Return-Path: <linux-kernel+bounces-437241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6B69E90CB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D18A1882F6F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D7921770A;
	Mon,  9 Dec 2024 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mFamO1Fh"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F57216E00
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741204; cv=fail; b=F3KtN5E98G9KJ+Z72M9Zmj8hWrtO+ianhFN//YEQjpEsSaAbkXtiQgkTHqgF/4ynMcU7EGUJH8oQbdw1RCe/ukAhupzidi1CcuPBLgJXkTy7u9wf7Q/hFLjlBFV7kiRkqJSSXcWyM+WIT92LuD4ZE0580akkm0jpD8nm+UZSnxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741204; c=relaxed/simple;
	bh=k2OWnSMlyiuSf7Wswjt0VU3U2lOzD37sGGESVmnNMGs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DN561iFLtekURMRUwP52uCAylbySOVUEltkwDoEwEorS3CBVw9cCSe2a48DyWJW4iWG6kTQXxQvjt6z5TdWX7aRV9Nkkyir3mwpsG3zzwKJlafjWS37ybwhFAgv1PMDVbw1Mkms5wggiPRP1HQ84EIMqRe71nZGPyjgYCu9wFug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mFamO1Fh; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4zr11PPlDahzcm8u9mvOR+hB/Hn72O4A1Jh34hkVl7ikls8q9eEveDTVX/gTOpHy0F8Jn2MJ4SH1QSU00IoT4yG2X4/hDZyoM5jgyzFLChddBbFoxo/wHVRB0sqr8UYwXsVYWsAG8nQ/+FgR4FnRElbaECc1nFl8ztl6xB3zc2XIrZwAMYt/bW9aUWl2KNkyHlvGl02IEKqjB7wCOUx52PGmpGfsG8kPEVc+uB/o9dS81dm0c5/uVAjB3PpaAAxLpAZH7LZb/153GOmqbcrkM8ffedrXUFCguzlq64awqxUechbhe8gMeaZQiGkFWxMBdLCA43z0My3Fa2DRBCMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqetmX9kiLhgHvB5JiF98bi+SO+cHjHlvbadDQl7wyk=;
 b=VQfoWkCMu8ibeQ6o3kkAfaP/qQogiM6o+FGyiDeY2OdpJABmikp9sINlF/WeePQya3rju3rv8VDIg90Gx9Bn+MYBnEv1YN2tLHu3aqpdz3xRTgdduCyjN+i5Dg1QnDIvZxnaSp9xFwIUrl3lH3IWn7YlZOFokP/IYsC3u5F5pdzsZ8tPDmb8YvoWNggOMBNDtglDRmACJsD8Qo6rsHY1JU2scZu8G8GJmMxyhoizCOiMUiNK01yrDzbSCnx6vvOpw+uDh1SUc/GEWJgBSoLPcmD8U6jEbZEVlYFZrbp10J1cdPUqoSMNEHIXudyIllcN05cgC3Uj7b/4lSjRHkeNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqetmX9kiLhgHvB5JiF98bi+SO+cHjHlvbadDQl7wyk=;
 b=mFamO1FhwDueohl0wfBbCsRJeztF6dzjpS0nJcyPy2RHO9hqeRwIa6o5Z7YQh3WZHvOLu4tq3GOj5fQuykg327WoIBVphIjBn3erMQjarEGjSGO4j24c+ZXTeHdBB6SUf7df/A/RpfVmgtO/iHUqKzjN9LzL9Fjrgus2lxd+UmTyyHCDgtncwEaBGdsCZgbNHiMDPFeMzSdywsOjAKtvuH53tNbDl3gDD+P1NWFqBPJYI/mar5nuG+Djtv+07CXlBMzTaFUHtdYwNduyFGSE2/0Ve1VacJ17963lS8T6Zg4E/hhabv8QRWxRvBqVmYvHhP2OsA+toukSF1QbVM+IRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) by
 DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Mon, 9 Dec 2024 10:46:39 +0000
