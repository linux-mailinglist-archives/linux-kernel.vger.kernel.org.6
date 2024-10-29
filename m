Return-Path: <linux-kernel+bounces-387843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9359B56CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715CF1F22B65
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B8920C33B;
	Tue, 29 Oct 2024 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VA8dp/HK"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC620C03F;
	Tue, 29 Oct 2024 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244262; cv=fail; b=bd8ehJeWihCp10tvnN0seLexIqhUWYAgZt2gGtTkD6ZgIu+W0tgmErxW/do95MYfMd5kPbjAiz4Ppzcmf0S2QRUTtLoI7GoKYnB/UPWRaf/QL/sRc/r8NRYiwQG3R3L4dZYsjC43hv7Ps8xZiliAmt8ZhZiItLZl9FtNWw3Qm88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244262; c=relaxed/simple;
	bh=DQSyjovpsKAAF9YWLoG402aT+41YfWyK5PUh0NDD0oc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzHAgmb2qEz97+UJD7r1PZTpUHzPxu2QIrQUSX5yz9Zf0H0Hr6YnASE/qMsyQiAboQ1+IMj+6uhXrsXyJweH2725a0JcXEb3U5fyEUzLoOTZgf0PxlQkYokq9ERCaKU+9ZCY2TNIJlQmcJG6V7XUsO/d3lwnZCVI9yOq0SoYn/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VA8dp/HK; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWXyFABW/P7bjMYfWYe3CtqQVa+KFCXxHoB4l0cc6ACqlDNQqFRTxrFvV+N+KNDgwMOlGE5TbowlNi9UMOBxjgdCOPAbTKz1m0EMLdJMihGfY9r2VVn3MRAzEluzUD5fZNr7T9xzE9SNZYAz2tj+C59ezF9xSNajDW67JRGohnaW1TrEwbW14VtA5ciMTBfoIxViB528UW6tax2laczFJe0INNSheZxSbBRC2x6HPnW7DOVV+wkifqpqYJafERA2HZK+7gyEyS+L1qgG1kQ+cRtmMKns4KIuYISszOrPPW0e5ypIJkxwJfuOzjlSwHab3bJwXSYPw1jkDrNxU2UVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h931puc7XL6ozQDQZjdsjRZnMopFuKOqaDWmB4dMLZE=;
 b=apMZNIhoUsmc2v+fZQyZO2Io+Y5DMUJNsJ1GjNIoWQndNfaEkXtGWKUjgWzzGGLd2V6Fl4a7yXeIufR7uTurJWMeRODoIR1X4u0sXMgf+fTbcNBNaYwHQl6OejcrTX5KVeReIneqwg2HC2m81Y/z5OKwjFKnWfb8b7FbYKdKjUevqJwOsmgU/hRpofsJtUPpLONDHhG393FEtLfV2oCE2a+4FtpLzzeUDZ69Ls/dato93DbRGLayTe6GQNXFVBBfUlhTaoktCa3P3NyvdTyTnPNNi6d1UKsElu13/4UT2HMOXYwm8oL33tcvYGrs8JE1dCdQm8a8HuXsUZFFuxsoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h931puc7XL6ozQDQZjdsjRZnMopFuKOqaDWmB4dMLZE=;
 b=VA8dp/HKOiwcZWPLEWUP5wuMWLJbsSeB2ntgWjVI1P5IPvZa3dPg5qpC5djMXgQBWG6jn5EcSPbbr0ReKWCVHNmgl3qWKUaQUMUriWwJrOHk038oj0VWdYLDWvEjFLQNrbr/2NRAELVkYnLfEvRxEUADapCiqqhNILpiyh5aTEQ=
