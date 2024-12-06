Return-Path: <linux-kernel+bounces-435538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F159E7919
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E6E280AAF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4021C5492;
	Fri,  6 Dec 2024 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBnPsseE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4BF1C5484;
	Fri,  6 Dec 2024 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513766; cv=none; b=tzXffy8FiuneETDIx8KSBT+zf7asNBHtVKUvL1b1JCcwFQuJhWGqAyL/xHqJNJXQXOgXagLACCxE1yoRquHo9dRl6qPhvhPQeVTBK/tqwLr2EBUD0QplMBRVgdYmd+KguVghQ6SCrBA3wEsF66quMYp8ln96o4vVXRQCUydbnXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513766; c=relaxed/simple;
	bh=ublZLWv1E1rcxjkqUotDhS0XzBr2tkNHdg+FC/Wpxd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=APtS3oFyeKWzf08hY63tuaY52rLFWoi4jp5sdOtNC1C5/TU3KcBm6sTLwW6hlI6/JaAunDkE5UmRuNWp5DQomzORZ3YS//cCF8iELqra8w8D5tsgwsB740Dy37jqlLZxom6xvgwkUsu4IJULtWlJYPh8vyqXh1HwJ+ybY55eSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBnPsseE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614BCC4CED1;
	Fri,  6 Dec 2024 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513765;
	bh=ublZLWv1E1rcxjkqUotDhS0XzBr2tkNHdg+FC/Wpxd0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oBnPsseExF0lvkduzs5abODLrWSpqbAW4anugmIyRd2XN04dseQOxoD+ZkMZsRvkH
	 XKUIVme0TMOCIGNMI2MK37SSN2OYrjs7zqbFiCh091SwsR7wt8zzdn/FWLUvzeWJ5/
	 MMETgH1yLPfuyDx342Uv/4wA+JYmJfc+DE51FZdecBe4mENgYNcYhz51CNozh8kOuH
	 AzozeOx+TMIfafj9Jxm1FPURlHME9PfnREZZNzD+8R14i7siWMbdXF1i9s4sgC22Az
	 WxbswO7UpSGBBDdeOQFLkj4g5mCLohIt6C2YELRqHfspZaObcjWR9ibNHeM8qEmq/3
	 MgzdDDGAd8grw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:32:54 +0100
Subject: [PATCH v4 02/14] rust: hrtimer: introduce hrtimer support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-2-6cb8c3673682@kernel.org>
References: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
In-Reply-To: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12285;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=ublZLWv1E1rcxjkqUotDhS0XzBr2tkNHdg+FC/Wpxd0=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVdvZFcwNGVhQ05PMGZ3ZmFzbklCNnhNCkFkQUY2VnRSdlRYZmFtKy9u
 TkhXRElrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRnF
 BQW9KRU9HNEdqNTVLR04zKzdZUC9pS1JEeUpIZEVNREVtcHZ2WlFKcXA3TWErWkF2NEhLUkFiZw
 orZUUzZlZjbkRrZkZSV0hVWFBPUUgwQUxObGZWS0pIK2NpcXZlTWhmaGg3cS9qTkJVVmRlU1J2V
 FVyZldUZU9qCnpWbExkWUFDZ0F5VjhKYTZ4WWcyV0FRTHpxL0xFdjM1SEo1cmVMcW9hYXg4RzMv
 ZGlJeXF6eFNiS0xmMmdXUXIKejVBR3o5Y0RsMlYxMUJ5cUdmS04wbExKdTlsVXBCOEdhQUVZaHB
 QRHJFM3JYMXk4aEU4aUlZd3JncUh1dDAzSApLN1R6bDJ4SzJGbStIVVlTN0ZiVFIyVHRDZGhGRz
 hYckRJSnZFdjVDUExIQmJpeTZNSGZVdjliNTZsRmRLL3pJCkIyY0I1b3NBTlBGRFIrY0pVZDR4R
 kNxaHMrUzk3ZDlyNFY2aEtjSkpoZXM1Y01BMWZMOXJTaTcvSGRUdEVXcisKRTVqbkZzcDlpU3lJ
 bDlYTy9yb3k4S1JRL0pjeDNXTmRrbnN5U1JqRVJJbTEyd3QwYkRHZld2YkdRcHhMYXlLSApvSHd
 zblByR3NDOFBhTkxkYkF4RjM5YjIwSkN3YzlIckJZd2ZoRG8zNW1CeWJBTzVPVTBvM1hBMjBiWj
 k4UGwxCkpkYWZab0R5Z0F6SmhueHhXcHVLRC9wMVpXaGZjMFNWQTY5ZDhaR3lkTERLUWxraVl2Z
 2lzeExzajVTNEg1UFkKT3praVpzMldkRUhubTdiYm50OXVQOHpNOHh0RnkrRkFER3czM0lWeXEv
 SjJ5cFpKNC85R2c1MkhFNGMwNkVObgpqVVlFVVIvZ1lOTlZsWHVQLzcxODBXR2tBR3J3a3A5Uk9
 oTzBwcEJNcFNRd1VQZGVTa0VoaTgxM1dsSUkxZUdPCmhLMTA5UmVhU0g0bjNBPT0KPU1kOEMKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This patch adds support for intrusive use of the hrtimer system. For now,
