Return-Path: <linux-kernel+bounces-332116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2348C97B5BE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B25A1F25514
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA224193433;
	Tue, 17 Sep 2024 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYSSy84D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442617C9A7;
	Tue, 17 Sep 2024 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612115; cv=none; b=iEKGjNF7IEmDYuA6bdM7W1ySjbwHBAG9tF1Ytfc2+Fu64ui+tLZx4ahEam9Kq00G+Na0KKJsEvYQsFrpkypqN4OnTFtMVT+T0PxFQvMUhsOutFmpxSRSYKQ/ulh4/GuJBIiLiOqOH3QVuomRU6aNAEc34ZcJZhibkz1SKK1Vc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612115; c=relaxed/simple;
	bh=UnDWowuW7CyJq38pqnIU9YY6NT3h2llZspKVDqamff4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLFzfMpFLMC7Zo16/HPuuB7UvXFGSYM2agWwbrwOZONRi8t5g14YvqGVUgLkJif17bRjceKqKB3wT7/aDMXsy1DlpYM1w7J2V/+XuIIEtckV/DMnSSZt/QDROQoXuQicLFqNTyAhRSAMgHpraA29LEmNOl/hkO+8HRrhJdFGDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYSSy84D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C755C4CECE;
	Tue, 17 Sep 2024 22:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612114;
	bh=UnDWowuW7CyJq38pqnIU9YY6NT3h2llZspKVDqamff4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NYSSy84DQt/Mqjo1TPU9xzIFhRL0oWvn88DmZRwucGx+rQSYfwxnwqVj9MPndX1zp
	 dF38KegR903hNhJgSRWVUMi4uhLdBzRu9DtAfJMRAb9eIUN6w4qW2ZSN/C8mrkVg3U
	 d7FZsZZwCDaxlI5huqIqfuvKjpQvfgeQBTBNwXRbLOrz7HW+sPwXdKrBf6lMI3AnFx
	 gCG5XlDd182ilVY+XEw1TBLfkRNhEhuzHR0j19y+0/h1sc5duvxU4k2XTNsccKX7mi
	 3+5bZNM6tCUWXcrYESGEPTXQy4NViiYbg8Z0x63UTw9mB8BofGKa6BG8tVWVi4L09o
	 6dOwrhQmaJW6A==
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
Subject: [PATCH v2 06/14] rust: hrtimer: allow timer restart from timer handler
Date: Wed, 18 Sep 2024 00:27:30 +0200
Message-ID: <20240917222739.1298275-7-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4129; i=a.hindborg@kernel.org; h=from:subject; bh=UnDWowuW7CyJq38pqnIU9YY6NT3h2llZspKVDqamff4=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWZwR3hpU2VYWVE3WGtPRTFDTXUzSmJOCkYrYWd3RUI1Q0o4WndrU2ov K2RBKzRrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSDZ BQW9KRU9HNEdqNTVLR04zRGp3UC8wVnhLQ0ozNDVJNFF1QU9yYm1iUWZZZmVtM2Ywd2VPOEhzcQ oxUytWZGg3ZHhVbU1KakJUK2Q0cVRJY2xGRkhETXBneTJYcE03ZWtwTzNGNzVIdGJKQ2VFQ2NnW mo3eFhGU1VWClBCMjhKVWdSZVVSRGQxS04vMFZqOXEySzU4Y3F2VDY2RDBRVFpRaks5M29QeEJI UEJWK3VDTnhsT1E1MXZCWE8KQ1V5NnJiR0E5VDZoODE4N1RxMkpiZWMyRHJvaFMyMUhqYTYyT2Z wckRtQU4zSWQ4aUdTZkZseW1VZ2xGY0pxcwpwZEt3VTJtYWlqNEx6OWQ3Y0ZxdjBmc0E3cVdmck FPZ0hRNTBlZmtaMzgzeGdGeGI0TTJhYzBtV2owenhRZkd3CnlQbkJrcjlwYm9nTHg1MkNmL3ZJN mFqeC83WVNTUzk2VThnUlNBbWcyMW5sbCt1QjZJM3ZSYjZ0R295eXJMZjIKVktHdE9SYUt0TkxL SDZ5cHV5YnRlY0dDV1NXNDYwRU8vZ1pxWDFTQUpYVzF1TUJTZmFtNDd1OTNjR2RJS2QxbgpMTWF BL011N05oWlp1Ym1IZ
 0h0TkVaQ2dZK0lwNUlHWmR3YzhieFBDS3V5c1dOb0dxUUNBS1pyTU9keW oxT0tCCng0a0MzOG1nSUI5c28veFFIalR5VXNoQWJZYktsMUQrQXNuMkZacW5BUWxLMENhblRUS UJWU2p5d20wSFJpM0QKc1BsRzZuNGpTNTUyL2p2alJOaXZlQUl3SHdjdWxVYURwaUdFOFpGREg4 RzZmU045bXRybEFCUFBvSzVuSDhKUwpqeGJUVUhmQmZPS05KQVo2N2VkT2loczhDVG9QK3hHR3V kNzN0aVRpMCtmR3BYQm1iNUFYY0d2K1JkZ1JLeFJ5ClNGS3o2aERSRFh3a2hRPT0KPTFZeDEKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

