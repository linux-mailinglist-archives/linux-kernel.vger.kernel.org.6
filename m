Return-Path: <linux-kernel+bounces-397206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83749BD7EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657D71F25587
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A121765F;
	Tue,  5 Nov 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GGL8jvSQ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56F7217302
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843739; cv=fail; b=oDTTHnNVZF/iJwolyPen4Y5etuoUgYLNF4sryk3ndcuFz5hVrbpb9YXCJsDvyViPy3iYfYUlIvmAndXlBRJg/7xK3gnM/4OnSknf+ivLHaFJBX648sRVzGBrBJ//WzqPKSWuqPa3X3cD8jCLp1WeNcUKSGtdit5+TwPa0yUPVcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843739; c=relaxed/simple;
	bh=d2FeFQjoF9h4WmLdn5N6NMhjVplLuWPyW0LRiRL3H9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALYbae2ZzFBoO02z7xlmCefcggxLx/7+aXe4MTjoLfkdJ/uuAeyDi/KYktU9kqx47wvsaRTSFVcb+EKuKpR3NXVguxfgB021XPk/xqqVBXQiwpCWPluWhJxMZRbJ7UaTyFq7p7CgdSkqbbj9g2XofEBMi0wu1aeUROx8kLdmmro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GGL8jvSQ; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhpeqGfArUdjslaPcbe5cdWENq4WOl/BkGA1dXvWRFM3QacG6bFi0XsNWNMCf8q6K0LbryFBEGKByJpzxelMqMb5ilt7r27+PyIX2FGl54Qx8VgttBK/5AI/XBKx/usCL/QxBfnO5FYcIsRHZ8eBgyq9m603g85QCpnYISEd5jyNozQjBjVWyRaO49cZfHvrojiQoBwq+9lqvKg8da40ERKSKs3J8+F41YWvpy107SC+7FgY7/LQq5VS7jk8Swxb97kHEa7k391RiJhPbEc98G9DdXKSLiJFpLECFxXA1eOCF6VKR7UpKWatUPJOcDZRsduKqj2o84smJ1vZZkJxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uTeX9ncItRS/zxA1Qkdb/74J/+H26AfNGulNlXJiXw=;
 b=stswG6ptxDdt13IQEiazS/wYVF6YA6TvV6avxpn8i3icovi+9QiHPthGZcPVStYBsuI+5wvCuBASTgm0ptBiyyUhcHkhHgYqVtZAcC2Kw5RKS+lY0LITSahDjfhs4z1suMegD1YE00lk0D2MpEIw7yQfK3FKQcdiDouRHtuLBcUrpe0VlM6CNZjHzrIIZaQpVUnN6/7Z0rjCxZAPhu/4BzaV3Fv5Zk6TC/ew8Gc2EjJdRkqTl1qYC/2GX1ONT5gT38UDoV/GiwKGZq3Xsry3hhgBpKmf+0ZwHT6R9E3qnM5Iqr0rYvQmC/pl3Q6uhjHH79sx3GgkkXE3VImRJdY4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uTeX9ncItRS/zxA1Qkdb/74J/+H26AfNGulNlXJiXw=;
 b=GGL8jvSQbI5YVIG8UiZHmnPMnhxYEgYmE4L12QYJAOekCXQNOxS1VoKBb0gBdADQr6TISEfcpEuH+7gYuG3TzPYkllV/laGK+AzGNi5jxdaZ5oTMmXqsiEtI4djoXkVza5dHEg32sEnIpnoK8nYA1jGxsxb6xayPn3E0bMEsLQc=
Received: from MN2PR15CA0060.namprd15.prod.outlook.com (2603:10b6:208:237::29)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 5 Nov
 2024 21:55:35 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::37) by MN2PR15CA0060.outlook.office365.com
 (2603:10b6:208:237::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:34 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:31 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 20/35] x86/bugs: Define attack vectors
