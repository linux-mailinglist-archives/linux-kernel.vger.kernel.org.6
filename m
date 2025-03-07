Return-Path: <linux-kernel+bounces-551990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BEAA573D3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B273AA321
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3382D258CDB;
	Fri,  7 Mar 2025 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovp8Lr6N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E4258CC8;
	Fri,  7 Mar 2025 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383642; cv=none; b=EjuFlfYSBMdhSA8zQX4LmXzRTu8werETVELc6YQl4OBaNRlb+07HIqmUxqZD/bCSkhTbLEEQzan40vhVW7kQctuyAGIVq6od3N6E0j/7mrPWBUQ/GexMz6/bQpzQsQ+JCzOSQghuKUsGywycnH40prWx1PaClDdaonjZUWBBh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383642; c=relaxed/simple;
	bh=VhJsbQKfMjuj9PdCzRWTYfUb7k+hB0p9SP5ael/b4P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBL0XiByiIECHWhprA6nU8frS4YlyKP6J3Rb9glj6DOa9hXXr8iSldHFTDk+yPzky1dv7qaeF6QZGxJ5shusRBE1Et36+roj3OESbTuKE1Rm1SQ3mkmOdabHavguyIuZmnLgLFNQNz6lNLjRvvLHEe6AHg3zu6svd5IF1A85nAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovp8Lr6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F234C4CED1;
	Fri,  7 Mar 2025 21:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741383641;
	bh=VhJsbQKfMjuj9PdCzRWTYfUb7k+hB0p9SP5ael/b4P0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ovp8Lr6NNy+wgA2cGcykmix8OVw3ClYfqa4NvUp+K4RFQpZGNG49p/vCaybQRT1Ba
	 V1TYP4Qfq0j3+FdHnYQukk1VB8+0qdKnOXQNok/pf/n33dTdC0LOQEAJcn7nWc3dXA
	 9xhKX23Pyx+HdXg9Nzx8Bmp7gRMQSBebuOCuj3WnFiFW1gRPizm7Y85y6YIWuYch8V
	 UD+MtBrW1n6iFqc+DDpvs0qL5cn8WWEc+SXzq8QdJaRjM2AX/lq8+7w6dtNYTqZbkQ
	 MQM3N5SxZDbgj2loMOOXr2bhknCYuQhhv/yuCEoYKCG6ErwHU9FJhWcUvyJq98TUy9
	 1UC8tX/OHxp+w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 22:38:49 +0100
