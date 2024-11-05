Return-Path: <linux-kernel+bounces-397225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F397F9BD7FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11BE1C228B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A657021A4C3;
	Tue,  5 Nov 2024 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p9qESCPO"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B59216450
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843750; cv=fail; b=Pe2XXtyPvWs+MZTQtvnhXq+z7WXG643O+qErXW+fuiCCaOsGb8IUAsbUSyHY87V0QBd3vR54jj31Q6pi2R5VSTqzhwhcB5q15AZ0Eqqy5rUIh5dNeDvFtWFrfnXFj/VTNizXGL8vd/97xzA8ENbiGZ5ekc0SbiP1zlm6EcPoAQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843750; c=relaxed/simple;
	bh=h1lh4P19jrDNbk/wtvzV5iMTWQAn+SRhomTSlK4gTgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPd3gD3oAgSyPlcU2FucZdBqONZAgbenKmMHipcwx3F4FMvh8nRk/j06ZwSjAtkmeFVDZeMUPicEZSnTiLRAWS8+9Df53qhrEMJ+BxPlP0tWt4QGkjNdYTWED590NwCdomViDBpfPBZMCKYp4GGT7jPvDp0HiKhA1WPJcUzOHIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p9qESCPO; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guslNzQ9+s0oVymBBpqm960iwAu6hzjpmTkL/6rYAN9ZRbeK0tNw+sVIEETRl5KJKkCYRwpzopgx4hPRuPV2AeCBISxR2cw5GiOpWvcmr4xAgYIKb46EQEgvmQTgbKdofdakTxiNKlJKu04JtE3S+NLKNn4JbPduFoYs9T9QuA5Plua1cA5OMAOvG9LwcGJTZzfORTzsETklkGfgfoVhclx38d8/SFn5yYsbjynKx0GbIRvgI2AM9gMwhImZnHNuZyiZZBjki+MFPNmWj+yVYuwS6u0p8/qijUVmO4q/ZHS8TH7BdhXIsEDTaVwrggoExGy/K/XbYCFNmCqbeqGnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCXUXYSQ99VASOdx3gSeoBG40zfIX4HB8Ao/8XldM68=;
 b=q0mLEHWlcMWpeziaAr3upTXBItuVZ26FIQgt1gznwVtjD5+XBh7JL9VpFDTGUrHvOmfvRs6r7pfWqyg9o99c498JDwvTLmouCWs9hnLFWP7wN7nJmV44IFhl19xwQB3gnp/3orBF+JpC080hcW8noJCFmWzyan1TrQY8G0lfNF3IjTDc8RkZut+RdGpB6KUuoj3hZaEJs7LKReAoZ2Te6hWQEzeNcXcZbhzIIbshdGt33lyYXBLGbYjV71RiOAKehuy9mKLAz/Wg/O8nlb1XARp+zYTYr8IuzsV09tGsiJiyn1DJQt5txDu0zfqjCNzje6l0yJzQQHt7xOAAk/WNuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCXUXYSQ99VASOdx3gSeoBG40zfIX4HB8Ao/8XldM68=;
 b=p9qESCPOz2ZI1lygxqUWgKz4ohqB7lg/7nkhNLXNZuVu0jMAjOyh3yJd5MW2/eylsglo6qY+E1qghRjQSZWuNXELOtVHeSB1JvyNhzcE7+uu/NHjukWrecMx+j3WibDxPysFYcWTMa79FCM3wpNR6C8MemtwiWTcRQRYVAmPnaY=
Received: from MN2PR15CA0040.namprd15.prod.outlook.com (2603:10b6:208:237::9)
 by PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:42 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::61) by MN2PR15CA0040.outlook.office365.com
 (2603:10b6:208:237::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:42 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:38 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 34/35] x86/bugs: Add attack vector controls for srso
