Return-Path: <linux-kernel+bounces-327152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1CF97713E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68529B24C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1531C9862;
	Thu, 12 Sep 2024 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xTWOp/or"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0DE1C57B3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168175; cv=fail; b=ZJiOkq8Afg0r959a6913KM1ONRSgif7EaTKvgIkw2K5VaQpDKtva0oGI3OnUJm8NVbkj3EJtWgWmDS99FHcis/o/xA2aHfVT2wyNCI3AaKdmnDirChH2amjdcnilQRtVyWx7Axs1Z/2p4Pi3B9GJjodmeRCYPYr+SNEPGs8AJsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168175; c=relaxed/simple;
	bh=P7hLo18XmbJ4/JK+zUVULvpKDsWlHgRczvgU6qShHz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ghyc0fT/EcqLA5AdIWT4ynCpSDEZ6DwsWNslgPLxGV5MA/Iea/wSaNTgnFdrAuOThj7kNLUvoor1KlB9W8POeti/VMZP9nv0KVgQPIRsflsoRsfIWaiF3F0uHaS33pVc+vJIGnn6bDv0A1rqoavnw+ZKyh40jSGfFDBu2yj8bI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xTWOp/or; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0Ai65fm576D29jz5U+ZFqmUvYhj6rWKoxbzS/RMe577W+NMGT4dyWxENy4N5i5pqyLiRO4n6IdIQX/Igol8/70yRhnmL0PXv/10ufZx2rnb2vCeBpk7ldcABMrFJplGibknLUPlTbWPX+2fC8X7lRXiAfNAI9nz4fTDVTo18vVQl+N3Us6TR7P2EmiC0uIXn/IRBTJCYDTYeHIWy8BhnAf3pqaeyFtdQCyYyTe4hD3dISwLzP9TyEDnZlYCj/zpnD4obCYKQTOg0oK5oAWgzz/GQ7IqTfZJVqQoNdwhjDJ8eEViwttarjKgOn4x05fn+X040mqy11281/9YKaC2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MElgMgFEg4lzSb3D2VlJ2+nJ7ViC2FBR7RrdsaF90pk=;
 b=qwSKQCBtSuGbwgzeJl9wL7bdgUBxq+F7xYNmpMqYfeRsg9bxuS7LS8S6elkHHHTJ3UdxrDbsfmpRDQShCCaGgRyQRj8PxcDy/4NKWk2LIRO4kz4Rgwb7jUMzHZGplatdebV0bX0bL+JAmc7La5joxpa/KSGHynT01KQKUPPs0Wx3ljl8L2nxtknPLEuSsB9O1NmJZHhuiTvpSVdgDZNR7PcCNNFkbyltBnTbxpVRJSc7++jf+49AkVfyBxgz7t6PPLuI2C1bJpI5G4ZDLfucyWJZTFGbCbOrIRReNFbs9/uz2uxKmhwN1thS6cnMsoWSrGCmyzpkQb2mOtiCEpcD2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MElgMgFEg4lzSb3D2VlJ2+nJ7ViC2FBR7RrdsaF90pk=;
 b=xTWOp/orvAWTW2d8rQIS9ZJObhRTgjfWUceBkGi6CEz/zeLG9I1qyGVwRbWYfKzlJ1P3JXegeQWqrtFoat4aeT0fb7MQ4uevXLkHK0Hz3I2fG9MhdtoJwkzld4nTFDvNN4jN3yj3TXcDxPxDH0btoQ1lY31iCW8+JHKQeccL+WM=
Received: from BY3PR10CA0014.namprd10.prod.outlook.com (2603:10b6:a03:255::19)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 19:09:28 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::98) by BY3PR10CA0014.outlook.office365.com
 (2603:10b6:a03:255::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:25 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:22 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 30/34] x86/bugs: Add attack vector controls for bhi
