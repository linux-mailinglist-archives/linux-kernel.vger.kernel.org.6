Return-Path: <linux-kernel+bounces-276996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9692949AD9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C2D1C2297A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBC2176AAD;
	Tue,  6 Aug 2024 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZHdrcUps"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E0179967;
	Tue,  6 Aug 2024 22:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981772; cv=fail; b=CCImUQ/m8Vapr1yILS9hqA/UuSJu5Ebkq6VZb4iZv7R//gHEeJOJz3VvIbBmGkt78uNXi+u1ZbO/uljVTDsthDJjIkFVn60h79uBP6OdmkBZLDVviKbtUbVfLGv2fnlGBqz6twnN7Amm7kXHcq/uMJE1hUW70Zbv6EEZCQ68mAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981772; c=relaxed/simple;
	bh=IinG8gP1k6CcxHMdwln0iF0TeDK8BZYIXsnaWKd9nb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyCF+4KCgGsQm8prACLwt9YFFKUUwXJSdbDtt9RAH37ucd7slgtSui1zFlo1Nqs4jR0fQhwwdJWzM9B3g3/5nJJ7qjMG+mGF+PUXC0Ew5k9WviqmdUIQsjSBHnTTtvv7evt2nusJMz3HJUjnQG1OwbRjzlqVgnqVzQuzpTrEwiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZHdrcUps; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhL78FQCXHiERGZ3dHKUN+azpsGy9bdsg7zJdWlt67nszhjCkB8XljnBTW8YjAZv1YSKcWYofT7PK2Cuf04S5GHWp4xA/IlkR2muyCXO+CpVq29ShAiMlmVPfL9RXq4rb4U58mfrm7qjWD89yLELwvjUOF59+S+o7ZnoyQpMnOvHPgQZFQ29lU0PMoctPF82vgrLrIIMFrtf6IaKSOEZ8ppo0RadzFT6VIZt/jGgYtwoKjYJgqhHKYQ90QzMY2N0NsLd9/vUog2itkxZ+ffTxmSXP2qeWMv/C0yrKObwUgiByE4FWjuxGKNYpUwUQVw8NS3q4GJJoa1qd2of/MrjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXycPah3sYIOtbSlm5Y7QF7232jqqdNb/yPhAFo7Op8=;
 b=PbeQ8Xr1fiWdD1Bx6pJuSSUxoVwpc08RuduVAiv54+i8ykVoIC7pWNdmBb2+VUYzmpHRAcJxvWzfM0ZYPNihgWTPEL7052u7hWRcMqcQPu3fMnX3vD/2Gxw6QbKyWhiGPWZ853Jpz/LCpc5OnDgY6YjqJzVTDd86g9doLHmwaqeLpvRdxq88Nwzv2KoS3/XJEWwtVqlbs2z5Vx3VMwR/JPef4hIxRGxqL9aL1A8jejumbNiz2caLNrlmZvIvP9+l3ify/yGsWmk3NUT2CB5dgEGjE692C3l1GWxvma6DU+NPcBmbfEMI0pn9VLMrFkTKGDt575ZnuySTk/oeA4+LjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXycPah3sYIOtbSlm5Y7QF7232jqqdNb/yPhAFo7Op8=;
 b=ZHdrcUpsXxVRTPaHBesThJxAUUvPmf62uuavsfVSEUuaHs8KxcF+sN4Oe54w6vx5jGhQz41JaV58xD4aZgBM9iEjShKs4QCavv1HRk6OdpntXh1YpBen0mDhv6W+EkLpor4lMkyBiCT0UUAuQb0TYpUoSjdMM0scOLoQzsVV+4Q=
