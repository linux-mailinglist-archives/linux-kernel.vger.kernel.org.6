Return-Path: <linux-kernel+bounces-202813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E298FD17A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5178C1C21675
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488713C488;
	Wed,  5 Jun 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4lXxvP9f"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E619D882
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600794; cv=fail; b=LD0KTJ1Gv9VIHZoaXdOuCkm+UfAUxx/bR+2BSjshSgl7NsR2R67gSw+7Lp2pRDlHFUfKdHv+22uIE9PEcn6/eknsTGUGP9KWf97Fb9VAt/CgAF5xd1S2Nz3neOmEBrGTkaUD0I9UIGaQEiO8MoAdJ05B/nwEjAelUNowFHidWI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600794; c=relaxed/simple;
	bh=+pJntrVvob5QtJIhdht3R+wi8NtBtnx3C2mrnzm2+2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnchITlBpeGHZ7bRiECbtzqd7XpZILOgPIuJvBB816kniTcis7cblc5e/bdLxruA1EVvRQZ/E3MC0v+axvER7AARm6DTS2bs/Sy0peQVh4CIUgk4a3bGLcinkq+BiQZLZeD6Sxhzv0aCOHBBHteqNoKHymf3V9NmL+li4c2PNAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4lXxvP9f; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh5ITPLf0YW9+DF7tFc4L1yK0+Wd+Tr2fOejlXFIQT8BL5ZZwoL6PzYy/HMX3KyTey76SUCDarFyJYg4/7Kj/SZdwSx1wATnSqgNcZoPm+FH2MuqZaFIRmuFykkiRFoH0OrMo453wb2gSJP24qlp3I8LoFDO2FjDAY+z/EoYgm+pAwMFVHN8fBRsIKeg2Ge+psBDIjeL5vSpYVzgpr6fwqlLoF0wpG0F0MbwrZ4ehrQH0u5NX3jWIdfFsjxeGI0Qo9g3PJ9Er64XDNgHZ4i6CnH6soTBAMxX92Tf7OmRUi3+LHSJ5VeQPvUl8nR5gd+h6sjsdDvrCHzU1w0Kk4Oy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGmruK5i7QuPSLHWJrChWdiBxGcDlyKcpwb55Vl5XHk=;
 b=GKBpOZtQLK9c6MQgDQWo2j+aFj2L+xQ0CBOb9h0E+QFtH0OkbKYm2pdnUE3KCm6DSGw+UXJrw+ScSEuL4XeUczZJjYweBCbe9piAAN0AqamDE+OpezsZhTM4IaQeKJyy7j20FqZ0pbGi24zbd81sGINpFt11FSYdcILNtYdE6ccjA+Ixul1cmvCtbFIKnowIrMDBPc5qeEQtJnDozU/Y4aMc1hNNJfuWwsNLcWiZep2VI6EuHJ4SPIiMQmyR8J7qEQc3NlF4XeeE5kBxEVpxfFgIsI11KAKCTIAA8vtnHgw9b4884+pP/eJu7KFghaTv76y4EZLPX4FvtsfvbBVMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGmruK5i7QuPSLHWJrChWdiBxGcDlyKcpwb55Vl5XHk=;
 b=4lXxvP9fds30WmboLHm11yBfy7wH9vPdNXAT9puiLxIleBBa5Cp3qxQWd06+qVOgHpOoRvvNyqGlwa2q6VrEt8DDOSCFlNsbloosYuxJ28juklNB7Yupay7xSvsLMpV8cjDVpamYG0gSXkNHswDE1blRUBvXUSPhpKYfn066TQI=
Received: from MN2PR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:23a::30)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 15:19:47 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:23a:cafe::28) by MN2PR03CA0025.outlook.office365.com
 (2603:10b6:208:23a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Wed, 5 Jun 2024 15:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Wed, 5 Jun 2024 15:19:47 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:19:46 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v5 05/13] x86/sev: Use the SVSM to create a vCPU when not in VMPL0
