Return-Path: <linux-kernel+bounces-449447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA45F9F4F42
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631921881B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE951F76A8;
	Tue, 17 Dec 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1uOa9Ui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEDC1F75B3;
	Tue, 17 Dec 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448767; cv=none; b=eYUhYxGTctW6kiljqFIyQQQ0+m3B+npisDAGnvz0bSKQYw9W3X1UJuI4/6IUiQ2H6xDtOAu0z32/uHL7CgxY0/UB2vBhZAzB0Lez/29cXGYepAC7UgWH7guv4/yLE71xT4W7GUvaLLommdYXU6Khagr8/VOLLLDn2KEOZeELliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448767; c=relaxed/simple;
	bh=BaTuornQU3iUrsBJYToH5jffWKxOeX6MZ6yKQClRNP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AHqKllb3r5GK7YtY3+9r5tBQRHXLJqtie4TCPH5MZNDnsLH0iOu/UmIXuEF3U4ML+yvq6yWmSccpXPLJpjlihZKDNo3c/mAQQp95GukcAdwW1e7OgkUn+v1BWxK6jAQfVdFfk/aioo9wyQPeKCCwVStnrbgFiET2yq2mc4CYRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1uOa9Ui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406B3C4CED3;
	Tue, 17 Dec 2024 15:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448767;
	bh=BaTuornQU3iUrsBJYToH5jffWKxOeX6MZ6yKQClRNP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s1uOa9Ui8PH3FdfEoLNS2zRGEIr08ESeru/DjbJY11sXInf/B4Q3mf2mNtWPVcrXN
	 IRxPhQbSK+p5ox/Z/1CZAWHG89ltDFfQnvdlCTmc1iAZk33/MnHiN7Q3aQMZmV5Gfg
	 ufzeKUfUuqODBXflfz/ftTHWgZJU3JWdL7E3JK105ENuGyTkZy9fnPs6bRelTF7gAQ
	 +cdMjBrNlAEQ3SeeeNJYG2EROBfVWTHI8VRjIq+b/LPxjvGohoMhUM/Yxk5f/BogLr
	 iq9AK8YoGFEtOuniSGFjM77cC/j/9RJWFsDl937Arm+EA+KKr0Rn96JzoduF7ZExjG
	 381vGpiTYOrCQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:35 +0100
Subject: [PATCH v5 04/14] rust: hrtimer: implement `TimerPointer` for `Arc`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-4-b34c20ac2cb7@kernel.org>
References: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
In-Reply-To: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
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
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4083; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=BaTuornQU3iUrsBJYToH5jffWKxOeX6MZ6yKQClRNP4=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYUS97FjsFDuPCGga3mD82Qi8nX/p76r59Oj
 aozsTEWV1WJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWFAAKCRDhuBo+eShj
 d1BfEACXuRovJYFU0XRzpzLqYd2ptStuEotCZbBoMT6450d2V0TKC5QzCwySESo5Ec00t7qHvQ/
 K1Ec1Z2pKlrja307ii6SIZHeaf1yHSXL3kkziSBRY/e4GxPwO8KVt0ePoaUROm5csNSt9+BDjIo
 01kGUEyM0/oqEhJGD4+7xGLw1Twf/tJXZG57AbI5kEJQWuRwrts5iqxoYnGx3H4aa7s0/D6I2g7
 bJCDlQW+EqKd2T6rQJJlujSzGGHa1mDhNHj0G5ORZ9FRigukZ6DQlLeVciZlcxPXEFB8vUbtVH0
 2YGIOmvQd6WeZ8OXGayvOJp7SYmzg/q2gJlwwp8Gr7an44K7mgAwBL2I7kq58iylNfoeEIyAxbv
 OkU59NcIjD70iMV0zcfnHfBJZuz79+h298VmC8ymy1GI1+Q4eaNqD5z5fPng/BohjgdwpvF8jl/
 wPwwxSaF8evC1Jf6BAoruMTCDbsXawo1EtH64R3rd8exv65dVP/c1KiN/6n/cjbl/ePYLEKtzXO
 NMwMZTNVodErZEtVr1Xvr53XyQoLLhcsqSFvJWg3kLFhaydJA8cDJuKJxBJfcw48/iwL7go3RCQ
 rMuPqyNqkv/nLiCKuj+PdVz6nC0OvM+EZU7eQFP9L79zeVZ9GN7YLPg2qRS7LtCuMFjdSGO2jo1
 X0wTRcGPV51O//g==
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
index b09bdb8bc2037bf116a9a87b16271f4045f53aa9..178e33c1f656d2f834e45b004486f6e5fe1813dd 100644
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
2.47.0



