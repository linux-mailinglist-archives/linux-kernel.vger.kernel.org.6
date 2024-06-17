Return-Path: <linux-kernel+bounces-217338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB2090AE78
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C92928A015
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD37C197A98;
	Mon, 17 Jun 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rh/ds4HF"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6B197A60
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629114; cv=none; b=YZ8KN+m6DWuBQ/hehBefjCMFzkineg0HkIuarQJBzahwoH/HNZXQEcEvS/8t69coxZkc8BHXwI8MOWmbu+hlif02mqqOlbnJzyXCKueE9Lt45Bh+6zABWi0jvE42rS4MCWk20KQ7XqPisftDcXEYzEt9grKmkD2ErkZ1przug/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629114; c=relaxed/simple;
	bh=nxPgpfzEu6PHlA1VgCoWzm1ZNHnRPxmjOWoBDtPwbP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IyJGnOd7D9aq84kmtEXRo5zow3URO9r/iyoIiGRLsnqUW1Tmd9qxF6UVNg6jF/Y12aS01HpliwpnC2qbqjCk7cujOnP6/5VwvH6pW/PQY2JRZmBh336cqLWnD8/eRXsVmhS8j3zox8kbosaSyVs527DfWxh8PHGNueCRVkHhxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rh/ds4HF; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: zhouchengming@bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718629110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ml+7a7+sCA9GCU+VnA/N3YABoFs4dybvrwc/LO9px24=;
	b=Rh/ds4HFtHdG2NasTqRw2P2yX79eygyZlRfdDrBIrYyBweInv99M+Z2cqeFe+ONpZPCKfZ
	yn25AZ1OqLL2hz7vyiW7DcNqJ5whFFrg5KSIXi4zebEUptplRglWlTpcOIVPgiiacdAIW8
	DbmY9YO/ccwaW7tbpmzJzmm0uQmmH+c=
X-Envelope-To: minchan@kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: senozhatsky@chromium.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: flintglass@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: chengming.zhou@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Mon, 17 Jun 2024 20:57:40 +0800
Subject: [PATCH 1/2] mm/zsmalloc: change back to per-size_class lock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-zsmalloc-lock-mm-everything-v1-1-5e5081ea11b3@linux.dev>
References: <20240617-zsmalloc-lock-mm-everything-v1-0-5e5081ea11b3@linux.dev>
In-Reply-To: <20240617-zsmalloc-lock-mm-everything-v1-0-5e5081ea11b3@linux.dev>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
 Nhat Pham <nphamcs@gmail.com>
Cc: Takero Funaki <flintglass@gmail.com>, 
 Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718629103; l=10472;
 i=chengming.zhou@linux.dev; s=20240617; h=from:subject:message-id;
 bh=9xdd09wl1NsMgUm2kMaXAVzVLK1utv1A55dZZslZink=;
 b=fEwUDedBPmgapXCn1lzZF6Ojk9DUqAFlAU8dxdxL0QiN8Mua/VRedAhjEYYAxOnKnNI4T8Waj
 gwSvu+MQXRkAF13T7A0yNb2hElXgBzG8nLYeWKkLUyO4YJCgRhqpQX1
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=/XPhIutBo+zyUeQyf4Ni5JYk/PEIWxIeUQqy2DYjmhI=
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

This patch is almost the revert of the commit c0547d0b6a4b ("zsmalloc:
consolidate zs_pool's migrate_lock and size_class's locks"), which
changed to use a global pool->lock instead of per-size_class lock and
pool->migrate_lock, was preparation for suppporting reclaim in zsmalloc.
Then reclaim in zsmalloc had been dropped in favor of LRU reclaim in
zswap.

In theory, per-size_class is more fine-grained than the pool->lock,
since a pool can have many size_classes. As for the additional
pool->migrate_lock, only free() and map() need to grab it to access
stable handle to get zspage, and only in read lock mode.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zsmalloc.c | 85 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 44e0171d6003..fec1a39e5bbe 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -34,7 +34,8 @@
 /*
  * lock ordering:
  *	page_lock
- *	pool->lock
+ *	pool->migrate_lock
+ *	class->lock
  *	zspage->lock
  */
 
@@ -183,6 +184,7 @@ static struct dentry *zs_stat_root;
 static size_t huge_class_size;
 
 struct size_class {
+	spinlock_t lock;
 	struct list_head fullness_list[NR_FULLNESS_GROUPS];
 	/*
 	 * Size of objects stored in this class. Must be multiple
@@ -237,7 +239,8 @@ struct zs_pool {
 #ifdef CONFIG_COMPACTION
 	struct work_struct free_work;
 #endif
-	spinlock_t lock;
+	/* protect page/zspage migration */
+	rwlock_t migrate_lock;
 	atomic_t compaction_in_progress;
 };
 
@@ -336,7 +339,7 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
 	kmem_cache_free(pool->zspage_cachep, zspage);
 }
 
