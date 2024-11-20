Return-Path: <linux-kernel+bounces-415883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C21949D3DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6714BB245BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20FC1AA1FB;
	Wed, 20 Nov 2024 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hwTcgVRj"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A9381BA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112957; cv=fail; b=rZyaovGiiLRcVZNAWFffjS4+vZ8sQ3a4tH3e/svnUmLBcEOX615nhtMq7PXvQCYSOcZDI+SzpXjVaCmsGb8i31nwkjhMA8fCUSNPy7Rkzwml5d9kiLgffrYZq482s6C+vKnzNo54Wqzi6Se7zsDTAV8URz7ndj0qxjMld6EQUvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112957; c=relaxed/simple;
	bh=ybax6/MgZLsfCBFXyy5IgC3WEnBiGCo2R+TzyjvjxSk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k5gMYzN9OsfAHVXONRu6eafaLgQJJfFIu0dlKFxxmN3Cuok9Iz2RlZ6ZalNUWyUqcWGrfqtItRwMRwfVIDcogHcbCIpWDrFxkAqCtrnpBIuxDNej/GfJ0dfZ46X3TYDNPGqlLgHwzskWsubbALgL32XpVvJSWnSyXxup1XmsD00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hwTcgVRj; arc=fail smtp.client-ip=40.107.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frHltb4kPHMwmLu37udHEz9dhIcdl+MSxwZWVGFX7okbES6AODwWjJI3lVlV9Ltr05RLfFUz7w/HqOaRhZevrN2BFGsIo4jIk0H7P2vBjWq8r/EUzZVSfjqc+GogM4STbG/tVH7rdN+qECqRBdoaST3USzyXcQBPn7NVhtwjmS6xGoB1jImmb8AuZSv69lJ3L1sCG00BVJK9NKW3JkLNHaG9KvsFdbGj03BpG4aZVT+8mmY0eXVSYkBVHCxPBEfd39kfXqopAM0DxFlKBig3i9Ju7SoKEw1HUTVw1YzIBkX0XjkB4i/dU/UQdGns+PBcyiTdbTZvoee6JBSWZbCN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g70Ssr9y1NQ6kVqflFWJovvP5WAv/e4GwAAg7tbJYhY=;
 b=uF+fPRqJcVJEVPr7xVParhLp0CB++H9nEvnbWQZhCmMKo7gWKquE8AGamdZGXniXjF81HhvtAtzJNPKFVHsPQcq/OzbimH+8eKNfZbPAgYFIVMOrQb1CV3EKzDEhBD9k/UDtGF+zPwzXkLbRAnktp0WkrnP8VJhIxxOAQPkA9ckEYWFf+Qdxb0RZTOYmaL0a9wIGIl2dFr4vSv5Z4Falabwe3YPZ9qvKxYhVbaYygBYO7pfz+wfQoip6paZl8In0cz9Uhr1ii71uoyIlh4xnIKXq+fUChqs40MJQhccCD/S6pKKIvp6m1t7ttnC/14K/8Ho+WCgGSiy5nSbOX/r0OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g70Ssr9y1NQ6kVqflFWJovvP5WAv/e4GwAAg7tbJYhY=;
 b=hwTcgVRjeSM2ddJv0mmADOVnYnUkoaQkRz/yWckZqZgH2RVqu8KAuNqownf2AXdu7NAO5QwutEdXAXzAkW4Xj/puYhBiKoezTN07Ncr1McjxNviLtR1kMnGY+lxg9wirBLDrVkx+qxeXE+h0vgfHCLKu+iG7h7P9ZGKUMBGrjiPgRQb2n6A2CT5k1PwavTqxzSHGBdQdgwv3WDqfwHhjXZv6lHe+nucBFlb6L0bAtaUTHtWz5yggTZH0fb+G72JIFEiGruFt7SfOKvkA67riCYhMiuxLf0uz9KyU54e2eZlJzU5OZm0Ilai79MxKV6xD1AlPVd3zxi+80OAQ/HZQYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 14:29:06 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8182.014; Wed, 20 Nov 2024
 14:29:06 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Use the NUMA scheduling domain for NUMA optimizations
