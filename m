Return-Path: <linux-kernel+bounces-385697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2889B3A82
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8223F1F22A64
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6EA18EFC8;
	Mon, 28 Oct 2024 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OTG+viJ0"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21A16F851
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144013; cv=fail; b=T5cAccD38u9Dnbmgcy+vdI6xjaEZn4bf8Ho9VRzqaC2Si+ZMbaxfKjEjWfEzPj95HyOVsCpjr3aCdoJ2uml8yW8Fr/zjtGjjg8VtCqCKxGCvRA3ufDCxC6QdyojV+aDORN5HSzC+SxUTGMc82gMTYvQnL0ASgYhBHjdoEY5f1Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144013; c=relaxed/simple;
	bh=IuAex62buaNfJDYtl671EengNZ6f/JOwcVxRyr1HCgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hw3LVE5VBKX9mVaLpaSluq/3RDTQH652X239C9O5DtnuTilkyc+VObxeJIBdywSifothKyOl/6Lj+eTRso0FN81CYdompXLkamacrRgg6v6zjL9qz3qMQUR0LhZ6SM1jIXzil7OxNy3VQe2ug/RFn0XulyOA9Jxlzvv8rygcgVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OTG+viJ0; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHKN2KvwYVQ2Qba7u3/KzNzxWJwfZW15AC48VOn4mG/bCgWsekUSJw6zzKLPVlKpZD7acVzSAI+ZC5zFcX7QUgQN9MsBnVvhSi0KzMpe9GCLaVcQm8BDs96YpfInKRTwJbR7BQZ1Sg4kcIJ+wBq5NMUSS/cffxObgQURK7hapAEON3ErtezzTBymgEP359wZS8HhgnFp1TNiumt4XPhfCIB8oPkcTaTqzDUdM8lGOMGkUTPLqfW0hk1yB+fd/9M8jhfyhTAIGfRXfFzypEsuYKRgrdkRos9VQXp3at7WOtK1S/l0m7bqTPzJIYPmJJQWtbCtvSv5aaERQB5wjIEZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvFyQFfovgqN7re3a+VdRHB2KPbTgN+YhA3nqH989PA=;
 b=gkJZT+eTZtqLGp1pO7omVKIxoni7TTHYCQ4eY1oQIWpcjqvcyvSl/8gCgcQjmmmUFMcr7es5sKTbUBXJhi3Ftee5fLUr54bxZM8UsNr+5fWAB4WnLCptM3k5mOsVtYpFJagXhBnZdSEqtF+VIZykSZ4Ri2vT+kQ4HkACatS2Y/Hk29UP2xO1jwvazJG+HdZRbog2VHSK6EpiLzy9jm6vYUTqEqBTKqvrnO+DTkkxH6jni0GOD1Rjv/rKMcvJi5HazbGRWfOlBOsQtaO0ztly8AJsq0cNhzhFX279wUuof82gaJE7cX/m16zOkEHa6zS/9xQP8/8bNzT7ASPwV52Zwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvFyQFfovgqN7re3a+VdRHB2KPbTgN+YhA3nqH989PA=;
 b=OTG+viJ0vKiWYe62MZHr63bSKPwWz8Um9wrFl6klsyM04tSiKSmVOW6ixB5SKTz/fNi4JUTTbSSfutrk1t9/vvLBIuSWBqc6blVeNNENBCzlASWmYPhlpSixg0fi6pioProLp8nWUZTAoU0/ZGvcUTYXKHlNao9BBsEnHzYDI68=
Received: from BLAPR03CA0038.namprd03.prod.outlook.com (2603:10b6:208:32d::13)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 19:33:28 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::7f) by BLAPR03CA0038.outlook.office365.com
 (2603:10b6:208:32d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 19:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 19:33:27 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 14:33:26 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v5 4/8] x86/sev: Move the SNP probe routine out of the way