Date: Tue, 5 Nov 2024 15:54:40 -0600
Message-ID: <20241105215455.359471-21-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105215455.359471-1-david.kaplan@amd.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c986a0a-3ba1-456a-6255-08dcfde49378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mr3C1UsW9YqwqVfsfirjD6qiNk9Z4U6sHLl5eViTQI1WPi2ofTAsiPclsi6O?=
 =?us-ascii?Q?eY7A7uO2to9J9rlFEM5lveqTGLnC2pZxuXQc02A63bFy6X0tXX1yj8W7uu4t?=
 =?us-ascii?Q?/am4osmVhrZITthoonZZd7nbIZ3SeGU+yEfrt4N9//AxB7zBgkAaUypIOUKq?=
 =?us-ascii?Q?PNTYybhpJVsFIja/jzyAswTNmZj+O6JzhkgYv03tbOnKj1NtnGN3ylHDngxl?=
 =?us-ascii?Q?Xi+MgpOO8W3VcDaFTja03DNxx5sR8JH2JcwuZZvev07pF0dCBVGQh08F3r9C?=
 =?us-ascii?Q?IadDIIa+tlTP1dr2sUBO+5dEpi6gD4QUUygmOXJJUvAQfMkr+ygnXv/P6RtP?=
 =?us-ascii?Q?djNG+i44zhQEZvP/YFmnbaahTmjODK53smZe2pbhxKr8pRr0GFsu5DpQ0b9A?=
 =?us-ascii?Q?m6aRSWfA/KoEMAAt7rLV5F307ZV+PG3QdKMrGGlh3DrtThLKDW5wvskPt/NH?=
 =?us-ascii?Q?cy3QVPx2i2Bc5Pj9bPEwCFrfgmOfpvvaSvr1m8W0d3XplQOAO6UOp4qCNPPR?=
 =?us-ascii?Q?nxAwbQBFlERLfv4jIxu+908D+7j8Agso0k7fBWpGEzOewvmyxwAYUDqaJ7SE?=
 =?us-ascii?Q?/PUB+cUa5t/pyyHnX6n02EQWepzoiGysRRuXGp50hCVudTxMx15GKQ+IlagR?=
 =?us-ascii?Q?98gVWT318SzJ1htIGmw7lvCGlehU+Ufuw2O0S+dtRp9rp5an7iFP34WAAJL8?=
 =?us-ascii?Q?C7dMuKgzr6g7q+7ILHRc5eTT1EKYMWdYQwXuNykAFLGFpUzMVE5E36mtrYiS?=
 =?us-ascii?Q?nop4lmwaBRrr+Mcf5Hlphc/QGLuLURl9DUcQDfeOQWdUwX6C+DCqs1xeogb9?=
 =?us-ascii?Q?iXThD8Hz3nhQgxRN9r6zElx21p+U9Gt6oyLOi7L3QRKIZ4r+At31PdU5PLCa?=
 =?us-ascii?Q?MRLYKMxXMHKl0+UN8WzLr6yCGau7hx8m8fRLFnGjacm4TugpDEY1f9KmHkBa?=
 =?us-ascii?Q?pK3HlmM8wHRxoxC70lkvCEB2EjeZwL1LnEYkQ3QF4eVBMex1+2PRUgEsP3rk?=
 =?us-ascii?Q?Us+ll6zdXUajmV/Z1j+1yWQOnPXwYwG9kSpSFrC6enRfz8fvegnT60HfarbO?=
 =?us-ascii?Q?330YdIp+EK6gVttoOxhxH37uej6/WE0IeMxzxUITx9iZ/18fbQJ5Gdzdq+fA?=
 =?us-ascii?Q?mNfUitF1ZIJ3w6gLoxf4UXoSR5/vZAfRo59AakLbMH2Z+uXkoJluhRTsKs+U?=
 =?us-ascii?Q?kkgpu7xkWp8oP1IG8MBEDbHd10OQaFydawljpSLjeBJCM7ZZmvQIdrIjjdV+?=
 =?us-ascii?Q?aMePvfNcL2Wd/xW65fgwVM+0gb2+BVl+5IB2cZtY04f1tLeWjX3w2IY4rOrc?=
 =?us-ascii?Q?+ZZp2q+JgIoXhWJoULZDoEa5Ml+z0E/3yxU499vxxahGBS6wAVxPfllW19ti?=
 =?us-ascii?Q?ePRCQ8Rn2sd6meWUS+jp3CC5IIElNQ0G1bO4xOJPOD0xpHtDvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:34.7497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c986a0a-3ba1-456a-6255-08dcfde49378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672

Define 5 new attack vectors that are used for controlling CPU
speculation mitigations and associated command line options.  Each
attack vector may be enabled or disabled, which affects the CPU
mitigations enabled.

