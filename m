Return-Path: <linux-kernel+bounces-276995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC804949AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD2F1F2057F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A456517A902;
	Tue,  6 Aug 2024 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yif36IZf"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13376179967;
	Tue,  6 Aug 2024 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981765; cv=fail; b=M33kN4G5QRNKMvgWBVM1R5vMd3Vv14xoLsawVtBXsg+c16iPmG5ympH5WbG72nlDUmkqHKR+YEt96ILsYQgwqwab9e3mEK74plk9iNbk/cDf7dtu4sFH9uQDOlIF5XAlmJkaVAinGJ0I97hcqUoF3aOeLlpIc7X4rlfUl3+OL18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981765; c=relaxed/simple;
	bh=tdHjo9T4ycAO56/xBxZHmei05ipK5GzS1vleKOZ/z50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WULV/yHrtD9HVlTcVhPsScCJGDyU4nOG3x9O8W1VjBuVyBv7hFaRMY5XxzHCGoghhIwr5XL2mkf/Q4xx5aMVDJjOd3iyNMN45nSeL3f1a7EYU50g4f0cBZ+1eJPu1o3+cx3idurijaAw/1tD/81NCG646PZYu9zM/AsFLimhags=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yif36IZf; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmpuB+f6WUIr0G7fsF/1I0g5WlpVReOzIQdD2oyAzWd/SI/Jrv4ZFJOzeryJjU9es53xZEjKMpMbbrRkwfXaKoaw7TI4V6tpB0o32ttpCXyKf7DZWbRKKo6SMybLI3Guo8ji/QPt7ICL5j5xgYYn6FF9DDMfKNbfMAMS/rHzLgvP7qYnN/UYWmA0tONrtBWtU33SNEHOM73q4P50g/r5KqFIQtui3Si4f7UYLhOpiJXm38oSY7vX6iV8fbNT+kUe11Hdcn1lpn3qcldIAyfkt8EZK2UJA00LN4cKcMHLb1RClmnHPGhRGx0en/fXgD/PTxok2+mCC8AYwdp0axOqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pexdJ/VZaAfU7NL0kG6dEUV7XURs0Rf1NSdEfVC3qAw=;
 b=ORdwd2EYaqEaXDFI1M3CbcwBNDNzzDI6s0NQzXrWtWOzlUWtFaFxZ1t+5HFMU/tCTUYiznxDBQrlsEOLIahH8ZBFcBgmnRAxzSAUvf0jHl4WTPbglh044HuEYgefHBno6+S3UfbyBH2LTgoYzN+WuWX47+AxVScpTr72i1pXZeSx9NyDqHIgf9ZwbL3yCnmEGypnTap3Mr2uJuiAZsuALoa9bg6pVqTxW5RQ96Wm6wVolrFm0uCl6fBc6VwVS1JrQq/HyJscSdgo2S2Lt9VQXIFuwuCUdRSgGklsjvhkeB+pf4hSgmGjErMWblTqTo2b1GXfZ9pHK04FY12u7LobYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pexdJ/VZaAfU7NL0kG6dEUV7XURs0Rf1NSdEfVC3qAw=;
 b=yif36IZfNDMYWjryisqfsTR84Gp4kxYi6xkaqTppFvzPsvsPPZIf7Sv6YK0N4YmwJnFUn9H0+pDgGud7XqySJk4e5cTc4ehu/aywIeW1qlSlkWUZ62Ml0l29fKaVYXYAtOSrA5n/2RsiozuzHdGWZbiHESvGJp2QLt85OTSzojg=
