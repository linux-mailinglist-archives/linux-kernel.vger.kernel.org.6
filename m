Return-Path: <linux-kernel+bounces-276979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E00B949ABA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A064E1C2290D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415D173357;
	Tue,  6 Aug 2024 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mnyOza0I"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F124170A02;
	Tue,  6 Aug 2024 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981677; cv=fail; b=HQBlVbaijmXhJxQ0/BCPkhgnG+U7F47HKeLa7v5T/U3ixi8zN1AMSyhrxQQb9D7HzQnchchcFG/t7p3QZzuKtC063J82YvJYOWubTkbhhF4MCl3ktC1vGKeH/WC2JGm7SzdAUO7Uu8zlyh/1d+6rxpSnn6TjMm8yjdl60ywQ+5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981677; c=relaxed/simple;
	bh=Zkhlad+IoMfI1eUswuZuFrEEt2qR/rruZFvFXno7SEA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RjxCBMSNaqM+mu1fQ/qnC5fshH4Zhh9gaLwyYkP7Eb0mE5iTKJ7DVyyW6yG76ojvU6np3FmR0MwPi1Z36Uq4GHwjU4irmHL9fAIumHnGYW/bmXkxsZj5AYa7NCfd3fcy5qkTuQS0ymytGzj+FT7hHjbWpN0yntBqUVqcVDSR5QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mnyOza0I; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5bb0H+Q8YtHRzZRA0jB4xnCdjGdXbiidIUxrxIp7zaK5I+6kYdtlkc4xKFJyZHZeC4b4nr/8P2Zqos0GvZjDaDnCjxYIr39pceTK8nZXvQ/N8MzjjnAtMSRZ2y6zjgxAlVAtwfukDWfsML1aKgF5CI/RYlVmw0tr5tnCwWQ9H9Vf3d5Sd1YdtV3rFgh3ql1pHDOFeAviDxBbkcoxeNvmit3JWkUfD5d7w9n9wOwXAKvv0DqNPp28kk7GdZgrN7A80RrmqIk6y1Id+XyutVr/nXMl7w0cW2QRZ8YDMak8hlvxXiLXDHJkcDX/+46qrFqOq0X1RkWs+ydiqe5niK2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw9rhwFlLJE3A5drlA4lnVeuwWCOauekxjYg0PGN8tE=;
 b=J8c2G/egVUNZUl8EbNLzG/fgFa6tzj10NMs4KpnbLPiFD8DnHtgfR0al7LKYZGfc+0TT66wmeBitj5VrJNqJ/oWuUp02uLX1EJaxv3o1bF/stq3HbKsBYM9jkax9DJ9l5lB6IaLOJdnhtGvVAWcSRaIpQjzoQu+8Axbs1+11RGBbgAcuATuJE13eiR3m+Jc36UmWwAx/si7iFEBKGE4+xElk1IMpr4MblJQlHQ2uVaa8/54JVSW34sH0He/50Qa7isL0XYJvtVbh03FLPhs+pUW3/n/AoBjYxALoQJOH/HAMAI7QmZgL0FGXXJi+5UZbMOOr32GXdXRCIGYimPryxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw9rhwFlLJE3A5drlA4lnVeuwWCOauekxjYg0PGN8tE=;
 b=mnyOza0ILk92eXZRJEvmeVdBXMK9Igm7Lv6H9d3bvodpcWdSvVW0Z2GwCwrdlgLug1/lzsqQVN8lD8VW2t8Apa15tqDxbw+IHYDGpPhjbdTrSPmyTgWelqHAb8TyplAs8G67DJGiWnZEYmY0ZRZ+fXCDrljw8/YDfJptk/LYVvo=
