Return-Path: <linux-kernel+bounces-316053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D8F96CA68
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1921C22530
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B94E1898EB;
	Wed,  4 Sep 2024 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TX+fzaoV"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2917BEC3;
	Wed,  4 Sep 2024 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488707; cv=fail; b=EkKywPIc2E5xgmVbIyyxiQ71XQiSSr5rq2abYqCV7inAhx08oH6GZiUjAK2ZBjIOOHacKn7mPcn6+AwNuWDTf+robzRkC3s+1P1f0936rUbcFUbClnxQSlQlsJzLnn0q2iICDO34oMx9EBAPme91ybtnvUE1iI2xtn2XI/+6NBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488707; c=relaxed/simple;
	bh=WUUCNo7VgIl3hkx2Dk4DS0egSMOUiaj5KVPG/k3M8/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnU2obutkvjOOdBD2N2R9K5pUh3E46CNe2acLgvKX+uhyeKABvmFqkk4SImAsm49HqMD6ZHu4tnh7CNuC183ewGRFjpCPBTW9ynXN5LaQu9DvOt1TLXOVwfFc16s5s/4MQ7gfmi17M2GFHlJ7t0Bfk395w8AgElGTy7/I0ju/oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TX+fzaoV; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np8XQtY4Zw48uZ+bs33srU2BBj00LdV2wgIlPs7T7f+MAqeYC4ssQuXtsmROgzWmpc+ra/QUkDApM2yuU9xEUGfEcwxqlwHuQbtp/blwNyYDfqiCaN/H1ZuInoUP/t8fDGuAQHcwxWkMWbqyVI/vi5mpJHYIsbpJeOCO+r6tJmoc08eNc8saCcCnRFBx6t4gT0jqJxYRByYadzyedVsp8npVW/irCOMiDPrKDmOmCM+ZCsO5955gj+3CM83UjA1T5tyBTQFiVdifcTImsIls1yndj7gSOpkQAdwNaQkglWAsz+3CQ9X0kSvOFqwMZSCGKkn10bj+XM9DdZpMpzjtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAnF4PGkxzWSo4A2Ewt+9xOJFjJe33m1uj4pdc7Luys=;
 b=PytbVHFHa2kJJC5GeyEJtuwQoCgOctGJk1Wuxrt0g4hoQTW0oA4CKfPtY2ZQjs/HM1r0EyzpllPDvTPRAJYRKb6ETre9F/vtV5lGb328HKiH/Il6kPEe8xr7boxkbYhrEZgB7P4UG+R619EyJdYEGp3t7u6MyzWWURLws7xT0dkeVfDudg/FQLjb9LqFS6S49X3tR8kzCZBtynq54ZWDY1UlCCMeJS8oBxs8l7Xrsf6vFfJLe0Hs3nnSk2Ra8bkc7aawRTnWvUiRQRnHOPsaHpTlfA+74P9cfqwtySisOuc9Rjpfq7JKRKtO1XY/5lL2nJ7qu7ZCYNAzbjkJM3RAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAnF4PGkxzWSo4A2Ewt+9xOJFjJe33m1uj4pdc7Luys=;
 b=TX+fzaoVDv/PSSpyGNWLztuKpbBP8wqgjQPk3Pyc1weQJp2hGnCrE/yMfNXzrKLSMZXJ+u4l149eQ7YGuTXizmuHxkv7WIcuoFJ5jj+6+7Vw4b0KEto4hpbg9VZ7g7EJq1oTbk2jJ6OtvLaX01xksnAaJXDHfLLRMI1PdZEGDqY=
