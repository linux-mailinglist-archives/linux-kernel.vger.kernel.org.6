Return-Path: <linux-kernel+bounces-568697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E72AA69975
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EFD1888E11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707D214A82;
	Wed, 19 Mar 2025 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4wesvsZf"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83578219319
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412709; cv=fail; b=FCHTKp7Hh5OB/M3sxpJeTpdCcUVKsj7ELnslxtPRb19O9tlth5/FwdwAHuUKCTSuOHO0WxZTES+6q3oQqjlbS7BUroPhQJiuP5QWBfJlEcqWh8XDRFlQXnmay2AOng0ZtQm17t0d0UO3U9Gflgf6mfScMxRwxm7I8IfrdC/8lt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412709; c=relaxed/simple;
	bh=CwACzvsXFGQ+4o9JzFM3SXvkdZnCjvPpRstRwwmveA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzGb61GXa6u/DVpWwvcdii6y6omAd0k90qLG1EOGpo91f86VS6lG35Kac8AhXkj/uOuTZmXrLuNGqDJp+E5Zvw8DQzqsPXHnymBfs0hFJABxVYYrh7LDNw3SenfXf8VYl8Kk3O9H7OwcVeDzyhKtKcDNYdYv6lhZ6T1z8bAkr7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4wesvsZf; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNV/yleleGLbHG0RUop+A6UkniDrrRy4IYpeAMMS1V26DgPmancCSx1fIGiFlpLCwq0wDW4/nZ589zth+1/6zLdCGVAaiNvNVgD2Ct/bjiJBDxOITTtbluRfQguIYq+Vn6i8mEjjXnsLiJL9hopeY9/t3a+69XPmJE2CNOIGUdRk0tRD6yzDt3SXpXd3wp+/3gEq37aq7yjSCXieVoDCq9ojR1scYxpKC64OM2ZRgo3UmuKn/k3AI/g4ty/56taYMmmLfWQPmrLWkZRqQB/EvMu588XKAUfVW0IaJl79y5Mxfk0IuRcC9Q/ggLIe6XQhOAb2UQFP9nFhPFU7ewtzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtVePGSIcc5EsBIhdgHjgHCwmTFiPZreK0dOtW/EQes=;
 b=HMvq2dy2xMZCHrc+bBpn6UEUdOENKD2M6KFTMLrNOErKVW2Fwg8RksAWVO5xwCVKApbmUHX26RcDsU7aMoFgNTsVSjw6LcdmfB9DB3TE8YpyKfJisWttbENZGH+TBe5sN98z9cov79OCzunvlp5hqnuCTJoCk8EibQm+KebhmLvpuxU9Lh4RSMvk+IGIEQJPjDir7VtePflvctiAKcKLWI1WxiAnElV454tjrDhwRbkOex5jvlq6gR1Qt9WXMsHPZMI5iefcqDcHMo/Y0lY0BSDHNpk/i7/VeiSsB7fsVhX4bSFEGPalwgx/NZspa9mZXY12GQc/puyfHT6wz5nVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtVePGSIcc5EsBIhdgHjgHCwmTFiPZreK0dOtW/EQes=;
 b=4wesvsZfUuHPArobaYmr9axYEevL+wv5xx5S0HYFwRo7xevuL69iBJsp4IzaXSk4tmvBSBwlhyGzIfqWxwtTD37Kyuy2fSvQMap3CJWl/6cJAu11V3j/EnAhnm1q4dnxmgWep6iUEiSb2j8cLT2XlVTqsPoLuPEgbA4ol7bwZls=
