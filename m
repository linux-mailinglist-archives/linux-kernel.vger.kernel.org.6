Return-Path: <linux-kernel+bounces-240269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F23926B02
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40901C21702
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4CB194AE4;
	Wed,  3 Jul 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="brKOHcOp"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD8194AC2;
	Wed,  3 Jul 2024 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043488; cv=fail; b=Zy2rF1Gj8fH378W39YjOlzu9R4yy4zYVEK+S3k+DnXf3WgQj7beAUKTlY1U4njEIzU87nW3ZtkEIZ25IarUBxDnDeXaqJ5CyjjILvRWCR6zUkJBcCf0NLNh4+S/NdsLXK5AZE4idtf8yZzoToCZOCVT/WuplazZsj/Gi+ICCRUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043488; c=relaxed/simple;
	bh=ez74uEXJQjDKAjZWTWltz6AlHYKJQpaISZMoBnjzZeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6FNj2wIImf5tyZvfB97G67iReZDnqjuepmzsRoujoDOFO/gmhmV7TkMciYQi1c+SgZhRRECLRVsct5u+w3gaG0j3KSmIr1jZkHtXr8HXmcwEvKHI5ruuTOQtEgCnoTs7/8U3WOQ4cSC4PNQT1l7VGQBqOlYPhgQQmUCrSu4smw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=brKOHcOp; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPssGzH4q+oo0QeZURJUiRUOLUBh1ASA8aXySC7Po72a+WbQNwenHDaFMOJ+7Az5wkJ98HIf8b0r9qPWmnDEiEY+l0uM8OTH9fyh6Ni6ATIOmZB9NlCzoO5n7id1++QCfKwwH8bErEwYhYuXWzi1gy2Qyz1MQz2pahxnHA1PdEPeWiDywyKpaE5NV5v0/ItjmIkfm5H22jZNpgF3UL5LU8I6GB7vBakO8vYRQExblkN6PiFQ1XOKHRJ8hOW1ebq+ghv88fPWUbvqDTht5m/yeo10Gf+Bi7s812VAPKm8Pi9RDypZg/11Ahpudemqu5QNN+dqOrcQNlnE5jRvty1J9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK+E7FmSud0CYmjxuahPKNHj4bNImm5Ncs4Rdp8g2Js=;
 b=ZxKpCqvJpnnwlj4z8SMMzTLUWoGF+Ef1H6eOhPCkQdXYtXu9gPF3TGW5d0KoHu9kI99006/i1h3Bln3h7dH63qf0MnffXvvtNuSa//M/fYb6IeaDkShvYPpvFfn1+ZXzhv1pA88sxb/yGVfgOrMC10GkOoWwEmho5fTnAiMRS5MH5083qhlAgVvSw1e590l62lUUgDROAGID5JqUmff2Jlylw+W0XGrJKh5gqF4QmDGZtRtpCvvaiuJINJn4iRuFYo7MsSITs5YX1Gdx5lhy4s4znNCdgsEPjt00fIJxVvDpL52yDc69ELYzw3EmRRHB+SCgHSbX/A+p72o8rbSLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK+E7FmSud0CYmjxuahPKNHj4bNImm5Ncs4Rdp8g2Js=;
 b=brKOHcOpFQEGyqzFAzQ25J0nXSbPSmnbq7wVICzTS55Ymk7rKyB8jSpCZqkICP4UDGiN9wlNm64K2+OlKz9vlknWdYkMjMuRDgTbd1OYCKzqzf2P/6EcubOoX3yrVAJrAIQSbHmJlqiEri0mUygIxUZwpVk0OfrBswFNy8h6nfQ=
