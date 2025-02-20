Return-Path: <linux-kernel+bounces-524759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4660A3E6C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD04D19C3DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63A1264F9E;
	Thu, 20 Feb 2025 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdxNSsVJ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB1264F84;
	Thu, 20 Feb 2025 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087473; cv=none; b=J99uZ4gwnIo4g2Eq4C3zLpOVvkcoQRDwPDICABMun/2VAIvkhSX7IdNgzpkglRs6+7k+j3Hjd7w8syo0zvEKg9dhcerTZ5MYE1Wsyh0pe27nULy5iLA3NWgCMPWOfCTEd8LQ2daW2KSGqupa+Rtc9mr804Y8ErBrZF6MoY4OxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087473; c=relaxed/simple;
	bh=ZMzUV7EagjYA+QnVxN3/s78mmN3Mb1SrscUo0Fe/3wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3NwwDp/kfNA5CnAY97mQx5oa7vD1VnWlvGo3ip4peNXIzTPNBmAof9PsfUGuo/0ony4it/E7JFrsmm8Ig85DbytbGPXQkITenn69uPZ36vATdUrO8weuqD3jpGbuNAOY4YMegOUAmB9887kKWZuB7MALEgfnBlBQ1IzadRyOUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdxNSsVJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a440effcfso25454031fa.0;
        Thu, 20 Feb 2025 13:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740087470; x=1740692270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/AHxN53omPCKDXXdtdccLlHfpgjy3pWDMb4ampTqog=;
        b=ZdxNSsVJ+e+3qyZ1LZBNzM5vIAsFfB3Ciar9H8NMvNxpKGb6w8DRIWV1qdOHTWB4Or
         h0FU1u5vV7gJWbEsG1o9proV3WxZ+HuS6IyHHrEBcinBW9aHGsJSs794ufrhWDgg2Qjq
         6g00Uzp0atSw6dQx0Av/xNp6vmlBPrGSUXh7CCobIIJ8/whicEEpBpWLvoJ1EswH8u+B
         wj24CydfVQ7hWygQ9qMsqBIeFYBrMr3Iy5q4Vq9+cq4t8d3n0arHW8NMzHkhN7u0xDd3
         pkZo8c6qKrnUkDWxXbfpr8FQ2xwzy8Wxgsq+4FXhnaOYlhAzU09Ngk/wYKz4LoWPuwIC
         fltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740087470; x=1740692270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/AHxN53omPCKDXXdtdccLlHfpgjy3pWDMb4ampTqog=;
        b=se+33muFYlAuM91aAB9jsnyHnYtCU63KJgM9IrfVcakOe1obgg3cZ3DUWIeK60pDyr
         zjYQv5UiAlvWsNQFu1MtF+Xhcyl6mFuso9feX241LifybW4Zhem68K5F/QLvepfSpjVl
         wvfvEWaI1l7XkTjlJpzZyzT7NIJ9MNy3GAompRx8JZWmcZs0UsuFBpL9IcqTy6Ho+Tfq
         9sxO01tLlmE7XONwtDmgWRBBBi2pfsc2U6CsECBhz5wJXDK4Njh+o5J6ZgDpJBu8a5OC
         1FkH/90YVa7sb9FgT/gyJIpz4L4mCMOV1DNZY8WjR2pWjgSPyP7/IlXa2xH4/rsbbZAq
         swvg==
X-Forwarded-Encrypted: i=1; AJvYcCWQD6myUk2PcfSCg6buxSN+g9In9s7VATP0fKJ15OIC8YbWuXAA5fd4xMj+7CYkpM/TJIhgt8P+1ZZuqnI=@vger.kernel.org, AJvYcCWZ584yMhl/lIl8iq84n4LHmy4NN0oASn2B7ZeNDP4BKFrKsN3PyHlLAlg6BTrASQGJEYw5aGuDIpJOmoBDHDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGgqnkogAChiUzBbv/0K+lsWkvXTtv6febHa/s4UgIxmCmTat
	m/2+7ZADi2Zc4xNw1YyAg06Clp6rU6yGK+IsHAoIm4/MmEIvT+9p0XUzuayAvllWWPZTDuYDm+I
	Hm5TaQnj1v/Zq3ReO6Ab+a4IaBW0=
X-Gm-Gg: ASbGncs1QUrEgiQMXABCSvdSxjnc/shpKkE6nQx3+6KTvGwP7c/Li7C2+VbX4MPByAE
	GsXZ2KoeD6GPfC7V0HwQVZ5f6Hbxrfe8ssIwwTQjST8RuwfJeHFMMkRRVuYZX6qY6BYVk+Jqr7/
	+GrsljHZntHHyv
