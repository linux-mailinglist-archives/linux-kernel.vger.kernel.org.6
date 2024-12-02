Return-Path: <linux-kernel+bounces-428363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ED89E0D58
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B7B282655
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF801DF275;
	Mon,  2 Dec 2024 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KdsuaPoC"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D641DF266
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172707; cv=fail; b=UTJ+GxJNDO1s+AiMsB6fIy/ee7dYzPnibE5/rTJyTEErGAbmNS0QdyBHgame1/lDitpQgqI9pWX/BUxdhjRmj/jIwm0DxBtP3VYGpf0x3c9dHQEA+mJFtg8qmq1zElUjTM2fj20Jkn+C3EwK61+UoIzifVscW1x6tnOhvst/EaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172707; c=relaxed/simple;
	bh=R7FZMAxV1py2pxLIQc/aw4SUmvXARIlzGiAPk4x36VM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ru0SfFIYvH67YzDdhu5RfmGuebfMnX6z0rC8sCBqD0yYth0wQOFxKWrRfmssvSXVXucuaEkzqLWmIN4TdHJWTheVx6daucEUF8rbFb3kYYbTuBaUQjZvB/MpwW6+v813LHg2uRQRIgoUVeZ47VmCNBvPtVMAW7SqPeEluTlZB0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KdsuaPoC; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7/VoVxLN1QlAjwRd5xhKgHjql5SV1ZIGnMqYX7iIuV77OhuwCHOzZUoXvro2QVyQWhdqGnPWsx7rc5kavN0lHFFl/rlSciozNQB1Xcl9QZKx7WeljrTOkrSco2EGLnWXijwn1Ipddkm41fUu+udNTjcMhEgZQ1J523W6Bg6aH50yce0bSQZdSVj3QzXZ6Q6BgyHVd0/Zw8MGh/nBi+VpQpjaSil/+m1saWpFdJcMvxb/Z4sGzXQjaPNAFx6v87rDaw1Gp2JdOpPbJQwmGxIvUAPnohBzFcnB59FvsvT/ml0fUCsDuziU5Urk9JJJrudwJJRuIwG8hjPkSMAqjIl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK3cl4nfjFMwtSCtIczcQcTxoIT+Q+2URiAsbAwhDtI=;
 b=FFaAPWPz7lC4bmkKuwJun08A1FqBL8zLak/fJcXHIdIVaIOQ2wzV25usQzJh4e5li5gNbOdkOqsGPK8YnTqyNx3lr5Lhuu/dkZCARkQfM0NgH5XkDYiJodq2uuifAreSkc9aqq3odQ6aqpZfYV9cIWUQLrxditbsVtING3ZfQmeih1bAmFTA4lKwihMo/j1XdIX6+F0U73WFkXhGyGMjC/QsKAFgDh26wZ876zxDRE9QLHI7Q8cNz7v9G7UUifSNJ/i217Lh4VGdB+jzUfHb1XbqcIfZz64GkMtCPnOKPWIWefFOLMJvdOIUOrreB06tSJD8YhFnDbbxZvsqyBaGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK3cl4nfjFMwtSCtIczcQcTxoIT+Q+2URiAsbAwhDtI=;
 b=KdsuaPoCS1BF5QnLACqgHJ5INht/1B2afavJa/ZINjgMlTaa3dOHhAlT21cNVrVxZvBPl49NSl6PDKemOnIl5iGgMuY4ZNA/tVmCtg5XlNkAKL2qceGAguoq3injC4Vgf2vQGAIsfFDuolPWxzHna+0WXD3fm34ur6/UG33+W54=
Received: from SN7PR18CA0014.namprd18.prod.outlook.com (2603:10b6:806:f3::26)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 20:51:42 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::57) by SN7PR18CA0014.outlook.office365.com
 (2603:10b6:806:f3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 20:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 20:51:41 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 14:51:40 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v6 5/8] x86/sev: Map only the RMP table entries instead of the full RMP range
