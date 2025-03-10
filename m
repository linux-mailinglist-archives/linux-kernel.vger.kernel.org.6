Return-Path: <linux-kernel+bounces-554693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42431A59B57
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73257167F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0029223958E;
	Mon, 10 Mar 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hg6/ZO8W"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3F238D21
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624863; cv=fail; b=Nx32yOzWFTzm95aR96GNeYXg1ZGV9XFtUP/rhJJahha15V3AtZctXa3tl4uIJ9VIIXn8ldhXvHlJd1oDJDW9CnWyDvoi3vN997sB9nY4FHFwWlxAZTiVSqmKBmHDUzo+juN8b0chaKDqV/apEJn3Y2X4xdEZ/Ujh3XMjQTYN7Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624863; c=relaxed/simple;
	bh=dUvNb1fXqp+Oo3Q6zPOs1JRGNA+ThHpQF8en9AwZIis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocE+G3U5fdVlcPhCQbyowD3FBrsQyK7jTFOKHDuldfpoHxiMz0oby/IX5lvATTgo9cyt/zLVtO714Ch7A6okcpzHqOX3MW/JbOVA7IKg3cJovTWJ9z+u7A/3nLBLKOInXNHBu1CQlz6UNUuCEk13UaV/QrA5l6F1a7e/ws1lBoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hg6/ZO8W; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPb814Wn5eQ8GPxDnSBQ4xWUPsucn8d6Sw3YGd+BYEnCifFkzahgojspVK6vFx0+DsJNvBMhFPfmmZff2TMX7fG49QS3n+zSBTuQIQDN7LyR1S/+EX58Vn6QS2XKs5dBj4+jpye4J3t+f8NFa9cWyO5P2vayz+j04V1k75zjMrJ57IeSqfZSfPuLQ8J7Xzlm5mWQk/3xnRE1345YCPjgR/jyrlU1IWwUR07CQclATnZ7Zi4pLnceJctudsAxcH5sHAPWmeEXt546U1Cq50OIZOTgSbYBlGBDDOsKTwhAlSjJ0A5rWadihQt/92YiuyrPu3en5vx4tfe4UypkLuKgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iavqTK3Z0Q5LOgGnt9tdCLPCGq8dEOs5pyi8+sX5hGE=;
 b=q9QTRgFFRiCVgi8zZLuMibupurkU/RPAZZuk4OSRqpYJhOHiLL8Z0tE7RPOJnLxYm7kKUbMbRTcn2ogA6BX0wAXDlD5wWJQKp1JIrwfto8Kne/kOTkvtaN215laqxkKweL0fcDuip1owJht1L14EBgCoLppd++dLIxMkD8TwLpbkSPSCScKn+WdCg2IT6eew9vL5yVRJ6qZ6PtQGKiCI1yorUa8pPBRONno/8wq3F10vuK5fECbS2MWGRSGJuENfMNBFAaI6QtaKbavTxSKCdn+3Je+pNbRH8cUc6l75eOZA5XeSpAYpEJ3Y92Wdw7y/qCT8xj30dyMnsgana2WdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iavqTK3Z0Q5LOgGnt9tdCLPCGq8dEOs5pyi8+sX5hGE=;
 b=Hg6/ZO8W5seJYg1hgPy8xLX9TTzxfkE5ZUr8VxdOlGbfXBUfxWlgWLJbMc28oCJnb3TcGVDo3Es2tWate8RxyFapl9yRJFfSt6K5OeDrgbdRLjBc3cEffB0tHSNjx9FkN39x95j+CNw+pfUeWdtPqbGZBznHCmMLWRz0M26eVt8=
Received: from BN9PR03CA0071.namprd03.prod.outlook.com (2603:10b6:408:fc::16)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:40:56 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::99) by BN9PR03CA0071.outlook.office365.com
 (2603:10b6:408:fc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Mon,
 10 Mar 2025 16:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:56 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:52 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 18/36] cpu: Define attack vectors
