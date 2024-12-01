Return-Path: <linux-kernel+bounces-426645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 919939DF642
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031E6B21603
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A39A1D14F8;
	Sun,  1 Dec 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sukvBRJl"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1251AD5A
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733067545; cv=fail; b=O6keAplz7TDGOshO4pDpQxLZqxXcuNQXIvQnPDwgw+To2b/uwfargVXGPUt9Pl1GxOSzPSmo7ZDPJVBU2DlYMAzl5MMMYlOHuYIVRFKbO30TArdX5uWIUi8I1+DEEwh1gHsGA8totiqqkloAZt9gQBVfupGdFJRu33lpJWizBWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733067545; c=relaxed/simple;
	bh=sn6DD+CwKrEhgJdEIwc+FPg5KR4Z47r5apppQmWtiBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQuoJGg+7rvyDs+FmY3Pk5LUJacEOmmHCEW4WtPLm6XFlTLOyb03BXcoEUpHI8MbDOVqd/kXqBh9nxHr62mjUuOdJY4RQ1sc+qV8yYUqOd0C9FOtJ6XltKdQECjDcuZ5OFDkgK7B39eSDNAUKEt3KYR3GARatwN8+LbWQSD6z7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sukvBRJl; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSPRPKRshsBxfOx4VewDpH+PJjc46AwGY37+pY6k4CgmdqafQW5x25z2iJWSvjvKJHvozOgp6r9rSLoqkcankO3nqIA5gZBUzcVOTWeSjdrbgTvPxQRFl/d9EJOI5GVBONo3Hg21UOLn1JhwdjfMD2lQ/4vUM6XIAHiuk4r5zmc+52Mkg6BkZqu1F/QNNT2UE1aj+HkQ6V9F0wgTHDygmnvKoLdm6XpfR51cJNR9c+aVY/o/pkBA8ydKtesJEFeLn3bvF+3RiLe0D0cSVwn+LaxaRBSW/pY2NOApvVXGOMH3Gc6qJUUcKCSuqDc1UBD0g7RHPKmoRL3Gi9qKD89uig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nlPY/6Qshc9zj3Hpbodb22GoEP29Mg/IgKDFMvsBNc=;
 b=Ld7owSr8YlAmmZQe7gtnP2q7CFA/AY15bYG+e6HbL8YR4CpHG5cvM2JrQUC04hig1jaOGJAnX0HavoG9YnnkYLrK1nkD18TKIfiUQTWbFv9VLEcYRVvmp3cI02VWhK6fnMlOnY6Ds5JSYRpGfkoB+Zns6JtjNsUWnMsLT7sPJOKedVyw2Hh7koX6MvdtSlHlLjHooR0eoF47aavaMsH0eWBUagf1gk2cdarfF7Lo+CbqwwHFyZUk8ERTBiz7WyaPDQK6qFaHyvXJqMs0Vg8RNuIZuHQBPluwSaq3dmqnrBK8U6+usryuhfNbVa2ie8kV4AMa2MKJYsvVBlPtwsNi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nlPY/6Qshc9zj3Hpbodb22GoEP29Mg/IgKDFMvsBNc=;
 b=sukvBRJlIkcMRJ+fn5riIQ4dkTu/zCBGkha0armeTp0BPWd905G4d/UVO6j0b0Y1Af4wXROe3tKA5pJf6BrG2hL4223lhOeP+XE4pyMb7zn2+jJt4FEx7WX5/MXmxfJufOTLZy3Mka4Eb4EOqqBWHzzNwWN5fHCTR6Hbpm8VxqQ=
