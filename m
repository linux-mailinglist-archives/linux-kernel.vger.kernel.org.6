Return-Path: <linux-kernel+bounces-546144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9570A4F6E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28DE188FA99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9929D1EA7FA;
	Wed,  5 Mar 2025 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NqpAebb+"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16D51E5B91
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741155121; cv=none; b=SmDnBqrwaFi5VpQ4YmLWTJlGhUsDkgKs/beZbvBbndi7HY9/ycGySMePZ9mL4SHsFqcjh5mvZu6woycIFCrT8ArBbpagnNF70V0JMBfDxVbk2VNM9bQcSeFlEaBnxpDqD3/Eh9JTKrPxwMXNNgkvZxSVaOdjNf4fPTNsSggsMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741155121; c=relaxed/simple;
	bh=iRStbOpLVIAApdbemlh9RwFlXe/MGEHVpH8/IZ4iju0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4e9BInpvWFMCLtVFw0K//CadSw1Ag0bGQ4zeJrGSmUJgPfT304vtz5IP5JMjMgB1gZpxywgh1j4uETNGJ6CUiXB0QDH1cjL0vnvFywk7i54UD260XQxs5cWt3IA2eVgfr3uAT0O4WjE5s/uGAoU+ZpGQZ1QWYtgHgUjbuQcL1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NqpAebb+; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741155118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8Bqfcz7PgVEFtBp+cmFfADLG6mXxpRGvGVC/yYU2bs=;
	b=NqpAebb+VPXqgePqnox4fJ1VPtXsFc4mX0lvtiEvRaIO7un0c0kK81tIPtimYMIf0mHt5I
	qBouqrSMQGWWnETMPaO7V3U4BGHWZdo8lGyRML8GKKWHuk+6zj4LtNG8zbeurpCtpJT2RJ
	1+YQeUtblKbQzHmBW0/C243DqnMvGhY=
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
Subject: [PATCH mm-unstable 3/5] mm: zpool: Remove object mapping APIs
Date: Wed,  5 Mar 2025 06:11:31 +0000
Message-ID: <20250305061134.4105762-4-yosry.ahmed@linux.dev>
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

zpool_map_handle(), zpool_unmap_handle(), and zpool_can_sleep_mapped()
are no longer used. Remove them with the underlying driver callbacks.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 include/linux/zpool.h | 30 ---------------------
 mm/zpool.c            | 61 -------------------------------------------
 mm/zsmalloc.c         | 27 -------------------
 3 files changed, 118 deletions(-)

diff --git a/include/linux/zpool.h b/include/linux/zpool.h
index 1784e735ee049..2c8a9d2654f6f 100644
--- a/include/linux/zpool.h
+++ b/include/linux/zpool.h
@@ -13,25 +13,6 @@
 
 struct zpool;
 
-/*
- * Control how a handle is mapped.  It will be ignored if the
- * implementation does not support it.  Its use is optional.
- * Note that this does not refer to memory protection, it
- * refers to how the memory will be copied in/out if copying
- * is necessary during mapping; read-write is the safest as
- * it copies the existing memory in on map, and copies the
- * changed memory back out on unmap.  Write-only does not copy
- * in the memory and should only be used for initialization.
- * If in doubt, use ZPOOL_MM_DEFAULT which is read-write.
- */
-enum zpool_mapmode {
-	ZPOOL_MM_RW, /* normal read-write mapping */
-	ZPOOL_MM_RO, /* read-only (no copy-out at unmap time) */
-	ZPOOL_MM_WO, /* write-only (no copy-in at map time) */
-
-	ZPOOL_MM_DEFAULT = ZPOOL_MM_RW
-};
-
 bool zpool_has_pool(char *type);
 
 struct zpool *zpool_create_pool(const char *type, const char *name, gfp_t gfp);
@@ -47,12 +28,6 @@ int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
 
 void zpool_free(struct zpool *pool, unsigned long handle);
 
-void *zpool_map_handle(struct zpool *pool, unsigned long handle,
-			enum zpool_mapmode mm);
-
-void zpool_unmap_handle(struct zpool *pool, unsigned long handle);
-
-
 void *zpool_obj_read_begin(struct zpool *zpool, unsigned long handle,
 			   void *local_copy);
 
@@ -95,11 +70,6 @@ struct zpool_driver {
 				unsigned long *handle);
 	void (*free)(void *pool, unsigned long handle);
 
-	bool sleep_mapped;
-	void *(*map)(void *pool, unsigned long handle,
-				enum zpool_mapmode mm);
-	void (*unmap)(void *pool, unsigned long handle);
-
 	void *(*obj_read_begin)(void *pool, unsigned long handle,
 				void *local_copy);
 	void (*obj_read_end)(void *pool, unsigned long handle,
diff --git a/mm/zpool.c b/mm/zpool.c
index 378c2d1e5638f..4fc665b42f5e9 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -277,49 +277,6 @@ void zpool_free(struct zpool *zpool, unsigned long handle)
 	zpool->driver->free(zpool->pool, handle);
 }
 
