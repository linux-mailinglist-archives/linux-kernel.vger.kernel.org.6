Return-Path: <linux-kernel+bounces-528969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10900A41E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BBF178E45
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E795421931D;
	Mon, 24 Feb 2025 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiTxdRmQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273712571AF;
	Mon, 24 Feb 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398747; cv=none; b=WA8yGGjtgcweJ3zP3hZc8VAu3sx62lziIlKM5ris9YXAXy7tz2Xt8tTAzojBLI55nPMsLI21Qpz35tDQ5N6D8OvSdw5inpejFfrTOgofJjQdkRjqVQiII6X7Z/zbnIxmZCpGCfj0ihnoe3w/AK1RPTqHlpl1Eb2PoKvEu9rm5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398747; c=relaxed/simple;
	bh=68obgfc+2OHQofSGZkb2YIGN660KlZzCALimTCdZfds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CVu0lHYRw/Pw7dN5TAlP6gXssLLdjYGtbm2HGXbqyHrw4y/dNLB0wfuemfMS+kLK2txw57P9uiQoTRzezYwG7fe6omwS3lsK7HRj4Z5WyLDCYplaMtHxHHO6sXkOmVW05hlvvaurJMMvt/E9YNfzFrIfArm9bMloAj6gG5YlNSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiTxdRmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217BDC4CEE9;
	Mon, 24 Feb 2025 12:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398746;
	bh=68obgfc+2OHQofSGZkb2YIGN660KlZzCALimTCdZfds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uiTxdRmQ8vdu73D34G8fIsJqggJEkx1JHF7zMBfn5tTB6Tt/l81Q23ahb98bJk0VM
	 DGkdGmHns3mIlZyTf0EfVI66kFq9teu5NVT6JxADltrARvOAzjFzCvgUY+/lwyJjhW
	 QKEbImCg+hspaXEci+aU5O2BE6EiUzaXggj1s5FV49x9X+Szm2Y1pBWm/eJ4qoENfJ
	 K4yI3nO3Qbgz1qnU+JLa1AW2PDWP5T2NJxlSi0VU4kqYkjR6sQuWJpiknSg1HqXxof
	 Vc7ZXn8n20V1EhMTD/zl5hPVZkxhZP6/Hg5+h9MjAvWR5RHEH4sDxFyY71AJqB4eZT
	 A2j63J2qL1Lpw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 13:03:45 +0100
Subject: [PATCH v9 11/13] rust: hrtimer: add `HrTimerMode`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-11-5bd3bf0ce6cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5503; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=68obgfc+2OHQofSGZkb2YIGN660KlZzCALimTCdZfds=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAmWt1scoialav2+XM5RBCikrGcnUkVBDL5q
 1Dm8Kz2g5iJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgJgAKCRDhuBo+eShj
 d7huD/9ZZ57dCQXMPwj8JB5Gp69+C6dHAkvJexaKFyXMSOBoQG/3sTkaVWKHGRvS4QbCjsA1ttk
 0q2wpdWGIs/1mu3WNnzEm/Q4XIWz/pOkQzfr5LFmUFgrC6iiL/OM+ePrjo4MWYXPv6ByMbDoII7
 z+5ghUqonQUsHunzOHhWQJOWibSoUW8kPEBLIUKIhJVs2cRLiNp+2c3AhbfASlGAFXB1cfPynP7
 M08kr12vUoMjzeZmYHmkUbumQONspKGnZXf87H4idkf/XWOa39BB9uFk0EXR2NMhW3ErpV65cYm
 tmUJg0pLjjiDEteWiWHZQKAEJd3oQ14Vn2wlcPBc0Vo98tF4X0midrKuuAvdIwI3wxWuKwu989G
 MZvxbiuJTnrQL0QyO4JqXWo1ttpMJ/c8TrUc1HJT2xc5zS03E4RL/AtLsa888WF6gVwaIZvVF5H
 hJba4YH0AElFjMIda056ej+KI2/gNaJBikF1rjTWfkG54mSmAdqXXuxtMsfsmWjJOLkQU7r8rUJ
 nICCxUoXEAHd0TPqDI/9LfUDGmlhtA1JyWs+o5txJrzRem/85oaMvlomc2+4LTgB31mglZk/W7R
 U1W+1LHaPtJMTMkB9PvS5Ob7QWR5WVx4k42R5bOMAiQMcOT5A2vXORiONCjaYwBX66IdNBdU/Q6
 myV3aQ/v3R5K7Fw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow selection of timer mode by passing a `HrTimerMode` variant to
`HrTimer::new`.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 80 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index fc4625ac2009..160df73a2d44 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -79,6 +79,7 @@
 pub struct HrTimer<T> {
     #[pin]
     timer: Opaque<bindings::hrtimer>,
+    mode: HrTimerMode,
     _t: PhantomData<T>,
 }
 
@@ -92,7 +93,7 @@ unsafe impl<T> Sync for HrTimer<T> {}
 
 impl<T> HrTimer<T> {
     /// Return an initializer for a new timer instance.
-    pub fn new() -> impl PinInit<Self>
+    pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
     where
         T: HrTimerCallback,
     {
@@ -107,10 +108,11 @@ pub fn new() -> impl PinInit<Self>
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
@@ -371,7 +373,7 @@ unsafe fn start(self_ptr: *const Self, expires: Ktime) {
                 Self::c_timer_ptr(self_ptr).cast_mut(),
                 expires.to_ns(),
                 0,
-                bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                (*Self::raw_get_timer(self_ptr)).mode.into_c(),
             );
         }
     }
@@ -394,6 +396,78 @@ fn into_c(self) -> bindings::hrtimer_restart {
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



