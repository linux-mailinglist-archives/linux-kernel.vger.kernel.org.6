Return-Path: <linux-kernel+bounces-332112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053D997B5BA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E9EBB250F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B40B1925B8;
	Tue, 17 Sep 2024 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhfPgZrX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B9A29;
	Tue, 17 Sep 2024 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612104; cv=none; b=dVEw3RccLFLV6Eb583PetW3eAmeM24gx6oYHTPS420PpLxiCkvAFztYLNRFSdqvyppf7yZyXcyFOhP4mPdIh8uWZ4rCLLGvX+cayTwkIPgtzGstSgQsF5MOuoCuIBGQ72TVl0qEjAZIwQGLDTs+H7TJk9bhoklHib/EzpiQohfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612104; c=relaxed/simple;
	bh=xKL5HMeRstFVPof1hsTkfQs0tfaKDeMRSFDFcVRIIXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6o3xXPO/pBYGiL0ZnXNScdHR6IGMTJMpWlaePZxQmUcgFUzybdWV8hY/jxk5rOUZNZ+1S5tiPdLQkqJbHFD9T1fm6TLQr8llF33BtuHwzTgbDIW2vBrJBSQ0qF4JqOnw6TI+u+b6ex8DQC6OGTqhv/L9bQgp36K8lLxK01x5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhfPgZrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E5CC4CEC5;
	Tue, 17 Sep 2024 22:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612103;
	bh=xKL5HMeRstFVPof1hsTkfQs0tfaKDeMRSFDFcVRIIXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QhfPgZrXFHbhj/Eocoonc754jCAxq5uQ47x20nvz4UWISsdm4/Yr2HJnl1pv4qXCk
	 aD8vRGrLs47/xg9auyftIih2BKh1RV+VuB0GtQsdcnDnrZ7Nn9gtF/eSGA/w3Xfcp7
	 Saz2on0FLq/mo7V3Bvl4bixeslReFvjsFTFnmuOARa7zFYPLM9uYioKA7VOOUNkKpz
	 MdA0vAXG5yJ7YhgJvUVj0tnRc83MQc1orjMwrL6DV1Iv+emwFFSeXK43AXaEt/3fxw
	 PcfiJNMHn2C2B38ONHohxbN+ay0Wo7Yac7D6QfihRHxo0OcvVInuxtBaIJG2Nf0LXP
	 kLcFPDbR4oxCw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/14] rust: hrtimer: implement `TimerPointer` for `Arc`
Date: Wed, 18 Sep 2024 00:27:29 +0200
Message-ID: <20240917222739.1298275-6-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7855; i=a.hindborg@kernel.org; h=from:subject; bh=xKL5HMeRstFVPof1hsTkfQs0tfaKDeMRSFDFcVRIIXU=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWZrcDNaWXIwSVY2UGRad2xrVVNhMDJwCnI0TU9jR0E1Q3gyUzFpUGhL VFF5YllrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSDV BQW9KRU9HNEdqNTVLR04zUmxFUUFNU2ZrRG1QU1FFMS9ZN1Z0YUV0UkdWQmlaTFg5TmtYSWE2Uw pkV2lsYUZYU01VZlA4a285UTVUYmZRblhYVnp2M29xOVExTDNxdmFJbG1mUTRqR0xWZktMcVJ5N lVRdU5BQVhxCkVnWHFIOElKTEV0eFZYd0Z2SWphOWY2eVM3dTFuZWVaMW9xdG5saXkvVERoYkln S0ZvcG9WMitHZ1NmSWwwSloKS2o4c3d1aGRqN0JEU0pTQitBcVBrYU5GbFZuWFpMbmxOWURyaTh obWJJK3FCbHFDWCsxdURnczY5TThjQTdIOApKcytQbnI1aHFLcnhTVWE2L01WdlRrOXBkRHRIbG gvWXRSMVlXSFFSMDdwZHVXYW5jaEVkbkdwTTZHclM0V3ZpCjdrSW1CenAzZkJvTDg0VUFuNlN6V ytQb1VYbG41UTJISEEwTEp4RVZtSGg0eTAydVZyWEtpaHN4ZENQRkNOMVUKVm9WNGRpNlF2aWFH NDR2RzE2dHFqR0t3ZnYrV2RIZDcxSzBDQy9jTjhsRUhEOUhmZG93b0cwWDZqWkEvTlJ6cwpvL0J xVmFRVitXa0dzbWw1a
 m1lalNJMzc5N1FwM3hzS0pWTzEyRnlMZHBwaXh3czQvY0Z0RkY3Mk43V3 NqKzl1CmVTWitoUi8rdzBRcE1LMTVtdEpXU1pIVjN1NE96VGl5Uy9neEpSYmM0dEpoRmVIY2Nre FZYc1pmekgvbTYzUU4KTUZsOFZENERjRk1uR3RNN2xYbHlkZ0hicHFRUVhVN3hWaFpUMG1TY2s0 RDdRa3dmR0FaQTZrSlZGVG1pWTdZZwp2NWRWeVcvb2pHYmxRMVFYemlsN2FDY3hvOVZUYUtOeDZ ZZ0V2S1V2bWNqWGFBenNjTi9kdkpDcTQ0WVN3WHpsCnlDd2ptYlBlckNZaDJ3PT0KPW5wRkgKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

