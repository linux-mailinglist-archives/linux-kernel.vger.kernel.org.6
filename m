Return-Path: <linux-kernel+bounces-332130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3597B5CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEF31C21C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEEC197A7C;
	Tue, 17 Sep 2024 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXjJx9En"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CF9191F95;
	Tue, 17 Sep 2024 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612168; cv=none; b=QMGe0+wU3xX70QKR26FqrJbl2QTRhRa1RmKJAN/Wm5K/tkgZGA65e1jLa0Lh1zgw61t/7uoDH64XqEdmypFYXiGJCV+xjZBPylsPkhONNX/+d9MmaFp3x78cIpvDYiB3q8H4+D/KyBwr4YygrtPcalRXAgvSSzkT1QpHwsdDgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612168; c=relaxed/simple;
	bh=G2PXh+26EvlDBwfEK+RZpBUa80ZOm1qBa9idm3081VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plQ82z5e5xGUbYz2ISqSWkbS2QeivDKjaMOQChy3hScOS3aDfc3M1ktH0wwRsuUZHw+MRVuOS6e4ZPR5k13O4V4ZoulbpsTkt9qfF1lb3xThQBDag89zxurFuL3E1J7NRnWO3/BNeRDJUKX6escgTbTHGgJXJmTfAxriXvxq6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXjJx9En; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BF7C4CED2;
	Tue, 17 Sep 2024 22:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612166;
	bh=G2PXh+26EvlDBwfEK+RZpBUa80ZOm1qBa9idm3081VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OXjJx9EnfLgjILCec4Ix2g3gaEYUSiPWTN7hgy2sVbEkHFQFsWL13vQwvNKkFPq5z
	 mGDiYZhkRAq/XXBHY9f7qLN6mTHzb7EPuJxvew2MkiHmosd08xzWB91T8bxJDAgAHf
	 UY79D7WrmR8duIul6yIvuPF7mH/F6JywXSM5Ixig53ezhVlUwmF8a+cUXVUfS/wsld
	 BJdYFeRGvcZbVA+LK2xXNyBW0zx+MOquCQ+SBROV3t0fqjkIxzPErSdZQU/GSeFfaw
	 5h34MRVgZ7e4i+RZ8mvPJsFdvAAuFVbGYWOdjcG2flc+lkE4IcTbVb7mdsbUunkY5C
	 1KPFS7bb6Jv6g==
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
Subject: [PATCH v2 02/14] rust: hrtimer: introduce hrtimer support
Date: Wed, 18 Sep 2024 00:27:26 +0200
Message-ID: <20240917222739.1298275-3-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9928; i=a.hindborg@kernel.org; h=from:subject; bh=G2PXh+26EvlDBwfEK+RZpBUa80ZOm1qBa9idm3081VA=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWZZU0EyUDJrQlR0ZE9qRmx5RGU1UXFCClR1VEdHUG9sSC9LTERpdnFx Tzh4OVlrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSDJ BQW9KRU9HNEdqNTVLR04zaW5ZUC9Scm9SK0VUbEtseXp3Ylk1YzZoOUt4Z3RtcnFES0NPaWFFOA piRHhLSS9RMG95aUg4RDZNSmFqNGhaRkJNS3pMMlpzNC8ra2YvZWNqUjVsS2M1dHVWMDJkaUFwU Fl4VUpyOVJoCll2RkVCT2xHa3R5aFFKaVVtRkdyMWEyM2xaS2lqYmZsUjcrb1RPa3lVbC9WUmVs OW9ZOWN3akFzazRmdDVhbzgKcmxEbDNmMXhaRkw3cXZqeW4vV0EyYVRmUVphOWtNZm5BK1J3Qjc 0bm0rYURtZGdiNGpPekNRMnV2WHhySUlMQQoyaEtwelJvbkRGYVVlRnY5b1lFSi9OQ09uekRrSz B4MVpBekRWTWdZdlJoMUtaeUFuY3lDdFF5VWRERWcxTStiCkJmQm1UWVVJWlNCaFBGNlNXSVRSe UdnRjZ1MmtXcWpHUnVkc2Z4YzFjbDBVeFNMYm9PQ3RYWmNjTW5KVks0UnkKQnJWNnJhTjJkQng4 VzY2cS9QNzJHaUJrdHVqa3RjVGNvK1Azay9RZ0prR2U5b2oveFRMVFdjOFUyUmIxMFAwRQpqUnN 5VDVETU44a3BWaENsV
 WJjN0ZsaEF2MGZnRGl4UXlKeWtmbkd0MFpYSUdCT1lHemdkcEpIN2owcF NvVWpoCmxFam55ZWIydTNYWjJwWTljV283ZWVPZEFIR1M2d1lWeG1WOG82Q1hiajRMbUNRNFhPU WdSSGt4Z1Bac1Z1SHYKMGRyMlNMQm5NaWRVdUhZOE1ueWUzMTNUWTc0WXliSnRKTnJhQ1ArRXdU Vlo0YU83VG1Sc1hUcjRsakREbmVDWApVTDc2VEtUQjdMNDJVTVdDVXNVbml6ZWNyc2hHK0w2d0N XZ3plaVlQTzh1R1ZEQ3FMbkdaQU9CT2RuNmhCSUpUClRNdWZuVXlPdFU4eDJRPT0KPStCLzEKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