Date: Mon, 10 Mar 2025 11:40:05 -0500
Message-ID: <20250310164023.779191-19-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310164023.779191-1-david.kaplan@amd.com>
References: <20250310164023.779191-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f33e78-db02-4d57-014a-08dd5ff254d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zK0AH9qhkLI5wPEY5biMYSxK6+qT4WIrYE1K29+I+V3wGuT4setSEtYkSHHe?=
 =?us-ascii?Q?fZHlu6K8e1ND3g610I5pzZNJ60TzjvhKyw9NmAE+G2yLO3KXfwMRtD9aDvMw?=
 =?us-ascii?Q?9VGVXN3YgI6DM5LfAyKI+zvTxrKwpZIK3mlGCCAW0Zw2S11tntC5poaXZwvE?=
 =?us-ascii?Q?LjgOSE5Gi2YblRLt/akIb2/R14htclD74FHUdgU6WQradv/SF6fg2KxhYawg?=
 =?us-ascii?Q?tY4VHSaXzewPQCzMrVd9wzGnBhOPmxgDvGrJrjFXuaZOmFJ5uLK/E8ynSb5E?=
 =?us-ascii?Q?9DeggfK9bARlksAR242hOqfCf7wgztqfhJXvjt2sSnUDE/sODkH0dWQXG+fz?=
 =?us-ascii?Q?WLaQfDTkiO1gXrcfObw/bqueOij85DRcakZtgBh9agOx4PcYpQLzdYy9hZ7d?=
 =?us-ascii?Q?K74MS/Xe8iViVRJufpznIvXiA3G7pvs82Q/I6KlaKyGbpqwQTzw0mjXFPm4K?=
 =?us-ascii?Q?Y8fRC/DUcVkD9lw+VJB+LWnqph+TO/sGfLr4lj4CH0Ws9E6aklpDqOUHwo1g?=
 =?us-ascii?Q?8svheCwxiuErvAze0kCt9jbr1YSdaX1eHGk4elDBMg2UaXmiQT5jKz5Xxer1?=
 =?us-ascii?Q?aEhs/G2pooeq9snI4VMAcFb+87HWiCNoJDH7aY81e7lAAqLJ3nUaE/5wulTt?=
 =?us-ascii?Q?jETqfFNpQR25j8mTpZfK2CVR2iYWof7vm+iAuyiOXPipdY3vRtvPSPYff5gS?=
 =?us-ascii?Q?EUjtLovE0m2vnQQGgAv4mRp7uqmfICBiGSXE/iPK2FrQxskYhWIgmlupo9ia?=
 =?us-ascii?Q?v2kP11PooeMtXtBhtctIWUCU5KlxQWaziG3eJeWTgOqQfYXF+fbRoG+7HdKz?=
 =?us-ascii?Q?7cnuVNe/MGRg0LCCveHgqHIrnFMjD0VZ6goaFrypuXfu2IbdrpsXn1wSiqIt?=
 =?us-ascii?Q?OpFUJ2cjUhnnQsiZ2phnaWuJMpQzvZ/zCph1ONRwERNUj409uSs1ehnUr0Mk?=
 =?us-ascii?Q?lPSbRm+/huKmRFFN7v/kC0yoBvIQnz88lM8pv6lo4rvbIjS4T+rSi6xMMvTr?=
 =?us-ascii?Q?aKoXMtkq7MHfqdn6tM5Zzh9wm6M7lHZAteh0utXdLBBPurFaRHAeqgSfcIP1?=
 =?us-ascii?Q?XsElL6CG49hcB8Nbg6Lkrnk902mvmpukYNz4OfFeilqFaO0nCV1uQ6bNDwIP?=
 =?us-ascii?Q?EZG46r4GudZA/0So+EcZNeJ9eVIw8GKopCMxp6NyOD3uJsTBBhs6sJsnoHm1?=
 =?us-ascii?Q?PR1cUNpFYxhXxuZ7j0ombM5GqwPlq2cz6ADPZG9sKzcbucrweSFwcj92DzLg?=
 =?us-ascii?Q?Cqw7WjTEvUk0d2CBKHgY5Lep5GvRYToEXTZuDZaW3aHHXDDjxUjmhOUwE0Xw?=
 =?us-ascii?Q?FgRomcM34FeHl4tT22k4EwBSnNikKoewMkfglEzEv+497UHbb+6Ll0MRs/O3?=
 =?us-ascii?Q?mzN7PYELpwICS26nsaSXN94wFWor7pXuKXXhrmAyfdplAIvv7WFpNKIxmibl?=
 =?us-ascii?Q?Lqvgq4HST37EmqA7KfLVWn5WrUZGvT9xX5lgIixWNGm2WrqaNLTlIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:56.6111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f33e78-db02-4d57-014a-08dd5ff254d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332

