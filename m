Return-Path: <linux-kernel+bounces-443904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28F49EFD54
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05566189105C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C401DDC37;
	Thu, 12 Dec 2024 20:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S5bR2xQx"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2F31DD0D6;
	Thu, 12 Dec 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034763; cv=fail; b=mz80OYnSXe05DcfP4sllZ1Nkpe39ekp45SJHN8af8IZbDx4YQTrzAjwPup6DXsrRCLAx63vdjsS4nGw6khQ9sPVHHjFXbZxPWjLVgL00cMvYLq2M7dmme8+kxuzrN+rVZp1rWz0ZcPOtMM/1yk8NYYsyLEL7ft16Mxrt0WzlDZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034763; c=relaxed/simple;
	bh=v9JPxdfRRDyJgh4KtNKZuAzMMdJDkEx9S2XKCcaMAis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juD3CqDUcN+8rTfakmNAkeQphIBQ/sMTwLoKWaOHajfKh/1hYt26LfxACZDyJkHAYtgXkGC0/hHCTiT6OAJfPrmLBXEbMMf9VB3SnkA+B3w6fsWgSjC18rEizn0AS1GyHR2giAs5+jekZatpTo4NMGnWcUWydIgTKPB9BQ+0Gjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S5bR2xQx; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRdLWl78fLdtf0Psdbo/tyWYt7HFhWBor3zQZNGHf8yXRLBgV8LgQkFAerdbmH1jzec0ngHKhorcRTmtD/oNhUrWguGAUUa6B6vM4/FK4MnZhLpARKqvkx3zsOkWJKzv+O6sSeczNp8vuNT3Q7mjl/vAWDx9vNgOafR0j0d/Sz70sUYAnDd+4AZ5KAZH1a5tG1eOfVpO8Ipv78O1NhHSc2VExPAVYzZdn7aBJMHnb5cHabR+ukUT1dhA3KdfkvLEhjN+c00eBGa9aYJ6l4TvX9xUEYzmDwl5f6kHAjdJfTmnU5dIHY31kelpEkheb9N+r4C0mFSEx/aHSVijf8uYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUX9nJS79VDsDk6oax9ocJQlzLq1/7eKXDyJLZSx9r8=;
 b=Sgo2OA+Cw3jW3fmxapwnxDtHc/SSL8dH+gXyhGyrwaZhPnwhaqqBbE0aEZy9JecSoclcjkNhoeGZCzsaK8CjZyuAo6DIOItSh5HQzcC+UngoLr/gSJK1BSCMfqPX2lpLNyPTxJyhUN/cGJOdyeOWvTPfnmrAM+GEJH+ypq/Qhi1jZ24YkoruK5qKCe+ij1b01nGBceYmT9Zmubw9f2T9aGzbP/p6sQ1OFe8VT4M4xKt6vUvn6zc5gPBPl7rmDpPNsc7ZUnBqy/FiZAPI6QERjr7cK87ys/qEcLldzWS/firRPlpiobGZysXR6+u8c30Q2oXNTk1RAzFyCd/9SK6ZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUX9nJS79VDsDk6oax9ocJQlzLq1/7eKXDyJLZSx9r8=;
 b=S5bR2xQxJ8ndLsMZJwFv5dPcHFI6U6jsO0whUSpDVrmcCTY5eBjFBSf3DAPqqY8qOBTcB+5j/xiFx5EZjCpi8n0EzwNSoZ4uK+4LeYN2jgp8b4JC0T3t3s1GkqInehaem29yZzy/9V+ByQOEB8eba183bHuNwTuxeUdTh+IC+Q8=
