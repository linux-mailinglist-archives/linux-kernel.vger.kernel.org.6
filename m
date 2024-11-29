Return-Path: <linux-kernel+bounces-425763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA19DEAC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B711B2296F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CE31A0AE9;
	Fri, 29 Nov 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fa+tclBT"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5819F133
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897093; cv=none; b=WLyMeglN9xhXNKzZROBgbd+0OX7ay7WBrEFI1oSmnsZIbW6v2Xi1j7EXV7XV/Qw/9GKHlsJY4ACtQ5xFFkznWqwDNLEwnKQ4yMEFP1LvOaTrv0Nd4erjtDreSpb9Q0E3h6RevucW/1HA8msDeP8O++Be9UNiU39MhBWin7d7omg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897093; c=relaxed/simple;
	bh=XPB2fPFZjrYL0iRHIlVMkQZX1c/Zh2qF3tGKVnuj2uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2YTTC1/4XQCtqcdhH4nRpcV7oiagH9wxgAmask9CDbo62unlIYrHT/B1V2FIGRXdZC48q9kLp9YmzPOc5WfEyq7ez0KEX6fJ00r5Qzoet469ZLckVoxGnFixu/9WBgdGG3upMnneaz+BnpC7FbLNUoOwR3sV4DAZrUHsZM8F7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fa+tclBT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so12802525e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732897090; x=1733501890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSJbyVhu/Z0dv4o62YeLYD1I2J6cBWYBkDMBY0s8v6A=;
        b=Fa+tclBTTIXn8Au0KaZYxSOUv/HMPCkKSNu9lg040a9cm5zIfGno/DFM63pXMIi248
         kwhIk++MUX0UqGqaHIlv802cvX/d4g1R7LnAQZNbgl8n6pkqomVjIxvM5r+s5IVA1oRm
         GUXBEmuFd2ZoU9yuiaKT5k6YpiaPzoLwSaN+z6bthnQCM0OobzTs3gVrKAhzvIgxRzqe
         l6aj+/YSRQBdnsnnHGrMZGjpdKdRfEmlXFIjm4Nu7v7GpOl607MONdCAar5xZHZHB6iC
         /lpfRf9GXpGEd+wGyfgqg45YYSKzR1hsw1LbVQnP/06By+hpJJ7CiP6FEMlsZgZeGmRj
         um4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897090; x=1733501890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSJbyVhu/Z0dv4o62YeLYD1I2J6cBWYBkDMBY0s8v6A=;
        b=JIiyi8Fz14E/2bEB+9tK5ojan62OHtb954PYEVvscWZseI2N5hmZKUVyxY0R1A5wde
         U+DkOrwURMpNKOvdQbCp7kvQ1uLfymNLYM2svanG3cj/Wh/MHOuAnyL3OGSU8K5aiIjB
         U00iQ4RQK+ER/6yzZluEVLFrxiD1TdYZCbrxvGBjdkbv3a/37juYXPysmuizInTJTh/v
         8WqyiQwezHZGHloSWrZFJZzUUk8G8Q1Ps6Z8QdW0X/9Te6r6QwvW4ZnQnjVU1pQk0STh
         dY4Lw9aTut7VxN1kNAko78f4DiwdgKpPsmWv6CjbOozPgar3hxlrfDlcQ8dZRgWzeKsk
         O0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXZtjcSxwaoWUKPC0JMuClOEtDaN+Kq+YWwfdTnyhJq80mMFIK7GvSD/2h12LWkptDYEn/Bx4VSYAiQ5Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QGb3lJS00gCaYdufzXDnQ0Pminc8d1/IMUbaPGQ3GpHO+I+y
	SASzHS66bGR43qwfScTSeVNwNWLkhXFUnS6t/YFYRhSOg61rv4fiOUwoNR+6xQw=
X-Gm-Gg: ASbGncsuMhIPPnWP1G4SBbF6rvrZMZfWyKTF8TWCvAXY3eqTvkBOhU9CxhboQw/eywo
	lj2khMBAHitr0X3ULHpKTdG2HJKw+zMf2C7YGJFHbKrS1mlNptYjpzB2CHzxT19E5SE9ngpwi3N
	6KWCBvLCPFQUW0H3bRba+dgokEd7fQWxyodV9HMcvotgXs2WyrNi/z5FjCJhrsDnEcdRyt7wyTG
	lFwnmmP9o9FqaJgkoZrpMqUUUe+nJVcFyei5NoC7M4clNQqrHHW3Z/vLUE=
