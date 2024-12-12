Return-Path: <linux-kernel+bounces-443895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AF29EFD38
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C50163683
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256EA1DE3AE;
	Thu, 12 Dec 2024 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Cf4iPA3"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6D1D79A0;
	Thu, 12 Dec 2024 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034695; cv=fail; b=QqWe/Q2Y0SgKObvNEtS4c+eLWhp8oF7EieOwedfOuXwp/D60jS8pqtu+2Vrgn5+Bj6vOKJyw13iVT6dXwis5p50e2859xf+RPcwnshRHqVK2YY56aJLRXsJ5y+Witp+KTa4x6k93BLGdlRpPPqde7SeMItVgHppeB1xTm+h+ZdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034695; c=relaxed/simple;
	bh=LH4Jh5rcZv+/lNIUq9YBW8d86YI3oWrCFM1z8Vkik3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5rZLXhZKOBzeCdILEuyGppU9TRqYBs551nN88Es1TFAj5GiuYCE6IK3vK5e7fC2pdid6Gnspyz6QywqCGOo0gn7iRxLcuYMlSVrJO+U3msxKbCWbsB06JF7aJQS3sx9nGgioj4B/1w5+bovfUh19MGzMCdgbM17RN+meBH4ilU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Cf4iPA3; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdG6bjan/IPVxLhjmyVKmNItv9CYDK0MdLgRHRsVIry3AW0AJgUkj6g2NR3VgWuuoP76Ot1ImtI8JR2mlLsKYMm4x6dhscmuwnMK39x2UvlKIxG9bgfO3/3rCMSH7MAGzn4jUWnqmCivJqTAW3KVREDQgoO01711T49C7EDmmRPjIFgxNbaxeZIBcAaK5rp6+ujMat/VVZhHfiBwo1Q5/bR7d9hhmHqLFdteMH6IdabKxSqKu7SdD7vMIfscWVUjTsCuXqqmo6Tu1Y9HfnkiU2zt9a4LTsAf5NOh4PWX8yVCK6mXosE6HASeB3kvZ6YK+eV7B5evMRd7mhrojuOjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+mqJJJBeAefnP/OmB2csC/4Auic+7bbeN0+l7av3fk=;
 b=Zz5RC6I9l9cZCdYtCgtA6Die37z9kuhliMEu3XnVasBm9EmASevqSRtL6sOQpGi99UvyzGsGUmRVqEX/uVQoKqifUexWU+Bp2NQ1wG5rh8JOrYHBsXGpaBc8CgjFDOGqIEbqnCbGCPCB8noDnlwEOl0iuXxgXx844REttPtJUqQSSKaH7qMk6eQIVCgX/n2OBF2XKIg5GD6vtA3IB5orDzKPcsuOv4t07CqLbI3YWP0rxDFBoVsrR9nIIs9To6rUl1WeHLNXh5GmPoxuD77rFTGmawRsmqJze4tN5cwxnUT+fbPhuybNPpw9MJGlEfRNuY57uLUnwyjgjqI+LMSNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+mqJJJBeAefnP/OmB2csC/4Auic+7bbeN0+l7av3fk=;
 b=5Cf4iPA3h0x1jVOY8ILqq7CIIuuUyRjkud15ADL5a0kGUBU9dyyNY2L29QT38WU7JWJ/vMh04FSPgEv18l578xrgQ8jI7huzijdToFrhh+OYyXT5gVbhyyXfd/Oaa0DUP2NG4FSqbOWjqzYni3OfRE1LKoXg2/qweHCdyfLBVoM=
