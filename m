Return-Path: <linux-kernel+bounces-548206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D331A5419C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5727716D2C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24B319AD70;
	Thu,  6 Mar 2025 04:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="qPLl2jqO"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF718C337
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741234803; cv=none; b=Y3YFq0LGSFocxRkFX0SlIxOTzRtv78wKlEmk8HDpJmYPbz1Nlns/2d428ZysBvicviEtIJgKTzAm8yKFgzQyIvg7wmSgWoA+7n7aXi8rWAoE98qqDWt41Ay0/sENzbduN2nrjc7sScop4j3qhlqj8EId6BC7ykjoxW9w5TpbjNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741234803; c=relaxed/simple;
	bh=rSdBIjiN+L5xAcoEytivrG/VsBzu8ZKoYf5oxMGygVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdfYzcHTisLyhIWsNQ4SH1Uv1/5bY2Gs0yvPpDz38s6DkM+j/jx8w7GKeBWC0DOHCGunNKb9XEAvrI/VZaeVBvv+l6evRmn7CWGi7AHgItTmhnoydzyaIY6dt2TLi5cPMucXjiqFTkP7/FrD4t5Qmu4na+aepDjuuHgmc1HOJoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=qPLl2jqO; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=L4ZGpeQMYuwcpq+BSTDZhILpfs5srr9kd9gzTHKEfqU=; b=qPLl2jqOVCZ3fFWN+WeBYoBWCM
	cYXf+RlqALt7qZNTxT2obCFfruXhwjHg1x/OIEbhp9oz7r73q+HUGm6fnZTzCueGHZDBRI6doS2tz
	Laje3Q1LcTQFkEWk8sEawHc7fIiggmO0dzKIfcHlEDmqZmow3r5Nmtk/v1h94KEGyq1g8Twe2z6hh
	JTf1l9ooiNKAVx1mOV6dTHiDTr+rBQBak0lpmAqd0WaIuI5/BnJryfJDvSG6r/IrNYyBnikza5rTR
	UD3eyObLWMcZq0Go5NoWOi7oNctavjlAHBtCDJ+k87V19NjDeJfm+M3kaN9eJli/q39f83X1PtNmB
	tObk7ewQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tq2hb-004Atu-24;
	Thu, 06 Mar 2025 12:19:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 06 Mar 2025 12:19:19 +0800
Date: Thu, 6 Mar 2025 12:19:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 3/5] mm: zpool: Remove object mapping APIs
Message-ID: <Z8kiRym1hS9fB2mE@gondor.apana.org.au>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-4-yosry.ahmed@linux.dev>
 <Z8j_Ct0hTwAnd2-w@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8j_Ct0hTwAnd2-w@gondor.apana.org.au>

On Thu, Mar 06, 2025 at 09:48:58AM +0800, Herbert Xu wrote:
>
> This patch breaks zbud and z3fold because they haven't been converted
> to the new interface.

I've rebased my zswap SG patch on top of your series.  I've removed
all the mapping code from zpool/zsmalloc and pushed it out to zram
instead.

This patch depends on a new memcpy_sglist function which I've just
posted a patch for:

https://patchwork.kernel.org/project/linux-crypto/patch/Z8kXhLb681E_FLzs@gondor.apana.org.au/

From a77ee529b831e7e606ed2a5b723b74ce234a3915 Mon Sep 17 00:00:00 2001
From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 6 Mar 2025 12:13:58 +0800
Subject: [PATCH] mm: zswap: Give non-linear objects to Crypto API

Instead of copying non-linear objects into a buffer, use the
scatterlist to give them directly to the Crypto API.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/block/zram/zram_drv.c |  58 ++++++++++++----
 include/linux/zpool.h         |  26 +++----
 include/linux/zsmalloc.h      |  11 ++-
 mm/z3fold.c                   |  17 +++--
 mm/zbud.c                     |  45 +++++++------
 mm/zpool.c                    |  54 ++++++---------
 mm/zsmalloc.c                 | 123 +++++++---------------------------
 mm/zswap.c                    |  35 +++-------
 8 files changed, 148 insertions(+), 221 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fda7d8624889..d72becec534d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -15,6 +15,7 @@
 #define KMSG_COMPONENT "zram"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
