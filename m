Return-Path: <linux-kernel+bounces-519521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A25EFA39D98
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BA0C7A57A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6918C26F470;
	Tue, 18 Feb 2025 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj3RfYk3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AB26A08A;
	Tue, 18 Feb 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885337; cv=none; b=qyDSmNBvvCUnAW4YHSRd1XR2Y2PI2KPq9wsUQn6jUsLZ6GY3aS49bHKk/p0mQ0Dfmnrs5vmmW/8XG18nDKFCOXbDFcX00WzYJngJ6tztCjEuNhZtQGsRWTC1zkIFxun1aSg+MvTsFLwV2BzI+Rv050xYDHCE1roTTYKZNamMpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885337; c=relaxed/simple;
	bh=dsJMGL8Vy5ZK8N2dXrkHVY1AwzDKsAsYWk8CdjvAtOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ckKVZkUjMMHqUj1AA2zdxWUWelP2476ZLmkwGc1h4/fjtjk2Ns6QG1Zmc04xWu6xGkmlC2wd/EAv25rxra25JMdA6yikqjG2+DqNe14LeebhC4zQvZkTGStHV7OQrvYWwyCFL3JKnYSFyhuRVuUL/pXIap+IidViVXswRhCr51E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj3RfYk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFE7C4CEE2;
	Tue, 18 Feb 2025 13:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885337;
	bh=dsJMGL8Vy5ZK8N2dXrkHVY1AwzDKsAsYWk8CdjvAtOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lj3RfYk36xYBq2iN6O13H0x1mXEbGhBjIL0s72A7LUUw0TfaEvmHXr7OTeBU/wgjw
	 yIDzdkld5GXeFG5km4+MVBRKQaZ04ZWJToxm3bzJGvsIbpFl9HAwtCuewaeofF+eNw
	 hKvqPiWM2tqLc+qNIPEW+xmpW2a+Ci/SGqXT74ApFbsvDADAhTgVxF+nVXnN4EnMk+
	 mcPHJFiQGKsP4kHqvFNOoI+LAf3fTLN3PIiqNclhpZtjnckuEZ3pRbaKKJrhfJdpPq
	 d+q+qE6Bi6mnx/kLN3ltuJZ2pOkSI0ijzAk9DkvKrsUniHhwYaQBujTdluKkOj0+C8
	 nTT485Y3KuPZg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:13 +0100
