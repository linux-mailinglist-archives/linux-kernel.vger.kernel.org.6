Return-Path: <linux-kernel+bounces-378703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEEF9AD433
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE631C22104
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6692F1FCC54;
	Wed, 23 Oct 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OKamSZuX"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC81FAC42
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708984; cv=fail; b=UqA+r9bkdPt7mo2oT7y3zG8WpcMIqv/alwLUjob4HSeJW7AofsnmKK1uFIZKpvbGV+XyZT51oQwgU/T/oxyD0rBhFFZApmrxLvYGLZ7Ix8+2xGsrjSNclAXsKDIknainotSrjeg1wKGOK64Bc9Wof2b86jKH5AiEpS/QJ2xXd0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708984; c=relaxed/simple;
	bh=gEu2lft2EZtbRBZ5VoAthDmw6A0ez9buuxHJYwBQoNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwVM0NEOmzCzTsdY0GMvSAi/kejMw83OQPHbxcaqwCsm0+apSZ+ragD8fsy6SuC1MRV04KNQowSQLMPxYnv0CgDswND98wDGH1mJl1axw1tZOrpHEQVlRCsmHVk8oHc8jdp2SzFKguLvWvciYBvAClnoYkUOw2CDhQUlopcC5jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OKamSZuX; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bs8ZE5CL4LviVtCLCTkgDMqDV9LUcoJYe4qwrW/Brwd5XShEjxfZGrj9NS1GCy0cV0AoFW0MXDnrdTj1m7ZKYtfdXgO9pCuGKOuuRYb5h8csEcKG5d1dXBedBAmXVbXw75Vh+QkuhL+WDRWmYXMApOQOSRWCaRXl2AMaeppK9wM0Qvhkr8HLPATXAwQiC/cqHgmHoBDkk1Jh0IL+dBaQ77BW9d8WZRBUaXhNvX/zosjwMm4YvrdlvwLNSDDVAPtrjklyUQn4ugUQOleYSwNQrD2Gi4W6k8BLABUPiSbqu+F1mCJjb60aZDndz0iXDIm5xFz4hEubqAAx5eoa/g1c3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0Dm2++1qYz6RA/Y9QSkw/DLBN7iGwt3JS7N3VTkTpk=;
 b=Dyruz0c0mBboF6vPD+Pua/FfrCBHX++sIgRTB2DqqHLS8tpRyhBSUxjHgh9msS05kEdzJrN/UcULK7QGIjEvnapcefu4qkfeUfqdGVe7jAONPloksfcwn2tcR+OE1Jz/xBQA9evPJoMB/S8TOD3rhGC2hOx9ezDoeGzFNh3WhkQW7AIGKmDCzniM6ZOC/kzWvoIT1C3uLFwo/xIAmsNlcU7L5iYIAf4dVHZYkHHPtlw1WOZ3zG1pVlsWhJ0C+Q0PyEM6ErN6b0OOOssFnspXMZBuzBQnX3/Q9Beflx7T9eiSkA++1NHC2lx041U5TxwCVvwPe0zmL2WdCV/fZ8D6lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0Dm2++1qYz6RA/Y9QSkw/DLBN7iGwt3JS7N3VTkTpk=;
 b=OKamSZuXzn7BlwmLV2r1VAsU8ng+sMkNqISCLC7X79slO9z0MpNNOefA9wLw4WD3sTTq1MZLmK1mhoeafw6Pb/4PV6KM1CxtK3cKipRdor58K8sCVVez5Fhim5WNySycSOD5NkcEzQsdaSDXG1YKsv9CceS0hVgs2PB0fOIrBtM=
Received: from DM6PR01CA0016.prod.exchangelabs.com (2603:10b6:5:296::21) by
 CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.17; Wed, 23 Oct 2024 18:42:58 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::30) by DM6PR01CA0016.outlook.office365.com
 (2603:10b6:5:296::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 18:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 18:42:57 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 13:42:56 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v4 6/8] x86/sev: Treat the contiguous RMP table as a single RMP segment
