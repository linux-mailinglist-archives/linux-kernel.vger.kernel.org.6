Return-Path: <linux-kernel+bounces-568704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDCEA69996
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41ED7981BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE6A219A6B;
	Wed, 19 Mar 2025 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZiIXnefF"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0123921481E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412778; cv=fail; b=oz4J7nh+pdgHKNP1Ll8jPNHAscj5H3PX6mbrREeWSK4KhkujAMCFlQATrcTyN9m5YDr3qN2th2oT6AOu7DSNbp2i6gDnZMq2023iMDdHOgVrDoJfosejOL1Y4NDp+uwTfbNuicYWo4OjZU/5SEUrw1wMLZzsNJy2+exoJiCVcKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412778; c=relaxed/simple;
	bh=vqhVZEqfzvz64eoLRfrl0/5zZCtF0jAWVjQKYxO58sc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8G/9eGlY1O26GmwuNuqJwMbHV0z0jpbrMYCC5BZKImFklpC+m8vm85a7P9aVjO/wzUHTULFVoRg28kkWXcvL656f6Z+FGQ1D7g9cw6JenpI1MnRWuETqoMdKSLelV8joOXoibjvRfrCYpAOMcnqpcSruhbHJrOdrDC1hideB6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZiIXnefF; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcrRp8ibA1L8lZ/lJnU4UdcQBLzd/+9sMG+ccYx7+EaPlqpbtKCJICX46n2lR04M9nnZ3vf7CrY9mPh/gunz+BCmqJliF5PGmivbUDU2XTd1v6giuRWaTQalSKjMA4CLeg+lpOJKradrjhQTfnhPT9aHJzbsyL2Zb/bZn031Zh4LaRC+SnUk9dNxl/iH0yq5kfrFfFwERNcPFvojEgFbs5n+1HYf2Pwugm8226fGLOYHXTUEgJ/T5H4UxA2yUW/8klPVgmd8nplT4/P+QZLOih2tOBSSUu+lPxfFdz8/Eozu+TTzHMK3FZPeqYDlH2gUQd34f6YY/advwepsO1cceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMsrH2gwsvfzOvnhHaikDdLZ0RBu7hhS898jqAkzLyg=;
 b=NrJGMPqUjR8GANHmbt7fv8A8LFVqXVUbhOO34OKSPX41wf7xZcpjQms2qOl+gH8VCgsV8rduWI3ApVygX2qO03vDqg+kx+x3jW5ot+ezAi+PiqUYE5mj+LAgyHlVacqk0VunZMEtXew+FXm6dHIVeVOalXLstbR0xKZYvjgV2xTRy2RE4WNrrMmmnI7HUWLEu6sLZOOiJYjpiaWT429ROKLH6rNlFmzSguJgsZBDGL4hIUsapsFxk3BVVxuesec7QHYgtSeiqc0QfjNxVbT5YvHCC0/5pT5z2aPKtSQzrAfOmkdWjy1sQCLb361WPx+0Zecyr6IJRsN6x/cx66lWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMsrH2gwsvfzOvnhHaikDdLZ0RBu7hhS898jqAkzLyg=;
 b=ZiIXnefF1S/ioqWWZlOnbYguX0sEyJgPjFz3aZWjvwM7Wy5HE//UoVmGR2sKYnyvWuLAs4YtmIbXnADJT4A5rhexLE9gbmmWEu3jwnyJ3UaBcnLdWztiSMnJQvPoZHrcxLnnCuqSFq4+tdmLoAUMfO18sAeFpNLUuLEg00VpePs=
