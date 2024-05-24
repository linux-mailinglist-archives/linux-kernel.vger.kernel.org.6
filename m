Return-Path: <linux-kernel+bounces-188668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972058CE52B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17AF1C216AE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334F68626A;
	Fri, 24 May 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FYgrdb/4"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B582D83;
	Fri, 24 May 2024 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553436; cv=fail; b=dN9cf3jl9lb6uT+4iKdF4ugEe41j5Vlu6lHCyXO71dVKGJtyFJ8gsx+Zf1/Qdc2wFCw3OQbBS5VDimZn2cYyH+OxTHFAgf+eW+ffbb8vviWPcFsPxUwH0h5bc9WTZ847FU6aA/Ffxmwi/R7hvRHJ01bVpGgg80X8Sx+ShetYQY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553436; c=relaxed/simple;
	bh=QEDymciQwxHTwfFC8LLr+GgDkGY1ah85S+QmH2wozkI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IZUbjXz6DrqTAWJ6rXMowvmd83ig3nSmz0RUHNTO8OlewqjACQM1IlH+Zbp1qAjAKoxjOCWhF2/jyhQJQsjtTNEsuVeiLSMa//evijfLbg9wUYj2s6xzovm6yQffH9zVtvNp3E2PFbwedzC5S6AwZoUEEkJwlzwaVYr8gL2Wjvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FYgrdb/4; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF+zMv00iN6tBe+OWDHE12HeeDqiyWGqotLmhCrJkEtHiAE3Xb/v3X7ritjW8BBMgfKdThN57njSoxzl97qvWECB8i6JeypGTdvG34NhxVIhRJdJHtE1f5ilP/bq/g1DLtnT+wxzaV0YFkQqCY+kVseCpZNZXK/tWeZ4Ms9iNU8vtWLelXnu90fq1T0jyGvC8CUT1MYEoM20laxFFeQgB3/jgW8/ZumlVOk2QNLkeVQa5AyU+z3TOTJtM0Eg2ejlvmNjnrzhPXL2vXFeMw1e1ri8hu8nOf5DkNA2sO0yMLJMj6fnPpNxn0fck1TDDgjZo9w+SXEgl+sMdAs6g3uNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMqscZO99aoX1W0FND8HHQGKhpNorzYyNtclohOrkzI=;
 b=QLI6VU6o464iV5JtnBR6jOLRzvs/i7im3og8Bi3rm9/4CoAhpjsyz3ioEEjtEvuGEIeYqAt5cUu3GPMdajNN9sSJSFegTfnLYmSsSvdAjcnXj7CtpNwE8wsRLRgEduuZR8EwWxBv8iBZWJekPY6jgItyw5tOnNnAQF9RHVJEOe9L9/cbdOvaKpNG9zSEmtbQ5QsP+ZJ5RsBvOJMLkYzlxG6pVVmpWaZwrfGCdTMhLit2rOxQJwotOMnZSeyE2QwSA2JdcgoF9PQ0dnHXng3Qe0CoxzfMpa2B9Av81kgnGtwutL2uMhTyudsI0Ziq9rpeGPS6dqsLfYZAXDBhL3bt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMqscZO99aoX1W0FND8HHQGKhpNorzYyNtclohOrkzI=;
 b=FYgrdb/4bX4Dus1M+825Zse3FIqxDATkWll1XXWmTqrtFEqaq6cfIgXhx6UG8h3dQer9/N5RySuCkVsa2XO07WrI5xWWFOy+tmEQH6RQDBrDTDCJ31xFGHu9GPbuXhhbHGyMIPzKDeoUrUsCUDpTf2gHR9+cXlURsI8yt0ewCj8=
