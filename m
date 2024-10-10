Return-Path: <linux-kernel+bounces-358950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A6D9985AB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AF3282431
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8D41C2DD5;
	Thu, 10 Oct 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gcXM/qwI"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9651C3F18;
	Thu, 10 Oct 2024 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562522; cv=fail; b=QP0cKY8/37eugoudIVPb0M19MgGvi98gBbE0MVnjwC1KswYsiMF0s0DwtwvUXPfjwob+qEuVGhddtfGc1Fq4hHAMDmZzdLa4b4W8BV2lVQ3LDo7X6TNRN3xStot5PswaISjrFHw9CEQl08wX0tmckKDxY5U/wsPr4s+uJShVeF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562522; c=relaxed/simple;
	bh=LlCxj/gaqnhgIzMtbHxrCWYkJ2IvoGgUj4EeaOvSAnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkHMNXTDLjj+PdaR3QyebQUbegVau8dLuhJIBQIxOb0FLG+Vccp/VcTjMeXVqSvA50dfioF++cTotTy4cGBdiwoPYEBN9O0i1GWil8Q4LOoobeoqNMpIw/HK8GR8iyDOJccvgGKaOJh3ePYw7mkhQ0XAKegw2TnnY0uo34cyCsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gcXM/qwI; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSynuDX214A6JSS5NfYgsCotv4cJjHn1tEzAtI5z+6D/zpPZUXz+11AaKnmhGGlTv7I202gyU+t1DuyAeOtLQIjPzWUo+LVxM2pWEFACGopfABVRB3EzxXGDKFztg5agLUYNn1uISdvfFLszaVbILoRvDyjRqGbymLaQdUNlqoxw+7zG5n2LtPSgDWTSXsHss+MGWjWhDjE8KfjrfeP7neug4JejKWAYeowhY/ciZ9URv33L1gGQJMxFbQh3UZiev8VLSms5jQRqiJchZA+AxkGqFbDvppP4rPOFa/CfneSeMXyJfUHIiJcuq/KszIdZ8YpOZgfN8KOCAZpqKRcN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8lmCdmyRyarOKU9cQRwnCBCVlhhH7zBEmOJCi+Uwu8=;
 b=XymO3TWUZuZQT4koE7JTf4dO4ShHjfhXJwvMsvOjsuc9QOsKl9VdV3MPaDwdQCuCnpGlFL1Stzxb7/NsKiH/g7imW/RyQnWOrB7EIEq7/IECNMzkJtM9/jZ6AFV1ZUqhTU8DiIUPlEiUmdFZySeZQcGhM7iIQN7FV52alC+gcxJGmCnpXUtqOio/VLKMeYAIz9NYeKGTxq0xbOBSGUhZMPwMr6N0lr6mdcoHRHbT3NcX3++BXQwmc9hhOnREHoy0u4TjTjjELjKrQQ9rIp1Z4bpz32vo93W5i3oP4zO2YZRzHFCtMcRQMIYvOZQqeitrWpG0qHYApyJSx6cqTI219w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8lmCdmyRyarOKU9cQRwnCBCVlhhH7zBEmOJCi+Uwu8=;
 b=gcXM/qwIp68fY0PzEMJ32ROVmelETdeI/DEcANVzNdsNDcuNvfLR07brLALufjrCJlGMwCnqSbV+KEQPQ0poilawHb8Ed0B/Tqm8c5NqjD2tmw+Ll9kFBQDpsuIbiN5j+nVddyEXtAn1HavKagKmpXCY/9k/Gum9lW6JSEjS+yg=
