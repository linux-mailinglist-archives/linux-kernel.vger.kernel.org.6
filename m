Return-Path: <linux-kernel+bounces-553187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6052A58556
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C61F3A27AA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC01C1DF279;
	Sun,  9 Mar 2025 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb37gByU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198A61CAA88;
	Sun,  9 Mar 2025 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533750; cv=none; b=pqXX+uEIvODU6ESDDc6aIQC5pmcl4PIGhM3pDVIrx+Yo8FIVuBF8W9tgcnNeg7+LChIeDG2Hxa513NAZUJhan973EcRnDEicKxOY/zkIxqtt07NlN1dK5eJxw698bFpH8RTTZKAqeNBDtPfOVf37aGTN2JLYD1RxosSZECt6CYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533750; c=relaxed/simple;
	bh=e4Tg3ElvZajihJllWZKR6PZYEY6OPwlUgxWEPUgKJaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZ2GHqTXjHHogidpRFAJbdpzycd3ePYjVuHQgXBk5s2Ub5lKZSy+7M6BwIsImAfNnOW4WUuHH/9rJxAohL4fRubm2o5t1Shp0Lp6fpuF/eKb85+CFJhLfY5ZgqKIjORk1KvC04gnPiARoRyu6TWe+FLfZFR91GJXAEMKBUrCAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xb37gByU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611A5C4CEF0;
	Sun,  9 Mar 2025 15:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741533749;
	bh=e4Tg3ElvZajihJllWZKR6PZYEY6OPwlUgxWEPUgKJaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xb37gByUwbmUhphReK41NKFGFmZWiNdhmkRVu95aGXBsORGRIsbYPAX2Nmtq/ME4j
	 Mq1M0hnvORl1k++XVeIGHQUxLjHOlLU6QIlyAjS/yUuBY2gNjC0KyPvKZ45WqP18e4
	 ysM0BQvlnPmUCTKh7z6EaPTfwlQe+6v5ZaqhurwrLk4WXqGdevXzZaxuL4DJRVT78h
	 1iYa/4w7wByj1Oh0v3d8V8zXCcQ6/turaoQiON4OX1CssDaYRjieUxISoBOUKjNSJP
	 tOkWX1Mi7WiyFu2sibageeEoVGjYQR40PkY3LN2BmH6Hb8N8gUBUiDID8zn3OKL1+6
	 BSwBkYRsaVcMw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sun, 09 Mar 2025 16:18:54 +0100
Subject: [PATCH v12 03/13] rust: hrtimer: implement `HrTimerPointer` for
 `Arc`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-hrtimer-v3-v6-12-rc2-v12-3-73586e2bd5f1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4895; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=e4Tg3ElvZajihJllWZKR6PZYEY6OPwlUgxWEPUgKJaQ=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnzbFp5FCvVV3WA5AMThM5Sq+0QmUM8ndC5ntSW
 uugHPsjzAeJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ82xaQAKCRDhuBo+eShj
 d1DBD/9VrWKK+aPlF71ZdMc4S0JtrNfrHariNMg3NdcudXGw2OeEE2YJogplCuyrbh9aRhBB/yV
 zu6TT8qCTDWCcVYsbyHZsPCfC0GE/TK+Z3B6hp8hpRlfAdcLCQ8/6nBdQZ5OaljAc6UEbbJwVbI
 EUT2YlPF/iTvfiqn8ZnuJl08b8g/oiCfNrLAlq3kb5669YFnpci1zLueFyPAUX+UsWqrUkCHrqh
 s+kPA6PSMRi4PIHKkOuCKqQSNDA9yth1hufInyK0+B2jY7BcD/HFGzAgGJVDkAmG4KqrXaswkEv
 wJF1svE096lo1Mwps99xCbQW0jIfqru4hD+GcBvYOnZpHx6jgXRJie66WA9UjjJP0zp/lLJwTL1
 MG9Jr6WILQB1Jf0zG5QNbOLGyQTLDfWU+qe4ujJG7NrbpbbbP80ozTh1za2w0uUCEKcxwx0HeMY
 sL2hxcgRNyHMPdKPkn9ubDR1yeoZfZ+aPeLbpxzGUXvPLHoCzXYo7yFeCcNOYQXAicslJuj/S6l
 Z6jU+kqjSva+wYxAKnok7iZ4eZvoUMHuOVDll7dLjI2OBwrPYbfcxzShCjXgymdPh6GLEy3u0Ts
 6lwhTLfizbNYj9qRw9G5uTTMlGWtoarhH/xan19iW9V9nUswSCIHVqFoEDw3UrIjY+ve80ullMm
 7A8a9DDMcf8ydMw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow the use of intrusive `hrtimer` fields in structs that are managed by
