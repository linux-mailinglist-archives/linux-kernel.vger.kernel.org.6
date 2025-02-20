Return-Path: <linux-kernel+bounces-524736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC11A3E67A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9AB189F3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549B81EE001;
	Thu, 20 Feb 2025 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuLc+8Wo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FAE1D54D1;
	Thu, 20 Feb 2025 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086350; cv=none; b=LXJb7sQ6rfakMCfym+qn1IGFpLZBdj7Pv/mLF7r3YYCajABy6H8o63d439qLHig1s5r/8U4yPIqP+flYAzhPK6tqHRGnmlnMx7NQYuGFd2P3BPnq8YTUt/D9qeYj5wgIu0oK0l/MRpZoXIQt3aaqLWxGq8ERD/C7CIQDhO9Rl/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086350; c=relaxed/simple;
	bh=uoOMnodQ4Ci7A6GqubZ3v3byPCrusiTbmbos5sLMOZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pws3dwJhZbO9P9XJBPxMsic4LRjSm1kABxQFpI8btHel9cx9NtiojmlkzxMFlKh4GDkkBQRewZ+KZVS4UW9ShBexx6+COONYgbSvfXDD4bhP7bMAmub71QS4wVzfBPVnbJsytuj6H4HOJNry+4zXuwTX+Wv/jfqGaBZt75vpMPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuLc+8Wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB90C4CED1;
	Thu, 20 Feb 2025 21:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740086350;
	bh=uoOMnodQ4Ci7A6GqubZ3v3byPCrusiTbmbos5sLMOZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LuLc+8WozM5j7JeVycSXrkgTXL3eeLPquUfkOOFMk10cWdNpryahqiwDBzigrbP23
	 o35hM60CJVHBhk7Q1/3xhB4lDrZbnIKDRhNMFZP2rt9kdiMSR7j16VNCaqYba58IM3
	 oEjDB2tJ6sTM8jZWEG6ukGkthPisrTIKaN+vcv0EeVIlAoGlqL16orYdX9lX7afZ2W
	 URaCsC8Lr08we/rBIHvENCojvb0EDoDCluExcOOR2FOm38ke+fN5pqN7aR9PHInl8v
	 ZdaHxThiLRRrgfwrJvcqhftRnZWwhVuBB2QsUxmEQdnTe88hHZp2avzfl9DmuwvC+W
	 L7uhxGDkFpnXQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Lyude Paul" <lyude@redhat.com>,  "Guangbo Cui" <2407018371@qq.com>,
  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
