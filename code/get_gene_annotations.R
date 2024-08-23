# To install this package, use BiocManager::install("org.Dm.eg.db")

library(org.Dm.eg.db)
library(tidyverse)

gene_annotations <-
  tbl(dbconn(org.Dm.eg.db), "genes") %>%
  left_join(tbl(dbconn(org.Dm.eg.db), "flybase"), by = "_id") %>%
  left_join(tbl(dbconn(org.Dm.eg.db), "gene_info"), by = "_id") %>%
  left_join(tbl(dbconn(org.Dm.eg.db), "chromosomes"), by = "_id") %>%
  dplyr::select(flybase_id, gene_name, symbol, gene_id, chromosome) %>%
  dplyr::rename(FBID = flybase_id, gene_symbol = symbol, entrez_id = gene_id) %>%
  collect(n = Inf)

gene_annotations %>% write_csv("data/gene_anntotations.csv")

