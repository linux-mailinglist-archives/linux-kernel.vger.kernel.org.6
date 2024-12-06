Return-Path: <linux-kernel+bounces-435535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F119E7915
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357A3280EC3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEFA21CFE1;
	Fri,  6 Dec 2024 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVMZKJPs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0D21B1B5;
	Fri,  6 Dec 2024 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513753; cv=none; b=HkAve07f9W7hgcVOy+d2feOHRb2F5q4xlafA6ztfkvpYaKA0On9hQX3HYrTKl9+uBGuA1Ly62EPHBZzPzVb/SpjBHhuJGxOlNRL5wYv3vZG/2XnNNxWjh0ARKkyq6xyf5Pn7Ahku/MKv+T6V4fuXaPZHuH59toDty2N8IuvxJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513753; c=relaxed/simple;
	bh=nooMkUxQMi3qxanUzKuu/XUmI2mf+pjc89vZvmK0u20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZUckQReScLte+F/i8Wg8TtbeuKw5m60pWZq3n7MM+ERMv9C0kjimF/bke6/kOKaVixZ/X0/Cd3cQzPedfe2aXZloJjmuVrt1y33k0HdIeZ1514CH9mW4c/XhN5dAs2cRmB976QZc5hLRwlqZ0cWmrK8C8h8lMqw/WbMhbGy+aII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVMZKJPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CC4C4CED1;
	Fri,  6 Dec 2024 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513752;
	bh=nooMkUxQMi3qxanUzKuu/XUmI2mf+pjc89vZvmK0u20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TVMZKJPsxx+xhC3VweVMEUOIq3ssEjVlcDbYDvOei+z0zZInytwsv6iiuYAwslovS
	 0XFIVFOPo8lpUebNGLkdDVp0X6W+3b31ldLEHsVmfAua8t2ScEmYVdj5KCNbACvKs+
	 ZchfG8wo94I91xfhMyXAHkChiaUWlQ1G570PRqJHp+qH06vxSoNJrXJmbsSxJIXTni
	 jFq4QByQhRDrSNCcQs2nw0Oivff/ETu7U/9vhkp5pt9NvX9GXpgI+a1hF/0pHmWb4O
	 E5HZgF1G07kjbfxuwrRHBNet5kK6o89AVqaM+2ql2bbm4t2rS5dXx2TQaY7j3rkRbY
	 DftEpc6skrlHw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:33:04 +0100
Subject: [PATCH v4 12/14] rust: hrtimer: add `TimerMode`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-12-6cb8c3673682@kernel.org>
References: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
In-Reply-To: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5693; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=nooMkUxQMi3qxanUzKuu/XUmI2mf+pjc89vZvmK0u20=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVhNR1JDV2lzazNFay91OUY4MmlnUlg0CnpVc3g1V3RnTDl3TFc5Vkkx
 dWFCam9rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRnp
 BQW9KRU9HNEdqNTVLR04zczk4UC8xSTgwa0VpRDVrMVFCKzEwelRBR29tTmRsbWtJQ0FOeS9CaA
 oxUHQ3TG04djNnalE0ZzViSUFmWFlCa2RBL0FTVEVyMjJvVE02WW1FRlQ3T2hGdi9GUTUzRG95U
 EpYME5qZnpnCmUySlZvbmlRb3UvRG5aUllEbGZDaDNhRFhLMiswOW44NTNPY2hUcit3MXhQMjJB
 d05tUkY4dThIWEhmNXAvTHMKbFhNYXJDUk1YNDFBdjJhbE1IaWJ0eGo4SDJDRDZqTlRCWm9iaXk
 wUjljQzlUOFNlQzd6cTUrRkdFRDRWTkZhagpuSlRPMHdRT1BTQ0FaaVRjK3h6N1UxaEtoU1Y2Yj
 dKRnlsTmpDMGZpT3BSSjZ5YUV1dFhUaGZlZk5qdVJiWEI5CnNiRm1yK3VaZll3VjdKdHBmM3FNc
 k9SZk9ZUlNjb2VlQ2xNZ2lwSm90amxCUUROZ3I5QlZGK1Q5bmZLODZWTmUKYWtBRUNEZlFYVFdi
 ZGUwQk9lRlU1d2ZlTVZISlV6Wkl5NkV1VzRGZHZqYTZnVysweEVOamd3SWFMd1lhRmxvTApDOTB
 3N2ZlcnZSNnpIT3BxRURrdENlNnkzdG9uOVR2Y1pzT0FUYTY0TW0wbWpyM0NzNW8raFc4S0JoeE
 trVzc3CksxM3lwU0d0UHRORWNPZVQ3bmI1dUgxZ2k0ZGd4ZzM5c1EwT1JsdlN5OGZ1ZG9odXAya
 zEzUURPdkUrcHROV3QKY1lZSDFWd0ZzYlJSR3cwcDZhL0pncTJkUGhxWUJCelNIeE1aL2JzQlc3
 SlBBMWo1N09nY1oxdUVvQXVNTEVFNwpzTWN5YVROOFFaV0I4bjA5OXRVTjB2SU40cGZ0Uy9XeWR
 ocGYvTWloM040R1NJWk5FTjV3cmk2MDRSRE1wR3dJCm9HL2dnenhEOUhvZ2RnPT0KPXVnU1AKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow selection of timer mode by passing a `TimerMode` variant to
`Timer::new`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 87 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 976a7350d6bee0cebe3dcca04ccbe48fef31e430..3bcc45dae130448173be157ce60395e2b9d46a10 100644
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
2.46.0



