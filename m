Return-Path: <linux-kernel+bounces-425298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE7B9DC02D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74E7B22CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1F115CD4A;
	Fri, 29 Nov 2024 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uuq6f9W3"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8415D5B6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732867226; cv=fail; b=teUDKjM0TGSlCfw6SERwgACVRPtJHoTZim29IEe6uZ0twUx7VhRDvCj+D3xCfcyXKMHiyfcBroNyWnRAnetPsDZJb/R72eyxmgpssb9JxCkN4o1DTw+BK/jT+rfw+VK2SXTyokiqjS5KvzM2Nc68oCQgVGv+BuNLBY/QrZH36Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732867226; c=relaxed/simple;
	bh=5Ls7O52ka17cjoqjnLVzYoYZ0JpL+g2h3VIAsDsXR8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SJts5Gp+fyMwzRtH/36cBpJiAF5H9sad0UM0d8b3V2p7gSUVtbroruEk5cOUSMhuFMg3Ekv5JGSdoJH+LEM9be0tSsTNV41gTzffR4i163ogWLreH5Tr8YjB1NS+Wf6AirF/j/oF3SVw0/7x1ejy3EA6stskdYo575ORH8Sd9fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uuq6f9W3; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfmkJI+1PlI2TVAuD1I/aSfJCAaZYJUGtZFee7xSmV34vckdnWJ5DMKf9PUDHs10dSfAnQAsfZ97wRPc69dNx3gGkzPqVD3A1FIbvJhiQX9JEAmVM9u/ncWhFo/1jUssOzdOb/jah45D2dxt/rnukmqseU7tzN4JLYeXJFVkrgOPnd1m6OwFFrLpU6r/vr1lOxIVAuJs2E2nSgfTmX7skmXMu9HNKa2yGeaE7fgte1/pF6aYwmKXsJhTvAe3i3ZjuidM/Y175SwkhLN0ooMbu46bHHoXDmcoajiC++gL+gyFFbYw00/PNF3aGOp2BrTpNZ5cWfnIIiqIs6UoL1lRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y38+mTxxpzF5fGkZOFbvnrukdWIIyb0qrQaNe1U2YGg=;
 b=YBtSPDnxLzGoTvB/xXEF0xN/kw42LAoesTpixvjGrfpPXHJ+IE2BmgfejT2J/p13eRfnSqc4ps9UTr8f/TGBoh21qrSYxIe5pLwwB44B/oYC658utS7Fk4J+8eBk97zUnWil8gemgUgDaXvcAwfuGf2zc1k2PcntO+vPdclFnct+efiv1fcn//B7meTC+11/G909oFZTMfl2qZTAzMdHpVmGTF6m3MQvb6SSG6h1TfC8RuuA9dfevGJ9D6uw4kUvhE5r0Tno+9fK9dlOZVRn2BOPuuTn09PZjzM6h0kJRBSo0GccRtaVKwlsOiw9y73TMqiX5HFxjkSEeJZmCGDzZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=os.amperecomputing.com
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y38+mTxxpzF5fGkZOFbvnrukdWIIyb0qrQaNe1U2YGg=;
 b=Uuq6f9W3mJMgzB5HCM9lUktSu1EmTDN1UQOUqE6vyYZYQfYZ4BCuvap/mVyAzreDojYh1fTNKs9RspCLL1KPl43StKd7FzB7oxdYV0CvflRUAyv1CLojZeiuxu/+L6cWP062c1IGzhyb5Y+MJO2PG/SS3CmjFQvEkE6uIzLusxI=
