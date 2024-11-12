Return-Path: <linux-kernel+bounces-405844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBF49C5807
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BADE281D77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7BD1F77AE;
	Tue, 12 Nov 2024 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZ9tKnGE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAAE1F779E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415294; cv=none; b=ZfLrButhMhz0vH+xWb7/5kXhEBEbz5q5G8aErOnWS2Ti2D6ru1a2b1nM2WrT+s/PkfRynEqFloEkxrIcKIb6GaN4KW0Uh8q0JjL6yCnFfl3t2Fe0wFRuUnGn+s89WdqwzkcdCcQnjCvMsYjyTNwei4uPrPAzUVrBo83vhgyDTxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415294; c=relaxed/simple;
	bh=Bs1byzgH5hh7+R8J4kFIiZBpuVkOnAvf4P2jvHt8PCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1XAKvB1OtV+YLTvl6sW2EOPTMpqRLNFqqSFscOUp4ZXkAV47U+Qfp7QoLIXgtnV5nFqYcMBgtmNWUA6g+ER9MHImzzfuoekP1JpcqmX2SSz5pIlnLmSnJoNWmQwbyLtZwHWE4HiVdD//6oYDrUJcQLPiSwAn5zLjnlcw6cEpKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZ9tKnGE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731415291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wcYhvchpj++GWPtIMb6T8g2NQojM6fwpi715hYIVjM=;
	b=IZ9tKnGEz6nih9Wr6OUgfLLjd6bz4d7nSLf1A/JsyU1dqwtViVokpTqwV8mO73EO9fPFjb
	+5rKgMeAEaSxDiff9jiOfSSVbgEHOn2c2grNqbA1sxwK2aKK6+yXKeJBXfaCOzfQ5wBva+
	sE/+Q+WWLM57f1UEI0mWuXsdMJQkjv8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-Fh6wjDiwP8anUIph856OFQ-1; Tue,
 12 Nov 2024 07:41:27 -0500
X-MC-Unique: Fh6wjDiwP8anUIph856OFQ-1
X-Mimecast-MFC-AGG-ID: Fh6wjDiwP8anUIph856OFQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB91F1956080;
	Tue, 12 Nov 2024 12:41:24 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.108])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABC5030000DF;
	Tue, 12 Nov 2024 12:41:20 +0000 (UTC)
Date: Tue, 12 Nov 2024 07:41:17 -0500
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
Message-ID: <20241112124117.GA336451@pauld.westford.csb>
References: <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
 <20241106135346.GL24862@noisy.programming.kicks-ass.net>
 <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
 <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
 <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
 <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
 <20241107140945.GA34695@noisy.programming.kicks-ass.net>
 <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
 <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Nov 12, 2024 at 08:05:04AM +0100 Mike Galbraith wrote:
> On Fri, 2024-11-08 at 01:24 +0100, Mike Galbraith wrote:
> > On Thu, 2024-11-07 at 15:09 +0100, Peter Zijlstra wrote:
> > > On Thu, Nov 07, 2024 at 03:02:36PM +0100, Mike Galbraith wrote:
> > > > On Thu, 2024-11-07 at 10:46 +0100, Mike Galbraith wrote:
> > > > > On Thu, 2024-11-07 at 05:03 +0100, Mike Galbraith wrote:
> > > > > > 
> > > > > > I built that patch out of curiosity, and yeah, set_next_task_fair()
> > > > > > finding a cfs_rq->curr ends play time pretty quickly.
> > > > > 
> > > > > The below improved uptime, and trace_printk() says it's doing the
> > > > > intended, so I suppose I'll add a feature and see what falls out.
> > > > 
> > > > From netperf, I got.. number tabulation practice.  Three runs of each
> > > > test with and without produced nothing but variance/noise.
> > > 
> > > Make it go away then.
> > > 
> > > If you could write a Changelog for you inspired bit and stick my cleaned
> > > up version under it, I'd be much obliged.
> > 
> > Salut, much obliged for eyeball relief.
> 
> Unfortunate change log place holder below aside, I think this patch may
> need to be yanked as trading one not readily repeatable regression for
> at least one that definitely is, and likely multiple others.
> 
> (adds knob)
>

Yes, I ws just coming here to reply. I have the results from the first
version of the patch (I don't think the later one fundemtally changed
enough that it will matter but those results are still pending).

Not entirely surprisingly we've traded a ~10% rand write regression for
5-10% rand read regression. This makes sense to me since the reads are
more likely to be synchronous and thus be more buddy-like and benefit
from flipping back and forth on the same cpu.  

I'd probably have to take the reads over the writes in such a trade off :)

