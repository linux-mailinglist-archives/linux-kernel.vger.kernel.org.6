Return-Path: <linux-kernel+bounces-285649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EB49510D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0921C226E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074E31AE876;
	Tue, 13 Aug 2024 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBOa5rqp"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C021AD409
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593477; cv=none; b=RINZAtPIRHnxZXBDBVoVbWJCzXP1dIUUYxn6XF684SQzBldW+lM/0HRr4MCWGyu9BrK5EiAgGBW33nzUk9FhVA1nZOlRXFUymoLsSN2CTKgGbrMAVdA/NLDiz1UoLpBU3HF0aoyAc6yllWvOrZq3JcIM9uJz9J6IgJk6sgqquaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593477; c=relaxed/simple;
	bh=J4Kgef7EArt+Y5CaByvcOsXzI9ZY8Zshs63tGVhYw14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LeaiE96NAcrDtyC9b8zTvyw2Xt5WWxofY8L7weQ/rTAnF+735GoiSYERsaf0EpF4EevqAh+cZrPOgYlCBmCZKTygEtTf+OLTqK6FitwUGZsX7JcTHuJTcYmxaatYFMVuPCa+olm/l82JW6/rCFcRYTkvFsLpslwT/o8vtrGhP1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBOa5rqp; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fc52d3c76eso64599945ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723593474; x=1724198274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8jCnhYPm2DKglkrXvf4u96saYMORmO4EQNpMl//RxQ=;
        b=CBOa5rqp64Ng7iuODkdpMft13ExWgPfqPaQcM1E3zEkyKfyIiLBTgwuHxeob4P8DiM
         wnXsAzLQeTx1iB+SVJY9EtWw/zm56YB0yvcWHba1qE9fWhDVnioYBy5uRVAt4oiE5Vau
         7dk0HXLnxcRP9HWQbGbbIlgb4M/FS/jDzvQS9wxFtM5GeTzyYF9ew7rsdmqDScgelCkX
         /+YSWU6DT7hTuh6pSQ8JKgMBS9quPN9dMiwjo4Z2lVGXiC2V/62JxlQ5EApMfEhxpEx5
         2wf1/6G9LVgIc6hpSyaWyUQT19krk5u0yCBOjzMTqE3ZQXqbOWbuBMH3X6vGcX34xWSR
         zNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723593474; x=1724198274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8jCnhYPm2DKglkrXvf4u96saYMORmO4EQNpMl//RxQ=;
        b=Adtmqq1u0rg21rj0vEU5cMsGgXPJsklTvlALvNEkJ4eM8K7LGpnHIMiiC5ILThL3zO
         h9nqNjRvV6Wa2t6idDm7gFAH127SVC7qO3GwkfHjv6MrzqaMXhwimjE+GYD71dIoRIwR
         kZ18qdOffnyxRJ0n8u0UiKd63BQ8RHRNwxdUdp+4DqdzCssUrYFswk/rjjRUvyhbzDkB
         bMRXml5AD1ZJ0jixgeyY9xZAmNhtqGqUjMyyz3elzB1YQRwi8tE3ytibF6FcBxClQOXE
         1P5tObrmIspoGv0yUOGoTzWRECnmJGmW9PKe2B/W5ucXpNTnUQNKiq4d5I9aglJ0NSaU
         IIJg==
X-Gm-Message-State: AOJu0YxdIt9cXbWSdWn6rvztlcI4uzDzGRUaydFxRgtvpZ9P+kyTFDPH
	gpR6kKOjFx/4UO1VVhZm5fEXqRTiIKWC8XvT7OQ/wuvsKl4ZhyuKy3Z9CiOdjW4mHEc+kRZeYFe
	oaxoCH0BQTWYL1ODZxEIpV7uo2r+WCcIgLBB8Uf8hGo8ZvtADeGmBEkDDfgpvIhwrRI5hwdkEQW
	BaEY4FP30q0s5ZBuc9VEpWMCMBO1nzqQfTG0ij53WugDF2
