Return-Path: <linux-kernel+bounces-314663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D78496B68A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1321283B6D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C471CCEE3;
	Wed,  4 Sep 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pXoyfkw1"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC18A1CCB24
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441866; cv=none; b=NeRO/6YRxi7N3YONrSqrJYHVN4bjVZo0YUXZbOCpAPqn+kvmlmO0SxMuSY4DLbXnczqTuwVA+DBkp3zI+25xAU5GBkby8d1XMJjkoiOZHDmRf6ZGBFQZmZ0kOG0a45ldoPWxE8y/9HMzZDiXAxit4P1WhpqbpmyOHVujTOdeRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441866; c=relaxed/simple;
	bh=5wYF5kkscRe0vQAg/hp9RqFyvrVU7TFzdsTHZ1UHy3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aOjgbpgRRBKrjUC2NPVCfDCTcwjrub7yXvKkX4OkwO1NnugCy4B1JkxM0KFOIlqq9w+0Gmkr+gdAOIAccDTiQ+hiNbU4myUMROFGBGZZPGtxy5jVkOlfUcH2TBtl+k43htsywgvmsBTrkIi/Dpe2yTJ5TqSU6iQf7d63xe5CJv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pXoyfkw1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bb8cf8abeso50939185e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725441863; x=1726046663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VLa4IUGpyG/+sHc+g+J89M3gD7Af7Gw0mlPT6IVl0+k=;
        b=pXoyfkw1Y9k42540PqiQh4u1WKF3rKSF0/axjECKzS4hhPJKpz5yk6m5rrpbtHi4oH
         62O36w7A0+wCrYZbcOEet5tnpcPqk2p1zCcr6RtKIJtuvxdhS4CCSsu6BmT1rUFKrExe
         36bfEZhxgff4uTJnY8B0GoQR/FC+m4/Ttc0k9+pULuRsuI73wgc66WbawwFxOeUXg1OU
         BPnExR6JHAvKRIVVE8mGaM/m2cX9cSTae4eGNt/bC7wvgVjXEfOQxfHNxnmXGozd/VBq
         rJxsidta2tm4akhqgqw8lcTHR/OT+XhfdL267/3SXtGuu9u/ng/HjC2RCOq+1nfriP1Q
         5KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725441863; x=1726046663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLa4IUGpyG/+sHc+g+J89M3gD7Af7Gw0mlPT6IVl0+k=;
        b=uoEh77UGOTLzJmqQo2zKbrxMk+kbF8JyttXx6/34yyGLMuk8EwORgE81/eU48SHytk
         ZRthyqxdPR5bRDif+gSSLb3fzzqVRRhjJq4PdeO5PMVv44IdLQt2r0kVTma+utV7A22D
         aT1FM7/mIOcfdltAiPtQ/dQx2R9gRH6HbXp3evAXTaWaQA/cCveJ3tsWyadCjODqCbW3
         vwUZ+aSmyCApzvcxfdw7zTfALtR+6ICJqueEod/exj9fmUhFGa7D2PT7yIoNRyirAJY3
         1Stbd8ZVzPJwGcz4Igx6/iDXPiYPA//aU1/auPtjGQkZB6jpYy+zcID5qtOVCySd/wMo
         Yi3g==
X-Forwarded-Encrypted: i=1; AJvYcCXWvJTj2AfU/wVBQ+EBW0bm1ZevN+2FmUuVnSRON0wg0UPyXgix4cTNDBVE+F2DuSAatim30CKmjGV5eEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzDgEtXdIq6XxJgamPH0Vote8H0l+NI2/TwxlUqP0Y6RNDGSYJ
	3zXch2cv5hSi4fXRQkzHEAz/P3sPI7KSgrlmtiN3yoPDFic9B8tWf3z4sQ3i8oE=
X-Google-Smtp-Source: AGHT+IF/VzSp2bcLXaCoph66AYoryz1m5NrU4WCsSMqQrUtDuVjPHkTDrL1/kJdyBAyFrsftJ7IIig==
X-Received: by 2002:a05:600c:1551:b0:428:ea8e:b48a with SMTP id 5b1f17b1804b1-42c8de5f5c3mr24959075e9.8.1725441862876;
        Wed, 04 Sep 2024 02:24:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:580f:d407:6ab5:fb77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c5792acbsm9641837f8f.76.2024.09.04.02.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:24:22 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Move effective_cpu_util() and effective_cpu_util() in fair.c
Date: Wed,  4 Sep 2024 11:24:17 +0200
Message-Id: <20240904092417.20660-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move effective_cpu_util() and sched_cpu_util() functions in fair.c file
with others utilization related functions.

No functional change.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

---
 kernel/sched/fair.c     |  99 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/syscalls.c | 101 ----------------------------------------
 2 files changed, 99 insertions(+), 101 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d697a0a3fc73..9e19009da48f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8084,6 +8084,105 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 	return cpu_util(cpu, p, -1, 0);
 }
 