-/* pool->lock(which owns the handle) synchronizes races */
+/* class->lock(which owns the handle) synchronizes races */
 static void record_obj(unsigned long handle, unsigned long obj)
 {
 	*(unsigned long *)handle = obj;
@@ -431,7 +434,7 @@ static __maybe_unused int is_first_page(struct page *page)
 	return PagePrivate(page);
 }
 
-/* Protected by pool->lock */
+/* Protected by class->lock */
 static inline int get_zspage_inuse(struct zspage *zspage)
 {
 	return zspage->inuse;
@@ -569,7 +572,7 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 		if (class->index != i)
 			continue;
 
-		spin_lock(&pool->lock);
+		spin_lock(&class->lock);
 
 		seq_printf(s, " %5u %5u ", i, class->size);
 		for (fg = ZS_INUSE_RATIO_10; fg < NR_FULLNESS_GROUPS; fg++) {
@@ -580,7 +583,7 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 		obj_allocated = zs_stat_get(class, ZS_OBJS_ALLOCATED);
 		obj_used = zs_stat_get(class, ZS_OBJS_INUSE);
 		freeable = zs_can_compact(class);
-		spin_unlock(&pool->lock);
+		spin_unlock(&class->lock);
 
 		objs_per_zspage = class->objs_per_zspage;
 		pages_used = obj_allocated / objs_per_zspage *
@@ -837,7 +840,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 {
 	struct page *page, *next;
 
-	assert_spin_locked(&pool->lock);
+	assert_spin_locked(&class->lock);
 
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(zspage->fullness != ZS_INUSE_RATIO_0);
@@ -1196,19 +1199,19 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	BUG_ON(in_interrupt());
 
 	/* It guarantees it can get zspage from handle safely */
-	spin_lock(&pool->lock);
+	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &page, &obj_idx);
 	zspage = get_zspage(page);
 
 	/*
-	 * migration cannot move any zpages in this zspage. Here, pool->lock
+	 * migration cannot move any zpages in this zspage. Here, class->lock
 	 * is too heavy since callers would take some time until they calls
 	 * zs_unmap_object API so delegate the locking from class to zspage
 	 * which is smaller granularity.
 	 */
 	migrate_read_lock(zspage);
-	spin_unlock(&pool->lock);
+	read_unlock(&pool->migrate_lock);
 
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
@@ -1364,8 +1367,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	size += ZS_HANDLE_SIZE;
 	class = pool->size_class[get_size_class_index(size)];
 
-	/* pool->lock effectively protects the zpage migration */
-	spin_lock(&pool->lock);
+	/* class->lock effectively protects the zpage migration */
+	spin_lock(&class->lock);
 	zspage = find_get_zspage(class);
 	if (likely(zspage)) {
 		obj = obj_malloc(pool, zspage, handle);
@@ -1377,7 +1380,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		goto out;
 	}
 
-	spin_unlock(&pool->lock);
+	spin_unlock(&class->lock);
 
 	zspage = alloc_zspage(pool, class, gfp);
 	if (!zspage) {
@@ -1385,7 +1388,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		return (unsigned long)ERR_PTR(-ENOMEM);
 	}
 
-	spin_lock(&pool->lock);
+	spin_lock(&class->lock);
 	obj = obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
@@ -1397,7 +1400,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
 out:
-	spin_unlock(&pool->lock);
+	spin_unlock(&class->lock);
 
 	return handle;
 }
@@ -1442,14 +1445,16 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 		return;
 
 	/*
-	 * The pool->lock protects the race with zpage's migration
+	 * The pool->migrate_lock protects the race with zpage's migration
 	 * so it's safe to get the page from handle.
 	 */
-	spin_lock(&pool->lock);
+	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_page(obj, &f_page);
 	zspage = get_zspage(f_page);
 	class = zspage_class(pool, zspage);
+	spin_lock(&class->lock);
+	read_unlock(&pool->migrate_lock);
 
 	class_stat_dec(class, ZS_OBJS_INUSE, 1);
 	obj_free(class->size, obj);
@@ -1458,7 +1463,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	if (fullness == ZS_INUSE_RATIO_0)
 		free_zspage(pool, class, zspage);
 
-	spin_unlock(&pool->lock);
+	spin_unlock(&class->lock);
 	cache_free_handle(pool, handle);
 }
 EXPORT_SYMBOL_GPL(zs_free);
