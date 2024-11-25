Return-Path: <linux-kernel+bounces-421580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654CC9D8D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2511028D264
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B7D1CDFA7;
	Mon, 25 Nov 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHIGu9A+"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DAF1CCEF6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564339; cv=none; b=AZn00aBHiUKAd0Gdv6fUuVNxX6u6hnDEeooey56i3BoaqAW4WnpFY9RWVJbHIJcfHdOW4Vl6f3rwn6X485oXwCvMxOnH0KWGr0CrmwsbSuuFWe5yw44D1j3XGEmEtmDhfKf9jWoQve1Mg1aKIj3VStoS5yinw6A5MoOw5dsd7Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564339; c=relaxed/simple;
	bh=YQhCzALqRDyDbecrAh9MRJPPWuTt5/T20h9nLExEeM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qmMAusLoa1w9y6DQ91qLmCkcWiM0b22aKjXDX/dCscUoB9vgMgHtCDTgsoVVbXrBv9cbBy9yVfv6qnTYwVxfLvHCSxC89BYmDDD+cVlp8GN+iwO63CylVUvjT7SDzaBOnWqAbmV0UVQY4Ljeu6y8rIdJmxObR5Z38z5lbeUMssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iHIGu9A+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-214caf579f9so13632855ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732564337; x=1733169137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HwT7sFYNiac03qNvlAMYNsq6dw1Y8S2dHsVOsavG2c=;
        b=iHIGu9A+QiUZbbu4Sj9CVLq17oE+QD0wNclwR4NWZg/TBhYBQor4vjELK0vrOQtBuS
         1Ev2DBbeEkH/nSX6Om6t4+c85bmOWupnn67p+b916ngxnyFfZ8eQK4/wr6427hCDA00T
         bQfQRdRjfgFYetOCXL5O9pQyoa39uyJg8X1y/g5zF0ZUvQ5zrOcW6D6XSzOjUcn+zM2W
         ecyUNyhgeToS0fCwU7kWKgA/JyvgwQOITPscMpy+NQhjWSIt0ZPU8wsXGcf88J/lTXoX
         0SMJKcYhlvw1YEPnSE7zzQRqTAUt1AjAjWO8UXrcL/Ml2gyLVX4mK4Y8IpFVvM/3fTvr
         Dqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564337; x=1733169137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HwT7sFYNiac03qNvlAMYNsq6dw1Y8S2dHsVOsavG2c=;
        b=byWZsxI4F1LFcWWuZKAEsqwht6ocLs1OE+44xeYTOlEveSc2WdE4w0paN0W2GRCXuz
         qfTLlNNsAJwTwT/dycis7F/uLv3tDFjO11gRKQADFeiFP8qVgwAw3L+/d8yVodF3VkFk
         9f2Wq8ExI913dTWUwnPIcGKXcQdeuDUqJ9lky92N2UUp8pVYPTYToBfzBsO0qeITUoIX
         8TNyx1pVvemdEeWaZwT8fvxTh6r5n7Po6YoG+5/Rl5kxKOXgQQu9GrM4Phkd60kwmhcY
         r9SZ6veJnHllCN17gJO3quZzXEpYEMDXlaeLqHnIzWH9wOEPdyPX/OVuDFH68Sz3Wlx9
         dSjw==
X-Gm-Message-State: AOJu0YwvyJUQ03fpSQNOwxjHkvJ81slaRI+NLW/sllYWRBaqwxiyS6RF
	Nt49F/o/VHHCGKTsaqg6us0+kE3rnn6n587neioIBSZyd/ikI4sjr/hgJEuiq1ENUi9MGvadGlP
	lvje1LEP1gB+R3fJWb/ae7JeGBcHYPlTnGOaLCIOMXqh8CEUAehK2wvsiHJHhdclouuVQEKd3SO
	vdTdhHHV4075cETU53V4YvousRZnpUlobtaM2JJLZ2c+51
X-Google-Smtp-Source: AGHT+IGBeZIDh0a6pqhb9R7agS8KBzor9QImbCQUllu1nJQTGBmlhwnhZdqXG+5XE5dpVQevwr4+wxsvFvy9
X-Received: from plgm5.prod.google.com ([2002:a17:902:f645:b0:212:4a87:fa9a])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:244b:b0:20c:774b:5ae5
 with SMTP id d9443c01a7336-2129fce2dd2mr194368775ad.9.1732564337034; Mon, 25
 Nov 2024 11:52:17 -0800 (PST)
Date: Mon, 25 Nov 2024 11:52:00 -0800
In-Reply-To: <20241125195204.2374458-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241125195204.2374458-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125195204.2374458-7-jstultz@google.com>
Subject: [RFC][PATCH v14 6/7] sched: Fix proxy/current (push,pull)ability
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
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
index b492506d33415..a18523355fb18 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6737,6 +6737,23 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
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
@@ -6875,6 +6892,10 @@ static void __sched notrace __schedule(int sched_mode)
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
@@ -6908,6 +6929,10 @@ static void __sched notrace __schedule(int sched_mode)
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
2.47.0.371.ga323438b13-goog