Date: Wed, 23 Oct 2024 13:42:00 -0500
Message-ID: <e4ad82d80e8a484f1d0a46ec94b7c9fccf91d13e.1729708922.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729708922.git.thomas.lendacky@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 62fd3202-e7ef-4ec6-c7c5-08dcf3928398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7YX2Ufl2Ml1IsdmlnDwWEY3la8xrw/UR/74AlEXPT4VAVbh79O9UXkfUzYeG?=
 =?us-ascii?Q?0NFUXnpOSh50ZoUyPLqQQvPoTiGTBWDQa+BukAyQSWnPiI8nlBMh3Wl8x3V7?=
 =?us-ascii?Q?yrQ547BRdv/uZqWDcRXeipklL+re/Fa9KQQexjAqz5xS6B5sm2Er33WEME1T?=
 =?us-ascii?Q?PBwPFdRc8uVUdExhxPh9FhgiNlpzBC0hwbN/Qqd+QZsLkjDTLa14Xw2JXGJ0?=
 =?us-ascii?Q?JcPPyg613TINdb3MTaD+xZJjkEY88HNBAqycMddYbgS23vBPgmzgQqvwVrv9?=
 =?us-ascii?Q?BAypA45He8ooYdA1Dh6tJjG/K//AX0zUI/sP4osko+Q29WLMGGduJvpMpGW3?=
 =?us-ascii?Q?7uL+FdX67Li92iZ2p941uc5DCz6TAZ1VXvmXrG1KUXAJwgwMf4dREjF08j9g?=
 =?us-ascii?Q?v9IPzzRKZoEhNpWLUvA4pRfqjfcAIOaIEGTLRNBACqt8hNZ9Y7jxw+aSJvZC?=
 =?us-ascii?Q?JKtNt6w7/sYop6W8K2vvC0xfiyWNxZ5LmibOMPR5L0CXEEPAzfmhvPBw3DG6?=
 =?us-ascii?Q?G8xc/T9Oddsg3PZpCe/TNjCnPwI1vIWdWNOlEg8wesEynxxHsGhpA6fLqekY?=
 =?us-ascii?Q?Zf893W00yMJKksT3xrT/+BkzokDPh3WImgVcOPZXcHhOrlJpQfO31avgcuMc?=
 =?us-ascii?Q?7F0MF/M5W6YOhQdGVdQ2L5eWpCB4pjFVOUCwLTOqLupat+P2ReRuGtVsnuiM?=
 =?us-ascii?Q?+Vtzx9ywseTDnLfj/cuze9A3igEMXTE63/o52Ol3/J8i2EM4NZyBbCmG4XAX?=
 =?us-ascii?Q?YcvpzdV6DYbWK6SnveU5orUgxCb7LVNzpGLF14eVa0tWCqI0mOt5oE+yYEfJ?=
 =?us-ascii?Q?ELrnTDtv8M0qXSdu6vB3rLhrxr/9VLZrp6yS+8Pt1FBOgffLlV06c25WggMq?=
 =?us-ascii?Q?7B8yEuyJ7M3VWgBF1olsoQOYC9flSAc06kngjEpf8DwYmjkoPOe2Nqg5QvJ8?=
 =?us-ascii?Q?u4py40bJkNZij2+YY2yWubg/fUUzLnzNj97jX+8S0mpEuSaITA45Hugd+31z?=
 =?us-ascii?Q?hp9FUQuLi8jcT3egQirtfiPUtuAbTw3KdZ6e0NKBWJ+i03ZFHNAedIA+XaAW?=
 =?us-ascii?Q?cFmGbWK4+7OdHGrY+qsJqiyELkMfHZkfWTn2JoHFJZDJUGqOxy4vYTEgvuQu?=
 =?us-ascii?Q?WL5XoBUznFF906RDVYgy30nh20HZ9krwelWnHvNkL8Z1pM+NtKBI4et1mQ80?=
 =?us-ascii?Q?0heozVwjKhea+Krou5AvVbfXYEQ+MrL8JvNPCC6w2OxBa2wuaBkB8TFSwtiw?=
 =?us-ascii?Q?0Ev8YgFqFGXFk/SZfwQUFw+suz6IZHotzhV3CqTRGmmC2BlQVXaptRMOHGWz?=
 =?us-ascii?Q?vdJPKoDtjriLWcH0OqcXMQVoGRQHCzupiTP90q/nPdcnfL0YOrzu8QHKWIZA?=
 =?us-ascii?Q?HCJWiYnh9uow8bMwo7KZcfBEiR+w4BjeIfm1vj2Na6qJpM3INg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:42:57.6807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fd3202-e7ef-4ec6-c7c5-08dcf3928398
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040

In preparation for support of a segmented RMP table, treat the contiguous
RMP table as a segmented RMP table with a single segment covering all
of memory. By treating a contiguous RMP table as a single segment, much
of the code that initializes and accesses the RMP can be re-used.

Segmented RMP tables can have up to 512 segment entries. Each segment
will have metadata associated with it to identify the segment location,
the segment size, etc. The segment data and the physical address are used
to determine the index of the segment within the table and then the RMP
entry within the segment. For an actual segmented RMP table environment,
much of the segment information will come from a configuration MSR. For
the contiguous RMP, though, much of the information will be statically
defined.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/virt/svm/sev.c | 193 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 174 insertions(+), 19 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index dd256e76e443..043b2582e10e 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -18,6 +18,7 @@
 #include <linux/cpumask.h>
 #include <linux/iommu.h>
 #include <linux/amd-iommu.h>