Subject: [PATCH v11 08/13] rust: hrtimer: implement `UnsafeHrTimerPointer`
 for `Pin<&mut T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v11-8-7934aefd6993@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5089; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=VhJsbQKfMjuj9PdCzRWTYfUb7k+hB0p9SP5ael/b4P0=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBny2dwDd/B5I5XHoS4NT6uJl6tIIXWSndxjgIjw
 3lEnwx40vGJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8tncAAKCRDhuBo+eShj
 d1HIEACk8oL/ITmAVZbUoaVG6WNUI0HlU8TSg9GbNa1ImwDdEur4qxzcQ6nAAdw/rOONjlrVbTX
 Z8Fduu3t3XNQfibyGSfcKTkYqAG9/eeKMcrWShL+SwrySRMgrXOuuOPgw1k2XQDBb5cKuXLurkm
 rHNpGIG90EswJiRxR20GA4XdEYyjSLbn05BCJ/5ojh9oT3RNSEcgIP3Hn8Rto8SAw2SPagU3NO+
 JpM0wSq4JQO94y7Z7sM+iMFS4G/gW57nILpHI79POq5Rdasj7B+Btfr9piNvoONOtT9FOgBvWah
 5AZeGynOUvG+gf4YHvkxu49s/LN8O2Esm1DD8CLFEnw0rI/AimlpsmmfSJ+PfdaKEJaelmemKfJ
 Bd211eaV6N81ebL5pwo6x7/vBfYC1hMejXivzznMj7bXEP5x81jzTpg2GIkhN9gRI31Tsq8DQet
 LsY3uiEV2hnAFnlx/RMSA42Un7sxnbRqBAIzSi/ln2fh1oXxf5XyLDvdfvLKw8xz+X0owwQEwfC
 mWbPJVofpTieG3u+LRomaaWHcDfCxiixxpTsgZP4dcS7gFG8mfuuDeHqoFKsqWWLP5AmxO3LfxJ
 rHsWLYJA4dgHII5cDO8NkwWwV1LKdgqpRH866TR+G/ML1tFYOAapvsupAZAySWhZAbgG+yy839R
 foQXbcD9VzJ8WNQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow pinned mutable references to structs that contain a `HrTimer` node to
be scheduled with the `hrtimer` subsystem.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs         |   2 +
 rust/kernel/time/hrtimer/pin_mut.rs | 110 ++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index fee8e44447ee..ab0950a964e8 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -433,3 +433,5 @@ unsafe fn timer_container_of(
 pub use arc::ArcHrTimerHandle;
 mod pin;
 pub use pin::PinHrTimerHandle;
+mod pin_mut;
+pub use pin_mut::PinMutHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
new file mode 100644
index 000000000000..007f47d26df6
--- /dev/null
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::{
+    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, RawHrTimerCallback, UnsafeHrTimerPointer,
+};
+use crate::time::Ktime;
+use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
+
+/// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the timer might
+/// be running.
+pub struct PinMutHrTimerHandle<'a, T>
+where
+    T: HasHrTimer<T>,
+{
+    pub(crate) inner: NonNull<T>,
+    _p: PhantomData<&'a T>,
+}
+
+// SAFETY: We cancel the timer when the handle is dropped. The implementation of
+// the `cancel` method will block if the timer handler is running.
+unsafe impl<'a, T> HrTimerHandle for PinMutHrTimerHandle<'a, T>
+where
+    T: HasHrTimer<T>,
+{
+    fn cancel(&mut self) -> bool {
+        let self_ptr = self.inner.as_ptr();
+
+        // SAFETY: As we got `self_ptr` from a reference above, it must point to
+        // a valid `T`.
+        let timer_ptr = unsafe { <T as HasHrTimer<T>>::raw_get_timer(self_ptr) };
+
+        // SAFETY: As `timer_ptr` is derived from a reference, it must point to
+        // a valid and initialized `HrTimer`.
+        unsafe { HrTimer::<T>::raw_cancel(timer_ptr) }
+    }
+}
+
+impl<'a, T> Drop for PinMutHrTimerHandle<'a, T>
+where
+    T: HasHrTimer<T>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+// SAFETY: We capture the lifetime of `Self` when we create a
+// `PinMutHrTimerHandle`, so `Self` will outlive the handle.
+unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a mut T>
+where
+    T: Send + Sync,
+    T: HasHrTimer<T>,
+    T: HrTimerCallback<Pointer<'a> = Self>,
+{
+    type TimerHandle = PinMutHrTimerHandle<'a, T>;
+
+    unsafe fn start(mut self, expires: Ktime) -> Self::TimerHandle {
+        // SAFETY:
+        // - We promise not to move out of `self`. We only pass `self`
+        //   back to the caller as a `Pin<&mut self>`.
+        // - The return value of `get_unchecked_mut` is guaranteed not to be null.
+        let self_ptr = unsafe { NonNull::new_unchecked(self.as_mut().get_unchecked_mut()) };
+
+        // SAFETY:
+        //  - As we derive `self_ptr` from a reference above, it must point to a
+        //    valid `T`.
+        //  - We keep `self` alive by wrapping it in a handle below.
+        unsafe { T::start(self_ptr.as_ptr(), expires) };
+
+        PinMutHrTimerHandle {
+            inner: self_ptr,
+            _p: PhantomData,
+        }
+    }
+}
+
+impl<'a, T> RawHrTimerCallback for Pin<&'a mut T>
+where
+    T: HasHrTimer<T>,
+    T: HrTimerCallback<Pointer<'a> = Self>,
+{
+    type CallbackTarget<'b> = Self;
+
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `HrTimer` is `repr(C)`
+        let timer_ptr = ptr as *mut HrTimer<T>;
+
+        // SAFETY: By the safety requirement of this function, `timer_ptr`
+        // points to a `HrTimer<T>` contained in an `T`.
+        let receiver_ptr = unsafe { T::timer_container_of(timer_ptr) };
+
+        // SAFETY:
+        //  - By the safety requirement of this function, `timer_ptr`
+        //    points to a `HrTimer<T>` contained in an `T`.
+        //  - As per he safety requirements of the trait `HrTimerHandle`, the
+        //    `PinMutHrTimerHandle` associated with this timer is guaranteed to
+        //    be alive until this method returns. As the handle borrows from
+        //    `T`, `T` is also guaranteed to be alive for the duration of this
+        //    function.
+        //  - Because `PinMutTimerHandle` borrows mutably from `T`, the
+        //    reference we create here is guaranteed to be unique.
+        let receiver_ref = unsafe { &mut *receiver_ptr };
+
+        // SAFETY: `receiver_ref` only exists as pinned, so it is safe to pin it
+        // here.
+        let receiver_pin = unsafe { Pin::new_unchecked(receiver_ref) };
+
+        T::run(receiver_pin).into_c()
+    }
+}

-- 
2.47.0



