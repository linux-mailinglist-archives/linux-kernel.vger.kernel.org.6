Return-Path: <linux-kernel+bounces-448970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3779F47D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7319F1881C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C221E00BD;
	Tue, 17 Dec 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FXKzWQPk"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B691DFE37
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428558; cv=fail; b=nAdBOnJHYqXkaLlr9lilCMtHy/7Fk6qNJj2h6WBxhirMQyJfe0Y3V5beQTjHwOwNvWOh+IcFSAzr4iTz9NfEAKD1NIA/Yd8GYuTLWf6nP2eksMruV4burJpbRBvqOzSXmdxbB96pRMTDiSMf3cNh4u9JNqDRfGU0Trt/CmUirrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428558; c=relaxed/simple;
	bh=KMnL8t883Tkl4Qy9c0Hc4C9WzxP9grNzAFD+XaTkDRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZz7l1HQjJ8ExwbaFcewgU5o0ccaYIRX5C25V7XG+srbBD78IC7gyw/SQKRjD4UvotTA6roRWEGHPolfRE7pOAHB6CONx7wXSkPLbfBB84Bk+Xt3+hxP+5FdYi7X/SCXFjW659T8Z2BFgjaFyvx8iH3zEFjdvl8/NiK10noLtc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FXKzWQPk; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpZCS1fgDgPHo7FKHN11pQyCjFBSD++vDlLQyQGlpGQVnisY7LR8W2jhIAVh8x4Cna78Ogaq0iLa3vNZTaD3v6lXpDQV0mC1DcX69MYjZauD6fsJwhMAOygGWdW+y9BOt5ex/0/8XA3hJGYILx9x8VV7RIltFqg1VhMFK566xrJC466OYgVo380v+gwXnJ1CC2CnjqdPXwgbg37Bqpw8Bb3YttDSjWh1IVlhlNbZCnCuVa9jNYJMX2pAv0zp0YJi/jPgf416+w0gN3bbH6LuQgF7y/+krb+X69WvkoDHrVHLQuljfUI0l8L3tIwuJBJlpjhDmeF2/uVyDvwGUeqHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GYHd2Nz2EofHg7Ysrj8cMgZ/aIFj6kxlffh0klQWmU=;
 b=K18OkE/vx5nmDQ7rFWpbIJanIyt+uVHLsFpFSBUyE41Y9o2jNz5/W3zi3oKMnXA8Oj9qqpra+lUbEmltAmZjMgkkYBq07LXMU6YdDZufO/fzvbN5ggaPtxdfR93OLIIsgfGol5llJcH+b28bPySP0xr8GQhcpgLk+tIoj27LAN2iTvRhmGeSi4mcTZs3yXITg1FZqwVhPEavxXkfydVSGo98JnsqwYy9NeFETZ5/m6dCJnL/uEkjEVKIx6L0p9uboIxwbx6zSEreUkwAqfRHEH8Vp5TjB3FslW8O4CMdChkSNWSWULU1a1SSFb+gUBsPxnwhpGCwU7m0DclHHSu3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GYHd2Nz2EofHg7Ysrj8cMgZ/aIFj6kxlffh0klQWmU=;
 b=FXKzWQPkK8nKq75A/zdYfeZks3pb9PgjFRTjrzlyNfdwANo8Kilu9GA+Bg4fyF0OK1AFcT2tbvqpDdGvCppFdefvlbCKZY3F6LyB86X3mSUYq2JTHcsJdT1Ez73i9B+ehWAd1VQDOVnytGE1jX5vjxvbcq9JDwZv+24hPoq+xtkWlo94ehIQRNICSxO5GKjDbII1NxkWpb/wP4AZS8xBn9sqM2zmV2bEo1u1DYh/sHNCAwvC4DKKTCxW74aIVPxoZvkBTGHFf+w2h0R79VsV75e1DKB+kevMH13veh43Esu3xvXKaXvWUB37Q5wkSjc6t4qw0AgbgSJIriUke+Dw+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 09:42:35 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:42:35 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] sched_ext: Get rid of the scx_selcpu_topo_numa logic
