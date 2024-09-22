Return-Path: <linux-kernel+bounces-335030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B230797E00E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 05:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738AA2816E8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 03:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD35193088;
	Sun, 22 Sep 2024 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w/KaDx11"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB31917EF;
	Sun, 22 Sep 2024 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726976250; cv=fail; b=MqSeDvFPRKS0MgL7X0dTxYViEOAvS6FMam2v7kGL3t8ua2e52/0hwNfrgzjXOHNHbdr83bnrRdhVzTMQ7xIfer6sUISg7HZ/L0s0ZeHNWPTkqA3xxyMw95J4A+Wijcm0ImveRRwTolUIVTIcAtDpReQf5wfgSvAZTIv+ugkgG0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726976250; c=relaxed/simple;
	bh=hExtzreLpTluuLKLSU0EeqSzaHKKl9KhEdXS/bqYRzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOMyUDZHZ697a3x9gE9yLKzaGOOd24WHhMa3fhcE2DcS/kJL2h0JBEHcI+x/7TeNMe3A2SuXDU0V5DmWzDZRFJbQd5efrL75IwMWKIcT0LY+MjxVCE8dvzHjdwRgWMgfUNN6iQRNkMOvVhieaZCLfcEPkVbyeBPDK8BJVa0cThc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w/KaDx11; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rr9WVADksr2iBaCjI2L8TVwqiojDc7yE8pflxURAY9q/PSJv0iwVG/nA1XHdVVoVHdawdp4+NVIoRz5P6Ei/fAf7rL1L1U3U8yzfupaN0uCDi+6G6HrHcfOqnRnmqdHlP/fA3zEEvpRGpptQfox80RTH1eszvKOTW1DzfkeB74KoyfWEuUNArn+HC3zwf1vm9MJESnriO9o+QjmoL599iYmEAN9SoDYqun0G52pMsfQ12T9CsiGHG+Idkhk5YacV1Z94ubGlApnjtvV+prSRgqXlYuLM3y+5kWvuUGP/oX74CTsdwPnfxVFBcXcL/Qthq4GaI67FBl+ZI/4gi8W2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eghMVy5Lkb2dtkjjrhp1WkhnPCmRzpN+cQl9bbvxAcU=;
 b=yMkHeoSutI1luOzWp6Yh3Hwv9puKSqTpNa0GvHsukJiAeEvI63LosIa9IgYv0AI9VnQ/OYMmznE8XClzNuxaOAY3FFSmMuYEEH8dYFUGOG3p81LUZnBEeS/ukvelbOfMGMvvXWOk5AuIMx5EC+tFK99++QeChuYB65QOkC5kO7vdVSetIpFdUXOSf76v//snvRCTp7Tc2XcDsRJhxOft6hCz3Zdludm6/hnf3iLzkFKbf+dCCUjnaTkpUOsAFt24Kymf0AoOTERRDrLoiDmC02NcBslD3rtp/2TB3My/TchTlbON8XmeXDmPOrzv3Gliu6XTCIiItGOZOjm10uqxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eghMVy5Lkb2dtkjjrhp1WkhnPCmRzpN+cQl9bbvxAcU=;
 b=w/KaDx11v/PPsDuXcsrAP+nM6ilo4Ov0hI6Ah1RbzauqQpgQap3YwRzz05R8kjMI70u3wxJW9OUawIjU2FzbFrY0frh39wnpYkFvYabZDB5Ch2rK61B08i+mW8TFUw8icsLDiyTcskaNxGAUjU3SLu1NjzR9JiyYKFhSr0CWRCU=
