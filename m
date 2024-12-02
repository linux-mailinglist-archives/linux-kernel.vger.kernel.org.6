Return-Path: <linux-kernel+bounces-428364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 763489E0D91
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 873C3B3CF81
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A7F1DF27A;
	Mon,  2 Dec 2024 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hxzb/2NJ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41631DEFE6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172717; cv=fail; b=OY5OH9BYL5ODRieygbI4t5IuW5p3k+LQfu26+LV9nHQg1V+dVWUsNrs/aHpPi2PPGQpHvc3WrT6QE2ZIUQ6rkdg5gHeirTIoJqa/Rxew2nmvnIiHbMJ5sJ/d/E4283XXBdFGiwbad1NcT9FFLqp/bu2/JYxWcN1t6lEehGfuX+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172717; c=relaxed/simple;
	bh=sFy40V0xq4Dc4DbXbq3WDZV8uDXzBfKvZUUAoLB2R0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKnNvPnXUVSCCOK0o/q9RvfHtWVqVP+sdzdrJqsYkb72sGweWeQGcKZ0O/ZeGC0eaGIi1MEG9+fV5g4GMHQq6vHqwMHSPhWI2RzpkOAAHlHIwG9/gQhF2oYHZvXDb7IQzyFoyosfY2Z8S6AjJqE6yUfo3gBRxqD1bwRI86rpUGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hxzb/2NJ; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTEEX/zsFmzM8tlrifYrcOkrC4hVF7DjcPZ3E4qFXJ1ZT4NsBRyAlzMDeO/EsgWsFqqrkx5lGrgTAZ4jYT/6cWR+jMDOsYfcL36mtqk9harEmYQCw4fwBGerqyQtX1v5oGH/nHLe6b5ySeYsunMtW5A59K4ib2ESakPtQxkDbzIyP8H1Z0aLuqpYsuzbZye5YETA0vAJRd32fB9fHepbLWfvAhl3nFhLVQfjE8TWugLBxLZ66ojQcMGMg9rNO5mIidr2vUU6HxUcsPF1y1GdIrTe3DSAZjXO/zWluJzQy/srek20ViQm5QiUgOaFKDjL4A76I0ZueIfNaNUA04qV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNj+8Ot0GGzC83vES43VL0kj+x73zmUX3GPb22ieG3U=;
 b=wcVLGRPwIHlpWmSQDzMBuUtMa1HWwclRHZFw2G6OP2Q6tK5GKgOVH0/HecxOWOR8m1mr1gJEdJ899OUxAU/C43iwtsIFBYB/0ecTvv5krZpnS5J1+0BvzwUScmmcEqfLhq/QMi7aG7qhR43+Bxu9wUvrkkNxQc6nsmuUueEzXIcsEAZlrWhLdJgc/kdOx7VZHFk/6viufU4XvJxWrslyetGIZK/rEpeQiMfofRzPGu8sgu3tWi/UyFX7nMUQql+a9z/QHKOg8VexrkpZutfQiWtfWOElffJrwPVCa3FYswh2fRoY15tbDhuob2iOtVDDofhGFiJqtP7fnL1ilMH9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNj+8Ot0GGzC83vES43VL0kj+x73zmUX3GPb22ieG3U=;
 b=hxzb/2NJcxCbq4YITMkWVsYv4m5FPYpmxZYg7+8urpwhW70OQjw9Ycnu+lK5MS0X+wyB9SN8f8RE2x5w1o142x+5zFJM15p2hNyFGEA8k9Scrk+KmT77VIlbbH8Qr+ITHTl7+RF/aE2cAU7ylBziLdft2e+P0jEXsuQT4WcOO/0=
Received: from SA1PR04CA0006.namprd04.prod.outlook.com (2603:10b6:806:2ce::6)
 by MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Mon, 2 Dec
 2024 20:51:49 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::ec) by SA1PR04CA0006.outlook.office365.com
 (2603:10b6:806:2ce::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Mon,
 2 Dec 2024 20:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 20:51:49 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 14:51:48 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v6 6/8] x86/sev: Treat the contiguous RMP table as a single RMP segment
