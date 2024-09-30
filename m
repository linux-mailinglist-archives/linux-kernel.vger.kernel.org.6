Return-Path: <linux-kernel+bounces-344345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1351398A88C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB691F23342
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E5619A2A2;
	Mon, 30 Sep 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KoU0dHAO"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498D199FBE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710160; cv=fail; b=HUMx3bQ9RsEfLoh9NMRcXZTbHElv8EawUozePzk93vMYnNn1elObw/qThUDz38xp8SRCKeJRNpK7322orHQrrnriRFb8FaAdgguwsLLVd2Aix6076YT9AK7BOMJD5jmD8OgWFTokACusp+CU3ymAEAbib1XUmdCBj3SY72TXmFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710160; c=relaxed/simple;
	bh=2TU800065al9d5LdU/DhO+l5xpjuxhOeAdqh9kUMAJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUBsZH58r2jMUnRBs/tYk059f7+zazgkvVpSK+mARmz+4ZST6lhNEn8BeiB+g9R2UH2V492mK29BGX0HdAXu4zwrbBOdo1XLOdvDDaVpB9ypj0I5U3kmfPm6ZHXpaDONWNSa5Lw+lNZMBKt6wWAH9xjQovo2DUHuZ9/CmmU6XPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KoU0dHAO; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrjO+ozdMfgstsNXtIrPCPFbS2bDh2rOQexDjxEmmquIdv5usdqkC0SMyaWjM+XXIFRNAu0lA+HlrJswVrtXCG+n6umwUntL8RtPhZYw5FpPOCd6Rh3ViZCvOuzzYbvZnXvkwOlPsiyakLgqbUylIn8fL+Nl5sSksoakDlGVPftoFSniwBKNG2K1i5LSp2wjerSPKyUGnHIJ/L68qj1L5sYNnakTQ5hwa0BwjYcA1GlenWC+4jVjkCj/DipFdrxhIMqqJFwNayG66pjb7egk5sh2maBPOb0YB4kjOcazsRrlIeN6b4pUfQjxWWgApK7MCNIlJwaOGBpDQ6+/0zfVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt8Yeb8z/SsOQuSadXc9xRJIX6Pyk98s9HTyjBIzmnM=;
 b=qzVLmICxCQHZRG4XYw8TpBNOa/wr94OJl3DiFfqWyfjbPIZKN2JOh/UCPfc8HRwmKodpJSQZoIjKCOMhJ1HEzgEoOMWYi/3M2mGwXQJwLA11z72rA+bZNQ/hNenM3yGWNRUqmFi28oo2KoRnVBd0/+K4xLdZp25ufRa70gizWXrBYQ2AcMUasPEPwAOdUgt8rp+U9xhQ0bJlUra0CG7LiOoKaIfofA2gV78A5j3pQHINsJ/kNsMXiFUUHr8Hm6MGPjjTxBviRjIID1nxc7g2+nt77991NF0rMtsSCdepSxGFtjpSN/E/OAV/UPIAV5MIwI0POkXwrJzD2UqPIVC5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt8Yeb8z/SsOQuSadXc9xRJIX6Pyk98s9HTyjBIzmnM=;
 b=KoU0dHAOnaXg8QnfFvaRjvGYM887GXks27GABGkS63PMwyg2+XeEi6IXy43xYkAmctrkCTxPNKJG9JH1GhNyeJXpBGfjFXK/NGiRD7eMCLgVFoTleZYlT7bbrYvlg1Dyr9zTMisSqmK4Q+KrRRboF23Rf1qTr01SJbeZ+IzVrUQ=
Received: from DM6PR03CA0059.namprd03.prod.outlook.com (2603:10b6:5:100::36)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 15:29:08 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::f6) by DM6PR03CA0059.outlook.office365.com
 (2603:10b6:5:100::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 15:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 15:29:08 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 10:26:44 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 3/8] x86/sev: Require the RMPREAD instruction after Fam19h
