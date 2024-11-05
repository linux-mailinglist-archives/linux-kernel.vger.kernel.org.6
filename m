Return-Path: <linux-kernel+bounces-397216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8BA9BD7F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAB1284274
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B84F2185AA;
	Tue,  5 Nov 2024 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HHg01jvo"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC9217F2B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843744; cv=fail; b=esqnFoLm/+qogEvRQNHycximUCwXkRIL6VZQnpgby9UAzI7gms471qJtXlWhUE0oA+NpjDOSH/GqgfnQvxeh2sej/dFDIt4ALZxRsHbytWZJEVW1CqfLWq2TQ/ccYKhStTRlxeihLUP30rKDSw4WJXYjPfPQFPhLxLpqk2Ck+fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843744; c=relaxed/simple;
	bh=VEjeP3MOZCZl1hIllDWFcHRFxJdasi0zrJ67POLBRlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jw5VYIGD0eVYA1flMD3wFBdpOMuzqSkmPOGYgzGVGbuGCq/EtZRBTNrgMaRS3+P8lRTP/HrFOqC9zxiMLv85FCQP4AagHmVtxWTcJIU1NRXp0I9joE+XnmUTQQeBxrdaefdMmPGqbr68Cm2zjtgeoUG1E88tGcPdLOUyBY7y7fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HHg01jvo; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idA6S0c1MNK/Wd5p3oz/C09rwH+CJUe1Z/AhURhQr6R1QvtsOXiIjWAcbsJSfm/USho0blp4j8LW1krk+GtAgrlEgCWMixBSzEpWCp34yi1zgXiE+6H+j2KKajPN5MedOa+Dkk31s5jOHAxa5JDw763PncaBQp6gffvyJsFOj9PDkQyjZaPkE+ZkuvhuXhhb9LeUcTSBtvc4jdPiRXL5gbmzCufIalhtrzJIb0wY8GGyWShriCY5OHpZvDMzRVdU8il2NT2fzd0vOzWR7bizTAhvgTS0+VtE9aoWnH5PXtbyLM3ntdSpLCgTHn1Zwhd5SjfcCVexQLL+bxffgE7utw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DGQoSjNaXMbrK6x2exSEHkV7LlxiJNyalRTic9bJyM=;
 b=qsUZXnwqptD4UdCp9M9t9TvTfUrQY/iiXF/57lPt3rGaW1F8J9a4uUmENw1S9QpCe5M90P/MlVo3GPOWInWGkw4Z8Z/JmocEgPJVOJ7fW2GY0ePpRuy+En9Mg1JROH0OjyeX41H6/yDmki2Ps0nEa39b7xa9s8WXWCpPIWK+aaBT2QL6whesfTXUDOTPFuNg2lcD9GxhK0G5ZqKJUXlp0oZmwwbsBlSY9d95bC4vYoApZ7NFF9yJLNtsHQKqH/Kfty7DscCOWX0pB4ECp/+7BMa/ny0HtJU1if9Z9vkRswvWaFWtgtXo3YNzJr/6+JuAfDY/qrxP19aASR8azLDV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DGQoSjNaXMbrK6x2exSEHkV7LlxiJNyalRTic9bJyM=;
 b=HHg01jvo2ILT2IZtUNBYtFynL+hW1e8nfVngcXfT8pcD+EDqs6lKUDbeYWWVB1RJ1HQyceR3h0BM3IyL9j/K1WBs9l6jPCqSewMXviSeHuX5iy2jhTtZjbo+trw+L29LdvkpyZZ0DK4ldgAnO0vyvy8ms1/RwUn8WxyCILPZ7cQ=
Received: from MN2PR15CA0055.namprd15.prod.outlook.com (2603:10b6:208:237::24)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 21:55:39 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::3c) by MN2PR15CA0055.outlook.office365.com
 (2603:10b6:208:237::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:39 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:34 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 27/35] x86/bugs: Add attack vector controls for gds
