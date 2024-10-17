Return-Path: <linux-kernel+bounces-369828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537319A2333
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C691C28503
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BD51DE2C8;
	Thu, 17 Oct 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivv5H52c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584F1DF73E;
	Thu, 17 Oct 2024 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170596; cv=none; b=KkplE+30ihRlI2KOT2gUfImQUfGrWiqD5OiynF0GTaAz9f+WUoDfkGutCnxF9pzmTong8of9SLL8cUlK/vsnub9EegzSjhpm8rKTKhQ1M1xjWGa/pH03aDlPYTCuNY76cXtWEo98yc4EHqK7u0nsr5GUFo4+NguGa91Zm7AhFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170596; c=relaxed/simple;
	bh=WpykfoidvT7YgqobFCGhM6E4/3XnNpFURLVGB8L0/r4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QxVQ80A7lWj8tMWNOmO3iDKqQ1aNLtYVuyWYaxO0tDMuPBf/pkxgS4L5tl4fdgXKXiBKdPIDn1ozeIk3ONIO/8nI2276Exy+Y1k0WDoHPlqYnJaDqYW6APM+dg7tfIoQUZyRuSX6au89fp2TOlQ7ijDIVV+0XZd96zjaWApl5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivv5H52c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7FDC4CEC3;
	Thu, 17 Oct 2024 13:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170596;
	bh=WpykfoidvT7YgqobFCGhM6E4/3XnNpFURLVGB8L0/r4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ivv5H52clVpqohzUraSFqFMKtx5OdPvKNwPoOyk5lkUnrn3gWYDcoINV1uBSJIW5v
	 d4C9vZx1aUu8MX5dSkzAv7rQBhvnlY0iUrbeWUIXin4eTqVOVnr5FX5yh9F5RUhrkx
	 cNs48OAtrwUJqhqd+cqzawD5cNo5uiYTg+jRuzURLCJyEvI0epdG9U6Uks2Or5bvUl
	 mf9RdnQnhYO0heOyayLNMAfC1ihg5d2+JczTpzHWfro6oINdjqxDHuzsMc3Kf2NiCj
	 Bxx7pT+9h3rBdqhyRU4rpayGU6HK0dHdJwwyiuG89SG3iedBquK7EgbU6e3EydMpz3
	 QEGMHC9HFbWBA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 17 Oct 2024 15:04:37 +0200
Subject: [PATCH v3 10/13] rust: hrtimer: implement `TimerPointer` for
 `Pin<Box<T>>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-10-59a75cbb44da@kernel.org>
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

Allow `Pin<Box<T>>` to be the target of a timer callback.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs      |  3 ++
 rust/kernel/hrtimer/tbox.rs | 95 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index d8cea8b15a9afc134b10dc5703d88d70323fc943..2c1573e19576de93afc959d71e94173e2c1ed715 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -394,6 +394,9 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
     }
 }
 
+// `box` is a reserved keyword, so prefix with `t` for timer
+mod tbox;
+
 mod arc;
 mod pin;
 mod pin_mut;
diff --git a/rust/kernel/hrtimer/tbox.rs b/rust/kernel/hrtimer/tbox.rs
new file mode 100644
index 0000000000000000000000000000000000000000..b4199671d728c7f070b4ffb30a3cbc2635c0cb89
--- /dev/null
+++ b/rust/kernel/hrtimer/tbox.rs
@@ -0,0 +1,95 @@
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
+pub struct BoxTimerHandle<U>
+where
+    U: HasTimer<U>,
+{
+    pub(crate) inner: *mut U,
+}
+
+// SAFETY: We implement drop below, and we cancel the timer in the drop
+// implementation.
+unsafe impl<U> TimerHandle for BoxTimerHandle<U>
+where
+    U: HasTimer<U>,
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
+impl<U> Drop for BoxTimerHandle<U>
+where
+    U: HasTimer<U>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+impl<U> TimerPointer for Pin<Box<U>>
+where
+    U: Send + Sync,
+    U: HasTimer<U>,
+    U: for<'a> TimerCallback<CallbackTarget<'a> = Pin<Box<U>>>,
+    U: for<'a> TimerCallback<CallbackTargetParameter<'a> = Pin<&'a U>>,
+{
+    type TimerHandle = BoxTimerHandle<U>;
+
+    fn start(self, expires: Ktime) -> Self::TimerHandle {
+        use core::ops::Deref;
+        let self_ptr = self.deref() as *const U;
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
+        }
+    }
+}
+
+impl<U> RawTimerCallback for Pin<Box<U>>
+where
+    U: HasTimer<U>,
+    U: for<'a> TimerCallback<CallbackTarget<'a> = Pin<Box<U>>>,
+    U: for<'a> TimerCallback<CallbackTargetParameter<'a> = Pin<&'a U>>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `Timer` is `repr(C)`
+        let timer_ptr = ptr.cast::<kernel::hrtimer::Timer<U>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // queuing the timer, so it is a `Timer<T>` embedded in a `T`.
+        let data_ptr = unsafe { U::timer_container_of(timer_ptr) };
+
+        // SAFETY: We called `Box::into_raw` when we queued the timer.
+        let tbox = ManuallyDrop::new(Box::into_pin(unsafe { Box::from_raw(data_ptr) }));
+
+        use core::ops::Deref;
+        U::run(tbox.deref().as_ref()).into()
+    }
+}

-- 
2.46.0



