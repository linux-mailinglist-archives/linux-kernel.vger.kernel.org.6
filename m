Return-Path: <linux-kernel+bounces-268141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB529420CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708D81C22E55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8904518DF8E;
	Tue, 30 Jul 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QLlihSNT"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8518DF7D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368453; cv=fail; b=UDCs9I9Tmy0p/RJUXW3qqV+Cx+Smply32eFFufxblehQyC3YFe5PA0weJYWH5wVSyoLUmKV+rEjdPBMjtBxactierMTwtruGVs8pCu7JLf4ZpAvnbnK8ZSdPixrwg8+U6MGyZgU2mZdJd7YvOZdl0zmBMcIkip+uohfK8tTBDCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368453; c=relaxed/simple;
	bh=kBmG3oyaXCc7Kdk1lVEAUJZNeYXEr1v6wmYTK1d50qA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgWtP/dwyvD7CDPCMSJFJd59bXDe85nHRwLTGTRbudPfUhbfD/3E8QcpjcOBI74WDpihJYp1MfTNkhHYTB29utOe3g6BOzN57pqnKg2SO8RMz/TtuhstPEYkbJqf2Hq56fh9yGH+TgVjUEH8wJGIlWut2mfIHcChFp5VRGTFNVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QLlihSNT; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKwmJJzclWijAzKw9YUEW2ZG/BIlp0IFWz5OzZUL7o8Up9hKc6Clb6gqMNYs/VpruPmVXs0Wu6qFws8ztXHuJ/jLh91jwbYcrjgPf4JlwATeaEdlUcKA4d1u2Kax7tif/xPjsaJOKvscnMcWExRgB9e/vbeNp9AxqCprMZ9bUpaCW3pp2yYcqqE7YHdeQRCUzSkuDzvwhtcvorKmnLR5ca5UFLUtSgjxBfWxZxDxvgZiF4+lKhLhCha++9xvCwPhuWHNjoY6rKo2bcItJjAuIl6KPYGyBZ9ouOEur0YxnzZJYUr/HJnbMvoGIkeAF6O68rwANnLXFZ55DJOA4YlpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYKyywUZaArWrHpIgzRuN7q5CmO5o9ImOE065iL1XyQ=;
 b=vD7SCiPsNwvLswPpOam4Ar6WQVjfwOWyueQL/OrnJ8aGVJovBzjdVJ+pWP1i5+RKd5we6Blc0JN2corxwmB67Mc15EPPYIg5dlXZH0iA5Ufj7f6XC0VKI50IwZ4Mjige+a7kdHAjn4vNgb5ulzTPre8zt8twJNWNAgdFBSM5WRH41XlIHHn3uM26QV22MBLzq/RG7h4r1Z/0aRmi0N7pDKt17JDGXp1FsbF48BOAu0XmWumiyozRloM1t3XwuEFLSnrjcs+xILHWD2PnxKD/SBk025gwDWa6N7piyZkzMSwhcuO3ai5fA0uP66gbZd9dQTCL5my7WADhcSK8G5bb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYKyywUZaArWrHpIgzRuN7q5CmO5o9ImOE065iL1XyQ=;
 b=QLlihSNTd483xU3RrJkqjlQMgCzBFHifE8iu+aaDSCHKkxGOhrAbBxNcFO/Ysu1HonFpHBf3GJKVehtBW5nSZyzYNnnZKQf3oJRVEfJRt6GI0qoe3yjfRIb/mCkj8JMsDk0BH1yoh5bmYOVPGaTrxYMg95SOZcymIeruR06WSO4=
Received: from PH0PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:e::12)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.29; Tue, 30 Jul
 2024 19:40:49 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::a6) by PH0PR07CA0037.outlook.office365.com
 (2603:10b6:510:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 19:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 19:40:48 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 14:40:47 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 4/7] x86/sev: Move the SNP probe routine out of the way
