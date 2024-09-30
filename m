Return-Path: <linux-kernel+bounces-344346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0267298A894
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0A82825CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A2719ABDE;
	Mon, 30 Sep 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GwBY+ugc"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7DE19AA7A
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710166; cv=fail; b=qKCSbEqHLcIlJe8Yj97AyRENBF1kl+mjZxCB+WPrT4PKF4aCw9mdkvP4vHEKuVeVx27+3sSrIMtE5EE3FlnsliAGYoh+4HWbvi5hWc0a+TKaSbNLbBV8Wr0dFTbUBZ/reSK3SsjKDqv/Rn2XdetYSoitY68Qhe1ZBfEnOtoHy4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710166; c=relaxed/simple;
	bh=9MMqmyKjc+lX2mevROtL7OvvD+/w1N4NVemVhsg3J1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0jPrL1edxNLxec+AmHyOqsV4Pkqb5V3rLm8pw3lpSLFP99XAvJBKIEUZkcGpgP69X5esN0+z4V/f0Gppiq3E3z0gUMA8VJfA5zYouh2/2apj5gHns7eEYVKioXgUqkzD3aSXTgvJmErVyb8dR8GqJkqzZ/HCswtLX58JsDhu4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GwBY+ugc; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pr0DQ8shD7Tkzk+RsXDTvnPey99bPBoz0uTIMClKToSQGuDnKkDg2ysJbrDjrTY1rP5q3gqm4ZZy2IRDblok4UrhkHd8hC6v3FlxQT85eY08f9XCNJbECSh+0IVUcO1GIOX8jmJBfD3LkDiwk6mgY2Yq8l+nwgbvmQsW2Airfppjp5zneEoBPFHFnT3w8iYaVip4i0ZI5GTaPItw1kz7G8BuZEwpGwiDWlRDloZ0HPXSikAR+8A7OLZbLVBohQtpSsR8U7WBvI9HBrJsTGpOa4n2IFSpvPg60E/ekXAwACuKJTf7i+gClE13lBGl7ahUhGT/V1gdWfPf2oQ0ZslhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O8YmUEGHg8FRli4ASVLvNhSwFw0+bIZledzUrbGj+E=;
 b=D8AZL+0aT9WJpqUqsDhSPbE5jzg9pD4FumaKc/qdAsanbzVVmJzgrmWg45Fd55jVu/XWNKH18+Iz7Jj2+63U7UqgspgGEKlG3cxq9W/s1rT7gTM+22/gp4v+d0+xFWS7A4XlcMJ+PH5jx/eNQd2i+/a9IQ0xLK3vWJi8666jBhWHIf4/V556GcuuY1AxeWgcwDNaaEqmIXEou0+g2W7a6qAWRx7MDtNmouFKbOcjX+jpNKzP1f1Bn7y74Tbhjr8c0sWjVlYlUBuZ5ogSOUkgUn0mOkdvNOuhi8EDEud60k38EVpgEO17BbGgbwV2224cGM0KxzIr73sMuuohTyfrQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O8YmUEGHg8FRli4ASVLvNhSwFw0+bIZledzUrbGj+E=;
 b=GwBY+ugcV652MKm7m+nwM4wGboPjCx+atujcUQA/KbpoASw29Uut2EMcddoeCGqmN7QbIJmCeedFXDSIb7SB4W8JNSzI3cBEiup8T1gnRP5AwWmw7+mGEjKtAtiCkDCQ7BWRdCLvN6vuReQzTeiwEoartbE+dYrWbNoH7QyIjbU=
Received: from PH0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:510:5::18)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:29:14 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::db) by PH0PR07CA0013.outlook.office365.com
 (2603:10b6:510:5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 15:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 15:29:14 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 10:28:58 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 6/8] x86/sev: Treat the contiguous RMP table as a single RMP segment