an `Arc` by implementing `HrTimerPointer` and `RawTimerCallbck` for `Arc`.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     |   4 +-
 rust/kernel/time/hrtimer/arc.rs | 102 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 20d3440c2a02..c6d6eaed31aa 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -150,7 +150,6 @@ unsafe fn raw_get(this: *const Self) -> *mut bindings::hrtimer {
     /// # Safety
     ///
     /// `this` must point to a valid `Self`.
-    #[allow(dead_code)]
     pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
         // SAFETY: `this` points to an allocation of at least `HrTimer` size.
         let c_timer_ptr = unsafe { HrTimer::raw_get(this) };
@@ -350,3 +349,6 @@ unsafe fn timer_container_of(
         }
     }
 }
+
+mod arc;
+pub use arc::ArcHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
new file mode 100644
index 000000000000..df97fade0aa1
--- /dev/null
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::HasHrTimer;
+use super::HrTimer;
+use super::HrTimerCallback;
+use super::HrTimerHandle;
+use super::HrTimerPointer;
+use super::RawHrTimerCallback;
+use crate::sync::Arc;
+use crate::sync::ArcBorrow;
+use crate::time::Ktime;
+
+/// A handle for an `Arc<HasHrTimer<T>>` returned by a call to
+/// [`HrTimerPointer::start`].
+pub struct ArcHrTimerHandle<T>
+where
+    T: HasHrTimer<T>,
+{
+    pub(crate) inner: Arc<T>,
+}
+
+// SAFETY: We implement drop below, and we cancel the timer in the drop
+// implementation.
+unsafe impl<T> HrTimerHandle for ArcHrTimerHandle<T>
+where
+    T: HasHrTimer<T>,
+{
+    fn cancel(&mut self) -> bool {
+        let self_ptr = Arc::as_ptr(&self.inner);
+
+        // SAFETY: As we obtained `self_ptr` from a valid reference above, it
+        // must point to a valid `T`.
+        let timer_ptr = unsafe { <T as HasHrTimer<T>>::raw_get_timer(self_ptr) };
+
+        // SAFETY: As `timer_ptr` points into `T` and `T` is valid, `timer_ptr`
+        // must point to a valid `HrTimer` instance.
+        unsafe { HrTimer::<T>::raw_cancel(timer_ptr) }
+    }
+}
+
+impl<T> Drop for ArcHrTimerHandle<T>
+where
+    T: HasHrTimer<T>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+impl<T> HrTimerPointer for Arc<T>
+where
+    T: 'static,
+    T: Send + Sync,
+    T: HasHrTimer<T>,
+    T: for<'a> HrTimerCallback<Pointer<'a> = Self>,
+{
+    type TimerHandle = ArcHrTimerHandle<T>;
+
+    fn start(self, expires: Ktime) -> ArcHrTimerHandle<T> {
+        // SAFETY:
+        //  - We keep `self` alive by wrapping it in a handle below.
+        //  - Since we generate the pointer passed to `start` from a valid
+        //    reference, it is a valid pointer.
+        unsafe { T::start(Arc::as_ptr(&self), expires) };
+        ArcHrTimerHandle { inner: self }
+    }
+}
+
+impl<T> RawHrTimerCallback for Arc<T>
+where
+    T: 'static,
+    T: HasHrTimer<T>,
+    T: for<'a> HrTimerCallback<Pointer<'a> = Self>,
+{
+    type CallbackTarget<'a> = ArcBorrow<'a, T>;
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
+        //  - `data_ptr` is derived form the pointer to the `T` that was used to
+        //    queue the timer.
+        //  - As per the safety requirements of the trait `HrTimerHandle`, the
+        //    `ArcHrTimerHandle` associated with this timer is guaranteed to
+        //    be alive until this method returns. That handle borrows the `T`
+        //    behind `data_ptr` thus guaranteeing the validity of
+        //    the `ArcBorrow` created below.
+        //  - We own one refcount in the `ArcTimerHandle` associated with this
+        //    timer, so it is not possible to get a `UniqueArc` to this
+        //    allocation from other `Arc` clones.
+        let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
+
+        T::run(receiver);
+
+        bindings::hrtimer_restart_HRTIMER_NORESTART
+    }
+}

-- 
2.47.0



