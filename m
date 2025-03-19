Return-Path: <linux-kernel+bounces-568673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB937A6992A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3CA484050
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B5F213235;
	Wed, 19 Mar 2025 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q1bOdpHS"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7032F37
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412247; cv=fail; b=u9CiTq3/ZFIcYbUvJ2fG4GrS+m8CS/eH0m+uQz6QfOnHStqWFxsa3J+nI/2a2bKalUTdBOeWUxg3u70NY2g2QxhA8N0Gb0qI1k8NzRWPyYrtAbyqcCVv2cW+9GpN9S4uh8svDYyePHwE2Q8CknhUhPSdQc4bGYq/LqwQYjPK0BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412247; c=relaxed/simple;
	bh=UNCaA9yZBYICy2B4JAN8lZACfzZkBLeh6Vt6HoJODS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOJI4DnUmEP49M1mdTJN+Z7IAUAN+cbbNGf3j/lw38DkpPssn0bvAm6n5PsKmJM+c0gDx1c8sJnDu1jr6O/JuV9bONOR/DQQivcMggQIgi9QWcx0h/FxCkB5du4V+FRqpZ8ZDkVAqR/EXBRzYCJN6utESMSW/28m0Qt4QT1J8FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q1bOdpHS; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUieM0gYppq/RbWGvc33RPxKs0d9/Gd1bcKiCxDAgTiKlaZPQELdyyclNAp0ItjQ45NFgkyN+feBUK4LEZFDJN8S5XEIOOnl5/TArtIxm46iUlEPtUj6m7rsOFoyHXShfmvSlc0iMymPZRNwTvT2Gy2Ej2jHKVN24HAqcVDInIjY3ukOgB5rddjb8JenkOEUVtxp93x68jciSr8IpfuQZpoEgNRj4U9Y9TT8JBUBKQtBRD/6U7xgi29tvJbFi2i0/6ILP94i9mvyL6k9LZxuCVxLajkDyh/fWz8H1aCRad3hCvcfMIxiEr9rh1RKnGLAR9IDLrgU8mQyuwA0NXWVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flOo3vLO2rJeiBptjrTWYFaJiojxSG0aBTYgf9G0Q9s=;
 b=XlNAhSEkmKEAm1qJSKRwbsv9LLdFPftwEJ6AWI5pFnixBALHFlzEVwDzWzFzN6k14cwXDsxJlpacYp6K7sRJhqI29311CwGtXJgh/92VWyNCJP6WTHWC8gp+drtBV+4TyqL9ukUxyABCqo4ez8FMVi+bN0h4BmXhQlYT1BbmzQuuU2MDbiLGuDaye02tg2YUqM7pHP4lEeUVlbsV6THHPFxV8QgShM5dOr59kRrjAm7nuCl8M1W1ltTy+hvgKuJYtLrI/oBDr76mnxnv7zLkQVDNdLn9I2iuAr/Bkxdxf1BXfQnjvsYvD7ocQcq/wnSSQvvsqDL21EGwi+4q/7/TQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flOo3vLO2rJeiBptjrTWYFaJiojxSG0aBTYgf9G0Q9s=;
 b=q1bOdpHSzm+929plILyPP2MaFBZQkRuCDkqUtOBtd/Bpi7Vu6FEMrc+WnyCAuZY4ZKCrElbZAMUm4osSJA1ejWM/CxmmY3d+zqzI7rIReOgfbq3hBxs24gid7m3Gh5avDGmD6SGXIdfs++9xVjAVqCrM9pqyMpVLmrGMueYnUxE=
