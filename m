Return-Path: <linux-kernel+bounces-357997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB449978FA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFF228440D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A579C19005B;
	Wed,  9 Oct 2024 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3iDUJ5qu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eLgUPdwT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5956817B4FE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515793; cv=none; b=JIwFrcl5Ps44rgHI9Bxi9ELxO8gt7ObTaphGkQEip+FkzSdBpg5gaHvXG4j6b+npOj0ESJHNHfyYiSNn12BBX+brSkEobghuwEaGOwSCcNXcGVXNKK77e2SQT3y3pNfnGUwyQUWX9EDdWRBT0W9pIS4iQKClAt7eOiX/O9RW1U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515793; c=relaxed/simple;
	bh=Y37fFFfYqnTs1jVs6SuqHEt5e3spVxCh6p2Wk1RjExw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IaJQ63u/2lt4SAGinBywtPxuY/MRo18M7l+c8C85e9kdEAiKbwiytRCXhnkaSqF+k3f19T2aANGjKpbp5c5p2P+CVwtvHKlx+qcd0B5PZB95JouDDRteLCpRdpmbF3nLj3CU/86/uF0fAmYwGOePODxFzhonSA1Cym5Ex0pegQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3iDUJ5qu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eLgUPdwT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728515788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m5Myka16BwlkryMnVHccrY4kSgON7KSMWm3ywUnLqiE=;
	b=3iDUJ5quE1UupDViqWjD2EnvXQJa3SkMpYe84TyD8YTKJcZMjT3TkwBAU3ipgp9VdHFj2Y
	2xYyUw4sKBHtVZx2vKAM7bIfkHvn8IjvFmJH8Eqz8YdWEOuUcIgHPVNnkTAhsdeKn7+cCc
	lCxNcL5S5fzBC9INV+hYos4bUCLBXG0VmUVbrb+y/PEKba4UsrLBGT5zEwLr6LJZhrSQNv
	dXDxzOa5/czdme/tx6tWLPALxWHmXUnZgguoIwfHgzF1Rop9BPXEjCgP6sj9kTFOSX2zSK
	abAvNgzg84Rv2CvUagiwHxWs+bukqKvTvrBxby6Y5wCgcQerH1qhmDg1ASfa0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728515788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m5Myka16BwlkryMnVHccrY4kSgON7KSMWm3ywUnLqiE=;
	b=eLgUPdwTTrHRRKVcJI91otNoLVcdKvC8+1eWcx84Z7W0y9VWmTNZjPPtuRkLwGrVWHxfv0
	TUBc1f4oka5pL0Bw==
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 mingo@kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
In-Reply-To: <20241009171923.78813d22@gandalf.local.home>
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de> <87wmihdh3u.fsf@oracle.com>
 <20241009062019.1FJYnQL1@linutronix.de>
 <20241009080202.GJ17263@noisy.programming.kicks-ass.net>
 <20241009100133.2569e2a7@gandalf.local.home> <87h69lqbk0.ffs@tglx>
 <20241009164355.1ca1d3d3@gandalf.local.home> <87ed4pq953.ffs@tglx>
 <20241009171923.78813d22@gandalf.local.home>
Date: Thu, 10 Oct 2024 01:16:27 +0200
Message-ID: <875xq0rho4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 09 2024 at 17:19, Steven Rostedt wrote:
> On Wed, 09 Oct 2024 23:06:00 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> For the transition phase we obviously need to do:
>> 
>>     while ($cond) {
>>           spin_lock(L);
>>           do_stuff();
>>           spin_unlock(L);
>>           cond_resched();
>>     }
>
> But if $cond needs to be protected by spin_lock(), what then?
>
> 	spin_lock();
> 	while ($cond) {
> 		do_stuff();
> 		spin_unlock();
> 		spin_lock();
> 	}
> 	spin_unlock();
>

Seriously? The proper pattern for this is to do either:

	while (READ_ONCE($cond)) {
		scoped_guard(spinlock)(L) {
                	if ($cond)
                		break;
			do_stuff();
                }
		cond_resched(); // To be removed
	}

or in case that $cond is more complex and needs lock protection:

	while (true) {
		scoped_guard(spinlock)(L) {
                	if ($cond)
                		break;
			do_stuff();
                }
		cond_resched(); // To be removed
	}

You get the idea, no?

>> Seriously, this crap preserving mindset has to stop. If we go new ways
>> then we go them all the way.
>
> It's not about "crap preserving" but more of taking smaller steps. Then we
> can see where a regression happened if one does come up. Kind of like how
> you did the x86 64bit/32bit merge. Do steps that keep things as close to
> what they were at the start and slowly move toward your goals.

Correct. But if you want to do small steps then you have to look at all
the usage sites first and prepare them _before_ introducing the new
model. That's what I have done for the past 20 years.

The comparison to the 32/64bit merge is completely bogus because that
was just the purely mechanical collocation of the files to make it easy
to consolidate them afterwards. The consolidation was the real effort.

If you want a proper example then look at the CPU hotplug cleanup. There
was a large pile of preparatory patches before we even started to
convert to the state machine concept.

Look at all the other things we've done in the past 20 years of
refactoring to make RT possible. They all follow the same scheme:

   1) Analyze _all_ usage sites, i.e. make an inventory

   2) Define a migration path, i.e. come up with proper abstractions

   3) Convert the usage sites over to the new abstractions

   4) Replace the mechanics in the new abstractions

I certainly tried to short curcuit in the early days, but I learned
instantaneously that the short circuit approach is doomed especially
when you deal with changing the most fundamental parts of an OS.

Your idea of taking smaller steps is fundamentally flawed as it fails
to look at the bigger picture first and just tries to emulate the status
quo without doing the preparatory steps upfront.

Peter's approach is perfectly fine because it provides an opportunity,
which allows to do the analysis (#1) not only by inspection, but also by
observation, without being disruptive.

That seems to be the more painful approach, but I can assure you it's
less painful than the 'emulate crap' just to make progress approach.

Why?

It forces people to actually analyze the problems and not work around
them with yet another magic duct tape solution which is equally ill
defined as cond_resched() or the hideous might_sleep() hack.

The goal is to reduce technical debt and not to replace it with a
different variant.

Thanks,

        tglx

