Return-Path: <linux-kernel+bounces-224051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D62A911C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2221F216B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B145212D74E;
	Fri, 21 Jun 2024 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AAEy6Q8q"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A58129A74
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954151; cv=none; b=XztU2B6IFbcPXUqqSfWz/844G6CRG0cZ9NU6bA1qeXrqlJFQcC9sGszTCrg2t7NkW4MVF53WfqihjrAxQImnts8tqkIJaTB/mjzOnBUe0SCLmlsiU1Q9+W2l4pB2GpmjJyo9HtK9M8NL/8HUBVAooX3pbC+w/xAxtY7DQ3YiEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954151; c=relaxed/simple;
	bh=7D3T7yM8Ob4tOureTBkgzH9fmQTasZoU94aL1jswHyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wo0/4+f6q7xqPSD9GYuY+V1HO3o6rsoiHbwKM4PvXK27CFCrujRIQ5ybhcOhKwaTQi7Zp/r2tPKJS0IZYGIORQhVX6+6eQvWPrlbXbkcmzEYJfvTuWUKN/s9M1qzXCJ4QJ69eb8B0vRPV41TqSyNDO09zmDfbXx4CzlxPaLBMMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AAEy6Q8q; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: nphamcs@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718954147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYdTXTKYKtxpSFisk6BbhTPD4FTbLOjBtWhY7hcv+m0=;
	b=AAEy6Q8qMThfp8kju3S0+6cahdNf6SL7krmx7kKmZxDZqLUkrCic+qYfM2S6DCjAorPsyl
	CpXV7PUVRqGash7dK+FHYkF2Dl5YrOXyd69BoZsID0WC5m+qnk2yyWzr2+YIjRa6uhYDFa
	cutl+bIlz4gc45U/G18ydx2LjOsEl4c=
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: dan.carpenter@linaro.org
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: yuzhao@google.com
X-Envelope-To: senozhatsky@chromium.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: flintglass@gmail.com
X-Envelope-To: minchan@kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Fri, 21 Jun 2024 15:15:10 +0800
Subject: [PATCH v2 2/2] mm/zswap: use only one pool in zswap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-zsmalloc-lock-mm-everything-v2-2-d30e9cd2b793@linux.dev>
References: <20240621-zsmalloc-lock-mm-everything-v2-0-d30e9cd2b793@linux.dev>
In-Reply-To: <20240621-zsmalloc-lock-mm-everything-v2-0-d30e9cd2b793@linux.dev>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
 Nhat Pham <nphamcs@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>, Takero Funaki <flintglass@gmail.com>, 
 Chengming Zhou <zhouchengming@bytedance.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718954135; l=7684;
 i=chengming.zhou@linux.dev; s=20240617; h=from:subject:message-id;
 bh=7D3T7yM8Ob4tOureTBkgzH9fmQTasZoU94aL1jswHyU=;
 b=8sdShy75MzwC/1IFMnr18SRcRbKvQCp+VzBanMFYq6w/l2N6ol5uzzF1PQ9WaWRTmkpeR30Yh
 u576rjAX3CKBSC1rNo6BhQSlRBwj42Y/lHwdKCcU1Hr+SqBuF1IZCDl
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=/XPhIutBo+zyUeQyf4Ni5JYk/PEIWxIeUQqy2DYjmhI=
X-Migadu-Flow: FLOW_OUT

Zswap uses 32 pools to workaround the locking scalability problem in
zswap backends (mainly zsmalloc nowadays), which brings its own problems
like memory waste and more memory fragmentation.

Testing results show that we can have near performance with only one
pool in zswap after changing zsmalloc to use per-size_class lock instead
of pool spinlock.

Testing kernel build (make bzImage -j32) on tmpfs with memory.max=1GB,
and zswap shrinker enabled with 10GB swapfile on ext4.

                                real    user    sys
6.10.0-rc3                      138.18  1241.38 1452.73
6.10.0-rc3-onepool              149.45  1240.45 1844.69
6.10.0-rc3-onepool-perclass     138.23  1242.37 1469.71

And do the same testing using zbud, which shows a little worse performance
as expected since we don't do any locking optimization for zbud. I think
it's acceptable since zsmalloc became a lot more popular than other
backends, and we may want to support only zsmalloc in the future.

                                real    user    sys
6.10.0-rc3-zbud			138.23  1239.58 1430.09
6.10.0-rc3-onepool-zbud		139.64  1241.37 1516.59

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/zswap.c | 60 +++++++++++++++++++-----------------------------------------
 1 file changed, 19 insertions(+), 41 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index e25a6808c2ed..7925a3d0903e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -122,9 +122,6 @@ static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
 module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
 		   uint, 0644);
 
