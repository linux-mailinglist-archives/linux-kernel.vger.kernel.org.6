Return-Path: <linux-kernel+bounces-357616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D8A997357
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BAC284F33
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487B91E1C30;
	Wed,  9 Oct 2024 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xZfbNWdC"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55E1E1C16;
	Wed,  9 Oct 2024 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495683; cv=fail; b=emFmcxB7adLP3FTHMeBzXiY5hOV2X08n912ZE4IDGf2JilORJTswGqIJCCnxEN4adujK60y/FgdKTdN/GnHzoxW92UGy1m3KJR1sG84wiSBBXe5Uu51hJv6ZGCnLUHrjFOXehT5d+q1hPHxrDZTWMaAAnAt+SWrV7q7R/coTGn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495683; c=relaxed/simple;
	bh=IfdInPu2TsJ1NH4/IwwKahGdXqaPqTHq5X7pBsyg+oc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYqvCCX0IApTvU6U5M9QxA+yEHAVzQQXgyKhizSfARwiyv9qwdQnFGHil/EEvafusIVQBrM5O3D+P3paDFhUraiYX/5kKVBZK/9hFYtJsPPp9tV3lf8px+4zObTXb8+t87q6hjf77BjHiuQ1XDR3NWEOOZHPnU6Uab6FdQshIUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xZfbNWdC; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuEXff9wo/NUiuFe+03ydqCz6odiBi5YfmgCPuXGEKXNKzuOdiJTir3dVXmHVUoob0f0oRLuokWIwopr2VZXPQY/RN25qdvK6CA57igK8HoEazcki9AnnL5UgdzEdyevQqVgNCDMt0DHUvv0eGCNSRVUnnzHMIrQBA6hy3FcYMnIeDD8JCVIFOLap5B4bUWp2SSnSTtYK8fABgMEKNsYszS6P2kGAwghPRm7VWbx9qC58SSp+Bl/0UfGvnAGe6ypjLDWXniaosQOdzx5y8T/uXRKHLjWNtaea3fHx+Qhq7+2vHtTqcR+PdA9kcmb87Ynl7voJq+E+t3MGEINt7wQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjR4goWMOQKGd4YA+zuL0YQScjdktXzVeIDC+OGqxTY=;
 b=cYlvXV7t7SurF/O+rmldC5DKsa5E0YtiXoBmt+5I55Mt4UbbzHovoQSmWwQL43oQSg0VHWOZyQeJoI9aayDdMPGyZYGrUGZ5Js/Kd0s78NcsS10XJ94hhfMI2wkaNX1ZvvjP8u4m1jRBvCskGrJj3N8qCinIV0PEWBgVUmV1TnzZLHQfRcqxJZ1OoRTT/5iLB3np7vZUSziqLOmezuD2cLEPoYbNIeZQWVHP8eP5mUHvzRrqOi+m88/j3DpqJ0SXyEUVR+hNvqTSD7kP8G5k83AgvhLICZC38M28UhTJ/0OIBFB0u3yhXax7mimTzn0bvaO59+AuU0w/EtLBu1Kuuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjR4goWMOQKGd4YA+zuL0YQScjdktXzVeIDC+OGqxTY=;
 b=xZfbNWdCgPvBKBFexfg5VO2Y++Wnir10/oAf0E1Er0LRFoNoaXykyn1cBV4zJvl/1OsEMxW5V/DMGdygcBbrnqM//z0xtPTERsfWm9/UaHhTyOa1Bw8MVyz8vNnDY2GtA0NI3D0FQTwuCK+45b8kNX7nbdlUjSLwIZn2U3A08nI=
