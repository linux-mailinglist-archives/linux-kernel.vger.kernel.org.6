Return-Path: <linux-kernel+bounces-202812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA6C8FD179
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F9DB25837
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A366A54907;
	Wed,  5 Jun 2024 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AW9Rz+lu"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1722C45030
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600779; cv=fail; b=Mbhw/r/V3F5/Hp1eoxBRRGCTewnsfx1Unctx0SVPlyisdgqethAgv1bTWFSTZfvFlPuCZW7QEgG2lvLPWCx8v2fnBolFZIK9hne5/7zRm5EwNCaXiuOu3XlZ3nhShljdcSvg6qT0mie3Zk7hB0dbanO0sHYiGTG9wa0CV9kPqwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600779; c=relaxed/simple;
	bh=8XLajzlbRqEV43mPnmbBZ5Nr+6Wri2qzMju2/FR2DDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeAEIMUcdTEcXNUR5CkyDk7uSWwR7WIOS1W0Kw6q1hAdXSfO1VQ/wCElNM2aa9A2Ulm54dk3tS0xqBrbPnDK+eqR1ssvbENW+L3KuYhzm2k79nYbSIxUqzobyUUqN1vDWg3Ja3Z6OquQrQjARYfAC3/EfjDqAeRFBpuiPXd36rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AW9Rz+lu; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnBvlfAClmaciWQ3XrH8q4edC8J+PoZe8sAkllDJBSetF2D7FE6L0bTexwQ26ilvpZLPQh/1K+Rm/sgBqxqep7FJeD/ts334tWghsWTGw5DFa+t13iu5VsrPsaOiMzgjIGPbKdiPl8aVkiQC2cd9KzVXLOWm44jUVdtm7FDMKtVIV6H1YmPIbAj+vgBwAZHCYS62kzk6hk0D6EAiOQa/YslcKb+X3ViWPLfaUKSSNhHEmsQzS1NmvqHRt4bTE7ZF+wc/3R4/tmOGI7YWrtlgQ1qzNdgy6si99VAAbo4G2r+ovSnbsO9CwxXO0fvWKM0l9vLTQfwYRuDHxQ/ifKKZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0JHmcZknA8SpOGatoihFu0Hg7yqixpdeRCy1MYwWW0=;
 b=klTgzabR5cA1SApVY4r8pxvWxaekQlH3fGzgLJurWBo/0Uob8Bk1usk41Nbr+aMbZ1fmzkM2SkqoQ627NMlmRuaUoiwwY4w3rO9ZhThleTXCfWpgKMacKCG/m7NVTREpv//LAeuVn8WAm0ENLg2zI0+tkunxRs2dU/xk2/QkKBgPj5U4QAHrXQPXqX8Z3fScAx980XP5dWtbPBo0V1aIk87ejeHltORBFV5UrtDJuDvYw2ULGEIOwQmpr3vs2O2LlAW9nxdfN2hF5XPK6UIGpraDAjVuUDBOY5apNO+jMs8wWH1OkoZuWcLougVa4JjM/RmqLnhAkyY3k5sEKn146Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0JHmcZknA8SpOGatoihFu0Hg7yqixpdeRCy1MYwWW0=;
 b=AW9Rz+luK7GjtDwAUqbxx30FZTs4vfjfUXeHgVxMSOijU5dFiLkPrdCXcMU2I0KNSVuoJREAqX9NMMLisi6Fu1TfTsGwz+/h1XhVdViKGuoNop88P/kjlWnGHWJOHf+cQLRBD3WR9n8RpCf40bzalNvD4KGLm37yiu+sO+wN4ss=
Received: from CH2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:610:20::18)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 15:19:32 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::21) by CH2PR07CA0005.outlook.office365.com
 (2603:10b6:610:20::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 15:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 15:19:31 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:19:28 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v5 03/13] x86/sev: Use kernel provided SVSM Calling Areas
