Return-Path: <linux-kernel+bounces-170661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0088BDA4E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFDF1F254DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3906BFA4;
	Tue,  7 May 2024 04:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eRw8vXNs"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748546A8DE
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057708; cv=none; b=QRWOT1cSTkh2ZIVDfTwpgcWZYpv+f2o58+kD3X4p5iF9ZlqeOacYN1rH81ahWvOgskH9BsgsmFv8QJrsyHcSZbs5pAeDZ7tb7ZLhXUWK2ENjwEGJcmHcpd+29Bc0PJjg1F1+rQgYt344VefO8TKsYzqQYdsJIA8GlfYfDVOG2s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057708; c=relaxed/simple;
	bh=QRM6rt9Y2CwgCYANXyI4MGSWhlWefGEY58W8j/wW5v0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l1wU6smykxzDm0V7gYJSf7jA2dytA/5NWae8Bh+o2M5KHobl7RVxj9b0zh+uOBlElQ2Zfe9NvIHZA/u1pgkEPyhxBITNIfkxMHl98AkH5ShK2tsQoksZ9Xy2BRk5qPDxBFbhf1fBAB54iF8r4m8GKx0lDiETzTU6ZZQyou1wLVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eRw8vXNs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-deb45f85880so4894417276.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 21:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715057705; x=1715662505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJRHvCMvLtcKdBlmKBDsb8/B612809tuo4BzdlxZuvg=;
        b=eRw8vXNseaAHh68cxxb9IBF7jzaieJYBvk/yUNamGQPTknGnQmIjx7vyPmui35s6ct
         bUS6T1NcHhyfZbsX47xYCjxS6rEUxfXa7F7WD49uQ5agGLegt0f6+4GRA3ohis4TJ3LW
         I+T8/BO3uwN/CNimpcsSbNeBo9gfjpGoayMBMRtai1tJHh7I1ZsrS4c+wBTZh8al+wgV
         ygB+31shcu7wGd0Vv5cL7xJ6ByYaX8djfHJVHPEI2BJoS1GfUIMJyW83PqIePVULNIsE
         np44Hpd9sS0QXssRaU1cKWiNknXpXQB+R0pZ6zIH+77PNdoG5EhJx98t3wev6Q7dSq+e
         M9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715057705; x=1715662505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJRHvCMvLtcKdBlmKBDsb8/B612809tuo4BzdlxZuvg=;
        b=B8xMn0WY+VPuwrpPfSMvVlDAtcJ+AbUf+uUzDt6U9AxFqFAA+jhVXRlsotYcrT0B1w
         +dCnP42+AgSt0tH+BS0hmaU1wX7gh4u1bgaYpDV4n5aAW6KBc7uU0L9F04DufeS2Q15W
         1jfe8XoT/saIuz7EjI3Q6IgSRADy+THWaXn98mFZgnWxVK0+yD8lVjrnPrKS84avGCRf
         5KLacIMul6R+k2kNFv/a0tmtj/hoaBmbL/XWWeh3WhYQl6dWEut09qEHUgIqQZsExhR9
         afxA1QvP29Fw31uCuMZFjtJNBTBfHRt5mTFB7CWllYo3VptIk6ZpnHxIWwhxw8GTqyXc
         AgGQ==
X-Gm-Message-State: AOJu0YwQT+o/59SAPYvPpiHDFvDGt440Ck7CFmBVeSWQi+qu1vTF5ql5
	2NW5zlfxNoPdvc7uBRxr6y1aLr7BRPbSHbIEa49RvhmMbRTJcMKkNZauCYl4JxIxI+3O9UelC3V
	TlQcNwVezsmnKKmg/nu2rH0+JTcA7k3zLU1i3686S9vML3lj4cE73puIvneYmDV0VLkAqtoTHyL
	R7kxnTMKedL9f3u76bivAXa4CeG1ltEDk9yoB8OUF7RLMc
X-Google-Smtp-Source: AGHT+IHeys1vXI0WLNCvokOkQNCtDBQAgNUlXYE91szlRUmsMyateB7LH42VV9Tu7E4Z1Lcj3O8T7+TREuVL
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:2f53:0:b0:de1:d49:7ff6 with SMTP id
 v80-20020a252f53000000b00de10d497ff6mr1469308ybv.7.1715057705297; Mon, 06 May
 2024 21:55:05 -0700 (PDT)
Date: Mon,  6 May 2024 21:54:34 -0700
In-Reply-To: <20240507045450.895430-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507045450.895430-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507045450.895430-6-jstultz@google.com>
Subject: [PATCH v10 5/7] sched: Consolidate pick_*_task to task_is_pushable helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Connor O'Brien" <connoro@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	Metin Kaya <metin.kaya@arm.com>, John Stultz <jstultz@google.com>
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
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: split out from larger chain migration patch,
 renamed helper function]
Signed-off-by: John Stultz <jstultz@google.com>
---
v7:
* Split from chain migration patch
* Renamed function
---
 kernel/sched/deadline.c | 10 +---------
 kernel/sched/rt.c       | 11 +----------
 kernel/sched/sched.h    | 10 ++++++++++
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index eaedc69c5e30..ae583a427539 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2179,14 +2179,6 @@ static void task_fork_dl(struct task_struct *p)
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
@@ -2205,7 +2197,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 	if (next_node) {
 		p = __node_2_pdl(next_node);
 
-		if (pick_dl_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu) == 1)
 			return p;
 
 		next_node = rb_next(next_node);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 975cb49a64dc..8b6fb77e095b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1791,15 +1791,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
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
@@ -1813,7 +1804,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 		return NULL;
 
 	plist_for_each_entry(p, head, pushable_tasks) {
-		if (pick_rt_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu) == 1)
 			return p;
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2d41ebe200c7..e46f69ba9ba2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3490,6 +3490,16 @@ void move_queued_task_locked(struct rq *rq, struct rq *dst_rq, struct task_struc
 	set_task_cpu(task, dst_rq->cpu);
 	activate_task(dst_rq, task, 0);
 }
+
+static inline
+int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
+{
+	if (!task_on_cpu(rq, p) &&
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
+		return 1;
+
+	return 0;
+}
 #endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


