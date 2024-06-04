Return-Path: <linux-kernel+bounces-201212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2738FBB02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA281F22378
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEA114A09E;
	Tue,  4 Jun 2024 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zA8A680t"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B414A088
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523625; cv=none; b=MknFqxRsIXU5O79SBqn5BXSEzgYQSgnww4G68SxF5jMMsyDUFlBC618PyNm21L9r8KK9JTnTPkulZvM/7J3pBf//dxKOgJkWRcit9fcLzysiDibUoY9DIznSfcmyhnBmdXmxJSaMS424p4V+HjrYDP4WY2yQu6LrUxVTlC6ZPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523625; c=relaxed/simple;
	bh=w7ZEyukyRV+/9n1UGLtHOWCQnBJmpgY6htuPha8k+Jk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IOw61n9Mvw7r80JQlJ7ivPL0s9pW++oqgVv8rtGpkJY02+CpcNm16BTXMF3FJgNn53AxB8qryd19HbcZE8+VFJVT1uxjiROyhvnyZfp+hUmTQshnzToDz4I9WtQtFL+svovaqskr37q97GAggHpjdDCEEkxWkKZKsD9irAySOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zA8A680t; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627eb3fb46cso96842597b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717523623; x=1718128423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RkO01EBi4ZpDllQIyTsXkNSPQB7Na6mjECCeDND9h9A=;
        b=zA8A680t/8Pwos7Hu9yYQ7Bd7hvKWjObApRyiIV9VaKk7IORvwKqJtIRPBCnkQuSts
         CEDR59gjxXxFTjxnITtWtsgZF8IWvcZfIvo8CLHpQCGtgvuluh20+hvbu5oWMxjOv0Da
         rwxZSC/iChPfm1eh9WcaTo3r6Gn5pI2/5dRRo68RLqmdD/HYKRlPAyWpbUBzFPRkzAo4
         hEhPLW4M1QM/GKJ8GL5LkXBU25kJUyeBSt0ivIJ51IfiTrLappqVwNZtK5WFxwYeB6lO
         s0t53/M1Gd4H5vnWtV8Fa9jL7rx0dLBwDOIYh3XRQlVRZF+IQfDNN1nqfTh8xJpaToHH
         O5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717523623; x=1718128423;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RkO01EBi4ZpDllQIyTsXkNSPQB7Na6mjECCeDND9h9A=;
        b=ZHgNZ0DCNeBolo1H02J0xCjaS7loXJVPXOU/emXz97vPg2zJe0KR/x8u2YzJKqSfpa
         jsVszmcffyjqTGCsG9LSGjOrSfGznhAgh+TkDhCSq14gfTaYXy+fOkXO9rcI1wMvt0L7
         nCj+BFKGkt1cX36VS6X9LtzTsWAO9Lb/Sp+DmK/kVKDT4JOa6qU0h2Kojpj+kz4B1xRd
         LMJ4HBo9sPZiI+p5PBILcgZv0SL+grR1ryII2tAzZ+DaPnA81C/5O6bMcIp0fciCeX0q
         dKllIpOoiC4JePastsbhUKKqmU6zCBbQMqYR2gnP4NxxmmZB/E6LWyVBn5wQMZN4tw3+
         SF+w==
X-Forwarded-Encrypted: i=1; AJvYcCUBZ7ENg4hVbjC/1WWfuqpRL1tzSeylsdwkYXNlPu8W4KU9tqUHoRKJjTo6EnsxCRqJZt1WZew7nIYDNhmz+aZ9u+GwiwLoTRqr3xZn
X-Gm-Message-State: AOJu0YxEGCRU3xiEpj3faOPKuhSeVdjAXT1K8of3u1gVHeaSiy+lVIR1
	AuNPMtnEv3z1IYaC+j2Q9fQFZme4FIIc+IKfbckwymkwv3A39J+U/CwIcqqAelCNWj1ToCZ+MOQ
	WHw7grtDKMIluMoIoaw==
