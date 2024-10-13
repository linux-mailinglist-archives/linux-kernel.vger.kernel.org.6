Return-Path: <linux-kernel+bounces-362897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD0199BADD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129CC1C209BA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515DF1487ED;
	Sun, 13 Oct 2024 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CEDXhFsm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TRaiBUFS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8823231CA8
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728845169; cv=none; b=JXKFIIjAUSStiPg/eMNWBw7Fg0Qf5wkLLK3zu5s6v0Kh06z/v80A7Zgb9XKSJTslAH02jwGHNcomxNN4ltk2y2pvLVNBHxh/SsCdUUy5wc5zMfJx2RrP6nZN8H07qHxxDkSVow3jTKqnDIcdyg9rVC4s4Yko+dddAxuFkrhj8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728845169; c=relaxed/simple;
	bh=ZUUE6w9XqTzrS9c117PlPCvS9snJEfp9O+s5IZaYj4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bdkgKRtbY7kAG52EVJoeAqmx++hg6UXhD6a9jHVj81FlQlCJWFyTXeMzM3cq32D0BnNN93vv6CKCDVaqQfhiGd8McpJ/GQ1egLbKGM2hrE9FFa23XIUo2mOQqVWUstTUrI4J8gkYNl31llVKBBH5m0RAna6UTDjnSve2vVI4gMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CEDXhFsm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TRaiBUFS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728845158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLWspbZVHLhgKlWgflGBy75KbQWaJx31B1gB7cguB2M=;
	b=CEDXhFsmpPWl5aSCpPObDL/sW7v/KMgVqpeLwI2GjbH3e1dGgY+os0F3PD2bRLW2XJK+4r
	0GDZIQ72R8Ij13nTaU8ZYfOJubM9K/HJAt4omtB/umxbbkkCJYTVWioKF9t09keIb0o2vk
	TKVEs9Pf71ckofODy1VOh6tJ/1hv4XZX+tFPus8OaqI9HwtUBYjWpVhCeYbZ8P0V6Okf+c
	N5q82ZToOTGQTS6UdehgyDPNr2RvRk8FdTepuamUX/sF2/ci7Jt7ZNOO8W77HdoVZ8kY/y
	ty7Xbih7AucMFH5cUQkWxgvLP2p784YJKBnAB2PYjr1kI8bhwg13IYzCiXzDyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728845158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLWspbZVHLhgKlWgflGBy75KbQWaJx31B1gB7cguB2M=;
	b=TRaiBUFSHbz+d5tEbH0qxHso55Wvn5Dr3PLLrtsYGCLF6LD7FOzvgUnYVW7JK4u3AZjd6p
	CEfsdxSXXzxRSwBA==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Waiman Long <longman@redhat.com>
Subject: Re: [patch 25/25] debugobjects: Track object usage to avoid
 premature freeing of objects
In-Reply-To: <33d4dca7-3a1b-c99d-7e76-160a5fca61c2@huawei.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.499184215@linutronix.de>
 <33d4dca7-3a1b-c99d-7e76-160a5fca61c2@huawei.com>
