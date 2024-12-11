Return-Path: <linux-kernel+bounces-441965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432809ED626
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B674166906
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA55242F01;
	Wed, 11 Dec 2024 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DmKapwTL"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B67242EF1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943451; cv=fail; b=jlhJ8jn8MB/Wt9L9au13IpoYKnqV8uCG4OBmBaU6PFUJMYbexJXGD/9W0bpCmbB43slSBMljhxCTWYVbj0oBBXVVlDzV7yv0DRUHUBNb0seit1gSSzSmIrA1731lf9n43LaVs3i+F/o/tUM0MzEemOt7BQQ0qYKfRVRX9aVglhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943451; c=relaxed/simple;
	bh=B51GHzOohB1lNQx5rAlHi5Y1NSmlRh8kDZVcZPnXxYY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hC3w8VGnkLYlMF7F/v6Hr5VS+eFYzP5ydYkhoJkiA5ZG4Xha4tiwe8hNVihxTLZ+HDX82kHhyETR3aXI3BqHvKHuPOGaqLAuFsqNhmIsHUlDI8ueAcvKFyVpFm3s3KptUawle5297qM/GCV6y331WskFpIu5qbNe3EZC8xM0fdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DmKapwTL; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWKR5YEH28ke6xgjQlk/85VDgS0m2OtkebmBXAvdNjbmVzmNTO0j9o7QIBkB3ePw3i4jbnpUWhTA2XgqhHFuPJaGqxkfs7ar2RL6zWMVsqt8OwwRyCzeU2vLKkCQ+nmiuaF0bghRMU2tPYNaiEvoEc677XGaqMA8eNhEIeiHFgXdFjbwIoA7izjezqQrlD3nuvxx1LCjg1YI0thFU16aBay1zejxjluXBLwTf8XA5gRE8ls4ABY5rE3OXWa+a5zdqTUerm/LhHquUGdoz8hIn6TJgDb0psVKTB4QElHD02dHWzQMYSfk4jBLLIQgPpPpXuBnjxlOLqsfEvRLhBdybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0jPE2mwkxamNBkoP+Y4ib5FhZsW/NDw4r9svhjcvoQ=;
 b=ORumpoeG6TxIkUI6ooXhIIiALUvJBb/hfo5ixIqu3pHEY8yPZgL1pG/ESQgPzVdbhuXMLuDJIjSfkct4FgOToFUa3tfWqoVe0Y5boBYXRrWCfGRBlcduDNc4fyt21vQq+qHIWq6LsmB2f9tJrXy6/jSbjVmVUjCMhUGfVOOk1HrshPzLCLgQIz0BGhQ5YiCmcpqC4dqQjbTJWB9oUwNhc/JLOSJ9scpwzaHLcmmqeOa/fG++yoj1htLbxxaYz0wj4UeUeKlTCn02BKUQ1C7ST/9E/sO/3T96O1RCgfelvKRK32s9W/6vxkQSIa0mi0JKEhtnGH+oGFDDc3aVzCdhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0jPE2mwkxamNBkoP+Y4ib5FhZsW/NDw4r9svhjcvoQ=;
 b=DmKapwTLQ4xp4Fn7zgsOYld7CKEUU4F4dQIjKR07qOmCFNtFkjKCVy0M6eHbwoj7efI+sY6KYe8hDcX5CHE0fzEPPn7whx31WxgdXFlpG7brI3OP97wrd6KGznNsK6yheegCH8taIGuC7tcKLxVrzLjvjCBT4OzQD+GBoSq7f1I=
Received: from PH0PR07CA0033.namprd07.prod.outlook.com (2603:10b6:510:e::8) by
 LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 18:57:25 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::a4) by PH0PR07CA0033.outlook.office365.com
 (2603:10b6:510:e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 18:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 18:57:24 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 12:57:17 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 4/8] x86/topology: Remove x86_smt_flags and use cpu_smt_flags directly
