Return-Path: <linux-kernel+bounces-562942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C8FA634FF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AC716EBA9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1765DA933;
	Sun, 16 Mar 2025 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e5VDxqFi"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876F188587
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742121020; cv=fail; b=oRq2cM7jprkET86S23feF+0kD761k+QUOAmA05tNTqCs0Xanp7QU9SLg9ejetIBWwPORw/Vh+OcxyagzasZSMfFrrWQ+ucd6BRheYVqe6ZfkjfcFq1oZMcXXsfDIwIwYtPcT0TRw6/OeZFIjvzXVaMJ7W0JlsHqPVYRtxjaLDVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742121020; c=relaxed/simple;
	bh=Af30TauJFBz70w5kUkaNKtxSL7QmhsiLcXaJlT8Tozk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmPMJvnuqJIWVj9GyJ+2edoAFqb0uiGVzpKwD+vAfqF9iZ8fnLQVUpZItOTH5eCaR4Tz+k+ep+MfKk2AXQ3IBbq2tlrK12Rhg4JmBbmxnqnv+OSR7Tc81cVipBOXwkePrkDI3aGNvBJeD04oNvZHYbV3Qc7gHSne39M3PhQa50c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e5VDxqFi; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTQuDxDbxaTgkVrzQIdZaaprSpQEmXZ4gJObyP3m6F9dp7fFKGJrOSsoCjKRn1lYAaiZAPIdBN8uV0H4/eMoXZe+k8PwIIsMq8HhMN9ZsxeoavT9Jcl04rdY+MxbJ4fRuAyjfxLJVIblQAb8lTS87qOQtU3vGZcdfm7Fnz4V6oU1Jh9MZ4bqrhri3KxcNGnTMzb975WfLZHmKQXl1pYOUbNSNka/69Y5K9lNlZ28r1od7gNI8p44/ARums0obAGIWsTwbkC40PSSFA8HNdOur93APm+gepogOpMUi0Z87rO5ExgRgSTqHoPsLN0f3b835aPMuvXI9kCT+tqjTbGHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOfC8Nv4ppL5FLK5g0TCRM06/pbruq9zDQmqRF2qliE=;
 b=N2dLLDAUOXEBhPxPk5IXbBHPsdmdjr5B2NUOTbV6Y16f5cm042pt8gkPKbJSJ5wgSrom7K0NcW2Izggz5iGrpFlyziuk0ps+NRoAkX8kjwiAH/HLH8Aa7D08o2tZz7O0npJf1LUPZU85HTNuPMKazSlB8kGd3f5uFKxPU1I4fJw93bf0pwocUhF7g+XvYyeTUWbMYG3d+yiTNTZ7VYKdS4tpDV1h+g1Ym1RSR9HkuSJlfG/pU+Y+3ScFAfoOnnLsbSzPk4cIPERbrKxl20Oba3S06BhKw4Jsio/+eQH0sIheMHWM3082rGag0ADaNtboCb04O35rVGAK7Uhrq3NFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOfC8Nv4ppL5FLK5g0TCRM06/pbruq9zDQmqRF2qliE=;
 b=e5VDxqFiwzSq/bLJ58GIzxIqmHTf0JnH0IOHoVw4VoqbpOBXSqCDjFXstxVo005sfrROB8re3po9A+i588DWc/WDt+FiECdx5gbFaWV7hwxDIegpYlvUNmBAXZmHApUO7rzipEWTrqfH/3t/98d14zJQtDMqI6IFcdD91kZf8Z4=
