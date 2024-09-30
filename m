Return-Path: <linux-kernel+bounces-344339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DBC98A877
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18342817BC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA40198E9E;
	Mon, 30 Sep 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0v7+stI+"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAA4198A06
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710110; cv=fail; b=KcJl6BaUmZ5Cq0RbytTbqljoF9fqN0TlX6HcM/Hu1ThZi0Bj/ons266+kdPPJvXhW05zSfcVJF/ZAnFEbUHNDSCkCSoG1gBE54xLdLK7+px8tkoBaIpGDOkjbVLYLDF2XT7p/vjtohNGuxH/nJ9rvP1kJhD0gtaoOes5fCCm8T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710110; c=relaxed/simple;
	bh=T+AuwQVlO4kVy2UTybr9Ssl+QOUDs4z7w0Yl9022B30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNg8SAswNHii7smDC6hRW03Ti2rdBfcqKLpbl1uJRDGeS6/vkhww5lQoT+E7usFRvmsZ5RumBr4n72B1kI4RoW+jeomSSd+y80BIvrX6HXv0zb3A7TfawRtbWMad5E102DTWZcum5eLzNXbr7P6tQBwWJajPgCp8NRB9kn9eRVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0v7+stI+; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFx3m9avdXuU0T3fvmJD9djfpOksAxSFMLzGCJL1ToNENwbvzK9h8iO+v4FWi8CZ3VLpb1+9J0/GuNTZgnbvjSafmVPeDOyruG5oJiq/ZU4i8niQ4l2X0rEe1Qlrsz/wRHr0MeolrZoEuWQd8unWPi/Y1je67BLqgqJaxIpt36vMZTaN5yGcKln4zJlbMmdkKL2EkytIKY5KbLKMac0rT5qPS25BK6T6NikxIdvbQHoB4v/Vnox1BFyY1YpWgYxsHjlfQUhyzGo6QLcM0U6BHmu5MXqXRmxeq4rALvXYYf5OBaZ3XcG59j2oHcUl80qXf8mPeN5tlFhVyJIXTD1E1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNzdsdorqmzdI1TX0wknVPixlglwQ7l2/ZAdfw+j/XY=;
 b=H4keKiYWU3EUWWkWif4cwXs7eiOoLr50QFAkCRK9ExeOAxnWfUpOZElpEsxh1MrcsB3wsdV2Zp+n1MfAXL98y2J+Fu/y2fD5/uyh5s4N7XvdQMJPfHIkH4WwKA9FopgQdHqq3vSdnEo4kiW7CFWoArI0j0OUiJmjCsnybz66Z3wGBS+jjgE8RY2+6yr0Y4FlVMrETCZzYRcNk5ao8LKCLOimnWybA0fUK8NiY9vO//1BcYScEtT9LVFy035PVxTf6QQLuF+8cb2KKHcwZH15gS09CtLbC7nIdyo+FpaqJOaGTZHKtGiYZ7w53eV9ONMTpC6MRpIMJPLsJjyV6oJSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNzdsdorqmzdI1TX0wknVPixlglwQ7l2/ZAdfw+j/XY=;
 b=0v7+stI+3GtZ3+d1KIdKB14P6eUXGOZaOE69Rc6Fqj4SNEH7l8p3ScNiEX+4omqWdkSmDgpwr7RZKHezaAR1HOBAdwEaGHWJL8jCtvUIsMFq+I5zg2cIr66FQCAiliCxfdkJIukI4Y7uw4XlkgrJn1uKm5wton1DHJquZcaSdgw=
Received: from DM6PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:100::22)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 15:28:26 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::39) by DM6PR03CA0045.outlook.office365.com
 (2603:10b6:5:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 15:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 15:28:25 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 10:25:26 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 2/8] x86/sev: Add support for the RMPREAD instruction