+#include <crypto/scatterwalk.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/bio.h>
@@ -23,6 +24,7 @@
 #include <linux/buffer_head.h>
 #include <linux/device.h>
 #include <linux/highmem.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/string.h>
@@ -1559,21 +1561,23 @@ static int read_same_filled_page(struct zram *zram, struct page *page,
 static int read_incompressible_page(struct zram *zram, struct page *page,
 				    u32 index)
 {
+	struct scatterlist output[1];
+	struct scatterlist input[2];
 	unsigned long handle;
-	void *src, *dst;
 
+	sg_init_table(output, 1);
+	sg_set_page(output, page, PAGE_SIZE, 0);
 	handle = zram_get_handle(zram, index);
-	src = zs_obj_read_begin(zram->mem_pool, handle, NULL);
-	dst = kmap_local_page(page);
-	copy_page(dst, src);
-	kunmap_local(dst);
-	zs_obj_read_end(zram->mem_pool, handle, src);
+	zs_pin_object(zram->mem_pool, handle, input);
+	memcpy_sglist(output, input, PAGE_SIZE);
+	zs_unpin_object(zram->mem_pool, handle);
 
 	return 0;
 }
 
 static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
 {
+	struct scatterlist input[2];
 	struct zcomp_strm *zstrm;
 	unsigned long handle;
 	unsigned int size;
@@ -1585,11 +1589,22 @@ static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
 	prio = zram_get_priority(zram, index);
 
 	zstrm = zcomp_stream_get(zram->comps[prio]);
-	src = zs_obj_read_begin(zram->mem_pool, handle, zstrm->local_copy);
+	zs_pin_object(zram->mem_pool, handle, input);
+	if (sg_is_last(input)) {
+		unsigned int offset = input[0].offset;
+
+		src = kmap_local_page(sg_page(input) + (offset >> PAGE_SHIFT));
+		src += offset_in_page(offset);
+	} else {
+		memcpy_from_sglist(zstrm->local_copy, input, 0, size);
+		src = zstrm->local_copy;
+	}
 	dst = kmap_local_page(page);
 	ret = zcomp_decompress(zram->comps[prio], zstrm, src, size, dst);
 	kunmap_local(dst);
-	zs_obj_read_end(zram->mem_pool, handle, src);
+	if (sg_is_last(input))
+		kunmap_local(src);
+	zs_unpin_object(zram->mem_pool, handle);
 	zcomp_stream_put(zstrm);
 
 	return ret;
@@ -1684,8 +1699,9 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 static int write_incompressible_page(struct zram *zram, struct page *page,
 				     u32 index)
 {
+	struct scatterlist output[2];
+	struct scatterlist input[1];
 	unsigned long handle;
-	void *src;
 
 	/*
 	 * This function is called from preemptible context so we don't need
@@ -1703,9 +1719,11 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 		return -ENOMEM;
 	}
 
-	src = kmap_local_page(page);
-	zs_obj_write(zram->mem_pool, handle, src, PAGE_SIZE);
-	kunmap_local(src);
+	sg_init_table(input, 1);
+	sg_set_page(input, page, PAGE_SIZE, 0);
+	zs_pin_object(zram->mem_pool, handle, output);
+	memcpy_sglist(output, input, PAGE_SIZE);
+	zs_unpin_object(zram->mem_pool, handle);
 
 	zram_slot_lock(zram, index);
 	zram_set_flag(zram, index, ZRAM_HUGE);
@@ -1723,6 +1741,8 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 
 static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 {
+	struct scatterlist output[2];
+	struct scatterlist input[1];
 	int ret = 0;
 	unsigned long handle;
 	unsigned int comp_len;
@@ -1773,7 +1793,11 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		return -ENOMEM;
 	}
 
-	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
+	sg_init_table(input, 1);
+	sg_set_buf(input, zstrm->buffer, comp_len);
+	zs_pin_object(zram->mem_pool, handle, output);
+	memcpy_sglist(output, input, comp_len);
+	zs_unpin_object(zram->mem_pool, handle);
 	zcomp_stream_put(zstrm);
 
 	zram_slot_lock(zram, index);
@@ -1872,6 +1896,8 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 			   u64 *num_recomp_pages, u32 threshold, u32 prio,
 			   u32 prio_max)
 {
+	struct scatterlist output[2];
+	struct scatterlist input[1];
 	struct zcomp_strm *zstrm = NULL;
 	unsigned long handle_old;
 	unsigned long handle_new;
@@ -1990,7 +2016,11 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		return PTR_ERR((void *)handle_new);
 	}
 
-	zs_obj_write(zram->mem_pool, handle_new, zstrm->buffer, comp_len_new);
+	sg_init_table(input, 1);
+	sg_set_buf(input, zstrm->buffer, comp_len_new);
+	zs_pin_object(zram->mem_pool, handle_new, output);
+	memcpy_sglist(output, input, comp_len_new);
+	zs_unpin_object(zram->mem_pool, handle_new);
 	zcomp_stream_put(zstrm);
 
 	zram_free_page(zram, index);
diff --git a/include/linux/zpool.h b/include/linux/zpool.h
index a976f1962cc7..2beb0b7c82e2 100644
--- a/include/linux/zpool.h
+++ b/include/linux/zpool.h
@@ -12,6 +12,7 @@
 #ifndef _ZPOOL_H_
 #define _ZPOOL_H_
 
+struct scatterlist;
 struct zpool;
 
 bool zpool_has_pool(char *type);
@@ -27,14 +28,10 @@ int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
 
 void zpool_free(struct zpool *pool, unsigned long handle);
 
-void *zpool_obj_read_begin(struct zpool *zpool, unsigned long handle,
-			   void *local_copy);
+void zpool_pin_handle(struct zpool *pool, unsigned long handle,
+		      struct scatterlist *sg);
 
-void zpool_obj_read_end(struct zpool *zpool, unsigned long handle,
-			void *handle_mem);
-
-void zpool_obj_write(struct zpool *zpool, unsigned long handle,
-		     void *handle_mem, size_t mem_len);
+void zpool_unpin_handle(struct zpool *pool, unsigned long handle);
 
 u64 zpool_get_total_pages(struct zpool *pool);
 
@@ -47,9 +44,8 @@ u64 zpool_get_total_pages(struct zpool *pool);
  * @destroy:	destroy a pool.
  * @malloc:	allocate mem from a pool.
  * @free:	free mem from a pool.
- * @sleep_mapped: whether zpool driver can sleep during map.
- * @map:	map a handle.
- * @unmap:	unmap a handle.
+ * @pin:	pin a handle and write it into a two-entry SG list.
+ * @unpin:	unpin a handle.
  * @total_size:	get total size of a pool.
  *
  * This is created by a zpool implementation and registered
@@ -68,12 +64,8 @@ struct zpool_driver {
 				unsigned long *handle);
 	void (*free)(void *pool, unsigned long handle);
 
-	void *(*obj_read_begin)(void *pool, unsigned long handle,
-				void *local_copy);
-	void (*obj_read_end)(void *pool, unsigned long handle,
-			     void *handle_mem);
-	void (*obj_write)(void *pool, unsigned long handle,
-			  void *handle_mem, size_t mem_len);
+	void (*pin)(void *pool, unsigned long handle, struct scatterlist *sg);
+	void (*unpin)(void *pool, unsigned long handle);
 
 	u64 (*total_pages)(void *pool);
 };
@@ -82,6 +74,4 @@ void zpool_register_driver(struct zpool_driver *driver);
 
 int zpool_unregister_driver(struct zpool_driver *driver);
 
-bool zpool_can_sleep_mapped(struct zpool *pool);
-
 #endif
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index c26baf9fb331..fba57a792153 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -16,6 +16,8 @@
 
 #include <linux/types.h>
 
+struct scatterlist;
+
 struct zs_pool_stats {
 	/* How many pages were migrated (freed) */
 	atomic_long_t pages_compacted;
@@ -38,11 +40,8 @@ unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size);
 
 void zs_pool_stats(struct zs_pool *pool, struct zs_pool_stats *stats);
 
-void *zs_obj_read_begin(struct zs_pool *pool, unsigned long handle,
-			void *local_copy);
-void zs_obj_read_end(struct zs_pool *pool, unsigned long handle,
-		     void *handle_mem);
-void zs_obj_write(struct zs_pool *pool, unsigned long handle,
-		  void *handle_mem, size_t mem_len);
+void zs_pin_object(struct zs_pool *pool, unsigned long handle,
+		   struct scatterlist *sg);
+void zs_unpin_object(struct zs_pool *pool, unsigned long handle);
 
 #endif
diff --git a/mm/z3fold.c b/mm/z3fold.c
index 379d24b4fef9..eab5c81fa7ad 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -36,6 +36,7 @@
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/workqueue.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/zpool.h>
@@ -1392,12 +1393,15 @@ static void z3fold_zpool_free(void *pool, unsigned long handle)
 	z3fold_free(pool, handle);
 }
 
-static void *z3fold_zpool_map(void *pool, unsigned long handle,
-			enum zpool_mapmode mm)
+static void z3fold_zpool_pin(void *pool, unsigned long handle,
+			     struct scatterlist sg[2])
 {
-	return z3fold_map(pool, handle);
+	void *buf = z3fold_map(pool, handle);
+
+	sg_init_one(sg, buf, PAGE_SIZE - offset_in_page(buf));
 }
-static void z3fold_zpool_unmap(void *pool, unsigned long handle)
+
+static void z3fold_zpool_unpin(void *pool, unsigned long handle)
 {
 	z3fold_unmap(pool, handle);
 }
@@ -1409,14 +1413,13 @@ static u64 z3fold_zpool_total_pages(void *pool)
 
 static struct zpool_driver z3fold_zpool_driver = {
 	.type =		"z3fold",
-	.sleep_mapped = true,
 	.owner =	THIS_MODULE,
 	.create =	z3fold_zpool_create,
 	.destroy =	z3fold_zpool_destroy,
 	.malloc =	z3fold_zpool_malloc,
 	.free =		z3fold_zpool_free,
-	.map =		z3fold_zpool_map,
-	.unmap =	z3fold_zpool_unmap,
+	.pin =		z3fold_zpool_pin,
+	.unpin =	z3fold_zpool_unpin,
 	.total_pages =	z3fold_zpool_total_pages,
 };
 
diff --git a/mm/zbud.c b/mm/zbud.c
index e9836fff9438..3132a7c6f926 100644
--- a/mm/zbud.c
+++ b/mm/zbud.c
@@ -36,10 +36,9 @@
  *
  * The zbud API differs from that of conventional allocators in that the
  * allocation function, zbud_alloc(), returns an opaque handle to the user,
- * not a dereferenceable pointer.  The user must map the handle using
- * zbud_map() in order to get a usable pointer by which to access the
- * allocation data and unmap the handle with zbud_unmap() when operations
- * on the allocation data are complete.
+ * not a dereferenceable pointer.  The user must pin the handle using
+ * zbud_pin() in order to access the allocation data and unpin the handle
+ * with zbud_unpin() when operations on the allocation data are complete.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -49,6 +48,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/preempt.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/zpool.h>
@@ -339,28 +339,30 @@ static void zbud_free(struct zbud_pool *pool, unsigned long handle)
 }
 
 /**
- * zbud_map() - maps the allocation associated with the given handle
+ * zbud_pin() - pins the allocation associated with the given handle
  * @pool:	pool in which the allocation resides
- * @handle:	handle associated with the allocation to be mapped
+ * @handle:	handle associated with the allocation to be pinned
+ * @sg:		2-entry scatter list to store the memory pointers
  *
- * While trivial for zbud, the mapping functions for others allocators
+ * While trivial for zbud, the pinning functions for others allocators
  * implementing this allocation API could have more complex information encoded
  * in the handle and could create temporary mappings to make the data
  * accessible to the user.
- *
- * Returns: a pointer to the mapped allocation
  */
