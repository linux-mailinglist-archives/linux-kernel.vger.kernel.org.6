Return-Path: <linux-kernel+bounces-332122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A98297B5C4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6751C21B34
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57871953AD;
	Tue, 17 Sep 2024 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoY0mLNN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8C195381;
	Tue, 17 Sep 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612127; cv=none; b=uhhwxN2cFQX48fL3kJJ4XpT0obm721Aa27WVsXdVIX78N8wtYMmYUXnazGd6TiT8EyWVSvmrsvuymcVmX8fr1wwbuEseSTHq7xGmFN/SkbZZAMDGOKUgIFL+e5lcENvauhuv8ZA3I2FQ5QwfuAYdfAQdjmBUYB3JzPzTvZu/gnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612127; c=relaxed/simple;
	bh=U0py9DMnxzTkJ1CnpwtopusE2xoM7Eizw4Dj5cLOz3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rd0jWJk0vE0W7WUPfdhsO4P9m8QlrzaFoDpjRvDdgwEM6I0WjgeoFt9oEKJhsiS2/YzAoUBNqc9Ydoj65VbaHORH0UkRlciVIZHGcSfPuw0ctn6t6qzemyKNdGFD5ZDeZHpmTwX+CnS2PORGZ276gs9Dsvcwyh9KUIGqD+LNWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoY0mLNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17549C4CECE;
	Tue, 17 Sep 2024 22:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612126;
	bh=U0py9DMnxzTkJ1CnpwtopusE2xoM7Eizw4Dj5cLOz3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XoY0mLNNVkBOdbCGUy2ULblGtkTsFiGuQufDTDlEyNe3PnhShq3WmBxfDsbVv1SMF
	 +/+8t7/3TlQxZgEhK8tu80314oMlmncrN9uaaT75sw2xi3A6tPk1QqALCspbjcuAZd
	 2+6eW0o5ySc8riKncsZ/BPXTVc3znHjNWWNnsLm0NnIUPiU1D/fwkkRsbKtdn9Ap64
	 6omrvPBZAYBL8bGkG0QhF77T5FmOCb4kgwlh3Y782mTF9C+DDyv2JTm8PzfgPBSnm3
	 mzWbL9WqpHzg0zSqSbGg2qMMKXpK7Kaf02SneOUyoRWQunpTTYOMc0XmEkIGXEWXGB
	 l4wIRMny36V1Q==
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
Subject: [PATCH v2 10/14] rust: hrtimer: add `hrtimer::ScopedTimerPointer`
Date: Wed, 18 Sep 2024 00:27:34 +0200
Message-ID: <20240917222739.1298275-11-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3884; i=a.hindborg@kernel.org; h=from:subject; bh=U0py9DMnxzTkJ1CnpwtopusE2xoM7Eizw4Dj5cLOz3Y=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWY1S1N6L0lZb2tQVHhralhwVTM0UzIvClFjcmZKd3dXV1BuL3B2TWxm ODYyNm9rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSCt BQW9KRU9HNEdqNTVLR04zT05rUUFNQ21TL3IzamVTeDZGcGt1Y3FPcy9wNkQvV1VvckpxV2o4RA pCU3pBd0U3Ylh4T3h1YUFtQUVzcXRCdTJzUkk2ZXlWczJrajgxSXZZb3hmZ2VKU2F3S1lyMkYwW nFZY0txZkVzCnNwOHdrUlNaYkI0azJuczQyRkJ1K3hiZWJESGhJd01PUEpEZXA0ckEyTVhGaTc2 Qy9nU0xieExZb0ppZHQzcHAKU3FlZ0JoTGQ5S1JlQU1lc0MxSUZ2ck9mWXZ4WHc0YThhd2pwTnd aQ1prb2RvbU04WVprY0xXY0p0WERMZjdhVgpybGRVR0dpRzRpV3RCVy9iMGlnVURNVnduNWlWNW RpUW14K0J0WmZGaGwxVzZaRnhna0RRcEpzMSthdXBablhDCjU1SlVKc0hBV2UyVkJLTUl0b3V4a lJDODFKSDZ6OUhhN0MwMTV4ZHZyZkxRa0I4c1FvTXJEVWgvYVRiMTZqMSsKZnE1a2lZQTZxL1hy K1hYYnFZS3hDbzNZUTVqMnlKeStEOWM5bCtqZXJiS2t1c2hMRHk2U01rNXVuYVRMa25oVgp1T1c zQ1AyZEttR0p2U2FST
 0JYUGFsQ0hOUERMdlFOcDVvdlNVYloyc3dkRGkxM3E2cEg4UEZyWHd5bl htVE9jCkdkclZmS040QnRRWmlIblpsajMyUGt4b0pjUkRqNUliNGxxdVlUekVvZlMxSkltSXExe HgzT0pXZXYwK3h0UnIKbVNUbjk3cWdpelVMWXJxdlNSUmZJaVhSb0pLT1JXZ1RnUHF4TnJqaWg3 dGZSYWpwZkNQd3pmT3lEdkkxN05LSQpDcExTRE44TWxoWCtLcFlWMGY2M2lIYnN0bEhnWDZLcXh wcWpDQk5CS3IxU2kyUHlsSjA3TzN5MkEwbHhmSUwwCjVhRHlTSkxlREFzeTlBPT0KPUpBNFAKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

