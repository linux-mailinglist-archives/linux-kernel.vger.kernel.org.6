Return-Path: <linux-kernel+bounces-223623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B05829115AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D371C1C20970
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEEE13FD86;
	Thu, 20 Jun 2024 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jVFccFx3"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ADA130ADA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922218; cv=fail; b=rKHsiyhbneoJgR89tNXS74wnq0ZlMOLDkSPFT7t+nfz2nWoMSmYScASOFcw1ia2ci3ouqN+6BJH8gMJG7YXo0TJczL7jNfZzxtzo/ks/y1Y/1wcQ7dxRq+xd0CzX9lZeacvrlsaesohKRXu/T+5qTY8kiplZ8XeqvkHXmEBpV3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922218; c=relaxed/simple;
	bh=YfGAFigLizNM5FiR8qnq0TLLj8g7gIFQCBl8Zhgbc/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aa09LIxQRwS57F1sAJSbovVgUJPSwYZE0S2xLXM21/iNdzPb/VIO11V+mMZDmTROCyC7Y0/c/9KyxjH2KIxGpx5oNqkC+Tg+71tGl45DG4MPZl+38DTUdEyFSR/hlNmckG8fCdYuOGf9lx0AFZEDPQahhjotEH10Db1uVyS6GnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jVFccFx3; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNND1V7DFpA3Tv9SsH8TUFSh+ErLNSKH4uxLC1sk0Jf88xn/1bvQVGTSMLs48xwa3127Rfu9qI9IYCr3aHIXHm9hmCaBK1+taCj/ncJhvftDwD/FeWUUZ3eGUyyP2hlcFRArFyYV5nPq12E0qtTF1ysQon8Wmu0dli2AhnxfqL0wHOYcd/N7ia15J5hJhXSLBkxDQMU2xyufFfSj6ePRvZNHNHIIbAMnGmxsdpK7pbSI2pHJ3ZYUDCvA0Xvc6fDHX2DWR5b1jkBlpbPDPbEIjqc9YijxALMLBhhYGqlQASqzvto9a3FxAmIIXLZGj3/Mwv0GSObMCUcMC4kk2FkzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTEfbIm79av/K9gpTjTpNJIKnd5ga6i1t5xv2TIjpe4=;
 b=JKKJgk/t67/9GZoOjrVi1PyhCcTwWsXB6q+JAcRVljpHGNCfudw6MBeKh1FaLH7JbnhlKyYrALQO+j9BVzwjNsRW9Q1RGuoqv8EMqbpRjpefZdQT13EQH7kOvZmgQWz81fLj0/MFcuihrJ7tDeyU18LxD+KoOWEggG5euZ+WtwTtt+MGzqvgQoi4NJncVheJqj/DMoQypHCwFK0E9f+g+RyvBN94YXu44iW5FMkzbSETmFH7rbIIbSuvZrkJuFBMeTb0Q8qmeS8SlNJz68GKykckvjCsG0mnl7eQoE2r6nyTfaNlRQkR3/dzIPlrc4hkSpAmUijzI85tl1GrlGJlxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTEfbIm79av/K9gpTjTpNJIKnd5ga6i1t5xv2TIjpe4=;
 b=jVFccFx3hSW+SS7ojQ2C7S4Lxpx3a0mBmqMRqJ9fBhkz1GwPu3nwUOMngbwAKsyhDtKhp6CWENSNilG56U8HkTj70PMbeEEp7HjvBX7hm+/eQfJ4NY5cYp1KnlwumcNTqphc+2IGEekO5Nbp8dg98WA5UR/ZQJaDGDuLbCedlBQ=
Received: from CH0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:610:11a::12)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 22:23:34 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::ac) by CH0PR03CA0355.outlook.office365.com
 (2603:10b6:610:11a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 22:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 22:23:33 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 17:23:32 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <hpa@zytor.com>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kirill.shutemov@linux.intel.com>,
	<bdas@redhat.com>, <vkuznets@redhat.com>, <dionnaglaze@google.com>,
	<anisinha@redhat.com>, <jroedel@suse.de>, <ardb@kernel.org>,
	<dyoung@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 1/3] x86/sev: Move SEV compilation units
