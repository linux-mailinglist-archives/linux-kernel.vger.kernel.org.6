Return-Path: <linux-kernel+bounces-336438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB0C983ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B491C22055
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082DF3612D;
	Tue, 24 Sep 2024 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxsxztKY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200FB67A
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727140639; cv=none; b=DErHwAbTCDJWivyPzajeZerehKaeFuSRlOMZKEvzppkUVnCVU33Lumom1Rb29anB3MclOvGa0TMrHxZJ4lrw5l8oljpd0vVsou1U6jC1CsBC+gvc3YXlnktd4p6BrPccXvjHz9Yvwmbi28fCrKyLyr2CXO0I7M54VtFSrIX1ohI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727140639; c=relaxed/simple;
	bh=TC61NMZkVLT5VlFsRHxoHlVUivXlE7pDxlM31DB9mpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ko8kpUgi4762tJmsP7oLrFmxizlDmWputihNKhwCXWEX4/CAtMs57zP6WYVnJeUALOjMsx5VSxIW9WKxZwrWw/0I3JW+S0cseHtkt5iClAae7PTtQLvg/XkFTs+1YjbQMrr5rfKj8vSpz8eakip5dP/KAp9edO/vSvDVfjkeJys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxsxztKY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727140636; x=1758676636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TC61NMZkVLT5VlFsRHxoHlVUivXlE7pDxlM31DB9mpg=;
  b=BxsxztKYayVmUCd/vbvFfPGYU9U8u74rRmC3hFmntWOFpDDHI/fCb8Ov
   tGMjrLed4s2ZuaWSomollQkyCRIKgZlg8WQgTriFoC7M3I31z7+e96JnA
   wnvovIw8rp1NHiS20eO6hY7ca4ThD3v4B/R7SGQvNWF0RwwTGoxlGrSwl
   JjGhMQ42C2PdBbmLelLLuEa+07huFN9vEwSMN2oWNulqOlf5d8O90beMf
   ZjljQt/EvPMEG7NO3b8ifoMdlEf506RQiiMrK+MJ1gXLLpOrawhrFvG2M
   1vvbFuD581Zshp2PPehOhV503hLjtKlq7EWfwF6VBsqlA3OhDI0n0eRmo
   A==;
X-CSE-ConnectionGUID: sCU8AjK3RV+gw6WNglq0sg==
X-CSE-MsgGUID: J33hCYPgTF2Flk2XkGoP7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="30002038"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="30002038"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 18:17:11 -0700
X-CSE-ConnectionGUID: h6kZ0n4KQd2ezP+USAgHWA==
X-CSE-MsgGUID: 6ihG0j0jSjSdRCs1upV+/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="108688460"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa001.jf.intel.com with ESMTP; 23 Sep 2024 18:17:10 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	shakeel.butt@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Date: Mon, 23 Sep 2024 18:17:07 -0700
Message-Id: <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zswap_store() will now store mTHP and PMD-size THP folios by compressing
them page by page.

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
of large folios by compressing batches of up to say, 8 pages in an
mTHP in parallel in hardware, with the Intel In-Memory Analytics
Accelerator (Intel IAA).

A new config variable CONFIG_ZSWAP_STORE_THP_DEFAULT_ON (off by default)
will enable/disable zswap storing of (m)THP. The corresponding tunable
zswap module parameter is "mthp_enabled".