Received: from MW4PR03CA0078.namprd03.prod.outlook.com (2603:10b6:303:b6::23)
 by DS0PR12MB6653.namprd12.prod.outlook.com (2603:10b6:8:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 12:23:50 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::84) by MW4PR03CA0078.outlook.office365.com
 (2603:10b6:303:b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.21 via Frontend
 Transport; Fri, 24 May 2024 12:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:23:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:23:46 -0500
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
Subject: [PATCH v4 00/19] x86/resctrl : Support AMD Assignable Bandwidth Monitoring Counters (ABMC)
Date: Fri, 24 May 2024 07:23:19 -0500
Message-ID: <cover.1716552602.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS0PR12MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ba03f1-d8f3-4b73-872f-08dc7bec5d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVBtaFUrcGRYTGtWUks4RTR6NDhaMnQ5TVRKZXlaK3VhS2RDYVB0NXd5STRN?=
 =?utf-8?B?cVN6Rk9jbVRFU1BlaXVFTXFXaHZ1QXBlUVZSZkJnSVR4WGVjWU1yb2pHU1Jz?=
 =?utf-8?B?cGErMWJGcHlCM1ZOOHBwZ2hPb1p4TVBLV3dVQnZlWnY2VTNsTXluL2t5M1Yw?=
 =?utf-8?B?bkZpNkgrMEIycG9ublJtMWpjM21WcWxSVFdoQ214eVBjLzhtT25sRTNMKzhu?=
 =?utf-8?B?aGZybEdzNjRaWEtEdEFvanB2UGh3KzdHc0dCdVRLaXRJUStiSDBZRFBkRFZ5?=
 =?utf-8?B?NEcxTEk4RkNaNDJEcVRyYnBzRHNFYWdHdlhUeWNUOHZnQ3V5TExMdFllVzBM?=
 =?utf-8?B?N2xxUkZtWGN1c0VkdG05UnQ4QmFxQmdpM3ViZzBmWldZUGQwdDJpQXRCemxu?=
 =?utf-8?B?Tk9vekxLcGNTRzNBb2IwYUV5SlRlVVdZOUhHV01XamxiYTlnUVQ2ZFExNVZn?=
 =?utf-8?B?ZjhjUnA5czMxbjFpY3MxcUd5WlNTOG5zUzRSWjJ3eHBSUXV4QXF3YmhGSzQw?=
 =?utf-8?B?SU93Y1ZmMHE1dlIvUXg4K0ZrMktUZ2R4ei84Q1VpRHM2OG53S2UwYWlvbVRS?=
 =?utf-8?B?Q05PQUxsRVpwdERFQUYrbnZzanBtRWxwWU4yS3RVZHRyZ2xnaGx5alB0dVI5?=
 =?utf-8?B?dzBmM3M5SEU4Y2VOV3dVcFNFWUc2cndGWHYwMlJzWWRtUTdZa2dMS2YzUFI2?=
 =?utf-8?B?RDJ4TndnV1pNQm92T1pGY2xyM0pBdzR3MzRYQkNFQVJkTlVjQk1mVTJBMmxF?=
 =?utf-8?B?OFFpMU8xWEVwckxlald3TW1adi80bFQ4T1lmS2x1TjJ6OEtuNTkvSCtFNndv?=
 =?utf-8?B?dnp2cWswQUY3NTlLOFNSbXYzZE9BVllzQ3VEOEthRUpaZUVLbkhrK1Q5UlRR?=
 =?utf-8?B?SVI2UElXU2JNazFjdkpPLzIyRnNCSkZ0eWdhVW8wWk56SDNCZ1p2NjRpUm5a?=
 =?utf-8?B?blBlZG8waWFIRlBqQWNCMVUwa1B2N1V5MFZuRDhuQ1IrL3NsT3ViOXVubU00?=
 =?utf-8?B?MjNMb1dVSitrVUJIeDh4VjNMYTRDTkJPSW9waUs4TitibnJZWHBWQmVQUGl1?=
 =?utf-8?B?TjQrZ0VXNGdDaDNtVWNqMHoybEFRMXZRYURHL0I3YzBHdUdpRWhqYVc5WWVW?=
 =?utf-8?B?T0JwajFtcXNqbHNiS3RVVVNISVFycWZybFZlRGhzY0ZLNzVKQzNVV3dJUDk2?=
 =?utf-8?B?b1h2UDdRb3VpdExDY1AxRUs2NUlYbDFsTG1zKy9wcGI4RjVaWmJPaDNnVEc1?=
 =?utf-8?B?N1kvS0NiZEtLY3dpQkcyN3U3ZWdwamRQQzkydUNiNFpXZjA0U04xajdrMU1m?=
 =?utf-8?B?NmlwMVY3KzJXUmZ5RkNPc1FKUW90NjRQenZoL2V1aTFjRENMV0UwNG84cHll?=
 =?utf-8?B?cEhTOW9WVzVSbEo4VkR4aGhVYWVZOE9XN0sxSURLSVg2YWdZWlI1a2NxS2Zj?=
 =?utf-8?B?cXhqcVRScDc0WnZoSXFKOFVYeGxGUjcxeVduL1RPUEszZExIY1FZcnlnMFhi?=
 =?utf-8?B?K2pWY2UrTHdRNVNuT2p5dVg5UWszYnZDMHg2dGs4SXd5UUhreTBzZHlpalAx?=
 =?utf-8?B?bGR1dTBGUzhaalZjaTkyLzhvNVhhS0FKeTJmVVJWcEl3QVpsWjVRMHlNbGRL?=
 =?utf-8?B?RGl1VUVqcE9kWlpiZm1oSFFDT3dvS1FMZVdCL0locTN1SkQvZFFidGpQZ0Vk?=
 =?utf-8?B?eEpJa01jZVNoZjIxTUhSd2t0Y2JjVDhDYUp4akNoUlJ0dTJJR0w4TkpIeGVY?=
 =?utf-8?B?V29oU2Nray9EakcwVnVib3VEc25KcmRnS2JXZGtzRmVhcXhnL0dYQ1dpQmM2?=
 =?utf-8?B?WGVLei9EL2k4Y0crTUd2QT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:23:48.7023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ba03f1-d8f3-4b73-872f-08dc7bec5d5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6653


This series adds the support for Assignable Bandwidth Monitoring Counters
(ABMC). It is also called QoS RMID Pinning feature

The feature details are documented in the  APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC). The documentation is available at
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

