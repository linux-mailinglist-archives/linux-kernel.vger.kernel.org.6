Return-Path: <linux-kernel+bounces-424468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753B69DB4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0115B22A85
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA681198845;
	Thu, 28 Nov 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="roZPrRia"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E56192B94
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786088; cv=none; b=QAmr9i079+PAHVi+NE3+7IBEBTDR3736KuvAfdZt1iNUSpzb8bguTS7jWu+rpgrsWX3uKwytZTJIWq81WVBcS4uSWXrFOuW8QhBr8XY+/GTv5YFirM17SgMXEvRgKEhZGE79pYSXAYC45DHrOHa3DaUpAaL1DYdlKy79ar7PHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786088; c=relaxed/simple;
	bh=dWnM/7fMGmDUt4fGQfcYcFzuYHJ6obAGrUXWMxvqB6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbnYOf3cbNuLB3itQjh89B10N9MWWkNwVnNUbColCXBEyuNUn+B+wOmo3v75Zq++FAZs/8Znof3QlZ/1NpkzQr7azLe8vp69ZbQ/XJ7hNH3UpNLpPQPD997fHph2TXwxXSMhLCm9cVam5MZ+TNBwbAJOGmVR5H1SQrTDJRfAcjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=roZPrRia; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a752140eso5040495e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732786084; x=1733390884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sCmgeQzfYei2G42vQ2RJNQKdvbxfWwnCrC/7TrOSpU=;
        b=roZPrRiaWXfeuIq8NV+0/cdfuOkskilTg1ejYrgg0O9Fe3vkJjz7SSGWxHx37RmBFc
         JhjzDWMATznZjydg7gzKgtOtqS3RVgdfjNiYQP4M0InMoDwk7IcHT4pZxXisY4dbIfZ0
         yDUIR8S8X0ct4SCPUT2Uce8pXP9WXFvhFcgfskm5w6qe+rfGZf9HWxxndey3RF1Y1+fI
         Z4X94ImJWAzU5hXQLSRAVdz4X+y6V9e5NwarKPHNNnS1ITZB9nvm5MvZMCInJb1mXwCg
         +Ak6p2HH41RbOE+eaAmKh556Q/qM/rnXkh5GZQJaChn2GMrRPAzsHVazI9Yuu8kkjHJa
         DYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732786084; x=1733390884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sCmgeQzfYei2G42vQ2RJNQKdvbxfWwnCrC/7TrOSpU=;
        b=AzZZvyUUeKLh74pPf0RCZ2ztvEInEYK0Vi9fOzDBeoOHGDrSoM8vz+Vy/EZAYQe/xP
         oaRsWs83MERKL3/rJ1cfPVahmFiVfZLyQVgOgVyPbCyrt3jKZeKWYq6KnumoJZBbm0Vi
         ITHhYnOyVNZdmF5l9zUS9MApBFYPhJMfBP60sUAP5owtxCijbbmVFFNV/7m+8Ziw72WQ
         g7/0N7U1AWfNGBLIgpZNz2BL0HFmT9Zov8oScRjnoL5BPjEkdvO27R6+Gnly9JTWEsdJ
         GY8A32t6nYTC7XXXeUxuGyvGbQthTXt1WPgc2+lp9RA36KGiR2EFi3dod6EgY3R7g9qV
         VxcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC+PBZv+3/oQl5qraM1CJHbfNDHhHm3O9QxFdK8fc9EeasV0ZChv5NHiQjk5z1dxoPXHKF7d4IdgExYR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxGlbQ/9pA/nGprKoRwZuWD85KJsO7+L1Ehvqk6lp6K0po3AT1
	yNQT7nYhhmRE3+12ieovPPsh9bxyOUON5GgdDO/oeT7p5XpHcSiaroYUFhCb3RU=
X-Gm-Gg: ASbGncsXAstWE8//Ivvo/OIAh051y+ZbfSTjwffnYQexB0LrnNgoXFEbTUiRqvW+fUR
	0DGTvwI6M+Q24vGvGN+fWY737SunA2MuIaTL+L9FWQQA3QXaBxEjvuylW7Ll5N8eR83nkeikW7T
	oO64E/HCarcwbjsJ0IU2337c4RnryHM7ZGnn1ZYwxQ0qdOZ4uKqFTtjDb8a2hCGT3PKDPxL0HyE
	HDNgzmSVGU9DOoSIN8LNZJlwqFoBWXpncv0R/UcD2sSQ8HqPFACOmFKoUg=
X-Google-Smtp-Source: AGHT+IGbAZ8sOAp9ERSWKNx1W3oZeGtODmDr/HyIMa7lWX9KL1Icz6v5ae0QqXM0gzN9crt1RckdQw==
X-Received: by 2002:a05:600c:3ba6:b0:434:9e63:faff with SMTP id 5b1f17b1804b1-434a9dbc41bmr58648595e9.2.1732786084085;
        Thu, 28 Nov 2024 01:28:04 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c0d5:15dc:1ec9:3f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm47078885e9.37.2024.11.28.01.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:28:02 -0800 (PST)
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
Subject: [PATCH 6/9] sched/fair: Removed unsued cfs_rq.h_nr_delayed
Date: Thu, 28 Nov 2024 10:27:47 +0100
Message-ID: <20241128092750.2541735-7-vincent.guittot@linaro.org>
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

h_nr_delayed is not used anymore. We now have
- h_nr_running which tracks tasks ready to run
- h_nr_enqueued which tracks enqueued tasks either ready to run or delayed
  dequeue

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/debug.c |  1 -
 kernel/sched/fair.c  | 41 ++++++++++++++---------------------------
 kernel/sched/sched.h |  1 -
 3 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8f5273043c16..84f623b9d4af 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -846,7 +846,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_enqueued", cfs_rq->nr_enqueued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_enqueued", cfs_rq->h_nr_enqueued);
