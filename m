Return-Path: <linux-kernel+bounces-568698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B80DA6996C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0F74843E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA5214A90;
	Wed, 19 Mar 2025 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GN6uGhX0"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4484F2144A6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412723; cv=fail; b=j3ou4Yc0K3H3EF/7lkmmAJ6AQ7isSMXrYNmsJVBIHICmEtqF/Nt+tRawAst0PUjIirnHCt4OcQRZP7huZEPe+on8orzXqUxGt11RJNiScRl3F8g9rxAX0TpYvEdD78gRXvF0Lv5CNEhwXiCLRIY7g13BVRhxKMqB7uXJFbVFl0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412723; c=relaxed/simple;
	bh=0AfJvqsXjDyDoCMdLjEMOrEjW8bwNMPcCAxf81HbnUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2ZNNyUF6EQ2WTkoARsST+MUqNDdx57U+OiQwBQs40sRwJN47J58U4PGqC4urlkPWE8cCIXrBzAfrh6gOiE/cNECDH/CFuRj/5Jn9B22vae/SZNqkF30XN7SW0LxM7EmZT7+IA8kA93/SwSj3M72p+xofNAbF98UyF1jqaFpNt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GN6uGhX0; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppJDLvpTagOkHNCEnoyM3sxIhBOiWvGelk244CtIPpPkQfYgXNqAMyMORKnNsIfTKwN/85jkQce5NO0VL2dKM/T4naJeRCVs74MVcrZRpCVujBxpbUsr+cHfcke5FtJHedZM8sNliJ9e9eGZko8LJK/cQbTmiL15VFkGqo6mqGEzdGr1ooKe6+a5N3P02abp70iagIyNqoFdx6XLmJggBe4hDrCf9li7xn90YAAuD7Ui14QuqYVjCLJdk60BfImO6p3kuOLNZKqoU5SgXUq8ZI5NlvKCRZQ2IlqEDKjnMV3x5C8f6t+4vqSsgR4DmFBeHXIJ49lyL0ipJTwGt6obBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsLJE/h2f3iBqJCSh/p9SqyDaJnSWoeY2MYMRp9SgIE=;
 b=dMtZIz2+VzWo0AZ/R1zgTPHh3Nne99eI4Pp137HEAi3I54/CSMU/0m0Sv0HD4xqSRXFk28/4GEiF48tYeyF90O0zJwO8jj0QZwW5fvZ2Nwh30dJFXzWDCU5cSzloWAwvloEzOlYCOogdTUB59Lti1tJ8TnI7dNMtEaAxoQrG2CcMUcqQzLYi41Q84k64vMQRlPwzWilcFuQaFP29giGBupRKum0tA3/QhkpfEVJ1sFnBOBBI1Se48w2tf4t+F/ZvvDkHkcRgaUfxEC2my8bvPZ5Q8rvVebhVo/+EoaLlN9+1Bk8879jelRjy13KnkivD11yqnm/g3VmEadZd3f9aqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsLJE/h2f3iBqJCSh/p9SqyDaJnSWoeY2MYMRp9SgIE=;
 b=GN6uGhX0nDlSZjalEwMOu0CfPljZOg/pns9KC6kD1YebA7RJS87FAL3RTa0VPRR8mONbABnMl50az+FyYaw8rowVxjz+sPo4Ujc1iHtJjHHxKND9W1lXbm9d3IwWFVZOEdX4oL0/lZDojuD4FaWl4eQa39QYZc3Klkst42kFhKI=
