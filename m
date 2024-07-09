Return-Path: <linux-kernel+bounces-246637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B3792C495
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE841F22DEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4811E18787E;
	Tue,  9 Jul 2024 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H04tlgh8"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE718785B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557159; cv=none; b=soDFIXegG2WdQej12ms0ONm6oj39cPP1IjAbzQiL7qq6q1ILZZHXrdr5XtYigHwAbBK0QtBw444bqF45SX7gkU5uSq1VaIep23mk/bQj6nLk3YnwAx5XTbYf7wYwHXPdM7GOPvzzDLVApQC4SC4ACnn1oz23FkEceBvOvDYa7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557159; c=relaxed/simple;
	bh=V1PF08pJ+tLWUnbiVFTp/QGQhy5yYg7gQLXFb/OQcQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uLeR5nDPS21p/QsBpwwrydhFBN4x+hsKfTACqoP71LLV8H9Qig6f62mAkZNLsJAYv4898Bq4jmDHaDxHLWL5plw77YDFRd58oaE8npKYdSEz3V1WOWgWZlL6yT1yzIaWhmv7zsIIJFxkb9KenJFNui9IttQeGBBaQR1ESy0dqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H04tlgh8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fb2ee83169so42772435ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720557157; x=1721161957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6xxvV2bWwwSWDlU+VJFmJ+e4u0BCl9LU2uMRtJJq7g=;
        b=H04tlgh8975QOJTdnCyA0433UcmoNXsf+8jlnpoW9oOmY0K8bU88MtdxPYwQ7LJ86I
         ///aCSorh93PC5EiDW890bECBIepHIngGk6mU3zygbeMrM6dsjEhBCxtena6msKIAnj0
         lMf30+qT49MyqTEJBvmxMF16dxJXNIHF0AUk3Ne6uEJNTLiohGneiHs27tGCI8R/acje
         QAtItwSNKo7v+vuSuTTHwmD1Co6lQh9zfInZGBEKJ/36BIaYqqltNlGZr6ljZub2eAVp
         vDsfojcHffXRaWZV3qiv4mZUJhOPBShSEbgVw/TpluhV0Lc1tfx6IjTnnGEDbHmAPEuF
         XfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557157; x=1721161957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6xxvV2bWwwSWDlU+VJFmJ+e4u0BCl9LU2uMRtJJq7g=;
        b=wUMhUf0L2ID9G1ZfoeYpjVJwZROb8brfhJeshsU/okGexQPns6GmEa7D3vB2+3/hKD
         kVyRrospeIOARMa2cACGHHnwRUp95GHFxHoNFVDlP8I/q7g86jyJJvMjCy1PQyo2f1hr
         A+lu6FH8OJC4yVK4rvT7RndUMfnX02bo4GP0B1hLHuWvBvI2bJhBcB9Slx1BCFf4TK70
         1TLmFwyBAocoBWxFlqrU6FQ1RfrP0j47DgHBHkrhxDarxLQ/y1uDbm5Hg9FFLaqccv4p
         FccgwDufKkNynzyuls1w2PfKI9WlRPkNhHCJcJO9o7C+4iv6cbMiSkd0c5LVUKeBVCrU
         e8SQ==
X-Gm-Message-State: AOJu0YwdYWDdt8yrOKdGIvE3IJbwjP8itMX03Oro9WEj+wTLO2eknxHM
	tbqdpECSGUKN5El5dKnjlU1GfbSKWJbDfT4T3MZFCdLOj6QAl21pjr6vwlyd3guVaGvY8jM1w6C
	STOrgMAT5CYpvdAuERNNg5VkRoD55g/S72Ps6TMB4h73iENgVoDnmyEtASQ1CHJmHQbcgdoYtH4
	OOiDf4SiZ6aVgSJm7it+S2N+o5QXTY/E8BgP40IfENW3rc
X-Google-Smtp-Source: AGHT+IFl1bSmqEi3C8wdAPOssZy1aEGWMhMjHM4X/fIsGQ249Cc0QIbjiNLJqMXt9/yCo0Du1jYzfmP+7xoc
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:ecc7:b0:1fa:acf0:72d6 with SMTP id
 d9443c01a7336-1fbb6cd2646mr161955ad.3.1720557156775; Tue, 09 Jul 2024
 13:32:36 -0700 (PDT)
Date: Tue,  9 Jul 2024 13:31:48 -0700
In-Reply-To: <20240709203213.799070-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709203213.799070-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240709203213.799070-6-jstultz@google.com>
Subject: [PATCH v11 5/7] sched: Consolidate pick_*_task to task_is_pushable helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Connor O'Brien" <connoro@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	John Stultz <jstultz@google.com>, Metin Kaya <metin.kaya@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Connor O'Brien <connoro@google.com>

This patch consolidates rt and deadline pick_*_task functions to
a task_is_pushable() helper

This patch was broken out from a larger chain migration
patch originally by Connor O'Brien.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel-team@android.com
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: split out from larger chain migration patch,
 renamed helper function]
Signed-off-by: John Stultz <jstultz@google.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
v7:
* Split from chain migration patch
* Renamed function
v11:
* Switched to bool (though later in the series it goes
  to a tri-state return) for now to simplify review.
  Will add tri-state handling later in the series when
  its needed. Suggested by Metin and others.
---
 kernel/sched/deadline.c | 10 +---------
 kernel/sched/rt.c       | 11 +----------
 kernel/sched/sched.h    |  9 +++++++++
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3e05e239f5f6..ef135776e068 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2178,14 +2178,6 @@ static void task_fork_dl(struct task_struct *p)
 /* Only try algorithms three times */
 #define DL_MAX_TRIES 3
 
-static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
-{
-	if (!task_on_cpu(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_mask))
-		return 1;
-	return 0;
-}
-
 /*
  * Return the earliest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise:
@@ -2204,7 +2196,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 	if (next_node) {
 		p = __node_2_pdl(next_node);
 
-		if (pick_dl_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu))
 			return p;
 
 		next_node = rb_next(next_node);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 55bb33f367ad..56363e18949a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1790,15 +1790,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 /* Only try algorithms three times */
 #define RT_MAX_TRIES 3
 
-static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
-{
-	if (!task_on_cpu(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_mask))
-		return 1;
-
-	return 0;
-}
-
 /*
  * Return the highest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise
@@ -1812,7 +1803,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 		return NULL;
 
 	plist_for_each_entry(p, head, pushable_tasks) {
-		if (pick_rt_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu))
 			return p;
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a24286059a6a..493de4cc320a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3490,6 +3490,15 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
 	set_task_cpu(task, dst_rq->cpu);
 	activate_task(dst_rq, task, 0);
 }
+
+static inline
+bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
+{
+	if (!task_on_cpu(rq, p) &&
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
+		return true;
+	return false;
+}
 #endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.45.2.993.g49e7a77208-goog


