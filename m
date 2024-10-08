Return-Path: <linux-kernel+bounces-355525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324E6995382
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5633E1C24CA6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1791E0DC1;
	Tue,  8 Oct 2024 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZpTe/zmB"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D771E04BF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401922; cv=fail; b=GmB2sjW7D1Hg57NSkNpIFIiwX0ntqrFLp4DtqtG4K/7rQdV9WCJRlzbCkHMhAoHNF/RZFTdvxd6l/9O3y1tjMViBKTVIHtkOYg1PQsYnXet37kAdnijmeFzsFHlwCN9TsgXN9ClFd5Bi9pNF19H9EcKUe0igfiO6zGzOdywNUSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401922; c=relaxed/simple;
	bh=MVJh6n9YPYcd6wHutlUUNQbZqSImeiyLJiYWhkXKrn8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=rownL8pS/vSXZ3rvD6R7rqGBryWY45d2GW5okpMe8o9PAwIK2660TLUx9Y4BMXlwIL9mf5dWgRV5sNQYLCX/1GGPnYgmf5X7lZowQco/Da5+1u4RSoFjyb+Ta1RzH925zRiDTMZ4yH1kFcv2d4YZ8hrp+CBXy9i6LbZef9lHO7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZpTe/zmB; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjDECoVQQVBECB39q4Xk5FXqe9JkvkuRXSiGNspamgsjlt8y9QELGx5gKrNSEPQSh3AlQDNeXRHXoKJxhf/ir1cdR0Gzx3LvVkY1jBiBOYeDD5G5b3mnahOkmC2nWB9LxvQLk9/fGRi8GPMo1S4/yxkPsFKlu2fFEy0w00Uk5LDuS2Q7ctq0ScT2RxzRm20rJC+kzFGcOnMfMQB8pgFtTUsPtiZKpVUU/wSOl2cY08AkxML99ZkTzLsum02ANbnKkPnn58e2vCkcD2JvekuGRQl4wyZ7ABftcFKdcV/dPh+ZhWgsLdEk/mgDBzPO/V2zyZnu4lvA7nwBQ23CsMao6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyC2qmVCgu6XQCks6GzBqAVvXqnEIyn/lGosaS8neVA=;
 b=oLc78LIhDJeL6ft8f/JLJB/KNcBQSSG/8wz75tTHlxcn31elTXe8tekBc1t+0f9dbTouUKRXYFCSHofW1WHNopWNlM4GkJFWqa1QMxK2m5ybKFOwUviqQlNM8G74D8gb4oQ6ymO+0Z9GSeswVo8nllqN1W5ff1EMN+l57FnBe+6dWRECw9NfQuS5kxuvtyn7Z9ILGnFYZp0JX+KGlO4hMw9nuvaCrkR3FfFphj4xRApXkxEMQKJwQOVAQgtaZoyZD6rqD1YPTZ66jPuyEm3jOkxstSb04QyeH0J/F4dB8gLCMO3vsf+N79NZtuu/FrAOTmpUXj1Cg/2V57u91IPTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=cmpxchg.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyC2qmVCgu6XQCks6GzBqAVvXqnEIyn/lGosaS8neVA=;
 b=ZpTe/zmBOkVUBPnf3PCHYmHrp3NRfocAV8/mmXjyf/VQ6YIXfushon26hwdhaPhRGk2eNBe+O3M0cdaHSAQJB67LFdiJDf2/sLNJweCB3zXwEwLuteoGsmhD/rnGvgGI0fNozIcBoHqjqhC8sTYiZblpfjCvkwNOQosYkicLkYU=
Received: from BL1PR13CA0149.namprd13.prod.outlook.com (2603:10b6:208:2bb::34)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 15:38:35 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::48) by BL1PR13CA0149.outlook.office365.com
 (2603:10b6:208:2bb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 15:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 15:38:34 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 10:38:28 -0500
Message-ID: <c97da254-9add-85bb-cd46-7c0d5ac77548@amd.com>
Date: Tue, 8 Oct 2024 21:08:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [REGRESSION] Re: [PATCH 17/24] sched/fair: Implement delayed
 dequeue
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra
	<peterz@infradead.org>
CC: Klaus Kudielka <klaus.kudielka@gmail.com>, Chris Bainbridge
	<chris.bainbridge@gmail.com>, <linux-kernel@vger.kernel.org>,
	<bsegall@google.com>, <dietmar.eggemann@arm.com>, <efault@gmx.de>,
	<juri.lelli@redhat.com>, <mgorman@suse.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <tglx@linutronix.de>, <vincent.guittot@linaro.org>,
	<vschneid@redhat.com>, <wuyun.abel@bytedance.com>,
	<youssefesmat@chromium.org>, <spasswolf@web.de>,
	<regressions@lists.linux.dev>, "Linux regression tracking (Thorsten
 Leemhuis)" <regressions@leemhuis.info>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>
