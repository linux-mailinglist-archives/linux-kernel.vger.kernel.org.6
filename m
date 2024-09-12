Return-Path: <linux-kernel+bounces-327124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB1697711D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C35E1C2383E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949241C1ABF;
	Thu, 12 Sep 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yinVSogq"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136371C1724
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168160; cv=fail; b=lqfFaiegj6CAMnxKFQlIZDBRInWJnLnvCJ2/sgMxE2AW+aHmz6BT7ZoK88jChJQteky1NvMVGb9pmKBc+JfPiHyxPKBYZZBapqgug94itWRTtGgQFHOzr8ugpD3HivJ6rkLFKNfiZHJzpUDbx/qH+ZqZZO/0vyJVXuCEpHg0uL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168160; c=relaxed/simple;
	bh=RFg/c842V4NKgIhafcrsxW4OY/E4tlnEsEM2d7p3gEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFoifAsPWy8NlPHzIsqc0rWO41ycHZsSUcQfpqNU4Hz1Hc4KTOcw6FHrpB9hpojMrP0n1OS0ytxGiqxXitqhT2U/PnIAqX4upBEGf7XagzoqbP8yZ8JTOaEYQFQr8mEY3HcGH7heHGEthXIXmvYVdQGv6YiXIoOy949YjmUGSy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yinVSogq; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KamXGPfJ5XiwrOhL2ZDxznNBKNizubEESwKPwNnv5VloDYKa194BnVTnLEwpT3kaIJe+Tkd1USUgJ/Kc6s5d88+qMpUkxuxrDL3B8qzJwcstKdwIKhr8Qt7AuTuydegRknO/oDJFJgVEBPHdjy/ekiFURraihJkHcefbiYn80v08AsT9dUKAwEbhlfYrUGYAuXdKsp+FZPsJF1vGMoT3mSAd2R/OqUdAlkgPPpnfs256PvYnZGX6Cs2mTjQrSTtWIV20ZMkXiZmnLP8CnZ7eubnRusYkE0ZOjfzkqFpittiqA0PlBDYsvKk3FoDN2e+Gh30A0tj8sBMWpjtCgRFFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBYmvgdbmZjIYqvMadFMMeEMiruEEyEZrjyEld5POMA=;
 b=YNuiiugFdc74joDRJRyc21+LtcQCiuK7zTUfFDkORqBacNphJA9FloOWR1t/OMFb3QH9CrR4xHYm62FH3oCmbkcypVVd6Z4amNX4m0m5n38ZlGlmtoZJCgoZ7iP4iBhPHMOMV5khM9YEma93FrDnvdwzrA6Jyqc7+SCkh0ppnfK2rhYKhUKpTSanVyiHTobaVa1m+uU1wRtAXyTx40dOq+XFfPxeUmRd+D+R9365ngSN0aVnbIqb7qrKrvxE60q5rASoiI5eoGzcFZAgdsEpdtqeNvb81AucrOiAwegN+00y+ggALcj3iSwBcpJMNWAorCmDO+aEvVOIiQ3ssBKWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBYmvgdbmZjIYqvMadFMMeEMiruEEyEZrjyEld5POMA=;
 b=yinVSogq25D7Co2BD3qiwd26tKgD+cTgKjCIaBq/Ki2lZrYi8edyCmbl1vFMNyB8/dxpgZVTdfiwGIoepi89tgwrB1pEgKtbiKpXkR7mKXYzdiEqxmfw92rBBQmm5W5/nwJBj92ynAyGRa8lFQ+YeeCYPK9RDy2xFPd6AVffwZA=
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Thu, 12 Sep
 2024 19:09:12 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::7) by MW4P222CA0001.outlook.office365.com
 (2603:10b6:303:114::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:12 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:09 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 02/34] x86/bugs: Add AUTO mitigations for mds/taa/mmio/rfds
