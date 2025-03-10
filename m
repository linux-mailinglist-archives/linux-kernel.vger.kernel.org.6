Return-Path: <linux-kernel+bounces-554755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80644A59BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DCF188A888
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81E02356D7;
	Mon, 10 Mar 2025 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dxIVChwA"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7723371B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626309; cv=none; b=Dq8RuoCI9Ih7dprT/Zm/cOeCxbzOriTYbJKH5RtpzK/pS6xHYZu+4uqSni1U0/MB631VZLNGdW/d5FsMAv2FElp1HwqdJSIlvE6A2ZDYGBMdH0ccE4UIk0fbhQVZJCBbGyHe4gXuQryf30CtZs7hi9ga+ZHy3S4xbsbLIju0w1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626309; c=relaxed/simple;
	bh=pi9xguxgmi8jgveuQ3APRb4E+MjxkvqvRH3D05xwEJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ps16mUJ26X9C9YlogBRjuo2AfoRSY9qjWOVF2xCni1xliigjYdJ3JKXT+wPPuw93x3VVGj4jyk8DKJn3LY6BqIEJOplAY5K6L6rz3AGSNcfpQPKTo3zlW8n59HytpsKCHiQNk3llpjXDPE5bzkQSJMFuSotWgYoh1ioOkAjTlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dxIVChwA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913d45a148so1527640f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626305; x=1742231105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsKAVR4VpZ3o1CX3CIQeDuMn525H6M2KaGLkBcm6fQw=;
        b=dxIVChwA/2syr/8ilj++nasP4V4aXzh7NCrLJRcYok8/CUZmTaE+SrbnsgoWNdGfXP
         dH/xyOk2NcvgJMSeER6zW83wcl+azl9p7xM1kETbuhdolAZswcGfZEoO9H79APZTa+wW
         hH2wkkXFtWcElW8x/xWp3Yl3nWEG/zq6/FdJ8JRkS+0mfjBT7AwMLNmrPtez29MUSsy+
         lk89I1UeY6ybX5tecnMKYR4A7q4cfjxmOw3CJARjRckmZIECx98d9QZevds3Yy7zjcUd
         JOEnFK566Q135/ub9q8lsmZmrz+dF3noOPm2kTQ8tspC4V/e7pFBUNlhGHQlF7o31enm
         GQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626305; x=1742231105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsKAVR4VpZ3o1CX3CIQeDuMn525H6M2KaGLkBcm6fQw=;
        b=K3wxwUoT0SMbqlT+TvlZvf5UD2w+ablVb1EVwsMHhHPqCu7V16wPGIsLSNTQqgQJ6o
         BxMcb7pmvFFOQVsYmMZQRdaKmBjMd0E0iDSfXb2WKq8FbA4kVoQaFH3tx+5s/p6X4b+O
         wrUTfdQHlmHEgDJXb/6rXyIbNgfG1l6EMhAv+ODkmmIjl3to9c9+5SEI7lGFLB/7ZNaY
         9sWqTAxrSqL9XFDsa1jSB1V5EW0kOseRwzswCC1DAUIxyPX4Z8XZhH7HMo7MAWc45Uoj
         hi4hyQTXDYe5MA/y6cLD5PZWbXDrHJNKpKa7f31QAiD4VQbEsUNPGrrvHnyvSV0X2PAe
         wBXw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ar0EMtM7XM6e2NRP54YO3T7ZJJGwy2UPhK1FMcQWnu0sN0g8hiaqRWfl59WJI94moA2+lfuct0ymnME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpESLDwUyrTc9vfCWNt4+uRC19ZI8lG882QhTiLK5IdMz9QIUR
	j+sU3rHvh3hmoldb9h/1So7uD2i/ZOWn+LfsAkyIfmuoW2WSq2V8hPUMezcSkWg=
X-Gm-Gg: ASbGncuyyz8gKRNY4OGBAmkNyZZW88vF24X72d7ORfLaxNK1hQEVdVcX5B3Bewjg0N2
	4M6vqxjIoC2cDPBQ2av4GTkTrbtDmNE2M0rySoky7Fp5EUFAaJb+Nx1vxp8Q4s6ZVcAoHhN5nSH
	Vu6Bfmk3ndLAuRDBu9nX3ThN/GYCT7iV+1pf/Dk2WCLmXbz4dHo9AuQhwJbvyl8GVCi3OP5PLhF
	EobF2LAHzqFW/nl0rUUkjTCL6Q7gFV4mw8x7C/qe4Ld5Tc0F9DLsrbAPEGYgI/hOD2zhCwxlMX2
	Ewa/SLDtdJFBAv2XsnVS6F87rz0TI4pQF8H1xumEpeISkCI=
X-Google-Smtp-Source: AGHT+IEjcwJt33XK0+9oNBWYafwW/xgXhi9ZySNjt6XnxyxR7xOz/zzPFrVCVP5U0+zTQKRhB11BqQ==
X-Received: by 2002:a5d:47c1:0:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-39132d2ac45mr8673374f8f.1.1741626305012;
        Mon, 10 Mar 2025 10:05:05 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:05:04 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2 08/10] sched: Add RT_GROUP WARN checks for non-root task_groups
Date: Mon, 10 Mar 2025 18:04:40 +0100
Message-ID: <20250310170442.504716-9-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170442.504716-1-mkoutny@suse.com>
References: <20250310170442.504716-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With CONFIG_RT_GROUP_SCHED but runtime disabling of RT_GROUPs we expect
the existence of the root task_group only and all rt_sched_entity'ies
should be queued on root's rt_rq.

If we get a non-root RT_GROUP something went wrong.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/rt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1633b49b2ce26..d0acfc112d68e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -178,11 +178,14 @@ static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 
 static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
 {
+	/* Cannot fold with non-CONFIG_RT_GROUP_SCHED version, layout */
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
 	return rt_rq->rq;
 }
 
 static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 {
+	WARN_ON(!rt_group_sched_enabled() && rt_se->rt_rq->tg != &root_task_group);
 	return rt_se->rt_rq;
 }
 
@@ -190,6 +193,7 @@ static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
 {
 	struct rt_rq *rt_rq = rt_se->rt_rq;
 
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
 	return rt_rq->rq;
 }
 
@@ -506,8 +510,10 @@ typedef struct task_group *rt_rq_iter_t;
 
 static inline struct task_group *next_task_group(struct task_group *tg)
 {
-	if (!rt_group_sched_enabled())
+	if (!rt_group_sched_enabled()) {
+		WARN_ON(tg != &root_task_group);
 		return NULL;
+	}
 
 	do {
 		tg = list_entry_rcu(tg->list.next,
@@ -2609,8 +2615,9 @@ static int task_is_throttled_rt(struct task_struct *p, int cpu)
 {
 	struct rt_rq *rt_rq;
 
-#ifdef CONFIG_RT_GROUP_SCHED
+#ifdef CONFIG_RT_GROUP_SCHED // XXX maybe add task_rt_rq(), see also sched_rt_period_rt_rq
 	rt_rq = task_group(p)->rt_rq[cpu];
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
 #else
 	rt_rq = &cpu_rq(cpu)->rt;
 #endif
@@ -2720,6 +2727,9 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 	    tg->rt_bandwidth.rt_runtime && tg_has_rt_tasks(tg))
 		return -EBUSY;
 
+	if (WARN_ON(!rt_group_sched_enabled() && tg != &root_task_group))
+		return -EBUSY;
+
 	total = to_ratio(period, runtime);
 
 	/*
-- 
2.48.1


