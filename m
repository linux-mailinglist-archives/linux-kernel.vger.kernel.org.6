Return-Path: <linux-kernel+bounces-519516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F6A39DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB0D3B7F91
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277FF26E16F;
	Tue, 18 Feb 2025 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBdiLfwq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B9926E159;
	Tue, 18 Feb 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885318; cv=none; b=E9j+PY9/EdKS3EkIi2a3Z4mXlA1RqOZh8JumwcGSiDSG6SINJO3yEtM3omKcbxH2lQeRDIB2ghufWk3U377wNiUko2eDOeJ7PyDMoPmk3qZbKHMViqglhKorXLkPANdZ/LYxO/Q0fztiTMMmY60Dt75xAUdAZJG4157UrhNw6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885318; c=relaxed/simple;
	bh=DyhUM3cGjVtemPeWulojmVfZzFOhawmRI1WoCDW0lco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJe/qhzzAr0skwnVCgGUFHhr78B/tOW+ZFY42FbALl5imI8f8gEQ+7JRLn1wObhiyZA7asCD+G5nFoaCDdxcTIPbkQxGeaWC+16rIKLCzfAp9quF+l33aNhlP0fFqUmab7O6br6TnHUcIH8tx6AoKNS3KkT/I5zNWOF6Oy85PE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBdiLfwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85913C4CEE2;
	Tue, 18 Feb 2025 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885317;
	bh=DyhUM3cGjVtemPeWulojmVfZzFOhawmRI1WoCDW0lco=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kBdiLfwqVtuzzcLtHIANm8uGSMzt3AhSjj4bJCLeAHFPJwuJ/AWVhs9c+2y+cghyV
	 Y4O9519ZhrcRBRUwL20ikr6JsHLfgU9WYmEtnfh1MPGL+xstYABQhytpUCpeM9jb13
	 H/vicXRfa6epehvXWrwgwsKqZ1eBwZL9deCOCDC/F6b7qnZOcZyG/EYAbw3lPTk5rS
	 Aq3ABZSZLVa/ndN7KJe3lnhxd/jWLzCZ5VX8ZfQqrT790B7WmcvdZDQbTmFecYwIub
	 XAlsisy2IfZX0D7vXm9yPUHHMaXWaumba94TORLtIg+JBaY13OU+56EI1Z5fvtA64X
	 9YzDnGxnx/xDw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:17 +0100
Subject: [PATCH v8 12/14] rust: hrtimer: add `HrTimerMode`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-12-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5630; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=DyhUM3cGjVtemPeWulojmVfZzFOhawmRI1WoCDW0lco=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIq6G0x9tlCXaZyowuUdqMeWq/ugWljtfVYLG
 CmD+pOsfcWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKugAKCRDhuBo+eShj
 dwiND/9VRcJFusNBC/ZUFz7YLB0Ww16mltK+RCd809GwsbeVoVjahAidQY5LMqZ4UrJ9gqjWGe1
 LkONkE5UE/uQiDqXWoyzBWJPQ20Bl/TQBbYfgOuS3GlTWqGw2esmXakRnsJo0mJE2uYwYtTRgXx
 SnKn36uAYZlHEaSJnIgGoLeTiVtsXSZqJpnWxMTM/6ADS6/nhCzfiuxhcKDZ3Klz+RAFElLIn6l
 p8c14pi0XaGuDm/ZvYcQZDfy+4rzkeTKJFjqC7REAxfPexUpffOb+gRIRyqfoJUmOe5j3lRGFP3
 D/h7GY93uqsWNL1QQs1hzfTeLeLDYuec5KmB1eQ8BCdDIC7X2MO8Uv+LmqjEsTQkPf7lcbEq/yw
 oTb+TSQ8mBb8b0lYIBV5w8aXhxCxY3MKOG5CeSMHvN5UqKgOKKbApJeZrY/6wQKBkjBWK+z5TZp
 PTpfGBg9RMut1xbF1EX77OhoctiJtqrVupv93wrDKNF9U33EEU7lrHYALJ2MJO2zfwtleYwiBTL
 EqqJ8B166ep3E5cd7SvUbbs4+6OkpvUR6TqNmLnpm53C1RhtvIn54vH5KNXm94CSIntTcJSayRO
 VLnQr37p2Ypa72YgYlO9Mm3yL/sXQO7NG58BLudv3I4ol/VDyo52sq3NurjsjT2wK7sfge4jLTo
 Zug6p9hMI50y3tg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow selection of timer mode by passing a `HrTimerMode` variant to
`HrTimer::new`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 86 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index de9edf52ebb07..db49061f830c3 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -59,6 +59,7 @@
 pub struct HrTimer<T> {
     #[pin]
     timer: Opaque<bindings::hrtimer>,
+    mode: HrTimerMode,
     _t: PhantomData<T>,
 }
 
@@ -72,7 +73,7 @@ unsafe impl<T> Sync for HrTimer<T> {}
 
 impl<T> HrTimer<T> {
     /// Return an initializer for a new timer instance.
-    pub fn new() -> impl PinInit<Self>
+    pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
     where
         T: HrTimerCallback,
     {
@@ -87,10 +88,11 @@ pub fn new() -> impl PinInit<Self>
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
@@ -336,7 +338,7 @@ unsafe fn start(self_ptr: *const Self, expires: Ktime) {
                 Self::c_timer_ptr(self_ptr).cast_mut(),
                 expires.to_ns(),
                 0,
-                bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                (*Self::raw_get_timer(self_ptr)).mode.into(),
             );
         }
     }
@@ -368,6 +370,84 @@ fn from(value: HrTimerRestart) -> Self {
     }
 }
 
+/// Operational mode of [`HrTimer`].
+#[derive(Clone, Copy)]
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
+impl From<HrTimerMode> for bindings::hrtimer_mode {
+    fn from(value: HrTimerMode) -> Self {
+        use bindings::*;
+        match value {
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
+impl From<HrTimerMode> for u64 {
+    fn from(value: HrTimerMode) -> Self {
+        Into::<bindings::hrtimer_mode>::into(value) as u64
+    }
+}
+
 /// Use to implement the [`HasHrTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.

-- 
2.47.0



