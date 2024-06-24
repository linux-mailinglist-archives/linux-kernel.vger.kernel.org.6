Return-Path: <linux-kernel+bounces-227374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 395C2915023
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47811F23267
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC20119CD12;
	Mon, 24 Jun 2024 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Slma8VY3"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667D19ADB5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239897; cv=fail; b=rzJ3CfNczqkp9sGoCVR4zS2K+1CbNdJvuyt6zRw4HqYnwAaasQUDNQnvjjH7g2QYt8jvHqZYUpxWNwjBnv6bcATAVW19pDoaqsaM191yu97fbyg1X2lBw57f4VoODDxFkhpvsQqOJ/SQnkzcT1zMTNQtY5v+hj3a7FiBsMfTxsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239897; c=relaxed/simple;
	bh=9MMqmyKjc+lX2mevROtL7OvvD+/w1N4NVemVhsg3J1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEtJHqDXYEBNZPhVV7kbV1C5yg6g5kzbC4+P/E2nUjFLJ8mQWaJnyrTWbXDCeam2cbYkfYXe4NkuVWTYidtPJcKWc3FzAx33OKV7i6aleh7LGoq90A99AIlKloNSTu4moCfNNMah0ezIonFXRXYITS1+RvRdPn3PyTpQ5hSHoOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Slma8VY3; arc=fail smtp.client-ip=40.107.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu7fbAhtcu2wH5wKgSltSy4bM40in89JG5uQBtl3iMODce1lULlmCV+ZrE6o8shzhRiB2RL6i/uEMDzG3ifPUtUSKwGIbXC/j4Af+Q/mZ4vMSP6sWEfmticeE64XY0Jo6N4hjvl0k1ZGpUA/omym368nPKYw68j461nTWOF7MZhXIcNW9mawhziDpY6/qGKz/JknzJNCUAV5dAxfnXYmD3yraAP8BwXXSInFCMNwPWqzp3p2Lf52CKFMivXPPql2glN/3Scqk+DvxPH3FVV5puIATCsAQGRItKrpVGPhFzycDEnbEDQf2QaP5TDPL7963HAgh7sHPsI39hOsxug+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O8YmUEGHg8FRli4ASVLvNhSwFw0+bIZledzUrbGj+E=;
 b=U4E+hF4PkLU3w2Me/333tIFhryrEGegofFILoxMdR8wJ/GNdrvRQ7jS0zOZvb/RmJqOY4VJ2qPCZPxCLNsWPpjqHkfUnSgSmZvE6QPmraJRw+CBWBDM34pR+J3staGeFbIB5Q+swdyKaFDVFQTiXB/X060WliXYA6GJI5Oe0i5jUe9kudtlQMyw0WHpPAdqO3dWL/UPPYYkGmDOfzEGeY5bjAeYiLCC5hRTnnsn7aqneP3w/WT5NCrn0Y8qTNS2axB3DswN13U/QuHC/gXt7MAPs7cJxsfnwmR297txR8e0XCE1IBwITwFDZT4WQmq7xCDYB4DjV0XliK38s+fUtog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O8YmUEGHg8FRli4ASVLvNhSwFw0+bIZledzUrbGj+E=;
 b=Slma8VY3kTQjnTCTvYIgSRLF2B/JkB7bfbeDUhXVlfoQOMBAMcXxBLdAWAmQUYJ8HDyEOefIgNgcgZ0fwIf5Cv6qkq7Lp1/enJujpGPfp+aHDqVlOpztnP5RjpxqCnjML1G4hrHGJ2xIm1t6nh94QU7XLNOv4avzJThqto0XRVo=
Received: from MN2PR16CA0043.namprd16.prod.outlook.com (2603:10b6:208:234::12)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 14:38:09 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:234:cafe::1f) by MN2PR16CA0043.outlook.office365.com
 (2603:10b6:208:234::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 14:38:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 14:38:09 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:38:08 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 6/7] x86/sev: Treat the contiguous RMP table as a single RMP segment