Define 4 new attack vectors that are used for controlling CPU speculation
mitigations.  These may be individually disabled as part of the
mitigations= command line.  Attack vector controls are combined with global
options like 'auto' or 'auto,nosmt' like 'mitigations=auto;no_user_kernel'.

Cross-thread mitigations can either remain enabled fully, including
potentially disabling SMT ('auto,nosmt'), remain enabled except for
disabling SMT ('auto'), or entirely disabled through the new
'no_cross_thread' attack vector option.

The default settings for these attack vectors are consistent with existing
kernel defaults, other than the automatic disabling of VM-based attack
vectors if KVM support is not present.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 include/linux/cpu.h |  20 +++++++
 kernel/cpu.c        | 129 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 138 insertions(+), 11 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 6a0a8f1c7c90..476c6dfe2c03 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -190,9 +190,25 @@ void cpuhp_report_idle_dead(void);
 static inline void cpuhp_report_idle_dead(void) { }
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 
+enum cpu_attack_vectors {
+	CPU_MITIGATE_USER_KERNEL,
+	CPU_MITIGATE_USER_USER,
+	CPU_MITIGATE_GUEST_HOST,
+	CPU_MITIGATE_GUEST_GUEST,
+	NR_CPU_ATTACK_VECTORS,
+};
+
+enum smt_mitigations {
+	SMT_MITIGATIONS_OFF,
+	SMT_MITIGATIONS_AUTO,
+	SMT_MITIGATIONS_ON,
+};
+
 #ifdef CONFIG_CPU_MITIGATIONS
 extern bool cpu_mitigations_off(void);
 extern bool cpu_mitigations_auto_nosmt(void);
