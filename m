Return-Path: <linux-kernel+bounces-307808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B9965327
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4933280198
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139C1BAEF1;
	Thu, 29 Aug 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRNCHLIt"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A21BD02C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971952; cv=none; b=dI1obx+QeeCaXO+V/GPhS4rQj7Jh2YP4uu4F2Nvxyjv1pgZ58p9H9SAM4KgGKPqBXKfGe8ipX1YXyploZWoF6njrAMPY1oLY9F0HVVVLuIb2xI/RlGTBAzGELsVoTV1GAZDSVDehD2SKmzahfhr4xwhQFfLxpInkO4ILKax/rzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971952; c=relaxed/simple;
	bh=CzaI7n2hJSmYgQCUfdGj1peQuOyAcYrCaXwY+whfeQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZwLabSEmoUFt8+hGTogkILcIg8uI5wZD52HbHE0ZIU+CccPwUm4kV5ogI+vPXVei7o8s618MahluEJN1EsRsnJw3wHjkcbRMV+Rp5/xQZn+dAvrrlTZOCRkAIzpPsuuLg+ohRLRmAcBxjiUxsLcxKNBF3Dfb5sxdN4DbUyQfycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRNCHLIt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b41e02c293so23871197b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724971950; x=1725576750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sadksEmx3LkfX90PRO1WBwAjQYEhZvpgSirDnXXTDC4=;
        b=dRNCHLItDaxCeTA5DQlCAeiICRN+RZUcgF8U6ud/1bXh7Gg5eS5MqsMgrEuOp2jU0W
         YUFWBr9LHZjv+t+m6Vop6wKT/EdXgypOl5rZLO7BuhI6/gESa6AvMCPrmI0Nn0e72FYI
         S/Yg66M0Eq4ilE6eDZFLAqudPNCxD74rkeQjVSwbCJtJgeOWo4ofc+aiHuIOTmOlo3Po
         NUE3q+OiexYkrsooaR7A+/1lXLj05wC3rd3IGcZN/O6xj6opdQC6aGAS/UaQc+RuBrv1
         VcjkRSmg2HcT5JhxpOhA7ttwBAauDJFXwAmDOC7MPcw7N3F3Sv+/xY8zhN+TZjImpnvO
         G2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724971950; x=1725576750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sadksEmx3LkfX90PRO1WBwAjQYEhZvpgSirDnXXTDC4=;
        b=CAOUMBUwnVRF+WsAQkLYlqy0svleInzT0iXnzFL0Hp0KtWPzX7zZ64/NSA0Sbnkq9X
         LHlxjVM/+lM059W1VqsF3/F3MJ/nqC8NwEBTAWKa7eSSoqbIVoQurQXuO0dyb8plVroG
         yxeY7Xs61z9RAyygSBo6xQMnrKsCUaO2w0qg0CDGBJ27B7zJl2qa7Gzxj7OWazYx8Xl9
         kvzEXCoQBhZQXYRYy7v49nEYhTnZqkkhex46InvxSKC7vsbfAHiXgXoPewOrg2y/yMxI
         UUdjxEtelw5MZhwHAKb5MIdDPBwwsCk+5YLdhht6lvWCensBnDv+Ur3nl5Kes35YOCgU
         S3aw==
X-Gm-Message-State: AOJu0YzBy6pceeF4jttQdMTVV+jH1a1JLs5WstBF4VGWwRyh+zleeqP0
	ovnggdDEkgSCFkRZwgEmcQySQhpHzXlDEDkX3pErqokkkazmC7D5IgivgcCiy90RyYOvnTmfneP
	0nZH22Cp+FY2wBe3JgWGisKqi1fNuKEphEfJFABYBIQDptOlOAaXGiuCjGh5WVIK20JYZ0t9iDo
	4e8y7SQJtx5aym6V8Pha2CfVrQk/9s173IZYVRrAhpzfbA
X-Google-Smtp-Source: AGHT+IEdmsm6x6l9xiiTg0rUqnJ/ou0d1Eo7D102GxIX/TxRyV+b3f2p6N4LdH295ISXY9gKg+DTSxj+Mxud
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:4a82:b0:68f:dfc2:98ee with SMTP
 id 00721157ae682-6d40f82a0demr1457b3.5.1724971949751; Thu, 29 Aug 2024
 15:52:29 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:52:06 -0700
In-Reply-To: <20240829225212.6042-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829225212.6042-1-jstultz@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240829225212.6042-7-jstultz@google.com>
Subject: [RESEND][PATCH v12 6/7] sched: Split out __schedule() deactivate task
 logic into a helper
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
2.46.0.469.g59c65b2a67-goog