Date: Wed, 20 Nov 2024 15:29:03 +0100
Message-ID: <20241120142903.59521-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c87f9f-fa79-43b7-ee0e-08dd096fb083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y44GWe/08rqV7omz144F8GXxs3yXyDT+N0Ai3EqhAO5GYlhgKvFLZbOQY/xt?=
 =?us-ascii?Q?F+c1sIHso+GmT98W6WrZaWj4ukyeptbQNvZUsxaUWmgvREMumoHeCak9SnrV?=
 =?us-ascii?Q?YICOjbXhrIjJ00NOwf5Pu2h6GeialgiRKDlnNfB75e1lsJHPIwfvRUGIDiXg?=
 =?us-ascii?Q?W8WYHvW5xgHmH5/gPJr4scJHH2YTgdSlXW85ZY1Zok/jnUMVUvY9G4T7Ns1K?=
 =?us-ascii?Q?3wypDjDpe30T4vr63c0Kln9HQ8YQpWF+8CeAdnaZPYcz8hLKJnb5sYFQgQAV?=
 =?us-ascii?Q?bV9hTyXDxL1EKRkAWE5QV+oe+LmlFERUVxm4s8VNecxYnmr7np8TLmEXZdjE?=
 =?us-ascii?Q?aqM9I7XNtlJUrMz0CnLnlYh7kjflWO4Lm2ig6wOUekttbQi173ln9yTdMHSc?=
 =?us-ascii?Q?r1CLmexmu/0gncZEHKEgRSz0THJvD+EXhFOcen/J/m7GqMYyx0I2bLSA+Ikz?=
 =?us-ascii?Q?JWPYdiy1BGiRzFiYDKNfcPh+ADyWMQ22tcmdYoANqESFvGdMfse4biQgs1MF?=
 =?us-ascii?Q?cRcu+Z25CH3AGL+vorFkr6jCqJa5t9H27Ps2sspTHLm5qB6NbBd1jkv41U/Q?=
 =?us-ascii?Q?HVxccqj++9rxSgSwXXX36osavZE3KzaomkksNHLa+VHGV0plMk5gDGMfgmnP?=
 =?us-ascii?Q?Q4+SBRFmKDbk6b49C9HBc951Ni++dqIqsyxKFSeQBWpKiaUipcJsZ37Pj20z?=
 =?us-ascii?Q?o3NPthsNrCnUytI3GxTatI39/RUi0n02pL6w9ILAIHXUFjgGnOgWjFQ9KiAF?=
 =?us-ascii?Q?ZJskzEOJnYCm8YrvYqh8fveUcA65KHo99HJ8Hs5iQ5KQwlaMXCRnmOi0ia5t?=
 =?us-ascii?Q?nZlOmdgqcwjj4H3yI12w+GDiUQdwOGkso2eqmvljCOo/1F97yIfbF+a7WET9?=
 =?us-ascii?Q?V2WAWEXlkveadpXu2a0g77nkUYg81rBUMyUH+TVWhpUAVV9QGwKaE1xe7zh+?=
 =?us-ascii?Q?PXbvQDeNkuzXC/DP3PEZCCDiKlnrNzEX76JOl4DZRWVpbMEFZiQZfJDjFb/H?=
 =?us-ascii?Q?cPjheuBKAtOWl8ZhAl1QOym8whEqt+bYZ+zsDlppiDml+dS4tYB224zsjY5a?=
 =?us-ascii?Q?30RQuVmB0BJPXvzfEaUesYE7+YZiTOoKgSiIEY4hH7wtWnrtgN2pbJDYC6IE?=
 =?us-ascii?Q?3D0KRc3/69bey6mjeRvX9WBTQxvQr+BaMpFgktvgSqfRr+4GouPgcvTQ6ytU?=
 =?us-ascii?Q?3OpY6PZQGGLBqvnLhiYAvZcBzmtM6UqX6lJLHA9jfiBewI+aT8B1mJPVNA4z?=
 =?us-ascii?Q?4R/6qtZVWgDBPQ+ZzEpWLZX/vXDddz8VH1Tto2hFzoqK0e7fYD+WBAidGwL1?=
 =?us-ascii?Q?3Z4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pbLBoQA4aIQY/Hc6bM1OsUWoNvytydQbkL3i2/s4e8xhFZ7udu5lmuzyrn53?=
 =?us-ascii?Q?Xq8W1uW2o/xtT+ugzCyZjWsPtz092+tlnFHTDD85GSXSwpUWoLbccydHK7sR?=
 =?us-ascii?Q?bBcwF6W0dtPyoiEfr5PGj+vEY196qCceQHgEOg6DZhzmjvGE7cOsIzHhoELk?=
 =?us-ascii?Q?N5dKaSmwz6ecjYuVqrVmGnAHsh/+MxrKF3lBUD1rgH2aeDTcePizY6jOta6P?=
 =?us-ascii?Q?55dACWZL3hZ9hdBZRr9LnIfW7F0BVErHLiSMgpTv9iB9AuHp6ZNqbweMzc3T?=
 =?us-ascii?Q?SLqw9RvEvyBRL/Jv08pFefkHIQOP7/yW8Wsdw5PV27/pYlZtLDJTU9ieBNAo?=
 =?us-ascii?Q?SuWuz1u2kH/kquJYRcRdqgm2GMec6RmoBkMs7Q7JGPMXMzetS/wZ252PN+eB?=
 =?us-ascii?Q?aJjgXlI+rY02vtLt/K2R0Z4/3GWR5Z9l/QqYGCWQBVYS9MuLN6ZP5JInOEct?=
 =?us-ascii?Q?x2xoxuxlphJnfBIfVpTmWVSL2XUNyatSrGS721J++qWltTq4B4RI5ZZvsdUa?=
 =?us-ascii?Q?OmXqnehMvJrBv1oyuQ3Z5Q9rjoNQgHJs5Y4QTOHpKGIwl/qijfHJizbr0zyv?=
 =?us-ascii?Q?P0hic4sj030TDyuY5YSv1JYvgnXYu/iwRxX7ptQghdnXXHlbqu/L96d/AFYA?=
 =?us-ascii?Q?+dqk2WYTp+PlUNriKPfXpQUHRRImBliJLQGBiDKvAe9+sAJ5ZINO4VMcc+Wd?=
 =?us-ascii?Q?txjuvYQFiU5Idp0Zoo/w+nPsO8syDRCwfqAldGh4yOLvtazzD65Fcgs9ZhpT?=
 =?us-ascii?Q?tiFR/MM6ym3kMM4dOI6Vq1F91PkCuGJBQ7WkofjJNg4fv9IcLL/Z1aWwo6+o?=
 =?us-ascii?Q?sbYORQT9P7fJgvWjsWxT09BhVMOuGJ0PQp9o6ejCsDPDcd9jEecZ/sd0mz9H?=
 =?us-ascii?Q?MHpwSHvDkPI+hJi7E6nnRwwMtZkBpF1nL64B60EoPJoHmx59bjWjp+pVaRGY?=
 =?us-ascii?Q?RyYy9PLsxc7/LBZfxFfwS1XrWKzKx0afyQ79auw0RMCHHrOO+m4E1A8zy0J7?=
 =?us-ascii?Q?p/uets+/Vs4ny2QAn61MulNIMqYB1cNwajmv2vPyZr170sKgv1autocCAtTn?=
 =?us-ascii?Q?bgHt5CMx1sb99j3gag57FN0TG46J0gkequOOYV1LB20/Se4fBR9kHxHZ6iSw?=
 =?us-ascii?Q?JJCnLpd++XyzcuuJck7ZmwBZsa+BoZ0o8yLYhDjwjsLKrBuICt+CmHens72G?=
 =?us-ascii?Q?5S4TgbnxVF2BYWtuX55VQZha2bJwBcrCA77OwgFsRQ9DdR9vH71Wj7YA9V6Z?=
 =?us-ascii?Q?GB4KOFQ2hUmvQ3s3qBG8Ytk2RoOHQJCZrHAYoO3IYuLMVsmMYoCNus0dYGmq?=
 =?us-ascii?Q?7bcnQ/r7vCC6EorqmZo8OS/K2ywNcoVm3OJwWHXHLYv5/XkSoWJlnfyu/BIr?=
 =?us-ascii?Q?w48SM3MoiV1rfv60b4FQGMGczCvOdCQqGDuShK13xv103D5LRW0DGblSAxWL?=
 =?us-ascii?Q?kZaLihP8GX6O26MVeU4+4GhzPPUJFjjYLB3ciUxpITzJYmr80cULpmohfygj?=
 =?us-ascii?Q?0wnpoeRTxnqRs+p85E+yQW7FBWalUShCX12veU2zYuG5Uswsp6loOhKA9la2?=
 =?us-ascii?Q?FQQXfw8xPGeu3q5ehXJdBY1hhtSXbRUYhZ9LKdPS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c87f9f-fa79-43b7-ee0e-08dd096fb083
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 14:29:06.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jLxvZkNBmZpU95gFeQZPViTwzkXb2eml2wULpkhfnLOAKGYATb59NJkdAWqRxVB6+gJpnzTH6Giwxb+df+4Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

