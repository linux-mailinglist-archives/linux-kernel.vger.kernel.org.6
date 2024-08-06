Return-Path: <linux-kernel+bounces-277002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FBD949AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B0E1C220AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32348178374;
	Tue,  6 Aug 2024 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="npG30UBH"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E3176FDB;
	Tue,  6 Aug 2024 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981818; cv=fail; b=Gp5xc1Wk/p1v6Hm5XnZfuFd6y9hb8LQ7baR2unKZlqJQfdczLczYp2lWd84agrhmWGI7sA2fvlwIQS3j4U3EPWztUzd1/5fulAz3yKkamxLicJhkFRs7WfR1haftX+1Lu6yDv89NzQb0bz46uihgV/6Un2+vvRbXzp4VtXHX3I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981818; c=relaxed/simple;
	bh=mHbX5JYetqMw/hXe5qyEdJExcjwCbgWhEQeJw31C/iU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cq8a7ZitfrZMdZvHsPx9g2bLLc2qxhU5ZzL3khusgGlJRuQAaGtwTOf8JEdhQxCbEonJFlVT0i9q/sAsBVKe6LO8NRNe0q2xA/QpkRat3/pQfQnzCgK6dLv4BtxNYlO4+iMUTapiBSdewFMbkxRGjlMBQ3r0IzFMMT6rmxNcg1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=npG30UBH; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nx38/i3YyBI4/L77vCysXxCrv8c5V0+9CuuHCQL2XP2DDCG71ZQdLtGx/aQixl1QUGWk2LGmgaZpYWC2pUQIpArDB053TElyl43B7ZWgQf60EoQc+f5tI1pJFsy0GfXCA2MZ1jOErVGRDEJ8oxoLMjEZPhwu6sWh1Guo2/JJKcLASZzWgXmNI4dQrmjleLOizy0+x79gn7wgpkYv0dxvn1c5RTGoC7kUB+YjSNaStwfLT7/MLgUt+vA940sfktA9jV4j0+iRRZkjecJKdttDTJHPMwTdijPG+E9u0ZG9B0JUe9dCTvdHbFfNVROpWwgP61PkCxRb5skchnJaON/tnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r78anek0uaT/s8CX/EzS5YsOweokANxgaK/Mv0ttNA=;
 b=q+HXZmMVrFsMR5KxxLmG3k6vfYaHe0+ULd7fbHkz/XNHRxM0/t8UXQGV+/Du0gUVKBGC3gsPWJ51k3fVC+S/RCl/zJiWPWsfmBDt8P2V18zwsdwT9CNx18w9pR1SV0qE3Ka3//8bbdR8ImQPlYLPu5vEcxGxGqbOx9bq17ju+XYq24HYAdfApMY7xwFX8nBkjbHskFVASbroaVHtoEt/oxGkUBTxHRO10Q68Kb2GcSNJUK01qfZaWRua69fdDxctfyUdfxKoVwOhYOgSPMMe+e1DFJUiSYnZc/1UHUAVsn5RrHSkQ79WVEyPtRiXUjonUujoGkyoAzY1JfOdecYsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r78anek0uaT/s8CX/EzS5YsOweokANxgaK/Mv0ttNA=;
 b=npG30UBHx5yBCTZK0VP3EnCjtov1tn4Rv6YS6RArLTKeObnYbxCvNAIqdK4RcXqMRoB9H+OhcZKbxMs3VGT2C9iQoTwzdcCgPanM5Sc4AqenhsNez1xJVupy5v2xi97ylb21vScXeR8xvTrQ+4TkRbBNfaxMlLO0qeh6ei2f1NI=
