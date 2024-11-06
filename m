Return-Path: <linux-kernel+bounces-398344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E719BEFE2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442851C23270
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827F2201033;
	Wed,  6 Nov 2024 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bf/Pkzix"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A2317DFF2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902470; cv=none; b=lmHl2QC++7EQ6WVMKiPV67ahtj6FXfIXhUrUqkmROl5AGKF+OTC/XgYYSfzNz0MT6Ixm1ncP3cmfudoFoNulvNxJBOtYB+vHWmLuYrccsTHAuyybrRraoO7R7uqPhyAO8HBugLYLaEO59gATt95YgL7omZSfbdbsax8W1StQ33Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902470; c=relaxed/simple;
	bh=N5SdKO4ehfL4iQyZh4SD9hMu5lTcta6dKxtrjxrB27o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+2fZZIBdg1z5i59sRxBd9XT1nQwu83WFX3e60rOhbEWb0VznwmiLjMGEtl7aYQg6cHsIWAAsPzEG2FWwGAx2Om5WbGwVLeduKX2BgYvcDmM12OtcVmXRxZFGLQta17Y2ImDIxBHl81LRiGQkzCzfw+d+7fuD2CBdTC66A5Qg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bf/Pkzix; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B43GbIBS2o8It4Z+1jpOf7ITiZ9iWAZcE6LL+80Es+M=; b=Bf/Pkzixrozw925uIiMA6diGTt
	KDE3Qk8fi+LTfW3oHtHkqIb9fdQqjTW18GnbrRwwPx55S9Ty83/kXbXX8NUkmktTFiTeuQgogDZlH
	37Xe7u9m8ktfS34lW+4Y8mqaD9nqPTW3z7jzx3ZCgblkEmlkWtXgvmUC7/Djw1Muiu+2Gy+9drdty
	8DiprSTqQ6yxcWRAyrtNM1uZjMLDHeCYASxHfZFN7m0DbiojYoNB+zsWLVsuBbiYOfDuQEyBtkh8y
	sWzstnm7GbR4aCx/G/XXdjtH8IfMvhRfJ9hDApf5EazMlohBG+YKEo6KsAjOIbsdTbcUQInyFFBAk
	tfIPtUZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8gnc-00000004gfd-11cB;
	Wed, 06 Nov 2024 14:14:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7BBD9300478; Wed,  6 Nov 2024 15:14:20 +0100 (CET)
Date: Wed, 6 Nov 2024 15:14:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Phil Auld <pauld@redhat.com>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
References: <20241101125659.GY14555@noisy.programming.kicks-ass.net>
 <20241101133822.GC689589@pauld.westford.csb>
 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
 <20241101144225.GD689589@pauld.westford.csb>
 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
 <20241101200704.GE689589@pauld.westford.csb>
 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
 <20241104130515.GB749675@pauld.westford.csb>
 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
 <20241106135346.GL24862@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106135346.GL24862@noisy.programming.kicks-ass.net>

On Wed, Nov 06, 2024 at 02:53:46PM +0100, Peter Zijlstra wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 54d82c21fc8e..b083c6385e88 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3774,28 +3774,38 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
>   */
>  static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  {
> +	CLASS(__task_rq_lock, rq_guard)(p);
> +	struct rq *rq = rq_guard.rq;
>  
> +	if (!task_on_rq_queued(p))
> +		return 0;
> +
> +	update_rq_clock(rq);
> +	if (p->se.sched_delayed) {
> +		int queue_flags = ENQUEUE_DELAYED | ENQUEUE_NOCLOCK;
> +
> +		/*
> +		 * Since sched_delayed means we cannot be current anywhere,
> +		 * dequeue it here and have it fall through to the
> +		 * select_task_rq() case further along the ttwu() path.
> +		 */
> +		if (rq->nr_running > 1 && p->nr_cpus_allowed > 1) {
> +			dequeue_task(rq, p, DEQUEUE_SLEEP | queue_flags);
> +			return 0;
>  		}
> +
> +		enqueue_task(rq, p, queue_flags);

And then I wondered... this means that !task_on_cpu() is true for
sched_delayed, and thus we can move this in the below branch.

But also, we can probably dequeue every such task, not only
sched_delayed ones.

>  	}
> +	if (!task_on_cpu(rq, p)) {
> +		/*
> +		 * When on_rq && !on_cpu the task is preempted, see if
> +		 * it should preempt the task that is current now.
> +		 */
> +		wakeup_preempt(rq, p, wake_flags);
> +	}
> +	ttwu_do_wakeup(p);
>  
> +	return 1;
>  }


Yielding something like this on top... which boots. But since I forgot
to make it a feature, I can't actually tell at this point.. *sigh*

Anyway, more toys to poke at I suppose.


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b083c6385e88..69b19ba77598 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3781,28 +3781,32 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 		return 0;
 
 	update_rq_clock(rq);
-	if (p->se.sched_delayed) {
-		int queue_flags = ENQUEUE_DELAYED | ENQUEUE_NOCLOCK;
+	if (!task_on_cpu(rq, p)) {
+		int queue_flags = DEQUEUE_NOCLOCK;
+
+		if (p->se.sched_delayed)
+			queue_flags |= DEQUEUE_DELAYED;
 
 		/*
-		 * Since sched_delayed means we cannot be current anywhere,
-		 * dequeue it here and have it fall through to the
-		 * select_task_rq() case further along the ttwu() path.
+		 * Since we're not current anywhere *AND* hold pi_lock, dequeue
+		 * it here and have it fall through to the select_task_rq()
+		 * case further along the ttwu() path.
 		 */
 		if (rq->nr_running > 1 && p->nr_cpus_allowed > 1) {
 			dequeue_task(rq, p, DEQUEUE_SLEEP | queue_flags);
 			return 0;
 		}
 
-		enqueue_task(rq, p, queue_flags);
-	}
-	if (!task_on_cpu(rq, p)) {
+		if (p->se.sched_delayed)
+			enqueue_task(rq, p, queue_flags);
+
 		/*
 		 * When on_rq && !on_cpu the task is preempted, see if
 		 * it should preempt the task that is current now.
 		 */
 		wakeup_preempt(rq, p, wake_flags);
 	}
+	SCHED_WARN_ON(p->se.sched_delayed);
 	ttwu_do_wakeup(p);
 
 	return 1;

