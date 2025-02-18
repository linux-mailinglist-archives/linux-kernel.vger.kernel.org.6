Return-Path: <linux-kernel+bounces-519513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617E4A39DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD93B6E60
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8626E26B2BE;
	Tue, 18 Feb 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbGtZKTW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C9226B2BC;
	Tue, 18 Feb 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885307; cv=none; b=tisHondUjz+Ai6cLXZFWvs7bBzKglypS+lp5m3N/ZtEFUqGGnVzPWgp/4uyutS9Dl0k9JtsefG294/bJwbBsYXXlj3tDx8+704BQfFtXzAOM2pcsyynDA4f/G9+zKwl9L6E9/VlrcZFsZk01VtZjuDF36bupuSoWdT/1AapzBsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885307; c=relaxed/simple;
	bh=FhqC9LeTi3i3E4qvwVUGdTQsRHg4Tojfkv9D1HoCLaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LKC7wOP4c7OD79Lyoq92w0UHid7Ef4drKZ4mC+G2aOeXpA+N/S8qqxMPIM2zkCEkrTlNeE2OA8LitFcoZ1U6y+5tBgtz5KCFjAw0BLlXbA5N9bIOKbdooC6NHldhlhQN02zYAQ5JHfc+mpZhbWQ05YIHcqesufgOrTU/I4mGm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbGtZKTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B119C4CEE2;
	Tue, 18 Feb 2025 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885307;
	bh=FhqC9LeTi3i3E4qvwVUGdTQsRHg4Tojfkv9D1HoCLaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gbGtZKTW2FJWDPdnVdTEZhbjBEOKYBUPY7xUPGt53p5IaZm2EEti2wwt/0bKGjRgN
	 qhylmTn0Wx0bd2QOEcJ/WaecEOMahBUkKwImSHIVMiy3WJStaUSY1inHGmVMxbyaUU
	 zrZPPdvJc7BrAoJHwKJimo/dvimme/8QZk5H1Z1nNzcBpZU2SqAcDDrmXaJ9XRwrCl
	 e8x54eYPbe2YAFfAsXTgay9LQVWLmI5dL/YiphTS4//wnseabDuvCURdV2h3FB+cWQ
	 IL7F8n7G45yquQX95+x5G9l8Fc8A9VYyeZcYM3SCM/R5LpFE6e5u5DAQYqzImpC/kx
	 x3ZhUchNjgpow==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:18 +0100
Subject: [PATCH v8 13/14] rust: hrtimer: add clocksource selection through
 `ClockSource`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-13-48dedb015eb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3998; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=FhqC9LeTi3i3E4qvwVUGdTQsRHg4Tojfkv9D1HoCLaY=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIq7YANcgZqMzDeuuifIn4VXRQuerYmLWVIzq
 0LW2VbwvwSJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKuwAKCRDhuBo+eShj
 d06KEADFvgDST9bU+byuR3mbPkPDWudF54VYxCyLiNZuiN5ItEinvOIi/zJzqXKFS+47g6BcF9a
 nwmbAKtfNaiJHhigOGUZlyx/U4WfakMM+y8uI9bA0wjgfaFD/9IbOvlZJL4pbrCsbyjj7fBq0hw
 +Y2ZA8XR5eaEDJouSrlW2BSnI6ncQqn2hyX+eTxpkvqZvJB+Lb3O5kkRsA049Bz8Ib0twbsu++t
 qXJoOKhiwnN11vJaDUh1u5gEfC56fF9DNQJtC2/5bOynD6sl9WjfJMQd5+LT4fELpGF/oQeONbY
 Yb7SwWT6AtiGG33qnuXtENWhRUSJSpcorD3qELRycRsSq8rxLrBOaZAEPln+S20ucNgMPmrknR0
 GIQgqTD1BqJ+/o2CaX4lSDT7VY9QdJGu0/biMy1GCtuvnkFogu7A84cFG0dKQzYeDoJopu09071
 TMXNr2N0Rld68QNN+Grct/l/E1ukMwr29LKqjx2gs44HCJHseIoKndKmFU5ljYYdPeBm7nENyzA
 KShBoxfuZEJrA9mf4AoYg0G2WOlK7QDHJFJkP9u5rO8yd2KxPir6WDwqjbMfAj2bPudzqCjIMGT
 tHNw2CtR52VGZO86ccTnNKb063R2pGvS07OQY6o/QHMI7kYbf5+MA0tZQMoEFO7cV5Xx+Fkx/er
 O7c9LR63TFsCzVw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow selecting a clock source for timers by passing a `ClockSource`
variant to `HrTimer::new`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 52 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index db49061f830c3..2b46d66eaa313 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -73,7 +73,7 @@ unsafe impl<T> Sync for HrTimer<T> {}
 
 impl<T> HrTimer<T> {
     /// Return an initializer for a new timer instance.
-    pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
+    pub fn new(mode: HrTimerMode, clock: ClockSource) -> impl PinInit<Self>
     where
         T: HrTimerCallback,
     {
@@ -87,7 +87,7 @@ pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
                     bindings::hrtimer_setup(
                         place,
                         Some(T::CallbackTarget::run),
-                        bindings::CLOCK_MONOTONIC as i32,
+                        clock.into(),
                         mode.into(),
                     );
                 }
@@ -448,6 +448,54 @@ fn from(value: HrTimerMode) -> Self {
     }
 }
 
+/// The clock source to use for a [`HrTimer`].
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
 /// Use to implement the [`HasHrTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.

-- 
2.47.0



