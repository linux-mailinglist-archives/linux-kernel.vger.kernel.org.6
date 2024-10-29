Return-Path: <linux-kernel+bounces-387831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3465D9B56B0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7977283DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0DD20B20D;
	Tue, 29 Oct 2024 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K+VgfMEJ"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491620B208;
	Tue, 29 Oct 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244180; cv=fail; b=WNgmiMPtFVI5JoXilXevpf/JPEG5L8vkynRiQnB7I0BH3Zw2PVb0NjY3itsCw3U0o8mTx9AHqbRpAI8OuAr/R2gT12ipItnbI4/wvVfTYBWoFHuhCMCAaMWqmvw8UFnTAjUIv9cbWKblcCrpIjTlv5bUweGgdBM4XURHgxfL9vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244180; c=relaxed/simple;
	bh=PuD1Sp+iCOPAM0bf8vS7VUiUduMBWImWahmCjyuHR1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+ayLZa5XZskE8JEZ2ZcCtjuGMYH7P0YNVhr9JrP1VA+CWWZBDQPgs8tGWBkCK9HcR5cYZxJJiT2l2ZOY9uiHWB0ut3plBuDDx15zppy9sYCfJ4+pllU2MoUTn4uBhoCUuIABLs1eIe4kPi7C8rcavSDRfK2nk9ISW9PL/Cw6iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K+VgfMEJ; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rz3dUjS/dds7aMVdNwpwKQhxgT3ecqc6pKskYpD7wVGht8sQVbjvyoJGeTjPt2HHLYOO5gHBSBIFOEWRTc48ywzlaA5ogp9mMv9GPby+JKeqs1muC1EbPxVO6kio/foPhohl4GAHi5wH5O8QEmkTPhWI029yjDYdkECUFJ2CRPb6+noTnCKO9jOTGJeAZazG75h5H/4h50aHZJd4LJHYQ0QWeBPxMJ4ErqRDD5DO+QWSTneqQ13Z8vEFTLR8gzI+yNMu4EzAqOiJt4p6ON20bqYTIzog50QNfK4xUwT234EYte6M0pdV/3qpl7G/C+fakRQKQ2ZZz7vNepWR5dpJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEEcZaIslTpPMrS+eOeuB3s73jtKGZG2WXB6kSu+bI0=;
 b=CRZRx84+TpA19YPYjHj/sAmXYkOAO1n3lPEEMYTXj8Z5lVZhKyk3j7pgEYWj8q9rV8HeDxY3Dm3wDSkWbe9PxzjsPlEZW6vuxzJ4PV2eq/igMDe+6ROmdfnnf4AROcYUP1lU4DNfMFiEnTc4lF37v4DFckhg86Dg1XjHvwhcq80y438/G8Stt00wzl2oSHn/326m2mbtFWaxXboR2lDsyLGZJchlGkUdNyNBZ+HBeBlyBGF+Ksc+Bm98jAsN1FxPUIgsPkgK7QNJysRFyM6wIFwI9PIPnc8ZM67h3rCPPICKZeWltBIFvsiHWOb+xFUfcjHPXG8A6jxxd21117Rcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEEcZaIslTpPMrS+eOeuB3s73jtKGZG2WXB6kSu+bI0=;
 b=K+VgfMEJK6/GfcjXqp1tbNsVToA3E+ZooK484rHtdBQTrdqZ2i8qM+q+wqHZBJHkSi6BsJygq0C26DYuvspwaX2XFVDbcSex0ErhqXPKhlA/tSv06Z1xIRfTuVQHA0SP0ouZowFjYrE5MNugjFYeeBYya6dTIAm+C1PL4wpba9k=
