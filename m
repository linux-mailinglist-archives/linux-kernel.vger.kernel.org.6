Return-Path: <linux-kernel+bounces-551989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60407A573D1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEAFF1899B6F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F07257AF5;
	Fri,  7 Mar 2025 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWFELj+w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3818D1A8F82;
	Fri,  7 Mar 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383637; cv=none; b=L6Vz1L0SYWukeSBXAflC5/bC8ebjwua1GQac6RGjEei2/AMVHJ7ixhHhUy2dM/825KJc/A9NT+thsUhFSuio73PzGF7yiT/cSnKbEIBOeWeQUpfC1yksx0oSvpwG/ZILApz+viB30eKZIFK+nwnduou61qMfnHClQ+oMkxRjUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383637; c=relaxed/simple;
	bh=h0iFl/xf9u7fHTzOfVbtZqGS0f6i0+1XWSChAEqV6XE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8Yi3O04CQF/v3vIO/WOQlgrLJuHsPs2uVZgsFdzmVA/kzAHCxWc8pPSEpUtugvRLflhQVEeQ3FRcDhiUFc+F0KMkcLRZe/dKKtMaF9MZ4Zri+GrDeFO+WHdDtSOUQUVstubdz1Qv+8xwVzKFlDoPg1UkKf6J2E4eZjwKZXBLTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWFELj+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60E1C4CEE7;
	Fri,  7 Mar 2025 21:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741383636;
	bh=h0iFl/xf9u7fHTzOfVbtZqGS0f6i0+1XWSChAEqV6XE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NWFELj+w9fdz6kxx31TyzH/Ik+/avWjmWkc1H7cPIaUvqs4OdVZeNx1FVmkt4gn/T
	 fAQABR0PT+1ni9xtW1y3EwjSY037rvKKHBgTdcPOcw4OU4/g17aS8Smz9R3UkWTO6F
	 OLU/cqDp2fCSvUmPQngHUDdY2uh6wy0HV/+0uIGIs383p9lGFmCMOZhUHBX/bxOdiV
	 37unLURd0haIIZpmQgE/JGKjS8b4+GdK7fdUAmSjtAEpVFzw9zXFhhG52t3tWUEQ/s
	 xUiW/u9KmU3Od2IRCeo5Wc2fX8n0wCAvMNg9eDnRj6OWWS6slvdfJtn02t+gRU+RLE
	 XTf08TF53OwLA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 22:38:42 +0100
Subject: [PATCH v11 01/13] rust: hrtimer: introduce hrtimer support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v11-1-7934aefd6993@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
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
 Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16004;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=h0iFl/xf9u7fHTzOfVbtZqGS0f6i0+1XWSChAEqV6XE=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBny2dp+I3BwgcUiusCVGdqW/W+/BNnGw82soAbN
 dfwAWQpeHCJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8tnaQAKCRDhuBo+eShj
 d3z3D/9FCXjFbvYOCgzeCB6h1DB0X6Vk8TFqIngc4XsQmh/D7Bd1TB+T+W51SW0pbtd+SACaGtk
 /MN6/zSSwQcuBW6CCtBXSTvE00NvMHJExYCgCroP98qoLaj3iyT+qNYBYRKg08WXCopQCiOXP/C
 sSE66fUyDiYSsfxeg0FcqAqZen5BDTcpeBN70rtJMEoogqpFVtWmU2IrgXrxMCm8k6p/4J8N8QM
 n7kw2bubZBmykuvoHuYxRcO3pYQBg40RQzTPdHR355T6nJLtj7WVdpY5ByseWdhhIlwL3A3GzJe
 eFM/ZzqXcUA2+sMNjSWauXKsFlNGLc/3/431K8YdijLxXoLPAy0NTkn6yIVOsNId7PykdI/F3mP
 2Ftf5TYdM56AJ3GVXi/uKaDEPeURMs3gPrF9wP8WHoIF8VbhJ8LqTlpoQBr2hqmzETy3arW+XFX
 XAoLYWrRm/SahLL5JZnTEyA1bVFzO0pwY2B3bcIxlaqQhvBGXKNxJ/NPjanIcgUGqbVTYOi6kxe
 YrLBUNrfCICQDPEjIAd3XZ6G70w8A6/Z+ZJWp6rr4N7y4brMgCeRdMXQldCUEPfGcYes2MRbwDx
 AVi/qEbinS9YVuRJEuWNl0CuoeuWBA2YHh2VNFbxw14+mvGu1m6qSFqwue313D5yweRiyit66m8
 gVdgGhLWbKDjGqQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for intrusive use of the hrtimer system. For now,
only add support for embedding one timer per Rust struct.

