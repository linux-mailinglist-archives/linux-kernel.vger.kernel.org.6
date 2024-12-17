Return-Path: <linux-kernel+bounces-448862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 713209F4684
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E543188A559
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5055F1DC745;
	Tue, 17 Dec 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HIDvKdp2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17121126C08
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425573; cv=none; b=SGlVx33XqzBmqZ+HGUhj75K7wCMa1flAdyjGt851eHeDvf2ABZZgj+b3T9FqTe9ZTxNbX/EU7Q0laR6cygcT4jaxoTl/8ym8PV1ewo2Q+iDc3958PKyB3P1XhPM4NvYlfB4qA/seCA4TtukPsNSXaN/GzRrlNSf5TS2UpeGgPMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425573; c=relaxed/simple;
	bh=A3o+UlHWraOY4K2CE/YvM5CDsQmxGDMQ1d5dkZ9NoAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1cVVGaIWUf2dzOM41e0EfJ8oQ+nZaUKwONs/YyjQiEzUqAuJll4ReA1b1R7WamfdLfzpKHR5TIqnuiRwggSHW6ISF9W1kfOT6dX89iCxnase8Z4/T2TD1pi+XHwtJOGW39bu9HCpvDzEiRUwE2sw0W1jLa8282PAUfPlJKWDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HIDvKdp2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=aypXfkBlQH9z+E33uDRENlhfda0ApLGXn+W6C302NpQ=; b=HIDvKdp28duzDC6tJNS5L/B1vK
	D3rkd9DwMwwXtZ9LUMLrL7xB5ewwaR/+tePbEl5m88MiqMSiG7xMp5IA2wfgVe2oluGVhsc3sFUlB
	EaM27VPcZuKifTN3k8S5GklgZomiMYKNr0oceC9tz69O9015rIHjAnDIBhPjesQW4ePmgc9L1ijP0
	8yBStgh6/LOEFYiNUmu+r+J1oKRUTtzTDN0ytUEOo0pITQ623iod30kE+8qs2bjxiZ4LlaTtFRZcv
	n4a8L7IebHL69zHTsgKiAAv0JqxxDC1uHNjCE38adey88HH68VziX3QMG/+roiGzUWsrpBwd7ALU3
	3g1dJ2uA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTJs-00000005tKO-1oxR;
	Tue, 17 Dec 2024 08:52:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F1181300192; Tue, 17 Dec 2024 09:52:43 +0100 (CET)
Date: Tue, 17 Dec 2024 09:52:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Subject: Re: [RFC][PATCH v14 5/7] sched: Add an initial sketch of the
 find_proxy_task() function
Message-ID: <20241217085243.GI35539@noisy.programming.kicks-ass.net>
References: <20241125195204.2374458-1-jstultz@google.com>
 <20241125195204.2374458-6-jstultz@google.com>
 <20241214000559.GC17501@noisy.programming.kicks-ass.net>
 <CANDhNCpYgQ6KspsykWhewNAm1N1mPSh=hthx2OnisX3c+7M0ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCpYgQ6KspsykWhewNAm1N1mPSh=hthx2OnisX3c+7M0ng@mail.gmail.com>

On Mon, Dec 16, 2024 at 09:42:31PM -0800, John Stultz wrote:
> On Fri, Dec 13, 2024 at 4:06 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Nov 25, 2024 at 11:51:59AM -0800, John Stultz wrote:
> >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index f8714050b6d0d..b492506d33415 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -5052,6 +5052,34 @@ static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
> > >       }
> > >  }
> > >
> > > +/*
> > > + * Only called from __schedule context
> > > + *
> > > + * There are some cases where we are going to re-do the action
> > > + * that added the balance callbacks. We may not be in a state
> > > + * where we can run them, so just zap them so they can be
> > > + * properly re-added on the next time around. This is similar
> > > + * handling to running the callbacks, except we just don't call
> > > + * them.
> > > + */
> >
> > Which specific callbacks are this? sched_core_balance()?
> >
> > In general, shooting down all callbacks like this makes me feel somewhat
> > uncomfortable.
> 
> So, if we originally picked a RT task, I believe it would setup the
> push_rt_tasks callback, but if it got migrated and if we needed to
> pick again,  we'd end up tripping on
> `SCHED_WARN_ON(rq->balance_callback && rq->balance_callback !=
> &balance_push_callback);`
> 
> For a while I tried to unpin and run the balance callbacks before
> calling pick_again, if find_proxy_task() failed, but that was running
> into troubles with tasks getting unintentionally added to the rt
> pushable list (this was back in ~feb, so my memory is a little fuzzy).
> 
> So that's when I figured zaping the callbacks would be best, with the
> idea being that we are starting selection over, so we effectively have
> to undo any of the state that was set by pick_next_task() before
> calling it again.
> 
> Let me know if you have concerns with this, or suggestions for other approaches.

For now, lets stick a coherent comment on, explaining exactly which
callbacks and why.

> > > +/*
> > > + * Initial simple proxy that just returns the task if it's waking
> > > + * or deactivates the blocked task so we can pick something that
> > > + * isn't blocked.
> > > + */
> > > +static struct task_struct *
> > > +find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
> > > +{
> > > +     struct task_struct *p = donor;
> > > +     struct mutex *mutex;
> > > +
> > > +     mutex = p->blocked_on;
> > > +     /* Something changed in the chain, so pick again */
> > > +     if (!mutex)
> > > +             return NULL;
> > > +     /*
> > > +      * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
> > > +      * and ensure @owner sticks around.
> > > +      */
> > > +     raw_spin_lock(&mutex->wait_lock);
> > > +     raw_spin_lock(&p->blocked_lock);
> >
> > I'm still wondering what this blocked_lock does, that previous patch had
> > it mirror wait_mutex too, so far I don't see the point.
> 
> Yeah, early on in the series it's maybe not as useful, but as we start
> dealing with sleeping owner enqueuing, its doing more:
>   https://github.com/johnstultz-work/linux-dev/commit/d594ca8df88645aa3b2b9daa105664893818bdb7
> 
> But it is possible it is more of a crutch for me to keep straight the
> locking rules as it's simpler to keep in my head. :)
> Happy to think a bit more on if it can be folded together with another lock.

I'm a big believer in only introducing state when we actually need it --
and I don't believe we actually need blocked_lock until we go SMP.

Anyway, I have since figured out the why of blocked_lock again; but
yeah, comments, because I'm sure to forget it again at some point.