Rely on the NUMA scheduling domain topology, instead of accessing NUMA
topology information directly.

There is basically no functional change, but in this way we ensure
consistent use of the same topology information determined by the
scheduling subsystem.

Fixes: f6ce6b949304 ("sched_ext: Do not enable LLC/NUMA optimizations when domains overlap")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 114 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3c4a94e4258f..508845f0c25a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3197,6 +3197,74 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 		goto retry;
 }
 
+/*
+ * Return the amount of CPUs in the same LLC domain of @cpu (or zero if the LLC
+ * domain is not defined).
+ */
+static unsigned int llc_weight(s32 cpu)
+{
+	struct sched_domain *sd;
+
+	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	if (!sd)
+		return 0;
+
+	return sd->span_weight;
+}
+
+/*
+ * Return the cpumask representing the LLC domain of @cpu (or NULL if the LLC
+ * domain is not defined).
+ */
+static struct cpumask *llc_span(s32 cpu)
+{
+	struct sched_domain *sd;
+
+	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	if (!sd)
+		return 0;
+
+	return sched_domain_span(sd);
+}
+
+/*
+ * Return the amount of CPUs in the same NUMA domain of @cpu (or zero if the
+ * NUMA domain is not defined).
+ */
+static unsigned int numa_weight(s32 cpu)
+{
+	struct sched_domain *sd;
+	struct sched_group *sg;
+
+	sd = rcu_dereference(per_cpu(sd_numa, cpu));
+	if (!sd)
+		return 0;
+	sg = sd->groups;
+	if (!sg)
+		return 0;
+
+	return sg->group_weight;
+}
+
+/*
+ * Return the cpumask representing the NUMA domain of @cpu (or NULL if the NUMA
+ * domain is not defined).
+ */
+static struct cpumask *numa_span(s32 cpu)
+{
+	struct sched_domain *sd;
+	struct sched_group *sg;
+
+	sd = rcu_dereference(per_cpu(sd_numa, cpu));
+	if (!sd)
+		return NULL;
+	sg = sd->groups;
+	if (!sg)
+		return NULL;
+
+	return sched_group_span(sg);
+}
+
 /*
  * Return true if the LLC domains do not perfectly overlap with the NUMA
  * domains, false otherwise.
@@ -3228,19 +3296,10 @@ static bool llc_numa_mismatch(void)
 	 * overlapping, which is incorrect (as NUMA 1 has two distinct LLC
 	 * domains).
 	 */
