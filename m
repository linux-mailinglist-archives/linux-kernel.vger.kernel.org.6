Return-Path: <linux-kernel+bounces-554685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B4EA59B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0213A702A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211BE2356CB;
	Mon, 10 Mar 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c5CLgnEu"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F4233D9D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624849; cv=fail; b=BqKiz67dtgh7FfsEty5fcVva/hbkFc8YQL7DBGVo0eI3LU7xAunrzYlgGxRW1rONvE9BFFCQhxcqFXIGQtgLREIZKS5IwF4IrGaRV+YfL0kSIJSAEqk+JVyjE0Ai2rvA8QZLPq3U1D7aFN1RKQj4r3f+X5qfr9GqTSDS3NXoWhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624849; c=relaxed/simple;
	bh=YxleewDcwK4TqSsm33GGuqQKAlUkU5ZtFt19W+CC4Ik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYMj55oyEww0ufrWgA+IkO8u8v09r2cCqqFkDGeDYe7OAvp9FakT6WJw0yngsEMqFBMclDldO1fMdb9GeDZZ6Jf9u3Caaetr1TyXLDKrYBLC8xKXKNcLTZOIqTUUIRRF97jixVe1XnEOoHHc04ilfGT9T5DKGbJB/G+Uc+tgZqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c5CLgnEu; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cH7f0pDgUZ5Rsc9K5oyZ3CtGKVKUUZ/cR8jR5kUbsF1lPDFUEkgQkQYpAwrnokvDLqcLsWftPL/HWasZ434tuVaT7M/S6sMxHe3XS6Wb0fVLr7Lc0xXB82VLil2I+YjWckvECSeYt+mAsbkjQ/Ju/d1AwTKqv7IUtJBg5XyI6wp3c3/Ij6pQ/c2vkPCPIKIO5kpwG4bMkRVQQoxxaKmlx1zu5lzM8iSyWYG0ouHGke+TB6m+N2GD7q6doaMxED5eMgnlEbJLPByYQtAe2YMwn9B2j3jbtfly50n/dzOUamq0LN/oXdGmfv3mtfSN0Eor8z6Os+vleQxXJ2qbn6WQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qih7QssvUCSexbTjBpL4FeaFsPoJxR5yOxmbj/lARIo=;
 b=I5/ZJ77W0ynBrqaqxHeLBpPkR3EhCfbhSqXAgDfifJ6IlRoTG49cHqF3iFJfaWMMIXQwF1qc7H1F1yLzpk/rEBMzTbNcdsGxrK+5DSUiAexZ+W61sX3G+AJGr36Z+anmcw+iwbkVoNDUSfDCub+1MCQGrTs3oY8WY2benh3//wfUSlsuhmMP5nnUtHFXYYbCsi3rUMl4KgteYCFhXrcRxYT4SUwqZeOgaAZQSRj5kv/k/4NRMSqJt4Pn77CewRjqLUpiBgXHBiwifCWtKdlKboFOxV1y6A35X9bEKaLRfw1YZ8pX2ZYElHhvBN8S2XbgkNIbV+gYAhxZAI5yNvqAZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qih7QssvUCSexbTjBpL4FeaFsPoJxR5yOxmbj/lARIo=;
 b=c5CLgnEucTVnvpDg+evwD8fzlpr0R/eFRdxPuzQO/wupBaOo3YQbrqCd47JeEWeXwvqGjOMGCRAE6VxziOqf8/BG49pVo/2zsJUAOhW5WGiiRidEajlHwpwpHS8X1OUuAIVvPh9sK9aG36R+jnm58julnzNrxThLw5oEOl2Ci7M=
Received: from BN9PR03CA0748.namprd03.prod.outlook.com (2603:10b6:408:110::33)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:40:43 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::b2) by BN9PR03CA0748.outlook.office365.com
 (2603:10b6:408:110::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Mon,
 10 Mar 2025 16:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:43 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:42 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 09/36] x86/bugs: Only allow retbleed=stuff on Intel
