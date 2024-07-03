Return-Path: <linux-kernel+bounces-240248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E0926AD5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F18228627F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31DA194A42;
	Wed,  3 Jul 2024 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5r7TPh99"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3789F1849CD;
	Wed,  3 Jul 2024 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043331; cv=fail; b=SAjaxMYPi+wBYjzhKOqs17c+jdPAQBKcCdZvsFg9PXcj8DGDTe1Ops4FApU2WvLYp64wCRpLSN6IdpzOAYcuftvDwe7Ld7cUXk1xukqA8vxT9j+A5NdSHg6aqmN6qe3Bkf90z1RnWXt3Svs3sYQfIGfzkq6MVTpD7S3BPULIjuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043331; c=relaxed/simple;
	bh=jd5wczooO6UYr8FiAz0vw2grdepf7GrUoflycCq50MY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n5zNp2k+eWdJHEvxAwvcP95BJ5EdWhHVbcV8EnR6VrWNl7tLFS/E5Q6qO6vSgN/esh+NOoiZ9IwzSPR/EmytmFNzAo4QHb3bXjFjpV3SQT28SCVxGMc9AG8UQEG2alZHaP0X/3IOrjWSn4ZS8s3am8CvKEWpGtv6SrqejZU0VyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5r7TPh99; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gyv1t+YvkTe9HuLVpdP1B7zPxDQteUN1TTy4RcEgHwQ3/8sQSM40QgK41oFoZZvqvs9HaODctl7DiQ1vnXniyCm5F1nWOyzY7KHXpMI7C1cbJpVNubkhzFwRYXNXGIhubI0xdyYZjEPKGUazYdZbqSuWQeMA46v6HYLl0Vr2qSyjZWwL84Jy6jpXhRLpWPptKsk4oTV4sWEEzpPpcehbUSv6YFU8nA6QcOIZBAXAZIqFtZEvk3y5KBWV1HuyivaXpms6v9r6UHSB1KYbdL0o9ZNuOfZh8ZENNyQXdjnO4vfhMggz+hzlj3DL1xpZeKMsy5Ah8Bj0I5wus573I1qnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srfVKCuHLKTpGZN5AcY6W8tEOfrBSdyWAxYCL8O4O4U=;
 b=iHZoDXte3kC590IIH+WHgUpUBq/oehrY9itlZ2R4Pp6apXfs3+LZYTMZJ/EqWfAulbkq+WaW9gr3aRxMp9pBa/IG9KLsZrTV6E03swqkOIE8CZyvCAoAsli1PCjBOH+alzEC2aL/xxI7XYmDFHttxRSUpGDquv7MVY/L4secoyojyEk4fQerJohb1d5n/6BCXpnrgvnFlQbEnjBYZ08gioW7SvXlr2xVF0cji6kO8cn6fE6Iu00lLDqBFUXKmgLXCEiLJG7xm86TcHh90O/GajG5xHlo/OHs0nJV34d7Kc7Fp1ArQY1aD5dOqXBHg+TKKo8xjjiIK38fJXGRmUzoHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srfVKCuHLKTpGZN5AcY6W8tEOfrBSdyWAxYCL8O4O4U=;
 b=5r7TPh99l1ItqRmfvg3baSrj0CVsPh+xzMwEZGZTuRfr2o02kqx3vVDBVc0UVOpoSFV/BET6HiPxZGODV80eaUNg87DMAYvzvLuTY4Y8MNwYn45DCXGMg82Y6V5OlGeY+nL5ILIXVv1Uj/N5lzcJ6FvMhagyNk/mbW5O1EZFoEA=
