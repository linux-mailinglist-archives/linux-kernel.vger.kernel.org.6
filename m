Return-Path: <linux-kernel+bounces-290032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DDD954E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4DA1F219B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFCD1BE85C;
	Fri, 16 Aug 2024 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d6ObeCl7"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7E1BD51F;
	Fri, 16 Aug 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825032; cv=fail; b=FwhrRbokf7cPKzzdHIjWUq2yHuxc0QbFSmIpVPj0RM2of/6bS5WwP6CohvulXghXKDEWsERQYFWtaPMSpoK1cr75zmKLr052+ZaOQ85KK8kkLabf7MhD4w9xiHaRSfMYvWMvpw8qmzMndL7vSkvQ0tTRzRNyv6YdIymujxHWObg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825032; c=relaxed/simple;
	bh=fiDjUVQP5D95p9Cd15KPz+Oy1LhFrHPY3ujs4LkuniE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAYA0YM9sCPNRhxmeG5tbVTv85YlcEE2vgbCGCP+ALDtyPkDPB+axsGn+kO2cwrgSsUPOzpJpNsWOSj04iMdSMBD40TId55VHqhs7LMwTp0Ff5WLbxc+/a+mCfYdl2lVcAKNPW1/DqZ0FxL6ftwgHEautHTmw9S3Oj0reuCS+lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d6ObeCl7; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+MoCfibByellkXg737K85fXPm8AOKT03R88M5s5qgFC7d/gkPRXo8xBi6Zr7vpI7BBLn6tiWEVuk1N5/P6OyTwz+02TtukW9VwNCrL3ooL1LVG0ocvhGRnZS+FMoXfsHcIm/S98NaRMsejxfgVRox3HHaDQvkI7QEqFfnwR/l3BJUnHlqaTGLAUJQ+KOWvPP1pypQqFtxYP/jI7P5mp6rOlXqpZJjeD0fqVXVxce9BNNjd3ezESdM9vMjHf56DHi/nyKDtOnZPb3oDTg9EXcR0+PIvFV843jvwbFY6kMkKaz6yKLlYtmP/afy3z8U8sH0xkuUkWCIt3FTp/qGByzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLYIHgOsw9hezXg+eSeMu2BKsUQri3216RRa0Kp6YSg=;
 b=WnCQh0muma9yoMuGYRXDr8uQMw6UI77KMOSgjuGmCnZ19XLnm2M8CJ84PAnDo8anP4Z75hjfUxnuBqMWCEoIvAIPYAB60FtQwCv8xjpmMaYyc/MnmLWykvjJKvijgNhD5YZb1qZl5hojyR0uzu8v+0HxTelvTqyYEeRRhCLqwgm+dBwSSC3qUjUUm5CCexZvqkJTmVFdIY5+6EQi0J4Y6bkucf7dS5KYIEdQqlplXk0snoLv5MT/pQ6brAy/d04v3TzLfPISYLieiubCR3jgbwApA68FAGJmFBeQqK5KoZ0xUT7pCKOm2dccc7heMT11albU//PSI6wD1U5bbxU2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLYIHgOsw9hezXg+eSeMu2BKsUQri3216RRa0Kp6YSg=;
 b=d6ObeCl7au9y0Z8XNpmPhBHEOgGmMeSNrydEcqT3wtN8PSHVEY8g+AFYuxGF1pXeR/ncQaUjeCvofdo3EA+39qM3pomAQCgu/RQ516O7FYzRIEmQOAx4QFzrVkOleO7+r5Q0/83Nav62Ox3FDCybnjJPJ2iCWtvum5YzZxg9/s8=
Received: from BY3PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:217::15)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 16:17:06 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::7c) by BY3PR04CA0010.outlook.office365.com
 (2603:10b6:a03:217::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 16:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 16:17:04 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 11:17:00 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<babu.moger@amd.com>, <ebiggers@google.com>, <alexandre.chartre@oracle.com>,
	<perry.yuan@amd.com>, <tan.shaopeng@fujitsu.com>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH 4/7] x86/resctrl: Implement SDCIAE enable/disable
