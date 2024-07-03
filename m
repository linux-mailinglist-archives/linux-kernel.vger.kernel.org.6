Return-Path: <linux-kernel+bounces-240253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA944926ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD19281A1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE89B19415E;
	Wed,  3 Jul 2024 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ptty/wQh"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E0194A72;
	Wed,  3 Jul 2024 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043363; cv=fail; b=qWXNPxphYiOi25J91Za9awS+OcDL6Qxdv8SydEJhMRBsapoO5XJsjI1dD7L1T0xvUTU/tpTEoVJ76/4otUcxEjfMCqNo2MetFxlWvb0CoNoxfGaWufAjRl5HZcnPqg3Uenv6IvWJLzSbB13BMxib9jKY6AOFPeQhRAvM3vnXpaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043363; c=relaxed/simple;
	bh=v2T81gf12uokqE9TtCJwDCCKgNeFIMTR08x+NJY45eI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uf8UgyEK7W5ooY15heU9hGo1IKUfsUJOuhz1b6QNi3M5WDTmBP+2u36gj4F9yq4EO3qYm3ia0qZp903P3He7cMJKUYwZWe1AYTNvqVU2ea9yV4x2j0V98eFflBXAGV/NneDMOsKrwYilgq2br272Ni+oO3eaUVF/wVX2xvUTWWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ptty/wQh; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhE4Xma25lncIfJmNna1zXaZG6YlpmKFQfJvzNRSK6WJFm1H6Lya2pjIHP/PUHvouBHk78SwsNkKgPYvFKI41w7w+s5LCw8ibYSD+aldEqXwUOw220SVxPWQ473JzZKrXGEow0VqxiQYWBeSEzZCOVB9qFyVcnCoURIPgGFLZQM4NmqGpS8mb9/o7nuGxfjK85mWGVodSd7EsFX3Xr9SNK38PUzXjJQ1+OQ7YBPdiCBd01FRpQPescPgXF/FFcw81+FxfNuWDZpru3DqIbddjhLEItSVdNLCLoOPMd08xl8+OdMmIaCXhXWpn2rLwuot7tR8tsXZqR40M9ITMxnP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3W5ZMUAY9rs8zbUUr8VDko1yjGJEUhyQBastIWdCtM=;
 b=ipqgJOslyvIbemoOpOkh0AQf34PN6JRpQLCzhueDtfd5H/bnNs8+dxXv+2ci1ZR2nOqVkx/YJzqzibcI9EKHUbXw93HTx8gZN8u/8BQL2A0AlIJ9/CuXS6Xu+NidfbO1DvMZJvUyzYAAlfVoK0x/JrgfbkKmnErHc/r/sYR0UFwX3Eaf3UGsR2xnkxRXvFeObI62IEk+4D3yCixCH8I1DyxTSKeRcQAvVA3ivthbgDY2158vIhHp1D9jAQl7fleyo5Bl0Zvu+tVWnI865PjeY5YIKGjBsUszaUR/4V6udS0bDowLz8oHDy6ojZJTwGClzUwUCpYrXJN1pPY//0shEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3W5ZMUAY9rs8zbUUr8VDko1yjGJEUhyQBastIWdCtM=;
 b=ptty/wQhmmfFpU6UbhS/TKY9xcsSoQpMJhNl6NjJpxgS6vzzWW5DtXG6P+QdktsykQPkEPgy9pPBFTfGnnsXzT//ZcifVy7AMOYM1mv4KR/mENrdVcqBMcFpAH1rHYPtoJ5U36ymBl8U7glTvXs/YOx39IcRIvwU9FJoxVpazHg=