Received: from CH5P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::26)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 21:48:45 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::61) by CH5P221CA0019.outlook.office365.com
 (2603:10b6:610:1f2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26 via Frontend
 Transport; Wed, 3 Jul 2024 21:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:48:44 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:48:42 -0500
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
Subject: [PATCH v5 00/20] x86/resctrl : Support AMD Assignable Bandwidth Monitoring Counters (ABMC)
Date: Wed, 3 Jul 2024 16:48:11 -0500
Message-ID: <cover.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4da8ad-7915-49fe-8119-08dc9ba9e96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3QxeUdGZzlrZEhyZ2NpUkdYaWdVWWlxMXJhSzIwZWJKZWltVmJIYnB4dDEy?=
 =?utf-8?B?eHJOR3l0MW9pQ3hpelppK0k3OUMxS3FzUXIrU1BGRmsrTWk1b3lCSUMzRWFO?=
 =?utf-8?B?MVErUStIbFIxZE9ZSjVtWEF3cm5VdHBBNHJtclBwWWE4cVI0Qi9BUnppaS80?=
 =?utf-8?B?c24vcWNQRWVXVm9aRExpKzg2RW4yalNyM3JHMWhFbjdEbEI0TE55cTZEM213?=
 =?utf-8?B?NWtyM05MaUVjbk4rSzI5TXE5K3dFSzhkeWJvQ1B0N280ckFJdCtNRHVFSHU0?=
 =?utf-8?B?MHEzaDJYTUtCdStMZHF5R0tBVHVhOUh4eDBHUnNPQlZWZWJ2K2RkUWhQaVkx?=
 =?utf-8?B?UFh0M1ZTcmZBMHBwTExMajQ0ekNDWlFJSzZWUHZkcU1sSm43TlZWWGw4OEh1?=
 =?utf-8?B?V2Uydjd4U0U2YzJkNGtjelNoKzJ1TzA1UWZBelRaRm8xVHRIc2Vad3lQc3hK?=
 =?utf-8?B?aWxWQU1EeWVYKy8vR3MvS0NGenZjMDRDdTVmeTBYL1dpenFpb2xrUVR5OFhZ?=
 =?utf-8?B?VjZWNFNwVE5wNFM4azlOd2lVZnViR2tuaFRZQ0dBRlpNNzlYRjZQWHVxdVpP?=
 =?utf-8?B?SThmMG9LbXhHdkxFRjdOZFRIMGo2TUpWTk9FcUh3WERFbzdsUCthc3pITWpQ?=
 =?utf-8?B?TDZSbWdINmp3K21scnhqbVhLR3l6M0hHakRrVFJsUlRGeEkyS1pjYmJLUFd4?=
 =?utf-8?B?d2U1TnBzQmVsV0tiR1pKeWI5a3lLL1NQQ0E2Y2dONDRCbGhVQzBHdGE0K1Qx?=
 =?utf-8?B?Ri9rejlZUFR1bnQ2c2plYTFQQ0NVNGlYb3JsM29RcVBXdU1DZFpjd1FXY2VS?=
 =?utf-8?B?Q24rLzBSR2FlU0F2bms0OHRPT3NoYXZjT1RFOGl3M3ZOTnhXL3NPMzlxMEdt?=
 =?utf-8?B?Mzh6WWoxb3ovUjFLT1hzNCsyWVNFK1VPUEdTaFR2M0tXYlYrWnkyOTdVZlBF?=
 =?utf-8?B?MHVUWUVDYmMrZUdCUDV1aHZibXVrSUtZREFJSmVtUnF5N2lYYk80SmJMemNu?=
 =?utf-8?B?eE9HaFZlM3kwWU9LOFdUR0hFNC9EOFNzQkRicXg5MG9hcTFyanhIM2hUNHln?=
 =?utf-8?B?MC9xOFVKbVZnOVIxdjg0Nkp5ZlFqcE1NUXZvTDBlZWFwNDdKeWxyeVA2MFgy?=
 =?utf-8?B?YlU5Y0xBOHRlTEJrUmZvV3RJcEFSL09VYndBcWRCTnZSaEpHMzlHZC95MUhX?=
 =?utf-8?B?eTRXb3JwcnpoMW5MMmhxeWwvUW1XcEJicVJjTjJ1aWVXNXhoZWhGQmV2ZFNs?=
 =?utf-8?B?RTNabXlsalZ4d3ZCWloyNFBRREpsdzVGWXZZbTVuaHlUU3FSTDE4QVlKZlBw?=
 =?utf-8?B?c1lwaHo1Q2k1NXZSaCtiYVpjR1RJTWxBOVJaZGc0TnhhditvS3ovbzNMLzB5?=
 =?utf-8?B?MjNXVytoMitsRWRKU2Z6Y0lXaDlzdit5M3RDREZGZUJJb0hMS1JZSVZ5bzJB?=
 =?utf-8?B?ZkRNb2pML0JPeWhrbXZTSFlZbG1PM1FYcDZnWklRS2p1RGhIRHczSDVNZ1Jk?=
 =?utf-8?B?clBWVHB4bzlyTU1Va2ZYZk52NlNFS0t6ZnplV1pCbmlqT1FoY0VlYXhKc0No?=
 =?utf-8?B?b2FlUndSYnVJN3ZQZ0dvUTJ1MTNHZ1cvOFdqckVRT0lkNUxoMGZndUtyY0pl?=
 =?utf-8?B?cnJldWNHZnNmNW1JeVpDdWM0L0U2UThZaWx6S2hKWGlMcEMrS2FScjBKTnNp?=
 =?utf-8?B?UDY1RHFFNVgwUDBMSlkyaDIrWXpHL0NvNjRjNGRISnZpdHZXdjNzRzJFaXZL?=
 =?utf-8?B?dHVRUTN0Ym5Iam9VUXM4SnoxMnA5blhMNExnNUxVcnAwSTdKVzl1My8xamQv?=
 =?utf-8?B?NVRjNFBuT0cxU3JnQUhUQnJZV25kSE01Y2tVVjNHUFJKSzhhQ2RGNFBGTG9V?=
 =?utf-8?B?dXFrTkFNTGpENjFXYzdHN2VMb0hlMHpkTXJBbmVodlc5K2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:48:44.6851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4da8ad-7915-49fe-8119-08dc9ba9e96f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983


This series adds the support for Assignable Bandwidth Monitoring Counters
(ABMC). It is also called QoS RMID Pinning feature

The feature details are documented in the  APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC). The documentation is available at
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

