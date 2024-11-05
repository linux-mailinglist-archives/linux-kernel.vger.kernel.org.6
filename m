Return-Path: <linux-kernel+bounces-397214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7309BD7F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0982835F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D47218337;
	Tue,  5 Nov 2024 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MlIqUGqC"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D72D21767B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843743; cv=fail; b=WLWqw7xoX9VvJGhrQrx0HUzYp0EfQ+Oy7qmuLeD61ru5Wn+Wvjk5PYc0dECJphn9o8GDMS96ikWf6TYizvuZiW0YXNAC0ti5Odx5cCJ8YcAx8fgnog151oNJZiADVzXLNwTL1MMjJewEIEk19ZElLpI67c2MixvPOCCz+uIJYq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843743; c=relaxed/simple;
	bh=55LI3GWSsT+dXfpf+Q9k1K3Y/WggN9tWq7Q7RZj39L4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=almAr4cAYBGs60HsBKZztLgBRcC0l5q6QwLHRbuNHAwDVOHSkJ4s6SPcDAw8M+ShNJ4nNEhfta3KJG7hV8QrhBtgFDpQMEanZVbRCAyyqHmgE5QL59lncPqn6i0EF5kHuzV2dxUsZa+JSBcyM6c2CjMhuM/ZqWyqf0+uUArn37Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MlIqUGqC; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtILNdilA/EHYfjC+KdtixZFEUDUJiv+RY/FuRwIh0mkFzQcEFmQZpoRRza9XtweWRoo6NrQOqJc1/vcZS7HK95wymiS/jhujSg63DDD4/kNf7wqi0hGdZ2OpXXRBiNwmWpq2D3f756BZwX54Wg8Mrc6Nf7nUkWP/H9GX7ZyLwQQL9uVAnUsZfb3uOGpGeacIeIpYL1NxuaGgvfcNI8pVh/FdDs98gzBuYPtlEHKpn/xP7bkTnfVqHXnnOquHsAaFaJUFNXiWN/Kpgf8mewoe+FfoUEsVcKGR1CsKtPClYpS4KCmFHP8WbBIRE2UN45+fMu5iGPxaO+q4nxhQtTkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HYoastPPZeKwaT9iIP5WR86KSpzIOU9kTIiS2cj6o8=;
 b=xPQyZinNgPVTWRhA5w4rrHBpliKEIhdEWYRbZthnKO3yVSS7TiWdyvOktJfV7GLfPhcE+xKP7Oz7TvKFaWcJR6t5qWthGXNgOafSXPaKKpGLs6AB9N18PfGV+WjV8pIxUoYl/XoGd7lTypx5/8gFFSNQ/Od1PG2RmUGBtn4WVoUig02ZAKDjz5Z6wFht0MwgSp6m/gFng6MlSUi1nsdIPlgm+RKcbkCAYcZQzvEQIYCVIxeFa5jl3aceJaGCEap1xWDYiv6OhT8hhZyXGSeh95av9EXj1K+zFQI8vAlCUVH1ZgI+3iqdHWa7srsMOUTVg2YEcf3WyWQxst51KDQC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HYoastPPZeKwaT9iIP5WR86KSpzIOU9kTIiS2cj6o8=;
 b=MlIqUGqCm/EpPT0AmutYTNqJmx6+eL/OKPltppP8aePO8fB/FpP2dFykfGO+RFqEMeszV4+LTPe+QoBdwgnTCYzkLRmJmCCcRwXDF7J2zsOH96agRHGA4WuwhSJxq1ze3b41S0WiWHAQfnBHXxEyQTrMEYC9Hti3B9n9vTpg+x4=
Received: from MN2PR15CA0057.namprd15.prod.outlook.com (2603:10b6:208:237::26)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 21:55:35 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::59) by MN2PR15CA0057.outlook.office365.com
 (2603:10b6:208:237::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:35 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:32 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 22/35] x86/bugs: Add attack vector controls for mds