Date: Wed, 5 Jun 2024 10:18:46 -0500
Message-ID: <fa8021130bcc3bcf14d722a25548cb0cdf325456.1717600736.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: cd25ed99-2488-42b8-7343-08dc8572e66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2N9ScKmcLA/kMO52Iu4TWJN+UrtlfAlF5BuImwXQUYG6eQensU6GExuVzXUu?=
 =?us-ascii?Q?IEFKHABtASWdoDrHmh0qS0rZov+SB/cmwHduu05J38TD7rNOvVDRg+EAPfSG?=
 =?us-ascii?Q?I2+vziVwRP1yhX5Zns7EUQlh60xNNTMWv0ferQNXpJ43L4eHdIomwVmhRuAo?=
 =?us-ascii?Q?rFH4baj9WzrrmOICALnfQ5qwOKPOttftw9lthmZvaiM/btlGzb4KovQwLcM8?=
 =?us-ascii?Q?xSzn9A9i1wCZnbLcFjoXKM9CMzH+cKBW5WDW9ObJeRD7PZVZG2PQY+GLW5fm?=
 =?us-ascii?Q?APZUnAtvQ8yDiSzyr4eO/PQheZLjzw2ZlNxqLMHWktU/zr5zqmmeiJ1IuAvG?=
 =?us-ascii?Q?7OekNWJ2G0a5lbj9qqdEM5RFPtkocg37neWBaKmB0L/Aq2qDhNR5BwPLnBaL?=
 =?us-ascii?Q?M3HZPpCncreN4/SX2ogNz0uHKmVm2XQAQx7gxa06vuzE9yoSw85AnMrHdTgY?=
 =?us-ascii?Q?eMeDbXNUZxz5nFq1H3mK5Y8BlE4lk1Kp0ICnV62ygztdCNAaLh7Fj6hIgKtK?=
 =?us-ascii?Q?o4HXWcFAJ+3uboidEiVZ/zwprWG1GcDl9vTJVS8B+LpzJE0jEg4Lbmde0/uV?=
 =?us-ascii?Q?8+ARCU9NucpYuKldDTjCeej3G6D+vuxVYRg9XJ8hSV3PsZ1mVgC6utAKLA2n?=
 =?us-ascii?Q?TwvGodm9iS3agCAlj1nf25B701V0sV8p7WpSz4wLq5CqwqY9eFynNzYWuR9y?=
 =?us-ascii?Q?3GPY5LajMvCwAB28jaWw/R3J7KXZDJXXDRj+XL1tO8bdo9l/W+th9dvd7Nqo?=
 =?us-ascii?Q?fCwgon6/TMftLEfr7zHZWaZrDKdBMKHJOAvE4uxfWbRGnzvmx/NXj67k/z+j?=
 =?us-ascii?Q?lknANZ9T1ZQ88+nB11L5kuNVQRmljyyEUZA4cgA7jrUxkeSRAuNcErUmw2RI?=
 =?us-ascii?Q?NPh9DJwOaOgTmXMpIdJDyPf3EsIxK4e7CLNMIRl364UskQB28j6rcdvicY2d?=
 =?us-ascii?Q?jZPKOc8yjILgz+p+AKa+yBPA3nLm/5EUky/HXaUxtIifhqM7y8Wo51gKyzkp?=
 =?us-ascii?Q?J/MLNUFEEryYjJF7kyhiWxsxb/56guK4ktJ2ITPHs0mFOPVfISo5vUiLF6Jf?=
 =?us-ascii?Q?/PpY/BGme3ero4/yuhpiJuJ3aYlAhepfClEQXye7Y/is6VgCjJIAtk9m+mNx?=
 =?us-ascii?Q?dCWreuf12DNEB1mcBg7CxHiCxC79cvYyZYQ4zP02/eHGbRMlERmF4xQ2fgVR?=
 =?us-ascii?Q?yZnYsQcMQq0wztl7GcsfZGtziReV10KpcOY23STzaluXwdu/ydKVLOrmtiZ7?=
 =?us-ascii?Q?fRS902sb4TgosX6rle3NJ5m8T07eF8G39GZkg2b4Pq3aR4jC3wIOlcz5ZH60?=
 =?us-ascii?Q?TZUqWPnoxHjyZu1n7+aLSXm5lwP6TlwyTh5m5KkGvOJrqhwxwxuzlJct3D/K?=
 =?us-ascii?Q?AjlLaJGW1Lrk1PvjeEonz5c1LCHJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:19:31.6994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd25ed99-2488-42b8-7343-08dc8572e66c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749