Date: Mon, 28 Oct 2024 14:32:39 -0500
Message-ID: <45e811b7bcf8d6d1fb3fb60687c16ede574558ab.1730143962.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c94bff-2d5d-477b-086b-08dcf78765c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CdIRbiqUm9Kw1JmZVmmGjZ0NmWgy5s+OCY1tEzCSelz4XHtvXeCJ9eDapms5?=
 =?us-ascii?Q?6i6Gj9c3Esv5NZmg+kBWc21xKWxYn6qAYS46I/31cNWap81YZ6l8EqFRJnHo?=
 =?us-ascii?Q?TluK2Bci881F1w7dopm0kodGRgONmxnt34hGBnKsD9vVPxvtRtwtS+IUbz6u?=
 =?us-ascii?Q?zQb6Dc7kO+Zsxqb1IiG90Usz36/s/mZvzDoJbxNXEfy6J4S5CMpHsyy87GcQ?=
 =?us-ascii?Q?hdCSs6jmtvS00IAfL7LRKEMSZ4AzYPSauG8UqjxKD6RhLHJVrP/LNQHpdP7h?=
 =?us-ascii?Q?jA4CZOd4ZQVRsWKf/wlM40hFm3SZV7z0Ycp/KJ+5E1FNtkvmjLFL0NWzM3PZ?=
 =?us-ascii?Q?O/8tgPpEcQJF80t26Y1vP4vZT/aurOD/E8sbpltBwdBzlL/6eddT7EKhtf0l?=
 =?us-ascii?Q?eX/QatPT0igpUtvP69pQFEmpFcQsfeFqs0rthV5fanFTiqxkq3v0uW2kOjKG?=
 =?us-ascii?Q?dt3+i6kFyjvmtu9dIwzGafIzuXqyCfTdbE0F+yzhS8ch8jelC2vyYPPurbCf?=
 =?us-ascii?Q?VnQ/Dm0J0npj8bOQnl+yXIZintBIZbaLQFw1coJNcwoCWFXXSTBcf8nhm0hb?=
 =?us-ascii?Q?ToP+hKbtCCwW9rmizPb+9iMFILBdJHik8dNXNnp9Atglz4dbGl2uS7Ywe2CW?=
 =?us-ascii?Q?6AAMIF4GtKk+adfVAMiaw2G1BDCRJj+Qbv/tY30eTAJAgrSpIDECgODTNH/y?=
 =?us-ascii?Q?uPkQPZCpyFPd77Z7NOSrDJbGmE1uJlUxLmcvgP7x591UgBV8JQ/Q7vyJQF8b?=
 =?us-ascii?Q?+80mQM2Dmf9+xEx+esSiM+pjA7EK4ESIjR11Pzd/gktlCHk4lhBGVEjY6C9r?=
 =?us-ascii?Q?xLLz3E7uSJOdWAtQafNVHUhAGrhFzz+iUGDZ40FfIn8cKyA702HoqRYyeEa9?=
 =?us-ascii?Q?3H4t1Sxp/RxZAx6EKbLOxsfkEVOlPvGcIPSxr6btkZQhrs5VqPQUlLPp1uZB?=
 =?us-ascii?Q?+ApGFk9qpawFYdBPELUF8EJBjtPfNa3mcWwI7+eEUfOYPS4YuENBlCPOE/4/?=
 =?us-ascii?Q?4ikDMfLjwY6y9uRE/zvzvnUOJQ3noRFt5mNOgSD8YuDH6lJDCSZLm7RnAfcW?=
 =?us-ascii?Q?0owAn1scVyvr63BFZ3Rtn2U1U7aptA6gdsDglt4j6qsNl5loaD+mWvqNs6to?=
 =?us-ascii?Q?hYV12o/lt4ePD79q9K4yb1VmbIFvspBcLtnAp58pBntC6AAYbPaRkxfDwEnL?=
 =?us-ascii?Q?beN9P5x6124vrpBFk5C9RHSBXLJNFEYHWoLD3XBoUmdmCc8eEglfyZXlTcFo?=
 =?us-ascii?Q?qKJmdJAvsK/8LCCvwL6lL2pi1aVa8mPsWnfnRlqHiDGnmKum0W64EPPi8Y7t?=
 =?us-ascii?Q?NbRsMUQsEFb63/zGS/OgTdHjXrTapIy8HZ2BXXFRUJJyj0Jykqjf5b913Ykf?=
 =?us-ascii?Q?B6zBfHyw2AKlsZps3J/6UqPDRs4Xyjc9MHLTARibj+l02zwUhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:33:27.8873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c94bff-2d5d-477b-086b-08dcf78765c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590

To make patch review easier for the segmented RMP support, move the SNP
probe function out from in between the initialization-related routines.

No functional change.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 arch/x86/virt/svm/sev.c | 60 ++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 7cca3d07e678..0b778cf7fa3d 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -135,36 +135,6 @@ static __init void snp_enable(void *arg)
 	__snp_enable(smp_processor_id());
 }
 
-#define RMP_ADDR_MASK GENMASK_ULL(51, 13)
-
-bool snp_probe_rmptable_info(void)
-{
-	u64 rmp_sz, rmp_base, rmp_end;
-
-	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
-	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
-
-	if (!(rmp_base & RMP_ADDR_MASK) || !(rmp_end & RMP_ADDR_MASK)) {
-		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
-		return false;
-	}
-
-	if (rmp_base > rmp_end) {
-		pr_err("RMP configuration not valid: base=%#llx, end=%#llx\n", rmp_base, rmp_end);
-		return false;
-	}
-
-	rmp_sz = rmp_end - rmp_base + 1;
-
-	probed_rmp_base = rmp_base;
-	probed_rmp_size = rmp_sz;
-
-	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
-		rmp_base, rmp_end);
-
-	return true;
-}
-
 static void __init __snp_fixup_e820_tables(u64 pa)
 {
 	if (IS_ALIGNED(pa, PMD_SIZE))
@@ -291,6 +261,36 @@ static int __init snp_rmptable_init(void)
  */
 device_initcall(snp_rmptable_init);
 
+#define RMP_ADDR_MASK GENMASK_ULL(51, 13)
+
+bool snp_probe_rmptable_info(void)
+{
+	u64 rmp_sz, rmp_base, rmp_end;
+
+	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
+	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
+
+	if (!(rmp_base & RMP_ADDR_MASK) || !(rmp_end & RMP_ADDR_MASK)) {
+		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
+		return false;
+	}
+
+	if (rmp_base > rmp_end) {
+		pr_err("RMP configuration not valid: base=%#llx, end=%#llx\n", rmp_base, rmp_end);
+		return false;
+	}
+
+	rmp_sz = rmp_end - rmp_base + 1;
+
+	probed_rmp_base = rmp_base;
+	probed_rmp_size = rmp_sz;
+
+	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
+		rmp_base, rmp_end);
+
+	return true;
+}
+
 static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
 {
 	if (!rmptable)
-- 
2.46.2


