Return-Path: <linux-kernel+bounces-559119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86450A5EFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCEA188F6B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE92F264F90;
	Thu, 13 Mar 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JOQgdK3r"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAAD264A7C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858764; cv=fail; b=VezVFZSbVbAz9kYb4uThCFVpdmRfkhmHnDs2Ss6KqsVB6qq7Gdh50qxJKY0fIc+IGjJcs4KnrZ8FNjEhjQViSO661aCtFqYhxKho3djx2YbVH90mvDOeTat9aEfnp/YmxIGUQ69NxveRkMkGB+aZr9Jswdm73ZM+i7qav2q9vJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858764; c=relaxed/simple;
	bh=azqloHhRipsP/t/aybbzJgRwh4C2dDTEMfbmpHJ4mBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9ZXRD8w58EIQkoQ6JFMOuYH0GJxu11axcP9yiL+o26xZwnySVESgM3XL4QgncHuuVpD27Hi5qponDDSHHuc2ASaxnt3M/ZrX+4weN/8pCieuzZvvp6ylMXD+3LeLPRdvkvaPWx31WEnptoPSATXuXGoEUEOmZEQZAGEGXl5EnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JOQgdK3r; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlhMSwn82EKiPBoly6BfJPYt70uZZYcoDOInUOKVNpZN4moojw+3thIavPOX0EEVX8pbdzgQ1cc0qqjpdvKdgCZPFqNagg1E9mwz8DxMMuVKd1legZHr86a3OO2SVnIiAnhNLqsJmUXX+mmXdmXjALGKpSEpsstjAuUNCmICisd5OGujPsCG44md526Qqyajni66BUnce0NIZ81rNTPk1T8dD8PoFF6UMMnt7688Wod8EdSpyVxox61aUOS9paZwC71JnF0EUmxkoDiKaQGBR7g7YTjMpbS0A+jIs9tVm5YmBd85QJJ0blupDbfnCOy93R5voJfbpc3ffyRGQJ4TRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQga1b8EBcWCeOnkEzr9HFTRrZrpSoTZQOooNme1C4w=;
 b=TevpHQtmQiKTTlMTEEVI2iZzZJEGpJPf/zGfeEWTyyPv5icF5VCnBkxa2LCWHoDqlsM58EFeiUkfaqJvB5+OOiSU4DB0G7eYUI989O9s69g3egfFGb2ZcJ2xSbDLpt6kUEwGzLBqRNVyTXPGQYZkNUfzEhiVKqYgwsvFy8NZsvoxU7qUOl6aABZVVOpclI/8SbsyedF053wWaNH0UHFlunh3rirGLtXGxgf1L0EWVBBe5l4/F9tOygfEt3tv4pEGCCdb+DJLPuG9ZJxVwkWUlsf+eRIGWmb/XV8294RRBlRfLmLJf9SkkZRvYb4JamhWLSPMcs/LKw46QTSYbpHvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQga1b8EBcWCeOnkEzr9HFTRrZrpSoTZQOooNme1C4w=;
 b=JOQgdK3r6N+zMO1mvIxF4HVCpMAB3ZleDl6q9z9ZRXzmpA7KvJdHOEP4+I054r5TXzzGDPWrCmOJQIeKbVP7EdfcjF8guYNqI7UZw0j6+VAsfGg1ggc4VJ8EqaS5EzCTUREINJZd7BS5pl4H2H71AByvKwcLrSXwjDs1neaUoF8=
