Return-Path: <linux-kernel+bounces-383718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC9A9B1F78
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D731F213C5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCEB16EC1B;
	Sun, 27 Oct 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z0hQe/Z4"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F3152E1C
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730051409; cv=fail; b=ltMdMFRquVqTWtE36hzuLBec+GjRVNHF6mqRuD2FS1wOleqVFGUmsafAYmO4NQYzEvv+8lhPItGgRo8bwY2HQQMiA1QIo5az3/ieT5nbNPrLef8URekL0f415cDDYk0uezuj1Lf/SrI1JYQ4+PARCJZst7S67Rlr3dB0Q0iN0X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730051409; c=relaxed/simple;
	bh=oAleyZRjpRdMF2VyeKiz6KHi+Qc9LSaItiL2fqGkiCY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h+lfTT3AM/edZnXgfCKXkZcx+uDtc+E7qhSVPiLbMfj37dzbwSEIQeGomGLCzTu4CkUx/1aJMMXlpWhk82aSejZBOTJ39MIux7oIoAjokmpBEABNuCsCzAUdsCKRVhBnnbwGSR4crXMXElHS8MI++oV5W+bjtXoeLfLG7xdJ0TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z0hQe/Z4; arc=fail smtp.client-ip=40.107.212.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZQ9MqKYlocqZ+Rgs2BIcr/cLJN05d9O1qVW+g0jwlZeS53dyfPnKOpvCizZaXZ4Gr32HaDqv4F3H+WyU0tvbgfNhcJPCP/K5hoc/KhPLKLhu4XCk5hYGHc3HRSdD5CbKwwAcWXxdraOtZCs2Uwv1231xanpfCixfE95jBl9ahgZoQFu0p32IFJjVmUQ0GkK1+2IlMVCSkeyK1JscpwFSLeE807MNWTDH9l5SV7TdhrR+Z6zcUOWXCDxEFQFEYRRJuw9t18PydgKZVwW8VMeQUr82hWCuILvutdYrYytQcY3lh0qKSKjOdwa6cDVgnlA5BawDsKeApvexpdoRHZK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jG2hbTWgbvoLlf5/nQGW2VP+RZbf62sUjmmaaE7Znps=;
 b=MrNcu+bO7JIOFpsaDB4Odz2pMDNFVDDaXNCJvlo4Eie6bDxGm8NFmurrzbuC2c/YWbD0kRC3la5SUfhSSaLCPikaKHXa9tx6CVjbGXuEmsnxwJlxaMxNPnZS9yqWbpoJl7UT5pITZQlrcWNmGOTw7YUKuv6XrGP+XnzCFcrKSy/nYOaF+oAEWWeSThMhSDac5ZuylOv/x5yPYpEBthM5Psgu8whZtFn1lIjymbiRuH3LckNmv9qZnz5mY9oFEDMWsjDHB2EIfu1aI7Bo5/dq5Mqm4x6FJAdqGJZv8cl6juMom6FL6fqVnzKwRojWUULHFx0IQycj0vlUrjCDzpYu8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jG2hbTWgbvoLlf5/nQGW2VP+RZbf62sUjmmaaE7Znps=;
 b=Z0hQe/Z44F9KFv2mEEf80buelJZNL3eIGCGwzi2v7cs6rbzox1eR6mKDO6FMjb0wjHYDeIVr2jsYW0b1BYObEw3z/kuX1E0cftxs4WHAD63o5kKh2mUrVSQEF+Fq1aTJIDT2GUa8JeE6iUQ1gcDLlgwl3I144kEaKUji4PcIzH961dkw7wcN3/n4DvDFv9x7nQR22z2ybp3HIg7M8ANuP2hnolhPvDg68crX4ErCxpuLordhcbXiDqO+QC9q5MCLRxfW4A7/tcxXtK/s11XH6JHhNpucyvbYuUOBXV4m/QFAESKJ+PB1SheE5GCtiRwe15DjjbNYdGFrYj8xlotj3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Sun, 27 Oct
 2024 17:50:03 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8093.024; Sun, 27 Oct 2024
 17:50:03 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3] sched_ext: Introduce NUMA awareness to the default idle selection policy
