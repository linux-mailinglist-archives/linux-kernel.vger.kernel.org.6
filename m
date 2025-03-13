Return-Path: <linux-kernel+bounces-560096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC88A5FDA9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9177E7A9B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97284156C76;
	Thu, 13 Mar 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="argKukpz"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AF81386DA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886654; cv=fail; b=S4dwW0VXSOW3FJStwJlEL94cJGvQHK5TVmDSG4O7/55uz+E6JuKvCx/CwZp5sX5jV20tSZP6ITxS2oIIsi6iCVRH/GvsqTSPHSjbc4N/wudXWbdbYm6NuzoFJA+vO5LgfcA7/8Jhq1Kl1+2m4wOFnKYF8Nz1tAbeqW6a7qvWvPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886654; c=relaxed/simple;
	bh=K5zJ7qNUhn+JHL4QFLllJ9r5mgb/LOFcIaFkRK9JP3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kNg1vo0h4dqCwDpBcnAp5tPWyOzmICbf8FFWJ4EATTAbQ4VzeNd02hXeXoKmOnQG9v+U5rm4FPLxjsEQc6PGft+KmtzBkM/t7aZ0sXTWR3jS4wH3LMZgsVLSc40nAlnUlTKf9SedI9YkUC4Sez8wOxz3kzyJImEZC/ZdKSuXuLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=argKukpz; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/GD5jaYLHKdavge9ovBlgVqHbatZKGCn4W+WmLh5DkBf4duJdaGSV/444N3x0cbl0qPyCaGc4CEb4Ecwai+GsdBY5W3Q6bMoa2fJFHB81k8U881KNABBWS3wXGWvjldVA8YsIRtWmjgz7Ir9iU/ClnzMUz4oUVINnapJtGj/ZKHO1dVIXdBxtsZ1/FhFYJSA7LAFipaJnUELp60HqUdvfD4FVnBIlIpBRopiWz4RxEgARZH1cG1M/8g62/Q+jR+jjX8QhJc5KyLFKMRXEejG7hXpBftup6MgEU8dXofKNA6izLVCxZ5p+2TIhNly9PakknY9ZmYu07Tqfi1NXYXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApttnL9PYxbXmx0lXo4xpzQY2/bugS8HpnUo3QwD4ks=;
 b=YYszT+WPUqG3uhsDhrrQsgOBjMb/XWPC5lL+K4F6nbu6xAnN7gtYX3v5TZPrObb32/MVbgPGEHftqtxTzNtmA9zlMyKj8egcZfBo57KpHHGjQGuwuGG5FYe1OQ5qHKo6EoQQ9106bJhyRWJ9bfifG30wZhthKDKQBRVVotbSaAKyoKQg/7PRJgZHSm+Vw6EuCL2iKqmdCLDFjN819fluf6FJILwqv7467euYWJC+EgLhRGllUoFUgeRVIynXD5ij8t2VfScJBUHXWGEEv1oJ69a9y4nXHvk0/OgodzoI/xGeGmuepEgGiLtXhQSpiXsRV53cD0j+dTIwfy0QbBdLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApttnL9PYxbXmx0lXo4xpzQY2/bugS8HpnUo3QwD4ks=;
 b=argKukpztQP7J7mpM5R8BkVLxsPttWRR6AIjp6C650/K7a2zI4LHCa/zyooQPVK7VGnVS9N4LAFReATNRr9PmGQ3jurH/EDOQ1JLVPWJ21PYsJddo/ld35E2hzKaALMUlRaz5XAHp5V5iDzkqtVV26Dt4yWGKCWhhViMWyNoaN0=
Received: from BL1PR13CA0154.namprd13.prod.outlook.com (2603:10b6:208:2bd::9)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 17:24:10 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::8c) by BL1PR13CA0154.outlook.office365.com
 (2603:10b6:208:2bd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Thu,
 13 Mar 2025 17:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 17:24:09 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 12:24:03 -0500
Message-ID: <dddcd352-d3f3-4578-9f3a-1bf58d8fdb63@amd.com>
Date: Thu, 13 Mar 2025 22:54:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v15 4/7] sched: Fix runtime accounting w/ split exec &
 sched contexts
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
CC: Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
	<vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman
	<mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan
	<xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>,
	<kernel-team@android.com>