Date: Mon, 30 Sep 2024 10:22:10 -0500
Message-ID: <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1727709735.git.thomas.lendacky@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 89594ea5-dda5-4387-2e98-08dce16486c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MalnxV2oO8f+8fgPuJa9+xwVh+ceCSkEJbjaEbfNuu0G1VVTciLlT9yH92vD?=
 =?us-ascii?Q?HuTGc7Mzsp2RGLFppw8SRQVrvB/DYfVBTTNGkmZqeiQdnUzc1N1rb/ZtGkpx?=
 =?us-ascii?Q?NiGZS32PD1++aDdd5LVYQBLwDj0qEiJzBpe1RYDaGu13LG8RQXbyOZOLNQzR?=
 =?us-ascii?Q?g6vdVZDBeU6oG3jHohGmL5PW6wcj4UxMyD2P39d8KtGpmT0kCuKI7emFLfLx?=
 =?us-ascii?Q?quwJul3FJ7q/hoKywYwaSK4+NL7FMdBzpka/OXBaKVK7KchiAG/AnUXuSxxb?=
 =?us-ascii?Q?hAjZX4pcICKCQoi0iSVMPMD0BOjKaxSYkES5JOgo7X0kOiBkO1BHMBIAhaMR?=
 =?us-ascii?Q?fsEsQTiJ64T40Ul6r5iSxMdr//wgDANl6750HVWBkg1hIwuFBFb6+i7USyZQ?=
 =?us-ascii?Q?+FCWJUgJbslZbA4GwwDNDKx2LEFXuc4ItG/b6sT79yYYKT8fG2xAImcasL2a?=
 =?us-ascii?Q?eZrgx3sogTNyuCW/YdXK6VpS95n+J9nNOuxxMfJrWRP7VzUSvJZB9+xLuAxJ?=
 =?us-ascii?Q?LyNgKsixlmqBt5fzq31XvylBcJoj9R6p/GyFNjJyCcIpXBtfDmTLOYdcUQn6?=
 =?us-ascii?Q?wmB4FceFQq3shhrUTKFQCH/39H80yDjeiyilyOrWIZuBfJZJxvZ8nupWYt/W?=
 =?us-ascii?Q?LkI1lRGQJlQJSaW7cTdcGAJeU1g56ZBhKRjjF9ZNTzN54JE+jLUzinheBgOp?=
 =?us-ascii?Q?MJk5CzbDp5VTmH2R8dbacPwhgB/ubxIU4Aw4Hzt+RSf7S7ouNYc4e9eJiV5E?=
 =?us-ascii?Q?IHIl2a5gB7NxtUc/Sp5VPGq+vhzY0Vumw/JxZS84ih3P9Skb6kyH7gLV/Vnn?=
 =?us-ascii?Q?P4LOiSm60uqvfxxaTMSjowmBTWBGyT6mqrW8+JksRhw/8hptVj0Ttgb84Ts2?=
 =?us-ascii?Q?B+KsBHsLLsXAHA/GKD+OcxxAAevQOYzNdqQrKDkDWAidnFsaCLup5E/KMXYZ?=
 =?us-ascii?Q?5gQOH3ctolTs9gQ1iJx16h/zD6fswyZ5khyrYRsnwNh0vu7MMa5bs3nQMrad?=
 =?us-ascii?Q?bkfkU2do6P0zwQ+trlYYNkDWPhiNHk0F6v6IN+uHegtiWWr6RWoD4HcH2uf2?=
 =?us-ascii?Q?3uwbn6liLohCxkwo2P/GY2K9iO3yxmwhkHz1sTm2eWx94XIlQgkRs/xhJOR8?=
 =?us-ascii?Q?O+9At14+pzGBLYWnZOlqB7UR6Yh6Xo2s9DM43m3zny+SsAO6j/bR+EfK4T/S?=
 =?us-ascii?Q?Yz7kpMDesIf9oDQ8GOA7mRm48vZWRdJXKtl2OJMoZIW+hNzlzJ1jc5HEU/mo?=
 =?us-ascii?Q?Pc8Ne3uctzXCu9r5FwEI5Pytev9a8YMwul233FkciJAKfPR2nCNXjJK6w+Jw?=
 =?us-ascii?Q?bIo6GXcmnWOu8DFj18NKRp4IlDu5zWcaAKLOVrqBieKdknIJdl5cJh32Vay7?=
 =?us-ascii?Q?Mfd6mzfNCBeFTmq93phsxmI2rhDz1uF2NpojHcQ9oYAO06pkPsYr8LZ8vKvx?=
 =?us-ascii?Q?JEQZ8j75HN92YiJJoLMDREvqtAO2KGYF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:28:25.0051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89594ea5-dda5-4387-2e98-08dce16486c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812

The RMPREAD instruction returns an architecture defined format of an
RMP table entry. This is the preferred method for examining RMP entries.

The instruction is advertised in CPUID 0x8000001f_EAX[21]. Use this
instruction when available.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/virt/svm/sev.c            | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dd4682857c12..93620a4c5b15 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -447,6 +447,7 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 103a2dd6e81d..73d4f422829a 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -301,6 +301,17 @@ static int get_rmpentry(u64 pfn, struct rmpentry *entry)
 {
 	struct rmpentry_raw *e;
 
+	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
+		int ret;
+
+		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
+			     : "=a" (ret)
+			     : "a" (pfn << PAGE_SHIFT), "c" (entry)
+			     : "memory", "cc");
+
+		return ret;
+	}
+
 	e = __get_rmpentry(pfn);
 	if (IS_ERR(e))
 		return PTR_ERR(e);
-- 
2.43.2


