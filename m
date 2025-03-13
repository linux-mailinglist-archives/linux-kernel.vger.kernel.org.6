Return-Path: <linux-kernel+bounces-559118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC9FA5EFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476907A5414
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8307725FA0D;
	Thu, 13 Mar 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MEmnSbXQ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5292641E1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858746; cv=fail; b=gZj+xVR22ThGGqnHpmy/Lg4fqRo8OJXOwgTxfxBU1Q5Q9QGl2B9/VahQWUvO/lmuN0dSH048MdzcVU8zNfxvSMVVQs1dB5EqPY1SqcLT+bIC/LkAItG/VyQR0DrrAmKaCnB2y6EPqZbimjXx9Y6yo2N8ZpkVJ0gI3eAsTHdkepY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858746; c=relaxed/simple;
	bh=IWPX1jFAVG0dZRgyxTo3T1gUkHa8LndcS9c3lH/p/t4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7vxcGg6/HIDoqHntFzMb2pnVR/cJ6ZE0I3IVQPlMJMvcgzYO8ey4Gw/ivHcVK7ne6Yik1+M+grkDNcJ9ZEp3xKm6Yzw3B++lYhcr9rv/GrjvWf6PI9lF4ma4SmgBd7+hbe6ADm5nAlvJz6n9IQHqIAbs1PtjZK8f3rNTxudpy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MEmnSbXQ; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1SgoKFiIc04GUYMjkksFrB/oiGvZ9Hn3cdx9jvgFc5OVZ7MIYRypfM+wELNEWZo0p2qayy4sfCN7Z56W91Xd+Zqys9ORAMn3OEvUQepctKuGHVbjfBGmy6y2rYu6UBgJX8VnRUugnrZvUjy8eh6oURtHQ3WkmZoApfLWeirJNKH6nklU7UBcjuZmOu3d2hQySyg0vZSuGiiHZ5s2a4PclaWgFjapzZIixrQ2oCoqfxE8mQqil+fDGX+IhkMbHc/uK0m/RlmxOIcNoaebnYkVSSnuj3XoBu1WQr/0xQrdW0QzQGcOit/s/8BDDs2r8tbbUNuPogDRgyBojWSf8G90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZHix5/tRJ0uPmqG1bVpzoGeTvzhyuIC+pdwRqUs+P8=;
 b=OxXaW8Elp7V1/ABMfw52umMuSfG0am0vwDZwL5MeI4lTkLwul09QQZwKyuqqUSHSjorIKxjosFY0RZAiasmqPyOAovpRSLWqVzljzFhtHQDOFv3Va4OpkNR+DlO80Fw42QIdglEQvgs1WDsjD/I5kufwkoZ5MAjNn0qYQVr2SJ68qaMJ1fCdGGwmqi+ogMFxnDJFwgUi6c19XtMzbbZ2g9jf+g+gSCkU3uGG02AbcXn0v61DMM9EyUDt0zO6SEmuhGHhhaJWwvJZxov937RZu/m7QaKpeUzCmOnG93d7oX3dwG4irSxMNRGmsctMPJPhHS64ol2Pv4wRj9cWA7Lhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZHix5/tRJ0uPmqG1bVpzoGeTvzhyuIC+pdwRqUs+P8=;
 b=MEmnSbXQuPRUhYRYoIZTC4IxKqd0z9x8+Ahqjs6s69OLEZFCi9sA3Ma9hZLd5uQ7fZjcPe0l3MbgrWOrxPbFcnI/KeWpOTby3Kp+PeIFKJqtLrL6KlYQNMX/j6RwU9DQ+qm/Z+OvrOiwNC/qR1tMIhY24PDhJFy3ndsa4FCTzhg=
