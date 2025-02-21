Return-Path: <linux-kernel+bounces-525460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC5A3F04A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C425286029D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD67204081;
	Fri, 21 Feb 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/sGrMWR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766D4202F65;
	Fri, 21 Feb 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130196; cv=none; b=k4Qx6jC7FPx5xnjKgSMfx3uNhm2k+bFfE5UfM6mJtLiF838OCfWYGkd4nLrYQtTLhxs1KcWYOw2/jS5Y/W4OW3kK4GOmyPTI3w6Tt9U2ydQKc+Ay7emH1TgopDcvFjF5Nl8gZr+8pxS9ocj4RnmjSNVQ8CAqdXhlNuFXhdaqpH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130196; c=relaxed/simple;
	bh=+vex0rU7yyux6VIUtzzsy4nIGcombmSuQZU7IYkXS6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PlXrQvVFETlo4ng9pW6AAC/Nc9a8cldrgf1TNHPWs54aiYw8O0rlKLtxfKaGhRQDyX0GRsdz+FJg2+JsIMh+VxMex+1I5um1QHmGPeMcrUFVJBQxFgSJlk4gmLCE0p4DdMB0agarP8nT1PS6VaRpxolhXrqwrFFYu0r4o78HfWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/sGrMWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC46C4CED6;
	Fri, 21 Feb 2025 09:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740130196;
	bh=+vex0rU7yyux6VIUtzzsy4nIGcombmSuQZU7IYkXS6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V/sGrMWREby+xBpIYtvwK/qThmBERaseP8UgRym6EmsG1EQ6N84amqN00BEBjXQ5h
	 lw/sKsYGfzVzsWV2fkNitzqxGiX4QVP6RAmLiTd3HmYn4Q6qyRfA78mmD3lMgIwJpa
	 vDrj8lOnmbg8BaG/TXD6zJchor2NxXFsbVz1heFa50ie6jCdHMqlrzfwA46AlNUJeJ
	 Y6M0TxOxLG73WJ/naCm/gIPuWaAVR8bWI1qtFbTBRWCTaYaVHDXQJRQhl+yUyIyZCR
	 Ryn/xYJIJixdIM5OEy+Op0oZXOpHCSWeFJtbmjzRKDwWm5fQUUFVw5WTyN2ndxpS+0
	 G7XEU0ErBqhUg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
In-Reply-To: <df748ac2-3551-460f-a16f-85d805671a3f@proton.me> (Benno Lossin's
	message of "Thu, 20 Feb 2025 23:46:10 +0000")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
	<1id7is_U22yzuGODgkUIoB5AFM6snF9CPu7F_sY7Mfkn3EwQRPfjB5JNkRFYu6DX1N8X_OQvdEB2BT-l3rFhwg==@protonmail.internalid>
	<df748ac2-3551-460f-a16f-85d805671a3f@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 10:03:03 +0100
Message-ID: <87a5afhdq0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 18.02.25 14:27, Andreas Hindborg wrote:
>> This patch adds support for intrusive use of the hrtimer system. For now,
>> only one timer can be embedded in a Rust struct.
>>
>> The hrtimer Rust API is based on the intrusive style pattern introduced by
>> the Rust workqueue API.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/time.rs         |   2 +
>>  rust/kernel/time/hrtimer.rs | 312 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 314 insertions(+)
>>
>> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
>> index 87e47f2f5618d..2cf365cfb412e 100644
>> --- a/rust/kernel/time.rs
>> +++ b/rust/kernel/time.rs
>> @@ -10,6 +10,8 @@
>>
>>  use core::convert::Into;
>>
>> +pub mod hrtimer;
>> +
>>  /// The number of nanoseconds per millisecond.
>>  pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
>>
>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> new file mode 100644
>> index 0000000000000..a6332924efabd
>> --- /dev/null
>> +++ b/rust/kernel/time/hrtimer.rs
>> @@ -0,0 +1,312 @@
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
>> +//! * Stopped
>> +//! * Running
>> +//!
>> +//! Operations:
>> +//!
>> +//! * Start
>> +//! * Cancel
>> +//! * Stop
>> +//! * Restart
>> +//!
>> +//! Events:
>> +//!
>> +//! * Expire
>> +//!
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
>> +//! A timer is initialized in the **stopped** state. A stopped timer can be
>> +//! **started** with an **expiry** time. After the timer is started, it is
>> +//! **running**. When the timer **expires**, the timer handler is executed.
>> +//! After the handler has executed, the timer may be **restarted** or
>> +//! **stopped**. A running timer can be **canceled** before it's handler is
>
> This confuses me a bit, in the other thread you wrote that the handler
> decides if the timer should restart or be stopped. But What happens when
> I call `cancel` on the `HrTimerHandle` while the handler is running, but
> finishes shortly after with a restart request? Will it be canceled?

Tamir had a somewhat similar question and Is added the following


//! A timer is still considered to be running when the handler is executing. The
//! return value of the handler determines if the timer will stop or restart
//! when the handler finishes executing.
//!