The patches are based on top of commit
commit fbfd4bcefc65 ("Merge branch into tip/master: 'x86/vmware'").
whic includes Tony's SNC support.

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

	#cat /sys/fs/resctrl/info/L3_MON/mbm_mode
	[abmc] 
	legacy

	Linux kernel detected ABMC feature and it is enabled.

b. Check how many ABMC counters are available. 

	#cat /sys/fs/resctrl/info/L3_MON/num_cntrs 
	32

c. Create few resctrl groups.

	# mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp


d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_control
   to list and modify the group's monitoring states. File provides single place
   to list monitoring states of all the resctrl groups. It makes it easier for
   user space to learn about the counters are used without needing to traverse
   all the groups thus reducing the number of filesystem calls.

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

	# cat /sys/fs/resctrl/info/L3_MON/mbm_control 
	non_default_ctrl_mon_grp//0=tl;1=tl;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
	//0=tl;1=tl;
	/child_default_mon_grp/0=tl;1=tl;
	
	There are four groups and all the groups have local and total
	event enabled on domain 0 and 1.

	=tl means both total and local events are enabled.

	"//" - This is a default CTRL_MON group

	"non_default_ctrl_mon_grp//" - This is non-default CTRL_MON group

	"/child_default_mon_grp/"  - This is Child MON group of the defult group

	"non_default_ctrl_mon_grp/child_non_default_mon_grp/" - This is child
	MON group of the non-default group

