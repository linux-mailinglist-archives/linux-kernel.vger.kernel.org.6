Return-Path: <linux-kernel+bounces-435524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17569E7904
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D48E28444B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E034204591;
	Fri,  6 Dec 2024 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwhKLQYV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953D4192B76;
	Fri,  6 Dec 2024 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513710; cv=none; b=GXVnEZhPLpKc9wEuI2AwN2c2ndYxnN5CsIWYFfOaDDtnu7SqkmDbfrGkB2FFZQSy+TR2AiZU6ph85lM6EealMHb6BMQiEmGK4Jd/nOYTqu+GG3rFv8NUe1OP/1ovkkI6b6HihO4P+2u5CunYadgmyTcQIHEcFt4h5dMFzB76diI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513710; c=relaxed/simple;
	bh=5AsfxhMcapsiSrIIx3K1wmlhpNNxyQ5cVuoVQNELSIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELFXFUnN8bdVHz0p3yg1G4aiJcUjCXw9w69Zdz+H+HgKv80coYxS73Y2T4wdBM7vyHgdlsEq5G0N3fJNizS3YdmHWUD3MyJAbBltXrzGsRpcKkcp14rg+OSGvvH50Bh1LUddKl2redNuFsWsdRtlX1GgUIMo60rdAKaay1xxMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwhKLQYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90615C4CEDD;
	Fri,  6 Dec 2024 19:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513710;
	bh=5AsfxhMcapsiSrIIx3K1wmlhpNNxyQ5cVuoVQNELSIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AwhKLQYViq5/Bd0Oit88GefPPe0RqAOv0l0R+N8Cz1XQIrYAWrSD56NVTsO6WTzqB
	 LQKqpd/8oLxMQW8BTwlP/0oLrIDgl+MCo5B5DQPMkVeHajqTn0RfO7fp9HtGAztjtr
	 MMEBN/DhmqgyKTOIgaT96dDBFfy35cUS0e1+5aWmQgnSmFwsfwys2L1MAXCCMRNA2m
	 IEc3Etgz0oRJf/fC2krp1jVKhuPM2D5ZNS88zltcWLZJTkuyOgV2PpCkdGy4Oijz0y
	 7yo3xNjeMoPQx7pkGne/UH97VHGDod2nytr6Kl119kdbEkfdKsvEvvwD23lr3sRLZo
	 VaNqGvfzO4I4Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:33:05 +0100
Subject: [PATCH v4 13/14] rust: hrtimer: add clocksource selection through
 `ClockSource`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-13-6cb8c3673682@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4032; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=5AsfxhMcapsiSrIIx3K1wmlhpNNxyQ5cVuoVQNELSIg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVhUanB5bmxpTUZOYWZodllzdklxdnROCjFnQkJHcEZDQ2dIdkc3Wlhy
 U3UrU29rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRjB
 BQW9KRU9HNEdqNTVLR04zaHY4UC8zMGlMUWg5RWloZDlJK2xwQWg1UWRneU4vaXZFNzlJN3hRKw
 owNC9iQWt2V29vT01Qb0RjOHAxWklpM0RJOGp0Szh5NE45aVlvdGkrOFBMTWpodnkzTFhYRUJ5e
 TNMN0xWV2IyCmVWWko4MnU2QnIvOUlSUGVqT1pJeDJyRWtBTmNGRzZUdDlHKzNvV3o0Q3pKTW9u
 YW9KemRraWJMWjkyR25TSTIKVjlRRmN1V3lwaEpJNEloeDZQM3M3TFpzNHRCd3FyQTFIZ01WS2l
 jZjJEYUU5R2lRcDRDUlFtOW4wSElhb2MzLwovaHZpd2NNWGhKcjR0ZGtTQ3E3NHlpQ2J5MWtNY0
 NOREJ2eTZGNWRZOVhHSlRmL0NFYm1TZDVIcUVWK0x6K2ppCkljbm9iRW0wT1o0KzU4bWxjRTY5N
 Hp1K1pLeExmZEgreDBsMmw1aGM5bXJwYVRSblZHYkJ6OGJib1VHR3d1Tk8KUVUvdmVobGExdit1
 TUMyMExEZlhidDRBY3JGbldtWDJzTUg2TnIvYlZ2SDB4VGVEdktMVXFPRDJEV2x3R2lmUgpjYlp
 meVVQbkRSRzlOYWMrN3JqWmhrUGpzeE1GR25SdTRuK0kzek1ad1NiSXJVQ0I5YXFqWXpMcVdNdU
 g4UWdSCjVMbmppU280aGJza29vT2c1S2xhd29GTXhkb3FIRUgyNXFsWTZzNXgyd3R5ampZS3ZYN
 S9KMlFPY2xGYUlySisKaGUvTlVjazJLU2lKUFhsbmRTejFyZlcrSXdoMVJJVm40Tld6b1RNMDl3
 bU9tZk95OHlCVkpab3JTelBGN3N3dQoxR0UyZVNQRTBUUjE3WXFmQUlweHZ6SDhrZWRwUStSSXd
 lbnZ3WnZ6MUhFckZhciswRjJyb3lHZmM2ZWRBT3pnCmJvWGZrdEtxRXg4NmlnPT0KPURzNGQKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow selecting a clock source for timers by passing a `ClockSource`
variant to `Timer::new`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 52 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 3bcc45dae130448173be157ce60395e2b9d46a10..ef1c404c7d3e859b8ac70316b6bb44302130dd95 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -57,7 +57,7 @@ unsafe impl<U> Sync for Timer<U> {}
 
 impl<T> Timer<T> {
     /// Return an initializer for a new timer instance.
-    pub fn new(mode: TimerMode) -> impl PinInit<Self>
+    pub fn new(mode: TimerMode, clock: ClockSource) -> impl PinInit<Self>
     where
         T: TimerCallback,
     {
@@ -71,7 +71,7 @@ pub fn new(mode: TimerMode) -> impl PinInit<Self>
                     bindings::hrtimer_setup(
                         place,
                         Some(T::CallbackTarget::run),
-                        bindings::CLOCK_MONOTONIC as i32,
+                        clock.into(),
                         mode.into(),
                     );
                 }
@@ -444,6 +444,54 @@ fn from(value: TimerMode) -> Self {
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