X-Google-Smtp-Source: AGHT+IG98szI73ZNCoIhOV8kejNTVDpGJJ4whJQBxKBrMgBWivuKR4Zny2rU1jLSFhAlPBEnPs3zVZyVQs41JDjj
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:add0:0:b0:dfa:88df:b389 with SMTP
 id 3f1490d57ef6-dfacac4e620mr529276.7.1717523623046; Tue, 04 Jun 2024
 10:53:43 -0700 (PDT)
Date: Tue,  4 Jun 2024 17:53:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240604175340.218175-1-yosryahmed@google.com>
Subject: [PATCH] mm: zsmalloc: share slab caches for all zsmalloc zpools
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, 
	Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Zswap creates multiple zpools to improve concurrency. Each zsmalloc
zpool creates its own 'zs_handle' and 'zspage' slab caches. Currently we
end up with 32 slab caches of each type.

Since each slab cache holds some free objects, we end up with a lot of
free objects distributed among the separate zpool caches. Slab caches
are designed to handle concurrent allocations by using percpu
structures, so having a single instance of each cache should be enough,
and avoids wasting more memory than needed due to fragmentation.

Additionally, having more slab caches than needed unnecessarily slows
down code paths that iterate slab_caches.

In the results reported by Eric in [1], the amount of unused slab memory
in these caches goes down from 242808 bytes to 29216 bytes (-88%). This
is calculated by (num_objs - active_objs) * objsize for each 'zs_handle'
and 'zspage' cache. Although this patch did not help with the allocation
failure reported by Eric with zswap + zsmalloc, I think it is still
worth merging on its own.

[1]https://lore.kernel.org/lkml/20240604134458.3ae4396a@yea/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zsmalloc.c | 87 ++++++++++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b42d3545ca856..76d9976442a4a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -220,8 +220,6 @@ struct zs_pool {
 	const char *name;
 
 	struct size_class *size_class[ZS_SIZE_CLASSES];
-	struct kmem_cache *handle_cachep;
-	struct kmem_cache *zspage_cachep;
 
 	atomic_long_t pages_allocated;
 
@@ -289,50 +287,29 @@ static void init_deferred_free(struct zs_pool *pool) {}
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
 #endif
 
-static int create_cache(struct zs_pool *pool)
-{
-	pool->handle_cachep = kmem_cache_create("zs_handle", ZS_HANDLE_SIZE,
-					0, 0, NULL);
-	if (!pool->handle_cachep)
-		return 1;
-
-	pool->zspage_cachep = kmem_cache_create("zspage", sizeof(struct zspage),
-					0, 0, NULL);
-	if (!pool->zspage_cachep) {
-		kmem_cache_destroy(pool->handle_cachep);
-		pool->handle_cachep = NULL;
-		return 1;
-	}
-
-	return 0;
-}
+static struct kmem_cache *zs_handle_cache;
+static struct kmem_cache *zspage_cache;
 
