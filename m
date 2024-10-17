Return-Path: <linux-kernel+bounces-369818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2399A2328
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B7D1F23107
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415E31DE3D5;
	Thu, 17 Oct 2024 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD3KUHVh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6EC1DE3A5;
	Thu, 17 Oct 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170557; cv=none; b=E+iz6DzQkT20Imx6qi1A3jJ6oxOBjaHE5a3u1XXzWvbIW1u2ADThUVNNW8cgidUjMLcgJa8d+jEgy7OONFB19XdKn7B7+lWSRwLJv6JcL74yLtPgJxue0QzPQU4QSGtvuwHZjYxuJDi8lc4aFLwPFVONujJMQKtfX0iukAzeIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170557; c=relaxed/simple;
	bh=pcbBSEOaYdDpx4xhl+4Ai8sZ4IvENt0icA1nT6MrNCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isaZD7c1FB1tJZpYV2WKPkW54Hm462tsierLjEHnCwGsPt9VKLvb8BkAmBGYgLoAoe2DnalU2Y+sPjg26bhPKR7jp98KOqEPwRXCL4uMKhmeGzEtxJURyeGSxZuNEd/O4pNunKHHNo5Dj66OjNtulJNTbgD3u/UuTLQeq+N4gJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD3KUHVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C79C4CEC3;
	Thu, 17 Oct 2024 13:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170556;
	bh=pcbBSEOaYdDpx4xhl+4Ai8sZ4IvENt0icA1nT6MrNCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kD3KUHVh1tofmIpCByHH3oddeWbvkLdMkum2LWq8sdmJ+yYLxqe0KKVR+kEaFAccS
	 8wWpktZT1qHbkCsszGLjlnNjtivdPnI6egPdrWBK253LO99mPOFooajIygeQW5ebl/
	 caWSr4k6PpF3eQLayCtFBKdPLWT9lIYdYWXymX1N5wcMHcj/GLTRC00kaP7XnM0U0x
	 K2Zgke8mjLIMxHbaMfqzcvl0eIBUT3eMrOQAwkzzp+kAqnV1fwk5msqz5TLpY/eh/I
	 MFxgkYBT1/FlVeW7ccYH9RdfFLruEtJUNJeU9rNtA6r3Ybxu3sdr0qFXl0eWLVLj6O
	 Dmw2erjDutTUQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 17 Oct 2024 15:04:39 +0200
Subject: [PATCH v3 12/13] rust: hrtimer: add clocksource selection through
 `ClockSource`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-12-59a75cbb44da@kernel.org>
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

Allow selecting a clock source for timers by passing a `ClockSource`
variant to `Timer::new`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs | 52 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index 1674d1dcba39cc7ab82e1f189002afa365ee9341..f3d57c6cb1a95075c28192b5cd2f97431989a0b1 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -57,7 +57,7 @@ unsafe impl<U> Sync for Timer<U> {}
 
 impl<T> Timer<T> {
     /// Return an initializer for a new timer instance.
-    pub fn new(mode: TimerMode) -> impl PinInit<Self>
+    pub fn new(mode: TimerMode, clock: ClockSource) -> impl PinInit<Self>
     where
         T: TimerCallback,
     {
@@ -70,7 +70,7 @@ pub fn new(mode: TimerMode) -> impl PinInit<Self>
                 unsafe {
                     bindings::hrtimer_init(
                         place,
-                        bindings::CLOCK_MONOTONIC as i32,
+                        clock.into(),
                         mode.into(),
                     );
                 }
@@ -442,6 +442,54 @@ fn from(value: TimerMode) -> Self {
     }
 }
 
+/// The clock source to use for a [`Timer`].
+pub enum ClockSource {
+    /// A settable system-wide clock that measures real (i.e., wall-clock) time.
+    /// Setting this clock requires appropriate privileges. This clock is
+    /// affected by discontinuous jumps in the system time (e.g., if the system
+    /// administrator manually changes the clock), and by frequency adjustments
+    /// performed by NTP and similar applications via adjtime(3), adjtimex(2),
+    /// clock_adjtime(2), and ntp_adjtime(3). This clock normally counts the
+    /// number of seconds since 1970-01-01 00:00:00 Coordinated Universal Time
+    /// (UTC) except that it ignores leap seconds; near a leap second it is
+    /// typically adjusted by NTP to stay roughly in sync with UTC.
+    RealTime,
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
+    /// A nonsettable system-wide clock that is identical to CLOCK_MONOTONIC,
+    /// except that it also includes any time that the system is suspended. This
+    /// allows applications to get a suspend-aware monotonic clock without
+    /// having to deal with the complications of CLOCK_REALTIME, which may have
+    /// discontinuities if the time is changed using settimeofday(2) or similar.
+    BootTime,
+    /// A nonsettable system-wide clock derived from wall-clock time but
+    /// counting leap seconds. This clock does not experience discontinuities or
+    /// frequency adjustments caused by inserting leap seconds as CLOCK_REALTIME
+    /// does.
+    ///
+    /// The acronym TAI refers to International Atomic Time.
+    TAI,
+}
+
+impl From<ClockSource> for bindings::clockid_t {
+    fn from(value: ClockSource) -> Self {
+        match value {
+            ClockSource::RealTime => bindings::CLOCK_REALTIME as i32,
+            ClockSource::Monotonic => bindings::CLOCK_MONOTONIC as i32,
+            ClockSource::BootTime => bindings::CLOCK_BOOTTIME as i32,
+            ClockSource::TAI => bindings::CLOCK_TAI as i32,
+        }
+    }
+}
+
 /// Use to implement the [`HasTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.

-- 
2.46.0



