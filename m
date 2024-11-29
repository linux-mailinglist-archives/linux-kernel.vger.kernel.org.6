Return-Path: <linux-kernel+bounces-425222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D24A9DBF0D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4393A164B03
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C124155325;
	Fri, 29 Nov 2024 04:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j8zbglSi"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F7D154BE0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732854511; cv=fail; b=PCiXi9/qMU8zdBrTTOoi4Jdk7vx+gwSWhfP4yJw0bIMsZWa6TJpJe+I5tBEFIWrP76qnrgXfemFLHhgCD4D2WBlGfFhs6J5iggH2x/TtiH7Ktkb8BzBq1NZTHw2hSEz2CthOISBJxzBZ7L/dlPJKc4NCY7hM3L2iXsYRBdJJ7/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732854511; c=relaxed/simple;
	bh=7kVcFUF1MaW8PYGoy98K6vBAPv0EV/vXf//gLZvz7Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aC5GBlieH0E/k6MeBdB1l/ahr9IrzaBQzTVgvvFa2AormlsCKq5/up+Rh1VO8Pgx/W5ySypEwQ+bvZF0GfzP0GA72fPrtqTYRNgZehACuV0UgeSSplP1gIAjDc/P6zwk/w36gZyzfGqEtFsb3qpKdVw7nkUnsc+2HAw+cvTS6Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j8zbglSi; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEixYjjp+l3ygOko+6ABq5GlXC2pO5gywmxJPXuOFhBNA9fwM7dMt5VzbqbNXnYHyRwOj/5f8adFjA15zLdBHca6I8i3HId+IU+SJfSufl06T0dR7vHGzlkn42pzFdiwVEr3JiHKMiKM4ICRaMLU6qH2BL3gqFOe9fhhCdk7cuae7hgk3+LjdUdgFDev85/QGvu72UaJM3tciO9F9FZOCGborvs9d+7OH43rlX5YtS3YOhzJOTtmIi1bLF4QTZEHqw20uq2gidp0pb90CDk5QB9mqcNdyyqrXHeSouw8A31meMWq+AGwyYsiBXm1+r+4jZ0L/6xh7C/kkXO619D0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2Yl10rsxiuYeUuuse0FbXwBCBUIXF529wIp5RC7R58=;
 b=S/kjbNbs/Nq6RKg234UbpN+Ud1ipzKva0uGOSo5HlfZY+p4dEW0pPFCXynemfAZs2K8F4VWjfOCCKCI6qGvusT1ZMtasfQSl8CzbBJzNooZ9F+wAE5JwYjLCjsAI3X7NqbglizBes/c0LHekpipeZzF1HmK2tgDF5TM2VVGhS9H62CYjDFI3bpj41o8PQ+NVm/YxMwZTdjJqochP+/Zo8R4ysndpYaoBM5a0M3xSvn8lDhbPfnOYqyKOWIngLponU0blHiTod29j4B7FXtVmOyNuERNAbRWaq92NqdTP8RVajbcYA3QUNMdmhTl3FeZ6hMibBbEYIoEukDGlfDU1Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=os.amperecomputing.com
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2Yl10rsxiuYeUuuse0FbXwBCBUIXF529wIp5RC7R58=;
 b=j8zbglSikG2F5B8wyfIJvo3ClIAa/UI/QYN5PG/loPqCj3oaOvEgEo3RTDMEja51GEyyMXs7RDhqexEC23jhbbISAoajqIGJtn6mfPPdwYp0uDw4jGNzPzMEFSaX7/jh5Xc/KjGZNsK5DSO+9ArBdz1BJhRcS5lyPZ0LkboHO2I=
