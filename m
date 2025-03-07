Return-Path: <linux-kernel+bounces-551991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E888A573D4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B583AE127
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD2B259499;
	Fri,  7 Mar 2025 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJz253yC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF6257451;
	Fri,  7 Mar 2025 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383647; cv=none; b=XfrSYa6SFMm+hIgfv5jNA/2Ldr1GYOqMHx0PaabgVGXpwi/PyrD1gxX63iFGyt48tnDBWYNSC+l8yDGLZ/7FcxR/g5BruPqU1+kwtXthQ3tUy4L+MLKThmS///rzEt7wyliaWyixpe+OowBgOYlogIrMx953TLhoJFeKXD1rB/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383647; c=relaxed/simple;
	bh=EOkY/aoS6nNmxClR0QpR0OVOdPp6tEkN5Lzbu3qGboA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahgSr2UUBToIMOhSjgQ90nim55xN6IJkPBJd7yo1doLLYntJZmCgYh9LHi/o6s6Z5cNUhLn131Fe6ofT9rVegfPOUtugGj+Oj0V2r/1Uzrh3T6Y7SbZrvVL9woEzhV8QwDgIlh4AOHmzSQ96G4DbeHDtcDWHusBGUbyYNzVSL7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJz253yC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E71C4CEE5;
	Fri,  7 Mar 2025 21:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741383647;
	bh=EOkY/aoS6nNmxClR0QpR0OVOdPp6tEkN5Lzbu3qGboA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AJz253yCq1aISeytSMmpfLfy1Tqgz7/c/EeOj0bAMdVSpTpoG2H54D+1bUt+wt6mz
	 Gj2rcLeFCSe+TVf1GwYhbW/2MOwkXBgoTjiZlW1TXAFsv0zrSeY8n7v4bpz3RDRf/4
	 B3T5J/bQ1My1hUOoTIDwQHoNYspMMaLCvlri5DI6CiN7CqOGbtZeV1seQ2QuXsFMe8
	 talltKPSseDWXyLyaceeoCr5rt+zBVQDX1r+u7r/kO+l6IgMrFxM2RD1jnkmcOoizO
	 Q8UF+97UpnHILqmi2KpAeGZq2RuBBdGwRKjgKyOLaFBf00iO2/fc36zOtRkHmHhjJQ
	 vKolUeztTHz8g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 22:38:52 +0100
Subject: [PATCH v11 11/13] rust: hrtimer: add `HrTimerMode`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v11-11-7934aefd6993@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5724; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=EOkY/aoS6nNmxClR0QpR0OVOdPp6tEkN5Lzbu3qGboA=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBny2dzeO2GJFPsAEmt3cDIy3IIjCvtfal7nJZ3M
 /RrGxBpo0KJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8tncwAKCRDhuBo+eShj
 d8zQD/9OJcDxannRy66SlMeyi6zJbjgQYlzwiE2Ue/niTSb2K4xmQECFK9zeo6xdOV2k7omMrQI
 8oxn6+PgjXTwbh6mvfcTwFuN83EdRJSJsqDWQX5nG2SUF8/DR8BmRzdqAo1UKbkTL0wi5xA1416
 IIJDwJ4KRtLfXxFoEntqy6ZJtw+6FPh8kQ29qOYDN+vGnLU23tb0vF5PMsF0dMWVw5n5Wf+dVG3
 Yb4ZScj0fMZtCxyaoIkwc4ri11OpuF5a1d9PuUJqNFcJa+v0MZiTkh/5G7HliU0pPsisfmTpTqp
 kn11D/bx4+mj4qGWf/UVquz/q3THzptgq3im+5qIyu8ZPxL3na+Nzjwerf3hCJWiKUHUr8i9B7z
 R5zre8RoxSlO1fNbtlIHjubAza5DJ94VsTHSn7wLnjT2VCGII0lj9eZ1no1ZlVv5aqy57QzoIol
 m3VRz1KAEKjW5G3WYD3XsGoNqG/Rx50oAgs9N6DyevpNBF3m1vPlGY6lASO1KxYjhveCX17djD5
 s0k6Yld4ZgYoZA8mgWAut1pjVUhzeqk8yafP1JWNt40Xnvp+3WTHyXMZJNd+GekJOJznX+IDb3E
 Ch/Dpcz3y6ghl+318ox8P9QrHWkB4eZO7EKZMD8+QQTUAqPPhoKuPmNu0OYdt3NAQLnKF7nyGIZ
 QEnTspaiNSLQUSQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow selection of timer mode by passing a `HrTimerMode` variant to
