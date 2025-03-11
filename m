Return-Path: <linux-kernel+bounces-556900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2FA5D041
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABC5189F980
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535E8264A6E;
	Tue, 11 Mar 2025 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLzqCI33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E12253AB;
	Tue, 11 Mar 2025 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723204; cv=none; b=gGbfRnMnX/8rkxN3HAUIGOxzk6Za4mOZxuPSqFf8pXLpKdCt3+rs/BlmrKLGV2K28vieRZQKS1/t6tRdcmzPhRFLgAptVuYCiAgM2r6NJo9eComLiAJR5nKZopVv8b5QnMMoSsYtA6deUu5N2f0ytQHS7c+4LRdrZlq6wWHFc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723204; c=relaxed/simple;
	bh=v/3az4vRYWs1ucCK+L7O2rSWOUhMtd/+E8koIZNf1pk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e5o+qU3ZMvw7wikM99uID7UqzL6U+ytOvNdP6kHL6gzNFc2tczGJrhgsfFjJCa4f5ykPIqB//Lpxwa2HnDaVS2vUWjmjBJwqAyhqb2FN5Y1m0wY2a/h4EF/+7ztSII5th2ZeWmkOnwJm9o52kMYok3YHoPuxMrCTODHH8h0GZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLzqCI33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EF9C4CEEA;
	Tue, 11 Mar 2025 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741723203;
	bh=v/3az4vRYWs1ucCK+L7O2rSWOUhMtd/+E8koIZNf1pk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PLzqCI33Rld89CMLqG4K05hZsXzto39OqGC8Ctlw9oBssd67NYytMot13Tsy+LPmA
	 QN9rh68VTT7GjSVzb5UIu9UbR3TuVrlIp4cwwlAweFnBp691GTtiULPAUQQLK4V30i
	 mTGOpceXlUjf/tbVI3a6QG7JXTLqLHagdJUSTU0BzGqFtPXeIVZ0aLzLSBmIm0nByQ
	 u0mIh9LkHpr2OTzP0BUoE55lx0R2cQqOIAl0QzULSRCsFstwhHQRy8zF0vFbDbV15v
	 zRNsnq8lVg8qabyi/pvnUgE6kfn4kiKvpUTwm/weVDi7ZUmMZzmddV3GFmKTKVg2Sx
	 KzNBkYgi60aOA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Guangbo Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,
  "Daniel Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  "Markus Elfring" <Markus.Elfring@web.de>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 01/13] rust: hrtimer: introduce hrtimer support
