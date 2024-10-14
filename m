Return-Path: <linux-kernel+bounces-364104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2935599CB31
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813AFB25209
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D004E1ABEBF;
	Mon, 14 Oct 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="40OTqukc"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3B61ABEB4;
	Mon, 14 Oct 2024 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911417; cv=fail; b=EaYAdD3wj6RzqfrlEj1qXbfcz4zRjybLrCggodSL0k2VCI/Gklm1SPqvcxpIsve+qPrjYIudX423dvf40+eChrFoqMUJDO8zLhSlutzsFOpG1JarEaC7Ays/uc+oKxfpP6yLmux3LH/g9Rw7L0oISQNxiGXheJq0cCeVRhw2IvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911417; c=relaxed/simple;
	bh=bcNUeFc3ANsNxa/r9Z6gfGywVJTNnsWhZrixPm/cbrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1XOCRjxPVyvkdy7q9Lr2TscnNdG/2fwErWk+IHDhWWn32qytmxZmyc46PrrfbrxjR6nsUnUbz7vDaWE1cd+4fd9JPBsVkf3fS2qLzEgZ4EYPgZ92htV4P/rdggbwWdbsYIz/mnEqLXvdFblF07kCFIjmJL1393Y5/Q5oHOT4wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=40OTqukc; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbjzhs6L5xk6IJ5a1YBpJbmhkPlmoywGImkyBa2kxnJVHTtFPmxiequgHRmt9nvgEKYvJ9P6/zFKPspX/rEfKosEYxNS4XEubbjDKDixw3O40Jf2dmBz8GPfC1VtNftPLkNQrwfSDGqWgQK8gE9pYYQl9n7Ce8KIiByjIN1XkInXwbd2LL+CawqViUVg4b5obrvzR+/qBMI6+pvM+gqZIKalngbPFXFm94z7lj2ZezvJ/GB46mUjuFYFrEWpK2OnmYmdJ0IEbqNz+mFT4Nyvn5LRDMeTvIfrUWqrlKzscZsmvAA8hUKOsNtHlZdcSWp7NQO3rdPcU9cZ5xEVQ43z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jkk9zG0ZFzpQeKLkU77A9p54dY5F2rUL+eMLcHRmis=;
 b=w7fMv7dKaByFIlf9aqg6NwVtthNwLo7QGJYpGAeou3Oiz7bmR82Zld02KizWC67U5zvEW7njreELebF1lDKaCQga+pYNCZ1DvbbzbW9nnA7CVan0Po4tUZ2U4w2VuEmTuJaCMLCUryahsXyC1ZdQ8s8NX+v8am1XzP0tgeP3Gw+8LXhG2svJd1pgGBcryVgTUoLzYmVT4jTtHLcmVNq6UB29GKZSXAvPKG+zYXX43XciPcgqpTVYdMsXzbkiLB+vEhuHyMzW34lRW5Vyq0RWqRK0ECOc6WVE85zpps0SVYjmHjw2/Z8fU9kkCNhmtVSs3tneWWeGBhbSntlViHaesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jkk9zG0ZFzpQeKLkU77A9p54dY5F2rUL+eMLcHRmis=;
 b=40OTqukc4w65IPJyga1nqfBN6qeKAmkcTWGx5kmAem4NRzXX7D2uZ81Hd3NP+E98ylc0z/MEInfnzPziYEnM70nnNe8KD8G+NSIw7qZbkFELfWKNfi/PHK7cpG68h9+mXtbNxivfLROFK2fZ2qy8Aj/tM/pxgxWgVSN2Bzrm19Q=