> tbench 8
> 
> NO_MIGRATE_DELAYED    3613.49 MB/sec
> MIGRATE_DELAYED       3145.59 MB/sec
> NO_DELAY_DEQUEUE      3355.42 MB/sec
> 
> First line is DELAY_DEQUEUE restoring pre-EEVDF tbench throughput as
> I've mentioned it doing, but $subject promptly did away with that and
> then some.
>

Yep, that's not pretty. 

> I thought I might be able to do away with the reservation like side
> effect of DELAY_DEQUEUE by borrowing h_nr_delayed from...
> 
>      sched/eevdf: More PELT vs DELAYED_DEQUEUE
> 
> ...for cgroups free test config, but Q/D poke at idle_cpu() helped not
> at all.
>

I wonder if the last_wakee stuff could be leveraged here (an idle thought,
so to speak). Haven't looked closely enough. 


Cheers,
Phil

> > ---snip---
> > 
> > Phil Auld (Redhat) reported an fio benchmark regression having been found
> > to have been caused by addition of the DELAY_DEQUEUE feature, suggested it
> > may be related to wakees losing the ability to migrate, and confirmed that
> > restoration of same indeed did restore previous performance.
> > 
> > (de-uglified-a-lot-by)
> > 
> > Reported-by: Phil Auld <pauld@redhat.com>
> > Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> > Link: https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford.csb/
> > Signed-off-by: Mike Galbraith <efault@gmx.de>
> > ---
> >  kernel/sched/core.c  |   48 +++++++++++++++++++++++++++++-------------------
> >  kernel/sched/sched.h |    5 +++++
> >  2 files changed, 34 insertions(+), 19 deletions(-)
> > 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3783,28 +3783,38 @@ ttwu_do_activate(struct rq *rq, struct t
> >   */
> >  static int ttwu_runnable(struct task_struct *p, int wake_flags)
> >  {
> > -       struct rq_flags rf;
> > -       struct rq *rq;
> > -       int ret = 0;
> > -
> > -       rq = __task_rq_lock(p, &rf);
> > -       if (task_on_rq_queued(p)) {
> > -               update_rq_clock(rq);
> > -               if (p->se.sched_delayed)
> > -                       enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
> > -               if (!task_on_cpu(rq, p)) {
> > -                       /*
> > -                        * When on_rq && !on_cpu the task is preempted, see if
> > -                        * it should preempt the task that is current now.
> > -                        */
> > -                       wakeup_preempt(rq, p, wake_flags);
> > +       CLASS(__task_rq_lock, rq_guard)(p);
> > +       struct rq *rq = rq_guard.rq;
> > +
> > +       if (!task_on_rq_queued(p))
> > +               return 0;
> > +
> > +       update_rq_clock(rq);
> > +       if (p->se.sched_delayed) {
> > +               int queue_flags = ENQUEUE_DELAYED | ENQUEUE_NOCLOCK;
> > +
> > +               /*
> > +                * Since sched_delayed means we cannot be current anywhere,
> > +                * dequeue it here and have it fall through to the
> > +                * select_task_rq() case further along the ttwu() path.
> > +                */
> > +               if (rq->nr_running > 1 && p->nr_cpus_allowed > 1) {
> > +                       dequeue_task(rq, p, DEQUEUE_SLEEP | queue_flags);
> > +                       return 0;
> >                 }
> > -               ttwu_do_wakeup(p);
> > -               ret = 1;
> > +
> > +               enqueue_task(rq, p, queue_flags);
> > +       }
> > +       if (!task_on_cpu(rq, p)) {
> > +               /*
> > +                * When on_rq && !on_cpu the task is preempted, see if
> > +                * it should preempt the task that is current now.
> > +                */
> > +               wakeup_preempt(rq, p, wake_flags);
> >         }
> > -       __task_rq_unlock(rq, &rf);
> > +       ttwu_do_wakeup(p);
> >  
> > -       return ret;
> > +       return 1;
> >  }
> >  
> >  #ifdef CONFIG_SMP
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1779,6 +1779,11 @@ task_rq_unlock(struct rq *rq, struct tas
> >         raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
> >  }
> >  
> > +DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
> > +                   _T->rq = __task_rq_lock(_T->lock, &_T->rf),
> > +                   __task_rq_unlock(_T->rq, &_T->rf),
> > +                   struct rq *rq; struct rq_flags rf)
> > +
> >  DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
> >                     _T->rq = task_rq_lock(_T->lock, &_T->rf),
> >                     task_rq_unlock(_T->rq, _T->lock, &_T->rf),
> > 
> > 
> 

-- 


