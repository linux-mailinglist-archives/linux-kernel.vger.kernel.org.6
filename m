Return-Path: <linux-kernel+bounces-238350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583069248A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E843B25680
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901871CD5D6;
	Tue,  2 Jul 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gd/02UQR"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33624084E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950297; cv=fail; b=sCl8yJrQ3BBEJrNgiapkycuCcu+Xg/0e4qY4OwRU4YkPEEti7+DfvT7aEgJKl7Pn0cXSVDJgbOdxhJ8+88VqSy/tHxZ+4LedWubS/7xE4HMa0UJjkrK9F78ZMELXuQLaYCeStyOLC9Lm/hg1lcY9P3R5CleFvqQBw8Q2p6j2DXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950297; c=relaxed/simple;
	bh=zatAsJxGxTty56N28Y/nYSj7Vz4vVt3Yp4lteAx20Fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZoQDc4YakhseyGDmAABRglmHrwemzma7Q1UOgsYt/l5dHCC+w6waUIjvGV9RpqS0KfivRvOPUfLuRvahA+GXjLBfbvdVpWf74OAj2/a67f3Rk0woI54ezwlvvSL302PzKnZFVg/mKeumOs6kulIHAg3i5b2UO3GDvAF//Ro3qAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gd/02UQR; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjjnM1uTAZJdNCm6kbfMbW83DTWl8UKIamjo+fThWXQjUHFSHLaWwbB6cLFKY5zWm+epilpg2Z2DSihF/V8Fx9IVVsKsusG/GLBMUcFbMqoI3HjfVKnnB3+fS2R6KwLeJVWL8QGjLHk2Wco/QWYZLHB6iAL2SlqKjhCIqX0wQmCwmkH7+Hek0WJENr7KEZ6OoqieZ3BrBeP5r3ScnHcUkqTbMzOS3V5eSUS8XYqzhrBE3mWy6Mx0kQyAIFkjNZ4y01rcNBWMOK7IguNRBw0ZJ+dFl2xR4Fr8pncJdR7RaRhsNC5joE5vTVr4ZAnpyan5vr0wPMa8R6DPJ+i3yNzT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E96lfO2ane/Bn+hd5G+CEZvQoyEFIsDM+LjtymPitAA=;
 b=VBTO7FUBtX/I+xQq/wtmxLAVr4VdK7ZItPXyhVmeZAIxfIChXHH+3IatSiYZC4ch73QFAKnHmMiNV9FG96svJ6n+sKCFLvTtUksAKLP+YgxN3qHiRwldGTisfXgaPVAARYeanDQbjkQ3zVn8TcOx7Cc/Kl5Yqmp1WyF2KtSfslMyMEHZxqVB0PzpqS/LeWujJP0sTrfzr6V0AuSUCpQsLHm86hMKjpho0osF4VSngfQcHyg6Hdxh6HyiSoCfk4olLXaWAgeGNgi0A1Hu1PehCq3jz3F1msMq7QPio7qsQbuAHLV8y5x84sYagEYGFkQhL6cbFfOca9y+OAofISweZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E96lfO2ane/Bn+hd5G+CEZvQoyEFIsDM+LjtymPitAA=;
 b=gd/02UQREsm3Up7W1IrlFdrnEkUeQJ2QD2tcM9xESbialQSLH+S4lnZbUGj1MzRfLdBBTaQtyxXljm3QeACQ0Jv2siqTNkEFQCbj+qgGIz/7TTSHsCHGdeReizUsVWomF2G16Qoc0WPNydDf5nq3DinqQ/v/J7pHe4RWx9mtTdI=
