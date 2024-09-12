Return-Path: <linux-kernel+bounces-327133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CACD297712A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959C2287762
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDA21C3F0F;
	Thu, 12 Sep 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ay8IOojq"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF01C2459
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168167; cv=fail; b=oLckgBq8j1Xxz0lteBTt5Po8loDfZG5vJUZ54eFDAvlJZGddqY93GHtrC3MgUoJFUxleNiIF3Zgt4qaEsYiWPxJACtcbTcuFOiifbgeH3Us0eDtb7HENy1KRZwCf84zI0N/zepbLd4FGhnj+jVelfW++BpxI1ZulcDoFa8U0Rb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168167; c=relaxed/simple;
	bh=iTB8lgYmOXPVJ3KF3yJZpUkHkDZgOt7sgqENlDq0pj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4B/17GQDCB4tL1jwSORIaYR4ydyOhXFPl4t7yl0/Nz7QEdOAho36fvDrvtaAv02oPm2wG5tWeHZ/7KNuG0hSZ28OYYTcO5gBmBIymJtsEHa9E4qN15xtRnji/fdNDz08jRksfYrpd48AovhwEcHjpXf9xuH4OPDcR8kCjNWodo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ay8IOojq; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXi8oyL1TITSZzhzCzfevxaiqd39m357FYLaGIC5VaPitk/+D/8nqpVFj6AGspMZy0QE66dBpWq63rbtWTRcx0flFxHbzrHiEZyDJHzJMZUyWG+j42jlUWIb73uUvirG3VDcvKSncGPpfx+Ij/6jAo7gaRcjqzBeOrmnqZHdfdWZAwL+ShvJgN7W3Ug9Uk4rUw5rh3Bzc+ZOHWhsjCG13jTmOl1vxrR5UmrhKydyNu5I5d3Vbip4rH2+tnOC736c7wlZh4t6MKJ0RgDogIDLqKv+8fewXKj3uXCICRJygR7yoDmp5+igwiNT+GbtXgpDgzXlpsroP302w/a2oYm+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikqZrigfAhH7U3X6eOBzwXvaxLBIp35op8sFYx9KK7M=;
 b=QubB5Q176ua5DPLHxUj42sI5b7F2XPZpBeyZWPZxwIO7f5hkziBqm7jAVWj9lDXjVf7NaNBO/YsbEQGi7PzFzAFpQZTjdY64BYMCQiFnABqsyOu7xuUUKfOgVQpTBDECTLlmwljOEyjlcuPMfAoZJyP4q9JufX9Tv3NwyowzWgVm311qg0zMeVqPXcqiQQ7qgNNr4431MOcdxbTyGSZ55mlZ+wcJt/5JnAfGsgqN8QiMMFNj282LIke5KqdluGwySKwp3jeM8WggviWBUPfXNBiojgzIRmQv4fMnwwowLPx1DmUxbjzoZwAmmlFB6MbOQ8crdxSTd21WUbH0+0GUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikqZrigfAhH7U3X6eOBzwXvaxLBIp35op8sFYx9KK7M=;
 b=Ay8IOojqyaYa9iGquF/4hWOuAxXQlvr9+cLC4nauXoJnGQ7la1lz8zPpuNQKhU3w4L8KEqdsBoMQvTquo474Wb9H6Y+HNpCyUB50RVUZk/BNot9A+HMGoOTZm5v0J5uwrlwHwqgXlfZ69nbdCUWoblieBkK02Yns9E71fup9Ars=
Received: from BY3PR10CA0020.namprd10.prod.outlook.com (2603:10b6:a03:255::25)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 19:09:20 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::fd) by BY3PR10CA0020.outlook.office365.com
 (2603:10b6:a03:255::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:20 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:16 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 16/34] x86/bugs: Restructure l1tf mitigation
