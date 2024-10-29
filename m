Return-Path: <linux-kernel+bounces-387836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5789B56BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16BA1C20D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50120C46D;
	Tue, 29 Oct 2024 23:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YlMPuFmw"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17AE20C00E;
	Tue, 29 Oct 2024 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244214; cv=fail; b=R3M/zPmFdhR7E9xTmCRLnYJUqzY8CkoCo/3zWiFIjNac+lY0okZXoFxRAOmxEiIa2RMx2jmnLyoBhlAxWZVgZVzhr2HbtJWEi1x+xeKiOL64EgUkJEXzKUBlPPVkYaeLQcF658kcRtxy5mXfac+0DKEqeva4f57Kv7/ox6rwjjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244214; c=relaxed/simple;
	bh=yZAJT4uX2VTMRwzX8ufpwX2XBXVezXu6R9QcB8lidWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FErW2THkupQCO/BU44L6Nan3Om92pXdWvZLyZAa9i/d4bEDx0z/scbWV2r4hqD1A+oDE8W1EIXLpX1FuMIbZBufFFBX152QAVM5R0yO6n7lFY7VPAvHsmYYVeFzmlyR0QZ9ihRtdXw1FuUrh8NcYd3PyPykEhxZKyMzUJN/TDDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YlMPuFmw; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fN3CBe8tTTsh8JLlWIIx+nMdLFNseHokhqj7TkGc76UnR5s+KdMtFcI8p1f3oAOU4bIT34ogzMUuAzj3BgezVKnL7tVyN0HsFuHwpUpAoPJ46KxT1k1ViHvgc0NO1+c64FNH0velHZaF+I7o0/Y+w0iaiy3hWy+dUiQ7moKsyY53+qflPfaj+mztwXAsKsRNfOO2IElolAuMChl0x2wsoj3wLV/hd3mMpB5EZ0Z8nHY3DOaauWnrhEnDlqA8hSFUwliuFR96nA9K4L+7g9AUJYazzdw9HHhNQEyhD2VxQHRQqT5Fj6Bj4WD7Hc577QUj0OIWWsb/KMmUJXDzmvdIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiOaVJZfAOPm06RSE1UzskqReBP4js38qM+vdJpQm+Y=;
 b=Bt2fyBBHtXm9/CJq7kEZ3q0pMC2WbUAg6Htv4YgBVSFigaS7bOkxS9z4wx8o5QmOCX2jFbmok+8RHnKlYkDnuAiCIyxUvJgg/QR71o+27q6S3ZWe23kHFpbBcdG+zNYb+s7r8DklaY+G1/R7izp8F52wv3a1b3z38VQsibGNt0qnQaxMV5mGHJdjEATB2fiqdW2Q+E8LVty/7oCKLKeBul3N1DO3HM2/VwVLaqtEctY/kApCpiOsr7261n5evgmauIAYOZr0rDmF0QEi23v9pmHvxsreJfBn3lsxZO46aA0C23PhDzNPaVhU3+oBPTrhKbzCp+RpCmvgOhmjhhzKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiOaVJZfAOPm06RSE1UzskqReBP4js38qM+vdJpQm+Y=;
 b=YlMPuFmwiAzT6xL4nIAux97CxGTSYsK+MjEuFeSDgxnSH4xAmUUqK/RoueFRhhakSXFk6Ty6ChKnPX03mlHmwF1ag70kxxYSQ6Dfnzs9H6ZTIkqCF7YRbXauTRbQGnfNAgfOU6fiXKj7mdTIMl2RrVZ1k5V8aYQO6wAxDHfz0nE=
