Return-Path: <linux-kernel+bounces-424467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5139DB4C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2466282495
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D76194C6A;
	Thu, 28 Nov 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mr7sntZF"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6819049B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786086; cv=none; b=bwZ0mmCRcGbvW62YNzzFp4BYklspW7lhw5W72Sse4sGwD1ZXXCjjO0gw2fUDUC/YJDbzWAxQK2XAllrBIWYYVqXCyX/JJ4Lx7BYx7EzMntZcJzHorLpa6UCcYmxgnE7l2x5XZLPdz+jfpevW822IKxcbu57NRSqqhep8c2cz0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786086; c=relaxed/simple;
	bh=kMEX057xnOKxanvXKojIuYognrIC/ESd92hfo61DxoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naPJsW1tuG4nt4byuL2a+94UmXSp/0KXHtm5i35vvQPgz/m+htuIvk53Xct0CNkq9dXhWHRCm260hQFgeaQvAQR9hFSsqtpv9hnB7aOzBZOb0Cfo2yJRYdIbJ+VZQr01B+p4CcLoIsB8VEDudA+otGjmHKHYMc924gE6PgpksQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mr7sntZF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so9955085e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732786082; x=1733390882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RJnvdeirAoOPRQXdey1AZfjeU4m7OozAEH8LULGv+c=;
        b=Mr7sntZFzTYuWmJlTx3GPATwLbfA7tkPVAx1VeHZ7jGbZ1VMwx2akeSa56Jh+y8IWR
         6FG26S0WUZ3Dnp6Hbzh9pHYx/t99+IK15Psyq4qjKg+WgXVXI/gDhpCTwoECeaZVuprR
         z/rM/vqiPw1WLPzdOmwTY9F2S7B6O80bjRyy/SBNjRfTvy0jkfhCFbhAmWgHbLoWC193
         Y9mQ+fQ4u6VeMyQpxWZpRdRMvnoT0IZcaAKtgh/PgwDOoG/Ewp2pBQXIUkEEY9XYPEHt
         sINvWgBjZ09Fe65cYEyGiL8KXxZHu91aIATuBdJbikZackOAdsWoXC0qipO8BbgZ9cBA
         DaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732786082; x=1733390882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RJnvdeirAoOPRQXdey1AZfjeU4m7OozAEH8LULGv+c=;
        b=CJX0rCzNr2RIEdSeazxNDZ9lX+29zUtyn5DGCWBSq+nwq/hfoOvdOX5LTJbaYIqlIQ
         p4sf/mbseT4K55/LSS84HcBmTRW9uR993G7vg5n1dWR6DogO/eb01Qer59X0n4BMqpPK
         TdyhtKTc7ZdeMaYZ+K7TUG8Rvmu0VcldrpXUnGkWLdhHAAs9ti50jTcubbh91XEXHPq8
         9bo3M8Y3d/Bxt8RWAH4RO84YDMA2Y7zqG51c3Ab519y0YXPm8XK3tdzUalKE/zK5UK0u
         PKuo6pBiqn7RMbG4f28uiTsQ3lmtQIltFurhauawd+gLihgOHLu+r8kLJit6WcoxJknd
         QLDg==
X-Forwarded-Encrypted: i=1; AJvYcCVZbN8xXfNd/5M35zXqrdE/QvBH8fhc2yuNCOr6r4U/tguHeXljeMvsg/XxOfFmHeCOWewn+rAnnSyjBWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIc6shxWIkuYKEpWQbUMR2T8DdhOQ6x5v8ds8GfJgnB3xnn2mI
	9PE839IWxLQfQkLXsjAsQNxrvtuwXwTaS2RsLXroWB5Sc96Fp3i7pboNGtTyvFs=
X-Gm-Gg: ASbGncu1qbjWvrCDb1VoKycavPGZ+iiStUG10pWZUb1pv1OL1T7cp1AYU182JDxc1NO
	xcEz0FWZdSmAlwIwPZD377dhSF2s9HpsZVm0JzFDVrieo1MQAKdECcvu5nT1RN+lXBJiVfKFAav
	f7p7HXJJ6fqEhbBaHgsQcmASJCgelbn5XB6t3Y5rfV9hKjUj5mdRq53GD8wphZZVBJbvpfpnxPC
	tufF3bh1RnyXSJ8U9mH3zf+NKKuskpQRR3sVG9KGXrv4DZKYm6+ataHmf0=
