Return-Path: <linux-kernel+bounces-397192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022219BD7DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C4C1C22BDE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60271216447;
	Tue,  5 Nov 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KMUn443T"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26EC21620F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843730; cv=fail; b=riKBZB/7qXrssrWHW01s7R7JvAyEhdlEiXLgwDYhqXXZ67L/XENjbV3jNFWfg4CAn6u/QQrgn+Efl67E5ISMrC1xHAiNd2o3XpTYYbygWPIZmez2mNnxWlvE/eESDRtAoThndCFYRBUocngDHQv++L1NIIcdoAXUwYHxAhvMVGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843730; c=relaxed/simple;
	bh=stzJGOD1DUzUnvLSXvQvWQ9zkt8aQ01l/rcB7XhX+9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fU5eveYTVFcSMoblbw7nEw5b3l3epzOe+gCMqGyKTIns5hahEpyiw0/lGsyihs/ujCxLCFupOzjATFtZFZgBUdfWyrogg6gjfEu3riBylLpswAY1wCPtcIGm1uS0P+GtY84zq/Mas51dLgf1U33BHtwVFxNmhCBPuLEWksJ2Ths=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KMUn443T; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfgX+86+Yk2SMsAMZF/F0zO3bOcUjPDPHHdhX4A5GCubrUjZYMOUO2zScG/ujKCuEQ+05MH3+jh80w0N9HenSvEDAH53itb0LxjAc7zemg1xutbWqeSIqJWTuQruH8feWkmWFII3ct9v78qsi2wcOu9DgEZXmIzXAjTVaz0f3fJu1A+lTcmyG1Ut132HdFqLrE5ajHsmuWSSgcj5tik6HDo4LTMmV63PUE0i22A6Ai7PwaxPwC5kYZRKhbqUtwgfJXb9yQ/HouIo53NP15LI3556YZbOnmRpXAWyI2ULs0ElD7ENr8NTpolYncAyq4w/Qo/TM9q4CALIzUEyDdxxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5b0UVVMA5guHEkx0QX4JBfc4jbRQb75STDHtAbblXWo=;
 b=V0u0tO6qdYbuZhF1DEi8y7G5SFbOUxfC31lg86J59HZsw2R791bJcIQLRg0OF6gQnO+WmBE4EKr46JpFDvLzuVL95DRjPDCULftavAZmAG4OBHPGbXkivBu4y0okYl+3lUxuOUCsEoYUF0sBRY2XWzomtayOETUCKhkmHUY3qUlQqx/eHkhEY6FccYqBBkj7gdfibTAbFMRxv7CARqjV764Z3yylRTiVgWvmUC/4LaQaWBUg7UJ0WiACO3t06JafL+XXpAzPyouETiFZY+VSREsIC8R89+UWqrk27+tTG0Ib8DN7etnDPEUMtFpFU4wFoREzgYciQXYu8O2N5GIYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5b0UVVMA5guHEkx0QX4JBfc4jbRQb75STDHtAbblXWo=;
 b=KMUn443TVtONA2kPqFXT0f8R9rF8rhA84sehQkFg7pxCmr2U8iMawP8WrO5b+Jw+ttlnxyduX0iSBxwXRrtStMCA2NutKvs/+6C2jetfmkj3yva73Jl5u1y+Yn6Ca/5A186+H1uxsRvOjUCX0j7AVkUkYXKnFfFBPKl9+g8Sx3M=
Received: from MN2PR15CA0060.namprd15.prod.outlook.com (2603:10b6:208:237::29)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Tue, 5 Nov
 2024 21:55:24 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::d3) by MN2PR15CA0060.outlook.office365.com
 (2603:10b6:208:237::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:23 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:22 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/35] x86/bugs: Relocate mds/taa/mmio/rfds defines