Date: Mon, 30 Sep 2024 10:22:11 -0500
Message-ID: <a8aa2542fb1b65371ca08ce2be40a5179aec6dca.1727709735.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|BL3PR12MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: df619ae2-f90a-43a5-d19e-08dce164a063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c7kNDWZVJbbT8+zko5+HeZ3C3afvW2OR1PkZaJGvGBC7DoTysx5TrJqqgqbw?=
 =?us-ascii?Q?qytxDlVoZ8RKPhaz9Dq9GA5GDmiJyST/j4scnzqOngNLDco4xENInTMpYwi3?=
 =?us-ascii?Q?pUSajAITPl5jLpFYp7Z4drvmMRCKd1PuqBhMwkrs6s31l4tHVdmHIPsNjjHw?=
 =?us-ascii?Q?vBDZSDrVfX2Xxd12sYSBA2odrDrfk+ZTKk21V6iQrjsQ91crQVY5HqpuGro0?=
 =?us-ascii?Q?ehJo8DpvG7uU4+FW57RuhNtPrLPFPyfgHXSSwsO1vJ8rjlfTq4QrScwB9SAE?=
 =?us-ascii?Q?ri+g1f1/LfuDP7kg+UasGKi4Itzf1ig+dp/SmT/Vd79dPjpLLRlJLGfcqoIi?=
 =?us-ascii?Q?mC20X35A3cdAyUC+R/p3A5YcC/iQKlnZsbQROa2BR/MGT8dC0fvsQQXvvLcW?=
 =?us-ascii?Q?I7QQukxzKWGKUpXC267zdgb2kV8OIUEqYn2QP2cZ1h16Q5RLEo3LmWxwLpQj?=
 =?us-ascii?Q?wT9YxHQUbTwVxfgNTWI/k8vttkY5cN975l38CULQo1WsMIhp30q27cpxR2J9?=
 =?us-ascii?Q?4zkfjxS3CAvtUul+v9uq1K+EoasruBaAtak0WHdmy9Xwl9NB9vEVkYp/QF3j?=
 =?us-ascii?Q?4HQJF82LEwdOvSzyIJnam7Aqg+V+l/3N5e5EWHNSYRXAA1oY9EnoBtlO/R1T?=
 =?us-ascii?Q?axm+KH92oqJ7tF0sGucoui/kdiwYB6MxwFsAYHeIjU2AvPMzo61vfzAlgP6d?=
 =?us-ascii?Q?1t3cve2m3xq9TLtS1k7AH0ye/D//qTd4DygrbtnPqje9J4x5K9hLL2sZY/ix?=
 =?us-ascii?Q?HHtZPLyzeHyWhPCoPxHZxVhyxO1E35B5DDZrsXzkG3kR0Av9JU/+OlwOsAzA?=
 =?us-ascii?Q?G2FpjaqbBEe5AIbLbolre7STBEQ1dPX1KGK5yKYXlwWqiVELt+vH62wb9lWi?=
 =?us-ascii?Q?9S62ayKAgL6Xxbkd4eYWE7v/wECAmtAw4ta1GD6CJIoy1G9IH7whOGxAjGTV?=
 =?us-ascii?Q?V2cD7AW+DagPMnuCg9zh0J+4QL1JN4XUuCeB3mvusXjTZ1pMqFf7y7d4UeWU?=
 =?us-ascii?Q?TcJcSXW6W2V0DcyUrET7fGKmVrJhFI1yfXDdstM8W7OSa3q8xUzFqvdzkQoe?=
 =?us-ascii?Q?z/h4OzGcdKJD7NAZPOmFRfeGeY99kNMc7/aM3raxIpoT7e4rlIkoqCunuSE4?=
 =?us-ascii?Q?vUsHWHC1R69WFQbK5TxN4ludxtlLIoandsS15EorsieUvvCiX8udTjGbQu6a?=
 =?us-ascii?Q?Hy1zYBg9SiTqEixkzGOKyBkSHgzHh9vLbH8ya3rTGaOFqJGP+glns1oUlHqb?=
 =?us-ascii?Q?zRvxLuJQb20nJv3ZBKh0dIROEctAiyn0BNcaTPxX0WwcBoUNT84pl1uUDW6q?=
 =?us-ascii?Q?16kn5++9Wj7cs6boM0H6anaoG4kvF86iyV5q5gGdh0CrKNr48g/TEfBu2ErI?=
 =?us-ascii?Q?FMimymBQw8Wc0QH2guzLt2Jdi8+o?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:29:08.1455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df619ae2-f90a-43a5-d19e-08dce164a063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572

Limit usage of the non-architectural RMP format to Fam19h processors.
The RMPREAD instruction, with its architecture defined output, is
available, and should be used, for RMP access beyond Fam19h.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 015971adadfc..ddbb6dd75fb2 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -358,7 +358,8 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
 		 * for which the RMP table entry format is currently defined for.
 		 */
 		if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
-		    c->x86 >= 0x19 && snp_probe_rmptable_info()) {
+		    (c->x86 == 0x19 || cpu_feature_enabled(X86_FEATURE_RMPREAD)) &&
+		    snp_probe_rmptable_info()) {
 			cc_platform_set(CC_ATTR_HOST_SEV_SNP);
 		} else {
 			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
-- 
2.43.2


