Return-Path: <linux-kernel+bounces-448847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0519F466C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3224F18872EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63871DC747;
	Tue, 17 Dec 2024 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SoxlDpoq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB190189521
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425213; cv=none; b=YKbca2tXKmZVGdkK8DLVZWU8q+BKLGtLUrEtqNec+vU2mVQwRNqSgJ+7CeNBvU265sbeTl+vx2QpVeqk6kfH7YBZoRLxH3joDsvD/QP8SNDvS8L438GKTn98Jy3n/sQFilC8fcN/SkI6X6WnIU7bSFMgm9RCkPwp/6cZPtkjet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425213; c=relaxed/simple;
	bh=wH+KlnPkWW5GnsOPiWJoIQdMXNXmO7S8bhnsPMXmVCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvfMF5ExOxmHswPFUxU2qmj3Tvw0AmG4dYIpGkdbYVnn7TdnmD69ZRvAWSoWX4p83wCzCK+clICtOS92EfAnv1x9aMa8ZJoEG+vOS2F+dfBpXCKDMukGFH5lTJvJknjDXfaOSfZi0cqdrvr20BJ5SE5NIliNFVYdRtrftgrcKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SoxlDpoq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q6ThPRmnd+IBqm5XEqcBm+eF4xD/75P3K23bnCaaDZ0=; b=SoxlDpoqlM7hvjSVTMy9UVCXK7
	vB2iP3rxKrElFlxM443Tm4vD7lpPI6Ho0FI84kq0MUY/wFOCkYfvU/gvIBajwjNVPdjT3XLFKEnQc
	IKSLdu3th3JBZoZfaIdW+m65tdBsgYDMlABJmdCtSzfC4/vyG+jH8wKbT1VpBcuZ7BhfaG+qWGTCQ
	3Uah26DZJc8JuiZcoPEQjXDfb1QhZ9gFQW8I+PeViHMfVbInEF6ckNOP2IUxF/rxDTqBiot+0WXEU
	FR4IQRpbjvKRykyqNZg4FmGmap7jj+82+fLSdLSt7Z9RZYZ2hVi4i0pBq9zqPOXTj/y3OdakwhDCR
	5h3QGG+Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTE3-00000005ro8-2Du9;
	Tue, 17 Dec 2024 08:46:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 170F0300192; Tue, 17 Dec 2024 09:46:43 +0100 (CET)
Date: Tue, 17 Dec 2024 09:46:43 +0100
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
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [RFC][PATCH v14 2/7] locking/mutex: Rework
 task_struct::blocked_on
Message-ID: <20241217084643.GG35539@noisy.programming.kicks-ass.net>
References: <20241125195204.2374458-1-jstultz@google.com>
 <20241125195204.2374458-3-jstultz@google.com>
 <20241213232214.GA17501@noisy.programming.kicks-ass.net>
 <CANDhNCraMepXyQPs1q-aNa+Gh745WpaFPkngA9Eohi9vXRpe+w@mail.gmail.com>
 <20241216165419.GE35539@noisy.programming.kicks-ass.net>
 <CANDhNCpTfZFOkUkB4f4iQwXA3wnsDuUA_1ZLuseGYunnpgO9Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCpTfZFOkUkB4f4iQwXA3wnsDuUA_1ZLuseGYunnpgO9Rw@mail.gmail.com>

On Mon, Dec 16, 2024 at 09:01:24PM -0800, John Stultz wrote:

> > +struct task_struct *proxy_handoff(struct mutex *lock);
> > +{
> > +       struct task_struct *next;
> > +
> > +       if (!sched_proxy_exec())
> > +               return NULL;
> > +
> > +       /*
> > +        * current->blocked_donor can't change if we can't schedule
> > +        * caller needs to do this, since its needs stabiliy of return value
> > +        */
> > +       lockdep_assert_preemption_disabled();
> > +       next = current->blocked_donor;
> > +       if (!next)
> > +               return NULL;
> > +
> > +       scoped_guard (task_rq_lock, next) {
> > +               /*
> > +                * current->blocked_donor had better be on the same CPU as current
> > +                */
> > +               WARN_ON_ONCE(scope.rq != this_rq());
> > +
> > +               scoped_guard (raw_spin_lock, next->blocked_lock) {
> > +                       /*
> > +                        * WARN_ON on this? How can this happen
> > +                        */
> > +                       if (next->blocked_on != lock)
> > +                               return NULL;
> > +               }
> > +
> > +               /*
> > +                * blocked_on relation is stable, since we hold both
> > +                * next->pi_lock and it's rq->lock
> > +                *
> > +                * OK -- we have a donor, it is blocked on the lock we're about
> > +                * to release and it cannot run on this CPU -- fixies are
> > +                * required.
> > +                *
> > +                * Dequeue the task, such that ttwu() can fix up the placement thing.
> > +                */
> > +               if (!is_cpu_allowed(next, cpu_of(scope.rq)))
> 
> nit, we'd want to check its not the wake_cpu so we try to return it so
> proxy migrations don't upset the tasks' original placement

I don't think that really matters, not doing this migration is probably
faster and then load balance will try and fix things again.

The thing is, you want this task to take over the lock and start running
ASAP, and we know *this* CPU is about to release the lock and then the
power of the block-chain is likely to make the next task run.

So less migration is more better, otherwise you then get to pull the
entire block chain over to whatever -- and you know how much 'fun' that
is.

> > +                       deactivate_task(scope.rq, next, DEQUEUE_SLEEP);
> > +       }
> > +
> > +       return next;
> > +}
> > +
> 
> Ok. I'll stare at all this a bit and see if I can give it a try.  I
> fret that this doesn't handle the case if wakeups on the task occur
> through other code paths? (So we still need BO_WAKING/NEEDS_RETURN to
> prevent us from running until we migrate back). I don't really have a
> specific case I can articulate, but my gut is telling me the problem
> will be w/ ww_mutexes as that was a major source of problems with the
> early versions of the patches that I believe tried to use logic
> similar to this.

Right, so I've not looked at ww_mutex specifically yet, but I thought to
have understood it was more or less the same problem there. If you've
got more details, please do share :-)

