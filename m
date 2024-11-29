Return-Path: <linux-kernel+bounces-425760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E749DEAC5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7B0163BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C5119C566;
	Fri, 29 Nov 2024 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUKOcADs"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617F198E61
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897089; cv=none; b=ABzrxbLxOMjzwbbCMHMGekh29jUiJ8DWdjUq6mkaS8u/E75RePBB9UoZOQoblG+NGOa+mFYOcF1tyrUJwoSrjDdycsSF0vVKRK6Nbf9xngaPOBLRObX0lsepX1geEeL3rDELoLVnQd/e9wyaE9fmN+fmWqkpdGuUBnb2Jx5Wedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897089; c=relaxed/simple;
	bh=tqNOtmW96sg8iet4ogIXsIsEvh2i05V9tNvLJtxW64U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUp0mZHR7Ix4fPZ67HBJTpiOOIXTppybtnlBXtaKV7YEbeI1CKLv+czJRFKfDvfLkVrTu+71V+L7g8e9RoGOEIBe9LhSgHe8LWfNVxMRhx84Z5/uyKDVu7RYPiNOLKaZ0QcDZv8ewD+xXu/cGT3Dpqbdj0MMz/ju1XpY27mtlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WUKOcADs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-432d86a3085so17991135e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732897086; x=1733501886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vF2R4EUT+nJZbHQI5DrM5xiVMJG0f4OOkPOReTcBCxU=;
        b=WUKOcADseB/0bfzbQWAo4zfJP0Q05rFkq3CONuFCNa/GDmK2L587Xq2kqqv8DC8v5o
         qYKEmPw9SQDLZ7C6R2Gj/4KKcSWIZSIzm2IuBuKHYPNP6e381D5/WRB0FDdf9SeSnxbH
         +06SH5a5D7/PnQJVr1HGopQJd6i/bV+qSV9YOCaLQrIv7G1eVG+vlTOOWQ0vBn7gbKCv
         zGZfK1s33VXQpb1rDAci3mKWR4AIhGO3tOeWV0UXHLCI8kCdDcfhiWyZGKo36s2Z6sn4
         M+xVFf8SjQlA7tbf1BzKMG9ad0Nj2izh2u4yTMtxI42yiGbnzq0hBu3QKSbIUruQcCnz
         ie6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897086; x=1733501886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF2R4EUT+nJZbHQI5DrM5xiVMJG0f4OOkPOReTcBCxU=;
        b=fdI2pWK+t74zM0SdFAA+IZM2Ap7VsvANSiXpaGzky7wQ6NqwrK7390L1slrH9tahh9
         HLB4X+D/HmFF4pEpaUZM2QTFRQS8gU4d32somQWPIvUcMYcQml+70m4pAlflhXGFA/Ja
         zcFIwtyla48IgTFub/n3OwoOH0t1o+fdseQtmvIa0m+jS8K8OzTBsuuZ5MFyCEgDFZOz
         3ZxnBJUDLRcOs9pEhCYy998qDADzbDebV3qgprmsYTwch7inpYHDSXpRFxiB5nkcLGIW
         9urQwwsZwCOcQHZfZzr7sZMryep4cbe2syqv0D1Fp4jFuS2SoFTmDWn3FgTVdHanIfPl
         tcWg==
X-Forwarded-Encrypted: i=1; AJvYcCUnHyQMr5j72WHppCI3wT5xr5/W3H2AGm+thTm4dT8HlAuZFborvWyotklwLb7eSQxscNZV26K4rLO3ENk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIj6Iyt9wcQpJki6/Ah3LMrnf/r4fovgDZjT9vuvn7rN1/wCs9
	e/U11P+fisZUSTSjQQxZaQTdS8UsKGjvUWBdXJuSg7f0X4GK7bSRRZqsJzXcShE=
X-Gm-Gg: ASbGncuvT3HWHR12eSOrIMxBRZuLctjizXiPqhERd8pYwd0C+xvsquaM8oTgCeQ/Pkg
	HhK0WIPU3hxA+4YX+XC1wVy9B5yzY4bxnmHhtma1BgEvR37f4YmcJIgHfKOfnOadcZKPxrSzVb8
	TdJkJiWfVT83Ah4zyGqogX2TfzJPoTBKtS7KgRDbdJD7ZaEvqkpa3lKHyeUSF2YpV6+S/eLU+PA
	mN9dNjpyxCSLpxTr1H8duOpimJaJj1Q9G1yEgMW2Vizt2MyZwf+iz5QtYg=
X-Google-Smtp-Source: AGHT+IFbikcBofclt6kKPgOT/PkUTy9kvil+mRrmrXpD3qGu4K0mEXRYd1TZsK9MI+vZ7Y2naBY8+A==
X-Received: by 2002:a05:600c:5012:b0:434:a396:9474 with SMTP id 5b1f17b1804b1-434a9dd0586mr122079975e9.18.1732897085601;
        Fri, 29 Nov 2024 08:18:05 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c54b:5636:4db3:1028])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm56771665e9.15.2024.11.29.08.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:18:04 -0800 (PST)
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
Subject: [PATCH 04/10 v2] sched/fair: Removed unsued cfs_rq.h_nr_delayed
Date: Fri, 29 Nov 2024 17:17:50 +0100
Message-ID: <20241129161756.3081386-5-vincent.guittot@linaro.org>
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

