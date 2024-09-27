Return-Path: <linux-kernel+bounces-341502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 094109880DA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83AD1F21EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447FB1B3F2F;
	Fri, 27 Sep 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cl831p8+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X8KuIP1H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8A51B3B2F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426955; cv=none; b=BWvZl4diC/3DleY0B9HL/YAuq7xki6tQwOHzYbFFKDHFgoDLOJdg/wUoNBo9DrY6S2wYr+cDPgOyz/kqElLGX5JovieML9r6kZnTd4bOHHavw+Rcqykcq2KZ//0rQ6gnqtKM2VPMO7c6XkCxVJFRg8W3zGmMRqidMpwurRnqszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426955; c=relaxed/simple;
	bh=7zGLzpG45aslQEdkxT7c+S67ymcLqlpUALg8nAaSMGI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SLmzzm8W4fA5JDaNlqnVTKX4CcIJu7VCgRB03HcQU1mRiqlHzltk0oxbcLsFu7dLuCUzOrl2u/WAZCrn2eCUuVtBVb/eEF4WFS/5eu34hPcx0epzAfdkY84p6MKf8KGSn1r4Scuw3avCZYxtW7qly6xZ8fqGdw4rp5zWLtV43TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cl831p8+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X8KuIP1H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084818.547327138@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rjS/LkNZGaAl6fB4xGY0nR6sDvgfIhY1KsxZmw2tZDI=;
	b=cl831p8+QUnk3jT3Oruc+wz4yoxc7aUpvYgetyRzW8GmFcYb23hM7OxOARbFNHrklPjGiZ
	nToM3bww96vFqO17xikvPhAIArFMh9j/CHTrkS46CYATmpDpIL440C4ynsKFYKii0CI1L9
	XR/ZTMYlJnZZNTFBU41muBeoMBRUii5bl2R8lUo3uLVN5cCD87J44rBJiXW8Mtqu2Vo2O3
	4ak5uLWZ72nULnf9OBDK1cnN2HC+lMAKp1PwbudL/DITudSE+rVKTvSC3cofsz6Yv+LCGS
	Et0gjueNZ89seySAbcLRKtBc5Y+I/qfkT5O5RedyvMLFcndiF0RB692wzEMGPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rjS/LkNZGaAl6fB4xGY0nR6sDvgfIhY1KsxZmw2tZDI=;
	b=X8KuIP1Hob0T4wI3c3rP13XcpX8M+EQaJLJw8FJJXPEIR+qV0PDmJtEQJOQ2WJG9aEPJ2H
	K1RpE3YGfn9shMCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch v4 27/27] alarmtimers: Remove return value from alarm
 functions
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:49:12 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Now that the SIG_IGN problem is solved in the core code, the alarmtimer
callbacks do not require a return value anymore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 drivers/power/supply/charger-manager.c |  3 +--
 fs/timerfd.c                           |  4 +---
 include/linux/alarmtimer.h             | 10 ++--------
 kernel/time/alarmtimer.c               | 16 +++++-----------
 net/netfilter/xt_IDLETIMER.c           |  4 +---
 5 files changed, 10 insertions(+), 27 deletions(-)
---
diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 96f0a7fbf105..09ec0ecf1486 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1412,10 +1412,9 @@ static inline struct charger_desc *cm_get_drv_data(struct platform_device *pdev)
 	return dev_get_platdata(&pdev->dev);
 }
 
-static enum alarmtimer_restart cm_timer_func(struct alarm *alarm, ktime_t now)
+static void cm_timer_func(struct alarm *alarm, ktime_t now)
 {
 	cm_timer_set = false;
-	return ALARMTIMER_NORESTART;
 }
 
 static int charger_manager_probe(struct platform_device *pdev)
diff --git a/fs/timerfd.c b/fs/timerfd.c
index 4bf2f8bfec11..67400c9bde07 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -79,13 +79,11 @@ static enum hrtimer_restart timerfd_tmrproc(struct hrtimer *htmr)
 	return HRTIMER_NORESTART;
 }
 