Date: Thu, 20 Jun 2024 22:23:06 +0000
Message-ID: <f9fe7d70185083b2fa50a242225fd033becb2274.1718920799.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718920799.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1718920799.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 9728c932-069d-44e7-a687-08dc91779f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|36860700010|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YWBiLHw1wGWF5CujDCRalHRKHdUUJRKGnWYfGHBpjFQa2BVeYmfUcUV0+Mif?=
 =?us-ascii?Q?WaAO7H6IeB/3hkbN8LohNClwG12XEidPGb8z/HsKIdFvrBOwmiWUJWjeJuRY?=
 =?us-ascii?Q?KpxxcfJdu7hMZsmAJeMLmiwkwOQqdvDj5l+E0FNcX2fhpRfFfFWGVU3YshFE?=
 =?us-ascii?Q?K7Zg3uhzk2Mdj8vYdE3oAjpYSWx5PEzsesrLbK+t+OWjO7gKtr6PcDlmxtS7?=
 =?us-ascii?Q?V7Y6C1ouJSbAPEWcTrN3FCDrKG5IfYaZZXDBLz1sZB7hCF/avMhQ7UxYNOrQ?=
 =?us-ascii?Q?Eq0iZthCAF/nWAdVlfv7LAZaRn//af1GfZURtWxwJjIuKt0bj1yAo2k67kyh?=
 =?us-ascii?Q?Q6CGV/P6IPes1Kt1ODyhKyo5TFXYS/fTuZIvL/kdCHNLgTrWahDBVSFfsNQQ?=
 =?us-ascii?Q?vGuW3St0JrOZTZVUzpOObzdflW5a240VAIRyT/mHobVK2IRJDk+XtLrYOqvK?=
 =?us-ascii?Q?EMT3/176km24g4ODri9zX/DAtXksm62NVYVRC/Gvyx6CVHOV/j9330+7E+xv?=
 =?us-ascii?Q?/dM4crsfhCiNBT1uTGmPyajWxe80+z52V+HcvNChO+6GEubRoPiJh8ZQJtoN?=
 =?us-ascii?Q?hVnVgcPlYQx8/5Se0gIx3dSU9Lx/vmmTlEKRi7Eb3qNr8ZAC0xbiKnhM4yLB?=
 =?us-ascii?Q?P5vysax8tN/GvJE2rL0/+Hji/A0DcoVr1pIoCQlGCXsT8e+pwp10omQsrFHw?=
 =?us-ascii?Q?n374p5K3Hxni84xitaTpYyVON6IIDEq2Z2hwkLAQsbZdBeWCBvMDIuovJlTQ?=
 =?us-ascii?Q?/UQEG2NhJVUoNOOIcslhZxySo26PqM8D22OkxqLEq/nAAzKpozZjKcLxSJIS?=
 =?us-ascii?Q?krXI7xg5QRGTmc8mP9zzyLZv7xVNHKcu8+m8SbsV+BuZR+yHR2GXTXeNnMHR?=
 =?us-ascii?Q?yD61JaO6wzUxwzbgkr3paW75AzewYLAekPnWSD41raIOuqBgOlmVpzSLZ+cb?=
 =?us-ascii?Q?OX0/78RsFKcWugRFLL+1J6+qkHN5pfB6xS64CVt3WiNJXxqn0hSOEpNJ7zdq?=
 =?us-ascii?Q?Ly78AfVaqHnGjTV3jlNGtqhkkvIyNgVWohDmY4mlf8DJLSTqIoAkaG2ZsiiK?=
 =?us-ascii?Q?iWmTH1oe1RMm3oY8EaDRskCPhQ73wVvjTk9pdUrfc83UDr5QQQR4O3MVSdOp?=
 =?us-ascii?Q?LQ2O/tjYw9waurDzUZ5g9Bor/uBxW3UUKDWqiT2IU/ZdDh6eapA/NMDzGjQx?=
 =?us-ascii?Q?IgcVa8EtHzfg0I0XqkFHmtx6g3jwJbskHYBPUza5XgfjpVtNhHg8I1onRfPv?=
 =?us-ascii?Q?CQAwAwMkVGZ7S8ti9IaGsJaqH7/X57diSy32C2oinN9dFBgGWHGngp8WAxwg?=
 =?us-ascii?Q?gwQvDnI2tUn28twySecWfQUffpf9Hd/TCTqPXPVxVanHV1uepUIoq15A+Plj?=
 =?us-ascii?Q?wg1b6aY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(36860700010)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 22:23:33.7437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9728c932-069d-44e7-a687-08dc91779f36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246

