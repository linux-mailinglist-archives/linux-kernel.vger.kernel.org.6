Return-Path: <linux-kernel+bounces-357838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70A9976CF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32533285C50
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340FF1E32A0;
	Wed,  9 Oct 2024 20:43:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A031E200A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506632; cv=none; b=Cx3iRS60HBQ14xIZgCQqb5LByQ6r4zgKpSLyluwJG3eZY32Rx8frcuParsvJLyss0yTIK1u17XpALZevoyHC5RO5CQh65cXgKdLwj2zsmkymuEzqw5/QkbKGSpGCIgthHHYayYustBmN5qum2WRLxxeUZmLATuFeQu6B1UoptF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506632; c=relaxed/simple;
	bh=8yt+kQW1n3A7GTqmFm2ujcJH6Yb6J5NUBpnb18HIJhw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkmoqPVfraQv4O4zAELp3OOKblNlpRS1JS1yc+uoTlkxwSogc1A9AZO19ff5G1kggtOU+FxmC0J4rOKLr1DFtwyr9zk/KlOb739g/CigDeKZYq/NBsVMZ3aRIwEZ4fCwL2Y2XmLLCBBu8u83AjnucJGimWtPkfwDZuyzlI8CcX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744EBC4CEC3;
	Wed,  9 Oct 2024 20:43:50 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:43:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 mingo@kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
Message-ID: <20241009164355.1ca1d3d3@gandalf.local.home>
In-Reply-To: <87h69lqbk0.ffs@tglx>
References: <20241007074609.447006177@infradead.org>
	<20241008153232.YwZfzF0r@linutronix.de>
	<87wmihdh3u.fsf@oracle.com>
	<20241009062019.1FJYnQL1@linutronix.de>
	<20241009080202.GJ17263@noisy.programming.kicks-ass.net>
	<20241009100133.2569e2a7@gandalf.local.home>
	<87h69lqbk0.ffs@tglx>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Oct 2024 22:13:51 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> > If we think about it as what would happen with the current PREEMPT_NONE,
> > wouldn't need_resched() return true as soon as NEED_RESCHED is set? That
> > means, with PREEMPT_AUTO, it should return true if LAZY_NEED_RESCHED is
> > set, right? That would make it act the same in both cases.  
> 
> I don't think so. Quite some of these need_resched() things have been
> sprinkled around to address the issues with PREEMPT_NONE.

My point is that the need_resched() that are sprinkled around are checking
if a schedule has been requested or not. From that point alone,
LAZY_NEED_RESCHED is something that requested a schedule.

> 
> We need to look at those places and figure out whether they need it when
> LAZY is enabled. There might be a few which want to look at both flags,
> but my expectation is that those are less than 5% of the overall usage.
> 
> Peter's choice is the right one. That forces us to look at all of them
> and figure out whether they need to be extended to include the lazy bit
> or not. Those which do not need it can be eliminated when LAZY is in
> effect because that will preempt on the next possible preemption point
> once the non-lazy bit is set in the tick.
> 
> Remember, the goal is to eliminate all except LAZY (RT is a different
> scope) and make the kernel behave correctly to the expectation of LAZY
> (somewhere between NONE and VOLUNTARY) and non-LAZY (equivalent to
> FULL).
> 
> The reason why this works is that preempt_enable() actually has a
> meaning while it does not with NONE.

Looking around, I see the pattern of checking need_resched() from within a
loop where a spinlock is held. Then after the break of the loop and release
of the spinlock, cond_resched() is checked, and the loop is entered again.

Thus, I guess this is the reason you are saying that it should just check
NEED_RESCHED and not the LAZY variant. Because if we remove that
cond_resched() then it would just re-enter the loop again with the LAZY
being set.

Hmm, but then again...

Perhaps these cond_resched() is proper? That is, the need_resched() /
cond_resched() is not something that is being done for PREEMPT_NONE, but
for preempt/voluntary kernels too. Maybe these cond_resched() should stay?
If we spin in the loop for one more tick, that is actually changing the
behavior of PREEMPT_NONE and PREEMPT_VOLUNTARY, as the need_resched()/cond_resched()
helps with latency. If we just wait for the next tick, these loops (and
there's a lot of them) will all now run for one tick longer than if
PREEMPT_NONE or PREEMPT_VOLUNTARY were set today.


-- Steve

