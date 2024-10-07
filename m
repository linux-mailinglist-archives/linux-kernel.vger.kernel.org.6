Return-Path: <linux-kernel+bounces-353886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ABC9933FC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B67B1C23815
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739A1DD883;
	Mon,  7 Oct 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YiqDAhfL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l2NT/9Qy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE34D1DDA20
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319813; cv=none; b=cGPtBk6IaZfqihvrCp45e/tf5z0RvpFEuA7u1sYg2MTPOgdEV9EID3GcnvfT0nSUtnPyu/BIi+hnDKhywiUaJQdaN22D1ZugnLdaJHZouc4e41D0P72G6MaV99v7RRFmOddxkc2X361snAUKAYnNPYlw9oG54URdydEV5/IeFjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319813; c=relaxed/simple;
	bh=TG4W13Y2+J182jBOPq36tFXGWnSxPrWxhQ8KT35JGzQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rWbs9ZY04kD4/jirYw9sUaIlk77Y4mHQdSSgGHY4mz1H+lv074OcuEvqsO0Fa4+BhhdtS18ZYkAO0IFDYZIxKQIYk4EuigmZz/1KWe2KmmVzbfTYwwEOQDA9dEFm5oU6GrF0QQyOiIQjncjyb0fy34vpJFdurl0kstv46mYqH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YiqDAhfL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l2NT/9Qy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.893554162@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=p/HKRAt0Ud86tNjgylPgGhmPpraXRWuyB3Oxip/mEds=;
	b=YiqDAhfL93Ned49EPNDl2MGOnFacZkA4r1GMeZffvUuhK/8YBNmg8zn8iCmZ/xXRbn5day
	gTNjATUrRoSVfDdQYgx+fr83Fip8m5ebwnc8KSFudljrr0yKpEYUn1z1T0dEAg/jj53br3
	30jY1fTZRiynRuWdnP+7un/ToIbfvp4PFTcL4KXWel5gloLyljUZMVNCCrBjZHxOIQEmbI
	QoyWzzZFsONpaJGC2GfKZu3h6QtU2aLmVRURAYG3nU5eTHA+bZkd1x3u6tolTtfHuS/R29
	7XQnzSU6ZKORWfGWvSJ73yIoXjHNZ367eMtS+opczQLiJOautWX9FX7ODxJLNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=p/HKRAt0Ud86tNjgylPgGhmPpraXRWuyB3Oxip/mEds=;
	b=l2NT/9Qy4Y2fvCux6kBCYZt1oyY4ft6DjbPp0+CallgPiHcd3H4mn88FDclepyXMLCvP1i
	VVNClPKRe0GnixBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 15/25] debugobjects: Rework object allocation
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:09 +0200 (CEST)

The current allocation scheme tries to allocate from the per CPU pool
first. If that fails it allocates one object from the global pool and then
refills the per CPU pool from the global pool.

That is in the way of switching the pool management to batch mode as the
global pool needs to be a strict stack of batches, which does not allow
to allocate single objects.

Rework the code to refill the per CPU pool first and then allocate the
object from the refilled batch. Also try to allocate from the to free pool
first to avoid freeing and reallocating objects.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |  144 +++++++++++++++++++++++++----------------------------
 1 file changed, 69 insertions(+), 75 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -141,6 +141,64 @@ static __always_inline bool pool_must_re
 	return pool_count(pool) < pool->min_cnt / 2;
 }
 
