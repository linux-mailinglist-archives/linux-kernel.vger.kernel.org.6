Return-Path: <linux-kernel+bounces-449450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEEF9F4F41
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E357A7A879B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2AE1F868B;
	Tue, 17 Dec 2024 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGGg3QFN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE61F707F;
	Tue, 17 Dec 2024 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448783; cv=none; b=BN5OQM9BL7hGjbLPXDnLpYieRRDZGngqXPxdU8fT/ZPsHmrxxD/dxC/Cu7qM/E3oSh97MkqH5jfY4e6zgWGPzULYb5JjyVdA8rfVlSHVuF22NB2ITU8Gb/8X7hP6UBLM1h1w+scTkTAYMXy4S1UKMhXIjgxfBAge3jVFD9Y5ZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448783; c=relaxed/simple;
	bh=AGCwY1Om71mI6/3ZTwWXymP7dzg0hkZbFbkHu2TONUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zn10bMgSXB0UcOgvShBlYrwhpaT6nXMKap60bv0IBtaZlCD0x/Sw05veM42x4pvz1+IKH2YfEJH6euEGzFN1dRvkf2wCnWTQs2vEC8ryjIefPgAqz9GPej/NV+nOnS4DFZ36vqadrOICwUnCrHs1YiiAtSMvpgPyhNbfLl67dNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGGg3QFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B89FC4CEDE;
	Tue, 17 Dec 2024 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448783;
	bh=AGCwY1Om71mI6/3ZTwWXymP7dzg0hkZbFbkHu2TONUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SGGg3QFNVk5/K9U+VkQM4Vvdg61UVFiRVDW0GLR8HJSWZJwZ7WA/O2asjN/PTKwym
	 ODMmONGUkS2i87cIZtS4Yzc3fDePHAPp+ASKg0DzhoFRuK5SbCNymWRCoo6agmOx7+
	 v5esgH736HUtdVdZZBp/UWpox6zahcr1JObJ+rAk/jdH07zAwTbSgcgg0d7SgRoHiR
	 3V8aEhHj0+TwHhdl/VUFnvscDjDSCh9+EZitNxpwweX48+9kBhKZWTmGrNkk1YRFbI
	 uz38IShxkzxNAJ+qTGnsfayHZKgIx0hUpEXDQVsd14u6jOTFV7Y+/PYnQVHV5Vj7Ws
	 2J+xXLjsJuA6g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:39 +0100
Subject: [PATCH v5 08/14] rust: hrtimer: implement `UnsafeTimerPointer` for
 `Pin<&T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-8-b34c20ac2cb7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4022; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=AGCwY1Om71mI6/3ZTwWXymP7dzg0hkZbFbkHu2TONUo=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYYwtCBpF0UKh7xFacK6svSlIP1W/4Uem2wy
 JnDK0TyvH+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWGAAKCRDhuBo+eShj
 d/lkEACfvalN6T5UYMPXsLzwVE9GbPqTgKceSu5/qW3Ql8ujryRhq6/zKMunRSwTJXvuO3vtxM+
 R79BRWlQMD5kKi7Hzh0swOPRE1+tsHHRtV5gIGZPDa21zoawbtBa87HdCFnE3K2Mizu9QcYBHKq
 Mp5DU2IYM1WYpsAUbusBLcrUeSeRQT8qG9i9BLR01AtD7GLNwAMdQoz39q9N1FB5/fRrR8U9vin
 sgzQahZMOvM5jmxMXOW4+OkuB7Dg/Stt8H//5H01uJdb3gpEQ1hUQLZk7Q6YBtmVK6gr55Rx31M
 hq2C422ycUMKFf2GpeTWVaSpT8TrjWfdR57+7WO9uW1s1+vB6w22nDj3t2eiF/BvCHVetn/psS9
 J+I5zurw+NsFSoSW5jsaCD69+MjJUxannOxmMf2T8eMtkQkZRLZ/PVX7OxqgZx9mBVf6MYiM+Jb
 gyoRkakN/MLB22otzn6IIvdy4UfCRb3ilupgg/41iy+EZwbtHUvgVe1QZXKuvms4jrNfdydlYWo
 /p3zqtbnO9dvoXYfAW9HfJiXQyozITvsnAmUtNAxc2PEnRh3qeJITIrMvVUd3l3SXATwlTvzO6A
 hg/QPGd8qHvUJvmoEcDiQoeBJ+GeQNiAgbf7wvk5SfvxyBjWn4NrflykHmdjWaHK2rs1/saHTBz
 Ts3YMaZptsKodmQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow pinned references to structs that contain a `Timer` node to be
scheduled with the `hrtimer` subsystem.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     |  1 +
 rust/kernel/time/hrtimer/pin.rs | 95 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 6b03eb4b42dbd6447728c42949a2f93d736dc3b0..00172cb50ff153ef2b911f5025bdca40b995e825 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -396,3 +396,4 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 }
 
 mod arc;
+mod pin;
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
new file mode 100644
index 0000000000000000000000000000000000000000..7b251f157b2c196a3bde220b12619ce0c0ecce6c
--- /dev/null
+++ b/rust/kernel/time/hrtimer/pin.rs
@@ -0,0 +1,95 @@
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
+/// running.
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
+        let self_ptr: *const U = self.inner.get_ref();
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
+    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle {
+        // Cast to pointer
+        let self_ptr: *const U = <Self as core::ops::Deref>::deref(&self);
+
+        // SAFETY: As we derive `self_ptr` from a reference above, it must point
+        // to a valid `U`.
+        unsafe { U::start(self_ptr, expires) };
+
+        PinTimerHandle { inner: self }
+    }
+}
+
+impl<'a, U> RawTimerCallback for Pin<&'a U>
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
2.47.0



