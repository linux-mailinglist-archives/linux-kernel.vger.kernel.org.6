Return-Path: <linux-kernel+bounces-397202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F939BD7E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC7C1C20FFD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ADF217336;
	Tue,  5 Nov 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a9d/83IC"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73542216425
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843738; cv=fail; b=tHWXTFvo1dKdxzd/h77k2CHz3bWWQsbOMLIGfMXI4ZA6dy0gp9bxO18AW/JeHpLElW8r8KSqAZORZm/LI3AQqWnjivg2VrBpyf/Qg6Zl1XQTEcvZPZYk48qvJMmiPYd/kmKFSSzXutjNULqKHSitsqQCe/xAGapIob06xILnMsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843738; c=relaxed/simple;
	bh=0XKFr+RwRYESF2VuFyqF3H+SY+NZ7sQJq5f0g1/pMHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlT/9ERcKr78w/ovvNkIwk+xC8g5WBfKbePbsCtl2a9/wcS2ths9DDG8qR8rikrHxzTt8xiRT4MtOoDx+YwAI3rhLuJZQdagZFtwEFDUvXvSCnU7uFph+OlOEIiqBfd5RpPQN+J1U3E2bJTBERiiE1ZnteBeI7TXzsJeKeB2yq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a9d/83IC; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FC6dH2Za7aXsRxpoAfHGJwpK6qgK1Y57OnCTxEXNqIisMpqkYQCHs3VCUdbJQdtw3ZPBLsR4ji31I0yMDONkMHr7VAI8NSINWZmWKMYRrFzYWDLsh2fe/IhLyH4K4P1pLceqrsGsK5P4xDzl7AU9Gj3za9Bhx0w+D6qY5ZnUyYhi3ikqzcs7ICaVrtcMhpjdOEkrW+rXhG3mDgaBHXtm+p6tw7ydDKpr5L4mCEnBjMjxs4O9/gfsbks//U5D1/nng25O3HXYdO+LGEonImIL00H3BWvwFi0wWIH1wk4mJWybNvnkOb9kUZXiKTdQFWlBHbffnJQTA/4dz7wysso8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVLGzChQABCmSrmcrnY1D6noRTi8oK2ZvHkK7Fk4wuk=;
 b=I+wbyUrY8LOKsBD/cJNbhmkZL6UuzNWdC2Wz9yveDiCHfU/xU5heRy6X048oF+9sOKH/fywWLWaXDd5WoPszw8hS3k4am7bUpCKXgO1eX5B0zOXyKWOkUZl/ozJQ6CMwlm1BiDvva+u4TEqJGMDMtl4Lq8ukryDloUW8dnJ0oo2iX5OhmVoKQ3DKU/oZOhQAXzopw8RsyGJVNTILW8b91bA4D4xYpJywCPo6uxtjPCFrNO8pWJiKmstluXKMRL0zOTBSGYccWst489//Qc4CTLO4UEZvrFR3d6Td6WrqnYoqo/uUY3hnLgHPw5vZlhGV2FHx1ifPTk+0Ny3aIa1U6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVLGzChQABCmSrmcrnY1D6noRTi8oK2ZvHkK7Fk4wuk=;
 b=a9d/83ICkWEs+X8ppe4afA1L0/rSkspl0cYynLvEXRJvMhSrNEyGUzBQEIBv8s/KgrVm6HnAoCycgpd61JhTFNCq9YA86hPB5Rkr2wDXPsTyZgGbM+earDZ5I8r8oBQ8n+l+Ok+XRBE+BLgDQhdMxqTh9Jn98GCjq1KRq5lI3j0=
Received: from MN2PR15CA0038.namprd15.prod.outlook.com (2603:10b6:208:237::7)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 5 Nov
 2024 21:55:33 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::29) by MN2PR15CA0038.outlook.office365.com
 (2603:10b6:208:237::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:33 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:29 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 17/35] x86/bugs: Restructure l1tf mitigation