Received: from BL1PR13CA0224.namprd13.prod.outlook.com (2603:10b6:208:2bf::19)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 04:28:25 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::70) by BL1PR13CA0224.outlook.office365.com
 (2603:10b6:208:2bf::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend Transport; Fri,
 29 Nov 2024 04:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Fri, 29 Nov 2024 04:28:24 +0000
Received: from [10.136.33.212] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 22:28:19 -0600
Message-ID: <d16cc372-b4ae-473f-bf86-83469fbead99@amd.com>
Date: Fri, 29 Nov 2024 09:58:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] sched/fair: Fix warning if NEXT_BUDDY enabled
To: Adam Li <adamli@os.amperecomputing.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<patches@amperecomputing.com>, <cl@linux.com>, <christian.loehle@arm.com>,
	<vineethr@linux.ibm.com>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-2-adamli@os.amperecomputing.com>
 <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
 <3deb3671-64df-4dd9-a539-3d41009f9875@os.amperecomputing.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <3deb3671-64df-4dd9-a539-3d41009f9875@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: dc99ea5f-0a8a-4408-507b-08dd102e4391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckpTWnF1QURhT2JHYkx5QXN2akdRQXNCOTg5WUxXOFlPSVZDN3l3RURGNnlw?=
 =?utf-8?B?QURLYzFHTkEvTkhUblp4Nm9xakdhd0dJZ0lXYUZ1alBsczlnWmVidS91V3ov?=
 =?utf-8?B?bGxlRzExVHN6Zlg2bDVXelY0V1ZnS0dpREZRSnVDWnRNMWhsekg4VGhiYmo5?=
 =?utf-8?B?ZGozL3BPOU9nUFdXalg0c3IvZ3Q0MXYwV3lRY21ORnpwMmRMWW9aMGpzZEFt?=
 =?utf-8?B?NHFkbFMzQ2JLVVFtWHVPNzlEd3crZzYwb2FoVVRQT0ovaHprODFpZzc1NDVn?=
 =?utf-8?B?Q2QvVTBFdmZDSGN5dU5UcHR4TERKa0NXYUN0UFdkWUR4SHhyRTA0Y3JoaDlT?=
 =?utf-8?B?M1JBcHRQOFpSdnhrYzAxV29pa0p3L2gveDdscGNMcE04S2wxTnkwNVp0Tjgy?=
 =?utf-8?B?bDBGejkwbEUyUkFJQlpkbS9STW5oeE0wUDI2RUVXMG50amFNaGF5ai9Od0hX?=
 =?utf-8?B?Yk9tUzVpU1k5NTdBRjJtbjBsZG0wZXM5eVVSbkJtNnlEUzdxbVFoamRsTk83?=
 =?utf-8?B?bTFQcWcvMFJualhBbFhHaFlXU2hPbk9DQWVMS09CVmdlOVB1eS9zV3hjRVZ2?=
 =?utf-8?B?UlExL1NSZTRwcEVwdFNoZXZjelJucEhzcW5UbGRpSm5WQTlWVTg4WE9BWHov?=
 =?utf-8?B?bnRmbTFzRjlCdkhMRTBNc0o2YzgwaDJzTjFOaDh6ZVd4bFBtVkt3cjV3enFM?=
 =?utf-8?B?RHRTWEFhVFlnQzZVTUlQTDBXMGFBTVZRU2Q0RkJ2L1Nha1E5Y2plVGt4SUlS?=
 =?utf-8?B?NDl2dVRBaXpWYTFiQVV3VWhWV2E5Q1VoUVI0Qms5OHNnei9EUkdQdG9SaFV3?=
 =?utf-8?B?bjBBQlpLVTJtSGhJZ2Z4WUtnRmxVQ2xjN202RU9ZQ2xzcE5DRmxVNEpGdWVB?=
 =?utf-8?B?c1RrYk5QNVFWcmxGUjdaNm5RMHBIbGo3Z1lDaEN0ZytDZ0pMaFl6TkNwaFQ4?=
 =?utf-8?B?VmhIMnJ1YWxYTVBiNmliYjN5aWlkRklzaUgxN2FDUEM3L2hUK3RxMEMzbXBK?=
 =?utf-8?B?aXFlckVYdk9namVBZWhPSHlSMURCNjFJZTRSVHcvd2hsblNnRGpGUVpTbWFk?=
 =?utf-8?B?TFg0NExTZ2trMHNQcEd6Y1VMSmR1dGpBcXlyeWw2WHkxbzlNbXlzZDlpUnVk?=
 =?utf-8?B?dmxwS1d1ZVk1NnMxdnVhVVJOckZKZVV1SDBac1BjbG1UU3d3VnpRcnEzOVZ0?=
 =?utf-8?B?RTJNNmdzN0s0aU5wOTVhWktWOThUMlp5WXZGV3lkcFV4TXdXdmtUaXV2ZGJ6?=
 =?utf-8?B?N2wyQXJRbUZhT01KL20yRzgvQ0pYM2pTNDY2Rlo1VzVyQjdpVGdTR2hvYXM2?=
 =?utf-8?B?aU05L1lIQTNDMFp2VG91eWZSRFpPVmUzUkRoUlZlaW9xMGpYb1pOVU5naEc0?=
 =?utf-8?B?ckhsbHl0akV0WnFjOHFENWNIWUw2aDNVODVsTmZxY1c4c1hyQ2Q1K3oycUts?=
 =?utf-8?B?aWhPa3Vjck0vK29wQ0N3dm5PQXh4ODhZZnhMWEt1NGhOaTVuS2E4RjVNQ2Zo?=
 =?utf-8?B?aW1oYXJlempFVkJjcnVWYUZSdTE2dUJibVRBcS9oWWk3NU1sZTdkVGtieW56?=
 =?utf-8?B?UXpxUHM4RUlHK2FwY2VHaVFpTWh4VXFvbERyYXl1K2lOdHNiUzZRWUNENTRC?=
 =?utf-8?B?blo0cU1ySzd0dVVkT1dVb0RkT2pUbW9VT2JwTE54RkZuZ2x0RFpwNll5cisz?=
 =?utf-8?B?bUdRTXNVZVRnUEliWldMdVVtSGhFNElVVEk0eGpyOTNOUEcyUTBERng4K2Q2?=
 =?utf-8?B?Ui9CNEVTMlZvNG54SEsyVENBei9FdngweW9lZGlIeERXdUk5WHN1Wis1WTk2?=
 =?utf-8?B?a20yUWFpbUFiR29LTURCN0hXYzJINXJNK2xiL3pLbVpydmFkclBwNWE1aVQ4?=
 =?utf-8?B?UFllK3dqditkTWRBRHdlcVY2SjlXeHpkQnlpcnJDaHQyZUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 04:28:24.3834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc99ea5f-0a8a-4408-507b-08dd102e4391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850

