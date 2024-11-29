Return-Path: <linux-kernel+bounces-425761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73F19DEAC6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382BCB21E68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77F519F41B;
	Fri, 29 Nov 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPJfIGIZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35ED19CCEC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897090; cv=none; b=cCf2VP1QOkCAjmVUXSg4M0e+Fy+3Bik5NR1lTo6R1ZKDCnIKi+9UusPpDZxNyHquZkeht8RlAMKsmy3Sb3sejFy+Az6rPDQv2B8m3uX1IihzfnbikHMT/bkuKrghJME3/zdDRsXpyRGcb5pfv5JMCCLVrzY/kSQ1+p34hxmhsBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897090; c=relaxed/simple;
	bh=BQroqjA3tpW6ydk5eyvkfeQCSMdsCrBx2gtpZY1Z2ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctYKAwAbt5wKgjDTs/t4eoUpc1nahnb5v30XwdmMqXkDI5GFnGNsTxNz4OhhuOCu1m3DrGsuNUEpWujcctW3/L22kGy1pazBjkyS15vpwqT3xjxIKV2FETFGk2qRdj2KkGKJo1WId1Ei4cyqJ9FE4SoILZN8EO1I5k9qpFjrMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rPJfIGIZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso18431495e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732897087; x=1733501887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgbHKxsSuKlEzMqZT8dZSeNojQwBTMFn/yeQpPPHhPw=;
        b=rPJfIGIZqPte52o/OCf6zIEjeFrEPRQYtuqrqbMSaZKQwxqSjbG/eeyGhbjC+F1Z3v
         IICBK2S+AVfmk7l+m7M5EV/6n/DZtj3o8s9C2oXPDYUHWdUCRpCtoW/NLSBnLS727Edt
         905ca7e+jun2BEs/Q0GUF2biJreTUfYeQO9undTi9TfLxPwddhxZ0sqUzmSIopvi6QvL
         vTs8XsLcTOqPV1edFW7Kip9yBGNQSi1NvxOutxLYm9jMFLR0hNeB1SD41wWG3IgiK6nX
         GlNpZSntBjISsG6Abo/ZWJzbAq6IWVeDd3BAQ1sAs2FpwmIpXcm743B6LSLYBPi82eHS
         dI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897087; x=1733501887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgbHKxsSuKlEzMqZT8dZSeNojQwBTMFn/yeQpPPHhPw=;
        b=WIRrnMmyb2WgDI8fCTRD6BMWRecX/LsUQoGo7x5RhdJWhsCaqddZqnpNHSWbGOJNag
         a6zSZSIEoF9CAW8tSLhLb0A9stVucvv5oe2YRR+F3BlYCCVApogtsocgADXDAzsK9+GC
         72olprodcaC54oWXT2jpB4o2zoJlgbwYVnimU/KAjdaL1aDJOMAvBAsxKKRK5Ns1InJg
         XgdodrMmSG//n0IefQQ3vgHbji4P2nyZ6JVxmsq3i3vPHlLAwiQzbO+Tt30rmC6oSKqm
         QXAJaSHc8kIanx9IlH++3ddKFXeRmgSMig6Pcg53A4bQb5UpCYSZ97eoM5lA14SSU9V1
         l+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjgcmyyIdlpm+2je+YjSwEuC5+wHPqlcV9C6zWSvSXfAhEZrRej6QZ3WBmfgvDaKa7mkybDTkF3/f+t3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7n5lzMsz9pU/fDYGn9mb3h+k5uJSn0PguVpK9aB1+vJPYeQjL
	6DGpRoZnKW8Oks6BOYXAYgBKotJuSEWEbaXVo+sDP19I9yE5q4a8gGwIQALXqIM=
X-Gm-Gg: ASbGncu/3Jj1rY785VWLW3owgubzYh3GCWcSu56y+GX8I7ixDSX7ovZXI31dDt6GMcr
	v+7wrWxf1xd3qfLh96G1U8kdr83rc2cx26jxWAjDUwclC45gqJQKyV37sRe30JHdJ/7pt28eNav
	pSRwTWDcZlo5qBN95o5M45go7CJPK5kwjQzHgiQ7x0Nes9aaCFzK7aDCwAqQMcGLq67qK3HU3Wy
	UQ9oN/T+YDMS1uXRyRGMFzj1jDXdYA+bdHfcOyAwVw2cficTWHBNmOj2ec=
