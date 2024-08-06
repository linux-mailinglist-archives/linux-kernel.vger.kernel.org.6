Return-Path: <linux-kernel+bounces-276999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7287949ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D173B261BD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9DA176FBD;
	Tue,  6 Aug 2024 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZFlW7P8A"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A1176FAC;
	Tue,  6 Aug 2024 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981797; cv=fail; b=LhcfAlgFfum0Qpn8SO6oa22dfJbxHtC2dt3EIi3b2D2ujX1e/SSyJk3xX4RsAGgbSA0Rfzo7iCZsh43H70GKOurIkuxHh7UcdhmZer3HuCGNuNp6rHnM/vQ2QisLw3fgsO34kuZWZt5enj3JaVJoLSCRkqrfmbNS677uze008gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981797; c=relaxed/simple;
	bh=pli7r7CTjm9BcUqKudlKus/FYyBJxyDZGWvNQQ2I0ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=suPoyOMbU0DWTVu8IkZW87GAsLL3wugrUjj85q2wD8yegPgHI1Mo9VGywyQOo2Rj0ER3ScFMnPqKEWO0lde3OUOarBE8XLXzDuki2p7EyBOhIkm2oB+GZ0s5oVb3+Fjg28u8IuB45wiHivxXNLBIAWto+Anpk/4mEITfwYaWY3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZFlW7P8A; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5KDkbQ6ueE3mNXtvHq6DWpLoHCHGa5PC0CIUGaYOA2Fh5c2EdT6WJxWx2WCInPKVTybm0CBmMv3k5xAldh7GNgNI4wA6WLWYqtv4NW31d9iSmNrv0H7u+XaVMrC/sMoDsQOLeij77mKJw1vhvlmk6aW3LizIcB8W1uzNU+qx4Z+28zqgfValpPRzOqer20ojZUEOkHvgFYSFPtmBu1FPXQ2kPE2NW/mYzoVXQecnZxn+nNMrD+J7YGtpLNakw9uZ8O+uKf0qXLkUpO6aUl8+7u5uvxH6Eqn++1Qip3iD7ldPjQEJ3kS6tRQZ8HqDtBNSvudhYvRItpWZmNnXoV4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DArFEDCS+dNE5mUsS+iZ5V7CzYdSI1OPb1mP7h/Mv7A=;
 b=KZElWQDWP1Ne4Pj6X52BYgDRH2pRAbCz/NGWzrfh5Tw0bQEWOqyd/gdQtRo5UhKP4deHRdOTgdRQujQeMQ/oq3LQPqAYawqSEC1kNo2KehTsqO4SZ4kGaZkG1+QL+2hOV4YlGKJP1BIhrqDhA4+KY0GFHSBKqDIja75NSQNoJae7Xep7UiW3A60phbHR4r/hwhmZwTDtd8IpmgcdJifO7LdIn/M8ZFEae7/7ETvaRRhD8LU+F4/nUnKbs3HBzw/5hMDeccPUux5oMfYfURTE7hdWcar2wCBMrEiN01mlHvowYhj+vq2hGjwJozZuws6pjx/bIZgkgKokb8cEPHG3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DArFEDCS+dNE5mUsS+iZ5V7CzYdSI1OPb1mP7h/Mv7A=;
 b=ZFlW7P8A0h0XmPugXstHUhVXbb9XkJ1kck/YuCQfQGfGInm5koB3b5gkwt330YJP2BTNeBRXkSUw3/HnebwL+sb4mdzXsWMWkG7RJudoeeY07f/7uObI8Xah57z2NGOX/KNSiCchlWMRwxvB58IhGSA2I9ilfx8bJldiA29sJ4s=
