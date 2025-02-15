Return-Path: <linux-kernel+bounces-515911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEB3A36A67
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7FA172DD8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15601EDA19;
	Sat, 15 Feb 2025 00:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lPJi4a/o"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA9199EB2
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580910; cv=none; b=SgNSdO0bSu0ApBDBmNh93TsdUdFjT38T7oz0WisGrmactPp+kQkM5vksJfhrIuECobwO8Q4szZhiu4r84zd85WMJ+43vzerGOdrGLVuxQ524FZMsJ4tGfTskRljRxtV7JXtoHHymEkcfxkHC5OKxImTjiNQNug6K8rcI0PC0bdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580910; c=relaxed/simple;
	bh=V5mh7QO0ytEe/f77i7RiwTyLJMrWr1WN18TqiZZvzIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+WrrsvhaNBU2Z5FhocAXMZgWlrMYp2XtbTmgC9ZmbYlgUkg9jMZ4Wv6ht+eMxnQMK6LfC2jXX/HVFpGPXfiiz3RVffkBavDqy2EXUll9ddgOBsnTEhbqEtoM7SSocTWvV+G+qWu3j6szIj2GhrAUj41CC1nAiohMS6h+HHlvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lPJi4a/o; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ELCa1Z027681;
	Sat, 15 Feb 2025 00:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=7XLnz
	TDvKuS5A/bOB7on7CO/KHjru0Nt+RL5Wd/5fgI=; b=lPJi4a/o2Vqso0Y+dCR9M
	9oohisCX9Kxqtj6sAm7974KL49Makb0WT0KrLAiBeVC9tt9ildUj9HcvRxqVkxpt
	MPSDCTcMaOTPnsiBiNPAGQfQGzkv0jWeEZlHsRskAbWLJyOqvqgv1gWcVfGWhfvX
	DnQP45cAupmY2FhUJODNayYi81qazi+/FS7vcWAuUvXw/BMtKZ3tuWRXaahoznWE
	hvKrejIGZpTuDT3bqiDsgghqCFAItiIXmrAkmokZA9PmkPjmDXRqI8bSDSSXAGW5
	plOgF7Yn8u6mlzCpYhtZKgAsI9lYVlTFHVmkcQeqaGQ26NsCwozcgJwEZdwYQWZ9
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tncpr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 00:54:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51F04a9Q014085;
	Sat, 15 Feb 2025 00:54:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqdx0jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 15 Feb 2025 00:54:46 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51F0sjV1030902;
	Sat, 15 Feb 2025 00:54:46 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqdx0j9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 15 Feb 2025 00:54:45 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, prakash.sangappa@oracle.com
Subject: [PATCH 2/2] Sched: Add scheduler stat for cpu time slice extension
Date: Sat, 15 Feb 2025 00:54:14 +0000
Message-ID: <20250215005414.224409-3-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250215005414.224409-1-prakash.sangappa@oracle.com>
References: <20250215005414.224409-1-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_10,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502150006
X-Proofpoint-GUID: 7NwTSfwcjNPxo4w9kb6DqxVzy74ord1B
X-Proofpoint-ORIG-GUID: 7NwTSfwcjNPxo4w9kb6DqxVzy74ord1B

Add scheduler stat to record number of times the thread was granted
cpu time slice extension.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/linux/sched.h | 2 ++
 kernel/rseq.c         | 1 +
 kernel/sched/core.c   | 5 +++++
 kernel/sched/debug.c  | 1 +
 4 files changed, 9 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75abe260de72..927d54b665e6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -327,6 +327,7 @@ extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 extern void hrtick_local_start(u64 delay);
+extern void update_stat_preempt_delayed(struct task_struct *t);
 
 /**
  * struct prev_cputime - snapshot of system and user cputime
@@ -538,6 +539,7 @@ struct sched_statistics {
 	u64				nr_wakeups_affine_attempts;
 	u64				nr_wakeups_passive;
 	u64				nr_wakeups_idle;
+	u64				nr_preempt_delay_granted;
 
 #ifdef CONFIG_SCHED_CORE
 	u64				core_forceidle_sum;
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9f83d47253ce..230cb84036b1 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -451,6 +451,7 @@ bool rseq_delay_resched(void)
 		return false;
 
 	t->rseq_sched_delay = 1;
+	update_stat_preempt_delayed(t);
 
 	return true;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cee50e139723..034c76f0514c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -924,6 +924,11 @@ void hrtick_local_start(u64 delay)
 	rq_unlock(rq, &rf);
 }
 
+void update_stat_preempt_delayed(struct task_struct *t)
+{
+	schedstat_inc(t->stats.nr_preempt_delay_granted);
+}
+
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ef047add7f9e..e160e14b348f 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1213,6 +1213,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P_SCHEDSTAT(nr_wakeups_affine_attempts);
 		P_SCHEDSTAT(nr_wakeups_passive);
 		P_SCHEDSTAT(nr_wakeups_idle);
+		P_SCHEDSTAT(nr_preempt_delay_granted);
 
 		avg_atom = p->se.sum_exec_runtime;
 		if (nr_switches)
-- 
2.43.5


