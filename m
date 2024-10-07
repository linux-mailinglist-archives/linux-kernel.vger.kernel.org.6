Return-Path: <linux-kernel+bounces-353893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AAA993406
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891E71C23A7E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB3C1DDC21;
	Mon,  7 Oct 2024 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3iy5XBcx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWhpu0ZS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8226B1DC187
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319820; cv=none; b=qFGIW9bJE7dCDUQnkboce0W6z9kSPo0F95CdCoKErj8mc067LSLFW3DvCX5FkWPMVYi+ViJ4x4HxE2IRc2H4i+xD9Izz6h0tLWRLjgKAYW7Ew+MmXApP8wI/zAPa/nZB8sCtqpockKjfKUuCGRUAeiLzz7kPQfV7Sk0lVyKFOB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319820; c=relaxed/simple;
	bh=A/QoDAJ8UX7nh5/h6SAiKHXrp6KgHkiTwFui3vTEugs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=vFeg/+hv0u8JuSIZ+La5L0a2BYaUhHbTXW6EGi3yik+iRouEe6zJ3xAZV29aoODLI0BHBxTyEculPzgxO8Rte5EQ6WEXUdxAg++J8TlQLE9Tojozv7VolY4SKBuPUL1RDgiknt457byBVXjIoOSyqXkHRtTq4xMFEbEXYbVBC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3iy5XBcx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWhpu0ZS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164914.258995000@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2KVZpIKee4ylgIKgtuYLEAYJPCkBNT2M6tYQt6vWCCo=;
	b=3iy5XBcxVzTRm1l4neosADf9zarTysfMYt91IJ1rRHiKjelEoQbss8/7SnF5ih+mZqQpKw
	0Vgw6Aa7ijL8ey7rKvfh9/zvtQyby4y0sUh59u7B5YWzNjMhQNKZ9DcdMPWI1pk7NKx+I3
	mRK5h4f8uYkXPJYzk8cQH3lRYm9Uymms+0JOpuahvM2Ixgc1pKqJZqAu0KY7oPqvaTTlVe
	tz6RKFMVHTzf4+c3jx0ZR0+NwNdYLn0uTzs/ZmaVjvAhMbVwJj5EgLQGSBu5ZD0P6VcMkP
	5z9IyKSZ881wVIVurjEkHZauIKs01tHVq7laS9wtETyBCSnpsaD7ZUA/POph4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2KVZpIKee4ylgIKgtuYLEAYJPCkBNT2M6tYQt6vWCCo=;
	b=jWhpu0ZSHk/ECb2Rtw1Z1lokwnC71cRTVSUt/wD76qxZBcmN5WzU9bJUUt4S+yEl/VjRjT
	YJjRLGuUgC+9hgBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 21/25] debugobjects: Implement batch processing
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:17 +0200 (CEST)

Adding and removing single objects in a loop is bad in terms of lock
contention and cache line accesses.

To implement batching, record the last object in a batch in the object
itself. This is trivialy possible as hlists are strictly stacks. At a batch
boundary, when the first object is added to the list the object stores a
pointer to itself in debug_obj::batch_last. When the next object is added
to the list then the batch_last pointer is retrieved from the first object
in the list and stored in the to be added one.

That means for batch processing the first object always has a pointer to
the last object in a batch, which allows to move batches in a cache line
efficient way and reduces the lock held time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   61 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 15 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -149,18 +149,31 @@ static __always_inline bool pool_must_re
 
 static bool pool_move_batch(struct obj_pool *dst, struct obj_pool *src)
 {
-	if (dst->cnt + ODEBUG_BATCH_SIZE > dst->max_cnt || !src->cnt)
+	struct hlist_node *last, *next_batch, *first_batch;
+	struct debug_obj *obj;
+
+	if (dst->cnt >= dst->max_cnt || !src->cnt)
 		return false;
 
-	for (int i = 0; i < ODEBUG_BATCH_SIZE && src->cnt; i++) {
-		struct hlist_node *node = src->objects.first;
+	first_batch = src->objects.first;
+	obj = hlist_entry(first_batch, typeof(*obj), node);
+	last = obj->batch_last;
+	next_batch = last->next;
 
-		WRITE_ONCE(src->cnt, src->cnt - 1);
-		WRITE_ONCE(dst->cnt, dst->cnt + 1);
+	/* Move the next batch to the front of the source pool */
+	src->objects.first = next_batch;
+	if (next_batch)
+		next_batch->pprev = &src->objects.first;
+
+	/* Add the extracted batch to the destination pool */
+	last->next = dst->objects.first;
+	if (last->next)
+		last->next->pprev = &last->next;
+	first_batch->pprev = &dst->objects.first;
+	dst->objects.first = first_batch;
 
-		hlist_del(node);
-		hlist_add_head(node, &dst->objects);
-	}
+	WRITE_ONCE(src->cnt, src->cnt - ODEBUG_BATCH_SIZE);
+	WRITE_ONCE(dst->cnt, dst->cnt + ODEBUG_BATCH_SIZE);
 	return true;
 }
 
@@ -182,16 +195,27 @@ static bool pool_push_batch(struct obj_p
 
 static bool pool_pop_batch(struct hlist_head *head, struct obj_pool *src)
 {
+	struct hlist_node *last, *next;
+	struct debug_obj *obj;
+
 	if (!src->cnt)
 		return false;
 
-	for (int i = 0; src->cnt && i < ODEBUG_BATCH_SIZE; i++) {
-		struct hlist_node *node = src->objects.first;
+	/* Move the complete list to the head */
+	hlist_move_list(&src->objects, head);
 
-		WRITE_ONCE(src->cnt, src->cnt - 1);
-		hlist_del(node);
-		hlist_add_head(node, head);
-	}
+	obj = hlist_entry(head->first, typeof(*obj), node);
+	last = obj->batch_last;
+	next = last->next;
+	/* Disconnect the batch from the list */
+	last->next = NULL;
+
+	/* Move the node after last back to the source pool. */
+	src->objects.first = next;
+	if (next)
+		next->pprev = &src->objects.first;
+
+	WRITE_ONCE(src->cnt, src->cnt - ODEBUG_BATCH_SIZE);
 	return true;
 }
 
@@ -226,7 +250,7 @@ static struct debug_obj *pcpu_alloc(void
 			if (!pool_move_batch(pcp, &pool_global))
 				return NULL;
 		}
-		obj_pool_used += pcp->cnt;
+		obj_pool_used += ODEBUG_BATCH_SIZE;
 
 		if (obj_pool_used > obj_pool_max_used)
 			obj_pool_max_used = obj_pool_used;
@@ -239,9 +263,16 @@ static struct debug_obj *pcpu_alloc(void
 static void pcpu_free(struct debug_obj *obj)
 {
 	struct obj_pool *pcp = this_cpu_ptr(&pool_pcpu);
+	struct debug_obj *first;
 
 	lockdep_assert_irqs_disabled();
 
+	if (!(pcp->cnt % ODEBUG_BATCH_SIZE)) {
+		obj->batch_last = &obj->node;
+	} else {
+		first = hlist_entry(pcp->objects.first, typeof(*first), node);
+		obj->batch_last = first->batch_last;
+	}
 	hlist_add_head(&obj->node, &pcp->objects);
 	pcp->cnt++;
 


