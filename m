Return-Path: <linux-kernel+bounces-355506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E75799533E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54C7281422
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1011E04BA;
	Tue,  8 Oct 2024 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hv8RLVWU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pzg4cZ6D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0FA1E049E;
	Tue,  8 Oct 2024 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400883; cv=none; b=Br3tbaYhSRiWNyIjxCFz1djcJG4vhFE+sVtcL6/7KpJZ/LubNs0NM8UK5LaoTdHpaZ/oX5O3y6FxvkayKPUepFnOGoGkMI9j3iYIUohJBAe1h+tD2OhKH6XYGoAy/j1CLQjmapQ7Lu16P7kKup9W+AnuRZAj8+16NjR0QeYuovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400883; c=relaxed/simple;
	bh=433XxIHpU9T7s7INXr8uSL9mwO5qKnfKc1yNBcVny4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J7o0SxMe5WbsglJQvZ+zgRhj9Y9dRqjqO9cO/i7awNv3W5xi0zWWLwbBtaNJQJhSnablaXYHUxBCTxvaF+5B/yKJMGjKwgWzt0ADLdlHYYF1/47BInPzlL1R2i/Dnq5fwitktzO9a7RuE+z/4mq3mEn0Ru3fjrXLmoFplN7QzPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hv8RLVWU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pzg4cZ6D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728400879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+uLeRZLnttHb34vsWR35vegqVbPeYjV996KCqrj9XyQ=;
	b=Hv8RLVWU/D5aAnA7/bJpuDDFvJ3gk9zslzZIUoM/qKsAA6WQ23jG5DpueioGf3PHNBQKLN
	A7GaOOyxHiAuEHL2rhxXyMpUyEM0G7fxsnQdWNHsgIx+mbzfSUR5TgeTDf8P1Icb4uevyz
	oFzPhtcQs79BUR/J949AncdIDfzlGpQq6NZBCx9ZEX/xvDqc3fBrvMJkBeGdCbTy0ljt7G
	yrylMSzWbHnWWivOE8SaCbCHLgRMBOTbILybGjB2ysGZ7zdtR9eszZ5TVsD5T8pixzHCHB
	/6Emuc589kuOY6jZ7K4BX+NCMALws263lx2WkYeH5PcNaNT5b5tx8zRSZEeC8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728400879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+uLeRZLnttHb34vsWR35vegqVbPeYjV996KCqrj9XyQ=;
	b=Pzg4cZ6DABoFz7DpoUM9JiurvlEMFou2t+PJ856YhcjBBWeKsJOVM8U+5M1/Lq/zaVRfg5
	DWbUEpEOjnsFHXCQ==
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
In-Reply-To: <9f580260866a202d7608f902464b7fae087dd6c6.camel@redhat.com>
References: <20240916213025.477225-1-lyude@redhat.com>
 <20240916213025.477225-4-lyude@redhat.com> <8734lew7jn.ffs@tglx>
 <0a802e5fc0623ac8ae4653a398d0dfd73c479b96.camel@redhat.com>
 <87a5fgunoc.ffs@tglx>
 <9f580260866a202d7608f902464b7fae087dd6c6.camel@redhat.com>
Date: Tue, 08 Oct 2024 17:21:19 +0200
Message-ID: <878quytyc0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 07 2024 at 14:30, Lyude Paul wrote:
> On Mon, 2024-10-07 at 14:01 +0200, Thomas Gleixner wrote:
> So actually the new solution I suggested a little after that original email
> wouldn't need to call local_irq_save() directly - sorry, I just explained it
> kind of poorly and it hadn't been in my head for very long. I think you'll
> like this solution a lot more though, lemme explain:
>
> Basically instead of having functions like with_interrupts_disabled, we would
> instead introduce a new trait that can be implemented by locks with context
> tokens: BackendWithContext:
>
> pub trait BackendWithContext: Backend {
> type ContextState;
>
> unsafe fn lock_first(ptr: *Self::State)
> -> (Self::Context, Self::ContextState, Self::GuardState);
>
> unsafe fn unlock_last(
> ptr: *Self::State,
> context_state: Self::ContextState,
> guard_state: &Self::GuardState
> );
> }
>
> Where the idea is that a type like SpinlockIrq would define ContextState to be
> a u64 (holding the flags argument from spin_lock_irqsave). lock_first() would
> use spin_lock_irqsave and create the token, unlock_last() would use
> spin_unlock_irqrestore with the saved ContextState. Then we could use those
> unsafe primitives to implement a method on Lock like this:
>
> impl<T: ?Sized, B: BackendWithContext> Lock<T, B> {
> pub fn lock_with_new<'a>(
> &self,
> cb: impl FnOnce(Self::Context, &mut Guard<'a, T, B>) -> R
> ) -> R;
> }
>
> What lock_with_new would do is:
>
>  * call B::first_lock() (which would be spin_lock_irqsave)
>  * call cb() with a LocalInterruptsDisabled token and a &mut to the Guard (so
>    that the caller can't drop the lock before exiting the noirq context)
>  * Call B::last_unlock() with the ContextState that was passed to first_lock()
>    (which would be spin_unlock_irqrestore)
>
> So we'd absolutely still be modeling around the locking primitives
> spin_lock_irqsave() and spin_unlock_irqrestore(). And subsequently we could
> still nest lock contexts like normal. with_irqs_disabled() wouldn't be needed
> in this arrangement - but we would still need the Interrupt tokens (which
> would be fine since they're just for enforcing correctness anyway).

Makes sense.

>> The above example really should not end up in 3 guard contexts, but in
>> two by combining #1 and #2 into one. In C this looks like:
>> 
>>     scoped_guard(spinlock_irqsave)(&A) {
>>         // Allows to operate on resources which are exclusively
>>         // protected by A (DataA)
>>         
>>  scoped_guard(spinlock)(&B) {
>>            // Allows to operate on resources which are exclusively
>>            // protected by B (DataB)
>>         }
>>     }
>> 
>> Nesting B into lock A is required to keep some aspects of DataA and
>> DataB consistent. But the other parts of DataB require only B to be
>> held.
>> 
>> For extended fun lock B is not necessarily required to be acquired with
>> interrupts disabled. The fact that it nests into lock A does not make it
>> mandatory.
>> 
>> A lock is only required to be acquired with interrupts disabled if it
>> can be taken in interrupt context. That's a per lock property.
>
> I think you misunderstood something somewhere - this has always been the case
> with the bindings I submitted that you don't need a context for all locks,
> only locks that define one. That is why we reimplement lock() to look like
> this (where T is the data protected by the lock and B is the backend):
>
> pub fn lock<'a>(&'a self) -> Guard<'a, T, B>
> where
> B::Context<'a>: Default
> {
> self.lock_with(Default::default())
> }
>
> So SpinLock's B::Context is (), which implements Default - meaning you can
> acquire it simply like this:
>
> some_lock.lock();
>
> But that wouldn't work for SpinLockIrq with a context of IrqDisabled<'a>,
> since IrqDisabled doesn't implement Default.

Thanks for clarification. It's clear now.

Thanks,

        tglx

