Return-Path: <linux-kernel+bounces-389039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28B49B67CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838041F236CF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E029218933;
	Wed, 30 Oct 2024 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bp1GsDCF"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A56A213EE0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301956; cv=none; b=X4/uznqFi1Cn6OLaMH4zZriNykXB6jjjgb8JgZAlRaIMJFbZyhvRGPy/JvMlL9n0ojV/mC8eIFLlW6VBAdLIahzTcctzkkCD3QzH5QAgmMieeGzjITANcpvumI4pcOzv/abdX8I11/uIawwtymI71AGmtLDvsCK6ECU6MytMdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301956; c=relaxed/simple;
	bh=RNOg5ouTL1U+ujWCIwyxrXtmr4rRrvxV8iy7MoAAMzw=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Pc/O5okPLlB4UZ6c+7N9fnoK28M43cUCYuOlhpJstnaI6Fq0IyZN7ZHM4ALLr2wK5yM8LXKWpudR0TuXHPhe0FFosv2nsG1NF5S8FMQGKFx8gr8b4theRN3yxvAzMYBMHJ6P4oFnWJBzqsenaAMTSjSx79PBQzPVO3axowDzIXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bp1GsDCF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=aunwiDDKYmVRvfITOprvRJLMm2ei70V4JyWWDCQb24U=; b=bp1GsDCF9nZj4N+lWP9O1kDt1e
	oyzl/jBSZua0slb1ZAQVsO1EON6kbRZgkAl30MGsO7i3ht+68pcO7aaOfCNqpRT8LiLRoQJ2Xs73G
	pmgdJ7vSVXqs83/S6azQtsTtUdnS3Q9vi6GpmPaezX+C3aouZZ2EcvBcxKlueg6PgsIP9I/vOPKLK
	ND/M4mdD922hXabXWHjSsBl9hcqXUNkWSTQrzXhZ8mwHKlp0QEhNbhwJZf26ccxa8Hlsv/2nDEeqw
	b1C5OUqRuPEFJY2sZJmJOLqgM9WDvoBpyOouiKJlIiFW0F0ewA5didolsX86Ls0IvKXbkx27Tu+vJ
	6JnfUE5Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AZs-0000000AI28-3P1D;
	Wed, 30 Oct 2024 15:25:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E9D84301D03; Wed, 30 Oct 2024 16:25:43 +0100 (CET)
Message-Id: <20241030152142.711768679@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 30 Oct 2024 16:12:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 void@manifault.com,
 linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 4/6] sched: Fold sched_class::switch{ing,ed}_{to,from}() into the change pattern
References: <20241030151255.300069509@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Add {DE,EN}QUEUE_CLASS and fold the sched_class::switch* methods into
the change pattern. This completes and makes the pattern more
symmetric.

This changes the order of callbacks slightly:

				|
				|  switching_from()
  dequeue_task();		|  dequeue_task()
  put_prev_task();		|  put_prev_task()
				|  switched_from()
				|
  ... change task ...		|  ... change task ...
				|
  switching_to();		|  switching_to()
  enqueue_task();		|  enqueue_task()
  set_next_task();		|  set_next_task()
  prev_class->switched_from()	|
  switched_to()			|  switched_to()
				|

Notably, it moves the switched_from() callback right after the
dequeue/put. Existing implementations don't appear to be affected by
this change in location -- specifically the task isn't enqueued on the
class in question in either location.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |   61 ++++++++++++++++++++---------------------------
 kernel/sched/ext.c       |   19 ++++++++++----
 kernel/sched/idle.c      |    4 +--
 kernel/sched/rt.c        |    4 +--
 kernel/sched/sched.h     |   21 ++++++----------
 kernel/sched/stop_task.c |    4 +--
 kernel/sched/syscalls.c  |    7 +++--
 7 files changed, 59 insertions(+), 61 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2102,34 +2102,9 @@ inline int task_curr(const struct task_s
 	return cpu_curr(task_cpu(p)) == p;
 }
 
-/*
- * ->switching_to() is called with the pi_lock and rq_lock held and must not
- * mess with locking.
- */
-void check_class_changing(struct rq *rq, struct task_struct *p,
-			  const struct sched_class *prev_class)
+void check_prio_changed(struct rq *rq, struct task_struct *p, int oldprio)
 {
-	if (prev_class != p->sched_class && p->sched_class->switching_to)
-		p->sched_class->switching_to(rq, p);
-}
-
-/*
- * switched_from, switched_to and prio_changed must _NOT_ drop rq->lock,
- * use the balance_callback list if you want balancing.
- *
- * this means any call to check_class_changed() must be followed by a call to
- * balance_callback().
- */
-void check_class_changed(struct rq *rq, struct task_struct *p,
-			 const struct sched_class *prev_class,
-			 int oldprio)
-{
-	if (prev_class != p->sched_class) {
-		if (prev_class->switched_from)
-			prev_class->switched_from(rq, p);
-
-		p->sched_class->switched_to(rq, p);
-	} else if (oldprio != p->prio || dl_task(p))
+	if (oldprio != p->prio || dl_task(p))
 		p->sched_class->prio_changed(rq, p, oldprio);
 }
 