+extern bool cpu_mitigate_attack_vector(enum cpu_attack_vectors v);
+extern enum smt_mitigations smt_mitigations;
 #else
 static inline bool cpu_mitigations_off(void)
 {
@@ -202,6 +218,10 @@ static inline bool cpu_mitigations_auto_nosmt(void)
 {
 	return false;
 }
+static inline bool cpu_mitigate_attack_vector(enum cpu_attack_vectors v)
+{
+	return false;
+}
 #endif
 
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index ad755db29efd..fe00ab81d682 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -37,6 +37,7 @@
 #include <linux/cpuset.h>
 #include <linux/random.h>
 #include <linux/cc_platform.h>
+#include <linux/parser.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -3178,8 +3179,38 @@ void __init boot_cpu_hotplug_init(void)
 
 #ifdef CONFIG_CPU_MITIGATIONS
 /*
- * These are used for a global "mitigations=" cmdline option for toggling
- * optional CPU mitigations.
+ * All except the cross-thread attack vector are mitigated by default.
+ * Cross-thread mitigation often requires disabling SMT which is too expensive
+ * to be enabled by default.
+ *
+ * Guest-to-Host and Guest-to-Guest vectors are only needed if KVM support is
+ * present.
+ */
+static bool attack_vectors[NR_CPU_ATTACK_VECTORS] __ro_after_init = {
+	[CPU_MITIGATE_USER_KERNEL] = true,
+	[CPU_MITIGATE_USER_USER] = true,
+	[CPU_MITIGATE_GUEST_HOST] = IS_ENABLED(CONFIG_KVM),
+	[CPU_MITIGATE_GUEST_GUEST] = IS_ENABLED(CONFIG_KVM),
+};
+
+bool cpu_mitigate_attack_vector(enum cpu_attack_vectors v)
+{
+	if (v < NR_CPU_ATTACK_VECTORS)
+		return attack_vectors[v];
+
+	WARN_ON_ONCE(v >= NR_CPU_ATTACK_VECTORS);
+	return false;
+}
+
+/*
+ * There are 3 global options, 'off', 'auto', 'auto,nosmt'.
+ * These may optionally be combined with attack-vector disables after a ';'.
+ *
+ * Examples:
+ *   mitigations=auto;no_user_kernel,no_user_user,no_cross_thread
+ *   mitigations=auto,nosmt;no_guest_host,no_guest_guest
+ *
+ * mitigations=off is equivalent to disabling all attack vectors.
  */
 enum cpu_mitigations {
 	CPU_MITIGATIONS_OFF,
@@ -3187,19 +3218,95 @@ enum cpu_mitigations {
 	CPU_MITIGATIONS_AUTO_NOSMT,
 };
 
+enum {
+	NO_USER_KERNEL,
+	NO_USER_USER,
+	NO_GUEST_HOST,
+	NO_GUEST_GUEST,
+	NO_CROSS_THREAD,
+	NR_VECTOR_PARAMS,
+};
+
+enum smt_mitigations smt_mitigations __ro_after_init = SMT_MITIGATIONS_AUTO;
 static enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
 
+static const match_table_t global_mitigations = {
+	{ CPU_MITIGATIONS_AUTO_NOSMT,	"auto,nosmt"},
+	{ CPU_MITIGATIONS_AUTO,		"auto"},
+	{ CPU_MITIGATIONS_OFF,		"off"},
+};
+
+static const match_table_t vector_mitigations = {
+	{ NO_USER_KERNEL,	"no_user_kernel"},
+	{ NO_USER_USER,		"no_user_user"},
+	{ NO_GUEST_HOST,	"no_guest_host"},
+	{ NO_GUEST_GUEST,	"no_guest_guest"},
+	{ NO_CROSS_THREAD,	"no_cross_thread"},
+	{ NR_VECTOR_PARAMS,	NULL},
+};
+
+static int __init mitigations_parse_global_opt(char *arg)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(global_mitigations); i++) {
+		const char *pattern = global_mitigations[i].pattern;
+
+		if (!strncmp(arg, pattern, strlen(pattern))) {
+			cpu_mitigations = global_mitigations[i].token;
+			return strlen(pattern);
+		}
+	}
+
+	return 0;
+}
+
 static int __init mitigations_parse_cmdline(char *arg)
 {
-	if (!strcmp(arg, "off"))
-		cpu_mitigations = CPU_MITIGATIONS_OFF;
-	else if (!strcmp(arg, "auto"))
-		cpu_mitigations = CPU_MITIGATIONS_AUTO;
-	else if (!strcmp(arg, "auto,nosmt"))
-		cpu_mitigations = CPU_MITIGATIONS_AUTO_NOSMT;
-	else
-		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",
-			arg);
+	char *s, *p;
+	int len;
+
+	len = mitigations_parse_global_opt(arg);
+
+	if (cpu_mitigations_off()) {
+		memset(attack_vectors, 0, sizeof(attack_vectors));
+		smt_mitigations = SMT_MITIGATIONS_OFF;
+	} else if (cpu_mitigations_auto_nosmt())
+		smt_mitigations = SMT_MITIGATIONS_ON;
+
+	p = arg + len;
+
+	if (!*p)
+		return 0;
+
+	/* Attack vector controls may come after a ';' */
+	if (*p++ != ';' || !IS_ENABLED(CONFIG_ARCH_HAS_CPU_ATTACK_VECTORS)) {
+		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",	arg);
+		return 0;
+	}
+
+	while ((s = strsep(&p, ",")) != NULL) {
+		switch (match_token(s, vector_mitigations, NULL)) {
+		case NO_USER_KERNEL:
+			attack_vectors[CPU_MITIGATE_USER_KERNEL] = false;
+			break;
+		case NO_USER_USER:
+			attack_vectors[CPU_MITIGATE_USER_USER] = false;
+			break;
+		case NO_GUEST_HOST:
+			attack_vectors[CPU_MITIGATE_GUEST_HOST] = false;
+			break;
+		case NO_GUEST_GUEST:
+			attack_vectors[CPU_MITIGATE_GUEST_GUEST] = false;
+			break;
+		case NO_CROSS_THREAD:
+			smt_mitigations = SMT_MITIGATIONS_OFF;
+			break;
+		default:
+			pr_crit("Unsupported mitigations options %s\n",	s);
+			return 0;
+		}
+	}
 
 	return 0;
 }
-- 
2.34.1