References: <20250312221147.1865364-1-jstultz@google.com>
 <20250312221147.1865364-5-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250312221147.1865364-5-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: de3fb585-f02b-4cb2-b415-08dd6253ddcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um96TkMrWXJxcFo3d1R4Q0k4UThYL3VPTjBaTFpMalBJTWNWQnBHOCtZakND?=
 =?utf-8?B?OVIrOERwWTk0QmFtSHlDbkpaTy9sU3RZZ3lWalhndCtTVExOaXBUd3dJYlZH?=
 =?utf-8?B?SEVsQUJKRWNueHRLdGZjR3lGUVRHaitXWm1LWkxyWkUwNnVuUUNlMVRlUjdK?=
 =?utf-8?B?T0U5SzFZQUJhUGxoMWhmVVVPQ3hWKzUvVmREVTFadTVSS2VHOGFEN3k3RjN5?=
 =?utf-8?B?dVJiYmhWUEtiaXU1SFdlejFhVWNLdW0rOG5iR3RoT0pYQ1N5M3VzbzIxUmJj?=
 =?utf-8?B?anZPVjB0KzN6c1dKTGRSWmV1R0t1ZkpLSndjUnlJaHdPU1NINFBqeEJXMGlN?=
 =?utf-8?B?aUd5NkR2Z1pnQno4SnI2NmZHcDQwZEZDZ1JjejRYNHR3QjJkZExjajRnYjd4?=
 =?utf-8?B?ZWxueGJMS3RvVGZhRWhLeC9aZmY3KzNoSjZMRi83aml1Y0Q3WSsrbnA0Zkk3?=
 =?utf-8?B?bWNqS3Rua3NFbGZPZDJPWmwzc2JvM004S3VyQXRQbHgrV0RiL1dmeFVienZr?=
 =?utf-8?B?MDJzN1QyYXhhSU1hRHBKMmFDOHRVTFBPYWlCbXpTeUF2RmpLMnB6VGFoWFlp?=
 =?utf-8?B?NzNweVlPdFVwNURUeGZTTjc4dGZCYUZVVDJWTWgrRE1jVmxpWGd2UkdYU05B?=
 =?utf-8?B?ejc1Q3lwOWY2VUVTa2tWa21vVHFXengvNmliN1ZOKzZJa0M0MzRJOVpQcEdD?=
 =?utf-8?B?UUZhWlZ2NGg5T2pMUjROeS9GZkhrNzhYVWdFOGZJT1JnOUZoUnc4eXRxckQw?=
 =?utf-8?B?b3A1T1NOUTNkdEswcTJWUW13NHZwWjMvcXNmbElHTkdoYTlpSjVtUE9OY3Bv?=
 =?utf-8?B?ZnREY0F4OFM5cTc4TWpwVUY0OUJSR1luVnlJQ1hhVUJRVEsyWTcrbk1uQnkr?=
 =?utf-8?B?MHpzMi9TMytudXU2ZVZOVlB5WEpPNFc0MEI5QjJrWlB6c1lneWpmam82dERs?=
 =?utf-8?B?M0hHVWdyMnJ0NkVlZ2xCUjdkaWxGWDdVL2FwVUdJUU9GMFNsejZQTHM1ZkM0?=
 =?utf-8?B?K1dzejlhUjZFUXYyUnNGVG41VlNFaUl4RnkwTmszL3dicmtsMnhCYjFIRkVt?=
 =?utf-8?B?akVPdExPVXVYNUY3em9zajJka3ZtODZ1L29ZLzU3T1JRRkhteEZ1Y25JQVM5?=
 =?utf-8?B?U3c5MzNibGFwSzFVZDgwWHlDWFpuUXdaQWZDd25lR3krUGlNazh0NEFYWSsz?=
 =?utf-8?B?STdpUGszYzZMcE9RWllMSjd3L3JBWWkvNkxtMjJkTmp3MkJ4Z2dtVmxlT2ZJ?=
 =?utf-8?B?akx0UzlnMlBia01SRGRheGpRRmNWYXZnVDgxQ2JnSTZSQnRnY3JtdWhGNWh0?=
 =?utf-8?B?cHNKT1lKZW9UazBpUXNKUVJKOEl1SkFMMjFRNXBDb0VBWDRBbmxOeTZkaDlG?=
 =?utf-8?B?NmdMTWFzZFlzTmRoZDBhOEsxc2tHWHRRNmw1N3poUHRSdVJ5VmNoWmxJOWpx?=
 =?utf-8?B?enNLQmNoeDd5OHNXWGN6dkdIYWhtZXRnckFwb3drbUZTSnladU5lU2RTVXc0?=
 =?utf-8?B?WnNwMUxCU3VIVG1vV2JLOFcxL1ZqQVQ0a1BwQTJna0svK04vOXNBSmRUY2E4?=
 =?utf-8?B?VFlmL0NFYWpZcTNQZ0lFanM1aEZIbDZtT2d6N1RCZC9yTEdwdEh1Lzl3R3F0?=
 =?utf-8?B?ejFiaHJNajMxcmFOaTFwTExLazVlODJKemExM3lXRXpvc21oZ2FicXhWS3NE?=
 =?utf-8?B?YzZDVlRjZmttSDJneVZuMGJBa1pIdVNJbjRrei8yWWFvRnpiVXY0bHlPSUpt?=
 =?utf-8?B?OTRDOEVxbEVuVnJ2bTM0cmhOOE0rUTZmWHI5cEJIQnhtVUhaVnRqeFJqMCt4?=
 =?utf-8?B?dVRWVVNCMzg1UjB3MGxjcGwxMXpGdnVGeEFvNVBQZE5YMk5uYkZWdVgybXRp?=
 =?utf-8?B?WDBnR3JtVjVlN0NpM294bnU2aWt0T252Q0g1emNabUFqY1FqMkVFa29KZkx0?=
 =?utf-8?B?VkNpQ2ljZ29QWXBYYWJiV3Q2RHpnOGdCS3AzTHV0UUZ4dW4weWU3Qkt6OXRH?=
 =?utf-8?B?NGx6cVBtUVpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:24:09.9194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de3fb585-f02b-4cb2-b415-08dd6253ddcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956

