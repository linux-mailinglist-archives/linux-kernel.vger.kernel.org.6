Return-Path: <linux-kernel+bounces-397196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373239BD7E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FF31C22B49
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6555216A35;
	Tue,  5 Nov 2024 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0MNJO3ZN"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2CF216431
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843732; cv=fail; b=RvF/paXQICIdjzgnwwYv14yPbcUjE3t7WeELSgDSYnYSEmOqE+JAXE4eOZg77RY1/kosgy/pAz7kV7ckfodEJc3OQff0mQCdbnIhdVXZmGtqDO6vbFP8/Qn18LpGIceyyv9teNoV9Jqw+ymR9bCwLzKQ0WnjetdiQKZBQdSyEEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843732; c=relaxed/simple;
	bh=hzdM3r8tKeVAVGZxO73I14Z7J5Jrr17k6PP5Aem7E0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCva/AC9OFFJ7T/tNH4SewP7qlbG/kfVsrjrgVWh71SQCFSOI+MG93SWhXE1FgfuZ7LJzncX8XswbkC7TNwS656aeOEVTXbPXS8HojbIT4pMNP/udsePGdlQRqcEoDk1DMTK7c1Fg2CmlatwzXHV6bT53/P+mbILGPrDBJnhVgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0MNJO3ZN; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCRk7+Fu/N3LI52hpMFYAR9XBaXyQE6WxgvX+c2S7YLVjkk5vIVrV+iLI5rTB71Z2nyt+mG2TwUYCR5f2A3ILUAAix4eP66aBwlw+Wai7wNcaxk2BQ8neN5jiHB7yhZpuXBgve4+uEko5bsPbpHQLrJ8l8qNUZ5XhkOyXDowtiCDI4qQ/h9fTQaSyWJ9Tantw1G7NWdOEEYgw7S4HuBpZbZ8Z68vZdllaD4mshtJcOw4E2KyfMTDaOn9cRHLtxRyKZNchSeApD3wrxv9+lUruczyWJfjRACZMcd7Ue/FAticKY2B+PdP2x1dC2qBI5MRpthbCdR7WmhGJWW8gh1wPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUr9t7yvYrfhI81zmh4CJULVH6YkJaiubo0NObv+HPs=;
 b=SseKQglyVBsfzhN6q55sQ63Ws4v3xBiWpAFMyJ2uRg43Xfac0wzsx+Kf06z1soYEk2jhPoZRpVew44Dy9eRjXWwyXwqIKjEtykDZcwTkbjO1DP8bsrnLg8a8uve8VRqKuriIvrvePJjWB5rU+knyDX+ANvlKN9Vq59duDtaxRuap72hBmi9KfM6/OoV6pqn53sasTT6+Wj+taSpjquxZhddPl7ZmY7MjJC3rvNOg0xuAoE5KSxr/2hv3V2v6as1pyZz2NYCXB1HR8VFC3S6xvR1i5iqH8XgYCVSpXKADyHeGZ7IPfWWP2zFmL0o4/+lUTPoCkbFbtDdlJK1gI4IA7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUr9t7yvYrfhI81zmh4CJULVH6YkJaiubo0NObv+HPs=;
 b=0MNJO3ZNmeb+Lh11iZp93fhwfSRJidVY1PAEpMpzrhrF90wUXf5AAHqXS6DEOBIrbK1B83zQwz75MIrPvMbgQM92+Z8+kL/U5fgChdCZcBwTktDasxxcvtx1dw8PJOTzCmZHVs8VHCa6nsUizgifgkrgPqaZi/hfOAiYmrGyFKQ=
