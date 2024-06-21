Return-Path: <linux-kernel+bounces-225009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AAD912A83
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98996B277E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0523C15445F;
	Fri, 21 Jun 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gbAdskS8"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503AD15219C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984565; cv=fail; b=nz0aXNvxn3pzIsexFFSdki1ttZmnJ1z+QSvWaEQN5iRehiff9lskAngzO62GeJSXNcQxilDilrggKwfW+KrDDr8k4LEB6gfzrwC0bkR/rpjw1KwO57BagVtcwheV3kHGk0H22k15/bYLvK7+KXeLMcS6sKjWwbiYIpP3hZuz+hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984565; c=relaxed/simple;
	bh=q0pKV49LiDdcu/kmErPRMI+DWSga1b2KCC9Rh3Rumwg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=liwjWEWuV5Seq9aLMD7Kf/sDRLfaBebRSgITa3eNFS85dVeYxDv1x77r4nExaaq3AZwfdeHLiYfZ1VRh9Y6FmO6kPNreQuaIdKLesEVMr6i184q8M2qibYdI5CsyMfUb4uk/Mlq9qApipQ7b70RT8YE1aputndcusxLUBiwCu+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gbAdskS8; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpgsE2YLr1GGWg48F/DowgMGMFESAqP9PU1YnDY8IXRs4vp44j8FWo1uOlu5g8YlMSOnYXdFnWNuQGn+JcXZQmriHMmqmVX9IbNwex2oy5tsHIf2s1bl4y2DmKpjVr4l5vw598qhLw3np9tzf7NPBJaI4n0leGOfL2o3azTAkT1K4XrxRlGrELNuIXLwBI02vjhtCh+TD4seQlRtcFSUm7h+iQ0vNTjsOy8ApbHqEcrt7y/c6AN7pPcCrV+j3p42pq+soEkQTIGrw6Y3XdA984h99ZtdExAdinSyouafXFeQwjVQhd3Fwc01M1iqjHb2RfccPIjzSaVHYgpS2bP1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6MPtWZJwiiE6QBlm2ZkmF4YCgAXs/gzH6RbHNrCXmc=;
 b=bIXvy6x1grUE+EGcjmiQIgzG0vrx4oCkc9efIGbiCEVFRVKeUVAMgRYsStk+aQ633Tu8gTAXPg0gLnZdxWcxpuoDPgaakfhhm37CCR1QgzO4uINfkXDW5IoeAKLUQmgplqiNzGVnx1cppGXGKK6WjwJWsYpOCp7ueucvgEI2lcbf5MNubh/GeXVPRO466KMv/A+rj/dyIe3dmvBUNCHZlQwcGZod85778Nlrb35poXqQHc6UY29S2LdHuHyBvLCMlIN0/1g26et/8awBJvzrmfYjXsL8A2O5gSSjqZ7PxPopAnb6Y7Qt9i58rEjuu8CjY+nXus6vMrzjDXOO0ostjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6MPtWZJwiiE6QBlm2ZkmF4YCgAXs/gzH6RbHNrCXmc=;
 b=gbAdskS8JJEQXVIu863ZoqQZYgkYF1Z0QpxQJTe8o9lni/K7Pk4jTKuFXPNX1nYytnPW/+CuMFb6ZfB5xGLyfevuEiqEoo7Yg6oOKuufLy7UzTUWrsL89VFT0QVKfmRPynKZrxztrnn5D41rPSU8KAFXPtnJRUfkoMXjL3V6Bm8=
Received: from BL1PR13CA0265.namprd13.prod.outlook.com (2603:10b6:208:2ba::30)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 15:42:40 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:208:2ba:cafe::d9) by BL1PR13CA0265.outlook.office365.com
 (2603:10b6:208:2ba::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Fri, 21 Jun 2024 15:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Fri, 21 Jun 2024 15:42:39 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 10:42:38 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2] x86/sev: Do RMP memory coverage check after max_pfn has been set
