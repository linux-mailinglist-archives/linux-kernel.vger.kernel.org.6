Return-Path: <linux-kernel+bounces-442985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B319EE508
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF2E1668C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8BE1F239D;
	Thu, 12 Dec 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HpQpc5qW"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E06259495
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003033; cv=fail; b=Oan5tIfccs0csmi7KCA1oAFBkJvG2aVGUlZr4wLXR4NxsFlJJAIn38oEmcZ07OWt3ZNMdyju1Eh4XpKrvy+7gNRtIX8TbuHo2zaKG3vahVf0G8ZZtSfCg1Ap52UDBqA++OKYOy/QTHJTqXgFGskxSj+4p3YXL+T7jHgsuv2ionw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003033; c=relaxed/simple;
	bh=EL4YF67BQTw/lr6+bQW781nt9jbBXVLQEmkYnWKk6J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A8rN9J6qE9PGK1yAh2te0Q1/yeHLYbWE3Y5MwxC1+mgrWGJVbAQ+PfhhJdrQEbIjucbA2HhkB8ap+jZ50Trf/jYf9BlUsrUB7xrQPZq5IBf2ioxYR6osEWra+OesMx2jTLQ1JyaoBy5/hV5QpnC6z+NB+x2t27pNuAUEzy0Ofw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HpQpc5qW; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQXNQiKdbHDVSWFRW/btEFQLC/FuqGYJsXg0qe9WSiK8MmtKdAtuGvRUytwG9frniZayjScgyJpT/ikIIjKyHHq8oGqEQbrWwjmmlanltVHp+3d25CPu18k7F3j5oayIuBlU1euiD3qg0zKiuZCCLNp9FbE4YgU4Gj2cI6nw0nTE8eg2/0fJAeWV//IKrBM0gO/11j0OxW/N8ErBb0f9F8RnhOH18tBXQdoLK/mpKXuXL5RBjCmXMb/fHW2HIDTs/mVQ6vVYBKfjyyW4UnZl1bEwhFRaXfxn6utipfYnT3DKRDSSjOxWP3NorsEzexDpUGZdjkX8hIJPCX/zsUuKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfN3jFriYx4MYY2KqKT4F8Zib2poGD0u1u7r8XX+cMc=;
 b=d5zUH3LuOi+1ycqd4p8QNZw98qUhb4Yl7tOK9R6kVPXCvC9KWkGzO+unThbOdo5UH2p9N23pmyUg9Iij60HI2AfycYEiBy1rdOthdA168mCp6SOIw4btwQMU5WTlN8NmydVb/dM0BXPCMXXyjPzQKcazQf6o2Jj2dA7uN9ll688gfzXmZB1twQkDfVCNj2BAgnshHqDeG+P4WeWd6sJ3cJpFXsc5+vpQUgA+c64u7D4Ox0/1UfnpRfMNzyhv3ezJ+Hawvuhki94KS72kZYWR++pR9ZfHfBDkn+b7nH+IJC/HJ2lfhjAXRI06h9C/bmHsDrNvC8Kl+MaBy8BDMcHYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfN3jFriYx4MYY2KqKT4F8Zib2poGD0u1u7r8XX+cMc=;
 b=HpQpc5qWkrWjtO2Zc57WXAbvJmfk0FSGBLES5asMUV+6tZEwEFPmL3THjwlTQEHZxXSVoy+9bQ2jCPbCFdaDbkt+I4TmsCp4rivqbKJW4fUdSkAk8uaHzm2e0fbFkFq+mPnnkoRtO4T9zjSHQc3FgoeipU9ArtA5O4TeGhgsr94=
