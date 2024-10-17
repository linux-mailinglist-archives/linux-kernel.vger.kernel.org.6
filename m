Return-Path: <linux-kernel+bounces-369819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9959A2329
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2D4283100
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369051DE4D6;
	Thu, 17 Oct 2024 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPV/MUyT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60C1DE4C8;
	Thu, 17 Oct 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170560; cv=none; b=uzsvCLGrzZFoBYqRgRBd76JrjY28XGWiPLW1bVMqrSz93g9nxJiRppvcdNZNZ2t3pSRiwg+CXoX1nWvDhPnmbobR/6gL/GbVIHepUbcPxqlOHeG/MP1I+Ubon2r28pVT7HhNPgWkB9+DM5ry60/h37MnGlIOHuLneVAd6G5YmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170560; c=relaxed/simple;
	bh=kEEtRzguOzN8Ion4HyzOjI+aWeQ2Y+lQGVZV/cNGGmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxwqSlyQeZyoVBftBsOharVkottOGNCNdr5c+2Zy/jmGMz9eim38ClpzruXQ9y9V08fOprUvWX3+MA/Na3v38UeAS932GW2OfgMsqRo+wTldAhD4Mcu09ve7lX8KrS+0rfrTTG2ZKYpkDXUi/syuImZcAS4xd8LPcwgQZdYtqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPV/MUyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6D9C4CEC5;
	Thu, 17 Oct 2024 13:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170560;
	bh=kEEtRzguOzN8Ion4HyzOjI+aWeQ2Y+lQGVZV/cNGGmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uPV/MUyT34OMZaTRj+PVZ3QpMZt4s/DmIGXQvou6Ly/plWJuykg+0DNzcFJjNwouz
	 zlk+0GDYu3hUVJwWKDE4JM5ZAiA8kPuA2R07gWKbnqz85kW1MYXdOuFHiYIRNxan57
	 dQlbxBYmgB0mnK1CvYPj643uAu8MLw7mO1vL4av+EVOq+K1XcdLm84Pm8UAVP4UW9E
	 P5xd0HqAf1HY1dP52OOk1z8ayWZHEQsKFputT+3/pA1ZHNjyqdoQ0jeiveQOVhHcow
	 PYiwmvFlgRPjl5Dg+FbxRC6eALkMAoVAL5ADwKSDre14yoCjH2YiCigzYmMlFzluY3
	 oID++KAqIRztg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 17 Oct 2024 15:04:31 +0200
Subject: [PATCH v3 04/13] rust: hrtimer: implement `TimerPointer` for `Arc`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-4-59a75cbb44da@kernel.org>
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

This patch allows the use of intrusive `hrtimer` fields in structs that are
managed by an `Arc`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs     |  3 +-
 rust/kernel/hrtimer/arc.rs | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index 99058a690f2e18b5c26c94c71133407019aa4a26..6427b0450c694105190c8cddea0c768ab195aca2 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -107,7 +107,6 @@ unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
     /// # Safety
     ///
     /// `self_ptr` must point to a valid `Self`.
-    #[allow(dead_code)]
     pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
         // SAFETY: timer_ptr points to an allocation of at least `Timer` size.
         let c_timer_ptr = unsafe { Timer::raw_get(self_ptr) };
@@ -302,3 +301,5 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
         }
     }
 }
+
+mod arc;
diff --git a/rust/kernel/hrtimer/arc.rs b/rust/kernel/hrtimer/arc.rs
new file mode 100644
index 0000000000000000000000000000000000000000..881de053ecad866a26e46a0123ec2bf38511c2bc
--- /dev/null
+++ b/rust/kernel/hrtimer/arc.rs
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::HasTimer;
+use super::RawTimerCallback;
+use super::Timer;
+use super::TimerCallback;
+use super::TimerHandle;
+use super::TimerPointer;
+use crate::sync::Arc;
+use crate::sync::ArcBorrow;
+use crate::time::Ktime;
+
+/// A handle for an `Arc<HasTimer<U>>` returned by a call to
+/// [`TimerPointer::start`].
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
+        let self_ptr = Arc::as_ptr(&self.inner);
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
+    fn start(self, expires: Ktime) -> ArcTimerHandle<U> {
+        // SAFETY: Since we generate the pointer passed to `start` from a
+        // valid reference, it is a valid pointer.
+        unsafe { U::start(Arc::as_ptr(&self), expires) };
+
+        ArcTimerHandle { inner: self }
+    }
+}
+
+impl<U> RawTimerCallback for Arc<U>
+where
+    U: HasTimer<U>,
+    U: for<'a> TimerCallback<CallbackTarget<'a> = Self>,
+    U: for<'a> TimerCallback<CallbackTargetParameter<'a> = ArcBorrow<'a, U>>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `Timer` is `repr(C)`
+        let timer_ptr = ptr.cast::<kernel::hrtimer::Timer<U>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // queuing the timer, so it is a `Timer<T>` embedded in a `T`.
+        let data_ptr = unsafe { U::timer_container_of(timer_ptr) };
+
+        // SAFETY: `data_ptr` points to the `U` that was used to queue the
+        // timer. This `U` is contained in an `Arc`.
+        let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
+
+        U::run(receiver);
+
+        bindings::hrtimer_restart_HRTIMER_NORESTART
+    }
+}

-- 
2.46.0



