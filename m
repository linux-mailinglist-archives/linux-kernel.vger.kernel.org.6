Return-Path: <linux-kernel+bounces-561023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5B9A60C91
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7EE7ABEBB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF75199249;
	Fri, 14 Mar 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d/erJjnY"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5640E1C863D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942919; cv=none; b=VUuqu+ZeU2WOKYbEQoyBPLz0qXqlQJr6n78AC4vhjY7Ovy/lZnr2Rxjly89ZEjaCPtNwQEMYcOBOaQCB+OryTk9w9YjwRgKcJu5vPZO9a+wIRZQv2demRw3hHykqEEIrCbKEGtPNc1+SYCQnwE99w5dhKMjYflrrpZIudjBueN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942919; c=relaxed/simple;
	bh=ZPbFUB1aDJ6npqy1n2b2+uJWj6axbYS9pRD44xZR/LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YauXXJhW5YEmkUoL/nJiOHmPphZFI6yWhtgxr817qNORJwOtPbZOSWR66TJOKh943l9hSLClIV84yzjSdqDpy5rr8W5i9eb6VFT7XCmEjSL9J4X79pIrDhpJY7WsvMsx4B+f+EMNFcFD1iWhWbytIxu+xaoIPFchDdlRYVx5H2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d/erJjnY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNPAFv032478;
	Fri, 14 Mar 2025 09:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WC21KT+DF4pH3QGnn6JeBdsbDsjOVK4gG3Eqa2oKs
	Y4=; b=d/erJjnYekX3ZdQo1XEiNXaoL0ReBUYOuxvFzXwNxq0zWi2v62ibPTCJu
	tlDwtGJ9oMSY2E+/4AyosOW36j6m97jai6D7lqFJMLX1GMWdFFuHYwitjoKzgP8V
	zaUpqjAXsORnq+FZkks3ifQboHTVtd6caOLxp47xjDXkQGr3en/OviXtMlwcNrZW
	38ALd5/Xq/MyI5GH3OSZ0dtwec5PjhXZqRpFJtRVfiP6xNDLWmeAw71hZt/L4rJe
	uG+BOcQm5TlqsmTsCdVeYGqVhqwedotnXXm7doux9ig1QUr1wPhhO8KHuFC2uw2u
	iW8vjyaO9eqfe9O99fdgCE1YdXJtQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hptq1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 09:01:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E8vZDg007889;
	Fri, 14 Mar 2025 09:01:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hptq1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 09:01:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E8fD3b026099;
	Fri, 14 Mar 2025 09:01:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspp61w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 09:01:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E91aQU19267926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 09:01:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52B782004D;
	Fri, 14 Mar 2025 09:01:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD3DA20043;
	Fri, 14 Mar 2025 09:01:33 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.in.ibm.com (unknown [9.204.206.228])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 09:01:33 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Adam Li <adamli@os.amperecomputing.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH] sched/fair: Remove stale references to LAST_BUDDY and SKIP_BUDDY
Date: Fri, 14 Mar 2025 14:31:28 +0530
Message-ID: <20250314090128.25141-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BU8BRCeYwFywfFjohn3E9RJqr27HHFsM
X-Proofpoint-ORIG-GUID: aWRHpb_e9z4xAzvMzK6GLLi9nBbXCMos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_03,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=718 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140071

Commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") removed the
functionality associated with LAST_BUDDY and SKIP_BUDDY. However,
some outdated references remained in the comments for pick_next_entity
and check_preempt_wakeup_fair. This commit cleans up those comments
to maintain clarity and correctness.

No functional change intended.

Co-developed-by: Adam Li <adamli@os.amperecomputing.com>
Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 kernel/sched/fair.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9dafb374d76d..379dbcbb24e9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5578,8 +5578,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
  * Pick the next process, keeping these things in mind, in this order:
  * 1) keep things fair between processes/task groups
  * 2) pick the "next" process, since someone really wants that to run
- * 3) pick the "last" process, for cache locality
- * 4) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
 pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
@@ -8780,9 +8778,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 *
 	 * Note: this also catches the edge-case of curr being in a throttled
 	 * group (e.g. via set_curr_task), since update_curr() (in the
-	 * enqueue of curr) will have resulted in resched being set.  This
-	 * prevents us from potentially nominating it as a false LAST_BUDDY
-	 * below.
+	 * enqueue of curr) will have resulted in resched being set.
 	 */
 	if (test_tsk_need_resched(rq->curr))
 		return;
-- 
2.43.5