Received: from CY5PR15CA0114.namprd15.prod.outlook.com (2603:10b6:930:7::28)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 09:39:18 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::af) by CY5PR15CA0114.outlook.office365.com
 (2603:10b6:930:7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 13 Mar 2025 09:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 09:39:18 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 04:39:13 -0500
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
Subject: [RFC PATCH 4/8] sched/fair: Move sg_{overloaded,overutilized} calculation to sg_lb_stats
Date: Thu, 13 Mar 2025 09:37:42 +0000
Message-ID: <20250313093746.6760-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ca330a-d571-4774-08e7-08dd6212ed2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?09dvs2dKthOE9EQTxUXh4C8ZcsSejKNK7QimJz/PS52O+qkyagtXWmWrQBul?=
 =?us-ascii?Q?Z7z9KfKbMgfWfMiDyAiHHIXcF+4YE0pvCyY8ai9y208ZfeEeAF+gOFhiswSH?=
 =?us-ascii?Q?DZmcOXAFL8KXXCyvbJXYg9qSibv+IPtf3D5BGpcRkzL1POpeshu1Zte/GG33?=
 =?us-ascii?Q?Ir7diBjH3b/sZz8M4NpTAfQ6eNsGBV5jyvE4t59xUZd/4o6oovZRkGFYhs1V?=
 =?us-ascii?Q?457p+f+9wSVdz7A8bsRo6QFg3JrE5Bch20UR4juz3QObVhYXAhQgkKoxqtZN?=
 =?us-ascii?Q?d6a9ctJewnWRLzCNGFtUy6h2y3IW68cQgtHROwA9AqsnhCY03H9/SwQKeNNe?=
 =?us-ascii?Q?ihUUy25AUfLyWl6PVCk8OWqKHuqdNdFdTsSaXp3cVz6+boUxNJqhx5IygcWD?=
 =?us-ascii?Q?VMZPz5v2MuQok6O5EClSS7brRqYFbT5xmffJJO9tQ1UxQMhaPpngdZ9fMRez?=
 =?us-ascii?Q?RktiS9tfElSKNInyho9aLtMpmwZ17OsxXiqwUp5ypOEOBgqOGNw/vQItjL/y?=
 =?us-ascii?Q?/4dUd2749ubebYzdlFB5m7d0+80JZ6P4W28GT75O2lUIutTeGx2YI88HDviB?=
 =?us-ascii?Q?X3bEZMnI1xumSQuBK8GJh24gokeX98h2i/3D8aWFOKU4wJPx4SondyVdmnF8?=
 =?us-ascii?Q?KUyADVBHol4Fn6LZrrp8udHnx1NOo91sCxWACVmPNlgk9ujXKcvfDlNKVsTW?=
 =?us-ascii?Q?AsLSdLwqcKF77TJF3J2Gdj5VEnPdJBut0eslW5zkwLPlIkmlmGUmJA6A8vIL?=
 =?us-ascii?Q?McK9tZdOoqof2Z+uJWwIFQ07N/2Euw2eEOXJSQTf8/zKumUUpNYvj4bKdLsU?=
 =?us-ascii?Q?YlvDDpW8nOzad4mftU9XAQchq0lHDvL1rS7B5SWPmTo+IlNbYfo1Pdjp8vb1?=
 =?us-ascii?Q?hFNoGcFYdcCXycvNRYZLBJrN+DgiRCP3pX060iwkQFuMpbq+XFOQG1z6lh4g?=
 =?us-ascii?Q?GpvZ1s7+igmUV8qpV2iMaFPVtLtjDyObHxKqksPn4rYJiJP8/ihiX2ObF6H7?=
 =?us-ascii?Q?dKLoMecgvbKY6DRAqHBod+87hP3sdVwpL1gBwNNNYMbbLA8ncRxXXwTPcOad?=
 =?us-ascii?Q?xhGXj0ib+fBkzKruH99DriFSfcXmdGT53WH+Sa7d2K5URUB8EkLAdOtGlcJ4?=
 =?us-ascii?Q?CnEJCVQHVs/PjmRoAg9gVxneYBaz72otaphrd6sTC+hhEuM8NRU9y/rrwvdw?=
 =?us-ascii?Q?M/gQ1csJY5qWZKAfrKqeTosnMgMibWR4GkkvDJOEVlZ2bw6cp/6HVmLHq91W?=
 =?us-ascii?Q?+jyO3UR9l1zPg36aXHp3uHOMI+GPncphDZFp1ybl8OyK+OKsTFoq2Zf/f6Kp?=
 =?us-ascii?Q?Hkt2PEqDS6DcpJVff9fVx5rIaoY5auKJMvZIDEJ5Wm0qmwHYwbsfyoqYB0ka?=
 =?us-ascii?Q?as6UQBz9oWe8lIjui1FCQx3N5k7zqVr8UGmXrT+AI46daV+4AjZSzFg1xlbR?=
 =?us-ascii?Q?UN8AGrQyWcNXASvPcRXjFZUzX6MuBBGeDSLDbRIFqT5g6i5O+/vXyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:39:18.3116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ca330a-d571-4774-08e7-08dd6212ed2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918

update_sg_lb_stats() used a pointer to update the group overloaded and
overutilized status to propagate to root domain. Discard the pointer
passing and use a flag in sg_lb_stats struct to indicate the overloaded
and overutilized status. This will be used in subsequent commits to
propagate the overloaded and overutilized status up the sched domain
hierarchy and set these status at highest domain.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c  | 14 +++++++-------
 kernel/sched/sched.h |  6 ++++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 39bee40dde27..3b1ed14e4b5e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10287,9 +10287,7 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 static inline void update_sg_lb_stats(struct lb_env *env,
 				      struct sd_lb_stats *sds,
 				      struct sched_group *group,
-				      struct sg_lb_stats *sgs,
-				      bool *sg_overloaded,
-				      bool *sg_overutilized)
+				      struct sg_lb_stats *sgs)
 {
 	int i, nr_running, local_group, sd_flags = env->sd->flags;
 	bool balancing_at_rd = !env->sd->parent;
@@ -10311,7 +10309,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->sum_nr_running += nr_running;
 
 		if (cpu_overutilized(i))
-			*sg_overutilized = 1;
+			sgs->overutilized = 1;
 
 		/*
 		 * No need to call idle_cpu() if nr_running is not 0
@@ -10324,7 +10322,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		/* Overload indicator is only updated at root domain */
 		if (balancing_at_rd && nr_running > 1)
-			*sg_overloaded = 1;
+			sgs->overloaded = 1;
 
 #ifdef CONFIG_NUMA_BALANCING
 		/* Only fbq_classify_group() uses this to classify NUMA groups */
@@ -10340,7 +10338,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			/* Check for a misfit task on the cpu */
 			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
 				sgs->group_misfit_task_load = rq->misfit_task_load;
-				*sg_overloaded = 1;
+				sgs->overloaded = 1;
 			}
 		} else if (env->idle && sched_reduced_capacity(rq, env->sd)) {
 			/* Check for a task running on a CPU with reduced capacity */
@@ -10982,7 +10980,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sds, sg, sgs, &sg_overloaded, &sg_overutilized);
+		update_sg_lb_stats(env, sds, sg, sgs);
 
 		if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
 			sds->busiest = sg;
@@ -10992,6 +10990,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		/* Now, start updating sd_lb_stats */
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
+		sg_overloaded |= sgs->overloaded;
+		sg_overutilized |= sgs->overutlizied;
 
 		sum_util += sgs->group_util;
 		sg = sg->next;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index dc9d6e4c704b..9372a75ab3cf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2159,8 +2159,10 @@ struct sg_lb_stats {
 	unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
 	unsigned int group_weight;
 	enum group_type group_type;
-	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
-	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
+	unsigned char group_asym_packing;	/* Tasks should be moved to preferred CPU */
+	unsigned char group_smt_balance;	/* Task on busy SMT be moved */
+	unsigned char overloaded;		/* Contains at least one overloaded CPU */
+	unsigned char overutilized;		/* Contains at least one overutilized CPU */
 	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
-- 
2.43.0