Date: Tue, 30 Jul 2024 14:40:04 -0500
Message-ID: <8dc7831f77caec994dda31f7150e60f2617d1316.1722368407.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1722368407.git.thomas.lendacky@amd.com>
References: <cover.1722368407.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: c50bfbe2-a2e5-4172-5234-08dcb0cf8338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WnGHSMTHv7SAEYGFZF3Ir1FlQivY/WXxUHyjqwgDzma3DIR48IM9RhS1Z+fz?=
 =?us-ascii?Q?M/bn22WzH9o8pqOjbA5sW4emxeUZMJdZE8tj943/zlwC9EJWqFXnkcmIZoFu?=
 =?us-ascii?Q?u63PyqIA5+MwzhXD39pwcZhUoaE+pfzQ+dZ45Y5DQbj+b51sjiOcCXv4rnK5?=
 =?us-ascii?Q?hWWoNlP3wm0M3sz2xcMZAGe6ZGpoEb8VjIyNJXUtIFKmFWXEpcGOPt2XnvFe?=
 =?us-ascii?Q?L+bcFhi1DLaNmW/SgEZOI2s6OrRUSwNJWfQqFqNYlvxrUiGgjDtzZMkVsyR8?=
 =?us-ascii?Q?N6TE/cwFaax8dM5XhcxN+5tkNIOPH7xDhMDHf4NtfmrFZeKsUcaibdMq204T?=
 =?us-ascii?Q?njp/nAlO4IcT8GIku0qdB726VxgIG9tFYCPiMXQ76/Axw+ckcd78RxHEmhE6?=
 =?us-ascii?Q?SgOlgHLlZeBEK2eeZqJF4FIbxa70QUrkYNbK5IKK5PFNwT2MNIneQNLK0ou9?=
 =?us-ascii?Q?S3D3F2U9q0yeKf6iO0PN8jIhoqnBf1Vx2thOxewGUhPs9JJnN/hCw/hhx3FY?=
 =?us-ascii?Q?7VkeUD5Pi9WVWWuaLP6wesZGRqVfLmplvvjhMzHRCnJ4BvptzVI7GxQ6NTGq?=
 =?us-ascii?Q?EHtKzGckInjluQYAPJ1qmDYbfmnC9/wClVwq4K3Og1ri3NDooKxr+B8WEF4N?=
 =?us-ascii?Q?3BrzQXVpUhl9sdmV8tAMCxKWElm5o2WUoycem9QWLEHz0EmT9eWYICBm+3hQ?=
 =?us-ascii?Q?bEydwWEDULQDrSDTBzcfPPNkmjJ0hMZNdOJTdUAuJJKwNxXq/hcFhDs/In1R?=
 =?us-ascii?Q?SPnBVeoANbPWwWBrg6OKt8xERsV3pb4+unEZ3x/fcatt49wVR/yJgmA+ZDdI?=
 =?us-ascii?Q?2ZpeUPZci8EzdFHctJ4C8NUKar9nvuLz1MFoWk0cG93RzUD2dlbAmGllIqUb?=
 =?us-ascii?Q?pWUe9lj8AGSvhApOrn8ZDwH801RR7KdiqGDsvEMh4elT7r/0Rt3nIbWdmlAn?=
 =?us-ascii?Q?xs4xKWgz1T27djQcmWDZ257nsDypup48INY8VFp3A+yAFpbPhw3DrUhITW1x?=
 =?us-ascii?Q?cP/eXo3oGIGnOPFRWJ0t7RLfi4c0PE1BcX2K/0YhcFALv1Vx5u/Ulq29d20k?=
 =?us-ascii?Q?zc/Qi85vtz8tZWZwxCXa1h71q2kVs0ApV5HxQBnnirl3zwwIwDSL+WGmIe2O?=
 =?us-ascii?Q?jwhsmaQ+zVrFT0Hr5r/omkRjRyj4jvjWqw2l5e7QwSBAsTVOed6cKaLQIHow?=
 =?us-ascii?Q?634h2pdiCr4ULpX6rVELECFAD6N5mLXVVX9CRBXotWgYjDpkJNm0ZTHQEORU?=
 =?us-ascii?Q?Gsak+/HdUtrKFVogF8tCH/61UpTug52PDiHIKL3g1vjEofmk5Q0vh2qyceae?=
 =?us-ascii?Q?BfQw3ICIp0jGIjx6mkD8007/bQH6kk7MXbf4zgI6NY3klGWfl0b6JLtR2AG3?=
 =?us-ascii?Q?xb84TDontYoPH3L3tyQEsR/RB8om6MVtQqcrdiaCD+yUGggNVOJhmTTHwNlA?=
 =?us-ascii?Q?tkYM1uB1jDSVBemymxVICs+lnDyubBuv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:40:48.4274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50bfbe2-a2e5-4172-5234-08dcb0cf8338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151

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


