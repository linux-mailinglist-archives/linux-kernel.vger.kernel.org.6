Return-Path: <linux-kernel+bounces-285648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 448469510D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693001C225AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D5D1AE84D;
	Tue, 13 Aug 2024 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iavBV1XH"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5F1AE030
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593474; cv=none; b=jUQuhJ6PZ1k/nTFBLCgddducLXEoHRK0u9jfBpWMCmb2R5vvRbWMyolQS4LqCa6P4/cL/p3F6bM3BHfrDffkSuByVJMQZkPgw1TcJh1XflI7ndMBzUuizl8kzejG1KC1sxc5xubLkbpposUq6NJP7nmerGv77xjxFRNNSt9ANYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593474; c=relaxed/simple;
	bh=v1wXxV9ZA+NDtCThJ9NcLLcQESem98LeLzRfDLxECQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J+k+qL/Kf3hENrXBttFDGeUJtp1gMftdFgr3t5TOeDH0mF3ynvKTHqLba8v5PtLBhNnvyvuFFZouG5Ye6wm/pn1gVjxUXKMcLhHGLG+KDrBbsgaWnneVhTRW+YAHBxI0Wvc4K7IuDZTtSIjYEjRhziS6nlqqHKHwY8WronNIe9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iavBV1XH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a28217cfecso5474579a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723593472; x=1724198272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUZmHciByNs0lKefLuCTbO3bdK4dWgPt635eSO9BfM8=;
        b=iavBV1XH57QWij/zK21bClxmboB113mTVN3J0drbvSqZSpYKvZ1FHBfGC2q7MPktgb
         VZ4xCC8EmrPRvL73BkcrA5I2SLfSVn5JGFhfHxoZOefp960C2BqbqC2rM4cLvwM4dwma
         a1HUVTqsgRg+rBnRdm16WJ8kTB9lu6iHNUV60D4BHxJoY/YooIwwAjdvFFvdTSLQX61+
         lcE5rQZ7DalLx5PWekNF5rELnUP5RXjiFR0QsisQFSHXfN8s057d0vYV/P6A/PsPShdn
         OeG3Yl5/AI8toKBHYCBFrVXPAKvRwwjIcjAEYvw8l3AQVgZ0EJsFF5eJH4B4vkW2+2be
         og7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723593472; x=1724198272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUZmHciByNs0lKefLuCTbO3bdK4dWgPt635eSO9BfM8=;
        b=GsuS13GvRKZoNayR69aZfaqVB8Aui+numu6SFkriK6rRICNQMF9CVULMvAJ1lxcO75
         XeSoxWyotuujyH6eh4Ku05gDkF4X45Wq6bDEZus0kuO3vJontHxfbUlvzao78yo3YRVx
         0312W7bpoD4y+pSE5cKOm/6YOan45jqYNVhsxZ+PGmRHU5wzvWW+MTs5woqRQeCCLj1N
         AbUxKVIQNN2Jeb26qeZY7pVYeAw9CFU9WOTm65MHpAhb6NsHiqnNRmc3MniOIBz4ZtvV
         6mjPOTHwLY6X9td2KlKRGQ5lBDNRyAdp1xbczH99b0gn/BGZ2fh0yqm1zfmofiabjFM+
         L3/Q==
X-Gm-Message-State: AOJu0YxFs5G44w4RnXnTJwdjTj+TfJT0A4dFCZR6mhvX3drRlz5KjE8m
	eRD1lLiuxpXtcGFUTQnu51abl3TnhvpDL5Y/Yk4b5tjNb92VhlhUEVy+XA9VtLxVuCXza67cGZM
	FSmKbhJba5XdFecG6qsq+BdLc5X5L2fbROeDno6jynP9UDvCSXPJM88gWtELgB8bGvs+iADqEQm
	xFwUv7ny7Wo+PxPhW4pXXs36JElpPy/Crn5gr4MY6jWhUd
X-Google-Smtp-Source: AGHT+IEivARax7OmduQSeXk59tWfeTR3wKWE0qctFvaPNbUX3CJHvEE3SBZgk6ti6VCAXBtquQRyfUA8skGO
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:2584:0:b0:718:2a63:47a1 with SMTP id
 41be03b00d2f7-7c6a56c4173mr1475a12.3.1723593471014; Tue, 13 Aug 2024 16:57:51
 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:57:25 -0700
In-Reply-To: <20240813235736.1744280-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813235736.1744280-1-jstultz@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813235736.1744280-6-jstultz@google.com>
Subject: [PATCH v12 5/7] sched: Consolidate pick_*_task to task_is_pushable helper
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
index ac60d2819bd1d..d3050f6c2958d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2183,14 +2183,6 @@ static void task_fork_dl(struct task_struct *p)
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
@@ -2209,7 +2201,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 	if (next_node) {
 		p = __node_2_pdl(next_node);
 
-		if (pick_dl_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu))
 			return p;
 
 		next_node = rb_next(next_node);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 496d3e6ab57d2..9f07f09641f7a 100644
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
index d2cc31c2457e5..10ef612c078f9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3586,6 +3586,16 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
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
2.46.0.76.ge559c4bf1a-goog


