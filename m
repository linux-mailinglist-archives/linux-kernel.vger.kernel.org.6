Return-Path: <linux-kernel+bounces-316043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5540096CA50
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BE71C254D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D018D656;
	Wed,  4 Sep 2024 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dMakgI6i"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFAA183CCC;
	Wed,  4 Sep 2024 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488629; cv=fail; b=E8o8MossQWz8xrGbT+IhvTcPWZyIEQeZ4V7Gms+p0YyK3BuMVJA6JB0gNxoAVAbzt9+dZLo3i4Hrz5pxl0zuE57dwRnWwueHt1gPrJyS/sJh4iEzAZJ+7/nC0cllRmtJyDO49DEqdwJQzHxuIOyxf/Mp5lTgdQ2NULi2XrclYF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488629; c=relaxed/simple;
	bh=NcSEIKdM6VeA/yk0iQ+y4wrjEl/+UX97/gBFoEafgsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pk2Xnq41Tbd4766Hf/4T+xGllBeORa0m3xridDj4/f4a4Q93TJRqzxtnHjDnRfqgNYu79BTMDDQpF+TryUR/6PrYE9CW029RiAvQuNbSDTOG/eOv4AyQYJSGKCgMk/KHPobb4B/I/7/zmquyRVJ/oX71STGYKQYSm/jc+TDYsqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dMakgI6i; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnC8aC5uehSr2OLmmLe6rcUovcbm0kHd4OyVJOd7s3YtNx1ZDf5X+cNjbDiVOnNNC6Ikt0R5s2L+hmEGi0cWI+2+MQ50pb/qPMXDaBJI+ri05QleqURGqbSUZwRhpaqILdXYf/V2joxRqKmc7JFgUxWlqXtrPvN9AhIA4t6Wm86RpVSFnNBdr0H0RhAjV+xWUlDn4bWgmlEDDyISgWRqWA4ydheOSWd2U6nJdkjfOzB5LQxjE3U/oD6HankiQN3rRXWvUNPFQHLBXnBApxxN5dOfdDjspvqMxKphznbKxPlG1V9WZsbWANOsaFCCyw81VsSX/dFSI1sA3/09b+hWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EkOgz3CewqjYnU9X4U6dva1vk3/3causYz5ruao6v4=;
 b=wTm3gsZaqHb4G0QiYe5V4Wj+qp29F2vUe7AoZ1oDm9Xq//PlfoScivrZsAqCR3RWQECA2PulNuCybYwfsJovQXS6ohF5D/nvyizocKSDjxbs8fyvM1KRhTMy2lten7A0MIYrjYDM7SZ4k9xH42KNaczSGAdijBxvIPKTMqWRewI9trQlZchZH2lHZEUDS63wDpJrvXIZe8y9Me3FfFMal0RVOAnJax11rzZXbmlxryrR0J4jHt0DqNtGlXkQyzv+QgkN1qdugC+drh3reh3fDjiF6cPxhiM4XOZzkz686+us4wDLuP9hQWOGN9+5P9UZmc2ec/EiCJiIsDvR39rRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EkOgz3CewqjYnU9X4U6dva1vk3/3causYz5ruao6v4=;
 b=dMakgI6iIiaIi1bxE4fuEE2FAB38jyXqjeX4p6/eowCbigdTuauP2claOJEfTLZBzqW6u6f7XxTXMnUgrqk69SfntGf8GU+5pIcDjGGMatAXAelOnPOGrC39cCQCgEBHstAWcV00FcDKK/93eppRYVTIMVdqwkINAiZ5bfeXV3k=
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 22:23:44 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::13) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Wed, 4 Sep 2024 22:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:23:44 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:23:38 -0500
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
Subject: [PATCH v7 14/24] x86/resctrl: Introduce cntr_id in mongroup for assignments
Date: Wed, 4 Sep 2024 17:21:29 -0500
Message-ID: <419261f76baa0a156249b38279ee7d319b477f15.1725488488.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: de451cbb-b1d8-4c63-d8a8-08dccd303cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s+jquJGYC9VtGbamlNfXnRCYxbmwwUmPBPl8aIIBEbhXZv1z4No5G8X1niB2?=
 =?us-ascii?Q?qa10m3aMNPkV5x+JE0hQnRfHdQWnPcF7cCFFS+m9gxYFZbXTI+MFU/0yol2c?=
 =?us-ascii?Q?mCoNTTJ2mlCQE74XDhnQzn/BaE5Zu1u4xyabZHIatiNNalPxKDr39JLKVAYC?=
 =?us-ascii?Q?ahzpYmcJFMNpYLNICu8Ln4ZT/vNl8Zd+kNcK/R5fd/PtWZVrPOxDBDOH5LRY?=
 =?us-ascii?Q?x2JcOyaTKe5ZgsqeTLf1iozB/Qwx545ZpCd2DlNEvCFhPJQ/px0Y6GYaob+Y?=
 =?us-ascii?Q?0ZqWwu7ii1/zW9EXkUBdTujegAcRTeOXHKJ/FjXVJyennh+EWGMeQ6tALcDk?=
 =?us-ascii?Q?k1KG1ldfen4E8O/oUA/epFZPB8zdqKa0u7HVVJE4IajeJ3GTxWzw4wmraJ1i?=
 =?us-ascii?Q?CvvAgjB1MEAZPaBA0kc8GNrb2t8LEO23+kXP/Lodm/gvR69Syt5uWdKo2Zd9?=
 =?us-ascii?Q?dnkCMzeX40rD6X493bw90UooVqmYsTo08X2xDeAVVBBGSsF7CbaO8R8vZqKH?=
 =?us-ascii?Q?AQQ7RyLG2j88JWudB+9ezozQqM9aZ3Qkt5e7tX443SYRVrTV53RY1z/D/IEe?=
 =?us-ascii?Q?KWJNF4tx9A82zrCgUUt0Os9N6YZbjDLTHB7iyrcuOIAADNb6hCOlP5pr/uoe?=
 =?us-ascii?Q?dTXW4F4rii+zmGadNkLXIzYZadAxI9kij4a1+rvHJKnKGe0jeN7AjjrNgz3+?=
 =?us-ascii?Q?3epyNYEucfsWP+6CWGEsjY89DkyvYrCGBS3uYtklcbon5qUeAHrCdZTQNBkI?=
 =?us-ascii?Q?IVmsRoJp9OFOjpWjRlDrnp6jVXBYJSlkkak05AjUh3wvvwc1eifCn4bq+sVa?=
 =?us-ascii?Q?Be65JKkzB2KCkzUVoJj5RoHbzOB8MwJg98ac7mT9/ZpGnf/R88hlRvt+aBa2?=
 =?us-ascii?Q?0AGgkQYkQ/4i9r2TR62AwmbfsprE+usRE63qsZAICLi98WdhOrdORAfpeQnG?=
 =?us-ascii?Q?dJkFTBaTKYKKi5MIw7pp4WvYbNrQWFmHE+5nx/VvoMOlx2ImZDCT8yTVbRwi?=
 =?us-ascii?Q?lP695P8POiuHMW8jnP/XVwA6nKiElo1wOwLhUWsaHmPQ4BJ8CeZdtI+yTG3O?=
 =?us-ascii?Q?Avi3/kiDAIAGV0qYoeq1MaHZ1kKURPj48et7v8bZ4Hwu9o6lwXC15f72NhLi?=
 =?us-ascii?Q?tfggG23iO8smd1IlmxCkbIxWlQbglt/h3xCFL1kCGMrxqILDzjNWwQ+X2aPt?=
 =?us-ascii?Q?mVgd8tHwQ05o9tiPtWpB8F4U0c2EEKsXjlcku3GClR3GUAliPNZbVXBb3/J4?=
 =?us-ascii?Q?pIYiTVJehGDO8F9BD9ayvAa4Nh9RbGOWuh5NIXzl4QfcsT1VWQaSylS1LmBL?=
 =?us-ascii?Q?RFsH6iGBNKLBliOeWInRdaS85xDtepIvAorcuYsQtOc75BH4QYONF1ZJlT/N?=
 =?us-ascii?Q?hfhSw2zPewi8XSHX9bRuO9SW856XGkb51vBpTXRcbSgRfamH50FrwFH+ZYjX?=
 =?us-ascii?Q?CDSj5vQ34woMFgRyab116gYaRuc2ZusX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:23:44.0781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de451cbb-b1d8-4c63-d8a8-08dccd303cd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662

