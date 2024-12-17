Return-Path: <linux-kernel+bounces-449535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A79F5089
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 636F07A9E04
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCED1FBCB7;
	Tue, 17 Dec 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM1YEsyn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3E1F76C0;
	Tue, 17 Dec 2024 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451017; cv=none; b=JeWB0wfHx1JNaYCoDk4b93HAfv+v2GiysF5uPjP49GOtcN/K5SjWK0K95JcMTjlF/o9QGc2wbl8PKbl0C5ON6L5rOIdtyAvPykZpgdVtEGmDQ0dRNHBhMTjEM15JvM1HPQS9fKhYziCxXI8znoeIB6X3/vq2D38rFmR0hAcAUyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451017; c=relaxed/simple;
	bh=XA1cD9dyHs4PM1ZV8ZO3BjAUlvYxEt2jsMm2z6jdQDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rvpz8E3dGau/E5zcCi+S3S8Nd/4Flf9wH0pIhcFtS1ldkkzKRpimUen42lEYjS95AvpYuLM1HCurr0Uaglj9lQeiaIkb2wAx6uhNTzqA7/24JFWHlctQJdjBJewBvF+RS6jRhg8Ea/SGAlIkuYb3IbVZUFkCFOosAXOlZ0FKNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM1YEsyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA00AC4CED3;
	Tue, 17 Dec 2024 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734451017;
	bh=XA1cD9dyHs4PM1ZV8ZO3BjAUlvYxEt2jsMm2z6jdQDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MM1YEsynpd3Ipr0yJCLluQiT0Axt5AyQBFYWTvVMqtEY3mfAN3Iffwa1IKB2egOZR
	 j4eCxDLMUbrVJrOmIjX5fVIwiNc6k4cklolqs+/brvN9nrFwImA5xMv9RneKKiYTOu
	 8K+NUAmT9KmcsxYARcGi6RnXewMk9pYzlY1g3BSj6wypAaFTA84wZoz+yrsXt/9vVR
	 E4MjSpBytErdLIgVM5494g7ThLNmsPEn2/Q7WNHgWvyHvaoGDu71pTpTIS8pyGL/4W
	 zBrbLP54ayAagGkxcoxIzUMNScywX5a++PikjRnnkYvrzH4JjU+tuGO970YKW9sL+A
	 aQsyHRsH+3EYw==
Date: Tue, 17 Dec 2024 16:56:54 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/14] rust: hrtimer: introduce hrtimer support
Message-ID: <Z2GfRgwIA0-zQmXc@localhost.localdomain>
References: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
 <20241217-hrtimer-v3-v6-12-rc2-v5-2-b34c20ac2cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217-hrtimer-v3-v6-12-rc2-v5-2-b34c20ac2cb7@kernel.org>