-/**
- * zpool_map_handle() - Map a previously allocated handle into memory
- * @zpool:	The zpool that the handle was allocated from
- * @handle:	The handle to map
- * @mapmode:	How the memory should be mapped
- *
- * This maps a previously allocated handle into memory.  The @mapmode
- * param indicates to the implementation how the memory will be
- * used, i.e. read-only, write-only, read-write.  If the
- * implementation does not support it, the memory will be treated
- * as read-write.
- *
- * This may hold locks, disable interrupts, and/or preemption,
- * and the zpool_unmap_handle() must be called to undo those
- * actions.  The code that uses the mapped handle should complete
- * its operations on the mapped handle memory quickly and unmap
- * as soon as possible.  As the implementation may use per-cpu
- * data, multiple handles should not be mapped concurrently on
- * any cpu.
- *
- * Returns: A pointer to the handle's mapped memory area.
- */
-void *zpool_map_handle(struct zpool *zpool, unsigned long handle,
-			enum zpool_mapmode mapmode)
-{
-	return zpool->driver->map(zpool->pool, handle, mapmode);
-}
-
-/**
- * zpool_unmap_handle() - Unmap a previously mapped handle
- * @zpool:	The zpool that the handle was allocated from
- * @handle:	The handle to unmap
- *
- * This unmaps a previously mapped handle.  Any locks or other
- * actions that the implementation took in zpool_map_handle()
- * will be undone here.  The memory area returned from
- * zpool_map_handle() should no longer be used after this.
- */
-void zpool_unmap_handle(struct zpool *zpool, unsigned long handle)
-{
-	zpool->driver->unmap(zpool->pool, handle);
-}
-
 /**
  * zpool_obj_read_begin() - Start reading from a previously allocated handle.
  * @zpool:	The zpool that the handle was allocated from
@@ -381,23 +338,5 @@ u64 zpool_get_total_pages(struct zpool *zpool)
 	return zpool->driver->total_pages(zpool->pool);
 }
 
-/**
- * zpool_can_sleep_mapped - Test if zpool can sleep when do mapped.
- * @zpool:	The zpool to test
- *
- * Some allocators enter non-preemptible context in ->map() callback (e.g.
- * disable pagefaults) and exit that context in ->unmap(), which limits what
- * we can do with the mapped object. For instance, we cannot wait for
- * asynchronous crypto API to decompress such an object or take mutexes
- * since those will call into the scheduler. This function tells us whether
- * we use such an allocator.
- *
- * Returns: true if zpool can sleep; false otherwise.
- */
-bool zpool_can_sleep_mapped(struct zpool *zpool)
-{
-	return zpool->driver->sleep_mapped;
-}
-
 MODULE_AUTHOR("Dan Streetman <ddstreet@ieee.org>");
 MODULE_DESCRIPTION("Common API for compressed memory storage");
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d84b300db64e7..56d6ed5c675b2 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -482,31 +482,6 @@ static void zs_zpool_free(void *pool, unsigned long handle)
 	zs_free(pool, handle);
 }
 
-static void *zs_zpool_map(void *pool, unsigned long handle,
-			enum zpool_mapmode mm)
-{
-	enum zs_mapmode zs_mm;
-
-	switch (mm) {
-	case ZPOOL_MM_RO:
-		zs_mm = ZS_MM_RO;
-		break;
-	case ZPOOL_MM_WO:
-		zs_mm = ZS_MM_WO;
-		break;
-	case ZPOOL_MM_RW:
-	default:
-		zs_mm = ZS_MM_RW;
-		break;
-	}
-
-	return zs_map_object(pool, handle, zs_mm);
-}
-static void zs_zpool_unmap(void *pool, unsigned long handle)
-{
-	zs_unmap_object(pool, handle);
-}
-
 static void *zs_zpool_obj_read_begin(void *pool, unsigned long handle,
 				     void *local_copy)
 {
@@ -538,8 +513,6 @@ static struct zpool_driver zs_zpool_driver = {
 	.malloc_support_movable = true,
 	.malloc =		  zs_zpool_malloc,
 	.free =			  zs_zpool_free,
-	.map =			  zs_zpool_map,
-	.unmap =		  zs_zpool_unmap,
 	.obj_read_begin =	  zs_zpool_obj_read_begin,
 	.obj_read_end  =	  zs_zpool_obj_read_end,
 	.obj_write =		  zs_zpool_obj_write,
-- 
2.48.1.711.g2feabab25a-goog


