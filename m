Return-Path: <linux-kernel+bounces-357611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C12599734D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F84F1C24134
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE6E1E1047;
	Wed,  9 Oct 2024 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4CusasqO"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FD1E0481;
	Wed,  9 Oct 2024 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495649; cv=fail; b=TwgD4ma6ZjC2av/o9zckMUa9u1U4XtqRlcEmb8lh9lzplC4ZBK/nNhJAEelDVFF41Ih7KjPwtjyke2OTVrdFuDx9bxo4x7izelh3pTBk5an9eOPzDNLHcgWr8YvHMmabKrvNfJJar0YbdkjhKBr7OOO6m6hRlmPZ6SwRS1Hbz64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495649; c=relaxed/simple;
	bh=plfYM9dVyl9WOxEilD7d8swDJL9fdOF0R7wfFRiWQSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feMrFsORB7UU3cIFLPHvkNzzFT7raZSnYG8PeG/ers3dLxtMgOtaFBo0STsVDREG5XU+Nay92+O/enEz30pefBHHsGFCqCdj9ig9zzFyvjGmEPNOIf6kWqF8eGBfE10Sk+EMjWdObzt2uG+tlt1tRzzyB8tw4fUkv7Fll1HWFJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4CusasqO; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/W8DPePaMh5zFJieodbAKaxBAZI/hAjOwgpC3HqJUla88/nqGysuAGoXCU0MzMCMsXwoWfGnUQ3lxS2+D8d4XZBfdyT6BY9bAAkgt7z8r1w2tcizAvNUKJ2AYtlp487Vp13CL9GBI68nOObUhLzsCR/JUb3HJbpeWBEwJ+xav5Z9/Ncsx8IPwzYfbCN+4IWvhXVXZtpdTXnQlSFEyxXfVJFuN7pC+ddFKqNJuZL+h+2CZpDE3Tjv5vM0EU5g7LYKHj3qFMNJAfnOVCTeH7kLFm43/AO/r8qab4hH9yKGoea26AZ+DktRoiCe8EMA15HP6pI5Pry1LtmcIQ1Wd97Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5iInP2Tkkz3/7r2BzSbTyn+iu2rS++fnxHlAYMpXd0=;
 b=MtLxskY/twYWh8I/G7AkaqlnxdV/PiEcWkXIqv0pn5qVC/khP2ZSFBywEZsEo7m4iyTgZRDCx2d8AYktN+zLYG86spOb3HAQzKsq63u1dDqH5B1eVjBn461s/jebdnRtWkg389S9T6/K8LXUl0+GUO1YLJZjbk+qMDJpPdrXjmSN/VjkEKEJt6nZxGXlTWmRBrQDy7k9ZYNvKHS4MqVcm7qa/iXhnRap3En8FcdfAunusbn2sZK37LFUtPLa+O4zqwgMd1ua4SbGB0UAo3oDM957vqTJTh4hY0zPpCltwouHNSTcZScvfZC7wDAyiUys+XwPJp+X5/OpkCrgx4GhKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5iInP2Tkkz3/7r2BzSbTyn+iu2rS++fnxHlAYMpXd0=;
 b=4CusasqOjX9TZkarEPEDU/jpPLQyXPN0EZJeIe++ry8qRq2rtanfEK7ZkLZ80900h1tBTQz02L54JfvC9SsHoYaBnwOH1gq+RZoLBgSQq9LqL03+ZlLSeveaJ7r/Rx8v2DxTV0jWsuPYNxB+PxZUDVY1m1QnQFDQWqO9xnPIpm4=
