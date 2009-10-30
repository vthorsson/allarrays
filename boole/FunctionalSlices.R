
ncbi.dir <- file.path(Sys.getenv("DATA_DIR"),"ncbi")
load(paste(Sys.getenv("DATA_DIR"),"ncbi/gene.symbol.RData",sep="/"))

util.dir <- file.path(Sys.getenv("AA"),"utils")
source(paste(util.dir,"utilitiesBoole.R",sep="/"))

## Load discretized matrix 
pdata.dir <- file.path(Sys.getenv("AA"),"processed_data/20091015")
load(paste(pdata.dir,"mm.RData",sep="/"))

###
### Functional groups
###
go.dir <- file.path(Sys.getenv("DATA_DIR"),"GeneOntology")
ca <- as.character(read.table(paste(go.dir,"CytokineActivity.tsv",sep="/"),as.is=TRUE)$V1)
cb <- as.character(read.table(paste(go.dir,"CytokineBinding.tsv",sep="/"),as.is=TRUE)$V1)
extcell <- as.character(read.table(paste(go.dir,"ExtracellularRegion.tsv",sep="/"),as.is=TRUE)$V1)
tfa <-  as.character(read.table(paste(go.dir,"TranscriptionFactorActivity.tsv",sep="/"),as.is=TRUE)$V1)
##m2a <- as.character(read.table("/Users/thorsson/data/MacPolarization/WoundHealingM2a.tsv",as.is=TRUE,sep='\t',header=TRUE)[,"Gene.ID"])

## Arachidonic acid pathway
library(KEGG.db)
kp <- as.list(KEGGPATHID2EXTID)
aacid <- kp[["mmu00590"]]

source("~/bin/R/MatrixPrintFormat.R")

cat("\nCytokine Activity\n")
mm.ca <- sliceByAvailableRows(ca,mm)
mm.ca <- diversify(mm.ca,col.on.min=0.05, col.on.max=0.95,row.on.min=0.05,row.on.max=0.95)
writeBooleMat( mm.ca, prefix = "CA", outdir=pdata.dir )

cat("\nCytokine Binding\n")
mm.cb <- sliceByAvailableRows(cb,mm)
mm.cb <- diversify(mm.cb,col.on.min=0.05, col.on.max=0.95,row.on.min=0.05,row.on.max=0.95)
writeBooleMat( mm.cb, prefix = "CB", outdir=pdata.dir )

cat("\nTranscription Factor Activity\n")
mm.tfa <- sliceByAvailableRows(tfa,mm)
mm.tfa <- diversify(mm.tfa,col.on.min=0.05, col.on.max=0.95,row.on.min=0.05,row.on.max=0.95)
writeBooleMat( mm.tfa, prefix = "TFA", outdir=pdata.dir )

cat("\nArachidonic Acid Pathway\n")
mm.aacid <- sliceByAvailableRows(aacid,mm)
mm.aacid <- diversify(mm.aacid) ## not a lot expressed at all
##mm.aacid <- diversify(mm.aacid,col.on.min=0.05, col.on.max=0.95,row.on.min=0.05,row.on.max=0.95)
writeBooleMat( mm.aacid, prefix = "AACID", outdir=pdata.dir )