-static void *zbud_map(struct zbud_pool *pool, unsigned long handle)
+static void zbud_pin(struct zbud_pool *pool, unsigned long handle,
+		      struct scatterlist sg[2])
 {
-	return (void *)(handle);
+	void *buf = (void *)handle;
+
+	sg_init_one(sg, buf, PAGE_SIZE - offset_in_page(buf));
 }
 
 /**
- * zbud_unmap() - maps the allocation associated with the given handle
+ * zbud_unpin() - unpins the allocation associated with the given handle
  * @pool:	pool in which the allocation resides
- * @handle:	handle associated with the allocation to be unmapped
+ * @handle:	handle associated with the allocation to be unpinned
  */
-static void zbud_unmap(struct zbud_pool *pool, unsigned long handle)
+static void zbud_unpin(struct zbud_pool *pool, unsigned long handle)
 {
 }
 
@@ -400,14 +402,14 @@ static void zbud_zpool_free(void *pool, unsigned long handle)
 	zbud_free(pool, handle);
 }
 
-static void *zbud_zpool_map(void *pool, unsigned long handle,
-			enum zpool_mapmode mm)
+static void zbud_zpool_pin(void *pool, unsigned long handle,
+			   struct scatterlist sg[2])
 {
-	return zbud_map(pool, handle);
+	zbud_pin(pool, handle, sg);
 }
