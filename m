Return-Path: <linux-kernel+bounces-424014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8239DAF5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 23:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF0A2820DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6487720408D;
	Wed, 27 Nov 2024 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dl+sUoet"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFEC203704
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748010; cv=none; b=KvBAdgvmyWTlWy73TDUILNQUTaeSOS9Q3zLVKCjXz0UKc1VNOcIbwd0ji9OJD3HjRtU4CB9bqoS3S7+qUddXtNRCqrwk5ubHMlxvijgWbmeQpBHwNx4Fg8kt36KDtz09hbUdSCGnLWMEAN5GQiLO9bqp15ROdyndCrD8TBdFMQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748010; c=relaxed/simple;
	bh=C3GKVK6Y3WXAyh5rwDc2Noj36/JK07WlrTl18HMt5Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0/8FxugruW/I5ByrUypjRtePUerKt1rkbFdiH7/phfqxER8cjHMUGSt7RKMAAifDogTHeNo1GDwyjFslRbSGvEMlYixAuSHJuwzauXGj9iAB9pVzbRp7ylOL59UmcM+L7JqbY4W2s7GJry/CWHzHMe7OosJyW+HXxe+y4Aq6G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dl+sUoet; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732748009; x=1764284009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C3GKVK6Y3WXAyh5rwDc2Noj36/JK07WlrTl18HMt5Dk=;
  b=dl+sUoetlnIWbhJJWqPAzZC2bgksbBsBWav4l83LNbI3cgF/U8TUMBP7
   5J6Q3XfZE8CgHvq74UlJFzFYlPg4K6GrzioxWbZAlzRTiwhVnB+1Z83To
   kIrH/30pCVU2Q1twdFWH8jOJS8qgresSiXu7AeZIEcseaamkVAxaELqm7
   GyGtV7JejSmgu2OzOWmwPfAijxOZHaTXOvPrIppD7CuB2h5OWPlGdOGKd
   sZoEmi5KULUQYuRc2ntMWS6mRmomuOUVF0Ufo+ExiY/bn8MYAkyQnVVGQ
   nFdSXNMeyHw3QxavK4sBpxSB5z3/L33bT9Rua78/OAbbLQLIoKoEWMzH5
   Q==;
X-CSE-ConnectionGUID: XVevmi1xTNK5EvhFJPxG5A==
X-CSE-MsgGUID: 5I96WoNwRwOn4YAW6Y4r8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="33022415"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="33022415"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 14:53:26 -0800
X-CSE-ConnectionGUID: 3kh+VfrZRcCXbRoufuZUbQ==
X-CSE-MsgGUID: ddh5E4T1QkKfP79JROuekw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="92235438"
Received: from unknown (HELO JF5300-B11A338T.jf.intel.com) ([10.242.51.115])
  by fmviesa008.fm.intel.com with ESMTP; 27 Nov 2024 14:53:26 -0800
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
Subject: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications for batching.
Date: Wed, 27 Nov 2024 14:53:24 -0800
Message-Id: <20241127225324.6770-3-kanchana.p.sridhar@intel.com>
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

In order to set up zswap_store_pages() to enable a clean batching
implementation in [1], this patch implements the following changes:

1) Addition of zswap_alloc_entries() which will allocate zswap entries for
   all pages in the specified range for the folio, upfront. If this fails,
   we return an error status to zswap_store().

2) Addition of zswap_compress_pages() that calls zswap_compress() for each
   page, and returns false if any zswap_compress() fails, so
   zswap_store_page() can cleanup resources allocated and return an error
   status to zswap_store().

3) A "store_pages_failed" label that is a catch-all for all failure points
   in zswap_store_pages(). This facilitates cleaner error handling within
   zswap_store_pages(), which will become important for IAA compress
   batching in [1].

[1]: https://patchwork.kernel.org/project/linux-mm/list/?series=911935

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 93 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 22 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index b09d1023e775..db80c66e2205 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1409,9 +1409,56 @@ static void shrink_worker(struct work_struct *w)
 * main API
 **********************************/
 
