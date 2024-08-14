Return-Path: <linux-kernel+bounces-287169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DEF952432
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F651C217D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AFE1C8FD0;
	Wed, 14 Aug 2024 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="elclyek2"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDE21C68B3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668263; cv=none; b=VBsRqiqdde8lq1R++OSNeyrL4kU9RsfzTg9JLbbxctdbEJM0jBfLhMYp8vMP2ta4tTGKC/wd8T0GiGAXFjd7U2ezqPHHXZkjnT57LKSubFabjJnej5eHU204cx1m77o2vUEWhBA7RB+vLkmOmGyBOUyI1+G6VxsCM7jT16dLRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668263; c=relaxed/simple;
	bh=S1RYIxjoIOM2v4Xggy5IaXihSoD6S1AByvM8TOXP3xQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/j1HFlxkn94e8p4t6GLf2OliYsA8430fFUZm7lw2PpGnbCWmgybN/bjKAe9ak6wqqsUkExNXVj7kig0VFo1ekjVVyikg6M+yVQCXd2P7WUfwuPCYKOKGVst3psfwAeIUHdOjJprdATR+f4Lfoa8k4AyfNvSSS1TN7tNbAakJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=elclyek2; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7tbfsyg77bd6tadjkqwwk7vlva.protonmail; t=1723668258; x=1723927458;
	bh=IvtMA3+Z7FkvrgaQ6LlkOMVsAEPt5hSPxNVCWZ5bIX8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=elclyek2ih//0EVuMNi9Y+3HGoeHYkV5b+UNCy1OImXVRpdcZ10LAvP8B9D+FSqjC
	 10w31msqmbHfaSczaZIgfEffFNieulmreZmCfaGK14SaAW3+0fOSGBKq7Jaa9KMMcD
	 Zibz9EdYSRXK4C/s2OJvdqm9XfkDQ3RRVYmMVBOGnsnsz0cDYCvQI17hn/KdN/FkE3
	 1Isj+gP+iW3WR4ETUsel3BYBsWddpSyCXL8GxptBdAb45TVTILd5Euvaw7CmxS+9YN
	 f1Azsig74cXxsNB5bJxTtFqXDGhbnHyVhU33DOX2ACNFnfuDuD3Rqn8gsGLXCVi83W
	 6PiLnVe4LU2qg==
