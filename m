Return-Path: <linux-kernel+bounces-443894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870A69EFD43
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36D11883791
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E581D7E21;
	Thu, 12 Dec 2024 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zrH67MDu"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C41D79A0;
	Thu, 12 Dec 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034682; cv=fail; b=HDPqpN6TVpx2emYlVVCz2u2cSZ8ImqnwHGDBTShS5ZKKMdorCZpwrphxKrAOIfvuOOOqVrOz5vVPW67BZ9z6Ctrdc9fffE2rXytEgFay+/GPUjsEr2O8cWIfgyvZEg/ZiLWmyVsftAAd2A1Xtnv41lbp1ztRt3jTUUoboGCL/pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034682; c=relaxed/simple;
	bh=9lOpZUh2druwAdeXOeshaGDfc+LGthvTEnn+heJ6wfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T873TBRZyzM9jU39zAR/wZr5iLTb9GJDfq1G76Z03FTZZR97UQbj45kjeKHo6Fiu7nCjXHUoy3OQrA8nAgk0StijmkzGOrxSyqCZbnkR3uYxXJEvt09pYih3ZrAwzTdyOMg8AhZaadLM6BKQ5avesCtLceaOYXlcrIE4vm91l4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zrH67MDu; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0k0URox+ybfIQb3Pq8OZDmCuYHiihZNfTE+FNC72hJ5rbOeqeNBL1NL5e4iG/NiOrncBAUmIO3tLaiOF5GuDjbGM1NQLPdJ4D1RVLc5beUmg/OERuhQqHZGIIzEN/v49WP99z+MMVyaCYffI7L/YcpID0T91UnebZgnVDrBZ++1113oSFhSLg9AGryJoW7k4OM9iSuBtJsaUoZWnkbA7yZUNLfbbSUhai7RbkWtr+IKGHjO1VnkWPRA1LZyNJif1O4YKCZE94aXAAWY4hsFM0dXZEsjJcR1c23w9H3E6FlBinmRSFBeekVopVl8rU/JsLV94DDMjXsJiMwYqO4qZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fHTms6cbIda3QGYshrPttozfkvBeBgEHTm8IaatpAo=;
 b=RzJevC4pBSntfuv/h6g1AfNKSWoufjsaaAiIZgc4BLTnIb0lV3C7KghiAR7XNHR4aUTFxDV4y1AOtw4A+wJTQLC/G1oG4rLnv5A9ZMBMVd4lvo3b62vkpFysV4TXPGKWh6tYd6QnaGkXwF9N5eyw7tB+ROUFsQ6EfWCnTP8ElM34By4DNwQQqHzZBsHi4eml1zixeBc6nP+LyX9FL7wit49uJn3nvZDzMbRBxYrTBOUVERmBeK64huifvJOstkZukQ5KxQoTG8g442/r7apfBcuzreesb4J1w2E+9oVHuJK6Z+R+tkb+dps13ohH/jQ8/12yUFgAO0V9ex6xdxZZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fHTms6cbIda3QGYshrPttozfkvBeBgEHTm8IaatpAo=;
 b=zrH67MDusnINqHANCR9qOq0N0j8Qudrjgrl7/iIvAcUJrMZmaEouIYNPLK3WlUgGAZdHYJpR54Ef3+rZEvlyAvsjIQ2BF/PASKqBs/soXo/fi7HxwzcH0gzyEhcuZ0xXxa6BtQpeDuf9i29w93kBGBpZHja0HvSQVwDQBXrQXYw=
