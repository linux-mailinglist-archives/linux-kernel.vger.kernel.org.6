Return-Path: <linux-kernel+bounces-344960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C65E98B0A3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56A01F230D1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA49E188A00;
	Mon, 30 Sep 2024 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PLxkKvhL"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546DB185B78;
	Mon, 30 Sep 2024 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727737890; cv=fail; b=N9vIrUyo/wbO+FTM/KIKsHhJmQJfmFLb5pGqgl/Ah7QT/oqTItsRdpM7iiY+w8Iuf/ajzIjRNDOiX9vCCLJF1U+iFOJPjujq6swqDwRuX42zvq+vXjLRO4TQEVY6bq9zgTmcddJNKFaBAPvU/fHeEQ9Sebqx74kK2+7rxMvG+KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727737890; c=relaxed/simple;
	bh=3DDcqfVeXFDE2HEGM/btMG9d5Pp3amyFNqbWoB4eZ5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoaSkrukanTnkQrzsiAfmq3wJqmPGKubJWKzKkS6JreseH9KBZtxINiHRd10Ms45G57yjOscpZWm43HiaMHzOdg8t9L1ezccu9YsztsJo4G5Q2jLP6/bFYx7h9z5QrQS/9uRciZprQLm6WUE0L8KQv4QQfkicG2vTSjHzTTT3EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PLxkKvhL; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1QrcGgUEYJ8tAZlr7bjceln+9pM2sFrYb6NNm9qu4Dg12XOc4DBoTT3ZkvFSkE6uQM27D5CnmXK0fqknTeVgVBJCTTtd1VHRkawvpTQEjl+kE6CccHwID/FqWe4KSlxmzg9BkbrGnaYt011fBRJ45b3Thr+eG4b7wkUyTatbWRk2yzxTHBGJf0MkYSzT25f4EJv00rt/wTcI+C9kVN3YesKwOw9SmRCLD5hmPoBjtdI8NPQFAM15wvN6SzqPEjdISS7Ij9yd2rg5RlIUCIXuhD4vmqaWYMphc8G4Xaxk8yMHOHgLoxRnt39X37M3u9O4Nq7yu9iGFaNM99DMAX5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+vTSSMIkY/W6dm6DoGGBOA1s263+nMZTxc7EP3Jej0=;
 b=brBflFLUSKY+QsanOhkWuJ9u55YNFfuQ9OCk9sb6RFT5cEyYE7fhMPxsipoxo6vb6y8S9A3CT9PAo9XbglhGQjRN2/JyzImSBFRotjfGqrS/xQcTELbWOTD6pIT3m7ZA0I8y14GR9YowdDzxwVhsmXtdh4KhNkRS6cqDUBSgxT+LFIjvAauE/fXUReA1+lMjq1fV6BHZFLhIVYmTUBjWe3Bt4K24hUrl4DjHSjNU79y2j7DL218LnfWMbq36wMZYP1ij/fyX/ZIcethGqiF8jEYB3v2CamBIUGT77f9nRtgLLD6XbeZ/wnYCP/zOmqHgpOcgVKGuOdkb8SamtgFDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+vTSSMIkY/W6dm6DoGGBOA1s263+nMZTxc7EP3Jej0=;
 b=PLxkKvhL90/L039uv874U3qmBCtJLgUtlt1Uy4cwz+mZ5YUN/Ukmf7UqNwprFf4cUhYLYwKj+2wzyiMDR4lqVatPn+pwxYjbCHx84HbihHPq3US9U3NsfNBw7L3nnNd5abYmR21Roduboh7jP9MHT+E8U1Zue18Pk1wv8UhbtaM=
