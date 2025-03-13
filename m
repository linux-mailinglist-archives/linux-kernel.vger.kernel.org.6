Return-Path: <linux-kernel+bounces-559124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14239A5EFC4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A1019C08F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6309264A7C;
	Thu, 13 Mar 2025 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s2H+CjOh"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDA2641D5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858819; cv=fail; b=epxP8mTJU+pkzfZc7QR4Nm4V9uV/xZuR5zvpntyoPDYc7RZpUGp2HOMns4xlKHjYCfgoR5m3XFYNEqWgIMWWYiPXjoY5MWIbXoakUbxvaVourV/uKCbhUzXeBRP9/pilA55ac6Ma+zNWyXZCPxVCebkI7ToMIalgnBIP2cm5zIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858819; c=relaxed/simple;
	bh=es9pVx2HhSueI0Mwksv+y1j3/Hm7M0odaToMzS28rtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pN4WIlW/BO/Q5hvlbg4ekFMVN+4l+CZDxjnRcaSZpS63lyddHxutaAIIURAKoB8H6R4SMUb1qvWyEARA+dZcgfS6JJRAp+gh3bNlF0tL7k2bql67AtN49gbJ3rFhuB9ITp0y656nYhRw5cLBeevtl2g5z+lTJeUCF/RXSgXZGpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s2H+CjOh; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j15vRzY9V3zjj1DeD0HsRRsUHjyvv44pLrXgKyvhiobKVvqdmQ2MP/esNWK8mTgs23Bas5PUpUG+XXx/Q9A28DJE4qD9UAcHXHaa1MSebkBW8pS45vF54q6LcR/y4LZIj0hrWH7JktKvb6PNu1jPt5u+4IuTJX1TfY8a1+8EGJ2eKm9zwVQE1PI7wboU5dPjQrHXktAtfazTWDXFqK/1tcHoN4AZxm61u8G3SqZGTT/lOZWMncy8W31UGAKWFknsf4UMWhwVZoFwKhovAgKyoBjK8497iQlQ3R+zkGtL2C/aNU7LNLgMJj9ueJmljWogVq2mQAaE95EHQZjIVmh9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gJNKOqMGALhKZBgfD/6DKGI47PKEPHqifwKQMim4Fc=;
 b=PU9YTtFC9DEfha/wmfm9EF5DPYeeSI0jSXAkj3SgFnial0OeLcyIFrs9qP/A4DkHhhtMkPbGriu6YtQ+yy2M4qYOsnoX1qpt0PhrwqQkk3hNG+nno16Db7cxz2z0b1WMHaVzVWGxLTPSrcTGkAR8IfO4Y8I9nRzWk5LyGRFlX4uBhDAyVALm/QcQxiu9OFhoagVNOAyfUdMo+DOwQuMqXKi4naER8mUm7vtERfMtfpJeHf0ff0zVmdKASPgEUdMWn4buw3PYteEdIOqsh/ZjGBx/xRuJHcBWBwexfWUWTI7reppYV4HNcPYzqdnltJndc+vVONb+Q0aL8CjLFrWaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gJNKOqMGALhKZBgfD/6DKGI47PKEPHqifwKQMim4Fc=;
 b=s2H+CjOh8DEj5ps7P6nfm4cWoC30VfrJnd/xBqTGYJW/LXfurABoJtoFnx1WkJ1Cx7Lrnc1xVtRbyvWzRazkL25mOdYzxs2giFDP0f+px7p6YmAY3WawyxOy8MJQy+WgEj6PWrQeryFwa+sFZXt3nkt5tjbrp8B1jivKot42Itg=