Received: from CY5PR17CA0058.namprd17.prod.outlook.com (2603:10b6:930:12::20)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 23:22:54 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::12) by CY5PR17CA0058.outlook.office365.com
 (2603:10b6:930:12::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 23:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:22:54 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:22:51 -0500
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
Subject: [PATCH v9 05/26] x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
Date: Tue, 29 Oct 2024 18:21:37 -0500
Message-ID: <ea51ba382e1abc3a2d670679de938087eb4f2b8a.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 267c545c-eb0f-47f0-6730-08dcf8709d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fmw4vlkn7LZo+DbmFCm7yXkykUDqPSzy5LKIwLa/+Ia4kdAa+mJ1XWoSP851?=
 =?us-ascii?Q?nGF2yuZ4Pn9VVPpXoxEtoXZBn2zMywaU0Ow2gAcb7DMyIFoIgd1umAcqqTRs?=
 =?us-ascii?Q?Rv2AcgVMPDdzcYVc6ULbzZisL4LS143O4rJNPi40ar5wGQJniY6+YbrvQT5i?=
 =?us-ascii?Q?mMmpPU6INSNNVC3rfqXOeqEdiW+VTpAHJGY6yaZcd6T2wWaA/Fcrf1IHlP6L?=
 =?us-ascii?Q?0SS35kDD29m2eQe30EF1U/eupOtesePFz37h9U1qx5OnOQa1YRbRVPgi/eWx?=
 =?us-ascii?Q?5TFuQ6MeKqJjghYhhvNcW9RIoTYSb/+SZV/rEEq8glfwDiPHSd8YkzNl0vRq?=
 =?us-ascii?Q?60CXntLeh/uysGgXjUJlNMe6Fu8LMV2++6kkAah8BsZPMDS4aUCylMtJjiAf?=
 =?us-ascii?Q?kKzAmM1e9HqcnznR3HX5jyZGqygb0R/nxBIInwuKQRL6cKx8MpOq5zZYdtDq?=
 =?us-ascii?Q?cJyO48fG7GFSq88lhby75KR6w22bWTaWQYFXSuQZ8niZefWASLZH4U6oZ6Pi?=
 =?us-ascii?Q?KXsK/mw9xlr9J6PRSEc538hp9jgOKoUKntKSicG0JucqiVIhLTo+QCiKnKwn?=
 =?us-ascii?Q?YAlWrd/160fVDOOYdmyomjWmIfx1PEusy4bg4D7Qn+IWAtMzU6Oj2nxiTYqd?=
 =?us-ascii?Q?UhpfkE1GNb6kvQxFW8HGdN0NdGn5n/CmMJtLesYzTrzR6xhONgL27cgD/nQ+?=
 =?us-ascii?Q?5xRxFlIjtjqNgvEC/BlqAWiDgzaMu1mXVX1BbMiOSgcQNvRHbaaZHncg/rOJ?=
 =?us-ascii?Q?/vLz0sZKxWA367JAKqLUlrVrunmZVOe2bNs2pwHX6HKGAmY2XiU4Qxtd3F5Y?=
 =?us-ascii?Q?Ux7ICg8rW4x2XkBxIUjbeJjE6QDHYlO9vXE75pQzHvOhctT+E9U65OC+XD9d?=
 =?us-ascii?Q?rnIAeqaX9/LloRmB6hoRqiGFYtFw+Rf1hHThh7DoJ5MnI0EDzO/08Qp0p38o?=
 =?us-ascii?Q?veIper/hc5kJ5I8X80LdPbW/lYrSy7dKpWslDWxkevvZ6CM9l8n3ysyXQC0o?=
 =?us-ascii?Q?BKEt/Qon/Mpn7DJdmxGU+kYX0Mt1f5pKalkA2bR6GOvZksyXHp+TgExjR4XL?=
 =?us-ascii?Q?1Mg+WRJMsqL1HQ/n28+tDaMB2UBFaacCM+5IxTSE5tonxz1dApJpfRjSMDGE?=
 =?us-ascii?Q?/a2IzLQCh2U6BkOaI0tx1BYLroYNCOffbYtzl9RUajdOaW+WCA9U3Nrerab5?=
 =?us-ascii?Q?7/ynvvEZJn3I2OQvs0EyJUjszuiTedeVMbC2CKU97CCIL8f42mcPlTv/no+C?=
 =?us-ascii?Q?Y/DHXKUxgL+wqXvK7+8hN/2eCrdIxbc0ixFnbzOzhGXPkLQuQfmU25ynrvdh?=
 =?us-ascii?Q?3cmVmYCHZrM5lNZDWrlk4oF9+bNAXp2iG9JEZ8VLdP7PmoyNL3EkynSdHgef?=
 =?us-ascii?Q?XUrqulmRURp54sE8lVg9S+/BTxS1vHp/ae+AIogNZ8yviuFhwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:22:54.0840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 267c545c-eb0f-47f0-6730-08dcf8709d85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Detect the feature and number of assignable monitoring counters supported.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v9: Added Reviewed-by tag. No code changes

v8: Used GENMASK for the mask.

v7: Removed WARN_ON for num_mbm_cntrs. Decided to dynamically allocate the
    bitmap. WARN_ON is not required anymore.
    Removed redundant comments.

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
 arch/x86/kernel/cpu/resctrl/monitor.c | 6 ++++++
 include/linux/resctrl.h               | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f7fdf2c767f0..383bf3ad2dcf 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1229,6 +1229,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			mbm_local_event.configurable = true;
 			mbm_config_rftype_init("mbm_local_bytes_config");
 		}
+
+		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+			r->mon.mbm_cntr_assignable = true;
+			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
+			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+		}
 	}
 
 	l3_mon_evt_init(r);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 3c2307c7c106..511cfce8fc21 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -185,10 +185,14 @@ enum resctrl_scope {
 /**
  * struct resctrl_mon - Monitoring related data of a resctrl resource
  * @num_rmid:		Number of RMIDs available
+ * @num_mbm_cntrs:	Number of assignable monitoring counters
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