Date: Tue, 5 Nov 2024 15:54:22 -0600
Message-ID: <20241105215455.359471-3-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105215455.359471-1-david.kaplan@amd.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efeb154-e726-43fc-d94d-08dcfde48c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d0ImaNhtdWG2QXfFKJVqzZlYTVDWFFzoTZ4RiLn96OoIyCw43hWmisaHAKvY?=
 =?us-ascii?Q?3iqsumSEpb6FIe4PLIGjOa99oTI/fvoO/eVscpwAE45GtZq0YMa2gz2JeoNc?=
 =?us-ascii?Q?GwsNeD0fEVBe0Tv8rxRKTm8q8ge/dr5OMFcEW2ESy1MYDtCqSJRXum1QPR5t?=
 =?us-ascii?Q?Qz84QjTzioL13+82G6aiYkQfNOTl78ioeozV/UOM52GCacIhgnLQd4lGiVCc?=
 =?us-ascii?Q?HJCJZRmKrPyfWrxCBdmZz2f3RVfr+fym+rww7dwvbbXxLajLAOPr5Y6bchg5?=
 =?us-ascii?Q?RktzwTNVXgaeMMU1CQrEUGVhvlvK4OQzFnlvMGpLR1cjsb1hQbkGMzztzElk?=
 =?us-ascii?Q?8HQim9wl+dG87u2X5ye4VTvpr5ASAlBz5v3Yj+5nJ3C6sB7TEZiTRB0S/y0w?=
 =?us-ascii?Q?nyWL+5PyWaOWB4ujSUtR/zbY0+i8q+lVqBzLRerlrfrDthwIL329EwD8MQRq?=
 =?us-ascii?Q?FrbsyVswiluaaIdu9JZrAaHS0D7M2KkyTV5gw/3xS1In/jkN7lCK0YDUZzQe?=
 =?us-ascii?Q?FqzTVdO5TrqcA3oaeMmZslobl9QKkRnd+o+z6lZbXU6Vh/lYjP52XgxByr8P?=
 =?us-ascii?Q?Tr1DecNQGfKYORzcReDjDqt6Ftn4ybeMXDNYaFPU8rLsKQFYrTQKaDGU7vzH?=
 =?us-ascii?Q?MfeIvJvrsWZCEhhMhzGPGc/DgRliESW3Bbc3RMx1ACAIXHav0/0Cxzh7WMTF?=
 =?us-ascii?Q?0yOtaXzofRzYsLv1gQrOkHdXy5c+cjckijmjUoiV42MofJc10Sn4GmCinSrD?=
 =?us-ascii?Q?FmgtR0OH3Mk8BMOMHvU40IKLiRvL8ZKJqDAaG49Bhghd1x5nvT3TKuJko3TW?=
 =?us-ascii?Q?sY/IDeSaEQtOhaOXtPLvnfxhQfyRS+lnCaBWLR/qZqhH7bZrAg+ZzOTkNFfI?=
 =?us-ascii?Q?PAwSJhO74nHz2HdM5DHYzIPPO72vdbMpsAxM3wmF0fEzdWOJFimYMKtIvhZ1?=
 =?us-ascii?Q?Zh+z+VNTFzFDrMm23ThiEvrxw71M5VO4oLJEpi7S2GhRpzjedVkV0+PNqGf+?=
 =?us-ascii?Q?PwSqZSUCcTJDRR25jj1LXQthIhsa5Y1qZJSWj3Of/fUrs/GUkLnjVS8OzEuZ?=
 =?us-ascii?Q?18Z37qnPPytDSzLRybAdRCIH1NLLtl0hEhK2M+v9zIUrELWYMS505LOZn2pf?=
 =?us-ascii?Q?rrXYlowxQQkCW+vFuruNHlwPk/fcVmttGCQvqAHVbHrtI0kPITJgpSExWecy?=
 =?us-ascii?Q?8fkwv/xePceODWQ96zdF8Bia+Xd9grxD6qWZ2YR073MZpazELbx1HTSyHjot?=
 =?us-ascii?Q?C/IYHL+636LZcXNn3q3CsgVpaLcYgHit5LZE1snhOkQVP8Ja6cTtbSZpKYHQ?=
 =?us-ascii?Q?e3Zx1zGlLNY7bnHvneIpKjScDjq8i+Y8BAbl1KH67VpSZesaRuANQIc8pXZo?=
 =?us-ascii?Q?1ObO/9haHgKzFKrhAiez03UIJEu8JhII8wSNea6oHeHb0R3mXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:23.2340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efeb154-e726-43fc-d94d-08dcfde48c98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

