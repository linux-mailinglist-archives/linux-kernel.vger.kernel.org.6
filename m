Return-Path: <linux-kernel+bounces-550856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72A3A56506
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D26F3AAE70
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193A1215F79;
	Fri,  7 Mar 2025 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtQI2vyw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC09215076;
	Fri,  7 Mar 2025 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342725; cv=none; b=cdy4HhofP7/klX3P5v8OIHiHAAS/CZZNoTsAFGaR+yNIT45vpxjyfCEaphQxnHG4xOpj4DtU0Pz6/RBWXo5D9xIhiQ0844CwnpeJwI2RBB6tPixmxF7jvwHHnmYAUH5pAg8TUtcWWKHDupbWbhdhKWMhjs4QmMk9kMicSrAXRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342725; c=relaxed/simple;
	bh=n+S40PGtViHCqq08Ofci1IJnKPyB8rSLki0NyHPQeM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p2S5noiiGJAEhgw8Zmc79opawIDhovyfkQ3zrqClgDeGlIozEn5v0TcPOwpvz8WihMsnnWlClmaPNqchNZDgwQCaYEyIQ9aTohWyjgEkdGghyh8EpQHZkw321QfQzprRnUXJkHXjI4aW0XIGi+nN6zSr1C0pTZJT25x0TJtfrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtQI2vyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F0FC4CED1;
	Fri,  7 Mar 2025 10:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342724;
	bh=n+S40PGtViHCqq08Ofci1IJnKPyB8rSLki0NyHPQeM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FtQI2vyw+hVjEBfvc6hvvXgFPjzcbVPehIW6FDZ8n1paEtNvd0liZAfut8LLKkURM
	 /5I1/YclMuJirnF/s0z60ov4WmD6K7SUMQHPGrnOLfe2/UJNhL4+cG4Ks0PzA5Bs4R
	 Ab/850ZCPoHZgVeJUucJbJ8WxK96DOQetsYuFdXsRPGkcU8flQtRjr9iUDJ3cfcY93
	 5XgQPezPDz6nCkGGsD1aTZTVylOVGi38B8Ihhj3DqqUgcxZY7N9yvzzEE/qfgtTQVs
	 totZCklown4rifCttsfIxzqB4NIn3xRbHdvCu2yC1OIqmSXl6xsRDYId7PZx9Ke0CS
	 TBL97jCOLf3Vw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 11:11:52 +0100
Subject: [PATCH v10 07/13] rust: hrtimer: implement `UnsafeHrTimerPointer`
 for `Pin<&T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v10-7-0cf7e9491da4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4292; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=n+S40PGtViHCqq08Ofci1IJnKPyB8rSLki0NyHPQeM0=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnysZ8Ou/uVpoHJ+yR4GNdpX1ruFBP3oLWgRI4Q
 ow6FQKXokKJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8rGfAAKCRDhuBo+eShj
 d6ueD/0UtGzxDL1GVrKsJVfa6T2/kiyrXDvxiVimZftFk6HiWn1yF9uCHDS2//WeOeJoYx0jdZ+
 xgDForBqlpcZerdqKZw399emRnO+86OYIzsa3rmB7vGDL+YJAHDC8HnMYjO6o+WNU7hhMuiKltx
 y221/iWiQ/SZ/E9dxGskTIQjG5SxJd4lqkY9c6525m4ONnMhm8+IkjZgBpbxz4ae37xp7p1Po9R
 KnNX1IAD76B2bnCPI4SZ1X0Umlu3xiGV7wNhWUiijAGsp4htwUvc+IN+kvpRvUbFDJiWUSEO6AO
 amgvkNEPn/b+xwn77ID3Y9NtK0fPxbngpliogWtId5rr9rAIXmp8to9NShO8YGPepVAqYE+ayN1
 g/WYylRPG6o0VfO4YC4YcsVOEiY23xjUdDJZ6E3fqWJUP9n/41AW5KJhONXEo2T7gLrx/Uy4ii7
 xIIJMcECUCmadXx1pypNxEoMp6nBX0KoLbHRr8uiMEtei9OpNOLPXZjMvaEo1i6oq7E1vuk+qoc
 BU8oG/6jk0zFv17HGWGq0Lcie/Mh8t644vN1+V5SFcNqkhkPkpnLO4YhoixKzZ7e7WasrJDv1kr
 WcD0BJXgoqP1buXMwzX57XiFVRuA9nh9tktjOZFzo5dQonGeLnBg9qGq00ISfI8PDicMFsNNsal
 bOm7pCz6Qm9lsgA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow pinned references to structs that contain a `HrTimer` node to be
scheduled with the `hrtimer` subsystem.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     |  2 +
 rust/kernel/time/hrtimer/pin.rs | 99 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index d90a25785f87..2ca56397eade 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -439,3 +439,5 @@ unsafe fn timer_container_of(ptr: *mut $crate::time::hrtimer::HrTimer<$timer_typ
 
 mod arc;
 pub use arc::ArcHrTimerHandle;
+mod pin;
+pub use pin::PinHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
new file mode 100644
index 000000000000..6c9f2190f8e1
--- /dev/null
+++ b/rust/kernel/time/hrtimer/pin.rs
@@ -0,0 +1,99 @@
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
+    Pin<&'a T>: RawHrTimerCallback<CallbackTarget<'a> = Self>,
+{
+    type TimerHandle = PinHrTimerHandle<'a, T>;
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
+        // SAFETY: By the safety requirement of this function, `timer_ptr`
+        // points to a `HrTimer<T>` contained in an `T`.
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



