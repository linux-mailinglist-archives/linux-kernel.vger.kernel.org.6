Return-Path: <linux-kernel+bounces-449449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7169F4F46
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B69F18836A0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696CA1F8675;
	Tue, 17 Dec 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdXiYmp/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B191F7597;
	Tue, 17 Dec 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448777; cv=none; b=ri7VmhoDDKwNjCXWavdlYJFin+ebiJz8mD8udKGarjpz2xW5RDT15iXFg4hU9oErCRYJprRf0+9NusOiFK8ezc+UcXsUFtUtUr2z1Cs5MZ+01D4Nel6tsevcmdfR/UWUdP3lsi8apVMB/cFmaCw40o/Ael71Kv/8fiq/jAGYd2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448777; c=relaxed/simple;
	bh=PgyZwM1wmVnFNYZFv0HvXUEMJw1qjAFl5cH9ilxk0H0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cshUgbOBAooN17hllviX/XOPJ4bQyLjiEgOt5gH01aQCvEYrR6/lBLVQGMBDgJ+2cQTZ0LDbuo+oYDsb16WgJvt9gRgL9DTJc3rD3+VyXNHKFhNfVHc5JyEnwNROqulzT4Dh8voMWbKwq5NT8C4TVZ+NKZuXvjQiogvve/TgZ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdXiYmp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02D1C4CED6;
	Tue, 17 Dec 2024 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448777;
	bh=PgyZwM1wmVnFNYZFv0HvXUEMJw1qjAFl5cH9ilxk0H0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kdXiYmp/S3GkNrWUmDZDSfHnntNq+MM4bu8mczW66UvayN85iDh7Bn+KpbATfiCNZ
	 yczGj++oivgj+zR3svAGQpzS0l0Q1wyWJ/CskAIO/uWhW0AQAv4gs8GtMzyOW7fiR1
	 R4HXqOBEXcy4nu+YoTXzvCIOb9XYO0giSt7bL08IZB6nT5YaepOtuxh3oUJC2HkDGe
	 uxWhTHjqrOBzKC+LsbF7hX+2nrR7lkrH+Y4kCgPpt5diEHviVINFGi5YrcBHQYFmvi
	 eHqN9KlwFwlfHyh2Sh5Sr+4ugB1OkRX8t0Ge6cKIwhDY/jbxqtgmZJUbCf2hM2OFL3
	 9mzFnEk9P6Ehw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:43 +0100
Subject: [PATCH v5 12/14] rust: hrtimer: add `TimerMode`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-12-b34c20ac2cb7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5693; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=PgyZwM1wmVnFNYZFv0HvXUEMJw1qjAFl5cH9ilxk0H0=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYcuvciGdEOtumQPS2SmX9EixXlRvlys19dA
 TWPd+ZSLg2JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWHAAKCRDhuBo+eShj
 d50VD/0Z1mnaHnG27YpYmztMpg4SrnfRn9x9XcUAWXrcbUbNanaYtmr+ZoDIOUc7tU5xC/1R6Uz
 vCB1K6HtdS1Hn34cpUBd/t5ToKLpSe5XHiaEySGrwxLKYLKkGBfZYjVgFElvB8r8oUakL7GFClt
 G9gN78YPhKeklPxID/wSRv0noKYQ9SOEWO7PjHE8dkyBLG/wxntWbsYLRl2EhaHsLImQOlGoUyR
 5Fh31PQ8FO8Nzu6KwEp67nI+1Nzo10Qpe3Ujj5rHqXKw9Z3+GbL9da2Kgj9cxoDtBXEbaa+yfaK
 Lswx8E44WwRfMTv9BaLoCz7kqGo+tmY8EeOndxawzdAgahJeUlVykUSFEfUW4bk2/dNIkBwCP3e
 wwqNPgfTXluS5Rakt1vikWBvkkJRdE2wY9czrcQ7rjHHhmOysSh2dM2v+abPJIWv1LC5LsIqh9i
 MRWLwvXh6NiEMX7WMSXKnSCCL2KLQGNIIJ/7X+JWuSTE6H494d9txpmHIXxTQm2kXmrc4RZgAi7
 pWUBHk0ZYhvavHr2nayK4+FK7SqBfuo6pIGqjeF6p4hF5cl87rpbXyZUg0EiyEneyLhQFajKamm
 l5tur+PDDwcghLlmP+jDzUI8ADedoTuvtZDlYl8hcLNAxNKATnCTy9w9Q07daZIb5RR+7KkOSo3
 K0/oVZyqlwCuoRA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow selection of timer mode by passing a `TimerMode` variant to
`Timer::new`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 87 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 46dbf0d7fe30d271a2b76af89cc4e9e18b42a19a..17cf7c1d704d5e900ad4d08e642e02b1e518badf 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -43,6 +43,8 @@
 pub struct Timer<U> {
     #[pin]
     timer: Opaque<bindings::hrtimer>,
+    // This field goes away when `bindings::hrtimer_setup` is added.
+    mode: TimerMode,
     _t: PhantomData<U>,
 }
 
