Return-Path: <linux-kernel+bounces-543190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F0FA4D29F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCFA16A46F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 04:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E521F0E52;
	Tue,  4 Mar 2025 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gqOJHTWd"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82862A1BB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 04:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741063104; cv=fail; b=ts28VNpxdkEE7xPGc89ELSnUgTdKS7ULfW3qcOF+us0RwCL9l3VBy9gw+d7kriPGh3dIpt4TdwsNO2aeOjVVV9+/QcN5bjJQNzko+v4iebloFT2oBGAkgroHSR7orvjK+UfkCDtW5kZYlYGe18WW503XASComPzJbzEwa+VbTMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741063104; c=relaxed/simple;
	bh=L7TETxOr9CDaB4OP1Gb694I1gphNTcO53ZynfvQaFYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ir2pMgvH2WW8CIYbOfwbomGQHQ8Zvs6s9wF0RYTIjp4dlpWzCQiQL+AUYkmk6JxJ6I/Exqq0yaFi47Z4japdnjHbbOoesW13tPveadGfxl3wbhqxQVEWUgrldVsQmLfyJkq2HwzFsoW13jIHkV815AoCD+i8K8oUfkSXRdHy2PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gqOJHTWd; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAV/QxOWOZNlY75V9RwKY2Vfk7UrzlkC1IPnM6crFB/JzGZRQVzt7CYpfx54cF1ISDqK6vOQwImNZiC0+p4dx/IqiVReqt4F3LEt9M7IWUQxE2B+oToQrtPizTPUzkhE2fHdA/88citArcMLGkGrCXArdKG2V+oh5iy06dJzfDO3QOlY5wZqkeVWrfYnCxJb5szgmYSpbUmvTRt1VtHHxKWz56y4UBE4va/QqMAIrD7+UeTtSFTJSUQiDbhwGaelUxK3eDDJompw5S7qMrUNOsfmEZrAwLtgNq3WT+yIyfeRPZvkFZ6nGMcESUNv5gaBFEtickBKF3agWf/g9yjDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xVRiuolrnMBCFYdYziQunI9n5PXBYc+8vNDHwi/t24=;
 b=CmvWW2RGsgKp/mHSN9USDxMIT6vBSOqfVPnzknaKtRpF3D9FiF5ycQfiWovRKjKpbM4LwL0uhgD1SopykC3FM8pRtRRzOns+iCu9zoywLNQvOJqPovh+Yd69t+brxl0pCC3/Mpo4LjuYXuigmN3s7/AobhTM0f+y/Ex4SfxlDcTWg5BRmZY2YY9HbTzJw8Ag+QSc1zPZvDFWXFSGpfF34wgj0BhFIaiKQHas1e7I/YfF6Kc9MaN1kq8hkJrdU+m8ATC0FtcTk1lKcpE052s6n+obtzq4WTeiLA4NXCeTGkzWngdtU9ZOXZpxzKlAIuDyMwcu/w3khruoymNGINeGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xVRiuolrnMBCFYdYziQunI9n5PXBYc+8vNDHwi/t24=;
 b=gqOJHTWdwX50OuOKQTOKOPIA72fnXlHw0vTnKEPCgJMoFwG2KzAfgpemGk0qs7A5mtIa1Z7i5tQGsCDG9ZJKyhizhfHeGM5R1C5uyHusg08qSdho6/iwxSd9dIyEX8FYb+e5BISQrXK4h0qQyxgHcGUD+PuLTEoyfdzcZXTpftU=