Date: Wed, 5 Jun 2024 10:18:48 -0500
Message-ID: <bcdd95ecabe9723673b9693c7f1533a2b8f17781.1717600736.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 7121651e-6a81-4792-1363-08dc8572efad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c186lC7rITyxUWn7w5I0oJA9Q11UweSgulE6DyaWW/cCyTDza4aNS4TTdp4P?=
 =?us-ascii?Q?XXDh24WFL9OfwHJJBmTewdZG32VyhMJv0iKqFrzo6eVbRf1Izarg+jLXRQA2?=
 =?us-ascii?Q?CF/Eu7bBgccCc19wDgr6JMfUH+Gji0C59iWwBzKqWAPovBFkcLI6sNa1t6eu?=
 =?us-ascii?Q?/87KY0BWteL6Fn9zdCpuDJbHSc/yfo2T9QFfwgHA33o7zmVx1xBse2hinH06?=
 =?us-ascii?Q?ZB/WNgOpSEU1T3ZnzA0V+Z86ckhEyB2Stvoz3ipRGVYUUzy3fsci+nsF7dAT?=
 =?us-ascii?Q?2qbJxOd5ZXBlCsAsHd6SIEGPH45yn55/k+YPDqgN0FBjIroo1O8qkQ6F7QV9?=
 =?us-ascii?Q?3ejPbB0yVleLeiTabzQc8zzykk2R+eAPrfJaTLRhG4YbfSirSlZkPPc3cjzt?=
 =?us-ascii?Q?OLQhS28xRPRWjUaOv/57MZ+iGde754rJFJ2B4HxRajyo98+08I3SEWQSSTef?=
 =?us-ascii?Q?oHrPxjpa4Rh/zn4fwkkIFTVWcRIDjnUhM0U9Kk0oowMbU+W5VEjJEiIrTHJm?=
 =?us-ascii?Q?5NJ9J1UxWEg7tOVCUBD7ifiizavcoDpQ+J4ZRlD5gieQ2Di9hK1NUAoN55XF?=
 =?us-ascii?Q?tTSpG5ZpSjxs/yal+FNlT/+KztuMmTFGxjWz+rk5420E40Hq1ziYPyEti1jd?=
 =?us-ascii?Q?4PNdtZSxkpJhpbtjiMscnzR2gM7MTjsBNCygfBG6swYOdf3J7hAhmEMyvbGg?=
 =?us-ascii?Q?wEMuYIdLLUdyrcJZ5ZqUikMWJTv8vEnXsggOynFPVoInCl43hSE1fmdnb3p0?=
 =?us-ascii?Q?yxRbjw3hkk12nG/N5jI84YTVju74tq32h4xVGh7msAbqdcRE5zV2jFxkOF6N?=
 =?us-ascii?Q?hV9LZeKVO/Czn1N0a3Gl+a9gnlM7xXyo4b9wcmSctZqNALqb9d81klIV6ZUn?=
 =?us-ascii?Q?bBK/7tRx+mqZhxErFHlBiUiGxfsr7jYEb5pOj2N5gpDhFlwSub2Lru65YbQo?=
 =?us-ascii?Q?e+IhMRIyrrC8aiBBWtcJAXNhQleKZo6dlmPJoSCWioXF2PBYuBm5GYZIwWIb?=
 =?us-ascii?Q?lCMsDdUR8JEUhtekVkEnqUuP2/ey9tbZjI5Ni7AccqezJK/hY0dm9/zGqxeH?=
 =?us-ascii?Q?hHNuPwxD4zTcFJiJVjOx1zEtDJzdhtyprI3eDBCS9wpZrcpUrZvtYJDlgWFn?=
 =?us-ascii?Q?FnQEZ9vxn7CAshaPcMVHbP0aIrAKvH0++H7w0EG542ORvzTjbLoBQOb8ChIs?=
 =?us-ascii?Q?Rmlxdlbh7D9X/FonKFrDFUMEuP/rz4hlJ0JfMJqm/wULVGVcPy0Q0INng5go?=
 =?us-ascii?Q?jkDv9yRJwrfK2lgOrEl+baIQ6jik3pUKU3jsxD+QWIbIXfao2hJu8/QzzHQN?=
 =?us-ascii?Q?rTKdIkTks6agMfQlVJas9dXLlGUvLTb88GoUQ7pUIXhNc2A+GfvHsR2l4vJs?=
 =?us-ascii?Q?T5g6BlCLULmUnC1QpapuIHIi8NFa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:19:47.2849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7121651e-6a81-4792-1363-08dc8572efad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358

Using the RMPADJUST instruction, the VSMA attribute can only be changed
at VMPL0. An SVSM will be present when running at VMPL1 or a lower
privilege level.

