Return-Path: <linux-kernel+bounces-286410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A2B951A98
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7506EB214F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948451AED58;
	Wed, 14 Aug 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="CZFckKv4"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58781AC43D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637469; cv=none; b=r1mkr8QA2e0nKyxuLy6VqGjfz0eAxh5ayXuEa8mhPKfZcRAHnh1w27IU6CrLa00nchnQo8C+05Hbfi36Cyy39GTw6kcdOjE36rfoXWnymWUqxT8kSrvH7xAcQsc55eK5fiHpwvTu6j+kDH9cxcnJh/vqYKGTISLghAy5OY033b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637469; c=relaxed/simple;
	bh=9omUs5eQt37eqG1ja5INiYEOWyqnnkjgd7EVy8uVX8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6FSZTcKVV0JPPdnp34qbBPbthYC78ZfjPVe/NE6x+8RATZzPtXuMIi0xla26viQnGObGRmoCqgRgr9LDFfkHPw2rgPqk0Ql5nDZ4jwdxIlzQzBUEduSzWWsNLI8PanyVWJg0pv0Wtjj7KBHbaV9FLCe/AwTa1wGw8AuYRX88ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=CZFckKv4; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202408141210555c00b4731764bb35a7
        for <linux-kernel@vger.kernel.org>;
        Wed, 14 Aug 2024 14:10:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=V4nWFMfJWPuj8vZFKQtZgJuA1Le3ETLyXy4AKLletes=;
 b=CZFckKv4l7b0gC1dqvb9BTI/sqZAiXwSi9rewnQNP6/F/aI0aOWm3LiW2VUAIb6D+J8Ct8
 GUqkXjOHxa9Yid9WyUGarFCujcZWhjxkT3+cJzFMPkPnoFbYoo/2A/LD9Syx2KFstNN2hHdW
 LRbMsCbxyAPpwWLYl7dcgaMZer3x/xRvAe7G0hDDqbW1BbknJq59Qj+OUUW/qRcZ6P/I88Zp
 Ii6hGMXWeCnm6uO4o0a3jVb4oCc9xqUg/eWWLvG54HKqsGm/Vwhj6afhEXdwEVjeeTiGocPo
 VfKycgZZiT+1KY3eBX1yciuG3NhcV/6uQLMeDKsPlT0XJX8cvTFEpLAQ==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	qyousef@layalina.io,
	frederic@kernel.org,
	jan.kiszka@siemens.com,
	bigeasy@linutronix.de,
	anna-maria@linutronix.de,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v4 1/1] hrtimer: Use and report correct timerslack values for realtime tasks
Date: Wed, 14 Aug 2024 14:10:32 +0200
Message-Id: <20240814121032.368444-2-felix.moessbauer@siemens.com>
In-Reply-To: <20240814121032.368444-1-felix.moessbauer@siemens.com>
References: <20240814121032.368444-1-felix.moessbauer@siemens.com>
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
shows the correct value of "0". Setting non-zero slack values (either
via procfs or PR_SET_TIMERSLACK) on tasks with a rt policy is ignored,
as stated in "man 2 PR_SET_TIMERSLACK":

  Timer slack is not applied to threads that are scheduled under a
  real-time scheduling policy (see sched_setscheduler(2)).

The special handling of timerslack on rt tasks in downstream users
is removed as well.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 fs/proc/base.c          |  9 +++++----
 fs/select.c             | 11 ++++-------
 kernel/sched/syscalls.c |  8 ++++++++
 kernel/sys.c            |  2 ++
 kernel/time/hrtimer.c   | 18 +++---------------
 5 files changed, 22 insertions(+), 26 deletions(-)

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
index 9515c3fa1a03..ad171b7a5c11 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -77,19 +77,16 @@ u64 select_estimate_accuracy(struct timespec64 *tv)
 {
 	u64 ret;
 	struct timespec64 now;
+	u64 slack = current->timer_slack_ns;
 
-	/*
-	 * Realtime tasks get a slack of 0 for obvious reasons.
-	 */
-
-	if (rt_task(current))
+	if (slack == 0)
 		return 0;
 
 	ktime_get_ts64(&now);
 	now = timespec64_sub(*tv, now);
 	ret = __estimate_accuracy(&now);
-	if (ret < current->timer_slack_ns)
-		return current->timer_slack_ns;
+	if (ret < slack)
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


