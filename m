Return-Path: <linux-kernel+bounces-353237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76143992AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0422A1F234B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43691D2716;
	Mon,  7 Oct 2024 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d9TOvwjT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QlXTTan5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505081D1E60;
	Mon,  7 Oct 2024 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302504; cv=none; b=tfUlydBW6TbUGrJAoO6y7uAL302g3u0wl+wsonYbdZPCNChdPj8N3Z7nRciixuCQpqJfzU4okeFTKqB+f5tLLkhg3B/OvQ1WG1nYQ6Ut734IGUmm98UqFa2omTICG0N//usuoZXQYehHfudgsMyPGwCJnpLjaDYkv7Q/6T0DNIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302504; c=relaxed/simple;
	bh=H0VBqBFVjQSy9PoKrfKNbDDZaFrpotc3uN6aYrYSKIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zlr6dpSroIYe9MywZ4lCF+LJA58UHk920004lFz4xlc8O972cKq4tasKv6ArGEX1FeP2X1dOgpYXdKNRQ/VkmhIW8yxnnEHfk459wtet0wSockrSmvWtAXqiRVo+We0tGVmOZWY6n9ceeRSk9y2fw5T0W66kUp156wHLBqF2xoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d9TOvwjT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QlXTTan5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728302500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C84Rwtjg5+pdqVVVY4IrSgUud1AUbu+ERhzKV8tIPGA=;
	b=d9TOvwjTzFVgkQJhjxqzp3LoiQLCxc3wjyJTnpshel36c8HEsPQVDfMLQJSBGn7YG31mx1
	WxRqxbZwVnZTZinWNxx/AhB7fsi0dRiRxGXVuYh/P6/zsThMPwiTjaE9aiWWfN+ZAePE79
	dNZyi8zFV04UbcAcuCUroFtjBLHaLjAlRKEAvTbr01KvaoNoUUduJBPbqptowyjyeXnVOB
	unXdP+RYIY4ZXpYxWJ/pealkj9KxQvtWNDv9E5IcYCOpVq3Ii/r4GbAbMviOFz85SsjCZr
	EstL8KiR7fDQLv10gTxzzyfPiLmDqSHiBtM/pqAFqkFTtJJJMw4T3GMrO5bICg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728302500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C84Rwtjg5+pdqVVVY4IrSgUud1AUbu+ERhzKV8tIPGA=;
	b=QlXTTan59lYEDkhnPw+7sO8fUASeoyEoZ71Fki4ZnOp0vl5WkyxhY6nUoV9T7XEhbjzAuT
	u4XXl4ocQy5ovvDw==
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Benno Lossin <benno.lossin@proton.me>,
 Daniel
 Almeida <daniel.almeida@collabora.com>, Gary Guo <gary@garyguo.net>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson
 Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo
 <yakoyoku@gmail.com>, Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v6 3/3] rust: sync: Add SpinLockIrq
In-Reply-To: <0a802e5fc0623ac8ae4653a398d0dfd73c479b96.camel@redhat.com>
References: <20240916213025.477225-1-lyude@redhat.com>
 <20240916213025.477225-4-lyude@redhat.com> <8734lew7jn.ffs@tglx>
 <0a802e5fc0623ac8ae4653a398d0dfd73c479b96.camel@redhat.com>
Date: Mon, 07 Oct 2024 14:01:39 +0200
Message-ID: <87a5fgunoc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 04 2024 at 14:48, Lyude Paul wrote:
> On Wed, 2024-10-02 at 22:53 +0200, Thomas Gleixner wrote:
>> At this phase of rust integration there is no need to wrap
>> raw_spinlock_t, so you have two options to solve that:
>> 
>>    1) Map Rust's SpinLockIrq() to spin_lock_irqsave() and
>>       spin_unlock_irqrestore() which does the right thing
>> 
>>    2) Play all the PREEMPT_RT games in the local irq disable abstraction
>
> I would very strongly rather #2. The problem with #1 is that one of the goals
> with the way I designed this abstraction with was to make it so that we could
> have lock guards that share the lifetime of the IrqDisabled token - which
> means the compiler can stop you from holding the lock outside of an
> IrqDisabled context. We have a powerful type system in rust, so IMO we should
> use it.
>
> I don't think this is as difficult to do as it seems either. One thing we
> could do is have two different versions of the with_irqs_disabled functions:
>
> with_irqs_disabled_on_nort
> with_irqs_disabled
>
> And as well, have each respectively return a different token type:
>
> IrqsDisabledNoRt -> Local interrupts are disabled on non-RT kernels
> IrqsDisabled -> Local interrupts are disabled always
>
> I think this actually is a nice solution, because it provides a number of
> benefits:
>
>  * It makes it much more clear that interrupts won't always be disabled. I'll
>    be honest, I've been working on drivers for almost a decade in the upstream
>    kernel and as you can see I don't think any of us actually realized
>    interrupts being turned off here wasn't a given :P. I'm sure it's
>    documented, but when you've been working on this stuff for so long you
>    don't always default to going back to documentation for stuff like this.
>  * Having two different token types would prevent raw spinlocks from being
>    used in contexts where it's not guaranteed local IRQs would be disabled -
>    and vice versa.

