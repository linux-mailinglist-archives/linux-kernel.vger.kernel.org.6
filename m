Return-Path: <linux-kernel+bounces-227372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A2791501E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E243281A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3593419CD04;
	Mon, 24 Jun 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VkmHMISt"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615819AD67
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239886; cv=fail; b=giSC5qxseyjieynIOYNNCm/pFV1AnDVVlCZ93a1yYt0qMzfk2saLdCDGZYCull0dsKjQVIIe74BNahcoEaSGvsXWjImMf79i1suBKV8t4+JB3SA4Y48gFAxTPIaJnqBO32LB+kXVoIM5adAwiHx2F6vFF8SnhzIErGZeHyUmpcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239886; c=relaxed/simple;
	bh=3jBNdQuOnPDungJ/P9wT4zRL7z3ao26B4dmZqfQJDBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDW1byGvxrmxFSwZIAiKV1aUGaw9EaqoVFR6lXdvFWn0QZQQIx9JhZynlR5kfih0ojFx29/fyQjHfp2PDeGuNeHvKcAvtuh3Z+BKHppF3ZFn0J3tmKxyK5B2PzWrWPSyR+zvx39HJuBfkLqebEruqKa8+SxZGZ5iE/mvkFHR4io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VkmHMISt; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNTeIBIYjfT4U7G+a6YYcq4b947ic2C5bMuz+GZ3HqG2kim92VOdl7EUYj8ZK6/9hla2mIuRDIlAmod6KkfPBueXAdzy0zYT98kA3zj6wA22n6GPYg1UJKyfnWCA+5IcUhnillsUrJoFS/uesODigyFT4FHOFDgDeS2pzXRAQ8LPYBuxptv5WlN6l7yuimLoZYDOpwAOHUiO+4/YS7fEICUCApr8r1lE4x40Bi79gtrhKXUDNuHLKATqaGGrXDG+wIxdMVjxS4KnIa/rtQcMQLhWQwQZmvzbPJMZfNEX3dEPbvl7HJaEjlVUpLy5M/66iLilfPb8ul0ySfoDhc245Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T6OLVACWHgZ1LYo7hE/mdJpXwj2bJ21of8Mu2wqhdk=;
 b=ROI3a5/i00bOByIYo+hdqT3Amw+CgtfXgyX4PN4GAG0MBsmqxfDkFoFyCCPUr1xi+IEGwuSbyMqlzaPsZOg8aCBWM6sydq9oQRB9ErBeIRhLGGwXvWoempPRVXFICBu7s7xsphch6LccoBAj/XdD6pfxM75CWJ4lQyRt7DKCLz68/tODa/u79dllJgLtZ3D5MRXwSN0ab2whhso9J1W8WIT+/Q/KdULKcqjUserD6uLfxxuX0YErwemanFtfuGjDvMIGV7qcirMJLDh0MxEqh1E3dxElXre9uBTcWYcBWVpSntq9B2UrjP2OwAhLJiqlbO4RbJHGD+Bv3Sd/EwTbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T6OLVACWHgZ1LYo7hE/mdJpXwj2bJ21of8Mu2wqhdk=;
 b=VkmHMIStWpQaF8gKwupJ7a03AFvP2grarlj5FN+u14rSs8xaAPhb8YBrbYfoAVpoCyVkDQMl6JC71vg1roTf/OXa7YDex0Ruz3xCgpqOFNw4tlH+Q4vZq1cYzCn+ANYEwlyMB2mlgT1dHyExFGMRggKe4hXu/i9g3hIWs6ogyYw=
Received: from BL1P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::35)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 14:38:02 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::3d) by BL1P223CA0030.outlook.office365.com
 (2603:10b6:208:2c4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 14:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 14:38:01 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:38:01 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 5/7] x86/sev: Map only the RMP table entries instead of the full RMP range