Le Tue, Dec 17, 2024 at 04:17:33PM +0100, Andreas Hindborg a écrit :
> This patch adds support for intrusive use of the hrtimer system. For now,
> only one timer can be embedded in a Rust struct.
> 
> The hrtimer Rust API is based on the intrusive style pattern introduced by
> the Rust workqueue API.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time.rs         |   2 +
>  rust/kernel/time/hrtimer.rs | 296 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 298 insertions(+)
> 
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index f59e0fea79d3acfddd922f601f569353609aeec1..51c3532eee0184495ed5b7d717860c9980ff2a43 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -10,6 +10,8 @@
>  
>  use core::convert::Into;
>  
> +pub mod hrtimer;
> +
>  /// The number of nanoseconds per millisecond.
>  pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
>  
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..b09bdb8bc2037bf116a9a87b16271f4045f53aa9
> --- /dev/null
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Intrusive high resolution timers.
> +//!
> +//! Allows running timer callbacks without doing allocations at the time of
> +//! starting the timer. For now, only one timer per type is allowed.
> +//!
> +//! # Vocabulary
> +//!
> +//! A timer is initialized in the **stopped** state. A stopped timer can be
> +//! **started** with an **expiry** time. After the timer is started, it is
> +//! **running**. When the timer **expires**, the timer handler is executed.
> +//! After the handler has executed, the timer may be **restarted** or
> +//! **stopped**. A running timer can be **cancelled** before it's handler is
> +//! executed. A timer that is cancelled enters the **stopped** state.
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
> +pub struct Timer<U> {

I seem to remember we had a debate on that. Why not call that Hrtimer?
Timer is a bit too generic for a name. I suspect you'll need to introduce
jiffies based timer bindings in the future as well and then some confusion
may arise.

> +    #[pin]
> +    timer: Opaque<bindings::hrtimer>,
> +    _t: PhantomData<U>,
> +}
> +
> +// SAFETY: A `Timer` can be moved to other threads and used/dropped from there.
> +unsafe impl<U> Send for Timer<U> {}
> +
> +// SAFETY: Timer operations are locked on C side, so it is safe to operate on a
> +// timer from multiple threads
> +unsafe impl<U> Sync for Timer<U> {}
> +
> +impl<T> Timer<T> {
> +    /// Return an initializer for a new timer instance.
> +    pub fn new() -> impl PinInit<Self>
> +    where
> +        T: TimerCallback,
> +    {
> +        pin_init!(Self {
> +            // INVARIANTS: We initialize `timer` with `hrtimer_setup` below.
> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtimer| {
> +                // SAFETY: By design of `pin_init!`, `place` is a pointer live
> +                // allocation. hrtimer_setup will initialize `place` and does
> +                // not require `place` to be initialized prior to the call.
> +                unsafe {
> +                    bindings::hrtimer_setup(
> +                        place,
> +                        Some(T::CallbackTarget::run),
> +                        bindings::CLOCK_MONOTONIC as i32,
> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,

Always relative?

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
> +    /// `ptr` must point to a live allocation of at least the size of `Self`.
> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
> +        // SAFETY: The field projection to `timer` does not go out of bounds,
> +        // because the caller of this function promises that `ptr` points to an
> +        // allocation of at least the size of `Self`.
> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer)) }
> +    }
> +
> +    /// Cancel an initialized and potentially running timer.
> +    ///
> +    /// If the timer handler is running, this will block until the handler is
> +    /// finished.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `self_ptr` must point to a valid `Self`.
> +    #[allow(dead_code)]
> +    pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
> +        // SAFETY: timer_ptr points to an allocation of at least `Timer` size.
> +        let c_timer_ptr = unsafe { Timer::raw_get(self_ptr) };
> +
> +        // If handler is running, this will wait for handler to finish before
> +        // returning.
> +        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronization is
> +        // handled on C side.
> +        unsafe { bindings::hrtimer_cancel(c_timer_ptr) != 0 }
> +    }
> +}
> +
> +/// Implemented by pointer types that point to structs that embed a [`Timer`].
> +///
> +/// Typical implementers would be [`Box<T>`], [`Arc<T>`], [`ARef<T>`] where `T`
> +/// has a field of type `Timer`.
> +///
> +/// Target must be [`Sync`] because timer callbacks happen in another thread of
> +/// execution (hard or soft interrupt context).
> +///
> +/// Starting a timer returns a [`TimerHandle`] that can be used to manipulate
> +/// the timer. Note that it is OK to call the start function repeatedly, and
> +/// that more than one [`TimerHandle`] associated with a `TimerPointer` may
> +/// exist. A timer can be manipulated through any of the handles, and a handle
> +/// may represent a cancelled timer.
> +///
> +/// [`Box<T>`]: Box
> +/// [`Arc<T>`]: crate::sync::Arc
> +/// [`ARef<T>`]: crate::types::ARef
> +pub trait TimerPointer: Sync + Sized {
> +    /// A handle representing a running timer.
> +    ///
> +    /// If the timer is running or if the timer callback is executing when the
> +    /// handle is dropped, the drop method of `TimerHandle` should not return
> +    /// until the timer is stopped and the callback has completed.
> +    ///
> +    /// Note: It must be safe to leak the handle.
> +    type TimerHandle: TimerHandle;
> +
> +    /// Start the timer with expiry after `expires` time units. If the timer was
> +    /// already running, it is restarted with the new expiry time.
> +    fn start(self, expires: Ktime) -> Self::TimerHandle;
> +}
> +
> +/// Implemented by [`TimerPointer`] implementers to give the C timer callback a
> +/// function to call.
> +// This is split from `TimerPointer` to make it easier to specify trait bounds.
> +pub trait RawTimerCallback {

RawHrtimerCallback ?

> +    /// Callback to be called from C when timer fires.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Only to be called by C code in `hrtimer` subsystem. `ptr` must point to
> +    /// the `bindings::hrtimer` structure that was used to start the timer.
> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart;
> +}
> +
> +/// Implemented by structs that can the target of a timer callback.
> +pub trait TimerCallback {

HrtimerCallback ? etc...

Thanks.

