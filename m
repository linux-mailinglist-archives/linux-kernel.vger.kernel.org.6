Return-Path: <linux-kernel+bounces-316051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3B996CA62
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5C21C21809
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B0188A10;
	Wed,  4 Sep 2024 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H1ZbAvGV"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57B17BEC3;
	Wed,  4 Sep 2024 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488687; cv=fail; b=aa6MLM2lE/m1bUa7KR80JmNjvSjy0zagCqL9xo8EoFlcDFPtCXN9E8MQtCpQwXmiJEVo4oMltXyl1LK6rQci+z5TbwxREr+klRqFvTi/CrgfjAhyFM7er5YJfu6heFnzwueilx4GodOal0ln55gQjosd8rh90QWm8rOfpt8iYOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488687; c=relaxed/simple;
	bh=8fmBpo5A1I3PEgYdiQT1N+4fc8Afo1k3cAEmwgUMiw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0xMjUIzHRyc0uYygwRigFmDGzjlzL6Q/1IdffwUykmfFQoCWzyxQue+n+vg3YN9QLQ19n8O/tUT638l6YcwtYvSssgflxy9A9xiqKxv/l87iDYeCZqN42hWlM6LO1RVy8HbkI92Ur0U5Lv9qT9C31dGi8lH4Xdj715XgSLXFUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H1ZbAvGV; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ax2piosVsAvZwLdjLG8ZyGoxxxHUSaLJrR/LgQH4g3aOSC0uehvL6evjPDZLKpTCI/7MxNk7QJj8RzdR91W9NCEK8IsvPN7jaObGAXZzjgiYagcyc9sPn+rdkXRrw74X9btUXMqOnYF0Brw3ez3W88w0uu+M2qPZmHt9OhIkGa5LdWHX57q7WK3yril2YSoDb4e/DXBWR0M36cWbzkWnDZ1xJSr7wFQPvcIGyknJJX2jPLCFOzN0xIXbj+aIJSATVMrRPdUM9ccgehJEgJdi7tmsuk0ry6VZBZxkm6Zg49YCzX7yG0aml6w9crzmlf1hAoN2ZC5XUxjcXywJ3C+baA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U9zwzIjOe51f6cgBrARMIhv9aXvQVDrYgDZ/XI5PxI=;
 b=DS20jV/Zl/kXsS55hIFTlDJ28SsVZozolxV+4Vz8eg7h84s36uzabqti35AebTluGgAU7K32tX7Rxz4kwoyFlRlGep1AJGdZg2twJSZezkZVhd4pPttJSqjlmZ8LkidAy5SAkA09I848Fjkr7jfXAtY3mKUpHaNAg28tPh9A51WQhXVpKjVYm1pDQDrEY15mjCPmO9E3rNZ5FWhbfX2zTd5dbHGzY3kVfJw0YEq+RqTrWt/N1rQxP6o2wtrXqdxNh79eIZ0GRFur/RQEOJDcXX0zsqh5WNrHQrCaniuSpp9mVoQGeelcJP5kVFu3btqgNwdy7Xs+G1mPXfegwfGeGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U9zwzIjOe51f6cgBrARMIhv9aXvQVDrYgDZ/XI5PxI=;
 b=H1ZbAvGVTfTWCcedVvtOQqCTJrtvo7VS14fXVo3nepmBPtTQoBvDMuFG5lTr/IfuXB8wbcjBRs1q11wVyGx/byEj5BYailZYXvQ+a4QXJ2SOMvK7ixbbc4nbYNBmxlE1lRbe3yJwzhlx1t7iODpvd94Ni4FE1tIeFx6vkwJGkwk=