Date: Sun, 27 Oct 2024 18:49:53 +0100
Message-ID: <20241027174953.49655-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::6) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6ee9e6-82fa-417b-1795-08dcf6afc910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v4BdBdojeJmXd2b1vDQJu4FWUZdU3szT7dmv4jV99ga1k+pXDk13pPGqTC5e?=
 =?us-ascii?Q?wHx7uojjDgEYFxmoHeZohyF/sMnerUnMp6qRzdx4/S8YQNiKq12YMZICEYdl?=
 =?us-ascii?Q?Ji2SCc3VYv2rYRF5iWXrEoyVuvZrfY4LW568vp4uhxZhFfkq654DY2gTOHE1?=
 =?us-ascii?Q?NE/PMZEICVzDO9/4lWHVdxczp3vL7WGf3cnWQ5mneeXzTQoNv8AqMwgEOmdT?=
 =?us-ascii?Q?T/w3vem5u/cbj0/u767MyACkJR32JhIk7AUisvC3U7Jp8dqYyQ5CIsryvOYw?=
 =?us-ascii?Q?VHrnvcyn62Y43X6d2f1Ze/b1YejLy1TwiNgRJzy3C9yeeibVUZRgL/CMZ+dq?=
 =?us-ascii?Q?bE9BvZ2FYXWTt12YtqyTtdHHdowDUCRW/Fzkval2ZRALrCPgECLxMk2E/6Hu?=
 =?us-ascii?Q?NRA75GxEOjOxUXmCHjsvB1jFcZvRLofxYC539PJatxpKFLZOmZTxTUdPRefB?=
 =?us-ascii?Q?f+ATYCWxsilMoHwfI+pDd81Nvprqpdxal/pdcOV6nlUt3z8hjXLeauzEgCuX?=
 =?us-ascii?Q?yBsxoxtKpwgzDoCYDfFrHMn9h1jNnuXn/TV4FhUq0Tn/Ck4qQ5muCzW0mpI/?=
 =?us-ascii?Q?9/7ahfnt8DTN3NVcjNN/2IZaAg+ESV96BUOb6jKLMCaZb5Ch7FLcMRNXV8xk?=
 =?us-ascii?Q?s3o9uEHg7ec2c517+2cMBMH9qcVvYgrvyIZuGLoUBmJBx7/BhCi0INdb7/xN?=
 =?us-ascii?Q?7I6yfdeLn9BeucNVnQTilT8xrcTEAwaBePFU/IiEMw0XTEV9HfVaZmUl7F0p?=
 =?us-ascii?Q?CAKocCS3HhATqEIIcCs6XuAFD5OCu9TPBWzhbmPHurtm35i6tzj8sW1XMHUs?=
 =?us-ascii?Q?aGFNwn295LKFEtS0l0xQIj8RJcl0Z1DFBIK683UiYTVdbJ/6BUm/FbB5oh26?=
 =?us-ascii?Q?fHIWQuTebLZaJPpfTN4V0dz5HMZooTsHtOH0NDXe4mi5KHrsobxataIPKVOy?=
 =?us-ascii?Q?c3+aYeUVau/gzDfo6Alt0vpLukndHzMm7TZZBuxrW2q60OUcpK5nVeD0vu0r?=
 =?us-ascii?Q?Qr57x6d9FQcJROdgy/FRrVS/hKAJRUebfYvuGwHdcRyBpN+CopRi+8PWfQmm?=
 =?us-ascii?Q?g5flPBh7QxeWK9P1V/QqI7cXKGe9qEOB1C2peuOuiiXPerHxLWoMrurBBCzz?=
 =?us-ascii?Q?6whHgVB2LO7Yc//3C9X8sUUECepquJCIfjj8och7RAF7oNAVmEEbD1zcxPOD?=
 =?us-ascii?Q?O8GrpPJ75VpAioWMS9APRyZmeu4xbyXbraetQkxr5HTdK2Qcr5RJRhkhUIFI?=
 =?us-ascii?Q?gn7lPi27lpBhLdFsAMBnLA5VfR1p03CyJHhzmrPv0gDAAmfI28CrUcsPF5HM?=
 =?us-ascii?Q?nRq7ybrUbJHlD4tMBDfWyuy+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8nKaNxNSi2+5OESwsRe/jCb/yiHeMMrLIg9r/Vbeyku8bGPLXYU0iszNFg+z?=
 =?us-ascii?Q?4XI3VmJVCIB8b6XLxgPDDFy1BXLerpGMbahtkSioA09wrg39ZXuiJ9TinrC0?=
 =?us-ascii?Q?jgTzUShxWG1ExzXk9HqPnYbttcIlneY5aAcMUd3WyeuYAIbcg0uSgNCXMg6P?=
 =?us-ascii?Q?zAL4pxEwGNgynoO1S132+5HB8se6dQtt5mwWCNoE0r8rn+upGaXEhFxzjCj/?=
 =?us-ascii?Q?qe/1xu9IOVLHRbl8onvtRw9Wa60UKAif5e14e9cA+AASK2EZbvbhaPie9cRD?=
 =?us-ascii?Q?q7V5IGD3NmJJsxsULJoeHVX/hEcG2BxFUcjcKZTFxOxXVWvzSFVc1PRN1R1f?=
 =?us-ascii?Q?uQeHdE6S8NIOmdkcnvkOuMOLkpH3DL78gIzpAiSoQ5E7WQfgSQZC00+AVe80?=
 =?us-ascii?Q?JIhUYNeryW1FMO8EuzSWX4y0c/R5/VFY0JdzB3zCdmAnDxtwIncIP0H+UWV+?=
 =?us-ascii?Q?YNLbThMgS6QZbbTuHJLPAu94z9UmRGYtqExdaACAP2yuyA6C4mPpJh42w01n?=
 =?us-ascii?Q?ccn07I6s/Uaeapx+BMwtBYV7cvgPppI7pjpd0IT6Q+wesETJKZUuIP9yDeE4?=
 =?us-ascii?Q?bE35k9NitlZq1tD+rAvJYFJy9UBpyLdIfYgBsXv+WN0MFLzPPEY9UiFPRZ+J?=
 =?us-ascii?Q?tzaof5Drb9u4KKpuwhEfDDfjBzqmh3xgcGGlyG2QnM9gbBQODlfRxJ/RRnZQ?=
 =?us-ascii?Q?G42TGOZ41PF+oWYNWOjMHq6aq3JGwFqBn17BRF0d4srndcQhGTXdD2Nq+aQN?=
 =?us-ascii?Q?M+sANULk9nz6PbAV9YmmtuOSIuundEj3EaEQZJmpBx/GxkZ20sGaITV6hqSM?=
 =?us-ascii?Q?wKXRKBTy8mwSm3eV2+BE0O2oFE0eACs/zzRe/sDwh8haVezgIWkr4/EOyGk3?=
 =?us-ascii?Q?djkkbCoX79SGzJm138uXse2ENv0qCt4qYTZxNQRdh8ZjFSXD2xJ1KGaBvlO7?=
 =?us-ascii?Q?e9tGmBYHaNya5j1Ilt+SDkrhrRf0QzBx5RO51p+WwNiSgjjszeEccy/Ig7a4?=
 =?us-ascii?Q?vXehwctwjPIxpANhtfw3Hg9h/cuP2BDbYdlHfZAlbvGjuTiUvh2G7qn4r7jd?=
 =?us-ascii?Q?pST2V9/tpCuopjlqf5Ki9FJjdhf1Z6yXlwLb4btzY7BOG9eqe2WK0r+DObfY?=
 =?us-ascii?Q?9VY8gRSDlzaVqP5Q+YUDRmFaxO9OtfJ7f520puD+jcvyGxQqxwPFBgCGi9iX?=
 =?us-ascii?Q?kqu5BI9jOtmFSY0XOWpXNjl9352QKGN+f81RrhhwS/Tcp25iuJTENswpqMqO?=
 =?us-ascii?Q?zeeRG+09Iibn81mW28e3cY8BgZVMHENlCAaWqd0rcdG/M/niqlGgb0fCFuvh?=
 =?us-ascii?Q?ng/Hy2DtY9XoElxBkCC+CRfwGRgferQdDKhbXNxBMYovSRbEUtDYO5WTtD/b?=
 =?us-ascii?Q?BJQMjLX9h2vz2xH2uOeiqoaP8ByQNMNOW1lvn32qEHZIOsCnCY/GSOTmBYkq?=
 =?us-ascii?Q?mU4wpjTPWbpywXUHj2sl8pp23a9Rqw2b5U6ZkQqi6Q1SQ1mDmLCqWw9Civ1Z?=
 =?us-ascii?Q?GNMEp9QUOJFYnVWuxbe3R1mSLwi6DatPlBkhJAM5hI8mu59hEuwB2WWXeL57?=
 =?us-ascii?Q?Avdb1z9o7QhuXKw1YpNak3tEtl2/98GizhqSqYf7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6ee9e6-82fa-417b-1795-08dcf6afc910
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 17:50:03.5057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uokhGR7Zvk1pHDwg3nM7MwVsU+9PFwSBJntPp7o+M0iubMOB3TySyZMXdV40qxfVZRX0b0KRMrrGxMtkx0cdZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266

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
 kernel/sched/ext.c | 139 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 120 insertions(+), 19 deletions(-)

