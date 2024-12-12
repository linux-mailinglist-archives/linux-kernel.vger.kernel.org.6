Return-Path: <linux-kernel+bounces-443892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15E89EFD35
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D19228B574
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F3E1DD874;
	Thu, 12 Dec 2024 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ILBX0e2P"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFA1C173C;
	Thu, 12 Dec 2024 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034669; cv=fail; b=TpuKmUO6QCpZBcW1yo23sba9odftHsvmNnYMI16fliD1kR0lF8hlYFKeMdqjdTre26rFN4ADDqvfs2VvHDvxp51u0e9bl4rEMeeJw2FR4TOm1g2reONZWxL0b19o3doFI0cbGCp3kuD9yDDEyhDn0O9XWZreRz/VGQrvmETTnuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034669; c=relaxed/simple;
	bh=NnD/22pRfRZdofIgEzgYayvRtFI693CNx9az4J4Q1d4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRIM2Gf51qTXKv68bceZyTZLnwyeN43lZESPJGSMcpAUuUWlmdNlJXHkuewf4wQBHOidfISQ5b2fppKNqf/B47A7KJjpFhEyZHvQpBvZ9L8Bqf1wnj0KeyYobdZVr3MZRzK5JjbJ5pGSzSCtFp3yNzL6gLwP+ndLCEuhPKOxmYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ILBX0e2P; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+3DWqBPiWAcgiFbmajp2GSwmLZK2NSUcVMPmWrHDKwlE/bIcRXiIRQq6xAZJWv9TdNmxHKP9+ixv7qZK4X6nbKH/LVPyVqDRzLAyGSX/CMMB4gSsWlEucUsHilGkChZwTUHq5uXuZ1StF0EJ88oE9WTA3vnaLrzCsYoUTnxFNi82FyDiW8hO1VIbFkIjt+nTvZMygXM8f/IF7MsTk5jXYqleRcFEmGjtqFr6yDQhT0srl8spSRGrMyPDTO8vXqp4QzcH+SEFJYaGWsC2Li2bRwGjdYvkfXwYHX2BjSTXSj3BlMILcEA3j6RM/fWyfPVDbQeF1cRu7ifp/oHc0pmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOHKMYDrhp2Z3/i6CTARy0BAmryoqeE0lM4RL4Eiz9M=;
 b=LZTchu2/pyDC3gBlLOW1/Gu5teOmOxC/kTglg6yeUrVh6bWB44XaO9BxiCuwlLX/HPSMjkIq9bf+PmEgUBoq+aB6CbB8dqeo8JlUfdTD0iHDa9ZZdCENIkMJMhzr6OslkgtDk/EAZRvIamYQO7zz6MteZWf11X/K96gMCsKLpclAVi7O9ggotFWS/yikO9nLPA9jrXN44Oi4DO+Cu23Eeik3P1LOsOywKiKbbgFj3l2OKrnWq4uZU94WQKzPMfcqP2u/mVU1G4U8OfbIAiAktu40zmgwC4AJ4oX6omLpy/wbBvLXtaSfyIxQcnzBnxeT8MNQHb0GInI3N2dVHagLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOHKMYDrhp2Z3/i6CTARy0BAmryoqeE0lM4RL4Eiz9M=;
 b=ILBX0e2Pg+sACngKEo7GvZtJ6ZOuzLOpR44xGc/iaXAPK2gZSzrJbtEevNm4Ak4b4tMyzaAUvYwgnnnLYB2a5Yog4imTWe4rfA5S12K1jLRp13CV2ngXHzkI/7M4pL+Uch+lxIp6UsIJRVpSU1cLgXPzpdX8JpzWZvAoUWaZi64=