e. Update the group assignment states using the interface file /sys/fs/resctrl/info/L3_MON/mbm_control.

	The write format is similar to the above list format with addition of
	op-code for the assignment operation.
	
	* Default CTRL_MON group:
	        "//<domain_id><op-code><flags>"
	
	* Non-default CTRL_MON group:
	        "<CTRL_MON group>//<domain_id><op-code><flags>"
	
	* Child MON group of default CTRL_MON group:
	        "/<MON group>/<domain_id><op-code><flags>"
	
	* Child MON group of non-default CTRL_MON group:
	        "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"
	
	Op-code can be one of the following:
	
	= Update the assignment to match the flag.
	+ Assign a new state.
	- Unassign a new state.

	Flags can be one of the following:

        t  MBM total event.
        l  MBM local event.
        tl Both total and local MBM events.
        _  None of the MBM events. Only works with '=' op-code.
	
	Initial group status:
	# cat /sys/fs/resctrl/info/L3_MON/mbm_control
	non_default_ctrl_mon_grp//0=tl;1=tl;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
	//0=tl;1=tl;
	/child_default_mon_grp/0=tl;1=tl;

	To update the default group to enable only total event on domain 0:
	# echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_control

	Assignment status after the update:
	# cat /sys/fs/resctrl/info/L3_MON/mbm_control
	non_default_ctrl_mon_grp//0=tl;1=tl;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
	//0=t;1=tl;
	/child_default_mon_grp/0=tl;1=tl;

	To update the MON group child_default_mon_grp to remove total event on domain 1:
	# echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control

	Assignment status after the update:
	$ cat /sys/fs/resctrl/info/L3_MON/mbm_control
	non_default_ctrl_mon_grp//0=tl;1=tl;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
	//0=t;1=tl;
	/child_default_mon_grp/0=tl;1=l;

	To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
	remove both local and total events on domain 1:
	# echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
	       /sys/fs/resctrl/info/L3_MON/mbm_control

	Assignment status after the update:
	non_default_ctrl_mon_grp//0=tl;1=tl;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
	//0=t;1=tl;
	/child_default_mon_grp/0=tl;1=l;

	To update the default group to add a local event domain 0.
	# echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_control

	Assignment status after the update:
	# cat /sys/fs/resctrl/info/L3_MON/mbm_control
	non_default_ctrl_mon_grp//0=tl;1=tl;
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
	
g. Users will have the option to go back to legacy mbm_mode if required.
   This can be done using the following command. Note that switching the
   mbm_mode will reset all the mbm counters of all resctrl groups.

	# echo "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
	# cat /sys/fs/resctrl/info/L3_MON/mbm_mode
	abmc
	[legacy]

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
	
k. Now read the total event again. The first read will come back with "Unavailable"
   status. The subsequent read of mbm_total_bytes will display only the read events.
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	Unavailable
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	314101
	
l. Unmount the resctrl
	 
	#umount /sys/fs/resctrl/

---
v5:
  Rebase changes (because of SNC support)

  Interface changes.
   /sys/fs/resctrl/mbm_assign to /sys/fs/resctrl/mbm_mode.
   /sys/fs/resctrl/mbm_assign_control to /sys/fs/resctrl/mbm_control.

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

v4:
  https://lore.kernel.org/lkml/cover.1716552602.git.babu.moger@amd.com/

v3:
 https://lore.kernel.org/lkml/cover.1711674410.git.babu.moger@amd.com/  

v2:
  https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/

v1 :
   https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/



Babu Moger (20):
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
  x86/resctrl: Initialize monitor counters bitmap
  x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
  x86/resctrl: Remove MSR reading of event configuration value
  x86/resctrl: Add data structures and definitions for ABMC assignment
  x86/resctrl: Add the interface to assign hardware counter
  x86/resctrl: Add the interface to unassign hardware counter
  x86/resctrl: Assign/unassign counters by default when ABMC is enabled
  x86/resctrl: Report "Unassigned" for MBM events in ABMC mode
  x86/resctrl: Introduce the interface switch between monitor modes
  x86/resctrl: Enable AMD ABMC feature by default when supported
  x86/resctrl: Introduce interface to list monitor states of all the
    groups
  x86/resctrl: Introduce interface to modify assignment states of the
    groups

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/arch/x86/resctrl.rst            | 181 ++++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   3 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
 arch/x86/kernel/cpu/resctrl/core.c            |  12 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  19 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  69 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |  63 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 930 ++++++++++++++++--
 arch/x86/kernel/cpu/scattered.c               |   1 +
 include/linux/resctrl.h                       |  21 +-
 12 files changed, 1218 insertions(+), 87 deletions(-)

-- 
2.34.1


