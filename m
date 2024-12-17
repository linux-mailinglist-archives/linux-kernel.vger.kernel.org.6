Return-Path: <linux-kernel+bounces-449452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BD29F4F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0861882584
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D896A1F8AC4;
	Tue, 17 Dec 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9+aVcZ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19AD1F8906;
	Tue, 17 Dec 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448795; cv=none; b=IyTrmz3AbC+BvaDdS0RYtRfsyR8GatxnwLSFv62j6igzNu8ztqsqh83YCAjSg7gPRWipqpFp/LhZ+OQaAXHJF+44fcgZux22+o5oFSyWcu7Kk9GdGS74wtv4RiREv3xJQgYYc+rTNtb/4mAQSIB0DxuSA6ybsmPOo03uDyli/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448795; c=relaxed/simple;
	bh=9FNldwPp52UQBwi+GTczE3aFsHu8VA7iPdgnD1jtrW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kUrL9EwM0i95EeWETriaJoOu+Aad3HT4MDCyO1alrKOwkJWNbEnnKeOuxVKH2ZoWSnZGTskdqGbO9BaFM4aTzryIrATrTvFe7Gx/nyxPn1b/NatP3glXbEUgSF94rTqZ6ssozzTWK/CkPMDHAL78IUDj4SQznkWRF2akcsBnVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9+aVcZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD4EC4CEDD;
	Tue, 17 Dec 2024 15:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448795;
	bh=9FNldwPp52UQBwi+GTczE3aFsHu8VA7iPdgnD1jtrW0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m9+aVcZ1ovDl6R4zpRgyYkvsmI7bfhYhHuQW2xFooFv8yfA5uPtswpLUOYOwfoDbo
	 aERx9mnOwEJ89uF9qHxlAX4TNkcfWqm+UE8JJpLSFRetSz3JGoFrBSihuy5krww46U
	 bcIjpJGaA0ysJe+zA0LChCqSp/crl5PjygCkjyjy7mwmjTrm9FQiTHu+Y9s8jVBDwC
	 ctlG2gqQuh2XNs3PnsmUqF8N6viKZEQsfMLMGfPjXfAnGlnq0/VOvcIpsjMgOKBmII
	 kKgGtDU+aoHOmCWfAAox3tEGL6wxp9w0VeoZETnmmploeUyccsJ+YA0l3lAJltqQDw
	 q6qqsrjaTuRVA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:44 +0100
Subject: [PATCH v5 13/14] rust: hrtimer: add clocksource selection through
 `ClockSource`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-13-b34c20ac2cb7@kernel.org>
References: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
In-Reply-To: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
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
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4032; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=9FNldwPp52UQBwi+GTczE3aFsHu8VA7iPdgnD1jtrW0=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYdUHeHPy30TnlbH6nEd8VUbZrsFXanj9Qou
 CTWEIZv2GCJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWHQAKCRDhuBo+eShj
 d3b6D/9hXRtjJyRBMiwgOOzGEUlPaILg+QpYQEqN8KaDw8GR5lSYo2p1VCRJwTRvFu3JHwR3mCd
 +mPQmeD3XLmPTNTTi8oSTatyPN/R7/0Xks1Yussl8YeckxRyrsKwIzj0fXgdq7wtPyjVNrmlRPk
 xQMNEv4lmxRMecThEcekC1SiPCkqmq0SvZ6jyyFeXKuVFozMEfmC5KNU91A3bkWlxhn2DpodPlW
 nhhjADHub/rE107dOT4E/sFdDGNTEHXPRjEZLWoyhLw/+bTQ7prT7IHr7JmO6mi4YSOHHbnsqya
 rqgAHH6HIfwVqW5/Xh/Df8cuUBoCrIC/gF3Ajwb+iyZHR1j0lWUO6FBVE5bbmvduIh4Vjh/AmZc
 xwBEGRlgUk+02zdc6RluvYx48BgK2//LbqrALhG5aVrcI/XHrCNtO9Ia8ccs8bpL8GkLjDpbWNp
 y0LaA4j1i/Z9ubHZdFd2+WYdiB7C+O9f/uX0mKw4VKbrHdVN3c4Ljo+6d7TgCTbqH+Yh9BmvngY
 Z1VGQGEfbkyhJ3euFtlFuQqg7rOJHoazyCPrcRWBpIBIALp43MydsGXBQ9Y9OAn0VJGycDrjpsA
 z8H7vrZRS5a4dy4AL9kS/N3qG2bkrAyh5RTyJk9j90P2l6wVklfE2GNQcckoubU82ho1GSPiQEm
 srd6cOxMC6427tw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow selecting a clock source for timers by passing a `ClockSource`
variant to `Timer::new`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 52 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 17cf7c1d704d5e900ad4d08e642e02b1e518badf..f9be0fa43c896a09439601bea825e5b17d0e995d 100644
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
2.47.0



