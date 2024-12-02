Return-Path: <linux-kernel+bounces-428113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556AE9E0A59
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0A616230D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E611DDC13;
	Mon,  2 Dec 2024 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sw+2MAKG"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817C1DB940
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161578; cv=none; b=ohw03QdEGjNpAH+eoJZ+bOHwy4siPAFIkQF6jGkm0+b7IPd+Y9zeSLh4yp/GdNDVOg4arNdLSs9afAIBwGqSpm6ByIxVRg55+CBvap8CG6RCqJ6npHr5BII1qWY1LmjSPrhckGvC/07HnHu5EvjW4Eg8aGljc+aKSyzZwigc+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161578; c=relaxed/simple;
	bh=dlupHd+njlE7jJ2Rs1AySOi0dOpE8uNlQ64FxIFDBnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7bqPmjAq2Pdrjbnl/1QCmaq2aAVJKx14Pfu++C80y/cw57hdnVB/8QvaOE3Yb0BEKjjNkk588OTYxxnb+7ti2OhT5PL3uc1ArV5M//a67aKrvIVbZx8+qhBGCk+p+zjDKrhltUHUF+Rueqsf9ZnRj3lvNKoncxbwWRovN3YSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sw+2MAKG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so42974615e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733161574; x=1733766374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38f3rBCxzrz2c9uXXio6KuyhyFwB3F5q6yyrAFCosaw=;
        b=Sw+2MAKGTEE5+vlbUveD0NpAvwz3M2OeTCfs8dlWRskUD+My6yvfqk6UJ55MBq0KbN
         gYZa9hXRNOjemhJtUAFyVv9Tz5s50qpqAOa2mDYH0SZBSChlG6BEycm1Z3StZxqdqPcT
         4MV7iD0QnIKFaAepNbf/9lA4o/46V2jfyDkawGu1bPp/ALzORFn7GHxrUGpi0zaRmeo9
         AFQeH5Y+ExbH2UzANb6NMXXk8+6yeV6gw5F/Fmggcz1Kkim1HDECT7RAOTAUFClGb667
         aSF30fxLDL/uzVf2MWQu1/4QlacSwjTgZzpkPNAvaWM2VwpxPRXz/ljUQgW/ZTksy525
         t+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161574; x=1733766374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38f3rBCxzrz2c9uXXio6KuyhyFwB3F5q6yyrAFCosaw=;
        b=t9iuSkI68o2mYD39bFQ1BhsINYkRxYTXIzbT7lNIqS0EqLAIeXfkmAALlZl7O0AyVc
         bL9ziAQp8xisznxr7g/Wm9a3q7uIFyDEI2x+9Y8CloBllzzhJnJ4GbXPfsYYg7ifUqcr
         6RFgCse1JOEcjOFFuA0VYKzJZ3k6dK6FX8hz/XfiROB1hMmzCT6ZDl1cuzaq4DJasGbA
         7CiJDWMKnKUHIELixBDx7TAxzaHrog+/4D5lMOpXjYlZ0CZqjflpTSwRO/ANdlArTOb0
         jBcD7qk0enBqBSwnOCo5TXC8sH2819K3XM5MgljYDzEflvnfuwVGRlJxVNUmaepsKINZ
         kYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWScKgDNnR+ysqFCkv1qEkspvFJ+iphEHfay28GkNFGnbFTdAN/n3AZ01MbduO3qrL2IFN+YvrjdA4Q5e8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypj3PcRVI2b8fHIY/zt8xxvaUCqE0oXEuUmzo7b5vtX9M1vRjy
	bfsxnv8XCX9027n+nQwPm+/GSi+KAU6NalZTNnZiDb+r1YFEu12yCd/F4nJVnlo=