Received: from SN6PR05CA0020.namprd05.prod.outlook.com (2603:10b6:805:de::33)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 19:31:54 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::e3) by SN6PR05CA0020.outlook.office365.com
 (2603:10b6:805:de::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:31:53 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:31:42 -0500
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
Subject: [RFC PATCH V1 05/13] mm/migration: Migrate accessed folios to toptier node
Date: Wed, 19 Mar 2025 19:30:20 +0000
Message-ID: <20250319193028.29514-6-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f498ec8-74af-44c1-3a40-08dd671cb460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9SwE2bFnse8n/39XTWVI1UMO2afQRlhIF8aCdF5uxb/WfCFINloTJRFd2dpO?=
 =?us-ascii?Q?N/Pnm32NEMNWd0XwaAEdpe2ReO5rgUb2eNhJ8zt7W3w03P7eAOYza+Pf1adp?=
 =?us-ascii?Q?ui2Kp5BtHYXpvi0tIYP5SIJLFv5p2CGp3dri6bWmrLecHARzhXFc0ayCICsF?=
 =?us-ascii?Q?RkHWSYjsELwo8m6J5JoM2sFDoLfJ3RevXdA1NCq57uIYV271IoWa9UL77fD1?=
 =?us-ascii?Q?w+rJij7FG6fx+jHFoyOKejtF80SBC4ZIgHKU6lqIsi2RL4x6+MyyJ34Ogsrl?=
 =?us-ascii?Q?TUv6ZyGSyF0b74b0OoJyh5ta46VR0tx8uee1i6pSf/wbozoPIQnO96hObqAH?=
 =?us-ascii?Q?p5aFebuS0l5PrOdnKPW4zyDW1EZ12yks0CAiVS1VT5Fn79zu4axuKQHisG2o?=
 =?us-ascii?Q?0jChdLhzK3T44RMTepeP2iiJdzz2DqH27/yZsGtbSX/pLnUc7zbgwN9mNTf1?=
 =?us-ascii?Q?gds0gnehGeFZkYiEBAC1RbOZrfWHjRkX4odPYJpHSlzYRYtwZxMYkZ+Ln/mL?=
 =?us-ascii?Q?rKyP1RbiBHM/uJma8Y1b239WRAwzs+eDs+/fNiTiDMrQZG8fHNciezaLvRaP?=
 =?us-ascii?Q?YUGvXxup3bApBgyK39zX3XYg/PVQS2ok8j9qkgaAg/UM/kvjLmTh6AVMgmlp?=
 =?us-ascii?Q?azHo7MQ0sBzGbV2sZbCGusaJwPCHJoXDZui0HIOGLNxE5i+eFntn2ijMP1JC?=
 =?us-ascii?Q?p+d0mJ46Grjzwr4AhhbbBpnJtUjlgycHTSjfTqn8dslsTFunuk6SfkAoHMfg?=
 =?us-ascii?Q?5Z0XKlcQmS8Zy8dV2+2BHkZj1USdulusZpGZm5tECrJMtTsTCIEKOKhcliw4?=
 =?us-ascii?Q?610N70Yfxmsz5ZaPmGwPX+RmycQqATZsYrycJzqFWel31bxPgLLihF8SWr/3?=
 =?us-ascii?Q?OWKxiAjF41pbQkXYZvs7QnOICs6ZVvJhIhKPrvxSXBGUTnwjxBV56D5gB8Yo?=
 =?us-ascii?Q?Lc/yDwdro0yl46zxKnooyrOstJTvVok863/OKVbOIrHRi/B9zHO0WsZhUlXP?=
 =?us-ascii?Q?Dz6OxM1T77ht0FWMO3I0kKpKgHvVQ/7LxfZHfDSx+mO36iNnptkeY8WM1gYS?=
 =?us-ascii?Q?GTwkms5G/hN+YwuK0iFoIcrkLbELnQtxeuLgqd9g+emPzJ8vvYMyPOgPpIwV?=
 =?us-ascii?Q?cFmGFybBT6GuE2RWh1pVNz1BpO69d3lCWMrrK61T2Lo4bqn3A1JxKed8Obtv?=
 =?us-ascii?Q?dcDY1QVyXNxJVaTgjX9UL/Eg1Ryg2Ncf5JVd5VPx9A3PCrISJBrtbNRuO/uw?=
 =?us-ascii?Q?Ba7l2q34mpyC+P5jdh9qCeX+r6PqqkPzoDtBSwz2dC5NPhsJXOfbC5VmRSgN?=
 =?us-ascii?Q?4se0UYagG8kjwWtPUWbLcGdR+zYxa9SXbwTISPGfs8Buc4UfK1b5G6oz9+Ad?=
 =?us-ascii?Q?n4yp2+C6ejm5EhL/Hyt6PEen1WYH6ZIAs3D5/9dR3aF+NiA+krFbum/mO0oG?=
 =?us-ascii?Q?LwZsHtsvj/jRLk3s8TVmwLDxj43aeoG825qGP+xzzpP9Spab8pgy8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:31:53.8803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f498ec8-74af-44c1-3a40-08dd671cb460
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290

For each recently accessed slowtier folio in the migration list:
 - Isolate LRU pages
 - Migrate to a regular node.

The rationale behind whole migration is to speedup the access to
recently accessed pages.

Currently, PTE A bit scanning approach lacks information about exact
destination node to migrate to.

Reason:
 PROT_NONE hint fault based scanning is done in a process context. Here
when the fault occurs, source CPU of the fault associated task is known.
Time of page access is also accurate.
With the lack of above information, migration is done to node 0 by default.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/migrate.h |   2 +
 mm/kmmscand.c           | 209 ++++++++++++++++++++++++++++++++++++++++
 mm/migrate.c            |   2 +-
 3 files changed, 212 insertions(+), 1 deletion(-)

PS: Later in the patch a simple heuristic is used to find the target node

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 29919faea2f1..22abae80cbb7 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -142,6 +142,8 @@ const struct movable_operations *page_movable_ops(struct page *page)
 }
 
 #ifdef CONFIG_NUMA_BALANCING
