Return-Path: <linux-kernel+bounces-401702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2169C1E31
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690B3282472
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8701E9062;
	Fri,  8 Nov 2024 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnSsKby+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016A192B95
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072907; cv=none; b=WhohPzy51Dnt3L4AHUXUa6dgw3qDODADFYbMryzGfIOD9dfMl6wgkBVdULoqYaF8iaCwH3w+s6jTm1sKCjlBEqxig7Cp1EUPDGTCroury0LxPYHhB08pAPfUjROidZ6u5LyTwhKjWJBLWBMllxPyatijaaBIwJ1kYawNaAl4a/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072907; c=relaxed/simple;
	bh=ZK+z9DLrRMas3ZQh3uu1RjkcHvtZop9OcrS1v+9Kk0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwFVUsXebfiMIL8lj216LT69OsPpWTt2GoLCJHK2oM5nGR/QRUCAR4cLfRRoUufccDRDoAi+RvA9PQCXI0N5ouStUzxQt1axRyzs4Ol6RqgIE61KxDKzqM0Pi5snxJgHOrYRrukrZeAGcFv/VRyl+VMuVMwURYr+BzVAqLnwgjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnSsKby+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731072904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AFDIVN5ex8oiwd7Th7YhPHVLybe0v8YtPNpfLK2FaQ=;
	b=AnSsKby+Woodn+MBPXRgeo52t2fVobNPLbmJC7pumkzxHmrDTmitU/wKANSVb+c8gHu8Tx
	CwBdQQpE9j8ryXcSP84hG65z0up0xhuVfl3dcqyfuveOUu+1Utzcn+JUErz+4vstTweyhO
	UAI6dhLIQJAnlk3YUhmDciwKQ9UXxdw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-FBxgimIhNKe4PBRtikW56A-1; Fri,
 08 Nov 2024 08:35:00 -0500
X-MC-Unique: FBxgimIhNKe4PBRtikW56A-1
X-Mimecast-MFC-AGG-ID: FBxgimIhNKe4PBRtikW56A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB3091955F57;
	Fri,  8 Nov 2024 13:34:58 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.129])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7EF51956054;
	Fri,  8 Nov 2024 13:34:54 +0000 (UTC)
Date: Fri, 8 Nov 2024 08:34:52 -0500
From: Phil Auld <pauld@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: Dequeue sched_delayed tasks when waking to a
 busy CPU
Message-ID: <20241108133452.GA43508@pauld.westford.csb>
References: <20241104130515.GB749675@pauld.westford.csb>
 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
 <20241106135346.GL24862@noisy.programming.kicks-ass.net>
 <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
 <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
 <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
 <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
 <20241107140945.GA34695@noisy.programming.kicks-ass.net>
 <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Nov 08, 2024 at 01:24:35AM +0100 Mike Galbraith wrote:
> On Thu, 2024-11-07 at 15:09 +0100, Peter Zijlstra wrote:
> > On Thu, Nov 07, 2024 at 03:02:36PM +0100, Mike Galbraith wrote:
> > > On Thu, 2024-11-07 at 10:46 +0100, Mike Galbraith wrote:
> > > > On Thu, 2024-11-07 at 05:03 +0100, Mike Galbraith wrote:
> > > > >
> > > > > I built that patch out of curiosity, and yeah, set_next_task_fair()
> > > > > finding a cfs_rq->curr ends play time pretty quickly.
> > > >
> > > > The below improved uptime, and trace_printk() says it's doing the
> > > > intended, so I suppose I'll add a feature and see what falls out.
> > >
> > > From netperf, I got.. number tabulation practice.  Three runs of each
> > > test with and without produced nothing but variance/noise.
> >
> > Make it go away then.
> >
> > If you could write a Changelog for you inspired bit and stick my cleaned
> > up version under it, I'd be much obliged.
> 
> Salut, much obliged for eyeball relief.
>

Thanks Mike (and Peter).  We have our full perf tests running on Mike's
original verion of this patch. Results probably Monday (there's a long
queue). We'll see if this blows up anything else then.  I'll queue up a
build with this cleaned up version as well but the results will be late
next week, probably.

At that point maybe some or all of these:

Suggested-by: Phil Auld <pauld@redhat.com> 
Reviewed-by: Phil Auld <pauld@redhat.com>
Tested-by: Jirka Hladky <jhladky@redhat.com>


Cheers,
Phil


> ---snip---
> 
> Phil Auld (Redhat) reported an fio benchmark regression having been found
> to have been caused by addition of the DELAY_DEQUEUE feature, suggested it
> may be related to wakees losing the ability to migrate, and confirmed that
> restoration of same indeed did restore previous performance.
> 
> (de-uglified-a-lot-by)
> 
> Reported-by: Phil Auld <pauld@redhat.com>
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Link: https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford.csb/
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  kernel/sched/core.c  |   48 +++++++++++++++++++++++++++++-------------------
>  kernel/sched/sched.h |    5 +++++
>  2 files changed, 34 insertions(+), 19 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3783,28 +3783,38 @@ ttwu_do_activate(struct rq *rq, struct t
>   */
>  static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  {
> -	struct rq_flags rf;
> -	struct rq *rq;
> -	int ret = 0;
> -
> -	rq = __task_rq_lock(p, &rf);
> -	if (task_on_rq_queued(p)) {
> -		update_rq_clock(rq);
> -		if (p->se.sched_delayed)
> -			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
> -		if (!task_on_cpu(rq, p)) {
> -			/*
> -			 * When on_rq && !on_cpu the task is preempted, see if
> -			 * it should preempt the task that is current now.
> -			 */
> -			wakeup_preempt(rq, p, wake_flags);
> +	CLASS(__task_rq_lock, rq_guard)(p);
> +	struct rq *rq = rq_guard.rq;
> +
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
> -		ttwu_do_wakeup(p);
> -		ret = 1;
> +
> +		enqueue_task(rq, p, queue_flags);
> +	}
> +	if (!task_on_cpu(rq, p)) {
> +		/*
> +		 * When on_rq && !on_cpu the task is preempted, see if
> +		 * it should preempt the task that is current now.
> +		 */
> +		wakeup_preempt(rq, p, wake_flags);
>  	}
> -	__task_rq_unlock(rq, &rf);
> +	ttwu_do_wakeup(p);
> 
> -	return ret;
> +	return 1;
>  }
> 
>  #ifdef CONFIG_SMP
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1779,6 +1779,11 @@ task_rq_unlock(struct rq *rq, struct tas
>  	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
>  }
> 
> +DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
> +		    _T->rq = __task_rq_lock(_T->lock, &_T->rf),
> +		    __task_rq_unlock(_T->rq, &_T->rf),
> +		    struct rq *rq; struct rq_flags rf)
> +
>  DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
>  		    _T->rq = task_rq_lock(_T->lock, &_T->rf),
>  		    task_rq_unlock(_T->rq, _T->lock, &_T->rf),
> 
> 

-- 