Received: from SN7PR04CA0222.namprd04.prod.outlook.com (2603:10b6:806:127::17)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 23:24:16 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::69) by SN7PR04CA0222.outlook.office365.com
 (2603:10b6:806:127::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32 via Frontend
 Transport; Tue, 29 Oct 2024 23:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:24:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:24:14 -0500
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
Subject: [PATCH v9 15/26] x86/resctrl: Add data structures and definitions for ABMC assignment
Date: Tue, 29 Oct 2024 18:21:47 -0500
Message-ID: <219cac124638f576cc7a9c5a14207f8c018e31f1.1730244116.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730244116.git.babu.moger@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 856d1412-dbf2-4dab-fe01-08dcf870ce9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDQvbytXNXhGaFdmNzloOGtTajdna0c5Z1JXUkxEeXQrVkMvTy8yczVrbGg0?=
 =?utf-8?B?R2pEcW5IUWpuR0JjcVhITDV2d0RmbjJGZXE4MmJDQXFoQ0hrdFFuOXdVZXVF?=
 =?utf-8?B?UmhqL3BNeUZUaTljL2RjMUNOU0tSajBiSmUvblpNd2tpa3VmOVdUWERqMTdi?=
 =?utf-8?B?YWd3UkpKNnBuQlVmQWJoVFA5WW03ZThsYjBRMlpVZFpUNnJBUENadTd0eXJr?=
 =?utf-8?B?UzVWVm9qNVAvRDRuTUd4RmNRQzU1MU9wTkhVZk1KdHUrSjhlY0VCbU9wWlBy?=
 =?utf-8?B?Vjd2TEd6ZjZrdUxwcWhrSnVvL2k5Tml1M05FTW9zbWNVLy9tRUJ5b3ZldXQx?=
 =?utf-8?B?bmJXeEhPQldyZ1FBSzRzOVNqWnFIc3JjU3k4RzMrUzBacU9OQlZLZXBKOTFz?=
 =?utf-8?B?TDhUVXo2dEdhTG9SRk5rRnRTNG5HZS9jQ0FwYXltVnB4ZmVnOHlwRTM3amNF?=
 =?utf-8?B?dDdpNUJTRTNVeHlwQVJFSDdJSDEvc1FQZXB3VWIxTmVUWW1LUVYxTkRSRWVh?=
 =?utf-8?B?TDhKQzRDMCt1U0ZHUGFZNzhJVStUQ1dBYWNZWG1CeWQvamoyNjhabUxmY1kz?=
 =?utf-8?B?MjBPS28zNVBMM0hPaG81NWFNb0hFMjRvQXJWUjhvNUQvb2krbWlVcnM3K0JN?=
 =?utf-8?B?OXhqalkrb0d6YisyVmg4MDFDd3hVZ3RyaGFLem1PWFlnMGxHdVlVVEZRa2VD?=
 =?utf-8?B?V3RTVFYyNjRLZUE4YlQzWkpJODVQRTZGMWpxenlBTG1tUXFoRWFoRWM0eXhN?=
 =?utf-8?B?ck1HdERXMkV0RmlCSEtmd1dKc3I2UlNWU1NiV2xidS9xck5wWG9oVENIQmQz?=
 =?utf-8?B?TkZwSnJBdXM4aXp2V1Z6cmpMalBnNGtnUm5pZDdseUFMZnFGeE44bWM2UVZV?=
 =?utf-8?B?QzJ0QzNmNUpxbGplM1M2ZFpMd0g2bEMvdERPdU9KSkNMU0xpdGt5c0Y5OXla?=
 =?utf-8?B?VG1Renprc0x5YmVFdzJMUzVhMXlkUVEwTm16aTcrdVRuei9ERjliaHozclox?=
 =?utf-8?B?QkV1czFVTW5ScGIweG9OMDY0dkx3b2l5Q2hESkJtU0pDeUdPL3cxQjF3QUhD?=
 =?utf-8?B?d1pIOUlpdVIwL3M5MkUwZVZHbmdpTW9vbmtxR1ZadUhML1hoaEV1bXFVQUNK?=
 =?utf-8?B?SlBrT0dBZ2VaNE1uZ3k3STNWZU5ESEJGOVcwRUZkdGdDUlBFQzlDK2w1VnBY?=
 =?utf-8?B?ZmowbnVzOFpFdVBhaytvZTdWV2l2SHR2V2V0YktUM25LdE5EakpFSXFiRkhn?=
 =?utf-8?B?R1BFdDhEbnpVZUhRZXRwaWI3YjgyT0NwQ0JvMkYwSVZ6MStjT1RzNmtJT09O?=
 =?utf-8?B?b1V4VjdDcWV6UUxKVkV2TUFZM1lIQ1RrQ1RuUW0rOTJZeU5mS20xT0JiaVlu?=
 =?utf-8?B?SzZSYlFiYlRFQ0NCbWhnbmsxTVc2QmJpSW14bmV4NEF3MS9iYy9xeTZBcUE5?=
 =?utf-8?B?NkJqK3cxZE9RY1I0YWhNMDkyOWtJeUFGUGZoeHRmYktxdmZOV25Wd2VNR0Yx?=
 =?utf-8?B?aGxrZkdSVmx0WVI5d2JZYlMzc2lkeVRzaWlpQjZSYjZ5S1l6UmJ0UDBzYXBh?=
 =?utf-8?B?VWpXRCtEV3pKUlJBQ0lMTFhVOENuWk5yeTh6d1NhdVlLM1l0QnhnNkFja29C?=
 =?utf-8?B?T3U3RjBoY2ZOR2I3TGtvb0E4a20wQjNxY3F5N2p0ZXI1VDM3ejlpRmZrNEFL?=
 =?utf-8?B?SEZlU0htWHZzM3J6SlRlNUduYjF1WThaVFhPWkZDRzNlYlBVZnk4UU9UemZU?=
 =?utf-8?B?VzZMVFkvWXR5UXcvSisxcWRSNmtDWjd4RHhURHFzR2RJUk55bkVvWkdFZ05R?=
 =?utf-8?B?b2FiT3RnMWI1bW15MC90Y2NPbXhCdGFBc1pNSncvKzFISXk3WG92WXpFUi9w?=
 =?utf-8?B?ZmFJR1dvb0NDKzJWVG5yWUFHQTNFc0FvbHZ5bkJtUnc3UVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:24:16.5276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 856d1412-dbf2-4dab-fe01-08dcf870ce9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076

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
v9: Removed the references of L3_QOS_ABMC_DSC.
    Text changes about configuration in kernel doc.

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
 arch/x86/kernel/cpu/resctrl/internal.h | 35 ++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index bdc95b7cd1b0..d7dec2326cd8 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1194,6 +1194,7 @@
 /* - AMD: */
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
+#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
 #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index add8e84b483e..5895ea72fc26 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -602,6 +602,41 @@ union cpuid_0x10_x_edx {
 	unsigned int full;
 };
 
+/*
+ * ABMC counters are configured by writing to L3_QOS_ABMC_CFG.
+ * @bw_type		: Bandwidth configuration (supported by BMEC)
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
+ * Counter can be configured across multiple writes to MSR. Configuration
+ * is applied only when @cfg_en = 1. Counter @cntr_id is reset when the
+ * configuration is applied.
+ * @cfg_en = 1, @cntr_en = 0 : Apply @cntr_id configuration but do not
+ *                             count events.
+ * @cfg_en = 1, @cntr_en = 1 : Apply @cntr_id configuration and start
+ *                             counting events.
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