Received: from PH7P220CA0144.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::6)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 22:02:38 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::3f) by PH7P220CA0144.outlook.office365.com
 (2603:10b6:510:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Tue, 6 Aug 2024 22:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:02:38 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:02:36 -0500
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
Subject: [PATCH v6 12/22] x86/resctrl: Introduce mbm_cntr_map to track counters at domain
Date: Tue, 6 Aug 2024 17:00:49 -0500
Message-ID: <e905666d2341a5a8c8e8bf3a337291375a80e6ce.1722981659.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722981659.git.babu.moger@amd.com>
References: <cover.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa50add-a1ad-44d3-1002-08dcb6637c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YS+ROqJp9dUj8hfLCFT0PFtTLZS7fVbSAJKLvtYPkAZ/ZuVP+3vEk7rSd+TB?=
 =?us-ascii?Q?Fyq/0yzk+RhAL1Dwdkfu3yGrBvbwfY/3dEabwKuCSW9YYFAQxqGML0JbpVrP?=
 =?us-ascii?Q?o4TtRhROVgBZyVVDderXJ980AG8GV5sPN8mZkgqqs85SAo+7KmiYAOv5tlV5?=
 =?us-ascii?Q?FXD8BpREbqCtp7rDh3Nbnu+yAmIAeF/Ae3QslW5ZTn6Fy8PiRsAHF2aQlPe8?=
 =?us-ascii?Q?nzviOjlS8f828LmJleszUvAkMf28Gg44gY/BIOCWMBrRAtptoq3sGKrZ58na?=
 =?us-ascii?Q?Tl2BGZunvk4SNUcJ1VaEWQ9Wzta9Ugv4EPl2hdtWdbse4QMmZXZjmCMKPsgP?=
 =?us-ascii?Q?dIZbhOPgUrR2OSHxEcgpT4isn8dOFsNEPAbu01OYdXzP7RIvdDY3fT54uX8c?=
 =?us-ascii?Q?D2NQYEeSgOfIY98/zu/0Q5M4wdHXkNplUDryJC/Be+/HrjQfiel7mnfV4NOy?=
 =?us-ascii?Q?1nydq+AG6VEt16Tvt6tUfeFaWdgI90wH6Mr7o1kX9a8G9PrAKDns5COv6QyM?=
 =?us-ascii?Q?gdwVzwzQ3Ua0XXi3lshuskxlv3IEQY4jhuPK+/af2FlfdwzY6k4UnJZhVbwb?=
 =?us-ascii?Q?Lv7gqBnzXFxWwff1Hf+wm6sc1Msa8jGlAWO3Hz1JnkO5N5hN57CWg/oc56Fh?=
 =?us-ascii?Q?KozDP1m0jfDmMWnCfH5Bj2Lws1CTIU4wjVVSuc2BcvX5kccFJkkdDC7UMpjH?=
 =?us-ascii?Q?G/MU2eYCqq8c9pbqjqN4caxbbSH0ZfxvK17db6vk/yEFs8AoeiiaEqYvf6j5?=
 =?us-ascii?Q?1ANw0AHUkBClx/70u6ii57sHxaxJMkqBNkdQlfF9OcLubcrZYV5UVrnSfZmA?=
 =?us-ascii?Q?YYOaXavG214czyK9i9JJ7pXGFLZKfflHb1032ojvfag154F8ZOpWOuphDVvd?=
 =?us-ascii?Q?Oy3YG5jqjbuyc7wb400DoV/lDX1KV58l8E/7Svc/Jgv8xIIGziqTEGp9WdA0?=
 =?us-ascii?Q?cUjQX4JFa1QyIpSNWqKnyuk9RD4OXovzAJlX03rUmgl5K/gotKUITyJM73Og?=
 =?us-ascii?Q?ylpTrAsZMAqVhbqVw+5ercREcHaRpPUgpuoIL9hjAYP8mpe2l+jvOCK2PtT2?=
 =?us-ascii?Q?po3nzOB8wUZBu09K68nNmNLtzj3naz6KMVyv5LFBynVeMI3e5skDz0FT8X14?=
 =?us-ascii?Q?vsNa/ylH97k9sTYVrgeKWMgrOuIdPO9J7/pXpYuJ8HSNrTX9J2t0zlMAPYXR?=
 =?us-ascii?Q?r9+UoevsH00drSoY0lHClzl5aEIlzIpYOm/H1P49OxE6+co0u4upLRoD4FFn?=
 =?us-ascii?Q?AhrVrLQha7R0SnlQ2dxjqEEoMhhVqpnEqgcJvHSwR1enziKFCgyM6NoAAJWS?=
 =?us-ascii?Q?zijSUsO64HbGBOTlK5Tc5H+O52T7Q/gCmoHJ/oU/bIuRDAAvC1gkSLEWj9Fr?=
 =?us-ascii?Q?78lFewLa6uWt0VESfRMATpYMdDBzwgxMtGx9KU5l7thMnIXTjERRCXqh7Ceb?=
 =?us-ascii?Q?6I89aPBHg+Na81PcqtUfPmiVoKQWZsZM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:02:38.0921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa50add-a1ad-44d3-1002-08dcb6637c36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415

The MBM counters are allocated at resctrl group level. It is tracked by
mbm_cntrs_free_map. Then it is assigned to the domain based on the user
input. It needs to be tracked at domain level also.

Add the mbm_cntr_map bitmap in rdt_mon_domain structure to keep track of
assignment at domain level. The global counter at mbm_cntrs_free_map can
be released when assignment at all the domain are cleared.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: New patch to add domain level assignment.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++++++++
 include/linux/resctrl.h                |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0047b4eb0ff5..1a90c671a027 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4127,6 +4127,7 @@ static void __init rdtgroup_setup_default(void)
 
 static void domain_destroy_mon_state(struct rdt_mon_domain *d)
 {
+	bitmap_free(d->mbm_cntr_map);
 	bitmap_free(d->rmid_busy_llc);
 	kfree(d->mbm_total);
 	kfree(d->mbm_local);
@@ -4200,6 +4201,15 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain
 			return -ENOMEM;
 		}
 	}
+	if (is_mbm_enabled()) {
+		d->mbm_cntr_map = bitmap_zalloc(r->mon.num_mbm_cntrs, GFP_KERNEL);
+		if (!d->mbm_cntr_map) {
+			bitmap_free(d->rmid_busy_llc);
+			kfree(d->mbm_total);
+			kfree(d->mbm_local);
+			return -ENOMEM;
+		}
+	}
 
 	return 0;
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index ef08f75191f2..034fa994e84f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -105,6 +105,7 @@ struct rdt_ctrl_domain {
  * @cqm_limbo:		worker to periodically read CQM h/w counters
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
+ * @mbm_cntr_map:	bitmap to track domain counter assignment
  */
 struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
@@ -116,6 +117,7 @@ struct rdt_mon_domain {
 	struct delayed_work		cqm_limbo;
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
+	unsigned long			*mbm_cntr_map;
 };
 
 /**
-- 
2.34.1