Received: from MW4PR03CA0325.namprd03.prod.outlook.com (2603:10b6:303:dd::30)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 12:15:14 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::e8) by MW4PR03CA0325.outlook.office365.com
 (2603:10b6:303:dd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Thu, 10 Oct 2024 12:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 12:15:14 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 07:15:13 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, <linux-coco@lists.linux.dev>, Borislav Petkov
	<bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Eric Van
 Tassell" <Eric.VanTassell@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, "H
 . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Pavan
 Kumar Paluri" <papaluri@amd.com>, Dhaval Giani <dhaval.giani@amd.com>
Subject: [PATCH v6 1/2] x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
Date: Thu, 10 Oct 2024 07:14:54 -0500
Message-ID: <20241010121455.15795-2-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010121455.15795-1-papaluri@amd.com>
References: <20241010121455.15795-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: c2cc8989-cf5e-428f-9b4e-08dce9253220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HAx55+DFbx2GkCtPyBmQE1+buyNrobIxHvql0+/umsT1EahNCyTlSe/Ud5H3?=
 =?us-ascii?Q?Z/ir+LoDHFq0tgWk9/AbAeSpEcoo/hVkIdX/2lFX/14aahqzpPUx2YaObac2?=
 =?us-ascii?Q?o4EgBNLHVxPQdlOBhykI/JYMx7tbAd9J5ZqFg8NtU9WEFk0GDeFr4MlXFzOe?=
 =?us-ascii?Q?6M6p9fUT5bdyb6XILtnqw4S1sbrl21d1v+W5ekFyzmX8T2qI7KDsUltuU1p7?=
 =?us-ascii?Q?M4YzoBRMurNTY8NgM/n0mtcqz7f2q+wViUV6y8Dx4RQtCZjSDt16sruBnO9L?=
 =?us-ascii?Q?4l7VrEki8YsxoAn79xkR6xbcd0I8irRtkcnPE5aCj5lq68hiTce4oKrEIBRj?=
 =?us-ascii?Q?mmXUb7wnWVrXbmaIaLvqVyicUvbdfibBtRdIceYUlEjlBhwgBMl6nX5lQaf+?=
 =?us-ascii?Q?6heozzKPLzValjTXLYDa6EC6t08Ouy9Oh6cVpaH+lAIvmNdIf75GgzMn+Xyl?=
 =?us-ascii?Q?2Ez/ExRaXc3upWcxQh0g5SQpG3k3yUMM9TEhaOuB4dYpqHKc6VgunZAu9O3z?=
 =?us-ascii?Q?XJEBPpeiyyZOr369TuJqjNNxF4Zwash+foNaaIbbC2dyJaquVpQ0u6FPOmI2?=
 =?us-ascii?Q?JJi5iCYoF5crLxRBWOolDrI2U92QXaL7PzJsnmvFF5gwB5KYoONICKXqXYU9?=
 =?us-ascii?Q?NwLDSH0Vir0f6Rci1SWYMU0A+khYg1yl6yMJo6UE5HCb6iGMpKhJ8QXtqkoj?=
 =?us-ascii?Q?oXo4jHHC5PdOqj87w5hmyfv5pkQWo/7s4yKbmqHL1WSkBYDkErY9t0S4Gliv?=
 =?us-ascii?Q?EklNKWzO10kxJhF/6T/oN2XNPldq5BZ/I/lExhyAWh0QL5iFZ1SKkcbkxIdW?=
 =?us-ascii?Q?+Zv8XLM2zxietnvWLNZJ/l9bp96NVRF7uWf6So3TWbs6EjyrSQOZhsG0pw8d?=
 =?us-ascii?Q?1lA6HwA/xzmH8SitouPQa+S7ci7trubZJHT8Qk7cl876lCtON4+SBNnBico2?=
 =?us-ascii?Q?NGEMirfOjlJyO6MCRIjreGMF/r0XkXibpEAFNPWWSO8C55pUvaSq22bMm18x?=
 =?us-ascii?Q?MgWHnYXqCOBRQZbXiCs06WZY9P+NWtkuDS+DHpXlHbD29TLfQ6zcM8LXE4EC?=
 =?us-ascii?Q?/73LeJOP+Q692jIDXX/sdhIp9HOEiSC+0OHdUvh3oC3v8VfjCpXSoqSRP2cc?=
 =?us-ascii?Q?WwlbApno4utC2HyJDE1d/NQlU1/W+loonk4Te0KOf6sE+XDwTahMv9ieYXw6?=
 =?us-ascii?Q?LcZpL7XrZDc1yHMg6DjtCVHRdbBuskQwxMS2Kqse9XktQxNmg1+9+lupmPqp?=
 =?us-ascii?Q?9aUU75qJuCoc8nGjgz2io1cycmGsPu/mnQKgUGA5fAkFQHc0PH/kT7rDlGim?=
 =?us-ascii?Q?igMcj5FavJivd1LBGL4LN+lGMMaKC446G942FajuU99cKGcJESb/+3opmGZ1?=
 =?us-ascii?Q?nUjk5M8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:15:14.2420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cc8989-cf5e-428f-9b4e-08dce9253220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667

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
index 000000000000..9640507342e0
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