Date: Tue, 5 Nov 2024 15:54:42 -0600
Message-ID: <20241105215455.359471-23-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd2e1f9-fbb2-46d4-83ff-08dcfde493fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qhgcqepi6mmEJri6Ya65JUPRkXdm0xRmru6ORPXitrz57ZLyswrixus3ZBHm?=
 =?us-ascii?Q?6KWtwjj00DO3vVoFyT4PC/E0RA8kj2gP5ohkWmH9keFVmdXerLvJUs1QjNpt?=
 =?us-ascii?Q?rNg6NkY0tnrJxjITpN4lxlff3WlkrT4QqSFx5EjfNwYoHh1dJkr8+7MEWniY?=
 =?us-ascii?Q?DXrYU0USsVg+cXr8oqgURAHK9HRAcRLL1Mbf2u64oAFj9c0i2R5L2lQIORn7?=
 =?us-ascii?Q?iLqA+Pmn79/Zbl+cm4qYyTuzu0iGuXGvcoB9DLwMqRO83dKxGW4U8FJxC/DB?=
 =?us-ascii?Q?6f86Y25aAfaomtHYF6kZdexmCTl1BmlxtK9IN/aM9sftG1Mh4bgbNskRtLZ0?=
 =?us-ascii?Q?/md+UVQXPRxScs8j9Tk6rScloZi9fA9jVppzwpsxRzJIWkWlXg14gQFvXd3u?=
 =?us-ascii?Q?nkZJq5K82x3F05REQYe97BFJpwf+5JKXi8km8ARMUnht1ykmi0MLHgEB1hjn?=
 =?us-ascii?Q?sqfH8FIglbv853kEfv5BC6qyEtdm1ucm+dCDegE79nHLwVbCsaOdlFjGaBSd?=
 =?us-ascii?Q?6h3rgwGFDXIFFxakaVIF9L+BbWCFh+s00EANJpwmUWBPRSz17GP8kvR45QFL?=
 =?us-ascii?Q?4cE5gbcG/njG4dVNFeQ9ig/2y0s/T6t+tTS/PY/UloIbt4ST7ovwF3zRDsze?=
 =?us-ascii?Q?lBH3CR9eIqN6lJAiW4n1gwSph5ZQ6amjCmGqAzZeHAW/FwnFm16Oa+Ws6qwr?=
 =?us-ascii?Q?WVYHDlZY/MKUqlxQFG8t5Cu41gxkWCChKwnHCl8Fylx5sV0vkbxqDHXRLVjA?=
 =?us-ascii?Q?tkj+62Zgs17c9Rqh6utnct/cScH5PzwVMrIF+lMZ53/0Krcz/pQuN8CCb7DM?=
 =?us-ascii?Q?HdV0vBzarUQ/HceDhPis1n/8mKY6pCmayFfV+O7ikSFnRXsBAjuOkjrkQ31v?=
 =?us-ascii?Q?0mUBvPKVfSg254l4/VjqHevEQzfPREtrEBkOCHOa1kpFyXEQ/FzaH5yojZQ8?=
 =?us-ascii?Q?pZ0RLpstaHmfWtNLzSeoepx30It/gfssn7PtBtNiwP9g553t81yoysPUOy+p?=
 =?us-ascii?Q?BZ245BvAJOX0EwQCtHydiDRE/WHHDQLskjjaagKqk/ogFnIfYViJbWjN4NFM?=
 =?us-ascii?Q?3MFwXtnzOy/qdFVHDCZ7Hb3HAq7IccnEUt0KQ4enavDHGpuCE4p4PW45pRF6?=
 =?us-ascii?Q?en70GjgwO6wzx53g35cfkA16rs9BzLybHnVl8s2cwUysyd86Cxtn2rX7TvPQ?=
 =?us-ascii?Q?A88HKQKMMJaYX6TeLYpRltiSoHtWS4DrxNv2qhcD4xax+a+fxHkJ+OtEYLPt?=
 =?us-ascii?Q?scRyK5LjkSk30W1bRI7EqnD4LI0wMdEcmNRWl5js3X3Bu+WWVl/rn5eqi8RK?=
 =?us-ascii?Q?p91OfCCZW0Xkk3SB0ImdhSB3qcQnboP8Pslhv3mLfQSkUHGq8+f/pxpOJp+V?=
 =?us-ascii?Q?0tvhSfshM+9Mg+KegpiDUjKBe/tiiXxeD4FEkhSAkfRKHYSnww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:35.6247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd2e1f9-fbb2-46d4-83ff-08dcfde493fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088

Use attack vector controls to determine if mds mitigation is required.

If cross-thread attack mitigations are required, disable SMT.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6a5996d3b324..aa916e1af0b9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -415,8 +415,12 @@ static void __init mds_select_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off())
 		mds_mitigation = MDS_MITIGATION_OFF;
 
-	if (mds_mitigation == MDS_MITIGATION_AUTO)
-		mds_mitigation = MDS_MITIGATION_FULL;
+	if (mds_mitigation == MDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_MDS))
+			mds_mitigation = MDS_MITIGATION_FULL;
+		else
+			mds_mitigation = MDS_MITIGATION_OFF;
+	}
 
 	if (mds_mitigation == MDS_MITIGATION_FULL) {
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
@@ -445,7 +449,8 @@ static void __init mds_apply_mitigation(void)
 	if (mds_mitigation == MDS_MITIGATION_FULL) {
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
-		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
+		    (mds_nosmt || cpu_mitigations_auto_nosmt() ||
+		     cpu_mitigate_attack_vector(CPU_MITIGATE_CROSS_THREAD)))
 			cpu_smt_disable(false);
 	}
 }
-- 
2.34.1


