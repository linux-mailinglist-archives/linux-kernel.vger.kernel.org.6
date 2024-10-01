Return-Path: <linux-kernel+bounces-345259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710B798B3B7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3061C2833B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123681BD027;
	Tue,  1 Oct 2024 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V012ApDo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DF1BBBED
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761033; cv=none; b=KvDflvHnjjzvXxrb6m5Lk+ekW+9eNwP+ZoSpMR6/IpshcwYULqVsuq0XmLAYLh7WaBZHBc+HFCzuUNhqL3zGSBDqTOZSSZn/TTDdFg3XpPrZjWrOUVnXUovcnW2xWcMcHchkTX9YduV6/3mXaNpoVRWZGXYpk5G8jboGsGAdu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761033; c=relaxed/simple;
	bh=ZqA5lLeXDY0x6sdJphTljhIJY7azBNvVtOD2DnEXQcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gTtV+JH+LNwtkZ+IERzT0JxWtbmV4334alNw9t98M4akIN5Rv9thaWAnSb4rUE9CHR1kQUUZALI77El5B4zL+IczYN3E4VpBdbCfrHVAqVQuNkMDfTOj7rUSetJ2LBt4tA3S5i99CBUJ3zuV9gbTl6+dyDLbCBJrYDhs/8c49z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V012ApDo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727761032; x=1759297032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZqA5lLeXDY0x6sdJphTljhIJY7azBNvVtOD2DnEXQcU=;
  b=V012ApDo7XyIRRqFZELvr5w0bMahnWBmgmlPq0/L4aQLuGR0wY4+DUU8
   LpgpjwdkBu//kU6EB4FlhoRZYZKUuFaXp9PPhMdKDTBgbcudik9kE2bBC
   xkfhE/CC+Wx1Q0QgfWm4ROfVG28CNU5GFP/miXyH6kIUkVQRxXSPm28rW
   iFoTTA+iZZRP6MVMGoB1nCSUNmu5ykiEhlm/lGTIun2MarC9z0RWk6x6P
   d2KEKVjsnQesb9i3OkGMTTWl6GCBmucB9SmjfYMujkyWm8QKPWITSSHWs
   pQqA0lzGlMSbbkl6y42rdcsytjjIovlzk2ZQB2/HzYAxOQyqW718W7Vr4
   Q==;
X-CSE-ConnectionGUID: sK8J4JJ0Tw+cxjPY9N3CxA==
X-CSE-MsgGUID: YKGNolaHRn+MX64WZ+ZVaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="37465128"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37465128"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 22:32:27 -0700
X-CSE-ConnectionGUID: fGhzmQz2RFu8X+pw/8tNSA==
X-CSE-MsgGUID: 7dEULFhAQP6ZmQjTLj2l8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73205815"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa007.fm.intel.com with ESMTP; 30 Sep 2024 22:32:26 -0700
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
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v10 6/7] mm: zswap: Support large folios in zswap_store().
Date: Mon, 30 Sep 2024 22:32:21 -0700
Message-Id: <20241001053222.6944-7-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zswap_store() will store large folios by compressing them page by page.

This patch provides a sequential implementation of storing a large folio
in zswap_store() by iterating through each page in the folio to compress
and store it in the zswap zpool.

zswap_store() calls the newly added zswap_store_page() function for each
page in the folio. zswap_store_page() handles compressing and storing each
page.

We check the global and per-cgroup limits once at the beginning of
zswap_store(), and only check that the limit is not reached yet. This is
racy and inaccurate, but it should be sufficient for now. We also obtain
initial references to the relevant objcg and pool to guarantee that
subsequent references can be acquired by zswap_store_page(). A new function
zswap_pool_get() is added to facilitate this.

If these one-time checks pass, we compress the pages of the folio, while
maintaining a running count of compressed bytes for all the folio's pages.
If all pages are successfully compressed and stored, we do the cgroup
zswap charging with the total compressed bytes, and batch update the
zswap_stored_pages atomic/zswpout event stats with folio_nr_pages() once,
before returning from zswap_store().

