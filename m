Return-Path: <linux-kernel+bounces-357626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1984499736F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC952842C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1E415C15E;
	Wed,  9 Oct 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IOKcQZra"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE141E1C12;
	Wed,  9 Oct 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495748; cv=fail; b=f3AEgrzLTMq2l4xG9w44E1wGnYPEazbnYI5zUOVTif0heZMctgxBzQb5/v3h9aGOwBi+5lCCAHDgwVBO0603d6OPjnFr0nTpZxIGcVRW2kjEs1Tinc8dudGSIzrGATqhUZfaRecAu1ic58Z2h1r/6eijoJ90u8FEf+7Pif2Xlpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495748; c=relaxed/simple;
	bh=t+tVSSHAitiBMpltgu5NQPbv9hMc8CuiRy0k6uXOu5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNPqagmqHxeozYBCi4OWId8TY7foV7ffqCVJaIdPL/LX5TOH403lGAfQQSOCbgMOztbEdl8C1HBJzaI9w1cXcIWoVhdy/bSyrqLyPg2T0AkZQWgcxVVfk9lhfxhUdbk6toLEB+YrfFbEQHybQbhuoyPgIMlHxi0lP4Buf4CSmWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IOKcQZra; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgMD6c3632nkolidqKte+Lo16B0hKGkO+c985NZZg5zieMqu7+jkR24t23K2I1KhpC/trbXdiHXF2fizrnrZ5gQsO+I6fojoXepnu/ULnmmPRskpXVL5m2q4e1PcVE0VwFdL5M/beX8UpnabAQL9W5fG/hE4yLeWr7SOIoG6Wf3JWPk5aFBALbGYLgR2xY0xbu+MK/3U9mFBb5JVTR92Eu4iWjylfh9bdiG7l3q8PBiu0ZbO3j76DKLBzoT1PQlzBEk85Y+7557panQc82TPMmvFa0TxE86C6LMqpgiMXFJy3mITwFbpdKCDvBOIgCs+vBmFKMqeD2Xpj1J6QHgALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJpQL0XC0YaApHy1ipBeqsFdLvjd54LAip84w/ETV1Q=;
 b=f2XArmH7V4p/F35eiPyufASXU6did3/rNTEtuQmCnj1wE5S/HjXybQueruEOd0sGxEYNS0QP3VdLRa1vSxljmiKdq/bRitr7DVtgoLhtaCfslYfaucOIVY3U6xaRgCEvEtCf5a6Nf6sy5UBYDIrcpzg0U5qeamwEob1E6yNqJqQoaDdX+Gixw83N+1bygKxo4J0DH0W1iTfHNt+kw7ZY8zuPksuxCHpu6o3bsMmO4+V2B/N4iCiGjGZFBM9NtldomchM7kwXv5HRw0R9/LH6Yhk8/RrkXobs7CwmJ5bgr4hXzIb/X5HHPiZZV7gOwGHBV9bQjdWtejJuG4xf1Apbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJpQL0XC0YaApHy1ipBeqsFdLvjd54LAip84w/ETV1Q=;
 b=IOKcQZra3ivf2+twW7iMS8x1kK6HH/AEW1cbj9hyToECYXJ2z8BYthEjdfYqywuVIsLNHK0Tu0XkT5xsy79aozi7lNCSP/CE/qvvhMv6G9ux3cjii4JfUlSdf3e65/roOtOmjWhMUsPVauX+0TkvfUR290kbf8bY5rw+5Ripo/Y=
