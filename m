Return-Path: <linux-kernel+bounces-238990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E101925496
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91511F255B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3216C136986;
	Wed,  3 Jul 2024 07:26:34 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27690131BDD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991593; cv=none; b=HmmqXY+qprk3/av5CzoLkL0hc/C8VoLuSYY8GigzMSa2buDsldFhxsTdrNHiF9t7lZVPfQkvtbjeyU2p+cSWq0/7P/pbL2t/zkRMAl9TFfHlYORy3MjAzRe76TL4hFhnkmkgfxLFbNlfj3PXoXPDsYrz1rh5yNotNwYGcumiwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991593; c=relaxed/simple;
	bh=sM48PVr6/ZVkYfkSGtONLmuGdRCxRT0Ovx3tUWqLHwo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PKJClU0LUekSfFku62fqS/L4OUeMIc4QwH8vZRICCZ+Ki43tyJ8cuocjab7Ysb3MA5s6H+RsLOaoHRDV8saHZFf8a5efDk9cO2lcEjlljermqC5nQ7nlo8TP708aVMo0/vSMWN126USEGCb/d6BKntmYi9LqDgR0FcxmWNtM+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so547819839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 00:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719991591; x=1720596391;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJbmOzkC/sl0HVV8kYGdcdAPPdfiAFvNZKyytSwrDZM=;
        b=Atz0HSYCmltIqSXZULpChMJqUuou9OEWrzvMFqwRdLZRlqn+g+BxKUDQ964ntq5b8Y
         lbfVyF4tzdBRmE00/AiuT2TlYiWU0ZkZx6aP9RluRtkt2TcudlHAai6Adm+FV8vAXYBF
         dA/kHtlaOMp4EGvCVdC6m/I21aPhkov2+oGjQlgiykPLU9NvUiBBxveTnDfz+t/jYe/2
         vBJ47T3HfUV5YiIK+upzekAgkAHMV2ulXcaoYvx+YqcNpGKEvm8B+J7JnJ5rMcHBtm9E
         99Dv3Ab7fdewPylGuV3RL15oFZ5BWWcAqW7+DQoWztZhWw6Xty1/1laEIuyxWeDHRGwB
         lorw==
X-Gm-Message-State: AOJu0YzhxpbLWSFBzTwUN45UDR8aLFZ9tp9xMIjxmvsqqD6Va4Sgxhzp
	GQgPjD2YAUEjUEJ3nZpZBRhyrJ0XH3+14T8gOkHWUgGw/4JjFVU9plskHmjqXKDrfK9kmlbd+vw
	kS3DpcUrT07PqeckmBhXMgRYYo/tz9s/0WWdJugTHoLF+fMlTL7P2C2Y=
X-Google-Smtp-Source: AGHT+IGld67AA0WM48TnIB4CuSVGsvaQh5pqx2r3Cgx8FrezdZX79Xb9NoA/BgkuLLhCu7POLBWtpydRq+U1H55ffDhKDqZtJbBU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1696:b0:7f3:d731:c6d1 with SMTP id
 ca18e2360f4ac-7f62ee18504mr80368839f.1.1719991591084; Wed, 03 Jul 2024
 00:26:31 -0700 (PDT)
Date: Wed, 03 Jul 2024 00:26:31 -0700
In-Reply-To: <00000000000089427c0614c18cf4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdb895061c52bf0e@google.com>
Subject: Re: [syzbot] Test
From: syzbot <syzbot+c4c6c3dc10cc96bcf723@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Test
Author: radoslaw.zielonek@gmail.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e25604716c03576d05ac8a5209743

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


