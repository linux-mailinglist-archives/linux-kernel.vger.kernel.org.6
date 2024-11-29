Return-Path: <linux-kernel+bounces-425758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4FF9DEAC3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F48163AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B626166F32;
	Fri, 29 Nov 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lH0KGkGP"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E845BEC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897085; cv=none; b=teOo8UxZ0JWc5ne/QlA6UTQ+7ZkHB6mRGzSHIOYdL8ORFb/zA2mfMSYJH20SI1AsW9liCypinmsUAR/UlcTm7+tBeN9jqhUUyIJk/WxeNKyaNcKhew61YZWXdL7TE1xLt5qaOPpxc4E/HJkpIuYO3qoeNb6ld8DVvXXqQaBKeu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897085; c=relaxed/simple;
	bh=mVjbS47HdiYvofNh5GZkckIEOg0gcnZo8m6/Giv5pm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8V4A9s/7hyak4nqvt/FObOEMHrk2p0pVaJKz3h5cE6IKqi5tXc6CMfkO4qX/clDnRJCVHC59SuUI0/VDrJHmjgqeaGACt8/Il+ow3A2Aru1nPsJJU3aypRX+UUhoFKFVLrHZh/ac7GGkFH3nP7xQ39d5Wz0aeoNHoN+fCUSJLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lH0KGkGP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a45f05feso22577385e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732897082; x=1733501882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlFKgVHb4nQ5bY+wYMwnva3c054rOZjazLjMOFEFCGI=;
        b=lH0KGkGP99GfCa07Z3ETGm90TOk/Gse9KXb1es3clYOwdljXrcL891qh9UT0BidLo0
         vFBGgod/HtMS8qNiSnk6dn/F+u0EH8wIk8atXrqakyA4AijJBk2dabS6kt7Lsh9rq8yE
         +f8KCVO4TljXYUjFiAoQG8jnRyxYwG2jZ4ZXvl2HMkSlzVXS5IFGh/1waxNcTpVlkPpf
         qsEuZQAqEG3DQZr8iRnpoRbwxcCs3r39Tt5dncK0k+ma0WVUp06FGg99CR9Adwfy52jm
         rJEwvfHD8wHKiXCaqrEBeelyZpMZvRwukP6NjMPhPhuc781XHmFtE6tuItfmNcIa7rDn
         Mo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897082; x=1733501882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlFKgVHb4nQ5bY+wYMwnva3c054rOZjazLjMOFEFCGI=;
        b=M1I2LoE3Cy474pVZncRszK9DH+KEZyDJASClVrcUMEs+4zgeomxeYS+wTqx/kwzPUV
         jQpAtDmicixO3vtLbcbKyxRjBjFtjBVFmSPesgBPacJnEQsAKUmdUllsdAdJdzOmjDPl
         N3fxbhDeTJ0JLQ/Tui1Xm5togdsRLkgnhmpjFZeO6agfKNrqEyfLsQMR4RV1RMUX5sP9
         YcYyvLVfdU3XvfzC708L2AvBUmonDYDmyBvmI8OjMQWMGy/mpgp64si5Eo8sWehC4pkf
         ngiEbX54ziW7LA7wZ5Ds3CeAdaI3A1dQjRgawAj0xdAq/Tx9AjlJeCJblffEBA7OCiMA
         Sl1g==
X-Forwarded-Encrypted: i=1; AJvYcCUpEjLzsc9kBvnbSWHHKRIqTJWBUjN30dgsipIldUs9whBDNdtVw94RZMQt+Ol9KtjWvQWuoBmBoV4mmpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3YlEBMKvZwaQZah2G3u8s/xkXtznREQx/Ny6x8tUaHeiRC438
	ipwedq7XyDjfWOnYh3UoRgdbVh75ewVHusCcL/ob2YrniJOnttrGhELnWOSyD/4=
X-Gm-Gg: ASbGncs89hFeszVs/86YM5DtmbJTHhfvXQ3NjnD4qSAfdayCfsCUaLpvlB7pzSUFuHZ
	jFG4+UcXGJQ2jmmOjA4hUM97a/hlrN2ADp+SWi6KS9CKJPfqZSpYpNB/j9QlEFkM5EchOaCG0cv
	A4vH9Z3krMobAeigqDbd1Mr8UFtHR1vf5Qq2xCoBSJx7DvquQIk3ZC8V77HSrWj6fZT6vH6SAPc
	Zjy1q9euVEKoWKBY3zv3EK/HT1BHcEMlY2pnL9Ei6gsBdsOvpXtxD2XpzM=
X-Google-Smtp-Source: AGHT+IHxNip/mKKsi5cIrDGLz8EFEzYYZIENgG+Z67N0gzEjPnvbF3TSg7XY3Euzjs1+MkxlWP7oFg==
X-Received: by 2002:a05:600c:4e8a:b0:431:562a:54be with SMTP id 5b1f17b1804b1-434a9dc36c1mr131953595e9.9.1732897081748;
        Fri, 29 Nov 2024 08:18:01 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c54b:5636:4db3:1028])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm56771665e9.15.2024.11.29.08.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:18:01 -0800 (PST)
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
Subject: [PATCH 01/10 v2] sched/eevdf: More PELT vs DELAYED_DEQUEUE
Date: Fri, 29 Nov 2024 17:17:47 +0100
Message-ID: <20241129161756.3081386-2-vincent.guittot@linaro.org>
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

