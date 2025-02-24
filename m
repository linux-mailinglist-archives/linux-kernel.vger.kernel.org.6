Return-Path: <linux-kernel+bounces-528978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D78A41E92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71153AB658
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B6A248892;
	Mon, 24 Feb 2025 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0y/+s5S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D93248879;
	Mon, 24 Feb 2025 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398782; cv=none; b=EhykUhQvkAKzuXArPRJlM+WhWDBYN4ZrOUU6k90dCvmML+r9cNtJdyGibOhyCJnCPac6zu9tnH9FFMQKOaG+Pwcesaqp7eAh7GA/x70OoxzF3oC4RvjlIUc1uf/MhkMVpfDRHukUMXSYY/sl5fImyZ1uaZV0+sl2WTaQ2wxUsRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398782; c=relaxed/simple;
	bh=l/WE/Iyt5IAfurnrT002wpnh8ahQZE+ejk/Q/RlMt6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxZ01htkZ3+EcUr4bfGIGbT10968/KX1QM3NfGIo3tXlTvlpqNo4jnXdBjuN1d8z5biMQM3ij7wbU9F0b1Xm6YbqlKfAo1RkDGR4pOQ+5KzMFteuhLG5+K0Dx4Y2eL81U0mm/OIcnr3bwWvcpLuFIrWh1GWaJ68dRsnAb+pyXlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0y/+s5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8055C4CEEC;
	Mon, 24 Feb 2025 12:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398782;
	bh=l/WE/Iyt5IAfurnrT002wpnh8ahQZE+ejk/Q/RlMt6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B0y/+s5SPe5pWrYPKdhk/v+Ph52JXnqurNOEx1JJtsKRBt/2kDSSojN1Rg+wRoMwT
	 t4Bsq9054Nf3l96xuwwp91oDn6APRQ9m1eo/f53RIeNvBzM85zTp+zQln479RK0IG0
	 Okn9c7CueCCfS/cE+rAGTBtpJdIc1e95Gedeg01LaOJCB9fVnKs/lKlyt8BifywnhF
	 756VLOjNuIugYul2aG3BNmhaaeZLPXtVHUWbgNqaVx9n+hJ0a9YOp3q3AoqUMO/3xE
	 kiWO/o1wVF7jnBE8VxRbD8u3WXUJTYJAf3Z0MhdtqBfaPpusHMJgTBExXO2cwfQXAa
	 AwMDA9Y2d6NYQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 13:03:42 +0100
Subject: [PATCH v9 08/13] rust: hrtimer: implement `UnsafeHrTimerPointer`
 for `Pin<&mut T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-8-5bd3bf0ce6cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4462; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=l/WE/Iyt5IAfurnrT002wpnh8ahQZE+ejk/Q/RlMt6I=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAjmeNKjyJa36N7rTzlZdrLwwpDVBGIaBQch
 xCGBItaPaCJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgIwAKCRDhuBo+eShj
 d5f0D/4zOL9VmopzOXR5gnUKJoAo8ZBhlCNY2HXwpt/ay47V6RaSq4RM4A9LBogTpj9hWWTAJJU
 bYa3tQZpOpI/oZLVuLNtRHeguAb2/TyCsbYgB0SpCuF48j3tdgwx8OmL/Ff/0jCBXRHsCRVuKkF
 hrWd3ovIh72D9V8F8uwLWENgzBWj/bxJ+eaGw3tBqCqyoB/qf5tMMQE9zBEuhm7STA3cUjLST1Y
 Fem0rCvUv74xb/YlQ14iO0+aCcBYPpqHt3aFCaqcZggFMQEZVS84pzemRp/BPNggZoOFt+Afy8J
 A9+Ux0GjXCy/ej7VlUdRGLUJ+p1KcP+nNFUy7OfadOXBEQfTjsby27831n4vPMQcJOmNFlfIwTH
 aVMu3iBgs8GyrgM8/zQ22FbMMi+m63oWo0GD6jnt8wYSbrbb1crk6NIP7YpNWwdh5kxQluDk1Ru
 iKBTOIla+YVWnuB2molUI2oW7AaUJo1EjsTi1b6p++FBke7jjTM+OxbagZhivnr0eGykin7tsXA
 qrnzsawLveGpByZjCxD1wwHJsD9HZazlPu8xgW2G7Zxgin/BDvqa5UUfxvJnqRY6lyO126CICDs
 QIp3+5dpNL+9nyaYwNl5mSYgID9gad5DEE7Bb1Jwad38tdtlpAITyRjpc1VqHa7+uSFcpesuvbm
 NfO1W9xuXdaVm5Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow pinned mutable references to structs that contain a `HrTimer` node to
be scheduled with the `hrtimer` subsystem.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs         |   2 +
 rust/kernel/time/hrtimer/pin_mut.rs | 101 ++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 52a3dd1c3984..07b19699d4e8 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -430,3 +430,5 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 pub use arc::ArcHrTimerHandle;
 mod pin;
 pub use pin::PinHrTimerHandle;
+mod pin_mut;
+pub use pin_mut::PinMutHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
new file mode 100644
index 000000000000..4f4a9e9602d8
--- /dev/null
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -0,0 +1,101 @@
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
+/// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the timer might
+/// be running.
+pub struct PinMutHrTimerHandle<'a, T>
+where
+    T: HasHrTimer<T>,
+{
+    pub(crate) inner: Pin<&'a mut T>,
+}
+
+// SAFETY: We cancel the timer when the handle is dropped. The implementation of
+// the `cancel` method will block if the timer handler is running.
+unsafe impl<'a, T> HrTimerHandle for PinMutHrTimerHandle<'a, T>
+where
+    T: HasHrTimer<T>,
+{
+    fn cancel(&mut self) -> bool {
+        // SAFETY: We are not moving out of `self` or handing out mutable
+        // references to `self`.
+        let self_ptr = unsafe { self.inner.as_mut().get_unchecked_mut() as *mut T };
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
+    Pin<&'a mut T>: RawHrTimerCallback<CallbackTarget<'a> = Self>,
+{
+    type TimerHandle = PinMutHrTimerHandle<'a, T>;
+
+    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle {
+        // Cast to pointer
+        let self_ptr: *const T = <Self as core::ops::Deref>::deref(&self);
+
+        // SAFETY:
+        //  - As we derive `self_ptr` from a reference above, it must point to a
+        //    valid `T`.
+        //  - We keep `self` alive by wrapping it in a handle below.
+        unsafe { T::start(self_ptr, expires) };
+
+        PinMutHrTimerHandle { inner: self }
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
+        // SAFETY: By the safety requirement of this function, `timer_ptr`
+        // points to a `HrTimer<T>` contained in an `T`.
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