Received: from SJ0PR13CA0131.namprd13.prod.outlook.com (2603:10b6:a03:2c6::16)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 17:40:38 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::d6) by SJ0PR13CA0131.outlook.office365.com
 (2603:10b6:a03:2c6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Wed, 9 Oct 2024 17:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:40:37 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:40:35 -0500
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
Subject: [PATCH v8 04/25] x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
Date: Wed, 9 Oct 2024 12:39:29 -0500
Message-ID: <797226b0c121bca6b6e6c3bf535a70aef2c4989c.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f746fd-dc13-499c-aae1-08dce8897ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OgyAgMp5oPMNwE+pHK0/114ndBITvx/hDjPwTji1mjG6usoHnd+8jpFehh/p?=
 =?us-ascii?Q?BDY37jCgltSPnNVbRxADM+UkuwRjdApat1g1btkTLCxEK2tBSbcyKxhlX9QO?=
 =?us-ascii?Q?1ZdaA8o+4h7lIf4n2XPn+aF0j7FIjL0+/vrOe0t76A4hDQx1sL1PF0Jn1vWC?=
 =?us-ascii?Q?2CDOC3xVAJO0GctT8fOFCTEwkbBqJitnCQmnYxwrDkOqMzXJIvYlkc7GayRk?=
 =?us-ascii?Q?ylxn6isp38/zsbxeDoTK3eScc9Qw/zxUT0ze0SAsc8Xhaq94b238RL9K9K+w?=
 =?us-ascii?Q?kSuEXKk9SBSKjYCcvEB4u3kI3D1dt77aAH7IpLM+8Hoq6RfzG3mvQ/C4NQFv?=
 =?us-ascii?Q?Z8co+iL4JiVQzSn5RT96xCmXniJ5jDIUt6SYHwPaFgWqutVpXZDQfYW7G6Rj?=
 =?us-ascii?Q?NXGZu6sTgsAi1PfKFYvrevkA+eCd2ukOTK1Y2zkdpHPl3CSZfoZQCeOo2qCa?=
 =?us-ascii?Q?IssBi1UrHcxzJ/3quMnWC+0CLJ/lh/9GNo51A3I3sdBFwWiRoAthTLN6G6ct?=
 =?us-ascii?Q?Nsc4yt5YRR76E3HvIsP/keDHVH2DuKIbjMFNAxybYmiT8AsFqRp1+8N0yF8m?=
 =?us-ascii?Q?HXxV3ocyPyvr8QVRnuYYnq0KLgMlyLJtUdJKFLwWtK4mCeSpZTqxBN6KKqNt?=
 =?us-ascii?Q?hUD6uMUfo3RXqmrkKemsk8NrYb9DeH9UU+zqOpuxfgBwmYFl79y1K6L4g9gB?=
 =?us-ascii?Q?TkPHiLejtL6bPv0wRUn20bTkbxATWSiYE3bQIZKCoXFqJvo9yLvLcBKrzkkH?=
 =?us-ascii?Q?h/Xycsh2pThmLl2u4viVdWn0CDqsnmW12AK5QLZzRp+QtqlkL4fHTbSJgHaW?=
 =?us-ascii?Q?UjpESHdHB7eZjL1Cgn3Se1kuy/7CQT/Z/mwScT2QLQWqwdHzMuK7e4jdrh8c?=
 =?us-ascii?Q?hyqLK9BcrKzjUmW+DEowj6yjk+YMYwL3upj/6vHJKa1p3u89x1HMS3smr5Xn?=
 =?us-ascii?Q?x+H29mQ9ONCMS0d80c7iLw45MIe/Iw51tzlr+oNnAFQBH5jQyOCnU/NIbsKh?=
 =?us-ascii?Q?AUcG83nipiFy08VES1l35zSn2h2+z7Vzektd4xe+MhEDZFSkLsfy+Mmg/G2G?=
 =?us-ascii?Q?Lj2R0LhHqsads/Rrzuaggy80l3LRc1utNu/G4MSYNP3TnlpzHCLrov2ReXb+?=
 =?us-ascii?Q?xk6drOwOT2Im6JYC8kr5/oOivyi6axzJy4+Xlj0XOSQW0Jlo8AMWUpdZXiF5?=
 =?us-ascii?Q?DOjJmYiOVfL8UjQco43wzKG3ZZNa5Q4EaYBM2s4NBipJ6sgLuS84zzCe64SR?=
 =?us-ascii?Q?GI7F91o+/8HESlFzkSfjKPSN8WrN0VrmaDRmWmWvnfCvu4vIKvgjhv30IIW2?=
 =?us-ascii?Q?HVAjsmO+c1wumWKT9uX/I67sToBBlaZc1kifkgxgmQDa2SRwCD0EQKQTPP7i?=
 =?us-ascii?Q?Vvb+m7tyTOZjhYWsZhTBh6ed4MnZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:40:37.7797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f746fd-dc13-499c-aae1-08dce8897ca8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Detect the feature and number of assignable monitoring counters supported.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Used GENMASK for the mask.

v7: Removed WARN_ON for num_mbm_cntrs. Decided to dynamically allocate the
    bitmap. WARN_ON is not required anymore.
    Removed redundant comments.

v6: Commit message update.
    Renamed abmc_capable to mbm_cntr_assignable.

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
 arch/x86/kernel/cpu/resctrl/monitor.c | 6 ++++++
 include/linux/resctrl.h               | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 795fe91a8feb..41a8b587f4f5 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1229,6 +1229,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			mbm_local_event.configurable = true;
 			mbm_config_rftype_init("mbm_local_bytes_config");
 		}
+
+		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+			r->mon.mbm_cntr_assignable = true;
+			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
+			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+		}
 	}
 
 	l3_mon_evt_init(r);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 3c2307c7c106..511cfce8fc21 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -185,10 +185,14 @@ enum resctrl_scope {
 /**
  * struct resctrl_mon - Monitoring related data of a resctrl resource
  * @num_rmid:		Number of RMIDs available
+ * @num_mbm_cntrs:	Number of assignable monitoring counters
+ * @mbm_cntr_assignable:Is system capable of supporting monitor assignment?
  * @evt_list:		List of monitoring events
  */
 struct resctrl_mon {
 	int			num_rmid;
+	int			num_mbm_cntrs;
+	bool			mbm_cntr_assignable;
 	struct list_head	evt_list;
 };
 
-- 
2.34.1


