Return-Path: <linux-kernel+bounces-357627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C9A997374
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74777B25E4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503B1E47A7;
	Wed,  9 Oct 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dzXI9hq5"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130E1DE4CE;
	Wed,  9 Oct 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495759; cv=fail; b=cKUfWKH67D8LlXsvD2EGQvWKfqQmFSqCR5+SSEOw99Qu0xFy2r6/O6hF/p1x/0Uft2a8cFPw3K5cnfAD+DoGn4GpYgxytn9L3v4xdbVC/qMQaAP/yfCD1PQB0V5gT9rYRSF4gkz/gJWhy1i3fRcTSfFzSQDikmZ57z0deF/cg0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495759; c=relaxed/simple;
	bh=FCyD88I/IEkfxwVdahvsv9OoqjzLZ4t0VxiQAmkzsFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWGvzATphARXdr5eb5bN4m5mwNsyFl5OCtk7I8nqfi7ADSXoxh8ZtmC2tI7BfDgEAKmXia8D4q1eXwbPDjEkWx/jENjUg9deEVB5n0o8yg+RefqfxJMyHJ84WXkiGD8J20tCidqo2ceFrHCTlodZIFnDLmIbQ1IZgue5RH9dV5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dzXI9hq5; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrb4jH9zBh0uFyNOVp449aqMDh1mmElpu1+QbxdNxaPyztFO/8Bf69BUYTMdL2AgOnIqo47s6KNMa4mfc2CpyUfqgzogHPT1AR5V5Z8cy+kB9gcVzaqIluKPMKrIjcJI44OsYs7V7XREAMLRiAp1+yUM09QVg9QffGuzFWiszQUV1sfeE7O7927DSqpLc6w05Q5TUIu9424pdUtqpJ6MQKY0Z6gteNR1PiLotlAJbLugVI14RVC4RsCgknAmZYcu4ErzhY3KM+he2Zf+zh8jLro39Y0m/mZNw3FD9chQx5UMsUPycwPIXxQFFlu+RJZOPCEA5aXTiQQDN/ThLen/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMMeuRMpmwsEA1CkpjlARXsTE3OzNy1B7XrwrI3lVos=;
 b=KAk0jEc5ZLXqF2SyBuchwZ7okXmkh8/p3Xe5/Co9w/4V0OJX509KT3vItMHoto/9w+TinSnmIJWOpTWdP8mROJGkNhFQNebF8iAhEt7RHIFfNkQ+Hl94D3ZzwVJiP8sieTkrrMDnPLD0dWGczoYzkX6s4CEMdgjLGkXhuDn8eccaDsOa2/jwZOmlzsDykPqa1zE7NgQMy22flbeEIFvOKMETDoWRZ0OMFPxRnDtpPWBRKwC41yXFshO1tdi7fgldwkbDpQAe2vtuU9mTbZDI9/AdEmpB6O6mJYv3373ssbrD1GU252ezqie4/I2DoPW8fq+DBpfAiOQhaVLKaofs4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMMeuRMpmwsEA1CkpjlARXsTE3OzNy1B7XrwrI3lVos=;
 b=dzXI9hq5dHhTjlbk1cKyp4F505uaBKQXbYLB4AvH8NscdxZmPZfdRxD4AwnSTOdcreNaeG6oApXy8HbUvtCCZktU84gXxKqG++/8EyuVTfEyv4NrXD2ijclitPWHCgZvl0Ja6I+qsqsWZDLlTQtKhuoWHWWn2YBoJfWE5NHLcS8=
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:42:28 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::2f) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 17:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:42:27 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:42:25 -0500
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
Subject: [PATCH v8 18/25] x86/resctrl: Add the interface to unassign a MBM counter
Date: Wed, 9 Oct 2024 12:39:43 -0500
Message-ID: <a06e3f9b975bc3743ed8b8df04b6b52229d62bd9.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b1f789-e715-41e9-84ab-08dce889be28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7fr4Aw/LXiyFr1rN8yNORwfIa77/TEraAab/a2aK7Z0K0kJ5eF1sW+iFfa/l?=
 =?us-ascii?Q?pY+4Cem+3rz5Mvq5wqTfr9oq2/Ow7NeTU1hAAhcun0MhieaYfZipR8oXl6Nj?=
 =?us-ascii?Q?a7Ojxirp5wWS3IMBDSHuItRaGZ0YQPb29CKwQU6PASGX+vnSXpLHAMgIX6r0?=
 =?us-ascii?Q?txPoIz4aKHbaXV1LkNZPduQDJol6nE41WAOfS6rihrhif3qWnQrR0z+6rfoo?=
 =?us-ascii?Q?MXuYtpqEUCe5PmroR+iYvxQhzcGOc6rtoUPpNP3aWUkeZncL7VkvoZ5hFSY9?=
 =?us-ascii?Q?eklKAMoRH2SqwVGsROyCO1C12kvda2da7QW/sZHlNV/pkt3wD4d3uL0cY9E9?=
 =?us-ascii?Q?IKxOa7/i+Fyi4yA4S/Le8umFQpn6rbAVbc7D5u6qb8Cj8a9c4MCCs6HZg/eE?=
 =?us-ascii?Q?VwK3VTTf1CPoNegukKRgLjT/q17VV4sDgKOu+cHhJ1YjyUtkAZMCCa8em4+z?=
 =?us-ascii?Q?2y4tHhox9XIORrzJnHluN8Ib+6bvLvijBL1UCLq4DC56baIyYKYhs7t5OZgZ?=
 =?us-ascii?Q?dP1VHjJI6Ydg2NS+bcb5ZSg0XzDdZshFZoTkSU6CyFJ9iJ5GBrBoxJvcpxl4?=
 =?us-ascii?Q?/tSXKogbYK9AVlJV4niEmxS1M3CrCbq7mCGr6ZvZLGC5aUPBDvwKSWKF+D6E?=
 =?us-ascii?Q?Gox0fKlKbfsPKckgJjjWCav4IPofcUTuA28A8dPZwcacohsBZc9OGErMX2mI?=
 =?us-ascii?Q?9/LrB6UkFgvZd3q8h7EUgwQANdwrOuGKif1CIeHf8KYwsBHF8H9YOfJagJ3p?=
 =?us-ascii?Q?e/YPQyglie3vu7nsRPZFsrh3PPRca8bEHsBZ61pepTxIavsDi75NJdyWu18F?=
 =?us-ascii?Q?O6AWvWORfKq8hr33GzSDpvfd5lMHvedUW6xMNVVztASUYQalI1A/kAPpOZP5?=
 =?us-ascii?Q?jTaDrBq/mrl11ntJEU55zIKIH1gUheUwECZ5rlF7yTod9oHOY+Ug9OyQ8mOe?=
 =?us-ascii?Q?dBepjx0tOrFSbtTG9ZJND8z75gdxiOp4An2dU6diCtr9E+msgxYGIyl+7QjL?=
 =?us-ascii?Q?wNZQvyNzS5v5RRw6qvhlyruWekq9ZB0b0xCMxgoKsQyNkPxM97OldmF6uanJ?=
 =?us-ascii?Q?KrnP6NJMVTr/DPRe0LIUurI1RQ55a/nwov7rI4IdeePc6F9nwENwLUlV3W7b?=
 =?us-ascii?Q?jGVnfPwwgbqUd0b/cqtuO2bcdLP7MnBB3v+XdY9uBJcZNoO5SpS8jYqKSnBK?=
 =?us-ascii?Q?VSAwi4Bj4FgUY/I8iHTTxIV5VF8ZLlwvield6Lb/rHcfEATm56kJmtfZehVB?=
 =?us-ascii?Q?UkQjw1DcbKD455kbwO50EaJiBbNW5MBHxx5enIHL3q3bMKOgtlzXpO4gtVP/?=
 =?us-ascii?Q?JDRpHUriirdZWjpF2zgBecTMbLZ9oT0WSWiQBZPNzMig/4sFhvfREXQKWI3E?=
 =?us-ascii?Q?hatoSBCMDizHmiduMwq/w1s5Qs9q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:42:27.6851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b1f789-e715-41e9-84ab-08dce889be28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279

