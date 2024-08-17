Return-Path: <linux-kernel+bounces-290541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D9495557D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 07:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E39A9B22FB5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 05:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8E12CDAE;
	Sat, 17 Aug 2024 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ds/jPYC5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64880BFC
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723871372; cv=none; b=NUnd/COaDUAE246Y2B7r7HyUFvggFkoVFr+AX7+4v2ocGgmPHy7l4jxFQpBis7UrI0LU4UUMzJ36WTcAaePoHKb1EgHcOJuPJMbs0qku5wIy8bn5KYfJp9F2Jx7jTsFz23AOp2C4NlX5yE6LkNqs53TxvqH7xLefbkl1EcjCp/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723871372; c=relaxed/simple;
	bh=Hs5osIBnEQbfhkvnt0UdOWrL7Zx29/pIwKoBT11shSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=js6xgfLW0MgtcaWN8EYfj4r9RV9XGfEHSYzScFWlgCedicdFBakbUL/uf2nwXvVpipLbuSQ8aDyGqVkqAE/CYLC0vUIFwfmq3IiTJCUPjOxTa7oYtnWfGp/qGbZCScD6FgtT7RKmM71sq6sYDGTvxlURuA2Y0S2llsZg3GEQx1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ds/jPYC5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723871370; x=1755407370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hs5osIBnEQbfhkvnt0UdOWrL7Zx29/pIwKoBT11shSE=;
  b=Ds/jPYC5IlLIJRdKX6gMwxhX0U5KuVXgwBYwPUMuP0i769oId4sOl3Fb
   LsiX71JWV/IbIbV/FGD7P+sMGA1qvzVJoa7NNB+JCJZ1F9Qwhi6qhezL5
   CPMn+PE771752UOihOuYTMyAq07V7ZG9gDpTW0l9cpBCXAVnm8gRjKrLV
   vX6e+FtmnUiqzAt3T+x6PvI5CSfko0sFo2NrDwQkZMxJFFS4nIo6Awj/k
   HeM6IZ6kUXriud8SB/MnrGzbhBRqCQW+ZQ2rZyp4F7SZ0JLkClIKtljtZ
   RGk5m4slKHeGj/jDrqNaYKaIz9ZIJSCql7LPAsYD9POVfJrpM/J2NV46l
   Q==;
X-CSE-ConnectionGUID: nxAipbHkQmS4S0AGG0sm0Q==
X-CSE-MsgGUID: zdAzslCOSHuYQHsB8wBjnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25929471"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="25929471"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 22:09:21 -0700
X-CSE-ConnectionGUID: 45aK0Pq1RiiWmgfsLRGP+A==
X-CSE-MsgGUID: BXaEkahsTVqlUNwVVqM3Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="60141495"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa006.jf.intel.com with ESMTP; 16 Aug 2024 22:09:21 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v3 2/4] mm: zswap: zswap_store() extended to handle mTHP folios.
Date: Fri, 16 Aug 2024 22:09:19 -0700
Message-Id: <20240817050921.18462-3-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240817050921.18462-1-kanchana.p.sridhar@intel.com>
References: <20240817050921.18462-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zswap_store() will now process and store mTHP and PMD-size THP folios.

