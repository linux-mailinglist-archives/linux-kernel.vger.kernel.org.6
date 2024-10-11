Return-Path: <linux-kernel+bounces-361966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9D699AF62
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C859289706
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98891EABAB;
	Fri, 11 Oct 2024 23:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pb4BnJea"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE431D278A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689149; cv=none; b=k//0tvsSNK+uZFmgvHXcHLi61Y4zJ9ftZS4lMk275cpFS2pE6GufqZoMO06LXByGQePUTKdkuVbtUJKqBnv7+f2oEPHyEa7oPM2MMvUK+URMsXB6bxAuQnwRkjlwjmpnMBrwHhAyUbeLZm4rBpMATwe20+r5yS4IZxztOWJrktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689149; c=relaxed/simple;
	bh=vKVhXyUCQW3VrmxMgwIAKNIWXaRjutTkmiYmUdOL7y8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YA4uORysuDtxLLp2zWpafnPfXxhnRIfhJicG/DhpuKScwuFFUOCpRjDX4qinDR5PlW99Zw/rwUkZWL6kfYpSA7uCISd6nXJbsnrMMuY7LLuQAolkOW0Cxy0aihkjh8kHPF3w9eYy8fQ0i3PSRFECjqDVQLP6GX3q1PYHUTjDJrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pb4BnJea; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20c98aa6b4bso16147685ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728689147; x=1729293947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZKyKnHvG8nikVkXgW9xs5MrACmc1p4QGfsCdciCMo4=;
        b=Pb4BnJea98IaD5B0gKRVwf0d5wzJ4bPU8h5Ez95erQpL4AolgPM5zjF4B7sHBcrzDl
         0f+4jlpLXjCDX+YyEh9FGcIbsSJvgNfTvi04aZh/ykfS//W3eqLB776VTj9mbu0EBYUY
         xU5ex9BnfesmpMgUTvpLw3kCjJvjE/wrvWs3KooV2FpHP7CSkjZetyWik6G5VputEMD/
         CNjP0e0ZtxC/AYVF+J+EY0K1VPKPLWV9v7RNgh8VklOafWY72iG3WZDHNbjHZinW2tyk
         D4mPRX6hIqM/RMoEODxg2y2S4AhqHp0jz/95Rgs3+Ixnhuw7PaWArtdxMjvhWhYbptzF
         tG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728689147; x=1729293947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZKyKnHvG8nikVkXgW9xs5MrACmc1p4QGfsCdciCMo4=;
        b=t9BjToq5HSaOdcAVyAPWRavOMbISmtqdBDgz+Y/k0viJ6t9hY2RTw/pkslyWRbtZTp
         vFmrvNi4svEGEi29pd29YX+qzgHziGvC5WoOZ80+cA2sWkESF6ovEX8+3oe1y+zGAu36
         3BFDmP91vMMsz2Heuilue5N/mbzv26mtNUtM/JGR8ThISjfjazpUJcMyrfObFegios+3
         mzVyH+Copj3s0QXH3uBV+6TUcN7R3692hF6BauZ+kK8MHuH156eNhBrJuXpQNm9iApKX
         PAqeYmZBYJ2gO2tO6u7gtNDnFysa8WrbEMAMINB3RBzyHeBNtGvk84msF/NAXC1muXjd
         Euww==
X-Gm-Message-State: AOJu0Yw3bp+PSpahx5y9gMIlZctOMB+BCP/PhwIu7t7ed4o0TbT7KuVW
	bwzyoc2eKVNfN0WlT9IMoh/bMDsYOS2yQmW1qBEhDt+lh9cFLksfQXWtuQ2wrSlnAhN9Lp1Rff+
	sU10dj8+f/c1Bhgxegnjz6q3o02dCEpMshyYfcx/44hyH+c7cFjdBs1pvCAtqPTvGPv7V98m91o
	2JK3xnR4MydAX+hzBXVg2N8QTPH8DCF5FgmKyqAlvWQcBv
X-Google-Smtp-Source: AGHT+IFnuEvQlaT8Q+rAgHUYmvhhqBT1iMhn0UnSzE2/kqSQ0d+r4yswJ7gwmgr3nI8NpsGnXcI/Qyig4jzH
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:c94b:b0:20c:8b07:c66b with SMTP id
 d9443c01a7336-20ca17378efmr94865ad.11.1728689144888; Fri, 11 Oct 2024
 16:25:44 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:25:17 -0700
In-Reply-To: <20241011232525.2513424-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011232525.2513424-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011232525.2513424-6-jstultz@google.com>
Subject: [PATCH v13 5/7] sched: Consolidate pick_*_task to task_is_pushable helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Connor O'Brien" <connoro@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Metin Kaya <metin.kaya@arm.com>, Christian Loehle <christian.loehle@arm.com>, 
	John Stultz <jstultz@google.com>
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
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: split out from larger chain migration patch,
 renamed helper function]
Signed-off-by: John Stultz <jstultz@google.com>
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
 kernel/sched/sched.h    | 10 ++++++++++
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6c87d812efbe..56260a80a268 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2487,14 +2487,6 @@ static void task_fork_dl(struct task_struct *p)
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
@@ -2513,7 +2505,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 	if (next_node) {
 		p = __node_2_pdl(next_node);
 
-		if (pick_dl_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu))
 			return p;
 
 		next_node = rb_next(next_node);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e2506ab33c97..c5c22fc51824 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1773,15 +1773,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
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
@@ -1795,7 +1786,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 		return NULL;
 
 	plist_for_each_entry(p, head, pushable_tasks) {
-		if (pick_rt_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu))
 			return p;
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b904a5004eae..cb74a577c89d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3779,6 +3779,16 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
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
+
+	return false;
+}
 #endif
 
 #ifdef CONFIG_RT_MUTEXES
-- 
2.47.0.rc1.288.g06298d1525-goog


