Return-Path: <linux-kernel+bounces-428117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30579E0A5C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2900281B77
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF851DE3B3;
	Mon,  2 Dec 2024 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8hZ871S"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35481DE2A2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161584; cv=none; b=UiHsUvopWZAZB8h3sK3+bBLcqjj+TMjCav6RFIbk5Vc/+dasJSO0JbYCMo4GBbjz/uhH5CIVEfzp6sguZFFJthA9In8NR9BvHIf3UG72kXN3/rJh4eaLmDmvcZCZ/0zxyD/VzMTzoYTdjkpMJJAj4S3rok0hF6wWChwHooxxWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161584; c=relaxed/simple;
	bh=D4g5jqrbanGfWVMem76yHEW8lroqNq946rQxKR1Vbdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hICfnEA4zh1PeIFqx/oLUQThIUkDvbagcCbCeVDG2G6n6CgpO1V0iaCgMvkwtXULEDQkAevFf/iTIr31QBuoAKQw5ylETviWazVTH5iZYAokj6SVYkHycMv/jmC1kZiFwyBixzTxUNmmed1+0sb1dEpkaPQxSp7MCLt6F233CjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o8hZ871S; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso42113095e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733161581; x=1733766381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LENeNFXikaUf1Bv3eseCGzkfYoR7UWKdlBvAhWPdfaI=;
        b=o8hZ871S3zyb9jvBkZ/L7ADMo0JqV6opM+zVxf6JOVSwiJb8VsPEFBTUFfCzNxRTGd
         BYmMjHjgHWEaGFXOS8wzesseKd9IxIkk4pVOZSPJ2JZxZB1vBNyUUmrDT0wA25mZjyEO
         k0vfeTgdkyN0fyW4hJpwxF7QyGdF1VLVsYkVhSWaV2+IEhnwQgwX6WX4XVmZiiREVdqR
         olDpWdgk4PxWomGNwM7CGUO4vyBMaRqcJ2XR4mpi0lWqer+sU2Mdp3oWb5857Gh/qug4
         2quTmK1tc2ZhW+X3eWvNH2Qj6j5ciUsFrWgK4Jn8CplIM727JMdcils+jaLVPiFXxfn+
         g8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161581; x=1733766381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LENeNFXikaUf1Bv3eseCGzkfYoR7UWKdlBvAhWPdfaI=;
        b=X5UgW9s6qSaCTdku/RqILEhhwPKIrJyEZXMLeAk7ARuJhzo1dXPXX4qB7RdQgvizGy
         qzu5OFPJqR18+NTcjS0qfEbUVHkIpff3iPjFa6D6Qr1j/RltKKTpIaaH72rjqN8qXWjg
         u1/UwGhjs8J9vVXFF+Z/iLFHtEpB0zM13EZC+ly/Ip1JafNCmzI2tDqnra2MorppEIGm
         I9QoluWo36+LLxo5jfpNay/J+P2aLlkC9qH1GUmeY+1bEbn8oEo9jdb/UCjLy2uw0kNn
         6WSrZ83WfUegCzt154DJ7o48qAfE9zatIImtuLMLEMzWPys9MTcOJJ/P9uzcOuOzcfRC
         pmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWDXrWlgJdpAbOpuci2tqP9WgPGkFUeyjXO/5o8PGhsdbpzxxiAlyvK4atEb8tTA6V6FMwDSmxyPD07oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBrwWVkiweO0QxR023HCN3Y44JdhZrYuiKEwSS8fGSUSoefA2r
	LxpcHx0UeNbqzZwktP68w0pOt8yODfO57XxMZJ6qdSv6x7biuwrds5rslvgBCqo=
X-Gm-Gg: ASbGncuoMlt5DsnMQuPHIn3sg4v2h3ptyZ1dKwPCEFwtElK4V//jEPTqzP577VuNkzW
	X64k4Jdvm1hSEs8zYUusCnqY2snR1vuJCL0RsGVZYg/HGGqIu+7amt2+v6hf8imXgFsJ5h/ilGR
	L9+HZBNXyo4BHQRDeyDxo2akFkgGjEZikWSATg8CTjsDg1t8l4yz6wlisLFP9CXskQkg+vYdduL
	r+r+5BetQEZXQ5XbRvzyZRlSVoZhRbTKZcWajuifsLUB1Xmk+W6zTiqrq4=
