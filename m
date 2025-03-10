Return-Path: <linux-kernel+bounces-554701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A588DA59B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE991882B79
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB4923BCF7;
	Mon, 10 Mar 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EWH+svF1"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474DA23AE93
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624869; cv=fail; b=oGvTr5k/SN7kCtyxByvxCvFDn2zwHgzIFpmXDUtKQe1vk43iwJ4MH+1NNzHOOc0g9KLoHhO0Yz74hOqzFSKOrFT4KgYrMoXO8dbVoAohHSLPM6eaEXT43tpoJ97kLMIfd4zCOsjIppWmQSu+s71kRoB5ug/XhV9d8qSajFtuaWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624869; c=relaxed/simple;
	bh=gmtuJUxLwQSryJNVC/8KTKW6nLCv9yZmT3/1kMAVS3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+c9Xxys2nEwzzIKoKl487QBmZj3Rmv5zOOxHI2ANKmfEvcG7NtHCOkViPniExHtZQe36oJPepbaASQmXgW+3pQvl5Bx47tdecZZ+V67bANQBr9nErYfisRvk8Es3AFxAs/DWW+0dyHe7W8yg5/u8pxlF6pfvbmbMKAgE0eXEk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EWH+svF1; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PN3WLK7wPm+XIpBT2CAomw2JERRG3nvs1r/uR/OB2utgxSaOksruNhLV94rR2lKPL1kfc3XeVicbEUWXx8uW7TPQF4FD/AuqkVU6hqfE9rvz6TmEE/N1y1XCU/a4UKacKEmeqh2A6O/uxkOkxZ3CBM9eYcKgDuLUIbEhYl7RcygLty8sELlChG6IiZcAM7lJ/KJRzXMzjNiCHu3HFSJsOW+MztgeWtIbFTZbvUlMgFJramU7p1hb8UnZxam9DoVjkgnQoHI6QnB2ri84FNsYLAecb6c3jXrOh62HBh2aPb8AZOH29Wk8w/3vbfDx7D58+f1qQRxjBYWEHH+86tXDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJX5vc1eZEzXCjJRi0jEdOJR1UbWxNFLZTtR9meW0dM=;
 b=gD5EDwpQUPjHN4FnLeZepMxZyltFBbEDWVFKNMt7N98nJqA/Pc1ikqjw7NHk5i5RGDQovID75WiaeRLDTBtejeLGn2KKIej+GZWFMed3f1DdGFP/J6iYX0Vc1neFjFmsKH/VocDycag2NvkxvBDO3ozwmMXGmuglYwK1ztBohRvwtOvktMeEQMq4ttTfdJLGPlqjGhES2kGH9GfqLVd8cLgTInP9NXqirCFRZQmNpyCEkUAo9qIODgNKtjpye/0qBAl60RQsiXEwZZN9ZkJjTdupP/6PgU74u4afpklg4pPepT7p9JbOiI+XhZSnUEmlbu2US04LsvWnwOYXXVYX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJX5vc1eZEzXCjJRi0jEdOJR1UbWxNFLZTtR9meW0dM=;
 b=EWH+svF112XdX9dJlziG5Qi4Cu7WlEWdMma03LpLAg2zGHvNU+erGdDwjMAG3vsX1ww1pHGR8N5HLjvgMnR/liXVgB+joRwOUGwdbdpcMR5fnJvUaAVs+XFou2y+b+G4D8yw6KZfp602JegyCXpK6/O/DpiHKMaccsYYqBq28mQ=
Received: from BN9PR03CA0080.namprd03.prod.outlook.com (2603:10b6:408:fc::25)
 by DM4PR12MB6229.namprd12.prod.outlook.com (2603:10b6:8:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:41:04 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::d9) by BN9PR03CA0080.outlook.office365.com
 (2603:10b6:408:fc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:41:03 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:41:01 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 26/36] x86/bugs: Add attack vector controls for gds