+static bool pool_move_batch(struct obj_pool *dst, struct obj_pool *src)
+{
+	if (dst->cnt + ODEBUG_BATCH_SIZE > dst->max_cnt || !src->cnt)
+		return false;
+
+	for (int i = 0; i < ODEBUG_BATCH_SIZE && src->cnt; i++) {
+		struct hlist_node *node = src->objects.first;
+
+		WRITE_ONCE(src->cnt, src->cnt - 1);
+		WRITE_ONCE(dst->cnt, dst->cnt + 1);
+
+		hlist_del(node);
+		hlist_add_head(node, &dst->objects);
+	}
+	return true;
+}
+
+static struct debug_obj *__alloc_object(struct hlist_head *list)
+{
+	struct debug_obj *obj;
+
+	if (unlikely(!list->first))
+		return NULL;
+
+	obj = hlist_entry(list->first, typeof(*obj), node);
+	hlist_del(&obj->node);
+	return obj;
+}
+
+static struct debug_obj *pcpu_alloc(void)
+{
+	struct obj_pool *pcp = this_cpu_ptr(&pool_pcpu);
+
+	lockdep_assert_irqs_disabled();
+
+	for (;;) {
+		struct debug_obj *obj = __alloc_object(&pcp->objects);
+
+		if (likely(obj)) {
+			pcp->cnt--;
+			return obj;
+		}
+
+		guard(raw_spinlock)(&pool_lock);
+		if (!pool_move_batch(pcp, &pool_to_free)) {
+			if (!pool_move_batch(pcp, &pool_global))
+				return NULL;
+		}
+		obj_pool_used += pcp->cnt;
+
+		if (obj_pool_used > obj_pool_max_used)
+			obj_pool_max_used = obj_pool_used;
+
+		if (pool_global.cnt < obj_pool_min_free)
+			obj_pool_min_free = pool_global.cnt;
+	}
+}
+
 static void free_object_list(struct hlist_head *head)
 {
 	struct hlist_node *tmp;
@@ -158,7 +216,6 @@ static void free_object_list(struct hlis
 static void fill_pool_from_freelist(void)
 {
 	static unsigned long state;
-	struct debug_obj *obj;
 
 	/*
 	 * Reuse objs from the global obj_to_free list; they will be
@@ -180,17 +237,11 @@ static void fill_pool_from_freelist(void
 	if (test_bit(0, &state) || test_and_set_bit(0, &state))
 		return;
 
-	guard(raw_spinlock)(&pool_lock);
-	/*
-	 * Recheck with the lock held as the worker thread might have
-	 * won the race and freed the global free list already.
-	 */
-	while (pool_to_free.cnt && (pool_global.cnt < pool_global.min_cnt)) {
-		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
-		hlist_del(&obj->node);
-		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt - 1);
-		hlist_add_head(&obj->node, &pool_global.objects);
-		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
+	/* Avoid taking the lock when there is no work to do */
+	while (pool_should_refill(&pool_global) && pool_count(&pool_to_free)) {
+		guard(raw_spinlock)(&pool_lock);
+		/* Move a batch if possible */
+		pool_move_batch(&pool_global, &pool_to_free);
 	}
 	clear_bit(0, &state);
 }
@@ -251,74 +302,17 @@ static struct debug_obj *lookup_object(v
 	return NULL;
 }
 
-/*
- * Allocate a new object from the hlist
- */
-static struct debug_obj *__alloc_object(struct hlist_head *list)
+static struct debug_obj *alloc_object(void *addr, struct debug_bucket *b,
+				      const struct debug_obj_descr *descr)
 {
-	struct debug_obj *obj = NULL;
-
-	if (list->first) {
-		obj = hlist_entry(list->first, typeof(*obj), node);
-		hlist_del(&obj->node);
-	}
-
-	return obj;
-}
-
-static struct debug_obj *
-alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
-{
-	struct obj_pool *percpu_pool = this_cpu_ptr(&pool_pcpu);
 	struct debug_obj *obj;
 
-	if (likely(obj_cache)) {
-		obj = __alloc_object(&percpu_pool->objects);
-		if (obj) {
-			percpu_pool->cnt--;
-			goto init_obj;
-		}
-	} else {
+	if (likely(obj_cache))
+		obj = pcpu_alloc();
+	else
 		obj = __alloc_object(&pool_boot);
-		goto init_obj;
-	}
-
-	raw_spin_lock(&pool_lock);
-	obj = __alloc_object(&pool_global.objects);
-	if (obj) {
-		obj_pool_used++;
-		WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
-
-		/*
-		 * Looking ahead, allocate one batch of debug objects and
-		 * put them into the percpu free pool.
-		 */
-		if (likely(obj_cache)) {
-			int i;
-
-			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
-				struct debug_obj *obj2;
-
-				obj2 = __alloc_object(&pool_global.objects);
-				if (!obj2)
-					break;
-				hlist_add_head(&obj2->node, &percpu_pool->objects);
-				percpu_pool->cnt++;
-				obj_pool_used++;
-				WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
-			}
-		}
-
-		if (obj_pool_used > obj_pool_max_used)
-			obj_pool_max_used = obj_pool_used;
-
-		if (pool_global.cnt < obj_pool_min_free)
-			obj_pool_min_free = pool_global.cnt;
-	}
-	raw_spin_unlock(&pool_lock);
 
-init_obj:
-	if (obj) {
+	if (likely(obj)) {
 		obj->object = addr;
 		obj->descr  = descr;
 		obj->state  = ODEBUG_STATE_NONE;


