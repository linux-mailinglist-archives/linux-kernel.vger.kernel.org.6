Return-Path: <linux-kernel+bounces-344337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF61E98A874
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6B0B252C1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C345F196C86;
	Mon, 30 Sep 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d/4s1HZ7"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459281922FA
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710081; cv=fail; b=oNqR4X7DzclJQhuHoPWj1M3yHS+4H+svSZF8uDArWzKv0nPaTjvHpeJfab7X7PXu3DeDdoxN5npsZaW2GVw3BWTe487cxQgvTPL/SDplOixuLcInFowcGayCLsysKGT2JsLcGZWl0Z/wB8R2aaTEe9D1gsCVLwh9+/187vJHIBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710081; c=relaxed/simple;
	bh=verHtiZf/iVNzl7U9hmkm2hjXL7PjOqURfJYRwP7070=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUHXzGLqzVKzkLoZolY1t02ZsLpVrp2HHas6sDqx/fEoyZu6CQpv9KmIjP4vFNjzqGriNA5p4wqTxaaGTPsSpRXQj07HfnYjaez22xdo6raYM+Ee1hUuo3aR2jcy0JaOlYq1RoRDujokNANDY3Ds1Vqkem8WcLa7JQMOx2/B64g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d/4s1HZ7; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4ndVFhU4JMDATD2E7YjY93xe5W8KiDU1fa8gRmY1sdy4aiH8BN3/NRlywqJx872UfoTdY3jrr5FAaK7P1eSP8hRQsCB7SyTWOY46P7QioKGo0eZF561GCSEWCUxBYvSrsXjvyEk6laMuhJVhvHFmRxmWVPlzf7Z32mRBK3bzdg9G+uyQ1kqFdOHtGO9hyIBtSM/AwZ1nUqpXyLAMa41ym8cWvpX6DDdgR+kDAfBcUzlMmAhEd/shFh+ab9k02lrgevTobZxqt964ybnB6ixojUXz+UWfjVr5eyalWh1UDVVG91C8W9v/oRZsVvNEpdYUFiORSeMe38BbdftNns+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTpESBTdoperuSFMsX12OBru3MYfjl7IITR/8JLUiiQ=;
 b=pOEeJ87r0t7BEf6jpNRQwTbctMv8N65xzOtBpduXxWgX5Qso1RQABLpVt+H3EdkmO4NInFHyZBY9fyoEKnGHt3awCoU5AJ/+t6NL4MtGtgIrp2sEI+ubvGVFPYVS+JkOUeRDsgoNJPIYZ5GDkDiX8WTD9Mw/biPr8JpF2Gzej0SfUI2/LuFVnBTOkC4js6W7illKlJUoF5Ff2pcMCXTH+ehChL5zZld6/Sz4Ay4w1AEF2UrtsC+W+xLYztvE5ovU51rD2w7dZSoOcrq7GFnOZatXXYLTho75zq9yGgzweF26pCUfCmwt2sRhDYc/nHiiV6oNmBXm1scDdvISrhSmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTpESBTdoperuSFMsX12OBru3MYfjl7IITR/8JLUiiQ=;
 b=d/4s1HZ78mqG00fSPhBCniZBEwtYegvvvPUFccPAfoYNyNTj6sYEv7Lg37MsEz2hCB17ngK/VC9pvPn63UT900LWMXJhruT3Da6XF2epP5+unyWvnYpVG6YjRkfL6YSJQgPEQJlHr6WaDJKxRT7LWIjWe5Sj8PqLR09vyDOcevc=
Received: from PH7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::35)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:27:56 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::1d) by PH7P220CA0001.outlook.office365.com
 (2603:10b6:510:326::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 15:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 15:27:56 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 10:23:13 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 1/8] x86/sev: Prepare for using the RMPREAD instruction to access the RMP
