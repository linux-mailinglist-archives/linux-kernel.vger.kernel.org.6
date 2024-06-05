Return-Path: <linux-kernel+bounces-202815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1278FD17D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30DCB2601A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B394D15350D;
	Wed,  5 Jun 2024 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dn11wMf1"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2A153BF8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600801; cv=fail; b=UsZF2C2c9IuT8aG50x/nhgYh9T8QgvwCwmRgJBcd3snDjs4WMqyg6yX3buOgITkO0M5cKmJdzsphv+o9GQmnh1vq/5t2JLOR3iiyHGDxRiUKOYf/yaQQ38vWKCPoG8cqAjN8SzGXMltW6zxWfJTaA0ygywN5ZOKv8U0I+XDVpQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600801; c=relaxed/simple;
	bh=cqfNPsWBdJVyQ8eUoP0eVCse0W3dNu7fO42O6ApdzSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0qoaCw/o61j8cunm+CrzORIQ9dEwHijF6I5YMV7NlrSu91RADjCtjXFquOOBduo2/ex+cEnoGGCUuWfSBOhjVFjtrndITSDcuVT+xRKmqfCRNO6h6lLOCYjqf48sx25SjfCQE+cw00EC4rGpYWZ8kIyNp/ItT1bqlFAbNbOo1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dn11wMf1; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/6iIaQ9CAwVzcwkP7ehcIbgb5A5jmHAWvOvdg89k0cbo9LfvOY+c7QtFQvNkwKQEKJ2MABjR18Wiw1v0WoGnBToecoZ4O+XJkIO4LjNmSIJ2+YtyICXDgqmZkxHi5m8HQOPpBdQSteVSLI4EoWpbuD3hqfapt46c2vGTS0uFmELhCbvuk2RV4caX31vC+xcJ9ypy0KJnUN5YNTPQ/Jw5lG41Jl5F6aHOBDJIu7wA6Sskk9D7o3G8PXmXw8IIM7G6N1UyBtbHpZhGGTBu7LR6gotmpiCvwW+RQq5/qb8Z/jrbH0DfCaaAFEtfeYUg8CdxQBHMpEmSiHQfgK7YBgJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gugp2oJb36UvrE5l8Pcwm1vXJI0qRKIt6kslbn0n1eI=;
 b=CF2gp+877+ySN185sH8NqLGr+0KDOzfTwRju2bq/Wkehry4+CvwANDQ1+zk+U3ndjeGgQe7Z6gdYucTwlGqmPl2+vqeBNdAs04k21+C2zOzUWNP4zX2ckhty/T2527aC7QQnfEbicLlp8ydfQcQbRyCjlOl6xcPMbvvl6KFLz2WIKGFBVsowHZJr2tEt6qbFmhc6keQ+PWRCJ72HZ6FliSN9x4zfZl0BKXoPdLBmcu2a7ybadwHYY4V/Y84bSQDQCh9rdSkt/3o4ZuuLIXSMyw4lBpERSCB3/KBmbNmi/Z95q3qsRyBqxjWdHtPFhbpvFhcVvl8l8+85qH+ZHDN+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gugp2oJb36UvrE5l8Pcwm1vXJI0qRKIt6kslbn0n1eI=;
 b=Dn11wMf1CZuJZDtCqwsamHKHDDslRWyNNbBhJqX6iOw1zJ7C1vARbMf6quHloLVcaOJOgzxRABPgQuqmVh+m26sRvUumtg+Q7E+Jlc32q6wHtqhZoaCX7Dz9yOTYrLdm7dxDLyYMfBDbmzUUYz1OYgY7cgy9U+V7jBzx5VxBJlY=
Received: from BN9P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::29)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 15:19:57 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::b) by BN9P220CA0024.outlook.office365.com
 (2603:10b6:408:13e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32 via Frontend
 Transport; Wed, 5 Jun 2024 15:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Wed, 5 Jun 2024 15:19:57 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:19:56 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v5 06/13] x86/sev: Provide SVSM discovery support
