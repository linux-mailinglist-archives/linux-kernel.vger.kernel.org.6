Return-Path: <linux-kernel+bounces-441970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFD39ED64B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA26188548E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C3A205AB6;
	Wed, 11 Dec 2024 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IJX1KwAl"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAEA236953
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943531; cv=fail; b=p0r6qj8PerB3acq/D/7qE3Gf89tdsJa6IJCsWi5hFrpy6qH5uqXT6LrLO+2xHwOcFsVdJskUXhgEWptKnaMB2xxJkwFyoSb/wsW88aCMMoGrb8PGBhRXkvYBjQGd+aZ6F3vIZCpS9uh5EOhXEhPIeMwMXCpdbqM1CXFMdRl7ntQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943531; c=relaxed/simple;
	bh=odguSQaQf53uKboP+a0h6cMou9KDoHk9Y0jAM8k3OEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Da4NAawiZgwP4py4flNKyE3vn//6rv6jUph/lwdQc3kDixUhGTp5KjiF7YJa+3cK5XQ9PeePZW6mJCZ1VSz5wKSayg4ttJT04CeAakXyMs0Bso1Bc22kZ3Obwd1+4xzxO4J5YRPWWudaccUZZaVLlJsVOUXbNtDeTN/zwo6zTpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IJX1KwAl; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGIAmi+u+xNcdCxMFNNg507dsJDu7HyTdFYxScDA2i7paJHOPNfSIGRGr+NGNTgS8xDTm1XzIPiPd0Vbqz0QlOCxR43dPmrp/G/0SHAlWJfGV8SzztfIin1PdFyy6yNPbRnYGZMANhMrJ3tUsrmmboDjYDxfl1rtnsV9s7TyDcljnskrYtQPIkyBenEJOEvPLqnFds5ym2DJCqTKcDqTVha76+tAnuA4tOBKkUFtMKGcH6S/Ar6Zg91JZ7ELTOQD00r8vrJRYV25MsR9Y6dlKRsuZyXb6s7r80WpRK1zBxim6Vo8BpOun7BZ+ycXooWSFzk9FzRxA8zmshutcd2lqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsEJBbHEFXd8YT5f5YBngvC9jmpr7LmqyTd0BJHkDYw=;
 b=qCoAnNpDVf2PMoay1DZdfr9XFuW/fI9QBfA/RHpiQOUBQm8iw56DAq+8qsLS/Q6fx9N34jqtfa4sxq+1UdKgirVDmznZZbCsb6EXuo0eSWF55xMLe1w0X5lZc+oigSxJ/UGjh1iqonPZA35QC0rjH5zTvzdeYANqFt/bCIU6/KLUmViTi+MvHK2RnODOev6fQjwjnxynMxAOCCnWnkIwAAuL7yar9sEX+NUxF3zyxFwMwdLExWp58GVwoeYmJEF6+LRh3AQicxn63Gl0jajMzb1vKhxYj0f2G0VlqTe8/ZZuL7tTEd2cP1xeaN8JT/V2tXe5m4aDnis0te83f2NgjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsEJBbHEFXd8YT5f5YBngvC9jmpr7LmqyTd0BJHkDYw=;
 b=IJX1KwAlerxJh78AYuSfdgn/DwTKsQJ9Puej9fxaS+zNeskgPinqiGWFXs5/ruZP/1dOoPRFajvnwlGOVnNMAUmAou8Jhg1TiVTNr5FHd0Ozm/EM8IHgdtFBXww5lk2hZjVNdo6mddR2WKDRbRl+bxF8IRQJFk4La2KcFRUB9zU=
