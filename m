Return-Path: <linux-kernel+bounces-369823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DFD9A232D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC87F2822FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E333D1DE896;
	Thu, 17 Oct 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXikI7Q/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6571DE893;
	Thu, 17 Oct 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170577; cv=none; b=GptpORyyMeVyl052m5tNVO6vPEgp8CHCZQi5rnnAypvhONsLYswpUE2OGQquupG01JaucycCh84MhQi6RIhMVpcHtiImfhgI9ScHMQZJyrO+1jaKOrLA784NeiRHNM7JJlKdroZtnBKPPaVmpv25MY/9YrQAWmiRDV+eh+majTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170577; c=relaxed/simple;
	bh=vK66/laxxraODLHeUfQy6EIVcT/80ojUgOWDCBSGJcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CvTW+EexXtwulsZ142icJXRyiM1B6srLxkOA3/P+KiNePCN+vVDkrRI7Chl0RZITLDl0B8tJSiJnNiB/jLr/DwTrMSigPUOWeCoS5jTtXuM8alZ7bUq5oROUcQ2ttAruBL1wFerljo/cDmBieYTfFb9CuEv2HXz2hxErjccyiz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXikI7Q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1E1C4CEC3;
	Thu, 17 Oct 2024 13:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170576;
	bh=vK66/laxxraODLHeUfQy6EIVcT/80ojUgOWDCBSGJcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nXikI7Q/iXtSUChiZjg5VM2V6SbDL1EWfPtcYI9l3xuc0MD5mIqkK7Dew/Tt11qDI
	 KQJDa7RnGN9o6Df22UyGYTYza654ur8duVzUBEgGuxtg2Lwxug3Rc/wwn/F0Lj7A/0
	 HhpBxgRPon2vt/trsLXM8KFDoJYV+/rwIomWS6YdgoHUf2K4x5vBkeVJ1pt7bUjyP1
	 yEF4JpaLN9962Y3XWYnygBQGoaLydooyRDTjM+QSxzRe+DKd/H2Fyz8tcTmKVgIWA2
	 HhbGPy5fjcEjeQIzB7igFcQrseMiQNVDI+QEpLahT9Yut7fzYS2JZThTpC/2TnXMWw
	 cw8y1fNyZ/sqQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 17 Oct 2024 15:04:35 +0200
Subject: [PATCH v3 08/13] rust: hrtimer: implement `UnsafeTimerPointer` for
 `Pin<&mut T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-8-59a75cbb44da@kernel.org>
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

Allow pinned mutable references to structs that contain a `Timer` node to
be scheduled with the `hrtimer` subsystem.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs         |  1 +
 rust/kernel/hrtimer/pin_mut.rs | 99 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index ceedf330a803ec2db7ff6c25713ae48e2fd1f4ca..940390aa2a6c6a222534b545d8d2fbd639a19f64 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -363,3 +363,4 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 
 mod arc;
 mod pin;
+mod pin_mut;
diff --git a/rust/kernel/hrtimer/pin_mut.rs b/rust/kernel/hrtimer/pin_mut.rs
new file mode 100644
index 0000000000000000000000000000000000000000..d6c85647a762066776cf292620a8b19c12721876
--- /dev/null
+++ b/rust/kernel/hrtimer/pin_mut.rs
@@ -0,0 +1,99 @@
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
+/// A handle for a `Pin<&mut HasTimer>`. When the handle exists, the timer might
+/// be running.
+pub struct PinMutTimerHandle<'a, U>
+where
+    U: HasTimer<U>,
+{
+    pub(crate) inner: Pin<&'a mut U>,
+}
+
+// SAFETY: We cancel the timer when the handle is dropped. The implementation of
+// the `cancel` method will block if the timer handler is running.
+unsafe impl<'a, U> TimerHandle for PinMutTimerHandle<'a, U>
+where
+    U: HasTimer<U>,
+{
+    fn cancel(&mut self) -> bool {
+        // SAFETY: We are not moving out of `self` or handing out mutable
+        // references to `self`.
+        let self_ptr = unsafe { self.inner.as_mut().get_unchecked_mut() as *mut U };
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
+impl<'a, U> Drop for PinMutTimerHandle<'a, U>
+where
+    U: HasTimer<U>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+// SAFETY: We capture the lifetime of `Self` when we create a
+// `PinMutTimerHandle`, so `Self` will outlive the handle.
+unsafe impl<'a, U> UnsafeTimerPointer for Pin<&'a mut U>
+where
+    U: Send + Sync,
+    U: HasTimer<U>,
+    U: TimerCallback<CallbackTarget<'a> = Self>,
+{
+    type TimerHandle = PinMutTimerHandle<'a, U>;
+
+    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle {
+        use core::ops::Deref;
+
+        // Cast to pointer
+        let self_ptr = self.deref() as *const U;
+
+        // SAFETY: As we derive `self_ptr` from a reference above, it must point
+        // to a valid `U`.
+        unsafe { U::start(self_ptr, expires) };
+
+        PinMutTimerHandle { inner: self }
+    }
+}
+
+impl<'a, U> RawTimerCallback for Pin<&'a mut U>
+where
+    U: HasTimer<U>,
+    U: TimerCallback<CallbackTarget<'a> = Self>,
+    U: TimerCallback<CallbackTargetParameter<'a> = Self>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `Timer` is `repr(C)`
+        let timer_ptr = ptr as *mut Timer<U>;
+
+        // SAFETY: By the safety requirement of this function, `timer_ptr`
+        // points to a `Timer<U>` contained in an `U`.
+        let receiver_ptr = unsafe { U::timer_container_of(timer_ptr) };
+
+        // SAFETY: By the safety requirement of this function, `timer_ptr`
+        // points to a `Timer<U>` contained in an `U`.
+        let receiver_ref = unsafe { &mut *receiver_ptr };
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



