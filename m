Return-Path: <linux-kernel+bounces-370227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA11F9A2994
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1F528292A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786D01DFE1B;
	Thu, 17 Oct 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaTz8Z2m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F61DEFE5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183852; cv=none; b=R2KGhYJtcyKjYCPcucM1Wv90v2g3Bmpj/4qt7WpkfjsgPSQgEGYMgWZgELJBDuRrJffWzDevvlDW2ZO/1uqLOgv/5zLVi6mLUn3cDqWdJYv/VB04NGiRMscq2nN/l+e7n1e/lmCGArrU1BABfpvRdtAje/VKmyVmLGiNOtFi9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183852; c=relaxed/simple;
	bh=6aXvULtk6P46L533gMCv6UHWYGmMTNxFbGJJ5TXot5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltbQLJkvlyOuC7GHMcOGHgUILJsvIJLltJhiFsl/du1IKjuTeh3CVBc9kkC1HDrfOw/EIxZ+ne3/oV410V7+O8cH4Y49MdM/torjSEGpru/tnr55t16yZVLQ3DtaOZxF3XNraq1WDlDOVMxfFdACy7/sNQYNRx9b36WZHecSYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaTz8Z2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCBAC4CECD;
	Thu, 17 Oct 2024 16:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183852;
	bh=6aXvULtk6P46L533gMCv6UHWYGmMTNxFbGJJ5TXot5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaTz8Z2mU1Ob+nyqvi409KbvSvdQAUAd003Em9Upkk9cekH855Hyk7JrfPHPFVd80
	 OxLlKlXayRescmRDn44IZkVyR4gLdoJV8RnpcouPj+OUZHDv4wacmVtdrIl64i1dlC
	 HSVq1Bh59SYwSkL7VVBloEK/5AVSk4rBRjYrKyBwvHtxMPgil1gx+WZCvSfwhtbzOF
	 2nfZ/mJF+GZEd5EkFnGhgOFpFpejSARZxJCYjrH9Jp0FS6qd7BKGrNX0fZkgQ6v6Sa
	 AMOtmAQcMx9WojQJvizo8tmlG61AQKcpFFQa72FfWJUd4yFLwijK/Ww8qYYJ+IaTES
	 948pDpCDyRTLg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 03/10] tick: Remove now unneeded low-res tick stop on CPUHP_AP_TICK_DYING
Date: Thu, 17 Oct 2024 18:50:34 +0200
Message-ID: <20241017165041.6954-4-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017165041.6954-1-frederic@kernel.org>
References: <20241017165041.6954-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic clockevent layer now detaches and stops the underlying
clockevent from the dying CPU, unifying the tick behaviour for both
periodic and oneshot mode on offline CPUs. There is no more need for
the tick layer to care about that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 753a184c7090..9f90c7333b1d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -311,14 +311,6 @@ static enum hrtimer_restart tick_nohz_handler(struct hrtimer *timer)
 	return HRTIMER_RESTART;
 }
 
-static void tick_sched_timer_cancel(struct tick_sched *ts)
-{
-	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
-		hrtimer_cancel(&ts->sched_timer);
-	else if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
-		tick_program_event(KTIME_MAX, 1);
-}
-
 #ifdef CONFIG_NO_HZ_FULL
 cpumask_var_t tick_nohz_full_mask;
 EXPORT_SYMBOL_GPL(tick_nohz_full_mask);
@@ -1055,7 +1047,10 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * the tick timer.
 	 */
 	if (unlikely(expires == KTIME_MAX)) {
-		tick_sched_timer_cancel(ts);
+		if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
+			hrtimer_cancel(&ts->sched_timer);
+		else
+			tick_program_event(KTIME_MAX, 1);
 		return;
 	}
 
@@ -1604,21 +1599,13 @@ void tick_setup_sched_timer(bool hrtimer)
  */
 void tick_sched_timer_dying(int cpu)
 {
-	struct tick_device *td = &per_cpu(tick_cpu_device, cpu);
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
-	struct clock_event_device *dev = td->evtdev;
 	ktime_t idle_sleeptime, iowait_sleeptime;
 	unsigned long idle_calls, idle_sleeps;
 
 	/* This must happen before hrtimers are migrated! */
-	tick_sched_timer_cancel(ts);
-
-	/*
-	 * If the clockevents doesn't support CLOCK_EVT_STATE_ONESHOT_STOPPED,
-	 * make sure not to call low-res tick handler.
-	 */
-	if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
-		dev->event_handler = clockevents_handle_noop;
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
+		hrtimer_cancel(&ts->sched_timer);
 
 	idle_sleeptime = ts->idle_sleeptime;
 	iowait_sleeptime = ts->iowait_sleeptime;
-- 
2.46.0


