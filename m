Return-Path: <linux-kernel+bounces-188680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176098CE546
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A33A1C21662
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAFB129A6F;
	Fri, 24 May 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nagqZjf5"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2F86277;
	Fri, 24 May 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553524; cv=fail; b=er25AsGSb7l5d3KUx72gr1ZGc+t5ofag4D49mNFx+X/xf5bhf49ztKgyVs8JPnapRhZz/n0bSV4PN2GXZD6Ap5I+GgKCVDuVDlYkEdl/erXKbz1jakG2GcnI+srzZWThrqHR5NrWitEHQm5H4E7eSV2p6OfM30HGFZiK2YzYteg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553524; c=relaxed/simple;
	bh=kTEl5zXRWlHGu4YcHJOXLaYywDBV/fKfz0oVIw7fLSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNiDohefl6tp0gbHdIXkh/gVCo1CypTcSBOlWsYZzVEFSGe8rGEO8+fCsEbO5032qlIOd6yuvOxdsOQNrylFAiGXQadUvn7mGtyDFp/8w0hR3fwud6cfyZt4hu1QZJv2rYz+Ok7/C7/1HCVZB+7+cQ8IDPAJ7G58AbFN5SiNLzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nagqZjf5; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSodj/9G6ixez9lMBYq86zPQ/K8kSDO4MiOfDs8JynX+0P41NPHAOtX25SFtZGC6yNTokYdPBcnSPne5bcbFjNmXkOK/UMH8awaf4O5KsLOTp19n4oFqXciO3Ygj2ujGiMfo50azi5NFKH/Z+ua7pWEOe2piPLb5yIlxQqv65Ps+FxqhA32j6hAtL5CgPEKN/L0+RLl/kmhQcLW/qywlhTqBuxw4OuhTYMWHlgCOS0hcVdG152V+b7lyLjNH/l0JxzuIqixHA9qixHjanrbCiClktmH0aswJ1GXyU6pjvll7ZJjOXgTc2QGTH/eHhYLTzGzQxx3efH1ZuEIp/dKnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b7aT/Nuc/6Ii4sNretzJt+OqoFeqPhZYwGxGuDu1fI=;
 b=iWSHsqvpdcOpiSOYqNQAE2/tivoZ3gGkjgHxhGH2NcjNTxCyUJLzKcwaKpkub3zGbrzcLBAKQwMdhZrjADXhYg8cYP5A4HhC6p6P+MS5f2JVHpqezubaR0mRIeS3v2lYNY0yltxvjyfOoHalwAgSsIOqxS6HyJqbNJZkBpYlSAnCEcNlZTMBByXKKtY5dwChX7jVa41E9DKMWJElkgTDdC4k2Ewbd2x97NgmUkxijLLvMB5nrH6+QyQCTWtTjd3ykDKnHcx3WsAS1+laM78fYH4/sQTAIe/egxAjrzMdLkr3ZVv9pQfkfPQPzHUp7zBsf00h+WZCdur6UZ1c5QiDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b7aT/Nuc/6Ii4sNretzJt+OqoFeqPhZYwGxGuDu1fI=;
 b=nagqZjf5C1b5dtaKeUujz69oO3vqyAoYLEs2N9Tdieh+Zpr7HwmKt5hP0nNRmkb4HuHIHhiYQWQJHtp5NS2jwQcVa8T3d18YRA+MdepSOy1R4jFF0ydnYB6McV0/efkhOCTnL+t+a06Ok2F1Hleruor6RYcgKXGSGXwyv3TabXQ=
