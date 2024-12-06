Return-Path: <linux-kernel+bounces-435534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5899E7911
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352D718839D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A6321B1B3;
	Fri,  6 Dec 2024 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi7KP1mX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AFD21B1A0;
	Fri,  6 Dec 2024 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513748; cv=none; b=TRol8bp0oLOHgOkK4bkrHihu+a2pxNO8WwQFxuy0AFpMpTHaG8FRoSYHuNjW3u3aRfG84LCiUblPKDHfR+J30ghgp6mJe11izqr/OdzZO0JKApo1NXKNS1P3H1lQ1aL2ovohS5cjiW/IDIYNVYxX9cemoZcykK0kkVvClP+aKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513748; c=relaxed/simple;
	bh=Gn70I9pN0f4TEQ9qvGFsjodYORtSobyj7JiWCADhVpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNimuNwtHoZM0m48pB34A7huFjYuXAn7JIpyDPLKFQ7sAHUO7TJ2Rtp7yb4r8lEAdoLWr5UE72mARWoSom/CQVrtouVATjsQaTpu5mwJXc2M698FoEJgMTb6KpZEMdeLjU5uLgOzfJDpzo4eFzZv4XnSzCqF9nxgqcgwyAm0WP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi7KP1mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E3BC4CEDD;
	Fri,  6 Dec 2024 19:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513748;
	bh=Gn70I9pN0f4TEQ9qvGFsjodYORtSobyj7JiWCADhVpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qi7KP1mXsJgXDv6bjK/FjXYDXeJqMuftfSfxZSgNAJLGlKciBnDHR+is3p+YGE2B0
	 dtxi4ixXZngPyEECp16qWE3d7WVkiu86ALDF2L8e87heOjAq7PT3Zf/wbgcnoN/Ako
	 exPQv/MU0PRuhR9lp7L9I1L4buWWymM2RWQ4tEsDN4FSY4NdpOWcW8JSB4bOGnrVUN
	 XZR63NkUTTYQmuI3OXwKyEwwvBexY6sl3gY/h8wYqnc5mav3b7mt7J0Fb2mTZHC4QY
	 25V44hlEVF3jfsnA0bPBr6cOvqcD26eXLsjva9KJktNfDpfXRPtTGxKr0JzJ8lig2S
	 TszOn9RygGhZg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:32:59 +0100
Subject: [PATCH v4 07/14] rust: hrtimer: implement `UnsafeTimerPointer` for
 `Pin<&T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-7-6cb8c3673682@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4022; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Gn70I9pN0f4TEQ9qvGFsjodYORtSobyj7JiWCADhVpQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVc1RjFNa0NZWDlnb2lvU252M3JVUWtFCkZBdDNMeDNtWCtDYVgwdThM
 UzVFSW9rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRnV
 BQW9KRU9HNEdqNTVLR04zS2ZRUC9qT21DcG9aMEFTSFRneHpSQkxWdTNDR09ubTNKYk1BR1N2Uw
 p5czBublZIbXlyLzZrVVowUEloSVZ3U1V4ajBGb2FMdU9LbitndHNuK3JSN094RzlIS05FUHRVO
 FhvRHVTVy9kClc1Q3BTTVpEOGJDdHJzTnkwa3BqUXJVSmg1bGdKTWRuSlk4c2hMQm9WWmVENG9p
 RzNLaXBJNFlmRjJBdWE5WHAKWXRKZ21ZMUF1N2xpaUd1bUV4U0toM2U3U3U1b1dwSDZFRnFsMWV
 PbE9EdlFWWkpJMHErY1JwK2loQzNYTTFKYwo3aHBMSk1LK3VjNWZSU3ZMM1B5dUVsMVBhL2VIOT
 d4YkhRTTZvR05kZ0drQ3UrZkYwSWRGWWNDUERoYm9nQ1VhCm5TbUMvZFlQNE5XUnMyNzM5OXk1T
 GJTcytWMnlzMWxGdUZnVkFOTk1PaTBGZmN0TjZBR2pheUFKcE5FMmFqbXAKcHpBT0lpOEpVNjll
 VEpMZlNRYUc4ZllZMXRiUUtWb1hUYXlQZ3Q5K3ZOK1hETEFLWXZTN2I4Y3ZzRTA5Z1ZqQwptNnN
 0ZVdsNFFNbzErUWFwVHloU2VIcG8xdk5zVUFsZjdJSXhUUG1hK0pUcmpVTmx4Z0xjdDFXYU1EMF
 Z6cmhaCnBNeWFMMm5nUSt2M1QvY2xrTzhDTHk1YW1ONDdxbFBFSytySGZKL1JMUzRaZmZCODdIM
 3N3MHUwM0tLS0x1SkcKMlNmM0xTbWsxZGQzZVBhVU04MmtFUzJxR1IzSFViWWwvbGFxMVA3N3JX
 WGp3VG5lUUEvUXZLUWJCVG5FVFlmUwpIYzBTbUFueXBKYzJzNGdEYmw5bWZtdkE4MDNMYndQMlE
 wWHROUzNmbGQ5akhxOUY2QVlKWDRRVDRPMWlvZkhlCmxjbHZTa0RqZnhrbFR3PT0KPUxUUUoKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
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
index fab9bf2612ceaa1ce936ab9b9bc31b018a1a9aef..ad02e023b78062b368af1849063d830ffba5f29b 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -363,3 +363,4 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
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
2.46.0



