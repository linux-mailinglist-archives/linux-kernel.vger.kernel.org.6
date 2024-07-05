Return-Path: <linux-kernel+bounces-242078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A232928347
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806941F2515D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A99144D1F;
	Fri,  5 Jul 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTEtMEE2"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712F13A412
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166263; cv=none; b=KZPoptJcptoYnaIWmbF48NEOg/L1LMJVKwTwHf1fZKCOC79371dp9rqOphDI1Ydjm7+60nQpY9y2qP6IGBnEQbVDbWVvW+WZ2XeMZobtbknWr3UR5p5hQMwpwgug8+sFwQS9GMzeXuHrrsM49yV/WXVbLhrGcsoxY8emA0Ifu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166263; c=relaxed/simple;
	bh=Bi75qJpaPL6OrvTxm60BhWQIwz9zFJETJyMI8T9Ic2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NA82uSsOwwaqRlI7HO4VJOH0dfykKp6uxz3vZeqThel8yGio6Rn5BZOXenlfMS2cuqHKYy8h+EGROPkK8KF84My30D9YLA/XVTvYMT46pR85DnbvY06fNb1ulPd+Ao/VSJ5OLKfeJLPfVhyzrbgNJauX2er/h9FNWxH+w13q9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTEtMEE2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea2ce7abaso1245698e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720166259; x=1720771059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ahhT1cUXxpEuMACajTYDd5HqVim/E3HR7gjG2q/IHhU=;
        b=OTEtMEE21dBmp9JmSN0aDzcpZkdRynDHb25GvWTo6wewjTIuafoXVVsJ6iGE3LEolp
         KG+epQ0MnV+pTzymjQWZYuG+P2pr4f+Q07tKzJ4VPdZG9ReDmmW3VW8Cy2VV3pJpmXnv
         WHKm4aMuvhxyr0cBGJOBABlswNtykU7cstaDIQlueytgNggZ44St7z9Bxq7yaBIPHabb
         HM9XtILayJ6KGJO91MHOnjnVjyIMLFKEXnyxur5pdVmub42EIcJEGXTlF7QeFmG9uANG
         tbC5hH9sYgVJ5yx3qmQJDHzsIX2HAWQgzrprcVAS+WnzkC+5B9H+MHKxOfzd6FbKdzLt
         v1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720166259; x=1720771059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahhT1cUXxpEuMACajTYDd5HqVim/E3HR7gjG2q/IHhU=;
        b=Fo8EPMwAhIIonZL40nRrBtkDRUYzrvKGzxC25o1RFF+r2qkx5lKRpa7p2s6SpuK7vh
         KBdrmJJhIyacfrgPuKUhOsxPz7ZLOUIYd7ue85TbORlEbgN0qrLusRfkW40xqT3vtRvM
         WBDYlhzOpfBedkQZV3n7D8jYGMg0MJOF2BP+KY9J1lfnXyoJirw37QnlVkW3dGVjlQOR
         nd1dTltE0T7eMJE4vFJ+VvnUfcaUOTIljBEqFgiYL2swIvfa9owM6qjW+2REmzV5ydXc
         0sUp4Yh5vHguj5WIh+cdYbw9VF6d8BNqcp5qL2LRI/mSFnESS9ICJ7miRwapo4rR2UAe
         W0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUhBMY9DXt7Bht9ipdn1KslgsJO5egPyPYz/bpIwqADs58MNoHe560AS2Sc5p58PyA4sxATzo5cK0bhEcQEH4bf++912V1kkox1rP98
X-Gm-Message-State: AOJu0YzfoxgnDkaY/POTfW1E3Y32SYlWjM4/0z05AgbLpJ0VuvjulWKv
	nKx1GiTcwJbLq78ugl2DeukmWe1n08nbYG4hYqDvEzXC2z1zXBn4
X-Google-Smtp-Source: AGHT+IE5nSmzsDuLxlOFZdN+xIfpqkLaxc3AtcBHM1Qpc0uDs7srgD77PbH7j7yTYVIGksrDBbmczg==
X-Received: by 2002:ac2:456f:0:b0:52c:842b:c276 with SMTP id 2adb3069b0e04-52ea06b0effmr3123830e87.53.1720166259043;
        Fri, 05 Jul 2024 00:57:39 -0700 (PDT)
