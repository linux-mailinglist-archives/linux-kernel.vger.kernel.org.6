Return-Path: <linux-kernel+bounces-396103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875739BC7DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B46284708
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8D620512E;
	Tue,  5 Nov 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VTwh+zDl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OZsioKgP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EDF204932
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794502; cv=none; b=lnJnAecdwBeSQemfTxJr0uxErFo11EFchmyyMKS4/QVlVYjalkBd7IHSl58o30fk6FDJLvLEXU9QneuD7bUGVBQerdwm2gyvfUBN0BDm8P78EpJ1AHNVnmfP4sIXeysaIYx9VMetFDeqKrZ7X7wQz0EXguFCihwJbFoPCePPT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794502; c=relaxed/simple;
	bh=pcOy4Ch+2qNU2o58NMhqPNimeFTq5CWfkqW9pKoDuEQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DeqjyFYUGK1FbuL6MpmwuEDcmGucGnbxVBQkB3kpvzkqXpsQGzs0ANH53mUxaUl12D+kqVkiFKlJQX4wSdwylAPlXzBvQFLSiN9JzWndB986pjEDrrl6s0iymtquydVQ/7hvya+gcwbt0EwJd6LQUyjqDjqEfKcok5jtkRDKofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VTwh+zDl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OZsioKgP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064214.318837272@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CPnchhOLepqueHqgrg5lKLbIFHFsL+lVYOmF9AdWSew=;
	b=VTwh+zDl2v5GaR36diQGbrHKq7RJ0egy7spPRT8mgbYcAs8SvHgk37nm602RrD1IR89AVm
	daClBGdABw+I45FGm3o+7Pr5eVPYNUW967n77R3fYzoM5mACQQ9253LnlMkrHOLsjFhJ3l
	cuUpz6UXrm6phRlKYiBBy5G9kIHECQmg8hiFpyqvyHd4l0lrPdhNihLHFg2Bhqrsf7aQlK
	QqdpIbu+SZmOnuMWKESERl9DByUxl5W3icbhamsmYH7X/H/sVPcpJw2qWyUG60QssvZL9s
	KlzKEo5UiXBA1mXih2n6beygUDXYO1yV+rxKZC4g83bmau6xEMm0VxTqd+N46A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CPnchhOLepqueHqgrg5lKLbIFHFsL+lVYOmF9AdWSew=;
	b=OZsioKgPjyPbFNwNV58tCy2Qt21vbDfGihLxJeNkaLVYVi2ALg/TcR1JoavDM4rIkx3Evz
	d7bNz9i03fhh4VCQ==
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
Subject: [patch V7 21/21] alarmtimers: Remove return value from alarm
 functions
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:58 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Now that the SIG_IGN problem is solved in the core code, the alarmtimer
callbacks do not require a return value anymore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/power/supply/charger-manager.c |    3 +--
 fs/timerfd.c                           |    4 +---
 include/linux/alarmtimer.h             |   10 ++--------
 kernel/time/alarmtimer.c               |   16 +++++-----------
 net/netfilter/xt_IDLETIMER.c           |    4 +---
 5 files changed, 10 insertions(+), 27 deletions(-)
---

--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1412,10 +1412,9 @@ static inline struct charger_desc *cm_ge
 	return dev_get_platdata(&pdev->dev);
 }
 
-static enum alarmtimer_restart cm_timer_func(struct alarm *alarm, ktime_t now)
+static void cm_timer_func(struct alarm *alarm, ktime_t now)
 {
 	cm_timer_set = false;
-	return ALARMTIMER_NORESTART;
 }
 
 static int charger_manager_probe(struct platform_device *pdev)
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -79,13 +79,11 @@ static enum hrtimer_restart timerfd_tmrp
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
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -321,7 +321,7 @@ static int alarmtimer_resume(struct devi
 
 static void
 __alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-	     enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+	     void (*function)(struct alarm *, ktime_t))
 {
 	timerqueue_init(&alarm->node);
 	alarm->timer.function = alarmtimer_fired;
@@ -337,7 +337,7 @@ static void
  * @function: callback that is run when the alarm fires
  */
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-		enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+		void (*function)(struct alarm *, ktime_t))
 {
 	hrtimer_init(&alarm->timer, alarm_bases[type].base_clockid,
 		     HRTIMER_MODE_ABS);
@@ -530,14 +530,12 @@ static enum alarmtimer_type clock2alarm(
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
@@ -698,18 +696,14 @@ static int alarm_timer_create(struct k_i
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
@@ -761,7 +755,7 @@ static int alarmtimer_do_nsleep(struct a
 
 static void
 alarm_init_on_stack(struct alarm *alarm, enum alarmtimer_type type,
-		    enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+		    void (*function)(struct alarm *, ktime_t))
 {
 	hrtimer_init_on_stack(&alarm->timer, alarm_bases[type].base_clockid,
 			      HRTIMER_MODE_ABS);
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -107,14 +107,12 @@ static void idletimer_tg_expired(struct
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


