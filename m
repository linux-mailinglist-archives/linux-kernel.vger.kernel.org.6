Return-Path: <linux-kernel+bounces-559120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8719EA5EFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19C23A918C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755DD2641DE;
	Thu, 13 Mar 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DVHINQW7"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B502641DF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858783; cv=fail; b=gTjGcpOQM5vN0pBXk9wZo2D27OemjhMVwh9D5bRRnOtxQEvwoS7MWL+TuxKmjR+/o/q/MgHFzQVPbuCTzMOKtXM2sNuUFReBQYL5Q33y3guL4TRnYbQ6DnDOGPa2GDA3I9EztYxxQgmy1vOmEw5dxFu+OBjYEirFX2GFBisfBOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858783; c=relaxed/simple;
	bh=ZX9E5u5YFODE1Da8tR5uU8WdJFzIBtlsolxhNQBUCPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iX0ITj0Uj9USmxVT9CjBXYqJmeHckTPfH54LAvM3bR498ueiefrU5qRQ9WN1GCqjrcc33qpKU3ZLdLI2jg3PcttUKCRK2u6EHYE8FTG2oXN4nGXb85gGvH5T0vONzBAOwY9IXAqLTV+QT7kAOWzKBPAMm0ZZxnGj0WOhTvA62go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DVHINQW7; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnYXo0YtZUWsMvYobagCz8EH2YoVq82JnA/2BR8lIQkvNa3Qn7OM4iLVXlcFAv52YlCWvGIyvmbFYhnAY/P6ug4ekjxO/97VSXCRsnKMtBvnVqTmIIMZEvLFyMk5zK+2U0Xn5cAaZ4hjMNEHn7ZZ0qoP1SwtvI6Xk6oWyhRcqy47P3Mb6+640oyp3Xi8MkvZRc59sRGhDHg8tH9GNUJAAXJn8+HPBo7Cd+7HxXgQhJR4oR0atj0r+CsFykqsyLLVCm7s+8Nw4kEfPgMTV+ldXIOGJal35FWkWaFTLu5gpaYNEi2er2w8xsy5J4ETFBT5sIplCbf9LpKMc8TAaHzy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5MEss81ikQ4a1yPc7QlAkM9Ap7hvJpIRshYb2zErUk=;
 b=UGTI387h6qGGg+70y7gXzafjm1WmSYsbEtVlDYMvOjtzjIRU6KtXh41IHXpZu2KR3m2q9nFS0Svp86H/K8lhdl+c6fajzoLXOoi35NXy/bS7HSbrLMjgY8GdOzkCx62TmDRSLFoLi5O6Y94ZbruNrYFLIKOB+RSBnztE0aqD0Z+v23bZLB6pBS27q/UpsORt0zRa2RgVgMw+3vJ2ObQHLfG1BEzmh0keC8o1rXgwcAZJUa4bLVOYIa1jFTthA9e8eGlMlC99v4RvVeLP5tSC6Ks+DpgzIDJ6ZcvIWu1FrEEdDEGllUdBExRiFAVo0KFKP9cXIe/WKbVQYckyLvpoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5MEss81ikQ4a1yPc7QlAkM9Ap7hvJpIRshYb2zErUk=;
 b=DVHINQW7XUGXy+SEkGdrTzDTVYKIs4b/7brmTtWhIxYJeNGjId5jBhSuEqD/LqZHjUHugxjSW1MxsBrma1zD35nmucM8yMpDq+SrCQQXMsHlv0MFq+MtuCTe8KapgOOZKFurhCtQSKqgnvfRuGCTpmRUlKQ9FB2fuA+wrjPZm2c=
