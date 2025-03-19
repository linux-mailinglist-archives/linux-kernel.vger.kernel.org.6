Return-Path: <linux-kernel+bounces-568706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43044A69999
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B7E8A3664
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E2B2147F5;
	Wed, 19 Mar 2025 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QFBJeEhH"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02759214A9E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412797; cv=fail; b=q9sSEHsUIBWVeK9/M274Rek1lHL8iAF5n2hL/nCRFP+ZtzAzTHOxdSMlu/sAtB1pT6CS6+V+fP04bUG+DG71MW4ABn48FV/UvzgwUfesQ7/YatDXlTh151fWDNHclbkh5oB9C8ObhwY/mmrdeoZn0Wo98Cj9RbkDvpYteIjv+zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412797; c=relaxed/simple;
	bh=iLZh5xxDHXbPPPGG5TtdGuIpB+Px9YVtKEdylvQm7Z0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5TkjHIvcBul5/qLcUNWZqEoHo3rPUEQet6dEUICXQX1VOM3NFp6/nCSPDijItq8VofYAOZFky6UaLHHsLELH1fdqDcgy4DKMTX3B90y8Bqh63Qrf3T2SgcyAuN8YunTqskpFnrGYYXGAE+Q+e0p41FpAul6LDxV2apksjCjybE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QFBJeEhH; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TN3lCGAF5u8M5d6j/wPcIe6UjgTbf7gbVirJ3yFuPlpTvr37+duBAwsAhOy0A00oSigtCjG1PdT7VyH/0cBYRSaEdKjk8exwQpCBJJFxKKeWdUduIuNE4t2wJUZhb70C6tOtXUk+kx/8OSmWQt5rMfXZv6Xseo9pK6VVeNeSg0318QnNRPi4wxxw32jDBGtNvPNrde1gF+yPau0kQlLd+p01s3P3X9wuQ27yhtvtvnQZ2VbzSZ1fl+/7wxEdKQnFWkZT/7Bhwgdw3tcARlKlP9Jlb5HitiZ0IVejIw41dQrzl2by3f/BFnSQUzoajBkJISKDKbqHGX8aIrBqI49m/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krPBi94jIB/Baadfzed9TBHF0/sXB2vjDdvQbhvxMPQ=;
 b=jngXRrtDe8q9SGFkMpeyt0zkbPP7kzd0tMEMlyUunPcdyBJZcBrk8xMNXXMLLAF7CSEl2OJWviz5iVXIwik+7zJcZbC1v9HjZuwEYtU5QK0NzIo11OIUuWovEfajYqQR8upVtjFcwvDU8grTMEmF4SfOlWYln/IBNtEvgUF7bcvqFeklPNCUOVlN3nBvqnmH1XCjKRVXkRRvFycq3T1hj8I5B9b4SF+nmLorzEDKLHzi9FvvnFZnPryyrm8Un2YCd3CLDFsKayFSqOLQk7dMtHHuXYDf2vHbx+AwtOv2d3rTzEQ97+WTcYI5aOPT5IS7w8hp0Ggzbc6o2UAgs66FYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krPBi94jIB/Baadfzed9TBHF0/sXB2vjDdvQbhvxMPQ=;
 b=QFBJeEhHLhhXvWKPNvlPnlh6M71JbF76bfBmp1k45jZzMn2x5SOqHdkTxr39C3poXbTuOqE0gUqePuaJg3yAXsDLJS/1F+8dZdjeQz7RP99+ztdjA3SJwWqcJKrVJ5hNOgnn9pUg7K8AydC0W4027/KbfQzZTI4HoyF9fv0+rKw=
