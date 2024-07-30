Return-Path: <linux-kernel+bounces-268143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C479420CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819481F21E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57A818CC11;
	Tue, 30 Jul 2024 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O7dGlT7A"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141418CC01
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368467; cv=fail; b=QAQmFdKs715KRGLoy+j00Nr7eywgz8FClGnpeEr+kLjdy8wztmDbf7uFwkwXdVAwvDB9ZKVlXCfAv5hslojsroHyilNrH50JSqM4PEukxf0T+PbvjrnmRykyT34JwTBliRZsYWRDd4TK7Ht28T2fs6e2d30Ms9JHPdT7rKZLWg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368467; c=relaxed/simple;
	bh=9MMqmyKjc+lX2mevROtL7OvvD+/w1N4NVemVhsg3J1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFqr00Eb5lvPVqUJM3zfAOLr4VMHmNSw18Altc9jwWG5BwM3mqtHn7su5nUYuTXeLT79nBo/zA2Bs+eo2+IK4UHImvzv3iCmC0LJOxN212K25RSFu0kC1ZDERJa0lBvkUK+JSj3zLs8sdzfHlGY0T6y9X+IGJQalG4lcurd/H70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O7dGlT7A; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQK67COISrCr7dZSzcWAyW1x+7mz3CwLb85up2BF31g2dT7f+u4fQsAn1VElYUM2dovK+AYDqTjMajjOBPCw6qtZgEWMqgNL6MT+boRe5BInMIelPJJBAlOMkSOlKzC/I93VU088J4RPjqJSUxc3OREKQIw7+2ZkXtFHxDy38rWOYHg7X67k+HvDsJtwXrZ5mpTaNKD8DS1vbwFqL65RQsTLiHVjOl/kSjpuiGGMKw79IJcB61GH6dxYGCJnHgyLdmBvzC9CIEVZVITDEduxLzx2PihE04Oac6+CgKM+EopJzcO2lGCLx1hF7MatqZjwrEp+oB5efI9oe8JEWD2+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O8YmUEGHg8FRli4ASVLvNhSwFw0+bIZledzUrbGj+E=;
 b=IZEMnPN/0e2GTwt5J07O7fJbKqo+fnrcmPqvuVoSya0hS+64aMlY05WYAejaFf7/VTFimbQxGIgkautxGigaTgN4AEhK6nQSqpTV9MVcCu6n9jakwof9PPFdo7SwROxSKuuAbuRIXBL0NS6Fyjg3zI+L093HAdnl2UayIC3SoT5aRA5LUiRAvRdN5h/nfuuCw2Gdjw5W91GsW3CvRPcGzqvB0SzInha6jFPfl+Q3vOjQ4gUolGzm4itAWJXgp/RMgMJAlTqCwLf8Rf0KR5mRx0yvxAgqQaVrNaHRhc7l1Z76c9y76N5TWNy+Q+q2to4cE/+9f+6hxxzMoV+a0pitEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O8YmUEGHg8FRli4ASVLvNhSwFw0+bIZledzUrbGj+E=;
 b=O7dGlT7AJxevem2VPT+SZJTEUG8HNDI5WSws/Z2IBI4Alc52B4eavczjiFjaVBz/sOZdPJC79JiZ4w+upiaufl75bZrZDP4nNIpi9at1tyAOf12L4ZK5VKvHGv7ho+UU66WRc9vK/hduiZBvKw1NR5t/69jCSC4GTxiq8P7RS5Y=
Received: from PH7PR13CA0011.namprd13.prod.outlook.com (2603:10b6:510:174::26)
 by PH7PR12MB8777.namprd12.prod.outlook.com (2603:10b6:510:26b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 19:41:03 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:174:cafe::19) by PH7PR13CA0011.outlook.office365.com
 (2603:10b6:510:174::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19 via Frontend
 Transport; Tue, 30 Jul 2024 19:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 19:41:02 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 14:41:01 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 6/7] x86/sev: Treat the contiguous RMP table as a single RMP segment