X-Gm-Gg: ASbGncs95xu6PrlLyuYG9tmcPBMKi5BoKD+L8lRirWo4sm0djpB4ty6RrPXrwt2ymMj
	V9pDiaqwo/pqrX5ibb1xRMyKEDMqfJxgCVlfMdkYV658cCj2JZ3zmk3zhCAce96B0Xy3j/xq4dk
	WenkX3VKe7XWvYcoZ9W6O7626+QNmgisUPrKVjsaTzKhXg0vzwqx1/iWRZEc+mLKlknc+k0z3xz
	BXQpulTPdIIVCMncXA2XhQcV9P6CMVJAA8cvrF3isbnS53sHUuKliQyRx4=
X-Google-Smtp-Source: AGHT+IE3KT6IRqQVQo830z7cat+AqDap0oAyQ2msOIzq4sLdYzRFZsde3Q897a8HHmyqw5AP9Jprtw==
X-Received: by 2002:a05:600c:1c98:b0:434:a962:2aa0 with SMTP id 5b1f17b1804b1-434a9df13a6mr199769375e9.32.1733161574442;
        Mon, 02 Dec 2024 09:46:14 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:f271:ff3b:369e:33b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm193275855e9.29.2024.12.02.09.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:46:13 -0800 (PST)
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
Subject: [PATCH 02/11 v3] sched/eevdf: More PELT vs DELAYED_DEQUEUE
Date: Mon,  2 Dec 2024 18:45:57 +0100
Message-ID: <20241202174606.4074512-3-vincent.guittot@linaro.org>
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
[ Fixes checkpatch warnings and rebased ]
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
index 4283c818bbd1..fc69aab57870 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5463,9 +5463,33 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
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
@@ -5495,7 +5519,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 			if (cfs_rq->next == se)
 				cfs_rq->next = NULL;
 			update_load_avg(cfs_rq, se, 0);
-			se->sched_delayed = 1;
+			set_delayed(se);
 			return false;
 		}
 	}
@@ -5909,7 +5933,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, dequeue = 1;
+	long task_delta, idle_task_delta, delayed_delta, dequeue = 1;
 	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5942,6 +5966,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
+	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		int flags;
@@ -5965,6 +5990,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_delayed -= delayed_delta;
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -5987,6 +6013,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6012,7 +6039,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta;
+	long task_delta, idle_task_delta, delayed_delta;
 	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6048,6 +6075,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
+	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -6065,6 +6093,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6082,6 +6111,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6930,7 +6960,7 @@ requeue_delayed_entity(struct sched_entity *se)
 	}
 
 	update_load_avg(cfs_rq, se, 0);
-	se->sched_delayed = 0;
+	clear_delayed(se);
 }
 
 /*
@@ -6944,6 +6974,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
+	int h_nr_delayed = 0;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_running = rq->cfs.h_nr_running;
 	u64 slice = 0;
@@ -6970,6 +7001,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (p->in_iowait)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
+	if (task_new)
+		h_nr_delayed = !!se->sched_delayed;
+
 	for_each_sched_entity(se) {
 		if (se->on_rq) {
 			if (se->sched_delayed)
@@ -6992,6 +7026,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
@@ -7015,6 +7050,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
@@ -7077,6 +7113,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	struct task_struct *p = NULL;
 	int idle_h_nr_running = 0;
 	int h_nr_running = 0;
+	int h_nr_delayed = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
 
@@ -7084,6 +7121,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		p = task_of(se);
 		h_nr_running = 1;
 		idle_h_nr_running = task_has_idle_policy(p);
+		if (!task_sleep && !task_delayed)
+			h_nr_delayed = !!se->sched_delayed;
 	} else {
 		cfs_rq = group_cfs_rq(se);
 		slice = cfs_rq_min_slice(cfs_rq);
@@ -7101,6 +7140,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = h_nr_running;
@@ -7139,6 +7179,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
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
index 5eb2d5b9722f..99d19c605e4f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -649,6 +649,7 @@ struct cfs_rq {
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
+	unsigned int		h_nr_delayed;
 
 	s64			avg_vruntime;
 	u64			avg_load;
@@ -898,8 +899,11 @@ struct dl_rq {
 
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


