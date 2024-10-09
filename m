Return-Path: <linux-kernel+bounces-357635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3294C997393
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497751C24B92
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D85D1E2014;
	Wed,  9 Oct 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nQxPDdAv"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78761E1C31;
	Wed,  9 Oct 2024 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495782; cv=fail; b=GLq9derXGw2uGfxFDgRfVrOG61yV5I/Zij3D/I6bAPpj6c8xKym0mXnxxptLfXbF8BnVoA4gB8OYBp4wIOD+CWBRnXSCgTglMC6lvZRSXEo5n7paPoHin2HDWTNQUAz8aX1skA3HU5ptzgTbjlwoK2luBeiQ59C6cklK9+22SAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495782; c=relaxed/simple;
	bh=xlq1FmjqHgcjMMoryVpfQnlCL8xGgr+FCAu3OLiy6qU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qh8xdZOXvV1p+gGmTVxzoNh9hfVvsd3ORpmk98m2bvRRkfu2DHzR3PUnfbdiqztRP1i0KzyqcAkoWGDc8z9yegicjqTvhYWNKeMVRxyEp3dmxyj3TWHrMbLsXN0CeIBMdO16+RfsILkqGvGzjswjSeCDc9o4TzDRQBAjDpLIidY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nQxPDdAv; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMg2Qy5RQVuIYg72f5aVhCwqUqLRWet+s5dumcNBivHnemvTDdId9EVSeLxGyXTPuMX2G1hpXwA8+7kopjjy0Ne/sMPDoSnjjiLMIsATfrraPiwGBTtJisy9Ywi3Huw4PfbP1oH4Lzl0juKIJSAZfkiNynsS4heQ5h/ECp4uFXT+4psTXJ9cU31eb5V+TX1JbTBmyNf4hchkxdFUDlnu3WZ+2Yv9IVFDUme92Hn/Mi/uxfTxJ9bKIrmYxx3IEObdC7buaxfNCFnjC8mc+SFYzTQwn/AZvADfpg9ERakZcqLZ4KYD36+ahQCBqrHygkoJQW5Hfh/0dsgjPMgeqLyA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67PxsLWY1X4Jyy+e6y4RSsxsqq08RHlXkJN60Okdyf0=;
 b=jxbrJMSxLRdWjMG9LdYI5PWjgXmuH+Lh/XM9NftnnrSvDEdk+oxvxhwGHH1I2b4lxJEnKyQe/VdmndhmVngqlX2dyTD81BHF+dDVNGPKegFy3FhXhA3ALnidUUHx98U4vCZXoslZZRsG3/BQjIdB7E8Mm3OArAAH1BCarsZ0thUPfVEqrsY3NGoohmGGUomF0AAfL9nWR4d0b5WFGxcn2KdY/AtjABax2G0fa9xFJLf4aGOWAHM8Mhsk81i5BZ4Y242GwuZ7/jR27aFmO3OyZtAQPGbO2bMRVPOvR8Ygg8lCbJmpDKafcZOOeNN9cqEoBcKW8qCnlWkWpCEkunKYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67PxsLWY1X4Jyy+e6y4RSsxsqq08RHlXkJN60Okdyf0=;
 b=nQxPDdAvP5WIVAjvM7pwcuJIsVRDOfkz+iiUhU/zudLSfN5yGAsXQ019x5K6yWbRfQzufPManWk4VsyoPf/c6+ADofRBtNrq+uemxWDEys8uZi5eF6NBBH5odWjtl25wpkhgtnZDDErIkLQxSGI6V16jaqXBYcjzSCm3hI6INN8=