Date: Thu, 12 Sep 2024 14:08:39 -0500
Message-ID: <20240912190857.235849-17-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: e84b4a36-5340-4ae1-7f21-08dcd35e67e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JayDx6UyiQ0/RW36FgXsz9mAylSBAsOvMtGXQ5fwF1PSLNl0STLkuxAfm+rG?=
 =?us-ascii?Q?434GinBwTXhfLEUsnJxxHnVl70MZgH4glLH3NDqS7xZQdAzYtHXg1YGtLh8H?=
 =?us-ascii?Q?jn9ny6SWxrd4/AJds7rMyMJHvm5HAKZShLLRllGBo4HfcD3vDvLn/FWOzKNR?=
 =?us-ascii?Q?iG4eOB8I5JCDahW6pWKYMP/3tznLJdfrTnS30J+uHjny3HLFq8ps+U2+wJ2M?=
 =?us-ascii?Q?w36xAwdksjhfug8/FSWJW0eL7BNeEK1jRVSiIKw6DDgQ2Z1H3eJ6oP64/1Cw?=
 =?us-ascii?Q?RQQFj+2MYDqwVd4AVWfNxNUd7Wvfkc2WHCHR3wLhrr8wgwPsB6Q6+B9jT1cZ?=
 =?us-ascii?Q?+a41fDnrfOOR7ce4fWZN59VrY8VhKn2bZyIOdBm+ml87oYSWg+M7tuTTelbs?=
 =?us-ascii?Q?0tbFJxjUI4hguJmnwOTaECRTPsVTD0Uw+jB8ExyoGucz363dQjfy473qqBz0?=
 =?us-ascii?Q?5Azs5IczLjfFVCvbaDUjQA3Exfkmd3thxzx81DqvbpQOzNp/ol2Y4vy8BcDN?=
 =?us-ascii?Q?hEt6RoOgGlhodrcvT7gDsvMO262lArx7R8v70TXLHe+lXB4pxjueGW/j9TNz?=
 =?us-ascii?Q?5BxDOSTpD0ddI2OLi07DhisqHp1Bt1kDxg++idzUbzL/v+vhQL1ONWpEFVW5?=
 =?us-ascii?Q?boA8oEv3yLwaJJJfOtkPpKLGuA8ea2lalpnHc2Yax3Dz4q6RRXKXsZ/Ol+xg?=
 =?us-ascii?Q?MGw+mhfXK/q77oGar2L0xut8Iywsm5y5OYym5lDuufRknHUI0dsQ2XxlRJPG?=
 =?us-ascii?Q?L8ErkgpJ3lmMlrsPtmwhJUql+UbmANIGA/UUNgzkGCQJTOKO2ZZwb68NK5+L?=
 =?us-ascii?Q?PAspM0DcV6qJuK0jOcY5MrLHP+wKZ47QBmAIPKiHCX7DGuE4c9gnvOYU0aan?=
 =?us-ascii?Q?W+TyrLGr0kfI9LPJX0LdRAI7yhZ3WECsZxU00ikeb25W5de0wLybboLHd3X4?=
 =?us-ascii?Q?qqrc68fr4FlohWy8rR6WmAc1KLhEnf3heKmyvogh27vBBWSi4wM6FplTdcx1?=
 =?us-ascii?Q?39BW4aSO+iH376PmEKxbAqoDouA2J5/CWay9vG9DMFzpHUrYgUnNWdDmL21b?=
 =?us-ascii?Q?ib/L5RHqz3q+cLz7YkhV0ebHldYCbScbCn6kJ2UIQ1edhRE5ZRS1mIV5mh2E?=
 =?us-ascii?Q?5kqxJazE8wzIRAN00I3eEyXCgC8Yy2uxeGPqEAgSyqxGTNHDQvKWAA9dIwno?=
 =?us-ascii?Q?4ipFewl+fM1OIOklQzCW1NWIBaKmajbFnfwADVJK2huzxsnu/Ank1M9gY6eC?=
 =?us-ascii?Q?r3B0sNZnq6wUlAgoUFR5uym6pycwocGWqMrCdOr04GaDpYg0hNqriQjxGrxl?=
 =?us-ascii?Q?JbmxHaWWuh6kqPBbQeNbiZ6nclvmFvqKRaum4pkla8ReFE2A1veJP23rhIhz?=
 =?us-ascii?Q?u9bPA2xW+bvfG7TV/sD4vN3yXlgNmOYDB8TuEytt31gvVfOzeG05ss5O2GGp?=
 =?us-ascii?Q?oQgl9TOvaTq+Ga/sL6enonWdSFQxygQi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:20.1554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84b4a36-5340-4ae1-7f21-08dcd35e67e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475

Restructure l1tf to use select/apply functions to create consistent
vulnerability handling.

Define new AUTO mitigation for l1tf.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/bugs.c       | 28 ++++++++++++++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 187805f7db3f..ba4005a7c0e3 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -728,6 +728,7 @@ void store_cpu_caps(struct cpuinfo_x86 *info);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
+	L1TF_MITIGATION_AUTO,
 	L1TF_MITIGATION_FLUSH_NOWARN,
 	L1TF_MITIGATION_FLUSH,
 	L1TF_MITIGATION_FLUSH_NOSMT,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c996c1521851..ba10aa37d949 100644
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
@@ -225,6 +226,7 @@ void __init cpu_select_mitigations(void)
 	retbleed_apply_mitigation();
 	spectre_v2_user_apply_mitigation();
 	ssb_apply_mitigation();
+	l1tf_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -2502,7 +2504,7 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
 
 /* Default mitigation for L1TF-affected CPUs */
 enum l1tf_mitigations l1tf_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_FLUSH : L1TF_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_AUTO : L1TF_MITIGATION_OFF;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
@@ -2550,22 +2552,32 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 
 static void __init l1tf_select_mitigation(void)
 {
-	u64 half_pa;
-
-	if (!boot_cpu_has_bug(X86_BUG_L1TF))
+	if (!boot_cpu_has_bug(X86_BUG_L1TF) || cpu_mitigations_off()) {
+		l1tf_mitigation = L1TF_MITIGATION_OFF;
 		return;
+	}
 
-	if (cpu_mitigations_off())
-		l1tf_mitigation = L1TF_MITIGATION_OFF;
-	else if (cpu_mitigations_auto_nosmt())
-		l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
+	if (l1tf_mitigation == L1TF_MITIGATION_AUTO) {
+		if (cpu_mitigations_auto_nosmt())
+			l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
+		else
+			l1tf_mitigation = L1TF_MITIGATION_FLUSH;
+	}
+
+}
+
+static void __init l1tf_apply_mitigation(void)
+{
+	u64 half_pa;
 
 	override_cache_bits(&boot_cpu_data);
 
 	switch (l1tf_mitigation) {
 	case L1TF_MITIGATION_OFF:
+		return;
 	case L1TF_MITIGATION_FLUSH_NOWARN:
 	case L1TF_MITIGATION_FLUSH:
+	case L1TF_MITIGATION_AUTO:
 		break;
 	case L1TF_MITIGATION_FLUSH_NOSMT:
 	case L1TF_MITIGATION_FULL:
-- 
2.34.1


