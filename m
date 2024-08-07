Return-Path: <linux-kernel+bounces-278680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE5794B376
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655FBB230B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A312A156228;
	Wed,  7 Aug 2024 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdIi7K0w"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30FB1553BC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072466; cv=none; b=erBYblikdiXZbDHNeo/XdzewUsPSSbZEPhwTnYglPpaByAr8XcU+b7t/VlE93mYei7FKuCYr25PpyS35sKHicN59QQ3mjRd3oHwomHEJpIlXUPrjmshg55pfKaHYdQFcXZm1zRlJbRcPfR1XUE2m2ikaVxQLzKD/v0z5mcSrMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072466; c=relaxed/simple;
	bh=1o1NC8rg8z5B8zRAQEByqdLgackW7shnCdu6Gq+0S1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fEG/+5Sp3TdavqIFCTWCAggoKm8JI82SX4CnSP7YRjzz5h9VZ4XT1Vct85Zv+k1br8h/uadqSC06Vc2KOmR+UXCncYizY7313LjcyFswdh9Swe+bujVqUHjnvEw8sGMG4BxmAOPYIGHEW32Y3JQKx8XYoGL2a3/fP5ZJHSSLd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdIi7K0w; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70968db52d0so348017a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 16:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723072464; x=1723677264; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BkUyrVZZ45mPx7AOPsCo8Ri+2SzHwqAvfAOfwoH4qHQ=;
        b=AdIi7K0wWSJd59LQuoqve9vtEXNMYxNwWVQhqj3EP/4tXX8B6e4gdjkfCXiAvpuocA
         +OCU61KvvJxMY5ZlmrrWsMac8V05FN4MAe3B21dWbj8vu+AzdsI44+P3Vvm7FGh22SCf
         bzpe7z/59HzrCKhmR4YmnI5scJqDfLdKFAITa8xmZ5/5ZQvzKXfOuqz9AY5M6qbqS97K
         hiTznWh2dZVRgGrmQ0TFVEj//ztzKYE7aVvONBRyX1LTwsQGk5L50BEapcRTrpiLDia/
         Yy6EMqvg7Mlvgfj4PNyhzqyIQT19/NYGIcBd0Giy0f/ZkF1LhS8cm+COeemqVssmIU2V
         K7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723072464; x=1723677264;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkUyrVZZ45mPx7AOPsCo8Ri+2SzHwqAvfAOfwoH4qHQ=;
        b=UuPtHmAfaKF9OMLcOQczXIb9MawUUxCZwJsyCarg9tbz9fYEXgl5vyF6VG/n9Ee3w8
         cHZXyqUDQDiSeBTZmluQsflukatDOob34hhQoBPFpLR980HE8lZsyn2Fe4PmCDLZ7qo3
         GiAtajG580MJPAkPYltIrOlgJxbf9Z9TWh3F+PW5jDDpBryuhDyq/cgMH7iSvoJiZnTG
         mjmMJvyhKeP1mN6GQDu52D+NoCcqEbeRZNfC5rGi4P6LARgR+/6yyGqqDDz0UCbBxIq0
         vQgLbr0WIy/8Ev5id5WYwnvrVJ+9SBnEUcdcLRcK3uqqLwBFCTlg9lA9raKmi3eCdxZM
         zHEg==
X-Gm-Message-State: AOJu0Yzkq+wqNqY7qOJolNlob0L+OjR/Yji3yK6NrR3Kra9U5GQaSjuU
	Ndzr+24L0e50nM1GV+EoUSuzCJqqeohHVSJHdwUCxp4cnh352fzh
X-Google-Smtp-Source: AGHT+IHwycBay4aGCZH/CwEAT/ox4lXzWoOtN/IzG8nJc4dGwCg9RcZQAFOD72bxFpsB2bIzZMja6Q==
X-Received: by 2002:a05:6358:e49f:b0:19f:4c1b:f0f8 with SMTP id e5c5f4694b2df-1b15cfdeb57mr33860655d.24.1723072463586;
        Wed, 07 Aug 2024 16:14:23 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c17885275dsm1118702a12.83.2024.08.07.16.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:14:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Aug 2024 13:14:21 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: [sched_ext/for-6.12] sched_ext: Don't use double locking to migrate
 tasks across CPUs
Message-ID: <ZrP_zUjrTcrfdHDe@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

consume_remote_task() and dispatch_to_local_dsq() use
move_task_to_local_dsq() to migrate the task to the target CPU. Currently,
move_task_to_local_dsq() expects the caller to lock both the source and
destination rq's. While this may save a few lock operations while the rq's
are not contended, under contention, the double locking can exacerbate the
situation significantly (refer to the linked message below).

