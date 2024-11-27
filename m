Return-Path: <linux-kernel+bounces-424013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF479DAF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 23:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1628B21FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586D520408C;
	Wed, 27 Nov 2024 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6be47q5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D8D2036FF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748010; cv=none; b=K6RafjTV+IJ5RwZ1sDELX7I3NMh9+qjzfxBvYFSmkI0p68o8O6VW4geXNQeWoLYTsBlHL0zVmm3ZX2rvTg13KpjembsU6d0pyPvD9EtBeNc/4ltVAhVUmj5KYqtpuOI5SHVsGPbHGMz4tOui3OPNf3aRURsL9iPEot15ZnRDA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748010; c=relaxed/simple;
	bh=v3LlDsATLJ9yWYXEOtbAuM5Fnc0kQ/M+aHEO4nE6tzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YSAa8QCy0WDx6Co8S3YYFV2bwy83D1AjFtHahnHV2/ZsWZH3LffEnFii7xytCRZMjAs6iIQVhCovKnkQkDQmfioJ/aGMxe9uOWk2Ka0tUpjk8lD/u9Sgx65pXi62eXbYTMH5IP8NW07TEK2HmxJ3jsF9OHdzbXNX+7AZraxdFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6be47q5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732748009; x=1764284009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v3LlDsATLJ9yWYXEOtbAuM5Fnc0kQ/M+aHEO4nE6tzE=;
  b=f6be47q5PT7RdivO9bphvw3Pr44/xBNVpSfMU6k2zG2Ta7LKUaZs2sHU
   pytfuuaKuxc+O6Agw4xF/kSjPTileXF2lXuWFt4RfJ6C5mc6SN3O/GGHe
   /DD/3KeEpVnsOVQdeNR8HyN2GqcdF2DDNbUHdQaKiyWPcR08sCz7+kpIe
   PWTLfFijGqJW4hinQ3cRQYwJUNcoQYx0+VW9oSdijnzmAyHsj24wwNeql
   F58c9HlJCq/jkmnXDZ4uT6iK3FTeR0u1ZFQo5+E1A+ZT8O4ofpCCWG19v
   CknZ/UEaOR0nbmWIMa8fHeUc/3kroGdKwBGFuzOah96UFgKwZUoZo6B7X
   A==;
X-CSE-ConnectionGUID: 42ATld+OTJejKEt/WYekLA==
X-CSE-MsgGUID: QaTJ5wHdQ9uxTDadapR1Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="33022407"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="33022407"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 14:53:26 -0800
X-CSE-ConnectionGUID: JICzFf11QY6j60/+U18wxw==
X-CSE-MsgGUID: 34/6rIBPRY2GdRkmAkuBuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="92235434"
Received: from unknown (HELO JF5300-B11A338T.jf.intel.com) ([10.242.51.115])
  by fmviesa008.fm.intel.com with ESMTP; 27 Nov 2024 14:53:25 -0800
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v1 1/2] mm: zswap: Modified zswap_store_page() to process multiple pages in a folio.
Date: Wed, 27 Nov 2024 14:53:23 -0800
Message-Id: <20241127225324.6770-2-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modified zswap_store() to store the folio in batches of
SWAP_CRYPTO_BATCH_SIZE pages. Accordingly, refactored zswap_store_page()
into zswap_store_pages() that processes a range of pages in the folio.
zswap_store_pages() is a vectorized version of zswap_store_page().

For now, zswap_store_pages() will sequentially compress these pages with
zswap_compress().

These changes are follow-up to code review comments received for [1], and
are intended to set up zswap_store() for batching with Intel IAA.

[1]: https://patchwork.kernel.org/project/linux-mm/patch/20241123070127.332773-11-kanchana.p.sridhar@intel.com/

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/zswap.h |   1 +
 mm/zswap.c            | 154 ++++++++++++++++++++++++------------------
 2 files changed, 88 insertions(+), 67 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index d961ead91bf1..05a81e750744 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -7,6 +7,7 @@
 
 struct lruvec;
 
+#define SWAP_CRYPTO_BATCH_SIZE 8UL
 extern atomic_long_t zswap_stored_pages;
 
 #ifdef CONFIG_ZSWAP
diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb23..b09d1023e775 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1409,78 +1409,96 @@ static void shrink_worker(struct work_struct *w)
 * main API
 **********************************/
 
