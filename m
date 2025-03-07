Return-Path: <linux-kernel+bounces-550848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43520A564F9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBE8167F1E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9452116F6;
	Fri,  7 Mar 2025 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oksvQGZa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F7213E9E;
	Fri,  7 Mar 2025 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342697; cv=none; b=JPOcIbKk3ZV9caUEE+gGVpRIt53xMfyxm3XkKKf6uL5j5AjIle+1UyrovdIDHZiXkUgYz8+oNaQ4ErA9yn/LfmhVNn2FM+SpNYyRWUT4KEPEVecy/dtJQH5N2vCtC0wlFPaU+FMm1At3bwPINpRCzxNOK0TXyAc9rc5l4sE0jYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342697; c=relaxed/simple;
	bh=ZveO4w9Rr+A3ScDbC9K40c0DZgZelyjryLpnTvdyjIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bVN6XCZzQRLlTfpkoohjl1wK/fc+348xpClZzfb7HjaVql3xGnrhDUUXaPGCfdLFFlxw4QhzOL9W2Gzj2jpnzbFaa6gv34VeQKA0/x6ppRgx9DjHnXiB4glL1eIwuDzJIQCgZUOin7VegZmyUbUijvJBxUbicqEDQu9wLCbwvxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oksvQGZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD27C4CED1;
	Fri,  7 Mar 2025 10:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342697;
	bh=ZveO4w9Rr+A3ScDbC9K40c0DZgZelyjryLpnTvdyjIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oksvQGZad8xu4MyXJ7ozwSFOemSIVEadK93ZY51fCwmq9enbMdQCTcCKl0gGK+9h/
	 taSh8+eJ83PaYNqM8PT3EEdA6kNHaZuJQAk6KuPSDdelDfI2pvkYHJtYeMVEqhRxDK
	 0Ypr+fFxWecm/G2HqBqEfbcD/a57Bzf/Vt16zyHEXaFC/aLDDbYiJ94ivBruKRESF/
	 Cr3iHvKmBCFXDE2ZQPBB8KyD7qgEcD+xhUUCRwuSzya6083RZijeQx4maFU4Q0LZGY
	 hLMMCtEmxLu7y6Kp071nBOi+ZOUxkJLlMWAAbw5fgvRW4z4kwk3UgU5gbFVU4dKrt/
	 huUL9IP5NJetg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 11:11:57 +0100
Subject: [PATCH v10 12/13] rust: hrtimer: add clocksource selection through
 `ClockId`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v10-12-0cf7e9491da4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5518; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ZveO4w9Rr+A3ScDbC9K40c0DZgZelyjryLpnTvdyjIo=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnysaBvIjmZzQvi1r5ZppDNfPhOA28QC8upn3Bc
 XMxLl6MKaKJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8rGgQAKCRDhuBo+eShj
 d56+EACIr2XARK4XGJQLNjKKqVoSR4Ud33cqxyXh7Og0skI8DXDhcyXeOd5gGsM1S1/AsXcEmSs
 fGbtiKM29qykD7i6almFFInVg4SaLwTSTHW3HuypaOKcL9gPpK6Pc6dWqMhUqpCim7AMmH92Ez/
 mV/zPJ3EmwjxBg9q14uSdaEquZomQ7Q/DHb58srBSdP87eCyb5WzYxrz28HzZMMbGxCkMWK+35n
 KIueFy2wBl0pm5MAWiV5p2L+BSUJ6y4Zz9PUUg5HLpRuMrFhRYJinsFrejabN/tZWip5cJNrXQe
 2/nKCgBmJArRrPLBV47jiVLPEJwu1Dc8EH5B9zNHN/4QwV/Vj9ljlnuqN7uckHjWOW8W04HEHN1
 Kqhs7U4SxcqwTYpNI89gg7K6k7W2FXZOhFrVGE4pm5cSTbvZsdmanjuSRRnCagqJZOPpkLPfb3u
 IuVvUDencCZW4yoiGrH1x4tpJDi2G7bMmvx2kwCm+JTjHPYxEUXUnV3GYdCE/Tf7YbzVVPx01PO
 fN099pUtr3CTFRfJ0cVQ1tWSUqm0KSFTxWHiC6qyVoyJRbYopuf5XA9/lE8uVDHE4nmjU4nr3tt
 KacRh6dM4BLvCK27gBW1BPA7WBWkDV862AhuqVbwwkaFP3HlaGu4GlNVWz67MGP5OPNzF3x1Pjl
 0uyt9L3V/0SWOvA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow selecting a clock source for timers by passing a `ClockId`
