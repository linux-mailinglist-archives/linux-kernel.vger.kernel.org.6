Return-Path: <linux-kernel+bounces-434006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C3D9E6011
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35FD1884D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AFF1CDFD5;
	Thu,  5 Dec 2024 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HzSBKp11"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3D1CCEF8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434026; cv=fail; b=osmoTzI7R1izGNns/rfH8VqtzpMNgZjBdGYAY7f68kTuBvcwnjluBnUDa6vvpPUOwwR4/ewcIddgeALtz8jFkYFauvUBqcIlxPnCOdujRuK61M6bmjImAbmuH6TbVc3vssl4Apx4TRouCM+42CbnoGrqjftb0Sk+GugnM5n7GvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434026; c=relaxed/simple;
	bh=d5L9oIdilgWsqtdxYJjHek4j1u1/z2FXtQnxqM2vrBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iiWK80Roklq6wzAtyl1ntBIkelN3X0LaANycWY96T4zixRiI/jYlXcHk0Q+61hO/4r9nEfCXG9kGb0urb3XPo4v8nMTxYQ0eP/EnssCNNyDP9mItadjk6u74zKfM5MKlT2R/laPONH55076g/Y/c5yRQ/oLQ4luK4K+KXbox6Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HzSBKp11; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EY4aiuLc744j6QW2Ze3yR8f8s4fnjaszAOOiTFy2il3sFCqQmo4+3nFZcJZzy4xuTYqbGxqaB1+AVnZfsosziLmMEajyD0UZ1nOMX8Ud4J60DX3OPJrN6czwIBip2kexXVNa/xu+NqCAxbvPtS2oRT2QwKdlhAK39+Z0arGV35fln2jOIpkbZkQJb/M2ftCa1ysGSBlzR5PBgmkF16RiQXuSBmigRFKkfXNG3cWrlPdUPkx0Pn72d8gWV+dL7/j0mZKOMAiNq+abMZisLMT0nMaFBRwN5uTjxHfaudAU+ks9uO/pcaEchcLX/AndMO+gT+UqqgPaKP8ybsCDBLwTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eP/66Z8+jmKB1OHVKVYqg68Ru+uaOLXrFtc4Fb6plc=;
 b=e7v5LQeBgk8eUgeM43lSI4KslMAu/9MV+aO6hsYiYWdANrdErH1o20qPzwFbaeUwNXpXWUTXqsbMn365leoxHVDwmPX/Vz30rmqYE8jXw80AWm42XIde1jvhzbNGSh/+NDzrIPJXqZDC8dv8xs8TvjmeaGbAJVOfH08ZI/2WxNEYmrRB3HlbPJqjdiIjOazuNRnavmySQx26cGz5tjaPSS2P5LvSiYm1DFidW3VE9EdZ3yTB35zECXtwhGgFbGzccyuiEMf0etHv1pqCLjyR7hHAh6dahDyJTugYyxgGKmXb4BUU5aQ9jSYMV4uwuTD7rZborNLTlanjqGU5KSUtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eP/66Z8+jmKB1OHVKVYqg68Ru+uaOLXrFtc4Fb6plc=;
 b=HzSBKp115MZX6B5aCTGUSbySsVwApX+3MXFvuWZokE/dHhH+qFH5nsvn5oEu83U3ct5iAvJRHbZfuElR6EKCD2redXf6S8JX+gJGGZTRztDNaLCP7e70mwFEyANKCd6cVbhy6WdniTMIHhdGbSmMwDJfviHPnPAcMdxXtM13utIeGyRyC1z73sUgX/fInJFuavrQ4Ricbi0wUakpVWFt066w+0ZWtwlki5ailjdrjt5H0zyR4e+XHhe5o9iDAe7ugG3rF480r7HTjbAXlPAi/D892mwjgNmqo/N2sIsYqHv+KyJrwUXccV0PXxIn2lHvoX5NVvJqJ1fOU1HOlRT8eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 21:27:02 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 21:27:02 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] sched_ext: Introduce SCX_OPS_NODE_BUILTIN_IDLE