Date: Sun, 13 Oct 2024 20:45:57 +0200
Message-ID: <87bjznhme2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 10 2024 at 21:13, Leizhen wrote:
>> +static bool pool_can_fill(struct obj_pool *dst, struct obj_pool *src)
>> +{
>> +	unsigned int cnt = pool_count(dst);
>> +
>> +	if (cnt >= dst->min_cnt)
>> +		return true;
>
> There's already an interception in function debug_objects_fill_pool().
> It's unlikely to be true.
>
> debug_objects_fill_pool() --> fill_pool() --> pool_can_fill()
> :
> 	if (likely(!pool_should_refill(&pool_global)))
> 		return;

While they are different checks, you're right.

If fill_pool_from_freelist() reused objects and was no able to refill
the global pool above the threshold level, then fill_pool() won't find
objects enough objects in the to free pool to refill, so it's just
checking for a completely unlikely corner case.

I just validated that it does not make a difference. Updated patch below

Thanks for spotting this!

       tglx
---
Subject: debugobjects: Track object usage to avoid premature freeing of objects
From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 14 Sep 2024 21:33:19 +0200

The freelist is freed at a constant rate independent of the actual usage
requirements. That's bad in scenarios where usage comes in bursts. The end
of a burst puts the object on the free list and freeing proceeds even when
the next burst which requires objects started again.

Keep track of the usage with a exponentially wheighted moving average and
take that into account in the worker function which frees objects from the
free list.

This further reduces the kmem_cache allocation/free rate for a full kernel
compile:

   	    kmem_cache_alloc()	kmem_cache_free()
Baseline:   225k		245k
Usage:	    170k		117k

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -13,6 +13,7 @@
 #include <linux/hash.h>
 #include <linux/kmemleak.h>
 #include <linux/sched.h>
+#include <linux/sched/loadavg.h>
 #include <linux/sched/task_stack.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -86,6 +87,7 @@ static struct obj_pool pool_to_free = {
 
 static HLIST_HEAD(pool_boot);
 
+static unsigned long		avg_usage;
 static bool			obj_freeing;
 
 static int __data_racy			debug_objects_maxchain __read_mostly;
@@ -427,11 +429,31 @@ static struct debug_obj *lookup_object(v
 	return NULL;
 }
 
+static void calc_usage(void)
+{
+	static DEFINE_RAW_SPINLOCK(avg_lock);
+	static unsigned long avg_period;
+	unsigned long cur, now = jiffies;
+
+	if (!time_after_eq(now, READ_ONCE(avg_period)))
+		return;
+
+	if (!raw_spin_trylock(&avg_lock))
+		return;
+
+	WRITE_ONCE(avg_period, now + msecs_to_jiffies(10));
+	cur = READ_ONCE(pool_global.stats.cur_used) * ODEBUG_FREE_WORK_MAX;
+	WRITE_ONCE(avg_usage, calc_load(avg_usage, EXP_5, cur));
+	raw_spin_unlock(&avg_lock);
+}
+
 static struct debug_obj *alloc_object(void *addr, struct debug_bucket *b,
 				      const struct debug_obj_descr *descr)
 {
 	struct debug_obj *obj;
 
+	calc_usage();
+
 	if (static_branch_likely(&obj_cache_enabled))
 		obj = pcpu_alloc();
 	else
@@ -450,14 +472,26 @@ static struct debug_obj *alloc_object(vo
 /* workqueue function to free objects. */
 static void free_obj_work(struct work_struct *work)
 {
-	bool free = true;
+	static unsigned long last_use_avg;
+	unsigned long cur_used, last_used, delta;
+	unsigned int max_free = 0;
 
 	WRITE_ONCE(obj_freeing, false);
 
+	/* Rate limit freeing based on current use average */
+	cur_used = READ_ONCE(avg_usage);
+	last_used = last_use_avg;
+	last_use_avg = cur_used;
+
 	if (!pool_count(&pool_to_free))
 		return;
 
-	for (unsigned int cnt = 0; cnt < ODEBUG_FREE_WORK_MAX; cnt++) {
+	if (cur_used <= last_used) {
+		delta = (last_used - cur_used) / ODEBUG_FREE_WORK_MAX;
+		max_free = min(delta, ODEBUG_FREE_WORK_MAX);
+	}
+
+	for (int cnt = 0; cnt < ODEBUG_FREE_WORK_MAX; cnt++) {
 		HLIST_HEAD(tofree);
 
 		/* Acquire and drop the lock for each batch */
@@ -468,9 +502,10 @@ static void free_obj_work(struct work_st
 			/* Refill the global pool if possible */
 			if (pool_move_batch(&pool_global, &pool_to_free)) {
 				/* Don't free as there seems to be demand */
-				free = false;
-			} else if (free) {
+				max_free = 0;
+			} else if (max_free) {
 				pool_pop_batch(&tofree, &pool_to_free);
+				max_free--;
 			} else {
 				return;
 			}
@@ -1110,7 +1145,7 @@ static int debug_stats_show(struct seq_f
 	for_each_possible_cpu(cpu)
 		pcp_free += per_cpu(pool_pcpu.cnt, cpu);
 
-	pool_used = data_race(pool_global.stats.cur_used);
+	pool_used = READ_ONCE(pool_global.stats.cur_used);
 	pcp_free = min(pool_used, pcp_free);
 	pool_used -= pcp_free;
 

