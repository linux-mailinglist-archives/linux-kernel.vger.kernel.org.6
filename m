Return-Path: <linux-kernel+bounces-519524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B2DA39DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AFD178090
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6405A26F44A;
	Tue, 18 Feb 2025 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMNBD1SP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DAB26A0B9;
	Tue, 18 Feb 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885348; cv=none; b=Iwuq+s/DDEDCXwzwgMSqRJTu4zGj/NV6T/18tAFRT7Dzcg/1gev/fA9UCVvyAWd8L3AUrFJvIBcn+OukF4SC24K+eagSb3qvy7REpOifYixgSmibEkv13jdNHUaJoDoxHqCyQ6ZVtYE+bLutVUT0bDXw2Wwm/Ysj8KSW3yCqvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885348; c=relaxed/simple;
	bh=lN5+CQUa4AoWls2NexT8gnVu15FEJjN7LDCy+Mvwpaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ct5IK6swJTXqTEXIYPyZ6o0kVTdUGd68yiRfh1fWR2Sasq/9pRw0Xa5/GbliWUi9YNEzkQdnoXPl2Ke/pjgoAWg5hdvpSwSZblKWZr11b/IHblJ1xuM2Tt4t+rcT2bIwuihAAYonaDDlrfwqxIIodbxgnv/JLl8PmBFcF8Z58B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMNBD1SP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F710C4CEE2;
	Tue, 18 Feb 2025 13:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885347;
	bh=lN5+CQUa4AoWls2NexT8gnVu15FEJjN7LDCy+Mvwpaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YMNBD1SP/DpipE58/znMXXuyAqf1wwz+MvJsKr0bq41g3P3nboHD5WNcewX3lOYiq
	 V/aAeScIC8w2lQaze4G3CTWvMSZ1fhh3yC6vEbULTAb5FSrgtpwaJRPkO6vPj/mJXQ
	 zxBLtZf3Xfw2S09+tH4+j1Kgg5+/AZdoKrzrAcYKPblBeE/VSjb7RTY7r8LGYtkqrD
	 rYpjc563sI3lP5Md7zY6CiKrL46PzFj+dOmCSEpe1IpvQ+cIfYusoQgh5C0k4bJ4dl
	 Q6U8dgbFiYnKSZFldRkpOFV1R5zTjnnB0pz58FrIZ0u62M5G48eaiw7c3C352jBJhR
	 cw1pBpwMP7cyA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:07 +0100
Subject: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12939;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=lN5+CQUa4AoWls2NexT8gnVu15FEJjN7LDCy+Mvwpaw=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIqw79p81DLuM018ujkNjgAGnd4KPAZZFdwRS
 AeP1d7LFJuJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKsAAKCRDhuBo+eShj
 dyRjD/9flCn4gLkNwCOwd4k1/H81j7DJqYloo8Shkr1yQa1PpjxJ7se5mYMGviWpdfk4P0CVoDg
 cZt3D23jBVoTSM2BLMrrKiAVtl4kSyg7vYcNaUGi3evTbweXtp02/r7OlTqEblYNXjtNvp5ABQl
 XXC1SR0dS4xfcyc8gyb90dVDV5NGGQ+JQI8U5kXgTcj4ruSJviAgSF6DWedfbm0yVmYCmlRfo7j
 Vpjg09pUI/DhweHtT4DZ+exT5wDsSaf7gmQM+PyWA98yQU/AAxcw23zafZ7xpzikJdINjAOdAqx
 Ei4Cx4cyGPmuMaw4ZyknFSoFI5NnxV2Nua9tweKTU3QApu9oK1xkmcCGrW5hKANvTCvcrfBSx+7
 fWsAeK46ycNgSyY55rZUXDval/qBFO3w30WrqyZracg8y0KEglniYgdEGESH0P0ae7YCWyQjmcv
 4ZcklJgORCE1A9BQXycbl4Jtww3FsuOlKggHOzEssNpYdRLVsgVe6mqpcSAhds/wUUYRjLwkhir
 0ylWLB0LX0Oz1lMq+g3qmICJn0N+IApXcju5l4lcJJVDKfKiTwUAsYQUvU2YnT0+vV4afiDWR1M
 KyOzEXJHcuxN49cnFXYd9L8B2bQ051TX8LhJKoY6AoLSrutrpqUIsXDk15TA458R2qc/Onhuewm
 8r5ifNIVup1I7fQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This patch adds support for intrusive use of the hrtimer system. For now,
