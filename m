Return-Path: <linux-kernel+bounces-317276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2654D96DBD1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80311F23577
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30339FC5;
	Thu,  5 Sep 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kZyW5y/u"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8E210E9;
	Thu,  5 Sep 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546689; cv=fail; b=ciTWRN8iUK114V64BomACaqhcm1hQXqiiI98ruN9I4As7w+fTYQLR9/bg3Sq3HLK98AzI0zGV7Lah0afI9Bbt9erkNi8n1v5HMWLM48uWvNnjtPdzRzxomI7hWxkE6gWUhIy2zhgSRldA5RZfCGHO9q1geFDzLkBCXxwLjfXs1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546689; c=relaxed/simple;
	bh=srNLLesiLDuvsSunKUoLm06Xtwdrvo3kA73BFQ3ZwlE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+vXl3BcJCE32QL31AvdCsK8bcR5NM3yctph1n2iA3Q96wzlR60g03RXR8Kdqa/cruTiccit6Hmqvy8bTuBVqpCO6Qfd98BVdMvimBZ63XEJbYXgSj5uG3+4xOB4WoDu6hDQVUR8gWmaRooEfOnAg45GnHgLJSav/u0W+1HOFQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kZyW5y/u; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjTw0GkLYEVvhlio2N/zaEFoSPAqaHHoRuHVSX/vHRkYwTgR2Ee15TrZIkXZKPd5e28eK/96efstxUWAQdYyjqJ0nPFZC4wVmeizCYM68HkgQN/9nQkqvr6N2MhdBOKr4thIwhcylh0QiYi3gL6BeOPk71T+qz3JGaKV9/mnAkSL9wEvci1SPaEVhg5+bEQKN5aQNj2sp2rEeSwDDSF3quz1E+tVPH7RAZLG41WSJ6NVGQgMo3pXov0hB0BtPSPYdvmzwoYF+X3fBnr1X0ppAyxLTv36yuWAq6x5qN6BWakjs96D3mZVbPxaZWPtVgZW9pR+76gLwQRbwUeVMA4IfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYpJU64SQo7/EmW+nl44948247L6IgGeXRY5+/lN9cA=;
 b=LKP2IfpT6uaRW5hs2V7demVTpd2DMSM0LA12mD9XwlEM6lgEvGKzslsOU22QO/3S3jPwF1ZtwIJMiSGIzdSExh8h9lmdnf1kx5TG31HgZ6PjKDX06o05ShXe7ApzrhtsFG0nh5Mvw72YKbciOytJiskdpe2SrzLrHvDDC5rxn9NC4QWusOxQtKXc1yEGGvRRWi42uMMj+rN5208QC3NG++bQWBc9yslfh7BO1gZzI50+RPSdXR2PpdxqCBtagi+a9ho7NIUaUJbFUou9niN5oKzbOiR7tt8FsZA1/xAQGZ3OMvJhHMPjEnaiLbf9OBk6ELzwj0aTyfs7BOF/EGhb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYpJU64SQo7/EmW+nl44948247L6IgGeXRY5+/lN9cA=;
 b=kZyW5y/umg5MWyB/SsoDZ38JOEJCY6k+D6+7G6e6GYOrFkVe2QEBfpir3VcKDSH1mURAsDPpKyDU01Eld4Ky85OH2rOUmHxr9L7UooZ6BbTWEMNLBQzK8KkNSkxeCe3gjCncTtkugiUeeFe5zJ91abc1+NU7/K/0vvaP/qKF2L4=
