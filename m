Return-Path: <linux-kernel+bounces-371076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F4E9A3601
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AE51C21956
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ABC18B48C;
	Fri, 18 Oct 2024 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjbvtdPq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AA18787A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234093; cv=none; b=UA4SG9qarq2N3tq5/xYu/YgB/2KCAwamdaKPAB7A33rWo0tmnB/YrMtKLkrX3vR2tu04gdhKTTmPMebLYhqbHZwxEi6AyY/ASetgjvHNfsyJPRGuR/pUFxo3/HAQ8IpMkEXqH4bru9KwyTbKi3k4sYsWYalyd2UsWJG2/ezKyNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234093; c=relaxed/simple;
	bh=Wk7y1NCaq5vrYXmMN8sm97ljo3rd4bPykdD24mhfkEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z/7hE8Ieitim1O6tB3IVEuZsI7LeCPGxnFh9awWb+R6PLDn50Xw/vCOOxtsBKn+flZIThcgtRqaW9F5g/tX9+6GevH7Q7GT1gjufuhhHxOukBxMsxB9aHJdm2vSc45wLEU11Bpwm+pgcADP2nVn0dKY/41h2/BCHF7fQtYKLENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjbvtdPq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729234091; x=1760770091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wk7y1NCaq5vrYXmMN8sm97ljo3rd4bPykdD24mhfkEY=;
  b=RjbvtdPq7O3FWXwT+BHoZil3d99OGkHbTWuB+c91vkgOWBSN2u7FYB11
   BjYPBvMqbBIOX3prs3+pMcc1AFwCZo4esdUE6zvcuaLej5bPRli8/uGWy
   a7ilQ+IgQnU+psif6Rv17KBo9Q0BAxY6NqR+bAt8hV5cBJesL+1Brt4DM
   JJ2X+msLmWtJo1+hlXjecabJF3L00m39E+PLHavUSDlcVvL14ocBAHlxE
   aUufQOQh6Hhff9GoIdSRUNWrUwB2s0t+x6Kzrfn1q6TSATWuDXEGM2SJ1
   Dv4zO1ZWI+jS4EMiFg5Cvj5822hf3r+sShr2j4CdX3CkRHheDzA07zZDQ
   A==;
X-CSE-ConnectionGUID: W2OYiiq8So+Ja3LkJzTzBA==
X-CSE-MsgGUID: /cxUvX2BRKyEwvWoP/TBJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28963350"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28963350"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:48:09 -0700
X-CSE-ConnectionGUID: 2dVk8TXESRGmpz6l97XWIg==
X-CSE-MsgGUID: 3TYx2nS6SfmEhvdE+9apQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="82744516"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa003.fm.intel.com with ESMTP; 17 Oct 2024 23:48:08 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	willy@infradead.org,
	bfoster@redhat.com,
	dchinner@redhat.com,
	chrisl@kernel.org,
	david@redhat.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 4/7] mm: swap: swap_read_folio() can add a folio to a folio_batch if it is in zswap.
Date: Thu, 17 Oct 2024 23:48:02 -0700
Message-Id: <20241018064805.336490-5-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241018064805.336490-1-kanchana.p.sridhar@intel.com>
References: <20241018064805.336490-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch modifies swap_read_folio() to check if the swap entry is present
in zswap, and if so, it will be added to a "zswap_batch" folio_batch, if
the caller (e.g. swapin_readahead()) has passed in a valid "zswap_batch".

If the swap entry is found in zswap, it will be added the next available
index in a sub-batch. This sub-batch is part of "struct zswap_decomp_batch"
which progressively constructs SWAP_CRYPTO_SUB_BATCH_SIZE arrays of zswap
entries/xarrays/pages/source-lengths ready for batch decompression in IAA.
The function that does this, zswap_add_load_batch(), will return true to
swap_read_folio(). If the entry is not found in zswap, it will return
false.

If the swap entry was not found in zswap, and if
zswap_load_batching_enabled() and a valid "non_zswap_batch" folio_batch is
passed to swap_read_folio(), the folio will be added to the
"non_zswap_batch" batch.

