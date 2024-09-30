Return-Path: <linux-kernel+bounces-344343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301C198A889
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088CD281A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA75199FAC;
	Mon, 30 Sep 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g8jvLFnL"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BF199EBB
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710156; cv=fail; b=kGh7V7WTKlfVKJyxWfi0RghhR5VAk+skgYjwxhN6hhMsZqexXRLAHqp5tp9ZravFJPkhwcz8kIY7a7AzPkQguM9IPq+7T9LuOA1CtLzqXGTANfWtt/UOi81T1ut+hGvZ4CTWAYn0xcgeKmWabKVxD7ztPtE+YYxx2Qf3WcYY+uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710156; c=relaxed/simple;
	bh=kBmG3oyaXCc7Kdk1lVEAUJZNeYXEr1v6wmYTK1d50qA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbI4+hh+GJtcoFZXh0gawi7W20pOCbf+NyGQuk3XnJKtFtvD+kwOK7ZGv+3yviSuS72cVrRqRouB3Q3ftnD8Zv/MXFh1SUQQUSJEQ/CNXuCXO6plwYEb8DH3yA+QW5HaiBGhg06o4+l3h4sQhzJjRLdDICs5tscO5qtn8wS5D98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g8jvLFnL; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umXT5Y9URXTT2b/iK4UlQNRVhWc/tldxda3iSgV9UIHOHmBtfGWk/9G5HEXL+zKoDRqrd9EtokkUXW63DyTJ4q29kvNtUCvkWK9LnSkQ61xN6AYvwdcdLA3HBjpODMoR/UyT9YWfphCVz5VrNeY3nsd3M+y8tvhqNg4D8+C2uOkBlsITlNbds6/d+XNINWsoKm3nLkWro2socgMt31PUjiBi6NVfqiK8Wmg/Bqf0qr55KGorI4F8YJ02RUL/h9w79X9UM+hCUTBWoimaRM/qtWaCV0ohT3PUymx2NP1Xr+jDxRe/HOuxVvg5V/0HfCMAtusEHT0DYbt7x4LisRyJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYKyywUZaArWrHpIgzRuN7q5CmO5o9ImOE065iL1XyQ=;
 b=dbXfuw/FCWJAvZ+FeVFuVvfZg/877KKDEuWOx2SUgdNnAmhFJ/xylRWdibjWTRbxI0SK+q8PUitjpRbdIhH1mJl6dWrjNtIZ8tKOurMSD19uGTnyIBx+F2RIYqFpcIncs9xUT8lqBmU3aOB2UxIxwfLiyPh/8purFltn1Gf3NksdqC70r4lijaET9oTa8EbU2ZxMbkhOsqAsnP156WSqaXudwOT6eg8uJj7r/VYK7rveBAYt0ZQubUB8qU7CNAPc0rmwhncd4tPeL6+hpf0gUxUp6M0TfHHP9Fc8q738GTnDYuuMNlzL5YoRmF1tdxPj0z4XEOSLesyYlt2JksxcTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYKyywUZaArWrHpIgzRuN7q5CmO5o9ImOE065iL1XyQ=;
 b=g8jvLFnLr8qI2kDOor2MhUoeUV53tJrMkrlxH02+rwEh8J0VC4Yazr2t66pevuCb1xCSTkuSYnUJAL3v6PUYTXIYssmJ1T4+54UpgDuUAa54l1LQgmOP68cG/H6jexgC4GqSrTRxlOSc5fsltSbdkE/PXwhB32ueLEvpIg0HmOo=
Received: from PH7P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::9)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 15:29:11 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::a3) by PH7P220CA0017.outlook.office365.com
 (2603:10b6:510:326::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 15:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 15:29:10 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 10:27:56 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 4/8] x86/sev: Move the SNP probe routine out of the way
