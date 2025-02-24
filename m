Return-Path: <linux-kernel+bounces-528974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C2A41E87
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6031118892E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B57F23BCEE;
	Mon, 24 Feb 2025 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+y5KfLQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254FEEB5;
	Mon, 24 Feb 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398767; cv=none; b=AhCHUkUmMgP2C8d3OD77Of3KRcsNt+JbMpxYTAFzzlKlJfVK68lSxXF5R6UUeKDkywtfuXXMAM2K9ofHgIxXn8LtA6gCZiTXGDgVTulAMaiE9rtwuX3aiZwQuVYmkZLrz5mu0M+HWJd6+3775igiU74oNzQx3wAf3LpQWop1m8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398767; c=relaxed/simple;
	bh=DuU3evB+1LgFZLESTxh1PCvMJv87DbYXfEPsG7tHlYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k8kZx8OG23pESkOBqFIKnTPf13je73rZOj25ZgoYbA8kUw7ByVvEz3u6/ObVaVk2DvDFabSl//Ne3/eanywBMGF6jhyn70Lo12SGn6WwtCDG/V+KQ1iqIpvSlA7um4VdsAHJEQLiBMXhfeY7snRb28jT4f5Jja51sn0m5b7u0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+y5KfLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C46C4CEED;
	Mon, 24 Feb 2025 12:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398767;
	bh=DuU3evB+1LgFZLESTxh1PCvMJv87DbYXfEPsG7tHlYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q+y5KfLQbE29GkzRAHkNCqnV3UHl5zPUNJZMTWNd+ArvI7CoutxD59m6Cay+aOcnl
	 0+Aa7Pk0f9Qy921VOZNjqawqmd5sXLD3Cu8QHEzSlvyQQndn2peH2LttLCJQkDfSrA
	 33DueDQQpFbdWI2kqdfttquybWdqXrTDL6ytZgEHeLD9Roj7ndUIyHxhImlvbMpHC+
	 oP/hxBnhb2TyHNGoWISuxYaaK2ozICbPrHODWTArNuXWM3dER6yv1K3dxSyYZ2ufo9
	 Q6dilPSIGuvcwcTrHLsCO2xrrfdxMNGxWtl936WLi5dZMPBOjqoOo9evtL0oC3TiWk
	 p3MJ1kk3YHvQg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 13:03:46 +0100
Subject: [PATCH v9 12/13] rust: hrtimer: add clocksource selection through
 `ClockSource`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-12-5bd3bf0ce6cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4207; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=DuU3evB+1LgFZLESTxh1PCvMJv87DbYXfEPsG7tHlYM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAm1O6CWWrm8R3i5ADwYFUlMwUMBoI623Lcr
 qvSRb+NA4aJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgJgAKCRDhuBo+eShj
 dzT5D/4n1CJIE9B6+23HwQi5XXPk9H5DOlzJOy3d1uMdSHNnF6fSRuLfj/WJPoDKA122t7JzQb6
 VbxDLPpa8QWEJafd464zVUVvO0dL/P1e99S0+0MLeWryeoRD7Cd8rImx/5le4GOIknW5ru724L3
 zbM5XKCqROZJOuJEdy6TqiBBSfOJxnKUbHwkYOi8az2BP+nqI85XYmoocz95FBq3UlVX+4Kairb
 Eh1kKe5H7cYAgRDYQaJ14q+OuUmYn90m6zQqrrlOrhFhNusAafAQmz5QHU2sDn/kHCJnY/nqoKx
 DPuw0RsgNHjU8ks3zACL7CHaG6U3PG5eabuzxd+I8t3TH4DhTnkaUYkVMzpOhnwOcamkTDhqrwi
 pfIt89Et3ZfWA1zPLsm/TYGJeD4xq0ocG+OckX8GbKlGab+2GzYFnl1NpVc/BRn3QJWZoi+sjZD
 ovWk5YA1ytGj63sJWOS+qqjo7F2E48AKtAfz/H4q/2Khz+usq1l6R9Auu3VFpre14idhurAJxTY
 mRbiivlO3GfxzikgCR/gjhnRLyFgZtjt3qzmpcueiwwJMSM8EgCT96LL2orYtRjc3IZ5UrWf+9g
 NTLXaHTNIFQ7R4dQdlNywNum4C4fQMh5u12z404YrqgQ5mO5ifbG8OlQ1FAg6+p11IJ8kBq6vlb
 i1e1OOpuwBrVkUw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow selecting a clock source for timers by passing a `ClockSource`