Received: from BN9PR03CA0752.namprd03.prod.outlook.com (2603:10b6:408:13a::7)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 20:17:42 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::9a) by BN9PR03CA0752.outlook.office365.com
 (2603:10b6:408:13a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 20:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:17:42 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:17:38 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <peternewman@google.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <andipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<babu.moger@amd.com>, <xin3.li@intel.com>, <andrew.cooper3@citrix.com>,
	<ebiggers@google.com>, <mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
Subject: [PATCH v10 12/24] x86/resctrl: Introduce cntr_cfg to track assignable counters at domain
Date: Thu, 12 Dec 2024 14:15:15 -0600
Message-ID: <5abf8affeaade3e7b08e9509d11bc78143935800.1734034524.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734034524.git.babu.moger@amd.com>
References: <cover.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf15d85-ae65-499e-7eca-08dd1aea089d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1LBuh1oIY7/0GZE1apq8IcPYgKyWy9/wipEYnOohgjSnjd7iBS2ehd05lW6J?=
 =?us-ascii?Q?uC2nqEhy34mkS6WTpwOA01A9MQfqlLYtCgReyLkhNGIfjarD9xZWOdAgjHp/?=
 =?us-ascii?Q?JkU25umKqwnkeHYqDyHxjqCU9mSTHpeSNBtDgkWO+mg8x6X6n7kRFloN+mQd?=
 =?us-ascii?Q?QOp29ezF8pqkQXSkybRlOljve6j93cvzYXwsYKSeL8V6zr7PCK7LLZQk3uVk?=
 =?us-ascii?Q?EWM/dmxg86mJq7v2mC8i79aDjhlQlfu9wj69r3ZIxf2dh1qZ3k+g+3dP1S49?=
 =?us-ascii?Q?OlrXdkDexQCIFUdlqoEL5sdMedE1Wl+95cYZMNPq1PtXhdulQh5JNQvuuRvE?=
 =?us-ascii?Q?CmT4I1Xgq/mWfUzJmGTp9fpZKu/Pm6IXc8cO7sh2NkHWTe8EuQoUWkxIzKgy?=
 =?us-ascii?Q?UNNUDeaf/fj5BvTeUEJFRC7ouxgVUjpZSA+FSBXkTW195dw0I46e1c0ymq8w?=
 =?us-ascii?Q?yRvDe5e0YRSAUvzFXBicfpycc5GEoPYL6VANHMT91GLjN34GhV7wc30y4aNs?=
 =?us-ascii?Q?wnyDu/dlBcNN+XE6iiTLUWpPCeFuRlWPXvGpXCWAzq9mWJyUYhNcnuyb7vpE?=
 =?us-ascii?Q?aPN8QovQPAqkg+H2i1ghPblqJBU71VI26K1rJkLDc4zPlpG7U6owQPUW8Nl1?=
 =?us-ascii?Q?yqkymSEZqh7Dy4cSCsQUA/YvlyXxHbiyjpuJsRv4+5FV/0uLJnhkBB7mcGgt?=
 =?us-ascii?Q?a3E8utSgilCXI9oe/G5nPLDzzOFzwD7W3mG02RO1cqftJ/A5U6fazcolzCq5?=
 =?us-ascii?Q?eSlTRgqrG51yF85LkGPRS5N3lZw+Dr9KTcrtn0IkLzIpcuqi/q1uMGli38KX?=
 =?us-ascii?Q?kYbgs0/YwNlOgMDQNL/l6yMxOk8uTSg+UYI8d8HbPB4pvm3J1gUii2YzNAZM?=
 =?us-ascii?Q?+6ctaBZJkiWnn1Lt0znwa6+Y/0j6LvA7oExdTuwsSrJc3wEVNSlknuIZutnM?=
 =?us-ascii?Q?IGUgI1cfbhc88NCZ8FI2DZ720BwDU9/rQJrJEBFBLv09OMCGWExunl/+q0t8?=
 =?us-ascii?Q?Zz2fN9rspowvAzqeu/fXjpC6UFUoG0bLx4j0/e6kVzF/UMsdoXo/EtUV0FBz?=
 =?us-ascii?Q?ZT7tLT5SRxJ9qfrToNcaXJT3eSTOz+9w5XfSow9DOu+ZhyQwr9XYPw8JiHXR?=
 =?us-ascii?Q?zPRjMfUigmEwsF3KxozEjteThKMM9zA3FcCgziSUPP51ll4jIEyMZoM/l61t?=
 =?us-ascii?Q?GeqRhW3ufKkUGUAHRqI58WFulkDsr6sOA7iWIL8CCX9jPdkEBCNR+Mpz4UX4?=
 =?us-ascii?Q?sqJ+P86QbJn46H0zNVATE1jlUYxjicRBw7AL46xjtI/tZP2R07ByVEF0qpBZ?=
 =?us-ascii?Q?JsomoJFNTUzJ4IloaPmtPJyaCk28s1UPD4Z7Q9hGAUqKsCpnKZwhldTw47Ha?=
 =?us-ascii?Q?rCEIruwSF7t85AXeVm7jXrL4oIM77cWqEVhxzN4o8tbH/r7q7/cTq2IaDpTT?=
 =?us-ascii?Q?BYUlIz4i0nfV3a4YBU+XYlanEp08p4sfRkFVk/cbsFG8kd2ZtcfHDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:17:42.5062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf15d85-ae65-499e-7eca-08dd1aea089d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

In mbm_assign_mode, the MBM counters are assigned/unassigned to an RMID,
event pair in a resctrl group and monitor the bandwidth as long as it is
assigned. Counters are assigned/unassigned at domain level and needs to
be tracked at domain level.

Add the mbm_assign_cntr_cfg data structure to struct rdt_ctrl_domain to
manage and track MBM counter assignments at the domain level.

Suggested-by: Peter Newman <peternewman@google.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Patch changed completely to handle the counters at domain level.
     https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
     Removed Reviewed-by tag.
     Did not see the need to add cntr_id in mbm_state structure. Not used in the code.

v9: Added Reviewed-by tag. No other changes.

v8: Minor commit message changes.

v7: Added check mbm_cntr_assignable for allocating bitmap mbm_cntr_map

v6: New patch to add domain level assignment.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
 include/linux/resctrl.h                | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 682f47e0beb1..1ee008a63d8b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4068,6 +4068,7 @@ static void __init rdtgroup_setup_default(void)
 
 static void domain_destroy_mon_state(struct rdt_mon_domain *d)
 {
+	kfree(d->cntr_cfg);
 	bitmap_free(d->rmid_busy_llc);
 	kfree(d->mbm_total);
 	kfree(d->mbm_local);
@@ -4141,6 +4142,16 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain
 			return -ENOMEM;
 		}
 	}