Received: from MN2PR15CA0065.namprd15.prod.outlook.com (2603:10b6:208:237::34)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:24 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::66) by MN2PR15CA0065.outlook.office365.com
 (2603:10b6:208:237::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:24 +0000
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
Subject: [PATCH v2 03/35] x86/bugs: Add AUTO mitigations for mds/taa/mmio/rfds
Date: Tue, 5 Nov 2024 15:54:23 -0600
Message-ID: <20241105215455.359471-4-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 817c07c6-97ea-4df8-3315-08dcfde48d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MJy+3uBm1uDVsLc7MB5pSZ8akJxRd6wrgDSM70MYVND5ahJA5F2vSuNleYsQ?=
 =?us-ascii?Q?pY7qnBI2P8H6OnJYiRGN/uBRTrV6Ure6hVoRz6AHbGiI1gTCGOZd+T5jmGpr?=
 =?us-ascii?Q?GHGq+JVebq/98DfWXtEty2mPiZmyBdSWb8VJ1HDsJYxMiZWmSjaSz8bISHoX?=
 =?us-ascii?Q?6gs5PAEO2hyI573XoX8QptIYlnk4oKm5JthYjQ3aDoFvgerv1Dvp+rj3spQR?=
 =?us-ascii?Q?3JoqbtNKT1Rim9gjkiNjCAJZRs+57wta9ODCLYJ4PeP6EYEXSXJucaWNiguX?=
 =?us-ascii?Q?u9djRGXKAXS74V48jeNxvbwu1egulYdk4vQ/ayHEpl/ZWpRUzrOD43EleTX+?=
 =?us-ascii?Q?Xe8fuoewanNDEi8FA5zMBFRgYxAu6d3NAl4XACYaAO7+/D5Lv6v3NMQPUfOQ?=
 =?us-ascii?Q?IgbZbEt017ubinrhyj2qqSYoqyWiFJqDLoMX+9FLNGijcAMo18u3UwnhI5Ni?=
 =?us-ascii?Q?cly8uO/kwxlbG6vp5XxMRFO4RSUK75JsMbScU7+80KDftDI8wz8v0QRXIrEC?=
 =?us-ascii?Q?olybnWvqpxpOPjy7BpYxJ+dhCHSzO/FlyPqca/bQ91It6LOTbvFuK2j7FQ6x?=
 =?us-ascii?Q?+27G4f9iYAELk7mUI2O8a7uIdsmeo6I9pJnH7edtvjfO83gGaGNK1dLHucMo?=
 =?us-ascii?Q?v1pZPZF99+PFUR9IfscGHUkHC5i7IpmoWI4tHyh5mRRCX4RMzxpinyDzpq4Z?=
 =?us-ascii?Q?k5V7f4NkqsPanIPx7v1OMomw9WZVn8o4t5gffdTIdkZTP70FnjqUro2S6GZe?=
 =?us-ascii?Q?T/wqeuLn7eg3iyCl+ZbQdZtD+NszOd07KQZalyq95CENwZw+yIJ7FjpJAYMs?=
 =?us-ascii?Q?Zl0aoKeDeFUrJL8jtd4sgEkERfgGQyAra28LjLebu4b4r8+ib1wckCjyFsqY?=
 =?us-ascii?Q?jBvi9RY53hkEza9V+MatAtf5BR6T6232MeAWZQyW4PEuLZMemSTf5fo+uDog?=
 =?us-ascii?Q?FVBf8iW1SkPaB9JbYB6whuG4s4NMZqS1fA+6PlO6j2TQlLNczZEtrFiMcEXr?=
 =?us-ascii?Q?5klBh3cAWHl0UybBurALotyyGyw4CYbO8L8vQx27vByExSj07t5mYK+TL/5H?=
 =?us-ascii?Q?j2MNrIJEgoSYjH7s2urPv6ZKJzbb1mKzRDOUsObMDgTX5gmZWcMOlQClQCNd?=
 =?us-ascii?Q?GVeV4I/Mw83ZWb7pIBe1E3ofvOJpjqKJ2D8StvarX6oPQIPSt/N60kk+r0kC?=
 =?us-ascii?Q?xoq+98Dju8+kgNxM/WHCgSnep08PvFA06i3cVNq3goJI49Lbc4GkXPbr3xNH?=
 =?us-ascii?Q?1nWDPGCQJ3hqWQymeY/XEItFPyCSM5VZkkT8Zv5qBml1YUl7Sc1R+NbHI0V/?=
 =?us-ascii?Q?KeHGyclIbaBgMmmP/D2V4olQxeIyU4+PhAlHtPGwfniPZWTgXCL1elw3VRJb?=
 =?us-ascii?Q?HHTczWmH6uM8XJPi/kjAN5REnOYT6OTu//s/5BTICW3VQGsPFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:24.4684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 817c07c6-97ea-4df8-3315-08dcfde48d55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493

Add AUTO mitigations for mds/taa/mmio/rfds to create consistent
vulnerability handling.  These AUTO mitigations will be turned into the
appropriate default mitigations in the <vuln>_select_mitigation()
functions.  In a later patch, these will be used with the new attack
vector controls to help select appropriate mitigations.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/bugs.c       | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c0975815980c..ea4b87b44455 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -754,6 +754,7 @@ extern enum l1tf_mitigations l1tf_mitigation;
 
 enum mds_mitigations {
 	MDS_MITIGATION_OFF,
+	MDS_MITIGATION_AUTO,
 	MDS_MITIGATION_FULL,
 	MDS_MITIGATION_VMWERV,
 };
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3fd7a2ce11b5..34d55f368bff 100644
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
@@ -510,6 +516,9 @@ static void __init rfds_select_mitigation(void)
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
 
+	if (rfds_mitigation == RFDS_MITIGATION_AUTO)
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+
 	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 	else
@@ -1995,6 +2004,7 @@ void cpu_bugs_smt_update(void)
 		update_mds_branch_idle();
 		break;
 	case MDS_MITIGATION_OFF:
+	case MDS_MITIGATION_AUTO:
 		break;
 	}
 
@@ -2006,6 +2016,7 @@ void cpu_bugs_smt_update(void)
 		break;
 	case TAA_MITIGATION_TSX_DISABLED:
 	case TAA_MITIGATION_OFF:
+	case TAA_MITIGATION_AUTO:
 		break;
 	}
 
@@ -2016,6 +2027,7 @@ void cpu_bugs_smt_update(void)
 			pr_warn_once(MMIO_MSG_SMT);
 		break;
 	case MMIO_MITIGATION_OFF:
+	case MMIO_MITIGATION_AUTO:
 		break;
 	}
 
-- 
2.34.1