Received: from CH0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:610:b0::24)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 22:24:58 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::8d) by CH0PR03CA0019.outlook.office365.com
 (2603:10b6:610:b0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:24:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:24:55 -0500
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
Subject: [PATCH v7 24/24] x86/resctrl: Introduce interface to modify assignment states of the groups
Date: Wed, 4 Sep 2024 17:21:39 -0500
Message-ID: <68c8ef0592c653c5b99cd26d982966cd4a41cb31.1725488488.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725488488.git.babu.moger@amd.com>
References: <cover.1725488488.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dcb5d7-4468-481a-8839-08dccd306839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUs5YU04bnZ6VTQzQStHSHVwNVg4U0wyQmNBMjN6R25GNWQyWEgxOUQvSG01?=
 =?utf-8?B?UnZnTU9UK3BCbUE0WGVIS08rU0RnUXliQmhweDhZS09jaEIwS0gzOXRqVEl2?=
 =?utf-8?B?eThPYUhEM0dNUkFoSElVMC9GRFQyN0Z2MlBTNndiQzBlcXg1eTNBc1oxKy9h?=
 =?utf-8?B?azQ1RktiT0pFTllHdDBqeHVhaG10TkJIS3ppSWdVUW1ScTA4NC9mODFsdDA1?=
 =?utf-8?B?ejNKYy9LMDVlWlVxVVltVnF6d3IrR1ZJdXBibStmclJ0aXQxWTMrUDZWL2RG?=
 =?utf-8?B?K1BhUGZzZW9hNVBjWWNvUTJXZERKV2hyQ1ZEVUY1bE5MUytWbkovNXZCbFNP?=
 =?utf-8?B?dEw2b2lUR0N5ZHdnQlI4YWxEeTN0QkFoZkFGRld6Yjc4RnF2YkhiSXlzcHhH?=
 =?utf-8?B?ZG9oMWxaeFFhQ0pvYU5LZEw0NkhQZlBhdGVzV1dEdWJBR0wzTFBya2FacDcx?=
 =?utf-8?B?cHMydTlPME5lRXcwOWRUM1J4MTRlQ1lDVmswc3NpaUNDbzhtY2xaT1hxTUpI?=
 =?utf-8?B?NnlGby90dVo4Z1p3b0JMeGRLN09PR3Z2S1lUekFtais0RmhES2dPaGxpTWZv?=
 =?utf-8?B?TURmVSttVHBTc0QxajV5ZVBsbG0xTWNRSFlHemtwTXA1MDlEZk12MFRYTktJ?=
 =?utf-8?B?RzFkZFgwOE14UVovRlZuZHIwMURuRWtvNHBuZVFyNGVvMXZ5d2huNjR3M2Jj?=
 =?utf-8?B?ZDNGNUJWVFRoSHVjTHM5b3ljb2VLMTk1YzgwTU91bFBoeDUxYWhzVEJmbGFT?=
 =?utf-8?B?TlROWjd2RXdGbnhVdVhlVVZFTk1hTTVGTi9abE1Ocks4M3pRK1dHN0N0c0Jh?=
 =?utf-8?B?SjVMOTVjTUZlV3RUZEdqTklaNit6NG9kRmRHTzJjallTbjkrblM2SnFlb3pT?=
 =?utf-8?B?ZjJpQ1JZcTZ5QWRac1oxZG80anJMTFhodnFxR2Fkc2huRUc2Q2owT25EZTMw?=
 =?utf-8?B?cW10eGFtaTA3a3VOS201VFZjUHhRTzh4NVFGRVJteThtcWhCTnZzQTNBUVp3?=
 =?utf-8?B?bEdsNjVBeUhKZFBNaW44K0ZEYU1OWFF6QWN2VCszU0JlUXMxelpkV2loRENX?=
 =?utf-8?B?ZUxIcDJvU0VZWTc0QkRMM204OXJhZklCbGp5WnozNnFGZkdxcUEvcG1tMDk2?=
 =?utf-8?B?alJWWjYxR0gzTkordGJybmtxRlF0UDIzZm5MaTQ0RHZvakNySjdZTzhKdk9E?=
 =?utf-8?B?TnlTRVpvblhpQUtGdEpDbStnNDhPY2kvQ1VZS3ZKaFl3cXQyL2tsVzljSzI5?=
 =?utf-8?B?emRFT05YVlo1UUQyQmdvalc4clZkdXQxSXhkWnRnclhyUXNpUHZUalhpQ0Rv?=
 =?utf-8?B?OFUvV0h4MHdKc0JYRVgvZ3FLbDdYNUJJRDVWVXVIczArcFlaRUNQTzJuNVhK?=
 =?utf-8?B?bVlVTGVIZmh5N0dZNkFBVFBPNzBXbzVBT09kOC9qWG9KT2F0amJqSklQVUNz?=
 =?utf-8?B?QlZZd0wzUTRpL3JxSzZXd1VPWGhwNC9ZbFo3M2xhYThybnF1dzlZdkxydGo0?=
 =?utf-8?B?YlAxNjA0OHdhM3ZuTzJyT0RTREdIeXlSdnNCbm9Sd3NIV3VIWVJsZTQ0Q1hN?=
 =?utf-8?B?Rzg2VGFmSzZjMk12TmltbDJBYkpDaGRnNjJkZ2VZdGJtNEFFbC81L24xakly?=
 =?utf-8?B?YnR1YXZraEE3Z1pSUzZKTkhJY0Rka29aQVZJNEZlbm13S1lIaWpiNGhoZE1Y?=
 =?utf-8?B?VUM1eU96ZFBKbHNhOFExckNFWjBya0t6WVpHQlVObVRaVmlBRURKWXZxdTRV?=
 =?utf-8?B?Q0RJYUk2TG5BeTVmVGMxZmsxcDErbGlYdlhjeFBuRnBLZ1loMDZ2bnJ3ckE3?=
 =?utf-8?B?OXIwRHc5ZWJqc1QxNnZSSE10T1Bja2RianF4VDY0WlVhTWJ6MjFjcTZ3UnZU?=
 =?utf-8?B?YlRWM2N2eWVOVlhmbm42cTVkTElKWUhFdFNCTlNVMDN1RzF2TjBVeitUcEJj?=
 =?utf-8?Q?11Yh41ln9l2aLWaEmSnue1wYj/Le4Pki?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:24:56.9242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dcb5d7-4468-481a-8839-08dccd306839
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227

Introduce the interface to assign MBM events in mbm_cntr_assign mode.

Events can be enabled or disabled by writing to file
/sys/fs/resctrl/info/L3_MON/mbm_assign_control

Format is similar to the list format with addition of opcode for the
assignment operation.
 "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"

Format for specific type of groups:

 * Default CTRL_MON group:
         "//<domain_id><opcode><flags>"

 * Non-default CTRL_MON group:
         "<CTRL_MON group>//<domain_id><opcode><flags>"

 * Child MON group of default CTRL_MON group:
         "/<MON group>/<domain_id><opcode><flags>"

 * Child MON group of non-default CTRL_MON group:
         "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"

Domain_id '*' will apply the flags on all the domains.

Opcode can be one of the following:

 = Update the assignment to match the flags
 + Assign a new MBM event without impacting existing assignments.
 - Unassign a MBM event from currently assigned events.

Assignment flags can be one of the following:
 t  MBM total event
 l  MBM local event
 tl Both total and local MBM events
 _  None of the MBM events. Valid only with '=' opcode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
    Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
    Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
    Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
    Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
    Removed ABMC reference in FS code.
    Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
    Not sure if we need to change the behaviour here. Processed them sequencially right now.
    Users have the liberty to pass the flags. Restricting it might be a problem later.

v6: Added support assign all if domain id is '*'
    Fixed the allocation of counter id if it not assigned already.

v5: Interface name changed from mbm_assign_control to mbm_control.
    Fixed opcode and flags combination.
    '=_" is valid.
    "-_" amd "+_" is not valid.
    Minor message update.
    Renamed the function with prefix - rdtgroup_.
    Corrected few documentation mistakes.
    Rebase related changes after SNC support.

v4: Added domain specific assignments. Fixed the opcode parsing.

v3: New patch.
    Addresses the feedback to provide the global assignment interface.
    https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
---
 Documentation/arch/x86/resctrl.rst     |  94 +++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  10 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 234 ++++++++++++++++++++++++-
 3 files changed, 336 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a72cb3a6b07a..e46ec63d920e 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -334,7 +334,7 @@ with the following files:
 	 t  MBM total event is assigned.
 	 l  MBM local event is assigned.
 	 tl Both total and local MBM events are assigned.
-	 _  None of the MBM events are assigned.
+	 _  None of the MBM events are assigned. Only works with opcode '=' for write.
 
 	Examples:
 	::
@@ -352,6 +352,98 @@ with the following files:
 	 There are four resctrl groups. All the groups have total and local MBM events
 	 assigned on domain 0 and 1.
 
+	Assignment state can be updated by writing to the interface.
+
+	Format is similar to the list format with addition of opcode for the
+	assignment operation.
+
+		"<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
+
+	Format for each type of groups:
+
+        * Default CTRL_MON group:
+                "//<domain_id><opcode><flags>"
+
+        * Non-default CTRL_MON group:
+                "<CTRL_MON group>//<domain_id><opcode><flags>"
+
+        * Child MON group of default CTRL_MON group:
+                "/<MON group>/<domain_id><opcode><flags>"
+
+        * Child MON group of non-default CTRL_MON group:
+                "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
+
+	Domain_id '*' will apply the flags on all the domains.
+
+	Opcode can be one of the following:
+	::
+
+	 = Update the assignment to match the MBM event.
+	 + Assign a new MBM event without impacting existing assignments.
+	 - Unassign a MBM event from currently assigned events.
+
+	Examples:
+	::
+
+	  Initial group status:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	  //0=tl;1=tl;
+	  /child_default_mon_grp/0=tl;1=tl;
+
+	  To update the default group to assign only total MBM event on domain 0:
+	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	  Assignment status after the update:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	  //0=t;1=tl;
+	  /child_default_mon_grp/0=tl;1=tl;
+
+	  To update the MON group child_default_mon_grp to remove total MBM event on domain 1:
+	  # echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	  Assignment status after the update:
+	  $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+	  //0=t;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
+	  To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
+	  unassign both local and total MBM events on domain 1:
+	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
+			/sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	  Assignment status after the update:
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=t;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
+	  To update the default group to add a local MBM event domain 0.
+	  # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	  Assignment status after the update:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=tl;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
+	  To update the non default CTRL_MON group non_default_ctrl_mon_grp to unassign all
+	  the MBM events on all the domains.
+	  # echo "non_default_ctrl_mon_grp//*=_" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	  Assignment status after the update:
+	  #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  non_default_ctrl_mon_grp//0=_;1=_;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
+	  //0=tl;1=tl;
+	  /child_default_mon_grp/0=tl;1=l;
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 3250561f0187..799f36eef2b6 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -67,6 +67,16 @@
 
 #define MON_CNTR_UNSET			U32_MAX
 
+/*
+ * Assignment flags for mbm_cntr_assign feature
+ */
+enum {
+	ASSIGN_NONE	= 0,
+	ASSIGN_TOTAL	= BIT(QOS_L3_MBM_TOTAL_EVENT_ID),
+	ASSIGN_LOCAL	= BIT(QOS_L3_MBM_LOCAL_EVENT_ID),
+	ASSIGN_INVALID,
+};
+
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ffa0ed98efbe..56ecdf7406ae 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1047,6 +1047,237 @@ static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_str_to_mon_state(char *flag)
+{
+	int i, mon_state = ASSIGN_NONE;
+
+	for (i = 0; i < strlen(flag); i++) {
+		switch (*(flag + i)) {
+		case 't':
+			mon_state |= ASSIGN_TOTAL;
+			break;
+		case 'l':
+			mon_state |= ASSIGN_LOCAL;
+			break;
+		case '_':
+			mon_state = ASSIGN_NONE;
+			break;
+		default:
+			return ASSIGN_INVALID;
+		}
+	}
+
+	return mon_state;
+}
+
+static struct rdtgroup *rdtgroup_find_grp_by_name(enum rdt_group_type rtype,
+						  char *p_grp, char *c_grp)
+{
+	struct rdtgroup *rdtg, *crg;
+
+	if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
+		return &rdtgroup_default;
+	} else if (rtype == RDTCTRL_GROUP) {
+		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
+			if (!strcmp(p_grp, rdtg->kn->name))
+				return rdtg;
+	} else if (rtype == RDTMON_GROUP) {
+		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+			if (!strcmp(p_grp, rdtg->kn->name)) {
+				list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+						    mon.crdtgrp_list) {
+					if (!strcmp(c_grp, crg->kn->name))
+						return crg;
+				}
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static int rdtgroup_process_flags(struct rdt_resource *r,
+				  enum rdt_group_type rtype,
+				  char *p_grp, char *c_grp, char *tok)
+{
+	int op, mon_state, assign_state, unassign_state;
+	char *dom_str, *id_str, *op_str;
+	struct rdt_mon_domain *d;
+	struct rdtgroup *rdtgrp;
+	unsigned long dom_id;
+	int ret, found = 0;
+
+	rdtgrp = rdtgroup_find_grp_by_name(rtype, p_grp, c_grp);
+
+	if (!rdtgrp) {
+		rdt_last_cmd_puts("Not a valid resctrl group\n");
+		return -EINVAL;
+	}
+
+next:
+	if (!tok || tok[0] == '\0')
+		return 0;
+
+	/* Start processing the strings for each domain */
+	dom_str = strim(strsep(&tok, ";"));
+
+	op_str = strpbrk(dom_str, "=+-");
+
+	if (op_str) {
+		op = *op_str;
+	} else {
+		rdt_last_cmd_puts("Missing operation =, +, -, _ character\n");
+		return -EINVAL;
+	}
+
+	id_str = strsep(&dom_str, "=+-");
+
+	/* Check for domain id '*' which means all domains */
+	if (id_str && *id_str == '*') {
+		d = NULL;
+		goto check_state;
+	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
+		rdt_last_cmd_puts("Missing domain id\n");
+		return -EINVAL;
+	}
+
+	/* Verify if the dom_id is valid */
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		if (d->hdr.id == dom_id) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found) {
+		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
+		return -EINVAL;
+	}
+
+check_state:
+	mon_state = rdtgroup_str_to_mon_state(dom_str);
+
+	if (mon_state == ASSIGN_INVALID) {
+		rdt_last_cmd_puts("Invalid assign flag\n");
+		goto out_fail;
+	}
+
+	assign_state = 0;
+	unassign_state = 0;
+
+	switch (op) {
+	case '+':
+		if (mon_state == ASSIGN_NONE) {
+			rdt_last_cmd_puts("Invalid assign opcode\n");
+			goto out_fail;
+		}
+		assign_state = mon_state;
+		break;
+	case '-':
+		if (mon_state == ASSIGN_NONE) {
+			rdt_last_cmd_puts("Invalid assign opcode\n");
+			goto out_fail;
+		}
+		unassign_state = mon_state;
+		break;
+	case '=':
+		assign_state = mon_state;
+		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
+		break;
+	default:
+		break;
+	}
+
+	if (assign_state & ASSIGN_TOTAL) {
+		ret = rdtgroup_assign_cntr(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
+		if (ret)
+			goto out_fail;
+	}
+
+	if (assign_state & ASSIGN_LOCAL) {
+		ret = rdtgroup_assign_cntr(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
+		if (ret)
+			goto out_fail;
+	}
+
+	if (unassign_state & ASSIGN_TOTAL) {
+		ret = rdtgroup_unassign_cntr(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
+		if (ret)
+			goto out_fail;
+	}
+
+	if (unassign_state & ASSIGN_LOCAL) {
+		ret = rdtgroup_unassign_cntr(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
+		if (ret)
+			goto out_fail;
+	}
+
+	goto next;
+
+out_fail:
+
+	return -EINVAL;
+}
+
+static ssize_t rdtgroup_mbm_assign_control_write(struct kernfs_open_file *of,
+						 char *buf, size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	char *token, *cmon_grp, *mon_grp;
+	enum rdt_group_type rtype;
+	int ret;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
+		mutex_unlock(&rdtgroup_mutex);
+		cpus_read_unlock();
+		return -EINVAL;
+	}
+
+	rdt_last_cmd_clear();
+
+	while ((token = strsep(&buf, "\n")) != NULL) {
+		if (strstr(token, "/")) {
+			/*
+			 * The write command follows the following format:
+			 * “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
+			 * Extract the CTRL_MON group.
+			 */
+			cmon_grp = strsep(&token, "/");
+
+			/*
+			 * Extract the MON_GROUP.
+			 * strsep returns empty string for contiguous delimiters.
+			 * Empty mon_grp here means it is a RDTCTRL_GROUP.
+			 */
+			mon_grp = strsep(&token, "/");
+
+			if (*mon_grp == '\0')
+				rtype = RDTCTRL_GROUP;
+			else
+				rtype = RDTMON_GROUP;
+
+			ret = rdtgroup_process_flags(r, rtype, cmon_grp, mon_grp, token);
+			if (ret)
+				break;
+		}
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -2315,9 +2546,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_assign_control",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_assign_control_show,
+		.write		= rdtgroup_mbm_assign_control_write,
 	},
 	{
 		.name		= "cpus_list",
-- 
2.34.1


