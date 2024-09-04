Return-Path: <linux-kernel+bounces-316046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E927B96CA58
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17ED28BDEA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CB41917DA;
	Wed,  4 Sep 2024 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5uWQzJPh"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7272179967;
	Wed,  4 Sep 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488649; cv=fail; b=QuVafaPYLiIA7X2BKc+ewGel8So0x8UupEX4I8Euust05Wv/KZ/Sps38MJQ3gj1E2Om1wUeLrKFNRQZkM5ZY5Qpr/fmrG1+BGT3ghyHQMr2iDWDqrW+CzcszusrbrYWbD+cMFSVnVedHCUlUhm8pvVZBOlwzNCHNa6pEHzC/pkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488649; c=relaxed/simple;
	bh=Qef71ea4ZxUd5IgqgRDwPHowxyxw5qyIWfE24MHLvmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKW54B9LxP3PuZIMIrEBZ980fVyG0XleY3CpYQyp4vCld+TAe+algcQUshVF2lv8ANzt8JE+td0Qu70a72PJCQ9JITw7gvSNMM+FUrAeKRsEhFFFlGknmQtkbLNOCRuBeOLrVYVqoZV+bbz2hadK73PvdJdwirxB/gwbesDY3U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5uWQzJPh; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoPSpVmYrFklKuOvlxfaMyBEu4wcnDyEQwcCvhls/Y3iooB/BRLG1GoLPfZZ3n4rGXMslhlF9bIJUk9p5QTgQJEFovXrWHjSLa6C7RuLEZVBieh8TvvRoHjiVJJoIwc2yQuATpyVjLjoWdp062jHAAO3nqYqONr0xgQix0OHmn3G2CQh0wpKihmQC4tt0GajQSApFp372yl44RjTHTr8Wrel7r53x+AWSH1xWUF8uEVQAFgJoQNvqQS7eG0cAUL8h6En+YfDMBAi5Rgwfd+IdOuaQJykuSdeStR6kAWwSSV6QhtD6peY/PwkPaRks+Wg9zstTQzgm+pjm+fYkzuvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6FoOnZDty4RJn/oEHg1YWPtoi0BXr+qk+8nmcfCbJs=;
 b=bVIRoHO4q6t+nWnrTdFIRl+/rvCYKigwMBmhaX4PZLs/wO9eO9ze++oE6JQNioT4bbRMwnFG6FPpHGyu9H/1s2rfO04I6lwPEc95zgSjpNV1mFKBBJSgSm7uNzq4nHBysyDPZ46YyXu3ubfDLeAbuLSXusYTlJXe+nee0U5AtU4CnNrm9SqXvg+nYaDvQ/ciq38rVHwfdTYA3wr6jRg/o5cZeAnh4IBFinVogxtiu2gipuPcDi7qERLfzxsk5jzKGUux2gxuIqnTbDRKe3sXQZcFztbz8op16jdZXTxF8NBmF3f2ggCy4CzGTccRXnIFWXzu4NUSDMZHCo9prUcbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6FoOnZDty4RJn/oEHg1YWPtoi0BXr+qk+8nmcfCbJs=;
 b=5uWQzJPhpX4tgoFA90qhk9XvuZsVMH1u1CQO0zTQ4eRWQ2BiwC4ZUyZG5sWfd8SSHsPGEgIkrDQn4+mvva+8nhG7zka2a7S+52GcOiJ5/YCEdZkjUgg5yLGQczBsxyGUTwyHeroyR/6QLwif173SdHhj+9eQlRUfnOxQXvjkTBk=
