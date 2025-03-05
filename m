Return-Path: <linux-kernel+bounces-546492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB65A4FB51
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA20E188DBA1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9271C205AB0;
	Wed,  5 Mar 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="evB15Yn1"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C8D86340
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169379; cv=none; b=VF7WfKneNd2NRLSminVyQ4ARHr6M3QMkcFHIjSmWw6eDZfbYZRzvi2QoFn4+2FORU1GO1uxo43qgGIMpaZZfZHDSbDTPzfvxly6XO7dFqDBL2dfqig+6IvQMLLqkkJE/Wh24Pf4d6MWe55MD7SE/PmaRAOCLXifQhLJoYK3xH9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169379; c=relaxed/simple;
	bh=jRDsWGLHPyzD4dJakynyMEsgzpcLHEfSJ3qgCKI7Kqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZ9t7JB19s8WvVzVLrg1iWhpaSlxVsMd8vopyJfQ3Yq6KNaJJuHToPzgGraeewfBBqNhlcLhx8GUXvQFYooBF7WrxNItsGTAFWqMWr1Sryxmm3HaRPN+qrmRPnbOKkNZYibRvzVQ4CleHoRoafCCmtbTsSYRBfRbsds1/4ZUQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=evB15Yn1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52594CAF008577;
	Wed, 5 Mar 2025 10:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uYhz189O/8pxfiPbgZRCulIxKGozZ0nBv2yVMcO7j
	uU=; b=evB15Yn1QI3SD6GkdqQxGYciNf+nraV1h2XM1bR9VKPZA3rKcVr0JKgUj
	/ZS7I5XKxOEU1NbQnQg/zmiUhNzPZA5Ejt4A8OvZtJqeHC5gyfAXr2HfLIpGoEnH
	K9Xao6Dnb4dBhJUEEUutKBrwgWQdt886A1kDTBpvwERReu0UUx7hP2xsboTGHb5M
	I5c2Rl14LVcfbyytR7QXYzLFULuAXLtyZXaFA+O+aPuNUw0kpg7Z9tMdfTcDt1LL
	D6MKiADCAcK+TBKXml/dL6jeWTfr/c/TryVJ4qclLzXJllPGIb7QRYVvXBrMwbuz
	LzvBzDrr7MiyU3x7sNNzvttKggTHA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568ppaue9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 10:09:02 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 525A7IbB031861;
	Wed, 5 Mar 2025 10:09:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568ppaue6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 10:09:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5259HEIC020811;
	Wed, 5 Mar 2025 10:09:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esk1wcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 10:09:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525A8xfJ56099152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 10:08:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 232FD2008D;
	Wed,  5 Mar 2025 10:08:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23F002008C;
	Wed,  5 Mar 2025 10:08:56 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com.com (unknown [9.124.217.27])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 10:08:55 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, riel@surriel.com
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, odin@uged.al,
        linux-kernel@vger.kernel.org, aboorvad@linux.ibm.com
Subject: [PATCH v2] sched/fair: Fix invalid pointer dereference in child_cfs_rq_on_list()
Date: Wed,  5 Mar 2025 15:38:54 +0530
Message-ID: <20250305100854.318599-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: khX0P5shTlI92e3on75lNawtlVq-Y8qV
X-Proofpoint-ORIG-GUID: Ms0GmorFYxJvFSbQCwCbpMOyxSN4e4AG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=634
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050079

In child_cfs_rq_on_list(), leaf_cfs_rq_list.prev is expected to point to
a valid cfs_rq->leaf_cfs_rq_list in the hierarchy. However, in some
cases leaf_cfs_rq_list.prev and rq->tmp_alone_branch can point to the
list head (rq->leaf_cfs_rq_list) instead of another cfs_rq->leaf_cfs_rq_list.

The function does not handle this case, leading to incorrect pointer
calculations and unintended memory accesses, which can result in a kernel
crash.

A recent attempt to reorder fields in struct rq exposed this issue by
modifying memory offsets and affecting how pointer computations are
resolved. While the problem existed before, it was previously masked by
specific field arrangement. The reordering caused erroneous pointer
accesses, leading to a NULL dereference and a crash, as seen in the
following trace:

[    2.152852] Call Trace:
[    2.152855] __update_blocked_fair+0x45c/0x6a0 (unreliable)
[    2.152862] sched_balance_update_blocked_averages+0x11c/0x24c
[    2.152869] sched_balance_softirq+0x60/0x9c
[    2.152876] handle_softirqs+0x148/0x3b4
[    2.152884] do_softirq_own_stack+0x40/0x54
[    2.152891] __irq_exit_rcu+0x18c/0x1b4
[    2.152897] irq_exit+0x20/0x38
[    2.152903] timer_interrupt+0x174/0x30c
[    2.152910] decrementer_common_virt+0x28c/0x290
[    2.059873] systemd[1]: Hostname set to ...
[    2.152682] BUG: Unable to handle kernel data access on read at 0x100000125
[    2.152717] Faulting instruction address: 0xc0000000001c0270
[    2.152724] Oops: Kernel access of bad area, sig: 7 [#1]
..

To fix this, introduce a check to detect when prev points to the list head
(&rq->leaf_cfs_rq_list). If this condition is met, return early to prevent
the use of an invalid prev_cfs_rq.

Fixes: fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added after unthrottling")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef435a7aa..52ac22465a24 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4045,15 +4045,24 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
 {
 	struct cfs_rq *prev_cfs_rq;
 	struct list_head *prev;
+	struct rq *rq;
+
+	rq = rq_of(cfs_rq);
 
 	if (cfs_rq->on_list) {
 		prev = cfs_rq->leaf_cfs_rq_list.prev;
 	} else {
-		struct rq *rq = rq_of(cfs_rq);
-
 		prev = rq->tmp_alone_branch;
 	}
 
+	/*
+	 * Return early if prev points to rq->leaf_cfs_rq_list, the
+	 * list head and not a valid list node, to avoid computing
+	 * an invalid prev_cfs_rq.
+	 */
+	if (prev == &rq->leaf_cfs_rq_list)
+		return false;
+
 	prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
 
 	return (prev_cfs_rq->tg->parent == cfs_rq->tg);
-- 
2.43.5


