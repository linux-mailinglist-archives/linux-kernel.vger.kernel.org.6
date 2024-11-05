Return-Path: <linux-kernel+bounces-397223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A4D9BD7FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4FA281B30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AECA219C8C;
	Tue,  5 Nov 2024 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sVgfbyUd"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBFD218329
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843749; cv=fail; b=Y666uA5y6UFBkvK1F2PQn/asOEJL+vaqLtoYxKRgYKKwqr5Sb52Fs2hOcr/Z20N6B9p1/Qci7m/p5ntkiF6HcONOVS9uXN+gswbczZtuteFCiVv/YKFDk6GiS8xNsqGuBevv48ybAjURoQCAvTfAACqChR2Q8wEGEznQAj/NMzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843749; c=relaxed/simple;
	bh=6qJiZRpT6SCkCopJsnP3slrYGo4g9DAomfbQoInXU8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRAJOdxRKhmSNvWDUDbL1jKGmeRquGWjtFDI8mDRV4+kpC7PZnA7JPclNViAAvPRHHaLCacN4LFlHZ864gYuRPRIiEjdtJaLMxIERpkuVrZ61okHcu6ad33M4VZc20OWC/lrxkMsOffJE6RrPmIO4GTvdja2yLgvZ1t/bUNkf5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sVgfbyUd; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWt+fpz+L5UUesIGBDsf4JtBJTSbMmOo4eCi5u7H8IhxfH5QjYYtjK6D0vAWX4ScXgM1CXh/L7oq5Y4DvdoqFrQz8T8d99PJdxGCg/LhA7rAll/4EsmO3PSOz+oYfFgNt+0Gu7s3VKGeuMgw2R1jHZ5iFjsfKG6BjoMBJzvIaULl+TLh21QHgSle3TQDCSn8Sj3AICF2Bv1byp6Y3APEgqhbVxMItS4Z09RXYuCkZoXfjl+PhINFkZc/30+71UgvhPScXHZ1xo1r1V0cZn+KdtTlaOGI7oWpjYoG+j1wbRl0tYknHBDuUkrjEgYfqurpxSmaVJFVqAWzuEL4CT13vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5CxKju6URfhVPpLXzSYsL2SO3DvkRKNSMAX0maezFo=;
 b=ysZUnbe1OD2JRJJSQRuDyXOvLIdwWdoeeETj+PWzZ8fNLcsz3pWfXhn5w2EZmI3frGSH1CEjP6460VRJwBD6VlAjJNjZl2lj/3Fu+kalRTSE7fP7kR6f9dRST4Hp//uH+5n1M0KSa63WN6v+mXzNHc3kYJbz5XM7byJGkUU6TJaxf8a027TDX3L7/WE09kczCFlBWjISSRmgJFGa0tHVu+4CVRdVvU+JInEwxyO+xVVVDuPwKc2Db2+m/DSHX+TMrsz9fViNkFR8XCINHDivjfClk7KFGJm4RtrWwLObfZp/v+hpv9wWwwP8iUhC12IvpVKiAWk+Ez5ISN7tFVHNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5CxKju6URfhVPpLXzSYsL2SO3DvkRKNSMAX0maezFo=;
 b=sVgfbyUd8NyItu+bBWLswVxkITsY3UYwSjbRBk7IXuN2wV4gGx9N/8XE/3y7HQ1eFuG/o8x8WFl4WVPulCLEK64mZ2r7+j07B1W+Q29eoxLIfibbSbUyK9yRx9sU/Hy8egRpQSayqpGS7MuhZA6ALeERD2oXqNrSuByq0tBpzI4=
Received: from MN2PR15CA0056.namprd15.prod.outlook.com (2603:10b6:208:237::25)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:39 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::dc) by MN2PR15CA0056.outlook.office365.com
 (2603:10b6:208:237::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:36 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:32 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 23/35] x86/bugs: Add attack vector controls for taa
