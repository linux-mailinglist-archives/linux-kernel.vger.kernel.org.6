Return-Path: <linux-kernel+bounces-384831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12D59B2EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108661C21386
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857741D5ACF;
	Mon, 28 Oct 2024 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cMKkUj/s"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A91D3648
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115229; cv=fail; b=nAwHIVOT889X1brKqZQjDpJlOLji08MGFXX8cZaimXv/2aWAODnRqnx9oROw4sox47YaGviLngXaMFHftXCnQyK67S6MpnpqmMc7bxh6JX3UsxBWOlyvfnsxkmE6/ypEvLXV22nUdVm9kulk5aLgEA78JSCNioULrCcnE6oX0V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115229; c=relaxed/simple;
	bh=md8kIIc0NbGfcXDFQZ3dHT/J8ExcKugOSioqmzPl4S8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ufW10ioxjYUV+dthyFuIwJx0NiI/s0UkqWypJUdaVLE6md7VSE/1h/o/YAj6GwMA0SLPw0coXNlD6AqccvxYTwoXOl1AbgVdnKbsdGkrhPll2E0+KURaZ9E5hO6Z1fddpRPNkmWbVE3OSbZByDuEqpa91Mq9cLiiCrC1QMPun2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cMKkUj/s; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmZ2tVvYHhlzwRDKk52ATPT1HD6hOnBM6PdLyqre72gBaqcLJHVTINxajmqYcOsvQnp8dv5efeSuHJVEjC2LXiF2h5HJH/IKcAA9+XZz4FwntBz4kaZF/DqVP8W0C4cOU9YnBJn3lAJQ4/1oRacl5gPbfrnG+D0vNrnpUqUvDBH84zGnckBZhe56cNF39Q5jen93du/lPR+g8TzuVSjq3C22309RAacj9TlLdgppD5NH12Bu1u3QqDRj/ZFrrk4zHwB2k+OgqXClOyNzDdnbzARIx4vnoPekSDmsZg8XZpW9pCSsgkqCDglZ+eKX1XoD/d3zZ0FtPqdXP1L/I+t8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLJdF0e+sd2FRxAVsA+1PwseCmf3r9jHDySqHkPvuDM=;
 b=Rt4C1UJ1+4iePB6M+qL55D23dU0SBiQpe94HbSxOpHE/qvRdd0BozAfWwGZss3PQXq+6ZtmZC70BGFWFzRpQMhQe+JGGF+0AhrkEyEIhjITZXKQ8ZFA9QKqxeERXE/NqeZOLSeM04+QK2RxdhQqB6DyRfCzC1Vw9nLFEIHM5ObcKtIIUb3WFxGdE1o5KORQl5Q4EEmldi2+btfTaWkdLwcveTg3DtHUzB21AaCJp06qq4ozdVimURiLW97xx/CF7iae/VmvdVP8k3ltcqKK15f46xoIbdY82zZed1Lc2dtp9w7kDlfYhIBfV6P9MD8e7pIPM/BRRPfoS2l5pNAtNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLJdF0e+sd2FRxAVsA+1PwseCmf3r9jHDySqHkPvuDM=;
 b=cMKkUj/sQmbgI+OMg7hNNSp3YNG7eAnqSe4NajeD1KL47vcn+T4TuZGhywsyx3HPC9YR1qL3nrBo/mojjmixvVnf09Kagq4EC6vB967JyuOAmQYErHyswsiLF0iRQJpYX692gOl0aVauoT5ollagSMHPZ5gK+SrdOoZHKsdhaWMtu60AtVXe1y1gU51PEhcC96/Bpc1lI8pAEQj/XPmr9q6/TrcjPQ2fJ1Hf398bjvfe5d9eEA0eUBuE+NG7yyvd0nvc1eoxKp01p/gxqRtYxdfnnrKRpAKuXmnyvMDgb5wvJEF7jBnEavChof1WEcVn2VKrw7w2e7TpuqX1Hq3/yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 11:33:43 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 11:33:43 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v4] sched_ext: Introduce NUMA awareness to the default idle selection policy