@@ -7161,6 +7136,9 @@ void rt_mutex_setprio(struct task_struct
 	prev_class = p->sched_class;
 	next_class = __setscheduler_class(p->policy, prio);
 
+	if (prev_class != next_class)
+		queue_flag |= DEQUEUE_CLASS;
+
 	if (prev_class != next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 
@@ -7197,11 +7175,10 @@ void rt_mutex_setprio(struct task_struct
 
 		p->sched_class = next_class;
 		p->prio = prio;
-
-		check_class_changing(rq, p, prev_class);
 	}
 
-	check_class_changed(rq, p, prev_class, oldprio);
+	if (!(queue_flag & DEQUEUE_CLASS))
+		check_prio_changed(rq, p, oldprio);
 out_unlock:
 	/* Avoid rq from going away on us: */
 	preempt_disable();
@@ -10550,6 +10527,12 @@ void sched_mm_cid_fork(struct task_struc
 struct sched_change_ctx sched_change_begin(struct task_struct *p, unsigned int flags)
 {
 	struct rq *rq = task_rq(p);
+
+	lockdep_assert_rq_held(rq);
+
+	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
+		p->sched_class->switching_from(rq, p);
+
 	struct sched_change_ctx ctx = {
 		.p = p,
 		.flags = flags,
@@ -10557,24 +10540,32 @@ struct sched_change_ctx sched_change_beg
 		.running = task_current(rq, p),
 	};
 
-	lockdep_assert_rq_held(rq);
-
 	if (ctx.queued)
 		dequeue_task(rq, p, flags);
 	if (ctx.running)
 		put_prev_task(rq, p);
 
+	if ((flags & DEQUEUE_CLASS) && p->sched_class->switched_from)
+		p->sched_class->switched_from(rq, p);
+
 	return ctx;
 }
 
 void sched_change_end(struct sched_change_ctx ctx)
 {
-	struct rq *rq = task_rq(ctx.p);
+	struct task_struct *p = ctx.p;
+	struct rq *rq = task_rq(p);
 
 	lockdep_assert_rq_held(rq);
 
+	if ((ctx.flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
+		p->sched_class->switching_to(rq, p);
+
 	if (ctx.queued)
-		enqueue_task(rq, ctx.p, ctx.flags | ENQUEUE_NOCLOCK);
+		enqueue_task(rq, p, ctx.flags | ENQUEUE_NOCLOCK);
 	if (ctx.running)
-		set_next_task(rq, ctx.p);
+		set_next_task(rq, p);
+
+	if ((ctx.flags & ENQUEUE_CLASS) && p->sched_class->switched_to)
+		p->sched_class->switched_to(rq, p);
 }
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4487,19 +4487,24 @@ static void scx_ops_disable_workfn(struc
 
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
+		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
 
+		if (old_class != new_class)
+			queue_flags |= DEQUEUE_CLASS;
+
 		if (old_class != new_class && p->se.sched_delayed)
 			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scoped_guard (sched_change, p, queue_flags) {
 			p->sched_class = new_class;
-			check_class_changing(task_rq(p), p, old_class);
 		}
 
-		check_class_changed(task_rq(p), p, old_class, p->prio);
+		if (!(queue_flags & DEQUEUE_CLASS))
+			check_prio_changed(task_rq(p), p, p->prio);
+
 		scx_ops_exit_task(p);
 	}
 	scx_task_iter_stop(&sti);
@@ -5199,20 +5204,24 @@ static int scx_ops_enable(struct sched_e
 	percpu_down_write(&scx_fork_rwsem);
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
+		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
 
+		if (old_class != new_class)
+			queue_flags |= DEQUEUE_CLASS;
+
 		if (old_class != new_class && p->se.sched_delayed)
 			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 
 		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
 			p->scx.slice = SCX_SLICE_DFL;
 			p->sched_class = new_class;
-			check_class_changing(task_rq(p), p, old_class);
 		}
 
-		check_class_changed(task_rq(p), p, old_class, p->prio);
+		if (!(queue_flags & DEQUEUE_CLASS))
+			check_prio_changed(task_rq(p), p, p->prio);
 	}
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -494,7 +494,7 @@ static void task_tick_idle(struct rq *rq
 {
 }
 
-static void switched_to_idle(struct rq *rq, struct task_struct *p)
+static void switching_to_idle(struct rq *rq, struct task_struct *p)
 {
 	BUG();
 }
@@ -534,6 +534,6 @@ DEFINE_SCHED_CLASS(idle) = {
 	.task_tick		= task_tick_idle,
 
 	.prio_changed		= prio_changed_idle,
-	.switched_to		= switched_to_idle,
+	.switched_to		= switching_to_idle,
 	.update_curr		= update_curr_idle,
 };
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2633,7 +2633,6 @@ DEFINE_SCHED_CLASS(rt) = {
 	.rq_online              = rq_online_rt,
 	.rq_offline             = rq_offline_rt,
 	.task_woken		= task_woken_rt,
-	.switched_from		= switched_from_rt,
 	.find_lock_rq		= find_lock_lowest_rq,
 #endif
 
@@ -2641,8 +2640,9 @@ DEFINE_SCHED_CLASS(rt) = {
 
 	.get_rr_interval	= get_rr_interval_rt,
 
-	.prio_changed		= prio_changed_rt,
+	.switched_from		= switched_from_rt,
 	.switched_to		= switched_to_rt,
+	.prio_changed		= prio_changed_rt,
 
 	.update_curr		= update_curr_rt,
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2340,6 +2340,7 @@ extern const u32		sched_prio_to_wmult[40
 
 #define DEQUEUE_MIGRATING	0x10 /* Matches ENQUEUE_MIGRATING */
 #define DEQUEUE_DELAYED		0x20 /* Matches ENQUEUE_DELAYED */
+#define DEQUEUE_CLASS		0x40 /* Matches ENQUEUE_CLASS */
 
 #define DEQUEUE_SPECIAL		0x0100
 
@@ -2350,6 +2351,7 @@ extern const u32		sched_prio_to_wmult[40
 
 #define ENQUEUE_MIGRATING	0x10
 #define ENQUEUE_DELAYED		0x20
+#define ENQUEUE_CLASS		0x40
 
 #define ENQUEUE_HEAD		0x0100
 #define ENQUEUE_REPLENISH	0x0200
@@ -2415,14 +2417,11 @@ struct sched_class {
 	void (*task_fork)(struct task_struct *p);
 	void (*task_dead)(struct task_struct *p);
 
-	/*
-	 * The switched_from() call is allowed to drop rq->lock, therefore we
-	 * cannot assume the switched_from/switched_to pair is serialized by
-	 * rq->lock. They are however serialized by p->pi_lock.
-	 */
-	void (*switching_to) (struct rq *this_rq, struct task_struct *task);
-	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
-	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
+	void (*switching_from)(struct rq *this_rq, struct task_struct *task);
+	void (*switched_from) (struct rq *this_rq, struct task_struct *task);
+	void (*switching_to)  (struct rq *this_rq, struct task_struct *task);
+	void (*switched_to)   (struct rq *this_rq, struct task_struct *task);
+
 	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
 			      const struct load_weight *lw);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
@@ -3898,11 +3897,7 @@ extern void set_load_weight(struct task_
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
 extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
 
-extern void check_class_changing(struct rq *rq, struct task_struct *p,
-				 const struct sched_class *prev_class);
-extern void check_class_changed(struct rq *rq, struct task_struct *p,
-				const struct sched_class *prev_class,
-				int oldprio);
+extern void check_prio_changed(struct rq *rq, struct task_struct *p, int oldprio);
 
 #ifdef CONFIG_SMP
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -76,7 +76,7 @@ static void task_tick_stop(struct rq *rq
 {
 }
 
-static void switched_to_stop(struct rq *rq, struct task_struct *p)
+static void switching_to_stop(struct rq *rq, struct task_struct *p)
 {
 	BUG(); /* its impossible to change to this class */
 }
@@ -115,6 +115,6 @@ DEFINE_SCHED_CLASS(stop) = {
 	.task_tick		= task_tick_stop,
 
 	.prio_changed		= prio_changed_stop,
-	.switched_to		= switched_to_stop,
+	.switching_to		= switching_to_stop,
 	.update_curr		= update_curr_stop,
 };
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -698,6 +698,9 @@ int __sched_setscheduler(struct task_str
 	prev_class = p->sched_class;
 	next_class = __setscheduler_class(policy, newprio);
 
+	if (prev_class != next_class)
+		queue_flags |= DEQUEUE_CLASS;
+
 	if (prev_class != next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 
@@ -709,7 +712,6 @@ int __sched_setscheduler(struct task_str
 			p->prio = newprio;
 		}
 		__setscheduler_uclamp(p, attr);
-		check_class_changing(rq, p, prev_class);
 
 		if (scope.queued) {
 			/*
@@ -721,7 +723,8 @@ int __sched_setscheduler(struct task_str
 		}
 	}
 
-	check_class_changed(rq, p, prev_class, oldprio);
+	if (!(queue_flags & DEQUEUE_CLASS))
+		check_prio_changed(rq, p, oldprio);
 
 	/* Avoid rq from going away on us: */
 	preempt_disable();