Received: from MW4PR04CA0219.namprd04.prod.outlook.com (2603:10b6:303:87::14)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Sun, 1 Dec
 2024 15:38:58 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::48) by MW4PR04CA0219.outlook.office365.com
 (2603:10b6:303:87::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sun,
 1 Dec 2024 15:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Sun, 1 Dec 2024 15:38:56 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 09:38:49 -0600
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <gourry@gourry.net>,
	<nehagholkar@meta.com>, <abhishekd@meta.com>, <david@redhat.com>,
	<ying.huang@intel.com>, <nphamcs@gmail.com>, <akpm@linux-foundation.org>,
	<hannes@cmpxchg.org>, <feng.tang@intel.com>, <kbusch@meta.com>,
	<bharata@amd.com>, <Hasan.Maruf@amd.com>, <sj@kernel.org>
CC: <willy@infradead.org>, <kirill.shutemov@linux.intel.com>,
	<mgorman@techsingularity.net>, <vbabka@suse.cz>, <hughd@google.com>,
	<rientjes@google.com>, <shy828301@gmail.com>, <Liam.Howlett@Oracle.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, Raghavendra K T
	<raghavendra.kt@amd.com>
Subject: [RFC PATCH V0 01/10] mm: Add kmmscand kernel daemon
Date: Sun, 1 Dec 2024 15:38:09 +0000
Message-ID: <20241201153818.2633616-2-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241201153818.2633616-1-raghavendra.kt@amd.com>
References: <20241201153818.2633616-1-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 219beb38-5627-4a3c-1cf7-08dd121e44e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yvyWoAMG7HFH7o3xa+atHiKEqPOWqkz3Php0Yj1FzUj3UesWW4s7amGLZMKN?=
 =?us-ascii?Q?P9gZc07/J7XYYOFv9jy5G9L0iu21nvCYbO42G7RxvrFYq0q4sKatDZjL3fnM?=
 =?us-ascii?Q?hJyyRcBZMptD5h/w2XHTDy6YKRC9ezvUSwlKs8sxwTFqK4CHahb5e1yAvkxt?=
 =?us-ascii?Q?F03dnogHGEFFCCt6TPhmnrZk/NCCYbQkT/2y7ub2YQjZtmORANMzqmI6ecWj?=
 =?us-ascii?Q?eu/dYtVZJcEU0EitutumNRnb3N3+w0p+GAsP1FM1vLpM5P+ATsznUl143Pqw?=
 =?us-ascii?Q?BPY4uF4r2xSvpTf+xcm5wAyc9qyUrsXwPr8d19fyv1lQ41tIFnX7GTNaRi/X?=
 =?us-ascii?Q?LRmLz5PoYG78cei67Nnv0iEM3Jv6LGY4LoedV1CmyUsDp9yBTILNYCvAMITv?=
 =?us-ascii?Q?c2OptDkEwuKPQ+CoyPJ3wzORzYkbuFWvG2iLdksbbwEuNOzrKfaax2TWWLWC?=
 =?us-ascii?Q?n1F4pawcOzI9FgdJRdnZ/o/kQkKiisZfvDOysmWrOgpenQ78xDUN9JM4Y2i4?=
 =?us-ascii?Q?iFcCTHYvhEMjafpebs2YWgjCFEGsN8AaTdcuQ/s33pTF148SmgF+8v8Eg0Km?=
 =?us-ascii?Q?rxxnQbHgOXuIdXkGx0YD56Fj+gFUSgmmZ5UjctmBUoKc8bJFV0IqtZopGbxF?=
 =?us-ascii?Q?+t3xIADBzhu83V/dMzr3qYNCI36xRDQnuF5o1q6O49pMcVZLky/DWr6be7rc?=
 =?us-ascii?Q?WzhYjU8rqfqU8QR9cg5ynCGktgt7RrG16wgF/uZCqf14D0chB99sYbxYq2m1?=
 =?us-ascii?Q?1rEuG7/rz2DIQ1uSIomaL1UnRqUYUhzxnML72RIVoO83FvQ3XNmA/QCenj4u?=
 =?us-ascii?Q?LYBk2nmcku3vo9UQIdymdUrMfp87iOGq7XwWUy7ynyiFcmdAXUCSqPlnxgn1?=
 =?us-ascii?Q?n71R6Jj9Ht+eUNoAEALD7ghOMiecHEPBOh2d2/XqQzPstfbRDfOCiok7PgAS?=
 =?us-ascii?Q?TuIaUIPODQnRJrKvcVf+lBuiw/2PBtVgHRg7GhlOl7T42SdmEXLBnQyuBA1r?=
 =?us-ascii?Q?wN3V4S2hTHTbWP0Lzo6k68VDE2CJVVB6/qMtVsXzKp4miAzsk98FLC7QWXeP?=
 =?us-ascii?Q?gAO5phYc+DVG9cV97h9yV2sspvOvO1ZbJUEEfqMab6kCymDlSmuaiSXOqo2N?=
 =?us-ascii?Q?zvrC3k5o6o5WCQlFcjSXvH4IwFkM+2qOQxD3fft4O/nB2vtS2xAO6ZEkeaEb?=
 =?us-ascii?Q?o6f/wB5cLZS1Hah9rTjLuNKjXT/juNDXtHK/Ds/g0EMGheid0yy/W49PrXc3?=
 =?us-ascii?Q?OQQEygLWbMSffGxVvlV54SFDo5v6kbAesKzqmeXeypt5D+Kj36S/nn1X+cs1?=
 =?us-ascii?Q?6/myzDi0VRJFqhcSnm960BGC+tzSP6Ezp1zXFEpKnsuCpUCDl/kfYxNnzjyA?=
 =?us-ascii?Q?ZRN6DTv1kN3iQAC8NwyoeV9czeVcUCRj7gQxK40EA9ELLWdFQHWiMXaxwPA8?=
 =?us-ascii?Q?bp5xqNO5iB9qRhl4bMmdMHm7rrX2oMGJwXqLneQEvH2wl8y7FPVmRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 15:38:56.8878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 219beb38-5627-4a3c-1cf7-08dd121e44e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

Add a skeleton to support scanning and migration.
Also add a config option for the same.

High level design:

While (1):
  scan the slowtier pages belonging to VMAs of a task.
  Add to migation list
  migrate scanned pages to node 0 (default)

The overall code is heavily influenced by khugepaged design.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/Kconfig    |   7 ++
 mm/Makefile   |   1 +
 mm/kmmscand.c | 182 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 mm/kmmscand.c

diff --git a/mm/Kconfig b/mm/Kconfig
index 84000b016808..a0b5ab6a9b67 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -740,6 +740,13 @@ config KSM
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
index dba52bb0da8a..1b6b00e39d12 100644
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
index 000000000000..23cf5638fe10
--- /dev/null
+++ b/mm/kmmscand.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/mmu_notifier.h>
+#include <linux/swap.h>
+#include <linux/mm_inline.h>
+#include <linux/kthread.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/cleanup.h>
+
+#include <asm/pgalloc.h>
+#include "internal.h"
+
+
+static struct task_struct *kmmscand_thread __read_mostly;
+static DEFINE_MUTEX(kmmscand_mutex);
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
+
+static unsigned long kmmscand_sleep_expire;
+
+static DECLARE_WAIT_QUEUE_HEAD(kmmscand_wait);
+
+struct kmmscand_scan {
+	struct list_head mm_head;
+};
+
+struct kmmscand_scan kmmscand_scan = {
+	.mm_head = LIST_HEAD_INIT(kmmscand_scan.mm_head),
+};
+
+static int kmmscand_has_work(void)
+{
+	return !list_empty(&kmmscand_scan.mm_head);
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
+static void kmmscand_wait_work(void)
+{
+	if (kmmscand_has_work()) {
+		const unsigned long scan_sleep_jiffies =
+			msecs_to_jiffies(kmmscand_scan_sleep_ms);
+
+		if (!scan_sleep_jiffies)
+			return;
+
+		kmmscand_sleep_expire = jiffies + scan_sleep_jiffies;
+		wait_event_timeout(kmmscand_wait,
+					     kmmscand_should_wakeup(),
+					     scan_sleep_jiffies);
+		return;
+	}
+}
+
+static void kmmscand_migrate_folio(void)
+{
+}
+
+static unsigned long kmmscand_scan_mm_slot(void)
+{
+	/* placeholder for scanning */
+	msleep(100);
+	return 0;
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
+		kmmscand_migrate_folio();
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
+
+static int __init kmmscand_init(void)
+{
+	int err;
+
+	err = start_kmmscand();
+	if (err)
+		goto err_kmmscand;
+
+	return 0;
+
+err_kmmscand:
+	stop_kmmscand();
+
+	return err;
+}
+subsys_initcall(kmmscand_init);
-- 
2.39.3


