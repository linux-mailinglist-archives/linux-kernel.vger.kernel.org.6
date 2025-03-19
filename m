Return-Path: <linux-kernel+bounces-568671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2141A6992E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A2718925F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DBF2139C7;
	Wed, 19 Mar 2025 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lk94Pf9C"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1F1E0B86
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412230; cv=fail; b=FWbWTGgWNqk0Z7VpgjgWeUmAo4WJ3glUL3xcLZYeTglk+MN3nqXqqkfKwhJut85MI7aMSzB68XYB352GNwppSPDwZmRf5oxYQ0881TrWIzwm3wCNRDngJfIVjQZi2iJcut6pXWQtxHfN6YvCul+2sUkjO0Ah9HEHRgdahLjiFng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412230; c=relaxed/simple;
	bh=pOHlxDcIQ2vTSb71xqhcVRTTZ2Up3EuOQU3sKiqXxSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyePGV/d/AO66sk4Oj+UlP6uu85ojeLVL2Ncy13gAf2LKxCelNSZDYF9BgES8lJ+i61GVBBKC/EXYLaI47PsU6/iluXsPO2qWblheOkDQ6gpRh+081QZh+Mdj+3iy+vkgC+LJPOKNRbKw434UicVA2j0DD65sUHFvkM3uQ2GaQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lk94Pf9C; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHYBrowxLzylWRqCuSomJ3W2ojvElgZrcEw5b/AGhpwFcnoYwBIMIO7TFrEiraY2RjWRj/0V6jaQGzUjKEPhToSBqCEGxJWif7cH0ItH7HLeELYjc9TGqy9w/8QUf5i9nu+mRuTc1Hvc6xRNM0Xu92UMGec8QD00ZxvO44cqZEM8w5u7g4f3tLf9zmcOhPTr4CTG0eo4ip1Y4enXDazbVJcZol1074R7DDt9neRvW812P2jXsi495XMRRLKMy6MXAWOgC1aKDfGjXl7xDIvBP0dRRy3ZOP9xo9kY4Hs3FNdgDdsYyoNzdb/Pw06MJY2P140qxePxX8pMm97bth59Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oi6OB1LzwfSy1hb0t8o9q2QfNMHz3zUKojtPDKuE4c8=;
 b=D8uok86m0PB2jftkhjK09lAdgGZqpo0SfDjgX6jEEg7Mu7rUZirrzss/i+l/w8gAfjFnwVkS/H2zUDT6MlpgRZz+yGeNaBCEhAhuvth7K3iWSVb67iEbzaoYYZ+ASKyeCVajCVVugllED0xPcHbMCyc0AWOuxchJTSLggJ3y370StbFzsHl826RDKv3OsXDIVQxS9tEEAmqQaM71aggVkYmlrJQ247mq3mhzVkjlj8yT5qRO3vawVMnmgseCH5kJ+7yvcPMbiYIDsoA8dIT6F2NzPq8CU8G8Ix3H0HW+KWXfMzPhASD81VPPy85WjmTsFhOBK1YA8EbipWcNBa3WRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi6OB1LzwfSy1hb0t8o9q2QfNMHz3zUKojtPDKuE4c8=;
 b=Lk94Pf9CuwJPH0mwyc+h1TJjethlp3qZe+CXHRr0Hxq359V6dGtHZhHFGCZvfEDuuyE0JJYbJGboti+y56MmWiOruZWJq9FEWi9G9RZ9CWYdEOP/wRAHtqpkO+yP/SceC5WM/i5ypjvOkCjjZPjc58X3sRe4OmOuBDa/FB0Vx+A=