Move the mds, taa, mmio, and rfds mitigation enums earlier in the file
to prepare for restructuring of these mitigations as they are all
inter-related.

No functional change.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 60 ++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 83b34a522dd7..3fd7a2ce11b5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -243,6 +243,37 @@ static const char * const mds_strings[] = {
 	[MDS_MITIGATION_VMWERV]	= "Vulnerable: Clear CPU buffers attempted, no microcode",
 };
 
+enum taa_mitigations {
+	TAA_MITIGATION_OFF,
+	TAA_MITIGATION_UCODE_NEEDED,
+	TAA_MITIGATION_VERW,
+	TAA_MITIGATION_TSX_DISABLED,
+};
+
+/* Default mitigation for TAA-affected CPUs */
+static enum taa_mitigations taa_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_VERW : TAA_MITIGATION_OFF;
+
+enum mmio_mitigations {
+	MMIO_MITIGATION_OFF,
+	MMIO_MITIGATION_UCODE_NEEDED,
+	MMIO_MITIGATION_VERW,
+};
+
+/* Default mitigation for Processor MMIO Stale Data vulnerabilities */
+static enum mmio_mitigations mmio_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ? MMIO_MITIGATION_VERW : MMIO_MITIGATION_OFF;
+
+enum rfds_mitigations {
+	RFDS_MITIGATION_OFF,
+	RFDS_MITIGATION_VERW,
+	RFDS_MITIGATION_UCODE_NEEDED,
+};
+
+/* Default mitigation for Register File Data Sampling */
+static enum rfds_mitigations rfds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_VERW : RFDS_MITIGATION_OFF;
+
 static void __init mds_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
@@ -286,16 +317,6 @@ early_param("mds", mds_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"TAA: " fmt
 
-enum taa_mitigations {
-	TAA_MITIGATION_OFF,
-	TAA_MITIGATION_UCODE_NEEDED,
-	TAA_MITIGATION_VERW,
-	TAA_MITIGATION_TSX_DISABLED,
-};
-
-/* Default mitigation for TAA-affected CPUs */
-static enum taa_mitigations taa_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_VERW : TAA_MITIGATION_OFF;
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
@@ -386,15 +407,6 @@ early_param("tsx_async_abort", tsx_async_abort_parse_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"MMIO Stale Data: " fmt
 
-enum mmio_mitigations {
-	MMIO_MITIGATION_OFF,
-	MMIO_MITIGATION_UCODE_NEEDED,
-	MMIO_MITIGATION_VERW,
-};
-
-/* Default mitigation for Processor MMIO Stale Data vulnerabilities */
-static enum mmio_mitigations mmio_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ? MMIO_MITIGATION_VERW : MMIO_MITIGATION_OFF;
 static bool mmio_nosmt __ro_after_init = false;
 
 static const char * const mmio_strings[] = {
@@ -483,16 +495,6 @@ early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"Register File Data Sampling: " fmt
 
-enum rfds_mitigations {
-	RFDS_MITIGATION_OFF,
-	RFDS_MITIGATION_VERW,
-	RFDS_MITIGATION_UCODE_NEEDED,
-};
-
-/* Default mitigation for Register File Data Sampling */
-static enum rfds_mitigations rfds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_VERW : RFDS_MITIGATION_OFF;
-
 static const char * const rfds_strings[] = {
 	[RFDS_MITIGATION_OFF]			= "Vulnerable",
 	[RFDS_MITIGATION_VERW]			= "Mitigation: Clear Register File",
-- 
2.34.1


