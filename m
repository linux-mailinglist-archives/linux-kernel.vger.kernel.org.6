Return-Path: <linux-kernel+bounces-560623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E4EA60765
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5244319C2C58
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9358B282F0;
	Fri, 14 Mar 2025 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tzTTXyFu"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F74400
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741918390; cv=fail; b=tph+SfmWZoSDJ70KX6aWJByQ+ScJQ5X3C47SHsHdNOtaeccd70Nguk3uoZUnsCT7S8E7/LIGedf9tL2dcfHsPE6hltugWeIvhp2S16Lc8iDAgh3euttKTnqO8gn9KQGJGLmtZ8z7cg1ISOWymczpwqGJ95yKcnjm9RLCjlO4OhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741918390; c=relaxed/simple;
	bh=htpuAYnhdZIpsMd6Nx9dqyNpViuE4Wfu3I6+ebaQvX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euweKuOR4HWhS3QvWqkvSC5R+hSGiDg63NkhtMS6waDrwmtZv91ioeC6J9Orbalwoub4TS2YTBjNClaFm89fguX9pE5T4ONCvxM9SOrnzn3aVu/bnlSCTt/q6Po7jkHioJTwVw2qejxn55IoZq9D6HMBHtF6GotLk1crh1wwGnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tzTTXyFu; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWXVJZB+AVfvx8KPgdmQvnVuIx60Fh5q6s9ZItil+KXxCMwqfcEMBZaWw98zUneAakRWvEWfzxRxj1L17TE6zbWGWYYOb+qLA5ilf0XY2qOgUqD5GVU4zZ1jgW25OOEMeyhlcxbsXnjQPWdCEn4WAuwbBBIvbL9W5geooFMBMM8npvkggbMTP6HEY+M8wAMeDEp3QhdskW7riX4oHWXq3B/+/DLxLkSlb1f2pMNvYdoiJhENxp9BnDuQdGQ3bc0sJj43VGGWXUoSAOPR3EaFP2H2a4xVXbZLqeify2VCunsk1JIdeb0SyGehjlay9SM1fBIz53YJU87jsqPFUQgkVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+TaagNmerc8UQTFJWAuzDWVvuAubGqGqx7l/9+zPnk=;
 b=qpFHBAPODKldWG0Witroyv0UEWMzU16XqSm+eUWeGjleLS30sWl8lMnBTmm1fHnMfAbXlJJpPAs+jQgy3Uhtc0jpUcAuv62rgd1/EmqKPlmocZceNHgBZTDvvK2KdT2ggqKo1G7dgvzXkex52OaDE7OIGBzFWfUwg0j5EbT31wjg9VI+QMSRRE460IsZ0453KVAhKi58d3tvqXKNUCXxFbMTSMlc5vAsaGNjUJ2SnBRvMqT5Q84iP9XEpzJGWdUtddkS3DxDCvXq2ITYCftAPojdOUzRlV5z7+q/b3QCLhwUV8YwQ3iJZsmAUagF/dZQTIuh8gHeXK9X67jMMMufXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+TaagNmerc8UQTFJWAuzDWVvuAubGqGqx7l/9+zPnk=;
 b=tzTTXyFuH7MhAQivLslD9UJI3+kQfylFYE34VoapFTvYreY7pXOPegwAQ1lGJSxIdSN/OEQBIQyh0+0ZHkSj3nbgYUDcFf1crK/0kzvn81QGXn+ecgttQDeBg06e+RdZST2Zmp+WfhTfVRbIewemAM6/zt2zpu7AcNCMi0ik6Vg=
Received: from MW4PR03CA0233.namprd03.prod.outlook.com (2603:10b6:303:b9::28)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 02:13:00 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::85) by MW4PR03CA0233.outlook.office365.com
 (2603:10b6:303:b9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Fri,
 14 Mar 2025 02:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 02:13:00 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 21:12:49 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Michael.Day@amd.com>, <abhishekd@meta.com>, <akpm@linux-foundation.org>,
	<bharata@amd.com>, <dave.hansen@intel.com>, <david@redhat.com>,
	<dongjoo.linux.dev@gmail.com>, <feng.tang@intel.com>, <gourry@gourry.net>,
	<hannes@cmpxchg.org>, <honggyu.kim@sk.com>, <hughd@google.com>,
	<jhubbard@nvidia.com>, <jon.grimm@amd.com>, <k.shutemov@gmail.com>,
	<kbusch@meta.com>, <kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>,
	<leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lsf-pc@lists.linux-foundation.org>, <mgorman@techsingularity.net>,
	<mingo@redhat.com>, <nadav.amit@gmail.com>, <nehagholkar@meta.com>,
	<nphamcs@gmail.com>, <peterz@infradead.org>, <riel@surriel.com>,
	<rientjes@google.com>, <rppt@kernel.org>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>, <vbabka@suse.cz>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>
Subject: Re: [LSF/MM/BPF TOPIC] Overhauling hot page detection and promotion based on PTE A bit scanning
Date: Fri, 14 Mar 2025 02:12:31 +0000
Message-ID: <20250314021231.11824-1-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <56872982-8676-4d65-85ef-b894728db18b@amd.com>
References: <56872982-8676-4d65-85ef-b894728db18b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: d57ef602-88ab-4496-dd57-08dd629dbe7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0w7CHdPtdKSMsq2tHpbxfiqzurAC8YjL0rqTL247LM04jAs/cF1rdZ8l3CKg?=
 =?us-ascii?Q?ZOksPA8KVU8HIK8g7rSgmM0iJ1/fVNRTrpS1Fe/KAyd255Tyr6Btj0Uv8eNp?=
 =?us-ascii?Q?aDFweglvNPD7xRXNQi2dHM97/sxeCk/f5cBgsqSmrUj/+CPsyhFcHn2gOc47?=
 =?us-ascii?Q?ycULKGvjsLB0DAHydv4YJmcD2j3ozm8XguQhz4bA11QKG6WR+Yj5tKsJ3b1i?=
 =?us-ascii?Q?9pmGd4vIzG0nBBKMvaZd9zxYiIbjLujCMlWVceLkFBAu8xFBKVtYAdiwf3Vo?=
 =?us-ascii?Q?to3y1oFJ73DjjQ7qvcoq4Vqy88nIB7HubSzOnYmTHDAwfCkNJt6AnlOpRyop?=
 =?us-ascii?Q?huFNNlPUVu8WA77ZXalLF2H7rguoYIo2u49qdcEGbcU9LC5cDf+uvY3iCd9b?=
 =?us-ascii?Q?wLZm6kNbCHKMgq7C6zFGGZXmw1uojXjwBUCv7WJZDNwxme8O42H0ozhn6Xyi?=
 =?us-ascii?Q?CMSroCJPlC1/eEuNvV5k1+S/ET/3b/za3VOllTumMlBNtJHbAY/JDzK1i9GP?=
 =?us-ascii?Q?ZMmS4ppDDGf5/bKeWuh1lRbOFQXeeq7gRTksuHpQl7N5BcGI6dchGgFu/vrP?=
 =?us-ascii?Q?r2w277UbyuCHwEDbh7qgiDfCv0tGrDTJPu4cNUOMXSlPWZAmeTgyWRK9H0Xu?=
 =?us-ascii?Q?BZ1nErOrVLFGFxq3qCyx4sswp9Im3ltlih3JnoSHmwwl3GHjsk2UdSExDf83?=
 =?us-ascii?Q?tCQR8m4dnlpWDKOlruB3E2c6rWhgNKvJrwxWx1ZBc+ET2C/oCUHlvagygdx+?=
 =?us-ascii?Q?RQDmYjmjn38lioN+MMj2zQ0MUyd9CArsgoEMNKQtRWe1iMPWC2d0uF0/Q1S/?=
 =?us-ascii?Q?BepsvFilFsOG/j3omBikj1HAgHHBeOIg0bVPoxc7+GOD848i+j5mfr2bC1AK?=
 =?us-ascii?Q?IqbAFCuG523amjPxlszLkBKdP3olaefOH1q/+MUmtr6Qy48gSWEdfwIJC5T0?=
 =?us-ascii?Q?2eZxfD45KrbBzT3Bb76vB25WqKnzQHgZVk6QyWAPTsmFhN/jj+MTRNt5xFbG?=
 =?us-ascii?Q?DFO8FsyEHirSjjAqM3+OIi7XwZkznJq71rxBGmqNJA6OU0IQMexjKy8GT/je?=
 =?us-ascii?Q?feTbq2BCCRTbyrcZmYaD+NPLBjkO1OF66Da4YpnyGBvHjrJemc/Xwn8jrIri?=
 =?us-ascii?Q?CVArBLX+KR/SvFamWA2QUsedCNc/Vu+3yFnaabwKBlUuEWqexNf+Jhhk/0mP?=
 =?us-ascii?Q?TTnzoCCAQMupDOcFW3ImQoID9mse59FG0UQA8+3Eqj5ZSZkMWCAnPGcwTBvp?=
 =?us-ascii?Q?s5UvxJPkv74+phAY1TLY1/89JfhAeB4/9dGK/9trIjxWPx3FNruytPE5X6ob?=
 =?us-ascii?Q?y4qLrSMR7Du1z5n6W4Ng+BdGZXwsVCP8b4jrF5zcRuDzu7SWnxja06eRXXlk?=
 =?us-ascii?Q?tKH17LaZGQnq9ZXPpY43RGboEF63sc27qwMxWX1PVG6a2ZH35XQ2lq+OtIff?=
 =?us-ascii?Q?nXrxzv6svXvGdeyyrNKD0ZQVOrnAm2iMZ5+VB9Wkt44B9XKU9LZwWDRBEXA4?=
 =?us-ascii?Q?4CrblZzwru5xrus=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 02:13:00.0288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d57ef602-88ab-4496-dd57-08dd629dbe7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739

PTE A bit scanning single patch RFC v1

---8x---
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
diff --git a/fs/exec.c b/fs/exec.c
index 506cd411f4ac..e76285e4bc73 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -68,6 +68,7 @@
 #include <linux/user_events.h>
 #include <linux/rseq.h>
 #include <linux/ksm.h>
+#include <linux/kmmscand.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -266,6 +267,8 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 	if (err)
 		goto err_ksm;
 
+	kmmscand_execve(mm);
+
 	/*
 	 * Place the stack at the largest stack address the architecture
 	 * supports. Later, we'll move this to an appropriate place. We don't
@@ -288,6 +291,7 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 	return 0;
 err:
 	ksm_exit(mm);
+	kmmscand_exit(mm);
 err_ksm:
 	mmap_write_unlock(mm);
 err_free:
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
new file mode 100644
index 000000000000..7021f7d979a6
--- /dev/null
+++ b/include/linux/kmmscand.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KMMSCAND_H_
+#define _LINUX_KMMSCAND_H_
+
+#ifdef CONFIG_KMMSCAND
+extern void __kmmscand_enter(struct mm_struct *mm);
+extern void __kmmscand_exit(struct mm_struct *mm);
+
+static inline void kmmscand_execve(struct mm_struct *mm)
+{
+	__kmmscand_enter(mm);
+}
+
+static inline void kmmscand_fork(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	mm->pte_scan_scale = oldmm->pte_scan_scale;
+	__kmmscand_enter(mm);
+}
+
+static inline void kmmscand_exit(struct mm_struct *mm)
+{
+	__kmmscand_exit(mm);
+}
+#else /* !CONFIG_KMMSCAND */
+static inline void __kmmscand_enter(struct mm_struct *mm) {}
+static inline void __kmmscand_exit(struct mm_struct *mm) {}
+static inline void kmmscand_execve(struct mm_struct *mm) {}
+static inline void kmmscand_fork(struct mm_struct *mm, struct mm_struct *oldmm) {}
+static inline void kmmscand_exit(struct mm_struct *mm) {}
+#endif
+#endif /* _LINUX_KMMSCAND_H_ */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..fbd9273f6c65 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -682,6 +682,18 @@ struct vm_operations_struct {
 					  unsigned long addr);
 };
 
