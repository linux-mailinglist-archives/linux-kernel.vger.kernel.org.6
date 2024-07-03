Return-Path: <linux-kernel+bounces-240257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B9A926AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6868E1F2197F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AD8194C6E;
	Wed,  3 Jul 2024 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kc2a6TNe"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C6194C61;
	Wed,  3 Jul 2024 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043392; cv=fail; b=cpcC/TEeIAxTPvciWxXwS/laEu3vbKTfHM1oT+bA/pLtGtGxqGNIVIoOx+V5hjPra+6MjHAqw8eVuuxIWF1dEg161Yl76RfeamhfOw6o6hrdGga24DEmZd2hG4Ckys2ftNSJh/vvFh851FhS/9+0lJHrDXxlMtPsj+PwPWJdFvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043392; c=relaxed/simple;
	bh=aTY3ucYLUeYS0GHnz1dp8/gaq/1g0xdl/W5HYM9ljWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGtdMER5XnwRjW/iCUDVRewu77ErbdKG8KedBbyD8L4SKF96s6TOKIfDRnXnR/3XdTJ74yGn5lp5JIOxumJ/Go76pkcq5wiFsoMi0/WPYOHN8wJ2MGEXoZ088plDPk9xdOVNTI5lSQhKf6dw5r3f3CwLL6SSwakGkXDnl/kkb64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kc2a6TNe; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6gVi+U1sg6jPxuZmgoo4IeCgXEO6dlPsvra5oCF0WQ7+OTpveF4MntjPrlCJbXvY1YzUKdeQ7r+X2yONYUZ7zAC2/JPxeeLaJCcPaDqiQG+zi1wD19YLwGAzEqhNwUkAKbZ2An7k9EGNhvpXxw/v7NO6NK98IMJRgHe267Wxgxuidntjqgr1eZj8EEgDZg1Xoq6liPW66icYtCnanikJuHe61iELCtzUmWczvLy4eDsAuGXH1UimPhA7N8/+AhAuaBDTmHs4y1Tye6WY4nUDh/Ej7UmJ8DE+njJTgvzAztJc86s4lT6VdyosIAiMBWq+jenvriTg6VMX/M5V4ffzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xO7IZ5QrroWa0unSifp/19Xmelu1dtZeWnsQdKSl+x8=;
 b=kzsB/cA0JG3A73kbMdDez21PZRwaoqSTB5sprpWRq+J7YRDMPdiyVWHjdMcUiBuhX5kzn+PNvA0tbJxFGKeAeuzXGQtGEYO7HVkw4LvKM2W1voqBeOfFPEhrXwB/8WsmHN6XrkXYtoGKArJJjVub6NsYUylma3TGMFZBdprHwyCR1ksVnTIWCb9AaRj+vLG5Qoq/1g+hCm657dL8v2VrAhyJRpOu6fNyeE1aHRkGhAQToJui5bu3nInbD2gs88HvOq+FzeYtlR71YjVJ7++6ZRc5NTYyeYXuHAG3Pa8ZnigIKNkjlnkjBf9RMO34S0tTU1O8lWVkmtmcr4Ev1Fh0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO7IZ5QrroWa0unSifp/19Xmelu1dtZeWnsQdKSl+x8=;
 b=Kc2a6TNe1rjmukIiQiwnyI9j/ER7lnEXYek8iV8apKd+5yfn4rdWKmXFKdJOAGdpZMMAu7XDHMzL0KihPF6HdW8dPbkMPM5g9E7euriRyKKd+EMoOJ04/soPH7duou+1A9UppGX9QGmfz/x8XDCdJlUHC9ulA7OrBwJK//f1XOA=