Hello Adam,

On 11/29/2024 8:51 AM, Adam Li wrote:
> On 11/28/2024 3:29 PM, K Prateek Nayak wrote:
>> Hello Adam,
>>
> Hi Prateek,
> Thanks for comments.
> 
>> On 11/27/2024 11:26 AM, Adam Li wrote:
>>> Enabling NEXT_BUDDY triggers warning, and rcu stall:
>>>
>>> [  124.977300] cfs_rq->next->sched_delayed
>>
>> I could reproduce this with a run of "perf bench sched messaging" but
>> given that we hit this warning, it also means that either
>> set_next_buddy() has incorrectly set a delayed entity as next buddy, or
>> clear_next_buddy() did not clear a delayed entity.
>>
> Yes. The logic of this patch is a delayed entity should not be set as next buddy.
> 
>> I also see PSI splats like:
>>
>>      psi: inconsistent task state! task=2524:kworker/u1028:2 cpu=154 psi_flags=10 clear=14 set=0
>>
>> but the PSI flags it has set "(TSK_MEMSTALL_RUNNING | TSK_MEMSTALL)" and
>> the flags it is trying to clear
>> "(TSK_MEMSTALL_RUNNING | TSK_MEMSTALL | TSK_RUNNING)" seem to be only
>> possible if you have picked a dequeued entity for running before its
>> wakeup, which is also perhaps why the "nr_running" computation goes awry
>> and pick_eevdf() returns NULL (which it should never since
>> pick_next_entity() is only called when rq->cfs.nr_running is > 0)
> IIUC, one path for pick_eevdf() to return NULL is:
> pick_eevdf():
> <snip>
> 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> 		curr = NULL; <--- curr is set to NULL

"on_rq" is only cleared when the entity is dequeued so "curr" is in fact
going to sleep (proper sleep) and we've reached at pick_eevdf(),
otherwise, if "curr" is not eligible, there is at least one more tasks
on the cfs_rq which implies best has be found and will be non-null.

> <snip>
> found:
> 	if (!best || (curr && entity_before(curr, best)))
> 		best = curr; <--- curr and best are both NULL

Say "curr" is going to sleep, and there is no "best", in which case
"curr" is already blocked and "cfs_rq->nr_running" should be 0 and it
should have not reached pick_eevdf() in the first place since
pick_next_entity() is only called by pick_task_fair() if
"cfs_rq->nr_running" is non-zero.

So as long as "cfs_rq->nr_running" is non-zero, pick_eevdf() should
return a valid runnable entity. Failure to do so perhaps points to
"entity_eligible()" check going sideways somewhere or a bug in
"nr_running" accounting.

Chenyu had proposed a similar fix long back in
https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/
but the consensus was it was covering up a larger problem which
then boiled down to avg_vruntime being computed incorrectly
https://lore.kernel.org/lkml/ZiAWTU5xb%2FJMn%2FHs@chenyu5-mobl2/

> 
> 	return best;  <--- return NULL
> 
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index fbdca89c677f..cd1188b7f3df 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -8748,6 +8748,8 @@ static void set_next_buddy(struct sched_entity *se)
>>>                return;
>>>            if (se_is_idle(se))
>>>                return;
>>> +        if (se->sched_delayed)
>>> +            return;
>>
>> I tried to put a SCHED_WARN_ON() here to track where this comes from and
>> seems like it is usually from attach_task() in the load balancing path
>> pulling a delayed task which is set as the next buddy in
>> check_preempt_wakeup_fair()
>>
>> Can you please try the following diff instead of the first two patches
>> and see if you still hit these warnings, stalls, and pick_eevdf()
>> returning NULL?
>>
> Tested. Run specjbb with NEXT_BUDDY enabled, warnings, stalls and panic disappear.

Thank you for testing. I'll let Peter come back on which approach he
prefers :)

> 
> Regards,
> -adam

-- 
Thanks and Regards,
Prateek


