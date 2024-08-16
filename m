Return-Path: <linux-kernel+bounces-290034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B809D954EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBAF1C217B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D71C2307;
	Fri, 16 Aug 2024 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pQ9ZM2ox"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C71BF32F;
	Fri, 16 Aug 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825040; cv=fail; b=hYN/4fDzzANwy3GQBnWFfWrHMe85yldyqmqKBiaOwN6+6mq0KnTE8AbZFWeNR7Zi1/UzJz9940A3jSbn8JwxR176oGZbaD+Wsy3NppH6wpKNJkrFVUGYI7UUsldaiRKAkPgmaFMrlY15Hz4aKQykgpEQLrduK+AkKICN6YPoWKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825040; c=relaxed/simple;
	bh=UsF1pKmscS63sIpNN8ejMkwiYrRe7qJploSW1IY6VMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=am1sEhYiXoUuVHwyjxF4Z17RB3rcCd+Ju/aKl0hvplODUNideQGUMQ99GmydGUGj5adrqiiR9kjRPyKNyWcoqXdY7TZmAiSGif8TlP2CTblbpWGjnoD8VJYHcnJ7iIfN94EGH+/U8xkqKrpSkHrfcBnc4lsSjZqTB2ecLt6fUqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pQ9ZM2ox; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8pbu7NZ1Ph3csrn7NmxTBtGZlGOPbU2c9Y82t8lDOaRFvpRE0pElqizQ5y8/QE/+T1iXkHSmlcK5/Hi6scZkcpsPd34ZwIo2N4q1Qe/lecXsw7ulJ6NMSYuDyxRt5/vruxrV5JOb/fmTK7xusYCyCzMl2Omk50ConHwaclzCokMuhODCEZlDbJVbttOdj6j+rtURzvfqDhrrsKzhl2fWc7D05CezyXYKfLUvkO2R5mFwtjfEIGM9Ga/35lupCpQY2TwdEyVOgMoVb4N8LGTykqhLaP24bxZo1hZ1aL/7Z0H6D8tpZi2YMZavNViio0dVROlgm4OLmb9nRoCfvXFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBgL3p/4gQe8lophFKdZFQjZg1gmBiYmEMuZ0MDaj+I=;
 b=a/Amg6ydzJkbuya2w+jcdI6/RjjUz903TyMI7OGqxmh9dNEt3lXEOk6y0ThJ3D3ndpDOFOGAC5mB1LCJNFZdk0KW/remWoEOfbC5/3Z4XxN2OXwPhZrHZJzs91Cl+KUDAqX5c8Wsb6hGMq+iPfBYZ1vdUmGShpEiIH/0gqUxN3gVlQ9f5WQIQNA6MiAKqysQiLWtWRrtB0U+RWH4/EI92hUvfBc6+HYqMWXqOJh6FscD4XpMGxj3ZHW+nDDQQG2JrWSRg/xjNMvSDC3IjmRxjcQztmUj5Mh55Ysubb7VbxFYcnhANaYutZxU05GMHKshLG76v5LljJ1jxIXjzst+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBgL3p/4gQe8lophFKdZFQjZg1gmBiYmEMuZ0MDaj+I=;
 b=pQ9ZM2oxxhh781uDZk+6eucrs15Gtc6d+PPPrYguiGbH6JtAXJ4Dt8Gzpkw5mvJ+WQBXIgYNpcSh/MTcC+q2DexoiH4fWhcxCxMiqTrgpttAHWpKlUC0u3oE90Ip5iwG4RmMlbzZGx5u9+31lYvQVJ55rtSzAtvnGe4pXNgMJnc=
