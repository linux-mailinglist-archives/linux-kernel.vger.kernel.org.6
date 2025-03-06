Return-Path: <linux-kernel+bounces-548253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C78FA54267
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52DBA1893AF8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD931199396;
	Thu,  6 Mar 2025 05:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZwwKJzpG"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DC143166
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 05:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240047; cv=fail; b=cy0kAKhngb3BbSVv7w6Cz6t46Byua8wmwWs2rY7Nbx+Gd7LbQMvYbBhpdjFA10R1wcMBXwDRcs1pG39iyK6gwq6Aporqxqld/PIQLQuTLaH427XNUdHLB/9RibZS+nqKQTcIjnqa/SzRV8HrvNB+EimnnUas77d6WfZo7F3QLpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240047; c=relaxed/simple;
	bh=UvvtbPeI4QX44f+VFNfx44tYuKgULCixC8xcnzsyEAI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EejOt1l3gjCq532/ugqHq5zqd3FWb/XbWlWt5ziuAwShtbV/0AaivRVLu0EPC9Zym10SBFvBFkEczUASj0hPhZAuA6Q/PnfV6WU006eDJYTdilBjyRPMb5aQeNcTlF+QfaBZY1w6RFXSCZScaB2nHhGSN3qhuGsptNoclNEuLvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZwwKJzpG; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnpFZ7e/C3qcdHveiEDzlOP0HHV4ZVMs3dBQG3cqLNa7K6GVaWiWKw2ejKbKZkr9nX13K6jxpvxP/s4QsIEEWHkhTAunShlsgQ/m31rrQdf1DmmQT2xF+Mbx5qiLKt7cvJY0v4GtZPYnO7Jv0VfPwWT6kMu1nw3Rn0/8+VeXPGEPNErD3U7Bgk6iO/d/T19VTIs3um1angHzUF0/pNPcJCi9JlCnxIFgu1r4F+ODm7uRNlq6GMcF6bBTNy0+61bEtqDdk3jYXXM75tXqWYaKayRxmAWO6T8tyqekknCEXSVdUuGprPo6234KM4X1MqHSxwEX+ff9ctRzx/9P8ZJncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGR0a7QoIDLQXftmz/h92JF2OeoRfFiIzzu7pSWhTW4=;
 b=ghUupwSGBGNlIIrv9PTNCTPvDPm6XGCd5bm2jJPWC4eTyVxzI828lTXhYYkh/Yct2R3frNCbgRz/A8KzqdHQ+RlDvC5LjKpPV3yRyBFz0f9XRb56X8yBUBMnyPJpjM1r8fqgtgqLGGBxtf/8DWVi6TJmNjRUzyrGr8oP4a4VK39dlB4R/KhQDNsfK4J/J5T1Iw+E1joTtru3v7QKZp94GWYpumFe20FJD0NTNgWH15EY7wlf6TG6+0+VK77RHZJaQFN1e2lXrwoiTEV73C99u2QB7fIyoXxQMT/9REDn9jkkxJTBnMM2uoeAIKMoBBTi868EDCDtfi46X+DoKgIIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGR0a7QoIDLQXftmz/h92JF2OeoRfFiIzzu7pSWhTW4=;
 b=ZwwKJzpGFEPSaeR3/pwxZqwilhvHtU1eZbqdmvOo4zKj6N/F3AsbyHZXtN1CZTqB4lrkA7aFfwv74EpWsO1a2yPKzecpR1F6NS8NK/EsudZhzyTcSvfbs9ASx5h8UHBSySo3F9Atd78TXxgbChjpvoB+YwJTiRXHGEkUzpDDma8=
Received: from BN9PR03CA0200.namprd03.prod.outlook.com (2603:10b6:408:f9::25)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 05:47:22 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::2e) by BN9PR03CA0200.outlook.office365.com
 (2603:10b6:408:f9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 05:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 05:47:21 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 23:47:11 -0600
From: Bharata B Rao <bharata@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Jonathan.Cameron@huawei.com>, <Michael.Day@amd.com>,
	<akpm@linux-foundation.org>, <dave.hansen@intel.com>, <david@redhat.com>,
	<feng.tang@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<honggyu.kim@sk.com>, <hughd@google.com>, <jhubbard@nvidia.com>,
	<k.shutemov@gmail.com>, <kbusch@meta.com>, <kmanaouil.dev@gmail.com>,
	<leesuyeon0506@gmail.com>, <leillc@google.com>, <liam.howlett@oracle.com>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <nadav.amit@gmail.com>,
	<nphamcs@gmail.com>, <peterz@infradead.org>, <raghavendra.kt@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>, <vbabka@suse.cz>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <yuanchu@google.com>,
	<hyeonggon.yoo@sk.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH 1/4] mm: migrate: Allow misplaced migration without VMA too