Update the migration path so that double locking is not used.
move_task_to_local_dsq() now expects the caller to be locking the source rq,
drops it and then acquires the destination rq lock. Code is simpler this way
and, on a 2-way NUMA machine w/ Xeon Gold 6138, 'hackbench 100 thread 5000`
shows ~3% improvement with scx_simple.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20240806082716.GP37996@noisy.programming.kicks-ass.net
---
 kernel/sched/ext.c |  136 ++++++++++++++++++-----------------------------------
 1 file changed, 47 insertions(+), 89 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2097,11 +2097,12 @@ static bool yield_to_task_scx(struct rq
 #ifdef CONFIG_SMP
 /**
  * move_task_to_local_dsq - Move a task from a different rq to a local DSQ
- * @rq: rq to move the task into, currently locked
  * @p: task to move
  * @enq_flags: %SCX_ENQ_*
+ * @src_rq: rq to move the task from, locked on entry, released on return
+ * @dst_rq: rq to move the task into, locked on return
  *
- * Move @p which is currently on a different rq to @rq's local DSQ. The caller
+ * Move @p which is currently on @src_rq to @dst_rq's local DSQ. The caller
  * must:
  *
  * 1. Start with exclusive access to @p either through its DSQ lock or
@@ -2109,109 +2110,63 @@ static bool yield_to_task_scx(struct rq
  *
  * 2. Set @p->scx.holding_cpu to raw_smp_processor_id().
  *
- * 3. Remember task_rq(@p). Release the exclusive access so that we don't
- *    deadlock with dequeue.
+ * 3. Remember task_rq(@p) as @src_rq. Release the exclusive access so that we
+ *    don't deadlock with dequeue.
  *
- * 4. Lock @rq and the task_rq from #3.
+ * 4. Lock @src_rq from #3.
  *
  * 5. Call this function.
  *
  * Returns %true if @p was successfully moved. %false after racing dequeue and
- * losing.
+ * losing. On return, @src_rq is unlocked and @dst_rq is locked.
  */
-static bool move_task_to_local_dsq(struct rq *rq, struct task_struct *p,
-				   u64 enq_flags)
+static bool move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
+				   struct rq *src_rq, struct rq *dst_rq)
 {
-	struct rq *task_rq;
-
-	lockdep_assert_rq_held(rq);
+	lockdep_assert_rq_held(src_rq);
 
 	/*
-	 * If dequeue got to @p while we were trying to lock both rq's, it'd
-	 * have cleared @p->scx.holding_cpu to -1. While other cpus may have
-	 * updated it to different values afterwards, as this operation can't be
+	 * If dequeue got to @p while we were trying to lock @src_rq, it'd have
+	 * cleared @p->scx.holding_cpu to -1. While other cpus may have updated
+	 * it to different values afterwards, as this operation can't be
 	 * preempted or recurse, @p->scx.holding_cpu can never become
 	 * raw_smp_processor_id() again before we're done. Thus, we can tell
 	 * whether we lost to dequeue by testing whether @p->scx.holding_cpu is
 	 * still raw_smp_processor_id().
 	 *
+	 * @p->rq couldn't have changed if we're still the holding cpu.
+	 *
 	 * See dispatch_dequeue() for the counterpart.
 	 */
-	if (unlikely(p->scx.holding_cpu != raw_smp_processor_id()))
+	if (unlikely(p->scx.holding_cpu != raw_smp_processor_id()) ||
+	    WARN_ON_ONCE(src_rq != task_rq(p))) {
+		raw_spin_rq_unlock(src_rq);
+		raw_spin_rq_lock(dst_rq);
 		return false;
+	}
 
-	/* @p->rq couldn't have changed if we're still the holding cpu */
-	task_rq = task_rq(p);
-	lockdep_assert_rq_held(task_rq);
-
-	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(rq), p->cpus_ptr));
-	deactivate_task(task_rq, p, 0);
-	set_task_cpu(p, cpu_of(rq));
-	p->scx.sticky_cpu = cpu_of(rq);
+	/* the following marks @p MIGRATING which excludes dequeue */
+	deactivate_task(src_rq, p, 0);
+	set_task_cpu(p, cpu_of(dst_rq));
+	p->scx.sticky_cpu = cpu_of(dst_rq);
+
+	raw_spin_rq_unlock(src_rq);
+	raw_spin_rq_lock(dst_rq);
 
 	/*
 	 * We want to pass scx-specific enq_flags but activate_task() will
 	 * truncate the upper 32 bit. As we own @rq, we can pass them through
 	 * @rq->scx.extra_enq_flags instead.
 	 */
-	WARN_ON_ONCE(rq->scx.extra_enq_flags);
-	rq->scx.extra_enq_flags = enq_flags;
-	activate_task(rq, p, 0);
-	rq->scx.extra_enq_flags = 0;
+	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr));
+	WARN_ON_ONCE(dst_rq->scx.extra_enq_flags);
+	dst_rq->scx.extra_enq_flags = enq_flags;
+	activate_task(dst_rq, p, 0);
+	dst_rq->scx.extra_enq_flags = 0;
 
 	return true;
 }
 
