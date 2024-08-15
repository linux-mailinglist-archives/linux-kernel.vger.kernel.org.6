Return-Path: <linux-kernel+bounces-287569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C95395296F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A64287074
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA12178383;
	Thu, 15 Aug 2024 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="W95hu87Z"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38381176FAE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704037; cv=none; b=X/WRY5jg6tE3xAUiRYmlOZ41pHMGWQNACUE0NDm7riaLRKMbj2Th3ZVUbspgtbOgVmMnoLeXytrQDe/QJk5obZAqhHwXiU7XUPIho3A3JRMYuO5ocB1mIVBiNYsqhXnxIWDEpWDs058S0QKS7K7LF/1tz/HXzCzsuu6tTzJ8wP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704037; c=relaxed/simple;
	bh=btVyO5gQo/KA6fR4kSWu222wz0/LfuumKfAIGpzzPRg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geqbJYrEVh4+iH2fbx7a59Lv4ORhbCHxN4y1Fm2DwOMKswbHLy64qmk508+He4KF/4fwRdZuyeSEOgKglKowu4Zs+f+txRIJy0n7iQU41pdgsIXqjZTg+2024cJbfkMXNUU+c6Gpmuqi7uzzKbWItMLsBgZufH9B9AyjA5ZFdK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=W95hu87Z; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723704032; x=1723963232;
	bh=JS43fM60RhDm+Th9MoEtNNKuKV29u1Ehm7PpXPr8fO8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W95hu87ZrFzIJKRWqy7jJGYtEoW0XwdV1CnQ1Mti26jwCs+JTKG/sqp5axXMQ4hUb
	 hTD74u4GPLku7uhSh6sIWl2Ik3XIGcIo2lfHrnncUYbwbXlw6q/Ist2VXoOOp3cRtd
	 w5swmtogjto4IplpVXSITimV2GUqtZpg3J/Kp8VkoLxuJk5ebwciDefgc/pLUPspkT
	 Vodt4I8TBq2TqGGn8Lg7HttJ+Z7bn8OMceUolzjewXmegH7dbMdjN8tf0nZEII3kiA
	 xlrol+93f/+cwEmNBA7ZAoy4SgaQn17JJhJyAyEVO3P7CNx9FTLK3r9xtsh36+2IL3
	 J7Uzxarcc132g==