This patch allows the use of intrusive `hrtimer` fields in structs that are
managed by an `Arc`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs     | 102 ++++++++++++++++++++++++++++++++++++-
 rust/kernel/hrtimer/arc.rs |  87 +++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/hrtimer/arc.rs

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index 5c92afd8eb2c..fd1520ba9fba 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -4,6 +4,64 @@
 //!
 //! Allows scheduling timer callbacks without doing allocations at the time of
 //! scheduling. For now, only one timer per type is allowed.
+//!
+//! # Example
+//!
+//! ```
+//! use kernel::{
+//!     hrtimer::{Timer, TimerCallback, TimerPointer},
+//!     impl_has_timer, new_condvar, new_mutex,
+//!     prelude::*,
+//!     sync::{Arc, CondVar, Mutex},
+//!     time::Ktime,
+//! };
+//!
+//! #[pin_data]
+//! struct ArcIntrusiveTimer {
+//!     #[pin]
+//!     timer: Timer<Self>,
+//!     #[pin]
+//!     flag: Mutex<bool>,
+//!     #[pin]
+//!     cond: CondVar,
+//! }
+//!
+//! impl ArcIntrusiveTimer {
+//!     fn new() -> impl PinInit<Self, kernel::error::Error> {
+//!         try_pin_init!(Self {
+//!             timer <- Timer::new(),
+//!             flag <- new_mutex!(false),
+//!             cond <- new_condvar!(),
+//!         })
+//!     }
+//! }
+//!
+//! impl TimerCallback for ArcIntrusiveTimer {
+//!     type CallbackTarget<'a> = Arc<Self>;
+//!
+//!     fn run(this: Self::CallbackTarget<'_>) {
+//!         pr_info!("Timer called\n");
+//!         *this.flag.lock() = true;
+//!         this.cond.notify_all();
+//!     }
+//! }
+//!
+//! impl_has_timer! {
+//!     impl HasTimer<Self> for ArcIntrusiveTimer { self.timer }
+//! }
+//!
+//!
+//! let has_timer = Arc::pin_init(ArcIntrusiveTimer::new(), GFP_KERNEL)?;
+//! let _handle = has_timer.clone().schedule(Ktime::from_ns(200_000_000));
+//! let mut guard = has_timer.flag.lock();
+//!
+//! while !*guard {
+//!     has_timer.cond.wait(&mut guard);
+//! }
+//!
+//! pr_info!("Flag raised\n");
+//! # Ok::<(), kernel::error::Error>(())
+//! ```
 
 use crate::{init::PinInit, prelude::*, time::Ktime, types::Opaque};
 use core::marker::PhantomData;
@@ -72,6 +130,25 @@ unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
         // allocation of at least the size of `Self`.
         unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer)) }
     }
+
+    /// Cancel an initialized and potentially armed timer.
+    ///
+    /// If the timer handler is running, this will block until the handler is
+    /// finished.
+    ///
+    /// # Safety
+    ///
+    /// `self_ptr` must point to a valid `Self`.
+    unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
+        // SAFETY: timer_ptr points to an allocation of at least `Timer` size.
+        let c_timer_ptr = unsafe { Timer::raw_get(self_ptr) };
+
+        // If handler is running, this will wait for handler to finish before
+        // returning.
+        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronization is
+        // handled on C side.
+        unsafe { bindings::hrtimer_cancel(c_timer_ptr) != 0 }
+    }
 }
 
 /// Implemented by pointer types that point to structs that embed a [`Timer`].
