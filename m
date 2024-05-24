Return-Path: <linux-kernel+bounces-188678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F638CE541
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685821C21691
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D4128815;
	Fri, 24 May 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xMFo2250"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553312839A;
	Fri, 24 May 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553510; cv=fail; b=X+IHMniDHPX1L/0k+ZHpMOPNejEfXfQ2sbNT2W9WRRRqt8qV5Woia/1gBfG+dwAa/Duyz1oCs6wycPDgDa67VmAWcK5jBtYPAbjDMPBe1hzea2D+bzZXtx+rIlytdCj/0nlvexx1GyPt75UThADn2UnBufm7QXBv5dzCTwx/J6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553510; c=relaxed/simple;
	bh=eV0jyMi9udEG5TAdmtAazeLXt4itGAfD2tuiNNH0eJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icyaCnE3RAcWVYi0vOu3okAcacAaTWiOpQAVf13fRA3U6CYEsknUIumseGOFXtUbFypFHXsnsR0RQzcemJO8pe1I7uQ/siXu5PJKYzAqo6sBZmOv2IcKsWitv8UvsZAFAxOtBUuFqBnkoHD52l30mOFOCJWsWW34wvnEu8Id6KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xMFo2250; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWhqvLhGpffILR9OIf1r3J6i+0od7CPbC7VVV8CzNeMkjrm0ngotS84evtOTETyBBSRKnt+8VyIOGsHgJ11lUZmQoHgbeICd5ILmwGEKWLRSpJeFbpAM2CE67h8mRklx3BRolPWW8dFKCGkUchfJvLXXteLddzjuQIJcjrhxRROSKb5dX28x2BBsNFRBjOi8KLoE3ERxHqWLIwD1rhtpCWW38iY6GvTWJdxrNm4LUNaPRx827QSwqKl/eS6KeEv0dQuPs0mvNMU394pLrONUXYrJIxBQudmo36eRRF0u/iNoUvUTQh65xPJ2j9wsR8F+yfjl/Z0Pf1hji/e4ZVx34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crbseFOPiDuQ9wYDl7KtQQM8nOIzvY6hQkAdOxXNxFM=;
 b=mmSeR4sMr9gSpykYKH0ZUiSvNqSPThj0rDL2ebA2ljL7lNRvWEX6IT8lDtqNJLmepm2kc/E85tlh+MIaHDncFCodRJ2fK9kujNMZkFFBLcTMvLUqU+SrqYYaVJwbaFB6RTk/c+KWxPkWTtlejyKGHKDk4TSofWv+rHi+yOlNh7Ne2grlXvBzLi1fuUgkbFWmPCUdrPJmbocX7yKFb7SoYq3INgMeps/q6EdOyLJyYJ/cRGI3Fns6DyJs3fiaxmVThMs4tpedVnYebBO4nhFOH8++wTFB5HKs+5cieVALjyJ8i/iclj5DQNE77TFn0c5GKKJsIu8GeeTktBJJlTVtKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crbseFOPiDuQ9wYDl7KtQQM8nOIzvY6hQkAdOxXNxFM=;
 b=xMFo2250MRaaDagg97kPKOCJzHG7E2uBNkFbY+AQGlCXXMV80YP55EPAdfVL+qHxJkqrTse3ndZtT58zyS/jHehrzQuDxQ0wlPXBssuort80oUMdou3MkTok1lL0I/Rhkcq6JiRNYAn5x2jHc775aEamfnpFrImg/qiVhvRmLGc=