You really want to have two distinct lock types: spinlock and
raw_spinlock. On a non-RT kernel spinlock maps to raw_spinlock, but
that's an implementation detail.

>> #1 is the right thing to do because no driver should rely on actually
>> disabling interrupts on the CPU. If there is a driver which does that,
>> then it's not compatible with RT and should use a local lock instead.
>
> FWIW too - that seems reasonable. The reason I still see benefit in with
> with_irqs_disabled_on_nort though is that this feels a bit closer to some of
> the goals of the C API to me. We have spin_lock_irqsave and spin_lock, with
> the intention that on non-RT kernels IRQs should only need to be disabled a
> single time even if multiple spinlocks are acquired within the scope of a
> single function. I'd like to ensure we can still do that on rust since it's
> possible to do.

Sure. That's not the problem. The problem is:

      local_irq_save();
      spin_lock();

instead of

      spin_lock_irqsave();

The latter allows RT kernels to substitute spin_lock_irqsave() with:

      rt_spin_lock();

which maps to a rtmutex variant and does neither disable interrupts nor
preemption. It only disables migration to guarantee that the task stays
on the CPU, which in turn is a prerequisite for protecting per CPU data
with the lock.

The former does not work on RT because then the rtmutex is acquired with
interrupts disabled, which is a nono because the acquire can sleep.

There is another problem with this split. The example in your spinlock
patch is exactly what we don't want:

> +/// // Accessing an `Example` from a context where IRQs may not be disabled already.
> +/// let b = with_irqs_disabled(|irq| {
> +///     noirq_work(&e, irq);
> +///     e.d.lock_with(irq).b
> +/// });

Why? 

This pattern is in 99% of the cases wrong to begin with independent of
RT because noirq_work() can only be safe if it operates strictly on per
CPU data. If it accesses any shared resource including hardware it's
broken on SMP.

Outside of a very narrow part of core code which uses raw spinlocks,
there is absolutely zero reason for such a construct. We've educated
driver writers to avoid this pattern and now Rust tries to reintroduce
it.

Please do not encourage people to do the wrong thing.

I completely understand and agree with the goal of taking advantage of
Rust's safety, but not for the price of misguiding people.

So you want to make this work:

   spin_lock_irqsave(A);
   spin_lock(B);

and let the compiler validate that the nested spin_lock() is invoked in
a context which has interrupts disabled, right?

To do that you split the spin_lock_irqsave() into

   local_irq_save();     #1
     spin_lock(A);       #2
       spin_lock(B);     #3
       spin_unlock(B);
     spin_unlock(A);
   local_irq_restore();

That makes sense as it gives you three distinct guard contexts, but the
outermost guard context (interrupt disable) is an illusion in most cases
as it does not provide a guard for anything. It merely provides the
prerequisite for locking lock A.

The above example really should not end up in 3 guard contexts, but in
two by combining #1 and #2 into one. In C this looks like:

    scoped_guard(spinlock_irqsave)(&A) {
        // Allows to operate on resources which are exclusively
        // protected by A (DataA)
        
    	scoped_guard(spinlock)(&B) {
           // Allows to operate on resources which are exclusively
           // protected by B (DataB)
        }
    }

Nesting B into lock A is required to keep some aspects of DataA and
DataB consistent. But the other parts of DataB require only B to be
held.

For extended fun lock B is not necessarily required to be acquired with
interrupts disabled. The fact that it nests into lock A does not make it
mandatory.

A lock is only required to be acquired with interrupts disabled if it
can be taken in interrupt context. That's a per lock property.

Thanks,

        tglx