Received: from MN2PR20CA0057.namprd20.prod.outlook.com (2603:10b6:208:235::26)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sun, 16 Mar
 2025 10:30:13 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::63) by MN2PR20CA0057.outlook.office365.com
 (2603:10b6:208:235::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Sun,
 16 Mar 2025 10:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 10:30:12 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Mar
 2025 05:30:07 -0500
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
Subject: [RFC PATCH 11/08] sched/fair: Move from "last_update" to stats versioning
Date: Sun, 16 Mar 2025 10:29:12 +0000
Message-ID: <20250316102916.10614-3-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: f19ce577-6961-4347-0ea0-08dd647588eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NyTZT1mqHlDqYhIKeZ+9Xn7g9A19XzE7BzECkuw1kKAGeKpGSG+KpVj74qts?=
 =?us-ascii?Q?MbhwpRvFbuahPshJnCP/AZKwd8MT9kNtUMLNVI0ldMVOywRcyCXIiWMKouYG?=
 =?us-ascii?Q?R7MdHuevZvTex5VlhP4wtkHvGFUuMcN3b/yHR15PEGV/aCtN47dEDbe86YtC?=
 =?us-ascii?Q?awJP4ec3Pz0oefuk4c5lUfUplm2jnZRIHHwE/WsCsa1wLtT+CSgmjkxeYppE?=
 =?us-ascii?Q?DeRbp+euwm1yO6bWtcW6ljzf4q03CmEAHW7abfg6cbTRYfWzBNzgaFDSZkkd?=
 =?us-ascii?Q?yrRL9DwdZbJtm6rfmNvdxUMcZuaREQZICuwJN4mnNtpPEksyjHdc0/LNQZFU?=
 =?us-ascii?Q?Xy7GnwzbomeRsJAWF5DieFSg30k8dIEIIV/XUFUz+x/sER4TMvlgdKfc5ldr?=
 =?us-ascii?Q?l3UZdXog0/IK8QWCBhX+8JyQDNpRTKrpseJbJaGqs13SwQ/ua1Uv70QEWsvx?=
 =?us-ascii?Q?HmQYgIllU8eZFYyoL1pvwCmJ46aHdQeHcRZDnpIDamfdVfV64LTpi6aXVNmo?=
 =?us-ascii?Q?u8f21NTB8yop/gzn6e5zMDg6lzsYScfef55E8fuJS1lZVVVJU56Hoa/Aad1G?=
 =?us-ascii?Q?mTmUnlyVIhgPdBchYaubYe/fBWfdH5reS66c0OwbWsq1XEZtYPIzIhuypqQP?=
 =?us-ascii?Q?V/Qspewv4rZaz0N4LYa9VR31Gs3ORYJYfBLNFSLy4AIwn02Wu6oWKEJO+V8S?=
 =?us-ascii?Q?ExkNnfymMRppjf0QaGK0PoC7cG0W7UuR1cephiflygmXpZY4PRVh0qHRP7gA?=
 =?us-ascii?Q?dmc/S82c9Wiqc31hxhUXc4As2/puTmwv8qgxSvTnSuBPt/iGwXoWTjMUJDRd?=
 =?us-ascii?Q?rulZ50LUJMOZILgezhsIV3H+KRD//Dq9spGNReQ6KiYddb+RDBA3rzCEX63a?=
 =?us-ascii?Q?/48ax/LOwA4puU7tII331oP6GypCldtpINfOxnLWs2YyPAJR60pwwXQR7rkM?=
 =?us-ascii?Q?KPnoIXHbQkbJhT2wrG85/M4ffaWRgR9A8+gRmyzcxXjHsCkJwLG4fbOc52L2?=
 =?us-ascii?Q?rOhGyUjSCnNPExMGR40+fqg/r48ZqzFpKL5NnIevWJWg9b+xlmp97rlUueTL?=
 =?us-ascii?Q?HLMd/ImxjkxKa4yDKLdfwAM4iuRj09d6FkG+D5Ll8dL51i+BfW7KrUIYPvIT?=
 =?us-ascii?Q?XuZ42dYX4K5whupS53WbsSTjLCOEVGmw4yX+iAjjDaCKLyIf2E6qPt3kvhwk?=
 =?us-ascii?Q?2KCtAvyn5uLVsxYvwQni/Q79mBcEtuMUaFu6LxyJTrI3AQhE0caKwur2lfjI?=
 =?us-ascii?Q?kirqsU5G1eVxQObNFC0LYbAsjKJn4OTmid8a0iyb6/5oHO95kwnP6t4uxLh7?=
 =?us-ascii?Q?/2xF5tW+tPiOLlCvWPa7VBuqCg6mZPgqDd7c/sT1HHzE/6h0fWWotp040UhW?=
 =?us-ascii?Q?0/FWsv5U7FxAY6BeAhciFGw4L+lrzb9PnRD5QDjlwZQy+8ORZJ4vSpScokl8?=
 =?us-ascii?Q?ckFrGOWK8LvpGLMCsqOSbDdBJpQcnV9Khpea6HaBvETpLkDcBUvL5CK6cGeg?=
 =?us-ascii?Q?lH9gmzyp2rY3W6U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 10:30:12.7067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f19ce577-6961-4347-0ea0-08dd647588eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082

The combination of "stats_lock" and jiffy based "last_update" is not
scalable for newidle balance. Instead move to a versioning-based scheme
where the version number helps with both readers reading consistent data
without the need for a lock and writers using the version for both
locking and indicating stats freshness.

Additional semantics have been added for the writers to update state
stats if the time elapsed since last update has crossed the 50us
threshold.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c     | 83 +++++++++++++++++++++++++++--------------
 kernel/sched/sched.h    | 22 ++++++++++-
 kernel/sched/topology.c |  3 +-
 3 files changed, 77 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d09f900a3107..6c486e194a9d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10275,11 +10275,13 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 	return check_cpu_capacity(rq, sd);
 }
 
