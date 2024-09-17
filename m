Return-Path: <linux-kernel+bounces-332125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17C897B5C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDE31F259EB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C5198A11;
	Tue, 17 Sep 2024 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdlksakP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B4198857;
	Tue, 17 Sep 2024 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612142; cv=none; b=mrnq0iso13IceJxh9GI0Wt0RmBwLyiU6xDBVAd1RcnUadY6Gn3exG2k8V8VIacpL7408/CKZ1cGiUsTJ5x1MfI1gWy9yKaZE1GDzaKwaFrlYaZ+TxHVZyGY1MfsEVF+wKHbPvgDhoNWknYLU6YB3AAqe/oaIZIfaRkiLAR/jpT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612142; c=relaxed/simple;
	bh=XWnKE68vcP/rwqWTFNK3jUi79rHtK9rXpgWFPSw+jzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJLrtgnj0iGfvQYVF7lXGJoWguil/kpoxo3f4nBdj7/52yIkCSeOywdbO1C8zacXbAkTDOK+2NqmeK9/x0qrFGYmxRMybIDRUe6tmaWfbL70hSaqt+c8vaJUSiMVA9aBG1jeWW3Co2n4LigNRcAY5+tczZuEWc4Kry+QzEapDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdlksakP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727A5C4CECD;
	Tue, 17 Sep 2024 22:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612142;
	bh=XWnKE68vcP/rwqWTFNK3jUi79rHtK9rXpgWFPSw+jzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gdlksakPvGSbWQX94A/tPXY5O2KSs7WiOKyujQL/RJva2nASAySyNSALbkZ0b+V9X
	 J0sX6FepdEBWKUTF9n5nXWjdC9GQkUJ6H5zGJLsUBvsh0GCSv+urEfwRHjL5w29vUn
	 q7RFTEWGsGKVEYTASOwqffjMofrutrMzJJHzExwHlhriaJIOdRpPFQQ/doYMk7oZFT
	 /pAuX+PMLYHmPjE0L2ZZF8duha+HFTayk8iPh2wIaRgkSsd84Zsw/ZqgHw2r8rk6LA
	 hR5bapCPf1xTh4VxAmIgxK+exuZf+SwAMzA7tTjASbmwKRa+7n/D1NffT6nKQP1SBP
	 N2HT4wzs8E35A==
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
Subject: [PATCH v2 13/14] rust: hrtimer: add `schedule_function` to schedule closures
Date: Wed, 18 Sep 2024 00:27:37 +0200
Message-ID: <20240917222739.1298275-14-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4136; i=a.hindborg@kernel.org; h=from:subject; bh=XWnKE68vcP/rwqWTFNK3jUi79rHtK9rXpgWFPSw+jzE=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWdHejBqTWtCa3Avd1BVSGw4a05KUE1PCnZUWDRHemtCYTdMemQ2eEUy Umcvam9rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSUJ BQW9KRU9HNEdqNTVLR04zYmNnUUFJRDBCNm5ZN3pMeVh1SS9zM2g5RkZwTDA4UzJDd2dENWpLRQ ptbGlZSUZYUW9sRlAxd2xSdGZrRENnOFJoWFpNaVlFUGhhdnZLVWYvS2J6NkU3VDdSbHE2RDVEZ lUrVjlCbU9oCkZobkhMUDE5eEJFeTFxRExlelNUUnl1d2tLVCtlSUt2WSt2eDljZ3NVKzdkTVBL Qys0NUtpcUh5dVNlTTRPS1gKRjN2YjRSazE2cWc2S1huajZyQlBlRmxFZk9HZ2NFTDZjaW9TREV zamNzQjZqRjRUam1lS0wrczZyeTVIZlFpcgo2U2xoQTJHU0F3MFhRcGdrOCtLTlFFZGZObFVNWH hQWHF2a3E4WVQ3QTBhYVpJRWZqQlF4VzhTeXBTQzRjZktRCi9UU01hbUdSaHY5dEdWcGJud2RqU zBVTHY0SVVkZERmT0NJSVNMamVWSTFodWRydEJ6MzNmTGtMM1lSRVpSb3IKY2U5WnlSak5kbUdl WllzNTdLMThpZFRGTEtLMDhxNU8vdERzZ3V3aGFtazdLd1dlT3BYQmVTT05vTDdkZ2d4VwpjbTI 2czliRk1FWGZBdlVHW
 EdabStjbDA3ZnQ4bmgwUEcxR2FvUkRGWHNvM0lMT3Z5ZTdNWTJWQ3FZY1 AvSHRtClRPdVJkR0QwU2U4UGNMd1FBdHMwanZhY0R6MFZOLzl4QXc5aXdXbFlBd09YRUs1QTBXd E9ISnZCUHBjd3NIb3UKV0lTMkUrclhPbkg2eGR1UHVtUlFLT1JubXpzZ0RkWUhNb2FDZDRRNVdT WkdRMU9sQmJObEY4cmxWTlJkUG1iZApVNnM4V2d6VWx2bGxSeUR0cU1jdDVlNk9idExmck14RUV rT2d0YlZnYzNkOS9lcXFzQ1V4NWtJa2xoRGR6Z3VuCnhuMEVMNms1bzNBZHF3PT0KPUNoNjQKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

