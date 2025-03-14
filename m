Return-Path: <linux-kernel+bounces-561919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEC0A61895
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D40E7A5F74
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61C2202C55;
	Fri, 14 Mar 2025 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xLAmYGsE"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F4574BE1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974753; cv=fail; b=h/f8x0r5bezeDTHjtcExKHv57IVLmVHIqwqpSMLOQCVJAGPhdi5qVG/+v/zNb3AOl++9vAZuPi1BQnfnmDrW7JkoZSY9zh2g9L56TtuI9bgJulrNNWC6X845aN5Kvb/wXFqAhgweFBpZz19iEOoKIu1q5OOwQpe5ORDiaGjcgnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974753; c=relaxed/simple;
	bh=dLS3V/scrfPZlAYBsCgeI/h9jqbEkS7zBl9MUqvaO4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ekf3+MgdH5F50solRfeuuGiknA+lp+LRvX6DH87Yb+y5DVMIpWtNqeI0DwL2Mmw+8fut3FYGNjJJcJt6yvljuTQBtPOGigewZXwdyV+g2j8JTQ+D3qb8EXqp8CpwI8hKFLxdKV9clP7oyq3EkhCKjJrpK1L3tMyrDAYABo781Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xLAmYGsE; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4g7M7oL2FX3rCQXE7UBH/+0V5isxABLehVeEdZCGc00rBrs0o6TCKHyo1MU3fWmCpd4R1xRziGUivZy6AgbWTtZeigq9zGLZ2KHMCEyY5Ysi7qz8p1qkM1VtlH7Txg7lfhGoYn49VBpZ6jA5SaIIdbzgyOLK3W5rKCoJyOi3K1IynjatQaNDS7JI3SGRPh4ARPjJMNT6+J5SCqEixAAF4jK9EEy3Wu+UIR3yaRT05x/onQwwznlrxWR8OcChVD83Ww80c9SelG+vsT1XSK1qC/yCE30rUFXyPcobfJajVYkt8dJbAGIbQ7N03OOEA+U6VBpnMQ2CtLmvSXVCidrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZ7Z6/0kuCApUoj2MZLtte2muGU/KY3vhmsVxpRlvMU=;
 b=oGfhLC3ZszvupSkreCrC44xPvYtxbsjP/I8tQxU2pojQT3CMd0dkt/1im9ZPod/YTKGcmE2bR19VqsFSdmlPR7p4f48Py2na2QMwlnKC5yIEu8P+SQj7ioeCoctAUlLn8rlmY9HEZR0BB56pye120CAqDwslMmVAbMHn8F2ntETrpU9XSjeLwgfqE+SEhqp4smOpmaX3iV9fzfViO/tzxS5d8IIQD7Ftk/pO0tYzW6ucmv1IJotgBZMwYUaVXZzd4//O9mNmLYIn0UukZhGRPCteD6bi0pPQpv53WdI5RON/4+MWFbiHbK24dtGhUiacqMhNV0paeXTMkvFZUC+p+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ7Z6/0kuCApUoj2MZLtte2muGU/KY3vhmsVxpRlvMU=;
 b=xLAmYGsEz1PcYH7SsJGX9Edhub85F4+5rCaDFvvRDxeduWN/CxLZNAZUmp+sdPjW+QjobAmG4BKnohRzLfJTY1xrRC5CgjcVPWM7km0R5Lqm2i8HULJqmiyDXO9kFLJJxzYc5HrDk4aFv4OEUbqYtL4RLa9qhmBl3BtkWti2ibA=
Received: from SJ0PR13CA0199.namprd13.prod.outlook.com (2603:10b6:a03:2c3::24)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 17:52:27 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::cf) by SJ0PR13CA0199.outlook.office365.com
 (2603:10b6:a03:2c3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Fri,
 14 Mar 2025 17:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 17:52:26 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 12:52:22 -0500
Message-ID: <dd749cb4-fcf7-4007-a68e-3ca405925e9d@amd.com>
Date: Fri, 14 Mar 2025 23:22:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/7] sched/fair: Handle unthrottle path for task based
 throttle