only one timer can be embedded in a Rust struct.

The hrtimer Rust API is based on the intrusive style pattern introduced by
the Rust workqueue API.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time.rs         |   2 +
 rust/kernel/time/hrtimer.rs | 296 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 298 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index f59e0fea79d3acfddd922f601f569353609aeec1..51c3532eee0184495ed5b7d717860c9980ff2a43 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -10,6 +10,8 @@
 
 use core::convert::Into;
 
+pub mod hrtimer;
+
 /// The number of nanoseconds per millisecond.
 pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
 
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
new file mode 100644
index 0000000000000000000000000000000000000000..646cd5bfa6623aec62294f9115fbf6fedc0a426c
--- /dev/null
+++ b/rust/kernel/time/hrtimer.rs
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Intrusive high resolution timers.
+//!
+//! Allows running timer callbacks without doing allocations at the time of
+//! starting the timer. For now, only one timer per type is allowed.
+//!
+//! # Vocabulary
+//!
+//! A timer is initialized in the **stopped** state. A stopped timer can be
+//! **started** with an **expiry** time. After the timer is started, it is
+//! **running**. When the timer **expires**, the timer handler is executed.
+//! After the handler has executed, the timer may be **restarted** or
+//! **stopped**. A running timer can be **cancelled** before it's handler is
+//! executed. A timer that is cancelled enters the **stopped** state.
+//!
+//! States:
+//!
+//! * Stopped
+//! * Running
+//!
+//! Operations:
+//!
+//! * Start
+//! * Cancel
+//! * Stop
+//! * Restart
+//!
+//! Events:
+//!
+//! * Expire
+
+use crate::{init::PinInit, prelude::*, time::Ktime, types::Opaque};
+use core::marker::PhantomData;
+
+/// A timer backed by a C `struct hrtimer`.
+///
+/// # Invariants
+///
+/// * `self.timer` is initialized by `bindings::hrtimer_setup`.
+#[pin_data]
+#[repr(C)]
+pub struct Timer<U> {
+    #[pin]
+    timer: Opaque<bindings::hrtimer>,
+    _t: PhantomData<U>,
+}
+
+// SAFETY: A `Timer` can be moved to other threads and used/dropped from there.
+unsafe impl<U> Send for Timer<U> {}
+
+// SAFETY: Timer operations are locked on C side, so it is safe to operate on a
+// timer from multiple threads
+unsafe impl<U> Sync for Timer<U> {}
+
+impl<T> Timer<T> {
+    /// Return an initializer for a new timer instance.
+    pub fn new() -> impl PinInit<Self>
+    where
+        T: TimerCallback,
+    {
+        pin_init!(Self {
+            // INVARIANTS: We initialize `timer` with `hrtimer_setup` below.
+            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtimer| {
+                // SAFETY: By design of `pin_init!`, `place` is a pointer live
+                // allocation. hrtimer_setup will initialize `place` and does
+                // not require `place` to be initialized prior to the call.
+                unsafe {
+                    bindings::hrtimer_setup(
+                        place,
+                        Some(T::CallbackTarget::run),
+                        bindings::CLOCK_MONOTONIC as i32,
+                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                    );
+                }
+            }),
+            _t: PhantomData,
+        })
+    }
+
+    /// Get a pointer to the contained `bindings::hrtimer`.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to a live allocation of at least the size of `Self`.
+    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
+        // SAFETY: The field projection to `timer` does not go out of bounds,
+        // because the caller of this function promises that `ptr` points to an
+        // allocation of at least the size of `Self`.
+        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer)) }
+    }
+
+    /// Cancel an initialized and potentially running timer.
+    ///
+    /// If the timer handler is running, this will block until the handler is
+    /// finished.
+    ///
+    /// # Safety
+    ///
+    /// `self_ptr` must point to a valid `Self`.
+    #[allow(dead_code)]
+    pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
+        // SAFETY: timer_ptr points to an allocation of at least `Timer` size.
+        let c_timer_ptr = unsafe { Timer::raw_get(self_ptr) };
+
+        // If handler is running, this will wait for handler to finish before
+        // returning.
+        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronization is
+        // handled on C side.
+        unsafe { bindings::hrtimer_cancel(c_timer_ptr) != 0 }
+    }
+}
+
+/// Implemented by pointer types that point to structs that embed a [`Timer`].
+///
+/// Typical implementers would be [`Box<T>`], [`Arc<T>`], [`ARef<T>`] where `T`
+/// has a field of type `Timer`.
+///
+/// Target must be [`Sync`] because timer callbacks happen in another thread of
+/// execution (hard or soft interrupt context).
+///
+/// Starting a timer returns a [`TimerHandle`] that can be used to manipulate
+/// the timer. Note that it is OK to call the start function repeatedly, and
+/// that more than one [`TimerHandle`] associated with a `TimerPointer` may
+/// exist. A timer can be manipulated through any of the handles, and a handle
+/// may represent a cancelled timer.
+///
+/// [`Box<T>`]: Box
+/// [`Arc<T>`]: crate::sync::Arc
+/// [`ARef<T>`]: crate::types::ARef
+pub trait TimerPointer: Sync + Sized {
+    /// A handle representing a running timer.
+    ///
+    /// If the timer is running or if the timer callback is executing when the
+    /// handle is dropped, the drop method of `TimerHandle` should not return
+    /// until the timer is stopped and the callback has completed.
+    ///
+    /// Note: It must be safe to leak the handle.
+    type TimerHandle: TimerHandle;
+
+    /// Start the timer with expiry after `expires` time units. If the timer was
+    /// already running, it is restarted with the new expiry time.
+    fn start(self, expires: Ktime) -> Self::TimerHandle;
+}
+
+/// Implemented by [`TimerPointer`] implementers to give the C timer callback a
+/// function to call.
+// This is split from `TimerPointer` to make it easier to specify trait bounds.
+pub trait RawTimerCallback {
+    /// Callback to be called from C when timer fires.
+    ///
+    /// # Safety
+    ///
+    /// Only to be called by C code in `hrtimer` subsystem. `ptr` must point to
+    /// the `bindings::hrtimer` structure that was used to start the timer.
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart;
+}
+
+/// Implemented by structs that can the target of a timer callback.
+pub trait TimerCallback {
+    /// The type that was used for starting the timer.
+    type CallbackTarget<'a>: RawTimerCallback;
+
+    /// This type is passed to the timer callback function. It may be a borrow
+    /// of [`Self::CallbackTarget`], or it may be `Self::CallbackTarget` if the
+    /// implementation can guarantee exclusive access to the target during timer
+    /// handler execution.
+    type CallbackTargetParameter<'a>;
+
+    /// Called by the timer logic when the timer fires.
+    fn run(this: Self::CallbackTargetParameter<'_>)
+    where
+        Self: Sized;
+}
+
+/// A handle representing a potentially running timer.
+///
+/// More than one handle representing the same timer might exist.
+///
+/// # Safety
+///
+/// When dropped, the timer represented by this handle must be cancelled, if it
+/// is running. If the timer handler is running when the handle is dropped, the
+/// drop method must wait for the handler to finish before returning.
+pub unsafe trait TimerHandle {
+    /// Cancel the timer, if it is running. If the timer handler is running, block
+    /// till the handler has finished.
+    fn cancel(&mut self) -> bool;
+}
+
+/// Implemented by structs that contain timer nodes.
+///
+/// Clients of the timer API would usually safely implement this trait by using
+/// the [`impl_has_timer`] macro.
+///
+/// # Safety
+///
+/// Implementers of this trait must ensure that the implementer has a [`Timer`]
+/// field at the offset specified by `OFFSET` and that all trait methods are
+/// implemented according to their documentation.
+///
+/// [`impl_has_timer`]: crate::impl_has_timer
+pub unsafe trait HasTimer<U> {
+    /// Offset of the [`Timer`] field within `Self`
+    const OFFSET: usize;
+
+    /// Return a pointer to the [`Timer`] within `Self`.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to a valid struct of type `Self`.
+    unsafe fn raw_get_timer(ptr: *const Self) -> *const Timer<U> {
+        // SAFETY: By the safety requirement of this trait, the trait
+        // implementor will have a `Timer` field at the specified offset.
+        unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast::<Timer<U>>() }
+    }
+
+    /// Return a pointer to the struct that is embedding the [`Timer`] pointed
+    /// to by `ptr`.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to a [`Timer<U>`] field in a struct of type `Self`.
+    unsafe fn timer_container_of(ptr: *mut Timer<U>) -> *mut Self
+    where
+        Self: Sized,
+    {
+        // SAFETY: By the safety requirement of this function and the `HasTimer`
+        // trait, the following expression will yield a pointer to the `Self`
+        // containing the timer addressed by `ptr`.
+        unsafe { ptr.cast::<u8>().sub(Self::OFFSET).cast::<Self>() }
+    }
+
+    /// Get pointer to embedded `bindings::hrtimer` struct.
+    ///
+    /// # Safety
+    ///
+    /// `self_ptr` must point to a valid `Self`.
+    unsafe fn c_timer_ptr(self_ptr: *const Self) -> *const bindings::hrtimer {
+        // SAFETY: `self_ptr` is a valid pointer to a `Self`.
+        let timer_ptr = unsafe { Self::raw_get_timer(self_ptr) };
+
+        // SAFETY: timer_ptr points to an allocation of at least `Timer` size.
+        unsafe { Timer::raw_get(timer_ptr) }
+    }
+
+    /// Start the timer contained in the `Self` pointed to by `self_ptr`. If
+    /// it is already running it is removed and inserted.
+    ///
+    /// # Safety
+    ///
+    /// `self_ptr` must point to a valid `Self`.
+    unsafe fn start(self_ptr: *const Self, expires: Ktime) {
+        // SAFETY: By function safety requirement, `self_ptr`is a valid `Self`.
+        unsafe {
+            bindings::hrtimer_start_range_ns(
+                Self::c_timer_ptr(self_ptr).cast_mut(),
+                expires.to_ns(),
+                0,
+                bindings::hrtimer_mode_HRTIMER_MODE_REL,
+            );
+        }
+    }
+}
+
+/// Use to implement the [`HasTimer<T>`] trait.
+///
+/// See [`module`] documentation for an example.
+///
+/// [`module`]: crate::time::hrtimer
+#[macro_export]
+macro_rules! impl_has_timer {
+    (
+        impl$({$($generics:tt)*})?
+            HasTimer<$timer_type:ty>
+            for $self:ty
+        { self.$field:ident }
+        $($rest:tt)*
+    ) => {
+        // SAFETY: This implementation of `raw_get_timer` only compiles if the
+        // field has the right type.
+        unsafe impl$(<$($generics)*>)? $crate::time::hrtimer::HasTimer<$timer_type> for $self {
+            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
+
+            #[inline]
+            unsafe fn raw_get_timer(ptr: *const Self) ->
+                *const $crate::::time::hrtimer::Timer<$timer_type>
+            {
+                // SAFETY: The caller promises that the pointer is not dangling.
+                unsafe {
+                    ::core::ptr::addr_of!((*ptr).$field)
+                }
+            }
+        }
+    }
+}

-- 
2.46.0



