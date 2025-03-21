Return-Path: <linux-kernel+bounces-572040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7712CA6C5B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF903BB1A2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B99234970;
	Fri, 21 Mar 2025 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cHvN1eW2"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88F23312D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595313; cv=fail; b=pTHWgE9OyteMTLHynI1eiFCahNgpetZ+/Nml3Dcsd3NRqDUeRxmHL0DO5NgFm+dvQWBeQ4nnFUHPhJKPet9IDacp7JkQfD2oA+0KMWqCECj/BHFHsL79VtNrIWqSqEaaw5OoinA5wruVrJlIgYX50kKkaB/LRfA51/WMPNAuMYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595313; c=relaxed/simple;
	bh=NSb29VKtHCb/vS0h+MnmFLXur/jldxWXsAsSTcUkEi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NnbCl91r/zkiEDrN4EkX/CcaftmCvpU7kVSsH+X+CYyiba16EDqcNtmlLDHvzxSr3+5dGV2ubeW2pnzNbTWkCCMlMog0yj687Y/b+CHGkScYaGUi9FW3qDqYqdyGAwFpc5D0A5cQaR7OfyrnuHvqYLl6lkkD/BqxvI2mCYaXPuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cHvN1eW2; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhPU4S64B79uDZqw6IG2wFftj49n9cjf9KvIuCdtPimiH46HpxHLS+w9WEmnW4xVjejk8th9jsxrOJ1XXV4XlLFQgIxCfY1J7qAkjn/5FgbpvR7HBomIjAXiP1baM/AGwanni6kn9QmcqDoiSnsmd5sY6hymtT9057IJSavFBLt1SQ3NU1XXDgM+cyhrCoKLyaENUvL9uMA5O/lWmN1ZfP1eHDaY6F+YVF5n8v/F7JWT1/0RbpandlADA+1mTB16//s33H5lJkhJXTTI993jGsXxPANlsRaZoboCEavuEzRzVcqrXDZmepCE4ve7lTf8C3D0trozW0p1zn/W8/ovJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrbv0YDeFA5izAB4gj5YqFBx7+c5+vSquJWMqRlp6Lc=;
 b=W3Q3LepfzuTj+8wCz0m0YOvN61Gw1iChdzWqYAIDPEriv3jZpEalZmdnG+AtQ5QfGZ84TGUeZGAAvcbknOBuIwAkO7dZ/+aGxxtNYFYusVUkzgtvBCpkoMDZsBoZhZVUnAObEhd/Takj1fwPfraAvDaVdxk/hlOI3iJc7nSLwCImueOY8O8cnP66REzu9JwVSxamaAdfXOGrmVpm8yB7nZjxWjmTn8fk0biEY18K1Ji5sv8DDv/TSAFM9ETHZc+9jRsG4QKTSZZG+5ri+c13i4TCLqj7C9EcFiSNLqoZaPoqYSeq0wMJlcqrIKgukcLmhV3JxGtxnDgHI6Q84DZhsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrbv0YDeFA5izAB4gj5YqFBx7+c5+vSquJWMqRlp6Lc=;
 b=cHvN1eW23P+z5ik8uIzUcITpV/i7vmF4o0SAgi8Kkq/ALvuGadAMLpDllIEJ2s+IPrMGAq27wDaDvr9GePRJ6PjtDMaetUi963iGjHwROnGrbEzi+Ldt2nqQB0shsffroN8oFR/OrxRA8FdpQwyDD8eWxZRKD1hcivi8buQn/WnaUdl3Jq8QMkOCfm56380tDYco2vs7BoVwfh9CfEZyEy6ktvJPuvpdz90rCTZsdLfp77E6ZPT7oOhrzTIHfg17ZQstraSjm+71DTxQadRU+SfJcoYkNqDeNKY0Zn+AkbFohOpiQ5iE5tFs+Ue48TIRVzzalXkDEvksmegzBE1mUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 22:15:09 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:15:09 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] sched_ext: idle: Extend topology optimizations to all tasks
