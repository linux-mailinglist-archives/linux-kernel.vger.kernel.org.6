Return-Path: <linux-kernel+bounces-357887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED6E99775E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327FDB215FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A7A2119;
	Wed,  9 Oct 2024 21:19:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AE619C563
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508760; cv=none; b=GjUD3FoeIqbXQ3mEHEFIchbPxMWtkh9fpCwMm6qaWZTNsPHTpwadfVtXHjWuGMJCM58ddpyy4Cb8RZqgcneqDe8InPwWo5yY/z14I8s9j6K+uj519Vpv9p+vFgMSYO7pGvEHKS0C9Z35wEFM33KZ0IqwLDCAWk85TrbWJBFbmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508760; c=relaxed/simple;
	bh=il0jwC+o7ON6KsudDg+iThkTAoZHy6yfGFoRj0x/HRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+ReMhtXd/iSNKGDOzb0wBErLbDe+LoFx/vNgKMeezDqbRitzQJKJPMkPMbV2GP6OLV8SyqTJc/dCYJA+gqNx+SlWlTvz0Do4gTldqB2xIXFAKj9oNIFn/nougFaPy1OkaYEXfe2YvXDSEqCFAi1dhyMolWgDCnoWSHz9kroXCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD15DC4CEC3;
	Wed,  9 Oct 2024 21:19:17 +0000 (UTC)
Date: Wed, 9 Oct 2024 17:19:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 mingo@kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
Message-ID: <20241009171923.78813d22@gandalf.local.home>
In-Reply-To: <87ed4pq953.ffs@tglx>
References: <20241007074609.447006177@infradead.org>
	<20241008153232.YwZfzF0r@linutronix.de>
	<87wmihdh3u.fsf@oracle.com>
	<20241009062019.1FJYnQL1@linutronix.de>
	<20241009080202.GJ17263@noisy.programming.kicks-ass.net>
	<20241009100133.2569e2a7@gandalf.local.home>
	<87h69lqbk0.ffs@tglx>
	<20241009164355.1ca1d3d3@gandalf.local.home>
	<87ed4pq953.ffs@tglx>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Oct 2024 23:06:00 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> > Perhaps these cond_resched() is proper? That is, the need_resched() /
> > cond_resched() is not something that is being done for PREEMPT_NONE, but
> > for preempt/voluntary kernels too. Maybe these cond_resched() should stay?
> > If we spin in the loop for one more tick, that is actually changing the
> > behavior of PREEMPT_NONE and PREEMPT_VOLUNTARY, as the need_resched()/cond_resched()
> > helps with latency. If we just wait for the next tick, these loops (and
> > there's a lot of them) will all now run for one tick longer than if
> > PREEMPT_NONE or PREEMPT_VOLUNTARY were set today.  
> 
> You are looking at it from the wrong perspective. You are trying to
> preserve the status quo. I know that's the path of least effort but it's
> the fundamentally wrong approach.
> 
>     spin_lock(L);
>     while ($cond) {
>           do_stuff();
>           if (need_resched()) {
>           	spin_unlock(L);
>                 resched();
>                 spin_lock(L);
>           }
>     }
>     spin_unlock(L);
> 
> is the bogus pattern which was introduced to deal with the NONE
> shortcomings. That's what we want to get rid of and not proliferate.

So this is actually a different issue that you are trying to address. But I
don't see how it had to deal with NONE, as even PREEMPT would suffer from
that loop, right? As the you can't preempt while holding the spinlock.

> 
> For the transition phase we obviously need to do:
> 
>     while ($cond) {
>           spin_lock(L);
>           do_stuff();
>           spin_unlock(L);
>           cond_resched();
>     }

But if $cond needs to be protected by spin_lock(), what then?

	spin_lock();
	while ($cond) {
		do_stuff();
		spin_unlock();
		spin_lock();
	}
	spin_unlock();

?

> 
> And once all the problems with LAZY are sorted then this cond_resched()
> line just goes away and the loop looks like this:
> 
>     while ($cond) {
>           spin_lock(L);
>           do_stuff();
>           spin_unlock(L);
>     }
> 
> There is absolutely no argument that the spinlock held section needs to
> spawn the loop. We fixed up several of these constructs over the years
> and none of them caused a performance regression. Quite the contrary
> quite some of them improved performance because dropping the lock lets
> other CPUs interleave.
> 
> Seriously, this crap preserving mindset has to stop. If we go new ways
> then we go them all the way.

It's not about "crap preserving" but more of taking smaller steps. Then we
can see where a regression happened if one does come up. Kind of like how
you did the x86 64bit/32bit merge. Do steps that keep things as close to
what they were at the start and slowly move toward your goals.

-- Steve