Received: from MW4PR03CA0353.namprd03.prod.outlook.com (2603:10b6:303:dc::28)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 04:38:16 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:dc:cafe::1c) by MW4PR03CA0353.outlook.office365.com
 (2603:10b6:303:dc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.26 via Frontend Transport; Tue,
 4 Mar 2025 04:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 04:38:15 +0000
Received: from [10.136.44.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 22:38:10 -0600
Message-ID: <ce1e5fe8-c6be-4072-88ec-a465e9920213@amd.com>
Date: Tue, 4 Mar 2025 10:08:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7 v5] sched/fair: Filter false overloaded_group case for
 EAS
To: Vincent Guittot <vincent.guittot@linaro.org>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <lukasz.luba@arm.com>, <rafael.j.wysocki@intel.com>,
	<pierre.gondois@arm.com>, <linux-kernel@vger.kernel.org>
CC: <qyousef@layalina.io>, <hongyan.xia2@arm.com>, <christian.loehle@arm.com>,
	<luis.machado@arm.com>, <qperret@google.com>
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
 <20250302210539.1563190-2-vincent.guittot@linaro.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250302210539.1563190-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: e0aaed05-9855-4358-76c8-08dd5ad66141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUhFWmxwTmFEMFNHbGFtWG9mUlE1aGNPYURNeW45enE3VVFNUUdlT3l5cWNH?=
 =?utf-8?B?c1VOdkl0RzAwWW1ZTlVWZE9NTGxyVEhBNVVOVjh1OVlodzZ0QnM4emVqcHIr?=
 =?utf-8?B?NVV2UzMrdHJjWW96WVJDM2plWld2a1RWOHdpRG02c2JOekIwaktEWHRpVkJz?=
 =?utf-8?B?RWs1YUNsWjVQOFdLR3B0Y0d2ekwwR3FjcjdYRk9KM1BIdkQrdVdJT2ZXdFhO?=
 =?utf-8?B?ZE9GdnYvTmx1a1NLb1MweW5obGtFMU9uK2F2TW5jN3BaL1gzaU1VdHgrT1dK?=
 =?utf-8?B?d2p3QzMwcWJWZUVaVDltQ01maHpSWmplMkgyVFNZNERDQ3Fzd3dzZnlWejJy?=
 =?utf-8?B?UVlTdHNKZHRTdnBEK1JQTDF0RzdhbWJKYXAwV0dKYzcvR0NkZnFrUUlDRndX?=
 =?utf-8?B?ZjJmY3psekJxREZJc0VQMTNnd0pXN1lVU3o1blM5aVgyNzMyeGJoKy9sdWNo?=
 =?utf-8?B?dUpqNThaNEpFN3p0NVFrdU5aZERQM0RacnJoUW14ckhVY0FnZExIQkE4Qkk5?=
 =?utf-8?B?KzRlWktxSEZnL1FUT3Y2RkJvMDlnWnVPUE5CcWJUWVJ1RndnNWEzcjlIbnpF?=
 =?utf-8?B?QVlkeGNkQUhhbVk4amFlcUxLWCszT2ZKdVVYM25KRXN2VXV6elF3Ny9QZHg4?=
 =?utf-8?B?QlBxUm1NL2FEd2JiVExiQldscnpGUTU4TmtvZmRqaUxvZGNxOEEyeGJ5NEFi?=
 =?utf-8?B?QXBKSS9KcmJOK2svRTBoMXBVTEV3TW5sZHBOVmZuYm84WWJIMDU1SWhZeVBM?=
 =?utf-8?B?ODVJRURtVnJuVExTNDQ3ZFY2Z0ZLS0daOE9ZMU9DaFc2a3YxNS9Ha25nOEEx?=
 =?utf-8?B?MkFvMzFLYkZ0SVExTGtOcjV2OTBERjg4TU94eTZUYXQxOHplNzZhUXVjdlNU?=
 =?utf-8?B?Tld1TTVjRktMaHR0N2pucEJuakVmZTRPZmQvVmdFM0I0cXR5WVFFWWlJYzFr?=
 =?utf-8?B?WmNXaEZBeXE3OGpmbHRTblo0WU1YSEJJazRrOVdJdW5SRUE2NTM3OFJIZHFH?=
 =?utf-8?B?QTlNbEp0c0YxUXlUUE9SSHlvQ2dHdUJEVEhPRU9JVVNPY0l6WWJPem9Mc0R2?=
 =?utf-8?B?V0cyTmlUaE9sWFBpMlVmK0dydXkySWtuUlB0RENva2NXa3FGZ25NRlN2ZUF4?=
 =?utf-8?B?cjBMaXFEa2grcVc3QVBtYXJibCt5dkU3THpTaTZnSU5JZGlJdUxoUmo0U283?=
 =?utf-8?B?TmoxbFJqbkhkd3lYQUdMbUlsbm9QajFwdmJrRmJqVlF5TmZxRklWWGlkS013?=
 =?utf-8?B?SjZEaFJRaVhzQjN3S0xyelFQWE1NOXJmT2JhNiswVnFFSFRXQWtrV3pLaHht?=
 =?utf-8?B?ZnNjei8zOEd1T2JMY1hNOXhWY2hMYlhrZitEbnR2b09JTEs5cllXY0JMeGhi?=
 =?utf-8?B?TjJQTkZuRllCOWtOVU9GR2Y1ZTlRVVFiVGQ0c3BPaHpudUNhS29wUWxTc3Fj?=
 =?utf-8?B?NWx0cjdmU2twTGVKcnJDUjN2S1hWZlRDMUk3cU0wdGlxQSs5UUdVcXA4Ui9p?=
 =?utf-8?B?ckVQc2tPcEVXQWQ2bEVKVm5td3NnZmtwbC9GWWZ5L0ozNUZPcDZVMXI1TXVJ?=
 =?utf-8?B?MUVEYTZ5RllpdFhISllLK2NicndQTG90NUlrVlZKOG1wQjlySWxkNEFKZGho?=
 =?utf-8?B?blNneDRGb1ZTdDF4WEd2bVcxTmhuMEFPb20xM1huMVhjbEpMeGt3NVpZVFRp?=
 =?utf-8?B?bDJ2ZGE5NEIvKzhPdmFYaVNEUHdXeERFRmk4M3d2WHRqZU55N3VIdDFENHhI?=
 =?utf-8?B?UitJSG1OTUZqNE5YUElvY1Y1eC9kbmNpRm1KV1RFcStjejBPQ1diaVlGZlZy?=
 =?utf-8?B?UUYySVMvL1RQZUsyTi9GN1g4K0ZPTFg5WkxWMEcvbFN5NkloNE0rL2JoOSsx?=
 =?utf-8?B?cWpZclI0QnZ1SEdPellPRExWb0JkZlFhNkMzVG9ucFFwNUEzMkk2NDhna3p1?=
 =?utf-8?B?VEdNWnVMS2FQY2svaXVRTWMyRzlNOHV2T2IrSER1ZmJmY2d2Yk5yVmNsMW1X?=
 =?utf-8?Q?u9G3B+5NiZQ6FbiEe5v9DdkoVSTiCM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 04:38:15.6097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0aaed05-9855-4358-76c8-08dd5ad66141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246

Hello Vincent,

On 3/3/2025 2:35 AM, Vincent Guittot wrote:
> With EAS, a group should be set overloaded if at least 1 CPU in the group
> is overutilized but it can happen that a CPU is fully utilized by tasks
> because of clamping the compute capacity of the CPU. In such case, the CPU
> is not overutilized and as a result should not be set overloaded as well.
> 
> group_overloaded being a higher priority than group_misfit, such group can
> be selected as the busiest group instead of a group with a mistfit task
> and prevents load_balance to select the CPU with the misfit task to pull
> the latter on a fitting CPU.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>   kernel/sched/fair.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 857808da23d8..d3d1a2ba6b1a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9931,6 +9931,7 @@ struct sg_lb_stats {
>   	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
>   	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
>   	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
> +	unsigned int group_overutilized;	/* At least one CPU is overutilized in the group */
>   #ifdef CONFIG_NUMA_BALANCING
>   	unsigned int nr_numa_running;
>   	unsigned int nr_preferred_running;
> @@ -10163,6 +10164,13 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>   static inline bool
>   group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>   {
> +	/*
> +	 * With EAS and uclamp, 1 CPU in the group must be overutilized to
> +	 * consider the group overloaded.
> +	 */
> +	if (sched_energy_enabled() && !sgs->group_overutilized)
> +		return false;
> +
>   	if (sgs->sum_nr_running <= sgs->group_weight)
>   		return false;
>   
> @@ -10374,8 +10382,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   		nr_running = rq->nr_running;
>   		sgs->sum_nr_running += nr_running;
>   
> -		if (cpu_overutilized(i))
> +		if (cpu_overutilized(i)) {
>   			*sg_overutilized = 1;

Since sgs->overutilized is tracking the overutilized status, can we get
avoid passing the "sg_overutilized" pointer to update_sg_lb_stats() and
just use the sg->overutilized in update_sd_lb_stats()?

Something like below:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 857808da23d8..de4a7e19d383 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10346,14 +10346,12 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
   * @group: sched_group whose statistics are to be updated.
   * @sgs: variable to hold the statistics for this group.
   * @sg_overloaded: sched_group is overloaded
- * @sg_overutilized: sched_group is overutilized
   */
  static inline void update_sg_lb_stats(struct lb_env *env,
  				      struct sd_lb_stats *sds,
  				      struct sched_group *group,
  				      struct sg_lb_stats *sgs,
-				      bool *sg_overloaded,
-				      bool *sg_overutilized)
+				      bool *sg_overloaded)
  {
  	int i, nr_running, local_group, sd_flags = env->sd->flags;
  	bool balancing_at_rd = !env->sd->parent;
@@ -10375,7 +10373,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
  		sgs->sum_nr_running += nr_running;
  
  		if (cpu_overutilized(i))
-			*sg_overutilized = 1;
+			sgs->group_overutilized = 1;
  
  		/*
  		 * No need to call idle_cpu() if nr_running is not 0
@@ -11046,7 +11044,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
  				update_group_capacity(env->sd, env->dst_cpu);
  		}
  
-		update_sg_lb_stats(env, sds, sg, sgs, &sg_overloaded, &sg_overutilized);
+		update_sg_lb_stats(env, sds, sg, sgs, &sg_overloaded);
  
  		if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
  			sds->busiest = sg;
@@ -11056,6 +11054,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
  		/* Now, start updating sd_lb_stats */
  		sds->total_load += sgs->group_load;
  		sds->total_capacity += sgs->group_capacity;
+		sg_overutilized |= sgs->group_overutilized;
  
  		sum_util += sgs->group_util;
  		sg = sg->next;
-- 
Thanks and Regards,
Prateek

> +			sgs->group_overutilized = 1;
> +		}
>   
>   		/*
>   		 * No need to call idle_cpu() if nr_running is not 0