When an SVSM is present, use the SVSM_CORE_CREATE_VCPU call or the
SVSM_CORE_DESTROY_VCPU call to perform VMSA attribute changes. Use the
VMPL level supplied by the SVSM for the VMSA when starting the AP.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h |  2 +
 arch/x86/kernel/sev.c      | 75 ++++++++++++++++++++++++++++----------
 2 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 01e3866c4d61..36cd7aebaa9b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -233,6 +233,8 @@ struct svsm_call {
 #define SVSM_CORE_CALL(x)		((0ULL << 32) | (x))
 #define SVSM_CORE_REMAP_CA		0
 #define SVSM_CORE_PVALIDATE		1
+#define SVSM_CORE_CREATE_VCPU		2
+#define SVSM_CORE_DELETE_VCPU		3
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b5c18ed4c572..ea4677177396 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1006,22 +1006,50 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
-static int snp_set_vmsa(void *va, bool vmsa)
+static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
 {
-	u64 attrs;
+	int ret;
 
-	/*
-	 * Running at VMPL0 allows the kernel to change the VMSA bit for a page
-	 * using the RMPADJUST instruction. However, for the instruction to
-	 * succeed it must target the permissions of a lesser privileged
-	 * (higher numbered) VMPL level, so use VMPL1 (refer to the RMPADJUST
-	 * instruction in the AMD64 APM Volume 3).
-	 */
-	attrs = 1;
-	if (vmsa)
-		attrs |= RMPADJUST_VMSA_PAGE_BIT;
+	if (snp_vmpl) {
+		struct svsm_call call = {};
+		unsigned long flags;
 
-	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
+		local_irq_save(flags);
+
+		call.caa = this_cpu_read(svsm_caa);
+		call.rcx = __pa(va);
+
+		if (make_vmsa) {
+			/* Protocol 0, Call ID 2 */
+			call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
+			call.rdx = __pa(caa);
+			call.r8  = apic_id;
+		} else {
+			/* Protocol 0, Call ID 3 */
+			call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
+		}
+
+		ret = svsm_perform_call_protocol(&call);
+
+		local_irq_restore(flags);
+	} else {
+		u64 attrs;
+
+		/*
+		 * Running at VMPL0 allows the kernel to change the VMSA bit for a page
+		 * using the RMPADJUST instruction. However, for the instruction to
+		 * succeed it must target the permissions of a lesser privileged
+		 * (higher numbered) VMPL level, so use VMPL1 (refer to the RMPADJUST
+		 * instruction in the AMD64 APM Volume 3).
+		 */
+		attrs = 1;
+		if (make_vmsa)
+			attrs |= RMPADJUST_VMSA_PAGE_BIT;
+
+		ret = rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
+	}
+
+	return ret;
 }
 
 #define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
@@ -1055,11 +1083,11 @@ static void *snp_alloc_vmsa_page(int cpu)
 	return page_address(p + 1);
 }
 
-static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
+static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
 {
 	int err;
 
-	err = snp_set_vmsa(vmsa, false);
+	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
 	if (err)
 		pr_err("clear VMSA page failed (%u), leaking page\n", err);
 	else
@@ -1070,6 +1098,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
 	struct ghcb_state state;
+	struct svsm_ca *caa;
 	unsigned long flags;
 	struct ghcb *ghcb;
 	u8 sipi_vector;
@@ -1116,6 +1145,9 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	if (!vmsa)
 		return -ENOMEM;
 
+	/* If an SVSM is present, the SVSM per-CPU CAA will be !NULL */
+	caa = per_cpu(svsm_caa, cpu);
+
 	/* CR4 should maintain the MCE value */
 	cr4 = native_read_cr4() & X86_CR4_MCE;
 
@@ -1163,11 +1195,11 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	 *   VMPL level
 	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
 	 */
-	vmsa->vmpl		= 0;
+	vmsa->vmpl		= snp_vmpl;
 	vmsa->sev_features	= sev_status >> 2;
 
 	/* Switch the page over to a VMSA page now that it is initialized */
-	ret = snp_set_vmsa(vmsa, true);
+	ret = snp_set_vmsa(vmsa, caa, apic_id, true);
 	if (ret) {
 		pr_err("set VMSA page failed (%u)\n", ret);
 		free_page((unsigned long)vmsa);
@@ -1183,7 +1215,10 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	vc_ghcb_invalidate(ghcb);
 	ghcb_set_rax(ghcb, vmsa->sev_features);
 	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
-	ghcb_set_sw_exit_info_1(ghcb, ((u64)apic_id << 32) | SVM_VMGEXIT_AP_CREATE);
+	ghcb_set_sw_exit_info_1(ghcb,
+				((u64)apic_id << 32)	|
+				((u64)snp_vmpl << 16)	|
+				SVM_VMGEXIT_AP_CREATE);
 	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
 
 	sev_es_wr_ghcb_msr(__pa(ghcb));
@@ -1201,13 +1236,13 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 
 	/* Perform cleanup if there was an error */
 	if (ret) {
-		snp_cleanup_vmsa(vmsa);
+		snp_cleanup_vmsa(vmsa, apic_id);
 		vmsa = NULL;
 	}
 
 	/* Free up any previous VMSA page */
 	if (cur_vmsa)
-		snp_cleanup_vmsa(cur_vmsa);
+		snp_cleanup_vmsa(cur_vmsa, apic_id);
 
 	/* Record the current VMSA page */
 	per_cpu(sev_vmsa, cpu) = vmsa;
-- 
2.43.2


