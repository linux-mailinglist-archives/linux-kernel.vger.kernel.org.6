Return-Path: <linux-kernel+bounces-397220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C789BD7FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186B01C22843
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA100218D9A;
	Tue,  5 Nov 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SQXSaii4"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5E218334
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843747; cv=fail; b=Sn4s2eFyw+h4/y/b7J+YOo/W6ymzqnNFkiCr2ECT9hTbDKywyt7e8YI2HxGlynKksTsh+JXpULJjdqjs2hRschNAQlmWeW/9vTjLeBvSvXM3WaHCpc07Q3pvf6vdU+gH0sqZnoGyQS1YXEFsn/jgjUw8GB+oeNQg0gHQEmNtA70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843747; c=relaxed/simple;
	bh=GQImFkrVbzIDYxUD8u0mTONoey1LPPSWUAwDH9+l11c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3H5RjSJHDRBoIxYlD5Kd35++VOXy0Sir/bLgpWs6rt4H9wNjnhxuz+zyKwJ+hfM0Sh0WfsIduglRnPEMXLto4IHfNLzlZki8omRfyIgG361bE7siqxqvLGPE4pXITYbQG6cpqsBTkk2tacym99+Ru0sSoI4wQpfawfP920JA/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SQXSaii4; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wU/S2cAySkuEF34J02SRbbFKkp2EnRUngSHK3dy+6ELjW9SW+1Q9Mo2nR6HzSF2CMltvzV3a1L9ZCFImu/RB3KCJtFJ4OmHU/yhr327W2BK47Jg4XRcAN3r+TkaZU94EBG2PM+3csA/K+mp3iacyhqmkiaWkL8rLocfwmEqNp3i4C9GiLMuW+49ntp9VWZWcmSxO7l4q92J5bH56BaKc5UK/nt6BMEGbyYRjm2QdUO3P5G+uPlNbPz0nPkqhJT2wpJS1zc+Lw7JXRngWOo8EuvYg1Dpw4aYRkLf1j9akVGZ1bq6TbcxIcihQ3dtNVqa4dR5ubkGALOPYnvBR5nwgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfV0qQMrY2pW7wTJIZ2rCrOnuQrhxSMilG31XPFZ7dY=;
 b=G77Ay73xWIA9/y42gKIj2JazaO1XDWnoS4xbhn8ricFZHarhQqUPiz8hSkFnJL/beI64xWtEVE+n8i/q56P+xjxAYmAOjrrcG52UVeg03FV4nLo9nSeHbt1TlkWT5XU8FLrZC414LlTSa1ms/H2vOaZ6U+nQ8X2BYefGC+KD711Yeb7NFZgEdHOeUZy7dAigiUipuNaUt/ueZCW7jUeaK5TpaqM07MXgUXCXDgYeqcC7gDk/SFBFyf/F6SwG1iVj0G4OTOiWtVbc0K2G+dYyiYIbtGnXKjf7Q7vRIxRW0tZ91gEDjJ+GbSZzkc2ppW9xy4fC8TloKphmMEZKUZenBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfV0qQMrY2pW7wTJIZ2rCrOnuQrhxSMilG31XPFZ7dY=;
 b=SQXSaii4do9zQfFjfF9lHIhlzMKAX2fkXLRBiZxYbls+QMI59iIY7Dp86h16Eg2OUy/pwZ/CAnWrj6BbdopkN0y1Gr6P+3PxemRgCkolsAvGFC25HbdIWMdRYj4fNz+Tues/Z2A9PEh3olaO4qRtneqhT8gbVTZmkKtvPcjj/ns=
Received: from MN2PR15CA0051.namprd15.prod.outlook.com (2603:10b6:208:237::20)
 by DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 21:55:42 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::a2) by MN2PR15CA0051.outlook.office365.com
 (2603:10b6:208:237::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:41 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:37 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 32/35] x86/bugs: Add attack vector controls for spectre_v2
