Return-Path: <linux-kernel+bounces-524924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36148A3E8BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4D13A86A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C0F1F4198;
	Thu, 20 Feb 2025 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YGJQDKah"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9772862A5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095183; cv=none; b=qpLaTWQt6aMnnEx+s8DG7kEvaSEjsqPSnjIUsJrJ7ZVaXh4fw8kh5Erh2s4IuwqR/UXgwWPvYF4xf56T4ry8ZRpAnq8OL7OPqWYahZmQD6X+9vg6x18gSINDggx3UwSYRvJc6hOziAVrIh2OTgti/FTo1LapFM/7lvn4Dve2nUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095183; c=relaxed/simple;
	bh=m2yHG/QL4JuPgPTr7XQKQuMeYmV9fXz6ydWBhErNzUA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyKv4IQTtU6eQXoc6JlzRujciz0MeThyt5mZzCgVk/lqEWhNh19krpEl1W56Q8fdkGTxivhNg1Dm2iNxBbWwmqp3xDr74w+VLfBckR8qMBsURqW8rfSjxhrhPcKGPCos+VsawriSDoAMAFMItKPYrbNn9cyKtalQDtlcIF9Dclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YGJQDKah; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740095177; x=1740354377;
	bh=d/XzjkS8i6TllPSoLJZnCwKfuue4ReaS7JSLMaHI6uw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=YGJQDKahu0h+JepBPwUTixxx//XJZ6XjahSR5npDfDG5Rzh5nN7uohbKkeuYTtYyD
	 SDomMisyb1oz0zqQVRnN5bB/3L/5x/yrwyUqGn8RUo0cRJU1bGPAI4PQ0Wgzp1PIi8
	 2YOw5KlWN73ZvP+RrxeDPJLk3mGRELkGb9enIITzAMD0/7fMEd88f1UpXtgmDJLysE
	 wbTIdlk5n7wv3knYEEnO8k3u/6pBmcPZklpF977XyWbOJzaQ30cywZSi1US19trIUZ
	 Nz852ZkVZXqnZTVrxTIOn+NnWXC8MZ0LIiImQyu8oi+5354qRhPvUIm6okwEOXJco3
	 Lsk07wq3QfX3A==
Date: Thu, 20 Feb 2025 23:46:10 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
Message-ID: <df748ac2-3551-460f-a16f-85d805671a3f@proton.me>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a3aa2e71b729635a44670a4904836da525e161fe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.02.25 14:27, Andreas Hindborg wrote:
> This patch adds support for intrusive use of the hrtimer system. For now,
> only one timer can be embedded in a Rust struct.
>=20
> The hrtimer Rust API is based on the intrusive style pattern introduced b=
y
> the Rust workqueue API.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time.rs         |   2 +
>  rust/kernel/time/hrtimer.rs | 312 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 314 insertions(+)
>=20
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 87e47f2f5618d..2cf365cfb412e 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -10,6 +10,8 @@
>=20
>  use core::convert::Into;
>=20
> +pub mod hrtimer;
> +
>  /// The number of nanoseconds per millisecond.
>  pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
>=20
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

This confuses me a bit, in the other thread you wrote that the handler
decides if the timer should restart or be stopped. But What happens when
I call `cancel` on the `HrTimerHandle` while the handler is running, but
finishes shortly after with a restart request? Will it be canceled?

I also have a bit of a wording issue with "the timer is running" IIUC,
this means that the timer subsystem keeps track of the expiry time and
when the time is elapsed, it fires the code that you registered prior.
At first, I thought that "the timer is running" meant that the
registered code is running. Maybe we should have two different terms for
that? I personally would prefer "active timer" for "the timer subsystem
is currently tracking the time and when it is elapsed, it will run the
code" and "running timer" for "the timer's expiry time has elapsed and
the timer callback is currently being executed".

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

Can you link to the `cancel` function?

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

I don't understand this argument. The bounds in the other patches seem
like they could easily be combined. Then this trait could be merged into
the one above.

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

Technically "exclusive" access is correct if the `CallbackTarget` is
`Pin<&Self>`, since you will get exclusive access to a `Pin<&Self>`, but
it might confuse people, because there can be multiple `Pin<&Self>`. So
I would just drop the word "exclusive" here.

> +    /// handler execution.
> +    type CallbackTargetParameter<'a>;

Also why can't this type be an associated type of `HrTimerPointer`?
Since this seems to always be constrained in the impls of
`RawHrTimerCallback`.

---
Cheers,
Benno

> +
> +    /// Called by the timer logic when the timer fires.
> +    fn run(this: Self::CallbackTargetParameter<'_>)
> +    where
> +        Self: Sized;
> +}