Received: from CH0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:b0::15)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 22:24:03 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::ec) by CH0PR03CA0010.outlook.office365.com
 (2603:10b6:610:b0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:24:03 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:24:01 -0500
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
Subject: [PATCH v7 17/24] x86/resctrl: Add the interface to unassign a MBM counter
Date: Wed, 4 Sep 2024 17:21:32 -0500
Message-ID: <91e045eb3a3b461c44f61c64b826c9e05ac75abe.1725488488.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725488488.git.babu.moger@amd.com>
References: <cover.1725488488.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: bc457430-10ec-46d3-7b85-08dccd30481a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a02UU2Z0uwE6Cp9jiepuU/kqL0f4TRxwNEjcMrHxonV5GaVlgBVMIj0mwc4v?=
 =?us-ascii?Q?cN4t5Xdy0/TzW1uSHdU4HXErKDVlTa5B4mZS0BdoHz+Yz9RXMJYEb+pVR7u5?=
 =?us-ascii?Q?JfeDd8vW4mhFMVfqWdflqPDUaHsIkheYkw0qFMN5lVsNVGhp5TeJ9giVqgB9?=
 =?us-ascii?Q?AfrOD+Bq1gq2fKp5dPZgxoAAcZGVfsy40tXI1vsmPcoQJMAN2zgcJC8rMXX6?=
 =?us-ascii?Q?sBUNS1KcWyqc8/yuUrTRxray8KKjoRlKX5i08/f279iQX2oahHGYbFpud5AW?=
 =?us-ascii?Q?2TFHUFTkHnZz86SdgtVHCTX+MD8Neku5q89jR4/I0VXcXIblEewDXWQM+zar?=
 =?us-ascii?Q?r4eaecECU9VbKRoMH5kp4eaQTTbwJp71qRr+aATxIgbVaJqTw4580FIjVdHn?=
 =?us-ascii?Q?7A0o+I5/Lhuk4BxvdPTMDY4YXcAT58gf35HfPupwb5OqeBU9X008abOa4mrq?=
 =?us-ascii?Q?wXUMeqWhwGgqOTe2GeK++mcTi4EqSsma8ZX6ad5fT/6PtxCm+TSp2KjuCrET?=
 =?us-ascii?Q?fqUGH+DgRpAC8YAvjwieovOXeahWgUZrF1+5UJ8tfTrRdMlg4Td0N+fBTT56?=
 =?us-ascii?Q?ZxB1i7uzXK6kc76w8yqpJPDvzC7oMMA68dzS+SiJtOeZ8Ci1hbti0SE3+zf7?=
 =?us-ascii?Q?Qj/kcavDVEJHrKADAWtiww4eShF37oUaE7uhMaltk7uUt+W1v+fVka4TpmPH?=
 =?us-ascii?Q?BUC3z6BCsQLAQZ5gmbDcOzELpFREoclylyuyd+n8ME7ftQ2wFOk7WDoxh/mz?=
 =?us-ascii?Q?x6HRA92+o7SdxtwXxoPpC6AVdgDu1ONsNv7qXxPPMFpu3KUGvrzCgoxn/ekp?=
 =?us-ascii?Q?Jj5QM8TUXvmBrIGMjKWP5T5QlxZPTIzfuTOodEyQu0Rk6E28RDgR5bXMjm0o?=
 =?us-ascii?Q?XX+4Eq21/X5saewfSKx66M+H9U0cJCoH5+yYoUYBJlhX/we4mBK3pgeTzbdF?=
 =?us-ascii?Q?oiXjv+jWu9jkNMDRbVagcGmARIfxuINdasttD39Xbvmj8mZXgkxDE/LNu3Nb?=
 =?us-ascii?Q?L8dGrE6cuQUFj0hE7TPWzRg46u5cPFUio7Ky5YaVRxwaZaaGUE6KQyY81gSg?=
 =?us-ascii?Q?KHwLdzQlLUdyWEszZH0pVnbHauCBq6YFoWdkpBQmbms7QBycwam5EkYGbiZi?=
 =?us-ascii?Q?2mBH9Jas07XxZr5YF/FKjGBdu/tKTm27Jiwbd1ajZuDnjQjuctqkj1cPZFzd?=
 =?us-ascii?Q?ZA6rBFgpeaXUMN2csXqNhMPm9qEmP9JtxF50Asd9AHEUxODPR6s1zCVuY5mw?=
 =?us-ascii?Q?1yLzPOZ+N5riZImPeYy4sS1P8ExN+NIE5WCStem+4AAJPj9XxQD+jhTnX+UU?=
 =?us-ascii?Q?miSaz09xLEWbfoXNIlp523Z7OyFFQMAoBRCehdBZwHQZ4X0NQVb3GazH0kgS?=
 =?us-ascii?Q?E+76B9PyH7eexr29cCfa8uNshyJTCe9phouuBvHf0hIpTLu5imxIgZRHbMIM?=
 =?us-ascii?Q?5s7GCluV5n91BDPN1yf6ZjDK8mVmvs4T?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:24:03.0805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc457430-10ec-46d3-7b85-08dccd30481a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

The mbm_cntr_assign mode provides a limited number of hardware counters
that can be assigned to an RMID-event pair to monitor bandwidth while
assigned. If all counters are in use, the kernel will show an error
message: "Out of MBM assignable counters" when a new assignment is
requested. To make space for a new assignment, users must unassign an
already assigned counter.

Introduce an interface that allows for the unassignment of counter IDs
from both the group and the domain. Additionally, ensure that the global
counter is released if it is no longer assigned to any domains.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Merged rdtgroup_unassign_cntr and rdtgroup_free_cntr functions.
    Renamed rdtgroup_mbm_cntr_test() to rdtgroup_mbm_cntr_is_assigned().
    Reworded the commit log little bit.

v6: Removed mbm_cntr_free from this patch.
    Added counter test in all the domains and free if it is not assigned to
    any domains.

v5: Few name changes to match cntr_id.
    Changed the function names to rdtgroup_unassign_cntr
    More comments on commit log.

v4: Added domain specific unassign feature.
    Few name changes.

v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
    The function is not called directly from user anymore. These
    changes are related to global assignment interface.

v2: No changes.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 49 ++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6a90fc20be5b..9a65a13ccbe9 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -707,6 +707,8 @@ int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     u32 cntr_id, bool assign);
 int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 			 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