Date: Mon, 30 Sep 2024 10:22:09 -0500
Message-ID: <4d62cc503d1e3278c3830f24462e3956233760ac.1727709735.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 3665dbd7-ae68-42e4-ee28-08dce1647572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sa8KsZVG2uCj/EFn3ZxxpOOEaMjBDp0Pqyz3idgeh/R2YNYNUVASmpCb/xtk?=
 =?us-ascii?Q?SoupkSLAzGt1bcpajoZJfDrQvylX1LUcIkMngd0S8KXfhIpUO/HbvzYdHLVa?=
 =?us-ascii?Q?v0CUJ3lPNQFLkAlvszUx99l0CCHuiNTwwM8jDciJfwZvpYQjiJGR5hIpsuE7?=
 =?us-ascii?Q?nMCyqZ+qwvwd05TG9yjJmDLV0xl0jEKX7bH87fS6S2oqRxAFnKk7jhr4RLA7?=
 =?us-ascii?Q?5tsjhT/M0TnP3wkQ+DQG+2xEyBNLfJFtFt3XRfD9myazfIYASwLapvjMF7+7?=
 =?us-ascii?Q?CoAljXjsM9PDUFjywnXtfSnlXUiEdWggdXz5I+yjAJVmY8NZ7eJcwbuo2sKY?=
 =?us-ascii?Q?F2i2fuwyOfsl/vRXTuwDHGqTRLaQUQMzB4uaR1S6G1eOGrtPOn/1AHYHhaKH?=
 =?us-ascii?Q?fRwSxZg2OLkrOXaVByBQSojuW8qjt0xii0jFV/HM4D4cweUB6ykwRb1fEmWs?=
 =?us-ascii?Q?y7kIogxhDL4pYStaAk2f5T3fHJETr537vKEawDTTDuZQzxBUTMLVYRDRycae?=
 =?us-ascii?Q?yqRsZ0kRqL+xoRQUoCIfH1p3XiElQZJVDMddKp2MTVZ8EuNG9sIlRPUqU3/c?=
 =?us-ascii?Q?qAz5Z7Dxa3XnMcebJxJQESdkTAZeB6bB70URQeH3ygqFOCl13ouX5/N5oMqT?=
 =?us-ascii?Q?WvO+bvvaxP1v6Hpx83tABc9bMU69OqOXwTEEYg4+OryMuz7LTfmRr4OKg1gZ?=
 =?us-ascii?Q?KZjuAvDkfMAmrXzZSN19L8B344osPTNKFSGKmarsQxROVVJdCSRqc8a5a8ZU?=
 =?us-ascii?Q?DckEF0lw0yQKf8/rrtXZ7Jj05B4cVkeR07hncrQAY3rRBrhVN04CmamG//+P?=
 =?us-ascii?Q?hmPxezgkxHJNhDQ5MmmJy4Sah+BEt1pBu7yOZBTKr1Q63fCosTKDFTibCmJ9?=
 =?us-ascii?Q?7wxfnFhZ+JrzO8l2G4SQBK25yYCtZsRgOG8vGbA3vkA3DdmcSCA3FQnoA3Sb?=
 =?us-ascii?Q?HYfpx7nX2YmwECpAJCEhVCo8XNpC/iwgpllXezWkFN5colQwlVRGLZNGv8vS?=
 =?us-ascii?Q?z9h8/KE00tN7b1URY72o/tArfTG7Ttn42zsPraaBSNyaAKNCURwuL+qMLHic?=
 =?us-ascii?Q?KH/hliHtnPePFiEysT2jc9KWk7xREt4ZYDup7pJcVO2+rD8HQXuMd2RqGeOp?=
 =?us-ascii?Q?yIi9opG/h9YEBaIwX6d4oTXNyguCdNNdxd6ZEkF4+ifyXkLwMA8S0IJrb/Uk?=
 =?us-ascii?Q?halsOr1MUM01LD62b8fC7dFa02HxsFjL6ym+506/7P7KJx3ZEDAM2mCyeZ5G?=
 =?us-ascii?Q?oRFf5jbyrvlCqQKXBlOqYwjFfcRkqNqQhVQgG/pc9xUL0/KW69YPjVTDyOb8?=
 =?us-ascii?Q?Uz7auVNiPgMJ3Cm4b6E1b71LFceBnRaGZ9Psrk3UiOK7zdxQsVnSQ/RpMky0?=
 =?us-ascii?Q?frPqa+PMpynEGEqOcUpeiWAfm3BQkxL1RIM28wX6j+2TlnubgykgCd5MY9a+?=
 =?us-ascii?Q?y6jltPhQbj6KCYofLTRUenxwYSE+fAZR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:27:56.1338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3665dbd7-ae68-42e4-ee28-08dce1647572
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

