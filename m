Return-Path: <linux-kernel+bounces-406888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3859C65C3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C140DB3267D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D24C2FB;
	Wed, 13 Nov 2024 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EOWxRHY4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6842594
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456121; cv=none; b=tvQj+fALeqlp9MKgXFlLSPYwOivUEQTB4ck+ty2eBoNfOD2vR3ywfwcG2sfUVvZF9nfBL4zXSss1dYsq3MoWGHQtVOBslFGyj3tpoYRsQJkwWEI1Ei9SZo8UiivnMTj3m9rb9jVTN2LBTdjDMtaGJ5Uga+e4Ocay2T6acBZh6HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456121; c=relaxed/simple;
	bh=TbgoMEuwGi6G4LUaIyabcfrYg0z38clwHZwShAlAZuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+t5Qy0s2XLkTGkw6qpL7YFH7IvocABs/5drPouxgqQmrcMDEUiD1K06k++tm7eHM3MNpzbxRxHA2k/cp1tR0xiIj2Gpyw+wNVQn9VRBCCBsPkVDHy8Mjb30u2i1VbLEWIJBG06vReaHVOR8PDYtTnn3E1eSPLw/j4pBtfZOHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EOWxRHY4; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACN1OpF014771;
	Wed, 13 Nov 2024 00:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=vqZgh
	5sUUyWoAJsJxhJC7O1mO8aLdHp325y5+0SCYio=; b=EOWxRHY4ZSkbJSrXGQ0DA
	HkhbltoQVE16mKRBj3UwMrNuou3m6TMWUpBh++M47svdWaet0YxVY3hiyYsecGDM
	TofI8f/MliOa2HA5s1tZ7N1TgMBIo2AZpuV6oYtwf0Jej4RftbAaYi9leZGf3XWG
	0wJLCSMTPqZ5sNnEkh4/BGlDB26efMm/weRBCyF8Cor6SJMooli5LYEIFwZWrSlF
	sRbOan7KqG0aZ0pWhO2LKjG1Uipq+XnAiOfCqcp0l1IbZHFMKpJFZel4DwYf8gwl
	+AwpWBG2airGmYiIET/f5omMS+An15tJt/JJXLxCLaqjLDQXNi3YBYiihrwubJ5W
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwnq8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 00:01:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMiekd007941;
	Wed, 13 Nov 2024 00:01:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx68uqac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Nov 2024 00:01:42 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AD01bKm011807;
	Wed, 13 Nov 2024 00:01:41 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx68uq2j-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Nov 2024 00:01:41 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, peterz@infradead.org, tglx@linutronix.de,
        daniel.m.jordan@oracle.com, prakash.sangappa@oracle.com
Subject: [RFC PATCH 4/4] Add scheduler preemption delay granted stats
Date: Wed, 13 Nov 2024 00:01:26 +0000
Message-ID: <20241113000126.967713-5-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241113000126.967713-1-prakash.sangappa@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120193
X-Proofpoint-GUID: bz74X_KWIExTMkRz0cGkRtmAcgLpLpH0
X-Proofpoint-ORIG-GUID: bz74X_KWIExTMkRz0cGkRtmAcgLpLpH0

Add scheduler stats to record number of times preemption delay was granted
or denied.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/linux/sched.h |  8 ++++++++
 kernel/sched/core.c   | 12 ++++++++++++
 kernel/sched/debug.c  |  4 ++++
 mm/task_shared.c      |  2 ++
 4 files changed, 26 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b53e7a878a01..e3f5760632f4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -327,6 +327,10 @@ extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 extern void hrtick_local_start(u64 delay);
+#ifdef CONFIG_TASKSHARED
+extern void update_stat_preempt_delayed(struct task_struct *t);
+extern void update_stat_preempt_denied(struct task_struct *t);
+#endif
 
 /**
  * struct prev_cputime - snapshot of system and user cputime
@@ -532,6 +536,10 @@ struct sched_statistics {
 	u64				nr_wakeups_affine_attempts;
 	u64				nr_wakeups_passive;
 	u64				nr_wakeups_idle;
+#ifdef CONFIG_TASKSHARED
+	u64				nr_preempt_delay_granted;
+	u64				nr_preempt_delay_denied;
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 	u64				core_forceidle_sum;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 713c43491403..54fa4b68adaf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -916,6 +916,18 @@ void hrtick_local_start(u64 delay)
 	rq_unlock(rq, &rf);
 }
 
+#ifdef CONFIG_TASKSHARED
+void update_stat_preempt_delayed(struct task_struct *t)
+{
+	schedstat_inc(t->stats.nr_preempt_delay_granted);
+}
+
+void update_stat_preempt_denied(struct task_struct *t)
+{
+	schedstat_inc(t->stats.nr_preempt_delay_denied);
+}
+#endif
+
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4a9fbbe843c0..ace7856f13c3 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1215,6 +1215,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P_SCHEDSTAT(nr_wakeups_affine_attempts);
 		P_SCHEDSTAT(nr_wakeups_passive);
 		P_SCHEDSTAT(nr_wakeups_idle);
+#ifdef CONFIG_TASKSHARED
+		P_SCHEDSTAT(nr_preempt_delay_granted);
+		P_SCHEDSTAT(nr_preempt_delay_denied);
+#endif
 
 		avg_atom = p->se.sum_exec_runtime;
 		if (nr_switches)
diff --git a/mm/task_shared.c b/mm/task_shared.c
index 5b8a068a6b44..35aecc718c8e 100644
--- a/mm/task_shared.c
+++ b/mm/task_shared.c
@@ -285,6 +285,7 @@ bool taskshrd_delay_resched(void)
 			/* not granted */
 			shrdp->kaddr->ts.sched_delay
 				= TASK_PREEMPT_DELAY_DENIED;
+			update_stat_preempt_denied(t);
 		}
 		return false;
 	}
@@ -295,6 +296,7 @@ bool taskshrd_delay_resched(void)
 	/* granted */
 	shrdp->kaddr->ts.sched_delay = TASK_PREEMPT_DELAY_GRANTED;
 	t->taskshrd_sched_delay = 1;
+	update_stat_preempt_delayed(t);
 
 	return true;
 }
-- 
2.43.5