Received: from SN7PR04CA0018.namprd04.prod.outlook.com (2603:10b6:806:f2::23)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:33:11 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::22) by SN7PR04CA0018.outlook.office365.com
 (2603:10b6:806:f2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:33:10 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:33:01 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Michael.Day@amd.com>, <akpm@linux-foundation.org>, <bharata@amd.com>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dongjoo.linux.dev@gmail.com>,
	<feng.tang@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<honggyu.kim@sk.com>, <hughd@google.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <kbusch@meta.com>,
	<kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>, <leillc@google.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<nadav.amit@gmail.com>, <nphamcs@gmail.com>, <peterz@infradead.org>,
	<riel@surriel.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<santosh.shukla@amd.com>, <shivankg@amd.com>, <shy828301@gmail.com>,
	<sj@kernel.org>, <vbabka@suse.cz>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: [RFC PATCH V1 13/13] prctl: Introduce new prctl to control scanning
Date: Wed, 19 Mar 2025 19:30:28 +0000
Message-ID: <20250319193028.29514-14-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319193028.29514-1-raghavendra.kt@amd.com>
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbe0152-2683-452a-ef4b-08dd671ce250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SX9G7uYor+8ZG/8teWgp8/APefddEfHP2qYFZRz/ZQ/7AlQvE2pt2uXS4aD/?=
 =?us-ascii?Q?4+F7a26mAcztlNXxfyKd6/UTY1YSJsNRyZ+HMZRBDB2YiyBGVH8VXo6KUSvq?=
 =?us-ascii?Q?2YPowAeK5jn9QG4jAz752YBYz3Oyrbysl5EeYOQY0f4AltB3mVNDeUGvDRaw?=
 =?us-ascii?Q?aVOAmSu81naqE4/ThJSw0wTOrEcO2PGRZ91SODg6Rrjo0zViom2te/F7us51?=
 =?us-ascii?Q?+tCJSdWlBNMhDOw+zKm9MvaAtgtDp/KAwAwiG2jZI0jLphXvb4ptdvuQIdwz?=
 =?us-ascii?Q?3cD++R9VLlXWpvbcFt+Bvfz4/N6Bbmkv4ji7/n7+xrfz3RTkjVng4eyN2Amc?=
 =?us-ascii?Q?vdXgGacy89uOOX5PPZ4w0L7ubROVKVVZl2k/U/7Zr8OjCBlnh5inyoFI/Di0?=
 =?us-ascii?Q?nwI7c0tzwH3zI0DAFocWJwPY0wzFieSAkrODMWFfp6DhRMS5OI8YsfC+smPM?=
 =?us-ascii?Q?HgmRhtU4/xomLtAYBmqxX976AGM/y9qj7uYW16sAbC7zby/zHIiK0RluzhA0?=
 =?us-ascii?Q?p7QLT/7wIPVWn4K50VXw2xopP3noPnyFdhKpxY9bPtx/odUKCJJ4Mp3oCWJO?=
 =?us-ascii?Q?XhZA0aIjkXaaWRDKB5lUoKqtin8i3F4IpJsrFlqDRCSP6Gv8h1EJRVNCghB1?=
 =?us-ascii?Q?4IStbbolPHn9ebuLDI+hp56c/ifrXRfgvHCQApPmq2bDYSfpih5VGm3qrnl1?=
 =?us-ascii?Q?h+X3M4F3olD9UWv3zCDLOJksydmo7THiKy+rnkQegI27+WABQDbtb5/zo3Ey?=
 =?us-ascii?Q?1eyj53C+ImlcURKJtDTQDNQ5V6OlpE0Y7WNNNVPbcTRwJHM47+uxL8TmygMq?=
 =?us-ascii?Q?Ll2eQLaxpD5/dtNxAqfIM9ElPw/79Dn+NCN02BTDDrAto+RRvbXxfi8D8EVg?=
 =?us-ascii?Q?crfPyPBlymkxChwrgjJgxTwHAm2TdleOMuWsbh2rrkQQhTWmVoBHNSu7Z0fR?=
 =?us-ascii?Q?RKmo0CzKdmNTjKbUPf7R3Dp7L3npAZzFTfcKMI69H48FztAcDt66J/sT6You?=
 =?us-ascii?Q?Doln5ZjGpKBffw7sEubPMuRqXOSefTBL4F+kFsfzUCFGPPYrV5L1q1gT0yiA?=
 =?us-ascii?Q?yAw++cMd9p58DENZ+rVxC0Gpjp96QT1ZOD1tg1LIrPMgah/hv6f/JntKSXBl?=
 =?us-ascii?Q?55TnMGRXVGoi8xgO90cH8DK9W73KqwaClA8hoYLS0TcmJhK946VWpJeCjGl9?=
 =?us-ascii?Q?AxExVl7yZiyqydy0diCCjiDoxJkvw8rjONsMg6Di9KlLH68T8EzuCCXB3w2V?=
 =?us-ascii?Q?62D+X8fnxUKCniSM1FztJRdk8wBtwTSz1Xb9onIGXv/ri/Wblz6GsGGGVg8j?=
 =?us-ascii?Q?zwb9zK2b14q2KvA+ntU0K6paSnxoFTAoXn2ze1EpCpXB2cOheo/vqYZ8nb5f?=
 =?us-ascii?Q?KTuG6cgqnutf+wX93cMrsDzG8FUvm8dEfmz8rY6ZScxhKZqSJ8vs8E3H/Cj/?=
 =?us-ascii?Q?C63+qQDsgiGFZC439GsXkZchi/gsn3A6OQwAwtA9FoSD3qn+qV1sXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:33:10.9241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbe0152-2683-452a-ef4b-08dd671ce250
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383

 A new scalar value (PTEAScanScale) to control per task PTE A bit scanning is
introduced.

0    : scanning disabled
1-10 : scanning enabled.

In future PTEAScanScale could be used to control aggressiveness of scanning.

CC: linux-doc@vger.kernel.org 
CC: Jonathan Corbet <corbet@lwn.net>
CC: linux-fsdevel@vger.kernel.org

Suggested-by: David Rientjes <rientjes@google.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 Documentation/filesystems/proc.rst |  2 ++
 fs/proc/task_mmu.c                 |  4 ++++
 include/linux/kmmscand.h           |  1 +
 include/linux/mm_types.h           |  3 +++
 include/uapi/linux/prctl.h         |  7 +++++++
 kernel/fork.c                      |  4 ++++
 kernel/sys.c                       | 25 +++++++++++++++++++++++++
 mm/kmmscand.c                      |  5 +++++
 8 files changed, 51 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 09f0aed5a08b..78633cab3f1a 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -195,6 +195,7 @@ read the file /proc/PID/status::
   VmLib:      1412 kB
   VmPTE:        20 kb
   VmSwap:        0 kB
+  PTEAScanScale: 0
   HugetlbPages:          0 kB
   CoreDumping:    0
   THP_enabled:	  1
@@ -278,6 +279,7 @@ It's slow but very precise.
  VmPTE                       size of page table entries
  VmSwap                      amount of swap used by anonymous private data
                              (shmem swap usage is not included)
+ PTEAScanScale               Integer representing async PTE A bit scan agrression
  HugetlbPages                size of hugetlb memory portions
  CoreDumping                 process's memory is currently being dumped
                              (killing the process may lead to a corrupted core)
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f02cd362309a..55620a5178fb 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -79,6 +79,10 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
 	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
 	seq_puts(m, " kB\n");
+#ifdef CONFIG_KMMSCAND
+	seq_put_decimal_ull_width(m, "PTEAScanScale:\t", mm->pte_scan_scale, 8);
+	seq_puts(m, "\n");
+#endif
 	hugetlb_report_usage(m, mm);
 }
 #undef SEQ_PUT_DEC