Date: Wed, 11 Dec 2024 18:55:47 +0000
Message-ID: <20241211185552.4553-5-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185552.4553-1-kprateek.nayak@amd.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 38196cbc-fcda-46dd-7162-08dd1a15a6b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v9HQSxzVLgRDqD6Lg/bDzwCajkxVHblcdQFKUA2WLbeq2a2C8fCpJ4zHVInd?=
 =?us-ascii?Q?tduJKTLm6BbWQVl7mihTUYEOPhNc2zbFcG181DpgPNg4ZNfxAsrt7jEYiFDP?=
 =?us-ascii?Q?boxr/yFrTpKM1BIi+7CpRFwMhsCPcSp+noO0wkEIh8tJxs5ue//3JGOB/IPV?=
 =?us-ascii?Q?iqPDyePU8FMlKDTUGOJAVYuYtO9pgqOpdH2000egGVFr7UmBm4nIm8WDn6Sh?=
 =?us-ascii?Q?hIUDu50fdCQ2F7AUxGF0FrVddYEJ4X03fhrlhDyt56GwO40lz1gM5d6vilyY?=
 =?us-ascii?Q?D+KePnc99YFhGEgM9KsR8KzBAo1r53UUynFmUk5xGEiosIpHBnbPETeaXE/U?=
 =?us-ascii?Q?Q9Lu2sOr1jN8IV0cB45hNyyuQiHEPuxfftuqdCJILagf59kJM0C5NPJgDqF8?=
 =?us-ascii?Q?nVLq8gTu6Yyjs8L9giuGN9KlLe0buAacXsJpDG7Mzkw9ydWs0wR8uqKtFoRP?=
 =?us-ascii?Q?qsgaGwVdWBS6bu8Kt7JAAegJ2htpbW94HS1nlHAEMhxKIJYNT7Fqg4Hlf+PE?=
 =?us-ascii?Q?+XwbwZjyN2eUSdzrsCzqxk6ANL/5QdeMK7eooMBAM8MaTqkkL3U/F6LUmEuB?=
 =?us-ascii?Q?vb7/J303gLZI2nIBNYllX9X4DUI5tOagLIEKjoLZoIZcq7dwP+/6b2gFGSrl?=
 =?us-ascii?Q?sUg3FXhaVEkNyMLr4IkWqqOT+HEU3XjNOaRcO1t+RUGHbJwtwkWUyxgDObgr?=
 =?us-ascii?Q?tkcTr8Ze3WBfWmY8oI4tQqUGS8mqRMXPHEvMR8yRgRJTgxSNfWwKrYq62R7f?=
 =?us-ascii?Q?8ka6BUDlXqYG/mgdwTGrOOGiLQd2P2rbaITbCpDSpSGZ8p/gGnMJIhDpvOPi?=
 =?us-ascii?Q?Rea8byNQPQpYRsASHm8xoF/G4P4xf5m4N7xzR8Qve7DHx4quha/NPqmujjz4?=
 =?us-ascii?Q?fR6Fg97i40y+fatOZfPi1PDJ2/v0TBYqSAglMc3EOunPQ2El3FD64SdsnPvi?=
 =?us-ascii?Q?UuEP5w7Pwq6Fm9Gx73t0J/kCSWyipKHvozV+GoUTICq5smrG65uKbA3U+raX?=
 =?us-ascii?Q?7ey4j/B5sw5d0w7VvxUNQOOvbr+w7eWcanndXzmeYkbwfvZjWVp0PDaZB1rB?=
 =?us-ascii?Q?wXlzcw8oCuG6uKzwAHas+IjYFZLNpvTTAxkKOcXPLIc0PE5gzi720ebdA78u?=
 =?us-ascii?Q?wWivditj8tg/ETFhw/XA/H8wrD7Osb/it/vj5/tUYcrEpBKBJPD4M76SJ/ft?=
 =?us-ascii?Q?oeD3J1rvSBAgeXPHfe1tRVUxduHtzj3cloXBvSQef5w1gVKZUjefhrc8m68Z?=
 =?us-ascii?Q?UxtGU64hRmh6wQtUScLUFMHFIL8aEHcs4DWOuLXc2vb3iS4cE/OkLFsmMVuJ?=
 =?us-ascii?Q?s5GFaG+pNCi9G5O6Jylp4eYtOTMptlY9Ep5uUFgNI3XpCoVL7rKF7svg5Ln2?=
 =?us-ascii?Q?oKKKgwnjwewBrBcQNfu2ZIO6DUaNH8SxtkdPAk45thvYvSI3TtTcpTtnAXWH?=
 =?us-ascii?Q?bmT8cpP0fhFWbZjwSQaNkESVlMjiheII?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 18:57:24.9150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38196cbc-fcda-46dd-7162-08dd1a15a6b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406

x86_*_flags() wrappers were introduced with commit d3d37d850d1d
("x86/sched: Add SD_ASYM_PACKING flags to x86 ITMT CPU") to add
x86_sched_itmt_flags() in addition to the default domain flags for SMT
and MC domain.

commit 995998ebdebd ("x86/sched: Remove SD_ASYM_PACKING from the
SMT domain flags") removed the ITMT flags for SMT domain but not the
x86_smt_flags() wrappers which directly returns cpu_smt_flags().

Remove x86_smt_flags() and directly use cpu_smt_flags() to derive the
flags for SMT domain. No functional changes intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/kernel/smpboot.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b5a8f0891135..6e300897b7ee 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -482,12 +482,6 @@ static int x86_core_flags(void)
 	return cpu_core_flags() | x86_sched_itmt_flags();
 }
 #endif
-#ifdef CONFIG_SCHED_SMT
-static int x86_smt_flags(void)
-{
-	return cpu_smt_flags();
-}
-#endif
 #ifdef CONFIG_SCHED_CLUSTER
 static int x86_cluster_flags(void)
 {
@@ -519,7 +513,7 @@ static void __init build_sched_topology(void)
 
 #ifdef CONFIG_SCHED_SMT
 	x86_topology[i++] = (struct sched_domain_topology_level){
-		cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT)
+		cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT)
 	};
 #endif
 #ifdef CONFIG_SCHED_CLUSTER
-- 
2.34.1


