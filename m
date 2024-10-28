Return-Path: <linux-kernel+bounces-385696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB579B3A81
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD161C212C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7071DF989;
	Mon, 28 Oct 2024 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YEUzhtMv"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D91DF969
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144010; cv=fail; b=TwyRb3CgqasTzu32SAbflHU4iIW2s/7p4by05KXL1cQBHknrgTMs6pLUwxEHxB6qo//O19fZvuu9M2u9bCFQEdtCyy7jF++dGMBDC6inCeZHDLznV/Zt6ZV/Ax48WQsVjZcQwk2Kiu4J4DTcgaj0BlqlBQ+9tamAXkLSsU/5yTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144010; c=relaxed/simple;
	bh=hyNf7YKUZaJS4ks6oBSi4M0wauxn9oFqAVYpsF2e+uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeUGB1qkAx19DextuLzYphJ/wsbb7U3PoxUT6TPQm9Kshb2bNdZSnu7Kj1gH5EI0a579q/812/bk00E2F4BWj5aP9ENAsRDL076Ez2Z4cewPVgGcY6ufcKwR+t8Ko168xxu/+Qj1BVHHrh1ljDlGmYh0dK0DNHexDvMsVbVk8UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YEUzhtMv; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFJulOLj7zC1nbXC14E4HMi/Btk+J0dLM1w4W3MP9wVP1Xaq8eok8+rasXeVYeYrhT9rUPiDxh4rvJvSP9H1Zlw7hQxwhjLWnsaJUlyyclQvTU3x7Rj7N7/o464rI1wMS9uonOJWQZ/+zjM/H5xt3X8IiuQsaQ64qYy/kjtl5hRob7BDZ6lRSsHhhqRuSKIWh8Bb0b9CKSpdALHCfDU2EzGNTljrkaQz7dbUSzM6iGUfdRPOUSDDz/JJYKbwABYLky6YAURIFtbQGg6ymfSDV7OjpfVYhDQXBhlZdfoAMpPNj3+84LfPqG9QoUNJmsTg1Mi8dp4w4CpB4uzpQ8ijsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9bPyLDYUJ7oWscq04iouZXoPug7wWN/baWfwQShLfA=;
 b=UzusuxPluR1HrjZZORxyJ0xcg1qy0DuG7Yqc90Abfr/dYDyp+F0tDydNdYoEMxF1qSQXKcXvPjLPHBCtoRI6lekeXFTcDX/tE4OUAFWIC4JyFqTpfiArsVKr2xyUzSqsE/oi/PByhhZOZlotyp2FvMNYghZcwU/2jnxq4nD5kHx1d5/hypWbIXGjH2tI/epYe3SuWK66CnNZLGqYMLT6bOdL5NqJdKLHDMHzlmc8cakhUjM8a6jvs1XwHzp9raNPETp5+YsLocGM3eLeVZDL4AzGr8BNDZqn+EL0MLMJc5LvunvACLwuN5I3fH23RKi2ruSvcFpF/t2H6AvGO8Kusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9bPyLDYUJ7oWscq04iouZXoPug7wWN/baWfwQShLfA=;
 b=YEUzhtMvyev4MxbswVRNfRlq8Nt8lKA7idU1mL9nUSgfq3KUwUK5knY6Op/7lAcVJkRhWXODo3m+h+kdL+NWqhMbyXHo/+xb3tg1YKpvz3DXZ8gW56h4+R+6Ksed3fNg9ih4p0h2ELOZq7UuOdkOf8EL55W5//7xAIJXEKMJRoA=
Received: from MW4PR04CA0380.namprd04.prod.outlook.com (2603:10b6:303:81::25)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 19:33:21 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:303:81:cafe::f9) by MW4PR04CA0380.outlook.office365.com
 (2603:10b6:303:81::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 19:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 19:33:21 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 14:33:19 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v5 3/8] x86/sev: Require the RMPREAD instruction after Zen4
