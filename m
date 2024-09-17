Return-Path: <linux-kernel+bounces-332132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2256A97B5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E941F25C22
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A511991D7;
	Tue, 17 Sep 2024 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3XLPuv2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5736D19341D;
	Tue, 17 Sep 2024 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612176; cv=none; b=s1FM3Rzz7rl45Om2iMwMYXfk54hA5rq3YUxXi6UIFHydSoo/zXf3A6/aHdzqzPdA9l0RsCzcfnjuTt+3kXRNAoZsFTBYAwFgKiLQZfjS2u7hzyqvp6PrqG0y27qA7pfO3T3LJDiL2otE/gM8FNM5wZNJJuNAopJYsPwFxPH1ilY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612176; c=relaxed/simple;
	bh=4ztTKZJklMZuWdRnDRwNkRp6CSHy/hhu2f7aimDKXJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvSMvkgMsDGDnbVRb1skFLgQrMLoiKHXkJtcZBFbDhxalcdHF1MQ2zO4h7CL6h4d0wjoDvaVD70islTXB7oAiCYY+4agIXolP5wQ7/bkMxJJhy1eQKKzedG89D3jIG4tQlU1W1lRljJ/sWl0cawJFPCBvosND87wESZ1lwKV7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3XLPuv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61473C4CECE;
	Tue, 17 Sep 2024 22:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612175;
	bh=4ztTKZJklMZuWdRnDRwNkRp6CSHy/hhu2f7aimDKXJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3XLPuv2ar12ModWf3DiizJ8Z599hiAF+yiF9UB7nitasdYp2jDNvkC3LLScFSae9
	 /WEZRYNNqDdechJiB6rzsYbQaOpZAD6zmLCj+86XiSkCkV9YEVAtcaK2sveoknTyfz
	 6wVtP2w80SRxOngRNVdRQyrWdIvk7m+m4kePNTp+dFBKH/q77kqlVr3b2JToSrE/DN
	 L8fCkLqzAFrYZ15qlLW+5az1Tuq3cTYVVlXbFEzOyQepPZLH1mE/GVBCEtzC5FV2Ws
	 8GOlDpItFqPp4VIRmEIoYQ5T8geiBjLduKMybuKuT1/wJ1ym1kdjEbCyKstBrN76x7
	 JaGNnity8I37A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/14] rust: hrtimer: implement `UnsafeTimerPointer` for `Pin<&mut T>`
Date: Wed, 18 Sep 2024 00:27:33 +0200
Message-ID: <20240917222739.1298275-10-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4089; i=a.hindborg@kernel.org; h=from:subject; bh=4ztTKZJklMZuWdRnDRwNkRp6CSHy/hhu2f7aimDKXJE=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWYzY3B0V0RFR3hYTjRVUk9DNEdONUMvCnFaVFZJZXFHdzlzQTJqR1B4 WXpDTG9rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSDl BQW9KRU9HNEdqNTVLR04zVzk4UUFLN1Jodmd4SmRkeFl2QlVMM2JaNXJ6S0ZGNSszQ3Q3TS8rSA pGdXJHVFlXMFdqK2lTekFXclVmdlZBMFhVNEY1UzFmNk9rOUtVWXpUT3pMK1huRjkzV0JrdWhaY 0RSUVJ4VzVOCkk0NWlMSzdadHVYNjUvSXovd1U5cWM5S2h1RGJ1VkY0TkJuQk1PbGRaaGZHTm5T b08yYXQ0bmNKMzVDQnpmQWgKcXIrbDYyZzdXUU5aK25oazVNK0cxTnZtWi9hSk05aWw4Mno3NWg 4N1FpQ3BQZ09FY1o2QndoVzNhWkcyeVNsYQp2WXRVa29ySHB2OEgxaVdOWWg1MU1pYmhoT0Nhbk k4cHQ2SFk1YzhhbzZlaW02TXZCSFlGZWNST1NHSExjYmM4CjQ3WVBRR0o4bG9ZOWJXZy82dEZrc W9DaEpKamYvRWQvWEQxdWo2Sk9ibzVGckxkc0trbjk5d2Rwa3B6MDJJakEKSWRFdVV2cHRlclVw Tm0waTFOMjZKMkpaeWx1LzdjajlObG5mZ0l3Z0ZCaWkyb0JaV3JZTEVYTEVWNzg4VjQrbAphOWJ lTDFrQ1VVcXZQcGc4Q
 3h2eTZiVFV1bnJ1WkRkN0pMMXhCclc0b3pYRDl2RENHQ29hMnhibTZ2OH JNckRKCkVDOWtoQlFpYmkzRUc1SXBmQnlVaENoQnY1dEkrOWhIRzRsNGtSQ3JqcjMrd1FrTHRId 3pvWEEyOTlib1hnbEYKVlhYMW4vM0JlWFRwYUJHWU9idmc4dlVrYWFyVWlNZXA2Wi9hZCtSRWta ZDB5MS9CZzJRS3pEbThxZlN0c2VVTAo4MDAzbHZMMGZJUTJ6NjZKMG9YWk03THJBU1dRb2lSY2F keDJ0YkpybzdxeVNBRkpKNUF5WEVwNE5aWk5qOUN3Ci9hRXhJek0rb2dvdEJRPT0KPWxYWjcKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

