Return-Path: <linux-kernel+bounces-387847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9549B56D9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC731C22537
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2B020C03E;
	Tue, 29 Oct 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sb3ZAHGT"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5537520C010;
	Tue, 29 Oct 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244305; cv=fail; b=OVYbQHPhn5teSyaDXBJsm3I8wp2Zgo/Kv5EHmbEmToD+pZF9YLj83lRjNQzl5uTAv5XvBgSWjqT3DtxKU2h4QwR8M/SzCvGja8Avcp3faFEXhHQT+dO2vysaUPyXbPBmp2R2YNpv9OYJqiRnikPe56RIQkyrB1fdh4iRhn+xsmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244305; c=relaxed/simple;
	bh=cmPycCslCVhqH15OPdzDaJH7QBDqnAczNtrx0WNpumA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qi+iOSTLbKiuFJ0quaP+RJLwPoyY/Fk01dAzvKD6nD1/W5CXK4HB/oPRjHV24WC+H+UGh983hZFoV7OgEN2lCZ1OtYYMpyG6sJ2C5PnoUkrIkUVXAWs/1U961agQzpsWMhx47/KbqBM0wwwQBvBtMjN7Zf/NSYPsvT2hGHN5fZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sb3ZAHGT; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqR++lBHlPXS+JG4MTV2xAi1HvYrunyzNoKHjzWF166/UTfH+J8rmYOAP/xrQm/n9swLdzExNEWx1Is26uYEN/nWMqCIik8Nd8CND77FvG8vNX9VDKQ5SduAWkp1HiogVgXp10PlfJkPYey6GxihFZIslwOzYYu6j/Pb+E8O7RiBnbfsnP+Trdl1iXuT5SNA9S4/zpy6EsJwqpchNyQSGrK7D0DOGFP2ZzGu7zbBgy8DkzQ3gmqDXvCkDi4CZfcyYd1vDXyR0JuiQBusvkhKu4ctTMF/VYp8+5ro9CBGb6MTRFfiHbmrRC5R5fAvMWVn+jg14R+hd39Hy3wr3qokoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OEC810PVHXizf+eNwCxetZg1u0KhT4uJPuZ3YYxUqs=;
 b=k1zbw9tqpWWzEKy2UwZn4rhAA67MFHldboGdGiaS8/tHosg9DaNXslgBOVm7hzOS7yw1RHns+ubkLXjBaMGZc2/4kppYTYqV1dJ05MEbx6QWT9qs7N5ayR5xuXMxlW5hY43jDFhdtaGnZdtyGI/oubNAJZZRAoPOhtq3/PjU+Otrk0JsyNElHvRqykX3+ZS4/C2zXyTOr790odD/pUo++oRgU07M73QlTVuIO5/1VqZOWdZwXUueLgkKYM+qliKBs0apjSFum9l66At3LH7fnFIKehJ+7K/RrFA2LqqeKkyj1/35dfF/jKXWDCSroAM+pBhXtvzKQr6pQrW4UAEUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OEC810PVHXizf+eNwCxetZg1u0KhT4uJPuZ3YYxUqs=;
 b=Sb3ZAHGTxbgJ80oY2IwEnlDNWr2lEL+dMbz+dyjmCNNI8C47ZanOJUZ9E0knkVV1J3M+HcqrrcgCQmAB2tDDRt9sBMes9ih11vgeU3h+le2E12UUiS3cxTn2v6hTSj62xE6XJpK5Ln6IJhnBuW6jYvXAxgnpq4baYmcTZqwJbVY=
