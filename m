Return-Path: <linux-kernel+bounces-568694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C4A6996D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841F2884DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900B02147F7;
	Wed, 19 Mar 2025 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FVBN95Of"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BED2144A5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412702; cv=fail; b=V/kkk23NzZfO6W0vcPwQRPjr1kphvRkk6N0fwAeuMq613MaPzOerlELX3hynNmqGskb9smrTm3OnRNJkH2RFCnb2quYWC+tbt75vsFm60BjHo9Pn42wrXictT2BMtb1cQXvjXU3yQnbKZtfBMaBrxpc99b983zOX2xqijfRslgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412702; c=relaxed/simple;
	bh=7HU71naNgONWYZmMotLkEvcczG6LKMtPS0soeTGGnGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AF5uBpHYhFoTp6E+GIozGcnPDyv3ZhVVmrcZemh0YKqhjsaOpyHaEf6u1MOJS+y/1whQtc8NFfLytTvN3FyIHTwloaeXW9p5VfLNan0aRn0XUB5BLI9tYFhpi6csPmH/tiCFcBjr2AIcXaY6dgNqLkvcLRyIyt0Ol5GSDDHFkWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FVBN95Of; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnrfdaYEkoqgwUJbkZKpDtm81CIdd3DCcFJsc4OyQ9hXOfMYMgayiYdvcy74Eb8WBt/KHDe4KC8297sTNWliY4HV1b3jqSaxXcFumY9cMq9yBwhtgz0oM7ncutuNYcDDAAH4q7C9reAPDwPILMUIesFGkIbOLqq/I3tRXvDPhvnr48j80WIui7cTHSql6u/qx7sIvRF8yE2zn9oAxH/3Oqk3AyVkSSNJFgD9usG3EKHmg5qjFwNRy5QkJ+Ztxlv6AT/TbHTpXRPUpKHab4MWoQQ5sg5Ijkcgkaw80IsEcWBVn7TnMSpWh0WGD2BqwtBBr7FK+WoLpWxn6EGznJkWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cx9mqxLbBvGY1Qdr7POiHWnrJdk6S1CQ2w02ch47VKs=;
 b=Pr4585eyMNXyJgLLKLkLf8qhGTZBqRuHBHk911iNN2VjPIWgE6tAu0FD2fBnqfweIWNcD4vhUqxL/xWf6Hu4n/ZI0bl9uxlAx+sA34/2ygC3VLaLb9PLWvsvOeV8xhMa/nQM9yjjYV5RkgcbNg+D/RzJr9wP3wSjMHPxpHZxhuUunuoDd6eyt+h0PYUBm+d8O0d/udOc7y3rWj2jvgyEDjBuC8QvMQfbZqOEc8pK3uDIQcFDFlM7FF8yIl1PCKokr9OaHl+WksRnZ0/pwGAjs1/N3nAvLMrjp5nUnhUU3XGV+8m11Iba3lLbBu48fZddey3py+OUDbqySwn7XdF+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx9mqxLbBvGY1Qdr7POiHWnrJdk6S1CQ2w02ch47VKs=;
 b=FVBN95Of5poV8druQhY+53PKt2RzSYkW9rha8O7wtd7L1HRrkT8tHel/r4zmASi/Gh4ne4OhYkEk5kYRO0+htAZMGfzpuJLS2RzJOI6yeFuvIZuN4uVAMbmNBQy0iAMkTUKkUQF99mLVGnfQsPDeptmOlnnKLsOU98J46Ivqje4=