Received: from SJ0PR05CA0115.namprd05.prod.outlook.com (2603:10b6:a03:334::30)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:41:17 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::6) by SJ0PR05CA0115.outlook.office365.com
 (2603:10b6:a03:334::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 17:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:41:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:41:14 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
Subject: [PATCH v8 09/25] x86/resctrl: Add __init attribute to dom_data_init()
Date: Wed, 9 Oct 2024 12:39:34 -0500
Message-ID: <03077cf67cea1b3ebb00495fd40d1535db27ff8c.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c405c7-bc2e-4eb2-9385-08dce88993e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ny5eP8YIC1DXuHscIpbR1okkN8FRPwGSWmScGR7hCPCI/Cvn/EDUILNkSnoB?=
 =?us-ascii?Q?IsKlfUC6M2yLsVEej5EKXzpObVSLHM6MpCl8MN4jFXS0V3nhPBq11XFNQ3pt?=
 =?us-ascii?Q?9H3Z02crWlxg3Ics35u2WVx7wVaZKMy7Bafl4Nr1mgUETRfedTIViD43qT2c?=
 =?us-ascii?Q?ImRsN3Z4BTL38aETX1U0ievcmMxqt5Ubx3fQf265+sTLdAKs1pA1SraofnMv?=
 =?us-ascii?Q?gTxdm93+SDegbIbAbnvV55QrZPkQX9tf5fWFbeZviG358/xK37XfKMod/Iiq?=
 =?us-ascii?Q?xrkonqq2e6WqtZFcRWsUaEGIHaUqpUf6J92Qd40CqUI8Lu8kGsJpEIg6Jb4T?=
 =?us-ascii?Q?3wDcPs9JWfQcMS6pCtlDC8oPY3IOa6ZyWLJnsu6gn/StJDPVF2pF1rC0bBFE?=
 =?us-ascii?Q?0H/e1BI194staL+G01FuBC+TwuhXuvGAk22KlsFPsi+6QVM4o/7RA9X2sfNn?=
 =?us-ascii?Q?EzLa4UOVpJ8ELsWP5lbPt9A2urq4z5EBnWULDcmHgYEofJzZTdygJ7V7NQJ1?=
 =?us-ascii?Q?M7YKwjMpHuuNYuwyjKTnlm7FWoWziQbR2a/EurY5V3nu3hAOr5HZu2FUAmbH?=
 =?us-ascii?Q?S3V6sMOevGCM9bwwyt950Bnu+1SFzBa0U3LlQ9mcnXfGz2IycqlG1KgvdUt+?=
 =?us-ascii?Q?S4s4uNkqi1kbprr5eSaXXygLwj52LKq7Jm5xCib3jqVCz2Tf1d81MK5dy5c1?=
 =?us-ascii?Q?/W0/az9hjMw2JHDfz9/98NMQ/TLluHVygIcK3JvG5JnucsALAnbqNDPdmj8V?=
 =?us-ascii?Q?h+vbP+zsZqrfyWGSUcw8uBG1z8bfprN5smdx5LEKBUZ2wUGvvBZhwl+RjY3K?=
 =?us-ascii?Q?6rGftkANFTnUlmdXuEWvFIPE2klVb5pHUu0x/dEkoCY2YCbkWdkW00zVJN3v?=
 =?us-ascii?Q?WANn3HbAjxTgvST170hOIUNzc8Sp0vpIm4I/u42tUC9b6XVRX7NpwaT5yQ5D?=
 =?us-ascii?Q?BJ9gIEUzKZlwy2t4ReLXMvyLCwo8jg3jIDSLmrvF5440aXKjNv8PN0LMEPxK?=
 =?us-ascii?Q?MB6WA84qomf5yB7KnYFKj7vBLMWu2HWeVxZkekHviGcS4l2D5wwppl6VJRxE?=
 =?us-ascii?Q?ixpR1YDUamH+eRMOdLx1J2KXR3yJtScCbUdi9nmmHmT4cM8vOotKgLs6AjlY?=
 =?us-ascii?Q?qVOEWn0FUA4GXl8SfEwvEitMgwpOOqvQ17IjUs/rHMJDHFXzZwTmgv8CloY7?=
 =?us-ascii?Q?OsW0M0OZQYR3o0K27/YCEsq4UhNrQENTZZwWOf93FZJIbLswIROvWnDhPeHT?=
 =?us-ascii?Q?nxhunZIlZ+9KBKQecpCM5jvwwMSqXeUz+LX0Q6/OeoE2FfV+Y0w6Q/zizCpt?=
 =?us-ascii?Q?l5APoU2yy02kwkjtzmUVlA5e/y7PoNwSfCJdJ39h7PAC9weLK4pWj6dw4owi?=
 =?us-ascii?Q?5RwW0VItanGz7SrmnN+cIdJhmNYG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:41:16.7493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c405c7-bc2e-4eb2-9385-08dce88993e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

dom_data_init() is only called during the __init sequence.
Add __init attribute like the rest of call sequence.

While at it, pass 'struct rdt_resource' to dom_data_init() and
dom_data_exit() which will be used for mbm counter __init and__exit
call sequence.

Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()")
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: New patch.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 2 +-
 arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 49d147e2e4e5..00ad00258df2 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -1140,7 +1140,7 @@ static void __exit resctrl_exit(void)
 	rdtgroup_exit();
 
 	if (r->mon_capable)
-		rdt_put_mon_l3_config();
+		rdt_put_mon_l3_config(r);
 }
 
 __exitcall(resctrl_exit);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a45ae410274c..92eae4672312 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -633,7 +633,7 @@ void closid_free(int closid);
 int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
-void __exit rdt_put_mon_l3_config(void);
+void __exit rdt_put_mon_l3_config(struct rdt_resource *r);
 bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 7aa579a99501..66b06574f660 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -983,7 +983,7 @@ void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long delay_
 		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
 
-static int dom_data_init(struct rdt_resource *r)
+static __init int dom_data_init(struct rdt_resource *r)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	u32 num_closid = resctrl_arch_get_num_closid(r);
@@ -1044,7 +1044,7 @@ static int dom_data_init(struct rdt_resource *r)
 	return err;
 }
 
-static void __exit dom_data_exit(void)
+static void __exit dom_data_exit(struct rdt_resource *r)
 {
 	mutex_lock(&rdtgroup_mutex);
 
@@ -1247,9 +1247,9 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
 
-void __exit rdt_put_mon_l3_config(void)
+void __exit rdt_put_mon_l3_config(struct rdt_resource *r)
 {
-	dom_data_exit();
+	dom_data_exit(r);
 }
 
 void __init intel_rdt_mbm_apply_quirk(void)
-- 
2.34.1