If an error is encountered during the store of any page in the folio,
all pages in that folio currently stored in zswap will be invalidated.
Thus, a folio is either entirely stored in zswap, or entirely not stored
in zswap.

The most important value provided by this patch is it enables swapping out
large folios to zswap without splitting them. Furthermore, it batches some
operations while doing so (cgroup charging, stats updates).

This patch also forms the basis for building compress batching of pages in
a large folio in zswap_store() by compressing up to say, 8 pages of the
folio in parallel in hardware using the Intel In-Memory Analytics
Accelerator (Intel IAA).

This change reuses and adapts the functionality in Ryan Roberts' RFC
patch [1]:

  "[RFC,v1] mm: zswap: Store large folios without splitting"

  [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u

Co-developed-by: Ryan Roberts
Signed-off-by:
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 189 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 121 insertions(+), 68 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 2b8da50f6322..09aaf70f95c6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -411,6 +411,12 @@ static int __must_check zswap_pool_tryget(struct zswap_pool *pool)
 	return percpu_ref_tryget(&pool->ref);
 }
 
+/* The caller must already have a reference. */
+static void zswap_pool_get(struct zswap_pool *pool)
+{
+	percpu_ref_get(&pool->ref);
+}
+
 static void zswap_pool_put(struct zswap_pool *pool)
 {
 	percpu_ref_put(&pool->ref);
@@ -1402,68 +1408,38 @@ static void shrink_worker(struct work_struct *w)
 /*********************************
 * main API
 **********************************/
-bool zswap_store(struct folio *folio)
+
+static ssize_t zswap_store_page(struct page *page,
+				struct obj_cgroup *objcg,
+				struct zswap_pool *pool)
 {
-	swp_entry_t swp = folio->swap;
-	pgoff_t offset = swp_offset(swp);
-	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry, *old;
-	struct obj_cgroup *objcg = NULL;
-	struct mem_cgroup *memcg = NULL;
-
-	VM_WARN_ON_ONCE(!folio_test_locked(folio));
-	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
-
-	/* Large folios aren't supported */
-	if (folio_test_large(folio))
-		return false;
-
-	if (!zswap_enabled)
-		goto check_old;
-
-	/* Check cgroup limits */
-	objcg = get_obj_cgroup_from_folio(folio);
-	if (objcg && !obj_cgroup_may_zswap(objcg)) {
-		memcg = get_mem_cgroup_from_objcg(objcg);
-		if (shrink_memcg(memcg)) {
-			mem_cgroup_put(memcg);
-			goto reject;
-		}
-		mem_cgroup_put(memcg);
-	}
-
-	if (zswap_check_limits())
-		goto reject;
 
 	/* allocate entry */
-	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
+	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
 	if (!entry) {
 		zswap_reject_kmemcache_fail++;
 		goto reject;
 	}
 
-	/* if entry is successfully added, it keeps the reference */
-	entry->pool = zswap_pool_current_get();
-	if (!entry->pool)
-		goto freepage;
+	/* zswap_store() already holds a ref on 'objcg' and 'pool' */
+	if (objcg)
+		obj_cgroup_get(objcg);
+	zswap_pool_get(pool);
 
-	if (objcg) {
-		memcg = get_mem_cgroup_from_objcg(objcg);
-		if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERNEL)) {
-			mem_cgroup_put(memcg);
-			goto put_pool;
-		}
-		mem_cgroup_put(memcg);
-	}
+	/* if entry is successfully added, it keeps the reference */
+	entry->pool = pool;
 
-	if (!zswap_compress(&folio->page, entry))
-		goto put_pool;
+	if (!zswap_compress(page, entry))
+		goto put_pool_objcg;
 
-	entry->swpentry = swp;
+	entry->swpentry = page_swap_entry(page);
 	entry->objcg = objcg;
 	entry->referenced = true;
 
