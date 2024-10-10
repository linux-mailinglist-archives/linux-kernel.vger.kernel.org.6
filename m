Return-Path: <linux-kernel+bounces-358821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924DE998441
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560CA284F13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155041C1AD1;
	Thu, 10 Oct 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F73tLZ0D"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1F81C1755
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557854; cv=fail; b=S45f5kouPzfTtaxUoJqpONWDq9Eksa0r0YvMoAJzrk0zWn2JCUVfIis4erk+C6lunpqtfC9Tp1xNep4HYX6CVbjLm3zchwXeUVGlM2dV1ifYq1Td9+xT8x+bySNwGFpGCd9ejHlpJviR0qNYaupt4xSQN3nqj80q86uBMutEInU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557854; c=relaxed/simple;
	bh=FYba2t4dKlAQYKJ7qC8zod0hNcYIj4Ec+zLf7nIg7ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p85+rgw0yII20sj3Ir+AXtAXpv6tSaT695pgzH1Z6sZShEMnq3hD+I55zwPOi47ZJPFoUpfsjgCLY0Q7e7NZnq2kUQ+lpRTd5teqKzRBswMo71iY4Lp4J+fQgc68hmvfOlyf/5jAh6loRNxMEE1aUE7LIDh2agF19lDIlin2OhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F73tLZ0D; arc=fail smtp.client-ip=40.107.95.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paRV3Y5IqbIPP/QuYOcT8VOx7b8qqNukAEbhJ0jJs7KLDKeHh3u5nzCJq6GBaFTVyBReVeeXJ3LGeogjUi3prXJOhTbbfjRdlhaHWmi1QlO++KNOsKUplhF/uRgasSXZhJCt8/QAABPEl1U3Cq3G9lELjFfBr0dr9O4XZx/nuWuCiK8Aa3pUJJzrf2NL+TV7cA9f4iFJqkclhIUA3Sf1WAB/+xDNCeaH8v+C1vyu85EBAM8rHFtwuatI/9phbzUro96T3ir00hRaA44gyrYubAjul1bha98KA58zj88f6krghnzmx6GPKKghJbSpxcIsMUEUvDDFeg9aJmOlEUXMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfYsR55u/JqYpOuFEm8qsFtiS+PczT9vDYZ7g0/Errg=;
 b=sD9/1BU5k/XAVD7SyJDEPNGDA+2dj/DteZjqVbeUKq2N+/zK/MUkWeiDvqd3jX3YXn9KmmawfQsxSjamsVG7iDKMv/Tl3Ee1AQGoR3xEj8+VT2m2HkOzCKSfZm1hFqAUn3hjAC+K3F2yfmsvK+NNYQcAziJ9+c+AVeR8Ebhc1Ptq7alaCxVqTmJr/upBOyQlpCokP/HrQiSW6jt9xcPFErMRbjylm8KmFuLX6ZoExLeV3D+kdjTgiH7NQrwtqYVfcMGu2K3TFY4eIRU5cgDzPxEcNLEFceBGvfpCbfjks8lszJnp4PYhVBAo3OiIkWBjVHMkPKigGbLa/veqDu6OQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfYsR55u/JqYpOuFEm8qsFtiS+PczT9vDYZ7g0/Errg=;
 b=F73tLZ0DiOpbHePOqjEBRuCHgMHi42Dcf96uwTDVGuSQhm5KL2bkWP8/6zpcLHsNzZTlA3KjU2ofd9G6nufutE/nbIENFVBEDVfwM6rQ9SAPSvxhGEKqKK5SDRKfaogSxpUcuFwNLd4ORma0S52DgTbCsYNkTtF3wS42S8FPV/4=
Received: from BN0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:e6::24)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 10:57:21 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::f1) by BN0PR03CA0019.outlook.office365.com
 (2603:10b6:408:e6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Thu, 10 Oct 2024 10:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 10:57:20 +0000
Received: from [10.136.44.56] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 05:57:15 -0500
Message-ID: <1113bd31-20f2-ca3c-9d90-0fdeb8dc2096@amd.com>
Date: Thu, 10 Oct 2024 16:27:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/3] sched/core: Fix PSI inconsistent task state splats
 with DELAY_DEQUEUE
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Suren Baghdasaryan <surenb@google.com>,
	<linux-kernel@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Klaus Kudielka <klaus.kudielka@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Youssef Esmat <youssefesmat@google.com>, "Paul
 Menzel" <pmenzel@molgen.mpg.de>, Bert Karwatzki <spasswolf@web.de>,
	<regressions@lists.linux.dev>
