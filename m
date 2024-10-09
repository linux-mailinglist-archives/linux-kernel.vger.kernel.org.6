Return-Path: <linux-kernel+bounces-357622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD30997365
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A491C2253A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BA91E284E;
	Wed,  9 Oct 2024 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z+LTW6Sk"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62E31E0E0E;
	Wed,  9 Oct 2024 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495725; cv=fail; b=Gi+nMlggZpS2GnEoXPLVDUh5Ujbbd9OgkDfGufSJuLR7KikMWiImvDIAaMsgmVeHVz9vsdII3Oe2/Ozo1jeXUr7tafVlMd86Unv3WkB1Pt0n71PNqJ6n4xZQx5Fp8zvic6vHkUhHusuZuL6BpFyVTtBTxL7ftQyazVuiy5JNttU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495725; c=relaxed/simple;
	bh=y3MLz0yY9re2k6mna8Qs5qcZtKxwa2dWNVejpMPWoHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSq3d9qP8tJR+0Ux3v60pOtC3uEoGRoGysO7g4EdULROE5BkUHqDgLZ/srWkyF6y5YhW+EGNRz91kZ8qBThh/4GGuQJbIv/JgbMFXVpXOq4HNbf8hrn8raQfhRWsBU9eyLVgooDgf0dF+/VeAYpN9fnCSHIXLEL5D6LywrFHnyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z+LTW6Sk; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSMsnc0xVLPBDBBuBdIL7qns+b7pDCQqCd5qXbPZSThP6FSP9IClZ+L7UCCGeAxg9vY8lptptv7ffCLV3I/L/CPNDzYPc0uxTfBfqM+88oJh1Q2UI/Eu49tfDQukDfycGeV09Gvsuqu2Px5hSOygQId6vlFepUl8kH447hrakqZY58NTqhbli7d7iqNZ9YAFIQrhO33ofT7kuiOzLtloNqS1NAoySFZ16jYkSH5JS8mewp8oSVLiwkGzTc4WdbJG0IKTi5QGNDb34iwMaK9ZVkgGhuQT9gyi+GB787fnLSkMNfZT3CDS1P/hZR/yAQqVapm2nXc4NiNngOUUnldZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeguYBnlP4mO4oUjNQ1zFexrmO7vdBwh7ol9YfGu7Ow=;
 b=CFQwfOsn12oY3PS+tDnpjtoH01JxVYF8bQRrkryinAnImv4zb+odDviAvmNiscxkcE9I8IgEiy52skw/P/Pqtnu1aYcZ9e9L17WtOwmX2ubPlD7aKIThNv13nBQzAMEvdWauYW5KqmjEvapSLeH/Ky5YjfRZHJ0Cbv+UMb1Oj9LLLUvhki/xwac3nUJBp49dVhmKmeviE/xTOPcqQNrJgFTjP7pz0nDEAfAqCW26nuEJAvGhHGM+/zdSb9NAG8a/BLiNminZfPkLHyoS014+6fh6w/6GakyKYWBDl8tSrzhrt8vszckl9vi+Kzhf53c/7sK5PFtZ4OlN4QgrBV1tug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeguYBnlP4mO4oUjNQ1zFexrmO7vdBwh7ol9YfGu7Ow=;
 b=Z+LTW6SkVymelwcZX0xob5Sx5TOj0BvNEvKsdsxSwj+3WQryIPGsuvAMf4czvPkKpNnFkpvx9wGwL1/amYBbTVDIsPGBt4eLHn/UrFQC+oQPwwz8EPbohojzMWoNVscjFwgoHDDmdVV6LDl4KNnBtlZw77f8UQxUHvReLiWIm9Y=