The RMPREAD instruction returns an architecture defined format of an
RMP entry. This is the preferred method for examining RMP entries.

In preparation for using the RMPREAD instruction, convert the existing
code that directly accesses the RMP to map the raw RMP information into
the architecture defined format.

RMPREAD output returns a status bit for the 2MB region status. If the
input page address is 2MB aligned and any other pages within the 2MB
region are assigned, then 2MB region status will be set to 1. Otherwise,
the 2MB region status will be set to 0. For systems that do not support
RMPREAD, calculating this value would require looping over all of the RMP
table entries within that range until one is found with the assigned bit
set. Since this bit is not defined in the current format, and so not used
today, do not incur the overhead associated with calculating it.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/virt/svm/sev.c | 141 ++++++++++++++++++++++++++++------------
 1 file changed, 98 insertions(+), 43 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0ce17766c0e5..103a2dd6e81d 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -30,11 +30,27 @@
 #include <asm/cmdline.h>
 #include <asm/iommu.h>
 
+/*
+ * The RMP entry format as returned by the RMPREAD instruction.
+ */
+struct rmpentry {
+	u64 gpa;
+	u8  assigned		:1,
+	    rsvd1		:7;
+	u8  pagesize		:1,
+	    hpage_region_status	:1,
+	    rsvd2		:6;
+	u8  immutable		:1,
+	    rsvd3		:7;
+	u8  rsvd4;
+	u32 asid;
+} __packed;
+
 /*
  * The RMP entry format is not architectural. The format is defined in PPR
  * Family 19h Model 01h, Rev B1 processor.
  */
