Return-Path: <linux-kernel+bounces-426648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C59DF647
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7411BB2165C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4FE1D5CD6;
	Sun,  1 Dec 2024 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V0p5WyhP"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F261D6DB4
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733067564; cv=fail; b=Gm4I5DD6zfODtFIjjJnzwZB98D1G+uhPpzVQU8sLHsWb64RGt6EJEzWB0RKyTGwGSzkPywEvS58/umcCZc+uZKyZDgDfOEUu+CX/Qj3f1nsREeT4DMziSPdPHvQfrDX73EfJL9mgdLvy01X7kXsk/OFshpmjopv57K8NOHV07b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733067564; c=relaxed/simple;
	bh=vapLt8f/TAUyErMgW4oujUahxOE0EHVbkwfYMlLoKt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6qO/zuHe34ZfIRkGDawalKH1uwuabaeU8NBvR2qrOMuCQSoFuGLI827hTQOM1mnKgsKOrR6XhsvsHiZMkkndoywbrF0aNU1jjxqTlRkO+6aNAHmM20AvEGRb2CrI3xxI8dPIX+o+iXuDn3aceIaaDJFeCjGANsQ7mI6Lzipt7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V0p5WyhP; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eq/wLDx6ugTfmZshqkqmyVHV9T2lCfTgmz4ibIvVB4gSJE5A10DAMqs6zhixk+gJLWZPNDbNXXDoGj+ia2TbSNcdKJgIqKwHrS5Zw9N7fB+eB24X/qC4O/Rgj0rdcDuoSqqW1JV+oXRy3W+C4+oC0DcLP3w2Bo0BL06wDbWP3gq4MGDb7ZqxKJxnuvuTSG9WB3Y+RueqQSER1hgpca3DmOYEY6xB7X5mBDepbxPx4PCy9pKdap45QJrjNrlC26W7ng9hZ2KYF81pvoNlMsKhZMrcsN8D7BnWy+hD/CUAnQrgOPgElcMhDo9xtR4jSe3B2/g084F3gjVW1jdI318j0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se4i7oWsjWVI2dcozt7u1pG3jASFmxn3pMpuXEaD3CM=;
 b=ROBN0q8trI19gWNd1HweayjKHLg2EMe6BtKSR6IfYshmhvvx3tZ+3T5T1Cp4Tr2RZE+IX8X/e5miAOX5isVWgw7ove2Oi5M06tHjB9a/Y/pctfksUMSnt1DDmkSh1Gqkysi3dsowQGu8mLWTvUR/stzJqckuBMNoM9jOVFU0vwKccQsvc9ka/GEXqKRpagHdbbdbgD19OT5d9du8hK0iOj1hstODUyuQBKZq6hR1a+r0kMs8fc75RhhmQ73aMy5vgRGvyKhDWdRIgjVCPrW0358dXGHmCBHD+Jb3B0gK9RaPK3BSVqt5F37P0ne6r/tl8QIslr9whHt1gPXmXLmNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se4i7oWsjWVI2dcozt7u1pG3jASFmxn3pMpuXEaD3CM=;
 b=V0p5WyhPr85VBWbuRnbHwhW7ndb+B323uVjVWHtw+8pziiNpmyd89OX8pSYARC1pAK0BvWZ2TgPjG04KQsY8+ZFqUmQSMmozB2rQoFDsyh0dJXq8PSOuiXvwpa8HxGYN7rqq2EGGHjEgfvOyOHi86rrfFeJkd91K33aXZOCPZDw=