The default settings for these attack vectors are consistent with
existing kernel defaults, other than the automatic disabling of VM-based
attack vectors if KVM support is not present.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 include/linux/cpu.h | 11 +++++++++
 kernel/cpu.c        | 58 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index bdcec1732445..b25566e1fb04 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -189,6 +189,17 @@ void cpuhp_report_idle_dead(void);
 static inline void cpuhp_report_idle_dead(void) { }
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 
+enum cpu_attack_vectors {
+	CPU_MITIGATE_USER_KERNEL,
+	CPU_MITIGATE_USER_USER,
+	CPU_MITIGATE_GUEST_HOST,
+	CPU_MITIGATE_GUEST_GUEST,
+	CPU_MITIGATE_CROSS_THREAD,
+	NR_CPU_ATTACK_VECTORS,
+};
+
+bool cpu_mitigate_attack_vector(enum cpu_attack_vectors v);
+
 #ifdef CONFIG_CPU_MITIGATIONS
 extern bool cpu_mitigations_off(void);
 extern bool cpu_mitigations_auto_nosmt(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d0699e47178b..841bcffee5d3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3200,6 +3200,22 @@ enum cpu_mitigations {
 
 static enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
 
+/*
+ * All except the cross-thread attack vector are mitigated by default.
+ * Cross-thread mitigation often requires disabling SMT which is too expensive
+ * to be enabled by default.
+ *
+ * Guest-to-Host and Guest-to-Guest vectors are only needed if KVM support is
+ * present.
+ */
+static bool cpu_mitigate_attack_vectors[NR_CPU_ATTACK_VECTORS] __ro_after_init = {
+	[CPU_MITIGATE_USER_KERNEL] = true,
+	[CPU_MITIGATE_USER_USER] = true,
+	[CPU_MITIGATE_GUEST_HOST] = IS_ENABLED(CONFIG_KVM),
+	[CPU_MITIGATE_GUEST_GUEST] = IS_ENABLED(CONFIG_KVM),
+	[CPU_MITIGATE_CROSS_THREAD] = false
+};
+
 static int __init mitigations_parse_cmdline(char *arg)
 {
 	if (!strcmp(arg, "off"))
@@ -3228,11 +3244,53 @@ bool cpu_mitigations_auto_nosmt(void)
 	return cpu_mitigations == CPU_MITIGATIONS_AUTO_NOSMT;
 }
 EXPORT_SYMBOL_GPL(cpu_mitigations_auto_nosmt);
+
+#define DEFINE_ATTACK_VECTOR(opt, v) \
+static int __init v##_parse_cmdline(char *arg) \
+{ \
+	if (!strcmp(arg, "off")) \
+		cpu_mitigate_attack_vectors[v] = false; \
+	else if (!strcmp(arg, "on")) \
+		cpu_mitigate_attack_vectors[v] = true; \
+	else \
+		pr_warn("Unsupported " opt "=%s\n", arg); \
+	return 0; \
+} \
+early_param(opt, v##_parse_cmdline)
+
+bool cpu_mitigate_attack_vector(enum cpu_attack_vectors v)
+{
+	BUG_ON(v >= NR_CPU_ATTACK_VECTORS);
+	return cpu_mitigate_attack_vectors[v];
+}
+EXPORT_SYMBOL_GPL(cpu_mitigate_attack_vector);
+
 #else
 static int __init mitigations_parse_cmdline(char *arg)
 {
 	pr_crit("Kernel compiled without mitigations, ignoring 'mitigations'; system may still be vulnerable\n");
 	return 0;
 }
+
+#define DEFINE_ATTACK_VECTOR(opt, v) \
+static int __init v##_parse_cmdline(char *arg) \
+{ \
+	pr_crit("Kernel compiled without mitigations, ignoring %s; system may still be vulnerable\n", opt); \
+	return 0; \
+} \
+early_param(opt, v##_parse_cmdline)
+
+bool cpu_mitigate_attack_vector(enum cpu_attack_vectors v)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(cpu_mitigate_attack_vector);
+
 #endif
 early_param("mitigations", mitigations_parse_cmdline);
+
+DEFINE_ATTACK_VECTOR("mitigate_user_kernel", CPU_MITIGATE_USER_KERNEL);
+DEFINE_ATTACK_VECTOR("mitigate_user_user", CPU_MITIGATE_USER_USER);
+DEFINE_ATTACK_VECTOR("mitigate_guest_host", CPU_MITIGATE_GUEST_HOST);
+DEFINE_ATTACK_VECTOR("mitigate_guest_guest", CPU_MITIGATE_GUEST_GUEST);
+DEFINE_ATTACK_VECTOR("mitigate_cross_thread", CPU_MITIGATE_CROSS_THREAD);
-- 
2.34.1


