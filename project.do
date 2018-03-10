clear 
set more off


*import data
 import excel "F:\UNCC\DSBA6100\MergedDataSetIVSTATA.xlsx", sheet("QUERY_FOR_MERGED_WITH_DEPENDENT") firstrow

 *linear regression
 regress TotalPaid GenderM IsFatality ClaimantAge BodyPartRegion_Head BodyPartRegion_LowerExtremities BodyPartRegion_MultipleParts BodyPartRegion_Neck BodyPartRegion_NonStdCode BodyPartRegion_Trunk  ProcessingTime i.Claims_Month i.Claims_DayOfWeek 

 *logit
 logit Totalpaidbinary IsFatality ClaimantAge GenderF BodyPartRegion_Head BodyPartRegion_LowerExtremities BodyPartRegion_MultipleParts BodyPartRegion_Neck BodyPartRegion_NonStdCode BodyPartRegion_Trunk i.Claims_Month i.Claims_DayOfWeek 
 
 *linear regression-processing time
regress ProcessingTime GenderM IsFatality ClaimantAge BodyPartRegion_Head BodyPartRegion_LowerExtremities BodyPartRegion_MultipleParts BodyPartRegion_Neck BodyPartRegion_NonStdCode BodyPartRegion_Trunk  i.Claims_Month i.Claims_DayOfWeek 

*testing for multicollinearity 
 corr IsFatality BodyPartRegion_Head
 corr IsFatality BodyPartRegion_MultipleParts
 corr IsFatality ClaimantAge_at_DOI 
 corr IsFatality GenderM
 corre ProcessingTime TotalPaid Totalpaidbinary
 
 *create month dummies
 gen January = 0
replace January = 1 if Claims_Month == 1
 gen February = 0
replace February = 1 if Claims_Month == 2
 gen March = 0
replace March = 1 if Claims_Month == 3
 gen April = 0
replace April = 1 if Claims_Month == 4
 gen May = 0
replace May = 1 if Claims_Month == 5
 gen June = 0
replace June = 1 if Claims_Month == 6
 gen July = 0
replace July = 1 if Claims_Month == 7
 gen August = 0
replace August = 1 if Claims_Month == 8
 gen September = 0
replace September = 1 if Claims_Month == 9
 gen October = 0
replace October = 1 if Claims_Month == 10
 gen November = 0
replace November = 1 if Claims_Month == 11
 gen December = 0
replace December = 1 if Claims_Month == 12


*create day of week controls
 gen Sunday = 0
replace Sunday = 1 if Claims_DayOfWeek == 1
gen Monday = 0
replace Monday = 1 if Claims_DayOfWeek == 2
gen Tuesdayday = 0
replace Tuesday = 1 if Claims_DayOfWeek == 3
gen Wednesday = 0
replace Wednesday = 1 if Claims_DayOfWeek == 4
gen Thursday = 0
replace Thursday = 1 if Claims_DayOfWeek == 5
gen Friday = 0
replace Friday = 1 if Claims_DayOfWeek == 6
gen Saturday = 0
replace Saturday = 1 if Claims_DayOfWeek == 7


regress TotalPaid GenderM IsFatality ClaimantAge BodyPartRegion_Head BodyPartRegion_LowerExtremities BodyPartRegion_MultipleParts BodyPartRegion_Neck BodyPartRegion_NonStdCode BodyPartRegion_Trunk  ProcessingTime January February March April May June July August September October November Sunday Monday Tuesday Wednesday Thursday Friday

 logit Totalpaidbinary IsFatality ClaimantAge GenderF BodyPartRegion_Head BodyPartRegion_LowerExtremities BodyPartRegion_MultipleParts BodyPartRegion_Neck BodyPartRegion_NonStdCode BodyPartRegion_Trunk January February March April May June July August September October November Sunday Monday Tuesday Wednesday Thursday Friday

 
