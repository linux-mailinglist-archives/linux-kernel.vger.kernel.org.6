Return-Path: <linux-kernel+bounces-385699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F489B3A84
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5251C217DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3821DFE26;
	Mon, 28 Oct 2024 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pQiNb1Lo"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113CE1DF98C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144029; cv=fail; b=b5ssIh1M9NboBLnox1klz/cmE643mc8CUwtML5NyPMKahEdAgH5MvSWLOWQlimow0xmUPX+aPph2g5uE0GCKIRBKz0uGfxRmu8qwyse7We49k1hSr38FR0ZrYOaOWf9uOHA2QiElcCYCvR80IIyBwFH3nsnOT77sX1yXPwMAh7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144029; c=relaxed/simple;
	bh=Hg5NWm91fgZ+CnWccwQJ9FL6Elhw0h433M8kGgs0P/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrkFyjPEto/Pq65LLpMO+rxeudvNDGWI6x1zhUVCITgxCDT+puIa83kUzRa/U6LeZjce9JZrYyIdCHADAW/ztnSkIrVrmhECo0nr6PCYAFqTCuzSE8nxg5sroOOIvK0uvEdhyGR1hR3ygvYzOy/GGFCUJNres0tBeH5N9stUBMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pQiNb1Lo; arc=fail smtp.client-ip=40.107.96.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBwimVIPkFhYnyqlLiBbg6IWnQAD68stxvAz34/sDqISScymAuluaRT09/c15VZ5Ie7Y04+QnNHUMqqPHPNcjqYBxCX/CSkN8YtPD4SRlb5HF4CvffrfhnNlB9ltAPI9A8jGZI76JfK1e2gHnvb8yJS1LouGz/AT4+tPyeZDXgSVHYk5r2YMyhVko5abSPSO8jQmU5lXnWdbN9DAm77mGQaqo6nQZWvZf6NnH5j28PDaKFJweFENlnKl7UySiBJlmo50JBrKSh6eRKq79qshSTXE732GlyzEoW8aoip4cv2/MrEwBrYWeYfhKP//pbcCQCvnKURFpEN8HUaKpwYuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L52R3G3b3WA17yS7StZBLqPSnlBveP8Fd4NBktFTD1s=;
 b=LjbbnHsHuefKScQv+qvNWnPKlwe00NhVM2mPO/wByWthLZNulm9Y/AwUBqS7iaGBEqnhNN8BvyX+6eUryG8QPG3l4U18NLbqFiE/ENU/8RgvUhxstFJtnV9ZEM1+Q9I3t4hfEKxAHxINHN1mCtfNF9LS0V8InxECD613LVq+uplCYwGfTO5HPd6/kv5mebcU6jxDYWbnpk4nMSfCPA00qDcBzVtKFqIFw7EEcEFPvuY9EwQACfECKq/qCldkPcK8tZtpb43zeiTEqIv8RQOtw+o2lHx9usv90ENhmnRd4Pav7xi2QFMyw1TBuIGlAavXWrqmJdsOCp0ui0i9ewcmlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L52R3G3b3WA17yS7StZBLqPSnlBveP8Fd4NBktFTD1s=;
 b=pQiNb1LoGi2YI8oqFk4ZlNBB2sDUWXShPpNhL11bCc0yHt9TQw3ucZl9nGCGr5zp+xxvoL9axMivVdU5SDUTbuoHSuvPsLMvV2VQUFN2oOmfkerg/xunQG1HrJKE6caEWDQRnIg9vYyTxGgVpNkv2cb09TNs8OgYA2NPdXaBGRk=
Received: from MW4PR04CA0365.namprd04.prod.outlook.com (2603:10b6:303:81::10)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Mon, 28 Oct
 2024 19:33:42 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:303:81:cafe::26) by MW4PR04CA0365.outlook.office365.com
 (2603:10b6:303:81::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 19:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 19:33:42 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 14:33:41 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v5 6/8] x86/sev: Treat the contiguous RMP table as a single RMP segment