-static inline void cache_sd_stats(struct sched_domain *sd, struct sg_lb_stats *sd_stats)
+static inline void cache_sd_stats(struct lb_env *env, struct sg_lb_stats *sd_stats)
 {
-	struct sched_domain_shared *sd_share = sd->shared;
-	unsigned long current_jiffy = jiffies;
+	struct sched_domain_shared *sd_share = env->sd->shared;
 	struct sg_lb_stats_prop *lb_prop;
+	int cpu, retry_limit = 3;
+	u64 time, lock;
+	long version;
 
 	if (!sd_share)
 		return;
@@ -10288,23 +10290,52 @@ static inline void cache_sd_stats(struct sched_domain *sd, struct sg_lb_stats *s
 	if (!lb_prop)
 		return;
 
-	/* Concurrent load balancing instance already updated the stats */
-	if (READ_ONCE(lb_prop->last_update) == current_jiffy)
+	version = atomic_long_read_acquire(&lb_prop->version);
+	if (version < 0) /* Raced with a concurrent update. */
 		return;
 
-	scoped_guard(raw_spinlock_irqsave_try, &lb_prop->stats_lock) {
-		if (READ_ONCE(lb_prop->last_update) == current_jiffy)
-			break;
+	guard(irqsave)(); /* Minimize interruptions. */
+
+	cpu = smp_processor_id();
+	time = sched_clock_cpu(cpu);
 
-		lb_prop->sg_stats = *sd_stats;
+	/* Version is still fresh, no need to be rude yet. */
+	if (version > 0 && (s64)(time - version) <= 50 * NSEC_PER_USEC)
+		return;
 
+retry:
+	/*
+	 * Try to grab the stats for update. If the cmpxchg fails,
+	 * a concurrent writer succeeded to grab the stats before
+	 * this load balancing instance did. The acquire ordering
+	 * also pairs against readers checking the version after
+	 * reading the stats to ensure consistent state.
+	 */
+	lock = atomic_long_cmpxchg_acquire(&lb_prop->version, version, LLONG_MIN);
+
+	/* Someone else grabbed the version. */
+	if (lock != version) {
 		/*
-		 *  Pairs against readers checking the last_update
-		 *  before reading the cached stats.
+		 * Version is up for grabs! Try again. If the CPU grabs
+		 * the lock next time around lock = version = 0 and this
+		 * is skipped. If it cannot grab the version, lock != 0
+		 * and we return from here thus ensuring on a single
+		 * retry.
 		 */
-		smp_wmb();
-		WRITE_ONCE(lb_prop->last_update, current_jiffy);
+		if (!lock) {
+			version = 0;
+			goto retry;
+		}
+		return;
 	}
+
+	lb_prop->sg_stats = *sd_stats;
+
+	/*
+	 * Pairs against readers checking the version
+	 * before reading the stats.
+	 */
+	atomic_long_set_release(&lb_prop->version, time);
 }
 
 static inline int can_retrieve_stats(struct sched_domain *sd, enum cpu_idle_type idle)
@@ -10346,8 +10377,8 @@ static inline int can_retrieve_stats(struct sched_domain *sd, enum cpu_idle_type
 static inline int retrieve_cached_stats(struct sched_group *group, struct sg_lb_stats *sg_stats)
 {
 	struct sched_domain_shared *sg_share = group->shared;
-	unsigned long current_jiffy = jiffies;
 	struct sg_lb_stats_prop *lb_prop;
+	long version;
 
 	if (!sg_share)
 		return 0;
@@ -10356,24 +10387,22 @@ static inline int retrieve_cached_stats(struct sched_group *group, struct sg_lb_
 	if (!lb_prop)
 		return 0;
 
-	/* Stale stats */
-	if (READ_ONCE(lb_prop->last_update) != current_jiffy)
-		return 0;
-
 	/*
-	 * Pairs against the update to sgs_prop->last_update to
-	 * prevent readers from seeing an inconsistent value of
-	 * the propagated stats from a concurrent update.
+	 * Pairs with writer atomically updating version after
+	 * writing the stats.
 	 */
-	smp_rmb();
+	version = atomic_long_read_acquire(&lb_prop->version);
+	if (version <= 0) /* Stats have gone stale / being updated. */
+		return 0;
+
 	*sg_stats = lb_prop->sg_stats;
 
 	/*
-	 * If stats were read in the same interval, it cannot
-	 * read an inconsistent state since stats are only
-	 * updated once per jiffy.
+	 * Pairs with writer atomically invalidating a version
+	 * before updating the stats.
 	 */
-	return time_before_eq(jiffies, current_jiffy);
+	smp_rmb();
+	return atomic_long_read(&lb_prop->version) == version;
 }
 
 /**
@@ -11155,7 +11184,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		sg_overutilized = sd_stats.overutilized;
 		sum_util = sd_stats.group_util;
 
-		cache_sd_stats(env->sd, &sd_stats);
+		cache_sd_stats(env, &sd_stats);
 	}
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 391c4180eeb3..64f7e013fd59 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2176,8 +2176,26 @@ struct sg_lb_stats {
  * sched_domain load balancing statistics up the hierarchy.
  */
 struct sg_lb_stats_prop {
-	raw_spinlock_t          stats_lock;	/* Lock for updating the cached stats */
-	unsigned long		last_update;	/* Time when stats was last updated (jiffies) */
+	/*
+	 * Stats version has the following semantics:
+	 *
+	 * When 0, stats are considered state. A writer can lock the
+	 * stats by atomically changing it to LLONG_MIN. Once the
+	 * stats are written, the version is atomically updated to the
+	 * value returned by sched_clock_cpu().
+	 *
+	 * If the reader finds a positive value for version, the stats
+	 * are considered to be fresh and the reader will copy it for
+	 * load balancing. The version seen before and after the read
+	 * is compared to ensure the stats copied are consistent.
+	 *
+	 * Since invalidations under uncertain circumstances can take a
+	 * long time, a rude writer can always attempt to take over the
+	 * stats by atomically updating the version to LLONG_MIN if it
+	 * finds a large difference betwwen a valid version and the
+	 * value returned by sched_clock_cpu().
+	 */
+	atomic_long_t		version;
 	struct sg_lb_stats	sg_stats;	/* Cached sched_group stats */
 };
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index aeb55f66e8d6..2e72ef8d8d8e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2304,8 +2304,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 			if (!sg_stats)
 				return -ENOMEM;
 
-			raw_spin_lock_init(&sg_stats->stats_lock);
-			sg_stats->last_update = 0;
+			atomic_long_set(&sg_stats->version, 0);
 			sds->private = (void *)sg_stats;
 
 			sg = kzalloc_node(sizeof(struct sched_group) + cpumask_size(),
-- 
2.43.0