Date: Mon, 28 Oct 2024 14:32:38 -0500
Message-ID: <417326a7a2da682e1a3ab0dc0c02079bd6873d8a.1730143962.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730143962.git.thomas.lendacky@amd.com>
References: <cover.1730143962.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: eb491aff-03ec-4395-04de-08dcf78761bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ALLy308YKX0vGjZAJN6fb861uRYWPxv0kG4Gzg3pcFmGiAF4iPVXbfGJTiVE?=
 =?us-ascii?Q?gNyWDvn9SuSD7+fgAZ8lkPuA6fv0ggIaH4cH/CZgWvLDHV4wUzpe6vf+LsW0?=
 =?us-ascii?Q?dFrEiOisItgWwv3Ymdi0AMYu72EGk9qz6g1cU3eLNL/TD+tXHpYSDD3Xzj57?=
 =?us-ascii?Q?08eoyOZSXYCc6PYZw70Win4X+WKj9SoCbpU6ldD0/H/zVgeH8noij+/x3pXG?=
 =?us-ascii?Q?I+2jQsG8NCcynvzibj185SWbxz1cd90+1I5jTFouWb9Zq/Ezq7KXxf/Iuz8I?=
 =?us-ascii?Q?Dq2dfHCtWyO5ZuWjv/se+hrDg4OSRWohOm83z+x0v6rEDB/EJNuwUOePDbfx?=
 =?us-ascii?Q?zZ1osSvI6l/aE8jbvcvzeXCeTYSK8vKnp5Vqo63P1m2pvXDgNZZ5inIMSJd6?=
 =?us-ascii?Q?ej1jeuJTt/xg10YVjkesx5RpUOCDOGIIMYICOu7mTQlbt9ExomIBjL1g/w9L?=
 =?us-ascii?Q?K+6e2bAUgBeziGyOxWC/vz+39kFGuxwD0JAi/DQ5AXS5LQ60Ai5dYjEMgr5s?=
 =?us-ascii?Q?VmetrXDjPvYyzoduXrDoow8pNk2hiFspIYTlAviTXNIQBI2bs3C0f2/J8Ceu?=
 =?us-ascii?Q?8hBJ4Mr17uO1+Gh2OrnRFPzOWDwBMzQXLwqqjeX+yqtP1JcYS2bvI3PPkhMx?=
 =?us-ascii?Q?WVC3gSiHV/Z3f+qV0bX1lVOw2P45lGpjj0ik9pDKL/AIy/DMNIs2gB4Qy3eo?=
 =?us-ascii?Q?B5xqFTvx2IYT7Y2wBl0nNK2C3ukVCcr45a0f4eJ/zwtB5rQKnIH9sksnsn6l?=
 =?us-ascii?Q?1c00kIY9FF+gd/PqpOB7QWaoq7QreQtNiWw2AZg8h8l9bLbagwCDfmC8P76e?=
 =?us-ascii?Q?LjNvcI/kDUlc1nCCFHCCLkaK91xWTnwOW3HUOuuOjNSAFxIJfY2RH1yg5U94?=
 =?us-ascii?Q?MHnBxI6lqWBW/ktGZxuGlipLXbrmVprNhj7p/kb1yVc9/+D0hHKJ4YoVmu1S?=
 =?us-ascii?Q?oKKDdVOiThbGBO+ZjVim6tWWICdkzM3CL4WamnV+8ChOipZ3FeputxJVijXe?=
 =?us-ascii?Q?F3Nr1fWZty5oI2gp4QX96oHiCGQC09G8OBfPycK9tTvdefAN6CKOV1lBpnBX?=
 =?us-ascii?Q?DepS8DzMzy6+M6RXXINwZGNftFrAmwdJt9XqlrhnuIV4kivcBvle4GIFd/uN?=
 =?us-ascii?Q?yv7/DYnoeAXZ1rBktHZ1ecBZjBtQ27Yy62NHi+vwRDyB+Xg8v4XZmunEI6pY?=
 =?us-ascii?Q?TU538/nGaypu+5TWVoprbo+tRSYNGluGsouZ8vRjqpYTpAQ1ja7wBOmv4/c0?=
 =?us-ascii?Q?edpo2ajVWKqUyLCy0idiyqygvvi4khi1Rj3DvKfAPgnMBnzanLAjllJQVXLT?=
 =?us-ascii?Q?HivLNls5zNEl1A4xZb4CrHDap7nHSLLq5+EbKk0ecQr5RyglUUrmJRjnijgF?=
 =?us-ascii?Q?yzvuYJ+HHjxdBefVqsMBkU0w5ZB+n+hQqmCBvoX8DwayNTVgng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:33:21.1500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb491aff-03ec-4395-04de-08dcf78761bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292

Limit usage of the non-architectural RMP format to Zen3/Zen4 processors.
The RMPREAD instruction, with architectural defined output, is available
and should be used for RMP access beyond Zen4.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index fab5caec0b72..547bcdf50f1b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -355,10 +355,15 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
 		/*
 		 * RMP table entry format is not architectural and is defined by the
 		 * per-processor PPR. Restrict SNP support on the known CPU models
-		 * for which the RMP table entry format is currently defined for.
+		 * for which the RMP table entry format is currently defined or for
+		 * processors which support the architecturally defined RMPREAD
+		 * instruction.
 		 */
 		if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
-		    c->x86 >= 0x19 && snp_probe_rmptable_info()) {
+		    (cpu_feature_enabled(X86_FEATURE_ZEN3) ||
+		     cpu_feature_enabled(X86_FEATURE_ZEN4) ||
+		     cpu_feature_enabled(X86_FEATURE_RMPREAD)) &&
+		    snp_probe_rmptable_info()) {
 			cc_platform_set(CC_ATTR_HOST_SEV_SNP);
 		} else {
 			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
-- 
2.46.2


