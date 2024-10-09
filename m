Return-Path: <linux-kernel+bounces-357637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7799739E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72EC1C24CD1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA4F1E9086;
	Wed,  9 Oct 2024 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SoGqh+Pq"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E111D3631;
	Wed,  9 Oct 2024 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495801; cv=fail; b=JOSjVKBEDZoW+vPhVOdTSXwZEGPHgBx/Ju5hXS8hXha8fDMon9pmcy42s815cijTqyiaDo1VqjrbuMk+xn9O2w1mudkeZQJn9tsZK9o7Q7L9CGUCw+2+ISqqIiSXsaqqxvLHc5xGO+JKwuB9AJm56y0NtCbzhhYxAiCMU9oPh8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495801; c=relaxed/simple;
	bh=dqrYKJVpZyDIA9xmcbhN6MVLuKNXJCvsmc6AHY9WfmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVpocf63pV3kmP5v6Oa7YjZ5Y9G12YvkHJPliyZ6lK/vRf2eSwCadZVWzofo+gGlmgoRp7e0qfBFmPDuEenuLxStM676oaEPkN+gfs75vfLI4ufTk1hHhnyo6lJjzjpy78gT1xLa6RAmTXxGRVjm1133CAjyr35DxLc2X3G/HQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SoGqh+Pq; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmJ1oWLGlM9y94kevsF1Y9jDbrt64U1rmx6LdgFj2KaLLmsaw0m7gkIdc5ScVBfDYCPJCH32BTVk4FMB33n0rk1jqJ30695DalI5WRt0k7N2yYicQ5f8C5VnBYwjwPMlO8it9yD0Pjd/HdgjNFse6wPJgQLcTZjPuzp3Y7uF8ROUQZajcTdHIZ0UYMCQTSCoV/2uMMQLJEVXgfVT9KjsDXaVtppstFa4pLTFflMDnxgwDwg04IIkqWu4fpqN0YTTvSPCS2OhofX9npq4FDTEi+5qr38/Gev/4239Tret1p14KkjMN4Ohak3vaMXxQxhtzTFkdtpJjnPfp2ow0kN9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI0vKJLGLntUZmP06OaTtEewm2vElUTYjUMt3Ujyzcc=;
 b=M/EaIzlXYvQEJqyjh0b/RvPDHsOMl2hoondw6qCJlzj8JKfsmSTGTz3DnXzS/BY3FA8vdGT6yo+xhvft3tRid91Wo3RpgyHdZy4WnLH4R/FHk+YWMD4GtJJp7Ea/lQMwzXYG7SC7QMqpYd02BEg/GG/oD+Hj8sGFHPa/ctgHGxQdazlBIZtRy/9GehpULs8YMVT6RyDLQkjnfh1uUieLSoLB5lk/Q13zrJLzOo254STqVRpNsP4L7zJdItCQD3B6YFbgNqYGHUEWqyy+MCk5oJDusC8IVhBG6LEy5ITXfqSaDcPErv90GBN0XVKP/3aPyM9rMcX9TUzT3TUtCD7HkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI0vKJLGLntUZmP06OaTtEewm2vElUTYjUMt3Ujyzcc=;
 b=SoGqh+PqVTNneFiteL5zlot6A4z4y4xLG/QVuH3Gg9Q9Plu8npF2Kz/jArPULHJZe2qgZN7CnM0vNdy7+T86fzhvNBZL8UsBdQZO0HKzSWafAjCytlllGBVbnPf+TdClToi5YzONN5yUIckiPoHolLyGqnToqsexNPYQcmt/0e4=
