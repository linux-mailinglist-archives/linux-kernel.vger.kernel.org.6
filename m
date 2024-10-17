Return-Path: <linux-kernel+bounces-369816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B89A2326
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265831F23663
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7746B1DE2C1;
	Thu, 17 Oct 2024 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyMl5eer"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B641DD55F;
	Thu, 17 Oct 2024 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170548; cv=none; b=UmxkulIKEywpFaH3aIEG49k2qB4+SmexxRy72xAm5yCx50FWzOY1CUGfcTMOr7cYZzZfTiRsfsLDyZZXU+7viON9It1BNFMV043Yik6qT8Eyn3OFuB42HCyN0eS8eOse6ID1W3hMEtooDoyDjIsAiQv6Nv4f6v7lRnHBnmM/spY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170548; c=relaxed/simple;
	bh=djeIObyYMSba/ry9C1XpjcUIkMvUsOg5eoyYeIu/FVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWlU3nnxdJMwBOeyxRmkSp0AB3zUH3jg27bKdO1sR9Y/OJpX1ZBTxgaTSWYcy9NjVd3Lmm6hGqCQb6gkJs7mY1E7bl/Mu0UV8Bs7M/0jY+65StruhripFMUNfPZD9LK64AGldkowNmhotoncAIvcI//CapH5F2WSkCV76g5wJbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyMl5eer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45B3C4CED1;
	Thu, 17 Oct 2024 13:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170548;
	bh=djeIObyYMSba/ry9C1XpjcUIkMvUsOg5eoyYeIu/FVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MyMl5eer7cUrJYaPmR8C+qCyZikwe3X7j6fVSgW5dw+Q1lmPRjU9k0NVgukzpYxle
	 7nOMPjGGC07wjcY5+t0qFR/kdnxICQNr76qyGnB5nbhd7xfDW5N+GYzgSVBc5tyJgL
	 bYegPriCSzmdaEFn2zTYkRKZRtM5Roqz3OhhcluH5sYj+SIlLJ95jJ7MvTBhu/vtNM
	 EjYGXiUNJPwP6J1QoBsNJIquZFB86VsWZmsA+0ekVZXlWaU88/9JMQmO9w+03S+8xO
	 D8JO+3OAGUXxUpZFU/+s1sLobfSg+db8FuGmyFvS0g90XwWDETBwG+yTpo2eF7UVdZ
	 uuQ0HA3/av7WQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 17 Oct 2024 15:04:34 +0200
Subject: [PATCH v3 07/13] rust: hrtimer: implement `UnsafeTimerPointer` for
 `Pin<&T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-7-59a75cbb44da@kernel.org>
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

Allow pinned references to structs that contain a `Timer` node to be
scheduled with the `hrtimer` subsystem.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs     |  1 +
 rust/kernel/hrtimer/pin.rs | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index e97d7b8ec63ce6c9ac3fe9522192a28fba78b8ba..ceedf330a803ec2db7ff6c25713ae48e2fd1f4ca 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -362,3 +362,4 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 }
 
 mod arc;
+mod pin;
diff --git a/rust/kernel/hrtimer/pin.rs b/rust/kernel/hrtimer/pin.rs
new file mode 100644
index 0000000000000000000000000000000000000000..a2c1dbd5e48b668cc3dc540c5fd5514f5331d968
--- /dev/null
+++ b/rust/kernel/hrtimer/pin.rs
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
2.46.0