This change reuses and adapts the functionality in Ryan Roberts' RFC
patch [1]:

  "[RFC,v1] mm: zswap: Store large folios without splitting"

  [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u

This patch provides a sequential implementation of storing an mTHP in
zswap_store() by iterating through each page in the folio to compress
and store it in the zswap zpool.

Towards this goal, zswap_compress() is modified to take a page instead
of a folio as input.

Each page's swap offset is stored as a separate zswap entry.

If an error is encountered during the store of any page in the mTHP,
all previous pages/entries stored will be invalidated. Thus, an mTHP
is either entirely stored in ZSWAP, or entirely not stored in ZSWAP.

This forms the basis for building batching of pages during zswap store
of large folios, by compressing batches of up to say, 8 pages in an
mTHP in parallel in hardware, with the Intel In-Memory Analytics
Accelerator (Intel IAA).

Also, addressed some of the RFC comments from the discussion in [1].

Co-developed-by: Ryan Roberts
Signed-off-by:
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 234 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 172 insertions(+), 62 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6c5c656ec282..7a712be2f3cb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -884,7 +884,7 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
-static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
+static bool zswap_compress(struct page *page, struct zswap_entry *entry)
 {
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct scatterlist input, output;
@@ -902,7 +902,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 
 	dst = acomp_ctx->buffer;
 	sg_init_table(&input, 1);
-	sg_set_folio(&input, folio, PAGE_SIZE, 0);
+	sg_set_page(&input, page, PAGE_SIZE, 0);
 
 	/*
 	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
@@ -1394,36 +1394,83 @@ static void zswap_fill_folio(struct folio *folio, unsigned long value)
 /*********************************
 * main API
 **********************************/
-bool zswap_store(struct folio *folio)
+
+/*
+ * Returns true if the entry was successfully
+ * stored in the xarray, and false otherwise.
+ */
+static bool zswap_store_entry(struct xarray *tree,
+			      struct zswap_entry *entry)
 {
-	swp_entry_t swp = folio->swap;
-	pgoff_t offset = swp_offset(swp);
-	struct xarray *tree = swap_zswap_tree(swp);
-	struct zswap_entry *entry, *old;
-	struct obj_cgroup *objcg = NULL;
-	struct mem_cgroup *memcg = NULL;
-	unsigned long value;
+	struct zswap_entry *old;
+	pgoff_t offset = swp_offset(entry->swpentry);
 
-	VM_WARN_ON_ONCE(!folio_test_locked(folio));
-	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
+	old = xa_store(tree, offset, entry, GFP_KERNEL);
 
-	/* Large folios aren't supported */
-	if (folio_test_large(folio))
+	if (xa_is_err(old)) {
+		int err = xa_err(old);
+
+		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
+		zswap_reject_alloc_fail++;
 		return false;
+	}
 
-	if (!zswap_enabled)
-		goto check_old;
+	/*
+	 * We may have had an existing entry that became stale when
+	 * the folio was redirtied and now the new version is being
+	 * swapped out. Get rid of the old.
+	 */
+	if (old)
+		zswap_entry_free(old);
 
-	/* Check cgroup limits */
-	objcg = get_obj_cgroup_from_folio(folio);
-	if (objcg && !obj_cgroup_may_zswap(objcg)) {
-		memcg = get_mem_cgroup_from_objcg(objcg);
-		if (shrink_memcg(memcg)) {
-			mem_cgroup_put(memcg);
-			goto reject;
-		}
-		mem_cgroup_put(memcg);
+	return true;
+}
+
+/*
+ * If the zswap store fails or zswap is disabled, we must invalidate the
+ * possibly stale entries which were previously stored at the offsets
+ * corresponding to each page of the folio. Otherwise, writeback could
+ * overwrite the new data in the swapfile.
+ *
+ * This is called after the store of the i-th offset in a large folio has
+ * failed. All zswap entries in the folio must be deleted. This helps make
+ * sure that a swapped-out mTHP is either entirely stored in zswap, or
+ * entirely not stored in zswap.
+ *
+ * This is also called if zswap_store() is invoked, but zswap is not enabled.
+ * All offsets for the folio are deleted from zswap in this case.
+ */
+static void zswap_delete_stored_offsets(struct xarray *tree,
+					pgoff_t offset,
+					long nr_pages)
+{
+	struct zswap_entry *entry;
+	long i;
+
+	for (i = 0; i < nr_pages; ++i) {
+		entry = xa_erase(tree, offset + i);
+		if (entry)
+			zswap_entry_free(entry);
 	}
+}
+
+/*
+ * Stores the page at specified "index" in a folio.
+ */
+static bool zswap_store_page(struct folio *folio, long index,
+			     struct obj_cgroup *objcg,
+			     struct zswap_pool *pool)
+{
+	swp_entry_t swp = folio->swap;
+	int type = swp_type(swp);
+	pgoff_t offset = swp_offset(swp) + index;
+	struct page *page = folio_page(folio, index);
+	struct xarray *tree = swap_zswap_tree(swp);
+	struct zswap_entry *entry;
+	unsigned long value;
+
+	if (objcg)
+		obj_cgroup_get(objcg);
 
 	if (zswap_check_limits())
 		goto reject;
@@ -1435,7 +1482,7 @@ bool zswap_store(struct folio *folio)
 		goto reject;
 	}
 
-	if (zswap_is_folio_same_filled(folio, 0, &value)) {
+	if (zswap_is_folio_same_filled(folio, index, &value)) {
 		entry->length = 0;
 		entry->value = value;
 		atomic_inc(&zswap_same_filled_pages);
@@ -1443,42 +1490,20 @@ bool zswap_store(struct folio *folio)
 	}
 
 	/* if entry is successfully added, it keeps the reference */
-	entry->pool = zswap_pool_current_get();
-	if (!entry->pool)
+	if (!zswap_pool_get(pool))
 		goto freepage;
 
-	if (objcg) {
-		memcg = get_mem_cgroup_from_objcg(objcg);
-		if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERNEL)) {
-			mem_cgroup_put(memcg);
-			goto put_pool;
-		}
-		mem_cgroup_put(memcg);
-	}
+	entry->pool = pool;
 
-	if (!zswap_compress(folio, entry))
+	if (!zswap_compress(page, entry))
 		goto put_pool;
 
 store_entry:
-	entry->swpentry = swp;
+	entry->swpentry = swp_entry(type, offset);
 	entry->objcg = objcg;
 
-	old = xa_store(tree, offset, entry, GFP_KERNEL);
-	if (xa_is_err(old)) {
-		int err = xa_err(old);
-
-		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
-		zswap_reject_alloc_fail++;
+	if (!zswap_store_entry(tree, entry))
 		goto store_failed;
-	}
-
-	/*
-	 * We may have had an existing entry that became stale when
-	 * the folio was redirtied and now the new version is being
-	 * swapped out. Get rid of the old.
-	 */
-	if (old)
-		zswap_entry_free(old);
 
 	if (objcg) {
 		obj_cgroup_charge_zswap(objcg, entry->length);
@@ -1512,7 +1537,7 @@ bool zswap_store(struct folio *folio)
 	else {
 		zpool_free(entry->pool->zpool, entry->handle);
 put_pool:
-		zswap_pool_put(entry->pool);
+		zswap_pool_put(pool);
 	}
 freepage:
 	zswap_entry_cache_free(entry);
@@ -1520,16 +1545,101 @@ bool zswap_store(struct folio *folio)
 	obj_cgroup_put(objcg);
 	if (zswap_pool_reached_full)
 		queue_work(shrink_wq, &zswap_shrink_work);
-check_old:
+
+	return false;
+}
+
+/*
+ * Modified to store mTHP folios. Each page in the mTHP will be compressed
+ * and stored sequentially.
+ */
+bool zswap_store(struct folio *folio)
+{
+	long nr_pages = folio_nr_pages(folio);
+	swp_entry_t swp = folio->swap;
+	pgoff_t offset = swp_offset(swp);
+	struct xarray *tree = swap_zswap_tree(swp);
+	struct obj_cgroup *objcg = NULL;
+	struct mem_cgroup *memcg = NULL;
+	struct zswap_pool *pool;
+	bool ret = false;
+	long index;
+
+	VM_WARN_ON_ONCE(!folio_test_locked(folio));
+	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
+
+	if (!zswap_enabled)
+		goto reject;
+
 	/*
-	 * If the zswap store fails or zswap is disabled, we must invalidate the
-	 * possibly stale entry which was previously stored at this offset.
-	 * Otherwise, writeback could overwrite the new data in the swapfile.
+	 * Check cgroup limits:
+	 *
+	 * The cgroup zswap limit check is done once at the beginning of an
+	 * mTHP store, and not within zswap_store_page() for each page
+	 * in the mTHP. We do however check the zswap pool limits at the
+	 * start of zswap_store_page(). What this means is, the cgroup
+	 * could go over the limits by at most (HPAGE_PMD_NR - 1) pages.
+	 * However, the per-store-page zswap pool limits check should
+	 * hopefully trigger the cgroup aware and zswap LRU aware global
+	 * reclaim implemented in the shrinker. If this assumption holds,
+	 * the cgroup exceeding the zswap limits could potentially be
+	 * resolved before the next zswap_store, and if it is not, the next
+	 * zswap_store would fail the cgroup zswap limit check at the start.
 	 */
-	entry = xa_erase(tree, offset);
-	if (entry)
-		zswap_entry_free(entry);
-	return false;
+	objcg = get_obj_cgroup_from_folio(folio);
+	if (objcg && !obj_cgroup_may_zswap(objcg)) {
+		memcg = get_mem_cgroup_from_objcg(objcg);
+		if (shrink_memcg(memcg)) {
+			mem_cgroup_put(memcg);
+			goto put_objcg;
+		}
+		mem_cgroup_put(memcg);
+	}
+
+	if (zswap_check_limits())
+		goto put_objcg;
+
+	pool = zswap_pool_current_get();
+	if (!pool)
+		goto put_objcg;
+
+	if (objcg) {
+		memcg = get_mem_cgroup_from_objcg(objcg);
+		if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERNEL)) {
+			mem_cgroup_put(memcg);
+			goto put_pool;
+		}
+		mem_cgroup_put(memcg);
+	}
+
+	/*
+	 * Store each page of the folio as a separate entry. If we fail to store
+	 * a page, unwind by removing all the previous pages we stored.
+	 */
+	for (index = 0; index < nr_pages; ++index) {
+		if (!zswap_store_page(folio, index, objcg, pool))
+			goto put_pool;
+	}
+
+	ret = true;
+
+put_pool:
+	zswap_pool_put(pool);
+put_objcg:
+	obj_cgroup_put(objcg);
+	if (zswap_pool_reached_full)
+		queue_work(shrink_wq, &zswap_shrink_work);
+reject:
+	/*
+	 * If the zswap store fails or zswap is disabled, we must invalidate
+	 * the possibly stale entries which were previously stored at the
+	 * offsets corresponding to each page of the folio. Otherwise,
+	 * writeback could overwrite the new data in the swapfile.
+	 */
+	if (!ret)
+		zswap_delete_stored_offsets(tree, offset, nr_pages);
+
+	return ret;
 }
 
 bool zswap_load(struct folio *folio)
-- 
2.27.0


