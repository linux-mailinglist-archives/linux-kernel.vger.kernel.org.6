Return-Path: <linux-kernel+bounces-355583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CF9995458
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0482028A0B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2F61E0B96;
	Tue,  8 Oct 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UfbwQLy9"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73D718C922
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404711; cv=fail; b=U4ITxV769DayPXhOFhT/AWG+CQuA/7eyG2gcPNePrTlG8VsDGQAdN6V+eZ0zZ+0e16iUqcdFbDexEnISWwJNtaJoeKrtXCZzCqhptyoPZg3z2CjJZUPsCBzXQGf67mYIbPVlHQye6UzbTPhfIprfdkSQ8hKmEwzLto+OOlOMWhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404711; c=relaxed/simple;
	bh=d+tNJouMWtU/vJhpemR4X/8wE8BS7001X/dQy95ZY/k=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:CC:
	 References:In-Reply-To; b=WJZ3OTxPGDPPhJe1scQcfXTclQi4wpZ8AKTyEiHBVDwlSBQJnJY4W601mj0qOgN6Nt7hCBytDUW63XyEEQogN9X6I54oQW9pddyfzN8qk7CiWZt46GMDEQ5oy70YyoprVK2EJSqFx5yW/CT+7Q7b9bgvmKaLkcNY8bCWkH+p7nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UfbwQLy9; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLF35tpuIUxcYXg5IOJw4X4gBuF/L/Q8xB7GfPM7VAOTX2MlZBFGU5inKLtTyUBAxf575+qTYWZbyPJQn5HsfwhYi9aJrSIHV4+hOhoUXQGcGDbZtJ0gUJRtngQqvILgkje7txw062qUONKcmxEKVuzh9FpN61DREUXI6taeXjf9zYHLEf9NsVo1HOcH+DosQTxkMz/SaB5MOOaaDcSXwXSivsr8hbyeenGA+L/K96FzjolHlxLubMkPRk54KRy/DolOFC27q++GLCRJNEFk2XmH88EF/zyOa5Dp3V7X3uYGWkhGGjgoPaxPVwycZkrgzSODH8UpBLHAWFiFg7Muqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBgssSId36hPBhIK/yXM7aXU7XQjrch3BwwqklT5XxI=;
 b=McIi7hpTpIEmvGEWKBhedd4bKhHt6HDh/qeY2LIkIFHtJN18VgJGG730ekQa/fY0qoz+Q9Swh1+vLfe8vUJ9l9ld5yTLn2xe9HDLhDZdcUutD+r8g0Lt+2EAlXmTKe1boACW3r52Ia8kOX7+wt+CIfxHEwqWikbUuSEKWvCeogjg1R7PDvUDfn2VFI/3PqHeP+1LCy4JAVHOVsQ0U8PmLLISaKO4PG+oVdsm/j8IsVgkdv/ZO15XT/hPVoPzv3LjM7HnGs2dJKqmjNTnT13rOx6DP97axufe41kY6pp9RTg5EF9+mfSxr50bh3/gvqqiUHdZn/DGAXlf0jEWIjSmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=cmpxchg.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBgssSId36hPBhIK/yXM7aXU7XQjrch3BwwqklT5XxI=;
 b=UfbwQLy9u78fSS7I6zl+6dQHF3Bkvq9bJwY8oghq3v4RKNl1bzyf3jCAQryVSA05jXzFTXXl2ckrj8lzULiB2eglmp2J4N7gGXrFvX0ZA9RFVq0aV5yGlwtmbBsC6SsCaCHy1B90HYXhpfmOvN3cxCHZrS5xuDhTAlLQrhHwCrw=