Received: from SA9PR13CA0120.namprd13.prod.outlook.com (2603:10b6:806:24::35)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 22:01:10 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::a5) by SA9PR13CA0120.outlook.office365.com
 (2603:10b6:806:24::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Tue, 6 Aug 2024 22:01:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:01:08 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:01:05 -0500
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
Subject: [PATCH v6 00/22] x86/resctrl : Support AMD Assignable Bandwidth Monitoring Counters (ABMC)
Date: Tue, 6 Aug 2024 17:00:37 -0500
Message-ID: <cover.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 810c89cc-0caf-4bef-cbbf-08dcb66346b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVRqOVh0ZGkxWklob1BzTk5IbXNmLzNoQmhZbmNrdU90OExVeXpTS1BXeHFT?=
 =?utf-8?B?SG5SSExVQ0J4K2NmeGFBakFxK2VHTmd6Q0ZtRHBhQ29Edkp6L0VPb0NHQ3ND?=
 =?utf-8?B?ZHAraDZaRC9OZ1Q3dmFZNCtTU2N4OWswa0xaZzNXbkNUQXNrU29VWkdoL3lQ?=
 =?utf-8?B?NVlwem9PL0NpM2JXTDJPMUlIaW5OdCs4cmpSallQUGJjVW85Mm5YcW5qOWg2?=
 =?utf-8?B?WFFaQVBWSEh5eUkyczRWR0k4WUVNdSt4WDh3TlljRmMyYjlsT3VtNk1kcUJQ?=
 =?utf-8?B?MWhndXBwQno4WXIyTHlWRHhWTHhqNXl1MDBPZkNsMHFuWmpDOVdUSmRJTE5S?=
 =?utf-8?B?OTU3Mm5WU3p5ckZvaDUvS2JpZFdTZFh5RHV4VzFqQnFIcXNLY3kwcnJBdVdr?=
 =?utf-8?B?bHZvem9TT2lsV0liRFcxUUtVWGcvRWxKMmRmYWMvN3NCUTVBZmxvZWx6b3VB?=
 =?utf-8?B?UFdtZjJ1V2Y4eS9INlptUWd2Z2lHTUNsZjliTE1PZXBiY0tzWWxoaStOYXMz?=
 =?utf-8?B?SGlzYzVnaFhrMThxN1ptWXRlQjhwM1o1TForRjMyOUFRL3czZUVNa1dSbUxB?=
 =?utf-8?B?V2J5cWp2cjI2aTkxTk8xT2ZTbEV0VmYwa3pYa05sU0pPU1JOaG1GU2FRczB6?=
 =?utf-8?B?VitQZ1dzVDl3NVlFWGxqK3owSWtTeTk1b2xUVnhDSW9mZDJ2TGVadG9yUXB0?=
 =?utf-8?B?d1d4Tmt1MmF3ajV4dE9jZzFOVkQ5dDU0dEczb3dON291YkZsYVVhUWNWQmla?=
 =?utf-8?B?ZHNYTDEzUG1DQW5Pb0MyK1lHdVBFUUtYKzZyblovVEIvaWVYYkZJSFQwR3pU?=
 =?utf-8?B?VklXOW5nRGgvNGYzY29WZWVLWkpETkxnMjFCMllSNy8waUNNL3VSR0tpYkE3?=
 =?utf-8?B?Ym5NTGc1cHppdzZzeXhJQTFPN1RJZlBQZjc2MWJZTzdaVGI4c3B4aEVETGVP?=
 =?utf-8?B?YmtPYXhyNmxaL0xqenRFeGRsNmpQUUx1OGJlY2Mza3NFb1dBaFFIa05hZmt4?=
 =?utf-8?B?eVBIeThpSXF5aXVmRGZJV1B4OWI5QWlqT200bUhkS051NXNySlphTGV4TlBL?=
 =?utf-8?B?VHRWbithSFRycFIyTUlXMDRMaUtjdjBVbEdjK2FLYjFHbDJxd0FOcVRtdGhj?=
 =?utf-8?B?NWZMYmV6WDdZclRHQ3l6ZU53Q2RvUWY1WVczeHdqOEY3R2F2R0hxUkcxRTRC?=
 =?utf-8?B?akxSd0NmOFdnRjQwSytGK3hWeUM4RWtDaTd4K3VTMURWYUxaWnBwYTJsdm9v?=
 =?utf-8?B?VTdlck1wK0RPdWxuWWs3eUw5T09oZGxjL1RQalAzbHlzQmV1YnJxREdTd3Jx?=
 =?utf-8?B?aWdzTlJ4OUlpTkJuby9nNk53NmFqTm5aQXFMbmYvQ0N6aTZmblAvaDRaWktU?=
 =?utf-8?B?cFFYQjkzL0R6QXFFL2lhNzdhNWdOV0dEbS9YbVFlSTlMUzBCNU5RUGpVb3hQ?=
 =?utf-8?B?bC9tOWNnMmdldXV0cmVWUU9XQ0NUamtpZzhKbkNMaFN4N0ZYT0FNZHJkVTQz?=
 =?utf-8?B?bHFBa1ozMmlaQ1V5UFF2Y2tMTE9GcGxGRDRqaWc0VFpNQSt3V0hoUWxKeC9y?=
 =?utf-8?B?Qm5LNmszWnYwSEZiMkF5aXY2SHpwMllDTVVwditwWFNwbmF6dWpmZnpOZG84?=
 =?utf-8?B?Y1FNY2liU2JIWW1mZ1dieGRvdHBPcCt4NDBPQkVlRWN5ang2V01PUnNER1VQ?=
 =?utf-8?B?TUowL1ZpRElucXdlN3hxK1J5LzJPYjBFb2Fwa3I3bEMraC8zeVlGR2gxa0Jt?=
 =?utf-8?B?TW1QaEFCa3R4Q1RlUStqckRzNTdhVFFNNHYrK0dyVnZMbXo0SlhQREUxN1k5?=
 =?utf-8?B?Z0FraGs0L1FGREIvWDVmMitiY3NUS2ZlNWI2YmRnbU5RUFVidXU4VkFiZ0RL?=
 =?utf-8?B?Mmh5bjNFeG9makM5QTFnRkxIVWxEV2dkWDc1eGRHU0lrVlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:01:08.3388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 810c89cc-0caf-4bef-cbbf-08dcb66346b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123


This series adds the support for Assignable Bandwidth Monitoring Counters
(ABMC). It is also called QoS RMID Pinning feature

The feature details are documented in the  APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC). The documentation is available at
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