Received: from MW4PR04CA0378.namprd04.prod.outlook.com (2603:10b6:303:81::23)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 16:17:10 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::3f) by MW4PR04CA0378.outlook.office365.com
 (2603:10b6:303:81::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Fri, 16 Aug 2024 16:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 16:17:09 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 11:17:07 -0500
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
Subject: [PATCH 5/7] x86/resctrl: Add interface to enable/disable SDCIAE
Date: Fri, 16 Aug 2024 11:16:22 -0500
Message-ID: <e43947374dd9124ef5a6c677d0ec3ab715b6a7e7.1723824984.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd2f6fa-c09e-4abe-75dc-08dcbe0ee16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CcwuZrjLZi0qBU+cHsgPuzfk5G39CDtC9nxvtKwZx7JF6LNU3LtMeIhgvId/?=
 =?us-ascii?Q?DTUQYUVZgtqwEoJ6RCMq1sJXqM8Fd8OIcl5lTWA0nONMdJPjglqSsoxxrflG?=
 =?us-ascii?Q?ERkUvzp+LiKcVig1wizVOCPvoLbVNMNMNf61Yq/oR5AdDAImwUJyrfSQIiGt?=
 =?us-ascii?Q?9Y9nQCoDrtqffwvOJkhHR9F0k7V4ZH4RjpI48aMHb3oN5AMK5yiSaYdkinLn?=
 =?us-ascii?Q?bxH8lieeUlmjl6o4ceWlu+dJfmL344hJFKESmRX+ncWvTZslOB+JfIdz7XJN?=
 =?us-ascii?Q?Nmj1Y4czuIKFwFgdWma2wF/ZjZfDRxyhcy3hCaywlSs/TOXxF9IbuudNnlmU?=
 =?us-ascii?Q?tWL2X7KViSlqDeWOZ30XYwT9m2RNtpvVV6qR1VE5OH+AJuN6HDfrcAx4Xkfc?=
 =?us-ascii?Q?hqWQ4Zz+aaLGSwCxUAgpaO6QURootVS9JL5FgGzz7aJGfEuzr33KSh99PMzn?=
 =?us-ascii?Q?Xx7NG2Ipd8Sd88PyXPjWXdWTycEiQJruBXaO//uIldmNBqSbOqqTRJVKV8A+?=
 =?us-ascii?Q?7+9m64Dvh478xAtpnfJo15bwzt/fXjWpnl8z2ZKsOUznnwbKhtshW93njvbD?=
 =?us-ascii?Q?gPcSIMyEoAvKJpwBuejn8iN7SqdyC8CaAMG6FFCJn5ZM+Q8Fd9wqtCWD9uQc?=
 =?us-ascii?Q?UzTWn5ouv4sXLWQ8IMy+6uysQP1rNFU5sAx0dLp/UA9fJnPcF+5CB9yskPqV?=
 =?us-ascii?Q?FmGde3ZRSWsEkwGAzuR23U0Fs9Mez7nEr130no8W9uAP9Fxy0nSDvvgmS/8F?=
 =?us-ascii?Q?TIhFMzYr3uOTl5iQewppzeyopTES05m6ZrpLQB71NmTSFKajWt+rcI8ksiE7?=
 =?us-ascii?Q?C6zFGu6zpnQPncn1kxZS2M6wt/cmRXgAytyRgcnH7vsa5kU2M8KwWLb7osXs?=
 =?us-ascii?Q?74XEdNVdsVv/8L8O0MRheEcL2aYOlnz/HsBfc5ozxzs98KuohS8xOXhZws6G?=
 =?us-ascii?Q?d3euZ0Tfi6/ct+WDXlsLRMZg5aHYZ5/ZOxdALxvxdMerYMBYEvrlCI/At2pA?=
 =?us-ascii?Q?00zHd3MOboWsgyI65ylMpd1cbUCTReX9f+X+qDcmtVFwodI/wbj4vGWPn4Cq?=
 =?us-ascii?Q?79vFBzt15hi3aeh1GdiTeCVqQbgbZ9G0hJMbfi1Z894ERkJvzsjDVuMJTHVW?=
 =?us-ascii?Q?aV4K/u9Z7RGAgsZ/Ijix2defq3JEEaLJaT+SltfefeZ5wPXpuJo4IUMBQTRo?=
 =?us-ascii?Q?3B/SzzRYlF+spe/avd0e+JZfsv7LJnIyEjEKBBaOHj7w+oR9u5uUoENhVMIX?=
 =?us-ascii?Q?FcJYSoSoYvMWSUNdpzO6tWBj5EUw83AkoNPtzCyYVzPHMtjdUmf/bJa026bS?=
 =?us-ascii?Q?OGp3boQU2BADT0QitzUC0ybXqCxvmJwsECRhBKHUDYbe9jRQK4E1R+M6kUmk?=
 =?us-ascii?Q?n7fdmAhAxgayIUbfAooDG6bWOZJCBkSJppsQB00gGX1p2m57GasfKzSpCa9P?=
 =?us-ascii?Q?dE7DQ8Yk8eGKIfL7zqVIAxndXX/cwOrb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 16:17:09.8981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd2f6fa-c09e-4abe-75dc-08dcbe0ee16e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518

The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system software
to configure the portion of the L3 cache used for SDCI.

When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
partitions identified by the highest-supported L3_MASK_n register as
reported by CPUID Fn0000_0010_EDX_x1.MAX_COS. For example, if MAX_COS=15,
SDCI lines will be allocated into the L3 cache partitions determined by
the bitmask in the L3_MASK_15 register.

Introduce interface to enable/disable SDCIAE feature on user input.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/arch/x86/resctrl.rst     | 22 +++++++
 arch/x86/kernel/cpu/resctrl/core.c     |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 88 ++++++++++++++++++++++++++
 4 files changed, 112 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a824affd741d..cb1532dd843f 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -135,6 +135,28 @@ related to allocation:
 			"1":
 			      Non-contiguous 1s value in CBM is supported.
 
+"sdciae":
+		Indicates if the system can support SDCIAE (L3 Smart Data Cache
+		Injection Allocation Enforcement) feature.
+
+		Smart Data Cache Injection (SDCI) is a mechanism that enables
+		direct insertion of data from I/O devices into the L3 cache.
+		By directly caching data from I/O devices rather than first
+		storing the I/O data in DRAM, SDCI reduces demands on DRAM
+		bandwidth and reduces latency to the processor consuming the
+		I/O data. The SDCIAE feature allows system software to configure
+		limit the portion of the L3 cache used for SDCI.
+
+			"0":
+			      Feature is not enabled.
+			"1":
+			      Feature is enabled.
+
+		Feature can be enabled/disabled by writing to the interface.
+		Example::
+
+			# echo 1 > /sys/fs/resctrl/info/L3/sdciae
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e4381e3feb75..6a9512008a4a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -299,6 +299,7 @@ static void rdt_get_cdp_config(int level)
 static void rdt_get_sdciae_alloc_cfg(struct rdt_resource *r)
 {
 	r->sdciae_capable = true;
+	resctrl_sdciae_rftype_init();
 }
 
 static void rdt_get_cdp_l3_config(void)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ceb0e8e1ed76..9a3da6d49144 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -662,6 +662,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
 void __init mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
+void __init resctrl_sdciae_rftype_init(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c62d6183bfe4..58e4df195207 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -171,6 +171,27 @@ void closid_free(int closid)
 	__set_bit(closid, &closid_free_map);
 }
 
+/*
+ * SDCIAE feature uses max CLOSID to route the SDCI traffic.
+ * Get the max CLOSID number
+ */
+static u32 get_sdciae_closid(struct rdt_resource *r)
+{
+	return resctrl_arch_get_num_closid(r) - 1;
+}
+
+static int closid_alloc_sdciae(struct rdt_resource *r)
+{
+	u32 sdciae_closid = get_sdciae_closid(r);
+
+	if (closid_free_map & (1 << sdciae_closid)) {
+		closid_free_map &= ~(1 << sdciae_closid);
+		return sdciae_closid;
+	} else {
+		return -ENOSPC;
+	}
+}
+
 /**
  * closid_allocated - test if provided closid is in use
  * @closid: closid to be tested
@@ -1850,6 +1871,57 @@ int resctrl_arch_set_sdciae_enabled(enum resctrl_res_level l, bool enable)
 	return 0;
 }
 
+static int resctrl_sdciae_show(struct kernfs_open_file *of,
+			       struct seq_file *seq, void *v)
+{
+	seq_printf(seq, "%x\n", resctrl_arch_get_sdciae_enabled(RDT_RESOURCE_L3));
+	return 0;
+}
+
+static ssize_t resctrl_sdciae_write(struct kernfs_open_file *of, char *buf,
+				    size_t nbytes, loff_t off)
+{
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
+	unsigned int enable;
+	u32 sdciae_closid;
+	int ret;
+
+	if (!r->sdciae_capable)
+		return -EINVAL;
+
+	ret = kstrtouint(buf, 0, &enable);
+	if (ret)
+		return ret;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	/* Update the MSR only when there is a change */
+	if (resctrl_arch_get_sdciae_enabled(RDT_RESOURCE_L3) != enable) {
+		if (enable) {
+			ret = closid_alloc_sdciae(r);
+			if (ret < 0) {
+				rdt_last_cmd_puts("SDCIAE CLOSID is not available\n");
+				goto out_sdciae;
+			}
+		} else {
+			sdciae_closid = get_sdciae_closid(r);
+			closid_free(sdciae_closid);
+		}
+
+		ret = resctrl_arch_set_sdciae_enabled(RDT_RESOURCE_L3, enable);
+	}
+
+out_sdciae:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -2002,6 +2074,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_schemata_show,
 		.fflags		= RFTYPE_CTRL_BASE,
 	},
+	{
+		.name		= "sdciae",
+		.mode		= 0644,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_sdciae_show,
+		.write		= resctrl_sdciae_write,
+	},
 	{
 		.name		= "mode",
 		.mode		= 0644,
@@ -2101,6 +2180,15 @@ void __init mbm_config_rftype_init(const char *config)
 		rft->fflags = RFTYPE_MON_INFO | RFTYPE_RES_CACHE;
 }
 
+void __init resctrl_sdciae_rftype_init(void)
+{
+	struct rftype *rft;
+
+	rft = rdtgroup_get_rftype_by_name("sdciae");
+	if (rft)
+		rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE;
+}
+
 /**
  * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
  * @r: The resource group with which the file is associated.
-- 
2.34.1


