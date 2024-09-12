Return-Path: <linux-kernel+bounces-327127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E05977120
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6721C23852
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C13B1C232B;
	Thu, 12 Sep 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i8i2wMUW"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC501C1AA3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168163; cv=fail; b=LACap1CwPQJ/q4uotJf5LamLbUgIbrIbO9GVMKqeUkjCqQBlOi//cScBOgiaOCbjaiuz/WpF6kTVpvNdbenex3SaH/Egi2YyjYNg+yxieOtfIbsSKMGYrF71IIOwjAmDr+pr2YLJyEU4fzpXolXggrm94H5zqrSI2KipjWjcEsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168163; c=relaxed/simple;
	bh=vLPITijN2cQ7t37rG6+3aq+kdur1hgefHiLuu0kUOXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWCi3en0Mk16bZWWb6tCFKja5leQJMeiARCjgFx/NyHl0AFT7hJzM8RS9uNomYYJbKve+tWNoeTjPs9NH0l7TJt+vQG0e5Xgbch+pIGs94jQuYxsH2M0kQDPdxM9Bw3KJahSxsvTe7ucR5qzrTYBlgxWhuNMsmb7xlHbm79/4ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i8i2wMUW; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbRsc8i00u8ajcYhskw7MVpXhjr+XdpIegz6EF2xjl8IpWKgLBWTBX0P6CiLWMw9HSxobfb1pBMvO1Gcmy48yicJveBBBsNawWRx2/M8YxtbIUA58bw42mbRyMZaiS936L4EMJbQWkqtFemChXIBD7XBM7vPRmOclaqDSCENkROarJkMazvbBVPuiCQdE1yKZelj4QFsFp9SBWPXDhgkwo/GXiIg7rTc1AXHvgdrs6udVHyHOZrQhqeo1aWIksihucO8TKv8wOH/89ycPrVjKL8dtP7UAvQye9ZgGRTeswJyvHcX1R5vWaDM1wOxfpKjWWerjyMIQXdvYuDM+OP1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGhcbBnModAkL2Cb248Vafy9TcThihHbMkSgc8sJEEQ=;
 b=AtaeJDwOTMi60+XE/70Q4J0TCIjHbZjvawyCJuh5Jrgb7cx+JfTxbLpIGZYZmOgVPHB+cJymN5DK9OrfScgv0KepZRusCAOPEZbnr3P5d//l8d7TP2rfDa8ZGbI7AKzYV1RwPni5IPcPYbP/vQAcgQ4cbF/vy+MRVhcmNTloHMuyokbnR9m0/n8FOhGbk79TQro9TOZkS0qyHg8pHRWA3ctCFcP0XbcuagbrTuBGO2t9pnUKEQzEkhYsO66s/mYEp/pvJrdhMDJ0uYN1mGWfOEVSwFpFLjOEWom+chix13B+Q92WBto6+zFB466KCYp3ccKTX5d35xWbQ50eTikuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGhcbBnModAkL2Cb248Vafy9TcThihHbMkSgc8sJEEQ=;
 b=i8i2wMUWrpoSHd2J/gzdg3hzjBnAaZyJA8qeW0GvbnCQLkNDl5HRW2bK7Aq8AAlsBFW/asoOl2r2I7hrNQ6QElGea1EH+dMtRw7+XODm5WmW7i71pRZuGaibhDQgPChWsSPcaKn9mfvI4kZbXRCbR/SUoOqEebJnnFwlPdVRQ/s=
Received: from MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::19)
 by PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 12 Sep
 2024 19:09:17 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::fa) by MW4P222CA0014.outlook.office365.com
 (2603:10b6:303:114::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:17 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:12 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 08/34] x86/bugs: Restructure srbds mitigation
