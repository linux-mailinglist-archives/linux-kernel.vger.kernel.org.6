Return-Path: <linux-kernel+bounces-424465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 793129DB4C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEA75B22155
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3019118D63A;
	Thu, 28 Nov 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q8B6kzP4"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDE5157E82
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786083; cv=none; b=gYMPGeNjDROl+uKUHv2TBmE7ZqFbZRhE7QUT00bvYuuS0ys4vrGVwop9uX/bbOOYwzgg7KuESXAwrxfae3DM0I+soI0j6aD4kGQcI2kZGvyBiEgC2Mcs22w/z9oqEzV0Nf9zdQRL3w8JpBc5/GvA49xi8crKuEWTLbeT7LSN5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786083; c=relaxed/simple;
	bh=AFwaOtlJwBmL7UWVL/LuCsLkRORFbRAcghfQ7vZwWw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RS1qooaBDZ89ZpBSrtCZIoKFYLLSJRQcaGbwCfK7IHu7SYQtKF7WsrF3er7LDAD1GDnjamRXz70reBSbhi4hiqFdPhAWDTMZHfeRD6FvXrrex7OtKEgW01qK13Im32BDRHTRbirSF9F7v/MZTeYVhkUMKLx4dAGyHLIfLpgtZsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q8B6kzP4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-382456c6597so490577f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732786079; x=1733390879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHyrrLyD8GVTk1lrJ8IGYXmn5uMVrFFI+lZ5smrxk9s=;
        b=q8B6kzP4pcfH8OFGeQ2zuP/HJOXp4K0XEUawGaEw8GKdXY9Bpnjm2S/PjuzWEFLG5q
         UOHQlDwvzMCECxE+/S/hlYG1BJOYtsBT7CAL6ngSO7VsIUDe/H+EtYNYiByz90KsE7/Y
         zfalTt48pAKAC2N8VC8k14tBSihZViEwDrPgCpoFQHAtaaAhll1f1vvo8eeY/o/jqypl
         hMq/vHnmjDieOvP028GDvjbYCzX90EO99ptKJ6R3d9a3qeeR/zHPzAy9ysJ7OSCKKViT
         /fIM+kOW8uFWbG+HNymuCW80mypP5OSBdHnZQoVXoyTzceMW3zkiZFdxwzjZtUCJOl2/
         xBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732786079; x=1733390879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHyrrLyD8GVTk1lrJ8IGYXmn5uMVrFFI+lZ5smrxk9s=;
        b=d+40oijY+yf/dCcHJXSEfOdKFLSt9fSLckXVv/fd/J3aIjftBF0+7lNOveIthOrvJl
         RWV3YxWmBevMVG46knJwblkpeHTrwDj+W8or87Kr6LM26KgznbcHIz4MMfsM/7rLg/T6
         0poLtezyjfPrLf63NUUlzDdb80jtHDD0O4vV1wMlVBKwOK2XcbCBM7JLpb9cQbp6Yv4x
         MeNyubgirxucAcmaBJz7lho9JsK2tP+Zch5cgLJrcc8ISTrdxj56AvOGv1IBu/jWqRNX
         XREr2zs/kHFc3CfbLM4izDNq4Dk7YWHI7v6LYcmRkZLOUHXeLjCfUM6Zj6Ku9RM4dUSD
         FL6A==
X-Forwarded-Encrypted: i=1; AJvYcCWQrngnZSW344u0v8MMuuLGcMHT2HN+Jkb1iOLe47P2kmadjPs4b1TUGfYmkmF759m0g+TrlRjQlRXqgbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZZ3yDAMYKwMhzm3b51AGYrtWuRAey1D8Sf9t2RnE+jjzlQLfU
	DQQRBOlsBLq4/rfg6pxDsAtxAO6p6Bh1wjPWqvPz2AxyeB4J/n+gOzJ89UuHh0vAl5pGu7lSxlv
	TOTs=
X-Gm-Gg: ASbGncvjgEd3zzCstLR2H8RCd6jsfOwl4GNxsxm75PZDFLR8l+Pokk6x0c2lVYUP8ny
	h4qFqPP7r2C/kFzI/PQY43YwxamC+oN0M+mOEB3UWra9OfWasjuxHegcRBUbaDWST+YKTpifWa+
	WMW1OngG6VtNHyVf9C7EzlhzYz1+QLJ9jvkU5DYiEAWlV511U75LqEl8Sc8uO70LrXI1vyCGwTg
	T5xHMM/mjxslnz1jZ37J7ZrREMxbrXaPVFWnmoETciCTftQvJTypYeExUI=
X-Google-Smtp-Source: AGHT+IGd79W4eNyWkAVmSWcoCFYN1gmmNchqQI21EFS46Q8ouW1SouVj0543hUKO/49QVSlWok5o2A==
X-Received: by 2002:a05:6000:1561:b0:382:359f:5338 with SMTP id ffacd0b85a97d-385c6ebe4f3mr5666869f8f.34.1732786079578;
        Thu, 28 Nov 2024 01:27:59 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c0d5:15dc:1ec9:3f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm47078885e9.37.2024.11.28.01.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:27:58 -0800 (PST)
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
Subject: [PATCH 3/9] sched/fair: Rename cfs_rq.idle_h_nr_running into h_nr_idle
Date: Thu, 28 Nov 2024 10:27:44 +0100
Message-ID: <20241128092750.2541735-4-vincent.guittot@linaro.org>
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

Use same naming convention as others starting with h_nr_* and rename
idle_h_nr_running into h_nr_idle.
The "running" is not correct anymore as it includes delayed dequeue tasks
as well.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/debug.c |  4 ++--
 kernel/sched/fair.c  | 52 ++++++++++++++++++++++----------------------
 kernel/sched/sched.h |  2 +-
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 6b8cd869a2f4..63ec08c8ccf1 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -849,8 +849,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
 			cfs_rq->idle_nr_running);