In-Reply-To: <CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
 (Tamir
	Duberstein's message of "Thu, 20 Feb 2025 12:04:29 -0500")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
	<KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
	<CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 20 Feb 2025 22:18:59 +0100
Message-ID: <87wmdkgvr0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> On Tue, Feb 18, 2025 at 8:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>

[...]

>> +//! ## State Diagram
>> +//!
>> +//! ```text
>> +//!                  <-- Stop ----
>> +//!                  <-- Cancel --
>> +//!                  --- Start -->
>> +//!        +---------+        +---------+
>> +//!   O--->| Stopped |        | Running |---o
>> +//!        +---------+        +---------+   |
>> +//!                                  ^      |
>> +//!                  <- Expire --    |      |
>> +//!                                  o------o
>> +//!                                   Restart
>> +//! ```
>> +//!
>> +//! A timer is initialized in the **stopped** state. A stopped timer ca=
n be
>> +//! **started** with an **expiry** time. After the timer is started, it=
 is
>> +//! **running**. When the timer **expires**, the timer handler is execu=
ted.
>> +//! After the handler has executed, the timer may be **restarted** or
>> +//! **stopped**. A running timer can be **canceled** before it's handle=
r is
>
> "it's" =3D it is. This should be "its" (possessive).

Thanks =F0=9F=91=8D

> Just to be clear, after the handler has executed and before the timer
> has been **restarted** or **stopped** the timer is still in the
> **running** state?

It depends on the return value of the handler. If the handler returns resta=
rt,
the timer the timer does not enter the stopped state. If the handler
returns stop, the timer enters the stopped state.

The timer is still considered to be in running state the handler is
running.

I can add this info to the section.

>
>
>> +//! executed. A timer that is cancelled enters the **stopped** state.
>> +//!
>> +
>> +use crate::{init::PinInit, prelude::*, time::Ktime, types::Opaque};
>> +use core::marker::PhantomData;
>> +
>> +/// A timer backed by a C `struct hrtimer`.
>> +///
>> +/// # Invariants
>> +///
>> +/// * `self.timer` is initialized by `bindings::hrtimer_setup`.
>> +#[pin_data]
>> +#[repr(C)]
>> +pub struct HrTimer<T> {
>> +    #[pin]
>> +    timer: Opaque<bindings::hrtimer>,
>> +    _t: PhantomData<T>,
>> +}
>> +
>> +// SAFETY: Ownership of an `HrTimer` can be moved to other threads and
>> +// used/dropped from there.
>> +unsafe impl<T> Send for HrTimer<T> {}
>> +
>> +// SAFETY: Timer operations are locked on C side, so it is safe to oper=
ate on a
>> +// timer from multiple threads
>> +unsafe impl<T> Sync for HrTimer<T> {}
>> +
>> +impl<T> HrTimer<T> {
>> +    /// Return an initializer for a new timer instance.
>> +    pub fn new() -> impl PinInit<Self>
>> +    where
>> +        T: HrTimerCallback,
>> +    {
>> +        pin_init!(Self {
>> +            // INVARIANTS: We initialize `timer` with `hrtimer_setup` b=
elow.
>> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtim=
er| {
>> +                // SAFETY: By design of `pin_init!`, `place` is a point=
er to a
>> +                // live allocation. hrtimer_setup will initialize `plac=
e` and
>> +                // does not require `place` to be initialized prior to =
the call.
>> +                unsafe {
>> +                    bindings::hrtimer_setup(
>> +                        place,
>> +                        Some(T::CallbackTarget::run),
>> +                        bindings::CLOCK_MONOTONIC as i32,
>> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
>> +                    );
>> +                }
>> +            }),
>> +            _t: PhantomData,
>> +        })
>> +    }
>> +
>> +    /// Get a pointer to the contained `bindings::hrtimer`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `ptr` must point to a live allocation of at least the size of `=
Self`.
>> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
>> +        // SAFETY: The field projection to `timer` does not go out of b=
ounds,
>> +        // because the caller of this function promises that `ptr` poin=
ts to an
>> +        // allocation of at least the size of `Self`.
>> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer)) }
>> +    }
>
> Can you help me understand why the various functions here operate on
> *const Self? I understand the need to obtain a C pointer to interact
> with bindings, but I don't understand why we're dealing in raw
> pointers to the abstraction rather than references.

We cannot reference the `bindings::hrtimer` without wrapping it in
`Opaque`. This would be the primary reason. At other times, we cannot
produce references because we might not be able to prove that we satisfy
the safety requirements for turning a pointer into a reference. If we
are just doing offset arithmetic anyway, we don't need a reference.


> This extends to
> HrTimerPointer, which is intended to be implemented by *pointers to*
> structs that embed `HrTimer`; why isn't it implemented on by the
> embedder itself?

Not sure what you mean here. If you refer to for instance the
implementation of `HrTimerPointer for Arc<T>`, I get why you might
wonder, why does `HasHrTimer::start` not take a reference instead of a
pointer? We could do that, but we would just immediately break it down
again in the implementation of `HasHrTimer::start`. Might still be a
good idea though.

>
> I realize we discussed this on v6, sorry for not keeping up there.

No worries, it is good that we discuss this.

[...]

>> +
>> +/// A handle representing a potentially running timer.
>> +///
>> +/// More than one handle representing the same timer might exist.
>> +///
>> +/// # Safety
>> +///
>> +/// When dropped, the timer represented by this handle must be cancelle=
d, if it
>> +/// is running. If the timer handler is running when the handle is drop=
ped, the
>> +/// drop method must wait for the handler to finish before returning.
>
> Between this comment and the comment on cancel we say "if it is
> running" 3 times. Can we say it just once, on the method, and here say
> that cancel must be called in Drop?

Well, the comment on `cancel` is just a description of what the function
does. This piece of text is a safety requirement.

We could make the safety requirement for implementing the trait "Implement
the methods according to their documentation". But that would not help with
the drop requirement.

>
>> +pub unsafe trait HrTimerHandle {
>> +    /// Cancel the timer, if it is running. If the timer handler is run=
ning, block
>> +    /// till the handler has finished.
>> +    fn cancel(&mut self) -> bool;
>> +}
>> +
>> +/// Implemented by structs that contain timer nodes.
>> +///
>> +/// Clients of the timer API would usually safely implement this trait =
by using
>> +/// the [`crate::impl_has_hr_timer`] macro.
>> +///
>> +/// # Safety
>> +///
>> +/// Implementers of this trait must ensure that the implementer has a [=
`HrTimer`]
>> +/// field at the offset specified by `OFFSET` and that all trait method=
s are
>> +/// implemented according to their documentation.
>> +///
>> +/// [`impl_has_timer`]: crate::impl_has_timer
>> +pub unsafe trait HasHrTimer<T> {
>> +    /// Offset of the [`HrTimer`] field within `Self`
>> +    const OFFSET: usize;
>
> Does this need to be part of the trait? As an alternative the provided
> methods could be generated in the macro below and reduce the
> opportunity to implement this trait incorrectly.

There is no risk of implementing the trait wrong, because it is usually
derived by a macro.

We need at least one of the methods to be able to have the type system
verify that the type for which we implement `HasHrTImer` actually has a
field with the name we specify, and that this field has the right type.
And to have that, we need the OFFSET.



Best regards,
Andreas Hindborg



