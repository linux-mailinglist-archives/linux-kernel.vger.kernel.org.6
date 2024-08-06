Return-Path: <linux-kernel+bounces-276986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D28CF949AC5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622261F212C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF46172BDC;
	Tue,  6 Aug 2024 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OSmjLn4V"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C87178367;
	Tue,  6 Aug 2024 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981703; cv=fail; b=CVhyx9l/QYLllfkLr0hB+wRsIhR1QZLIZFAdnrwDRK4IFq7384eJdmVG16LTrrOB0G9eNTvJvBs/7c8J99bhtlwW9rYwxsRNkSJrl/fo6GP37ggSEB4IT/wcdL1WwzkUnlEboBGIHIFU3zvZfpVQMqbkdYQ0nfdX/tub+pWaGOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981703; c=relaxed/simple;
	bh=NbWIzbzE7s6Ri7XnZW7Wz9oCJKnn1mutWo0j/dJWHqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1FUiJHI7zUKQuO9J9KSfjgiB8RVwWg5fH9MI1ObIHkIiq8cF8nekGd8uBfOoQB6KwsrgjIV7H4eJ2kSac0ZuvIPbsYdEW/iQuaCihpYKRY91hgU3yGaaezCz9JSzQNQlCf7waHHijDorSsipRiQDozz40kVbv82D/2AEijmH1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OSmjLn4V; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAhO3e569JstEADeFiHLnxH+yJJCiq4JxjSWGoRS1lRZN/WQ+CcbaY0fBvfX841wlv2AMht4X6ziGVkLPAHJAa4oFIM35uR/k1f5trlt3bmszpS/I8DO1J1CTLyhkvcUoImfJyYYgOUckOVqx//nr7P+cwwecBBkdzSAXrDly5w3p7709mjTpcTOMHgtEKYUeQoiEHOxVHvRMVOQjemFX613hdhoGzFOiunT+Y1iAiW0BBJWAJQjBhMdgDH25tslFY1rDTQhhi+WP0W2Zl5UGEG6PXxaavvzEFVKwAMKui4JUzgR03zzwFnNU4RJvbp/m9zdV4U4KZ5DBKF3/UkKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhTYqUjgl3D1Z1jkJ56yVXOi4cxSBL1VgteBFkxvQXM=;
 b=Uv2kRhrIgICjvJin4SKzoNd5pzUucsQpKhiFI5ck42qDYzY/Mgxkj/GvKjTUIYdbjaF2AOQ/UI0fbAlp+GIpxvWKDpeWSeFFdjiTtamaZtaCGRXx1GviDeX+7YhE4ueTlWAXd+74Bnq/H8EFSGdkDacA/PRJyaWqDdXfLVN+6cTb6KgMdDjP4rlnn5WkZlta+p/bh1HGkq7LbCzT6MiJwNOy12p2r7rVodC0H1/mBl/FYBs4gmoBhuDUqxh3OdgWC/aHayPldTXH7WoodTc6yw3Sf7OynaMPUeGn/XKw5WIRLFhpczQf2ay9L7IrQUtXjzLKQRszfm8006eKU64+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhTYqUjgl3D1Z1jkJ56yVXOi4cxSBL1VgteBFkxvQXM=;
 b=OSmjLn4VF9m8dcmfz5x1cITc+R+C+40DXWkyP9/pAWjiTwc5vEiWMqLybUvevKYPSa1TCmN5zPTuZjgP7HPPqzMBZ6ybqrX0T3iUQyFBJsAAoKb5FIWsn+hNwt+VYyzVM2ArhXeGyi8Ich9q8vWMqLd9R2vSMU2cW0nc+E/uZXs=