Date: Tue, 17 Dec 2024 10:32:29 +0100
Message-ID: <20241217094156.577262-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217094156.577262-1-arighi@nvidia.com>
References: <20241217094156.577262-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::6) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 5186a7ea-dd66-4bde-74a4-08dd1e7f22f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FwLFMq1yD+UjwzeDrRuZ1/GNsSdftzrtGbwtZ64yRTT7bh/JEcTIK5oaCPuw?=
 =?us-ascii?Q?/Nna3OV47ZkUzVihra3c+KStSp2dk7LANvIpLiTouY/V3U4gFjSw2J02Hf0s?=
 =?us-ascii?Q?xRMecnmzz2b6At1J80GtUE+/5hlhLQ2e70stXO7ogeHXvvk0TfRT6PwhEZ3A?=
 =?us-ascii?Q?+RESlhMDOi0CZpBJAUC5TRigqCxkc7QgYYCS6HFbxvNwabo3sAz/IAUuejoS?=
 =?us-ascii?Q?OQHAeBiIgMXGgPAzjZEMj7KKQPzz+STOGZNvWXQHkCiFI0QC68n41GC3Wlbr?=
 =?us-ascii?Q?6qZivd250oPmSYL2YduR5kuql9w745hGhgBJcUlMQ/jrPa7NKErzW/0EK344?=
 =?us-ascii?Q?tl5AaN8NUwckStoEocdRl4G/7D4c5dSApjjWmUFiRYJX7lqT/V1y8xrTT9Oo?=
 =?us-ascii?Q?WzO4TQdDt30g65vuCPwgH2+hWAYR9rC/JMn+tw7LtY7go7xzK1UyOFNy2Tup?=
 =?us-ascii?Q?Jelt3hYGGq4C9yvOz9MvRtRcTsFo0iBRxD0jrTZ6W1TL7LFl4lcNLA3YcsuU?=
 =?us-ascii?Q?/9ezCUzxPPXepq6to88/mp9vMLp0zP5AgvUB8JnRiOs+lDiiGaNun1cwOdut?=
 =?us-ascii?Q?A3Pfk3mt22aPcOKOHRafbybKz7/W+3j7z2dioMRCMhdc6QGFbJjweQH0hWSz?=
 =?us-ascii?Q?N7nMeCkdZWr7nbv5e9KRsX+jt+IMZn8DSBjgrTo0hUb1lg6fR70FLNuKtWz8?=
 =?us-ascii?Q?D8d32gN1MerOOt83nwhY2TY0Ny6UNivUFlJ3eabEZwD5+RB5zGW6SBPG42d4?=
 =?us-ascii?Q?Gj7IiDdSxSY4cQvQd69f+VNMNr2Tm+ln78lfBmTBVVxRdvUgk03Up4rAc5yq?=
 =?us-ascii?Q?Mpijr+xRyDmh8BaVbU31a4SyMNqLzCSo87nOSAk9So55akAwhfVEnEqYiOPe?=
 =?us-ascii?Q?Wezmqwa9BZU2j+cJGczwB1mbS2cmVQIM9gsgNiTNCYKJ9Fq47ZmHwK/9GEbF?=
 =?us-ascii?Q?WmEp6dqzyQdrNnTnNEr5oVRgqDTj2RhSdk7HRO/mz03Ji6m3xL78K0XpB3gJ?=
 =?us-ascii?Q?mM/0MeRzD15tVTfQwLuge5R8wTpBn1mxcJhKu7gOWvEr4mrXfxTVYm7eXaVt?=
 =?us-ascii?Q?jvX3TsvLhiUcxKHu8zzOXd8/2weDLtAHYwhSc7a98qzUYz/pVXlX2vW4x2uo?=
 =?us-ascii?Q?vWX67v+Sjd6u8J15WHpYmE1VZ+FvitnDSivts3VnPXOHV+C0ldahRPDC4jHc?=
 =?us-ascii?Q?5Ac2ZBoxgFJYDkPawi5mEZe3yuiSdzqbhn7VPYLUoi5viFAWtkC2E87jK5iD?=
 =?us-ascii?Q?Bxs6WX8VTvoleQEHLYYIiy7DCfPsIJCQpR/B6+0Ftj8RtHf/bwrybsigBA98?=
 =?us-ascii?Q?ZjirpVqqT+XQgIhwvoYNVigf+RWmj1FAmvBdG6w1grtzr1dL1OaQT/E988c3?=
 =?us-ascii?Q?vmoZFL3W8rzCSRp3clm5MrOqxbOY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x966+0TN1bcoQXgROS7ofY1Ir5LPYiIG79sghu6/ZTeZzbs+cmbg7ptQF/Bx?=
 =?us-ascii?Q?Ec43gCB9IwmqtP7YyUSVb6OdkZ3H/vcZ19o1k1LLbT84IA0j/bDdjTsW6Loi?=
 =?us-ascii?Q?rS/tjNNGzO6xTHodI7WFEVsdAC5995OVjpyaOFnN+VlKldP/UHzZA/upoJX3?=
 =?us-ascii?Q?Pe6UInGD6YAo04VAHO/WbfJAuFVtwlgbbH691ew7jlXgBvMDXrl8JkYqPjkx?=
 =?us-ascii?Q?KdlFg6p8VnqN9ffIfvgT76hfpQm5YS7c+BZ/veFwNxV1ytqCWdfgfZRcK2XP?=
 =?us-ascii?Q?bTwipDXr0wWGh8jISeegQBsCeCLwo4YcWYYhd7ZOKzUlg5mc3xffAePjXATc?=
 =?us-ascii?Q?ZtthvxqCIFVg7bAvYRpHT26jMiiDzBYEydbtn40w+2Authy2XM/lRzV+Mmr8?=
 =?us-ascii?Q?7xcANBM1XQz8h2da3cYe8jXTVHPAd4YW+DVrCdBNLz70BnIAHzD0Y6drLKyM?=
 =?us-ascii?Q?zCp+W1QphomHZQcDkEjLrI3iq5r/v5d+dDJXBpZV74U63rkneqApbQpvQlJK?=
 =?us-ascii?Q?+JNk5xoKYOub4XfFQ2vxmcve6nLxsSgb8RKE047+0HOS8onIL3QBRxqz2vi0?=
 =?us-ascii?Q?jsg3wi92C/6BzenmYaLfk0S98yR6YY1+0kH7qPX3V6GFF7CXNr3ZMYeTWBKe?=
 =?us-ascii?Q?c13AYarymEukQQcqEjvKqghiXAU2oDAUW//ZbhGjhDgQUPYAzcRbNw7iH7Sx?=
 =?us-ascii?Q?fULawBKxinlR9BwJ1mA/N+3zAunNnlIYsoKiVVPk+WzTIXOpQkUHPldrYCFI?=
 =?us-ascii?Q?UdX22fdvrDjgS8i9qPIpv78pKnuYHvRoRgVi2VHjNqQXhz0TADxvUYPue7as?=
 =?us-ascii?Q?UE2MRVl3RaEIrk1y73YQFZEfxLCEBW1skcfWG0vbzddaZQl8rHLWfQY6ytAE?=
 =?us-ascii?Q?mQ9uAdS2bTHNzvstqb6kV5UjZ2z8ZbVfoPLMY9+d/L/msvhV4z6N4DKjO5Rf?=
 =?us-ascii?Q?1OtkS0DIi72WVkbNp6lg2NibSCWhtxxJGE7NAopHMutmey4y195LP5V2OF6q?=
 =?us-ascii?Q?3nZ9irEsePcICpwGQQhntqFshmOIwA3+rostI1ZI2B1mzUfJV8k09tP8umLa?=
 =?us-ascii?Q?JAt1l/3MXOoOfCrhE3hiKz5PWYCeL7T5s0iKK6w6zq0qyZrj0IeXqG5NOEy7?=
 =?us-ascii?Q?H/QDaPoEF858AhzEwz+CkXWBT95UoJWywr9QVHVECHmP7wPe/zOBi+8yKLj0?=
 =?us-ascii?Q?HczMLUjEST55jyuQGwF4Qmnr3O7y/lfted4HBcpHmzaVZvF2DCKSSAqojQN3?=
 =?us-ascii?Q?JJwMd3nvNBtiMxRjDKl3LUaFVfsNjO+kdHu2lOS+bli0KUPaDSVQIlC+E0Sh?=
 =?us-ascii?Q?ScYyhDIA5YPhdk1l2k3t8mv+U//4tKTqhRAjhsxgDJnd/rabZyCOlikNqI6f?=
 =?us-ascii?Q?MQpiTSBR0nJ4E+pEel33Z6tJnwGnWsa6HOTU7Hjb2/F4jEgHtLZ4CTNNe29T?=
 =?us-ascii?Q?0v6+7cVpwvCakR/LC08qXIgqVCWyIKU9rtpgFLVoSkDh+DFLe45TIDeYka47?=
 =?us-ascii?Q?pYe8Ru6M4kmLZaqN6G1RVLcKJCeD21KNzfCZQNRmsnr7CTr/ha7BxCGbDCGG?=
 =?us-ascii?Q?wCMhAbvMp5tAR0O9Y6qlANcAmFIwoctzsdAp/oQD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5186a7ea-dd66-4bde-74a4-08dd1e7f22f8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:42:35.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwqNRUVNghmu3lNxYCqEiFrmukOzMgw2YuGsCrZNxwYo2dVUwEBRWl0R15CzM0wIi4ty60dQP76h04sjDdUzMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362

