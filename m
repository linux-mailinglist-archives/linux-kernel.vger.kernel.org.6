Return-Path: <linux-kernel+bounces-545088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B7AA4E8BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677F57AA8B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025FE280CC1;
	Tue,  4 Mar 2025 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b8YwQbcw"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF992512F9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107656; cv=none; b=JV18/SBdHAzdku1wliwiyuc4519/uIdqT5mEmVnRezkBrak4HLKbL1f2sWPXn+Y5kxnRPwwi6O05Yjm742yaOaK8VtyjEq3elifR0INzHUwF8z1ecmv4vwHe+QyRn8tvqL6rkAxWJY5qbKO7P3IO8Gog8Or0T3+rlWIYY2sXvy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107656; c=relaxed/simple;
	bh=j9SCKW2LGg5Re5BYb5IhFyKIVKbLI4c9Bb5/Yb45mJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CLTCo01fGp/iZzzorBaSFkIhQogyLQZq/jbVOIwHvpG+AmQwdq5eEDlYZeZo0Bct9stSK347m2lmXpWhpz5P83lOqDqFDn6zjlhRfZBjl1AKT+jNalM/vG7b00ndIRtNg8wHhh4rejftW8si6POeT9IBrpW1aH4OW0YbPzCGwQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b8YwQbcw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524ERac7021572;
	Tue, 4 Mar 2025 17:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vYBlr1yOdsZTrIvHZP2kD050kBqaPLdQ06HNcLLnz
	SA=; b=b8YwQbcwFEPzBX7WK4wvE4i5boXdTiasBUJ3/hFkRjuv6NfBJLKnRwLl7
	Q/uQNxzfr/UxTaaPPrUFFi3OeO+tOywEO3Z5oDLY/Ssijel7474bmSrSypzc6/3L
	MYL2PkAJmkRabJjJCON0IPIQz03RC0MAU92mtMkCzRXTG+waXAMvQhnp5QWG10Ht
	Pg0KGSyKKnIKkxZq4ppdVDGZ1h72f89vYO0+zEDrlOp8e49GTkUCGAHpZOg1dQ8n
	y+C0bP3A3b1kbVQVCg+5qwwt1jAYiqxahWvl0/yAwh9/qj4zvEhuGnkUTLQutxyP
	sOid4hV43vCqIQYNIGk3rf4e4hE9Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455sw7kqww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:00:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 524GvKdX008706;
	Tue, 4 Mar 2025 17:00:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455sw7kqwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:00:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524FP4VO020936;
	Tue, 4 Mar 2025 17:00:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djneefj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:00:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524H0C8k32112950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:00:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DDA62004D;
	Tue,  4 Mar 2025 17:00:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E72DD20043;
	Tue,  4 Mar 2025 17:00:08 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com.com (unknown [9.124.216.210])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 17:00:08 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, riel@surriel.com
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, odin@uged.al,
        linux-kernel@vger.kernel.org, aboorvad@linux.ibm.com
Subject: [PATCH 1/1] sched/fair: Fix invalid pointer dereference in child_cfs_rq_on_list()
Date: Tue,  4 Mar 2025 22:30:07 +0530
Message-ID: <20250304170007.245261-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UdIElj5Muh3b3mLc-AGWl1p7jJtoI-97
X-Proofpoint-GUID: Nh5Wd0B9hdIs5PJf8NBdmMfdPjocepcP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=464 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040136

In child_cfs_rq_on_list(), leaf_cfs_rq_list.prev is expected to point to
a valid cfs_rq->leaf_cfs_rq_list in the hierarchy. However, when accessed
from the first node in a list, leaf_cfs_rq_list.prev can incorrectly point
back to the list head (rq->leaf_cfs_rq_list) instead of another
cfs_rq->leaf_cfs_rq_list.

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
 kernel/sched/fair.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef435a7aa..a4daa7a9af0b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4045,12 +4045,15 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
 {
 	struct cfs_rq *prev_cfs_rq;
 	struct list_head *prev;
+	struct rq *rq;
+
+	rq = rq_of(cfs_rq);
 
 	if (cfs_rq->on_list) {
 		prev = cfs_rq->leaf_cfs_rq_list.prev;
+		if (prev == &rq->leaf_cfs_rq_list)
+			return false;
 	} else {
-		struct rq *rq = rq_of(cfs_rq);
-
 		prev = rq->tmp_alone_branch;
 	}
 
-- 
2.43.5