Received: from BN9PR03CA0775.namprd03.prod.outlook.com (2603:10b6:408:13a::30)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:19:14 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::37) by BN9PR03CA0775.outlook.office365.com
 (2603:10b6:408:13a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 20:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:19:14 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:19:12 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <peternewman@google.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <andipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<babu.moger@amd.com>, <xin3.li@intel.com>, <andrew.cooper3@citrix.com>,
	<ebiggers@google.com>, <mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
Subject: [PATCH v10 24/24] x86/resctrl: Introduce interface to modify assignment states of the groups
Date: Thu, 12 Dec 2024 14:15:27 -0600
Message-ID: <2da72f1a57beb1f3de5cb2bdeda2269bdade8c76.1734034524.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734034524.git.babu.moger@amd.com>
References: <cover.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: 96071d37-bcac-4360-237b-08dd1aea3f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zi9JZFdoRFdQMHMrMUNqN0FFdXYyaGdaN2lZU2Nrd3ZzTlhad25KUi9TVjRO?=
 =?utf-8?B?K0xvbmNDa3dndTlWUzl4Y2Z3WWRVdjRaQnpuL2lacGdyMytMYUlBc2lkbHFo?=
 =?utf-8?B?dm90UGFwMUdxNERNdnZIUHc0b3V6bGJCdUluQTU0RVJ0OGoyZWNxRTVqNlla?=
 =?utf-8?B?amYwS3dNWHlsYmQ0TUFyRVJIZFlkMERrRFk3Z3hCdTFqa2ZKN2JINElia2Jx?=
 =?utf-8?B?TUhPWUZkeGJxVnpQb2dSTDUyN2RGNXFQdkhsdUV6OG41M0FOdXJjOU9VSDVK?=
 =?utf-8?B?VFRwS3JXdVdIWjA5TDVZeUx6TmdpemRSSTNKUEIwOE9mSDRvd2c4S0M0VFpq?=
 =?utf-8?B?QVk2MjlDYlQ0TWkzL1pkcHNoZGtFUm9OWXNTU0ZoZ3ZReGhBZExTRFhWVzFs?=
 =?utf-8?B?cStPanl6TEVCajRLU2loUmplOUZNMjRHT0dRTnN5dzRNQXpFdFpMREViemlT?=
 =?utf-8?B?QUo0VDJlWXlKR1ROZkNGVjVxcUl4RjBWNGJoQktsazFjTlRmQllFNmpBRGNj?=
 =?utf-8?B?VUJwblBKR251Qlc1cVRDZWszdGZza2o4YkNXL2JmR1NNaWp1Zm1JbkQ0WHZM?=
 =?utf-8?B?a1JSRW43ODFsQ2lTcTFmeWFVbUlET2QrWkM3TlNMWmdpdGJxSjFEb28wb21J?=
 =?utf-8?B?RXlPWFE2S2sxdE1yZGZkempUcFk5OG03WG1BdTV4eHdLWWp0Tk1odXc2N1Rm?=
 =?utf-8?B?d2xhUVBJaW8yOTlxNzE3MlVTRzR4N0lYVW04Q0lGMktIQURUQmJDZWJwa2N5?=
 =?utf-8?B?UnBlMkh0ZDlpd3hkKzJJYmZ6UmdQYmgzbTNQYk5HMGNNaVlWbzZIWm9GbERj?=
 =?utf-8?B?MmNGVWRnNkhKRWhtTTFoaWM2Q1JEZi9pN1FhbGd1T0FEWU5uYTJ4a1BxRko0?=
 =?utf-8?B?em9BY0Zyak9VYkVrNXV3NFYyZE02T1p2WGcvSUoxUmNuQlZBcjR3ZW1CM0Z2?=
 =?utf-8?B?c0IxNzQzcE04UlVkL2ZWaWlnY0J4ZWIyU0YzbnBvVHVqdU9BSTJ4UXVXaUoz?=
 =?utf-8?B?T3JTYWJpZEdIaldWZEo5TDdRMjJKQS84OE9uTnpYN09ScFMycWlqQVY3OGpO?=
 =?utf-8?B?NkxaY0hOb3grejcwK2lVK0tCeXNVV0lOYlAvOFp6Zml3TEdjeG96MG5Ld3Vw?=
 =?utf-8?B?MmJxL2hDWVJqN2JNNlI1eG1GQk4vaWpLcFlZaThmWFJhT1M2U3dGS1R3TS90?=
 =?utf-8?B?Z1NRK09GUFBYb3dXUWhQUnlQYXFYMEl5anVvbGxGdkNwcWFCbm56WVBQdm9X?=
 =?utf-8?B?NGxNS1RueWhQQnMweTIyQk9NaHNHeXZjMzRIc2Noc2s1QVNjb3FPWHFETmRa?=
 =?utf-8?B?UUMxb3kxMGZpQVgwdEdqMWFMdWFiMDRHSndqaUg5OStJRGp0SmhQekpZTEJX?=
 =?utf-8?B?enRoWkx3QlByN2ZpWlBmYmViWEdLV3dSTFlMS0JHd3VqeEVwTWlvZnk2U2Uw?=
 =?utf-8?B?aHY3dzJ1alk0bDNVSGE0UzZEUkhhS05WT0s1ZC80VTlkbXgzOW5pLy9EMGZ3?=
 =?utf-8?B?ZEJrRlFXYWRSM3FvUEF2aFBwWml1NDcrOThuVUxUMGlyc0p2TFBIUndkQ2JF?=
 =?utf-8?B?dnBlM0UvYzVwT096YlRGdngxaGJDRXVjcnltZXVaaTJMSmVqVStURVRPTGpp?=
 =?utf-8?B?aG8xMkFzOWJNZlJLbEtGZjBwanNTVzlsZGtFQzRkVE51UmdvbjJocW1MVmhR?=
 =?utf-8?B?S0RpeTdKVzkxZkFmMm9oYTR0cEo2cDVnU1BhZTJUQVB6STFLUG5uNHkrZUJR?=
 =?utf-8?B?TDFWWHlBKzdTSU1nem1WRWJzcDR4QVVxSGluVEZLcU85TjVzRkk4Y3BYN3ZB?=
 =?utf-8?B?Y0syOFBKNzZ2MElOdWVZajZwUWJKQjU2UHRXNmF6dWtzYno1TmRBVDNaNWQ1?=
 =?utf-8?B?T1BvekRBZU1IRHNacGRTUHdyMzl1clRzMnIwYVpXNlRxZk1DYVVTVFZRZVhY?=
 =?utf-8?Q?ZLrhrAq+WRXHMgx69UHc9iQAC0dC17XD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:19:14.6475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96071d37-bcac-4360-237b-08dd1aea3f89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520

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
v10: Fixed the issue with finding the domain in multiple iterations.
     Printed error message with domain information when assign fails.
     Changed the variables to unsigned for processing assign state.
     Taken care of few format corrections.

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
---
 Documentation/arch/x86/resctrl.rst     | 116 +++++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  10 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 241 ++++++++++++++++++++++++-
 3 files changed, 365 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 9ae2b8f335dd..3bb7c11df59d 100644
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
 
+	Assignment state can be updated by writing to "mbm_assign_control".
+
+	Format is similar to the list format with addition of opcode for the
+	assignment operation.
+
+		"<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
+
+	Format for each type of group:
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
+	Domain_id '*' will apply the flags to all the domains.
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
+	To update the default group to add a local MBM event domain 0:
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
+	MBM events on all the domains:
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
index 1ca51f68a523..f433e31a5e87 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -62,6 +62,16 @@
 /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
 #define ABMC_ENABLE_BIT			0
 
+/*
+ * Assignment flags for mbm_cntr_assign mode
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
index 70bf590ded8a..61a552974f13 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1051,6 +1051,244 @@ static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static unsigned int rdtgroup_str_to_mon_state(char *flag)
+{
+	unsigned int i, mon_state = ASSIGN_NONE;
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
+	unsigned int op, mon_state, assign_state, unassign_state;
+	char *dom_str, *id_str, *op_str;
+	struct rdt_mon_domain *d;
+	struct rdtgroup *rdtgrp;
+	unsigned long dom_id;
+	char domain[10];
+	bool found;
+	int ret;
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
+	found = false;
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		if (d->hdr.id == dom_id) {
+			found = true;
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
+	sprintf(domain, d ? "%ld" : "*", dom_id);
+
+	rdt_last_cmd_printf("Assign operation '%s%c%s' failed on the group %s/%s/\n",
+			    domain, op, dom_str, p_grp, c_grp);
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
@@ -2383,9 +2621,10 @@ static struct rftype res_common_files[] = {
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


