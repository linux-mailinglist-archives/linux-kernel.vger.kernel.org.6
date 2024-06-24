Return-Path: <linux-kernel+bounces-227370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB2191501C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEFD1C21D03
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB67E19AD7A;
	Mon, 24 Jun 2024 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sxIrV4jI"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA519AD67
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239879; cv=fail; b=U3oTwzoyyw9qTAqViv4MwVzWIqckrZET+m1pGTFmRoEDxgTuTMS+5lNHCbVz7TsBBeLUcx5Xk43GHmsPUhmkZ87YAPF3iCKJIIj68Rxs+NfWoNZPmW/NsbTh77WtKsOyh67S/mlnUgWzb13cilU81bl2n595QSUbtHqO4YhvwbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239879; c=relaxed/simple;
	bh=kBmG3oyaXCc7Kdk1lVEAUJZNeYXEr1v6wmYTK1d50qA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KP/ydYxKlY5cDp2yYwd6cnazeZrIrbnBQlYH/ffCTV2zIKK8MzxwZLAnlqyP1lE/4yVwfwc/xFmSpH3Rd0N/TNnyBDNp/V2tDZ4Y7NeVN7CK5MA5tXDRuuk5PqFAGZ6wOfFbzPxTFuOt/H3nmcNBUGplUXhNf9oEgfRT1hjQKtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sxIrV4jI; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlRlJQf/ZuJbqZL/kiWEBJj/CfGsZMjXFEseKi0Rsn1L92nc1RuN1ul6BHxEXu7Nryw4IJ/oPzxbO2imFOxhMd/iFDbhYZJlGEOHOVVkD5407HIgV8WAdbY9NlEfNj0wc2drRyfMAKBs+Waxs4zfldBeA7HdA90bBQ8oIDwkqOKq6WI2zJEkFASr5oWQlKO7sI1AJso30DIKXAvYBDoTl8qm5N1lF06HrMiuSFqq8uZSt/QayYts99vQEkalPvfgfvw3CgSITvJVnvqzMQbVRS8KdV9Y50waj5nUQqpknJQiLaJnkAt5uyHORneeSFRG44EIjFGoT0iu3fb0cVhryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYKyywUZaArWrHpIgzRuN7q5CmO5o9ImOE065iL1XyQ=;
 b=I310iHZL7KRsaK3n6OS3Alg2+oWO8SOe5DCn7f5WE2VWrVCH6DUj5qNM7UMZdHI6BhtT8J1xv0ygStdBc1n1K1z0cnC9CeieApJ4p0iyA/3hPvnq/VAUSuKQ5l9T4N/0lOdUp1CKNXpHEJfqLqYZ6+WPL+YVqiHAAVIn/F8Hx38RfqWjdesSwpti7rBdxM4TYrU3sVarXaDdQF4uHBIhLeKWsLyFRbMRj9Rq7CFYkFt00zY5UN8Y0HSp3TAzO9j9sCp+ocdptr+n/IR2uWhShmDvCv9n/VWjjHW16UqFjb5tXTblUJRcsQ0JS4YHiV4gDviijZenis7e0Ic0IMKglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYKyywUZaArWrHpIgzRuN7q5CmO5o9ImOE065iL1XyQ=;
 b=sxIrV4jIxfwMrIl07IJdOWFEdYMl/7+D+iqqGou5TGx2PYOTIUvQh3dQnsydy7DFcevJQXOq3xRkEFuEsFujdFDJf3QgqfI6kWlVUT3M5uxZ2torWr5NKKmh5mAkH5Fm8NMtert0QeNXt9YfGvtPUmXgFYiydK3FEqeHxFLlY2M=
Received: from BL1PR13CA0314.namprd13.prod.outlook.com (2603:10b6:208:2c1::19)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 14:37:55 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::39) by BL1PR13CA0314.outlook.office365.com
 (2603:10b6:208:2c1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.19 via Frontend
 Transport; Mon, 24 Jun 2024 14:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 14:37:55 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:37:54 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 4/7] x86/sev: Move the SNP probe routine out of the way
