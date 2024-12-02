Return-Path: <linux-kernel+bounces-428120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E265F9E0A64
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BD7281D10
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EADA1DE8A4;
	Mon,  2 Dec 2024 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xoNWz0mx"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553331DE4EB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161591; cv=none; b=l5HhSKpxo6n8J7yUwxQbHR82rAysB9AfjDPGdcI0DAq2HM1QZbFHftClfwFYj/MOpui3xvFAoEqSslMffmM7KorzA0jiXUe8xooEo0wVzrVCizE7NKWPICJGh3o7Q4wfTohB3TbpOnmp3UHUiwjLjt/8FdN2l3Drcz4vpmh/ST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161591; c=relaxed/simple;
	bh=XyfUa9YUfSVbElesWZeKwyIgT+WmILg+rHDvUh0HSrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCWKABbVLKnJCouQ2y4jLqiJG4GV12mFLBvKkXOg94s5qxUDeQWifCmLeH1lBuJdZpUZoK3BXXAZxeveBCWyRz2AdxxA6OxD0CxHx1OzzxT3swOS8FpJM8FfMjsl5aMy5smr+k+kOtOFuZzGLKToH60cWmXEJC1Ipo9KEHIzPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xoNWz0mx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a742481aso37161235e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733161585; x=1733766385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrNxnxZJyu0z/HPVoRTCfySDcSpKmA98viOx0ChTOpY=;
        b=xoNWz0mxlH1o0NlWBT9t9wYy1mlDDAlqsCAr4yiDcf58apmBe4niwfjly+qF5qgprR
         gVj2WmRhoqwYDTPfVKV90KR63cNHXLK1lNd5P0L+UDqnRSumzUzyQAtG43Ch0xak6Gn8
         RrKJ6VsgcSYni20PXQPeCWOmuFmM7NjmAWfW0s5P9iA5AUGmM7o0OekHVbXKoysugQii
         pPkZsvr/GgmdvsMKVyT3DW3VMgLSkAFM2ZKE90E73NxvcAkH+qIXoSDioJMkpj5nOHid
         oigRRs3upn/iko2piG30lAo2UnWwfUZghwp4yvCHVuBrPrNvhQIdkpq4zGUq1q+YyAVv
         UZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161585; x=1733766385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrNxnxZJyu0z/HPVoRTCfySDcSpKmA98viOx0ChTOpY=;
        b=HlNsmb3FjMwEm2RWQrAe+xJ8GGsoDwXFPMiisC3SQiJL4/yCSzl5BOZ9Wrc9tGuGKC
         T9Ph7yjSh7XRIxltfUikPrdpsjjYF0XAq+ClCq0wG845dqQfWDsikzMI0mscg/VwOAW7
         OfKDo87kOfpqc7bUs2AbF/K40qyyCNmBfQMBWtqpE5lqdavNGEB1BoEPpDQLjqBOR+Q/
         RRkW63d2P7LmNuPV5+ORdv2cyS2MTaBCkqPvlGyOCF79efU1dUoCpxPRLL4zufkV/Wgs
         pDFfDpTf/H0SGFIgEKf2Roi8Bl6bxOL7zJwBPLbWLgkrANdJGD35WrdFzat4s/vvWSYo
         3PtA==
X-Forwarded-Encrypted: i=1; AJvYcCWQFZFLeNDssUvY946Wp900467OTJlPgixXsjTzv+scdWjPo/O+Ctyd0IfpF1XEQyURk0B5Vde+7psdmwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26UEDbDMKdKxbhsTWF8YOyljDBu/CP091z6snESSPnqoESZDj
	DCra+P1qCP8+qNWX75+bVGMHwwcBKHCRRFvX427dLJd2n1p0XJMKwWGH72uSWzU=
X-Gm-Gg: ASbGnctXtqIyY2vK0361p3FkG+wgGBz8bWXBnhZ3oxappSmx8tGZCdN9hLle3sR/E+9
	+hlhlkE+uAGPJxZdjkTvhHRT4Snpr3bNv7gmsGiqGfrU05JmujK7HhjyvPko4okcDOiC02EnmVt
	Z88NxEmBCXQkJFixf9TfrLVk1C+n7DqXVah2kVeRF51fRzTVexth8RHdGOwde7Hex1OgorI+TGX
	erLgGSS5+4uUrHF8bE9eKRlVQohv6NcFMhjyMa+nmWPkksNoXpBa4DnIZU=