Received: from MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::26)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 09:40:13 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::ae) by MW4P223CA0021.outlook.office365.com
 (2603:10b6:303:80::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 13 Mar 2025 09:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 09:40:12 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 04:40:06 -0500
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
Subject: [RFC PATCH 7/8] sched/fair: Retrieve cached group stats from sg_lb_stats_prop
Date: Thu, 13 Mar 2025 09:37:45 +0000
Message-ID: <20250313093746.6760-8-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c35184-9c45-49a2-9cff-08dd62130d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?60l77rToGuxyzt/C/GCDm+ozCqnDvgjkC4LftdKI+4bKCQp5RZ/iwrTtjzOx?=
 =?us-ascii?Q?Z5hIIR/EpTv3L/fqxEbiofKdoLENMYKQNjz5TyClr+YbOL3fd9fUKtTkUk1q?=
 =?us-ascii?Q?KUnzMvbZG0STI+V5npJPiH9CwAAXo3OQh2NRLgo33MmlnRrf39cM1wipIDnU?=
 =?us-ascii?Q?YeLzHik/hAzy24EOz15SzSYFdh6VCdZ9vMhZLulVRzedmWdwiF7tPaMTtjRV?=
 =?us-ascii?Q?T0jyj4S7rmSdW3oyI+XsNlP+OojFUaSncN8OQGU5HFzvIrFF0lUmY6TjrpVu?=
 =?us-ascii?Q?OsyiAhQX1Nx2EYj3//s2pYY5KLeQND+3kpC0UqZImrUQ7ySsIg17gESkakdn?=
 =?us-ascii?Q?Ce7HSPI/e0rwhzjBWsILhCR35q4KW1RkMdakNcytnD4Q5xVtWfogOTAAsq8e?=
 =?us-ascii?Q?BdNOxSV8SwFpnRR7G2Lr6Zhdo75ahunszyMoDESefFdJ9eS7ukIJ1R0XZy2m?=
 =?us-ascii?Q?C9vZBWLFagZ0zceWVYIpialKNqGTj2puSh7gVM2aPiMBvlD9H5hZ6PKUjtkm?=
 =?us-ascii?Q?aJXwEFU2v7I7H+5duOAplfuS/9evGmeD1D5KaQKVjzS+mNHBWNiLjW04z3U7?=
 =?us-ascii?Q?/ZvfdIpSIDD7wPZLR0ZgoN57ulN6sSBVEJNYPaKhtMevlBiy1RHY2il28Ve+?=
 =?us-ascii?Q?m46o4jZvIgtgPytwEBn4+3nHgiVYzV8q+t74aVU1Cu3nATrRu+G3ba5NzR+B?=
 =?us-ascii?Q?AeEp8SI/fne5fvt3CbiVFRENWX36V/Xi84cusrEgXrVb0kXAXjzQBkf1pvEA?=
 =?us-ascii?Q?Gy10Fox+rjOWVNahWzX6DAEwVOfrTyu5SdQ0IZu8KSamP/NLeHE8UnCVsKWe?=
 =?us-ascii?Q?552m4OPTVrK/pOEi8e1i5gdP5umIn6FOLwC/ZyYZ1AT7BX119plXa1720Cf/?=
 =?us-ascii?Q?lVCuNV8SThk7LLhMRM55+Trhqxx2/cUzcDwiQfa9c/v1Hb2mOhctj626niIK?=
 =?us-ascii?Q?3c7CWQfyTuIWhUbfqfGG92DTfpgaCQyBOIBLD5i2QSopnbR8UOYl6DrwyYkh?=
 =?us-ascii?Q?9+DguIhJwNWlJM/jgLxCFQhxNxzGUbvaGGXl69NDFXPCv6QYtBHfgBUNVLyU?=
 =?us-ascii?Q?VsGxVBOry8YcIwq8H1g3SPoEV3vsV+S7ik/8soGi/k4NUJawCmVhwcG2uNvZ?=
 =?us-ascii?Q?+2jFUvtcO1ec69hbJplOeTA6F15vzDi9zkUa6up1mFNKq4j+90Rs9FqmOPjC?=
 =?us-ascii?Q?zHZbT6jslmA18/F6l8bREx69kBQAH3APvPm/USEr8JiEMdP1FT3GYIyRZUKm?=
 =?us-ascii?Q?du+q63dHNeeKSzHI/NZ8LRnxsU2DXrEmBvr2FAqwG0tQqUw4zaGWe4sLgXs1?=
 =?us-ascii?Q?9Wp2ZmmpMMnPz/C1aFZYeafK7jk3tqeEnq/yRawhqzassSpLOPX114bdpsvW?=
 =?us-ascii?Q?yALSxIZ3z0EtGWmr5DB1MlCeoi4G3B4NN11pYpPv7fD9VIcJbthRHNkm19rU?=
 =?us-ascii?Q?XOVMVEfLOzkjsn8h9++sE2PkwPZ0hfqkMuGzVhB1Q/SUZIsJPt5gnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:40:12.6654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c35184-9c45-49a2-9cff-08dd62130d88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104

Allow update_sg_lb_stats() to retrieve the group stats cached in
sg_lb_stats_prop saved by another CPU performing load balancing around
the same time (same jiffy)

Current implementation without invalidation of cached stats have few
limitations namely that the stats reuse is limited to busy load
balancing since stats can only be updated once a jiffy. Newidle Balance
can happen frequently and concurrently on many CPUs which can result in
readers seeing inconsitent values for the propagated stats.

For this iteration, the focus is to reduce the time taken for busy load
balancing allowing the busy CPU to resume renning the task as quickly as
possible.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 83 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 60517a732c10..3b402f294f0b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10275,6 +10275,75 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 	return check_cpu_capacity(rq, sd);
 }
 
