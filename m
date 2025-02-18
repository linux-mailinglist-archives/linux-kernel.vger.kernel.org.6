Return-Path: <linux-kernel+bounces-519514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4DFA39DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C4A161813
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3AE26D5DF;
	Tue, 18 Feb 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0xcoQ1d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F62698BE;
	Tue, 18 Feb 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885313; cv=none; b=ss1ZdRpi/e86BKqLC/Om3Eik+fTXK2iZxEV+vGsLGDOGvEb3q6ndaprZiz4faIvjari7MyF4Jpn5HzYx7KNKTRiy6AD3SXt6rrOUbVcICmroPMCVM35oh1uZbEiGO7LjaJjQN3AnzdJ7443SUF2qh1OV2mHT6VGdBoulv/Yirf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885313; c=relaxed/simple;
	bh=tCj5oG07VVNWC3t2NiX5T+MQC44KNGSqCWE3dxpeY4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ta7AXerytKBUto+RTdHdny5ziNWGZFaMgerRYUfgAkosiHtpy8zyawEqXGrhaKuZ6m74bgBznmY0DRC10alzyyil6+wcpuB2zCWr7TXVqhDo/L2wAIKXcFDKg2XaOpCU9Oad9PtHHope/NbDmJrOlbjsUK2fbGBm74irMru9ovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0xcoQ1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48031C4CEE2;
	Tue, 18 Feb 2025 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885312;
	bh=tCj5oG07VVNWC3t2NiX5T+MQC44KNGSqCWE3dxpeY4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q0xcoQ1dyAfrpjApojfVmkK5S5A4+tCyTHLRxycYKrX9UzsYd9C+U7PIpua2iN/WS
	 raxxW2bIn8ge4TnQbbmP59rQbb4zBgk69ySVBy88YK5j66TaYZdZUs7bHhKfjSkem2
	 QhaIOCBVDzsxWj+IiZw6NzPOtsl/pPz3v0A69y7QEEUAY4RVq54dzJV2M1+VACs/+L
	 Q6cGerWY4kWTcIlb2dj8jr9tVW40yv1VkQadxdRkBp9N6USlaCWDiTGIAcLMczREty
	 nVmoFAjyKKDJpskLD17owkxkB2r24U6dn1uNjJtVjGHgKYFqDQ0tHUDADG61aH95pk
	 RHJ/vfIjO6Iag==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:14 +0100
Subject: [PATCH v8 09/14] rust: hrtimer: implement `UnsafeHrTimerPointer`
 for `Pin<&mut T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-9-48dedb015eb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4284; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=tCj5oG07VVNWC3t2NiX5T+MQC44KNGSqCWE3dxpeY4w=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIq3JhXcbaxidghDp23kfXOfb2Q44iEwGK6lz
 KZ+CjxxyNOJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKtwAKCRDhuBo+eShj
 d5OFD/96oSJfnFjuj02Wr2gQxx8vg/OGGWz2rENPs6al9YhetgWGvc5H4n0xUqy7YPHBVSkDpOR
 6CBkqtRkDuemUI8aim0qdVOZenEShHgqHafVrjAh2K5cms0zAVuUbi5MIMI/iYuePUpZTX0+Ua0
 PRLuvVQXK9xS1ugQCz28kAm9Z3MWteGgYdPr2nZ2igp7pyRHDRnYTASErGTAeLEDvp8jIKBJMgB
 /mv0bRMiuo/gtUymvXwPW6MEAu27BViZuOrBjauZ2PD6jnUAhg8dNl6Rb242WgDPoYhRzjdJH0+
 GAFZB3TMiA+5u25w5vUY4dJV738grgHzU2eVY4a6elc7hOr66QgutuiYgqYn/ND1vzcB5q5n9dW
 OO7JAsEsg2iRlE9H8XfzBqtEl3bgnlpi3eqEH/U7M1CSUaDlOW1wwYViLaGIkCljHSPogca/kU7
 DBqS1YTaemhxeXKUI65kPsHZV/DxDBUqV7r4Nsz14ksFaIJ3CnmUUwMaYhpJdZtuVsUo8y99qAC
 5RnUZ643MV9Zx72Iiai5v5KmIHnLu5vPfvTSa/8FPpMS5IvRdFRKz8QWH/3wNh06rD3S1I3cFUY
 RjsMHw8Fa2kQU2JZgIVZZRkCtwaDFhUb0iFY9oFvIoJaozToO+mo1/B88Rr3O7q40SA8wB7Bk4e
 /FDUss1rlH2HsTw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow pinned mutable references to structs that contain a `HrTimer` node to
be scheduled with the `hrtimer` subsystem.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs         |  2 +
 rust/kernel/time/hrtimer/pin_mut.rs | 97 +++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 3228ed916b4fe..f36513cba4351 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -404,3 +404,5 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 pub use arc::ArcHrTimerHandle;
 mod pin;
 pub use pin::PinHrTimerHandle;
+mod pin_mut;
+pub use pin_mut::PinMutHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
new file mode 100644
index 0000000000000..153e89b86caf2
--- /dev/null
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -0,0 +1,97 @@
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
+/// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the timer might
+/// be running.
+pub struct PinMutHrTimerHandle<'a, T>
+where
+    T: HasHrTimer<T>,
+{
+    pub(crate) inner: Pin<&'a mut T>,
+}
+
+// SAFETY: We cancel the timer when the handle is dropped. The implementation of
+// the `cancel` method will block if the timer handler is running.
+unsafe impl<'a, T> HrTimerHandle for PinMutHrTimerHandle<'a, T>
+where
+    T: HasHrTimer<T>,
+{
+    fn cancel(&mut self) -> bool {
+        // SAFETY: We are not moving out of `self` or handing out mutable
+        // references to `self`.
+        let self_ptr = unsafe { self.inner.as_mut().get_unchecked_mut() as *mut T };
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
+    T: HrTimerCallback<CallbackTarget<'a> = Self>,
+{
+    type TimerHandle = PinMutHrTimerHandle<'a, T>;
+
+    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle {
+        // Cast to pointer
+        let self_ptr: *const T = <Self as core::ops::Deref>::deref(&self);
+
+        // SAFETY: As we derive `self_ptr` from a reference above, it must point
+        // to a valid `T`.
+        unsafe { T::start(self_ptr, expires) };
+
+        PinMutHrTimerHandle { inner: self }
+    }
+}
+
+impl<'a, T> RawHrTimerCallback for Pin<&'a mut T>
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
+        let receiver_ref = unsafe { &mut *receiver_ptr };
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



