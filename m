Return-Path: <linux-kernel+bounces-551091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C48C0A5680A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE793B5AE7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E2F219A8B;
	Fri,  7 Mar 2025 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FROA8mr9"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4CA219316;
	Fri,  7 Mar 2025 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351415; cv=none; b=ctXoZKkDQoWVQ9Ru0f803EZEbjs9VE1gcK2VaV4AhrOeiu8wjSLKTqSSNT9oRh7mK+nhccO+oeqA802Tn22w85DSwUr3PjxJkX8GoBhGuxQ4OcvoozTEvez+TvQrJij6vqpIGN9r/nELqejs+WR6+Ogz1R2zIQnxEvFew6V9XKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351415; c=relaxed/simple;
	bh=i7Sd/IexCJ/8cx3UsTc10kPl1K7+vLdPTwfUHg6rkXA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKAo23alTsb6MgpMMYbBrUN2TWCEFaL8owSPgsRPPcxLYIdlj5m0lyg/BjOXhSZvL27PewRhWFdWk6wQghcu+HdJczt4BrslXrS+AzrZ8PUtOGfWaL9W9+8y0NdDs6o5YKhV/IRwYwOFSZ4s6hg+0IHQpgkAt3TBucAfj6ZXq1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FROA8mr9; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741351404; x=1741610604;
	bh=RjJiyaGxRHXxlEa/8DxSIVsHSFPet/v8eDHYm9wD3VY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FROA8mr9y8qT2iOrg/UvAV6GD5Xv8OmAMluZcn6bj4cS+RjWumjn2lVGx8aamg4He
	 nP1W4y+/+9cBI/71+pJLEfSz5+/H3BhBi+ZPWPgJLPbdXWQpqFLlFoWut6s7jALfUL
	 szpwXp6rXgKI6M9RRcTyk/O/tVO1928rJhXccPe9tOJMrPQFjTxPCbGf+COXLvHstU
	 N19dHNVaV4RW0qOdRJ6rngAwzpGFeAi7HEqBsa/m4NboA52jVtqv5OnZx8eM6Pzyf+
	 H7gUWxq6YPE5h+pJB8OZDTQAivJ6J+ZKNVLcyc7MiMywPT7jzx+4CvTjt4HFU1S/HM
	 9injDWf6erkeg==
Date: Fri, 07 Mar 2025 12:43:18 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 01/13] rust: hrtimer: introduce hrtimer support
Message-ID: <D8A1JVVYBHY5.13BB8V796A7RR@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-1-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-1-0cf7e9491da4@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 34424600773bb8b01a1a77c481c0000781a1051d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
> Add support for intrusive use of the hrtimer system. For now,
> only add support for embedding one timer per Rust struct.
>
> The hrtimer Rust API is based on the intrusive style pattern introduced b=
y
> the Rust workqueue API.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Some smaller changes below, with those fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>  rust/kernel/time.rs         |   2 +
>  rust/kernel/time/hrtimer.rs | 359 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 361 insertions(+)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 379c0f5772e5..fab1dadfa589 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -8,6 +8,8 @@
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.=
h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>
> +pub mod hrtimer;
> +
>  /// The number of nanoseconds per millisecond.
>  pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> new file mode 100644
> index 000000000000..7d7d490f8b6f
> --- /dev/null
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -0,0 +1,359 @@
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
> +//! - Stopped: initialized but not started, or cancelled, or not restart=
ed.
> +//! - Started: initialized and started or restarted.
> +//! - Running: executing the callback.
> +//!
> +//! Operations:
> +//!
> +//! * Start
> +//! * Cancel
> +//! * Restart
> +//!
> +//! Events:
> +//!
> +//! * Expire
> +//!
> +//! ## State Diagram
> +//!
> +//! ```text
> +//!                                                   Return NoRestart
> +//!                       +---------------------------------------------=
------------------------+
> +//!                       |                                             =
                        |
> +//!                       |                                             =
                        |
> +//!                       |                                             =
                        |
> +//!                       |                                         Retu=
rn Restart              |
> +//!                       |                                      +------=
------------------+     |
> +//!                       |                                      |      =
                  |     |
> +//!                       |                                      |      =
                  |     |
> +//!                       v                                      v      =
                  |     |
> +//!           +-----------------+      Start      +------------------+  =
         +--------+-----+--+
> +//!           |                 +---------------->|                  |  =
         |                 |