Date: Tue, 5 Nov 2024 15:54:37 -0600
Message-ID: <20241105215455.359471-18-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfa514c-94a3-4697-1b3a-08dcfde492cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3PB7zsU56vnb8zvc7T+dGRgSBvW9xmSWcFfzq/zhs/iVdvfuobjFqRie4IVR?=
 =?us-ascii?Q?ZV4Fhs7FPkNz7Scv18WURc2PLMtSvbs3Q7nEqznr9aY1SzAqr1Zki/BR6/Ng?=
 =?us-ascii?Q?nuL5aAYYjVC/dTHzyRWNVZ8v2EyPIKKp06int+rz020+SqTc7jC8zKmFrNW1?=
 =?us-ascii?Q?x5futCVw4OXY/k/Bq4pV3RbvRJcjndQwN0bECpHnaIN1ytq4FAO7xlabZ0ZH?=
 =?us-ascii?Q?guCLmHSrcJ85fbS1ik0/Dbr8NIdBq+w8YVxm1QhnKtw7o+SqTO3Bbn1CjLcf?=
 =?us-ascii?Q?zdyRlfwxwqEsGb7HdlTfIhLjEpmEh860cItHZEdGp6o4yFNAbrjEl4707rfZ?=
 =?us-ascii?Q?VGuNgOaXBIf8Gekom0Zxb8ggzxX9nvAY3l0DWLzuWv105xkFYGH9Qa/aIFHC?=
 =?us-ascii?Q?d5K5uFtjoNhVkOTBvV9XGaRV8psVDPNwHe5y3aabR3FVoz2DqiJjFySVtWaF?=
 =?us-ascii?Q?MCO7LpKR04NLMhVYvfOzUx/RcvgQvTWn6qsfQx68KdwMGVLgQg+N2zLAb95a?=
 =?us-ascii?Q?PCnLJKP/hlivRxEw18JC4enzy9A+jt8LYKEMgbeeBoEMgGW+qtleHecogDtx?=
 =?us-ascii?Q?IqHk7r+XPWTM5XkNg9gYUYM7gtr/kTMR2v6HE4j9mrdPGc+1Jl5MCbsJzgt9?=
 =?us-ascii?Q?cW+Vb9aBrh40C1PFdFW4C6UMdjG6oNzHLl2Rq2rUhC+bWPyi/7RWN3LPq/RF?=
 =?us-ascii?Q?WKwvJFSKMm/migtyHm6NUr/husYsfzlQFxw9/v6hsdrFyDpjP974P+0zxgE3?=
 =?us-ascii?Q?ESPn4oWWC1lO/odCsctZlN0JjOfbuLGUKeucdn0mnMV11GW1yLvUvAv4G6Kf?=
 =?us-ascii?Q?l+5TtlpSRNlGHMcpRPwFKYWIIY47+TA1sr/twmPAvSHTerZPT7ssJ0YFfCl8?=
 =?us-ascii?Q?b7oQt9hlptf4iQMc2FXJaFq6uhQV6CDD1CvGZVR6ri7Neh9Zr/tVtImzZvnn?=
 =?us-ascii?Q?IWJpiomBb2gvxKeFhRaTNU2c2klPWGpHWVmjYjHgcw7mMT1AstEy34Oh+6BC?=
 =?us-ascii?Q?yr55J0SUTbTRQU/Kqa6oj70Wu0ph3jdmzNwWy+G01dFT1B/viAcmkdOdRzX4?=
 =?us-ascii?Q?TD9KVWWDIasFp06BKqkR4znnfXBeSzQfyqWRUS5a4PAt196rlltBVi6dZ2Kd?=
 =?us-ascii?Q?vw9y2OQKfkPc+2gknMSg0EmOb+7BJDyR+2UfzUJnQJJWDbYgxwe0nilNK38o?=
 =?us-ascii?Q?KNDw3Gyka3hE5rrtBgzRulK3+jDGe4vl4LlJg+WdlB5v9UzGmyIeVIu9Mu7G?=
 =?us-ascii?Q?OXplUlq9GeQ/BZZ8T5H0Az4EQSI2H0L7kcZAYwNiDNywQFZ/B/KVux/qXcZg?=
 =?us-ascii?Q?UAtUaipzT7S0z/xQgF2tw9w1itXp9gfH35J4EO2P06MdGT5JZP9/0yGUdU7V?=
 =?us-ascii?Q?xlv4bk6P6QmXJ48JKhmRAIX6em2nl/69yaBOaFsF0+nYVcUgAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:33.6560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfa514c-94a3-4697-1b3a-08dcfde492cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199

