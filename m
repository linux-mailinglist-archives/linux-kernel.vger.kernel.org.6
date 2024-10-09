Return-Path: <linux-kernel+bounces-357874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E391699773B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709E5B21461
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72AA1A4E92;
	Wed,  9 Oct 2024 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f5w6oddU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wcmI951r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C427613A409
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507970; cv=none; b=tdufqf+UiYdG7RlaeT8q8sS29mVQmCEHEAiLwKp4YO9DEdfxyWuEtaS8XZkczZ2GBUJZEzlXfsT0pNC818FhC6EB2HvIC+BGtFU5w6bx4RfLZqL/LEVQV8kqH+b1bRoWfz3k71MQynNTX5t5gYf7V6fIQNXAf5aXu5FvUkcRyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507970; c=relaxed/simple;
	bh=+icK/yZ+lx2XO3GvoozPUd1m6e6MzzJfKwNgaabPYjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PPAQpJ/jsyGoHBQo6DIckxz/3BhMVzRnHSzfsXJGLaeTzvqifBOxRYOxvIMnkkCxRyix/xIMYpzAOH7XmRp8Agk2FKwPYPshzmFIkm8mVFh8lZryrDpCERMR/oJXilkMrrXLouS0RwhRrqL0XMuLg7tdFgNgWDRhZjAFu9ylTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f5w6oddU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wcmI951r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728507961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PLrNPMEax/1XIv2gXbIgjHBnuZM6tq+rjJmA8NEhnew=;
	b=f5w6oddUuCV1gSW8WwAg58xy92fFtXPD26TYG83nP/x4rfo7yj7v1667T7TwMu1Q01eOVz
	XyfpsNkJSbgNHhxM+4OFKdkAha31N4VdSzXmKp2meVfPiRQlxO86fxwF4Vw98Qq7/gnK3W
	4b/DDS35gwPEA9SRZwAZHwpwvPYakFkN8D43QvWejhc/gDHpl8rl6g7hVN+hxuvLTuCc/W
	UXR3S6H8mBn/QhR8Otqc/Hh/Jknn5UrmPKqzsOkG+3bgGE0KstZ/4IcuP8vy1cqnPg2iD0
	nfRp7cdfXUoLS0yCUS6mARy8tMk6Du5tyQHfd7cUb0JU4/J6dSl2cyi7lWAOGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728507961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PLrNPMEax/1XIv2gXbIgjHBnuZM6tq+rjJmA8NEhnew=;
	b=wcmI951rEhrizlJbyWpwjcF+mf3zBsi1kgRHGiUdm6Z3JXwjkqfgVKRXOaU1vWqerzfiBO
	D6gzdlAjF185xJDw==
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 mingo@kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
In-Reply-To: <20241009164355.1ca1d3d3@gandalf.local.home>
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de> <87wmihdh3u.fsf@oracle.com>
 <20241009062019.1FJYnQL1@linutronix.de>
 <20241009080202.GJ17263@noisy.programming.kicks-ass.net>
 <20241009100133.2569e2a7@gandalf.local.home> <87h69lqbk0.ffs@tglx>
 <20241009164355.1ca1d3d3@gandalf.local.home>
Date: Wed, 09 Oct 2024 23:06:00 +0200
Message-ID: <87ed4pq953.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 09 2024 at 16:43, Steven Rostedt wrote:
> On Wed, 09 Oct 2024 22:13:51 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> The reason why this works is that preempt_enable() actually has a
>> meaning while it does not with NONE.
>
> Looking around, I see the pattern of checking need_resched() from within a
> loop where a spinlock is held. Then after the break of the loop and release
> of the spinlock, cond_resched() is checked, and the loop is entered again.
>
> Thus, I guess this is the reason you are saying that it should just check
> NEED_RESCHED and not the LAZY variant. Because if we remove that
> cond_resched() then it would just re-enter the loop again with the LAZY
> being set.
>
> Hmm, but then again...
>
> Perhaps these cond_resched() is proper? That is, the need_resched() /
> cond_resched() is not something that is being done for PREEMPT_NONE, but
> for preempt/voluntary kernels too. Maybe these cond_resched() should stay?
> If we spin in the loop for one more tick, that is actually changing the
> behavior of PREEMPT_NONE and PREEMPT_VOLUNTARY, as the need_resched()/cond_resched()
> helps with latency. If we just wait for the next tick, these loops (and
> there's a lot of them) will all now run for one tick longer than if
> PREEMPT_NONE or PREEMPT_VOLUNTARY were set today.

You are looking at it from the wrong perspective. You are trying to
preserve the status quo. I know that's the path of least effort but it's
the fundamentally wrong approach.

    spin_lock(L);
    while ($cond) {
          do_stuff();
          if (need_resched()) {
          	spin_unlock(L);
                resched();
                spin_lock(L);
          }
    }
    spin_unlock(L);

is the bogus pattern which was introduced to deal with the NONE
shortcomings. That's what we want to get rid of and not proliferate.

For the transition phase we obviously need to do:

    while ($cond) {
          spin_lock(L);
          do_stuff();
          spin_unlock(L);
          cond_resched();
    }

And once all the problems with LAZY are sorted then this cond_resched()
line just goes away and the loop looks like this:

    while ($cond) {
          spin_lock(L);
          do_stuff();
          spin_unlock(L);
    }

There is absolutely no argument that the spinlock held section needs to
spawn the loop. We fixed up several of these constructs over the years
and none of them caused a performance regression. Quite the contrary
quite some of them improved performance because dropping the lock lets
other CPUs interleave.

Seriously, this crap preserving mindset has to stop. If we go new ways
then we go them all the way.

There is a cost involved for cleaning the existing crap up, but that
cost is well worth it, because anything else is just adding to the ever
increasing accumulation of technical debt. We have enough of that
already.

Thanks,

        tglx

