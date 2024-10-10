Return-Path: <linux-kernel+bounces-358087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD174997A17
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5DCFB22323
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8613D281;
	Thu, 10 Oct 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K5IR2ZVz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hDb3Plhi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF5038DD8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523230; cv=none; b=GDUVIHM/AKE8MT6ixKBI1GDU7BiFTDVFGZcTqK4KKRBJnEPiNB/Ur8+LGCH73tYjQGuuFCIzA9eIUZMyhxfwNFTjMFU0rmehfyBKJK0DRIeU291Fs44YfWcIJTZ9My8OHtX8WFAE8I2FbiunDGn0DC96EQLaxGCENCulCV8LFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523230; c=relaxed/simple;
	bh=DU9B7RPFjGpjdBD4UKqSuNCawwNThbKUSaZgfXJNHBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VFyRduFLrXLOJlaxrXEtjxELFRxYAYZleMbAppbkOw4nW+gfaepCd5w735dAnyfcBov+kLBuOPPeCGjcivX944JMYx+DrbqwkX74L9JgRp3nu1Pw2dc7QL9UaX2DPRQ2JNuQY0Nr52ZwNBbuAt+CsxxPMtYFayPg9bpIsroeHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K5IR2ZVz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hDb3Plhi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728523227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+JJN4x/CHHAYCKzvw/EOTavecb+vLpBoHn9hogzbzw=;
	b=K5IR2ZVzSFe+ETwDQfUQAhvBCeT2WeQEYDNqIUVSvkPRF2OvsJG2MUIVOxJXrkjnwBW57f
	pCoW37JbBRSZ7tTBfKZMJyYHFxNSULUTiaGgiFgmZe5lUSIAmANk3KZvXeG9GaWvHXxR41
	Lev5XZjLJ8E7yUeQeMOpTLSTOYFxeshypm8jockWBZefm+7Xk3t25UNheBhy7qFMm5S4xT
	fUh7Zhby1fycEQ5GaE5CCHfG0EvRIXvGvhGgJPtECx/N2ut8xO5ryFeKazRIcpBbK/kOA/
	XICQKbjMtafi/mxT0GHtvRKik4HmOarcE5sUQUeKyP3JHwC+v8zx7aPLc7Jqvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728523227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+JJN4x/CHHAYCKzvw/EOTavecb+vLpBoHn9hogzbzw=;
	b=hDb3PlhimUu038C9QJ9lBrBXFiwAlOk2L5I5pjgr6M8SlWCodM+2fKncmS7vgMKf6dR6BH
	qkph1KTfRLHWEkBQ==
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 mingo@kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
In-Reply-To: <20241009192915.59344311@gandalf.local.home>
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de> <87wmihdh3u.fsf@oracle.com>
 <20241009062019.1FJYnQL1@linutronix.de>
 <20241009080202.GJ17263@noisy.programming.kicks-ass.net>
 <20241009100133.2569e2a7@gandalf.local.home> <87h69lqbk0.ffs@tglx>
 <20241009164355.1ca1d3d3@gandalf.local.home> <87ed4pq953.ffs@tglx>
 <20241009171923.78813d22@gandalf.local.home> <875xq0rho4.ffs@tglx>
 <20241009192915.59344311@gandalf.local.home>
Date: Thu, 10 Oct 2024 03:20:26 +0200
Message-ID: <87h69kiwit.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 09 2024 at 19:29, Steven Rostedt wrote:
> On Thu, 10 Oct 2024 01:16:27 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> On Wed, Oct 09 2024 at 17:19, Steven Rostedt wrote:
>> > On Wed, 09 Oct 2024 23:06:00 +0200
>> > Thomas Gleixner <tglx@linutronix.de> wrote:  
>> >> For the transition phase we obviously need to do:
>> >> 
>> >>     while ($cond) {
>> >>           spin_lock(L);
>> >>           do_stuff();
>> >>           spin_unlock(L);
>> >>           cond_resched();
>> >>     }  
>> >
>> > But if $cond needs to be protected by spin_lock(), what then?
>> >
>> > 	spin_lock();
>> > 	while ($cond) {
>> > 		do_stuff();
>> > 		spin_unlock();
>> > 		spin_lock();
>> > 	}
>> > 	spin_unlock();
>> >  
>> 
>> Seriously? The proper pattern for this is to do either:
>> 
>> 	while (READ_ONCE($cond)) {
>> 		scoped_guard(spinlock)(L) {
>>                 	if ($cond)
>>                 		break;
>> 			do_stuff();
>>                 }
>> 		cond_resched(); // To be removed
>> 	}
>> 
>> or in case that $cond is more complex and needs lock protection:
>> 
>> 	while (true) {
>> 		scoped_guard(spinlock)(L) {
>>                 	if ($cond)
>>                 		break;
>> 			do_stuff();
>>                 }
>> 		cond_resched(); // To be removed
>> 	}
>> 
>> You get the idea, no?
>
> Basically still the same logic, just a different syntax. Speaking of which...

Of course it's the same logic at the very end, but it's logic which is
understandable, makes sense and allows to change the underlying
infrastructure without disruption.

Refactoring is an art and if you get it wrong you actually make it
worse. Been there, done that.

>> It forces people to actually analyze the problems and not work around
>> them with yet another magic duct tape solution which is equally ill
>> defined as cond_resched() or the hideous might_sleep() hack.
>> 
>> The goal is to reduce technical debt and not to replace it with a
>> different variant.
>> 
>
> The above definitely sounds like rational to switch everything over to Rust!
>
>   /me runs!!!!

Why are you running away?

I'm all for moving the kernel to a less error prone programming
language. I've done ADA programming in my former professional live and
I'm well aware about the advantages of a "safe" programming language.

For me Rust is definitely the right way to go, aside of my personal
distaste of the syntax and the insanity of abandoning an existing
universe of ADA tools just because of 'not invented here', but that's a
different discussion to be had.

That said, converging to Rust requires a massive effort of being
disciplined on the C side in the first place. Otherwise the Rust
abstractions will just end up being a mostly useless wrapper around the
existing C insanities. Which in turn will neither reduce technical debt,
nor be able to hold up the promise to squash a whole class of bugs.

Quite the contrary it will accelerate the problems we already have
instead of reducing them, while everyone can pretend that we are so much
better off.

TBH, converging to Rust is a real chance to move away from the "features
first, correctness later" approach, but the way our community is
approaching it right now is just following the old scheme by making Rust
compatible to the "features first, correctness later" mantra.

If you still are telling me that:

>> > 	spin_lock();
>> > 	while ($cond) {
>> > 		do_stuff();
>> > 		spin_unlock();
>> > 		spin_lock();
>> > 	}
>> > 	spin_unlock();

is just different syntax than

>> 	while (true) {
>> 		scoped_guard(spinlock)(L) {
>>                 	if ($cond)
>>                 		break;
>> 			do_stuff();
>>             }
>> 	}

then please explain to me how you map your proposed scheme to a language
which is scope based by design.

Thanks,

        tglx


