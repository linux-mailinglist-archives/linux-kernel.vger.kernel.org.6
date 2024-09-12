Return-Path: <linux-kernel+bounces-327141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFDA977134
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45BE2897C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FA81C5791;
	Thu, 12 Sep 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C3O0yGe5"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131DC1C2DCF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168170; cv=fail; b=RSnNM+JUNFTxOUCjQZoybAAlAPTnnxM04RxZPhKSqY706LDQQ+b8Yp8+WomH5wVaEyhOm1myYJ4Wd5rjGQ6HSP6vRYBd4H4AdIBkm9NRSn/m5261fI8a2oUWGe7bwA5wTKAD7ebcJDIUQ4ZS0s7E4G8gVZUoFfmz+XXiSZNUuWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168170; c=relaxed/simple;
	bh=0D/tQTD4+SQNGKuIIIGvK6VVdro5iipUiRkav8+Wsus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7V7gOJqV0awgXWmUDfq8gGu1pp9q6U0RJQeeMil4zU2UMedQTHxlmHaDS1G4tNRayyEuwXWdAurYIGKwfR/yMKbMlip6/NucLkYm9iNLDuXreJqw6qWytxbEjkD1nlURXzFyrJYxdqgzzW8EbIli7v5TbCH/X2yP36AYt94BrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C3O0yGe5; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gB3lm3dA+NfovNoyspYCWwZYBOVdZ32JD1CK/SayEr6yhR6ivRWeiHNho/060jWoVmIT7vUeTDuwmG0x2xfLZm9R+EO82BsNX0jUhmphZqZIybhxGLcJLALkeHHHjg0wLGO+IqCF1umgoTqaq17HCqFE2tea3fhH04cECnfuCk+DbACUA04LMur+wh2a3uo5K90goUeIb9xvbUt9unveBuZuNW7jk8DnUTNwawZk/CJXGVWbKKT3VmOQ4UB4XdQ6/r/QRXEj8JDIpyo9AhUS0iRSXNc5UBB3CY6xw6WWCSli4GxlwIBn2WZ82Cyyk+/j6jqbbHZKXAcy9JpCVkiIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GIC2Tcg3HCrE4RKhKoT7XQei9oWJ8ja/6cw8UurA7s=;
 b=b7Dnz+jo1+iF8SxPP07QJyLxzKv1XW6xWWQv5CCrqQ9oEWOtV+qPgS/3Tb8LtDY8GL7pLpFYv8ywAdlR3opTkeHi6lbUU0VupYj7MSY8cREo0C8dkbIVGiiOOKuyU5KIM74WolsoXtTtE6GhIl6dWdOGlPD63bwGywyoVDVzhxCvxQeAEiw1Ljc3O5OO2kSG2PkF1fnGCJcjj+JfNnFbXtuHrvUr+T3s8HQh4N0L5qy1/ztNueIVMi58VOEeBmF2c3QEfpXqMCmhVCKCgP8GYefs1o0z2LY+Kz3fJm0d0GBhTYp5NvQGSqw37b4hye1h71GJXUt2lK4o2/4RQy0htg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GIC2Tcg3HCrE4RKhKoT7XQei9oWJ8ja/6cw8UurA7s=;
 b=C3O0yGe5Q68N2Bqrz3YH6G+dn9WVX3kuuav7UiD4JZnYg+0zpL0G32+BuVsISH3VCDU0krh0RBGwrpBrwxD+gVMR7U9LbHZWbmia5KgUniwXA+kHvCMMP10v/tb/9rr4t2PnNf1Haj8aIGS46Nev4pxqTIMoIAEUV8KKu8FzmL0=
Received: from MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::34)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 12 Sep
 2024 19:09:24 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::66) by MW4P222CA0029.outlook.office365.com
 (2603:10b6:303:114::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:23 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:20 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 26/34] x86/bugs: Add attack vector controls for gds
