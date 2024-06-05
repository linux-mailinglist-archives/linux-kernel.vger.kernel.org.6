Return-Path: <linux-kernel+bounces-202848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EBB8FD1D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CDD1C22694
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0849B4778E;
	Wed,  5 Jun 2024 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UGhAMKGa"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE483C482
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601934; cv=fail; b=EL6++4alfApmq9TJR5LPg7YarVmIcyihyL/os2Uj4fgGRTz7pLX+2ZKIcKvSZ6IeymLCWqynct/B+12C2787jjiEIz6ef1cFpVWwVM3kVQGie+sRMkn2KZaaFRkAcjP21jFQYyKiR2MBwWyDbkQaqvzRWju389ON77uIMX6Qh+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601934; c=relaxed/simple;
	bh=UnhtXjPb+VrHJoAvEtaCUpIU0rUiEIuyMebwgQ3UtdQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qtnWVMMHF3sxG0i7AjSBP3kxsg+Dv4zGfHtsgE/nG5T7oHUpi5b5abHHho8DHnlBJG6GvjiikbRm0Jf+SRTy24JWJ0V8MbqzIpptbH5RRPQhpi76yOvmiLehOJtLuSO631Sank28RlZBWoHUkY277ZTt4HijUHi6yTWs3kzFsuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UGhAMKGa; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuRkiYAbVz5ht9cr0UTVcJtR8iXcMLCgIPol/xO6Sujesnty41g9e4iSYqQcwW8Hnsybdiox2fvml4njBCZdG6HTCgrRU4gbfIIkjYxfw4yiEjEMxDV5LWzDJIzEnI7rrjUHWcpeuZ2vBLcbiJVeOTrig4oKmQHqIMUpXSa+1RgGuYnYw4WOmDjIWTemqFJtT7kEFjXwb7RCqUm5lT1mk0S7ppYzdOPd+qlcLNQKnj8pscYeusmmDB0EA5xyZZxoVbIR9+qlc0cIabemkION8RJu3C9mWsgt7+QjRDrzc2FuBzZ6AciR+bvBpEEOWCQkqTPJ0A1/RkyycMwTRTHEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFShWHmvJ4JCPt6n3v3rlAARn+kbaQquQxoySaC9a8g=;
 b=cKHAC0vrYKo/3gA4QU/L3mLtKtdFDIXNMqaGNVzcqJrFM3meubFRENvOlVLLvOiR3+ieItIBL5QwVkWdcIkgtBviv1qqmuo5Fq5a5om9wNQIZC/O3YrojvcYhHEuo8rnteC+7Iro3jbc1AyBk93qr+Sdop2Csei4xgLy/GcWOzgyZlOUuJCvRbltuNMOFHCRvqIloslTTLSUYN1LVHAvpT6dO9OR0wMkMe9YZwGoU8TN6IPF8cz9Nlz4CNzARENGFDXt2MuYyTBp7aibyJ12Kb2+OsMnivrhqecvo6aRCz8D5crpe7nGBgQO1ibb6knAwGz5Xu1GzlWxW9V3uKWCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFShWHmvJ4JCPt6n3v3rlAARn+kbaQquQxoySaC9a8g=;
 b=UGhAMKGaCZOW2ldaspYiPuJDogTLyt5RfL8NFQ7UcpeEFX+hCF363c7yoKI6CTmapIWPtg0+6LkvYCw3q+KiaLFM6DziV1kY3WX48n+nxjMnM1deOAqIwSyTwm3VvP8mex9zaEVUFNlW9BwXNG7dxS2e3HHkCra9IQ7JaOH1Bh0=
Received: from BL0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:207:3c::32)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 15:38:46 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::8a) by BL0PR02CA0019.outlook.office365.com
 (2603:10b6:207:3c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Wed, 5 Jun 2024 15:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Wed, 5 Jun 2024 15:38:46 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:38:45 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH] x86/sev: Do RMP memory coverage check after max_pfn has been set
