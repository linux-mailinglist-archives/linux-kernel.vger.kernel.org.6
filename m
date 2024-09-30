Return-Path: <linux-kernel+bounces-344344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD9D98A887
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67B71F2186A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0240199FD0;
	Mon, 30 Sep 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ht+9iWhg"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B74199FAE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710159; cv=fail; b=sWiGx8kbKU/FHmp6OcIyEXccXorifFIFAEPkNegQdKOmRCC5S0liyfRSS0iw3HKqchIXIbEN95xh3WQIz0aDheOUKugIlUxI/wGVAdNo4sFUnwh54xJWa3AwsDj7Gp8RMgyYzSM3TwnJ7hOalnUUJCvOHsccy8n0IT4gX3ROzh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710159; c=relaxed/simple;
	bh=3jBNdQuOnPDungJ/P9wT4zRL7z3ao26B4dmZqfQJDBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHIPyVNJlYHrqXoRlKLbMAAZmnfT/MQAzq358hF2HSugqojBixzt49REfwEsX8ntb8qheQTtk5+mU9Y2PhYVTSSvdu6QG/9iiaZ9hLyKrxEVSWL7BTKa1TKyG2JNNeXgyI2/Dqn9FJpShwgcuhjOo37E6+SB6fWDJXu4NPZsA2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ht+9iWhg; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYIFUGFTCD1f1j857iOpaKxCkiVnu78XL8R+CFeQgMmYNI90P13YDP35N+ozTdTn3qyjX6uR+ZX1edhcKoynWQN1lQ2P/Nl5pDrXsK18xMp5PVJ0WeAQJLAwm6AFvydHSjim/4/7Hl59DRq3Wl4qeJvBvrRhg13d3oQuXUfNP/6DsPIsCKbFDT0v9mwoAcTFrNj8fX1L2k1FHnCW5YoT9HgLypG5vPYf3UQlDe51lACNWeim1XSoPiwWZT4+1n2Jun2rCicbK5NeR+6Z4CpP3wtNxnabs8bf6FpzWYZDQ2J780ocNo3Fdd1ybO18hnz2gr4Uv91rvGeXzddrJkYTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T6OLVACWHgZ1LYo7hE/mdJpXwj2bJ21of8Mu2wqhdk=;
 b=ZXVuHCC4xB1wv6Y/9MbMUnFmz+aAh4dfqJ4HVUB04BisL77UZgz6c1lVZGjEuMIe/kO0rtA2I+bVNW7gM9lMeSWYY+JjcJNjqLF/+mi9K0Hkqf5d1ArvoeJPdcQCxddkRpwSMRjasVegUzvmydiDNip8Hy3ez7KvcgNDE6+00wwKrH8McGkt3s2LZ2ODk2RU5yUszy3srEUHlAULoFUtS9CRH9gIRXpelrIbxWD7zdd/us2C85gSfG5z6xaofjq8hhq0d2DM1gixuusdRcLO1+9O4bHhW4vZ1ThjljOtPyOzHPkNkc0Yr1GRxP01b4AKIcS9CUewjg94hkYBJZojrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T6OLVACWHgZ1LYo7hE/mdJpXwj2bJ21of8Mu2wqhdk=;
 b=ht+9iWhg9ji8LZV2A+DifyxBaHyN1giyYGiWxR7qIy3iSJmK+ykl685NWwJz4OblgeCqsChNqofBEx8U47T7KChK9pL2xpquxFzgJeddnTVMyc+k/ZqL0YqF1TCiIyO3n58PFbQswxHLWo+khjjKzct43QFtEVGK1wyL9NdvK40=
Received: from PH8PR02CA0022.namprd02.prod.outlook.com (2603:10b6:510:2d0::12)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 15:29:12 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::c5) by PH8PR02CA0022.outlook.office365.com
 (2603:10b6:510:2d0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 15:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 15:29:11 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 10:28:24 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 5/8] x86/sev: Map only the RMP table entries instead of the full RMP range
