Return-Path: <linux-kernel+bounces-443880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D56B9EFD1E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC8316659D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2429814B088;
	Thu, 12 Dec 2024 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XMdD0OsO"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8DDDDC;
	Thu, 12 Dec 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034590; cv=fail; b=GvuKI6WFsD7WXFFUe7yzF2qOTXtAjbwteIDrccDN79VqMFGpbvbViXYX5svcsmUfRzvZeWsCQZbapqpztgnvYjVmViFevPf7UZ3V1hhf0mXa94jZiU7UbwrL19vUpCGE8+6mrsDj0l2wlKVfEWti3r0CdrJZIw9cZ+E5sDjq+gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034590; c=relaxed/simple;
	bh=KnjLWvu1usdUoM5tY24wv5PlTGqlIQvF/PJCt7ic7p0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/sqvh+zHE8ldK4DN0MIM6xFYBSvTNhP9Te2Rjj77VaZvRZ1z0vn/d4HML/YBthqayjbMu+le0hx8thqqrqBVkDD6xL6O1blcq/2VrRElHYbfKTi+JJHoA5AQxhXLPxtpQMdzFMMSHiEcPd8jN82iNU91WNH1XH3X5sJDlHE5Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XMdD0OsO; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9fO3XPymBJojvNiJDTrFrls8v/dPkqtUUriF5hPzfnvWehA3owCuNsxH9axNPWxeCEYbEq2XrCebwQLi25qjbzpR/4fRe1jJB4zjuY/xSaT/L5lmEbvGwN9CD89Ccz23mrjhYg3WclMo+JGW2N5fZAGH5XcH32kGBDUztpn9Q+vvuPLR7Hb9v4+MvtD0AyaNTtXh0s2Z9LsXZzQT6AlccvJBE+mWcNTDrDdUkwMygV6ECNh2gVzPWXAa4bIkdsBBHbKRRyKPb/vM3u6WV1xTOmrmH3qtrA2Xy3Wvubnz1SjcjmO+GQqLZUUY8499ZaTuDloPtnPGdaYQpEhDUakKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMoDeOx0K29CcAwZe+vgJ20ktPuRYwKLhZp1h5C8SDk=;
 b=g+VR51WIBHPWr0HCQgIrmMXmf3WMWLms0Ev3CtEH39u/qs6bn7nW8AH0OZKgaUXKS9siN2MqF20gxzo+Ynn6MCPnUyzeJd3u9zxZcPz0t5o9jIkquAqVtgC63fglkr+x5C3WSQv22uQjzUJxKe3oALamIwKYMo2mMTch4EyYZc8wWJKLVgagyq+7AYhw+0W6I5H1Q7Ms0S4Dnk8kXfD/tzvRCkmHzxHctQklGxUUj8U59lWnDWti2uX67zlnpnj/isS8/wBaJI+qdwY8bB5eX61M7qT98MbSh8yCOmr7G7Rs33WtrYa7gnwCXVXd2fVKLv7+VUwqIsbo8jmmQLLqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMoDeOx0K29CcAwZe+vgJ20ktPuRYwKLhZp1h5C8SDk=;
 b=XMdD0OsO9nI6IWC5Ne0G6uF6DgNGoRgNELgKgTSmla9U4psQXXgZTVRdg8iupwpqRnBe6bIcBCFl4DjE4Bsc7CkiIphLHiUa95tbVNUJIaOcvCvRGrR42qI3rf0j+dqzVTtJp4sO9ZNpdcgZazm9GHKKD2ZAQFfE5x6o2yHGZ30=
