Return-Path: <linux-kernel+bounces-228634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D252D916313
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F499B26E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0909149E16;
	Tue, 25 Jun 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iksqhWGi"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D9149C50
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308546; cv=none; b=hwQnozIzXLkRfyg3gZsLQjlCb1ccIB92tfRdAtjftMhHl9ytbqJ6cKtMXVI6DnfRn4n0EKhvkRx23LjJXjXRMLpMumBFBGDNl2S0iK9+Dm+ODAgGvr2RLyS4E7jOektesICCxATKf9Hc2VduIyeTwjOvroU8EXOxAkVkEmh3eA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308546; c=relaxed/simple;
	bh=IQoC9h/J89BQa2nWVHcB9CCO9b8Kqv5BOP5Ve84yTy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F2EPU3mmWkkarw7Q0j2DzP5qesn0d30DLJi83DJWWxjSNArxyHvR2/RXVl81QpXtgB0751durF6jtIcSLdC71jX4uELZWKBlz9IlAClr9BcJjw2PhgWZCKIz/i4DMnkwFsFcinkxgkLRg+sicyh7WV1NDmVKqcA/4h4MA+Xm/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iksqhWGi; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a724b9b34b0so251109166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719308543; x=1719913343; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rrnOyyPx1s0VuaEDx73PVRxOQwVD4HvpbQ0NNGg+qU=;
        b=iksqhWGiQQrudKApbQpRb0NW4mvjcXoBufqVJ5/2uoWj5eMRQ6XHORLITIGPcKCC1J
         PIOtY8NwJxtGIYYKAdUni38xvqOoSTwBPmy+ZNj6sXeNrfrFpg01X3NZGGuDEsZbJz46
         ZivP95kw9f1HsbB9q+zSW5aRRtKXJB2UX8j4PCsHSBiq2XXGtSoiff8+Q6+Q0/79XPoU
         t54f4EpcUsImTS0ebB0HQqXIeVim0tYqt7u4Z8ReEKQqmz43x93MxnWxf7mLPY+o9ICK
         Qky3HNqxBwFOmFKDPSjRNSrIoG3KH8yupWsT4fXFCQB+ws2Fns7zz8GfxcxIBDoLAmz+
         NY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719308543; x=1719913343;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rrnOyyPx1s0VuaEDx73PVRxOQwVD4HvpbQ0NNGg+qU=;
        b=qKXN448PZ9C6KyDkKNQ8uOxH4ZGrZlIRd/Mvd17cuQZGxKsmv0pFIyJol45+EqKR0C
         u+l7T76QPkgx7GO8bowtHuhBFLjsMr/QkWYpiJjgeenR6rE/p35w3c53caarUvhajTq5
         gsvBqKdf1XyXCgbUMxcSfApn5tSQNN1+9KRb4Q9/6QDJoqZ00EqY3bpMIVDhT64OpTc2
         SuwWItcpUOseWssdsdV7E2OQAAqw5bfZ8ByOwJNIvaD58k4I6TKg0WPRgMxUZf2SWO2W
         tlXYQfTRYb9QVHXZkF7LXlLtipLUcodWyxsd04n6qM+EzYUMKlkaldOtbpI9lhA2Aexy
         K3wQ==
X-Gm-Message-State: AOJu0YyYwyiNA3DvrkiZkuICaFj80XB+pcVkuPWOC9XWsl0EV/Knsafk
	IF4Au5EaK+0kidLECoj9SIzjB9wKQtBoqHlftjkZwgpAVWuP9lHci4Ev/DVI/jY=
X-Google-Smtp-Source: AGHT+IEP7P0jnBbsE9ZI9yHg7Dc72C6tzs6TcbvwmSqykJ99FDoJ1yVZDgh0NbjeYsfF9NICJC87Sg==
X-Received: by 2002:a17:907:7782:b0:a6f:49bc:e857 with SMTP id a640c23a62f3a-a7245b6dc99mr444223066b.6.1719308543041;
        Tue, 25 Jun 2024 02:42:23 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48a038sm492967966b.48.2024.06.25.02.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 02:42:22 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Jun 2024 11:42:21 +0200
