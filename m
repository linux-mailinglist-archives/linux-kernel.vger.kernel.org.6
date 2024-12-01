Return-Path: <linux-kernel+bounces-426652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED999DF64B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 489C6B22072
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2201D6DBB;
	Sun,  1 Dec 2024 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cIAjPUyI"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB111D61B1
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733067590; cv=fail; b=YKXpVy6+RMGXYZbPcFqdUJINEqDRu3oXAn1kaFCxkKK8DOuuKrQAeWWZVdT8ykhnuVwHNQkCAgr/Z8+pDSKV+d1Lhx1PA1BomWIeY1w93h36f0ozr5yraOAD9fo4/Y+EGdhbBsCiLx/kvMN0LCUH2drwcJeg85RNAV05g+J+AX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733067590; c=relaxed/simple;
	bh=ljafux1/tL4+SrxEjKXNmAkiYg4YAj9JGGR3c0WI3/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9YLpwBOgGBFcqeUrkywpEz5mDDQLFFtxcvFfSB6UjvKn0iVDmgl4TSQl1WipzSCpJCx6wTXWPk2BoXIANGM7Eka5eB8hXIDlfM/Rf5RuJjAkkrbZuGTb9a33Ag9SO6t5ebDo3NUM/YrWgd96iJQHSTwXThkuWB3Oo3gpCgQlxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cIAjPUyI; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ek6Erq1UWSgPeUAm1lqUFRpfM/UYyqIxOSyJtei0J35LB3c6mY3lq+Ke9mW7q+YafRkABqfaXZ6VdeQTCmFobrYhvH0HBeh3CSeYifnfO3kbZ3PJEsYDl3qHBiVZ3zhWfb3/wSpFK0exTOzgASt+O3yZvBCouBB1AZpka7fnsd6xORV1qhvWupqw+bc2gmyz+UJP9pSJdu8JmmY2QtxQSSRs+9H7q9Q3zDovuzg5PEpbSQ4HbzoHu0mxL0JiwlHzDuqz0qhhYRmjJTzPI/iuSgrmiMOyxDD2ubPqrXkRLtgSf0E6FAcYpN7JQFk32ICbdGw0HxNVFPBDL0Qzt3j3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Tyigini5Kwm8cIJJd8zOop087IwBFUJq4O47InjsQw=;
 b=PtgHY4V6c6pophiI3RAiKogWfPyzu2BzVElN1874p1HeQnRgfgXu7tQ70mZJjMb8clcJ11RnxMe2tEChtWvtSTVVRn7pEp4KjWonKC/pj8sQeYXmsIqQ1UO7XtP6Ax5TvXjiXFLc4KIOJI61yM4WJ+GbxWJB1upq1a0wBXExagxj0LfyQDnTlDJlxAFKuJ8JzPumuHD+DcU3JlpB3f6ExeihPSZTdvbWIxIlDoWEhupF8b6lsf6yrfzIeeYm/NOtv2xDkCVmjbEl7MlfO2IicGxfXfnZzognJCUSQ2Rgsmma8MoyVOntVrm0JCuKh1ZnWwdDtIj3qRVQLd4wLpPVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Tyigini5Kwm8cIJJd8zOop087IwBFUJq4O47InjsQw=;
 b=cIAjPUyIzJtlsCd0hyNdSC3621OoZyPmNyZhJt0uS0CFjOoWThjcXe7oNnqUgWJtXNbAxwnAIAQ/Qeha9nnNu8fPXOOfHEuqC1E7oXqwyrSHwxoWiv6BVYv4VfdGm4KrGNYZdtJkQ36E6N+1rwKaFK9RCUJOH3NQvvcIs37JcAQ=
