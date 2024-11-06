Return-Path: <linux-kernel+bounces-398317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3089BEF7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4230284FE9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86C71E0DBD;
	Wed,  6 Nov 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uGQ0IEp6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606017DFF2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901244; cv=none; b=FOZE5eeFtzRrmJnMS6jZ+6ADbeMr/sCItekLd4knct3RCgLLiAJ6I2ZNS8NLMwQt0EDfAYE9vp7wtvPvjmqm17zQieOhyhalxa4wuNOvt5GgrbLyFx/nnax1cpTdAzyqHxNuky3mCLj1P7fIQAFTdks6edUQwKbGqIR8S7Z3gYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901244; c=relaxed/simple;
	bh=Hst5Fr0sqCFfT7B2GUw60fDs8HSuAWxxaHv9EDQuG/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRqoQrk3iKXkKcMeTpFZzG1LXYwI4Jhe+gmOhsMcRwHTrqUH1RwemBcyH9qUks8K5TtvcRGJrtEv1uoq9MEmhHRg6TR85GFokF9z3OtGkf800hkKlAUC8zVvhqmwOtby4NraHe78fckAidlyCWFTDX0yg4J3+8foIFlkU80O6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uGQ0IEp6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oU78uCbqhyIN6K5fs4xThp+jJ2hpjkhaK5esFgU4m68=; b=uGQ0IEp6y7Rrg37koB1LltOR7T
	9Eos64IXF/AMgEKJMGN9xtTpNtuNu6gV+/RavXXFQLCisjN8yOZ9VpQmWajiyK2frdHSHYLgvR70W
	knaoxBFfRfnliRakM4MpcNsB5rBzd+cTIbSKyHX4yq7qCDoEqeeTwuPPODbh0y2gzGZjhQDTQAvkV
	PSG7cc68b3+ixPK7480aiFU2z6w89/oicl2uyqnYD9OslvIdCVBMX8bjclsjk93drSOvvBWlyJzVL
	yB6uFJPGeaWTkR1HDDpMw0E3yYEYrr2sfQQysHf9gEPG+5sIVcxuaMfPAjhkkaXZePvzKz9rAqyjw
	D/6AXNFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8gTj-00000004et7-02rh;
	Wed, 06 Nov 2024 13:53:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B162A300478; Wed,  6 Nov 2024 14:53:46 +0100 (CET)
Date: Wed, 6 Nov 2024 14:53:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Phil Auld <pauld@redhat.com>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241106135346.GL24862@noisy.programming.kicks-ass.net>
References: <20241101124715.GA689589@pauld.westford.csb>
 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
 <20241101133822.GC689589@pauld.westford.csb>
 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
 <20241101144225.GD689589@pauld.westford.csb>
 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
 <20241101200704.GE689589@pauld.westford.csb>
 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
 <20241104130515.GB749675@pauld.westford.csb>
 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>

On Tue, Nov 05, 2024 at 05:05:12AM +0100, Mike Galbraith wrote:

> After one minute of lightly loaded box browsing, trace_printk() said:
> 
>   645   - racy peek says there is a room available
>    11   - cool, reserved room is free
>   206   - no vacancy or wakee pinned
> 38807   - SIS accommodates room seeker
> 
> The below should improve the odds, but high return seems unlikely.
> 
> ---
>  kernel/sched/core.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3790,7 +3790,13 @@ static int ttwu_runnable(struct task_str
>  	rq = __task_rq_lock(p, &rf);
>  	if (task_on_rq_queued(p)) {
>  		update_rq_clock(rq);
> -		if (p->se.sched_delayed)
> +		/*
> +		 * If wakee is mobile and the room it reserved is occupied, let it try to migrate.
> +		 */
> +		if (p->se.sched_delayed && rq->nr_running > 1 && cpumask_weight(p->cpus_ptr) > 1) {
> +			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> +			goto out_unlock;
> +		} else if (p->se.sched_delayed)
>  			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
>  		if (!task_on_cpu(rq, p)) {
>  			/*
> @@ -3802,6 +3808,7 @@ static int ttwu_runnable(struct task_str
>  		ttwu_do_wakeup(p);
>  		ret = 1;
>  	}
> +out_unlock:
>  	__task_rq_unlock(rq, &rf);
> 
>  	return ret;

So... I was trying to make that prettier and ended up with something
like this:

---
 kernel/sched/core.c  | 46 ++++++++++++++++++++++++++++------------------
 kernel/sched/sched.h |  5 +++++
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 54d82c21fc8e..b083c6385e88 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3774,28 +3774,38 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
  */
 static int ttwu_runnable(struct task_struct *p, int wake_flags)
 {
-	struct rq_flags rf;
-	struct rq *rq;
-	int ret = 0;
+	CLASS(__task_rq_lock, rq_guard)(p);
+	struct rq *rq = rq_guard.rq;
 
-	rq = __task_rq_lock(p, &rf);
-	if (task_on_rq_queued(p)) {
-		update_rq_clock(rq);
-		if (p->se.sched_delayed)
-			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
-		if (!task_on_cpu(rq, p)) {
-			/*
-			 * When on_rq && !on_cpu the task is preempted, see if
-			 * it should preempt the task that is current now.
-			 */
-			wakeup_preempt(rq, p, wake_flags);
+	if (!task_on_rq_queued(p))
+		return 0;
+
+	update_rq_clock(rq);
+	if (p->se.sched_delayed) {
+		int queue_flags = ENQUEUE_DELAYED | ENQUEUE_NOCLOCK;
+
+		/*
+		 * Since sched_delayed means we cannot be current anywhere,
+		 * dequeue it here and have it fall through to the
+		 * select_task_rq() case further along the ttwu() path.
+		 */
+		if (rq->nr_running > 1 && p->nr_cpus_allowed > 1) {
+			dequeue_task(rq, p, DEQUEUE_SLEEP | queue_flags);
+			return 0;
 		}
-		ttwu_do_wakeup(p);
-		ret = 1;
+
+		enqueue_task(rq, p, queue_flags);
 	}
-	__task_rq_unlock(rq, &rf);
+	if (!task_on_cpu(rq, p)) {
+		/*
+		 * When on_rq && !on_cpu the task is preempted, see if
+		 * it should preempt the task that is current now.
+		 */
+		wakeup_preempt(rq, p, wake_flags);
+	}
+	ttwu_do_wakeup(p);
 
-	return ret;
+	return 1;
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 21b1780c6695..1714ac38500f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1787,6 +1787,11 @@ task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
+DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
+		    _T->rq = __task_rq_lock(_T->lock, &_T->rf),
+		    __task_rq_unlock(_T->rq, &_T->rf),
+		    struct rq *rq; struct rq_flags rf)
+
 DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
 		    _T->rq = task_rq_lock(_T->lock, &_T->rf),
 		    task_rq_unlock(_T->rq, _T->lock, &_T->rf),