Restructure l1tf to use select/apply functions to create consistent
vulnerability handling.

Define new AUTO mitigation for l1tf.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/bugs.c       | 27 +++++++++++++++++++++------
 arch/x86/kvm/vmx/vmx.c           |  2 ++
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index ea4b87b44455..49da4636ce5a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -743,6 +743,7 @@ void store_cpu_caps(struct cpuinfo_x86 *info);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
+	L1TF_MITIGATION_AUTO,
 	L1TF_MITIGATION_FLUSH_NOWARN,
 	L1TF_MITIGATION_FLUSH,
 	L1TF_MITIGATION_FLUSH_NOSMT,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a3bbb0831845..98ef1cbc9e2a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -67,6 +67,7 @@ static void __init spectre_v2_user_apply_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init ssb_apply_mitigation(void);
 static void __init l1tf_select_mitigation(void);
+static void __init l1tf_apply_mitigation(void);
 static void __init mds_select_mitigation(void);
 static void __init mds_update_mitigation(void);
 static void __init mds_apply_mitigation(void);
@@ -225,6 +226,7 @@ void __init cpu_select_mitigations(void)
 	retbleed_apply_mitigation();
 	spectre_v2_user_apply_mitigation();
 	ssb_apply_mitigation();
+	l1tf_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -2533,7 +2535,7 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
 
 /* Default mitigation for L1TF-affected CPUs */
 enum l1tf_mitigations l1tf_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_FLUSH : L1TF_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_AUTO : L1TF_MITIGATION_OFF;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
@@ -2580,23 +2582,36 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 }
 
 static void __init l1tf_select_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_L1TF) || cpu_mitigations_off()) {
+		l1tf_mitigation = L1TF_MITIGATION_OFF;
+		return;
+	}
+
+	if (l1tf_mitigation == L1TF_MITIGATION_AUTO) {
+		if (cpu_mitigations_auto_nosmt())
+			l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
+		else
+			l1tf_mitigation = L1TF_MITIGATION_FLUSH;
+	}
+
+}
+
+static void __init l1tf_apply_mitigation(void)
 {
 	u64 half_pa;
 
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return;
 
-	if (cpu_mitigations_off())
-		l1tf_mitigation = L1TF_MITIGATION_OFF;
-	else if (cpu_mitigations_auto_nosmt())
-		l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
-
 	override_cache_bits(&boot_cpu_data);
 
 	switch (l1tf_mitigation) {
 	case L1TF_MITIGATION_OFF:
+		return;
 	case L1TF_MITIGATION_FLUSH_NOWARN:
 	case L1TF_MITIGATION_FLUSH:
+	case L1TF_MITIGATION_AUTO:
 		break;
 	case L1TF_MITIGATION_FLUSH_NOSMT:
 	case L1TF_MITIGATION_FULL:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 81ed596e4454..fe99022d14c7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -271,6 +271,7 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 		case L1TF_MITIGATION_OFF:
 			l1tf = VMENTER_L1D_FLUSH_NEVER;
 			break;
+		case L1TF_MITIGATION_AUTO:
 		case L1TF_MITIGATION_FLUSH_NOWARN:
 		case L1TF_MITIGATION_FLUSH:
 		case L1TF_MITIGATION_FLUSH_NOSMT:
@@ -7634,6 +7635,7 @@ int vmx_vm_init(struct kvm *kvm)
 		case L1TF_MITIGATION_FLUSH_NOWARN:
 			/* 'I explicitly don't care' is set */
 			break;
+		case L1TF_MITIGATION_AUTO:
 		case L1TF_MITIGATION_FLUSH:
 		case L1TF_MITIGATION_FLUSH_NOSMT:
 		case L1TF_MITIGATION_FULL:
-- 
2.34.1


