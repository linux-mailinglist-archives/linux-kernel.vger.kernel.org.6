Return-Path: <linux-kernel+bounces-240260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAC3926AEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775F21C2130C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617E019AA6A;
	Wed,  3 Jul 2024 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xom7nzrO"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EEB194A66;
	Wed,  3 Jul 2024 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043421; cv=fail; b=iz648ePigDTOrQY7JgyhP9FIXKwvTQjv0pqNHmaf6zqloxvyXdNf/6shptmAjPFo3wClY+mC7v2ddwmrNsdfNxiR0lsflhztB+8cgZg4YzGX7d/fWYocsspcLC7iizE9JwHWG9iprbUmccwNbwSGR+QzNDAP90LRsPeQ+OhhZFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043421; c=relaxed/simple;
	bh=2PWLq78NZ6Xq24cKpkfwlTtKGT4Ly0m1wEmSDYtNjsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4xKc1Qd5jd68fJ8XQ91nOETHHo43KYRFAMR1Iy4R3wcn8qj/AT0xcuRLWcFevb9Am760RxOvsd6cvObpelijEeblPGAHnt3tCOj2DOowUmhp5CTv5+C8EjMu8LQoFHtxI+8qgEIclogsmC0mviQRp0+Giw0DXzJbwO8UKaC6pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xom7nzrO; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOWzKEqkrNJfTCHfWqt6hetAL2U35vWpjpiYCMO5s9PQr6RcngD5H2RQdnP6Tqu+VrZK/KBPVIOMGhJxEppFnzNUSxCSVPCxPXrbfSnib3YeJFgAlgUu0YJR7E3rqw68Wn59C10CmUgp52gx/N3q86PpFWxZMBSYN2pm+u4ZVCFojbqOnZ+WCadeJEC+BS9DOW3bEppuX8x+gVCGn2US/fwWRSWjIXSJiVimFVh6gtPkFEolsm77sojvzSWnyFVBkvl2tsGRcXXAfzRo62qBxeUfYnUTA/eNGYtnsnK8R1QvNhIhn4/OQ/+vo02ART6JXKeXoGNYyILqX5dH5i3kTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMIaxpPoF+o2vqLCnBKaK3fIqX5OWC9KpObp/1myZfU=;
 b=UPUGghHQLTYhvXjJn7WSAheFQCwxd3TOm30PmrLtsA9yOSoYsQE1++pxyy7oIkJyu5pXonSp0bAQyX9KuRvnTwYo77kwd/qedIofsze55WzcZ1BGrC7UrmZ8oxpL5jXLnjwA0HI4AnIkE9tgD1VIw1lit88ITAmhd7UhSz6RJg6rbbs3/wM3YgDEjNe7Cz7pVIqo5bDdFIqJdOiRpk7Vxdni5UJEQaUmh82Zt6BEKg0uql19IkVFhoGaWa89Uq4TOita0hUQI+bF2LtM6XEgvH6H2wU1pgb151Q0t0E4IkwqzwWnx36sbhFqjAO2yWBT1TIbqYeYZ1ruOb9oM0R3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMIaxpPoF+o2vqLCnBKaK3fIqX5OWC9KpObp/1myZfU=;
 b=Xom7nzrOuNXbrkQY8GmKEPkL1ltufroz1OcTH+pDyoKYnewzg7R9XbF1Xi7T0Ux/FdBG+W1OMPC0mt2Ssp3RfV1HmsD9GfFpX2ws1LCGIfl3BOmQ8dO5stBw1iO8Xuey/YzJFEAl/1r6ei+LnpnzsOxGaNIe4+/88RItpUrgO0M=
