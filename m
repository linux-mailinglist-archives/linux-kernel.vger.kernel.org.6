Return-Path: <linux-kernel+bounces-296242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF2B95A80E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBB11F22C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E119617D34D;
	Wed, 21 Aug 2024 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfzzTyqD"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D915817CA14
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281602; cv=none; b=dCwmDUrQdlnRktHDPl21Ii2ftpza2Ik8duCgyL7QSbJzxaOHJUcNea9RuHwkfGFB6k6h/JqnRi5p62ROehxzcCKwpr31XXr520UWe2iPYRHoyvSXYAd5UQN8wKD2dtSqPSJQVfRwl71yYpbSShrpU6aHeX9VPjygibV6NQaS8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281602; c=relaxed/simple;
	bh=XN+rdEQOGamw9jTCOYuF+Hib81g2JNJcluTrSrE7Agw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbpWwoGTSTxyTAcjIO8qgv3p+m90m2U2lmgzO6uFPlkO3Nw0UzhmlNvB1+MZ22JHDuUFqqCg5nPim0NasohmHk0d6flazYoHaFhT0tOzObCJ+UD4tbmaAapkBECCiaoLSRr+jWVpRU8a5JpGjhX/CllIK9zQWsQIYRw2hztOeBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfzzTyqD; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-714263cb074so206572b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724281599; x=1724886399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNFMTHpoapmJ/WJI+sAnXGyaXgVzeQputyNi83Y8ox0=;
        b=BfzzTyqDEaf4spr1gzmVvuxDL2lIYvBFojGkaAs7vWcMq2aIYoc8/hwFl9gTHMRi2+
         HDkRyU0k/o/3yzV1OW14CxFUk5L5UBtmNLj2N5CUomLYJsQUJFokjEQjMJNhCXbbUuVm
         yuRTq5BGEvFOpKdyzdlFdSZaErRQJjjNYVUF1Vb9c+LaisoHA6ReyJv3xxZvNHD6sGTr
         17Obs4h2sTZ6XKefTUKNanLRjRNGg/6t859hwbmroD7EDObwdRQ6H/EFf+OVWWTkNTPO
         1uSIYsmWudLUsz5UjBqZqRqYcOl/n33SXMUtXABy44pFXprOkCtKEk3u9G6am2GdeXLM
         YskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724281599; x=1724886399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNFMTHpoapmJ/WJI+sAnXGyaXgVzeQputyNi83Y8ox0=;
        b=d3xw2xdhnyPN2m+VrdScPvlqMsdlCefMZdRCxFmAFCmaEykphADvhLTpcmZVy8UTpQ
         0/zic+ihkdWYRgnL+Fg2yVztm6Uov6/GUmvNs78QnmYHDG6x1eM2xoTx5fEBbQRWvTsq
         RBmcyn73auzjQ06PZ+qFfzfMRBZYKEoE3PlDkxUTrolSSKyz+cDwtM6Z30OypjdRDqGG
         o12nHSx/enUT7XHTzJPwNH+UpRGJll6+E9JyX9ENRJNhmyKLBpMNl13UDplFZELjrEIh
         aUnWPIcbX7t1q3jSVqpR6baba7HmfYXZTsJyJZnR9GL83X+xp8v6DhcNePqMvungGSvU
         YwIQ==
X-Gm-Message-State: AOJu0YyVGIz/sa/ft5A0CEx1LW87cvv22Holf4NdKm+vmBCt2fRQCKB7
	d3DLx70g9lwOSaZPI9oWyrPgs4v59XXC47TNuqhDDCSdkGeetGwh
X-Google-Smtp-Source: AGHT+IGoFV1n5PwRxmjQ/GKCkPMrEPUz6mW5eQeI9Nuc0rh3fPHSYKsoRSkr3q2mXTTNvKllP5BzNg==
X-Received: by 2002:a05:6a21:3a45:b0:1c4:9e5f:c645 with SMTP id adf61e73a8af0-1caeb30790dmr89701637.40.1724281598798;
        Wed, 21 Aug 2024 16:06:38 -0700 (PDT)
