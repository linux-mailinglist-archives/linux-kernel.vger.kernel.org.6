Return-Path: <linux-kernel+bounces-397193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A519BD7DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92EC283FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACAC21645F;
	Tue,  5 Nov 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qmOHG/Ds"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02B216427
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843731; cv=fail; b=ejsAQ1R52rhlRWO6HEhNjLexdsV76WLTINeKZPYQLKjExT8MvJ/nRcNw5jtASVZUjFL0zkSZBZ7nn2EgYlpPkSLFj8PMS5kHkg0G8gS4HGN7nyHPYDKuLAheDbv5H3joKKwOc81xCiyAfQDz+owirDqTIdAbWFUOvENA0ilVIpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843731; c=relaxed/simple;
	bh=HOGR22MLcdIEaAOrk9+NPOR/nTekIrelFjBpdOBI2xk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdBm8F9Znc6D1+6ksGNuQ2XDQlyVAaUDhhvdk9ZMVtK7isT7ngDKejHuB0shVt8Pj3/4V4IZJyf+ssgU+6eXvq5nU0aeYg3O6z4UPMRpQVqc0YW64GSxCYB685aKv0xNWKnInpX64xIcKN7LO6qdxb0Ynz5oQnIsJ3/8XGviB50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qmOHG/Ds; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjN7wyIvj+V5P6RVaj4Qjsbb7Zwy3Cgtlyxm/o2s6geWYzXnXXYWVZPO/JAdeDouJFyhredJ6cM5DNOTHepzFojOSZ8DNb9rMJbIGxBhUdpVOkEtp2H7creI+BtTy+MbsqHiBTetZY9GeGjVmqhflZdLCqvuRa0WSax+4h1xy8P3vnPXfc+DKO9T9bY7M+IpjMHMjCdnwmtEzuJaKfvre//hyXZ2TrbngD4n1ct/ImYi9uTCdrNSJLgAsiHeUBZnG3eoYG1xfmRqS+pqvN5Fp+PtlLaIUwyqv0U5NzdslNYqOP/XDQ7v6VYa2ym7NaRbK1VsPcAtDiAQcudhrOYU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBvK+G5mRcxA3ukAudDZXmiyg7Hz5w3mQvin8kluAZY=;
 b=wtuLo96eOLkoe16LAEz1QQiLm483gTkQs0Vo1DAfPQSstaRXo/kadMuAUE8dfdnRXLG3780iVER8i9gI5WvevwdjfxU7Dz7H0pbF7lwNslx79ezsylKl2oTkvtVFbZZtRw+TJ++4tfBq9F9IcZPN0ZJBVTIxThnrOzwli0pPYgcrUHYiPtXI+KBNM72pDtWph4ftX8YUZdCpf+Ku6EOZ0l91/h9J8oVuHMqo3hdJtXEbEjpUcDNq8dziItubCP2fGvHZJ3bhThoIHFstXjqXK44D32rqST1iOHCfR+do0O4Zpeu1PHQyXUYPSrTVf5Cu0TXbxEmZu8YssKtBhmLLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBvK+G5mRcxA3ukAudDZXmiyg7Hz5w3mQvin8kluAZY=;
 b=qmOHG/DsY8zIXbsn/fK3GVYYiU4tT1zoYKAaTQ0W5efuT37P3zTta8zeI/y2ST4biYCoZILjNyAL33ZRlp9L2FmYzMGsUkoAqpI1NZeOqPFqTDr5zpDdL3R+tAOavm6ee9zSqVKefVfv2xq9O/uJviNjlc1JYs9M9CrxxZCtz1c=
Received: from MN2PR15CA0045.namprd15.prod.outlook.com (2603:10b6:208:237::14)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 21:55:26 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::72) by MN2PR15CA0045.outlook.office365.com
 (2603:10b6:208:237::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.32 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:26 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:24 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/35] x86/bugs: Restructure mmio mitigation