Date: Thu,  5 Dec 2024 22:00:25 +0100
Message-ID: <20241205212627.193016-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205212627.193016-1-arighi@nvidia.com>
References: <20241205212627.193016-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 87dcec34-aae0-4fa1-613a-08dd15738ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IFln7ezxyZ064EL90/ZLG0PVR63C1uG0cM16aGtJTcAYZqk6sDTDR3pgRP+r?=
 =?us-ascii?Q?tlncvhz3jPffqMcbzARqdoBmHxmBd1Hk/3IvUCtshTm+yMN3SwEkk6hR++PB?=
 =?us-ascii?Q?hVbBNd06Uv3phJ7dY5kMeEQGb/lc/RxCbRTZ207K0CWAPtzg5WOpXHKsac6f?=
 =?us-ascii?Q?5eAwRBIREuWcXuo2A3Vw5250PxpFki2+f9/UmQi0q8XJKXz3cz9iW4SFJgvv?=
 =?us-ascii?Q?34b9oIaN61fCHpP20uLXLUhbafsrYfzgdqMnD6VNoUfxpYdLz8cIYF89H3jc?=
 =?us-ascii?Q?f/+F7NUhvoRZONhw8WVxIKdT1lpk0Pz57rUpRYhfDlObXjm32crvzAU+d6Ek?=
 =?us-ascii?Q?AgD3PNmtdYyRWlJsbPiHCo8JDDueRjIXAWCOiSub6a+DDQGOoIqIoxtZMmY1?=
 =?us-ascii?Q?GgmuG7qkaHHjQktG6cOi8QdrVmKY3yzMEZupBZzs/P9rd+EAgsZZSjHRxvNT?=
 =?us-ascii?Q?qbbmqRU0xrVQpBfN1CyOnoXLWyR+DzIig80JR/9Dn3gqnSuOAEweN5F223GD?=
 =?us-ascii?Q?xSQLFTHaxX08xVTqaRP4f9sRH6XK5Kh4K4suTNBAMPuz34gA5f/JUqGMYHTM?=
 =?us-ascii?Q?okoPDBqkuVNOne2I0Noea0lDa8gvI6cHjBEE+MOVzjZDjNHVno1llvJUP8m3?=
 =?us-ascii?Q?nGybTh8oFULftcWS9qSokeHfiWDJU3FKqB2RUqUvn2TYyBI5zIMYn7kNVmwQ?=
 =?us-ascii?Q?9MDykPs6S6V8u8GCKvZRBNLTsSoZQIdV5Msq7lHyf4foGfRY2xYOQRsVfCxR?=
 =?us-ascii?Q?t0sk7w+WudTh8sQM5S/nW2vYzy5bK6/Ja2sgXwZHQzujNOpsyj2iwH5SDhU0?=
 =?us-ascii?Q?reMqmdKVW/PF561i9PqpI4SeYxScDm/XRQbT1nZ7Y9IoQeIuQejFiVTjClY7?=
 =?us-ascii?Q?t/bGpgX29PKTy3CCBERF4m5/d5wG1gk07E+6bwMIJdSqhc4VBYlWNeFALYk7?=
 =?us-ascii?Q?f50fnARQrO95xDO9nMHRON4sQcOQAc0S+o2WoVc7wi3ZyvYa1C3ZwOKpOeDV?=
 =?us-ascii?Q?Vr/77RxIvNq5rBs0jTE/zdoU3u93BA6bVt47ABqAjiFenDwNLy/cJVbf6H+3?=
 =?us-ascii?Q?fe0MU/lEBjAeIpzCkREx8q6sq+gj2sycyYKY825R8T3FnSR0YDV78uSzr3LL?=
 =?us-ascii?Q?JEJl/FYOP8aCjkFvs4wbtZ9wCAHkZU37FDV3usO5UwkQlZowCa61n//TXcVu?=
 =?us-ascii?Q?byZORbVhDgS+NYzaxfGK1kGVNkGWiUM/w9/lxac/LHevtWAl0J5/lGoY9VFH?=
 =?us-ascii?Q?gfD0CRLE4KEasb4l5GEcSlWcnZO2M4yiVAa7+rjMOKuxsDZc3mPdT/lhalDD?=
 =?us-ascii?Q?zv5quz3lUadE9OLnqV4iWC50/5ZbLnDuL8Nu36HvtGGLCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/XF1ngwb3fccZM6DwXrh0pGmHajyes0XFGNIiR1fgWSSE+ZLqUciAKrKoIev?=
 =?us-ascii?Q?tWpvZ9D2JZZcnqDT/07+dGDXQCzlfS3779EVzhV6A9LLVjZUXq/1QoCZdPkc?=
 =?us-ascii?Q?CARn4wHkbEjaj28CRLWHn7v6cwfzaY0tpHxFLpf/OOO0St7Neu5dlYqeJaIK?=
 =?us-ascii?Q?ufeuJO/8MeK3YUP8dgRMd955uZfb7jFO/YULwSdGuzocJjgXkba4N0oRCVxV?=
 =?us-ascii?Q?jUOrUaGI/Q1P7Rzqh+3Vt/cGkeHWDiTSocVmfZKQEa9crd0owiqlsiNw9fqh?=
 =?us-ascii?Q?venEBmp5bGUuixvBDJYyAEjhWq62+jqfF/qaxIjEVeG51ORcRMFyxUgCeWdr?=
 =?us-ascii?Q?VWBtWOMyHyNNm+yTwpDKm75IknTaRqw+QePwutWsCkgZk6a9m1ODsqUNuSex?=
 =?us-ascii?Q?0gHWIu4fYd/MxffB2h33jsi0wYPcPwQxO+/BpmqKo6ZAU4Jn8gmVxS6ZGeyb?=
 =?us-ascii?Q?GrnoB9SYjyjrYqlaOGOOxiIB3V37XdY5VJi5Rb17hB5M3Xp3guhlb/HhY5o1?=
 =?us-ascii?Q?7l/Dq4vlOpyNHA7u3dNPc+T5fd/JcYoRHAjPgGvs82zIQL33UdB/uRZZKMyy?=
 =?us-ascii?Q?uVgNk9OXwe+Wtfr7/GX5DMCla5+ac5mfnxunGmCENZQL7mGwjptnIGWUT2Z+?=
 =?us-ascii?Q?MNsA4BSs08e2hIj+5f4fhlcFeeitivHWA2ITtucz1P1CeemH4KW7n/rmCwBh?=
 =?us-ascii?Q?ymswCSUAmijIeg0LfUeygYj/m7w09Xqcxq80RUiRO1nn0k0Hn53XOS4R8Czk?=
 =?us-ascii?Q?PnqyNaEjbZe0PLG1DsdGQ7HUOpPf8wKelthE2OKfQdu128RNsXFY5tnPsdMn?=
 =?us-ascii?Q?g0APfiC5tWdnfufSgIMH2+mWgF4ZKoP1e3sI9pwFVqq7LiT6rW0MzNlgsCLb?=
 =?us-ascii?Q?KNb5nhXchwWWt+08SDZx4WrIrHGecmI86IlFI49Vg7tdSBcERb4jL7HRaFvG?=
 =?us-ascii?Q?I5CxL5VkRCat5tfdjmxQTSllDiNck9wXS3sEAhft8r8qmd77RYDf6h7HEl60?=
 =?us-ascii?Q?2PXB78SVLENEPKd48VvniPxnKioJ20DSKf5BeGQh7NW0SbCA1j4M5/9KEWgC?=
 =?us-ascii?Q?hjyiFuU24IscqrHmTeMYyiHK8NwT2pq7Q848ePf3ofZRz+WZU4a9Xf3HktI2?=
 =?us-ascii?Q?LgKT8yR3HzXh3GLE8RZ1dMdGbaNpdMPqGFSHBKN6HERDlTSLqtuGF83cYToY?=
 =?us-ascii?Q?pKXAYJePLVqc8+ztg2q2YocVr2wp6INTcG+7K41sJN603jwGaa7eU7ZnrCeV?=
 =?us-ascii?Q?gbNeic8R2NRJ5YaZ7JgaOx7/neb7AUuJvxV+2y/lxqJraZo0KESXGRz8lUB9?=
 =?us-ascii?Q?EDctOf5ZzDKNchZOfeM/vNv0j83H9gWr8u7VekOWoGo2aZ6eXqpIZTIEn1dh?=
 =?us-ascii?Q?zev5WqpVQmhJvXvbxoH8LvuXwg8QBOvTCs2W/goVi7keQsPwkYEH0scSM2hL?=
 =?us-ascii?Q?inPAg4VC209twEvIeF5ikDad+bOInLp3idttZckuJfrPwIUzlpEwuwjhOpBV?=
 =?us-ascii?Q?b20i2EYihY7XdnxC65pgvenrAfCnYD5uU+U3/wjMitLRIal/Q33vQ6WH8Nsc?=
 =?us-ascii?Q?3LQzWP6MPAPHRKR9WIKY3FneW9SpK9iWJ+66fFYp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87dcec34-aae0-4fa1-613a-08dd15738ee2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:27:02.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRFFqT8dN0MinirIg1YVVxhnOhUesVoBI5DwFF/5WB0zskccCXcA5D10+XByOfgHwpqyqWkShSaOOZ3//e8P2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741

