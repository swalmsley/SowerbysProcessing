# Script to produce summary statistics for annual Sowerby's beaked whale matching

# S. Walmsley


#Required packages

library(data.table)

library(evaluate)

library(ggplot2)

library(tidyr)

library(dplyr)


#For reproducibility

set.seed(1234)


# Load in photo-ID dataframe (exported from lightroom) --------------------

dt <- data.table(read.csv('input/Sowerbys2021_AnnualMatching.csv'))

dt[,Date:=as.Date(Date.Original),] 




# Extract left and right

dt=dt %>% mutate(side = ifelse(grepl("left", Keyword.export), "left", NA))

dt=dt %>% mutate(side = ifelse(grepl("right", Keyword.export), "right", side))

# Extract annual best

dt=dt %>% mutate(annualBest = ifelse(grepl("annual best", Keyword.export), 1, 0))



# Commonsense checks

dt=dt %>% mutate(edge = ifelse(grepl("D1", Keyword.export), 1, "N")) # expected number of left and right-sided photos

dt[,.N,by=c("annualBest", "side")] # expected number of left and right sided identifications

dt[,length(unique(Title)),by="side"] # expected number of title names for left and right sided identifications



# Number of days sighted

dt[,numDays:=length(unique(Date)),by=Title]

dt[numDays>1,unique(Title),] 

dt[Title=="22L",unique(Date),] # July 21st, July 22nd

dt[Title=="7L",unique(Date),] # July 21st, July 22nd

dt[Title=="9L",unique(Date),] # July 21st, July 22nd

dt[Title=="12L",unique(Date),] # July 22nd, July 25th

dt[Title=="16R",unique(Date),] # August 16, August 22