variant to `HrTimer::new`.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time.rs         | 66 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/time/hrtimer.rs |  5 ++--
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index fab1dadfa589..f509cb0eb71e 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -83,3 +83,69 @@ fn sub(self, other: Ktime) -> Ktime {
         }
     }
 }
+
+/// An identifier for a clock. Used when specifying clock sources.
+///
+///
+/// Selection of the clock depends on the use case. In some cases the usage of a
+/// particular clock is mandatory, e.g. in network protocols, filesystems.In other
+/// cases the user of the clock has to decide which clock is best suited for the
+/// purpose. In most scenarios clock [`ClockId::Monotonic`] is the best choice as it
+/// provides a accurate monotonic notion of time (leap second smearing ignored).
+#[derive(Clone, Copy, PartialEq, Eq, Debug)]
+#[repr(u32)]
+pub enum ClockId {
+    /// A settable system-wide clock that measures real (i.e., wall-clock) time.
+    ///
+    /// Setting this clock requires appropriate privileges. This clock is
+    /// affected by discontinuous jumps in the system time (e.g., if the system
+    /// administrator manually changes the clock), and by frequency adjustments
+    /// performed by NTP and similar applications via adjtime(3), adjtimex(2),
+    /// clock_adjtime(2), and ntp_adjtime(3). This clock normally counts the
+    /// number of seconds since 1970-01-01 00:00:00 Coordinated Universal Time
+    /// (UTC) except that it ignores leap seconds; near a leap second it may be
+    /// adjusted by leap second smearing to stay roughly in sync with UTC. Leap
+    /// second smearing applies frequency adjustments to the clock to speed up
+    /// or slow down the clock to account for the leap second without
+    /// discontinuities in the clock. If leap second smearing is not applied,
+    /// the clock will experience discontinuity around leap second adjustment.
+    RealTime = bindings::CLOCK_REALTIME,
+    /// A monotonically increasing clock.
+    ///
+    /// A nonsettable system-wide clock that represents monotonic time since—as
+    /// described by POSIX—"some unspecified point in the past". On Linux, that
+    /// point corresponds to the number of seconds that the system has been
+    /// running since it was booted.
+    ///
+    /// The CLOCK_MONOTONIC clock is not affected by discontinuous jumps in the
+    /// CLOCK_REAL (e.g., if the system administrator manually changes the
+    /// clock), but is affected by frequency adjustments. This clock does not
+    /// count time that the system is suspended.
+    Monotonic = bindings::CLOCK_MONOTONIC,
+    /// A monotonic that ticks while system is suspended.
+    ///
+    /// A nonsettable system-wide clock that is identical to CLOCK_MONOTONIC,
+    /// except that it also includes any time that the system is suspended. This
+    /// allows applications to get a suspend-aware monotonic clock without
+    /// having to deal with the complications of CLOCK_REALTIME, which may have
+    /// discontinuities if the time is changed using settimeofday(2) or similar.
+    BootTime = bindings::CLOCK_BOOTTIME,
+    /// International Atomic Time.
+    ///
+    /// A system-wide clock derived from wall-clock time but counting leap seconds.
+    ///
+    /// This clock is coupled to CLOCK_REALTIME and will be set when CLOCK_REALTIME is
+    /// set, or when the offset to CLOCK_REALTIME is changed via adjtimex(2). This
+    /// usually happens during boot and **should** not happen during normal operations.
+    /// However, if NTP or another application adjusts CLOCK_REALTIME by leap second
+    /// smearing, this clock will not be precise during leap second smearing.
+    ///
+    /// The acronym TAI refers to International Atomic Time.
+    TAI = bindings::CLOCK_TAI,
+}
+
+impl ClockId {
+    fn into_c(self) -> bindings::clockid_t {
+        self as bindings::clockid_t
+    }
+}
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index d06be922d8d0..f700c479cd40 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -67,6 +67,7 @@
 //! A `restart` operation on a timer in the **stopped** state is equivalent to a
 //! `start` operation.
 
+use super::ClockId;
 use crate::{init::PinInit, prelude::*, time::Ktime, types::Opaque};
 use core::marker::PhantomData;
 
@@ -94,7 +95,7 @@ unsafe impl<T> Sync for HrTimer<T> {}
 
 impl<T> HrTimer<T> {
     /// Return an initializer for a new timer instance.
-    pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
+    pub fn new(mode: HrTimerMode, clock: ClockId) -> impl PinInit<Self>
     where
         T: HrTimerCallback,
     {
@@ -108,7 +109,7 @@ pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
                     bindings::hrtimer_setup(
                         place,
                         Some(T::Pointer::run),
-                        bindings::CLOCK_MONOTONIC as i32,
+                        clock.into_c(),
                         mode.into_c(),
                     );
                 }

-- 
2.47.0



