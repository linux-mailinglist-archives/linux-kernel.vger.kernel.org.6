Return-Path: <linux-kernel+bounces-260203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2640993A476
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FDF284524
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A631581E9;
	Tue, 23 Jul 2024 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UdhBp+wR"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39295157E8B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752450; cv=none; b=XKaidDh6Q2ONXO5ocSF0swEau/h4pYHpcKrZ9BW7EIsOe9wx2muoILdeVnAtrIZWoP0LHI6i/CKR6s9BogPFe2smuvyGVPjSYU6GRDg85CIB7+nZ2WF1cMbMHjfRoPxZ2QOq06S2pgTyDCfnyJ6PEh1Am+NanLT3muKYjG3USOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752450; c=relaxed/simple;
	bh=5utafZJ67SzbkhVteNqzLs+TJ3mFxTMKTkX2yQiSOK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcgT9IxSRhGzfh7llYVZ5imBSdRc2LDo6OhdVCjtJbwwhFpKtrzvJCmtqrKlVTUA1tUr5BBjp2CNFl9ktmtBjARHlhOeRvBHq5N5T5Q7gXCjjR+xqsTX7nhsOpS3zCrZ3/jVkrOJJfKcpXmib5qkY6MHjo8HGkJEI0FlkETDj28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UdhBp+wR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qbjknmzu+LU82a7Kil3PkTwU+OwCxh55DBnlesFC1xc=; b=UdhBp+wRYbskPdC18wHqYcWsCa
	/bIqCUiEFw0k8PEX6IOPwIFiNbF5kiLWZXiyEfqlv408sb7Q7OtS24q32jJL0P01vhvGFRpKncg49
	woLYeturDddUGjtwr44ZFUHhYbuBLX/FX7F8ctHv4en4BHeiEVQM9U+DKjPXNph3GnrPivm2hDIC3
	/Br0RoBhp2q4dUcawM6gRYiwVojYgZ+pbwuYeySflHL/IdBYJgy0SqT+BOjffon1EADCli/TCS/Cg
	gpV5mvf/s2H/fyqVL4f0zQ+55zJLAyOAnqF4aro0+BU/dqGFhI4b3vJUiTzSYdSjoUI0Cm7qiBLwD
	ZslJRPWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWISe-00000003iuj-1mfo;
	Tue, 23 Jul 2024 16:34:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 14C44300754; Tue, 23 Jul 2024 18:33:59 +0200 (CEST)
Date: Tue, 23 Jul 2024 18:33:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240723163358.GM26750@noisy.programming.kicks-ass.net>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>


Taken from git diff from your tree against Linus' tree... I've not yet
read everything, but I figured I should share these bits.

---

> @@ -1255,11 +1263,14 @@ bool sched_can_stop_tick(struct rq *rq)
>  		return true;
>  
>  	/*
> -	 * If there are no DL,RR/FIFO tasks, there must only be CFS tasks left;
> -	 * if there's more than one we need the tick for involuntary
> -	 * preemption.
> +	 * If there are no DL,RR/FIFO tasks, there must only be CFS or SCX tasks
> +	 * left. For CFS, if there's more than one we need the tick for
> +	 * involuntary preemption. For SCX, ask.
>  	 */
> -	if (rq->nr_running > 1)
> +	if (!scx_switched_all() && rq->nr_running > 1)
> +		return false;
> +
> +	if (scx_enabled() && !scx_can_stop_tick(rq))
>  		return false;
>  

Doesn't that boil down to something like:

	if (scx_switched_all())
		return scx_can_stop_tick(rq);

	if (rq->nr_running > 1)
		return false;