The patches are based on top of commit
commit 573c35550b2b ("Merge branch into tip/master: 'x86/percpu'")

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

Linux resctrl subsystem provides the interface to count maximum of two
memory bandwidth events per group, from a combination of available total
and local events. Keeping the current interface, users can enable a maximum
of 2 ABMC counters per group. User will also have the option to enable only
one counter to the group. If the system runs out of assignable ABMC
counters, kernel will display an error. Users need to disable an already
enabled counter to make space for new assignments.


# Examples

a. Check if ABMC support is available
	#mount -t resctrl resctrl /sys/fs/resctrl/

	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign
	[abmc] 
	mbm_legacy

	Linux kernel detected ABMC feature and it is enabled.

b. Check how many ABMC counters are available. 

	#cat /sys/fs/resctrl/info/L3_MON/num_cntrs 
	32

c. Create few resctrl groups.

	# mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp


d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
   to list and modify the group's assignment states.

	The list follows the following format:

	"<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"


	Format for specific type of groups:

	* Default CTRL_MON group:
	 "//<domain_id>=<assignment_flags>"

       * Non-default CTRL_MON group:
               "<CTRL_MON group>//<domain_id>=<assignment_flags>"

       * Child MON group of default CTRL_MON group:
               "/<MON group>/<domain_id>=<assignment_flags>"

       * Child MON group of non-default CTRL_MON group:
               "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"

       Assignment flags can be one of the following:

        t  MBM total event is enabled
        l  MBM local event is enabled
        tl Both total and local MBM events are enabled
        _  None of the MBM events are enabled

	Examples:

	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control 
	non_default_ctrl_mon_grp//0=tl;1=tl;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
	//0=tl;1=tl;
	/child_default_mon_grp/0=tl;1=tl;

	There are four groups and all the groups have local and total
	event enabled on domain 0 and 1.

	=tl means both total and local events are enabled.

	"//" - This is a default CONTROL MON group

	"non_default_ctrl_mon_grp//" - This is non default CONTROL MON group

	"/child_default_mon_grp/"  - This is Child MON group of the defult group

	"non_default_ctrl_mon_grp/child_non_default_mon_grp/" - This is child
	MON group of the non default group

e. Update the group assignment states using the interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control.

	The write format is similar to the above list format with addition of
	op-code for the assignment operation.
	
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
	+ Assign a new state
	- Unassign a new state
	
	
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
	 //0=t;1=l;
	 /child_default_mon_grp/0=t;1=tl;
	
	 To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
	 remove both local and total events on domain 1:
	 # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
	               /sys/fs/resctrl/info/L3_MON/mbm_assign_control
	
	 Assignment status after the update:
	 # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
	 non_default_ctrl_mon_grp//0=tl;1=tl;
	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
	 //0=t;1=l;
	 /child_default_mon_grp/0=t;1=tl;
	
	 To update the default group to add a total event domain 1.
	 # echo "//1+t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
	
	 Assignment status after the update:
	
	 # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
	 non_default_ctrl_mon_grp//0=tl;1=tl;
	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
	 //0=t;1=tl;
	 /child_default_mon_grp/0=t;1=tl;
	
f. Read the event mbm_total_bytes and mbm_local_bytes of the default group.
   There is no change in reading the evetns with ABMC. If the event is unassigned
   when reading, then the read will come back as Unavailable.
	
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	779247936
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
	765207488
	
g. Users will have the option to go back to legacy_mbm mode if required.
   This can be done using the following command.

	# echo "legacy_mbm" > /sys/fs/resctrl/info/L3_MON/mbm_assign
	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign
        abmc
        [mbm_legacy]

h. Check the bandwidth configuration for the group. Note that bandwidth
   configuration has a domain scope. Total event defaults to 0x7F (to
   count all the events) and local event defaults to 0x15 (to count all
   the local numa events). The event bitmap decoding is available at
   https://www.kernel.org/doc/Documentation/x86/resctrl.rst
   in section "mbm_total_bytes_config", "mbm_local_bytes_config":
	
	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	0=0x7f;1=0x7f
	
	#cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config 
	0=0x15;1=0x15
	
j. Change the bandwidth source for domain 0 for the total event to count only reads.
   Note that this change effects total events on the domain 0.
	
	#echo 0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	0=0x33;1=0x7F
	