Received: from SJ0PR13CA0141.namprd13.prod.outlook.com (2603:10b6:a03:2c6::26)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 17:42:51 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::13) by SJ0PR13CA0141.outlook.office365.com
 (2603:10b6:a03:2c6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Wed, 9 Oct 2024 17:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:42:51 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:42:49 -0500
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
Subject: [PATCH v8 21/25] x86/resctrl: Introduce the interface to switch between monitor modes
Date: Wed, 9 Oct 2024 12:39:46 -0500
Message-ID: <d3d1238b58ba9d808a8094b2174a52df2fcc5e6d.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: bf438eff-72f9-4e03-5b32-08dce889cc3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m7wsmiiyAnCkqAI5/cqneY6+k801ype1srbxh0GZajgvLbdifTIAKxz9OWBz?=
 =?us-ascii?Q?QEOiXJg7eiMkd8f09ucdaHfz7d/3q1YPyTx8QZoVcwPlYfX/ai1ZLhGe4GK3?=
 =?us-ascii?Q?AFZhNnKg0OgWmhL9L5cyFXkhM2ZYB9/AAxpg5oIkO9F1CFLqPeMeOmrdZ+u/?=
 =?us-ascii?Q?iDuUKXf/m9+1SLfXWiJvUdNRNb4aqIuFi6uEtMSKxWOU7XDU1hoUufbqCUcI?=
 =?us-ascii?Q?HdKPufADcnkxUmrYQwCAjAR8FaWkLRXSbqqjLjspcQA7g3Kw9hKBiv327nKb?=
 =?us-ascii?Q?pNIB3VJx6G8vX5uVl4OgWoj+JdwvOs7pzecWaNLtDDJsMdcQzSQH3a0ZXISL?=
 =?us-ascii?Q?NwvmJXhzvw9oOaE3YhYjPOktKTKKRCmOtBNVyeTcvJikN4Q/NhZmg3F+9o0Z?=
 =?us-ascii?Q?r/bWTkLsD4yHE10rAv+ttbKvcWt8ZVQqhts2LW2XAwDuHOJS6vRXvQIKJi3B?=
 =?us-ascii?Q?VWksd5Qg3oGD+IFLeqbolPJRaaRr943R2oGm5qYdN/vachz5aNTT9KKcWGYO?=
 =?us-ascii?Q?iiCdZWVYZhFioSSFiuCISlZPDy93FA7Sh17RXWdVRmmX3flOuadyAGppPLdD?=
 =?us-ascii?Q?A6MRCUKDJgOj+cn6n5fosXDyQt2K4inbWr+8zQP1NpG7kqqSoTgXz52MBwUL?=
 =?us-ascii?Q?bTzqSbR5iOV8QsrJkg4K7pfBoY6BX+a/Ci4o92qwLfNc7ruAF8My+n6mt9Dj?=
 =?us-ascii?Q?LBSlYwQ/0qJxUez58h3adOb/IpU+B78fvI45bl48w2/1yQGwNd3EAjjld46U?=
 =?us-ascii?Q?dzLq9kZy1rUp4UY/GVlk8NDyjj3uEopNrHw2r50hN1rKRNUvRh6rM/y8okYR?=
 =?us-ascii?Q?htCg5jwopBRxy1rs2WQHAE9pRO9kvH6zqe6Hn/UsFUpr4wqDh/aTUMDnugxj?=
 =?us-ascii?Q?NGPReHOClWdMgV5iPXnNEXy+bV93HuGsTCOp3agttO99WiItPwrXSaGfyCwc?=
 =?us-ascii?Q?BIXhzNxq3OgesuzovGBPasO5DK9dwhhNb+HSFf7xD26viIob9ZXmV9igMLre?=
 =?us-ascii?Q?s9tYTYhfFZ7Fyd8PFqPt+NhpoDFBJPVvmaud7DoDx4gE//n4veMxVO4vGAnL?=
 =?us-ascii?Q?5n9nonUblqptvSvG7W/3Hg/GYXcg1uRfyCXLX1MUSmn86rEWqIxUddSFALcL?=
 =?us-ascii?Q?7Mr16Fnv1u6Vu72cWhV77hlkcmKcwCdPIbjzsEOG3927FO3b5lDxJmhJQR1W?=
 =?us-ascii?Q?o5S9ngDFNT7oglH5ZZ28gGUKtpa3n5Y6OHPyaaVUE6YhREPHDRovVOpd0Q+f?=
 =?us-ascii?Q?5+DkAZxFW9wB3Xf9+xXeJn0jXoaU3iAfcm2xKbCo13pVc4oJvOPaDcDnXBEm?=
 =?us-ascii?Q?dpTzN5qoqgLmrZByX02gMvpsEP06b8eOkVtRm/PKMCSpRbQcMKvDvY56x/Jb?=
 =?us-ascii?Q?nG/NC9I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:42:51.2967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf438eff-72f9-4e03-5b32-08dce889cc3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164

Introduce interface to switch between mbm_cntr_assign and default modes.

$ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
[mbm_cntr_assign]
default

To enable the "mbm_cntr_assign" mode:
$ echo "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

To enable the default monitoring mode:
$ echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

MBM event counters will reset when mbm_assign_mode is changed.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Reset the internal counters after mbm_cntr_assign mode is changed.
    Renamed rdtgroup_mbm_cntr_reset() to mbm_cntr_reset()
    Updated the documentation to make text generic.

v7: Changed the interface name to mbm_assign_mode.
    Removed the references of ABMC.
    Added the changes to reset global and domain bitmaps.
    Added the changes to reset rmid.

v6: Changed the mode name to mbm_cntr_assign.
    Moved all the FS related code here.
    Added changes to reset mbm_cntr_map and resctrl group counters.

v5: Change log and mode description text correction.

v4: Minor commit text changes. Keep the default to ABMC when supported.
    Fixed comments to reflect changed interface "mbm_mode".

v3: New patch to address the review comments from upstream.
---
 Documentation/arch/x86/resctrl.rst     | 15 ++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 75 +++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 99ee9c87952b..d9574078f735 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -291,6 +291,21 @@ with the following files:
 	that case reading the mbm_total_bytes and mbm_local_bytes may report
 	'Unavailable' if there is no counter associated with that group.
 
+	* To enable "mbm_cntr_assign" mode:
+	  ::
+
+	    # echo  "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+
+	* To enable default monitoring mode:
+	  ::
+
+	    # echo  "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+
+	The MBM events (mbm_total_bytes and/or mbm_local_bytes) associated counters
+	may reset when the mode is changed. Moving to mbm_cntr_assign mode will
+	require users to assign the counters to the events. Otherwise, the MBM
+	event counters will return "Unassigned" when read.
+
 "num_mbm_cntrs":
 	The number of monitoring counters available for assignment when the
 	architecture supports mbm_cntr_assign mode.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cb2c60c0319e..88eda3cf5c82 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -888,6 +888,78 @@ static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static void mbm_cntr_reset(struct rdt_resource *r)
+{
+	struct rdtgroup *prgrp, *crgrp;
+	struct rdt_mon_domain *dom;
+
+	/*
+	 * Hardware counters will reset after switching the monitor mode.
+	 * Reset the architectural state so that reading of hardware
+	 * counter is not considered as an overflow in the next update.
+	 * Also reset the domain counter bitmap.
+	 */
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+		bitmap_zero(dom->mbm_cntr_map, r->mon.num_mbm_cntrs);
+		resctrl_arch_reset_rmid_all(r, dom);
+	}
+
+	/* Reset global MBM counter map */
+	bitmap_fill(r->mon.mbm_cntr_free_map, r->mon.num_mbm_cntrs);
+
+	/* Reset the cntr_id's for all the monitor groups */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		prgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
+		prgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			crgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
+			crgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
+		}
+	}
+}
+
+static ssize_t rdtgroup_mbm_assign_mode_write(struct kernfs_open_file *of,
+					      char *buf, size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	int ret = 0;
+	bool enable;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if (!strcmp(buf, "default")) {
+		enable = 0;
+	} else if (!strcmp(buf, "mbm_cntr_assign")) {
+		enable = 1;
+	} else {
+		ret = -EINVAL;
+		rdt_last_cmd_puts("Unsupported assign mode\n");
+		goto write_exit;
+	}
+
+	if (enable != resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		ret = resctrl_arch_mbm_cntr_assign_set(r, enable);
+		if (!ret)
+			mbm_cntr_reset(r);
+	}
+
+write_exit:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
 				       struct seq_file *s, void *v)
 {
@@ -2115,9 +2187,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_assign_mode",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_assign_mode_show,
+		.write		= rdtgroup_mbm_assign_mode_write,
 		.fflags		= RFTYPE_MON_INFO,
 	},
 	{
-- 
2.34.1


