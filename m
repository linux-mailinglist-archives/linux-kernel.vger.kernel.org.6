Return-Path: <linux-kernel+bounces-550844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77D9A564F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BE5175569
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96A4212D8D;
	Fri,  7 Mar 2025 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBWuYQZP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99220E33F;
	Fri,  7 Mar 2025 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342682; cv=none; b=n5Qa+araf1nD1KNJ0TPxRa43mwal6zemGxVAK9oc4MZvZ/vJY9Wq4EsYdefcIOobJCmA+hURHppn0WgAFeDlt1sk22D9FxwEbt23HIMaZAsV5GPO0tXe3rxDrhgUCAkyaTpZ7a++wMIr5A8fb2J23TLgNW1ctJSFV4uUFnoV8yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342682; c=relaxed/simple;
	bh=zT7N73QiIvCWJxz3qJsxQ4MQGTG8vrzJ4f63do4fXWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hbsycL0dZsuk+euUvBUrYKBEz3CFBtkmMMRjwiJ1CYf4IhpcbIOH8ZBpusLzrDiXJA1p8fdCKIkv7Pz6KkBXa2WzNuWr68xEQbUxtqXYkrpX0dbE0wQ+y3NdtSEQ9JJiwDq9mLlVaIXyH0AUE6rhcBWkHMuf/zu8t8XBwltnld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBWuYQZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C41C4CEE7;
	Fri,  7 Mar 2025 10:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342681;
	bh=zT7N73QiIvCWJxz3qJsxQ4MQGTG8vrzJ4f63do4fXWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jBWuYQZPuROehgLgnV4TW4Ysl67e8uYLn35nQVecqmlADkFSyynvTGq27fLHiqBRR
	 Rh6lW+w0qFoFpcTujK8ZVYTJnDle0SIlruc74ssl8w1v1kvgYgJDs5++QJc5tasQpk
	 yzG/4WsbGmMewTpJ5IH9hi2PlXFkifcSylSvunTz+xHeP21WPieYvxWJwJvIftHWZ7
	 rJRGWcOT2eINTOAA1hLDJYsaDC8QLsAcwlRbClfO8llGcr0LFqNP019dUcgqcIlZSj
	 ERRfQcIYni1v+esXQfj/nBDsBFG+1KgLRylmi8P82BoKsgCg+nuVrE+sFfU9gxgtlF
	 iUSMe/n4fAYCA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 11:11:56 +0100
Subject: [PATCH v10 11/13] rust: hrtimer: add `HrTimerMode`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v10-11-0cf7e9491da4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5672; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=zT7N73QiIvCWJxz3qJsxQ4MQGTG8vrzJ4f63do4fXWM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnysaAakAthqqnMilkb50j3zFMkuIVStsAV1oqn
 LXA48E5krOJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8rGgAAKCRDhuBo+eShj
 d7i7D/95w3NX+pRCyg0XahuciwKMnPvQZCNdV2BPAeZOt6peOZDSeHHs+WvoOSHWE6Npn5RFxka
 oq8fagxRHSNeNIBRVqCYYclL4jP5aXFODusk9faDh3SkOrjUdMUlz/nCQxv/n8Nx1br8p6I3SzI
 u4N8PgB0Al2zKpxZK9y6hyU09Yzh8bELVB8Q2Ak9Fe79Y/3l0mMJopktOqMoZRLCRFMOTGLBf7W
 WICA0IJOkcwWpIkjYE94vpyxXKxAIqiaaSSK+binkvbNoSLhuYFYwVWPDuMjspor/WxZf/YG/Zp
 RIuunCyebE/amRFH5rLq4f7UZq8oMYgnkg5KRDCRrXvHQMYOhdOhhUbcZMlfHVNNduXcMhxQX0q
 DOpDKhiakwNyBtT5nVa674f4NvGr8lV+dIu92tHXX+jWqd1ZjXDHU0ZtrUgxLoJ7vTgmwLuzVuE
 q2nC0LoVh49K5JX7xYC9jLSRbvoRBUPp6yoQzy5EqC7UfENYIT9HGafZcUHQGzPD0OVUQ6nLHYT
 5zHwF5O7zVMhaJsVb+qXbEPZKbxtw6YJwvas9VrER/BQfEO0DMp91WfH6UWkN3uQNCHp2ghOXQJ
 Ad7vOBcp59L/3GdvppZwEm1lRi3txiQxr+DfilaZp46PsJUeI32DQhymsUEVZBrB8vvjiv+we2E
 lIL7YEZ3yoKh9xg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow selection of timer mode by passing a `HrTimerMode` variant to
`HrTimer::new`.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 82 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 991d37b0524a..d06be922d8d0 100644
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
@@ -373,7 +375,7 @@ unsafe fn start(this: *const Self, expires: Ktime) {
                 Self::c_timer_ptr(this).cast_mut(),
                 expires.to_ns(),
                 0,
-                bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                (*Self::raw_get_timer(this)).mode.into_c(),
             );
         }
     }
@@ -395,6 +397,80 @@ fn into_c(self) -> bindings::hrtimer_restart {
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