Received: from DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793]) by DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 10:46:39 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v5 sched_ext/for-6.14] sched_ext: split global idle cpumask into per-NUMA cpumasks
Date: Mon,  9 Dec 2024 11:40:54 +0100
Message-ID: <20241209104632.718085-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::19) To DM4PR12MB6424.namprd12.prod.outlook.com
 (2603:10b6:8:be::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6424:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 6197691b-3323-4165-15de-08dd183ec2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MwI9Qda++TGGmAXWK0lyG+UFxWxfYa8FHO4zmKfvoEo5XxZ8avbw44WDIG1n?=
 =?us-ascii?Q?A2JtIDo4BaMNWxNUXGCx2Nk+4QuNdzn07OIWXj7VYH5FUs283uFOUiOCFYKp?=
 =?us-ascii?Q?5yx/DVOqB0OhNhEuBJMc10eVAPGvp4eJol9xH2YMf4Eo2JZzC94Kq45YLGVq?=
 =?us-ascii?Q?TEQsUxzE7K3wTF2J83wRzvH0W/I/JpoKe9THrbe6RlEEl2ErD4vqF23DM1ta?=
 =?us-ascii?Q?S0JIPc+LNe9YSC0BbVUh4/80sv+OgHL9GqjJ7LMlNKOOO9XtGRwI7QM/YDgB?=
 =?us-ascii?Q?iaB3n6hNfGZk6vzYmZ7hdtrHRhtJUrY404HdXmx/RzlYNSePL4veTse3mQ0J?=
 =?us-ascii?Q?Dl1zxo8gGjP8vnSSbIlWHL4cR7b9OGK2r4SZN81cqrCTGtksPFYVjk7Kd1Vu?=
 =?us-ascii?Q?bGAhO+GsP3dmAb3GtVn4XZ9VbH66+bap+xgklo55MLekhf/S8u30dQStjD5w?=
 =?us-ascii?Q?Alh9F3KE7UdyCyFrQPVR9Ft0iPIh9Yh/zLE3QDhmFp4/cNAbCX7ll5iLFwvL?=
 =?us-ascii?Q?8BregqeYvvdLotPZB3+qycfPrg8UOhapG7LcjMgrADTEfhOCFVz08VLlKdQo?=
 =?us-ascii?Q?WNAzkupwcXP8KJt0NjP/xyHCVwpiLwtfGPnWU/FyJuCIaAPUJ8wMIHyQfQUM?=
 =?us-ascii?Q?4BFtFoTnfo48dw8aKZtWYGAcEfSPc/zQucIuXn1lNU8y+oj9DkywvtMfJJLJ?=
 =?us-ascii?Q?QgyGLEB+bP7M7zPsd6AfLU3wYMZ22cQaLIWwdqjSHkxitlEtlJGsDjFWAZcJ?=
 =?us-ascii?Q?ij/4ZUFgkt4/E5Re++l+7eG4n5H77eVd0i2vONaieL4wugqbACVprIVXMc/i?=
 =?us-ascii?Q?M0OED6SE6oeHstTCq2xoiD9ce59i3KjLqkZcl6i1mhx4yivkcS6PUNpYTajY?=
 =?us-ascii?Q?f/3M2wwfuojhxj5mS2ldO3D+9MP0y0h04rF4jv7ZR13zmlVwojT2BYPxfNaD?=
 =?us-ascii?Q?s7l7vr4LIl+PvOoDGTSqo99VE66MJ/Xs+QVIkd8TnDzNhnEF3dZ/EzChe3+R?=
 =?us-ascii?Q?iDnlyKP/xzqVydRldYd63zPXiFmOGuUD7GTKRh5PhoCb95iAAm6aesilCX/h?=
 =?us-ascii?Q?+Hm1WcSe7W27/dEEbBdmxoyphqZDDQBIP9LTorCDsmf6HoCLSuvUltFNrl6q?=
 =?us-ascii?Q?XARM/JeQvnz5bz3rrzUahzUGdY4cb7dhwo8Kr3kJFub/3AE1xG96yIMpWVZ9?=
 =?us-ascii?Q?rBRsqPldQHB1bic5n5G4nEAcCaUhJWbFF5ZrulcSKUK/izspR2Tci0vNjW73?=
 =?us-ascii?Q?867Hx5VpDCK4vz5v6wBzP17ojBcMCbJdMSOv7+wRbkmnB8kBhMCCXa67+sqj?=
 =?us-ascii?Q?hbqNfZt+i3doa32OkQk+J9yuCfDJo6FXbeX0GN5SK9AYCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6424.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PQqeAmy/WIWHezaLKyp4exfSpaeXSynuzH3Mba1bvw3zOTiwoQaPEcIBA4zu?=
 =?us-ascii?Q?nfc90HqvcEtjTPWTI02sI6wq/2ut8aUFMIMHsINA1+1MRBU96VSpbBySeA2K?=
 =?us-ascii?Q?5zcSecJVRe7R8LPblAciZGfDg6IWyBIFclnTlQRuWXRjCCuZMBNDxvkbr0TZ?=
 =?us-ascii?Q?CrHxffy73pHIKV7zLg+y3/HbIqZ8+ZAtGKCeN5f6cpOVdViiIq4lWthHn0lH?=
 =?us-ascii?Q?Gq2ob2poAyMs10UC8OaKy6PRpEQ56PxvhC+bOHAs6fd3iqUFub+/UOBXqOgk?=
 =?us-ascii?Q?yGcxqpMW+PQ6Md5/WomJaagWR+QnhvKCzaJxYuEqdkB/3fWl27IH5rZ5RGz3?=
 =?us-ascii?Q?WI3Skz5NirRblvGVN1fzTdzvaYg8qkd4ocE5OdinMHDTD2TqvZyEt6L8S6JL?=
 =?us-ascii?Q?e/9Mmh1BOETkJsQMoE7wVoRUEdRK3Salhidlz2kW7ErX8lZz10QxnuKOq+2O?=
 =?us-ascii?Q?9X4hNsbr79XInLO/AtyR2gB7a2U1nBrXZVnd74aDCbCUFbyyL8g4RpqN1rEj?=
 =?us-ascii?Q?RHjqbucwlEsMbI1AewuF6n6SsEmk8rH7Lm6aBaVxfttPJqDn4hlr+6QTl9Rk?=
 =?us-ascii?Q?5dQJZnfilTbCIKN48Q2GkpF9KDHY+Idk0WgX6xfJ4XdYsIDV2rVEgWvATRDP?=
 =?us-ascii?Q?W0q/5RTReX5xdMQjSYU3SXfoCvimu4dSRT/V+34xZtBDcd4TdB1dbaWtxQjB?=
 =?us-ascii?Q?6SN5VzUwQ1rlBU/XPsoKenxZxUwQQVSZI5TcDRumiVZ+MnRceGEQkPkI4mGP?=
 =?us-ascii?Q?lACEyxK4u9BgnKDxQPt4SDyclcsK8qPaypT9XtHcFPyJFMvLELcVbvNEUeso?=
 =?us-ascii?Q?1WuimPLZa9R2GTzuiUr/vRBZwyYrYWfP6vCG7gZMlY0zvMIZuxv8SeW4SClp?=
 =?us-ascii?Q?mcxGhKjbQLNQOUzuJyKFNcr9b/aatNVYFFn2s/ikhHZX0vIBU1MN1sYqf6+W?=
 =?us-ascii?Q?ESeu5MAFMRo18fUTqgyKWV2K6vGieVl/zbGTqaASIk97eQUW87I/U//Z/qI6?=
 =?us-ascii?Q?xw70T+6iZ3j1Utwzm8Et2jLvNqQ1pCX9EsmZF5ZqI/JlAhpUyO4y4NoVJM+L?=
 =?us-ascii?Q?RBGRrXB6oMho4CR4Tm9EkqsmqDvWTfrDHlHah9miWnTVH7KJeUhJLOGScneG?=
 =?us-ascii?Q?HXPsHiI0XTT9KcKYSGVvBMpIsziyNk3PP5hFdeeLgI6THf7CJ+7kSFnRSBew?=
 =?us-ascii?Q?Wp1JFp96zSGaGaz3zpOkHjgIRZJR8liQABx/oFvKYDJiAUq01ZZzfsfGp/9n?=
 =?us-ascii?Q?gbmbv7qRGGobtLBt548ohBRCGvP8M+Fxuf5TRzdRN9ETA0fN1xOSR4OSAXoX?=
 =?us-ascii?Q?YEgbjqHT4mxC17yQ8XcqILNli3z5l0UGPvQJJi8VKtW3Iprd2HBpp+oTbb7r?=
 =?us-ascii?Q?VzFMzra3ALFYafL/H+PicHBMezyCVSWvvu54autYBzTUdEnk9d7TvrdwhCD7?=
 =?us-ascii?Q?ScPnJkHSYsCAgYPlI9vvYm1VaVEMDLgA1tu8hpOoI2wDSJIGzEDlzw+xONgw?=
 =?us-ascii?Q?okPQqSO9KchAE3RJ4lGASIFe2Z+YJ8u2jOMnZW0G/yXhoXjud5QAJ/GlpyNa?=
 =?us-ascii?Q?kmlatvBl37++0SAnR5kqeuIvT+u0a2muDVO9ACch?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6197691b-3323-4165-15de-08dd183ec2af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:46:39.2273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+VWJoIDzDfRV2hN1vrNaZInqsLFi5TIcw/6fERU+4pB0PULG+wkw2U/R8g5LTMQEgnxyiR758e2YUetptamzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462

= Overview =

As discussed during the sched_ext office hours, using a global cpumask
to keep track of the idle CPUs can be inefficient and it may not scale
really well on large NUMA systems.

Therefore, split the idle cpumask into multiple per-NUMA node cpumasks
to improve scalability and performance on such large systems.

Scalability issues seem to be more noticeable on Intel Sapphire Rapids
dual-socket architectures.

= Test =

Hardware:
 - System: DGX B200
    - CPUs: 224 SMT threads (112 physical cores)
    - Processor: INTEL(R) XEON(R) PLATINUM 8570
    - 2 NUMA nodes

Scheduler:
 - scx_simple [1] (so that we can focus at the built-in idle selection
   policy and not at the scheduling policy itself)

Test:
 - Run a parallel kernel build `make -j $(nproc)` and measure the average
   elapsed time over 10 runs:

          avg time | stdev
          ---------+------
 before:   52.431s | 2.895
  after:   50.342s | 2.895

= Conclusion =

Splitting the global cpumask into multiple per-NUMA cpumasks helped to
achieve a speedup of approximately +4% with this particular architecture
and test case.

I've repeated the same test on a DGX-1 (40 physical cores, Intel Xeon
E5-2698 v4 @ 2.20GHz, 2 NUMA nodes) and I didn't observe any measurable
difference.