-	old = xa_store(tree, offset, entry, GFP_KERNEL);
+	old = xa_store(swap_zswap_tree(entry->swpentry),
+		       swp_offset(entry->swpentry),
+		       entry, GFP_KERNEL);
 	if (xa_is_err(old)) {
 		int err = xa_err(old);
 
@@ -1480,11 +1456,6 @@ bool zswap_store(struct folio *folio)
 	if (old)
 		zswap_entry_free(old);
 
-	if (objcg) {
-		obj_cgroup_charge_zswap(objcg, entry->length);
-		count_objcg_events(objcg, ZSWPOUT, 1);
-	}
-
 	/*
 	 * We finish initializing the entry while it's already in xarray.
 	 * This is safe because:
@@ -1500,32 +1471,114 @@ bool zswap_store(struct folio *folio)
 		zswap_lru_add(&zswap_list_lru, entry);
 	}
 
-	/* update stats */
-	atomic_long_inc(&zswap_stored_pages);
-	count_vm_event(ZSWPOUT);
-
-	return true;
+	/*
+	 * We shouldn't have any possibility of failure after the entry is
+	 * added in the xarray. The pool/objcg refs obtained here will only
+	 * be dropped if/when zswap_entry_free() gets called.
+	 */
+	return entry->length;
 
 store_failed:
 	zpool_free(entry->pool->zpool, entry->handle);
-put_pool:
-	zswap_pool_put(entry->pool);
-freepage:
+put_pool_objcg:
+	zswap_pool_put(pool);
+	obj_cgroup_put(objcg);
 	zswap_entry_cache_free(entry);
 reject:
+	return -EINVAL;
+}
+
+bool zswap_store(struct folio *folio)
+{
+	long nr_pages = folio_nr_pages(folio);
+	swp_entry_t swp = folio->swap;
+	struct obj_cgroup *objcg = NULL;
+	struct mem_cgroup *memcg = NULL;
+	struct zswap_pool *pool;
+	size_t compressed_bytes = 0;
+	bool ret = false;
+	long index;
+
+	VM_WARN_ON_ONCE(!folio_test_locked(folio));
+	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
+
+	if (!zswap_enabled)
+		goto check_old;
+
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
+	for (index = 0; index < nr_pages; ++index) {
+		struct page *page = folio_page(folio, index);
+		ssize_t bytes;
+
+		bytes = zswap_store_page(page, objcg, pool);
+		if (bytes < 0)
+			goto put_pool;
+		compressed_bytes += bytes;
+	}
+
+	if (objcg) {
+		obj_cgroup_charge_zswap(objcg, compressed_bytes);
+		count_objcg_events(objcg, ZSWPOUT, nr_pages);
+	}
+
+	atomic_long_add(nr_pages, &zswap_stored_pages);
+	count_vm_events(ZSWPOUT, nr_pages);
+
+	ret = true;
+
+put_pool:
+	zswap_pool_put(pool);
+put_objcg:
 	obj_cgroup_put(objcg);
-	if (zswap_pool_reached_full)
+	if (!ret && zswap_pool_reached_full)
 		queue_work(shrink_wq, &zswap_shrink_work);
 check_old:
 	/*
-	 * If the zswap store fails or zswap is disabled, we must invalidate the
-	 * possibly stale entry which was previously stored at this offset.
-	 * Otherwise, writeback could overwrite the new data in the swapfile.
+	 * If the zswap store fails or zswap is disabled, we must invalidate
+	 * the possibly stale entries which were previously stored at the
+	 * offsets corresponding to each page of the folio. Otherwise,
+	 * writeback could overwrite the new data in the swapfile.
 	 */
-	entry = xa_erase(tree, offset);
-	if (entry)
-		zswap_entry_free(entry);
-	return false;
+	if (!ret) {
+		unsigned type = swp_type(swp);
+		pgoff_t offset = swp_offset(swp);
+		struct zswap_entry *entry;
+		struct xarray *tree;
+
+		for (index = 0; index < nr_pages; ++index) {
+			tree = swap_zswap_tree(swp_entry(type, offset + index));
+			entry = xa_erase(tree, offset + index);
+			if (entry)
+				zswap_entry_free(entry);
+		}
+	}
+
+	return ret;
 }
 
 bool zswap_load(struct folio *folio)
-- 
2.27.0


