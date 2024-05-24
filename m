Return-Path: <linux-kernel+bounces-188690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF348CE55C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F9D282098
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF6412C46B;
	Fri, 24 May 2024 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BsKvcU2G"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394BF12C467;
	Fri, 24 May 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553590; cv=fail; b=HFn8O2wReKchZOidrpXiLwdABueKfjsdZEi32J1LAjTAEnFRN+pu6KY+kJUGI5Cw6M5ZVVSIsnVUHnba4GHTFcELOPacTFOM1KgYoUUi2UZgayrfrojBfOgaXZ2RyPlzI7h9laGhzHF4g2Fkd2hXgZM65eCowk2tuR5YhCESec0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553590; c=relaxed/simple;
	bh=AyUWQpLd2Z/2VzCdQk/hKGR+/0KoDItT2GmZdZxvqzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toDHulZr3ONwwxBxdMrWeAWC8phj4d3ttt/zpWE2NAoOv6boxxnnGDDsNKX2ZjUai7mMuzr3/AaADuQj/5BOC7ZwQq87sNN81k0Q6XPH60mpoeivTzKjxmPkJA5nQ+PV3zpMvsruYvCNs56dpnYkf2BtBxLrsNEK6nhEqxlkTF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BsKvcU2G; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vovwfn9Z70U9IHTvuIsVW5jAWZL6U4XvcFNu6YEzkc793VDG8acvwSAm03ElgwzIpezRQBxgP6ug2ISkfW3G2ynx4LUHz2pVubFncm09xsaGgvdtb8GRYY4babQ/00US/HoZPXfcALpq35LGPxpwc9xbL61jISXxAYOoZaq41gGX3G4e6Mww0ZFWFyYQgXPhUlDspkdbP1i1HoGMTCTE9Z+7j9Lf+/pxseyCErizUtDpkI+l91x8oPRloMX4uIncmBOZEILlUeIWuUsDF0wovxbXm/YfMSLsw9tBA2VkHNTgFJfZ0i9eO++NHF/DXCx0M+MGhaKBfr6orS1OFOyXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3Oo48UfMt2uCLjcMPWZCu2wApcs32RTV2xbuviTZ38=;
 b=Ev853ZGtxkMxe0QLd7rjCBzf6HhR7usI45JnMSuT5bknU+tsymCv+gJtwmXy9p8AOuFjqUIH7n81OBse9BMm4VzcpBtDAuVUFl1dt7BPTy7mhVVPbsk3xTNp9k6ZCXVztw5JUDotwlVSOTAwd9vt7/QhW9+sP7AthbvCwEEBWiYGqHJDI2NiGH7ubznkKAl/rNWc2oBS+4Mmr698w2h2oDlqYttEtps5ok2TO3d10r6AR18cjFIiY6gerIelsyaunJxqhxvSYV58WxzDNNQITJzg+aWSOP+Wp+tQqjgYFNjK5L/VjFoV817r/0ucxWAeUeBnDNUDGTunhIrmAV2H0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3Oo48UfMt2uCLjcMPWZCu2wApcs32RTV2xbuviTZ38=;
 b=BsKvcU2GUxDj6SR0Fb2nQwcPN4N0eWdUmHd9U+tiGl5kVhGuk1WcQIJgh/r575YBVss1RrY2p5IGcOvfj3xiQheAqCUfF0Vliu6F0l1bpgVk+0/d38177oNhosfZBzPtR9LlR7HygHRgnRB8bQFqTBAPmv1u4PcAcooy4zPxBxQ=