Received: from BYAPR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:e0::41)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 14 Oct
 2024 13:10:08 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::c0) by BYAPR05CA0100.outlook.office365.com
 (2603:10b6:a03:e0::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Mon, 14 Oct 2024 13:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Mon, 14 Oct 2024 13:10:08 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 08:10:06 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, <linux-coco@lists.linux.dev>, Borislav Petkov
	<bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Eric Van
 Tassell" <Eric.VanTassell@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, "H
 . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Pavan
 Kumar Paluri" <papaluri@amd.com>, Dhaval Giani <dhaval.giani@amd.com>
Subject: [PATCH v7 1/2] x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
Date: Mon, 14 Oct 2024 08:09:47 -0500
Message-ID: <20241014130948.1476946-2-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014130948.1476946-1-papaluri@amd.com>
References: <20241014130948.1476946-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 22370436-3a3e-4408-18b4-08dcec51872a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?de5lRCUSP20CSUMCZwjtOF9/MvRSWCSUXMNNc3oDNExsP2PHoVRwu3zcOvTE?=
 =?us-ascii?Q?EXvk6KVoJFSaZXxwtUEgv1L48WKB/eOYfsdKmwPoECupCM4s6JLcntCxIdnm?=
 =?us-ascii?Q?/3UdrFQCsyw7tsMD+bLYaCmx8yOGpU0Sb1aJOZtwD/kWIBqL6IdRJNoAejZm?=
 =?us-ascii?Q?p4uXcPuacwHq8dfaBnMPnfl7B2ENuOouDqnX7uLxCYadgJeDRLevbME6XZGW?=
 =?us-ascii?Q?/gvuGWoIxOdbnnWyP7SrON712BaxS1p31J84h4Te2p5xS68wyRkeqZz6G5Nv?=
 =?us-ascii?Q?Z/zV6I9QiRfD0IIiBOZjjRsjWb2005j3VVSGrbyzT61x58acFFokPbtb+2eG?=
 =?us-ascii?Q?PNt35COq+LwYg8Kq0qtgfzk9Bbo4DjSdoBdAlKGNhRJCZr9vz9SIuiqppUJW?=
 =?us-ascii?Q?8TmlGqVs70Ce1H7MndjIR3CGF6FUKYwwMJcoWr9xTO8uBA7sfZ8zeM+X0D41?=
 =?us-ascii?Q?fphiPTmG7Qpx4fDOfO9LCL/bSbs0qSJBcKxUzcZB28Y+9MbfGUbslE+x3Mmk?=
 =?us-ascii?Q?iKXpw9KB664VD7osM9XcKLPXfDxWRpWK4C+JbAo6ECDk7rgTRArdHIUVLaei?=
 =?us-ascii?Q?HPb6ewxLiHNcDEEeW5ckdCMPAYAdDkm/fmMj2ls7Cydh/bumbtfJewD90/CC?=
 =?us-ascii?Q?3maey4bHJQL9aK+kTJ8JT0G0O1FyYjEI9MT9wOFQH3tR8PkAIUiWtNvQ0TtU?=
 =?us-ascii?Q?OV3BL3boTVKkd0/JO7+4oyr5yEMtSjjHuSTI3lZwPX/8cIPgfAu6ydHtPthn?=
 =?us-ascii?Q?+BMqKteHrVeXSColnDA8y+85SnCiwQyXmu41e9oxLZfXNgABoIO6TfvIIPEl?=
 =?us-ascii?Q?nCflWqcPBxzTBqrxI/JJ8tMzVOVyekBqJDUY+QhKdy0tDyKk06dan6CS+iKv?=
 =?us-ascii?Q?hqW67Qy429WD5nzAWD8KeIg2ejrVwJ1im+n4KGfGobW0DeMbMT04qT33lIaN?=
 =?us-ascii?Q?HpwQGnFC7Z48T3adGBhtrM68ElwY9+DcODcI9FkiOAdaqs2nuiF0xM36aJKL?=
 =?us-ascii?Q?LQqmASi3g8VzQTH0iCtsfLBi+xU85I2uqsuEgULz7jyhyAjSrmjVUPIbWmWP?=
 =?us-ascii?Q?rVfHeNi7Kv/ElMvmVcvgbD08jaz9k+BelySWe+2cjOJ/KeCDkLyajcrsiacj?=
 =?us-ascii?Q?TeNUPSf2NRsFSlQEBBBEkDwIALzfOhufj+XVtX2sQ9caOTzEjjcR07e48frF?=
 =?us-ascii?Q?BctOz0pKF00UzFP5OhyNbYzsvPlHSFx2Yce0ulVhaj9tx+9BiKb++dt48YRX?=
 =?us-ascii?Q?D7pLYSYZE85lPvdbbGtaGJt6ts2C08lySh13x6dfenFJk0mj9GewRfy8PbFX?=
 =?us-ascii?Q?/8WbjURy6NC22jrmIVlEcz9FjCIl4SSIKW1s+vy17Adhb0EJjc4KgwiBBtp0?=
 =?us-ascii?Q?FMGR4V4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 13:10:08.2706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22370436-3a3e-4408-18b4-08dcec51872a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932

Move SEV specific kernel command line option parsing support from
arch/x86/coco/sev/core.c to arch/x86/virt/svm/cmdline.c so that both
host and guest related SEV command line options can be supported.

No functional changes intended.

Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/coco/sev/core.c          | 44 -------------------------------
 arch/x86/include/asm/sev-common.h | 27 +++++++++++++++++++
 arch/x86/virt/svm/Makefile        |  1 +
 arch/x86/virt/svm/cmdline.c       | 33 +++++++++++++++++++++++
 4 files changed, 61 insertions(+), 44 deletions(-)
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
index 98726c2b04f8..50f5666938c0 100644
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
+extern struct sev_config sev_cfg;
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
index 000000000000..add4bae3ebef
--- /dev/null
+++ b/arch/x86/virt/svm/cmdline.c
@@ -0,0 +1,33 @@
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
+#include <linux/cache.h>
+
+#include <asm/sev-common.h>
+
+struct sev_config sev_cfg __read_mostly;
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


