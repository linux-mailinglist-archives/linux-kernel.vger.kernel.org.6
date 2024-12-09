Return-Path: <linux-kernel+bounces-438530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D949EA25B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E086282267
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813D41A0716;
	Mon,  9 Dec 2024 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ya7kbc82"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0A1A00E2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785388; cv=fail; b=UfCGT1+68PBoSsPPg70z8QnhCsSHNuxlNMrg2tqLRv98AYAOXwt2BInhsisiteE5VEVMyrVzaxn1rwP1GFCiJo7buETwuQ9nnk7gA/T6Fh+XOeTIlAHqeXHAezupopAtQPYpsa8UnNeozWKjdYtKxO1Rny7TMBkrnTN6r+bCjnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785388; c=relaxed/simple;
	bh=CnBxNyJaOAVFnp4U67j+GT99ozm/HpMG67obu2Fqil8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QP2uA0RvTzFVam82pm+R9EGb9fxH+EM+7rMQcbnlXVTj6M83MQP9quwrA0FKQ/NnMPU67BOhm0eDraAIeHXpa1FlkOy0XUsgNxZqSveucBZZm1eKx+e+QpCUeI3I7GJAxLwvl13KKsl22pmGa/cyYzI1bLZfA6AHEiiTwXlmYw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ya7kbc82; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbnXxQ2XXcWz7ynq5nSZsB+tJHeRc/fd9e+2rpxv01yDWMP1GeX997gmXWTiCgKMwZ4yoS2WuJgcvzk8HaQ8LK9R/xIE5n7p12HXnBBxVRjZe9VdCnK135uuqulUnJ3MhzY/buWTqTRuHxjRJ136EW4adPmJcNfbiwU3/cU4z3WguL3jprAmEUc5zdEcm7fxWmZzbYvunQiI1xLNfo6R5BN4Q9b9e7CCiepBk/dn4hQQWhLonE7ZitModQhi3I9hOXwglScLnjanrbGsEYK6Hc34iUk8BwiTs6PSy+1JbZdckWT9xFNt0j8uIIJ6PpDm/u+tZYJKTaRezFi5yxRmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q86MX5KJsIjhIC1e3tcF67kJtbTCrqeMdAQpR0GsNDQ=;
 b=Ag7cnlS99ACTOOKqWeEt1Dq1JWYtz2bDjAHlt8N3R8ld7BMpKJhPxISzL3jzzmDRS7nGdYp+Y+BLgwKqSntTgcEMol8g/S7hXLxssdZU5N9Z77YsD1itVdS9NrHIupYW6jEQHf0ew1tCC9cq6tcTO9xfh6+K89gu+ClCaaxFzvzqCS0jepOlXe00RyDnA85qhUZgXfoj+cn+6a/qBGwFEI9P1EwE8RY27Fq+Ljaz0rPchrujprKDsajnsADHea/JIxR+kJQbLmBtF27R4kN+WiFHhtP0Q1CXgxS4BO+Hdd9GT31PdCZfFp8kCCyYYFKI71NRSmGbz1XGajGKbVx8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q86MX5KJsIjhIC1e3tcF67kJtbTCrqeMdAQpR0GsNDQ=;
 b=Ya7kbc82GaADIaMMvNhu8DxoANx7EqDThGE3loU5cI96NEw8vg6px9OhFJUBZXEKKI6wmMfd988t/IC3SmqZygxfxsQxYGl2vjN7USbp+pFtS+65L82mfCZ/3RmN6QJA4ZPLG3FV7feh1+yY3h1+qCsYSOWaNNRPHa3Dm9JgrgOLp3mXrVrA5tm2KkcZU+y08T+IMJyqjxMvY9pscQCBaWHNDXJcnEAUUXbyxjIq9Vv0saDk6QtR2X/CkRjypornb3QbiRXjwKCsY5i4aup8dPrm8LEyiSEP6vKXsbBkAGt36pYA4invgVd7FvwH2FFMP1j8e8/XADNowZaC6qpwUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 23:03:01 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 23:03:01 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] sched_ext: Get rid of the scx_selcpu_topo_numa logic