To: Aaron Lu <ziqianlu@bytedance.com>
CC: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Josh Don <joshdon@google.com>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	<linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>, Chengming Zhou <chengming.zhou@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcAic5QThYG-r9CaXPgZtXJuB0RuCW5Y0SyBn7VyOQi=g@mail.gmail.com>
 <3fdb7163-d1f0-45c8-89fa-7c904b567696@amd.com>
 <20250314104315.GE1633113@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250314104315.GE1633113@bytedance>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bbe055-1802-4315-f752-08dd6320fbbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXFoaWdUS3RoNEFSWFJIemRFQTJmT1FzYzFEdjBMb2lFNFRwQVFrejJzL2lL?=
 =?utf-8?B?L0NqaVMwNnpQUkVKWHRmd2ZZTDg4eGZ3cE5abGJ3NjJhTTZIVmkyNFRHMVRq?=
 =?utf-8?B?WjM5bG9hMTB1dG5La3o5L214RlVJT043NnJTWGxLSmJ3NHY1ZGpxMll2ek05?=
 =?utf-8?B?Sk43M2JSdnhWT0YrQ1JzVDVsemhpRzJqcm05KzBjZ2ZaVzAvdU1lcUg2bEdy?=
 =?utf-8?B?dnJZUXZpUHMyVlFvTXdXb3NlZ0t6QzNkd0tSbFB3cUw3TzE1ZGpIK3pQdzdB?=
 =?utf-8?B?RDlYL3kvZTB3cHVobnFibXNGbXVMakFmc29UYXZLSzRib05CVlQrYkc2RVRi?=
 =?utf-8?B?UHczb2xBSyszVXVid2lFY3RkcUJkRG5XL2dpQkh5MGNoc1JBYUdmSHFPZXhq?=
 =?utf-8?B?VWxPRWZrMHBRWGR1T3RibGdzSEZNV3p5L0JwTmxTT3pEaks0aGlmY3F1MDhn?=
 =?utf-8?B?S0xsQ1QwKzI0SlBvOC9QdDNPb2h4NmgzWVlvZElvRmgwclNwMWEwNTZYQ1dm?=
 =?utf-8?B?QXU1cjNnNEk0NlhKTTloU1JNcUhzSE5QN0EyT3VLQnluZFc0SFJNeU1IMUkz?=
 =?utf-8?B?N01LZkV3RFlqNnA3K1NWRFlkNXRCT1pwWnRQWkJyNVNJZC9wSU5udGsrczB1?=
 =?utf-8?B?ZFJyb1FGalQrRjFwYURlaDNzajlWM0ZqcUlJOEtIR09TUWdzZktnYUs3T1h5?=
 =?utf-8?B?RTFVdVN6NmNQK3phNWNxclk5SEtpT3RQVkhubHVnQXpIbjd0ZFJsd055UUNP?=
 =?utf-8?B?RkRNdzYxV3pleTQwMkUyVWZrUFdmUm5TQWdLbFI5S0N3Y2R6TzFrYmpwUzZN?=
 =?utf-8?B?WVlPa0JQeC9Xd0JaYmRhT0NrMWdGYWg1Sy9TZ0djaEt5Zm5mMzB5blYvYlBC?=
 =?utf-8?B?Z3hpMWFpRzJMaU1wUmZUZVN4djJraFVJNkRzK3ptNkRsMlRVbjRVSjloaGdh?=
 =?utf-8?B?cXZyd2lSUHpqWUdLMUg5KzdEaXovT3FHNDYxd2o3S2hBWkRKdEdMNnp0Slh0?=
 =?utf-8?B?aFRTREpIMS90blhoNW1tSE9RL3R1QVJOYTU2clRGSXovZ0ZvTG8zdk5RU2M0?=
 =?utf-8?B?WlRCVDd1OVh0a0lqNHBnYVdQUXpoZ1FvOGo2bHQ3OVF2NnU5a3hLWGJaTmEx?=
 =?utf-8?B?TXdpTUxCZmM2a2tLQlRnazlKTFcrYmlQNXNCcHdRdDBtWDU3U2RjUzd0cUR6?=
 =?utf-8?B?dHpCMDF0RzlhaFpISUV0dUh6OHlhRWl0d0oyRXNvVlhvSXJzdExjdnNrSWFI?=
 =?utf-8?B?Wk1VcDVadzFLYlJjcGw0QWprQmdORElBQU11dXRDUnRkWXpvbjlXeGh2WTNk?=
 =?utf-8?B?L2R1elpETWJtelRXNVArVUovd0QzVHdTTGpLaGR3Wm5zQWpWRlE2aTlUQzJO?=
 =?utf-8?B?MmxMNWV3eGZrMFg1cGRSSDNEVFozMFg0UW9MbElZUVovbldFR3BiWFg5djZD?=
 =?utf-8?B?UTNUQjBmS09YWFoyc3lhUHdXWlpkdmdEL3pORDFkSTRyYXM0YXpQYWNjR08z?=
 =?utf-8?B?UUlZNmtUdFZvY2pTbVBHMU9JbnNmM2JTVGxvSjhWNlYyVUprSlcwRXgxREFM?=
 =?utf-8?B?aVFhckJ2anNpQWxUNjhtdC9admFZb0l0UFgzU29zMUlHeXJ3dlZ2elA2R3Nn?=
 =?utf-8?B?bllWaU9kK3pQMVBqdE05YnRwU0ZzYmJGa05jY0RERHFNb3diMUlqOCtMNU5I?=
 =?utf-8?B?Tk9SL2crNHd5MmNqd05vUm5XZmRYTGxJUXQ3d1RJRTE4ZXNXVm1HTUcvYkU1?=
 =?utf-8?B?SXA3azR5K0xzS1JpZjViSFBOWWxrUDJNV0REcWwzVnlpVkVtT0ZaTW9pUmxJ?=
 =?utf-8?B?eit2bmRrRjA1dmpCSERQYTNFRXNES1Y2UUtVTXpLaGVsQUlRaUdWVSswREFP?=
 =?utf-8?B?WkVBQVlRRnNqajZCOWkvQ1IyRE1TMjVYb3BkRGd2QnFaZ0xEMkJPTFJjS01v?=
 =?utf-8?B?UnZkeTFLaVMvWUNwc3BTcFJkcFdZNHAvcFhYN3ZSMVdjK2NET0hPbkQwMjc2?=
 =?utf-8?Q?8Gc5Mlh5jUVmP0UhYQuXQV9SJ7BtSs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 17:52:26.8706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bbe055-1802-4315-f752-08dd6320fbbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489

