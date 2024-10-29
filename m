Return-Path: <linux-kernel+bounces-387850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C34B9B56DF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE671C20D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DC120E330;
	Tue, 29 Oct 2024 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hfsGZNNu"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77B20CCD1;
	Tue, 29 Oct 2024 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244321; cv=fail; b=Cp6Qm5UB6z6gZtKVzJY+/lHDAWMRJ7gXqlkBKrUrQLF2ajvdB2HHn82B/xRrWfI/Dg/8rzCswMntY4bUvgbdnoEz3nkAp7f3dpqrGIsMxIUspZq7CkE0yMVp8Ya7b3HI0bS904CXfFBnsTvIm9BKa06fkUZL4Zkpe+3g0td/SAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244321; c=relaxed/simple;
	bh=mbRglOYee5vCNM6sfEI2hzdY2ZIohuLsgokK9DXAKMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sc9+aPGivXLKratYolM98AZO+CoQEqbg/n2Jzm572OkcRgVje76oDNaCgfL1fCyUscM+L6DFOnn/lUzvx8pEGY59aUoLwQ/fccsFp6nvmd00Eu2MedQnhLcEafdQVkv4UHOHCRo7yZKFMz7QFsYXIdK/++MTY6OdqwCI9349AJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hfsGZNNu; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icIhNsYKJKTgFVq7SKdV5DG8ENjmuRTLcFTvX3pdZzN5u2XjUjZe/f9WH78Lmi3g7tstdThgnxvLfMPyTtUdd63s3PDcuv2WXihG18cJVf2+ICcYhQokQRydG1I8Ef8s9ufO//UvYMs+Znzo/9/9CzmjRWn6YGXz8V59TCj8zCCGTA5MBGwGtt/tO7hNkPmbcePz/lsRStK7sg0rcbLaLNg1W9K/IiN807IRz3DLLPqZXcCX6oonGJpwpoZwAA4CidIoaoGIGkP2xcmBrP6cTi5/6d9gKtlacat6rMI/E77GS/aOftvestNaVEMHSLEHeJKvNTAowFpcwiohfNPI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHfbcN3J6fTw3VPEBFCLQbFy/BLgqSu8J9Yqvciip0k=;
 b=WXnNUi9MLy0xsEMLSqdzokTpX5YNmoSTET+eSaMgUhMJ0HwYae0mt4F3gPfChXrYjbhrMGX3aU2l7XPv9qtsva7fqJwGSQS04hMBGHC19NyvF0oR9Yks+Gf9NoKHiPp8FkIE/O+lhBem7qRPvOXhIOJQBHD6Y1exNg26+LDra1BBu04qyRxrp6Ql5omXcJyIQMvnZ/ehiBrJXouVQLChK6O479NbQezeOGr0UnEYD6AOHBtBGDBkMOY5rVIuM29EbNcsGiPJRt2QZzh+teNKWYw7nIeHY1eNbI7KMqhgUF/yzpTo6T27dhleBLVbKnA6JWJihnxPWAiUdHiLAyg0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHfbcN3J6fTw3VPEBFCLQbFy/BLgqSu8J9Yqvciip0k=;
 b=hfsGZNNu/12O+aWeLwpAfnBRvN4ikCI8iYes9j2+i7wnz/iPPaEhqJkD0ujUYGTRh4bK3I8pMTW8UFx6tAk7OwKb8yq4zuHmN9bnD+JwubX5rm9KQ9hjbGiVd4d/D6cI6JHntLs5ZESqAg4ztyEIb1Q8zhQi4enT75e+wDaXzSM=