Received: from BY5PR16CA0035.namprd16.prod.outlook.com (2603:10b6:a03:1a0::48)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 14:31:21 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::d) by BY5PR16CA0035.outlook.office365.com
 (2603:10b6:a03:1a0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Thu, 5 Sep 2024 14:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 14:31:21 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 09:31:20 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Pavan Kumar Paluri
	<papaluri@amd.com>
Subject: [PATCH v3 1/2] x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
Date: Thu, 5 Sep 2024 09:30:55 -0500
Message-ID: <20240905143056.48216-2-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905143056.48216-1-papaluri@amd.com>
References: <20240905143056.48216-1-papaluri@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 54fee22a-f18c-432d-518e-08dccdb769c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hE46hw2KrBbntEknCrZKYu+C7DydibZW0nSSriFTupGL95omAN8rOtNP/kQJ?=
 =?us-ascii?Q?7wZJipNmVGkAO9s8COc0jY5wrtf8oTbOXEFNM6spJ25j+LKMn4NB6U483tbx?=
 =?us-ascii?Q?PTuyjCxkcmaADgKL9EGblBK4+ZsAR/e8oGvPUKaLpjYQa0JOIpk5LIr4SoXA?=
 =?us-ascii?Q?0PyzmzctG5BRhF/UwZCbdplDvLJqw0QXTRBNPc923is/PZh4UrzcdI5HTo6Q?=
 =?us-ascii?Q?oS759YcnqbuK9Tux7For1DUrP2royMteXJda8jOtO4oBy6tewtEd/KSSbjvf?=
 =?us-ascii?Q?IZ5vVF0DEfcVwnxirlIohjlrkrQGshDd0qOni4zAu0xnNIl58v9O74dhVbfH?=
 =?us-ascii?Q?yyCWstuR4PfjUVKxRaTjJZraX1QbDPnNpbSWZVbWnL0EEI03VDFL+7fzjukj?=
 =?us-ascii?Q?7sRFNPSTHY4DafmbXrywmVyOh57gaNFDjBv50I7LRlcaR+1HLulGB/uck5/M?=
 =?us-ascii?Q?c5243OBSTW+/6Dvl2oG0cSG/bob3OHsQZ0nIzQxRjkxOkmYCk0/cBW78Ua2K?=
 =?us-ascii?Q?JjdircsILzEbZOOMuWWI4rSs6OcXCYAwaKYHvk27OrMOHJUq/ELkYCOSTfmP?=
 =?us-ascii?Q?6LD0d4u7vqYUI2A1mcqUD3Nn2p0ns7KMRGwroT0OlO3o6DmxxHpjeOInhEsd?=
 =?us-ascii?Q?KWnFhGfUEL1v5ghnyfZN26NREZKDn75KA47R/mEo3ZckaUhJHcxFhGJry+Fl?=
 =?us-ascii?Q?3IhLtGGqgyRZhPNN0I2IleBm7wU0ZITZfB2yB91SIEFW+tXBjZHf5hoQlHwI?=
 =?us-ascii?Q?uE748yrQk7tHuI9Dejhqc3lcXFeXkmTYmv7RfcGeNZ0azQnxBmnpm3pqI1DR?=
 =?us-ascii?Q?PrZF9QT8wilktALg1ITH1TFXYiBOF8qUrzPKaJThk1zG5729wF0ibeRVoZ89?=
 =?us-ascii?Q?JD5Q8OvBHG+NwqpUZCTBYZSipIOfLxbqu84mGxRQZWUPUsYA8rvUTACGGeN0?=
 =?us-ascii?Q?G0Oh8kyyMYNY3a1M/BCDo2EHbko1cyG8ixScGpd9BcmAcCD0Y8PXj45oSxqS?=
 =?us-ascii?Q?YC2ZcBCstpMbq6rW2h3GIwxT2LiPX7B3IU+Ja6tHkNC1vzSVdZazqfzyp072?=
 =?us-ascii?Q?yZavf80uGPco1NHPNbWnXY/Lv9k4dQDUtAVUvOzrumUmgTDs9OLmZ4/dc4Cx?=
 =?us-ascii?Q?G9Bgp2xbniWtdgLb3qDZohf0JWi+y5u1KcwBiWkf/WCLF2WoV6/cxEOA9btA?=
 =?us-ascii?Q?eWiXHKxb1rpoKBCXe7VPSK+bEZlplyXgyLEwc+sJ5GFOcm9KbOFto5knWIrp?=
 =?us-ascii?Q?Rq/UN525qBlfbZ8ejv1N3RA66lE0iswDH5Cr/7t3mR/PfCFY/YLTD+37mffR?=
 =?us-ascii?Q?P4k7+eOukUtNQycTz/l2FuEf1ofGThZB/tPaifQ9QKObmPuX/IQoeQwQm8aa?=
 =?us-ascii?Q?gu0Frjxto6BJMIzW7+x1NuJr0q/cjOPM8ayntlWeJSjsaMRKP6biHpf887K0?=
 =?us-ascii?Q?iJPVVm4sr0sdm3Owrj0BjqpwsVEzSRbY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 14:31:21.5741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fee22a-f18c-432d-518e-08dccdb769c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899

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


