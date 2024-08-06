Return-Path: <linux-kernel+bounces-277005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBA949AEC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E14B27228
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E557178395;
	Tue,  6 Aug 2024 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RZzlqQ1v"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594E173357;
	Tue,  6 Aug 2024 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981842; cv=fail; b=YbVnTtcCkEdlRIJrJTt35QHjc8aLNHhfYQyxmKBV13tLcRqsTnw4lPShwWiFV3slsXyhdqVqVv5GDXbwDnZH5WucMGUNRZkAI+YjIBU7VVCrc9cFkLUlMlre+LdmfChIs5IXpuaECoO8Kazs1nILYQuhRU/oAQk0PuR4fP6SXXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981842; c=relaxed/simple;
	bh=pukYNKCGZFaLeqFG/SNUDLDi9GGve9KZ5+48EQwT0qM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eg21DFFQ0FtVW53aKmPPiIKPSbbLhTC8skxB6aw3lWX/B5qPZfX7MPeGKzVspCWnQkRlLqta8/4z+jvZwKaaz+5afOHZbZAIko3xbpx3VIIYZQsLdfmD5cnO9IZHeV58v1yimJM7f4OE5MxuBlICZSZR/a4+Rend4Fimi+xV3b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RZzlqQ1v; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoapMqk5Chz0Vg9il2FEd5cZP++Zpv5xJI/7Tvc9LT3AB/bPtVhXBDyNJSeDP0DXIbnPfKoY2O7laCcjw3bMLlzYTP2+lIpgjxaKQXCNBobweMjZABP9C6ctDXsarq//oejD9X08GxJgqPk6RPLNs+KeAQanWX78M8xhcO2zXbRAztib4fnFqQeV3LjK9P2t56N+6oFOu76m5AibGKOAsMkDRia+4HMc0SlNZHx/gd+SFBIA1TwSPkii9EiEBvjhLdE2+8m5CWcwstRM70U7yJSprfOnUxOPPbQlVfaXloMQDQJtb2DlBf59n7pVOLXBIdhCT6PStZaD4j/O4WJ+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhPTqwvH8C2aCDoj33RCAClXdHGAvH2asU50hzRb118=;
 b=sVagc4JOD1G2d34Nhy6hdULbdif7BdxRFOa0SAvF4HMRywwlY6RTyfGe9NbrPo50f022DziVL6pxpxlkMKmFvYo5BxsV4bezbB+fv6F4QUb+NfXKzc4kx0oAwBnU3i2ya2XQ8qjrm9tcxbiiceaIVA4Y8SpGGt4WpKhpc4odvjj1bABD51ZP7PlEZ+kevnuJl0XqOqhl7jmQWq1v6w7+FkQrnHPVyDeQaXAfqsnGIYVpUa20PDskx6L5lYBjnFCVoori5yMKZxMtfxbRh9R9l/a0mRm5BUqh5CEF8ZaLzSompcxgwabPqSODQnRGEss7CQ9X87++f3DS6zfVIft2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhPTqwvH8C2aCDoj33RCAClXdHGAvH2asU50hzRb118=;
 b=RZzlqQ1vWaa1sDJl2dlp195WPy3tDxaLnK9PDilVLkjUd2uwkk7d/P0MChdlbhjVTtPufRQS4kzV1zzSJagzqQ0CM5oMe0QamzAzTduD8eytDyHhFTh/hMHsVqF9UfglhwREvFOo35TmK+pdF2oYwxvamg74MrY2OSIeqIKRdIo=
