Return-Path: <linux-kernel+bounces-568691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF41A6995E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E346316CCF1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EDC2147F8;
	Wed, 19 Mar 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NHUsEDeZ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BBA212FBD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412681; cv=fail; b=n7PQUxx0QS+IfvIFeSY3U18Ko8+Q2a4MvbNl+PRD6+EmqKhUwkV8SQQB7KkPqAXwlIFRUo2PERAf2sgjBvx3z/WdyfC7i1wTLyGd/8ZK85tnLaTPFADLtITKU4hnUcuhmbM7a8XIld32InFroi8EQrgCl0D3vcJUAJUEnhRE1v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412681; c=relaxed/simple;
	bh=2pUCrRZWlOG6fc23vIhfvL/s5SvBC38MUtr9NJCKhQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/sP+MgoNwAGHQIKf1DEJt4eVbSog85EB/UnGSOHFVAFvmb3FX0VbvPCxIkBA+fn0HE3tEVT+xyCXnK9QJ8XRIqoe8xWRURHzfa2B5HT3j5fXfLK60/BJhDjC91lu4AWybqZ2+veCU3TBPsSZ22Yx5qq5dMhcu/eoJQsorwR3XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NHUsEDeZ; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xk1QqGh6HBCRoIKnxFcZ2n//DJ1VX8R/RLfqy9TQGGdFkDbXRw/+sKX/VlQmhz/rrPlkXFxoyWh6wBfHRYAPKWPTrmHd9wC0GebVv6helMsYqo2rOYs4ldGG6N3hsm56XSo+O9tptPQsB7LgkKAEvdcPO/jIbC4Kp5dqMDDLwiy6aDmXMH/5Axcl3tQaCaaQ2Iw54x1mfQKsNIwzCssf29hU2hr52n9wcOQOe1ZwwT9sTMMrgOG+lekLfCeIqYbB4Dwe1+qtabYpufZiCFbtH04XUQv79GhHbBWOCIH8NYVFeEYw6ILk7erpfU0wKHC/N0tA7qwB+GUOUJOyhUMtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1YlgkAYpPVRIE0Exq0WZ36EVvjUeFBDZwrxw1q80i8=;
 b=wRirfef74xUPsuzFwZM5FpQyP0iCAv48ehirJYkgPSZXPBgBKKY7eJGTvDGaAuRnITiQpTPw44BCYkVSoijeJDJA5wkuCdz2ZUrWZoOk1iXRIw7hcEfbwZJt4S9vTJOQEruYk8OTd+qhRyQXXuLhBCDKMEvmpkW84rPJmMhKCADN5rXb4oyR1DXEpILyAKwONkfrPm0EMTKNmMNh2+IWNNJjf0moWKROfNLsgAkmG+LBx5XFpLRIDn/BHopTxnSLTVxuyyhsKJhLduTaiBnXG2x+sjDda6uVFb+0c6ML+j8iZx9D+C5FLhIG3xLQ9csNTcKrbYZB4bGs8/G6Hv/jaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1YlgkAYpPVRIE0Exq0WZ36EVvjUeFBDZwrxw1q80i8=;
 b=NHUsEDeZnSYaavYG0VPsefHnUOziaVjhbm8JatK9VWDk0dT9AKULm6iR8rVOuBQSRH/ZKRafcKqJ3wRP08euY47XsJ2UmLPoOfH+GsD8WGi/w580nHMQCNTW1y9LpB5JKhshK+JlMNz5AX1gNQCfZbW+ZckAKI4ekiMlzOLRYNM=
