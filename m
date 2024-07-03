Return-Path: <linux-kernel+bounces-239005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227179254B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4D428AE38
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0308E13B5A6;
	Wed,  3 Jul 2024 07:32:25 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA954502F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991944; cv=none; b=EgvqsZPQ15Yjnn5RA4dxkgkNATJkRmo0hkUwMT9DkA3eUvK+nv3cfxLOwiGGVZKkdsTSxVa4YpYsU6UzEsQq+IjKVQfB4AQMhA9BCZT3mA0X9G6p5bg3MrYP9u+COf5uoHfHwRPIgrDoHmgYPhCR3QFW/w6y2OZJZq8XBCZc05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991944; c=relaxed/simple;
	bh=RTr6DuFb0jcK5KsJ1WisGcdWrUwNN+BonIbZMMI11T0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JhPfOMQG7sLd4TQ3vEfxXkxsDbKI7Pj9qNqoXDSmpPj5p8O5zpGCTVA3jR7sGEBTopnsm8EynEjFrUubyXn85kFgRzaP0wn1n1eU436I24LBJTM+akVJwMT2Y0KI0s3CU5Nj2Opg2r5lNH0liZzejXRq1jmIPvWKQhYbqcl/8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f664993edbso17652339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 00:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719991942; x=1720596742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGHQWEy2N1RQFT/J/FUDcUJlJBQ+jInbbihKzGFa2c0=;
        b=cq2kSr6p8zyPKC8iNWF4Gfx9Gjcx0bvNcUoBbxW4dtPL2NVsh0jrokpZMp/8ZX22y5
         RqbVRZxV+uk4Gq0e6v/mBSlU5UTr6FPobgpbv45C1WrKtniQpq/pW8aNKjmZ4rNIYmYY
         EP5blsGgxTI1216WEz116dMizs2gVn5RX84jTRFyHCUlooqEknwIawsvS31PrBRxfUqv
         K9ee/+DrHGpL6qDsIcFTo3a+U7fsBGAEkQ+UjyEGHIDlRSnDeAWHY78Pt5B0g/eNfy9Y
         yqYdn4HJuk5dpVyr3+X8ccYNlpmFMl5/954izbxZCEneM8Uc8UE9xuEs7IFQsgpkhKQy
         XqeA==
X-Gm-Message-State: AOJu0Yzl7gGgXlL6a+clEpnia/va5zoL7ikig6cm6hrjQq1v0EPZ5X02
	90iv/9OKQgOCkxAfca9lJAsltMpIWVI6C2wS1s8ze+yFMuJ4JfkdiqRI4FSGl8w7+FDDPCpv/rz
	c3fJubylrdEpYNI6COBWxzwt6YGHdmNIydl0XB3M4gezVJtKX2eIhrhE=
X-Google-Smtp-Source: AGHT+IE2awO3mkaUJLTor8Ibas4dVUtcd5sXSrxUQ9wq17mTS+UlrQPRuzNVgGP+JbBLeXqEXZkRIP0bQ53Mg/X6t43xSTtnO3l/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:871d:b0:4b9:6c10:36c1 with SMTP id
 8926c6da1cb9f-4bbb6bccf6amr782603173.2.1719991940390; Wed, 03 Jul 2024
 00:32:20 -0700 (PDT)
Date: Wed, 03 Jul 2024 00:32:20 -0700
In-Reply-To: <0000000000000a13ee06183e4464@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fb88a061c52d482@google.com>
Subject: Re: [syzbot] Test
From: syzbot <syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Test
Author: radoslaw.zielonek@gmail.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dccb07f2914cdab2ac3a5b6c98406f765acab803

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


