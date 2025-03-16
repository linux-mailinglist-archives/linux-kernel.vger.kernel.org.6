Return-Path: <linux-kernel+bounces-562945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CBAA63502
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B27188F882
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB16A199924;
	Sun, 16 Mar 2025 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lzRWuQAr"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D11188587
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742121077; cv=fail; b=P9LeWvrZpcskxvwVhtPcX/uskIo6zn6kDWR80MJ7XymKVsj/HJRbQiTPfg8sn+rnmfsA+VnJR3M5LgvmGJFOaZ6jxZqG4ZdX5otj4ljQX8X5wLO2oNzggSqTyZp/uFOji9Zv1iqK1V7ESx8OTBK5RnX98GLTQosQcNs6MJ6k/ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742121077; c=relaxed/simple;
	bh=MinsjhYYMbWWT2d4h40ItM2KedtpUi+LpPU6x0XEe+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdMlJeKQLKrb7Dck+zLDd/v/CuY24DCIEoDHJudWkiiShc3ykmUuM4FtNPng03uaNqxglDTF2O2MJHRmk+3JEJOl2oCImhYdmcdx16G2uoKhIAkEceNCtPITc486imwA897+2EYvipTenVm2xpqths/hHXp6/Arv9BxF6qXq5cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lzRWuQAr; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSXeGPmwy1bLcWXjxR8x+Wwb2PDG1d6JYEO0pzygiah9dZNtwAdSXiOaPmSsKSzYhbSLl+Co+YaGbFOpf5ea3ZJBKkOP4vfTOqs6TmK3RQETty6Stvamj2yRxLxK2eew3T7sGcu51ENQifh08p5Hns1/7OZysW1H0yAAyCHcChmhjoJid1ciaI2Q8+QGDfVeujhIrhZLtJaTJ4sCtW4IZLwJe2lMVMiK+jcUqd3QaIv6sWUPQx6uIme5JKG861K0S41AZLQRvmIfin9j5JwMYxrQdOTfNiefayE611lmK7UHVJ+u1ekEqNKKZvo1ZSWKQPni5WEbez9QmgV4zMUdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYgIuba+so9S7IdErF/MdN92/mVyNcfY/VobhY1kcV0=;
 b=TfrZGxvcAWlTwnHD72FbnR/qHKY1xoMnucOSUDn/yqMa2Sxs1bbzeERhlCAMmdUM7Kp5vVJDmfapPfFagCK/Ua+zXHa+BZzzWYQqaJRGaDeGrT8AO5e4cnwMfLF5HPOAA/puoWaykMDxDNHYE1MSsca0CI9oRylbCo3V3UfmEAenDegNQDtR86NKFgotVg4B+RK0Btb1V3oygxOEVbjw9gBVoBs90LGoteY8Q24ZycF8B3hiff6NFi5c5UjoQrciCi+jRMZbBdAx++XRhelUBBXJKeQcqT/OOJiSL+gRl5iKrcJDZZfsY1nJDlM39BI75phN6VUq4a4EdFvv/DjOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYgIuba+so9S7IdErF/MdN92/mVyNcfY/VobhY1kcV0=;
 b=lzRWuQArNcXf9QaBZBFgAjGaUzVhm9XYSaRdxgnOP96EC8bGNBiLGdieqoWl5rqqrI/YGGn4PyLW/9jSQ4WUUDlUo4Dq6IMpFBipVHZ+IRB6kkIVRkbhEInAoiKB8OkYYFuYjwaG8CGoxRNsEOUdUqCIcSoO6hwoRrG5FOYPFjQ=