Received: from CH0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:610:b3::7)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 23:11:22 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::87) by CH0PR03CA0032.outlook.office365.com
 (2603:10b6:610:b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 23:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 23:11:21 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 18:11:20 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Pavan Kumar Paluri
	<papaluri@amd.com>
Subject: [PATCH v5 1/2] x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
Date: Mon, 30 Sep 2024 18:11:01 -0500
Message-ID: <20240930231102.123403-2-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930231102.123403-1-papaluri@amd.com>
References: <20240930231102.123403-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a342540-1c53-4294-1a3c-08dce1a532e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u8wks5yiq3csYZ+cjESWL6YpTRNEv2nhvwTO0dEOdC+m64DF/n7PFD/cEj1B?=
 =?us-ascii?Q?PHWm3JEHooeYCUOcY+1qUJaR9WtZfEbP+bvabEVkReUDs2t786kPnFexHocj?=
 =?us-ascii?Q?oDsxkmRHX5OQDMl/uj1sdC5jRap/rxMKF2iW7SkhVKoAJizb9lQlXlhM/6Fx?=
 =?us-ascii?Q?PI5umZJvJwVz9BjDEmdG+jZ+UnwuwVzSKskusCZeXq4hKzB6DYbVY26LlRD7?=
 =?us-ascii?Q?AXIgB20E6N6L6Z2d8QgeiXlFppf0JGTpmBvk52tEa2ZzUWtpnteHE5vAapQS?=
 =?us-ascii?Q?ftYbhdVeJWR9sRqUF4oZemyCOTa1rD83BcKPzDggu3Dv6i3Zhpqj6wcbgrq2?=
 =?us-ascii?Q?0bOVlj9quH9zS2feGVgSZe7fpQFhsKX1orDDcq+Y6U6HOFIyLewflxz8HHpO?=
 =?us-ascii?Q?5QQeT+0yg3d6GmAGfyuA3PWb0HT1NTNsV68deFGhAwR4DJcXBIvres3zsqGW?=
 =?us-ascii?Q?LVE39sD/TKm18AX3lTpSI65sjq/WdslAvH8f3iYH612+zpdrIzXprnAy7wqr?=
 =?us-ascii?Q?vDlOVY3t8qRznBV4w7W5Ts5CyfSG3FSgNAw2LDXY0/T0/W8tFlri6eY6T7Rq?=
 =?us-ascii?Q?ihrBmedWHz2pmDlLRRBvBYZnYfVk4KdivY0GoTiTye7QAbRMo1pe/0R17sec?=
 =?us-ascii?Q?uTS/mH8vI4vvvwDc8lMOEG17h7er8ujOJf+rDz1x3nVLB3Dav5fv0Rtewb4Q?=
 =?us-ascii?Q?Wt6pH9EA3kgRVvq18a7I0+lYbzfrg+mkj2ZvW9lUMZZSL8MmGO0NTNwDKt3w?=
 =?us-ascii?Q?uWz9xjV4wrpzdTE5488b2QRaa62eLKVbW/zSVPXjcWv25kclRmFlmRJUbLWY?=
 =?us-ascii?Q?RV4JXBOc30czB5yfFIUHnIcTitvNV0J0VeXHEfeHSG0Pdd69aYZOkHxtB9Vg?=
 =?us-ascii?Q?DWvRoxQBYKT+4caa0/iatrcFLieNZB84eyRZtH17VV5Zx3UwhqapKBLLI/2O?=
 =?us-ascii?Q?616TIppTlqA09cQEeYQoPve7xB9t0x904Co3pEaMKDZ6bpxIy5594kIvKu+3?=
 =?us-ascii?Q?GrdvxcFNRYNsp5r/y4GrMmfd2qsGQgxNMuJ/wtLpR/Vcs9A2vKcTrnVczzcc?=
 =?us-ascii?Q?CpmL5LYy0i8ioF6Hym3xRomU30rX3wa4FJtGh3YsHd4ql2hyP+LGx08+W43r?=
 =?us-ascii?Q?Vcza582Olo+7YcYlIKUbf+F2PacpqsGY7MZU4n+K3OGlqyiNp8HByO7L1yc3?=
 =?us-ascii?Q?Pv0r/hfe9aQiyM0dmfgQ1DW5ZY44XRjLZlh6OMc7NxxKweXbZTKdNXoSBsS5?=
 =?us-ascii?Q?hA+ywp8PBK8ZWNDprHr3I5wckiKz4i/qWt+uCKpoUk/PAR94HoNbQhYJnV1W?=
 =?us-ascii?Q?evVgT4YR8OYWPPOuTwIiTj6sPDM8qBmrf676e0eoMrNOwNe+am0uWUNyAwxl?=
 =?us-ascii?Q?qIPAlo8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 23:11:21.8715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a342540-1c53-4294-1a3c-08dce1a532e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739

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
index 98726c2b04f8..9e36e8dcc997 100644
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