+#include <linux/nospec.h>
 
 #include <asm/sev.h>
 #include <asm/processor.h>
@@ -74,12 +75,42 @@ struct rmpentry {
  */
 #define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
 
+/*
+ * For a non-segmented RMP table, use the maximum physical addressing as the
+ * segment size in order to always arrive at index 0 in the table.
+ */
+#define RMPTABLE_NON_SEGMENTED_SHIFT	52
+
+struct rmp_segment_desc {
+	struct rmpentry *rmp_entry;
+	u64 max_index;
+	u64 size;
+};
+
+/*
+ * Segmented RMP Table support.
+ *   - The segment size is used for two purposes:
+ *     - Identify the amount of memory covered by an RMP segment
+ *     - Quickly locate an RMP segment table entry for a physical address
+ *
+ *   - The RMP segment table contains pointers to an RMP table that covers
+ *     a specific portion of memory. There can be up to 512 8-byte entries,
+ *     one pages worth.
+ */
+static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
+static unsigned int rst_max_index __ro_after_init = 512;
+
+static u64 rmp_segment_size_max;
+static unsigned int rmp_segment_coverage_shift;
+static u64 rmp_segment_coverage_size;
+static u64 rmp_segment_coverage_mask;
+#define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_coverage_shift)
+#define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_coverage_mask)))
+
 /* Mask to apply to a PFN to get the first PFN of a 2MB page */
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
 static u64 probed_rmp_base, probed_rmp_size;
-static struct rmpentry *rmptable __ro_after_init;
-static u64 rmptable_max_pfn __ro_after_init;
 
 static LIST_HEAD(snp_leaked_pages_list);
 static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
@@ -185,6 +216,92 @@ static bool __init init_rmptable_bookkeeping(void)
 	return true;
 }
 
+static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64 pa)
+{
+	struct rmp_segment_desc *desc;
+	void *rmp_segment;
+	u64 rst_index;
+
+	/* Validate the RMP segment size */
+	if (segment_size > rmp_segment_size_max) {
+		pr_err("Invalid RMP size (%#llx) for configured segment size (%#llx)\n",
+		       segment_size, rmp_segment_size_max);
+		return false;
+	}
+
+	/* Validate the RMP segment table index */
+	rst_index = RST_ENTRY_INDEX(pa);
+	if (rst_index >= rst_max_index) {
+		pr_err("Invalid RMP segment base address (%#llx) for configured segment size (%#llx)\n",
+		       pa, rmp_segment_coverage_size);
+		return false;
+	}
+	rst_index = array_index_nospec(rst_index, rst_max_index);
+
+	if (rmp_segment_table[rst_index]) {
+		pr_err("RMP segment descriptor already exists at index %llu\n", rst_index);
+		return false;
+	}
+
+	/* Map the RMP entries */
+	rmp_segment = memremap(segment_pa, segment_size, MEMREMAP_WB);
+	if (!rmp_segment) {
+		pr_err("Failed to map RMP segment addr 0x%llx size 0x%llx\n",
+		       segment_pa, segment_size);
+		return false;
+	}
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc) {
+		memunmap(rmp_segment);
+		return false;
+	}
+
+	desc->rmp_entry = rmp_segment;
+	desc->max_index = segment_size / sizeof(*desc->rmp_entry);
+	desc->size = segment_size;
+
+	/* Add the segment descriptor to the table */
+	rmp_segment_table[rst_index] = desc;
+
+	return true;
+}
+
+static void __init free_rmp_segment_table(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < rst_max_index; i++) {
+		struct rmp_segment_desc *desc;
+
+		desc = rmp_segment_table[i];
+		if (!desc)
+			continue;
+
+		memunmap(desc->rmp_entry);
+
+		kfree(desc);
+	}
+
+	free_page((unsigned long)rmp_segment_table);
+
+	rmp_segment_table = NULL;
+}
+
+static bool __init alloc_rmp_segment_table(void)
+{
+	struct page *page;
+
+	/* Allocate the table used to index into the RMP segments */
+	page = alloc_page(__GFP_ZERO);
+	if (!page)
+		return false;
+
+	rmp_segment_table = page_address(page);
+
+	return true;
+}
+
 /*
  * Do the necessary preparations which are verified by the firmware as
  * described in the SNP_INIT_EX firmware command description in the SNP
@@ -192,8 +309,8 @@ static bool __init init_rmptable_bookkeeping(void)
  */
 static int __init snp_rmptable_init(void)
 {
-	u64 max_rmp_pfn, calc_rmp_sz, rmptable_size, rmp_end, val;
-	void *rmptable_start;
+	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, val;
+	unsigned int i;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
@@ -222,17 +339,18 @@ static int __init snp_rmptable_init(void)
 		goto nosnp;
 	}
 
