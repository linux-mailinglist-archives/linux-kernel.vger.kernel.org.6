Return-Path: <linux-kernel+bounces-546145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11264A4F6E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36A5188F6DF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21AB1E5B91;
	Wed,  5 Mar 2025 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DPgCSaJ/"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89681EB5E2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741155125; cv=none; b=Jak38rJ0MogCtseuqRmlVnVgP8dGdBTeI95Qfd6eLbXQFpWmUGdBMCmqKhDmhJVQsGygH6pakpXHxiMpoJnCtyNHBrqnitZsziv0sER+63XcL0kpxtLM7bydV7BUW0y0exsKWIdcownbhrQnTtcR0/8NiR+lsBfAn80gJj14JNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741155125; c=relaxed/simple;
	bh=rahTlPA4fhyOL+7WCtjNfdiNljfZiTw4NJF1j/mtp6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNsQrU71kOHGumggfwiYRSzXq1VNd7i6H1TsA03nR4bNZ1rrcqQv2K9nsTfv1RCzOc/1k3j40YeXhId+TrmlltuNmH99yfLFsS+kkOvPrQH/6jzfA2m5X3xCfu0SZtBPPnrccuhwsOR+K64MT7/3lGOj7h5Pxd1X/Dx6vZxFuzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DPgCSaJ/; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741155120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UhZJAb1vZBDPQY5aPuGxl/Pfa74mD9bb2pPv2uBSEcA=;
	b=DPgCSaJ/EaFB1ZPc4t8mnBIpN7oy4lyB/ivsJgKQV4J6SBrrL1VJ2bzJKbPWx7oEYaAdAP
	AvVxq2FW40CADY65HpTsCGZ2pmHpSN7reiPmd3wmk5mJ5NFTrsrdZiXnZAnAugXiQjRho0
	YuH9Xb3Uy2bVT7lqBMekm5VcHRL+QnE=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH mm-unstable 4/5] mm: zsmalloc: Remove object mapping APIs and per-CPU map areas
Date: Wed,  5 Mar 2025 06:11:32 +0000
Message-ID: <20250305061134.4105762-5-yosry.ahmed@linux.dev>
In-Reply-To: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

