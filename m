Return-Path: <linux-kernel+bounces-316028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEB396CA2D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1D71F288EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927B217920E;
	Wed,  4 Sep 2024 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HY6GAVo7"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406E1714B4;
	Wed,  4 Sep 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488524; cv=fail; b=cIp+k3ugjyFWIHbb6j2y2BtbziSkJB1emFxJlvmfiRk/6SiQFimJCAe+dIwQeLtXdS3EtEdBibPX3yHcJ/Wxmn2gCg7QLh5RE7OUsglJ/qYpiEUNXnzPi1mP+2o6WCelm7L5j9ep+QL4+lpfewz0J5tmd/oSVMYVsXmgtLFuFng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488524; c=relaxed/simple;
	bh=gNT9vtdGgoetBcEXofkLzsOAqboZd0ONcEIM1C5FDF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S8B2DXnxCCvcPhoDHHLzQMMFZIt6jeQG6c+EDJd23sxIKO2r9Vfz34A1dWJGH4+UedYM7/A31DBAHFH/KN/uug7WhGJ4dPB+zQN5bjX0ANo/V9QGu4v2+kkCmWvjushWgvckGUMroq8KT7z05eJojJSJPatXttAJfAJAymxtb8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HY6GAVo7; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6yiP6bEyYwp1rp17I+Zmt08ghLyzI0NEAP8uURC6Cbrfki+Gn54eG8afLxXdGLSIle5xarB2Yz1vx108+AvlC6zm/wRbD36glFsvObGfZeyPJfqsxeWMdgY2rJj0yd1OeFZVTNF0DuWVXrvi4hqR8w6luHs/D0CahUBTzFv+vLlmITMifv4QbsCgNedH1+ciZzKlYGoVxinRTHmV3+fxXp3FRQilyOYkSISEavM29Sh7gERLFurCrXGUBTJ4jD8CUOHHtxrLccl7no0jeKrPimIZIDXPZvg98Ug3GNGK/2ttNXBgyLkdANCE6aX04Az2LdC0WtAPyt0a35LGzebXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmDr5RBpoPvDeMKspn2F3oCfqtv6QvRADPdBqsfr2t8=;
 b=bATI87Rag+KAq8w/l9Q8/CVH0NiJXA51dwvVh8RFDcixuVyq5g3cm1DPtOLRBKZnKx2CzqLC2dOY24dGT6qrh+Ce1Wp3UqEGYHuU2M7w2Hue4gn8Y5A+yUOfh0v2JNYvp82NA7EGbVRA1kgbvh2rOWylFFbmOwuKvpLtzoqThG9KCghf+9xC3JxdyLQZ0CfRkNl1xGmLzlZJFXJXv2aAPXDTS2MyNbcKMKit3ypiVH+zaHjVeu+O/sSqwhPXXp/cevHwzRTcHqL67et2cSXcMib6fxf2nySBrqL9zGKFOCqo2hNU2fdGrcm1gJj5z0VffXWmx8dTpzOIgdf48fLCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmDr5RBpoPvDeMKspn2F3oCfqtv6QvRADPdBqsfr2t8=;
 b=HY6GAVo7zBWkq44n9CEJ3LhEo7AwjmdLFEeyk/jrsl75zlVLJyLCSfBq/kbZfd1QZR8mBS7bajKc7VcVUfX2w0WbMD+9Q2Zlh54L+mdPTXMSKGP6/fiTUGkq7usr/gC7HnEPV4K+y3DTxkRCEJe5NUdy9ozwwQUgZb21oSoXDGs=