Date: Thu, 12 Sep 2024 14:08:25 -0500
Message-ID: <20240912190857.235849-3-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 63765c55-a07c-44e9-21d8-08dcd35e6309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MoUAo0qLPGalbOOv2aHuWm1s+J1teb+xBKavxYM0dcJDvQ5XU97Tnw5dXzER?=
 =?us-ascii?Q?Qx3W1CvB1jvbtKGt6lGgoVOqT12jwE21MWqG97zVpqEwBKf/0qzTn4CbAPCN?=
 =?us-ascii?Q?2w1r2O1UTXm9UGRKdMq66yy/T+WKkUoSnjp4mvcNNIvSA3g+yVIA+4sC3IZc?=
 =?us-ascii?Q?IlvsYqgxyuBO3cRNFphDkLtNjE5+I7HgC/UA/90/69h/OqptkqYasbv/lzKV?=
 =?us-ascii?Q?/zI299V+a61r0SRnIX2jQWroEVqaLOAm1AwxVl4Os8ZXUDgcFr1FBS0F+3gM?=
 =?us-ascii?Q?C2lrmA520nztjyQBv8tPghEl/fNeqf4CKY+Zis9KqpYsBypzLDxQ0SZxtVYT?=
 =?us-ascii?Q?DiCwGIu3X2hwKPjupltXolt6i0b5Ct2/z+ZaS1ipdRpKRGVHxP8Z9KyGwxrA?=
 =?us-ascii?Q?FzexsOyhL6rColfCdIApeEJVAdbKKo/SDIOutVrYQ6cchk3TrxKciRqmS9Jm?=
 =?us-ascii?Q?/7hABcV39/LDTCtGr/fAU3H1YajBD/QDsQUaucQBRfHahNucP1Y+Iy8brRGz?=
 =?us-ascii?Q?mX/ax7mGP0nT+iPTbi18xhJHapMChQDpebEhFv6zf+JXtx3fUxKqgDyv/nrm?=
 =?us-ascii?Q?U3XS2rf6CVkgGtAXx6kDcJ9K5Qqxqb4PHUJS03yBMwKoQsYCRg02wf7Vg2+S?=
 =?us-ascii?Q?4fkoa/ZOOXMDjbr6PLO/lio4ZEwEj7MDWW63CsM0vFsrKduPlSlkVERfaQVR?=
 =?us-ascii?Q?BDUdJtZI1lz8IbsbUkJRaPTXnt6k3n3paUgtDK0H4QIRA6+3xoXd8e6WuFyl?=
 =?us-ascii?Q?NnGRSKvJV9VpwrAhf33oAUVtjJ+gj7r96guqnzFerpwJ9zTyIZurDnhapkNP?=
 =?us-ascii?Q?CFQZe6ie7bLhB2Q5Lw//hm6JDsfq+D3Fw0fxjXHtU3hfCjFm+jpkPDobWxCw?=
 =?us-ascii?Q?FlwhmxhLrdoI3GHq09VoDGdPzDzBM0a2GAeIfSGu0fgbctT574gUkD7MIpas?=
 =?us-ascii?Q?jHyA8IpXAPvBtZQzY1c/10Haw74Nw5q2R9APufoXOx7cGBANiyNxl4IPLxBu?=
 =?us-ascii?Q?SUciDALFas6NDGco/uu3CrNEIdjEW6sP0Lxxb73T8GMhGeryIhq/lWiuyYoj?=
 =?us-ascii?Q?Wri3F+DxultnjCOEpZ7sib//r8LFJEF6bYV72Qt5tNKxs6xPATjkUu5dVN3q?=
 =?us-ascii?Q?B8eQjF+LwDk8sEDFqd1dGndczolrifOrWdSp260MpeyeJuZoj90ASpEwyv5g?=
 =?us-ascii?Q?8ikH1tPby/dqxix/v6r+BBuJ5v7QqtmxY1YcMAQYsy1vrzoc4L21Quteo0LF?=
 =?us-ascii?Q?VZNtL0BZzfY+kI+prshHLUCWaudj1OOXkDQb0026EjIis/6R4blqpZC6jhzm?=
 =?us-ascii?Q?K6PXcrtvYwpPuJJLowf0AQNPRYGp9Ii8nOkhhhqI+M+h2TNbWt8rOrX5iN67?=
 =?us-ascii?Q?g7XGPcasyg6aRTLgnr/2NVXtkGv68Q89bqZShoLAp2xIMvNH7zKtms0fNPDN?=
 =?us-ascii?Q?ZCQOqlZ9wEtBwpNco8vtFmbdVQDAdaHu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:12.0134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63765c55-a07c-44e9-21d8-08dcd35e6309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

