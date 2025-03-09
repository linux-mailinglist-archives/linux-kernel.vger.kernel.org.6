Return-Path: <linux-kernel+bounces-553191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1408A5855A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD24B165069
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0D21DE4FE;
	Sun,  9 Mar 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLDzv6ak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5441DE4CA;
	Sun,  9 Mar 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533784; cv=none; b=epgleedisTSvAwzPsDN227L1h6+KNYYeJeXTWOO3FYf7uXjU79txUW6RKCTuHElYnMaq6fz1KdiZUjqrr1DC24/w+z6XmVIksGYbftVC1xqDtkILl5XKO2b0df2tynEUrhF/k/DvL5WlO0QThYf0V+pr1ab7xen8870TuQzWMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533784; c=relaxed/simple;
	bh=Psxseb9eW3+jpOO87puAyXZ+ypUuGK/8ZvM6S/VLMIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OLG5dBZfc9SqsS9gtsiDArj12TjXk0+7D8mfeSZGaaH7urHOb63fgoZ0S2LSzBmZ/AoaOzms02YcgqhuYbKvbCc9AmgklnTiZDWjODoBKG/7kTQWVsOeXg5bEtLOT35lm/1LbkUuKlJgt8eNVs+k2flE1evIEfgRH5Kr31/lBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLDzv6ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BFAC4CEE3;
	Sun,  9 Mar 2025 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741533784;
	bh=Psxseb9eW3+jpOO87puAyXZ+ypUuGK/8ZvM6S/VLMIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RLDzv6ak7W/AmtrU/yerz5bZofiu42ipbkGK5hkaYxONz0Do1EEQO0DZC8EatB6sT
	 Gc2QXTxNaij2NwiyHEIX2HDPRsYI5UtZWjPRbARqS2joo+NT/DhnCKeQ+dxwkXRUtN
	 oseBxzHgwqrcCEzbETnvvLY9+v4X2+t2u2qYwsk6+jyGFaP0UbG3SZA9frcpS2KBrq
	 CKpd8FdVYGe0uM2YjV8/f/Mju6Pku4VrHocaGAmmo3UU3J0vc/YmY+U1tfe18rdlsQ
	 LWqWUc8wE2pfZdbz5IyuU6Q/Mld+nvzdLlfcWpCz0P7kNrhRQ3EZsP0TahfJ6akqlw
	 CvtS0dQtJ5UkA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sun, 09 Mar 2025 16:18:59 +0100
Subject: [PATCH v12 08/13] rust: hrtimer: implement `UnsafeHrTimerPointer`
 for `Pin<&mut T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-hrtimer-v3-v6-12-rc2-v12-8-73586e2bd5f1@kernel.org>
References: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
In-Reply-To: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5022; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Psxseb9eW3+jpOO87puAyXZ+ypUuGK/8ZvM6S/VLMIs=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnzbFuGLOvoaRkGjPbGYEmJFrsRsoKC/EJ2i8Av
 3Qm3RWEek6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ82xbgAKCRDhuBo+eShj
 dxJXD/sFK4FI+aZNHSj1jiCZV8WCDu1Nfw8+5ZABaLEriPFWQDujPvXqPc6s6UXV/MgCRe1wymN
 jX99p9g0gdrslXaLUYfqXJdY8umJ9Yhscp95jODiRrfntdLkfOqnBgdgij6rSpbBNRBvRGFHlta
 g+sNLr40ZvXIRFfC3shubUnvyIrG29T/lsKTnx9nWA2TpctBjnnz6lW/EHFNJadYErnlcZfNnje
 arELUwAzlIebKi5u4abJGAGT4ICiNHgLdFzys5LCM2YDOYzaa6+BQKFilzciKQJQm1pBz5gGdW6
 14/JPV6/Wa6m0gUEbhtCXqsSiFH2JW7DtLCvbRXRncgmoSqMHHIr2baJW2fzDmaCtlPNg+eRsdu
 D5iE98j1SqjVgsF8eWqFE41eAAcZVn5w3ki6VjHzUt0WYVsRTMYv/Go1Sw9Y9tL3phWFUNTcgQE
 l0m3DtIvtXEtl2u2SPpb6LA8/ZSjvFhBETa76x2L2DcXwM2deyYe+VsgZkjdVz8GRZOYm+Ycg6i
 QjUwlDwmH/XPLQYME5ffPWWvU1nGnMXt96iY6HJLiKrOegGTFEE0SejGGw7hdoaY2Oi0eJogZws
 G/pe1l0i0+Oz0Zxw121X3FPr24fHsab95NU8yZXnHYCDnpBpUaCGZAe/LZ2jH6OKhJRDxqM3L07
 JG4c9US1f97b4mw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow pinned mutable references to structs that contain a `HrTimer` node to
be scheduled with the `hrtimer` subsystem.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs         |   2 +
 rust/kernel/time/hrtimer/pin_mut.rs | 108 ++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index abcaa505f7d8..4e81505d6675 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -434,3 +434,5 @@ unsafe fn timer_container_of(
 pub use arc::ArcHrTimerHandle;
 mod pin;
 pub use pin::PinHrTimerHandle;
+mod pin_mut;
+pub use pin_mut::PinMutHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
new file mode 100644
index 000000000000..90c0351d62e4
--- /dev/null
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::{
+    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, RawHrTimerCallback, UnsafeHrTimerPointer,
+};
+use crate::time::Ktime;
+use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
+
+/// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the timer might
+/// be running.
+pub struct PinMutHrTimerHandle<'a, T>
+where
+    T: HasHrTimer<T>,
+{
+    pub(crate) inner: NonNull<T>,
+    _p: PhantomData<&'a mut T>,
+}
+
+// SAFETY: We cancel the timer when the handle is dropped. The implementation of
+// the `cancel` method will block if the timer handler is running.
+unsafe impl<'a, T> HrTimerHandle for PinMutHrTimerHandle<'a, T>
+where
+    T: HasHrTimer<T>,
+{
+    fn cancel(&mut self) -> bool {
+        let self_ptr = self.inner.as_ptr();
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
+    T: HrTimerCallback<Pointer<'a> = Self>,
+{
+    type TimerHandle = PinMutHrTimerHandle<'a, T>;
+
+    unsafe fn start(mut self, expires: Ktime) -> Self::TimerHandle {
+        // SAFETY:
+        // - We promise not to move out of `self`. We only pass `self`
+        //   back to the caller as a `Pin<&mut self>`.
+        // - The return value of `get_unchecked_mut` is guaranteed not to be null.
+        let self_ptr = unsafe { NonNull::new_unchecked(self.as_mut().get_unchecked_mut()) };
+
+        // SAFETY:
+        //  - As we derive `self_ptr` from a reference above, it must point to a
+        //    valid `T`.
+        //  - We keep `self` alive by wrapping it in a handle below.
+        unsafe { T::start(self_ptr.as_ptr(), expires) };
+
+        PinMutHrTimerHandle {
+            inner: self_ptr,
+            _p: PhantomData,
+        }
+    }
+}
+
+impl<'a, T> RawHrTimerCallback for Pin<&'a mut T>
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
+        //  - As per the safety requirements of the trait `HrTimerHandle`, the
+        //    `PinMutHrTimerHandle` associated with this timer is guaranteed to
+        //    be alive until this method returns. That handle borrows the `T`
+        //    behind `receiver_ptr` mutably thus guaranteeing the validity of
+        //    the reference created below.
+        let receiver_ref = unsafe { &mut *receiver_ptr };
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



