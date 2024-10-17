Return-Path: <linux-kernel+bounces-369827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C8B9A2332
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764941F22F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4682E1DF736;
	Thu, 17 Oct 2024 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYzn/uIB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568791DE2AD;
	Thu, 17 Oct 2024 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170593; cv=none; b=Fdv6QP+EWExFzFlc84LL+bto/7cle2UUTk/anqjIjHknbgzrQa+RUiL+/8NkRXAElGjSkYAhqgVbpTdvudFtANWLcXk9OEuMYheEDhuyukC+xYtqP4fAgDBMd4MgERpODi8SYl940/WbceD7s3AfrNENy9TSXhHJ8g5wX6zNgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170593; c=relaxed/simple;
	bh=3HeksWAHU84glzjb1XoCrT2n/pqB6Bx/DG1gmiNpkf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HsYlajp3Y6gIYaNxLeyIUsuXYSVIrppZgBXNyS2N8WV7lHsggm3+hpjh1439TR0QEms5jEdkuMwQgf6ZBKNDM74fZhzWYo8fWNfx/le+C6ct360sAUUFAIJkpGMTGRr4h1JrB1ogqtwWWSWWn/8VhP7VN60nzzsVd1quOc/lXPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYzn/uIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88885C4CEC3;
	Thu, 17 Oct 2024 13:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170592;
	bh=3HeksWAHU84glzjb1XoCrT2n/pqB6Bx/DG1gmiNpkf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NYzn/uIBo7wAWmX2olJxsHtU0BpYF922If+2oRwARBAuBGZyPvOJO5b/h3QzJGvKA
	 lYg7YBZEuYHfF8rU4f3iGH7fE7/ra2hmpS3BNWAO/4A7Na5Ngq0VsCSC15iWdhrymi
	 /VOLSUXPn0czyPRUG6jTVdwUS8z+wf68JRuB0eICvbmRk/pM6ZwVkSCZeK6jrPpjHo
	 /kOqqIIaJ05TKRkUadOyA2LDLs1longwVimymGfwLBX1kYcMuNkLtKDLnd/LkdJOKg
	 m61GPSchV1qAqI1QI2uMB5VBxS6G9X4dNfbFhQNOZ/6+gjD3Ncbh7ZmY1f+nHAB0I2
	 sJkn7nd+3bnCA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 17 Oct 2024 15:04:29 +0200
Subject: [PATCH v3 02/13] rust: hrtimer: introduce hrtimer support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-2-59a75cbb44da@kernel.org>
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
In-Reply-To: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2

This patch adds support for intrusive use of the hrtimer system. For now,
only one timer can be embedded in a Rust struct.

The hrtimer Rust API is based on the intrusive style pattern introduced by
the Rust workqueue API.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs | 304 +++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 2 files changed, 305 insertions(+)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
new file mode 100644
index 0000000000000000000000000000000000000000..99058a690f2e18b5c26c94c71133407019aa4a26
--- /dev/null
+++ b/rust/kernel/hrtimer.rs
@@ -0,0 +1,304 @@
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
+/// * `self.timer` is initialized by `bindings::hrtimer_init`.
+#[repr(transparent)]
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
+            // INVARIANTS: We initialize `timer` with `hrtimer_init` below.
+            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtimer| {
+                // SAFETY: By design of `pin_init!`, `place` is a pointer live
+                // allocation. hrtimer_init will initialize `place` and does not
+                // require `place` to be initialized prior to the call.
+                unsafe {
+                    bindings::hrtimer_init(
+                        place,
+                        bindings::CLOCK_MONOTONIC as i32,
+                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                    );
+                }
+
+                // SAFETY: `place` is pointing to a live allocation, so the deref
+                // is safe.
+                let function =
+                    unsafe { core::ptr::addr_of_mut!((*place).function) };
+
+                // SAFETY: `function` points to a valid allocation and we have
+                // exclusive access.
+                unsafe { core::ptr::write(function, Some(T::CallbackTarget::run)) };
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
+/// [`module`]: crate::hrtimer
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
+        unsafe impl$(<$($generics)*>)? $crate::hrtimer::HasTimer<$timer_type> for $self {
+            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
+
+            #[inline]
+            unsafe fn raw_get_timer(ptr: *const Self) ->
+                *const $crate::hrtimer::Timer<$timer_type>
+            {
+                // SAFETY: The caller promises that the pointer is not dangling.
+                unsafe {
+                    ::core::ptr::addr_of!((*ptr).$field)
+                }
+            }
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b5f4b3ce6b48203507f89bcc4b0bf7b076be6247..d21c6afc50a9dd35d33829252d3cf320e4244864 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -34,6 +34,7 @@
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
+pub mod hrtimer;
 pub mod init;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]

-- 
2.46.0