Received: from DM6PR06CA0053.namprd06.prod.outlook.com (2603:10b6:5:54::30) by
 SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 21:49:19 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::e9) by DM6PR06CA0053.outlook.office365.com
 (2603:10b6:5:54::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 21:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:49:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:49:14 -0500
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
Subject: [PATCH v5 04/20] x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
Date: Wed, 3 Jul 2024 16:48:15 -0500
Message-ID: <ea967681e5ed7a9c27771d60ef993616e7e1292e.1720043311.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720043311.git.babu.moger@amd.com>
References: <cover.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: 3447ca83-b542-48da-a064-08dc9ba9fc5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SakYoNy7NMTavGeG+xqs+aeH2L0goqq2ygL7JnkKuB2K9VbkVeY1UUGzau1A?=
 =?us-ascii?Q?/inqX6lzVBMGIYAhK8II3HVIOwyhzFtlZvRukwrMG4CAgzMng6AP7+lfArbq?=
 =?us-ascii?Q?qwrZuXx8wyzD7fR/0Bh6XOBHmQVrqTohH1kelAJukG/2KnK8j9HgBZWkiZvF?=
 =?us-ascii?Q?C4JvS7jzxpktyJ30HoHNxICyAdiAoCecA/DPLr2PfSt2CcXzJ5aUq3epFSV5?=
 =?us-ascii?Q?QXvAGPyLAKaWFBehFC1EDgEcfU1bGGI68UwgDdc+6ANTa9FDhFgwp3uW297n?=
 =?us-ascii?Q?k3tEEAgvH2jKIrDFui+jl/nwevm8LV87L0ZJkLZByEb5iqK8DAXQuGh21guw?=
 =?us-ascii?Q?lGA6T8LbCw37cRIy6Mvy0eu6WNu+cg3NoEMOWfA5Czrnx9FwIl9g7G+nhqS6?=
 =?us-ascii?Q?fg3QQmtofeOBs1CvOdCW4Ol2u5uYPL81RtcI4/qFCEroIVUioYbMPtLVYuee?=
 =?us-ascii?Q?l9a4XCARTZX1Yc/RSJ8KeJCv9HVTOE/EopOpTGz80j6ec0e9ljtaTeTDaFaq?=
 =?us-ascii?Q?nC8AAxrNqtlbM2C6AdqoiElJV0UPoiBK7gjxTbS1yWY15srW3BrtrWMLRbTw?=
 =?us-ascii?Q?OZ0WHSvUFsogkbRXRPe3eVrLDEUsN+av2umjDqgpOoSIuIGSxpASkARJCF1x?=
 =?us-ascii?Q?tm6+H5rezkD7mRXWvq5ostScIkvbvCgJoR/7xPd+P5QjzWmGqhZiSomQVpWM?=
 =?us-ascii?Q?Tyys1kLDmQGcBm1Nq2OobHglupYlXVXuYBJt0B7vSPyu4LsTfMaGYHIhJfH6?=
 =?us-ascii?Q?+NyXB2gRaM+K16C6pcDjjkJH+fE85wR2b0PUptbrpWCqCqDRaEax6DWvdPQA?=
 =?us-ascii?Q?Z4pd+20HOGyqBV2ElZayUK3+EivDFISUreCGNPiv7S+kYfdcvQHJrZQUfoGi?=
 =?us-ascii?Q?qksgdNrTzpZu6v58j9v54URTtLoQoPGC/eccT4vQVfMQSjiyLoYxCDOG6C2r?=
 =?us-ascii?Q?aGM6knPVGmYKHDigoy/D3vPzTK2mdG8TXfk64pXJ5F+mE+NGlAXCG24sVP5G?=
 =?us-ascii?Q?d63o4wxmd3oVuiSIsuwWppoVtxRbYJjsZGVceEOBDdi2VPHVQ/rXPx0nqNN2?=
 =?us-ascii?Q?WWTCeyS7D1RVWotNoRiJk8LA1+4R4DR+yFdlRO5+Suqak8KptUyx8D/6Dymk?=
 =?us-ascii?Q?QQ6AuVZAKdGmK1ihAjPDSME6lprhD7nETS0Wkpxe8mlTZNifkn/K8NSS8swF?=
 =?us-ascii?Q?wam0akUFz1xQaIKvIrOpNxb9tOAZZAeJuv6O9VxRq8jrNzJTnVb0DMc4Rksy?=
 =?us-ascii?Q?uy+pRQZK15cE35usTGzDQj/jNq0vNZbI8rS4/lmt6FZN9bJmAESSNoWt9HJd?=
 =?us-ascii?Q?VAGWXZblNLm2/rRJi2tnYI3lQ1rYBgdwLthkdu6eL4374cMYTOZJLm8jTAIJ?=
 =?us-ascii?Q?ZyGLa//uL8zDT0t2LMCOZIDCAxAH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:49:16.4381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3447ca83-b542-48da-a064-08dc9ba9fc5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v5: Name change num_cntrs to num_mbm_cntrs.
    Moved abmc_capable to resctrl_mon.

v4: Removed resctrl_arch_has_abmc(). Added all the code inline. We dont
    need to separate this as arch code.

v3: Removed changes related to mon_features.
    Moved rdt_cpu_has to core.c and added new function resctrl_arch_has_abmc.
    Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
    rdt_resource. (James)

v2: Changed the field name to mbm_assign_capable from abmc_capable.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 12 ++++++++++++
 include/linux/resctrl.h               |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 795fe91a8feb..87d40f149ebc 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1229,6 +1229,18 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			mbm_local_event.configurable = true;
 			mbm_config_rftype_init("mbm_local_bytes_config");
 		}
+
+		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+			r->mon.abmc_capable = true;
+			/*
+			 * Query CPUID_Fn80000020_EBX_x05 for number of
+			 * ABMC counters
+			 */
+			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
+			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
+			if (WARN_ON(r->mon.num_mbm_cntrs > 64))
+				r->mon.num_mbm_cntrs = 64;
+		}
 	}
 
 	l3_mon_evt_init(r);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index e43fc5bb5a3a..62f0f002ef41 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -185,10 +185,14 @@ enum resctrl_scope {
 /**
  * struct resctrl_mon - Monitoring related data
  * @num_rmid:		Number of RMIDs available
+ * @num_mbm_cntrs:	Number of monitoring counters
+ * @abmc_capable:	Is system capable of supporting monitor assignment?
  * @evt_list:		List of monitoring events
  */
 struct resctrl_mon {
 	int			num_rmid;
+	int			num_mbm_cntrs;
+	bool			abmc_capable;
 	struct list_head	evt_list;
 };
 
-- 
2.34.1