Hello Aaron,

On 3/14/2025 4:13 PM, Aaron Lu wrote:
> On Fri, Mar 14, 2025 at 09:23:47AM +0530, K Prateek Nayak wrote:
>> Hello Aaron,
>>
>> On 3/13/2025 12:51 PM, Aaron Lu wrote:
>>
>> [..snip..]
>>
>>> ---
>>>    kernel/sched/fair.c | 132 +++++++++++++++-----------------------------
>>>    1 file changed, 45 insertions(+), 87 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index ab403ff7d53c8..4a95fe3785e43 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -5366,18 +5366,17 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct
>>> sched_entity *se, int flags)
>>>
>>>    	if (cfs_rq->nr_queued == 1) {
>>>    		check_enqueue_throttle(cfs_rq);
>>> -		if (!throttled_hierarchy(cfs_rq)) {
>>> -			list_add_leaf_cfs_rq(cfs_rq);
>>> -		} else {
>>> +		list_add_leaf_cfs_rq(cfs_rq);
>>>    #ifdef CONFIG_CFS_BANDWIDTH
>>> +		if (throttled_hierarchy(cfs_rq)) {
>>>    			struct rq *rq = rq_of(cfs_rq);
>>>
>>>    			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
>>>    				cfs_rq->throttled_clock = rq_clock(rq);
>>>    			if (!cfs_rq->throttled_clock_self)
>>>    				cfs_rq->throttled_clock_self = rq_clock(rq);
>>
>> These bits probabaly need revisiting. From what I understand, these
>> stats were maintained to know when a task was woken up on a
>> throttled hierarchy which was not connected to the parent essentially
>> tracking the amount of time runnable tasks were waiting on the
>> cfs_rq before an unthrottle event allowed them to be picked.
> 
> Do you mean these throttled_clock stats?
> 
> I think they are here because we do not record the throttled_clock for
> empty cfs_rqs and once the cfs_rq has task enqueued, it needs to record
> its throttled_clock. This is done in commit 79462e8c879a("sched: don't
> account throttle time for empty groups") by Josh. I don't think per-task
> throttle change this.
> 
> With this said, I think there is a gap in per-task throttle, i.e. when
> all tasks are dequeued from this throttled cfs_rq, we should record its
> throttled_time and clear its throttled_clock.

Yes but then what it'll track is the amount of time task were running
when the cfs_rq was on a throttled hierarchy. Is that what we want to
track or something else.

The commit log for 677ea015f231 ("sched: add throttled time stat for
throttled children") says the following for "throttled_clock_self_time":

     We currently export the total throttled time for cgroups that are given
     a bandwidth limit. This patch extends this accounting to also account
     the total time that each children cgroup has been throttled.

     This is useful to understand the degree to which children have been
     affected by the throttling control. Children which are not runnable
     during the entire throttled period, for example, will not show any
     self-throttling time during this period.

but with per-task model, it is probably the amount of time that
"throttled_limbo_list" has a task on it since they are runnable
but are in-fact waiting for an unthrottle.

If a task enqueues itself on a throttled hierarchy and then blocks
again before exiting to the userspace, it should not count in
"throttled_clock_self_time" since the task was runnable the whole
time despite the hierarchy being frozen.

> 
>>
>> With per-task throttle, these semantics no longer apply since a woken
>> task will run and dequeue itself when exiting to userspace.
>>
>> Josh do you have any thoughts on this?
>>
>>> -#endif
>>>    		}
>>> +#endif
>>>    	}
>>>    }
>>>
> 
>>> @@ -5947,12 +5967,16 @@ static int tg_throttle_down(struct task_group
>>> *tg, void *data)
>>>
>>>    	/* group is entering throttled state, stop time */
>>>    	cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
>>> -	list_del_leaf_cfs_rq(cfs_rq);
>>>
>>>    	SCHED_WARN_ON(cfs_rq->throttled_clock_self);
>>>    	if (cfs_rq->nr_queued)
>>>    		cfs_rq->throttled_clock_self = rq_clock(rq);
>>>
>>> +	if (!cfs_rq->nr_queued) {
>>> +		list_del_leaf_cfs_rq(cfs_rq);
>>> +		return 0;
>>> +	}
>>> +
>>
>> This bit can perhaps go in Patch 2?
> 
> I kept all the changes to leaf cfs_rq handling in one patch, I think it
> is easier to review :-)

Thank you! That would be great.

> 
> Thanks,
> Aaron
> 
>>>    	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
>>>    	/*
>>>    	 * rq_lock is held, current is (obviously) executing this in kernelspace.

-- 
Thanks and Regards,
Prateek