Date: Mon,  9 Dec 2024 23:56:27 +0100
Message-ID: <20241209230242.775225-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209230242.775225-1-arighi@nvidia.com>
References: <20241209230242.775225-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: f414e43f-9ded-45d6-54bb-08dd18a5a13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Ua4nrHOKdgPlACHM9XN94YL7aEw7ALL0bZzWZgX5vn9wYMCm8YhWjKmsq98?=
 =?us-ascii?Q?ExmbmwmB/oPJYdgdkCgiacJ+S2BhS8K74/nG3W5+esmhoehtIMev8pfBY05u?=
 =?us-ascii?Q?4Q8MQe0z8nAbA4WdcrSTCcHlVbOWAsEZVznMNMtX1NOYy23+hfsn4U9mWo27?=
 =?us-ascii?Q?u1s6WVR05dY8spIV4hId8bD5kzJlGsqikw+Zdfu+8iUG/W7yUTCg+rI8ZLWE?=
 =?us-ascii?Q?IiqSavYr1q2B60gHAUAjm7Wg775TtgsZ+Bp6fDYBrpdEa7NwbYkL4BObMdtO?=
 =?us-ascii?Q?mg52lsQ68cjWZd9wNTMmfy0F6FaasR7TY+jtbTm22ySLXsGnyQTbP7fBIipz?=
 =?us-ascii?Q?DBf8OhWCOPbWBhqGUHxNQSbSgUwJb85OZBtX4hDExmem1q03RMv1JAUj9MBf?=
 =?us-ascii?Q?r0BTrI534ijR7rCLX9EseS+ysoTWiMhBz0fLNQQzAlDfZQGoxLuZOzZBrkyL?=
 =?us-ascii?Q?oBuTUOoGYADqgZ7XIwVhaErZoWgT1pz0pfDTmYLPvC/Z6+Oq1cgdLXuFOszU?=
 =?us-ascii?Q?LdB2vMTvWfxzcFq6yz1mtvYUhAtqP+FFz337HdhegD9ro4ock2nT0jbz8QxT?=
 =?us-ascii?Q?spNuJdYL/eO/1XOdR1dVKFJKsH/DoFgGqlBmAAzsceQtHPlqLzwVYqpWhc5i?=
 =?us-ascii?Q?nQvvMq7z/iEGKMlNv8N85tYePLQQSPrk4lZERQHqDpS5iDdqn0xCz9iKAWJj?=
 =?us-ascii?Q?LfP5pJRhMlXow2LJiZpSyAIrPb33vYSLVxzm2ZbQR6Mh68QgQeJVZUBZNTLr?=
 =?us-ascii?Q?ubJuVyLW8uNORtax9ryFsmxExpLbLooywbxM+Sg6C78SEAxaS2g3ZfVP2/6F?=
 =?us-ascii?Q?F1veZK6BmCJB7SksJMSqxWEtNIKGW1Dk6q9DNcQDTsfh60Tr43fmrVBHF3Xn?=
 =?us-ascii?Q?35uYU0MpUX85U4zcBckUKVIWcOwVw1vYMFpCqAXH7NcAgJOG/TZCMeVD3VNM?=
 =?us-ascii?Q?v5c7/ZTQ/XgodCrM3Go9OgN7+Vj+YVVj3GipjE70POndUkn3pmyAQ1QfrOb6?=
 =?us-ascii?Q?O4d+2a7f888RpC2jN02mr2dUr2O4DVUx94/icMKpuoVHPNxtTmyD58nXUypN?=
 =?us-ascii?Q?odsza2fE5/Ordh/BJ/okiFnH5VqlvYyptchT4GI2YCYCVStvI4AbbATEVgRr?=
 =?us-ascii?Q?kY8EKlQpDNWQn3VA0hbDdJe5L8s+C35Oy4OXzT52FDeuc4N3uZoQFa47gcuL?=
 =?us-ascii?Q?BkLQTJgSyYno/SS1E+iooHVnibSaX+aZvqPbdZFNuUt9zKwkfvfPh2JgbKEw?=
 =?us-ascii?Q?DkoAn+a2DAQUZ4WWW8qA4r5sO4vQnI6XaQWdIFb1wdpqHfm6iyhxKu3AJkzm?=
 =?us-ascii?Q?TU5586p4QlL1u9urrCFOb6HaBurg8D9T2d0dCbU+hkZgvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BzfEAttJHXFr7ZNRBCkVSPWda5weWqm5PaM2E4OMbyA0bTTzkEAbEQOXspOR?=
 =?us-ascii?Q?AZ9qjRqUp4xc8Uu4880gMX/p94PrFbhNr7UWqIGnXrFUyGF300bQIG4AFbO6?=
 =?us-ascii?Q?EC452k9t7chZuH4ZMv81aY8p2iGwxt6hUJ2VIKIkMSAvoLIhBQc2j9sJEy6h?=
 =?us-ascii?Q?lcobgAEllAb8Xwdz5x7ICR7XSa89R+KYwYEzEojICAbKPcNYwEuKUVLqLuwP?=
 =?us-ascii?Q?hbhxRKNxPTN7BPawxqJNP2KSc7Px37bL1H/UhDQeR1Pj8C327Rk1cd4v4Srm?=
 =?us-ascii?Q?0xY2tGT84JZ763JMzis8n9bmT/VAKLHd6UkQXWKWdRnrqddGy/sm7F/tCp/j?=
 =?us-ascii?Q?HoZXJMwaK4VBQ8La6fPXd9t06vtftnI3GjMbyOs/Z4sQ0cUxGNTRAMcVupNC?=
 =?us-ascii?Q?QfsGpg2KT4AYKSbOH0fiqjxDtF7rFBFRr8YZJuU8sl8/6qqPxk4UpKDsDkZv?=
 =?us-ascii?Q?5Yr68OChX9CTKbZbRdqmzaHqV5pKauNU4BTLhCGWwmFsyLY8WOybXK4tljdY?=
 =?us-ascii?Q?UGVZsXVua19SgsE4EhH3dLD7eXIx2xiDv61PUKVVwL885A4hNJd9EEp3W5ig?=
 =?us-ascii?Q?WdVH7D9omFROimNpwPttiz2/KwNjzdtpaHehu/zTjOHVgyvPhQfDS7YzIzDD?=
 =?us-ascii?Q?FbTHYJvC8mC9rlLALfuK5bDpJm/xw3B63HmmRIf9dkyD7W7k6CIfvMTnYiw8?=
 =?us-ascii?Q?KvrO1r2aScCf9Hhq3u+8IbU+QVeKVFt1N9Le0cjBDFv8S7JQa5Wy5U1yWMCc?=
 =?us-ascii?Q?K9j+6zvkpUkk+tSiQuUHweWM3rK3DOSEsDGJlmwUSQToNvIUJJnzdqgiPW88?=
 =?us-ascii?Q?wX1sFeIRHO4IEfpkQEse4jlbtfcP+sKWmNg4zgPOmA+OKANAPp7Ly3q84PVQ?=
 =?us-ascii?Q?CygeFqKaDEoWMS5mCs3rcVsbMEs2+/sBj+mOC7NC9jAzQnndDbEa+bBIer/3?=
 =?us-ascii?Q?ulmSAa0sarowlQoX5ncpGKgxSLXRml+ffZOG5OCLGJO7bz/xVZhMnwLQtssg?=
 =?us-ascii?Q?IWIWkNoI2t+dMRj4WFcC1X1Rzu+t2Jq49RXmbv8jamm9Yw18KZnwHa/ZP7iE?=
 =?us-ascii?Q?0fQu0Gpsr6ji23iJIQiSfsLSJhWt5lIfa9ML1jYoroD0VbeGwHZ/nmTRNZlC?=
 =?us-ascii?Q?A/hisJiaBRhHbHCeXHUoJjvxJH44tOAolP1MSReIAyBZXf5faq8C3mpMlgA5?=
 =?us-ascii?Q?YJi856yEVStI7I7IkzQoslEBI9IGlKxY9t2ZYpoHKUkhXuaFXzbFJ/jS04B/?=
 =?us-ascii?Q?yVY6MGzYka8vod6uyN1PaE8QrEPNjqniJ+b/5b78mV0pheH3BuhsiKD1JsWH?=
 =?us-ascii?Q?+qxqJhgIKptrXhnXOalVXhsugHX/2tuWK/ICE1gDeGKbLpAXYSQF4uWWNA30?=
 =?us-ascii?Q?l3PE/CnJRVhIiAC4n9gsARLtjbWpSimT2nbWXltHjJ0+FicRioyepuRtM8F0?=
 =?us-ascii?Q?GoGyZul2KrWZuzgIhW6VE+bYjI4TtR0DrkaztG7b03YcczNLddUwwe8gT56g?=
 =?us-ascii?Q?Ns0wgSWGVcWXAoiJQXwDsiLSaSsxo8G0z1tngrhyMYwL3cJfGsR/vECBlVtF?=
 =?us-ascii?Q?vI42GJXLdvIy0H7VEQ6XnLw1HCybczd6QVBatjsw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f414e43f-9ded-45d6-54bb-08dd18a5a13a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:03:01.2127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+q5YiaPqGZSZCw6T78bFMrO4f935KvW2OOziyIMPTh0OmhBtq92Az2HudEYDnPaYNOomqc8RXNNiOeId7pSiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

