Return-Path: <linux-kernel+bounces-311994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3EF9690AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460DE1F236F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AAE46BF;
	Tue,  3 Sep 2024 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Db3T5DH7"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCD520E3;
	Tue,  3 Sep 2024 00:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725323762; cv=fail; b=hWtORG+dLrn2qt13ioIHZo9X1a3X3WdztAnJpcF0DvmJYWOEbXiT+UfAJDxqVt5JKaM3eJBf/bmqS4HtwCYNQFqfxdw/lfalUA+Uzr3413yJLZjPAxxireQ55EWaoNvMIAr+5n9lOOvCaxavbmIuIpK8wJCJSJmCshafSdDxiMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725323762; c=relaxed/simple;
	bh=nhg/6JVX4VPKLmJ2tTI0MR22cgfyLTpm51I39rPLgJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4ChmejayIGv87ZXjPS9IUCJKCFllpfDkdl5a6AKjAfrX0POGX2D0aOSzHNGDIAOosupZqqLZmioYbzCyKNvjU9W/Xx5zkKJFVhKfxWQenSbSCa0LxNu1CeT3kUowPnmxKp6nXZdSpNiUOe+/VjJgdFphMWb7VNxOYadvRCsk7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Db3T5DH7; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZEsWsj9c2PfZN3SSmzIuyWX5vb2uLLiIZ0O+nuAJ5NtKwUHsacul5lOpMXXKqAaNfC+XIMYe6mbGmmgIlu4+omKkot3TzL4cVDEi67PYlIprRL11lDekQ/8IvUyFZrhDVzCFmi6HwDc/rJG8VBju/Y9OU5Ez6WC0JuAS+GkNQo4gYz3l883CkZVcllZi6Bo1ZiVDv3HpUMMQUm7C6tFSYBTpcELuw+xZOerXl5VyHpkoWhD3hsXzqCuTKwzo8TyOy4D0SrlsiB1O/Bm8myemdetId3aCdIO33Ep4X2bA31Gk3WRbDbLyMlybLH1v5HVkd/QdpDlidRdzGw+tkRgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83LDSwg4Wmq33t+oGUmergoI4GuxdsWSC/h60vRjo8k=;
 b=K+yuHpmGNbqHrZWms1X2pluwvmWpt0QKmgo8IsvDPZPxDeZOSB4iHcBargI3K8cPwghlAqtEItC0tb7HU/Utgg0Qke6GGx+AqZEe/cRg2rI+STvm/JmrF131gl/4yVSe+4WdD3XmL9F/KyQ6tJvGUX2z5YdDafPwm4QDmcj8U+4ZNbUb2bK7rOIRkK2JF07bPZGCzrBrcTKLL7n6Xlgc+smXcTYMdoNtOlJrNwHyuphZgJcclGY6lF8Kz3atY7mlyz5t0XS49b3AJPtIBtle7OkgAGeSic2KakDVvTjmmzH+ibkdKPEdKRdoubeZl9CjO9pcpX46tT9tx9hAuNtFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83LDSwg4Wmq33t+oGUmergoI4GuxdsWSC/h60vRjo8k=;
 b=Db3T5DH7SGCnSN90sdr1iP2VaZfldl+WMEtfduBG4sSfVdlyxe3iic+laViyHw9Me0LjGZt43O9oFoNyNKTnxh8Nmaslfq5sUOd62ixwjYe0jDe4MOWpGqeS0XxjxtW5G9yA4dR84qf4A1wfn/KLNmVyGUU/U01eeQr32dNiwd8=