Date: Mon, 30 Sep 2024 10:22:12 -0500
Message-ID: <e5f2f8249a6fefefdf4930ad21c48a9a768f50af.1727709735.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f14259f-6ad1-4c7b-ed30-08dce164a1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gf3drBF+U2r4cIaFBmrFhxGEV+eUC47/uTdDgPEqUQDFu2fdw5rbmf3HYBU2?=
 =?us-ascii?Q?X27eGp3LPZRQj7NfoCKyKoSKsMbTnd7ZskugoRVauPn5W65DMqgSCxJwPYAC?=
 =?us-ascii?Q?7Ydh0VluuRdDUa4HnrzLZKWRmeCoOR3ZA1BA3BGJem3nzsZM2SMSGPyu4iw5?=
 =?us-ascii?Q?xvKbGGttsYWx4i8Chp6oqPR8Krzm/2/F6Sqr9yHThA7ze+HXGIhclB9XngM4?=
 =?us-ascii?Q?+yG28h5Tde8WrXVnCZmueXAYc9O3+kpeqYjtrdrw7rnt7Lxdd4fZEoKnK2ut?=
 =?us-ascii?Q?UHWNibdqrTec/Kfb2HJb21xBX4LUU6/IbAdilRlR/43kcAZhyNMepQ0VhL7q?=
 =?us-ascii?Q?8TUxmxk5oHLmTOfxkrYFdaLpVwoBv8xT2uuSdgIHpUbLVl/ebYvoh2xdNDr2?=
 =?us-ascii?Q?eyq9BRm3bDR6DCupaArBW/+DsM2SVq0tTuPx4Mua6fQ3SyYKix7FAFTZyr3H?=
 =?us-ascii?Q?owT90qt6H3eJ+wvRr+XNJuPNyXBlfLdZVZOH0rUHGdaYZ1fbgNDybX9CZ5+k?=
 =?us-ascii?Q?riATssoRNfAzSutFT1t5jryIhnM1d0fzgQhTd6neaCdE0FKB8av5qXmzxC26?=
 =?us-ascii?Q?97Y+caAW4uL7sUYK8yzJF4fduhlEw8wAaTPT8W6zhKbM9f5aaOp3D2eo9MW4?=
 =?us-ascii?Q?xToBN6v6rEBE30KWV64XJWNeRihw9apg2NthcGVaJ2KemiY+F9JDuDKGUejJ?=
 =?us-ascii?Q?xrJp6/7jR4Wj7KTOzNNMqS/EySEcvTGQQyZtborXWrKAacgnjaVw307YcCTr?=
 =?us-ascii?Q?1bsQmPS4Ia61vAd7p9/SIVqq+Wkhkp/MbJ6FBoHZtCyLrllcZVrcSMH0YzNe?=
 =?us-ascii?Q?mY12jBSoSmXXMNcAqQ6FKj3hbNK8EJVBZk9OZn0opN6Zj2cydOi8WuqRZ0Kw?=
 =?us-ascii?Q?/dIvUGZTwMtrcDNUn/lKeXeFgn6Feec59i0s3YQYdnqL5VpU2u+I7EJPIbq3?=
 =?us-ascii?Q?Etz+1o6XiEuRpGskYvfMTCIi9pL0vUm889LbPfeApmO6XYvO/cDHONed0zBw?=
 =?us-ascii?Q?QB0X7Ilv13Aa8FLh3GL5iPlx/CE64jwAHeeB+K31UBGrnKPlcD66R8Qx5vgp?=
 =?us-ascii?Q?GX5VJE23HBybAbChWKa6wkF4jefYIo8P22y/e41xJ8SprHiF1CLMHdqUTSqU?=
 =?us-ascii?Q?tUWXUP3StNKg2FMEkom+LCJqMcgub3vWWyJfxUOJimppKpBfVhgT0LoQYdXI?=
 =?us-ascii?Q?fLo6gmFXCalVkWDHIa9SfpdT7aEz4cp7mrV15VGWKCtV/VHfGI/xKibJtSRE?=
 =?us-ascii?Q?FDDUwLvZS/wh97jQF8JcdJTOJnFzFcGlUostIaCGWKOoobIbVfyK/w5xuIFO?=
 =?us-ascii?Q?WrIytF/rx9lM0ZzpdjQNAABdQpJZ9NTDWZMOgOYzZUmTM9zdeBvY5gKCq+bK?=
 =?us-ascii?Q?idMGVXL0M6fE81VnxRzZfQV75b3VbvzKlIIIHzR/LPZYfrJ6etZ4I4jUxU5I?=
 =?us-ascii?Q?RhrQh3hYkZ12uC/UkoT8tRXF1L4VMgNL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:29:10.8760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f14259f-6ad1-4c7b-ed30-08dce164a1fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

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