The SVSM Calling Area (CA) is used to communicate between Linux and the
SVSM. Since the firmware supplied CA for the BSP is likely to be in
reserved memory, switch off that CA to a kernel provided CA so that access
and use of the CA is available during boot. The CA switch is done using
the SVSM core protocol SVSM_CORE_REMAP_CA call.

An SVSM call is executed by filling out the SVSM CA and setting the proper
register state as documented by the SVSM protocol. The SVSM is invoked by
by requesting the hypervisor to run VMPL0.

Once it is safe to allocate/reserve memory, allocate a CA for each CPU.
After allocating the new CAs, the BSP will switch from the boot CA to the
per-CPU CA. The CA for an AP is identified to the SVSM when creating the
VMSA in preparation for booting the AP.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev-common.h |  13 ++
 arch/x86/include/asm/sev.h        |  32 +++++
 arch/x86/include/uapi/asm/svm.h   |   1 +
 arch/x86/kernel/sev-shared.c      | 128 +++++++++++++++++-
 arch/x86/kernel/sev.c             | 217 +++++++++++++++++++++++++-----
 arch/x86/mm/mem_encrypt_amd.c     |   8 +-
 6 files changed, 360 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index d31f2ed398f0..78a4c25119da 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -98,6 +98,19 @@ enum psc_op {
 	/* GHCBData[63:32] */				\
 	(((u64)(val) & GENMASK_ULL(63, 32)) >> 32)
 
+/* GHCB Run at VMPL Request/Response */
+#define GHCB_MSR_VMPL_REQ		0x016
+#define GHCB_MSR_VMPL_REQ_LEVEL(v)			\
+	/* GHCBData[39:32] */				\
+	(((u64)(v) & GENMASK_ULL(7, 0) << 32) |		\
+	/* GHCBDdata[11:0] */				\
+	GHCB_MSR_VMPL_REQ)
+
+#define GHCB_MSR_VMPL_RESP		0x017
+#define GHCB_MSR_VMPL_RESP_VAL(v)			\
+	/* GHCBData[63:32] */				\
+	(((u64)(v) & GENMASK_ULL(63, 32)) >> 32)
+
 /* GHCB Hypervisor Feature Request/Response */
 #define GHCB_MSR_HV_FT_REQ		0x080
 #define GHCB_MSR_HV_FT_RESP		0x081
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 16d09c1a8ceb..3abc2d759db7 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -178,6 +178,36 @@ struct svsm_ca {
 	u8 svsm_buffer[PAGE_SIZE - 8];
 };
 
+#define SVSM_SUCCESS				0
+#define SVSM_ERR_INCOMPLETE			0x80000000
+#define SVSM_ERR_UNSUPPORTED_PROTOCOL		0x80000001
+#define SVSM_ERR_UNSUPPORTED_CALL		0x80000002
+#define SVSM_ERR_INVALID_ADDRESS		0x80000003
+#define SVSM_ERR_INVALID_FORMAT			0x80000004
+#define SVSM_ERR_INVALID_PARAMETER		0x80000005
+#define SVSM_ERR_INVALID_REQUEST		0x80000006
+#define SVSM_ERR_BUSY				0x80000007
+
+/*
+ * SVSM protocol structure
+ */
+struct svsm_call {
+	struct svsm_ca *caa;
+	u64 rax;
+	u64 rcx;
+	u64 rdx;
+	u64 r8;
+	u64 r9;
+	u64 rax_out;
+	u64 rcx_out;
+	u64 rdx_out;
+	u64 r8_out;
+	u64 r9_out;
+};
+
+#define SVSM_CORE_CALL(x)		((0ULL << 32) | (x))
+#define SVSM_CORE_REMAP_CA		0
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
@@ -261,6 +291,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
+void snp_remap_svsm_ca(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -290,6 +321,7 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
+static inline void snp_remap_svsm_ca(void) { }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 80e1df482337..1814b413fd57 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -115,6 +115,7 @@
 #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
+#define SVM_VMGEXIT_SNP_RUN_VMPL		0x80000018
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_TERM_REQUEST		0x8000fffe
 #define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)	\
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 739362066e00..00173deefc46 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -21,6 +21,8 @@
 #define WARN(condition, format...) (!!(condition))
 #define sev_printk(fmt, ...)
 #define sev_printk_rtl(fmt, ...)
+#undef vc_forward_exception
+#define vc_forward_exception(c)		panic("SNP: Hypervisor requested exception\n")
 #endif
 
 /*
@@ -244,6 +246,126 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
 	return ES_VMM_ERROR;
 }
 
+static int process_svsm_result_codes(struct svsm_call *call)
+{
+	switch (call->rax_out) {
+	case SVSM_SUCCESS:
+		return 0;
+	case SVSM_ERR_INCOMPLETE:
+	case SVSM_ERR_BUSY:
+		return -EAGAIN;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Issue a VMGEXIT to call the SVSM:
+ *   - Load the SVSM register state (RAX, RCX, RDX, R8 and R9)
+ *   - Set the CA call pending field to 1
+ *   - Issue VMGEXIT
+ *   - Save the SVSM return register state (RAX, RCX, RDX, R8 and R9)
+ *   - Perform atomic exchange of the CA call pending field
+ *
+ *   - See the "Secure VM Service Module for SEV-SNP Guests" specification for
+ *     details on the calling convention.
+ *     - The calling convention loosely follows the Microsoft X64 calling
+ *       convention by putting arguments in RCX, RDX, R8 and R9.
+ *     - RAX specifies the SVSM protocol/callid as input and the return code
+ *       as output.
+ */
+static __always_inline void issue_svsm_call(struct svsm_call *call, u8 *pending)
+{
+	register unsigned long rax asm("rax") = call->rax;
+	register unsigned long rcx asm("rcx") = call->rcx;
+	register unsigned long rdx asm("rdx") = call->rdx;
+	register unsigned long r8  asm("r8")  = call->r8;
+	register unsigned long r9  asm("r9")  = call->r9;
+
+	call->caa->call_pending = 1;
+
+	asm volatile("rep; vmmcall\n\t"
+		     : "+r" (rax), "+r" (rcx), "+r" (rdx), "+r" (r8), "+r" (r9)
+		     : : "memory");
+
+	*pending = xchg(&call->caa->call_pending, *pending);
+
+	call->rax_out = rax;
+	call->rcx_out = rcx;
+	call->rdx_out = rdx;
+	call->r8_out  = r8;
+	call->r9_out  = r9;
+}
+
+static int svsm_perform_msr_protocol(struct svsm_call *call)
+{
+	u8 pending = 0;
+	u64 val, resp;
+
+	/*
+	 * When using the MSR protocol, be sure to save and restore
+	 * the current MSR value.
+	 */
+	val = sev_es_rd_ghcb_msr();
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_VMPL_REQ_LEVEL(0));
+
+	issue_svsm_call(call, &pending);
+
+	resp = sev_es_rd_ghcb_msr();
+
+	sev_es_wr_ghcb_msr(val);
+
+	if (pending)
+		return -EINVAL;
+
+	if (GHCB_RESP_CODE(resp) != GHCB_MSR_VMPL_RESP)
+		return -EINVAL;
+
+	if (GHCB_MSR_VMPL_RESP_VAL(resp))
+		return -EINVAL;
+
+	return process_svsm_result_codes(call);
+}
+
+static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
+{
+	struct es_em_ctxt ctxt;
+	u8 pending = 0;
+
+	vc_ghcb_invalidate(ghcb);
+
+	/*
+	 * Fill in protocol and format specifiers. This can be called very early
+	 * in the boot, so use rip-relative references as needed.
+	 */
+	ghcb->protocol_version = RIP_REL_REF(ghcb_version);
+	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+
+	issue_svsm_call(call, &pending);
+
+	if (pending)
+		return -EINVAL;
+
+	switch (verify_exception_info(ghcb, &ctxt)) {
+	case ES_OK:
+		break;
+	case ES_EXCEPTION:
+		vc_forward_exception(&ctxt);
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
+
+	return process_svsm_result_codes(call);
+}
+
 static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  struct es_em_ctxt *ctxt,
 					  u64 exit_code, u64 exit_info_1,
@@ -1289,7 +1411,7 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
  * services needed when not running in VMPL0.
  */
-static void __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
+static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 {
 	struct snp_secrets_page *secrets_page;
 	u64 caa;
@@ -1311,7 +1433,7 @@ static void __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	 * code and the early kernel code.
 	 */
 	if (!rmpadjust((unsigned long)&RIP_REL_REF(boot_ghcb_page), RMP_PG_SIZE_4K, 1))
-		return;
+		return false;
 
 	/*
 	 * Not running at VMPL0, ensure everything has been properly supplied
@@ -1339,4 +1461,6 @@ static void __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	 */
 	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)caa;
 	RIP_REL_REF(boot_svsm_caa_pa) = caa;
+
+	return true;
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 36a117a38b10..6bab3244a3b9 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -133,16 +133,20 @@ struct ghcb_state {
 	struct ghcb *ghcb;
 };
 
+/* For early boot SVSM communication */
+static struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
+
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
+static DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
+static DEFINE_PER_CPU(u64, svsm_caa_pa);
 
 struct sev_config {
 	__u64 debug		: 1,
 
 	      /*
-	       * A flag used by __set_pages_state() that indicates when the
-	       * per-CPU GHCB has been created and registered and thus can be
-	       * used by the BSP instead of the early boot GHCB.
+	       * Indicates when the per-CPU GHCB has been created and registered
+	       * and thus can be used by the BSP instead of the early boot GHCB.
 	       *
 	       * For APs, the per-CPU GHCB is created before they are started
 	       * and registered upon startup, so this flag can be used globally
@@ -150,6 +154,15 @@ struct sev_config {
 	       */
 	      ghcbs_initialized	: 1,
 
+	      /*
+	       * Indicates when the per-CPU SVSM CA is to be used instead of the
+	       * boot SVSM CA.
+	       *
+	       * For APs, the per-CPU SVSM CA is created as part of the AP
+	       * bringup, so this flag can be used globally for the BSP and APs.
+	       */
+	      cas_initialized	: 1,
+
 	      __reserved	: 62;
 };
 
@@ -572,9 +585,47 @@ static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t si
 	return ES_EXCEPTION;
 }
 
+static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
+{
+	long error_code = ctxt->fi.error_code;
+	int trapnr = ctxt->fi.vector;
+
+	ctxt->regs->orig_ax = ctxt->fi.error_code;
+
+	switch (trapnr) {
+	case X86_TRAP_GP:
+		exc_general_protection(ctxt->regs, error_code);
+		break;
+	case X86_TRAP_UD:
+		exc_invalid_op(ctxt->regs);
+		break;
+	case X86_TRAP_PF:
+		write_cr2(ctxt->fi.cr2);
+		exc_page_fault(ctxt->regs, error_code);
+		break;
+	case X86_TRAP_AC:
+		exc_alignment_check(ctxt->regs, error_code);
+		break;
+	default:
+		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
+		BUG();
+	}
+}
+
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
+static struct svsm_ca *svsm_get_caa(void)
+{
+	/*
+	 * Use rip-relative references when called early in the boot. If
+	 * cas_initialized is set, then it is late in the boot and no need
+	 * to worry about rip-relative references.
+	 */
+	return RIP_REL_REF(sev_cfg).cas_initialized ? this_cpu_read(svsm_caa)
+						    : RIP_REL_REF(boot_svsm_caa);
+}
+
 static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
@@ -600,6 +651,44 @@ static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 	}
 }
 
