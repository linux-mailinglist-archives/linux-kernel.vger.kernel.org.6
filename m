Return-Path: <linux-kernel+bounces-387828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4A39B56A7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA001C20F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F21D20BB5B;
	Tue, 29 Oct 2024 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MmzmWiNk"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE120492B;
	Tue, 29 Oct 2024 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244147; cv=fail; b=sSSCDCZHm471ye2BTUQriUOiFDukkyD+CXYtHluaOuI7qDjxCy6OXOQzT/VKqSKaB4aE/gPtXC2XmqW8Ij4bAlH47ZeDiUhOSJA3Z6iOTGnhs2CO7nM1G+xI4UxqYOKa93NElHiLV9uUbwMzw7KeY0grJ8zjE5OJzl1TwHX6Qpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244147; c=relaxed/simple;
	bh=9hNSyLRaQsaRX425nC0J+Iim8hvwJBdLJnriH5pVL08=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DDouVHUFksYXHDGbyut33ALTtxDJWzugK+PGdZq1OuqacWjeVVhKJVS4FJkfkPQSPMDvuGCQGH8FtZQtulMIt08QTD3onwxFgn46uq/4389J96lKs4XsPDPfR8p1QeyYq7SR85eK8cgTEHhXyOirgXpJpa9PB+ahto9lfW84HTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MmzmWiNk; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vh3xTG2t5N1FqmW4CVx5njjQi8EMr785540jcRX3xPpUa52+WPN3FDg9+FRZvhndQPDD66b2NYx9YWa7ZPooDRV5bFTrSSoqxUA4LUikkBMIDQffWF8cq1owl3fqGeS721dBEtnujHApaBOw7tMiZxBCaykCZf6nt3PzbOJwaEWxYZXFE2f7qtIowJ2QrYEl+lB9W+WddYzif2SKqhG6metGRogFycE5Jv+rBV2VCfXib9Pxenz6OQOqIcjFdbmN8otbweJIkSgrgpGxd+hr57EmkNeK6sQZhO7vbcf23K6DuhPZ8qS5xyMyhQHTFLsnI6dhI784p3sy+zzXZhAucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0q1ENmoEYbfDBCB+rWPNBFADMRFQ+6qBvwxM9WY+cM=;
 b=BjGJHtoE7XzmpJI32CNxHLmQ5PUCdrhEItlqknwwteOUEJXSdgoj+d+u7Kv7xZOiJTaWA/W/RuOgzCOEvdY/SJUQf7mdQwFTepBo6ozZJQb/UYKgiTNdtUd7sAIfstSaVjQDNBhlMtmlKJF2uMJ+cOT6QWQVbGv8r78YrUi2anittsGxBBKuNpVSGI3BAn1ZP6A+wLxBcJww2hdb8kaa7RbJv+BzTG7Ir3tW7MgBnrHrNBIgOpc99v651Kcj2QhUprmogvKflkh1998BStcJQE8HHr/kuqXuzeAn98jeI20R+o/jaa19wDtxLrIQgSdunlpF8FxvhHvUBZ6Tdj/xKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0q1ENmoEYbfDBCB+rWPNBFADMRFQ+6qBvwxM9WY+cM=;
 b=MmzmWiNkh32fCFSIAYM/U77ulVjbNUYSUKAGlICDVhnjQvbi+M6mBt/QrOgWLVV3mG4N+aL5wFs+NliGw3zTSoRCHaUCogdOwUNYODmsOLSkb+DpWgQSYofx4Z6tKr0fK88srWUebeiUBxVlcTWc3LB45BjYIrqeWVMnNzyXlmU=