Date: Thu, 6 Mar 2025 11:15:29 +0530
Message-ID: <20250306054532.221138-2-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306054532.221138-1-bharata@amd.com>
References: <20250306054532.221138-1-bharata@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: e2328a66-23f5-4a61-eae7-08dd5c725d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8YuyvYw0Z3TdW2Ft/s9MUEh/B4+SngIkYRVmsvwsbwzhBmZNfJo18ydm5coi?=
 =?us-ascii?Q?dD62KuDyTG4kDLDrxsg8w/n5D2FDAkKM6oyPe+jjvM1EzU8vhFAVf7pu5WY/?=
 =?us-ascii?Q?KHx6HlpQvdT68xkkm4wCLPYgQVuHDbJoArTQkgGGbjw+4YndBm6mkz7EKWES?=
 =?us-ascii?Q?PPJ6WCGlugbiiSwthgQLMyEokIddhTcQoz+V2niv4pASEjq8arv3C5CvAOg3?=
 =?us-ascii?Q?ljewwQRgT7028OLHvLLgl4QOA6N0dnpfPtdWKSgnkpyVVjUZO7wtjxu570pO?=
 =?us-ascii?Q?4pfhUHd7CpvPi9E7GyuAmfJENGlefpAZ+j4Ze2B13QD4wrS/Zhuugp1JjsGB?=
 =?us-ascii?Q?ubLbobsVSjf+rUZ59t/WeewxK/PZk3xLwBxjX+Q5+CXHBeLbMcYBs+zDwnMz?=
 =?us-ascii?Q?MMkhyNNkPF61cdKXPE00aTHJ0A6L+0hfu/LMuzQgWWrJfmDyMa5P2Ni9GZUw?=
 =?us-ascii?Q?iXU5z2NRFxqZXv/4XE9omEA76aDdAysuiahWDMQKmc7b7xVn1sO/3AbDpnUi?=
 =?us-ascii?Q?ILBLPLpLLU1AIhuo0fsaEl9TKrsSBytJ79yBDKPTh/h2a5e0mkICNTFKZ/+Y?=
 =?us-ascii?Q?ARhisFUKBawDT7yRVRpCYmD3UCiY07LeDK6xl9k2dUnrHfmm083UMpYTe47k?=
 =?us-ascii?Q?zHS6K9+0rFecYOAnjnAikhpkCtM/2PXSdd3GDUFjXgDaELnTG3RrAQSQEs0h?=
 =?us-ascii?Q?lSWcIvuLRCwiIwczD5ANkZ9C3M2FkapttymFP6l2Gr/UfLsW4Od+3pZ1r+yG?=
 =?us-ascii?Q?ksleeD4Mbu9PIuanaeeAvOeyNeMzgXBmC7viYv0yTVMaic1OwDfCLAlwZ3TM?=
 =?us-ascii?Q?c90YQQP4NzgW2XHgme7kykIwgerH7TsTsGjHxCtkJSGp/+CiYu8ztRAY94qk?=
 =?us-ascii?Q?iS6vvzjrFshAAgGJtsy843FZZFdIHfUDS93hwfoItrghm0PL1o7cyQHsdlca?=
 =?us-ascii?Q?ZtwbZcBRhg9rN6X6/xAjZSrJwMv9r4sHYP9YWGkBYY8/UzueeYNwcurtd1n+?=
 =?us-ascii?Q?muySkSjC8/QeYbsxa1CWuzV3vteycuTO7QrY/GULRqpYFOlvtOmGtT8iOzVD?=
 =?us-ascii?Q?xm02MKaGT+tNcYzYSK2wNKm8neeevxtYC/0/IhOei6kn6CvfgDjJE5v48Z2g?=
 =?us-ascii?Q?i3Uqv+RbSWxTY8VSgFRe14iT9TazT0zo4UO7x+j22IM89ThzXk6pRkO2CXip?=
 =?us-ascii?Q?Ja70RINgUejiv3+DwtKN6TuSuQkbHcCBXiN6OZWhkMgsxXktwoVoEVS6lwI/?=
 =?us-ascii?Q?mqNVQA4u0mRryY9+WnAb68fZGsLCynZdPPN12PSCEvizRfk0EjAgIR9Jbuh4?=
 =?us-ascii?Q?Yggr7o7nXH1Ab+U/1Vpbfxomf9O1dzL/xVfL0zOK7VYKHQH9Au1/fNqSxbUD?=
 =?us-ascii?Q?VE+ExY3wXegRN2QYXYuj08X0uJeB7o2hc84hMY0IeB2isV8hrRjg8sMAQD2p?=
 =?us-ascii?Q?KcX4z+fwQoNq0jp2c/CWTKxUkKHjL/bkFbJK7F094WPjtHWQBWm4qsXlDCxL?=
 =?us-ascii?Q?XWaqzce1sNdWcqU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 05:47:21.9259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2328a66-23f5-4a61-eae7-08dd5c725d69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154

migrate_misplaced_folio_prepare() can be called from a
context where VMA isn't available. Allow the migration
to work from such contexts too.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 mm/migrate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index fb19a18892c8..5b21856a0dd0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2639,7 +2639,8 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 
 /*
  * Prepare for calling migrate_misplaced_folio() by isolating the folio if
- * permitted. Must be called with the PTL still held.
+ * permitted. Must be called with the PTL still held if called with a non-NULL
+ * vma.
  */
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node)
@@ -2656,7 +2657,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 		 * See folio_likely_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) &&
+		if (vma && (vma->vm_flags & VM_EXEC) &&
 		    folio_likely_mapped_shared(folio))
 			return -EACCES;
 
-- 
2.34.1