Date: Mon, 2 Dec 2024 14:50:50 -0600
Message-ID: <22f179998d319834f49c13a8c01187fbf0fd308d.1733172653.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c3c524-8394-43d0-51dd-08dd13132016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZwjUcjK2fpeJC8N/AbkCWkppvkqJCnVXLARme+Mef3RefZ+nqEibGfn0eIQL?=
 =?us-ascii?Q?EMbK89c4KvprGbu44whfBJodExBI0M788dAijzoDDVJAMFX/0AoCWjBJi9y0?=
 =?us-ascii?Q?ur9svP/OA6dGv+7kDJxH1rIoaMqFqSbrYm1pGbrHy9nsiMNZLI9fhs3EfEOV?=
 =?us-ascii?Q?ZsvpeHwrp5nCgFOzyH1FaLc+NPAQmzj30xg4wReq6MvJu4oN6lMXdNBq/sL2?=
 =?us-ascii?Q?+fiXM5QqPUYKbCXPCIMuggisAsK4M3CloBXpyLDkAfCZcY7S7hsqj1QIYG7Y?=
 =?us-ascii?Q?HcPWqWQJcCl9zeUd6u26xDkJEodsQyHIl24mHYp1NURQYraCNA/F0Di+vRru?=
 =?us-ascii?Q?nYSlXVgSyNzdgACYob5oDieQY5dxhrYEtIWfQNDqrOZ4xaUWugLYAirrovXj?=
 =?us-ascii?Q?UsLDx3L1lCPBzW1NmrXy39ayUgFUqA1p1o+53Rw1i/IQx2KwDgf7bDOr5vlr?=
 =?us-ascii?Q?guqcILwHIMFBXV/BdRfIdg/NBw5kerZ359ZoerJ7GelldDrktVLGLU683r5e?=
 =?us-ascii?Q?JDjwKmg6xKuHkbMGte33upX7g5XXXgKYx3P6Xva6wap+I1P+bOTGI+7lBbJi?=
 =?us-ascii?Q?ExEarfPABY8bD3VJIO9xg2YpR+/CvuQ21pjaBkb4fYQIIJOZ1OAbJAKDaBg2?=
 =?us-ascii?Q?rPL+00dqtjXa8QTn7EGgJ4K2x0iuz4WchVXYFL/tgBJytDzYPf/NTfNgoCmN?=
 =?us-ascii?Q?OyHs34slrsLm9sc8mZFg/nAktUzW1XapyYQ27ZjfpBHmk5N7y4CbMdBukZA0?=
 =?us-ascii?Q?GDC4eboMbHGnwG7Xp2aUZx6NdQz0bz7GUU2jExZdI8z990ghKJDkfTn6o1zH?=
 =?us-ascii?Q?IkNv69lyhf80o8xUj5skln7oWIXs2RGdvVEnLmXKq5p9LcN2tJtskous6pmA?=
 =?us-ascii?Q?6OhW5r+fP8fo6tU1Gl7H2bs292vPSrLg9aEBewKIT+m4g4a40FUf++2kkNZl?=
 =?us-ascii?Q?AaxUWtiTIOephpXLqMecGbhii2qAuUZP/bMCI8Gdi/Pw9s7GxG497B1X0ANR?=
 =?us-ascii?Q?S1hx0QrTAH0naXLEGf+CRyPUsaRE5iO+re9Ky0oQCkBukMY+ACHwdOWg5+f1?=
 =?us-ascii?Q?LY4yEv/VfpxD1NFNZa8Ev2H8oSsZMFG07lvLdSaG3h3utGBMfKPQE27+2L31?=
 =?us-ascii?Q?snAiGowXFpaPVK0+i5w+gN6dcwSe3YPvdkThjAjhCK84LEAkxnb5U5LdBpoN?=
 =?us-ascii?Q?bNKOJwy3d6iRWLZvPWGfYLgjsinadeR9vmQ2fnQHOtzx/XMlALGmCit0olu1?=
 =?us-ascii?Q?Ex+/dk//ZsmoH2CdbHWTpqv/CcZSwnt845vWmExO0jl10qT7/VEkBs3Kgv3Y?=
 =?us-ascii?Q?rxOJZBy0vsdned6nxyoQ9Th9LOgzkKmG9oyZTGAdPPk96W9EFmtRzc8jBLgk?=
 =?us-ascii?Q?rXnK96WrbzRzbE3Jh/UHe5VXhJgsu73l3iGoFky58S+zJj+MxF0VfE3UuLpX?=
 =?us-ascii?Q?bH0M2XtlX4V+SZW4I+Y/lNsCEDFjGVa6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:51:41.9337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c3c524-8394-43d0-51dd-08dd13132016
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809

In preparation for support of a segmented RMP table, map only the RMP
table entries. The RMP bookkeeping area is only ever accessed when
first enabling SNP and does not need to remain mapped. To accomplish
this, split the initialization of the RMP bookkeeping area and the
initialization of the RMP entry area. The RMP bookkeeping area will be
mapped only while it is being initialized.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/virt/svm/sev.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0df378951ac7..2899c2e28db9 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -173,6 +173,23 @@ void __init snp_fixup_e820_tables(void)
 	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
 }
 
+static bool __init clear_rmptable_bookkeeping(void)
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
@@ -210,12 +227,17 @@ static int __init snp_rmptable_init(void)
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
@@ -224,7 +246,14 @@ static int __init snp_rmptable_init(void)
 	if (val & MSR_AMD64_SYSCFG_SNP_EN)
 		goto skip_enable;
 
-	memset(rmptable_start, 0, probed_rmp_size);
+	/* Zero out the RMP bookkeeping area */
+	if (!clear_rmptable_bookkeeping()) {
+		memunmap(rmptable_start);
+		goto nosnp;
+	}
+
+	/* Zero out the RMP entries */
+	memset(rmptable_start, 0, rmptable_size);
 
 	/* Flush the caches to ensure that data is written before SNP is enabled. */
 	wbinvd_on_all_cpus();
@@ -235,9 +264,6 @@ static int __init snp_rmptable_init(void)
 	on_each_cpu(snp_enable, NULL, 1);
 
 skip_enable:
-	rmptable_start += RMPTABLE_CPU_BOOKKEEPING_SZ;
-	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
-
 	rmptable = (struct rmpentry_raw *)rmptable_start;
 	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
 
-- 
2.46.2