X-Google-Smtp-Source: AGHT+IE28h3RcxLud9HeNMb47BPU6pdOukpyLe9pUiBwUJVRSJ7AERs4zS2fF6JmhLiCSYGQCAa5pA==
X-Received: by 2002:a05:600c:3589:b0:434:a4d3:31f0 with SMTP id 5b1f17b1804b1-434afb9533fmr76784415e9.3.1732897090073;
        Fri, 29 Nov 2024 08:18:10 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c54b:5636:4db3:1028])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm56771665e9.15.2024.11.29.08.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:18:09 -0800 (PST)
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
Subject: [PATCH 07/10 v2] sched/fair: Rename cfs_rq.nr_running into nr_queued
Date: Fri, 29 Nov 2024 17:17:53 +0100
Message-ID: <20241129161756.3081386-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241129161756.3081386-1-vincent.guittot@linaro.org>
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename cfs_rq.nr_running into cfs_rq.nr_queued which better reflects the
reality as the value includes both the ready to run entity and the delayed
dequeue entity.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/debug.c |  2 +-
 kernel/sched/fair.c  | 38 +++++++++++++++++++-------------------
 kernel/sched/sched.h |  4 ++--
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ba5e314eb99b..3571f91d4b0d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1341,7 +1341,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	if (scx_enabled() && !scx_can_stop_tick(rq))
 		return false;
 
-	if (rq->cfs.nr_running > 1)
+	if (rq->cfs.nr_queued > 1)
 		return false;
 
 	/*
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 37ccba0bedf5..9d9b6940687f 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -843,7 +843,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			SPLIT_NS(right_vruntime));
 	spread = right_vruntime - left_vruntime;
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
-	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "nr_queued", cfs_rq->nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_runnable", cfs_rq->h_nr_runnable);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_idle",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 20fe55e95882..dc9725da033e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -915,7 +915,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	 * We can safely skip eligibility check if there is only one entity
 	 * in this cfs_rq, saving some cycles.
 	 */
-	if (cfs_rq->nr_running == 1)
+	if (cfs_rq->nr_queued == 1)
 		return curr && curr->on_rq ? curr : se;
 
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
@@ -1247,7 +1247,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 
-	if (cfs_rq->nr_running == 1)
+	if (cfs_rq->nr_queued == 1)
 		return;
 
 	if (resched || did_preempt_short(cfs_rq, curr)) {
@@ -3673,7 +3673,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		list_add(&se->group_node, &rq->cfs_tasks);
 	}
 #endif
-	cfs_rq->nr_running++;
+	cfs_rq->nr_queued++;
 }
 
 static void
@@ -3686,7 +3686,7 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		list_del_init(&se->group_node);
 	}
 #endif
-	cfs_rq->nr_running--;
+	cfs_rq->nr_queued--;
 }
 
 /*
@@ -5220,7 +5220,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
-	return !cfs_rq->nr_running;
+	return !cfs_rq->nr_queued;
 }
 
 #define UPDATE_TG	0x0
@@ -5276,7 +5276,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *
 	 * EEVDF: placement strategy #1 / #2
 	 */