-static void zbud_zpool_unmap(void *pool, unsigned long handle)
+static void zbud_zpool_unpin(void *pool, unsigned long handle)
 {
-	zbud_unmap(pool, handle);
+	zbud_unpin(pool, handle);
 }
 
 static u64 zbud_zpool_total_pages(void *pool)
@@ -417,14 +419,13 @@ static u64 zbud_zpool_total_pages(void *pool)
 
 static struct zpool_driver zbud_zpool_driver = {
 	.type =		"zbud",
-	.sleep_mapped = true,
 	.owner =	THIS_MODULE,
 	.create =	zbud_zpool_create,
 	.destroy =	zbud_zpool_destroy,
 	.malloc =	zbud_zpool_malloc,
 	.free =		zbud_zpool_free,
-	.map =		zbud_zpool_map,
-	.unmap =	zbud_zpool_unmap,
+	.pin =		zbud_zpool_pin,
+	.unpin =	zbud_zpool_unpin,
 	.total_pages =	zbud_zpool_total_pages,
 };
 
diff --git a/mm/zpool.c b/mm/zpool.c
index 0931b8135d72..3355b57ec7ee 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/mm.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
@@ -262,51 +263,38 @@ void zpool_free(struct zpool *zpool, unsigned long handle)
 }
 
 /**
- * zpool_obj_read_begin() - Start reading from a previously allocated handle.
+ * zpool_pin_handle() - Pin a previously allocated handle into memory
  * @zpool:	The zpool that the handle was allocated from
- * @handle:	The handle to read from
- * @local_copy:	A local buffer to use if needed.
+ * @handle:	The handle to pin
+ * @sg:		2-entry scatterlist to store pointers to the memmory
  *
- * This starts a read operation of a previously allocated handle. The passed
- * @local_copy buffer may be used if needed by copying the memory into.
- * zpool_obj_read_end() MUST be called after the read is completed to undo any
- * actions taken (e.g. release locks).
+ * This pins a previously allocated handle into memory.
  *
- * Returns: A pointer to the handle memory to be read, if @local_copy is used,
- * the returned pointer is @local_copy.
+ * This may hold locks, disable interrupts, and/or preemption,
+ * and the zpool_unpin_handle() must be called to undo those
+ * actions.  The code that uses the pinned handle should complete
+ * its operations on the pinned handle memory quickly and unpin
+ * as soon as possible.
  */