Subject: [PATCH] sched/eevdf: Augment comments to account for reality
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-eevdf-doc-v1-1-215da9eb9354@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPyQemYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyNT3dTUspQ03ZT8ZF2jREMLc7MUS5PUVBMloPqCotS0zAqwWdGxtbU
 AroxoJlsAAAA=
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
This isn't fixing everything and isn't changing any kernel
symbols containing CFS, as I think that would be churny.
---
 kernel/sched/fair.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..03a8b36e8126 100644
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
@@ -5540,7 +5543,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 
 
 /**************************************************
- * CFS bandwidth control machinery
+ * Bandwidth control machinery
  */
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -6630,7 +6633,7 @@ static inline void sched_fair_update_stop_tick(struct rq *rq, struct task_struct
 #endif
 
 /**************************************************
- * CFS operations on tasks:
+ * Operations on tasks:
  */
 
 #ifdef CONFIG_SCHED_HRTICK
@@ -7666,7 +7669,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 }
 
 /**
- * cpu_util() - Estimates the amount of CPU capacity used by CFS tasks.
+ * cpu_util() - Estimates the amount of CPU capacity used by tasks.
  * @cpu: the CPU to get the utilization for
  * @p: task for which the CPU utilization should be predicted or NULL
  * @dst_cpu: CPU @p migrates to, -1 if @p moves from @cpu or @p == NULL
@@ -7677,7 +7680,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
  *
  * CPU utilization is the sum of running time of runnable tasks plus the
  * recent utilization of currently non-runnable tasks on that CPU.
- * It represents the amount of CPU capacity currently used by CFS tasks in
+ * It represents the amount of CPU capacity currently used by tasks in
  * the range [0..max CPU capacity] with max CPU capacity being the CPU
  * capacity at f_max.
  *
@@ -7689,7 +7692,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
  * of such a task would be significantly decayed at this point of time.
  *
  * Boosted CPU utilization is defined as max(CPU runnable, CPU utilization).
- * CPU contention for CFS tasks can be detected by CPU runnable > CPU
+ * CPU contention for tasks can be detected by CPU runnable > CPU
  * utilization. Boosting is implemented in cpu_util() so that internal
  * users (e.g. EAS) can use it next to external users (e.g. schedutil),
  * latter via cpu_util_cfs_boost().
@@ -9359,7 +9362,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	/*
 	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
-	 * DL and IRQ signals have been updated before updating CFS.
+	 * DL and IRQ signals have been updated before updating the scheduler.
 	 */
 	curr_class = rq->curr->sched_class;
 
@@ -9517,7 +9520,7 @@ struct sg_lb_stats {
 	unsigned long group_util;		/* Total utilization   over the CPUs of the group */
 	unsigned long group_runnable;		/* Total runnable time over the CPUs of the group */
 	unsigned int sum_nr_running;		/* Nr of all tasks running in the group */
-	unsigned int sum_h_nr_running;		/* Nr of CFS tasks running in the group */
+	unsigned int sum_h_nr_running;		/* Nr of tasks running in the group */
 	unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
 	unsigned int group_weight;
 	enum group_type group_type;
@@ -9721,7 +9724,7 @@ static inline int sg_imbalanced(struct sched_group *group)
  * be used by some tasks.
  * We consider that a group has spare capacity if the number of task is
  * smaller than the number of CPUs or if the utilization is lower than the
- * available capacity for CFS tasks.
+ * available capacity for fairly scheduled tasks.
  * For the latter, we use a threshold to stabilize the state, to take into
  * account the variance of the tasks' load and to return true if the available
  * capacity in meaningful for the load balancer.
@@ -11211,7 +11214,7 @@ static int need_active_balance(struct lb_env *env)
 		return 1;
 
 	/*
-	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
+	 * The dst_cpu is idle and the src_cpu CPU has only 1 task.
 	 * It's worth migrating the task if the src_cpu's capacity is reduced
 	 * because of other sched_class or IRQs if more capacity stays
 	 * available on dst_cpu.
@@ -11952,7 +11955,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
 		/*
-		 * If there's a runnable CFS task and the current CPU has reduced
+		 * If there's a runnable task and the current CPU has reduced
 		 * capacity, kick the ILB to see if there's a better CPU to run on:
 		 */
 		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
@@ -12577,7 +12580,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 }
 
 /*
- * se_fi_update - Update the cfs_rq->min_vruntime_fi in a CFS hierarchy if needed.
+ * se_fi_update - Update the cfs_rq->min_vruntime_fi in the hierarchy if needed.
  */
 static void se_fi_update(const struct sched_entity *se, unsigned int fi_seq,
 			 bool forceidle)

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240625-eevdf-doc-2a1876d94ee4

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