From: "Borislav Petkov (AMD)" <bp@alien8.de>

From: "Borislav Petkov (AMD)" <bp@alien8.de>

A long time ago we said that we're going to move the coco stuff where it
belongs

  https://lore.kernel.org/all/Yg5nh1RknPRwIrb8@zn.tnic

and not keep it in arch/x86/kernel. TDX did that and SEV can't find time
to do so. So lemme do it. If people have trouble converting their
ongoing featuritis patches, ask me for a sed script.

No functional changes.

Cc: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Michael Roth <michael.roth@amd.com>
Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/boot/compressed/sev.c                      | 2 +-
 arch/x86/coco/Makefile                              | 1 +
 arch/x86/coco/sev/Makefile                          | 3 +++
 arch/x86/{kernel/sev.c => coco/sev/core.c}          | 2 +-
 arch/x86/{kernel/sev-shared.c => coco/sev/shared.c} | 0
 arch/x86/kernel/Makefile                            | 2 --
 6 files changed, 6 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/coco/sev/Makefile
 rename arch/x86/{kernel/sev.c => coco/sev/core.c} (99%)
 rename arch/x86/{kernel/sev-shared.c => coco/sev/shared.c} (100%)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 697057250faa..cd44e120fe53 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -127,7 +127,7 @@ static bool fault_in_kernel_space(unsigned long address)
 #include "../../lib/insn.c"
 
 /* Include code for early handlers */
-#include "../../kernel/sev-shared.c"
+#include "../../coco/sev/shared.c"
 
 static struct svsm_ca *svsm_get_caa(void)
 {
diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
index c816acf78b6a..eabdc7486538 100644
--- a/arch/x86/coco/Makefile
+++ b/arch/x86/coco/Makefile
@@ -6,3 +6,4 @@ CFLAGS_core.o		+= -fno-stack-protector
 obj-y += core.o
 
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx/
+obj-$(CONFIG_AMD_MEM_ENCRYPT)   += sev/
diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
new file mode 100644
index 000000000000..b89ba3fba343
--- /dev/null
+++ b/arch/x86/coco/sev/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += core.o
diff --git a/arch/x86/kernel/sev.c b/arch/x86/coco/sev/core.c
similarity index 99%
rename from arch/x86/kernel/sev.c
rename to arch/x86/coco/sev/core.c
index 726d9df505e7..082d61d85dfc 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/coco/sev/core.c
@@ -613,7 +613,7 @@ static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
 }
 
 /* Include code shared with pre-decompression boot stage */
-#include "sev-shared.c"
+#include "shared.c"
 
 static inline struct svsm_ca *svsm_get_caa(void)
 {
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/coco/sev/shared.c
similarity index 100%
rename from arch/x86/kernel/sev-shared.c
rename to arch/x86/coco/sev/shared.c
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 20a0dd51700a..b22ceb9fdf57 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -142,8 +142,6 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
-obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
-
 obj-$(CONFIG_CFI_CLANG)			+= cfi.o
 
 obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
-- 
2.34.1


