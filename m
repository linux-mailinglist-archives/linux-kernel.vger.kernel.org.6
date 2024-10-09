Return-Path: <linux-kernel+bounces-357639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D669973A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754F42888BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB89C1EABB9;
	Wed,  9 Oct 2024 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LmPZ4u8U"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546B1DFE0E;
	Wed,  9 Oct 2024 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495812; cv=fail; b=uBybiiqNvQU6yUzv4pmM+U77Jrh9nUau1OC0y0DcsN6/sU1SAoF008TRXY6+izUpiEZc2tHddKEJihLE0JwVtjNQARZyI/vxMiVn9OvLqRbSHqlYVV78QFHt1Ke11zoB/iRWhp3uy+yuX1oVzrLmFS2Vg3hCKuljL8GEBK4+bJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495812; c=relaxed/simple;
	bh=bK/ojl/wBbcH/26aXwlmp1CbiBI8qkRQiZjcLS0V+3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjkxbAfAC76xWDirhddM2mtd7Qf8UiTndlkKu45h9XDquLN3cqQyUwlBydgKHKi1DnmIVajuBfBGAS3eMXQUJTJEDTHPJbyok32kcx8L0nX1YipE+yzhgoImD05oOAvZu7ln+Qcnx0+sdgNdOAKEpw2P4CtQpO3X/VM3lRjgnGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LmPZ4u8U; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pp/0V4/LRGjsNQSq2IgZtZlRvaFZfhXha5oATXGt5Qm+uPRJ9QvkQMkjj78g6knn8kvT16U64AHotmY2clXnEaEAR8Uyl0clMPQ7xS1dn9jQ7iKp0HoZZy5tEBk5puOsJ2G75b4sK75h3t86m9ML2fBANhCJ+3ImBjq6SweeNXYBQjTIsewwzSmWVYvklpV4Prk2tAd5lC6vRiL3bbkXL6Bmo4dURnXOjUE6kU7xsMQTt2sdIHILzjsWEhUGU8eyuOe1w/Xkvmfz0qPOJ6hmiA8lCe9lot7eQ9mbxR6teOi4Apjt+J8kqB/+R5F39HJ4yC3GUJ2s0C1GpDWmRGViAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdJ7A6iYNpGAyUVxO7RNZz7dBVSTFvxNxLDFKM0Whsw=;
 b=iWKBt1ELB22HwTwxlGFXEFo6LrryrbikyJVcFzf6gwBCUzkW5ouokgWOWdYoSH05FX8DbDA68d6/zcxfaogpViUgPTQwGs7Nwa/FR3p2qgyyhybuVYCftmCu6vxK3AT+dU8H5kswtdtY8zh5NWV0p7PfjcKAvU1Fp/qUkHO9ZXt5+4kZcXalavhkGfnAK/OVCe58BKmJdzTEsw+/ZH7TVx1F1VfsqY9aAK7e+SDw+Y8R7zMy/IQFdRwxTbYmzy15/xAQk7hiV7JmyU0z9/kSttC9AuM3ZoLDSe7sa2dNnrTVsA7Y+QZe+8atZIChYDxZZqJhdtH1e6C06wA+dSB3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdJ7A6iYNpGAyUVxO7RNZz7dBVSTFvxNxLDFKM0Whsw=;
 b=LmPZ4u8Uq581QUUOCggW8eEl1wbxqut65i1uvAifOhe25AHuda8fg1FK/359Mve9IHADWofeSPEP+hQLQRvicDn+8dGLGfk0owLe5a2UMzKMZL4feADSvTHIXLMtIsCFdvEqIAdOU6fSGrjX3jyCFf9MR3ReSEYHvMTstf9WoW8=