Received: from BL1PR13CA0186.namprd13.prod.outlook.com (2603:10b6:208:2be::11)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Sun, 16 Mar
 2025 10:31:08 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::be) by BL1PR13CA0186.outlook.office365.com
 (2603:10b6:208:2be::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Sun,
 16 Mar 2025 10:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 10:31:06 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Mar
 2025 05:31:01 -0500
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
Subject: [RFC PATCH 14/08] [DEBUG] sched/fair: Add more lb_stats around lb_time and stats reuse
Date: Sun, 16 Mar 2025 10:29:15 +0000
Message-ID: <20250316102916.10614-6-kprateek.nayak@amd.com>
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
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: dc699145-e295-429b-ab5c-08dd6475a8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fIzAeAfdylAs1JGxK61rnBqK5cevZb1mEaVSfb2X3Cnkd8vlSC6blQaxSXgw?=
 =?us-ascii?Q?9W/ci1JYzHZ/kFOPnF2ByNRpYnEHPtTc+ABhIzbnpVijqIxHYkxinmI7T869?=
 =?us-ascii?Q?tT2Ft38EyfjO0Vk3Jvz3ypJefNK/QMH4+MpXTh9KlIZ3KBwAifWtg+QVPCaU?=
 =?us-ascii?Q?VaAe7QVANYM7WLRPJU/llcyqEWgC02E1BCgsMhm9hqz9sf6q9KBpJTA2paEj?=
 =?us-ascii?Q?tcPGjKXNlrNTftwabeLlMs3xT95tNyR7gljIPKdRRCjLgBYZ2F5jJHZvqu/Y?=
 =?us-ascii?Q?9AIk6C26o+0wiSeolikrV164Vs1ZQf8lf3Y/ckE5wk8GsfXJqThszpHmlyb8?=
 =?us-ascii?Q?1TO+8stgfmZR7zP19mB48nqlNS50JQ9oqssXfxZdNi/cq3j/AVFmECJmotYD?=
 =?us-ascii?Q?J6lU/htm77zHe+JrO6uVovVMN7iGL1YRrtYnxmXN6t0IlZlyPsZXKIWJdYCQ?=
 =?us-ascii?Q?0lg07iupKQUokxPgkPVkXon4JV+4GYG36/uQWzsW7EWnvH/cbqVFaT1AehrV?=
 =?us-ascii?Q?qBFfbo+EcsJZ/NzN+sCa8GWUn8Z7ocMN8OJLfcRRgPj2809Q/J7SmtVbvkco?=
 =?us-ascii?Q?9XZnP0d0iy1w4Or5hVoDyZZv26ifhne+PWuHAxlxCBiceKbxMsonrZ22IfXx?=
 =?us-ascii?Q?IstnayxjU6mtzBRXO/tvwo04PUXYLI1Wq4vZ+B0TnGJICXTtjB91MiRNyXFg?=
 =?us-ascii?Q?1DVx1AXOm3Hjv9Oz5yBstQ4bRQtgQZQAAQbkeQJ+EP6HHzBlAhXiOewVQUT+?=
 =?us-ascii?Q?zsBglUk5XGhrM1+4BitZUfw6ELLdXFTehNryu40SM7EOWD4C9IfGMSOpb931?=
 =?us-ascii?Q?/z1dV+0iXygRH9lIDpb4wBjAJtB3SCYLKPvpautc4gsvrXbReMZ9UXWwgd+x?=
 =?us-ascii?Q?0TjyEuY22bc3qJ9l3wGXtq0VIOWxOt+m5gqhceq96pPIM7Zis4qCwFcjMbdu?=
 =?us-ascii?Q?Nx5RRZp203XvjMuvh8oI19bslCuvuD1Sk/PNC0iMZwzrJw/jisUGxDItdZ/P?=
 =?us-ascii?Q?eRPvxgwGDUSbE1yvvhQhZjl9Qu1F3voj1wynZPfSWQ7lD8NG1gXFy4yIYUYK?=
 =?us-ascii?Q?rBB7AZMUn9wurkT8P65Oys0GkLGghl1IDQZ212N97t5f6/szX8Ww1eVPAj5A?=
 =?us-ascii?Q?gzVFoxCe5LLjbQ5OdkosJ9Vs7g5tPAKxXD6c7yC37x668KL6pL4V5Nfby+SY?=
 =?us-ascii?Q?YdYJUoPEtOxBlpYOTeoJJMYFz8VVmQ8bAjS5O9kj71pxOvUttFhK5iy1u0o7?=
 =?us-ascii?Q?Yn2GK6WhojWjBkQX2qcBhgAXqwJy221QY1HNhvvxcSxz7lAU33B/+HSjP8bI?=
 =?us-ascii?Q?HwO4Z9fqzLyaXAy/Af9CZHkKJE6g0+WOUxMXKMRObF2pJPBPHKHJFsOSg6sr?=
 =?us-ascii?Q?SqDKVbvPYjgpMOut3a90JbPijMlkuqm9CZIIieoZrSVQN24qRX+ySRMcOT7Y?=
 =?us-ascii?Q?4myoVhgpjuUA4uAIv9RsXAzRtOQ9KbW8MgRKMAd+rGAZ8lJYV3/hkPjo46vG?=
 =?us-ascii?Q?byz2WeTS5KwZJQA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 10:31:06.2143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc699145-e295-429b-ab5c-08dd6475a8cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661

Add stats for load balancing time and stats reuse efficiency.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched/topology.h |  5 +++++
 kernel/sched/fair.c            | 21 ++++++++++++++++++++-
 kernel/sched/stats.c           |  9 +++++++--
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index a16d7d9dd9d3..dea65eb263c6 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -123,6 +123,11 @@ struct sched_domain {
 	unsigned int lb_hot_gained[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_nobusyg[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_nobusyq[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_min_time[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_max_time[CPU_MAX_IDLE_TYPES];
+	unsigned long lb_total_time[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_stats_reused[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_stats_recomputed[CPU_MAX_IDLE_TYPES];
 
 	/* Active load balancing */
 	unsigned int alb_count;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 31501b933d45..bb7b21421415 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10491,10 +10491,13 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	 * group_smt_balance is not possible under busy load balancing.
 	 */
 	if (can_retrieve_stats(env->sd, env->idle) &&
-	    retrieve_cached_stats(group, sgs))
+	    retrieve_cached_stats(group, sgs)) {
+		schedstat_inc(env->sd->lb_stats_reused[env->idle]);
 		goto group_classify;
+	}
 
 	memset(sgs, 0, sizeof(*sgs));
+	schedstat_inc(env->sd->lb_stats_recomputed[env->idle]);
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
@@ -11901,6 +11904,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 {
 	int ld_moved, cur_ld_moved, active_balance = 0;
 	struct sched_domain *sd_parent = sd->parent;
+	u64 lb_start = sched_clock_cpu(this_cpu);
 	struct sched_group *group;
 	struct rq *busiest;
 	struct rq_flags rf;
@@ -12174,6 +12178,21 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	    sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
 out:
+	if (schedstat_enabled()) {
+		u64 now = sched_clock_cpu(this_cpu);
+		u64 elapsed = now - lb_start;
+
+		if (!schedstat_val(sd->lb_min_time[idle]) ||
+		    elapsed < schedstat_val(sd->lb_min_time[idle]))
+			__schedstat_set(sd->lb_min_time[idle], elapsed);
+
+		if (!schedstat_val(sd->lb_max_time[idle]) ||
+		    elapsed > schedstat_val(sd->lb_max_time[idle]))
+			__schedstat_set(sd->lb_max_time[idle], elapsed);
+
+		__schedstat_add(sd->lb_total_time[idle], elapsed);
+	}
+
 	return ld_moved;
 }
 
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 4346fd81c31f..b2ace3c51062 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -141,7 +141,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
 			seq_printf(seq, "domain%d %s %*pb", dcount++, sd->name,
 				   cpumask_pr_args(sched_domain_span(sd)));
 			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
-				seq_printf(seq, " %u %u %u %u %u %u %u %u %u %u %u",
+				seq_printf(seq, " %u %u %u %u %u %u %u %u %u %u %u %u %u %lu %u %u",
 				    sd->lb_count[itype],
 				    sd->lb_balanced[itype],
 				    sd->lb_failed[itype],
@@ -152,7 +152,12 @@ static int show_schedstat(struct seq_file *seq, void *v)
 				    sd->lb_gained[itype],
 				    sd->lb_hot_gained[itype],
 				    sd->lb_nobusyq[itype],
-				    sd->lb_nobusyg[itype]);
+				    sd->lb_nobusyg[itype],
+				    sd->lb_min_time[itype],
+				    sd->lb_max_time[itype],
+				    sd->lb_total_time[itype],
+				    sd->lb_stats_reused[itype],
+				    sd->lb_stats_recomputed[itype]);
 			}
 			seq_printf(seq,
 				   " %u %u %u %u %u %u %u %u %u %u %u %u\n",
-- 
2.43.0