The patches are based on top of commit
325700e2e9e8 (tip/master) Merge branch into tip/master: 'x86/timers'.

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

/sys/fs/resctrl/info/L3_MON/mbm_mode: Reports the list of assignable
monitoring features supported. The enclosed brackets indicate which
feature is enabled.

/sys/fs/resctrl/info/L3_MON/num_mbm_cntrs: Reports the number of monitoring
counters available for assignment.

/sys/fs/resctrl/info/L3_MON/mbm_control: Reports the resctrl group and monitor
status of each group. Assignment state can be updated by writing to the
interface.

# Examples

a. Check if ABMC support is available
	#mount -t resctrl resctrl /sys/fs/resctrl/

	#cat /sys/fs/resctrl/info/L3_MON/mbm_mode
	[mbm_cntr_assign]
	legacy

	ABMC feature is detected and it is enabled.

b. Check how many ABMC counters are available. 

	#cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs 
	32

c. Create few resctrl groups.

	# mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp


d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_control
   to list and modify the group's monitoring states. File provides single place
   to list monitoring states of all the resctrl groups. It makes it easier for
   user space to learn about the counters are used without needing to traverse
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

	# cat /sys/fs/resctrl/info/L3_MON/mbm_control 
	non_default_ctrl_mon_grp//0=tl;1=tl;
	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
	//0=tl;1=tl;
	/child_default_mon_grp/0=tl;1=tl;
	
	There are four groups and all the groups have local and total
	event enabled on domain 0 and 1.

e. Update the group assignment states using the interface file /sys/fs/resctrl/info/L3_MON/mbm_control.

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
	
	= Update the assignment to match the flag.
	+ Assign a new event.
	- Unassign a new event.

	Flags can be one of the following:

        t  MBM total event.
        l  MBM local event.
        tl Both total and local MBM events.
        _  None of the MBM events. Only works with '=' opcode.
	
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

	To update the non default CTRL_MON group non_default_ctrl_mon_grp to unassign all
	the MBM events on all the domains.
	# echo "non_default_ctrl_mon_grp//*=_" > /sys/fs/resctrl/info/L3_MON/mbm_control

	Assignment status after the update:
	# cat /sys/fs/resctrl/info/L3_MON/mbm_control
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

j. Users will have the option to go back to legacy mbm_mode if required.
   This can be done using the following command. Note that switching the
   mbm_mode will reset all the mbm counters of all resctrl groups.

	# echo "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
	# cat /sys/fs/resctrl/info/L3_MON/mbm_mode
	mbm_cntr_assign
	[legacy]

	
k. Unmount the resctrl
	 
	#umount /sys/fs/resctrl/
---
v6:
  We still need to finalize few interface details on mbm_mode and mbm_control
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


Babu Moger (22):
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
  x86/resctrl: Introduce MBM counters bitmap
  x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
  x86/resctrl: Remove MSR reading of event configuration value
  x86/resctrl: Introduce mbm_cntr_map to track counters at domain
  x86/resctrl: Add data structures and definitions for ABMC assignment
  x86/resctrl: Introduce cntr_id in mongroup for assignments
  x86/resctrl: Add the interface to assign a hardware counter
  x86/resctrl: Add the interface to unassign a MBM counter
  x86/resctrl: Assign/unassign counters by default when ABMC is enabled
  x86/resctrl: Report "Unassigned" for MBM events in ABMC mode
  x86/resctrl: Introduce the interface to switch between monitor modes
  x86/resctrl: Enable AMD ABMC feature by default when supported
  x86/resctrl: Introduce interface to list monitor states of all the
    groups
  x86/resctrl: Introduce interface to modify assignment states of the
    groups

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/arch/x86/resctrl.rst            | 201 ++++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   3 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
 arch/x86/kernel/cpu/resctrl/core.c            |  12 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  13 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  90 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |  65 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 948 ++++++++++++++++--
 arch/x86/kernel/cpu/scattered.c               |   1 +
 include/linux/resctrl.h                       |  25 +-
 12 files changed, 1262 insertions(+), 102 deletions(-)

-- 
2.34.1