Add the trait `ScopedTimerPointer` to allow safe use of stack allocated
timers. Safety is achieved by pinning the stack in place while timers are
running.

Implement the trait for all types that implement `UnsafeTimerPointer`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs | 93 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index 09fb674993c2..6254fa584464 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -70,6 +70,66 @@
 //! pr_info!("Counted to 5\n");
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
+//!
+//! Using a stack based timer:
+//! ```
+//! use kernel::{
+//!     hrtimer::{Timer, TimerCallback, ScopedTimerPointer, TimerRestart},
+//!     impl_has_timer, new_condvar, new_mutex,
+//!     prelude::*,
+//!     stack_try_pin_init,
+//!     sync::{CondVar, Mutex},
+//!     time::Ktime,
+//! };
+//!
+//! #[pin_data]
+//! struct IntrusiveTimer {
+//!     #[pin]
+//!     timer: Timer<Self>,
+//!     #[pin]
+//!     flag: Mutex<bool>,
+//!     #[pin]
+//!     cond: CondVar,
+//! }
+//!
+//! impl IntrusiveTimer {
+//!     fn new() -> impl PinInit<Self, kernel::error::Error> {
+//!         try_pin_init!(Self {
+//!             timer <- Timer::new(),
+//!             flag <- new_mutex!(false),
+//!             cond <- new_condvar!(),
+//!         })
+//!     }
+//! }
+//!
+//! impl TimerCallback for IntrusiveTimer {
+//!     type CallbackTarget<'a> = Pin<&'a Self>;
+//!
+//!     fn run(this: Self::CallbackTarget<'_>) -> TimerRestart {
+//!         pr_info!("Timer called\n");
+//!         *this.flag.lock() = true;
+//!         this.cond.notify_all();
+//!         TimerRestart::NoRestart
+//!     }
+//! }
+//!
+//! impl_has_timer! {
+//!     impl HasTimer<Self> for IntrusiveTimer { self.timer }
+//! }
+//!
+//!
+//! stack_try_pin_init!( let has_timer =? IntrusiveTimer::new() );
+//! has_timer.as_ref().schedule_scoped(Ktime::from_ns(200_000_000), || {
+//!     let mut guard = has_timer.flag.lock();
+//!
+//!     while !*guard {
+//!         has_timer.cond.wait(&mut guard);
+//!     }
+//! });
+//!
+//! pr_info!("Flag raised\n");
+//! # Ok::<(), kernel::error::Error>(())
+//! ```
 
 use crate::{init::PinInit, prelude::*, time::Ktime, types::Opaque};
 use core::marker::PhantomData;
@@ -224,6 +284,39 @@ pub unsafe trait UnsafeTimerPointer: Sync + Sized {
     unsafe fn schedule(self, expires: Ktime) -> Self::TimerHandle;
 }
 
+/// A trait for stack allocated timers.
+///
+/// # Safety
+///
+/// Implementers must ensure that `schedule_scoped` does not until the timer is
+/// dead and the timer handler is not running.
+pub unsafe trait ScopedTimerPointer {
+    /// Schedule the timer to run after `expires` time units and immediately
+    /// after call `f`. When `f` returns, the timer is cancelled.
+    fn schedule_scoped<T, F>(self, expires: Ktime, f: F) -> T
+    where
+        F: FnOnce() -> T;
+}
+
+// SAFETY: By the safety requirement of `UnsafeTimerPointer`, dropping the
+// handle returned by `UnsafeTimerPointer::schedule` ensures that the timer is
+// killed.
+unsafe impl<U> ScopedTimerPointer for U
+where
+    U: UnsafeTimerPointer,
+{
+    fn schedule_scoped<T, F>(self, expires: Ktime, f: F) -> T
+    where
+        F: FnOnce() -> T,
+    {
+        // SAFETY: We drop the timer handle below before returning.
+        let handle = unsafe { UnsafeTimerPointer::schedule(self, expires) };
+        let t = f();
+        drop(handle);
+        t
+    }
+}
+
 /// Implemented by [`TimerPointer`] implementers to give the C timer callback a
 /// function to call.
 // This is split from `TimerPointer` to make it easier to specify trait bounds.
-- 
2.46.0



