Return-Path: <linux-kernel+bounces-327153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A2797713F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9881F24BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C241C3317;
	Thu, 12 Sep 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vhax1CNu"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E01C7B63
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168177; cv=fail; b=LGPD7eng5WVh/aiu9FCtpOVOoJPIrFbLKTqJthIbc3mwgsGdeqG78mOjOfiyDWT7EqVLndDgI8XGeadixoS2JVesLdvRA60ree2K5O7mCKPyLrLckdVRqta2m2Ti4EgO99JxEyyXPEfLwugmNcFYAROFi8ZdiN8TFR2aSxT32UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168177; c=relaxed/simple;
	bh=UX+XdjiaPVh5zOstQF4uL+WUdtTqLKcp524r6ltniWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3c2QO8MTfVk6/4ytVbE4/RAaiX/0ZvIZqb3nnt7UYv7I8Nw+YADqWsrfGTuWosm8MnpxKBE4G9fKrWw3a9rYsHu1a8IKmMR9NhvAOjCtiIoTXXV9YGOcGVq/8cEtlILx52/FVma/OV/Ts5Zn4hpcqaZkkfOfcey7RY05e6IJzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vhax1CNu; arc=fail smtp.client-ip=40.107.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUTNcdGORNYZd8jIARAkkE/NaICIVin8wdTlFhQ7mcp8fIeZ1EdzPGQwa1Uh57+2DVQnbc5FG4esAErNs61n51aYMhkCGaOw6+DobTzUxsK/0Sd+i41bMt1xWtVo3UoJGV6tQV3N0xPqYmSUsm1ukok84aepuxBFlD9CplG3S6RiN5kfTn3D7RoE6fcw5hLUXGw2PVfDiS8kZ5coEnnRnIeY+HnMAa1ACGMvcNNSKgfznl93cgsz5UiYAmdUPduqrlSSAe0k/wKSgti1mU/H7ot7Vd20UKaRZU64g+WBgaAy1UiiTZ+wJaG0uZvYgOq6kiGRR259HJm63e0ugc7FPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FjKT6D1IgKge+NWHMLBze0bTEC22wyrur+Z5NyCLmM=;
 b=xpOP7s3j+NUSAlQ8L3C7oI8a9lWy/Rezouq7XTvARRiCA35xvlVlK6h/K0QtMMOUEBwaxg2J0yWwJbUwz0dvaP/KhJJFSTsRzIKlnd1hvtCFEENNyJGrppfEUaD7zVMFQBzx8CP2xiE2ct4S+yPHWLB4nOnnQ5RJl1+gZe3HhIpsoZ6sD+gLsJ/tBCIEWIZG1RjMgf2XGOKpnSGkvTzvayz9ZIzyG0dmGXFITIH7f07p4n38rxbi4HSlZeJzP+3XFcCjXPoLDl3xM+uWyOBfiFFBEF+z9ucXbcA+VHcwSd5FLTr1ywh9aIXjtTtTDiR2g7mPYxOgme/I+C/Rz4bfcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FjKT6D1IgKge+NWHMLBze0bTEC22wyrur+Z5NyCLmM=;
 b=vhax1CNuwOsXA0GnblE2KR52GzfSGuoIs9LdIihvxE6btwryOao91GjMfKrMsTMBaArY4HyXeCcfojXrBr71SmfVHRA3zmgfBg78jVRxnRdpRhwC2clMjQmyWXa9veTIWJn5TsuRbb4Def9V9e+ubpud47Tt407tkx5jwDEWMDo=
Received: from BY3PR10CA0026.namprd10.prod.outlook.com (2603:10b6:a03:255::31)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.33; Thu, 12 Sep
 2024 19:09:23 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::d2) by BY3PR10CA0026.outlook.office365.com
 (2603:10b6:a03:255::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:22 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:19 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 24/34] x86/bugs: Add attack vector controls for rfds