Received: from CH5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:1f1::13)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sun, 1 Dec
 2024 15:39:42 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::ef) by CH5PR03CA0015.outlook.office365.com
 (2603:10b6:610:1f1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Sun,
 1 Dec 2024 15:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 1 Dec 2024 15:39:42 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 09:39:35 -0600
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
Subject: [RFC PATCH V0 08/10] vmstat: Add vmstat counters
Date: Sun, 1 Dec 2024 15:38:16 +0000
Message-ID: <20241201153818.2633616-9-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 187baa7d-6a5e-4c9e-8595-08dd121e5fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YqPcNQHjjTD5nXdzmTzRylvMCFUecnE40VUaQ5KzGDJF/edjGxwtWuJ3Y+M/?=
 =?us-ascii?Q?2q/H4W8em0GunbXy+d0wPLwxFIwCffuR8M7cROjVmi2OQrf4yMDOZY8ypyNp?=
 =?us-ascii?Q?+KrP/TSKrywzjFzAt9gKRmV0Pp3cCNXCWvTLuhVLmfNadjS7E5ZwiabQlrez?=
 =?us-ascii?Q?IkIYbMnf14014Xnlo5pKxs3PSIXrU/tADaHfrBD3PW6Qr7e1nv5gNXknWISD?=
 =?us-ascii?Q?/KDJrxm8hklfe+xizpPPCRkmxar5cIZWEKk6+8fZaBtxLzFb8lTYfCtDM+0N?=
 =?us-ascii?Q?HVYINh3TL7G/YrNyca4q1RKfu43HhtEdhb90zBEHQR8K3Es4ZQ7mPCHDbxOH?=
 =?us-ascii?Q?ndUpoYE0kkhByVbkzpWAOSItAjTPjodPNqUlfLsovabsnVZIZeFx70tMIhG6?=
 =?us-ascii?Q?4JJcC8yxdgkgLuvi1yIHkvBQR+7J/e/3NEthCmPH1Gj3B2MFJ1swN3TZPIfr?=
 =?us-ascii?Q?W4fQGqm3csefIlNmSDAelEB6wJpNKHhOPjwkBDAbnT4CZivJV0N9xVH6MkIG?=
 =?us-ascii?Q?RldCvzWpIIn+wqfWjxFNMU+c+ZuAsMQj2Qkc5+2IlzeToahPA7T5wJ/arWTd?=
 =?us-ascii?Q?senw8xr6O0rKEtRHRWagrvdBa+zYr8+k4GTUzWj1GiJ0MzcIhgH/Jo7jYcQ3?=
 =?us-ascii?Q?/Zj1CPH2IcoGMhLhhqKFx6mCR0Ao8dz+hOgDcim9Cilq/YgmNYunSzgjmIno?=
 =?us-ascii?Q?lIs5l/UELYUUab90/q/++NlujObydY+oFjfnFMce3gbiAIjdqJYsLS12WfY4?=
 =?us-ascii?Q?JEFdyvHuve62VuCbWlyMmKACj2Y29QRIah4Ql3iLeYMNXcJ3YYK0uVKXBeDB?=
 =?us-ascii?Q?VlITfAMykSyQ+kAS9CPzQOnaDmU9gS+5kuI0aivkqjdx0yZq/iz26q6v4jeo?=
 =?us-ascii?Q?jvDDAziEtqbMCWcYJhQmwavSOFmWGA2utwWS4Wh9RhYv3k8juQvHtMU9Tbpv?=
 =?us-ascii?Q?tQK0MYsmTpuEGhwcsGs7ZKr9ifzoa58WCN8VD+WLuJy1WdeuKRdrQHFK0Dfo?=
 =?us-ascii?Q?pEcmecth5tkN3cIrLwjd509w09WT3Pw5cfQIKPYavNymX6YEPYm94kaQqurf?=
 =?us-ascii?Q?bvFl3njcvJvfs5ON5UerTnehzQw61UwGfk5L61NWztqz4TAygXNmWPfasT2E?=
 =?us-ascii?Q?hpZeJ01VjkussaaTk+iZqRCLYLQDVlFjFmZqAkNeVT54pXJGK8qd9vgbTxbA?=
 =?us-ascii?Q?1UvB54ftJGKYtu1LATHtc2IIcW5Sm3hB4K9iUfDa1DNLWa+qsraG+TmUxXyN?=
 =?us-ascii?Q?9XAr0vo5aF/FuQI71EigKUIoH4asuQ1GBfX+USzYRrFlsTqEq52J0Nuy5hMg?=
 =?us-ascii?Q?S6nUkE4+rzXIrHn07X4mJwLZJZg174SsomKUrRQPdobpkshy244FJhvl14Ea?=
 =?us-ascii?Q?hU+rJWHtbNkKH49jv6UryVicezLXfAsJ8WOKMJeeJJLsDAWlFKSAq4iKklOQ?=
 =?us-ascii?Q?mAwkwHZTk/wOJxIh7qM4k8vMzrbs1O4VWOLm3076ZhDUgcfqG4ACEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 15:39:42.1229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 187baa7d-6a5e-4c9e-8595-08dd121e5fce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133

Add vmstat counter to track scanning, migration and
type of pages. 

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm.h            | 11 ++++++++
 include/linux/vm_event_item.h | 10 +++++++
 mm/kmmscand.c                 | 50 ++++++++++++++++++++++++++++++++++-
 mm/vmstat.c                   | 10 +++++++
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c39c4945946c..306452c11d31 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -681,6 +681,17 @@ struct vm_operations_struct {
 					  unsigned long addr);
 };
 
