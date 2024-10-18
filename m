Return-Path: <linux-kernel+bounces-371077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762619A3602
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9DCEB23AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F2018C924;
	Fri, 18 Oct 2024 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWxAGnrc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F614188713
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234094; cv=none; b=laCxVVxYP2ekjxw1KUz92uLXUPLIKWSzFAENGWHPKPQZKRHKUppR3PAU6T2pbhp+PiHTbZp6fe5vWmVUgPaJ9vfn6AElsirCibGYyihGOFmRtjjwNiQV5dwvCCRb2xRIaspFrJVuV2nrBUPWH2mD1KaLRq/u7unVKLmJCOAYr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234094; c=relaxed/simple;
	bh=EVMRjfiuNxd9amTtVRjIPzNA0R9fg2+OAdURffS6kSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PYLcvr5tkJzVCkRkkXOLx/LV0os4aMadepvLovOSiWacj+Bxy0ZjJZS2Bb8aEUUjiggUptFCRVON0wg1/O54qOX3NmRknm8mL3ZiRkoXFOjnvQy2LI0RLxS0Hlx3X6YgDk91FniWADE9VzWq2/yh8iPRflN8Q/rqGXzT1So6E1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWxAGnrc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729234092; x=1760770092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EVMRjfiuNxd9amTtVRjIPzNA0R9fg2+OAdURffS6kSM=;
  b=WWxAGnrc9MUQmyXhbClJyVFcdMLJc5WiHOT3+N9CRCs9mOZOHg/kEh0o
   nbSsseT3KMxdehaFO5FX4n2CF0ItcF3K4Cm8fMf5QBQMvOddtyaC66DOC
   n9NcvzQyMxACcI2SDisu8yfM/WtM0gyC/ZxHMZ3lE661QOPXxuLY2r0Qg
   VjGZw3Fmvw+dJTFEaHvzHVA5fprGIQi4Gt59/zUvFG/dckUfEuL/vqeOT
   e37gJbIciiQt6ZQspqnsrVMqN0QoB75srHnJiTwJZFvemfvfsvFI+i1tA
   uilP7Sd9dxyLnCf4uVcEbS224IyNZfahWbuiu3bh956oC3bpPSWxBvGmW
   A==;
X-CSE-ConnectionGUID: wG+1eC8cQMCqIjUx0O5SPA==
X-CSE-MsgGUID: 144r3/6fS6ePkpFxBnAB3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28963362"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28963362"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:48:09 -0700
X-CSE-ConnectionGUID: bK28v/+wSFW12salxHZpOw==
X-CSE-MsgGUID: 2L41HZYESMSBem9+UQfdBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="82744521"
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
Subject: [RFC PATCH v1 5/7] mm: swap, zswap: zswap folio_batch processing with IAA decompression batching.
Date: Thu, 17 Oct 2024 23:48:03 -0700
Message-Id: <20241018064805.336490-6-kanchana.p.sridhar@intel.com>
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

This patch provides the functionality that processes a "zswap_batch" in
which swap_read_folio() had previously stored swap entries found in zswap,
for batched loading.

The newly added zswap_finish_load_batch() API implements the main zswap
load batching functionality. This makes use of the sub-batches of
zswap_entry/xarray/page/source-length readily available from
zswap_add_load_batch(). These sub-batch arrays are processed one at a time,
until the entire zswap folio_batch has been loaded. The existing
zswap_load() functionality of deleting zswap_entries for folios found in
the swapcache, is preserved.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/zswap.h |  22 ++++++
 mm/page_io.c          |  35 +++++++++
 mm/swap.h             |  17 +++++
 mm/zswap.c            | 171 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 1d6de281f243..a0792c2b300a 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -110,6 +110,15 @@ struct zswap_store_pipeline_state {
 	u8 nr_comp_pages;
 };
 
+/* Note: If SWAP_CRYPTO_SUB_BATCH_SIZE exceeds 256, change the u8 to u16. */
+struct zswap_load_sub_batch_state {
+	struct xarray **trees;
+	struct zswap_entry **entries;
+	struct page **pages;
+	unsigned int *slens;
+	u8 nr_decomp;
+};
+
 bool zswap_store_batching_enabled(void);
 void __zswap_store_batch(struct swap_in_memory_cache_cb *simc);
 void __zswap_store_batch_single(struct swap_in_memory_cache_cb *simc);
@@ -136,6 +145,14 @@ static inline bool zswap_add_load_batch(
 	return false;
 }
 
+void __zswap_finish_load_batch(struct zswap_decomp_batch *zd_batch);
+static inline void zswap_finish_load_batch(
+	struct zswap_decomp_batch *zd_batch)
+{
+	if (zswap_load_batching_enabled())
+		__zswap_finish_load_batch(zd_batch);
+}
+
 unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
 bool zswap_load(struct folio *folio);
@@ -188,6 +205,11 @@ static inline bool zswap_add_load_batch(
 	return false;
 }
 
