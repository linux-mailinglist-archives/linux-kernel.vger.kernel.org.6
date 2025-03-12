Return-Path: <linux-kernel+bounces-558527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF53A5E70F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3947F7AD260
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F421F152B;
	Wed, 12 Mar 2025 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PfXXdvV8"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E281F1311
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817537; cv=none; b=N4ujhLnxp7MmAT4Uz4+vBQrQeZRlysfght9PEcbTjzuKvPEwbJeRsictKEiKECrU9/AAMNpIuYl7KStZoh8sDYOgkH+eIEotfitiVI2aGgLQ2K9MZW/dCFjgtB7iM9LNrwwywtriwgkkvNb8NQLGlcMx6e/yxh8qGE3qgeOCess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817537; c=relaxed/simple;
	bh=req2emdWfB0EILF9JqxNwvTgZRnMrCObPu1gITQ16xc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=msMjHoQBUEQzy9/XaT6GMAP//q4fw6P8CVPMLuuLIYOt/fsMTeyyPUm11pR+RTyu778NGhkKpcqROPiPbC1t/xA+vZcW7pjeTdOW6PD6WxNSK+/Inn2CveIOJ1KgwKwQV2f7T3Q0EcOtqB1nyx20pfuWDLuUe2aPBqLv3A2QrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PfXXdvV8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225429696a9so8617675ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741817534; x=1742422334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yb7D8Nv8RbDNVPA6BEFWWZ/iiYtFcCjVbuTNxnftR+c=;
        b=PfXXdvV8fNBjB0240vmdR/nlaainAORlJb1pZ0ZjqxnaIKEyvRxANglcB2lVxFw3xQ
         LsYEjavgQo9zJ8WxM+9TmE1MjhjFsrFEo43rL9D0fYav6acp+YkGxW101UXmkU9Bzkon
         hMWLko9NnoVZycfVQwD1c5vEcDMDcmu/Y1WO2I4It+PrctYD5qoQTk4GUGaRyvUZfZXG
         SvA+Jacl6ZVURu13j/EHf4nKMJasqvz5/m+1qCOxN5rKgTKUZxEanj3S6GIGVDGj4QrB
         e9CK8a1ZkojM4cuWnOrWt9QJE+5AdnWm2NDchllNk7tYyJAV97kuAbrGLG1zobsXsAft
         HAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741817534; x=1742422334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yb7D8Nv8RbDNVPA6BEFWWZ/iiYtFcCjVbuTNxnftR+c=;
        b=vqNFgnAlQwIodmd0fu/XLugS2uj+B2BLDs+LFwpCzu3nHkMt56jlFcBz3z7vAxICZy
         p0Hcbk2lZYIBc8uzC41654k94a8/VgryafkcYYBp5Bu5KcmNR5FiRk4hFX3UJW8Meqzx
         ZRHJo2D0bsqV0cCes8pZAc5649142nmSs9MfzSHlfUZ90i75u67n/obQwenfq/EF4VHQ
         r3iYisBRJBFqTQHCKbj8VpgMXyJcugj4+QTrH+6vEcXXJMLGcFqJ3UeVNHMm4JV/ct8f
         w/d8lfgnU6reVF0QUpZ4Eva7q6nvBapJfJgAJDUGturvIAz/dWZQNPosf+kIl/dlYdE9
         Et+Q==
X-Gm-Message-State: AOJu0YxIrJO0Pt5vxqoWy8UGOEsJRP0d5Alnbud8RCwFvfVdb0cNdF+e
	pyf8htpaAXRQZXrCN3zDIAXgQxTZ8WSTK514I3tcqSS5UyJbRVpBmz6b8PiI+GMX21J74+AN8ya
	4yyAD4qz86q0aONpT7aqcB9PvHNKI4s+q/d7gKqY49S1QM/xnPAs0qcelLTKdaEw2kePjeesLA0
	iIZ68f63uxCLFvuf2YNG7dcQSdKvkkCD4aqRYb6/xKT9t1
X-Google-Smtp-Source: AGHT+IGyWxTtg6fXUr10H8hhSrLY5MwvkDnk2Pt0hz5MA85DWNygzaAwBWdJAzaQWFEDbBP9zLY6M2NVZ5tU
X-Received: from pfjd14.prod.google.com ([2002:a05:6a00:244e:b0:736:a1eb:1520])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b4d:b0:730:8a0a:9f09
 with SMTP id d2e1a72fcca58-736aaaaca0fmr34850966b3a.18.1741817534134; Wed, 12
 Mar 2025 15:12:14 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:11:36 -0700
