Return-Path: <linux-kernel+bounces-387854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBD39B56E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E235A1C20DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A138220C02F;
	Tue, 29 Oct 2024 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bw+zQqzh"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F34420C46D;
	Tue, 29 Oct 2024 23:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244372; cv=fail; b=AieJOzYE6XJipma3nyc0V9+eQIvOadiXRNilK8fjeMwXBuLZwURVy9ryD4gcyjeeM77B81fAqOfLQHeGuGx3TDVSnP/pmMkdObvIEZhYy6+MKOJqAfFzVwOLXN2iKDWlFVJEYJiftnLdK9g5DZ9aAcV6WW9X68YlO/aSBKDo9+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244372; c=relaxed/simple;
	bh=9m65ClpxNVfQlngwhM8XM95G1YPtOlBC5Z18c1+VEgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9VRzsLLXPFeT4JqIZsgUO1H5w/tLpEUUyvPDN7dOoN+0aHUTd49SHJ+fCtI6efmyVqNzYrmp8jsMSH/PUmhr3Ph0KkPqGhD7fATYLMZV+bAK2HHR2UrixHOdOIXxk23iEeJaoz1Oeugd/c3AP3jNmOM4yFTnFdJ8pzjC2pwpRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bw+zQqzh; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1e0VMvRUWSe/TJMe37Hab/JvZVby/Af6UKedZQgs0drcbj3Lglx22o+N1WvP6DRyanOjMwmliTWxqu4k7tPmdKzrZPBlvaRr5VNyiGHL3J8JwFlTX+EbSixsB7fwaC39d9LavWL5tgIkyzVkzL6PBENCJ4glQ1NQfJV91aL9Oyogq81aebIT4xiPIuZ1WGDuDOVzm56zpZ28+Ciq/QfVfywr4LYzKDp7ct8FPs85B8RtKg1lgrY7Klbe3dOuFEQD+Ejp+MM4xV10yiOwrhuZ+5TzO5fVWvaNLrOzcn6AnO0gPgsT2qAMv9noEWFo1oZXPPEe3ptCq3I6fLu/xsLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpuUQzZ3m6n5peXlKD8Llgs5qGiEScsi5EAcCniIV30=;
 b=sWa0dxrtEFUHFzuvDKgrZt8uGfheZkQ+38Buwe4cT2mO8ZcQObaL/A/pWrXxrB/TehyPy5vJQhvXSb/LNjeGAl0thAJCfYA/atZbEn7HOu6FnZTaeo/uEn26vLi3kfE8+fRpziTy0I3tkDEdSS4plIFo/zXS/hYeL4VVR2EwD8glbXNI+fNZSry8pg6EKh2t7slbLXJ4wDeIAn2/79ubmozl6GoVvBHduCjA6dsKrhftaDsMZP95czU5kld1X64fAuEsPiz1TdoBKS35R3QNgQsas98xEwkU21DF2X8cNaGFmoNmuoLDsw1D46zZyfMgbNxHPHdwfDPAEbCVHKJFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpuUQzZ3m6n5peXlKD8Llgs5qGiEScsi5EAcCniIV30=;
 b=bw+zQqzhRjlApSuNjgXDxxeKwcdJoGR9g0j1PLquFIhrwDXJC1d886rWMp64lc3jkShe7JjQoppXKjzRjQ488L7TX4JnEyYo5vT0kiFk9gBovIw1K5pKOPWZ8RR01A6dvA0oOk5heELleAJGomTRAt6XC8TIwoY9T7ulm/W6BKA=
