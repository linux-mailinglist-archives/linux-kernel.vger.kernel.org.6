Return-Path: <linux-kernel+bounces-441961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9B79ED615
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDFC282350
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29832360A0;
	Wed, 11 Dec 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g7dlhhmf"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C2A20A5CF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943394; cv=fail; b=ASHff2SU6ngntHnOtL7Yb/JLFEUvlg6mTqFCp/d5P8ogZUGy8nAtEwzEdCSOV2sWcnZgBeS30QCzwPLz+h7tz/gc3HXzSjJaqe3JGN0TTpGmqzo70VnMy/rErDO1hjjFqF/eEEay0WiUoZOIUnA7TrVxkxAEpZjX/dVejb8SSwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943394; c=relaxed/simple;
	bh=Bre41trVRBohC4zvVFPB5M587fLjir/blwn/CJkgP+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzCpmfCoLmKcm7ehmm5NJae/JR9hxrYWL7gqEjHVuWE/SeOei9C8wmvOX6n8F2VWd7ZbUln5jJAWiJyGnQYj4QwsOgRC/d/S47YtmwHOsoySdIoAYxRWFxNs7F7e0iuYqCZbD2xnPK4x6upuowfYaE4oUR+M9PGk68y4x/wXtp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g7dlhhmf; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjkXLvTPUpVRuNCJ320+rFQ8W31Tj+cZ7yPJKSrqzx22oNjq78qm6DtOZ+kIE8pRGA7+Tgv6zGxPU3WDLPjwZxndSPhsNKpIiwLB3GpEDyL/oMXFGYtEkm6rtpCd+CopXg2RWzqKAC1y+OScxpKTfLGKZoCffz4eZq9ePY2zeib3/HVwaQEsGMclh7KWTUQvwH688MOcdLXAY6AJNZhFE+YWjYz6tsJvwPUCuJvxMMS9DzUaijTJHbthnRuCunNk+4fCzc1k3k9FL5q6UEMzn9npmowHR71UYiTtFNeCkFJvqNDaKWmTKXuAs9aZlLk4pT4JoF+PZh2jVbTIknibPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Gad3kKJiLb5f5dDBQyplklCc4JCyjxOFc/r1zDbNQQ=;
 b=gZobCLs14dU16ujzVuM/TmZyD/A9rqnMirR82Fx57alymGe7cYPVwuNPMUSkz2wRcc3Ezii6D6kYMYuQzxkQR603FKq4mFX8NeIUeoYtGsTjxx4cZv6EVO4JPQ0CAP2xQ1afiWwQL9S4RHMDYkCmbLdxpZW7XE9zmIgqTjUQsow0ZajLhDhCPkXZF5aoPje7gN08gj2zngubB6358YLdMNYYsr24uVGXQammncOBOP0mWemvBC6YmNwhwBTKAjTAFTCXlJQx4u8QdbClTn8q8RDefxUjEk2JP7iJmQmCEZP4qX3z3t4rDVWTPFzMcEgM3KnN8qq9EHAEcsGVxAfZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Gad3kKJiLb5f5dDBQyplklCc4JCyjxOFc/r1zDbNQQ=;
 b=g7dlhhmf89dWfwGpmnB2YQBo/YNWirGNE1PZ01DOof2NwnI2UpRgx7SorLglzrtMhxxixR1Q/2VNvwxranPjWe5tuRdkQet2vfSi6vpWKeOFknAb3hK+uXnxqNWysrsgrMk5fJiCO9z8SuXH6mNU/BBs0uIkuPUWfj5gCHCTKxA=
