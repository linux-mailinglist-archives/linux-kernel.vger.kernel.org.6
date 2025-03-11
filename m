Return-Path: <linux-kernel+bounces-556470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C16A5CA39
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E550B1891B05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B325F7AF;
	Tue, 11 Mar 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fz8mnSdg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1DD25E825
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709113; cv=none; b=GBV6FMalQHbUtFAbvvX4FPKP8FQSmFs7mt80S+CiWt6nx52wfSwXeguXv3vQPUz6k6k0M0rICYo/667XXmiwIwvi6SKGQAwIIvAqiUoOkeu0ocnZxgzCmkKjVecAb+qfi7OrU7E8GcIk+oq8nrxZF58v8iKGC76AJjR6RmnHzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709113; c=relaxed/simple;
	bh=9KteNSzAS1N3Pma9R02pDnV5Tm5gRtcl9mbvLt8kRoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TW27DJdDZafW2TWWnMNzAH+jhtttn+cBw5to2zTmxC5wtdn1mLvapIFfNFMXT/yz7VRXQUf+VClnbM9kksXdUkF6iramJxewogzJXUg4/uXNhrg8KasCgnDw07+QKDuYpfHUQGGuJRXZMEUakXhqx4Zc7QJ4qE5wRwrLwDXy4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fz8mnSdg; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDMuTj014977;
	Tue, 11 Mar 2025 16:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=GZv4NKpKq6BV0CxDnpfqod0P9ROQ2
	0QorA9AAMbCOLI=; b=fz8mnSdgADOXO/ZuKtw3cAbNJxdvKPWWqbCVJoR9nh8MZ
	7JzG20vG8lrGI12WSmg7s8ccbfFrJWlCpWIgueX8yM418kx+QjXb+Zw3unFZghqT
	A4OLZCfp8dwXE0wgG81r7tv6fdZd6teOsCQ9akD/ghm9e6PHPIBtJH99ps7A8ZmQ
	DnQrIvykHmg1UfEBM6XXvqgydwITSQQfFHVjLR+0ojofYhuccFTqPxMlChOYCbNN
	/Q+QMWghfsmAMRB6ZocSN8B6sUCANK98jPJxb1Q9VXugXqpB0O1GFOPD2WnxYHYY
	vUMVumJj9tNJetsVguDpwe7BSAr1H1RyNsOlJMMmQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ctb5a31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 16:04:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BEeXO0030680;
	Tue, 11 Mar 2025 16:04:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcnke17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 16:04:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52BFxxkI039494;
	Tue, 11 Mar 2025 16:04:49 GMT
Received: from clb-2-bm-ad2.osdevelopmeniad.oraclevcn.com (clb-2-bm-ad2.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 458gcnkdyj-1;
	Tue, 11 Mar 2025 16:04:49 +0000
From: Libo Chen <libo.chen@oracle.com>
To: peterz@infradead.org, mgorman@techsingularity.net
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tj@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        akpm@linux-foundation.org, longman@redhat.com,
        lorenzo.stoakes@oracle.com
Subject: [PATCH] sched/numa: skip VMA scanning on memory pinned to one NUMA node via cpuset.mems
Date: Tue, 11 Mar 2025 09:04:47 -0700
Message-ID: <20250311160447.2813222-1-libo.chen@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110102
X-Proofpoint-GUID: 0awqwil2ToVXPCQSpAGhyf95dP3wGZP0
X-Proofpoint-ORIG-GUID: 0awqwil2ToVXPCQSpAGhyf95dP3wGZP0

When the memory of the current task is pinned to one NUMA node by cgroup,
there is no point in continuing the rest of VMA scanning and hinting page
faults as they will just be overhead. With this change, there will be no
more unnecessary PTE updates or page faults in this scenario.

Signed-off-by: Libo Chen <libo.chen@oracle.com>
---
 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c798d27952431..ec4749a7be33a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3315,6 +3315,13 @@ static void task_numa_work(struct callback_head *work)
 	if (p->flags & PF_EXITING)
 		return;
 
+	/*
+	 * Memory is pinned to only one NUMA node via cpuset.mems, naturally
+	 * no page can be migrated.
+	 */
+	if (nodes_weight(cpuset_current_mems_allowed) == 1)
+		return;
+
 	if (!mm->numa_next_scan) {
 		mm->numa_next_scan = now +
 			msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
-- 
2.43.5