Received: from BY3PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:217::20)
 by CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sun, 1 Dec
 2024 15:39:17 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:217:cafe::7f) by BY3PR04CA0015.outlook.office365.com
 (2603:10b6:a03:217::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Sun,
 1 Dec 2024 15:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Sun, 1 Dec 2024 15:39:16 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 09:39:09 -0600
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
Subject: [RFC PATCH V0 04/10] mm/migration: Migrate accessed folios to toptier node
Date: Sun, 1 Dec 2024 15:38:12 +0000
Message-ID: <20241201153818.2633616-5-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CY8PR12MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3f6520-b0f3-4df4-344d-08dd121e50ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/lyhM3aHDzOb6iHkc+rtO3hrTk0/24KGdoW3LbpckxcQLrTD3s1KO4VWcdat?=
 =?us-ascii?Q?D7oAHBkHxPQpWtaHjE4Je62rTpRGoxbJmqqw+Z+Qn/dEZV4R1eDq9G4RBQfh?=
 =?us-ascii?Q?yFPAS0dAB+/g/vmxaQnsB7sAZmMvRvvXzq9EsuzOPb+9585h64m3skR5E8nr?=
 =?us-ascii?Q?W2M/YCf2pYOlvGO3j3gPS4Ee3WAoJ55jHIks4TnSBPV9TnOd5PDLnvvIIixd?=
 =?us-ascii?Q?mZ8PN5hilKMqXSYJ2uECIG/B23MFRWGzfZexN2TsOJNAGzS4KCbudkTqQeIe?=
 =?us-ascii?Q?2jHlLgTAG/TnitgNtys9UfFTZ1Xy+gDFQeafXOIx3Xbrze0/jp42qEJiBem/?=
 =?us-ascii?Q?ddahQRAWlHivYAtatoOxjhiqUqYxxbbBeN7vjDUz/9Ocg/D5beXSyMRpetqn?=
 =?us-ascii?Q?qmk2qMmb8AASg7Bvlb5ZMe3B4NP3n/lmjD98ujS9UHWcO/zWr5xIX+Mw9xU2?=
 =?us-ascii?Q?C0WLFb7ihzz31Pnc02f/zBh2O2Ur4aHWhLfaWNGfpyayc3qAlX/zo3WSLyw8?=
 =?us-ascii?Q?N3o8VBpQIeEyK258TP/dr3AJRd9bJowRvdT20cEh2BWeK0L/VkybKxu1eLKi?=
 =?us-ascii?Q?kzRt6SxPv2UAdQAdjUzmOBrD+4How8XpbI850kWIl1jcDSRO3Gpp4ti+Xi7c?=
 =?us-ascii?Q?Df/RhxSXY45cZ6Vjn1hTbeJEBWZi1rovq6AsDQjePI2tlOmfkSvlfYYFU9J/?=
 =?us-ascii?Q?qNiINhP6W42d9cpJOdpabmuj1073C9fZ0Ea/8v6sdJ5/xZXLLyYoUbh3obd8?=
 =?us-ascii?Q?OPbBYaXfEcVbYVtgcK+OfkBsIJrD+UAmlGRUHUTsvhGUutNDLalxkfQTvoGV?=
 =?us-ascii?Q?XG1HR71jwW1NF1mfF89Ls+bh9BkN9DIwxTyVW1Pe/iaLsnFPjuciZUM/xALm?=
 =?us-ascii?Q?4li1SwjKuXFjfqRwTezk6Le1AL5y0n0X2gQytxSIom1nKqefP3dLtgJQKKMC?=
 =?us-ascii?Q?3a9Fl7kraQACqjbl+AAxbQcdeMmzjyufa8DITjdubgmAFbLi1L1z22FiRpHF?=
 =?us-ascii?Q?CNxQbySm6QOdh41ojo3ONuXkLgDRs5WrdoPnsdYQjGvDfbVIarg3OlvOYKAb?=
 =?us-ascii?Q?kXfhUuADShC3qKaEgdLtUp/GBjCcmUkbFV6vphdCbX0tpJI+qgZrglukJ7Iv?=
 =?us-ascii?Q?2juL6BYRHXrLEdZrriuFqbyEE0dexUzRYDT5lFZmclMxlRlpqfabZYop6vO4?=
 =?us-ascii?Q?K9B5SYXNacu8BffV9HAwON9r9PLt3Wy8eeFt3UC5uw0XxdDzy1toMXAD1ghH?=
 =?us-ascii?Q?fBCpTlLc/zU9MXD4w6bTRO+phQNu68zslnyuEmRX0/3IX7aNYVXp+aCF5aUH?=
 =?us-ascii?Q?aQFd/chAJJ1PjQmS5Ug/O+ze1SXAm7Xl0pbkslvFcqKt9E5geqAw45nD3f97?=
 =?us-ascii?Q?ezbyVKkBpeM0pr1sAHxA9Bjmws9uQalPSuAA2uOJNoVLH3Xolv9co73qLfuj?=
 =?us-ascii?Q?Xa5LhNcy6ZvF1FsbPdhNofu9y7z+psl8oqdJU/+BxUdZeyS63VtY3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 15:39:16.6763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3f6520-b0f3-4df4-344d-08dd121e50ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266

For each recently accessed slowtier folio in the migration list:
 - Isolate LRU pages
 - Migrate to a regular node.

The rationale behind whole migration is to speedup the access to
recently accessed pages.

Limitation:
 PTE A bit scanning approach lacks information about exact destination
node to migrate to.

Reason:
 PROT_NONE hint fault based scanning is done in a process context. Here
when the fault occurs, source CPU of the fault associated task is known.
Time of page access is also accurate.
With the lack of above information, migration is done to node 0 by default.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kmmscand.c | 178 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

TBD: Before calling migrate_misplaced_folio, we need to hold a PTL lock.
But since we are not coming from fault path, it is tricky. We need to
fix this before the final patch.

diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 0496359d07f5..3b4453b053f4 100644
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
@@ -36,7 +37,15 @@ static unsigned long kmmscand_mms_to_scan __read_mostly = KMMSCAND_MMS_TO_SCAN;
 volatile bool kmmscand_scan_enabled = true;
 static bool need_wakeup;
 
+/* mm of the migrating folio entry */
+static struct mm_struct *kmmscand_cur_migrate_mm;
+
+/* Migration list is manipulated underneath because of mm_exit */
+static bool  kmmscand_migration_list_dirty;
+
 static unsigned long kmmscand_sleep_expire;
+#define KMMSCAND_DEFAULT_TARGET_NODE	(0)
+static int kmmscand_target_node = KMMSCAND_DEFAULT_TARGET_NODE;
 
 static DEFINE_SPINLOCK(kmmscand_mm_lock);
 static DEFINE_SPINLOCK(kmmscand_migrate_lock);
@@ -115,6 +124,107 @@ static bool kmmscand_eligible_srcnid(int nid)
 	return false;
 }
 
