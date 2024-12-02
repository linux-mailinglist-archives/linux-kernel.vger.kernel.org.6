Return-Path: <linux-kernel+bounces-427992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9CC9E08C4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C881658A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E65919259E;
	Mon,  2 Dec 2024 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STxcBL4j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897517ADF8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156683; cv=none; b=rajo5uFGRuh/K1wNVvVTGk02e9CnAMUyGWDjeOWaqY0QGuMiQYy9E/gwwlL3PIO46RNdx7HwH4JuuXswcjbQJ091t+I4b8d6VzyZiP/Hp5w+96ghMV0yCl6gGN8wmF2IF/zS7GnpnP505iFxK824s2/AZJdDHLCOxQ/6uu3RehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156683; c=relaxed/simple;
	bh=QJqiyuoZrTkeZuGFvGYTmcrIOXKIPZtStoE69Z2/Nd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgQr89j6N6ZDk4jUVbIbuoKUJyuA4KX9EJl+Ul4iCihS4TdbOZHwFT8Rt1R86ODoPkZSaKuHlsz6o+V1ahxEfeSmFhE+tTciEFP6naOlCI8+b6vy9JvbQrD2S4qecMw7fvAsnLfVPy+gUcyCzqvKNEMuR/lxJW7UaaOozXCEgbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STxcBL4j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733156680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfwKuBWLWYGTkMtLKeinQf3I7MG5+yZMN5/aeW2SzIA=;
	b=STxcBL4jeMPVPw7+kw5EVxWTOex6PrHc7XznXcCmtUjVaKK2Svcb3hz2ayvHGmOqOzTJEU
	aYWhTIF2ZoAgpm3/etah+HnCVqNkENQmz7T02L0t5YhgSgAacoFNo0IOPcs6M71CP/S44N
	fUbkIEO0iGaNymQZ1yrF3N+ISrhh30U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-1ndjU8QTMp6E8Hea03GkcA-1; Mon,
 02 Dec 2024 11:24:36 -0500
X-MC-Unique: 1ndjU8QTMp6E8Hea03GkcA-1
X-Mimecast-MFC-AGG-ID: 1ndjU8QTMp6E8Hea03GkcA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F025D1944D20;
	Mon,  2 Dec 2024 16:24:33 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.82.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1A6C1956052;
	Mon,  2 Dec 2024 16:24:29 +0000 (UTC)
Date: Mon, 2 Dec 2024 11:24:27 -0500
From: Phil Auld <pauld@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH V2] sched/fair: Dequeue sched_delayed tasks when waking
 to a busy CPU
Message-ID: <20241202162427.GB1226982@pauld.westford.csb>
References: <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
 <20241112154140.GC336451@pauld.westford.csb>
 <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
 <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
 <20241114112854.GA471026@pauld.westford.csb>
 <20241119113016.GB66918@pauld.westford.csb>
 <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
 <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
 <20241121115628.GB394828@pauld.westford.csb>
 <bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Nov 23, 2024 at 09:44:40AM +0100 Mike Galbraith wrote:
> On Thu, 2024-11-21 at 06:56 -0500, Phil Auld wrote:
> > On Wed, Nov 20, 2024 at 07:37:39PM +0100 Mike Galbraith wrote:
> > > On Tue, 2024-11-19 at 12:51 +0100, Mike Galbraith wrote:
> > > > On Tue, 2024-11-19 at 06:30 -0500, Phil Auld wrote:
> > > > >
> > > > > This, below, by itself, did not do help and caused a small slowdown on some
> > > > > other tests.  Did this need to be on top of the wakeup change?
> > > >
> > > > No, that made a mess.
> > >
> > > Rashly speculating that turning mobile kthread component loose is what
> > > helped your write regression...
> > >
> > > You could try adding (p->flags & PF_KTHREAD) to the wakeup patch to
> > > only turn hard working kthreads loose to try to dodge service latency.
> > > Seems unlikely wakeup frequency * instances would combine to shred fio
> > > the way turning tbench loose did.
> > >
> >
> > Thanks, I'll try that.
> 
> You may still want to try that, but my box says probably not.  Playing
> with your write command line, the players I see are pinned kworkers and
> mobile fio instances.
>

Yep. The PF_KTHREAD thing did not help. 


> Maybe try the below instead. The changelog is obsolete BS unless you
> say otherwise, but while twiddled V2 will still migrate tbench a bit,
> and per trace_printk() does still let all kinds of stuff wander off to
> roll the SIS dice, it does not even scratch the paint of the formerly
> obliterated tbench progression.
>

Will give this one a try when I get caught up from being off all week for
US turkey day. 


Thanks!

> Question: did wiping off the evil leave any meaningful goodness behind?


Is that for this patch?  

If you mean for the original patch (which subsequently broke the reads) then
no. It was more or less even for all the other tests. It fixed the randwrite
issue by moving it to randread. Everything else we run regularly was about
the same. So no extra goodness to help decide :)


Cheers,
Phil

> 
> ---
> 
> sched/fair: Dequeue sched_delayed tasks when waking to a busy CPU
> 
> Phil Auld (Redhat) reported an fio benchmark regression having been found
> to have been caused by addition of the DELAY_DEQUEUE feature, suggested it
> may be related to wakees losing the ability to migrate, and confirmed that
> restoration of same indeed did restore previous performance.
> 
> V2: do not rip buddies apart, convenient on/off switch
> 
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  kernel/sched/core.c     |   51 ++++++++++++++++++++++++++++++------------------
>  kernel/sched/features.h |    5 ++++
>  kernel/sched/sched.h    |    5 ++++
>  3 files changed, 42 insertions(+), 19 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3783,28 +3783,41 @@ ttwu_do_activate(struct rq *rq, struct t
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
> +		int dequeue = sched_feat(DEQUEUE_DELAYED);
> +
> +		/*
> +		 * Since sched_delayed means we cannot be current anywhere,
> +		 * dequeue it here and have it fall through to the
> +		 * select_task_rq() case further along in ttwu() path.
> +		 * Note: Do not rip buddies apart else chaos follows.
> +		 */
> +		if (dequeue && rq->nr_running > 1 && p->nr_cpus_allowed > 1 &&
> +		    !(rq->curr->last_wakee == p || p->last_wakee == rq->curr)) {
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
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -47,6 +47,11 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
>   * DELAY_ZERO clips the lag on dequeue (or wakeup) to 0.
>   */
>  SCHED_FEAT(DELAY_DEQUEUE, true)
> +/*
> + * Free ONLY non-buddy delayed tasks to wakeup-migrate to avoid taking.
> + * an unnecessary latency hit.  Rending buddies asunder inflicts harm.
> + */
> +SCHED_FEAT(DEQUEUE_DELAYED, true)
>  SCHED_FEAT(DELAY_ZERO, true)
> 
>  /*
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1783,6 +1783,11 @@ task_rq_unlock(struct rq *rq, struct tas
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

-- 