Date: Wed, 5 Jun 2024 10:38:37 -0500
Message-ID: <92b4ba20a5afeb4aecde167bfac094d0275d8e1b.1717601917.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: a3bb6c0d-a215-40a5-3883-08dc857596bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TmEB5muveuPk4K+DUJN+aKBcXb3Orw7WuNX7kWT+JCQm6Sf9MyxWGfuElayT?=
 =?us-ascii?Q?hdbrIQgCcl4wjdIq+heBh5RUMzel7AKKyyOjNbsdSGDgu0tjUylKahFJ+Etx?=
 =?us-ascii?Q?F872lTbRgWXNzPntWsrx3i8M9ybkZu+uxCUZTD+x/uAoU6PAAIJNZfGCjzhY?=
 =?us-ascii?Q?6dz4pbxXmvPwJmucsEDbIWrV0Aisbd3rYaingBPrZWj7GVX4WrllDfT3CJT7?=
 =?us-ascii?Q?z/U8yXsCnB/KIFzjJ+MGOn6+p+HA59HiwWkhVzPkQfMN4x3EjqiG8uODL6pb?=
 =?us-ascii?Q?e9WdG8BWzLgnjdm7gXdfZe8YtNDgWvYYMw2jUaY10gEDgX/TXv55lpS/cAGA?=
 =?us-ascii?Q?01xrnm2tjkJbzxL79ggDYywknPmVgPucYdqgNeSaThvM6l9FdkdZ8Obg2v9g?=
 =?us-ascii?Q?fql51ro15+8IRJZfSZxzMmdLk9MOQw8GcW1FloKHtA1pZqsJMmdC2e5JmRKb?=
 =?us-ascii?Q?JBw3mGCbGt4fC4MjDsWHUkkBbqvh9F4tAx1fabA1WXT4GZO2S9y9r3EUexwN?=
 =?us-ascii?Q?oXc3CWXzsjuyOic6hkmSQbH4wxN/2wiuDj/INItyy2GphpYu8b0fOLqXUbKE?=
 =?us-ascii?Q?MUnQuIr//pvGZ6HZ/Ivh9+hEpuQMhihn8q1vXBp71E7c0VR674eBONK2v3RJ?=
 =?us-ascii?Q?kpZAKDEBbowfuRXSdENqE+9TmrQpJfeubKU8qgTta0lsdX8v2kMDwd/HOoEo?=
 =?us-ascii?Q?KMydIH2iiAAQEi5rKzuQiBv8Qrq+xJNXbfWj2++Ik6uT0waTXjwCvyPPvCbp?=
 =?us-ascii?Q?J5CiB9e7F4nRdzauw2TFYpkWCUqO8OKKjN3qrEuabUsb3P49QR5pi37RRr5g?=
 =?us-ascii?Q?tqZsM+vF6I8N4C/KqAxFkSxl5MsU6F/APYnb7xy2btAITopjfLGj+8YUQq5h?=
 =?us-ascii?Q?sQtFNRClugGBdkgMGWLYkGpq6OOw9A7U3Usfj97BkBlETP94dNrQ/W8p5/Jp?=
 =?us-ascii?Q?fglBLD/CLh++uajAioTn4c76F5VjyGW8RycdIvGsOUF5qFu6JP28y+H6usHR?=
 =?us-ascii?Q?jNW9sDvztKr1lHien82I+WLXVON4fMChHexp2jrtuEjjo138fJtxJpuZ8Mp6?=
 =?us-ascii?Q?uELWSYCAAnuhH41GD17zEOcOR4roPLKB86u2/wrgwXL9HPlPLHZbOpljLvVb?=
 =?us-ascii?Q?rqW0F2rzRRT6xTzcZiClgjtJ3hwMMAbV9I+59G2YjNr9eDDKRb/CBMrlX1Q9?=
 =?us-ascii?Q?MDX9jDffdUQqexWuaoU4/OL3jxr4AgCW6mvhIjG3+h4sIK5ook4sA1Ui/PSS?=
 =?us-ascii?Q?eP4ImgafOf7tX3djFj2JpR/U4DGtSqcQe7xuqzuPm8FMnnRP2zOxOctGVhUn?=
 =?us-ascii?Q?8kM4oosreC/PUPIrzLoTYgCguJe6jPaO2Kuq/h8bQVMB8XL0/xH60fkNolI3?=
 =?us-ascii?Q?k8TKDtOQeeCZpm8dFMaYb0Dtl1CZKtp5QUtcbyXprcrmxVBPsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:38:46.5662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bb6c0d-a215-40a5-3883-08dc857596bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603