Date: Fri, 16 Aug 2024 11:16:21 -0500
Message-ID: <d40df35b8f25b1ce009863da5b53f43640fb426d.1723824984.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723824984.git.babu.moger@amd.com>
References: <cover.1723824984.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e8f644-154b-4ce4-f6f1-08dcbe0ede3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l4TtRW9vjE3GnyvRO87hDbEGC/pLj82JJTMZFtHPiFKSJjFiGPLQZB7IhPNs?=
 =?us-ascii?Q?HXwhX3SIbbfNQY23SPHYdyAhzkJIA4jK+Q3gyYCRl0dbiBaUH+RSkZJzY7sy?=
 =?us-ascii?Q?tqrWDKcx+jO5xjOew1LKKmxql7zTslbGjEZDCWrb2yI3JuAOipS8jfWDNIXO?=
 =?us-ascii?Q?kWoYUB7/s9/sTa5qZvf+sIahxS9iOZRO6Iy6JXOZ0izJbHgAPEt3jEAzOH+Q?=
 =?us-ascii?Q?MWg/qIdN63T+YK6D1cQUy+KJgwbGb5eaPuVkEYwCFsb3dl5Nye/f1tcCpJEy?=
 =?us-ascii?Q?lxxXFweO0kkvDsB2Hn3XTwy7fA19ZLUQCm+JyZ6h0EmXskp9FW8xpSS/EDon?=
 =?us-ascii?Q?tbPCKVngm79KPacQfkculLu/hBbd+jEPHe33G8WqEuOjoTjbN4oSt8GD+4Sb?=
 =?us-ascii?Q?z+OPAmaTlu2Sp0PE1qoMXnRQsjjHghcP56vvnE738xVZv7f31oq4ZchjUSDJ?=
 =?us-ascii?Q?wX2GLYNrJJafJkjEw+xntniQ6kdFez/IMN5OXYZNW7srVDfoSYtqnXIVkwB5?=
 =?us-ascii?Q?SysOsB7RJDrQJcQAzZl8jl91/5od1BvwPiqbv2NfVUrtWFQD73C5E+TunFZf?=
 =?us-ascii?Q?F+7ZpyeXCVcQo8fDLPmMq8EwYH34j4G+sYKNB6twokINMXOGe8NUPE0JnU1/?=
 =?us-ascii?Q?pnZ98rsYC3nCjV2QVPL4YRTBwK/H1VAI7ZLZsQ4CJ6dZ5FlSa/bhKjt70HRi?=
 =?us-ascii?Q?T//ebBgKLgFlslcOVTMwcVH8RfJLT1eGmOxgPKJ7M6GJlbhqfVIpnS3sVqYI?=
 =?us-ascii?Q?CM8U1aaBBtptcf1kUP6MOgEhY0c4evC9QdacY7vNZ3QaKPLjfFsw/5CguCOr?=
 =?us-ascii?Q?ebhQLDHkJlwwH6ZadlIK0wpxK8c5cKYNqMlP8uRKS47qZNXaeY4KvacfDZtf?=
 =?us-ascii?Q?ybX6BTs9jUKtmiIa16UKrVCmhCBreeRqOD7fDRJH5OxvTAWEsIGoc0JXuATS?=
 =?us-ascii?Q?zzLzZit+85tENhP0whSBGVvfUF36cEw63rAb++3jcUWwjRSxQhx5Sj/w/5YG?=
 =?us-ascii?Q?ANkV2w/nzmqivzyUkx0U9s4oaw+753vJUt/UqQ6YbgPVEbvnO0fG1vz3o2Hq?=
 =?us-ascii?Q?tqVR9jc6nrkaHVLmq/Tgt2lhBCz3aDkGglhEU3UMEymTOcoHGDoQgCcfcy5J?=
 =?us-ascii?Q?efaDGY5c0WbCxW5dHgja24UklOMz0tp0ahVmZP5cfAiNfs55/a59j8xCIjw5?=
 =?us-ascii?Q?NTYVey3rT1jH0FP0wJWiLFKgaM92SHtgSH5LHROsZK/vm5Vd7eh4Od8Rs9rC?=
 =?us-ascii?Q?xRVE6YsbJ33qpCSQLf2qi9O5d3HdMacsAdpjHoWW9+oS6SU/9tHl2RJLlHG0?=
 =?us-ascii?Q?Wy4fA9Xdr4tVamFCIBuR6C+U6067ZZEfpJtVOGCOGcyrwrsd9+0n0QzmXeko?=
 =?us-ascii?Q?TXilKYH3INndHGmiMQLK+A40W+NxXtfFSccO229pqT7NlqaCOeSlhq6bBCoH?=
 =?us-ascii?Q?Y7HbzvhAEx/VNbLHVDpwF8e4l+MmEsWA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 16:17:04.5431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e8f644-154b-4ce4-f6f1-08dcbe0ede3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610