Add a flag (SCX_OPS_NODE_BUILTIN_IDLE) to toggle between a global flat
idle cpumask and multiple per-node CPU masks.

This allows each sched_ext scheduler to choose between the new or old
model, preserving backward compatibility and preventing disruptions to
existing behavior.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 56 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ed2f0d13915c..d0d57323bcfc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -122,6 +122,12 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_SWITCH_PARTIAL	= 1LLU << 3,
 
+	/*
+	 * If set, enable per-node idle cpumasks. If clear, use a single global
+	 * flat idle cpumask.
+	 */
+	SCX_OPS_BUILTIN_IDLE_PER_NODE = 1LLU << 4,
+
 	/*
 	 * CPU cgroup support flags
 	 */
@@ -131,6 +137,7 @@ enum scx_ops_flags {
 				  SCX_OPS_ENQ_LAST |
 				  SCX_OPS_ENQ_EXITING |
 				  SCX_OPS_SWITCH_PARTIAL |
+				  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 				  SCX_OPS_HAS_CGROUP_WEIGHT,
 };
 
@@ -886,6 +893,7 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 #ifdef CONFIG_SMP
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
 #endif
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
@@ -929,18 +937,32 @@ static struct delayed_work scx_watchdog_work;
 #define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
 #endif
 
-static struct {
+struct idle_cpumask {
 	cpumask_var_t cpu;
 	cpumask_var_t smt;
-} **idle_masks CL_ALIGNED_IF_ONSTACK;
+};
+
+/*
+ * cpumasks to track idle CPUs within each NUMA node.
+ *
+ * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not specified, a single flat cpumask
+ * from node 0 is used to track all idle CPUs system-wide.
+ */
+static struct idle_cpumask **idle_masks CL_ALIGNED_IF_ONSTACK;
 
 static struct cpumask *get_idle_cpumask_node(int node)
 {
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return idle_masks[0]->cpu;
+
 	return idle_masks[node]->cpu;
 }
 
 static struct cpumask *get_idle_smtmask_node(int node)
 {
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return idle_masks[0]->smt;
+
 	return idle_masks[node]->smt;
 }
 