Received: from LPPLJK6X5M3.. (178-37-38-123.dynamic.inetia.pl. [178.37.38.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58f6f46f4aasm700518a12.69.2024.07.05.00.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:57:38 -0700 (PDT)
From: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	oleg@redhat.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tandersen@netflix.com,
	bigeasy@linutronix.de,
	vincent.whitchurch@axis.com,
	kunyu@nfschina.com,
	ardb@kernel.org,
	linux-kernel@vger.kernel.org
Cc: liam.howlett@oracle.com,
	syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
Subject: [RFC] Signaling overhead on RT tasks is causing RCU stall
Date: Fri,  5 Jul 2024 09:56:23 +0200
Message-ID: <20240705075622.925325-2-radoslaw.zielonek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I'm working on syzbot bug: rcu detected stall in validate_mm
https://syzkaller.appspot.com/bug?extid=a941018a091f1a1f9546.
I have analyzed this issue and here is what I found:

When too many signals are sent to the RT task, the overhead becomes very high.
The task cannot perform its job and as a consquenece the rt_runtime (0.95s)
is not reached even after hundreds of seconds.
This situation can be achieved by using POSIX Timers with very low interval.

The problem scenario:

1. RTLIMIT_RTPRIO is changed to non-zero value.
2. Scheduler policy is changed to SCHED_FIFO or SCHED_RR.
3. Posix Timer is created with low interval - several nanoseconds.
4. The signaling overhead becomes very high, the RT task is scheduled
   but cannot reach rt_runtime (0.95s). As a consequenece there is no context
   switch with non-RT task even after hundreds of seconds.

I have created a very simple solution by monitoring the number of signals
and throttling the RT task when the number of signals is greater than
or equal to 100. I am aware that this solution is very weak and cannot
be applied as a long-term, proper solution.

Could you help with finding more appropriate solution?

The patch is here:

Reported-by: syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a941018a091f1a1f9546
Link: https://lore.kernel.org/all/0000000000000a13ee06183e4464@google.com/T/
Signed-off-by: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
---
 include/linux/sched.h |  7 +++++++
 kernel/sched/core.c   |  1 +
 kernel/sched/rt.c     | 26 +++++++++++++++++++++++---
 kernel/signal.c       |  9 +++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 17cb0761ff65..123bc16ad3d0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1121,6 +1121,13 @@ struct task_struct {
 	size_t				sas_ss_size;
 	unsigned int			sas_ss_flags;
 
+	/*
+	 * Number of signals received by an RT task between scheduling ticks.
+	 * This counter is used to throttle RT tasks when too many signals
+	 * (e.g., POSIX timers) are sent to the task, which can cause an RCU stall.
+	 */
+	atomic_t rt_signals_recv_count; /* used outside of the rq lock */
+
 	struct callback_head		*task_works;
 
 #ifdef CONFIG_AUDIT
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d44efa0d0611..9def826bd35f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4779,6 +4779,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 			p->policy = SCHED_NORMAL;
 			p->static_prio = NICE_TO_PRIO(0);
 			p->rt_priority = 0;
+			atomic_set(&p->rt_signals_recv_count, 0);
 		} else if (PRIO_TO_NICE(p->static_prio) < 0)
 			p->static_prio = NICE_TO_PRIO(0);
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3261b067b67e..9b22d67d1746 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -24,6 +24,15 @@ int sysctl_sched_rt_period = 1000000;
  */
 int sysctl_sched_rt_runtime = 950000;
 
+/*
+ * To avoid an RCU stall due to a large number of signals received by RT tasks
+ * (e.g., POSIX timers), the RT task needs to be throttled.
+ * When the number of signals received by an RT task during a scheduling
+ * tick period exceeds the threshold, the RT task will be throttled.
+ * The value of 100 has not been thoroughly tested and may need adjustment.
+ */
+#define RT_RECV_SGINAL_THROTTLE_THRESHOLD 100
+
 #ifdef CONFIG_SYSCTL
 static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
 static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
@@ -951,7 +960,7 @@ static inline int rt_se_prio(struct sched_rt_entity *rt_se)
 	return rt_task_of(rt_se)->prio;
 }
 
-static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
+static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq, int rt_signal_recv)
 {
 	u64 runtime = sched_rt_runtime(rt_rq);
 
@@ -966,7 +975,15 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 	if (runtime == RUNTIME_INF)
 		return 0;
 
-	if (rt_rq->rt_time > runtime) {
+	/*
+	 * When a large number of signals are sent to this task (e.g., POSIX timers)
+	 * the delta time deviates significantly from real time due to the overhead
+	 * of handling signals. For RT tasks, this can cause an RCU stall.
+	 * To avoid this, throttle the task when the number of signals received
+	 * exceeds a certain threshold.
+	 */
+	if (rt_rq->rt_time > runtime ||
+		rt_signal_recv >= RT_RECV_SGINAL_THROTTLE_THRESHOLD) {
 		struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
 
 		/*
@@ -1021,7 +1038,9 @@ static void update_curr_rt(struct rq *rq)
 		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
 			raw_spin_lock(&rt_rq->rt_runtime_lock);
 			rt_rq->rt_time += delta_exec;
-			exceeded = sched_rt_runtime_exceeded(rt_rq);
+			exceeded = sched_rt_runtime_exceeded(
+						rt_rq,
+						atomic_read(&curr->rt_signals_recv_count));
 			if (exceeded)
 				resched_curr(rq);
 			raw_spin_unlock(&rt_rq->rt_runtime_lock);
@@ -1029,6 +1048,7 @@ static void update_curr_rt(struct rq *rq)
 				do_start_rt_bandwidth(sched_rt_bandwidth(rt_rq));
 		}
 	}
+	atomic_set(&curr->rt_signals_recv_count, 0);
 }
 
 static void
diff --git a/kernel/signal.c b/kernel/signal.c
index bdca529f0f7b..d58e0ba9336c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -629,6 +629,15 @@ int dequeue_signal(struct task_struct *tsk, sigset_t *mask,
 	bool resched_timer = false;
 	int signr;
 
+	/*
+	 * To prevent an RCU stall due to receiving too many signals by RT tasks,
+	 * count all signals regardless of their type.
+	 * Based on this counter, the RT scheduler will decide whether the task
+	 * should be throttled or not.
+	 */
+	if (tsk->policy == SCHED_FIFO || tsk->policy == SCHED_RR)
+		atomic_inc(&tsk->rt_signals_recv_count);
+
 	/* We only dequeue private signals from ourselves, we don't let
 	 * signalfd steal them
 	 */
-- 
2.43.0