+static int svsm_perform_call_protocol(struct svsm_call *call)
+{
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int ret;
+
+	/*
+	 * This can be called very early in the boot, use native functions in
+	 * order to avoid paravirt issues.
+	 */
+	flags = native_local_irq_save();
+
+	/*
+	 * Use rip-relative references when called early in the boot. If
+	 * ghcbs_initialized is set, then it is late in the boot and no need
+	 * to worry about rip-relative references in called functions.
+	 */
+	if (RIP_REL_REF(sev_cfg).ghcbs_initialized)
+		ghcb = __sev_get_ghcb(&state);
+	else if (RIP_REL_REF(boot_ghcb))
+		ghcb = RIP_REL_REF(boot_ghcb);
+	else
+		ghcb = NULL;
+
+	do {
+		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
+			   : svsm_perform_msr_protocol(call);
+	} while (ret == -EAGAIN);
+
+	if (RIP_REL_REF(sev_cfg).ghcbs_initialized)
+		__sev_put_ghcb(&state);
+
+	native_local_irq_restore(flags);
+
+	return ret;
+}
+
 void noinstr __sev_es_nmi_complete(void)
 {
 	struct ghcb_state state;
@@ -1346,6 +1435,18 @@ static void __init alloc_runtime_data(int cpu)
 		panic("Can't allocate SEV-ES runtime data");
 
 	per_cpu(runtime_data, cpu) = data;
+
+	if (snp_vmpl) {
+		struct svsm_ca *caa;
+
+		/* Allocate the SVSM CA page if an SVSM is present */
+		caa = memblock_alloc(sizeof(*caa), PAGE_SIZE);
+		if (!caa)
+			panic("Can't allocate SVSM CA page\n");
+
+		per_cpu(svsm_caa, cpu) = caa;
+		per_cpu(svsm_caa_pa, cpu) = __pa(caa);
+	}
 }
 
 static void __init init_ghcb(int cpu)