Received: from SN7PR04CA0236.namprd04.prod.outlook.com (2603:10b6:806:127::31)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 23:26:04 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::cb) by SN7PR04CA0236.outlook.office365.com
 (2603:10b6:806:127::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 23:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:26:04 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:25:45 -0500
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
Subject: [PATCH v9 26/26] x86/resctrl: Introduce interface to modify assignment states of the groups
Date: Tue, 29 Oct 2024 18:21:58 -0500
Message-ID: <1dfa8b184a00d94013470b2818c23fd8eab66baa.1730244116.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730244116.git.babu.moger@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e3a92b-a106-4d13-1754-08dcf8710ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUdQb3ZtbDI3MktURFlXamluU2FTTkZWQ1dTc3ptdGVhQTlzUnBIKzBkY1cv?=
 =?utf-8?B?d092MjQrb2dCbURJcGhrSzZCWWRoSzY3UEZKcHVmNDEweWpuYmVSZEYzVHQ3?=
 =?utf-8?B?TCtOVjlRRUV3aXc3RGhCU3A1bjYrOGFOcS9xRmlVWm5hVEJvNzArbW84bjJI?=
 =?utf-8?B?UmNMbUIrckVFRHdtTUNQenJvNjA1RCtzYnQ0QlpDZVdqbUx5Vk1VL2k5Ym5t?=
 =?utf-8?B?TU9TOEw4YkZ3VDVQcWVsU0tZUnpRVVpqa1IySlUvckdoRWc4S3ltbWt1R0lu?=
 =?utf-8?B?ZHgwS1QwVHZKRi9LbzNPMmpCYlg0WFljdzl0WnhKT2xVOHBxVHdUTzU0b0xw?=
 =?utf-8?B?UEd4R2NMRTR3cUxyVG9oSFZSRkZoOXordHJMazk0WDZCMkRKd1dXQnFHMFV4?=
 =?utf-8?B?WVVlQWlQRjNXUGJJNnJ1bEptTjUrTWpINWRlNG9mckowZjF6LzdhZXBhZktk?=
 =?utf-8?B?b29EVHJuWXhVczBrblVGdHhtanA4ekZIUHlUSzg2WTBHQVJlQkFpRWgvM3BT?=
 =?utf-8?B?RTdlcEYxZlROYlhkMi9HbVFXSFFVWmtDaCtkclpNOEtzOG8zWnhPQ2NsYXdh?=
 =?utf-8?B?Wis1ZURKKzMyNHQ1VlJhQVN6Z0tkNzU1V01idDBXcVBwcnVGODZKeXp6OXRL?=
 =?utf-8?B?b1VsR2luQnpXM0U4ZklSc1NCWXJiWFp0c3dnN2FWYUkyZHg4S1ViZlRoTDhQ?=
 =?utf-8?B?VFo0M01SREw1aTlWWnRYQzhta1ozSEJ0QW1aZDIwdmQ5RUFLaUs0U215ZGtQ?=
 =?utf-8?B?T3FUWTBabHh5VW95d0MxM0p1ZXpTSkswWWVxKzJUT1dhRmVhTUJZek8wb0Uv?=
 =?utf-8?B?bG9GUmY5eVVabkhNNi9OamNFQ0dHbklZZEhvbnZBRWNKU3BEVXdmNCticEFz?=
 =?utf-8?B?TG9zMXFSYXNhWlZIeWwxSDZ3OUc0SE5sd1A4bEFwZTd0TUs5VmZsMEZIYStz?=
 =?utf-8?B?Z05zZEh2ZkErWjYvTTkyS2pGLy9NQjJoSWl4N2tZSFd1anNhcVhIZGJYOFJL?=
 =?utf-8?B?L2RuWFVQbGFzTUZWRGY5Y1hhNktEdzErRHFsdmpPc2FJanNCSXdRd3k1ZnQ3?=
 =?utf-8?B?MnZJeThPUE5JeUdPb3Y1TDhGMUJOaGNUQjhCbFFlNi9zMEsrSkEwa3p2VEc4?=
 =?utf-8?B?Wm1iODhES2tOUWg2Mm9tYUdkNXZ6ZEVWWG9BL0JVeHA4S3g0c3RJMkdWN0tL?=
 =?utf-8?B?TkFEWHNCOU5JbDhDQnhCRjZyRWRVZGZxVkplQ2w5WGxqUzZUaENBYkVIbXBu?=
 =?utf-8?B?REJPTkNDd05NcUZ1SHhhd3FvM0RzNkdVUXBleGwzLzA1MlB3NWc3QTNLcGVm?=
 =?utf-8?B?QkZLRW5zUkVTTkhibW54eCt4R3FSMlQyQXZ0Tm50SFU2R0lmak1xaGpKYm0z?=
 =?utf-8?B?Q1d2NE5neDcwQk1SZ0ZHL2orMFNIU3E1TVJ4Yy9pZ3BmQXBTM0VvS2E5d1pV?=
 =?utf-8?B?TnhGMHlmVFNjUUZLQXVHdnNBNE9MTzM3eDJ2T2x3VG9sVVFrTWxMZ1Z3MWRS?=
 =?utf-8?B?N1IxTGNaM09GeG9KaFZkTVRCc3ZWQllmcGtPMjFOOGpLekg4YUFET0NPWERP?=
 =?utf-8?B?VUROZk9jL1dEanIyOG9DeFlraGQ1K1ZEQ0JHSDhDbEVDYjRCUEZ1SnhWd1I4?=
 =?utf-8?B?TW5oMTZwTlRmZi9VSHg3ZGpBS3I4amMwcFlRU0lPRDB2K1Z5QTVxbWFrUlJV?=
 =?utf-8?B?NHoxK0RJb3cwKytLVXBvaEovM3M2S3Q5dXk3YWtwN3V6VER4Sk1ROVlNS1FK?=
 =?utf-8?B?ZTdUVldLUDFIanl5ZWlGNjM1Rmw3T0JKZE03NjM0Q25HTUcvcCtnV2kxMDlz?=
 =?utf-8?B?VEhsdlRWcjQxSG9JZjVQQW43Z1lQWHhtSzVBaWEwdlJEU2xJb0JYR2U1ZHFv?=
 =?utf-8?B?S2ZsZTNZK25UeSs0cVF6cU4wbUFMRTRpYjRFZUVZbFhNTVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:26:04.3259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e3a92b-a106-4d13-1754-08dcf8710ede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303

Introduce the interface to assign MBM events in mbm_cntr_assign mode.

Events can be enabled or disabled by writing to file
/sys/fs/resctrl/info/L3_MON/mbm_assign_control

Format is similar to the list format with addition of opcode for the
assignment operation.
 "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"

Format for specific type of groups:

 * Default CTRL_MON group:
         "//<domain_id><opcode><flags>"

 * Non-default CTRL_MON group:
         "<CTRL_MON group>//<domain_id><opcode><flags>"

 * Child MON group of default CTRL_MON group:
         "/<MON group>/<domain_id><opcode><flags>"

 * Child MON group of non-default CTRL_MON group:
         "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"

Domain_id '*' will apply the flags on all the domains.

Opcode can be one of the following:

 = Update the assignment to match the flags
 + Assign a new MBM event without impacting existing assignments.
 - Unassign a MBM event from currently assigned events.

Assignment flags can be one of the following:
 t  MBM total event
 l  MBM local event
 tl Both total and local MBM events
 _  None of the MBM events. Valid only with '=' opcode. This flag cannot
    be combined with other flags.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v9: Fixed handling special case '//0=' and '//".
    Removed extra strstr() call.
    Added generic failure text when assignment operation fails.
    Corrected user documentation format texts.

v8: Moved unassign as the first action during the assign modification.
    Assign none "_" takes priority. Cannot be mixed with other flags.
    Updated the documentation and .rst file format. htmldoc looks ok.

v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
    Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
    Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
    Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
    Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
    Removed ABMC reference in FS code.
    Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
    Not sure if we need to change the behaviour here. Processed them sequencially right now.
    Users have the liberty to pass the flags. Restricting it might be a problem later.

v6: Added support assign all if domain id is '*'
    Fixed the allocation of counter id if it not assigned already.

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
 Documentation/arch/x86/resctrl.rst     | 116 +++++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  10 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 236 ++++++++++++++++++++++++-
 3 files changed, 360 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 590727bec44b..d0a107d251ec 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -347,7 +347,8 @@ with the following files:
 	 t  MBM total event is assigned.
 	 l  MBM local event is assigned.
 	 tl Both MBM total and local events are assigned.
-	 _  None of the MBM events are assigned.
+	 _  None of the MBM events are assigned. Only works with opcode '=' for write
+	    and cannot be combined with other flags.
 
 	Examples:
 	::
@@ -365,6 +366,119 @@ with the following files:
 	There are four resctrl groups. All the groups have total and local MBM events
 	assigned on domain 0 and 1.
 
+	Assignment state can be updated by writing to the interface.
+
+	Format is similar to the list format with addition of opcode for the
+	assignment operation.
+
+		"<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
+
+	Format for each type of groups:
+
+        * Default CTRL_MON group:
+                "//<domain_id><opcode><flags>"
+
+        * Non-default CTRL_MON group:
+                "<CTRL_MON group>//<domain_id><opcode><flags>"
+
+        * Child MON group of default CTRL_MON group:
+                "/<MON group>/<domain_id><opcode><flags>"
+
+        * Child MON group of non-default CTRL_MON group:
+                "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
+
+	Domain_id '*' will apply the flags on all the domains.
+
+	Opcode can be one of the following:
+	::
+
+	 = Update the assignment to match the MBM event.
+	 + Assign a new MBM event without impacting existing assignments.
+	 - Unassign a MBM event from currently assigned events.
+
+	Examples:
+	Initial group status:
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	  //0=tl;1=tl;
+	  /child_default_mon_grp/0=tl;1=tl;
+
+	To update the default group to assign only total MBM event on domain 0:
+	::
+
+	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	Assignment status after the update:
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	  //0=t;1=tl;
+	  /child_default_mon_grp/0=tl;1=tl;
+
+	To update the MON group child_default_mon_grp to remove total MBM event on domain 1:
+	::
+
+	  # echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	Assignment status after the update:
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	  //0=t;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
+	To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to unassign
+	both local and total MBM events on domain 1:
+	::
+
+	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
+			/sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	Assignment status after the update:
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=t;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
+	To update the default group to add a local MBM event domain 0.
+	::
+
+	  # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	Assignment status after the update:
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=tl;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
+	To update the non default CTRL_MON group non_default_ctrl_mon_grp to unassign all the
+	MBM events on all the domains.
+	::
+
+	  # echo "non_default_ctrl_mon_grp//*=_" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	Assignment status after the update:
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=_;1=_;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=tl;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b90d8c90b4b6..3ccaea6a2803 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -74,6 +74,16 @@
  */
 #define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
 
+/*
+ * Assignment flags for mbm_cntr_assign feature
+ */
+enum {
+	ASSIGN_NONE	= 0,
+	ASSIGN_TOTAL	= BIT(QOS_L3_MBM_TOTAL_EVENT_ID),
+	ASSIGN_LOCAL	= BIT(QOS_L3_MBM_LOCAL_EVENT_ID),
+	ASSIGN_INVALID,
+};
+
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5cc40eacbe85..9fe419d0c536 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1082,6 +1082,239 @@ static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_str_to_mon_state(char *flag)
+{
+	int i, mon_state = ASSIGN_NONE;
+
+	if (!strlen(flag))
+		return ASSIGN_INVALID;
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
+			return ASSIGN_NONE;
+		default:
+			return ASSIGN_INVALID;
+		}
+	}
+
+	return mon_state;
+}
+
+static struct rdtgroup *rdtgroup_find_grp_by_name(enum rdt_group_type rtype,
+						  char *p_grp, char *c_grp)
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
+static int rdtgroup_process_flags(struct rdt_resource *r,
+				  enum rdt_group_type rtype,
+				  char *p_grp, char *c_grp, char *tok)
+{
+	int op, mon_state, assign_state, unassign_state;
+	char *dom_str, *id_str, *op_str;
+	struct rdt_mon_domain *d;
+	struct rdtgroup *rdtgrp;
+	unsigned long dom_id;
+	int ret, found = 0;
+
+	rdtgrp = rdtgroup_find_grp_by_name(rtype, p_grp, c_grp);
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
+		rdt_last_cmd_puts("Missing operation =, +, - character\n");
+		return -EINVAL;
+	}
+
+	id_str = strsep(&dom_str, "=+-");
+
+	/* Check for domain id '*' which means all domains */
+	if (id_str && *id_str == '*') {
+		d = NULL;
+		goto check_state;
+	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
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
+
+	if (!found) {
+		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
+		return -EINVAL;
+	}
+
+check_state:
+	mon_state = rdtgroup_str_to_mon_state(dom_str);
+
+	if (mon_state == ASSIGN_INVALID) {
+		rdt_last_cmd_puts("Invalid assign flag\n");
+		goto out_fail;
+	}
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
+	if (unassign_state & ASSIGN_TOTAL) {
+		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
+		if (ret)
+			goto out_fail;
+	}
+
+	if (unassign_state & ASSIGN_LOCAL) {
+		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
+		if (ret)
+			goto out_fail;
+	}
+
+	if (assign_state & ASSIGN_TOTAL) {
+		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
+		if (ret)
+			goto out_fail;
+	}
+
+	if (assign_state & ASSIGN_LOCAL) {
+		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
+		if (ret)
+			goto out_fail;
+	}
+
+	goto next;
+
+out_fail:
+	rdt_last_cmd_printf("Assign operation '%c%s' failed on the group %s/%s/\n",
+			    op, dom_str, p_grp, c_grp);
+
+	return -EINVAL;
+}
+
+static ssize_t rdtgroup_mbm_assign_control_write(struct kernfs_open_file *of,
+						 char *buf, size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	char *token, *cmon_grp, *mon_grp;
+	enum rdt_group_type rtype;
+	int ret;
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
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
+		mutex_unlock(&rdtgroup_mutex);
+		cpus_read_unlock();
+		return -EINVAL;
+	}
+
+	while ((token = strsep(&buf, "\n")) != NULL) {
+		/*
+		 * The write command follows the following format:
+		 * “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
+		 * Extract the CTRL_MON group.
+		 */
+		cmon_grp = strsep(&token, "/");
+
+		/*
+		 * Extract the MON_GROUP.
+		 * strsep returns empty string for contiguous delimiters.
+		 * Empty mon_grp here means it is a RDTCTRL_GROUP.
+		 */
+		mon_grp = strsep(&token, "/");
+
+		if (*mon_grp == '\0')
+			rtype = RDTCTRL_GROUP;
+		else
+			rtype = RDTMON_GROUP;
+
+		ret = rdtgroup_process_flags(r, rtype, cmon_grp, mon_grp, token);
+		if (ret)
+			break;
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
@@ -2383,9 +2616,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_assign_control",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_assign_control_show,
+		.write		= rdtgroup_mbm_assign_control_write,
 	},
 	{
 		.name		= "mbm_assign_mode",
-- 
2.34.1