Received: from MW4PR03CA0346.namprd03.prod.outlook.com (2603:10b6:303:dc::21)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 23:25:16 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::f6) by MW4PR03CA0346.outlook.office365.com
 (2603:10b6:303:dc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 23:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:25:15 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:25:12 -0500
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
Subject: [PATCH v9 22/26] x86/resctrl: Introduce the interface to switch between monitor modes
Date: Tue, 29 Oct 2024 18:21:54 -0500
Message-ID: <e656cf18db67785b20ee2999a4677fb258e78906.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ec2129-62ca-4681-9748-08dcf870f1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JTxvKlWVPK4sgFT/FgmMRMDUj7W9DTAbSAQmbJQtxRqjMjIR2f6b484/jiFB?=
 =?us-ascii?Q?ythhVXmnjMxIjmfTHgKAFdzpEZv9pDm1psf3FaneG2EUMUp4Fxw5CdLF6F7k?=
 =?us-ascii?Q?Y0UDWUPSJuzcwrBgm1U0adH4PcelPk68Er9ctLWg40Mk89obIkHNYJStZDEL?=
 =?us-ascii?Q?jVTxUcBr7j+vTc8++WomQ7aCi0tilqpFFOjzGkFJYv3LNpNrFg0UYBg+GF/K?=
 =?us-ascii?Q?MJdWpG2mm5cjE5wFRH0uaR7M2nYLbZJgpH+XyUobZZ+WRCymgFortffPmkvk?=
 =?us-ascii?Q?kWU2/SI/9dM5rid4J6by0Yhkc8wUUhubjz9m/k4NiiRBsaE4U0Au+HtH04FB?=
 =?us-ascii?Q?Wzai6oTqbv3X2OinUqRofX+czK09otdAf7QWZaFKEbPSW1p25u+4q8dpu/Oz?=
 =?us-ascii?Q?yW84eMWpVDgPG3MBLdrN8t37y6ECEs/bN+A3MOpEH2HrwUYq0uLTNtGCYyJy?=
 =?us-ascii?Q?MpvwnIjP8cI7bSk2W77sdYhtxSz9IXFroTE0UN2DUOu7C+SUek0Z7QkzcNju?=
 =?us-ascii?Q?7UyA0p0hZTrNA3qx3C6frZv0wSoIiVhZ4JjOyMwLdghX3sOu5LS9mQb2Desd?=
 =?us-ascii?Q?qOLE5J5VeOKBYTCUnQ28gPhxIdHaXyfHC0FsG+XVoly7nGWyGbAo0o5ZBXUh?=
 =?us-ascii?Q?2fS8KSgbO7XNY9/yFGG/6UqdzfkmGfUpQPBhh6HxZTusO6ckRD/9qm2lqLOv?=
 =?us-ascii?Q?0Mkp5ovqa2eeTSvaBctLm1kV22ORBnzCHgqzySFSO6+cest3uuf5hroarnG5?=
 =?us-ascii?Q?sdbxjo1zvulCtAyNnUzHQtYCWsimHKrckI9DNEWcSrbvtCGX1L+i/ASnrcLY?=
 =?us-ascii?Q?PU2e+IZ5iDAF17nVneQaUQKQayg6CFqeajuYHMRxC54vmZA6WCRNNnjTm07u?=
 =?us-ascii?Q?7yyAtXISCrx1XYIftkV0GolnmZzABSafeymOT073Dpw/UFCXHXtd467++8AK?=
 =?us-ascii?Q?bPCvSCuuPlZY2zW9/Q2zYdwqkD4ZO/9XdNyW6GlsCrMTWWEyiXsbAJjfLK5V?=
 =?us-ascii?Q?l0p58OisBUV7aQGHvTQhEdWxA4NfBIb0IV0RFTi7Sr82dTI6RMF+bUzkAXkE?=
 =?us-ascii?Q?UaeEjxL62oCeUfqw4RtLeWaJtU10PqAH/T3GyGbmaUdrAB/czqaaYZxr7X75?=
 =?us-ascii?Q?R2UHg1MqusW5YmboJJVDlkAwOHqiOEjZU0QKADXBjYzt01vVmE/PWIRb60ws?=
 =?us-ascii?Q?Nhf0QhuW4+eOyqkIgpDDxbIg+MziMWdNk8/IOaHKoFqMs1YWQlEYKCnSxYx1?=
 =?us-ascii?Q?5o5mNEb4Cro9rmWLOuajHPWhj+pcLfeeD89N4DBQQ+s4OW5qkSAYz+oeKM7A?=
 =?us-ascii?Q?OUSCl/fFSXoTx9FEDKA9ndyeQ1ZzHD2ozHrjes+rGOpy+vqP1cIelWnUJ3Kf?=
 =?us-ascii?Q?FhAfAGx/PZ/TwStJS5HgxkTEFEJRHsq1FVsTeQykP9hIz2WekQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:25:15.4423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ec2129-62ca-4681-9748-08dcf870f1c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254

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
v9: Fixed extra spaces in user documentation.
    Fixed problem changing the mode to mbm_cntr_assign mode when it is
    not supported. Added extra checks to detect if systems supports it.
    Used the rdtgroup_cntr_id_init to initialize cntr_id.

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
 Documentation/arch/x86/resctrl.rst     | 15 +++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 81 +++++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 864fc004d646..1b39866e8b04 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -290,6 +290,21 @@ with the following files:
 	mbm_local_bytes may report 'Unavailable' if there is no counter associated
 	with that event.
 
+	* To enable "mbm_cntr_assign" mode:
+	  ::
+
+	    # echo "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+
+	* To enable default monitoring mode:
+	  ::
+
+	    # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+
+	The MBM events (mbm_total_bytes and/or mbm_local_bytes) associated with
+	counters may reset when mbm_assign_mode is changed. Moving to
+	mbm_cntr_assign mode require users to assign the counters to the events.
+	Otherwise, the MBM event counters will return "Unassigned" when read.
+
 "num_mbm_cntrs":
 	The number of monitoring counters available for assignment when the
 	architecture supports mbm_cntr_assign mode.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a8d21b0b2054..7fa6a86c6ca8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -933,6 +933,84 @@ static void rdtgroup_cntr_id_init(struct rdtgroup *rdtgrp,
 	rdtgrp->mon.cntr_id[index] = MON_CNTR_UNSET;
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
+		rdtgroup_cntr_id_init(prgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
+		rdtgroup_cntr_id_init(prgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			rdtgroup_cntr_id_init(crgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
+			rdtgroup_cntr_id_init(crgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
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
+		if (r->mon.mbm_cntr_assignable) {
+			enable = 1;
+		} else {
+			ret = -EINVAL;
+			rdt_last_cmd_puts("mbm_cntr_assign mode is not supported\n");
+			goto write_exit;
+		}
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
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -2166,9 +2244,10 @@ static struct rftype res_common_files[] = {
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