Date: Thu, 15 Aug 2024 06:40:28 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Aakash Sen Sharma <aakashsensharma@gmail.com>, Valentin Obst <kernel@valentinobst.de>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/3] rust: Introduce irq module
Message-ID: <2b139d06-c0e0-4896-8747-d62499aec82f@proton.me>
In-Reply-To: <Zr2JryyeoZPn3JGC@boqun-archlinux>
References: <20240802001452.464985-1-lyude@redhat.com> <20240802001452.464985-2-lyude@redhat.com> <Zrzq8su-LhUIoavm@boqun-archlinux> <1bcae676ec4751ae137782c4ced8aad505ec1bb9.camel@redhat.com> <Zr0QyN8sQ6W2hPoJ@boqun-archlinux> <9855f198-858d-4e3f-9259-cd9111900c0c@proton.me> <Zr0aUwTqJXOxE-ju@boqun-archlinux> <Zr2JryyeoZPn3JGC@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 64c2b25ea9656e001ad16ddd492ff2aec8b43367
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 06:53, Boqun Feng wrote:
> On Wed, Aug 14, 2024 at 01:57:55PM -0700, Boqun Feng wrote:
>> On Wed, Aug 14, 2024 at 08:44:15PM +0000, Benno Lossin wrote:
>>> On 14.08.24 22:17, Boqun Feng wrote:
>>>> On Wed, Aug 14, 2024 at 03:38:47PM -0400, Lyude Paul wrote:
>>>>> On Wed, 2024-08-14 at 10:35 -0700, Boqun Feng wrote:
>>>>>> On Thu, Aug 01, 2024 at 08:10:00PM -0400, Lyude Paul wrote:
>>>>>> [...]
>>>>>>> +/// Run the closure `cb` with interrupts disabled on the local CPU=
.
>>>>>>> +///
>>>>>>> +/// This creates an [`IrqDisabled`] token, which can be passed to =
functions that must be run
>>>>>>> +/// without interrupts.
>>>>>>> +///
>>>>>>> +/// # Examples
>>>>>>> +///
>>>>>>> +/// Using [`with_irqs_disabled`] to call a function that can only =
be called with interrupts
>>>>>>> +/// disabled:
>>>>>>> +///
>>>>>>> +/// ```
>>>>>>> +/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
>>>>>>> +///
>>>>>>> +/// // Requiring interrupts be disabled to call a function
>>>>>>> +/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
>>>>>>> +///     /* When this token is available, IRQs are known to be disa=
bled. Actions that rely on this
>>>>>>> +///      * can be safely performed
>>>>>>> +///      */
>>>>>>> +/// }
>>>>>>> +///
>>>>>>> +/// // Disabling interrupts. They'll be re-enabled once this closu=
re completes.
>>>>>>> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
>>>>>>> +/// ```
>>>>>>> +#[inline]
>>>>>>> +pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'=
a>) -> T) -> T {
>>>>>>
>>>>>> Given the current signature, can `cb` return with interrupts enabled=
 (if
>>>>>> it re-enables interrupt itself)? For example:
>>>>>>
>>>>>> =09with_irqs_disabled(|irq_disabled| {
>>>>>>
>>>>>> =09    // maybe a unsafe function.
>>>>>> =09    reenable_irq(irq_disabled);
>>>>>
>>>>> JFYI: this wouldn't be unsafe, it would be broken code in all circums=
tances
>>>>> Simply put: `with_irqs_disabled()` does not provide the guarantee tha=
t
>>>>> interrupts were enabled previously, only that they're disabled now. A=
nd it is
>>>>> never a sound operation in C or Rust to ever enable interrupts withou=
t a
>>>>> matching disable in the same scope because that immediately risks a d=
eadlock
>>>>> or other undefined behavior. There's no usecase for this, I'd conside=
r any
>>>>> kind of function that returns with a different interrupt state then i=
t had
>>>>> upon being called to simply be broken.
>>>>>
>>>>> Also - like we previously mentioned, `IrqDisabled` is just a marker t=
ype. It
>>>>> doesn't enable or disable anything itself, the most it does is run a =
debug
>>>>
>>>> Yes, I know, but my question is more that should `cb` return a
>>>> `IrqDisabled` to prove the interrupt is still in the disabled state?
>>>> I.e. no matter what `cb` does, the interrupt remains disabled.
>>>
>>> What does this help with? I don't think this will add value (at least
>>> with how `IrqDisabled` is designed at the moment).
>>>
>>
>> I was trying to make sure that user shouldn't mess up with interrupt
>> state in the callback function, but as you mention below, type system
>> cannot help here.
>>
> [...]
>>>>
>>>> I haven't found a problem with `&IrqDisabled` as the closure parameter=
,
>>>> but I may miss something.
>>>
>>> We could also use `&'a IrqDisabled` instead of `IrqDisabled<'a>` (note
>>> the first one doesn't have a lifetime). But there is no behavioral
>>> difference between the two. Originally the intended API was to use `&'a
>>> IrqDisabled<'a>` as the closure parameter and `IrqDisabled<'a>` in
>>> functions that require irqs being disabled. As long as we decide on a
>>> consistent type, I don't mind either (since then we can avoid
>>> reborrowing).
>>>
>>>> So the key ask from me is: it looks like we are on the same page that
>>>> when `cb` returns, the IRQ should be in the same disabled state as whe=
n
>>>> it gets called. So how do we express this "requirement" then? Type
>>>> sytem, comments, safety comments?
>>>
>>> I don't think that expressing this in the type system makes sense, sinc=
e
>>> the type that we select (`&'a IrqDisabled` or `IrqDisabled<'a>`) will b=
e
>>> `Copy`. And thus you can just produce as many of those as you want.
>>>
>=20
> Hmm.. on a second thought, `Copy` doesn't affect what I'm proposing
> here, yes one could have as many `IrqDisabled<'a>` as one wants, but
> making `cb` returns a `(IrqDisabled<'a>, T)` means the `cb` has to prove
> at least one of the `IrqDisabled<'a>` exists, i.e. it must prove the irq
> is still disabled, which the requirement of `with_irqs_disabled`, right?

Yes, but that doesn't do anything. If the token is `Copy`, then we are
not allowed to have the following API:

    fn enable_irq(irq: IrqDisabled<'_>);

Since if the token is `Copy`, you can just copy it, call the function
and still return an `IrqDisabled<'a>` to satisfy the closure. It only
adds verbosity IMO.

> Or you're saying there could exist an `IrqDisabled<'a>` but the
> interrupts are enabled?

No.

---
Cheers,
Benno