Received: from BN9PR03CA0563.namprd03.prod.outlook.com (2603:10b6:408:138::28)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Thu, 12 Dec
 2024 20:16:07 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::ca) by BN9PR03CA0563.outlook.office365.com
 (2603:10b6:408:138::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 20:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:16:06 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:16:04 -0600
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
Subject: [PATCH v10 00/24] x86/resctrl : Support AMD Assignable Bandwidth Monitoring Counters (ABMC)
Date: Thu, 12 Dec 2024 14:15:03 -0600
Message-ID: <cover.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 19363005-0bc4-4767-e926-08dd1ae9cf7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXFjc2NBcDVYL0RoMmY5TEg3eDJrU1U5KzIrbzJMVUpTRWFQVElzdkE3Zks3?=
 =?utf-8?B?czhOOHc3Sy9qeEJoUy9MQ01JellVaUtqWDMzaWhNOGlDMjlib3U1Z25aMW9N?=
 =?utf-8?B?alIxakhMWGhGd0xYRXhJRVAwV01pN0s3Tm9kUDJFUjV2NDcwZWVqcmRUN0Ja?=
 =?utf-8?B?Q1B3MWlzcjkxck54ZTR6TEttR1hlSjEvRmtJbG5TZEtObU5DK04xQlFmSWdk?=
 =?utf-8?B?bXNHekZiTlB0dFJjcWZsWm1ERTkxeDVpRUsyKzFmWEFhUWEvb3JYMHdEWFBK?=
 =?utf-8?B?d0hrV2VyV1QxV2c3UkZpNU9aTDlJY3l1U3lmelhGbHg4TndZcDNkVlZEWFRE?=
 =?utf-8?B?cTY2Rm83dW56d3NnNVd3bHMxcHVYeFdPS0h2STY2WG00V253cVUxbDdmSTBL?=
 =?utf-8?B?ZHFDMlllVzZzeS91UVpTZU5vZzJqZ0VLSm5VdFFsU2FCYUpDV3IwTEs4Q293?=
 =?utf-8?B?Qm9RL3czaUV1dks5Rk9odHByN1FPbTM4c0FTWXl5aC9uU21ZSUJTWWRVdHFo?=
 =?utf-8?B?dU5GMnU5SWFUQ1VsdzViRjVGTzFNZUxRRnpQcnpvbUtMVnJDdzg4YlJ1WmM1?=
 =?utf-8?B?b2xralVyTmV2cU5DL2Y4M1M0MU9iUlRBNUU1Ukd3b2NLaG9wN0gxbzU5SmpT?=
 =?utf-8?B?dkswMTJtZU9vamc0ZGZJNW1reUtSWU4vVm9Ic2VrTmoyUzFrVG4zQUNMaWpD?=
 =?utf-8?B?Um5LcXZ6aWJLcTUyWTQvUFdSdnFwcm5xSkorVzVwclFvZ1pnL2VxUTltTzI2?=
 =?utf-8?B?T1UySEpMN1FrUVVnbXV3ZEs3L3FNN1VlRVdraXVJYXZNWUYxc2gwSEU2K3gz?=
 =?utf-8?B?b2JSNFdteXdiODZuamZIVGZnd3hDa1MwTGkzSUNBaHI1bFRaMVZQZFN5SVll?=
 =?utf-8?B?NDNPVWdqSXo3NjlDU1BaRWJQTm1BdE04SGZMMFJESjdweGVuYklsb2plck9I?=
 =?utf-8?B?aGJudXY5a0ZXTk9qUGRuQndIVkVvQUtkcXZITDBvYm10QjBIb0ZDdUpqOXdW?=
 =?utf-8?B?a0pPeG8xRk5VNVFyS3lWbFBwSk80TzV3U3Q0QjVoK3RkT0FBeEZ1Z29qL1c4?=
 =?utf-8?B?RzdCY2Y4eTFHR1I1dUhlUmJBaWxhWWFzRjRTOHpVYXBmT2NVY3diYmJIVG45?=
 =?utf-8?B?cWMzeUdHU2Z1M09RRGgzVjNPOFlUcUJmYXVaTDU3TnlqSy9JY2MrUWkvZUFX?=
 =?utf-8?B?TzFPY1k3MXVObzN4dlBJSHFISW5kNXh2WHpIcUUxVVpBNElLd2hUbHJ2MFUw?=
 =?utf-8?B?bnNJY296YmxzYk9xVFRLaGZIRkFBdXZIVmxwQlRHcTQ1djhhRzR0ZjRPNTZC?=
 =?utf-8?B?cW1YdEkyUWN1ZHpuaEFPNllrL1NHZGNET0Z2UytTLzBZQUEvMU5LaVY4d0hJ?=
 =?utf-8?B?SFNPSUM3VGt2czNZdjZoVWVHRzNRbXBHQ1gzSXdPTUxlOVBGM3phUGZkWWcr?=
 =?utf-8?B?VmcwRGtGTFlheWh3a0xKL0k5bFlTZVFHc2J5dndWelRVM0YvMk1PK1FpRHYv?=
 =?utf-8?B?ek9hWXByV0FETGRhWjdtbWd4VkFPK3IxR0VRdFc1UlAvSFRvQUxZaU1tUzdH?=
 =?utf-8?B?N3FyWWVzVWkwdktJSG5kakNRbWYxT3duaURySDRZZ3lCcVZwL0xlQjF2ampr?=
 =?utf-8?B?N0QrN2p6U244bytUWHF0bStBK0R2dHZuOFA4ZDJjRVNlZkxTb1h6OUZiaE8y?=
 =?utf-8?B?VEF3MVA5OUo2NElGdFVRWDNWRENDeWJFZ1p1TUwxY3FERy9DV2VwbU9ic2dr?=
 =?utf-8?B?ZVZsVHpFeHpOaXdGMjAwOGJPQkhuWVg1QnBQUnY1UEYySkdlWE5zU085SGFG?=
 =?utf-8?B?MkFKdXphcWZyRFl0dUZQRm0xT2d5dzJ4cmhMOGs3a29jREs4V2dwdDYyN3Yv?=
 =?utf-8?B?VVczZnJRTVRYeVNUeEdiYXVRQ3NJUnRDbDdGT3NDRTdGY3ZNSnNHVkJhKzNz?=
 =?utf-8?B?QS9FcFprMnp5Y0FWMGkza0IvZUpkcEE3RDBFbGsvOGwrNXlDakhLQ2FRWmtQ?=
 =?utf-8?B?eXlUcWZvcWJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:16:06.6690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19363005-0bc4-4767-e926-08dd1ae9cf7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898


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
d803bbbb55f4f (tip/master) Merge branch into tip/master: 'x86/tdx'

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

	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
	[mbm_cntr_assign]
	default

	ABMC feature is detected and it is enabled.

b. Check how many ABMC counters are available. 

	# cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs 
	32

c. Check how many ABMC counters are available in each domain.

	# cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs 
	0=30;1=30;

d. Create few resctrl groups.

	# mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp

e. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
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

f. Update the group assignment states using the interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control.

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

g. Read the event mbm_total_bytes and mbm_local_bytes of the default group.
   There is no change in reading the events with ABMC. If the event is unassigned
   when reading, then the read will come back as "Unassigned".
	
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	779247936
	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
	765207488
	
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
	
i. Change the bandwidth source for domain 0 for the total event to count only reads.
   Note that this change effects total events on the domain 0.
	
	#echo 0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	0=0x33;1=0x7F
	
j. Now read the total event again. The first read will come back with "Unavailable"
   status. The subsequent read of mbm_total_bytes will display only the read events.
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	Unavailable
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	314101

k. Users will have the option to go back to 'default' mbm_assign_mode if required.
   This can be done using the following command. Note that switching the
   mbm_assign_mode will reset all the MBM counters of all resctrl groups.

	# echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
	mbm_cntr_assign
	[default]
	
l. Unmount the resctrl
	 
	#umount /sys/fs/resctrl/
---
v10:
   Major change is related to domain specific assignment.
   Added struct mbm_cntr_cfg inside mon domains. This will handle
   the domain specific assignments as discussed in below.
   https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
   I did not see the need to add cntr_id in mbm_state structure. Not used in the code.
   Following patches take care of these changes.
   Patch 12, 13, 15, 16, 17, 18.
   
   Added __init attribute to cache_alloc_hsw_probe(). Followed function
   prototype rules (preferred order is storage class before return type).
   
   Moved the mon_config_info structure definition to resctrl.h
   
   Added call resctrl_arch_reset_rmid() to reset the RMID in the domain inside IPI call
   resctrl_abmc_config_one_amd.
   
   SMP and non-SMP call support is not required in resctrl_arch_config_cntr with new
   domain specific assign approach/data structure.
   
   Assigned the counter before exposing the event files.
   Moved the call rdtgroup_assign_cntrs() inside mkdir_rdt_prepare_rmid_alloc().
   This is called both CNTR_MON and MON group creation.
   
   Call mbm_cntr_reset() when unmounted to clear all the assignments.
   
   Fixed the issue with finding the domain in multiple iterations in rdtgroup_process_flags().
   
   Printed full error message with domain information when assign fails.
   
   Taken care of other text comments in all the patches. Patch specific changes are in each patch.
   
   If I missed something please point me and it is not intentional.

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

v9: https://lore.kernel.org/lkml/cover.1730244116.git.babu.moger@amd.com/
v8: https://lore.kernel.org/lkml/cover.1728495588.git.babu.moger@amd.com/
v7: https://lore.kernel.org/lkml/cover.1725488488.git.babu.moger@amd.com/
v6: https://lore.kernel.org/lkml/cover.1722981659.git.babu.moger@amd.com/
v5: https://lore.kernel.org/lkml/cover.1720043311.git.babu.moger@amd.com/
v4: https://lore.kernel.org/lkml/cover.1716552602.git.babu.moger@amd.com/
v3: https://lore.kernel.org/lkml/cover.1711674410.git.babu.moger@amd.com/  
v2: https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
v1: https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/


Babu Moger (24):
  x86/resctrl: Add __init attribute to functions called from
    resctrl_late_init()
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
  x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg in struct
    rdt_hw_mon_domain
  x86/resctrl: Remove MSR reading of event configuration value
  x86/resctrl: Introduce cntr_cfg to track assignable counters at domain
  x86/resctrl: Introduce interface to display number of free counters
  x86/resctrl: Add data structures and definitions for ABMC assignment
  x86/resctrl: Implement resctrl_arch_config_cntr() to assign a counter
    with ABMC
  x86/resctrl: Add interface to the assign counter
  x86/resctrl: Add the interface to unassign a counter
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
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |   8 +
 arch/x86/kernel/cpu/resctrl/internal.h        |  78 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |  68 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 971 ++++++++++++++++--
 arch/x86/kernel/cpu/scattered.c               |   1 +
 include/linux/resctrl.h                       |  53 +-
 12 files changed, 1355 insertions(+), 92 deletions(-)

-- 
2.34.1