Received: from SN7PR04CA0024.namprd04.prod.outlook.com (2603:10b6:806:f2::29)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:32:51 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::2f) by SN7PR04CA0024.outlook.office365.com
 (2603:10b6:806:f2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 19:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:32:51 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:32:41 -0500
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
Subject: [RFC PATCH V1 11/13] vmstat: Add vmstat counters
Date: Wed, 19 Mar 2025 19:30:26 +0000
Message-ID: <20250319193028.29514-12-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CH2PR12MB4102:EE_
X-MS-Office365-Filtering-Correlation-Id: 187ab32e-35b4-463c-0133-08dd671cd69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?388euDnwXyJ8MZTQe0dJ4kEIxumWHeEgVXY4HIQTOOofsXvWc6We2QmB0Vvy?=
 =?us-ascii?Q?H07J2lUgKahX1szjHK4TErKl3Mx6UfEeprEdcCJLkIqcu0QHMBjo2Hbqd0fq?=
 =?us-ascii?Q?xULwriLDR38n2JU5sJSacVQhW2It7nrzRgFDS++UCnPxMmEisDXRfnxYkAMw?=
 =?us-ascii?Q?FGl77Nx30wj1Ls767ZMYhLnRY9ElzxGjnkEJIn0CR/tYQB8LHKSlOl0A6FHT?=
 =?us-ascii?Q?TibU1qRtoPAS49sMqHPNAjk8+Uo97Yjd0jpU8a5zSfyBRAVixs5g0k53DI8U?=
 =?us-ascii?Q?e3OcD/AtwEZKLNXtPk4MtTDcp6W+yysj4z3AQ4jUGP03J/C9cR1C40dc6+4b?=
 =?us-ascii?Q?1kv8sXrnDQR66josTGcSLJumFuVN9tmm/Dbg7YTTWv3afP1gMGmPXonMXDBm?=
 =?us-ascii?Q?wosibZRuCRKpQ3qxU07bUV8a/ikJsTcwczVENdr5NzZRZbjpWxSkhWeAyzHz?=
 =?us-ascii?Q?/qVawpa9QXhSK9eZ2Mot9sVXI1iP2Ha9jXlBkAsyRGZEsGT4MrgIK0MtMA4+?=
 =?us-ascii?Q?inktlHgCmvJbv2QkVr+6h6Pd7IxnAviuK2KAJD6odTP7JTs35ouU0RGKUh4Z?=
 =?us-ascii?Q?lhoOmkS19GR4iAPP4ZXDej8bvdZ7ik92XrbboibiDyG1oR7XM4cbpRYnc04E?=
 =?us-ascii?Q?wAvXyEAbHZYq4e6hOD/MAbMKKSPtqIoPz+2b3KhPRfNjg+2fM3/clWltBUw4?=
 =?us-ascii?Q?FsrHgR+/2PqSiKp/DRmcFo0O2wYKHPtbobAZwQhzrBSfZySlcANOI1nPeYLK?=
 =?us-ascii?Q?SwpbpRYpCzITbIhXUybeAXMjtWcKdjlDJ+ExlGD9qyauhrtTu+LFZ0Aq1wLf?=
 =?us-ascii?Q?/2Rz3RPKgOgyMUiC7rnwgFXnklQLZisd5DgPRgjBSckq4YQrcOSSACW/G9cP?=
 =?us-ascii?Q?pLnYEdHZL4wyZ5W2BfKYYfMWsUp5ij9cYDb4T8nC0GN9PXFyqumYkDBi6KjU?=
 =?us-ascii?Q?atNmWChBShsFyFRmcVXfg83P0GrIGLhH/Lf2H5qOPIbxXey0LpwWxMSLdnms?=
 =?us-ascii?Q?40tBGOabFRNrbLJM8OkZiXfO6q2WjCCrwj0U2VW+Fr/oaxm7XB1qJT575ybg?=
 =?us-ascii?Q?csZ9KaL5YtU35yeFi3a9nisgsl3pFIjijSvGcx/IeLFup5ez3lsHE02V/ZGB?=
 =?us-ascii?Q?54pmqIF/II1xr3TOPX7akjlwsUdglLFUPqwYFTI9TPBBZDod8J2PTeBG/Z2A?=
 =?us-ascii?Q?TvdPh7ktUyAqdq2jrvmowdcOotOCP6synpx/rciBBg5o3AT3g3zMmVWntniM?=
 =?us-ascii?Q?GpQa214qQ5PGYPzpuXJPxWlAirBYTZNZMdXH52h4+gOHDzEq3L+kCEpGhs9/?=
 =?us-ascii?Q?Yko6Ac2zK6Ik5TU8Gs65HOAzhbrPsRazz13Ud2dKbwyTpcWtax+DCqsABQ9k?=
 =?us-ascii?Q?KKpgGj0ztja9TqisYXMolo1ytl6KlJtvIO2Ydk9sgowvq+X8zZ+UvfuwI8eJ?=
 =?us-ascii?Q?pVMhHu2Zs9cXdQZtMO9yJNp4WhRe1deO2Te+id6IOnLo4GZxAidDLNTNOZBM?=
 =?us-ascii?Q?bNmjE3s/ySHpwOE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:32:51.3146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 187ab32e-35b4-463c-0133-08dd671cd69c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102

Add vmstat counter to track scanning, migration and
type of pages.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm.h            | 11 ++++++++
 include/linux/vm_event_item.h | 10 +++++++
 mm/kmmscand.c                 | 52 ++++++++++++++++++++++++++++++++++-
 mm/vmstat.c                   | 10 +++++++
 4 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..e40a38c28a63 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -682,6 +682,17 @@ struct vm_operations_struct {
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
index 618594d7c148..c88b30e0fc7d 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -323,6 +323,39 @@ struct attribute_group kmmscand_attr_group = {
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
@@ -769,6 +802,9 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 		return 0;
 	}
 
+	if (node_is_toptier(srcnid))
+		count_kmmscand_toptier();
+
 	if (!folio_test_idle(folio) || folio_test_young(folio) ||
 			mmu_notifier_test_young(mm, addr) ||
 			folio_test_referenced(folio) || pte_young(pteval)) {
@@ -784,14 +820,18 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 		info = kzalloc(sizeof(struct kmmscand_migrate_info), GFP_NOWAIT);
 		if (info && scanctrl) {
 
+			count_kmmscand_slowtier();
 			info->mm = mm;
 			info->address = addr;
 			info->folio = folio;
 
 			/* No need of lock now */
 			list_add_tail(&info->migrate_node, &scanctrl->scan_list);
+
+			count_kmmscand_migadded();
 		}
-	}
+	} else
+		count_kmmscand_idlepage();
 
 	folio_set_idle(folio);
 	folio_put(folio);
@@ -907,6 +947,12 @@ static void kmmscand_migrate_folio(void)
 				ret = kmmscand_promote_folio(info, dest);
 			}
 
