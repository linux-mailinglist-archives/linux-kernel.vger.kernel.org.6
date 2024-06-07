Return-Path: <linux-kernel+bounces-205823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C309E9000D1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485DD2879B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F219915B12A;
	Fri,  7 Jun 2024 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k6K3EGki"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00B2F2B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756262; cv=none; b=p4OsNZjWBlEpmBuCDilYtvARO9DQ3ZuaMQWWzLIviWFjHcJyuPREIsIugh1xWb8m/mTHmXMvrgcZcFLYrSMQo5WSerJkUfcunghzHCj/h8nyhzUkN1Rzm8gyg3qL5IM3pYTpepOrP/Jm7UwMRyjd+tWMAlU6GdufaSobvBTF9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756262; c=relaxed/simple;
	bh=TH4cscibZLSNy4YsDvEPmdXH2rRNMmDbYIaDLwboVUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BArEq6yKmxkjm6FqxWT17qWsRdDFgjIJ+CxBUk8YOL69M9WNO70cTME5i7dL0dqdfi36RXa8RMB2eoE45+IR3vpGs22DFf8noNfuxMqGZQURZbCv7XJh5ErkUS+tdC9N6fcye34Lxwr0YhVaESeCzHppGHdvlihrfUth7N4Z1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k6K3EGki; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uyoBt0JfhrDyTzN3Vspe+/CrH6yaV6pDIoW5yTEXKos=; b=k6K3EGkiBF4XVnPjzFLdokzTJv
	ebb7u0invf9NHAcVPNjyfvZAjYjzyquHcuwO6ixuUQL24xR7iSMTXigMypLm3h5f54/q+NuiRhnnt
	xdeIZrT0Mh0KXGaeL1rPLIJXP3+3SE2SNZ3GOC06WOJnvmQQGTuc9FBWswRXk8AJ/al3v9V9cr6/E
	R29g+tPKXTqmYBvYNSxksz0Wu/0Sx6pMmH/YS/wO5NvWv/YZh9b6zq0hNbG+4cVfK7Okx03OO9U4P
	7PJYWIU4plys4X0v5DrvOLXCwWmNxoFTZVMoBNgTY82eUvTW0bOvtqAvCIy10wuL3mf46oMraPgOP
	xCSSyjVw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFWru-00000005IK2-0Ewb;
	Fri, 07 Jun 2024 10:30:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E470D30047C; Fri,  7 Jun 2024 12:30:43 +0200 (CEST)
Date: Fri, 7 Jun 2024 12:30:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Initialize the vruntime of a new task when it is
 first enqueued
Message-ID: <20240607103043.GO8774@noisy.programming.kicks-ass.net>
References: <20240606121133.2218723-1-zhangqiao22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606121133.2218723-1-zhangqiao22@huawei.com>

On Thu, Jun 06, 2024 at 08:11:33PM +0800, Zhang Qiao wrote:
> When create a new task, we initialize vruntime of the new task
> at sched_cgroup_fork(). However, the timing of executing this
> action is too early and may not be accurate.
> 
> Because it use current cpu to init the vruntime, but the new
> task actually runs on the cpu which be assigned at wake_up_new_task().
> 
> To optimize this case, we pass ENQUEUE_INITIAL flag to
> activate_task() in wake_up_new_task(), in this way,
> when place_entity is called in enqueue_entity(), the
> vruntime of the new task will be initialized. At the same
> time, place_entity in task_fork_fair() is useless, remove it.

The better argument would've looked at history to see why the code was
the way it is and then verify those reasons are no longer valid.

Specifically, I think these are remains of child_runs_first, and that is
now gone.

Can you verify and update accordingly?

> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---
>  kernel/sched/core.c |  2 +-
>  kernel/sched/fair.c | 16 ----------------
>  2 files changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bcf2c4cc0522..b4ff595a2dc8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4897,7 +4897,7 @@ void wake_up_new_task(struct task_struct *p)
>  	update_rq_clock(rq);
>  	post_init_entity_util_avg(p);
>  
> -	activate_task(rq, p, ENQUEUE_NOCLOCK);
> +	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_INITIAL);
>  	trace_sched_wakeup_new(p);
>  	wakeup_preempt(rq, p, WF_FORK);
>  #ifdef CONFIG_SMP
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index efce2d36a783..bb5f376fd51e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12702,23 +12702,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>   */
>  static void task_fork_fair(struct task_struct *p)
>  {
> -	struct sched_entity *se = &p->se, *curr;
> -	struct cfs_rq *cfs_rq;
> -	struct rq *rq = this_rq();
> -	struct rq_flags rf;
> -
> -	rq_lock(rq, &rf);
> -
>  	set_task_max_allowed_capacity(p);
> -
> -	cfs_rq = task_cfs_rq(current);
> -	curr = cfs_rq->curr;
> -	if (curr) {
> -		update_rq_clock(rq);
> -		update_curr(cfs_rq);
> -	}
> -	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
> -	rq_unlock(rq, &rf);
>  }
>  
>  /*
> -- 
> 2.18.0.huawei.25
> 