+bool migrate_balanced_pgdat(struct pglist_data *pgdat,
+				   unsigned long nr_migrate_pages);
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node);
 int migrate_misplaced_folio(struct folio *folio, int node);
diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 6e96cfab5b85..feca775d0191 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -59,6 +59,8 @@ static struct mm_struct *kmmscand_cur_migrate_mm;
 static bool  kmmscand_migration_list_dirty;
 
 static unsigned long kmmscand_sleep_expire;
+#define KMMSCAND_DEFAULT_TARGET_NODE	(0)
+static int kmmscand_target_node = KMMSCAND_DEFAULT_TARGET_NODE;
 
 static DEFINE_SPINLOCK(kmmscand_mm_lock);
 static DEFINE_SPINLOCK(kmmscand_migrate_lock);
@@ -182,6 +184,76 @@ static void kmmmigrated_wait_work(void)
 			migrate_sleep_jiffies);
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
+extern bool migrate_balanced_pgdat(struct pglist_data *pgdat,
+					unsigned long nr_migrate_pages);
+
+/*XXX: Taken from migrate.c to avoid NUMAB mode=2 and NULL vma checks*/
+static int kmmscand_migrate_misplaced_folio_prepare(struct folio *folio,
+		struct vm_area_struct *vma, int node)
+{
+	int nr_pages = folio_nr_pages(folio);
+	pg_data_t *pgdat = NODE_DATA(node);
+
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
+	/* Avoid migrating to a node that is nearly full */
+	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
+		int z;
+
+		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
+			if (managed_zone(pgdat->node_zones + z))
+				break;
+		}
+
+		/*
+		 * If there are no managed zones, it should not proceed
+		 * further.
+		 */
+		if (z < 0)
+			return -EAGAIN;
+
+		wakeup_kswapd(pgdat->node_zones + z, 0,
+			      folio_order(folio), ZONE_MOVABLE);
+		return -EAGAIN;
+	}
+
+	if (!folio_isolate_lru(folio))
+		return -EAGAIN;
+
+	node_stat_mod_folio(folio, NR_ISOLATED_ANON + folio_is_file_lru(folio),
+			    nr_pages);
+
+	return 0;
+}
+
 static inline bool is_valid_folio(struct folio *folio)
 {
 	if (!folio || folio_test_unevictable(folio) || !folio_mapped(folio) ||
@@ -191,6 +263,101 @@ static inline bool is_valid_folio(struct folio *folio)
 	return true;
 }
 
+enum kmmscand_migration_err {
+	KMMSCAND_NULL_MM = 1,
+	KMMSCAND_EXITING_MM,
+	KMMSCAND_INVALID_FOLIO,
+	KMMSCAND_NONLRU_FOLIO,
+	KMMSCAND_INELIGIBLE_SRC_NODE,
+	KMMSCAND_SAME_SRC_DEST_NODE,
+	KMMSCAND_PTE_NOT_PRESENT,
+	KMMSCAND_PMD_NOT_PRESENT,
+	KMMSCAND_NO_PTE_OFFSET_MAP_LOCK,
+	KMMSCAND_LRU_ISOLATION_ERR,
+};
+
+static int kmmscand_promote_folio(struct kmmscand_migrate_info *info, int destnid)
+{
+	unsigned long pfn;
+	unsigned long address;
+	struct page *page;
+	struct folio *folio;
+	int ret;
+	struct mm_struct *mm;
+	pmd_t *pmd;
+	pte_t *pte;
+	spinlock_t *ptl;
+	pmd_t pmde;
+	int srcnid;
+
+	if (info->mm == NULL)
+		return KMMSCAND_NULL_MM;
+
+	if (info->mm == READ_ONCE(kmmscand_cur_migrate_mm) &&
+		READ_ONCE(kmmscand_migration_list_dirty)) {
+		WARN_ON_ONCE(mm);
+		return KMMSCAND_EXITING_MM;
+	}
+
+	mm = info->mm;
+	folio = info->folio;
+
+	/* Check again if the folio is really valid now */
+	if (folio) {
+		pfn = folio_pfn(folio);
+		page = pfn_to_online_page(pfn);
+	}
+
+	if (!page || PageTail(page) || !is_valid_folio(folio))
+		return KMMSCAND_INVALID_FOLIO;
+
+	if (!folio_test_lru(folio))
+		return KMMSCAND_NONLRU_FOLIO;
+
+	folio_get(folio);
+
+	srcnid = folio_nid(folio);
+
+	/* Do not try to promote pages from regular nodes */
+	if (!kmmscand_eligible_srcnid(srcnid)) {
+		folio_put(folio);
+		return KMMSCAND_INELIGIBLE_SRC_NODE;
+	}
+
+	/* Also happen when it is already migrated */
+	if (srcnid == destnid) {
+		folio_put(folio);
+		return KMMSCAND_SAME_SRC_DEST_NODE;
+	}
+	address = info->address;
+	pmd = pmd_off(mm, address);
+	pmde = pmdp_get(pmd);
+
+	if (!pmd_present(pmde)) {
+		folio_put(folio);
+		return KMMSCAND_PMD_NOT_PRESENT;
+	}
+
+	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
+	if (!pte) {
+		folio_put(folio);
+		WARN_ON_ONCE(!pte);
+		return KMMSCAND_NO_PTE_OFFSET_MAP_LOCK;
+	}
+
+	ret = kmmscand_migrate_misplaced_folio_prepare(folio, NULL, destnid);
+	if (ret) {
+		folio_put(folio);
+		pte_unmap_unlock(pte, ptl);
+		return KMMSCAND_LRU_ISOLATION_ERR;
+	}
+
+	folio_put(folio);
+	pte_unmap_unlock(pte, ptl);
+
+	return  migrate_misplaced_folio(folio, destnid);
+}
+
 static bool folio_idle_clear_pte_refs_one(struct folio *folio,
 					 struct vm_area_struct *vma,
 					 unsigned long addr,
@@ -379,6 +546,48 @@ static void kmmscand_collect_mm_slot(struct kmmscand_mm_slot *mm_slot)
 
 static void kmmscand_migrate_folio(void)
 {
+	int ret = 0, dest = -1;
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
+			if (info->mm) {
+				dest = kmmscand_get_target_node(NULL);
+				ret = kmmscand_promote_folio(info, dest);
+			}
+
+			kfree(info);
+
+			spin_lock(&kmmscand_migrate_lock);
+			/* Reset  mm  of folio entry we are migrating */
+			WRITE_ONCE(kmmscand_cur_migrate_mm, NULL);
+			spin_unlock(&kmmscand_migrate_lock);
+dirty_list_handled:
+			cond_resched();
+			spin_lock(&kmmscand_migrate_lock);
+		}
+	}
+	spin_unlock(&kmmscand_migrate_lock);
 }
 
 static unsigned long kmmscand_scan_mm_slot(void)
diff --git a/mm/migrate.c b/mm/migrate.c
index fb19a18892c8..a073eb6c5009 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2598,7 +2598,7 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
  * Returns true if this is a safe migration target node for misplaced NUMA
  * pages. Currently it only checks the watermarks which is crude.
  */
-static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
+bool migrate_balanced_pgdat(struct pglist_data *pgdat,
 				   unsigned long nr_migrate_pages)
 {
 	int z;
-- 
2.34.1