Received: from SJ0PR13CA0157.namprd13.prod.outlook.com (2603:10b6:a03:2c7::12)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:41:56 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::35) by SJ0PR13CA0157.outlook.office365.com
 (2603:10b6:a03:2c7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Wed, 9 Oct 2024 17:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:41:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:41:54 -0500
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
Subject: [PATCH v8 14/25] x86/resctrl: Add data structures and definitions for ABMC assignment
Date: Wed, 9 Oct 2024 12:39:39 -0500
Message-ID: <94cfd19bf9b16570b07649e1058b4ee55ac8c102.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 44993453-8bdb-4c04-b35a-08dce889ab5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzF3amhhYVRGU3R6ZHNtOXlSTU1KRVFTMUV2THZYVzJlbGh5Qk53SFVSMUds?=
 =?utf-8?B?TFk3Zm1WWmFtYThtaUt4Yk82Z2tGV25qRitmeG1XdjN6NVMraExoM3VvbGMx?=
 =?utf-8?B?UlZSTmtQYkVWZGtyNHV4YTBnWFF1aDBHMDVHcmlVWlJzenQzT05QemdkQmtt?=
 =?utf-8?B?U0hYeThGRWZYbTY4ZVZTa1psNjVSSGl4VmtNcXBCSWpMVjJWOFc4dkMzanNK?=
 =?utf-8?B?cnQremJ5K3lHb3FTZjNQaDVXWGc1amwxS2ZHVGdsWmJRQU5pakJZVXBCOG1r?=
 =?utf-8?B?RjRSckhjWnd3SURlbGlvTy9aSXAxZSs1NXVxeW5PZGlLS2dYcnl6WEZ3b0RC?=
 =?utf-8?B?RjZjMFU1Y2pSbm8wQWR4Q05jNW5JSFdXZUNEdTM2LzZ1OHhPZTJJQlBFRGpF?=
 =?utf-8?B?U2xGRnVjRzlncUxZZHBYK1ZtcjZiVWxjRzNYejUvYm96VGN0czFSVUpTcVo1?=
 =?utf-8?B?b1o5ZWVLa1VMU1JkNzMvR05Zay9NeW5CVUJXTUMyUW1qVkxFZlRyNnFrVlNx?=
 =?utf-8?B?M2liZnQ5NTBtU2ttS05jVUZ3eEwycW04K0NvdERVODRtVXd6b0lVb25vZExX?=
 =?utf-8?B?OHp3NlhwYVNMWG03amF5R0hYeTRSY2dnKzViWUdaTEkrUFZVdzZUTDBhMmNr?=
 =?utf-8?B?MmM4ck0wTVFmRUdrMFNvd0JnTUF6R0lseHYzR1dNVllMNFRWNDI1Rk5lSU9N?=
 =?utf-8?B?RVF6M0pzVys3M3dzV0lSNVdONnVESnRTdmF5SWZyMlZhTHhqRm80MXNJMmFW?=
 =?utf-8?B?YUdlQ052VGp6YnZsNS82ODc3Y1hOenhqdnE5ak9TejRmZ2d0TnZzMGk1YTNo?=
 =?utf-8?B?Z25hUzVoTUZJY1AyMW5ZN0hTL2dHaCtTSUsvQUFpeDhMbDRMSktsVkt4MjdV?=
 =?utf-8?B?ZmVRL0IvdGdJckhJUWYwaGJxY09tS3BTblM2N3BmWjZzeTBFT3RHYnJiZlZ0?=
 =?utf-8?B?ZjU4NWNYTjF6WTJacWo4OXROa0lXNlBtUjZreWlhK2NGNldKUGZCOTZaODFM?=
 =?utf-8?B?aGp5dmRucUZoV3RYZldHODFDWFZ4SHdJd0dFR2tpYU0vV0FKQ0g1Z2ZpTWk0?=
 =?utf-8?B?VmwzRWRSMjMvdWlTU3VrNTRBSEtBU2dVRkR0UWVmak1RVkhOMTdjazR2V05K?=
 =?utf-8?B?YVMyMld0blFzeTJTUmlUVmNrdlhwR1VMUHRwaG9PL1ZEallNRHl0b1FxcGZy?=
 =?utf-8?B?M0xPTk0wZkVvQTRvMzJKM1Vhelk5TlEwWHJGU2pKS2tiODYyWlpkTGZzbWNm?=
 =?utf-8?B?RGhIYjRHTkszZlFFNjQ1UU1JUWtieTdaSmhIWS9NMllUaU9XLzVzY2YwZmZ4?=
 =?utf-8?B?NzF0WDQvSjYreWgxTW5BcTRRVkVieDlaUGlNQzVMR0cwUjZaLy9zckFqVTFD?=
 =?utf-8?B?R2wzQ21OQ0RWSFN4bDFDWm1PVDRCTVJ4N0oxRmxCZXRsS2F1SUlCSEhSYU1y?=
 =?utf-8?B?NzVJKzErZ2FDVEdVNUFlYzB2YlNFWTVZeDNoUnhiUVJNRXllclN2UEpNRHhR?=
 =?utf-8?B?TS9HbnJGcDBOTkF1YU5vUHRQUEhNekxlRlBNdXcxMTZzMlljdUFkVTRqcEhB?=
 =?utf-8?B?dGNtTGw3aFpNZHppa2xMYjFJaEhEbTJOS25vbmI1bXNFUTFhS1NtL1FjcktD?=
 =?utf-8?B?ZCtldXlUNEdjU0VhUXFzVVo5M1BNb2kxeEQ5aG1hU1czbXA0bzg0dkkyTURz?=
 =?utf-8?B?UVUzbjc2azRieFNJWXVrRVVhTHF5RXEzUUxHblhQakxWTzZLYlZWYlVhS0ZS?=
 =?utf-8?B?OFlRNjZiUDBqYU02QjZ3MnRuSkJVQmwwR2NBQ3RuRU50SGxBQ0JVRXBFdklm?=
 =?utf-8?B?emdwTTNNT3o0ZSs2bXo3QWNiZG9YQ1VSL3BXYVBXVXdVbDYvY3c0aFRuOGpX?=
 =?utf-8?Q?8xJ07Uig5GAuu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:41:56.1569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44993453-8bdb-4c04-b35a-08dce889ab5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID, event pair and monitor the bandwidth as long as the
counter is assigned. The bandwidth events will be tracked by the hardware
until the user changes the configuration. Each resctrl group can configure
maximum two counters, one for total event and one for local event.

The ABMC feature implements an MSR L3_QOS_ABMC_CFG (C000_03FDh).
Configuration is done by setting the counter id, bandwidth source (RMID)
and bandwidth configuration supported by BMEC (Bandwidth Monitoring Event
Configuration).

Attempts to read or write the MSR when ABMC is not enabled will result
in a #GP(0) exception.

Introduce the data structures and definitions for MSR L3_QOS_ABMC_CFG
(0xC000_03FDh):
=========================================================================
Bits 	Mnemonic	Description			Access Reset
							Type   Value
=========================================================================
63 	CfgEn 		Configuration Enable 		R/W 	0

62 	CtrEn 		Enable/disable counting		R/W 	0

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

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Update the configuration notes in kernel_doc.
    Few commit message update.

v7: Removed the reference of L3_QOS_ABMC_DSC as it is not used anymore.
    Moved the configuration notes to kernel_doc.
    Adjusted the tabs for l3_qos_abmc_cfg and checkpatch seems happy.

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
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h | 33 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 43c9dc473aba..2c281c977342 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1196,6 +1196,7 @@
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
+#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
 
 /* AMD-V MSRs */
 #define MSR_VM_CR                       0xc0010114
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 86e3e188c119..de397468b945 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -602,6 +602,39 @@ union cpuid_0x10_x_edx {
 	unsigned int full;
 };
 
+/*
+ * ABMC counters can be configured by writing to L3_QOS_ABMC_CFG.
+ * Reading L3_QOS_ABMC_DSC returns the configuration of the counter id
+ * specified in L3_QOS_ABMC_CFG.cntr_id.
+ * @bw_type		: Bandwidth configuration(supported by BMEC)
+ *			  tracked by the @cntr_id.
+ * @bw_src		: Bandwidth source (RMID or CLOSID).
+ * @reserved1		: Reserved.
+ * @is_clos		: @bw_src field is a CLOSID (not an RMID).
+ * @cntr_id		: Counter identifier.
+ * @reserved		: Reserved.
+ * @cntr_en		: Counting enable bit.
+ * @cfg_en		: Configuration enable bit.
+ *
+ * Configuration and counting:
+ * cfg_en=0,            : No configuration changes applied.
+ * cfg_en=1, cntr_en=0  : Configure cntr_id and but no counting the events.
+ * cfg_en=1, cntr_en=1  : Configure cntr_id and start counting the events.
+ */
+union l3_qos_abmc_cfg {
+	struct {
+		unsigned long bw_type  :32,
+			      bw_src   :12,
+			      reserved1: 3,
+			      is_clos  : 1,
+			      cntr_id  : 5,
+			      reserved : 9,
+			      cntr_en  : 1,
+			      cfg_en   : 1;
+	} split;
+	unsigned long full;
+};
+
 void rdt_last_cmd_clear(void);
 void rdt_last_cmd_puts(const char *s);
 __printf(1, 2)
-- 
2.34.1


