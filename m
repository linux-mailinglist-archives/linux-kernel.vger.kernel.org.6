Return-Path: <linux-kernel+bounces-353887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7089933FD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1115D283869
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BA71DDC31;
	Mon,  7 Oct 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K1cT0xsA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sXuiqRvP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF71DDA34
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319813; cv=none; b=VsQHM6QA/YF9MbKoIn/LGoaaOJoybP3839EknHfNvXYIbCIlsvM8h3YCZj6fVt306nxndHtOL/vlWOJMdWM7yP8shGRzPBGN5t7Pk3O3Yfw7ZNaezuSSHFpLNBd4Klrow4xAXSlREq4MfHBLu5NlAnhSdetckwTQ+7WPMR1SGD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319813; c=relaxed/simple;
	bh=R8YmF0GjRlr0cM8252feIJU66w97dlkN40Ue5mmiqu8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=kztzrEMFuv1N0yFKPhcVq9pFRTCreTW7ixcXrJmMAvZgo2SL82AmjvrIvrlATLD65FZ4UNz6ETSvGq9RSWoxx2Eu3AhyfegkSkzbFWri1Pq1qiR4iEqUjHB8ERrH76EqzaPfaqE3ysSZf2+EmYHTDTsNmxr2LT42vuNHYHNNfks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K1cT0xsA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sXuiqRvP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.955542307@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8NTqjYqyTRgkGxIw/yZ5nqyqj1AMPCRe3Sjf3y1Rql0=;
	b=K1cT0xsA8fjsDmISnqkVGv7mwVJ7nBxXqh/XM1RI9rB+Exjm7X+0S3NFNGRBBiMbFR8gHD
	zwvA693CHZzJbtmNRW2gUDtDCOj5fTJarHxZvrncSxWHtF/UqQ0po98qz/Od8pwLApo7w6
	9llGzle09wDUhDy1ZSqMoUyrBqM64O0Xm/vweqbZi+rgoa6dBUTkRLMNzS6TUYGezCMRAE
	cSQxzWsbIrWnE6xRbGw5wrBXmhm3461sMd3vLPCp8C+i2DoRR/+MoKKffmxhn33oOt8ME0
	xtr/IQ8i9uJzqmlEQ/lbA7PnjkJorN+kUehi1pU2iDHvwt6rImhmMhVpr824fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8NTqjYqyTRgkGxIw/yZ5nqyqj1AMPCRe3Sjf3y1Rql0=;
	b=sXuiqRvPoug9UDEQq4kNiHavrlkzMhPe+NLOcYRBOmtuLOIfyBZBNOsM/X6EuO8NoJlIr1
	fx3cRWZTnfPyBwDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 16/25] debugobjects: Rework object freeing
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:10 +0200 (CEST)

__free_object() is uncomprehensibly complex. The same can be achieved by:

   1) Adding the object to the per CPU pool

   2) If that pool is full, move a batch of objects into the global pool
      or if the global pool is full into the to free pool

This also prepares for batch processing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   99 ++++++++++++-----------------------------------------
 1 file changed, 24 insertions(+), 75 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -199,6 +199,27 @@ static struct debug_obj *pcpu_alloc(void
 	}
 }
 
+static void pcpu_free(struct debug_obj *obj)
+{
+	struct obj_pool *pcp = this_cpu_ptr(&pool_pcpu);
+
+	lockdep_assert_irqs_disabled();
+
+	hlist_add_head(&obj->node, &pcp->objects);
+	pcp->cnt++;
+
+	/* Pool full ? */
+	if (pcp->cnt < ODEBUG_POOL_PERCPU_SIZE)
+		return;
+
+	/* Remove a batch from the per CPU pool */
+	guard(raw_spinlock)(&pool_lock);
+	/* Try to fit the batch into the pool_global first */
+	if (!pool_move_batch(&pool_global, pcp))
+		pool_move_batch(&pool_to_free, pcp);
+	obj_pool_used -= ODEBUG_BATCH_SIZE;
+}
+
 static void free_object_list(struct hlist_head *head)
 {
 	struct hlist_node *tmp;
@@ -375,83 +396,11 @@ static void free_obj_work(struct work_st
 
 static void __free_object(struct debug_obj *obj)
 {
-	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
-	struct obj_pool *percpu_pool;
-	int lookahead_count = 0;
-	bool work;
-
 	guard(irqsave)();
-
-	if (unlikely(!obj_cache)) {
+	if (likely(obj_cache))
+		pcpu_free(obj);
+	else
 		hlist_add_head(&obj->node, &pool_boot);
-		return;
-	}
-
-	/*
-	 * Try to free it into the percpu pool first.
-	 */
-	percpu_pool = this_cpu_ptr(&pool_pcpu);
-	if (percpu_pool->cnt < ODEBUG_POOL_PERCPU_SIZE) {
-		hlist_add_head(&obj->node, &percpu_pool->objects);
-		percpu_pool->cnt++;
-		return;
-	}
-
-	/*
-	 * As the percpu pool is full, look ahead and pull out a batch
-	 * of objects from the percpu pool and free them as well.
-	 */
-	for (; lookahead_count < ODEBUG_BATCH_SIZE; lookahead_count++) {
-		objs[lookahead_count] = __alloc_object(&percpu_pool->objects);
-		if (!objs[lookahead_count])
-			break;
-		percpu_pool->cnt--;
-	}
-
-	raw_spin_lock(&pool_lock);
-	work = (pool_global.cnt > pool_global.max_cnt) && obj_cache &&
-	       (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX);
-	obj_pool_used--;
-
-	if (work) {
-		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + 1);
-		hlist_add_head(&obj->node, &pool_to_free.objects);
-		if (lookahead_count) {
-			WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + lookahead_count);
-			obj_pool_used -= lookahead_count;
-			while (lookahead_count) {
-				hlist_add_head(&objs[--lookahead_count]->node,
-					       &pool_to_free.objects);
-			}
-		}
-
-		if ((pool_global.cnt > pool_global.max_cnt) &&
-		    (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX)) {
-			int i;
-
-			/*
-			 * Free one more batch of objects from obj_pool.
-			 */
-			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
-				obj = __alloc_object(&pool_global.objects);
-				hlist_add_head(&obj->node, &pool_to_free.objects);
-				WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
-				WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + 1);
-			}
-		}
-	} else {
-		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
-		hlist_add_head(&obj->node, &pool_global.objects);
-		if (lookahead_count) {
-			WRITE_ONCE(pool_global.cnt, pool_global.cnt + lookahead_count);
-			obj_pool_used -= lookahead_count;
-			while (lookahead_count) {
-				hlist_add_head(&objs[--lookahead_count]->node,
-					       &pool_global.objects);
-			}
-		}
-	}
-	raw_spin_unlock(&pool_lock);
 }
 
 /*


