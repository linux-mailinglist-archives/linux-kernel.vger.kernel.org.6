Return-Path: <linux-kernel+bounces-435531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEB39E790D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65911883BA5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612A216E36;
	Fri,  6 Dec 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIMoDm+R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF31DE2D8;
	Fri,  6 Dec 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513740; cv=none; b=stiqrRsedvPwT5JPRa4LzsCoPanrg6+iqxoIuDZeqVFZQbaOoX5j/APusYJOasOSQLeE2V7e2t9OQVmEz6XHFfVzKCG5DL9NSVt41aKB24ZX0GQKjjYMTOLsqUkaOm4cvreUFE2BhZnchblYr+rvAnkXgQLq2DhaW7v6H7s0Cys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513740; c=relaxed/simple;
	bh=hgqYHLie9pxbgzFDmV4u1qaSr5gb7nx65glYblRhSjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YesBxbiGnjdZYRfYI9Jog1eRrFUS276IpJRUZ4S8TVJjHtjFubWJq1KLwgmd8LEUGF9UUaON5K6oCvZETVNn3iMgCeMvPe3pDnvW6QvLfmxBMEu5wgnEcrpe0ozoIJwh7eSICRKfGcaInOCkEfcxe2L+1RZ25XWyUdFDULWEYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIMoDm+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC746C4CED1;
	Fri,  6 Dec 2024 19:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513740;
	bh=hgqYHLie9pxbgzFDmV4u1qaSr5gb7nx65glYblRhSjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pIMoDm+RoXqEGz7M1B/l2ERbVNEE1HRauVU0hK7We0uC1iz17nnnjlSgey+E+LrmK
	 +Wp7ZwM+AGBTxKRx0xLmgXl8OlyEs4qPpDNkhro3jn3WUO6sVnBga2GjLNjqAiMxpr
	 Dsj5MB9J8BhPHVU9y0gsnJHtlxc1vUz6jsSvi2AbSjeSIgFUYqM1E8lBCNg9pC+yNS
	 Pp3Qp0H3wlTIUjoq8wzz/z+C/5H6Bt19YrWdQ2qu5fxyUqXFZABuggZRmzM/xzKezs
	 /UoDwzQpM0TOQ5t1osGtIMpsl6JeFMOCFoJ7Q+4htJSLI1WLMViyPGUEI/Pt91jsTq
	 uQHdlV/8PZL1g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:33:00 +0100