Date: Tue, 5 Nov 2024 15:54:54 -0600
Message-ID: <20241105215455.359471-35-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: d17b6a6b-8081-46ab-18f9-08dcfde4981e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rb5lo1Nf0i9rGqU9qcXMQ4O2PJQNqC4ZSENH5QflZnPh1RoSpEtF4i8ZdOyU?=
 =?us-ascii?Q?bJvbJgBlwY4CaNlvVeXPQKN/Rt4vp4CmCwBrl41KTs3gdNvqvfWND7a5JA2p?=
 =?us-ascii?Q?RUBiKmXOtVVClMoyEKpoCYOybLmo6q6S58fP0LGFx+eRf+HGU1Fc7umn4NkJ?=
 =?us-ascii?Q?vh+MvupkCWjxKN4mrfVnPnaDiM0d/9rzB9Ev+ZDGfg2bu6dvKiIs4GnbpUlp?=
 =?us-ascii?Q?X+O7Rui4rEivt7ZbN3lZ7BKDmXdvRlcL8MlspoD2WsvDW1iVHPC5h6z2z/5a?=
 =?us-ascii?Q?SIpMGfzafUtYDl50sQp9XYUXFoatDnNSW69DbIyqoBXV2z9l3LPlJxgFN4BM?=
 =?us-ascii?Q?3SboWjldl96QeTPaGZpNJUMY8Hnv0lS8h1QQWt5n9eGl9mylZbwZQ6OOPr2S?=
 =?us-ascii?Q?od5G7gHBr/KVYBFo7OIN+Qbei8vOdBgd31SJKt0P3AN7SHeWK+4wknzWC799?=
 =?us-ascii?Q?bclFh4TjO/rMZtFeW2mBbG75TRLi/GUIYEeGWpkCyTN3O52vAnPRfnOODsRr?=
 =?us-ascii?Q?akb0l2BzWdEwIPj84PO75OrPsLCnB5Ott7IQjgpK52eED3EPSixxakcDjc+X?=
 =?us-ascii?Q?kvzE8xuTsvbGgAamTmeQ8kzMU7DfGe/+ZkLTMQV8bEn7QJz86IrvyMgzFVez?=
 =?us-ascii?Q?rL/rgS/lWMeuQ1SB21T0+z4U4JHJJmadyDGijEF9R6X0sx2V5nfHq+iCW9UJ?=
 =?us-ascii?Q?edS0Y5mUoX140CERzg2UQGB9Y0zTmZ6Dv0kijottajY0oir8bpl9ttVwbteA?=
 =?us-ascii?Q?OKOJ4Za+zvImB76bbC4+fCy2+uc8vSbChZ7XqpoYKEHgb5zuL57s7tPhnsYO?=
 =?us-ascii?Q?9JoN1dEc08fHRUNbzBaTcJjqXUjI/TUQTeeuaeXNAZiKAAuq+b+hpq3mSand?=
 =?us-ascii?Q?RxseRcnRefaWyjulJKJN65uWVjjqGJs3bcQd8r3noOhmE+E9KNNpJ5MczElf?=
 =?us-ascii?Q?pnS43SwS/RqUM4arz4QWFa4mf8VZETEuld65KkuVOrZoxOlpDDHnn7IxugI2?=
 =?us-ascii?Q?gZJYFczKVpMiwq1dthClc15J/4Uli2QndSiQy8ZyBqZFiGt66NYeON2R0+El?=
 =?us-ascii?Q?WA3aL80WYuwV9j5uMndNKsxlcuk7YOOOZ06gEMZXPLwc7TfU5i4oZRIwuR0N?=
 =?us-ascii?Q?FdBbbV0Fcw/MsPs2tDxvjX4wD5CQC7sMzd58rQyY3KthFFY5kF23vMoehDDw?=
 =?us-ascii?Q?zYFTfD8bDgBilPOFOOyJejY/mg+4RwIey8V2hd4UbaePUFOO/YKIz9TEkFli?=
 =?us-ascii?Q?2DHwIZSR+wW3M2A6EmGXFCqEddNoJS4xWHDoC8XDZpEtSpq+8Ih+7HX/3gws?=
 =?us-ascii?Q?JZO4fGj1ZJF6Nu96gKToLGj2ZKhKjqOKsTBsJVuJre/FYkVvl/yclCqZ1JIc?=
 =?us-ascii?Q?q2DSB0Y2s9YgBNDNP5p/r9X8vp6oR8pHHl4JwQg20c6P3V834A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:42.5622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d17b6a6b-8081-46ab-18f9-08dcfde4981e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962

Use attack vector controls to determine if srso mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 81876a24c83c..8552666c1b64 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2868,8 +2868,14 @@ static void __init srso_select_mitigation(void)
 		return;
 
 	/* Default mitigation */
-	if (srso_mitigation == SRSO_MITIGATION_AUTO)
-		srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+	if (srso_mitigation == SRSO_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_SRSO))
+			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+		else {
+			srso_mitigation = SRSO_MITIGATION_NONE;
+			return;
+		}
+	}
 
 	if (has_microcode) {
 		/*
-- 
2.34.1


