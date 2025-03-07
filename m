Return-Path: <linux-kernel+bounces-551997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB16A573DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2EE23B0658
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E39B25B67D;
	Fri,  7 Mar 2025 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6uBesRz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377C257449;
	Fri,  7 Mar 2025 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383674; cv=none; b=pMr1LMdVd7OD/FEUD+Erhb2eb4f8eWw7BcL2BauIcyU/wV4kV6YeKuANt1fe1uIQ4HwpE1UcKY7tXMLjqp7NUczAP/grwve1EFn4pPOO1WCPtebZkYt0wRpMM9iihsNcrsag5yMEWnTDB2sJljBcSln6M+Sp1hXON+EpmiLhh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383674; c=relaxed/simple;
	bh=PkP7dWERrpIqA772sTetspuSqId5QckTq9VZHzXUEeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jm5AlF0bXlUp6AjR11XoetCuOdqoEcjkWKo1DNT68dx6Q1LWsebBbkg3kHBydL/aiy4sRrulVQeqB1jFFdtT1HhDwXnAqt4Ceu1+nT+zj+CKzxeRMW0fVQzwyss6iyP3BOqUhCKRjbF1TMINs166KFnssMBCzbwBrBQnziU6oZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6uBesRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B162C4CED1;
	Fri,  7 Mar 2025 21:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741383673;
	bh=PkP7dWERrpIqA772sTetspuSqId5QckTq9VZHzXUEeE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m6uBesRzzdwmjLaqdFSdUyrC2aXHmz1yxKyKsJK5/uXSlbR+KQQlguQZxnHO2kc0r
	 BhjzUFfICW4Ed35xqCoc4xIJdTFLwKCD+FEKxLoMaFeRkceru1Wybcx5ShoRJfW4os
	 ytBUw/He3/Vm8Umg7WD16J45PXQqv9bPpbwAkP6vpb93LirMPR1tANsgGsIpxiZFId
	 oqr/zkTluSbx2ON2+zNNob9gXOsxDKvpKMJ1LsPHI1e/9vqlfZNXfv8FQEBcvMeMjY
	 90kqd2nv5K1bcSSIwvO3mXzLtbvHpnIGwYZiQq0y5Uaq4ExLEzA2jyi2afDkB7Lkkw
	 Yf19UTe6RttaQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 22:38:44 +0100
Subject: [PATCH v11 03/13] rust: hrtimer: implement `HrTimerPointer` for
 `Arc`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v11-3-7934aefd6993@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
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
 Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4837; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=PkP7dWERrpIqA772sTetspuSqId5QckTq9VZHzXUEeE=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBny2drZ+70NdG0bF2k9lywAloYOgmJ4cFbKhCvI
 IvmnmZBJx2JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8tnawAKCRDhuBo+eShj
 dwXMD/0duRqTwqgvlCF44xsP2rKTxy8Ef/mBN5GZzmL/0EbOTjIXIDaCQRZG/pbbsbcPuQenVds
 uWV/GdkGTpbECtQtp6Y46sQJbvLsGQX8x61mpsqffr8eAp/HZBbylUTcb9/WBslXfXiMl6QylYv
 +tTdWIZrBk5v83fXtcmigywGt8vSfb396IE2H350z9bzfZgXt+3oMXranbJfAcXGR3IMVVtTDPl
 qNXA6zwinwuTvibOdo64y9ypwp0B2lHxviPdkUteeF5kbrryXckAL355N7DqMja+w4aVLbJ0Edd
 WJ9ACi1fNgTcPyIQIAJFY5vf5NjSQ8npIOcIuwYqDPcSiYAWtttQ9GdjmjF6H66zsfEKKQV91AL
 URW4kGR4kVr6bgKFaRLXf9TDhS5YUqC51FU/tJHISgJDR0uYkjt4nSGvAAjbiL4Fyg6B4bETuWU
 7WCCXuQHnkHTRyrCWi3nE7goH2CloabDxj5/rEwH1mLbC0c/YnHoxOgvJVR3+vjumaoTmRQzANx
 TdkP3T7CB1sb7op7JlPfUGFLVpnEdR5Nnf8be2CD/dWd3H9X+4ppKJ5zMSGA7RzhVRwA30bZjHv
 2fakWtWN45AmwIweWq6Jl8cHMflyCXaDMg5U15UL7jfS9fqK39jiIUdu6+ujR2QwnUcFSl6h7Rt
 QKXuWyA4cJD2LmQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow the use of intrusive `hrtimer` fields in structs that are managed by
