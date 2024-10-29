Return-Path: <linux-kernel+bounces-387846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D1C9B56D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93239281BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8313120C494;
	Tue, 29 Oct 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nEQSFcTL"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3C20C004;
	Tue, 29 Oct 2024 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244302; cv=fail; b=mD/wjV9EYQwk27Xs9SPQimNBiMXi/ojMWkJcIzAQQvzEzCgipJsCvkeKXKDWspWGSG8mX7tyvQvMHB2zP3sXJe9xWjbDZGqXeHwOoUbk2kqfWChny2MA+GE+aDxeQRt1loLbPFIawVe4pwlCs6Qm3xkhjJd2UOKG/JGvDW3M0vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244302; c=relaxed/simple;
	bh=8jbUK9xKN+sMRgEmAmQA/nJmaobOJtL+oxfFu0mBsI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5zcgYjpyCR6Vj63M/GiC5fh6O1gUxPjDFXPRzlz7TvIM7sEcLM14KfZatkezqkyaZJc4Gl3bQfBr7tpmImlrD6dLpgeO3NXeh3oKKHo0EUplwi/PXACz0hqvUC9dc000He0fcHZ4o4dFVkGWzc5m65KvpOFg+h2IVijTUhTICs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nEQSFcTL; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpeqcWy4ctynU1dN6DDWADCNf/DUMXNZMUCrhNb8qfvjvX/lpW2WN5rkisU4O8lF71EnPzlvxUghAHnC1ZBEOw/Kq5SwvQO4MkjOK5AtZM/chIFBGpeL02Dzxn6w+YZO8klrfFW1oES9Lo6WS7rJFDFZaMAagfXnFWK/JTNIi/gls+eM9YOKKIfKWplZNLytBLv5+KfedGBA3EkwtGzqynwE7OWTPatA1AYmqiHhi5c75SqAXHo/V5FRXqB9H05QcY3UGSRx5ptWgR6gVOarKpNqMe2iJ/a6FkXRaLwpepfTbne3xYdoPY4wR4v23rfTvmcyqzuv4/QYDLJX/PTtkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Rtu0m1uldQtDd7y9k0ewKo7VWtuPjzlbof4Eot5QhY=;
 b=Kfvsr0ugIGSLoJ4+X3oGywv/uptcphRdIW0EuAvGl7uJtgdc+GMWR9uHFJD9f5owG0bfNMO59R5rqtx3+jlfiZfU76Hun+gBdnZ9NMv7U4v81z6JtRHNIWKt6lfane2M//scHR9nHqqMb8ME09sC1vmUdDnhb7NSsUYFlGmVyAQyhhyARDWasNH3jNMlcjixW3QnNDCEZY6/sH1PoKTgfhCdEzXJbMkr4pgJKphqzmNqdDH8qFGGWVNz7PAHVqkw2YnBOBCNvHYpXM1ZQaXDWHHsJNHiv7DJMH8bxu4lLc4+tIyC4EBVL0SxVeV5rfEQ4CrT6WSWS4ejwCwefF+z2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Rtu0m1uldQtDd7y9k0ewKo7VWtuPjzlbof4Eot5QhY=;
 b=nEQSFcTLLhRQ/XwO5F/3d7HMQ6xIyRYYq5sLleDVlJh+0jeLyObiE9LrDXMb8m/F94znpY3p4R74OOXhPk27FhsHoda/C8oBuvVmY99sIVeTintP+k/AzS0KcMKDPxHMyqV8R+O6ieI/H+QHNNDcdHnYKgUEutlZQvZGi6FfumE=
