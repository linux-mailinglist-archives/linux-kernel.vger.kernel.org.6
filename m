Return-Path: <linux-kernel+bounces-449460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D97739F4F55
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18061881F57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9687C1F9A94;
	Tue, 17 Dec 2024 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMRlDaAT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E413B1F8666;
	Tue, 17 Dec 2024 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448841; cv=none; b=ftL5llK6CUG2vcTGD0u+7sOdmS4gphBMlp1FDcaOilEqvq1k/4t56PhPLscdGSrmYoiGOZFsgjmCTICA0aNZww7WRn3EbI1Y9PeMSs8bIBcIjGtXsWEx7wWz8PrxLRHcqqmCWql0HR+ycZulgG+CpgvYC2ZV9if8vCnQ2HdNXnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448841; c=relaxed/simple;
	bh=5Yt7jBm0gYPrBh6n87ngEjFAFMCg7ynZ/CL4taawfrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oUYsb7CPyDVy94+hpRWaZTgknOsRUbGQnB6xiLSJE6v1grPILBTOqqpiCDc48nXB3SDfZYIbIeAHCpCy+RVctXcsZd061wisFqoOgaHzrrl1ktXbA8rftL80f/SxWpRWI46N4CMd4SMEtJjuNhYzglhhvpSzuQhQ5eJZQ+rVB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMRlDaAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F163EC4CED3;
	Tue, 17 Dec 2024 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448840;
	bh=5Yt7jBm0gYPrBh6n87ngEjFAFMCg7ynZ/CL4taawfrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EMRlDaATeJ4kwnqvpwPwM1LwaJ8qV6bfkXnBAW91Ty/KYbLfkZtIY0P4aW1Lx/Xap
	 qSQ3CeiB4c/j/SeE8V+qxrRtQcqBI1zJDlS/cnLRWGZH+44xmEjB2igT8/AvnDw7pM
	 wD6jYYaZhSARmlvbWrdO8DH5ZHrdOQGyyEC/1niBV2ZPXZZ9sxvuhj4SC8t2LKY9AC
	 bS0zUBKjZ6XQ+k6Q5zhbX9zpWPwwtxnlqMbfRRGCYGgcvs1ne61MvY4kXwvSW3o2CZ
	 cEKnBiTrdFwkFcY9ayaO/V8OpUvCsJLI29uXagDhNQN29HFqew8zZpg1xxhIintx80
	 935MeEeGoPLPw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:40 +0100
Subject: [PATCH v5 09/14] rust: hrtimer: implement `UnsafeTimerPointer` for
 `Pin<&mut T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-9-b34c20ac2cb7@kernel.org>
References: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
In-Reply-To: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
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
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4236; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=5Yt7jBm0gYPrBh6n87ngEjFAFMCg7ynZ/CL4taawfrw=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYZOg/XWDhRuPjFHq4lXw7hp3WhvDU8418iI
 YC0YuKebmaJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWGQAKCRDhuBo+eShj
 d8wVEACYy/zUfMd+xmKlTGeUy8uAumKd2euRbCwuHmIcyCjFcoxHLd4PKPwtbAZoIakWBtM0o6c
 5xgGIjq98qubyg8+VnjR0gYt2qjVmuvEXjnl00mah3qkhevkC1msGzIEwkdE36VC64zr26ILCB6
 eg+WrVrtGWVdQdv30odBd1ENH58Mz09hbBIpLptr6K2iaA7Y6N+Bj/k8Cemv+qqVYxixABANXXR
 Xwob9CoJwDtRv0vt7LdwmN9xjRzFg9M6dL7tnWUIiVSXrKVJ0dKnd+F8g2xu/+LwjpE+FIb79XG
 IN7cBllcBjMijo4dV5MHa89GBTPnsfQb1MZSJN/+M/5H6LsM10aBGb7lLXOfN7Bz0ceIFmC+Pkg
 aEs6pVRNNlwT3BdSE8ypA84OBTKlTKSRLBSvLb65NBsc77jgZQJ/t0ytVC+vrXvm2I2wwQQeduS
 6A1/dEHEt8yvSBowk9DC548SPaLNDSw1nxtXYhSMNnHKpEK1LroAENOHJbXNWSo484lrrcbi9Ka
 Y7+LestMhTudIFWrru/JPsd0mlKkR44DWa4okMYCr9jLzMLW5qhrcoj/qd4x1oMmKHMShJVc3hg
 ol+LnouFrhgbRnbfO4UICKJXuMHmLqwNjqD6ebIhaKIdrawtkCwuDn8rfKGhEHIS6nmfNekXMix
 ZAxYthucH2T/zlA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow pinned mutable references to structs that contain a `Timer` node to
be scheduled with the `hrtimer` subsystem.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs         |  1 +
 rust/kernel/time/hrtimer/pin_mut.rs | 97 +++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 00172cb50ff153ef2b911f5025bdca40b995e825..c223f1385c723a0b75e7f8184deadbca38872e0a 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -397,3 +397,4 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 
 mod arc;
 mod pin;
+mod pin_mut;
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
new file mode 100644
index 0000000000000000000000000000000000000000..50ba9109919838aa9b09381000bab4ab8d3a2340
--- /dev/null
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -0,0 +1,97 @@
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
+        // Cast to pointer
+        let self_ptr: *const U = <Self as core::ops::Deref>::deref(&self);
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
2.47.0