Received: from DM6PR02CA0153.namprd02.prod.outlook.com (2603:10b6:5:332::20)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 18:58:43 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::78) by DM6PR02CA0153.outlook.office365.com
 (2603:10b6:5:332::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 18:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 18:58:43 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 12:58:36 -0600
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
Subject: [RFC PATCH 8/8] sched/fair: Uncache asym_prefer_cpu and find it during update_sd_lb_stats()
Date: Wed, 11 Dec 2024 18:55:51 +0000
Message-ID: <20241211185552.4553-9-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 8878dd80-0422-433f-b060-08dd1a15d58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqKff//UNUdo4zLeMjU1ZACFQl3jOLPEa3JgN9/X1w8P45smwWa9T9sOMUEx?=
 =?us-ascii?Q?DvCrghFWV97R13WNHeVcJkAYMVKP//QM2yTBX7gAg9SF1VPrgmURlxRTkHQW?=
 =?us-ascii?Q?u65CemaM3RCjA8TCgPuO0jPAjlL1MweX+l+KkLf74ZHiz8UorH01+1E9CtGR?=
 =?us-ascii?Q?rd2IeO1xOZ5Nwq0oBjNQVRNqmAB4xOJ8Hk/lbS5mwrqCGVSkDEHIn1GOgCIG?=
 =?us-ascii?Q?6CuumEOB3kSamj0qXauXmzmIO/en4L5m0ktUlZXj0IJrXC/xFfh3fxl85U4Q?=
 =?us-ascii?Q?ZjD7X3MB2I8bUkjd6KtuaonMbsrYbvtQp7hqtkyMZ5v+qUlW+fRkNbDwWYMd?=
 =?us-ascii?Q?CKBJ9VQqwv/4KlbgXNC/JB//GPpAzgjcmW9/rQRAmqq7XLsNxiA7WPoRX70T?=
 =?us-ascii?Q?eBr5TKBOZSaX2sUJIbHO1wdPNlrnsLnL75Q1EHSv00pzgrmxHPOcSij3H5mQ?=
 =?us-ascii?Q?gz6jP+uUD91oOCjEGwHrfsTXd3fOh0KP7lNREEq33NUqAiKv5QhnbXmgiotP?=
 =?us-ascii?Q?PzgIEKLW9yUPoJfmIDCB5z/H7IIUNE3siPrA3Oj7FxG8DfbQCtFztVqtzhP2?=
 =?us-ascii?Q?EVymDGjBSmGT1Hc+rbro5ZxAkocC6R8Wcle8rh4UDhzZngjDhAjjGbNqZRoT?=
 =?us-ascii?Q?+jdczIDWnP/8Dfsps/KndLtbiJOVZjYDXtJvUcy9t0C0nEInE0mecfkYcPee?=
 =?us-ascii?Q?dbgIQlDZYYo6nPY5nYvmqJ9IGPtL1XTa4YjuuqfH1DLJYZ2o8kbGpDwWaPjc?=
 =?us-ascii?Q?ncue87E4Z8YKfu7XHYMSJIST1NiTdde93bO9tkV+5w/NhYOoomuLMVhqt8fH?=
 =?us-ascii?Q?RgCnzaTj9jpf6axrBNoQkIGEmTTfrZCm4jgHqoCQUQBSMnLqKaR7du/5jNtn?=
 =?us-ascii?Q?COlxHkVqa/yLpWNrpU+tq9IA8mAXko0TQ463mNKY64jK/mgmWlwzoX9r6E/n?=
 =?us-ascii?Q?yde3cggAZi2plnRugdHkBZMP4VApxBFvm2QWztT/2S4D6h0CNVagS1tyJqoF?=
 =?us-ascii?Q?JqzdIPl3gAcTMvy4j8cTbyWOJmtRs0IXjeVEgAHANJjIfGlfuX+8y6Blurq3?=
 =?us-ascii?Q?+N3RreiibvtiW1XAE9HINxbvyyazZ+EVtE+E+dAX2e5aDm/bLTonxG321em5?=
 =?us-ascii?Q?nwPIWpKD+7+KQSicF+e7qjce+6ReYAqT1sEdTYIHpV+UyMvjDgZk8PjMNDn9?=
 =?us-ascii?Q?1rwFU/zy6mHN5Hw4T7W2jzZnhtRQ2kdX6G53IE/tIGdt3i5QK429H7j+t/dM?=
 =?us-ascii?Q?+knekRl1tfJb6R1FGhzjhngR6ApkgdKdSZsOVJiwazbqTnEd5hbzH3XpPKy8?=
 =?us-ascii?Q?ee5hplaKOHwfxMg3yznf+CDKSl2TbmoYiLJUBqU54JpDP7WHp+r86nK9Yb1C?=
 =?us-ascii?Q?05+E4gJNbWVu+idFAPWWrHTMyHbrr5L39Tmh6L5K1syn3yFxrfa6gNaPLso8?=
 =?us-ascii?Q?4mHlIfy0oj7MiRxIQcENr80IrZAX7r2v?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 18:58:43.4227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8878dd80-0422-433f-b060-08dd1a15d58d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108

On AMD processors supporting dynamic preferred core ranking, the
asym_prefer_cpu cached in sched_group can change dynamically. Since
asym_prefer_cpu is cached when the sched domain hierarchy is built,
updating the cached value across the system would require rebuilding
the sched domain which is prohibitively expensive.

All the asym_prefer_cpu comparisons in the load balancing path are only
carried out post the sched group stats have been updated after iterating
all the CPUs in the group. Uncache the asym_prefer_cpu and compute it
while sched group statistics are being updated as a part of sg_lb_stats.

Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c     | 21 +++++++++++++++++++--
 kernel/sched/sched.h    |  1 -
 kernel/sched/topology.c | 15 +--------------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3f36805ecdca..166b8e831064 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9911,6 +9911,8 @@ struct sg_lb_stats {
 	unsigned int sum_nr_running;		/* Nr of all tasks running in the group */
 	unsigned int sum_h_nr_running;		/* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
+	unsigned int asym_prefer_cpu;		/* CPU with highest asym priority */
+	int highest_asym_prio;			/* Asym priority of asym_prefer_cpu */
 	unsigned int group_weight;
 	enum group_type group_type;
 	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
@@ -10243,7 +10245,7 @@ sched_group_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group
 	    (sgs->group_weight - sgs->idle_cpus != 1))
 		return false;
 
-	return sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
+	return sched_asym(env->sd, env->dst_cpu, sgs->asym_prefer_cpu);
 }
 
 /* One group has more than one SMT CPU while the other group does not */
