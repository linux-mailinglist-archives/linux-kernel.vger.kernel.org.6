Return-Path: <linux-kernel+bounces-271846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831119453E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BBE1F22179
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CAF14AD3A;
	Thu,  1 Aug 2024 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TbKhOuup"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF164145B28;
	Thu,  1 Aug 2024 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722545823; cv=fail; b=TpazZwEQAIEQxK81IkTokYrpSmXhNgZVRU4Ry085rxqbRwOFgSYIQlPZdqPC8borwVzcUWxd+1/R2pEHGiKFhUjqorxr41bS97+IStBwFZwNOZ0tCKLPd5SE3GJNxdNwA7LrARJ6s8LstoAVwwheitg73rotU1IkOy/yCWJoLBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722545823; c=relaxed/simple;
	bh=pYUdW/i1EhPgH5yKr1dbqcp4JCatVkCX7KcXaAxReH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXu1MoUQ1ERJpeuekSe/yfOJk1naHOuS+K/f0/YIbl2MjcMYcVaXQG1rJ/npWpTPQHVq93Z0s2L+K36tCd7iC3SskN6lQOcJ/anXij/Tu9YUbkGZXrQxAogMtgh78uPJSGRHE/vWRLgjvPb/tnXY731sjHzMNAeNYicNlm2lPP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TbKhOuup; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4s6/lFvrNXsfoZrwtAwkyyBHviuxIY0lDbAPc5wP1eU4hF/D2/2wLdtGjxt2LcBONBRlz6cnWzU/QMkSUtaLGTUqY05/tI1rk4c8c3CyTbVV8fdbxpDoh5jWO1yIN0xOaAgYJ2TsrJjhD1Kq3vSgUpcT0KIrvVUvwvW3mogWpWluAPANOMbbAo2uekTch3r9QsAYOrkaR8K1/d42ieq/TfAjWvYk7tqtF3rRMqa/ERXaEmxCoNtsHt+xklwOPH5l037m6ootIujzSqgFdosT2YwBoKqPiXKHaVHu33MMstDPnSExWDlglS5j2wpesxnT2lXrtRyP6nXvJPBjEmE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsekWvlF7gS8r/Mi3UrBRLHcHm2QSZ1Bkyybkk+yTh8=;
 b=tdT3RGlA7aAQjqSQDcjENkAvcfnHypTc6Ixu6WF7xhKAsoSU74eRHz3MBcTweu5xo2l77/5rYF7wAj08V/H/EkpDYERUEQjEP8aCaCLxol4e3ArYrdq8CKB3/mh4Drny7MojYP00RGdPY5X5wS8pBg6GQzSWJ5ZGJqMbP+3mgf35ZjmlWH3rE9LMAoUe5+g0XKfL891YEQ/udfmFrgmuPMuLD+mYgDX5kVekL4YHcsZ+6M9tnLf2LLjzmS8KVXmu9sKRELutWQicR2nY2HIk4sqn+vV/FISYVKWhYMYW+L1Bubbt/biVS10BM5D1SClnEbhwNGSH03QlzPhEsUngYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsekWvlF7gS8r/Mi3UrBRLHcHm2QSZ1Bkyybkk+yTh8=;
 b=TbKhOuupjoOFq1PI6KgP41RWLbWg102BoMRF4T8ssiSksNNCiBZCmjkDCDDuhEODPzn9YFuDGUFh5Me3CXHNGA02swK1DJMJHUwb+ewJ6G1gxBVdFYYb4TUvzFOfo29coUf72vNP38L1CFw0JtY0ejO87Htw9y75uSEwpzIFjbk=