`HrTimer::new`.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 82 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index cb404daa12f8..2b7ab112e187 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -80,6 +80,7 @@
 pub struct HrTimer<T> {
     #[pin]
     timer: Opaque<bindings::hrtimer>,
+    mode: HrTimerMode,
     _t: PhantomData<T>,
 }
 
@@ -93,7 +94,7 @@ unsafe impl<T> Sync for HrTimer<T> {}
 
 impl<T> HrTimer<T> {
     /// Return an initializer for a new timer instance.
-    pub fn new() -> impl PinInit<Self>
+    pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
     where
         T: HrTimerCallback,
     {
@@ -108,10 +109,11 @@ pub fn new() -> impl PinInit<Self>
                         place,
                         Some(T::Pointer::run),
                         bindings::CLOCK_MONOTONIC as i32,
-                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                        mode.into_c(),
                     );
                 }
             }),
+            mode: mode,
             _t: PhantomData,
         })
     }
@@ -369,7 +371,7 @@ unsafe fn start(this: *const Self, expires: Ktime) {
                 Self::c_timer_ptr(this).cast_mut(),
                 expires.to_ns(),
                 0,
-                bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                (*Self::raw_get_timer(this)).mode.into_c(),
             );
         }
     }
@@ -391,6 +393,80 @@ fn into_c(self) -> bindings::hrtimer_restart {
     }
 }
 
+/// Operational mode of [`HrTimer`].
+// NOTE: Some of these have the same encoding on the C side, so we keep
+// `repr(Rust)` and convert elsewhere.
+#[derive(Clone, Copy, PartialEq, Eq, Debug)]
+pub enum HrTimerMode {
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
+impl HrTimerMode {
+    fn into_c(self) -> bindings::hrtimer_mode {
+        use bindings::*;
+        match self {
+            HrTimerMode::Absolute => hrtimer_mode_HRTIMER_MODE_ABS,
+            HrTimerMode::Relative => hrtimer_mode_HRTIMER_MODE_REL,
+            HrTimerMode::Pinned => hrtimer_mode_HRTIMER_MODE_PINNED,
+            HrTimerMode::Soft => hrtimer_mode_HRTIMER_MODE_SOFT,
+            HrTimerMode::Hard => hrtimer_mode_HRTIMER_MODE_HARD,
+            HrTimerMode::AbsolutePinned => hrtimer_mode_HRTIMER_MODE_ABS_PINNED,
+            HrTimerMode::RelativePinned => hrtimer_mode_HRTIMER_MODE_REL_PINNED,
+            HrTimerMode::AbsoluteSoft => hrtimer_mode_HRTIMER_MODE_ABS_SOFT,
+            HrTimerMode::RelativeSoft => hrtimer_mode_HRTIMER_MODE_REL_SOFT,
+            HrTimerMode::AbsolutePinnedSoft => hrtimer_mode_HRTIMER_MODE_ABS_PINNED_SOFT,
+            HrTimerMode::RelativePinnedSoft => hrtimer_mode_HRTIMER_MODE_REL_PINNED_SOFT,
+            HrTimerMode::AbsoluteHard => hrtimer_mode_HRTIMER_MODE_ABS_HARD,
+            HrTimerMode::RelativeHard => hrtimer_mode_HRTIMER_MODE_REL_HARD,
+            HrTimerMode::AbsolutePinnedHard => hrtimer_mode_HRTIMER_MODE_ABS_PINNED_HARD,
+            HrTimerMode::RelativePinnedHard => hrtimer_mode_HRTIMER_MODE_REL_PINNED_HARD,
+        }
+    }
+}
+
 /// Use to implement the [`HasHrTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.

-- 
2.47.0