-/* Number of zpools in zswap_pool (empirically determined for scalability) */
-#define ZSWAP_NR_ZPOOLS 32
-
 /* Enable/disable memory pressure-based shrinker. */
 static bool zswap_shrinker_enabled = IS_ENABLED(
 		CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
@@ -160,7 +157,7 @@ struct crypto_acomp_ctx {
  * needs to be verified that it's still valid in the tree.
  */
 struct zswap_pool {
-	struct zpool *zpools[ZSWAP_NR_ZPOOLS];
+	struct zpool *zpool;
 	struct crypto_acomp_ctx __percpu *acomp_ctx;
 	struct percpu_ref ref;
 	struct list_head list;
@@ -237,7 +234,7 @@ static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
 
 #define zswap_pool_debug(msg, p)				\
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
-		 zpool_get_type((p)->zpools[0]))
+		 zpool_get_type((p)->zpool))
 
 /*********************************
 * pool functions
@@ -246,7 +243,6 @@ static void __zswap_pool_empty(struct percpu_ref *ref);
 
 static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 {
-	int i;
 	struct zswap_pool *pool;
 	char name[38]; /* 'zswap' + 32 char (max) num + \0 */
 	gfp_t gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
@@ -267,18 +263,14 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	if (!pool)
 		return NULL;
 
-	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++) {
-		/* unique name for each pool specifically required by zsmalloc */
-		snprintf(name, 38, "zswap%x",
-			 atomic_inc_return(&zswap_pools_count));
-
-		pool->zpools[i] = zpool_create_pool(type, name, gfp);
-		if (!pool->zpools[i]) {
-			pr_err("%s zpool not available\n", type);
-			goto error;
-		}
+	/* unique name for each pool specifically required by zsmalloc */
+	snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
+	pool->zpool = zpool_create_pool(type, name, gfp);
+	if (!pool->zpool) {
+		pr_err("%s zpool not available\n", type);
+		return NULL;
 	}
-	pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
+	pr_debug("using %s zpool\n", zpool_get_type(pool->zpool));
 
 	strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
 
@@ -311,8 +303,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 error:
 	if (pool->acomp_ctx)
 		free_percpu(pool->acomp_ctx);
-	while (i--)
-		zpool_destroy_pool(pool->zpools[i]);
+	zpool_destroy_pool(pool->zpool);
 	kfree(pool);
 	return NULL;
 }
@@ -361,15 +352,12 @@ static struct zswap_pool *__zswap_pool_create_fallback(void)
 
 static void zswap_pool_destroy(struct zswap_pool *pool)
 {
-	int i;
-
 	zswap_pool_debug("destroying", pool);
 
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
 
-	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
-		zpool_destroy_pool(pool->zpools[i]);
+	zpool_destroy_pool(pool->zpool);
 	kfree(pool);
 }
 
@@ -464,8 +452,7 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	list_for_each_entry_rcu(pool, &zswap_pools, list) {
 		if (strcmp(pool->tfm_name, compressor))
 			continue;
-		/* all zpools share the same type */
-		if (strcmp(zpool_get_type(pool->zpools[0]), type))
+		if (strcmp(zpool_get_type(pool->zpool), type))
 			continue;
 		/* if we can't get it, it's about to be destroyed */
 		if (!zswap_pool_get(pool))
@@ -492,12 +479,8 @@ unsigned long zswap_total_pages(void)
 	unsigned long total = 0;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(pool, &zswap_pools, list) {
-		int i;
-
-		for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
-			total += zpool_get_total_pages(pool->zpools[i]);
-	}
+	list_for_each_entry_rcu(pool, &zswap_pools, list)
+		total += zpool_get_total_pages(pool->zpool);
 	rcu_read_unlock();
 
 	return total;
@@ -802,11 +785,6 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 	kmem_cache_free(zswap_entry_cache, entry);
 }
 
-static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
-{
-	return entry->pool->zpools[hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS))];
-}
-
 /*
  * Carries out the common pattern of freeing and entry's zpool allocation,
  * freeing the entry itself, and decrementing the number of stored pages.
@@ -814,7 +792,7 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
 static void zswap_entry_free(struct zswap_entry *entry)
 {
 	zswap_lru_del(&zswap_list_lru, entry);
-	zpool_free(zswap_find_zpool(entry), entry->handle);
+	zpool_free(entry->pool->zpool, entry->handle);
 	zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
@@ -939,7 +917,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 	if (comp_ret)
 		goto unlock;
 
-	zpool = zswap_find_zpool(entry);
+	zpool = entry->pool->zpool;
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
 	if (zpool_malloc_support_movable(zpool))
 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
@@ -968,7 +946,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 
 static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 {
-	struct zpool *zpool = zswap_find_zpool(entry);
+	struct zpool *zpool = entry->pool->zpool;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
 	u8 *src;
@@ -1467,7 +1445,7 @@ bool zswap_store(struct folio *folio)
 	return true;
 
 store_failed:
-	zpool_free(zswap_find_zpool(entry), entry->handle);
+	zpool_free(entry->pool->zpool, entry->handle);
 put_pool:
 	zswap_pool_put(entry->pool);
 freepage:
@@ -1683,7 +1661,7 @@ static int zswap_setup(void)
 	pool = __zswap_pool_create_fallback();
 	if (pool) {
 		pr_info("loaded using pool %s/%s\n", pool->tfm_name,
-			zpool_get_type(pool->zpools[0]));
+			zpool_get_type(pool->zpool));
 		list_add(&pool->list, &zswap_pools);
 		zswap_has_pool = true;
 		static_branch_enable(&zswap_ever_enabled);

-- 
2.45.2