Received: from CY5PR15CA0057.namprd15.prod.outlook.com (2603:10b6:930:1b::32)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Tue, 29 Oct
 2024 23:22:20 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:1b:cafe::5e) by CY5PR15CA0057.outlook.office365.com
 (2603:10b6:930:1b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 23:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:22:18 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:22:09 -0500
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
Subject: [PATCH v9 00/26] x86/resctrl : Support AMD Assignable Bandwidth Monitoring Counters (ABMC)
Date: Tue, 29 Oct 2024 18:21:32 -0500
Message-ID: <cover.1730244116.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a55b49d-32c0-4856-491d-08dcf8708895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3JiUGQxb1ROcGVYWlhCQ1ZadENxUFFTS2dySy9kY3pIc2RmSFFySFA5Y1o4?=
 =?utf-8?B?NEN1b3hsVSs3d0t6eVJYbnpSVEdSSmhMOW4zdWFVSGkxbml1UVNaeHlGMzlO?=
 =?utf-8?B?c0Z4Q2VmSGR5c0JHRXgzYzZIL0hnTUg1UDFheXBBMTFVMXJabC80MkNpQVNw?=
 =?utf-8?B?bkhSeTU0d3JXZU9CdjhzTDlBUXBLZStpbHY5VTNUcldUckhNZmxaMDIxMTBo?=
 =?utf-8?B?SGpqL3pVRkdyRzB3UldzTEsvMEQ2bk1nQkZoeFZ1VHhFSE9sRFhrQk5KSUhE?=
 =?utf-8?B?QlI2Umx4Y2RFdzE3amxYbjRRb0U0bXVTb2JudjY5QVZ2SkZvdDc3MFNBd00v?=
 =?utf-8?B?Q2Z6Y3VEWVZLMnB3Q1RZMmpNbXpJTTlmUlV4RlZtUElGc3lrcUROVjNvaElu?=
 =?utf-8?B?dmd2K0Q4azF5ZlBVRzZJbVYzRTdsZ0NjRmErTzFKY1pxQ0Jva2o2RHV5SkQx?=
 =?utf-8?B?a2RPWEZsVjU3U2puWnhSRUJ5N29JUHA3bjdocEhuSHJUT3QvVDVZV3BIOEpU?=
 =?utf-8?B?MUhwbXlXazJIRzdxRnRDMjlLWGtOR1dPMUNMUEorWDA1akVIQ05QcnZ5YVhv?=
 =?utf-8?B?NUtPL1ljdjkySzUrRkp2dnpzaTZlTEw0ZXdXTXNVWHFWUDZoOUtOVEhrYUMx?=
 =?utf-8?B?dlpMVktIdlVEOGhiYU9KVERQMzFEcGh2Szk1VDNqNkNITEQvN2F6bGZFNmNI?=
 =?utf-8?B?dWk5eWtvMjZWTzZ3dlp6TFZGYXJHM2ZTZlFiamVneFZZMEhZTmJPS3JneHha?=
 =?utf-8?B?OEZyT1VRaHRoMTZUZ1JPOEpwMlZUZHpUYjg0RzRKd1JodXJRaEk5K2hCSUxi?=
 =?utf-8?B?SU45NXliSEZmOU83UTdYb09pc3ZPVS9ISDBtL0VmeGpuSER5QkNlZ0FkM3Zq?=
 =?utf-8?B?b1BRYU1pV2tFTjJhQ1gzZVVLNy83cXhncXZucE9UTVNiOFNDMVdxdzdPaTli?=
 =?utf-8?B?SEVxZm03b1lEWnJ1U09ycUdMalN2VkxzNkJZZkhERzluTHJETzlKUzUrS1JE?=
 =?utf-8?B?SnFyejBaQ2tHL3hlZWt3MEdYQnkvUFJQbnk0QU5KbXcxV2tERDdIUHU3b01T?=
 =?utf-8?B?TGZQczdqZStEWUcyYjdzd0EzN3M2OWZFYng5T0paME5pN1ZVUVMwazh1RjVO?=
 =?utf-8?B?MnhKRUpFN05jZ2hvYTYyYzE3elN0a3U0TjlTczZhVGtPRS84UnE3U2k4cTJE?=
 =?utf-8?B?ckFWTEdoaFF6eFNoL01LdjMwa09hZ3JEWUlNQys1VUVzdW01WmlOTjZuYWlU?=
 =?utf-8?B?V3Q1bFdKR1ZFZnl2aEZVMDJvTWM3OGhFWnZFYUxFWlN4VEhrVjJFQ3JIWTJT?=
 =?utf-8?B?Vlg4V3VYazFRRlJWczZreE9UOTVac0tuWmdySmttbWFHZXNBRDVUb25hUHQr?=
 =?utf-8?B?c2MrWTgvbDFOMk80eGVIQVhmWnBDKzUydVl1K25FdmZTcE4remd5ajFXajlD?=
 =?utf-8?B?L3dyTk9DaGxjSndJNWY3bXN6aTZxc0ZZQlJsaWN1WjJabFZaWG1OcnkrcjNP?=
 =?utf-8?B?Zk1xai9vNTdZNE10ZTBsUGZoTlFSc0pGdDhoUGYwSnB3eHgvNGlGU0hxM09G?=
 =?utf-8?B?UFJQK21sZS9uY1dWSk1jSWhlVGJqUDVtSVpab25Hc3VUM1lXRWhPUVZRVUU1?=
 =?utf-8?B?TFJLWFEyYitIaDQySUVNV0tjTjlOeS82QjNiU1lHc2hhTWJNUkxwbEhYdHJQ?=
 =?utf-8?B?enJWb1BWYW01MFBtTHR3SU1VUXpWZGpZc2JVUWg0S0I0eXFtcjBhMnhkb0FZ?=
 =?utf-8?B?Z2RianlldStzZjVpR3huYmxxSm1kSUJGLzZMU1pDd1hlcENtY3Z5WURIRnN2?=
 =?utf-8?B?OWpZQUl1M0Q1WVhZYk40VnN3MU9kdjBsL0g0UjQzSk4vRlF6YWloRXBmN00x?=
 =?utf-8?B?ZVQwaW1DbkpBZ3NDOWVnakFuTzFvOGFwNFYwQ29qbzNGUXh4SXBJcmdkVjZz?=
 =?utf-8?Q?83+IhOcqBV4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:22:18.9559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a55b49d-32c0-4856-491d-08dcf8708895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082


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
da99b80a7f5f1 (tip/master) Merge branch into tip/master: 'x86/sev'

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
worrying about counter being reset in between.
    
The ABMC feature provides an option to the user to assign a hardware
counter to an RMID, event pair and monitor the bandwidth as long as it is
assigned.  The assigned RMID will be tracked by the hardware until the user
unassigns it manually. There is no need to worry about counters being reset
during this period. Additionally, the user can specify a bitmask identifying
the specific bandwidth types from the given source to track with the counter.

Without ABMC enabled, monitoring will work in current 'default' mode without
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

/sys/fs/resctrl/info/L3_MON/available_mbm_cntrs: Reports the number of monitoring
counters free in each domain.

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
   to list and modify any group's monitoring states. File provides single place
   to list monitoring states of all the resctrl groups. It makes it easier for
   user space to learn about the used counters without needing to traverse all
   the groups thus reducing the number of file system calls.

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
        _  None of the MBM events. Only works with '=' opcode. This flag cannot be combined with other flags.
	
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
	$ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
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
v9:
   Patch 14 is a new addition. 
   Major change in patch 24.
   Moved the fix patch to address __init attribute to begining of the series.
   Fixed all the call sequences. Added additional Fixed tags.

   Added Reviewed-by where applicable.

   Took care of couple of minor merge conflicts with latest code.
   Re-ordered the MSR in couple of instances.
   Added available_mbm_cntrs (patch 14) to print the number of counter in a domain.

   Used MBM_EVENT_ARRAY_INDEX macro to get the event index.
   Introduced rdtgroup_cntr_id_init() to initialize the cntr_id

   Introduced new function resctrl_config_cntr to assign the counter, update
   the bitmap and reset the architectural state.
   Taken care of error handling(freeing the counter) when assignment fails.
  
   Changed rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() to return void.
   Updated couple of rdtgroup_unassign_cntrs() calls properly.

   Fixed problem changing the mode to mbm_cntr_assign mode when it is
   not supported. Added extra checks to detect if systems supports it.
   
   https://lore.kernel.org/lkml/03b278b5-6c15-4d09-9ab7-3317e84a409e@intel.com/
   As discussed in the above comment, introduced resctrl_mon_event_config_set to
   handle IPI. But sending another IPI inside IPI causes problem. Kernel
   reports SMP warning. So, introduced resctrl_arch_update_cntr() to send the
   command directly.

   Fixed handling special case '//0=' and '//".
   Removed extra strstr() call in rdtgroup_mbm_assign_control_write().
   Added generic failure text when assignment operation fails.
   Corrected user documentation format texts.

v8:
  Patches are getting into final stages. 
  Couple of changes Patch 8, Patch 19 and Patch 23.
  Most of the other changes are related to rename and text message updates.

  Details are in each patch. Here is the summary.

  Added __init attribute to dom_data_init() in patch 8/25.
  Moved the mbm_cntrs_init() and mbm_cntrs_exit() functionality inside
  dom_data_init() and dom_data_exit() respectively.

  Renamed resctrl_mbm_evt_config_init() to arch_mbm_evt_config_init()
  Renamed resctrl_arch_event_config_get() to resctrl_arch_mon_event_config_get().
          resctrl_arch_event_config_set() to resctrl_arch_mon_event_config_set().

  Rename resctrl_arch_assign_cntr to resctrl_arch_config_cntr.
  Renamed rdtgroup_assign_cntr() to rdtgroup_assign_cntr_event().
  Added the code to return the error if rdtgroup_assign_cntr_event fails.
  Moved definition of MBM_EVENT_ARRAY_INDEX to resctrl/internal.h.
  Renamed rdtgroup_mbm_cntr_is_assigned to mbm_cntr_assigned_to_domain
  Added return error handling in resctrl_arch_config_cntr().
  Renamed rdtgroup_assign_grp to rdtgroup_assign_cntrs.
  Renamed rdtgroup_unassign_grp to rdtgroup_unassign_cntrs.
  Fixed the problem with unassigning the child MON groups of CTRL_MON group.
  Reset the internal counters after mbm_cntr_assign mode is changed.
  Renamed rdtgroup_mbm_cntr_reset() to mbm_cntr_reset()
  Renamed resctrl_arch_mbm_cntr_assign_configure to
            resctrl_arch_mbm_cntr_assign_set_one.

  Used the same IPI as event update to modify the assignment.
  Could not do the way we discussed in the thread.
  https://lore.kernel.org/lkml/f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com/
  Needed to figure out event type to update the configuration.

  Moved unassign first and assign during the assign modification.
  Assign none "_" takes priority. Cannot be mixed with other flags.
  Updated the documentation and .rst file format. htmldoc looks ok.

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

v8: https://lore.kernel.org/lkml/cover.1728495588.git.babu.moger@amd.com/
v7: https://lore.kernel.org/lkml/cover.1725488488.git.babu.moger@amd.com/
v6: https://lore.kernel.org/lkml/cover.1722981659.git.babu.moger@amd.com/
v5: https://lore.kernel.org/lkml/cover.1720043311.git.babu.moger@amd.com/
v4: https://lore.kernel.org/lkml/cover.1716552602.git.babu.moger@amd.com/
v3: https://lore.kernel.org/lkml/cover.1711674410.git.babu.moger@amd.com/  
v2: https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
v1: https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/


Babu Moger (26):
  x86/resctrl: Add __init attribute for the functions called in
    resctrl_late_init
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
  x86/resctrl: Introduce mbm_cntr_map to track assignable counters at
    domain
  x86/resctrl: Introduce interface to display number of free counters
  x86/resctrl: Add data structures and definitions for ABMC assignment
  x86/resctrl: Introduce cntr_id in mongroup for assignments
  x86/resctrl: Implement resctrl_arch_config_cntr() to assign a counter
    with ABMC
  x86/resctrl: Add the interface to assign/update counter assignment
  x86/resctrl: Add the interface to unassign a MBM counter
  x86/resctrl: Auto assign/unassign counters when mbm_cntr_assign is
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
 Documentation/arch/x86/resctrl.rst            | 233 +++++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
 arch/x86/kernel/cpu/resctrl/core.c            |  27 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  12 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  91 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         | 113 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 967 ++++++++++++++++--
 arch/x86/kernel/cpu/scattered.c               |   1 +
 include/linux/resctrl.h                       |  32 +-
 12 files changed, 1389 insertions(+), 95 deletions(-)

-- 
2.34.1