-	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_idle",
 			cfs_rq->h_nr_idle);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a96a771d8e61..1b4f1b610543 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5468,21 +5468,18 @@ static void set_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		cfs_rq->h_nr_running--;
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
-			cfs_rq->h_nr_running++;
-		cfs_rq->h_nr_delayed--;
+		cfs_rq->h_nr_running++;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 	}
@@ -5490,7 +5487,7 @@ static void clear_delayed(struct sched_entity *se, bool running)
 
 static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
 {
-	clear_delayed(se, false);
+	se->sched_delayed = 0;
 	if (sched_feat(DELAY_ZERO) && se->vlag > 0)
 		se->vlag = 0;
 }
@@ -5934,7 +5931,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long running_delta, enqueued_delta, idle_delta, delayed_delta, dequeue = 1;
+	long running_delta, enqueued_delta, idle_delta, dequeue = 1;
 	long rq_h_nr_enqueued = rq->cfs.h_nr_enqueued;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5968,7 +5965,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	running_delta = cfs_rq->h_nr_running;
 	enqueued_delta = cfs_rq->h_nr_enqueued;
 	idle_delta = cfs_rq->h_nr_idle;
-	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		int flags;
@@ -5993,7 +5989,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_running -= running_delta;
 		qcfs_rq->h_nr_enqueued -= enqueued_delta;
 		qcfs_rq->h_nr_idle -= idle_delta;
-		qcfs_rq->h_nr_delayed -= delayed_delta;
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -6017,7 +6012,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_running -= running_delta;
 		qcfs_rq->h_nr_enqueued -= enqueued_delta;
 		qcfs_rq->h_nr_idle -= idle_delta;
-		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6043,7 +6037,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long running_delta, enqueued_delta, idle_delta, delayed_delta;
+	long running_delta, enqueued_delta, idle_delta;
 	long rq_h_nr_enqueued = rq->cfs.h_nr_enqueued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6080,7 +6074,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	running_delta = cfs_rq->h_nr_running;
 	enqueued_delta = cfs_rq->h_nr_enqueued;
 	idle_delta = cfs_rq->h_nr_idle;
-	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -6099,7 +6092,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_running += running_delta;
 		qcfs_rq->h_nr_enqueued += enqueued_delta;
 		qcfs_rq->h_nr_idle += idle_delta;
-		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6118,7 +6110,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_running += running_delta;
 		qcfs_rq->h_nr_enqueued += enqueued_delta;
 		qcfs_rq->h_nr_idle += idle_delta;
-		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6972,7 +6963,7 @@ requeue_delayed_entity(struct sched_entity *se)
 	}
 
 	update_load_avg(cfs_rq, se, 0);
-	clear_delayed(se, true);
+	clear_delayed(se);
 }
 
 /*
@@ -6986,7 +6977,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int h_nr_idle = task_has_idle_policy(p);
-	int h_nr_delayed = 0;
+	int se_delayed = 0;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_enqueued = rq->cfs.h_nr_enqueued;
 	u64 slice = 0;
@@ -7014,7 +7005,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
 	if (task_new)
-		h_nr_delayed = !!se->sched_delayed;
+		se_delayed = !!se->sched_delayed;
 
 	for_each_sched_entity(se) {
 		if (se->on_rq) {
@@ -7036,11 +7027,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_entity(cfs_rq, se, flags);
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		if (!h_nr_delayed)
+		if (!se_delayed)
 			cfs_rq->h_nr_running++;
 		cfs_rq->h_nr_enqueued++;
 		cfs_rq->h_nr_idle += h_nr_idle;
-		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = 1;
@@ -7062,11 +7052,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		if (!h_nr_delayed)
+		if (!se_delayed)
 			cfs_rq->h_nr_running++;
 		cfs_rq->h_nr_enqueued++;
 		cfs_rq->h_nr_idle += h_nr_idle;
-		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = 1;
@@ -7129,7 +7118,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	struct task_struct *p = NULL;
 	int h_nr_idle = 0;
 	int h_nr_running = 0;
-	int h_nr_delayed = 0;
+	int se_delayed = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
 
@@ -7138,7 +7127,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		h_nr_running = 1;
 		h_nr_idle = task_has_idle_policy(p);
 		if (!task_sleep && !task_delayed)
-			h_nr_delayed = !!se->sched_delayed;
+			se_delayed = !!se->sched_delayed;
 	} else {
 		cfs_rq = group_cfs_rq(se);
 		slice = cfs_rq_min_slice(cfs_rq);
@@ -7154,11 +7143,10 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			break;
 		}
 
-		if (!h_nr_delayed)
+		if (!se_delayed)
 			cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->h_nr_enqueued -= h_nr_running;
 		cfs_rq->h_nr_idle -= h_nr_idle;
-		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_running;
@@ -7195,11 +7183,10 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		if (!h_nr_delayed)
+		if (!se_delayed)
 			cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->h_nr_enqueued -= h_nr_running;
 		cfs_rq->h_nr_idle -= h_nr_idle;
-		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_running;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7d99d18e8984..0b297242eb5d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -649,7 +649,6 @@ struct cfs_rq {
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_enqueued;
 	unsigned int		h_nr_idle; /* SCHED_IDLE */
-	unsigned int		h_nr_delayed;
 
 	s64			avg_vruntime;
 	u64			avg_load;
-- 
2.43.0


