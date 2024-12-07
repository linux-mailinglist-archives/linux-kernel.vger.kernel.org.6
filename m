Return-Path: <linux-kernel+bounces-435895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8D59E7E5A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4916918867A0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC722E859;
	Sat,  7 Dec 2024 05:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m/QTR01R"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1B17E0
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733549439; cv=none; b=RLnUsKQesNZTQsNl2xOQRni/wjH8GBbhti3wAA/kZUCEDyu3s4DlVC4+1bdbxAimRkQc3VdnyEC9QIooO6iwoTKOlBy1QKctiLQdLtVrLfefJ9J1Fr0nI3a3U86EFTfTDfe04GKODwOvnZWmFxOzanx6it50UkJNyIIaEx+ME9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733549439; c=relaxed/simple;
	bh=1zA9ZvOYxIfK0B2uAwGPnyR4+MbhH3GfBOS3nxBFGk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4jyrA/5ksicznNp571snfzi7LAs/Q/u6fe8dBrOr5lQS8WBstcP3NRfRK0XbiqnCsiROjKjwxPD8mFa+M+aH/riTWYzGGem/CeJAud/xO3fM5iVCC6x9c0/kNUnO0AiP/eFdoHBnPXpNNG/t2/N95ox82fViHpCXm9GP6wX/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m/QTR01R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B74U6Sd002895;
	Sat, 7 Dec 2024 05:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+5WzM4oWnnyGh/hnqsQGagQPt6MNZooewr5cO9Gfj
	Vo=; b=m/QTR01RkDcEWTFLg1yM/K/GBu03Rk51QFai+3M25snWh9oPd+j7CfsKb
	a2v5xoz28WzIOrcT/Swue7ANFby1hq7oLm+X/wwNZZ8LM2bHAT3VR889LX4Ry9f9
	f52HgfV1kx6z0PXuQFkbkeFOwJmzV0PmYoM8twjqDNOGYXsu/aja8hnb5t2umIgN
	U50FqBrHCr3IlBzkmFTFYTvWcxIFAYae0dGWCGg62zXbiAMN/9mn3KuCL+MNvNff
	cR0f73HUx8uZh7UxN6Bwb+o1yy3riUekkEyLoE+auFNCCAUhQemRFZQ7tprsjlf/
	q+nyvyeFF3KgOkD7gefj0mVM7FrdQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv88d5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Dec 2024 05:29:57 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B75RYlo018828;
	Sat, 7 Dec 2024 05:29:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv88d5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Dec 2024 05:29:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B716Urf005580;
	Sat, 7 Dec 2024 05:29:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43a2ky0u9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Dec 2024 05:29:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B75Tp0T56295754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 7 Dec 2024 05:29:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5301E20043;
	Sat,  7 Dec 2024 05:29:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F05420040;
	Sat,  7 Dec 2024 05:29:45 +0000 (GMT)
Received: from vishalc-ibm.ibmuc.com (unknown [9.39.29.4])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  7 Dec 2024 05:29:45 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, sshegde@linux.ibm.com, srikar@linux.ibm.com,
        vineethr@linux.ibm.com, Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v2]  sched/fair: Fix CPU bandwidth limit bypass during CPU hotplug
Date: Sat,  7 Dec 2024 10:57:31 +0530
Message-ID: <20241207052730.1746380-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jdFrmBetBUDrgdXj0jJOk4P6nk_DWxhV
X-Proofpoint-ORIG-GUID: h8TVJEYjNjILUXLFbgHRVXCgxF1UxgHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=840
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412070043

CPU controller limits are not properly enforced during CPU hotplug
operations, particularly during CPU offline. When a CPU goes offline,
throttled processes are unintentionally being unthrottled across all CPUs
in the system, allowing them to exceed their assigned quota limits.

Consider below for an example,

Assigning 6.25% bandwidth limit to a cgroup
in a 8 CPU system, where, workload is running 8 threads for 20 seconds at
100% CPU utilization, expected (user+sys) time = 10 seconds.

$ cat /sys/fs/cgroup/test/cpu.max
50000 100000

$ ./ebizzy -t 8 -S 20        // non-hotplug case
real 20.00 s
user 10.81 s                 // intended behaviour
sys   0.00 s

$ ./ebizzy -t 8 -S 20        // hotplug case
real 20.00 s
user 14.43 s                 // Workload is able to run for 14 secs
sys   0.00 s                 // when it should have only run for 10 secs

During CPU hotplug, scheduler domains are rebuilt and cpu_attach_domain
is called for every active CPU to update the root domain. That ends up
calling rq_offline_fair which un-throttles any throttled hierarchies.

Unthrottling should only occur for the CPU being hotplugged to allow its
throttled processes to become runnable and get migrated to other CPUs.

With current patch applied,
$ ./ebizzy -t 8 -S 20        // hotplug case
real 21.00 s
user 10.16 s                 // intended behaviour
sys   0.00 s

Note: hotplug operation (online, offline) was performed in while(1) loop
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

v1: https://lore.kernel.org/all/20241126064812.809903-2-vishalc@linux.ibm.com

---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbdca89c677f..e28a8e056ebf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6684,7 +6684,8 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 	list_for_each_entry_rcu(tg, &task_groups, list) {
 		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
 
-		if (!cfs_rq->runtime_enabled)
+		/* Only unthrottle the CPU being hotplugged */
+		if (!cfs_rq->runtime_enabled || cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
 			continue;
 
 		/*
-- 
2.47.0