Add a way to quickly schedule functions for execution after a certain
duration has elapsed.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs         | 49 +++++++++++++++++++++++
 rust/kernel/hrtimer/closure.rs | 72 ++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 rust/kernel/hrtimer/closure.rs

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index 1750016b2b22..2fd3e68368da 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -132,6 +132,52 @@
 //! pr_info!("Flag raised\n");
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
+//!
+//! Using a helper:
+//! ```
+//! use kernel::{
+//!     hrtimer::schedule_function,
+//!     impl_has_timer, new_condvar, new_mutex,
+//!     prelude::*,
+//!     stack_try_pin_init,
+//!     sync::{Arc, CondVar, Mutex},
+//!     time::Ktime,
+//! };
+//!
+//! #[pin_data]
+//! struct Data {
+//!     #[pin]
+//!     flag: Mutex<bool>,
+//!     #[pin]
+//!     cond: CondVar,
+//! }
+//!
+//! impl Data {
+//!     fn new() -> impl PinInit<Self, kernel::error::Error> {
+//!         try_pin_init!(Self {
+//!             flag <- new_mutex!(false),
+//!             cond <- new_condvar!(),
+//!         })
+//!     }
+//! }
+//!
+//! let data = Arc::pin_init(Data::new(), GFP_KERNEL)?;
+//! let data2 = data.clone();
+//!
+//! let handle = schedule_function(Ktime::from_ns(200_000_000), move || {
+//!     pr_info!("Hello from the future");
+//!     *data2.flag.lock() = true;
+//!     data2.cond.notify_all();
+//! });
+//!
+//! let mut guard = data.flag.lock();
+//! while !*guard {
+//!     data.cond.wait(&mut guard);
+//! }
+//!
+//! pr_info!("Flag raised\n");
+//! # Ok::<(), kernel::error::Error>(())
+//! ```
 
 use crate::{init::PinInit, prelude::*, time::Ktime, types::Opaque};
 use core::marker::PhantomData;
@@ -497,5 +543,8 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 mod tbox;
 
 mod arc;
+mod closure;
 mod pin;
 mod pin_mut;
+
+pub use closure::schedule_function;
diff --git a/rust/kernel/hrtimer/closure.rs b/rust/kernel/hrtimer/closure.rs
new file mode 100644
index 000000000000..96286a12e87a
--- /dev/null
+++ b/rust/kernel/hrtimer/closure.rs
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::{pin_init, tbox::BoxTimerHandle, Timer, TimerCallback, TimerPointer, TimerRestart};
+use crate::{
+    alloc::{flags, Flags},
+    impl_has_timer, new_mutex,
+    prelude::*,
+    sync::Mutex,
+    time::Ktime,
+};
+use macros::pin_data;
+
+#[pin_data]
+pub struct ClosureTimer<T> {
+    #[pin]
+    timer: Timer<ClosureTimer<T>>,
+    #[pin]
+    callback: Mutex<Option<T>>,
+}
+
+impl_has_timer! {
+    impl{T} HasTimer<Self> for ClosureTimer<T> { self.timer }
+}
+
+impl<T> TimerCallback for ClosureTimer<T>
+where
+    T: FnOnce() + 'static,
+{
+    type CallbackTarget<'a> = Pin<Box<ClosureTimer<T>>>;
+    type CallbackPointer<'a> = &'a ClosureTimer<T>;
+
+    fn run(this: Self::CallbackPointer<'_>) -> TimerRestart
+    where
+        Self: Sized,
+    {
+        if let Some(callback) = this.callback.lock().take() {
+            callback();
+        }
+        TimerRestart::NoRestart
+    }
+}
+
+impl<T> ClosureTimer<T>
+where
+    T: FnOnce() + 'static,
+    T: Send,
+    T: Sync,
+{
+    fn new(f: T, flags: Flags) -> Result<Pin<Box<Self>>> {
+        Box::pin_init(
+            pin_init!(
+                Self {
+                    timer <- Timer::new(),
+                    callback <- new_mutex!(Some(f)),
+                }
+            ),
+            flags,
+        )
+    }
+}
+
+/// Schedule `f` for execution after `expires` time.
+pub fn schedule_function<T>(expires: Ktime, f: T) -> Result<BoxTimerHandle<ClosureTimer<T>>>
+where
+    T: FnOnce() + 'static,
+    T: Send,
+    T: Sync,
+{
+    let timer = ClosureTimer::<T>::new(f, flags::GFP_KERNEL)?;
+    let handle = <Pin<Box<ClosureTimer<T>>> as TimerPointer>::schedule(timer, expires);
+    Ok(handle)
+}
-- 
2.46.0



