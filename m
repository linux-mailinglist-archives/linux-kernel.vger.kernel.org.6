Return-Path: <linux-kernel+bounces-519523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BD7A39D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A07C7A59E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA81D26A0AF;
	Tue, 18 Feb 2025 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBGtdo4L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19826FA44;
	Tue, 18 Feb 2025 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885343; cv=none; b=Na4xh2UIMAY9hAdDHT6m5bjCDW6FNIY0gUwyLB19I3hWOG142wONxu+cWsbQBxNsSSXHgOz8q1DvUr7xS/gi67G2XA/OHtFPvO2mAu8UiFHE/y4rQyw3mruVSQqormo5+UXy8q3ZYKi0vJTdDfLDq4M0zlXjro6nfxfYm4MbICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885343; c=relaxed/simple;
	bh=GdL8CTL8TdtXCZlxISGaGmp4Wk2SYeeszwVWXNJKMCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=USxJjWG5UO+t7dPmYqBwRAldAUeEcHl1QpPQkYNI9i4gu+ZAuzyelSrE71jdGu16chP+Gnr9XOuddOZXdrOGPeL82FShWFhTEVc0LDOEC9BTtoY5RVdBYUXyw4EfAanvTy+Z4g/S6YCLk3m8caUvrmjBuThxmUOhAAWTyj3hayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBGtdo4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371DBC4CEE2;
	Tue, 18 Feb 2025 13:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885342;
	bh=GdL8CTL8TdtXCZlxISGaGmp4Wk2SYeeszwVWXNJKMCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NBGtdo4LnLQq/f5/qh3Pisu7RsVglvKrl0UQeCVXQto4yWEXVQT4PVR9U4GThf8Hn
	 QjHs0+Rs5/vTKfoidw27wuG7G/ays2tIKrHK0rfVquWKTzJu1SB73apJJa7vogqG9z
	 hMrutUQSFdJcOABRZGnOZUqqQ0iJIECZip4G1zAvynje+evWN/7eX7LqpAdwVq5/62
	 Pn/cybxMkwvDKys5x9F/Gxv77ECYMA9c+7WRvQp9s96yqk7EWEjPWanVfmXYCWRXbB
	 +cJMPCmK8KRJL24OmCZFT449MoNY1NQ6wjA0nVx9WGb1GUv6/Xnu196D9O6WVNrCH0
	 5Tks3+WZInX5A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:16 +0100