Received: from SA9PR10CA0006.namprd10.prod.outlook.com (2603:10b6:806:a7::11)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 19:31:43 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::25) by SA9PR10CA0006.outlook.office365.com
 (2603:10b6:806:a7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:31:42 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:31:32 -0500
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
Subject: [RFC PATCH V1 04/13] mm: Create a separate kernel thread for migration
Date: Wed, 19 Mar 2025 19:30:19 +0000
Message-ID: <20250319193028.29514-5-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 03dff38e-7350-4ae2-5724-08dd671caddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sF/pEHEPvPGRjshqRhWXUqdKI7+oW+GK9tWDSUXoqK4GeHHdDo3fs41nG5pG?=
 =?us-ascii?Q?ha3aua8nSmYi6OPLyk9yV965JdaVIpfe7wImESSkxK/eZFr9HQ89FJP3cNtd?=
 =?us-ascii?Q?XktD0GpVFcX4qcLfwgDTI6LR/UK6PE1SOJxf2qAU1DgsBnHrnK/r4Gt2u/B+?=
 =?us-ascii?Q?uM0NqPF9l9BUadoqM0IGSQACUjX9OP7MbtgW5+zlMFOXp5jviFl0KY7i7Mzx?=
 =?us-ascii?Q?mDmVh+LSr29nEaDOMsMb900FDIBYO4RQMcqyrYVJl/AQnZcasqxjsrDf0oQu?=
 =?us-ascii?Q?e1xO3B8xwGt+GHq5vowy8fSlYPtYi3o44N5HjZptHTkqu9sDwzTwtJfpXyck?=
 =?us-ascii?Q?i2rXJC17KRmJkf16HLABgtb/Jw6MghAcdIjfuGHK29HPOVVzaXWXtI1/8OAN?=
 =?us-ascii?Q?uTv/BY5Ra6xEYZ7HEtvgik0qfSvwPlalush4CkkLfVPVkZQSO38ElxEcOzuW?=
 =?us-ascii?Q?Smb2sBLsTRHu+39WZj89gs+J9mwnMWUUg0uWUNEDIXq//3zF1x67pojvQUY0?=
 =?us-ascii?Q?xmcU2AHZs3t3f4ZAzvPyVNsG+66PUJ2Jn4JGa5QhScbdhUG3e07LtWMj29Nb?=
 =?us-ascii?Q?pH5IWTMX7M8qVvAHb/BtzUE+0DA4w8DhmUGiyQ8qFMcxYzZKBDTjE+BfSMxk?=
 =?us-ascii?Q?qXZDRkVaEZg294uANsfECkfZzEEu/Ndbq1lh9rXprjSvBQPnFZfOrfR3fvj3?=
 =?us-ascii?Q?vdLQP7650+xPUGyojGpxJ5LkiPDagCvjkp8L+l3ywbnvs/NOixLPgFQN0I/l?=
 =?us-ascii?Q?E/OcLzvKvfjihv/3F/N1ewMZq3Bx2MSjZR8vHxuvd1esqVlC6bnI9bpuuQci?=
 =?us-ascii?Q?4PmRzm2AFTEbZ/JuyyXQKcnYWU2uyWtgbSTcD9mtQkbALM4pOot/mQ6W/fYp?=
 =?us-ascii?Q?9f89ARQnfGgwy4J87vHyPFdJH5Dqs3ZY9TDdGmcEj6KXeGad16RxDE10artQ?=
 =?us-ascii?Q?eNZ5e565XFTgTU1WvEgKWsdquSIIq56PsUbKDsR/jVN0GrVkrx0nEP8ao4c6?=
 =?us-ascii?Q?j9+W5rgAmBIkIB2Rp3PaXFqmdhWrwNtgGc/Cmv9Mn4i5ySGsWj2tA+vrBRO/?=
 =?us-ascii?Q?Tk+xU/BTpc/CCmzzhpBYIvsgzVTsrtlF2lCFP5eMnKVAUHTRifePZQv007rB?=
 =?us-ascii?Q?YMugAu9cBbM8JoXbxvT2d1z9eOtlgJPVsxlQDcbZs7fufZt8nwoupQ9/cQ+O?=
 =?us-ascii?Q?61VyEaGRnRJ7eU9MfwbfXPn9Q2kUYF+pPjrXMq7OYzNMl6H7LO2uflNkTNOB?=
 =?us-ascii?Q?GpLh7o9wp9jv65GYqWOJePcAPCEShZA6hI2cyil3N/WiE5fFhFl6xatsKBhv?=
 =?us-ascii?Q?y1EuEsXKVNk0simDenz8ttaNS9MGDJ1gjM/J0lwu74vsHivRLTDpOq2F1lkV?=
 =?us-ascii?Q?czJflnwf9o8Tm2VG7ePNOsIYdpKJq2SyLPo1P16ou0Jw01cdZW+UztqLdAUA?=
 =?us-ascii?Q?UxnwuWmIuZ0ztW0d2Oaq/lXx5RZSD1HcvrWr+1TGsyiUSXu7M3QQYUrI8q76?=
 =?us-ascii?Q?xDDWdnW289XYLVU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:31:42.9406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dff38e-7350-4ae2-5724-08dd671caddd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091

Having independent thread helps in:
 - Alleviating the need for multiple scanning threads
 - Aids to control batch migration (TBD)
 - Migration throttling (TBD)

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kmmscand.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 3 deletions(-)

diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index a76a58bf37b2..6e96cfab5b85 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -4,6 +4,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/mmu_notifier.h>
+#include <linux/migrate.h>
 #include <linux/rmap.h>
 #include <linux/pagewalk.h>
 #include <linux/page_ext.h>
@@ -41,10 +42,26 @@ static unsigned long kmmscand_mms_to_scan __read_mostly = KMMSCAND_MMS_TO_SCAN;
 
 bool kmmscand_scan_enabled = true;
 static bool need_wakeup;
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
 
 static unsigned long kmmscand_sleep_expire;
 
 static DEFINE_SPINLOCK(kmmscand_mm_lock);
+static DEFINE_SPINLOCK(kmmscand_migrate_lock);
 static DECLARE_WAIT_QUEUE_HEAD(kmmscand_wait);
 
 #define KMMSCAND_SLOT_HASH_BITS 10
@@ -80,6 +97,14 @@ struct kmmscand_scanctrl {
 
 struct kmmscand_scanctrl kmmscand_scanctrl;
 
+struct kmmscand_migrate_list {
+	struct list_head migrate_head;
+};
+
+struct kmmscand_migrate_list kmmscand_migrate_list = {
+	.migrate_head = LIST_HEAD_INIT(kmmscand_migrate_list.migrate_head),
+};
+
 /* Per folio information used for migration */
 struct kmmscand_migrate_info {
 	struct list_head migrate_node;
@@ -101,6 +126,13 @@ static int kmmscand_has_work(void)
 	return !list_empty(&kmmscand_scan.mm_head);
 }
 
+static int kmmmigrated_has_work(void)
+{
+	if (!list_empty(&kmmscand_migrate_list.migrate_head))
+		return true;
+	return false;
+}
+
 static bool kmmscand_should_wakeup(void)
 {
 	bool wakeup =  kthread_should_stop() || need_wakeup ||
@@ -111,6 +143,16 @@ static bool kmmscand_should_wakeup(void)
 	return wakeup;
 }
 
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
 static void kmmscand_wait_work(void)
 {
 	const unsigned long scan_sleep_jiffies =
@@ -126,6 +168,19 @@ static void kmmscand_wait_work(void)
 	return;
 }
 
+static void kmmmigrated_wait_work(void)
+{
+	const unsigned long migrate_sleep_jiffies =
+		msecs_to_jiffies(kmmmigrate_sleep_ms);
+
+	if (!migrate_sleep_jiffies)
+		return;
+
+	kmmmigrated_sleep_expire = jiffies + migrate_sleep_jiffies;
+	wait_event_timeout(kmmmigrated_wait,
+			kmmmigrated_should_wakeup(),
+			migrate_sleep_jiffies);
+}
 
 static inline bool is_valid_folio(struct folio *folio)
 {
@@ -238,7 +293,6 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 			folio_put(folio);
 			return 0;
 		}
-		/* XXX: Leaking memory. TBD: consume info */
 		info = kzalloc(sizeof(struct kmmscand_migrate_info), GFP_NOWAIT);
 		if (info && scanctrl) {
 
@@ -282,6 +336,28 @@ static inline int kmmscand_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
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
 static void kmmscand_collect_mm_slot(struct kmmscand_mm_slot *mm_slot)
 {
 	struct mm_slot *slot = &mm_slot->slot;
@@ -294,11 +370,17 @@ static void kmmscand_collect_mm_slot(struct kmmscand_mm_slot *mm_slot)
 		hash_del(&slot->hash);
 		list_del(&slot->mm_node);
 
+		kmmscand_cleanup_migration_list(mm);
+
 		mm_slot_free(kmmscand_slot_cache, mm_slot);
 		mmdrop(mm);
 	}
 }
 
+static void kmmscand_migrate_folio(void)
+{
+}
+
 static unsigned long kmmscand_scan_mm_slot(void)
 {
 	bool next_mm = false;
@@ -347,9 +429,17 @@ static unsigned long kmmscand_scan_mm_slot(void)
 
 		if (vma_scanned_size >= kmmscand_scan_size) {
 			next_mm = true;
-			/* TBD: Add scanned folios to migration list */
+			/* Add scanned folios to migration list */
+			spin_lock(&kmmscand_migrate_lock);
+			list_splice_tail_init(&kmmscand_scanctrl.scan_list,
+						&kmmscand_migrate_list.migrate_head);
+			spin_unlock(&kmmscand_migrate_lock);
 			break;
 		}
+		spin_lock(&kmmscand_migrate_lock);
+		list_splice_tail_init(&kmmscand_scanctrl.scan_list,
+					&kmmscand_migrate_list.migrate_head);
+		spin_unlock(&kmmscand_migrate_lock);
 	}
 
 	if (!vma)
@@ -478,7 +568,7 @@ void __kmmscand_exit(struct mm_struct *mm)
 {
 	struct kmmscand_mm_slot *mm_slot;
 	struct mm_slot *slot;
-	int free = 0;
+	int free = 0, serialize = 1;
 
 	spin_lock(&kmmscand_mm_lock);
 	slot = mm_slot_lookup(kmmscand_slots_hash, mm);
@@ -493,10 +583,15 @@ void __kmmscand_exit(struct mm_struct *mm)
 		free = 1;
 		/* TBD: Set the actual next slot */
 		kmmscand_scan.mm_slot = NULL;
+	} else if (mm_slot && kmmscand_scan.mm_slot == mm_slot && mm_slot->is_scanned) {
+		serialize = 0;
 	}
 
 	spin_unlock(&kmmscand_mm_lock);
 
+	if (serialize)
+		kmmscand_cleanup_migration_list(mm);
+
 	if (free) {
 		mm_slot_free(kmmscand_slot_cache, mm_slot);
 		mmdrop(mm);
@@ -546,10 +641,59 @@ static int stop_kmmscand(void)
 
 	return err;
 }
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
 static void init_list(void)
 {
+	INIT_LIST_HEAD(&kmmscand_migrate_list.migrate_head);
 	INIT_LIST_HEAD(&kmmscand_scanctrl.scan_list);
+	spin_lock_init(&kmmscand_migrate_lock);
 	init_waitqueue_head(&kmmscand_wait);
+	init_waitqueue_head(&kmmmigrated_wait);
 }
 
 static int __init kmmscand_init(void)
@@ -568,8 +712,15 @@ static int __init kmmscand_init(void)
 	if (err)
 		goto err_kmmscand;
 
+	err = start_kmmmigrated();
+	if (err)
+		goto err_kmmmigrated;
+
 	return 0;
 
+err_kmmmigrated:
+	stop_kmmmigrated();
+
 err_kmmscand:
 	stop_kmmscand();
 	kmmscand_destroy();
-- 
2.34.1