Finally, the code falls through to the usual/existing swap_read_folio()
flow.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/zswap.h | 35 +++++++++++++++++
 mm/memory.c           |  2 +-
 mm/page_io.c          | 26 ++++++++++++-
 mm/swap.h             | 31 ++++++++++++++-
 mm/swap_state.c       | 10 ++---
 mm/zswap.c            | 89 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 183 insertions(+), 10 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 294d13efbfb1..1d6de281f243 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -12,6 +12,8 @@ extern atomic_long_t zswap_stored_pages;
 #ifdef CONFIG_ZSWAP
 
 struct swap_in_memory_cache_cb;
+struct zswap_decomp_batch;
+struct zswap_entry;
 
 struct zswap_lruvec_state {
 	/*
@@ -120,6 +122,19 @@ static inline void zswap_store_batch(struct swap_in_memory_cache_cb *simc)
 }
 
 bool zswap_load_batching_enabled(void);
+void zswap_load_batch_init(struct zswap_decomp_batch *zd_batch);
+void zswap_load_batch_reinit(struct zswap_decomp_batch *zd_batch);
+bool __zswap_add_load_batch(struct zswap_decomp_batch *zd_batch,
+			    struct folio *folio);
+static inline bool zswap_add_load_batch(
+	struct zswap_decomp_batch *zd_batch,
+	struct folio *folio)
+{
+	if (zswap_load_batching_enabled())
+		return __zswap_add_load_batch(zd_batch, folio);
+
+	return false;
+}
 
 unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
@@ -138,6 +153,8 @@ struct zswap_lruvec_state {};
 struct zswap_store_sub_batch_page {};
 struct zswap_store_pipeline_state {};
 struct swap_in_memory_cache_cb;
+struct zswap_decomp_batch;
+struct zswap_entry;
 
 static inline bool zswap_store_batching_enabled(void)
 {
@@ -153,6 +170,24 @@ static inline bool zswap_load_batching_enabled(void)
 	return false;
 }
 
+static inline void zswap_load_batch_init(
+	struct zswap_decomp_batch *zd_batch)
+{
+}
+
+static inline void zswap_load_batch_reinit(
+	struct zswap_decomp_batch *zd_batch)
+{
+}
+
+static inline bool zswap_add_load_batch(
+	struct folio *folio,
+	struct zswap_entry *entry,
+	struct zswap_decomp_batch *zd_batch)
+{
+	return false;
+}
+
 static inline bool zswap_store(struct folio *folio)
 {
 	return false;
diff --git a/mm/memory.c b/mm/memory.c
index 0f614523b9f4..b5745b9ffdf7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4322,7 +4322,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 				/* To provide entry to swap_read_folio() */
 				folio->swap = entry;
-				swap_read_folio(folio, NULL);
+				swap_read_folio(folio, NULL, NULL, NULL);
 				folio->private = NULL;
 			}
 		} else {
diff --git a/mm/page_io.c b/mm/page_io.c
index 065db25309b8..9750302d193b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -744,11 +744,17 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 	submit_bio(bio);
 }
 
-void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
+/*
+ * Returns true if the folio was read, and false if the folio was added to
+ * the zswap_decomp_batch for batched decompression.
+ */
+bool swap_read_folio(struct folio *folio, struct swap_iocb **plug,
+		     struct zswap_decomp_batch *zswap_batch,
+		     struct folio_batch *non_zswap_batch)
 {
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
 	bool synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
-	bool workingset = folio_test_workingset(folio);
+	bool workingset;
 	unsigned long pflags;
 	bool in_thrashing;
 
@@ -756,11 +762,26 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
 
+	/*
+	 * If entry is found in zswap xarray, and zswap load batching
+	 * is enabled, this is a candidate for zswap batch decompression.
+	 */
+	if (zswap_batch && zswap_add_load_batch(zswap_batch, folio))
+		return false;
+
+	if (zswap_load_batching_enabled() && non_zswap_batch) {
+		BUG_ON(!folio_batch_space(non_zswap_batch));
+		folio_batch_add(non_zswap_batch, folio);
+		return false;
+	}
+
 	/*
 	 * Count submission time as memory stall and delay. When the device
 	 * is congested, or the submitting cgroup IO-throttled, submission
 	 * can be a significant part of overall IO time.
 	 */
+	workingset = folio_test_workingset(folio);
+
 	if (workingset) {
 		delayacct_thrashing_start(&in_thrashing);
 		psi_memstall_enter(&pflags);
@@ -792,6 +813,7 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 		psi_memstall_leave(&pflags);
 	}
 	delayacct_swapin_end();
+	return true;
 }
 
 void __swap_read_unplug(struct swap_iocb *sio)