From: Peter Zijlstra <peterz@infradead.org>

Vincent and Dietmar noted that while
commit fc1892becd56 ("sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE") fixes
the entity runnable stats, it does not adjust the cfs_rq runnable stats,
which are based off of h_nr_running.

Track h_nr_delayed such that we can discount those and adjust the
signal.

Fixes: fc1892becd56 ("sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE")
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Closes: https://lore.kernel.org/lkml/a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com/
Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Closes: https://lore.kernel.org/lkml/CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com/
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[ Fixes checkpatch warnings ]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20240906104525.GG4928@noisy.programming.kicks-ass.net
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/debug.c |  1 +
 kernel/sched/fair.c  | 51 +++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/pelt.c  |  2 +-
 kernel/sched/sched.h |  8 +++++--
 4 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a48b2a701ec2..a1be00a988bf 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -845,6 +845,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
 			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3356315d7e64..f4ed2ed070e4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5465,9 +5465,33 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
-static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
+static void set_delayed(struct sched_entity *se)
+{
+	se->sched_delayed = 1;
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		cfs_rq->h_nr_delayed++;
+		if (cfs_rq_throttled(cfs_rq))
+			break;
+	}
+}
+
+static void clear_delayed(struct sched_entity *se)
 {
 	se->sched_delayed = 0;
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		cfs_rq->h_nr_delayed--;
+		if (cfs_rq_throttled(cfs_rq))
+			break;
+	}
+}
+
+static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
+{
+	clear_delayed(se);
 	if (sched_feat(DELAY_ZERO) && se->vlag > 0)
 		se->vlag = 0;
 }
@@ -5497,7 +5521,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 			if (cfs_rq->next == se)
 				cfs_rq->next = NULL;
 			update_load_avg(cfs_rq, se, 0);
-			se->sched_delayed = 1;
+			set_delayed(se);
 			return false;
 		}
 	}
@@ -5910,7 +5934,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, dequeue = 1;
+	long task_delta, idle_task_delta, delayed_delta, dequeue = 1;
 	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5943,6 +5967,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
+	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		int flags;
@@ -5966,6 +5991,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_delayed -= delayed_delta;
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -5988,6 +6014,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6013,7 +6040,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta;
+	long task_delta, idle_task_delta, delayed_delta;
 	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6049,6 +6076,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
+	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -6066,6 +6094,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6083,6 +6112,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6936,7 +6966,7 @@ requeue_delayed_entity(struct sched_entity *se)
 	}
 
 	update_load_avg(cfs_rq, se, 0);
-	se->sched_delayed = 0;
+	clear_delayed(se);
 }
 
 /*
@@ -6950,6 +6980,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
+	int h_nr_delayed = 0;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_running = rq->cfs.h_nr_running;
 	u64 slice = 0;
@@ -6976,6 +7007,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (p->in_iowait)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
+	if (task_new)
+		h_nr_delayed = !!se->sched_delayed;
+
 	for_each_sched_entity(se) {
 		if (se->on_rq) {
 			if (se->sched_delayed)
@@ -6998,6 +7032,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
@@ -7021,6 +7056,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
@@ -7083,6 +7119,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	struct task_struct *p = NULL;
 	int idle_h_nr_running = 0;
 	int h_nr_running = 0;
+	int h_nr_delayed = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
 
@@ -7090,6 +7127,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		p = task_of(se);
 		h_nr_running = 1;
 		idle_h_nr_running = task_has_idle_policy(p);
+		if (!task_sleep && !task_delayed)
+			h_nr_delayed = !!se->sched_delayed;
 	} else {
 		cfs_rq = group_cfs_rq(se);
 		slice = cfs_rq_min_slice(cfs_rq);
@@ -7107,6 +7146,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = h_nr_running;
@@ -7145,6 +7185,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = h_nr_running;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index fc07382361a8..fee75cc2c47b 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -321,7 +321,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
-				cfs_rq->h_nr_running,
+				cfs_rq->h_nr_running - cfs_rq->h_nr_delayed,
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 090dd4b38fa2..77a05ca0cce7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -649,6 +649,7 @@ struct cfs_rq {
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
+	unsigned int		h_nr_delayed;
 
 	s64			avg_vruntime;
 	u64			avg_load;
@@ -897,8 +898,11 @@ struct dl_rq {
 
 static inline void se_update_runnable(struct sched_entity *se)
 {
-	if (!entity_is_task(se))
-		se->runnable_weight = se->my_q->h_nr_running;
+	if (!entity_is_task(se)) {
+		struct cfs_rq *cfs_rq = se->my_q;
+
+		se->runnable_weight = cfs_rq->h_nr_running - cfs_rq->h_nr_delayed;
+	}
 }
 
 static inline long se_runnable(struct sched_entity *se)
-- 
2.43.0