-void *zpool_obj_read_begin(struct zpool *zpool, unsigned long handle,
-			   void *local_copy)
+void zpool_pin_handle(struct zpool *zpool, unsigned long handle,
+		      struct scatterlist *sg)
 {
-	return zpool->driver->obj_read_begin(zpool->pool, handle, local_copy);
+	zpool->driver->pin(zpool->pool, handle, sg);
 }
 
 /**
- * zpool_obj_read_end() - Finish reading from a previously allocated handle.
+ * zpool_unpin_handle() - Unpin a previously pinned handle
  * @zpool:	The zpool that the handle was allocated from
- * @handle:	The handle to read from
- * @handle_mem:	The pointer returned by zpool_obj_read_begin()
+ * @handle:	The handle to unpin
  *
- * Finishes a read operation previously started by zpool_obj_read_begin().
+ * This unpins a previously pinned handle.  Any locks or other
+ * actions that the implementation took in zpool_pin_handle()
+ * will be undone here.  The memory area returned from
+ * zpool_pin_handle() should no longer be used after this.
  */
-void zpool_obj_read_end(struct zpool *zpool, unsigned long handle,
-			void *handle_mem)
+void zpool_unpin_handle(struct zpool *zpool, unsigned long handle)
 {
-	zpool->driver->obj_read_end(zpool->pool, handle, handle_mem);
-}
-
-/**
- * zpool_obj_write() - Write to a previously allocated handle.
- * @zpool:	The zpool that the handle was allocated from
- * @handle:	The handle to read from
- * @handle_mem:	The memory to copy from into the handle.
- * @mem_len:	The length of memory to be written.
- *
- */
-void zpool_obj_write(struct zpool *zpool, unsigned long handle,
-		     void *handle_mem, size_t mem_len)
-{
-	zpool->driver->obj_write(zpool->pool, handle, handle_mem, mem_len);
+	zpool->driver->unpin(zpool->pool, handle);
 }
 
 /**
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 961b270f023c..90ce09bc4d0a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -23,6 +23,7 @@
  *	zspage->lock
  */
 
