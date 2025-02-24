Return-Path: <linux-kernel+bounces-528981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6253DA41E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA51A3A8FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F20219318;
	Mon, 24 Feb 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1pqX9pT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A824EF89;
	Mon, 24 Feb 2025 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398787; cv=none; b=BJ3qI+zr1+L9h7axWbh11plFnO/YTpRaQUgK8PCQDzJ7xthd5LKe5BDRs0KN8i6VNau+JApq+m38muQrQernq73Ey1mxyMc6rArRAEOWabUACz8r8wExZC/eOwSFBWfAsEer565uWtYiSisUaSofKsJLgjYyBucoWdhOqm4rIlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398787; c=relaxed/simple;
	bh=Cz+PPybrgL3Hjwl6SQDfq7mfUBbxBMfLAxxhdBqy5pM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGnHzmpQX/fAIOShlPvRIKmmAtC37dnuYy5qZbZbiBpp7tdJtDFjWfugeAQJmDMtq35u/771GWlPVCNTgFLlfCUKTLvfECvN221jwatE1LWjprAItBungRnwsp7B9UNg4Mjs9DQApcLHuPfWmvVdCbBRq8NOzvsZHzwPK/GFKqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1pqX9pT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA93C4CED6;
	Mon, 24 Feb 2025 12:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398787;
	bh=Cz+PPybrgL3Hjwl6SQDfq7mfUBbxBMfLAxxhdBqy5pM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n1pqX9pT/mG0mGatUilT03znChbge1Z0gnTT3jXhRsUlvGKW96Cj14v9czRaeUyVi
	 TkC2DeDZNfepsSOq5wTkRxiLeMOMjW+Tzi3BZScW0EPZLVMttmLaWhgLibe2FZjiSZ
	 szwirEyGQM5zd/x6YlZ1JwFA4D+CI4jRYAQYqpbJEB/D/u7dCjTXwsmgqy64A4O5qp
	 l+djFLwn8FiMKxsZV1Xme+XreHL7w6wyzPf+HsI2Dhs5Emm3gMDlE7fD5I2qianWWE
	 mz7ZG8urVRtQoyC8nPNNA5N27qz78Dc2Q7OT74u/7iZymMFYWgABG1QEz+jRG4jLiw
	 /4nPHmX9EbOJQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 13:03:37 +0100
Subject: [PATCH v9 03/13] rust: hrtimer: implement `HrTimerPointer` for
 `Arc`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-3-5bd3bf0ce6cc@kernel.org>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
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
 Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4286; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Cz+PPybrgL3Hjwl6SQDfq7mfUBbxBMfLAxxhdBqy5pM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAe/84kGb1/9Af6ccIKbZAboSmZkU3vH06A1
 dFEhQIc5HmJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgHgAKCRDhuBo+eShj
 dygVEACqHjNH3F2N3GA11As7RSYy6OuRCmqMz27+i7mQL0jxdgDYm2Oz8ztjMyz7JvBc3YNEGLK
 t9XIPFLt+WtVqG7ZqXRrMb4ssDAXEjxcshIOTn/Zp2MwKyE9MxUp9PQaD8KFcJoGVdr1r7B8Lyz
 KAHslxEx6lSZ/t6FlO029DiWy7FnsHmKkmgLFwRwlty5PYmrXkGEhjuSpGACzOxukG8tsU3e9EU
 9jgxgPUc6l2toNS+IVoJarB6BkHCMSscjfJEvzplKrfKM+CfzhgVVfSgXVfhAjZhcKwO0e1GZ93
 yZOm51aLVlHDChT1ey5KmtbIeIR39Otb9jHKu+zBuv/xlYHa8bLB+tBr6B23BsAX5ALpb0e8CXF
 kYoDhfjsd9ihOW77AqUoEYllvh8tUXJb3qevbUU/7IZD8wuQSXBbMajbjMj87DaNYpDUtlBxyxs
 dgx/qrWt70RehG31zmGFYcxf4bKnqecvXhFqfMIB6jXQwks5ANl7h23LCeU0KKHbJq+HPFUPXfA
 4dJxmthU7FmFWZkjNlEZQczdKwGy3phqxYef6yF14Y4m9/LBDajZBWxXNF8bVHfCqlGQVOXoFXb
 ixcjpCvrkMjvCX3cqiXiro5LVFfsnD1Tw+ry+kqPCdj1aQiEVpKLc+OLCzzoqCjDq1TUS1kZmaL
 FsUNsN2E8ThBsrw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This patch allows the use of intrusive `hrtimer` fields in structs that are
managed by an `Arc`.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     |  4 +-
 rust/kernel/time/hrtimer/arc.rs | 94 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index fe20405d8bfe..d08fd7de158d 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -143,7 +143,6 @@ unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
     /// # Safety
     ///
     /// `self_ptr` must point to a valid `Self`.
-    #[allow(dead_code)]
     pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
         // SAFETY: timer_ptr points to an allocation of at least `HrTimer` size.
         let c_timer_ptr = unsafe { HrTimer::raw_get(self_ptr) };
@@ -345,3 +344,6 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
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