@@ -3423,7 +3445,7 @@ static bool llc_numa_mismatch(void)
  * CPU belongs to a single LLC domain, and that each LLC domain is entirely
  * contained within a single NUMA node.
  */
-static void update_selcpu_topology(void)
+static void update_selcpu_topology(struct sched_ext_ops *ops)
 {
 	bool enable_llc = false;
 	unsigned int nr_cpus;
@@ -3442,8 +3464,16 @@ static void update_selcpu_topology(void)
 	rcu_read_lock();
 	nr_cpus = llc_weight(cpu);
 	if (nr_cpus > 0) {
-		if ((nr_cpus < num_online_cpus()) && llc_numa_mismatch())
+		if (nr_cpus < num_online_cpus())
 			enable_llc = true;
+		/*
+		 * No need to enable LLC optimization if the LLC domains are
+		 * perfectly overlapping with the NUMA domains when per-node
+		 * cpumasks are enabled.
+		 */
+		if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
+		    !llc_numa_mismatch())
+			enable_llc = false;
 		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
 			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
 	}
@@ -3456,6 +3486,14 @@ static void update_selcpu_topology(void)
 		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
 	else
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
+
+	/*
+	 * Check if we need to enable per-node cpumasks.
+	 */
+	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
+		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
+	else
+		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
 }
 
 /*
@@ -3683,6 +3721,12 @@ static void reset_idle_masks(void)
 {
 	int node;
 
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
+		cpumask_copy(get_idle_cpumask_node(0), cpu_online_mask);
+		cpumask_copy(get_idle_smtmask_node(0), cpu_online_mask);
+		return;
+	}
+
 	/*
 	 * Consider all online cpus idle. Should converge to the actual state
 	 * quickly.
@@ -3740,7 +3784,7 @@ static void handle_hotplug(struct rq *rq, bool online)
 	atomic_long_inc(&scx_hotplug_seq);
 
 	if (scx_enabled())
-		update_selcpu_topology();
+		update_selcpu_topology(&scx_ops);
 
 	if (online && SCX_HAS_OP(cpu_online))
 		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
@@ -5618,7 +5662,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	check_hotplug_seq(ops);
 #ifdef CONFIG_SMP
-	update_selcpu_topology();
+	update_selcpu_topology(ops);
 #endif
 	cpus_read_unlock();
 
-- 
2.47.1