@@ -1395,6 +1496,32 @@ void __init sev_es_init_vc_handling(void)
 		init_ghcb(cpu);
 	}
 
+	/* If running under an SVSM, switch to the per-cpu CA */
+	if (snp_vmpl) {
+		struct svsm_call call = {};
+		unsigned long flags;
+		int ret;
+
+		local_irq_save(flags);
+
+		/*
+		 * SVSM_CORE_REMAP_CA call:
+		 *   RAX = 0 (Protocol=0, CallID=0)
+		 *   RCX = New CA GPA
+		 */
+		call.caa = svsm_get_caa();
+		call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
+		call.rcx = this_cpu_read(svsm_caa_pa);
+		ret = svsm_perform_call_protocol(&call);
+		if (ret)
+			panic("Can't remap the SVSM CA, ret=%d, rax_out=0x%llx\n",
+			      ret, call.rax_out);
+
+		sev_cfg.cas_initialized = true;
+
+		local_irq_restore(flags);
+	}
+
 	sev_es_setup_play_dead();
 
 	/* Secondary CPUs use the runtime #VC handler */
@@ -1819,33 +1946,6 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	return result;
 }
 
-static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
-{
-	long error_code = ctxt->fi.error_code;
-	int trapnr = ctxt->fi.vector;
-
-	ctxt->regs->orig_ax = ctxt->fi.error_code;
-
-	switch (trapnr) {
-	case X86_TRAP_GP:
-		exc_general_protection(ctxt->regs, error_code);
-		break;
-	case X86_TRAP_UD:
-		exc_invalid_op(ctxt->regs);
-		break;
-	case X86_TRAP_PF:
-		write_cr2(ctxt->fi.cr2);
-		exc_page_fault(ctxt->regs, error_code);
-		break;
-	case X86_TRAP_AC:
-		exc_alignment_check(ctxt->regs, error_code);
-		break;
-	default:
-		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
-		BUG();
-	}
-}
-
 static __always_inline bool is_vc2_stack(unsigned long sp)
 {
 	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
@@ -2095,6 +2195,47 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
+static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
+{
+	struct svsm_call call = {};
+	int ret;
+	u64 pa;
+
+	/*
+	 * Record the SVSM Calling Area address (CAA) if the guest is not
+	 * running at VMPL0. The CA will be used to communicate with the
+	 * SVSM to perform the SVSM services.
+	 */
+	if (!svsm_setup_ca(cc_info))
+		return;
+
+	/*
+	 * It is very early in the boot and the kernel is running identity
+	 * mapped but without having adjusted the pagetables to where the
+	 * kernel was loaded (physbase), so the get the CA address using
+	 * RIP-relative addressing.
+	 */
+	pa = (u64)&RIP_REL_REF(boot_svsm_ca_page);
+
+	/*
+	 * Switch over to the boot SVSM CA while the current CA is still
+	 * addressable. There is no GHCB at this point so use the MSR protocol.
+	 *
+	 * SVSM_CORE_REMAP_CA call:
+	 *   RAX = 0 (Protocol=0, CallID=0)
+	 *   RCX = New CA GPA
+	 */
+	call.caa = svsm_get_caa();
+	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
+	call.rcx = pa;
+	ret = svsm_perform_call_protocol(&call);
+	if (ret)
+		panic("Can't remap the SVSM CA, ret=%d, rax_out=0x%llx\n", ret, call.rax_out);
+
+	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)pa;
+	RIP_REL_REF(boot_svsm_caa_pa) = pa;
+}
+
 bool __head snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