-	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
-			cfs_rq->idle_h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_idle",
+			cfs_rq->h_nr_idle);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
 #ifdef CONFIG_SMP
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6b7afb69d8ff..2cd2651305ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5938,7 +5938,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long running_delta, enqueued_delta, idle_task_delta, delayed_delta, dequeue = 1;
+	long running_delta, enqueued_delta, idle_delta, delayed_delta, dequeue = 1;
 	long rq_h_nr_enqueued = rq->cfs.h_nr_enqueued;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5971,7 +5971,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	running_delta = cfs_rq->h_nr_running;
 	enqueued_delta = cfs_rq->h_nr_enqueued;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
+	idle_delta = cfs_rq->h_nr_idle;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
@@ -5992,11 +5992,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		dequeue_entity(qcfs_rq, se, flags);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_enqueued;
+			idle_delta = cfs_rq->h_nr_enqueued;
 
 		qcfs_rq->h_nr_running -= running_delta;
 		qcfs_rq->h_nr_enqueued -= enqueued_delta;
-		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_idle -= idle_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 
 		if (qcfs_rq->load.weight) {
@@ -6016,11 +6016,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_enqueued;
+			idle_delta = cfs_rq->h_nr_enqueued;
 
 		qcfs_rq->h_nr_running -= running_delta;
 		qcfs_rq->h_nr_enqueued -= enqueued_delta;
-		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_idle -= idle_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
 
@@ -6047,7 +6047,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long running_delta, enqueued_delta, idle_task_delta, delayed_delta;
+	long running_delta, enqueued_delta, idle_delta, delayed_delta;
 	long rq_h_nr_enqueued = rq->cfs.h_nr_enqueued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6083,7 +6083,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	running_delta = cfs_rq->h_nr_running;
 	enqueued_delta = cfs_rq->h_nr_enqueued;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
+	idle_delta = cfs_rq->h_nr_idle;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
@@ -6098,11 +6098,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_enqueued;
+			idle_delta = cfs_rq->h_nr_enqueued;
 
 		qcfs_rq->h_nr_running += running_delta;
 		qcfs_rq->h_nr_enqueued += enqueued_delta;
-		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_idle += idle_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
@@ -6117,11 +6117,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_enqueued;
+			idle_delta = cfs_rq->h_nr_enqueued;
 
 		qcfs_rq->h_nr_running += running_delta;
 		qcfs_rq->h_nr_enqueued += enqueued_delta;
-		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		qcfs_rq->h_nr_idle += idle_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
@@ -6937,7 +6937,7 @@ static inline void check_update_overutilized_status(struct rq *rq) { }
 /* Runqueue only has SCHED_IDLE tasks enqueued */
 static int sched_idle_rq(struct rq *rq)
 {
-	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
+	return unlikely(rq->nr_running == rq->cfs.h_nr_idle &&
 			rq->nr_running);
 }
 
@@ -6989,7 +6989,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
-	int idle_h_nr_running = task_has_idle_policy(p);
+	int h_nr_idle = task_has_idle_policy(p);
 	int h_nr_delayed = 0;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_enqueued = rq->cfs.h_nr_enqueued;
@@ -7043,11 +7043,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (!h_nr_delayed)
 			cfs_rq->h_nr_running++;
 		cfs_rq->h_nr_enqueued++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_idle += h_nr_idle;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7069,11 +7069,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (!h_nr_delayed)
 			cfs_rq->h_nr_running++;
 		cfs_rq->h_nr_enqueued++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_idle += h_nr_idle;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7131,7 +7131,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
-	int idle_h_nr_running = 0;
+	int h_nr_idle = 0;
 	int h_nr_running = 0;
 	int h_nr_delayed = 0;
 	struct cfs_rq *cfs_rq;
@@ -7140,7 +7140,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	if (entity_is_task(se)) {
 		p = task_of(se);
 		h_nr_running = 1;
-		idle_h_nr_running = task_has_idle_policy(p);
+		h_nr_idle = task_has_idle_policy(p);
 		if (!task_sleep && !task_delayed)
 			h_nr_delayed = !!se->sched_delayed;
 	} else {
@@ -7161,11 +7161,11 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		if (!h_nr_delayed)
 			cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->h_nr_enqueued -= h_nr_running;
-		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_idle -= h_nr_idle;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = h_nr_running;
+			h_nr_idle = h_nr_running;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7202,11 +7202,11 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		if (!h_nr_delayed)
 			cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->h_nr_enqueued -= h_nr_running;
-		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_idle -= h_nr_idle;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = h_nr_running;
+			h_nr_idle = h_nr_running;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -13567,7 +13567,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 		}
 
 		idle_task_delta = grp_cfs_rq->h_nr_enqueued -
-				  grp_cfs_rq->idle_h_nr_running;
+				  grp_cfs_rq->h_nr_idle;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
 			idle_task_delta *= -1;
 
@@ -13577,7 +13577,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 			if (!se->on_rq)
 				break;
 
-			cfs_rq->idle_h_nr_running += idle_task_delta;
+			cfs_rq->h_nr_idle += idle_task_delta;
 
 			/* Already accounted at parent level and above. */
 			if (cfs_rq_is_idle(cfs_rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b5fe4a622822..8727bfb0e080 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -649,7 +649,7 @@ struct cfs_rq {
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_enqueued;
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
-	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
+	unsigned int		h_nr_idle; /* SCHED_IDLE */
 	unsigned int		h_nr_delayed;
 
 	s64			avg_vruntime;
-- 
2.43.0


