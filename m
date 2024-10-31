Return-Path: <linux-kernel+bounces-391280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDFB9B84AE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C3D1C21EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1421CC16B;
	Thu, 31 Oct 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8021RU0"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0061B3B2E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408127; cv=none; b=pwvH/xWtL/LBl7MZho+tdz9ucxTZxe1lVsvTGhTV41Xpm7rqWTZBj0DVMhqfZYrFQneomEBqszFDk1xgsfwf9T+ekvUZtupJDlsGc8tPU0Gx78xwEbnOiXR0OdnYjrqon6dw27g8gIbfNT7pxEvNZ8LkdkokDgmcspOJ2tjgMKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408127; c=relaxed/simple;
	bh=RdgaVHzACBCDH5yNeAThPzNfuJPyp2C2dGXK7c0vm7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Yi/dCQUpdrRNo0VBJ1onQKy6rhYYNYvXYnwmYnD6nuM6G1+doBCy2KNL0aGfc6x7xHFixG/5eWt4c/2QHjaNtMhRAVgIpHSXJJD2DiguUCukFu1cFM7V95ki+58kQLh/OLCbdaX+Hh1rLWW/ubIag96c6GAmWUgvho/ad9KdwSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M8021RU0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e690479cso1520945e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730408119; x=1731012919; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mm9SY+Bbh+1eN6IJ0rJf8G4SKrB7KcS7jxXXrJQLtOw=;
        b=M8021RU0PYodm2JNlK3WOyTRcbrXWQiVYSKF6s5iNLGcshpnkFawdnZW/l+vm/wFys
         ubhHvokPq2buBzYOMfBSuxrAJH2XY5VCw5yA/tGl/ebmBYkwo0GD6vZfc6gKDgwxqA5H
         Z076yNDuS5K8EcIyqZAymekO1VBTR7KdfzOvRFTmYqMKIWQNvWOF/0hHOcCUMZyIBv4n
         YUqMNDbZl+bXRzHxqvnzTUZ72BlhYcDrPHv0ZApVBcVfOH71ygv8PhCBgTM/Yu1bDxED
         hQxAdu6GsJHPfhmtUPh2Gz9Q0YEK83xJqxMSygVuMIPYjkF8luXZyqQ3sTf7n9piTLdy
         cvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408119; x=1731012919;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mm9SY+Bbh+1eN6IJ0rJf8G4SKrB7KcS7jxXXrJQLtOw=;
        b=lWfbFvAMPOB8s7tRCw37n9aXa9Un6dvXzECd9iOSynOmuot0fiu9+LrXSFl0e8dJgc
         pm1nnNaa4zM++GnHE8/3SZiQ2qv0wJkH7g+uRQAqo3i5nFG/aqItnIKF62zIuD924Peq
         9d46Hb9BRZtCHQ+eUlcSuHhh6Vx/E4B4gd0hjrNG0PJUWC9cYc6yK8zMDGs46Fb1wbZs
         7OubvqZJ53DXz9OlnExQEvq9HJXJ5IinhFRKZe6toHLNht/DQsnXg6pZnJQmqee2Yt6W
         VnsShoiA5DYFifuuWSbRrd+t7TghxYjXlXN88CPZ8VtRfWh8LzUUfcv1BllzYzmZISrq
         cO9A==
X-Gm-Message-State: AOJu0Yw6mD57LneYujo/29Iy+JBCI+2FEei9U+YzmmQT3oAiEQSr1ROI
	d/hdPgUgG9WNaVqr5ESaNnR53KTL79JYfoO2hH/LeFk1UU1tOpbz1YH3iQA1RYY=
X-Google-Smtp-Source: AGHT+IEKGqipIhHr/KCldwUi5uIePMtPVWvjYcwInZOwizJTxvUscsv4EMZBdj3QTUybh6dDKxwX0A==
X-Received: by 2002:a05:6512:401a:b0:536:a4e1:5fa2 with SMTP id 2adb3069b0e04-53d65df2818mr828356e87.26.1730408118505;
        Thu, 31 Oct 2024 13:55:18 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c370sm325226e87.103.2024.10.31.13.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 13:55:18 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 31 Oct 2024 21:55:17 +0100
Subject: [PATCH v2] sched/eevdf: Fix documentation to refer to EEVDF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-eevdf-doc-v2-1-8de4ed583f67@linaro.org>
X-B4-Tracking: v=1; b=H4sIALTuI2cC/23MQQrCMBCF4auUWTvSxKRaV95DuojNtB2QpEwkK
 CV3N3bt8n88vg0SCVOCa7OBUObEMdTQhwbGxYWZkH1t0K02bactEmU/oY8jaqcu5873hshA/a9
 CE7936z7UXji9onx2Oqvf+k/JChVqZb3r6dGfrLk9OTiJxygzDKWUL1C6TdyjAAAA
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

The references to "CFS" is a bit misleading these days since
the scheduling principe is EEVDF.

Rewrite the top level comment, and trim other comments and
kerneldoc to implicitly refer to the scheduling implemented
in this file, or just "the fair scheduler".

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Rebase on v6.12-rc1
- Tweak subject to make it more to the point
- Link to v1: https://lore.kernel.org/r/20240625-eevdf-doc-v1-1-215da9eb9354@linaro.org
---
 kernel/sched/fair.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 225b31aaee55..eda6d1fe4257 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Completely Fair Scheduling (CFS) Class (SCHED_NORMAL/SCHED_BATCH)