Date: Wed, 5 Jun 2024 10:18:49 -0500
Message-ID: <4f93f10a2ff3e9f368fd64a5920d51bf38d0c19e.1717600736.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1717600736.git.thomas.lendacky@amd.com>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 493ebccf-69f1-4245-16cb-08dc8572f598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CiIJUfOWCgBIk50NtxX+FmuLrXq71q2oOODZlSZSnkapN5g6bDNUJqTDepzt?=
 =?us-ascii?Q?4aSpkS4sbApFvofhajs/OgePjzFrE0qbV8abNvtcB9TIFZYgSx66wbfHu2MO?=
 =?us-ascii?Q?FiMrm4NnPDvsd2F4UGoI7avGYWulC6u2FHaGhRz768TJ/Oa/094sjDd2IIuk?=
 =?us-ascii?Q?jfYsu6lrbu1HZesipd7UXokBqY539D6oZVGTp0M0dNOb9KwvbQVVKAOBH/WX?=
 =?us-ascii?Q?d7EzmGc1tDhrmpJI2+6vkHHMf+pmh2bV0lJvEPSsCT0XuSixRNJMUm/WTAuO?=
 =?us-ascii?Q?r6Vazu/KRBsqC3A4amOEY7M0IE86aLm1uqNQ+Km04/AhGDPkEEVy5duRr8vh?=
 =?us-ascii?Q?z25d/WA2SlywxPh5bdPjVZOBIQctjcBRS07ehJzSZ7YI2D9qFv46jv7ItVLl?=
 =?us-ascii?Q?RO7PlDJ1NlK4fYxibxjIZ+nc+EKIg7EoQQjBfGS0GaJFIwEaffR8VVPh5p6l?=
 =?us-ascii?Q?jwbPqgVBZ8F2N3g97nmEKLiV0zpADwZI6e4V2bRplzUHtzvjKSof4cJL1Zum?=
 =?us-ascii?Q?JG1SNWfCrihgETaXDM2rPQMCe30rxU2c4wQpB51UdI+qzr9VUnEjapfiAh+W?=
 =?us-ascii?Q?sf53uE141DubI78F3QR094s4AhnUU92SJLGTSVcQy2hTeL7uNk2KYX34j2qU?=
 =?us-ascii?Q?gZC+9S98Ip3em31jUi7ACBDWDQ6p5ZHwspI81D/5OXCBZp97W7vdINFHJrBA?=
 =?us-ascii?Q?1EaMz0FA+W2ylbfgivR9eVRHSYNUR49HVZrw1ZCCg8neRqWByqUECD8++fs5?=
 =?us-ascii?Q?38pYM/P8UraMmo3GuNRAXf0UP1pVboN+uHlzOz/4XM/VT37k/Hbw0iizumwK?=
 =?us-ascii?Q?lYPYyJWYluA1DahJAJ090NvXcYUklLFx8rDcieDnsTJyQ2nuPHXAwlzGI/wt?=
 =?us-ascii?Q?VWprzKge0icpDAl8F0geRBtjlQ5LhWEhOmcaaGwGJSnnUHHQvtFjZSG5B0ym?=
 =?us-ascii?Q?GW/4Q6KCZArkuIb7m0b3FrG/OLwY188D+YgHPuxbhT2eyp7V8CXEjo/fvTM5?=
 =?us-ascii?Q?lsUpyV/xy0FTyOPdQj5m/q6cIIhMJs1TF1tUFxGdXzlIh8ncw1E/gf+lmAvT?=
 =?us-ascii?Q?8woTA20OncNpX4vF8I2g++Q36C0O1an2tnFdCoSSIXxb/qj8d9bDdMBjntEX?=
 =?us-ascii?Q?YWy2aO1KoKBGEds7QM/q3aCWQ3rssdFYLMlV+nWnchAhvPU0d4LUT/Ul2YnY?=
 =?us-ascii?Q?T2Zt8otamsoh2UyDZIWe0GonF5x6Dx4409I7gP84Wf3rGPDWsVRvhYDMo5xD?=
 =?us-ascii?Q?uffFqaRjpNmbPMoiIheoStPWysHd197yi8SFgNZaZ9a6vWST3eUZvl5dkv+O?=
 =?us-ascii?Q?sROwp7GZdY5oNJO930fUc8ezZk+pAhoB98IbHV2pArY2eLt+Wrs5bCAI+9Xw?=
 =?us-ascii?Q?eqo0z6w215pDPqjT5YO+E5UZXsqL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:19:57.2294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493ebccf-69f1-4245-16cb-08dc8572f598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916

The SVSM specification documents an alternative method of discovery for
the SVSM using a reserved CPUID bit and a reserved MSR. This is intended
for guest components that do not have access to the secrets page in order
for those components to call the SVSM (e.g. UEFI runtime services).

For the CPUID support, update the SNP CPUID table to set bit 28 of the
EAX register of the 0x8000001f leaf when an SVSM is present. This bit
has been reserved for use in this capacity.

For the MSR support, a new reserved MSR 0xc001f000 has been defined. A #VC
should be generated when accessing this MSR. The #VC handler is expected
to ignore writes to this MSR and return the physical calling area address
(CAA) on reads of this MSR.

While the CPUID leaf is updated, allowing the creation of a CPU feature,
the code will continue to use the VMPL level as an indication of the
presence of an SVSM. This is because the SVSM can be called well before
the CPU feature is in place and a non-zero VMPL requires that an SVSM be
present.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/msr-index.h   |  2 ++
 arch/x86/kernel/sev-shared.c       | 11 +++++++++++
 arch/x86/kernel/sev.c              | 11 +++++++++++
 4 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..1826f1f94111 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -446,6 +446,7 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_SVSM		(19*32+28) /* SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e022e6eb766c..45ffa27569f4 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -660,6 +660,8 @@
 #define MSR_AMD64_RMP_BASE		0xc0010132
 #define MSR_AMD64_RMP_END		0xc0010133
 
+#define MSR_SVSM_CAA			0xc001f000
+
 /* AMD Collaborative Processor Performance Control MSRs */
 #define MSR_AMD_CPPC_CAP1		0xc00102b0
 #define MSR_AMD_CPPC_ENABLE		0xc00102b1
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index c274fa826ef0..e91fcffcf602 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1646,6 +1646,8 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
 static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 {
 	struct snp_secrets_page *secrets_page;
+	struct snp_cpuid_table *cpuid_table;
+	unsigned int i;
 	u64 caa;
 
 	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
@@ -1694,5 +1696,14 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)caa;
 	RIP_REL_REF(boot_svsm_caa_pa) = caa;
 
+	/* Advertise the SVSM presence via CPUID. */
+	cpuid_table = (struct snp_cpuid_table *)snp_cpuid_get_table();
+	for (i = 0; i < cpuid_table->count; i++) {
+		struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
+
+		if (fn->eax_in == 0x8000001f)
+			fn->eax |= BIT(28);
+	}
+
 	return true;
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index ea4677177396..5ba1c481b867 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1337,6 +1337,17 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	/* Is it a WRMSR? */
 	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
 
+	if (regs->cx == MSR_SVSM_CAA) {
+		/* Writes to the SVSM CAA msr are ignored */
+		if (exit_info_1)
+			return ES_OK;
+
+		regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
+		regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
+
+		return ES_OK;
+	}
+
 	ghcb_set_rcx(ghcb, regs->cx);
 	if (exit_info_1) {
 		ghcb_set_rax(ghcb, regs->ax);
-- 
2.43.2