+/*
+ * Do not know what info to pass in the future to make
+ * decision on taget node. Keep it void * now.
+ */
+static int kmmscand_get_target_node(void *data)
+{
+	return kmmscand_target_node;
+}
+
+static int kmmscand_migrate_misplaced_folio_prepare(struct folio *folio,
+		struct vm_area_struct *vma, int node)
+{
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
+	if (!folio_isolate_lru(folio))
+		return -EAGAIN;
+
+	return 0;
+}
+
+enum kmmscand_migration_err {
+	KMMSCAND_NULL_MM = 1,
+	KMMSCAND_INVALID_FOLIO,
+	KMMSCAND_INVALID_VMA,
+	KMMSCAND_INELIGIBLE_SRC_NODE,
+	KMMSCAND_SAME_SRC_DEST_NODE,
+	KMMSCAND_LRU_ISOLATION_ERR,
+};
+
+static int kmmscand_promote_folio(struct kmmscand_migrate_info *info)
+{
+	unsigned long pfn;
+	struct page *page;
+	struct folio *folio;
+	struct vm_area_struct *vma;
+	int ret;
+
+	int srcnid, destnid;
+
+	if (info->mm == NULL)
+		return KMMSCAND_NULL_MM;
+
+	folio = info->folio;
+
+	/* Check again if the folio is really valid now */
+	if (folio) {
+		pfn = folio_pfn(folio);
+		page = pfn_to_online_page(pfn);
+	}
+
+	if (!page || !folio || !folio_test_lru(folio) ||
+		folio_is_zone_device(folio) || !folio_mapped(folio))
+		return KMMSCAND_INVALID_FOLIO;
+
+	vma = info->vma;
+
+	/* XXX: Need to validate vma here?. vma_lookup() results in 2x regression */
+	if (!vma)
+		return KMMSCAND_INVALID_VMA;
+
+	srcnid = folio_nid(folio);
+
+	/* Do not try to promote pages from regular nodes */
+	if (!kmmscand_eligible_srcnid(srcnid))
+		return KMMSCAND_INELIGIBLE_SRC_NODE;
+
+	destnid = kmmscand_get_target_node(NULL);
+
+	if (srcnid == destnid)
+		return KMMSCAND_SAME_SRC_DEST_NODE;
+
+	folio_get(folio);
+	ret = kmmscand_migrate_misplaced_folio_prepare(folio, vma, destnid);
+	if (ret) {
+		folio_put(folio);
+		return KMMSCAND_LRU_ISOLATION_ERR;
+	}
+	folio_put(folio);
+
+	return  migrate_misplaced_folio(folio, vma, destnid);
+}
+
 static bool folio_idle_clear_pte_refs_one(struct folio *folio,
 					 struct vm_area_struct *vma,
 					 unsigned long addr,
@@ -266,8 +376,74 @@ static void kmmscand_collect_mm_slot(struct kmmscand_mm_slot *mm_slot)
 	}
 }
 
+static void kmmscand_cleanup_migration_list(struct mm_struct *mm)
+{
+	struct kmmscand_migrate_info *info, *tmp;
+
+start_again:
+	spin_lock(&kmmscand_migrate_lock);
+	if (!list_empty(&kmmscand_migrate_list.migrate_head)) {
+
+		if (mm == READ_ONCE(kmmscand_cur_migrate_mm)) {
+			/* A folio in this mm is being migrated. wait */
+			WRITE_ONCE(kmmscand_migration_list_dirty, true);
+			spin_unlock(&kmmscand_migrate_lock);
+			goto start_again;
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
 static void kmmscand_migrate_folio(void)
 {
+	int ret = 0;
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
+			if (info->mm)
+				ret = kmmscand_promote_folio(info);
+
+			kfree(info);
+
+			spin_lock(&kmmscand_migrate_lock);
+			/* Reset  mm  of folio entry we are migrating */
+			WRITE_ONCE(kmmscand_cur_migrate_mm, NULL);
+			spin_unlock(&kmmscand_migrate_lock);
+dirty_list_handled:
+			//cond_resched();
+			spin_lock(&kmmscand_migrate_lock);
+		}
+	}
+	spin_unlock(&kmmscand_migrate_lock);
 }
 
 static unsigned long kmmscand_scan_mm_slot(void)
@@ -450,6 +626,8 @@ void __kmmscand_exit(struct mm_struct *mm)
 
 	spin_unlock(&kmmscand_mm_lock);
 
+	kmmscand_cleanup_migration_list(mm);
+
 	if (free) {
 		mm_slot_free(kmmscand_slot_cache, mm_slot);
 		mmdrop(mm);
-- 
2.39.3