Subject: [PATCH v4 08/14] rust: hrtimer: implement `UnsafeTimerPointer` for
 `Pin<&mut T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-8-6cb8c3673682@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4236; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=hgqYHLie9pxbgzFDmV4u1qaSr5gb7nx65glYblRhSjQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVcray93Vm9YUzI4Y0JzYUtieDl4NXV4CnVsZzY0N1FzVW1xR05FQWEx
 cXJXcW9rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRnZ
 BQW9KRU9HNEdqNTVLR04zYkQ4UUFJbEtFdEVKMEtpYlVaMHYzZUt5NG8wUGNzRmlKaVh0bjBlMQ
 pFMXc3TE9mcUdHdm5NQ21XeUFoellneStocEFHUkJnM3hQWW5zOXVNZW5vNHgxaGU3dlBUK1pVe
 Gk5MmVjMWZhCkJJQjFSNWx2WnJqYU1zRWIxZC9QYU1NVHJTcW5zamtYTTE3Q09adHI1Q2tvUUdh
 dUo3WUIyM09WL0tYWHhrQ3gKOXpjWlZ1STBzZkI4TFlIUnlQQUdGd1RjS1JEQ09PaVovdjlpS0t
 6S2tFc3dUZ3RpZll4SC9iVDVDaklXdnd2SAoxV3VoZUluT2RFbFFWbmlsSFpIUDR3N2MycjZyeG
 owd3BOSjVLZjRNWkZzdDFZUlczbXkwT0lzZ2RnL2ZOTHgwCjJYSWRxUTM0N2dXMDk5MG1LUys1Y
 0xyK3ZTV0hmbVduZDNuVVhmZlJDZ0xBMm01MDhyQjdyNzM0dXNBVG5ObXQKSGxSVWlZTG1lb2J0
 d2Y1VUU3WDhqNFB3VjU0M3oraENRdERuaVdWd2dodE1GemdrRzNxMDVBVnJoWlFUQmxOeAppZzl
 VZTY5UnN5M1oxYkFQS2lzMy9DTTh4Wk9GaWt4eW9id2NnbnJ5OVdrU3pRejFFemxKUmgyMVdHQW
 JPTlBDCmdOempBblUwODVBWmE5a1JVL2toY2pyUFIvaVQzeVdtODFkWkdNSXBHdHk5YmduZkRKc
 U9uK3V5WkVGVFhLcS8KcjBUYy9waHdUSHozVzZuREFsaVBRYzBwUklVeEVUaWczQ3VJNnhXeGNE
 T0d4THBRdUxBQnBUVDN5T2VKdkNxNgozbGF5a1ZxUXJma1g0YWF0OStnUmlFUWd3S3VzR0hLcGI
 zQ1RwTFk4WkloUXZWemNOd1lMSGFhRTNIeEVkVTlRCkpBVndMV0wrM3RJbGpnPT0KPTg4RmQKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow pinned mutable references to structs that contain a `Timer` node to
be scheduled with the `hrtimer` subsystem.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs         |  1 +
 rust/kernel/time/hrtimer/pin_mut.rs | 97 +++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index ad02e023b78062b368af1849063d830ffba5f29b..efcb5e44a0dc3660a09f230c01cca998b763e8d9 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -364,3 +364,4 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 
 mod arc;
 mod pin;
+mod pin_mut;
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
new file mode 100644
index 0000000000000000000000000000000000000000..50ba9109919838aa9b09381000bab4ab8d3a2340
--- /dev/null
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
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
+/// A handle for a `Pin<&mut HasTimer>`. When the handle exists, the timer might
+/// be running.
+pub struct PinMutTimerHandle<'a, U>
+where
+    U: HasTimer<U>,
+{
+    pub(crate) inner: Pin<&'a mut U>,
+}
+
+// SAFETY: We cancel the timer when the handle is dropped. The implementation of
+// the `cancel` method will block if the timer handler is running.
+unsafe impl<'a, U> TimerHandle for PinMutTimerHandle<'a, U>
+where
+    U: HasTimer<U>,
+{
+    fn cancel(&mut self) -> bool {
+        // SAFETY: We are not moving out of `self` or handing out mutable
+        // references to `self`.
+        let self_ptr = unsafe { self.inner.as_mut().get_unchecked_mut() as *mut U };
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
+impl<'a, U> Drop for PinMutTimerHandle<'a, U>
+where
+    U: HasTimer<U>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+// SAFETY: We capture the lifetime of `Self` when we create a
+// `PinMutTimerHandle`, so `Self` will outlive the handle.
+unsafe impl<'a, U> UnsafeTimerPointer for Pin<&'a mut U>
+where
+    U: Send + Sync,
+    U: HasTimer<U>,
+    U: TimerCallback<CallbackTarget<'a> = Self>,
+{
+    type TimerHandle = PinMutTimerHandle<'a, U>;
+
+    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle {
+        // Cast to pointer
+        let self_ptr: *const U = <Self as core::ops::Deref>::deref(&self);
+
+        // SAFETY: As we derive `self_ptr` from a reference above, it must point
+        // to a valid `U`.
+        unsafe { U::start(self_ptr, expires) };
+
+        PinMutTimerHandle { inner: self }
+    }
+}
+
+impl<'a, U> RawTimerCallback for Pin<&'a mut U>
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
+        let receiver_ref = unsafe { &mut *receiver_ptr };
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