Hello John,

On 3/13/2025 3:41 AM, John Stultz wrote:
> The idea here is we want to charge the scheduler-context task's
> vruntime but charge the execution-context task's sum_exec_runtime.
> 
> This way cputime accounting goes against the task actually running
> but vruntime accounting goes against the rq->donor task so we get
> proper fairness.
> 
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Suleiman Souhlal <suleiman@google.com>
> Cc: kernel-team@android.com
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>   kernel/sched/fair.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c798d27952431..f8ad3a44b3771 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1129,22 +1129,33 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
>   }
>   #endif /* CONFIG_SMP */
>   
> -static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
> +static s64 update_curr_se(struct rq *rq, struct sched_entity *se)
>   {
>   	u64 now = rq_clock_task(rq);
>   	s64 delta_exec;
>   
> -	delta_exec = now - curr->exec_start;
> +	delta_exec = now - se->exec_start;
>   	if (unlikely(delta_exec <= 0))
>   		return delta_exec;
>   
> -	curr->exec_start = now;
> -	curr->sum_exec_runtime += delta_exec;
> +	se->exec_start = now;
> +	if (entity_is_task(se)) {
> +		struct task_struct *running = rq->curr;
> +		/*
> +		 * If se is a task, we account the time against the running
> +		 * task, as w/ proxy-exec they may not be the same.
> +		 */
> +		running->se.exec_start = now;
> +		running->se.sum_exec_runtime += delta_exec;
> +	} else {
> +		/* If not task, account the time against se */
> +		se->sum_exec_runtime += delta_exec;
> +	}
>   
>   	if (schedstat_enabled()) {
>   		struct sched_statistics *stats;
>   
> -		stats = __schedstats_from_se(curr);
> +		stats = __schedstats_from_se(se);
>   		__schedstat_set(stats->exec_max,
>   				max(delta_exec, stats->exec_max));

So I'm slightly confused here - For the case of proxy where
entity_is_task(), we charge the delta_exec to the running task's se but
then we go ahead and update the exec_max against the stats of the
donor's se? That seems odd.

Could we just replace the se with &rq->curr->se if entity_is_task()
returns true and keep the rest as is? The calculations will be same as
what it is above (except for the stats bit) and you'll not require
updating "exec_start" for both current task and proxy's se. Thoughts?


>   	}

-- 
Thanks and Regards,
Prateek