Received: from SJ0PR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:334::22)
 by LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 4 Sep
 2024 22:21:56 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::ce) by SJ0PR05CA0107.outlook.office365.com
 (2603:10b6:a03:334::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 22:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:21:53 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:21:51 -0500
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
Subject: [PATCH v7 00/24] x86/resctrl : Support AMD Assignable Bandwidth Monitoring Counters (ABMC)
Date: Wed, 4 Sep 2024 17:21:15 -0500
Message-ID: <cover.1725488488.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b3f999-cb9c-4528-fb47-08dccd2ffb2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDMycWg0TDU3SkVEQVBxNHM1ZVFVaUp1OGtOdWNQckNmWS9iMlBnaUJNenVP?=
 =?utf-8?B?TDBtNUlWSFU1Y2JBOFFoVFoxbXpFcWVqc0R3MC91SndMdTMvT0NORE0wNC9N?=
 =?utf-8?B?Vkp6VWYrRUpwQ292R2RLSFR1QTBjcnpWckdsQUt3OHVrNEFiaE9FUUtBSFhq?=
 =?utf-8?B?a1ZsU056REpFdml5Z2RPRkNxYVhheVR4OERPcnI5V3lsU0xRSmlNYXVMTzhi?=
 =?utf-8?B?cG5OK3h1ZHFpOEFDNDZoekpJRmptQURYbkZjZUVWYk4xZUlKeUFwcEk5THBX?=
 =?utf-8?B?bElRUmVMQzVwV3dlVFFYMWlNbFBycnNscWZpell5S1BHOTg3aEd0SlFJTWN5?=
 =?utf-8?B?L3gwZWVxKzIvUjl5VlFVTm1BUWkzR0c5cm1HTVJUMmZoaEdoSE1NT3lyRlZX?=
 =?utf-8?B?QjJ3aVhDVG1VY2d6bmZtTGlwVVU3WU85OG1GVExkbWdqT1djcEhCQnBtZW9u?=
 =?utf-8?B?TTZ3VlVvWVZsOTAwZDIwYW9pM0dJZ2F5OGxZZEhlaWZFeVAycmMzODJ5Q2hC?=
 =?utf-8?B?b1drYmxndTU1dUxpNVpydHNwTTVrWFJEbDVyUjI2em1VZDdUSmNuYUJhSFc4?=
 =?utf-8?B?QS9ETGJnbmlzNU10b3dnbXdBVC9wVm1SUldqb2dQTzlqakpkRnB4Ry9DdU80?=
 =?utf-8?B?TFFKMEs5c0tMNjJ2YUVOajB1a1BMMWdXeityRDVrSmN1blhpUUVxcXFEQy9Q?=
 =?utf-8?B?MXRmWnU0cHVkWk9iSE9rSktOdUxlSVhPSW53YjVXOTlQcDdGU2hqL2c0UHN0?=
 =?utf-8?B?d0R2eHpnOFpFUW1Oa05Od2lUT2tiUnFzeGpTcHBGV2M4aGp0L2poOEcvZGJO?=
 =?utf-8?B?KzNSanN3aDZKMXZqYmF6ZDZKUERDQ2N1NUp5UXF0N0JDV1hQNC9TQ204WEEz?=
 =?utf-8?B?TnJKcVZZOUhVQmJkcmhIeis2SjhORzdUa3k1YmZoNkY2T3FZOG5oNnlSeHRw?=
 =?utf-8?B?bHlUcUtaOTZEdGU1bC8zU1h2NlpWLzAxMzFLSVhDN0Z3WUtZZHBRaW9zTmV4?=
 =?utf-8?B?WDQ4c2JlZkFlc2E2bm0yZ3JRSlhJeHNJL0IvMElHQzk2UXJiYWRDMFB6bmUx?=
 =?utf-8?B?S2h0d2Q4TWN5VUFGZjI2eGtmaHNENFRFRzJaTVVHbUo4cjRZeGNFOHhMOVBn?=
 =?utf-8?B?VURRZ1l0REJBenhIeUZHZURGWXl0TzdnSmhxZ0Y1ZjBjQkpYa1dwbUZEUkxa?=
 =?utf-8?B?aXFRODBLQjNDQnlvRGRxU3JFU3FaT0o1a0ZHUWUybDF6d3VWeUlwNWlPUFU3?=
 =?utf-8?B?TTR2bVNWY3MwNHJlb05URElvTkhxL1lHZUw3QWI0TjE1aHQyWW0vSG02M2Ns?=
 =?utf-8?B?RERCRWtlZjdtZ3p1L2h6aHMxMjRpLytpL2RrbmlveHg0RllXaU1NSDVxLzhp?=
 =?utf-8?B?Q2pEVjR0YWRzRlpIckdKa0NRQnhVaUxkR2JkNG5uMFk3SVFvR0lEQ0Z1dndF?=
 =?utf-8?B?QWtBREM3cnUwNDZ2SnF6T0VYZ0hpUHd3OGlMYzdkbVhLS0Q1bVpPNFJ6K3BD?=
 =?utf-8?B?SEt0VWJONXBzdW1vQ0lRVVJSczQ2ZXh4ZXlRU2hPS0VHY2FhNGtRZ2tHWXds?=
 =?utf-8?B?aDNuZ1JTSEhpeCtLTDAvbzBCb2NmYU95bzBGekYxM0dKcnI0dDd4TE1kOXFn?=
 =?utf-8?B?QmJSVllPaE03Z1NVV25CaktKQ3BPVlhBUTlxSTFabEdQbWxBcmJKVlRWM1RV?=
 =?utf-8?B?Ny9sQk9VQ2d2UFl6TlROckIrQnpDQ0ZMd3lnd2FUY1dmU0E0T1k4ZlcrU1dN?=
 =?utf-8?B?VUs2MHFIUG5MeGVzUkNjMTR6cFN6VHV3THl1ZFNMT1RLbzU2bW9FTzBFeUJq?=
 =?utf-8?B?Q241WUZoRlJ4aGgzMEtzRHB3VlZrdXNHc2o3dWprWjZyUkFybVphU29MTzE4?=
 =?utf-8?B?QWx0RjlrMFZNbUZrajczeWQxdmJFenRjd1h3NUIwTGQxQ2llN0tJSVJBZTh1?=
 =?utf-8?Q?SSHeAAr6TQhNVKstxExFh7e8s6r2lV+z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:21:53.4260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b3f999-cb9c-4528-fb47-08dccd2ffb2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265


This series adds the support for Assignable Bandwidth Monitoring Counters
(ABMC). It is also called QoS RMID Pinning feature

Series is written such that it is easier to support other assignable
features supported from different vendors.

The feature details are documented in the  APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC). The documentation is available at
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