X-Google-Smtp-Source: AGHT+IEUI/3GcBh5AacbAE5p7WHpoV5Q7nV5gU2MdCEkEfgyioELEpEiJMrxBr2x8NZvCNuOauGWIw==
X-Received: by 2002:a05:600c:354e:b0:434:a684:9b1 with SMTP id 5b1f17b1804b1-434a9dbbfc6mr224922805e9.4.1733161580918;
        Mon, 02 Dec 2024 09:46:20 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:f271:ff3b:369e:33b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm193275855e9.29.2024.12.02.09.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:46:20 -0800 (PST)
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
Subject: [PATCH 06/11 v3] sched/fair: Removed unsued cfs_rq.h_nr_delayed
Date: Mon,  2 Dec 2024 18:46:01 +0100
Message-ID: <20241202174606.4074512-7-vincent.guittot@linaro.org>
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

h_nr_delayed is not used anymore. We now have
- h_nr_runnable which tracks tasks ready to run
- h_nr_queued which tracks enqueued tasks either ready to run or delayed
  dequeue

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/debug.c |  1 -
 kernel/sched/fair.c  | 40 ++++++++++++----------------------------
 kernel/sched/sched.h |  1 -
 3 files changed, 12 insertions(+), 30 deletions(-)

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
index e3c89aeda73f..8afd1b548e76 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5470,7 +5470,6 @@ static void set_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		cfs_rq->h_nr_runnable--;
-		cfs_rq->h_nr_delayed++;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 	}
@@ -5483,7 +5482,6 @@ static void clear_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		cfs_rq->h_nr_runnable++;
-		cfs_rq->h_nr_delayed--;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 	}
@@ -5935,7 +5933,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_task_delta, delayed_delta, dequeue = 1;
+	long queued_delta, runnable_delta, idle_task_delta, dequeue = 1;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5969,7 +5967,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	queued_delta = cfs_rq->h_nr_queued;
 	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
-	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		int flags;
@@ -5994,7 +5991,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
-		qcfs_rq->h_nr_delayed -= delayed_delta;
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -6018,7 +6014,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
-		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6044,7 +6039,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_task_delta, delayed_delta;
+	long queued_delta, runnable_delta, idle_task_delta;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6081,7 +6076,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	queued_delta = cfs_rq->h_nr_queued;
 	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
-	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -6100,7 +6094,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
-		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6119,7 +6112,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
-		qcfs_rq->h_nr_delayed += delayed_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6982,7 +6974,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
-	int h_nr_delayed = 0;
+	int h_nr_runnable = 1;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	u64 slice = 0;
@@ -7009,8 +7001,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (p->in_iowait)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
-	if (task_new)
-		h_nr_delayed = !!se->sched_delayed;
+	if (task_new && se->sched_delayed)
+		h_nr_runnable = 0;
 
 	for_each_sched_entity(se) {
 		if (se->on_rq) {
@@ -7032,11 +7024,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
@@ -7058,11 +7048,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
@@ -7125,7 +7113,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	struct task_struct *p = NULL;
 	int idle_h_nr_running = 0;
 	int h_nr_queued = 0;
-	int h_nr_delayed = 0;
+	int h_nr_runnable = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
 
@@ -7133,8 +7121,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		p = task_of(se);
 		h_nr_queued = 1;
 		idle_h_nr_running = task_has_idle_policy(p);
-		if (!task_sleep && !task_delayed)
-			h_nr_delayed = !!se->sched_delayed;
+		if (task_sleep || task_delayed || !se->sched_delayed)
+			h_nr_runnable = 1;
 	} else {
 		cfs_rq = group_cfs_rq(se);
 		slice = cfs_rq_min_slice(cfs_rq);
@@ -7150,11 +7138,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
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
@@ -7191,11 +7177,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
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
index 4374c660f5c7..d3ce5e99b025 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -650,7 +650,6 @@ struct cfs_rq {
 	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
-	unsigned int		h_nr_delayed;
 
 	s64			avg_vruntime;
 	u64			avg_load;
-- 
2.43.0


