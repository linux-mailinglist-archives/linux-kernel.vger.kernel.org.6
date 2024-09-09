Return-Path: <linux-kernel+bounces-321338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA7E9718F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B10B1F22D94
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404F1B6535;
	Mon,  9 Sep 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jLlJJ58E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kxtWvAKe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801CC172BCE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883850; cv=none; b=scFsNxnuhurRU7QH7ypWKiT1g/Uak6tgnMEIqGIdelf2inywTFE0YsEnp+1LdKMv2/WdsJj28mGZIS1ESoEVQfTz5m/jmZfp1I/GOTOikkd8UMqR8tCdi6guQqQ0Eq2kksNC9MFzviWrVqjJZkm5G2NkEN8wFRwDNBYLnmwTzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883850; c=relaxed/simple;
	bh=LYqKpqVx/QdkW8kffX1bnWBV6xPiET67YAC+mBLmST0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=afdBvj3w6NsXrK2d2YzgpIE8eyrj8p5/HcEEHLtPD6uahgOihE72DlAP3S5cL7UbvX9DnpB3/swyB8BojNPxRZDIOlw1e4VlT6bjDqQMQdpO62b/9lFqMsI3ZWiEVbhMFl23KDm/gP2y0vCyxH69cDnEvI5UpuBCzf5u+6q6Z04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jLlJJ58E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kxtWvAKe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725883846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/jl45tWkaKNif552yzuyiAMyiPg06sn4vIphCIXfpY=;
	b=jLlJJ58Et7+aczenyONIzhhPrtDntec4+/6J/Pb/75IeY6vHOiRjPCVVqIfMw+dzpMjKjL
	e4gfq/9rqmG5gnLJOI/H8uHf4fX5v7uRBCFwmeN6i3rmt6JyvuknAPPsWfkEbTLsBfDGr8
	/52TQHX0zqsHypGUsdzc6hlYD5RdCcGIy/vHzYAV48GeaJQp1Qnk/pTQsDlO11ESlHUZQP
	KTCbSAD4ChOX2MqGcj8N7Gm1QVpbuI1/ol0VPiQANswTo1TrHQuysaSGYVUMKZatrD93vM
	PCRmJSLY9PWOZECTlIKjvL8iNLwsoArKUVJcsC2TDs4CidUdM1O6MzbdALiP+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725883846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/jl45tWkaKNif552yzuyiAMyiPg06sn4vIphCIXfpY=;
	b=kxtWvAKeT5h7qIstcIjt26wC7crED74BqgW87iGFJcR09Z6qr5gXzWiv+NYYDX0wIeTr+f
	KxweYuKenWvbGrAg==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] debugobjects: Don't start fill if there are
 remaining nodes locally
In-Reply-To: <87ed5tchc6.ffs@tglx>
References: <20240904133944.2124-1-thunder.leizhen@huawei.com>
 <20240904133944.2124-5-thunder.leizhen@huawei.com>
 <336109d9-2eea-4d67-ee22-ed218b9504c3@huawei.com>
 <7613ce35-0c65-341f-c6ed-412de79890e6@huawei.com> <87ed5tchc6.ffs@tglx>
Date: Mon, 09 Sep 2024 14:10:45 +0200
Message-ID: <87bk0xc9iy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 09 2024 at 11:22, Thomas Gleixner wrote:
> On Thu, Sep 05 2024 at 11:45, Leizhen wrote:
>> +               obj = kmem_cache_zalloc(obj_cache, __GFP_HIGH | GFP_NOWAIT);
>> +               if (!obj)
>> +                       return NULL;
>
> No. That fails on RT. See debug_object_fill_pool().

Some more thoughts on this. The goal is to reduce contention on pool
lock. At the same time, this needs to ensure that the opportunistic fill
mechanism actually works reliably.

debug_object_fill_pool() is invoked from

    - debug_object_init()
    - debug_object_assert_init()
    - debug_object_activate()

debug_object_init() is usually invoked from preemptible context. It will
most of the time consume a tracking object from the per CPU or the
global pool because re-initialization of a tracked object is rather
rare.