Received: from DM6PR10CA0034.namprd10.prod.outlook.com (2603:10b6:5:60::47) by
 PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 6 Aug
 2024 22:03:54 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::d9) by DM6PR10CA0034.outlook.office365.com
 (2603:10b6:5:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Tue, 6 Aug 2024 22:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:03:54 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:03:52 -0500
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
Subject: [PATCH v6 22/22] x86/resctrl: Introduce interface to modify assignment states of the groups
Date: Tue, 6 Aug 2024 17:00:59 -0500
Message-ID: <30a946c5ec042e66db675e9e57fe2cff971f570e.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH0PR12MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 28bdc730-904b-4393-51c9-08dcb663a97c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D8IFgkquDVB4AJVY+PiphssmrT79ob4vxTZUP0asGhcbLceqjoz7LNa3KOO8?=
 =?us-ascii?Q?TzVYhmIMOk3IdGakdsxMmnqlDte5tcTZ5VgRYizvbTAMNjPHmYQWvS8K1n6R?=
 =?us-ascii?Q?JfX5/232LE7XeAAvMV9FgBmpTlLUxMT3MrXo/iANMq7nuXI769jF0qIKR5A8?=
 =?us-ascii?Q?2lOSWAI9/qV4tTOeshgvJ246Gnt98QglUI9RA6KyKmc0hi1+04854QvLVpy4?=
 =?us-ascii?Q?tju70du6ad5ssEewDJ7vMZlQ3rfA0cpnBHM7kHEPR+Jw+gmXpmwFi9rKOuik?=
 =?us-ascii?Q?ymogThrhxjuLJsTZPEmZB+Q3/ie4D+rz5guBA+24ApqUA6TO+9TjYWB/Z40J?=
 =?us-ascii?Q?e/xJML2sPNHCUK9igpERBtg+CWH3AgQOs9zXvNBl7rZx7kN//gUTD3tfoqsb?=
 =?us-ascii?Q?ktCjMfPDRvEgG7wv2OexnaxLELJxGBFfenhb51I4zyR2SxYE4tOpI5DLuX3Q?=
 =?us-ascii?Q?gyCxHoFV6VKWKjw31WzAqohTxcnwo85f5rPOtCijsdTWc8jqoikMOQr0Rlqm?=
 =?us-ascii?Q?v+xLDdXxdrgqXzWtHnEufOnmeqDW5bxvhyHYbgqCB8RXxBKj3UAS63WaNpqk?=
 =?us-ascii?Q?1+7wNRQZrC6ctjyYr5PyEPk9hKp6yuahURj8AXLal2K9ZjJkkcSB16YI+Vyh?=
 =?us-ascii?Q?LUdZs1T1BL3vOe/gbQfxucyrM+e18mJhqLu+3Avu6VEt5toxkZW3uJcy71sl?=
 =?us-ascii?Q?L2AXqBM/8KF7iEHUCe62ArDxztcOmMJWlNErijqa9Q2SeftOb7jC3DaMzanL?=
 =?us-ascii?Q?8LykgXzLoibZAjasLa1xeA7nVOga2p33SuJ7fmdgozGTzCL2vRdU5puuJrhi?=
 =?us-ascii?Q?80Y6H43IS/mJn3BYjHLVU9Ju6snv9cwdqc5SWUaU5Bw3p5GryJ3iRPp+209i?=
 =?us-ascii?Q?qOf7v5L0bjeS8PIpuOH/FZwP887YATcMrUstCzZabkKZq3iciRSxznQ6ZbHA?=
 =?us-ascii?Q?AmQJH11jwhWJbhRnkGH8ivRVDURAkjFsbLDpahoJKaUMLQvUhYy3woxittc1?=
 =?us-ascii?Q?oWt1M6ZlkzSW9wmiHkPglzgAPWDatxU++wu84NOoDV9x+PJTPIUNPOTPLWlJ?=
 =?us-ascii?Q?U/e0cUrfYNKsW3zpzzQH9sU7VPC8tuGO65XqjGCsfBz3qCFRcWwWz3W6dzya?=
 =?us-ascii?Q?Vt6hFJkqSiwTF8VbJHl3aKVcjS+zr0hhFbOvW1JjEbGjf/PX+bLFysvwkzc0?=
 =?us-ascii?Q?x+o5UnGsHZZtXP4L1FF1B7MQRVxSX1PsTlJdxh4mehhvuIqUsP9dfwYlIG7H?=
 =?us-ascii?Q?HctIR8il6xJqNXN3FAZF3qi+XZALCfP+BUvj7D0Fi19RXk3Z/mlH//mZveNG?=
 =?us-ascii?Q?2lgNwYbmAjjr17CsTm8kruVUFdaHNtQ7RMpTgTJJSJ56obWjUusmwTfUNsSy?=
 =?us-ascii?Q?Qz8w4oGh9eGBfVj+6s9flY3xF2Gn5aaOeTzuNSPu22CZh52WPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:03:54.0032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bdc730-904b-4393-51c9-08dcb663a97c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471

Introduce the interface to assign MBM events in ABMC mode.

Events can be enabled or disabled by writing to file
/sys/fs/resctrl/info/L3_MON/mbm_control

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
 + assign a MBM event
 - unassign a MBM event

Assignment flags can be one of the following:
 t  MBM total event
 l  MBM local event
 tl Both total and local MBM events
 _  None of the MBM events. Valid only with '=' opcode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 Documentation/arch/x86/resctrl.rst     |  94 +++++++-
 arch/x86/kernel/cpu/resctrl/internal.h |   7 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 315 ++++++++++++++++++++++++-
 3 files changed, 414 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 113c22ba6db3..ae3b17b7cefe 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -346,7 +346,7 @@ with the following files:
 	 t  MBM total event is enabled.
 	 l  MBM local event is enabled.
 	 tl Both total and local MBM events are enabled.
-	 _  None of the MBM events are enabled.
+	 _  None of the MBM events are enabled. Only works with opcode '=' for write.
 
 	Examples:
 	::
@@ -365,6 +365,98 @@ with the following files:
 	 enabled on domain 0 and 1.
 
 
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
+	Domain_id '*' wil apply the flags on all the domains.
+
+	Opcode can be one of the following:
+	::
+
+	 = Update the assignment to match the MBM event.
+	 + Assign a MBM event.
+	 - Unassign a MBM event.
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
+	  To update the default group to assign only total MBM event on domain 0:
+	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_control
+
+	  Assignment status after the update:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	  //0=t;1=tl;
+	  /child_default_mon_grp/0=tl;1=tl;
+
+	  To update the MON group child_default_mon_grp to remove total MBM event on domain 1:
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
+	  unassign both local and total MBM events on domain 1:
+	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
+			/sys/fs/resctrl/info/L3_MON/mbm_control
+
+	  Assignment status after the update:
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=t;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
+	  To update the default group to add a local MBM event domain 0.
+	  # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
+
+	  Assignment status after the update:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=tl;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
+	  To update the non default CTRL_MON group non_default_ctrl_mon_grp to unassign all
+	  the MBM events on all the domains.
+	  # echo "non_default_ctrl_mon_grp//*=_" > /sys/fs/resctrl/info/L3_MON/mbm_control
+
+	  Assignment status after the update:
+	  #cat /sys/fs/resctrl/info/L3_MON/mbm_control
+	  non_default_ctrl_mon_grp//0=_;1=_;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=tl;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ba3012f8f940..5af225b4a497 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -46,6 +46,13 @@
 
 #define MON_CNTR_UNSET			U32_MAX
 
+/*
+ * Assignment flags for ABMC feature
+ */
+#define ASSIGN_NONE			0
+#define ASSIGN_TOTAL			BIT(QOS_L3_MBM_TOTAL_EVENT_ID)
+#define ASSIGN_LOCAL			BIT(QOS_L3_MBM_LOCAL_EVENT_ID)
+
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d7aadca5e4ab..8567fb3a6274 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1034,6 +1034,318 @@ static int rdtgroup_mbm_control_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/*
+ * Update the assign states for the domain.
+ *
+ * If this is a new assignment for the group then allocate a counter and update
+ * the assignment else just update the assign state
+ */
+static int rdtgroup_assign_update(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid,
+				  struct rdt_mon_domain *d)
+{
+	int ret, index;
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX)
+                return -EINVAL;
+
+	if (rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET) {
+		ret = rdtgroup_alloc_cntr(rdtgrp, index);
+		if (ret < 0)
+			goto out_done;
+	}
+
+	/* Update the state on all domains if d == NULL */
+	if (d == NULL) {
+		ret = rdtgroup_assign_cntr(rdtgrp, evtid);
+	} else {
+		ret = resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
+					       rdtgrp->mon.cntr_id[index],
+					       rdtgrp->closid, 1);
+		if (!ret)
+			set_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map);
+	}
+
+out_done:
+	return ret;
+}
+
+/*
+ * Update the unassign state for the domain.
+ *
+ * Free the counter if it is unassigned on all the domains else just
+ * update the unassign state
+ */
+static int rdtgroup_unassign_update(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid,
+				    struct rdt_mon_domain *d)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int ret = 0, index;
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX)
+                return -EINVAL;
+
+	if (rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET)
+		goto out_done;
+
+	if (d == NULL) {
+		ret = rdtgroup_unassign_cntr(rdtgrp, evtid);
+	} else {
+		ret = resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
+					       rdtgrp->mon.cntr_id[index],
+					       rdtgrp->closid, 0);
+		if (!ret) {
+			clear_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map);
+			rdtgroup_free_cntr(r, rdtgrp, index);
+		}
+	}
+
+out_done:
+	return ret;
+}
+
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
+	if (assign_state & ASSIGN_TOTAL) {
+		ret = rdtgroup_assign_update(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID, d);
+		if (ret)
+			goto out_fail;
+	}
+
+	if (assign_state & ASSIGN_LOCAL) {
+		ret = rdtgroup_assign_update(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID, d);
+		if (ret)
+			goto out_fail;
+	}
+
+	if (unassign_state & ASSIGN_TOTAL) {
+		ret = rdtgroup_unassign_update(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID, d);
+		if (ret)
+			goto out_fail;
+	}
+
+	if (unassign_state & ASSIGN_LOCAL) {
+		ret = rdtgroup_unassign_update(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID, d);
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
+static ssize_t rdtgroup_mbm_control_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes,
+					  loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	char *token, *cmon_grp, *mon_grp;
+	int ret;
+
+	if (!resctrl_arch_get_abmc_enabled())
+		return -EINVAL;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+	rdt_last_cmd_clear();
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
+			 * Make sure check for two consecutive delimiters and
+			 * advance the token.
+			 */
+			mon_grp = strsep(&token, "//");
+			if (*mon_grp != '\0') {
+				rdt_last_cmd_printf("Invalid CTRL_MON group format %s\n", token);
+				ret = -EINVAL;
+				break;
+			}
+
+			ret = rdtgroup_process_flags(r, RDTCTRL_GROUP, cmon_grp, mon_grp, token);
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
+			ret = rdtgroup_process_flags(r, RDTMON_GROUP, cmon_grp, mon_grp, token);
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
@@ -2277,9 +2589,10 @@ static struct rftype res_common_files[] = {
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


