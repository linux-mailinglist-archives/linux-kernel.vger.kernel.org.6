Return-Path: <linux-kernel+bounces-170662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE78BDA4F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869FFB24BF6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A2671B4C;
	Tue,  7 May 2024 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Po6hLqjS"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88056BB44
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 04:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057710; cv=none; b=N16/cSHVMaq6pehWEdm5EiW2Z4EGvBcyQjm+8fRCXR0oMq6yJ3Pwp39gfWNq+emNNBD21UI4+S3vPHv5q1Lx5mwz3VNm4hGOnrYqGiukL/HpoV3hCEUIqpTLU834tXJW1UAau12RNiKLEBccor5/B7IDSkEwuYSY5zL6DqQToy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057710; c=relaxed/simple;
	bh=g+GTE0QgxbfXrqDmGkRrFg5fgfsWhvESxTFXfZ6/tqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VUsSKjt0Otxo0oPllgbcJKudr3VnPoFXNLLitXxVQuKP1Fm+rMEMU6Nlk38wgXGjwEYyAJKlnICkoShXe5NsK2jkYuEfR9k0dH+kIGo/Pv1x9ITC30R6B7puAfu7uiDi4NevCVaSgfIw4gr0APUBxoOndm1pXJbsuTVtf29A21Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Po6hLqjS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b38e234a96so2286230a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 21:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715057708; x=1715662508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=frDfJWnzxEJXtKKN1swtCrc9MKAkukKvokYtsbi9wt8=;
        b=Po6hLqjSKMMxMISjQak1BL6baDtYbXBqx6mexRMsjDJxGt028L6sI33lJjuTNSdYw0
         cxl88WOrYNgD5Fth5kwstDdfDMurbCv+rTqpY350Svau3YfeVNP3A11+HjDpwauJdFHC
         wZxcawLXciUtoGpqRuS4JuIkHoR5t4/NeamFTRyP5v831RE2uuTYWB9ymYoewMLYgk1B
         KH+F4MhtYeMZAYooGmffsMA+T0IfcD42l6+AgXtUhhsD6gnxo0xNaChV5ZLTvv69HPsF
         1scMik7z2LfIz0haXUVt/gS5jkGmVBUOfudI+CzT00Ayy3JJ4bwzWJq1xQdj+tELurlC
         +Jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715057708; x=1715662508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frDfJWnzxEJXtKKN1swtCrc9MKAkukKvokYtsbi9wt8=;
        b=UO6pXvaTSodG0nSnKkp2Zu/22j4WdzyxkxjFmvdZlK9Dm7t+BdiPixBLHOIrYgZvij
         W9/RadtQCmVycQZOaFp0xVYy94XYOmrxDbfugby26PypA3WzlPh2BrgKvQwC+2QDU+/B
         CELJCHGmOfEYRpKwceTf6tOfDAf6GiM+Alc2krO6JaqhY1Knn+vbFcP23cNr1YWLVStu
         aL3w20id7Ax4HMoaRgWs6qat1kOBtR/O9Xm1hS/GDKjmr48OYCokLdwzxlCPXmdYcX7i
         PQa0TFnCZvgDTY8N76SAu5OqEgPQKsCg0/qczhAOs3RPCX45WUTN9q/a9OWtDM6DAj5b
         u/XQ==
X-Gm-Message-State: AOJu0Yy5wfkzaEMRO461oLtpB9cfNGLdr12tZB1+vreywgMc1JbX5yUh
	BhWNYmn0WkM8R5uUgCEmA3Pp/Aag2AiIpAQvMeiexiChEM2RpWZPCLJsD7BWNjSZw58uETb+cpP
	yKAtOwfQLtBIJK4k2YFLGmlzv9vRdSZe5W0dyRKAxp/SQP/Y/xsAqow02sEmeQVSkla8VPZnCZ4
	AnUr0N1TZP/FnEc0BW9qFiuV91NLXkAl22YbBMofhQ13WT
X-Google-Smtp-Source: AGHT+IFvlQYUY1S0c6R25r61u9MoSdtllzzBEFfXLANFAfot55vN9dlCHOU8FfzFirWkKwAzNUTX/WNRVXNB
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:aa17:b0:2ad:5fb9:16e9 with SMTP id
 k23-20020a17090aaa1700b002ad5fb916e9mr38005pjq.2.1715057707178; Mon, 06 May
 2024 21:55:07 -0700 (PDT)
Date: Mon,  6 May 2024 21:54:35 -0700
In-Reply-To: <20240507045450.895430-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507045450.895430-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507045450.895430-7-jstultz@google.com>
Subject: [PATCH v10 6/7] sched: Split out __schedule() deactivate task logic
 into a helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
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
Signed-off-by: John Stultz <jstultz@google.com>
---
v6:
* Define function as static to avoid "no previous prototype"
  warnings as Reported-by: kernel test robot <lkp@intel.com>
v7:
* Rename state task_state to be more clear, as suggested by
  Metin Kaya
---
 kernel/sched/core.c | 72 +++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 48f0d4b381d5..8bc5844ebab9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6572,6 +6572,48 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 # define SM_MASK_PREEMPT	SM_PREEMPT
 #endif
 
+/*
+ * Helper function for __schedule()
+ *
+ * If a task does not have signals pending, deactivate it and return true
+ * Otherwise marks the task's __state as RUNNING and returns false
+ */
+static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
+				   unsigned long task_state)
+{
+	if (signal_pending_state(task_state, p)) {
+		WRITE_ONCE(p->__state, TASK_RUNNING);
+	} else {
+		p->sched_contributes_to_load =
+			(task_state & TASK_UNINTERRUPTIBLE) &&
+			!(task_state & TASK_NOLOAD) &&
+			!(task_state & TASK_FROZEN);
+
+		if (p->sched_contributes_to_load)
+			rq->nr_uninterruptible++;
+
+		/*
+		 * __schedule()			ttwu()
+		 *   prev_state = prev->state;    if (p->on_rq && ...)
+		 *   if (prev_state)		    goto out;
+		 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
+		 *				  p->state = TASK_WAKING
+		 *
+		 * Where __schedule() and ttwu() have matching control dependencies.
+		 *
+		 * After this, schedule() must not care about p->state any more.
+		 */
+		deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
+
+		if (p->in_iowait) {
+			atomic_inc(&rq->nr_iowait);
+			delayacct_blkio_start();
+		}
+		return true;
+	}
+	return false;
+}
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6665,35 +6707,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
2.45.0.rc1.225.g2a3ae87e7f-goog


