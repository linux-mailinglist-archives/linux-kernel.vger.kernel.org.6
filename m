Return-Path: <linux-kernel+bounces-528966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC32A41E84
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212A07A27C4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A5B2571B3;
	Mon, 24 Feb 2025 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnA9Wtsi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8812571A0;
	Mon, 24 Feb 2025 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398731; cv=none; b=ltd+dH2+EqGAv2hVveuzO2PaZNgt4ZZTnNOhoB/LwhbJOrMtERndDwfIhJs0gBmYfGm+cmOFDNyRkg8c9G2hZR3vixuib/gnW44WREWLEXRNhgKDymORHnfSwA8lDHYDdEQOgysGRuojeTO8IPmOai1CHil5ByxvOAGtnpvo7ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398731; c=relaxed/simple;
	bh=+j5W9iNg5qA4s2ao7e3w2gC8NaVgZMD/chrZEXGXXxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xn+/ras7SSn8ApjNf847MX/ciHmIwY4UmowfAMusc3EMKyoJ0m2SIWGcEbDRkYFP3fdrrxO22NDsJyE5GwYeiLiTOYa591dj4KfjbHe0bgQV9dRvc19SlSCbLaNax1eYZYlR9UiLGVNN6lGwr5k/XZOSNhXUUcsq7Jk1WJ8vvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnA9Wtsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC83BC4CED6;
	Mon, 24 Feb 2025 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398731;
	bh=+j5W9iNg5qA4s2ao7e3w2gC8NaVgZMD/chrZEXGXXxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MnA9Wtsi04Oovc2JkfVw1wa3nsdO3U+h3k8gS0/dkzUuxXibR9HA4GjxYZ19GM3CW
	 PU2xHLp0kOfcDcbIKc47SB3dWRBlEOZeXip+QVaBGuHFIYBQkQe2L9GvhkTeFMUvze
	 EzX7/8HtpUZ5hnUVC1v7or+AHb0Vhd5ye42XbEGMv7SfgMKNuPDza6O0irhE9w3onz
	 Imi1iDKwxZ/gglQwiU+u7Cl1h+CC/T1OhP2gDdSbacEB8eqaywm+kLwfWywmx9GdvZ
	 kwDVkprmHvbUrxljmBeUaPECbsJbM7sufD63Yv0MLVF+eES3wWNVgq3w3uejONLIg6
	 e41N8ef/ncClA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 13:03:41 +0100
Subject: [PATCH v9 07/13] rust: hrtimer: implement `UnsafeHrTimerPointer`
 for `Pin<&T>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-7-5bd3bf0ce6cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4212; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=+j5W9iNg5qA4s2ao7e3w2gC8NaVgZMD/chrZEXGXXxQ=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAis0fH/72lIovOHz/fg8NTAbiLn84YI7qON
 7mBf47d23mJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgIgAKCRDhuBo+eShj
 dzcID/wNJ+tA+eRLsh4tDs7Ep0qdqpxvbkvq4Ji+Hts+9TPFkiuNiTLkfeOXJA3Xh023xisTE6u
 Mbi19Ayp4B66zxCJwdD9CZpdbAIg/+uUTWUaeT0vIGae5+WTAXZ2sVX1QF7YF8GoCNRJu3t+yGm
 T3c1MDCLlfrFa1K2zIZkHqjJyXkuFO6qeMa6FvFmIXH6pOa3jI+HgIvikJkhMX1JhY/8RRh88LH
 Ih5fiZtzyYHaL5vsA3fraeDCXkHUE4mzMwN4B59Up6BTHWWFaljTvBMFecUAJ09kZ6tnvnmkomh
 Sart3WAdBxQIgs7U4YnDQtQN90jjg0LX0UC+mWuhTYQP9bqoR/ZbALgdD4k5d1g7Q+a2TYJC5Jf
 YN4+cTNHjuHmrcOFt4LvRGev5Ru/0UWIjlce0mXRXvGF7pIgo1ysBWGtwh7Cx2fq7Y/sXLXrj1r
 ZDiBqUWMFu+S8VDRiksUzopVgcTnkZCBq1Y6x5tmi4Q1IVwEjQwN7SqYpl7LO7jnw/Fi8tK3FSK
 piH8TvWhShtvhA39xzSII3SgdssfONNJpBab1G259MRJuxyWHehOi89WuoXsTcVaVu8qqp5zFbN
 e8KJNcw2NWtS/V00blwUDvTxhZHKFaRDcVGy0fpzjasB8j8GDbOLiNwc8Zz5d52xRAgn+p2bZD4
 taFAhqNzD0x7AlQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow pinned references to structs that contain a `HrTimer` node to be
scheduled with the `hrtimer` subsystem.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     |  2 +
 rust/kernel/time/hrtimer/pin.rs | 99 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 64b769ad59cc..52a3dd1c3984 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -428,3 +428,5 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 
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



