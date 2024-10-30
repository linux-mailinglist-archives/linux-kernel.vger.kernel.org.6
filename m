Return-Path: <linux-kernel+bounces-389040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF5A9B67CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47701F2369F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D120218936;
	Wed, 30 Oct 2024 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N7wIEeVd"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A33213ED9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301956; cv=none; b=DlIl1QpM8jnSqac5ypF5ZqDx+3lkl0zLmDsHiqt2jGR9Qua+rIXlqSKCc79XaFt7TZRZTlh6M43NKM2c+P1rHzP383gxJo2u7d+L9ZeVO09m7QOyitff2J2vMWY0jHzj/YjOEQ881WiNS4mSuer0Nu88f83MRfGWjwAZlfCysQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301956; c=relaxed/simple;
	bh=mccBWL9WEoEDXhSL3qlwPQc6HCn5mfi3S4mWhduGjio=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aA7q8V+eJy7bFYwDciLU+yURNsPE30NlS2U2m9wfpd5dm7EAtt2/kh3H10XM4F/enCVhxtYeRTM1OUS4CwAvJ8NDGuazRtotc9IesYoz7Y/l730ajYP+kH10LKRG4q3zRDIwh3HyczedpL9vyAIe/1+ThIHjkqWzxruLCII6l0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N7wIEeVd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=CENJfiIAjzpdW6w2/RkM/sIExyk1ul4yI9JaIDui0rk=; b=N7wIEeVdgULIyi7njLxxIBobBo
	BYg1apHI1COlEDCc6v/9zL2vMyDI2H3zeUlYdv9X65FHd+gUFf86aJJcQQMmhDyArZtNfSFTTag5M
	rOkT10ge9VT1kgPcDJzyFFSnNDuWrAo/fG8Vp6m5dvHRL617i1aIiVyhlOWgGP1vggBn4jEKwFOrG
	m+XaVCf/OJgN4GDVaeCiJkrkFvtsk1Geto8lLVLnjbCXYpiEDSXbE6vhHN35WJ9JWGIOXibDO/qfi
	PI04I0JAPQ2nV3oHVQWMI7lGlKIKLzTZpp5SxFPYxqkM+WmavZCrO+P43Wwjew787HNn4FL+Ploee
	VN+gSdZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AZs-0000000AI26-3P15;
	Wed, 30 Oct 2024 15:25:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DEF72301173; Wed, 30 Oct 2024 16:25:43 +0100 (CET)
Message-Id: <20241030152142.488737132@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 30 Oct 2024 16:12:57 +0100
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
Subject: [RFC][PATCH 2/6] sched: Employ sched_change guards
References: <20241030151255.300069509@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

As proposed a long while ago -- and half done by scx -- wrap the
scheduler's 'change' pattern in a guard helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cleanup.h |    5 +
 kernel/sched/core.c     |  158 ++++++++++++++++++------------------------------
 kernel/sched/ext.c      |   33 +++-------
 kernel/sched/sched.h    |   21 +++---
 kernel/sched/syscalls.c |   65 ++++++-------------
 5 files changed, 112 insertions(+), 170 deletions(-)

--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -297,6 +297,11 @@ static inline class_##_name##_t class_##
 #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
 static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
