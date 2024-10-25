Return-Path: <linux-kernel+bounces-382442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EE79B0DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666A01C230A1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C281120D4E3;
	Fri, 25 Oct 2024 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RziIvO6r"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA66820102B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882255; cv=none; b=BZ+riuuX/6Ni9GPooxlbCtkZOv4wKMJ2sFBgyAknawYlgYmBQnf/yNjc5bKfy7hFZUx+r2EoFTHICiUtBIoq/twl4zTZb5GxVbR8swT9az6bP7A2e+K5HmdupZt+ldfhS3p0EBYwQBDKko+VLZ/S2NNUX2nJJrm9Iy8ZtxcRzDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882255; c=relaxed/simple;
	bh=8hAABrJJbWqvYw02eph31ohO20CW5zw9K7omo5B2fTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myYlDAB3eb25VT4j18Nyn/6QSfJqlsJt6mtB5vfFM+r7dX7OZ2iz9bQlSEIQ0yprugJ7YAcDLecAxrEC+6T7ssotF9fm++RW1Pf8qBkjkBucbh7sFX/bSYxZEbPaHtoGTj9LlsacjdB2E+KwrdCPMVcKoMDHCw8UtGBkrEcrNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RziIvO6r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBn6Ma012483;
	Fri, 25 Oct 2024 18:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TdMxc7kprPO6fqOE3CsuTjKAoauA/lGiHfNLxz2/r
	b4=; b=RziIvO6r2SZuvdJ0a8pCgI+K6kUGwapE1uDpCYJ/84nCpMAObh5YG9oRe
	huqHcV4o+2cG4AGLE85NnTLz1R0GIislVuW4INioJRUyCYcp/aghDlk4OMgwa2mq
	HcrSPB4s1IpTBSRCjpyk0pe+1L7RypycJE1cQsHcLCbQ/9Qcbnk7nVLzvwBwI0P6
	+eE3xCD74aMuXnnmd5YLjwT9mMUtt0NgFhzc6D4xza9AuXRcUb6TwmlvXjIWxaGg
	XFxwufoKr7BM8BjPHEBDQpKuWK3ZYu/PA/XNixwvWohFVeEyKjtqVFlyufJZUSvV
	zTwDRSVbHojyafBR7bMH1JFgLGdfg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fbw4a15b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 18:50:29 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49PIkd5q001307;
	Fri, 25 Oct 2024 18:50:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fbw4a157-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 18:50:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49PHnGmT008816;
	Fri, 25 Oct 2024 18:50:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkay7h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 18:50:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49PIoQvc58655206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 18:50:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8A1720043;
	Fri, 25 Oct 2024 18:50:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71AEF20040;
	Fri, 25 Oct 2024 18:50:24 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com.com (unknown [9.179.0.227])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Oct 2024 18:50:24 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: peterz@infradead.org, tj@kernel.org, void@manifault.com,
        vincent.guittot@linaro.org, juri.lelli@redhat.com, mingo@redhat.com
Cc: bsegall@google.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vschneid@redhat.com, mgorman@suse.de, aboorvad@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched: Pass correct scheduling policy to __setscheduler_class
Date: Sat, 26 Oct 2024 00:20:20 +0530
Message-ID: <20241025185020.277143-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ulTrUVlY1bVKK5AotPLRwcxAXkVuaiG6
X-Proofpoint-GUID: r-eG7QFE70p2UPZxAUjG8a7DxiJpAcGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250144

The function __setscheduler_class determines the appropriate
sched_class based on the scheduling policy and priority. Previously,
the function used the task's pointer to retrieve the scheduling policy,
which could lead to incorrect decisions if the task's struct had an
outdated policy. This behaviour where the task pointer may reference an
outdated policy when __setscheduler_class is called, was introduced in
commit 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")

To resolve this, corresponding scheduling policy is passed directly
to __setscheduler_class instead of relying on the task pointer's cached
policy. This ensures that the correct policy is always used when
determining the scheduling class.

-------------------------------------------------------
Before Patch:
-------------------------------------------------------

```
sched_ext # ./runner -t init_enable_count
===== START =====
TEST: init_enable_count
DESCRIPTION: Verify we do the correct amount of counting of init,
             enable, etc callbacks.
OUTPUT:
ERR: init_enable_count.c:132
Expected skel->bss->enable_cnt == num_children (3 == 5)
not ok 1 init_enable_count #
=====  END  =====

=============================

RESULTS:

PASSED:  0
SKIPPED: 0
FAILED:  1
```
-------------------------------------------------------
After Patch:
-------------------------------------------------------

