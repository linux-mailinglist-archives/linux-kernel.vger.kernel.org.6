Return-Path: <linux-kernel+bounces-428118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD4A9E0A5F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B05163D92
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64091DD9A8;
	Mon,  2 Dec 2024 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMdEdPiX"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937331DE2D4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161586; cv=none; b=D5zwUhbG3vnvX1/phT5rZb8xTORyGXjod+RwTtm3F1pFXTbnMznIRO12LbCEkoU3bSGurRMd2I+LfzUt42hrYqaUozmatShBDHlX1gWXbHhqTPzbC4dCRWSwjGzQHMJaSRHg3WPYUOQbuvhlRP2BBHNZkgnUG+WQ7LCkTe3p2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161586; c=relaxed/simple;
	bh=DYN6Lk1itAAawvdGEpfPUHXf/lGIrZr0P7wVPRit1kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6vJ5sZD7ADrB10H3l7jqdLwPgUVW7vAlE/UYD1CsTV1os+am/bxI1RTsMnRFRv1cZUZzbv0zsJKYfJLCwgOaqwp2Yy3lssSsIlza8eeITWFkqpIwWCFMf3LA9dVcZHXANuBBnm92jtMsJYl52JFRMYJe7nB0fR9wd0t0Q2J+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aMdEdPiX; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df1d1b726so5388680e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733161583; x=1733766383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnzTu39yWGpfYZcqrwWi2HtHvhGqlJE+kQkZcQmTmm8=;
        b=aMdEdPiXjqBDVS+BqrSHh6qKFTUua/VMAd+dxsLvtstKyuTHT/ZxEKkpVt7CTM0wLK
         KiCAWNRqgVumDjCWPzmWXp4DlZjrvIkX7EJGHIZ/kMHCbnd3QNjex9SficI6B0vwMUSi
         2vf9+Di5L3K/v5W02f07Gy+xOuK6301+kqZtMF62Ggp+r9PhfNXaoLcYgTu7gymXmwqJ
         +fBzm5xQbktLOaAiFyaMgMWHm1VuZMT+SUUAMn5iOGStCdfAebYHAlzGT++3JfOu47ly
         XV1V+Y1YWzCOM6cQN9y+tU7g2eoA5bhbybgyh24OiDQOxwFqQztQUuz2ytNGhI3rnDZs
         vlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161583; x=1733766383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnzTu39yWGpfYZcqrwWi2HtHvhGqlJE+kQkZcQmTmm8=;
        b=mVtsJo52b8PXL6AaqNf+9MpUzf9UElGQe08fdicanhWLy+29zTb0Uv2OtbrjDg3x1Q
         xG1giLVcxWp5z5VnUXieqC3k6A3Ul/oa0u/Xu6WZL8GQtkfYMpljlykjEqhtOdVBWSFx
         2jRBm6L3p4CKhtwA8iDOha/Ao2fo6X/SQnSU1bIkAp6J6d9zMN+kXa76DbcqfnyPpHqg
         CYv3Pev9cePef7oJaRn+5HnEbFJNd/akEr5O1jbBJN/13nYad80xgqOEDQHlEOSrtdaa
         5nsSNXDHgV/LKm0Asjp4NL5f7eIV9KCExut5r/M5E9zkuLhi1YsJ7zsiWUsUKGfBwsp/
         TRsg==
X-Forwarded-Encrypted: i=1; AJvYcCXqAs0dE4dtO6ACo4HTVAJFXA3rAGnXAdbvgo2Vlx3N3Rr17Kmuxs0SLPVxN7NB4+BS1DF8BDzmIUyQdTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHon+BcJLsurremnfhUVcK5IvIEQsHdZgN/Jgl2RFdxrEKaD7
	jiGwFZBXR1PkCa1Flsbz73gVsjCg2TqpSY4qTM2OSz+soaCKRdjWgeb2VFQuV4Y=
X-Gm-Gg: ASbGncs2alGZ0wvRuywjuY9ZR/Su4HIByKgebUbH1ZneYB2MWcyvWqxw1jc40CHFZ5l
	PgwnzFxMQQrgvBxliSkuv747EsfEL5PqpY2R/bqL90iNv+aB65LzoFSyAzFRlkWC3cZ2hyxNKH0
	Lq5Oh9ImTpKRwU4M71yi/sgEzX8rv2x7thT4wsh5bJ0eRMZljghnCREhIVSUwHDi9jsnzn9WxM/
	HOo7cQxVDTe4WBoie865sfpSchj8Iwjmr2a/qRqdDilPu5R3cYeE+9NyEY=
X-Google-Smtp-Source: AGHT+IFVqA8OTBgPdz06WxgL36XbSwxnkLKT9CjFvpGbSd1hOMAxC1cLy2QxMKymipVsqrot87BIBg==
X-Received: by 2002:a05:6512:3e22:b0:53d:ed3e:4dbb with SMTP id 2adb3069b0e04-53df00d10a5mr11901568e87.21.1733161582606;
        Mon, 02 Dec 2024 09:46:22 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:f271:ff3b:369e:33b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm193275855e9.29.2024.12.02.09.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:46:21 -0800 (PST)
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
Cc: kprateek.nayak@amd.com,
	pauld@redhat.com,
	efault@gmx.de,
	luis.machado@arm.com,
	tj@kernel.org,
	void@manifault.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 07/11 v3] sched/fair: Rename cfs_rq.idle_h_nr_running into h_nr_idle