> @@ -5773,7 +5827,19 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
>  				  struct rq_flags *rf)
>  {
>  #ifdef CONFIG_SMP
> +	const struct sched_class *start_class = prev->sched_class;
>  	const struct sched_class *class;
> +
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	/*
> +	 * SCX requires a balance() call before every pick_next_task() including
> +	 * when waking up from SCHED_IDLE. If @start_class is below SCX, start
> +	 * from SCX instead.
> +	 */
> +	if (sched_class_above(&ext_sched_class, start_class))
> +		start_class = &ext_sched_class;

	if (scx_enabled() && ...)

?

> +#endif
> +
>  	/*
>  	 * We must do the balancing pass before put_prev_task(), such
>  	 * that when we release the rq->lock the task is in the same
> @@ -5782,7 +5848,7 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
>  	 * We can terminate the balance pass as soon as we know there is
>  	 * a runnable task of @class priority or higher.
>  	 */
> -	for_class_range(class, prev->sched_class, &idle_sched_class) {
> +	for_active_class_range(class, start_class, &idle_sched_class) {
>  		if (class->balance(rq, prev, rf))
>  			break;

Don't you need fixing balance_fair() here? It has:

  if (rq->nr_running)
    return 1;

Which would return true and terminate the iteration even if there are
only scx tasks left.

>  	}
> @@ -5800,6 +5866,9 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	const struct sched_class *class;
>  	struct task_struct *p;
>  
> +	if (scx_enabled())
> +		goto restart;
> +
>  	/*
>  	 * Optimization: we know that if all tasks are in the fair class we can
>  	 * call that function directly, but only if the @prev task wasn't of a
> @@ -5840,10 +5909,15 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	if (prev->dl_server)
>  		prev->dl_server = NULL;
>  
> -	for_each_class(class) {
> +	for_each_active_class(class) {
>  		p = class->pick_next_task(rq);
> -		if (p)
> +		if (p) {
> +			const struct sched_class *prev_class = prev->sched_class;
> +
> +			if (class != prev_class && prev_class->switch_class)
> +				prev_class->switch_class(rq, p);
>  			return p;
> +		}
>  	}

So I really don't like this one.. at the very least it would need a comment
explaining why it only needs calling here and not every time a put_prev_task()
and set_next_task() pair cross a class boundary -- which would be the
consistent thing to do.

Now, IIRC, you need a class call that indicates you're about to loose the CPU
so that you can kick the task to another CPU or somesuch. And last time I got
it backwards and suggested adding an argument to pick_next_task(), but what
about put_prev_task()?

Can't we universally push put_prev_task() after the pick loop? Then we get
something like:

	next = pick_task();
	if (next != prev) {
		put_prev_task(rq, prev, next->class != prev->class);
		set_next_task(rq, next);
	}

I have patches for most of this for fair (in my eevdf queue), and I
think the others are doable, after all, this is more or less what we do
for SCHED_CORE already.

  /me went off hacking for a bit

I've done this; find the results at: queue.git sched/prep

I've also rebased the sched_ext tree on top of that with the below delta, which
you can find at: queue.git sched/scx

This led me to discover that you're passing the task of the other class into
the bpf stuff -- I don't think that is a sane thing to do. You get preempted,
it doesn't matter from which higher class or by which specific task, a policy
must not care about that. So I kinda bodged it, but I really think this should
be taken out.

I also found you have some terrible !SMP hack in there, which I've
broken, I've disabled it for now. This needs a proper fix, and not
something ugly like you did.

Anyway, it seems to build, boot and pass the sched_ext selftest:

PASSED:  21
SKIPPED: 0
FAILED:  0

(albeit with a fair amount of console noise -- is that expected?)

Also, why does that thing hard depend on DEBUG_BTF? (at least having
that option enabled no longer explodes build times like it used to)

Also should we /CONFIG_SCHED_CLASS_EXT/CONFIG_SCHED_BPF/ ? Then
something like: grep BPF foo-build/.config
more easily shows what's what.

I suppose I'll look more at all this in the coming days ... *sigh*


---
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index da9cac6b6cc2a..6375a648d3bf5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2015,11 +2015,11 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
 	}
 }
 
-static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags)
+static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags)
 {
 	if (!(p->scx.flags & SCX_TASK_QUEUED)) {
 		WARN_ON_ONCE(task_runnable(p));
-		return;
+		return true;
 	}
 
 	ops_dequeue(p, deq_flags);
@@ -2054,6 +2054,8 @@ static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	sub_nr_running(rq, 1);
 
 	dispatch_dequeue(rq, p);
+
+	return true;
 }
 
 static void yield_task_scx(struct rq *rq)
@@ -2702,6 +2704,18 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 		 */
 		update_other_load_avgs(rq);
 	}
+
+	if (!first)
+		return;
+
+	if (unlikely(!p->scx.slice)) {
+		if (!scx_ops_bypassing() && !scx_warned_zero_slice) {
+			printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
+					p->comm, p->pid);
+			scx_warned_zero_slice = true;
+		}
+		p->scx.slice = SCX_SLICE_DFL;
+	}
 }
 
 static void process_ddsp_deferred_locals(struct rq *rq)
@@ -2727,10 +2741,15 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 	}
 }
 
-static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
+static void switch_class_scx(struct rq *rq);
+
+static void put_prev_task_scx(struct rq *rq, struct task_struct *p, bool change_class)
 {
-#ifndef CONFIG_SMP
+#if 0 // ndef CONFIG_SMP
 	/*
+	 * XXX broken, put_prev no longer comes after balance but now comes
+	 * after pick.
+	 *
 	 * UP workaround.
 	 *
 	 * Because SCX may transfer tasks across CPUs during dispatch, dispatch
@@ -2774,7 +2793,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 		p->scx.flags &= ~SCX_TASK_BAL_KEEP;
 		set_task_runnable(rq, p);
 		dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
-		return;
+		goto out;
 	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
@@ -2788,7 +2807,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 		 */
 		if (p->scx.slice && !scx_ops_bypassing()) {
 			dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
-			return;
+			goto out;
 		}
 
 		/*
@@ -2805,6 +2824,14 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 		else
 			do_enqueue_task(rq, p, 0, -1);
 	}
+
+out:
+	/*
+	 * XXX switch_class was called after put, if this can be called earlier
+	 * the goto can be avoided.
+	 */
+	if (change_class)
+		switch_class_scx(rq);
 }
 
 static struct task_struct *first_local_task(struct rq *rq)
