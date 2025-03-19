Return-Path: <linux-kernel+bounces-568672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B55A69930
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8192818943FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80932147F6;
	Wed, 19 Mar 2025 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QnipFg4+"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209E5213E78
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412237; cv=fail; b=uxahI3e9NuiVH9Ex0KnSoy+opFhpEdsILFzce1oBFyJMOTvVngIDsqh8d/48ecbpFtIjLdG4JlFbXzdFplqaXBOcjudnvDD19ANESBG/hVZPfLDP4pvLVNUQ/uaytlA1y9Wz7MWQE/XowdoSFj0L+cUcqP4kYkQ6Ncbg7PxFqXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412237; c=relaxed/simple;
	bh=stV6qHmXKpZPHjuRDVq3c4bV+y+ZMkrovx8edPOxAyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gz2Gpk8Q8RiYN0jZjWsmsMVmwJeuN0jns0adR92xzqRCbjS3hDHz6cG10tn5B3t5lXnLIrjJTWMAPv8Ez8Xjm9Z4HeSWkqt1jPEyrxbP0ZO/eXQHFTCJLEWJcxOhyLZTvs671FVJmS6WCFNRrhS/Co/++V5/oVlZMBdywKXVQI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QnipFg4+; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfD8pgNR3dG18aXRfuhxSJKUITEQ1hQwT8uiTUZBZ+WrJm7pX150hn8/2h9Ja0jjdO6jru0oy1ZxcBhNyAY4D7fOnAlnAhw2prqlxJEqZa2kw6BTqL3/BMQxunZBTwM1rly3qtB8osLid5sjTvrbVMWDAO4h/yTsM5xh/ps33g+MVk/rsJevr9UAHY0p8OegqR44oXL1IbRIfFIFBO7PqMP96DO18A0YWESXFaquVM02e97GsYIJrZIgwkhaqzYr2nv7XygvYGAZ29S+lAzh1UZmPHYnlSrddLniMuaQB6rVFEFmKCI3uxdF1eyl5M7CxBmh/ZA8sz+w0TI9Do6waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Uk2NghjfYayPFwNKu3cg0qIrYSvpyALadQw52E+hQQ=;
 b=ZOrqcAdPZ3A5grvaDQDzgx5rlI9dYEPbinShaB++dUcN/eyeiWFP2olhM8qWJhsQze//fVjMGJDQlSIuCc20woi8ELf1hg7Gy/02e04MHJE05Ce3YyXE4UTLbsA37DP/zDJFS75HDkj+jwCGnFBcplOUs50gbWBhZ024BNd0kUcoBmq88EETJzkqLetjj6ZUncYztdzxwh9GRyT4jAILE15U6rMgc6l6+9I/fryh7o95R2JH78XxLtxp5MXr0gY4IlzF/i1GXxtSJl8N9ngOcjYqueXaHK3C9bOGgOw9x2/XTpuYto3dPlOPqemOSBZnlK/EeyjR0/DkTz0gDJC2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Uk2NghjfYayPFwNKu3cg0qIrYSvpyALadQw52E+hQQ=;
 b=QnipFg4+uIIn811W7K3qKeZpmZZc56zTiARSfWh953l8yk/WyUoDUAYd1HEbg8kIWF28bSE9zQvOBCe8uxgLrNaLsQfxr/dPtNqrp3eU+ZbO+ywp55/JxnW/ndd1WzLo+uWRMqrtY1RYclCdA5WUuqhP0t3nSDCzb7Oq/qw2WmM=