References: <20240830123458.3557-1-spasswolf@web.de>
 <ZvA7n9GNoD-ipjkj@debian.local>
 <1ee5f5828e2021bf1051dc1f9b6f01a8c061ffb1.camel@gmail.com>
 <2128d714-90f7-1598-b32b-559206fce5de@amd.com>
 <20241004123506.GR18071@noisy.programming.kicks-ass.net>
 <20241004135744.GB1658449@cmpxchg.org>
 <fae14e09-cd35-5feb-c3b4-8318a76b26a3@amd.com>
In-Reply-To: <fae14e09-cd35-5feb-c3b4-8318a76b26a3@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a59048-31c2-4c32-7a45-08dce7af4547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S081bWFiRGNZOHJSVTJ0ZTRzbVdRek1sdlZ5NDhBZ2FJYndldThuazl2NkhH?=
 =?utf-8?B?OUpWVWczM2hLaFRaNFVSdHVuR1crZndmazYvRVlVeTRNaWw2Rk0vcitoRUNJ?=
 =?utf-8?B?TWl2bjhVNzVncGF2Y25lQnJaQVF0VnBtOWI4THZydEs1SjU5YnJFanFYQjlo?=
 =?utf-8?B?azF4OUp5bmlHY2gydHk2MEZOZnEzbVExMTRESDFPTjJDdkVKSVJBb3pDRDdD?=
 =?utf-8?B?SEhhUTAyK3F0K2xkd0FFUWk5WU1ZQ3ZMb1NqeFJKMUk0VWlScnM1NkdQczVT?=
 =?utf-8?B?YzVmZlN6cjBobmkrUm5GOXMzL01WNEJqRzRnODNkdU95Wm4zRUdlVk1uQmpD?=
 =?utf-8?B?bFFWLzZScCs5ZVZkTVk0aGxkcDZQNmRNSTIxTzRRWEdMcGdtTkRQS0N6dUNk?=
 =?utf-8?B?UUEvVE10cGJ5aUZlRC9TZ3pwcnZZVC9kM1pObmVFUUdPY0ttckFDRmRZNnRG?=
 =?utf-8?B?cUM4enk1bU9SR2o3dkFOVG5uZEllNnYyaG5iV0ZkbnJQOGl1eDdnN3JqamhT?=
 =?utf-8?B?YnRkUDhiS2lCa1RYSEVsbFhtRXdCbTNmMS9xQlBJKzFkenlrR1hBcjQzS1hr?=
 =?utf-8?B?Q1lHdm02YTNROUNxa21yR2JwbWFCbHNtRmJIUDdpK3pmQnZRZ2l2VTlDdll3?=
 =?utf-8?B?SmxCZ0dqTHlBaGM5Rk9ucFFWYWozU1ppelBrRlAyTXJuM3hmeERueHpOYnRR?=
 =?utf-8?B?bDF0a091VDNHdVNENDZKZDMvTG5wbjZSdnYyTjR3TnBrU0pVUXJtSm5manA5?=
 =?utf-8?B?TzYwYXhtZ0FuelRwSTFMT3VZeUJhVmQ4Ymo4UGJ3OXZkSGp2OU5xREZsV0hY?=
 =?utf-8?B?bkFDeWZFV0EzQ3NqalZseFU5ZHE0MVUwQ1lrcTFKUVVIaUQ4enp4T1czR2Vp?=
 =?utf-8?B?NUp6VXk4SytqVVJqSG9vZkYycGp4OUNueHlpM1N6WEhpRkU1QllpVzhWYndY?=
 =?utf-8?B?MG12VjBEQ21ZWEY2V2lHVXJHSWtjSDFSQllqc1NnN3hCVzNuN3JJY3kzdFV1?=
 =?utf-8?B?c3NDUVFnUGo2UlNxTFVjQitLTUNaaW1mN2pia1NEeUdYY2lyd1hFOThDaW1w?=
 =?utf-8?B?MEl6TmhWb2VKRXI0ckw0SDRxbGRiQUZ0d1JFUjQ4aElTZVZtYWFrWDZVN1BU?=
 =?utf-8?B?SDY4VDhUUmZyako0OFZGWWNBdjdsa1pvcEJFY3lkTWprQ3ZvNFVGd1h5RWZp?=
 =?utf-8?B?QVV2UGJOOWhQMDVYRU9WQ3RNSzhVaGdjT1hPcWxobGJQMXJVazV5OW5CT2Q3?=
 =?utf-8?B?dmJ1TDRaTmpNVmZUYXBJSGZjdlUzR3RjTU1ENStDT2tId01FNnAzNlpmT3c3?=
 =?utf-8?B?cFFRZWpWRUFaVmpxaGZVZWRnSmRVeDRaVlFoTm5kREZ3Z0hUNGFZbmxHMGJl?=
 =?utf-8?B?L2tKSVpaSUU2SU85d3BMeFI5Y3pwMU4vZG5JOVpOMVAvM01UMzBhamlpYWxW?=
 =?utf-8?B?RGR3eGFaQnZNK3lOVGM1TzUzTU1kUVVvYWxQajRKNFRNUzlkd2FJaFMxRWNq?=
 =?utf-8?B?c0xIMG54YXdQUnhoM2ExL3RSYkUzMDNyQlhTTHluRTRXa2NtUkhESUZXaHdT?=
 =?utf-8?B?eWVPMWRSRU42UnJTZll6dmpGM0JnYS85Wnd0UTdSalNyZVN2amdUSzdQMUlh?=
 =?utf-8?B?ejI1RlM0LzZ3cnppam8rUHc1NEowMEM2L1hhYngzWmlVeGo4VWlQT09LMnd6?=
 =?utf-8?B?cTU1bVFDeFdka24xcVJSejBPbGRsdCtSdHozbmZ2SlRxbFprKzQxUjhwTll0?=
 =?utf-8?B?aW1HM2V0UC9pVFAxRjBVYXlQb3hSTVhVaFh5ZVRHckEwdmZlRzFxOGsvNCtN?=
 =?utf-8?B?dnpNa3JLSW1GWWJFcUEvZjBqL0lUV09VZjNFb1pBZFdTbVJoL0VYb1hzN1lS?=
 =?utf-8?Q?2RyHBCDEA+xvM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:38:34.5966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a59048-31c2-4c32-7a45-08dce7af4547
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295