Received: from BYAPR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:74::30)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Tue, 3 Sep
 2024 00:35:57 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::c8) by BYAPR05CA0053.outlook.office365.com
 (2603:10b6:a03:74::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12 via Frontend
 Transport; Tue, 3 Sep 2024 00:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 00:35:56 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 19:35:52 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Pavan Kumar Paluri
	<papaluri@amd.com>
Subject: [PATCH v2 1/2] x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
Date: Mon, 2 Sep 2024 19:35:10 -0500
Message-ID: <20240903003511.1530454-2-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903003511.1530454-1-papaluri@amd.com>
References: <20240903003511.1530454-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: e3644593-e6de-475f-69e8-08dccbb06052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HK+8qbGrpF8GabhOXwrg5c56h3688MaaMyXfUnh/FAa2eAVSN7FxKN1xU6hO?=
 =?us-ascii?Q?VZ+QRocrjsptPnYGr1WYO5R66jT33IImGNINyG1ahZmhFWa62e/BmYlg5bRE?=
 =?us-ascii?Q?rF60lPmIOKeLEXCZ2ogsnPBPrFfRfFNoCeDh5O2yAC2ytKLQ3SAx7H7jk+FH?=
 =?us-ascii?Q?49GoBQy5X0ESNVKf8yT0eNP+7PXqZ816S1rh14SkCMFmKoDB6muROOF3/WJe?=
 =?us-ascii?Q?LjKvTkEoD2w2o7M1wz40R2zcM92CH67oTiDyglZMsVeOUzTR7o8afBftWxLt?=
 =?us-ascii?Q?ZxCvH/g7dzb7zGpKeJgS+ZWai11EE+8wrj2ybiWXq5P35D0etfFpfKwu/2gp?=
 =?us-ascii?Q?Jw3ZhBl5xKu7ZVDqOF2Na0W/NDLuNy+ZPMMD+B8MOegcWqBfF+iacYfBkSAD?=
 =?us-ascii?Q?CYMb0jom1OL4Xb1S4I5ITY8p+fpt17xDCyfmuw/7lrANuQMKyAfcVkAY5CX+?=
 =?us-ascii?Q?eazeerV3MXzpv1TRCBOZ9Xy6x8I6wZOYpObzIQViQrYz2XOJKirXVTEXg/oF?=
 =?us-ascii?Q?Lv3muQ596P8P7W/lOx6XGrWS44gwXRg7IbNB7uYtAbwc6nLKn9qQgKZkQR+D?=
 =?us-ascii?Q?GaNIcaiJf4ZCryCROMGzCj46mkT9GGR7P3b0RT6MUvhxkmmGkz5oSTgEJCHM?=
 =?us-ascii?Q?EJszbUaKjXTkWWokk9Dn4q3ZQTrESk4dRvZcUTtLh2AJx9FYopdymSHnlAkk?=
 =?us-ascii?Q?2rXHJDNxRoxEqDrtwsgwExx1f2DmkqcN2TAJhVbE9vZD8q2bHXIYb3KQHkDa?=
 =?us-ascii?Q?9IKQS7cWlNOpHb9xVeHYSqGd0r28t7V46Kpj35jL/84WrdF6zVUxgpfMn7IK?=
 =?us-ascii?Q?e3EFB3ZaqLWoIU/M1zY4/z2HxE+OI0/kS07kUfNXqvfFG4kudwM3eiRDaDVM?=
 =?us-ascii?Q?US1u0pSeP38NpzZjhMICcwWkx4Ma/X0e0bTQFbxdp6kmpQiiB0nwUIgy3ueQ?=
 =?us-ascii?Q?14alzUSVzL105av8RV/SnHFKxp5YYNYb53xheZn569qs2D4pniHtgTcLZq6P?=
 =?us-ascii?Q?WYcRjR/VL7ZH/33Js32c53DonQ6DumlJ/EGnxCIXVg2WbrzLkWrhvxf3l78N?=
 =?us-ascii?Q?4Y/d7rDXx+pq93QYkgz/ebwnJGuZkU7p9sTzV5I38VP/CQfro2As0Xl//NBp?=
 =?us-ascii?Q?Uz+h79W8kOfeTTWUzjNMKUoMXN/6UNrmoXu6WSaIBuzSb3YutWEkmHSYkWGc?=
 =?us-ascii?Q?uNHWFqUx8S5H1Tnb5vEasVG8kYv7R5B27GqAklKWMIHph8mD3i/vDNRNSr1X?=
 =?us-ascii?Q?nHFkQms5mxNSIQyga1ll+9w73LSD8TSeDujABIOWjHbn+Xhc5ExGCgmTugUG?=
 =?us-ascii?Q?8ev//5SqJr4ilzyBR70KptvTzG8uBT78wl9UrPLAafeLFyztpIPnJhJ0idS2?=
 =?us-ascii?Q?nwKMt7oOZddKyvG0FE8WvnUfg701r/dzt3XtQoNObujaeFTNQseJeHfcDrkr?=
 =?us-ascii?Q?/99YcKZUMbjY4Hv9rdz7rnUdBVr3GLK3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 00:35:56.5620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3644593-e6de-475f-69e8-08dccbb06052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011

Move SEV specific kernel command line option parsing support from
arch/x86/coco/sev/core.c to arch/x86/virt/svm/cmdline.c so that both
host and guest related SEV command line options can be supported.

No functional changes intended.

Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/coco/sev/core.c          | 44 -------------------------------
 arch/x86/include/asm/sev-common.h | 30 +++++++++++++++++++++
 arch/x86/virt/svm/Makefile        |  1 +
 arch/x86/virt/svm/cmdline.c       | 32 ++++++++++++++++++++++
 4 files changed, 63 insertions(+), 44 deletions(-)
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
index 98726c2b04f8..d3e7f97e2a4a 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -8,6 +8,9 @@
 #ifndef __ASM_X86_SEV_COMMON_H
 #define __ASM_X86_SEV_COMMON_H
 
+#include <asm/cache.h>
+#include <asm/pgtable_types.h>
+
 #define GHCB_MSR_INFO_POS		0
 #define GHCB_DATA_LOW			12
 #define GHCB_MSR_INFO_MASK		(BIT_ULL(GHCB_DATA_LOW) - 1)
@@ -220,4 +223,31 @@ struct snp_psc_desc {
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
index 000000000000..4fe34e831d8f
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