In-Reply-To: <20250312221147.1865364-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250312221147.1865364-1-jstultz@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312221147.1865364-7-jstultz@google.com>
Subject: [RFC PATCH v15 6/7] sched: Fix proxy/current (push,pull)ability
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Valentin Schneider <valentin.schneider@arm.com>

Proxy execution forms atomic pairs of tasks: The waiting donor
task (scheduling context) and a proxy (execution context). The
donor task, along with the rest of the blocked chain, follows
the proxy wrt CPU placement.

They can be the same task, in which case push/pull doesn't need any
modification. When they are different, however,
FIFO1 & FIFO42:

	      ,->  RT42
	      |     | blocked-on
	      |     v
blocked_donor |   mutex
	      |     | owner
	      |     v
	      `--  RT1

   RT1
   RT42

  CPU0            CPU1
   ^                ^
   |                |
  overloaded    !overloaded
  rq prio = 42  rq prio = 0

RT1 is eligible to be pushed to CPU1, but should that happen it will
"carry" RT42 along. Clearly here neither RT1 nor RT42 must be seen as
push/pullable.

Unfortunately, only the donor task is usually dequeued from the rq,
and the proxy'ed execution context (rq->curr) remains on the rq.
This can cause RT1 to be selected for migration from logic like the
rt pushable_list.

Thus, adda a dequeue/enqueue cycle on the proxy task before __schedule
returns, which allows the sched class logic to avoid adding the now
current task to the pushable_list.

Furthermore, tasks becoming blocked on a mutex don't need an explicit
dequeue/enqueue cycle to be made (push/pull)able: they have to be running
to block on a mutex, thus they will eventually hit put_prev_task().

Cc: Joel Fernandes <joelagnelf@nvidia.com>
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
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kernel-team@android.com
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v3:
* Tweaked comments & commit message
v5:
* Minor simplifications to utilize the fix earlier
  in the patch series.
* Rework the wording of the commit message to match selected/
  proxy terminology and expand a bit to make it more clear how
  it works.
v6:
* Dropped now-unused proxied value, to be re-added later in the
  series when it is used, as caught by Dietmar
v7:
* Unused function argument fixup
* Commit message nit pointed out by Metin Kaya
* Dropped unproven unlikely() and use sched_proxy_exec()
  in proxy_tag_curr, suggested by Metin Kaya
v8:
* More cleanups and typo fixes suggested by Metin Kaya
v11:
* Cleanup of comimt message suggested by Metin
v12:
* Rework for rq_selected -> rq->donor renaming
---
 kernel/sched/core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b4f7b14f62a24..3596244f613f8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6722,6 +6722,23 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 }
 #endif /* SCHED_PROXY_EXEC */
 
+static inline void proxy_tag_curr(struct rq *rq, struct task_struct *owner)
+{
+	if (!sched_proxy_exec())
+		return;
+	/*
+	 * pick_next_task() calls set_next_task() on the chosen task
+	 * at some point, which ensures it is not push/pullable.
+	 * However, the chosen/donor task *and* the mutex owner form an
+	 * atomic pair wrt push/pull.
+	 *
+	 * Make sure owner we run is not pushable. Unfortunately we can
+	 * only deal with that by means of a dequeue/enqueue cycle. :-/
+	 */
+	dequeue_task(rq, owner, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
+	enqueue_task(rq, owner, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE);
+}
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6856,6 +6873,10 @@ static void __sched notrace __schedule(int sched_mode)
 		 * changes to task_struct made by pick_next_task().
 		 */
 		RCU_INIT_POINTER(rq->curr, next);
+
+		if (!task_current_donor(rq, next))
+			proxy_tag_curr(rq, next);
+
 		/*
 		 * The membarrier system call requires each architecture
 		 * to have a full memory barrier after updating
@@ -6890,6 +6911,10 @@ static void __sched notrace __schedule(int sched_mode)
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
+		/* In case next was already curr but just got blocked_donor */
+		if (!task_current_donor(rq, next))
+			proxy_tag_curr(rq, next);
+
 		rq_unpin_lock(rq, &rf);
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