@@ -2108,12 +2249,7 @@ bool __head snp_init(struct boot_params *bp)
 
 	setup_cpuid_table(cc_info);
 
-	/*
-	 * Record the SVSM Calling Area address (CAA) if the guest is not
-	 * running at VMPL0. The CA will be used to communicate with the
-	 * SVSM to perform the SVSM services.
-	 */
-	svsm_setup_ca(cc_info);
+	svsm_setup(cc_info);
 
 	/*
 	 * The CC blob will be used later to access the secrets page. Cache
@@ -2306,3 +2442,12 @@ void sev_show_status(void)
 	}
 	pr_cont("\n");
 }
+
+void __init snp_remap_svsm_ca(void)
+{
+	if (!snp_vmpl)
+		return;
+
+	/* Update the CAA to a proper kernel address */
+	boot_svsm_caa = &boot_svsm_ca_page;
+}
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 422602f6039b..6155020e4d2d 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -2,7 +2,7 @@
 /*
  * AMD Memory Encryption Support
  *
- * Copyright (C) 2016 Advanced Micro Devices, Inc.
+ * Copyright (C) 2016-2024 Advanced Micro Devices, Inc.
  *
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
@@ -510,6 +510,12 @@ void __init sme_early_init(void)
 		 */
 		x86_init.resources.dmi_setup = snp_dmi_setup;
 	}
+
+	/*
+	 * Switch the SVSM CA mapping (if active) from identity mapped to
+	 * kernel mapped.
+	 */
+	snp_remap_svsm_ca();
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
-- 
2.43.2