@@ -55,7 +57,7 @@ unsafe impl<U> Sync for Timer<U> {}
 
 impl<T> Timer<T> {
     /// Return an initializer for a new timer instance.
-    pub fn new() -> impl PinInit<Self>
+    pub fn new(mode: TimerMode) -> impl PinInit<Self>
     where
         T: TimerCallback,
     {
@@ -70,10 +72,11 @@ pub fn new() -> impl PinInit<Self>
                         place,
                         Some(T::CallbackTarget::run),
                         bindings::CLOCK_MONOTONIC as i32,
-                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                        mode.into(),
                     );
                 }
             }),
+            mode: mode,
             _t: PhantomData,
         })
     }
@@ -322,7 +325,7 @@ unsafe fn start(self_ptr: *const Self, expires: Ktime) {
                 Self::c_timer_ptr(self_ptr).cast_mut(),
                 expires.to_ns(),
                 0,
-                bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                (*Self::raw_get_timer(self_ptr)).mode.into(),
             );
         }
     }
@@ -363,6 +366,84 @@ fn from(value: TimerRestart) -> Self {
     }
 }
 
+/// Operational mode of [`Timer`].
+#[derive(Clone, Copy)]
+pub enum TimerMode {
+    /// Timer expires at the given expiration time.
+    Absolute,
+    /// Timer expires after the given expiration time interpreted as a duration from now.
+    Relative,
+    /// Timer does not move between CPU cores.
+    Pinned,
+    /// Timer handler is executed in soft irq context.
+    Soft,
+    /// Timer handler is executed in hard irq context.
+    Hard,
+    /// Timer expires at the given expiration time.
+    /// Timer does not move between CPU cores.
+    AbsolutePinned,
+    /// Timer expires after the given expiration time interpreted as a duration from now.
+    /// Timer does not move between CPU cores.
+    RelativePinned,
+    /// Timer expires at the given expiration time.
+    /// Timer handler is executed in soft irq context.
+    AbsoluteSoft,
+    /// Timer expires after the given expiration time interpreted as a duration from now.
+    /// Timer handler is executed in soft irq context.
+    RelativeSoft,
+    /// Timer expires at the given expiration time.
+    /// Timer does not move between CPU cores.
+    /// Timer handler is executed in soft irq context.
+    AbsolutePinnedSoft,
+    /// Timer expires after the given expiration time interpreted as a duration from now.
+    /// Timer does not move between CPU cores.
+    /// Timer handler is executed in soft irq context.
+    RelativePinnedSoft,
+    /// Timer expires at the given expiration time.
+    /// Timer handler is executed in hard irq context.
+    AbsoluteHard,
+    /// Timer expires after the given expiration time interpreted as a duration from now.
+    /// Timer handler is executed in hard irq context.
+    RelativeHard,
+    /// Timer expires at the given expiration time.
+    /// Timer does not move between CPU cores.
+    /// Timer handler is executed in hard irq context.
+    AbsolutePinnedHard,
+    /// Timer expires after the given expiration time interpreted as a duration from now.
+    /// Timer does not move between CPU cores.
+    /// Timer handler is executed in hard irq context.
+    RelativePinnedHard,
+}
+
+impl From<TimerMode> for bindings::hrtimer_mode {
+    fn from(value: TimerMode) -> Self {
+        use bindings::*;
+        match value {
+            TimerMode::Absolute => hrtimer_mode_HRTIMER_MODE_ABS,
+            TimerMode::Relative => hrtimer_mode_HRTIMER_MODE_REL,
+            TimerMode::Pinned => hrtimer_mode_HRTIMER_MODE_PINNED,
+            TimerMode::Soft => hrtimer_mode_HRTIMER_MODE_SOFT,
+            TimerMode::Hard => hrtimer_mode_HRTIMER_MODE_HARD,
+            TimerMode::AbsolutePinned => hrtimer_mode_HRTIMER_MODE_ABS_PINNED,
+            TimerMode::RelativePinned => hrtimer_mode_HRTIMER_MODE_REL_PINNED,
+            TimerMode::AbsoluteSoft => hrtimer_mode_HRTIMER_MODE_ABS_SOFT,
+            TimerMode::RelativeSoft => hrtimer_mode_HRTIMER_MODE_REL_SOFT,
+            TimerMode::AbsolutePinnedSoft => hrtimer_mode_HRTIMER_MODE_ABS_PINNED_SOFT,
+            TimerMode::RelativePinnedSoft => hrtimer_mode_HRTIMER_MODE_REL_PINNED_SOFT,
+            TimerMode::AbsoluteHard => hrtimer_mode_HRTIMER_MODE_ABS_HARD,
+            TimerMode::RelativeHard => hrtimer_mode_HRTIMER_MODE_REL_HARD,
+            TimerMode::AbsolutePinnedHard => hrtimer_mode_HRTIMER_MODE_ABS_PINNED_HARD,
+            TimerMode::RelativePinnedHard => hrtimer_mode_HRTIMER_MODE_REL_PINNED_HARD,
+        }
+    }
+}
+
+impl From<TimerMode> for u64 {
+    fn from(value: TimerMode) -> Self {
+        Into::<bindings::hrtimer_mode>::into(value) as u64
+    }
+}
+
 /// Use to implement the [`HasTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.

-- 
2.47.0



