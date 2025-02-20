Return-Path: <linux-kernel+bounces-524323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058CDA3E1C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCB5176CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE10212B15;
	Thu, 20 Feb 2025 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdnmNJqT"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81C5212B0A;
	Thu, 20 Feb 2025 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071111; cv=none; b=IMWTykFWt4PGQfOHl/aO1PV22lnFrHZcrE3SK7nRFm3tbRlcOcvE4wfVcG2dPJn+OLqEyuxK6v+IXlZJpQELFwCHllBOvwnvwdM8lXgVN1RNjyq/j9fwHMdUpGfR1LWR780L3imu5N28iXm5gKFX3mcR5bfC6U9NAir6SZibEdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071111; c=relaxed/simple;
	bh=lELVnAQcgzEFa/YbKH0F9fs23sdBMKYoXwEioyu65Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wwxc364yEVKN8Q63vR9IS17Xm/d43JLNf1OcfbiROyqi+5rQ5I4KF/bIPDe0LXvkoYQwNoR60D/BKT9FGg5s44vVWnxL0FL68fYDvqi/0qwdPpDGayk+WHLkNZIgWkJFtPsYSChkawWwWE1nsSw4qRSR0xZQH87Uy052Vs4+1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdnmNJqT; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-543e47e93a3so1430174e87.2;
        Thu, 20 Feb 2025 09:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740071107; x=1740675907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciHSX2e1RzEuIlSFeHdrZNaxDBPdrWX6mpLIUoF0eIM=;
        b=BdnmNJqTbfeqGlkvWJB2xbEYd0kx63mA2fyldt1cpUhhPgkALem1am96lT+NjSqOl+
         zvIj5XcPwjXtNwnc+UNQjMDHnK2xqJV+bzkZpzqi6BcXR4KIJgp6yVdM8FDVXC+m+kV7
         ucbsZNAQ5HqkWZiQIKaJfgvZLsYf2sWOU+P0/Au69JJz3/l9hNFasXpCtJQOOfBMaZ8u
         9TrpaSKuujTI5BueLOKqforH4QJLVtb6w1Dm56ZR1eOSgwhvhGmSP41CVZzwfB+WOs40
         DTcnPVZNXC+kLd9rhwsq1bB9FB2rvqq7VCTEPaADUqQMzflWn6vVTBDjhaCuoTcFGMcq
         xkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740071107; x=1740675907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciHSX2e1RzEuIlSFeHdrZNaxDBPdrWX6mpLIUoF0eIM=;
        b=BXo0fpal/x1v0q0XQR6D0xj3GH/xJaX2dkX09peFJp4GOCz0rgSVlH9OBf6cC5qJMi
         InduRgXft+rjiS8nhIAAANQO3Sgs5Kyg/vrp2dcEeHR03Pp2qeA/gOzIRYrTJuY9qcOI
         u3GovyeyjWyFOfFQyEMNss7LVAeE5QbBYOtllL3nQRQNeOkm8yrLwSLzrU/adyJChOFl
         cshrsWLI2CXWD7WdvnexeWiuvDXk7uNzuooGDEk2ftfAqfIrOvO3ROqdToZbeVAuRiyh
         pUr0bCCFyNJ6sFnN+oQAxEtPPULFOVxXbVbaS0FVIrwkln2vN8R18Kssbc6OaSbaWRXA
         Waqw==
X-Forwarded-Encrypted: i=1; AJvYcCW9xkt4Vb4XlhebZbHq97t7eWEnS6W53jQ0kHnTsCDkptZUwIpK6/Evo/pV0uY9J9wdS2VcCjfglCD7JI4=@vger.kernel.org, AJvYcCXDc58au1qqxN1RWF2GY28YH/Xt4I+hXFRFep6w6sElTHY6o49Lr79tl7b6I8kn1T08h4pQ/zZrhjdqVL74psU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7enZ3Z4A4nqvMgFNQhegw+8TqXzeFBZQnW515pJqNKRgqghD6
	RXhRh55idZDuff3hLyXa6uZ0RNrCK+9YFd3+Xbf7LKtxaGMveJ9aG+FLggCcAF6/CdWVRpFwwPu
	rJJiS1TuN1AldbZda0NUqxZAF8uI=
X-Gm-Gg: ASbGnct1enf1P2RGDiYdDl9E2lassiYDe5yRQivIa32ZFHFoaEY5gOcT8GRnByF7PFs
	w//jqTSFAESAr2eQDqwXYfDI2sqKkI8MQbhY3dUPg468msVx+v8/aYq8X3P26SxPV90xasSp3WG
	Wrs+5/PW71A3mF