Date: Wed, 14 Aug 2024 20:44:15 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Lyude Paul <lyude@redhat.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Aakash Sen Sharma <aakashsensharma@gmail.com>, Valentin Obst <kernel@valentinobst.de>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/3] rust: Introduce irq module
Message-ID: <9855f198-858d-4e3f-9259-cd9111900c0c@proton.me>
In-Reply-To: <Zr0QyN8sQ6W2hPoJ@boqun-archlinux>
References: <20240802001452.464985-1-lyude@redhat.com> <20240802001452.464985-2-lyude@redhat.com> <Zrzq8su-LhUIoavm@boqun-archlinux> <1bcae676ec4751ae137782c4ced8aad505ec1bb9.camel@redhat.com> <Zr0QyN8sQ6W2hPoJ@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f842340faae028f04799d26eefc8f2384d4c51ee
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.08.24 22:17, Boqun Feng wrote:
> On Wed, Aug 14, 2024 at 03:38:47PM -0400, Lyude Paul wrote:
>> On Wed, 2024-08-14 at 10:35 -0700, Boqun Feng wrote:
>>> On Thu, Aug 01, 2024 at 08:10:00PM -0400, Lyude Paul wrote:
>>> [...]
>>>> +/// Run the closure `cb` with interrupts disabled on the local CPU.
>>>> +///
>>>> +/// This creates an [`IrqDisabled`] token, which can be passed to fun=
ctions that must be run
>>>> +/// without interrupts.
>>>> +///
>>>> +/// # Examples
>>>> +///
>>>> +/// Using [`with_irqs_disabled`] to call a function that can only be =
called with interrupts
>>>> +/// disabled:
>>>> +///
>>>> +/// ```
>>>> +/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
>>>> +///
>>>> +/// // Requiring interrupts be disabled to call a function
>>>> +/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
>>>> +///     /* When this token is available, IRQs are known to be disable=
d. Actions that rely on this
>>>> +///      * can be safely performed
>>>> +///      */
>>>> +/// }
>>>> +///
>>>> +/// // Disabling interrupts. They'll be re-enabled once this closure =
completes.
>>>> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
>>>> +/// ```
>>>> +#[inline]
>>>> +pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>)=
 -> T) -> T {
>>>
>>> Given the current signature, can `cb` return with interrupts enabled (i=
f
>>> it re-enables interrupt itself)? For example:
>>>
>>> =09with_irqs_disabled(|irq_disabled| {
>>>
>>> =09    // maybe a unsafe function.
>>> =09    reenable_irq(irq_disabled);
>>
>> JFYI: this wouldn't be unsafe, it would be broken code in all circumstan=
ces
>> Simply put: `with_irqs_disabled()` does not provide the guarantee that
>> interrupts were enabled previously, only that they're disabled now. And =
it is
>> never a sound operation in C or Rust to ever enable interrupts without a
>> matching disable in the same scope because that immediately risks a dead=
lock
>> or other undefined behavior. There's no usecase for this, I'd consider a=
ny
>> kind of function that returns with a different interrupt state then it h=
ad
>> upon being called to simply be broken.
>>
>> Also - like we previously mentioned, `IrqDisabled` is just a marker type=
. It
>> doesn't enable or disable anything itself, the most it does is run a deb=
ug
>=20
> Yes, I know, but my question is more that should `cb` return a
> `IrqDisabled` to prove the interrupt is still in the disabled state?
> I.e. no matter what `cb` does, the interrupt remains disabled.

What does this help with? I don't think this will add value (at least
with how `IrqDisabled` is designed at the moment).

>> assertion to ensure interrupts are disabled upon creation. So dropping i=
t
>> doesn't change interrupt state. I think this actually does make sense
>> semantically: even if IrqDisabled wasn't a no-op in a world where we cou=
ld
>=20
> Just to be clear, I'm not suggesting making IrqDisable not a no-op.
>=20
>> somehow implement that without running into the drop order issue - there=
 still
>> would not be a guarantee that dropping `IrqDisabled` would enable interr=
upts
>> simply because it could be a nested disable. And there's no way we could=
 make
>> interrupt enabled sections explicit without either klint, or carrying ar=
ound a
>> `IrqEnabled` (which we would have to do for every function that could sl=
eep,
>> so I don't think that's ideal). So without a token like this all code ca=
n do
>> is assume it doesn't know the interrupt state, and rely on solutions lik=
e
>> lockdep to complain if code within an interrupt context tries to perform=
 an
>> operation that would be unsound there like sleeping.
>>
>> This being said - I would be totally alright with us making it so that w=
e
>> assert that interrupts are still disabled upon dropping the token. But

We can't implement `Drop`, since it already implements `Copy`. But we
could add a debug assert before we call `local_irq_restore`. I think
it's a good idea to add a debug assert.

>> interrupts have to disabled throughout the entire closure regardless of =
the
>> presence of IrqDisabled. The same rules apply to C code using
>> local_irq_save()/local_irq_restore() - between those two function calls,=
 it is
>> always a bug to re-enable interrupts even if they get turned back off. U=
nsafe
>=20
> Do you mean the particular local_irq_save() and local_irq_restore(), or
> do you mean any interrupt disable critical sections? Note that we have
> wait_event_interruptible_locked_irq() which does exactly re-enabling
> interrupt in the middle to sleep and I'm pretty sure we have other cases
> where interrupts are re-enabled. So I'm not sure when you say "the same
> rules apply to C code ..."
>=20
>> functions are no exceptions, nor are C bindings, and should simply be
>> considered broken (not unsafe) if they violate this. I suppose that's
>> something else we could document if people think it's necessary.
>>
>>
>>> =09})
>>>
>>> note that `cb` is a `-> T` function, other than `-> (IrqDisabled<'a>,
>>> T)`, so semantically, it doesn't require IRQ still disabled after
>>> return.
>>
>> This was the reason I originally had us pass IrqDisabled as a reference =
and
>> not a value - specifically since it seemed to make more sense to treat
>> IrqDisabled as an object which exists throughout the lifetime of the clo=
sure
>> regardless of whether we drop our reference to it or not - since it's a =
no-op.
>>
>=20
> I haven't found a problem with `&IrqDisabled` as the closure parameter,
> but I may miss something.

We could also use `&'a IrqDisabled` instead of `IrqDisabled<'a>` (note
the first one doesn't have a lifetime). But there is no behavioral
difference between the two. Originally the intended API was to use `&'a
IrqDisabled<'a>` as the closure parameter and `IrqDisabled<'a>` in
functions that require irqs being disabled. As long as we decide on a
consistent type, I don't mind either (since then we can avoid
reborrowing).

> So the key ask from me is: it looks like we are on the same page that
> when `cb` returns, the IRQ should be in the same disabled state as when
> it gets called. So how do we express this "requirement" then? Type
> sytem, comments, safety comments?

I don't think that expressing this in the type system makes sense, since
the type that we select (`&'a IrqDisabled` or `IrqDisabled<'a>`) will be
`Copy`. And thus you can just produce as many of those as you want.

---
Cheers,
Benno


