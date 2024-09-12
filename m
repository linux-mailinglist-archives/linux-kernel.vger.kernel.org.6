Return-Path: <linux-kernel+bounces-327146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560F977138
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DBA289D35
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF49B1C57AE;
	Thu, 12 Sep 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ENfHICzM"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438FF1C3F12
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168171; cv=fail; b=AF2oDfYLvm0rcU0optcHJV6EvrGT2DZwFvrh51AQlcuHhUYBaHNFQHqP7NO+xxPmKawPhHziENnLMCRmTg9Q2ea4fz1McMrSuJdx3mkZH3sKaTD12GtkG2RDxWTbOPQDN0Kr4fYQqeGF9CjzduWP5cDLoRBBySshL2yGxXZkhmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168171; c=relaxed/simple;
	bh=6xNSBfw9JLBjDXO/gk+kuxJtKieRhVKfmU+szo7lo9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W24tOcZQ0p6BV849GtwRNSRhvchvFYbDnVSx3NczQT5jh9m6Ntrx4J2mLzbg7+c0sOB9RMJaNTWuu2auiacUWGIN1Qei37w+JNVwUq5Slvo0bot1iLm9rqkA8qdm/4aYJR71tVCGzewCDPdCZejB8ZVAe3OCVssoLNA15tpt1UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ENfHICzM; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pG/pCZquZWJaiQHuEVAZhx4NuBHGUeKpkT5egfEyL0RGSwD5Y3tZem8OQQFclTnNST5y3CaG4RYgQUwi2Jr/25mctplEyB4V+Kn45pxCJ5fSgZkm4oy2KCWX3LyC4mQmm7WokhkSFK+UJ6eCmmsEx9IB329skvfX4bHX0dh+dTIyxSMYfOMCU78CnKMzOmXBoYI0y2X7+WFkxn/fmsG/RiBvHiOT4hyuZoTc0KbnaedNwqLN+8KTk1/H2KPGzhiJ7DlfLqX1PMX2qsknzJWaCgFTpZOxbXv+Xp6NyRFj3CTXRozYN8V1E+AdQiQ2ZWn7v+i1CZ65WG2z2TImEaL/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGm/o3JsCgegyWt6lkzs87UhfFZph4DQcizwSJEaHPo=;
 b=rDlstGyUaKaaeHlQW63DqnEtGPykgloLZrY27ENdtJRsa1ItTXR+ahTuNJoGsuC3Og/KAznhBuE8zk+/6dfdmPzVuIkMa66tAYp+uN0g7sMqLV+Ealx3YAGkR/otE9t45oPgi7BDeE1dlt64xaZFjnbXiBii102zOPIIYhb25VPs28POQkG4PjxKG5igmzybKTikPYZy46ilxbqliJWA0ASNoswOglrr6Pn89hJ/51ieQMSRmmc5TO4kFD4O1z2Am8WsOQBkZVGlYKouPKWeZacW9mJW5jgHPY0mbz5DQ06/anSAaWvARJscOH8BF2lb6odL+TMheTy+JuFULYWxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGm/o3JsCgegyWt6lkzs87UhfFZph4DQcizwSJEaHPo=;
 b=ENfHICzMV4q4GMx8EOqYfKO905CczoP/IF5q5XuZon3XWPdYr6/nTCuTgrJX+ewo3Yv4VoyNHc3eT8MCReewNXhqJPqv6gUzKSqsFuubKd4uErN+UZR5z8iEITGejwNQojzDyeZY+3vt6q+321ogWSckVtVfm2IdsgpEE2Rvf/A=