Received: from CH0PR03CA0392.namprd03.prod.outlook.com (2603:10b6:610:11b::31)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 4 Sep
 2024 22:24:41 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::a) by CH0PR03CA0392.outlook.office365.com
 (2603:10b6:610:11b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:24:41 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:24:39 -0500
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
Subject: [PATCH v7 22/24] x86/resctrl: Update assignments on event configuration changes
Date: Wed, 4 Sep 2024 17:21:37 -0500
Message-ID: <ff0cd2a73c78fdb7487632381b4aec642a0af5ef.1725488488.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725488488.git.babu.moger@amd.com>
References: <cover.1725488488.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 9029aa6b-56d1-48af-facc-08dccd305ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sWXDSJu15QkcGbOJvpqiYl0UsLEObRlhgHbDghOal/gt0KenP2bNQQ3MbVFs?=
 =?us-ascii?Q?wQQP/V5f77gbysufIisEqYIZeR0ZmrlGwSTfLUezrifQ9r1Dvq+U75H2Azjm?=
 =?us-ascii?Q?sns2d5EYMsS9HI+HML4V5MGHEMBW5LFd1CjumI0lvTGY3gYaXTjVqtE6vmtf?=
 =?us-ascii?Q?YncktI0mnSK4N23MXs/kSZUDYGTthQinx9TLlseNd2Y+KoTTvCt4L+cZou5v?=
 =?us-ascii?Q?4LhotwaKAcf1EvSakzc3PgVS0uNP0FwwTy4gFLAL8I4VMFg98FlVpYsA6Jo1?=
 =?us-ascii?Q?WBQ6DUOwHejT03YzoCJdxZGkBUaL8xtATkCZBslsVgeM065YIXYUGQOYcncX?=
 =?us-ascii?Q?3Vl63+VXl+v5/61HlvPurXci6x2SMuC6CaLhnkGiwbyqcJ6ZT9GvMQr3zfFb?=
 =?us-ascii?Q?VwH/DLbiGDQfetxPUwfMhnALGP+nS7XeG7C9XfwKmOeEtWcuvRTzXnsV2vCX?=
 =?us-ascii?Q?uC2uah4BUrZeC6cQdacwa1Nf0st4QhShPdaF+tfxtq6EROKk6DUl8B61y05H?=
 =?us-ascii?Q?rc9kzxJHIutKq/x+3WQLZ3JwRPeHRCwoF6LJa7wFJlJkMVAJthIOEZlTqfiE?=
 =?us-ascii?Q?wK5amJXWUIXCqszT2ckRl+7VfKQAdkhUf9rrxiEJ4ATcsFh8rgxi3YC8zmKg?=
 =?us-ascii?Q?5UqyFp/eSEAhPMv0I+khF9CquBEAJC7UEDM1AIpsY+Lw1uYgUXUY4RKbEsXj?=
 =?us-ascii?Q?AEEueyWrHoVAgLLXK8Pgq6L4ON74Zy/h3eYSjOyX5q+IHp81G6WP81RuNwMg?=
 =?us-ascii?Q?P7KgxSUV9mVQ8L6AQr/r4xKp+h8/vxT3Yg+9Ls9QGycXP3AJSDBDxlo2DAyB?=
 =?us-ascii?Q?kUgyDQpxLsDh3VttnX4I5Z4wqi70ZFvSuS4KUmZ5NStQF+V376+t6tfMySRE?=
 =?us-ascii?Q?BHR2dgkOGwz8H5xOSK+dAoRPZdTg8+lZ4w+u2aPmlU0M93yraU9xhIRUKiyd?=
 =?us-ascii?Q?g2NLLLmb+/u5SGRcmakWro9jwnXDWYWNmKSgcW6LEnfYGWw5I2SmOm01/xYq?=
 =?us-ascii?Q?rV9Wdi/BxoTGMFpvkjxgPkbya8PLqvTs74xjwdJNz+dROVJ3pRwEXb7RZxfG?=
 =?us-ascii?Q?QsK0r2B0e0TePxP8vpSSf10vGoKaZ3liesxBxPKqXSebVDmFD3LuKRN0dPth?=
 =?us-ascii?Q?ob6xdSyqZU+0zSeQJShkHKsqUn1idk4xyOM50wp1ROLJQTsF3nzV4GJj38uU?=
 =?us-ascii?Q?in4PDdPqsbiL0YyWIgfLP4bg9d6IOqKj+MoVeyAzAJhTrxgPArVFoZQLXXL4?=
 =?us-ascii?Q?kc9UPattGhEd8UrQjxEyUb2EI20rAOfkN58G6kD67exIT6sax7VWFwAXqH6c?=
 =?us-ascii?Q?evRgKyTUUQdBHY6rDNWg09CeCRUKiwW3dqx8Tq2nkWLxXrdsLe6v2d6enK4c?=
 =?us-ascii?Q?dVMP6XS7BvWQkkENJcMh6zNa6sQRz05uegxchy2UVA6bgcdjR0lyQuz/8S2+?=
 =?us-ascii?Q?xM88K191JqdglxrMFMeWw0qk92LOdtiT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:24:41.4420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9029aa6b-56d1-48af-facc-08dccd305ef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212

Users can modify the configuration of assignable events. Whenever the
event configuration is updated, MBM assignments must be revised across
all monitor groups within the impacted domains.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: New patch to update the assignments. Missed it earlier.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1054583bef9d..0b1490d71e77 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -871,6 +871,15 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
  */
 #define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
 
+static bool resctrl_mbm_event_assigned(struct rdtgroup *rdtg,
+				       struct rdt_mon_domain *d, u32 evtid)
+{
+	int index = MBM_EVENT_ARRAY_INDEX(evtid);
+	int cntr_id = rdtg->mon.cntr_id[index];
+
+	return  (cntr_id != MON_CNTR_UNSET && test_bit(cntr_id, d->mbm_cntr_map));
+}
+
 static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
 					 struct seq_file *s, void *v)
 {
@@ -1793,12 +1802,48 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int resctrl_mbm_event_update_assign(struct rdt_resource *r,
+					   struct rdt_mon_domain *d, u32 evtid)
+{
+	struct rdt_mon_domain *dom;
+	struct rdtgroup *rdtg;
+	int ret = 0;
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
+		return ret;
+
+	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+		struct rdtgroup *crg;
+
+		list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+			if (d == dom && resctrl_mbm_event_assigned(rdtg, dom, evtid)) {
+				ret = rdtgroup_assign_cntr(r, rdtg, dom, evtid);
+				if (ret)
+					goto out_done;
+			}
+		}
+
+		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list, mon.crdtgrp_list) {
+			list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+				if (d == dom && resctrl_mbm_event_assigned(crg, dom, evtid)) {
+					ret = rdtgroup_assign_cntr(r, crg, dom, evtid);
+					if (ret)
+						goto out_done;
+				}
+			}
+		}
+	}
+
+out_done:
+	return ret;
+}
 
 static void mbm_config_write_domain(struct rdt_resource *r,
 				    struct rdt_mon_domain *d, u32 evtid, u32 val)
 {
 	struct mon_config_info mon_info = {0};
 	u32 config_val;
+	int ret;
 
 	/*
 	 * Check the current config value first. If both are the same then
@@ -1822,6 +1867,14 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 			      resctrl_arch_event_config_set,
 			      &mon_info, 1);
 
+	/*
+	 * Counter assignments needs to be updated to match the event
+	 * configuration.
+	 */
+	ret = resctrl_mbm_event_update_assign(r, d, evtid);
+	if (ret)
+		rdt_last_cmd_puts("Assign failed, event will be Unavailable\n");
+
 	/*
 	 * When an Event Configuration is changed, the bandwidth counters
 	 * for all RMIDs and Events will be cleared by the hardware. The
-- 
2.34.1