Received: from PH7P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::16)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 17:43:24 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:510:32a:cafe::dc) by PH7P221CA0028.outlook.office365.com
 (2603:10b6:510:32a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 17:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:43:22 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:43:20 -0500
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
Subject: [PATCH v8 25/25] x86/resctrl: Introduce interface to modify assignment states of the groups
Date: Wed, 9 Oct 2024 12:39:50 -0500
Message-ID: <c3c12e970a660c32088a447f9961826ec3a9fb24.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3f8933-bc75-4abf-cceb-08dce889df0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UytFSGR4V2ZHOVhLQ3drRUhjdUM0SzJGYzdwQ0FiTityV20yY0FnNUNDRXRv?=
 =?utf-8?B?VWlaK2pjSEQxOU1QUTBxNStuaHpTTk54eklMd0J6bjRCWjRmTkJmWVFjOG9y?=
 =?utf-8?B?ME1takZ4djNaY2dzakduV0hiazk1cmFVKzMvSnRyY2lrWG13RkJzcEJWWFYw?=
 =?utf-8?B?OUpYckRYOVNseWE0QmJsUXBPYU0welZ3UHdRanV3WGtNZjZGVVljWllXSVRM?=
 =?utf-8?B?K21EcVpVcUFpYWZiOWRLNkVidC9WR1llWUVPNk9iL3lPUklQU1E5aERqbzd2?=
 =?utf-8?B?MzNUTkw1ZFArUnI5eWduYy8vZTlkM21Da1dhMXJHRW0vdURadkNJTUpIWUJV?=
 =?utf-8?B?eWMxSE5BWW9jYUVJLy9KVkdaYWNaalRRaVlQaUxHSmd3RSt0YmlVOXNkU0p5?=
 =?utf-8?B?bkQ3bloyQ3J1QWc2VDEweWNpUnJRVm8rTGF2SGJTT0VpMHoyY1hkczFYVFAv?=
 =?utf-8?B?L2ZKb1pBS3g5RFZKU2tZU0xGOEcwNUNYRlU2U0M2N0FvNWtKRFNQQkp0YUR3?=
 =?utf-8?B?WnAweDZFblJEUGI3ZndMeFc2dW1lV3RPdWt1UTdsMDRDODV6TlN5eXlVS3d5?=
 =?utf-8?B?S2JvNzNWR1BVYVYyWmZLbG9jZVBSdDUxTnNvc1piR0ZGMUI0dGVoaHJHRmpq?=
 =?utf-8?B?SmhTakRrOUwxTnF0NGV1ZU4rakpiTDJadTRtNDVSTkNQeVJCRlc1V2RWOHZF?=
 =?utf-8?B?amlDdjFYdUZJV0l4cW9QRDhndmtNY3JHTU1SckxKR25PVXpaaUdSOERrS3BR?=
 =?utf-8?B?UXpXcndWZE9QZTZCUVQwajB2R05qTmF3b05IT2p2bzhETkN5UXhqaDlmM3RR?=
 =?utf-8?B?cDV5YjJyc2tHb2tlaTJaRms0S1JzQ1M4a2hoR0RIRkJTUkZpYklObjVHcFRw?=
 =?utf-8?B?R0pFOGo3RWRtekxROGkxcGhSSlhDSmM5UzMxUUpzZWtpWWFWYW81bHdlTDdO?=
 =?utf-8?B?OGF4NzM5YUJJTnBCUjd4aVZrVkZBcmFCTHQzanNOVlRLQU14OGxqYmR1ZEFt?=
 =?utf-8?B?Si9SSm5kWno4cmJaRUIvTFphMHpZOXBKLzB0a0EzanpCYjltVm5RSzNveXEx?=
 =?utf-8?B?SmhLYkN4dUt5ZEVDaDdIZXI4N0JqbEtBZVNNQlF0NE42WnVRMkVYT2JLeFdE?=
 =?utf-8?B?RDVObzIrWGJ5VXBNTFV2cFdiM0xHVUdUczhOZnlhenNjMTJySjVPK2FCRHNl?=
 =?utf-8?B?UEw5MTdWTFZOOHR0c0ZSRDErSHFkTmJNMkdLYTdmNlBucExpcnFHdTBtUENE?=
 =?utf-8?B?Sy9hNDhtVFdCREFqYmxlR20vKzBhZTFUaVZVbmhJRVNCdnhhcE9mcTRtSkI3?=
 =?utf-8?B?SnBmTlFEaXpoOEhwQm1ZZis3NFN5aGt1b1NWYVBHV0hjaUNCeW5oM05nQWRz?=
 =?utf-8?B?bGZjb1FIc2RWaDc5Z25RdE5qbUMyWEhxZ0RqQnY5Y0pTdXhNSFJMZ2hFMjFH?=
 =?utf-8?B?bkoyR29yR2ZnU1ZaWWFmQ3ZJMlVDV0VoMXl4RE1TSzB6TXoxRUcvWjNtWUhu?=
 =?utf-8?B?MkxNVVZyUXNhQzZFcTZSNUJoTUFRdXZ1UU1WWGlkYVZPdmlvaTF5b1F1VnhY?=
 =?utf-8?B?SzArUGp3ZWd0VVFGL1d2UHFCd3llTEJLTmNaQTVoQ3R5eWJyd0pWYTMrZEM4?=
 =?utf-8?B?SmtZeTFlaDZGbUxKNGVxUFlldUFEbmRkeDFrVmYwWTNCczd1MFJZUmhTcWNT?=
 =?utf-8?B?RVR0bFlSb211NkxxNlhCSDBjeWdnVFVRSGdYK0t0NzRxOFA4TmVGTXR0WGxH?=
 =?utf-8?B?cEhnZUVXMkt3K1dlSlI2NFBjRGIzSjdPVjNVa3FIZW1ESzJ1Zk9QWG85a21Y?=
 =?utf-8?B?MUx5ekp1WkR2RWRBNTQ1Qm9YMk1semg4YjFtcmI2c2Y3SjMrcjBPYm9FdXZw?=
 =?utf-8?Q?gM7VhbThIHx6l?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:43:22.8501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3f8933-bc75-4abf-cceb-08dce889df0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647

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
 Documentation/arch/x86/resctrl.rst     | 115 +++++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  10 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 233 ++++++++++++++++++++++++-
 3 files changed, 356 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index b85d3bc3e301..77bb0b095127 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -336,7 +336,8 @@ with the following files:
 	 t  MBM total event is assigned.
 	 l  MBM local event is assigned.
 	 tl Both total and local MBM events are assigned.
-	 _  None of the MBM events are assigned.
+	 _  None of the MBM events are assigned. Only works with opcode '=' for write
+	    and cannot be combined with other flags.
 
 	Examples:
 	::
@@ -354,6 +355,118 @@ with the following files:
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
+	  $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
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
+	  #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=_;1=_;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=tl;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a6f40d3115f4..e8d6a430dc4a 100644
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
index cf92ceb0f05e..6095146e3ba4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1040,6 +1040,236 @@ static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_str_to_mon_state(char *flag)
+{
+	int i, mon_state = ASSIGN_NONE;
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
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
+		mutex_unlock(&rdtgroup_mutex);
+		cpus_read_unlock();
+		return -EINVAL;
+	}
+
+	rdt_last_cmd_clear();
+
+	while ((token = strsep(&buf, "\n")) != NULL) {
+		if (strstr(token, "/")) {
+			/*
+			 * The write command follows the following format:
+			 * “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
+			 * Extract the CTRL_MON group.
+			 */
+			cmon_grp = strsep(&token, "/");
+
+			/*
+			 * Extract the MON_GROUP.
+			 * strsep returns empty string for contiguous delimiters.
+			 * Empty mon_grp here means it is a RDTCTRL_GROUP.
+			 */
+			mon_grp = strsep(&token, "/");
+
+			if (*mon_grp == '\0')
+				rtype = RDTCTRL_GROUP;
+			else
+				rtype = RDTMON_GROUP;
+
+			ret = rdtgroup_process_flags(r, rtype, cmon_grp, mon_grp, token);
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
@@ -2328,9 +2558,10 @@ static struct rftype res_common_files[] = {
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
 		.name		= "cpus_list",
-- 
2.34.1