Received: from localhost (192.243.127.228.16clouds.com. [192.243.127.228])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbef1edsm2493325a91.47.2024.08.21.16.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:06:38 -0700 (PDT)
From: Woody Zhang <woodyzhang666@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Woody Zhang <woodyzhang666@gmail.com>
Subject: [PATCH 5/5] debugobjects: use list_bl to save memory for hash slot spinlocks
Date: Thu, 22 Aug 2024 07:05:39 +0800
Message-ID: <20240821230539.168107-6-woodyzhang666@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821230539.168107-1-woodyzhang666@gmail.com>
References: <20240821230539.168107-1-woodyzhang666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hlist_head + spinlock with hlist_bl_head to save memory for
spinlocks.

Signed-off-by: Woody Zhang <woodyzhang666@gmail.com>
---
 include/linux/debugobjects.h |   4 +-
 lib/debugobjects.c           | 288 +++++++++++++++++------------------
 2 files changed, 144 insertions(+), 148 deletions(-)

diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
index 32444686b6ff..e5b27295d50f 100644
--- a/include/linux/debugobjects.h
+++ b/include/linux/debugobjects.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_DEBUGOBJECTS_H
 #define _LINUX_DEBUGOBJECTS_H
 
-#include <linux/list.h>
+#include <linux/list_bl.h>
 #include <linux/spinlock.h>
 
 enum debug_obj_state {
@@ -26,7 +26,7 @@ struct debug_obj_descr;
  * @descr:	pointer to an object type specific debug description structure
  */
 struct debug_obj {
-	struct hlist_node	node;
+	struct hlist_bl_node	node;
 	enum debug_obj_state	state;
 	unsigned int		astate;
 	void			*object;
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7cea91e193a8..d68a96e351aa 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -38,30 +38,23 @@
 #define ODEBUG_FREE_WORK_MAX	1024
 #define ODEBUG_FREE_WORK_DELAY	DIV_ROUND_UP(HZ, 10)
 
-struct debug_bucket {
-	struct hlist_head	list;
-	raw_spinlock_t		lock;
-};
-
 /*
  * Debug object percpu free list
  * Access is protected by disabling irq
  */
 struct debug_percpu_free {
-	struct hlist_head	free_objs;
+	struct hlist_bl_head	free_objs;
 	int			obj_free;
 };
 
 static DEFINE_PER_CPU(struct debug_percpu_free, percpu_obj_pool);
 
-static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
+static struct hlist_bl_head	obj_hash[ODEBUG_HASH_SIZE];
 
 static struct debug_obj		obj_static_pool[ODEBUG_POOL_SIZE] __initdata;
 
-static DEFINE_RAW_SPINLOCK(pool_lock);
-
-static HLIST_HEAD(obj_pool);
-static HLIST_HEAD(obj_to_free);
+static HLIST_BL_HEAD(obj_pool);
+static HLIST_BL_HEAD(obj_to_free);
 
 /*
  * Because of the presence of percpu free pools, obj_pool_free will
@@ -139,23 +132,23 @@ static void fill_pool(void)
 	 * when allocating.
 	 *
 	 * Both obj_nr_tofree and obj_pool_free are checked locklessly; the
-	 * READ_ONCE()s pair with the WRITE_ONCE()s in pool_lock critical
-	 * sections.
+	 * READ_ONCE()s pair with the WRITE_ONCE()s in obj_pool bit lock
+	 * critical sections.
 	 */
 	while (READ_ONCE(obj_nr_tofree) && (READ_ONCE(obj_pool_free) < obj_pool_min_free)) {
-		raw_spin_lock_irqsave(&pool_lock, flags);
+		hlist_bl_lock_irqsave(&obj_pool, flags);
 		/*
 		 * Recheck with the lock held as the worker thread might have
 		 * won the race and freed the global free list already.
 		 */
 		while (obj_nr_tofree && (obj_pool_free < obj_pool_min_free)) {
-			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
-			hlist_del(&obj->node);
+			obj = hlist_bl_entry(obj_to_free.first, typeof(*obj), node);
+			hlist_bl_del(&obj->node);
 			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
-			hlist_add_head(&obj->node, &obj_pool);
+			hlist_bl_add_head(&obj->node, &obj_pool);
 			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
 		}
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
+		hlist_bl_unlock_irqrestore(&obj_pool, flags);
 	}
 
 	if (unlikely(!obj_cache))
@@ -173,25 +166,26 @@ static void fill_pool(void)
 		if (!cnt)
 			return;
 
-		raw_spin_lock_irqsave(&pool_lock, flags);
+		hlist_bl_lock_irqsave(&obj_pool, flags);
 		while (cnt) {
-			hlist_add_head(&new[--cnt]->node, &obj_pool);
+			hlist_bl_add_head(&new[--cnt]->node, &obj_pool);
 			debug_objects_allocated++;
 			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
 		}
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
+		hlist_bl_unlock_irqrestore(&obj_pool, flags);
 	}
 }
 
 /*
  * Lookup an object in the hash bucket.
  */
