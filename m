Return-Path: <linux-kernel+bounces-551996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD73A573DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189111899DED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D603B25A34F;
	Fri,  7 Mar 2025 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF7Zqs+z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B292459F6;
	Fri,  7 Mar 2025 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383669; cv=none; b=iPhjpmUtdMPilk32BSvOo35V4mILpYLqtNSReJcM999g6E2X+I8Su0/itYblWE6p9A/EWH4XCLByVnIP5JtLHZTu57svDpfblCEPAX3/xSFl2YvjWvXBRbgXlLsFd218BmO/DNLE+1C1etPlyZMGsOIwrJs1mQpweg73diEmPT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383669; c=relaxed/simple;
	bh=6qkooi3B1u/j+X2E8Y+Wol50H//30QxUSdGcR9hM7AA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WizCHsgICP3mM+xpov6P9t/ifWISPj6wS8p0leza3egLLfEK1FmPiE295+3YUqPV76EKuHzoiH8KuaEwrOAqKzVsAYl5oMR7918i5SzJIO2f/1nxwR/vKZBOh4XQ/32fL9HhbOI3dymRg0S9xiU7qBW5omrOwmJk9Cl1qy1fqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF7Zqs+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFFCC4CEEC;
	Fri,  7 Mar 2025 21:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741383668;
	bh=6qkooi3B1u/j+X2E8Y+Wol50H//30QxUSdGcR9hM7AA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fF7Zqs+z1pSrwnOCAu6klnOakr8F3Xaa0wsWzuGPxACnASfgam0eK47gPeEgUilKJ
	 GjJazRgesbaCbANBiTzdRFd6Ta6LVeSGxxK1rirtF+XGZFNjjS0VKuh3kSx/2fz2J3
	 7WHEKN27wDhlR15oBBjJEDcE5eYzOw2hyCxdQgKAjbyHfjOvaIyYGLCyUfY8l+hZvr
	 cDCc2gPH515rIr1QX5VRxJE7/OdNXxPaTB30vdIZpv+B7SksMLjbLpnnYywzJQu93y
	 ukP3UM2r7Ujg3zKBPVlRNdir353bW0Cq/hchhztgiR+s0ilQMKixCxxfugRvCXCtVg
	 mcz9jDpSV7esg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 22:38:53 +0100
Subject: [PATCH v11 12/13] rust: hrtimer: add clocksource selection through
 `ClockId`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v11-12-7934aefd6993@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5570; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=6qkooi3B1u/j+X2E8Y+Wol50H//30QxUSdGcR9hM7AA=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBny2d0koMifcrJGDJ28KxAtRgJOQiY1BpIucpKF
 0msesDdAxyJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8tndAAKCRDhuBo+eShj
 d7xZD/9WxngKNtWco6FWPM5P7cTkC3sLIg6C2SbmANOFExx/kF6QyVtvC1XoOpUcaa4XXNt+dFd
 N1WCQDA3/AF0Co+hRPXqEm9N3tvTn1ARpuKf9ru/ZAtId0MKYV5NPjAnpWOu/xMMQWegkH8URl4
 k7na1x3BlvUvik1NHtsIpX31AupDGSufi4SnF4Oi6IScON2rzatRMAkdWQOQuigWw3BZX22ppHq
 k5Rc/Yc5G9QCaYfASTMYtfzHAFu9vS2XQUV7B0qkRwMG+OiMqLSVFe3QtVrrWocmpeDCnsee8ur
 DJgsrAdEPJl2oHssbdoJHpw2iKqLxrz1hwiGIFkfzzJgP0xqPxDXWSQjOKnM9rH3YjnhdoAULJs
 cPQjKM/KiNarNQ+f+h8cLAm2kBVlDcac5JsJXchpTfwWH72zN+g9mwHlGrQFqtJKg0JcAsVlVmw
 hp+l2p9e7DGGEx2UXooQNPiMGRrGTG68I5styv6+XVDDG5l6ozQkg9sQ2IaPMoVbdadwe8x0zeO
 Z2ixL1UZ8FmagIrXWQEl8BhwXt4x6idfxmg+y8fVcCuR7XNQUocqJAP5CatrDu6HmpaJzvXDX8N
 u0Rdqwbxvu8xY25NnKCexaRh1z44AeCNOmrDYtfjdIBcScyLBS1n1WrdiAWxWQnqpCGgt2rY0Ch
 97cbL5pFRkTSE1A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow selecting a clock source for timers by passing a `ClockId`
variant to `HrTimer::new`.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
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
index 2b7ab112e187..a75df68bbda9 100644
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