Subject: [PATCH v8 11/14] rust: hrtimer: implement `HrTimerPointer` for
 `Pin<Box<T>>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-11-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
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
 Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4469; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=GdL8CTL8TdtXCZlxISGaGmp4Wk2SYeeszwVWXNJKMCI=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIq57brDPBamIbPGr9m9UZYAMYq8jcTUB2P7p
 ZwgpnnwgT+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKuQAKCRDhuBo+eShj
 d7n2D/0UTT7fHs5f6dRnOmrTmqt4R68Fao3gkxme+cq42UDz28lCvMldQZgK/J/O4CpxwSK5jQw
 8Gh7ElavclkqzOhPQ+efUs/ap19rEG10cJ+OaZADxOeJt3P8gzES24Cc57xs0gewy8/x60VvLP7
 fjQdqxVlDP31Xvkq2OQLo5CEHzdgSxwhTF83oDL0p6AIZqT7QY5a3SNaWq0EgTmYe+MmphE+wSh
 4kmP0AE7tZymz6h3YfAJqPhTKSI7sTnIOknDVrbNu20GZxhoIeu8QZHFCZnvUTU2fxyO6dg093H
 4Wor0t2jaCwVh4iwmgI/dL8bx5EajEnNT4R/l2k3EQNFDiTrJwM52OHj5uaEvNt8ns9YrYt8jHM
 DZ0G5dZJbnMlJ1ST89nDvbggFyvyK3pLEmh+3KCRCaNfUll01CDcvvZsCMDVRjdLi/BqRx97LT5
 0cOVwqsx5zdjw7qMgjvlzt47XcsniNB6Q5KpgHM8hpWSpfOfavh/2EBftc8bGdFbt1oXqscGtKK
 7eopjhWU57pyhxU+TQSI60/IxqfyT6458+EAflhh0gw3JAFh2bHk4oPi8E3a67mIFewE3oyvG1L
 JC4RH+ZfETLcBNddhBni7GNYNEIqrDs+vhCuvk+3Dg8qGKmUg3VPy/4tplkwutrysQTRy1qQXrZ
 FO7hmnNNX4/6tNg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow `Pin<Box<T>>` to be the target of a timer callback.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs      |   3 ++
 rust/kernel/time/hrtimer/tbox.rs | 102 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index f36513cba4351..de9edf52ebb07 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -406,3 +406,6 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 pub use pin::PinHrTimerHandle;
 mod pin_mut;
 pub use pin_mut::PinMutHrTimerHandle;
+// `box` is a reserved keyword, so prefix with `t` for timer
+mod tbox;
+pub use tbox::BoxHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
new file mode 100644
index 0000000000000..39db96de023a8
--- /dev/null
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::HasHrTimer;
+use super::HrTimer;
+use super::HrTimerCallback;
+use super::HrTimerHandle;
+use super::HrTimerPointer;
+use super::RawHrTimerCallback;
+use crate::prelude::*;
+use crate::time::Ktime;
+use core::mem::ManuallyDrop;
+
+/// A handle for a [`Box<HasHrTimer<T>>`] returned by a call to
+/// [`HrTimerPointer::start`].
+pub struct BoxHrTimerHandle<T, A>
+where
+    T: HasHrTimer<T>,
+    A: crate::alloc::Allocator,
+{
+    pub(crate) inner: *mut T,
+    _p: core::marker::PhantomData<A>,
+}
+
+// SAFETY: We implement drop below, and we cancel the timer in the drop
+// implementation.
+unsafe impl<T, A> HrTimerHandle for BoxHrTimerHandle<T, A>
+where
+    T: HasHrTimer<T>,
+    A: crate::alloc::Allocator,
+{
+    fn cancel(&mut self) -> bool {
+        // SAFETY: As we obtained `self.inner` from a valid reference when we
+        // created `self`, it must point to a valid `T`.
+        let timer_ptr = unsafe { <T as HasHrTimer<T>>::raw_get_timer(self.inner) };
+
+        // SAFETY: As `timer_ptr` points into `T` and `T` is valid, `timer_ptr`
+        // must point to a valid `HrTimer` instance.
+        unsafe { HrTimer::<T>::raw_cancel(timer_ptr) }
+    }
+}
+
+impl<T, A> Drop for BoxHrTimerHandle<T, A>
+where
+    T: HasHrTimer<T>,
+    A: crate::alloc::Allocator,
+{
+    fn drop(&mut self) {
+        self.cancel();
+        // SAFETY: `self.inner` came from a `Box::into_raw` call
+        drop(unsafe { Box::<T, A>::from_raw(self.inner) })
+    }
+}
+
+impl<T, A> HrTimerPointer for Pin<Box<T, A>>
+where
+    T: Send + Sync,
+    T: HasHrTimer<T>,
+    T: for<'a> HrTimerCallback<CallbackTarget<'a> = Pin<Box<T, A>>>,
+    T: for<'a> HrTimerCallback<CallbackTargetParameter<'a> = Pin<&'a T>>,
+    A: crate::alloc::Allocator,
+{
+    type TimerHandle = BoxHrTimerHandle<T, A>;
+
+    fn start(self, expires: Ktime) -> Self::TimerHandle {
+        let self_ptr: *const T = <Self as core::ops::Deref>::deref(&self);
+
+        // SAFETY: Since we generate the pointer passed to `start` from a valid
+        // reference, it is a valid pointer.
+        unsafe { T::start(self_ptr, expires) };
+
+        // SAFETY: We will not move out of this box during timer callback (we
+        // pass an immutable reference to the callback).
+        let inner = unsafe { Pin::into_inner_unchecked(self) };
+
+        BoxHrTimerHandle {
+            inner: Box::into_raw(inner),
+            _p: core::marker::PhantomData,
+        }
+    }
+}
+
+impl<T, A> RawHrTimerCallback for Pin<Box<T, A>>
+where
+    T: HasHrTimer<T>,
+    T: for<'a> HrTimerCallback<CallbackTarget<'a> = Pin<Box<T, A>>>,
+    T: for<'a> HrTimerCallback<CallbackTargetParameter<'a> = Pin<&'a T>>,
+    A: crate::alloc::Allocator,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `HrTimer` is `repr(C)`
+        let timer_ptr = ptr.cast::<super::HrTimer<T>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // queuing the timer, so it is a `HrTimer<T>` embedded in a `T`.
+        let data_ptr = unsafe { T::timer_container_of(timer_ptr) };
+
+        // SAFETY: We called `Box::into_raw` when we queued the timer.
+        let tbox = ManuallyDrop::new(Box::into_pin(unsafe { Box::<T, A>::from_raw(data_ptr) }));
+
+        T::run(tbox.as_ref()).into()
+    }
+}

-- 
2.47.0



