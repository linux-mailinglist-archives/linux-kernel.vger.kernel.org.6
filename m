Return-Path: <linux-kernel+bounces-435529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D449E7909
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E99F1885A35
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A6C215163;
	Fri,  6 Dec 2024 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiOrae7C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6CC1DE2D8;
	Fri,  6 Dec 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513732; cv=none; b=BVDsVSehzSVj/M7fuMYRCHE2u4cM5NYVM2NI0RDxW9eD8bILU6ANcp2XfTpp+nBbtfMzqGznuQRZWueOUc5+2yhbtuoUGc3M8HLGoDCgCcNBJXxQ+d5sYm3goLHGRqIOoMxXMPzMP7/oVrTNoEt+HvDKjg9jfszu1AZc4/m0IxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513732; c=relaxed/simple;
	bh=6WgaFtCFG45ZPn9cC//15Oy/uIkYY9hKr/2/l/u9DGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOUAfQZNgbZYxGww+8+eChcbbLgZ2WuAKyy8GfMdWwxkaeGqbKrr0+uBRdQrXAUC8lGmfg8t+HjPU9K53brIC1fbwxwXYV//0ROZexX5dxOHlvM1tS4FELqP027hHkxIJlARvzTnZD/gWWLwPP/Eb46ozD2fwqSxw0N3Q8e24ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiOrae7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BAAC4CED1;
	Fri,  6 Dec 2024 19:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513732;
	bh=6WgaFtCFG45ZPn9cC//15Oy/uIkYY9hKr/2/l/u9DGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WiOrae7CZbIPyeN02W+XFTSOotrv5Gx2ifXzaNV2mwLShHRiY8bjUtQwnyv5T8eHm
	 AvzeEntjOrHq2hcaZ7dhO+IEAnCNd5KsQbX/HXhQA0waYQHspE4d4Id+t2L6FE/XrE
	 fh8UeTiM8JcABN7uZZJNYbyC3fFqYmNW0N4JuuyMzkzWbIHjveNXToYOMT9fSGOtoK
	 UmIarGB3DSb8iyz5AUb5A8Qr6vD7+rNIOacJ3gElAM8KjrOMFD/lK1N0zwlldLln5I
	 GAEq8ZpjGx7vAwF2Dcug2yKLF7m0nqhmkfIFT1lZRUhgHgRH3n0A6ufEepqtWXq+BK
	 MzdU/aMWEWaiw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:32:56 +0100
Subject: [PATCH v4 04/14] rust: hrtimer: implement `TimerPointer` for `Arc`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-4-6cb8c3673682@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4083; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=6WgaFtCFG45ZPn9cC//15Oy/uIkYY9hKr/2/l/u9DGU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVdzbEVRdG96QUdBTmdwQUNQNHdaOGp5CnB2SDF0QTRNQlBIU2JQSmxp
 amhxOW9rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRnJ
 BQW9KRU9HNEdqNTVLR04zNW9ZUC8xUnR3UWkwTVRxcGp0RVN3WVlqZFVlN09tMEFkTW9KSXB4UQ
 pObU9wSURvVmNaZVpDUkhUWDRla2FKZ1VpakNFSzNBdHFQM3RFckJhQ2ZCZHBRUzVqVjdxQW1le
 Eo1RWh3dmVxClpSZFNXdjJQOW9BNXNPa1RJSGxOVG5scEFyTkJMekVWZ2dveXlFQVN1U1p0THla
 empRbDFiOUYwTmhnbGJIMXAKN2JPditBM3lKeW5MUWJmN1d4RzB4NjVHczg0SVF2eHZubFNsNlQ
 yRTNtck0zSjZtTm5lYmNkdzF6azB4Y1VVRwpOS0FMZmJSeWVURGY2d2JTUDV4ZHBqVHFLSFEzcS
 tXai9FNVR4alk2YldJK1NQd3hKY29Qd1RHaGx5WUZuKzNyCk5IejdQdjRpd3M3bXZNQytZZm5BS
 29lY0tyYVpBNEhNMU9sY212bHNaNG1Uc0tCdDI3eXdYbFdMSFozL1l6aTcKUXlqTHk5ZEhYeSsx
 QlBnbkJRdDBraHorY3Bhc0FxcWplSU1HRzIrRVU5a0MyRUFxd3V3aldDWG5xb200VEFicwpSMmV
 VaHZUR291SmlMNy9CdDgvZWRMcTQ3WHBhT1pBL25mdk1FK0VMNmllUGdQbWJmY1lITzV4OERsVX
 B5RmtMCjEvMzdpS1hFUVlxWEt3cGZ1RS9tY0txNVBMQnZlcDBiZ09aWEN0QmJxdk1zZit0eXRwe
 HB2cExNUEs2dUFzQXYKNDhEQ3NVdXJ3TGpiRHBJb2VyMGdIbnVmMlpSTXJaSE1NWWw1WmRCR2dp
 bm9oMmFOYmpmbWRGN2JKdHFwZUhodQpNTEMwRzlQQUR5L0RockRVRmkwam94eUtCZ2lpWmk1UEZ
 iS3NlZmZ6NFV3WlpBSDlVQzd3VXpyY3ZvSGlkTHFlCnhkU29iUjRHT0JjaUpBPT0KPXNDUGIKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This patch allows the use of intrusive `hrtimer` fields in structs that are