The RMP table is probed early in the boot process before max_pfn has been
set, so the logic to check if the RMP covers all of system memory is not
valid.

Move the RMP memory coverage check from snp_probe_rmptable_info() into
snp_rmptable_init(), which is well after max_pfn has been set.

Fixes: 216d106c7ff7 ("x86/sev: Add SEV-SNP host initialization support")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/virt/svm/sev.c | 45 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0ae10535c699..0636fc5279e6 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -61,7 +61,7 @@ struct rmpentry {
 /* Mask to apply to a PFN to get the first PFN of a 2MB page */
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
-static u64 probed_rmp_base, probed_rmp_size;
+static u64 probed_rmp_base, probed_rmp_end, probed_rmp_size;
 static struct rmpentry *rmptable __ro_after_init;
 static u64 rmptable_max_pfn __ro_after_init;
 
@@ -120,7 +120,7 @@ static __init void snp_enable(void *arg)
 
 bool snp_probe_rmptable_info(void)
 {
-	u64 max_rmp_pfn, calc_rmp_sz, rmp_sz, rmp_base, rmp_end;
+	u64 rmp_sz, rmp_base, rmp_end;
 
 	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
 	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
@@ -137,28 +137,12 @@ bool snp_probe_rmptable_info(void)
 
 	rmp_sz = rmp_end - rmp_base + 1;
 
-	/*
-	 * Calculate the amount the memory that must be reserved by the BIOS to
-	 * address the whole RAM, including the bookkeeping area. The RMP itself
-	 * must also be covered.
-	 */
-	max_rmp_pfn = max_pfn;
-	if (PHYS_PFN(rmp_end) > max_pfn)
-		max_rmp_pfn = PHYS_PFN(rmp_end);
-
-	calc_rmp_sz = (max_rmp_pfn << 4) + RMPTABLE_CPU_BOOKKEEPING_SZ;
-
-	if (calc_rmp_sz > rmp_sz) {
-		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
-		       calc_rmp_sz, rmp_sz);
-		return false;
-	}
-
 	probed_rmp_base = rmp_base;
+	probed_rmp_end  = rmp_end;
 	probed_rmp_size = rmp_sz;
 
 	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
-		probed_rmp_base, probed_rmp_base + probed_rmp_size - 1);
+		probed_rmp_base, probed_rmp_end);
 
 	return true;
 }
@@ -206,9 +190,8 @@ void __init snp_fixup_e820_tables(void)
  */
 static int __init snp_rmptable_init(void)
 {
+	u64 max_rmp_pfn, calc_rmp_sz, rmptable_size, val;
 	void *rmptable_start;
-	u64 rmptable_size;
-	u64 val;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
@@ -219,10 +202,26 @@ static int __init snp_rmptable_init(void)
 	if (!probed_rmp_size)
 		goto nosnp;
 
+	/*
+	 * Calculate the amount the memory that must be reserved by the BIOS to
+	 * address the whole RAM, including the bookkeeping area. The RMP itself
+	 * must also be covered.
+	 */
+	max_rmp_pfn = max_pfn;
+	if (PHYS_PFN(probed_rmp_end) > max_pfn)
+		max_rmp_pfn = PHYS_PFN(probed_rmp_end);
+
+	calc_rmp_sz = (max_rmp_pfn << 4) + RMPTABLE_CPU_BOOKKEEPING_SZ;
+	if (calc_rmp_sz > probed_rmp_size) {
+		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
+		       calc_rmp_sz, probed_rmp_size);
+		goto nosnp;
+	}
+
 	rmptable_start = memremap(probed_rmp_base, probed_rmp_size, MEMREMAP_WB);
 	if (!rmptable_start) {
 		pr_err("Failed to map RMP table\n");
-		return 1;
+		goto nosnp;
 	}
 
 	/*
-- 
2.43.2