Received: from CY5PR15CA0254.namprd15.prod.outlook.com (2603:10b6:930:66::28)
 by SA5PPF7D510B798.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 09:39:00 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::9d) by CY5PR15CA0254.outlook.office365.com
 (2603:10b6:930:66::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Thu,
 13 Mar 2025 09:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 09:39:00 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 04:38:55 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Chen Yu <yu.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, David Vernet
	<void@manifault.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>
Subject: [RFC PATCH 3/8] sched/fair: Move "struct sg_lb_stats" and its dependencies to sched.h
Date: Thu, 13 Mar 2025 09:37:41 +0000
Message-ID: <20250313093746.6760-4-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313093746.6760-1-kprateek.nayak@amd.com>
References: <20250313093746.6760-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA5PPF7D510B798:EE_
X-MS-Office365-Filtering-Correlation-Id: aff0814d-7daa-407b-a465-08dd6212e2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e7Tp7ri2wA1bfKFcvQuOknAXj21QZt96zOQD0pldOpbpt2Ax/RM3SZfYJAaG?=
 =?us-ascii?Q?GCJVvlvrukYswiFqtaYzaxfxbKMbnfN1AhkjsU70nXTCaJHzQuB6qMA/9OFs?=
 =?us-ascii?Q?7rlrui1XBDnXofE1eiaj5eAuvs33FzRRcCGCPUyQ/Q2v02ZpNc2cGXcE6xBw?=
 =?us-ascii?Q?X416GA8xT9V7Oo4j5VYLSh8X0vsC+kOjerJ8VheMufeXK35Yie4JzVlOYiCn?=
 =?us-ascii?Q?kzMVMnbVHN9ArBYgT0iC1sY0dQVOstMoivuJVS9vMy/apnFNrgUMNby4vtXk?=
 =?us-ascii?Q?HvSdUwkktoDm/LJOSO5oCk3ptNkLBpIs0/fjOdIulPze3wWkz6FvFPimMdxf?=
 =?us-ascii?Q?cW4BT9pyMzE3gu2xspa0Q6ppPO0lwhknAm6VeuX3Z8Vmb8C7P5LlK3NKY6TN?=
 =?us-ascii?Q?eAiHSAMaLe+RGnTkdvaKtR2w6I9QxXzzFIqCdDZy41wO41WoVuacBiDKk0NQ?=
 =?us-ascii?Q?y3blqh+twnXs55mpyhLzCbksgqjnrqNqye5vq3l0syMaZiciwJ/x/FTcBngR?=
 =?us-ascii?Q?14nXnb2JhkrKB5J3CAgIOsDdcczeMY/6I+Qtg1Oyvkql04UlL3gaaDtEcgNZ?=
 =?us-ascii?Q?lrp9T/O++hMbfmpHRcS2+cvGCxBlqlsAubLQMNtDyQTcDJu1VApveNr8uyju?=
 =?us-ascii?Q?SqNrylNX0c/+496F8onJ9KcAyTbkwMa168bCcuv3Cb7lURzwW8GmfJL2jhM+?=
 =?us-ascii?Q?5k2z5KSUAl+U4k+vnjJIKDo73nOiaKMPt46AMVPcHaeOj68mxS8v5H3/Vv7b?=
 =?us-ascii?Q?s1Cac63t9wTESwIwnJ4FRfUz2mvXcegn0Cg4sdqr9YEUuaXivU0RCp1IW6RW?=
 =?us-ascii?Q?DLv1YO52zQk11YvQJEOa/rf3KRmd11cQqOTb4Se0+i4pxVZHH1aGFS4s1ro5?=
 =?us-ascii?Q?d7ae3yP6WCuvyv4+gkIgFY2o2v1hlzwxU6ie872UHs+eiaFQwRZ7XPOqdpnB?=
 =?us-ascii?Q?AVJU7SKC76GzaqWcv0ygyUR7NqWZfyZOkUlDKjezbesMpgtoziuV5GS8GNZu?=
 =?us-ascii?Q?AHLHB5bGHhtg2/HNanTZh7XEypVJK5e0EhlEXBAa12lC76O7+xMztq8VGD87?=
 =?us-ascii?Q?yHgqedAIAr37SEiBWn2P5f6idfuGS/wxvRRvlxVMUtbFWTAHj4pYSpDrvUdH?=
 =?us-ascii?Q?c4UscbRWXbS5hK8u0j6pwmoC1EDAaEYRdMu1X9px25Mx389lRNE9e3DqtXAC?=
 =?us-ascii?Q?Jr/Bju0v4CdoSsa3aYlRSsRgHg07VxSguFy9ITnMEo7jVAKxonDdxsZ80PYU?=
 =?us-ascii?Q?ivQdgQoJRV6Teo2Iv24kw4OOpzwNFNi7nbQ4xk0wJ+l948CTfqToE9lj62ey?=
 =?us-ascii?Q?WldWajJN9js/uT50z+4bRHYHZf3cGTB9HCgKV1GneYY9WUeOZEhX9up22F4y?=
 =?us-ascii?Q?ApM0NYcAp3rD/Vhj+zlbWrWNYLVgNQ+OmdtijV8iNz1QQlTmFf1c8Sm0Js9l?=
 =?us-ascii?Q?3EI3m35NvigYWUeksQx1iQyW+ikdS2Aa9XI+JBUsbGhR70USbUo2tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:39:00.6617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff0814d-7daa-407b-a465-08dd6212e2a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7D510B798

"struct sg_lb_stats" will be embedded into "struct sched_domain_shared"
to propagate load balancing information up the sched domain hierarchy in
the subsequent commits. Move it, and the internal types in depends on
from fair.c to sched.h

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c  | 66 --------------------------------------------
 kernel/sched/sched.h | 66 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9dafb374d76d..39bee40dde27 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9168,49 +9168,6 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
 
 enum fbq_type { regular, remote, all };
 
-/*
- * 'group_type' describes the group of CPUs at the moment of load balancing.
- *
- * The enum is ordered by pulling priority, with the group with lowest priority
- * first so the group_type can simply be compared when selecting the busiest
- * group. See update_sd_pick_busiest().
- */
-enum group_type {
-	/* The group has spare capacity that can be used to run more tasks.  */
-	group_has_spare = 0,
-	/*
-	 * The group is fully used and the tasks don't compete for more CPU
-	 * cycles. Nevertheless, some tasks might wait before running.
-	 */
-	group_fully_busy,
-	/*
-	 * One task doesn't fit with CPU's capacity and must be migrated to a
-	 * more powerful CPU.
-	 */
-	group_misfit_task,
-	/*
-	 * Balance SMT group that's fully busy. Can benefit from migration
-	 * a task on SMT with busy sibling to another CPU on idle core.
-	 */
-	group_smt_balance,
-	/*
-	 * SD_ASYM_PACKING only: One local CPU with higher capacity is available,
-	 * and the task should be migrated to it instead of running on the
-	 * current CPU.
-	 */
-	group_asym_packing,
-	/*
-	 * The tasks' affinity constraints previously prevented the scheduler
-	 * from balancing the load across the system.
-	 */
-	group_imbalanced,
-	/*
-	 * The CPU is overloaded and can't provide expected CPU cycles to all
-	 * tasks.
-	 */
-	group_overloaded
-};
-
 enum migration_type {
 	migrate_load = 0,
 	migrate_util,
@@ -9916,29 +9873,6 @@ static void sched_balance_update_blocked_averages(int cpu)
 
 /********** Helpers for sched_balance_find_src_group ************************/
 
-/*
- * sg_lb_stats - stats of a sched_group required for load-balancing:
- */
-struct sg_lb_stats {
-	unsigned long avg_load;			/* Avg load            over the CPUs of the group */
-	unsigned long group_load;		/* Total load          over the CPUs of the group */
-	unsigned long group_capacity;		/* Capacity            over the CPUs of the group */
-	unsigned long group_util;		/* Total utilization   over the CPUs of the group */
-	unsigned long group_runnable;		/* Total runnable time over the CPUs of the group */
-	unsigned int sum_nr_running;		/* Nr of all tasks running in the group */
-	unsigned int sum_h_nr_running;		/* Nr of CFS tasks running in the group */
-	unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
-	unsigned int group_weight;
-	enum group_type group_type;
-	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
-	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
-	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
-#ifdef CONFIG_NUMA_BALANCING
-	unsigned int nr_numa_running;
-	unsigned int nr_preferred_running;
-#endif
-};
-
 /*
  * sd_lb_stats - stats of a sched_domain required for load-balancing:
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 38aa4cba5d1f..dc9d6e4c704b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2102,6 +2102,72 @@ struct sched_group {
 	unsigned long		cpumask[];
 };
 
+/*
+ * 'group_type' describes the group of CPUs at the moment of load balancing.
+ *
+ * The enum is ordered by pulling priority, with the group with lowest priority
+ * first so the group_type can simply be compared when selecting the busiest
+ * group. See update_sd_pick_busiest().
+ */
+enum group_type {
+	/* The group has spare capacity that can be used to run more tasks.  */
+	group_has_spare = 0,
+	/*
+	 * The group is fully used and the tasks don't compete for more CPU
+	 * cycles. Nevertheless, some tasks might wait before running.
+	 */
+	group_fully_busy,
+	/*
+	 * One task doesn't fit with CPU's capacity and must be migrated to a
+	 * more powerful CPU.
+	 */
+	group_misfit_task,
+	/*
+	 * Balance SMT group that's fully busy. Can benefit from migration
+	 * a task on SMT with busy sibling to another CPU on idle core.
+	 */
+	group_smt_balance,
+	/*
+	 * SD_ASYM_PACKING only: One local CPU with higher capacity is available,
+	 * and the task should be migrated to it instead of running on the
+	 * current CPU.
+	 */
+	group_asym_packing,
+	/*
+	 * The tasks' affinity constraints previously prevented the scheduler
+	 * from balancing the load across the system.
+	 */
+	group_imbalanced,
+	/*
+	 * The CPU is overloaded and can't provide expected CPU cycles to all
+	 * tasks.
+	 */
+	group_overloaded
+};
+
+/*
+ * sg_lb_stats - stats of a sched_group required for load-balancing:
+ */
+struct sg_lb_stats {
+	unsigned long avg_load;			/* Avg load            over the CPUs of the group */
+	unsigned long group_load;		/* Total load          over the CPUs of the group */
+	unsigned long group_capacity;		/* Capacity            over the CPUs of the group */
+	unsigned long group_util;		/* Total utilization   over the CPUs of the group */
+	unsigned long group_runnable;		/* Total runnable time over the CPUs of the group */
+	unsigned int sum_nr_running;		/* Nr of all tasks running in the group */
+	unsigned int sum_h_nr_running;		/* Nr of CFS tasks running in the group */
+	unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
+	unsigned int group_weight;
+	enum group_type group_type;
+	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
+	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
+	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
+#ifdef CONFIG_NUMA_BALANCING
+	unsigned int nr_numa_running;
+	unsigned int nr_preferred_running;
+#endif
+};
+
 static inline struct cpumask *sched_group_span(struct sched_group *sg)
 {
 	return to_cpumask(sg->cpumask);
-- 
2.43.0