Date: Tue, 5 Nov 2024 15:54:26 -0600
Message-ID: <20241105215455.359471-7-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6e32b1-fce0-4c75-2800-08dcfde48e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UI6Ti2silt1yimYLzrCCSwyU1VFEG2JF/rMARgvqVR4QOIQUWYn6S/MOcuyf?=
 =?us-ascii?Q?F4+uWuwXHISIxC0P8VpnKeIw7Xq5nqKdQcf/cmtAaqq2m9kn1mH2RGOVT+CW?=
 =?us-ascii?Q?ky4at5dot+wUmBGsd5td6FbPrew5ckBUg/J7TLsGkM1etxQtxtMGtMKQq0Wh?=
 =?us-ascii?Q?BNXn0StzyWK4HaykO4dDecFL0qYPRYRfDxuQvo6k6XGGrT9gKwVcc5+7KrIS?=
 =?us-ascii?Q?bWQt8JdezzztdszW9h3A2w37QvUOjFTbXpMecZeTsxxC/K0zdBTnpVnJBJ2o?=
 =?us-ascii?Q?XJ4Htx3cQvLavrBlcVqV4MRfcp/ajpLxjdACkIt07eOfRUlR4nBf/RB8nh8l?=
 =?us-ascii?Q?BpiV3gffv0a46M7/WxMClIyb7jawnIB8+5Z8qtt7DRfJT5a1BKADfoaKhOBw?=
 =?us-ascii?Q?uTAeZfmkHoH4JzZOpUeaN82I5gqSO+t5aL1mKmo90GKh+NGUy8CoEXLcxzJB?=
 =?us-ascii?Q?SQtLc9XKKRwLoZ8k/feTPWN7s/z97M7twnzWPqQjNohtorAn3b4EVbb96sCq?=
 =?us-ascii?Q?X7SAFQDKBwShicOW370itt22Uu2OmzzJRY2/ukIQdlXvJCnGArfAczCVAq6A?=
 =?us-ascii?Q?vuXJrEPmYhNhkhvXu74SaavP1rIExfLv2Mvf2LgRY0arGmGOqiVUoxBpEbeu?=
 =?us-ascii?Q?x/HWe3s8HT+dACVUfF2U5zspl/mskNIRLnGQDiNDSs38GiD1vZdj32zk0MpW?=
 =?us-ascii?Q?IuCv6L3/15U3Rn6S2qU2e+nPWoNQRh7CdmDXrGyPUz0Dt7nQaa/j9P1B+Dfx?=
 =?us-ascii?Q?wL0qtuFkGjZwhdFx4TSC6SiSxbtIkiA55Dro5X2ahEJS+aieDTf8KCwdWQfu?=
 =?us-ascii?Q?2pVZw8U+XrYZ3Ik7fr1iaZsualwjEtf2WU3xkz3F5gM+rgLxcPrwyAANGZCL?=
 =?us-ascii?Q?GB5os+aTOH8s6IxAboe/H6KvC1IF1obz5qKi12/9GzwXFkK1zwQll+iNagk9?=
 =?us-ascii?Q?gLLspyLSEDIajHmU38SegjL51ndCY2sFkEY0u5o2gwK0n9lbYAXtZBkNcyh+?=
 =?us-ascii?Q?J0KtAQpY+sNSZFg0X5VoUifkR0hIH9G0pc7njwUndAV/eeiPTiwQrrUksgns?=
 =?us-ascii?Q?ZcVlMARAuQhcjPCMxy0/giYoYP3DvJyaoqyLlE0SX7vJJxqhSEWIXgkczrj8?=
 =?us-ascii?Q?bVxJgR3CYngNoec1aAqjWOLHWNy8id57fqGiFz1S/hJHXRT7mZqv+kk0iFtL?=
 =?us-ascii?Q?X+o2dG9lGs+yUs+gdR9kYQ0ty/2hc563bRsEkEihh4TF+Yebnb/cz7QUYOQW?=
 =?us-ascii?Q?vjR2JzZn5MdjpQ0AEII8/IcCaHhz2XceDP1nJU4MsQnLa59EVqH/vGT1nELy?=
 =?us-ascii?Q?37KFg3x8rkJB/EgKUDJVtZTjzioDwls9AcmzsQGOLcOzQL7c+aC/PUwGyvnX?=
 =?us-ascii?Q?h0H1nR+AmBI6R0VHPI8CXosBciGXUAiFx+MoQrJqlxoZwJxoUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:26.0934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6e32b1-fce0-4c75-2800-08dcfde48e4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013

Restructure mmio mitigation to use select/update/apply functions to
create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 55 +++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c676804dfd84..1332b70e48f8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -68,6 +68,8 @@ static void __init taa_select_mitigation(void);
 static void __init taa_update_mitigation(void);
 static void __init taa_apply_mitigation(void);
 static void __init mmio_select_mitigation(void);
+static void __init mmio_update_mitigation(void);
+static void __init mmio_apply_mitigation(void);
 static void __init srbds_select_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
@@ -190,6 +192,7 @@ void __init cpu_select_mitigations(void)
 	l1tf_select_mitigation();
 	mds_select_mitigation();
 	taa_select_mitigation();
+	mmio_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -207,9 +210,11 @@ void __init cpu_select_mitigations(void)
 	 */
 	mds_update_mitigation();
 	taa_update_mitigation();
+	mmio_update_mitigation();
 
 	mds_apply_mitigation();
 	taa_apply_mitigation();
+	mmio_apply_mitigation();
 }
 
 /*
@@ -505,6 +510,40 @@ static void __init mmio_select_mitigation(void)
 		return;
 	}
 
+	if (mmio_mitigation == MMIO_MITIGATION_OFF)
+		return;
+
+	/*
+	 * Check if the system has the right microcode.
+	 *
+	 * CPU Fill buffer clear mitigation is enumerated by either an explicit
+	 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
+	 * affected systems.
+	 */
+	if ((x86_arch_cap_msr & ARCH_CAP_FB_CLEAR) ||
+	    (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
+	     boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
+	     !(x86_arch_cap_msr & ARCH_CAP_MDS_NO)))
+		mmio_mitigation = MMIO_MITIGATION_VERW;
+	else
+		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
+}
+
+static void __init mmio_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
+		return;
+
+	if (mitigate_any_verw())
+		mmio_mitigation = MMIO_MITIGATION_VERW;
+
+	pr_info("%s\n", mmio_strings[mmio_mitigation]);
+	if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
+		pr_info("Unknown: No mitigations\n");
+}
+
+static void __init mmio_apply_mitigation(void)
+{
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
 
@@ -533,21 +572,6 @@ static void __init mmio_select_mitigation(void)
 	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
 		static_branch_enable(&mds_idle_clear);
 
-	/*
-	 * Check if the system has the right microcode.
-	 *
-	 * CPU Fill buffer clear mitigation is enumerated by either an explicit
-	 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
-	 * affected systems.
-	 */
-	if ((x86_arch_cap_msr & ARCH_CAP_FB_CLEAR) ||
-	    (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
-	     boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
-	     !(x86_arch_cap_msr & ARCH_CAP_MDS_NO)))
-		mmio_mitigation = MMIO_MITIGATION_VERW;
-	else
-		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
-
 	if (mmio_nosmt || cpu_mitigations_auto_nosmt())
 		cpu_smt_disable(false);
 }
@@ -670,7 +694,6 @@ static void __init md_clear_update_mitigation(void)
 
 static void __init md_clear_select_mitigation(void)
 {
-	mmio_select_mitigation();
 	rfds_select_mitigation();
 
 	/*
-- 
2.34.1