Received: from CH0PR03CA0303.namprd03.prod.outlook.com (2603:10b6:610:118::16)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:23:50 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::9) by CH0PR03CA0303.outlook.office365.com
 (2603:10b6:610:118::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Wed,
 19 Mar 2025 19:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:23:50 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:23:42 -0500
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
	<Jonathan.Cameron@huawei.com>, <hyeonggon.yoo@sk.com>, <byungchul@sk.com>,
	Mike Day <michael.day@amd.com>
Subject: [PATCH RFC V2 5/9] mm: add support for copy offload for folio Migration
Date: Wed, 19 Mar 2025 19:22:08 +0000
Message-ID: <20250319192211.10092-6-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: ab83a946-6cf6-4667-1e0b-08dd671b9450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gcPZODinQLlEs6YEZGp33h2jgJIRZ6JR5G/qgtIPPGZtG9ntNW9s52KrynBj?=
 =?us-ascii?Q?1nCYzuO3q9Vv16DKoksgjhgDyUUE5ehyD29XpTKj8HRWOs5wX8kvLeclVO+y?=
 =?us-ascii?Q?jmPo/SJTR6IIO6hiG8D/TPdTS3Ob//vIsmeeGsvUJB6FXI9FS2im8ZoR1TRr?=
 =?us-ascii?Q?0UlNnNHf6R/Gr24HxdDNiHwevTZTsWCOcdfEkQ25/ESTvaE/RUiREHQa9BIy?=
 =?us-ascii?Q?LCecPgoqLpx7l38+tBRTIZMrxBjrcddPIVsTux22R6a5YxgfXYKYzAKPgVRq?=
 =?us-ascii?Q?iGF3eXf2wSy+AX/gc7tQJxr7SAYBrWP50pkAqTtgqYnUfhWx7NmUrEGdDZGy?=
 =?us-ascii?Q?hkc/Q1EZMqTLnxHOlP1j4Dwdv16Y0Q3//MNpXH45ChXRvQfoa4OBy8+WhWaI?=
 =?us-ascii?Q?hj26Imc/wVgLDdw4sfhIhVcQLyIapchYPLh5LbTlUP5Wjk1/7SVagkESUrmn?=
 =?us-ascii?Q?r2Wn+vvxJvXPzdtLBWFASqxcyFqo38QeeacvWMjIvwTRBTNiNAQIi4NMoxGe?=
 =?us-ascii?Q?5QGVS1ICjvCX4C2PriiDHdbK9s5hiIckMQNl1BaoyBdrd3zKtDKVQIvqzwDR?=
 =?us-ascii?Q?ypEmFYVQ2wttc6hnrRxOIXjpnwI8InWPXVAUzrEQ2AbSPZGraUwxMZgVJveu?=
 =?us-ascii?Q?qjuGV809TpcvhsP1WQbbIM8JbYGhuFiO8DkPmXDP+JIIKSrk37fRc0irq/lj?=
 =?us-ascii?Q?9oTdkpoZKStvvKxG5JTFkaBYXuvBfBjFGF9bDd6UdoV/2gglylIMOmFyCBjt?=
 =?us-ascii?Q?mIRtlIBG2AAd2vi1Grw+9SQTcurHvpQJUofAa45BuDKh8Iio+3aM0U7RZweq?=
 =?us-ascii?Q?oYOJqbFgdIShI3LOC21KUMxbsgf/lmYWfwR6Ts/PkVjH5jX0mWxoJbwqidvB?=
 =?us-ascii?Q?R+5F6jVfp6Dn35K6yVjytTrwltFknokTK2ijC55MT7r1gIuis1u3kGVaE2S+?=
 =?us-ascii?Q?/k+FAqsaLkzKNTvbuSXAhZyTxCX7KGVpt9yUriQ//UItx2rDWCj8mJutlcga?=
 =?us-ascii?Q?G5meT1iGkZfV7hDH+DlG+oSfW+KHTZ/YHx6Wp/ABHmOgCyefwXpVSbqZ68LA?=
 =?us-ascii?Q?oLUrsmpE/ZhugAg7MlB0+a7XYmoS1L9pjBl24E/BGHqdrmdxHKFgSMUo0mEm?=
 =?us-ascii?Q?sA+5oNOA5MMMA49LYHs8m9LaaKqADhDmfodgBAkWaQI+UleqgWahTi3GgWu6?=
 =?us-ascii?Q?qq5cm4WaAmU6aEz2CropiwRDdFT3Tn81Mpvj48ByX7gZfgmQYPG1U+U35acq?=
 =?us-ascii?Q?d1t7+pba/SpfSc4MDAGRqZTWU8fJOocwngxyL+F/26guxe/hU6NfOCeEMdU7?=
 =?us-ascii?Q?cxr0OKWaj+kgFQ6fuvNozxFXZUhUEw2ytWg8wwyDYt3dPsJJs94xZcvqvvdp?=
 =?us-ascii?Q?14d/cAccnOJp71Xyh7Q+kOIQ9JtI9KHBIcMpqWXmgijsI4F6XHMznRB9OYo7?=
 =?us-ascii?Q?96K5bib/gJdIn/AYuQV9XFDcwsiT8aNrk0RIOjDgG/FWrUV8ZRw5LLVe2w8Y?=
 =?us-ascii?Q?P9ftAhEFDaHu728=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:23:50.5909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab83a946-6cf6-4667-1e0b-08dd671b9450
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336

From: Mike Day <michael.day@amd.com>

Offload-Copy drivers should implement following functions to enable folio
migration offloading:
migrate_offc() - This function takes src and dst folios list undergoing
migration. It is responsible for transfer of page content between the
src and dst folios.
can_migrate_offc() - It performs necessary checks if offload copying
migration is supported for the give src and dst folios.

Offload-Copy driver should include a mechanism to call start_offloading and
stop_offloading for enabling and disabling migration offload respectively.

[Shivank: Rename the APIs and files to generalize the original DMA-specific
offload implementation to support various copy offloading mechanisms such as
DMA engines, CPU multi-threading, or other
hardware accelerators.]

Signed-off-by: Mike Day <michael.day@amd.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/migrate_offc.h | 36 +++++++++++++++++++++++++
 mm/Kconfig                   |  8 ++++++
 mm/Makefile                  |  1 +
 mm/migrate.c                 | 43 ++++++++++++++++++++++++++++--
 mm/migrate_offc.c            | 51 ++++++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/migrate_offc.h
 create mode 100644 mm/migrate_offc.c

diff --git a/include/linux/migrate_offc.h b/include/linux/migrate_offc.h
new file mode 100644
index 000000000000..908f81ebd621
--- /dev/null
+++ b/include/linux/migrate_offc.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _MIGRATE_OFFC_H
+#define _MIGRATE_OFFC_H
+#include <linux/migrate_mode.h>
+
+#define MIGRATOR_NAME_LEN 32
+struct migrator {
+	char name[MIGRATOR_NAME_LEN];
+	int (*migrate_offc)(struct list_head *dst_list, struct list_head *src_list, int folio_cnt);
+	bool (*can_migrate_offc)(struct folio *dst, struct folio *src);
+	struct rcu_head srcu_head;
+	struct module *owner;
+};
+
+extern struct migrator migrator;
+extern struct mutex migrator_mut;
+extern struct srcu_struct mig_srcu;
+
+#ifdef CONFIG_OFFC_MIGRATION
+void srcu_mig_cb(struct rcu_head *head);
+void offc_update_migrator(struct migrator *mig);
+unsigned char *get_active_migrator_name(void);
+bool can_offc_migrate(struct folio *dst, struct folio *src);
+void start_offloading(struct migrator *migrator);
+void stop_offloading(void);
+#else
+static inline void srcu_mig_cb(struct rcu_head *head) { };
+static inline void offc_update_migrator(struct migrator *mig) { };
+static inline unsigned char *get_active_migrator_name(void) { return NULL; };
+static inline bool can_offc_migrate(struct folio *dst, struct folio *src) {return true; };
+static inline void start_offloading(struct migrator *migrator) { };
+static inline void stop_offloading(void) { };
+#endif /* CONFIG_OFFC_MIGRATION */
+
+#endif /* _MIGRATE_OFFC_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db06417..7a0693c3be4e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -722,6 +722,14 @@ config MIGRATION
 config DEVICE_MIGRATION
 	def_bool MIGRATION && ZONE_DEVICE
 
+config OFFC_MIGRATION
+	bool "Migrate Pages offloading copy"
+	def_bool n
+	depends on MIGRATION
+	help
+	 An interface allowing external modules or driver to offload
+	 page copying in page migration.
+
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	bool
 
diff --git a/mm/Makefile b/mm/Makefile
index 850386a67b3e..010142414176 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_FAIL_PAGE_ALLOC) += fail_page_alloc.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
+obj-$(CONFIG_OFFC_MIGRATION) += migrate_offc.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
diff --git a/mm/migrate.c b/mm/migrate.c
index 8b6cfb60087c..862a3d1eff60 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -44,6 +44,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 #include <linux/pagewalk.h>
+#include <linux/migrate_offc.h>
 
 #include <asm/tlbflush.h>
 