Received: from BLAPR03CA0157.namprd03.prod.outlook.com (2603:10b6:208:32f::27)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 11:30:28 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::6c) by BLAPR03CA0157.outlook.office365.com
 (2603:10b6:208:32f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 11:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 11:30:28 +0000
Received: from [10.136.35.10] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 05:30:22 -0600
Message-ID: <9a5b069c-597a-4c65-b9f6-bfa9725817df@amd.com>
Date: Thu, 12 Dec 2024 17:00:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] sched/fair: Do not compute overloaded status
 unnecessarily during lb
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
 <20241211185552.4553-8-kprateek.nayak@amd.com>
 <CAKfTPtDQy=VfH3Ta8zLSACX7QV+LWaRvj_ueN=iSu5i4t8oBtQ@mail.gmail.com>
 <a79e0e83-d1e8-4a16-a317-599e063d4797@amd.com>
 <CAKfTPtDN2rrKVgdDxtSeFtdQkjLXV7FUx_0JmYc1Fv4FZZaLdw@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtDN2rrKVgdDxtSeFtdQkjLXV7FUx_0JmYc1Fv4FZZaLdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d60aa0e-6cc3-4ff2-db83-08dd1aa06102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG1INkVOUFRLMHlKNFROVUpIMU13MjdseXRtdGE3alkwMUtrME1uK3J4LzBJ?=
 =?utf-8?B?S0dSU3kvOUZQZWhYWThhL0EydHlVMUZCTy9CM1NjR2E0Z0xHOFJlZUFLN0hN?=
 =?utf-8?B?UCs3cjBLTUtTYWVob1R1dWdBMy9JNFcrOE01WDBSS0dIUkFDdTJpSUZ5L1JJ?=
 =?utf-8?B?eDlSL2lWMDFVSno3Q1ZoUGRxYlEvdGJVc0lYWkFwUytSdGcyRFR6dW1IWnR5?=
 =?utf-8?B?S29uZktST21yOVk4QkxtR1ozZDlYMjJjRDc4ZVphTkxhWmJhY3MzSHpCSzJh?=
 =?utf-8?B?TnA3ZlgrR0V4QWNEbUFQMEx6VHN5bUVxbEttYk1oQUlLbjBCSWVlSUQ4OEV4?=
 =?utf-8?B?bC9LMXhzYkVuVW5EMGlsZ2gxUEwwUWJYQTZ2T3dDQnphTXh6QTNISDV6am03?=
 =?utf-8?B?ZjJvY2s1cllOcVFTa3FHUnNyTmU1NEVBdWhiMHBldlprNjRCNDNqU2lyK3hl?=
 =?utf-8?B?UTVzM0N2UytHN010ZVVOWmU2Mk1ObXVYMG5janoyQ3JURUdHMS9ia2czbDlx?=
 =?utf-8?B?WnlHREZlUzhhT1dTQVJobmtlYVVnQmJDK0piRm42ejJUWGNXa2RSU0VPT3Z1?=
 =?utf-8?B?T0xaY1lYcGdTYmVyZjlSejNTVmJIeG95UE5OSFFTd09EQ2t4ZmM4a0RIQUh0?=
 =?utf-8?B?K21GN0twSTZQeSt3bGxUbWhCQkxhZis2MENEMHM3TXVJN1JCdEdLeWJnak1D?=
 =?utf-8?B?Yi9sT1lDQVlRWXdRQi80VzFOOUhkRmdYS3BGTmlkTGdWQ3VNaUl5SXcyejAw?=
 =?utf-8?B?VWwxbmxGMmRCMDI3SmxCbXA2Zk5vY2tJenArajhMNFRKcW5KOVFnalpRdmV6?=
 =?utf-8?B?c2ErdzdveUV6RWlXM3JFc2hhYUlOSDJOK1RkeW5CS0N4QitlKzZJL244K256?=
 =?utf-8?B?Z0Z4bmw4cm1QUEk1Sk54TnBBUXllaU1kQkxVMDA1VysxZWhHK215S1I4RnA5?=
 =?utf-8?B?Z1M1Wm9iWGNlaEV6OFlISnJhRGtnOThFRWNBaVdpV0h4SHNULzYva0JQUWFE?=
 =?utf-8?B?OEJxZFRhZXgwbDhkVll4YVRqYWZuSFZZeUJZWUN6ZGNIZ2p3Y1lOcXZzMzJo?=
 =?utf-8?B?QjY2TUt5U0Y3SzRTaDZ6S1F6ZGpraldYV2ZBSGZqSnUxUW91REZTNXpUUmZo?=
 =?utf-8?B?aGk4MkdpejV3OUthVlRzMkc3a0pMbjR1YWc5cmlsb0ZCTDFDcFA5NU5aVWZY?=
 =?utf-8?B?dW9WRmJBMGhuRjJPbXY1blIvWUtaQlNBdnBkSVBURlZzRjIwVWNkeDh6Nks4?=
 =?utf-8?B?NlE4UEVpSWJLV2xmcFc0Rm0vRnFNcTFEZTFrMFQxSzM1SWJ1TkVFdnBMZFEr?=
 =?utf-8?B?VGZVZk1NVFYyZlh3NENWRm1YbkY1aG9SVnNUM2FFWUdKZW41NHVHMEVGajBw?=
 =?utf-8?B?VnoxdlRsN1Z4TG52SWlXSkZ0K1hPMUNDQ3V0NmxLKytkUFpNTjdnM0R5YjAx?=
 =?utf-8?B?ZlNwR0hUVm5ISUhjUEd5cnBVZWNrdEZVcGdIaUlIeldLMGFzbzJNODh2eTl1?=
 =?utf-8?B?dUk2ZkVRYk40bFNaaFFEQzVpSFIwSWd4T00vKzZlbnJ4T3hxVFo3eVFyNUl2?=
 =?utf-8?B?QktWQW16TThWQ1hOZDc4WWFnUzUvV2ZzTVQrY2tkL3Q5ZjR1SFJ5bWpqVDFR?=
 =?utf-8?B?NEYzQ0RCczlVanNQaFFrZXlQSWxEWjRIcU9oRWF4amxpZXMzek5rdHVWbGM0?=
 =?utf-8?B?UkUyeFJpVGxqaGV5c3FOamd6QWQrR2tHVUhoa2lMazNYK1BIcFhzUTlUZ1ZU?=
 =?utf-8?B?TDJHS1NrQTdWSXNyTm5Na0dNOU5VZTNqVU82SGkvWmhlcWFnUWd2Wjg4MVdh?=
 =?utf-8?B?Z1UyOW5LUVZwM05scDNCVTVxclc2alk3SVBFUlZHWW1Pd2tkMkl5Mk5zbEVv?=
 =?utf-8?B?MWs1Q2pHbEozNkQ0Wm00Rm9Jckhrd0o4Z0YwVXFkOCtnYlZhVkhIMTVyMksr?=
 =?utf-8?Q?U/O0davwKannFAy4dzXiaLxKI5FKk2wq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 11:30:28.0520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d60aa0e-6cc3-4ff2-db83-08dd1aa06102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138