debug_object_assert_init() and debug_object_activate() only consume a
tracking object, when the to be tracked object is statically
initialized or the call site failed to initialize the object. Both can
be called from arbitrary contexts even under PREEMPT_RT, where
preemptible context is a prerequisite for pool refill via allocations.

And of course any CPU which sits in fill_pool() can be preempted if the
calling context is preemptible. And no, we can't disable preemption
accross the whole thing due to RT.

So something like the uncompiled below should reduce lock contention
significantly with a reasonable safety net.

Thanks,

        tglx
---
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -125,14 +125,10 @@ static const char *obj_states[ODEBUG_STA
 	[ODEBUG_STATE_NOTAVAILABLE]	= "not available",
 };
 
-static void fill_pool(void)
+static void fill_pool_from_freelist(void)
 {
-	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
+	static unsigned long state;
 	struct debug_obj *obj;
-	unsigned long flags;
-
-	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
-		return;
 
 	/*
 	 * Reuse objs from the global obj_to_free list; they will be
@@ -141,25 +137,57 @@ static void fill_pool(void)
 	 * obj_nr_tofree is checked locklessly; the READ_ONCE() pairs with
 	 * the WRITE_ONCE() in pool_lock critical sections.
 	 */
-	if (READ_ONCE(obj_nr_tofree)) {
-		raw_spin_lock_irqsave(&pool_lock, flags);
-		/*
-		 * Recheck with the lock held as the worker thread might have
-		 * won the race and freed the global free list already.
-		 */
-		while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
-			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
-			hlist_del(&obj->node);
-			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
-			hlist_add_head(&obj->node, &obj_pool);
-			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		}
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
+	if (!READ_ONCE(obj_nr_tofree))
+		return;
+
+	/*
+	 * Prevent the context from being scheduled or interrupted after
+	 * setting the state flag;
+	 */
+	guard(irqsave)();
+
+	/*
+	 * Avoid lock contention on &pool_lock and avoid making the cache
+	 * line exclusive by testing the bit before attempting to set it.
+	 */
+	if (test_bit(0, &state) || test_and_set_bit(0, &state))
+		return;
+
+	guard(raw_spinlock)(&pool_lock);
+	/*
+	 * Recheck with the lock held as the worker thread might have
+	 * won the race and freed the global free list already.
+	 */
+	while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
+		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
+		hlist_del(&obj->node);
+		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
+		hlist_add_head(&obj->node, &obj_pool);
+		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
 	}
+	clear_bit(0, &state);
+}
+
+static void fill_pool(void)
+{
+	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
+	static atomic_t cpus_allocating;
 
 	if (unlikely(!obj_cache))
 		return;
 
+	/*
+	 * Avoid allocation and lock contention when
+	 *
+	 *   - the CPU local pool has at least 2 objects left
+	 *   - another CPU is already in the allocation path
+	 *   - the global pool has not reached the critical level yet
+	 */
+	if (this_cpu_read(percpu_obj_pool.obj_free) > 1 && atomic_read(&cpus_allocating) &&
+	    READ_ONCE(obj_pool_free) > (debug_objects_pool_min_level / 2))
+		return;
+
+	atomic_inc(&cpus_allocating);
 	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
 		struct debug_obj *new[ODEBUG_BATCH_SIZE];
 		int cnt;
@@ -172,14 +200,14 @@ static void fill_pool(void)
 		if (!cnt)
 			return;
 
-		raw_spin_lock_irqsave(&pool_lock, flags);
+		guard(raw_spinlock_irqsave)(&pool_lock);
 		while (cnt) {
 			hlist_add_head(&new[--cnt]->node, &obj_pool);
 			debug_objects_allocated++;
 			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
 		}
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
+	atomic_dec(&cpus_allocating);
 }
 
 /*
@@ -598,6 +626,15 @@ static struct debug_obj *lookup_object_o
 
 static void debug_objects_fill_pool(void)
 {
+	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
+		return;
+
+	/* Try reusing objects from obj_to_free_list */
+	fill_pool_from_freelist();
+
+	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
+		return;
+
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
 	 * context -- for !RT kernels we rely on the fact that spinlock_t and

