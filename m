Return-Path: <linux-kernel+bounces-386660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0BE9B4685
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD89C1C226E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3A520493E;
	Tue, 29 Oct 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L2AeoOWL"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F10204082
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196990; cv=fail; b=dSt1AS1t7Dc55bLCe7H46qhbArLDSzoQUcXy+QbPpU4GrI/015xQWoDFyFCDKCnOvfVlhV/O6eVx0tLADeA744MUg4ixnQODTq3Axezlp+cDeccbEuzvboV0/lh/7/xhZa8ThL8chmRHVDCOQplZE26Uw+ZhNiOBnNWr4FOA7/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196990; c=relaxed/simple;
	bh=Hmn+wnPElvqZ2tHZ0xFPxFR0sLEfFcOWmoEl37We4gs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y3wJIOFrdqlkg1cKnxnw12Mr7L9SL1rhLrBlwF2t3sYnf8GD2tNqfyfwOk9wVpQ+QO9tfQ1liXArqEhMCfpKtQrQ1J83wT+HtaV/06CPSfvkve1iLQ81+0dn/Hz4GGOyAqCRtS3Ek/GzHUodK7rGmGByOh7MgTudWtFbCVtnFf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L2AeoOWL; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsVAFVZPK4NyRQZRUSVoQ3v5Oa9gZnJjCnfBz0nA3J+RbWgRcdi3jXNSW1HEHRd12x3HyqTA5DQbFpBFhG9uhe0lq2HYWSW6pbHnE0Nn/2NiTFpyOg/t39xSYIpUm5XR2QwCpO03zYS8v2h4HR9ERrgHQHDZTgNgfSh6w3gdkIJ1lIKHE78sqIwdCxdAtZDLnv5ebjPeiWebD+ovVNDQhmW2Hykd6BFmzT3AKFNuPWO8X+1X1jaWf8RsH65J/o9i/ucpkk6pQWreiFAMXTrMtZoTVZQ4SkVCZxh0yiX17K9HOF/S3TtCRXfI3HepsieSKMnzT0/eWyxF6sqBH7zZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxWEHlNKgCOLgqQYosGPWDc5bJWTkQgdeAFfPj/h3Ws=;
 b=wVZ70g4t6crvBK36EacqAS+XDULJcfV/FzmASLA9cscAOPC7kaR+qxqm2zLenUoqHjjUMNosk6HpnL68nMQ3ppjouLjeaP8ZpCqes1vf4GaKYt+RPiTyAnWgdix1jXumkCucLh6q7iHLfi+pWKv4F/1VIPREoMLkSVXUfkCa8gue7KsxB20JPZtnwfLx6DsedW4GHC0Z3ajqRiG963Smr8SWFoPY5UfcFzrFRvb0IE9OjnGZHtPXJQzsZ3QnvWzG4EeS80mkl8v6ruNceFJpM/5oSJRSjByZDF7bOV3sSOTcjsLS9PN3U7pl1+U4rYewqAAHkb7dcXDbpxSdMFiopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxWEHlNKgCOLgqQYosGPWDc5bJWTkQgdeAFfPj/h3Ws=;
 b=L2AeoOWLF73evollGi1t7H4N38x/hJOhdEdqxqgLRLKNDgvQT9D0+gn2CcXtV9pNvcieT3/sBJesWmDU5Dab/oV5ly4K2/2gK7jM36QmbD+aBHtRJtdI10vDusQv0LpHSQTIUU/1bVIA8vee4La3VH7R8vfhIYrekzi8hwyaVHLBVxkJ98X8yAEJkRx/b+didUxKoMojwMeylTEvdrg1n9w/GtjzW+thfMONw7qZqd4qvmxbLH0wmsRbyeIXkAkVxJcOdjVbUsW/TXCn7WFKI/g4nKL01cfCz5GaAd6X4a/iV9oEdScm99rRu09/EQqyZW0mq58e8rYOGoSCt/ahVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 10:16:23 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 10:16:23 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v5] sched_ext: Introduce NUMA awareness to the default idle selection policy