X-Google-Smtp-Source: AGHT+IHdSCDkdxH6Hph3vQPQOkkb7o/CwxydrLmfjQec6aN1CpZ6Znom9bkSkM5L8ajHu6+nL2LCTH97mNKWdeuMMoY=
X-Received: by 2002:a2e:3c14:0:b0:309:2999:77d4 with SMTP id
 38308e7fff4ca-30a505d863cmr18037481fa.6.1740087469451; Thu, 20 Feb 2025
 13:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
 <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
 <KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
 <CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com> <87wmdkgvr0.fsf@kernel.org>
In-Reply-To: <87wmdkgvr0.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 20 Feb 2025 16:37:13 -0500
X-Gm-Features: AWEUYZliI_VrX4T85KKg7MveWeq-OsXOuwjUJx6sq2N3HSgYQwiWJGGDJMDmzvU
Message-ID: <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:19=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > On Tue, Feb 18, 2025 at 8:29=E2=80=AFAM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
> >>
>
> [...]
>
> >> +//! ## State Diagram
> >> +//!
> >> +//! ```text
> >> +//!                  <-- Stop ----
> >> +//!                  <-- Cancel --
> >> +//!                  --- Start -->
> >> +//!        +---------+        +---------+
> >> +//!   O--->| Stopped |        | Running |---o
> >> +//!        +---------+        +---------+   |
> >> +//!                                  ^      |
> >> +//!                  <- Expire --    |      |
> >> +//!                                  o------o
> >> +//!                                   Restart
> >> +//! ```
> >> +//!
> >> +//! A timer is initialized in the **stopped** state. A stopped timer =
can be
> >> +//! **started** with an **expiry** time. After the timer is started, =
it is
> >> +//! **running**. When the timer **expires**, the timer handler is exe=
cuted.
> >> +//! After the handler has executed, the timer may be **restarted** or
> >> +//! **stopped**. A running timer can be **canceled** before it's hand=
ler is
> >
> > "it's" =3D it is. This should be "its" (possessive).
>
> Thanks =F0=9F=91=8D
>
> > Just to be clear, after the handler has executed and before the timer
> > has been **restarted** or **stopped** the timer is still in the
> > **running** state?
>
> It depends on the return value of the handler. If the handler returns res=
tart,
> the timer the timer does not enter the stopped state. If the handler
> returns stop, the timer enters the stopped state.
>
> The timer is still considered to be in running state the handler is
> running.
>
> I can add this info to the section.

Yeah, some clarification here would be useful.