Received: from BYAPR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:40::39)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.36; Wed, 3 Jul
 2024 21:50:13 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::99) by BYAPR04CA0026.outlook.office365.com
 (2603:10b6:a03:40::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Wed, 3 Jul 2024 21:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:50:12 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:50:09 -0500
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
Subject: [PATCH v5 11/20] x86/resctrl: Remove MSR reading of event configuration value
Date: Wed, 3 Jul 2024 16:48:22 -0500
Message-ID: <82e8c5c888220b7659d7cd57fb291412ba62b120.1720043311.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720043311.git.babu.moger@amd.com>
References: <cover.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bd312c-21fa-4933-21d8-08dc9baa1ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iwm++pE70fo1/GYceZfkF0XHdECPpA03eV4YmF8VqwvtIepNm3jS5wlX+aGR?=
 =?us-ascii?Q?z2Ds+2qJ3s0qKJH6DMyGim/nswq9KZipNYqYdOqEzyMf2vEJXrDaDXD0t8ew?=
 =?us-ascii?Q?wyFuWRmMxvcZJhQIrIKcljRQUbqMPNhkRo1QvyLj8+uiz/rT8TpT79pMf9f9?=
 =?us-ascii?Q?xcIOb2V4iR/KzlN4xzoPHXVVCdzc8ocdP6t8KZv+jLAuHlmXmOgOwt+se5VT?=
 =?us-ascii?Q?gTk23Q5Uytc1frWJsWwTHDv+tEAECd+EhmuugU9gKkHDTufNKWXRghjPDQZF?=
 =?us-ascii?Q?yBTMm2MgvGLElr7BIRW4HcgRNYpdjCJtIFg1zHVF/XFuPlVoWFc3t7EvLQOn?=
 =?us-ascii?Q?CsGJcFCZUSZp4F2NB4NaW+ZyjxC3+ZL63kfX3s6oH2kmGBebYFlfK0/+2IXk?=
 =?us-ascii?Q?1bzgYBBxQcPkrTfP2JHbTWSI2F5lU3B8cmEq/ALjM5cGjWJQ8UcWpuFUbgWr?=
 =?us-ascii?Q?grAyhWNH4tkWcAeawoKTUjvvV2Ua2RkkkvT8rmrxvaEF7v9TjlSg2j2O/Ul9?=
 =?us-ascii?Q?nlX2kRNSG9IPz0yvOgopElaaSP0uEgyMBY5JleJNZVXDMzs0s5BrUVQ9EReW?=
 =?us-ascii?Q?uOK+uhxd/kwSlo/hsGfHfsuJkAAx6yf7u6FGrL2SnEr67/GLcI8UO/19BCji?=
 =?us-ascii?Q?BRBGpwZZ9etgzTuLPr4Q03h5kAWs1UsjyY1HRDd9MgpnmawSM9SkHJdyka2w?=
 =?us-ascii?Q?hi25qIR93lgdU2yamkNaZpr/kYArKbxnjYVDmCXsV4gvKeerIXJh1dz5xljZ?=
 =?us-ascii?Q?tBIjRTUHs2WfwEyEGNAsNib68Nb01QWwkHR5LFk6I1ir9OwIVyXZavcsMHdC?=
 =?us-ascii?Q?yRsiNxV7zJPr3GVwcCo6yXTJ+hzTDvdpkoDjRUdCadoDODX4aukX5Qvb2eBk?=
 =?us-ascii?Q?nL9HfWrufNvmXfa2EMB31cSEfFgeYA7fkvyu/FSoOCu0zupiw+yAjPq+OFOy?=
 =?us-ascii?Q?2BqZMls2iu07ofpyx3Ojj+mcyNT/MkVki4lzr974dSiE2ilDRebyIPASMGa0?=
 =?us-ascii?Q?+8LvlO5DO9vRT7jtdd9H2iCxVvkEJYNealfNjsBVf4d4Un0ea801/ic4RVbp?=
 =?us-ascii?Q?BMfFK16NIf4Lo9E7qp1OQA06PupcIt6y8hHq7MfrHxY3zO/jYf65U7ahZoIg?=
 =?us-ascii?Q?wkSnMF3l4x+QE+78l0O9gpBRMH5oIMLHlUu1koQk8DDHmo82eQtq2JouuybP?=
 =?us-ascii?Q?nk/ghzRLHSE9c9YqmqJzJKFLUjPpWmKACNuprbyGKeHb+2KC4nySTG9XWmfe?=
 =?us-ascii?Q?z5TgXYBCKbASeBbZ60x1EK1RvBZBTO+v3e1KFQUtEB4M2rmc0DMHTIzINPiP?=
 =?us-ascii?Q?ZmNRuZyN5kOGPmncDe7AITG/7gziRuvPYVm8JDgUfe37myuO+ygvb6aoZgAC?=
 =?us-ascii?Q?b25g0AdA7qQ1ohhWCfvIpADHFzl8KnAcJnkPsQwXNY0BoCewTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:50:12.6425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bd312c-21fa-4933-21d8-08dc9baa1ddf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199

The event configuration is domain specific and initialized during domain
initialization. It is not required to read the configuration register
every time user asks for it. Use the value stored in rdt_mon_hw_domain
instead. Also update the configuration value when user writes it.

Introduce resctrl_arch_event_config_get() and
resctrl_arch_event_config_set() to get/set architecture domain specific
mbm_total_cfg/mbm_local_cfg values.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v5: Introduced resctrl_arch_event_config_get and
    resctrl_arch_event_config_get() based on our discussion.
    https://lore.kernel.org/lkml/68e861f9-245d-4496-a72e-46fc57d19c62@amd.com/

v4: New patch.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 112 +++++++++++++++----------
 include/linux/resctrl.h                |   4 +
 2 files changed, 72 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b2b751741dd8..91c5d45ac367 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1591,10 +1591,59 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 }
 
 struct mon_config_info {
+	struct rdt_mon_domain *d;
 	u32 evtid;
 	u32 mon_config;
 };
 