Date: Tue, 29 Oct 2024 11:16:18 +0100
Message-ID: <20241029101618.318812-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e187bb7-ff46-4d99-af7e-08dcf802bd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zHAoE8CAf2QMk47mE7/1OPL60YwBb8e3C88jYJ0Bx438Z+QUjJEEVATH5jaA?=
 =?us-ascii?Q?fTEWtrgCNNM8r/U8GvfgvkUf16M4BmGxJiVrGAjm6jaQU3C7u4Nr33W+1IoV?=
 =?us-ascii?Q?PxCTgvBAVrtRKyU1DOpPs+aIoDqPZBRE66FuFEfcyHUCmvvLTwSClIT5Fmmj?=
 =?us-ascii?Q?aS3zNPZzr/Mg5jCAkfXOREX+UFckdLedmWJSVnoReUvYR2wxEBOEaNW+W8x+?=
 =?us-ascii?Q?YSxFHcIK/pfOR9Q80AyWUO79mxkkPCUEdpOC0STQ1P6mOGNVPsATsxgFGoEm?=
 =?us-ascii?Q?0RdPMnMkKNY8hOpeTbPhnQYQOHghdd63VePs3jTcDE+12WMDyxNdaAFEwJqs?=
 =?us-ascii?Q?FC2u5gimC6JS0QJEaJaeja39RH24JPHIlQGGDMAr//ULwiYIpGI3OVieQcdb?=
 =?us-ascii?Q?s6PnSpPc5ovA0G9xqxR9Wr2stxEmo4VDGkleDScVa2FT95FpBg6zOd0kJifQ?=
 =?us-ascii?Q?GikDgOrXxzbpsE26G3c0svcTxHErCtv1pmSiGkdzUELo0aBxTxoqHkY+0F3O?=
 =?us-ascii?Q?ba5/MHc1uKtdhCYEkmDBIuUZgCxeqpWitxcNCwNFlE7s75GLimK+gvZkzDFs?=
 =?us-ascii?Q?tzGSFidDtaqNuqE0GDm9qK4dXscIjAqLCPiMU1oHchR+C21cHF5cogYvklLP?=
 =?us-ascii?Q?t0X0OBTOQg5m3Lwyq8h3MH/O9p+3Qev+NQkdw7fxhpWiNDJgOMy3HuyeBCLc?=
 =?us-ascii?Q?yVWjeMoWjd0EUckB3Ve+0t0iIoraX9YLbAJ7KKYEeKaSkPy5a5PU0hwE8Ukw?=
 =?us-ascii?Q?Q7OG/rTnETwvNw4es42IK8n2bKfPlFGi/wEAvue9k+1B/IMgZX6uGuwXjFtL?=
 =?us-ascii?Q?MSvVL4kCo5ExjbIP8S0iR3RQWaQ+pQzmbKLRM7aInyRiPMeNsWqh1L69lmEW?=
 =?us-ascii?Q?zN32TV9aZGdFJPcZmLBnHF9D7NHXNlSAcZPHRR6WbNat2zQUT2gWe264T/M7?=
 =?us-ascii?Q?l5SsleuoGYKDEapVgUv31R8QVBZ7oeVvlDmVcJkbLWIYhFQWoJ1q7F7rYyan?=
 =?us-ascii?Q?Dfa3zxW1cxL+7ynStVkqhrqU+psxYWtZkpk2b1j3/3JIJwZMVlBMkHgzFVZI?=
 =?us-ascii?Q?BnStxLgc6WCVJsUnmUuQHc8xeG5/sPJAHdRAsw02ESV8/MIPqEoUmCGcMfph?=
 =?us-ascii?Q?eXHA8UZ2waPWiT+x+sFvve18xzB6AHbWlyvYAMqDAf28PfwMMTigZBxjq7yq?=
 =?us-ascii?Q?rBLWAc2xmXeM/wgnBAiFS2QCk/VjgXG36tLiTPLUHTh1nHl6kBgyvXqRJ3q2?=
 =?us-ascii?Q?T38Mj7a7CGNwqTl9PEZSMOBRYdkn0LsUVg+xG2ieAFZkjqpRjA4l+8RR/LzI?=
 =?us-ascii?Q?faMN78HfXZjHDX/GfmaOVevg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VnUzwsWF5zWT0oGigD1nFFB4b35kOAWg+kz8jpDC5McPeL/l4+/Dr11pjoIc?=
 =?us-ascii?Q?GPAvKsABX+nHDjPdmEIkTjlWQrHXaWigNNG3BZDXqzwnUQR/Ieu9WRGP4fUb?=
 =?us-ascii?Q?G8/4TOQAzZN0aALFIk29348Etq8WVie/WwGLQJIBX+RyWZ8l8EKuzbg2ogOk?=
 =?us-ascii?Q?6VAAaS2NmlD0kratDl2KejLUlPkeC+qtrWVOaSuKpFO0FR8EbZfG+icebnvN?=
 =?us-ascii?Q?KM8L7Y7TTbW+XebwZhOncbqf1RNNfUHjB863HURPLahGNRXjnzeKLvlf14ut?=
 =?us-ascii?Q?4v3Ro4jkIgcG/PUjSa8h58ZrhCxGTUgZi2r0D5wuSf5NCiX8Rsae/ClK2wAT?=
 =?us-ascii?Q?hLTsPsH6wx7+/mXsrFs1drZR0h92K903oizQ8HNx8G6eUJo6yrozXEYWrNwG?=
 =?us-ascii?Q?j6LE6bSVwxPBImEq8fa7wRFI9PzvZjAEdv420lWk9l89w1W6lNXbqNcpHevV?=
 =?us-ascii?Q?PV4F+TObeFrrkUs4KyzWZfT7lsIClv55TiFzyc8gVxUO25doDpt286MK6xzS?=
 =?us-ascii?Q?JsGc2v5/xcwHF1h8RpK+o1/18NsGVzUN/7Oj+38viu1XzjMMSPcQ7W6aRhhN?=
 =?us-ascii?Q?Qo+hQDqg0hwDce5ONV1bH6768nuOdoPaY1ke9TrNnkdg6vNyM6id8h5Rd54Q?=
 =?us-ascii?Q?NNH2w4Y12GED+ba6pAXl8jbktIBnI1qRl3nqDOlkE1H3jmiWsLtRAGdeBt6b?=
 =?us-ascii?Q?Zc274UmMaok7WkkVGtTQ6W93pHuiWUGVaOQpwjiJRIt7+w3lGgUnx4w7lOhQ?=
 =?us-ascii?Q?vs98jiPpFxb6aHtE1jFNX05HPamomIypvHw2TEaQPJI4edPvXn5Tza6MhNL6?=
 =?us-ascii?Q?W9Kt1V+2Ye2kK6kC/vM6rffwnShWGYkulc0dPLkU8PM/mnSpmhE5zbX8vWVy?=
 =?us-ascii?Q?oNJgqpw5MoU+LvSf7EZ2ELIXWbxEf3zXUSrFXkZ0eKqwhWRl793jaCzxeJjg?=
 =?us-ascii?Q?Is+CO6jowoHLlOLBTAMpQEDCBiKVy4GkuWuH6hkUmUD/cHPl89YSFgRXLMQS?=
 =?us-ascii?Q?L8OU8TgTrxGvNdOGWYOJaS9H+7Mq/+EGUe3RN66Rz4mlx1dhjWYvHlD5JfGw?=
 =?us-ascii?Q?Mg+uogFvHci7UXSpDK/nNk7y65bH0ioLRaJ8OWA0omm45IZBCQn4wtIXIr1F?=
 =?us-ascii?Q?2GkEqLkx563YmHk4l8VTul6N9HB4fB5g5GNhuXeuzyTxCmbWHvsI3sCPz94t?=
 =?us-ascii?Q?qeLlQqKYSUgmFo9i7MK17aK7ybwVDzkHY0cXDOAPDQyKZB7nwi5Hmk1E6vrG?=
 =?us-ascii?Q?nO5YPRJYw8uxhgFFCctNTQoN+x2mAZQWicjBrHlqkja0bOaa7Yj6BVSNppHG?=
 =?us-ascii?Q?pwf5yJL5df5jS1v5QCG1D6zPuaKHU9PO/MgyT2X2G3hKNnLeleOQ0KY+i84M?=
 =?us-ascii?Q?7TMob+dpz43vutX57jP+MRpMjrxQJ4TigjMvlbAct5tRbE/RdWlrpuICoaOR?=
 =?us-ascii?Q?40oxijs11zd0XEhSHCVhF2oCPqIxo+eyRdmM4K5pHqTNPU2E+bG5koV0hny2?=
 =?us-ascii?Q?FAbwIuy216UnzAihzPk1Bdc5s0cJ0eGFp3iZ442GjYMiorCfBYHG3Y9AyU7F?=
 =?us-ascii?Q?zGYFfbEa1TkfXBNRNljBBbOd1UmEriuJu4/LM0x2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e187bb7-ff46-4d99-af7e-08dcf802bd91
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 10:16:23.6276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RcIOvXL6GGQ9jzM4vGRIWHY4J8Qsj9eJ1N1UB/cPs4xBaQLNi1wHA8xhRyGpbx+7pOO9bXMd+pOiT4U1/SL/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698