@@ -743,6 +744,37 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 }
 EXPORT_SYMBOL(folio_migrate_flags);
 
+DEFINE_STATIC_CALL(_folios_copy, folios_mc_copy);
+DEFINE_STATIC_CALL(_can_offc_migrate, can_offc_migrate);
+
+#ifdef CONFIG_OFFC_MIGRATION
+void srcu_mig_cb(struct rcu_head *head)
+{
+	static_call_query(_folios_copy);
+}
+
+void offc_update_migrator(struct migrator *mig)
+{
+	int index;
+
+	mutex_lock(&migrator_mut);
+	index = srcu_read_lock(&mig_srcu);
+	strscpy(migrator.name, mig ? mig->name : "kernel", MIGRATOR_NAME_LEN);
+	static_call_update(_folios_copy, mig ? mig->migrate_offc : folios_mc_copy);
+	static_call_update(_can_offc_migrate, mig ? mig->can_migrate_offc : can_offc_migrate);
+	if (READ_ONCE(migrator.owner))
+		module_put(migrator.owner);
+	xchg(&migrator.owner, mig ? mig->owner : NULL);
+	if (READ_ONCE(migrator.owner))
+		try_module_get(migrator.owner);
+	srcu_read_unlock(&mig_srcu, index);
+	mutex_unlock(&migrator_mut);
+	call_srcu(&mig_srcu, &migrator.srcu_head, srcu_mig_cb);
+	srcu_barrier(&mig_srcu);
+}
+
+#endif /* CONFIG_OFFC_MIGRATION */
+
 /************************************************************
  *                    Migration functions
  ***********************************************************/