Received: from BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21) by
 CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.26; Fri, 24 May 2024 12:25:19 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::cf) by BYAPR01CA0044.outlook.office365.com
 (2603:10b6:a03:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 12:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:25:18 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:25:16 -0500
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
Subject: [PATCH v4 11/19] x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
Date: Fri, 24 May 2024 07:23:30 -0500
Message-ID: <a02dd2b9fa06f360eabe923c5c6d17fa4036aa9a.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3f9ec1-2e2b-4199-565d-08dc7bec9313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v9+ZCVwVBs2pT8wBEQJMTosFz73Fy93WTx+YHRyPAefqbPze4j7LoRnaTTVl?=
 =?us-ascii?Q?R+5GGx81qQE9aKHhjhV/G9PIbcbDKTrfZq22wAnVvVvs6mcOgkMu3pYYEyUo?=
 =?us-ascii?Q?t7+uzKl6aorEJO4eR1BZ1bZGjJcXCvkw36pzxWbp8IgOurS7czC+3RV+0c1n?=
 =?us-ascii?Q?KzcVHODRb6AabxV4I5sg5CP167TkAmpdowtFBFGG4JUO8+550oCvC7yAmSA7?=
 =?us-ascii?Q?N7RQ2UgTuxe3sMemJuKT3OBQGknyDmvp86eGnlu1/7j/T7+8TzVWo7W3yTiz?=
 =?us-ascii?Q?c6H1lW0AF0TlSFWuM+coS82UKi7R7Swtbm/cdCcj3y2CibH2euTUA9HmSBDm?=
 =?us-ascii?Q?F3npZKIutPDJ29y3sc90G9tVu0lsiRGuY6kh/9MV/gI1oxUNSXVjF/umIIk4?=
 =?us-ascii?Q?7zP/lgEsEPKYfsm5IW8zqdWFz1+YtVB5ncaO4Erw61qONqehWBmSLYfnRbvJ?=
 =?us-ascii?Q?pYWcqSn+dQFyZvotG+ZxpUeGWH182TLoo7/UP7fK6e0Xc9chDsCZOcoWZoiq?=
 =?us-ascii?Q?V6ydqcQMzCdvoY1NSQuOknzP4+5vi3df4OQLP9PPCya1LT47MmKBWVwLnL4M?=
 =?us-ascii?Q?H3+2sOYbtMv+kCmwQiM618ZvEGq3/hClLGlltF7a4EG1S/tH/7leOt3uw6rw?=
 =?us-ascii?Q?sWsbFU7WbZ0hssxt/V/VpoIF2fb91dcDTMkO2kY7T6OOZAjDFnshy3+dqeoN?=
 =?us-ascii?Q?T2X235vkao3+ZRgOQ990p38RomD2o9KU1YoXeHiEMRehfjif16bJE6CsaDC1?=
 =?us-ascii?Q?39JM5qds+1Ll6qSf7kk7hjsWKEyYhJFYGxY6aLh4izT/r3oJZQmPJcjH4EMq?=
 =?us-ascii?Q?MjIDgNFUvYQbI4KD9wBqA2RdxdCinzQosOeBKHHmZz9uy/CqEfPis9oRA2nb?=
 =?us-ascii?Q?Wf4juXUp+dYEIeI52vS6flybDjumnqH1w0/C5fcidO3qD9NNUTxlxSxq2868?=
 =?us-ascii?Q?aJmZobkMwNGXgw9PgjVKNG6YiFdufUCu6A1FCpt302kBstXNHKqJ3lPGMrGL?=
 =?us-ascii?Q?fb0EDO+Jic/RFEOHOKNhz3pt6tF1ZYAOFW+teQ+eQN8qJqllMbLBqLWHg2rQ?=
 =?us-ascii?Q?KpcTDJMNUtE0IoliSMYWcTjrTit1QLXaebm9q1XNYavic2DK+ftcC9Panrcz?=
 =?us-ascii?Q?kQLA5t0WbxCaY+vXMnrWtwefTeK6zs/vkIQTAlEiPoC4Vs0hhGWjdlF8AluG?=
 =?us-ascii?Q?90lKN1mPpFjzDXpQIgaBLXwLbHDT1LKtu8+nJsJU81I2HlRmltBjhybs1Vqj?=
 =?us-ascii?Q?VjAQSLQqviBhYL9yC3TPNmK2MY7Rq8Tzq/+VIIXDVwM8+Hj7lB0lym+iHlCa?=
 =?us-ascii?Q?IJ5o+5KfJkcpI+B0rhAujL2uaRQ/ZLEL5pX3dISRr6YnfDAHJYz/rS8ioSrM?=
 =?us-ascii?Q?olHyx8A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:25:18.7440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3f9ec1-2e2b-4199-565d-08dc7bec9313
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085

If the BMEC (Bandwidth Monitoring Event Configuration) feature is
supported, the bandwidth events can be configured to track specific
events. The event configuration is domain specific. ABMC (Assignable
Bandwidth Monitoring Counters) feature needs event configuration
information to assign hardware counter to an RMID. Event configurations
are not stored in resctrl but instead always read from or written to
hardware directly when prompted by user space.

Read the event configuration from the hardware during the domain
initialization. Save the configuration information in the rdt_hw_domain,
so it can be used for counter assignment.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: Read the configuration information from the hardware to initialize.
    Added few commit messages.
    Fixed the tab spaces.

v3: Minor changes related to rebase in mbm_config_write_domain.

v2: No changes.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
 arch/x86/kernel/cpu/resctrl/internal.h |  5 +++++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index ec93f6a50308..856c46d12177 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -542,6 +542,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
+	arch_domain_mbm_evt_config(hw_dom);
+
 	list_add_tail_rcu(&d->list, add_pos);
 
 	err = resctrl_online_domain(r, d);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5e7e76cd512f..60a1ca0a11a7 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -373,6 +373,8 @@ struct arch_mbm_state {
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
  * @arch_mbm_total:	arch private state for MBM total bandwidth
  * @arch_mbm_local:	arch private state for MBM local bandwidth
+ * @mbm_total_cfg:	MBM total bandwidth configuration
+ * @mbm_local_cfg:	MBM local bandwidth configuration
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
@@ -381,6 +383,8 @@ struct rdt_hw_domain {
 	u32				*ctrl_val;
 	struct arch_mbm_state		*arch_mbm_total;
 	struct arch_mbm_state		*arch_mbm_local;
+	u32				mbm_total_cfg;
+	u32				mbm_local_cfg;
 };
 
 static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
@@ -622,6 +626,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
+void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index b1d002e5e93d..ab0f4bb49bd9 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1093,6 +1093,27 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
 
+void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom)
+{
+	u64 msrval;
+
+	/*
+	 * Read the configuration registers QOS_EVT_CFG_n, where <n> is
+	 * the BMEC event number (EvtID).
+	 * 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
+	 * 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
+	 */
+	if (mbm_total_event.configurable) {
+		rdmsrl(MSR_IA32_EVT_CFG_BASE, msrval);
+		hw_dom->mbm_total_cfg = msrval & MAX_EVT_CONFIG_BITS;
+	}
+
+	if (mbm_local_event.configurable) {
+		rdmsrl(MSR_IA32_EVT_CFG_BASE + 1, msrval);
+		hw_dom->mbm_local_cfg = msrval & MAX_EVT_CONFIG_BITS;
+	}
+}
+
 void __exit rdt_put_mon_l3_config(void)
 {
 	dom_data_exit();
-- 
2.34.1