Received: from CH2PR20CA0018.namprd20.prod.outlook.com (2603:10b6:610:58::28)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 19:58:07 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::ae) by CH2PR20CA0018.outlook.office365.com
 (2603:10b6:610:58::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34 via Frontend
 Transport; Tue, 2 Jul 2024 19:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 19:58:05 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 14:58:04 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <dave.hansen@linux.intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <x86@kernel.org>
CC: <hpa@zytor.com>, <rafael@kernel.org>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <kirill.shutemov@linux.intel.com>,
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <anisinha@redhat.com>,
	<ardb@kernel.org>, <dyoung@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <jroedel@suse.de>
Subject: [PATCH v11 2/3] x86/mm: refactor __set_clr_pte_enc()
Date: Tue, 2 Jul 2024 19:57:54 +0000
Message-ID: <f2152ca66e98cc399681e4964d748306b1845710.1719948376.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719948376.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1719948376.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2b51be-60a3-402a-350a-08dc9ad14997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PzGjDe/CQtmO1dOBOOzANd6PYFD/m4pZSnTpZtD3sytWg7LzKt2yiNwWozBU?=
 =?us-ascii?Q?i3jUTmsMHgJhcL7QngfEASegGKvQbOKV4cLerrqIqjkUPVBbKNGPr7yqm2Pa?=
 =?us-ascii?Q?GvWlDdE3rBkO+DwpMIYXg0Q2/udMNx0Wr8pQI1+a7QsOavHUi7G9EI+l6ntu?=
 =?us-ascii?Q?b2NgYn4oL3dsh9R4YmCImpkaPzg7uSFazApmEdTg14gsjQV7UvlXtfLbRmUs?=
 =?us-ascii?Q?By+nvI6Uvnt66JlpXGn9ANEMlSKK6Jm1xbE++1OGItinxLXjy9vn/1i6oBYn?=
 =?us-ascii?Q?/TlFPlTVVwhPWm3nys+P1RBpZ5a+RVUN9ptfzyoawPwEIFb2CLSNl1b0DSIU?=
 =?us-ascii?Q?MC3OMTEMSnG5pRALecOIn5SdbxT9kwu1/xR4DeWhKfGM5S7pyGl65cWi8u74?=
 =?us-ascii?Q?5T3ENznxigXSTqcZJJ61VCjWQHshqfkpPvFmzeYH9qqT5wQBaOFSeAjeULN8?=
 =?us-ascii?Q?j0NLrX/St7GfkST98pR2kBfb08pnU/75aF2rFXFpcGE+XfkifaJ7olG7oq+v?=
 =?us-ascii?Q?Cvz/nYKI0vuXjVhgqHWoYL5DHE6Hkfb0GFgYr8SvZ3iHbCW1kMrHwJBkVt6I?=
 =?us-ascii?Q?l/r2qt0RO4dqBzLSMHNFdB51gL5LKtFwXQJNPQtL3Tt49jykiBiiZyhxXr3N?=
 =?us-ascii?Q?0TXU+ghWQZY5ZZR8sjv1uoPSFvbfpfBIivXMQqA4uOMvxaNI88d2WvKG9ldv?=
 =?us-ascii?Q?G81V+kV/9XhWi+Dywd4RZNOcbdse+ArW6Eo/1Ob13nQbtdTM+qimNZ2bUmy8?=
 =?us-ascii?Q?enTGj5wrZNe4FMMdB26up2VBLM3/CxxkFTqzAeWE8+gsVLLcXpxt3bVR1sfo?=
 =?us-ascii?Q?+CJbbfOMTHA5cfcy9Y4ci4zcKCO3UwF1vu/MU/+hwu6o9lmmwDl/gAtYAb7k?=
 =?us-ascii?Q?GsprtOCkVMzjh5HKKYVEN9cODRLFqs9G0W9w6vfqzlXpJ3DSh0MXUXNOcUAI?=
 =?us-ascii?Q?8QMu0XJ4ogor2SppAf0xagT3vUSUmYEyifyrPPyDmkFW9I3b7lsCrQ5aTbki?=
 =?us-ascii?Q?SD2/ZNsvFA2qQUGFmUMqd83WciB9M4hcOZ4yhOmeIf6qYF918tY2c+QkaYnZ?=
 =?us-ascii?Q?SoG/jwv+mWRIFP3GS/0hLyZEPqka5kQHluqKwrwTr4wWzQQUlqYPmwu1pedj?=
 =?us-ascii?Q?peysz4+9vUu6UK33RArV2I+FJwGCF+OoXTrMEsD/tCjaazKGrreo5qJgbVy8?=
 =?us-ascii?Q?b9wGIWNKJXxQR1Nz5WU5zmuT65w4vIQooeAUMWsMgxCCNXR9UkDJOnkWAOsj?=
 =?us-ascii?Q?mlKJrRhYL+gpAIa0RFWtjKWUvYwVjVWuSd7EGUjH4ZIORoKFoCF3gjX0tO6B?=
 =?us-ascii?Q?HhHMHHLYh/ik31L/r+8Px/vOBq9xPiVOjlmL21dSqvkDyPWhZMZWfTYkEaR/?=
 =?us-ascii?Q?sQf/Kf/n6Vp58SHpkjPLngW8hmgYb/XsQ88wAOmQXmnAZOgFeqfaL/Q2krpY?=
 =?us-ascii?Q?gWJDjmvrvWLEDcQN4WfRowDfL8fxLepY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 19:58:05.2631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2b51be-60a3-402a-350a-08dc9ad14997
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042

From: Ashish Kalra <ashish.kalra@amd.com>

Refactor __set_clr_pte_enc() and add two new helper functions to
set/clear PTE C-bit from early SEV/SNP initialization code and
later during normal system operations and shutdown/kexec.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/sev.h    |  9 +++++++
 arch/x86/mm/mem_encrypt_amd.c | 47 +++++++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ac5886ce252e..4f3fd913aadb 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -348,6 +348,10 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
 void snp_update_svsm_ca(void);
+int prep_set_clr_pte_enc(pte_t *kpte, int level, int enc, void *va,
+			 unsigned long *ret_pfn, unsigned long *ret_pa,
+			 unsigned long *ret_size, pgprot_t *ret_new_prot);
+void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
@@ -384,6 +388,11 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
 static inline void snp_update_svsm_ca(void) { }
+static inline int
+prep_set_clr_pte_enc(pte_t *kpte, int level, int enc, void *va,
+		     unsigned long *ret_pfn, unsigned long *ret_pa,
+		     unsigned long *ret_size, pgprot_t *ret_new_prot) { }
+static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 86a476a426c2..42a35040aaf9 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -311,15 +311,16 @@ static int amd_enc_status_change_finish(unsigned long vaddr, int npages, bool en
 	return 0;
 }
 
-static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
+int prep_set_clr_pte_enc(pte_t *kpte, int level, int enc, void *va,
+			 unsigned long *ret_pfn, unsigned long *ret_pa,
+			 unsigned long *ret_size, pgprot_t *ret_new_prot)
 {
 	pgprot_t old_prot, new_prot;
 	unsigned long pfn, pa, size;
-	pte_t new_pte;
 
 	pfn = pg_level_to_pfn(level, kpte, &old_prot);
 	if (!pfn)
-		return;
+		return 1;
 
 	new_prot = old_prot;
 	if (enc)
@@ -329,7 +330,7 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
 
 	/* If prot is same then do nothing. */
 	if (pgprot_val(old_prot) == pgprot_val(new_prot))
-		return;
+		return 1;
 
 	pa = pfn << PAGE_SHIFT;
 	size = page_level_size(level);
@@ -339,7 +340,39 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
 	 * physical page attribute from C=1 to C=0 or vice versa. Flush the
 	 * caches to ensure that data gets accessed with the correct C-bit.
 	 */
-	clflush_cache_range(__va(pa), size);
+	if (va)
+		clflush_cache_range(va, size);
+	else
+		clflush_cache_range(__va(pa), size);
+
+	if (ret_new_prot)
+		*ret_new_prot = new_prot;
+	if (ret_size)
+		*ret_size = size;
+	if (ret_pfn)
+		*ret_pfn = pfn;
+	if (ret_pa)
+		*ret_pa = pa;
+
+	return 0;
+}
+
+void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot)
+{
+	pte_t new_pte;
+
+	/* Change the page encryption mask. */
+	new_pte = pfn_pte(pfn, new_prot);
+	set_pte_atomic(kpte, new_pte);
+}
+
+static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
+{
+	unsigned long pfn, pa, size;
+	pgprot_t new_prot;
+
+	if (prep_set_clr_pte_enc(kpte, level, enc, NULL, &pfn, &pa, &size, &new_prot))
+		return;
 
 	/* Encrypt/decrypt the contents in-place */
 	if (enc) {
@@ -354,9 +387,7 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
 		early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);
 	}
 
-	/* Change the page encryption mask. */
-	new_pte = pfn_pte(pfn, new_prot);
-	set_pte_atomic(kpte, new_pte);
+	set_pte_enc_mask(kpte, pfn, new_prot);
 
 	/*
 	 * If page is set encrypted in the page table, then update the RMP table to
-- 
2.34.1