Date: Mon, 24 Jun 2024 09:37:08 -0500
Message-ID: <8a2b3cb06613552c6ffe498418541573e6821044.1719239831.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 498cc1d7-c546-4903-35f3-08dc945b3c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lN1mbM/j9dxIqLv7Hedp9Xfg50lmj5pyX991eU5hOHHzWAH0f64wAvw5+rBu?=
 =?us-ascii?Q?5smyfEGZP3Tfp696xztBXgF5mLV8Rm0G9Vpti7RrPWbtozA+gkNoZ2mvw+6u?=
 =?us-ascii?Q?4C4AlG2tNU6YSalzNiGxZ6ymu8z7+UUt8anC6H6X8apTeAMirO3toNGXvkAh?=
 =?us-ascii?Q?rXiB5BDBEliEfc1BIKfN9NvXo7qktjjG3Szu90ZtzatfZzJrYd10sMfM4zXL?=
 =?us-ascii?Q?lln05JyqrXAjhhmDWjiWw9Ilbp6jA4Z7Qei0MeURT4RqgSRI1uODui1+I+i1?=
 =?us-ascii?Q?dT6pjMpSzhiTjYSEkJxAYj08i4UwRa+J0UpyYIGPcCrVY3yBkvo323M03g+8?=
 =?us-ascii?Q?0BHiQ/oJpJ7xQrJqm1IeD391vGsJcnyiIMTx5b9pd/oNQrVeCGn7Nzg+52Bb?=
 =?us-ascii?Q?Xv7lb0Eeui8g5KALCaLK9ma5B5xPP9n6Pp4dlbLV/vcFSB9Sj6PTFw1EmUOc?=
 =?us-ascii?Q?KfB8h5E+FKlEC8UtmaBEhyNmb0BJTJ+FoPNu9f9zSdQJ0B1/K6zE4rjcXk3I?=
 =?us-ascii?Q?ASH4Ws5jaNbz9ZPE08/uNZQtVFT/1bhSAu7a+zYbXwtzwGRcQHqdH1KkxZ+J?=
 =?us-ascii?Q?ntP9QsAePcB7bK3VAZQrsAXp2I+JwC8XajW3YRy9ufPjAoW62edB5F1LV32V?=
 =?us-ascii?Q?ozQoCmi1+H9lmrRMHcaTdXVYEJ4JydY+h7Y3D89b9iCpFKvQFYQuu65L33Zw?=
 =?us-ascii?Q?XrMSpByu9G8ZDuaZEtIDlLch5HwMEfuHpVPV4XNW88hIA2kcbE7lcoZQA/qH?=
 =?us-ascii?Q?Xpgp0jjkGpCh6pRxEaaxgq7VEsSek84w7Uwe0X3XGcqknvpxN5xqREX8huXj?=
 =?us-ascii?Q?GMeuFki1+yCuTzK3hjIVDm4HG20W/VkYZglcZqlSjkEQB4GFkoUZRKxDR95T?=
 =?us-ascii?Q?WFMgW500mqSC3gjOA9cID4OVkMbs5Afb3OaQzy1Z9W7rbH6B5qS3/5XllyKF?=
 =?us-ascii?Q?QjgDGwXFwhqsFrRBgN+FY9AUAhBo7M+PR/CuPjp7r8kc2XP+DdW++sOIF+BI?=
 =?us-ascii?Q?HpzwifMqaNJKW6m8eRbkMEvBXeIRIuWBE9W4/cvtnC8qjoVIFQbFQjjTxn5J?=
 =?us-ascii?Q?7MPErdUBHHqPORDFSFWtKyf795QyNdM1bzTlLN6cUaT0ieNz1n3w9EK7N8Vi?=
 =?us-ascii?Q?o2rJQH+UJCOHGRiCkStfFKMOi/MdRD3JAd+S4+WXq5eHOI1g5jhorTnpiq0j?=
 =?us-ascii?Q?ZQr6SjVCpy/+M80//BPcT8givWhycBGWVdIDnEoo/48Talx8L+n1rnWwF5FT?=
 =?us-ascii?Q?BzNqiYkC0PdR52BJHbBvpPam140JTdfWzQ4O1gRVuMGB645ak8z6t4mJewCc?=
 =?us-ascii?Q?Z+vzelOx1YwNZUHCXNIdxnGloL8OBdDdafrxzTw34Hpzy8R9PrqzOO0lcoli?=
 =?us-ascii?Q?VDkq4XhaEXqpIUaidhv21wdy0q8oyTgGWH/KZPdO4Uu4TZrbFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:37:55.0730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 498cc1d7-c546-4903-35f3-08dc945b3c21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242

To make patch review easier for the segmented RMP support, move the SNP
probe function out from in between the initialization-related routines.

No functional change.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/virt/svm/sev.c | 60 ++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 73d4f422829a..31d1510ae119 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -132,36 +132,6 @@ static __init void snp_enable(void *arg)
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
@@ -286,6 +256,36 @@ static int __init snp_rmptable_init(void)
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
 static struct rmpentry_raw *__get_rmpentry(unsigned long pfn)
 {
 	if (!rmptable)
-- 
2.43.2