Received: from SN6PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:805:106::14) by SJ1PR12MB6147.namprd12.prod.outlook.com
 (2603:10b6:a03:45a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 22:01:37 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::79) by SN6PR2101CA0004.outlook.office365.com
 (2603:10b6:805:106::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Tue, 6 Aug 2024 22:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:01:37 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:01:35 -0500
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
Subject: [PATCH v6 04/22] x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
Date: Tue, 6 Aug 2024 17:00:41 -0500
Message-ID: <851bfbee0fd53631acae8d209796d52ce8051e68.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: c34da4bb-1c46-422a-e48f-08dcb66357f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IWT+Xz3H06ov8zxVoDOcLYUONg/NjpNIiKPCC37qS5jsUdD0uMwSN1Mq5CaE?=
 =?us-ascii?Q?sJxHyCHz0tkN680jF4xuh/w3CVVNtOQJDtRq+mnyDwGTRMNBLzyjL//ptr3d?=
 =?us-ascii?Q?6kBqS/f9KgvKT17THXj2XJxJE1vCT/biIqyC1U7E154On0WUEzhGqrboxko0?=
 =?us-ascii?Q?UNd7mIXTxHPyzpw6qL2ksYKIluBIK3UWPds6HzrqlX8qwFzkZA5Cj8hYtal6?=
 =?us-ascii?Q?W/GgFI2XM8LzbuNpcXNYhq632bpiFGmU95DAnxDLFLaWs0FVnjCnTGrtll/d?=
 =?us-ascii?Q?JZ/xmxAm7L3TwMIhOIhZTmJfmZadX1fJPP2rHpkfqCtrZOcdCkZdPhsEZNHn?=
 =?us-ascii?Q?uPPxxUA0K5xPRggFqZJ2G0fnyQxaFxIDeM+7aLmiX2Sks9QS/9EanRm+xcI6?=
 =?us-ascii?Q?ZzZaZ4Kx6diUyS2X61GEi9IxBBVdRLpm5qTE9MggAqqtO7Ws+DSpn993lBwW?=
 =?us-ascii?Q?JJgZsq91DXEzQa3pnMBy+T+Nv8eQ6ktonmPwJrpDFJqyg4d8Fnsu7hZLv5S/?=
 =?us-ascii?Q?WFgIRt80iSI/vCr/titG3w2Iu6mKj/mv4YfMOG4sfK5zdATHvcJBQhXpgJas?=
 =?us-ascii?Q?ftFPE0L5Cs0GrmxMbWeX39dptY1t6Zxru3Zb41bPkhoy9U0177uB25mFYX/e?=
 =?us-ascii?Q?f/uClLBAbhEG4vtft1au2PDuTPIal3SaWa4ovSex0zwe8QsfLqqGR8pmQSkw?=
 =?us-ascii?Q?vGlzxlRCQedoFikL4qYwcMLE9H6Es3ApfFzVwbvoEEw3xrwdhHRsMShC+lYQ?=
 =?us-ascii?Q?porsF/t1CbV7gQq0XzNx9Sdcv3VaIEeJ91GhYOeg9AZQygRSV2mTci/q753n?=
 =?us-ascii?Q?Lsf/MjAk/8B/+RFCPTuHVzZXUZv4rdQzobl62mXtSW230CPLP6KhklSE9GGv?=
 =?us-ascii?Q?RRg4IrpWI25cRncH7q79+lGz3R0FDbwsyg7SzYLuyp4oDFoSdqH5KHtDze++?=
 =?us-ascii?Q?Mqe96cMi+kgV70Sg3KeSISaYhNincycf5JrdFblrxQLB/VO1HFYgBDEnr3XX?=
 =?us-ascii?Q?0bMXkE/YFmIjyDUCWIg2G1i4ltVvrijuW0wn+cR3mofWaJvEvHcTzQ83aSwd?=
 =?us-ascii?Q?Qzhtpz9WMCUVelJqbxxxk99mq6peSFTBovImJZqWFtv/cdTekV7I8cd0NvuD?=
 =?us-ascii?Q?BTl/dBRiSRbChc6yU5AlFC8Qd9veHD2k43vjgNcgww9VTxHNkXTU2VDBjxTp?=
 =?us-ascii?Q?wZa3cxkL8mj4RRfH4VN8ve+kaW2WRlMIU4BCmGRbHF5QR5BhdiqJxm7HmQ1y?=
 =?us-ascii?Q?Ks3jdUixc3Fz9uBqqiK7aYg6mYYeZkGPnrZriDpAnvrZmfm8WjIXL+ZDBMJY?=
 =?us-ascii?Q?2IcOfYN9KMcCaXKHWQ2RbPyE4oB4c0D9XE/xWzy2u64vphoxpx9Ejs527boK?=
 =?us-ascii?Q?EOnxO/g4bSo1yLrMGsFJcWtCZvxuDZZKsTNIrn561EfJiZUBjw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:01:37.2867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c34da4bb-1c46-422a-e48f-08dcb66357f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Detect the feature and number of assignable counters supported.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 arch/x86/kernel/cpu/resctrl/monitor.c | 12 ++++++++++++
 include/linux/resctrl.h               |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 795fe91a8feb..88312b5f0069 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1229,6 +1229,18 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			mbm_local_event.configurable = true;
 			mbm_config_rftype_init("mbm_local_bytes_config");
 		}
+
+		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+			r->mon.mbm_cntr_assignable = true;
+			/*
+			 * Query CPUID_Fn80000020_EBX_x05 for number of
+			 * ABMC counters.
+			 */
+			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
+			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
+			if (WARN_ON(r->mon.num_mbm_cntrs > 64))
+				r->mon.num_mbm_cntrs = 64;
+		}
 	}
 
 	l3_mon_evt_init(r);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 1097559f4987..72c498deeb5e 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -185,10 +185,14 @@ enum resctrl_scope {
 /**
  * struct resctrl_mon - Monitoring related data
  * @num_rmid:		Number of RMIDs available
+ * @num_mbm_cntrs:	Number of monitoring counters
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