Allow pinned mutable references to structs that contain a `Timer` node to
be scheduled with the `hrtimer` subsystem.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs         |  1 +
 rust/kernel/hrtimer/pin_mut.rs | 98 ++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 rust/kernel/hrtimer/pin_mut.rs

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index 25d3702d0d05..09fb674993c2 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -397,3 +397,4 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
 
 mod arc;
 mod pin;
+mod pin_mut;
diff --git a/rust/kernel/hrtimer/pin_mut.rs b/rust/kernel/hrtimer/pin_mut.rs
new file mode 100644
index 000000000000..e25c7158ae4f
--- /dev/null
+++ b/rust/kernel/hrtimer/pin_mut.rs
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::HasTimer;
+use super::RawTimerCallback;
+use super::Timer;
+use super::TimerCallback;
+use super::TimerHandle;
+use super::UnsafeTimerPointer;
+use crate::time::Ktime;
+use core::pin::Pin;
+
+/// A handle for a `Pin<&mut HasTimer>`. When the handle exists, the timer might
+/// be armed.
+pub struct PinMutTimerHandle<'a, U>
+where
+    U: HasTimer<U>,
+{
+    pub(crate) inner: Pin<&'a mut U>,
+}
+
+// SAFETY: We cancel the timer when the handle is dropped. The implementation of
+// the `cancel` method will block if the timer handler is running.
+unsafe impl<'a, U> TimerHandle for PinMutTimerHandle<'a, U>
+where
+    U: HasTimer<U>,
+{
+    fn cancel(&mut self) -> bool {
+        // SAFETY: We are not moving out of `self` or handing out mutable
+        // references to `self`.
+        let self_ptr = unsafe { self.inner.as_mut().get_unchecked_mut() as *mut U };
+
+        // SAFETY: As we got `self_ptr` from a reference above, it must point to
+        // a valid `U`.
+        let timer_ptr = unsafe { <U as HasTimer<U>>::raw_get_timer(self_ptr) };
+
+        // SAFETY: As `timer_ptr` is derived from a reference, it must point to
+        // a valid and initialized `Timer`.
+        unsafe { Timer::<U>::raw_cancel(timer_ptr) }
+    }
+}
+
+impl<'a, U> Drop for PinMutTimerHandle<'a, U>
+where
+    U: HasTimer<U>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+// SAFETY: We capture the lifetime of `Self` when we create a
+// `PinMutTimerHandle`, so `Self` will outlive the handle.
+unsafe impl<'a, U> UnsafeTimerPointer for Pin<&'a mut U>
+where
+    U: Send + Sync,
+    U: HasTimer<U>,
+    U: TimerCallback<CallbackTarget<'a> = Self>,
+{
+    type TimerHandle = PinMutTimerHandle<'a, U>;
+
+    unsafe fn schedule(self, expires: Ktime) -> Self::TimerHandle {
+        use core::ops::Deref;
+
+        // Cast to pointer
+        let self_ptr = self.deref() as *const U;
+
+        // SAFETY: As we derive `self_ptr` from a reference above, it must point
+        // to a valid `U`.
+        unsafe { U::schedule(self_ptr, expires) };
+
+        PinMutTimerHandle { inner: self }
+    }
+}
+
+impl<'a, U> RawTimerCallback for Pin<&'a mut U>
+where
+    U: HasTimer<U>,
+    U: TimerCallback<CallbackTarget<'a> = Self>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `Timer` is `repr(transparent)`
+        let timer_ptr = ptr as *mut Timer<U>;
+
+        // SAFETY: By the safety requirement of this function, `timer_ptr`
+        // points to a `Timer<U>` contained in an `U`.
+        let receiver_ptr = unsafe { U::timer_container_of(timer_ptr) };
+
+        // SAFETY: By the safety requirement of this function, `timer_ptr`
+        // points to a `Timer<U>` contained in an `U`.
+        let receiver_ref = unsafe { &mut *receiver_ptr };
+
+        // SAFETY: `receiver_ref` only exists as pinned, so it is safe to pin it
+        // here.
+        let receiver_pin = unsafe { Pin::new_unchecked(receiver_ref) };
+
+        U::run(receiver_pin).into()
+    }
+}
-- 
2.46.0