The patches are based on top of commit
a85536e1bce7 (tip/master) Merge branch into tip/master: 'x86/timers'

# Introduction

Users can create as many monitor groups as RMIDs supported by the hardware.
However, bandwidth monitoring feature on AMD system only guarantees that
RMIDs currently assigned to a processor will be tracked by hardware.
The counters of any other RMIDs which are no longer being tracked will be
reset to zero. The MBM event counters return "Unavailable" for the RMIDs
that are not tracked by hardware. So, there can be only limited number of
groups that can give guaranteed monitoring numbers. With ever changing
configurations there is no way to definitely know which of these groups
are being tracked for certain point of time. Users do not have the option
to monitor a group or set of groups for certain period of time without
worrying about RMID being reset in between.
    
The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as it is assigned.
The assigned RMID will be tracked by the hardware until the user unassigns
it manually. There is no need to worry about counters being reset during
this period. Additionally, the user can specify a bitmask identifying the
specific bandwidth types from the given source to track with the counter.

Without ABMC enabled, monitoring will work in current mode without
assignment option.

# Linux Implementation

Create a generic interface aimed to support user space assignment
of scarce counters used for monitoring. First usage of interface
is by ABMC with option to expand usage to "soft-ABMC" and MPAM
counters in future.

Feature adds following interface files:

/sys/fs/resctrl/info/L3_MON/mbm_assign_mode: Reports the list of assignable
monitoring features supported. The enclosed brackets indicate which
feature is enabled.

/sys/fs/resctrl/info/L3_MON/num_mbm_cntrs: Reports the number of monitoring
counters available for assignment.

/sys/fs/resctrl/info/L3_MON/mbm_assign_control: Reports the resctrl group and monitor
status of each group. Assignment state can be updated by writing to the
interface.

# Examples

a. Check if ABMC support is available
	#mount -t resctrl resctrl /sys/fs/resctrl/

	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
	[mbm_cntr_assign]
	default

	ABMC feature is detected and it is enabled.

b. Check how many ABMC counters are available. 

	#cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs 
	32

c. Create few resctrl groups.

	# mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp


d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
   to list and modify the group's monitoring states. File provides single place
   to list monitoring states of all the resctrl groups. It makes it easier for
   user space to to learn about the used counters without needing to traverse
   all the groups thus reducing the number of file system calls.

	The list follows the following format:

	"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"

	Format for specific type of groups:

	* Default CTRL_MON group:
	 "//<domain_id>=<flags>"

       * Non-default CTRL_MON group:
               "<CTRL_MON group>//<domain_id>=<flags>"

       * Child MON group of default CTRL_MON group:
               "/<MON group>/<domain_id>=<flags>"

       * Child MON group of non-default CTRL_MON group:
               "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"

       Flags can be one of the following:

        t  MBM total event is enabled.
        l  MBM local event is enabled.
        tl Both total and local MBM events are enabled.
        _  None of the MBM events are enabled

	Examples:

	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control 
	non_default_ctrl_mon_grp//0=tl;1=tl;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
	//0=tl;1=tl;
	/child_default_mon_grp/0=tl;1=tl;
	
	There are four groups and all the groups have local and total
	event enabled on domain 0 and 1.