Similarly to commit dfa4ed29b18c ("sched_ext: Introduce LLC awareness to
the default idle selection policy"), extend the built-in idle CPU
selection policy to also prioritize CPUs within the same NUMA node.

With this change applied, the built-in CPU idle selection policy follows
this logic:
 - always prioritize CPUs from fully idle SMT cores,
 - select the same CPU if possible,
 - select a CPU within the same LLC domain,
 - select a CPU within the same NUMA node.

Both NUMA and LLC awareness features are enabled only when the system
has multiple NUMA nodes or multiple LLC domains.

In the future, we may want to improve the NUMA node selection to account
the node distance from prev_cpu. Currently, the logic only tries to keep
tasks running on the same NUMA node. If all CPUs within a node are busy,
the next NUMA node is chosen randomly.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 136 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 119 insertions(+), 17 deletions(-)

ChangeLog v4 -> v5:
  - use cpu_online_mask instead of cpu_possible_mask
  - call update_selcpu_topology() based on scx_enabled()

ChangeLog v3 -> v4:
  - check only the first possible CPU to determine if there is a single
    LLC or NUMA domain that contins all CPUs
  - use static_branch_maybe() to check LLC and NUMA static keys
  - fix build with !CONFIG_SMP

ChangeLog v2 -> v3:
  - fix RCU locking
  - use highest_flag_domain() to determine the NUMA cpumasks
  - rely on num_possible_cpus() instead of nr_cpu_ids
  - refresh NUMA/LLC static_keys when an scx scheduler is loaded and on
    CPU hotplug events
  - rename static_keys to make it more clear that they are used only by
    the built-in select_cpu

ChangeLog v1 -> v2:
  - autodetect at boot whether NUMA and LLC capabilities should be used
    and use static_keys to control their activation
  - rely on cpumask_of_node/cpu_to_node() to determine the NUMA domain

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6705c2e67c99..fc7f15eefe54 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -870,6 +870,11 @@ static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
+#ifdef CONFIG_SMP
+static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
+static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
+#endif
+
 static struct static_key_false scx_has_op[SCX_OPI_END] =
 	{ [0 ... SCX_OPI_END-1] = STATIC_KEY_FALSE_INIT };
 
@@ -3124,31 +3129,79 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 		goto retry;
 }
 