Received: from DM6PR02CA0150.namprd02.prod.outlook.com (2603:10b6:5:332::17)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 09:39:36 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::3c) by DM6PR02CA0150.outlook.office365.com
 (2603:10b6:5:332::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 13 Mar 2025 09:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 09:39:35 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 04:39:30 -0500
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
Subject: [RFC PATCH 5/8] sched/topology: Define sg_lb_stats_prop and embed it inside sched_domain_shared
Date: Thu, 13 Mar 2025 09:37:43 +0000
Message-ID: <20250313093746.6760-6-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: e16bfeeb-ed39-4cea-49fa-08dd6212f7a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6mUrQkYBH9wIDr3O4+VYBu4Y1ZHpoYft+YUrOKL2QzSTVggUfEsWHJqUXzqs?=
 =?us-ascii?Q?WhsLuD8ln1uaGIn5FyDhqXvaG/UiMzwJnn6IqNDcHWNvxSXbStFLxdkfseHT?=
 =?us-ascii?Q?lPZefx3rqDXxlLOWRnqX+snjqilQxipzRbGAohMQrKBnHW6aLL8t8kdWgPJ2?=
 =?us-ascii?Q?OihTmj4i743IoYXeArBi4uswkE4q7lh3YVNpH3OBIs5rb14qYLzW+1kJyWx9?=
 =?us-ascii?Q?SbR5fqOIrVzKNBk3c8jVhtF7xrY5o0VJ62P8RwRUmkXsxAT5RXsqRWWOggK1?=
 =?us-ascii?Q?Ku27EYphV6uQnEzCxY1trLV9hkGCniHePTzvdrRvABY/DI8diCPDAdo3G9WS?=
 =?us-ascii?Q?6SvKVfofcH9NrB65oiAicCIC+2uZ2z7nsqvIgEzsU0JTuQWI9dqN7m/CxruW?=
 =?us-ascii?Q?S1lciqxfOAV7Tp1LcW2JVOZgUDe5Zqq04vGXl4c3oHj5mJJNvmnQLrQFMu9k?=
 =?us-ascii?Q?awQAKCg9kQK1U6UjVuhRB/c6ut4d//37J0wDZyNSxxrQKxpEjj/RITkgrdD7?=
 =?us-ascii?Q?g+aObAms7Q4W9jBqOg/CbcqlqRDmcQbSP5+YhCXln1UFRfY+H4wSqNSEQ1Wc?=
 =?us-ascii?Q?7k53gHzf+yDQdgefFF1v33B8aQu++x/Ia42WwUk8C25cUz9ecfQpglBc8p6w?=
 =?us-ascii?Q?uBXlMCMo9WKnBduQFT7uVeasJXO8JaH81kRQt6pqqHgWoj036/txE+Iq+nXq?=
 =?us-ascii?Q?h5058lbEDQ1akuTeeZrQfXY/92bgWOprz2dZyxQ77NFVwFC6cUl4bT0JxiUm?=
 =?us-ascii?Q?oMMmXIkZqGKxLKK8HroZ3S0gAj9bcLT04GVaIO4283kocIrqUNbJwZtc93S6?=
 =?us-ascii?Q?comJzFY99Oy/f0lPQcDKsAdViZ9gecHSXbXK2eFyEvC9HDNj4axXbMPbrYIZ?=
 =?us-ascii?Q?gcVmzJsdS+mW2SgYceRafkOh8IcvPtsbr1oVTT8eZNmyCr2jTlBdaUQcRvO1?=
 =?us-ascii?Q?b5MH7whTE5Lg2Swn3esOHbr8dbZnQMyPUxNjAPodzE9aow9ajXzGP3BZp/u7?=
 =?us-ascii?Q?ByudwIqEeL1yowVdft4GRFo0e4WGRkqlBnrhJBhtbZPcSI5DBcRXUYUPgl8v?=
 =?us-ascii?Q?pIWT1XwyZfX5JeqPO2yMRWMMr8IjUVU9K5mFX4UQ24ASa4ZtzoNoHtQ53+B9?=
 =?us-ascii?Q?FUdBoyCPO3uJXDu9JDrlQYEgi31I6kmftM6bP95paFyk5K2U6tPeBvOhSQia?=
 =?us-ascii?Q?UsYb/OqhT0v5/Hf4XgnsKCb+ssE+y0kkMHTWHomls1/Q87Gb+CJN5w0icB6N?=
 =?us-ascii?Q?FWRs24G8bZO84kxbSdZiQRSs4xMtqveFHcHyh42TKiVAZ3JJp+naKkV+4600?=
 =?us-ascii?Q?7oenwr971zWy/y8G8mO/UuwJI1lyfGBi7PNl7JBYiY8lhNFNJeWQBbeO72AF?=
 =?us-ascii?Q?wu834rhqaqIuHb4qktSd5pcbgIsFrC1W7dsiqNmeoCuW8gfWkdm5ArzKmwlE?=
 =?us-ascii?Q?1uEz8vRxhqxsE0Zbd1HN6GjS7N6Htpq2KgOg4sQNqLu7wqS7BIPrpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:39:35.9228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e16bfeeb-ed39-4cea-49fa-08dd6212f7a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217

"struct sg_lb_stats_prop" is a container around "sg_lb_stats" to help
propagate the load balancing stats up the sched domain hierarchy. Embed
the same in "sched_domain_shared" for concurrent load balancing
instances to reuse the statistics collected for domains below.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched/topology.h |  9 +++++----
 kernel/sched/sched.h           | 11 +++++++++++
 kernel/sched/topology.c        | 26 +++++++++++++++++++++++---
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 7f3dbafe1817..a16d7d9dd9d3 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -78,10 +78,11 @@ extern int sched_domain_level_max;
 struct sched_group;
 
 struct sched_domain_shared {
-	atomic_t	ref;
-	atomic_t	nr_busy_cpus;
-	int		has_idle_cores;
-	int		nr_idle_scan;
+	atomic_t		ref;
+	atomic_t		nr_busy_cpus;
+	int			has_idle_cores;
+	int			nr_idle_scan;
+	void			*private;	/* lb stats propagation field */
 };
 
 struct sched_domain {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9372a75ab3cf..391c4180eeb3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2170,6 +2170,17 @@ struct sg_lb_stats {
 #endif
 };
 
+/*
+ * sg_lb_stats_prop - Load balancer stats propagation container.
+ * This is embedded in sg->shared->private and is used to propagate
+ * sched_domain load balancing statistics up the hierarchy.
+ */
+struct sg_lb_stats_prop {
+	raw_spinlock_t          stats_lock;	/* Lock for updating the cached stats */
+	unsigned long		last_update;	/* Time when stats was last updated (jiffies) */
+	struct sg_lb_stats	sg_stats;	/* Cached sched_group stats */
+};
+
 static inline struct cpumask *sched_group_span(struct sched_group *sg)
 {
 	return to_cpumask(sg->cpumask);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 508ee8aa492b..aeb55f66e8d6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -621,10 +621,19 @@ static void link_sg_shared(struct sched_group *sg, struct sched_domain_shared *s
 	atomic_inc(&sds->ref);
 }
 
+static void free_sched_domain_shared(struct sched_domain_shared *sd_shared)
+{
+	if (!sd_shared)
+		return;
+
+	kfree(sd_shared->private);
+	kfree(sd_shared);
+}
+
 static void free_sg_shared(struct sched_group *sg)
 {
 	if (sg->shared && atomic_dec_and_test(&sg->shared->ref))
-		kfree(sg->shared);
+		free_sched_domain_shared(sg->shared);
 
 	sg->shared = NULL;
 }
@@ -661,7 +670,7 @@ static void destroy_sched_domain(struct sched_domain *sd)
 	free_sched_groups(sd->groups, 1);
 
 	if (sd->shared && atomic_dec_and_test(&sd->shared->ref))
-		kfree(sd->shared);
+		free_sched_domain_shared(sd->shared);
 	kfree(sd);
 }
 
@@ -2273,6 +2282,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 			struct sched_domain_shared *sds;
 			struct sched_group *sg;
 			struct sched_group_capacity *sgc;
+			struct sg_lb_stats_prop *sg_stats;
 
 			sd = kzalloc_node(sizeof(struct sched_domain) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
@@ -2288,6 +2298,16 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sds, j) = sds;
 
+			sg_stats = kzalloc_node(sizeof(struct sg_lb_stats_prop),
+					GFP_KERNEL, cpu_to_node(j));
+
+			if (!sg_stats)
+				return -ENOMEM;
+
+			raw_spin_lock_init(&sg_stats->stats_lock);
+			sg_stats->last_update = 0;
+			sds->private = (void *)sg_stats;
+
 			sg = kzalloc_node(sizeof(struct sched_group) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sg)
@@ -2332,7 +2352,7 @@ static void __sdt_free(const struct cpumask *cpu_map)
 			}
 
 			if (sdd->sds)
-				kfree(*per_cpu_ptr(sdd->sds, j));
+				free_sched_domain_shared(*per_cpu_ptr(sdd->sds, j));
 			if (sdd->sg)
 				kfree(*per_cpu_ptr(sdd->sg, j));
 			if (sdd->sgc)
-- 
2.43.0


