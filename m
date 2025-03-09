Return-Path: <linux-kernel+bounces-553189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E485FA58557
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B573A20D9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977211E04BB;
	Sun,  9 Mar 2025 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgQBcpyz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72401CAA93;
	Sun,  9 Mar 2025 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533766; cv=none; b=SdAuAzL7PcW7ZaJmKXHGgT1wcRgOZ2gfnmSxcfOjYFHnp0bQ6gMfjc6j4yb0nxq61caEmiIudQbbuGlxEX9DD3cv5zSN+IdAp+n5zdxvqsW+Gwct1iSgQ3e7qvM6mNH5jwX9CH6UUgAH/G8K3uzLM5yPXkrBmkNj+gHgJ16150g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533766; c=relaxed/simple;
	bh=xw2lAfKBPsk0cxwZygCBVdqZbLCzth76URvjiDmFDxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jv93FMohw+SSa9WcOBXeNgU8MHhvShlioOkKFC7uo0ujsOXhvC50AkUyqLI5WToAAwZsbZb95I2KAWE75YcrgzXw/oOrBlZxC6jiy//aNtgRiYNeK6wOiYqsS2jxv2H6bVvgK3G6a5sKpHHBVY+TMIDqLBxYYcko7QTrqkvP2wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgQBcpyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D130AC4CEE3;
	Sun,  9 Mar 2025 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741533766;
	bh=xw2lAfKBPsk0cxwZygCBVdqZbLCzth76URvjiDmFDxM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jgQBcpyz/mn3/uJgfC2UTClx2C0eAh2ALFyDr/XuRu2/R3VOsso34b6se8zm1GtBe
	 jgTJFpZqURNDJQGUrJR750ObGQ4FQEGp7Oh1Z5GmYoD4nHrWJ8DDQvnM35E5YNEj4T
	 xQD7FOPf5tt91Ki9abZlAg4zW3vPhrE6PsGcLwwu5gixlM+2pFtXEqU3NHEfLRlRvO
	 5exdSsjOLFqKXHwmGl21vttECHyv88c4sOYrTNZDdv/ckfHdBuiL1hYc2OufZ+NNg/
	 1szKBdwUCNZF0fWqd4Nehf3fcc6GzEacPZh2axlFlQQ9RiViSUiJw3juqTnWfIHOGS
	 RgTFFEKrE3pyg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sun, 09 Mar 2025 16:18:58 +0100
Subject: [PATCH v12 07/13] rust: hrtimer: implement `UnsafeHrTimerPointer`
 for `Pin<&T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-hrtimer-v3-v6-12-rc2-v12-7-73586e2bd5f1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4581; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=xw2lAfKBPsk0cxwZygCBVdqZbLCzth76URvjiDmFDxM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnzbFtZ312wCzyv7F8m7L/M6Yd3DrbjcxrC+HOe
 GQ2Te+/wxOJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ82xbQAKCRDhuBo+eShj
 d7dNEACfIpNfV1Orb6Xs6ljA3Gg1EsoQ6z0rtWQ85uUlIuzOo06NakwlNPcXsGBAvrdzcoabOlZ
 TfGlQTTBUW4BLIvSjHRLwJTafQKu30mw5tyvy5mCOywJK3Lo5rzNP1e352F5EWHFM2WQiwdDI4Q
 NwPN9wOQN1iBmL39ypfZKtPnC1ocMWTIgEA/sKkczTwqby7yMdlD+615d4bwre2PIcveL+8cfoT
 omaFGZwbL54wS/RXkDk2aDVmuPYTTwuYcI58md6oNezKZp4DJiHtaU5UGWNonGh8+UIp2vmMwsy
 f1m5D00Igg4UnAP1B+LW5kGllcdT3N3asAJNnx9i8iMhKFryvgbbH/ye+MsEUgQbYDjBZo1f4vG
 cEEOUeCA6gomiL+JQ+NpZ2bXckbVJDBW4FU+55U+piKAZgzGEh25Oyl4FOrcDViHZ07/CVbUISK
 GRY7fzbc3Fwy92NFklm5DFumROezEeba52wsmBjLOrbdLDXVHt3UUfk+HnFC2sa/QfxT7OQ0qnE
 wvZs4w14Tng2tqtx+Q5kxIFWbqyNZP5FhvN5bPhU1avrky2u2hJ1sRdBgRlwSH+LizzB8/NCASN
 FuQa5ESo1CEVX/7CkYkIubEAOUdHWiP483P3xDCQiFHvf+GvGEVj9m+NkrJ/gi78F4Fht2xRF0o
 hZKipbC42CwfNZg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow pinned references to structs that contain a `HrTimer` node to be
scheduled with the `hrtimer` subsystem.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     |   2 +
 rust/kernel/time/hrtimer/pin.rs | 104 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index f9b2323a305a..abcaa505f7d8 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -432,3 +432,5 @@ unsafe fn timer_container_of(
 
 mod arc;
 pub use arc::ArcHrTimerHandle;
+mod pin;
+pub use pin::PinHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
new file mode 100644
index 000000000000..f760db265c7b
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
+        //  - As per the safety requirements of the trait `HrTimerHandle`, the
+        //    `PinHrTimerHandle` associated with this timer is guaranteed to
+        //    be alive until this method returns. That handle borrows the `T`
+        //    behind `receiver_ptr`, thus guaranteeing the validity of
+        //    the reference created below.
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