-static void destroy_cache(struct zs_pool *pool)
+static unsigned long cache_alloc_handle(gfp_t gfp)
 {
-	kmem_cache_destroy(pool->handle_cachep);
-	kmem_cache_destroy(pool->zspage_cachep);
-}
-
-static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
-{
-	return (unsigned long)kmem_cache_alloc(pool->handle_cachep,
+	return (unsigned long)kmem_cache_alloc(zs_handle_cache,
 			gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
 }
 
-static void cache_free_handle(struct zs_pool *pool, unsigned long handle)
+static void cache_free_handle(unsigned long handle)
 {
-	kmem_cache_free(pool->handle_cachep, (void *)handle);
+	kmem_cache_free(zs_handle_cache, (void *)handle);
 }
 
-static struct zspage *cache_alloc_zspage(struct zs_pool *pool, gfp_t flags)
+static struct zspage *cache_alloc_zspage(gfp_t flags)
 {
-	return kmem_cache_zalloc(pool->zspage_cachep,
+	return kmem_cache_zalloc(zspage_cache,
 			flags & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
 }
 
-static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
+static void cache_free_zspage(struct zspage *zspage)
 {
-	kmem_cache_free(pool->zspage_cachep, zspage);
+	kmem_cache_free(zspage_cache, zspage);
 }
 
 /* pool->lock(which owns the handle) synchronizes races */
@@ -837,7 +814,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 		page = next;
 	} while (page != NULL);
 
-	cache_free_zspage(pool, zspage);
+	cache_free_zspage(zspage);
 
 	class_stat_dec(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
 	atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
@@ -950,7 +927,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 {
 	int i;
 	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE];
-	struct zspage *zspage = cache_alloc_zspage(pool, gfp);
+	struct zspage *zspage = cache_alloc_zspage(gfp);
 
 	if (!zspage)
 		return NULL;
@@ -967,7 +944,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 				dec_zone_page_state(pages[i], NR_ZSPAGES);
 				__free_page(pages[i]);
 			}
-			cache_free_zspage(pool, zspage);
+			cache_free_zspage(zspage);
 			return NULL;
 		}
 
@@ -1338,7 +1315,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	if (unlikely(size > ZS_MAX_ALLOC_SIZE))
 		return (unsigned long)ERR_PTR(-ENOSPC);
 
-	handle = cache_alloc_handle(pool, gfp);
+	handle = cache_alloc_handle(gfp);
 	if (!handle)
 		return (unsigned long)ERR_PTR(-ENOMEM);
 
@@ -1363,7 +1340,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 
 	zspage = alloc_zspage(pool, class, gfp);
 	if (!zspage) {
-		cache_free_handle(pool, handle);
+		cache_free_handle(handle);
 		return (unsigned long)ERR_PTR(-ENOMEM);
 	}
 
@@ -1441,7 +1418,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 		free_zspage(pool, class, zspage);
 
 	spin_unlock(&pool->lock);
-	cache_free_handle(pool, handle);
+	cache_free_handle(handle);
 }
 EXPORT_SYMBOL_GPL(zs_free);
 
@@ -2111,9 +2088,6 @@ struct zs_pool *zs_create_pool(const char *name)
 	if (!pool->name)
 		goto err;
 
-	if (create_cache(pool))
-		goto err;
-
 	/*
 	 * Iterate reversely, because, size of size_class that we want to use
 	 * for merging should be larger or equal to current size.
@@ -2234,16 +2208,41 @@ void zs_destroy_pool(struct zs_pool *pool)
 		kfree(class);
 	}
 
-	destroy_cache(pool);
 	kfree(pool->name);
 	kfree(pool);
 }
 EXPORT_SYMBOL_GPL(zs_destroy_pool);
 
+static void zs_destroy_caches(void)
+{
+	kmem_cache_destroy(zs_handle_cache);
+	kmem_cache_destroy(zspage_cache);
+	zs_handle_cache = NULL;
+	zspage_cache = NULL;
+}
+
+static int zs_create_caches(void)
+{
+	zs_handle_cache = kmem_cache_create("zs_handle", ZS_HANDLE_SIZE,
+					    0, 0, NULL);
+	zspage_cache = kmem_cache_create("zspage", sizeof(struct zspage),
+					 0, 0, NULL);
+
+	if (!zs_handle_cache || !zspage_cache) {
+		zs_destroy_caches();
+		return -1;
+	}
+	return 0;
+}
+
 static int __init zs_init(void)
 {
 	int ret;
 
+	ret = zs_create_caches();
+	if (ret)
+		goto out;
+
 	ret = cpuhp_setup_state(CPUHP_MM_ZS_PREPARE, "mm/zsmalloc:prepare",
 				zs_cpu_prepare, zs_cpu_dead);
 	if (ret)
@@ -2258,6 +2257,7 @@ static int __init zs_init(void)
 	return 0;
 
 out:
+	zs_destroy_caches();
 	return ret;
 }
 
@@ -2269,6 +2269,7 @@ static void __exit zs_exit(void)
 	cpuhp_remove_state(CPUHP_MM_ZS_PREPARE);
 
 	zs_stat_exit();
+	zs_destroy_caches();
 }
 
 module_init(zs_init);
-- 
2.45.1.288.g0e0cd299f1-goog