Date: Mon, 30 Sep 2024 10:22:13 -0500
Message-ID: <89d50ef2f0a9b3eaf4e9c4cf4e0a418f963d92e7.1727709735.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 42571b3b-06cd-4fa5-ffef-08dce164a23f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hfH23/0JrWNgeLXTqcc+8H9x3bMy3M+6H1eqw25qpa7UhEQfyNFqhgq14z2s?=
 =?us-ascii?Q?5M2Wp/Q/DN/ZpUwL7yOEQbF6IzlNo5weB7Du6OMsTWjwvnWBh2+71SznjPat?=
 =?us-ascii?Q?GGyG1q7+sFhqmwP+KG1SgLX7aKV5u35vR1HWOc+oU2rA3bkbgxDoeUNOIaTt?=
 =?us-ascii?Q?Lb2HnSrrZnZXJ41WtldCYWyWH6PpXI/33lnD95xE4Ghp/igXJqxtRJgkSYj3?=
 =?us-ascii?Q?ct6dqKYCzURob8NMUd1Ikfn3ujySkP/WCn8rLIqyd6kpCqeQzKsza6pHfSDs?=
 =?us-ascii?Q?PvpUxtBhCDjHW+sjSbv2dJUxm6chQEYrBSNWJdPhH4vDI3g2KOooicfn/zIR?=
 =?us-ascii?Q?bBEDpb6W+icxZwzQm1iBWoa98VjUfAFFnLPzy2tUJDOiPYasKo3711nbE3VM?=
 =?us-ascii?Q?vRJsKVTtJb8xA+aGxsAp+E0xfUS8GqMSkP3wtEjnTsl0qQ4qH94VwN62IXVt?=
 =?us-ascii?Q?i0m9pZsQcsiMfJWXBWKjS5M7VLRgAqyTrX6FBxl/1Z7UhMwVjlcYhGmcycuH?=
 =?us-ascii?Q?plqYLzn3LddAaR97v90ZSKE+xcY0bdaqvBTF045ny8vTKJIUXTJ6jlalPDhb?=
 =?us-ascii?Q?FyRD3q5LsLJ0O6jZSQneZvvNRMPtx1y6M0b+rUoOd4NLlbQ+BRDWapByjRAA?=
 =?us-ascii?Q?ZQl6g4+9NttUX93ILmotxVOPVa3wAtj7IDCzRS+jITStVZO03rgGLh9kvZDD?=
 =?us-ascii?Q?sw9VP3K2ra5SM8FWdV4uQRSjAybX2muI8u5SbyfEkbA7w9B6sxKMVbvTxvzr?=
 =?us-ascii?Q?IooM75su/XFN+ZiM/BQQ4xqZYLzxKSjUfAvUrB3d1aV6QvMS2nEdVVgO15/U?=
 =?us-ascii?Q?VmNkE3zBvIKk0au+oZUfLGquXpowIhml1o5jNedid/j14iKqDYUOJN9lX5wP?=
 =?us-ascii?Q?5QE1jUBWu/Ndw4RWfWestllkKP5ujp7XegJ4EcmUf77/x0VteYPcLeUNy3o+?=
 =?us-ascii?Q?WwMRpGuv49Qzd/Brvntw1Kv8QghfY282FCRjMHV0jduxGv4lbD+nx6E8c9Gh?=
 =?us-ascii?Q?L6Qp/plJE8OlpYnLlunrAEw28D7gFuAwPWIw1K1iSJx5p4XK2IEh7smBZP33?=
 =?us-ascii?Q?dYIE7jD2355kjtrBirs+/QTCkJDNF4R/WIA/l9SBZCrpEapaqOAFVbMkYxXf?=
 =?us-ascii?Q?ZrBvc8yfc6AcUSQEybnua0447UebGHpVps89lkiyRDvnHHQ7otd5fZkeqOgL?=
 =?us-ascii?Q?feDKlefA31QVIvoH7FpaLcP49CIrmPNiJTJzY0B1XzBMWNnsYkS10NW0h9Zd?=
 =?us-ascii?Q?bNedQRnsyMiJnL4AFGXP+47Mx9CO3FgSYZuDrouJuTNzXZgkbPQHUejBgHTI?=
 =?us-ascii?Q?T+SKUpxbtD3GooH7OWuGUgMItVcj/JL52ISkGUYy2QDVVofRNxGVLWoeNvGQ?=
 =?us-ascii?Q?PX6JNk4F6kh3Bb8vOmCNKzVWPXWs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:29:11.3287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42571b3b-06cd-4fa5-ffef-08dce164a23f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232

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


