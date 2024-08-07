Return-Path: <linux-kernel+bounces-278682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD8E94B37F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF471F232E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC00815574C;
	Wed,  7 Aug 2024 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDp8Cmza"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A975250EC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072523; cv=none; b=F2zxdthGTuePeO2qd317QkPuFObVrlGnnT+ibNk8689B/rYsc4W0XML1Mw0YbOaarZ85lQwuKxQald6kY2V7EOIRqVo/NH+oyQIH0siPk+PJnHXMjaHpBPE0cMqabAb5g/Bq4JHquTRoOX9hi+y5TDFbaV7n0tYfY1mwzTWjiLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072523; c=relaxed/simple;
	bh=g6fwRxzKiATfXm+sT3fDct05OaOU8jAcI7ris4uZ6ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwCcdshyJ25y0hIXt3Lh9sTrphoaytmq06vDhcpt79b/ZEU0Q5173PJJ+EBTI/0dUejg/AUYQ5+UrRNb3619FWHtnN8bbKGQxs7i/pFPlgfdEYAj9nH1W39Uy7rKROyKyMT6VJJuUcuXRQ9fCDgRiwho+JtsVkhYuFHWzRXyHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDp8Cmza; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a10b293432so279469a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 16:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723072521; x=1723677321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5PJAYS7DgaqUsPKkhFkqTuOjfovnSIg+M5ncNQ8+hw=;
        b=PDp8Cmza9+Fk/NXYy6feyX245iTwd0e2gIzlPwK2JOpyCkjzXQghUfHuzfOzJXmEzz
         h+PEf8xCRkpQ+WAEHE+//POjxCsgNLNNH1ki4tLyDE9UWWf9gaz90GjF9ckPEXrUNWOb
         4PK/DnFFsVxyLpI6u749m3NLZeZhFvHW/RFxQ2e7DRM2kKXKY6A2072+Ni2+09O9gX/u
         xhyQeoyeivM8/kdg2wM5hSQF5lBdVgVh6xJbQGkF59POR2gh0ym0sv2tKx9k8Al+ULmm
         e+OlDf39cyJ5eFvNdOcCj908ALL2QtksmQujj7pBjs5s9wuj0/xVZfMPsH+r5FMshtKm
         ObRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723072521; x=1723677321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5PJAYS7DgaqUsPKkhFkqTuOjfovnSIg+M5ncNQ8+hw=;
        b=vZOO7lywMJjG6sCyGjrwtm1hcN6SLwJHW+Kj4iraxO3F3QtEgMYigPgVYnWrD4cjCc
         ZDdQy93GE+7d4gYVmrakM/GQlPs36986i/lkKPv+CNads+zMTd495yqt110r4SGBjzQ3
         URfveq7dGt2lyXBKZCnt+fqTySMK0P3cviiJibManPI4GyuKq7TqhkBUT33RjIxStttr
         SQzti2Nb3B7l+JB7K9mQz2xIolihPnBazefhsVjPGuhuasRSS5kC4H4pQYFtYOxtDlRh
         edR3DuLovsQvDvQ3/xvBsi5jFz9zgKsgrJ1E096VMeVKNKsUHVYYBfX+NsrqZPGAPaIX
         7e/A==
X-Gm-Message-State: AOJu0YxdXiDqgfgBB50aaKPxru4J0Y0nMdFazmSQVg4Eq+ds15I3BS2n
	7ELdIwRnJ0cmQWB4yyJXjeXM1cWYpOVQMcxmjEr8eJaa0StyVXl4
X-Google-Smtp-Source: AGHT+IGkDJEV/m/O+QumrfDkjTJ33D9Q1ix6tvVb1B19mLBdlb/FAPZVvJbe3vv2aDNxVIo8UUZMtA==
X-Received: by 2002:a05:6a20:3952:b0:1c4:818c:2986 with SMTP id adf61e73a8af0-1c6fceccfdfmr12770637.13.1723072521329;
        Wed, 07 Aug 2024 16:15:21 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2fc0d8sm33605b3a.205.2024.08.07.16.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:15:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Aug 2024 13:15:19 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RESEND sched_ext/for-6.12] sched_ext: Don't use double
 locking to migrate tasks across CPUs
Message-ID: <ZrQAB_d1WSqgYQmB@slm.duckdns.org>
References: <ZrP_zUjrTcrfdHDe@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrP_zUjrTcrfdHDe@slm.duckdns.org>

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
Oops, PATCH prefix was missing. Resending.

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