Date: Tue, 5 Nov 2024 15:54:43 -0600
Message-ID: <20241105215455.359471-24-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6dbb23-655f-4536-e357-08dcfde4943b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BDkC3aS1kW/fPdcfZ/kkpkQUyi/obCq4YtcPulKAepIHqH5M3pENpUzGyf50?=
 =?us-ascii?Q?pJ5BxsPXZrdtQY8QUNyqubqrTLxkUMIWfWlvKA1khD9bis3DffX3o97sq9g2?=
 =?us-ascii?Q?awCdoZPwk6CScS2zrAEWvhjoG8L66UVrV1etMsCtmaKW93IEcU0oVjbEKodF?=
 =?us-ascii?Q?72KVudMjfZ+564RYu9aBS50KhskISq5DiddElwVMcO/KoytMoHQ+pPWlAI8x?=
 =?us-ascii?Q?cFdZZylv7bDk1UsJOhA3NyeganBnsWGa884oYUnPdTZp39KcdmeiSsRmU/uy?=
 =?us-ascii?Q?iKZycN+e6rabRfBB+io4EQlGdaChiO4H9E0a0BPLscZc3JSm93Xh2ZKwO7Ew?=
 =?us-ascii?Q?qnmSkDYxkHEuRBsoQ3bkq2OTI7t49jzVqMScTKpxBwLyja5hQ/5KVeyhUGgB?=
 =?us-ascii?Q?PlIDPQPGzOvnxoZOnIZs6wwn8n22I3nhHIiZQX5HFNUbv0dH3OGCs0uCuoaO?=
 =?us-ascii?Q?F0Exk+x47q9EKqO0n1w5GxFsdQNdp95saw/EHLWLl9GWNod50koBzlf7yASr?=
 =?us-ascii?Q?d+ytC4Nx6zutB0pqfD7BF9YTeUSzgdHyTWW9mdzAltdx6gE2/BXHgPipMAWO?=
 =?us-ascii?Q?IZJ95TSVOGJbfeeg5QFPj/X5pLPPL/ODRkm+7H4uWJWk5NfRkat3BM1wase0?=
 =?us-ascii?Q?Yv24hi8jlN/tgTUIxs4/rB0Hu6TAPgWfgLn3QybWoQg+hsOp0xB/U/P1MRfx?=
 =?us-ascii?Q?ARIH93SF7hbKVUQvenWR3vib8hj1/qL8+45JpiagsSGM+ivxBWIWL71rUaS6?=
 =?us-ascii?Q?qyjgvECIV3tMRI4H8ned00AT+MbSQHDnknLfo7H91dD080iDijdaqslyeuNv?=
 =?us-ascii?Q?CAZyisBztCTacyUl66IIzEpZUhRskQxaaGCt4/F2GXjbOq7UIrxdT+WMZN1H?=
 =?us-ascii?Q?EcU6hDh/oW6uxNofIrLiLYBxH52xtquQKEHpcz9ruZM3DbpZd467+MyXAmew?=
 =?us-ascii?Q?OK8twrdK47CfABG6Ymyhuw1iG8Qedt+SQHLXAJwBxwuVpqpHTfd1LXuUWAIk?=
 =?us-ascii?Q?qh6PT/OMwjrv/jPZEO1Bl4i9134dJUDcD1KAe9co2Ej6ZGYH1Rxq6y2qBNKu?=
 =?us-ascii?Q?lvL0BkpH5e4bnLUlTmOoHwWdmA3qq9nfeNGy8/whBIhWh1foxnDHBnLuPRFO?=
 =?us-ascii?Q?9za5zyd0VM3d/SiLTi/4Dvs1jwEFsk8n321z7x4F+OcdMnFsiN24BBc5vE9V?=
 =?us-ascii?Q?oJ/F8s86F2mKGugm6vH5HwZaW1CMs0ha9t+U6tFjuQ5IaWXotYRRlqwRrl3T?=
 =?us-ascii?Q?X6TUWcj+cLTmm5Ms8KGTqFaaRUTrmYZPNqFitPMJwRCJMbk35kinMt+vWT9Z?=
 =?us-ascii?Q?qrddwcQwhqTy9s2c6NqDwRlI2yx5/foSoidIuXTpT3LN/g3Q2nJVgfYK9QRJ?=
 =?us-ascii?Q?1txTenjiO6IAqMTugJtBa3yJIIytQXMjpSXZ7l50h87dCvpH8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:36.0466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6dbb23-655f-4536-e357-08dcfde4943b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404

Use attack vector controls to determine if taa mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index aa916e1af0b9..431182a0ecc5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -510,11 +510,17 @@ static void __init taa_select_mitigation(void)
 	if (taa_mitigation == TAA_MITIGATION_OFF)
 		return;
 
-	/* This handles the AUTO case. */
-	if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
-		taa_mitigation = TAA_MITIGATION_VERW;
-	else
-		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
+	if (taa_mitigation == TAA_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_TAA)) {
+			if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
+				taa_mitigation = TAA_MITIGATION_VERW;
+			else
+				taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
+		} else {
+			taa_mitigation = TAA_MITIGATION_OFF;
+			return;
+		}
+	}
 
 	/*
 	 * VERW doesn't clear the CPU buffers when MD_CLEAR=1 and MDS_NO=1.
@@ -555,7 +561,8 @@ static void __init taa_apply_mitigation(void)
 		 */
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 
-		if (taa_nosmt || cpu_mitigations_auto_nosmt())
+		if (taa_nosmt || cpu_mitigations_auto_nosmt() ||
+		    cpu_mitigate_attack_vector(CPU_MITIGATE_CROSS_THREAD))
 			cpu_smt_disable(false);
 	}
 
-- 
2.34.1


