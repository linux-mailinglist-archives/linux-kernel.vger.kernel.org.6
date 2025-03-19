Return-Path: <linux-kernel+bounces-568693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48331A69964
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA39481312
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83032153C5;
	Wed, 19 Mar 2025 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rcFspfru"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBEF215162
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412690; cv=fail; b=IwaT1d2mUUCgK6TxmbjTxJOS/SeW2+bPAyLbZllhx0afLuqoWzd87/GublY37GQBXQviWP21YIJxAETeSmDAlL4O2yIPRBny2zIMT0nHJ+KfLjR926vq0wLilat9ZnpTrZWmtTYaNZKW5R/kT60wGABx9/3Ctsc2e9Ds6gIBGT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412690; c=relaxed/simple;
	bh=ksY23e3UlOZAYayDclYl6xxMuiuQfRlkLaJxhW3SZx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tg5du7Uod5JJdpbLmvNUpt9e71zDH9GcCTyP3h4TDIvtDzMKIAVLha1fVXVlU35GW2TfE47TRAseTxl83uLFacYD0Dm9kjTmFKdDIJYNK8p8qbEJW++PCEB9VGzkwP2oxh5BonLQC/UxU87Z/+c1gfgdeFFhc2nzI53eNOB4iCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rcFspfru; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kibCpY+AWIHnpIBsHswAK7OW9k8W0vfpD4oZeaGnpRyaTaoPs1NooAsWgc/bp1oep/N5HQAWXVxmKNId6bVE8MYl53R1DZZMKHZSJ1KBQJijIQTOs90osHu4Ki+9Rj9gHjQPKta91IeDE7T7nQZNRAjdKgLByMg18MVfGTbpKUvezQ7T7cGkGR1Z20w9+cQberO9lGagvw+sp+1f53LN3bd/yaoXCq4XrvpqRlfHvTJMBpCNaNDcoH78ZwNKMc7p+rG3wy95MtZcbA8fW9MRWXWoOJp97RtfgYY6ULUYs3Rb3gysWK3HvHv6chGhCVfH2VqK1pb9ETyAbVpa13nmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zAsfk1Gi/fQowp0bKiSXni4gGILQhtwytmUrsvnI2k=;
 b=BQxN1+zoYrzxYDKXDthRpMaUaTcmQV4i80r86u5rVouBhOGvaasLvkBGiwlM/LwHMuxCVyC6pIvykXJex3cLoO3+/BDa6P+t48PSu5TfUp/akkmkum0gByFvYszDcCwARkQ7UQmhZe7IEj/UEocRq7jIDRRYsQsmFSmWiyiflnPtgTybTR2eIRPQeuwduIA35tgd4JvYoY5gESSNeeSaiDphW5/EcifTxsUPqGsX1J2cD357Jgujuy04YlMtqWdVGjh+eJ/0lQbh/xmvuKMoz/HE45kPo4Y3ZIZMt+y2ZiRBTYKa2NJ3DhiyUaFN28iGtV/Viu3qrJk7W3S3xCZjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zAsfk1Gi/fQowp0bKiSXni4gGILQhtwytmUrsvnI2k=;
 b=rcFspfruOE/sAd/tYVASi3Ib8RxA4n+CSPANb6WncngYZwng7fYy3Xg0hB62tpvH1wDEMiZrnOZhmLpB0fzsVVp1Zm19X0WGugptC4J8Miqe4xZhQnL495gjjpphGLEfTxm6199RsWG4herI3gEh4ptSl2gc84tItucGYC/xpYE=