Hello Johannes, Peter,

On 10/4/2024 10:13 PM, K Prateek Nayak wrote:
> [..snip..]
>>> Anyway, assuming PSI wants to preserve current semantics, does something
>>> like the below work?
>>
>> This doesn't. But it's a different corruption now:
>>
>> [    2.298408] psi: inconsistent task state! task=24:cpuhp/1 cpu=1 psi_flags=10 clear=14 set=0
> 
> I hit the same log (clear 14, set 0) and I tried the below changes on
> top of Peter's diff:
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0d766fb9fbc4..9cf3d4359994 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2012,9 +2012,10 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>       if (!(flags & ENQUEUE_NOCLOCK))
>           update_rq_clock(rq);
> 
> -    if (!(flags & ENQUEUE_RESTORE) && !p->se.sched_delayed) {
> +    if (!(flags & ENQUEUE_RESTORE) && (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))) {
>           sched_info_enqueue(rq, p);
> -        psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
> +        psi_enqueue(p, ((flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)) ||
> +                   (flags & ENQUEUE_DELAYED));
>       }
> 
>       p->sched_class->enqueue_task(rq, p, flags);
> -- 
> 
> ... but it just changes the warning to:
> 
>      psi: task underflow! cpu=65 t=0 tasks=[0 0 0 0] clear=1 set=4
>      psi: task underflow! cpu=31 t=0 tasks=[0 0 1 0] clear=1 set=0
> 
> Doing a dump_stack(), I see it come from psi_enqueue() and
> psi_ttwu_dequeue() and I see "clear=1" as the common theme. I've
> stared at it for a while but I'm at a loss currently. If something
> jumps out, I'll update here.

I could narrow down the crux of the matter to the fact that when a task
is delayed, and the delayed task is then migrated, the wakeup context
may not have any idea that the task was moved from its previous
runqueue. This is the same reason psi_enqueue() considers only ...

     (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)

... as a wakeup. In case of a wakeup with migration, PSI forgoes
clearing the TSK_IOWAIT flag which seems to be the issue I encountered
in my splat previously.

With that said, the below diff, based on Peter's original approach
currently seems to work for me in the sense that I have not seen the
inconsistent state warning for a while now with my stress test.

Two key points of the approach are:

o It uses "p->migration_flags" to indicate a delayed entity has
   migrated to another runqueue and convey the same during psi_enqueue().