+int rdtgroup_unassign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+			   struct rdt_mon_domain *d, enum resctrl_event_id evtid);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1d45120ff2b5..21b9ca4ce493 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1944,6 +1944,55 @@ int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 	return 0;
 }
 
+static int rdtgroup_mbm_cntr_is_assigned(struct rdt_resource *r, u32 cntr_id)
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
+/*
+ * Unassign a hardware counter from the domain and the group. Global
+ * counter will be freed once it is unassigned from all the domains.
+ */
+int rdtgroup_unassign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+			   struct rdt_mon_domain *d,
+			   enum resctrl_event_id evtid)
+{
+	int index = MBM_EVENT_ARRAY_INDEX(evtid);
+	int cntr_id = rdtgrp->mon.cntr_id[index];
+
+	if (cntr_id != MON_CNTR_UNSET) {
+		if (!d) {
+			list_for_each_entry(d, &r->mon_domains, hdr.list) {
+				resctrl_arch_assign_cntr(r, d, evtid,
+							 rdtgrp->mon.rmid,
+							 rdtgrp->closid,
+							 cntr_id, false);
+				clear_bit(cntr_id, d->mbm_cntr_map);
+			}
+		} else {
+			resctrl_arch_assign_cntr(r, d, evtid,
+						 rdtgrp->mon.rmid,
+						 rdtgrp->closid,
+						 cntr_id, false);
+			clear_bit(cntr_id, d->mbm_cntr_map);
+		}
+
+		/* Update the counter bitmap */
+		if (!rdtgroup_mbm_cntr_is_assigned(r, cntr_id)) {
+			mbm_cntr_free(r, cntr_id);
+			rdtgrp->mon.cntr_id[index] = MON_CNTR_UNSET;
+		}
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


