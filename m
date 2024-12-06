Return-Path: <linux-kernel+bounces-435530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB89E790A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9FB160EF1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7181C21518C;
	Fri,  6 Dec 2024 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBZYNLno"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EC11DE2D8;
	Fri,  6 Dec 2024 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513736; cv=none; b=rsFoWkk9x9kkbYTPcdjt0x+1IJaAlqrSBk3PplDYaJrTK3H09A37v+3uSoDGffGhMhNqbhXUy+1OWr7A+0Ah2DQ+CM6n7aTngyMBsH3dCTuDr4inHAKk9KVLP5Vapoap9HajP4XK3pyXkOWQcvLugjceqqdKbg04iTMosp9RDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513736; c=relaxed/simple;
	bh=nCt+rC7hD4TBOexROjY8cgHhOsOh0+xYX8SSIYt9Euw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z36XG64mNpUX71Q/+hNn4kb4B4pPKbSgfqBajEMbwlB45vT7tEAOJ2OCFzct7cPFjwk4thGLigUFQJ8YcmMKq5SaXt5I0YptQHN/R0XVncP32WoBweJ/bESqmCyta+K/82J+5DmzuhZ2vTB+bhH/57uAVWbfIURlpxLnm+cf04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBZYNLno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE579C4CED1;
	Fri,  6 Dec 2024 19:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513736;
	bh=nCt+rC7hD4TBOexROjY8cgHhOsOh0+xYX8SSIYt9Euw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EBZYNLnoRMWC0ibZQKd2ibhtFGCchpftRO1kE2VxNXdFEiVnTSbpwe0OSHoRh+ZyC
	 HzbNLRLvx3urFyMz9mLVhX1ecCQqWChvcXRmu80kKSa6EBwhY6cZ86d4v0iff0RnSH
	 yip7VhxLQrUnzhDs/MAkkEoGM30fRQ29iq3BXHsi18mAnmWcHVuNSgmvn6+m+yLeV+
	 KliJkHyPmjqPosd/kUyWMOx0z0No+dxXXGpyBkzkwFPXq2INwR3i71BKeiGd1D9lNr
	 orC/AhrPbWc6Y/vHxcPREbAumbuawyEUgK/aOqRlfVVZPbvM1wTffkxwT94KeNFHrr
	 1kWkCeLpfsaaQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:33:03 +0100