Date: Mon, 2 Dec 2024 14:50:51 -0600
Message-ID: <8c40fbc9c5217f0d79b37cf861eff03ab0330bef.1733172653.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1733172653.git.thomas.lendacky@amd.com>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: dd968c7d-eccd-415e-515c-08dd13132472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?63U/6jD5vdjxSTNdrfX0Ky0hbG8dIvOo/QtoDzVUy0w8iDw2XMxAKn87boYf?=
 =?us-ascii?Q?L0p7aPAwG9IO5Wp+8O4c5JOnWZMtXg6oWfLRhqShx6SeyGCKQFAUtrv680Ha?=
 =?us-ascii?Q?rGGQcLQFUejD4ie55sVAmRkD2gg5WypYUeuBAn9jyRkOxDpReit4r5KCO+dy?=
 =?us-ascii?Q?wv0z+RfZo+3bpvNPpZQCvGGwNomST2JMHkUUl8bs60hzur4kuvxTyHmoItze?=
 =?us-ascii?Q?oIYFRm82meoBkTH7TT7+HwiYAtEAGvhIfZsreJ8Sot4OFPNOYjmMwCublrGK?=
 =?us-ascii?Q?ZVGrcRspFzWHccMBy3/iQ/K5evaU3HUowH2FL5Tkvk6oykS1fhKvBenk3Fol?=
 =?us-ascii?Q?X0dXqfZFWIQHXbneyXmEPPzC38rf0nWTmoYILJTu7qsN1oI+YK6Ysx9K/8sV?=
 =?us-ascii?Q?7uj4OHF1KbQc+xqAx3lGUZJxpH1uLZcOFcFPhnCmkHjPtKqlavd4P1Tx1VjP?=
 =?us-ascii?Q?N13ani+JkC8l2zOnvgr5aYS3XGKrt7CcV2MNUsw2XWrXpEFrF92l/hK1f31t?=
 =?us-ascii?Q?M7nsoBjh5mCdf925Trv3IHyUjlqc/KBj7O5tYSJb/AY2PVf8nPgJUnox0wo4?=
 =?us-ascii?Q?axiitouoaMWijShfLCyzX0geoD2xvTU9DTxKk0bPqEiav2u8p+bLW3ulpPmU?=
 =?us-ascii?Q?zj3fvXqHdBLU/4pBs4WR/cYmEsznHtOqM4GcYG7FqERymCEMewmmNgfzRs80?=
 =?us-ascii?Q?T8SAAq3ihJeT64aKZpAwcTW+YtMlI7uCoDoL0sYDadX0qt0GshgoSKtvejg7?=
 =?us-ascii?Q?zjD10ZcFaxdL32dmUgWjGWMXXoTemyGBxWgtjkhkVqrAQ7fdyeKj9iuE4PWC?=
 =?us-ascii?Q?CMTrfxV32Xsyuv3F6xqnOGuhZMCun3p6ni84YvSbyatXloKQk6t05fGlJIWC?=
 =?us-ascii?Q?dl7CvYILPkoMq98HlyTuqR4KCJteL//kgScmfkaA4VuWzlIWaZFubPZPveiG?=
 =?us-ascii?Q?GZznFJLc5EE070OyZxM5T9YjEei4aoBm7D/y9hqhG1SIoK1jB9MgV+Qxphu/?=
 =?us-ascii?Q?kx4Jn2gfUa3Civ+XsSFZrTEKfDNv2U7BlMux3a9YQDmTOcQBY/2AFUL0m7TX?=
 =?us-ascii?Q?oL3PbGyGPNcYoh7fy+c+LnFWj6W9NiC/2rIyXuAY2adSIT5i6CjCxx2HaYuP?=
 =?us-ascii?Q?Wm+JQboYGgkUyMf7GhTeF2zzsuY/M+SC2PnFDZgJ95zC9ZhLM/DdQqIVY3C4?=
 =?us-ascii?Q?Nl5zBdYiITSWmfH3kpVgLYPnMetmYzOeuc4Ma7OinW3j5EaAgYuETWmuJ5Ve?=
 =?us-ascii?Q?/rHKGI+/wbuTFK5WszPLThwis9klqeXhGUJwCUfe5s5XGFQg7+NTq6VZD/5C?=
 =?us-ascii?Q?fJy1vUMdntM+71qXQRBAtOYuFbPysIvLA3vExdhimRofzy9vlXIBlWsGOZF0?=
 =?us-ascii?Q?4gGnZKcaC94C8Kf1R/fJ2bGWs9rwBH9iCKSqep/ouBgWy62jQpNGUd1TBHiu?=
 =?us-ascii?Q?NWpnorJKEUxADmsujhTFR1oUIei0bzgq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:51:49.1694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd968c7d-eccd-415e-515c-08dd13132472
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237

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
 arch/x86/virt/svm/sev.c | 190 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 171 insertions(+), 19 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 2899c2e28db9..3272a73d3594 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -18,6 +18,7 @@
 #include <linux/cpumask.h>
 #include <linux/iommu.h>
 #include <linux/amd-iommu.h>