Received: from BN0PR07CA0008.namprd07.prod.outlook.com (2603:10b6:408:141::35)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:18:04 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::b3) by BN0PR07CA0008.outlook.office365.com
 (2603:10b6:408:141::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 20:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:18:04 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:18:02 -0600
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
Subject: [PATCH v10 15/24] x86/resctrl: Implement resctrl_arch_config_cntr() to assign a counter with ABMC
Date: Thu, 12 Dec 2024 14:15:18 -0600
Message-ID: <9f74a647d9ff929f040c57e32e253ac824d12086.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 60795b34-a04c-4205-ff3e-08dd1aea1579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9i5hdVEqGNpCv2GkLpzNxqQhLekcoIr88/rO8WqslS/7yvi1NdnGNdDBS6Vy?=
 =?us-ascii?Q?ofywoC6GVbMpJnuFYMWaw3Dg01zIhmixMrxuywcvSW9gz9XvxPcXj80Vb1FV?=
 =?us-ascii?Q?egjMqEOlrU6OKaXYHkydr8IVKHP8KjVeNARe9mYxTiK8zYfzxViX7Fnk5GS9?=
 =?us-ascii?Q?eNkGmJGzreOBDX7KDVN38x0wdtpIZgQylJig79AJ7YNZGmjRvFcetdTdyTEq?=
 =?us-ascii?Q?yCNg2PYnoDgkMs6Eutvj9ZLlHEjqYXavN9kZZ1iPR/8fO4cJNFm1c0scVSuL?=
 =?us-ascii?Q?2z0Lizk0oBUI9VKYi169F7MG3H/vrf8AAUy1RVx2SAnZiQ3HXfOAV0wtPdug?=
 =?us-ascii?Q?/RBVt9duNLC5+yOXM7pJpOcI2+nLjlaWeMM7UmRnphXwJrL8L/+VEDBYPX+D?=
 =?us-ascii?Q?sf7dQAqoxjo/0n55T5Hb+Nh47UQYBcDWK29RQB8MGlIGYDjGKRwTPNLf11Uh?=
 =?us-ascii?Q?+AUxGw7M5RDRqev4oT8n/9zEFsKuVUzYNoro7c/CGth1NbtZcIXAwW+pkTI1?=
 =?us-ascii?Q?tFZHY4GTNufctk9iKbCrFy9oapZjlmKBissyXLeJJ1OvVhDW+RVt+UNxAHiF?=
 =?us-ascii?Q?0M4hmj6PX8zOfX57XzC0jR5E4tplGWo93c92X7xAQvDrXxu8FjMlbg1rV40f?=
 =?us-ascii?Q?4ooBjVorf1UktqcN9MSvjAce89SBnTZ9DXnePLw0XV7ai9R4R/5tQY93IMb+?=
 =?us-ascii?Q?X8yJfMaQDnikwrsC5ZWrAzakNIoZ8zBSaSHuM9gdhXsB0c5zJQ89KxJ2EFtN?=
 =?us-ascii?Q?UX3rjYg260Pmcb3JViPW9OZcMYsyeU+92ln12Pe2FScjKf7JuBi/50rOlsrh?=
 =?us-ascii?Q?MENX5NU39ykDMlKdADq9kP0IVPzFhN4sG/jWkks/D9YCrU3woxbSl8b//Aqu?=
 =?us-ascii?Q?rCQV18ERndqV4F4Jd4jn6bAMWUmDF2KIHBcJmo73gzf8AP1sRWr1VdQ/eav3?=
 =?us-ascii?Q?WJYPfWKPH/2AjaMQpud0lZfp50MX0s9VskU90vmWEoCKX4FdX0n5i0cN2tKw?=
 =?us-ascii?Q?uAPuxEcXP/lUxWspQFcpcsM3MhYu0WGO6Zo8614Wx6T4unaFnQ8p4xsUHjNX?=
 =?us-ascii?Q?VwUcA+D1BfkhigqlbCb1czjTDIW20G7u1/zHkTz5z/YLAn2kNv2bXcK0E8sX?=
 =?us-ascii?Q?WpZLTEHwsJnVE4yiFVaS+OulUOmyQHy9DN83Bm+N68lYj8+8ht9aJgpngiQp?=
 =?us-ascii?Q?mUszQ+291LosoW7aQwaVrv4ATeTBrv5H6vCh4Gv3SEOeue+74lqY3zrKFc3J?=
 =?us-ascii?Q?KhMFKMH5q/Xe3b11tI71esXL3GtnQeGxChs1Ay2gzCOpO3s93ZgrTN77lV9E?=
 =?us-ascii?Q?+wO5BrNG7z2lPHyuVjdVIND9LEBdESLQZA7hIa3wG2c02gNj0Eed/5enQNeU?=
 =?us-ascii?Q?WmRzYmGhYRaWtmrKQf7AauIc88pn8EzuFzy7DqUOzkhjfWZnRYmBtB0+IBxA?=
 =?us-ascii?Q?hMM/eU4IONBuEFtBFCeoD8TzOcxUxRCZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:18:04.0683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60795b34-a04c-4205-ff3e-08dd1aea1579
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID, event pair and monitor the bandwidth as long as it is
assigned. The assigned RMID will be tracked by the hardware until the user
unassigns it manually.

Configure the counters by writing to the L3_QOS_ABMC_CFG MSR and specifying
the counter ID, bandwidth source (RMID), and bandwidth event configuration.

Provide the interface to assign the counter ids to RMID.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Added call resctrl_arch_reset_rmid() to reset the RMID in the domain
     inside IPI call.
     SMP and non-SMP call support is not required in resctrl_arch_config_cntr
     with new domain specific assign approach/data structure.
     Commit message update.

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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 58 ++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 35bcf0e5ba7e..849bcfe4ea5b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -701,5 +701,8 @@ bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
 void arch_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
 unsigned int mon_event_config_index_get(u32 evtid);
+int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			     u32 cntr_id, bool assign);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 72518e0ec2ec..e895d2415f22 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1686,6 +1686,34 @@ unsigned int mon_event_config_index_get(u32 evtid)
 	}
 }
 
+struct cntr_config {
+	struct rdt_resource *r;
+	struct rdt_mon_domain *d;
+	enum resctrl_event_id evtid;
+	u32 rmid;
+	u32 closid;
+	u32 cntr_id;
+	u32 val;
+	bool assign;
+};
+
+static void resctrl_abmc_config_one_amd(void *info)
+{
+	struct cntr_config *config = info;
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+
+	abmc_cfg.split.cfg_en = 1;
+	abmc_cfg.split.cntr_en = config->assign ? 1 : 0;
+	abmc_cfg.split.cntr_id = config->cntr_id;
+	abmc_cfg.split.bw_src = config->rmid;
+	abmc_cfg.split.bw_type = config->val;
+
+	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg.full);
+
+	resctrl_arch_reset_rmid(config->r, config->d, config->closid,
+				config->rmid, config->evtid);
+}
+
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
 	struct rdt_mon_domain *dom;
@@ -1869,6 +1897,36 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+/*
+ * Send an IPI to the domain to assign the counter to RMID, event pair.
+ */
+int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			     u32 cntr_id, bool assign)
+{
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+	struct cntr_config config = { 0 };
+
+	config.r = r;
+	config.d = d;
+	config.evtid = evtid;
+	config.rmid = rmid;
+	config.closid = closid;
+	config.cntr_id = cntr_id;
+
+	/* Update the event configuration from the domain */
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID)
+		config.val = hw_dom->mbm_total_cfg;
+	else
+		config.val = hw_dom->mbm_local_cfg;
+
+	config.assign = assign;
+
+	smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd, &config, 1);
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


