Return-Path: <linux-kernel+bounces-168870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87598BBF16
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 05:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB92282036
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 03:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D588F17F7;
	Sun,  5 May 2024 03:09:38 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4D12D812
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714878578; cv=none; b=iI7EkBSaafFVHetEczhq3S3SHtIMBKvavrkY9qcuWM0jpjQ11eGMWvTkpIpYJiJfM406w6Fykyw72vTQO+OG0yXd0kZMvTrK5TXfLm/wDg0ETT6/xzd+iUzmj59JTKP+tU6HOfnEEArNukabCdfk6kgTdcR6pakHcTokDLnFBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714878578; c=relaxed/simple;
	bh=JovTlggdLZ+eev1UzaRIj22vDkSldGSCZB+hh3iRUz8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O0bFty9MgbcGnYQEu99vyLAkTXjvQyoU2AO4cw/nMr1WY+F1C2FItIhzcJ+f7ThrviaZsol5VjkHYsFCP1GWrBjrjhKhyD2gtKF1Uc1SJAhRdqKU/1dBO5KXJcMoQf3EUyLTI5UZsSJwYS8BlRtzRqujvnEM2xji5j3y1jou8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 8842A186072ED4;
	Sun,  5 May 2024 11:06:19 +0800 (CST)
Received: from didi-ThinkCentre-M920t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 11:06:20 +0800
Date: Sun, 5 May 2024 11:06:15 +0800
X-MD-Sfrom: fuyuanli@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: fuyuanli <fuyuanli@didiglobal.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<kolyshkin@gmail.com>, <fuyuanli@didiglobal.com>,
	<akpm@linux-foundation.org>, <kent.overstreet@linux.dev>,
	<frederic@kernel.org>, <oleg@redhat.com>, <hca@linux.ibm.com>,
	<paulmck@kernel.org>, <tj@kernel.org>, <bigeasy@linutronix.de>,
	<kuba@kernel.org>, <CruzZhao@linux.alibaba.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: Introduce task_struct::latency_sensi_flag.
Message-ID: <20240505030615.GA5131@didi-ThinkCentre-M920t-N000>
Mail-Followup-To: mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	kolyshkin@gmail.com, fuyuanli@didiglobal.com,
	akpm@linux-foundation.org, kent.overstreet@linux.dev,
	frederic@kernel.org, oleg@redhat.com, hca@linux.ibm.com,
	paulmck@kernel.org, tj@kernel.org, bigeasy@linutronix.de,
	kuba@kernel.org, CruzZhao@linux.alibaba.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZJY02-PUBMBX-01.didichuxing.com (10.79.65.31) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)

In the path local_bh_enable()->__local_bh_enable_ip(), the softirq
handlers will be executed in the context of current task. But for some
tasks sensitive to running latency, we expect that they will not spend
extra time executing softirq. So latency_sensi_flag is introduced in
task_struct, when it is set to 1, task only wakes up softirq daemon in
__local_bh_enable_ip().