If a timer is canceled while the handler is running, the call to cancel
will block. After the handler has finished executing and the timer has
been restarted or stopped, the cancel call will unblock. If at the timer
is stopped cancel has no effect. If the timer was restarted because of
the handler return value, it will be canceled.

I'll add a note on that as well.


> I also have a bit of a wording issue with "the timer is running" IIUC,
> this means that the timer subsystem keeps track of the expiry time and
> when the time is elapsed, it fires the code that you registered prior.
> At first, I thought that "the timer is running" meant that the
> registered code is running. Maybe we should have two different terms for
> that? I personally would prefer "active timer" for "the timer subsystem
> is currently tracking the time and when it is elapsed, it will run the
> code" and "running timer" for "the timer's expiry time has elapsed and
> the timer callback is currently being executed".

I understand your confusion and I experienced a similar confusion when I
first dove in. Early iterations of this patch set used another
terminology, but C maintainers requested I use the terminology used in C
hrtimer subsystem. Which of course is the right thing to do.

And so in this terminology a timer is `running` when it is armed and
will run the handler when expiration occurs.

I tried to explain with the paragraph under the diagram, but perhaps it
is not enough. I can try to expand it further.

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
>> +// SAFETY: Timer operations are locked on C side, so it is safe to operate on a
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
>> +            // INVARIANTS: We initialize `timer` with `hrtimer_setup` below.
>> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtimer| {
>> +                // SAFETY: By design of `pin_init!`, `place` is a pointer to a
>> +                // live allocation. hrtimer_setup will initialize `place` and
>> +                // does not require `place` to be initialized prior to the call.
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
>> +    /// `ptr` must point to a live allocation of at least the size of `Self`.
>> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
>> +        // SAFETY: The field projection to `timer` does not go out of bounds,
>> +        // because the caller of this function promises that `ptr` points to an
>> +        // allocation of at least the size of `Self`.
>> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer)) }
>> +    }
>> +
>> +    /// Cancel an initialized and potentially running timer.
>> +    ///
>> +    /// If the timer handler is running, this will block until the handler is
>> +    /// finished.
>> +    ///
>> +    /// Users of the `HrTimer` API would not usually call this method directly.
>> +    /// Instead they would use the safe `cancel` method on the [`HrTimerHandle`]
>
> Can you link to the `cancel` function?
>
>> +    /// returned when the timer was started.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `self_ptr` must point to a valid `Self`.
>> +    #[allow(dead_code)]
>> +    pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
>> +        // SAFETY: timer_ptr points to an allocation of at least `HrTimer` size.
>> +        let c_timer_ptr = unsafe { HrTimer::raw_get(self_ptr) };
>> +
>> +        // If the handler is running, this will wait for the handler to finish
>> +        // before returning.
>> +        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronization is
>> +        // handled on C side.
>> +        unsafe { bindings::hrtimer_cancel(c_timer_ptr) != 0 }
>> +    }
>> +}
>> +
>> +/// Implemented by pointer types that point to structs that embed a [`HrTimer`].
>> +///
>> +/// Target (pointee) must be [`Sync`] because timer callbacks happen in another
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
>
> I don't understand this argument. The bounds in the other patches seem
> like they could easily be combined. Then this trait could be merged into
> the one above.

I initially wrote `HrTimerPointer` and `RawHrTimerCallback` as a single
trait. But I ran into problems when specifying trait bounds. I got some
loops in the type graph that the compiler could not figure out.

>
>> +pub trait RawHrTimerCallback {
>> +    /// Callback to be called from C when timer fires.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Only to be called by C code in `hrtimer` subsystem. `ptr` must point to
>> +    /// the `bindings::hrtimer` structure that was used to start the timer.
>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart;
>> +}
>> +
>> +/// Implemented by structs that can be the target of a timer callback.
>> +pub trait HrTimerCallback {
>> +    /// The type whose [`RawHrTimerCallback::run`] method will be invoked when
>> +    /// the timer expires.
>> +    type CallbackTarget<'a>: RawHrTimerCallback;
>> +
>> +    /// This type is passed to the timer callback function. It may be a borrow
>> +    /// of [`Self::CallbackTarget`], or it may be `Self::CallbackTarget` if the
>> +    /// implementation can guarantee exclusive access to the target during timer
>
> Technically "exclusive" access is correct if the `CallbackTarget` is
> `Pin<&Self>`, since you will get exclusive access to a `Pin<&Self>`, but
> it might confuse people, because there can be multiple `Pin<&Self>`. So
> I would just drop the word "exclusive" here.

Yes, maybe it should be "shared or exclusive access, depending on the type"?

>
>> +    /// handler execution.
>> +    type CallbackTargetParameter<'a>;
>
> Also why can't this type be an associated type of `HrTimerPointer`?
> Since this seems to always be constrained in the impls of
> `RawHrTimerCallback`.

That might be a nice improvement, I'll try that out.


Best regards,
Andreas Hindborg