Date: Tue, 5 Nov 2024 15:54:47 -0600
Message-ID: <20241105215455.359471-28-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 7628e642-950b-41b0-422a-08dcfde49641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jQUclHa7afDhN0J1kSQww6AoV6x4R1Zr9OpABpiPcXDgD9ZgkH9Oni6ccmEw?=
 =?us-ascii?Q?ff3tjVgcCMxNZQYkckvL1ZEIXAAn3y1HfVfDlb/yqLVmlvCt1EeVFsr3BiEn?=
 =?us-ascii?Q?H8KiGnJvv0wE/0qUdyHFbtZwm6IjMBWvTJpR94cbUntl4BthYyW99JzElVWI?=
 =?us-ascii?Q?QmDY0noWAgUqBT1tAWesNA2pODkpbkmAN8LkijWUqjL61sjsFkhRVJFSUt6K?=
 =?us-ascii?Q?OZ1LpjE9cCygYoqVzdrKwInoyIS2MJJuru05dNupOor8bADZu5hw6W526fup?=
 =?us-ascii?Q?id7qTr8cnmhxfaDKtoc3pwEz2K7SmfEv8bCRDCMPZaU06WW7WCI3kNoQPYvF?=
 =?us-ascii?Q?kV+rra9nA/HRoTOY4twMiD49oDHJEke4v0PA9w53ledFp7Ibn9TU9EOgMcR8?=
 =?us-ascii?Q?jbM1o9XGv3YQ/ngBQUeyR+s9EHRvfWO/0GvLkbhl5s9Lm0ttGtscrOi+Hyl7?=
 =?us-ascii?Q?AYy2MHS60b0ZIWOFoi5TmebZ3EDuLsyuh6IfaCdvogBWMBok685dtFGx3OHC?=
 =?us-ascii?Q?A877qdSLQbM+MXrEtxFnDUr2mta76mNeyppivMSeoLQy4+Gv7q6LhuY65yNl?=
 =?us-ascii?Q?CH8bf+L3uQgdWKay888zSIuYdctHgk7DYiFesOGxeAoXsKq9T+H0CUveX8dN?=
 =?us-ascii?Q?BF7fsQSwrAn3a86Xv+/IOKGaklZ0E3Flhoo0XdaHStE8qrPyCNZ3q0wSZ5Yr?=
 =?us-ascii?Q?9pDoyji960LT6JnupeML/GB6GZAwj3QEmWFa3B9t7U4eZENUtTbSfphKwNdx?=
 =?us-ascii?Q?nGDpgmUXSYkSrctvQ3z2Lzyd/h4xVXbcf+bQfW8X6+RbbK2kO8At2tpBmkJp?=
 =?us-ascii?Q?/HONPGF4+vD3eTPB3cPN67YsY2uDL2wTrccbp+BsHrmoMDUSRHD+DgvpDo8b?=
 =?us-ascii?Q?2ec01lRyUQIT3xwR8vOXnTJFn/K5D1n85Zr6qvV7L5uhPV7YfUNml3iyDsfw?=
 =?us-ascii?Q?hWrKhCzYZ70DjHHNx8R+mP7iJqC63dlwZFDbPKS46oORvl17c5ISM+ht8f4L?=
 =?us-ascii?Q?HKH3fjFKtNowSE+SLqVLD76CwQzrNaUhRJ00zkbdafWJmm9WnjiV+RVc4W0I?=
 =?us-ascii?Q?7ID1J/VcBZHF2PJVgLs841SWInoherQCloYbd3VCgCqehAnNx1GbVCLSh7I1?=
 =?us-ascii?Q?7DihdT7V9dJPagmH6mmnFAEiQsj2Dmue8yI0kxu+2hOU7LA3+WCdUYr23dLq?=
 =?us-ascii?Q?Phm9NlNVoTdv2sVHo85T/9PPnADZ1WCp8ugo+Ype2m2xQliElpTUfgPKGhqg?=
 =?us-ascii?Q?hYqLCPfA4KqXL2Vv/7IPiI5VfL8UhMwqMovtSy9r2QaB1cK9UX2Za54cMGGB?=
 =?us-ascii?Q?nGb9YXqO6mmbcBahM/M/HsniHfO6tB5rGQN6IO1yF4WIhEkTJvaC4S7Twee9?=
 =?us-ascii?Q?QYAfmMeFRC9lUhm/nxtsnKfNvHZiDZaHuuNLfx0BklB2fUbQpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:39.4372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7628e642-950b-41b0-422a-08dcfde49641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667

Use attack vector controls to determine if gds mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 083452942264..8612be5445ba 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -995,8 +995,14 @@ static void __init gds_select_mitigation(void)
 		gds_mitigation = GDS_MITIGATION_OFF;
 	/* Will verify below that mitigation _can_ be disabled */
 
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