With the introduction of separate per-NUMA node cpumasks, we
automatically track idle CPUs within each NUMA node.

This makes the special logic for determining idle CPUs in each NUMA node
redundant and unnecessary, so we can get rid of it.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 77 +++-------------------------------------------
 1 file changed, 5 insertions(+), 72 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0b9b6627515b..a07a76c08f81 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -893,7 +893,6 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 #ifdef CONFIG_SMP
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
-static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 #endif
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
@@ -3382,25 +3381,6 @@ static unsigned int numa_weight(s32 cpu)
 	return sg->group_weight;
 }
 
-/*
- * Return the cpumask representing the NUMA domain of @cpu (or NULL if the NUMA
- * domain is not defined).
- */
-static struct cpumask *numa_span(s32 cpu)
-{
-	struct sched_domain *sd;
-	struct sched_group *sg;
-
-	sd = rcu_dereference(per_cpu(sd_numa, cpu));
-	if (!sd)
-		return NULL;
-	sg = sd->groups;
-	if (!sg)
-		return NULL;
-
-	return sched_group_span(sg);
-}
-
 /*
  * Return true if the LLC domains do not perfectly overlap with the NUMA
  * domains, false otherwise.
@@ -3452,7 +3432,7 @@ static bool llc_numa_mismatch(void)
  */
 static void update_selcpu_topology(void)
 {
-	bool enable_llc = false, enable_numa = false;
+	bool enable_llc = false;
 	unsigned int nr_cpus;
 	s32 cpu = cpumask_first(cpu_online_mask);
 
@@ -3469,43 +3449,20 @@ static void update_selcpu_topology(void)
 	rcu_read_lock();
 	nr_cpus = llc_weight(cpu);
 	if (nr_cpus > 0) {
-		if (nr_cpus < num_online_cpus())
+		if ((nr_cpus < num_online_cpus()) && llc_numa_mismatch())
 			enable_llc = true;
 		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
 			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
 	}
-
-	/*
-	 * Enable NUMA optimization only when there are multiple NUMA domains
-	 * among the online CPUs and the NUMA domains don't perfectly overlaps
-	 * with the LLC domains.
-	 *
-	 * If all CPUs belong to the same NUMA node and the same LLC domain,
-	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
-	 * for an idle CPU in the same domain twice is redundant.
-	 */
-	nr_cpus = numa_weight(cpu);
-	if (nr_cpus > 0) {
-		if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
-			enable_numa = true;
-		pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
-			 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
-	}
 	rcu_read_unlock();
 
 	pr_debug("sched_ext: LLC idle selection %s\n",
 		 enable_llc ? "enabled" : "disabled");
-	pr_debug("sched_ext: NUMA idle selection %s\n",
-		 enable_numa ? "enabled" : "disabled");
 
 	if (enable_llc)
 		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
 	else
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
-	if (enable_numa)
-		static_branch_enable_cpuslocked(&scx_selcpu_topo_numa);
-	else
-		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
 }
 
 /*
@@ -3526,9 +3483,8 @@ static void update_selcpu_topology(void)
  * 4. Pick a CPU within the same NUMA node, if enabled:
  *   - choose a CPU from the same NUMA node to reduce memory access latency.
  *
- * Step 3 and 4 are performed only if the system has, respectively, multiple
- * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
- * scx_selcpu_topo_numa).
+ * Step 3 is performed only if the system has multiple LLC domains that are not
+ * perfectly overlapping with the NUMA domains (see scx_selcpu_topo_llc).
  *
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
@@ -3537,7 +3493,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			      u64 wake_flags, bool *found)
 {
 	const struct cpumask *llc_cpus = NULL;
-	const struct cpumask *numa_cpus = NULL;
 	int node = cpu_to_node(prev_cpu);
 	s32 cpu;
 
@@ -3559,13 +3514,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * CPU affinity), the task will simply use the flat scheduling domain
 	 * defined by user-space.
 	 */
-	if (p->nr_cpus_allowed >= num_possible_cpus()) {
-		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-			numa_cpus = numa_span(prev_cpu);
-
+	if (p->nr_cpus_allowed >= num_possible_cpus())
 		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
 			llc_cpus = llc_span(prev_cpu);
-	}
 
 	/*
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
@@ -3627,15 +3578,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				goto cpu_found;
 		}
 
-		/*
-		 * Search for any fully idle core in the same NUMA node.
-		 */
-		if (numa_cpus) {
-			cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, SCX_PICK_IDLE_CORE);
-			if (cpu >= 0)
-				goto cpu_found;
-		}
-
 		/*
 		 * Search for any full idle core usable by the task.
 		 */
@@ -3661,15 +3603,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			goto cpu_found;
 	}
 
-	/*
-	 * Search for any idle CPU in the same NUMA node.
-	 */
-	if (numa_cpus) {
-		cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, 0);
-		if (cpu >= 0)
-			goto cpu_found;
-	}
-
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
-- 
2.47.1


