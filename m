Return-Path: <linux-kernel+bounces-442577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC5F9EDE89
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 05:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7BA188908D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C01515AAC1;
	Thu, 12 Dec 2024 04:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LSFu3eVf"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DEF126BEE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 04:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977937; cv=none; b=DF5wORsuemdy6AEIbK067dLkb9UN8cY4XtSVpj/ozIG7jwqHiBCOS9Ujqu/BpMJeoVU2VBYDe3YJeoFADenyn7uYABQ3SG0TDuC9JnJTWqJtWb6F7sXhHsYKRjn3ARJa7TAlewSha+X864wIs3TUzOAceMxgDCh5aYZ+BFFyYUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977937; c=relaxed/simple;
	bh=URby7mfJDcP+7lz2RH90pZmNTG1vW093r/mkgOUp6bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktF3+y8GWPiDsv2DbiRdGVLkejveL4yRLsKrhdTP5EaoTkbstKK+8oVofk3b9HGAO8/NMgYLz8/MGILHDTfefdoWfR7MkF0whDjwLBOoYVRRLhGZpK5ArNsfSo814uvqWCClRm341CcvaVWlKd5njfQyfw3aIMMei0ZjW+sU9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LSFu3eVf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBK3oPY003595;
	Thu, 12 Dec 2024 04:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=wcJ5tCwTqcRnSPGSXtlsMkfq5/nsemqd8qwLy/zEJ
	co=; b=LSFu3eVfuynNcAcMUEQfqncbEAMKmUyewCFM4THTgxW011dUYInAUeYWC
	ogyICMSsgf0jpYupiExuDzcG3HE3Zp5eduPjKqDx/BurYs7U0dh/QvRysboXmvRA
	b2MAVbPfKkjU1J7we8bK5anGP+XiriG5kpjzy1sd7OQUXgS1wXOObhtxWM93o+yM
	YCgFAblfsgeF4jZkXBQ+Py2+WKL2jPfpsBOTUkT0BchpiUy/F73d3g2ZUC7zeyl7
	UHxkcyQYm+EV/DNM5mFy6YLKISRjrXVXb5eyNuXxxA5g+yH9KIlXdIYw9aznzGNB
	e6ZU6irwk34ON2yP5+IYQKgPU5W0Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xrhyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:31:55 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BC4ReSQ018830;
	Thu, 12 Dec 2024 04:31:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xrhy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:31:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC3449T000358;
	Thu, 12 Dec 2024 04:31:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0pspc2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:31:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BC4VoQP56689104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 04:31:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B45CA2004B;
	Thu, 12 Dec 2024 04:31:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88FF420040;
	Thu, 12 Dec 2024 04:31:47 +0000 (GMT)
Received: from vishalc-ibm.in.ibm.com (unknown [9.109.245.217])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 04:31:47 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, sshegde@linux.ibm.com, srikar@linux.ibm.com,
        vineethr@linux.ibm.com, zhangqiao22@huawei.com,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v4] sched/fair: Fix CPU bandwidth limit bypass during CPU hotplug
Date: Thu, 12 Dec 2024 10:01:03 +0530
Message-ID: <20241212043102.584863-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kNL4rVqqjokZCs9FcNMajhcAP8UVntF1
X-Proofpoint-ORIG-GUID: _K0ikhv4d01Cw9OB11GDZ6b9e46PtleE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120030

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

This also has another symptom, when a CPU goes offline, and if the cfs_rq
is not in throttled state and the runtime_remaining still had plenty
remaining, it gets reset to 1 here, causing the runtime_remaining of
cfs_rq to be quickly depleted.

Note: hotplug operation (online, offline) was performed in while(1) loop

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Suggested-by: Zhang Qiao <zhangqiao22@huawei.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

v3: https://lore.kernel.org/all/20241210102346.228663-2-vishalc@linux.ibm.com
v2: https://lore.kernel.org/all/20241207052730.1746380-2-vishalc@linux.ibm.com
v1: https://lore.kernel.org/all/20241126064812.809903-2-vishalc@linux.ibm.com

---
 kernel/sched/fair.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa0238ee4857..72746e75700c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6679,6 +6679,10 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
+	// Do not unthrottle for an active CPU
+	if (cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
+		return;
+
 	/*
 	 * The rq clock has already been updated in the
 	 * set_rq_offline(), so we should skip updating
@@ -6693,19 +6697,21 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 		if (!cfs_rq->runtime_enabled)
 			continue;
 
-		/*
-		 * clock_task is not advancing so we just need to make sure
-		 * there's some valid quota amount
-		 */
-		cfs_rq->runtime_remaining = 1;
 		/*
 		 * Offline rq is schedulable till CPU is completely disabled
 		 * in take_cpu_down(), so we prevent new cfs throttling here.
 		 */
 		cfs_rq->runtime_enabled = 0;
 
-		if (cfs_rq_throttled(cfs_rq))
-			unthrottle_cfs_rq(cfs_rq);
+		if (!cfs_rq_throttled(cfs_rq))
+			continue;
+
+		/*
+		 * clock_task is not advancing so we just need to make sure
+		 * there's some valid quota amount
+		 */
+		cfs_rq->runtime_remaining = 1;
+		unthrottle_cfs_rq(cfs_rq);
 	}
 	rcu_read_unlock();
 

base-commit: 231825b2e1ff6ba799c5eaf396d3ab2354e37c6b
-- 
2.47.0


