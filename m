Return-Path: <linux-kernel+bounces-246638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B76992C496
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA4F1C219E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A00D189F39;
	Tue,  9 Jul 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6QjC69J"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2A18787A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557161; cv=none; b=sk8U1HU8Ll2YPKS/MIJ8NreAizH4hfP5WSmRiliTKfQk4vpr5+GC8pEpI5r1Tvnbx8WqVxndcqHUlXMZ8vmqcVlsKjzP+Ja8M5uqszmxMYAPLoDuRVR/u9FJPX/kzdoQxRrfaWwt//ncj0Mt/D7CWWRaIGbGWP/uyxBAW5swaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557161; c=relaxed/simple;
	bh=OdboL8GRjZ9HaNPDORv6f99DqVqCLARn8M9yns8iW10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NZotO+NYPBwnVLgEQLtpkL8cv1S0W2VUEwZzhdANWDsKeGt0p1gNA1D7TNXI2NAZv0YmyinvDCM9ClJ0o/SYcTrj66oWj5pQVwY/jUHdvIs0Fz2o0H58ZgU0BqUYQKOlnVglZ9X/SlyuzKc1DRmNk+Js1lbpvILrDRNuUxQvWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s6QjC69J; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c95f737113so5418308a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720557159; x=1721161959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+x+zlwEFkDOcEBJWqLmqHwwAqtu5VuIJvpoq5xrn34=;
        b=s6QjC69J/O1Mv7fjBxyGWCT6lKzY6Qew2CusBhxk5qVWrmZ/sy9pNEv1ZsUduCayDj
         7lMnBCsonuv4aZ1oHdYKcB5e7ubanVJSKT+jwa2iiCUmq/QDn9DClC2aYiU1UKqQia5W
         oy1DBi0AmDa/lrx76yJsUk8AfMlD7aZTgyi08g/j4jsAVybEVUWR53aEJeDBVtZXITkW
         KqrEMVd1Wyt0VC0kgAlBLwx08A9Ha3/DdPBy2Q4SSEPYVHsU1r8QEEMPC9QDrjJFzcUI
         UsOYH2ur8e0/Cz6WLe3awyprfDNwwhTpKZOaIvgcVTYD7pd/9/Hd2OWPKjM6HTwwRCET
         wygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557159; x=1721161959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+x+zlwEFkDOcEBJWqLmqHwwAqtu5VuIJvpoq5xrn34=;
        b=W7MAVy9sc7LdZkXNrvEPOYRJhMbuha4uZTCfa/5GrVsDOm0kfZiBi55qZLG7MGaEKK
         LmTClCLq4YZ46V6W+FvTDKL4ouBGJBaVTRyyF/UThGk6G9EceJNAH8aa7XF1/24CK0ng
         C4VNivIYt81CcQZoIy7akqUrqgya3iZswbDBOJq9eLH11TphmtPKmlp7Wg8iwwVUU+zb
         BjLqmU8Aa4x0/87PQfnhiQcZq1QYUXPbs+rPlEAcGr8Tzpf+v+nMS7lUULUtdRAq8sft
         GT84gMGMyd3XvjJcG7wM0dYGUDgNoPpW+59HyV+dbSkYFJJZaAm6VScOZhffyebcWKSm
         HaTQ==
X-Gm-Message-State: AOJu0YxLWu49OaRpWzNsdVzr73CAtQHh9rEdcVhOpRZkYCNSj3KxYFNi
	/5/Hup47DB4NfCQF3vNbzXSQbPRZa2fwIm/Q9oFWQ7wvo8GuCbiTi81+iuKhnzlLaf2mYuYMYwr
	qpg23NasU5Lx8rq27B6PuPEC1ZAnpxbzoMv/KWvKDBn5rELUOhjv5DXt5FK2NJk80u71pTncojD
	zYjz0jM3gLGhqb2tzC9yFWgOoIedUUvCFs4syPcyB5d4aH
X-Google-Smtp-Source: AGHT+IFFC0Vp1N3md7SxhD+JLWl5slCFlb5hK6ZHAGLfzOORUrqcGP4Bk8LB46ia8JbxDjJuWLDE4ifCoONQ
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90b:1917:b0:2c9:75c6:32d8 with SMTP id
 98e67ed59e1d1-2ca35be805dmr83893a91.1.1720557158836; Tue, 09 Jul 2024
 13:32:38 -0700 (PDT)
Date: Tue,  9 Jul 2024 13:31:49 -0700
In-Reply-To: <20240709203213.799070-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709203213.799070-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240709203213.799070-7-jstultz@google.com>
Subject: [PATCH v11 6/7] sched: Split out __schedule() deactivate task logic
 into a helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
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
Signed-off-by: John Stultz <jstultz@google.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
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
index 5e63dbcbc1f0..029e7ecf5ea9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6566,6 +6566,47 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
@@ -6659,35 +6700,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
2.45.2.993.g49e7a77208-goog