+	if (!alloc_rmp_segment_table())
+		goto nosnp;
+
 	/* Map only the RMP entries */
-	rmptable_start = memremap(probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ,
-				  probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ,
-				  MEMREMAP_WB);
-	if (!rmptable_start) {
-		pr_err("Failed to map RMP table\n");
+	rmptable_segment = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
+	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
+
+	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0)) {
+		free_rmp_segment_table();
 		goto nosnp;
 	}
 
-	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
-
 	/*
 	 * Check if SEV-SNP is already enabled, this can happen in case of
 	 * kexec boot.
@@ -243,12 +361,20 @@ static int __init snp_rmptable_init(void)
 
 	/* Zero out the RMP bookkeeping area */
 	if (!init_rmptable_bookkeeping()) {
-		memunmap(rmptable_start);
+		free_rmp_segment_table();
 		goto nosnp;
 	}
 
 	/* Zero out the RMP entries */
-	memset(rmptable_start, 0, rmptable_size);
+	for (i = 0; i < rst_max_index; i++) {
+		struct rmp_segment_desc *desc;
+
+		desc = rmp_segment_table[i];
+		if (!desc)
+			continue;
+
+		memset(desc->rmp_entry, 0, desc->size);
+	}
 
 	/* Flush the caches to ensure that data is written before SNP is enabled. */
 	wbinvd_on_all_cpus();
@@ -259,9 +385,6 @@ static int __init snp_rmptable_init(void)
 	on_each_cpu(snp_enable, NULL, 1);
 
 skip_enable:
-	rmptable = (struct rmpentry *)rmptable_start;
-	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry) - 1;
-
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
 
 	/*
@@ -282,6 +405,17 @@ static int __init snp_rmptable_init(void)
  */
 device_initcall(snp_rmptable_init);
 
+static void set_rmp_segment_info(unsigned int segment_shift)
+{
+	rmp_segment_coverage_shift = segment_shift;
+	rmp_segment_coverage_size  = 1ULL << rmp_segment_coverage_shift;
+	rmp_segment_coverage_mask  = rmp_segment_coverage_size - 1;
+
+	/* Calculate the maximum size an RMP can be (16 bytes/page mapped) */
+	rmp_segment_size_max = PHYS_PFN(rmp_segment_coverage_size);
+	rmp_segment_size_max <<= 4;
+}
+
 #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
 
 bool snp_probe_rmptable_info(void)
@@ -303,6 +437,11 @@ bool snp_probe_rmptable_info(void)
 
 	rmp_sz = rmp_end - rmp_base + 1;
 
+	/* Treat the contiguous RMP table as a single segment */
+	rst_max_index = 1;
+
+	set_rmp_segment_info(RMPTABLE_NON_SEGMENTED_SHIFT);
+
 	probed_rmp_base = rmp_base;
 	probed_rmp_size = rmp_sz;
 
@@ -314,13 +453,29 @@ bool snp_probe_rmptable_info(void)
 
 static struct rmpentry *__get_rmpentry(u64 pfn)
 {
-	if (!rmptable)
+	struct rmp_segment_desc *desc;
+	u64 paddr, rst_index, segment_index;
+
+	if (!rmp_segment_table)
 		return ERR_PTR(-ENODEV);
 
-	if (unlikely(pfn > rmptable_max_pfn))
+	paddr = pfn << PAGE_SHIFT;
+
+	rst_index = RST_ENTRY_INDEX(paddr);
+	if (unlikely(rst_index >= rst_max_index))
+		return ERR_PTR(-EFAULT);
+	rst_index = array_index_nospec(rst_index, rst_max_index);
+
+	desc = rmp_segment_table[rst_index];
+	if (unlikely(!desc))
 		return ERR_PTR(-EFAULT);
 
-	return rmptable + pfn;
+	segment_index = RMP_ENTRY_INDEX(paddr);
+	if (unlikely(segment_index >= desc->max_index))
+		return ERR_PTR(-EFAULT);
+	segment_index = array_index_nospec(segment_index, desc->max_index);
+
+	return desc->rmp_entry + segment_index;
 }
 
 static int get_rmpentry(u64 pfn, struct rmpread *entry)
-- 
2.46.2