X-Google-Smtp-Source: AGHT+IFpli/7NAJG5uLrYxwYw5vRJ4lyktmzG/hm/XGwp2LNNhvckj2JUM0gTreRhfpy4ukRgiqmwVvA6dwn
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:903:22cd:b0:1fd:6433:b37b with SMTP id
 d9443c01a7336-201d63b2043mr647725ad.4.1723593473238; Tue, 13 Aug 2024
 16:57:53 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:57:26 -0700
In-Reply-To: <20240813235736.1744280-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813235736.1744280-1-jstultz@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813235736.1744280-7-jstultz@google.com>
Subject: [PATCH v12 6/7] sched: Split out __schedule() deactivate task logic
 into a helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Metin Kaya <metin.kaya@arm.com>
Content-Type: text/plain; charset="UTF-8"

As we're going to re-use the deactivation logic,
split it into a helper.

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
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: John Stultz <jstultz@google.com>
---
v6:
* Define function as static to avoid "no previous prototype"
  warnings as Reported-by: kernel test robot <lkp@intel.com>
v7:
* Rename state task_state to be more clear, as suggested by
  Metin Kaya
v11:
* Return early to simplify indentation, and drop unused bool
  return (will be introduced later when its needed) as sugggested
  by Qais.
---
 kernel/sched/core.c | 71 +++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b2cc20ed14de6..2cc84f1549b7b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6349,6 +6349,47 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 # define SM_MASK_PREEMPT	SM_PREEMPT
 #endif
 
+/*
+ * Helper function for __schedule()
+ *
+ * If a task does not have signals pending, deactivate it
+ * Otherwise marks the task's __state as RUNNING
+ */
+static void try_to_deactivate_task(struct rq *rq, struct task_struct *p,
+				   unsigned long task_state)
+{
+	if (signal_pending_state(task_state, p)) {
+		WRITE_ONCE(p->__state, TASK_RUNNING);
+		return;
+	}
+
+	p->sched_contributes_to_load =
+		(task_state & TASK_UNINTERRUPTIBLE) &&
+		!(task_state & TASK_NOLOAD) &&
+		!(task_state & TASK_FROZEN);
+
+	if (p->sched_contributes_to_load)
+		rq->nr_uninterruptible++;
+
+	/*
+	 * __schedule()			ttwu()
+	 *   prev_state = prev->state;    if (p->on_rq && ...)
+	 *   if (prev_state)		    goto out;
+	 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
+	 *				  p->state = TASK_WAKING
+	 *
+	 * Where __schedule() and ttwu() have matching control dependencies.
+	 *
+	 * After this, schedule() must not care about p->state any more.
+	 */
+	deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
+
+	if (p->in_iowait) {
+		atomic_inc(&rq->nr_iowait);
+		delayacct_blkio_start();
+	}
+}
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6442,35 +6483,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	 */
 	prev_state = READ_ONCE(prev->__state);
 	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
-		if (signal_pending_state(prev_state, prev)) {
-			WRITE_ONCE(prev->__state, TASK_RUNNING);
-		} else {
-			prev->sched_contributes_to_load =
-				(prev_state & TASK_UNINTERRUPTIBLE) &&
-				!(prev_state & TASK_NOLOAD) &&
-				!(prev_state & TASK_FROZEN);
-
-			if (prev->sched_contributes_to_load)
-				rq->nr_uninterruptible++;
-
-			/*
-			 * __schedule()			ttwu()
-			 *   prev_state = prev->state;    if (p->on_rq && ...)
-			 *   if (prev_state)		    goto out;
-			 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
-			 *				  p->state = TASK_WAKING
-			 *
-			 * Where __schedule() and ttwu() have matching control dependencies.
-			 *
-			 * After this, schedule() must not care about p->state any more.
-			 */
-			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
-
-			if (prev->in_iowait) {
-				atomic_inc(&rq->nr_iowait);
-				delayacct_blkio_start();
-			}
-		}
+		try_to_deactivate_task(rq, prev, prev_state);
 		switch_count = &prev->nvcsw;
 	}
 
-- 
2.46.0.76.ge559c4bf1a-goog