Received: from SA1P222CA0187.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::14)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:31:13 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::c5) by SA1P222CA0187.outlook.office365.com
 (2603:10b6:806:3c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:31:13 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:31:02 -0500
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
Subject: [RFC PATCH V1 01/13] mm: Add kmmscand kernel daemon
Date: Wed, 19 Mar 2025 19:30:16 +0000
Message-ID: <20250319193028.29514-2-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 8966c4a0-bc7f-44a7-2b6a-08dd671c9c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uOsbzxn9Ra/71b3QdilmFLcwsYqgpUH8zMdp5Ax2j3KUkZTt1blWU399UecF?=
 =?us-ascii?Q?QwEHWrSbSx1RCwQ1lKT3aRgkytNVHhitIxH0J62qi3Oyk8pBqRc0364V5Yag?=
 =?us-ascii?Q?qGlzJu4x7qNo16eBdtWcm22bD+3AWUoXCrpv6yMvCXaSVomIFS380EWlUJhD?=
 =?us-ascii?Q?c7mRi7HL4i+b2+tkkIBi72i1Nphw5FqKhPAEwf8Rc+JvMpx0yBZ9Ema3en6/?=
 =?us-ascii?Q?OhVeDqJSwATPY39rxxNx4AZu6+i4mKRMGUX9snlUL7rMrR5bUf5OODCGrdmE?=
 =?us-ascii?Q?vbJ+fSHDw98bPapVLq2Y/Dx+3j4QjJMx2Pzi0WzxOwStTuT/iqlX6dQPZmSU?=
 =?us-ascii?Q?GH/ukniK0yNXF8jWNh2C7uWlVDzeRP7QTaA/pZheFcFhwWwA97ioTaV6OzeE?=
 =?us-ascii?Q?ZGDs/tgrT4JBKa2DmPK31J5dYccFy1e8i9xE81ln6ROZ5fdOPOtKEbD+q4QP?=
 =?us-ascii?Q?pDIo2eqnHQ4pKEThhtbv2DLi63iCg+7Ahjwzdv5t1cWGG3/u65aCyICGHzcC?=
 =?us-ascii?Q?eE/ulAR2cGcFRDnQsUC+hHO7tuXXgJ6+m9SdcA3ed9TtwJU9GtZZUWwTNMXe?=
 =?us-ascii?Q?F3lBnZhRpx755OR8nFEZbTsB6ymA+ySJzXrUf3Fq9Qi14Eu9rl8BGj2oD/HS?=
 =?us-ascii?Q?WZ2r40OXANzApJnmz5SXNUpUFyOp9MDmp24ROyFaSfp+/jNdoYYdY01RilVw?=
 =?us-ascii?Q?UokQhG/DuKdqb0QpFY/TfIo97Hx+H1jw2kGolN9VyfDQA+X5z81lobaHL4gv?=
 =?us-ascii?Q?3aYvsiI8xWuPGmcMbIsIWNSapSc2AwLWEQ4WM2tM+VlbZ3f2bnzuhZpUz2hN?=
 =?us-ascii?Q?llNCWF1tKncjMWZPDQOCrYlRpRfx4Jyiemye+4AyawaMjplZgXfEf5qrMqfN?=
 =?us-ascii?Q?08Y8ZXXD3vC6sgYICsJ92HcyHQuObrWtyLfL4iYWB+Q85vj3C/+rrEvpd8z8?=
 =?us-ascii?Q?1TM45KDg5UZo506zDgAmNFcaUQnDktniFWdKWl8haOpNG0kVPJStTU90w8c3?=
 =?us-ascii?Q?iFAzznfMx0I072IuGpw/5gJmiHhPBz25EZjXC1Eg4hommyAnoZHjOrgtiLTa?=
 =?us-ascii?Q?zkpD+cgNahu8sufAPoJrmMThPKF27UghP4Ltc0C8jdqg2ixyoULboNA92oie?=
 =?us-ascii?Q?vqC2/SxKuU7SbA5ZH8hv4xUb45f1ZQZVfhMwS+OQWIL2f7DAi3jpVTNeWSp9?=
 =?us-ascii?Q?qvsV0m4Hsceb+dqiXkUEZzA80xmKBZUaKwCb+Zav1E9aemWnUf6kOSgYNx4x?=
 =?us-ascii?Q?dQGohjJ0Xir7Ajva61uScEoIIrqGIs0KyzAmioFvHmLILJpLg8er3PzgtGKU?=
 =?us-ascii?Q?9DTsEme197NdthIoMGLFDVEvw5do4Ahp/G0IMUrwc/ZTnH3PuwfLkW1FXRUw?=
 =?us-ascii?Q?RqprU7lvm75q3nUpFMqaIGBBk5ZZxpnFzpi8CQtVSm/Lms7XgkBBvjyDtoGW?=
 =?us-ascii?Q?R1bE6yzdmcGMZuth5X5k3w8oBAsEotNcTjwxc1KY0hPc0nseeDCuJjLwiD2H?=
 =?us-ascii?Q?TR8z1FeUhtpnR7A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:31:13.1620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8966c4a0-bc7f-44a7-2b6a-08dd671c9c2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258

Add a skeleton to support scanning and migration.
Also add a config option for the same.

High level design:

While (1):
  scan the slowtier pages belonging to VMAs of a task.
  Add to migation list

Separate thread:
  migrate scanned pages to a toptier node based on heuristics

The overall code is heavily influenced by khugepaged design.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/Kconfig    |   8 +++
 mm/Makefile   |   1 +
 mm/kmmscand.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 mm/kmmscand.c

diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db06417..5a4931633e15 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -783,6 +783,14 @@ config KSM
 	  until a program has madvised that an area is MADV_MERGEABLE, and
 	  root has set /sys/kernel/mm/ksm/run to 1 (if CONFIG_SYSFS is set).
 
+config KMMSCAND
+	bool "Enable PTE A bit scanning and Migration"
+	depends on NUMA_BALANCING
+	help
+	  Enable PTE A bit scanning of page. CXL pages accessed are migrated to
+	  a regular NUMA node. The option creates a separate kthread for
+	  scanning and migration.
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
index 000000000000..6c55250b5cfb
--- /dev/null
+++ b/mm/kmmscand.c
@@ -0,0 +1,176 @@
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
+bool kmmscand_scan_enabled = true;
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
+		if (unlikely(kthread_should_stop()) ||
+			!READ_ONCE(kmmscand_scan_enabled))
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
2.34.1


