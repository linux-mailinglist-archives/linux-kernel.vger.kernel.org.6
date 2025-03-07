Return-Path: <linux-kernel+bounces-552003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76942A573E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E251887356
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03D92586E2;
	Fri,  7 Mar 2025 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi9fJvxo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164422586C4;
	Fri,  7 Mar 2025 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383706; cv=none; b=IFj/Fl4Zc09YwJ19s4xDkaYBDwA0Z5wMT4dzvd/SgqlMHuiR9bqPH5PWtyL3CZBtjSOo7N1nbqiFYEmtQ0aeOZaWtH42Ov3w2ZC3QfcL46EIxbnuiVxfIzV62XmBslvtLhl0En1fVzaHkZ2lSJTuQmvDINH7k/7NQJ1VHsa3Zac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383706; c=relaxed/simple;
	bh=39rjeFhd5rDBchJ7XrlQK09N9GOwtaFo3/g2FBx3D+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svBO5V+FFDyE6BzeFaufX64uE9oYDsHmwFZi46DZSs0O7AukwQjSKEDKMyV4NCJbdn2xbIXLgOMBQTGpFPQrWg4xYOhBDgnwVduZPFJgC//jxZ3uMwzlMBcXBCHksJCWk5nwZVcjiibH5Uf0itekjGtYcDOCXCFUG0bnRZZ6HaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi9fJvxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3A5C4CED1;
	Fri,  7 Mar 2025 21:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741383705;
	bh=39rjeFhd5rDBchJ7XrlQK09N9GOwtaFo3/g2FBx3D+g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gi9fJvxo0DjRN8llww8mewVdDC5QQXA29UVKAngnXgjxMGkE3K/UDWuwIihnwoeDf
	 kLxHmLfDnaYKWUjLKe5xW8DTDGKwqd7bGQAlGOkqQBQCd32JMfKsyQs2uQfR5KIxKi
	 PBDpFZQI53I+v1U1c5590t9glTBWqrPTfqJ+ZEkjiy7l3+kbpoiI0EhZjp7taIq0XL
	 lnePnvDdwdFuF4maPvhTIQ3nEnlPQvylmrJejsPtlhIZc+U8q++Xxve78NdV0+aJ5H
	 wEIcQ3XsdMbvgEq793wkHpOP7Ssmgzew+NZRd9ePFnFGgPqN7bfp65oTC1W4PvPR6w
	 p8yOBmgwy4LuA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 22:38:48 +0100
Subject: [PATCH v11 07/13] rust: hrtimer: implement `UnsafeHrTimerPointer`
 for `Pin<&T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v11-7-7934aefd6993@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4516; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=39rjeFhd5rDBchJ7XrlQK09N9GOwtaFo3/g2FBx3D+g=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBny2dvuXVIiwjg7SYPJcDZnDgzm4T09G/7qqV4Q
 yBkowivVIWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8tnbwAKCRDhuBo+eShj
 dxIDD/9DKr4PsXs/ydaCBCDdosM99NwIJT1ooSJ2vkU6xqNrU+fvqKlKClYOizzOTgr6ZoHJjOh
 p2c6sTjYeJj2SJdUAmkpBz8hBVDiRIb7n5glR4cNdVQbJ/1KC1c8T351YSXtxftjOg719XGs0ue
 hcNY2hq5rjdUhIc79pGlsczctyPOAoGbMQ8TdHyUiRh/sQAPKS8ZAb+qeYEs0pTouUhZfNrbpxG
 zP0x+W2DmOvFmM20jAIsaUzsrYpxfaFArMHitC177MIZNyHYQve5W/NnE2D0VbcAylg4YesgKUS
 5s4YhppNqwTWAvpx7aNP4JF7oZP92u/Tdc34zVPK0wnYymLBaqxc79kLtM95Fde724Dnow7mlVR
 7RmrJWuCbLWtiI9jFrQLjxnKE+muoSXmYA+MyaAsUtBQJ6Smj2OXoi4YKZZM3lMmE9Jfl3f+o7o
 6hO1PpDmamNqmYkllVtAE99bqgK+LLnLmZpv68XCohOpPnWdlCDVjZjOlL96QZnxMSEJBI6OCNx
 uTD2sBruW13ne45MVEhFgoRaBGsgwlOUYXQ2Bv6fUI7eB63DMD3uMIC1pppXDcSKwmwXpmOzLyN
 R6WE0sTf5X4MTxxmoDoOnLGsr5jHVIRlP5ltBpHklPn84zo1mjmXxN0uJevmkKC78DwRuO7XSdd
 V8YUvGx4KZHhuDg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow pinned references to structs that contain a `HrTimer` node to be
scheduled with the `hrtimer` subsystem.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     |   2 +
 rust/kernel/time/hrtimer/pin.rs | 104 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 8eae2d10b6a5..fee8e44447ee 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -431,3 +431,5 @@ unsafe fn timer_container_of(
 
 mod arc;
 pub use arc::ArcHrTimerHandle;
+mod pin;
+pub use pin::PinHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
new file mode 100644
index 000000000000..215afbad23dd
--- /dev/null
+++ b/rust/kernel/time/hrtimer/pin.rs
@@ -0,0 +1,104 @@
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
+    T: HrTimerCallback<Pointer<'a> = Self>,
+{
+    type TimerHandle = PinHrTimerHandle<'a, T>;
+
+    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle {
+        // Cast to pointer
+        let self_ptr: *const T = self.get_ref();
+
+        // SAFETY:
+        //  - As we derive `self_ptr` from a reference above, it must point to a
+        //    valid `T`.
+        //  - We keep `self` alive by wrapping it in a handle below.
+        unsafe { T::start(self_ptr, expires) };
+
+        PinHrTimerHandle { inner: self }
+    }
+}
+
+impl<'a, T> RawHrTimerCallback for Pin<&'a T>
+where
+    T: HasHrTimer<T>,
+    T: HrTimerCallback<Pointer<'a> = Self>,
+{
+    type CallbackTarget<'b> = Self;
+
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `HrTimer` is `repr(C)`
+        let timer_ptr = ptr as *mut HrTimer<T>;
+
+        // SAFETY: By the safety requirement of this function, `timer_ptr`
+        // points to a `HrTimer<T>` contained in an `T`.
+        let receiver_ptr = unsafe { T::timer_container_of(timer_ptr) };
+
+        // SAFETY:
+        //  - By the safety requirement of this function, `timer_ptr`
+        //    points to a `HrTimer<T>` contained in an `T`.
+        //  - As per he safety requirements of the trait `HrTimerHandle`, the
+        //    `PinHrTimerHandle` associated with this timer is guaranteed to be
+        //    alive until this method returns. As the handle borrows from `T`,
+        //    `T` is also guaranteed to be alive for the duration of this
+        //    function.
+        let receiver_ref = unsafe { &*receiver_ptr };
+
+        // SAFETY: `receiver_ref` only exists as pinned, so it is safe to pin it
+        // here.
+        let receiver_pin = unsafe { Pin::new_unchecked(receiver_ref) };
+
+        T::run(receiver_pin).into_c()
+    }
+}

-- 
2.47.0