Received: from CY5PR15CA0107.namprd15.prod.outlook.com (2603:10b6:930:7::16)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Sun, 22 Sep
 2024 03:37:23 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::db) by CY5PR15CA0107.outlook.office365.com
 (2603:10b6:930:7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.26 via Frontend
 Transport; Sun, 22 Sep 2024 03:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sun, 22 Sep 2024 03:37:22 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 21 Sep
 2024 22:37:21 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Pavan Kumar Paluri
	<papaluri@amd.com>
Subject: [PATCH v4 1/2] x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
Date: Sat, 21 Sep 2024 22:36:25 -0500
Message-ID: <20240922033626.29038-2-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240922033626.29038-1-papaluri@amd.com>
References: <20240922033626.29038-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcfa3d8-e858-40d3-d324-08dcdab7de7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GuwOuoYspbzj5NoqmmREKI6RHv+g2CO9pwD0OJZ9Dl3hh4+vCWDLN2KSXUfp?=
 =?us-ascii?Q?Xsvulvy6C8AE1wv2+mH3QaQUkqi4aSxO09cB4+fjneK2IR26vrnQsx0wf1xS?=
 =?us-ascii?Q?U8sDdkfSzc1/Vb92qPVPkeKxerYKN7wcm6B+rzNVP5DEJ06nonxShqv8zZSV?=
 =?us-ascii?Q?vFelJePVJc9ivHJxI+7Z7FnImCvzsQW89zhb6y/pJqOekrYvz5YTWinz+GXH?=
 =?us-ascii?Q?xb5OvqKq6tBDF/4ZUfkvfNt5azUlL5+hpyNOO/UVu/FiuBkShhjJ/To242aa?=
 =?us-ascii?Q?Ta14yJRpbkDtdlwafCVJpBkkSim+5X5q/OTOlchkuCNNCD/njV+crM4aVWhA?=
 =?us-ascii?Q?MC39h7foyMmkEtpBtlIc3JpQepiMVzoZTaiWoqdAbdIDLFMMz6KJWxA2VT47?=
 =?us-ascii?Q?ypx3molHdA1kvXH9c9eSa1MhO1T74cIBOAf7b53DUrgvl4ULafQSJsfh3stV?=
 =?us-ascii?Q?NZ9pm4qI0lbp0GkU6k1U9+vRLM4mty+DtkJR4uGOngsrdnWsSg0hBE6+i7nf?=
 =?us-ascii?Q?/yN7wufBHvzAOoAqKyhAvBZkr7/iBYrq9v8wHDH34NEBE0geh3LKGNLSXrHA?=
 =?us-ascii?Q?IZVFA5XtQ7C9zN5mwlGQBa6u1sdcAHbVzRstnV7j8CIS4zcvyZikK/z1emcA?=
 =?us-ascii?Q?OpXDBPc1rWhTnpVYO/c1rxlVQAJBQS1fCYZ20Qvf+I0z3t53mAfEZQhYtsO4?=
 =?us-ascii?Q?FLCtTsL7Ozig3XgBWX1m8gUMssDdqiFHXkxhBIOq3ThWHPBdwysNb3GF8+xF?=
 =?us-ascii?Q?z3fGHabHiJH/t+LBHwaRYO/fOXr7EHkDh6J+I2n/XCId3u3DlvUNJWJOpuAW?=
 =?us-ascii?Q?RlCm5PeJfXmygpuO32KRpqbQygUDszfhmnMEQb0mFosHg2CElZnNWMBdulE+?=
 =?us-ascii?Q?D6MbAPMwLh93g1gzFLqvHiZ11qp9ToEAMleYBbyZLH3PWa6Pqgbhah21bPTC?=
 =?us-ascii?Q?cmFDI5pDmirBeg0QtS7wRBu3Je+aQa6XNUNVVdgmklH6B10+yvF4cLB78TkL?=
 =?us-ascii?Q?xuo6eif2nCD3V21wnp2bX8Bj3lchWUo15nQygONo80eYf/lzbBHB/qCuxZ6K?=
 =?us-ascii?Q?h8h+cv3abV6dXUOo5DxMEcUTWRljOeRopAQPYRLCVD+zw6A/+gQW+v+H2XHv?=
 =?us-ascii?Q?qtJPaV42lRjqRddT+wORTTyBzhuPREm28pPe4a1D3fEGxxJemFhU3LXk2Pdm?=
 =?us-ascii?Q?OhKp7cJCTDdTysZHSsJsQ59oIafssWREz+56wbSgtjcbBpmf7il7j3W9kcFo?=
 =?us-ascii?Q?uJps7NcFNNbpp+g2TeCcyN5wo1C6Y5cvM5BW8alM4PFmVBWy4Byt9lfe264U?=
 =?us-ascii?Q?yeaOwYx7YccFIT350qVf8PDIzgDLzA8qrowpy9VYKid63hmeQl7kEmFTbxLK?=
 =?us-ascii?Q?YwtKi1c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 03:37:22.4576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcfa3d8-e858-40d3-d324-08dcdab7de7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602

Move SEV specific kernel command line option parsing support from
arch/x86/coco/sev/core.c to arch/x86/virt/svm/cmdline.c so that both
host and guest related SEV command line options can be supported.

No functional changes intended.

Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/coco/sev/core.c          | 44 -------------------------------
 arch/x86/include/asm/sev-common.h | 29 ++++++++++++++++++++
 arch/x86/virt/svm/Makefile        |  1 +
 arch/x86/virt/svm/cmdline.c       | 32 ++++++++++++++++++++++
 4 files changed, 62 insertions(+), 44 deletions(-)
 create mode 100644 arch/x86/virt/svm/cmdline.c

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index de1df0cb45da..ff19e805e7a1 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -141,33 +141,6 @@ static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 static DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
 static DEFINE_PER_CPU(u64, svsm_caa_pa);
 
-struct sev_config {
-	__u64 debug		: 1,
-
-	      /*
-	       * Indicates when the per-CPU GHCB has been created and registered
-	       * and thus can be used by the BSP instead of the early boot GHCB.
-	       *
-	       * For APs, the per-CPU GHCB is created before they are started
-	       * and registered upon startup, so this flag can be used globally
-	       * for the BSP and APs.
-	       */
-	      ghcbs_initialized	: 1,
-
-	      /*
-	       * Indicates when the per-CPU SVSM CA is to be used instead of the
-	       * boot SVSM CA.
-	       *
-	       * For APs, the per-CPU SVSM CA is created as part of the AP
-	       * bringup, so this flag can be used globally for the BSP and APs.
-	       */
-	      use_cas		: 1,
-
-	      __reserved	: 61;
-};
-
-static struct sev_config sev_cfg __read_mostly;
-
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -2374,23 +2347,6 @@ static int __init report_snp_info(void)
 }
 arch_initcall(report_snp_info);
 