References: <20241010082838.2474-1-kprateek.nayak@amd.com>
 <20241010104724.GK14587@noisy.programming.kicks-ass.net>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241010104724.GK14587@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: bac314fe-7952-4229-e27e-08dce91a508a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUNOMTFRUWZ3dXJLb0JtN1RsUzlGbzE1YUVDd0F5VmZVUHVlSEx3T01iaTNG?=
 =?utf-8?B?amo4ZExWQTFiTWxhZ3IwVEZEOFlRV2RkRWpIYndFaFdGNHhBbjN6V1lFMStU?=
 =?utf-8?B?WEFhemY3MUVqTXZhY0hwTThidTFNNmdYZWVITjBmRERDS0ZRL3pzbzBmR3Vk?=
 =?utf-8?B?QTcxUUgreHd5R29pOHlReVpMMlFTWmp3RVZUMzh6azJGZWdJQnBjdUFGeXFG?=
 =?utf-8?B?RFo0YndNbDFMczFiL0hIS1pNYU5rY2NWS2RhYUZHc2pJYkxOb090UzE4WDNi?=
 =?utf-8?B?bkxiQUJQbE1GNitPckF6Wkd5eFI3aGMyQ1E4K1RDWVd3Yk5aYk5heWxtMVBl?=
 =?utf-8?B?T2Y0WDFQSHhmdy9OTGpYemJGZ3ZzRWxoK0VWT3VieE16ajNMOEQrc2pKQ1Jt?=
 =?utf-8?B?VUhXMnRHNjZwQWhJb2FCL2VLQ2IzVDZER3JvRjNKYll2R2FjYTByNU9kSUE0?=
 =?utf-8?B?MHFLUmg0Rm1VSGh4bXBlTnFJZWltZWcxNzF6NzdTdnZYMWxKVkNZYWVxd3Y1?=
 =?utf-8?B?UVJabnVMU2F6S3ZOczhta25rUXAxOWlaSkVtRTlENGFxb2wrbVY5MzhYRzFP?=
 =?utf-8?B?WHNjSTVPVUwwOTlZdjkwMDAwL2ZJK2ZtYzdCZVQ4UXdFY05SWE5zYjByWWs2?=
 =?utf-8?B?cXN0TTBteC8vd3F6dXpOWFEyaW1PaUYvSUtST0JJRVBiLyszUmhodTRSNTJl?=
 =?utf-8?B?eis2dG0rUEE5UDllTkpkYUVIOTQzdUV1SlRoSnMrMFNQc1hjMHpDWTRGZUMz?=
 =?utf-8?B?UDBKNDlsekRQbGgzU2F6U3FQcStXUWhiT3pGb1BscmNOT1dBd3NaZ0QrV1JG?=
 =?utf-8?B?bnI0L1pIZDhVQ0s1SW1MV0M2ay9HR0hNNklJK0ZLRXhwMlJJalM2aTRQWXFN?=
 =?utf-8?B?WEtaSG1pS2VkemxRbmk5RE5EUEtRc0k3dHNQTlllTG95alh5THQvRUdJbG0w?=
 =?utf-8?B?djVOQ0hzN0xNU2hrdTg2MGtxMG5GbXM4N1l4dmN1NzBSaW8zZlJvZmFtWkFx?=
 =?utf-8?B?UVI1NFh3UmUxMFdsZXloaHZ6U3hBdzFVRmozN0RhSytBenc3RUo3TGc1Uzg2?=
 =?utf-8?B?aHR4TnFUTnd0WDFuQ3J6dzNmNStzbm93bS9VRUlGVDdQOWJqZ1BUZ21tSWZJ?=
 =?utf-8?B?YitDL2o1K0FkY3BLVDNOZXN5VzRwN3RaVlBFWVFVWXNrdHJDTFJLNzFiQVhU?=
 =?utf-8?B?VHFZUjluWVNLbkc5bUhrMHBVWjhHY2RuQ0ttMFF1RWY3dklFaVc5RnZCMFpu?=
 =?utf-8?B?Nm4vanpmWnhwWWVYNzZjOThYaFpKa3BJcEhuRW8rQmp2SmsxOHc0NVA5QmNk?=
 =?utf-8?B?TW5RNmt1dkRDSHQxd1V6dlZvSUt5cmlmVFplWGR3MldVZ1I5SHpJWk1Cc0VS?=
 =?utf-8?B?dXcxdWZ2cnF6MWp1RktXUVM1MUVodDhBVFlmUVhpL1RZeUZoeGR6MTgvSUhD?=
 =?utf-8?B?bkpvbUlTOVYzRndIM2lZSmRRQWNldFJpaS8veUFseWFKbkREQUlydHdQOFFO?=
 =?utf-8?B?QXZpVE1qSHQvNklsaGNqa0JGN3VLRkRFdmdyNXFoZmI1SVI1UXVmR0RJOE52?=
 =?utf-8?B?d3gyMVhIUWpSWCs2Q3NjVy8wemZrUDVXUFlOeGptV0JtcWpCVjFmTWZQdzZQ?=
 =?utf-8?B?N1RxbkR3djVKMGZFMERjM0s2bmF4SjdBY29VNEFYbDFnKzJ6dSsxUFd4NXhB?=
 =?utf-8?B?SHIvOFl5amxFNCs3YTI2NHZkR3NXZjVlRUNXcTMzNXNDMTJ4cTNZNDhmbURK?=
 =?utf-8?B?a2xkb2hubHc0bCtrTVZ0bjNORldvUXMvS0VUS0cycDNaNmlPV2FTZUVpVGlV?=
 =?utf-8?B?eGhhZHMzT3pPUlE3NTRJNlVTeGg0UVFYaU1HbWNEN2V4bUQ0V0lyZDVSL0Q0?=
 =?utf-8?Q?Ux24ROpisRYjm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 10:57:20.8843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac314fe-7952-4229-e27e-08dce91a508a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625