-	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running && se->vlag) {
+	if (sched_feat(PLACE_LAG) && cfs_rq->nr_queued && se->vlag) {
 		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
@@ -5425,7 +5425,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		__enqueue_entity(cfs_rq, se);
 	se->on_rq = 1;
 
-	if (cfs_rq->nr_running == 1) {
+	if (cfs_rq->nr_queued == 1) {
 		check_enqueue_throttle(cfs_rq);
 		if (!throttled_hierarchy(cfs_rq)) {
 			list_add_leaf_cfs_rq(cfs_rq);
@@ -5570,7 +5570,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if (flags & DEQUEUE_DELAYED)
 		finish_delayed_dequeue_entity(se);
 
-	if (cfs_rq->nr_running == 0)
+	if (cfs_rq->nr_queued == 0)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 
 	return true;
@@ -5917,7 +5917,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 		list_del_leaf_cfs_rq(cfs_rq);
 
 		SCHED_WARN_ON(cfs_rq->throttled_clock_self);
-		if (cfs_rq->nr_running)
+		if (cfs_rq->nr_queued)
 			cfs_rq->throttled_clock_self = rq_clock(rq);
 	}
 	cfs_rq->throttle_count++;
@@ -6026,7 +6026,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 */
 	cfs_rq->throttled = 1;
 	SCHED_WARN_ON(cfs_rq->throttled_clock);
-	if (cfs_rq->nr_running)
+	if (cfs_rq->nr_queued)
 		cfs_rq->throttled_clock = rq_clock(rq);
 	return true;
 }
@@ -6126,7 +6126,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	assert_list_leaf_cfs_rq(rq);
 
 	/* Determine whether we need to wake up potentially idle CPU: */
-	if (rq->curr == rq->idle && rq->cfs.nr_running)
+	if (rq->curr == rq->idle && rq->cfs.nr_queued)
 		resched_curr(rq);
 }
 
@@ -6427,7 +6427,7 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	if (!cfs_bandwidth_used())
 		return;
 
-	if (!cfs_rq->runtime_enabled || cfs_rq->nr_running)
+	if (!cfs_rq->runtime_enabled || cfs_rq->nr_queued)
 		return;
 
 	__return_cfs_rq_runtime(cfs_rq);
@@ -6950,14 +6950,14 @@ requeue_delayed_entity(struct sched_entity *se)
 	if (sched_feat(DELAY_ZERO)) {
 		update_entity_lag(cfs_rq, se);
 		if (se->vlag > 0) {
-			cfs_rq->nr_running--;
+			cfs_rq->nr_queued--;
 			if (se != cfs_rq->curr)
 				__dequeue_entity(cfs_rq, se);
 			se->vlag = 0;
 			place_entity(cfs_rq, se, 0);
 			if (se != cfs_rq->curr)
 				__enqueue_entity(cfs_rq, se);
-			cfs_rq->nr_running++;
+			cfs_rq->nr_queued++;
 		}
 	}
 
@@ -8876,7 +8876,7 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 
 again:
 	cfs_rq = &rq->cfs;
-	if (!cfs_rq->nr_running)
+	if (!cfs_rq->nr_queued)
 		return NULL;
 
 	do {
@@ -8993,7 +8993,7 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_stru
 
 static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
 {
-	return !!dl_se->rq->cfs.nr_running;
+	return !!dl_se->rq->cfs.nr_queued;
 }
 
 static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
@@ -9783,7 +9783,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
 			update_tg_load_avg(cfs_rq);
 
-			if (cfs_rq->nr_running == 0)
+			if (cfs_rq->nr_queued == 0)
 				update_idle_cfs_rq_clock_pelt(cfs_rq);
 
 			if (cfs_rq == &rq->cfs)
@@ -12965,7 +12965,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 	 * MIN_NR_TASKS_DURING_FORCEIDLE - 1 tasks and use that to check
 	 * if we need to give up the CPU.
 	 */
-	if (rq->core->core_forceidle_count && rq->cfs.nr_running == 1 &&
+	if (rq->core->core_forceidle_count && rq->cfs.nr_queued == 1 &&
 	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
 		resched_curr(rq);
 }
@@ -13109,7 +13109,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
-	if (rq->cfs.nr_running == 1)
+	if (rq->cfs.nr_queued == 1)
 		return;
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7ece69b0fc14..fa317662da53 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -645,7 +645,7 @@ struct balance_callback {
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
-	unsigned int		nr_running;
+	unsigned int		nr_queued;
 	unsigned int		h_nr_runnable;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_queued;
 	unsigned int		h_nr_idle; /* SCHED_IDLE */
@@ -2564,7 +2564,7 @@ static inline bool sched_rt_runnable(struct rq *rq)
 
 static inline bool sched_fair_runnable(struct rq *rq)
 {
-	return rq->cfs.nr_running > 0;
+	return rq->cfs.nr_queued > 0;
 }
 
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-- 
2.43.0


