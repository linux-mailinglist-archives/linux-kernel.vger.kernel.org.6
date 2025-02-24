Return-Path: <linux-kernel+bounces-528975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B7BA41E94
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9527A3873
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E710C23BD0E;
	Mon, 24 Feb 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ134fp7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DD2571A9;
	Mon, 24 Feb 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398772; cv=none; b=Cj7wXaKhPRq0vcwvI6biUuzQjD73ePiUMf+utUDwnOQaqI1aIztYtGkwXwPEqvRtu7GrK3Hp58r7co+/62CpKhkjkqCXI7MRkg+IbvnZ3px/FYj6eLuRw0N/HWSt8aJVQ8668UGQBgYYxVD3ev4jjxWqmnJVz5QRfCP9ZuHHBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398772; c=relaxed/simple;
	bh=Nzuene3NVidCaFeicx6mpxQJsNDAEReuoanj6ttvvKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DRvy5t3UvFtwKp5jKeT1xr8zbdwqV/hmFDaUH31Oiraoy8iqQRHbIueBpp6+3mLW9kKBO9Q3LUsrVWgjgHQjw9lPQQ92E5N4TZCWb0I12goq17vMgX8HS8+9NeKTQdT7Wxyd8aGgCYa8eGzVHC5yMG9+6qfHjkYoju97D90Y8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ134fp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7872C4CED6;
	Mon, 24 Feb 2025 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398772;
	bh=Nzuene3NVidCaFeicx6mpxQJsNDAEReuoanj6ttvvKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DQ134fp7SNZYMQvRPkpD95AMDuvKYakZoeSjWPxZHmMKC37IC7wh090+Mqcpj5YZS
	 d2g+kDc0YZNtGGKAM4wF9XTenYLBoLN6Lx6dEhJEdjUuC0OevwBWn5aaH/NehuC/fb
	 TB9lbb4RR8D24glRSbZ4syuFEBoItZ/hdNERj+tMVebUQiIEny8rkyOqH+NJm/UdTn
	 ZSNs/eklNV6gbfxHcu04elqbnsV6tknVVU5UHKguxJqe1H42mkkDyjlV+k5uD9QRsm
	 PqoN6qTpZ5+wviUjBV/G9cohQrcCk0andVlPBq2k2poWLmgtRqTxTFfPZnXmz6DHnB
	 WjZVoG8E8D/OQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 13:03:35 +0100
Subject: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16531;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=Nzuene3NVidCaFeicx6mpxQJsNDAEReuoanj6ttvvKA=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAcBc3wloRfg0eFVJIIDVxOlNR9u5AtPaDek
 geOjdNpiaeJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgHAAKCRDhuBo+eShj
 d3amD/99F1R9JD49ne3hqcLsUF2uxohsMy8jToWC1HrkURQGdO6ytxMN9I0hxkS0d1WvIafGMpw
 Rpg0uCT3Lps2g/nwO03vnGh6ww6gz6kZVTSxTHxHjKW1nYYVOoiQSY4NtrJblXSdfUbQwkzWNtA
 tvoOagyPFDE4VSPaoTjpJ041Izh6RRxlnz8Bw6AT+DV6gcg+8c2IRg9m5pbBlpS1HRL1QFLPXah
 +fojXhZjC/9fnVm/0n3bmUOo6kESokhy/O5RROfQK2Yan9fxxbgdTUsjnKN6YPHS7vXC60OlQcN
 N+uCTmpFp3AXN0VdoykSbeObnharu9cJtVzG1y+DDvoOJsvV+bXbAyWiYDWdp6W2alwuNN20uqk
 aE08Oquyb2kumHZPV3CKOeJibikFfD+F+mtCJhYmdY7ARcd7gwHAZEHnaitNIuIC6jIDcjOgrh8
 bNYSp72wvWUCQMnR+pXJFpL5h4ESSfvjLlWI/msvoAThm+uxrwTEhzlfeXzaUyJ+WQA1aUZfbkN
 GzHKkuN9eB4CcccZhYs8SgcekV39556iWYMjqGbzTRyiG9FT5pD85iqCWYPwCJW3eO50czLygVx
 Lb2iGqKArEGDVWkzfQ5I/fAbengzhOV7MBD7LIKdh1myA3eyETUhcqFewT2zfXvn5Qh0EsXRBWs
 YLNICDy+dyvlKgg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This patch adds support for intrusive use of the hrtimer system. For now,
only one timer can be embedded in a Rust struct.

The hrtimer Rust API is based on the intrusive style pattern introduced by
the Rust workqueue API.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 kernel/time/Kconfig         |  13 ++
 rust/kernel/time.rs         |   3 +
 rust/kernel/time/hrtimer.rs | 347 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index b0b97a60aaa6..7726e14ca3e2 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -211,3 +211,16 @@ config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 
 endmenu
 endif
+
+config RUST_HRTIMER
+	bool "Enable Rust hrtimer API"
+	depends on RUST
+	default y
+	help
+	  This option allows exclusion of the Rust hrtimer API from the build.
+	  This allows testing out changes to the C API without having to update
+	  the Rust abstractions during initial development.
+
+	  Say Y if you wish to build the Rust hrtimer API.
+
+	  Say N if you wish to exclude the Rust hrtimer API from the build.
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 379c0f5772e5..e928b1340ee3 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -8,6 +8,9 @@
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
+#[cfg(CONFIG_RUST_HRTIMER)]
+pub mod hrtimer;
+
 /// The number of nanoseconds per millisecond.
 pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
 
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
new file mode 100644
index 000000000000..fe20405d8bfe
--- /dev/null
+++ b/rust/kernel/time/hrtimer.rs
@@ -0,0 +1,347 @@
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
+//! executed. After the handler has finished executing, the timer may enter the
+//! **started* or **stopped** state, depending on the return value of the
+//! handler. A running timer can be **canceled** by the `cancel` operation. A
+//! timer that is cancelled enters the **stopped** state.
+//!
+//! A `cancel` or `restart` operation on a timer in the **running** state takes
+//! effect after the handler has finished executing and the timer has transitioned
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
+    /// This function do not create any references.
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
+    /// Instead they would use the safe [`HrTimerHandle::cancel`] on the handle
+    /// returned when the timer was started.
+    ///
+    /// This function does not create any references.
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
+    /// This type is passed to [`HrTimerCallback::run`]. It may be a borrow of
+    /// [`Self::CallbackTarget`], or it may be `Self::CallbackTarget` if the
+    /// implementation can guarantee correct access (exclusive or shared
+    /// depending on the type) to the target during timer handler execution.
+    type CallbackTarget<'a>;
+
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
+/// drop method must wait for the handler to finish before returning.
+///
+/// Note: One way to satisfy the safety requirement is to call `Self::cancel` in
+/// the drop implementation for `Self.`
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
+    /// This function does not create any references.
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
+    /// This function does not create any references.
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
+    /// This function does not create any references.
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
+    /// - `self_ptr` must point to a valid `Self`.
+    /// - Caller must ensure that `self` lives until the timer fires or is
+    ///   canceled.
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



