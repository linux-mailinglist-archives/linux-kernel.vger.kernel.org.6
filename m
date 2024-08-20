Return-Path: <linux-kernel+bounces-294334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7CF958C56
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4D36B21176
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B971BD512;
	Tue, 20 Aug 2024 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="H0X/u4lk"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0361B8EA8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171810; cv=none; b=HJXEx2K/rqRwzUGyR1/oJ4M6NLSTbg+qa3pIPvtBnZNcGiGF9kWyGLDayYPJoehJCO5R5q23d+DYW4kNXV6bgBudye92iL/NCt65JqLQPr1YEfQdgUHMuJU/DEhlIzChP3enOmhHHrFmTir2JtdW1DMvFT3oWQEVws6tqWin+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171810; c=relaxed/simple;
	bh=GQPbKPJztlK6T882OcegVi96fmYLqoqnWFn1+Q/Iecs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IDm+ubxQqvDCyuGYs0b/SMGWYE4bELyW1el7bbfbLhHe+Iw8Khd/ScQle667VdmBghD+dtEVB36/TNT84FMjb4EvHui8UHBXhVPc+gRTPsUiUBLBhg1JcaCIRzw/Vac7q6CTHd4ENVtXgiMo/qARxmtakWMRG4NIXgiIAsJgZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=H0X/u4lk; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bed83489c3so4345967a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171806; x=1724776606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gs4Ks0Kkm98Csg47MQJPALx1GhqbRV6StE7nBUKSXR0=;
        b=H0X/u4lkYVxFQFnzat5w3riIAUl6WVHxxPByZomWAcSHNL+Ptim7h5zZhLrJV3CCx9
         amArqi5HN+roUdYPOTMBeL5bhMY7AIEJvdql9T4gYy/vL3HajjoFV1hh4wxInVuZQdOH
         VtM7oPIiEfB2R+DYHdaHwup+R0WFfFrtXODtyV1MbX/cbEARy5X2gXMLIP0Tzi1+zAzz
         BzkbYZFei4WSydr7Od7zo370kfNVvrIY+AiYwBv5Z6ZaLPVFFqtpt2P7PBOvOGM7G2oH
         CQ9e8wkYgph2Swc0WrTN7m0TLt+PP6waRY9AQQQcT2x+F26lpeB5aLQG7dezsNHHI36L
         KhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171806; x=1724776606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gs4Ks0Kkm98Csg47MQJPALx1GhqbRV6StE7nBUKSXR0=;
        b=EG93c5xBmCzRspzXOun6XRdFumxy0X3DopLWWaC2ndixnjLtsBc63F3LMtb+/4pRBX
         i6msTA+KWLl8qGPA1wrWq/ITrbdicdzivHMLUhuGWRyHE5CuQyVbTK/715BGJk9UJX5H
         JIVIa6mNd+PeTUzCFGhch5bNGGOoXziEJS2gkDfYuPIXYf/YLSEd81ofzUXwl3WdV4Yj
         iN/XssRJuVwPPyYmz1KLIqoNbSYbHAiNlX8zqbAtB3YcYKzME0283ffba3detDTLI5pY
         Ij07GQW4hTRqxRS4rMMxiRmhWkbafh4a0G/Vh85zDpKxtG88soy+et2sy+m/RzPn9yWM
         KYRg==
X-Forwarded-Encrypted: i=1; AJvYcCWtIFV0M9ZEwRlB1PSlqSAUWOEuHLev4JIBbu4fEVbHil6fYuBhhq8aRSCIZZ4hmXtlggCcvFKUwkzoE66g0OYRzUP7kyKV9bQJMZfV
X-Gm-Message-State: AOJu0YynRt+9qfW7t1uBgaOVtHOt3cjS6zAGvVvN7pdPkBX6gxfi8flC
	TblZ2pmEF3A2UqTeEBR8dnxJYcY3c2UdElG/eQyju5O9uogczuMayHIfUWarwMo=
X-Google-Smtp-Source: AGHT+IGwNTmVgxwt0g3+fIC/ibzEl8NcSRLlNxBxLL/CCcYzyggVVh9aXnQfRJ+/Pw7OoMUPFxuxmw==
X-Received: by 2002:a17:907:6d20:b0:a7d:2f42:db54 with SMTP id a640c23a62f3a-a8392a49851mr940380666b.65.1724171806188;
        Tue, 20 Aug 2024 09:36:46 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:45 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 09/16] sched/fair: util_est: Take into account periodic tasks
Date: Tue, 20 Aug 2024 17:35:05 +0100
Message-Id: <20240820163512.1096301-10-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new faster rampup is great for performance. But terrible for power.
We want the faster rampup to be only applied for tasks that are
transitioning from one periodic/steady state to another periodic/steady
state. But if they are stably periodic, then the faster rampup doesn't
make sense as util_avg describes their computational demand accurately
and we can rely on that to make accurate decision. And preserve the
power savings from being exact with the resources we give to this task
(ie: smaller DVFS headroom).

We detect periodic tasks based on util_avg across util_est_update()
calls. If it is rising, then the task is going through a transition.

We rely on util_avg being stable for periodic tasks with very little
variations around one stable point.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   |  2 ++
 kernel/sched/fair.c   | 17 ++++++++++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8db8f4085d84..2e8c5a9ffa76 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -829,6 +829,8 @@ struct task_struct {
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
 
+	unsigned long			util_avg_dequeued;
+
 	struct sched_statistics         stats;
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e2b4b87ec2b7..c91e6a62c7ab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4331,6 +4331,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.cfs_rq			= NULL;
 #endif
 
+	p->util_avg_dequeued		= 0;
+
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
 	memset(&p->stats, 0, sizeof(p->stats));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a6421e4032c0..0c10e2afb52d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4832,6 +4832,11 @@ static inline unsigned long task_util(struct task_struct *p)
 	return READ_ONCE(p->se.avg.util_avg);
 }
 
+static inline unsigned long task_util_dequeued(struct task_struct *p)
+{
+	return READ_ONCE(p->util_avg_dequeued);
+}
+
 static inline unsigned long task_runnable(struct task_struct *p)
 {
 	return READ_ONCE(p->se.avg.runnable_avg);
@@ -4899,9 +4904,12 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * quickly to settle down to our new util_avg.
 	 */
 	if (!task_sleep) {
-		ewma &= ~UTIL_AVG_UNCHANGED;
-		ewma = approximate_util_avg(ewma, p->se.delta_exec / 1000);
-		goto done;
+		if (task_util(p) > task_util_dequeued(p)) {
+			ewma &= ~UTIL_AVG_UNCHANGED;
+			ewma = approximate_util_avg(ewma, p->se.delta_exec / 1000);
+			goto done;
+		}
+		return;
 	}
 
 	/*
@@ -4914,6 +4922,9 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	/* Get utilization at dequeue */
 	dequeued = task_util(p);
 
+	if (!task_on_rq_migrating(p))
+		p->util_avg_dequeued = dequeued;
+
 	/*
 	 * Reset EWMA on utilization increases, the moving average is used only
 	 * to smooth utilization decreases.
-- 
2.34.1