only one timer can be embedded in a Rust struct.

The hrtimer Rust API is based on the intrusive style pattern introduced by
the Rust workqueue API.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time.rs         |   2 +
 rust/kernel/time/hrtimer.rs | 312 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 314 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 87e47f2f5618d..2cf365cfb412e 100644
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
index 0000000000000..a6332924efabd
--- /dev/null
+++ b/rust/kernel/time/hrtimer.rs
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Intrusive high resolution timers.
+//!
+//! Allows running timer callbacks without doing allocations at the time of
+//! starting the timer. For now, only one timer per type is allowed.
+//!
+//! # Vocabulary
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
+//!
+//! ## State Diagram
+//!
+//! ```text
+//!                  <-- Stop ----
+//!                  <-- Cancel --
+//!                  --- Start -->
+//!        +---------+        +---------+
+//!   O--->| Stopped |        | Running |---o
+//!        +---------+        +---------+   |
+//!                                  ^      |
+//!                  <- Expire --    |      |
+//!                                  o------o
+//!                                   Restart
+//! ```
+//!
+//! A timer is initialized in the **stopped** state. A stopped timer can be
+//! **started** with an **expiry** time. After the timer is started, it is
+//! **running**. When the timer **expires**, the timer handler is executed.
+//! After the handler has executed, the timer may be **restarted** or
+//! **stopped**. A running timer can be **canceled** before it's handler is
+//! executed. A timer that is cancelled enters the **stopped** state.
+//!
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
+pub struct HrTimer<T> {
+    #[pin]
+    timer: Opaque<bindings::hrtimer>,
+    _t: PhantomData<T>,
+}
+
+// SAFETY: Ownership of an `HrTimer` can be moved to other threads and
+// used/dropped from there.
+unsafe impl<T> Send for HrTimer<T> {}
+
+// SAFETY: Timer operations are locked on C side, so it is safe to operate on a
+// timer from multiple threads
+unsafe impl<T> Sync for HrTimer<T> {}
+
+impl<T> HrTimer<T> {
+    /// Return an initializer for a new timer instance.
+    pub fn new() -> impl PinInit<Self>
+    where
+        T: HrTimerCallback,
+    {
+        pin_init!(Self {
+            // INVARIANTS: We initialize `timer` with `hrtimer_setup` below.
+            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtimer| {
+                // SAFETY: By design of `pin_init!`, `place` is a pointer to a
+                // live allocation. hrtimer_setup will initialize `place` and
+                // does not require `place` to be initialized prior to the call.
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
+    /// Users of the `HrTimer` API would not usually call this method directly.
+    /// Instead they would use the safe `cancel` method on the [`HrTimerHandle`]
+    /// returned when the timer was started.
+    ///
+    /// # Safety
+    ///
+    /// `self_ptr` must point to a valid `Self`.
+    #[allow(dead_code)]
+    pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
+        // SAFETY: timer_ptr points to an allocation of at least `HrTimer` size.
+        let c_timer_ptr = unsafe { HrTimer::raw_get(self_ptr) };
+
+        // If the handler is running, this will wait for the handler to finish
+        // before returning.
+        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronization is
+        // handled on C side.
+        unsafe { bindings::hrtimer_cancel(c_timer_ptr) != 0 }
+    }
+}
+
+/// Implemented by pointer types that point to structs that embed a [`HrTimer`].
+///
+/// Target (pointee) must be [`Sync`] because timer callbacks happen in another
+/// thread of execution (hard or soft interrupt context).
+///
+/// Starting a timer returns a [`HrTimerHandle`] that can be used to manipulate
+/// the timer. Note that it is OK to call the start function repeatedly, and
+/// that more than one [`HrTimerHandle`] associated with a [`HrTimerPointer`] may
+/// exist. A timer can be manipulated through any of the handles, and a handle
+/// may represent a cancelled timer.
+pub trait HrTimerPointer: Sync + Sized {
+    /// A handle representing a started or restarted timer.
+    ///
+    /// If the timer is running or if the timer callback is executing when the
+    /// handle is dropped, the drop method of [`HrTimerHandle`] should not return
+    /// until the timer is stopped and the callback has completed.
+    ///
+    /// Note: When implementing this trait, consider that it is not unsafe to
+    /// leak the handle.
+    type TimerHandle: HrTimerHandle;
+
+    /// Start the timer with expiry after `expires` time units. If the timer was
+    /// already running, it is restarted with the new expiry time.
+    fn start(self, expires: Ktime) -> Self::TimerHandle;
+}
+
+/// Implemented by [`HrTimerPointer`] implementers to give the C timer callback a
+/// function to call.
+// This is split from `HrTimerPointer` to make it easier to specify trait bounds.
+pub trait RawHrTimerCallback {
+    /// Callback to be called from C when timer fires.
+    ///
+    /// # Safety
+    ///
+    /// Only to be called by C code in `hrtimer` subsystem. `ptr` must point to
+    /// the `bindings::hrtimer` structure that was used to start the timer.
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart;
+}
+
+/// Implemented by structs that can be the target of a timer callback.
+pub trait HrTimerCallback {
+    /// The type whose [`RawHrTimerCallback::run`] method will be invoked when
+    /// the timer expires.
+    type CallbackTarget<'a>: RawHrTimerCallback;
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
+pub unsafe trait HrTimerHandle {
+    /// Cancel the timer, if it is running. If the timer handler is running, block
+    /// till the handler has finished.
+    fn cancel(&mut self) -> bool;
+}
+
+/// Implemented by structs that contain timer nodes.
+///
+/// Clients of the timer API would usually safely implement this trait by using
+/// the [`crate::impl_has_hr_timer`] macro.
+///
+/// # Safety
+///
+/// Implementers of this trait must ensure that the implementer has a [`HrTimer`]
+/// field at the offset specified by `OFFSET` and that all trait methods are
+/// implemented according to their documentation.
+///
+/// [`impl_has_timer`]: crate::impl_has_timer
+pub unsafe trait HasHrTimer<T> {
+    /// Offset of the [`HrTimer`] field within `Self`
+    const OFFSET: usize;
+
+    /// Return a pointer to the [`HrTimer`] within `Self`.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to a valid struct of type `Self`.
+    unsafe fn raw_get_timer(ptr: *const Self) -> *const HrTimer<T> {
+        // SAFETY: By the safety requirement of this trait, the trait
+        // implementor will have a `HrTimer` field at the specified offset.
+        unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast::<HrTimer<T>>() }
+    }
+
+    /// Return a pointer to the struct that is embedding the [`HrTimer`] pointed
+    /// to by `ptr`.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to a [`HrTimer<T>`] field in a struct of type `Self`.
+    unsafe fn timer_container_of(ptr: *mut HrTimer<T>) -> *mut Self
+    where
+        Self: Sized,
+    {
+        // SAFETY: By the safety requirement of this function and the `HasHrTimer`
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
+        // SAFETY: timer_ptr points to an allocation of at least `HrTimer` size.
+        unsafe { HrTimer::raw_get(timer_ptr) }
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
+/// Use to implement the [`HasHrTimer<T>`] trait.
+///
+/// See [`module`] documentation for an example.
+///
+/// [`module`]: crate::time::hrtimer
+#[macro_export]
+macro_rules! impl_has_hr_timer {
+    (
+        impl$({$($generics:tt)*})?
+            HasHrTimer<$timer_type:ty>
+            for $self:ty
+        { self.$field:ident }
+        $($rest:tt)*
+    ) => {
+        // SAFETY: This implementation of `raw_get_timer` only compiles if the
+        // field has the right type.
+        unsafe impl$(<$($generics)*>)? $crate::time::hrtimer::HasHrTimer<$timer_type> for $self {
+            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
+
+            #[inline]
+            unsafe fn raw_get_timer(ptr: *const Self) ->
+                *const $crate::time::hrtimer::HrTimer<$timer_type>
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
2.47.0