Date: Thu, 12 Sep 2024 14:08:47 -0500
Message-ID: <20240912190857.235849-25-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9077c3-a9a5-4116-e324-08dcd35e698b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Frr/1jkPE+rEO5KBL+WmD5khcNeOiu3j/dHOYPJzhVlJHJnC0skQqqblsz0F?=
 =?us-ascii?Q?wflpuJ995W6XR6thJQBwVYniBTf6UIOyKL31kZwJ+zIC4v9efv+hw/3nrQsq?=
 =?us-ascii?Q?WMUmVGU1peOZaSGwV+n3fAU9KbwxnfaarxpHH8MlFORQrklX4CH5tXdzd8C7?=
 =?us-ascii?Q?MigQ1e+Fsneo8QPtx6aFjaHJ0HqSMFG9BAlRiFTR3GUqLltS9wY3vdxnZrT4?=
 =?us-ascii?Q?Q65BKzrmWpSMSjIs16jPvrP+vW/aLzFT6ebUpfyPyP5BcpETw1acMp2QH0Xc?=
 =?us-ascii?Q?v3e3C3arLjb4/yE9eUSXsJZwFpIxO0u/ngOA1BlhNYHsZFeGgNi2fal7bXb5?=
 =?us-ascii?Q?sag52WtAfbYtv3Mdib78+7xO8EWwZtAGa3UY5+rAOBxtdad4oaNQqqrEPa+d?=
 =?us-ascii?Q?c2wGNAJljPZZt2CB6gFwMLT/SgzqNWC2YgkxRDfqjMORgxe/rqpoqU0UZy2k?=
 =?us-ascii?Q?8lL2C/jALYhTqiR0lcwwZfp2a75fY5n4z0O8/aiKgkLK6ATsAxjPigL6XJyH?=
 =?us-ascii?Q?DVZyPeA4sjdfzORaDif6IcsJyR130TJ4OLvw+Q/nUzdTILlJeIZUp3TqWpRB?=
 =?us-ascii?Q?l2DLbncHOIT5urx0M8l/vyDTLryYlDY3Onl+vLWr81y3F5Z+gOYWyyHBH07D?=
 =?us-ascii?Q?+1x9C9fqO9r2wY37K1wwc2iBOm285/ZGu4RUiYqA+7Z0V3fmiYflsVO+Il/F?=
 =?us-ascii?Q?RkQj81JFwXlCGtpV20XX9QCCBIAbqBqkEC2u3DWZrAn1CJBD0MymNjIP/doQ?=
 =?us-ascii?Q?3F2i5H4O1ijZ0jwB+1QwIaSj5x42FTzSQNu2C9T6Vuz5OTUab6TX7z6pRS7V?=
 =?us-ascii?Q?oPh7h3zjx8Rq4b9B0S5TRdQl/sJGjyrrJ+AFaMvMnCjTd2tkga8uhZkCflru?=
 =?us-ascii?Q?LHq1Nwpn3C9TWPXGrxP9Br1wdEt39T350hOu3pB6URH5A6MCkLgX719dkkip?=
 =?us-ascii?Q?h5aEy9ytEyyy56SkzCBsH+cs96g1WvOpb3h4wZUfRzzYgylffmDIoOjJmPSE?=
 =?us-ascii?Q?gdcQOlPn/prd2UuFAHAujj8Rjuq5k0l77IOTTwShoyiZrmMtpfXAXmxh50gn?=
 =?us-ascii?Q?/CQv4IGd7fA17C4bVaye4hf2JD+bOQoxjRfNWODpP13NpwDmeUWOoVJfqnXn?=
 =?us-ascii?Q?oYNDNHPhar6RG+4HTm/Jl2am/gBQuDNG78xwuHiL47hzzVEUjMwLoIrCD76J?=
 =?us-ascii?Q?rlOZlrInJF6ZbNTl+hVVd4lxMRUeHzF8g9X4+cRMPc2VHmu74w+6LNoEzOAP?=
 =?us-ascii?Q?vola7++iU8w3R1/zX8NbdHvYg6DwQB6z7W4PZACrPAYvJlMXgoZRWuMj6G7X?=
 =?us-ascii?Q?i+e5t4Y7nxraM1f1va9wv8/mSjZudF/9ViMvtvuB1uPX2la77gfXWEfiabbh?=
 =?us-ascii?Q?MCldJnCXZl7Z1al0n2lM1BrKmB5xVrz1jg/6/2AJPNo+MqXmhrC0m7SUN7tw?=
 =?us-ascii?Q?2Fx6pv6zAgMeavDf0NxI0cqsssUcq7XV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:22.9367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9077c3-a9a5-4116-e324-08dcd35e698b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835

Use attack vector controls to determine if rfds mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 87ddf0b67d45..75ac56cd0e21 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -722,8 +722,14 @@ static void __init rfds_select_mitigation(void)
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
 
-	if (rfds_mitigation == RFDS_MITIGATION_AUTO)
-		rfds_mitigation = RFDS_MITIGATION_VERW;
+	if (rfds_mitigation == RFDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(RFDS))
+			rfds_mitigation = RFDS_MITIGATION_VERW;
+		else {
+			rfds_mitigation = RFDS_MITIGATION_OFF;
+			return;
+		}
+	}
 
 	if (!(x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR))
 		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
-- 
2.34.1