The hrtimer Rust API is based on the intrusive style pattern introduced by
the Rust workqueue API.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time.rs         |   2 +
 rust/kernel/time/hrtimer.rs | 351 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 353 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 379c0f5772e5..fab1dadfa589 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -8,6 +8,8 @@
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
+pub mod hrtimer;
+
 /// The number of nanoseconds per millisecond.
 pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
 
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
new file mode 100644
index 000000000000..dc64cef96dd4
--- /dev/null
+++ b/rust/kernel/time/hrtimer.rs
@@ -0,0 +1,351 @@
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
+//! - Stopped: initialized but not started, or cancelled, or not restarted.
+//! - Started: initialized and started or restarted.
+//! - Running: executing the callback.
+//!
+//! Operations:
+//!
+//! * Start
+//! * Cancel
+//! * Restart
+//!
+//! Events:
+//!
+//! * Expire
+//!
+//! ## State Diagram
+//!
+//! ```text
+//!                                                   Return NoRestart
+//!                       +---------------------------------------------------------------------+
+//!                       |                                                                     |
+//!                       |                                                                     |
+//!                       |                                                                     |
+//!                       |                                         Return Restart              |
+//!                       |                                      +------------------------+     |
+//!                       |                                      |                        |     |
+//!                       |                                      |                        |     |
+//!                       v                                      v                        |     |
+//!           +-----------------+      Start      +------------------+           +--------+-----+--+
+//!           |                 +---------------->|                  |           |                 |
+//! Init      |                 |                 |                  |  Expire   |                 |
+//! --------->|    Stopped      |                 |      Started     +---------->|     Running     |
+//!           |                 |     Cancel      |                  |           |                 |
+//!           |                 |<----------------+                  |           |                 |
+//!           +-----------------+                 +---------------+--+           +-----------------+
+//!                                                     ^         |
+//!                                                     |         |
+//!                                                     +---------+
+//!                                                      Restart
+//! ```
+//!
+//!
+//! A timer is initialized in the **stopped** state. A stopped timer can be
+//! **started** by the `start` operation, with an **expiry** time. After the
+//! `start` operation, the timer is in the **started** state. When the timer
+//! **expires**, the timer enters the **running** state and the handler is
+//! executed. After the handler has returned, the timer may enter the
+//! **started* or **stopped** state, depending on the return value of the
+//! handler. A timer in the **started** or **running** state may be **canceled**
+//! by the `cancel` operation. A timer that is cancelled enters the **stopped**
+//! state.
+//!
+//! A `cancel` or `restart` operation on a timer in the **running** state takes
+//! effect after the handler has returned and the timer has transitioned
+//! out of the **running** state.
+//!
+//! A `restart` operation on a timer in the **stopped** state is equivalent to a
+//! `start` operation.
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
+// SAFETY: Timer operations are locked on the C side, so it is safe to operate
+// on a timer from multiple threads.
+unsafe impl<T> Sync for HrTimer<T> {}
+
+impl<T> HrTimer<T> {
+    /// Return an initializer for a new timer instance.
+    pub fn new() -> impl PinInit<Self>
+    where
+        T: HrTimerCallback,
+    {
+        pin_init!(Self {
+            // INVARIANT: We initialize `timer` with `hrtimer_setup` below.
+            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtimer| {
+                // SAFETY: By design of `pin_init!`, `place` is a pointer to a
+                // live allocation. hrtimer_setup will initialize `place` and
+                // does not require `place` to be initialized prior to the call.
+                unsafe {
+                    bindings::hrtimer_setup(
+                        place,
+                        Some(T::Pointer::run),
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
+    /// This function is useful to get access to the value without creating
+    /// intermediate references.
+    ///
+    /// # Safety
+    ///
+    /// `this` must point to a live allocation of at least the size of `Self`.
+    unsafe fn raw_get(this: *const Self) -> *mut bindings::hrtimer {
+        // SAFETY: The field projection to `timer` does not go out of bounds,
+        // because the caller of this function promises that `this` points to an
+        // allocation of at least the size of `Self`.
+        unsafe { Opaque::raw_get(core::ptr::addr_of!((*this).timer)) }
+    }
+
+    /// Cancel an initialized and potentially running timer.
+    ///
+    /// If the timer handler is running, this function will block until the
+    /// handler returns.
+    ///
+    /// Note that the timer might be started by a concurrent start operation. If
+    /// so, the timer might not be in the **stopped** state when this function
+    /// returns.
+    ///
+    /// Users of the `HrTimer` API would not usually call this method directly.
+    /// Instead they would use the safe [`HrTimerHandle::cancel`] on the handle
+    /// returned when the timer was started.
+    ///
+    /// This function is useful to get access to the value without creating
+    /// intermediate references.
+    ///
+    /// # Safety
+    ///
+    /// `this` must point to a valid `Self`.
+    #[allow(dead_code)]
+    pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
+        // SAFETY: `this` points to an allocation of at least `HrTimer` size.
+        let c_timer_ptr = unsafe { HrTimer::raw_get(this) };
+
+        // If the handler is running, this will wait for the handler to return
+        // before returning.
+        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronization is
+        // handled on the C side.
+        unsafe { bindings::hrtimer_cancel(c_timer_ptr) != 0 }
+    }
+}
+
+/// Implemented by pointer types that point to structs that contain a [`HrTimer`].
+///
+/// `Self` must be [`Sync`] because it is passed to timer callbacks in another
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
+    /// Type of the parameter passed to [`HrTimerCallback::run`]. It may be
+    /// [`Self`], or a pointer type derived from [`Self`].
+    type CallbackTarget<'a>;
+
+    /// Callback to be called from C when timer fires.
+    ///
+    /// # Safety
+    ///
+    /// Only to be called by C code in the `hrtimer` subsystem. `this` must point
+    /// to the `bindings::hrtimer` structure that was used to start the timer.
+    unsafe extern "C" fn run(this: *mut bindings::hrtimer) -> bindings::hrtimer_restart;
+}
+
+/// Implemented by structs that can be the target of a timer callback.
+pub trait HrTimerCallback {
+    /// The type whose [`RawHrTimerCallback::run`] method will be invoked when
+    /// the timer expires.
+    type Pointer<'a>: RawHrTimerCallback;
+
+    /// Called by the timer logic when the timer fires.
+    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>)
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
+/// drop method must wait for the handler to return before returning.
+///
+/// Note: One way to satisfy the safety requirement is to call `Self::cancel` in
+/// the drop implementation for `Self.`
+pub unsafe trait HrTimerHandle {
+    /// Cancel the timer. If the timer is in the running state, block till the
+    /// handler has returned.
+    ///
+    /// Note that the timer might be started by a concurrent start operation. If
+    /// so, the timer might not be in the **stopped** state when this function
+    /// returns.
+    ///
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
+pub unsafe trait HasHrTimer<T> {
+    /// Return a pointer to the [`HrTimer`] within `Self`.
+    ///
+    /// This function is useful to get access to the value without creating
+    /// intermediate references.
+    ///
+    /// # Safety
+    ///
+    /// `this` must be a valid pointer.
+    unsafe fn raw_get_timer(this: *const Self) -> *const HrTimer<T>;
+
+    /// Return a pointer to the struct that is containing the [`HrTimer`] pointed
+    /// to by `ptr`.
+    ///
+    /// This function is useful to get access to the value without creating
+    /// intermediate references.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to a [`HrTimer<T>`] field in a struct of type `Self`.
+    unsafe fn timer_container_of(ptr: *mut HrTimer<T>) -> *mut Self
+    where
+        Self: Sized;
+
+    /// Get pointer to the contained `bindings::hrtimer` struct.
+    ///
+    /// This function is useful to get access to the value without creating
+    /// intermediate references.
+    ///
+    /// # Safety
+    ///
+    /// `this` must be a valid pointer.
+    unsafe fn c_timer_ptr(this: *const Self) -> *const bindings::hrtimer {
+        // SAFETY: `this` is a valid pointer to a `Self`.
+        let timer_ptr = unsafe { Self::raw_get_timer(this) };
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
+    /// - `this` must point to a valid `Self`.
+    /// - Caller must ensure that the pointee of `this` lives until the timer
+    ///   fires or is canceled.
+    unsafe fn start(this: *const Self, expires: Ktime) {
+        // SAFETY: By function safety requirement, `this`is a valid `Self`.
+        unsafe {
+            bindings::hrtimer_start_range_ns(
+                Self::c_timer_ptr(this).cast_mut(),
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
+
+            #[inline]
+            unsafe fn raw_get_timer(
+                this: *const Self,
+            ) -> *const $crate::time::hrtimer::HrTimer<$timer_type> {
+                // SAFETY: The caller promises that the pointer is not dangling.
+                unsafe { ::core::ptr::addr_of!((*this).$field) }
+            }
+
+            #[inline]
+            unsafe fn timer_container_of(
+                ptr: *mut $crate::time::hrtimer::HrTimer<$timer_type>,
+            ) -> *mut Self {
+                // SAFETY: As per the safety requirement of this function, `ptr`
+                // is pointing inside a `$timer_type`.
+                unsafe { ::kernel::container_of!(ptr, $timer_type, $field).cast_mut() }
+            }
+        }
+    }
+}

-- 
2.47.0