+#ifdef CONFIG_KMMSCAND
+void count_kmmscand_mm_scans(void);
+void count_kmmscand_vma_scans(void);
+void count_kmmscand_migadded(void);
+void count_kmmscand_migrated(void);
+void count_kmmscand_migrate_failed(void);
+void count_kmmscand_kzalloc_fail(void);
+void count_kmmscand_slowtier(void);
+void count_kmmscand_toptier(void);
+void count_kmmscand_idlepage(void);
+#endif
+
 #ifdef CONFIG_NUMA_BALANCING
 static inline void vma_numab_state_init(struct vm_area_struct *vma)
 {
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0234f14f2aa6..7950554f7447 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1014,6 +1014,14 @@ struct mm_struct {
 
 		/* numa_scan_seq prevents two threads remapping PTEs. */
 		int numa_scan_seq;
+#endif
+#ifdef CONFIG_KMMSCAND
+		/* Tracks promotion node. XXX: use nodemask */
+		int target_node;
+
+		/* Integer representing PTE A bit scan aggression (0-10) */
+		unsigned int pte_scan_scale;
+
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f70d0958095c..620c1b1c157a 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -65,6 +65,17 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NUMA_HINT_FAULTS_LOCAL,
 		NUMA_PAGE_MIGRATE,
 #endif
+#ifdef CONFIG_KMMSCAND
+		KMMSCAND_MM_SCANS,
+		KMMSCAND_VMA_SCANS,
+		KMMSCAND_MIGADDED,
+		KMMSCAND_MIGRATED,
+		KMMSCAND_MIGRATE_FAILED,
+		KMMSCAND_KZALLOC_FAIL,
+		KMMSCAND_SLOWTIER,
+		KMMSCAND_TOPTIER,
+		KMMSCAND_IDLEPAGE,
+#endif
 #ifdef CONFIG_MIGRATION
 		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
 		THP_MIGRATION_SUCCESS,
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index b37eb0a7060f..be1a7188a192 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -9,6 +9,96 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
 
+DECLARE_EVENT_CLASS(kmem_mm_class,
+
+	TP_PROTO(struct mm_struct *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+		__field(	struct mm_struct *, mm		)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+	),
+
+	TP_printk("mm = %p", __entry->mm)
+);
+
+DEFINE_EVENT(kmem_mm_class, kmem_mm_enter,
+	TP_PROTO(struct mm_struct *mm),
+	TP_ARGS(mm)
+);
+
+DEFINE_EVENT(kmem_mm_class, kmem_mm_exit,
+	TP_PROTO(struct mm_struct *mm),
+	TP_ARGS(mm)
+);
+
+DEFINE_EVENT(kmem_mm_class, kmem_scan_mm_start,
+	TP_PROTO(struct mm_struct *mm),
+	TP_ARGS(mm)
+);
+
+TRACE_EVENT(kmem_scan_mm_end,
+
+	TP_PROTO( struct mm_struct *mm,
+		 unsigned long start,
+		 unsigned long total,
+		 unsigned long scan_period,
+		 unsigned long scan_size,
+		 int target_node),
+
+	TP_ARGS(mm, start, total, scan_period, scan_size, target_node),
+
+	TP_STRUCT__entry(
+		__field(	struct mm_struct *, mm		)
+		__field(	unsigned long,   start		)
+		__field(	unsigned long,   total		)
+		__field(	unsigned long,   scan_period	)
+		__field(	unsigned long,   scan_size	)
+		__field(	int,   		 target_node	)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__entry->start = start;
+		__entry->total = total;
+		__entry->scan_period  = scan_period;
+		__entry->scan_size    = scan_size;
+		__entry->target_node  = target_node;
+	),
+
+	TP_printk("mm=%p, start = %ld, total = %ld, scan_period = %ld, scan_size = %ld node = %d",
+		__entry->mm, __entry->start, __entry->total, __entry->scan_period,
+		__entry->scan_size, __entry->target_node)
+);
+
+TRACE_EVENT(kmem_scan_mm_migrate,
+
+	TP_PROTO(struct mm_struct *mm,
+		 int rc,
+		 int target_node),
+
+	TP_ARGS(mm, rc, target_node),
+
+	TP_STRUCT__entry(
+		__field(	struct mm_struct *, mm		)
+		__field(	int,   rc			)
+		__field(	int,   target_node		)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__entry->rc = rc;
+		__entry->target_node = target_node;
+	),
+
+	TP_printk("mm = %p rc = %d node = %d",
+		__entry->mm, __entry->rc, __entry->target_node)
+);
+
 TRACE_EVENT(kmem_cache_alloc,
 
 	TP_PROTO(unsigned long call_site,
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
index 735405a9c5f3..bfbbacb8ec36 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -85,6 +85,7 @@
 #include <linux/user-return-notifier.h>
 #include <linux/oom.h>
 #include <linux/khugepaged.h>
+#include <linux/kmmscand.h>
 #include <linux/signalfd.h>
 #include <linux/uprobes.h>
 #include <linux/aio.h>
@@ -105,6 +106,7 @@
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/tick.h>
+#include <linux/prctl.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -656,6 +658,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	mm->exec_vm = oldmm->exec_vm;
 	mm->stack_vm = oldmm->stack_vm;
 
+	kmmscand_fork(mm, oldmm);
+
 	/* Use __mt_dup() to efficiently build an identical maple tree. */
 	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
 	if (unlikely(retval))
@@ -1289,6 +1293,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	init_tlb_flush_pending(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLOCKS)
 	mm->pmd_huge_pte = NULL;
+#endif
+#ifdef CONFIG_KMMSCAND
+	mm->pte_scan_scale = PR_PTE_A_SCAN_SCALE_DEFAULT;
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
@@ -1353,6 +1360,7 @@ static inline void __mmput(struct mm_struct *mm)
 	exit_aio(mm);
 	ksm_exit(mm);
 	khugepaged_exit(mm); /* must run before exit_mmap */
+	kmmscand_exit(mm);
 	exit_mmap(mm);
 	mm_put_huge_zero_folio(mm);
 	set_mm_exe_file(mm, NULL);
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
diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db06417..529bf140e1f7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -783,6 +783,13 @@ config KSM
 	  until a program has madvised that an area is MADV_MERGEABLE, and
 	  root has set /sys/kernel/mm/ksm/run to 1 (if CONFIG_SYSFS is set).
 
+config KMMSCAND
+	bool "Enable PTE A bit scanning and Migration"
+	depends on NUMA_BALANCING
+	help
+	  Enable PTE A bit scanning of page. CXL pages accessed are migrated to
+	  regular NUMA node (node 0 - default).
+
 config DEFAULT_MMAP_MIN_ADDR
 	int "Low address space to protect from user allocation"
 	depends on MMU
diff --git a/mm/Makefile b/mm/Makefile
index 850386a67b3e..45e2f8cc8fd6 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_FAIL_PAGE_ALLOC) += fail_page_alloc.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
+obj-$(CONFIG_KMMSCAND) += kmmscand.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
diff --git a/mm/kmmscand.c b/mm/kmmscand.c
new file mode 100644
index 000000000000..2fc1b46cf512
--- /dev/null
+++ b/mm/kmmscand.c
@@ -0,0 +1,1505 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/mmu_notifier.h>
+#include <linux/migrate.h>
+#include <linux/rmap.h>
+#include <linux/pagewalk.h>
+#include <linux/page_ext.h>
+#include <linux/page_idle.h>
+#include <linux/page_table_check.h>
+#include <linux/pagemap.h>
+#include <linux/swap.h>
+#include <linux/mm_inline.h>
+#include <linux/kthread.h>
+#include <linux/kmmscand.h>
+#include <linux/memory-tiers.h>
+#include <linux/mempolicy.h>
+#include <linux/string.h>
+#include <linux/cleanup.h>
+#include <linux/minmax.h>
+#include <linux/delay.h>
+#include <trace/events/kmem.h>
+
+#include <asm/pgalloc.h>
+#include "internal.h"
+#include "mm_slot.h"
+
+static struct task_struct *kmmscand_thread __read_mostly;
+static DEFINE_MUTEX(kmmscand_mutex);
+extern unsigned int sysctl_numa_balancing_scan_delay;
+
+/*
+ * Total VMA size to cover during scan.
+ * Min: 256MB default: 1GB max: 4GB
+ */
+#define KMMSCAND_SCAN_SIZE_MIN	(256 * 1024 * 1024UL)
+#define KMMSCAND_SCAN_SIZE_MAX	(8 * 1024 * 1024 * 1024UL)
+#define KMMSCAND_SCAN_SIZE	(2 * 1024 * 1024 * 1024UL)
+
+static unsigned long kmmscand_scan_size __read_mostly = KMMSCAND_SCAN_SIZE;
+
+/*
+ * Scan period for each mm.
+ * Min: 400ms default: 2sec Max: 5sec
+ */
+#define KMMSCAND_SCAN_PERIOD_MAX	5000U
+#define KMMSCAND_SCAN_PERIOD_MIN	400U
+#define KMMSCAND_SCAN_PERIOD		2000U
+
+static unsigned int kmmscand_mm_scan_period_ms __read_mostly = KMMSCAND_SCAN_PERIOD;
+
+/* How long to pause between two scan and migration cycle */
+static unsigned int kmmscand_scan_sleep_ms __read_mostly = 16;
+
+/* Max number of mms to scan in one scan and migration cycle */
+#define KMMSCAND_MMS_TO_SCAN	(4 * 1024UL)
+static unsigned long kmmscand_mms_to_scan __read_mostly = KMMSCAND_MMS_TO_SCAN;
+
+volatile bool kmmscand_scan_enabled = true;
+static bool need_wakeup;
+static bool migrated_need_wakeup;
+
+/* How long to pause between two migration cycles */
+static unsigned int kmmmigrate_sleep_ms __read_mostly = 20;
+
+static struct task_struct *kmmmigrated_thread __read_mostly;
+static DEFINE_MUTEX(kmmmigrated_mutex);
+static DECLARE_WAIT_QUEUE_HEAD(kmmmigrated_wait);
+static unsigned long kmmmigrated_sleep_expire;
+
+/* mm of the migrating folio entry */
+static struct mm_struct *kmmscand_cur_migrate_mm;
+
+/* Migration list is manipulated underneath because of mm_exit */
+static bool  kmmscand_migration_list_dirty;
+
+static unsigned long kmmscand_sleep_expire;
+#define KMMSCAND_DEFAULT_TARGET_NODE	(0)
+static int kmmscand_target_node = KMMSCAND_DEFAULT_TARGET_NODE;
+
+static DEFINE_SPINLOCK(kmmscand_mm_lock);
+static DEFINE_SPINLOCK(kmmscand_migrate_lock);
+static DECLARE_WAIT_QUEUE_HEAD(kmmscand_wait);
+
+#define KMMSCAND_SLOT_HASH_BITS 10
+static DEFINE_READ_MOSTLY_HASHTABLE(kmmscand_slots_hash, KMMSCAND_SLOT_HASH_BITS);
+
+static struct kmem_cache *kmmscand_slot_cache __read_mostly;
+
+struct kmmscand_nodeinfo {
+	unsigned long nr_scanned;
+	unsigned long nr_accessed;
+	int node;
+	bool is_toptier;
+};
+
+struct kmmscand_mm_slot {
+	struct mm_slot slot;
+	/* Unit: ms. Determines how aften mm scan should happen. */
+	unsigned int scan_period;
+	unsigned long next_scan;
+	/* Tracks how many useful pages obtained for migration in the last scan */
+	unsigned long scan_delta;
+	/* Determines how much VMA address space to be covered in the scanning */
+	unsigned long scan_size;
+	long address;
+	volatile bool is_scanned;
+	int target_node;
+};
+
+struct kmmscand_scan {
+	struct list_head mm_head;
+	struct kmmscand_mm_slot *mm_slot;
+};
+
+struct kmmscand_scan kmmscand_scan = {
+	.mm_head = LIST_HEAD_INIT(kmmscand_scan.mm_head),
+};
+
+struct kmmscand_scanctrl {
+	struct list_head scan_list;
+	struct kmmscand_nodeinfo *nodeinfo[MAX_NUMNODES];
+};
+
+struct kmmscand_scanctrl kmmscand_scanctrl;
+
+struct kmmscand_migrate_list {
+	struct list_head migrate_head;
+};
+
+struct kmmscand_migrate_list kmmscand_migrate_list = {
+	.migrate_head = LIST_HEAD_INIT(kmmscand_migrate_list.migrate_head),
+};
+
+struct kmmscand_migrate_info {
+	struct list_head migrate_node;
+	struct mm_struct *mm;
+	struct folio *folio;
+	unsigned long address;
+};
+
+#ifdef CONFIG_SYSFS
+static ssize_t scan_sleep_ms_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", kmmscand_scan_sleep_ms);
+}
+
+static ssize_t scan_sleep_ms_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	unsigned int msecs;
+	int err;
+
+	err = kstrtouint(buf, 10, &msecs);
+	if (err)
+		return -EINVAL;
+
+	kmmscand_scan_sleep_ms = msecs;
+	kmmscand_sleep_expire = 0;
+	wake_up_interruptible(&kmmscand_wait);
+
+	return count;
+}
+static struct kobj_attribute scan_sleep_ms_attr =
+	__ATTR_RW(scan_sleep_ms);
+
+static ssize_t mm_scan_period_ms_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", kmmscand_mm_scan_period_ms);
+}
+
+/* If a value less than MIN or greater than MAX asked for store value is clamped */
+static ssize_t mm_scan_period_ms_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	unsigned int msecs, stored_msecs;
+	int err;
+
+	err = kstrtouint(buf, 10, &msecs);
+	if (err)
+		return -EINVAL;
+
+	stored_msecs = clamp(msecs, KMMSCAND_SCAN_PERIOD_MIN, KMMSCAND_SCAN_PERIOD_MAX);
+
+	kmmscand_mm_scan_period_ms = stored_msecs;
+	kmmscand_sleep_expire = 0;
+	wake_up_interruptible(&kmmscand_wait);
+
+	return count;
+}
+
+static struct kobj_attribute mm_scan_period_ms_attr =
+	__ATTR_RW(mm_scan_period_ms);
+
+static ssize_t mms_to_scan_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", kmmscand_mms_to_scan);
+}
+
+static ssize_t mms_to_scan_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return -EINVAL;
+
+	kmmscand_mms_to_scan = val;
+	kmmscand_sleep_expire = 0;
+	wake_up_interruptible(&kmmscand_wait);
+
+	return count;
+}
+
+static struct kobj_attribute mms_to_scan_attr =
+	__ATTR_RW(mms_to_scan);
+
+static ssize_t scan_enabled_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", kmmscand_scan_enabled ? 1 : 0);
+}
+
+static ssize_t scan_enabled_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	unsigned int val;
+	int err;
+
+	err = kstrtouint(buf, 10, &val);
+	if (err || val > 1)
+		return -EINVAL;
+
+	if (val) {
+		kmmscand_scan_enabled = true;
+		need_wakeup = true;
+	} else
+		kmmscand_scan_enabled = false;
+
+	kmmscand_sleep_expire = 0;
+	wake_up_interruptible(&kmmscand_wait);
+
+	return count;
+}
+
+static struct kobj_attribute scan_enabled_attr =
+	__ATTR_RW(scan_enabled);
+
+static ssize_t target_node_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", kmmscand_target_node);
+}
+
+static ssize_t target_node_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	int err, node;
+
+	err = kstrtoint(buf, 10, &node);
+	if (err)
+		return -EINVAL;
+
+	kmmscand_sleep_expire = 0;
+	if (!node_is_toptier(node))
+		return -EINVAL;
+
+	kmmscand_target_node = node;
+	wake_up_interruptible(&kmmscand_wait);
+
+	return count;
+}
+static struct kobj_attribute target_node_attr =
+	__ATTR_RW(target_node);
+
+static struct attribute *kmmscand_attr[] = {
+	&scan_sleep_ms_attr.attr,
+	&mm_scan_period_ms_attr.attr,
+	&mms_to_scan_attr.attr,
+	&scan_enabled_attr.attr,
+	&target_node_attr.attr,
+	NULL,
+};
+
+struct attribute_group kmmscand_attr_group = {
+	.attrs = kmmscand_attr,
+	.name = "kmmscand",
+};
+#endif
+
+void count_kmmscand_mm_scans(void)
+{
+	count_vm_numa_event(KMMSCAND_MM_SCANS);
+}
+void count_kmmscand_vma_scans(void)
+{
+	count_vm_numa_event(KMMSCAND_VMA_SCANS);
+}
+void count_kmmscand_migadded(void)
+{
+	count_vm_numa_event(KMMSCAND_MIGADDED);
+}
+void count_kmmscand_migrated(void)
+{
+	count_vm_numa_event(KMMSCAND_MIGRATED);
+}
+void count_kmmscand_migrate_failed(void)
+{
+	count_vm_numa_event(KMMSCAND_MIGRATE_FAILED);
+}
+void count_kmmscand_kzalloc_fail(void)
+{
+	count_vm_numa_event(KMMSCAND_KZALLOC_FAIL);
+}
+void count_kmmscand_slowtier(void)
+{
+	count_vm_numa_event(KMMSCAND_SLOWTIER);
+}
+void count_kmmscand_toptier(void)
+{
+	count_vm_numa_event(KMMSCAND_TOPTIER);
+}
+void count_kmmscand_idlepage(void)
+{
+	count_vm_numa_event(KMMSCAND_IDLEPAGE);
+}
+
+static int kmmscand_has_work(void)
+{
+	return !list_empty(&kmmscand_scan.mm_head);
+}
+
+static int kmmmigrated_has_work(void)
+{
+	if (!list_empty(&kmmscand_migrate_list.migrate_head))
+		return true;
+	return false;
+}
+
+static bool kmmscand_should_wakeup(void)
+{
+	bool wakeup =  kthread_should_stop() || need_wakeup ||
+	       time_after_eq(jiffies, kmmscand_sleep_expire);
+	if (need_wakeup)
+		need_wakeup = false;
+
+	return wakeup;
+}
+
+static bool kmmmigrated_should_wakeup(void)
+{
+	bool wakeup =  kthread_should_stop() || migrated_need_wakeup ||
+	       time_after_eq(jiffies, kmmmigrated_sleep_expire);
+	if (migrated_need_wakeup)
+		migrated_need_wakeup = false;
+
+	return wakeup;
+}
+
+static void kmmscand_wait_work(void)
+{
+	const unsigned long scan_sleep_jiffies =
+		msecs_to_jiffies(kmmscand_scan_sleep_ms);
+
+	if (!scan_sleep_jiffies)
+		return;
+
+	kmmscand_sleep_expire = jiffies + scan_sleep_jiffies;
+	wait_event_timeout(kmmscand_wait,
+			kmmscand_should_wakeup(),
+			scan_sleep_jiffies);
+	return;
+}
+
+static void kmmmigrated_wait_work(void)
+{
+	const unsigned long migrate_sleep_jiffies =
+		msecs_to_jiffies(kmmmigrate_sleep_ms);
+
+       if (!migrate_sleep_jiffies)
+		return;
+
+	kmmmigrated_sleep_expire = jiffies + migrate_sleep_jiffies;
+	wait_event_timeout(kmmmigrated_wait,
+			kmmmigrated_should_wakeup(),
+			migrate_sleep_jiffies);
+	return;
+}
+
+static unsigned long get_slowtier_accesed(struct kmmscand_scanctrl *scanctrl)
+{
+	int node;
+	unsigned long accessed = 0;
+
+	for_each_node_state(node, N_MEMORY) {
+		if (!node_is_toptier(node))
+			accessed += (scanctrl->nodeinfo[node])->nr_accessed;
+	}
+	return accessed;
+}
+
+static inline unsigned long get_nodeinfo_nr_accessed(struct kmmscand_nodeinfo *ni)
+{
+	return ni->nr_accessed;
+}
+
+static inline void set_nodeinfo_nr_accessed(struct kmmscand_nodeinfo *ni, unsigned long val)
+{
+	ni->nr_accessed = val;
+}
+
+static inline void reset_nodeinfo_nr_accessed(struct kmmscand_nodeinfo *ni)
+{
+	set_nodeinfo_nr_accessed(ni, 0);
+}
+
+static inline void nodeinfo_nr_accessed_inc(struct kmmscand_nodeinfo *ni)
+{
+	ni->nr_accessed++;
+}
+
+static inline unsigned long get_nodeinfo_nr_scanned(struct kmmscand_nodeinfo *ni)
+{
+	return ni->nr_scanned;
+}
+
+static inline void set_nodeinfo_nr_scanned(struct kmmscand_nodeinfo *ni, unsigned long val)
+{
+	ni->nr_scanned = val;
+}
+
+static inline void reset_nodeinfo_nr_scanned(struct kmmscand_nodeinfo *ni)
+{
+	set_nodeinfo_nr_scanned(ni, 0);
+}
+
+static inline void nodeinfo_nr_scanned_inc(struct kmmscand_nodeinfo *ni)
+{
+	ni->nr_scanned++;
+}
+
+
+static inline void reset_nodeinfo(struct kmmscand_nodeinfo *ni)
+{
+	set_nodeinfo_nr_scanned(ni, 0);
+	set_nodeinfo_nr_accessed(ni, 0);
+}
+
+static void init_one_nodeinfo(struct kmmscand_nodeinfo *ni, int node)
+{
+	ni->nr_scanned = 0;
+	ni->nr_accessed = 0;
+	ni->node = node;
+	ni->is_toptier = node_is_toptier(node) ? true : false;
+}
+
+static struct kmmscand_nodeinfo *alloc_one_nodeinfo(int node)
+{
+	struct kmmscand_nodeinfo *ni;
+
+	ni = kzalloc(sizeof(*ni), GFP_KERNEL);
+
+	if (!ni)
+		return NULL;
+
+	init_one_nodeinfo(ni, node);
+
+	return ni;
+}
+
+/* TBD: Handle errors */
+static void init_scanctrl(struct kmmscand_scanctrl *scanctrl)
+{
+	struct kmmscand_nodeinfo *ni;
+	int node;
+	for_each_node_state(node, N_MEMORY) {
+		ni = alloc_one_nodeinfo(node);
+		if (!ni)
+			WARN_ON_ONCE(ni);
+		scanctrl->nodeinfo[node] = ni;
+	}
+	pr_warn("scan ctrl init %d", node);
+}
+
+static void reset_scanctrl(struct kmmscand_scanctrl *scanctrl)
+{
+	int node;
+	for_each_node_state(node, N_MEMORY)
+		reset_nodeinfo(scanctrl->nodeinfo[node]);
+}
+
+static bool kmmscand_eligible_srcnid(int nid)
+{
+	if (!node_is_toptier(nid))
+		return true;
+
+	return false;
+}
+
+/*
+ * Do not know what info to pass in the future to make
+ * decision on taget node. Keep it void * now.
+ */
+static int kmmscand_get_target_node(void *data)
+{
+	return kmmscand_target_node;
+}
+
+static int get_target_node(struct kmmscand_scanctrl *scanctrl)
+{
+	int node, target_node = -9999;
+	unsigned long old_accessed = 0;
+
+	for_each_node(node) {
+		if (get_nodeinfo_nr_scanned(scanctrl->nodeinfo[node]) > old_accessed
+			&& node_is_toptier(node)) {
+			old_accessed = get_nodeinfo_nr_scanned(scanctrl->nodeinfo[node]);
+			target_node = node;
+		}
+	}
+	if (target_node == -9999)
+		target_node = kmmscand_get_target_node(NULL);
+
+	return target_node;
+}
+
+extern bool migrate_balanced_pgdat(struct pglist_data *pgdat,
+					unsigned long nr_migrate_pages);
+
+/*XXX: Taken from migrate.c to avoid NUMAB mode=2 and NULL vma checks*/
+static int kmmscand_migrate_misplaced_folio_prepare(struct folio *folio,
+		struct vm_area_struct *vma, int node)
+{
+	int nr_pages = folio_nr_pages(folio);
+	pg_data_t *pgdat = NODE_DATA(node);
+
+	if (folio_is_file_lru(folio)) {
+		/*
+		 * Do not migrate file folios that are mapped in multiple
+		 * processes with execute permissions as they are probably
+		 * shared libraries.
+		 *
+		 * See folio_likely_mapped_shared() on possible imprecision
+		 * when we cannot easily detect if a folio is shared.
+		 */
+		if (vma && (vma->vm_flags & VM_EXEC) &&
+		    folio_likely_mapped_shared(folio))
+			return -EACCES;
+		/*
+		 * Do not migrate dirty folios as not all filesystems can move
+		 * dirty folios in MIGRATE_ASYNC mode which is a waste of
+		 * cycles.
+		 */
+		if (folio_test_dirty(folio))
+			return -EAGAIN;
+	}
+
+	/* Avoid migrating to a node that is nearly full */
+	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
+		int z;
+
+		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
+			if (managed_zone(pgdat->node_zones + z))
+				break;
+		}
+
+		/*
+		 * If there are no managed zones, it should not proceed
+		 * further.
+		 */
+		if (z < 0)
+			return -EAGAIN;
+
+		wakeup_kswapd(pgdat->node_zones + z, 0,
+			      folio_order(folio), ZONE_MOVABLE);
+		return -EAGAIN;
+	}
+
+	if (!folio_isolate_lru(folio))
+		return -EAGAIN;
+
+	node_stat_mod_folio(folio, NR_ISOLATED_ANON + folio_is_file_lru(folio),
+			    nr_pages);
+
+	return 0;
+}
+
+enum kmmscand_migration_err {
+	KMMSCAND_NULL_MM = 1,
+	KMMSCAND_EXITING_MM,
+	KMMSCAND_INVALID_FOLIO,
+	KMMSCAND_INVALID_VMA,
+	KMMSCAND_INELIGIBLE_SRC_NODE,
+	KMMSCAND_SAME_SRC_DEST_NODE,
+	KMMSCAND_PTE_NOT_PRESENT,
+	KMMSCAND_PMD_NOT_PRESENT,
+	KMMSCAND_NO_PTE_OFFSET_MAP_LOCK,
+	KMMSCAND_LRU_ISOLATION_ERR,
+};
+
+static int kmmscand_promote_folio(struct kmmscand_migrate_info *info, int destnid)
+{
+	unsigned long pfn;
+	unsigned long address;
+	struct page *page;
+	struct folio *folio;
+	int ret;
+	struct mm_struct *mm;
+	pmd_t *pmd;
+	pte_t *pte;
+	spinlock_t *ptl;
+	pmd_t pmde;
+	int srcnid;
+
+	if (info->mm == NULL)
+		return KMMSCAND_NULL_MM;
+
+	if (info->mm == READ_ONCE(kmmscand_cur_migrate_mm) &&
+		READ_ONCE(kmmscand_migration_list_dirty)) {
+		WARN_ON_ONCE(mm);
+		return KMMSCAND_EXITING_MM;
+	}
+
+	mm = info->mm;
+
+	folio = info->folio;
+
+	/* Check again if the folio is really valid now */
+	if (folio) {
+		pfn = folio_pfn(folio);
+		page = pfn_to_online_page(pfn);
+	}
+
+	if (!page || PageTail(page) || !folio || !folio_test_lru(folio) || folio_test_unevictable(folio) ||
+		folio_is_zone_device(folio) || !folio_mapped(folio) || folio_likely_mapped_shared(folio))
+		return KMMSCAND_INVALID_FOLIO;
+
+	folio_get(folio);
+
+	srcnid = folio_nid(folio);
+
+	/* Do not try to promote pages from regular nodes */
+	if (!kmmscand_eligible_srcnid(srcnid)) {
+		folio_put(folio);
+		return KMMSCAND_INELIGIBLE_SRC_NODE;
+	}
+
+
+	if (srcnid == destnid) {
+		folio_put(folio);
+		return KMMSCAND_SAME_SRC_DEST_NODE;
+	}
+	address = info->address;
+	pmd = pmd_off(mm, address);
+	pmde = pmdp_get(pmd);
+
+	if (!pmd_present(pmde)) {
+		folio_put(folio);
+		return KMMSCAND_PMD_NOT_PRESENT;
+	}
+	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
+
+	if (!pte) {
+		folio_put(folio);
+		WARN_ON_ONCE(!pte);
+		return KMMSCAND_NO_PTE_OFFSET_MAP_LOCK;
+	}
+
+
+	ret = kmmscand_migrate_misplaced_folio_prepare(folio, NULL, destnid);
+	if (ret) {
+		folio_put(folio);
+		pte_unmap_unlock(pte, ptl);
+		return KMMSCAND_LRU_ISOLATION_ERR;
+	}
+
+	folio_put(folio);
+	pte_unmap_unlock(pte, ptl);
+
+	return  migrate_misplaced_folio(folio, destnid);
+}
+
+static bool folio_idle_clear_pte_refs_one(struct folio *folio,
+					 struct vm_area_struct *vma,
+					 unsigned long addr,
+					 pte_t *ptep)
+{
+	bool referenced = false;
+	struct mm_struct *mm = vma->vm_mm;
+	pmd_t *pmd = pmd_off(mm, addr);
+
+	if (ptep) {
+		if (ptep_clear_young_notify(vma, addr, ptep))
+			referenced = true;
+	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		if (!pmd_present(*pmd))
+			WARN_ON_ONCE(1);
+		if (pmdp_clear_young_notify(vma, addr, pmd))
+			referenced = true;
+	} else {
+		WARN_ON_ONCE(1);
+	}
+
+	if (referenced) {
+		folio_clear_idle(folio);
+		folio_set_young(folio);
+	}
+
+	return true;
+}
+
+static void page_idle_clear_pte_refs(struct page *page, pte_t *pte, struct mm_walk *walk)
+{
+	bool need_lock;
+	struct folio *folio =  page_folio(page);
+	unsigned long address;
+
+	if (!folio_mapped(folio) || !folio_raw_mapping(folio))
+		return;
+
+	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
+	if (need_lock && !folio_trylock(folio))
+		return;
+	address = vma_address(walk->vma, page_pgoff(folio, page), compound_nr(page));
+	VM_BUG_ON_VMA(address == -EFAULT, walk->vma);
+	folio_idle_clear_pte_refs_one(folio, walk->vma, address, pte);
+
+	if (need_lock)
+		folio_unlock(folio);
+}
+
+static int hot_vma_idle_pte_entry(pte_t *pte,
+				 unsigned long addr,
+				 unsigned long next,
+				 struct mm_walk *walk)
+{
+	struct page *page;
+	struct folio *folio;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	struct kmmscand_migrate_info *info;
+	struct kmmscand_scanctrl *scanctrl = walk->private;
+
+	int srcnid;
+
+	pte_t pteval = ptep_get(pte);
+
+	if (!pte_present(pteval))
+		return 1;
+
+	if (pte_none(pteval))
+		return 1;
+
+	vma = walk->vma;
+	mm = vma->vm_mm;
+
+	page = pte_page(*pte);
+
+	page_idle_clear_pte_refs(page, pte, walk);
+
+	folio = page_folio(page);
+	folio_get(folio);
+
+	if (!folio || folio_is_zone_device(folio) || folio_test_unevictable(folio)
+		|| !folio_mapped(folio) || folio_likely_mapped_shared(folio)) {
+		folio_put(folio);
+		return 1;
+	}
+
+	srcnid = folio_nid(folio);
+
+	if (node_is_toptier(srcnid)) {
+		scanctrl->nodeinfo[srcnid]->nr_scanned++;
+		count_kmmscand_toptier();
+	}
+
+	if (!folio_test_idle(folio) || folio_test_young(folio) ||
+			mmu_notifier_test_young(mm, addr) ||
+			folio_test_referenced(folio) || pte_young(pteval)) {
+
+		/* TBD: Use helpers */
+		scanctrl->nodeinfo[srcnid]->nr_accessed++;
+
+		/* Do not try to promote pages from regular nodes */
+		if (!kmmscand_eligible_srcnid(srcnid))
+			goto end;
+
+		info = kzalloc(sizeof(struct kmmscand_migrate_info), GFP_NOWAIT);
+		if (info && scanctrl) {
+
+			count_kmmscand_slowtier();
+			info->mm = mm;
+			info->address = addr;
+			info->folio = folio;
+
+			/* No need of lock now */
+			list_add_tail(&info->migrate_node, &scanctrl->scan_list);
+
+			count_kmmscand_migadded();
+		}
+	} else
+		count_kmmscand_idlepage();
+end:
+	folio_set_idle(folio);
+	folio_put(folio);
+	return 0;
+}
+
+static const struct mm_walk_ops hot_vma_set_idle_ops = {
+	.pte_entry = hot_vma_idle_pte_entry,
+	.walk_lock = PGWALK_RDLOCK,
+};
+
+static void kmmscand_walk_page_vma(struct vm_area_struct *vma, struct kmmscand_scanctrl *scanctrl)
+{
+	if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
+	    is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
+		return;
+	}
+	if (!vma->vm_mm ||
+	    (vma->vm_file && (vma->vm_flags & (VM_READ|VM_WRITE)) == (VM_READ)))
+		return;
+
+	if (!vma_is_accessible(vma))
+		return;
+
+	walk_page_vma(vma, &hot_vma_set_idle_ops, scanctrl);
+}
+
+static inline int kmmscand_test_exit(struct mm_struct *mm)
+{
+	return atomic_read(&mm->mm_users) == 0;
+}
+
+static void kmmscand_cleanup_migration_list(struct mm_struct *mm)
+{
+	struct kmmscand_migrate_info *info, *tmp;
+
+	spin_lock(&kmmscand_migrate_lock);
+	if (!list_empty(&kmmscand_migrate_list.migrate_head)) {
+		if (mm == READ_ONCE(kmmscand_cur_migrate_mm)) {
+			/* A folio in this mm is being migrated. wait */
+			WRITE_ONCE(kmmscand_migration_list_dirty, true);
+		}
+
+		list_for_each_entry_safe(info, tmp, &kmmscand_migrate_list.migrate_head,
+			migrate_node) {
+			if (info && (info->mm == mm)) {
+				info->mm = NULL;
+				WRITE_ONCE(kmmscand_migration_list_dirty, true);
+			}
+		}
+	}
+	spin_unlock(&kmmscand_migrate_lock);
+}
+
+static void kmmscand_collect_mm_slot(struct kmmscand_mm_slot *mm_slot)
+{
+	struct mm_slot *slot = &mm_slot->slot;
+	struct mm_struct *mm = slot->mm;
+
+	lockdep_assert_held(&kmmscand_mm_lock);
+
+	if (kmmscand_test_exit(mm)) {
+		/* free mm_slot */
+		hash_del(&slot->hash);
+		list_del(&slot->mm_node);
+
+		kmmscand_cleanup_migration_list(mm);
+
+		mm_slot_free(kmmscand_slot_cache, mm_slot);
+		mmdrop(mm);
+	} else {
+		WARN_ON_ONCE(mm_slot);
+		mm_slot->is_scanned = false;
+	}
+}
+
+static void kmmscand_migrate_folio(void)
+{
+	int ret = 0, dest = -1;
+	struct mm_struct *oldmm = NULL;
+	struct kmmscand_migrate_info *info, *tmp;
+
+	spin_lock(&kmmscand_migrate_lock);
+
+	if (!list_empty(&kmmscand_migrate_list.migrate_head)) {
+		list_for_each_entry_safe(info, tmp, &kmmscand_migrate_list.migrate_head,
+			migrate_node) {
+			if (READ_ONCE(kmmscand_migration_list_dirty)) {
+				kmmscand_migration_list_dirty = false;
+				list_del(&info->migrate_node);
+				/*
+				 * Do not try to migrate this entry because mm might have
+				 * vanished underneath.
+				 */
+				kfree(info);
+				spin_unlock(&kmmscand_migrate_lock);
+				goto dirty_list_handled;
+			}
+
+			list_del(&info->migrate_node);
+			/* Note down the mm of folio entry we are migrating */
+			WRITE_ONCE(kmmscand_cur_migrate_mm, info->mm);
+			spin_unlock(&kmmscand_migrate_lock);
+
+			if (info->mm) {
+				if (oldmm != info->mm) {
+					if(!mmap_read_trylock(info->mm)) {
+						dest = kmmscand_get_target_node(NULL);
+					} else {
+						dest = READ_ONCE(info->mm->target_node);
+						mmap_read_unlock(info->mm);
+					}
+					oldmm = info->mm;
+				}
+
+				ret = kmmscand_promote_folio(info, dest);
+				trace_kmem_scan_mm_migrate(info->mm, ret, dest);
+			}
+
+			/* TBD: encode migrated count here, currently assume folio_nr_pages */
+			if (!ret)
+				count_kmmscand_migrated();
+			else
+				count_kmmscand_migrate_failed();
+
+			kfree(info);
+
+			spin_lock(&kmmscand_migrate_lock);
+			/* Reset  mm  of folio entry we are migrating */
+			WRITE_ONCE(kmmscand_cur_migrate_mm, NULL);
+			spin_unlock(&kmmscand_migrate_lock);
+dirty_list_handled:
+			cond_resched();
+			spin_lock(&kmmscand_migrate_lock);
+		}
+	}
+	spin_unlock(&kmmscand_migrate_lock);
+}
+
+/*
+ * This is the normal change percentage when old and new delta remain same.
+ * i.e., either both positive or both zero.
+ */
+#define SCAN_PERIOD_TUNE_PERCENT	15
+
+/* This is to change the scan_period aggressively when deltas are different */
+#define SCAN_PERIOD_CHANGE_SCALE	3
+/*
+ * XXX: Hack to prevent unmigrated pages coming again and again while scanning.
+ * Actual fix needs to identify the type of unmigrated pages OR consider migration
+ * failures in next scan.
+ */
+#define KMMSCAND_IGNORE_SCAN_THR	100
+
+#define SCAN_SIZE_CHANGE_SCALE	1
+/*
+ * X : Number of useful pages in the last scan.
+ * Y : Number of useful pages found in current scan.
+ * Tuning scan_period:
+ *	Initial scan_period is 2s.
+ *	case 1: (X = 0, Y = 0)
+ *		Increase scan_period by SCAN_PERIOD_TUNE_PERCENT.
+ *	case 2: (X = 0, Y > 0)
+ *		Decrease scan_period by (2 << SCAN_PERIOD_CHANGE_SCALE).
+ *	case 3: (X > 0, Y = 0 )
+ *		Increase scan_period by (2 << SCAN_PERIOD_CHANGE_SCALE).
+ *	case 4: (X > 0, Y > 0)
+ *		Decrease scan_period by SCAN_PERIOD_TUNE_PERCENT.
+ * Tuning scan_size:
+ * Initial scan_size is 4GB
+ *	case 1: (X = 0, Y = 0)
+ *		Decrease scan_size by (1 << SCAN_SIZE_CHANGE_SCALE).
+ *	case 2: (X = 0, Y > 0)
+ *		scan_size = KMMSCAND_SCAN_SIZE_MAX
+ *  case 3: (X > 0, Y = 0 )
+ *		No change
+ *  case 4: (X > 0, Y > 0)
+ *		Increase scan_size by (1 << SCAN_SIZE_CHANGE_SCALE).
+ */
+static inline void kmmscand_update_mmslot_info(struct kmmscand_mm_slot *mm_slot,
+				unsigned long total, int target_node)
+{
+	unsigned int scan_period;
+	unsigned long now;
+	unsigned long scan_size;
+	unsigned long old_scan_delta;
+
+	/* XXX: Hack to get rid of continuously failing/unmigrateable pages */
+	if (total < KMMSCAND_IGNORE_SCAN_THR)
+		total = 0;
+
+	scan_period = mm_slot->scan_period;
+	scan_size = mm_slot->scan_size;
+
+	old_scan_delta = mm_slot->scan_delta;
+
+	/*
+	 * case 1: old_scan_delta and new delta are similar, (slow) TUNE_PERCENT used.
+	 * case 2: old_scan_delta and new delta are different. (fast) CHANGE_SCALE used.
+	 * TBD:
+	 * 1. Further tune scan_period based on delta between last and current scan delta.
+	 * 2. Optimize calculation
+	 */
+	if (!old_scan_delta && !total) {
+		scan_period = (100 + SCAN_PERIOD_TUNE_PERCENT) * scan_period;
+		scan_period /= 100;
+		scan_size = scan_size >> SCAN_SIZE_CHANGE_SCALE;
+	} else if (old_scan_delta && total) {
+		scan_period = (100 - SCAN_PERIOD_TUNE_PERCENT) * scan_period;
+		scan_period /= 100;
+		scan_size = scan_size << SCAN_SIZE_CHANGE_SCALE;
+	} else if (old_scan_delta && !total) {
+		scan_period = scan_period << SCAN_PERIOD_CHANGE_SCALE;
+	} else {
+		scan_period = scan_period >> SCAN_PERIOD_CHANGE_SCALE;
+		scan_size = KMMSCAND_SCAN_SIZE_MAX;
+	}
+
+	scan_period = clamp(scan_period, KMMSCAND_SCAN_PERIOD_MIN, KMMSCAND_SCAN_PERIOD_MAX);
+	scan_size = clamp(scan_size, KMMSCAND_SCAN_SIZE_MIN, KMMSCAND_SCAN_SIZE_MAX);
+
+	now = jiffies;
+	mm_slot->next_scan = now + msecs_to_jiffies(scan_period);
+	mm_slot->scan_period = scan_period;
+	mm_slot->scan_size = scan_size;
+	mm_slot->scan_delta = total;
+	mm_slot->target_node = target_node;
+}
+
+static unsigned long kmmscand_scan_mm_slot(void)
+{
+	bool next_mm = false;
+	bool update_mmslot_info = false;
+
+	unsigned int mm_slot_scan_period;
+	int target_node, mm_slot_target_node, mm_target_node;
+	unsigned long now;
+	unsigned long mm_slot_next_scan;
+	unsigned long mm_slot_scan_size;
+	unsigned long scanned_size = 0;
+	unsigned long address;
+	unsigned long total = 0;
+
+	struct mm_slot *slot;
+	struct mm_struct *mm;
+	struct vma_iterator vmi;
+	struct vm_area_struct *vma = NULL;
+	struct kmmscand_mm_slot *mm_slot;
+
+	/* Retrieve mm */
+	spin_lock(&kmmscand_mm_lock);
+
+	if (kmmscand_scan.mm_slot) {
+		mm_slot = kmmscand_scan.mm_slot;
+		slot = &mm_slot->slot;
+		address = mm_slot->address;
+	} else {
+		slot = list_entry(kmmscand_scan.mm_head.next,
+				     struct mm_slot, mm_node);
+		mm_slot = mm_slot_entry(slot, struct kmmscand_mm_slot, slot);
+		address = mm_slot->address;
+		kmmscand_scan.mm_slot = mm_slot;
+	}
+
+	mm = slot->mm;
+	mm_slot->is_scanned = true;
+	mm_slot_next_scan = mm_slot->next_scan;
+	mm_slot_scan_period = mm_slot->scan_period;
+	mm_slot_scan_size = mm_slot->scan_size;
+	mm_slot_target_node = mm_slot->target_node;
+	spin_unlock(&kmmscand_mm_lock);
+
+	if (unlikely(!mmap_read_trylock(mm)))
+		goto outerloop_mmap_lock;
+
+	if (unlikely(kmmscand_test_exit(mm))) {
+		next_mm = true;
+		goto outerloop;
+	}
+
+	if (!mm->pte_scan_scale) {
+		next_mm = true;
+		goto outerloop;
+	}
+
+	mm_target_node = READ_ONCE(mm->target_node);
+	/* XXX: Do we need write lock? */
+	if (mm_target_node != mm_slot_target_node)
+		WRITE_ONCE(mm->target_node, mm_slot_target_node);
+
+	trace_kmem_scan_mm_start(mm);
+
+	now = jiffies;
+
+	if (mm_slot_next_scan && time_before(now, mm_slot_next_scan))
+		goto outerloop;
+
+	vma_iter_init(&vmi, mm, address);
+	vma = vma_next(&vmi);
+	if (!vma) {
+		address = 0;
+		vma_iter_set(&vmi, address);
+		vma = vma_next(&vmi);
+	}
+
+	for_each_vma(vmi, vma) {
+		/* Count the scanned pages here to decide exit */
+		kmmscand_walk_page_vma(vma, &kmmscand_scanctrl);
+		count_kmmscand_vma_scans();
+		scanned_size += vma->vm_end - vma->vm_start;
+		address = vma->vm_end;
+
+		if (scanned_size >= mm_slot_scan_size) {
+			total = get_slowtier_accesed(&kmmscand_scanctrl);
+
+			/* If we had got accessed pages, ignore the current scan_size threshold */
+			if (total > KMMSCAND_IGNORE_SCAN_THR) {
+				mm_slot_scan_size = KMMSCAND_SCAN_SIZE_MAX;
+				continue;
+			}
+			next_mm = true;
+			break;
+		}
+
+		/* Add scanned folios to migration list */
+		spin_lock(&kmmscand_migrate_lock);
+		list_splice_tail_init(&kmmscand_scanctrl.scan_list, &kmmscand_migrate_list.migrate_head);
+		spin_unlock(&kmmscand_migrate_lock);
+	}
+
+	if (!vma)
+		address = 0;
+
+	update_mmslot_info = true;
+
+	count_kmmscand_mm_scans();
+
+	total = get_slowtier_accesed(&kmmscand_scanctrl);
+	target_node = get_target_node(&kmmscand_scanctrl);
+
+	mm_target_node = READ_ONCE(mm->target_node);
+
+	/* XXX: Do we need write lock? */
+	if (mm_target_node != target_node)
+		WRITE_ONCE(mm->target_node, target_node);
+
+	reset_scanctrl(&kmmscand_scanctrl);
+
+	if (update_mmslot_info) {
+		mm_slot->address = address;
+		kmmscand_update_mmslot_info(mm_slot, total, target_node);
+	}
+
+	trace_kmem_scan_mm_end(mm, address, total, mm_slot_scan_period,
+			mm_slot_scan_size, target_node);
+
+outerloop:
+	/* exit_mmap will destroy ptes after this */
+	mmap_read_unlock(mm);
+
+outerloop_mmap_lock:
+	spin_lock(&kmmscand_mm_lock);
+	VM_BUG_ON(kmmscand_scan.mm_slot != mm_slot);
+
+	/*
+	 * Release the current mm_slot if this mm is about to die, or
+	 * if we scanned all vmas of this mm.
+	 */
+	if (unlikely(kmmscand_test_exit(mm)) || !vma || next_mm) {
+		/*
+		 * Make sure that if mm_users is reaching zero while
+		 * kmmscand runs here, kmmscand_exit will find
+		 * mm_slot not pointing to the exiting mm.
+		 */
+		WARN_ON_ONCE(current->rcu_read_lock_nesting < 0);
+		if (slot->mm_node.next != &kmmscand_scan.mm_head) {
+			slot = list_entry(slot->mm_node.next,
+					struct mm_slot, mm_node);
+			kmmscand_scan.mm_slot =
+				mm_slot_entry(slot, struct kmmscand_mm_slot, slot);
+
+		} else
+			kmmscand_scan.mm_slot = NULL;
+
+		WARN_ON_ONCE(current->rcu_read_lock_nesting < 0);
+		if (kmmscand_test_exit(mm)) {
+			kmmscand_collect_mm_slot(mm_slot);
+			WARN_ON_ONCE(current->rcu_read_lock_nesting < 0);
+			goto end;
+		}
+	}
+	mm_slot->is_scanned = false;
+end:
+	spin_unlock(&kmmscand_mm_lock);
+	return total;
+}
+
+static void kmmscand_do_scan(void)
+{
+	unsigned long iter = 0, mms_to_scan;
+
+	mms_to_scan = READ_ONCE(kmmscand_mms_to_scan);
+
+	while (true) {
+		cond_resched();
+
+		if (unlikely(kthread_should_stop()) || !READ_ONCE(kmmscand_scan_enabled))
+			break;
+
+		if (kmmscand_has_work())
+			kmmscand_scan_mm_slot();
+
+		iter++;
+		if (iter >= mms_to_scan)
+			break;
+	}
+}
+
+static int kmmscand(void *none)
+{
+	for (;;) {
+		if (unlikely(kthread_should_stop()))
+			break;
+
+		kmmscand_do_scan();
+
+		while (!READ_ONCE(kmmscand_scan_enabled)) {
+			cpu_relax();
+			kmmscand_wait_work();
+		}
+
+		kmmscand_wait_work();
+	}
+	return 0;
+}
+
+#ifdef CONFIG_SYSFS
+extern struct kobject *mm_kobj;
+static int __init kmmscand_init_sysfs(struct kobject **kobj)
+{
+	int err;
+
+	err = sysfs_create_group(*kobj, &kmmscand_attr_group);
+	if (err) {
+		pr_err("failed to register kmmscand group\n");
+		goto err_kmmscand_attr;
+	}
+
+	return 0;
+
+err_kmmscand_attr:
+	sysfs_remove_group(*kobj, &kmmscand_attr_group);
+	return err;
+}
+
+static void __init kmmscand_exit_sysfs(struct kobject *kobj)
+{
+		sysfs_remove_group(kobj, &kmmscand_attr_group);
+}
+#else
+static inline int __init kmmscand_init_sysfs(struct kobject **kobj)
+{
+	return 0;
+}
+static inline void __init kmmscand_exit_sysfs(struct kobject *kobj)
+{
+}
+#endif
+
+static inline void kmmscand_destroy(void)
+{
+	kmem_cache_destroy(kmmscand_slot_cache);
+	kmmscand_exit_sysfs(mm_kobj);
+}
+
+void __kmmscand_enter(struct mm_struct *mm)
+{
+	struct kmmscand_mm_slot *kmmscand_slot;
+	struct mm_slot *slot;
+	unsigned long now;
+	int wakeup;
+
+	/* __kmmscand_exit() must not run from under us */
+	VM_BUG_ON_MM(kmmscand_test_exit(mm), mm);
+
+	kmmscand_slot = mm_slot_alloc(kmmscand_slot_cache);
+
+	if (!kmmscand_slot)
+		return;
+
+	now = jiffies;
+	kmmscand_slot->address = 0;
+	kmmscand_slot->scan_period = kmmscand_mm_scan_period_ms;
+	kmmscand_slot->scan_size = kmmscand_scan_size;
+	kmmscand_slot->next_scan = now +
+			msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
+	kmmscand_slot->scan_delta = 0;
+
+	slot = &kmmscand_slot->slot;
+
+	spin_lock(&kmmscand_mm_lock);
+	mm_slot_insert(kmmscand_slots_hash, mm, slot);
+
+	wakeup = list_empty(&kmmscand_scan.mm_head);
+	list_add_tail(&slot->mm_node, &kmmscand_scan.mm_head);
+	spin_unlock(&kmmscand_mm_lock);
+
+	mmgrab(mm);
+	trace_kmem_mm_enter(mm);
+	if (wakeup)
+		wake_up_interruptible(&kmmscand_wait);
+}
+
+void __kmmscand_exit(struct mm_struct *mm)
+{
+	struct kmmscand_mm_slot *mm_slot;
+	struct mm_slot *slot;
+	int free = 0, serialize = 1;
+
+	trace_kmem_mm_exit(mm);
+	spin_lock(&kmmscand_mm_lock);
+	slot = mm_slot_lookup(kmmscand_slots_hash, mm);
+	mm_slot = mm_slot_entry(slot, struct kmmscand_mm_slot, slot);
+	if (mm_slot && kmmscand_scan.mm_slot != mm_slot) {
+		hash_del(&slot->hash);
+		list_del(&slot->mm_node);
+		free = 1;
+	} else if (mm_slot && kmmscand_scan.mm_slot == mm_slot && !mm_slot->is_scanned) {
+		hash_del(&slot->hash);
+		list_del(&slot->mm_node);
+		free = 1;
+		/* TBD: Set the actual next slot */
+		kmmscand_scan.mm_slot = NULL;
+	} else if (mm_slot && kmmscand_scan.mm_slot == mm_slot && mm_slot->is_scanned) {
+		serialize = 0;
+	}
+
+	spin_unlock(&kmmscand_mm_lock);
+
+	if (serialize)
+		kmmscand_cleanup_migration_list(mm);
+
+	if (free) {
+		mm_slot_free(kmmscand_slot_cache, mm_slot);
+		mmdrop(mm);
+	} else if (mm_slot) {
+		mmap_write_lock(mm);
+		mmap_write_unlock(mm);
+	}
+}
+
+static int start_kmmscand(void)
+{
+	int err = 0;
+
+	guard(mutex)(&kmmscand_mutex);
+
+	/* Some one already succeeded in starting daemon */
+	if (kmmscand_thread)
+		goto end;
+
+	kmmscand_thread = kthread_run(kmmscand, NULL, "kmmscand");
+	if (IS_ERR(kmmscand_thread)) {
+		pr_err("kmmscand: kthread_run(kmmscand) failed\n");
+		err = PTR_ERR(kmmscand_thread);
+		kmmscand_thread = NULL;
+		goto end;
+	} else {
+		pr_info("kmmscand: Successfully started kmmscand");
+	}
+
+	if (!list_empty(&kmmscand_scan.mm_head))
+		wake_up_interruptible(&kmmscand_wait);
+
+end:
+	return err;
+}
+
+static int stop_kmmscand(void)
+{
+	int err = 0;
+
+	guard(mutex)(&kmmscand_mutex);
+
+	if (kmmscand_thread) {
+		kthread_stop(kmmscand_thread);
+		kmmscand_thread = NULL;
+	}
+
+	return err;
+}
+static int kmmmigrated(void *arg)
+{
+	for (;;) {
+		WRITE_ONCE(migrated_need_wakeup, false);
+		if (unlikely(kthread_should_stop()))
+			break;
+		if (kmmmigrated_has_work())
+			kmmscand_migrate_folio();
+		msleep(20);
+		kmmmigrated_wait_work();
+	}
+	return 0;
+}
+
+static int start_kmmmigrated(void)
+{
+	int err = 0;
+
+	guard(mutex)(&kmmmigrated_mutex);
+
+	/* Someone already succeeded in starting daemon */
+	if (kmmmigrated_thread)
+		goto end;
+
+	kmmmigrated_thread = kthread_run(kmmmigrated, NULL, "kmmmigrated");
+	if (IS_ERR(kmmmigrated_thread)) {
+		pr_err("kmmmigrated: kthread_run(kmmmigrated)  failed\n");
+		err = PTR_ERR(kmmmigrated_thread);
+		kmmmigrated_thread = NULL;
+		goto end;
+	} else {
+		pr_info("kmmmigrated: Successfully started kmmmigrated");
+	}
+
+	wake_up_interruptible(&kmmmigrated_wait);
+end:
+	return err;
+}
+
+static int stop_kmmmigrated(void)
+{
+	guard(mutex)(&kmmmigrated_mutex);
+	kthread_stop(kmmmigrated_thread);
+	return 0;
+}
+
+static void init_migration_list(void)
+{
+	INIT_LIST_HEAD(&kmmscand_migrate_list.migrate_head);
+	INIT_LIST_HEAD(&kmmscand_scanctrl.scan_list);
+	spin_lock_init(&kmmscand_migrate_lock);
+	init_waitqueue_head(&kmmscand_wait);
+	init_waitqueue_head(&kmmmigrated_wait);
+	init_scanctrl(&kmmscand_scanctrl);
+}
+
+static int __init kmmscand_init(void)
+{
+	int err;
+
+	kmmscand_slot_cache = KMEM_CACHE(kmmscand_mm_slot, 0);
+
+	if (!kmmscand_slot_cache) {
+		pr_err("kmmscand: kmem_cache error");
+		return -ENOMEM;
+	}
+
+	err = kmmscand_init_sysfs(&mm_kobj);
+
+	if (err)
+		goto err_init_sysfs;
+
+	init_migration_list();
+
+	err = start_kmmscand();
+	if (err)
+		goto err_kmmscand;
+
+	err = start_kmmmigrated();
+	if (err)
+		goto err_kmmmigrated;
+
+	return 0;
+
+err_kmmmigrated:
+	stop_kmmmigrated();
+
+err_kmmscand:
+	stop_kmmscand();
+err_init_sysfs:
+	kmmscand_destroy();
+
+	return err;
+}
+subsys_initcall(kmmscand_init);
diff --git a/mm/migrate.c b/mm/migrate.c
index fb19a18892c8..9d39abc7662a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2598,7 +2598,7 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
  * Returns true if this is a safe migration target node for misplaced NUMA
  * pages. Currently it only checks the watermarks which is crude.
  */
-static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
+bool migrate_balanced_pgdat(struct pglist_data *pgdat,
 				   unsigned long nr_migrate_pages)
 {
 	int z;
@@ -2656,7 +2656,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 		 * See folio_likely_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) &&
+		if ((vma && vma->vm_flags & VM_EXEC) &&
 		    folio_likely_mapped_shared(folio))
 			return -EACCES;
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 16bfe1c694dd..cb21441969c5 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1340,6 +1340,17 @@ const char * const vmstat_text[] = {
 	"numa_hint_faults_local",
 	"numa_pages_migrated",
 #endif
+#ifdef CONFIG_KMMSCAND
+	"nr_kmmscand_mm_scans",
+	"nr_kmmscand_vma_scans",
+	"nr_kmmscand_migadded",
+	"nr_kmmscand_migrated",
+	"nr_kmmscand_migrate_failed",
+	"nr_kmmscand_kzalloc_fail",
+	"nr_kmmscand_slowtier",
+	"nr_kmmscand_toptier",
+	"nr_kmmscand_idlepage",
+#endif
 #ifdef CONFIG_MIGRATION
 	"pgmigrate_success",
 	"pgmigrate_fail",