X-Google-Smtp-Source: AGHT+IGvskYac57SEuftdBv8ie0PbM1gsS3CqgSgY9CzEEgmC32+5ZUoz3s/Ng/lgizyr6+1BDcAZvzqv6StrG2UWXo=
X-Received: by 2002:a05:6512:110b:b0:545:23bb:23f4 with SMTP id
 2adb3069b0e04-5452fe271ccmr7580938e87.8.1740071106592; Thu, 20 Feb 2025
 09:05:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 20 Feb 2025 12:04:29 -0500
X-Gm-Features: AWEUYZl15gaLfRMPxJZ7BxVAJmMSfdWYMLaKgF6ZiZXNrvzDOWM-cGbdNC2q4mw
Message-ID: <CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
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

On Tue, Feb 18, 2025 at 8:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> This patch adds support for intrusive use of the hrtimer system. For now,
> only one timer can be embedded in a Rust struct.
>
> The hrtimer Rust API is based on the intrusive style pattern introduced b=
y
> the Rust workqueue API.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time.rs         |   2 +
>  rust/kernel/time/hrtimer.rs | 312 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 314 insertions(+)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 87e47f2f5618d..2cf365cfb412e 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -10,6 +10,8 @@
>
>  use core::convert::Into;
>
> +pub mod hrtimer;
> +
>  /// The number of nanoseconds per millisecond.
>  pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> new file mode 100644
> index 0000000000000..a6332924efabd
> --- /dev/null
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -0,0 +1,312 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Intrusive high resolution timers.
> +//!
> +//! Allows running timer callbacks without doing allocations at the time=
 of
> +//! starting the timer. For now, only one timer per type is allowed.
> +//!
> +//! # Vocabulary
> +//!
> +//! States:
> +//!
> +//! * Stopped
> +//! * Running
> +//!
> +//! Operations:
> +//!
> +//! * Start
> +//! * Cancel
> +//! * Stop
> +//! * Restart
> +//!
> +//! Events:
> +//!
> +//! * Expire
> +//!
> +//! ## State Diagram
> +//!
> +//! ```text
> +//!                  <-- Stop ----
> +//!                  <-- Cancel --
> +//!                  --- Start -->
> +//!        +---------+        +---------+
> +//!   O--->| Stopped |        | Running |---o
> +//!        +---------+        +---------+   |
> +//!                                  ^      |
> +//!                  <- Expire --    |      |
> +//!                                  o------o
> +//!                                   Restart
> +//! ```
> +//!
> +//! A timer is initialized in the **stopped** state. A stopped timer can=
 be
> +//! **started** with an **expiry** time. After the timer is started, it =
is
> +//! **running**. When the timer **expires**, the timer handler is execut=
ed.
> +//! After the handler has executed, the timer may be **restarted** or
> +//! **stopped**. A running timer can be **canceled** before it's handler=
 is

"it's" =3D it is. This should be "its" (possessive).

Just to be clear, after the handler has executed and before the timer
has been **restarted** or **stopped** the timer is still in the
**running** state?