+#include <linux/nospec.h>
 
 #include <asm/sev.h>
 #include <asm/processor.h>
@@ -77,12 +78,41 @@ struct rmpentry_raw {
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
+static unsigned int rmp_segment_shift;
+static u64 rmp_segment_size;
+static u64 rmp_segment_mask;
+#define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_shift)
+#define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_mask)))
+
 /* Mask to apply to a PFN to get the first PFN of a 2MB page */
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
 static u64 probed_rmp_base, probed_rmp_size;
-static struct rmpentry_raw *rmptable __ro_after_init;
-static u64 rmptable_max_pfn __ro_after_init;
 
 static LIST_HEAD(snp_leaked_pages_list);
 static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
@@ -190,6 +220,94 @@ static bool __init clear_rmptable_bookkeeping(void)
 	return true;
 }
 
+static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64 pa)
+{
+	u64 rst_index, rmp_segment_size_max;
+	struct rmp_segment_desc *desc;
+	void *rmp_segment;
+
+	/* Calculate the maximum size an RMP can be (16 bytes/page mapped) */
+	rmp_segment_size_max = PHYS_PFN(rmp_segment_size);
+	rmp_segment_size_max <<= 4;
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
+		       pa, rmp_segment_size);
+		return false;
+	}
+
+	if (rmp_segment_table[rst_index]) {
+		pr_err("RMP segment descriptor already exists at index %llu\n", rst_index);
+		return false;
+	}
+
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
@@ -197,8 +315,8 @@ static bool __init clear_rmptable_bookkeeping(void)
  */
 static int __init snp_rmptable_init(void)
 {
-	u64 max_rmp_pfn, calc_rmp_sz, rmptable_size, rmp_end, val;
-	void *rmptable_start;
+	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, val;
+	unsigned int i;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
@@ -227,17 +345,18 @@ static int __init snp_rmptable_init(void)
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
@@ -248,12 +367,20 @@ static int __init snp_rmptable_init(void)
 
 	/* Zero out the RMP bookkeeping area */
 	if (!clear_rmptable_bookkeeping()) {
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
@@ -264,9 +391,6 @@ static int __init snp_rmptable_init(void)
 	on_each_cpu(snp_enable, NULL, 1);
 
 skip_enable:
-	rmptable = (struct rmpentry_raw *)rmptable_start;
-	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
-
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
 
 	/*
@@ -287,6 +411,13 @@ static int __init snp_rmptable_init(void)
  */
 device_initcall(snp_rmptable_init);
 
+static void set_rmp_segment_info(unsigned int segment_shift)
+{
+	rmp_segment_shift = segment_shift;
+	rmp_segment_size  = 1ULL << rmp_segment_shift;
+	rmp_segment_mask  = rmp_segment_size - 1;
+}
+
 #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
 
 bool snp_probe_rmptable_info(void)
@@ -308,6 +439,11 @@ bool snp_probe_rmptable_info(void)
 
 	rmp_sz = rmp_end - rmp_base + 1;
 
+	/* Treat the contiguous RMP table as a single segment */
+	rst_max_index = 1;
+
+	set_rmp_segment_info(RMPTABLE_NON_SEGMENTED_SHIFT);
+
 	probed_rmp_base = rmp_base;
 	probed_rmp_size = rmp_sz;
 
@@ -319,13 +455,29 @@ bool snp_probe_rmptable_info(void)
 
 static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
 {
-	if (!rmptable)
+	u64 paddr, rst_index, segment_index;
+	struct rmp_segment_desc *desc;
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


