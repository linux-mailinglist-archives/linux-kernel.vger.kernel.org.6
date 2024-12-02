Return-Path: <linux-kernel+bounces-428116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB949E0A5B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC6A162B24
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089501DE3A6;
	Mon,  2 Dec 2024 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vres8kFY"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0811DDC3A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161584; cv=none; b=ol9U876DygiIIVD1ZMAOXjtF2hw3TKTgtvfP7ClzG9tvrHgDUfOCs48zUdoaDu9tKwLcF0cRoBk0e2wQ1dsqx4frqpHsa+E3IxQtjKa000ZU0wpfeeAIdlKufpXVqlMFFUqJn7yN10uJTPdlwPaJmrtJNSKRwS8RG+PQcP8da0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161584; c=relaxed/simple;
	bh=r76ZFxf6+szW9eepTQKANXmM15PvPmPw1HXWFoEr5bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMVxIVLZWFuFYLXPYlxo2YLDNChliLcRSQXeoTCH+TotMVJ8DTOfRNTAwsOyvuF/I8RRB+11Inr08U0jVmQVgi6rsaJCU+rwEgmaLIizktHP1GQytRVHI0joLayTuEsT5j2lKstTvPMjwxdcjIhgRY3+ljz7H5hxh0rAJMg7tKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vres8kFY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso42124475e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733161579; x=1733766379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4CmYt43pmWFjod+teL3Skl+Q8jt+0rCZaGH1lQgHrw=;
        b=vres8kFYC39ijn15CEV7jKioOuqrDfBNUOTDcZlB9VG5MWh4VhlFwFTGZn8o3nOZFr
         C6aG49mtoCbJJ9X9xSLAJ6r9kevMAeGG3wMKkk53F3Ig8YylEg3NMle+1PYWpEANP7jk
         a2fvAJhXO/NJ3/4vBezahKsHDU3vYXy3/r1jyIgLKwQTXVaSYoSNc6ZRCkDsODeTkAgD
         Doza42bTqSahVGWLHsoWfGt+yx2/KlQuN4I2OQBXZwWqSAVycXdntmUgj31be6rZrhh8
         HPf5Tay1U1zcUGsYp9LPtZke/aUV+z7g6ezfTmpJuLStBYQeCztjMufCfKhQJXWmT0oI
         arDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161579; x=1733766379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4CmYt43pmWFjod+teL3Skl+Q8jt+0rCZaGH1lQgHrw=;
        b=ldFz/bQj18vb8FYRLDtHTcR6Egjqui4w1FTMx/LcVTHM49rKBms/TuDOsgprNfBrvS
         9Vd2gdHvLn6C1JmTnLCnmSVSeqp1FvHAq2d55xBgwyZ9Kd3smdkIA9rooS6sSJWE628e
         mAeqVpGDGoMOwpxxOTLuJdqa0iJabMpSSRdqcP1B8JXhIvt5qVaov9a4X+gqZeEQAfQh
         eRnhwal5iH/QJjVaahH3XFL4W8Nzz+cv8nRn7JhVRmTW8Jd/zMfp18VHtdH/+GTuTM4P
         H09kQLmMhSzk8lJsBJu5LvUNB5yGZssdKknDuxj2hLDlrBC80UVwT5wjlL8ELh7w/yTy
         49YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl/trd9Zw/NFatJN/BiL6WFMrfeXfGybOZEQgpCGBPe5qlADdetKkdEjDsmDdVu9UE3YITZvyoY0izdWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLiirHCbgI2eETKPkG0tR/OUnM7RJO/HrtaH0W1nbN/DC9/Zkp
	tLFJ49qepZXJ+7ibkFchEtfGFXNA+LKebj8aMbUd7jbTuPGhTl3StQFOA7DHZ7s=
X-Gm-Gg: ASbGncsHdaU5RC1Jik6ByrcpzLBmHR1QL2RzhOBZWqg5qkt4VM+BA8v9QIDK0AqtM6R
	ozWepTVrA7db5ONQGcWeE8ULAdPXAxdyuEQHT4Bff6kJEbl0JqO4CC9y4RRFWcuB0KSCv7skww0
	ecwyJST9i9YEKRO82TcE8EDb9q3sRuarcqRdTnBPiiFQV/DxtWVLEeciWJIClAPjTCmXXFxnS5U
	hJmQzvrTSqzX2rxYbvv4PvZDTg1M0Um85hks7q5bd3qAtpyUEP5hNEHbgE=
X-Google-Smtp-Source: AGHT+IEZQs119pt6vxl/ltjNCpQHi5f8kOCbfJLZaQpN/MW0OaY1Xz4SYgTX1gju1ChOZekBvQHawQ==
X-Received: by 2002:a05:600c:3489:b0:434:a39b:5e44 with SMTP id 5b1f17b1804b1-434a9dcff98mr241827605e9.17.1733161579591;
        Mon, 02 Dec 2024 09:46:19 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:f271:ff3b:369e:33b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm193275855e9.29.2024.12.02.09.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:46:18 -0800 (PST)
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
Subject: [PATCH 05/11 v3] sched/fair: Use the new cfs_rq.h_nr_runnable
Date: Mon,  2 Dec 2024 18:46:00 +0100
Message-ID: <20241202174606.4074512-6-vincent.guittot@linaro.org>
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

