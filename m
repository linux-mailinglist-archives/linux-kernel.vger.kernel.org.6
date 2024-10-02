Return-Path: <linux-kernel+bounces-348029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DFC98E1B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981972824BF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A111D172E;
	Wed,  2 Oct 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2SdCgeT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0F1D0B9B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890411; cv=none; b=SJgzwVoN1fDzotdW0VVddJQLhXusMZSnG976WTyuK4dniKt8vs5rhruEndupQ/GQnVSfE+bezftNabzFy7l0yCDxiq0ReSN1Kc+1grKQjqREcltoCZSAheYVgc25k4UYbpB/OV9MZcaAUFscsvK0cbrv26Z+OQxJ168mzOMQhGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890411; c=relaxed/simple;
	bh=1csFwrhxEdRzmEJzvTdg5rK5UGxUh7oEkFpr7q5uGNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nh+utUsvBw/FsXTrjhkdjYu1TgKpx4YP69fBbgNRV89OIUVgymR56jNzAzBKPYtidjefjxd2Lbz8K/wJw/e4NT92Pivg0JpY6tpI+pZWCu10BKQlcEdTx8d7crVqOBXsAbRTMYcJHFVJ9VJAfxmzGbN4bZYoZJWafnQoDELR4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2SdCgeT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727890410; x=1759426410;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1csFwrhxEdRzmEJzvTdg5rK5UGxUh7oEkFpr7q5uGNM=;
  b=D2SdCgeT5tA+MsTfFBztC/JynL3aNrSk++fuE4OFX2CzHi0y9ETMbjq5
   B5/lFbTUJIWPzAEQ2TBqQaAMknyI0UXpy7YLXv/GAm5DHzJd3Mq4lTqO+
   3T3vPcuXy7HIl8UxTlKmj53x4Xm0W5Gy8GTHZhAgjEiecjoFvAJdU0BE9
   w3L/+S6MI9a8V5a6DbgBWGzIZP8DRgOpLYXUHp5OpvcG5rgjvVogHEHzE
   QqGcKvdy4R+eo0IQxrvbjzKgNmQTWyoEPE7XltutGzQjVndn/DdhlJvfo
   Z7vTvZr/mH7/t1QiuxxSP35z3u3fPE3/c3UOQg1kAHDYs8qRB+BNvYqqC
   g==;
X-CSE-ConnectionGUID: 54kddKjAQ22ugqjx4L9+gw==
X-CSE-MsgGUID: FTJ7XwdsSOSxxkZvhQzGhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27158927"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="27158927"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 10:33:29 -0700
X-CSE-ConnectionGUID: a7d7LA8UQjWECZOh3nGyoQ==
X-CSE-MsgGUID: WP87RBtpRi6GjkE+WlYMyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="73934168"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa010.jf.intel.com with ESMTP; 02 Oct 2024 10:33:30 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v1] mm: zswap: zswap_store_page() will initialize entry after adding to xarray.
Date: Wed,  2 Oct 2024 10:33:29 -0700
Message-Id: <20241002173329.213722-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This incorporates Yosry's suggestions in [1] for further simplifying
zswap_store_page(). If the page is successfully compressed and added to
the xarray, we get the pool/objcg refs, and initialize all the entry's
members. Only after this, we add it to the zswap LRU.

In the time between the entry's addition to the xarray and it's member
initialization, we are protected against concurrent
stores/loads/swapoff through the folio lock, and are protected against
writeback because the entry is not on the LRU yet.

This way, we don't have to drop the pool/objcg refs, now that the entry
initialization is centralized to the successful page store code path.

zswap_compress() is modified to take a zswap_pool parameter in keeping
with this simplification (as against obtaining this from entry->pool).

[1]: https://lore.kernel.org/all/CAJD7tkZh6ufHQef5HjXf_F5b5LC1EATexgseD=4WvrO+a6Ni6w@mail.gmail.com/

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 56 +++++++++++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 09aaf70f95c6..ddbcf34676c5 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -881,7 +881,8 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
-static bool zswap_compress(struct page *page, struct zswap_entry *entry)
+static bool zswap_compress(struct page *page, struct zswap_entry *entry,
+			   struct zswap_pool *pool)
 {
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct scatterlist input, output;
@@ -893,7 +894,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry)
 	gfp_t gfp;
 	u8 *dst;
 
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
+	acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
 
 	mutex_lock(&acomp_ctx->mutex);
 
@@ -926,7 +927,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry)
 	if (comp_ret)
 		goto unlock;
 
-	zpool = entry->pool->zpool;
+	zpool = pool->zpool;
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
 	if (zpool_malloc_support_movable(zpool))
 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
@@ -1413,32 +1414,21 @@ static ssize_t zswap_store_page(struct page *page,
 				struct obj_cgroup *objcg,
 				struct zswap_pool *pool)
 {
+	swp_entry_t page_swpentry = page_swap_entry(page);
 	struct zswap_entry *entry, *old;
 
 	/* allocate entry */
 	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
 	if (!entry) {
 		zswap_reject_kmemcache_fail++;
-		goto reject;
+		return -EINVAL;
 	}
 
-	/* zswap_store() already holds a ref on 'objcg' and 'pool' */
-	if (objcg)
-		obj_cgroup_get(objcg);
-	zswap_pool_get(pool);
-
-	/* if entry is successfully added, it keeps the reference */
-	entry->pool = pool;
+	if (!zswap_compress(page, entry, pool))
+		goto compress_failed;
 
-	if (!zswap_compress(page, entry))
-		goto put_pool_objcg;
-
-	entry->swpentry = page_swap_entry(page);
-	entry->objcg = objcg;
-	entry->referenced = true;
-
-	old = xa_store(swap_zswap_tree(entry->swpentry),
-		       swp_offset(entry->swpentry),
+	old = xa_store(swap_zswap_tree(page_swpentry),
+		       swp_offset(page_swpentry),
 		       entry, GFP_KERNEL);
 	if (xa_is_err(old)) {
 		int err = xa_err(old);
@@ -1456,6 +1446,16 @@ static ssize_t zswap_store_page(struct page *page,
 	if (old)
 		zswap_entry_free(old);
 
+	/*
+	 * The entry is successfully compressed and stored in the tree, there is
+	 * no further possibility of failure. Grab refs to the pool and objcg.
+	 * These refs will be dropped by zswap_entry_free() when the entry is
+	 * removed from the tree.
+	 */
+	zswap_pool_get(pool);
+	if (objcg)
+		obj_cgroup_get(objcg);
+
 	/*
 	 * We finish initializing the entry while it's already in xarray.
 	 * This is safe because:
@@ -1466,25 +1466,21 @@ static ssize_t zswap_store_page(struct page *page,
 	 *    The publishing order matters to prevent writeback from seeing
 	 *    an incoherent entry.
 	 */
+	entry->pool = pool;
+	entry->swpentry = page_swpentry;
+	entry->objcg = objcg;
+	entry->referenced = true;
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&zswap_list_lru, entry);
 	}
 
-	/*
-	 * We shouldn't have any possibility of failure after the entry is
-	 * added in the xarray. The pool/objcg refs obtained here will only
-	 * be dropped if/when zswap_entry_free() gets called.
-	 */
 	return entry->length;
 
 store_failed:
-	zpool_free(entry->pool->zpool, entry->handle);
-put_pool_objcg:
-	zswap_pool_put(pool);
-	obj_cgroup_put(objcg);
+	zpool_free(pool->zpool, entry->handle);
+compress_failed:
 	zswap_entry_cache_free(entry);
-reject:
 	return -EINVAL;
 }
 
-- 
2.27.0