-static enum alarmtimer_restart timerfd_alarmproc(struct alarm *alarm,
-	ktime_t now)
+static void timerfd_alarmproc(struct alarm *alarm, ktime_t now)
 {
 	struct timerfd_ctx *ctx = container_of(alarm, struct timerfd_ctx,
 					       t.alarm);
 	timerfd_triggered(ctx);
-	return ALARMTIMER_NORESTART;
 }
 
 /*
diff --git a/include/linux/alarmtimer.h b/include/linux/alarmtimer.h
index 05e758b8b894..3ffa5341dce2 100644
--- a/include/linux/alarmtimer.h
+++ b/include/linux/alarmtimer.h
@@ -20,12 +20,6 @@ enum alarmtimer_type {
 	ALARM_BOOTTIME_FREEZER,
 };
 
-enum alarmtimer_restart {
-	ALARMTIMER_NORESTART,
-	ALARMTIMER_RESTART,
-};
-
-
 #define ALARMTIMER_STATE_INACTIVE	0x00
 #define ALARMTIMER_STATE_ENQUEUED	0x01
 
@@ -42,14 +36,14 @@ enum alarmtimer_restart {
 struct alarm {
 	struct timerqueue_node	node;
 	struct hrtimer		timer;
-	enum alarmtimer_restart	(*function)(struct alarm *, ktime_t now);
+	void			(*function)(struct alarm *, ktime_t now);
 	enum alarmtimer_type	type;
 	int			state;
 	void			*data;
 };
 
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-		enum alarmtimer_restart (*function)(struct alarm *, ktime_t));
+		void (*function)(struct alarm *, ktime_t));
 void alarm_start(struct alarm *alarm, ktime_t start);
 void alarm_start_relative(struct alarm *alarm, ktime_t start);
 void alarm_restart(struct alarm *alarm);
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 593e7d561fa8..37d2d79daea4 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -321,7 +321,7 @@ static int alarmtimer_resume(struct device *dev)
 
 static void
 __alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-	     enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+	     void (*function)(struct alarm *, ktime_t))
 {
 	timerqueue_init(&alarm->node);
 	alarm->timer.function = alarmtimer_fired;
@@ -337,7 +337,7 @@ __alarm_init(struct alarm *alarm, enum alarmtimer_type type,
  * @function: callback that is run when the alarm fires
  */
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-		enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+		void (*function)(struct alarm *, ktime_t))
 {
 	hrtimer_init(&alarm->timer, alarm_bases[type].base_clockid,
 		     HRTIMER_MODE_ABS);
@@ -530,14 +530,12 @@ static enum alarmtimer_type clock2alarm(clockid_t clockid)
  *
  * Return: whether the timer is to be restarted
  */
-static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm, ktime_t now)
+static void alarm_handle_timer(struct alarm *alarm, ktime_t now)
 {
 	struct k_itimer *ptr = container_of(alarm, struct k_itimer, it.alarm.alarmtimer);
 
 	guard(spinlock_irqsave)(&ptr->it_lock);
 	posix_timer_queue_signal(ptr);
-
-	return ALARMTIMER_NORESTART;
 }
 
 /**
@@ -698,18 +696,14 @@ static int alarm_timer_create(struct k_itimer *new_timer)
  * @now: time at the timer expiration
  *
  * Wakes up the task that set the alarmtimer
- *
- * Return: ALARMTIMER_NORESTART
  */
-static enum alarmtimer_restart alarmtimer_nsleep_wakeup(struct alarm *alarm,
-								ktime_t now)
+static void alarmtimer_nsleep_wakeup(struct alarm *alarm, ktime_t now)
 {
 	struct task_struct *task = alarm->data;
 
 	alarm->data = NULL;
 	if (task)
 		wake_up_process(task);
-	return ALARMTIMER_NORESTART;
 }
 
 /**
@@ -761,7 +755,7 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
 
 static void
 alarm_init_on_stack(struct alarm *alarm, enum alarmtimer_type type,
-		    enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+		    void (*function)(struct alarm *, ktime_t))
 {
 	hrtimer_init_on_stack(&alarm->timer, alarm_bases[type].base_clockid,
 			      HRTIMER_MODE_ABS);
diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index db720efa811d..5514600586a9 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -107,14 +107,12 @@ static void idletimer_tg_expired(struct timer_list *t)
 	schedule_work(&timer->work);
 }
 
-static enum alarmtimer_restart idletimer_tg_alarmproc(struct alarm *alarm,
-							  ktime_t now)
+static void idletimer_tg_alarmproc(struct alarm *alarm, ktime_t now)
 {
 	struct idletimer_tg *timer = alarm->data;
 
 	pr_debug("alarm %s expired\n", timer->attr.attr.name);
 	schedule_work(&timer->work);
-	return ALARMTIMER_NORESTART;
 }
 
 static int idletimer_check_sysfs_name(const char *name, unsigned int size)