Received: from SA0PR11CA0165.namprd11.prod.outlook.com (2603:10b6:806:1bb::20)
 by SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:31:33 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::e4) by SA0PR11CA0165.outlook.office365.com
 (2603:10b6:806:1bb::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Wed,
 19 Mar 2025 19:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:31:32 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:31:22 -0500
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
Subject: [RFC PATCH V1 03/13] mm: Scan the mm and create a migration list
Date: Wed, 19 Mar 2025 19:30:18 +0000
Message-ID: <20250319193028.29514-4-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SJ1PR12MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 5feff88a-149c-4187-afa1-08dd671ca78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NTMEQ56E2JF6KYEc9gw2QsQreOr597HyqufvmoNP16bDmzEPj/QIC0li9G9E?=
 =?us-ascii?Q?2yswVh6KBA7wUU3vX016XL2X675QUZDZIeWO/JrTF+ojXQydJd2qSE/w8FQ9?=
 =?us-ascii?Q?OYDIXQKYhwuEC4kaz7cHtoFhE8lN4+fZxGk+5C4JmEtOX1nISqfoYIokylwh?=
 =?us-ascii?Q?vODH+3/aVSk5p8Q/ayzL1rtQ0QakDhhlVclV7Bq72QyoWlrsQilelkyIhoc/?=
 =?us-ascii?Q?inUDSwAWXyQX1hE6p5tD7R0IXjhI04bT9SJcR4I8NTssdtvvMigTRiVC8Xpv?=
 =?us-ascii?Q?FVnS+JnPFzahSx75PeoXgV9BQKRWeOFgFHwsX+EQ2fxro6Xr6q2in8hQdEYG?=
 =?us-ascii?Q?uOsTLnMF78YSJIc8SL6nQp0vpAFQjIysXB0Tc+HiUi0rxjyLCfOcydld6u1G?=
 =?us-ascii?Q?KDzrwC7uwac+cLV1CrIj76Cmu63j3KyxBFA5RfbouYFEj7huS2lTFLGZJYiy?=
 =?us-ascii?Q?9Uibkd/mmZBBIr/6TRchZLKBYk3NYP50o8SOG8n7GPMQF9bsMx3fNxJF9ux7?=
 =?us-ascii?Q?pbM+PVOBmLuOrd+cIeFl6q9bgAsbSh0P89xd275/p+qQ2VlKv1U4nWF2M6lI?=
 =?us-ascii?Q?tjBa0aefc7szodiWGcbO8z45bskN+e62169pYxnWjafkHQ273QDH+/tWj7sQ?=
 =?us-ascii?Q?5ymDyHY8kVqymvQbNkhEc2tb3ael+gPjzzsZzNZmbyUNyWbdP2m9gYnCbgLs?=
 =?us-ascii?Q?itWLkCgBZfqS2x8OmOuCV7V9x8ER/aNo8l9oqQR77BW446LEIABZvr3/LCGE?=
 =?us-ascii?Q?9D49jRIp0XlEJyZZrXACh03ItoDUv5pJRn83C9ECjGNXTaefpKOL4kSUUMQ/?=
 =?us-ascii?Q?dwbfhWc1bSD/qziStqlMSIuk3Ta2J+nhy2GjjouQySnO60B7VFL5Qp2u72og?=
 =?us-ascii?Q?OO8BXCA3lWYKoNgdBW4mr4ZKBK/7yE1dJL4D4aNLeGlq2IyWXVfuf9JbjPW9?=
 =?us-ascii?Q?B/z3luK5O7vlU5mNTxLv/SwOXItj5dvNqKRtlt9t+XkwGEyzyOJiOOZQRJEC?=
 =?us-ascii?Q?w4WraMt47euEU/pXRpQZPcCmvLqEajsrtryan3WMDTPjVub+Zn+25ZN1gsbn?=
 =?us-ascii?Q?ju+/rHU5JQnEjtbsOohW3g6vlqonOMP2fbOdQHtSpxZ69s06vM+3mDELBuJI?=
 =?us-ascii?Q?Yya8k1wW446bcs51fBaivAvV22/++c8PQ7Nphewdk2qhtBz3Sm4eKSAbh2i3?=
 =?us-ascii?Q?kjAUq9WUaEwucSiTiTfZ/a7NPs67VQFOCvIwEpiB6Trcm+7NYSfU3RJFZziQ?=
 =?us-ascii?Q?pC3o7v5WVK8xIsXcOCqNM+g+XAfh2uIbk78bhNEI63QCDgtK+VJ1RCIVbw0r?=
 =?us-ascii?Q?x2XqXx2qocWUVk/69oylzK36Nx3Jk6sSVcTBAHCrcGTm2SvYJpyVzMdgQIWS?=
 =?us-ascii?Q?SegQamIF6qvD6f8ty3T0eJAzEhHsrjWHkYb7xcdqAsyMb6oWfnsvxm+3gDIH?=
 =?us-ascii?Q?nu2FJmi3Gsb5F5ToT32W5XHgJlA9E57YZ6s9DUaXyj4wKGvF+lFWkij7Pp01?=
 =?us-ascii?Q?EBCc4QngPf42MTk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:31:32.3482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5feff88a-149c-4187-afa1-08dd671ca78a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338

Since we already have the list of mm_struct in the system, add a module to
scan each mm that walks VMAs of each mm_struct and scan all the pages
associated with that.

 In the scan path: Check for the recently acccessed pages (folios) belonging to
slowtier nodes. Add all those folios to a migration list.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kmmscand.c | 323 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 321 insertions(+), 2 deletions(-)

diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 36d0fea31dea..a76a58bf37b2 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -4,10 +4,18 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/mmu_notifier.h>
+#include <linux/rmap.h>
+#include <linux/pagewalk.h>
+#include <linux/page_ext.h>
+#include <linux/page_idle.h>
+#include <linux/page_table_check.h>
+#include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/mm_inline.h>
 #include <linux/kthread.h>
 #include <linux/kmmscand.h>
+#include <linux/memory-tiers.h>
+#include <linux/mempolicy.h>
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/cleanup.h>
@@ -18,6 +26,11 @@
 
 static struct task_struct *kmmscand_thread __read_mostly;
 static DEFINE_MUTEX(kmmscand_mutex);
+/*
+ * Total VMA size to cover during scan.
+ */
+#define KMMSCAND_SCAN_SIZE	(1 * 1024 * 1024 * 1024UL)
+static unsigned long kmmscand_scan_size __read_mostly = KMMSCAND_SCAN_SIZE;
 
 /* How long to pause between two scan and migration cycle */
 static unsigned int kmmscand_scan_sleep_ms __read_mostly = 16;
@@ -39,10 +52,14 @@ static DEFINE_READ_MOSTLY_HASHTABLE(kmmscand_slots_hash, KMMSCAND_SLOT_HASH_BITS
 
 static struct kmem_cache *kmmscand_slot_cache __read_mostly;
 
+/* Per mm information collected to control VMA scanning */
 struct kmmscand_mm_slot {
 	struct mm_slot slot;
+	long address;
+	bool is_scanned;
 };
 
+/* Data structure to keep track of current mm under scan */
 struct kmmscand_scan {
 	struct list_head mm_head;
 	struct kmmscand_mm_slot *mm_slot;
@@ -52,6 +69,33 @@ struct kmmscand_scan kmmscand_scan = {
 	.mm_head = LIST_HEAD_INIT(kmmscand_scan.mm_head),
 };
 
+/*
+ * Data structure passed to control scanning and also collect
+ * per memory node information
+ */
+struct kmmscand_scanctrl {
+	struct list_head scan_list;
+	unsigned long address;
+};
+
+struct kmmscand_scanctrl kmmscand_scanctrl;
+
+/* Per folio information used for migration */
+struct kmmscand_migrate_info {
+	struct list_head migrate_node;
+	struct mm_struct *mm;
+	struct folio *folio;
+	unsigned long address;
+};
+
+static bool kmmscand_eligible_srcnid(int nid)
+{
+	if (!node_is_toptier(nid))
+		return true;
+
+	return false;
+}
+
 static int kmmscand_has_work(void)
 {
 	return !list_empty(&kmmscand_scan.mm_head);
@@ -82,15 +126,277 @@ static void kmmscand_wait_work(void)
 	return;
 }
 
+
+static inline bool is_valid_folio(struct folio *folio)
+{
+	if (!folio || folio_test_unevictable(folio) || !folio_mapped(folio) ||
+		folio_is_zone_device(folio) || folio_likely_mapped_shared(folio))
+		return false;
+
+	return true;
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
+	int srcnid;
+
+	scanctrl->address = addr;
+	pte_t pteval = ptep_get(pte);
+
+	if (!pte_present(pteval))
+		return 0;
+
+	if (pte_none(pteval))
+		return 0;
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
+	if (!is_valid_folio(folio)) {
+		folio_put(folio);
+		return 0;
+	}
+	srcnid = folio_nid(folio);
+
+
+	if (!folio_test_lru(folio)) {
+		folio_put(folio);
+		return 0;
+	}
+
+	if (!folio_test_idle(folio) || folio_test_young(folio) ||
+			mmu_notifier_test_young(mm, addr) ||
+			folio_test_referenced(folio) || pte_young(pteval)) {
+
+		/* Do not try to promote pages from regular nodes */
+		if (!kmmscand_eligible_srcnid(srcnid)) {
+			folio_put(folio);
+			return 0;
+		}
+		/* XXX: Leaking memory. TBD: consume info */
+		info = kzalloc(sizeof(struct kmmscand_migrate_info), GFP_NOWAIT);
+		if (info && scanctrl) {
+
+			info->mm = mm;
+			info->address = addr;
+			info->folio = folio;
+
+			/* No need of lock now */
+			list_add_tail(&info->migrate_node, &scanctrl->scan_list);
+		}
+	}
+
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
 static inline int kmmscand_test_exit(struct mm_struct *mm)
 {
 	return atomic_read(&mm->mm_users) == 0;
 }
 
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
+		mm_slot_free(kmmscand_slot_cache, mm_slot);
+		mmdrop(mm);
+	}
+}
+
 static unsigned long kmmscand_scan_mm_slot(void)
 {
-	/* placeholder for scanning */
-	msleep(100);
+	bool next_mm = false;
+	bool update_mmslot_info = false;
+
+	unsigned long vma_scanned_size = 0;
+	unsigned long address;
+
+	struct mm_slot *slot;
+	struct mm_struct *mm;
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
+	VMA_ITERATOR(vmi, mm, address);
+
+	for_each_vma(vmi, vma) {
+		kmmscand_walk_page_vma(vma, &kmmscand_scanctrl);
+		vma_scanned_size += vma->vm_end - vma->vm_start;
+
+		if (vma_scanned_size >= kmmscand_scan_size) {
+			next_mm = true;
+			/* TBD: Add scanned folios to migration list */
+			break;
+		}
+	}
+
+	if (!vma)
+		address = 0;
+	else
+		address = kmmscand_scanctrl.address + PAGE_SIZE;
+
+	update_mmslot_info = true;
+
+	if (update_mmslot_info)
+		mm_slot->address = address;
+
+outerloop:
+	/* exit_mmap will destroy ptes after this */
+	mmap_read_unlock(mm);
+
+outerloop_mmap_lock:
+	spin_lock(&kmmscand_mm_lock);
+	WARN_ON(kmmscand_scan.mm_slot != mm_slot);
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
+		if (slot->mm_node.next != &kmmscand_scan.mm_head) {
+			slot = list_entry(slot->mm_node.next,
+					struct mm_slot, mm_node);
+			kmmscand_scan.mm_slot =
+				mm_slot_entry(slot, struct kmmscand_mm_slot, slot);
+
+		} else
+			kmmscand_scan.mm_slot = NULL;
+
+		if (kmmscand_test_exit(mm)) {
+			kmmscand_collect_mm_slot(mm_slot);
+			goto end;
+		}
+	}
+	mm_slot->is_scanned = false;
+end:
+	spin_unlock(&kmmscand_mm_lock);
 	return 0;
 }
 
@@ -153,6 +459,7 @@ void __kmmscand_enter(struct mm_struct *mm)
 	if (!kmmscand_slot)
 		return;
 
+	kmmscand_slot->address = 0;
 	slot = &kmmscand_slot->slot;
 
 	spin_lock(&kmmscand_mm_lock);
@@ -180,6 +487,12 @@ void __kmmscand_exit(struct mm_struct *mm)
 		hash_del(&slot->hash);
 		list_del(&slot->mm_node);
 		free = 1;
+	} else if (mm_slot && kmmscand_scan.mm_slot == mm_slot && !mm_slot->is_scanned) {
+		hash_del(&slot->hash);
+		list_del(&slot->mm_node);
+		free = 1;
+		/* TBD: Set the actual next slot */
+		kmmscand_scan.mm_slot = NULL;
 	}
 
 	spin_unlock(&kmmscand_mm_lock);
@@ -233,6 +546,11 @@ static int stop_kmmscand(void)
 
 	return err;
 }
+static void init_list(void)
+{
+	INIT_LIST_HEAD(&kmmscand_scanctrl.scan_list);
+	init_waitqueue_head(&kmmscand_wait);
+}
 
 static int __init kmmscand_init(void)
 {
@@ -245,6 +563,7 @@ static int __init kmmscand_init(void)
 		return -ENOMEM;
 	}
 
+	init_list();
 	err = start_kmmscand();
 	if (err)
 		goto err_kmmscand;
-- 
2.34.1