e. Update the group assignment states using the interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control.

 	The write format is similar to the above list format with addition
	of opcode for the assignment operation.
    	“<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”

	
	* Default CTRL_MON group:
	        "//<domain_id><opcode><flags>"
	
	* Non-default CTRL_MON group:
	        "<CTRL_MON group>//<domain_id><opcode><flags>"
	
	* Child MON group of default CTRL_MON group:
	        "/<MON group>/<domain_id><opcode><flags>"
	
	* Child MON group of non-default CTRL_MON group:
	        "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
	
	Opcode can be one of the following:
	
	= Update the assignment to match the flags.
	+ Assign a new MBM event without impacting existing assignments.
	- Unassign a MBM event from currently assigned events.

	Flags can be one of the following:

        t  MBM total event.
        l  MBM local event.
        tl Both total and local MBM events.
        _  None of the MBM events. Only works with '=' opcode.
	
	Initial group status:
	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
	non_default_ctrl_mon_grp//0=tl;1=tl;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
	//0=tl;1=tl;
	/child_default_mon_grp/0=tl;1=tl;

	To update the default group to enable only total event on domain 0:
	# echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

	Assignment status after the update:
	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
	non_default_ctrl_mon_grp//0=tl;1=tl;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
	//0=t;1=tl;
	/child_default_mon_grp/0=tl;1=tl;

	To update the MON group child_default_mon_grp to remove total event on domain 1:
	# echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

	Assignment status after the update:
	$ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
	non_default_ctrl_mon_grp//0=tl;1=tl;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
	//0=t;1=tl;
	/child_default_mon_grp/0=tl;1=l;

	To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
	remove both local and total events on domain 1:
	# echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
	       /sys/fs/resctrl/info/L3_MON/mbm_assign_control

	Assignment status after the update:
	non_default_ctrl_mon_grp//0=tl;1=tl;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
	//0=t;1=tl;
	/child_default_mon_grp/0=tl;1=l;

	To update the default group to add a local event domain 0.
	# echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

	Assignment status after the update:
	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
	non_default_ctrl_mon_grp//0=tl;1=tl;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
	//0=tl;1=tl;
	/child_default_mon_grp/0=tl;1=l;

	To update the non default CTRL_MON group non_default_ctrl_mon_grp to unassign all
	the MBM events on all the domains.
	# echo "non_default_ctrl_mon_grp//*=_" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

	Assignment status after the update:
	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
	non_default_ctrl_mon_grp//0=_;1=_;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
	//0=tl;1=tl;
	/child_default_mon_grp/0=tl;1=l;


f. Read the event mbm_total_bytes and mbm_local_bytes of the default group.
   There is no change in reading the events with ABMC. If the event is unassigned
   when reading, then the read will come back as "Unassigned".
	
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	779247936
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
	765207488
	
g. Check the bandwidth configuration for the group. Note that bandwidth
   configuration has a domain scope. Total event defaults to 0x7F (to
   count all the events) and local event defaults to 0x15 (to count all
   the local numa events). The event bitmap decoding is available at
   https://www.kernel.org/doc/Documentation/x86/resctrl.rst
   in section "mbm_total_bytes_config", "mbm_local_bytes_config":
	
	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	0=0x7f;1=0x7f
	
	#cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config 
	0=0x15;1=0x15
	
h. Change the bandwidth source for domain 0 for the total event to count only reads.
   Note that this change effects total events on the domain 0.
	
	#echo 0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	0=0x33;1=0x7F
	
i. Now read the total event again. The first read will come back with "Unavailable"
   status. The subsequent read of mbm_total_bytes will display only the read events.
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	Unavailable
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	314101

j. Users will have the option to go back to 'default' mbm_assign_mode if required.
   This can be done using the following command. Note that switching the
   mbm_assign_mode will reset all the MBM counters of all resctrl groups.

	# echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
	mbm_cntr_assign
	[default]

	
k. Unmount the resctrl
	 
	#umount /sys/fs/resctrl/