Date: Fri, 21 Mar 2025 23:10:47 +0100
Message-ID: <20250321221454.298202-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321221454.298202-1-arighi@nvidia.com>
References: <20250321221454.298202-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a75ffd-ac5e-4ed6-6099-08dd68c5d769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E9BCTGfBu8+Am/5QTNuOx97DocYdq2AP/5SGR7Ob4AuGX6s9+b5OYTAHYLip?=
 =?us-ascii?Q?zZ7qpHIj6RtAWzSmAyhmeB8AALJzuI+GQ0o18XdyoA7thDfXcduXDVyrufNu?=
 =?us-ascii?Q?SaDGsd8mvMI8iqfUhXWZBU4ucaVZ7whLLy3qAj+sGDOWYo9r+nqa0IhyCNPw?=
 =?us-ascii?Q?m4nX/heYPAHC3hp9nE4216I82qNI5B9PafV7nwMDVk2ov6uuoxW1gZjvL0tb?=
 =?us-ascii?Q?8mLgfyrDFALQk1oIFxk4vdtm+oMpeQ+kZYUP0EwOC/pMyzCcgkfuefORBLMa?=
 =?us-ascii?Q?rJBScr+aWEWX914opOoF0/k89R01M6BYgxsjhVYGPpY+jBiIM0CP5Y3mwiAV?=
 =?us-ascii?Q?/wcxV0ZAQyevQsEajw3SiYbiEqGe/VcgdBb+O+R9WfK2JS+/RejWSwipAn3+?=
 =?us-ascii?Q?be3pz9v2ldEc2TL/DnwL5luMeJB3WssRqVK+WcTVYB5Xp18iu+ZyC3mx5Rgp?=
 =?us-ascii?Q?oju1dC/qNTtHPVam67U7MOwRoWVubMc52Yv19lgDh8owW1w7ZxE1aEOAZrk0?=
 =?us-ascii?Q?LSP0bcmf7LCbyrsy+KSse5Jg92Hebdgp6siZSisKWZeGQJJSHYoyfYR7lsnr?=
 =?us-ascii?Q?JYtUQydX6DpOnuhABqFEdyKkzKFVnLpjbwzMbjUfO/SOEiYZRrufR/rNBLdb?=
 =?us-ascii?Q?8tRs5Q+yl+JwAsgChuX9G1Lop3icp51wcZ54TQi/O0FO4l7JdYuinMzhb6UN?=
 =?us-ascii?Q?CFTacct9xPIf20v04LuvZlYwGWeZRVTrNpWBF3zOQOkPcnwlJ7j7tuehWw6e?=
 =?us-ascii?Q?IfdbgS4sFkzZgBa/v/o/rhV9pNxNXt3K+1RhLG+ha3rMIPWVBcqtqkx8vZll?=
 =?us-ascii?Q?wzI3EYzM3sOpm6pzKmVGFP+zMd9D/ViJVhm2AShXKzJPt8GjG5JDvAXI0c3T?=
 =?us-ascii?Q?6eUPqCGIC84sP2WaYt/88mC7RjvDQ6iJMrIcOAPT/fCUnHn8oU3SZCHblNob?=
 =?us-ascii?Q?7d9LrO2Rca4NQMFepW+mAFJK9aIj/1Gm3PWCiNZwMtr+4MJYYFKSalxX814H?=
 =?us-ascii?Q?Q3LwjyDNQqA1zyWoyEBUKjBXtVMRMn2xx6/zHzpgLG1wExoM2dqzl/rrWqqZ?=
 =?us-ascii?Q?wkR4zGwV84J0fuq5uAAjcYrGNoFRC6rq4e7BNBwTftk9nbVv6ewAEw3ai2k8?=
 =?us-ascii?Q?5owjFgnK5NdNLq0bhMLLYOPcwOn1r7pJc4Y6FUtDFhWcAF/Jgp0wl1VAH0jv?=
 =?us-ascii?Q?ODLYhOhWPgqkxolHo2gZf7yWUAWcUvxkjvDxWAgMKiJLLj1C71er6Nig9kD5?=
 =?us-ascii?Q?P5IQJt+kWHUfgxuuSMdzopqpov7/IdN/SLyZWRDky3eJHfVVTYMJto+59uY9?=
 =?us-ascii?Q?F4G9XYWQZpTHMxGTzBAVePQ/sWAgF6Wpe5UYAnt7qFdlrXTMfaXV70pt3qDp?=
 =?us-ascii?Q?lGsK6KKfQnGU6yF5C/OHGz2YRogKnc5YfdI4u54YHU3qeFAfNpZTU3jVBw7D?=
 =?us-ascii?Q?7IGKc85x+pQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ldceYZHTdmIGbMXv7WYPUdOkVbgtkRlpNHPL67nw1R9iA/A+2xYcB/gr3Zjf?=
 =?us-ascii?Q?aLiMsvBJnoPGmIL2UvDa4h2QUwETjI2zSEtN2polCZ3H0buXlZid3z7x3xA1?=
 =?us-ascii?Q?h7++w0Qa0+XN+T2p1kFOfRNB7RNuARr6n9fR7wYoMTXzGBpQtr1K+X4PNJZ7?=
 =?us-ascii?Q?yBDc5nALHGD6hPaHqvnBC450WXuMnLei1AJ2h7M2XidS55yydXZdkqpNYKFc?=
 =?us-ascii?Q?mf915osi2vUqxVR9OCqRSnMRflCIn0etMjQ6/hABSSY+GoYiGt6Ph4bCOwZF?=
 =?us-ascii?Q?fc+0nS4C2Sm9o2g9xD2lnl34GVbsGnjEQo2wZZrKKqEqXvz/mhWQ2gK7DgqE?=
 =?us-ascii?Q?wyvhIxhumjcgvIFLVR25wJuUSs7DNJ2JOXwRSCjs37gRL9IIvbx6fvCZ9Axs?=
 =?us-ascii?Q?ZpFpkzqbTgrh880X8S1ww8mQPU5xY9LtuoB5nKwfmOl9DJHhtzrnTGRDwY3n?=
 =?us-ascii?Q?OScf6jFxtfcEoaSCtuikZZyrOQH3IZz2Nlnpu0jINt/iwF+kQNv/6ZpHqUpO?=
 =?us-ascii?Q?MaBju4pdxrmu1frnDwqMGPvw37SQe1JsQEa8h+HEfQffmhn40nbUrVGDO9Uq?=
 =?us-ascii?Q?yCc46BXYCJyOytkBCX/C39p85DbhlzYxEYpjdxH9o+0kv76kcbOBQhd3RC4H?=
 =?us-ascii?Q?X3kt0/MPBvbpLjy6kG0M644NobXSurPN1oECMMt+/YygHgdDyue4bsJOivyQ?=
 =?us-ascii?Q?AyM1tEGrHcMwY2HSNkxt1upKwG+QQsw3gd6GMBTHC63++rZ0oI5+UPXWmrvg?=
 =?us-ascii?Q?b0EGXofE+qMP2hp/xApECnXKKv8mCC2eMbPOMfnSR4L1+3kENrwzNDSMbDzU?=
 =?us-ascii?Q?9XhCfGy6aFnYuAnPNWrMsJVxZG3akd8sKkfmTgqkue311ufLc9UnL2b+GpgO?=
 =?us-ascii?Q?c6yub1ghgIzYTEBo/x07A4f+nhGaTvg1LIAEFhaMuTM+hU/YdtdMHLkV7ltV?=
 =?us-ascii?Q?U6diRZPjgVZEZ6ikp+W8/K1oJ2bae9t1JkYhq/GIH/pMOoS8uXSiSFuVRVk6?=
 =?us-ascii?Q?6MHntp21JnGFyqJ4yt1jdjHmyDIYWcobV8iqCTFI0zjFer5NMSMPgpqbnisi?=
 =?us-ascii?Q?5f6Jfo+Zh0Q8g39vVYWxJtBe3nhPuuvYve7RK8Mmr8fcW6k3liug5G+Hl6jG?=
 =?us-ascii?Q?SQUpypOuRBR7fTFHpY0wwTHJu375TVb+/ryIxvY7+d8I+p3fguGg3RWOfbiL?=
 =?us-ascii?Q?HVF8+FLOZeA8uXnBDwOfvblZIM4xSxvDf+BowpWKOOFt+IBeoSI2Yb3xWmzD?=
 =?us-ascii?Q?O23bDThy1u+k6pt+GQmIK0GU9seRb5m24esmDx0IXjKNoRFpdgNydY60ox6i?=
 =?us-ascii?Q?LFu4xzZf5MOs5Gd+tencDCt8XgaLT3nltvuwqAdBaa2ekGnw1Bp+TRbjSOvq?=
 =?us-ascii?Q?T6UqKh7kqwj6DrVA+tLgByO8SHYSNgGxjhJHXazKYACOgje2ij7KuAmCJUl1?=
 =?us-ascii?Q?7cvmd1aJ6PDLhe4QBowJHnzZu9rh50NL4MR+dglCL9ZTJ4U9r1UHYDTYI3mX?=
 =?us-ascii?Q?E35v47PSNFRYzFIfouxL9Ua3RFMxxULE4lCvTLsLQyv5okMv0JntbK2wdYRy?=
 =?us-ascii?Q?5anbXuGpVHgTzRM3nxT7jzr048fugHw/EYluXlJQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a75ffd-ac5e-4ed6-6099-08dd68c5d769
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 22:15:08.9554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kn/LlQzQKyFdeaB3JfQHdqfKY8y9hjqJsVD2mAuMk/kSjpWimEt5oMdXjlmrnDd2OOnprpdN8oGCuIxlbeBRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