+/*
+ * This function computes an effective utilization for the given CPU, to be
+ * used for frequency selection given the linear relation: f = u * f_max.
+ *
+ * The scheduler tracks the following metrics:
+ *
+ *   cpu_util_{cfs,rt,dl,irq}()
+ *   cpu_bw_dl()
+ *
+ * Where the cfs,rt and dl util numbers are tracked with the same metric and
+ * synchronized windows and are thus directly comparable.
+ *
+ * The cfs,rt,dl utilization are the running times measured with rq->clock_task
+ * which excludes things like IRQ and steal-time. These latter are then accrued
+ * in the IRQ utilization.
+ *
+ * The DL bandwidth number OTOH is not a measured metric but a value computed
+ * based on the task model parameters and gives the minimal utilization
+ * required to meet deadlines.
+ */
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long *min,
+				 unsigned long *max)
+{
+	unsigned long util, irq, scale;
+	struct rq *rq = cpu_rq(cpu);
+
+	scale = arch_scale_cpu_capacity(cpu);
+
+	/*
+	 * Early check to see if IRQ/steal time saturates the CPU, can be
+	 * because of inaccuracies in how we track these -- see
+	 * update_irq_load_avg().
+	 */
+	irq = cpu_util_irq(rq);
+	if (unlikely(irq >= scale)) {
+		if (min)
+			*min = scale;
+		if (max)
+			*max = scale;
+		return scale;
+	}
+
+	if (min) {
+		/*
+		 * The minimum utilization returns the highest level between:
+		 * - the computed DL bandwidth needed with the IRQ pressure which
+		 *   steals time to the deadline task.
+		 * - The minimum performance requirement for CFS and/or RT.
+		 */
+		*min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
+
+		/*
+		 * When an RT task is runnable and uclamp is not used, we must
+		 * ensure that the task will run at maximum compute capacity.
+		 */
+		if (!uclamp_is_used() && rt_rq_is_runnable(&rq->rt))
+			*min = max(*min, scale);
+	}
+
+	/*
+	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
+	 * CFS tasks and we use the same metric to track the effective
+	 * utilization (PELT windows are synchronized) we can directly add them
+	 * to obtain the CPU's actual utilization.
+	 */
+	util = util_cfs + cpu_util_rt(rq);
+	util += cpu_util_dl(rq);
+
+	/*
+	 * The maximum hint is a soft bandwidth requirement, which can be lower
+	 * than the actual utilization because of uclamp_max requirements.
+	 */
+	if (max)
+		*max = min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
+
+	if (util >= scale)
+		return scale;
+
+	/*
+	 * There is still idle time; further improve the number by using the
+	 * IRQ metric. Because IRQ/steal time is hidden from the task clock we
+	 * need to scale the task numbers:
+	 *
+	 *              max - irq
+	 *   U' = irq + --------- * U
+	 *                 max
+	 */
+	util = scale_irq_capacity(util, irq, scale);
+	util += irq;
+
+	return min(scale, util);
+}
+
+unsigned long sched_cpu_util(int cpu)
+{
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu), NULL, NULL);
+}
+
 /*
  * energy_env - Utilization landscape for energy estimation.
  * @task_busy_time: Utilization contribution by the task for which we test the
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 4fae3cf25a3a..c62acf509b74 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -258,107 +258,6 @@ int sched_core_idle_cpu(int cpu)
 
 #endif
 
-#ifdef CONFIG_SMP
-/*
- * This function computes an effective utilization for the given CPU, to be
- * used for frequency selection given the linear relation: f = u * f_max.
- *
- * The scheduler tracks the following metrics:
- *
- *   cpu_util_{cfs,rt,dl,irq}()
- *   cpu_bw_dl()
- *
- * Where the cfs,rt and dl util numbers are tracked with the same metric and
- * synchronized windows and are thus directly comparable.
- *
- * The cfs,rt,dl utilization are the running times measured with rq->clock_task
- * which excludes things like IRQ and steal-time. These latter are then accrued
- * in the IRQ utilization.
- *
- * The DL bandwidth number OTOH is not a measured metric but a value computed
- * based on the task model parameters and gives the minimal utilization
- * required to meet deadlines.
- */
-unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long *min,
-				 unsigned long *max)
-{
-	unsigned long util, irq, scale;
-	struct rq *rq = cpu_rq(cpu);
-
-	scale = arch_scale_cpu_capacity(cpu);
-
-	/*
-	 * Early check to see if IRQ/steal time saturates the CPU, can be
-	 * because of inaccuracies in how we track these -- see
-	 * update_irq_load_avg().
-	 */
-	irq = cpu_util_irq(rq);
-	if (unlikely(irq >= scale)) {
-		if (min)
-			*min = scale;
-		if (max)
-			*max = scale;
-		return scale;
-	}
-
-	if (min) {
-		/*
-		 * The minimum utilization returns the highest level between:
-		 * - the computed DL bandwidth needed with the IRQ pressure which
-		 *   steals time to the deadline task.
-		 * - The minimum performance requirement for CFS and/or RT.
-		 */
-		*min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
-
-		/*
-		 * When an RT task is runnable and uclamp is not used, we must
-		 * ensure that the task will run at maximum compute capacity.
-		 */
-		if (!uclamp_is_used() && rt_rq_is_runnable(&rq->rt))
-			*min = max(*min, scale);
-	}
-
-	/*
-	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
-	 * CFS tasks and we use the same metric to track the effective
-	 * utilization (PELT windows are synchronized) we can directly add them
-	 * to obtain the CPU's actual utilization.
-	 */
-	util = util_cfs + cpu_util_rt(rq);
-	util += cpu_util_dl(rq);
-
-	/*
-	 * The maximum hint is a soft bandwidth requirement, which can be lower
-	 * than the actual utilization because of uclamp_max requirements.
-	 */
-	if (max)
-		*max = min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
-
-	if (util >= scale)
-		return scale;
-
-	/*
-	 * There is still idle time; further improve the number by using the
-	 * IRQ metric. Because IRQ/steal time is hidden from the task clock we
-	 * need to scale the task numbers:
-	 *
-	 *              max - irq
-	 *   U' = irq + --------- * U
-	 *                 max
-	 */
-	util = scale_irq_capacity(util, irq, scale);
-	util += irq;
-
-	return min(scale, util);
-}
-
-unsigned long sched_cpu_util(int cpu)
-{
-	return effective_cpu_util(cpu, cpu_util_cfs(cpu), NULL, NULL);
-}
-#endif /* CONFIG_SMP */
-
 /**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
-- 
2.34.1