Subject: [PATCH v4 11/14] rust: hrtimer: implement `TimerPointer` for
 `Pin<Box<T>>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-11-6cb8c3673682@kernel.org>
References: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
In-Reply-To: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4446; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=nCt+rC7hD4TBOexROjY8cgHhOsOh0+xYX8SSIYt9Euw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgprQTBEQUFvQjRiZ2FQbmtvWTNjQnl5WmlBR
 2RUVVhMSXVBV1lVczBEdmZRdnc4TDZJLzlmQWh6YUFWdmhVWTJTClNnUk5kUjBHdllrQ013UUFB
 UW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjNCUUpuVTFGeUFBb0oKRU9HNEdqNTV
 LR04zSXVFUC8zTC90NUsvQllJcDR2eExYSmhCNjRJSFhiN1pwTmV1NlhveXUvYTY1WURoNDNjWA
 pMWUZGbEk2eUxacmpmOHVOb0JKNzBMajJJcU5RczgrT3N3SU0xblRQZTVObjRNU2VOSjJkM1NXb
 zVsd0lyQTRHCmtieHVWYVBObHFnaHBhN3BsMzlzVU1YcU93dDlNamNIT3lJR0RJMDZ1OVRKUFRU
 Ny81cnZra2JIYWxPUThsZzkKQlduTXliM0NyZit5VmVhc3ZsQk1oeTc2SnBZRjRhTG9OVEdjRmw
 0Vzc1SHRqL29pdUNyUFNzMlpVYkM2Ym84Zwo2VVRVZ0hHWHIwdjA5ZHd2VHlQaS9PU0hZMzFZZk
 hGaDR0V0taWVl5LzBVUzhocVhUNWVuK2lYZW1VM1RWbmd3ClFrN2JxT1dxSkJVc1k2c0lDRENUU
 3creVNsbjJCWVYvY3NzRjNveXBzdGlRZ2tTRUxndXc0Qy9Jc0pEWGhtS3EKQ0lvWGwzK0tOK08w
 amRLYmZnWHk5TWpWbjNUWFVMVzBaY2JWcTdKeis3MnFuUENTd25lMWZHMS9kODROWGVQaQp2V0x
 NNWM4VzNDWlRjWDBlWjhwS3UvV1MreDVZc3J4bWR3bXF1RlhUV2svQ0U5UlNLMlZYUmtNNldnZU
 duSDlBCm5uMEhETm9tRkFWNjZ3V2RrdHlZVE8vamgzcHhMWHA0YTd3TzNUYUlkbGM5aWxkbzZWV
 WtIVjlGVkQ3QnpOUXMKaFErOW5tM2JaRjZwZ1ltMUdvam5KMzdmQldta28vaTd4dHFVUEt0a29S
 MDl3TjhDcENlT1A3b2w2THFxbS80cgpqeU9YcFZKWjlpbE8xVWoxazJYMTNyV0E1d25jN1RodDU
 zUTE0VHppYXZkOFpwWmVVUmRZOC9LbFZicDcKPU91dDIKLS0tLS1FTkQgUEdQIE1FU1NBR0UtLS
 0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow `Pin<Box<T>>` to be the target of a timer callback.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs      |   3 ++
 rust/kernel/time/hrtimer/tbox.rs | 102 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 7835a33677ec32999c495d5b874ded2ff0786c9e..976a7350d6bee0cebe3dcca04ccbe48fef31e430 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -395,6 +395,9 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
     }
 }
 
+// `box` is a reserved keyword, so prefix with `t` for timer
+mod tbox;
+
 mod arc;
 mod pin;
 mod pin_mut;
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
new file mode 100644
index 0000000000000000000000000000000000000000..4b932a20cf6fcacdff7c40fc280f8d73a45addc0
--- /dev/null
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::HasTimer;
+use super::RawTimerCallback;
+use super::Timer;
+use super::TimerCallback;
+use super::TimerHandle;
+use super::TimerPointer;
+use crate::prelude::*;
+use crate::time::Ktime;
+use core::mem::ManuallyDrop;
+
+/// A handle for a `Box<HasTimer<U>>` returned by a call to
+/// [`TimerPointer::start`].
+pub struct BoxTimerHandle<U, A>
+where
+    U: HasTimer<U>,
+    A: crate::alloc::Allocator,
+{
+    pub(crate) inner: *mut U,
+    _p: core::marker::PhantomData<A>,
+}
+
+// SAFETY: We implement drop below, and we cancel the timer in the drop
+// implementation.
+unsafe impl<U, A> TimerHandle for BoxTimerHandle<U, A>
+where
+    U: HasTimer<U>,
+    A: crate::alloc::Allocator,
+{
+    fn cancel(&mut self) -> bool {
+        // SAFETY: As we obtained `self.inner` from a valid reference when we
+        // created `self`, it must point to a valid `U`.
+        let timer_ptr = unsafe { <U as HasTimer<U>>::raw_get_timer(self.inner) };
+
+        // SAFETY: As `timer_ptr` points into `U` and `U` is valid, `timer_ptr`
+        // must point to a valid `Timer` instance.
+        unsafe { Timer::<U>::raw_cancel(timer_ptr) }
+    }
+}
+
+impl<U, A> Drop for BoxTimerHandle<U, A>
+where
+    U: HasTimer<U>,
+    A: crate::alloc::Allocator,
+{
+    fn drop(&mut self) {
+        self.cancel();
+        // SAFETY: `self.inner` came from a `Box::into_raw` call
+        drop(unsafe { Box::<U, A>::from_raw(self.inner) })
+    }
+}
+
+impl<U, A> TimerPointer for Pin<Box<U, A>>
+where
+    U: Send + Sync,
+    U: HasTimer<U>,
+    U: for<'a> TimerCallback<CallbackTarget<'a> = Pin<Box<U, A>>>,
+    U: for<'a> TimerCallback<CallbackTargetParameter<'a> = Pin<&'a U>>,
+    A: crate::alloc::Allocator,
+{
+    type TimerHandle = BoxTimerHandle<U, A>;
+
+    fn start(self, expires: Ktime) -> Self::TimerHandle {
+        let self_ptr: *const U = <Self as core::ops::Deref>::deref(&self);
+
+        // SAFETY: Since we generate the pointer passed to `start` from a valid
+        // reference, it is a valid pointer.
+        unsafe { U::start(self_ptr, expires) };
+
+        // SAFETY: We will not move out of this box during timer callback (we
+        // pass an immutable reference to the callback).
+        let inner = unsafe { Pin::into_inner_unchecked(self) };
+
+        BoxTimerHandle {
+            inner: Box::into_raw(inner),
+            _p: core::marker::PhantomData,
+        }
+    }
+}
+
+impl<U, A> RawTimerCallback for Pin<Box<U, A>>
+where
+    U: HasTimer<U>,
+    U: for<'a> TimerCallback<CallbackTarget<'a> = Pin<Box<U, A>>>,
+    U: for<'a> TimerCallback<CallbackTargetParameter<'a> = Pin<&'a U>>,
+    A: crate::alloc::Allocator,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `Timer` is `repr(C)`
+        let timer_ptr = ptr.cast::<super::Timer<U>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // queuing the timer, so it is a `Timer<T>` embedded in a `T`.
+        let data_ptr = unsafe { U::timer_container_of(timer_ptr) };
+
+        // SAFETY: We called `Box::into_raw` when we queued the timer.
+        let tbox = ManuallyDrop::new(Box::into_pin(unsafe { Box::<U, A>::from_raw(data_ptr) }));
+
+        U::run(tbox.as_ref()).into()
+    }
+}

-- 
2.46.0