-static ssize_t zswap_store_page(struct page *page,
-				struct obj_cgroup *objcg,
-				struct zswap_pool *pool)
+/*
+ * Store multiple pages in @folio, starting from the page at index @si up to
+ * and including the page at index @ei.
+ */
+static ssize_t zswap_store_pages(struct folio *folio,
+				 long si,
+				 long ei,
+				 struct obj_cgroup *objcg,
+				 struct zswap_pool *pool)
 {
-	swp_entry_t page_swpentry = page_swap_entry(page);
+	struct page *page;
+	swp_entry_t page_swpentry;
 	struct zswap_entry *entry, *old;
+	size_t compressed_bytes = 0;
+	u8 nr_pages = ei - si + 1;
+	u8 i;
+
+	for (i = 0; i < nr_pages; ++i) {
+		page = folio_page(folio, si + i);
+		page_swpentry = page_swap_entry(page);
+
+		/* allocate entry */
+		entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
+		if (!entry) {
+			zswap_reject_kmemcache_fail++;
+			return -EINVAL;
+		}
 
-	/* allocate entry */
-	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
-	if (!entry) {
-		zswap_reject_kmemcache_fail++;
-		return -EINVAL;
-	}
-
-	if (!zswap_compress(page, entry, pool))
-		goto compress_failed;
+		if (!zswap_compress(page, entry, pool))
+			goto compress_failed;
 
-	old = xa_store(swap_zswap_tree(page_swpentry),
-		       swp_offset(page_swpentry),
-		       entry, GFP_KERNEL);
-	if (xa_is_err(old)) {
-		int err = xa_err(old);
+		old = xa_store(swap_zswap_tree(page_swpentry),
+			       swp_offset(page_swpentry),
+			       entry, GFP_KERNEL);
+		if (xa_is_err(old)) {
+			int err = xa_err(old);
 
-		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
-		zswap_reject_alloc_fail++;
-		goto store_failed;
-	}
+			WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
+			zswap_reject_alloc_fail++;
+			goto store_failed;
+		}
 
-	/*
-	 * We may have had an existing entry that became stale when
-	 * the folio was redirtied and now the new version is being
-	 * swapped out. Get rid of the old.
-	 */
-	if (old)
-		zswap_entry_free(old);
+		/*
+		 * We may have had an existing entry that became stale when
+		 * the folio was redirtied and now the new version is being
+		 * swapped out. Get rid of the old.
+		 */
+		if (old)
+			zswap_entry_free(old);
 
-	/*
-	 * The entry is successfully compressed and stored in the tree, there is
-	 * no further possibility of failure. Grab refs to the pool and objcg.
-	 * These refs will be dropped by zswap_entry_free() when the entry is
-	 * removed from the tree.
-	 */
-	zswap_pool_get(pool);
-	if (objcg)
-		obj_cgroup_get(objcg);
+		/*
+		 * The entry is successfully compressed and stored in the tree, there is
+		 * no further possibility of failure. Grab refs to the pool and objcg.
+		 * These refs will be dropped by zswap_entry_free() when the entry is
+		 * removed from the tree.
+		 */
+		zswap_pool_get(pool);
+		if (objcg)
+			obj_cgroup_get(objcg);
 
-	/*
-	 * We finish initializing the entry while it's already in xarray.
-	 * This is safe because:
-	 *
-	 * 1. Concurrent stores and invalidations are excluded by folio lock.
-	 *
-	 * 2. Writeback is excluded by the entry not being on the LRU yet.
-	 *    The publishing order matters to prevent writeback from seeing
-	 *    an incoherent entry.
-	 */
-	entry->pool = pool;
-	entry->swpentry = page_swpentry;
-	entry->objcg = objcg;
-	entry->referenced = true;
-	if (entry->length) {
-		INIT_LIST_HEAD(&entry->lru);
-		zswap_lru_add(&zswap_list_lru, entry);
-	}
+		/*
+		 * We finish initializing the entry while it's already in xarray.
+		 * This is safe because:
+		 *
+		 * 1. Concurrent stores and invalidations are excluded by folio lock.
+		 *
+		 * 2. Writeback is excluded by the entry not being on the LRU yet.
+		 *    The publishing order matters to prevent writeback from seeing
+		 *    an incoherent entry.
+		 */
+		entry->pool = pool;
+		entry->swpentry = page_swpentry;
+		entry->objcg = objcg;
+		entry->referenced = true;
+		if (entry->length) {
+			INIT_LIST_HEAD(&entry->lru);
+			zswap_lru_add(&zswap_list_lru, entry);
+		}
 
-	return entry->length;
+		compressed_bytes += entry->length;
+		continue;
 
 store_failed:
-	zpool_free(pool->zpool, entry->handle);
+		zpool_free(pool->zpool, entry->handle);
 compress_failed:
-	zswap_entry_cache_free(entry);
-	return -EINVAL;
+		zswap_entry_cache_free(entry);
+		return -EINVAL;
+	}
+
+	return compressed_bytes;
 }
 
 bool zswap_store(struct folio *folio)
@@ -1492,7 +1510,7 @@ bool zswap_store(struct folio *folio)
 	struct zswap_pool *pool;
 	size_t compressed_bytes = 0;
 	bool ret = false;
-	long index;
+	long si, ei, incr = SWAP_CRYPTO_BATCH_SIZE;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1526,11 +1544,13 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	for (index = 0; index < nr_pages; ++index) {
-		struct page *page = folio_page(folio, index);
+	/* Store the folio in batches of SWAP_CRYPTO_BATCH_SIZE pages. */
+	for (si = 0, ei = min(si + incr - 1, nr_pages - 1);
+	     ((si < nr_pages) && (ei < nr_pages));
+	     si = ei + 1, ei = min(si + incr - 1, nr_pages - 1)) {
 		ssize_t bytes;
 
-		bytes = zswap_store_page(page, objcg, pool);
+		bytes = zswap_store_pages(folio, si, ei, objcg, pool);
 		if (bytes < 0)
 			goto put_pool;
 		compressed_bytes += bytes;
@@ -1565,9 +1585,9 @@ bool zswap_store(struct folio *folio)
 		struct zswap_entry *entry;
 		struct xarray *tree;
 
-		for (index = 0; index < nr_pages; ++index) {
-			tree = swap_zswap_tree(swp_entry(type, offset + index));
-			entry = xa_erase(tree, offset + index);
+		for (si = 0; si < nr_pages; ++si) {
+			tree = swap_zswap_tree(swp_entry(type, offset + si));
+			entry = xa_erase(tree, offset + si);
 			if (entry)
 				zswap_entry_free(entry);
 		}
-- 
2.27.0