Received: from PH8PR20CA0024.namprd20.prod.outlook.com (2603:10b6:510:23c::19)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Tue, 6 Aug
 2024 22:03:09 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::7a) by PH8PR20CA0024.outlook.office365.com
 (2603:10b6:510:23c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Tue, 6 Aug 2024 22:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:03:08 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:03:06 -0500
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
Subject: [PATCH v6 16/22] x86/resctrl: Add the interface to unassign a MBM counter
Date: Tue, 6 Aug 2024 17:00:53 -0500
Message-ID: <09da6e20b695086558d6cadefbc4830961e6e60b.1722981659.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722981659.git.babu.moger@amd.com>
References: <cover.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: bc01f782-09cf-4c32-2731-08dcb6638e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OoDFoZTeTo9xrlROcVULtZCUostGaa17KLZF8MtxjgQPZVrTC6wpW5+rbs5I?=
 =?us-ascii?Q?tRzLhp5TH1tYL5WkO4s9c11C5sU5Ue7/0Tsf3SDuiUfKcwUNkcc/OqRExxRk?=
 =?us-ascii?Q?bSYMBk1jAUDClCmzJeWITB2g9wjuELT9c6Gqq0D038hgy217xtk6LSlVxdsr?=
 =?us-ascii?Q?8Ac2DG+8RuCDD9cGDUTk2V1k8XfSzIkBgZcaWnXw4HRKnXhw5vqIL3u1otGp?=
 =?us-ascii?Q?bhleTmB/pSAPwKXce5gfhmI1IOgNE5gv95+vEIkDcoi1Bb2DJl1yIVpQ+yAv?=
 =?us-ascii?Q?pos9EJGJmpvAARwrrFbRI+xzEGHF8Bp9hVvqA5bFVOc0bBerI0mTyI6I1R9g?=
 =?us-ascii?Q?/Bcvz8gtW3r1lEjbIS7m21dUPwUPtkfGOfnWHlJiAmHU7m5PR4ZpyPFqr8Iw?=
 =?us-ascii?Q?AgtqpzsXtNbqbIhKqVMjyADQoTI6b498ILH/CV5IlAfXjw9T6nD6tD8f+dQe?=
 =?us-ascii?Q?nliJIBO7hps6g37+gt7Rf4JV/nh3thk9lLf1w4sTQijbnxrZIpchc6ZTkDuq?=
 =?us-ascii?Q?L9xInbpU8txCwFY3pJZusfnfx7hEhWNWPKz5XB0mmRdGKk7dBiTxI8tFkZCT?=
 =?us-ascii?Q?hTj3+rtUii8AQ8BiXtlY0+pE16Icx3zpQhZNTYtxG4GLrJ93qxi3lpyZ2aW6?=
 =?us-ascii?Q?OFlcG27wuayAdzCUKInKj9JfWJkrWaUBxKXJGgGH2ReR6YqrPduLVRgJ8Fm6?=
 =?us-ascii?Q?DC73i1UuBlE9CTSn+oj7T7uCyTYBiuRe2iPHmV9L16Ib1YDq40ACUe2RrRLm?=
 =?us-ascii?Q?ZEPCJOOsnr6f8nj10/axHxveOnISgSr8r8X08FUeFNQVh4YdBjDNHf52y5+t?=
 =?us-ascii?Q?N/N2jf+CVcvk3d7ouzfDC3KZRv4EmiOV8Vy1xnprIo+FPBJnV9CNovrTFVnp?=
 =?us-ascii?Q?OoRcVocahQlGVUenviu3gOCWZIVBNY8cD6VN3p6tgqxiJ37jCma6E8lcp6N8?=
 =?us-ascii?Q?GZf2fok5qL1WVM3OxHzQjXHLSLK80k6wKM8LjdYVuIC9RCRuEaq8beYHoVpF?=
 =?us-ascii?Q?D6HGY0qiPJqxsHZIcVI9UyvG8ALXPwwRKK1YhvYMhWJ8NAYVMQS3ZRv+AVq8?=
 =?us-ascii?Q?h9GBsPDjn+uLIFnwwRhGGzbYkg9YU2KSBb0dqryyzfFWntkofagjl8X3TUOa?=
 =?us-ascii?Q?xtBve+l5dLfbFXnaFtOrtwhbkJIwbgYM9JsDTGZ6M/c2p4FVdzU+Wptueanw?=
 =?us-ascii?Q?YVY5g773HvRwA7wgykn8yFKstlMgFoFwmXSX8svdHlcR/QgAUtsohhu2/lq5?=
 =?us-ascii?Q?yIWuQdFcY+S6ppk0dGDArgRPjOA2TDtFVLsc1yZ5OLgNafU7X8TQo4GA6jbl?=
 =?us-ascii?Q?xA2TQD8bb0pvfYBZyRLfikcxMjO67oLCXyK1L/k1BadvMK3InzT7N+r42n6p?=
 =?us-ascii?Q?SQuCPtoG3t1O4P42eoAws6WmaMTghlt2W68jx1dQGptvWNGB7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:03:08.6774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc01f782-09cf-4c32-2731-08dcb6638e78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as it is assigned.
The assigned RMID will be tracked by the hardware until the user unassigns
it manually.

Hardware provides only limited number of counters. If the system runs out
of assignable counters, kernel will display an error when a new assignment
is requested. Users need to unassign a already assigned counter to make
space for new assignment.

Provide the interface to unassign the counter ids from the group. Free the
counter if it is not assigned in any of the domains.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Removed mbm_cntr_free from this patch.
    Added counter test in all the domains and free if it is not assigned to
    any domains.

v5: Few name changes to match cntr_id.
    Changed the function names to
    rdtgroup_unassign_cntr
    More comments on commit log.

v4: Added domain specific unassign feature.
    Few name changes.

v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
    The function is not called directly from user anymore. These
    changes are related to global assignment interface.

v2: No changes.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 52 ++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 4e8109dee174..cc832955b787 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -689,6 +689,8 @@ int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, enum resctrl_event_id evt
 			     u32 rmid, u32 cntr_id, u32 closid, bool assign);
 int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
 int rdtgroup_alloc_cntr(struct rdtgroup *rdtgrp, int index);
+int rdtgroup_unassign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
+void rdtgroup_free_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp, int index);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1ee91a7293a8..0c2215dbd497 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1961,6 +1961,58 @@ int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
 	return 0;
 }
 
+static int rdtgroup_mbm_cntr_test(struct rdt_resource *r, u32 cntr_id)
+{
+	struct rdt_mon_domain *d;
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list)
+		if (test_bit(cntr_id, d->mbm_cntr_map))
+			return 1;
+
+	return 0;
+}
+
+/* Free the counter id after the event is unassigned */
+void rdtgroup_free_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+			int index)
+{
+	/* Update the counter bitmap */
+	if (!rdtgroup_mbm_cntr_test(r, rdtgrp->mon.cntr_id[index])) {
+		mbm_cntr_free(rdtgrp->mon.cntr_id[index]);
+		rdtgrp->mon.cntr_id[index] = MON_CNTR_UNSET;
+	}
+}
+
+/*
+ * Unassign a hardware counter from the group and update all the domains
+ * in the group.
+ */
+int rdtgroup_unassign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_mon_domain *d;
+	int index;
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX)
+		return -EINVAL;
+
+	if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
+						 rdtgrp->mon.cntr_id[index],
+						 rdtgrp->closid, false);
+			clear_bit(rdtgrp->mon.cntr_id[index],
+				  d->mbm_cntr_map);
+		}
+
+		/* Free the counter at group level */
+		rdtgroup_free_cntr(r, rdtgrp, index);
+	}
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


