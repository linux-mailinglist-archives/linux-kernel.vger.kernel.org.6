Return-Path: <linux-kernel+bounces-434005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4579E6010
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C1E18855FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5671CCB40;
	Thu,  5 Dec 2024 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T8Fjoc3P"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D661CBE8C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434022; cv=fail; b=UZj3n3UZXZZJV7C1n5Okc36MKeuSAFykgUIHO6S6kKrCutMxnwfndt4c/X2eyWM3sO9Yt3l0dErJRm/dh0uvB5tHFTwHm+EWy+5DMEnYtZ1fyHrnxDdc5IVM8e7QikjSzOsuICYimgHL6UBvAF9HCW+U1yrBxQDu7Q+Ml4gyR7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434022; c=relaxed/simple;
	bh=+GXQvEOMn37dYIlHOfq/T1TBwmVcRCg84JgwcCaf1fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wn/9sJeUIoSHdPPQnQQC0VRgN4WGJRxTp5nIv0QdPSXdVDA+lwXTiH67WwHrG29xpVJRwZQUndTJx2VqoRbEinTHJhh2kCITezxVpiIp5y53BhcjNuLyPdjU16X3voGhioyMsRbEgIgWMId/x19UBr18L74NkXVdV1E+ue5qxXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T8Fjoc3P; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i15HfW0PAWzv4J7/Nn0zqgI+jtsgNgkWsCq6Im8LnC1+3RX2JpR5X3+fjKI0d+wUMisAZhxut3hRqcOfmRpWA2fiJYp0naXw2LjqnRtCHXCT/hCXnntM0U+mmS1WXEssudz+g9tyJnswbsbJQq0Jh94WoNwB8DD7gTMMceRTAAjcrteAGaXJOwaosxlp6aF1psJIS9E6zy2npZXFT3hLd8QbZu1ooGymWODZWVDrzGyKy2C+pzBUgbpsLPCYx53LJSNwqAG4nUUvWD8aaWPJHviB4HQLg8fkhzMbVWcdPW++4CflkKXbNxJLj4j0fJXBMV22F+L4/M5P0my5UvFang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo0ltBXhc9vnRKivw8uGR35YJFwIvzmZFzkwKiPvYZM=;
 b=Q+0ONWFcekJNGNCDCab5nusmvoCpRIeNUvb4eumUA3ct63yILCOCp2KXMeJVAMMd3F1brOFpBxI+tWvh6bhH8evJQEqcenHB0l0QdBCq2cD7NOQGu69m7G00BMTB0HU0L4SQ/MNSvYvuRFoUDOKMqR/IG/PPRhN8ZlJ4qp/cOVZRFITGgA6jwPOJZvdVP9yMQliuwwero98atBx7XI2wCL5IpsRF9GuGe9cP9RZNFyiqo40zzPhDqbQrMx+Vd86YZveqBL6vJ3cZyrD8sWHtmKstiSNwwQqyxDpRkqNpuh6OYlYRmw0PaipHh5tsHsUhgQhmlm8yLskcHuL6+VbY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo0ltBXhc9vnRKivw8uGR35YJFwIvzmZFzkwKiPvYZM=;
 b=T8Fjoc3P5pzMiIc9Cwy7TEzvlgwInZCHuwE6EiS15loIYXjkg47uxzX5fn+3tcTYyQgRDNufOR/rXg5zIeCdLGLXTSDsa1QaIxe/nC/5nfLuT2hecWkbXSqXWljVaAylEy8V2/8218LS+f+XQlVC1W9yulwbWQpngOjMfssS4ynrqlyRoUUG7WtaFnwhicmMQYaSL+jEg+mtxAR6QhA+FScxCFR6jvbIDRlIhNNzhx8DPngne8Iu/Wqf12K75yNybKVZG9bleaOD8s6RIKrF9PoAMQzBtvHn60t7Vxt5PlFr5Thn76g4Zz1smm+IjUHm1/ibRcd/ZJ8+8vtySRK2ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 21:26:58 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 21:26:58 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] sched_ext: Get rid of the scx_selcpu_topo_numa logic