A test has been made in two hosts named A and B. In A, several clients
sent udp packets to a single server in B concurrently as fast as
possible. In B, the IRQs of these flows were bound to CPU 0 by flow
director, so there was always a triggered net_rx softirq on CPU 0. Then
a test program was started in B, which was also bound to CPU 0, and
keeped calling sendto() in a loop. Sampling with perf, results showed
that about 25% of running time of test program was spent executing
local_bh_enable() contained in syscall sendto(), but after setting
latency_sensi_flag to 1, this proportion had been reduced to 0.5%.

Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
---
 include/linux/sched.h            |  2 ++
 include/uapi/linux/sched.h       |  4 +++-
 include/uapi/linux/sched/types.h |  3 +++
 init/init_task.c                 |  1 +
 kernel/sched/core.c              | 12 ++++++++++++
 kernel/softirq.c                 | 20 ++++++++++++--------
 6 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..af39888079c0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -925,6 +925,8 @@ struct task_struct {
 	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
+	/* Bit means if task is sensitive to latency */
+	unsigned			latency_sensi_flag:1;
 #ifndef TIF_RESTORE_SIGMASK
 	unsigned			restore_sigmask:1;
 #endif
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..07c7ec5bd5a6 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -132,6 +132,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_LATENCY_SENSITIVE	0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -143,6 +144,7 @@ struct clone_args {
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_LATENCY_SENSITIVE)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index 90662385689b..d435b75e6ac9 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -116,6 +116,9 @@ struct sched_attr {
 	__u32 sched_util_min;
 	__u32 sched_util_max;
 
+	/* Latency sensitive flag */
+	__u32 sched_latency_sensi_flag;
+
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
diff --git a/init/init_task.c b/init/init_task.c
index 4daee6d761c8..f36237d06485 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -98,6 +98,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #ifdef CONFIG_CGROUP_SCHED
 	.sched_task_group = &root_task_group,
 #endif
+	.latency_sensi_flag = 0,
 	.ptraced	= LIST_HEAD_INIT(init_task.ptraced),
 	.ptrace_entry	= LIST_HEAD_INIT(init_task.ptrace_entry),
 	.real_parent	= &init_task,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..6dfc2db7ef88 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7763,6 +7763,9 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
+	if (attr->sched_latency_sensi_flag > 1)
+		return -EINVAL;
+
 	/*
 	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
 	 * information.
@@ -7804,6 +7807,8 @@ static int __sched_setscheduler(struct task_struct *p,
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
 
+		if (attr->sched_flags & SCHED_FLAG_LATENCY_SENSITIVE)
+			p->latency_sensi_flag = attr->sched_latency_sensi_flag;
 		p->sched_reset_on_fork = reset_on_fork;
 		retval = 0;
 		goto unlock;
@@ -7908,6 +7913,9 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	check_class_changed(rq, p, prev_class, oldprio);
 
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_SENSITIVE)
+		p->latency_sensi_flag = attr->sched_latency_sensi_flag;
+
 	/* Avoid rq from going away on us: */
 	preempt_disable();
 	head = splice_balance_callbacks(rq);
@@ -8314,6 +8322,10 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		get_params(p, &kattr);
 		kattr.sched_flags &= SCHED_FLAG_ALL;
 
+		kattr.sched_latency_sensi_flag = p->latency_sensi_flag;
+		if (kattr.sched_latency_sensi_flag)
+			kattr.sched_flags |= SCHED_FLAG_LATENCY_SENSITIVE;
+
 #ifdef CONFIG_UCLAMP_TASK
 		/*
 		 * This could race with another potential updater, but this is fine
diff --git a/kernel/softirq.c b/kernel/softirq.c
index b315b21fb28c..f4e7ce4cde81 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -226,10 +226,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 		goto out;
 
 	/*
-	 * If this was called from non preemptible context, wake up the
-	 * softirq daemon.
+	 * If this was called from non preemptible context, or current task is
+	 * sensitive to running latency, wake up the softirq daemon.
 	 */
-	if (!preempt_on) {
+	if (!preempt_on || current->latency_sensi_flag) {
 		wakeup_softirqd();
 		goto out;
 	}
@@ -375,11 +375,15 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	__preempt_count_sub(cnt - 1);
 
 	if (unlikely(!in_interrupt() && local_softirq_pending())) {
-		/*
-		 * Run softirq if any pending. And do it in its own stack
-		 * as we may be calling this deep in a task call stack already.
-		 */
-		do_softirq();
+		/* If task is sensitive to running latency, only wake up the softirq daemon. */
+		if (current->latency_sensi_flag)
+			wakeup_softirqd();
+		else
+			/*
+			 * Run softirq if any pending. And do it in its own stack
+			 * as we may be calling this deep in a task call stack already.
+			 */
+			do_softirq();
 	}
 
 	preempt_count_dec();
-- 
2.17.1