k. Now read the total event again. The mbm_total_bytes should display
   only the read events.
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	314101
	
l. Unmount the resctrl
	 
	#umount /sys/fs/resctrl/

---
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

v4:
  https://lore.kernel.org/lkml/cover.1711674410.git.babu.moger@amd.com/

v2:
  https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/

v1 :
   https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/


Babu Moger (17):
  x86/resctrl: Add support for Assignable Bandwidth Monitoring Counters
    (ABMC)
  x86/resctrl: Add ABMC feature in the command line options
  x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
  x86/resctrl: Introduce resctrl_file_fflags_init
  x86/resctrl: Introduce the interface to display the assignment state
  x86/resctrl: Introduce interface to display number of ABMC counters
  x86/resctrl: Add support to enable/disable ABMC feature
  x86/resctrl: Initialize assignable counters bitmap
  x86/resctrl: Introduce assign state for the mon group
  x86/resctrl: Add data structures for ABMC assignment
  x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
  x86/resctrl: Add the functionality to assign the RMID
  x86/resctrl: Add the functionality to unassign the RMID
  x86/resctrl: Enable ABMC by default on resctrl mount
  x86/resctrl: Introduce the interface switch between ABMC and
    legacy_mbm
  x86/resctrl: Introduce interface to list assignment states of all the
    groups
  x86/resctrl: Introduce interface to modify assignment states of the
    groups

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/arch/x86/resctrl.rst            | 144 ++++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
 arch/x86/kernel/cpu/resctrl/core.c            |  25 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  56 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |  24 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 714 +++++++++++++++++-
 arch/x86/kernel/cpu/scattered.c               |   1 +
 include/linux/resctrl.h                       |  12 +
 11 files changed, 964 insertions(+), 20 deletions(-)

-- 
2.34.1


Babu Moger (17):
  x86/resctrl: Add support for Assignable Bandwidth Monitoring Counters
    (ABMC)
  x86/resctrl: Add ABMC feature in the command line options
  x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
  x86/resctrl: Introduce resctrl_file_fflags_init
  x86/resctrl: Introduce the interface to display the assignment state
  x86/resctrl: Introduce interface to display number of ABMC counters
  x86/resctrl: Add support to enable/disable ABMC feature
  x86/resctrl: Initialize assignable counters bitmap
  x86/resctrl: Introduce assign state for the mon group
  x86/resctrl: Add data structures for ABMC assignment
  x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
  x86/resctrl: Add the functionality to assign the RMID
  x86/resctrl: Add the functionality to unassign the RMID
  x86/resctrl: Enable ABMC by default on resctrl mount
  x86/resctrl: Introduce the interface switch between ABMC and
    legacy_mbm
  x86/resctrl: Introduce interface to list assignment states of all the
    groups
  x86/resctrl: Introduce interface to modify assignment states of the
    groups

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/arch/x86/resctrl.rst            | 144 ++++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
 arch/x86/kernel/cpu/resctrl/core.c            |  25 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  56 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |  24 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 714 +++++++++++++++++-
 arch/x86/kernel/cpu/scattered.c               |   1 +
 include/linux/resctrl.h                       |  12 +
 11 files changed, 964 insertions(+), 20 deletions(-)

-- 
2.34.1



Babu Moger (19):
  x86/resctrl: Add support for Assignable Bandwidth Monitoring Counters
    (ABMC)
  x86/resctrl: Add ABMC feature in the command line options
  x86/resctrl: Consolidate monitoring related data from rdt_resource
  x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
  x86/resctrl: Introduce resctrl_file_fflags_init to initialize fflags
  x86/resctrl: Introduce interface to display number of ABMC counters
  x86/resctrl: Add support to enable/disable ABMC feature
  x86/resctrl: Introduce the interface to display monitor mode
  x86/resctrl: Initialize ABMC counters bitmap
  x86/resctrl: Introduce ABMC state for the monitor group
  x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
  x86/resctrl: Remove MSR reading of event configuration value
  x86/resctrl: Add data structures for ABMC assignment
  x86/resctrl: Add the interface to assign ABMC counter
  x86/resctrl: Add the interface to unassign ABMC counter
  x86/resctrl: Enable ABMC by default on resctrl mount
  x86/resctrl: Introduce the interface switch between ABMC and
    mbm_legacy
  x86/resctrl: Introduce interface to list monitor states of all the
    groups
  x86/resctrl: Introduce interface to modify assignment states of the
    groups

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/arch/x86/resctrl.rst            | 161 ++++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   3 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
 arch/x86/kernel/cpu/resctrl/core.c            |  10 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  61 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |  60 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 830 +++++++++++++++++-
 arch/x86/kernel/cpu/scattered.c               |   1 +
 include/linux/resctrl.h                       |  20 +-
 11 files changed, 1086 insertions(+), 66 deletions(-)

-- 
2.34.1


