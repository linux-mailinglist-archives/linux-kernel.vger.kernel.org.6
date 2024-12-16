Return-Path: <linux-kernel+bounces-447097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647FB9F2D40
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568DC168564
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD60202C2B;
	Mon, 16 Dec 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Iv1NuLx6"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211911FF60E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342376; cv=none; b=uSxUVF7Kv+k0j8XfBWw1JPS/5NoH85ExsPDLbkvXfWtWPotq1RdSmWhT6oTrWVh/jX5U9WXzDaez2N0yf2U3nPjre8Y3Nrw1Jhk5JSak+26+V2Z+mYHHG5PnIDyWyrDdYLXc2JDQnAsxBN5AuhBD8M+qDkmmfgaQ8hLU65Ui3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342376; c=relaxed/simple;
	bh=c7yvDfhv8WcxYFfPe46x6LquIBU7edyOUd9m2GSjlOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtJ8mqWQQnud/GCcX4ebZ2c9marRa/NuzCQHkHShTm2tystu6XyAKjvSLTBsuCy+XRixDuD+EZEzrdiGqFSxdXWP1LMoNnakUz8ZgMW5zcCDy8NF423gljcdieJl4jWwhfIAeHoU9acTyr460fzh6h1hJMgJJ+OaSSmp8Bk6HC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Iv1NuLx6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG3rgn9021225;
	Mon, 16 Dec 2024 09:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ulV4+WgTFr0u8S5OSFAAuFSRsajOC35FB5jApTr74
	Pw=; b=Iv1NuLx6b+hAmrrHHXkH5lDMFPdYtYLulTPHuJezZui7lWI87DlneIBzI
	qNMAf8FW2eKSCcLeOaac04BKJssM++eczTlY+O1moU7dlGTvX/PB1t4dtUre5kDr
	wyAMR00eR/KXsJtAxusjimLp1T7MNHqGnqFjng/o6p8wveh/nIHJB0Cwuu8ybSqS
	yF5Dh+5ZiSeJInrvvRzh41Ru+vfvf5NdwtvDt/Gqh7iMvRLNiiGP0RntEzffXJB/
	Qz5s2APJy7+uhzKaBq+J851dp2zSuPi8mj+5IMDMB/aVfaSDCSvnt/TWUnrv47Dn
	S5spHkwVvU/SSleSYz17Mxcu/XqFg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpgset4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:45:50 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BG9gdEs008750;
	Mon, 16 Dec 2024 09:45:50 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpgset0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:45:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG8QprV029773;
	Mon, 16 Dec 2024 09:45:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbsdhfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:45:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BG9jj5w31523376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:45:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 743BD20043;
	Mon, 16 Dec 2024 09:45:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9548720040;
	Mon, 16 Dec 2024 09:45:41 +0000 (GMT)
Received: from vishalc-ibm.ibmuc.com (unknown [9.124.212.182])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 09:45:41 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, sshegde@linux.ibm.com, srikar@linux.ibm.com,
        vineethr@linux.ibm.com, zhangqiao22@huawei.com,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Samir Mulani <samir@linux.ibm.com>
Subject: [PATCH v5] sched/fair: Fix CPU bandwidth limit bypass during CPU hotplug
Date: Mon, 16 Dec 2024 15:15:10 +0530
Message-ID: <20241216094509.1035255-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -EHadINEpZGe4KWVudO2w2n3Wtnn6INH
X-Proofpoint-ORIG-GUID: fXfu_If-8L93Ou-N1hJWCpUDQ0YfEpaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160079

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
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Zhang Qiao <zhangqiao22@huawei.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Tested-by: Samir Mulani <samir@linux.ibm.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

v4: https://lore.kernel.org/all/20241212043102.584863-2-vishalc@linux.ibm.com
v3: https://lore.kernel.org/all/20241210102346.228663-2-vishalc@linux.ibm.com
v2: https://lore.kernel.org/all/20241207052730.1746380-2-vishalc@linux.ibm.com
v1: https://lore.kernel.org/all/20241126064812.809903-2-vishalc@linux.ibm.com

---
 kernel/sched/fair.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3e9ca38512de..623c828ad3ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6709,6 +6709,10 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
+	/* Do not unthrottle for an active CPU */
+	if (cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
+		return;
+
 	/*
 	 * The rq clock has already been updated in the
 	 * set_rq_offline(), so we should skip updating
@@ -6723,19 +6727,21 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
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
 

base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
-- 
2.47.0


