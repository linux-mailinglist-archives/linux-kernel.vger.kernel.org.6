Return-Path: <linux-kernel+bounces-271735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A049452C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB66D1C22D44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AE51487F9;
	Thu,  1 Aug 2024 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="H1GgQwFZ"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6421E4A6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537273; cv=none; b=A0kSYqO9tm0DdJmMoK/749TtQgcS+1i3gUwJLB/6bsltWj2JxhJcLTrZAzWlsNzJbF+Xt33kvzcZdy4vovLbEumgIVkA2N1mpGsX+n+rnEHKJya+TgAM/dYpWmPwH+RbAbUtpNETn97E8eOdHZvUDk1drTh3mxh6gvlyTGVxinc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537273; c=relaxed/simple;
	bh=7tR7uU8C8V1R48q51+nmPkfNTligJoSIeKz1Y7QfQLc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkRHYuw4CLjYOfVYFWUAwMzpHATGdPWxBQQJm/4tkwloOf+UnySCmHvzw23PkHAPumD0jPMLanX1fjGSu/nNXosQeQl9yodWS/x9upkaXOjNOnewirlw3nWpcngoyv6FANy790w0ltieKFBjaZ6Td53OfvVvPnIyQPS/ZUO8FI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=H1GgQwFZ; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722537262; x=1722796462;
	bh=X0nPVtOydLuaFobnZaEPenFf+lze00gZVzjdM38Of0w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H1GgQwFZNjXkuS/bkqXvrX5upN/4Mwbi7qXv7e0/B0GZmPpEZLbv2CUblMz1sTCdM
	 hM100paSsjTlN13OTcR49WPieMi//PIFO5Cj+KgP8ORjcGS88hGoM4PUqyEgMvifQC
	 ojxE6dDmRYWkL2guBmHUL+Q0hG3UGL0XPKOgzA4VyU2mwiaArcAIYFKUMmsxmIjc+J
	 z6Ig1UaPsvaZjug0QA7NWx5f4GlN3hh7Iz6p4qcGoALHZGD3HNi+Lf3I9f9wQGaEKZ
	 wXJbNiV3aK7IYRX7r2/tnE4qNqEoe4O1V5wccivn5T12eKCyDXwgg+EGwggtZB/NQH
	 rjXEW5WAebf8A==