-static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
+static struct debug_obj *lookup_object(void *addr, struct hlist_bl_head *list)
 {
 	struct debug_obj *obj;
+	struct hlist_bl_node *tmp;
 	int cnt = 0;
 
-	hlist_for_each_entry(obj, &b->list, node) {
+	hlist_bl_for_each_entry(obj, tmp, list, node) {
 		cnt++;
 		if (obj->object == addr)
 			return obj;
@@ -205,20 +199,22 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
 /*
  * Allocate a new object from the hlist
  */
-static struct debug_obj *__alloc_object(struct hlist_head *list)
+static struct debug_obj *__alloc_object(struct hlist_bl_head *list)
 {
 	struct debug_obj *obj = NULL;
+	struct hlist_bl_node *first = hlist_bl_first(list);
 
-	if (list->first) {
-		obj = hlist_entry(list->first, typeof(*obj), node);
-		hlist_del(&obj->node);
+	if (first) {
+		obj = hlist_bl_entry(first, typeof(*obj), node);
+		hlist_bl_del(&obj->node);
 	}
 
 	return obj;
 }
 
-static struct debug_obj *
-alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
+static struct debug_obj *alloc_object(void *addr,
+		struct hlist_bl_head *list,
+		const struct debug_obj_descr *descr)
 {
 	struct debug_percpu_free *percpu_pool = this_cpu_ptr(&percpu_obj_pool);
 	struct debug_obj *obj;
@@ -231,7 +227,7 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
 		}
 	}
 
-	raw_spin_lock(&pool_lock);
+	hlist_bl_lock(&obj_pool);
 	obj = __alloc_object(&obj_pool);
 	if (obj) {
 		obj_pool_used++;
@@ -250,7 +246,7 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
 				obj2 = __alloc_object(&obj_pool);
 				if (!obj2)
 					break;
-				hlist_add_head(&obj2->node,
+				hlist_bl_add_head(&obj2->node,
 					       &percpu_pool->free_objs);
 				percpu_pool->obj_free++;
 				obj_pool_used++;
@@ -264,7 +260,7 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
 		if (obj_pool_free < obj_pool_min_free)
 			obj_pool_min_free = obj_pool_free;
 	}
-	raw_spin_unlock(&pool_lock);
+	hlist_bl_unlock(&obj_pool);
 
 init_obj:
 	if (obj) {
@@ -272,7 +268,7 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
 		obj->descr  = descr;
 		obj->state  = ODEBUG_STATE_NONE;
 		obj->astate = 0;
-		hlist_add_head(&obj->node, &b->list);
+		hlist_bl_add_head(&obj->node, list);
 	}
 	return obj;
 }
@@ -285,13 +281,13 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
  */
 static void free_obj_work(struct work_struct *work)
 {
-	struct hlist_node *tmp;
+	struct hlist_bl_node *tmp, *n;
 	struct debug_obj *obj;
 	unsigned long flags;
-	HLIST_HEAD(tofree);
+	HLIST_BL_HEAD(tofree);
 
 	WRITE_ONCE(obj_freeing, false);
-	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
+	if (!hlist_bl_trylock_irqsave(&obj_pool, flags))
 		return;
 
 	if (obj_pool_free >= debug_objects_pool_size)
@@ -305,13 +301,13 @@ static void free_obj_work(struct work_struct *work)
 	 * of them until the next round.
 	 */
 	while (obj_nr_tofree && obj_pool_free < debug_objects_pool_size) {
-		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
-		hlist_del(&obj->node);
-		hlist_add_head(&obj->node, &obj_pool);
+		obj = hlist_bl_entry(hlist_bl_first(&obj_to_free), typeof(*obj), node);
+		hlist_bl_del(&obj->node);
+		hlist_bl_add_head(&obj->node, &obj_pool);
 		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
 		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
 	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
+	hlist_bl_unlock_irqrestore(&obj_pool, flags);
 	return;
 
 free_objs:
@@ -321,14 +317,14 @@ static void free_obj_work(struct work_struct *work)
 	 * memory outside the pool_lock held region.
 	 */
 	if (obj_nr_tofree) {
-		hlist_move_list(&obj_to_free, &tofree);
+		hlist_bl_move_list(&obj_to_free, &tofree);
 		debug_objects_freed += obj_nr_tofree;
 		WRITE_ONCE(obj_nr_tofree, 0);
 	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
+	hlist_bl_unlock_irqrestore(&obj_pool, flags);
 
-	hlist_for_each_entry_safe(obj, tmp, &tofree, node) {
-		hlist_del(&obj->node);
+	hlist_bl_for_each_entry_safe(obj, tmp, n, &tofree, node) {
+		hlist_bl_del(&obj->node);
 		kmem_cache_free(obj_cache, obj);
 	}
 }
@@ -350,7 +346,7 @@ static void __free_object(struct debug_obj *obj)
 	 */
 	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
 	if (percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
-		hlist_add_head(&obj->node, &percpu_pool->free_objs);
+		hlist_bl_add_head(&obj->node, &percpu_pool->free_objs);
 		percpu_pool->obj_free++;
 		local_irq_restore(flags);
 		return;
@@ -368,19 +364,19 @@ static void __free_object(struct debug_obj *obj)
 	}
 
 free_to_obj_pool:
-	raw_spin_lock(&pool_lock);
+	hlist_bl_lock(&obj_pool);
 	work = (obj_pool_free > debug_objects_pool_size) && obj_cache &&
 	       (obj_nr_tofree < ODEBUG_FREE_WORK_MAX);
 	obj_pool_used--;
 
 	if (work) {
 		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
-		hlist_add_head(&obj->node, &obj_to_free);
+		hlist_bl_add_head(&obj->node, &obj_to_free);
 		if (lookahead_count) {
 			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + lookahead_count);
 			obj_pool_used -= lookahead_count;
 			while (lookahead_count) {
-				hlist_add_head(&objs[--lookahead_count]->node,
+				hlist_bl_add_head(&objs[--lookahead_count]->node,
 					       &obj_to_free);
 			}
 		}
@@ -394,24 +390,24 @@ static void __free_object(struct debug_obj *obj)
 			 */
 			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
 				obj = __alloc_object(&obj_pool);
-				hlist_add_head(&obj->node, &obj_to_free);
+				hlist_bl_add_head(&obj->node, &obj_to_free);
 				WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
 				WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
 			}
 		}
 	} else {
 		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		hlist_add_head(&obj->node, &obj_pool);
+		hlist_bl_add_head(&obj->node, &obj_pool);
 		if (lookahead_count) {
 			WRITE_ONCE(obj_pool_free, obj_pool_free + lookahead_count);
 			obj_pool_used -= lookahead_count;
 			while (lookahead_count) {
-				hlist_add_head(&objs[--lookahead_count]->node,
+				hlist_bl_add_head(&objs[--lookahead_count]->node,
 					       &obj_pool);
 			}
 		}
 	}
-	raw_spin_unlock(&pool_lock);
+	hlist_bl_unlock(&obj_pool);
 	local_irq_restore(flags);
 }
 
@@ -432,21 +428,21 @@ static void free_object(struct debug_obj *obj)
 static int object_cpu_offline(unsigned int cpu)
 {
 	struct debug_percpu_free *percpu_pool;
-	struct hlist_node *tmp;
+	struct hlist_bl_node *tmp, *n;
 	struct debug_obj *obj;
 	unsigned long flags;
 
 	/* Remote access is safe as the CPU is dead already */
 	percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
-	hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
-		hlist_del(&obj->node);
+	hlist_bl_for_each_entry_safe(obj, tmp, n, &percpu_pool->free_objs, node) {
+		hlist_bl_del(&obj->node);
 		kmem_cache_free(obj_cache, obj);
 	}
 
-	raw_spin_lock_irqsave(&pool_lock, flags);
+	hlist_bl_lock_irqsave(&obj_pool, flags);
 	obj_pool_used -= percpu_pool->obj_free;
 	debug_objects_freed += percpu_pool->obj_free;
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
+	hlist_bl_unlock_irqrestore(&obj_pool, flags);
 
 	percpu_pool->obj_free = 0;
 
@@ -460,23 +456,23 @@ static int object_cpu_offline(unsigned int cpu)
  */
 static void debug_objects_oom(void)
 {
-	struct debug_bucket *db = obj_hash;
-	struct hlist_node *tmp;
-	HLIST_HEAD(freelist);
+	struct hlist_bl_head *list = obj_hash;
+	struct hlist_bl_node *tmp;
+	HLIST_BL_HEAD(freelist);
 	struct debug_obj *obj;
 	unsigned long flags;
 	int i;
 
 	pr_warn("Out of memory. ODEBUG disabled\n");
 
-	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
-		raw_spin_lock_irqsave(&db->lock, flags);
-		hlist_move_list(&db->list, &freelist);
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+	for (i = 0; i < ODEBUG_HASH_SIZE; i++, list++) {
+		hlist_bl_lock_irqsave(list, flags);
+		hlist_bl_move_list(list, &freelist);
+		hlist_bl_unlock_irqrestore(list, flags);
 
 		/* Now free them */
 		hlist_for_each_entry_safe(obj, tmp, &freelist, node) {
-			hlist_del(&obj->node);
+			hlist_bl_del(&obj->node);
 			free_object(obj);
 		}
 	}
@@ -486,7 +482,7 @@ static void debug_objects_oom(void)
  * We use the pfn of the address for the hash. That way we can check
  * for freed objects simply by checking the affected bucket.
  */
-static struct debug_bucket *get_bucket(unsigned long addr)
+static struct hlist_bl_head *get_bucket(unsigned long addr)
 {
 	unsigned long hash;
 
@@ -558,11 +554,11 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 	WARN_ON(1);
 }
 
-static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket *b,
+static struct debug_obj *lookup_object_or_alloc(void *addr, struct hlist_bl_head *list,
 						const struct debug_obj_descr *descr,
 						bool onstack, bool alloc_ifstatic)
 {
-	struct debug_obj *obj = lookup_object(addr, b);
+	struct debug_obj *obj = lookup_object(addr, list);
 	enum debug_obj_state state = ODEBUG_STATE_NONE;
 
 	if (likely(obj))
@@ -585,7 +581,7 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket
 		state = ODEBUG_STATE_INIT;
 	}
 
-	obj = alloc_object(addr, b, descr);
+	obj = alloc_object(addr, list, descr);
 	if (likely(obj)) {
 		obj->state = state;
 		debug_object_is_on_stack(addr, onstack);
@@ -622,18 +618,18 @@ static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
 	struct debug_obj *obj, o;
-	struct debug_bucket *db;
+	struct hlist_bl_head *list;
 	unsigned long flags;
 
 	debug_objects_fill_pool();
 
-	db = get_bucket((unsigned long) addr);
+	list = get_bucket((unsigned long) addr);
 
-	raw_spin_lock_irqsave(&db->lock, flags);
+	hlist_bl_lock_irqsave(list, flags);
 
-	obj = lookup_object_or_alloc(addr, db, descr, onstack, false);
+	obj = lookup_object_or_alloc(addr, list, descr, onstack, false);
 	if (unlikely(!obj)) {
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+		hlist_bl_unlock_irqrestore(list, flags);
 		debug_objects_oom();
 		return;
 	}
@@ -643,14 +639,14 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	case ODEBUG_STATE_INIT:
 	case ODEBUG_STATE_INACTIVE:
 		obj->state = ODEBUG_STATE_INIT;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+		hlist_bl_unlock_irqrestore(list, flags);
 		return;
 	default:
 		break;
 	}
 
 	o = *obj;
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	hlist_bl_unlock_irqrestore(list, flags);
 	debug_print_object(&o, "init");
 
 	if (o.state == ODEBUG_STATE_ACTIVE)
@@ -695,7 +691,7 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
 int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
-	struct debug_bucket *db;
+	struct hlist_bl_head *list;
 	struct debug_obj *obj;
 	unsigned long flags;
 
@@ -704,13 +700,13 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 
 	debug_objects_fill_pool();
 
-	db = get_bucket((unsigned long) addr);
+	list = get_bucket((unsigned long) addr);
 
-	raw_spin_lock_irqsave(&db->lock, flags);
+	hlist_bl_lock_irqsave(list, flags);
 
-	obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	obj = lookup_object_or_alloc(addr, list, descr, false, true);
 	if (unlikely(!obj)) {
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+		hlist_bl_unlock_irqrestore(list, flags);
 		debug_objects_oom();
 		return 0;
 	} else if (likely(!IS_ERR(obj))) {
@@ -724,12 +720,12 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 			obj->state = ODEBUG_STATE_ACTIVE;
 			fallthrough;
 		default:
-			raw_spin_unlock_irqrestore(&db->lock, flags);
+			hlist_bl_unlock_irqrestore(list, flags);
 			return 0;
 		}
 	}
 
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	hlist_bl_unlock_irqrestore(list, flags);
 	debug_print_object(&o, "activate");
 
 	switch (o.state) {
@@ -752,18 +748,18 @@ EXPORT_SYMBOL_GPL(debug_object_activate);
 void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
-	struct debug_bucket *db;
+	struct hlist_bl_head *list;
 	struct debug_obj *obj;
 	unsigned long flags;
 
 	if (!debug_objects_enabled)
 		return;
 
-	db = get_bucket((unsigned long) addr);
+	list = get_bucket((unsigned long) addr);
 
-	raw_spin_lock_irqsave(&db->lock, flags);
+	hlist_bl_lock_irqsave(list, flags);
 
-	obj = lookup_object(addr, db);
+	obj = lookup_object(addr, list);
 	if (obj) {
 		switch (obj->state) {
 		case ODEBUG_STATE_DESTROYED:
@@ -776,13 +772,13 @@ void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 			obj->state = ODEBUG_STATE_INACTIVE;
 			fallthrough;
 		default:
-			raw_spin_unlock_irqrestore(&db->lock, flags);
+			hlist_bl_unlock_irqrestore(list, flags);
 			return;
 		}
 		o = *obj;
 	}
 
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	hlist_bl_unlock_irqrestore(list, flags);
 	debug_print_object(&o, "deactivate");
 }
 EXPORT_SYMBOL_GPL(debug_object_deactivate);
@@ -795,19 +791,19 @@ EXPORT_SYMBOL_GPL(debug_object_deactivate);
 void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_obj *obj, o;
-	struct debug_bucket *db;
+	struct hlist_bl_head *list;
 	unsigned long flags;
 
 	if (!debug_objects_enabled)
 		return;
 
-	db = get_bucket((unsigned long) addr);
+	list = get_bucket((unsigned long) addr);
 
-	raw_spin_lock_irqsave(&db->lock, flags);
+	hlist_bl_lock_irqsave(list, flags);
 
-	obj = lookup_object(addr, db);
+	obj = lookup_object(addr, list);
 	if (!obj) {
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+		hlist_bl_unlock_irqrestore(list, flags);
 		return;
 	}
 
@@ -821,12 +817,12 @@ void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 		obj->state = ODEBUG_STATE_DESTROYED;
 		fallthrough;
 	default:
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+		hlist_bl_unlock_irqrestore(list, flags);
 		return;
 	}
 
 	o = *obj;
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	hlist_bl_unlock_irqrestore(list, flags);
 	debug_print_object(&o, "destroy");
 
 	if (o.state == ODEBUG_STATE_ACTIVE)
@@ -842,19 +838,19 @@ EXPORT_SYMBOL_GPL(debug_object_destroy);
 void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_obj *obj, o;
-	struct debug_bucket *db;
+	struct hlist_bl_head *list;
 	unsigned long flags;
 
 	if (!debug_objects_enabled)
 		return;
 
-	db = get_bucket((unsigned long) addr);
+	list = get_bucket((unsigned long) addr);
 
-	raw_spin_lock_irqsave(&db->lock, flags);
+	hlist_bl_lock_irqsave(list, flags);
 
-	obj = lookup_object(addr, db);
+	obj = lookup_object(addr, list);
 	if (!obj) {
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+		hlist_bl_unlock_irqrestore(list, flags);
 		return;
 	}
 
@@ -862,14 +858,14 @@ void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 	case ODEBUG_STATE_ACTIVE:
 		break;
 	default:
-		hlist_del(&obj->node);
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+		hlist_bl_del(&obj->node);
+		hlist_bl_unlock_irqrestore(list, flags);
 		free_object(obj);
 		return;
 	}
 
 	o = *obj;
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	hlist_bl_unlock_irqrestore(list, flags);
 	debug_print_object(&o, "free");
 
 	debug_object_fixup(descr->fixup_free, addr, o.state);
@@ -884,7 +880,7 @@ EXPORT_SYMBOL_GPL(debug_object_free);
 void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
-	struct debug_bucket *db;
+	struct hlist_bl_head *list;
 	struct debug_obj *obj;
 	unsigned long flags;
 
@@ -893,11 +889,11 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 
 	debug_objects_fill_pool();
 
-	db = get_bucket((unsigned long) addr);
+	list = get_bucket((unsigned long) addr);
 
-	raw_spin_lock_irqsave(&db->lock, flags);
-	obj = lookup_object_or_alloc(addr, db, descr, false, true);
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	hlist_bl_lock_irqsave(list, flags);
+	obj = lookup_object_or_alloc(addr, list, descr, false, true);
+	hlist_bl_unlock_irqrestore(list, flags);
 	if (likely(!IS_ERR_OR_NULL(obj)))
 		return;
 
@@ -925,25 +921,25 @@ debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 			  unsigned int expect, unsigned int next)
 {
 	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
-	struct debug_bucket *db;
+	struct hlist_bl_head *list;
 	struct debug_obj *obj;
 	unsigned long flags;
 
 	if (!debug_objects_enabled)
 		return;
 
-	db = get_bucket((unsigned long) addr);
+	list = get_bucket((unsigned long) addr);
 
-	raw_spin_lock_irqsave(&db->lock, flags);
+	hlist_bl_lock_irqsave(list, flags);
 
-	obj = lookup_object(addr, db);
+	obj = lookup_object(addr, list);
 	if (obj) {
 		switch (obj->state) {
 		case ODEBUG_STATE_ACTIVE:
 			if (obj->astate != expect)
 				break;
 			obj->astate = next;
-			raw_spin_unlock_irqrestore(&db->lock, flags);
+			hlist_bl_unlock_irqrestore(list, flags);
 			return;
 		default:
 			break;
@@ -951,7 +947,7 @@ debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 		o = *obj;
 	}
 
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	hlist_bl_unlock_irqrestore(list, flags);
 	debug_print_object(&o, "active_state");
 }
 EXPORT_SYMBOL_GPL(debug_object_active_state);
@@ -962,8 +958,8 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
 	int cnt, objs_checked = 0;
 	struct debug_obj *obj, o;
-	struct debug_bucket *db;
-	struct hlist_node *tmp;
+	struct hlist_bl_head *list;
+	struct hlist_bl_node *tmp, *n;
 
 	saddr = (unsigned long) address;
 	eaddr = saddr + size;
@@ -972,12 +968,12 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 	chunks >>= ODEBUG_CHUNK_SHIFT;
 
 	for (;chunks > 0; chunks--, paddr += ODEBUG_CHUNK_SIZE) {
-		db = get_bucket(paddr);
+		list = get_bucket(paddr);
 
 repeat:
 		cnt = 0;
-		raw_spin_lock_irqsave(&db->lock, flags);
-		hlist_for_each_entry_safe(obj, tmp, &db->list, node) {
+		hlist_bl_lock_irqsave(list, flags);
+		hlist_bl_for_each_entry_safe(obj, tmp, n, list, node) {
 			cnt++;
 			oaddr = (unsigned long) obj->object;
 			if (oaddr < saddr || oaddr >= eaddr)
@@ -986,17 +982,17 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 			switch (obj->state) {
 			case ODEBUG_STATE_ACTIVE:
 				o = *obj;
-				raw_spin_unlock_irqrestore(&db->lock, flags);
+				hlist_bl_unlock_irqrestore(list, flags);
 				debug_print_object(&o, "free");
 				debug_object_fixup(o.descr->fixup_free, (void *)oaddr, o.state);
 				goto repeat;
 			default:
-				hlist_del(&obj->node);
+				hlist_bl_del(&obj->node);
 				__free_object(obj);
 				break;
 			}
 		}
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+		hlist_bl_unlock_irqrestore(list, flags);
 
 		if (cnt > debug_objects_maxchain)
 			debug_objects_maxchain = cnt;
@@ -1162,16 +1158,16 @@ static bool __init fixup_free(void *addr, enum debug_obj_state state)
 static int __init
 check_results(void *addr, enum debug_obj_state state, int fixups, int warnings)
 {
-	struct debug_bucket *db;
+	struct hlist_bl_head *list;
 	struct debug_obj *obj;
 	unsigned long flags;
 	int res = -EINVAL;
 
-	db = get_bucket((unsigned long) addr);
+	list = get_bucket((unsigned long) addr);
 
-	raw_spin_lock_irqsave(&db->lock, flags);
+	hlist_bl_lock_irqsave(list, flags);
 
-	obj = lookup_object(addr, db);
+	obj = lookup_object(addr, list);
 	if (!obj && state != ODEBUG_STATE_NONE) {
 		WARN(1, KERN_ERR "ODEBUG: selftest object not found\n");
 		goto out;
@@ -1193,7 +1189,7 @@ check_results(void *addr, enum debug_obj_state state, int fixups, int warnings)
 	}
 	res = 0;
 out:
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	hlist_bl_unlock_irqrestore(list, flags);
 	if (res)
 		debug_objects_enabled = 0;
 	return res;
@@ -1294,10 +1290,10 @@ void __init debug_objects_early_init(void)
 	int i;
 
 	for (i = 0; i < ODEBUG_HASH_SIZE; i++)
-		raw_spin_lock_init(&obj_hash[i].lock);
+		INIT_HLIST_BL_HEAD(&obj_hash[i]);
 
 	for (i = 0; i < ODEBUG_POOL_SIZE; i++)
-		hlist_add_head(&obj_static_pool[i].node, &obj_pool);
+		hlist_bl_add_head(&obj_static_pool[i].node, &obj_pool);
 }
 
 /*
@@ -1305,17 +1301,17 @@ void __init debug_objects_early_init(void)
  */
 static int __init debug_objects_replace_static_objects(void)
 {
-	struct debug_bucket *db = obj_hash;
-	struct hlist_node *tmp;
+	struct hlist_bl_head *head = obj_hash;
+	struct hlist_bl_node *tmp, *n;
 	struct debug_obj *obj, *new;
-	HLIST_HEAD(objects);
+	HLIST_BL_HEAD(objects);
 	int i, cnt = 0;
 
 	for (i = 0; i < ODEBUG_POOL_SIZE; i++) {
 		obj = kmem_cache_zalloc(obj_cache, GFP_KERNEL);
 		if (!obj)
 			goto free;
-		hlist_add_head(&obj->node, &objects);
+		hlist_bl_add_head(&obj->node, &objects);
 	}
 
 	debug_objects_allocated += i;
@@ -1327,21 +1323,21 @@ static int __init debug_objects_replace_static_objects(void)
 	 */
 
 	/* Remove the statically allocated objects from the pool */
-	hlist_for_each_entry_safe(obj, tmp, &obj_pool, node)
-		hlist_del(&obj->node);
+	hlist_bl_for_each_entry_safe(obj, tmp, n, &obj_pool, node)
+		hlist_bl_del(&obj->node);
 	/* Move the allocated objects to the pool */
-	hlist_move_list(&objects, &obj_pool);
+	hlist_bl_move_list(&objects, &obj_pool);
 
 	/* Replace the active object references */
-	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
-		hlist_move_list(&db->list, &objects);
+	for (i = 0; i < ODEBUG_HASH_SIZE; i++, head++) {
+		hlist_bl_move_list(head, &objects);
 
-		hlist_for_each_entry(obj, &objects, node) {
-			new = hlist_entry(obj_pool.first, typeof(*obj), node);
-			hlist_del(&new->node);
+		hlist_bl_for_each_entry(obj, tmp, &objects, node) {
+			new = hlist_bl_entry(hlist_bl_first(&obj_pool), typeof(*obj), node);
+			hlist_bl_del(&new->node);
 			/* copy object data */
 			*new = *obj;
-			hlist_add_head(&new->node, &db->list);
+			hlist_bl_add_head(&new->node, head);
 			cnt++;
 		}
 	}
@@ -1350,8 +1346,8 @@ static int __init debug_objects_replace_static_objects(void)
 		 cnt, obj_pool_used);
 	return 0;
 free:
-	hlist_for_each_entry_safe(obj, tmp, &objects, node) {
-		hlist_del(&obj->node);
+	hlist_bl_for_each_entry_safe(obj, tmp, n, &objects, node) {
+		hlist_bl_del(&obj->node);
 		kmem_cache_free(obj_cache, obj);
 	}
 	return -ENOMEM;
@@ -1377,7 +1373,7 @@ void __init debug_objects_mem_init(void)
 	 * completeness.
 	 */
 	for_each_possible_cpu(cpu)
-		INIT_HLIST_HEAD(&per_cpu(percpu_obj_pool.free_objs, cpu));
+		INIT_HLIST_BL_HEAD(&per_cpu(percpu_obj_pool.free_objs, cpu));
 
 	obj_cache = kmem_cache_create("debug_objects_cache",
 				      sizeof (struct debug_obj), 0,
-- 
2.45.2