+#define INVALID_CONFIG_VALUE   UINT_MAX
+
+unsigned int resctrl_arch_event_config_get(struct rdt_mon_domain *d,
+					   enum resctrl_event_id eventid)
+{
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+
+	switch (eventid) {
+	case QOS_L3_OCCUP_EVENT_ID:
+		break;
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
+		return hw_dom->mbm_total_cfg;
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		return hw_dom->mbm_local_cfg;
+	}
+
+	/* Never expect to get here */
+	WARN_ON_ONCE(1);
+
+	return INVALID_CONFIG_VALUE;
+}
+
+void resctrl_arch_event_config_set(void *info)
+{
+	struct mon_config_info *mon_info = info;
+	struct rdt_hw_mon_domain *hw_dom;
+	unsigned int index;
+
+	index = mon_event_config_index_get(mon_info->evtid);
+	if (index == INVALID_CONFIG_VALUE) {
+		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
+		return;
+	}
+	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
+
+	hw_dom = resctrl_to_arch_mon_dom(mon_info->d);
+
+	switch (mon_info->evtid) {
+	case QOS_L3_OCCUP_EVENT_ID:
+		break;
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
+		hw_dom->mbm_total_cfg = mon_info->mon_config;
+		break;
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		hw_dom->mbm_local_cfg =  mon_info->mon_config;
+	}
+}
+
 #define INVALID_CONFIG_INDEX   UINT_MAX
 
 /**
@@ -1619,33 +1668,11 @@ unsigned int mon_event_config_index_get(u32 evtid)
 	}
 }
 
-static void mon_event_config_read(void *info)
-{
-	struct mon_config_info *mon_info = info;
-	unsigned int index;
-	u64 msrval;
-
-	index = mon_event_config_index_get(mon_info->evtid);
-	if (index == INVALID_CONFIG_INDEX) {
-		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
-		return;
-	}
-	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
-
-	/* Report only the valid event configuration bits */
-	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
-}
-
-static void mondata_config_read(struct rdt_mon_domain *d, struct mon_config_info *mon_info)
-{
-	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_read, mon_info, 1);
-}
-
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
-	struct mon_config_info mon_info = {0};
 	struct rdt_mon_domain *dom;
 	bool sep = false;
+	int val;
 
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
@@ -1654,11 +1681,13 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 		if (sep)
 			seq_puts(s, ";");
 
-		memset(&mon_info, 0, sizeof(struct mon_config_info));
-		mon_info.evtid = evtid;
-		mondata_config_read(dom, &mon_info);
+		val = resctrl_arch_event_config_get(dom, evtid);
+		if (val == INVALID_CONFIG_VALUE) {
+			rdt_last_cmd_puts("Invalid event configuration\n");
+			break;
+		}
 
-		seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
+		seq_printf(s, "%d=0x%02x", dom->hdr.id, val);
 		sep = true;
 	}
 	seq_puts(s, "\n");
@@ -1689,33 +1718,27 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
 	return 0;
 }
 
-static void mon_event_config_write(void *info)
-{
-	struct mon_config_info *mon_info = info;
-	unsigned int index;
-
-	index = mon_event_config_index_get(mon_info->evtid);
-	if (index == INVALID_CONFIG_INDEX) {
-		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
-		return;
-	}
-	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
-}
 
 static void mbm_config_write_domain(struct rdt_resource *r,
 				    struct rdt_mon_domain *d, u32 evtid, u32 val)
 {
 	struct mon_config_info mon_info = {0};
+	int config_val;
 
 	/*
-	 * Read the current config value first. If both are the same then
+	 * Check the current config value first. If both are the same then
 	 * no need to write it again.
 	 */
-	mon_info.evtid = evtid;
-	mondata_config_read(d, &mon_info);
-	if (mon_info.mon_config == val)
+	config_val = resctrl_arch_event_config_get(d, evtid);
+	if (config_val == INVALID_CONFIG_VALUE) {
+		rdt_last_cmd_puts("Invalid event configuration\n");
+		return;
+	}
+	if (config_val == val)
 		return;
 
+	mon_info.d = d;
+	mon_info.evtid = evtid;
 	mon_info.mon_config = val;
 
 	/*
@@ -1724,7 +1747,8 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 * are scoped at the domain level. Writing any of these MSRs
 	 * on one CPU is observed by all the CPUs in the domain.
 	 */
-	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_write,
+	smp_call_function_any(&d->hdr.cpu_mask,
+			      resctrl_arch_event_config_set,
 			      &mon_info, 1);
 
 	/*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 62f0f002ef41..f017258ebf85 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -352,6 +352,10 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
  */
 void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
 
+void resctrl_arch_event_config_set(void *info);
+unsigned int resctrl_arch_event_config_get(struct rdt_mon_domain *d,
+					   enum resctrl_event_id eventid);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-- 
2.34.1