---
v7:
   Major changes are related to FS and arch codes separation.
   Changed few interface names based on feedback.
   Here are the summary and each patch contains changes specific the patch.

   Removed WARN_ON for num_mbm_cntrs. Decided to dynamically allocate the bitmap.
   WARN_ON is not required anymore.
 
   Renamed the function resctrl_arch_get_abmc_enabled() to resctrl_arch_mbm_cntr_assign_enabled().

   Merged resctrl_arch_mbm_cntr_assign_disable, resctrl_arch_mbm_cntr_assign_disable
   and renamed to resctrl_arch_mbm_cntr_assign_set(). Passed the struct rdt_resource
   to these functions.

   Removed resctrl_arch_reset_rmid_all() from arch code. This will be done from FS the caller.

   Updated the descriptions/commit log in resctrl.rst to generic text. Removed ABMC references.
   Renamed mbm_mode to mbm_assign_mode.
   Renamed mbm_control to  mbm_assign_control.
   Introduced mutex lock in rdtgroup_mbm_mode_show().
 
   The 'legacy' mode is called 'default' mode. 

   Removed the static allocation and now allocating bitmap mbm_cntr_free_map dynamically.

   Merged rdtgroup_assign_cntr(), rdtgroup_alloc_cntr() into one.
   Merged rdtgroup_unassign_cntr(), rdtgroup_free_cntr() into one.
   
  Added struct rdt_resource to the interface functions resctrl_arch_assign_cntr ()
  and resctrl_arch_unassign_cntr().
  Rename rdtgroup_abmc_cfg() to resctrl_abmc_config_one_amd().
   
  Added a new patch to fix counter assignment on event config changes.

  Removed the references of ABMC from user interfaces.

  Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
  Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.

  Thomas Gleixner asked us to update  https://gitlab.com/x86-cpuid.org/x86-cpuid-db. 
  It needs internal approval. We are working on it.

v6:
  We still need to finalize few interface details on mbm_assign_mode and mbm_assign_control
  in case of ABMC and Soft-ABMC. We can continue the discussion with this series.

  Added support for domain-id '*' to update all the domains at once.
  Fixed assign interface to allocate the counter if counter is
  not assigned.   
  Fixed unassign interface to free the counter if the counter is not
  assigned in any of the domains.

  Renamed abmc_capable to mbm_cntr_assignable.

  Renamed abmc_enabled to mbm_cntr_assign_enabled.
  Used msr_set_bit and msr_clear_bit for msr updates.
  Renamed resctrl_arch_abmc_enable() to resctrl_arch_mbm_cntr_assign_enable().
  Renamed resctrl_arch_abmc_disable() to resctrl_arch_mbm_cntr_assign_disable().

  Changed the display name from num_cntrs to num_mbm_cntrs.

  Removed the variable mbm_cntrs_free_map_len. This is not required.
  Removed the call mbm_cntrs_init() in arch code. This needs to be done at higher level.
  Used DECLARE_BITMAP to initialize mbm_cntrs_free_map.
  Removed unused config value definitions.

  Introduced mbm_cntr_map to track counters at domain level. With this
  we dont need to send MSR read to read the counter configuration.

  Separated all the counter id management to upper level in FS code.

  Added checks to detect "Unassigned" before reading the RMID.

  More details in each patch.

v5:
  Rebase changes (because of SNC support)

  Interface changes.
   /sys/fs/resctrl/mbm_assign to /sys/fs/resctrl/mbm_assign_mode.
   /sys/fs/resctrl/mbm_assign_control to /sys/fs/resctrl/mbm_assign_control.

  Added few arch specific routines.
  resctrl_arch_get_abmc_enabled.
  resctrl_arch_abmc_enable.
  resctrl_arch_abmc_disable.

  Few renames
   num_cntrs_free_map -> mbm_cntrs_free_map
   num_cntrs_init -> mbm_cntrs_init
   arch_domain_mbm_evt_config -> resctrl_arch_mbm_evt_config

  Introduced resctrl_arch_event_config_get and
    resctrl_arch_event_config_set() to update event configuration.

  Removed mon_state field mongroup. Added MON_CNTR_UNSET to initialize counters.

  Renamed ctr_id to cntr_id for the hardware counter.
 
  Report "Unassigned" in case the user attempts to read the events without assigning the counter.
  
  ABMC is enabled during the boot up. Can be enabled or disabled later.

  Fixed opcode and flags combination.
    '=_" is valid.
    "-_" amd "+_" is not valid.

 Added all the comments as far as I know. If I missed something, it is not intentional.