an `Arc` by implementing `HrTimerPointer` and `RawTimerCallbck` for `Arc`.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     |   4 +-
 rust/kernel/time/hrtimer/arc.rs | 102 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index dc64cef96dd4..f69a8483d21f 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -150,7 +150,6 @@ unsafe fn raw_get(this: *const Self) -> *mut bindings::hrtimer {
     /// # Safety
     ///
     /// `this` must point to a valid `Self`.
-    #[allow(dead_code)]
     pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
         // SAFETY: `this` points to an allocation of at least `HrTimer` size.
         let c_timer_ptr = unsafe { HrTimer::raw_get(this) };
@@ -349,3 +348,6 @@ unsafe fn timer_container_of(
         }
     }
 }
+
+mod arc;
+pub use arc::ArcHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
new file mode 100644
index 000000000000..fe3cb869bc9b
--- /dev/null
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::HasHrTimer;
+use super::HrTimer;
+use super::HrTimerCallback;
+use super::HrTimerHandle;
+use super::HrTimerPointer;
+use super::RawHrTimerCallback;
+use crate::sync::Arc;
+use crate::sync::ArcBorrow;
+use crate::time::Ktime;
+
+/// A handle for an `Arc<HasHrTimer<T>>` returned by a call to
+/// [`HrTimerPointer::start`].
+pub struct ArcHrTimerHandle<T>
+where
+    T: HasHrTimer<T>,
+{
+    pub(crate) inner: Arc<T>,
+}
+
+// SAFETY: We implement drop below, and we cancel the timer in the drop
+// implementation.
+unsafe impl<T> HrTimerHandle for ArcHrTimerHandle<T>
+where
+    T: HasHrTimer<T>,
+{
+    fn cancel(&mut self) -> bool {
+        let self_ptr = Arc::as_ptr(&self.inner);
+
+        // SAFETY: As we obtained `self_ptr` from a valid reference above, it
+        // must point to a valid `T`.
+        let timer_ptr = unsafe { <T as HasHrTimer<T>>::raw_get_timer(self_ptr) };
+
+        // SAFETY: As `timer_ptr` points into `T` and `T` is valid, `timer_ptr`
+        // must point to a valid `HrTimer` instance.
+        unsafe { HrTimer::<T>::raw_cancel(timer_ptr) }
+    }
+}
+
+impl<T> Drop for ArcHrTimerHandle<T>
+where
+    T: HasHrTimer<T>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+impl<T> HrTimerPointer for Arc<T>
+where
+    T: 'static,
+    T: Send + Sync,
+    T: HasHrTimer<T>,
+    T: for<'a> HrTimerCallback<Pointer<'a> = Self>,
+{
+    type TimerHandle = ArcHrTimerHandle<T>;
+
+    fn start(self, expires: Ktime) -> ArcHrTimerHandle<T> {
+        // SAFETY:
+        //  - We keep `self` alive by wrapping it in a handle below.
+        //  - Since we generate the pointer passed to `start` from a valid
+        //    reference, it is a valid pointer.
+        unsafe { T::start(Arc::as_ptr(&self), expires) };
+        ArcHrTimerHandle { inner: self }
+    }
+}
+
+impl<T> RawHrTimerCallback for Arc<T>
+where
+    T: 'static,
+    T: HasHrTimer<T>,
+    T: for<'a> HrTimerCallback<Pointer<'a> = Self>,
+{
+    type CallbackTarget<'a> = ArcBorrow<'a, T>;
+
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `HrTimer` is `repr(C)`
+        let timer_ptr = ptr.cast::<super::HrTimer<T>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // queuing the timer, so it is a `HrTimer<T>` embedded in a `T`.
+        let data_ptr = unsafe { T::timer_container_of(timer_ptr) };
+
+        // SAFETY:
+        //  - `data_ptr` is derived form the pointer to the `T` that was used to
+        //    queue the timer.
+        //  - As per the safety requirement for the trait `HrTimerHandle`, the
+        //    `ArcTimerHandle` associated with this timer is guaranteed to be
+        //    alive for the duration of the lifetime of `receiver`, so the
+        //    refcount of the underlying `Arc` is guaranteed to be nonzero for
+        //    the duration.
+        //  - We own one refcount in the `ArcTimerHandle` associated with this
+        //    timer, so it is not possible to get a `UniqueArc` to this
+        //    allocation from other `Arc` clones.
+        let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
+
+        T::run(receiver);
+
+        bindings::hrtimer_restart_HRTIMER_NORESTART
+    }
+}

-- 
2.47.0



