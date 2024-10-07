Return-Path: <linux-kernel+bounces-353898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEF99340C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DFF28265B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A721DC1A6;
	Mon,  7 Oct 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZLLF2hBO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pKRVkm8D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02D1DE896
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319825; cv=none; b=SJN21N2PepUBzGXOfwJVYE5fKnuSHfAbmuIQ8AKshXU/RbPYSoau4sCkHvLSPORlpSiZN+cGdIHOzy/CHBrSzodK9Xix9XwANJa1P8i7aQFi9bQCSoFwJWvTdOQaUGKM50WS3eairDvmoAN7yzZr9BnOU0YbozLlKUjlPtobOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319825; c=relaxed/simple;
	bh=279xa8mpg28AxbvwJ5VJI0fKKgnKuyWo7R6bGg0y0mo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=IY+/ga2YBL/UqgpwXh80muqtk7uxFOZdFPDqtVqPINS4EHCbljujvEoX/I1pyAyKOC60UXgxOsmY1JKjWW8/0LzMoTcBJY+P14QaFCQwqoZJLaNyWC9eyYcYntpfias5Cw6GgL2U62/Ut3iUUmhSdzTxb2ihry7SMoXlw8W6abg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZLLF2hBO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pKRVkm8D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164914.499184215@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=U+tLkJdJzX5oBPcMxYGnMu9J72CXO1tkPlg0+hp5+mc=;
	b=ZLLF2hBORDZNgqB6RGuan1NNhc9PPs1VCx2W8udEzRhxGg3bNFVKw6efNVpPaIEvWDItID
	TL7gHlj5ZeR/oWD3vAMA4y0xAO+nOMzv/uRZjWunyPn2td8xAv0zzU8wGpyqEZ2cOU59FW
	0oniecanWP9fsdripRvouZqyTEiAi9VEhkH9yr2Sl+A6L9713cOirfQwq1ywCar/rZV3Rj
	GO3UWZfnnQkXjNbQlYPy2Y/6wvGTlGYkCoAjIKSOD9Md2PV7qlgx8fNTIrwOT5GJdN6cSw
	d4T+C09Bl5kqfvvYideBPHeoU1dG4N1TNkJtfO8JUbQqaWjeHcD8xgW0Ozn9bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=U+tLkJdJzX5oBPcMxYGnMu9J72CXO1tkPlg0+hp5+mc=;
	b=pKRVkm8DBGXSlBWiDWmRwtEdt6hNdOmO+WR2gziTKtO5OjoNxHTO/e8uxPPH7DqrmpjdZx
	wZO5BVDoMCxvqkDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 25/25] debugobjects: Track object usage to avoid premature
 freeing of objects
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:21 +0200 (CEST)

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
 lib/debugobjects.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 5 deletions(-)

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
@@ -382,11 +384,28 @@ static bool kmem_alloc_batch(struct hlis
 	return true;
 }
 
+static bool pool_can_fill(struct obj_pool *dst, struct obj_pool *src)
+{
+	unsigned int cnt = pool_count(dst);
+
+	if (cnt >= dst->min_cnt)
+		return true;
+
+	return READ_ONCE(src->cnt) >= cnt - dst->min_cnt;
+}
+
 static void fill_pool(void)
 {
 	static atomic_t cpus_allocating;
 
 	/*
+	 * If the free pool has enough capacity, then don't try allocating
+	 * unless the global pool has reached the cricital level.
+	 */
+	if (!pool_must_refill(&pool_global) && pool_can_fill(&pool_global, &pool_to_free))
+		return;
+
+	/*
 	 * Avoid allocation and lock contention when:
 	 *   - One other CPU is already allocating
 	 *   - the global pool has not reached the critical level yet
@@ -427,11 +446,31 @@ static struct debug_obj *lookup_object(v
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
@@ -450,14 +489,26 @@ static struct debug_obj *alloc_object(vo
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
@@ -468,9 +519,10 @@ static void free_obj_work(struct work_st
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
@@ -1110,7 +1162,7 @@ static int debug_stats_show(struct seq_f
 	for_each_possible_cpu(cpu)
 		pcp_free += per_cpu(pool_pcpu.cnt, cpu);
 
-	pool_used = data_race(pool_global.stats.cur_used);
+	pool_used = READ_ONCE(pool_global.stats.cur_used);
 	pcp_free = min(pool_used, pcp_free);
 	pool_used -= pcp_free;
 


