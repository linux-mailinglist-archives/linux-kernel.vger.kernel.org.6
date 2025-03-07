Return-Path: <linux-kernel+bounces-550840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786ACA564F0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37D63AD807
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54DA20E033;
	Fri,  7 Mar 2025 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOdXl3SP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD316DED0;
	Fri,  7 Mar 2025 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342662; cv=none; b=RnS4LU9RP1g/Esc3WnGzZbTa6NinTIwEFzWeV4Wfno6dsNCTzIZ73wqnZvwn9soUPTpC323BohdYu/U7EZDXafcP/zUMYH6VZvMwwbXUfZNJYY9k0/cwANUOZSpjoCasClvUxUTwzQnGbLFtmydMqLrUhXmjBk/aKTTC6v28hXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342662; c=relaxed/simple;
	bh=1Vq1rpCX8kQrR4gFhW87Me9AbRSCjpBro5aw8HsYISE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNqXfntDppgLUB9Q7JW2Z4zwVbgBRQ5LLVZTUIYMW/wIJqYK0O1yhNv46PNYhdA84+38BQwy7NTtM7+ZUQQhTEzu5PA+E7kyquARQ3MPO6YhSKrNuom4RCodtZXA2Uc+0+HEPnpo+0hhFPz7AHQclOD49CVM1L18WE/W7K6TIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOdXl3SP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AE2C4CED1;
	Fri,  7 Mar 2025 10:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342660;
	bh=1Vq1rpCX8kQrR4gFhW87Me9AbRSCjpBro5aw8HsYISE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BOdXl3SPSi3KuFviQcHoWlndch6XoyelxBIrANN0Yprxu8PwytyI+WO8ss7vdULAv
	 EbRSAHgPyTrQyrT/08GKkqU/NmnG01n6Y2m6oa9zzwUbNpjqfVIX1ObX2RrysVfsM5
	 NV9Ph9MQaLz9TGvKc1dpwS1ro6FvUO+9Kup2f2ERcdGBpMqNKiSxbSeBmBmECXxJ8c
	 DHX3LQAo6rDk5whYSjEmgqK6m3T6ea9f2SnuoSNnj0au9WYlGenSEcPvToiY6x4uOa
	 7hTpnszU3dqol12nWOvneAsSWE4q1h49J/H/+N/JB8e9Vhi1cFXZiAu3k/64CxhSuu
	 6CSLwITjEasXA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 11:11:48 +0100
Subject: [PATCH v10 03/13] rust: hrtimer: implement `HrTimerPointer` for
 `Arc`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v10-3-0cf7e9491da4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4405; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=1Vq1rpCX8kQrR4gFhW87Me9AbRSCjpBro5aw8HsYISE=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnysZ4ZiCmJizeyd9VlTBCqDq0v74Wjyl5L6Nte
 WEpFgy2FQWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8rGeAAKCRDhuBo+eShj
 d176EAC92okuQDZSk1XM7+G38udeqBTDvkqmdMdhkB266PMkaSfIz9Iz2bxZ6PAXnnZTt1IKuBA
 IqGZ6I5Gy8LWLxWom6gwmXsRJ2zazZ1WwSkGtJrGYsD2AiA0Pc3+y5c7PsbQv/2r4UUo7+lcFwW
 8DkIWS2DGZsglM9uCp05zVVXpX1RJSLciHgBE1TI+UIHyU8pRjOqUGHHX+m4Sszv9ZRlEYgzWuu
 ugQAiVFrWKZsE5NMbfFaEeecfuHHSNTH/lLCg5w/Nsz97pU/pdyFY1weHHJQdYKbJEwuEXlndSV
 rATv5xqzZAVuRTKgcisdbxIJeP7OM0apvIEW4W0pcKXkmKLQiAz2/KmU6u07g9uF3GoRLkj446Y
 a8XMqBnwWkewEsyGh3JZfebXILgM5SwvtxFDUved5TIOYRln4bfAdmiJrcyLCt2jQQCyVCvmTw2
 oascio9OeCCSW66kBdTfuhb1UXALNKKYbyTtJPzhhMtahcgrZxg72EayNfdJtIEBIQkIe6ZOfp4
 qjOUTP8lx68JqmBxN/hzkE1E6gcT7lgyhd99OmNcs3oG5UMBnNX4fdaGacvR16mB2d5wD3b1hDm
 g8CgzNRjlCPt+4DApHIBNmN6fUBd+qt/5CkCwPWzDUGpo+gBy1oI7gFWkqsuuEjxoTovV8RHA8E
 X9zAnASZAEBwQ7A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow the use of intrusive `hrtimer` fields in structs that are managed by
an `Arc` by implementing `HrTimerPointer` and `RawTimerCallbck` for `Arc`.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     |  4 +-
 rust/kernel/time/hrtimer/arc.rs | 94 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 7d7d490f8b6f..bb46602a7749 100644
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
@@ -357,3 +356,6 @@ unsafe fn timer_container_of(ptr: *mut $crate::time::hrtimer::HrTimer<$timer_typ
         }
     }
 }
+
+mod arc;
+pub use arc::ArcHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
new file mode 100644
index 000000000000..5c916489fc13
--- /dev/null
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -0,0 +1,94 @@
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
+    Arc<T>: for<'a> RawHrTimerCallback<CallbackTarget<'a> = ArcBorrow<'a, T>>,
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
+        // SAFETY: `data_ptr` points to the `T` that was used to queue the
+        // timer. This `T` is contained in an `Arc`.
+        let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
+
+        T::run(receiver);
+
+        bindings::hrtimer_restart_HRTIMER_NORESTART
+    }
+}

-- 
2.47.0