@@ -1780,12 +1785,16 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	pool = zspage->pool;
 
 	/*
-	 * The pool's lock protects the race between zpage migration
+	 * The pool migrate_lock protects the race between zpage migration
 	 * and zs_free.
 	 */
-	spin_lock(&pool->lock);
+	write_lock(&pool->migrate_lock);
 	class = zspage_class(pool, zspage);
 
+	/*
+	 * the class lock protects zpage alloc/free in the zspage.
+	 */
+	spin_lock(&class->lock);
 	/* the migrate_write_lock protects zpage access via zs_map_object */
 	migrate_write_lock(zspage);
 
@@ -1815,9 +1824,10 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	replace_sub_page(class, zspage, newpage, page);
 	/*
 	 * Since we complete the data copy and set up new zspage structure,
-	 * it's okay to release the pool's lock.
+	 * it's okay to release migration_lock.
 	 */
-	spin_unlock(&pool->lock);
+	write_unlock(&pool->migrate_lock);
+	spin_unlock(&class->lock);
 	migrate_write_unlock(zspage);
 
 	get_page(newpage);
@@ -1861,20 +1871,20 @@ static void async_free_zspage(struct work_struct *work)
 		if (class->index != i)
 			continue;
 
-		spin_lock(&pool->lock);
+		spin_lock(&class->lock);
 		list_splice_init(&class->fullness_list[ZS_INUSE_RATIO_0],
 				 &free_pages);
-		spin_unlock(&pool->lock);
+		spin_unlock(&class->lock);
 	}
 
 	list_for_each_entry_safe(zspage, tmp, &free_pages, list) {
 		list_del(&zspage->list);
 		lock_zspage(zspage);
 
-		spin_lock(&pool->lock);
 		class = zspage_class(pool, zspage);
+		spin_lock(&class->lock);
 		__free_zspage(pool, class, zspage);
-		spin_unlock(&pool->lock);
+		spin_unlock(&class->lock);
 	}
 };
 
@@ -1938,7 +1948,8 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	 * protect the race between zpage migration and zs_free
 	 * as well as zpage allocation/free
 	 */
-	spin_lock(&pool->lock);
+	write_lock(&pool->migrate_lock);
+	spin_lock(&class->lock);
 	while (zs_can_compact(class)) {
 		int fg;
 
@@ -1964,13 +1975,15 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		src_zspage = NULL;
 
 		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
-		    || spin_is_contended(&pool->lock)) {
+		    || rwlock_is_contended(&pool->migrate_lock)) {
 			putback_zspage(class, dst_zspage);
 			dst_zspage = NULL;
 
-			spin_unlock(&pool->lock);
+			spin_unlock(&class->lock);
+			write_unlock(&pool->migrate_lock);
 			cond_resched();
-			spin_lock(&pool->lock);
+			write_lock(&pool->migrate_lock);
+			spin_lock(&class->lock);
 		}
 	}
 
@@ -1980,7 +1993,8 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	if (dst_zspage)
 		putback_zspage(class, dst_zspage);
 
-	spin_unlock(&pool->lock);
+	spin_unlock(&class->lock);
+	write_unlock(&pool->migrate_lock);
 
 	return pages_freed;
 }
@@ -1992,10 +2006,10 @@ unsigned long zs_compact(struct zs_pool *pool)
 	unsigned long pages_freed = 0;
 
 	/*
-	 * Pool compaction is performed under pool->lock so it is basically
+	 * Pool compaction is performed under pool->migrate_lock so it is basically
 	 * single-threaded. Having more than one thread in __zs_compact()
-	 * will increase pool->lock contention, which will impact other
-	 * zsmalloc operations that need pool->lock.
+	 * will increase pool->migrate_lock contention, which will impact other
+	 * zsmalloc operations that need pool->migrate_lock.
 	 */
 	if (atomic_xchg(&pool->compaction_in_progress, 1))
 		return 0;
@@ -2117,7 +2131,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		return NULL;
 
 	init_deferred_free(pool);
-	spin_lock_init(&pool->lock);
+	rwlock_init(&pool->migrate_lock);
 	atomic_set(&pool->compaction_in_progress, 0);
 
 	pool->name = kstrdup(name, GFP_KERNEL);
@@ -2189,6 +2203,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		class->index = i;
 		class->pages_per_zspage = pages_per_zspage;
 		class->objs_per_zspage = objs_per_zspage;
+		spin_lock_init(&class->lock);
 		pool->size_class[i] = class;
 
 		fullness = ZS_INUSE_RATIO_0;

-- 
2.45.2