Received: from SN7PR18CA0026.namprd18.prod.outlook.com (2603:10b6:806:f3::18)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Wed, 3 Jul
 2024 21:51:23 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:f3:cafe::82) by SN7PR18CA0026.outlook.office365.com
 (2603:10b6:806:f3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 21:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:51:23 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:51:21 -0500
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
Subject: [PATCH v5 20/20] x86/resctrl: Introduce interface to modify assignment states of the groups
Date: Wed, 3 Jul 2024 16:48:31 -0500
Message-ID: <49aa5321f6e81825a0e9e44cef06c243634e341a.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: a76bcd91-069a-409f-f117-08dc9baa47fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SK5um9buvovfPlPI73cUG9iNP+2RP1QjrJNSVElH2oc1Xc5+A7HC1JtUGqS8?=
 =?us-ascii?Q?N4ranF3wsUZftd+Rr6M7DsNlpJPcV4ELaqpPg59Uv7YjtHPKddwtjb09uoZA?=
 =?us-ascii?Q?uFdpRI/+kmND/nK42CjKbRJTQo/9ufCA7/EhmsVGyC9/yTY+KTN+Y5RUnrlg?=
 =?us-ascii?Q?exuOQSm0iVH+w+mR2+2enp4+mvqtE8U6CB5H21qPTR9nfjsal68Tz0ulEEyh?=
 =?us-ascii?Q?Zs6ULmcSnRVzKakgD0Aa/+YV/FlwpufmhCWnXXAv9qK08TXlYn7AanPzgro3?=
 =?us-ascii?Q?RF2SnBf+Dd8THvrgpSso972qs/DWnC5XfL1zEMRm1WRIimU5WcprUvHCdBPm?=
 =?us-ascii?Q?Qe0ywiwIMZiPpo2ZAg1nO1+aTP320KDhnssP09PKhu1o27tpYLeu8az6fv1e?=
 =?us-ascii?Q?1BmvDAtekLJNHFLwk82EqLd/53taM3Crt1R2OyzjdA229+sREhkpPiX1pRxB?=
 =?us-ascii?Q?jgaT8E3TUNgx8/pvLBvm4Rntw3b1/QB8z+QWwtmr859Dtj9DZKQfTYHzlQlZ?=
 =?us-ascii?Q?8GIDqmNaMLazG0Ov8fjcPib5fwG3mC1MofLdsCuEniq4KqsRVRJ1qcq0zvHu?=
 =?us-ascii?Q?ATY0bsiDOTDjV4xhpRV4d5CNJQoR8Vu/1wcrW7A1fqsRU3M5PnLL84YY2U77?=
 =?us-ascii?Q?NngGv9Xh/S5f3fEsfmxty5dsIBo6g8ywcFIQ6r76v5xFkysfZKPP6J47tyNB?=
 =?us-ascii?Q?Di9dHIrTv1mVlYIV8qxTgRsOOoHZTxF0rYl3kigIY1RvQBZD1PUv5gl6R3aT?=
 =?us-ascii?Q?GE1XtVCpOmpuw9ilU55tRMNvpCBNW4KoJEOAS/ZLxHZoFMybNxQb0cHA7uda?=
 =?us-ascii?Q?cVLrcf/tFj66qmOPwpSBkT8aUJNajMkKtUqX3fj/g2H6gLNZvznOlDq3xxEy?=
 =?us-ascii?Q?bO1o6YmCoZzMwXgs7ZtWJVqF9M2fYXT0SCHP+8ciyvY0hQY2EtgDNa8CS9p+?=
 =?us-ascii?Q?VS32aqb+mgwC/qtLG+yqiowxetl/6yrvl3c/eJAtGSY9VwrowsmodRYHDdYv?=
 =?us-ascii?Q?xsipcnbBoYIGN1EfyBM2ZMWQSto+VsgIFq6oS11MATJGpTYRsh/KKPPMGzZT?=
 =?us-ascii?Q?tA1iuoBxNL/W8eJDoAwmPilaEa9GezvnfzKsEYo2R//9oYVFfs/T0Cqc5Elq?=
 =?us-ascii?Q?Vfz+2uYKIZ11x7noj/sg/tBdCmircx/nBwRZ9QnbIA66zzm3QE/OwtX7tLzP?=
 =?us-ascii?Q?gnYmXaMN4yDpV7X1nin/YYp5U5gVHxtOSy6rEXPgbavM/Rq7P2njnqlOUxsN?=
 =?us-ascii?Q?DynMh7QkreEP3KNpklTd+CCDkJrTWppzNlwoUiB7fdfBR/YR8LUaSoKckcN/?=
 =?us-ascii?Q?w2/pvXRjppMX0DhDvPRRRFD8I7Ekq5ZyeBwu7BVxIu3iqQd2GHBnbUiYziuV?=
 =?us-ascii?Q?40jfqB/I/1FPQV01nO9WJyThCMU99sb2vDMS9tfhOA+Hjid0DQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:51:23.3556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a76bcd91-069a-409f-f117-08dc9baa47fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505

Introduce the interface to enable events in ABMC mode.

Events can be enabled or disabled by writing to file
/sys/fs/resctrl/info/L3_MON/mbm_control

Format is similar to the list format with addition of op-code for the
assignment operation.
 "<CTRL_MON group>/<MON group>/<op-code><flags>"

Format for specific type of groups:

 * Default CTRL_MON group:
         "//<domain_id><op-code><flags>"

 * Non-default CTRL_MON group:
         "<CTRL_MON group>//<domain_id><op-code><flags>"

 * Child MON group of default CTRL_MON group:
         "/<MON group>/<domain_id><op-code><flags>"

 * Child MON group of non-default CTRL_MON group:
         "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"

Op-code can be one of the following:

 = Update the assignment to match the flags
 + enable a new state
 - disable a new state

Assignment flags can be one of the following:
 t  MBM total event is enabled
 l  MBM local event is enabled
 tl Both total and local MBM events are enabled
 _  None of the MBM events are enabled. Valid only with '=" opcode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v5: Interface name changed from mbm_assign_control to mbm_control.
    Fixed opcode and flags combination.
    '=_" is valid.
    "-_" amd "+_" is not valid.
    Minor message update.
    Renamed the function with prefix - rdtgroup_.
    Corrected few documentation mistakes.
    Rebase related changes after SNC support.

v4: Added domain specific assignments. Fixed the opcode parsing.

v3: New patch.
    Addresses the feedback to provide the global assignment interface.
    https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
---
 Documentation/arch/x86/resctrl.rst     |  81 +++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 250 ++++++++++++++++++++++++-
 2 files changed, 329 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 05fee779e109..5a621235eb2b 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -331,7 +331,7 @@ with the following files:
 	 t  MBM total event is enabled.
 	 l  MBM local event is enabled.
 	 tl Both total and local MBM events are enabled.
-	 _  None of the MBM events are enabled.
+	 _  None of the MBM events are enabled. Only works with opcode '=' for write.
 
 	Examples:
 	::
@@ -358,6 +358,85 @@ with the following files:
 
 	 /child_default_mon_grp/ - This is a child monitor group of default CTRL_MON group.
 
+	Assignment state can be updated by writing to the interface.
+
+	Format is similar to the list format with addition of op-code for the
+	assignment operation.
+
+		"<CTRL_MON group>/<MON group>/<op-code><flags>"
+
+	Format for each type of groups:
+
+        * Default CTRL_MON group:
+                "//<domain_id><op-code><flags>"
+
+        * Non-default CTRL_MON group:
+                "<CTRL_MON group>//<domain_id><op-code><flags>"
+
+        * Child MON group of default CTRL_MON group:
+                "/<MON group>/<domain_id><op-code><flags>"
+
+        * Child MON group of non-default CTRL_MON group:
+                "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"
+
+	Op-code can be one of the following:
+	::
+
+	 = Update the assignment to match the flags.
+	 + Add a new state.
+	 - delete a new state.
+
+	Examples:
+	::
+
+	  Initial group status:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	  //0=tl;1=tl;
+	  /child_default_mon_grp/0=tl;1=tl;
+
+	  To update the default group to enable only total event on domain 0:
+	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_control
+
+	  Assignment status after the update:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	  //0=t;1=tl;
+	  /child_default_mon_grp/0=tl;1=tl;
+
+	  To update the MON group child_default_mon_grp to remove total event on domain 1:
+	  # echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control
+
+	  Assignment status after the update:
+	  $ cat /sys/fs/resctrl/info/L3_MON/mbm_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	  //0=t;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
+	  To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
+	  remove both local and total events on domain 1:
+	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
+			/sys/fs/resctrl/info/L3_MON/mbm_control
+
+	  Assignment status after the update:
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=t;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
+	  To update the default group to add a local event domain 0.
+	  # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
+
+	  Assignment status after the update:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=tl;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0de9f23d5389..84c0874d7872 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1068,6 +1068,253 @@ static int rdtgroup_mbm_control_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_str_to_mon_state(char *flag)
+{
+	int i, mon_state = 0;
+
+	for (i = 0; i < strlen(flag); i++) {
+		switch (*(flag + i)) {
+		case 't':
+			mon_state |= ASSIGN_TOTAL;
+			break;
+		case 'l':
+			mon_state |= ASSIGN_LOCAL;
+			break;
+		case '_':
+			mon_state = ASSIGN_NONE;
+			break;
+		default:
+			mon_state = ASSIGN_NONE;
+			break;
+		}
+	}
+
+	return mon_state;
+}
+
+static struct rdtgroup *rdtgroup_find_grp(enum rdt_group_type rtype, char *p_grp, char *c_grp)
+{
+	struct rdtgroup *rdtg, *crg;
+
+	if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
+		return &rdtgroup_default;
+	} else if (rtype == RDTCTRL_GROUP) {
+		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
+			if (!strcmp(p_grp, rdtg->kn->name))
+				return rdtg;
+	} else if (rtype == RDTMON_GROUP) {
+		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+			if (!strcmp(p_grp, rdtg->kn->name)) {
+				list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+						    mon.crdtgrp_list) {
+					if (!strcmp(c_grp, crg->kn->name))
+						return crg;
+				}
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static int rdtgroup_process_flags(enum rdt_group_type rtype, char *p_grp, char *c_grp, char *tok)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int op, mon_state, assign_state, unassign_state;
+	char *dom_str, *id_str, *op_str;
+	struct rdt_mon_domain *d;
+	struct rdtgroup *rdtgrp;
+	unsigned long dom_id;
+	int ret, found = 0;
+
+	rdtgrp = rdtgroup_find_grp(rtype, p_grp, c_grp);
+
+	if (!rdtgrp) {
+		rdt_last_cmd_puts("Not a valid resctrl group\n");
+		return -EINVAL;
+	}
+
+next:
+	if (!tok || tok[0] == '\0')
+		return 0;
+
+	/* Start processing the strings for each domain */
+	dom_str = strim(strsep(&tok, ";"));
+
+	op_str = strpbrk(dom_str, "=+-");
+
+	if (op_str) {
+		op = *op_str;
+	} else {
+		rdt_last_cmd_puts("Missing operation =, +, -, _ character\n");
+		return -EINVAL;
+	}
+
+	id_str = strsep(&dom_str, "=+-");
+
+	if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
+		rdt_last_cmd_puts("Missing domain id\n");
+		return -EINVAL;
+	}
+
+	/* Verify if the dom_id is valid */
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		if (d->hdr.id == dom_id) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found) {
+		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
+		return -EINVAL;
+	}
+
+	mon_state = rdtgroup_str_to_mon_state(dom_str);
+
+	assign_state = 0;
+	unassign_state = 0;
+
+	switch (op) {
+	case '+':
+		if (mon_state == ASSIGN_NONE) {
+			rdt_last_cmd_puts("Invalid assign opcode\n");
+			goto out_fail;
+		}
+		assign_state = mon_state;
+		break;
+	case '-':
+		if (mon_state == ASSIGN_NONE) {
+			rdt_last_cmd_puts("Invalid assign opcode\n");
+			goto out_fail;
+		}
+		unassign_state = mon_state;
+		break;
+	case '=':
+		assign_state = mon_state;
+		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
+		break;
+	default:
+		break;
+	}
+
+	if (assign_state & ASSIGN_TOTAL)
+		ret = resctrl_arch_assign_cntr(d, QOS_L3_MBM_TOTAL_EVENT_ID,
+					       rdtgrp->mon.rmid,
+					       rdtgrp->mon.cntr_id[0],
+					       rdtgrp->closid, 1);
+	if (ret)
+		goto out_fail;
+
+	if (assign_state & ASSIGN_LOCAL)
+		ret = resctrl_arch_assign_cntr(d, QOS_L3_MBM_LOCAL_EVENT_ID,
+					       rdtgrp->mon.rmid,
+					       rdtgrp->mon.cntr_id[1],
+					       rdtgrp->closid, 1);
+
+	if (ret)
+		goto out_fail;
+
+	if (unassign_state & ASSIGN_TOTAL)
+		ret = resctrl_arch_assign_cntr(d, QOS_L3_MBM_TOTAL_EVENT_ID,
+					       rdtgrp->mon.rmid,
+					       rdtgrp->mon.cntr_id[0],
+					       rdtgrp->closid, 0);
+
+	if (ret)
+		goto out_fail;
+
+	if (unassign_state & ASSIGN_LOCAL)
+		ret = resctrl_arch_assign_cntr(d, QOS_L3_MBM_LOCAL_EVENT_ID,
+					       rdtgrp->mon.rmid,
+					       rdtgrp->mon.cntr_id[1],
+					       rdtgrp->closid, 0);
+	if (ret)
+		goto out_fail;
+
+	goto next;
+
+out_fail:
+
+	return -EINVAL;
+}
+
+static ssize_t rdtgroup_mbm_control_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes,
+					  loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	char *token, *cmon_grp, *mon_grp;
+	struct rdt_hw_resource *hw_res;
+	int ret;
+
+	hw_res = resctrl_to_arch_res(r);
+	if (!hw_res->abmc_enabled)
+		return -EINVAL;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+	rdt_last_cmd_clear();
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	while ((token = strsep(&buf, "\n")) != NULL) {
+		if (strstr(token, "//")) {
+			/*
+			 * The CTRL_MON group processing:
+			 * default CTRL_MON group: "//<flags>"
+			 * non-default CTRL_MON group: "<CTRL_MON group>//flags"
+			 * The CTRL_MON group will be empty string if it is a
+			 * default group.
+			 */
+			cmon_grp = strsep(&token, "//");
+
+			/*
+			 * strsep returns empty string for contiguous delimiters.
+			 * Make sure check for two consicutive delimiters and
+			 * advance the token.
+			 */
+			mon_grp = strsep(&token, "//");
+			if (*mon_grp != '\0') {
+				rdt_last_cmd_printf("Invalid CTRL_MON group format %s\n", token);
+				ret = -EINVAL;
+				break;
+			}
+
+			ret = rdtgroup_process_flags(RDTCTRL_GROUP, cmon_grp, mon_grp, token);
+			if (ret)
+				break;
+		} else if (strstr(token, "/")) {
+			/*
+			 * MON group processing:
+			 * MON_GROUP inside default CTRL_MON group: "/<MON group>/<flags>"
+			 * MON_GROUP within CTRL_MON group: "<CTRL_MON group>/<MON group>/<flags>"
+			 */
+			cmon_grp = strsep(&token, "/");
+
+			/* Extract the MON_GROUP. It cannot be empty string */
+			mon_grp = strsep(&token, "/");
+			if (*mon_grp == '\0') {
+				rdt_last_cmd_printf("Invalid MON_GROUP format %s\n", token);
+				ret = -EINVAL;
+				break;
+			}
+
+			ret = rdtgroup_process_flags(RDTMON_GROUP, cmon_grp, mon_grp, token);
+			if (ret)
+				break;
+		}
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -2282,9 +2529,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_control",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_control_show,
+		.write		= rdtgroup_mbm_control_write,
 	},
 	{
 		.name		= "cpus_list",
-- 
2.34.1