Date: Mon, 28 Oct 2024 14:32:41 -0500
Message-ID: <6118c46de2b2260b72dd3ed4421e5e08713fd47a.1730143962.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730143962.git.thomas.lendacky@amd.com>
References: <cover.1730143962.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9103c1-b370-4a00-4a20-08dcf7876e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zyEefJCfiSXKRHftcCyuL5ZJD2ebWNzUmVccXNgqhSpaA4C/M+sME8aQI4nH?=
 =?us-ascii?Q?wCKJsfMpmFa6xW/V259+JxaguSc7x0Uw4o/nxQx/7iB/MWF5omQV+Cizw8vw?=
 =?us-ascii?Q?n7dGYL9w4JTrHK8vPu5vSLCLtT1fO1d1VYzabMRIK5eny/26upVmC8bslerP?=
 =?us-ascii?Q?wRjD1qRfN2Zh8YB+UfF31NiMGSgHGD2DT8LttaH6bcrbgzBfuPFl8BpibfS6?=
 =?us-ascii?Q?u1iYUTNuoM7269UTOcTP70wKylJMsOYuixOVxXpNp06R1Hv3xH4e3Ox9uES2?=
 =?us-ascii?Q?wxfjAcvqaFKCNoqA5mC9VHEUxFEvxDVEBVLBb1pfJqi/PtAjBONezjjtEseo?=
 =?us-ascii?Q?eobb+Mgvm663XbT3N0i78ASrTs0kuODkgG+llmz3lUKqI/oT3KJ0eUDyFukd?=
 =?us-ascii?Q?L7QJJiFZXLRjNYZkIs/x0otwEZrDW4n46nDwSV1cPb9saxSFUWVJUo9DfWQv?=
 =?us-ascii?Q?VgJmzJK4fZwmn92ekMcRz6Bac0iQviPv2w4FF7scCJTNAkMkMbpPqkEvyDkE?=
 =?us-ascii?Q?12qzEESe7CswMyLoSEdRpDWAGdm4ohN3v76uqJ3O+XSC2ArlTLFhgzUjSBHr?=
 =?us-ascii?Q?lxVeqUCVjwY7cOkS8Tao9KPXuyYKDSs1xULB6MvvcbjRI2X3R45eU9hBanxM?=
 =?us-ascii?Q?qCs45A0GpbEarL/aBwWP3j2VZvXPTDymh4Dxa09WvZSgE2l4YSRsboZCr1v/?=
 =?us-ascii?Q?PasEtNxuYWlbQrPbbZLKUdwIjBqaYYevcabSXBQFdRwOhZyLkgTWiwl5GdSD?=
 =?us-ascii?Q?B6vq4nXqgm4AjvDVhw3kegHWHupo82sIE8GWL2cukhgcW5DAsBmFgLMNQZAO?=
 =?us-ascii?Q?Pc78/PKhouOdSpzb9Aa5NXqeYj+MqvktiVHXNnf63bCB9eKetkmHPQ9TpzTh?=
 =?us-ascii?Q?MYPxoH0NNB9sa2P/Pr5uFd2tkBnLwAYbf8IJwjRmCt7e5kxxK9uSTxb3e8eP?=
 =?us-ascii?Q?ZX8NljvG+5DbIugvF6aSOzD2yrPQcRxO2uHbED0jEjpf06RQ671El9lj4Vjp?=
 =?us-ascii?Q?M0k8Om3EbQMh3R+FrU+loB9MEcYC82bsjACl0ftw7U2CU5d3lcZlQvaZKH6a?=
 =?us-ascii?Q?YpbED50LSSkd5DpZdxKerF67JVrQiVD9bZECHPywzHQnX59Fl7qZp5qDPwda?=
 =?us-ascii?Q?nJlywiEIEZXLnBTlCESfBaa3A4/56JYBKoVt9M9rCY53R3d1a9oB+3z7Aian?=
 =?us-ascii?Q?8CHWzcY4h0SQhEQC8ltQ1lhQUNWxNFY9ErcL1dHwev+1Ylu828nEzvvl6/x+?=
 =?us-ascii?Q?YIDfn5UflMO2AXY1h3TSyGDtFRwkcc+BFrDWv3VQK9WyJMGaQc5cZ+29IHqI?=
 =?us-ascii?Q?JMMLqjouotSCiUtUEhKCr9LeLRtAs56oZZzw5Apq+iSSj89oOPCIIy5RkSak?=
 =?us-ascii?Q?uiEls49DIU1gcSjlYyeJEtm7dgrkBpRdz9LYx9wHU4zcMNRnZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:33:42.2281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9103c1-b370-4a00-4a20-08dcf7876e4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421

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
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 arch/x86/virt/svm/sev.c | 193 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 174 insertions(+), 19 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 5871c924c0b2..37ff4f98e8d1 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -18,6 +18,7 @@
 #include <linux/cpumask.h>
 #include <linux/iommu.h>
 #include <linux/amd-iommu.h>
+#include <linux/nospec.h>
 
 #include <asm/sev.h>
 #include <asm/processor.h>
@@ -77,12 +78,42 @@ struct rmpentry_raw {
  */
 #define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
 
+/*
+ * For a non-segmented RMP table, use the maximum physical addressing as the
+ * segment size in order to always arrive at index 0 in the table.
+ */
+#define RMPTABLE_NON_SEGMENTED_SHIFT	52
+
+struct rmp_segment_desc {
+	struct rmpentry_raw *rmp_entry;
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
-static struct rmpentry_raw *rmptable __ro_after_init;
-static u64 rmptable_max_pfn __ro_after_init;
 
 static LIST_HEAD(snp_leaked_pages_list);
 static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
@@ -190,6 +221,92 @@ static bool __init init_rmptable_bookkeeping(void)
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
@@ -197,8 +314,8 @@ static bool __init init_rmptable_bookkeeping(void)
  */
 static int __init snp_rmptable_init(void)
 {
-	u64 max_rmp_pfn, calc_rmp_sz, rmptable_size, rmp_end, val;
-	void *rmptable_start;
+	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, val;
+	unsigned int i;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
@@ -227,17 +344,18 @@ static int __init snp_rmptable_init(void)
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
@@ -248,12 +366,20 @@ static int __init snp_rmptable_init(void)
 
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
@@ -264,9 +390,6 @@ static int __init snp_rmptable_init(void)
 	on_each_cpu(snp_enable, NULL, 1);
 
 skip_enable:
-	rmptable = (struct rmpentry_raw *)rmptable_start;
-	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
-
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
 
 	/*
@@ -287,6 +410,17 @@ static int __init snp_rmptable_init(void)
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
@@ -308,6 +442,11 @@ bool snp_probe_rmptable_info(void)
 
 	rmp_sz = rmp_end - rmp_base + 1;
 
+	/* Treat the contiguous RMP table as a single segment */
+	rst_max_index = 1;
+
+	set_rmp_segment_info(RMPTABLE_NON_SEGMENTED_SHIFT);
+
 	probed_rmp_base = rmp_base;
 	probed_rmp_size = rmp_sz;
 
@@ -319,13 +458,29 @@ bool snp_probe_rmptable_info(void)
 
 static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
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
 
 static int get_rmpentry(u64 pfn, struct rmpentry *e)
-- 
2.46.2