Date: Mon, 24 Jun 2024 09:37:09 -0500
Message-ID: <6db2d86b4fa0eafe1bd43e53a2e3bb1eb069c682.1719239831.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 176b60e0-798a-49df-a052-08dc945b4040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Br70uLW2EIi8gHsxxqM3wRpPPRQvGSx/xt9uptIi+SKXp437sO3PA2pcCCfv?=
 =?us-ascii?Q?/Xx4yZyhO1Ho4ZOEqmpV6TCHWeGHbPdeN/BjjZrG61eHvDOsqrdaJB3+Fxfa?=
 =?us-ascii?Q?KSDmGR9ddYJEkc/vMB6IwefzBqYKG8IosDs/I+3NED2lly8ERYmemBQXjaW3?=
 =?us-ascii?Q?Iz72Q2KbfAsc3aaIYSD3IccQimWmGS+bYumjDuA1fXnV+z9uSh3Ed1ShJu/u?=
 =?us-ascii?Q?lzYe+hk1T4F6iPfmqqmcbM6p1y/vUDZ5VnImw11fDvkbbCybgIVQOEu09ZIx?=
 =?us-ascii?Q?GciaJ/E0e+QzTaQQSlcURU8KnCaXgcZgX4D3fHZ1C65R5X16B50Ku64E3jB2?=
 =?us-ascii?Q?gsESDqu2Xs5BcIDyHVPHTHyElCy9qOhLHySOP7IoToPwOiIA47bTwETRd8Xi?=
 =?us-ascii?Q?xR8z/okmi/rk09mZI2pmahWA6JgsH7wUWmiLyDBXAlKRq54mTycYyq4PrOH3?=
 =?us-ascii?Q?D0ZMkPVW5sAsXMh3dM8kwqlT/uoU0mSGOWSkxTOZ7ke8XktzxvRnNr6772cT?=
 =?us-ascii?Q?9TtlgE2arAaV2VRaMp6+qXcdTmCnXD7CTJkIJziad48NAiayMkL5v3DJT3zi?=
 =?us-ascii?Q?HPeR1z6cMJ3crKuFbUemN1NSCYu5DCNfcMjD9/+BojmVNEoXJgfrghr10+tj?=
 =?us-ascii?Q?QiiSQfSOsyVpTjc3rrPlKcDW+uXtmOdB3Xldr0VsJdgnTbVLwF+BzOPPRwBE?=
 =?us-ascii?Q?V9clt3+pGFPOq2/7FtyIiUAnkrunvYSHD7OkuP6o8WOMQDbqdEY9tblGRqDX?=
 =?us-ascii?Q?N1ZchsnB4k+QpcF0Cvz6YwL93/sygoTxTO3KWWtrEBpVL678OqjKoZ+FlZs9?=
 =?us-ascii?Q?AIcusesAIfPvSLP7jGE9HU4wnd7f82VguFCIvsAoG5zCiMd2uq/fEUA1EmbP?=
 =?us-ascii?Q?nmL/FCpwzfKiQJokTODwd9LzwLq/Mnrw2heRltwSnYgbmh0fJcOa7WQUtf/5?=
 =?us-ascii?Q?hn3VivpAqNibqV/X+AKrb+cxNDFwjNJnRLW1Q+3P+QBaK1BmlY1MYu9cRvBz?=
 =?us-ascii?Q?ytY2Zm3JMAK4MX0pVaG+eybSHhWqzydJLQevIX8qCgGzANt4LGPpeQD5zFLw?=
 =?us-ascii?Q?zJHr3GhgQk8+1KQ7zs1TIKIHt4Qq1vk9Sv1aodCFp4HkckB+URQiSgabJo5t?=
 =?us-ascii?Q?X0TT+GIxveQvSvrpNGwQvgAzBxzHnrZfbgEzrF3Pi0pP3ZjTFssTwwHrHFt0?=
 =?us-ascii?Q?Z7cilzH4cJ1EOUE/tRNlyNIm7W+OeqTGtkx3rpA/tTAwPzmt7YL8Hg8hk9+v?=
 =?us-ascii?Q?4IbkWGDNp6Vuld8wxvGFnfDeQ+OEPI5AjMfVl/dpZJ+X+bQe4MZ6YS8/3oyc?=
 =?us-ascii?Q?X3ilBB0Z6quB4alzqNJomHnD8SCD3cLuxnYRHHmYSWK01t0I64sC5JNHAbot?=
 =?us-ascii?Q?/LZyCXMI4l1y0xCtOixpRRffJxaOJpnmajE3tXZGQuqcblR4rA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:38:01.9898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176b60e0-798a-49df-a052-08dc945b4040
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254

In preparation for support of a segmented RMP table, map only the RMP
table entries. The RMP bookkeeping area is only ever accessed when
first enabling SNP and does not need to remain mapped. To accomplish
this, split the initialization of the RMP bookkeeping area and the
initialization of the RMP entry area. The RMP bookkeeping area will be
mapped only while it is being initialized.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/virt/svm/sev.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 31d1510ae119..81e21d833cf0 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -168,6 +168,23 @@ void __init snp_fixup_e820_tables(void)
 	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
 }
 
+static bool __init init_rmptable_bookkeeping(void)
+{
+	void *bk;
+
+	bk = memremap(probed_rmp_base, RMPTABLE_CPU_BOOKKEEPING_SZ, MEMREMAP_WB);
+	if (!bk) {
+		pr_err("Failed to map RMP bookkeeping area\n");
+		return false;
+	}
+
+	memset(bk, 0, RMPTABLE_CPU_BOOKKEEPING_SZ);
+
+	memunmap(bk);
+
+	return true;
+}
+
 /*
  * Do the necessary preparations which are verified by the firmware as
  * described in the SNP_INIT_EX firmware command description in the SNP
@@ -205,12 +222,17 @@ static int __init snp_rmptable_init(void)
 		goto nosnp;
 	}
 
-	rmptable_start = memremap(probed_rmp_base, probed_rmp_size, MEMREMAP_WB);
+	/* Map only the RMP entries */
+	rmptable_start = memremap(probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ,
+				  probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ,
+				  MEMREMAP_WB);
 	if (!rmptable_start) {
 		pr_err("Failed to map RMP table\n");
 		goto nosnp;
 	}
 
+	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
+
 	/*
 	 * Check if SEV-SNP is already enabled, this can happen in case of
 	 * kexec boot.
@@ -219,7 +241,14 @@ static int __init snp_rmptable_init(void)
 	if (val & MSR_AMD64_SYSCFG_SNP_EN)
 		goto skip_enable;
 
-	memset(rmptable_start, 0, probed_rmp_size);
+	/* Zero out the RMP bookkeeping area */
+	if (!init_rmptable_bookkeeping()) {
+		memunmap(rmptable_start);
+		goto nosnp;
+	}
+
+	/* Zero out the RMP entries */
+	memset(rmptable_start, 0, rmptable_size);
 
 	/* Flush the caches to ensure that data is written before SNP is enabled. */
 	wbinvd_on_all_cpus();
@@ -230,9 +259,6 @@ static int __init snp_rmptable_init(void)
 	on_each_cpu(snp_enable, NULL, 1);
 
 skip_enable:
-	rmptable_start += RMPTABLE_CPU_BOOKKEEPING_SZ;
-	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
-
 	rmptable = (struct rmpentry_raw *)rmptable_start;
 	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
 
-- 
2.43.2