Received: from MN2PR12CA0007.namprd12.prod.outlook.com (2603:10b6:208:a8::20)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:17:56 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::ca) by MN2PR12CA0007.outlook.office365.com
 (2603:10b6:208:a8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 20:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:17:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:17:54 -0600
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
Subject: [PATCH v10 14/24] x86/resctrl: Add data structures and definitions for ABMC assignment
Date: Thu, 12 Dec 2024 14:15:17 -0600
Message-ID: <43914cc9f1fb21f171827fbc515009665410a8bd.1734034524.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734034524.git.babu.moger@amd.com>
References: <cover.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 251f1640-e918-41df-8f54-08dd1aea10bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejluR1ZRZ2FlWERFdU5XVXorRDloMzNiRVVYMUtCY2pXZVV1VzgzT01EMTVV?=
 =?utf-8?B?Y0VNd1Q3eWltNjUzOEhJRmxNUW1RTnp2UjNyc1E0TW9lTFFqQnZsMStOMGJM?=
 =?utf-8?B?NWdCYklzdXdKSFlXa3drbTM5ZHA4cmhMS0Q4a2hYTHlZVlBwSkJZSFhvbng3?=
 =?utf-8?B?NS9lemU0eHNjSWs1TXBjQ1lLa2M0UGp1WUgxMkllNkFoKzRRNTZ2ZTd5RjFI?=
 =?utf-8?B?NzNoOGgwTTZOcmtrS2tGYmZyL0UvMGUvM2Y4MEorM2dlZmkyanNTUUtMMVJP?=
 =?utf-8?B?akNpc24vbjA0bGJpTmFRRFIvd1BmTjdNNlJlT3FuTWp2Z3RzT08vVHk5azJJ?=
 =?utf-8?B?ZHlnckV5ZG1LQ1ZtaVRTNkplZFQvNEUrdDVucTdTMmc4blFtQmt3ckU1S3U1?=
 =?utf-8?B?MHUwNFpVZGZ2OFBYeCtJbkFRdWg3Nng5bjljUHo0NmhIa2p3WmY5cnA5aHFF?=
 =?utf-8?B?MjhFbzZHTitaV29jbUdWWDBEcmYzYkkzeTdSdUwvTG42UmZBWSsva2kyRjBx?=
 =?utf-8?B?YWJUMDBBNW0vdXpYMk5aSDljaWtYNGZUK2xjNHRBYjU4TzVRVUJZeGx4YTlm?=
 =?utf-8?B?UC9LOWk0QysrNHJhbjNRazlXL0t0VjVrb0xrNEl3UUJWUHVPMzFPcXdndElw?=
 =?utf-8?B?S0d6cmJtR1JjVDl4M0c3aHl1cE8yNlN3ZUhSaTlGdjRnUUVpYlZzb2ljY3M4?=
 =?utf-8?B?bXEyMVVMUmJWQkowZisxOGpOWndQdU04ekFTZXp0eW9OOXdqeFArbGMyMjAw?=
 =?utf-8?B?dFZFeUFTUm1sb2NKekMyOFJBR3FFUHZJNzVud3ZRamRWc04yVGxUbDZicElu?=
 =?utf-8?B?ZGlaYUtjYnhKSmpXeE5ibkVsTkVQT1gxNDRxV0pkWGU3WVhiK2dVeGRncUZs?=
 =?utf-8?B?aGdZcTZETE1KYnZLSUdwcGNDYTAyY05OME5scW1TTG9PMDc4aUthcTFXYWN6?=
 =?utf-8?B?K3ByTnp3Q093UlZTNUk2cmxMeXBiTnM0Yis1b1lPV2lFVElDb0FoYkxpeXVj?=
 =?utf-8?B?VnNPbWVCZ0pXNXJGSzZlRDFpK2w4dE5xbmhzR0xLUXdPbFg5aG9ST3I0Zndo?=
 =?utf-8?B?MStSRk51WEtnaGpmUzk2bU5VM25DN0VzVURSSDRtZC8xS1hoRjFKSkE3ZzZx?=
 =?utf-8?B?K2pkSm01b3dBT0N6dTVGTGJIbDlhcWxwc2QyMDdSeDdLZHZicW9pMHEzcy94?=
 =?utf-8?B?OWViVnRMem1vVUxzMlBvbW5FM3EzNHA2dG03eUlIWFZGcDl5SUY2d2VJL3NH?=
 =?utf-8?B?bktBdTJ5RUVJcFdYWTFrbVZkM1dwbVN4TEdOdTdGM2ZEM1Q5NmRjSFF4ckw4?=
 =?utf-8?B?OVlYVGgwb1RVMDZaUUMwcWk3d0luUFJudDJWZG56bHBEbWExUGRocXpLd2RS?=
 =?utf-8?B?T0pWYk50QU1tVXRMYm4xWnJDTlZmTmx4VHZ3d0ZqRUJkektrR3lBV1pNZU9K?=
 =?utf-8?B?SVYyckFmQ1BBcW5kSThISUVrd2szV2ZMUDgvbFdYeGswcmlQZ2cxOWc3dmN4?=
 =?utf-8?B?djN3ZEVPOXUvRmtaZzZScUpOUUtKVkk4NWhvZ2pHbGhnTDFaL2djdk9oV2NG?=
 =?utf-8?B?Q0dKNHZXVjJiMjJPbVJWdmdkQ3dWK0swcWp4REkxN2tBd1RlY2FJdDY4dDdk?=
 =?utf-8?B?ZHRPVnBtRHRwTGwwRkZUOUhjQ0FyRSt1UDNZSmh6WnhUMDFhc1VQL09rdHBO?=
 =?utf-8?B?N1B0UmxKR1hwYkhZMG4vL080WldGalR5OFpxaExnSFpQN3Q2VjlQTmZkaTFP?=
 =?utf-8?B?YnR2NTF5Z0R2OW01YmJuZWVueTNrUUI3cWdhcWd2bDVqcUIvdk0vMUZKRmpB?=
 =?utf-8?B?RW5BVmxjU0RrL0FubVZ2bVV1MmZJSXpMZnJZWEVhbDU5OFpRZmp6QlJLY3NI?=
 =?utf-8?B?S0NYbGhkS0hxVXZyaGdRRkJ2eFAycEZEVTQwY3UybEZlSEwweUcrZlM1TWFN?=
 =?utf-8?Q?lW4dHBULaFjTmS3BLPb57DcgY1ZWYP61?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:17:56.1512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 251f1640-e918-41df-8f54-08dd1aea10bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217

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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v10: No changes.

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
index f864550ddd42..35bcf0e5ba7e 100644
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