> +//! Init      |                 |                 |                  |  =
Expire   |                 |
> +//! --------->|    Stopped      |                 |      Started     +--=
-------->|     Running     |
> +//!           |                 |     Cancel      |                  |  =
         |                 |
> +//!           |                 |<----------------+                  |  =
         |                 |
> +//!           +-----------------+                 +---------------+--+  =
         +-----------------+
> +//!                                                     ^         |
> +//!                                                     |         |
> +//!                                                     +---------+
> +//!                                                      Restart
> +//! ```
> +//!
> +//!
> +//! A timer is initialized in the **stopped** state. A stopped timer can=
 be
> +//! **started** by the `start` operation, with an **expiry** time. After=
 the
> +//! `start` operation, the timer is in the **started** state. When the t=
imer
> +//! **expires**, the timer enters the **running** state and the handler =
is
> +//! executed. After the handler has returned, the timer may enter the
> +//! **started* or **stopped** state, depending on the return value of th=
e
> +//! handler. A timer in the **started** or **running** state may be **ca=
nceled**
> +//! by the `cancel` operation. A timer that is cancelled enters the **st=
opped**
> +//! state.

This looks very nice, thanks!

> +//!
> +//! A `cancel` or `restart` operation on a timer in the **running** stat=
e takes
> +//! effect after the handler has returned and the timer has transitioned
> +//! out of the **running** state.
> +//!
> +//! A `restart` operation on a timer in the **stopped** state is equival=
ent to a
> +//! `start` operation.
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
> +// SAFETY: Timer operations are locked on the C side, so it is safe to o=
perate
> +// on a timer from multiple threads.
> +unsafe impl<T> Sync for HrTimer<T> {}
> +
> +impl<T> HrTimer<T> {
> +    /// Return an initializer for a new timer instance.
> +    pub fn new() -> impl PinInit<Self>
> +    where
> +        T: HrTimerCallback,
> +    {
> +        pin_init!(Self {
> +            // INVARIANT: We initialize `timer` with `hrtimer_setup` bel=
ow.
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
> +                        Some(T::Pointer::run),
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
> +    /// This function is useful to get access to the value without creat=
ing
> +    /// intermediate references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `this` must point to a live allocation of at least the size of `=
Self`.
> +    unsafe fn raw_get(this: *const Self) -> *mut bindings::hrtimer {
> +        // SAFETY: The field projection to `timer` does not go out of bo=
unds,
> +        // because the caller of this function promises that `this` poin=
ts to an
> +        // allocation of at least the size of `Self`.
> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*this).timer)) }
> +    }
> +
> +    /// Cancel an initialized and potentially running timer.
> +    ///
> +    /// If the timer handler is running, this function will block until =
the
> +    /// handler returns.
> +    ///
> +    /// Note that the timer might be started by a concurrent start opera=
tion. If
> +    /// so, the timer might not be in the **stopped** state when this fu=
nction
> +    /// returns.
> +    ///
> +    /// Users of the `HrTimer` API would not usually call this method di=
rectly.
> +    /// Instead they would use the safe [`HrTimerHandle::cancel`] on the=
 handle
> +    /// returned when the timer was started.
> +    ///
> +    /// This function is useful to get access to the value without creat=
ing
> +    /// intermediate references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `this` must point to a valid `Self`.
> +    #[allow(dead_code)]
> +    pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
> +        // SAFETY: `this` points to an allocation of at least `HrTimer` =
size.
> +        let c_timer_ptr =3D unsafe { HrTimer::raw_get(this) };
> +
> +        // If the handler is running, this will wait for the handler to =
return
> +        // before returning.
> +        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronizati=
on is
> +        // handled on the C side.
> +        unsafe { bindings::hrtimer_cancel(c_timer_ptr) !=3D 0 }
> +    }
> +}
> +
> +/// Implemented by pointer types that point to structs that contain a [`=
HrTimer`].
> +///
> +/// `Self` must be [`Sync`] because it is passed to timer callbacks in a=
nother
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
> +    /// This type is passed to [`HrTimerCallback::run`]. It may be a bor=
row of
> +    /// [`Self::CallbackTarget`], or it may be `Self::CallbackTarget` if=
 the

This part of the docs no longer makes sense. You probably mean to say
`Self` instead, right?

> +    /// implementation can guarantee correct access (exclusive or shared
> +    /// depending on the type) to the target during timer handler execut=
ion.
> +    type CallbackTarget<'a>;
> +
> +    /// Callback to be called from C when timer fires.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Only to be called by C code in the `hrtimer` subsystem. `this` m=
ust point
> +    /// to the `bindings::hrtimer` structure that was used to start the =
timer.
> +    unsafe extern "C" fn run(this: *mut bindings::hrtimer) -> bindings::=
hrtimer_restart;
> +}
> +
> +/// Implemented by structs that can be the target of a timer callback.
> +pub trait HrTimerCallback {
> +    /// The type whose [`RawHrTimerCallback::run`] method will be invoke=
d when
> +    /// the timer expires.
> +    type Pointer<'a>: RawHrTimerCallback;
> +
> +    /// Called by the timer logic when the timer fires.
> +    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarg=
et<'_>)
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
> +/// drop method must wait for the handler to return before returning.
> +///
> +/// Note: One way to satisfy the safety requirement is to call `Self::ca=
ncel` in
> +/// the drop implementation for `Self.`
> +pub unsafe trait HrTimerHandle {
> +    /// Cancel the timer. If the timer is in the running state, block ti=
ll the
> +    /// handler has returned.
> +    ///
> +    /// Note that the timer might be started by a concurrent start opera=
tion. If
> +    /// so, the timer might not be in the **stopped** state when this fu=
nction
> +    /// returns.
> +    ///
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

This link is unused.

> +pub unsafe trait HasHrTimer<T> {
> +    /// Return a pointer to the [`HrTimer`] within `Self`.
> +    ///
> +    /// This function is useful to get access to the value without creat=
ing
> +    /// intermediate references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `this` must point to a valid struct of type `Self`.

I don't think that this is the correct requirement. The pointer `this`
must be valid (i.e. dereferenceable), but the value that we're pointing
at doesn't have to be valid, right?

Same below.

> +    unsafe fn raw_get_timer(this: *const Self) -> *const HrTimer<T>;
> +
> +    /// Return a pointer to the struct that is containing the [`HrTimer`=
] pointed
> +    /// to by `ptr`.
> +    ///
> +    /// This function is useful to get access to the value without creat=
ing
> +    /// intermediate references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to a [`HrTimer<T>`] field in a struct of type `=
Self`.
> +    unsafe fn timer_container_of(ptr: *mut HrTimer<T>) -> *mut Self
> +    where
> +        Self: Sized;
> +
> +    /// Get pointer to the contained `bindings::hrtimer` struct.
> +    ///
> +    /// This function is useful to get access to the value without creat=
ing
> +    /// intermediate references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `this` must point to a valid `Self`.
> +    unsafe fn c_timer_ptr(this: *const Self) -> *const bindings::hrtimer=
 {
> +        // SAFETY: `this` is a valid pointer to a `Self`.
> +        let timer_ptr =3D unsafe { Self::raw_get_timer(this) };
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
> +    /// - `this` must point to a valid `Self`.

Here the requirement is correct, since you need that for
`hrtimer_start_range_ns`.

> +    /// - Caller must ensure that `self` lives until the timer fires or =
is

There is no `self`, do you mean the value living behind `this`?

> +    ///   canceled.
> +    unsafe fn start(this: *const Self, expires: Ktime) {
> +        // SAFETY: By function safety requirement, `this`is a valid `Sel=
f`.
> +        unsafe {
> +            bindings::hrtimer_start_range_ns(
> +                Self::c_timer_ptr(this).cast_mut(),
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
> +
> +            #[inline]
> +            unsafe fn raw_get_timer(this: *const Self) ->
> +                *const $crate::time::hrtimer::HrTimer<$timer_type>
> +            {
> +                // SAFETY: The caller promises that the pointer is not d=
angling.
> +                unsafe {
> +                    ::core::ptr::addr_of!((*this).$field)
> +                }
> +            }
> +
> +            #[inline]
> +            unsafe fn timer_container_of(ptr: *mut $crate::time::hrtimer=
::HrTimer<$timer_type>) ->
> +                *mut Self

This formatting looks a bit weird, (macro formatting is annoying, I
know).

---
Cheers,
Benno

> +            {
> +                // SAFETY: As per the safety requirement of this functio=
n, `ptr`
> +                // is pointing inside a `$timer_type`.
> +                unsafe {
> +                    ::kernel::container_of!(ptr, $timer_type, $field).ca=
st_mut()
> +                }
> +            }
> +        }
> +    }
> +}
>
> --
> 2.47.0