-#ifdef CONFIG_SCHED_MC
 /*
- * Return the cpumask of CPUs usable by task @p in the same LLC domain of @cpu,
- * or NULL if the LLC domain cannot be determined.
+ * Initialize topology-aware scheduling.
+ *
+ * Detect if the system has multiple LLC or multiple NUMA domains and enable
+ * cache-aware / NUMA-aware scheduling optimizations in the default CPU idle
+ * selection policy.
  */
-static const struct cpumask *llc_domain(const struct task_struct *p, s32 cpu)
+static void update_selcpu_topology(void)
 {
-	struct sched_domain *sd = rcu_dereference(per_cpu(sd_llc, cpu));
-	const struct cpumask *llc_cpus = sd ? sched_domain_span(sd) : NULL;
+	bool enable_llc = false, enable_numa = false;
+	struct sched_domain *sd;
+	const struct cpumask *cpus;
+	s32 cpu = cpumask_first(cpu_online_mask);
 
 	/*
-	 * Return the LLC domain only if the task is allowed to run on all
-	 * CPUs.
+	 * We only need to check the NUMA node and LLC domain of the first
+	 * available CPU to determine if they cover all CPUs.
+	 *
+	 * If all CPUs belong to the same NUMA node or share the same LLC
+	 * domain, enabling NUMA or LLC optimizations is unnecessary.
+	 * Otherwise, these optimizations can be enabled.
 	 */
-	return p->nr_cpus_allowed == nr_cpu_ids ? llc_cpus : NULL;
-}
-#else /* CONFIG_SCHED_MC */
-static inline const struct cpumask *llc_domain(struct task_struct *p, s32 cpu)
-{
-	return NULL;
+	rcu_read_lock();
+	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	if (sd) {
+		cpus = sched_domain_span(sd);
+		if (cpumask_weight(cpus) < num_possible_cpus())
+			enable_llc = true;
+	}
+	sd = highest_flag_domain(cpu, SD_NUMA);
+	if (sd) {
+		cpus = sched_group_span(sd->groups);
+		if (cpumask_weight(cpus) < num_possible_cpus())
+			enable_numa = true;
+	}
+	rcu_read_unlock();
+
+	pr_debug("sched_ext: LLC idle selection %s\n",
+		 enable_llc ? "enabled" : "disabled");
+	pr_debug("sched_ext: NUMA idle selection %s\n",
+		 enable_numa ? "enabled" : "disabled");
+
+	if (enable_llc)
+		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
+	else
+		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
+	if (enable_numa)
+		static_branch_enable_cpuslocked(&scx_selcpu_topo_numa);
+	else
+		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
 }
