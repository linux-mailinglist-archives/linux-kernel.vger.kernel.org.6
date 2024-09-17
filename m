Return-Path: <linux-kernel+bounces-332123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC9D97B5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A25FB29743
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2A7192D76;
	Tue, 17 Sep 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7Frz93C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72129178363;
	Tue, 17 Sep 2024 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612132; cv=none; b=ISz9D5FFPh0BTSv9d/OJGJaPxowMBlZOl1465hsFtyn4SVf44iagvjSVEADhSuJqPEW8u03qsEwDOoY86vRDCWPXnY/CjGnc9K4efdXFsC9+1TP766zbLOGOw3niM9yoiBUMNQpq4oGfqQcTGpLaRUGroft4vTcN5JuGNEGrlik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612132; c=relaxed/simple;
	bh=BkB2xvYeoQrGfgSamMPfNUGbcq5vvBqTCceqHEixtuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxmX2zhRIFJqHj64KOhGDlEABNuQEHJcXR5Gmgh9G25NyshLNWB2Ulpg2+Vd6lAQW3uQO38FzyYkeXoaqZhjpVoV5UPttYnmj6mw9yV3gqHw3c7+bjS1ZFcyD1fw5004+ZkeEC+1eawOMp/sML+t8/iu6ywnTkjp1o/lysVb9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7Frz93C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E34CC4CEC5;
	Tue, 17 Sep 2024 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612132;
	bh=BkB2xvYeoQrGfgSamMPfNUGbcq5vvBqTCceqHEixtuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n7Frz93Cekm1lxLTVeggTlHMKB3veKPOhzSifoEG8vRWNYoR3zL437JgtCROg9tL0
	 wu3+hVtrk0tPN6ybFg9S+TyThheFZrTCtxQuHCAvsWwca1qAQMiUL/nzGZGlEOUQBI
	 f9Sfe7cIyFHKCVGTO1hkrb7j2WikzbLyTDRHCLMTXxQO8lMTHwUPrGDC68N8T/D9s+
	 a/gZCIDrmpeFmli9eJRHpGrz+wQWLqX1i6cFjoAHRb/Ph6aXNKSdH1WkT1Tvnyi/bX
	 X6qkzs4uWgtJoCQFxQ7Naa5Ub1Mci490nJ+leXWgTYljznY24mr6DwOJjvXVDe48+E
	 55Y8QaGa+kHYQ==
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
Subject: [PATCH v2 08/14] rust: hrtimer: implement `UnsafeTimerPointer` for `Pin<&T>`
Date: Wed, 18 Sep 2024 00:27:32 +0200
Message-ID: <20240917222739.1298275-9-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3873; i=a.hindborg@kernel.org; h=from:subject; bh=BkB2xvYeoQrGfgSamMPfNUGbcq5vvBqTCceqHEixtuQ=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWZ3NVNGVStLVmR2WGlobk9sUHA3RkN1CmhrOE5XWlRpSEhkbmU5TEIw cS9lbW9rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSDh BQW9KRU9HNEdqNTVLR04zQlRzUC8wMFQrUG5VYkEzQ0ZKbmRWODRGL3F4elpHbzRTZk9XcnR5Tw pGeExuUXBYZXlDTGtxV25zZU5LMmhsTHJTWVRqOHdiOVhZeVNEWHNPakkwb1VxMHY4UEFjSnFXV Wc3UTNLOUpzCjllc2taU0RveW05NUF3WVU5cE5CdEYxcHhpMWhBckVhVGQ4Z1dicERRQlQ0RXcr WHdzekRuNlhRc25IUEI3L1cKNTYrTkx4blNtejZuY1RUY3ptYkprQlRRVENhemJvZU12YVdqMU5 yRHFqYjIrOTFyWUNtNnJUdVN3Y2R2cXFoTApRVHRBMU1JMUx6eGdJYzd5TmQ3eldubkVweFdPTE o3RTk3SHIyVkhMRmZDNUs5bmhtSVhjTW8vclRHc3VxWlZpClFlQ01pRFgzQkhBS21BeXpMSHAvU CtrVk9vQ0VyTkJIMERFZlkrRC9aeXdINXZwbENOcGxqMW43TzhweEk3RlEKOFB5VXd2NTdPOXZw ME8weHhHYjNTNDlDd1RCSklWdVQvdlNNVmlRVEhubmxpU2xaZ2kvWnIrb09YbjdMRjd4dwpFaHV OVDB5UTExUjJRa0QvM
 zhMYVNvZk4zV2JkQnNmZ2dIRElqTjNSODVxcTg2N1IrMFI4ODJNOFR5Yz l2Yjg3Cm5rME5tMXYwdU9XZE0rQ0x0MDBQMVc0VnJuOHJZemhNOE1mcnE5TzdWZ0FhS2tTM24zc 2lVUXBxdE5Yb2ZKY3EKY3REb0tLM0Z4ODNvYWlLTk95VFpZYWlVZjdkQVBIRnpBcnM4am9Eb1Jz S2ZVMGhibHRXbXdxZ3J4djRGajA4agpWWUI0V2VNclhscGg5QzlGUDA0MG1Wa2IyZ1ZYV2JVejJ kbit3RysrdnBrcWFoemZ5bG1CMS95eWRVSmMyUU5RCll4eTRHNVFZcDZVd3N3PT0KPUxJRnoKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

