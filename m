Return-Path: <linux-kernel+bounces-421919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4799F9D91F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0922A281FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D73191F84;
	Tue, 26 Nov 2024 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J9lRvef6"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385317E473
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603760; cv=none; b=e6KXKWF7Gu95/91HHOBXgC9cUuiPOJ0zdq1ZIKXBmNAb3uU3D41aU4UaPYk9k+AwhpfEiJLnUgSlz9TMzL+z2f7q7aSUN0RnqIBeVCzDNKnzLFlIzAib7OIPgwLd6xlfCSiQHsaWkzo1v9kd3ZMUodXPo3ZEwSCB95nKBYlctuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603760; c=relaxed/simple;
	bh=ZLa0XF6XkGxRwZeEzGmQNAkU/LqzuKfoo/fst6RQ+qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBDjarDrsMLmh08HksnxXMaCiikoksfsOALnP8kX7RrBOFelq6WqZECg/pRo6pWn6ra7AO8tTEYAB3lc8TZOZhDK43AkN9vJj99TFuk115Tx3qjXJ6J8IXJGyQeeW4y2+W+dyy7l6e3ZdUGlCCx3+dEXAILSr25zx1tuKMXStz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J9lRvef6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ4AENC013664;
	Tue, 26 Nov 2024 06:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=s3ZhFNSUl9iqx8+IDDbRDcXBzM+SLQy9siDseX4B1
	AM=; b=J9lRvef6QvZM+AJyKpqnpYC0d7lz5hRbzQJvZAA8A1DaJ9nUqMm2BMeBu
	S9uJaM3Gu4Fg6ZGdjJlSbfJCcpRKXg0Ev9iq0jTILzRvvU9AnfHaJ6UeOxaB6Qim
	mxTyPImVkjI47GbOcA/kRS4BZ2U0tGG+YI7pIZ1zd2KCHpS4Sk8YlAHCzhXUMA/q
	bJNrLmfqufJgmgInlIGe3I6kbJ4vZllLtC7jQ3Aa/7GqyDVPTCHQnX0jLBEynP1W
	gHPTQ9UqyjaMJo4Hp6IDV6qzUNagIXYQ9QBNOD2zsc50pbRT6wjElTc8ZnpjSuDf
	D9xhScSljZlbPBmZFUadrTEiqtY7A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4338d243fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 06:49:05 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AQ6n4lg026768;
	Tue, 26 Nov 2024 06:49:04 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4338d243ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 06:49:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ4i7Or026390;
	Tue, 26 Nov 2024 06:49:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30utht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 06:49:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AQ6n0ZS50987438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 06:49:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70D0320043;
	Tue, 26 Nov 2024 06:49:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7356820040;
	Tue, 26 Nov 2024 06:48:57 +0000 (GMT)
Received: from vishalc-ibm.ibmuc.com (unknown [9.124.220.73])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Nov 2024 06:48:57 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, sshegde@linux.ibm.com,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH] sched/fair: Fix CPU bandwidth limit bypass during CPU hotplug
Date: Tue, 26 Nov 2024 12:18:13 +0530
Message-ID: <20241126064812.809903-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s3i9uyJhOdxb31yaHZoaZ4l5qeCHs6zh
X-Proofpoint-ORIG-GUID: T-cZA_f7CMN4U7vKFlPTykmy9jAy9sXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=865
 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411260051

CPU controller limits are not properly enforced during CPU hotplug operations,
particularly during CPU offline. When a CPU goes offline, throttled
processes are unintentionally being unthrottled across all CPUs in the system,
allowing them to exceed their assigned quota limits.

Assigning 6.25% bandwidth limit to a cgroup in a 8 CPU system, where, workload
is running 8 threads for 20 seconds at 100% CPU utilization,
expected (user+sys) time = 10 seconds.

# cat /sys/fs/cgroup/test/cpu.max
50000 100000

# ./ebizzy -t 8 -S 20        // non-hotplug case
real 20.00 s
user 10.81 s                 // intented behaviour
sys   0.00 s

# ./ebizzy -t 8 -S 20        // hotplug case
real 20.00 s
user 14.43 s                 // Workload is able to run for 14 secs
sys   0.00 s                 // when it should have only run for 10 secs

During CPU hotplug, scheduler domains are rebuilt and cpu_attach_domain
is called for every active CPU to update the root domain. That ends up
calling rq_offline_fair which un-throttles any throttled hierarchies.

Unthrottling should only occur for the CPU being hotplugged to allow its
throttled processes to become runnable and get migrated to other CPUs.

With current patch applied,
# ./ebizzy -t 8 -S 20        // hotplug case
real 21.00 s
user 10.16 s                 // intented behaviour
sys   0.00 s

Note: hotplug operation (online, offline) was performed in while(1) loop

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbdca89c677f..c436e2307e6f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6684,7 +6684,8 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 	list_for_each_entry_rcu(tg, &task_groups, list) {
 		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
 
-		if (!cfs_rq->runtime_enabled)
+		/* Don't unthrottle an active cfs_rq unnecessarily */
+		if (!cfs_rq->runtime_enabled || cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
 			continue;
 
 		/*
-- 
2.47.0