X-Google-Smtp-Source: AGHT+IEfsr5441I8R7aL13O7HLv1nVIFu3QDWMcm0ug1ajKBaQVVSBg8AYDKw943gznGxXFbYlowjA==
X-Received: by 2002:a5d:588f:0:b0:382:4aeb:91c7 with SMTP id ffacd0b85a97d-385c6eb6911mr11101247f8f.18.1732897087022;
        Fri, 29 Nov 2024 08:18:07 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c54b:5636:4db3:1028])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm56771665e9.15.2024.11.29.08.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:18:06 -0800 (PST)
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
Subject: [PATCH 05/10 v2] sched/fair: Rename cfs_rq.idle_h_nr_running into h_nr_idle
Date: Fri, 29 Nov 2024 17:17:51 +0100
Message-ID: <20241129161756.3081386-6-vincent.guittot@linaro.org>
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
index 56be3651605d..867e1102c368 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -848,8 +848,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
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
index c13163deb92c..13ee5ea13580 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5934,7 +5934,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_task_delta, dequeue = 1;
+	long queued_delta, runnable_delta, idle_delta, dequeue = 1;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5967,7 +5967,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	queued_delta = cfs_rq->h_nr_queued;
 	runnable_delta = cfs_rq->h_nr_runnable;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
+	idle_delta = cfs_rq->h_nr_idle;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		int flags;
@@ -5987,11 +5987,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -6010,11 +6010,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -6040,7 +6040,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_task_delta;
+	long queued_delta, runnable_delta, idle_delta;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6076,7 +6076,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	queued_delta = cfs_rq->h_nr_queued;
 	runnable_delta = cfs_rq->h_nr_runnable;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
+	idle_delta = cfs_rq->h_nr_idle;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -6090,11 +6090,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -6108,11 +6108,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -6927,7 +6927,7 @@ static inline void check_update_overutilized_status(struct rq *rq) { }
 /* Runqueue only has SCHED_IDLE tasks enqueued */
 static int sched_idle_rq(struct rq *rq)
 {
-	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
+	return unlikely(rq->nr_running == rq->cfs.h_nr_idle &&
 			rq->nr_running);
 }
 
@@ -6979,7 +6979,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
-	int idle_h_nr_running = task_has_idle_policy(p);
+	int h_nr_idle = task_has_idle_policy(p);
 	int h_nr_runnable = 0;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
@@ -7032,10 +7032,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_runnable += h_nr_runnable;
 		cfs_rq->h_nr_queued++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_idle += h_nr_idle;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7056,10 +7056,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		cfs_rq->h_nr_runnable += h_nr_runnable;
 		cfs_rq->h_nr_queued++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		cfs_rq->h_nr_idle += h_nr_idle;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7117,7 +7117,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
-	int idle_h_nr_running = 0;
+	int h_nr_idle = 0;
 	int h_nr_queued = 0;
 	int h_nr_runnable = 0;
 	struct cfs_rq *cfs_rq;
@@ -7126,7 +7126,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	if (entity_is_task(se)) {
 		p = task_of(se);
 		h_nr_queued = 1;
-		idle_h_nr_running = task_has_idle_policy(p);
+		h_nr_idle = task_has_idle_policy(p);
 		if (!task_sleep && !task_delayed)
 			h_nr_runnable = !se->sched_delayed;
 	} else {
@@ -7146,10 +7146,10 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		cfs_rq->h_nr_runnable -= h_nr_runnable;
 		cfs_rq->h_nr_queued -= h_nr_queued;
-		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		cfs_rq->h_nr_idle -= h_nr_idle;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = h_nr_queued;
+			h_nr_idle = h_nr_queued;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7185,10 +7185,10 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
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
index e098b852704a..8c57da1af378 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -649,7 +649,7 @@ struct cfs_rq {
 	unsigned int		h_nr_runnable;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_queued;
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
-	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
+	unsigned int		h_nr_idle; /* SCHED_IDLE */
 
 	s64			avg_vruntime;
 	u64			avg_load;
-- 
2.43.0