Hello Peter,

On 10/10/2024 4:17 PM, Peter Zijlstra wrote:
> On Thu, Oct 10, 2024 at 08:28:35AM +0000, K Prateek Nayak wrote:
>> After the introduction of DELAY_DEQUEUE, PSI consistently started
>> warning about inconsistent task state early into the boot. This could be
>> root-caused to three issues that the three patches respectively solve:
>>
>> o PSI signals not being dequeued when the task is blocked, but also
>>    delayed since psi_sched_switch() considered "!task_on_rq_queued()" as
>>    the task being blocked but a delayed task will remain queued on the
>>    runqueue until it is picked again and goes through a full dequeue.
>>
>> o enqueue_task() not using the ENQUEUE_WAKEUP alongside ENQUEUE_DELAYED
>>    in ttwu_runnable(). Since psi_enqueue() only considers (in terms of
>>    enqueue flags):
>>
>>      (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)
>>
>>    ... as a wakeup, the lack of ENQUEUE_WAKEUP can misguide psi_enqueue()
>>    which only clears TSK_IOWAIT flag on wakeups.
>>
>> o When a delayed task is migrated by the load balancer, the requeue or
>>    the wakeup context may be aware that the task has migrated between it
>>    blocking and it waking up. This is necessary to be communicated to PSI
>>    which forgoes clearing TSK_IOWAIT since it expects the psi_.*dequeue()
>>    to have cleared it during migration.
>>
>> The series correctly communicates the blocked status of a delayed task
>> to psi_dequeue(), adds the ENQUEUE_WAKEUP flag during a requeue in
>> ttwu_runnable(), re-arranges the psi_enqueue() to be called after a
>> "p->sched_class->enqueue_task()", and notify psi_enqueue() of a
>> migration in delayed state using "p->migration_flags" to maintain the
>> task state consistently.
>>
>> This series was previously posted as one large diff at
>> https://lore.kernel.org/lkml/f82def74-a64a-4a05-c8d4-4eeb3e03d0c0@amd.com/
>> and was tested by Johannes. The tags on the diff have been carried
>> to this series.
> 
> Thanks!
> 
> I've renamed DELAYED_MIGRATED to MF_DELAYED, and made a note to go
> rename the MDF_PUSH thing to something consistent.

Ack. DELAYED_MIGRATED was coined in spur of the moment; MF_DELAYED fits
the "migration_flags" bill well.

> 
> I've stuck then in queue.git sched/urgent along with a few other fixes
> and I will hopefully push the lot into tip soon.

Thank you for picking up the patches! Let me know if there are any
surprises (there shouldn't be any after the thorough testing by
Johannes :) - thank you again for that)

--
Thanks and Regards,
Prateek

