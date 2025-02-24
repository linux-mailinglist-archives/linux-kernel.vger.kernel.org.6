Return-Path: <linux-kernel+bounces-528982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CB6A41E93
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25EE18891C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BE221931E;
	Mon, 24 Feb 2025 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3Xtwy7w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3D821A424;
	Mon, 24 Feb 2025 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398793; cv=none; b=tLS1+o2cuCBekh91aPE6eewljWt1rrCGrntSwdvISqx9EofamVbwR6lfskhlA1dUG/xotW2LA9t8M4liZG3cbN35MUIm6kFkSYDtmUHWJldYUdvv30rQmrnuQt+3K2h6B7iGTCO2BqwpTLcLVo7ACLIlP68TlurMM9EejJzckIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398793; c=relaxed/simple;
	bh=llc7zOHamY6xKtss+EvtekopfzOfsV9jJqRh+gsSyCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QUhPYhdQu/zBhP7cIt0y3G7LVHQwuzB1rkGVgOPQ+Je2U3AoQVmxMjCJ1hQxJd65psC1oDqIU9tE0WawlWBpArP9TPt035pPm3ma37wAWv2v7mvexBZqvuwls4bmjZt/F6brntLOJGGX9gvWMpl+DvK/8+ujjAqgFwbqYBPG4B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3Xtwy7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F20C4CED6;
	Mon, 24 Feb 2025 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398792;
	bh=llc7zOHamY6xKtss+EvtekopfzOfsV9jJqRh+gsSyCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M3Xtwy7wrQqxTskfUqWJbgbhMpDej0IyCGkEADsvaSClgbwk5tc7bd1geqS9DZglz
	 aWYHilsY8/ZiomRmsA+al1tJK6f9x9ZIQA7Eewm6SWT+BCQinxeLevW/mqeBMnezm4
	 lkK9fCWt+/1CRqQcIUw4HNXfw+xPu2WOlpWy13GUqneLpOA088qP8WXIP0voYBE53W
	 53G4s2/7gcqkkGJdHlfzcpYcFv9jnSv3PS5pCCpfgqmK5IG6/kc56IBp4cCcTPTG51
	 PFc4FlGrSyKK3y3OF82EvntkQ9YBifHJwvseRV/M5Trpk5kqSJDTxTkbutwnjiJVUl
	 HP0CL90d5V9fA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 13:03:44 +0100
Subject: [PATCH v9 10/13] rust: hrtimer: implement `HrTimerPointer` for
 `Pin<Box<T>>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-10-5bd3bf0ce6cc@kernel.org>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4707; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=llc7zOHamY6xKtss+EvtekopfzOfsV9jJqRh+gsSyCc=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAkT3Xg5K0oFkbT0YXJzRRIjym+i0t1snfzB
 fx01Ffgkc6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgJAAKCRDhuBo+eShj
 d5uGD/9iJ3OVwKM9qb66nHejnrfq8VDMUgnvy4LBF7hJFXzEaDHJBwT0XjUBpOgkDT+Z05iHsi/
 uAdv21julj35bz2R4ofmpIZ7W6ThaLBTPMVVHU2hQnBAtfktAXpjTkzWxHi/X29+TlBGFveYxPI
 u1GfPJdN8FzL7639SM3eG/9dGqttcpFEI4oFORaIxfrD3tNLvqQkYe7Dxo0/BIGgnkL+YwY3Sz8
 1rjaJxo8rscCNG8aepg4eyczNg6PDP7do7nBPXElhdJusL2wndvyNAp5LNQ7K315iGcsuajyDw8
 aBkAKNfFqTSPeV8kzL6qe/MWxjwXeGV1M3h049MrJISx1fJCFy89wD5TBOP6ofmlEUa08JYtYkp
 F64349U/2nQhK1sBkv/qXncR7/3DgJQOOYvDFoq5tp40tXshRCGUX5eCaUI3wWsCzPoiFUdqmNd
 vYzC7ze3cXjpfwECqpewg2r9aditzpuzgaQfBC5PpU7H9KZuJQCadKrXYfzWf4rxR+7h6AHb0go
 VBaD7desB+oscbJxkgERCwUD1JvoQBerJNDylBLBIUjoIsmeu6t7zJMPlSW/Uund8snDWSVkF5D
 zT4RxG7TaFkN/YyFCsL5XbzMMb9pr/LKX3JNcCTyVYcfeywrfOOXF8yJtFFQd3d8uZFOoUjtRP3
 8+MShHfydOR7zKQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow `Pin<Box<T>>` to be the target of a timer callback.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs      |   3 ++
 rust/kernel/time/hrtimer/tbox.rs | 109 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 07b19699d4e8..fc4625ac2009 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -432,3 +432,6 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 pub use pin::PinHrTimerHandle;
 mod pin_mut;
 pub use pin_mut::PinMutHrTimerHandle;
+// `box` is a reserved keyword, so prefix with `t` for timer
+mod tbox;
+pub use tbox::BoxHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
new file mode 100644
index 000000000000..a3b2ed849050
--- /dev/null
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -0,0 +1,109 @@
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
+use core::ptr::NonNull;
+
+/// A handle for a [`Box<HasHrTimer<T>>`] returned by a call to
+/// [`HrTimerPointer::start`].
+pub struct BoxHrTimerHandle<T, A>
+where
+    T: HasHrTimer<T>,
+    A: crate::alloc::Allocator,
+{
+    pub(crate) inner: NonNull<T>,
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
+        let timer_ptr = unsafe { <T as HasHrTimer<T>>::raw_get_timer(self.inner.as_ptr()) };
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
+        drop(unsafe { Box::<T, A>::from_raw(self.inner.as_ptr()) })
+    }
+}
+
+impl<T, A> HrTimerPointer for Pin<Box<T, A>>
+where
+    T: 'static,
+    T: Send + Sync,
+    T: HasHrTimer<T>,
+    T: for<'a> HrTimerCallback<Pointer<'a> = Pin<Box<T, A>>>,
+    Pin<Box<T, A>>: for<'a> RawHrTimerCallback<CallbackTarget<'a> = Pin<&'a T>>,
+    A: crate::alloc::Allocator,
+{
+    type TimerHandle = BoxHrTimerHandle<T, A>;
+
+    fn start(self, expires: Ktime) -> Self::TimerHandle {
+        // SAFETY:
+        //  - We will not move out of this box during timer callback (we pass an
+        //    immutable reference to the callback).
+        //  - `Box::into_raw` is guaranteed to return a valid pointer.
+        let inner =
+            unsafe { NonNull::new_unchecked(Box::into_raw(Pin::into_inner_unchecked(self))) };
+
+        // SAFETY:
+        //  - We keep `self` alive by wrapping it in a handle below.
+        //  - Since we generate the pointer passed to `start` from a valid
+        //    reference, it is a valid pointer.
+        unsafe { T::start(inner.as_ptr(), expires) };
+
+        BoxHrTimerHandle {
+            inner,
+            _p: core::marker::PhantomData,
+        }
+    }
+}
+
+impl<T, A> RawHrTimerCallback for Pin<Box<T, A>>
+where
+    T: 'static,
+    T: HasHrTimer<T>,
+    T: for<'a> HrTimerCallback<Pointer<'a> = Pin<Box<T, A>>>,
+    A: crate::alloc::Allocator,
+{
+    type CallbackTarget<'a> = Pin<&'a T>;
+
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
+        T::run(tbox.as_ref()).into_c()
+    }
+}

-- 
2.47.0



