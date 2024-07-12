Return-Path: <linux-kernel+bounces-250791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF6292FCDE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8473B1F23E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A2D172BA9;
	Fri, 12 Jul 2024 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CUm0DJ1m"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814016EB6A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795746; cv=none; b=WGuHbarq7kVZQ22g4dWm8y7tVcC+Zknp1D026JGtxeLmxcjxL0ya9FYo1ABchZXpe0gq4K3hyBa48oLMlMO09lhX7VgMxNY78OPUU94f95Xrp7cXz61qsCW7G8Bn3ZQPtPym4fO5Q6SO5tiyEjve9mbejSTk30NW1FgExlvDcRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795746; c=relaxed/simple;
	bh=qo2PVBNskdbpu7T2iu5GWycR3ioybh0+XsbMqjHLbN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnQ5ZLJ0EH5k0oBQZvWjX9KSTWt/iFPGNLaC+x9lJJGwDxt0fsfKBMC3kD+89Q2gqd2XBiPl8zc0sDK2htok++xLNkFUPEofWPJW8yoLTIlTTtY/gFe8xGIzSTs/50Y81ytmCWcLdYKmkbOj26K2OYUue8NRdp9nWdHigc58EQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CUm0DJ1m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MLpJD7+tGG5lHcgvhdf9uMynCgLUBi4fn3T23x57pW8=; b=CUm0DJ1mFwQa+diXsUifFnV1nw
	h7N/Ian/wOuzyU9L/QLsVsWSPfwEizJ8xjTMDvHFdJW4AlYiVnRs9kZGS/Y1pl8YBrCZJBulDdMlw
	hXpza+CzMAHUZjRH3uQo5K5hYzsJT002/MAUL8/oS/5+6KtZt6JHxEwOFRDF/09m7LPdm5GoieH0U
	lKcJdNNB2e83a36ZJzBo+p6eWfb2LRGkDvE0DoUI3ooSeIHk/G2pK29wkW3B/zRi+eBA4MjxUxkRG
	FZmYLaE4vNwilFAvnp7KsYziv7jnoDNsFpYGcnrwnguRHeqXFjGQHOzst+vCLxEcc/K7z20FDhkrs
	WO5uYu6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSHZs-0000000CZ0l-0vyZ;
	Fri, 12 Jul 2024 14:48:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9380830050D; Fri, 12 Jul 2024 16:48:51 +0200 (CEST)
Date: Fri, 12 Jul 2024 16:48:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v11 1/7] locking/mutex: Remove wakeups from under
 mutex::wait_lock
Message-ID: <20240712144851.GK27299@noisy.programming.kicks-ass.net>
References: <20240709203213.799070-1-jstultz@google.com>
 <20240709203213.799070-2-jstultz@google.com>
 <d293d88c-b83b-a955-de5e-db775f20c1e1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d293d88c-b83b-a955-de5e-db775f20c1e1@amd.com>

On Wed, Jul 10, 2024 at 11:11:51PM +0530, K Prateek Nayak wrote:

> > @@ -681,6 +682,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> >   		}
> >   		raw_spin_unlock(&lock->wait_lock);
> > +		/* Make sure we do wakeups before calling schedule */
> > +		if (!wake_q_empty(&wake_q)) {
> 
> nit.
> 
> This checks seems unnecessary (to my untrained eye). Any harm in
> skipping it and simply doing a wake_up_q() followed by wake_q_init()
> unconditionally?

Yeah, that doesn't really save anything.

> > +			wake_up_q(&wake_q);
> > +			wake_q_init(&wake_q);
> > +		}
> >   		schedule_preempt_disabled();
> >   		first = __mutex_waiter_is_first(lock, &waiter);

> > @@ -1207,6 +1209,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
> >   	struct rt_mutex_waiter *top_waiter = waiter;
> >   	struct rt_mutex_base *next_lock;
> >   	int chain_walk = 0, res;
> > +	DEFINE_WAKE_Q(wake_q);
> >   	lockdep_assert_held(&lock->wait_lock);
> > @@ -1245,7 +1248,10 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
> >   		/* Check whether the waiter should back out immediately */
> >   		rtm = container_of(lock, struct rt_mutex, rtmutex);
> > -		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx);
> > +		preempt_disable();
> > +		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx, &wake_q);
> > +		wake_up_q(&wake_q);
> > +		preempt_enable();
> 
> I'm trying to understand this - we enter task_blocks_on_rt_mutex() with
> "wait_lock" held (I believe the lockdep_assert_held() in the previous
> hunk checks for the same). I walked down the call chain (although
> briefly) and could only spot "task->pi_lock" being locked and unlocked
> before this call to "wake_up_q()" but the "wait_lock" seems to be held
> throughout, only being unlocked and locked again for
> "rt_mutex_adjust_prio_chain()" later down.
> 
> Did I miss something or is disabling preemption for this specific hunk
> enough to enable safe nesting?

So the whole ww-mutex stuff got significantly reworked since this patch
was started, but I think you're right, this wake_up_q() needs to be
outside wait_lock, while currently it sits inside.

One thing that helps though, is that I think that when
__ww_mutex_add_waiter() return !0, the wake_q should be empty here.

