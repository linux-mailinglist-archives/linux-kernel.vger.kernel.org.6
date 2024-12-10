Return-Path: <linux-kernel+bounces-439346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F168D9EADF6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B65D166835
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B841DC980;
	Tue, 10 Dec 2024 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NY03qHpU"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D4199E9D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826449; cv=none; b=q9e+x6KuKwgSOgBnPFTogTMXcn1rvE4CrOqV3dI65b90seVPc9unDNhj3TBIq5KWy2UwtAzdLUZs9ZlSIxypY0SfOrxQU0HtLFKCx5MbsvgVeG81UdGKjXkPmcpEFBB5Sck12yxX+makoA23Qeu4ofYWsaF0h9sQCTxjV3JaeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826449; c=relaxed/simple;
	bh=KB/vBElXgriDeXyPciNvNswdRorF0ygL8484p+4wH60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPzbnGo75IWxJg+f9XPqT9IkSjFhsxz1fZL07uqBv4d6xFRXc9XIibnOph/dubQugdcm5Q7+8N730aYdHTYHE7PazQULrCIBN7+K8Rv/XP3yHh1muLTUqndGx4O1jATPVjz05OXYV1Lb9DRdAQFeI1sPZ6X+tUwA4YgmUrfGx6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NY03qHpU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA9NRAP002320;
	Tue, 10 Dec 2024 10:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XPE+oKYcd6mroS0271E+I8PTBAWUdVMaMrEyTxE9s
	BM=; b=NY03qHpUpRGngU4PB4oOQswM7iklPqI5z5lGT0SMWMCX/F2WvbwFh7Ep3
	MmAu/vWfFxchXrFhUEsrLxws4Ltx+kSagIvOw1mawIWBlUR9F5dOBRTEvshwt/0d
	JnOnW+dVVRHsOo8AnTkCl9TG9FGPFYBBFBgB/YlbSLOZR8IUS3rls2J9cJqnwTGR
	2AXZyLy0aBe8yV7XUzrLVYuqBar795hhztwGFBmqfz2Hxsixq+ZfbQdBV89/tHkV
	pF5/c5o0ddHoofqwmNjE2fqZYEmr2WCwbqMB3yiEpLzpK/TA/EWKoP07vDqkpiyU
	7RTmbvD6Z44RfqKpimAYfCdAzsZSg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vpexu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 10:27:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BAALvoP023283;
	Tue, 10 Dec 2024 10:27:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vpexr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 10:27:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA6WTYk032739;
	Tue, 10 Dec 2024 10:27:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0psbbxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 10:27:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BAAR8sx37421384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 10:27:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE84C2004F;
	Tue, 10 Dec 2024 10:27:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F57C2004E;
	Tue, 10 Dec 2024 10:27:04 +0000 (GMT)
Received: from vishalc-ibm.ibmuc.com (unknown [9.124.213.186])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 10:27:04 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, sshegde@linux.ibm.com, srikar@linux.ibm.com,
        vineethr@linux.ibm.com, zhangqiao22@huawei.com,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v3] sched/fair: Fix CPU bandwidth limit bypass during CPU hotplug
Date: Tue, 10 Dec 2024 15:53:47 +0530
Message-ID: <20241210102346.228663-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rBqkD5h-glBBktZIAV6vXMoaqprft1Jt
X-Proofpoint-ORIG-GUID: UQxk-uD79d-tRXvUhGAddsEplSDloUr-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100074

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

v2: https://lore.kernel.org/all/20241207052730.1746380-2-vishalc@linux.ibm.com
v1: https://lore.kernel.org/all/20241126064812.809903-2-vishalc@linux.ibm.com
---
 kernel/sched/fair.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa0238ee4857..2faf7dff2bc8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6687,25 +6687,30 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 	rq_clock_start_loop_update(rq);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(tg, &task_groups, list) {
-		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+	/* Traverse the thread group list only for inactive rq */
+	if (!cpumask_test_cpu(cpu_of(rq), cpu_active_mask)) {
+		list_for_each_entry_rcu(tg, &task_groups, list) {
+			struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
 
-		if (!cfs_rq->runtime_enabled)
-			continue;
+			if (!cfs_rq->runtime_enabled)
+				continue;
 
-		/*
-		 * clock_task is not advancing so we just need to make sure
-		 * there's some valid quota amount
-		 */
-		cfs_rq->runtime_remaining = 1;
-		/*
-		 * Offline rq is schedulable till CPU is completely disabled
-		 * in take_cpu_down(), so we prevent new cfs throttling here.
-		 */
-		cfs_rq->runtime_enabled = 0;
+			/*
+			 * Offline rq is schedulable till CPU is completely disabled
+			 * in take_cpu_down(), so we prevent new cfs throttling here.
+			 */
+			cfs_rq->runtime_enabled = 0;
 
-		if (cfs_rq_throttled(cfs_rq))
+			if (!cfs_rq_throttled(cfs_rq))
+				continue;
+
+			/*
+			 * clock_task is not advancing so we just need to make sure
+			 * there's some valid quota amount
+			 */
+			cfs_rq->runtime_remaining = 1;
 			unthrottle_cfs_rq(cfs_rq);
+		}
 	}
 	rcu_read_unlock();
 
-- 
2.47.0