Date: Mon, 30 Sep 2024 10:22:14 -0500
Message-ID: <3a9a4f94fefe3b4ebb23a7dd3d33d9fd7a344ce1.1727709735.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1727709735.git.thomas.lendacky@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 3517278e-5672-4465-3afd-08dce164a405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qolK1XHBx70vnKtkZ/p0D+VGq38hIEY9gzQ+XXkmuI6lIEAen/HPT5SJ+Va6?=
 =?us-ascii?Q?/Tn6Oa7dC2etcpGLN/JCLhsxFinMe3zE+lF10A2dWG1QiwN0eie0XtFx4Mm9?=
 =?us-ascii?Q?uVZCpMx0TT2dAe4l6Vo10vNUrYduH3JareWNSVoqZpUXYMY7GrCDh9aMcODG?=
 =?us-ascii?Q?lnK/tv6/0sJwIsseCZhC4e77YZDbN3Vv31bd2ZXjjHqbeyT+t7PDkpAyhiEf?=
 =?us-ascii?Q?dLgZX9/39d96+7LV5bxzEsldgIp+cXTvJkgacdwchv9uJe8Xq0kjONgddMqM?=
 =?us-ascii?Q?QIjpQBYJMg/2XZC38uw18luhjzZEg0kMt8J0qCU+uUz8XX/OM/+yBRKL/UML?=
 =?us-ascii?Q?gVcl79uDSMWO9mBoCA1KBNLi7EwPJbSryYi5jfyve0JHTLLwuk8FQC+bT20M?=
 =?us-ascii?Q?o/VkVHCRRmQpeZ7/S2bQdU6Mii9ktJSaZrkePMh3Anp7MM8IGgTrW8+ogfkd?=
 =?us-ascii?Q?os02yGPa7F7ef2AUlPuYCrpJSjDMfwJDKB55zakWL0pm4fpx7g+6JmS8GKxa?=
 =?us-ascii?Q?NaTNYeVCiADCeCy99OLGXwRnx8XsbOBlIjXPBAeQ2zOcF2vbXLth9HnHZUlX?=
 =?us-ascii?Q?3+GvbITrJUPH4sDSngHynS84+4upNCkl15NlQlj7/g/S3VlCQY4rZ0y4g+5M?=
 =?us-ascii?Q?9+93yzbSFbc95g/uQKJ5jA8qaflYrEN0FezPQf3R1W2anO7HzNjpgOW881c5?=
 =?us-ascii?Q?F7IpMdxWeLCfcvhqLE+J2UNXWdXPmMDSWO1RfuKry1N/S9R9bbC/R+bOheN/?=
 =?us-ascii?Q?37bDJj9fG3gz4IWOKkp3K+Dfc+K0Fsq4IlsMBxT5ptVMCcpQMaqphABPVHay?=
 =?us-ascii?Q?O51Wjr8TrpqiPu9oEQQ3jzI+iWnhc8/wyYUGXH6BQVm6MhrTlsv68sIG9J1E?=
 =?us-ascii?Q?dJY8xN9RoKfMGOotutXyB6LEg9GCN/dO/FojsYKomKQ8bZ4jFX2U3dkWUoVL?=
 =?us-ascii?Q?BKKEOvpbp7RYvhwjXn+rBzANQcCjyHleVIqPJTIPUAj3mpEDwRZIHFEbUVEB?=
 =?us-ascii?Q?qLIPeYhaL/XducpV4J8wqLO5RYy4Rl0T6EjUsdi7HiiazaXT4qn2F+Tr2g7F?=
 =?us-ascii?Q?X1FlLk2REHF15sxqa0b3SbbCw9bC8/4qkp8Y+ZVFGk4aP9N7QAGlVXI/tql2?=
 =?us-ascii?Q?OLm8KSAYmuN6Ue1MBQ8gVzhLvx7vNwgooPJWJ/4SdollT1IH3akUMGPVlUah?=
 =?us-ascii?Q?Nh7qtbTdgFQBSNwJx91SrRzBMIIz+COIgM3A3JJFAgmdlaZ1CdotqZVGwurN?=
 =?us-ascii?Q?v0XTHe17A6tPTGz51PHaK/MXtGc+6wsyU3a4wr4WA6+eSq06cCk6GbBUp0po?=
 =?us-ascii?Q?X5W5T8fnbXpwnQ8+twc/eJsNj8Gwcr3e+Wzqe3qwl3M5BslyQRtxgQQ8KTWL?=
 =?us-ascii?Q?zCuNkIGQ2lC39JlIvatXMMp7+AsRk5Z07bhHpLy7l2lRF6NOaIe8apIhSIT/?=
 =?us-ascii?Q?BWOWa7HA5Ykh08hS3zzWdNAOmYDl/hOW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:29:14.2834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3517278e-5672-4465-3afd-08dce164a405
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619

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