+static inline int can_retrieve_stats(struct sched_domain *sd, enum cpu_idle_type idle)
+{
+	/*
+	 * Only under perioric load balancing can we ensure that no concurrent
+	 * CPUs modifies the stats being propagated upwards since
+	 * should_we_balance() can allow multiple concurrent newidle balance
+	 * to progress and an idle -> busy transition for idle balance will
+	 * require the stats to be recomputed since idleness metrics will
+	 * change with migration.
+	 */
+	if (idle)
+		return 0;
+
+	/*
+	 * If individual groups are separate NUMA domains, migrations can cause
+	 * preferred task statistics to change and will require recomputing of
+	 * stats.
+	 */
+	if (sd->child && (sd->child->flags & SD_NUMA))
+		return 0;
+
+	/*
+	 * misfit_task_load requires recalculation on SD_ASYM_CPUCAPACITY
+	 * domains. Skip caching stats for them.
+	 */
+	if (sd->flags & SD_ASYM_CPUCAPACITY)
+		return 0;
+
+	/*
+	 * TODO: For CPU_IDLE case, invalidate stats for an idle -> busy
+	 * transition but for the time being, save some cycles during busy
+	 * load balancing.
+	 */
+	return 1;
+}
+
+static inline int retrieve_cached_stats(struct sched_group *group, struct sg_lb_stats *sg_stats)
+{
+	struct sched_domain_shared *sg_share = group->shared;
+	unsigned long current_jiffy = jiffies;
+	struct sg_lb_stats_prop *lb_prop;
+
+	if (!sg_share)
+		return 0;
+
+	lb_prop = (struct sg_lb_stats_prop *)sg_share->private;
+	if (!lb_prop)
+		return 0;
+
+	/* Stale stats */
+	if (READ_ONCE(lb_prop->last_update) != current_jiffy)
+		return 0;
+
+	/*
+	 * Pairs against the update to sgs_prop->last_update to
+	 * prevent readers from seeing an inconsistent value of
+	 * the propagated stats from a concurrent update.
+	 */
+	smp_rmb();
+	*sg_stats = lb_prop->sg_stats;
+
+	/*
+	 * If stats were read in the same interval, it cannot
+	 * read an inconsistent state since stats are only
+	 * updated once per jiffy.
+	 */
+	return time_before_eq(jiffies, current_jiffy);
+}
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -10292,10 +10361,19 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	int i, nr_running, local_group, sd_flags = env->sd->flags;
 	bool balancing_at_rd = !env->sd->parent;
 
-	memset(sgs, 0, sizeof(*sgs));
-
 	local_group = group == sds->local;
 
+	/*
+	 * If stats can be retrieved, we are doing a busy load balancing.
+	 * Skip right ahead to group_classify() since group_asym_packing and
+	 * group_smt_balance is not possible under busy load balancing.
+	 */
+	if (can_retrieve_stats(env->sd, env->idle) &&
+	    retrieve_cached_stats(group, sgs))
+		goto group_classify;
+
+	memset(sgs, 0, sizeof(*sgs));
+
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
 		unsigned long load = cpu_load(rq);
@@ -10360,6 +10438,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	if (!local_group && smt_balance(env, sgs, group))
 		sgs->group_smt_balance = 1;
 
+group_classify:
 	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
 
 	/* Computing avg_load makes sense only when group is overloaded */
-- 
2.43.0