In general, on smaller systems, I haven't noticed any measurable
regressions or improvements with the same test (parallel kernel build)
and scheduler (scx_simple).

NOTE: splitting the global cpumask into multiple cpumasks may increase
the overhead of scx_bpf_pick_idle_cpu() or ops.select_cpu() (for
schedulers relying on the built-in CPU idle selection policy) in
presence of multiple NUMA nodes, particularly under high system load,
since we may have to access multiple cpumasks to find an idle CPU.

However, this increased overhead seems to be highly compensated by a
lower overhead when updating the idle state (__scx_update_idle()) and by
the fact that CPUs are more likely operating within their local idle
cpumask, reducing the stress on the cache coherency protocol.

= References =

[1] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_simple.bpf.c

ChangeLog v4 -> v5:
 - introduce new scx_bpf_cpu_to_node() kfunc
 - provide __COMPAT_*() helpers for the new kfunc's

ChangeLog v3 -> v4:
 - introduce SCX_OPS_NODE_BUILTIN_IDLE to select multiple per-node
   cpumasks or single flat cpumask
 - introduce new kfuncs to access per-node idle cpumasks information
 - use for_each_numa_hop_mask() to traverse NUMA nodes in increasing
   distance
 - dropped nodemask helpers (not needed anymore)
 - rebase to sched_ext/for-6.14

ChangeLog v2 -> v3:
  - introduce for_each_online_node_wrap()
  - re-introduce cpumask_intersects() in test_and_clear_cpu_idle() (to
    reduce memory writes / cache coherence pressure)
  - get rid of the redundant scx_selcpu_topo_numa logic
  [test results are pretty much identical, so I haven't updated them from v2]

ChangeLog v1 -> v2:
  - renamed for_each_node_mask|state_from() -> for_each_node_mask|state_wrap()
  - misc cpumask optimizations (thanks to Yury)

Andrea Righi (4):
      sched_ext: Introduce per-NUMA idle cpumasks
      sched_ext: Get rid of the scx_selcpu_topo_numa logic
      sched_ext: Introduce SCX_OPS_NODE_BUILTIN_IDLE
      sched_ext: Introduce NUMA aware idle cpu kfunc helpers

 kernel/sched/ext.c                       | 438 ++++++++++++++++++++++---------
 tools/sched_ext/include/scx/common.bpf.h |   4 +
 tools/sched_ext/include/scx/compat.bpf.h |  19 ++
 3 files changed, 332 insertions(+), 129 deletions(-)