Add AUTO mitigations for mds/taa/mmio/rfds to create consistent
vulnerability handling.  These AUTO mitigations will be turned into the
appropriate default mitigations in the <vuln>_select_mitigation()
functions.  In a later patch, these will be used with the new attack
vector controls to help select appropriate mitigations.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/bugs.c       | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 399f7d1c4c61..187805f7db3f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -739,6 +739,7 @@ extern enum l1tf_mitigations l1tf_mitigation;
 
 enum mds_mitigations {
 	MDS_MITIGATION_OFF,
+	MDS_MITIGATION_AUTO,
 	MDS_MITIGATION_FULL,
 	MDS_MITIGATION_VMWERV,
 };
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ee89e6676107..1cf5a8edec53 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -234,7 +234,7 @@ static void x86_amd_ssb_disable(void)
 
 /* Default mitigation for MDS-affected CPUs */
 static enum mds_mitigations mds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_FULL : MDS_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_AUTO : MDS_MITIGATION_OFF;
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {
@@ -245,6 +245,7 @@ static const char * const mds_strings[] = {
 
 enum taa_mitigations {
 	TAA_MITIGATION_OFF,
+	TAA_MITIGATION_AUTO,
 	TAA_MITIGATION_UCODE_NEEDED,
 	TAA_MITIGATION_VERW,
 	TAA_MITIGATION_TSX_DISABLED,
@@ -252,27 +253,29 @@ enum taa_mitigations {
 
 /* Default mitigation for TAA-affected CPUs */
 static enum taa_mitigations taa_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_VERW : TAA_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_AUTO : TAA_MITIGATION_OFF;
 
 enum mmio_mitigations {
 	MMIO_MITIGATION_OFF,
+	MMIO_MITIGATION_AUTO,
 	MMIO_MITIGATION_UCODE_NEEDED,
 	MMIO_MITIGATION_VERW,
 };
 
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
 static enum mmio_mitigations mmio_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ? MMIO_MITIGATION_VERW : MMIO_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ?	MMIO_MITIGATION_AUTO : MMIO_MITIGATION_OFF;
 
 enum rfds_mitigations {
 	RFDS_MITIGATION_OFF,
+	RFDS_MITIGATION_AUTO,
 	RFDS_MITIGATION_VERW,
 	RFDS_MITIGATION_UCODE_NEEDED,
 };
 
 /* Default mitigation for Register File Data Sampling */
 static enum rfds_mitigations rfds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_VERW : RFDS_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_AUTO : RFDS_MITIGATION_OFF;
 
 static void __init mds_select_mitigation(void)
 {
@@ -281,6 +284,9 @@ static void __init mds_select_mitigation(void)
 		return;
 	}
 
+	if (mds_mitigation == MDS_MITIGATION_AUTO)
+		mds_mitigation = MDS_MITIGATION_FULL;
+
 	if (mds_mitigation == MDS_MITIGATION_FULL) {
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
 			mds_mitigation = MDS_MITIGATION_VMWERV;
@@ -1965,6 +1971,7 @@ void cpu_bugs_smt_update(void)
 		update_mds_branch_idle();
 		break;
 	case MDS_MITIGATION_OFF:
+	case MDS_MITIGATION_AUTO:
 		break;
 	}
 
@@ -1976,6 +1983,7 @@ void cpu_bugs_smt_update(void)
 		break;
 	case TAA_MITIGATION_TSX_DISABLED:
 	case TAA_MITIGATION_OFF:
+	case TAA_MITIGATION_AUTO:
 		break;
 	}
 
@@ -1986,6 +1994,7 @@ void cpu_bugs_smt_update(void)
 			pr_warn_once(MMIO_MSG_SMT);
 		break;
 	case MMIO_MITIGATION_OFF:
+	case MMIO_MITIGATION_AUTO:
 		break;
 	}
 
-- 
2.34.1