Date: Mon, 10 Mar 2025 11:39:56 -0500
Message-ID: <20250310164023.779191-10-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9f5cb1-adfa-42cb-e86e-08dd5ff24d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yprC64ISb4kevj5ZVB5DaeBSnNhTz8dvXAfdFbPdOOGCe1PbZ9LZ907J8Rh8?=
 =?us-ascii?Q?+n7zyh5Nz4GWwyPHNzAKyxK/nZU8tlpKDuMu+4RAf1zhpoOZOqrJpMcxcFSW?=
 =?us-ascii?Q?q6RMEuQWmO9L6qWjcaIbWLfKefgS2YvOvLtp4zGbvHK+1u73wIS5zgFSc8Ex?=
 =?us-ascii?Q?psjWJgx1j4nYx5YCMHowhNWnwiTaSLCM6dl0XYjLEtmwLmizT3X5Fg4Kp/+X?=
 =?us-ascii?Q?F9PUGu+b1Zb0kiW5skqFFbd9Mzucl2nLaq+HsQDO/1izk9oPY4D01tAX538q?=
 =?us-ascii?Q?T85H/baQMTqsg1Mdac48znraP0VeWan3CtcmY2UniBdQwyOxUy42r2gDFvXL?=
 =?us-ascii?Q?aDC9mm82l5akWxvDScoaxHLJ/mBdEVXE4kpOQO/GbsKsH1ddjqFIXuMwlqTt?=
 =?us-ascii?Q?zH2FlBEU8Tat7DX/PQ0n7ImRxMbmHuMRG4o81anVLUVGs4AqZtpHa7lAmRiN?=
 =?us-ascii?Q?GAM6VWN/CmEX8Rjo/2lvPxNxKmdLJ0kvbw1LKZN9orFmLPZhFwIcsUNKNty4?=
 =?us-ascii?Q?h1pTR39LVlAnb0FsMaY3+kLc1+2vwVzuzSyf/73CEXPfrN3AwBVCr/4idvsc?=
 =?us-ascii?Q?1CPB6FYdixJ2R1nOkeQwBiLXFbJmxEx7TeNvXTHpBa3yzUdIyUPBQPb0E+FT?=
 =?us-ascii?Q?J4z5w3GO5HRXEqr+3d2Sp8E/CocNVtleCB/mFGv3FGfeiVwKTnSpRIN0LSIr?=
 =?us-ascii?Q?lHQJmiee4o4/xICzWHywKipsMOuAi7xI6crmN147nczaXfCDt+Ne8XG1dzuc?=
 =?us-ascii?Q?09c8Xd3VUBmY+wjG7nR3gUERir5Cyck4YPko5dX+eiwmKuFNC01AET0qOPeK?=
 =?us-ascii?Q?hPwQ/fdcamAOowE7SBDs0ispOyUEO/MXA0hihRQnIhIi1DnGpuuvwjvqPwyT?=
 =?us-ascii?Q?vg0nDzt8GZsaajonOm9DLPZ+zPX+8K1Lh3uZa8Jjhpu9IDXBbcftnWr4/K+F?=
 =?us-ascii?Q?ono+ArLqo4gkCYVL5kZ2No+iPQNAloBO/F56ECMaubeSBFWaRNWXzj9ueuYB?=
 =?us-ascii?Q?+oxSyHfXOeTLuNLGDpybf8VPNSBdfN5kPWDmCl+PtdYKci1wKvlyTDZbUXOi?=
 =?us-ascii?Q?Yoj6yz3qVX3tu/0xxH38nuTDi8qNBwbazCSFDF69zEQgDBtH1P3r21sdlOid?=
 =?us-ascii?Q?OORVXIStiSKAZOFAge/hPAouDYczc3RTDWhUhGCUt74L8DVqgBHQzYqPSUar?=
 =?us-ascii?Q?Tgl+LQPmAqU0BDFqKh67lLpHWTSTeneZOYOHOxcQmsPGsdpNUrG5co+EQQzT?=
 =?us-ascii?Q?50hlILBce252Obez8reHvkBEi4LKq1CUyMs6GdAVTl/Bb8czzD1kOJ7tGhoZ?=
 =?us-ascii?Q?/rCEVK1qd7Xq/29wAkw2iF8qDu+uuA3eS2bnZVYkcPfLaPIJo9lSuONZqiQX?=
 =?us-ascii?Q?TjsI2mBAK4CQgs0SVszwhn5pA81RD6py2DXh13KB/DjCjaR12ZMpOhQus0jU?=
 =?us-ascii?Q?FLdbB0tmxORKUco5J/JyxPtGuHRbkLAtmrvcxcmNRrk36BhG/5OkRrafcaBn?=
 =?us-ascii?Q?pWuwlu3HJp6epmI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:43.6605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9f5cb1-adfa-42cb-e86e-08dd5ff24d1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554

The retbleed=stuff mitigation is only applicable for Intel CPUs affected
by retbleed.  If this option is selected for another vendor, print a
warning and fall back to the AUTO option.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index de120ecb752d..4af342d226c8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1178,6 +1178,10 @@ static void __init retbleed_select_mitigation(void)
 	case RETBLEED_CMD_STUFF:
 		if (IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING) &&
 		    spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
+			if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
+				pr_err("WARNING: retbleed=stuff only supported for Intel CPUs.\n");
+				goto do_cmd_auto;
+			}
 			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
 
 		} else {
-- 
2.34.1


