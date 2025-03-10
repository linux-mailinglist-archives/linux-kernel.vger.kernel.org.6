Return-Path: <linux-kernel+bounces-554690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06FA59B55
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680EA3A4756
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91218238144;
	Mon, 10 Mar 2025 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hRYhMVCw"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2D237172
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624855; cv=fail; b=jsE7wd4p3jKvFxrKJMTzH+nqebgDTRSfdo9aKei1km6In1g7bdR1zJJuA3y3GLkuTgqzi7K1LpdLMnaoNVHI9bbSlDVeJZpXZf0TiJToQcRzSV4BBWebzgbNzX5WoDZDn/PbphIs8K+EAu+GlVI8YdPFtP2nqXyW/rVrpx2HC5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624855; c=relaxed/simple;
	bh=ivUSLRGA6C/t7YbqNEPMdpHlElsxdHLCoxrXyVZAP5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0JxZi9t4FwScSWOH4Iry44zZ9jt8BZOffyElweS5We8Qs5G9oQqxqAVIFCdjF3ReXIHkLSCvcpGA7Lkm7nGSXn9ZIsOs/MX46Rt3PjHcAEYQllfYaNNrfr6Vip6N+UMLT2sbv8XTLgH4KTHtP8yiEXOPlrkT3qH8txCJ3dI/1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hRYhMVCw; arc=fail smtp.client-ip=40.107.100.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPOR/X76G9fxaUmRwCZNCs0AjwQwHXrrzacckI4xY431nQEV2r7VpJQflkY0W4qUOdNijObe9AAYNV9Ar12xYZFIo9tVVHrF873Hak1tQBLOeY2ITtEX/nXBj6ob4qmazjUy+Vhvo7r5tXvb+0KMu2EGekLKBRcLvlVT8n+gjIzS9ScrzDbT5pwHZhihGsuB7JwXFATG9duz7oT+dYVQ6DVmsLUHu+PjPZZbtetQgCueO1DTivNJYP/mSsDZHLZf3M2YP/9oKNMnpHCt/leDxURn5PgYuAjc2u0Q5484XWPT3y8hc8HG9HLSitU1aEt8+njntHacr03ZcIfhGk/P0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ihEGZgkD5kRO7O/7c1QZIwoWCGTYLZIGhDir05d4MI=;
 b=C6D0CRpDk9lv8E0gDfL8qqJNVfBZC/6knC+SIpGvWHmNzOcHMLG9FdkRHRUi0pxUK9uGzbivH7bihHRj6xKR8qg2rYbFUBFUKYyfqclFyIEdOFspEx18nAdZqOMd2cB0ukhGqZl23Hh3aA9kuWy8fJ6MoU5DSGXnUxsXdLFDfhlMXkSPTj5ha0qN9li2XWeBsJg8VGiSJFSmRlwVcybtBJ2GlH+Z47LiqV7zgzgTfk2AaXxdOMwgq9jpN4X3yDjFkNUBuf3zZcXvq0CRAR9XKkFnb4IKnp2TPXyujbMgaq6TnUxS7XKMtsU235HKtSB+c1cfSEQ/uNKKq9DNMJT+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ihEGZgkD5kRO7O/7c1QZIwoWCGTYLZIGhDir05d4MI=;
 b=hRYhMVCwmH29Y4YozJvIQHaH3xMbWpTyjTus2CCUoZWRZO5JxnHZXcE0RbXm4T+/mbmQL0bb50p5r9APeq0BDm2q2nv9rlznydeH9k87HToCKF8dPMXQcvRP7ugnBYNbbLsRz/8iSgR/gZT5Ab9Q8QRikGwOQLop2MFap53PmhI=
Received: from BL1PR13CA0082.namprd13.prod.outlook.com (2603:10b6:208:2b8::27)
 by IA0PPF12042BF6F.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Mon, 10 Mar
 2025 16:40:50 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::f8) by BL1PR13CA0082.outlook.office365.com
 (2603:10b6:208:2b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.17 via Frontend Transport; Mon,
 10 Mar 2025 16:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:50 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:48 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 15/36] x86/bugs: Restructure l1tf mitigation