Date: Thu,  5 Dec 2024 22:00:24 +0100
Message-ID: <20241205212627.193016-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205212627.193016-1-arighi@nvidia.com>
References: <20241205212627.193016-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a309b2-4d0e-482a-eee7-08dd15738c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h/gL0VrbO9grI3s87hV9HGxtxT35TD2dT57aD45nKjaPC+rAqhIEvMAX1hXy?=
 =?us-ascii?Q?athgU5jPWPUBeW7gEiMG9H8i8c5xrMgzT1OM0rtodiuz0OQOvntjXZwsb/V7?=
 =?us-ascii?Q?uvcXfgLoj1c42lE6d2Le0/5p7jgf+Jew7uD4UDJKyIReJvDNoEoMAmxEpX1n?=
 =?us-ascii?Q?aCDQm4VeIWj4Uoka0wbBlF4cxM7ok0AaYVAdoj/WTA2mtIByz/+CzorqFESc?=
 =?us-ascii?Q?39EEJGZDHWR3LznZkpIaBDZ93tjdlqA9RgCazB8gYqlfo6/fBtsDqarpajhG?=
 =?us-ascii?Q?iA2/lviAn3JcE0tn8anwUVFMkI907jj9E0tSLsOCagHdIfNdX9TroFhfYBWz?=
 =?us-ascii?Q?V/Br/YuFJI04EeyVSvUSgROuGza6O3EkNEJVyDaaNVJ0roijqitG+Qb75Z56?=
 =?us-ascii?Q?x0R0VO6IRRF8WoUxhDV5Vd3uEtITtOr1ACQkS1loOlnikhSP9OARxOzqJEP/?=
 =?us-ascii?Q?LN4jvfoIy9jf/ctR6kWpqJjHU+g14TcMRBFDYtfvrKSE4H5SD2/zWb5WoZmT?=
 =?us-ascii?Q?Dn3V4YCMGyWHsl63WvlkHwbTrQaLIBbLozkBN45OGOXdD57wgs5oOlDgD2dl?=
 =?us-ascii?Q?PBTala2rWzLJ41okOio5xlMCbmihQWsBE7RFtqOwKVqq9XTzFlHPBmOT/NJ3?=
 =?us-ascii?Q?uLGZ2tka6ilUamTFLCH1nyZHo6HBWpVpRmJ+DKc0soAEWxqUjq19iU2xdc+1?=
 =?us-ascii?Q?ahge5tKEizwqkKGooVXOyU7Dnkq1T3keW5KXF/rUJWPUgf2tm2cwCqphuo6m?=
 =?us-ascii?Q?WCVAphljJgowZ3woaFxCGA3zqYwz5KBhGgK1Q9MRSdZ2bXaKYc+jzmUHN7B7?=
 =?us-ascii?Q?iZUJE3JFafJMW/pEt2gFyzXEmEWXM4CzSpFUDfwaY5XS9ObIusPDcWj3wIY3?=
 =?us-ascii?Q?9JcoEIQk7RW7eiWRdQB9BL9c+t3vc7RnPUDMhUdgmzS2WQq0H7vKvrqHtN6C?=
 =?us-ascii?Q?v4DrJ8BHwePyh4kKkYWVc1X2mBOtZ4gUjjdL26Mv2y1LL3Xm8xCLgWdpgphz?=
 =?us-ascii?Q?Xb+dea1Ea8mf2eMsl0a18IfuPSHGA7JOvRTOT18+YKOFk6O0ckVee42edphq?=
 =?us-ascii?Q?Aga7PHRqRndTC5PSw3RO9Hi19bb7A1hxQxMt/6JrbOhKallMCbhql+ewXzlJ?=
 =?us-ascii?Q?+sGNEIZ3RulYt2V+t5vIy79jceidJ6yYchfKM18a1Sg+1DH38an5STVBADJD?=
 =?us-ascii?Q?XvuUFg0r9wWLR2FylfMawv6FVn/jkRLzZpxWbwZEiKTs+gNuf6pjbtT7e+Ll?=
 =?us-ascii?Q?O4Zmb7HrzZtYvUxuGyX/STlAzqTTTvR4zYP6YaIycjI3BPcm6YvnvjhuHTa6?=
 =?us-ascii?Q?HdRlLGam/L40PyHiX9M1TRPvNEbU+uk/eqZLeOmH6HTtkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cP11E7v2UlfZPhAVrh1FueNJgQ7VxxCz5xtcGDd/ZvkOSj5k2u4z8mGHB88K?=
 =?us-ascii?Q?x4pO4pK2CwI78cTW+A1XHllMQPz5MKFuAw+qLpokCuo53B/G+yRoqRvRDEMl?=
 =?us-ascii?Q?NshbLlgTcW3c3zN2No87OHFnkskloWnilckVPS3zxtIvVdRFIw1I5tBeCg1u?=
 =?us-ascii?Q?AAHxge4c3aT5vXm7HollXJQZ8G3rAfp3V/h/Fq5n05YtLy0vd332EQI2Evdo?=
 =?us-ascii?Q?bXu5bSAn4UKRmpnAz98R5rYti6hrNazNQUc9EjSqyirkFpbrcIsJyrp5VkoW?=
 =?us-ascii?Q?KXWxvz0qMeg4MY3K8THfPiIsa7KhJMH9VMUgF93eADDlvok3yArSoVS3lWkN?=
 =?us-ascii?Q?oJTps1ryC3iqkgi3mzUeUKbNTVQ8EJadqEtIi9UVjq35Szwq6lFAYKGo9f4X?=
 =?us-ascii?Q?iRO2r2VOJyuky9FUZ5mZexblNz4lEfjPdR++myFZokLSdz5jYNi28kKpWvzF?=
 =?us-ascii?Q?Uoljf/YLOeDVvIB12xcovc14H/Ovzk33j9pw8nfIHsE4mGAaMBJIPjR4K26b?=
 =?us-ascii?Q?iZVjFwWa8uxa9s1THUrZpkOgPtP6u3nXlT2lNYNq/jHc7n3bnykAk8mChekd?=
 =?us-ascii?Q?/GgjV6Cgp71E+xDVAyZFaelriSqbK8o1fKyhjrsdCgvTbCu4q0mAeZm6WB+X?=
 =?us-ascii?Q?agzRjiw/DGBt/sSZBI6+cKW6vI0hAqzGeEAu7FgFHIqaal0ICdyJ2yBbVacY?=
 =?us-ascii?Q?Auq6HXH3Qk/w3j9W7U/TveqRgHGD8RbHWb+Y9JsEfCJclRzA0K6We5I6rfv/?=
 =?us-ascii?Q?DFhSR6HkkHMBPvQLbxS/Wcyw6t8/WkdKCza7uX7Rw7RepyAe4NxO3z6YazZG?=
 =?us-ascii?Q?I081oV9WcVjWscG4LyUGlyelrXJ22qnymR/97lty3lb2yvYm9nJVHBMFkLba?=
 =?us-ascii?Q?+YH3ezKhHIeI2cNmovdWxCWojiN7DjJVQUibsn3iYbtiVT98Nf2MIC/laI7y?=
 =?us-ascii?Q?cR8uabVC4RbMCCh+IwEGPw0bs5h3OW19NchK/7K/iS+9wyzSYnAHsVe+DrDp?=
 =?us-ascii?Q?oy3MiwpGPO4dZ3Z9yY5PaRAQZ93RFTv/aDEZKgJw4r50Rll8nyQYlHbeiv0Y?=
 =?us-ascii?Q?PTdtGBeYQ0GMQqeZmPs8XLbLeXGM6WyezIBS3UXGpU9MVaouTqv0q5s9rhr+?=
 =?us-ascii?Q?uRoYEFSMo8lC97H+AL+iDAZa59aaLFE2UzbeW4ruuzQuZ6iOORUYVnJW3aLR?=
 =?us-ascii?Q?8deBqNn+tS0pm9xgnGxnUfs5cw8Wjl8SAvF/awp7taoiNBjssOdDHiSp7YrJ?=
 =?us-ascii?Q?NPOIOiPP7L+PYMi2TAElvXzU+QdlxmSeqvtNe4VMFb+b5rZxWs8S5XWasfOV?=
 =?us-ascii?Q?ScZ7N0J0svvrVX10yU71xYepirnlQilDSfqKCumibI9tWQ3SsKBSeRBl8P6z?=
 =?us-ascii?Q?ENxTugowW96zL07k77l3gRkaKUgDBueK9OuEF/eohFh3Ulmdy9/Ke5hBOYIK?=
 =?us-ascii?Q?jLmP6tZVp2y8Lds2/BI5sPaJgdcJtQp0KKoaoKMQgCvB9qmCF4dpIqJtKI41?=
 =?us-ascii?Q?mQsbJrfSTYtXO6f1Vv7/fC1dQpdJzCQZV5+wKzpyb0YZeMbUAsHfsoFmO6Fz?=
 =?us-ascii?Q?t39k+YaVayEgLl0EAbn6TsTH3J4dJ0hp3DuzeP65?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a309b2-4d0e-482a-eee7-08dd15738c8f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:26:58.2252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sysKGoYZ4NX4sjPw8+2MGhsTDbUENiKCk1E6hBD+3ec/5lCD+wuItBqKqT2mtXtF7rDVx8SiTgqYO3U14qJ00Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741