@@ -10324,6 +10326,17 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 	return check_cpu_capacity(rq, sd);
 }
 
+static inline void
+update_sg_pick_asym_prefer(struct sg_lb_stats *sgs, int cpu)
+{
+	int asym_prio = arch_asym_cpu_priority(cpu);
+
+	if (asym_prio > sgs->highest_asym_prio) {
+		sgs->asym_prefer_cpu = cpu;
+		sgs->highest_asym_prio = asym_prio;
+	}
+}
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -10345,6 +10358,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	memset(sgs, 0, sizeof(*sgs));
 
 	local_group = group == sds->local;
+	sgs->highest_asym_prio = INT_MIN;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
@@ -10358,6 +10372,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		nr_running = rq->nr_running;
 		sgs->sum_nr_running += nr_running;
 
+		if (sd_flags & SD_ASYM_PACKING)
+			update_sg_pick_asym_prefer(sgs, i);
+
 		if (cpu_overutilized(i))
 			*sg_overutilized = 1;
 
@@ -10479,7 +10496,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 
 	case group_asym_packing:
 		/* Prefer to move from lowest priority CPU's work */
-		return sched_asym_prefer(sds->busiest->asym_prefer_cpu, sg->asym_prefer_cpu);
+		return sched_asym_prefer(busiest->asym_prefer_cpu, sgs->asym_prefer_cpu);
 
 	case group_misfit_task:
 		/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aef716c41edb..a3f0d326bd11 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2047,7 +2047,6 @@ struct sched_group {
 	unsigned int		group_weight;
 	unsigned int		cores;
 	struct sched_group_capacity *sgc;
-	int			asym_prefer_cpu;	/* CPU of highest priority in group */
 	int			flags;
 
 	/*
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9c405f0e7b26..20aa087710f0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1302,7 +1302,7 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 	WARN_ON(!sg);
 
 	do {
-		int cpu, cores = 0, max_cpu = -1;
+		int cpu, cores = 0;
 
 		sg->group_weight = cpumask_weight(sched_group_span(sg));
 
@@ -1314,19 +1314,6 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 #endif
 		}
 		sg->cores = cores;
-
-		if (!(sd->flags & SD_ASYM_PACKING))
-			goto next;
-
-		for_each_cpu(cpu, sched_group_span(sg)) {
-			if (max_cpu < 0)
-				max_cpu = cpu;
-			else if (sched_asym_prefer(cpu, max_cpu))
-				max_cpu = cpu;
-		}
-		sg->asym_prefer_cpu = max_cpu;
-
-next:
 		sg = sg->next;
 	} while (sg != sd->groups);
 
-- 
2.34.1