+	if (is_mbm_enabled() && r->mon.mbm_cntr_assignable) {
+		tsize = sizeof(*d->cntr_cfg);
+		d->cntr_cfg = kcalloc(r->mon.num_mbm_cntrs, tsize, GFP_KERNEL);
+		if (!d->cntr_cfg) {
+			bitmap_free(d->rmid_busy_llc);
+			kfree(d->mbm_total);
+			kfree(d->mbm_local);
+			return -ENOMEM;
+		}
+	}
 
 	return 0;
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index c8ab3d7a0dab..03c67d9156f3 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -94,6 +94,16 @@ struct rdt_ctrl_domain {
 	u32				*mbps_val;
 };
 
+/**
+ * struct mbm_cntr_cfg -Assignable counter configuration
+ * @evtid:		Event type
+ * @rdtgroup:		Resctrl group assigned to the counter
+ */
+struct mbm_cntr_cfg {
+	enum resctrl_event_id	evtid;
+	struct rdtgroup		*rdtgrp;
+};
+
 /**
  * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor resource
  * @hdr:		common header for different domain types
@@ -105,6 +115,7 @@ struct rdt_ctrl_domain {
  * @cqm_limbo:		worker to periodically read CQM h/w counters
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
+ * @cntr_cfg:		Assignable counters configuration
  */
 struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
@@ -116,6 +127,7 @@ struct rdt_mon_domain {
 	struct delayed_work		cqm_limbo;
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
+	struct mbm_cntr_cfg		*cntr_cfg;
 };
 
 /**
-- 
2.34.1