Received: from CH0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:32::20)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:23:59 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::de) by CH0PR07CA0015.outlook.office365.com
 (2603:10b6:610:32::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:23:58 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:23:50 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>, <ziy@nvidia.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <baolin.wang@linux.alibaba.com>,
	<bharata@amd.com>, <david@redhat.com>, <gregory.price@memverge.com>,
	<honggyu.kim@sk.com>, <jane.chu@oracle.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <leesuyeon0506@gmail.com>,
	<leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <mel.gorman@gmail.com>,
	<Michael.Day@amd.com>, <Raghavendra.KodsaraThimmappa@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>,
	<wangkefeng.wang@huawei.com>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <anannara@amd.com>, <wei.huang2@amd.com>,
	<Jonathan.Cameron@huawei.com>, <hyeonggon.yoo@sk.com>, <byungchul@sk.com>
Subject: [PATCH RFC V2 6/9] mm/migrate: introduce multi-threaded page copy routine
Date: Wed, 19 Mar 2025 19:22:09 +0000
Message-ID: <20250319192211.10092-7-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319192211.10092-1-shivankg@amd.com>
References: <20250319192211.10092-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 782e3ac6-43ea-462c-fa77-08dd671b9926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MzvXbJP6hhfW9pg5Pbpd3JDkG0nWx8nG9XvPpl717xPcaQv4uot6gkGyEiUV?=
 =?us-ascii?Q?eZvXgeIxYEkOyIf4XHlhIh3wQnpxTgkY6XtZK8rVUhH0JcXam8ljtyE3IJUd?=
 =?us-ascii?Q?uhyUgQFxV/mXillyndg5fUo5CWpJvuvtEPwUiGbjZjRzLe0aWzcpRrnp6Pqr?=
 =?us-ascii?Q?K3y1KPqndhQ4/uJovRFRaVDKDlwAlszv0ifWXjdPIClrOuPhLV8T9BNb2gF/?=
 =?us-ascii?Q?NpgMemk344gFgAOR2avQf/a0CfMJ2xRn7kxbC612au4spFSikE6xslp209HB?=
 =?us-ascii?Q?GcF1CqA9ztLUOOZ1+WwACxDyhvQzEVq/Dxhed1qLurBSah7CfrNC9y52G4yP?=
 =?us-ascii?Q?E+2H7LuiUWQxRNBcy5itCLxfBfftDXwlW+bkGpn74reEb6WVWAV/J6FKMz7M?=
 =?us-ascii?Q?cW8Xvn5mlmf6w2hzKAAGUXreKiqGWtTydGOauGzhIP4aE3ZRr3YFA2ICq5c/?=
 =?us-ascii?Q?MKOQQQG1ZiOvVpmFfEzYu8NMjiDLqA7QBNHZGGCvDuzBw8CBXnbgZeYBgdpY?=
 =?us-ascii?Q?cPdQk/One5B5yYt9JBUgKcBMS7HuCg7CsOwk0N+XZTM44tt3ENHTL9R6zyAL?=
 =?us-ascii?Q?qxwMEEZt/hVfqGFkE1vOT13RH3BRic/WM0370feNDrEyLXiNm2VAT9jLi4Fq?=
 =?us-ascii?Q?dhqmGx5gJwnuBY/o4UoWu0EzdYIeC5bSEXyBYmnm5hoEN8XaIvdzzNIsECJq?=
 =?us-ascii?Q?LfZ9QMsNXtMJAYoSQeGRTg/iZ1SpMheHmORJgzzOPlq4oqqvPW2nqTbwjgrc?=
 =?us-ascii?Q?jckZXS79SHd+m4EXSNCdHyEduJcKdNiXzf0De2ajW+SlJnrIDm7e5ScNAhO1?=
 =?us-ascii?Q?8M4cui4WZe0lNSPy7Kjfnkz2jl96jlcw7ek3ZPyG9VmpEzfrabUEJSGN6l2l?=
 =?us-ascii?Q?ExoQZHrWXemFsE8/ZuDyquK/BNV4OdANHKK2AnlODqSmmnVExA//i5xtU+5c?=
 =?us-ascii?Q?yMUlH7dFn6vMYHm1e3IjNN4aPcNnrnrSiWZYlybhA3xrMOH3Hz8EFfdVODPu?=
 =?us-ascii?Q?K2sYvPVurPVns/iAHeGSOgSfrwyll79zJqdElmbr/4KpEz1/wGrLP6L8zARS?=
 =?us-ascii?Q?I9gPLF9ZBRgOBTO/M42LWKn0V5imSUrA2fdMNaCT3NVlM2pirGrBUungPEVQ?=
 =?us-ascii?Q?2VbCSDumN43qdDUWzadvJYhlPTOvgSoR9Nj9AsogWb8yvMJIgc/KH5EVtqjJ?=
 =?us-ascii?Q?ALOecFf3giskAXEx2j41PoFbgwmFadzCaub0pJZhkbMq+1O+CI6rdM51/Gax?=
 =?us-ascii?Q?BX7wQPG/ssoqiOdycQG7EmMro9Rdfzdl3FzN5GhrIxbJU/nMjAc61CBF68IY?=
 =?us-ascii?Q?UlQ+PgjdamyajH5idcbCL8akjXd+2+nxJNim98/YRsYdLBrJ2eDQiU5f7yoI?=
 =?us-ascii?Q?ZfiWLDyjCJOVJaT0SuNgQe1PbN9v6NqWFNWqxNc1EmDiwQahnvHbDXKY1UYA?=
 =?us-ascii?Q?HI7V6xCiEd9BHsX4duz2Y+iv2zeD8Ny+F70sLS9sfC/0Z2o7SuWefqABm3ot?=
 =?us-ascii?Q?Te+5WRaZ7o1cqB8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:23:58.5849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 782e3ac6-43ea-462c-fa77-08dd671b9926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563

From: Zi Yan <ziy@nvidia.com>

Now page copies are batched, multi-threaded page copy can be used to
increase page copy throughput.

Enable using:
echo 1 >  /sys/kernel/cpu_mt/offloading
echo NR_THREADS >  /sys/kernel/cpu_mt/threads

Disable:
echo 0 >  /sys/kernel/cpu_mt/offloading

[Shivank: Convert the original MT copy_pages implementation into a
module, leveraging migrate offload infrastructure and sysfs interface.]

Signed-off-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/Kconfig                        |   2 +
 drivers/Makefile                       |   3 +
 drivers/migoffcopy/Kconfig             |   9 +
 drivers/migoffcopy/Makefile            |   1 +
 drivers/migoffcopy/mtcopy/Makefile     |   1 +
 drivers/migoffcopy/mtcopy/copy_pages.c | 337 +++++++++++++++++++++++++
 mm/migrate.c                           |  11 +-
 7 files changed, 357 insertions(+), 7 deletions(-)
 create mode 100644 drivers/migoffcopy/Kconfig
 create mode 100644 drivers/migoffcopy/Makefile
 create mode 100644 drivers/migoffcopy/mtcopy/Makefile
 create mode 100644 drivers/migoffcopy/mtcopy/copy_pages.c

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 7bdad836fc62..2e20eb83cd0b 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -245,4 +245,6 @@ source "drivers/cdx/Kconfig"
 
 source "drivers/dpll/Kconfig"
 
+source "drivers/migoffcopy/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 45d1c3e630f7..4df928a36ea3 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -42,6 +42,9 @@ obj-y				+= clk/
 # really early.
 obj-$(CONFIG_DMADEVICES)	+= dma/
 
+# Migration copy Offload
+obj-$(CONFIG_OFFC_MIGRATION)	+= migoffcopy/
+
 # SOC specific infrastructure drivers.
 obj-y				+= soc/
 obj-$(CONFIG_PM_GENERIC_DOMAINS)	+= pmdomain/
diff --git a/drivers/migoffcopy/Kconfig b/drivers/migoffcopy/Kconfig
new file mode 100644
index 000000000000..e73698af3e72
--- /dev/null
+++ b/drivers/migoffcopy/Kconfig
@@ -0,0 +1,9 @@
+config MTCOPY_CPU
+       bool "Multi-Threaded Copy with CPU"
+       depends on OFFC_MIGRATION
+       default n
+       help
+         Interface MT COPY CPU driver for batch page migration
+         offloading. Say Y if you want to try offloading with
+         MultiThreaded CPU copy APIs.
+
diff --git a/drivers/migoffcopy/Makefile b/drivers/migoffcopy/Makefile
new file mode 100644
index 000000000000..0a3c356d67e6
--- /dev/null
+++ b/drivers/migoffcopy/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MTCOPY_CPU) += mtcopy/
diff --git a/drivers/migoffcopy/mtcopy/Makefile b/drivers/migoffcopy/mtcopy/Makefile
new file mode 100644
index 000000000000..b4d7da85eda9
--- /dev/null
+++ b/drivers/migoffcopy/mtcopy/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MTCOPY_CPU) += copy_pages.o
diff --git a/drivers/migoffcopy/mtcopy/copy_pages.c b/drivers/migoffcopy/mtcopy/copy_pages.c
new file mode 100644
index 000000000000..4c9c7d90c9fd
--- /dev/null
+++ b/drivers/migoffcopy/mtcopy/copy_pages.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Parallel page copy routine.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/init.h>
+#include <linux/sysctl.h>
+#include <linux/sysfs.h>
+#include <linux/highmem.h>
+#include <linux/workqueue.h>
+#include <linux/slab.h>
+#include <linux/migrate.h>
+#include <linux/migrate_offc.h>
+
+#define MAX_NUM_COPY_THREADS 64
+
+unsigned int limit_mt_num = 4;
+static int is_dispatching;
+
+static int copy_page_lists_mt(struct list_head *dst_folios,
+		struct list_head *src_folios, int nr_items);
+static bool can_migrate_mt(struct folio *dst, struct folio *src);
+
+static DEFINE_MUTEX(migratecfg_mutex);
+
+/* CPU Multithreaded Batch Migrator */
+struct migrator cpu_migrator = {
+	.name = "CPU_MT_COPY\0",
+	.migrate_offc = copy_page_lists_mt,
+	.can_migrate_offc = can_migrate_mt,
+	.owner = THIS_MODULE,
+};
+
+struct copy_item {
+	char *to;
+	char *from;
+	unsigned long chunk_size;
+};
+
+struct copy_page_info {
+	struct work_struct copy_page_work;
+	int ret;
+	unsigned long num_items;
+	struct copy_item item_list[];
+};
+
+static unsigned long copy_page_routine(char *vto, char *vfrom,
+	unsigned long chunk_size)
+{
+	return copy_mc_to_kernel(vto, vfrom, chunk_size);
+}
+
+static void copy_page_work_queue_thread(struct work_struct *work)
+{
+	struct copy_page_info *my_work = (struct copy_page_info *)work;
+	int i;
+
+	my_work->ret = 0;
+	for (i = 0; i < my_work->num_items; ++i)
+		my_work->ret |= !!copy_page_routine(my_work->item_list[i].to,
+					my_work->item_list[i].from,
+					my_work->item_list[i].chunk_size);
+}
+
+static ssize_t mt_offloading_set(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	int ccode;
+	int action;
+
+	ccode = kstrtoint(buf, 0, &action);
+	if (ccode) {
+		pr_debug("(%s:) error parsing input %s\n", __func__, buf);
+		return ccode;
+	}
+
+	/*
+	 * action is 0: User wants to disable MT offloading.
+	 * action is 1: User wants to enable MT offloading.
+	 */
+	switch (action) {
+	case 0:
+		mutex_lock(&migratecfg_mutex);
+		if (is_dispatching == 1) {
+			stop_offloading();
+			is_dispatching = 0;
+		} else
+			pr_debug("MT migration offloading is already OFF\n");
+		mutex_unlock(&migratecfg_mutex);
+		break;
+	case 1:
+		mutex_lock(&migratecfg_mutex);
+		if (is_dispatching == 0) {
+			start_offloading(&cpu_migrator);
+			is_dispatching = 1;
+		} else
+			pr_debug("MT migration offloading is already ON\n");
+		mutex_unlock(&migratecfg_mutex);
+		break;
+	default:
+		pr_debug("input should be zero or one, parsed as %d\n", action);
+	}
+	return sizeof(action);
+}
+
+static ssize_t mt_offloading_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", is_dispatching);
+}
+
+static ssize_t mt_threads_set(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	int ccode;
+	unsigned int threads;
+
+	ccode = kstrtouint(buf, 0, &threads);
+	if (ccode) {
+		pr_debug("(%s:) error parsing input %s\n", __func__, buf);
+		return ccode;
+	}
+
+	if (threads > 0 && threads <= MAX_NUM_COPY_THREADS) {
+		mutex_lock(&migratecfg_mutex);
+		limit_mt_num = threads;
+		mutex_unlock(&migratecfg_mutex);
+		pr_debug("MT threads set to %u\n", limit_mt_num);
+	} else {
+		pr_debug("Invalid thread count. Must be between 1 and %d\n",MAX_NUM_COPY_THREADS);
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t mt_threads_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", limit_mt_num);
+}
+
+static bool can_migrate_mt(struct folio *dst, struct folio *src)
+{
+	return true;
+}
+
+int copy_page_lists_mt(struct list_head *dst_folios,
+		struct list_head *src_folios, int nr_items)
+{
+	struct copy_page_info *work_items[MAX_NUM_COPY_THREADS] = {0};
+	unsigned int total_mt_num = limit_mt_num;
+	struct folio *src, *src2, *dst, *dst2;
+	int max_items_per_thread;
+	int item_idx;
+	int err = 0;
+	int cpu;
+	int i;
+
+	if (IS_ENABLED(CONFIG_HIGHMEM))
+		return -ENOTSUPP;
+
+	if (total_mt_num > MAX_NUM_COPY_THREADS)
+		total_mt_num = MAX_NUM_COPY_THREADS;
+
+	/* Each threads get part of each page, if nr_items < totla_mt_num */
+	if (nr_items < total_mt_num)
+		max_items_per_thread = nr_items;
+	else
+		max_items_per_thread = (nr_items / total_mt_num) +
+				((nr_items % total_mt_num) ? 1 : 0);
+
+
+	for (cpu = 0; cpu < total_mt_num; ++cpu) {
+		work_items[cpu] = kzalloc(sizeof(struct copy_page_info) +
+						sizeof(struct copy_item) *
+							max_items_per_thread,
+					  GFP_NOWAIT);
+		if (!work_items[cpu]) {
+			err = -ENOMEM;
+			goto free_work_items;
+		}
+	}
+
+	if (nr_items < total_mt_num) {
+		for (cpu = 0; cpu < total_mt_num; ++cpu) {
+			INIT_WORK((struct work_struct *)work_items[cpu],
+					  copy_page_work_queue_thread);
+			work_items[cpu]->num_items = max_items_per_thread;
+		}
+
+		item_idx = 0;
+		dst = list_first_entry(dst_folios, struct folio, lru);
+		dst2 = list_next_entry(dst, lru);
+		list_for_each_entry_safe(src, src2, src_folios, lru) {
+			unsigned long chunk_size = PAGE_SIZE * folio_nr_pages(src) / total_mt_num;
+			char *vfrom = page_address(&src->page);
+			char *vto = page_address(&dst->page);
+
+			VM_WARN_ON(PAGE_SIZE * folio_nr_pages(src) % total_mt_num);
+			VM_WARN_ON(folio_nr_pages(dst) != folio_nr_pages(src));
+
+			for (cpu = 0; cpu < total_mt_num; ++cpu) {
+				work_items[cpu]->item_list[item_idx].to =
+					vto + chunk_size * cpu;
+				work_items[cpu]->item_list[item_idx].from =
+					vfrom + chunk_size * cpu;
+				work_items[cpu]->item_list[item_idx].chunk_size =
+					chunk_size;
+			}
+
+			item_idx++;
+			dst = dst2;
+			dst2 = list_next_entry(dst, lru);
+		}
+
+		for (cpu = 0; cpu < total_mt_num; ++cpu)
+			queue_work(system_unbound_wq,
+				   (struct work_struct *)work_items[cpu]);
+	} else {
+		int num_xfer_per_thread = nr_items / total_mt_num;
+		int per_cpu_item_idx;
+
+
+		for (cpu = 0; cpu < total_mt_num; ++cpu) {
+			INIT_WORK((struct work_struct *)work_items[cpu],
+					  copy_page_work_queue_thread);
+
+			work_items[cpu]->num_items = num_xfer_per_thread +
+					(cpu < (nr_items % total_mt_num));
+		}
+
+		cpu = 0;
+		per_cpu_item_idx = 0;
+		item_idx = 0;
+		dst = list_first_entry(dst_folios, struct folio, lru);
+		dst2 = list_next_entry(dst, lru);
+		list_for_each_entry_safe(src, src2, src_folios, lru) {
+			work_items[cpu]->item_list[per_cpu_item_idx].to =
+				page_address(&dst->page);
+			work_items[cpu]->item_list[per_cpu_item_idx].from =
+				page_address(&src->page);
+			work_items[cpu]->item_list[per_cpu_item_idx].chunk_size =
+				PAGE_SIZE * folio_nr_pages(src);
+
+			VM_WARN_ON(folio_nr_pages(dst) !=
+				   folio_nr_pages(src));
+
+			per_cpu_item_idx++;
+			item_idx++;
+			dst = dst2;
+			dst2 = list_next_entry(dst, lru);
+
+			if (per_cpu_item_idx == work_items[cpu]->num_items) {
+				queue_work(system_unbound_wq,
+					(struct work_struct *)work_items[cpu]);
+				per_cpu_item_idx = 0;
+				cpu++;
+			}
+		}
+		if (item_idx != nr_items)
+			pr_warn("%s: only %d out of %d pages are transferred\n",
+				__func__, item_idx - 1, nr_items);
+	}
+
+	/* Wait until it finishes  */
+	for (i = 0; i < total_mt_num; ++i) {
+		flush_work((struct work_struct *)work_items[i]);
+		/* retry if any copy fails */
+		if (work_items[i]->ret)
+			err = -EAGAIN;
+	}
+
+free_work_items:
+	for (cpu = 0; cpu < total_mt_num; ++cpu)
+		kfree(work_items[cpu]);
+
+	return err;
+}
+
+static struct kobject *mt_kobj_ref;
+static struct kobj_attribute mt_offloading_attribute = __ATTR(offloading, 0664,
+		mt_offloading_show, mt_offloading_set);
+static struct kobj_attribute mt_threads_attribute = __ATTR(threads, 0664,
+		mt_threads_show, mt_threads_set);
+
+static int __init cpu_mt_module_init(void)
+{
+	int ret = 0;
+
+	mt_kobj_ref = kobject_create_and_add("cpu_mt", kernel_kobj);
+	if (!mt_kobj_ref)
+		return -ENOMEM;
+
+	ret = sysfs_create_file(mt_kobj_ref, &mt_offloading_attribute.attr);
+	if (ret)
+		goto out_offloading;
+
+	ret = sysfs_create_file(mt_kobj_ref, &mt_threads_attribute.attr);
+	if (ret)
+		goto out_threads;
+
+	is_dispatching = 0;
+
+	return 0;
+
+out_threads:
+	sysfs_remove_file(mt_kobj_ref, &mt_offloading_attribute.attr);
+out_offloading:
+	kobject_put(mt_kobj_ref);
+	return ret;
+}
+
+static void __exit cpu_mt_module_exit(void)
+{
+	/* Stop the MT offloading to unload the module */
+	mutex_lock(&migratecfg_mutex);
+	if (is_dispatching == 1) {
+		stop_offloading();
+		is_dispatching = 0;
+	}
+	mutex_unlock(&migratecfg_mutex);
+
+	sysfs_remove_file(mt_kobj_ref, &mt_threads_attribute.attr);
+	sysfs_remove_file(mt_kobj_ref, &mt_offloading_attribute.attr);
+	kobject_put(mt_kobj_ref);
+}
+
+module_init(cpu_mt_module_init);
+module_exit(cpu_mt_module_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Zi Yan");
+MODULE_DESCRIPTION("CPU_MT_COPY"); /* CPU Multithreaded Batch Migrator */
diff --git a/mm/migrate.c b/mm/migrate.c
index 862a3d1eff60..e74dbc7a4758 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1831,18 +1831,13 @@ static void migrate_folios_batch_move(struct list_head *src_folios,
 		int *nr_retry_pages)
 {
 	struct folio *folio, *folio2, *dst, *dst2;
-	int rc, nr_pages = 0, nr_batched_folios = 0;
+	int rc, nr_pages = 0, total_nr_pages = 0, nr_batched_folios = 0;
 	int old_page_state = 0;
 	struct anon_vma *anon_vma = NULL;
 	int is_thp = 0;
 	LIST_HEAD(err_src);
 	LIST_HEAD(err_dst);
 
-	if (mode != MIGRATE_ASYNC) {
-		*retry += 1;
-		return;
-	}
-
 	/*
 	 * Iterate over the list of locked src/dst folios to copy the metadata
 	 */
@@ -1892,8 +1887,10 @@ static void migrate_folios_batch_move(struct list_head *src_folios,
 					old_page_state & PAGE_WAS_MAPPED,
 					anon_vma, true, ret_folios);
 			migrate_folio_undo_dst(dst, true, put_new_folio, private);
-		} else /* MIGRATEPAGE_SUCCESS */
+		} else { /* MIGRATEPAGE_SUCCESS */
+			total_nr_pages += nr_pages;
 			nr_batched_folios++;
+		}
 
 		dst = dst2;
 		dst2 = list_next_entry(dst, lru);
-- 
2.34.1