Received: from SA9PR10CA0015.namprd10.prod.outlook.com (2603:10b6:806:a7::20)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:31:23 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::85) by SA9PR10CA0015.outlook.office365.com
 (2603:10b6:806:a7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:31:22 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:31:12 -0500
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
Subject: [RFC PATCH V1 02/13] mm: Maintain mm_struct list in the system
Date: Wed, 19 Mar 2025 19:30:17 +0000
Message-ID: <20250319193028.29514-3-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e91f9a3-0125-4018-4357-08dd671ca186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dexsYIeqHGJqJtQI2EXSAibliOi3YzKMApOlwl2TqowRFfLgxr1MOTyuSD7P?=
 =?us-ascii?Q?vOFhWadrbBOa5bdaxUiHpruKEBwTJt0W0epoh1bzTuQrIoMERDwMLoWdPgYR?=
 =?us-ascii?Q?jrjO8E8CMLSR+WadaTCmJX6XkMXE13JehXlw5vXEdy39m6i5Mk78wwlnExHh?=
 =?us-ascii?Q?/8671u9iqowCP0chs7KdC2dgQo9gpwtxlBnHnfGtkqy+AUPzky1W0zK/WVPJ?=
 =?us-ascii?Q?6/WBijiJbV5/MVGTMf2xPJGz5nny2x9HDTkW1CvCm/dpvQhuiKUgRtZ5pXu9?=
 =?us-ascii?Q?gjwdK1WJy8FBv2nRh5xET80sws4Zht1wdTkl69PEi0rYzsH70/415UHc6rZK?=
 =?us-ascii?Q?Xk5+yEFs2H0cbJXTXRZ79r8ldgKRQtVtj0vIPh6u8Xtkx2ulBbb1okXiWiIu?=
 =?us-ascii?Q?f2S+YNf7INExZvbSrVEInhsuvt0SmjMlah2Y+kYTRjKZ6BPfwrXaDMDJwWmt?=
 =?us-ascii?Q?mMftKTAX3AF24p95kE7PV3qLKlr7bib3QXUShKRb0KM1Em2U93ekvn+5GdQH?=
 =?us-ascii?Q?o4FZjy4l9IzX85HHoE97IoLMIEoE/pEPHp5owgn9Fffpo2SBSdcJPej40OAZ?=
 =?us-ascii?Q?Up6TTW0+p2YZ5m7Xr4fMdw0wQY08Hsh2GwjCFOvvqRFh/7VdGvY3enIdVEiw?=
 =?us-ascii?Q?n744sPTQ99LyZAfnuAWeCg3UZso/bIJpttI6tlKceoXJwUoJitDIML62JaFc?=
 =?us-ascii?Q?x4rAuYS9VONsmtqK2c5GhLwg1vVLly9oqsUhOW3V3eWpNl/snk6+B1JcRJwt?=
 =?us-ascii?Q?vdlatmQE6xZCtETCkgtdosMx45M/3jagSSgabe9kCVWywMdR1Tj3vPfhmPVl?=
 =?us-ascii?Q?t3iKzCoCbTEaZnamQ4x/TlsGeFeuCA6LIZyOzZWEkJuBjXv4cCeDIleBB85v?=
 =?us-ascii?Q?K+lqqCG9w/eR5LtK5sWiDlNOMhTzgP9KDTtm2jcPQZ17WLqM1zVqJ2OZYEwy?=
 =?us-ascii?Q?WI17xeVHrh/3QjCBDO7r6+Xmim5FpTEuzafLDKX1EMqxTZyIL/fls5+8/gRu?=
 =?us-ascii?Q?L8zM2/TCdSJzr8Px5zx78OWJjjXeEzzdTZIxYWSHMSI7o9//y6nKxlu5xLug?=
 =?us-ascii?Q?GWywB2OwtgDpZD81RysEfb8B1pJHYB8JSbl+UNgmvq+XDfC9HuX+VLXp4f95?=
 =?us-ascii?Q?4X2gzzoKrKZ3LcO+02ZHpT97WR2usYIDfq3ssGmv3POznNnIh2mzkGL1wFCX?=
 =?us-ascii?Q?Mvbpcs9hBT87di6FGNiMyqaPvtIpLv6rbhrSAbSnZY8flN3PEUZVtJVNyM+y?=
 =?us-ascii?Q?WX8YEia30F45p9oL8zzdW2BkpdWbNOb2XC6EAO/Nci+oTEE8DgDnTfuMD30T?=
 =?us-ascii?Q?okg268RRAYxtzGdpSo/GsmFKCh1rj6QxSMc/CPqY9Zv7Ig4epp4VIhkOJ1VX?=
 =?us-ascii?Q?MzCwCk5V41htmvybGZ+8iA0nVdvNCdUJRxDoFvtVou67+k2C55Uzy1yk296U?=
 =?us-ascii?Q?KUUdowAO3BQH3UWkvN+vE2t+2h1xN3jFRsLJ0e75aVHBvIuqhD8NLmr8Xa/A?=
 =?us-ascii?Q?tcujGCjIiJXwT/A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:31:22.2373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e91f9a3-0125-4018-4357-08dd671ca186
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675

Add a hook in the fork and exec path to link mm_struct.
Reuse the mm_slot infrastructure to aid insert and lookup of mm_struct.

CC: linux-fsdevel@vger.kernel.org
Suggested-by: Bharata B Rao <bharata@amd.com>

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 fs/exec.c                |  4 ++
 include/linux/kmmscand.h | 30 ++++++++++++++
 kernel/fork.c            |  4 ++
 mm/kmmscand.c            | 86 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/kmmscand.h

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
diff --git a/include/linux/kmmscand.h b/include/linux/kmmscand.h
new file mode 100644
index 000000000000..b120c65ee8c6
--- /dev/null
+++ b/include/linux/kmmscand.h
@@ -0,0 +1,30 @@
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
diff --git a/kernel/fork.c b/kernel/fork.c
index 735405a9c5f3..f61c55cf33c2 100644
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
@@ -656,6 +657,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	mm->exec_vm = oldmm->exec_vm;
 	mm->stack_vm = oldmm->stack_vm;
 
+	kmmscand_fork(mm, oldmm);
+
 	/* Use __mt_dup() to efficiently build an identical maple tree. */
 	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
 	if (unlikely(retval))
@@ -1353,6 +1356,7 @@ static inline void __mmput(struct mm_struct *mm)
 	exit_aio(mm);
 	ksm_exit(mm);
 	khugepaged_exit(mm); /* must run before exit_mmap */
+	kmmscand_exit(mm);
 	exit_mmap(mm);
 	mm_put_huge_zero_folio(mm);
 	set_mm_exe_file(mm, NULL);
diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 6c55250b5cfb..36d0fea31dea 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -7,13 +7,14 @@
 #include <linux/swap.h>
 #include <linux/mm_inline.h>
 #include <linux/kthread.h>
+#include <linux/kmmscand.h>
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/cleanup.h>
 
 #include <asm/pgalloc.h>
 #include "internal.h"
-
+#include "mm_slot.h"
 
 static struct task_struct *kmmscand_thread __read_mostly;
 static DEFINE_MUTEX(kmmscand_mutex);
@@ -30,10 +31,21 @@ static bool need_wakeup;
 
 static unsigned long kmmscand_sleep_expire;
 
+static DEFINE_SPINLOCK(kmmscand_mm_lock);
 static DECLARE_WAIT_QUEUE_HEAD(kmmscand_wait);
 
+#define KMMSCAND_SLOT_HASH_BITS 10
+static DEFINE_READ_MOSTLY_HASHTABLE(kmmscand_slots_hash, KMMSCAND_SLOT_HASH_BITS);
+
+static struct kmem_cache *kmmscand_slot_cache __read_mostly;
+
+struct kmmscand_mm_slot {
+	struct mm_slot slot;
+};
+
 struct kmmscand_scan {
 	struct list_head mm_head;
+	struct kmmscand_mm_slot *mm_slot;
 };
 
 struct kmmscand_scan kmmscand_scan = {
@@ -70,6 +82,11 @@ static void kmmscand_wait_work(void)
 	return;
 }
 
+static inline int kmmscand_test_exit(struct mm_struct *mm)
+{
+	return atomic_read(&mm->mm_users) == 0;
+}
+
 static unsigned long kmmscand_scan_mm_slot(void)
 {
 	/* placeholder for scanning */
@@ -117,6 +134,65 @@ static int kmmscand(void *none)
 	return 0;
 }
 
+static inline void kmmscand_destroy(void)
+{
+	kmem_cache_destroy(kmmscand_slot_cache);
+}
+
+void __kmmscand_enter(struct mm_struct *mm)
+{
+	struct kmmscand_mm_slot *kmmscand_slot;
+	struct mm_slot *slot;
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
+	if (wakeup)
+		wake_up_interruptible(&kmmscand_wait);
+}
+
+void __kmmscand_exit(struct mm_struct *mm)
+{
+	struct kmmscand_mm_slot *mm_slot;
+	struct mm_slot *slot;
+	int free = 0;
+
+	spin_lock(&kmmscand_mm_lock);
+	slot = mm_slot_lookup(kmmscand_slots_hash, mm);
+	mm_slot = mm_slot_entry(slot, struct kmmscand_mm_slot, slot);
+	if (mm_slot && kmmscand_scan.mm_slot != mm_slot) {
+		hash_del(&slot->hash);
+		list_del(&slot->mm_node);
+		free = 1;
+	}
+
+	spin_unlock(&kmmscand_mm_lock);
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
 static int start_kmmscand(void)
 {
 	int err = 0;
@@ -162,6 +238,13 @@ static int __init kmmscand_init(void)
 {
 	int err;
 
+	kmmscand_slot_cache = KMEM_CACHE(kmmscand_mm_slot, 0);
+
+	if (!kmmscand_slot_cache) {
+		pr_err("kmmscand: kmem_cache error");
+		return -ENOMEM;
+	}
+
 	err = start_kmmscand();
 	if (err)
 		goto err_kmmscand;
@@ -170,6 +253,7 @@ static int __init kmmscand_init(void)
 
 err_kmmscand:
 	stop_kmmscand();
+	kmmscand_destroy();
 
 	return err;
 }
-- 
2.34.1