Hello Vincent,

On 12/12/2024 4:48 PM, Vincent Guittot wrote:
> On Thu, 12 Dec 2024 at 12:01, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> Hello Vincent,
>>
>> Thank you for reviewing the patch.
>>
>> On 12/12/2024 3:26 PM, Vincent Guittot wrote:
>>> On Wed, 11 Dec 2024 at 19:58, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>>>
>>>> Only set sg_overloaded when computing sg_lb_stats() at the highest sched
>>>> domain since rd->overloaded status is updated only when load balancing
>>>> at the highest domain. While at it, move setting of sg_overloaded below
>>>> idle_cpu() check since an idle CPU can never be overloaded.
>>>>
>>>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>>> ---
>>>>    kernel/sched/fair.c | 7 ++++---
>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index ec2a79c8d0e7..3f36805ecdca 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -10358,9 +10358,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>>>                   nr_running = rq->nr_running;
>>>>                   sgs->sum_nr_running += nr_running;
>>>>
>>>> -               if (nr_running > 1)
>>>> -                       *sg_overloaded = 1;
>>>> -
>>>>                   if (cpu_overutilized(i))
>>>>                           *sg_overutilized = 1;
>>>>
>>>> @@ -10373,6 +10370,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>>>                           continue;
>>>>                   }
>>>>
>>>> +               /* Overload indicator is only updated at root domain */
>>>> +               if (!env->sd->parent && nr_running > 1)
>>>
>>> nit: may be worth checking local variable 1st which should be cheaper
>>> than env->sd->parent
>>
>> What are your thoughts on passing NULL for "sg_overloaded" when calling
>> update_sg_lb_stats() at non-root domains? Would it be equally cheap to
>> do:
>>
>>          if (sg_overloaded && nr_running > 1)
>>                  *sg_overloaded = 1;
> 
> you will have to test it twice as it is also set for misfit task

Ah! True that. Local variable approach is indeed simpler.

-- 
Thanks and Regards,
Prateek

> 
>>
>>>
>>> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
>>
>> Thank you.
>>
>>>
>>>
>>>> +                       *sg_overloaded = 1;
>>>> +
>>>>    #ifdef CONFIG_NUMA_BALANCING
>>>>                   /* Only fbq_classify_group() uses this to classify NUMA groups */
>>>>                   if (sd_flags & SD_NUMA) {
>>>> --
>>>> 2.34.1
>>>>
>>
>> --
>> Thanks and Regards,
>> Prateek
>>