Date: Mon,  2 Dec 2024 18:46:02 +0100
Message-ID: <20241202174606.4074512-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202174606.4074512-1-vincent.guittot@linaro.org>
References: <20241202174606.4074512-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use same naming convention as others starting with h_nr_* and rename
idle_h_nr_running into h_nr_idle.
The "running" is not correct anymore as it includes delayed dequeue tasks
as well.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/debug.c |  3 +--
 kernel/sched/fair.c  | 52 ++++++++++++++++++++++----------------------
 kernel/sched/sched.h |  2 +-
 3 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 56be3651605d..e21b66b6ee10 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -848,8 +848,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
 			cfs_rq->idle_nr_running);
-	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
-			cfs_rq->idle_h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_idle", cfs_rq->h_nr_idle);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
 #ifdef CONFIG_SMP
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8afd1b548e76..7234206b9981 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5933,7 +5933,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_task_delta, dequeue = 1;
+	long queued_delta, runnable_delta, idle_delta, dequeue = 1;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5966,7 +5966,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	queued_delta = cfs_rq->h_nr_queued;
 	runnable_delta = cfs_rq->h_nr_runnable;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
+	idle_delta = cfs_rq->h_nr_idle;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		int flags;
@@ -5986,11 +5986,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		dequeue_entity(qcfs_rq, se, flags);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_queued;
+			idle_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->h_nr_runnable -= runnable_delta;
-		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_idle -= idle_delta;
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -6009,11 +6009,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_queued;
+			idle_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->h_nr_runnable -= runnable_delta;
-		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_idle -= idle_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6039,7 +6039,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_task_delta;
+	long queued_delta, runnable_delta, idle_delta;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6075,7 +6075,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	queued_delta = cfs_rq->h_nr_queued;
 	runnable_delta = cfs_rq->h_nr_runnable;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
+	idle_delta = cfs_rq->h_nr_idle;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -6089,11 +6089,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_queued;
+			idle_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->h_nr_runnable += runnable_delta;
-		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_idle += idle_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6107,11 +6107,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_queued;
+			idle_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->h_nr_runnable += runnable_delta;
-		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_idle += idle_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6921,7 +6921,7 @@ static inline void check_update_overutilized_status(struct rq *rq) { }
 /* Runqueue only has SCHED_IDLE tasks enqueued */
 static int sched_idle_rq(struct rq *rq)
 {
-	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
+	return unlikely(rq->nr_running == rq->cfs.h_nr_idle &&
 			rq->nr_running);
 }
 
@@ -6973,7 +6973,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
-	int idle_h_nr_running = task_has_idle_policy(p);
+	int h_nr_idle = task_has_idle_policy(p);
 	int h_nr_runnable = 1;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
@@ -7026,10 +7026,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_runnable += h_nr_runnable;
 		cfs_rq->h_nr_queued++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_idle += h_nr_idle;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7050,10 +7050,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_runnable += h_nr_runnable;
 		cfs_rq->h_nr_queued++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_idle += h_nr_idle;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7111,7 +7111,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
-	int idle_h_nr_running = 0;
+	int h_nr_idle = 0;
 	int h_nr_queued = 0;
 	int h_nr_runnable = 0;
 	struct cfs_rq *cfs_rq;
@@ -7120,7 +7120,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	if (entity_is_task(se)) {
 		p = task_of(se);
 		h_nr_queued = 1;
-		idle_h_nr_running = task_has_idle_policy(p);
+		h_nr_idle = task_has_idle_policy(p);
 		if (task_sleep || task_delayed || !se->sched_delayed)
 			h_nr_runnable = 1;
 	} else {
@@ -7140,10 +7140,10 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		cfs_rq->h_nr_runnable -= h_nr_runnable;
 		cfs_rq->h_nr_queued -= h_nr_queued;
-		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_idle -= h_nr_idle;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = h_nr_queued;
+			h_nr_idle = h_nr_queued;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7179,10 +7179,10 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		cfs_rq->h_nr_runnable -= h_nr_runnable;
 		cfs_rq->h_nr_queued -= h_nr_queued;
-		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_idle -= h_nr_idle;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = h_nr_queued;
+			h_nr_idle = h_nr_queued;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -13543,7 +13543,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 		}
 
 		idle_task_delta = grp_cfs_rq->h_nr_queued -
-				  grp_cfs_rq->idle_h_nr_running;
+				  grp_cfs_rq->h_nr_idle;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
 			idle_task_delta *= -1;
 
@@ -13553,7 +13553,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 			if (!se->on_rq)
 				break;
 
-			cfs_rq->idle_h_nr_running += idle_task_delta;
+			cfs_rq->h_nr_idle += idle_task_delta;
 
 			/* Already accounted at parent level and above. */
 			if (cfs_rq_is_idle(cfs_rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d3ce5e99b025..afe5cb93db89 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -649,7 +649,7 @@ struct cfs_rq {
 	unsigned int		h_nr_queued;       /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
-	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
+	unsigned int		h_nr_idle; /* SCHED_IDLE */
 
 	s64			avg_vruntime;
 	u64			avg_load;
-- 
2.43.0


