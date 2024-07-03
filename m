Return-Path: <linux-kernel+bounces-240261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFF4926AF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF4F1F21728
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765B119AD5B;
	Wed,  3 Jul 2024 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yRWvjTa8"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E50519AA75;
	Wed,  3 Jul 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043425; cv=fail; b=LcsHVQ3aZnDrtfKh6XaRxXZJe5+WPHvBbUc9gXpUtXsuFbowi84BhYXrkXwsTcIzyYnFaE6MxUNS+Av6YxeEMTrEoXlcMqMGZ8EPtImTpGmP8f3eAVfJOpnlh1LN+uIb6GlxpjaxOlU4EuvdbPN/eAsABJ7AO60jL6kw3K4m02I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043425; c=relaxed/simple;
	bh=7lV7MB2lP+UzWuY7xVl9JQN8Kc8+d5BzbamUIdhS98E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVqFC3KnGrY6E9r4VSDuqYsF84MvAe6td2zXPhs1Bgi07bGjQvsndF0Reweup0VdO7/IUHPiEuYjVq716685ZJvcvSjgh4kwuGNDk5Jasm1DfYqtudzipIq9onZzn7WZfvSoUm+AxnWFdEvwLvvbS2+h8gFP0CKUbAEd/nqBy1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yRWvjTa8; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHalk4Tm2mdkb36AMFV1H5jNBeSeq06zyUq/uhjUsY1Hst1E7oNrFpF5IP+8bRS9FIoqt11teAQmG5CvJJGck5HbyFV3yHc3V9xvF+OhiQKnNbE3KdNXoVTpXv6lwCONijuZqAu8UuoXhQ5q8pR1W1tFaSu/5TottjKake5RtbGacKtlPr+9cs3k4eTPlYpig5Do7duTKDdoGTOrE73iRUCywLz/6D/Nu3MND5W2dFUuFO08qoow4xXCGHZ0T/9PlaD2RtbSmehCH8Yj/Zios8S7air/SIEjIfV+zNDUf7pCl+PEn1WmvPbhyY1R8WNH/+ZV3guSRLMFG9uXJH/CrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waMoxOkYqoYygQWCPIxEkR8KrW1ZK8vcJbArrbtbbYM=;
 b=LVkqRW8edMsJx/rEMdTLF+4RvUow7JJH/QDCqyScIcP5a4C1tYf8XQFE8wqNJMOGnvIfS+vRPAEQJ+h158jbUi+7NzHhRqe9han05KSaQE4/a3hKRXzuILGYBfX6k7T8tWcvGY01x9mmulJpDAAPHhXwIig3HBdcjo0B5Zcgm3OGGRljWYa7/WP8g8HqfHPPXk4RrorvuHg2+hAhQHMnmmo9rlfUITHo/DQR3J96B2AkBxf+7aLPbgeq7OqEz8geHd3g6DuCU86Bo3PHPblOCt6WqVBmL5djLf0lVHAeIpIOBz+X+zUPHLj0ND9ZvOv6YQ877hv9kyxWPPabW44ghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waMoxOkYqoYygQWCPIxEkR8KrW1ZK8vcJbArrbtbbYM=;
 b=yRWvjTa8vp+u3ykJeo1zg3AmJeXzTzqHRXU6jWzvcRRTcbX94Rjv5RrId3QSD7nPhLewXZzwRN5w8YwSiSbNJHhVJQYOuV51icAunxEj/PfMB0OYvYEuL6WNsDtXvBEmMh2ywlLYeCxVWdpABMtW2zUSDQHGeA239l+ZhQP5so4=