@@ -1028,11 +1060,15 @@ static int _move_to_new_folio_prep(struct folio *dst, struct folio *src,
 {
 	int rc = -EAGAIN;
 	bool is_lru = !__folio_test_movable(src);
+	bool can_migrate;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(src), src);
 	VM_BUG_ON_FOLIO(!folio_test_locked(dst), dst);
 
-	if (likely(is_lru)) {
+	can_migrate = static_call(_can_offc_migrate)(dst, src);
+	if (unlikely(!can_migrate))
+		rc = -EAGAIN;
+	else if (likely(is_lru)) {
 		struct address_space *mapping = folio_mapping(src);
 
 		if (!mapping)
@@ -1868,7 +1904,10 @@ static void migrate_folios_batch_move(struct list_head *src_folios,
 		goto out;
 
 	/* Batch copy the folios */
-	rc = folios_mc_copy(dst_folios, src_folios, nr_batched_folios);
+	rc = static_call(_folios_copy)(dst_folios, src_folios, nr_batched_folios);
+	/* TODO:  Is there a better way of handling the poison
+	 * recover for batch copy and falling back to serial copy?
+	 */
 
 	/* TODO:  Is there a better way of handling the poison
 	 * recover for batch copy, instead of falling back to serial copy?
diff --git a/mm/migrate_offc.c b/mm/migrate_offc.c
new file mode 100644
index 000000000000..c632928a7c27
--- /dev/null
+++ b/mm/migrate_offc.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/migrate.h>
+#include <linux/migrate_offc.h>
+#include <linux/rculist.h>
+#include <linux/static_call.h>
+
+atomic_t dispatch_to_offc = ATOMIC_INIT(0);
+EXPORT_SYMBOL_GPL(dispatch_to_offc);
+
+DEFINE_MUTEX(migrator_mut);
+DEFINE_SRCU(mig_srcu);
+
+struct migrator migrator = {
+	.name = "kernel",
+	.migrate_offc = folios_mc_copy,
+	.can_migrate_offc = can_offc_migrate,
+	.srcu_head.func = srcu_mig_cb,
+	.owner = NULL,
+};
+
+bool can_offc_migrate(struct folio *dst, struct folio *src)
+{
+	return true;
+}
+EXPORT_SYMBOL_GPL(can_offc_migrate);
+
+void start_offloading(struct migrator *m)
+{
+	int offloading = 0;
+
+	pr_info("starting migration offload by %s\n", m->name);
+	offc_update_migrator(m);
+	atomic_try_cmpxchg(&dispatch_to_offc, &offloading, 1);
+}
+EXPORT_SYMBOL_GPL(start_offloading);
+
+void stop_offloading(void)
+{
+	int offloading = 1;
+
+	pr_info("stopping migration offload by %s\n", migrator.name);
+	offc_update_migrator(NULL);
+	atomic_try_cmpxchg(&dispatch_to_offc, &offloading, 0);
+}
+EXPORT_SYMBOL_GPL(stop_offloading);
+
+unsigned char *get_active_migrator_name(void)
+{
+	return migrator.name;
+}
+EXPORT_SYMBOL_GPL(get_active_migrator_name);
-- 
2.34.1