Received: from PH7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::26)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:43:09 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:33a:cafe::fa) by PH7P222CA0006.outlook.office365.com
 (2603:10b6:510:33a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Wed, 9 Oct 2024 17:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:43:08 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:43:05 -0500
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
Subject: [PATCH v8 23/25] x86/resctrl: Update assignments on event configuration changes
Date: Wed, 9 Oct 2024 12:39:48 -0500
Message-ID: <715b84c29f4ec849a79698ad43218d4a486422d3.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c20372-2d00-4cc2-73b5-08dce889d6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nnWt8mLh57qXcu/0mkYVRpoCmHPVZKZgmOP2YSs32FgzphAwpk8kTnKIoUeo?=
 =?us-ascii?Q?+WHkQKe4rFkafmCMJm1hR7eTn6Ut4M2XA9fTygGo9zRsSM7462rvoTssHFLn?=
 =?us-ascii?Q?JmXzAPa058BVCbtCxpNC73Ii7eNykw7tsgiGopSbp6C5YYc8eThwmd6KJNx2?=
 =?us-ascii?Q?zJTtHDZ8c4CeNMPWCRBzbbSmYdqdFNKHtWmzDHgth6SnWld3fFxNkYw7B8nf?=
 =?us-ascii?Q?focLxxBToVkch43WLl/m1Gopi55stnUUfdAB/HreBU9P3O5d9ax8jOQptugc?=
 =?us-ascii?Q?Wi/wTZ339QfsK9anIuvOrKrzoCqB+RcGOQiYTs+ZKgOUHniCCvBleu+3/dX0?=
 =?us-ascii?Q?WbhVi84fhkxKi5K/3yqFqIMNF6/SpRuiGrhnu5e08ePfOgyvHBLtroEW277x?=
 =?us-ascii?Q?ctLHlWZJr3ly3xGOKkRmWWzfhmJm+E9kNtKIMqa6rfpsM4AuhYrSgtkIP9Yd?=
 =?us-ascii?Q?Qea2ix+YRk4/9n1jY5Z08+z3veVgsC+8U/U9tV9YVwqo4isCibw5BGJe8ppr?=
 =?us-ascii?Q?7xHSVZPxQKrIqtf6rbfGOZhwdy/PF2sR1uwd+zPBh0PoVpb4NNwsYvg3LmCy?=
 =?us-ascii?Q?UFmbAx1llC8gnykvvn1AjcURHYPcz5b3Bc+eVH3elyA3bTlVbzieDYFQS6cS?=
 =?us-ascii?Q?zqQ+wwZHOBFXrJfhpTJvOoDDfmqa6jkBA0M1JK6RS1p4S0VJmqbnk63i0mSB?=
 =?us-ascii?Q?QqgBiwJJwTD4Wno1xLwkPlQybUA7bphRy5WFAEgE4RU+Ophcr0o3xDJ6kB1F?=
 =?us-ascii?Q?eC4me5Akgi+ZSVY7o6PVCI1BujHtDUJW+fj5hPp6KTJuH3pj8TsoafhzsBVk?=
 =?us-ascii?Q?KRUFVagoc6UC3JCgQI+l5qvBu2qN3VEYrpr86WJy/KoerL+Gc4dDNmSck+Oh?=
 =?us-ascii?Q?YpnoYPNSQ/Uq8ukU+3moXMM2+uXi9bdpyPgJUCQ6d5pkQo+EwpTBUSKnQ922?=
 =?us-ascii?Q?mKLTMOuiuskTC9mpJf8TjOXV3ZUpH0b4NcBvvnqiTmONLy6Zh2kIXM+plu0G?=
 =?us-ascii?Q?fT51Q5rC1saRbAfVbC3d4OAR/he+bECqaERFZLf7hpZ84ieiSd5aNcIWNohS?=
 =?us-ascii?Q?f2kWoI72s9ZkWtE3SjhJQpUmBdyUFtONreip2CbtaboMAjZsWZ5bdv0yMSeK?=
 =?us-ascii?Q?lYy9UiHejeXQwmPa7vdZHnIiLkwUJvu6baP8tuW9W6Zllh6ccEfmx8fthn9u?=
 =?us-ascii?Q?gHGtyYUO4nIxT8nPC2ogDXA2udce43D5ogMtkmtoUOax6dA5VKg4oiNl1Igo?=
 =?us-ascii?Q?oEnahAPVklIVdvCHUsVdBrCcyVyH5A7Vn0t0Z/KDj7tD2X92M7AeXxqEo16c?=
 =?us-ascii?Q?LmzXTUnk4ftIquIarUJkpxfFoIHV6PZXVb8kLGxk4qnc6xjwDBJZk5Gmv8P2?=
 =?us-ascii?Q?QO382FiqXEbgyHXOV+nrNalJBrm5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:43:08.8796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c20372-2d00-4cc2-73b5-08dce889d6bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267

Users can modify the configuration of assignable events. Whenever the
event configuration is updated, MBM assignments must be revised across
all monitor groups within the impacted domains.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Patch changed completely.
    Updated the assignment on same IPI as the event is updated.
    Could not do the way we discussed in the thread.
    https://lore.kernel.org/lkml/f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com/
    Needed to figure out event type to update the configuration.

v7: New patch to update the assignments. Missed it earlier.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f890d294e002..cf2e0ad0e4f4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1669,6 +1669,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 }
 
 struct mon_config_info {
+	struct rdt_resource *r;
 	struct rdt_mon_domain *d;
 	u32 evtid;
 	u32 mon_config;
@@ -1694,11 +1695,46 @@ u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
 	return INVALID_CONFIG_VALUE;
 }
 
+static void mbm_cntr_event_update(int cntr_id, unsigned int index, u32 val)
+{
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+	struct rdtgroup *prgrp, *crgrp;
+	int update = 0;
+
+	/* Check if the cntr_id is associated to the event type updated */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		if (prgrp->mon.cntr_id[index] == cntr_id) {
+			abmc_cfg.split.bw_src = prgrp->mon.rmid;
+			update = 1;
+			goto out_update;
+		}
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
+			if (crgrp->mon.cntr_id[index] == cntr_id) {
+				abmc_cfg.split.bw_src = crgrp->mon.rmid;
+				update = 1;
+				goto out_update;
+			}
+		}
+	}
+
+out_update:
+	if (update) {
+		abmc_cfg.split.cfg_en = 1;
+		abmc_cfg.split.cntr_en = 1;
+		abmc_cfg.split.cntr_id = cntr_id;
+		abmc_cfg.split.bw_type = val;
+		wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg.full);
+	}
+}
+
 void resctrl_arch_mon_event_config_set(void *info)
 {
 	struct mon_config_info *mon_info = info;
+	struct rdt_mon_domain *d = mon_info->d;
+	struct rdt_resource *r = mon_info->r;
 	struct rdt_hw_mon_domain *hw_dom;
 	unsigned int index;
+	int cntr_id;
 
 	index = mon_event_config_index_get(mon_info->evtid);
 	if (index == INVALID_CONFIG_INDEX)
@@ -1718,6 +1754,18 @@ void resctrl_arch_mon_event_config_set(void *info)
 		hw_dom->mbm_local_cfg =  mon_info->mon_config;
 		break;
 	}
+
+	/*
+	 * Update the assignment if the domain has the cntr_id's assigned
+	 * to event type updated.
+	 */
+	if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
+			if (test_bit(cntr_id, d->mbm_cntr_map))
+				mbm_cntr_event_update(cntr_id, index,
+						      mon_info->mon_config);
+		}
+	}
 }
 
 /**
@@ -1805,6 +1853,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	mon_info.d = d;
 	mon_info.evtid = evtid;
 	mon_info.mon_config = val;
+	mon_info.r = r;
 
 	/*
 	 * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the
-- 
2.34.1