+static bool zswap_compress_pages(struct page *pages[],
+				 struct zswap_entry *entries[],
+				 u8 nr_pages,
+				 struct zswap_pool *pool)
+{
+	u8 i;
+
+	for (i = 0; i < nr_pages; ++i) {
+		if (!zswap_compress(pages[i], entries[i], pool))
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Allocate @nr zswap entries for storing @nr pages in a folio.
+ * If any one of the entry allocation fails, delete all entries allocated
+ * thus far, and return false.
+ * If @nr entries are successfully allocated, set each entry's "handle"
+ * to "ERR_PTR(-EINVAL)" to denote that the handle has not yet been allocated.
+ */
+static bool zswap_alloc_entries(struct zswap_entry *entries[], int node_id, u8 nr)
+{
+	u8 i;
+
+	for (i = 0; i < nr; ++i) {
+		entries[i] = zswap_entry_cache_alloc(GFP_KERNEL, node_id);
+		if (!entries[i]) {
+			u8 j;
+
+			zswap_reject_kmemcache_fail++;
+			for (j = 0; j < i; ++j)
+				zswap_entry_cache_free(entries[j]);
+			return false;
+		}
+
+		entries[i]->handle = (unsigned long)ERR_PTR(-EINVAL);
+	}
+
+	return true;
+}
+
 /*
  * Store multiple pages in @folio, starting from the page at index @si up to
  * and including the page at index @ei.
+ * The error handling from all failure points is handled by the
+ * "store_pages_failed" label, based on the initial ERR_PTR(-EINVAL) value for
+ * the zswap_entry's handle set by zswap_alloc_entries(), and the fact that the
+ * entry's handle is subsequently modified only upon a successful zpool_malloc().
  */
 static ssize_t zswap_store_pages(struct folio *folio,
 				 long si,
@@ -1419,26 +1466,25 @@ static ssize_t zswap_store_pages(struct folio *folio,
 				 struct obj_cgroup *objcg,
 				 struct zswap_pool *pool)
 {
-	struct page *page;
-	swp_entry_t page_swpentry;
-	struct zswap_entry *entry, *old;
+	struct zswap_entry *entries[SWAP_CRYPTO_BATCH_SIZE], *old;
+	struct page *pages[SWAP_CRYPTO_BATCH_SIZE];
 	size_t compressed_bytes = 0;
 	u8 nr_pages = ei - si + 1;
 	u8 i;
 
-	for (i = 0; i < nr_pages; ++i) {
-		page = folio_page(folio, si + i);
-		page_swpentry = page_swap_entry(page);
+	/* allocate entries */
+	if (!zswap_alloc_entries(entries, folio_nid(folio), nr_pages))
+		return -EINVAL;
 
-		/* allocate entry */
-		entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
-		if (!entry) {
-			zswap_reject_kmemcache_fail++;
-			return -EINVAL;
-		}
+	for (i = 0; i < nr_pages; ++i)
+		pages[i] = folio_page(folio, si + i);
 
-		if (!zswap_compress(page, entry, pool))
-			goto compress_failed;
+	if (!zswap_compress_pages(pages, entries, nr_pages, pool))
+		goto store_pages_failed;
+
+	for (i = 0; i < nr_pages; ++i) {
+		swp_entry_t page_swpentry = page_swap_entry(pages[i]);
+		struct zswap_entry *entry = entries[i];
 
 		old = xa_store(swap_zswap_tree(page_swpentry),
 			       swp_offset(page_swpentry),
@@ -1448,7 +1494,7 @@ static ssize_t zswap_store_pages(struct folio *folio,
 
 			WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
 			zswap_reject_alloc_fail++;
-			goto store_failed;
+			goto store_pages_failed;
 		}
 
 		/*
@@ -1489,16 +1535,19 @@ static ssize_t zswap_store_pages(struct folio *folio,
 		}
 
 		compressed_bytes += entry->length;
-		continue;
-
-store_failed:
-		zpool_free(pool->zpool, entry->handle);
-compress_failed:
-		zswap_entry_cache_free(entry);
-		return -EINVAL;
 	}
 
 	return compressed_bytes;
+
+store_pages_failed:
+	for (i = 0; i < nr_pages; ++i) {
+		if (!IS_ERR_VALUE(entries[i]->handle))
+			zpool_free(pool->zpool, entries[i]->handle);
+
+		zswap_entry_cache_free(entries[i]);
+	}
+
+	return -EINVAL;
 }
 
 bool zswap_store(struct folio *folio)
-- 
2.27.0