Date: Thu, 12 Sep 2024 14:08:53 -0500
Message-ID: <20240912190857.235849-31-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd3c8b2-599e-44a7-2029-08dcd35e6b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L4b+9uxIOi/q7i3KJeUvU5hoakucQUKMmOF2nqhcrrIfqjy/aniSY4k9DiqE?=
 =?us-ascii?Q?44KAlueirIBO510v9UlSyS8ZhGThtaxAA8tCUHvl7PKzn893McgtgMrbaqpY?=
 =?us-ascii?Q?0C486WtlFrAWWRG6gAVwLQsF0q59ffOCd0PJ1DfwzQdyXbeEj9GV8nbVgsYT?=
 =?us-ascii?Q?DxEB2rzhkThy41z7JYoWvl9HYv3JTf4+UOzPtTI622FkxSiBfmsmnZGiBqpm?=
 =?us-ascii?Q?a1ko4NjOZE4t0ZzNt4bh1eK0OA/vJkMVyFwphswpJJMAXhjjtYmomEs8uOJd?=
 =?us-ascii?Q?iaXQnGB0M+gs96Pc72DeHRYaCFeZ89EV9k25pSbZMoWGRgPdz9nXkD/EdKx4?=
 =?us-ascii?Q?WltH6w9n7zQnEa3hiJmVp6QPE870VnfMdT/D3md1uETXcxP46RrW9pKGaPrw?=
 =?us-ascii?Q?uu58ib6VPQZF0YtfK0Sc0pSuRn+ihY4Rfy9GJDh8N6iBPzqBrAyGpN7bsPfv?=
 =?us-ascii?Q?MqjyXLKWjUdcGGar89OVINMk9JUHhLREsMW6+0pElD49mO1D1p7Stb5ubWo+?=
 =?us-ascii?Q?L72JZeq6U4bVj+ItvZkouBbgFpzESs4cx91FeP+vcQuKGmd9ZWZFoc/bNdCS?=
 =?us-ascii?Q?IejV721R3oYwC6Nyl7ZQzTaPfZffqPnU2xDbsECAk9H+zy9r+hKuHdebVg/5?=
 =?us-ascii?Q?51M1gIVeOQv6iutMZzMWqc3zNSze4zKoAz8Gw4fRxeX/Bn0HLH9uK8xCgJFd?=
 =?us-ascii?Q?9oCA6irp/Mm4cgZjC5rXlKynJGPn4ARjdP2ijNuUPebgbokbWScky+6r8H4c?=
 =?us-ascii?Q?j/XGw0mdjZB6rVrwMTQZzXCb34yzakpu/v2463NpUzKChwxdW6kvppDOrSgO?=
 =?us-ascii?Q?TUToY+Yl5hO5G5tuAmkblyNQf8isPgddM3FgLy/8sGk6rueylyI9QsK4IweU?=
 =?us-ascii?Q?VH2/ZLEfccKM0lFZcQhhpJiTuqTpu9amKwhim/qxFHIFt2ct6dntcZEq9w+J?=
 =?us-ascii?Q?n7T+p0KtzJO87G1kclsimln7FurNRrshdcGq3m64Q8IsrRDmuReRsX8U2zFn?=
 =?us-ascii?Q?x6PTAaIcgfqVZDMcl2dWvo6j4isLeB/yHoo/ffGivBjhbYzuoc1ADImtDX+N?=
 =?us-ascii?Q?cYZ/vrXksc3EEKB2d8DWxhg8pVKcnqzV91Az1T16+dFpIJ+lNODx8ju7IB71?=
 =?us-ascii?Q?n7DwtOw7vtQx+ljUsyBEosOOH/w8b+tO8jLukFT93yN0U8PtQT9yIdKpcKGt?=
 =?us-ascii?Q?UDreXbhw+FRiiikflUVi4ulhXecdoBD+CTIXf7oDNMgOK+7lHoyBIcrbKn2G?=
 =?us-ascii?Q?xViwmbeVFNQhk4OFpbVSsTIiL3p0VszXbok6GnDJU3EU9i+O14jcFNKzZLWD?=
 =?us-ascii?Q?EFl63BYpkaH4uCNNaRlsSqFzOOaMfXKjB6zbDbO3XdnS9j/atF/sxzGKMjP6?=
 =?us-ascii?Q?Qvw1aLMKz1evL4+LWoqSLXeyZflryUlDwaEDq2NUei9U/eQHLQQFCnkCeC2d?=
 =?us-ascii?Q?Nm+E4TAXKFqyZwIMFf3aScHhtFQlVtHm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:25.6711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd3c8b2-599e-44a7-2029-08dcd35e6b2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239

There are two BHI mitigations, one for SYSCALL and one for VMEXIT.
Split these up so they can be selected individually based on attack
vector.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9859f650f25f..cc26f5680523 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1858,8 +1858,9 @@ static bool __init spec_ctrl_bhi_dis(void)
 enum bhi_mitigations {
 	BHI_MITIGATION_OFF,
 	BHI_MITIGATION_AUTO,
-	BHI_MITIGATION_ON,
-	BHI_MITIGATION_VMEXIT_ONLY,
+	BHI_MITIGATION_FULL,
+	BHI_MITIGATION_VMEXIT,
+	BHI_MITIGATION_SYSCALL
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
@@ -1873,9 +1874,9 @@ static int __init spectre_bhi_parse_cmdline(char *str)
 	if (!strcmp(str, "off"))
 		bhi_mitigation = BHI_MITIGATION_OFF;
 	else if (!strcmp(str, "on"))
-		bhi_mitigation = BHI_MITIGATION_ON;
+		bhi_mitigation = BHI_MITIGATION_FULL;
 	else if (!strcmp(str, "vmexit"))
-		bhi_mitigation = BHI_MITIGATION_VMEXIT_ONLY;
+		bhi_mitigation = BHI_MITIGATION_VMEXIT;
 	else
 		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
 
@@ -1891,8 +1892,17 @@ static void __init bhi_select_mitigation(void)
 	if (bhi_mitigation == BHI_MITIGATION_OFF)
 		return;
 
-	if (bhi_mitigation == BHI_MITIGATION_AUTO)
-		bhi_mitigation = BHI_MITIGATION_ON;
+	if (bhi_mitigation == BHI_MITIGATION_AUTO) {
+		if (cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL)) {
+			if (cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST))
+				bhi_mitigation = BHI_MITIGATION_FULL;
+			else
+				bhi_mitigation = BHI_MITIGATION_SYSCALL;
+		} else if (cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST))
+			bhi_mitigation = BHI_MITIGATION_VMEXIT;
+		else
+			bhi_mitigation = BHI_MITIGATION_OFF;
+	}
 }
 
 static void __init bhi_apply_mitigation(void)
@@ -1915,15 +1925,19 @@ static void __init bhi_apply_mitigation(void)
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
-	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
-		pr_info("Spectre BHI mitigation: SW BHB clearing on VM exit only\n");
+	/* Mitigate KVM if guest->host protection is desired */
+	if (bhi_mitigation == BHI_MITIGATION_FULL ||
+	    bhi_mitigation == BHI_MITIGATION_VMEXIT) {
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
-		return;
+		pr_info("Spectre BHI mitigation: SW BHB clearing on VM exit\n");
 	}
 
-	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall and VM exit\n");
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
+	/* Mitigate syscalls if user->kernel protection is desired */
+	if (bhi_mitigation == BHI_MITIGATION_FULL ||
+	    bhi_mitigation == BHI_MITIGATION_SYSCALL) {
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
+		pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");
+	}
 }
 
 static void __init spectre_v2_select_mitigation(void)
-- 
2.34.1


