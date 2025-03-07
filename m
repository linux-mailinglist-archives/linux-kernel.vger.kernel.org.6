Return-Path: <linux-kernel+bounces-550852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D2EA56501
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD5A7A55CD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BDF2153D2;
	Fri,  7 Mar 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHuhVvlO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEC0215187;
	Fri,  7 Mar 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342703; cv=none; b=V4KZ17YVuD0XrZcUB0p0D01h877cp5nOcecB+pUgaIbS21gXV8zWEWjCPKh/3Sc+oMEqZQG+WEDLZrkoRuwKZc65VNkkR8jZiAFXXXh/vecjLl+/0kEougMWHbfpTxVbb+ZYlAFWTm2hEVKMemYF9CR1TQDvemYWAsViyHXIs7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342703; c=relaxed/simple;
	bh=gNsKwdbFSuabCqKH8ccREYgS407FI4XzDzED37AEbfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WPQkOgHVVXk1r9N2gXuVFkodte8HJ/ibHyEVYhLW4Sjk6mmjfkN9gYNwN9ri1ntzPD1bpjVSiCJsJcLlZ1sOUEsRYX//1TdyTRIaV6nuJBl34FJGan6AYc8nin0L8fwIaPR9y7n9vLDz+q3GbMAl75nxqaTmmyCBXc0RsDOGZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHuhVvlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FD6C4CEEC;
	Fri,  7 Mar 2025 10:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342703;
	bh=gNsKwdbFSuabCqKH8ccREYgS407FI4XzDzED37AEbfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YHuhVvlOkFMFagYRPdJyIPlUDEL/SZ9sEBoZAE5stK8eFK3wKsVmG4nYH5P9Mtcrg
	 8SL/aViFI2KR7Bk5QNnUZ2/Gf7QiH6E3lggDYbgmashec/vN1TcxgXyX150NohcvQ4
	 bBqgcdWxVU7uKy4UaqaXClpECJBxO0bqI/wmjxsUQk8j488cstInSu5UruvcSJ+WFQ
	 TzzC8WMNMtdN1+x7MXURfqdhWJ4hPRFBrQzjzJyumoz1W1OFNWTbEnxfDkEkv/kWDA
	 ZrWUuogs1Pm5PwxTToOkgEIXiyKR88hA9eKy2bVapsz+hiQwuWW9yLI7R0FDu6i/fH
	 vJLyLdw1RpJIA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 11:11:53 +0100
Subject: [PATCH v10 08/13] rust: hrtimer: implement `UnsafeHrTimerPointer`
 for `Pin<&mut T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v10-8-0cf7e9491da4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4542; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=gNsKwdbFSuabCqKH8ccREYgS407FI4XzDzED37AEbfA=;
 b=kA0DAAgB4bgaPnkoY3cByyZiAGfKxn2h5J6NdXwPYESfjh5fSCV/8zKwaUY2tfd++y/WzSTtp
 okCMwQAAQgAHRYhBBLB+UdWv3wqFdbAEuG4Gj55KGN3BQJnysZ9AAoJEOG4Gj55KGN3YQkQAMcC
 x4Gj/QtjopDPjfRtszw8ZsrtfeO1ziUgtxmAM072F1tfVm3dg2FIXWJNFT9P9tc/znXFnUq6CRK
 EsH7de2bDgn2ZXjOyKOViyf0HQBgRnqslX7nKsqMl1j54eoUpnAXV5RrK9SEsbBEVkDebMw52xc
 AVHXDX9/PrrrmSkP71B2GTxlDTlUIuVTe5d2fCv3PJUdKK0VlX4U+6V8ZCzhu1IzZG6isaxgU8j
 co2ySoofBtF5G8Ghwdn8nh5Jn1SgFSVR6NDfdgZlUZx2n1MtWpYwHMm7eqMzkR6E/KWs17V2veb
 4MKI+bN9pUN2dRPHNxBiaVIJ5x2NCTVfVbwwe1GoWRya5o24FUSIXCcrs17Lju6ZoHPFDHbY68E
 N51iO4QhYxPVLy1Rj07D5xuSuWiRum8WkSTQZMWi1xGH8R2/O6Qm0nF7uN+H0YKa44bOMfPXDWB
 KA5+rHl/RgahSFEvkn6uZd19CcjfbgoAZ942RsoNJaUREj1bNRS/6mdJilKrPCMLWUBBVFaGqH6
 DVQTIYLUirVIdGioBo1dUT/hPGa21R8rw1d/A9fc8nIUW+KbiS/O4fFUQOZdeSVs5L2XqRBfx6+
 brHJBGePfc22VjsJzjxvzXwFcGAJgKBDiuXLM75w3zPZyEZtr/ZRLUShdz4hWj0yhhtTVaJ6Qc8
 08rOU
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow pinned mutable references to structs that contain a `HrTimer` node to
be scheduled with the `hrtimer` subsystem.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs         |   2 +
 rust/kernel/time/hrtimer/pin_mut.rs | 101 ++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 2ca56397eade..d2791fd624b7 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -441,3 +441,5 @@ unsafe fn timer_container_of(ptr: *mut $crate::time::hrtimer::HrTimer<$timer_typ
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