The mbm_cntr_assign mode provides a limited number of hardware counters
that can be assigned to an RMID-event pair to monitor bandwidth while
assigned. If all counters are in use, the kernel will show an error
message: "Out of MBM assignable counters" when a new assignment is
requested. To make space for a new assignment, users must unassign an
already assigned counter.

Introduce an interface that allows for the unassignment of counter IDs
from both the group and the domain. Additionally, ensure that the global
counter is released if it is no longer assigned to any domains.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Renamed rdtgroup_mbm_cntr_is_assigned to mbm_cntr_assigned_to_domain
    Added return error handling in resctrl_arch_config_cntr().

v7: Merged rdtgroup_unassign_cntr and rdtgroup_free_cntr functions.
    Renamed rdtgroup_mbm_cntr_test() to rdtgroup_mbm_cntr_is_assigned().
    Reworded the commit log little bit.

v6: Removed mbm_cntr_free from this patch.
    Added counter test in all the domains and free if it is not assigned to
    any domains.

v5: Few name changes to match cntr_id.
    Changed the function names to rdtgroup_unassign_cntr
    More comments on commit log.

v4: Added domain specific unassign feature.
    Few name changes.

v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
    The function is not called directly from user anymore. These
    changes are related to global assignment interface.

v2: No changes.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 56 ++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 900e18aea2c4..6f388d20fb22 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -717,6 +717,8 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     u32 cntr_id, bool assign);
 int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
+int rdtgroup_unassign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+				 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e4f628e6fe65..791258adcbda 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1945,6 +1945,62 @@ int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 	return ret;
 }
 
+static bool mbm_cntr_assigned_to_domain(struct rdt_resource *r, u32 cntr_id)
+{
+	struct rdt_mon_domain *d;
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list)
+		if (test_bit(cntr_id, d->mbm_cntr_map))
+			return 1;
+
+	return 0;
+}
+
+/*
+ * Unassign a hardware counter from the domain and the group.
+ * Counter will be unassigned in all the domains if rdt_mon_domain is NULL
+ * else the counter will be assigned to specific domain.
+ * Global counter will be freed once it is unassigned from all the domains.
+ */
+int rdtgroup_unassign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+				 struct rdt_mon_domain *d, enum resctrl_event_id evtid)
+{
+	int index = MBM_EVENT_ARRAY_INDEX(evtid);
+	int cntr_id = rdtgrp->mon.cntr_id[index];
+	int ret;
+
+	/* Return early if the counter is unassigned already */
+	if (cntr_id == MON_CNTR_UNSET)
+		return 0;
+
+	if (!d) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+						       rdtgrp->closid, cntr_id, false);
+			if (ret)
+				goto out_done_unassign;
+
+			clear_bit(cntr_id, d->mbm_cntr_map);
+		}
+	} else {
+		ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+					       rdtgrp->closid, cntr_id, false);
+		if (ret)
+			goto out_done_unassign;
+
+		clear_bit(cntr_id, d->mbm_cntr_map);
+	}
+
+	/* Update the counter bitmap */
+	if (!mbm_cntr_assigned_to_domain(r, cntr_id)) {
+		mbm_cntr_free(r, cntr_id);
+		rdtgrp->mon.cntr_id[index] = MON_CNTR_UNSET;
+	}
+
+out_done_unassign:
+	return ret;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