@@ -2813,34 +2840,6 @@ static struct task_struct *first_local_task(struct rq *rq)
 					struct task_struct, scx.dsq_list.node);
 }
 
-static struct task_struct *pick_next_task_scx(struct rq *rq)
-{
-	struct task_struct *p;
-
-#ifndef CONFIG_SMP
-	/* UP workaround - see the comment at the head of put_prev_task_scx() */
-	if (unlikely(rq->curr->sched_class != &ext_sched_class))
-		balance_one(rq, rq->curr, true);
-#endif
-
-	p = first_local_task(rq);
-	if (!p)
-		return NULL;
-
-	set_next_task_scx(rq, p, true);
-
-	if (unlikely(!p->scx.slice)) {
-		if (!scx_ops_bypassing() && !scx_warned_zero_slice) {
-			printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
-					p->comm, p->pid);
-			scx_warned_zero_slice = true;
-		}
-		p->scx.slice = SCX_SLICE_DFL;
-	}
-
-	return p;
-}
-
 #ifdef CONFIG_SCHED_CORE
 /**
  * scx_prio_less - Task ordering for core-sched
@@ -2874,6 +2873,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	else
 		return time_after64(a->scx.core_sched_at, b->scx.core_sched_at);
 }
+#endif	/* CONFIG_SCHED_CORE */
 
 /**
  * pick_task_scx - Pick a candidate task for core-sched
@@ -2917,28 +2917,9 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 
 	return first;	/* this may be %NULL */
 }
-#endif	/* CONFIG_SCHED_CORE */
 
-static enum scx_cpu_preempt_reason
-preempt_reason_from_class(const struct sched_class *class)
+static void switch_class_scx(struct rq *rq)
 {
-#ifdef CONFIG_SMP
-	if (class == &stop_sched_class)
-		return SCX_CPU_PREEMPT_STOP;
-#endif
-	if (class == &dl_sched_class)
-		return SCX_CPU_PREEMPT_DL;
-	if (class == &rt_sched_class)
-		return SCX_CPU_PREEMPT_RT;
-	return SCX_CPU_PREEMPT_UNKNOWN;
-}
-
-static void switch_class_scx(struct rq *rq, struct task_struct *next)
-{
-	const struct sched_class *next_class = next->sched_class;
-
-	if (!scx_enabled())
-		return;
 #ifdef CONFIG_SMP
 	/*
 	 * Pairs with the smp_load_acquire() issued by a CPU in
@@ -2950,15 +2931,6 @@ static void switch_class_scx(struct rq *rq, struct task_struct *next)
 	if (!static_branch_unlikely(&scx_ops_cpu_preempt))
 		return;
 
-	/*
-	 * The callback is conceptually meant to convey that the CPU is no
-	 * longer under the control of SCX. Therefore, don't invoke the callback
-	 * if the next class is below SCX (in which case the BPF scheduler has
-	 * actively decided not to schedule any tasks on the CPU).
-	 */
-	if (sched_class_above(&ext_sched_class, next_class))
-		return;
-
 	/*
 	 * At this point we know that SCX was preempted by a higher priority
 	 * sched_class, so invoke the ->cpu_release() callback if we have not
@@ -2971,8 +2943,8 @@ static void switch_class_scx(struct rq *rq, struct task_struct *next)
 	if (!rq->scx.cpu_released) {
 		if (SCX_HAS_OP(cpu_release)) {
 			struct scx_cpu_release_args args = {
-				.reason = preempt_reason_from_class(next_class),
-				.task = next,
+				.reason = SCX_CPU_PREEMPT_UNKNOWN,
+				.task = NULL,
 			};
 
 			SCX_CALL_OP(SCX_KF_CPU_RELEASE,
@@ -3678,13 +3650,12 @@ DEFINE_SCHED_CLASS(ext) = {
 
 	.wakeup_preempt		= wakeup_preempt_scx,
 
+	.pick_task		= pick_task_scx,
 	.pick_next_task		= pick_next_task_scx,
 
 	.put_prev_task		= put_prev_task_scx,
 	.set_next_task		= set_next_task_scx,
 
-	.switch_class		= switch_class_scx,
-
 #ifdef CONFIG_SMP
 	.balance		= balance_scx,
 	.select_task_rq		= select_task_rq_scx,
@@ -3695,10 +3666,6 @@ DEFINE_SCHED_CLASS(ext) = {
 	.rq_offline		= rq_offline_scx,
 #endif
 
-#ifdef CONFIG_SCHED_CORE
-	.pick_task		= pick_task_scx,
-#endif
-
 	.task_tick		= task_tick_scx,
 
 	.switching_to		= switching_to_scx,