+#include <crypto/scatterwalk.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -49,6 +50,7 @@
 #include <linux/pagemap.h>
 #include <linux/fs.h>
 #include <linux/local_lock.h>
+#include <linux/scatterlist.h>
 #include "zpdesc.h"
 
 #define ZSPAGE_MAGIC	0x58
@@ -445,7 +447,6 @@ static void record_obj(unsigned long handle, unsigned long obj)
 /* zpool driver */
 
 #ifdef CONFIG_ZPOOL
-
 static void *zs_zpool_create(const char *name, gfp_t gfp)
 {
 	/*
@@ -475,22 +476,15 @@ static void zs_zpool_free(void *pool, unsigned long handle)
 	zs_free(pool, handle);
 }
 
-static void *zs_zpool_obj_read_begin(void *pool, unsigned long handle,
-				     void *local_copy)
+static void zs_zpool_pin(void *pool, unsigned long handle,
+			 struct scatterlist sg[2])
 {
-	return zs_obj_read_begin(pool, handle, local_copy);
+	zs_pin_object(pool, handle, sg);
 }
 
-static void zs_zpool_obj_read_end(void *pool, unsigned long handle,
-				  void *handle_mem)
+static void zs_zpool_unpin(void *pool, unsigned long handle)
 {
-	zs_obj_read_end(pool, handle, handle_mem);
-}
-
-static void zs_zpool_obj_write(void *pool, unsigned long handle,
-			       void *handle_mem, size_t mem_len)
-{
-	zs_obj_write(pool, handle, handle_mem, mem_len);
+	zs_unpin_object(pool, handle);
 }
 
 static u64 zs_zpool_total_pages(void *pool)
@@ -505,9 +499,8 @@ static struct zpool_driver zs_zpool_driver = {
 	.destroy =		  zs_zpool_destroy,
 	.malloc =		  zs_zpool_malloc,
 	.free =			  zs_zpool_free,
-	.obj_read_begin =	  zs_zpool_obj_read_begin,
-	.obj_read_end  =	  zs_zpool_obj_read_end,
-	.obj_write =		  zs_zpool_obj_write,
+	.pin =			  zs_zpool_pin,
+	.unpin =		  zs_zpool_unpin,
 	.total_pages =		  zs_zpool_total_pages,
 };
 
@@ -1145,15 +1138,15 @@ unsigned long zs_get_total_pages(struct zs_pool *pool)
 }
 EXPORT_SYMBOL_GPL(zs_get_total_pages);
 
-void *zs_obj_read_begin(struct zs_pool *pool, unsigned long handle,
-			void *local_copy)
+void zs_pin_object(struct zs_pool *pool, unsigned long handle,
+		   struct scatterlist *sg)
 {
+	int handle_size = ZS_HANDLE_SIZE;
 	struct zspage *zspage;
 	struct zpdesc *zpdesc;
 	unsigned long obj, off;
 	unsigned int obj_idx;
 	struct size_class *class;
-	void *addr;
 
 	/* Guarantee we can get zspage from handle safely */
 	read_lock(&pool->lock);
@@ -1168,107 +1161,43 @@ void *zs_obj_read_begin(struct zs_pool *pool, unsigned long handle,
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
+	if (ZsHugePage(zspage))
+		handle_size = 0;
+
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
-		addr = kmap_local_zpdesc(zpdesc);
-		addr += off;
+		sg_init_table(sg, 1);
+		sg_set_page(sg, zpdesc_page(zpdesc),
+			    class->size - handle_size, off + handle_size);
 	} else {
 		size_t sizes[2];
 
 		/* this object spans two pages */
 		sizes[0] = PAGE_SIZE - off;
 		sizes[1] = class->size - sizes[0];
-		addr = local_copy;
 
-		memcpy_from_page(addr, zpdesc_page(zpdesc),
-				 off, sizes[0]);
+		sg_init_table(sg, 2);
+		sg_set_page(sg, zpdesc_page(zpdesc), sizes[0] - handle_size,
+			    off + handle_size);
 		zpdesc = get_next_zpdesc(zpdesc);
-		memcpy_from_page(addr + sizes[0],
-				 zpdesc_page(zpdesc),
-				 0, sizes[1]);
+		sg_set_page(&sg[1], zpdesc_page(zpdesc), sizes[1], 0);
 	}
-
-	if (!ZsHugePage(zspage))
-		addr += ZS_HANDLE_SIZE;
-
-	return addr;
 }