Received: from SN7PR04CA0184.namprd04.prod.outlook.com (2603:10b6:806:126::9)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Tue, 6 Aug
 2024 22:02:47 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::6c) by SN7PR04CA0184.outlook.office365.com
 (2603:10b6:806:126::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Tue, 6 Aug 2024 22:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:02:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:02:44 -0500
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
Subject: [PATCH v6 13/22] x86/resctrl: Add data structures and definitions for ABMC assignment
Date: Tue, 6 Aug 2024 17:00:50 -0500
Message-ID: <337d3ed1eebc662dbc7e536aba49987c2396972e.1722981659.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722981659.git.babu.moger@amd.com>
References: <cover.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dc04ac-cd36-476c-7e56-08dcb66380c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzlRL1YyeFh5aDNUZjdWOFZYTWg4VlZjREt0ajdaR1FFbWFlK2pIUE43Y1Zs?=
 =?utf-8?B?VHR0MXNlaDg2aG5lUkFQSFlnaWJJVHZOajluU0s0QVdiMkRGZjAvVFRadHVE?=
 =?utf-8?B?eWVmWWp4RUpvOVB4V0VyZGd0a0JGNmVHdHZrcFVPM0EySDZGMVRJckhyajJD?=
 =?utf-8?B?d2lPMERJY2M3clZjNm5tNkY5Z0dWOEllYUd4YkNGUGNiQi9DM0lOb2I1VUpn?=
 =?utf-8?B?a0FtSWd2ZFFsS2RKbWdXRzVyWTFjVE8xQnRzNno5QUd5SGxWeitaVEFFZk9T?=
 =?utf-8?B?cVFFUUJsaGRJY0J4Wm4yYTRUWjBrZFp0ZGl1V3BGSGFOcHBLeEdabXkrR2w0?=
 =?utf-8?B?Und5Z2FwR2xRZVhHQlo3cWplVFZseEh0S25MRjhhVldsRmRuTFhzTFhXYS9F?=
 =?utf-8?B?aHZPdkN6ajNuQnNBTW9pbGY4bkRzYUxsRVZXMnFYNXc5eGRZVlB5aHVkWWxU?=
 =?utf-8?B?WEtPSGlNSlJHZmxzM3RveGZIa3dMZzB6Zis1TGZ1KzNBb1J2ajhaQkh4R216?=
 =?utf-8?B?WW81TTJiUWwrYmk2UjVNRW8ybE5zd3dmSTdMazVldkl4c3RVNG5ENXl4U2h2?=
 =?utf-8?B?Y0VGcmdvdFIwS0t2T21oT2xiaTZiYWwzTmYwU0dkOEY0Y0c3MWFRbkZFTWxT?=
 =?utf-8?B?ejJSTHgvSUQ1OGJqSVVFcis4T2JQVGhLQURwREovOHJFQldpWVpsbXlTdENN?=
 =?utf-8?B?dERIdEhjWlo5SThhQ0tlZ0pWU0VpOWhwQ25uNUpWOTEvVDJ3TzFkN2p2cXp0?=
 =?utf-8?B?UUFKT0ZpblFrR3JQNldsN0R4UFo1TWMzaVU5SjR4VnM3SmhxbDhFZ250Ry8w?=
 =?utf-8?B?VUhzWTV6Z1FMTDNOL3V5OGJZRmtPRTkzN21XSWpudGpBOEJ4blh3Ry94eXIw?=
 =?utf-8?B?Q1hLVHM0eXlBbkNzNnRrS3RKL2pzSGVEalpxeVpGOFVTZ2haaFVZRmtjSE1o?=
 =?utf-8?B?RlpYNSs3VmNwajZLV0w2YkJ5YUNmd1U3VEtWODdoM2Vza0duT2hqVEZwNi9y?=
 =?utf-8?B?UWtPalRVd3ovRzk1bDRjTURkdVlQV1I2LzQyYTM2YVpWV3VveEhRdmZrNUxi?=
 =?utf-8?B?T1ZYTWZreVhQT25VU2lqMFl5angvMjg2RHF6NktuNjFhZkZRUXBQQ09RdkUy?=
 =?utf-8?B?TW92VFdvRU9qUzd0TUFja3A2YVpFdnZlNnRxMlQ4NEZXT3hkWkhGdHdzVUc2?=
 =?utf-8?B?TG9KT2g1Uk1jYzB2TXNZcUdKYmJFRHJOcXkrWkkvYno2RUMxNXYyWjJJQUVB?=
 =?utf-8?B?TlBXQjRKcmtObjFURUhQWS9laExCcGR6Vk5aWjdjRVpyY0RZVWlpOG9LSk1V?=
 =?utf-8?B?Ylc0eVZCNkpIVWlxcnBSWFJMVnhiaU14ZnRySUpBNHU3OS9FWTVZVmNTVExH?=
 =?utf-8?B?eTJhYmlCbWYxekZFN3JjQ25meFZnRWhWeDlua2xGbjltWFRYSGxDNzdiSHVn?=
 =?utf-8?B?cTMzaEloWENNY01XaXpzWGpMa3pUVi9TZ1RxUjRyWXdjTVI2aldnd1FVbmVy?=
 =?utf-8?B?MVdFb0dpUWFZTzUvZkxqOC9FZ0ttYW9WcElRVW5jSzR6dk5BMHo2Qk1TcnJh?=
 =?utf-8?B?bHpscDlscUVxc0Z5TjV5cTdtMUgxVmFYSHgyakJoa25aOGtEbll2UG9kUTNN?=
 =?utf-8?B?WmhqazNpbFhHS01nMGdiUUx5Q056Qjk4U2VVaGdFK252MnJWQ2lOZ052Z2pk?=
 =?utf-8?B?RjFQZEh3TFdmSjN4T215clBiSGJTeFlZZDlPYnJkcDgydVg2czh0d1J5Nzk5?=
 =?utf-8?B?bjZVdWJQUXFqNVlpWTJOdDhvOXFWNTNCYmhLNGFUQ1FYUHhOZzRkSlNmb2xR?=
 =?utf-8?B?WEJXL29ZVk40S3JXbDQySGVVWDQ5YVNmdnZMV1JHdlRnekp6MTVpb085d1lR?=
 =?utf-8?B?NExhaVlTZG5ncktEYnNzbE9zN1lLekJ2Wmw2eHR3ZS9VT3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:02:45.7561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dc04ac-cd36-476c-7e56-08dcb66380c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as the counter
is assigned. The bandwidth events will be tracked by the hardware until
the user changes the configuration. Each resctrl group can configure
maximum two counters, one for total event and one for local event.


The ABMC feature implements a pair of MSRs, L3_QOS_ABMC_CFG (C000_03FDh)
and L3_QOS_ABMC_DSC (C000_3FEh). The counters are configured by writing
to MSR L3_QOS_ABMC_CFG. Configuration is done by setting the counter id,
bandwidth source (RMID) and bandwidth configuration supported by BMEC
(Bandwidth Monitoring Event Configuration).

L3_QOS_ABMC_DSC is a read-only MSR. Reading L3_QOS_ABMC_DSC returns the
configuration of the counter id specified in L3_QOS_ABMC_CFG.cntr_id
with rmid(bw_src) and event configuration(bw_type).

Attempts to read or write these MSRs when ABMC is not enabled will result
in a #GP(0) exception.

Introduce data structures and definitions for ABMC MSRs.

MSR L3_QOS_ABMC_CFG (0xC000_03FDh) and L3_QOS_ABMC_DSC (0xC000_03FEh)
details.
=========================================================================
Bits 	Mnemonic	Description			Access Reset
							Type   Value
=========================================================================
63 	CfgEn 		Configuration Enable 		R/W 	0

62 	CtrEn 		Enable/disable Tracking		R/W 	0

61:53 	– 		Reserved 			MBZ 	0

52:48 	CtrID 		Counter Identifier		R/W	0

47 	IsCOS		BwSrc field is a CLOSID		R/W	0
			(not an RMID)

46:44 	–		Reserved			MBZ	0

43:32	BwSrc		Bandwidth Source		R/W	0
			(RMID or CLOSID)

31:0	BwType		Bandwidth configuration		R/W	0
			to track for this counter
==========================================================================

Configuration and tracking:
CfgEn=1,CtrEn=0 : Configure CtrID and but no tracking the events yet.
CfgEn=1,CtrEn=1 : Configure CtrID and start tracking events.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Removed all the fs related changes.
    Added note on CfgEn,CtrEn.
    Removed the definitions which are not used.
    Removed cntr_id initialization.

v5: Moved assignment flags here (path 10/19 of v4).
    Added MON_CNTR_UNSET definition to initialize cntr_id's.
    More details in commit log.
    Renamed few fields in l3_qos_abmc_cfg for readability.

v4: Added more descriptions.
    Changed the name abmc_ctr_id to ctr_id.
    Added L3_QOS_ABMC_DSC. Used for reading the configuration.

v3: No changes.

v2: No changes.
---
 arch/x86/include/asm/msr-index.h       |  2 ++
 arch/x86/kernel/cpu/resctrl/internal.h | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index d86469bf5d41..5b3931a59d5a 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1183,6 +1183,8 @@
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
+#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
+#define MSR_IA32_L3_QOS_ABMC_DSC	0xc00003fe
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 1021227d8c7e..af3efa35a62e 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -589,6 +589,32 @@ union cpuid_0x10_x_edx {
 	unsigned int full;
 };
 
+/*
+ * ABMC counters can be configured by writing to L3_QOS_ABMC_CFG.
+ * @bw_type		: Bandwidth configuration(supported by BMEC)
+ *			  tracked by the @cntr_id.
+ * @bw_src		: Bandwidth source (RMID or CLOSID).
+ * @reserved1		: Reserved.
+ * @is_clos		: @bw_src field is a CLOSID (not an RMID).
+ * @cntr_id		: Counter identifier.
+ * @reserved		: Reserved.
+ * @cntr_en		: Tracking enable bit.
+ * @cfg_en		: Configuration enable bit.
+ */
+union l3_qos_abmc_cfg {
+	struct {
+		unsigned long	bw_type	:32,
+				bw_src	:12,
+				reserved1: 3,
+				is_clos	: 1,
+				cntr_id	: 5,
+				reserved : 9,
+				cntr_en	: 1,
+				cfg_en	: 1;
+	} split;
+	unsigned long full;
+};
+
 void rdt_last_cmd_clear(void);
 void rdt_last_cmd_puts(const char *s);
 __printf(1, 2)
-- 
2.34.1