Received: from CH0P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::7)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 21:50:20 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::8) by CH0P221CA0003.outlook.office365.com
 (2603:10b6:610:11c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26 via Frontend
 Transport; Wed, 3 Jul 2024 21:50:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:50:19 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:50:17 -0500
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
Subject: [PATCH v5 12/20] x86/resctrl: Add data structures and definitions for ABMC assignment
Date: Wed, 3 Jul 2024 16:48:23 -0500
Message-ID: <236652202801ad8760d6828ee4d4c6f91d009884.1720043311.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720043311.git.babu.moger@amd.com>
References: <cover.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: b53ea900-6aed-4e87-66d6-08dc9baa21fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0w0V3p0cGVoMTUwMFEzWEw5U0NkZHhYWmJUc2NNQU95TmhzRVNSa3hpOUZP?=
 =?utf-8?B?ZzYyK2xpZVA0UEdITUZSaklUWEFHd25Vd05odFIvTEFuenlEOWNzQ0t2Y0My?=
 =?utf-8?B?V2hZWllHb21ZVDBJMW5sSFdCQzBuZGNwNXVkZUczZE91OGRLdXhwcFRPdFNB?=
 =?utf-8?B?N1FoY3ROMERhNnFLQWloWXVFMEhzR2dqck9XYzluMXU1Tkd4bmtUV2ZBcmJ0?=
 =?utf-8?B?MzRKRmkxMXc5VHlyWnM5RmlMNHovdU56MGFzTUlVN0N3TmJnN0d0VHAxYzBK?=
 =?utf-8?B?OHNiWGlMZ1pMbDlBeEZ3UGxVQTB4bkJMVXhReEhsT1p2VVlIbkdHVllGK0FF?=
 =?utf-8?B?cVNUNDlzei80SVRwaU5FeTRRYWhDbW1iR1hlR0xYRllKSzVsU3ViK21FekpW?=
 =?utf-8?B?cnJ5RHN4bnlrNEFUQjc5VVRaek10UDh1dG03eHR3cEg2eFVGbW9HNElmR3do?=
 =?utf-8?B?NXMrR1V1NXJtSVMwbWZtRGJhYkZpYS9UZ3EzRUMrTWpwWCtRWG96SEswcktG?=
 =?utf-8?B?eU1PMDdQMzd5OVliR3phRW5kVysvRmJhUU5rZGs2OTJJS3dYbC85WTU1aXl5?=
 =?utf-8?B?L2lDb25YL0tpL05NSjMyWlh5VitONDdsTXRQRlY3bUhqTkZrNjI0NExqZGxY?=
 =?utf-8?B?UW50OWw1THpReDJpaGRaNklrejU3MjZ0YWN5d3U1NlNBWkxTMGc3SC9ycngr?=
 =?utf-8?B?M3BzVmZLS2J2RFJOZHN4YjA4cmI3T003Z0dIN29xd1VpSEczVGhVZVBYa2c1?=
 =?utf-8?B?L2lWOC9iZkI5WjJUblRGa3poTXB5aERPenJXQUVPSTJsS2dQMUgyVEI0NGkx?=
 =?utf-8?B?V0lNcTdBUER1cUlTcXk1Wk5GK2t5Nlc1QndnZ2xNVE5XU2ZINTgrSEF6V2t4?=
 =?utf-8?B?b3paaEVyeStkKzI0aDIxTWpzQVBYYlhUc0xsdXhta3BnSHFzSVowbHMwZWUx?=
 =?utf-8?B?ZDV2M1V4Q2JlRnJwbVZlK0NSbzFrekVoWVg3ZlBwa0NCRnY3aGNBemQwV2xq?=
 =?utf-8?B?U0ROZmxnSUZQV1J1S0JRUzArSnBwU0NFNlFCS0p6dzEySlI1M2JpRjEwQVo2?=
 =?utf-8?B?ODM3dUkrWFZVeEhzSnlxZUM2VnNTZzRZVEJIdnZxR3Zxc2twSFlFVmh5YktK?=
 =?utf-8?B?SHVaUzZRb3RoNVdBbytoY0J2YlZjVnYvS0xFL2YxUFliT1B5R2VXMWJHNllK?=
 =?utf-8?B?eFdiNDZrbTZzK2RRK1ZLc2tLR0VCdFFwbWs1QnlhK1hZK3lhTmRYS3NpTEZa?=
 =?utf-8?B?UkRyZmJ0T1hyREkwWUtjaGYwYmZjM3R5bmRWWHo4YVIxQjJDRnR2bTJMMnAy?=
 =?utf-8?B?WGVNRWtSVEFhODRwNkVDT3BMNW04OExYdk5FZFhyOTNYZThpVi92ZUpBeXRo?=
 =?utf-8?B?OWFHV1R2UzlEcHNVODRLRW03eG1obXF6d3ZhNGZOMW1sYTdGZVVER0xxRy9R?=
 =?utf-8?B?anV6eHl2Q3ZvSm9HRmJsRlFLOE9Tb3lIYmR0a0J5OVRiM3dZRGczQ2FaWnQ4?=
 =?utf-8?B?eEZ0cEtRdCtlQlRacUk3MUJ6b3JKZmJSVzcwS0hRTGNWNE5UK2ZOd2RHUGNh?=
 =?utf-8?B?eDZCSTN2S2R2Ykdxa1A4QUJTc3FQMDd3ZVFLaWhxZzVIRVRoYkNQbzBSOVN4?=
 =?utf-8?B?WWllLzFzYlRlTk9ha1U5eC9SRFJxSjFqa0hudHh3bytwYjUyTGxNTGtQS3or?=
 =?utf-8?B?RHphREN3Yy9UTzBqVk5qUWh1RC9PMWVDdGlGMFR1SDRub3JBQ0FoaUxiczh5?=
 =?utf-8?B?cm1FYy9pYXpCWXZLRjhma1VjaFRMT0lJRTBNcDJNeDBJbnhsWndzZEpyZWlN?=
 =?utf-8?B?aktYMVNUTkJ4M1FuL3BES2NXN0ZMNnMvTjA0Z1FET3NhTDRjbndWRHc2a0xG?=
 =?utf-8?Q?DDJKPFO539UCO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:50:19.5583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53ea900-6aed-4e87-66d6-08dc9baa21fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as the counter
is assigned. The bandwidth events will be tracked by the hardware until
the user changes the configuration. Each resctrl group can configure
maximum two counters, one for total event and one for local event.

The counters are configured by writing to MSR L3_QOS_ABMC_CFG.
Configuration is done by setting the counter id, bandwidth source (RMID)
and bandwidth configuration supported by BMEC(Bandwidth Monitoring Event
Configuration). Reading L3_QOS_ABMC_DSC returns the configuration of the
counter id specified in L3_QOS_ABMC_CFG.

Attempts to read or write these MSRs when ABMC is not enabled will result
in a #GP(0) exception.

Introduce data structures and definitions for ABMC assignments.

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

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
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
 arch/x86/kernel/cpu/resctrl/internal.h | 40 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 263b2d9d00ed..5e44ff91f459 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1175,6 +1175,8 @@
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
+#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
+#define MSR_IA32_L3_QOS_ABMC_DSC	0xc00003fe
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 4cb1a5d014a3..6925c947682d 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -100,6 +100,18 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature */
 #define ABMC_ENABLE			BIT(0)
 
+/*
+ * Assignment flags for ABMC feature
+ */
+#define ASSIGN_NONE	0
+#define ASSIGN_TOTAL	BIT(QOS_L3_MBM_TOTAL_EVENT_ID)
+#define ASSIGN_LOCAL	BIT(QOS_L3_MBM_LOCAL_EVENT_ID)
+
+#define MON_CNTR_UNSET	U32_MAX
+
+/* Maximum assignable counters per resctrl group */
+#define MAX_CNTRS	2
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -228,12 +240,14 @@ enum rdtgrp_mode {
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
+ * @cntr_id:			ABMC counter ids assigned to this group
  */
 struct mongroup {
 	struct kernfs_node	*mon_data_kn;
 	struct rdtgroup		*parent;
 	struct list_head	crdtgrp_list;
 	u32			rmid;
+	u32			cntr_id[MAX_CNTRS];
 };
 
 /**
@@ -607,6 +621,32 @@ union cpuid_0x10_x_edx {
 	unsigned int full;
 };
 
+/*
+ * ABMC counters can be configured by writing to L3_QOS_ABMC_CFG.
+ * @bw_type		: Bandwidth configuration(supported by BMEC)
+ *			  to track this counter id.
+ * @bw_src		: Bandwidth Source (RMID or CLOSID).
+ * @reserved1		: Reserved.
+ * @is_clos		: BwSrc field is a CLOSID (not an RMID).
+ * @cntr_id		: Counter Identifier.
+ * @reserved		: Reserved.
+ * @cntr_en		: Tracking Enable bit.
+ * @cfg_en		: Configuration Enable bit.
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
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 91c5d45ac367..d2663f1345b7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2505,6 +2505,7 @@ static void resctrl_abmc_set_one_amd(void *arg)
 
 static int _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
 {
+	struct rdtgroup *prgrp, *crgrp;
 	struct rdt_mon_domain *d;
 
 	/*
@@ -2513,6 +2514,17 @@ static int _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
 	 */
 	mbm_cntrs_init();
 
+	/* Reset the cntr_id's for all the monitor groups */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		prgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
+		prgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			crgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
+			crgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
+		}
+	}
+
 	/*
 	 * Hardware counters will reset after switching the monitor mode.
 	 * Reset the architectural state so that reading of hardware
@@ -3573,6 +3585,8 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 		return ret;
 	}
 	rdtgrp->mon.rmid = ret;
+	rdtgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
+	rdtgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
 
 	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
 	if (ret) {
@@ -4128,6 +4142,10 @@ static void __init rdtgroup_setup_default(void)
 	rdtgroup_default.closid = RESCTRL_RESERVED_CLOSID;
 	rdtgroup_default.mon.rmid = RESCTRL_RESERVED_RMID;
 	rdtgroup_default.type = RDTCTRL_GROUP;
+
+	rdtgroup_default.mon.cntr_id[0] = MON_CNTR_UNSET;
+	rdtgroup_default.mon.cntr_id[1] = MON_CNTR_UNSET;
+
 	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
 
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
-- 
2.34.1


