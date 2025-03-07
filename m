Return-Path: <linux-kernel+bounces-550853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2325BA56503
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105F97A9E6F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237812153EC;
	Fri,  7 Mar 2025 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjXEnJf2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7820E302;
	Fri,  7 Mar 2025 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342708; cv=none; b=SccZ7cnQEr3AzhkqncQzlWglXaf9noxzV3t8lPSFm/JnUVHp0x+xzjkJ+YxcGwouEDP5jvJTbjL7l5xG6yMyvgN6S7O1PktfJu+a8+me/vPm58imrlNEjYL8eBi0NsigeF98zXkqWh+v1LdB4DJUL3bb9qYM4fJKZbMQGq9NmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342708; c=relaxed/simple;
	bh=LTELwMfsbMFHMbYYKpUUvlJRCxNr4i2Kf4bB+CVpqRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVgbQswRqhMrVCpI3cviS4SPKrUXDIFkcy1oEUUFR2/+BPzTfE+ws4lZvVK0xaLUxX9BiyWM7USMsZ7lZ0FkSToUMFM54awv1ofVlBPDEKs80sPyWp7Rf3XHj0khR+upcEzwswp9uXR3T2G1mB+eInA8FMZN7D4qAjdjZ97bGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjXEnJf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C556C4CEE5;
	Fri,  7 Mar 2025 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342708;
	bh=LTELwMfsbMFHMbYYKpUUvlJRCxNr4i2Kf4bB+CVpqRw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SjXEnJf2J+QjUgbwxzjxfJrTSMvQpFknmPiAwADygeCThCrbdkW7tzAdMdpYQenQI
	 Kj4/jZJjAZ3lG4UvXDc7daj6Ja4Pnv0bJwWa4BxH4GBe4L66Jwuk/3LAxVVN1BqNf/
	 /gQYT5+Ux/9Ptv5frUefGp2XLYwGcRtRgpvGiCRvARbjWK8GtsXXwSlx37lDU/CLnT
	 bI0Fg7433uuYRrVXbHi0GA2IBYZ9cotFrzB+9h2xt/U7nNhEiCaQl6X4XBYOmQUTp6
	 UuyZg98/x/PN7IvaqUpFasbcrsHIucd02NY8uA03PyvgQXUPdn4cxoSv94nUq0QuH6
	 RBTjtpbgFso7w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 11:11:55 +0100
Subject: [PATCH v10 10/13] rust: hrtimer: implement `HrTimerPointer` for
 `Pin<Box<T>>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v10-10-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4787; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=LTELwMfsbMFHMbYYKpUUvlJRCxNr4i2Kf4bB+CVpqRw=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnysZ/4zuRLPtMhsy9onq3NpskdfKgcqzjOQHWU
 f6o3FWSbGqJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8rGfwAKCRDhuBo+eShj
 d88qEACkB3oK0EYD+9bDJfIiaDGXxv7997prir0ToBhVteUBp66dtDRKgdJ3zav7krMB+d/l3Ru
 41AE1H66pHHg69MooAT0mNn6VhApu90j8Rbekgcm+Wt7tvl62+Sty3BHnKH74oyhWN7KVv4c+xG
 YqRuz2YRDyt55ImbCNgpyYL6368dMFFXz2K5J7EDPnmzTTKwkcybRoodvNJer3vAO5ux+AADt0y
 jPFnRPw8phuAE3JDJYMXlci4O42hCJty7nGCKtN6jCnKBEzbQTAATDpWynFGWfQmfrYDQxwiu4A
 9/bkeTCuo0IxQR7cQfdWy8k7NOqlvuIYR2wxeWxlQiI+rGFl4KBc8XE8A7iX/w97n31WdLzyhPG
 HGkDtu5klLO3ij7obbNaL8ewNiFc4QdSf+t5ukTy9hM88jabBCW7X77PuSsrfIyGu9oBimNeTpK
 mMCnyFTAoQS6HiMjEldlU7+FNF1AfvsDHYli+o2wMHa2CGp8uAVONJ4rndD5mBF7JDw1VJkZbl/
 p3NR1NlK+Sz8d4Wl0XVm9/MJ5+AMCuckt+skTdjMYfuOGFV0i7P2SEFicHyhamEAYg1eEdtWmS7
 248iwh0nyJ7V4MjqVOGRu10UxnR9HE4+NXen9FrX3msHvtAitAEmQXKTxtEnliPd5x2wHMfx+tV
 kSNu5Doo+QgdL+A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow `Pin<Box<T>>` to be the target of a timer callback.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs      |   3 ++
 rust/kernel/time/hrtimer/tbox.rs | 109 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index d2791fd624b7..991d37b0524a 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -443,3 +443,6 @@ unsafe fn timer_container_of(ptr: *mut $crate::time::hrtimer::HrTimer<$timer_typ
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