Date: Tue, 5 Nov 2024 15:54:52 -0600
Message-ID: <20241105215455.359471-33-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DS0PR12MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f5ea38-2f9a-4ba5-6cba-08dcfde497b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hWYALAyGrFg3HqhwDWHGJrk1g0eAuj3X6m8aO4r9NMWaLBVMymhRQIex6I9X?=
 =?us-ascii?Q?3TRlSUF6K2A0PNZG/3EhwUynwTk4A8QlV0sfaUdOOaF2eMWRQGEmO1oKhOdb?=
 =?us-ascii?Q?sUCMAAm6it+en8XVHSj4Z9R+fryzyUkSWZlW1WF0+hCsPPl942BUtIYoVUUC?=
 =?us-ascii?Q?kFYVyF3vXeHti14fLo82jDRUsQFGkdXSF7+DscvzVPlvsJyvTUOswuq5Pf0M?=
 =?us-ascii?Q?qITTxBF/6kRB3tFIzKc2cMkGBTKbAJilpc1bpHFdPesF6UwhJDMOhYR4HXAG?=
 =?us-ascii?Q?cK6xVDTukTIq3AxRq7bDLrIlLzj3SseFH5UNaNPNF18jlPabfpC+bQtsyYee?=
 =?us-ascii?Q?tTEn5xWJQXDX9zi/etP+1Ixfs3rK0zORD7JP9VxCbndjdGMnQmSj3x/duGPY?=
 =?us-ascii?Q?czgU6nj3lOMXakP48Od5ddRXvgILN57u/NhasNktUJnhlO7a6fcl8KcPeEbz?=
 =?us-ascii?Q?Hm5DglR6XCE5tpS4ZHUwVBUhPvhvHIuDoMhBJGdiGRUVv+9w+w0vy9kd1VwW?=
 =?us-ascii?Q?6IAKYR5lvgDQEU0PCJXogyQyAWYXDkhBTlIxhPc+4YVslvi9mwI2QzpQyW6H?=
 =?us-ascii?Q?+R1huNFBTlolD35qBPTGkFfY3s1woBlCuf4mnKZJk1GxLb4nDWIU7qWSKx9A?=
 =?us-ascii?Q?gYIK1foDSGZ1Juqy7V3PZcAn+Vx4Xx4oReDtTyv46WIoc6MtCDVF4d61t3V6?=
 =?us-ascii?Q?4tnWXX+eFwlmXcila1tskI7SciUzncE4YbL6Bj4Q6uMJ50DGA6TDSE4v0ai9?=
 =?us-ascii?Q?m/CGg7nxdp5h0NePImK2iyFFOTjL9WK5PTOmBmy/GVuNFTzIXK9t+V4IGVSK?=
 =?us-ascii?Q?ejRsp07W2cB8mJPRnR9cHNwyJX77LVA7J02orUC9ZvoETeA5NqLXLBuAo5rY?=
 =?us-ascii?Q?N3Eqc3/VPXpAPZQ2RDkC1coZNsAStEEOqn+0qIeF5j0F1PIfPrusDhoU/H1j?=
 =?us-ascii?Q?l/Xg1J+0vOrDH8yOQtIrpkqbLJrzC3BZpmoT4tH/E4IdW7nqKuIsuUn1sFKn?=
 =?us-ascii?Q?f2lkYUmu3tHZOexuLCW0XmVANLercrnzrzxX5L1rNdWFM6xXSUZs9gqpn9q+?=
 =?us-ascii?Q?ysSY8KoYoHwW+3pbL3qo4YI6NBapOVXv/w889eokPE7cAsMVuK+FA9IsAhSt?=
 =?us-ascii?Q?5wctTIeZZTxTGKUFTeHN2xymbmfXBrxk0POb7ZWbsCmCWuvGbm8OBD3Zn7+u?=
 =?us-ascii?Q?uEqF7yruqW43MzD/ol+C3mxnfOhNskEnxeJyKQ8hDIW655TjeeCo3M20sWGg?=
 =?us-ascii?Q?jJeKt9MLEObrsS6Rwr7zhUo1Jkc2wR9wzxZXJ4IMZiKGNph2wXnTNtlnVNej?=
 =?us-ascii?Q?pCI6iwRKB9OxRb7+ChGEKSxN+4B/d0oZHK67x3ae2Fo1Mlf5KDMNqtun+twQ?=
 =?us-ascii?Q?2jPPgystvzDjLOU+gSY92HtViYbST62nNJMk94oqDsWrSEaNmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:41.8435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f5ea38-2f9a-4ba5-6cba-08dcfde497b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769

Use attack vector controls to determine if spectre_v2 mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cc5248cdfe6f..4d71b4f969dc 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1975,13 +1975,15 @@ static void __init spectre_v2_select_mitigation(void)
 	case SPECTRE_V2_CMD_NONE:
 		return;
 
-	case SPECTRE_V2_CMD_FORCE:
 	case SPECTRE_V2_CMD_AUTO:
+		if (!should_mitigate_vuln(X86_BUG_SPECTRE_V2))
+			break;
+		fallthrough;
+	case SPECTRE_V2_CMD_FORCE:
 		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
 			mode = SPECTRE_V2_EIBRS;
 			break;
 		}
-
 		mode = spectre_v2_select_retpoline();
 		break;
 
-- 
2.34.1