v4: 
  Main change is domain specific event assignment.
  Kept the ABMC feature as a default.
  Dynamcic switching between ABMC and mbm_legacy is still allowed.
  We are still not clear about mount option.
  Moved the monitoring related data in resctrl_mon structure from rdt_resource.
  Fixed the display of legacy and ABMC mode.
  Used bimap APIs when possible.
  Removed event configuration read from MSRs. We can use the
  internal saved data.(patch 12)
  Added more comments about L3_QOS_ABMC_CFG MSR.
  Added IPIs to read the assignment status for each domain (patch 18 and 19)
  More details in each patch.

v3:
   This series adds the support for global assignment mode discussed in
   the thread. https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
   Removed the individual assignment mode and included the global assignment interface.
   Added following interface files.
   a. /sys/fs/resctrl/info/L3_MON/mbm_assign
      Used for displaying the current assignment mode and switch between
      ABMC and legacy mode.
   b. /sys/fs/resctrl/info/L3_MON/mbm_assign_control
      Used for lising the groups assignment mode and modify the assignment states.
   c. Most of the changes are related to the new interface.
   d. Addressed the comments from Reinette, James and Peter.
   e. Hope I have addressed most of the major feedbacks discussed. If I missed
      something then it is not intentional. Please feel free to comment.
   f. Sending this as an RFC as per Reinette's comment. So, this is still open
      for discussion.

v2:
   a. Major change is the way ABMC is enabled. Earlier, user needed to remount
      with -o abmc to enable ABMC feature. Removed that option now.
      Now users can enable ABMC by "$echo 1 to /sys/fs/resctrl/info/L3_MON/mbm_assign_enable".
     
   b. Added new word 21 to x86/cpufeatures.h.

   c. Display unsupported if user attempts to read the events when ABMC is enabled
      and event is not assigned.

   d. Display monitor_state as "Unsupported" when ABMC is disabled.
  
   e. Text updates and rebase to latest tip tree (as of Jan 18).
 
   f. This series is still work in progress. I am yet to hear from ARM developers. 

v6:
  https://lore.kernel.org/lkml/cover.1722981659.git.babu.moger@amd.com/

v5:
  https://lore.kernel.org/lkml/cover.1720043311.git.babu.moger@amd.com/

v4:
  https://lore.kernel.org/lkml/cover.1716552602.git.babu.moger@amd.com/

v3:
 https://lore.kernel.org/lkml/cover.1711674410.git.babu.moger@amd.com/  

v2:
  https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/

v1 :
   https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/


Babu Moger (24):
  x86/cpufeatures: Add support for Assignable Bandwidth Monitoring
    Counters (ABMC)
  x86/resctrl: Add ABMC feature in the command line options
  x86/resctrl: Consolidate monitoring related data from rdt_resource
  x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
  x86/resctrl: Introduce resctrl_file_fflags_init() to initialize fflags
  x86/resctrl: Add support to enable/disable AMD ABMC feature
  x86/resctrl: Introduce the interface to display monitor mode
  x86/resctrl: Introduce interface to display number of monitoring
    counters
  x86/resctrl: Introduce bitmap mbm_cntr_free_map to track assignable
    counters
  x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg in struct
    rdt_hw_mon_domain
  x86/resctrl: Remove MSR reading of event configuration value
  x86/resctrl: Introduce mbm_cntr_map to track counters at domain
  x86/resctrl: Add data structures and definitions for ABMC assignment
  x86/resctrl: Introduce cntr_id in mongroup for assignments
  x86/resctrl: Implement resctrl_arch_assign_cntr to assign a counter
    with ABMC
  x86/resctrl: Add the interface to assign/update counter assignment
  x86/resctrl: Add the interface to unassign a MBM counter
  x86/resctrl: Auto Assign/unassign counters when mbm_cntr_assign is
    enabled
  x86/resctrl: Report "Unassigned" for MBM events in mbm_cntr_assign
    mode
  x86/resctrl: Introduce the interface to switch between monitor modes
  x86/resctrl: Configure mbm_cntr_assign mode if supported
  x86/resctrl: Update assignments on event configuration changes
  x86/resctrl: Introduce interface to list assignment states of all the
    groups
  x86/resctrl: Introduce interface to modify assignment states of the
    groups

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/arch/x86/resctrl.rst            | 198 ++++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
 arch/x86/kernel/cpu/resctrl/core.c            |  19 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  13 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  77 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |  90 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 875 ++++++++++++++++--
 arch/x86/kernel/cpu/scattered.c               |   1 +
 include/linux/resctrl.h                       |  31 +-
 12 files changed, 1227 insertions(+), 85 deletions(-)

-- 
2.34.1


