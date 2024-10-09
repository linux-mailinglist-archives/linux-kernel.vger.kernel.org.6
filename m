Return-Path: <linux-kernel+bounces-358004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF36A99791F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDEE2835E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8C21E3770;
	Wed,  9 Oct 2024 23:29:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B862AE8C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516552; cv=none; b=YD2lcoOSFh4Z3eEEqA0YA4Oys+KId5ffBIMJLkohE9s52Mwx665xujmUCs33FlF6Tx+n4UKGRpwYNtUbWB0Y9Pgu1PeTSsvdBc7aEP0Fm4ohajlBEKsNwXZoHN9457mRFXrxa/W6Jc3WmPZnDUDD88O9tMCl0lPBmBqXoUjt2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516552; c=relaxed/simple;
	bh=SJMfKFUqlsbSFJhiw6VZoA/OG1lrnIkETuWgEbXwlxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Un4+lsF/9kzl8jQ6Ay/tfnOrMiKv+6OoSYIO2LgVQRMbr7J1qcJbHp25U9w1w5I/XtvrBdiQ3EqPquTuie0sup6D2NqrH3aRyefMd1E+jfHOCe8JMatwjAl0nWJKrCQHFw2QG1AWYGiMp7+UZl6ezsa4LFCCKqb0Re2HaxKroS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AB0C4CEC3;
	Wed,  9 Oct 2024 23:29:09 +0000 (UTC)
Date: Wed, 9 Oct 2024 19:29:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 mingo@kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
Message-ID: <20241009192915.59344311@gandalf.local.home>
In-Reply-To: <875xq0rho4.ffs@tglx>
References: <20241007074609.447006177@infradead.org>
	<20241008153232.YwZfzF0r@linutronix.de>
	<87wmihdh3u.fsf@oracle.com>
	<20241009062019.1FJYnQL1@linutronix.de>
	<20241009080202.GJ17263@noisy.programming.kicks-ass.net>
	<20241009100133.2569e2a7@gandalf.local.home>
	<87h69lqbk0.ffs@tglx>
	<20241009164355.1ca1d3d3@gandalf.local.home>
	<87ed4pq953.ffs@tglx>
	<20241009171923.78813d22@gandalf.local.home>
	<875xq0rho4.ffs@tglx>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 01:16:27 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, Oct 09 2024 at 17:19, Steven Rostedt wrote:
> > On Wed, 09 Oct 2024 23:06:00 +0200
> > Thomas Gleixner <tglx@linutronix.de> wrote:  
> >> For the transition phase we obviously need to do:
> >> 
> >>     while ($cond) {
> >>           spin_lock(L);
> >>           do_stuff();
> >>           spin_unlock(L);
> >>           cond_resched();
> >>     }  
> >
> > But if $cond needs to be protected by spin_lock(), what then?
> >
> > 	spin_lock();
> > 	while ($cond) {
> > 		do_stuff();
> > 		spin_unlock();
> > 		spin_lock();
> > 	}
> > 	spin_unlock();
> >  
> 
> Seriously? The proper pattern for this is to do either:
> 
> 	while (READ_ONCE($cond)) {
> 		scoped_guard(spinlock)(L) {
>                 	if ($cond)
>                 		break;
> 			do_stuff();
>                 }
> 		cond_resched(); // To be removed
> 	}
> 
> or in case that $cond is more complex and needs lock protection:
> 
> 	while (true) {
> 		scoped_guard(spinlock)(L) {
>                 	if ($cond)
>                 		break;
> 			do_stuff();
>                 }
> 		cond_resched(); // To be removed
> 	}
> 
> You get the idea, no?

Basically still the same logic, just a different syntax. Speaking of which...

> 
> >> Seriously, this crap preserving mindset has to stop. If we go new ways
> >> then we go them all the way.  
> >
> > It's not about "crap preserving" but more of taking smaller steps. Then we
> > can see where a regression happened if one does come up. Kind of like how
> > you did the x86 64bit/32bit merge. Do steps that keep things as close to
> > what they were at the start and slowly move toward your goals.  
> 
> Correct. But if you want to do small steps then you have to look at all
> the usage sites first and prepare them _before_ introducing the new
> model. That's what I have done for the past 20 years.
> 
> The comparison to the 32/64bit merge is completely bogus because that
> was just the purely mechanical collocation of the files to make it easy
> to consolidate them afterwards. The consolidation was the real effort.
> 
> If you want a proper example then look at the CPU hotplug cleanup. There
> was a large pile of preparatory patches before we even started to
> convert to the state machine concept.
> 
> Look at all the other things we've done in the past 20 years of
> refactoring to make RT possible. They all follow the same scheme:
> 
>    1) Analyze _all_ usage sites, i.e. make an inventory
> 
>    2) Define a migration path, i.e. come up with proper abstractions
> 
>    3) Convert the usage sites over to the new abstractions
> 
>    4) Replace the mechanics in the new abstractions
> 
> I certainly tried to short curcuit in the early days, but I learned
> instantaneously that the short circuit approach is doomed especially
> when you deal with changing the most fundamental parts of an OS.
> 
> Your idea of taking smaller steps is fundamentally flawed as it fails
> to look at the bigger picture first and just tries to emulate the status
> quo without doing the preparatory steps upfront.
> 
> Peter's approach is perfectly fine because it provides an opportunity,
> which allows to do the analysis (#1) not only by inspection, but also by
> observation, without being disruptive.
> 
> That seems to be the more painful approach, but I can assure you it's
> less painful than the 'emulate crap' just to make progress approach.
> 
> Why?
> 
> It forces people to actually analyze the problems and not work around
> them with yet another magic duct tape solution which is equally ill
> defined as cond_resched() or the hideous might_sleep() hack.
> 
> The goal is to reduce technical debt and not to replace it with a
> different variant.
> 

The above definitely sounds like rational to switch everything over to Rust!

  /me runs!!!!

-- Steve