Date: Thu, 12 Sep 2024 14:08:49 -0500
Message-ID: <20240912190857.235849-27-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: c9fb7f3f-7b86-4bf3-718a-08dcd35e69ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A0jW69J7dwzDlPCDrj/CI66WBbiqlcFFFhS4ZWhT9jjm33xbedpltxeydIM7?=
 =?us-ascii?Q?RpYVNPrt8ZHgpHIuwGVHa9x/4anMbVtKK/mkBXdZ2XbFlP5teRLxqaPA2lpS?=
 =?us-ascii?Q?s0uqxbBe+z8YCpe/ppXp7KwKUfXBeVfz/RvuRwiy7yJsFh6rI2YBjtk92Fc5?=
 =?us-ascii?Q?VEPxxy8fnHwCq4SPWclx+x7NuwzwI+KlA+S6rhb5VQGKDcK2FSsW1KIcjGEP?=
 =?us-ascii?Q?HWPu+h6PIjLuIylbQOlghaS6yPcesqjGR6V50wHXSrjmV9UXuwSVHL11IewD?=
 =?us-ascii?Q?ZRAR9aOktu499HjPEom8Vz4hLRrCByBZ+FhMHyZaJagUx0JNZENKX45pFG/n?=
 =?us-ascii?Q?werPDVmolH3x5IHAGE/izgLKPW6vqN3vt+DvBUdiUSFmUC2cwwyFEZE8x3QB?=
 =?us-ascii?Q?XXpO88CJ6YZncdBBros22RDjQJ0yMn9QVe5S5cm2v8b5QSuGnX4UIA4qM61/?=
 =?us-ascii?Q?h5hWYR8Ckkv+05DIP5bBkiFezogDD3mNYF3Adfxrsy4qSG+UhbJO57DphcB5?=
 =?us-ascii?Q?mB5x7SjMUq1DVRNarIAV7WZ0gI9Xb72FoP9wxGg94bb8kkVZQ7qPyRncEbFr?=
 =?us-ascii?Q?s2fZ9GZgo7fVuOHlO2q5V951rcZG362bCb0vwbIAYg/6cGKl1XvF0gct1nmY?=
 =?us-ascii?Q?p8QtJ7wK5M7FzFV+KTkrKxyWDozy08uOf2Vh1u6IONpZlH9JlZfl73J3SEXm?=
 =?us-ascii?Q?4sZ89+eRJxbIjBUUxu9eYYqVGE9HGeKFI/O+U5Ddm1jbTcgiL1G2AztPgQmW?=
 =?us-ascii?Q?5pK2dZ34X0E5LTfZXf/n16uS9MrM864CDHtYjcb4ftBNWLuMq9WavoO4Aec7?=
 =?us-ascii?Q?KrHCvgeq+sL0Ny/GoZGjNuAkDHFHU/ZC1UlHqgYAZAHF0TOrqty866t/5BFz?=
 =?us-ascii?Q?B7q9n4sPXtmzULVuwObBQu1RA4fExsPCyHVjVpypQk0qUTiUO+wccYaRppxf?=
 =?us-ascii?Q?Di651T1rhBZ+meyeOA2/8G4CDVKDyVLnjSFU/VSy3qg0cDRRj3bs+hm1mnxt?=
 =?us-ascii?Q?A6lB114VVOp5VY0vBpjROqd0l7moujC648/k4LveTCCi77iE14SSc7jSvAjK?=
 =?us-ascii?Q?5sjhWP2zEsU2yvBP1p7mxNabhzUj7zwOO0bvRyjB0ANbRH3sxLnS75lGPt5E?=
 =?us-ascii?Q?Fs513Wf6ZAt0kjO1hoJiI1YAhqRiSylFL98YmCO0nlQHSRymFUMXGkqxXmF6?=
 =?us-ascii?Q?6cXXkKNK7PEL1rhkaNUMLlH1+l0HeouKx0iG1T4+MguC5LrsKIp8U07aKtTE?=
 =?us-ascii?Q?D5KgZbD1cP7HeS2VqRZk9matMbYVrCCAz5TUHyDIyCcIjdrOr5iSjjIbquUv?=
 =?us-ascii?Q?UDgK1A3trWSYOeC4/fYf2lnsxWzqBQ/fYKe0FEZYWPo2q8ATMXQ5n8991fOc?=
 =?us-ascii?Q?sl2FMy+nMmvrIdVeW2MIx2OZWR0zBaVbJIXDZUYRokTttIRkvGy/88K7y2X8?=
 =?us-ascii?Q?GzxTkD9eJPLUfSC2TTX5zKU1uNq8jrsC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:23.5448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fb7f3f-7b86-4bf3-718a-08dcd35e69ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656

Use attack vector controls to determine if gds mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d86755218c72..5fbf5a274c9f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1001,8 +1001,14 @@ static void __init gds_select_mitigation(void)
 		gds_mitigation = GDS_MITIGATION_OFF;
 	/* Will verify below that mitigation _can_ be disabled */
 
-	if (gds_mitigation == GDS_MITIGATION_AUTO)
-		gds_mitigation = GDS_MITIGATION_FULL;
+	if (gds_mitigation == GDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(GDS))
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