zs_map_object() and zs_unmap_object() are no longer used, remove them.
Since these are the only users of per-CPU mapping_areas, remove them and
the associated CPU hotplug callbacks too.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 include/linux/cpuhotplug.h |   1 -
 include/linux/zsmalloc.h   |  21 ----
 mm/zsmalloc.c              | 226 +------------------------------------
 3 files changed, 1 insertion(+), 247 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 6cc5e484547c1..1987400000b41 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -116,7 +116,6 @@ enum cpuhp_state {
 	CPUHP_NET_IUCV_PREPARE,
 	CPUHP_ARM_BL_PREPARE,
 	CPUHP_TRACE_RB_PREPARE,
-	CPUHP_MM_ZS_PREPARE,
 	CPUHP_MM_ZSWP_POOL_PREPARE,
 	CPUHP_KVM_PPC_BOOK3S_PREPARE,
 	CPUHP_ZCOMP_PREPARE,
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 7d70983cf3980..c26baf9fb331b 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -16,23 +16,6 @@
 
 #include <linux/types.h>
 
-/*
- * zsmalloc mapping modes
- *
- * NOTE: These only make a difference when a mapped object spans pages.
- */
-enum zs_mapmode {
-	ZS_MM_RW, /* normal read-write mapping */
-	ZS_MM_RO, /* read-only (no copy-out at unmap time) */
-	ZS_MM_WO /* write-only (no copy-in at map time) */
-	/*
-	 * NOTE: ZS_MM_WO should only be used for initializing new
-	 * (uninitialized) allocations.  Partial writes to already
-	 * initialized allocations should use ZS_MM_RW to preserve the
-	 * existing data.
-	 */
-};
-
 struct zs_pool_stats {
 	/* How many pages were migrated (freed) */
 	atomic_long_t pages_compacted;
@@ -48,10 +31,6 @@ void zs_free(struct zs_pool *pool, unsigned long obj);
 
 size_t zs_huge_class_size(struct zs_pool *pool);
 
-void *zs_map_object(struct zs_pool *pool, unsigned long handle,
-			enum zs_mapmode mm);
-void zs_unmap_object(struct zs_pool *pool, unsigned long handle);
-
 unsigned long zs_get_total_pages(struct zs_pool *pool);
 unsigned long zs_compact(struct zs_pool *pool);
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 56d6ed5c675b2..cd1c2a8ffef05 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -281,13 +281,6 @@ struct zspage {
 	struct zspage_lock zsl;
 };
 
-struct mapping_area {
-	local_lock_t lock;
-	char *vm_buf; /* copy buffer for objects that span pages */
-	char *vm_addr; /* address of kmap_local_page()'ed pages */
-	enum zs_mapmode vm_mm; /* mapping mode */
-};
-
 static void zspage_lock_init(struct zspage *zspage)
 {
 	static struct lock_class_key __key;
@@ -522,11 +515,6 @@ static struct zpool_driver zs_zpool_driver = {
 MODULE_ALIAS("zpool-zsmalloc");
 #endif /* CONFIG_ZPOOL */
 
-/* per-cpu VM mapping areas for zspage accesses that cross page boundaries */
-static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
-	.lock	= INIT_LOCAL_LOCK(lock),
-};
-
 static inline bool __maybe_unused is_first_zpdesc(struct zpdesc *zpdesc)
 {
 	return PagePrivate(zpdesc_page(zpdesc));
@@ -1111,93 +1099,6 @@ static struct zspage *find_get_zspage(struct size_class *class)
 	return zspage;
 }
 
-static inline int __zs_cpu_up(struct mapping_area *area)
-{
-	/*
-	 * Make sure we don't leak memory if a cpu UP notification
-	 * and zs_init() race and both call zs_cpu_up() on the same cpu
-	 */
-	if (area->vm_buf)
-		return 0;
-	area->vm_buf = kmalloc(ZS_MAX_ALLOC_SIZE, GFP_KERNEL);
-	if (!area->vm_buf)
-		return -ENOMEM;
-	return 0;
-}
-
-static inline void __zs_cpu_down(struct mapping_area *area)
-{
-	kfree(area->vm_buf);
-	area->vm_buf = NULL;
-}
-
-static void *__zs_map_object(struct mapping_area *area,
-			struct zpdesc *zpdescs[2], int off, int size)
-{
-	size_t sizes[2];
-	char *buf = area->vm_buf;
-
-	/* disable page faults to match kmap_local_page() return conditions */
-	pagefault_disable();
-
-	/* no read fastpath */
-	if (area->vm_mm == ZS_MM_WO)
-		goto out;
-
-	sizes[0] = PAGE_SIZE - off;
-	sizes[1] = size - sizes[0];
-
-	/* copy object to per-cpu buffer */
-	memcpy_from_page(buf, zpdesc_page(zpdescs[0]), off, sizes[0]);
-	memcpy_from_page(buf + sizes[0], zpdesc_page(zpdescs[1]), 0, sizes[1]);
-out:
-	return area->vm_buf;
-}
-
-static void __zs_unmap_object(struct mapping_area *area,
-			struct zpdesc *zpdescs[2], int off, int size)
-{
-	size_t sizes[2];
-	char *buf;
-
-	/* no write fastpath */
-	if (area->vm_mm == ZS_MM_RO)
-		goto out;
-
-	buf = area->vm_buf;
-	buf = buf + ZS_HANDLE_SIZE;
-	size -= ZS_HANDLE_SIZE;
-	off += ZS_HANDLE_SIZE;
-
-	sizes[0] = PAGE_SIZE - off;
-	sizes[1] = size - sizes[0];
-
-	/* copy per-cpu buffer to object */
-	memcpy_to_page(zpdesc_page(zpdescs[0]), off, buf, sizes[0]);
-	memcpy_to_page(zpdesc_page(zpdescs[1]), 0, buf + sizes[0], sizes[1]);
-
-out:
-	/* enable page faults to match kunmap_local() return conditions */
-	pagefault_enable();
-}
-
-static int zs_cpu_prepare(unsigned int cpu)
-{
-	struct mapping_area *area;
-
-	area = &per_cpu(zs_map_area, cpu);
-	return __zs_cpu_up(area);
-}
-
-static int zs_cpu_dead(unsigned int cpu)
-{
-	struct mapping_area *area;
-
-	area = &per_cpu(zs_map_area, cpu);
-	__zs_cpu_down(area);
-	return 0;
-}
-
 static bool can_merge(struct size_class *prev, int pages_per_zspage,
 					int objs_per_zspage)
 {
@@ -1245,117 +1146,6 @@ unsigned long zs_get_total_pages(struct zs_pool *pool)
 }
 EXPORT_SYMBOL_GPL(zs_get_total_pages);
 
-/**
- * zs_map_object - get address of allocated object from handle.
- * @pool: pool from which the object was allocated
- * @handle: handle returned from zs_malloc
- * @mm: mapping mode to use
- *
- * Before using an object allocated from zs_malloc, it must be mapped using
- * this function. When done with the object, it must be unmapped using
- * zs_unmap_object.
- *
- * Only one object can be mapped per cpu at a time. There is no protection
- * against nested mappings.
- *
- * This function returns with preemption and page faults disabled.
- */
-void *zs_map_object(struct zs_pool *pool, unsigned long handle,
-			enum zs_mapmode mm)
-{
-	struct zspage *zspage;
-	struct zpdesc *zpdesc;
-	unsigned long obj, off;
-	unsigned int obj_idx;
-
-	struct size_class *class;
-	struct mapping_area *area;
-	struct zpdesc *zpdescs[2];
-	void *ret;
-
-	/*
-	 * Because we use per-cpu mapping areas shared among the
-	 * pools/users, we can't allow mapping in interrupt context
-	 * because it can corrupt another users mappings.
-	 */
-	BUG_ON(in_interrupt());
-
-	/* It guarantees it can get zspage from handle safely */
-	read_lock(&pool->lock);
-	obj = handle_to_obj(handle);
-	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc);
-
-	/*
-	 * migration cannot move any zpages in this zspage. Here, class->lock
-	 * is too heavy since callers would take some time until they calls
-	 * zs_unmap_object API so delegate the locking from class to zspage
-	 * which is smaller granularity.
-	 */
-	zspage_read_lock(zspage);
-	read_unlock(&pool->lock);
-
-	class = zspage_class(pool, zspage);
-	off = offset_in_page(class->size * obj_idx);
-
-	local_lock(&zs_map_area.lock);
-	area = this_cpu_ptr(&zs_map_area);
-	area->vm_mm = mm;
-	if (off + class->size <= PAGE_SIZE) {
-		/* this object is contained entirely within a page */
-		area->vm_addr = kmap_local_zpdesc(zpdesc);
-		ret = area->vm_addr + off;
-		goto out;
-	}
-
-	/* this object spans two pages */
-	zpdescs[0] = zpdesc;
-	zpdescs[1] = get_next_zpdesc(zpdesc);
-	BUG_ON(!zpdescs[1]);
-
-	ret = __zs_map_object(area, zpdescs, off, class->size);
-out:
-	if (likely(!ZsHugePage(zspage)))
-		ret += ZS_HANDLE_SIZE;
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(zs_map_object);
-
-void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
-{
-	struct zspage *zspage;
-	struct zpdesc *zpdesc;
-	unsigned long obj, off;
-	unsigned int obj_idx;
-
-	struct size_class *class;
-	struct mapping_area *area;
-
-	obj = handle_to_obj(handle);
-	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc);
-	class = zspage_class(pool, zspage);
-	off = offset_in_page(class->size * obj_idx);
-
-	area = this_cpu_ptr(&zs_map_area);
-	if (off + class->size <= PAGE_SIZE)
-		kunmap_local(area->vm_addr);
-	else {
-		struct zpdesc *zpdescs[2];
-
-		zpdescs[0] = zpdesc;
-		zpdescs[1] = get_next_zpdesc(zpdesc);
-		BUG_ON(!zpdescs[1]);
-
-		__zs_unmap_object(area, zpdescs, off, class->size);
-	}
-	local_unlock(&zs_map_area.lock);
-
-	zspage_read_unlock(zspage);
-}
-EXPORT_SYMBOL_GPL(zs_unmap_object);
-
 void *zs_obj_read_begin(struct zs_pool *pool, unsigned long handle,
 			void *local_copy)
 {
@@ -1975,7 +1765,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 * the class lock protects zpage alloc/free in the zspage.
 	 */
 	spin_lock(&class->lock);
-	/* the zspage write_lock protects zpage access via zs_map_object */
+	/* the zspage write_lock protects zpage access via zs_obj_read/write() */
 	if (!zspage_write_trylock(zspage)) {
 		spin_unlock(&class->lock);
 		write_unlock(&pool->lock);
@@ -2459,23 +2249,11 @@ EXPORT_SYMBOL_GPL(zs_destroy_pool);
 
 static int __init zs_init(void)
 {
-	int ret;
-
-	ret = cpuhp_setup_state(CPUHP_MM_ZS_PREPARE, "mm/zsmalloc:prepare",
-				zs_cpu_prepare, zs_cpu_dead);
-	if (ret)
-		goto out;
-
 #ifdef CONFIG_ZPOOL
 	zpool_register_driver(&zs_zpool_driver);
 #endif
-
 	zs_stat_init();
-
 	return 0;
-
-out:
-	return ret;
 }
 
 static void __exit zs_exit(void)
@@ -2483,8 +2261,6 @@ static void __exit zs_exit(void)
 #ifdef CONFIG_ZPOOL
 	zpool_unregister_driver(&zs_zpool_driver);
 #endif
-	cpuhp_remove_state(CPUHP_MM_ZS_PREPARE);
-
 	zs_stat_exit();
 }
 
-- 
2.48.1.711.g2feabab25a-goog