-EXPORT_SYMBOL_GPL(zs_obj_read_begin);
+EXPORT_SYMBOL_GPL(zs_pin_object);
 
-void zs_obj_read_end(struct zs_pool *pool, unsigned long handle,
-		     void *handle_mem)
+void zs_unpin_object(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
 	struct zpdesc *zpdesc;
-	unsigned long obj, off;
 	unsigned int obj_idx;
-	struct size_class *class;
+	unsigned long obj;
 
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
 	zspage = get_zspage(zpdesc);
-	class = zspage_class(pool, zspage);
-	off = offset_in_page(class->size * obj_idx);
-
-	if (off + class->size <= PAGE_SIZE) {
-		if (!ZsHugePage(zspage))
-			off += ZS_HANDLE_SIZE;
-		handle_mem -= off;
-		kunmap_local(handle_mem);
-	}
-
 	zspage_read_unlock(zspage);
 }
-EXPORT_SYMBOL_GPL(zs_obj_read_end);
-
-void zs_obj_write(struct zs_pool *pool, unsigned long handle,
-		  void *handle_mem, size_t mem_len)
-{
-	struct zspage *zspage;
-	struct zpdesc *zpdesc;
-	unsigned long obj, off;
-	unsigned int obj_idx;
-	struct size_class *class;
-
-	/* Guarantee we can get zspage from handle safely */
-	read_lock(&pool->lock);
-	obj = handle_to_obj(handle);
-	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc);
-
-	/* Make sure migration doesn't move any pages in this zspage */
-	zspage_read_lock(zspage);
-	read_unlock(&pool->lock);
-
-	class = zspage_class(pool, zspage);
-	off = offset_in_page(class->size * obj_idx);
-
-	if (off + class->size <= PAGE_SIZE) {
-		/* this object is contained entirely within a page */
-		void *dst = kmap_local_zpdesc(zpdesc);
-
-		if (!ZsHugePage(zspage))
-			off += ZS_HANDLE_SIZE;
-		memcpy(dst + off, handle_mem, mem_len);
-		kunmap_local(dst);
-	} else {
-		/* this object spans two pages */
-		size_t sizes[2];
-
-		off += ZS_HANDLE_SIZE;
-		sizes[0] = PAGE_SIZE - off;
-		sizes[1] = mem_len - sizes[0];
-
-		memcpy_to_page(zpdesc_page(zpdesc), off,
-			       handle_mem, sizes[0]);
-		zpdesc = get_next_zpdesc(zpdesc);
-		memcpy_to_page(zpdesc_page(zpdesc), 0,
-			       handle_mem + sizes[0], sizes[1]);
-	}
-
-	zspage_read_unlock(zspage);
-}
-EXPORT_SYMBOL_GPL(zs_obj_write);
+EXPORT_SYMBOL_GPL(zs_unpin_object);
 
 /**
  * zs_huge_class_size() - Returns the size (in bytes) of the first huge
diff --git a/mm/zswap.c b/mm/zswap.c
index 8b086740698a..42b5fbeea477 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -13,6 +13,8 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <crypto/acompress.h>
+#include <crypto/scatterwalk.h>
 #include <linux/module.h>
 #include <linux/cpu.h>
 #include <linux/highmem.h>
@@ -26,7 +28,6 @@
 #include <linux/mempolicy.h>
 #include <linux/mempool.h>
 #include <linux/zpool.h>
-#include <crypto/acompress.h>
 #include <linux/zswap.h>
 #include <linux/mm_types.h>
 #include <linux/page-flags.h>
@@ -147,7 +148,6 @@ struct crypto_acomp_ctx {
 	struct crypto_wait wait;
 	u8 *buffer;
 	struct mutex mutex;
-	bool is_sleepable;
 };
 
 /*
@@ -865,7 +865,6 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 
 	acomp_ctx->buffer = buffer;
 	acomp_ctx->acomp = acomp;
-	acomp_ctx->is_sleepable = acomp_is_async(acomp);
 	acomp_ctx->req = req;
 	mutex_unlock(&acomp_ctx->mutex);
 	return 0;
@@ -928,6 +927,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	struct scatterlist input, output;
 	int comp_ret = 0, alloc_ret = 0;
 	unsigned int dlen = PAGE_SIZE;
+	struct scatterlist sg[2];
 	unsigned long handle;
 	struct zpool *zpool;
 	gfp_t gfp;
@@ -969,7 +969,9 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	if (alloc_ret)
 		goto unlock;
 
-	zpool_obj_write(zpool, handle, dst, dlen);
+	zpool_pin_handle(zpool, handle, sg);
+	memcpy_to_sglist(sg, 0, dst, dlen);
+	zpool_unpin_handle(zpool, handle);
 	entry->handle = handle;
 	entry->length = dlen;
 
@@ -988,34 +990,19 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 {
 	struct zpool *zpool = entry->pool->zpool;
-	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
-	u8 *src, *obj;
+	struct scatterlist input[2];
+	struct scatterlist output;
 
 	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
-	obj = zpool_obj_read_begin(zpool, entry->handle, acomp_ctx->buffer);
-
-	/*
-	 * zpool_obj_read_begin() might return a kmap address of highmem when
-	 * acomp_ctx->buffer is not used.  However, sg_init_one() does not
-	 * handle highmem addresses, so copy the object to acomp_ctx->buffer.
-	 */
-	if (virt_addr_valid(obj)) {
-		src = obj;
-	} else {
-		WARN_ON_ONCE(obj == acomp_ctx->buffer);
-		memcpy(acomp_ctx->buffer, obj, entry->length);
-		src = acomp_ctx->buffer;
-	}
-
-	sg_init_one(&input, src, entry->length);
+	zpool_pin_handle(zpool, entry->handle, input);
 	sg_init_table(&output, 1);
 	sg_set_folio(&output, folio, PAGE_SIZE, 0);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
+	acomp_request_set_params(acomp_ctx->req, input, &output, entry->length, PAGE_SIZE);
 	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
 
-	zpool_obj_read_end(zpool, entry->handle, obj);
+	zpool_unpin_handle(zpool, entry->handle);
 	acomp_ctx_put_unlock(acomp_ctx);
 }
 
-- 
2.39.5

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