-struct rmpentry {
+struct rmpentry_raw {
 	union {
 		struct {
 			u64 assigned	: 1,
@@ -62,7 +78,7 @@ struct rmpentry {
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
 static u64 probed_rmp_base, probed_rmp_size;
-static struct rmpentry *rmptable __ro_after_init;
+static struct rmpentry_raw *rmptable __ro_after_init;
 static u64 rmptable_max_pfn __ro_after_init;
 
 static LIST_HEAD(snp_leaked_pages_list);
@@ -247,8 +263,8 @@ static int __init snp_rmptable_init(void)
 	rmptable_start += RMPTABLE_CPU_BOOKKEEPING_SZ;
 	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
 
-	rmptable = (struct rmpentry *)rmptable_start;
-	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry) - 1;
+	rmptable = (struct rmpentry_raw *)rmptable_start;
+	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
 
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
 
@@ -270,48 +286,77 @@ static int __init snp_rmptable_init(void)
  */
 device_initcall(snp_rmptable_init);
 
-static struct rmpentry *get_rmpentry(u64 pfn)
+static struct rmpentry_raw *__get_rmpentry(unsigned long pfn)
 {
-	if (WARN_ON_ONCE(pfn > rmptable_max_pfn))
-		return ERR_PTR(-EFAULT);
-
-	return &rmptable[pfn];
-}
-
-static struct rmpentry *__snp_lookup_rmpentry(u64 pfn, int *level)
-{
-	struct rmpentry *large_entry, *entry;
-
-	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+	if (!rmptable)
 		return ERR_PTR(-ENODEV);
 
-	entry = get_rmpentry(pfn);
-	if (IS_ERR(entry))
-		return entry;
+	if (unlikely(pfn > rmptable_max_pfn))
+		return ERR_PTR(-EFAULT);
+
+	return rmptable + pfn;
+}
+
+static int get_rmpentry(u64 pfn, struct rmpentry *entry)
+{
+	struct rmpentry_raw *e;
+
+	e = __get_rmpentry(pfn);
+	if (IS_ERR(e))
+		return PTR_ERR(e);
+
+	/*
+	 * Map the RMP table entry onto the RMPREAD output format.
+	 * The 2MB region status indicator (hpage_region_status field) is not
+	 * calculated, since the overhead could be significant and the field
+	 * is not used.
+	 */
+	memset(entry, 0, sizeof(*entry));
+	entry->gpa       = e->gpa << PAGE_SHIFT;
+	entry->asid      = e->asid;
+	entry->assigned  = e->assigned;
+	entry->pagesize  = e->pagesize;
+	entry->immutable = e->immutable;
+
+	return 0;
+}
+
+static int __snp_lookup_rmpentry(u64 pfn, struct rmpentry *entry, int *level)
+{
+	struct rmpentry large_entry;
+	int ret;
+
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		return -ENODEV;
+
+	ret = get_rmpentry(pfn, entry);
+	if (ret)
+		return ret;
 
 	/*
 	 * Find the authoritative RMP entry for a PFN. This can be either a 4K
 	 * RMP entry or a special large RMP entry that is authoritative for a
 	 * whole 2M area.
 	 */
-	large_entry = get_rmpentry(pfn & PFN_PMD_MASK);
-	if (IS_ERR(large_entry))
-		return large_entry;
+	ret = get_rmpentry(pfn & PFN_PMD_MASK, &large_entry);
+	if (ret)
+		return ret;
 
-	*level = RMP_TO_PG_LEVEL(large_entry->pagesize);
+	*level = RMP_TO_PG_LEVEL(large_entry.pagesize);
 
-	return entry;
+	return 0;
 }
 
 int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level)
 {
-	struct rmpentry *e;
+	struct rmpentry e;
+	int ret;
 
-	e = __snp_lookup_rmpentry(pfn, level);
-	if (IS_ERR(e))
-		return PTR_ERR(e);
+	ret = __snp_lookup_rmpentry(pfn, &e, level);
+	if (ret)
+		return ret;
 
-	*assigned = !!e->assigned;
+	*assigned = !!e.assigned;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
@@ -324,20 +369,28 @@ EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
  */
 static void dump_rmpentry(u64 pfn)
 {
+	struct rmpentry_raw *e_raw;
 	u64 pfn_i, pfn_end;
-	struct rmpentry *e;
-	int level;
+	struct rmpentry e;
+	int level, ret;
 
-	e = __snp_lookup_rmpentry(pfn, &level);
-	if (IS_ERR(e)) {
-		pr_err("Failed to read RMP entry for PFN 0x%llx, error %ld\n",
-		       pfn, PTR_ERR(e));
+	ret = __snp_lookup_rmpentry(pfn, &e, &level);
+	if (ret) {
+		pr_err("Failed to read RMP entry for PFN 0x%llx, error %d\n",
+		       pfn, ret);
 		return;
 	}
 
-	if (e->assigned) {
+	if (e.assigned) {
+		e_raw = __get_rmpentry(pfn);
+		if (IS_ERR(e_raw)) {
+			pr_err("Failed to read RMP contents for PFN 0x%llx, error %ld\n",
+			       pfn, PTR_ERR(e_raw));
+			return;
+		}
+
 		pr_info("PFN 0x%llx, RMP entry: [0x%016llx - 0x%016llx]\n",
-			pfn, e->lo, e->hi);
+			pfn, e_raw->lo, e_raw->hi);
 		return;
 	}
 
@@ -356,16 +409,18 @@ static void dump_rmpentry(u64 pfn)
 		pfn, pfn_i, pfn_end);
 
 	while (pfn_i < pfn_end) {
-		e = __snp_lookup_rmpentry(pfn_i, &level);
-		if (IS_ERR(e)) {
-			pr_err("Error %ld reading RMP entry for PFN 0x%llx\n",
-			       PTR_ERR(e), pfn_i);
+		e_raw = __get_rmpentry(pfn_i);
+		if (IS_ERR(e_raw)) {
+			pr_err("Error %ld reading RMP contents for PFN 0x%llx\n",
+			       PTR_ERR(e_raw), pfn_i);
 			pfn_i++;
 			continue;
 		}
 
-		if (e->lo || e->hi)
-			pr_info("PFN: 0x%llx, [0x%016llx - 0x%016llx]\n", pfn_i, e->lo, e->hi);
+		if (e_raw->lo || e_raw->hi)
+			pr_info("PFN: 0x%llx, [0x%016llx - 0x%016llx]\n",
+				pfn_i, e_raw->lo, e_raw->hi);
+
 		pfn_i++;
 	}
 }
-- 
2.43.2