diff --git a/mm/swap.h b/mm/swap.h
index 0bb386b5fdee..310f99007fe6 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -84,6 +84,27 @@ void swap_crypto_acomp_decompress_batch(
 	int nr_pages,
 	struct crypto_acomp_ctx *acomp_ctx);
 
+#if defined(CONFIG_ZSWAP_LOAD_BATCHING_ENABLED)
+#define MAX_NR_ZSWAP_LOAD_SUB_BATCHES DIV_ROUND_UP(PAGEVEC_SIZE, \
+					SWAP_CRYPTO_SUB_BATCH_SIZE)
+#else
+#define MAX_NR_ZSWAP_LOAD_SUB_BATCHES 1UL
+#endif /* CONFIG_ZSWAP_LOAD_BATCHING_ENABLED */
+
+/*
+ * Note: If PAGEVEC_SIZE or SWAP_CRYPTO_SUB_BATCH_SIZE
+ * exceeds 256, change the u8 to u16.
+ */
+struct zswap_decomp_batch {
+	struct folio_batch fbatch;
+	bool swapcache[PAGEVEC_SIZE];
+	struct xarray *trees[MAX_NR_ZSWAP_LOAD_SUB_BATCHES][SWAP_CRYPTO_SUB_BATCH_SIZE];
+	struct zswap_entry *entries[MAX_NR_ZSWAP_LOAD_SUB_BATCHES][SWAP_CRYPTO_SUB_BATCH_SIZE];
+	struct page *pages[MAX_NR_ZSWAP_LOAD_SUB_BATCHES][SWAP_CRYPTO_SUB_BATCH_SIZE];
+	unsigned int slens[MAX_NR_ZSWAP_LOAD_SUB_BATCHES][SWAP_CRYPTO_SUB_BATCH_SIZE];
+	u8 nr_decomp[MAX_NR_ZSWAP_LOAD_SUB_BATCHES];
+};
+
 /* linux/mm/vmscan.c, linux/mm/page_io.c, linux/mm/zswap.c */
 /* For batching of compressions in reclaim path. */
 struct swap_in_memory_cache_cb {
@@ -101,7 +122,9 @@ struct swap_in_memory_cache_cb {
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
-void swap_read_folio(struct folio *folio, struct swap_iocb **plug);
+bool swap_read_folio(struct folio *folio, struct swap_iocb **plug,
+		     struct zswap_decomp_batch *zswap_batch,
+		     struct folio_batch *non_zswap_batch);
 void __swap_read_unplug(struct swap_iocb *plug);
 static inline void swap_read_unplug(struct swap_iocb *plug)
 {
@@ -238,8 +261,12 @@ static inline void swap_crypto_acomp_decompress_batch(
 {
 }
 
-static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
+struct zswap_decomp_batch {};
+static inline bool swap_read_folio(struct folio *folio, struct swap_iocb **plug,
+				   struct zswap_decomp_batch *zswap_batch,
+				   struct folio_batch *non_zswap_batch)
 {
+	return false;
 }
 static inline void swap_write_unplug(struct swap_iocb *sio)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 0673593d363c..0aa938e4c34d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -570,7 +570,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	mpol_cond_put(mpol);
 
 	if (page_allocated)
-		swap_read_folio(folio, plug);
+		swap_read_folio(folio, plug, NULL, NULL);
 	return folio;
 }
 
@@ -687,7 +687,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		if (!folio)
 			continue;
 		if (page_allocated) {
-			swap_read_folio(folio, &splug);
+			swap_read_folio(folio, &splug, NULL, NULL);
 			if (offset != entry_offset) {
 				folio_set_readahead(folio);
 				count_vm_event(SWAP_RA);
@@ -703,7 +703,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
 	if (unlikely(page_allocated))
-		swap_read_folio(folio, NULL);
+		swap_read_folio(folio, NULL, NULL, NULL);
 	return folio;
 }
 
@@ -1057,7 +1057,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		if (!folio)
 			continue;
 		if (page_allocated) {
-			swap_read_folio(folio, &splug);
+			swap_read_folio(folio, &splug, NULL, NULL);
 			if (addr != vmf->address) {
 				folio_set_readahead(folio);
 				count_vm_event(SWAP_RA);
@@ -1075,7 +1075,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	folio = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
 					&page_allocated, false);
 	if (unlikely(page_allocated))
-		swap_read_folio(folio, NULL);
+		swap_read_folio(folio, NULL, NULL, NULL);
 	return folio;
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index fe7bc2a6672e..1d293f95d525 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -2312,6 +2312,95 @@ bool zswap_load(struct folio *folio)
 	return true;
 }
 
+/* Code for zswap load batch with batch decompress. */
+
+__always_inline void zswap_load_batch_init(struct zswap_decomp_batch *zd_batch)
+{
+	unsigned int sb;
+
+	folio_batch_init(&zd_batch->fbatch);
+
+	for (sb = 0; sb < MAX_NR_ZSWAP_LOAD_SUB_BATCHES; ++sb)
+		zd_batch->nr_decomp[sb] = 0;
+}
+
+__always_inline void zswap_load_batch_reinit(struct zswap_decomp_batch *zd_batch)
+{
+	unsigned int sb;
+
+	folio_batch_reinit(&zd_batch->fbatch);
+
+	for (sb = 0; sb < MAX_NR_ZSWAP_LOAD_SUB_BATCHES; ++sb)
+		zd_batch->nr_decomp[sb] = 0;
+}
+
+/*
+ * All folios in zd_batch are allocated into the swapcache
+ * in swapin_readahead(), before being added to the zd_batch
+ * for batch decompression.
+ */
+bool __zswap_add_load_batch(struct zswap_decomp_batch *zd_batch,
+			    struct folio *folio)
+{
+	swp_entry_t swp = folio->swap;
+	pgoff_t offset = swp_offset(swp);
+	bool swapcache = folio_test_swapcache(folio);
+	struct xarray *tree = swap_zswap_tree(swp);
+	struct zswap_entry *entry;
+	unsigned int batch_idx, sb;
+
+	VM_WARN_ON_ONCE(!folio_test_locked(folio));
+
+	if (zswap_never_enabled())
+		return false;
+
+	/*
+	 * Large folios should not be swapped in while zswap is being used, as
+	 * they are not properly handled. Zswap does not properly load large
+	 * folios, and a large folio may only be partially in zswap.
+	 *
+	 * Returning false here will cause the large folio to be added to
+	 * the "non_zswap_batch" in swap_read_folio(), which will eventually
+	 * call zswap_load() if the folio is not in the zeromap. Finally,
+	 * zswap_load() will return true without marking the folio uptodate
+	 * so that an IO error is emitted (e.g. do_swap_page() will sigbus).
+	 */
+	if (WARN_ON_ONCE(folio_test_large(folio)))
+		return false;
+
+	/*
+	 * When reading into the swapcache, invalidate our entry. The
+	 * swapcache can be the authoritative owner of the page and
+	 * its mappings, and the pressure that results from having two
+	 * in-memory copies outweighs any benefits of caching the
+	 * compression work.
+	 */
+	if (swapcache)
+		entry = xa_erase(tree, offset);
+	else
+		entry = xa_load(tree, offset);
+
+	if (!entry)
+		return false;
+
+	BUG_ON(!folio_batch_space(&zd_batch->fbatch));
+	folio_batch_add(&zd_batch->fbatch, folio);
+
+	batch_idx = folio_batch_count(&zd_batch->fbatch) - 1;
+	zd_batch->swapcache[batch_idx] = swapcache;
+	sb = batch_idx / SWAP_CRYPTO_SUB_BATCH_SIZE;
+
+	if (entry->length) {
+		zd_batch->trees[sb][zd_batch->nr_decomp[sb]] = tree;
+		zd_batch->entries[sb][zd_batch->nr_decomp[sb]] = entry;
+		zd_batch->pages[sb][zd_batch->nr_decomp[sb]] = &folio->page;
+		zd_batch->slens[sb][zd_batch->nr_decomp[sb]] = entry->length;
+		zd_batch->nr_decomp[sb]++;
+	}
+
+	return true;
+}
+
 void zswap_invalidate(swp_entry_t swp)
 {
 	pgoff_t offset = swp_offset(swp);
-- 
2.27.0


