Return-Path: <linux-kernel+bounces-386965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62589B4A40
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC001F23B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9167B206944;
	Tue, 29 Oct 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqKqx8ik"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F44206508
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206503; cv=none; b=HtRG6olmbxRFmllVHkk/Od4LYNGtd8xryZ8Jtq+5Of9hGIRI+he9Pg8uW0o1ORnmBNHEpLTd5wHLqsao1/Jz9z9B74BPIW9YyNQqPBwyzg8k1C2jmrKciyyna8KsjLtA/KbONA0iez9QwTL5C0SxQ0slwdCVum4IQ3W4zsPQlms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206503; c=relaxed/simple;
	bh=6aXvULtk6P46L533gMCv6UHWYGmMTNxFbGJJ5TXot5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMzl4a8DHbwPpBhgw4JTnFEZhRVwOi5sJHsHNQbKu+c9LGEuo8V4eb7TG5GGN5p2speakPGp9T2lTvq6fhTJbSOSPv75Uued/ABujdb3wwGEmdkbTQWzpjCzbqABDcXp5AUY6dtQ2eNuuO/4NKVV0s3di/4bR8kozjO0HAzm0AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqKqx8ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AC9C4CECD;
	Tue, 29 Oct 2024 12:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730206502;
	bh=6aXvULtk6P46L533gMCv6UHWYGmMTNxFbGJJ5TXot5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqKqx8ikN7289XsW9/3QNHBD7wrEnQQlj3riNwUfoyzdWs7Sm/TQocy53+B/h+yi6
	 1rgUduRlUT6keVbL64qb5wJyIhdlPNC0iHJLW7NUGzbDZGUbPpLFHseioy2dZ4h/C3
	 JyQmH1UH0qIfR1PIEO9Arf9K3fezsfcvnALjZwrfGPglDlU6AgGfDduk7wfL4fFPCL
	 4VkfsG2mNX3qbzukUZ4ZfB4+g5IhexksbP8M8wDnJj4C4aP/r2ownX1vmZMYgLUjRu
	 EXDnEVw8sgv+G6NHOXrmD8OS+824T0o0pRESJA4PDoVcgjGkgoGyKu6e36ye5rOBoq
	 u2msMVgfIF+GQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 03/10] tick: Remove now unneeded low-res tick stop on CPUHP_AP_TICK_DYING
Date: Tue, 29 Oct 2024 13:54:44 +0100
Message-ID: <20241029125451.54574-4-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241029125451.54574-1-frederic@kernel.org>
References: <20241029125451.54574-1-frederic@kernel.org>
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