-	for_each_online_cpu(cpu) {
-		const struct cpumask *numa_cpus;
-		struct sched_domain *sd;
-
-		sd = rcu_dereference(per_cpu(sd_llc, cpu));
-		if (!sd)
+	for_each_online_cpu(cpu)
+		if (llc_weight(cpu) != numa_weight(cpu))
 			return true;
 
-		numa_cpus = cpumask_of_node(cpu_to_node(cpu));
-		if (sd->span_weight != cpumask_weight(numa_cpus))
-			return true;
-	}
-
 	return false;
 }
 
@@ -3258,8 +3317,7 @@ static bool llc_numa_mismatch(void)
 static void update_selcpu_topology(void)
 {
 	bool enable_llc = false, enable_numa = false;
-	struct sched_domain *sd;
-	const struct cpumask *cpus;
+	unsigned int nr_cpus;
 	s32 cpu = cpumask_first(cpu_online_mask);
 
 	/*
@@ -3273,10 +3331,12 @@ static void update_selcpu_topology(void)
 	 * CPUs.
 	 */
 	rcu_read_lock();
-	sd = rcu_dereference(per_cpu(sd_llc, cpu));
-	if (sd) {
-		if (sd->span_weight < num_online_cpus())
+	nr_cpus = llc_weight(cpu);
+	if (nr_cpus > 0) {
+		if (nr_cpus < num_online_cpus())
 			enable_llc = true;
+		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
+			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
 	}
 
 	/*
@@ -3288,9 +3348,13 @@ static void update_selcpu_topology(void)
 	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
 	 * for an idle CPU in the same domain twice is redundant.
 	 */
-	cpus = cpumask_of_node(cpu_to_node(cpu));
-	if ((cpumask_weight(cpus) < num_online_cpus()) && llc_numa_mismatch())
-		enable_numa = true;
+	nr_cpus = numa_weight(cpu);
+	if (nr_cpus > 0) {
+		if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
+			enable_numa = true;
+		pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
+			 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
+	}
 	rcu_read_unlock();
 
 	pr_debug("sched_ext: LLC idle selection %s\n",
@@ -3342,7 +3406,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 
 	*found = false;
 
-
 	/*
 	 * This is necessary to protect llc_cpus.
 	 */
@@ -3361,15 +3424,10 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 */
 	if (p->nr_cpus_allowed >= num_possible_cpus()) {
 		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-			numa_cpus = cpumask_of_node(cpu_to_node(prev_cpu));
-
-		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
-			struct sched_domain *sd;
+			numa_cpus = numa_span(prev_cpu);
 
-			sd = rcu_dereference(per_cpu(sd_llc, prev_cpu));
-			if (sd)
-				llc_cpus = sched_domain_span(sd);
-		}
+		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
+			llc_cpus = llc_span(prev_cpu);
 	}
 
 	/*
-- 
2.47.0