X-Google-Smtp-Source: AGHT+IG5x7UXSamlxr4tvQL+ndZOAUhaH5l1vZWFAEf6TvRbC1lb6JqxxLg43El4hkzXQjGt/O1h+Q==
X-Received: by 2002:a05:600c:3589:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-434afc44774mr20000965e9.16.1732786082532;
        Thu, 28 Nov 2024 01:28:02 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c0d5:15dc:1ec9:3f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm47078885e9.37.2024.11.28.01.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:28:01 -0800 (PST)
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
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 5/9] sched/fair: Rename cfs_rq.nr_running into nr_enqueued
Date: Thu, 28 Nov 2024 10:27:46 +0100
Message-ID: <20241128092750.2541735-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128092750.2541735-1-vincent.guittot@linaro.org>
References: <20241128092750.2541735-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename cfs_rq.nr_running into cfs_rq.nr_enqueued which better reflects the
reality as the value includes both the ready to run tasks and the delayed
dequeue tasks.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/debug.c |  2 +-
 kernel/sched/fair.c  | 38 +++++++++++++++++++-------------------
 kernel/sched/sched.h |  4 ++--
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 425739bbdc63..daaa20f01ad4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1341,7 +1341,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	if (scx_enabled() && !scx_can_stop_tick(rq))
 		return false;
 
-	if (rq->cfs.nr_running > 1)
+	if (rq->cfs.nr_enqueued > 1)
 		return false;
 
 	/*
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0c8e21f9039c..8f5273043c16 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -843,7 +843,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			SPLIT_NS(right_vruntime));
 	spread = right_vruntime - left_vruntime;
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
-	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "nr_enqueued", cfs_rq->nr_enqueued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_enqueued", cfs_rq->h_nr_enqueued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 65492399f200..a96a771d8e61 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -915,7 +915,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	 * We can safely skip eligibility check if there is only one entity
 	 * in this cfs_rq, saving some cycles.
 	 */
-	if (cfs_rq->nr_running == 1)
+	if (cfs_rq->nr_enqueued == 1)
 		return curr && curr->on_rq ? curr : se;
 
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
@@ -1247,7 +1247,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 
-	if (cfs_rq->nr_running == 1)
+	if (cfs_rq->nr_enqueued == 1)
 		return;
 
 	if (resched || did_preempt_short(cfs_rq, curr)) {
@@ -3673,7 +3673,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		list_add(&se->group_node, &rq->cfs_tasks);
 	}
 #endif
-	cfs_rq->nr_running++;
+	cfs_rq->nr_enqueued++;
 }
 
 static void
@@ -3686,7 +3686,7 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		list_del_init(&se->group_node);
 	}
 #endif
-	cfs_rq->nr_running--;
+	cfs_rq->nr_enqueued--;
 }
 
 /*
@@ -5220,7 +5220,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
-	return !cfs_rq->nr_running;
+	return !cfs_rq->nr_enqueued;
 }
 
 #define UPDATE_TG	0x0
@@ -5276,7 +5276,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *
 	 * EEVDF: placement strategy #1 / #2
 	 */