-static int __init init_sev_config(char *str)
-{
-	char *s;
-
-	while ((s = strsep(&str, ","))) {
-		if (!strcmp(s, "debug")) {
-			sev_cfg.debug = true;
-			continue;
-		}
-
-		pr_info("SEV command-line option '%s' was not recognized\n", s);
-	}
-
-	return 1;
-}
-__setup("sev=", init_sev_config);
-
 static void update_attest_input(struct svsm_call *call, struct svsm_attest_call *input)
 {
 	/* If (new) lengths have been returned, propagate them up */
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 98726c2b04f8..adddcf3edaf0 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -8,6 +8,8 @@
 #ifndef __ASM_X86_SEV_COMMON_H
 #define __ASM_X86_SEV_COMMON_H
 
+#include <asm/cache.h>
+
 #define GHCB_MSR_INFO_POS		0
 #define GHCB_DATA_LOW			12
 #define GHCB_MSR_INFO_MASK		(BIT_ULL(GHCB_DATA_LOW) - 1)
@@ -220,4 +222,31 @@ struct snp_psc_desc {
 #define GHCB_ERR_INVALID_INPUT		5
 #define GHCB_ERR_INVALID_EVENT		6
 
+struct sev_config {
+	__u64 debug		: 1,
+
+	      /*
+	       * Indicates when the per-CPU GHCB has been created and registered
+	       * and thus can be used by the BSP instead of the early boot GHCB.
+	       *
+	       * For APs, the per-CPU GHCB is created before they are started
+	       * and registered upon startup, so this flag can be used globally
+	       * for the BSP and APs.
+	       */
+	      ghcbs_initialized	: 1,
+
+	      /*
+	       * Indicates when the per-CPU SVSM CA is to be used instead of the
+	       * boot SVSM CA.
+	       *
+	       * For APs, the per-CPU SVSM CA is created as part of the AP
+	       * bringup, so this flag can be used globally for the BSP and APs.
+	       */
+	      use_cas		: 1,
+
+	      __reserved	: 61;
+};
+
+extern struct sev_config sev_cfg __read_mostly;
+
 #endif
diff --git a/arch/x86/virt/svm/Makefile b/arch/x86/virt/svm/Makefile
index ef2a31bdcc70..eca6d71355fa 100644
--- a/arch/x86/virt/svm/Makefile
+++ b/arch/x86/virt/svm/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_KVM_AMD_SEV) += sev.o
+obj-$(CONFIG_CPU_SUP_AMD) += cmdline.o
diff --git a/arch/x86/virt/svm/cmdline.c b/arch/x86/virt/svm/cmdline.c
new file mode 100644
index 000000000000..964677ab02d6
--- /dev/null
+++ b/arch/x86/virt/svm/cmdline.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD SVM-SEV command line parsing support
+ *
+ * Copyright (C) 2023 - 2024 Advanced Micro Devices, Inc.
+ *
+ * Author: Michael Roth <michael.roth@amd.com>
+ */
+
+#include <linux/string.h>
+#include <linux/printk.h>
+
+#include <asm/sev-common.h>
+
+struct sev_config sev_cfg;
+
+static int __init init_sev_config(char *str)
+{
+	char *s;
+
+	while ((s = strsep(&str, ","))) {
+		if (!strcmp(s, "debug")) {
+			sev_cfg.debug = true;
+			continue;
+		}
+
+		pr_info("SEV command-line option '%s' was not recognized\n", s);
+	}
+
+	return 1;
+}
+__setup("sev=", init_sev_config);
-- 
2.34.1