With the introduction of separate per-NUMA node cpumasks, we
automatically track idle CPUs within each NUMA node.

This makes the special logic for determining idle CPUs in each NUMA node
redundant and unnecessary, so we can get rid of it.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 77 +++-------------------------------------------
 1 file changed, 5 insertions(+), 72 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7e7f2869826f..ed2f0d13915c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -886,7 +886,6 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 #ifdef CONFIG_SMP
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
-static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 #endif
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
@@ -3375,25 +3374,6 @@ static unsigned int numa_weight(s32 cpu)
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
@@ -3445,7 +3425,7 @@ static bool llc_numa_mismatch(void)
  */
 static void update_selcpu_topology(void)
 {
-	bool enable_llc = false, enable_numa = false;
+	bool enable_llc = false;
 	unsigned int nr_cpus;
 	s32 cpu = cpumask_first(cpu_online_mask);
 
@@ -3462,43 +3442,20 @@ static void update_selcpu_topology(void)
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
@@ -3519,9 +3476,8 @@ static void update_selcpu_topology(void)
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
@@ -3530,7 +3486,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			      u64 wake_flags, bool *found)
 {
 	const struct cpumask *llc_cpus = NULL;
-	const struct cpumask *numa_cpus = NULL;
 	int node = cpu_to_node(prev_cpu);
 	s32 cpu;
 
@@ -3552,13 +3507,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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
@@ -3620,15 +3571,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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
@@ -3654,15 +3596,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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