diff --git a/include/linux/kmmscand.h b/include/linux/kmmscand.h
index b120c65ee8c6..7021f7d979a6 100644
--- a/include/linux/kmmscand.h
+++ b/include/linux/kmmscand.h
@@ -13,6 +13,7 @@ static inline void kmmscand_execve(struct mm_struct *mm)
 
 static inline void kmmscand_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
+	mm->pte_scan_scale = oldmm->pte_scan_scale;
 	__kmmscand_enter(mm);
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index eeaedc7473b1..12184e8ebc58 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1018,6 +1018,9 @@ struct mm_struct {
 #ifdef CONFIG_KMMSCAND
 		/* Tracks promotion node. XXX: use nodemask */
 		int target_node;
+
+		/* Integer representing PTE A bit scan aggression (0-10) */
+		unsigned int pte_scan_scale;
  #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 5c6080680cb2..18face11440a 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -353,4 +353,11 @@ struct prctl_mm_map {
  */
 #define PR_LOCK_SHADOW_STACK_STATUS      76
 
+/* Set/get PTE A bit scan scale */
+#define PR_SET_PTE_A_SCAN_SCALE		77
+#define PR_GET_PTE_A_SCAN_SCALE		78
+# define PR_PTE_A_SCAN_SCALE_MIN	0
+# define PR_PTE_A_SCAN_SCALE_MAX	10
+# define PR_PTE_A_SCAN_SCALE_DEFAULT	1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index f61c55cf33c2..bfbbacb8ec36 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -106,6 +106,7 @@
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/tick.h>
+#include <linux/prctl.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -1292,6 +1293,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	init_tlb_flush_pending(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLOCKS)
 	mm->pmd_huge_pte = NULL;
+#endif
+#ifdef CONFIG_KMMSCAND
+	mm->pte_scan_scale = PR_PTE_A_SCAN_SCALE_DEFAULT;
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
diff --git a/kernel/sys.c b/kernel/sys.c
index cb366ff8703a..0518480d8f78 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2142,6 +2142,19 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
 
 	return 0;
 }
+#ifdef CONFIG_KMMSCAND
+static int prctl_pte_scan_scale_write(unsigned int scale)
+{
+	scale = clamp(scale, PR_PTE_A_SCAN_SCALE_MIN, PR_PTE_A_SCAN_SCALE_MAX);
+	current->mm->pte_scan_scale = scale;
+	return 0;
+}
+
+static unsigned int prctl_pte_scan_scale_read(void)
+{
+	return current->mm->pte_scan_scale;
+}
+#endif
 
 static int prctl_set_mm(int opt, unsigned long addr,
 			unsigned long arg4, unsigned long arg5)
@@ -2811,6 +2824,18 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = arch_lock_shadow_stack_status(me, arg2);
 		break;
+#ifdef CONFIG_KMMSCAND
+	case PR_SET_PTE_A_SCAN_SCALE:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = prctl_pte_scan_scale_write((unsigned int) arg2);
+		break;
+	case PR_GET_PTE_A_SCAN_SCALE:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = prctl_pte_scan_scale_read();
+		break;
+#endif
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;
diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 38d7825c0d62..68ef2141c349 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -1113,6 +1113,11 @@ static unsigned long kmmscand_scan_mm_slot(void)
 		goto outerloop;
 	}
 
+	if (!mm->pte_scan_scale) {
+		next_mm = true;
+		goto outerloop;
+	}
+
 	mm_target_node = READ_ONCE(mm->target_node);
 	if (mm_target_node != mm_slot_target_node)
 		WRITE_ONCE(mm->target_node, mm_slot_target_node);
-- 
2.34.1