Received: from BN0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:408:141::8)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 08:00:19 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::40) by BN0PR07CA0009.outlook.office365.com
 (2603:10b6:408:141::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Fri,
 29 Nov 2024 08:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Fri, 29 Nov 2024 08:00:19 +0000
Received: from [10.136.33.212] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Nov
 2024 02:00:15 -0600
Message-ID: <ba9f47fc-4465-4db8-93e3-fe86c619bdef@amd.com>
Date: Fri, 29 Nov 2024 13:30:12 +0530
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
 <d16cc372-b4ae-473f-bf86-83469fbead99@amd.com>
 <cf3dbcfe-3c26-48e3-b32f-6473c8dbeb06@os.amperecomputing.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <cf3dbcfe-3c26-48e3-b32f-6473c8dbeb06@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b52f85-1f22-4668-7f24-08dd104bde37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzZOK2tqcVJMc09DZjZHWkNEREhuTlZ5c0NCNnlyOHFUeEg2cktkYkJVdUxj?=
 =?utf-8?B?SE9FVGRCNW9nVnlveGUzb0NiREdKR1lPYkNCQWVjTUJkM0ttUWVLOU1FVXVr?=
 =?utf-8?B?Vm4yQlB1RTJSTXBUUHpyUzV1REVrTmVxVjlwWmhUOTBNTHZRMlY1UnNHeHdq?=
 =?utf-8?B?TzZLKzVVa1FZdG4yblRoV05RS2E4bUlzUzdkakVLOUlkbkkvK2FWL25xU0tK?=
 =?utf-8?B?OU9tVkdhTmtTalhRaHkycllGaGF5eGdJMGNmVU5WQ1VkM1paeTdXbVUzUTNY?=
 =?utf-8?B?dDJ3YS8xUlhkeS9IK1NYemhLMDRqdTVwZHEwbGVHSmhwazBMUlVCRWI3YVVs?=
 =?utf-8?B?eWZRK290Z0l1b3BnQnJlRHhpNVNSRXBLSHJNSHI1amdZTHFBTS83VFlYVmVp?=
 =?utf-8?B?dGtMTVI1SjgzeklZQXZPUFEyREVQaXlPcjFwd3hxVmVtdm92OVRqb1V2YkhD?=
 =?utf-8?B?WFhDeWxpdGZGazByMU9LYkUxUGI3N0VpcXN2bEtQQ2pnUVZVMXdoWFdIbldv?=
 =?utf-8?B?dTNYdVRFdnFnSE5HYUJPWVVDc1VBY3UvT0Q1VWMraW0wbGg4MmVQcFZYWVN4?=
 =?utf-8?B?d2c0SXdRSWFONEloY0R0MHc4VW9LQXBIazhzb25DMmhHVGs3djlZbEE5SWEr?=
 =?utf-8?B?ZWpSRVo5STZKejh3N3RWYUxOUDVLM0N6T29jUlAvNmNkU08yaERUeDBYL2JB?=
 =?utf-8?B?bnR2TDJrSE85T1RlTjduaTBveFBpKzMyVnVITkgvL3JmK29BWWNyejN1Ull0?=
 =?utf-8?B?OS9qc3pVYW9rR3l6QmFJWTZCa1hNcHFGeHZSTSt5b1A5d3YyT2FrR291WVV2?=
 =?utf-8?B?K0dHVlZlTitjbFJHK0RpVlNHVWdzOXV4UVQ1UThiczAxanhPMDROSzlQcnll?=
 =?utf-8?B?ODZKUU96WVpqMjA0Qlp0a29oZFhsYlhLQUhrb25XejdnOUlFcU15R2tsdzhX?=
 =?utf-8?B?RzQ2VGJ4R0V0bDkvTHcveElnUWwrNW9DRzZ5N3JOamhXSTh6aDRxT0lLRld6?=
 =?utf-8?B?elVicnl6bVRJNUNlZDI4dEFZbFhaSTFpeERYRUpBWjQvNlZOQnhySDBKWHQy?=
 =?utf-8?B?QnZES1pkYkRpUkZhdW9iSm51K1RYQWtaeGZXK3V3dGt0U1pTQkVGc0tjOHJm?=
 =?utf-8?B?TWwyRWcxZmRlTUZpaVVqcGZINGhCL3MxdFJibWI4TDhMR0VCQ05OK0RJREhM?=
 =?utf-8?B?ODZpNU5oMDFnaWxwTTV6eUR1bU85NnNDRy9JRU15eDlUVjNJS1d5RGQ1UzdO?=
 =?utf-8?B?TXJZNk1oRUdyQnhNWm10ZVg2N2t0WkZpZ05yWEtEdUR1bnZUNU43NTFMbUVC?=
 =?utf-8?B?QWRzYUo5T1YrQm1Mc01qa3pzMUdhUUhpMGR6QnExMmdtYnlGd1R6Z2hqUWVw?=
 =?utf-8?B?c0w2YjFuOGYrbjBXbGRCTkZGSHVvb00yclZrZ0JxYTNEODBrUGdVbHlIZmNh?=
 =?utf-8?B?ZmJzdVZPV1BCa0hxMnVLcTFVYmlBQ1BSdTRqSnhNbjBsR01DL3ZjcVQ3Vk4z?=
 =?utf-8?B?SWV5Y0ZvdGh4dTNDUXlvSjNoSm9JcndaNGwxWDAxYnUvMjRQOUpGeHdlNWNT?=
 =?utf-8?B?YUxLNGxrUGdzZDF6eHpVUVhEaE5ZY2x3dVhTeVQ1RGhoajZUMWxIczAvRzk2?=
 =?utf-8?B?SWJPZk91dGVGK1VPN1VJcWJHNjdpU1dMSFQ5L2tMVExmelFEOXh4eVVySHJx?=
 =?utf-8?B?cnU4bWllU1k5UXNHdmFabmtacnFrY2FoL3ZzZTZWdUlaYTN1N3pGaWlyVDBM?=
 =?utf-8?B?V0ZUYnFMaEtZUGF5d2pYcXE4cHZjY1czLytuK2s3ek5IcWthT0NHT0pKUnpJ?=
 =?utf-8?B?Y0hRSWREY2Nwa3hBY0cweWtOOFN3YnJsUUV1c2ROMU5BbG1yQ0k2bmUzcS91?=
 =?utf-8?B?NGM1MWs0WHpKeWFCbU5HSkZvZUtIOUQ2WUFUUWxXOXJhM0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 08:00:19.2624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b52f85-1f22-4668-7f24-08dd104bde37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764

Hello Adam,

On 11/29/2024 1:10 PM, Adam Li wrote:
> On 11/29/2024 12:28 PM, K Prateek Nayak wrote:
> 
>>>> I also see PSI splats like:
>>>>
>>>>       psi: inconsistent task state! task=2524:kworker/u1028:2 cpu=154 psi_flags=10 clear=14 set=0
>>>>
>>>> but the PSI flags it has set "(TSK_MEMSTALL_RUNNING | TSK_MEMSTALL)" and
>>>> the flags it is trying to clear
>>>> "(TSK_MEMSTALL_RUNNING | TSK_MEMSTALL | TSK_RUNNING)" seem to be only
>>>> possible if you have picked a dequeued entity for running before its
>>>> wakeup, which is also perhaps why the "nr_running" computation goes awry
>>>> and pick_eevdf() returns NULL (which it should never since
>>>> pick_next_entity() is only called when rq->cfs.nr_running is > 0)
>>> IIUC, one path for pick_eevdf() to return NULL is:
>>> pick_eevdf():
>>> <snip>
>>>      if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
>>>          curr = NULL; <--- curr is set to NULL
>>
>> "on_rq" is only cleared when the entity is dequeued so "curr" is in fact
>> going to sleep (proper sleep) and we've reached at pick_eevdf(),
>> otherwise, if "curr" is not eligible, there is at least one more tasks
>> on the cfs_rq which implies best has be found and will be non-null.
>>
> if curr->sched_delayed == 1, the condition: '(curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))'
> can be true. Please correct me if wrong.

If curr is sched_delayed, that means it is going to sleep and it is
ineligible but it can only be ineligible if there is at least one more
task with a lower vruntime and hence best must be found. A delayed
entity will also not decrement the "nr_running" and it'll be queued back
from put_prev_entity() to be picked off later.

Essentially, I believe curr can never be ineligible in absence of other
eligible tasks.

> 
>>> <snip>
>>> found:
>>>      if (!best || (curr && entity_before(curr, best)))
>>>          best = curr; <--- curr and best are both NULL
>>
>> Say "curr" is going to sleep, and there is no "best", in which case
>> "curr" is already blocked and "cfs_rq->nr_running" should be 0 and it
>> should have not reached pick_eevdf() in the first place since
>> pick_next_entity() is only called by pick_task_fair() if
>> "cfs_rq->nr_running" is non-zero.
>>
>> So as long as "cfs_rq->nr_running" is non-zero, pick_eevdf() should
>> return a valid runnable entity. Failure to do so perhaps points to
>> "entity_eligible()" check going sideways somewhere or a bug in
>> "nr_running" accounting.
>>
>> Chenyu had proposed a similar fix long back in
>> https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/
>> but the consensus was it was covering up a larger problem which
>> then boiled down to avg_vruntime being computed incorrectly
>> https://lore.kernel.org/lkml/ZiAWTU5xb%2FJMn%2FHs@chenyu5-mobl2/
>>
> Thanks for the information.
>  From the timeline, it seems the issue is before 152e11f6df29 ("sched/fair: Implement delayed dequeue").
> DELAY_DEQUEUE may introduce risk for pick_eevdf() return NULL.

Ideally it shouldn't since delayed entities are still captured in
"cfs_rq->nr_running" and they'll eventually become eligible and be
picked off but I may be wrong and I hope someone corrects me in which
case :)

> 
> After patch 1 ("Fix warning if NEXT_BUDDY enabled"), the NULL pointer panic disappears.
> Patch 2 ("Fix panic if pick_eevdf() returns NULL") is a safe guard.
> 
> Thanks,
> -adam
> 

-- 
Thanks and Regards,
Prateek


