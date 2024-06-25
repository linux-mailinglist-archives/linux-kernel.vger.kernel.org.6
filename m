Return-Path: <linux-kernel+bounces-228292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5425B915DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775D31C216FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3D31428EF;
	Tue, 25 Jun 2024 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AOkVmtul"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDAD13C9CB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719290425; cv=none; b=uNumJOWqrlisnx2IGse6eggFzAKMcjDq7QXKhHcy8kgbVkZawaxC7KjEv5zpIopPNcTAWSN9mHdp9cKBUIG+/+IZTudHorGsbSX2PhwbvYQFVcZyU4yhtlFoDW3i0VA1kaursRN2uhqErtSywZWlEYnpdT4XUYRos2MY3ScroP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719290425; c=relaxed/simple;
	bh=Li6utiV8HVZ7YSsEACMojJqnpxw6KkasIDNGae+iQXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lj3DljasE6rjBkgAOFut1xNTYigARtOfUPBOlPk9ruxhOGyL2zxz7lvyLT+SkqAaGEDWarmK5oeL5C5sldGbDYmSUOxSdJAcARvYrpZTD7FtPD/EGYsygZKP+L6Su3o/8ueRI9+UszbOSq10kvAWlpOQsD5Pic1vBOhOzusYbT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AOkVmtul; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: senozhatsky@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719290420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pKGIJo4HSuKfU0M2K9Y5VwTqoEGcxmVdtjuLcedzYo=;
	b=AOkVmtulbKI3rbFIw1xAiYiBgbkMVJdCaJ7TFNgcZv6E0KTyy/RBcAQhfAIVgASUlPEvN9
	pY7IEJ2oVy97AKK8/sLGyAm/Lm7/aJpxJOmD+hO3mHHN9TkhmL+DOJk29gmjy/022I+KAc
	VZKrXe9gsRh/Ate616bzqebyFzNZ6p4=
X-Envelope-To: yuzhao@google.com
X-Envelope-To: flintglass@gmail.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: dan.carpenter@linaro.org
X-Envelope-To: minchan@kernel.org
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Tue, 25 Jun 2024 12:39:05 +0800
Subject: [PATCH v3 2/2] mm/zswap: use only one pool in zswap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-zsmalloc-lock-mm-everything-v3-2-ad941699cb61@linux.dev>
References: <20240625-zsmalloc-lock-mm-everything-v3-0-ad941699cb61@linux.dev>
In-Reply-To: <20240625-zsmalloc-lock-mm-everything-v3-0-ad941699cb61@linux.dev>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
 Nhat Pham <nphamcs@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>, Takero Funaki <flintglass@gmail.com>, 
 Chengming Zhou <zhouchengming@bytedance.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719290409; l=7705;
 i=chengming.zhou@linux.dev; s=20240617; h=from:subject:message-id;
 bh=Li6utiV8HVZ7YSsEACMojJqnpxw6KkasIDNGae+iQXY=;
 b=W1FR1Om9LTDEopO4RnmakTN3dtL10nv7yqtsg3qk290QpnITS9zGqJFjFfLC+ucvcOOzLOn0Z
 zR8NLvUy1+lA9+P4khbvc00fWDZ5hV14gl9MkX8jKE+21DsXNTEyD8i
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
 mm/zswap.c | 61 ++++++++++++++++++++-----------------------------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index e25a6808c2ed..5bb5a34a28e8 100644
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
+		goto error;
 	}
-	pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
+	pr_debug("using %s zpool\n", zpool_get_type(pool->zpool));
 
 	strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
 
@@ -311,8 +303,8 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 error:
 	if (pool->acomp_ctx)
 		free_percpu(pool->acomp_ctx);
-	while (i--)
-		zpool_destroy_pool(pool->zpools[i]);
+	if (pool->zpool)
+		zpool_destroy_pool(pool->zpool);
 	kfree(pool);
 	return NULL;
 }
@@ -361,15 +353,12 @@ static struct zswap_pool *__zswap_pool_create_fallback(void)
 
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
 
@@ -464,8 +453,7 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	list_for_each_entry_rcu(pool, &zswap_pools, list) {
 		if (strcmp(pool->tfm_name, compressor))
 			continue;
-		/* all zpools share the same type */
-		if (strcmp(zpool_get_type(pool->zpools[0]), type))
+		if (strcmp(zpool_get_type(pool->zpool), type))
 			continue;
 		/* if we can't get it, it's about to be destroyed */
 		if (!zswap_pool_get(pool))
@@ -492,12 +480,8 @@ unsigned long zswap_total_pages(void)
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
@@ -802,11 +786,6 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
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
@@ -814,7 +793,7 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
 static void zswap_entry_free(struct zswap_entry *entry)
 {
 	zswap_lru_del(&zswap_list_lru, entry);
-	zpool_free(zswap_find_zpool(entry), entry->handle);
+	zpool_free(entry->pool->zpool, entry->handle);
 	zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
@@ -939,7 +918,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 	if (comp_ret)
 		goto unlock;
 
-	zpool = zswap_find_zpool(entry);
+	zpool = entry->pool->zpool;
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
 	if (zpool_malloc_support_movable(zpool))
 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
@@ -968,7 +947,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 
 static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 {
-	struct zpool *zpool = zswap_find_zpool(entry);
+	struct zpool *zpool = entry->pool->zpool;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
 	u8 *src;
@@ -1467,7 +1446,7 @@ bool zswap_store(struct folio *folio)
 	return true;
 
 store_failed:
-	zpool_free(zswap_find_zpool(entry), entry->handle);
+	zpool_free(entry->pool->zpool, entry->handle);
 put_pool:
 	zswap_pool_put(entry->pool);
 freepage:
@@ -1683,7 +1662,7 @@ static int zswap_setup(void)
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