This patch allows timer handlers to report that they want a timer to be
restarted after the timer handler has finished executing.

Also update the `hrtimer` documentation to showcase the new feature.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs     | 50 ++++++++++++++++++++++++++++++++------
 rust/kernel/hrtimer/arc.rs |  4 +--
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index fd1520ba9fba..d6c3fa89f77e 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -9,7 +9,7 @@
 //!
 //! ```
 //! use kernel::{
-//!     hrtimer::{Timer, TimerCallback, TimerPointer},
+//!     hrtimer::{Timer, TimerCallback, TimerPointer, TimerRestart},
 //!     impl_has_timer, new_condvar, new_mutex,
 //!     prelude::*,
 //!     sync::{Arc, CondVar, Mutex},
@@ -21,7 +21,7 @@
 //!     #[pin]
 //!     timer: Timer<Self>,
 //!     #[pin]
-//!     flag: Mutex<bool>,
+//!     flag: Mutex<u64>,
 //!     #[pin]
 //!     cond: CondVar,
 //! }
@@ -30,7 +30,7 @@
 //!     fn new() -> impl PinInit<Self, kernel::error::Error> {
 //!         try_pin_init!(Self {
 //!             timer <- Timer::new(),
-//!             flag <- new_mutex!(false),
+//!             flag <- new_mutex!(0),
 //!             cond <- new_condvar!(),
 //!         })
 //!     }
@@ -39,10 +39,18 @@
 //! impl TimerCallback for ArcIntrusiveTimer {
 //!     type CallbackTarget<'a> = Arc<Self>;
 //!
-//!     fn run(this: Self::CallbackTarget<'_>) {
+//!     fn run(this: Self::CallbackTarget<'_>) -> TimerRestart {
 //!         pr_info!("Timer called\n");
-//!         *this.flag.lock() = true;
+//!         let mut guard = this.flag.lock();
+//!         *guard += 1;
 //!         this.cond.notify_all();
+//!         if *guard == 5 {
+//!             TimerRestart::NoRestart
+//!         }
+//!         else {
+//!             TimerRestart::Restart
+//!
+//!         }
 //!     }
 //! }
 //!
@@ -55,11 +63,11 @@
 //! let _handle = has_timer.clone().schedule(Ktime::from_ns(200_000_000));
 //! let mut guard = has_timer.flag.lock();
 //!
-//! while !*guard {
+//! while *guard != 5 {
 //!     has_timer.cond.wait(&mut guard);
 //! }
 //!
-//! pr_info!("Flag raised\n");
+//! pr_info!("Counted to 5\n");
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
 
@@ -202,7 +210,7 @@ pub trait TimerCallback {
     type CallbackTarget<'a>: RawTimerCallback;
 
     /// Called by the timer logic when the timer fires.
-    fn run(this: Self::CallbackTarget<'_>)
+    fn run(this: Self::CallbackTarget<'_>) -> TimerRestart
     where
         Self: Sized;
 }
@@ -296,6 +304,32 @@ unsafe fn schedule(self_ptr: *const Self, expires: Ktime) {
     }
 }
 
+/// Restart policy for timers.
+pub enum TimerRestart {
+    /// Timer should not be restarted.
+    NoRestart,
+    /// Timer should be restarted.
+    Restart,
+}
+
+impl From<u32> for TimerRestart {
+    fn from(value: bindings::hrtimer_restart) -> Self {
+        match value {
+            0 => Self::NoRestart,
+            _ => Self::Restart,
+        }
+    }
+}
+
+impl From<TimerRestart> for bindings::hrtimer_restart {
+    fn from(value: TimerRestart) -> Self {
+        match value {
+            TimerRestart::NoRestart => bindings::hrtimer_restart_HRTIMER_NORESTART,
+            TimerRestart::Restart => bindings::hrtimer_restart_HRTIMER_RESTART,
+        }
+    }
+}
+
 /// Use to implement the [`HasTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.
diff --git a/rust/kernel/hrtimer/arc.rs b/rust/kernel/hrtimer/arc.rs
index 80f6c20f95a9..fb8a40484add 100644
--- a/rust/kernel/hrtimer/arc.rs
+++ b/rust/kernel/hrtimer/arc.rs
@@ -80,8 +80,6 @@ impl<U> RawTimerCallback for Arc<U>
         // timer. This `U` is contained in an `Arc`.
         let receiver = unsafe { Arc::clone_from_raw(data_ptr) };
 
-        U::run(receiver);
-
-        bindings::hrtimer_restart_HRTIMER_NORESTART
+        U::run(receiver).into()
     }
 }
-- 
2.46.0