Received: from CH0PR04CA0028.namprd04.prod.outlook.com (2603:10b6:610:76::33)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 12:26:25 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::47) by CH0PR04CA0028.outlook.office365.com
 (2603:10b6:610:76::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 12:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:26:25 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:26:23 -0500
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
Subject: [PATCH v4 19/19] x86/resctrl: Introduce interface to modify assignment states of the groups
Date: Fri, 24 May 2024 07:23:38 -0500
Message-ID: <c1e31aaaa4c9e9ab6050e2d66a547b9b37be31eb.1716552602.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716552602.git.babu.moger@amd.com>
References: <cover.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: ee58329b-16f7-47c2-b0b2-08dc7becba86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FSzBzIN8sddyAboYEjGeJBnfws9od8rjsFcjEw74LX2tyioZqOjX6vcphaob?=
 =?us-ascii?Q?RIjs2VR0yhDH1mJN9p8d3HGZo4ZqxBxcw6GntDhYwyP2XzkDsxTzFBGQlEz8?=
 =?us-ascii?Q?Qx+0WySTgENJHKzoOq1Ke9ya9R3V8QR2s0Ia7or/81Dyrm5Zsh3dY9rTISw6?=
 =?us-ascii?Q?614pUpLG4S0Z2J44WgJoRHoJEC8gu4wGByxPAUV2ZUCzNezaYwbMIWGtYZja?=
 =?us-ascii?Q?Oo2EFZXc+Zl0dsNGpXIWrh0j20hzkQeQtMWVZkor7ACyougHzfS3DpH5XJNo?=
 =?us-ascii?Q?CPzxnVp/N5tw6LVOG47UOAs2bS9JxDHAgdasgvTOWswm9jg9N14ILadqi9Qu?=
 =?us-ascii?Q?idBrj1NL/+QnriVg+JACkhjj4Hv+PrwBd6/B+X4+QuWy656bPgfvipp/6t/w?=
 =?us-ascii?Q?UdFGLAAlrc6hHNyo5Onxy4+GhGkEGgK6ygaxVZasHim7kkqVknBrOyYj77UK?=
 =?us-ascii?Q?rKPXPx66TPu/LVtHwt8koL8SX2aZgOj/B7tFHGd51/4J1ep6JK7i7u4WrGbZ?=
 =?us-ascii?Q?neRuE5/ZiN9azyLP6qf59CBz6ZGdR8odpVJSxTceBBAwHrXcEgInVmYiJJdM?=
 =?us-ascii?Q?5B2bgpKPHyOY/YTF8AbTXA4yWKzMOGqMOXLzDnYp6coxAqj7ZRJayyyj/QdH?=
 =?us-ascii?Q?QDNQ/fmplQHJXmIdU9fPrwNeEBtSbz8Bia/hOeE5C/df9gbxxGcKRCsYoC2h?=
 =?us-ascii?Q?EdDIRXOts+LxQZTcRMdMYgWXsu4ixknhd6SBL2kM+OlkvSJU+eL/DMP4Bx7y?=
 =?us-ascii?Q?OcDXpdofOCUtIPzAJ5Ong+a053gZUAChxD1c99+oUI81IhPh2THRyoypwgMz?=
 =?us-ascii?Q?1C3SWhsuSFXvtH+PGTyURX8b6JAPYR1L3um1R2yyHmnsW+J7iFsd6XuudvZE?=
 =?us-ascii?Q?Ef+1m0wg4EJXUaIy05o0fJ3ZsbtVlp9+1wRW/Z22SE42YRbVZFx3leJcs57J?=
 =?us-ascii?Q?iA3Mo8rantJ6sJDSutyQm+NkKeFGmcjwjyTj2LRyv61NrXcGVxZt+ToNR2kb?=
 =?us-ascii?Q?UPgPsxsY8y/XS5Ndreo9zrmvkajM3I4U2fjTKPNZb03CxIoRFCDZlYtBM2j+?=
 =?us-ascii?Q?Tcwyhc4H9mzJze9IDaw7GbSNKYnvr3P8QMhKlAxOo7AlFi0vK1VGIDx6H7mA?=
 =?us-ascii?Q?IvQ6b1BejdrZsYDx+gg2nvnNib5VBB321Qx9co92hZ3gwVOoF7c537M8zYeN?=
 =?us-ascii?Q?aDDFG78cqWoXgnJEw1vp6Qb/BSr7w4b1nDNXJOW+7NMMkP3/aWt/rQbKkj9a?=
 =?us-ascii?Q?dUEnYm4tmkjm9iqceae1tzvfF3q+tE/+Gtslxi9vHc0uzWaVE4MEy6WFL8Ml?=
 =?us-ascii?Q?7CpG5jPrOIs/VvF+w1P87SYV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:26:25.0717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee58329b-16f7-47c2-b0b2-08dc7becba86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

Introduce the interface to enable events in ABMC mode.

Events can be enabled or disabled by writing to file
/sys/fs/resctrl/info/L3_MON/mbm_assign_control

Format is similar to the list format with addition of op-code for the
assignment operation.
 "<CTRL_MON group>/<MON group>/<op-code><assignment_flags>"

Format for specific type of groups:

 * Default CTRL_MON group:
         "//<domain_id><op-code><assignment_flags>"

 * Non-default CTRL_MON group:
         "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"

 * Child MON group of default CTRL_MON group:
         "/<MON group>/<domain_id><op-code><assignment_flags>"

 * Child MON group of non-default CTRL_MON group:
         "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"

Op-code can be one of the following:

 = Update the assignment to match the flags
 + enable a new state
 - disable a new state

Assignment flags can be one of the following:
 t  MBM total event is enabled
 l  MBM local event is enabled
 tl Both total and local MBM events are enabled
 _  None of the MBM events are enabled

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: Added domain specific assignments. Fixed the opcode parsing.

v3: New patch.
    Addresses the feedback to provide the global assignment interface.
    https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
---
 Documentation/arch/x86/resctrl.rst     |  81 +++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 242 ++++++++++++++++++++++++-
 2 files changed, 322 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 255087de568d..89af91805b38 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -336,6 +336,87 @@ with the following files:
 	 /child_default_mon_grp/ - This is a child monitor group of the default control
 	 mon group.
 
+	Assignment state can be updated by writing to the interface.
+
+	Format is similar to the list format with addition of op-code for the
+	assignment operation.
+
+		"<CTRL_MON group>/<MON group>/<op-code><assignment_flags>"
+
+	Format for each type of groups:
+
+        * Default CTRL_MON group:
+                "//<domain_id><op-code><assignment_flags>"
+
+        * Non-default CTRL_MON group:
+                "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"
+
+        * Child MON group of default CTRL_MON group:
+                "/<MON group>/<domain_id><op-code><assignment_flags>"
+
+        * Child MON group of non-default CTRL_MON group:
+                "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"
+
+	Op-code can be one of the following:
+	::
+
+	 = Update the assignment to match the flags
+	 + Add a new state
+	 - delete a new state
+
+	Examples:
+	::
+
+	  Initial group status:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	  //0=tl;1=tl;
+	  /child_default_mon_grp/0=tl;1=tl;
+
+	  To update the default group to enable only total event on domain 0:
+	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	  Assignment status after the update:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	  //0=t;1=tl;2=tl;
+	  /child_default_mon_grp/0=tl;1=tl;
+
+	  To update the MON group child_default_mon_grp to remove total event on domain 1:
+	  # echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	  Assignment status after the update:
+	  $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	  //0=t;1=l;
+	  /child_default_mon_grp/0=t;1=tl;
+
+	  To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
+	  remove both local and total events on domain 1:
+	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
+			/sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	  Assignment status after the update:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=t;1=l;
+	  /child_default_mon_grp/0=t;1=tl;
+
+	  To update the default group to add a total event domain 1.
+	  # echo "//1+t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	  Assignment status after the update:
+
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=t;1=tl;
+	  /child_default_mon_grp/0=t;1=tl;
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index bd3a54405402..b74c18927bd2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1068,6 +1068,245 @@ static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int str_to_mon_state(char *flag)
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
+static struct rdtgroup *resctrl_get_rdtgroup(enum rdt_group_type rtype, char *p_grp, char *c_grp)
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
+static int resctrl_process_flags(enum rdt_group_type rtype, char *p_grp, char *c_grp, char *tok)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int op, mon_state, assign_state, unassign_state;
+	char *dom_str, *id_str, *op_str;
+	struct rdtgroup *rdtgrp;
+	struct rdt_domain *d;
+	unsigned long dom_id;
+	int ret, found = 0;
+
+	rdtgrp = resctrl_get_rdtgroup(rtype, p_grp, c_grp);
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
+	list_for_each_entry(d, &r->domains, list) {
+		if (d->id == dom_id) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found) {
+		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
+		return -EINVAL;
+	}
+
+	mon_state = str_to_mon_state(dom_str);
+
+	assign_state = 0;
+	unassign_state = 0;
+
+	switch (op) {
+	case '+':
+		assign_state = mon_state;
+		break;
+	case '-':
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
+		ret = resctrl_arch_assign(d, QOS_L3_MBM_TOTAL_EVENT_ID,
+					  rdtgrp->mon.rmid,
+					  rdtgrp->mon.ctr_id[0],
+					  rdtgrp->closid, 1);
+	if (ret)
+		goto out_fail;
+
+	if (assign_state & ASSIGN_LOCAL)
+		ret = resctrl_arch_assign(d, QOS_L3_MBM_LOCAL_EVENT_ID,
+					  rdtgrp->mon.rmid,
+					  rdtgrp->mon.ctr_id[1],
+					  rdtgrp->closid, 1);
+
+	if (ret)
+		goto out_fail;
+
+	if (unassign_state & ASSIGN_TOTAL)
+		ret = resctrl_arch_assign(d, QOS_L3_MBM_TOTAL_EVENT_ID,
+					  rdtgrp->mon.rmid,
+					  rdtgrp->mon.ctr_id[0],
+					  rdtgrp->closid, 0);
+
+	if (ret)
+		goto out_fail;
+
+	if (unassign_state & ASSIGN_LOCAL)
+		ret = resctrl_arch_assign(d, QOS_L3_MBM_LOCAL_EVENT_ID,
+					  rdtgrp->mon.rmid,
+					  rdtgrp->mon.ctr_id[1],
+					  rdtgrp->closid, 0);
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
+static ssize_t rdtgroup_mbm_assign_control_write(struct kernfs_open_file *of,
+						 char *buf, size_t nbytes,
+						 loff_t off)
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
+			 * The control mon group processing:
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
+			ret = resctrl_process_flags(RDTCTRL_GROUP, cmon_grp, mon_grp, token);
+			if (ret)
+				break;
+		} else if (strstr(token, "/")) {
+			/*
+			 * Mon group processing:
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
+			ret = resctrl_process_flags(RDTMON_GROUP, cmon_grp, mon_grp, token);
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
@@ -2268,9 +2507,10 @@ static struct rftype res_common_files[] = {
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