Subject: [PATCH v8 08/14] rust: hrtimer: implement `UnsafeHrTimerPointer`
 for `Pin<&T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-8-48dedb015eb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4040; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=dsJMGL8Vy5ZK8N2dXrkHVY1AwzDKsAsYWk8CdjvAtOU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIq2B+VeCZle6Hpm68NBzkhYeYXvs9yGkVwyx
 QFd6y0xY3WJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKtgAKCRDhuBo+eShj
 d21vD/kB8mENb+jhiLrI06aJfIMC0nN/65vxIyMtor8H/LwuUdhNlRyrIjAThff3Z2NHffsnlon
 hlINGL3pGS8Hr1chIOfaeEBE25pc2EAgdpuJ+qJ3C1E4izU2ZpeEB/TO1N8wF0/9mnCKqLUG+yB
 Wyiemcslwspsgb/4ZJ5u2BIpmmS8+sf04pnFvSAS/JJBAYsIBeOfNiN888ctwbl7SqczX+IWc6x
 gn31a/bm0kowBDE18g4U+AeHyNvtKHQevDhzRwXh5/mS6B5F/n8hE0tKYNqrGTkwYWMm0XWpAns
 ht17qdtOmct0jGAOjNduen5OQV/gR+JYpHksGQkihFxcdsdJt1hUtpJoLJiDZIBQPiarNhjhYCv
 Lq5iNgy8grhUUrpyt6Wpft14R9Mc9J7GBTuVYN9LjIOsJASxQYNgnUaGQCll2ytsZLTE/NvooKm
 KbN7nfPiOJUcd/zGwCV5Z1VW1XknWOJjAt9h8p1Flpdioz93git8L+lMC6oOJisGXMrcpPO43/A
 26XmTMQ5lKiQpisJgauCtYHuzyk6zYnsIe4XgZbjNRcBBYct1LoQBn6SoHDp/5WCkZ1j6HGP19E
 M5aVj3BvMz66LgzDUO+jCH3QvxwDC09/fjJT3wHWmMFq1zu7pW0k7GRB3YF16e6CwuL8LNfBPXx
 0GDg7LGA9iyR2nQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow pinned references to structs that contain a `HrTimer` node to be
scheduled with the `hrtimer` subsystem.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     |  2 +
 rust/kernel/time/hrtimer/pin.rs | 95 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 666bcd6e46a11..3228ed916b4fe 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -402,3 +402,5 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 
 mod arc;
 pub use arc::ArcHrTimerHandle;
+mod pin;
+pub use pin::PinHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
new file mode 100644
index 0000000000000..ecab39118662e
--- /dev/null
+++ b/rust/kernel/time/hrtimer/pin.rs
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::HasHrTimer;
+use super::HrTimer;
+use super::HrTimerCallback;
+use super::HrTimerHandle;
+use super::RawHrTimerCallback;
+use super::UnsafeHrTimerPointer;
+use crate::time::Ktime;
+use core::pin::Pin;
+
+/// A handle for a `Pin<&HasHrTimer>`. When the handle exists, the timer might be
+/// running.
+pub struct PinHrTimerHandle<'a, T>
+where
+    T: HasHrTimer<T>,
+{
+    pub(crate) inner: Pin<&'a T>,
+}
+
+// SAFETY: We cancel the timer when the handle is dropped. The implementation of
+// the `cancel` method will block if the timer handler is running.
+unsafe impl<'a, T> HrTimerHandle for PinHrTimerHandle<'a, T>
+where
+    T: HasHrTimer<T>,
+{
+    fn cancel(&mut self) -> bool {
+        let self_ptr: *const T = self.inner.get_ref();
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
+impl<'a, T> Drop for PinHrTimerHandle<'a, T>
+where
+    T: HasHrTimer<T>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+// SAFETY: We capture the lifetime of `Self` when we create a `PinHrTimerHandle`,
+// so `Self` will outlive the handle.
+unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a T>
+where
+    T: Send + Sync,
+    T: HasHrTimer<T>,
+    T: HrTimerCallback<CallbackTarget<'a> = Self>,
+{
+    type TimerHandle = PinHrTimerHandle<'a, T>;
+
+    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle {
+        // Cast to pointer
+        let self_ptr: *const T = <Self as core::ops::Deref>::deref(&self);
+
+        // SAFETY: As we derive `self_ptr` from a reference above, it must point
+        // to a valid `T`.
+        unsafe { T::start(self_ptr, expires) };
+
+        PinHrTimerHandle { inner: self }
+    }
+}
+
+impl<'a, T> RawHrTimerCallback for Pin<&'a T>
+where
+    T: HasHrTimer<T>,
+    T: HrTimerCallback<CallbackTarget<'a> = Self>,
+    T: HrTimerCallback<CallbackTargetParameter<'a> = Self>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `HrTimer` is `repr(C)`
+        let timer_ptr = ptr as *mut HrTimer<T>;
+
+        // SAFETY: By the safety requirement of this function, `timer_ptr`
+        // points to a `HrTimer<T>` contained in an `T`.
+        let receiver_ptr = unsafe { T::timer_container_of(timer_ptr) };
+
+        // SAFETY: By the safety requirement of this function, `timer_ptr`
+        // points to a `HrTimer<T>` contained in an `T`.
+        let receiver_ref = unsafe { &*receiver_ptr };
+
+        // SAFETY: `receiver_ref` only exists as pinned, so it is safe to pin it
+        // here.
+        let receiver_pin = unsafe { Pin::new_unchecked(receiver_ref) };
+
+        T::run(receiver_pin).into()
+    }
+}

-- 
2.47.0