+			/* TBD: encode migrated count here, currently assume folio_nr_pages */
+			if (!ret)
+				count_kmmscand_migrated();
+			else
+				count_kmmscand_migrate_failed();
+
 			kfree(info);
 
 			spin_lock(&kmmscand_migrate_lock);
@@ -1083,6 +1129,7 @@ static unsigned long kmmscand_scan_mm_slot(void)
 
 	for_each_vma(vmi, vma) {
 		kmmscand_walk_page_vma(vma, &kmmscand_scanctrl);
+		count_kmmscand_vma_scans();
 		vma_scanned_size += vma->vm_end - vma->vm_start;
 
 		if (vma_scanned_size >= mm_slot_scan_size ||
@@ -1108,6 +1155,8 @@ static unsigned long kmmscand_scan_mm_slot(void)
 
 	update_mmslot_info = true;
 
+	count_kmmscand_mm_scans();
+
 	total = get_slowtier_accesed(&kmmscand_scanctrl);
 	target_node = get_target_node(&kmmscand_scanctrl);
 
@@ -1123,6 +1172,7 @@ static unsigned long kmmscand_scan_mm_slot(void)
 		kmmscand_update_mmslot_info(mm_slot, total, target_node);
 	}
 
+
 outerloop:
 	/* exit_mmap will destroy ptes after this */
 	mmap_read_unlock(mm);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 16bfe1c694dd..3a6fa834ebe0 100644
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
2.34.1