Date: Tue, 30 Jul 2024 14:40:06 -0500
Message-ID: <960311f5cf9badf8ec4be16031b2cd084fb0f3d0.1722368407.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1722368407.git.thomas.lendacky@amd.com>
References: <cover.1722368407.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH7PR12MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: f16d3203-60f6-4cc3-3f5a-08dcb0cf8be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?soo0A1zPhdCBsIqZo7sX0HMvROfTBQdLD2bn8XJEZM5g6/O3Xdg+YyxDfCMl?=
 =?us-ascii?Q?46NBF8Ib1bPR3bEOMX0xh/POQ+VoIIVxcpXLiv0v62JQh+62MsR9GgO24+LP?=
 =?us-ascii?Q?Wvb4hyfG3g+9VxOeEcuWJjO7oXQcb9gojJRTLI91Qp2m06JKITXfE4vwfnM2?=
 =?us-ascii?Q?4zziUO5fGcCO9sj32K1JjayVtBpJ+TlonQIx9xzlaVRY/aadn9L9Em+xgPia?=
 =?us-ascii?Q?lFiZoyvU6/wrCoIOKYygu11IJdD/GgDoC2cjdbk0Vd0dsEwOTOlVozRQjnKV?=
 =?us-ascii?Q?ZjX+nWACDJMyLo7edBDffmKqqNPxt3NmO4TZ+T1p3Jym+HRP+pmWLJtozNL5?=
 =?us-ascii?Q?46hBo8JOI9Mwh3y25uq9uUbA0PxXj+zQl+/5mM6wXEWR2zmPOyaJ/I2VlOAx?=
 =?us-ascii?Q?5orGRy7s94x6AsPpkcN16ASOjTjvTNAmm+Ne/AtoayJxoHb3CQlpxXqEntMr?=
 =?us-ascii?Q?WTvG6oTzyODMbJSmaSwdST2zLyVXuQYsQJBxY/Tn78S2ovSchwoOVKtWKmXB?=
 =?us-ascii?Q?+05lVV+Y6kb5CH0QhGsF3ndSPyYI40YGszXlJ8gQwC+V8qFAeRo6jZIZFNGd?=
 =?us-ascii?Q?NrBfjciYgnlLLLQNGjbQ5sldx5s4zX2wWzN8R9iwRcaiXN7c+CxC12Hzj53U?=
 =?us-ascii?Q?EaC3onI14PjN30gQjHV0Pba8duanuyLcpR/fuUMFkhnnTcKZUDVRksgRuS86?=
 =?us-ascii?Q?E7WXJ/yEmRwFCeuPOCi46bu7JGyu5HNXirDYxU6fW2dw4kKIhznVAoua4bRv?=
 =?us-ascii?Q?VWCtA2naXvyE091icP1eKxu50bHtfqbL0plo7ZExy0hkB7t2nRfMXCnprmai?=
 =?us-ascii?Q?5scIZGcVf0CnKA78wfGJCFdDgddfqMAYwjuLFfAZQEP3fDi7GUM8Ykl11tBU?=
 =?us-ascii?Q?sECkPupn8opK9J9ErVV1VoMzzXUR5CBZm6KtPv4ViJ7bqZefhEm0R8f2gW+S?=
 =?us-ascii?Q?TnwDwbftWzYbr5u3dYxd5xuWfXepttvGvl9lBPkms9lv0Si7ws5YgNHBfzg3?=
 =?us-ascii?Q?hs9UaRI14fMlLYISSwLHN1SqXe1IJdf/RsU3waY+3LqUypG6scVezzf23ChR?=
 =?us-ascii?Q?aZuvgJjwpK0Zhf42L1yXTCCj2vboHKhFGeXxdABebldcBaWq8F8Sg08Qvenk?=
 =?us-ascii?Q?GEb7rdL/TSTSllrDiiB2nqMTi3Wf6HcJ5I2GPvBTAJVXNqSg6tD5bT5o79Xd?=
 =?us-ascii?Q?zqKf6racW2eN9/ZvWGXxS53PYU1YkjRzCQ0XmNT7NGtfofYkADT0f4ogFbm+?=
 =?us-ascii?Q?1AsZmtNNVbsx2Hg6+nPkSDWmAYcbmjJtKBzATGmpECmwayQBoreg7HsfbyGO?=
 =?us-ascii?Q?I4JIHBHSuLTT00nr/hZFpdf/SFryP0bYd7yHMPEd3esKm/MIcql80eCdDxY6?=
 =?us-ascii?Q?U3iF7tFuYPSLmII+j0OEl9TuSXiCknQnfcg5nuCk2vyFo8mYbiypKdSPZrHF?=
 =?us-ascii?Q?/6nB2+HHu0cth6ZUYAa6uR+rGQ/gR1JZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:41:02.9628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f16d3203-60f6-4cc3-3f5a-08dcb0cf8be2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8777

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
 arch/x86/virt/svm/sev.c | 195 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 176 insertions(+), 19 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 81e21d833cf0..ebfb924652f8 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -18,6 +18,7 @@
 #include <linux/cpumask.h>
 #include <linux/iommu.h>
 #include <linux/amd-iommu.h>
+#include <linux/nospec.h>
 
 #include <asm/sev.h>
 #include <asm/processor.h>
@@ -74,12 +75,42 @@ struct rmpentry_raw {
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
+static unsigned long rmp_segment_coverage_size;
+static unsigned long rmp_segment_coverage_mask;
+#define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_coverage_shift)
+#define RMP_ENTRY_INDEX(x)	PHYS_PFN((x) & rmp_segment_coverage_mask)
+
 /* Mask to apply to a PFN to get the first PFN of a 2MB page */
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
 static u64 probed_rmp_base, probed_rmp_size;
-static struct rmpentry_raw *rmptable __ro_after_init;
-static u64 rmptable_max_pfn __ro_after_init;
 
 static LIST_HEAD(snp_leaked_pages_list);
 static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
@@ -185,6 +216,92 @@ static bool __init init_rmptable_bookkeeping(void)
 	return true;
 }
 
+static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64 pa)
+{
+	struct rmp_segment_desc *desc;
+	unsigned long rst_index;
+	void *rmp_segment;
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
+		pr_err("Invalid RMP segment base address (%#llx) for configured segment size (%#lx)\n",
+		       pa, rmp_segment_coverage_size);
+		return false;
+	}
+	rst_index = array_index_nospec(rst_index, rst_max_index);
+
+	if (rmp_segment_table[rst_index]) {
+		pr_err("RMP segment descriptor already exists at index %lu\n", rst_index);
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
-	rmptable = (struct rmpentry_raw *)rmptable_start;
-	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
-
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
 
 	/*
@@ -282,6 +405,17 @@ static int __init snp_rmptable_init(void)
  */
 device_initcall(snp_rmptable_init);
 
+static void set_rmp_segment_info(unsigned int segment_shift)
+{
+	rmp_segment_coverage_shift = segment_shift;
+	rmp_segment_coverage_size  = 1UL << rmp_segment_coverage_shift;
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
 
@@ -314,13 +453,31 @@ bool snp_probe_rmptable_info(void)
 
 static struct rmpentry_raw *__get_rmpentry(unsigned long pfn)
 {
-	if (!rmptable)
+	struct rmp_segment_desc *desc;
+	unsigned long rst_index;
+	unsigned long paddr;
+	u64 segment_index;
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
 
 static int get_rmpentry(u64 pfn, struct rmpentry *entry)
-- 
2.43.2