@@ -139,7 +216,11 @@ fn run(this: Self::CallbackTarget<'_>)
 /// When dropped, the timer represented by this handle must be cancelled, if it
 /// is armed. If the timer handler is running when the handle is dropped, the
 /// drop method must wait for the handler to finish before returning.
-pub unsafe trait TimerHandle {}
+pub unsafe trait TimerHandle {
+    /// Cancel the timer, if it is armed. If the timer handler is running, block
+    /// till the handler has finished.
+    fn cancel(&mut self) -> bool;
+}
 
 /// Implemented by structs that contain timer nodes.
 ///
@@ -196,6 +277,23 @@ unsafe fn c_timer_ptr(self_ptr: *const Self) -> *const bindings::hrtimer {
         // SAFETY: timer_ptr points to an allocation of at least `Timer` size.
         unsafe { Timer::raw_get(timer_ptr) }
     }
+
+    /// Schedule the timer contained in the `Self` pointed to by `self_ptr`. If
+    /// it is already scheduled it is removed and inserted.
+    ///
+    /// # Safety
+    ///
+    /// `self_ptr` must point to a valid `Self`.
+    unsafe fn schedule(self_ptr: *const Self, expires: Ktime) {
+        unsafe {
+            bindings::hrtimer_start_range_ns(
+                Self::c_timer_ptr(self_ptr).cast_mut(),
+                expires.to_ns(),
+                0,
+                bindings::hrtimer_mode_HRTIMER_MODE_REL,
+            );
+        }
+    }
 }
 
 /// Use to implement the [`HasTimer<T>`] trait.
@@ -229,3 +327,5 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
         }
     }
 }
+
+mod arc;
diff --git a/rust/kernel/hrtimer/arc.rs b/rust/kernel/hrtimer/arc.rs
new file mode 100644
index 000000000000..80f6c20f95a9
--- /dev/null
+++ b/rust/kernel/hrtimer/arc.rs
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::HasTimer;
+use super::RawTimerCallback;
+use super::Timer;
+use super::TimerCallback;
+use super::TimerHandle;
+use super::TimerPointer;
+use crate::sync::Arc;
+use crate::time::Ktime;
+
+/// A handle for an `Arc<HasTimer<U>>` returned by a call to
+/// [`TimerPointer::schedule`].
+pub struct ArcTimerHandle<U>
+where
+    U: HasTimer<U>,
+{
+    pub(crate) inner: Arc<U>,
+}
+
+// SAFETY: We implement drop below, and we cancel the timer in the drop
+// implementation.
+unsafe impl<U> TimerHandle for ArcTimerHandle<U>
+where
+    U: HasTimer<U>,
+{
+    fn cancel(&mut self) -> bool {
+        let self_ptr = self.inner.as_ptr();
+
+        // SAFETY: As we obtained `self_ptr` from a valid reference above, it
+        // must point to a valid `U`.
+        let timer_ptr = unsafe { <U as HasTimer<U>>::raw_get_timer(self_ptr) };
+
+        // SAFETY: As `timer_ptr` points into `U` and `U` is valid, `timer_ptr`
+        // must point to a valid `Timer` instance.
+        unsafe { Timer::<U>::raw_cancel(timer_ptr) }
+    }
+}
+
+impl<U> Drop for ArcTimerHandle<U>
+where
+    U: HasTimer<U>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+impl<U> TimerPointer for Arc<U>
+where
+    U: Send + Sync,
+    U: HasTimer<U>,
+    U: for<'a> TimerCallback<CallbackTarget<'a> = Self>,
+{
+    type TimerHandle = ArcTimerHandle<U>;
+
+    fn schedule(self, expires: Ktime) -> ArcTimerHandle<U> {
+        // SAFETY: Since we generate the pointer passed to `schedule` from a
+        // valid reference, it is a valid pointer.
+        unsafe { U::schedule(self.as_ptr(), expires) };
+
+        ArcTimerHandle { inner: self }
+    }
+}
+
+impl<U> RawTimerCallback for Arc<U>
+where
+    U: HasTimer<U>,
+    U: for<'a> TimerCallback<CallbackTarget<'a> = Self>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `Timer` is `repr(transparent)`
+        let timer_ptr = ptr.cast::<kernel::hrtimer::Timer<U>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // queuing the timer, so it is a `Timer<T>` embedded in a `T`.
+        let data_ptr = unsafe { U::timer_container_of(timer_ptr) };
+
+        // SAFETY: `data_ptr` points to the `U` that was used to queue the
+        // timer. This `U` is contained in an `Arc`.
+        let receiver = unsafe { Arc::clone_from_raw(data_ptr) };
+
+        U::run(receiver);
+
+        bindings::hrtimer_restart_HRTIMER_NORESTART
+    }
+}
-- 
2.46.0