Date: Mon, 28 Oct 2024 12:33:38 +0100
Message-ID: <20241028113338.85525-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a732f6-5df0-4c8b-7766-08dcf74460aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B/nmZRj/eF131WoNR2PZtOuSq4ls5GhDE5xXUaJkkCa+byPE5xPjHi4uQJQ7?=
 =?us-ascii?Q?sxd9jxXyYEQq71H5tRzIgvb3De4AflbapwYs+0NrJDim72dwUQbKtMczI+h6?=
 =?us-ascii?Q?mrf+klxyzHQAXIMDPwvo1HwOoJkgkjEptQH0tfxI0bMCi7juNmxy+QyriTwZ?=
 =?us-ascii?Q?P+oSDv16OIYnfHH5LKYjul+FDF6DxfwotYC8C62/Qd1h/+pQjYU+0a85QcjG?=
 =?us-ascii?Q?ikwTYNZjWjP4dSvOGpvxfWGFhOTV6JsTJMlwt8n2ly82IHXMrkvxkD1LE5Qb?=
 =?us-ascii?Q?CHdcAwv3tmAG/cvXPJpKDk46MZ4AHHcTzFc9HtKhOIlVfckbLNtAE6HFi2om?=
 =?us-ascii?Q?ALwlUXi9Msu2qszNcvv8uDqTo/8hg5L89H4BkzW1r8NixStvp678eUqYkHxi?=
 =?us-ascii?Q?3JBZgZVE7vVpz1LEpAY7QZFsv2L64KscVZEH/XcSbf0s8PDxlPH4z3LJrNSh?=
 =?us-ascii?Q?NMOrTLyNc6jO1cifbjbAaQBRMdcIzi5a2O6PLPSAjzGo1zQlVnr6VlPIQNd4?=
 =?us-ascii?Q?BODGDOdKCfuJwvUj9nf2jtOPlUqwYoOD41tIqNWBRCklbvFKZb5bldLQkuc/?=
 =?us-ascii?Q?xKXRvDA+pkB+x7SZsGOmoNcUdNWZHFU0Q8g4yWS9XvSV9+9b7vqaCKkQclFk?=
 =?us-ascii?Q?ZweKFJzQebBycDtEWYVlnAUzKiiMJyMSUvLEVawc9E7LigOXTPngveIHwb23?=
 =?us-ascii?Q?aAkALGaW5c5lfX8ChHYyp43ZWrMXyQebg8VyaNmb4be8twvtEk9YtayS3W/u?=
 =?us-ascii?Q?lYn8WN71Uelos2f2VBc8197oeu+gznW21X4HtNoH0td0yIvX2FtnkkFMN5eE?=
 =?us-ascii?Q?xf996eveWk7xj0jL5JgatY7EaFIJNKilu2BvPePnvRfWTlFMUmrTfBfpR1gt?=
 =?us-ascii?Q?iSwD8DvncWrqDeRS+et1zuVzG1YHpc2AX2Ov8feNRg+9B7oDMLyIkLClo1FY?=
 =?us-ascii?Q?ESblWlgJd6EsX/wVla36jyXsBmo9mxk6lH+XFANEi7QKwlUk6RgVeQMar8Wl?=
 =?us-ascii?Q?YORymyGsIpW2G8hfHHYCX2bH3qwubXdwu0Iihc35CAgPriW3h8TMU8n++mMY?=
 =?us-ascii?Q?qtm83XIbJriCCmoWFrTBBuXC5DSDEYPlQZPWL35lLFaDy7FD66PolatvRRaZ?=
 =?us-ascii?Q?f24hxEycAq19u+yQ4+ZbvN76GWRVcvCW4gfR79PxewggoGEf+s16Oa0PS4jD?=
 =?us-ascii?Q?Iju3p6qIBSlyMcbpZh1FHJL/uKav49/doD3jgdsPXVtQVCh8zojWiQ6MaUG+?=
 =?us-ascii?Q?Hm8e/0p7aPXBquttBI490HjPxCUW2kMUcKaVOnDKRxlAFgjst8nf0TSBkmWm?=
 =?us-ascii?Q?1zf7P+pw+8Rqy0QaN7Mko3/I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mZ7TOFFhlW+RyGMQul1QsFXCeJK60gWjtbpAJW1jow3Vgr6e0taPk/8EOnsX?=
 =?us-ascii?Q?DU+Obr+6OevJHbAoK3HB56bFx41zPjNptM/N7oiGBUwPOVB/Yjex4ZZuF8LK?=
 =?us-ascii?Q?Wxq51HdKBZrdN6rW6itL/33AZZDVy4/PBW5FEpKyzRjsCN2FTfomL4UAEzDI?=
 =?us-ascii?Q?ue1DvqsooaRVRQcZ1bZaaon1MeOILBPNRLAkhlGB1SJBA04JkHD1nodmBBRU?=
 =?us-ascii?Q?wsftPZhl7JiTe7A5RD2xjQj4Yg7akP0bVnYOoyChcok8Ie2wMfju8YoTBBc6?=
 =?us-ascii?Q?L+UKiV0tgNf3E9ymu9DZtNBC7jIejZRAQdNegINYuUtsfA4x40pIGIxYvsFr?=
 =?us-ascii?Q?JgLPJHgDuplZiF8V0HR6rtFnrAo1jQSIdkdDCqn1he7VDm6hvkHJT8nwjRsY?=
 =?us-ascii?Q?UDbCHMz6060Wwy0aeB0onm5Vv7KXqL9TKhrsDAe29agRrmV1enrVyzFfzbbS?=
 =?us-ascii?Q?vQ1RWvltNM3TrjXiAlDEIYK6Ift3YebeUq+SSF0egnmqlEOGaNoyi4jW5wKZ?=
 =?us-ascii?Q?Mqf6zw6h6HVROHsqICSXVZe0q0zgiLqK7UIQ9xGC8262ZXLzI7n1qma1LZdV?=
 =?us-ascii?Q?/JghBzkYB6Twc37NfpP8ROAef0BTDcZCanf77yi8ajUOXc29Va3ODMh3tmgD?=
 =?us-ascii?Q?SKNpG9mZh3stxNLJYG5C8zNAtCPIL0DzgpHGFNnMexVTsAUdMR8t7FtlpMN3?=
 =?us-ascii?Q?Wokn6sjnW4vAZUZ8yXT1kKNen0NNvqGJ7vAQfN1MIi3AoyUqQNxY2+nqkZq5?=
 =?us-ascii?Q?tXWZxCkEPPL64tOnmC9s+yUUPr8VAqVKjnSF0bqT9QfBr1uOaGTBBm66APPO?=
 =?us-ascii?Q?OCs4D3SGOoXnpUgY7Huf6WTNxSkfzFUMr18bS6iPfTQzADVjLF4dDaTfIPJY?=
 =?us-ascii?Q?hkBwewKrUtXmQiXMF8Q/tIqn47R+iKM66Lu8AbqJJWAM7s+Ackv/dWuN30y7?=
 =?us-ascii?Q?tJHFOR789B0GuB4Xxp+ulJc1efW4B1/lbwYxbdCDbUSoF6NhZ591XkbY+fgH?=
 =?us-ascii?Q?JqHFntf/nJxlzHYG7MdhXkwYRhD1xrLI463akfW59oNuj4CNwO4M1xS/ytGZ?=
 =?us-ascii?Q?Ehkf7GLuP2r4WCKyh4X5lepuEyCN81IHVOQ2WH8Tk8p9taZgsixpwR6biMBo?=
 =?us-ascii?Q?5A511/9wm43A+tQI0eK/+Wah2YlMJzhwXnhQeDXX39nFJt5QnX583i8KcsSg?=
 =?us-ascii?Q?0N0tphGUCzSqhBQGp+kOqyg7loUFjVtKx/Pukis6qkTPYUiK4EDVBQn0nBuC?=
 =?us-ascii?Q?1T/FdN+dPGVg3k8CWugHc37/DayaewlADZWyQShvcoTvDp6nJuUXLU26lCmE?=
 =?us-ascii?Q?oytyPsZkC+vd/WzSt7CxmyyQfsvaIHhTnomajhFKCF8LGd1kiHA4Zpj99cha?=
 =?us-ascii?Q?5HYIW5bnaDKTIhglFIcHIbcAegqiy9RbPfkpZAr3u8mxgdTPuRdpWIEprVNL?=
 =?us-ascii?Q?of+dpiqmT+FtoaTwiMX5n4FXmk6oGC4SkbC0t5KoXYbb4CUNbz23czwRH6qs?=
 =?us-ascii?Q?JrmRqe94eGYLQYz5+c5FGEjJuSQuBk2FxvoVbbzru9dxCYqDuKPfA5VrHlfq?=
 =?us-ascii?Q?KjtLvRRGoh/UXD0VDYi+LA7uQLgl9vvEud2cTcKq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a732f6-5df0-4c8b-7766-08dcf74460aa
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:33:43.5193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paUfQTx3qVOkhmvq7Q4zIgvvXL4c5vhh3ngtbeGkV2v/mVnzzAuHqVWTKl8rfcvleJjKbMJGrzSVBJt+1M1Eug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408

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
 kernel/sched/ext.c | 138 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 121 insertions(+), 17 deletions(-)

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
index 6705c2e67c99..4d3170b264ae 100644
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
+	s32 cpu = cpumask_first(cpu_possible_mask);
 
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
@@ -3383,6 +3479,10 @@ static void handle_hotplug(struct rq *rq, bool online)
 
 	atomic_long_inc(&scx_hotplug_seq);
 
+	if ((SCX_HAS_OP(cpu_online) || SCX_HAS_OP(cpu_offline)) &&
+	    static_branch_likely(&scx_builtin_idle_enabled))
+		update_selcpu_topology();
+
 	if (online && SCX_HAS_OP(cpu_online))
 		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
 	else if (!online && SCX_HAS_OP(cpu_offline))
@@ -5202,6 +5302,10 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			static_branch_enable_cpuslocked(&scx_has_op[i]);
 
 	check_hotplug_seq(ops);
+#ifdef CONFIG_SMP
+	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))
+		update_selcpu_topology();
+#endif
 	cpus_read_unlock();
 
 	ret = validate_ops(ops);
-- 
2.47.0