Use the new h_nr_runnable that tracks only queued and runnable tasks in the
statistics that are used to balance the system:
- PELT runnable_avg
- deciding if a group is overloaded or has spare capacity
- numa stats
- reduced capacity management
- load balance
- nohz kick

It should be noticed that the rq->nr_running still counts the delayed
dequeued tasks as delayed dequeue is a fair feature that is meaningless
at core level.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 18 +++++++++---------
 kernel/sched/pelt.c  |  4 ++--
 kernel/sched/sched.h |  7 ++-----
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46cf1c72598c..e3c89aeda73f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2128,7 +2128,7 @@ static void update_numa_stats(struct task_numa_env *env,
 		ns->load += cpu_load(rq);
 		ns->runnable += cpu_runnable(rq);
 		ns->util += cpu_util_cfs(cpu);
-		ns->nr_running += rq->cfs.h_nr_queued;
+		ns->nr_running += rq->cfs.h_nr_runnable;
 		ns->compute_capacity += capacity_of(cpu);
 
 		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
@@ -5394,7 +5394,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
-	 *     h_nr_queued of its group cfs_rq.
+	 *     h_nr_runnable of its group cfs_rq.
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
@@ -5534,7 +5534,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
-	 *     h_nr_queued of its group cfs_rq.
+	 *     h_nr_runnable of its group cfs_rq.
 	 *   - Subtract its previous weight from cfs_rq->load.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
@@ -10335,7 +10335,7 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 	 * When there is more than 1 task, the group_overloaded case already
 	 * takes care of cpu with reduced capacity
 	 */
-	if (rq->cfs.h_nr_queued != 1)
+	if (rq->cfs.h_nr_runnable != 1)
 		return false;
 
 	return check_cpu_capacity(rq, sd);
@@ -10370,7 +10370,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->group_load += load;
 		sgs->group_util += cpu_util_cfs(i);
 		sgs->group_runnable += cpu_runnable(rq);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_queued;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_runnable;
 
 		nr_running = rq->nr_running;
 		sgs->sum_nr_running += nr_running;
@@ -10685,7 +10685,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 		sgs->group_util += cpu_util_without(i, p);
 		sgs->group_runnable += cpu_runnable_without(rq, p);
 		local = task_running_on_cpu(i, p);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_queued - local;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_runnable - local;
 
 		nr_running = rq->nr_running - local;
 		sgs->sum_nr_running += nr_running;
@@ -11467,7 +11467,7 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
 		if (rt > env->fbq_type)
 			continue;
 
-		nr_running = rq->cfs.h_nr_queued;
+		nr_running = rq->cfs.h_nr_runnable;
 		if (!nr_running)
 			continue;
 
@@ -11626,7 +11626,7 @@ static int need_active_balance(struct lb_env *env)
 	 * available on dst_cpu.
 	 */
 	if (env->idle &&
-	    (env->src_rq->cfs.h_nr_queued == 1)) {
+	    (env->src_rq->cfs.h_nr_runnable == 1)) {
 		if ((check_cpu_capacity(env->src_rq, sd)) &&
 		    (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
 			return 1;
@@ -12369,7 +12369,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * If there's a runnable CFS task and the current CPU has reduced
 		 * capacity, kick the ILB to see if there's a better CPU to run on:
 		 */
-		if (rq->cfs.h_nr_queued >= 1 && check_cpu_capacity(rq, sd)) {
+		if (rq->cfs.h_nr_runnable >= 1 && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 2bad0b508dfc..7a8534a2deff 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -275,7 +275,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  *
  *   group: [ see update_cfs_group() ]
  *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
- *     se_runnable() = grq->h_nr_queued
+ *     se_runnable() = grq->h_nr_runnable
  *
  *   runnable_sum = se_runnable() * runnable = grq->runnable_sum
  *   runnable_avg = runnable_sum
@@ -321,7 +321,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
-				cfs_rq->h_nr_queued - cfs_rq->h_nr_delayed,
+				cfs_rq->h_nr_runnable,
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 869d5d3521f2..4374c660f5c7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -900,11 +900,8 @@ struct dl_rq {
 
 static inline void se_update_runnable(struct sched_entity *se)
 {
-	if (!entity_is_task(se)) {
-		struct cfs_rq *cfs_rq = se->my_q;
-
-		se->runnable_weight = cfs_rq->h_nr_queued - cfs_rq->h_nr_delayed;
-	}
+	if (!entity_is_task(se))
+		se->runnable_weight = se->my_q->h_nr_runnable;
 }
 
 static inline long se_runnable(struct sched_entity *se)
-- 
2.43.0