```
sched-ext # ./runner -t init_enable_count
===== START =====
TEST: init_enable_count
DESCRIPTION: Verify we do the correct amount of counting of init,
             enable, etc callbacks.
OUTPUT:
ok 1 init_enable_count #
=====  END  =====

=============================

RESULTS:

PASSED:  1
SKIPPED: 0
FAILED:  0
```

Fixes: 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 kernel/sched/core.c     | 8 ++++----
 kernel/sched/ext.c      | 8 ++++----
 kernel/sched/ext.h      | 2 +-
 kernel/sched/sched.h    | 2 +-
 kernel/sched/syscalls.c | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dbfb5717d6af..719e0ed1e976 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4711,7 +4711,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	if (rt_prio(p->prio)) {
 		p->sched_class = &rt_sched_class;
 #ifdef CONFIG_SCHED_CLASS_EXT
-	} else if (task_should_scx(p)) {
+	} else if (task_should_scx(p->policy)) {
 		p->sched_class = &ext_sched_class;
 #endif
 	} else {
@@ -7025,7 +7025,7 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
-const struct sched_class *__setscheduler_class(struct task_struct *p, int prio)
+const struct sched_class *__setscheduler_class(int policy, int prio)
 {
 	if (dl_prio(prio))
 		return &dl_sched_class;
@@ -7034,7 +7034,7 @@ const struct sched_class *__setscheduler_class(struct task_struct *p, int prio)
 		return &rt_sched_class;
 
 #ifdef CONFIG_SCHED_CLASS_EXT
-	if (task_should_scx(p))
+	if (task_should_scx(policy))
 		return &ext_sched_class;
 #endif
 
@@ -7142,7 +7142,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		queue_flag &= ~DEQUEUE_MOVE;
 
 	prev_class = p->sched_class;
-	next_class = __setscheduler_class(p, prio);
+	next_class = __setscheduler_class(p->policy, prio);
 
 	if (prev_class != next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5900b06fd036..40bdfe84e4f0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4256,14 +4256,14 @@ static const struct kset_uevent_ops scx_uevent_ops = {
  * Used by sched_fork() and __setscheduler_prio() to pick the matching
  * sched_class. dl/rt are already handled.
  */
-bool task_should_scx(struct task_struct *p)
+bool task_should_scx(int policy)
 {
 	if (!scx_enabled() ||
 	    unlikely(scx_ops_enable_state() == SCX_OPS_DISABLING))
 		return false;
 	if (READ_ONCE(scx_switching_all))
 		return true;
-	return p->policy == SCHED_EXT;
+	return policy == SCHED_EXT;
 }
 
 /**
@@ -4493,7 +4493,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
-		p->sched_class = __setscheduler_class(p, p->prio);
+		p->sched_class = __setscheduler_class(p->policy, p->prio);
 		check_class_changing(task_rq(p), p, old_class);
 
 		sched_enq_and_set_task(&ctx);
@@ -5204,7 +5204,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
 		p->scx.slice = SCX_SLICE_DFL;
-		p->sched_class = __setscheduler_class(p, p->prio);
+		p->sched_class = __setscheduler_class(p->policy, p->prio);
 		check_class_changing(task_rq(p), p, old_class);
 
 		sched_enq_and_set_task(&ctx);
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 246019519231..b1675bb59fc4 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -18,7 +18,7 @@ bool scx_can_stop_tick(struct rq *rq);
 void scx_rq_activate(struct rq *rq);
 void scx_rq_deactivate(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
-bool task_should_scx(struct task_struct *p);
+bool task_should_scx(int policy);
 void init_sched_ext_class(void);
 
 static inline u32 scx_cpuperf_target(s32 cpu)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 081519ffab46..29180ae51e54 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3800,7 +3800,7 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 
 extern int __sched_setscheduler(struct task_struct *p, const struct sched_attr *attr, bool user, bool pi);
 extern int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
-extern const struct sched_class *__setscheduler_class(struct task_struct *p, int prio);
+extern const struct sched_class *__setscheduler_class(int policy, int prio);
 extern void set_load_weight(struct task_struct *p, bool update_load);
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
 extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 0470bcc3d204..24f9f90b6574 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -707,7 +707,7 @@ int __sched_setscheduler(struct task_struct *p,
 	}
 
 	prev_class = p->sched_class;
-	next_class = __setscheduler_class(p, newprio);
+	next_class = __setscheduler_class(policy, newprio);
 
 	if (prev_class != next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
-- 
2.25.1


