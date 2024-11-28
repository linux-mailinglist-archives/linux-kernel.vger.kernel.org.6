Return-Path: <linux-kernel+bounces-424457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C179DB4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A018B212E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39327154C17;
	Thu, 28 Nov 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FDgrpQJ+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C936145A11
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732785583; cv=none; b=i/s2LKMlxywMhl9UClp5j0/hZa8XUInOKI9OcXY7qdlqy5ojEU2DwsCKtVRGfvrMo1mZRxzSRZS/YeI1hqwBh7GentqC5gqitn5MnZQF4Hb0I/wYFt1hm1S5qO5+OfXDIjiDu+zl0BbGfhpbdSMhXb7oS7bd5KD+PoEc98+Pi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732785583; c=relaxed/simple;
	bh=s5W+v/C6cusXbgreQW0+ioRU/S8M+YoB0GPtA1wsWqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGSnaBywOOebDUNNEArrwlAKmzOSIKlnHxXlIBCSD8pCXSyRnONPwjVWc6kag07i1hsy6NUHP/GNCOhVyS1nikxpfsIMQVqTtPS2CB7LiR5qwBYLXIQFDxWEIYDII0ujI0McVgWNC40TqO4f2obvrUld6GhzfFBzB2KlcumoG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FDgrpQJ+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aR/WbrU3RjKXoJdoSEx3mnXcQvouWTeva8Zm8RcmJc0=; b=FDgrpQJ+nROnMoRohfCqAVuhp5
	LMvSx/V+OCQOrPsXK8ZtcsnVfg2LZJ71L8q5I6q4+nE3kbe2FWd3CXWIJFyTBhlx/3Ow1ibLWc2iT
	onAhd42dDmR4rnJj+53vhDVzrUTWMHisI8Q6Gsy5WfKcgM9F3FUyr782RCP9FePaIF8RvEGlbQFD8
	TnlQH+6sPalBRkdpvTJ1owWfRTON5Sus2nSlMZpuEPofZmZMHT9H+qbF61nBGn7WSdcMA3gJmOYt+
	Pr9RFqaFF634JOE2Mfa/FQanxYoTe9/dvSLjmdPLUalc/J9Q/kmvXVZewtXxLqXF8lTjHI+0/CG1q
	d0mWQk5g==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGagK-00000002Ru6-3mu2;
	Thu, 28 Nov 2024 09:19:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3160A300271; Thu, 28 Nov 2024 10:19:29 +0100 (CET)
Date: Thu, 28 Nov 2024 10:19:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH] sched/core: Do not migrate ineligible tasks in
 sched_balance_rq()
Message-ID: <20241128091929.GA35539@noisy.programming.kicks-ass.net>
References: <20241128084858.25220-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128084858.25220-1-jiahao.kernel@gmail.com>

On Thu, Nov 28, 2024 at 04:48:58PM +0800, Hao Jia wrote:
> From: Hao Jia <jiahao1@lixiang.com>
> 
> When the PLACE_LAG scheduling feature is enabled, if a task
> is ineligible (lag < 0) on the source cpu runqueue, it will
> also be ineligible when it is migrated to the destination
> cpu runqueue.
> 
> Because we will keep the original equivalent lag of
> the task in place_entity(). So if the task was ineligible
> before, it will still be ineligible after migration.

This is not accurate, it will be eleigible, irrespective of lag, if
there are no other tasks. I think your patch tries to do this, but I'm
fairly sure it got it wrong.

> Therefore, we should skip the migration of ineligible tasks
> to reduce ineffective task migrations, just like the task
> throttled by cfs_bandwidth, until they become eligible.

And this misses an important case too -- load-balancing will try very
hard to balance load. If you disallow migrating tasks it might fail to
reach this goal. Since this is not a hard contraint it should eventually
give in and migrate it anyway.

That is, I would suggest allowing it when nr_balance_failed is non-zero.

> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> ---
>  kernel/sched/fair.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fbdca89c677f..5564e16b6fdb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9358,13 +9358,14 @@ static inline int migrate_degrades_locality(struct task_struct *p,
>  static
>  int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  {
> +	struct cfs_rq *cfs_rq = task_cfs_rq(p);
>  	int tsk_cache_hot;
>  
>  	lockdep_assert_rq_held(env->src_rq);
>  
>  	/*
>  	 * We do not migrate tasks that are:
> -	 * 1) throttled_lb_pair, or
> +	 * 1) throttled_lb_pair, or task ineligible, or
>  	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
>  	 * 3) running (obviously), or
>  	 * 4) are cache-hot on their current CPU.
> @@ -9372,6 +9373,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>  		return 0;
>  
> +	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running &&
> +			!entity_eligible(cfs_rq, &p->se))

Your indenting it wrong, please use: cino=(0:0

> +		return 0;
> +
>  	/* Disregard percpu kthreads; they are where they need to be. */
>  	if (kthread_is_per_cpu(p))
>  		return 0;
> -- 
> 2.34.1
> 

