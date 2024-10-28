Return-Path: <linux-kernel+bounces-384282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A0A9B28E9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A67A1B21847
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E921DCB3A;
	Mon, 28 Oct 2024 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b5CFTuhA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VHzhmV+U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E11DA109
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100748; cv=none; b=QTT7+/mJ6uGdx1UTApdxKm4m6ZUQOzIfeYx91/kRSwtgSC3gqYmd00oKHfXGPxjqadYCcl/ueuQZ20Qk7m7yrLgC2zPUZ9xCpgiIkyhbQY+IpyjADvBOwPeePIw9smf4KF34xzp+TLyAiWgO4F/Ta5LnjtSn9/SXC6Oqrerp+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100748; c=relaxed/simple;
	bh=R/JV9EZmAnsOfvYNISqRPW34yAoYN0tB9a88AkngsXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gg4oh9OHJ5nQ8B1nLWweLqbAIDyjQQ0gXVeGfUw2KqdvFNWDv8UVtg70TMVrqyHofKFae/MQaSi84nS1slkxXfGpdS7R5w3DSl4FGxfgqJVLjV1/+BFEu6WcnZV807fN7IyCM7GZEfQmJ9hltQ4nkWiks/6B1Q16kZz81K3+ETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b5CFTuhA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VHzhmV+U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDwyCLcsjSW0TN6AweNduUtpoLabOWtIspLAF0L+hZY=;
	b=b5CFTuhAgLScM/fgLykEN98jNcu5x/IF8cWvmu5txrUA1xoHcpSk/yZto/uSTs81voJ4TR
	OwznVXfiZImro9mc+zKv5Svi7eZPkDWbG19jNaZjN0dw0u4oGTqnxUh6eArRMWOpNKuikR
	ZQ7tluRpzbpv+Tq/zF1Fvdc2htUYkURuk/uKIQplMk4IzKu8pN1azGHBQHJPcfDuMC2m6h
	TIRdFxC+KXGvvSXUuSy3j3DWjp+qUBtIiNCNf/vyhVXOU03XWh0Bsxtg/O4bRXkrQut4RX
	BOyiBQkUmiNtN5jHl1OPLl2DAky5HbodxxsXne8jeRwgok/9TrmvSjOaJZvV6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDwyCLcsjSW0TN6AweNduUtpoLabOWtIspLAF0L+hZY=;
	b=VHzhmV+UPwrhEkP3yH9GJJ9APCbPP0uiyZbUfycUCKnkoPzh0+wW2+ZE3BuGaGbe5/7VTs
	T7cMVHSroDVW/LBg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	John Stultz <jstultz@google.com>
Subject: [PATCH 20/31] time: Switch to hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:53 +0100
Message-Id: <219ac422c7baf22e194e79d651cf1443f11d6b8c.1729864823.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864823.git.namcao@linutronix.de>
References: <cover.1729864823.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: John Stultz <jstultz@google.com>
---
 kernel/time/ntp.c                    | 3 +--
 kernel/time/posix-timers.c           | 7 +++----
 kernel/time/sched_clock.c            | 3 +--
 kernel/time/tick-broadcast-hrtimer.c | 3 +--
 kernel/time/tick-sched.c             | 6 ++----
 5 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index b550ebe0f03b..577e11d1b191 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -678,8 +678,7 @@ void ntp_notify_cmos_timer(bool offset_set)
=20
 static void __init ntp_init_cmos_sync(void)
 {
-	hrtimer_init(&sync_hrtimer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
-	sync_hrtimer.function =3D sync_timer_callback;
+	hrtimer_setup(&sync_hrtimer, sync_timer_callback, CLOCK_REALTIME, HRTIMER=
_MODE_ABS);
 }
 #else /* CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC) */
 static inline void __init ntp_init_cmos_sync(void) { }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index fc40dacabe78..f3acb16d6254 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -430,7 +430,7 @@ static void posix_timer_unhash_and_free(struct k_itimer=
 *tmr)
=20
 static int common_timer_create(struct k_itimer *new_timer)
 {
-	hrtimer_init(&new_timer->it.real.timer, new_timer->it_clock, 0);
+	hrtimer_setup(&new_timer->it.real.timer, posix_timer_fn, new_timer->it_cl=
ock, 0);
 	return 0;
 }
=20
@@ -784,7 +784,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, k=
time_t expires,
 	/*
 	 * Posix magic: Relative CLOCK_REALTIME timers are not affected by
 	 * clock modifications, so they become CLOCK_MONOTONIC based under the
-	 * hood. See hrtimer_init(). Update timr->kclock, so the generic
+	 * hood. See hrtimer_setup(). Update timr->kclock, so the generic
 	 * functions which use timr->kclock->clock_get_*() work.
 	 *
 	 * Note: it_clock stays unmodified, because the next timer_set() might
@@ -793,8 +793,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, k=
time_t expires,
 	if (timr->it_clock =3D=3D CLOCK_REALTIME)
 		timr->kclock =3D absolute ? &clock_realtime : &clock_monotonic;
=20
-	hrtimer_init(&timr->it.real.timer, timr->it_clock, mode);
-	timr->it.real.timer.function =3D posix_timer_fn;
+	hrtimer_setup(&timr->it.real.timer, posix_timer_fn, timr->it_clock, mode);
=20
 	if (!absolute)
 		expires =3D ktime_add_safe(expires, timer->base->get_time());
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 68d6c1190ac7..39017f1f8486 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -249,8 +249,7 @@ void __init generic_sched_clock_init(void)
 	 * Start the timer to keep sched_clock() properly updated and
 	 * sets the initial epoch.
 	 */
-	hrtimer_init(&sched_clock_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	sched_clock_timer.function =3D sched_clock_poll;
+	hrtimer_setup(&sched_clock_timer, sched_clock_poll, CLOCK_MONOTONIC, HRTI=
MER_MODE_REL_HARD);
 	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL_HARD);
 }
=20
diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadc=
ast-hrtimer.c
index e28f9210f8a1..a88b72b0f35e 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -100,7 +100,6 @@ static enum hrtimer_restart bc_handler(struct hrtimer *=
t)
=20
 void tick_setup_hrtimer_broadcast(void)
 {
-	hrtimer_init(&bctimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	bctimer.function =3D bc_handler;
+	hrtimer_setup(&bctimer, bc_handler, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HAR=
D);
 	clockevents_register_device(&ce_broadcast_hrtimer);
 }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 753a184c7090..bcea3a9fe638 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1572,12 +1572,10 @@ void tick_setup_sched_timer(bool hrtimer)
 	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
=20
 	/* Emulate tick processing via per-CPU hrtimers: */
-	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
+	hrtimer_setup(&ts->sched_timer, tick_nohz_handler, CLOCK_MONOTONIC, HRTIM=
ER_MODE_ABS_HARD);
=20
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && hrtimer) {
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && hrtimer)
 		tick_sched_flag_set(ts, TS_FLAG_HIGHRES);
-		ts->sched_timer.function =3D tick_nohz_handler;
-	}
=20
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
--=20
2.39.5