Received: from MW3PR06CA0015.namprd06.prod.outlook.com (2603:10b6:303:2a::20)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 23:23:28 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::f1) by MW3PR06CA0015.outlook.office365.com
 (2603:10b6:303:2a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 23:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:23:27 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:23:24 -0500
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
Subject: [PATCH v9 09/26] x86/resctrl: Introduce interface to display number of monitoring counters
Date: Tue, 29 Oct 2024 18:21:41 -0500
Message-ID: <447a268e3cddcebc30a0b2c5ccb321e3c6b9c8d9.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: e8df657c-494f-401b-1181-08dcf870b198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I1/DduRQwgPIVmspU4SvfjFE7yxXaOq09LZjT0pvbY/ioMmRSho6LGatZpMP?=
 =?us-ascii?Q?30UhuCOfBIBCnxYhWtXg47/p5MmarYQ6b1LkdN8cOI8GdsU8l1EWkm1K5oPC?=
 =?us-ascii?Q?iRckaQwpfV5vVr5Bh2adx/0VpX1NQSbH1p5hHztFntMt8VCEawQTuIXgwLqS?=
 =?us-ascii?Q?sZUAQrf3rpOpanqnhsp3+R/G2HWDsIY5km1VLYVR+R60x0FkrTF4UUIcymVw?=
 =?us-ascii?Q?+MVf9DCQdOoLuEguEffyQin9wd54JJexEbx/auFZPvJesUGbs9/t8yArJ1pp?=
 =?us-ascii?Q?55hKWX4XVIDKKV8UDuhDCE4XvDC0GXPVfxjr+HRlZMy4d1aGZtmX6SpbxwDp?=
 =?us-ascii?Q?hbcMhTywobyfHE7ii3abfl/La2D4DmXPIWkZaeYZDVYL1Y1Fw3C76fpTChJ7?=
 =?us-ascii?Q?I9F+/9RZDisanUgJIfDqzeCo8ImUdLS6ffkXn8IcTRVIQRblxabcPGhMkdSA?=
 =?us-ascii?Q?xFCANFHOc0EIHolMkjHVp+MyGADh1Qt8SEPf5mRwJmvDDKjBKek++5YBLl+e?=
 =?us-ascii?Q?LQNwJPj5vxxVCCS0gqpuZoOIDfJSgzVl/yFSZRjvNBqIJkU61L0Jr0jcRnnM?=
 =?us-ascii?Q?oCteEY2FdiR2DoqvIxdzeA+sTHMLqyjOp2sRgBWJyu3qKv3zPgyP0pyGv0z6?=
 =?us-ascii?Q?pCjLc9D7ADNUAm7tWniPfveVFdRsAnJ6LZxqioWAgHadoX+RcAgh9wQX35GN?=
 =?us-ascii?Q?DVtxaiQCObTsIUAAtw4wtsBbq5+kXSDkcrmc1LjwAMsuI8XF2V7KOLu3kPOt?=
 =?us-ascii?Q?MOjIbmuMtjjgXf25hzIyE4xeiRBvIZ0bW7VxpxiwHSVcFrY9uUpuMblrC7fO?=
 =?us-ascii?Q?Sn4m9jokZ5ad8/xC/kPxX+WgnXa9MFZlG5CCVoUpuTSreBE0lF2t+oELy13O?=
 =?us-ascii?Q?aYk03wUSsc0roXzzDQDwoZNDE0JHDrVdPcKLOHGiaPjR2MwRl/gPTSROuvNC?=
 =?us-ascii?Q?nrM4bIIucxP/GXvYoKNWvUU6CKDgVnY34o+JYnmWAe0O2K5qL1Vt7ArJwdmg?=
 =?us-ascii?Q?dCjpYCmCO7GEy/Dqy2LMBog6McD+P1PMUG3ou1vUByWEDGxfztBZslEyRle5?=
 =?us-ascii?Q?BkQiuel6ge2YC78cEI2uLQYk6E9eEshIpmaESuYrMVdXwvwH5xA4HLRDOt69?=
 =?us-ascii?Q?W83o5Yy0YezdmvAzX/a2TA75KTcd6unA4LV0iUAxkroghDjgNj3LizYT8bsw?=
 =?us-ascii?Q?Gn9FrEq2lq/UAxi21Vae2HImJ1HK22TYn9slHCwPwn5dnMgk7144FAoo3V8c?=
 =?us-ascii?Q?IO+psdPsqzKtOVTy+3YD4FtiIZDaYV72E6VXetE9DwR87X/auSN64+zAduwi?=
 =?us-ascii?Q?sbWG9bSNWsaBH8hRI5pgBnsSZEEve7n4pvJ4E+wqou6rh+SvfFR5EB4wNF9k?=
 =?us-ascii?Q?pqb82dJ3imA76+mv1uS61mc0iQ+tGJSJrf0U3COMkyU+XfYRYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:23:27.7764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8df657c-494f-401b-1181-08dcf870b198
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834

The mbm_cntr_assign mode provides an option to the user to assign a
counter to an RMID, event pair and monitor the bandwidth as long as
the counter is assigned. Number of assignments depend on number of
monitoring counters available.

Provide the interface to display the number of monitoring counters
supported. The interface file 'num_mbm_cntrs' is available when an
architecture supports mbm_cntr_assign mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v9: Updated user document based on the comments.
    Will add a new file available_mbm_cntrs later in the series.

v8: Commit message update and documentation update.

v7: Minor commit log text changes.

v6: No changes.

v5: Changed the display name from num_cntrs to num_mbm_cntrs.
    Updated the commit message.
    Moved the patch after mbm_mode is introduced.

v4: Changed the counter name to num_cntrs. And few text changes.

v3: Changed the field name to mbm_assign_cntrs.

v2: Changed the field name to mbm_assignable_counters from abmc_counter.
---
 Documentation/arch/x86/resctrl.rst     | 12 ++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a93d7980e25f..2f3a86278e84 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -290,6 +290,18 @@ with the following files:
 	mbm_local_bytes may report 'Unavailable' if there is no counter associated
 	with that event.
 
+"num_mbm_cntrs":
+	The number of monitoring counters available for assignment when the
+	architecture supports mbm_cntr_assign mode.
+
+	The resctrl file system supports tracking up to two memory bandwidth
+	events per monitoring group: mbm_total_bytes and/or mbm_local_bytes.
+	Up to two counters can be assigned per monitoring group, one for each
+	memory bandwidth event. More monitoring groups can be tracked by
+	assigning one counter per monitoring group. However, doing so limits
+	memory bandwidth tracking to a single memory bandwidth event per
+	monitoring group.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 9209fb3dc78f..e0d8080dcdcf 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1236,6 +1236,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			r->mon.mbm_cntr_assignable = true;
 			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f25ff1430014..339bb0b09a82 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -869,6 +869,16 @@ static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
+				       struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	seq_printf(s, "%d\n", r->mon.num_mbm_cntrs);
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1940,6 +1950,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_cpus_show,
 		.fflags		= RFTYPE_BASE,
 	},
+	{
+		.name		= "num_mbm_cntrs",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_num_mbm_cntrs_show,
+	},
 	{
 		.name		= "cpus_list",
 		.mode		= 0644,
-- 
2.34.1