Received: from SN6PR08CA0023.namprd08.prod.outlook.com (2603:10b6:805:66::36)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 23:24:54 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::7f) by SN6PR08CA0023.outlook.office365.com
 (2603:10b6:805:66::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 23:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:24:54 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:24:31 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <babu.moger@amd.com>,
	<jithu.joseph@intel.com>, <brijesh.singh@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
Subject: [PATCH v9 17/26] x86/resctrl: Implement resctrl_arch_config_cntr() to assign a counter with ABMC
Date: Tue, 29 Oct 2024 18:21:49 -0500
Message-ID: <a3c2bdf2153882cc955b80b7d0fcdf7af3d09eb3.1730244116.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730244116.git.babu.moger@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 404323b9-74fa-4c75-924e-08dcf870e530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xdhBWlumhS88aa6G5dSMvMyWdBg/UiD4A1iTHwTogYjuWVr+4vyzZ8E1OTb2?=
 =?us-ascii?Q?qtDNMAzQpOeDNm9JSY5pSAlc3vSKn3AMTccXvoXIUTG3NPYRkATHEMZg8r/W?=
 =?us-ascii?Q?wJlyDx5pBKLtOVuoPT7jIxpyH+vAwGX0GJmLuOjbgLsS0ZJjMEdq1wGclO3K?=
 =?us-ascii?Q?WPtGUnaY/l1aelCJgw81AnigXa20D6DDUFysgAvR/jwZu9cZPevgCeHuXdTh?=
 =?us-ascii?Q?7MQ3tLhGQ09OWDayG399CpfrJlyj7tlvmXJdlXi6TW/YPZbc5UmyMMqKuie0?=
 =?us-ascii?Q?K5DoMz0AGiL2/KcYtw68YVKiAkez6fkeWx5WhCWR2+fO3HVIxEm1VtECRCkt?=
 =?us-ascii?Q?+ad5/ONMdj8c+ieINAz3RdAFdy0cQgVt4BZW3r/65Vr2SgLcffV1hlE/SDkQ?=
 =?us-ascii?Q?oviBG9s+TWYFU1RL6Nh/6QRrNE6XSPNql3WPEgvI2J7J6RHxUpgcHslD065M?=
 =?us-ascii?Q?ksaFlaexdvCs9bhfVYLEUW5feeF8MtXAddvqjHdCwMXT6+eimhlRlnCsBa+c?=
 =?us-ascii?Q?UxAu0WIbMPCXLL4iFwQ+KWvK2kWBx5oBzHZCGLS+CUs/2KoXB54Amx+9jyD/?=
 =?us-ascii?Q?haGUnC/veQlaTKzVbb9y/sizkbqNawrCiLZYGI7NsNHGckUdZl7FDR0qgMS+?=
 =?us-ascii?Q?BtJch3t/COxlvktSvmUqC/Jv3t2DVXfM9fbeQrmCWbXFTFNKSbTSrKIgRPXX?=
 =?us-ascii?Q?sIHZvMDgMg9awp5VMrsee9hNPHW+eaF9YGPbsEMfg7d3uZRfZrHk66bA4FC3?=
 =?us-ascii?Q?yN2zEKk4qt5Zvz+uwduafzNx1uNUl6rkg10Tfd+YVgr45hXKelvW0zJKWKmw?=
 =?us-ascii?Q?A6VJUT55iW5OQZfY6MQcT+lJh7EjNQQd8SO0Co6RitAIku0cWn09qByyDppD?=
 =?us-ascii?Q?H59WeN0D2o5EPNZgmQNKCG9FGSQ+C3UEtrHpLeoRm/s/3cf9LEjixRrJWBj0?=
 =?us-ascii?Q?2davN65IBbb4hgvZafrq7sTaRdRMAhHXFCLkq35rxArdeeH5omClLX58nV+y?=
 =?us-ascii?Q?SGUlu3/okqwNS3e/5l9RSacY61JEl0FqQ3RhasRviD2gSGnXIPfARMNgTXYm?=
 =?us-ascii?Q?Vc6VrsSZh1g3nSGA0y6zKURQgJ/BToxSnFqnKURu/E0ldu3PNG+FekbVZ9hC?=
 =?us-ascii?Q?QCu32jncA3FY46S05XtcUt/S47s5QrkQw/sNx/QSDB1wwVZT9pszfowGobCx?=
 =?us-ascii?Q?4OvRYp4v4VwHMKCMa+P256rIaqXWfUj0bPHKoSMic3ITNDBlaWqQd4PJKeRF?=
 =?us-ascii?Q?CxZlTtD4JbqkqhB9XZbg8IXs1p8VACbK+ad9xzCcDE6sr3uqEKuEJ9FqveWn?=
 =?us-ascii?Q?jynKpEFq+mXEu7+yLs9bnzPXYlm0g/PvUGjca4YwSZluwIsscOg4cBDTGXPB?=
 =?us-ascii?Q?FziS7kiBDbEjLfwvp5mXtr9aq8aQFLplO0t41B/1fnip7tvVGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:24:54.4021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 404323b9-74fa-4c75-924e-08dcf870e530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID, event pair and monitor the bandwidth as long as it is
assigned. The assigned RMID will be tracked by the hardware until the user
unassigns it manually.

Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
specifying the counter id, bandwidth source, and bandwidth types.

Provide the interface to assign the counter ids to RMID.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v9: Removed the code to reset the architectural state. It will done
    in another patch.

v8: Rename resctrl_arch_assign_cntr to resctrl_arch_config_cntr.

v7: Separated arch and fs functions. This patch only has arch implementation.
    Added struct rdt_resource to the interface resctrl_arch_assign_cntr.
    Rename rdtgroup_abmc_cfg() to resctrl_abmc_config_one_amd().

v6: Removed mbm_cntr_alloc() from this patch to keep fs and arch code
    separate.
    Added code to update the counter assignment at domain level.

v5: Few name changes to match cntr_id.
    Changed the function names to
      rdtgroup_assign_cntr
      resctr_arch_assign_cntr
      More comments on commit log.
      Added function summary.

v4: Commit message update.
      User bitmap APIs where applicable.
      Changed the interfaces considering MPAM(arm).
      Added domain specific assignment.

v3: Removed the static from the prototype of rdtgroup_assign_abmc.
      The function is not called directly from user anymore. These
      changes are related to global assignment interface.

v2: Minor text changes in commit message.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  3 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 38 ++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index d1f3f3ca4df9..00f7bf60e16a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -714,6 +714,9 @@ int mbm_cntr_alloc(struct rdt_resource *r);
 void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id);
 void arch_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
 unsigned int mon_event_config_index_get(u32 evtid);
+int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			     u32 cntr_id, bool assign);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 36845e8e400d..1b5529c212f5 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1886,6 +1886,44 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static void resctrl_abmc_config_one_amd(void *info)
+{
+	u64 *msrval = info;
+
+	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
+}
+
+/*
+ * Send an IPI to the domain to assign the counter to RMID, event pair.
+ */
+int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			     u32 cntr_id, bool assign)
+{
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+	struct arch_mbm_state *arch_mbm;
+
+	abmc_cfg.split.cfg_en = 1;
+	abmc_cfg.split.cntr_en = assign ? 1 : 0;
+	abmc_cfg.split.cntr_id = cntr_id;
+	abmc_cfg.split.bw_src = rmid;
+
+	/* Update the event configuration from the domain */
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
+		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
+		arch_mbm = &hw_dom->arch_mbm_total[rmid];
+	} else {
+		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
+		arch_mbm = &hw_dom->arch_mbm_local[rmid];
+	}
+
+	smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd,
+			      &abmc_cfg, 1);
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