SDCIAE feature can be enabled by setting bit 1 in MSR L3_QOS_EXT_CFG.
When the state of SDCIAE is changed, it must be changed to the updated
value on all logical processors in the QOS Domain. By default, the SDCIAE
feature is disabled.

Introduce arch handlers to detect and enable/disable the feature.

The SDCIAE feature details are available in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
Injection Allocation Enforcement (SDCIAE)

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h | 12 +++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 ++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 82c6a4d350e0..c78afed3c21f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1181,6 +1181,7 @@
 /* - AMD: */
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
+#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 
 /* MSR_IA32_VMX_MISC bits */
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 955999aecfca..ceb0e8e1ed76 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -56,6 +56,9 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
+/* Setting bit 1 in L3_QOS_EXT_CFG enables the SDCIAE feature. */
+#define SDCIAE_ENABLE_BIT		1
+
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
@@ -477,6 +480,7 @@ struct rdt_parse_data {
  * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
  *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_enabled:	CDP state of this resource
+ * @sdciae_enabled:	SDCIAE feature is enabled
  *
  * Members of this structure are either private to the architecture
  * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
@@ -491,6 +495,7 @@ struct rdt_hw_resource {
 	unsigned int		mbm_width;
 	unsigned int		mbm_cfg_mask;
 	bool			cdp_enabled;
+	bool			sdciae_enabled;
 };
 
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
@@ -536,6 +541,13 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 
 void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
 
+static inline bool resctrl_arch_get_sdciae_enabled(enum resctrl_res_level l)
+{
+	return rdt_resources_all[l].sdciae_enabled;
+}
+
+int resctrl_arch_set_sdciae_enabled(enum resctrl_res_level l, bool enable);
+
 /*
  * To return the common struct rdt_resource, which is contained in struct
  * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d7163b764c62..c62d6183bfe4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1789,6 +1789,67 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static void resctrl_sdciae_msrwrite(void *arg)
+{
+	bool *enable = arg;
+
+	if (*enable)
+		msr_set_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
+	else
+		msr_clear_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
+}
+
+static int resctrl_sdciae_setup(enum resctrl_res_level l, bool enable)
+{
+	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
+	struct rdt_ctrl_domain *d;
+
+	/* Update  L3_QOS_EXT_CFG MSR on all the CPUs in all domains*/
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list)
+		on_each_cpu_mask(&d->hdr.cpu_mask, resctrl_sdciae_msrwrite, &enable, 1);
+
+	return 0;
+}
+
+static int resctrl_sdciae_enable(enum resctrl_res_level l)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
+	int ret = 0;
+
+	if (!hw_res->sdciae_enabled) {
+		ret = resctrl_sdciae_setup(l, true);
+		if (!ret)
+			hw_res->sdciae_enabled = true;
+	}
+
+	return ret;
+}
+
+static void resctrl_sdciae_disable(enum resctrl_res_level l)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
+
+	if (hw_res->sdciae_enabled) {
+		resctrl_sdciae_setup(l, false);
+		hw_res->sdciae_enabled = false;
+	}
+}
+
+int resctrl_arch_set_sdciae_enabled(enum resctrl_res_level l, bool enable)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
+
+	if (!hw_res->r_resctrl.sdciae_capable)
+		return -EINVAL;
+
+	if (enable)
+		return resctrl_sdciae_enable(l);
+
+	resctrl_sdciae_disable(l);
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


