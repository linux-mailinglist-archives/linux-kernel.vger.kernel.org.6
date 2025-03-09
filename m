Return-Path: <linux-kernel+bounces-553183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8DA58551
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C773AA21D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635D61DE3D5;
	Sun,  9 Mar 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSTA3p/r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD046426;
	Sun,  9 Mar 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533718; cv=none; b=i5k+dB70G26ZMJXfUxdimmCGLATKTBHBYbK0RRbl/vSBiDbgkzstVrKSDntGSRNAgZ7c3pDZIsdr/+vs3hL+xK17iQ1HcZjn26k3f6XMzgTJMHm/yMfcRR4yGDJk6JAT2OyW/iObRiZ32oiE0u2EfcmM8Mhyeq871NpqH71AZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533718; c=relaxed/simple;
	bh=XC9i27LoAS9Ry1i3YnpjdFGuLigUZQ8uGI9xUepInAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tVCH8nF/7elckGojYgpx+BzNMXyuLPnQdE6Mmy+8TvchI2ACIdt0Tu+KqYiUlS58R8R6Bi0k9UFK1Wk7+FuNF4boVUjc8DdULpO19i4/xQia4d33IURSYC0dNJ5p1XZf4lpc8uy4jveIHCbTHGETCy9zgAFNy+vHbFJU/3Qqgmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSTA3p/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654C6C4CEE3;
	Sun,  9 Mar 2025 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741533716;
	bh=XC9i27LoAS9Ry1i3YnpjdFGuLigUZQ8uGI9xUepInAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dSTA3p/rjFhZVaq7XuTB7cHTtoQFU8szYfKBKjoFhF+FWkJhf/E62+oVWLvgNyFBq
	 fTmeF45CVGwCYz+w2PUJ4p6LlV4DmJlKE2XPlhXxJDfIZCM4Q81YHYnLPccfw7Stc5
	 +ifBRNLByTI2l86gd5Me+89qfBtULYaBw3qVXPktcgP+y1q87wr6PTQaq5GsMeQTi/
	 RQtD4ePQuS+WIEbhhQvOVnBb6VdG61duBRWwXHnFznCG1bjZDPSmpSY07PZzcXnBTm
	 Mg6RpDi+SrgCeC58tFXi1orrfotvxSm8+mGBX6HeKh2RjjnE//5EmlzEkrHBInkWqd
	 DLSpr9QLM2rOg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sun, 09 Mar 2025 16:19:01 +0100
Subject: [PATCH v12 10/13] rust: hrtimer: implement `HrTimerPointer` for
 `Pin<Box<T>>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-hrtimer-v3-v6-12-rc2-v12-10-73586e2bd5f1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5248; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=XC9i27LoAS9Ry1i3YnpjdFGuLigUZQ8uGI9xUepInAo=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnzbFwsMfSYXGzay2VmyZm/9TwgBGlB70D+9pqy
 qgiwsxeRhuJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ82xcAAKCRDhuBo+eShj
 dzcpEACeSez4lj0cALJhMZt5DeuNuKs1/xt4h1DStGe1vtGNPn+XmDVdfRVbA2jPhp1ucQo+lG8
 ez8TTQyZoPrEEKeVQO3ExmCUhhKxszMgdOb99oTISe44p5OjmqISgFt+Hlt4Gl5O5KxxggW0t5n
 7qo6nQmqRSRfSlLzB7e+i1Ik79jFcqMPWWvugeff6cGCVmM9abh+i9OTYdad1L6w6i2uv7Hm08x
 G4WIaMefzo+Wnu7A+8GcisdTMRIb9tFtk3H44cHfosfLMpRgp5/PX5uRYt9KxHvLg3m8+lyfEDK
 zk/ZPAJTS1nIW0TQmaqDU5Iq8rVDOhTrhgVudtyo3rUsOEkhrr5P68TlZaHx8Zr0Qq5PyMEEe5L
 rIxzLg5ks1lJxAozvfzRnFHaCj/Yq9HOKI4cgX70EZu0l8j6yIqj4EiGBl/MN7EnBPT42cbWWqx
 pVCty9bYTfWQxv4jc8ROvy6NsypTphmfrsjbi2Lcwt79Q0SNyiPCxFokB1L9JTL9phP3EsIbxVa
 mcwyShsBnJZglJW8IPBUdE6FoHofuy7TVHSGzPC0g1egMiCf2rq8NbDXtL7n4TcsyUUYFPReCXY
 Mw9NW10zy5wShs17WJ/RTTS599FqQA9Tc/He1mr1kZJKsrfADC5KzUm9QD2NQbY6gEzs9yi/nHQ
 CEjZx36DlLa3FpQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow `Pin<Box<T>>` to be the target of a timer callback.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs      |   3 +
 rust/kernel/time/hrtimer/tbox.rs | 120 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 4e81505d6675..2436f04d02c7 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -436,3 +436,6 @@ unsafe fn timer_container_of(
 pub use pin::PinHrTimerHandle;
 mod pin_mut;
 pub use pin_mut::PinMutHrTimerHandle;
+// `box` is a reserved keyword, so prefix with `t` for timer
+mod tbox;
+pub use tbox::BoxHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
new file mode 100644
index 000000000000..2071cae07234
--- /dev/null
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -0,0 +1,120 @@
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
+        //  - As per the safety requirements of the trait `HrTimerHandle`, the
+        //   `BoxHrTimerHandle` associated with this timer is guaranteed to
+        //   be alive until this method returns. That handle owns the `T`
+        //   behind `data_ptr` thus guaranteeing the validity of
+        //   the reference created below.
+        // - As `data_ptr` comes from a `Pin<Box<T>>`, only pinned references to
+        //   `data_ptr` exist.
+        let data_mut_ref = unsafe { Pin::new_unchecked(&mut *data_ptr) };
+
+        T::run(data_mut_ref).into_c()
+    }
+}

-- 
2.47.0



