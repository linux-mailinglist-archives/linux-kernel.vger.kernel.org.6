Return-Path: <linux-kernel+bounces-546146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613C5A4F6E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6EB188F827
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399451F150D;
	Wed,  5 Mar 2025 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ozyCJOAF"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4511EEA4E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741155129; cv=none; b=jrSuLC/9KfuiH6zxc93lPubAt6sRhGZr0Sk87aAe58Bz4Vi2p5RWTMkLca9xZJpsNsED29DGF2BqZZx9SgR9DAbnSGxarhGjjXQNbwRcdHwnn06mCWEV5Y0rzFYG45Mi48gIRy4jI/WdHE9WJF2A7niETduF+zcuF+4ECmt/8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741155129; c=relaxed/simple;
	bh=1QAFUlkYxX/Tklmd9ajQ/kSRC1rOe18Q6iFJn5NEU1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzgQlT/mq/zDakG1FYaAtFQg3LiTT93R67PnGM2vv3pu7IunumSMqex+hLmOl41sNw9EL935d68sj0OUhLCa7J0IcuGS1rHVe6DxrAlTZNymzmklbMqGd7uzkzYCBILzM2Ya6bykLXvVuawTOOjOCXE8DVrDMXeKDiaEUfLiA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ozyCJOAF; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741155124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdDtOHvnm2EdaYulJZ60u1Fa0OrG84atgPrUT7g6aEw=;
	b=ozyCJOAFVQ+Nj7hdVEjapmmpRc/yILNSg+asLJmivfnQbe0r7mlmBhAfvkGYGIIsMqKhxY
	NLWVcMHJVaFpc9N7qkZlz2xZGUOcUpXCLilpMemMKftlWVS8i2Ha5Ny8xG/vdmiX2JfxBT
	xivQEpxxLKZIZFu9RF4irEUJT/E8fQU=
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
Subject: [PATCH mm-unstable 5/5] mm: zpool: Remove zpool_malloc_support_movable()
Date: Wed,  5 Mar 2025 06:11:33 +0000
Message-ID: <20250305061134.4105762-6-yosry.ahmed@linux.dev>
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

zpool_malloc_support_movable() always returns true for zsmalloc, the
only remaining zpool driver. Remove it and set the gfp flags in
zswap_compress() accordingly. Opportunistically use GFP_NOWAIT instead
of __GFP_NOWARN | __GFP_KSWAPD_RECLAIM for conciseness as they are
equivalent.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 include/linux/zpool.h |  3 ---
 mm/zpool.c            | 16 ----------------
 mm/zsmalloc.c         |  1 -
 mm/zswap.c            |  4 +---
 4 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/include/linux/zpool.h b/include/linux/zpool.h
index 2c8a9d2654f6f..52f30e526607f 100644
--- a/include/linux/zpool.h
+++ b/include/linux/zpool.h
@@ -21,8 +21,6 @@ const char *zpool_get_type(struct zpool *pool);
 
 void zpool_destroy_pool(struct zpool *pool);
 
-bool zpool_malloc_support_movable(struct zpool *pool);
-
 int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
 			unsigned long *handle);
 
@@ -65,7 +63,6 @@ struct zpool_driver {
 	void *(*create)(const char *name, gfp_t gfp);
 	void (*destroy)(void *pool);
 
-	bool malloc_support_movable;
 	int (*malloc)(void *pool, size_t size, gfp_t gfp,
 				unsigned long *handle);
 	void (*free)(void *pool, unsigned long handle);
diff --git a/mm/zpool.c b/mm/zpool.c
index 4fc665b42f5e9..6d6d889309324 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -220,22 +220,6 @@ const char *zpool_get_type(struct zpool *zpool)
 	return zpool->driver->type;
 }
 
-/**
- * zpool_malloc_support_movable() - Check if the zpool supports
- *	allocating movable memory
- * @zpool:	The zpool to check
- *
- * This returns if the zpool supports allocating movable memory.
- *
- * Implementations must guarantee this to be thread-safe.
- *
- * Returns: true if the zpool supports allocating movable memory, false if not
- */
-bool zpool_malloc_support_movable(struct zpool *zpool)
-{
-	return zpool->driver->malloc_support_movable;
-}
-
 /**
  * zpool_malloc() - Allocate memory
  * @zpool:	The zpool to allocate from.
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index cd1c2a8ffef05..961b270f023c2 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -503,7 +503,6 @@ static struct zpool_driver zs_zpool_driver = {
 	.owner =		  THIS_MODULE,
 	.create =		  zs_zpool_create,
 	.destroy =		  zs_zpool_destroy,
-	.malloc_support_movable = true,
 	.malloc =		  zs_zpool_malloc,
 	.free =			  zs_zpool_free,
 	.obj_read_begin =	  zs_zpool_obj_read_begin,
diff --git a/mm/zswap.c b/mm/zswap.c
index 4c474b692828d..138b50ba832b8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -964,9 +964,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 		goto unlock;
 
 	zpool = pool->zpool;
-	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
-	if (zpool_malloc_support_movable(zpool))
-		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
+	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
 	alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle);
 	if (alloc_ret)
 		goto unlock;
-- 
2.48.1.711.g2feabab25a-goog