-#endif /* CONFIG_SCHED_MC */
 
 /*
- * Built-in cpu idle selection policy.
+ * Built-in CPU idle selection policy:
+ *
+ * 1. Prioritize full-idle cores:
+ *   - always prioritize CPUs from fully idle cores (both logical CPUs are
+ *     idle) to avoid interference caused by SMT.
+ *
+ * 2. Reuse the same CPU:
+ *   - prefer the last used CPU to take advantage of cached data (L1, L2) and
+ *     branch prediction optimizations.
+ *
+ * 3. Pick a CPU within the same LLC (Last-Level Cache):
+ *   - if the above conditions aren't met, pick a CPU that shares the same LLC
+ *     to maintain cache locality.
+ *
+ * 4. Pick a CPU within the same NUMA node, if enabled:
+ *   - choose a CPU from the same NUMA node to reduce memory access latency.
+ *
+ * Step 3 and 4 are performed only if the system has, respectively, multiple
+ * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
+ * scx_selcpu_topo_numa).
  *
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
@@ -3156,7 +3209,8 @@ static inline const struct cpumask *llc_domain(struct task_struct *p, s32 cpu)
 static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			      u64 wake_flags, bool *found)
 {
-	const struct cpumask *llc_cpus = llc_domain(p, prev_cpu);
+	const struct cpumask *llc_cpus = NULL;
+	const struct cpumask *numa_cpus = NULL;
 	s32 cpu;
 
 	*found = false;
@@ -3166,6 +3220,30 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		return prev_cpu;
 	}
 
+	/*
+	 * Determine the scheduling domain only if the task is allowed to run
+	 * on all CPUs.
+	 *
+	 * This is done primarily for efficiency, as it avoids the overhead of
+	 * updating a cpumask every time we need to select an idle CPU (which
+	 * can be costly in large SMP systems), but it also aligns logically:
+	 * if a task's scheduling domain is restricted by user-space (through
+	 * CPU affinity), the task will simply use the flat scheduling domain
+	 * defined by user-space.
+	 */
+	if (p->nr_cpus_allowed >= num_possible_cpus()) {
+		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
+			numa_cpus = cpumask_of_node(cpu_to_node(prev_cpu));
+
+		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
+			struct sched_domain *sd;
+
+			sd = rcu_dereference(per_cpu(sd_llc, prev_cpu));
+			if (sd)
+				llc_cpus = sched_domain_span(sd);
+		}
+	}
+
 	/*
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
 	 */
@@ -3226,6 +3304,15 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				goto cpu_found;
 		}
 
+		/*
+		 * Search for any fully idle core in the same NUMA node.
+		 */
+		if (numa_cpus) {
+			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
+			if (cpu >= 0)
+				goto cpu_found;
+		}
+
 		/*
 		 * Search for any full idle core usable by the task.
 		 */
@@ -3251,6 +3338,15 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			goto cpu_found;
 	}
 
+	/*
+	 * Search for any idle CPU in the same NUMA node.
+	 */
+	if (numa_cpus) {
+		cpu = scx_pick_idle_cpu(numa_cpus, 0);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
@@ -3383,6 +3479,9 @@ static void handle_hotplug(struct rq *rq, bool online)
 
 	atomic_long_inc(&scx_hotplug_seq);
 
+	if (scx_enabled())
+		update_selcpu_topology();
+
 	if (online && SCX_HAS_OP(cpu_online))
 		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
 	else if (!online && SCX_HAS_OP(cpu_offline))
@@ -5202,6 +5301,9 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			static_branch_enable_cpuslocked(&scx_has_op[i]);
 
 	check_hotplug_seq(ops);
+#ifdef CONFIG_SMP
+	update_selcpu_topology();
+#endif
 	cpus_read_unlock();
 
 	ret = validate_ops(ops);
-- 
2.47.0