The built-in idle selection policy, scx_select_cpu_dfl(), always
prioritizes picking idle CPUs within the same LLC or NUMA node, but
these optimizations are currently applied only when a task has no CPU
affinity constraints.

This is done primarily for efficiency, as it avoids the overhead of
updating a cpumask every time we need to select an idle CPU (which can
be costly in large SMP systems).

However, this approach limits the effectiveness of the built-in idle
policy and results in inconsistent behavior, as affinity-restricted
tasks don't benefit from topology-aware optimizations.

To address this, modify the policy to apply LLC and NUMA-aware
optimizations even when a task is constrained to a subset of CPUs.

We can still avoid updating the cpumasks by checking if the subset of
LLC and node CPUs are contained in the subset of allowed CPUs usable by
the task (which is true in most of the cases - for tasks that don't have
affinity constratints).

Moreover, use temporary local per-CPU cpumasks to determine the LLC and
node subsets, minimizing potential overhead even on large SMP systems.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 72 ++++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 52c36a70a3d04..9c36f7719fcf9 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -46,6 +46,12 @@ static struct scx_idle_cpus scx_idle_global_masks;
  */
 static struct scx_idle_cpus **scx_idle_node_masks;
 
+/*
+ * Local per-CPU cpumasks (used to generate temporary idle cpumasks).
+ */
+static DEFINE_PER_CPU(cpumask_var_t, local_llc_idle_cpumask);
+static DEFINE_PER_CPU(cpumask_var_t, local_numa_idle_cpumask);
+
 /*
  * Return the idle masks associated to a target @node.
  *
@@ -391,6 +397,14 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
 }
 
+/*
+ * Return true if @p can run on all possible CPUs, false otherwise.
+ */
+static inline bool task_affinity_all(const struct task_struct *p)
+{
+	return p->nr_cpus_allowed >= num_possible_cpus();
+}
+
 /*
  * Built-in CPU idle selection policy:
  *
@@ -426,8 +440,7 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
  */
 s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
 {
-	const struct cpumask *llc_cpus = NULL;
-	const struct cpumask *numa_cpus = NULL;
+	const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
 	int node = scx_cpu_node_if_enabled(prev_cpu);
 	s32 cpu;
 
@@ -437,22 +450,27 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	rcu_read_lock();
 
 	/*
-	 * Determine the scheduling domain only if the task is allowed to run
-	 * on all CPUs.
-	 *
-	 * This is done primarily for efficiency, as it avoids the overhead of
-	 * updating a cpumask every time we need to select an idle CPU (which
-	 * can be costly in large SMP systems), but it also aligns logically:
-	 * if a task's scheduling domain is restricted by user-space (through
-	 * CPU affinity), the task will simply use the flat scheduling domain
-	 * defined by user-space.
+	 * Determine the subset of CPUs that the task can use in its
+	 * current LLC and node.
 	 */
-	if (p->nr_cpus_allowed >= num_possible_cpus()) {
-		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-			numa_cpus = numa_span(prev_cpu);
+	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
+		struct cpumask *local_cpus = this_cpu_cpumask_var_ptr(local_numa_idle_cpumask);
+		const struct cpumask *cpus = numa_span(prev_cpu);
+
+		if (task_affinity_all(p))
+			numa_cpus = cpus;
+		else if (cpus && cpumask_and(local_cpus, p->cpus_ptr, cpus))
+			numa_cpus = local_cpus;
+	}
 
-		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
-			llc_cpus = llc_span(prev_cpu);
+	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
+		struct cpumask *local_cpus = this_cpu_cpumask_var_ptr(local_llc_idle_cpumask);
+		const struct cpumask *cpus = llc_span(prev_cpu);
+
+		if (task_affinity_all(p))
+			llc_cpus = cpus;
+		else if (cpus && cpumask_and(local_cpus, p->cpus_ptr, cpus))
+			llc_cpus = local_cpus;
 	}
 
 	/*
@@ -598,7 +616,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
  */
 void scx_idle_init_masks(void)
 {
-	int node;
+	int i;
 
 	/* Allocate global idle cpumasks */
 	BUG_ON(!alloc_cpumask_var(&scx_idle_global_masks.cpu, GFP_KERNEL));
@@ -609,13 +627,21 @@ void scx_idle_init_masks(void)
 				      sizeof(*scx_idle_node_masks), GFP_KERNEL);
 	BUG_ON(!scx_idle_node_masks);
 
-	for_each_node(node) {
-		scx_idle_node_masks[node] = kzalloc_node(sizeof(**scx_idle_node_masks),
-							 GFP_KERNEL, node);
-		BUG_ON(!scx_idle_node_masks[node]);
+	for_each_node(i) {
+		scx_idle_node_masks[i] = kzalloc_node(sizeof(**scx_idle_node_masks),
+							 GFP_KERNEL, i);
+		BUG_ON(!scx_idle_node_masks[i]);
+
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[i]->cpu, GFP_KERNEL, i));
+		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[i]->smt, GFP_KERNEL, i));
+	}
 
-		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->cpu, GFP_KERNEL, node));
-		BUG_ON(!alloc_cpumask_var_node(&scx_idle_node_masks[node]->smt, GFP_KERNEL, node));
+	/* Allocate local per-cpu idle cpumasks */
+	for_each_possible_cpu(i) {
+		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_llc_idle_cpumask, i),
+					       GFP_KERNEL, cpu_to_node(i)));
+		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_numa_idle_cpumask, i),
+					       GFP_KERNEL, cpu_to_node(i)));
 	}
 }
 
-- 
2.48.1