Date: Mon, 10 Mar 2025 11:40:13 -0500
Message-ID: <20250310164023.779191-27-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310164023.779191-1-david.kaplan@amd.com>
References: <20250310164023.779191-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DM4PR12MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: b210bfe7-ec76-41a3-58c5-08dd5ff2593c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5e43K66+gL3D7ftqIOnctXWnUNfEAvGtkL20YKhKN4XtlzkxiZQdxV3gjlz8?=
 =?us-ascii?Q?WEcnGp4Gx23GkP84iN+xk1KfVbRC9Qu1ehIsOrmJQguQ9RbKE/IkON03PIzv?=
 =?us-ascii?Q?bIJmzhKZuygUHQbGFUcYwROEFeRD8Grh3t3Ls+yP79XpX4JsN/1U+at0SjWj?=
 =?us-ascii?Q?rDXUBfDJ+9eJiBJ6X6l1UOIdggBWmhH1Vw3mU4C++wQEtACkGpMp3/fQmcQF?=
 =?us-ascii?Q?bQIRDi1ZAg1BTy2+xar/zV7HQ4w/E/LfM4T4IPP/R1XNOqPOrw8+zRM2Tka0?=
 =?us-ascii?Q?tBBNvQ7IAzyY1fuW1zP+9I5MbQP/Whu6Yw21ATIPttsCqFHtjOY0TlfsSscP?=
 =?us-ascii?Q?oheWAfRvil/yoAuCYjPZePK7bbhKfvTtAJX5Uu+mpy87nPqwt2Z4INPXS1IX?=
 =?us-ascii?Q?rPdAG+x8WAZQNMOOBTivDZFyM5kf6sFXBn7KtQgIymd5RCNUVn9FPEX5UQUl?=
 =?us-ascii?Q?vePlEii1S8P5FO6IlXg2rVWPltb3+zYTEiFMuOfBjsKyh0xXNkh3ZPNR7nCs?=
 =?us-ascii?Q?YsaPrum9AfI1uBsGvyUp3OsXnfo+R9jOejStWZUqrKiYz0m5U1dpg6awtGU+?=
 =?us-ascii?Q?+FcOeoRh6AhblQkRRju9UBtaTyIc87PpIdmWGX8hkenUE9+J+INaxbVJnHfS?=
 =?us-ascii?Q?RxiIPFUiN/alblJrWaH832Cm4/07uNJplhEQmVYFQYtAgayugsj3DpiKSqNU?=
 =?us-ascii?Q?freORHCAAIwvmNhV7Of1fDJOp37zoy54BAR7LJEsOAJGx+wpv3nMaWQ6NjVS?=
 =?us-ascii?Q?4bvP0XhsC3BexT0Dk+IOgMC3Fub/xvm09xAC3j0ebi/1+YTk8agbf7UgJFrC?=
 =?us-ascii?Q?OaLuy9cUFOFNkw2E8GWgTWHe5IkgSyPhnPxqiViMQLFykvBaxK9uprnFDtbe?=
 =?us-ascii?Q?Mdlaavusd/MLFx/fsF8SJ+Is2E1rYYnawMfYizTb9z93BS0zNyUmE7pPdzCc?=
 =?us-ascii?Q?+hYNCRaTUUMbVPEJpLfW2L53Dv3Fd7LqJoieO4gWipw0IJT6n8eDDXV7ZNDR?=
 =?us-ascii?Q?lxQ6cqdIidDsgwrq3ZGq7yn+9uCijgdiS2HDyNdLa0xUGBYfArETcbj3A39z?=
 =?us-ascii?Q?3r9pp9M4Uefv41F0G+C2/mnk+J2pEoa2sGke2uh4CLfbaoMnQKCyblKw1iiG?=
 =?us-ascii?Q?asa4Ir1zoohRJdJsTxX57TsEeXaQZl/Sus+q/+VMM+SiKzSzkVyA4kGc7cgT?=
 =?us-ascii?Q?FGuSH8RJVhWlVjKQGq8OhHV0she/gxqfAvUiVI91QHClpar1jQyu7SSd0JWa?=
 =?us-ascii?Q?GuQBNeraAzQPG/oEPuDw7BLF2qGZuLsaoiX/Z35jIX9h8i4zGwh61hzgs+El?=
 =?us-ascii?Q?uaC20IUd2Z2qAQCaBUw1e621Q5ZD2B9CbXUpC3Jd3BuQQrn8qOfNoZnpsvT1?=
 =?us-ascii?Q?aGZfkg58gOJ7e7iY2rYQ/CLJ+YaSKc/F+cJ6jIWFWjGcSFIhuGUnOflWCEp7?=
 =?us-ascii?Q?MmUfNpmVOz7UzvWUCC4hp17haXuYwKUUwaO07Ej9Zaa0AAg5rL+ZIgja2qyU?=
 =?us-ascii?Q?LAWYGAOqkiScPGY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:41:03.9861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b210bfe7-ec76-41a3-58c5-08dd5ff2593c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6229

Use attack vector controls to determine if gds mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 148cac36a24b..5803c45dc15c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -994,12 +994,15 @@ static void __init gds_select_mitigation(void)
 		return;
 	}
 
-	if (cpu_mitigations_off())
-		gds_mitigation = GDS_MITIGATION_OFF;
 	/* Will verify below that mitigation _can_ be disabled */
-
-	if (gds_mitigation == GDS_MITIGATION_AUTO)
-		gds_mitigation = GDS_MITIGATION_FULL;
+	if (gds_mitigation == GDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_GDS))
+			gds_mitigation = GDS_MITIGATION_FULL;
+		else {
+			gds_mitigation = GDS_MITIGATION_OFF;
+			return;
+		}
+	}
 
 	/* No microcode */
 	if (!(x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)) {
-- 
2.34.1