Date: Mon, 10 Mar 2025 11:40:02 -0500
Message-ID: <20250310164023.779191-16-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|IA0PPF12042BF6F:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc71f47-69e0-476a-96fa-08dd5ff25114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wiCuAkqGFLM/1YvE3b846VnbcXRyGQ2i+f9XdoOE0JE/fiJuIKhJfzMYHDDi?=
 =?us-ascii?Q?7WSeV1GENZEUvE9KO4hIvKLnwKYwILAfHBeFUSHr482eNBSirndvNRCHoy9U?=
 =?us-ascii?Q?syc9lCcBwHMyN3DoXQ3H9wC9YZPVAZeukqc14igyx1kOF2y8xFPyJcRp2azG?=
 =?us-ascii?Q?p7k9Y5RsAg5xfSDufA/cXf5oW0CE451sS5dQz/cn7DZ1+rvojpsdnvBEPHBi?=
 =?us-ascii?Q?2ZgFKPE0VdqvN2jT8I9cdP+dx0H8QSEg8CICN0ehReN0DH19g31tsrkpaWhC?=
 =?us-ascii?Q?UE1sO4AHsl/vZhijBkWis3HbSmsjVVD+7LaQv4LyTUCWuWjuxdAMrl32h3DX?=
 =?us-ascii?Q?OSG2eotJ3vzR1z8mBqtW6oSwkSGGSRueueIY076agFkkvfaMGwq3gxarLt0b?=
 =?us-ascii?Q?MPfYl7XGZoWwBus5khvFtjB2KREFIXyyEeSozdB/b6y+Xwp+yW6p3pAzifOM?=
 =?us-ascii?Q?45PywVs3um+35J0vxY84CM9z7A50YIP9hqTdZW/6TkSHDvmzdl7oS3/E6wKe?=
 =?us-ascii?Q?J5Z8ffz9C8fDK1Bo9/MfzCySfNrkWDyb240e3GAcCGrI57jCFxLECucoXc3K?=
 =?us-ascii?Q?2T7ns3XgVGXWB6Y17UpoTWlMy8TFFJPJxD7IaCbFl2J194c/sYniKNncU4rj?=
 =?us-ascii?Q?LCe72wuW5ezeHqcYwO7AXpEJshngcfU0nvzh+IotXvlaEQ/WmBSYmV90feyD?=
 =?us-ascii?Q?jVG3KDaEYA4XOU60rg/d2rjvU4m3E3+MocENMQ36O4oQ4o/nY2Nd7C9KUKfp?=
 =?us-ascii?Q?9VOgGB1ZiMwsc9qoWrgFXNpi4T0Ij71njehnhF2zo4XeBXSJOj7RwEksn7GZ?=
 =?us-ascii?Q?HnjkPIdH5moGzay4U9T0IsiM8Fx9d/yHSaiqB77y89UntxYx++6b8pOyrbhc?=
 =?us-ascii?Q?iRKwxHlpV2bCGb5zQXd6fYb/6ILk1c2g4Uf4rQ5LNWjhHQtUV1150RRq6cKd?=
 =?us-ascii?Q?dhjXRSKYtdkos6AdsxHGoYb0vgUQ9ixW1iP20gI2ePsyT3i9Nx+oq6koT/KD?=
 =?us-ascii?Q?r9aOrJJ+h1dKXRV99saUpfQaX0/tdBum4ZSQG59OHhU2aXKmsPiUb1+k8cTi?=
 =?us-ascii?Q?x13PP8VX1qRMmU4y6hKwaskiZijGrDwbhN3Fe3l5O1+oRjD8ZMbNPfLyGQQ6?=
 =?us-ascii?Q?Nd6MYVd1Sj3MAGU/MeCf97IrUiA7pkHsABzymVyM767jrxQN8auePdFin4jk?=
 =?us-ascii?Q?N2uyXx8xCn2tZBv3swxebRnaLjVu2036HVTGCD9sVnzNXhwz38gddPQVlKeT?=
 =?us-ascii?Q?RVxSRK7Q8rk+UngMwe6pLnat9jGV+z9OmiwfkQFX8vyxmA7yPeyxbuwBocqP?=
 =?us-ascii?Q?L3TAt7ZHaDELY+/Uc34DCgEi3P7kk1rFhjM881zdi6SLizNKNCwTju9JHgxk?=
 =?us-ascii?Q?zMZg/WCq22D7bafyMFZK7mjzfMnJoSoMsCLVw6CRk5iHJYRZdvZb4c+WnmLQ?=
 =?us-ascii?Q?+CidMFQqZ8vzjRu5MHH4PMF7Ans3cJNaACVlyRnSq4bbr+x546vgHLkS3HdU?=
 =?us-ascii?Q?7TynGgpRQIRyxos=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:50.3037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc71f47-69e0-476a-96fa-08dd5ff25114
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF12042BF6F