> >
> >
> >> +//! executed. A timer that is cancelled enters the **stopped** state.
> >> +//!
> >> +
> >> +use crate::{init::PinInit, prelude::*, time::Ktime, types::Opaque};
> >> +use core::marker::PhantomData;
> >> +
> >> +/// A timer backed by a C `struct hrtimer`.
> >> +///
> >> +/// # Invariants
> >> +///
> >> +/// * `self.timer` is initialized by `bindings::hrtimer_setup`.
> >> +#[pin_data]
> >> +#[repr(C)]
> >> +pub struct HrTimer<T> {
> >> +    #[pin]
> >> +    timer: Opaque<bindings::hrtimer>,
> >> +    _t: PhantomData<T>,
> >> +}
> >> +
> >> +// SAFETY: Ownership of an `HrTimer` can be moved to other threads an=
d
> >> +// used/dropped from there.
> >> +unsafe impl<T> Send for HrTimer<T> {}
> >> +
> >> +// SAFETY: Timer operations are locked on C side, so it is safe to op=
erate on a
> >> +// timer from multiple threads
> >> +unsafe impl<T> Sync for HrTimer<T> {}
> >> +
> >> +impl<T> HrTimer<T> {
> >> +    /// Return an initializer for a new timer instance.
> >> +    pub fn new() -> impl PinInit<Self>
> >> +    where
> >> +        T: HrTimerCallback,
> >> +    {
> >> +        pin_init!(Self {
> >> +            // INVARIANTS: We initialize `timer` with `hrtimer_setup`=
 below.
> >> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrt=
imer| {
> >> +                // SAFETY: By design of `pin_init!`, `place` is a poi=
nter to a
> >> +                // live allocation. hrtimer_setup will initialize `pl=
ace` and
> >> +                // does not require `place` to be initialized prior t=
o the call.
> >> +                unsafe {
> >> +                    bindings::hrtimer_setup(
> >> +                        place,
> >> +                        Some(T::CallbackTarget::run),
> >> +                        bindings::CLOCK_MONOTONIC as i32,
> >> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
> >> +                    );
> >> +                }
> >> +            }),
> >> +            _t: PhantomData,
> >> +        })
> >> +    }
> >> +
> >> +    /// Get a pointer to the contained `bindings::hrtimer`.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// `ptr` must point to a live allocation of at least the size of=
 `Self`.
> >> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
> >> +        // SAFETY: The field projection to `timer` does not go out of=
 bounds,
> >> +        // because the caller of this function promises that `ptr` po=
ints to an
> >> +        // allocation of at least the size of `Self`.
> >> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer)) }
> >> +    }
> >
> > Can you help me understand why the various functions here operate on
> > *const Self? I understand the need to obtain a C pointer to interact
> > with bindings, but I don't understand why we're dealing in raw
> > pointers to the abstraction rather than references.
>
> We cannot reference the `bindings::hrtimer` without wrapping it in
> `Opaque`. This would be the primary reason. At other times, we cannot
> produce references because we might not be able to prove that we satisfy
> the safety requirements for turning a pointer into a reference. If we
> are just doing offset arithmetic anyway, we don't need a reference.

Why do we have a pointer, rather than a reference, to Self in the
first place? I think this is the key thing I don't understand.

>
>
> > This extends to
> > HrTimerPointer, which is intended to be implemented by *pointers to*
> > structs that embed `HrTimer`; why isn't it implemented on by the
> > embedder itself?
>
> Not sure what you mean here. If you refer to for instance the
> implementation of `HrTimerPointer for Arc<T>`, I get why you might
> wonder, why does `HasHrTimer::start` not take a reference instead of a
> pointer? We could do that, but we would just immediately break it down
> again in the implementation of `HasHrTimer::start`. Might still be a
> good idea though.

I was trying to say that my question (which I clarified above,
hopefully) extends to the description and name of this trait.
Specifically for this trait I don't understand why its semantics are
described in terms of pointers rather than references (and AsRef, to
allow for Arc and friends).

> >
> > I realize we discussed this on v6, sorry for not keeping up there.
>
> No worries, it is good that we discuss this.
>
> [...]
>
> >> +
> >> +/// A handle representing a potentially running timer.
> >> +///
> >> +/// More than one handle representing the same timer might exist.
> >> +///
> >> +/// # Safety
> >> +///
> >> +/// When dropped, the timer represented by this handle must be cancel=
led, if it
> >> +/// is running. If the timer handler is running when the handle is dr=
opped, the
> >> +/// drop method must wait for the handler to finish before returning.
> >
> > Between this comment and the comment on cancel we say "if it is
> > running" 3 times. Can we say it just once, on the method, and here say
> > that cancel must be called in Drop?
>
> Well, the comment on `cancel` is just a description of what the function
> does. This piece of text is a safety requirement.
>
> We could make the safety requirement for implementing the trait "Implemen=
t
> the methods according to their documentation". But that would not help wi=
th
> the drop requirement.

My suggestion is that the safety comment read: when dropped,
[Self::cancel] must be called. Something like that.

>
> >
> >> +pub unsafe trait HrTimerHandle {
> >> +    /// Cancel the timer, if it is running. If the timer handler is r=
unning, block
> >> +    /// till the handler has finished.
> >> +    fn cancel(&mut self) -> bool;
> >> +}
> >> +
> >> +/// Implemented by structs that contain timer nodes.
> >> +///
> >> +/// Clients of the timer API would usually safely implement this trai=
t by using
> >> +/// the [`crate::impl_has_hr_timer`] macro.
> >> +///
> >> +/// # Safety
> >> +///
> >> +/// Implementers of this trait must ensure that the implementer has a=
 [`HrTimer`]
> >> +/// field at the offset specified by `OFFSET` and that all trait meth=
ods are
> >> +/// implemented according to their documentation.
> >> +///
> >> +/// [`impl_has_timer`]: crate::impl_has_timer
> >> +pub unsafe trait HasHrTimer<T> {
> >> +    /// Offset of the [`HrTimer`] field within `Self`
> >> +    const OFFSET: usize;
> >
> > Does this need to be part of the trait? As an alternative the provided
> > methods could be generated in the macro below and reduce the
> > opportunity to implement this trait incorrectly.
>
> There is no risk of implementing the trait wrong, because it is usually
> derived by a macro.

There's no risk when it's implemented by the macro, but you used the
word usually,  which means there is a risk.

> We need at least one of the methods to be able to have the type system
> verify that the type for which we implement `HasHrTImer` actually has a
> field with the name we specify, and that this field has the right type.
> And to have that, we need the OFFSET.

I don't follow this logic. OFFSET is calculated in the body of the
macro. I'm suggesting that the macro generate the method
implementations (which would no longer be provided). In effect I'm
saying: keep OFFSET private.

I'm also noticing now that the macro generates an implementation of
raw_get_timer *in addition to* the provided implementation. Why are
both needed?

>
>
>
> Best regards,
> Andreas Hindborg
>
>