mbm_cntr_assign feature provides an option to the user to assign a
hardware counter to an RMID and monitor the bandwidth as long as the
counter is assigned. There can be two counters per monitor group, one
for total event and another for local event.

Introduce cntr_id to manage the assignments.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Minor comment update for cntr_id.

v6: New patch.
    Separated FS and arch bits.
---
 arch/x86/kernel/cpu/resctrl/internal.h | 7 +++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 27617fe592ed..e0ae8b0b45b2 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -62,6 +62,11 @@
 /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
 #define ABMC_ENABLE_BIT			0
 
+/* Maximum assignable counters per resctrl group */
+#define MAX_CNTRS			2
+
+#define MON_CNTR_UNSET			U32_MAX
+
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
@@ -231,12 +236,14 @@ enum rdtgrp_mode {
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
+ * @cntr_id:			IDs of hardware counters assigned to monitor group
  */
 struct mongroup {
 	struct kernfs_node	*mon_data_kn;
 	struct rdtgroup		*parent;
 	struct list_head	crdtgrp_list;
 	u32			rmid;
+	u32			cntr_id[MAX_CNTRS];
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a014d5f4c0b3..7fa92143daa7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3529,6 +3529,9 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	}
 	rdtgrp->mon.rmid = ret;
 
+	rdtgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
+	rdtgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
+
 	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
 	if (ret) {
 		rdt_last_cmd_puts("kernfs subdir error\n");
@@ -4083,6 +4086,9 @@ static void __init rdtgroup_setup_default(void)
 	rdtgroup_default.closid = RESCTRL_RESERVED_CLOSID;
 	rdtgroup_default.mon.rmid = RESCTRL_RESERVED_RMID;
 	rdtgroup_default.type = RDTCTRL_GROUP;
+	rdtgroup_default.mon.cntr_id[0] = MON_CNTR_UNSET;
+	rdtgroup_default.mon.cntr_id[1] = MON_CNTR_UNSET;
+
 	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
 
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
-- 
2.34.1