Received: from MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::8)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 19:09:25 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::4d) by MW4P222CA0003.outlook.office365.com
 (2603:10b6:303:114::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
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
Subject: [RFC PATCH 29/34] x86/bugs: Add attack vector controls for spectre_v2_user
Date: Thu, 12 Sep 2024 14:08:52 -0500
Message-ID: <20240912190857.235849-30-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: d50486e1-124a-45f6-b4b9-08dcd35e6af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L9XJWVa6eEYVZag8eIgREk9rqLtgucdg55xLMaIZILP/TH+R0kLP4K+hoCyZ?=
 =?us-ascii?Q?/yxXRHQ7/qH2SNenJFWygktsHMu14fo3RNEolPlOyk2mykqVYbdlt5uj3DV/?=
 =?us-ascii?Q?/7vQ/ZgGR1khkxrX0hoUfkjgys/UU5BwufeKxIBAmfoG+vjDHNHPWMth75ew?=
 =?us-ascii?Q?lV3c+yaLO62J0RY9L3LIeZlOj9gkGpZpgT7gnggMP2Tf5guqhCn3dJCH8QmN?=
 =?us-ascii?Q?GEUgI03Lb/gIclxU2rIHZLi5cAdFVYtwU6oWG+kB4xYBr3wHzhFg3Ez0YIAw?=
 =?us-ascii?Q?h4xwbpTMDQvphKJWAcyvYw/WdqLbVCM9QBPgcKSkve2aRixt/ZzE0EtoNoN4?=
 =?us-ascii?Q?UShmKG2MxBG6iFEQjLPtv6v/vPoP4ADKDxJ2ARHAFZkrTLavbZNDi5LRyR8A?=
 =?us-ascii?Q?n39KlCa9vx9j3qec+zfmw5owiLkJhJ7DsvoiSLrbaAMvBtw4pGQuyXwdbVEB?=
 =?us-ascii?Q?K9Bu6Mm1DAON83trU1O+AcABFURmzbIT3C7ow7n776B967J/+k8agKs5zrKf?=
 =?us-ascii?Q?gn9Ot+cu6GldLX01cg9/Jh2XJIpJY0gfn/hR7rs2YZ3zlftMoPNr8Pv2/ToT?=
 =?us-ascii?Q?Hf5ajrupF3c0AETBgLhfC7R5zSD9Sd8Dwllu4FrwshO9/TGLHEv9bLepeN3K?=
 =?us-ascii?Q?VCDh4fKaCq9w/Yx0c0BBr5cHhksSM06fGlB2IpdHcV1iUuzCfD/JTAG8gpAv?=
 =?us-ascii?Q?T+DPaRdGwJO8ha7EytnAHq0rVzw+4hqjiPPoy99uBiDkFa7foV/rCVXu9FzC?=
 =?us-ascii?Q?6RNp6mURn3SWhl5cFBtnMbKuFf3E9Lti4TAazw1rntBF3g0ZVKqQNdbu/y1J?=
 =?us-ascii?Q?T2hqXBXNLLZHgfVLnUqOCv/Jc6Np+s0Zf5OEHV/UskfGM7yJzGDdLolQ5vQi?=
 =?us-ascii?Q?pmJMk7/Fyp9J07oOF0alcOEP/AwvJbGmy95vbT/N9B0/gNO/gdn9HqMqqe4k?=
 =?us-ascii?Q?2OA8vIUxRTwnnm5axDcJ8dughe6bH1SKdIr6F/7xTDNpGsXQx7A9cQgpm633?=
 =?us-ascii?Q?Ri/yArpm9u2s6Q5EtbdbU821Nkvd6WcSpr2Aq2HSrVnF9ab6k/Fg1zaDVqFr?=
 =?us-ascii?Q?VrqqttgnvBMl7z7+X2rN3S4MsGcJQKQMJdlIgFmwjV5Yzbhg+gM3BlwtGAkN?=
 =?us-ascii?Q?aek1Cj5rQ27TGVAFJ0kSAej4LS9KS8Sn3YzA6d73lzUMOdR8Sd9EIzra+B0V?=
 =?us-ascii?Q?2aLm+XmmnW7FLPXt81m4h2OPje/GFE2WPDDsF3Tqihm2/P3zA+N6GEAAeuKR?=
 =?us-ascii?Q?i+E5OtZj5K9ERq7mvcx9PdWLtdK/+TXfI/vD85kXneDFKvjhQ0cbMX4NgIEw?=
 =?us-ascii?Q?W9efYsT8lWVu0vSWQYcoSwaBofALqHL18yW+blGwFQDIFLCjTKOxsyGUPRWG?=
 =?us-ascii?Q?zS7MAETg0tuDGhdvN+uc3ggNNAbmWRhHJQ0Nxay7Xv3bPkaiwQdCchECs/Qu?=
 =?us-ascii?Q?LZFNJTdTBMS6DVwZs0Nhb337DnOjlBj/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:25.2948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d50486e1-124a-45f6-b4b9-08dcd35e6af3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912

Use attack vector controls to determine if spectre_v2_user mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2659feb33090..9859f650f25f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1530,6 +1530,13 @@ spectre_v2_user_select_mitigation(void)
 		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT;
 		break;
 	case SPECTRE_V2_USER_CMD_AUTO:
+		if (should_mitigate_vuln(SPECTRE_V2_USER)) {
+			spectre_v2_user_ibpb = SPECTRE_V2_USER_PRCTL;
+			spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
+		} else {
+			return;
+		}
+		break;
 	case SPECTRE_V2_USER_CMD_PRCTL:
 		spectre_v2_user_ibpb = SPECTRE_V2_USER_PRCTL;
 		spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
-- 
2.34.1