X-Google-Smtp-Source: AGHT+IHWZpMD9BHt8HZ1Zol/LPw4HFq6GIKduvByiyw2TlPUkq0LEdLvSgJYkIxSIGL1/dlGQ5gE6w==
X-Received: by 2002:a05:600c:474e:b0:42c:de2f:da27 with SMTP id 5b1f17b1804b1-434a9dbc432mr219895875e9.2.1733161585518;
        Mon, 02 Dec 2024 09:46:25 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:f271:ff3b:369e:33b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm193275855e9.29.2024.12.02.09.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:46:24 -0800 (PST)
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
Subject: [PATCH 09/11 v3] sched/fair: Rename cfs_rq.nr_running into nr_queued
Date: Mon,  2 Dec 2024 18:46:04 +0100
Message-ID: <20241202174606.4074512-10-vincent.guittot@linaro.org>
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

Rename cfs_rq.nr_running into cfs_rq.nr_queued which better reflects the
reality as the value includes both the ready to run tasks and the delayed
dequeue tasks.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/debug.c |  2 +-
 kernel/sched/fair.c  | 38 +++++++++++++++++++-------------------
 kernel/sched/sched.h |  4 ++--
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e300ee4d7956..5e8e84a2bcb1 100644
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
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_idle", cfs_rq->h_nr_idle);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46a6e49b4f1c..95c51604e1ba 100644
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
 
@@ -5423,7 +5423,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		__enqueue_entity(cfs_rq, se);
 	se->on_rq = 1;
 
-	if (cfs_rq->nr_running == 1) {
+	if (cfs_rq->nr_queued == 1) {
 		check_enqueue_throttle(cfs_rq);
 		if (!throttled_hierarchy(cfs_rq)) {
 			list_add_leaf_cfs_rq(cfs_rq);
@@ -5568,7 +5568,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if (flags & DEQUEUE_DELAYED)
 		finish_delayed_dequeue_entity(se);
 
-	if (cfs_rq->nr_running == 0)
+	if (cfs_rq->nr_queued == 0)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 
 	return true;
@@ -5916,7 +5916,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 		list_del_leaf_cfs_rq(cfs_rq);
 
 		SCHED_WARN_ON(cfs_rq->throttled_clock_self);
-		if (cfs_rq->nr_running)
+		if (cfs_rq->nr_queued)
 			cfs_rq->throttled_clock_self = rq_clock(rq);
 	}
 	cfs_rq->throttle_count++;
@@ -6025,7 +6025,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 */
 	cfs_rq->throttled = 1;
 	SCHED_WARN_ON(cfs_rq->throttled_clock);
-	if (cfs_rq->nr_running)
+	if (cfs_rq->nr_queued)
 		cfs_rq->throttled_clock = rq_clock(rq);
 	return true;
 }
@@ -6125,7 +6125,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	assert_list_leaf_cfs_rq(rq);
 
 	/* Determine whether we need to wake up potentially idle CPU: */
-	if (rq->curr == rq->idle && rq->cfs.nr_running)
+	if (rq->curr == rq->idle && rq->cfs.nr_queued)
 		resched_curr(rq);
 }
 
@@ -6426,7 +6426,7 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	if (!cfs_bandwidth_used())
 		return;
 
-	if (!cfs_rq->runtime_enabled || cfs_rq->nr_running)
+	if (!cfs_rq->runtime_enabled || cfs_rq->nr_queued)
 		return;
 
 	__return_cfs_rq_runtime(cfs_rq);
@@ -6944,14 +6944,14 @@ requeue_delayed_entity(struct sched_entity *se)
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
index 9a9220aad9fc..aef716c41edb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -645,7 +645,7 @@ struct balance_callback {
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
-	unsigned int		nr_running;
+	unsigned int		nr_queued;
 	unsigned int		h_nr_queued;       /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_idle; /* SCHED_IDLE */
@@ -2565,7 +2565,7 @@ static inline bool sched_rt_runnable(struct rq *rq)
 
 static inline bool sched_fair_runnable(struct rq *rq)
 {
-	return rq->cfs.nr_running > 0;
+	return rq->cfs.nr_queued > 0;
 }
 
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-- 
2.43.0