h_nr_delayed is not used anymore. We now have
- h_nr_runnable which tracks tasks ready to run
- h_nr_queued which tracks queued tasks either ready to run or delayed
  dequeue

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/debug.c |  1 -
 kernel/sched/fair.c  | 45 ++++++++++++++------------------------------
 kernel/sched/sched.h |  1 -
 3 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index fd711cc4d44c..56be3651605d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -846,7 +846,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_runnable", cfs_rq->h_nr_runnable);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
-	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
 			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d5736bde3682..c13163deb92c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5472,21 +5472,18 @@ static void set_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		cfs_rq->h_nr_runnable--;
-		cfs_rq->h_nr_delayed++;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 	}
 }
 
-static void clear_delayed(struct sched_entity *se, bool running)
+static void clear_delayed(struct sched_entity *se)
 {
 	se->sched_delayed = 0;
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-		if (running)
-			cfs_rq->h_nr_runnable++;
-		cfs_rq->h_nr_delayed--;
+		cfs_rq->h_nr_runnable++;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 	}
@@ -5494,7 +5491,7 @@ static void clear_delayed(struct sched_entity *se, bool running)
 
 static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
 {
-	clear_delayed(se, false);
+	se->sched_delayed = 0;
 	if (sched_feat(DELAY_ZERO) && se->vlag > 0)
 		se->vlag = 0;
 }
@@ -5937,7 +5934,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_task_delta, delayed_delta, dequeue = 1;
+	long queued_delta, runnable_delta, idle_task_delta, dequeue = 1;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5971,7 +5968,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	queued_delta = cfs_rq->h_nr_queued;
 	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
-	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		int flags;
@@ -5996,7 +5992,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
-		qcfs_rq->h_nr_delayed -= delayed_delta;
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -6020,7 +6015,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
-		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6046,7 +6040,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_task_delta, delayed_delta;
+	long queued_delta, runnable_delta, idle_task_delta;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6083,7 +6077,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	queued_delta = cfs_rq->h_nr_queued;
 	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
-	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -6102,7 +6095,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
-		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6121,7 +6113,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
-		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6975,7 +6966,7 @@ requeue_delayed_entity(struct sched_entity *se)
 	}
 
 	update_load_avg(cfs_rq, se, 0);
-	clear_delayed(se, true);
+	clear_delayed(se);
 }
 
 /*
@@ -6989,7 +6980,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
-	int h_nr_delayed = 0;
+	int h_nr_runnable = 0;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	u64 slice = 0;
@@ -7017,7 +7008,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
 	if (task_new)
-		h_nr_delayed = !!se->sched_delayed;
+		h_nr_runnable = !se->sched_delayed;
 
 	for_each_sched_entity(se) {
 		if (se->on_rq) {
@@ -7039,11 +7030,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_entity(cfs_rq, se, flags);
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		if (!h_nr_delayed)
-			cfs_rq->h_nr_runnable++;
+		cfs_rq->h_nr_runnable += h_nr_runnable;
 		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
-		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
@@ -7065,11 +7054,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		if (!h_nr_delayed)
-			cfs_rq->h_nr_runnable++;
+		cfs_rq->h_nr_runnable += h_nr_runnable;
 		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
-		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
@@ -7132,7 +7119,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	struct task_struct *p = NULL;
 	int idle_h_nr_running = 0;
 	int h_nr_queued = 0;
-	int h_nr_delayed = 0;
+	int h_nr_runnable = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
 
@@ -7141,7 +7128,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		h_nr_queued = 1;
 		idle_h_nr_running = task_has_idle_policy(p);
 		if (!task_sleep && !task_delayed)
-			h_nr_delayed = !!se->sched_delayed;
+			h_nr_runnable = !se->sched_delayed;
 	} else {
 		cfs_rq = group_cfs_rq(se);
 		slice = cfs_rq_min_slice(cfs_rq);
@@ -7157,11 +7144,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			break;
 		}
 
-		if (!h_nr_delayed)
-			cfs_rq->h_nr_runnable -= h_nr_queued;
+		cfs_rq->h_nr_runnable -= h_nr_runnable;
 		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
-		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = h_nr_queued;
@@ -7198,11 +7183,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		if (!h_nr_delayed)
-			cfs_rq->h_nr_runnable -= h_nr_queued;
+		cfs_rq->h_nr_runnable -= h_nr_runnable;
 		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
-		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = h_nr_queued;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e0b05ab43abd..e098b852704a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -650,7 +650,6 @@ struct cfs_rq {
 	unsigned int		h_nr_queued;
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
-	unsigned int		h_nr_delayed;
 
 	s64			avg_vruntime;
 	u64			avg_load;
-- 
2.43.0