Date: Thu, 12 Sep 2024 14:08:31 -0500
Message-ID: <20240912190857.235849-9-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912190857.235849-1-david.kaplan@amd.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d73dfe9-e3b0-4dab-d85b-08dcd35e6608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D71GkIvHp9X0zKrlT0Q8qvjPDn03MHsvU7mR900PxNLPT+X4kPdObzlNr11z?=
 =?us-ascii?Q?rd2MbuxcBRJLXxzuz7zbcMqkHOHBRr49n2b+OK0fe0+kc7HVavisCSCUeR47?=
 =?us-ascii?Q?GJYvQxxUqfbf42H+8kSrsgC8zzH2UXLQTYOQbMIKlCv+1WRigtlg2OwVPKVH?=
 =?us-ascii?Q?D6rV/LyiUxL/+e6KZDwrZvjsZD3J1y3JIeKR9/NtP89BqSFPQ8sPdWOEz+bb?=
 =?us-ascii?Q?pv4PlVPKXSSwdHInTLK3A9h/1h5Ie0BH+mxWcE/ca8fgxSNRL9OASpyZiHMf?=
 =?us-ascii?Q?szMZPx6jYUhYt8USHtrFukr1Rf3OmspYM/k6HQgR5LE5sfiPU93ArqEiV/u4?=
 =?us-ascii?Q?owBl0lqmRikpRj4YFEFWoiPX3v1URwDdvrAbItF4ZZmhmcx+suPfEdCly5HH?=
 =?us-ascii?Q?Tny+LKGKGuk29tUq8uBablS5z4ax3QnzCDVx7vQBY4NKmvmX/2czmnLkQ5tE?=
 =?us-ascii?Q?u0zBhkxzP7f5WC/R9JnKQW7uhPJ9eri9AUe5WvTwzA6bVugrH11GIFjAgvTB?=
 =?us-ascii?Q?fGaLtV2+yaWE9sXV90pyLPWqhQ7rI3aGDZ4bDUU/vMbQsdibKhGVRYNUpzDR?=
 =?us-ascii?Q?OJ1GHUIjWOXryXxg9i+EH4b5M9GMTPOe0nzlq522yU6lMvk3LnNUOfHQMZaN?=
 =?us-ascii?Q?z8Sa4KFBCQ16sO4JZJVDwIjOwbLbt5+Aahi8hDCQJeR3a5w7UoY0nV/xJqoo?=
 =?us-ascii?Q?E5DSpWNNL8BjTKP+iQisMkNS+CiFHc8KVPKHHvVBGsfeo8K3vjCJUYc61JU7?=
 =?us-ascii?Q?pYulEqG00KOWasNL2Gwc6JUPrZ5e4WQcl+hORO9ydfMMbTVvq57Kiei7qEmJ?=
 =?us-ascii?Q?OWI7LIdJME2zWKipHlh8GoS4YnvXA7EZkBwOVNNohsgmdsf+zUqQUWKgXH0B?=
 =?us-ascii?Q?tcNZIJUOZfyP8fymaR9V9R8pxKcp8xiFpOssiuJqEqWCF159k3D4Tj5PO4q6?=
 =?us-ascii?Q?3MQvKUpIwttoN/dOKSFmkuHm873TB1H8xHgHbaguGJmM5IigXhogIs7LFHzi?=
 =?us-ascii?Q?WzH1mVDZbtIl41LilxOT2c6bq/vP1Fh4USmyjqaOupwGKpVaXdsQeisYRSRd?=
 =?us-ascii?Q?3HGK24JeydPNInrmqjxBsQ35s58sBZOjazAm4Hdy09c7wPmqfu9gMkD0VTsf?=
 =?us-ascii?Q?eP3wqfuLt6VE2HCbDIKuubq53bJXWXpkNbBatMOqGSEA2+KygV7Wf3CG9PQv?=
 =?us-ascii?Q?EJVP4PkPufrf+WCwA4yRDyHr22wflioHdhXIpGQa0FI+viJcIoaDA2e9H+Ti?=
 =?us-ascii?Q?c5GgpmHjrpn3EDHeLYV5JWz82CaZOZZTzjqe8GBW7qdWlfUkzL63SIvP8GIs?=
 =?us-ascii?Q?xB8CYq6NXZzIeGImH4d0tpgKt9840aACMbmNP8Qpybk3HJTOOPq0YtZRUcb7?=
 =?us-ascii?Q?AtP6RJ3vUhBuP9Kann+a+cDCvwKjr+YM4LHSAI+emWD+bHQrVjfg/hIQWUpE?=
 =?us-ascii?Q?eHTwaA2iofMpgAoLYjw0QksjCzrBbLNX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:17.0447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d73dfe9-e3b0-4dab-d85b-08dcd35e6608
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067

Restructure srbds to use select/apply functions to create consistent
vulnerability handling.

Define new AUTO mitigation for SRBDS.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index df41572c5d10..0fb97b94f5b9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -72,6 +72,7 @@ static void __init rfds_select_mitigation(void);
 static void __init rfds_update_mitigation(void);
 static void __init rfds_apply_mitigation(void);
 static void __init srbds_select_mitigation(void);
+static void __init srbds_apply_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
@@ -218,6 +219,7 @@ void __init cpu_select_mitigations(void)
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
 	rfds_apply_mitigation();
+	srbds_apply_mitigation();
 }
 
 /*
@@ -663,6 +665,7 @@ early_param("reg_file_data_sampling", rfds_parse_cmdline);
 
 enum srbds_mitigations {
 	SRBDS_MITIGATION_OFF,
+	SRBDS_MITIGATION_AUTO,
 	SRBDS_MITIGATION_UCODE_NEEDED,
 	SRBDS_MITIGATION_FULL,
 	SRBDS_MITIGATION_TSX_OFF,
@@ -670,7 +673,7 @@ enum srbds_mitigations {
 };
 
 static enum srbds_mitigations srbds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_FULL : SRBDS_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_AUTO : SRBDS_MITIGATION_OFF;
 
 static const char * const srbds_strings[] = {
 	[SRBDS_MITIGATION_OFF]		= "Vulnerable",
@@ -724,6 +727,9 @@ static void __init srbds_select_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
 		return;
 
+	if (srbds_mitigation == SRBDS_MITIGATION_AUTO)
+		srbds_mitigation = SRBDS_MITIGATION_FULL;
+
 	/*
 	 * Check to see if this is one of the MDS_NO systems supporting TSX that
 	 * are only exposed to SRBDS when TSX is enabled or when CPU is affected
@@ -738,6 +744,12 @@ static void __init srbds_select_mitigation(void)
 		srbds_mitigation = SRBDS_MITIGATION_UCODE_NEEDED;
 	else if (cpu_mitigations_off() || srbds_off)
 		srbds_mitigation = SRBDS_MITIGATION_OFF;
+}
+
+static void __init srbds_apply_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
+		return;
 
 	update_srbds_msr();
 	pr_info("%s\n", srbds_strings[srbds_mitigation]);
-- 
2.34.1