Allow pinned references to structs that contain a `Timer` node to be
scheduled with the `hrtimer` subsystem.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs     |  1 +
 rust/kernel/hrtimer/pin.rs | 96 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 rust/kernel/hrtimer/pin.rs

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index bb6349f440e2..25d3702d0d05 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -396,3 +396,4 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 }
 
 mod arc;
+mod pin;
diff --git a/rust/kernel/hrtimer/pin.rs b/rust/kernel/hrtimer/pin.rs
new file mode 100644
index 000000000000..f9ce0498a0d2
--- /dev/null
+++ b/rust/kernel/hrtimer/pin.rs
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::HasTimer;
+use super::RawTimerCallback;
+use super::Timer;
+use super::TimerCallback;
+use super::TimerHandle;
+use super::UnsafeTimerPointer;
+use crate::time::Ktime;
+use core::pin::Pin;
+
+/// A handle for a `Pin<&HasTimer>`. When the handle exists, the timer might be
+/// armed.
+pub struct PinTimerHandle<'a, U>
+where
+    U: HasTimer<U>,
+{
+    pub(crate) inner: Pin<&'a U>,
+}
+
+// SAFETY: We cancel the timer when the handle is dropped. The implementation of
+// the `cancel` method will block if the timer handler is running.
+unsafe impl<'a, U> TimerHandle for PinTimerHandle<'a, U>
+where
+    U: HasTimer<U>,
+{
+    fn cancel(&mut self) -> bool {
+        let self_ptr = self.inner.get_ref() as *const U;
+
+        // SAFETY: As we got `self_ptr` from a reference above, it must point to
+        // a valid `U`.
+        let timer_ptr = unsafe { <U as HasTimer<U>>::raw_get_timer(self_ptr) };
+
+        // SAFETY: As `timer_ptr` is derived from a reference, it must point to
+        // a valid and initialized `Timer`.
+        unsafe { Timer::<U>::raw_cancel(timer_ptr) }
+    }
+}
+
+impl<'a, U> Drop for PinTimerHandle<'a, U>
+where
+    U: HasTimer<U>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+// SAFETY: We capture the lifetime of `Self` when we create a `PinTimerHandle`,
+// so `Self` will outlive the handle.
+unsafe impl<'a, U> UnsafeTimerPointer for Pin<&'a U>
+where
+    U: Send + Sync,
+    U: HasTimer<U>,
+    U: TimerCallback<CallbackTarget<'a> = Self>,
+{
+    type TimerHandle = PinTimerHandle<'a, U>;
+
+    unsafe fn schedule(self, expires: Ktime) -> Self::TimerHandle {
+        use core::ops::Deref;
+
+        // Cast to pointer
+        let self_ptr = self.deref() as *const U;
+
+        // SAFETY: As we derive `self_ptr` from a reference above, it must point
+        // to a valid `U`.
+        unsafe { U::schedule(self_ptr, expires) };
+
+        PinTimerHandle { inner: self }
+    }
+}
+
+impl<'a, U> RawTimerCallback for Pin<&'a U>
+where
+    U: HasTimer<U>,
+    U: TimerCallback<CallbackTarget<'a> = Self>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `Timer` is `repr(transparent)`
+        let timer_ptr = ptr as *mut Timer<U>;
+
+        // SAFETY: By the safety requirement of this function, `timer_ptr`
+        // points to a `Timer<U>` contained in an `U`.
+        let receiver_ptr = unsafe { U::timer_container_of(timer_ptr) };
+
+        // SAFETY: By the safety requirement of this function, `timer_ptr`
+        // points to a `Timer<U>` contained in an `U`.
+        let receiver_ref = unsafe { &*receiver_ptr };
+
+        // SAFETY: `receiver_ref` only exists as pinned, so it is safe to pin it
+        // here.
+        let receiver_pin = unsafe { Pin::new_unchecked(receiver_ref) };
+
+        U::run(receiver_pin).into()
+    }
+}
-- 
2.46.0