In-Reply-To: <a01b93484a4b67932413bf53f8a45cea315d8d58.camel@redhat.com>
	(Lyude Paul's message of "Tue, 11 Mar 2025 13:06:56 -0400")
References: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
	<20250309-hrtimer-v3-v6-12-rc2-v12-1-73586e2bd5f1@kernel.org>
	<mgqJmos8H-QlK2HHH-RqPnV0apqkv5ljTKXvyRUHKyZvTBzorR0JGLwGK0MwHk-wLYoU19I-pRSrqJJKRCXfyQ==@protonmail.internalid>
	<a01b93484a4b67932413bf53f8a45cea315d8d58.camel@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 11 Mar 2025 20:59:44 +0100
Message-ID: <877c4vl4nj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> Only a few nits below!
>
> On Sun, 2025-03-09 at 16:18 +0100, Andreas Hindborg wrote:
>> Add support for intrusive use of the hrtimer system. For now,
>> only add support for embedding one timer per Rust struct.
>>
>> The hrtimer Rust API is based on the intrusive style pattern introduced by
>> the Rust workqueue API.
>>
>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>> Reviewed-by: Tamir Duberstein <tamird@gmail.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/time.rs         |   2 +
>>  rust/kernel/time/hrtimer.rs | 352 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 354 insertions(+)
>>
>> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
>> index 379c0f5772e5..fab1dadfa589 100644
>> --- a/rust/kernel/time.rs
>> +++ b/rust/kernel/time.rs
>> @@ -8,6 +8,8 @@
>>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
>>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>>
>> +pub mod hrtimer;
>> +
>>  /// The number of nanoseconds per millisecond.
>>  pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
>>
>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> new file mode 100644
>> index 000000000000..20d3440c2a02
>> --- /dev/null
>> +++ b/rust/kernel/time/hrtimer.rs
>> @@ -0,0 +1,352 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Intrusive high resolution timers.
>> +//!
>> +//! Allows running timer callbacks without doing allocations at the time of
>> +//! starting the timer. For now, only one timer per type is allowed.
>> +//!
>> +//! # Vocabulary
>> +//!
>> +//! States:
>> +//!
>> +//! - Stopped: initialized but not started, or cancelled, or not restarted.
>> +//! - Started: initialized and started or restarted.
>> +//! - Running: executing the callback.
>> +//!
>> +//! Operations:
>> +//!
>> +//! * Start
>> +//! * Cancel
>> +//! * Restart
>> +//!
>> +//! Events:
>> +//!
>> +//! * Expire
>> +//!
>> +//! ## State Diagram
>> +//!
>> +//! ```text
>> +//!                                                   Return NoRestart
>> +//!                       +---------------------------------------------------------------------+
>> +//!                       |                                                                     |
>> +//!                       |                                                                     |
>> +//!                       |                                                                     |
>> +//!                       |                                         Return Restart              |
>> +//!                       |                                      +------------------------+     |
>> +//!                       |                                      |                        |     |
>> +//!                       |                                      |                        |     |
>> +//!                       v                                      v                        |     |
>> +//!           +-----------------+      Start      +------------------+           +--------+-----+--+
>> +//!           |                 +---------------->|                  |           |                 |
>> +//! Init      |                 |                 |                  |  Expire   |                 |
>> +//! --------->|    Stopped      |                 |      Started     +---------->|     Running     |
>> +//!           |                 |     Cancel      |                  |           |                 |
>> +//!           |                 |<----------------+                  |           |                 |
>> +//!           +-----------------+                 +---------------+--+           +-----------------+
>> +//!                                                     ^         |
>> +//!                                                     |         |
>> +//!                                                     +---------+
>> +//!                                                      Restart
>> +//! ```
>> +//!
>> +//!
>> +//! A timer is initialized in the **stopped** state. A stopped timer can be
>> +//! **started** by the `start` operation, with an **expiry** time. After the
>> +//! `start` operation, the timer is in the **started** state. When the timer
>> +//! **expires**, the timer enters the **running** state and the handler is
>> +//! executed. After the handler has returned, the timer may enter the
>> +//! **started* or **stopped** state, depending on the return value of the
>> +//! handler. A timer in the **started** or **running** state may be **canceled**
>> +//! by the `cancel` operation. A timer that is cancelled enters the **stopped**
>> +//! state.
>> +//!
>> +//! A `cancel` or `restart` operation on a timer in the **running** state takes
>> +//! effect after the handler has returned and the timer has transitioned
>> +//! out of the **running** state.
>> +//!
>> +//! A `restart` operation on a timer in the **stopped** state is equivalent to a
>> +//! `start` operation.
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
>> +// SAFETY: Timer operations are locked on the C side, so it is safe to operate
>> +// on a timer from multiple threads.
>> +unsafe impl<T> Sync for HrTimer<T> {}
>> +
>> +impl<T> HrTimer<T> {
>> +    /// Return an initializer for a new timer instance.
>> +    pub fn new() -> impl PinInit<Self>
>> +    where
>> +        T: HrTimerCallback,
>> +    {
>> +        pin_init!(Self {
>> +            // INVARIANT: We initialize `timer` with `hrtimer_setup` below.
>> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtimer| {
>> +                // SAFETY: By design of `pin_init!`, `place` is a pointer to a
>> +                // live allocation. hrtimer_setup will initialize `place` and
>> +                // does not require `place` to be initialized prior to the call.
>> +                unsafe {
>> +                    bindings::hrtimer_setup(
>> +                        place,
>> +                        Some(T::Pointer::run),
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
>> +    /// This function is useful to get access to the value without creating
>> +    /// intermediate references.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `this` must point to a live allocation of at least the size of `Self`.
>> +    unsafe fn raw_get(this: *const Self) -> *mut bindings::hrtimer {
>> +        // SAFETY: The field projection to `timer` does not go out of bounds,
>> +        // because the caller of this function promises that `this` points to an
>> +        // allocation of at least the size of `Self`.
>> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*this).timer)) }
>> +    }
>> +
>> +    /// Cancel an initialized and potentially running timer.
>> +    ///
>> +    /// If the timer handler is running, this function will block until the
>> +    /// handler returns.
>> +    ///
>> +    /// Note that the timer might be started by a concurrent start operation. If
>> +    /// so, the timer might not be in the **stopped** state when this function
>> +    /// returns.
>> +    ///
>> +    /// Users of the `HrTimer` API would not usually call this method directly.
>> +    /// Instead they would use the safe [`HrTimerHandle::cancel`] on the handle
>> +    /// returned when the timer was started.
>> +    ///
>> +    /// This function is useful to get access to the value without creating
>> +    /// intermediate references.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `this` must point to a valid `Self`.
>> +    #[allow(dead_code)]
>> +    pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
>> +        // SAFETY: `this` points to an allocation of at least `HrTimer` size.
>> +        let c_timer_ptr = unsafe { HrTimer::raw_get(this) };
>> +
>> +        // If the handler is running, this will wait for the handler to return
>> +        // before returning.
>> +        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronization is
>> +        // handled on the C side.
>> +        unsafe { bindings::hrtimer_cancel(c_timer_ptr) != 0 }
>> +    }
>> +}
>> +
>> +/// Implemented by pointer types that point to structs that contain a [`HrTimer`].
>> +///
>> +/// `Self` must be [`Sync`] because it is passed to timer callbacks in another
>> +/// thread of execution (hard or soft interrupt context).
>> +///
>> +/// Starting a timer returns a [`HrTimerHandle`] that can be used to manipulate
>> +/// the timer. Note that it is OK to call the start function repeatedly, and
>> +/// that more than one [`HrTimerHandle`] associated with a [`HrTimerPointer`] may
>> +/// exist. A timer can be manipulated through any of the handles, and a handle
>> +/// may represent a cancelled timer.
>> +pub trait HrTimerPointer: Sync + Sized {
>> +    /// A handle representing a started or restarted timer.
>> +    ///
>> +    /// If the timer is running or if the timer callback is executing when the
>> +    /// handle is dropped, the drop method of [`HrTimerHandle`] should not return
>> +    /// until the timer is stopped and the callback has completed.
>> +    ///
>> +    /// Note: When implementing this trait, consider that it is not unsafe to
>> +    /// leak the handle.
>> +    type TimerHandle: HrTimerHandle;
>> +
>> +    /// Start the timer with expiry after `expires` time units. If the timer was
>> +    /// already running, it is restarted with the new expiry time.
>> +    fn start(self, expires: Ktime) -> Self::TimerHandle;
>> +}
>> +
>> +/// Implemented by [`HrTimerPointer`] implementers to give the C timer callback a
>> +/// function to call.
>> +// This is split from `HrTimerPointer` to make it easier to specify trait bounds.
>> +pub trait RawHrTimerCallback {
>> +    /// Type of the parameter passed to [`HrTimerCallback::run`]. It may be
>> +    /// [`Self`], or a pointer type derived from [`Self`].
>> +    type CallbackTarget<'a>;
>> +
>> +    /// Callback to be called from C when timer fires.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Only to be called by C code in the `hrtimer` subsystem. `this` must point
>> +    /// to the `bindings::hrtimer` structure that was used to start the timer.
>> +    unsafe extern "C" fn run(this: *mut bindings::hrtimer) -> bindings::hrtimer_restart;
>> +}
>> +
>> +/// Implemented by structs that can be the target of a timer callback.
>> +pub trait HrTimerCallback {
>> +    /// The type whose [`RawHrTimerCallback::run`] method will be invoked when
>> +    /// the timer expires.
>> +    type Pointer<'a>: RawHrTimerCallback;
>> +
>> +    /// Called by the timer logic when the timer fires.
>> +    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>)
>> +    where
>> +        Self: Sized;
>> +}
>> +
>> +/// A handle representing a potentially running timer.
>> +///
>> +/// More than one handle representing the same timer might exist.
>> +///
>> +/// # Safety
>> +///
>> +/// When dropped, the timer represented by this handle must be cancelled, if it
>> +/// is running. If the timer handler is running when the handle is dropped, the
>> +/// drop method must wait for the handler to return before returning.
>> +///
>> +/// Note: One way to satisfy the safety requirement is to call `Self::cancel` in
>> +/// the drop implementation for `Self.`
>> +pub unsafe trait HrTimerHandle {
>> +    /// Cancel the timer. If the timer is in the running state, block till the
>> +    /// handler has returned.
>> +    ///
>> +    /// Note that the timer might be started by a concurrent start operation. If
>> +    /// so, the timer might not be in the **stopped** state when this function
>> +    /// returns.
>> +    ///
>
> Extraneous newline
>
>> +    fn cancel(&mut self) -> bool;
>> +}
>> +
>> +/// Implemented by structs that contain timer nodes.
>> +///
>> +/// Clients of the timer API would usually safely implement this trait by using
>> +/// the [`crate::impl_has_hr_timer`] macro.
>> +///
>> +/// # Safety
>> +///
>> +/// Implementers of this trait must ensure that the implementer has a
>> +/// [`HrTimer`] field and that all trait methods are implemented according to
>> +/// their documentation. All the methods of this trait must operate on the same
>> +/// field.
>> +pub unsafe trait HasHrTimer<T> {
>> +    /// Return a pointer to the [`HrTimer`] within `Self`.
>> +    ///
>> +    /// This function is useful to get access to the value without creating
>> +    /// intermediate references.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `this` must be a valid pointer.
>> +    unsafe fn raw_get_timer(this: *const Self) -> *const HrTimer<T>;
>> +
>> +    /// Return a pointer to the struct that is containing the [`HrTimer`] pointed
>> +    /// to by `ptr`.
>> +    ///
>> +    /// This function is useful to get access to the value without creating
>> +    /// intermediate references.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `ptr` must point to a [`HrTimer<T>`] field in a struct of type `Self`.
>> +    unsafe fn timer_container_of(ptr: *mut HrTimer<T>) -> *mut Self
>> +    where
>> +        Self: Sized;
>> +
>> +    /// Get pointer to the contained `bindings::hrtimer` struct.
>> +    ///
>> +    /// This function is useful to get access to the value without creating
>> +    /// intermediate references.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `this` must be a valid pointer.
>> +    unsafe fn c_timer_ptr(this: *const Self) -> *const bindings::hrtimer {
>> +        // SAFETY: `this` is a valid pointer to a `Self`.
>> +        let timer_ptr = unsafe { Self::raw_get_timer(this) };
>> +
>> +        // SAFETY: timer_ptr points to an allocation of at least `HrTimer` size.
>> +        unsafe { HrTimer::raw_get(timer_ptr) }
>> +    }
>> +
>> +    /// Start the timer contained in the `Self` pointed to by `self_ptr`. If
>> +    /// it is already running it is removed and inserted.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// - `this` must point to a valid `Self`.
>> +    /// - Caller must ensure that the pointee of `this` lives until the timer
>> +    ///   fires or is canceled.
>> +    unsafe fn start(this: *const Self, expires: Ktime) {
>> +        // SAFETY: By function safety requirement, `this`is a valid `Self`.
>
> ---------------------------------------------------------^
> Missing a space over there
>
> With that fixed:
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>

Thanks!


Best regards,
Andreas Hindborg



