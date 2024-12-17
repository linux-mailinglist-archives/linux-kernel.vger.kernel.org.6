Return-Path: <linux-kernel+bounces-449446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505039F4F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583B916D4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A711F75A5;
	Tue, 17 Dec 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4YHbE+v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD911F7082;
	Tue, 17 Dec 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448762; cv=none; b=knHB50pxH7nodTDzZJRQK1zJIriDiUX6T7xiinC2UR5TyRkXaFZ1pOlezx2Fuw6s2tJxxiCKd9uQi+vUuwDUTZnWJW6TPfRtE+eIaSGgtPfZ9VVmoUZpipekteZGXZdqLYilcU3Lm+/85gmeiWIlp7vy+4+aAgKyAVMwVwP+oF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448762; c=relaxed/simple;
	bh=8HAOeJ5aPV3wyZF3YtER7fXarEqO15cVRrMfd0GEa4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2nWZanZIjX1oGpPU3FQwEqHK8Ti9VS7jAQiswpq1CIz2HYDnbIhnOQEs4NvRCU8zWyU3XUIZ8VSYMC5Pe0ewiAAGJdopOIfXYYkYvlOR3hRN6U3h8BRQDEFN+Qy6ifju9rcZ/8baSGSKd+mNZAk3IjUNyqvz+eWufsBU3ufHGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4YHbE+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EF5C4CED3;
	Tue, 17 Dec 2024 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448762;
	bh=8HAOeJ5aPV3wyZF3YtER7fXarEqO15cVRrMfd0GEa4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e4YHbE+vOXZLPUanzm8BdnpuWtHGhVcYYY13JmpzUnNZwczZP2MCzLCqJzq4XRe4e
	 VIY/Qe9mEdOFJkhg1oOOxZvi1gD9KmXcR7TWC+aB1tf7LUuFS/0l6UaK+by14ktG4S
	 TvPYVmm+PBecjzwpWHu10oNEpvTNSHeHHeLFO64zut9ou7YwdfeNJwr4NydXOffB6h
	 DHSbKN8N4hr8/rKYQs9Q31h8FKhUPAGS+eVBmqk2kO3EE3iVSuW3fE8uZYyGtq7TVq
	 UwIa38jHWdkKQ2B4ZmSVgA93qoyBJnPf/Qb62lGB7nLYLp/dbf/sYvP8+Dk6JmaO7r
	 Btjai/LmlNFuw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:33 +0100
Subject: [PATCH v5 02/14] rust: hrtimer: introduce hrtimer support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-2-b34c20ac2cb7@kernel.org>
References: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
In-Reply-To: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
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
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12283;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=8HAOeJ5aPV3wyZF3YtER7fXarEqO15cVRrMfd0GEa4o=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYScrbVH27Uv8iLaZVPZfjEBxLwX+oQU+g/Y
 sNWvqx170KJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWEgAKCRDhuBo+eShj
 d143D/9JX8nM3TmzER7yEDpBqJiyPqul7SBIpUCh4gSgdqkLwsgwqjcaETbhFKv6oTcUM7DLyT6
 50R6LlcrzPOhv4fTGPxoHV/TuJ6lzn+fe7+lTpqvUtwEBy55OPaF9WMVEDyShBaRP+u21CmFBC4
 DPdZAVE0VJANapFnV16aEJuf9jwgqTt2cdipcnNVRcNnWEoW/tDVbl+JRzAULMR/zSz8UKOvkA7
 SHOr+K3yrx64stmhSLPiOMS9vluT2mNRqNVdOxtMfK/vh/99fhpq5wHlqEdU0LR9eeyVbb39o0b
 g8HcQXxoVT2e3W9ooZ3yMZU1osD5h1tUmVSimMND3Q+tM61XhvVk1u1Qv5e14BqIOGTftGfOyyr
 KzsR4mJabWMtCr4nAybVhMMyrko7xsRb9qHkj935yE5gcblYpQ4vDf/Lma2GT1QpI972PnVhETv
 S/0gEQCiCWhMT1VqiMOkxpK7T1I+hjre1Xl/zgksCFuP+bTTs9WxCg7wqIKr0rf+vguyFjNotkq
 pAD2ryjkuhfOUclgIz5PWvMzGTGbOPWGjU4oY4+nWNpaCoWpQNWFGem0p3pR1QwmJUne++dEPsm
 GsCXxym1n0QFxn8kIpeBeCtV+W6jtwTDjRk1MDs4cJxuUrrHCIbgpfPYRYgux7m9VkVIzLY3rBy
 mqyUS/zmdLxAe4w==
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
index 0000000000000000000000000000000000000000..b09bdb8bc2037bf116a9a87b16271f4045f53aa9
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
+                *const $crate::time::hrtimer::Timer<$timer_type>
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