Received: from SA9PR03CA0004.namprd03.prod.outlook.com (2603:10b6:806:20::9)
 by LV3PR12MB9403.namprd12.prod.outlook.com (2603:10b6:408:217::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 20:56:58 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::68) by SA9PR03CA0004.outlook.office365.com
 (2603:10b6:806:20::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 20:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 20:56:58 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 15:56:57 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric Van Tassell" <Eric.VanTassell@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Michael Roth
	<michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Pavan Kumar
 Paluri" <papaluri@amd.com>
Subject: [PATCH 1/2] x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
Date: Thu, 1 Aug 2024 15:56:37 -0500
Message-ID: <20240801205638.6603-2-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801205638.6603-1-papaluri@amd.com>
References: <20240801205638.6603-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|LV3PR12MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6dde5d-9102-46a0-d0ca-08dcb26c7bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HmAKRkftkmJDAiDhHtgbmp8Ic2qq8/qopqW59B07mBrujlGoDz5LsUKgKg8p?=
 =?us-ascii?Q?LNKTvV8oZcKPtjErLt9FAW5XCtkS8wx+/8My4qc+GCMVTb8a6dDy6WxNUiTT?=
 =?us-ascii?Q?6cQgcmnE+NJD/dgUnJBQewjbBXIM+MFew7+5N7e8ZrQz2VU5OXIpcKn7cL/T?=
 =?us-ascii?Q?IdkYot9Z4XDiO89ikm+r+7HfrAV4yMNlB4T373dZ+ieuYcfb1/LqQ+Iw5JYl?=
 =?us-ascii?Q?wWDn+iocURw9eMMBXyGA61yn8tCS7qyIRPLp6o9294DHDFuXcS4hrYOz7kY8?=
 =?us-ascii?Q?o5oAnJSW+eUKKpXf6VEZDmqfH8xGWVMSOzdimxjldE02QwN4QZOVN/1R5bmX?=
 =?us-ascii?Q?gqGyCe1HMdsjjeWmECiZqQ7bFaUR4jUfF6DzgwUYHM1h0x6yb+MBbBZIg3yi?=
 =?us-ascii?Q?bykxH8RJ7kcYmNnQ3fcwle7yejoR5xVi2ysQhGSpqrELpCOIguFStWLFtH2l?=
 =?us-ascii?Q?Dt0Nn6SQcC+3lf8fBo8yAGiJKLERq1Iz1PpeLea+v8ENfAyYFIG/S0yHAVdg?=
 =?us-ascii?Q?wZNcnwo2ZMQAJx6XAjNKm8zOs9/ZO9Efke/0teBQnxhz+E6JueMHmP+S/46d?=
 =?us-ascii?Q?/VuH2HLgTZyQ647135FIfs1+xUKjKIuGtW1G2oTZaqzhF8u7+QynmJq595MR?=
 =?us-ascii?Q?syv6sUXaIEss/ScCnuGCg7W5/ugt8QnRZr6C6TOBwaTQBPJl46XBG0neEWFw?=
 =?us-ascii?Q?qAA6dpg6BIpFUWR2Ja6SYiwk0ogxVY1sMN30gqCyjpPPbbfhKJi7CQ+8FU7r?=
 =?us-ascii?Q?MkPN87M8srXcidUUE8fftn2nE1N//N/SM1AHuZ8MoPcj3ovnd2Q35BCKcJyz?=
 =?us-ascii?Q?1U7jCO+I4o3cDKe75POd2Y3ASikoZ+zq72RdZFFY/v/rQVz28B8WM+8MO+CG?=
 =?us-ascii?Q?US1jFqt2+fx94idZMWhKF9IZNW4YLK9+HZdUSKwxxcAKmi6po4telJ3a0Ovm?=
 =?us-ascii?Q?40pdFW8j8QXJBgVA24Ls8Nz0OgYMQPGjaJ90SaD2g6FGSO26xSswbV+HO08w?=
 =?us-ascii?Q?4vRoOCkbUqqQTBH4WOcreWAEviecwitTZMgbFetEHSZupSydqYb829xkGrMj?=
 =?us-ascii?Q?WzVzYMyUekzTgMb6n46duoJXxM2C54JnO0GaRLcza1gNwWhnEOYHUF5+TU8M?=
 =?us-ascii?Q?O7Kw/7Gd8DgEnUiZaodu1rUUBP18zpNff3q3TdwfG47YTXWzvKR3JhUMpUp+?=
 =?us-ascii?Q?jAzVHIp+CJYDflAdr/3gubAh66hQ6Hx8JDmYwPvMg907yc2LOBdHYxQAnFG/?=
 =?us-ascii?Q?fc4ScGyGMQhOOT4BGP3gY08msm5GDtD4HpHBmEE4fUAuz6fUIREZtn4kkZTH?=
 =?us-ascii?Q?sBOtJmixFohPouAg+3r79sxAwy/yDXolnMH9nB2FVtJdNgOxihNG4HO8imBr?=
 =?us-ascii?Q?go8QDv16rMk2panFPmgwcjJxl3loAturKivr7LkNkdDmI4+GSmSKi33wG7qv?=
 =?us-ascii?Q?FGC7QI5acx1cBWEKC0By1a8Iv4eCdybv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 20:56:58.0883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6dde5d-9102-46a0-d0ca-08dcb26c7bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403

Move SEV specific kernel command line option parsing support from
arch/x86/coco/sev/core.c to arch/x86/virt/svm/cmdline.c so that both
host and guest related SEV command line options can be supported.

No functional changes intended.

Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
---
 arch/x86/coco/sev/core.c          | 44 -------------------------------
 arch/x86/include/asm/sev-common.h | 27 +++++++++++++++++++
 arch/x86/virt/svm/Makefile        |  1 +
 arch/x86/virt/svm/cmdline.c       | 32 ++++++++++++++++++++++
 4 files changed, 60 insertions(+), 44 deletions(-)
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
index 98726c2b04f8..dd302fe49f04 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -220,4 +220,31 @@ struct snp_psc_desc {
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
index 000000000000..507549a9c793
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
+ *
+ */
+
+#include <linux/memblock.h>
+
+#include <asm/sev.h>
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