+#define DEFINE_CLASS_IS_UNCONDITIONAL(_name)		\
+	__DEFINE_CLASS_IS_CONDITIONAL(_name, false);	\
+	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
+	{ return (void *)1; }
+
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7099,7 +7099,7 @@ void rt_mutex_post_schedule(void)
  */
 void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 {
-	int prio, oldprio, queued, running, queue_flag =
+	int prio, oldprio, queue_flag =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	const struct sched_class *prev_class, *next_class;
 	struct rq_flags rf;
@@ -7164,52 +7164,42 @@ void rt_mutex_setprio(struct task_struct
 	if (prev_class != next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 
-	queued = task_on_rq_queued(p);
-	running = task_current_donor(rq, p);
-	if (queued)
-		dequeue_task(rq, p, queue_flag);
-	if (running)
-		put_prev_task(rq, p);
-
-	/*
-	 * Boosting condition are:
-	 * 1. -rt task is running and holds mutex A
-	 *      --> -dl task blocks on mutex A
-	 *
-	 * 2. -dl task is running and holds mutex A
-	 *      --> -dl task blocks on mutex A and could preempt the
-	 *          running task
-	 */
-	if (dl_prio(prio)) {
-		if (!dl_prio(p->normal_prio) ||
-		    (pi_task && dl_prio(pi_task->prio) &&
-		     dl_entity_preempt(&pi_task->dl, &p->dl))) {
-			p->dl.pi_se = pi_task->dl.pi_se;
-			queue_flag |= ENQUEUE_REPLENISH;
+	scoped_guard (sched_change, p, queue_flag) {
+		/*
+		 * Boosting condition are:
+		 * 1. -rt task is running and holds mutex A
+		 *      --> -dl task blocks on mutex A
+		 *
+		 * 2. -dl task is running and holds mutex A
+		 *      --> -dl task blocks on mutex A and could preempt the
+		 *          running task
+		 */
+		if (dl_prio(prio)) {
+			if (!dl_prio(p->normal_prio) ||
+			    (pi_task && dl_prio(pi_task->prio) &&
+			     dl_entity_preempt(&pi_task->dl, &p->dl))) {
+				p->dl.pi_se = pi_task->dl.pi_se;
+				scope.flags |= ENQUEUE_REPLENISH;
+			} else {
+				p->dl.pi_se = &p->dl;
+			}
+		} else if (rt_prio(prio)) {
+			if (dl_prio(oldprio))
+				p->dl.pi_se = &p->dl;
+			if (oldprio < prio)
+				scope.flags |= ENQUEUE_HEAD;
 		} else {
-			p->dl.pi_se = &p->dl;
+			if (dl_prio(oldprio))
+				p->dl.pi_se = &p->dl;
+			if (rt_prio(oldprio))
+				p->rt.timeout = 0;
 		}
-	} else if (rt_prio(prio)) {
-		if (dl_prio(oldprio))
-			p->dl.pi_se = &p->dl;
-		if (oldprio < prio)
-			queue_flag |= ENQUEUE_HEAD;
-	} else {
-		if (dl_prio(oldprio))
-			p->dl.pi_se = &p->dl;
-		if (rt_prio(oldprio))
-			p->rt.timeout = 0;
-	}
-
-	p->sched_class = next_class;
-	p->prio = prio;
 
-	check_class_changing(rq, p, prev_class);
+		p->sched_class = next_class;
+		p->prio = prio;
 
-	if (queued)
-		enqueue_task(rq, p, queue_flag);
-	if (running)
-		set_next_task(rq, p);
+		check_class_changing(rq, p, prev_class);
+	}
 
 	check_class_changed(rq, p, prev_class, oldprio);
 out_unlock:
@@ -7819,26 +7809,9 @@ int migrate_task_to(struct task_struct *
  */
 void sched_setnuma(struct task_struct *p, int nid)
 {
-	bool queued, running;
-	struct rq_flags rf;
-	struct rq *rq;
-
-	rq = task_rq_lock(p, &rf);
-	queued = task_on_rq_queued(p);
-	running = task_current_donor(rq, p);
-
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE);
-	if (running)
-		put_prev_task(rq, p);
-
-	p->numa_preferred_nid = nid;
-
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
-	task_rq_unlock(rq, p, &rf);
+	guard(task_rq_lock)(p);
+	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+		p->numa_preferred_nid = nid;
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
@@ -8957,9 +8930,10 @@ static void sched_change_group(struct ta
  */
 void sched_move_task(struct task_struct *tsk)
 {
-	int queued, running, queue_flags =
+	unsigned int queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	struct task_group *group;
+	bool resched = false;
 	struct rq *rq;
 
 	CLASS(task_rq_lock, rq_guard)(tsk);
@@ -8975,21 +8949,14 @@ void sched_move_task(struct task_struct
 
 	update_rq_clock(rq);
 
-	running = task_current_donor(rq, tsk);
-	queued = task_on_rq_queued(tsk);
+	scoped_guard (sched_change, tsk, queue_flags) {
+		sched_change_group(tsk, group);
+		scx_move_task(tsk);
+		if (scope.running)
+			resched = true;
+	}
 
-	if (queued)
-		dequeue_task(rq, tsk, queue_flags);
-	if (running)
-		put_prev_task(rq, tsk);
-
-	sched_change_group(tsk, group);
-	scx_move_task(tsk);
-
-	if (queued)
-		enqueue_task(rq, tsk, queue_flags);
-	if (running) {
-		set_next_task(rq, tsk);
+	if (resched) {
 		/*
 		 * After changing group, the running task may have joined a
 		 * throttled one but it's still the running task. Trigger a
@@ -10580,37 +10547,34 @@ void sched_mm_cid_fork(struct task_struc
 }
 #endif
 
-#ifdef CONFIG_SCHED_CLASS_EXT
-void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
-			    struct sched_enq_and_set_ctx *ctx)
+struct sched_change_ctx sched_change_begin(struct task_struct *p, unsigned int flags)
 {
 	struct rq *rq = task_rq(p);
-
-	lockdep_assert_rq_held(rq);
-
-	*ctx = (struct sched_enq_and_set_ctx){
+	struct sched_change_ctx ctx = {
 		.p = p,
-		.queue_flags = queue_flags,
+		.flags = flags,
 		.queued = task_on_rq_queued(p),
 		.running = task_current(rq, p),
 	};
 
-	update_rq_clock(rq);
-	if (ctx->queued)
-		dequeue_task(rq, p, queue_flags | DEQUEUE_NOCLOCK);
-	if (ctx->running)
+	lockdep_assert_rq_held(rq);
+
+	if (ctx.queued)
+		dequeue_task(rq, p, flags);
+	if (ctx.running)
 		put_prev_task(rq, p);
+
+	return ctx;
 }
 
-void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
+void sched_change_end(struct sched_change_ctx ctx)
 {
-	struct rq *rq = task_rq(ctx->p);
+	struct rq *rq = task_rq(ctx.p);
 
 	lockdep_assert_rq_held(rq);
 
-	if (ctx->queued)
-		enqueue_task(rq, ctx->p, ctx->queue_flags | ENQUEUE_NOCLOCK);
-	if (ctx->running)
-		set_next_task(rq, ctx->p);
+	if (ctx.queued)
+		enqueue_task(rq, ctx.p, ctx.flags | ENQUEUE_NOCLOCK);
+	if (ctx.running)
+		set_next_task(rq, ctx.p);
 }
-#endif	/* CONFIG_SCHED_CLASS_EXT */
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4355,11 +4355,10 @@ static void scx_ops_bypass(bool bypass)
 		 */
 		list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list,
 						 scx.runnable_node) {
-			struct sched_enq_and_set_ctx ctx;
-
 			/* cycling deq/enq is enough, see the function comment */
-			sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
-			sched_enq_and_set_task(&ctx);
+			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+				/* nothing */ ;
+			}
 		}
 
 		rq_unlock_irqrestore(rq, &rf);
@@ -4491,17 +4490,14 @@ static void scx_ops_disable_workfn(struc
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
-		struct sched_enq_and_set_ctx ctx;
 
 		if (old_class != new_class && p->se.sched_delayed)
 			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 
-		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
-
-		p->sched_class = new_class;
-		check_class_changing(task_rq(p), p, old_class);
-
-		sched_enq_and_set_task(&ctx);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+			p->sched_class = new_class;
+			check_class_changing(task_rq(p), p, old_class);
+		}
 
 		check_class_changed(task_rq(p), p, old_class, p->prio);
 		scx_ops_exit_task(p);
@@ -5206,18 +5202,15 @@ static int scx_ops_enable(struct sched_e
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
-		struct sched_enq_and_set_ctx ctx;
 
 		if (old_class != new_class && p->se.sched_delayed)
-			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEE_DELAYED);
-
-		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
-
-		p->scx.slice = SCX_SLICE_DFL;
-		p->sched_class = new_class;
-		check_class_changing(task_rq(p), p, old_class);
+			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 
-		sched_enq_and_set_task(&ctx);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+			p->scx.slice = SCX_SLICE_DFL;
+			p->sched_class = new_class;
+			check_class_changing(task_rq(p), p, old_class);
+		}
 
 		check_class_changed(task_rq(p), p, old_class, p->prio);
 	}
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3921,23 +3921,22 @@ static inline void balance_callbacks(str
 
 #endif
 
-#ifdef CONFIG_SCHED_CLASS_EXT
-/*
- * Used by SCX in the enable/disable paths to move tasks between sched_classes
- * and establish invariants.
- */
-struct sched_enq_and_set_ctx {
+struct sched_change_ctx {
 	struct task_struct	*p;
-	int			queue_flags;
+	unsigned int		flags;
 	bool			queued;
 	bool			running;
 };
 
-void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
-			    struct sched_enq_and_set_ctx *ctx);
-void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
+struct sched_change_ctx sched_change_begin(struct task_struct *p, unsigned int flags);
+void sched_change_end(struct sched_change_ctx ctx);
 
-#endif /* CONFIG_SCHED_CLASS_EXT */
+DEFINE_CLASS(sched_change, struct sched_change_ctx,
+	     sched_change_end(_T),
+	     sched_change_begin(p, flags),
+	     struct task_struct *p, unsigned int flags)
+
+DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
 
 #include "ext.h"
 
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -64,7 +64,6 @@ static int effective_prio(struct task_st
 
 void set_user_nice(struct task_struct *p, long nice)
 {
-	bool queued, running;
 	struct rq *rq;
 	int old_prio;
 
@@ -90,22 +89,12 @@ void set_user_nice(struct task_struct *p
 		return;
 	}
 
-	queued = task_on_rq_queued(p);
-	running = task_current_donor(rq, p);
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
-	if (running)
-		put_prev_task(rq, p);
-
-	p->static_prio = NICE_TO_PRIO(nice);
-	set_load_weight(p, true);
-	old_prio = p->prio;
-	p->prio = effective_prio(p);
-
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
+	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
+		p->static_prio = NICE_TO_PRIO(nice);
+		set_load_weight(p, true);
+		old_prio = p->prio;
+		p->prio = effective_prio(p);
+	}
 
 	/*
 	 * If the task increased its priority or is running and
@@ -528,7 +517,7 @@ int __sched_setscheduler(struct task_str
 			 bool user, bool pi)
 {
 	int oldpolicy = -1, policy = attr->sched_policy;
-	int retval, oldprio, newprio, queued, running;
+	int retval, oldprio, newprio;
 	const struct sched_class *prev_class, *next_class;
 	struct balance_callback *head;
 	struct rq_flags rf;
@@ -712,33 +701,25 @@ int __sched_setscheduler(struct task_str
 	if (prev_class != next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 
-	queued = task_on_rq_queued(p);
-	running = task_current_donor(rq, p);
-	if (queued)
-		dequeue_task(rq, p, queue_flags);
-	if (running)
-		put_prev_task(rq, p);
-
-	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
-		__setscheduler_params(p, attr);
-		p->sched_class = next_class;
-		p->prio = newprio;
-	}
-	__setscheduler_uclamp(p, attr);
-	check_class_changing(rq, p, prev_class);
+	scoped_guard (sched_change, p, queue_flags) {
 
-	if (queued) {
-		/*
-		 * We enqueue to tail when the priority of a task is
-		 * increased (user space view).
-		 */
-		if (oldprio < p->prio)
-			queue_flags |= ENQUEUE_HEAD;
+		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
+			__setscheduler_params(p, attr);
+			p->sched_class = next_class;
+			p->prio = newprio;
+		}
+		__setscheduler_uclamp(p, attr);
+		check_class_changing(rq, p, prev_class);
 
-		enqueue_task(rq, p, queue_flags);
+		if (scope.queued) {
+			/*
+			 * We enqueue to tail when the priority of a task is
+			 * increased (user space view).
+			 */
+			if (oldprio < p->prio)
+				scope.flags |= ENQUEUE_HEAD;
+		}
 	}
-	if (running)
-		set_next_task(rq, p);
 
 	check_class_changed(rq, p, prev_class, oldprio);
 