Received: from DS7PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:3bb::16)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:23:42 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::49) by DS7PR03CA0071.outlook.office365.com
 (2603:10b6:5:3bb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 19:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:23:42 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:23:33 -0500
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
Subject: [PATCH RFC V2 4/9] mm/migrate: add migrate_folios_batch_move to batch the folio move operations
Date: Wed, 19 Mar 2025 19:22:07 +0000
Message-ID: <20250319192211.10092-5-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: be185686-a276-4bb1-03c1-08dd671b8f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4yG82fjcfSYrRunChtn23amHxAVznV+Gi2cCH9bNtqym/WYKDBhGecZeIn3L?=
 =?us-ascii?Q?uUKGUW95Vukl99iE2rkNGvqGkhG5uRhHYTREfvqcQkK8wJfxazWxUoCV3XeH?=
 =?us-ascii?Q?j4MzbFTovqN+A/mSgSz7dZzFKMgTopgOw5TUC2qqzm9Im3nb6ed+W2uszBOZ?=
 =?us-ascii?Q?WoVivX2v6SrHJJwB8/0BfV/EXyj7WyBs+dq/N1iv1Au7BwwSym/4Nvo0crPH?=
 =?us-ascii?Q?R/IOpW6/D3ZFNyzM127E8QRSwo7ckJY6qA/LkIBYZevXDtM1HoFUF9lv5TIg?=
 =?us-ascii?Q?IKvXBwFb9Pi4vkTCDdfPVXOLDbdXqG3Ude3GkYJA6cDbe9Ef3773ttLUuzD1?=
 =?us-ascii?Q?zQxLuDckZuwH0l5opuG3nyugemkHg24aE0j2cGuA45HSZQFlalGk/xcSq7rI?=
 =?us-ascii?Q?hYaGIYjNQOggi8Lh5EMhnQMMRCLwWdbtCE+QSc5f88LbkfTWEurIJRhO2xjI?=
 =?us-ascii?Q?2rZXi/SqVFhLdyjmEjMNcA/Sivx+hEU4OzkQM5o8UA6oGObWJfnh4wqISmDP?=
 =?us-ascii?Q?5300sbg9j9ZkkygtBqIJOumyiiuUdSAGzZbq+iCU5R/j+upGwF2AjQJ6V97k?=
 =?us-ascii?Q?kx1jkntcZXwgfcH23xkLawI03nzx/nA8Gzn9Z72EdJ1L/FISFVRzOfe2bhkQ?=
 =?us-ascii?Q?zcNBzEj56bMjR5ABz73onoHVVSc+dZY8PTFd8he8EqNOkBTgy+E//ORqtjP+?=
 =?us-ascii?Q?rl1fmEbR9PAKTxLWJxiqA4Xjl8Qmw/UaV6bv/GnenxOJYGt0qS48+GUAOPaE?=
 =?us-ascii?Q?/P8TbMFSygcpCVpiJP1H52MUn38hZCs7AWtItZ91JyxgH18u1aHhDHaEF6SN?=
 =?us-ascii?Q?pFtQt/jsxC7pJzLRlJGrbe+zr3gRwPC6yAymkBUebXW3Vlr56PzsVB6f1MVb?=
 =?us-ascii?Q?vpVRR57jG6S3qae6m6TLmpRiDeAKLpDEExW+qmQhbcC5gE7U67ye0AcPDmtX?=
 =?us-ascii?Q?VpVMhkGd6BHl8/pSkPfFXnNdZb/kEC1ega6mY7G5Y15EYraNzQPVBlY8KF/J?=
 =?us-ascii?Q?GYVYLzKQyEcGD57fRf2VPhRDUPPYjChQht3ObRo7nKefCxqfhU0Y920I2omX?=
 =?us-ascii?Q?TgVhdhUKXtMhv/uxbvHlJHgbuGbNs55Tv0Fuel7HzzSgKQC8YrT+Vpl1V8I4?=
 =?us-ascii?Q?FEWJGDaAO6fNCfL5JIMk4r/dPqwMBc3holnGte4iMKbLP8nDOvSdsuOb9JZm?=
 =?us-ascii?Q?i2RhIBwL7TA/dM+FBZbLnRWZniKyUC1rxLnylFnx9osdXovIK0SgQ14jJOq4?=
 =?us-ascii?Q?1rBz8qMpgzwBtR2UafTq0MLlMwOnPkxHp9gJFAgXIWAnwucsLoxQBCfJUiY7?=
 =?us-ascii?Q?BpE5t4ar5dbQM4kDbVkF84SQw9R0339HOLS7DNvlinMsZBqCY09W4J3Lmmhy?=
 =?us-ascii?Q?Rj/yLaFbOBtM+JkmNRmgBOypymYSb8aRhthhIdlRhsHtlrLk3U0b0t/cVw5X?=
 =?us-ascii?Q?i0wAjldmLxuNKbBQ60KFAljXNkTc+49lZBMKbZGPXg/QyUwGU5EJt7HmVGG0?=
 =?us-ascii?Q?dtSib5lWoNIxpGU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:23:42.5994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be185686-a276-4bb1-03c1-08dd671b8f9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156

This is a preparatory patch that enables batch copying for folios
undergoing migration. By enabling batch copying the folio content, we can
efficiently utilize the capabilities of DMA hardware or multi-threaded
folio copy. It uses MIGRATE_NO_COPY to skip folio copy during metadata
copy process and performed the copies in a batch later.

Currently, the folio move operation is performed individually for each
folio in sequential manner:
for_each_folio() {
        Copy folio metadata like flags and mappings
        Copy the folio content from src to dst
        Update page tables with dst folio
}

With this patch, we transition to a batch processing approach as shown
below:
for_each_folio() {
        Copy folio metadata like flags and mappings
}
Batch copy all src folios to dst
for_each_folio() {
        Update page tables with dst folios
}

dst->private is used to store page states and possible anon_vma value,
thus needs to be cleared during metadata copy process. To avoid additional
memory allocation to store the data during batch copy process, src->private
is used to store the data after metadata copy process, since src is no
longer used.

[Zi Yan: Refactor the patch. Improved the original patch by removing the
need for an extra mig_info allocation (for storing anon_vma and old page
state). Instead, reuse src->private to store the data, making the
implementation simpler and efficient.]

Signed-off-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 204 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 198 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 0d40ac069cea..8b6cfb60087c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -752,12 +752,15 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 			   enum migrate_mode mode)
 {
 	int rc, expected_count = folio_expected_refs(mapping, src);
+	unsigned long dst_private = (unsigned long)dst->private;
 
 	/* Check whether src does not have extra refs before we do more work */
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
 
-	if (mode != MIGRATE_NO_COPY) {
+	if (mode == MIGRATE_NO_COPY)
+		dst->private = NULL;
+	else {
 		rc = folio_mc_copy(dst, src);
 		if (unlikely(rc))
 			return rc;
@@ -771,6 +774,10 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 		folio_attach_private(dst, folio_detach_private(src));
 
 	folio_migrate_flags(dst, src);
+
+	if (mode == MIGRATE_NO_COPY)
+		src->private = (void *)dst_private;
+
 	return MIGRATEPAGE_SUCCESS;
 }
 
@@ -1044,7 +1051,7 @@ static int _move_to_new_folio_prep(struct folio *dst, struct folio *src,
 								mode);
 		else
 			rc = fallback_migrate_folio(mapping, dst, src, mode);
-	} else {
+	} else if (mode != MIGRATE_NO_COPY) {
 		const struct movable_operations *mops;
 
 		/*
@@ -1062,7 +1069,8 @@ static int _move_to_new_folio_prep(struct folio *dst, struct folio *src,
 		rc = mops->migrate_page(&dst->page, &src->page, mode);
 		WARN_ON_ONCE(rc == MIGRATEPAGE_SUCCESS &&
 				!folio_test_isolated(src));
-	}
+	} else
+		rc = -EAGAIN;
 out:
 	return rc;
 }
@@ -1140,7 +1148,7 @@ static void __migrate_folio_record(struct folio *dst,
 	dst->private = (void *)anon_vma + old_page_state;
 }
 
-static void __migrate_folio_extract(struct folio *dst,
+static void __migrate_folio_read(struct folio *dst,
 				   int *old_page_state,
 				   struct anon_vma **anon_vmap)
 {
@@ -1148,6 +1156,13 @@ static void __migrate_folio_extract(struct folio *dst,
 
 	*anon_vmap = (struct anon_vma *)(private & ~PAGE_OLD_STATES);
 	*old_page_state = private & PAGE_OLD_STATES;
+}
+
+static void __migrate_folio_extract(struct folio *dst,
+				   int *old_page_state,
+				   struct anon_vma **anon_vmap)
+{
+	__migrate_folio_read(dst, old_page_state, anon_vmap);
 	dst->private = NULL;
 }
 
@@ -1770,6 +1785,178 @@ static void migrate_folios_move(struct list_head *src_folios,
 	}
 }
 
+static void migrate_folios_batch_move(struct list_head *src_folios,
+		struct list_head *dst_folios,
+		free_folio_t put_new_folio, unsigned long private,
+		enum migrate_mode mode, int reason,
+		struct list_head *ret_folios,
+		struct migrate_pages_stats *stats,
+		int *retry, int *thp_retry, int *nr_failed,
+		int *nr_retry_pages)
+{
+	struct folio *folio, *folio2, *dst, *dst2;
+	int rc, nr_pages = 0, nr_batched_folios = 0;
+	int old_page_state = 0;
+	struct anon_vma *anon_vma = NULL;
+	int is_thp = 0;
+	LIST_HEAD(err_src);
+	LIST_HEAD(err_dst);
+
+	if (mode != MIGRATE_ASYNC) {
+		*retry += 1;
+		return;
+	}
+
+	/*
+	 * Iterate over the list of locked src/dst folios to copy the metadata
+	 */
+	dst = list_first_entry(dst_folios, struct folio, lru);
+	dst2 = list_next_entry(dst, lru);
+	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+		is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
+		nr_pages = folio_nr_pages(folio);
+
+		/*
+		 * dst->private is not cleared here. It is cleared and moved to
+		 * src->private in __migrate_folio().
+		 */
+		__migrate_folio_read(dst, &old_page_state, &anon_vma);
+
+		/*
+		 * Use MIGRATE_NO_COPY mode in migrate_folio family functions
+		 * to copy the flags, mapping and some other ancillary information.
+		 * This does everything except the page copy. The actual page copy
+		 * is handled later in a batch manner.
+		 */
+		rc = _move_to_new_folio_prep(dst, folio, MIGRATE_NO_COPY);
+
+		/*
+		 * The rules are:
+		 *	Success: folio will be copied in batch
+		 *	-EAGAIN: move src/dst folios to tmp lists for
+		 *	         non-batch retry
+		 *	Other errno: put src folio on ret_folios list, restore
+		 *	             the dst folio
+		 */
+		if (rc == -EAGAIN) {
+			*retry += 1;
+			*thp_retry += is_thp;
+			*nr_retry_pages += nr_pages;
+
+			list_move_tail(&folio->lru, &err_src);
+			list_move_tail(&dst->lru, &err_dst);
+			__migrate_folio_record(dst, old_page_state, anon_vma);
+		} else if (rc != MIGRATEPAGE_SUCCESS) {
+			*nr_failed += 1;
+			stats->nr_thp_failed += is_thp;
+			stats->nr_failed_pages += nr_pages;
+
+			list_del(&dst->lru);
+			migrate_folio_undo_src(folio,
+					old_page_state & PAGE_WAS_MAPPED,
+					anon_vma, true, ret_folios);
+			migrate_folio_undo_dst(dst, true, put_new_folio, private);
+		} else /* MIGRATEPAGE_SUCCESS */
+			nr_batched_folios++;
+
+		dst = dst2;
+		dst2 = list_next_entry(dst, lru);
+	}
+
+	/* Exit if folio list for batch migration is empty */
+	if (!nr_batched_folios)
+		goto out;
+
+	/* Batch copy the folios */
+	rc = folios_mc_copy(dst_folios, src_folios, nr_batched_folios);
+
+	/* TODO:  Is there a better way of handling the poison
+	 * recover for batch copy, instead of falling back to serial copy?
+	 */
+	/* fallback to serial page copy if needed */
+	if (rc) {
+		dst = list_first_entry(dst_folios, struct folio, lru);
+		dst2 = list_next_entry(dst, lru);
+		list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+			is_thp = folio_test_large(folio) &&
+				 folio_test_pmd_mappable(folio);
+			nr_pages = folio_nr_pages(folio);
+			rc = folio_mc_copy(dst, folio);
+
+			if (rc) {
+				/*
+				 * dst->private is moved to src->private in
+				 * __migrate_folio(), so page state and anon_vma
+				 * values can be extracted from (src) folio.
+				 */
+				__migrate_folio_extract(folio, &old_page_state,
+						&anon_vma);
+				migrate_folio_undo_src(folio,
+						old_page_state & PAGE_WAS_MAPPED,
+						anon_vma, true, ret_folios);
+				list_del(&dst->lru);
+				migrate_folio_undo_dst(dst, true, put_new_folio,
+						private);
+			}
+
+			switch (rc) {
+			case MIGRATEPAGE_SUCCESS:
+				stats->nr_succeeded += nr_pages;
+				stats->nr_thp_succeeded += is_thp;
+				break;
+			default:
+				*nr_failed += 1;
+				stats->nr_thp_failed += is_thp;
+				stats->nr_failed_pages += nr_pages;
+				break;
+			}
+
+			dst = dst2;
+			dst2 = list_next_entry(dst, lru);
+		}
+	}
+
+	/*
+	 * Iterate the folio lists to remove migration pte and restore them
+	 * as working pte. Unlock the folios, add/remove them to LRU lists (if
+	 * applicable) and release the src folios.
+	 */
+	dst = list_first_entry(dst_folios, struct folio, lru);
+	dst2 = list_next_entry(dst, lru);
+	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+		is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
+		nr_pages = folio_nr_pages(folio);
+		/*
+		 * dst->private is moved to src->private in __migrate_folio(),
+		 * so page state and anon_vma values can be extracted from
+		 * (src) folio.
+		 */
+		__migrate_folio_extract(folio, &old_page_state, &anon_vma);
+		list_del(&dst->lru);
+
+		_move_to_new_folio_finalize(dst, folio, MIGRATEPAGE_SUCCESS);
+
+		/*
+		 * Below few steps are only applicable for lru pages which is
+		 * ensured as we have removed the non-lru pages from our list.
+		 */
+		_migrate_folio_move_finalize1(folio, dst, old_page_state);
+
+		_migrate_folio_move_finalize2(folio, dst, reason, anon_vma);
+
+		/* Page migration successful, increase stat counter */
+		stats->nr_succeeded += nr_pages;
+		stats->nr_thp_succeeded += is_thp;
+
+		dst = dst2;
+		dst2 = list_next_entry(dst, lru);
+	}
+out:
+	/* Add tmp folios back to the list to re-attempt migration. */
+	list_splice(&err_src, src_folios);
+	list_splice(&err_dst, dst_folios);
+}
+
 static void migrate_folios_undo(struct list_head *src_folios,
 		struct list_head *dst_folios,
 		free_folio_t put_new_folio, unsigned long private,
@@ -1980,13 +2167,18 @@ static int migrate_pages_batch(struct list_head *from,
 	/* Flush TLBs for all unmapped folios */
 	try_to_unmap_flush();
 
-	retry = 1;
+	retry = 0;
+	/* Batch move the unmapped folios */
+	migrate_folios_batch_move(&unmap_folios, &dst_folios, put_new_folio,
+			private, mode, reason, ret_folios, stats, &retry,
+			&thp_retry, &nr_failed, &nr_retry_pages);
+
 	for (pass = 0; pass < nr_pass && retry; pass++) {
 		retry = 0;
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
-		/* Move the unmapped folios */
+		/* Move the remaining unmapped folios */
 		migrate_folios_move(&unmap_folios, &dst_folios,
 				put_new_folio, private, mode, reason,
 				ret_folios, stats, &retry, &thp_retry,
-- 
2.34.1


