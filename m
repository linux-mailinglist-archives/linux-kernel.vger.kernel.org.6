Return-Path: <linux-kernel+bounces-327134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E19C197712B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FFA2881C7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973091C3F21;
	Thu, 12 Sep 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nms+UU5X"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362681C2DB1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168168; cv=fail; b=m2bSDPgok5nfDh+GxYuqf0xTMGW89AUHaJC4rnBDZ8QZS2bWrgtzpE2fEGdyC5jpiqNbJCpl6qat/oSOSLlI/qFPtrFzeD3Eb8ypd9oBFWRD5KnvfHyJPB9e9jiL7iQz4TKM1lMQU6Wq/yUqXqwMoxD+hWtiXXhOrC/AmkmRfiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168168; c=relaxed/simple;
	bh=n0ewX1m0DVXMIt29Ih9ptk95o4XuQQVWouoMhFlNwzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Te6xl+KFgqz2BRCbhAZhyx1bgV6wxDpvFmXZKTH3M5QJZcDKsvMZLlX4Bg9ZOQYb+R1xUbyWleAcIBgdKkLHf8zR6U5pgOsJnk5R20xNXg3W+KG/OqnbxnxqfjkWUjRwUjRe1r58waF0Y7mTJrEGAgJXljQBJoPriYnwDlqdxwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nms+UU5X; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMKgZIzhMk80MWOhtVLGJTu9bqn5xQQ8qgjUKNV4YiGkI0MAqowiHDLB9NK1cis3bzclBpex1/jukEfdOwJLS5wzN04pN1VAVWJ5zz9Co1mxyZxjQ5V6Jtw00cJlC6hhpu+iCLr662lvCKUlhtc3wiW4GFhgrSznDPLeAgImRu8gIce1TYDk0PB3ekGw1mTPI5DAt2ApoDNAMObfVS/GQ6TlRas17Z+C5UxCiil5UkqKU00Po1lgcrYRGltYYoaaL8/IS4Qw1K1mp0i4gxnJ4zb+ePoDdhd+OjiunnvZGk25TiPkrLWsTHRVky2CjSBfunKuTnifpvgpKNk+gp9Pog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poHheHxdxiwnT7zxGa+k80TxnHbojjrRI+aJ6pOCjcU=;
 b=H6RjiaWLEMurS6lhLONnOOB+ZwJ4xSwcMeXopCnlZEt4vFDHD/A/2YWIcSt+Lk20lHk3OPE8y4AQ5dJ8tveKYrvI3dTL3M8E0ld3upnYTYz3Csz18oRoKhvdEpb4+dXX27YJ3JlbHaN4NrfzzicdqTIE23RQWFqzgVljzoJrppWUj2MNtqvkVzhxewbGR3UIWC54rKAFypqc7I+OBMyyyZ/jbp5SqkcMLdWhk61osbD721DqjyK2o0HniBR8jYSR047bW1lZ1uOsgj+LxrTS0sdbt5Zi7WFVGZQ+chu1bWxyEJq19Yaa8qtORKozVQZm/aQC/6LMDJphLcgjTQX1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poHheHxdxiwnT7zxGa+k80TxnHbojjrRI+aJ6pOCjcU=;
 b=nms+UU5XGnx963s568VA5XldjbAOmManTOl0QiPY4EFAHe/jhH1RicEVAN2mTm0Nx41kzXYAQ7zw+1ZgOjT6VPJRhsb/F4Q3IDR5XDSbiOlhWMaXU1+XxAMRKfEEMXERkJc9N7gg4CqFOwCTlhMIS+gdTC/Zk9yHZNiwPnh46so=
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 19:09:21 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::c3) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:21 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:17 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 19/34] x86/bugs: Define attack vectors
Date: Thu, 12 Sep 2024 14:08:42 -0500
Message-ID: <20240912190857.235849-20-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912190857.235849-1-david.kaplan@amd.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f4f274-60eb-4d46-9394-08dcd35e68ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kXS8fk48DlgEIbZHP4+px/UEFHNZfpG0+sKIz0P2vAHyPxKGoqnVR5moVmLd?=
 =?us-ascii?Q?OwbEoqBeqThHtRruzn8HZtuwY96xtLkQZV+LzVf5G/vCgZbBAPWNivAgz14j?=
 =?us-ascii?Q?PZ4eLP+p/KQAKqzhb+zfJ2bQO455e4rRFHdl6U0sovZMzDDTVKY+HAZ7ATFk?=
 =?us-ascii?Q?WCmuP5DSF5/JZ/YqmiINvedCbAFUNSUhdNw6BgnRJxOmlLqxSVtZeIRVdj+S?=
 =?us-ascii?Q?18Ug8ZoQa0jEMXUkkRAlQXFUnHkgEgUde8/F+1nzk+4OFDyXOIvABLK5lZHJ?=
 =?us-ascii?Q?ls2jRnS1N6ckbUNQICMc7y9E1TCVgcawi4Tf3U9YvS9U+uDW0yxI6VyqtpSy?=
 =?us-ascii?Q?vspu4YUccVIiGokKNmBLIPWRrr5R4eukHAMCnehDflIl9yKYqB/uyoV7Ie53?=
 =?us-ascii?Q?tLDOE72eXRrD1fpCmGMMbbAIbaNfDxoj72Hedte5WR6kWX2ti70oF/tLrL4T?=
 =?us-ascii?Q?ivpU0smtMpkm5sQwW5zzU4jtbuCfFYUGJFeCKmeRk8fc4wpOBL4NelqUOgtU?=
 =?us-ascii?Q?2MlfMSgs8e+8q/2Gu8pX3gK6q89SkFCJAL8EyM8S46n/7dhxDwtvY09y65qm?=
 =?us-ascii?Q?ppqVPBODM1ooBgeJ1AKpwTN5xaAaG1qvZj2EaHPXN+zR2XYB5HW9/I/1OBtI?=
 =?us-ascii?Q?vLZyB7x9jnohSMT8LbC+TPBcHhD8rlzmxP/j6cYw+tdHVP1h2nEkHKhEtGdH?=
 =?us-ascii?Q?72pCDd6aPuvgR5/RVUXT1HtBn0sVhYgs4nmNYALcw+RoyC+FnmgA42UArjul?=
 =?us-ascii?Q?FqGbRP7TZ0yDavlb4yCllagdHc6PZe31iNhlJ17RG7tm6yocL3GH++8lzPTT?=
 =?us-ascii?Q?3ozCRFnD+C255ZkQLLyZyWI3V9kBbHEiWcwup1D/VEV3QcoqC8/5wnZbeYxu?=
 =?us-ascii?Q?WdbWy9dyJshLVYd+oj+mGZh2NYbm19aBg8o7Q/K90XcfR86NiQb/a1abG6rt?=
 =?us-ascii?Q?gFRzqgAr15BtsdB79qETIocdq5OLAXAStnmVtZxtrXecmhuQ+/B1wrRqJR7q?=
 =?us-ascii?Q?BmN2AKhYjMi8a5sJuInLPaei8xqPDIm5S7uafFsJlGvdR3Op7+n/cHVCyoMX?=
 =?us-ascii?Q?QVzTqIG8upNs914LOYDeYSLZWpqwKNlxNGRObSKGrpdROXqtrs+2DqfpENpF?=
 =?us-ascii?Q?kyiV05O23xK1ThURiBqDnvi5SFSI2pI11f3KiB2ku36SoPd35cFG7S/A1LK5?=
 =?us-ascii?Q?ArIUUhgZ5vd0PK7o7Oz3Q6fT7SSjtZaXV4vIaYHLBrON5avQ6nn7W9cNaDaB?=
 =?us-ascii?Q?G3aA/sdVGlJohUViJi43HwlhC9y0igsZWbgrrUmeBaVsrhtyofdgu6N6aS2K?=
 =?us-ascii?Q?kNQ1tm8KbcvoeWaJ96gXi+ztl1vosMxcqZAl/tk2m/A+pSJo1FBjZHssOVTB?=
 =?us-ascii?Q?b03RumqDn5bhXekPmEs/HoAy35e07Rax/3mGOy1QIAZGU9PSRGQaXK6u4vSU?=
 =?us-ascii?Q?xMKYCfkAegg/ne6HA1H6rmIgTbjQZCB7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:21.4666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f4f274-60eb-4d46-9394-08dcd35e68ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614

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
index d293d52a3e00..980653a55d9c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3201,6 +3201,22 @@ enum cpu_mitigations {
 
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
@@ -3229,11 +3245,53 @@ bool cpu_mitigations_auto_nosmt(void)
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