-	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running && se->vlag) {
+	if (sched_feat(PLACE_LAG) && cfs_rq->nr_enqueued && se->vlag) {
 		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
@@ -5425,7 +5425,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		__enqueue_entity(cfs_rq, se);
 	se->on_rq = 1;
 
-	if (cfs_rq->nr_running == 1) {
+	if (cfs_rq->nr_enqueued == 1) {
 		check_enqueue_throttle(cfs_rq);
 		if (!throttled_hierarchy(cfs_rq)) {
 			list_add_leaf_cfs_rq(cfs_rq);
@@ -5573,7 +5573,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if (flags & DEQUEUE_DELAYED)
 		finish_delayed_dequeue_entity(se);
 
-	if (cfs_rq->nr_running == 0)
+	if (cfs_rq->nr_enqueued == 0)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 
 	return true;
@@ -5921,7 +5921,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 		list_del_leaf_cfs_rq(cfs_rq);
 
 		SCHED_WARN_ON(cfs_rq->throttled_clock_self);
-		if (cfs_rq->nr_running)
+		if (cfs_rq->nr_enqueued)
 			cfs_rq->throttled_clock_self = rq_clock(rq);
 	}
 	cfs_rq->throttle_count++;
@@ -6033,7 +6033,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 */
 	cfs_rq->throttled = 1;
 	SCHED_WARN_ON(cfs_rq->throttled_clock);
-	if (cfs_rq->nr_running)
+	if (cfs_rq->nr_enqueued)
 		cfs_rq->throttled_clock = rq_clock(rq);
 	return true;
 }
@@ -6136,7 +6136,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	assert_list_leaf_cfs_rq(rq);
 
 	/* Determine whether we need to wake up potentially idle CPU: */
-	if (rq->curr == rq->idle && rq->cfs.nr_running)
+	if (rq->curr == rq->idle && rq->cfs.nr_enqueued)
 		resched_curr(rq);
 }
 
@@ -6437,7 +6437,7 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	if (!cfs_bandwidth_used())
 		return;
 
-	if (!cfs_rq->runtime_enabled || cfs_rq->nr_running)
+	if (!cfs_rq->runtime_enabled || cfs_rq->nr_enqueued)
 		return;
 
 	__return_cfs_rq_runtime(cfs_rq);
@@ -6960,14 +6960,14 @@ requeue_delayed_entity(struct sched_entity *se)
 	if (sched_feat(DELAY_ZERO)) {
 		update_entity_lag(cfs_rq, se);
 		if (se->vlag > 0) {
-			cfs_rq->nr_running--;
+			cfs_rq->nr_enqueued--;
 			if (se != cfs_rq->curr)
 				__dequeue_entity(cfs_rq, se);
 			se->vlag = 0;
 			place_entity(cfs_rq, se, 0);
 			if (se != cfs_rq->curr)
 				__enqueue_entity(cfs_rq, se);
-			cfs_rq->nr_running++;
+			cfs_rq->nr_enqueued++;
 		}
 	}
 
@@ -8900,7 +8900,7 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 
 again:
 	cfs_rq = &rq->cfs;
-	if (!cfs_rq->nr_running)
+	if (!cfs_rq->nr_enqueued)
 		return NULL;
 
 	do {
@@ -9017,7 +9017,7 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_stru
 
 static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
 {
-	return !!dl_se->rq->cfs.nr_running;
+	return !!dl_se->rq->cfs.nr_enqueued;
 }
 
 static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
@@ -9807,7 +9807,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
 			update_tg_load_avg(cfs_rq);
 
-			if (cfs_rq->nr_running == 0)
+			if (cfs_rq->nr_enqueued == 0)
 				update_idle_cfs_rq_clock_pelt(cfs_rq);
 
 			if (cfs_rq == &rq->cfs)
@@ -12989,7 +12989,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 	 * MIN_NR_TASKS_DURING_FORCEIDLE - 1 tasks and use that to check
 	 * if we need to give up the CPU.
 	 */
-	if (rq->core->core_forceidle_count && rq->cfs.nr_running == 1 &&
+	if (rq->core->core_forceidle_count && rq->cfs.nr_enqueued == 1 &&
 	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
 		resched_curr(rq);
 }
@@ -13133,7 +13133,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
-	if (rq->cfs.nr_running == 1)
+	if (rq->cfs.nr_enqueued == 1)
 		return;
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d795202a7174..7d99d18e8984 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -645,7 +645,7 @@ struct balance_callback {
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
-	unsigned int		nr_running;
+	unsigned int		nr_enqueued;
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_enqueued;
 	unsigned int		h_nr_idle; /* SCHED_IDLE */
@@ -2566,7 +2566,7 @@ static inline bool sched_rt_runnable(struct rq *rq)
 
 static inline bool sched_fair_runnable(struct rq *rq)
 {
-	return rq->cfs.nr_running > 0;
+	return rq->cfs.nr_enqueued > 0;
 }
 
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-- 
2.43.0