Date: Thu, 01 Aug 2024 18:34:17 +0000
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Aakash Sen Sharma <aakashsensharma@gmail.com>, Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: Introduce irq module
Message-ID: <461b5dc6-a286-418d-83b0-e7cb7fd7496a@proton.me>
In-Reply-To: <0b4b86d3a2b48466efa081e9076a351aaee6970d.camel@redhat.com>
References: <20240731224027.232642-1-lyude@redhat.com> <20240731224027.232642-2-lyude@redhat.com> <fadbccec-a51e-47ff-9c96-0aab043048c8@proton.me> <0b4b86d3a2b48466efa081e9076a351aaee6970d.camel@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9407c2d0ccc8698be61a806b6b9029868e40c83d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 18:44, Lyude Paul wrote:
> On Thu, 2024-08-01 at 09:51 +0000, Benno Lossin wrote:
>> On 01.08.24 00:35, Lyude Paul wrote:
>>> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
>>> new file mode 100644
>>> index 0000000000000..e50110f92f3fa
>>> --- /dev/null
>>> +++ b/rust/kernel/irq.rs
>>> @@ -0,0 +1,87 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! Interrupt controls
>>> +//!
>>> +//! This module allows Rust code to control processor interrupts. [`wi=
th_irqs_disabled()`] may be
>>> +//! used for nested disables of interrupts, whereas [`IrqDisabled`] ca=
n be used for annotating code
>>> +//! that requires that interrupts already be disabled.
>>
>> My intuition is telling me "requires that interrupts are already
>> disabled." sounds more natural, but I might be wrong.
>=20
> Maybe "can be used for annotating code that requires interrupts to be
> disabled."?

SGTM

>>> +
>>> +use bindings;
>>> +use core::marker::*;
>>> +
>>> +/// A token that is only available in contexts where IRQs are disabled=
.
>>> +///
>>> +/// [`IrqDisabled`] is marker made available when interrupts are not a=
ctive. Certain functions take
>>> +/// an `IrqDisabled` in order to indicate that they may only be run in=
 IRQ-free contexts.
>>> +///
>>> +/// This is a marker type; it has no size, and is simply used as a com=
pile-time guarantee that
>>> +/// interrupts are disabled where required.
>>> +///
>>> +/// This token can be created by [`with_irqs_disabled`]. See [`with_ir=
qs_disabled`] for examples and
>>> +/// further information.
>>> +#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
>>> +pub struct IrqDisabled<'a>(PhantomData<(&'a (), *mut ())>);
>>> +
>>> +impl IrqDisabled<'_> {
>>> +    /// Create a new [`IrqDisabled`] without disabling interrupts.
>>> +    ///
>>> +    /// This creates an [`IrqDisabled`] token, which can be passed to =
functions that must be run
>>> +    /// without interrupts. If debug assertions are enabled, this func=
tion will assert that
>>> +    /// interrupts are disabled upon creation. Otherwise, it has no si=
ze or cost at runtime.
>>> +    ///
>>> +    /// # Panics
>>> +    ///
>>> +    /// If debug assertions are enabled, this function will panic if i=
nterrupts are not disabled
>>> +    /// upon creation.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// This function must only be called in contexts where it is alre=
ady known that interrupts have
>>> +    /// been disabled for the current CPU, as the user is making a pro=
mise that they will remain
>>> +    /// disabled at least until this [`IrqDisabled`] is dropped.
>>
>> This is a bit verbose for taste, what about:
>> "Must only be called in contexts where interrupts are disabled for the
>> current CPU. Additionally they must remain disabled at least until the
>> returned value is dropped."
>=20
> sgtm
>=20
>>
>> Importantly the second sentence is not 100% clear from your version.
>> Feel free to take mine (with modifications).
>>
>>> +    pub unsafe fn new() -> Self {
>>
>> Do we need this to be public? Ie do you (or someone you know) have a
>> usecase for this? If not, then we can start with this function being
>> private and make it public when necessary.
>=20
> Yes - there's a few DRM callbacks, drm_crtc_funcs.{vblank_enable,
> vblank_disable, get_vblank_timestamp}, that happen with interrupts alread=
y
> disabled that will be using it:
>=20
> https://gitlab.freedesktop.org/lyudess/linux/-/blob/rvkms-example-0731202=
4/rust/kernel/drm/kms/vblank.rs?ref_type=3Dheads#L24
>=20
> It's also worth noting that if we weren't going to use this right away I =
think
> it would make more sense just to add the function later instead of having=
 it
> private, since we don't actually use this anywhere in irq.rs.

I didn't want the good docs you wrote go to waste :)
But since you have a usage, we can just keep it public.

>>> +        // SAFETY: FFI call with no special requirements
>>> +        debug_assert!(unsafe { bindings::irqs_disabled() });
>>> +
>>> +        Self(PhantomData)
>>> +    }
>>> +}
>>> +
>>> +/// Run the closure `cb` with interrupts disabled on the local CPU.
>>> +///
>>> +/// This creates an [`IrqDisabled`] token, which can be passed to func=
tions that must be run
>>> +/// without interrupts.
>>> +///
>>> +/// # Examples
>>> +///
>>> +/// Using [`with_irqs_disabled`] to call a function that can only be c=
alled with interrupts
>>> +/// disabled:
>>> +///
>>> +/// ```
>>> +/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
>>> +///
>>> +/// // Requiring interrupts be disabled to call a function
>>> +/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
>>> +///     /* When this token is available, IRQs are known to be disabled=
. Actions that rely on this
>>> +///      * can be safely performed
>>> +///      */
>>> +/// }
>>> +///
>>> +/// // Disabling interrupts. They'll be re-enabled once this closure c=
ompletes.
>>> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
>>> +/// ```
>>> +#[inline]
>>> +pub fn with_irqs_disabled<'a, T, F>(cb: F) -> T
>>> +where
>>> +    F: FnOnce(IrqDisabled<'a>) -> T,
>>
>> You can use this as the signature:
>>
>>     pub fn with_irqs_disabled<'a, T>(cb: impl FnOnce(IrqDisabled<'a>) ->=
 T) -> T
>>
>> Not sure if we have any convention for this, but I personally think this
>> version is easier to parse.
>=20
> sgtm

I hope that you saw my reply to myself, since what I wrote above is
unsound.

---
Cheers,
Benno