variant to `HrTimer::new`.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 59 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 160df73a2d44..77b8748ec29f 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -93,7 +93,7 @@ unsafe impl<T> Sync for HrTimer<T> {}
 
 impl<T> HrTimer<T> {
     /// Return an initializer for a new timer instance.
-    pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
+    pub fn new(mode: HrTimerMode, clock: ClockSource) -> impl PinInit<Self>
     where
         T: HrTimerCallback,
     {
@@ -107,7 +107,7 @@ pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
                     bindings::hrtimer_setup(
                         place,
                         Some(T::Pointer::run),
-                        bindings::CLOCK_MONOTONIC as i32,
+                        clock.into_c(),
                         mode.into_c(),
                     );
                 }
@@ -468,6 +468,61 @@ fn into_c(self) -> bindings::hrtimer_mode {
     }
 }
 
+/// The clock source to use for a [`HrTimer`].
+pub enum ClockSource {
+    /// A settable system-wide clock that measures real (i.e., wall-clock) time.
+    ///
+    /// Setting this clock requires appropriate privileges. This clock is
+    /// affected by discontinuous jumps in the system time (e.g., if the system
+    /// administrator manually changes the clock), and by frequency adjustments
+    /// performed by NTP and similar applications via adjtime(3), adjtimex(2),
+    /// clock_adjtime(2), and ntp_adjtime(3). This clock normally counts the
+    /// number of seconds since 1970-01-01 00:00:00 Coordinated Universal Time
+    /// (UTC) except that it ignores leap seconds; near a leap second it is
+    /// typically adjusted by NTP to stay roughly in sync with UTC.
+    RealTime,
+    /// A monotonically increasing clock.
+    ///
+    /// A nonsettable system-wide clock that represents monotonic time since—as
+    /// described by POSIX—"some unspecified point in the past". On Linux, that
+    /// point corresponds to the number of seconds that the system has been
+    /// running since it was booted.
+    ///
+    /// The CLOCK_MONOTONIC clock is not affected by discontinuous jumps in the
+    /// system time (e.g., if the system administrator manually changes the
+    /// clock), but is affected by frequency adjustments. This clock does not
+    /// count time that the system is suspended.
+    Monotonic,
+    /// A monotonic that ticks while system is suspended.
+    ///
+    /// A nonsettable system-wide clock that is identical to CLOCK_MONOTONIC,
+    /// except that it also includes any time that the system is suspended. This
+    /// allows applications to get a suspend-aware monotonic clock without
+    /// having to deal with the complications of CLOCK_REALTIME, which may have
+    /// discontinuities if the time is changed using settimeofday(2) or similar.
+    BootTime,
+    /// International Atomic Time.
+    ///
+    /// A nonsettable system-wide clock derived from wall-clock time but
+    /// counting leap seconds. This clock does not experience discontinuities or
+    /// frequency adjustments caused by inserting leap seconds as CLOCK_REALTIME
+    /// does.
+    ///
+    /// The acronym TAI refers to International Atomic Time.
+    TAI,
+}
+
+impl ClockSource {
+    fn into_c(self) -> bindings::clockid_t {
+        match self {
+            ClockSource::RealTime => bindings::CLOCK_REALTIME as i32,
+            ClockSource::Monotonic => bindings::CLOCK_MONOTONIC as i32,
+            ClockSource::BootTime => bindings::CLOCK_BOOTTIME as i32,
+            ClockSource::TAI => bindings::CLOCK_TAI as i32,
+        }
+    }
+}
+
 /// Use to implement the [`HasHrTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.

-- 
2.47.0



