Return-Path: <linux-kernel+bounces-284239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B4A94FEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366CE1C22865
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D554A282E2;
	Tue, 13 Aug 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="V5Jtbr6k"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B384963A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534226; cv=none; b=MB/3MWPXvoI1UJsDsFzfUXdulK4tuxZlYvcWIKl5QWCyfgksuwaixzwKnCEFKnDV/KZJvnp1KnZNd59mwZxd+Oyt3yshEJWFABOxdV/HEViTCQts/dwsQ/gDANcw0zUghMZG3z75CxAIKrqX9D9QTSse44AHpo1d9DeFMz0DBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534226; c=relaxed/simple;
	bh=zrTAqWiLAAsh9tVVy+FH95Bw/7Ut15R3A4TQBPkX+TM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rBXHlJIKapy3wtSr7P+zwsYotWE3WqGLSfxdXJSeXKF8VaaUYQ2dCFjKjopZikKnNzC7nSwLccIh2SVVumsyTsRuBaKJ4B6VANdVFpf/JG1Phsg7OHJNrskCSfGnlQsKE1e8J+nhfQtVkmpwKoR1tZnwnuAFHgNVukvdHoa+VEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=V5Jtbr6k; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240813073020ca4abcdae89ab64d43
        for <linux-kernel@vger.kernel.org>;
        Tue, 13 Aug 2024 09:30:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pIkqg8KMV/lyg7HaVrI3AjeV1ESCptZSt4qAAQYcmfw=;
 b=V5Jtbr6koEm95PlO01a4cHiViha49mfRFMzqxqJLMfMqn1J7KS+zBm6X5tAMTe41kqowK4
 mI26tpC/jkablL6/Kfi7tJV+jwQD1XxKAiFiFROiHL0LYbpyw2GKT7owQeSn80+6MY7cL3sw
 0/TTxYNi+NFHyEiq/qBZsdKC11TgIu3269wuj5MrWGj1Wfpuh0DC2u2RNXBhL0OLkll0AeYZ
 vrPb/VBA4LaQEmPW/zUSZVTldNzffR8xNLKNQjBtxMyAVow9YYvHemWKtGFkYd2xlDYOQPTz
 Ioh/3Sm7uxmUov88hBRMzGUonb+x8uGxF9cdi42FK2h0JNSc0Mhs+8jQ==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	jan.kiszka@siemens.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	qyousef@layalina.io,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v3 1/1] hrtimer: use and report correct timerslack values for realtime tasks
Date: Tue, 13 Aug 2024 09:29:53 +0200
Message-Id: <20240813072953.209119-2-felix.moessbauer@siemens.com>
In-Reply-To: <20240813072953.209119-1-felix.moessbauer@siemens.com>
References: <20240813072953.209119-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

The timerslack_ns setting is used to specify how much the hardware
timers should be delayed, to potentially dispatch multiple timers in a
single interrupt. This is a performance optimization. Timers of
realtime tasks (having a realtime scheduling policy) should not be
delayed.

This logic was inconsitently applied to the hrtimers, leading to delays
of realtime tasks which used timed waits for events (e.g. condition
variables). Due to the downstream override of the slack for rt tasks,
the procfs reported incorrect (non-zero) timerslack_ns values.

This is changed by setting the timer_slack_ns task attribute to 0 for
all tasks with a rt policy. By that, downstream users do not need to
specially handle rt tasks (w.r.t. the slack), and the procfs entry
shows the correct value of "0". The special handling of timerslack on
rt tasks in downstream users is removed as well.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 fs/proc/base.c          |  9 +++++----
 fs/select.c             | 12 +++---------
 kernel/sched/syscalls.c |  8 ++++++++
 kernel/sys.c            |  2 ++
 kernel/time/hrtimer.c   | 18 +++---------------
 5 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675..7ff3618c1e6f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2569,10 +2569,11 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
 	}
 
 	task_lock(p);
-	if (slack_ns == 0)
-		p->timer_slack_ns = p->default_timer_slack_ns;
-	else
-		p->timer_slack_ns = slack_ns;
+	if (task_is_realtime(p))
+		slack_ns = 0;
+	else if (slack_ns == 0)
+		slack_ns = p->default_timer_slack_ns;
+	p->timer_slack_ns = slack_ns;
 	task_unlock(p);
 
 out:
diff --git a/fs/select.c b/fs/select.c
index 9515c3fa1a03..153124ed50fd 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -77,19 +77,13 @@ u64 select_estimate_accuracy(struct timespec64 *tv)
 {
 	u64 ret;
 	struct timespec64 now;
-
-	/*
-	 * Realtime tasks get a slack of 0 for obvious reasons.
-	 */
-
-	if (rt_task(current))
-		return 0;
+	u64 slack = current->timer_slack_ns;
 
 	ktime_get_ts64(&now);
 	now = timespec64_sub(*tv, now);
 	ret = __estimate_accuracy(&now);
-	if (ret < current->timer_slack_ns)
-		return current->timer_slack_ns;
+	if (ret < slack || slack == 0)
+		return slack;
 	return ret;
 }
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ae1b42775ef9..195d2f2834a9 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -406,6 +406,14 @@ static void __setscheduler_params(struct task_struct *p,
 	else if (fair_policy(policy))
 		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
 
+	/* rt-policy tasks do not have a timerslack */
+	if (task_is_realtime(p)) {
+		p->timer_slack_ns = 0;
+	} else if (p->timer_slack_ns == 0) {
+		/* when switching back to non-rt policy, restore timerslack */
+		p->timer_slack_ns = p->default_timer_slack_ns;
+	}
+
 	/*
 	 * __sched_setscheduler() ensures attr->sched_priority == 0 when
 	 * !rt_policy. Always setting this ensures that things like
diff --git a/kernel/sys.c b/kernel/sys.c
index 3a2df1bd9f64..e3c4cffb520c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2557,6 +2557,8 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			error = current->timer_slack_ns;
 		break;
 	case PR_SET_TIMERSLACK:
+		if (task_is_realtime(current))
+			break;
 		if (arg2 <= 0)
 			current->timer_slack_ns =
 					current->default_timer_slack_ns;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b8ee320208d4..18eea0be706a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2072,14 +2072,9 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	struct restart_block *restart;
 	struct hrtimer_sleeper t;
 	int ret = 0;
-	u64 slack;
-
-	slack = current->timer_slack_ns;
-	if (rt_task(current))
-		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
-	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
+	hrtimer_set_expires_range_ns(&t.timer, rqtp, current->timer_slack_ns);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
@@ -2249,7 +2244,7 @@ void __init hrtimers_init(void)
 /**
  * schedule_hrtimeout_range_clock - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
+ * @delta:	slack in expires timeout (ktime_t)
  * @mode:	timer mode
  * @clock_id:	timer clock to be used
  */
@@ -2276,13 +2271,6 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 		return -EINTR;
 	}
 
-	/*
-	 * Override any slack passed by the user if under
-	 * rt contraints.
-	 */
-	if (rt_task(current))
-		delta = 0;
-
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
@@ -2302,7 +2290,7 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
 /**
  * schedule_hrtimeout_range - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
+ * @delta:	slack in expires timeout (ktime_t)
  * @mode:	timer mode
  *
  * Make the current task sleep until the given expiry time has
-- 
2.39.2


