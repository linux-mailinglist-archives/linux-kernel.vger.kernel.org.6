Return-Path: <linux-kernel+bounces-304685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F36596238D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6B91F25A22
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42B16B752;
	Wed, 28 Aug 2024 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3aA7cEz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB91667C7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837721; cv=none; b=MBiZyFwWHHGbxPBWGz7b58NPAKOZEE/xEbkf1hQW9iD/0OMO2M1kmxyHKhiQ2ZQWLoas2W5xcyEVFyyGuvWvvcaNm43ZrqrbbOYodBEecsOV9H4x8cbo65q02ZvlNzExKlgIdB0SUwJzp8XDwzXFtwZuZZf7SIfEBH9ryROFlYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837721; c=relaxed/simple;
	bh=K3yroI8ejev2DdrGq2bi16BmrcYH0+k9ICg7i86HaWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBeovNHD9acFXAW4SI8syZD3XuBJ3ythb1AlV19eagT0JSn7432AZMWA/Z2hgP0yCaEV0T4cz9mu8GjwUUWNVxe6cAPj/mqJBbz+PoF4R63Q6xBUmT3Y5o3yjGtJDqu0Q2nVWMEEp4ykVWY4mhUac/1jqkOgJC+SLgNrZPeYeag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3aA7cEz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724837718; x=1756373718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K3yroI8ejev2DdrGq2bi16BmrcYH0+k9ICg7i86HaWs=;
  b=K3aA7cEzAJVX5ejy3+Kq5GeEw/CrU8QkLD3SS8K6QiQ+fvUdQcEfpDwC
   MFEuI2wMEIHOtytJBuRJr8u5UfeybE3F4d2m8lF13W5rYq/MKSrLIDqcJ
   kGLlo7o25s55OEO28XMaGgtqxWcGZZeS9f/mPUIcUXDkFNqEN2YDevsK2
   NEyv4AnGScCumQTmX+EnTbJoiF2zdOa5RVgLUIBENCwfx0PBuiTuRJXYy
   ZVhBcC+0qL+Ryy6U+LpGsrf28cyy2VgiPiI2XTFr9RD/JJS7vh0UvZxnn
   ca0UzIOmILdYWZi0OVLAw1gvvljXcM8ruPlx8Usl7sbSqB1sJ15n1mGAg
   Q==;
X-CSE-ConnectionGUID: rG3Hz4tHT/iSFjFE97CCfQ==
X-CSE-MsgGUID: YP+bMNsqQTCksNMi86JW6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34763876"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="34763876"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 02:35:17 -0700
X-CSE-ConnectionGUID: Bqk7Q+llS7+LZM2jckH8EQ==
X-CSE-MsgGUID: eEaT/vxHTaq60gtZsRhdxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="100678975"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2024 02:35:16 -0700
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
Subject: [PATCH v5 2/3] mm: zswap: zswap_store() extended to handle mTHP folios.
Date: Wed, 28 Aug 2024 02:35:15 -0700
Message-Id: <20240828093516.30228-3-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
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

Made a minor edit in the comments for "struct zswap_entry" to delete
the comments related to "value" since same-filled page handling has
been removed from zswap.

Co-developed-by: Ryan Roberts
Signed-off-by:
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 231 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 170 insertions(+), 61 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 449914ea9919..d6f012ca67d8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -190,7 +190,6 @@ static struct shrinker *zswap_shrinker;
  *              section for context.
  * pool - the zswap_pool the entry's data is in
  * handle - zpool allocation handle that stores the compressed page data
- * value - value of the same-value filled pages which have same content
  * objcg - the obj_cgroup that the compressed memory is charged to
  * lru - handle to the pool's lru used to evict pages.
  */
@@ -876,7 +875,7 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
-static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
+static bool zswap_compress(struct page *page, struct zswap_entry *entry)
 {
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct scatterlist input, output;
@@ -894,7 +893,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 
 	dst = acomp_ctx->buffer;
 	sg_init_table(&input, 1);
-	sg_set_folio(&input, folio, PAGE_SIZE, 0);
+	sg_set_page(&input, page, PAGE_SIZE, 0);
 
 	/*
 	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
@@ -1404,35 +1403,82 @@ static void shrink_worker(struct work_struct *w)
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
+
+	if (objcg)
+		obj_cgroup_get(objcg);
 
 	if (zswap_check_limits())
 		goto reject;
@@ -1445,42 +1491,20 @@ bool zswap_store(struct folio *folio)
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
 
-	entry->swpentry = swp;
+	entry->swpentry = swp_entry(type, offset);
 	entry->objcg = objcg;
 	entry->referenced = true;
 
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
@@ -1511,23 +1535,108 @@ bool zswap_store(struct folio *folio)
 store_failed:
 	zpool_free(entry->pool->zpool, entry->handle);
 put_pool:
-	zswap_pool_put(entry->pool);
+	zswap_pool_put(pool);
 freepage:
 	zswap_entry_cache_free(entry);
 reject:
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