Received: from SJ0PR05CA0067.namprd05.prod.outlook.com (2603:10b6:a03:332::12)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:42:20 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::b) by SJ0PR05CA0067.outlook.office365.com
 (2603:10b6:a03:332::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.7 via Frontend
 Transport; Wed, 9 Oct 2024 17:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:42:19 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:42:17 -0500
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
Subject: [PATCH v8 17/25] x86/resctrl: Add the interface to assign/update counter assignment
Date: Wed, 9 Oct 2024 12:39:42 -0500
Message-ID: <86c8fd4db89f264b1382cd22d7cf53c4510bf07a.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 812ed83a-db3a-4106-9348-08dce889b98e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kw7cT/uD3zzsTBINwcygdZ2Et3Ml1a1IYcU7QbvoO/EI64lIvCnPELVwYwd3?=
 =?us-ascii?Q?QqSEvXSAZrsyN38D2QJ5I7N3tpHJH7/dISIRsvrKaYX+o/Do+iCkE0m7nDCt?=
 =?us-ascii?Q?MpBTKtDWULEd6R4R64tXGN0urGwTMtUgdTwBpoAF75HVHvpBkR1Jor6eHb8C?=
 =?us-ascii?Q?GQYD21Y5pKUGTuUZkobWcaIhkwfHrAea1FFGSz70t5Ez459HyYLoMqlCNMDt?=
 =?us-ascii?Q?DJecKmA2UtLPeTcvk6dBSxFWjK3pecERCqjYcPnMD2b75LgPN70nx5woZgFg?=
 =?us-ascii?Q?jMFgPy497SJ5URz5rP2QmzI5PdkPm+f0qSA//8n6uIOsWPwx5XlEieooK+2X?=
 =?us-ascii?Q?gZX77U889+oHMf0x9KhPmGEMlZ2vOHk1RgCp1lGFMcjejPis405wyM70ykCg?=
 =?us-ascii?Q?OQERkavtui7a3cChR21GlZbz07l6cHqgKK0Sq8Kdelw0RaBxh9Jh0nyG2Ck/?=
 =?us-ascii?Q?mFAhNE61v1vb8T3QT0MzgnuzpXWFL56RugI9t1pPqrEVSvS/SdZnO+4nNxLq?=
 =?us-ascii?Q?KZ1mc857sjWbTjy9odSNXYeIYJaOC9cr6+S1uAqBJ0XYnvD4NUc908ECknar?=
 =?us-ascii?Q?laxRBqKWIEgC+LoHJaZ2INAKDIeYxWyJn/BtMKM+V30WwXR6516pQlF66N5i?=
 =?us-ascii?Q?h0S4kQqHH3kBiIR0IDqVkXRG2QKqmv9U8j7C10qO7nhboc5i+IUGSlJI4CdH?=
 =?us-ascii?Q?KxlZ9AHeihgY7pPxeYzGzz8fuEIMyLG0HsVi1v1qzY7nWiL+WF1IJJZKtXyx?=
 =?us-ascii?Q?R7z0nHWFflLK/RdYEqbHhkx+tntDsiNfx2ujb7n1Avt3QS9bCaj5TD0Y2LOI?=
 =?us-ascii?Q?YP2DMDOnU8VVkXJO/FFyOnPe0JtQ4smyJz8/LKZqHLYYfFyAKAUIZLlHawgF?=
 =?us-ascii?Q?PhhUv09utcaXudiAotH9H2IMqX2Zv7mXUe619iqvZ8Y5d3sY3BT+o8hnLlZV?=
 =?us-ascii?Q?ijleQrWLVwgiOHZ/C6chkPnQkXVV5LTrOOYdpwHkWP1rlywho7YryIm6WAXT?=
 =?us-ascii?Q?dwT2qN1aBUXTNRXgGH/w+MKv9cvbC3CLtU7Qqtmj0fdSwoySZRn1Gf9YVO7w?=
 =?us-ascii?Q?80RjulN/8umpIWkdcW6wMGzNrAtt+CP+cvPErTC7bvWLNEjDtoD1KHyWVnMA?=
 =?us-ascii?Q?PsFr5sCvPzt4wZZ3vl3PxFc+WcNgdVvXLqioXh84y4CZCpJs4QskHVmKBCmc?=
 =?us-ascii?Q?y+BgsQaahcIGk1C4wtGXs/ujOaOsrHdxd4LnyQXTCgZQJ2eDZKuY7xQKXskd?=
 =?us-ascii?Q?E7jkG50QSjyyf1by8UP6evMw6cg/s2dMV0YLnL/VRho8G9YXlBwTGKwTnFVc?=
 =?us-ascii?Q?4ZITEV7kdWcH4uQ94Pf6CmE+ES+Flg89puSyffobYWPD5X/F/Tb10/lBzvoB?=
 =?us-ascii?Q?2c15c9cqaVxfIW8+EjRLpqZudPZU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:42:19.9653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 812ed83a-db3a-4106-9348-08dce889b98e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902

The mbm_cntr_assign mode offers several hardware counters that can be
assigned to an RMID-event pair and monitor the bandwidth as long as it
is assigned.

Counters are managed at two levels. The global assignment is tracked
using the mbm_cntr_free_map field in the struct resctrl_mon, while
domain-specific assignments are tracked using the mbm_cntr_map field
in the struct rdt_mon_domain. Allocation begins at the global level
and is then applied individually to each domain.

Introduce an interface to allocate these counters and update the
corresponding domains accordingly.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Renamed rdtgroup_assign_cntr() to rdtgroup_assign_cntr_event().
    Added the code to return the error if rdtgroup_assign_cntr_event fails.
    Moved definition of MBM_EVENT_ARRAY_INDEX to resctrl/internal.h.
    Updated typo in the comments.

v7: New patch. Moved all the FS code here.
    Merged rdtgroup_assign_cntr and rdtgroup_alloc_cntr.
    Adde new #define MBM_EVENT_ARRAY_INDEX.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  9 +++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 47 ++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6d4df0490186..900e18aea2c4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -67,6 +67,13 @@
 
 #define MON_CNTR_UNSET			U32_MAX
 
+/*
+ * Get the counter index for the assignable counter
+ * 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
+ * 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
+ */
+#define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
+
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
@@ -708,6 +715,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
 int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
 			     u32 cntr_id, bool assign);
+int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 4ab1a18010c9..e4f628e6fe65 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1898,6 +1898,53 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 	return 0;
 }
 
+/*
+ * Assign a hardware counter to the group.
+ * Counter will be assigned to all the domains if rdt_mon_domain is NULL
+ * else the counter will be allocated to specific domain.
+ */
+int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+			       struct rdt_mon_domain *d, enum resctrl_event_id evtid)
+{
+	int index = MBM_EVENT_ARRAY_INDEX(evtid);
+	int cntr_id = rdtgrp->mon.cntr_id[index];
+	int ret;
+
+	/*
+	 * Allocate a new counter id to the event if the counter is not
+	 * assigned already.
+	 */
+	if (cntr_id == MON_CNTR_UNSET) {
+		cntr_id = mbm_cntr_alloc(r);
+		if (cntr_id < 0) {
+			rdt_last_cmd_puts("Out of MBM assignable counters\n");
+			return -ENOSPC;
+		}
+		rdtgrp->mon.cntr_id[index] = cntr_id;
+	}
+
+	if (!d) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+						       rdtgrp->closid, cntr_id, true);
+			if (ret)
+				goto out_done_assign;
+
+			set_bit(cntr_id, d->mbm_cntr_map);
+		}
+	} else {
+		ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+					       rdtgrp->closid, cntr_id, true);
+		if (ret)
+			goto out_done_assign;
+
+		set_bit(cntr_id, d->mbm_cntr_map);
+	}
+
+out_done_assign:
+	return ret;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