Received: from MW4PR03CA0169.namprd03.prod.outlook.com (2603:10b6:303:8d::24)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 12:25:05 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::69) by MW4PR03CA0169.outlook.office365.com
 (2603:10b6:303:8d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Fri, 24 May 2024 12:25:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:25:04 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:25:01 -0500
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
Subject: [PATCH v4 09/19] x86/resctrl: Initialize ABMC counters bitmap
Date: Fri, 24 May 2024 07:23:28 -0500
Message-ID: <395f8ad5bba4e572cb8bcee11fa19b02cc950253.1716552602.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716552602.git.babu.moger@amd.com>
References: <cover.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: ea551f11-d361-47d0-8865-08dc7bec8ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cTdX4iV86F5OT7gPYxm1u7TABe+dltNGH1jcweylTuN7lAoM+dCpGoyYR3LN?=
 =?us-ascii?Q?QI/clM0Va9ZAVj+8k8k8foXyuu2O8Vmup2fQgcpL0YLyEkz9HsAYm9LhWLLI?=
 =?us-ascii?Q?23kJKYNx0NL7XBmysh9r94q71xvpcHFf0oluHEPL+ITe2HuxfUubLUli4W/M?=
 =?us-ascii?Q?jfMprgQvMDmiVRBlV3S6/Y5y9LeojyJTeBovVCwyxi3LZC24LUmleTNvzJQL?=
 =?us-ascii?Q?0tGM9rrr2TZLfuAoUfHEHR+dPdHcJqM8rQGNNkEjwsOAQT0kCx/ElGbD1bdF?=
 =?us-ascii?Q?TT7rt+oEKFZWMCfHRRrBUjLvynq7HCWQQzephxZ0ATCHFqqgzWe3GQgtn3jY?=
 =?us-ascii?Q?y+LUAXX54kV4yzDJddbk2vsxnkIxwbhWVIPwGYHPa2oyZTqxWmVGsDH2b7zT?=
 =?us-ascii?Q?bx3o9zCG5Zb9twjzvO7lQ1w1xzspjADLwYEqZjQga2Eqyp+9VNSZt/RFLQK/?=
 =?us-ascii?Q?tKEF0i0DmnQDWXz6XMceOOzTDoQZ0ZL3zfxCERMf+9maroZeRlJJEdZWFu06?=
 =?us-ascii?Q?IYTpOiSh22a9wNUHuj8QCDfvp9kItHGfIgJp6W7iJqIJPhRDMa4O54DwSnil?=
 =?us-ascii?Q?/ml0SDoAS6rQ9CblIqxwzjl7xn/KhjJ+FjdFBEJL16hEpZcKrzR1iCtiPj6S?=
 =?us-ascii?Q?pzKEtqYpFRiDGb2QQ+A99u13H+Hv1nNti619KiUwyVm4ZOodKmrZ+kjb2Ruj?=
 =?us-ascii?Q?dAj/TzWw0DEiMfOSQC80kz7/0ILqNytztdgWV/307tnuGpb5hb/Wok6WOgfa?=
 =?us-ascii?Q?4Xoq88npx8+ZbRrK0t1akb9S0JQWFLVpPYoRW1NBzrdITMJM/fsu85S5BV4L?=
 =?us-ascii?Q?92jYhRc1c4RCZSo1MRjOWrjLPk824f51Hlo8YIu3vLg7sCk+1q7vByJ2rdbD?=
 =?us-ascii?Q?Qr2RyoEQhBj0puD7MhEPF8yEwGP4pu3pYzsqPFjPacLPdFizjQGEnQxlE6it?=
 =?us-ascii?Q?/rBXgSRI8WwszN+XC1LAPp5qD15yv4Tnsnpawp6zlpOU/dG4o9rg0mraJhOA?=
 =?us-ascii?Q?/qtPhVP2tlZunOiKx32EAC/3XzsKAPPpsw4XEGjmFZMbHMwSkAXGFiwTQXDu?=
 =?us-ascii?Q?LT1eRfxQGU9wy9fHxsWQel3KI0VPuhwGBuitAR+KDtRGMju5X+SjYhKqYyi0?=
 =?us-ascii?Q?aPQ6p9BeTl1eYAsGJlmxNENcdnRMKkBkYQjeOG6EMAodLOS/8DYbvz+rVtmH?=
 =?us-ascii?Q?+7gAUk1LaLYW4mRNAYWmYuVqL3pnB2ISp5uF1cUJ6O/UxNFAXOxALat6XgmA?=
 =?us-ascii?Q?4WC2kNbBZSArt2wNooDimPn0XweZmu+iBun7+Lv9gzjmcP8xxBS+7qM6Rlg+?=
 =?us-ascii?Q?5dTTJsXBu80NQeA0t1fb1vbYWGAQ/iJbXJMq23R3oruXItloDXUwoObaaJe0?=
 =?us-ascii?Q?IAD65Mi1EgtWZzh2LPb0QntNCYzh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:25:04.9993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea551f11-d361-47d0-8865-08dc7bec8ad8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076

Hardware provides a set of counters when the ABMC feature is supported.
These counters are used for enabling the events in resctrl group when
the feature is supported.

Introduce num_cntrs_free_map bitmap to track available and free counters.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: Changed the name to num_cntrs where applicable.
    Used bitmap apis.
    Added more comments for the globals.

v3: Changed the bitmap name to assign_cntrs_free_map. Removed abmc
    from the name.

v2: Changed the bitmap name to assignable_counter_free_map from
    abmc_counter_free_map.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3071bbb7a15e..400ae405e10e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -186,6 +186,23 @@ bool closid_allocated(unsigned int closid)
 	return !test_bit(closid, &closid_free_map);
 }
 
+/*
+ * ABMC Counter bitmap and length for tracking available counters.
+ * ABMC feature provides set of hardware counters for enabling events.
+ * Each event takes one hardware counter. Kernel needs to keep track
+ * of number of available counters.
+ */
+static unsigned long num_cntrs_free_map;
+static u32 num_cntrs_free_map_len;
+
+static void num_cntrs_init(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
+	bitmap_fill(&num_cntrs_free_map, r->mon.num_cntrs);
+	num_cntrs_free_map_len = r->mon.num_cntrs;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -2459,6 +2476,12 @@ static int resctrl_abmc_set_all(enum resctrl_res_level l, bool enable)
 	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
 	struct rdt_domain *d;
 
+	/*
+	 * The bitmap num_cntrs_free_map needs to be reset when switching
+	 * the monitor mode.
+	 */
+	num_cntrs_init();
+
 	/*
 	 * Update QOS_CFG MSR on all the CPUs associated with the resource
 	 * Hardware counters will reset after switching the monotor mode.
-- 
2.34.1