managed by an `Arc`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     |  3 +-
 rust/kernel/time/hrtimer/arc.rs | 89 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 646cd5bfa6623aec62294f9115fbf6fedc0a426c..e76b864f3435667f56ed607fd3bf029317eb1332 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -98,7 +98,6 @@ unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
     /// # Safety
     ///
     /// `self_ptr` must point to a valid `Self`.
-    #[allow(dead_code)]
     pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
         // SAFETY: timer_ptr points to an allocation of at least `Timer` size.
         let c_timer_ptr = unsafe { Timer::raw_get(self_ptr) };
@@ -294,3 +293,5 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
         }
     }
 }
+
+mod arc;
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
new file mode 100644
index 0000000000000000000000000000000000000000..3b256292bc86160a495f7b192b3eda92f2dfcb31
--- /dev/null
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::HasTimer;
+use super::RawTimerCallback;
+use super::Timer;
+use super::TimerCallback;
+use super::TimerHandle;
+use super::TimerPointer;
+use crate::sync::Arc;
+use crate::sync::ArcBorrow;
+use crate::time::Ktime;
+
+/// A handle for an `Arc<HasTimer<U>>` returned by a call to
+/// [`TimerPointer::start`].
+pub struct ArcTimerHandle<U>
+where
+    U: HasTimer<U>,
+{
+    pub(crate) inner: Arc<U>,
+}
+
+// SAFETY: We implement drop below, and we cancel the timer in the drop
+// implementation.
+unsafe impl<U> TimerHandle for ArcTimerHandle<U>
+where
+    U: HasTimer<U>,
+{
+    fn cancel(&mut self) -> bool {
+        let self_ptr = Arc::as_ptr(&self.inner);
+
+        // SAFETY: As we obtained `self_ptr` from a valid reference above, it
+        // must point to a valid `U`.
+        let timer_ptr = unsafe { <U as HasTimer<U>>::raw_get_timer(self_ptr) };
+
+        // SAFETY: As `timer_ptr` points into `U` and `U` is valid, `timer_ptr`
+        // must point to a valid `Timer` instance.
+        unsafe { Timer::<U>::raw_cancel(timer_ptr) }
+    }
+}
+
+impl<U> Drop for ArcTimerHandle<U>
+where
+    U: HasTimer<U>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+impl<U> TimerPointer for Arc<U>
+where
+    U: Send + Sync,
+    U: HasTimer<U>,
+    U: for<'a> TimerCallback<CallbackTarget<'a> = Self>,
+{
+    type TimerHandle = ArcTimerHandle<U>;
+
+    fn start(self, expires: Ktime) -> ArcTimerHandle<U> {
+        // SAFETY: Since we generate the pointer passed to `start` from a
+        // valid reference, it is a valid pointer.
+        unsafe { U::start(Arc::as_ptr(&self), expires) };
+
+        ArcTimerHandle { inner: self }
+    }
+}
+
+impl<U> RawTimerCallback for Arc<U>
+where
+    U: HasTimer<U>,
+    U: for<'a> TimerCallback<CallbackTarget<'a> = Self>,
+    U: for<'a> TimerCallback<CallbackTargetParameter<'a> = ArcBorrow<'a, U>>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `Timer` is `repr(C)`
+        let timer_ptr = ptr.cast::<super::Timer<U>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // queuing the timer, so it is a `Timer<T>` embedded in a `T`.
+        let data_ptr = unsafe { U::timer_container_of(timer_ptr) };
+
+        // SAFETY: `data_ptr` points to the `U` that was used to queue the
+        // timer. This `U` is contained in an `Arc`.
+        let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
+
+        U::run(receiver);
+
+        bindings::hrtimer_restart_HRTIMER_NORESTART
+    }
+}

-- 
2.46.0