o It adds ENQUEUE_WAKEUP flag alongside ENQUEUE_DELAYED for
   enqueue_task() in ttwu_runnable() since psi_enqueue() needs to know of
   a wakeup without migration to clear the TSK_IOWAIT flag it would have
   set during psi_task_switch() for blocking task and going down the
   stack for enqueue_task_fair(), there seem to be no other observer of
   the ENQUEUE_WAKEUP flag other than psi_enqueue() in the requeue path.

If there are no obvious objections, I'll send a clean patch soon.
In the meantime, here is the diff:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..885801432e9a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2009,12 +2009,19 @@ unsigned long get_wchan(struct task_struct *p)
  
  void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
  {
+	bool wakee_not_migrated = (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED);
+
  	if (!(flags & ENQUEUE_NOCLOCK))
  		update_rq_clock(rq);
  
  	if (!(flags & ENQUEUE_RESTORE)) {
  		sched_info_enqueue(rq, p);
-		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
+
+		/* Notify PSI that the task was migrated in a delayed state before wakeup. */
+		if ((p->migration_flags & DELAYED_MIGRATED) && !task_on_rq_migrating(p)) {
+			wakee_not_migrated = false;
+			p->migration_flags &= ~DELAYED_MIGRATED;
+		}
  	}
  
  	p->sched_class->enqueue_task(rq, p, flags);
@@ -2023,6 +2030,8 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
  	 * ->sched_delayed.
  	 */
  	uclamp_rq_inc(rq, p);
+	if (!(flags & ENQUEUE_RESTORE))
+		psi_enqueue(p, wakee_not_migrated);
  
  	if (sched_core_enabled(rq))
  		sched_core_enqueue(rq, p);
@@ -2042,6 +2051,9 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
  	if (!(flags & DEQUEUE_SAVE)) {
  		sched_info_dequeue(rq, p);
  		psi_dequeue(p, flags & DEQUEUE_SLEEP);
+
+		if (p->se.sched_delayed && task_on_rq_migrating(p))
+			p->migration_flags |= DELAYED_MIGRATED;
  	}
  
  	/*
@@ -3733,7 +3745,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
  	if (task_on_rq_queued(p)) {
  		update_rq_clock(rq);
  		if (p->se.sched_delayed)
-			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
+			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_WAKEUP | ENQUEUE_DELAYED);
  		if (!task_on_cpu(rq, p)) {
  			/*
  			 * When on_rq && !on_cpu the task is preempted, see if
@@ -6537,6 +6549,7 @@ static void __sched notrace __schedule(int sched_mode)
  	 * as a preemption by schedule_debug() and RCU.
  	 */
  	bool preempt = sched_mode > SM_NONE;
+	bool block = false;
  	unsigned long *switch_count;
  	unsigned long prev_state;
  	struct rq_flags rf;
@@ -6622,6 +6635,7 @@ static void __sched notrace __schedule(int sched_mode)
  			 * After this, schedule() must not care about p->state any more.
  			 */
  			block_task(rq, prev, flags);
+			block = true;
  		}
  		switch_count = &prev->nvcsw;
  	}
@@ -6667,7 +6681,7 @@ static void __sched notrace __schedule(int sched_mode)
  
  		migrate_disable_switch(rq, prev);
  		psi_account_irqtime(rq, prev, next);
-		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
+		psi_sched_switch(prev, next, block);
  
  		trace_sched_switch(preempt, prev, next, prev_state);
  
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b1c3588a8f00..2dc2c4cb4f5f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1326,6 +1326,7 @@ static inline int cpu_of(struct rq *rq)
  }
  
  #define MDF_PUSH		0x01
+#define DELAYED_MIGRATED	0x02 /* Task was migrated when in DELAYED_DEQUEUE state */
  
  static inline bool is_migration_disabled(struct task_struct *p)
  {
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 237780aa3c53..06a2c6d3ec1e 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -129,6 +129,13 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
  	if (static_branch_likely(&psi_disabled))
  		return;
  
+	/*
+	 * Delayed task is not ready to run yet!
+	 * Wait for a requeue before accounting.
+	 */
+	if (p->se.sched_delayed)
+		return;
+
  	if (p->in_memstall)
  		set |= TSK_MEMSTALL_RUNNING;
  
@@ -148,6 +155,9 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
  	if (static_branch_likely(&psi_disabled))
  		return;
  
+	/* Delayed task can only be dequeued for migration. */
+	WARN_ON_ONCE(p->se.sched_delayed && sleep);
+
  	/*
  	 * A voluntary sleep is a dequeue followed by a task switch. To
  	 * avoid walking all ancestors twice, psi_task_switch() handles
--

Any and all suggestions are highly appreciated.

> 
> Thank you again both for taking a look.
> 

-- 
Thanks and Regards,
Prateek