This patch adds support for intrusive use of the hrtimer system. For now,
only one timer can be embedded in a Rust struct.

The hrtimer Rust API is based on the intrusive style pattern introduced by
the Rust workqueue API.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs | 231 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 2 files changed, 232 insertions(+)
 create mode 100644 rust/kernel/hrtimer.rs

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
new file mode 100644
index 000000000000..5c92afd8eb2c
--- /dev/null
+++ b/rust/kernel/hrtimer.rs
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Intrusive high resolution timers.
+//!
+//! Allows scheduling timer callbacks without doing allocations at the time of
+//! scheduling. For now, only one timer per type is allowed.
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
+        pin_init!( Self {
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
+                let function: *mut Option<_> =
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
+/// Scheduling a timer returns a [`TimerHandle`] that can be used to manipulate
+/// the timer. Note that it is OK to call the schedule function repeatedly, and
+/// that more than one [`TimerHandle`] associated with a `TimerPointer` may
+/// exist. A timer can be manipulated through any of the handles, and a handle
+/// may represent a cancelled timer.
+///
+/// [`Box<T>`]: Box
+/// [`Arc<T>`]: crate::sync::Arc
+/// [`ARef<T>`]: crate::types::ARef
+pub trait TimerPointer: Sync + Sized {
+    /// A handle representing a scheduled timer.
+    ///
+    /// If the timer is armed or if the timer callback is running when the
+    /// handle is dropped, the drop method of `TimerHandle` should not return
+    /// until the timer is unarmed and the callback has completed.
+    ///
+    /// Note: It must be safe to leak the handle.
+    type TimerHandle: TimerHandle;
+
+    /// Schedule the timer after `expires` time units. If the timer was already
+    /// scheduled, it is rescheduled at the new expiry time.
+    fn schedule(self, expires: Ktime) -> Self::TimerHandle;
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
+    /// the `bindings::hrtimer` structure that was used to schedule the timer.
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart;
+}
+
+/// Implemented by structs that can the target of a timer callback.
+pub trait TimerCallback {
+    /// The type that was used for scheduling the timer.
+    type CallbackTarget<'a>: RawTimerCallback;
+
+    /// Called by the timer logic when the timer fires.
+    fn run(this: Self::CallbackTarget<'_>)
+    where
+        Self: Sized;
+}
+
+/// A handle representing a potentially armed timer.
+///
+/// More than one handle representing the same timer might exist.
+///
+/// # Safety
+///
+/// When dropped, the timer represented by this handle must be cancelled, if it
+/// is armed. If the timer handler is running when the handle is dropped, the
+/// drop method must wait for the handler to finish before returning.
+pub unsafe trait TimerHandle {}
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
+        unsafe impl$(<$($generics)*>)? $crate::hrtimer::HasTimer<$timer_type>  for $self {
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
index 274bdc1b0a82..55f846c5a849 100644
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