With the introduction of separate per-NUMA node cpumasks, we
automatically track idle CPUs within each NUMA node.

This makes the special logic for determining idle CPUs in each NUMA node
redundant and unnecessary, so we can get rid of it.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 75 +++-------------------------------------------
 1 file changed, 4 insertions(+), 71 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d4666db4a212..80778d660be6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -893,7 +893,6 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 #ifdef CONFIG_SMP
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
-static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
 #endif
 
@@ -3385,25 +3384,6 @@ static unsigned int numa_weight(s32 cpu)
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
@@ -3455,7 +3435,7 @@ static bool llc_numa_mismatch(void)
  */
 static void update_selcpu_topology(struct sched_ext_ops *ops)
 {
-	bool enable_llc = false, enable_numa = false;
+	bool enable_llc = false;
 	unsigned int nr_cpus;
 	s32 cpu = cpumask_first(cpu_online_mask);
 
@@ -3485,38 +3465,15 @@ static void update_selcpu_topology(struct sched_ext_ops *ops)
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
 
 	/*
 	 * Check if we need to enable per-node cpumasks.
@@ -3547,9 +3504,8 @@ static void update_selcpu_topology(struct sched_ext_ops *ops)
  *
  * 5. Pick any idle CPU usable by the task.
  *
- * Step 3 and 4 are performed only if the system has, respectively, multiple
- * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
- * scx_selcpu_topo_numa).
+ * Step 3 is performed only if the system has multiple LLC domains that are not
+ * perfectly overlapping with the NUMA domains (see scx_selcpu_topo_llc).
  *
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
@@ -3558,7 +3514,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			      u64 wake_flags, bool *found)
 {
 	const struct cpumask *llc_cpus = NULL;
-	const struct cpumask *numa_cpus = NULL;
 	int node = cpu_to_node(prev_cpu);
 	s32 cpu;
 
@@ -3580,13 +3535,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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
@@ -3648,15 +3599,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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
@@ -3682,15 +3624,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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


