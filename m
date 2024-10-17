Return-Path: <linux-kernel+bounces-369822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B849A232C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DE91F20EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFA91DED74;
	Thu, 17 Oct 2024 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVpJiZeN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7441DE2A2;
	Thu, 17 Oct 2024 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170572; cv=none; b=HI1beb668qvHoRe7gWNdnxcg42rMMJYBdpeovlMENkJX/AZIovSxsbKb2vvPiIwiMdQ6aikFMLTPf83z1olOOzIqXi07Xkcw5LZ56bkYLiHbanc6DM0XpstsNbORUno8krgnfuiqIt/8t0z8m5Pz9t7G1S5BuzTUReH3ud+ZkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170572; c=relaxed/simple;
	bh=6GsQsOXBkEeRY13Q8KtQu/O5wn3Kj6oFTmpBitQUMoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9lQsdJ5N14e8M/vj6dHnj2ASRkV4jfsiiRliqL7zUbXAj7bcaJ4e6yi1VzsWwrdRa00lG0H2SEko4Vcc1SQxn0M6QDH3nklR6S0bgjnNSlkGNNjQqQ55hHRug2bnoexBk/5bCGfc6y6RTomSsdBbp2BymJeDqw4idLFqnSO5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVpJiZeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB57C4CEC5;
	Thu, 17 Oct 2024 13:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170572;
	bh=6GsQsOXBkEeRY13Q8KtQu/O5wn3Kj6oFTmpBitQUMoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BVpJiZeNfa+o7sXwgZhU/9TajP1Ho6+dkU72SJ9Piji006YANwQIRbWBaeWOLaRMu
	 eq71CQszVoXWUZF5Iw75MkzMhCNJItO3oPq1L+7OONkcUG+apb2vZOz/wystMrPIO/
	 TV0GVq7U9pcWfzPdvgH64zNviZ7nnT5QzimwtiJMDCO4jHUa5mcDNAaNO+1vgC19Va
	 ZZXrcPCBgoWlpBVFg/8/ukpIgo0hXOAZQLZmnlQo8SqSAJgWrjkVt/iyDU3YmYsGCe
	 LJrg/cgc1qbgBqkliGMfS1fVlolYIv3suvkoQeCw32grzHWRx1GXcCuy3ThM+vl1DV
	 RbVtf6Xb2oHOg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 17 Oct 2024 15:04:38 +0200
Subject: [PATCH v3 11/13] rust: hrtimer: add `TimerMode`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-11-59a75cbb44da@kernel.org>
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
In-Reply-To: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2

Allow selection of timer mode by passing a `TimerMode` variant to
`Timer::new`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs | 88 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index 2c1573e19576de93afc959d71e94173e2c1ed715..1674d1dcba39cc7ab82e1f189002afa365ee9341 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -38,12 +38,13 @@
 /// # Invariants
 ///
 /// * `self.timer` is initialized by `bindings::hrtimer_init`.
-#[repr(transparent)]
 #[pin_data]
 #[repr(C)]
 pub struct Timer<U> {
     #[pin]
     timer: Opaque<bindings::hrtimer>,
+    // This field goes away when `bindings::hrtimer_setup` is added.
+    mode: TimerMode,
     _t: PhantomData<U>,
 }
 
@@ -56,7 +57,7 @@ unsafe impl<U> Sync for Timer<U> {}
 
 impl<T> Timer<T> {
     /// Return an initializer for a new timer instance.
-    pub fn new() -> impl PinInit<Self>
+    pub fn new(mode: TimerMode) -> impl PinInit<Self>
     where
         T: TimerCallback,
     {
@@ -70,7 +71,7 @@ pub fn new() -> impl PinInit<Self>
                     bindings::hrtimer_init(
                         place,
                         bindings::CLOCK_MONOTONIC as i32,
-                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                        mode.into(),
                     );
                 }
 
@@ -83,6 +84,7 @@ pub fn new() -> impl PinInit<Self>
                 // exclusive access.
                 unsafe { core::ptr::write(function, Some(T::CallbackTarget::run)) };
             }),
+            mode: mode,
             _t: PhantomData,
         })
     }
@@ -330,7 +332,7 @@ unsafe fn start(self_ptr: *const Self, expires: Ktime) {
                 Self::c_timer_ptr(self_ptr).cast_mut(),
                 expires.to_ns(),
                 0,
-                bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                (*Self::raw_get_timer(self_ptr)).mode.into(),
             );
         }
     }
@@ -362,6 +364,84 @@ fn from(value: TimerRestart) -> Self {
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
2.46.0