Received: from DM6PR17CA0027.namprd17.prod.outlook.com (2603:10b6:5:1b3::40)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 21:49:48 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::69) by DM6PR17CA0027.outlook.office365.com
 (2603:10b6:5:1b3::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26 via Frontend
 Transport; Wed, 3 Jul 2024 21:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:49:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:49:46 -0500
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
Subject: [PATCH v5 08/20] x86/resctrl: Introduce interface to display number of monitoring counters
Date: Wed, 3 Jul 2024 16:48:19 -0500
Message-ID: <dc6716ae485cdd442057360f4619582a9c4b34a5.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 5016b3eb-ecc0-4982-2695-08dc9baa0f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gSHz068H9b7kVLMgCwXnopQGCSjKQ00YfnnRsjL096V4KYfzFKzsZQ1cNRm2?=
 =?us-ascii?Q?MTtoDsDzSYL6oHsY/y7r4EgwDWsvZhWdposILnpqA1vhVTQaKe4bbilZ9tm+?=
 =?us-ascii?Q?7kuNc4jpDWHm9+3eiu+2ofu+Mdo5ebTfhrVYFJDV6dNzWW7XKs+0bLTCd25G?=
 =?us-ascii?Q?OIc5EycEcl0e62TnMSYYjqhgVrHqjgVwsmt+t6W6BfZHkJwZ5L/zUeRE6wQn?=
 =?us-ascii?Q?4Yztq5B2uEYjodIfdDYRW34VqByDp5Y6C6BpBjhp3vsaZKCCGWb6S9/1M3w3?=
 =?us-ascii?Q?rCf2+xti2sAgUT+5OzaNaW4IHCht3xJA/O+5AmI23gn5lyQPadMHljq9l/7q?=
 =?us-ascii?Q?wvPn+i+Qk5oABzBpJUrBODke0dlRGhk6b39LP61lNpC9u067T2XHblkoGfcL?=
 =?us-ascii?Q?rtAgGrYydwpaVtpxhPEbaA3aD9Wxcl8xwIKmT6RiK78LJhQraCuaL0P8UyA1?=
 =?us-ascii?Q?Ql64zxwpxe5QfgAXlEXD3SWE8wvwAKdHQfvsyOOJZd/vyZGiRJfQCGWvpioI?=
 =?us-ascii?Q?DtApYCfzj2oe/u6J3p0N19FCATTGOFUR2LRbX8vDt18C4sa9p1+VXw89dYT+?=
 =?us-ascii?Q?W2IlY1FTkZnCy2Bza0PgNTY4YaqOF9tycCxNsAonEhAVuYL+ASSSmwODBto1?=
 =?us-ascii?Q?qQIc98QUBAOLT1E9CQrIKZFzv71O2/7Lp6eDO7bn4A+TsIrnyDFc/G1njXF1?=
 =?us-ascii?Q?vV7ksfsRqLbslmLlFVbx1t+NnS/mHucC+W1ThZJIZYwE6umac1n2h9xGLoBc?=
 =?us-ascii?Q?Baq+iJxgic3TWU8h8mCcWE96kaakgfCHgLkXWjRek7kDfJP9J+naVl12ZfqC?=
 =?us-ascii?Q?mbF5FnraDVI6vt6MI/S48dS89AvFfnqfv59otURwo+pky56sZYdBRLKuJpoL?=
 =?us-ascii?Q?ytXGp4eLkpo3Z/zRXv7YZ9y9/4xNTFD6ICttH64I4T/CnOWvF+Gb6GbcAKi7?=
 =?us-ascii?Q?LV8VL3P8jzMzKhGww2iTF7ZOQzxEVdFRYQMtQ/TVr6q2u2eyfHRwSpmLGndX?=
 =?us-ascii?Q?57gXLda8cozUcUYQ/HZx2XJVy3Hn/VsoVC4XRjO1tKe5mQQ8A625WL9NO54Z?=
 =?us-ascii?Q?vIyL49n/m4QjfBuF3q+tVzMiITTqTg6F+yxWZeH6cZ1Mpu6uqSBm19bfeeuW?=
 =?us-ascii?Q?OGGADjjNSwl51Qmc8TVKvjIn+FlbchUpFFQchErkganfdf/3YAJJWjkNM/U8?=
 =?us-ascii?Q?JAwsh0XqhABx7YvVO43XAX6pCrvkhvoKHYsInVKHmaQSDwSgkuTjCSR3d4H8?=
 =?us-ascii?Q?j9P2jVvLajCyCkX1DQaBjOgJaNVjrhi683UywzAfoAUiV8EqUmSmvk1GuEr+?=
 =?us-ascii?Q?KUhqE2eltcXDF1+KfGy0LB/GZXc+W4+lDy47Osj8Q2c+ZIn9Bh2S3g3vdM7t?=
 =?us-ascii?Q?AK9B2vhg1doGCNTAoKQ7GAnZ5FB2ewkJajVrUaYPnpyJz8lIkllRiMnsrem8?=
 =?us-ascii?Q?o37zYLkaeXesA1AwmUg2z0vD8wbniLHJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:49:47.9774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5016b3eb-ecc0-4982-2695-08dc9baa0f29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as the counter is
assigned. Number of assignments depend on number of monitoring counters
available.

Provide the interface to display the number of monitoring counters
supported.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v5: Changed the display name from num_cntrs to num_mbm_cntrs.
    Updated the commit message.
    Moved the patch after mbm_mode is introduced.

v4: Changed the counter name to num_cntrs. And few text changes.

v3: Changed the field name to mbm_assign_cntrs.

v2: Changed the field name to mbm_assignable_counters from abmc_counters.
---
 Documentation/arch/x86/resctrl.rst     |  3 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 108e494fd7cc..4907d0758118 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -287,6 +287,9 @@ with the following files:
 	Without ABMC enabled, monitoring will work in "legacy" mode
 	without assignment option.
 
+"num_mbm_cntrs":
+	The number of monitoring counters available for assignment.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 6c4cb36b4b50..7a93a6d2b2de 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1242,6 +1242,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
 			if (WARN_ON(r->mon.num_mbm_cntrs > 64))
 				r->mon.num_mbm_cntrs = 64;
+
+			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3988d7b86817..4f47f52e01c2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -865,6 +865,16 @@ static int rdtgroup_mbm_mode_show(struct kernfs_open_file *of,
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
@@ -1935,6 +1945,12 @@ static struct rftype res_common_files[] = {
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