ChangeLog v2 -> v3:
  - fix RCU locking
  - use highest_flag_domain() to determine the NUMA cpumasks
  - rely on num_possible_cpus() instead of nr_cpu_ids
  - update NUMA/LLC static_keys when an scx scheduler is loaded and on
    CPU hotplug events
  - rename static_keys to clarify that they are exclusively used by the
    built-in select_cpu

ChangeLog v1 -> v2:
  - autodetect at boot whether NUMA and LLC capabilities should be used
    and use static_keys to control their activation
  - rely on cpumask_of_node/cpu_to_node() to determine the NUMA domain

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6705c2e67c99..5be80b8ac4db 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -869,6 +869,8 @@ static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
+static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
+static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
 	{ [0 ... SCX_OPI_END-1] = STATIC_KEY_FALSE_INIT };
@@ -3124,31 +3126,79 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
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
+	s32 cpu;
 
-	/*
-	 * Return the LLC domain only if the task is allowed to run on all
-	 * CPUs.
-	 */
-	return p->nr_cpus_allowed == nr_cpu_ids ? llc_cpus : NULL;
-}
-#else /* CONFIG_SCHED_MC */
-static inline const struct cpumask *llc_domain(struct task_struct *p, s32 cpu)
-{
-	return NULL;
+	rcu_read_lock();
+	for_each_possible_cpu(cpu) {
+		struct sched_domain *sd;
+		const struct cpumask *cpus;
+
+		sd = rcu_dereference(per_cpu(sd_llc, cpu));
+		if (sd) {
+			cpus = sched_domain_span(sd);
+			pr_debug("sched_ext: LLC cpu%d: %*pbl\n",
+				 cpu, cpumask_pr_args(cpus));
+			if (cpumask_weight(cpus) < num_possible_cpus())
+				enable_llc = true;
+		}
+
+		sd = highest_flag_domain(cpu, SD_NUMA);
+		if (sd) {
+			cpus = sched_group_span(sd->groups);
+			pr_debug("sched_ext: NUMA cpu%d: %*pbl\n",
+				 cpu, cpumask_pr_args(cpus));
+			if (cpumask_weight(cpus) < num_possible_cpus())
+				enable_numa = true;
+		}
+	}
+	rcu_read_unlock();
+
+	pr_debug("sched_ext: LLC idle selection %s\n",
+		enable_llc ? "enabled" : "disabled");
+	pr_debug("sched_ext: NUMA idle selection %s\n",
+		enable_numa ? "enabled" : "disabled");
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
@@ -3156,7 +3206,8 @@ static inline const struct cpumask *llc_domain(struct task_struct *p, s32 cpu)
 static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			      u64 wake_flags, bool *found)
 {
-	const struct cpumask *llc_cpus = llc_domain(p, prev_cpu);
+	const struct cpumask *llc_cpus = NULL;
+	const struct cpumask *numa_cpus = NULL;
 	s32 cpu;
 
 	*found = false;
@@ -3166,6 +3217,30 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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
+		if (static_branch_unlikely(&scx_selcpu_topo_numa))
+			numa_cpus = cpumask_of_node(cpu_to_node(prev_cpu));
+
+		if (static_branch_unlikely(&scx_selcpu_topo_llc)) {
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
@@ -3226,6 +3301,15 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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
@@ -3251,6 +3335,15 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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
@@ -3383,6 +3476,10 @@ static void handle_hotplug(struct rq *rq, bool online)
 
 	atomic_long_inc(&scx_hotplug_seq);
 
+	if ((SCX_HAS_OP(cpu_online) || SCX_HAS_OP(cpu_offline)) &&
+	    static_branch_likely(&scx_builtin_idle_enabled))
+		update_selcpu_topology();
+
 	if (online && SCX_HAS_OP(cpu_online))
 		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
 	else if (!online && SCX_HAS_OP(cpu_offline))
@@ -5202,6 +5299,10 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			static_branch_enable_cpuslocked(&scx_has_op[i]);
 
 	check_hotplug_seq(ops);
+
+	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))
+		update_selcpu_topology();
+
 	cpus_read_unlock();
 
 	ret = validate_ops(ops);
-- 
2.47.0