-/**
- * dispatch_to_local_dsq_lock - Ensure source and destination rq's are locked
- * @rq: current rq which is locked
- * @src_rq: rq to move task from
- * @dst_rq: rq to move task to
- *
- * We're holding @rq lock and trying to dispatch a task from @src_rq to
- * @dst_rq's local DSQ and thus need to lock both @src_rq and @dst_rq. Whether
- * @rq stays locked isn't important as long as the state is restored after
- * dispatch_to_local_dsq_unlock().
- */
-static void dispatch_to_local_dsq_lock(struct rq *rq, struct rq *src_rq,
-				       struct rq *dst_rq)
-{
-	if (src_rq == dst_rq) {
-		raw_spin_rq_unlock(rq);
-		raw_spin_rq_lock(dst_rq);
-	} else if (rq == src_rq) {
-		double_lock_balance(rq, dst_rq);
-	} else if (rq == dst_rq) {
-		double_lock_balance(rq, src_rq);
-	} else {
-		raw_spin_rq_unlock(rq);
-		double_rq_lock(src_rq, dst_rq);
-	}
-}
-
-/**
- * dispatch_to_local_dsq_unlock - Undo dispatch_to_local_dsq_lock()
- * @rq: current rq which is locked
- * @src_rq: rq to move task from
- * @dst_rq: rq to move task to
- *
- * Unlock @src_rq and @dst_rq and ensure that @rq is locked on return.
- */
-static void dispatch_to_local_dsq_unlock(struct rq *rq, struct rq *src_rq,
-					 struct rq *dst_rq)
-{
-	if (src_rq == dst_rq) {
-		raw_spin_rq_unlock(dst_rq);
-		raw_spin_rq_lock(rq);
-	} else if (rq == src_rq) {
-		double_unlock_balance(rq, dst_rq);
-	} else if (rq == dst_rq) {
-		double_unlock_balance(rq, src_rq);
-	} else {
-		double_rq_unlock(src_rq, dst_rq);
-		raw_spin_rq_lock(rq);
-	}
-}
 #endif	/* CONFIG_SMP */
 
 static void consume_local_task(struct rq *rq, struct scx_dispatch_q *dsq,
@@ -2263,8 +2218,6 @@ static bool task_can_run_on_remote_rq(st
 static bool consume_remote_task(struct rq *rq, struct scx_dispatch_q *dsq,
 				struct task_struct *p, struct rq *task_rq)
 {
-	bool moved = false;
-
 	lockdep_assert_held(&dsq->lock);	/* released on return */
 
 	/*
@@ -2280,13 +2233,10 @@ static bool consume_remote_task(struct r
 	p->scx.holding_cpu = raw_smp_processor_id();
 	raw_spin_unlock(&dsq->lock);
 
-	double_lock_balance(rq, task_rq);
-
-	moved = move_task_to_local_dsq(rq, p, 0);
+	raw_spin_rq_unlock(rq);
+	raw_spin_rq_lock(task_rq);
 
-	double_unlock_balance(rq, task_rq);
-
-	return moved;
+	return move_task_to_local_dsq(p, 0, task_rq, rq);
 }
 #else	/* CONFIG_SMP */
 static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq) { return false; }
@@ -2380,7 +2330,6 @@ dispatch_to_local_dsq(struct rq *rq, u64
 
 #ifdef CONFIG_SMP
 	if (cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr)) {
-		struct rq *locked_dst_rq = dst_rq;
 		bool dsp;
 
 		/*
@@ -2399,7 +2348,11 @@ dispatch_to_local_dsq(struct rq *rq, u64
 		/* store_release ensures that dequeue sees the above */
 		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
 
-		dispatch_to_local_dsq_lock(rq, src_rq, locked_dst_rq);
+		/* switch to @src_rq lock */
+		if (rq != src_rq) {
+			raw_spin_rq_unlock(rq);
+			raw_spin_rq_lock(src_rq);
+		}
 
 		/*
 		 * We don't require the BPF scheduler to avoid dispatching to
@@ -2426,7 +2379,8 @@ dispatch_to_local_dsq(struct rq *rq, u64
 						 enq_flags);
 			}
 		} else {
-			dsp = move_task_to_local_dsq(dst_rq, p, enq_flags);
+			dsp = move_task_to_local_dsq(p, enq_flags,
+						     src_rq, dst_rq);
 		}
 
 		/* if the destination CPU is idle, wake it up */
@@ -2434,7 +2388,11 @@ dispatch_to_local_dsq(struct rq *rq, u64
 					     dst_rq->curr->sched_class))
 			resched_curr(dst_rq);
 
-		dispatch_to_local_dsq_unlock(rq, src_rq, locked_dst_rq);
+		/* switch back to @rq lock */
+		if (rq != dst_rq) {
+			raw_spin_rq_unlock(dst_rq);
+			raw_spin_rq_lock(rq);
+		}
 
 		return dsp ? DTL_DISPATCHED : DTL_LOST;
 	}