+#ifdef CONFIG_KMMSCAND
+void count_kmmscand_mm_scans(void);
+void count_kmmscand_vma_scans(void);
+void count_kmmscand_migadded(void);
+void count_kmmscand_migrated(void);
+void count_kmmscand_migrate_failed(void);
+void count_kmmscand_slowtier(void);
+void count_kmmscand_toptier(void);
+void count_kmmscand_idlepage(void);
+#endif
+
 #ifdef CONFIG_NUMA_BALANCING
 static inline void vma_numab_state_init(struct vm_area_struct *vma)
 {
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f70d0958095c..b2ccd4f665aa 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -65,6 +65,16 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NUMA_HINT_FAULTS_LOCAL,
 		NUMA_PAGE_MIGRATE,
 #endif
+#ifdef CONFIG_KMMSCAND
+		KMMSCAND_MM_SCANS,
+		KMMSCAND_VMA_SCANS,
+		KMMSCAND_MIGADDED,
+		KMMSCAND_MIGRATED,
+		KMMSCAND_MIGRATE_FAILED,
+		KMMSCAND_SLOWTIER,
+		KMMSCAND_TOPTIER,
+		KMMSCAND_IDLEPAGE,
+#endif
 #ifdef CONFIG_MIGRATION
 		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
 		THP_MIGRATION_SUCCESS,
diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 344a45bd2d3e..682c0523c0b4 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -279,6 +279,39 @@ struct attribute_group kmmscand_attr_group = {
 };
 #endif
 
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
 static int kmmscand_has_work(void)
 {
 	return !list_empty(&kmmscand_scan.mm_head);
@@ -500,6 +533,9 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 
 	srcnid = folio_nid(folio);
 
+	if (node_is_toptier(srcnid))
+		count_kmmscand_toptier();
+
 	if (!folio_test_idle(folio) || folio_test_young(folio) ||
 			mmu_notifier_test_young(mm, addr) ||
 			folio_test_referenced(folio) || pte_young(pteval)) {
@@ -511,6 +547,7 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 		info = kzalloc(sizeof(struct kmmscand_migrate_info), GFP_KERNEL);
 		if (info && migrate_list) {
 
+			count_kmmscand_slowtier();
 			info->mm = mm;
 			info->vma = vma;
 			info->folio = folio;
@@ -524,8 +561,10 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 			 * XXX: We are increamenting atomic var under mmap_readlock
 			 */
 			atomic_long_inc(&mm->nr_accessed);
+			count_kmmscand_migadded();
 		}
-	}
+	} else
+		count_kmmscand_idlepage();
 end:
 	folio_set_idle(folio);
 	folio_put(folio);
@@ -632,6 +671,12 @@ static void kmmscand_migrate_folio(void)
 			if (info->mm)
 				ret = kmmscand_promote_folio(info);
 
+			/* TBD: encode migrated count here, currently assume folio_nr_pages */
+			if (!ret)
+				count_kmmscand_migrated();
+			else
+				count_kmmscand_migrate_failed();
+
 			kfree(info);
 
 			spin_lock(&kmmscand_migrate_lock);
@@ -799,6 +844,7 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	for_each_vma(vmi, vma) {
 		/* Count the scanned pages here to decide exit */
 		kmmscand_walk_page_vma(vma);
+		count_kmmscand_vma_scans();
 		scanned_size += vma->vm_end - vma->vm_start;
 		address = vma->vm_end;
 
@@ -822,6 +868,8 @@ static unsigned long kmmscand_scan_mm_slot(void)
 
 	update_mmslot_info = true;
 
+	count_kmmscand_mm_scans();
+
 outerloop:
 	/* exit_mmap will destroy ptes after this */
 	mmap_read_unlock(mm);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4d016314a56c..d758e7155042 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1340,6 +1340,16 @@ const char * const vmstat_text[] = {
 	"numa_hint_faults_local",
 	"numa_pages_migrated",
 #endif
+#ifdef CONFIG_KMMSCAND
+	"nr_kmmscand_mm_scans",
+	"nr_kmmscand_vma_scans",
+	"nr_kmmscand_migadded",
+	"nr_kmmscand_migrated",
+	"nr_kmmscand_migrate_failed",
+	"nr_kmmscand_slowtier",
+	"nr_kmmscand_toptier",
+	"nr_kmmscand_idlepage",
+#endif
 #ifdef CONFIG_MIGRATION
 	"pgmigrate_success",
 	"pgmigrate_fail",
-- 
2.39.3