Received: from SN6PR08CA0026.namprd08.prod.outlook.com (2603:10b6:805:66::39)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 23:24:55 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::4) by SN6PR08CA0026.outlook.office365.com
 (2603:10b6:805:66::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32 via Frontend
 Transport; Tue, 29 Oct 2024 23:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:24:54 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:24:39 -0500
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
Subject: [PATCH v9 18/26] x86/resctrl: Add the interface to assign/update counter assignment
Date: Tue, 29 Oct 2024 18:21:50 -0500
Message-ID: <3851fbd6ccd1cdc504229e4c7f7d2575c13f5bd6.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 4677ecc1-c9b4-4b00-04d9-08dcf870e584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bgnk7U0BfRzUJUIat7IwsRDdqOSysiHdA6xJovZ7W8bjY5xiC+owlEGieJNS?=
 =?us-ascii?Q?x86YJJraaYBG3VtcC16qisRpoB1R0p46JzFGfunCZ6TARngb0IEjShNW8kJM?=
 =?us-ascii?Q?tzH0UdqebCUX4X7XLhqhdyM87UULuv5q2ir4CeuVwAvD6gcAkuqEmzo3Ea5j?=
 =?us-ascii?Q?bvrhbXzAqlcTl7oQUsFrH4icPDzRzglTCkzDiFNZHVkKal4OczZ0z1VZAUB4?=
 =?us-ascii?Q?O3xBWcXoDLlngQrAxR8M4DDepRFY2bckRhCRK/5FxIFX1DjhVDrSH2pbJT6I?=
 =?us-ascii?Q?CAoYKbbohDxOOf7VX3sK/ES3hCUyVcxGNjiPg0zOIRyRotnjHjhSuYoNjNdd?=
 =?us-ascii?Q?WI9qYX19ppcqJ5YUiWFRxIp5p0GZFJrbzEGAJBKOrSmjCg7R9/BKTJTZnqDf?=
 =?us-ascii?Q?YGhyI+cKScKVzi4mFQQF5eQz2AJ9WW2WyRW/RGIVaHfkRbfxif8RKjD3Zrxe?=
 =?us-ascii?Q?ptJLOrRQ99LXICWNpjBK+xWt93ztc7EZgKvxYsvvhCgz1WX8hzxbbWeUCov7?=
 =?us-ascii?Q?3WybCuBiFYH3mBILa5ipUxzgHRIGnXy88CpC9Hvi7IP5FFsb9YmghQN2G3Pj?=
 =?us-ascii?Q?BlgNkfAW7/ZvDmk8883RRxtYizPqLnxSocNu6zoPB9vjnhbPUQMlTNCNnQR4?=
 =?us-ascii?Q?KfllnDj6wOEem1H8obETBnvY+8MrsxENbPx5vdX9tl3T265E8Qnlbq97JF3o?=
 =?us-ascii?Q?P8IliSq5wesee97hCVs6hcDXphebExkzhtQj2470YMmWuSGOvKzS0PyraCBx?=
 =?us-ascii?Q?XpW6iw84wwH+h7cArmiGy199jzChG+f8XPCIY3K2lHUz66+U2sxCaH9Wmd7E?=
 =?us-ascii?Q?SvKK4q1esbn4yQu8LdZLXeSvVvchjiF9FLMMyWYREOMJpLt3l7n2OV3T7g5P?=
 =?us-ascii?Q?gHkjtNFbd7tpAtz3qQkUCgRz3CLmYXxQnArRPjczxIOhniWgTmnj6b3t03RQ?=
 =?us-ascii?Q?IwhpNZUiOUCs2uK0eBIENf1+0rrsul3syZUtQjFaIhAJGZhjyw0GYIYkcb3A?=
 =?us-ascii?Q?WpWE/W7ROFgOYDITU8+9X3ouvqjcFzKIvZfdWk7LWs27wCeQafXVTPnRYuX3?=
 =?us-ascii?Q?KLk9U10YBLyaCNGD17ARNgaMRsSNi4eGCLSndxTGBa3v4QWnwXLAXgzgG7Lf?=
 =?us-ascii?Q?K8jUHkKRveW5kfES8gCwMGAdD++0deeZy9Jq/fLpTlbPSzdyW8o/4LpGBMfo?=
 =?us-ascii?Q?mMd2CFPXZPiwTCReYsUoRS0f9c4enxYGgy9g22z8TXL6qSsn61rlTI7gvQJ6?=
 =?us-ascii?Q?wLbOcdNskVhGUcaHmGjQiPvO3U9RhgdB3eJqA79jPp+j+2p3DKS1x93mK+Ob?=
 =?us-ascii?Q?nmnE54p0yHLTfQNkU4XgvPpTvSDAxDOvB2k3qxIuJ4oAwXfgfvV9OSl0ZCpb?=
 =?us-ascii?Q?oiMm+iWTTjU1ck+8nRqW5VZkGYll5SwxpBV5xY2b7W/s1D96vA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:24:54.9646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4677ecc1-c9b4-4b00-04d9-08dcf870e584
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583

The mbm_cntr_assign mode offers several hardware counters that can be
assigned to an RMID, event pair and monitor the bandwidth as long as it
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
v9: Introduced new function resctrl_config_cntr to assign the counter, update
    the bitmap and reset the architectural state.
    Taken care of error handling(freeing the counter) when assignment fails.
    Moved mbm_cntr_assigned_to_domain here as it used in this patch.
    Minor text changes.

v8: Renamed rdtgroup_assign_cntr() to rdtgroup_assign_cntr_event().
    Added the code to return the error if rdtgroup_assign_cntr_event fails.
    Moved definition of MBM_EVENT_ARRAY_INDEX to resctrl/internal.h.
    Updated typo in the comments.

v7: New patch. Moved all the FS code here.
    Merged rdtgroup_assign_cntr and rdtgroup_alloc_cntr.
    Adde new #define MBM_EVENT_ARRAY_INDEX.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 87 ++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 00f7bf60e16a..cb496bd97007 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -717,6 +717,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
 int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
 			     u32 cntr_id, bool assign);
+int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1b5529c212f5..bc3752967c44 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1924,6 +1924,93 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 	return 0;
 }
 
+/*
+ * Configure the counter for the event, RMID pair for the domain.
+ * Update the bitmap and reset the architectural state.
+ */
+static int resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			       enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			       u32 cntr_id, bool assign)
+{
+	int ret;
+
+	ret = resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
+	if (ret)
+		return ret;
+
+	if (assign)
+		__set_bit(cntr_id, d->mbm_cntr_map);
+	else
+		__clear_bit(cntr_id, d->mbm_cntr_map);
+
+	/*
+	 * Reset the architectural state so that reading of hardware
+	 * counter is not considered as an overflow in next update.
+	 */
+	resctrl_arch_reset_rmid(r, d, closid, rmid, evtid);
+
+	return ret;
+}
+
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
+ * Assign a hardware counter to event @evtid of group @rdtgrp.
+ * Counter will be assigned to all the domains if rdt_mon_domain is NULL
+ * else the counter will be assigned to specific domain.
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
+			ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+						  rdtgrp->closid, cntr_id, true);
+			if (ret)
+				goto out_done_assign;
+		}
+	} else {
+		ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+					  rdtgrp->closid, cntr_id, true);
+		if (ret)
+			goto out_done_assign;
+	}
+
+out_done_assign:
+	if (ret && !mbm_cntr_assigned_to_domain(r, cntr_id)) {
+		mbm_cntr_free(r, cntr_id);
+		rdtgroup_cntr_id_init(rdtgrp, evtid);
+	}
+
+	return ret;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