+static inline void zswap_finish_load_batch(
+	struct zswap_decomp_batch *zd_batch)
+{
+}
+
 static inline bool zswap_store(struct folio *folio)
 {
 	return false;
diff --git a/mm/page_io.c b/mm/page_io.c
index 9750302d193b..aa83221318ef 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -816,6 +816,41 @@ bool swap_read_folio(struct folio *folio, struct swap_iocb **plug,
 	return true;
 }
 
+static void __swap_post_process_zswap_load_batch(
+	struct zswap_decomp_batch *zswap_batch)
+{
+	u8 i;
+
+	for (i = 0; i < folio_batch_count(&zswap_batch->fbatch); ++i) {
+		struct folio *folio = zswap_batch->fbatch.folios[i];
+		folio_unlock(folio);
+	}
+}
+
+/*
+ * The swapin_readahead batching interface makes sure that the
+ * input zswap_batch consists of folios belonging to the same swap
+ * device type.
+ */
+void __swap_read_zswap_batch_unplug(struct zswap_decomp_batch *zswap_batch,
+				    struct swap_iocb **splug)
+{
+	unsigned long pflags;
+
+	if (!folio_batch_count(&zswap_batch->fbatch))
+		return;
+
+	psi_memstall_enter(&pflags);
+	delayacct_swapin_start();
+
+	/* Load the zswap batch. */
+	zswap_finish_load_batch(zswap_batch);
+	__swap_post_process_zswap_load_batch(zswap_batch);
+
+	psi_memstall_leave(&pflags);
+	delayacct_swapin_end();
+}
+
 void __swap_read_unplug(struct swap_iocb *sio)
 {
 	struct iov_iter from;
diff --git a/mm/swap.h b/mm/swap.h
index 310f99007fe6..2b82c8ed765c 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -125,6 +125,16 @@ struct swap_iocb;
 bool swap_read_folio(struct folio *folio, struct swap_iocb **plug,
 		     struct zswap_decomp_batch *zswap_batch,
 		     struct folio_batch *non_zswap_batch);
+void __swap_read_zswap_batch_unplug(
+	struct zswap_decomp_batch *zswap_batch,
+	struct swap_iocb **splug);
+static inline void swap_read_zswap_batch_unplug(
+	struct zswap_decomp_batch *zswap_batch,
+	struct swap_iocb **splug)
+{
+	if (likely(zswap_batch))
+		__swap_read_zswap_batch_unplug(zswap_batch, splug);
+}
 void __swap_read_unplug(struct swap_iocb *plug);
 static inline void swap_read_unplug(struct swap_iocb *plug)
 {
@@ -268,6 +278,13 @@ static inline bool swap_read_folio(struct folio *folio, struct swap_iocb **plug,
 {
 	return false;
 }
+
+static inline void swap_read_zswap_batch_unplug(
+	struct zswap_decomp_batch *zswap_batch,
+	struct swap_iocb **splug)
+{
+}
+
 static inline void swap_write_unplug(struct swap_iocb *sio)
 {
 }
diff --git a/mm/zswap.c b/mm/zswap.c
index 1d293f95d525..39bf7d8810e9 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -35,6 +35,7 @@
 #include <linux/pagemap.h>
 #include <linux/workqueue.h>
 #include <linux/list_lru.h>
+#include <linux/delayacct.h>
 
 #include "swap.h"
 #include "internal.h"
@@ -2401,6 +2402,176 @@ bool __zswap_add_load_batch(struct zswap_decomp_batch *zd_batch,
 	return true;
 }
 
+static __always_inline void zswap_load_sub_batch_init(
+	struct zswap_decomp_batch *zd_batch,
+	unsigned int sb,
+	struct zswap_load_sub_batch_state *zls)
+{
+	zls->trees = zd_batch->trees[sb];
+	zls->entries = zd_batch->entries[sb];
+	zls->pages = zd_batch->pages[sb];
+	zls->slens = zd_batch->slens[sb];
+	zls->nr_decomp = zd_batch->nr_decomp[sb];
+}
+
+static void zswap_load_map_sources(
+	struct zswap_load_sub_batch_state *zls,
+	u8 *srcs[])
+{
+	u8 i;
+
+	for (i = 0; i < zls->nr_decomp; ++i) {
+		struct zswap_entry *entry = zls->entries[i];
+		struct zpool *zpool = entry->pool->zpool;
+		u8 *buf = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
+		memcpy(srcs[i], buf, entry->length);
+		zpool_unmap_handle(zpool, entry->handle);
+	}
+}
+
+static void zswap_decompress_batch(
+	struct zswap_load_sub_batch_state *zls,
+	u8 *srcs[],
+	int decomp_errors[])
+{
+	struct crypto_acomp_ctx *acomp_ctx;
+
+	acomp_ctx = raw_cpu_ptr(zls->entries[0]->pool->acomp_ctx);
+
+	swap_crypto_acomp_decompress_batch(
+		srcs,
+		zls->pages,
+		zls->slens,
+		decomp_errors,
+		zls->nr_decomp,
+		acomp_ctx);
+}
+
+static void zswap_load_batch_updates(
+	struct zswap_decomp_batch *zd_batch,
+	unsigned int sb,
+	struct zswap_load_sub_batch_state *zls,
+	int decomp_errors[])
+{
+	unsigned int j;
+	u8 i;
+
+	for (i = 0; i < zls->nr_decomp; ++i) {
+		j = (sb * SWAP_CRYPTO_SUB_BATCH_SIZE) + i;
+		struct folio *folio = zd_batch->fbatch.folios[j];
+		struct zswap_entry *entry = zls->entries[i];
+
+		BUG_ON(decomp_errors[i]);
+		count_vm_event(ZSWPIN);
+		if (entry->objcg)
+			count_objcg_events(entry->objcg, ZSWPIN, 1);
+
+		if (zd_batch->swapcache[j]) {
+			zswap_entry_free(entry);
+			folio_mark_dirty(folio);
+		}
+
+		folio_mark_uptodate(folio);
+	}
+}
+
+static void zswap_load_decomp_batch(
+	struct zswap_decomp_batch *zd_batch,
+	unsigned int sb,
+	struct zswap_load_sub_batch_state *zls)
+{
+	int decomp_errors[SWAP_CRYPTO_SUB_BATCH_SIZE];
+	struct crypto_acomp_ctx *acomp_ctx;
+
+	acomp_ctx = raw_cpu_ptr(zls->entries[0]->pool->acomp_ctx);
+	mutex_lock(&acomp_ctx->mutex);
+
+	zswap_load_map_sources(zls, acomp_ctx->buffer);
+
+	zswap_decompress_batch(zls, acomp_ctx->buffer, decomp_errors);
+
+	mutex_unlock(&acomp_ctx->mutex);
+
+	zswap_load_batch_updates(zd_batch, sb, zls, decomp_errors);
+}
+
+static void zswap_load_start_accounting(
+	struct zswap_decomp_batch *zd_batch,
+	unsigned int sb,
+	struct zswap_load_sub_batch_state *zls,
+	bool workingset[],
+	bool in_thrashing[])
+{
+	unsigned int j;
+	u8 i;
+
+	for (i = 0; i < zls->nr_decomp; ++i) {
+		j = (sb * SWAP_CRYPTO_SUB_BATCH_SIZE) + i;
+		struct folio *folio = zd_batch->fbatch.folios[j];
+		workingset[i] = folio_test_workingset(folio);
+		if (workingset[i])
+			delayacct_thrashing_start(&in_thrashing[i]);
+	}
+}
+
+static void zswap_load_end_accounting(
+	struct zswap_decomp_batch *zd_batch,
+	struct zswap_load_sub_batch_state *zls,
+	bool workingset[],
+	bool in_thrashing[])
+{
+	u8 i;
+
+	for (i = 0; i < zls->nr_decomp; ++i)
+		if (workingset[i])
+			delayacct_thrashing_end(&in_thrashing[i]);
+}
+
+/*
+ * All entries in a zd_batch belong to the same swap device.
+ */
+void __zswap_finish_load_batch(struct zswap_decomp_batch *zd_batch)
+{
+	struct zswap_load_sub_batch_state zls;
+	unsigned int nr_folios = folio_batch_count(&zd_batch->fbatch);
+	unsigned int nr_sb = DIV_ROUND_UP(nr_folios, SWAP_CRYPTO_SUB_BATCH_SIZE);
+	unsigned int sb;
+
+	/*
+	 * Process the zd_batch in sub-batches of
+	 * SWAP_CRYPTO_SUB_BATCH_SIZE.
+	 */
+	for (sb = 0; sb < nr_sb; ++sb) {
+		bool workingset[SWAP_CRYPTO_SUB_BATCH_SIZE];
+		bool in_thrashing[SWAP_CRYPTO_SUB_BATCH_SIZE];
+
+		zswap_load_sub_batch_init(zd_batch, sb, &zls);
+
+		zswap_load_start_accounting(zd_batch, sb, &zls,
+					    workingset, in_thrashing);
+
+		/* Decompress the batch. */
+		if (zls.nr_decomp)
+			zswap_load_decomp_batch(zd_batch, sb, &zls);
+
+		/*
+		 * Should we free zswap_entries, as in zswap_load():
+		 * With the new swapin_readahead batching interface,
+		 * all prefetch entries are read into the swapcache.
+		 * Freeing the zswap entries here causes segfaults,
+		 * most probably because a page-fault occured while
+		 * the buffer was being decompressed.
+		 * Allowing the regular folio_free_swap() sequence
+		 * in do_swap_page() appears to keep things stable
+		 * without duplicated zswap-swapcache memory, as far
+		 * as I can tell from my testing.
+		 */
+
+		zswap_load_end_accounting(zd_batch, &zls,
+					  workingset, in_thrashing);
+	}
+}
+
 void zswap_invalidate(swp_entry_t swp)
 {
 	pgoff_t offset = swp_offset(swp);
-- 
2.27.0