Date: Mon, 24 Jun 2024 09:37:10 -0500
Message-ID: <77fff24fec6053a8c5c97f6ff491210029b9edf0.1719239831.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1719239831.git.thomas.lendacky@amd.com>
References: <cover.1719239831.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: c724128c-6393-471c-22e0-08dc945b4480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?anopSB6nyhVbZ0NJRmJOjtBNEf6xdvqXnpWTVJ5NF5qLFNWXn1Vgb8dZhG8T?=
 =?us-ascii?Q?RraWCRZZYZ1rZwPbOyecpyWV7cCGIw//JC/1ZTQFRJ3ajFjKqUc8hSpgRyNG?=
 =?us-ascii?Q?lWgoovRg24+JpqX72TthGhfa1M+b/XM1CK8B8V3DDo2eITCrE1sHApOCvVAr?=
 =?us-ascii?Q?6Pv+E16XEADDpWzb27WnsJrmGVfdVum2CWYrwPdp1DTvBjH7jsvv69TNB/MH?=
 =?us-ascii?Q?k4PD1/cbMfDac2VjFUYtlMYjVYJ9B2qjicgNRmEG6QOUZGEx1vp4h/8IJQO2?=
 =?us-ascii?Q?j5C7RpyCFjx6Mth40JpWOiE50ieFjJoAzI1AkL8A7cDc6u5FuF4Pp84Y2j4V?=
 =?us-ascii?Q?JWYxRTK3gzjkkF+EqOPOw6U5lJFfQkWLfmOt6dU88hF08uog/gIS6pQVvRYJ?=
 =?us-ascii?Q?h4huUSMLv3P3Q8q91W6Sk7u2/XXbTXnM6cyr25aMqvZgsJVMO+qVgg9ptrC5?=
 =?us-ascii?Q?WbQDL2C2u1YoFRT2XyVej4D/0KMavTHwHIdb5a3kP7wSTRTplIc17Hsi1B6o?=
 =?us-ascii?Q?hHXetgHzdBbTZYJqQIctUrFjra+103FpwxTBjxSXqBiRvYPA9Wc2G6LyiFfy?=
 =?us-ascii?Q?z4+jLGJXYvH2M+5GCRDI8g0ELbFK/id8MmNu+z1sPMfKgldj2/WDoSOsKYr+?=
 =?us-ascii?Q?OAZYMOY7MR4GxEil9UFPOZNW8Mx5Qm32882Hv5sioi1nT8wCxxCyMb4btp5J?=
 =?us-ascii?Q?dLgtntBKQzxcVUqul2Cn4yLF7P8j2KkvBg42xeMSSd6IzWpK/O17cL+lKDos?=
 =?us-ascii?Q?f3hBKlUPM4KwkP4SiLLkVfiE+f1ILWC7mGf9z3fEOH7PXHoXaQTo5Me/cHna?=
 =?us-ascii?Q?c4vzMwcStJebvuAnbp2r9+eysYICBGVgvryPHq4lyu1/V0fjrnzBZHPo+V6o?=
 =?us-ascii?Q?0BjlAICz2084PoP/SqDP/4ojJ+h2musZOutt9L19YQTdbsniooNeNrn6PNxj?=
 =?us-ascii?Q?W7reBojY9auyMKWjJ5uzw72O4zIdCaxxVIpNcLhI5bI/Dfup+IYzG8p4A5Op?=
 =?us-ascii?Q?NFzdmqQYQE+N6GzWo9UvnMGifF/Xe24Hu61fQj+zfTe2jq1+ezTvKaXJw2w/?=
 =?us-ascii?Q?OlytcKBBHmRLhWvLYCYvBGesWv/3yDo0LMqju6zIWk7KnORbca9sc4GtoONO?=
 =?us-ascii?Q?+cdQka+eblYjHamNG5IXD5rTsQqUe65U/0Z5Ud4lEbvZgCLaOj/BYQoCdSWi?=
 =?us-ascii?Q?SxAVcQUgR7T60IG99rYAP8wsDB0F8UhIFj84j84jBoVpzG5zcVWiCaIW7TY0?=
 =?us-ascii?Q?hWjqm4wgSsS5l/VPeYa+c/LgOWXk8abGhuAOqKMPBSOKVxi80Iql47XDqp9N?=
 =?us-ascii?Q?uJi6q3BAYe9TnaDTlSyYPKmJEF1KPPZcaSbibOc3/t1rfQpxbKwr+gNrkW1D?=
 =?us-ascii?Q?n7VPCaqJLOCs/WN+6icw2AVjZzaxqOBIcvHfmM+p5gPqhcEBGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:38:09.0388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c724128c-6393-471c-22e0-08dc945b4480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663

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