Received: from PH7P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::9)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 18:56:26 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::c5) by PH7P222CA0010.outlook.office365.com
 (2603:10b6:510:33a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 18:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 18:56:26 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 12:56:19 -0600
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
Subject: [PATCH 1/8] x86/itmt: Convert "sysctl_sched_itmt_enabled" to boolean
Date: Wed, 11 Dec 2024 18:55:44 +0000
Message-ID: <20241211185552.4553-2-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a7fcbc-4314-40cc-c490-08dd1a1583bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gJhpWzNCBsJj6xt1E//YC6w9rMWmh95CXsfDnuOZgC6JHMJVOUBGAmsUCXA5?=
 =?us-ascii?Q?VfTYjmFsD3wQpmfaxfUehs+YrixeRljd2daWZSwWwGpuNVlRsAXm34VoR/lu?=
 =?us-ascii?Q?PAvV0ZpTTPGoXeMLcvVM1g4F5ZUDfPjRozFKlLUKRdx9EZoE8z1Obxqbx+aS?=
 =?us-ascii?Q?0spSWCZVJj+AEdfdTkzjY7/AhfO9fU5pVLPkxkqUefzdkoK0BCdIWvVsZSv/?=
 =?us-ascii?Q?eyScEEKoB73J6HP5x2qf9G0svRozbCxm6lFQAkcqAKijZhjIBq9UKcXByinR?=
 =?us-ascii?Q?WIcZ/nkCGVG4hayWbxoBJudeSew1E0CS5W+/pGrnr+hYuFDwA2uTduSWaqS5?=
 =?us-ascii?Q?7ErRAkJis8tmroWwtFp3G/tvLN778rexdwo9YKb5c1VKmZ7ALjoWyb9nE2yc?=
 =?us-ascii?Q?aGHArSxu7WF6FZNxi4pI1mN2bPfFfcaKVZskKmdZ8CvFC7Y1rRLXc/BdsdFc?=
 =?us-ascii?Q?HL3NXJ3v7ZCfw49mp2jjLVvoMQc6yS+dwMdWPWa2g84scwjE6wvAiTzijGuu?=
 =?us-ascii?Q?eQQMEv/kSs7Lanw/BFEivpn+LBOEmLBpZ4uAFpVZNOLw5h2OPg1ST5xqpCv+?=
 =?us-ascii?Q?v8Fp7kksOG7AZPBavFCnoWydCzlOu55y+UdAnC7yVdIKJhYYQXCFHrXMgkSe?=
 =?us-ascii?Q?dw+q8MLQes5rTwWy6gCzGLiw/+p08coyJMh327sRTBKcG4zZCZiGRkv1M4KM?=
 =?us-ascii?Q?G85ubJ+w3l6g3SqkjOVUjxYpUwdesHvQdfGodXaDq0xNSOq9ztSY0EaOE84r?=
 =?us-ascii?Q?8D+lpKcw14C0rA7ndqQD5rZwrX4v6PIkT1xezaKgSbOKSsPhH/1c/Vt0RMra?=
 =?us-ascii?Q?LSXqzXXXDL3ybKp9vTDf/iClU0OnW5jFpc/4kmO+0vM49R6wnp21Pxv9fbrE?=
 =?us-ascii?Q?oQXRJ7piRThlfO5FrcWZl3I2U80u8WwQk332jRkQroUVOLPCyVvEAhbE16AI?=
 =?us-ascii?Q?EYveyQrEc3+oVMlrEVbKq6TCQvO7eok7mGtrDi2xawDZkfELnLY00vQIxDr6?=
 =?us-ascii?Q?+0v8UZMM73dBZIXN1RDESzJCQKECLLfdlZUk6g7HIwPbJXacbflMgipnzKtm?=
 =?us-ascii?Q?9oyiOCqX1fexMnMKrgcCYsFfGsLzOtgptEbEwj5EDB7NHl8dYDmXhL5y8ES6?=
 =?us-ascii?Q?0DS7Ckl9nB65qK8b+0Lw+88Kf2GkoO8oX5Tzgb2/D3kU61lAWRABzrXZEMV0?=
 =?us-ascii?Q?zUAaWDlRV3o2VJIgejxreOTCGSpWhSmMmWy3JXzFfVdjHEOhCNlugjtKzH4d?=
 =?us-ascii?Q?D2N41SdCMPGRs9HboBcaqqg0VYchpTleB4+l7mJxOEcl5YcB0N4D2vL9FglV?=
 =?us-ascii?Q?uqkDlCUzvEKvtPFMD4nPHYrutCX4r8RS3u6GxlH3tkDkAyVDWgB/r3nKoeiC?=
 =?us-ascii?Q?t6FcMzcUKqlSCd50/GssPq8FCD0doV7lmAk3EyAf2Ge4encW4oLQpaKlVtyN?=
 =?us-ascii?Q?fK0cHOZzVwE4a9Y28ruK3zoIbczOjwzS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 18:56:26.2362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a7fcbc-4314-40cc-c490-08dd1a1583bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831

In preparation to move "sysctl_sched_itmt_enabled" to debugfs, convert
the unsigned int to bool since debugfs readily exposes boolean fops
primitives (debugfs_read_file_bool, debugfs_write_file_bool) which can
streamline the conversion.

Since the current ctl_table initializes extra1 and extra2 to SYSCTL_ZERO
and SYSCTL_ONE respectively, the value of "sysctl_sched_itmt_enabled"
can only be 0 or 1 and this datatype conversion should not cause any
functional changes.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/include/asm/topology.h | 4 ++--
 arch/x86/kernel/itmt.c          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index fd41103ad342..63bab25a4896 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -250,7 +250,7 @@ extern bool x86_topology_update;
 #include <asm/percpu.h>
 
 DECLARE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
-extern unsigned int __read_mostly sysctl_sched_itmt_enabled;
+extern bool __read_mostly sysctl_sched_itmt_enabled;
 
 /* Interface to set priority of a cpu */
 void sched_set_itmt_core_prio(int prio, int core_cpu);
@@ -263,7 +263,7 @@ void sched_clear_itmt_support(void);
 
 #else /* CONFIG_SCHED_MC_PRIO */
 
-#define sysctl_sched_itmt_enabled	0
+#define sysctl_sched_itmt_enabled	false
 static inline void sched_set_itmt_core_prio(int prio, int core_cpu)
 {
 }
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 51b805c727fc..28f449123d68 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -36,7 +36,7 @@ static bool __read_mostly sched_itmt_capable;
  *
  * It can be set via /proc/sys/kernel/sched_itmt_enabled
  */
-unsigned int __read_mostly sysctl_sched_itmt_enabled;
+bool __read_mostly sysctl_sched_itmt_enabled;
 
 static int sched_itmt_update_handler(const struct ctl_table *table, int write,
 				     void *buffer, size_t *lenp, loff_t *ppos)
-- 
2.34.1