> +//! executed. A timer that is cancelled enters the **stopped** state.
> +//!
> +
> +use crate::{init::PinInit, prelude::*, time::Ktime, types::Opaque};
> +use core::marker::PhantomData;
> +
> +/// A timer backed by a C `struct hrtimer`.
> +///
> +/// # Invariants
> +///
> +/// * `self.timer` is initialized by `bindings::hrtimer_setup`.
> +#[pin_data]
> +#[repr(C)]
> +pub struct HrTimer<T> {
> +    #[pin]
> +    timer: Opaque<bindings::hrtimer>,
> +    _t: PhantomData<T>,
> +}
> +
> +// SAFETY: Ownership of an `HrTimer` can be moved to other threads and
> +// used/dropped from there.
> +unsafe impl<T> Send for HrTimer<T> {}
> +
> +// SAFETY: Timer operations are locked on C side, so it is safe to opera=
te on a
> +// timer from multiple threads
> +unsafe impl<T> Sync for HrTimer<T> {}
> +
> +impl<T> HrTimer<T> {
> +    /// Return an initializer for a new timer instance.
> +    pub fn new() -> impl PinInit<Self>
> +    where
> +        T: HrTimerCallback,
> +    {
> +        pin_init!(Self {
> +            // INVARIANTS: We initialize `timer` with `hrtimer_setup` be=
low.
> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtime=
r| {
> +                // SAFETY: By design of `pin_init!`, `place` is a pointe=
r to a
> +                // live allocation. hrtimer_setup will initialize `place=
` and
> +                // does not require `place` to be initialized prior to t=
he call.
> +                unsafe {
> +                    bindings::hrtimer_setup(
> +                        place,
> +                        Some(T::CallbackTarget::run),
> +                        bindings::CLOCK_MONOTONIC as i32,
> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
> +                    );
> +                }
> +            }),
> +            _t: PhantomData,
> +        })
> +    }
> +
> +    /// Get a pointer to the contained `bindings::hrtimer`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to a live allocation of at least the size of `S=
elf`.
> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
> +        // SAFETY: The field projection to `timer` does not go out of bo=
unds,
> +        // because the caller of this function promises that `ptr` point=
s to an
> +        // allocation of at least the size of `Self`.
> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer)) }
> +    }

Can you help me understand why the various functions here operate on
*const Self? I understand the need to obtain a C pointer to interact
with bindings, but I don't understand why we're dealing in raw
pointers to the abstraction rather than references. This extends to
HrTimerPointer, which is intended to be implemented by *pointers to*
structs that embed `HrTimer`; why isn't it implemented on by the
embedder itself?

I realize we discussed this on v6, sorry for not keeping up there.

> +
> +    /// Cancel an initialized and potentially running timer.
> +    ///
> +    /// If the timer handler is running, this will block until the handl=
er is
> +    /// finished.
> +    ///
> +    /// Users of the `HrTimer` API would not usually call this method di=
rectly.
> +    /// Instead they would use the safe `cancel` method on the [`HrTimer=
Handle`]
> +    /// returned when the timer was started.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `self_ptr` must point to a valid `Self`.
> +    #[allow(dead_code)]
> +    pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
> +        // SAFETY: timer_ptr points to an allocation of at least `HrTime=
r` size.
> +        let c_timer_ptr =3D unsafe { HrTimer::raw_get(self_ptr) };
> +
> +        // If the handler is running, this will wait for the handler to =
finish
> +        // before returning.
> +        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronizati=
on is
> +        // handled on C side.
> +        unsafe { bindings::hrtimer_cancel(c_timer_ptr) !=3D 0 }
> +    }
> +}
> +
> +/// Implemented by pointer types that point to structs that embed a [`Hr=
Timer`].
> +///
> +/// Target (pointee) must be [`Sync`] because timer callbacks happen in =
another
> +/// thread of execution (hard or soft interrupt context).
> +///
> +/// Starting a timer returns a [`HrTimerHandle`] that can be used to man=
ipulate
> +/// the timer. Note that it is OK to call the start function repeatedly,=
 and
> +/// that more than one [`HrTimerHandle`] associated with a [`HrTimerPoin=
ter`] may
> +/// exist. A timer can be manipulated through any of the handles, and a =
handle
> +/// may represent a cancelled timer.
> +pub trait HrTimerPointer: Sync + Sized {
> +    /// A handle representing a started or restarted timer.
> +    ///
> +    /// If the timer is running or if the timer callback is executing wh=
en the
> +    /// handle is dropped, the drop method of [`HrTimerHandle`] should n=
ot return
> +    /// until the timer is stopped and the callback has completed.
> +    ///
> +    /// Note: When implementing this trait, consider that it is not unsa=
fe to
> +    /// leak the handle.
> +    type TimerHandle: HrTimerHandle;
> +
> +    /// Start the timer with expiry after `expires` time units. If the t=
imer was
> +    /// already running, it is restarted with the new expiry time.
> +    fn start(self, expires: Ktime) -> Self::TimerHandle;
> +}
> +
> +/// Implemented by [`HrTimerPointer`] implementers to give the C timer c=
allback a
> +/// function to call.
> +// This is split from `HrTimerPointer` to make it easier to specify trai=
t bounds.
> +pub trait RawHrTimerCallback {
> +    /// Callback to be called from C when timer fires.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Only to be called by C code in `hrtimer` subsystem. `ptr` must p=
oint to
> +    /// the `bindings::hrtimer` structure that was used to start the tim=
er.
> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::h=
rtimer_restart;
> +}
> +
> +/// Implemented by structs that can be the target of a timer callback.
> +pub trait HrTimerCallback {
> +    /// The type whose [`RawHrTimerCallback::run`] method will be invoke=
d when
> +    /// the timer expires.
> +    type CallbackTarget<'a>: RawHrTimerCallback;
> +
> +    /// This type is passed to the timer callback function. It may be a =
borrow
> +    /// of [`Self::CallbackTarget`], or it may be `Self::CallbackTarget`=
 if the
> +    /// implementation can guarantee exclusive access to the target duri=
ng timer
> +    /// handler execution.
> +    type CallbackTargetParameter<'a>;
> +
> +    /// Called by the timer logic when the timer fires.
> +    fn run(this: Self::CallbackTargetParameter<'_>)
> +    where
> +        Self: Sized;
> +}
> +
> +/// A handle representing a potentially running timer.
> +///
> +/// More than one handle representing the same timer might exist.
> +///
> +/// # Safety
> +///
> +/// When dropped, the timer represented by this handle must be cancelled=
, if it
> +/// is running. If the timer handler is running when the handle is dropp=
ed, the
> +/// drop method must wait for the handler to finish before returning.

Between this comment and the comment on cancel we say "if it is
running" 3 times. Can we say it just once, on the method, and here say
that cancel must be called in Drop?

> +pub unsafe trait HrTimerHandle {
> +    /// Cancel the timer, if it is running. If the timer handler is runn=
ing, block
> +    /// till the handler has finished.
> +    fn cancel(&mut self) -> bool;
> +}
> +
> +/// Implemented by structs that contain timer nodes.
> +///
> +/// Clients of the timer API would usually safely implement this trait b=
y using
> +/// the [`crate::impl_has_hr_timer`] macro.
> +///
> +/// # Safety
> +///
> +/// Implementers of this trait must ensure that the implementer has a [`=
HrTimer`]
> +/// field at the offset specified by `OFFSET` and that all trait methods=
 are
> +/// implemented according to their documentation.
> +///
> +/// [`impl_has_timer`]: crate::impl_has_timer
> +pub unsafe trait HasHrTimer<T> {
> +    /// Offset of the [`HrTimer`] field within `Self`
> +    const OFFSET: usize;

Does this need to be part of the trait? As an alternative the provided
methods could be generated in the macro below and reduce the
opportunity to implement this trait incorrectly.

> +
> +    /// Return a pointer to the [`HrTimer`] within `Self`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to a valid struct of type `Self`.
> +    unsafe fn raw_get_timer(ptr: *const Self) -> *const HrTimer<T> {
> +        // SAFETY: By the safety requirement of this trait, the trait
> +        // implementor will have a `HrTimer` field at the specified offs=
et.
> +        unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast::<HrTimer<T>>()=
 }
> +    }
> +
> +    /// Return a pointer to the struct that is embedding the [`HrTimer`]=
 pointed
> +    /// to by `ptr`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to a [`HrTimer<T>`] field in a struct of type `=
Self`.
> +    unsafe fn timer_container_of(ptr: *mut HrTimer<T>) -> *mut Self
> +    where
> +        Self: Sized,
> +    {
> +        // SAFETY: By the safety requirement of this function and the `H=
asHrTimer`
> +        // trait, the following expression will yield a pointer to the `=
Self`
> +        // containing the timer addressed by `ptr`.
> +        unsafe { ptr.cast::<u8>().sub(Self::OFFSET).cast::<Self>() }
> +    }
> +
> +    /// Get pointer to embedded `bindings::hrtimer` struct.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `self_ptr` must point to a valid `Self`.
> +    unsafe fn c_timer_ptr(self_ptr: *const Self) -> *const bindings::hrt=
imer {
> +        // SAFETY: `self_ptr` is a valid pointer to a `Self`.
> +        let timer_ptr =3D unsafe { Self::raw_get_timer(self_ptr) };
> +
> +        // SAFETY: timer_ptr points to an allocation of at least `HrTime=
r` size.
> +        unsafe { HrTimer::raw_get(timer_ptr) }
> +    }
> +
> +    /// Start the timer contained in the `Self` pointed to by `self_ptr`=
. If
> +    /// it is already running it is removed and inserted.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `self_ptr` must point to a valid `Self`.
> +    unsafe fn start(self_ptr: *const Self, expires: Ktime) {
> +        // SAFETY: By function safety requirement, `self_ptr`is a valid =
`Self`.
> +        unsafe {
> +            bindings::hrtimer_start_range_ns(
> +                Self::c_timer_ptr(self_ptr).cast_mut(),
> +                expires.to_ns(),
> +                0,
> +                bindings::hrtimer_mode_HRTIMER_MODE_REL,
> +            );
> +        }
> +    }
> +}
> +
> +/// Use to implement the [`HasHrTimer<T>`] trait.
> +///
> +/// See [`module`] documentation for an example.
> +///
> +/// [`module`]: crate::time::hrtimer
> +#[macro_export]
> +macro_rules! impl_has_hr_timer {
> +    (
> +        impl$({$($generics:tt)*})?
> +            HasHrTimer<$timer_type:ty>
> +            for $self:ty
> +        { self.$field:ident }
> +        $($rest:tt)*
> +    ) =3D> {
> +        // SAFETY: This implementation of `raw_get_timer` only compiles =
if the
> +        // field has the right type.
> +        unsafe impl$(<$($generics)*>)? $crate::time::hrtimer::HasHrTimer=
<$timer_type> for $self {
> +            const OFFSET: usize =3D ::core::mem::offset_of!(Self, $field=
) as usize;
> +
> +            #[inline]
> +            unsafe fn raw_get_timer(ptr: *const Self) ->
> +                *const $crate::time::hrtimer::HrTimer<$timer_type>
> +            {
> +                // SAFETY: The caller promises that the pointer is not d=
angling.
> +                unsafe {
> +                    ::core::ptr::addr_of!((*ptr).$field)
> +                }
> +            }
> +        }
> +    }
> +}
>
> --
> 2.47.0
>
>