Received: from PH8PR02CA0004.namprd02.prod.outlook.com (2603:10b6:510:2d0::26)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 22:03:31 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::3f) by PH8PR02CA0004.outlook.office365.com
 (2603:10b6:510:2d0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Tue, 6 Aug 2024 22:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:03:31 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:03:29 -0500
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
Subject: [PATCH v6 19/22] x86/resctrl: Introduce the interface to switch between monitor modes
Date: Tue, 6 Aug 2024 17:00:56 -0500
Message-ID: <784eaa900b9e0778ddc534c04c7ded9466bfd19b.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c08b469-32d9-43f1-9d81-08dcb6639c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZJiZsjFdB6FhIK4PltXEPq4qOayG6k9b9dEJtN3i4BsHdLpDD1b2AMawTcNZ?=
 =?us-ascii?Q?Kom66KXqXuKGbtlJCl7mK3ptYAsLWE49lJep5XS6HCMG06GR14tfiEtFVRbc?=
 =?us-ascii?Q?8jSbuEY6Ems66Wm6rnNxzHvG/LUG7qptPeF8b5AGD5NHR+YEDutkWuhrBjrj?=
 =?us-ascii?Q?3+h6tkk9WQkS3gmWBvErHPU/3wphuHZOlXRLr37YGRwNawQnciTgfSnIZoqy?=
 =?us-ascii?Q?u8jY5TFKQXyAZfFkAwMxAINPXsUdwwBVCwrw3DN0PZ5RgIngHXOZWA1zY8pJ?=
 =?us-ascii?Q?5OT7P8odB0tU3I9EWdCXYzHTAmc62jb8/pNAioxP0w7ypqR8R9nYAsDYNYI+?=
 =?us-ascii?Q?4zX43BKKj6DHSaHVMdxH/kXmZivH0uoZzDP+AG9QpXvcEi4uZV6Idu4RfR+I?=
 =?us-ascii?Q?6zIEt/ZRubtK1mhJXdTbFKw4ortuRxUZdXDJJdpAXPmhpnV/ltMkt0eLX469?=
 =?us-ascii?Q?X+aZlHU86RYzI/YpDjnNfvN+UYl3mvCu0rRVVk+FQagtntXdCokch6yRXoyE?=
 =?us-ascii?Q?Xmau4acLzoBwX1AC2Gfdi62IkDda/XjIWaeZpWqCvTO5EMra74aOnLlTt9ix?=
 =?us-ascii?Q?g5eE/LG+E3bgKJQoh56Q9IRyR1AtMAK18TxXNDUyG33GvAgaF7Cl6Q2zIgYi?=
 =?us-ascii?Q?zPJy2QP5fQ3mjc++aucM64AI8DwooHPWUCsSPnfWGqS9dO0wu+Bh/EGN23Id?=
 =?us-ascii?Q?9Iz6Y8gewWN3LYiKDMeABCnnVEXP0v8i42pOlgsHUm0xsxKjE9ZuxQ0Wi7z7?=
 =?us-ascii?Q?uhd+BmAxbauJ/raVSAbAmuSmN1PQc825w+8R01H0MNBTWA28Ea85DzSpw+Nk?=
 =?us-ascii?Q?2p7vII4ETm0Mw7gcC7X19+23H5l7YzB25y/ZJyp3fUyo40w22791oIMgs02+?=
 =?us-ascii?Q?LoOuCpAD1z7R13ZYaQJn0s3XfjyofXIdjTZHYzsqXAnLm+0kppVqjtB81i1p?=
 =?us-ascii?Q?O7TWNk8tpBO/LEg4odg6keP3+8kZjbs1jYvCYEJG6ydAgzTmDhdGTE0kNpQo?=
 =?us-ascii?Q?QJdW5pZMdshmIfNJGhLzpr9UGgL8F9Q9pLkNl/o/zjYtiBAF9qDUStsohN2R?=
 =?us-ascii?Q?3+4+6VkfM/+K3FPe3AM6n6FCaMqXGW3WJbpHf9juhI/DyjlFZNh5AL+x8GbF?=
 =?us-ascii?Q?z8B+O3bBwy3jFRh1ElRq1Uj58lHy6RlPlsjF2LPcsR7VldyC91NiGSmEK81a?=
 =?us-ascii?Q?xAhFhSvH44bommbZWUOagNNWbAAfq0J0U7EYkl2dEyEIdKnuo9bUTctE05I0?=
 =?us-ascii?Q?6FHJ+saNkCZJRliqSspinjDSbdoDyDv8dx+nYTF6M+Mnl4rTsKmSugoSCane?=
 =?us-ascii?Q?mJdEoCPP/ZVEU8EvQvUEgtCWmUVn4g2HMJjbFoB1iaJHxK/C4RbFP+J08bFK?=
 =?us-ascii?Q?sYRhU8hl46sbhDxUFuNda48Nd1sBSdCQ54bN/2YHFGSzhWrVzyEdZPQZ8Hrd?=
 =?us-ascii?Q?GJEk1aSQzyjsEiBxV0cV6AVqaq6HYqY1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:03:31.3886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c08b469-32d9-43f1-9d81-08dcb6639c01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341

Introduce interface to switch between ABMC and legacy modes.

By default ABMC is enabled on boot if the feature is available.
Provide the interface to go back to legacy mode if required.

$ cat /sys/fs/resctrl/info/L3_MON/mbm_mode
[mbm_cntr_assign]
legacy

To enable the "mbm_cntr_assign" mode:
$ echo "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_mode

To enable the legacy monitoring feature:
$ echo "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode

MBM event counters will reset when mbm_mode is changed.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Changed the mode name to mbm_cntr_assign.
    Moved all the FS related code here.
    Added changes to reset mbm_cntr_map and resctrl group counters.

v5: Change log and mode description text correction.

v4: Minor commit text changes. Keep the default to ABMC when supported.
    Fixed comments to reflect changed interface "mbm_mode".

v3: New patch to address the review comments from upstream.
---
 Documentation/arch/x86/resctrl.rst     | 15 +++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 62 +++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index aea440ee6107..d6d6a8276401 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -291,6 +291,21 @@ with the following files:
 		as long as there are enough RMID counters available to support number
 		of monitoring groups.
 
+	* To enable ABMC feature:
+	  ::
+
+	    # echo  "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_mode
+
+	* To enable the legacy monitoring feature:
+	  ::
+
+	    # echo  "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
+
+	The MBM event counters will reset when mbm_mode is changed. Moving to
+	mbm_cntr_assign will require users to assign the counters to the events to
+	read the events. Otherwise, the MBM event counters will return "Unassigned"
+	when read.
+
 "num_mbm_cntrs":
 	The number of monitoring counters available for assignment.
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d93c1d784b91..66febff2a3d3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -896,6 +896,65 @@ static int rdtgroup_mbm_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static void rdtgroup_mbm_cntr_reset(struct rdt_resource *r)
+{
+	struct rdtgroup *prgrp, *crgrp;
+	struct rdt_mon_domain *dom;
+
+	mbm_cntrs_init(r);
+
+	list_for_each_entry(dom, &r->mon_domains, hdr.list)
+		bitmap_zero(dom->mbm_cntr_map, r->mon.num_mbm_cntrs);
+
+	/* Reset the cntr_id's for all the monitor groups */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		prgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
+		prgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			crgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
+			crgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
+		}
+	}
+}
+
+static ssize_t rdtgroup_mbm_mode_write(struct kernfs_open_file *of,
+				       char *buf, size_t nbytes,
+				       loff_t off)
+{
+	int mbm_cntr_assign = resctrl_arch_get_abmc_enabled();
+	struct rdt_resource *r = of->kn->parent->priv;
+	int ret = 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if (!strcmp(buf, "legacy")) {
+		if (mbm_cntr_assign)
+			resctrl_arch_mbm_cntr_assign_disable();
+	} else if (!strcmp(buf, "mbm_cntr_assign")) {
+		if (!mbm_cntr_assign) {
+			rdtgroup_mbm_cntr_reset(r);
+			ret = resctrl_arch_mbm_cntr_assign_enable();
+		}
+	} else {
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
 				       struct seq_file *s, void *v)
 {
@@ -2127,9 +2186,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_mode",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_mode_show,
+		.write		= rdtgroup_mbm_mode_write,
 		.fflags		= RFTYPE_MON_INFO,
 	},
 	{
-- 
2.34.1