Date: Fri, 21 Jun 2024 10:42:05 -0500
Message-ID: <bec4364c7e34358cc576f01bb197a7796a109169.1718984524.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c4b307-f3ae-41da-ea03-08dc9208c7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+gQIAKt9C1U8lNH5uFIP9bxrzBBtf+aBtwrtO0WXRABObtcPavHji5Vp3Brz?=
 =?us-ascii?Q?l9tgxuvDcWhF71qoYL+yiyZwzzNpZVbfW4JZgfHXnyvtFwzuNczRCR+S2mWW?=
 =?us-ascii?Q?1720kMCuI+G1SRkYmOj7ikaMyT1mA5gEDfEL6W7lAM9SiFi9MLrDhHY5ZHoh?=
 =?us-ascii?Q?BLRYg61zFs2ChA8+nWs7VQlMjbMLmQheYps8y7AHICaLnlziIeESp47edJlQ?=
 =?us-ascii?Q?PO+q4ZDl2era8MD+RvsyFxuLBhLZ33oj5rT4cGdeeYGRTzJd3yTdiagoszw1?=
 =?us-ascii?Q?rhVTEyNgYkY8QgfYXsG+9G2MKKlHhvyj7fC3UNpCdIYlJEjoHAP6ZJzAyxkl?=
 =?us-ascii?Q?pXtcZKOcK6w8wjll4ZCVdd1YE57xk1F5ergODGgva2iEPT2C7kvLirKJOk84?=
 =?us-ascii?Q?3hybea1qv/pUHKGe8yYFTe/cpH0Ud8A9XAie7jJ1rPW3cZbAyUiDhLU58IjK?=
 =?us-ascii?Q?NGhjoUwtrxXdMs9Zm4GrZFiapURdTVhI5u0znsOAi29svxeryz5fTAm+orui?=
 =?us-ascii?Q?6PdQGBGwkV3gq1hVNKxdEBIZKESZHihDDwoeAmxKaMmv5/j1/batq441clJR?=
 =?us-ascii?Q?m2iJb1NaqhnKZbJ3VVMrGfIP0866nG5NM3Jq/7rMUbxtp+ycF58KwtraW/Xy?=
 =?us-ascii?Q?cT02gt5sDuqzCphBJdwEX3kwjryueLKc75a76dnkvG5TT3O2N3kiiPyfyz9J?=
 =?us-ascii?Q?miTXSWQ7pk6GiR6UqehCfElKw+yJ08jmyCID/x691jgY8pL+/VMxbBla7+MY?=
 =?us-ascii?Q?43pc7lTQ5DDivzi2Y09YycMOQH7//s0T5vLxebauyzCno7iYsijHJuB1Tywl?=
 =?us-ascii?Q?1LioqGJTEgYTN/xE/u2ldPGCruH4baKC0vXLVGRqaF7OZ06ONMUPbuKU+Jfb?=
 =?us-ascii?Q?PglgZyhdOkftMw6uWRLumtPvJf4C0xpqb0gZoY9oiherauLCw6D1c9EiQ9Xn?=
 =?us-ascii?Q?f79uY+pYTYdG8kYUijdMXARNtvmGNMAGuvwgCjRcSVeUDb8+Ouo+KVD/9j5i?=
 =?us-ascii?Q?MT2w5wXL29ijJ5fq6CA32f6091v7iu+HJt/AROhIcsjAUG715+sxNo+sI0q7?=
 =?us-ascii?Q?gPALvtGFhLyn34zqJIEc8Ze1Lp/sZCxVdP95qLIjr0NBwRXCePnOZcDOQ4SC?=
 =?us-ascii?Q?9dPLb90NSxzSv60v/Plocyu43zkw5rNSWUFjccE9CLa08pZdIaq0KHqhbLbS?=
 =?us-ascii?Q?8boWshtx6F2iKlVLQiI4Agj7qWFrVmEr9REm2BjJXSxn7wiQG3K7CBtGLNN+?=
 =?us-ascii?Q?h9Xd60gd3lCoFnTWOB1Ube2B7FLEnRX5yJ6QdrNGCNVd+DW2VlbA/FLv4L4j?=
 =?us-ascii?Q?hS16w7NZ4H4I6Rx78aCeiDtpztmAF6m5ZyKz5pUbdVVRzJdC0s3Equd/uQJ6?=
 =?us-ascii?Q?hjvrAx0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 15:42:39.1711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c4b307-f3ae-41da-ea03-08dc9208c7fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193

The RMP table is probed early in the boot process before max_pfn has been
set, so the logic to check if the RMP covers all of system memory is not
valid.

Move the RMP memory coverage check from snp_probe_rmptable_info() into
snp_rmptable_init(), which is well after max_pfn has been set. Also, fix
the calculation to use PFN_UP instead of PHYS_PFN, in order to compute
the required RMP size properly.

Fixes: 216d106c7ff7 ("x86/sev: Add SEV-SNP host initialization support")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

---

Changes in v2:
- Removed static variable used to hold the probed RMP_END MSR value and
  instead use the existing local variable in snp_probe_rmptable_info()
  and calculate the RMP_END value in snp_rmptable_init().
- Use PFN_UP instead of PHYS_PFN to correctly calculate the RMP size.
---
 arch/x86/virt/svm/sev.c | 44 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0ae10535c699..0ce17766c0e5 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -120,7 +120,7 @@ static __init void snp_enable(void *arg)
 
 bool snp_probe_rmptable_info(void)
 {
-	u64 max_rmp_pfn, calc_rmp_sz, rmp_sz, rmp_base, rmp_end;
+	u64 rmp_sz, rmp_base, rmp_end;
 
 	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
 	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
@@ -137,28 +137,11 @@ bool snp_probe_rmptable_info(void)
 
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
 	probed_rmp_size = rmp_sz;
 
 	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
-		probed_rmp_base, probed_rmp_base + probed_rmp_size - 1);
+		rmp_base, rmp_end);
 
 	return true;
 }
@@ -206,9 +189,8 @@ void __init snp_fixup_e820_tables(void)
  */
 static int __init snp_rmptable_init(void)
 {
+	u64 max_rmp_pfn, calc_rmp_sz, rmptable_size, rmp_end, val;
 	void *rmptable_start;
-	u64 rmptable_size;
-	u64 val;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
@@ -219,10 +201,28 @@ static int __init snp_rmptable_init(void)
 	if (!probed_rmp_size)
 		goto nosnp;
 
+	rmp_end = probed_rmp_base + probed_rmp_size - 1;
+
+	/*
+	 * Calculate the amount the memory that must be reserved by the BIOS to
+	 * address the whole RAM, including the bookkeeping area. The RMP itself
+	 * must also be covered.
+	 */
+	max_rmp_pfn = max_pfn;
+	if (PFN_UP(rmp_end) > max_pfn)
+		max_rmp_pfn = PFN_UP(rmp_end);
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