Received: from DS7PR03CA0223.namprd03.prod.outlook.com (2603:10b6:5:3ba::18)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 8 Oct
 2024 16:25:06 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:3ba:cafe::f5) by DS7PR03CA0223.outlook.office365.com
 (2603:10b6:5:3ba::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 16:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 16:25:06 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 11:25:00 -0500
Content-Type: multipart/mixed;
	boundary="------------4r0sHXasv310OVc1aeiCPhUK"
Message-ID: <f82def74-a64a-4a05-c8d4-4eeb3e03d0c0@amd.com>
Date: Tue, 8 Oct 2024 21:54:52 +0530
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
 <c97da254-9add-85bb-cd46-7c0d5ac77548@amd.com>
In-Reply-To: <c97da254-9add-85bb-cd46-7c0d5ac77548@amd.com>
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6c22d5-1aea-427d-baba-08dce7b5c55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3dIZis5aXFXRUFKejJ6L2ZHbWpUNUlWU2xvelFUU0pNa1JvcWlsWE0rY3FM?=
 =?utf-8?B?NEJCRnl4aFNYQUorVmN2QjJTYTRoYkhCY1hXMENEcWlRN2VuelJpSVZpWWQy?=
 =?utf-8?B?YlRpVk9yTXJUZTN1Z3RnUDRReXoyckpBMm1lY2lzT0Exb1QrcksrRFFkZ0dW?=
 =?utf-8?B?Z3daZ05iOEo1cEt6SWt6SDVScDdiRTNyZGlXVldZanJrWWZZUjZPbWtjeUtx?=
 =?utf-8?B?Y2Jjb3ZmMVRBdnVjZElsc3FYb1l3V3FxSUtuUmtCMVo4OFdXdDQ5R2dpa21n?=
 =?utf-8?B?RHZUY0N3Y0FIS1RlWEhEWDl5bHFUSGVNV014U3BwNHRDSjlFYlpJQ2RmajRY?=
 =?utf-8?B?ME8vTVEyNkRBZDFtaUtGSk1SWTlrL3djS3JVVEhvNklrYko4NDMyR291dHZK?=
 =?utf-8?B?MjZKZ2xYckVCNnBLQkc3V21xZU85OEt6d1FLc3BHbTRNUFdVUVhVdFhPL3RE?=
 =?utf-8?B?bzlQV1ZEQ1FQa3JXd1UrbmdDWkpqN1hXdnd3ejVqY3hpUm52U1ZMdTBSdEli?=
 =?utf-8?B?SXhwaUpBTGgways3WXpOZFdVUmYra3dGd2xvZVloZUNtblJ2aHdLOHl5cW5S?=
 =?utf-8?B?UGVrZkh2STNGbGprR2k4dXY1VjY4OGlLL3l2NEdGQ2hwRSsyOEprNzhxZ2dX?=
 =?utf-8?B?b2xkVVdqK1hUNmpMYTZocTN5aFJpTGNqNVVuaVU3OW1JMkNNZXp0UGkzTEVK?=
 =?utf-8?B?djlsOUJ0M3FzUk8weVhNVEIrRS84c0JURDdFM1dmdm03eVJkV1dMQkc3OFZ4?=
 =?utf-8?B?UFExN1Y3NjRLRWs1T2xhakVGM2J2SGhXSm1qcWVlTHdMYld1dnFUclFqcG9S?=
 =?utf-8?B?M0plZkg2NHVRV2M5dW45WHJpWUNKc2FlTWRITHNPSmRjbFdpTWpOR0l0bXV6?=
 =?utf-8?B?em5adTNUZnlrT0dFZGZvbEJ5Y3ZVNllNL1BjS1VWeWZlS1JsNE0xc0VqZjRJ?=
 =?utf-8?B?bXAyZ0RlazFSQTE0R0xYWnhFY3RrcE15T2diNUdOL28wMGpjZzg4aWFEQncw?=
 =?utf-8?B?RDhLbTlPOHd4SWhYS1ZBZTdSazgwdWxaanA3dkV0Zkc1bDVDNmVzUkt5VjFx?=
 =?utf-8?B?U0krN1hYbVJMdmZKWmZJMHhxZWw2ejZ0QUF6L1hrNlBOTEZqalh1cTlJMFRx?=
 =?utf-8?B?SUc3M0c1akROZEJQUE5YQlJtcHNRZTdZVjJTRnBIUE9XUHdlOUZJb0k0cy9H?=
 =?utf-8?B?aDVSd2NLaTdnUm9BRzdxZTNaQ1RMOWFEcWRCbjZlSE9VKzQ2eW9WNkhCMkVK?=
 =?utf-8?B?VXRKVUE3ZXpGbjVnd2JXc0NUQURGOFJ1d3dVMW1KSXR1aU1hVmFDR3BXakFq?=
 =?utf-8?B?V1ZzY1VpMllBZTBwb3pXZ1laa2t5OE4vTXRMZyswcmVkUFV2dDBxK200UG9W?=
 =?utf-8?B?V0RVL0hrSDRZVGdRU3BKNldCbCtZY3pNM2tweEVUR2cxdUlDYnY1RGtOdGVH?=
 =?utf-8?B?M1AxczJYeWVQSmdZOTloR0NJa29hY24rYUIvWkRnenY4SURIUjg3RHZrUWJt?=
 =?utf-8?B?eXNwTkRYYURrb0RmSWxKS2p4UEdoZXM1ejZpVEZEMXVmYUNHTUUxcXpZNFBY?=
 =?utf-8?B?MjNUQkVGbElwRG0vei9iSlhlSFJ2ZEg1MEFSUGhpc1ZyOGRsZWR0V01BSTZQ?=
 =?utf-8?B?TTJoU2dVQTFkRDcxeFZJOC9sYzloSkNMVVpCdHhhV3pKT1piRnVaU01jT0d5?=
 =?utf-8?B?cy9VaDc4UFArQXpoR2d4bjlMeU0vTzh4dHpOUVZkMHE4R2crTm11L28rczRw?=
 =?utf-8?B?U01aS1J0Tmx0T2FCUE9DcEpMTTd0K2tqRjNYMklPa3Zzdys3K3RoSllZREZi?=
 =?utf-8?B?a2lhNy9RSFBiT0kvemh0K1M4d0tLK0FnN1JuVXlMSitRUUFrMWwyK0h4TWxh?=
 =?utf-8?Q?O6IhoYeCDdKtb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 16:25:06.4737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6c22d5-1aea-427d-baba-08dce7b5c55b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438

--------------4r0sHXasv310OVc1aeiCPhUK
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hello folks,

On 10/8/2024 9:08 PM, K Prateek Nayak wrote:
> Hello Johannes, Peter,
> 
> On 10/4/2024 10:13 PM, K Prateek Nayak wrote:
>> [..snip..]
>>>> Anyway, assuming PSI wants to preserve current semantics, does something
>>>> like the below work?
>>>
>>> This doesn't. But it's a different corruption now:
>>>
>>> [    2.298408] psi: inconsistent task state! task=24:cpuhp/1 cpu=1 psi_flags=10 clear=14 set=0
>>
>> I hit the same log (clear 14, set 0) and I tried the below changes on
>> top of Peter's diff:
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 0d766fb9fbc4..9cf3d4359994 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2012,9 +2012,10 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>>       if (!(flags & ENQUEUE_NOCLOCK))
>>           update_rq_clock(rq);
>>
>> -    if (!(flags & ENQUEUE_RESTORE) && !p->se.sched_delayed) {
>> +    if (!(flags & ENQUEUE_RESTORE) && (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))) {
>>           sched_info_enqueue(rq, p);
>> -        psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
>> +        psi_enqueue(p, ((flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)) ||
>> +                   (flags & ENQUEUE_DELAYED));
>>       }
>>
>>       p->sched_class->enqueue_task(rq, p, flags);
>> -- 
>>
>> ... but it just changes the warning to:
>>
>>      psi: task underflow! cpu=65 t=0 tasks=[0 0 0 0] clear=1 set=4
>>      psi: task underflow! cpu=31 t=0 tasks=[0 0 1 0] clear=1 set=0
>>
>> Doing a dump_stack(), I see it come from psi_enqueue() and
>> psi_ttwu_dequeue() and I see "clear=1" as the common theme. I've
>> stared at it for a while but I'm at a loss currently. If something
>> jumps out, I'll update here.
> 
> I could narrow down the crux of the matter to the fact that when a task
> is delayed, and the delayed task is then migrated, the wakeup context
> may not have any idea that the task was moved from its previous
> runqueue. This is the same reason psi_enqueue() considers only ...
> 
>      (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)
> 
> ... as a wakeup. In case of a wakeup with migration, PSI forgoes
> clearing the TSK_IOWAIT flag which seems to be the issue I encountered
> in my splat previously.
> 
> With that said, the below diff, based on Peter's original approach
> currently seems to work for me in the sense that I have not seen the
> inconsistent state warning for a while now with my stress test.
> 
> Two key points of the approach are:
> 
> o It uses "p->migration_flags" to indicate a delayed entity has
>    migrated to another runqueue and convey the same during psi_enqueue().
> 
> o It adds ENQUEUE_WAKEUP flag alongside ENQUEUE_DELAYED for
>    enqueue_task() in ttwu_runnable() since psi_enqueue() needs to know of
>    a wakeup without migration to clear the TSK_IOWAIT flag it would have
>    set during psi_task_switch() for blocking task and going down the
>    stack for enqueue_task_fair(), there seem to be no other observer of
>    the ENQUEUE_WAKEUP flag other than psi_enqueue() in the requeue path.
> 
> If there are no obvious objections, I'll send a clean patch soon.
> In the meantime, here is the diff:
> [..snip..]

That last diff was malformed! Sorry for the noise. Here is the corrected
diff:

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

Attaching an RFC patch in case I messed this up as well!

> -- 
> 
> Any and all suggestions are highly appreciated.
> 
>>
>> Thank you again both for taking a look.
>>
> 

-- 
Thanks and Regards,
Prateek
--------------4r0sHXasv310OVc1aeiCPhUK
Content-Type: text/plain; charset="UTF-8";
	name="0001-sched-psi-Fixup-PSI-accounting-with-DELAY_DEQUEUE.patch"
Content-Disposition: attachment;
	filename="0001-sched-psi-Fixup-PSI-accounting-with-DELAY_DEQUEUE.patch"
Content-Transfer-Encoding: base64

RnJvbSAyZTE1MTgwZTE4YjUxZTlhMmJjMGQ3MDUwZTkxNWE3MGQyNjczYTA2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLIFByYXRlZWsgTmF5YWsgPGtwcmF0ZWVrLm5heWFr
QGFtZC5jb20+CkRhdGU6IEZyaSwgNCBPY3QgMjAyNCAxNToyNDozNSArMDAwMApTdWJqZWN0
OiBbUkZDIFBBVENIXSBzY2hlZC9wc2k6IEZpeHVwIFBTSSBhY2NvdW50aW5nIHdpdGggREVM
QVlfREVRVUVVRQoKQWZ0ZXIgdGhlIG1lcmdlIG9mIERFTEFZX0RFUVVFVUUsICJwc2k6IGlu
Y29uc2lzdGVudCB0YXNrIHN0YXRlOiB3YXJuaW5nCndlcmUgc2VlbiBlYXJseSBpbnRvIHRo
ZSBib290LiBUaGUgY3J1eCBvZiB0aGUgbWF0dGVyIGlzIHRoZSBmYWN0IHRoYXQKd2hlbiBh
IHRhc2sgaXMgZGVsYXllZCwgYW5kIHRoZSBkZWxheWVkIHRhc2sgaXMgdGhlbiBtaWdyYXRl
ZCwgdGhlCndha2V1cCBjb250ZXh0IG1heSBub3QgaGF2ZSBhbnkgaWRlYSB0aGF0IHRoZSB0
YXNrIHdhcyBtb3ZlZCBmcm9tIGl0cwpwcmV2aW91cyBydW5xdWV1ZS4gVGhpcyBpcyB0aGUg
c2FtZSByZWFzb24gcHNpX2VucXVldWUoKSBjb25zaWRlcnMKb25seSAuLi4KCiAgICAgKGZs
YWdzICYgRU5RVUVVRV9XQUtFVVApICYmICEoZmxhZ3MgJiBFTlFVRVVFX01JR1JBVEVEKQoK
Li4uIGFzIGEgd2FrZXVwLiBJbiBjYXNlIG9mIGEgd2FrZXVwIHdpdGggbWlncmF0aW9uLCBQ
U0kgZm9yZ29lcwpjbGVhcmluZyB0aGUgVFNLX0lPV0FJVCBmbGFnIHdoaWNoIHNlZW1zIHRv
IGJlIHRoZSBpc3N1ZSBJIGVuY291bnRlcmVkCmluIG15IHNwbGF0IHByZXZpb3VzbHkuCgpX
aXRoIHRoYXQgc2FpZCwgdGhlIGJlbG93IGRpZmYsIGJhc2VkIG9uIFBldGVyJ3Mgb3JpZ2lu
YWwgYXBwcm9hY2gKY3VycmVudGx5IHNlZW1zIHRvIHdvcmsgZm9yIG1lIGluIHRoZSBzZW5z
ZSB0aGF0IEkgaGF2ZSBub3Qgc2VlbiB0aGUKaW5jb25zaXN0ZW50IHN0YXRlIHdhcm5pbmcg
Zm9yIGEgd2hpbGUgbm93IHdpdGggbXkgc3RyZXNzIHRlc3QuCgpUd28ga2V5IHBvaW50cyBv
ZiB0aGUgYXBwcm9hY2ggYXJlOgoKbyBJdCB1c2VzICJwLT5taWdyYXRpb25fZmxhZ3MiIHRv
IGluZGljYXRlIGEgZGVsYXllZCBlbnRpdHkgaGFzCiAgIG1pZ3JhdGVkIHRvIGFub3RoZXIg
cnVucXVldWUgYW5kIGNvbnZleSB0aGUgc2FtZSBkdXJpbmcgcHNpX2VucXVldWUoKS4KCm8g
SXQgYWRkcyBFTlFVRVVFX1dBS0VVUCBmbGFnIGFsb25nc2lkZSBFTlFVRVVFX0RFTEFZRUQg
Zm9yCiAgIGVucXVldWVfdGFzaygpIGluIHR0d3VfcnVubmFibGUoKSBzaW5jZSBwc2lfZW5x
dWV1ZSgpIG5lZWRzIHRvIGtub3cgb2YKICAgYSB3YWtldXAgd2l0aG91dCBtaWdyYXRpb24g
dG8gY2xlYXIgdGhlIFRTS19JT1dBSVQgZmxhZyBpdCB3b3VsZCBoYXZlCiAgIHNldCBkdXJp
bmcgcHNpX3Rhc2tfc3dpdGNoKCkgZm9yIGJsb2NraW5nIHRhc2sgYW5kIGdvaW5nIGRvd24g
dGhlCiAgIHN0YWNrIGZvciBlbnF1ZXVlX3Rhc2tfZmFpcigpLCB0aGVyZSBzZWVtIHRvIGJl
IG5vIG90aGVyIG9ic2VydmVyIG9mCiAgIHRoZSBFTlFVRVVFX1dBS0VVUCBmbGFnIG90aGVy
IHRoYW4gcHNpX2VucXVldWUoKSBpbiB0aGUgcmVxdWV1ZSBwYXRoLgoKU3VnZ2VzdGVkLWJ5
OiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+ClNpZ25lZC1vZmYtYnk6
IEsgUHJhdGVlayBOYXlhayA8a3ByYXRlZWsubmF5YWtAYW1kLmNvbT4KLS0tCiBrZXJuZWwv
c2NoZWQvY29yZS5jICB8IDIwICsrKysrKysrKysrKysrKysrLS0tCiBrZXJuZWwvc2NoZWQv
c2NoZWQuaCB8ICAxICsKIGtlcm5lbC9zY2hlZC9zdGF0cy5oIHwgMTAgKysrKysrKysrKwog
MyBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9jb3JlLmMgYi9rZXJuZWwvc2NoZWQvY29yZS5jCmlu
ZGV4IDQzZTQ1M2FiN2UyMC4uODg1ODAxNDMyZTlhIDEwMDY0NAotLS0gYS9rZXJuZWwvc2No
ZWQvY29yZS5jCisrKyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMKQEAgLTIwMDksMTIgKzIwMDks
MTkgQEAgdW5zaWduZWQgbG9uZyBnZXRfd2NoYW4oc3RydWN0IHRhc2tfc3RydWN0ICpwKQog
CiB2b2lkIGVucXVldWVfdGFzayhzdHJ1Y3QgcnEgKnJxLCBzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnAsIGludCBmbGFncykKIHsKKwlib29sIHdha2VlX25vdF9taWdyYXRlZCA9IChmbGFncyAm
IEVOUVVFVUVfV0FLRVVQKSAmJiAhKGZsYWdzICYgRU5RVUVVRV9NSUdSQVRFRCk7CisKIAlp
ZiAoIShmbGFncyAmIEVOUVVFVUVfTk9DTE9DSykpCiAJCXVwZGF0ZV9ycV9jbG9jayhycSk7
CiAKIAlpZiAoIShmbGFncyAmIEVOUVVFVUVfUkVTVE9SRSkpIHsKIAkJc2NoZWRfaW5mb19l
bnF1ZXVlKHJxLCBwKTsKLQkJcHNpX2VucXVldWUocCwgKGZsYWdzICYgRU5RVUVVRV9XQUtF
VVApICYmICEoZmxhZ3MgJiBFTlFVRVVFX01JR1JBVEVEKSk7CisKKwkJLyogTm90aWZ5IFBT
SSB0aGF0IHRoZSB0YXNrIHdhcyBtaWdyYXRlZCBpbiBhIGRlbGF5ZWQgc3RhdGUgYmVmb3Jl
IHdha2V1cC4gKi8KKwkJaWYgKChwLT5taWdyYXRpb25fZmxhZ3MgJiBERUxBWUVEX01JR1JB
VEVEKSAmJiAhdGFza19vbl9ycV9taWdyYXRpbmcocCkpIHsKKwkJCXdha2VlX25vdF9taWdy
YXRlZCA9IGZhbHNlOworCQkJcC0+bWlncmF0aW9uX2ZsYWdzICY9IH5ERUxBWUVEX01JR1JB
VEVEOworCQl9CiAJfQogCiAJcC0+c2NoZWRfY2xhc3MtPmVucXVldWVfdGFzayhycSwgcCwg
ZmxhZ3MpOwpAQCAtMjAyMyw2ICsyMDMwLDggQEAgdm9pZCBlbnF1ZXVlX3Rhc2soc3RydWN0
IHJxICpycSwgc3RydWN0IHRhc2tfc3RydWN0ICpwLCBpbnQgZmxhZ3MpCiAJICogLT5zY2hl
ZF9kZWxheWVkLgogCSAqLwogCXVjbGFtcF9ycV9pbmMocnEsIHApOworCWlmICghKGZsYWdz
ICYgRU5RVUVVRV9SRVNUT1JFKSkKKwkJcHNpX2VucXVldWUocCwgd2FrZWVfbm90X21pZ3Jh
dGVkKTsKIAogCWlmIChzY2hlZF9jb3JlX2VuYWJsZWQocnEpKQogCQlzY2hlZF9jb3JlX2Vu
cXVldWUocnEsIHApOwpAQCAtMjA0Miw2ICsyMDUxLDkgQEAgaW5saW5lIGJvb2wgZGVxdWV1
ZV90YXNrKHN0cnVjdCBycSAqcnEsIHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgaW50IGZsYWdz
KQogCWlmICghKGZsYWdzICYgREVRVUVVRV9TQVZFKSkgewogCQlzY2hlZF9pbmZvX2RlcXVl
dWUocnEsIHApOwogCQlwc2lfZGVxdWV1ZShwLCBmbGFncyAmIERFUVVFVUVfU0xFRVApOwor
CisJCWlmIChwLT5zZS5zY2hlZF9kZWxheWVkICYmIHRhc2tfb25fcnFfbWlncmF0aW5nKHAp
KQorCQkJcC0+bWlncmF0aW9uX2ZsYWdzIHw9IERFTEFZRURfTUlHUkFURUQ7CiAJfQogCiAJ
LyoKQEAgLTM3MzMsNyArMzc0NSw3IEBAIHN0YXRpYyBpbnQgdHR3dV9ydW5uYWJsZShzdHJ1
Y3QgdGFza19zdHJ1Y3QgKnAsIGludCB3YWtlX2ZsYWdzKQogCWlmICh0YXNrX29uX3JxX3F1
ZXVlZChwKSkgewogCQl1cGRhdGVfcnFfY2xvY2socnEpOwogCQlpZiAocC0+c2Uuc2NoZWRf
ZGVsYXllZCkKLQkJCWVucXVldWVfdGFzayhycSwgcCwgRU5RVUVVRV9OT0NMT0NLIHwgRU5R
VUVVRV9ERUxBWUVEKTsKKwkJCWVucXVldWVfdGFzayhycSwgcCwgRU5RVUVVRV9OT0NMT0NL
IHwgRU5RVUVVRV9XQUtFVVAgfCBFTlFVRVVFX0RFTEFZRUQpOwogCQlpZiAoIXRhc2tfb25f
Y3B1KHJxLCBwKSkgewogCQkJLyoKIAkJCSAqIFdoZW4gb25fcnEgJiYgIW9uX2NwdSB0aGUg
dGFzayBpcyBwcmVlbXB0ZWQsIHNlZSBpZgpAQCAtNjUzNyw2ICs2NTQ5LDcgQEAgc3RhdGlj
IHZvaWQgX19zY2hlZCBub3RyYWNlIF9fc2NoZWR1bGUoaW50IHNjaGVkX21vZGUpCiAJICog
YXMgYSBwcmVlbXB0aW9uIGJ5IHNjaGVkdWxlX2RlYnVnKCkgYW5kIFJDVS4KIAkgKi8KIAli
b29sIHByZWVtcHQgPSBzY2hlZF9tb2RlID4gU01fTk9ORTsKKwlib29sIGJsb2NrID0gZmFs
c2U7CiAJdW5zaWduZWQgbG9uZyAqc3dpdGNoX2NvdW50OwogCXVuc2lnbmVkIGxvbmcgcHJl
dl9zdGF0ZTsKIAlzdHJ1Y3QgcnFfZmxhZ3MgcmY7CkBAIC02NjIyLDYgKzY2MzUsNyBAQCBz
dGF0aWMgdm9pZCBfX3NjaGVkIG5vdHJhY2UgX19zY2hlZHVsZShpbnQgc2NoZWRfbW9kZSkK
IAkJCSAqIEFmdGVyIHRoaXMsIHNjaGVkdWxlKCkgbXVzdCBub3QgY2FyZSBhYm91dCBwLT5z
dGF0ZSBhbnkgbW9yZS4KIAkJCSAqLwogCQkJYmxvY2tfdGFzayhycSwgcHJldiwgZmxhZ3Mp
OworCQkJYmxvY2sgPSB0cnVlOwogCQl9CiAJCXN3aXRjaF9jb3VudCA9ICZwcmV2LT5udmNz
dzsKIAl9CkBAIC02NjY3LDcgKzY2ODEsNyBAQCBzdGF0aWMgdm9pZCBfX3NjaGVkIG5vdHJh
Y2UgX19zY2hlZHVsZShpbnQgc2NoZWRfbW9kZSkKIAogCQltaWdyYXRlX2Rpc2FibGVfc3dp
dGNoKHJxLCBwcmV2KTsKIAkJcHNpX2FjY291bnRfaXJxdGltZShycSwgcHJldiwgbmV4dCk7
Ci0JCXBzaV9zY2hlZF9zd2l0Y2gocHJldiwgbmV4dCwgIXRhc2tfb25fcnFfcXVldWVkKHBy
ZXYpKTsKKwkJcHNpX3NjaGVkX3N3aXRjaChwcmV2LCBuZXh0LCBibG9jayk7CiAKIAkJdHJh
Y2Vfc2NoZWRfc3dpdGNoKHByZWVtcHQsIHByZXYsIG5leHQsIHByZXZfc3RhdGUpOwogCmRp
ZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvc2NoZWQuaCBiL2tlcm5lbC9zY2hlZC9zY2hlZC5o
CmluZGV4IGIxYzM1ODhhOGYwMC4uMmRjMmM0Y2I0ZjVmIDEwMDY0NAotLS0gYS9rZXJuZWwv
c2NoZWQvc2NoZWQuaAorKysgYi9rZXJuZWwvc2NoZWQvc2NoZWQuaApAQCAtMTMyNiw2ICsx
MzI2LDcgQEAgc3RhdGljIGlubGluZSBpbnQgY3B1X29mKHN0cnVjdCBycSAqcnEpCiB9CiAK
ICNkZWZpbmUgTURGX1BVU0gJCTB4MDEKKyNkZWZpbmUgREVMQVlFRF9NSUdSQVRFRAkweDAy
IC8qIFRhc2sgd2FzIG1pZ3JhdGVkIHdoZW4gaW4gREVMQVlFRF9ERVFVRVVFIHN0YXRlICov
CiAKIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19taWdyYXRpb25fZGlzYWJsZWQoc3RydWN0IHRh
c2tfc3RydWN0ICpwKQogewpkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL3N0YXRzLmggYi9r
ZXJuZWwvc2NoZWQvc3RhdHMuaAppbmRleCAyMzc3ODBhYTNjNTMuLjA2YTJjNmQzZWMxZSAx
MDA2NDQKLS0tIGEva2VybmVsL3NjaGVkL3N0YXRzLmgKKysrIGIva2VybmVsL3NjaGVkL3N0
YXRzLmgKQEAgLTEyOSw2ICsxMjksMTMgQEAgc3RhdGljIGlubGluZSB2b2lkIHBzaV9lbnF1
ZXVlKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgYm9vbCB3YWtldXApCiAJaWYgKHN0YXRpY19i
cmFuY2hfbGlrZWx5KCZwc2lfZGlzYWJsZWQpKQogCQlyZXR1cm47CiAKKwkvKgorCSAqIERl
bGF5ZWQgdGFzayBpcyBub3QgcmVhZHkgdG8gcnVuIHlldCEKKwkgKiBXYWl0IGZvciBhIHJl
cXVldWUgYmVmb3JlIGFjY291bnRpbmcuCisJICovCisJaWYgKHAtPnNlLnNjaGVkX2RlbGF5
ZWQpCisJCXJldHVybjsKKwogCWlmIChwLT5pbl9tZW1zdGFsbCkKIAkJc2V0IHw9IFRTS19N
RU1TVEFMTF9SVU5OSU5HOwogCkBAIC0xNDgsNiArMTU1LDkgQEAgc3RhdGljIGlubGluZSB2
b2lkIHBzaV9kZXF1ZXVlKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgYm9vbCBzbGVlcCkKIAlp
ZiAoc3RhdGljX2JyYW5jaF9saWtlbHkoJnBzaV9kaXNhYmxlZCkpCiAJCXJldHVybjsKIAor
CS8qIERlbGF5ZWQgdGFzayBjYW4gb25seSBiZSBkZXF1ZXVlZCBmb3IgbWlncmF0aW9uLiAq
LworCVdBUk5fT05fT05DRShwLT5zZS5zY2hlZF9kZWxheWVkICYmIHNsZWVwKTsKKwogCS8q
CiAJICogQSB2b2x1bnRhcnkgc2xlZXAgaXMgYSBkZXF1ZXVlIGZvbGxvd2VkIGJ5IGEgdGFz
ayBzd2l0Y2guIFRvCiAJICogYXZvaWQgd2Fsa2luZyBhbGwgYW5jZXN0b3JzIHR3aWNlLCBw
c2lfdGFza19zd2l0Y2goKSBoYW5kbGVzCi0tIAoyLjM0LjEKCg==

--------------4r0sHXasv310OVc1aeiCPhUK--

