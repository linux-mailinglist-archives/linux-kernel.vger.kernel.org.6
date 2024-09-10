Return-Path: <linux-kernel+bounces-323936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2853974574
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61801C257C3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119101AE039;
	Tue, 10 Sep 2024 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xez6njsp"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8511AC8BD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006392; cv=none; b=RxduqyTpUgwN8BlvmOQPlNAe/ZTV1J19U62A+Thf5ivsCtL8sVh24vLUAtp8zGP8vlaxhhp5W4g3XGbK569WGmF8bJw4vKobTaj2gqizH6V5GZmbVbtddISzFNj2xnR1fXJX0jMnanGTVsKpWUqFeo+yunDlkordlRlfMnMSRc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006392; c=relaxed/simple;
	bh=U9kExhQNmoqbUcABt0zApvKBDIP2+P0+yLvNARBa/8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O3RIYNySAuMK98eE+Qz0IwqjesXEpqITj3gouZLg1ygY+NpYfRfACfgAbVJMiq1PhkwQazr7KBZVaZg3ypDF1H5t3kV/hoBM6Mb3POAt0uaqkRSS9m9tQnjLurtCvIEK7t/rAq9KtUT7rUebNh6mPp4iEDdCOztnSRzIpYdBLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xez6njsp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1a74f824f9so2714764276.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726006390; x=1726611190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TgWPkJOgDCTgQuyFh0W8ok44kERRCzXuvotXrcKd8BI=;
        b=Xez6njspBPd0w6pSE/PFeyzn9O5FXx/DCH67ysypgWzL8d3r7abeeugTzeL8kO52je
         DaHzQxiUmmVGD9SK+5yy/dSWD/+0B33ozyekfS5VXmllZOhf5iyXou7lxR87e8It/1nr
         Isermu1t2FgaBZi+mfCx0SH3l6a2P0AItG54OGY4LMVG2V62+QCARbZsLvnA5EPNMUvt
         iRzZI2MX7YUujAx5X/NWpW+gynhrAUFsDZfzWEzd53OAB0Zwf3xMgmgMEqnYub2102SO
         tZIhQwGFbepBccx093sEpznj77Dbgf4Tp31pjc6s7UZrjYNxFDahgK47pQfFYvSeeuUT
         1cWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006390; x=1726611190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgWPkJOgDCTgQuyFh0W8ok44kERRCzXuvotXrcKd8BI=;
        b=Ab0loqFljkvcjZ+P2N7No/qzpa7VlRPnP56fx2g91bMtWXxTYjlNLoDawVIqporVl4
         YZe+VuxPF40PDwvlT1KFaL+fRKnECr7yj+BxSF6CBLjeQpQUBynDC78eV1p+N421fbQR
         rNd01Rb7/wglni3YwhGu2zx1kOIFi/UXy2SItYU9LSRzpqNf9hGCfgX7fwdaJ6BBcyeS
         kSVTsQln3y/vsD3mpgqqtRNymWl8A/2JswuCfWUquf1ZgiDm7AHqPbugg0MLmbht3ou4
         qaSj7emyhEmFRy1avRjsezygqnEHMdJs/OyeDW2fLFF4i7MbNtD08iTO5WUbX8AIkDpr
         sycA==
X-Gm-Message-State: AOJu0Yy+oVRDkFGVKoVlVElThk5YVWYgnb9A4Wy4hbHp0Wda/QEyheLc
	w7c+lvwedhCyx57WPDkxGqJcMFdgGcZFbLPwXIDXDusZ/idpe6q+tep0t+dONxgbXh+CmRvXcUK
	yrMAAXlO2D4H0Vwx3jKLsUAIAVNj9USp3goodTvgkbv3nIWudZHqFSxqfsPJC+BP//e74TvMvZ8
	ne9WTelrv8uDwEqgYnJcXbyYFaF82sKWKYAJfSSgE62Uyj
X-Google-Smtp-Source: AGHT+IFZpIB1bRgxwr+GsjEt5pT4U4ZebwKSRo8cZjRcQzgaWa9DzF5r7vck8rwK32SLTSXkOQqqNO5dx4HP
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:d607:0:b0:e1a:44fa:f09 with SMTP id
 3f1490d57ef6-e1d8c260cc1mr1251276.2.1726006389351; Tue, 10 Sep 2024 15:13:09
 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:12:12 -0700
In-Reply-To: <20240910221235.2132138-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910221235.2132138-1-jstultz@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910221235.2132138-7-jstultz@google.com>
Subject: [RESEND x2][PATCH v12 6/7] sched: Split out __schedule() deactivate
 task logic into a helper
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
2.46.0.598.g6f2099f65c-goog