This change reuses and adapts the functionality in Ryan Roberts' RFC
patch [1]:

  "[RFC,v1] mm: zswap: Store large folios without splitting"

  [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u

Also, addressed some of the RFC comments from the discussion in [1].

Co-developed-by: Ryan Roberts
Signed-off-by:
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/Kconfig |   8 ++++
 mm/zswap.c | 122 +++++++++++++++++++++++++----------------------------
 2 files changed, 66 insertions(+), 64 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 09aebca1cae3..c659fb732ec4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -59,6 +59,14 @@ config ZSWAP_SHRINKER_DEFAULT_ON
 	  reducing the chance that cold pages will reside in the zswap pool
 	  and consume memory indefinitely.
 
+config ZSWAP_STORE_THP_DEFAULT_ON
+	bool "Store mTHP and THP folios in zswap"
+	depends on ZSWAP
+	default n
+	help
+	  If selected, zswap will process mTHP and THP folios by
+	  compressing and storing each 4K page in the large folio.
+
 choice
 	prompt "Default compressor"
 	depends on ZSWAP
diff --git a/mm/zswap.c b/mm/zswap.c
index 8f2e0ab34c84..16ab770546d6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -127,6 +127,14 @@ static bool zswap_shrinker_enabled = IS_ENABLED(
 		CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
 module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
 
+/*
+ * Enable/disable zswap processing of mTHP folios.
+ * For now, only zswap_store will process mTHP folios.
+ */
+static bool zswap_mthp_enabled = IS_ENABLED(
+		CONFIG_ZSWAP_STORE_THP_DEFAULT_ON);
+module_param_named(mthp_enabled, zswap_mthp_enabled, bool, 0644);
+
 bool zswap_is_enabled(void)
 {
 	return zswap_enabled;
@@ -1471,9 +1479,9 @@ static void zswap_delete_stored_offsets(struct xarray *tree,
  * @objcg: The folio's objcg.
  * @pool:  The zswap_pool to store the compressed data for the page.
  */
-static bool __maybe_unused zswap_store_page(struct folio *folio, long index,
-					    struct obj_cgroup *objcg,
-					    struct zswap_pool *pool)
+static bool zswap_store_page(struct folio *folio, long index,
+			     struct obj_cgroup *objcg,
+			     struct zswap_pool *pool)
 {
 	swp_entry_t swp = folio->swap;
 	int type = swp_type(swp);
@@ -1551,51 +1559,63 @@ static bool __maybe_unused zswap_store_page(struct folio *folio, long index,
 	return false;
 }
 
+/*
+ * Modified to store mTHP folios. Each page in the mTHP will be compressed
+ * and stored sequentially.
+ */
 bool zswap_store(struct folio *folio)
 {
 	long nr_pages = folio_nr_pages(folio);
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
 	struct xarray *tree = swap_zswap_tree(swp);
-	struct zswap_entry *entry;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
+	struct zswap_pool *pool;
+	bool ret = false;
+	long index;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
 
-	/* Large folios aren't supported */
-	if (folio_test_large(folio))
+	/* Storing large folios isn't enabled */
+	if (!zswap_mthp_enabled && folio_test_large(folio))
 		return false;
 
 	if (!zswap_enabled)
-		goto check_old;
+		goto reject;
 
-	/* Check cgroup limits */
+	/*
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
+	 */
 	objcg = get_obj_cgroup_from_folio(folio);
 	if (objcg && !obj_cgroup_may_zswap(objcg)) {
 		memcg = get_mem_cgroup_from_objcg(objcg);
 		if (shrink_memcg(memcg)) {
 			mem_cgroup_put(memcg);
-			goto reject;
+			goto put_objcg;
 		}
 		mem_cgroup_put(memcg);
 	}
 
 	if (zswap_check_limits())
-		goto reject;
-
-	/* allocate entry */
-	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
-	if (!entry) {
-		zswap_reject_kmemcache_fail++;
-		goto reject;
-	}
+		goto put_objcg;
 
-	/* if entry is successfully added, it keeps the reference */
-	entry->pool = zswap_pool_current_get();
-	if (!entry->pool)
-		goto freepage;
+	pool = zswap_pool_current_get();
+	if (!pool)
+		goto put_objcg;
 
 	if (objcg) {
 		memcg = get_mem_cgroup_from_objcg(objcg);
@@ -1606,60 +1626,34 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	if (!zswap_compress(&folio->page, entry))
-		goto put_pool;
-
-	entry->swpentry = swp;
-	entry->objcg = objcg;
-	entry->referenced = true;
-
-	if (!zswap_store_entry(tree, entry))
-		goto store_failed;
-
-	if (objcg) {
-		obj_cgroup_charge_zswap(objcg, entry->length);
-		count_objcg_event(objcg, ZSWPOUT);
-	}
-
 	/*
-	 * We finish initializing the entry while it's already in xarray.
-	 * This is safe because:
-	 *
-	 * 1. Concurrent stores and invalidations are excluded by folio lock.
-	 *
-	 * 2. Writeback is excluded by the entry not being on the LRU yet.
-	 *    The publishing order matters to prevent writeback from seeing
-	 *    an incoherent entry.
+	 * Store each page of the folio as a separate entry. If we fail to store
+	 * a page, unwind by removing all the previous pages we stored.
 	 */
-	if (entry->length) {
-		INIT_LIST_HEAD(&entry->lru);
-		zswap_lru_add(&zswap_list_lru, entry);
+	for (index = 0; index < nr_pages; ++index) {
+		if (!zswap_store_page(folio, index, objcg, pool))
+			goto put_pool;
 	}
 
-	/* update stats */
-	atomic_inc(&zswap_stored_pages);
-	count_vm_event(ZSWPOUT);
-
-	return true;
+	ret = true;
 
-store_failed:
-	zpool_free(entry->pool->zpool, entry->handle);
 put_pool:
-	zswap_pool_put(entry->pool);
-freepage:
-	zswap_entry_cache_free(entry);
-reject:
+	zswap_pool_put(pool);
+put_objcg:
 	obj_cgroup_put(objcg);
 	if (zswap_pool_reached_full)
 		queue_work(shrink_wq, &zswap_shrink_work);
-check_old:
+reject:
 	/*
-	 * If the zswap store fails or zswap is disabled, we must invalidate the
-	 * possibly stale entry which was previously stored at this offset.
-	 * Otherwise, writeback could overwrite the new data in the swapfile.
+	 * If the zswap store fails or zswap is disabled, we must invalidate
+	 * the possibly stale entries which were previously stored at the
+	 * offsets corresponding to each page of the folio. Otherwise,
+	 * writeback could overwrite the new data in the swapfile.
 	 */
-	zswap_delete_stored_offsets(tree, offset, nr_pages);
-	return false;
+	if (!ret)
+		zswap_delete_stored_offsets(tree, offset, nr_pages);
+
+	return ret;
 }
 
 bool zswap_load(struct folio *folio)
-- 
2.27.0


