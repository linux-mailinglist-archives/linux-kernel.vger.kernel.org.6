Return-Path: <linux-kernel+bounces-552002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D17DA573E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BDF77A766A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6F225A2B5;
	Fri,  7 Mar 2025 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrLWY8gr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B45F2586C4;
	Fri,  7 Mar 2025 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383701; cv=none; b=TyYFBzftJYlVEEaEMNc9x6mJHoelzKFe9Gb0jEujC2fqravADTqywoEUEMlOEL3s+0yCgTRrpnHL2h6KGtyKRPKriajdef92C5CXiZkr0aoAN5vR5c43+u1LswN3NapQTdY47lGCMKCrL455AXcMrmI7XmLE4LJuWlkDKOWDumw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383701; c=relaxed/simple;
	bh=8HZc2koQvpcFgAmxjbTk3cLLBpLCSExGOakb1JOglEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cRBEkHRI3Xit495VKaunx0UAd/ggdpKhHwg+1+TIa9wT0klzFKjXb2bdt0jofeSHOD/O9WKoUi7wb+3Ze4cn/e3T0bJoIRqgiZMGj3ujuGyE7JW6ah70vmvF8TqYaicolrh5Hhr6s+PEG+g9PvBkG6i8tJ7C8jmc+aN5zvo/5m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrLWY8gr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA7EC4CED1;
	Fri,  7 Mar 2025 21:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741383700;
	bh=8HZc2koQvpcFgAmxjbTk3cLLBpLCSExGOakb1JOglEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UrLWY8grBHVeub6sTOSp8ffC+pw+TIfdf6/QPHFMBf8PfJlfMIrYtqeCLYQ/UYEjU
	 fwUGbXUpmVOgX38sTcO2ixZb0uEQ9g0An2zse/Fp+jgQ8qXKMs6wJHuuX9NfTcEhg5
	 AhdlKNKbDkc08L6e9T82/koBgvnGbToVMh7cIL105omW5nZm1tdV7/WCD9h4TAfSnH
	 X9vw7uJx8DBHglLz/B0HgNj4ISngUtkLY7EvQiT+0TPHpU/dWt23+olsE/YBXHQeDh
	 pxvEoVoJ9qvvBypp4KOxcq3xkxFIXkn0GzLoEtwewV8OPdACJBwIpPa49RvNbedEbP
	 WM9L64MHTy4hw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 22:38:51 +0100
Subject: [PATCH v11 10/13] rust: hrtimer: implement `HrTimerPointer` for
 `Pin<Box<T>>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v11-10-7934aefd6993@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5085; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=8HZc2koQvpcFgAmxjbTk3cLLBpLCSExGOakb1JOglEg=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBny2dyHqHktX4I8RO9S6j6/h3c0NhM1k/lY4sAl
 etJ+Rr6r8mJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8tncgAKCRDhuBo+eShj
 d/2oEAC0lW0q298CCj/+GL1al4Ren5SQYBWWIfpriuWggIz4cJBLINTUr6COlvi/p/sHoBdfS1+
 c+CpLwplvGsAJmuZoCaDb0hsFTn6+CxJ8JSe+aMS6p95IlgyE/wbfeAcFX0FXe2yYTXZWXvW2j8
 F3HOK8cY728HEgBHYDVStbhVPu00nwDtd3WlvHzGPChxRELOXYpGJsFndvkYmWFDERa0uLlPHd5
 f4ucn6UWo2ZquWcHbKP5YCThRT4mXocremQh+euYMU7SQ7mFKV18YnuvS/BzII5z9/6DfdEUtmo
 HPQi8rASNTeEwYsF2OjuF4sfrHSLtjt0ymxM2RSXZum448KwbY55FIQ/DCwdsOCHfnA+oNJdKo1
 9jJTzcoRfbn4eKdjbwO3zqjnz88Xr62+0ddjmchS7HmIVzq3B2eRrDMn2pICVoW3JzI3jesu136
 kN8jmUzm9n7pLwto73SBPxw+MGO2hmb9NC72oAU/bc7srKJX7qfYJuoMDxhtN44xHh7/wFW/x0E
 9zKw/n5fl2pZjr79x5TqMLQX7/XFKXh+qvgjVrfVHsBZd2q/KMlodTKJr5k6pekX4fijgPe2U4v
 cTxoWWQgecxGx+uB4LBdZaO2ODJoTNYT+6MJ9G26dkFJ9+hrJfGgC63uJODCHXwgaKV+M4YPwrj
 82G9D/qOoJywjew==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow `Pin<Box<T>>` to be the target of a timer callback.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs      |   3 +
 rust/kernel/time/hrtimer/tbox.rs | 118 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index ab0950a964e8..cb404daa12f8 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -435,3 +435,6 @@ unsafe fn timer_container_of(
 pub use pin::PinHrTimerHandle;
 mod pin_mut;
 pub use pin_mut::PinMutHrTimerHandle;
+// `box` is a reserved keyword, so prefix with `t` for timer
+mod tbox;
+pub use tbox::BoxHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
new file mode 100644
index 000000000000..43a0aa245368
--- /dev/null
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -0,0 +1,118 @@
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
+use core::ptr::NonNull;
+
+/// A handle for a [`Box<HasHrTimer<T>>`] returned by a call to
+/// [`HrTimerPointer::start`].
+///
+/// # Invariants
+///
+/// - `self.inner` comes from a `Box::into_raw` call.
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
+        // SAFETY: By type invariant, `self.inner` came from a `Box::into_raw`
+        // call.
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
+        // INVARIANT: `inner` came from `Box::into_raw` above.
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
+    type CallbackTarget<'a> = Pin<&'a mut T>;
+
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `HrTimer` is `repr(C)`
+        let timer_ptr = ptr.cast::<super::HrTimer<T>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // queuing the timer, so it is a `HrTimer<T>` embedded in a `T`.
+        let data_ptr = unsafe { T::timer_container_of(timer_ptr) };
+
+        // SAFETY:
+        // - `data_ptr` is valid for use as a mutable reference the
+        //   `BoxHrTimerHandle` associated with this timer has a mutable borrow
+        //   on the underlying `T` and we do not create other references to `T`.
+        // - As `data_ptr` comes from a `Pin<Box<T>>`, only pinned references to
+        //   `data_ptr` exist.
+        let data_mut_ref = unsafe { Pin::new_unchecked(&mut *data_ptr) };
+
+        T::run(data_mut_ref).into_c()
+    }
+}

-- 
2.47.0