Restructure l1tf to use select/apply functions to create consistent
vulnerability handling.

Define new AUTO mitigation for l1tf.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/bugs.c       | 25 +++++++++++++++++++------
 arch/x86/kvm/vmx/vmx.c           |  2 ++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5d2f7e5aff26..0973bed22172 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -734,6 +734,7 @@ void store_cpu_caps(struct cpuinfo_x86 *info);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
+	L1TF_MITIGATION_AUTO,
 	L1TF_MITIGATION_FLUSH_NOWARN,
 	L1TF_MITIGATION_FLUSH,
 	L1TF_MITIGATION_FLUSH_NOSMT,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1d77747e0f74..b9b7f5967f1e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -67,6 +67,7 @@ static void __init spectre_v2_user_apply_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init ssb_apply_mitigation(void);
 static void __init l1tf_select_mitigation(void);
+static void __init l1tf_apply_mitigation(void);
 static void __init mds_select_mitigation(void);
 static void __init mds_update_mitigation(void);
 static void __init mds_apply_mitigation(void);
@@ -234,6 +235,7 @@ void __init cpu_select_mitigations(void)
 	retbleed_apply_mitigation();
 	spectre_v2_user_apply_mitigation();
 	ssb_apply_mitigation();
+	l1tf_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -2554,7 +2556,7 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
 
 /* Default mitigation for L1TF-affected CPUs */
 enum l1tf_mitigations l1tf_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_FLUSH : L1TF_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_AUTO : L1TF_MITIGATION_OFF;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
@@ -2601,23 +2603,34 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 }
 
 static void __init l1tf_select_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_L1TF) || cpu_mitigations_off()) {
+		l1tf_mitigation = L1TF_MITIGATION_OFF;
+		return;
+	}
+
+	if (l1tf_mitigation == L1TF_MITIGATION_AUTO) {
+		if (cpu_mitigations_auto_nosmt())
+			l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
+		else
+			l1tf_mitigation = L1TF_MITIGATION_FLUSH;
+	}
+}
+
+static void __init l1tf_apply_mitigation(void)
 {
 	u64 half_pa;
 
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return;
 
-	if (cpu_mitigations_off())
-		l1tf_mitigation = L1TF_MITIGATION_OFF;
-	else if (cpu_mitigations_auto_nosmt())
-		l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
-
 	override_cache_bits(&boot_cpu_data);
 
 	switch (l1tf_mitigation) {
 	case L1TF_MITIGATION_OFF:
 	case L1TF_MITIGATION_FLUSH_NOWARN:
 	case L1TF_MITIGATION_FLUSH:
+	case L1TF_MITIGATION_AUTO:
 		break;
 	case L1TF_MITIGATION_FLUSH_NOSMT:
 	case L1TF_MITIGATION_FULL:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3dd9007ae685..bd61e88ba445 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -273,6 +273,7 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 		case L1TF_MITIGATION_OFF:
 			l1tf = VMENTER_L1D_FLUSH_NEVER;
 			break;
+		case L1TF_MITIGATION_AUTO:
 		case L1TF_MITIGATION_FLUSH_NOWARN:
 		case L1TF_MITIGATION_FLUSH:
 		case L1TF_MITIGATION_FLUSH_NOSMT:
@@ -7652,6 +7653,7 @@ int vmx_vm_init(struct kvm *kvm)
 		case L1TF_MITIGATION_FLUSH_NOWARN:
 			/* 'I explicitly don't care' is set */
 			break;
+		case L1TF_MITIGATION_AUTO:
 		case L1TF_MITIGATION_FLUSH:
 		case L1TF_MITIGATION_FLUSH_NOSMT:
 		case L1TF_MITIGATION_FULL:
-- 
2.34.1