+ * Earliest Elegible Deadline First (EEVDF) Class (SCHED_NORMAL/SCHED_BATCH)
+ * also known as the fair time-sharing scheduler, refactored from the
+ * Completely Fair Scheduler (CFS).
  *
  *  Copyright (C) 2007 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
  *
@@ -17,7 +19,8 @@
  *  Scaled math optimizations by Thomas Gleixner
  *  Copyright (C) 2007, Thomas Gleixner <tglx@linutronix.de>
  *
- *  Adaptive scheduling granularity, math enhancements by Peter Zijlstra
+ *  Adaptive scheduling granularity, math enhancements and rewrite to EEVDF
+ *  by Peter Zijlstra
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  */
 #include <linux/energy_model.h>
@@ -297,7 +300,7 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
 const struct sched_class fair_sched_class;
 
 /**************************************************************
- * CFS operations on generic schedulable entities:
+ * Operations on generic schedulable entities:
  */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -5691,7 +5694,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 
 
 /**************************************************
- * CFS bandwidth control machinery
+ * Bandwidth control machinery
  */
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -6802,7 +6805,7 @@ static inline void sched_fair_update_stop_tick(struct rq *rq, struct task_struct
 #endif
 
 /**************************************************
- * CFS operations on tasks:
+ * Operations on tasks:
  */
 
 #ifdef CONFIG_SCHED_HRTICK
@@ -7958,7 +7961,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 }
 
 /**
- * cpu_util() - Estimates the amount of CPU capacity used by CFS tasks.
+ * cpu_util() - Estimates the amount of CPU capacity used by tasks.
  * @cpu: the CPU to get the utilization for
  * @p: task for which the CPU utilization should be predicted or NULL
  * @dst_cpu: CPU @p migrates to, -1 if @p moves from @cpu or @p == NULL
@@ -7969,7 +7972,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
  *
  * CPU utilization is the sum of running time of runnable tasks plus the
  * recent utilization of currently non-runnable tasks on that CPU.
- * It represents the amount of CPU capacity currently used by CFS tasks in
+ * It represents the amount of CPU capacity currently used by tasks in
  * the range [0..max CPU capacity] with max CPU capacity being the CPU
  * capacity at f_max.
  *
@@ -7981,7 +7984,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
  * of such a task would be significantly decayed at this point of time.
  *
  * Boosted CPU utilization is defined as max(CPU runnable, CPU utilization).
- * CPU contention for CFS tasks can be detected by CPU runnable > CPU
+ * CPU contention for tasks can be detected by CPU runnable > CPU
  * utilization. Boosting is implemented in cpu_util() so that internal
  * users (e.g. EAS) can use it next to external users (e.g. schedutil),
  * latter via cpu_util_cfs_boost().
@@ -9721,7 +9724,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	/*
 	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
-	 * DL and IRQ signals have been updated before updating CFS.
+	 * DL and IRQ signals have been updated before updating the scheduler.
 	 */
 	updated = update_other_load_avgs(rq);
 
@@ -9872,7 +9875,7 @@ struct sg_lb_stats {
 	unsigned long group_util;		/* Total utilization   over the CPUs of the group */
 	unsigned long group_runnable;		/* Total runnable time over the CPUs of the group */
 	unsigned int sum_nr_running;		/* Nr of all tasks running in the group */
-	unsigned int sum_h_nr_running;		/* Nr of CFS tasks running in the group */
+	unsigned int sum_h_nr_running;		/* Nr of tasks running in the group */
 	unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
 	unsigned int group_weight;
 	enum group_type group_type;
@@ -10076,7 +10079,7 @@ static inline int sg_imbalanced(struct sched_group *group)
  * be used by some tasks.
  * We consider that a group has spare capacity if the number of task is
  * smaller than the number of CPUs or if the utilization is lower than the
- * available capacity for CFS tasks.
+ * available capacity for fairly scheduled tasks.
  * For the latter, we use a threshold to stabilize the state, to take into
  * account the variance of the tasks' load and to return true if the available
  * capacity in meaningful for the load balancer.
@@ -11566,7 +11569,7 @@ static int need_active_balance(struct lb_env *env)
 		return 1;
 
 	/*
-	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
+	 * The dst_cpu is idle and the src_cpu CPU has only 1 task.
 	 * It's worth migrating the task if the src_cpu's capacity is reduced
 	 * because of other sched_class or IRQs if more capacity stays
 	 * available on dst_cpu.
@@ -12312,7 +12315,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
 		/*
-		 * If there's a runnable CFS task and the current CPU has reduced
+		 * If there's a runnable task and the current CPU has reduced
 		 * capacity, kick the ILB to see if there's a better CPU to run on:
 		 */
 		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
@@ -12937,7 +12940,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 }
 
 /*
- * se_fi_update - Update the cfs_rq->min_vruntime_fi in a CFS hierarchy if needed.
+ * se_fi_update - Update the cfs_rq->min_vruntime_fi in the hierarchy if needed.
  */
 static void se_fi_update(const struct sched_entity *se, unsigned int fi_seq,
 			 bool forceidle)

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240625-eevdf-doc-2a1876d94ee4

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


