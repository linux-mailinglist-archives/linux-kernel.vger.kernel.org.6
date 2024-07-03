Return-Path: <linux-kernel+bounces-239558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79C8926219
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC97D1C22260
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4AE17C23F;
	Wed,  3 Jul 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a8EmbeQV"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975EB17B50C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014411; cv=fail; b=Ru5M84lncJb63x6qkVq3B/CkvLI/iee4R08x/qrmofGTL/8z5qSeZKvJz4kliM4JYxKXX9WN/c4diuxkm31+A2aFkgtHDoHudgfqKlpTSscGt7FlOw4oJdrIbwnYQ6Ow0vmh5qakw8ht+CkqkuvuDn7lU8KZebJk9LSSjfec2XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014411; c=relaxed/simple;
	bh=4svwSsUSBnBtMxVM+Y79/PFCr3mZ+3WeRszDLSZXL1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mo1JiRG3VIrW+9Cn6y7P5iAcglA5ZwnYRXgSCCppizoBlP9htDDREwP1st8djRar0GOn39bS+QBvdzeZjUTUyCBp0/VJHo62ZWu2DchvAlNU9aOYX3ycdxS9VMAAniwXdDFjuvGiStd/z1sv8ArqXwlxUdnyODZ0VcinDTC+LUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a8EmbeQV; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMj7/BjFBzar2ff63SBkM+84N0YbgqTCw5OWtAI1/ayUwv7TPjmHniKtpCn42aczhFN49pGFR66WRYqpi+YGQMwm0g5cLHM/8R65nHoBjRA56egPDNVrnCh9Yrr6iSvVEaJeSMnSVBEcgQMPMYRBX3S9dkFCOMZuwPtNDqessyCwIkrmvMN+zSvrzJN1YKv0+126eMJRHYjX/0HtoPuslwY/yPP2Kyft1XihWcQHMIg6jfNlcFU9tcuA07fpNoaDuwypsQ3oRvTRKD8oxmu1+GSukVcsQkPT4KMbgS1gzZ0jDWSbpann9zNfv1d8SbtdflissjcjCWTTHc9CEEweeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97hh3BhyDy2crOOidfICTJi/grGPscGouvDairL0LNU=;
 b=VY94+235Nx9Zbrd/nV3fkLL2iC6q8PN7EutmL5O14cCqFKdcAjvuUV8m9L5Jw/pniJ3SerebErUZEZB3Apv1J3urVXAK3xnGoTsx3Th8Px+xSvOZ2clP/6a8rhZuLen4xjP0tZ+VKjXs0ugjYCCm912cgvPlImjz6dR9NTGGcEXZ2wygF6KV9ajXi6YkbTbRJYlOZLw1AzL8ISf6ydZgLYA3qw9OtHYJZGIFERhKbuSql3L/vPpSlomKhZ5kgXMCAy7CsVASzIsJHtjvGXErU8o21O2WUrsAr6x5f6nRT/NZLNWg27skcwA/uOU1Ch837jpjaK5IPzpjj2rUvvJE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97hh3BhyDy2crOOidfICTJi/grGPscGouvDairL0LNU=;
 b=a8EmbeQV6KeeRW1QBN58UEbmJnEvLBLdBWWn8NYchC740W//5zn2Vx7n5DlC92EBQDq0gBAesOEcFkkemNxmMqidHLoqgFJPQZPoxkccHDIR2EXRV3NTRgvvPg/sHNkPyhhyQn7h6BMZlSZhx6C2zrfDhBDRxAkmzkBOjn0l/3g=
Received: from SN7PR04CA0069.namprd04.prod.outlook.com (2603:10b6:806:121::14)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.39; Wed, 3 Jul 2024 13:46:46 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::7b) by SN7PR04CA0069.outlook.office365.com
 (2603:10b6:806:121::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 13:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 13:46:45 +0000
Received: from [10.136.18.229] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 08:46:42 -0500
Message-ID: <1a90a564-8fb3-68c3-361b-ac337386c32c@amd.com>
Date: Wed, 3 Jul 2024 19:16:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
Content-Language: en-US
To: Chen Yu <yu.c.chen@intel.com>
CC: Mike Galbraith <efault@gmx.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, Tim Chen <tim.c.chen@intel.com>,
	"Yujie Liu" <yujie.liu@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Chen Yu
	<yu.chen.surf@gmail.com>, <linux-kernel@vger.kernel.org>
References: <cover.1719295669.git.yu.c.chen@intel.com>
 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
 <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
 <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
 <db81ba7fba622e2a1b7186e66471cfb9ad8490fd.camel@gmx.de>
 <ZoLDxQlTR7fxoXWs@chenyu5-mobl2>
 <683663e3-cef0-bb45-e1c7-5bf1cf44209c@amd.com>
 <ZoVOL3mOVFAGEmZV@chenyu5-mobl2>
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <ZoVOL3mOVFAGEmZV@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 451e4960-b220-4511-b0ea-08dc9b66945d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWl5ajNVTEwrb3pCdEY5TzNkbFRUckdXSVJSRXIveXF4OEkyNTF5ZjFxTG4z?=
 =?utf-8?B?RSsrVUExVGlGZDRUbmdEemY2aENVZWxLaXYxUnN3cWdtT0J6b09WN2o2VW1T?=
 =?utf-8?B?eDVOaC9XZ2RSOG5VTUZGLzFRVXVuTmprN0tEOGtIMGZNSnJDUDZ2K3FPblIy?=
 =?utf-8?B?OENUMHY3YmlHbTRsL280eFBxY1JJWjdOUElPSUdYNUFGR3Z0a3BnWUY2THhk?=
 =?utf-8?B?RVFmbFdkdzBERUNZU094WW1vN2UwQXg2cS9KYUxUUm9KWVBlMFhjSitZS3Bs?=
 =?utf-8?B?aWc3U2dPYnhTSDJ5M0RWU1BGQTIwaGo1ckdnV0w2djhPL2xjN1FsS2YyaGE4?=
 =?utf-8?B?am14SzFMUmFZRzBadUNsSUpiNkFlTk9zd3MzT01RVFZHNEFycnVxV291UTFm?=
 =?utf-8?B?VThaTW5odmZVWFdjZkZEZkJaNVBHd3VJS3g0bDg2WlVZWE5XVEE1U0pKQ2hO?=
 =?utf-8?B?ZjZMUGZSRGJyL0NJN0N0WkVBSnJPd1VHYXIrcTdJNEQ4bzhQZTdxTlpDSy9L?=
 =?utf-8?B?eDdLR0thR2FzZVhOcXgvbGU5UE9SS1UvUVd1RlI2ejNzL0lmV2IrVnJSMm1u?=
 =?utf-8?B?WE1uaDFrL0E4bXpBVENiMWQ5bXE1S2Z6aVJTc0VqdHF3NDBEamVNSWVHNTc2?=
 =?utf-8?B?VE5sUU1rSHd2WGZYMG1SZTU1SDJiYjJ4dXVnV2NNRC9lRXNjblMzZFVTOSs0?=
 =?utf-8?B?QkhBQmlRaktiSWxNMEE5Z2dETXVobWlNR1l1RDNzTm1DMWhyQi9rb0RzTTRy?=
 =?utf-8?B?ajBYMS91NGFIYkZnbVcwNXg4NWhoeUVaVGFDZE1ubG5Lc1BlYVJQaDRHS0Jr?=
 =?utf-8?B?djRtVVlMaVN1OURJaEFyTHI3SWR3V1Bjd3ltTGh5LzRqRHFnd3R3bVdqc3hy?=
 =?utf-8?B?aXlmc25Pbk1NbGIzUFpVUWIxT3k4YytJOHF0MTMxa0daa0J5OHBIY2h3d3ZO?=
 =?utf-8?B?OVdhOWltRGYyZXdjeGZONTlIR3dPTlJuc01Gckttc0U4QUJKcmhHS3VFRXRF?=
 =?utf-8?B?Ny9XOEw4TFBYL0lqZExqSHhUV1R4NGZHYnBwK3hZNjVRQ2FNbGpENkNzR0NB?=
 =?utf-8?B?M3BsdndIRkFYWTVRZ0FsVERwK21xODlJOUpzUEJJWUY4ZzVyS1dVa3Y5NmJN?=
 =?utf-8?B?c3hWbkwzdzRFSmVpQkN4R1hIR3NQM3dVVDFhVVhhUitPZ1JZKzVCOEVsNlV0?=
 =?utf-8?B?UmlxRnpFbS8wTHZkYWI1TFNyeU9rbkQwdnFaRGdDY2JrVEY4SzJHNUNaY3dI?=
 =?utf-8?B?Z1VpUEROOHY1NU1DYStkbHhVRWxJSm5UZDErNjZNSWpTajNyN3VBTDZlRGQ0?=
 =?utf-8?B?c25Db1B4dFJ6MlNSVEo5UlpKK0NEbHhJOE85ZldsVXVINTBLMFNMMFpTbFhX?=
 =?utf-8?B?Wkkxbi9ZNEc4bDNuRW9TR1JidDZCWkxhYVJMTms1NDNJenJJclVuVXlVUzNq?=
 =?utf-8?B?T09VYlNtdERiVjcxd1NVc3FzT3h5NjI2SFpUL21SR2tMR0tWcDBUZE5pRkFq?=
 =?utf-8?B?RkJLY21IMGtvZzFEeTJhVXF3UHExVGFhOWh6NklhRS8wNTl4UG5sMWNmUlI2?=
 =?utf-8?B?S3lRYWRmUWQyZjUyT1hCdXN3Ti9DbGhPbU4xSlZaLzRJVFFBVTM5QjlsS1p5?=
 =?utf-8?B?dnZYTWJWNHloam1UTlpRWjVvZjA3ZFdUcW1GR2ZHWU0wc2Vhd01ZQVJ0L25N?=
 =?utf-8?B?UW5KUTcxVmNLSVZGR2xsMGdWeVJYZzMvYjdnUXF6SEVuQU1Cb3cyUnNKblpH?=
 =?utf-8?B?SHJESldKUDlHM1hyRzNYUlRzUk9EOUZpcDdNclIwbXMwUDZqQ3M0STBLR1BU?=
 =?utf-8?B?L25RaXFQRmdTUmZmRjZlVHdEQzY0RVNQTU5kZjlNWXZCc3pZM1JKZngydjZn?=
 =?utf-8?B?U1poejY3ZzZjVXJ1dkZScDhMVXZWMmMvWTdzRXVWaTdDWnN4L0IySDFpRXky?=
 =?utf-8?Q?MwRApWGDdFKebbvyb8TmoxTRZcLsCF9X?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 13:46:45.7124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 451e4960-b220-4511-b0ea-08dc9b66945d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866



On 7/3/2024 6:42 PM, Chen Yu wrote:
> On 2024-07-03 at 14:04:47 +0530, Raghavendra K T wrote:
>>
>>
>> On 7/1/2024 8:27 PM, Chen Yu wrote:
>>> Hi Mike,
>>>
>>> On 2024-07-01 at 08:57:25 +0200, Mike Galbraith wrote:
>>>> On Sun, 2024-06-30 at 21:09 +0800, Chen Yu wrote:
>>>>> Hi Mike,
>>>>>
>>>>> Thanks for your time and giving the insights.
>>>
>>> According to a test conducted last month on a system with 500+ CPUs where 4 CPUs
>>> share the same L2 cache, around 20% improvement was noticed (though not as much
>>> as on the non-L2 shared platform). I haven't delved into the details yet, but my
>>> understanding is that L1 cache-to-cache latency within the L2 domain might also
>>> matter on large servers (which I need to investigate further).
>>>
>>>> 1:N or M:N
>>>> tasks can approach its wakeup frequency range, and there's nothing you can do
>>>> about the very same cache to cache latency you're trying to duck, it
>>>> just is what it is, and is considered perfectly fine as it is.  That's
>>>> a bit of a red flag, but worse is the lack of knowledge wrt what tasks
>>>> are actually up to at any given time.  We rashly presume that tasks
>>>> waking one another implies a 1:1 relationship, we routinely call them
>>>> buddies and generally get away with it.. but during any overlap they
>>>> can be doing anything including N way data share, and regardless of
>>>> what that is and section size, needless stacking flushes concurrency,
>>>> injecting service latency in its place, cost unknown.
>>>>
>>>
>>> I believe this is a generic issue that the current scheduler faces, where
>>> it attempts to predict the task's behavior based on its runtime. For instance,
>>> task_hot() checks the task runtime to predict whether the task is cache-hot,
>>> regardless of what the task does during its time slice. This is also the case
>>> with WF_SYNC, which provides the scheduler with a hint to wake up on the current
>>> CPU to potentially benefit from cache locality.
>>>
>>> A thought occurred to me that one possible method to determine if the waker
>>> and wakee share data could be to leverage the NUMA balance's numa_group data structure.
>>> As numa balance periodically scans the task's VMA space and groups tasks accessing
>>> the same physical page into one numa_group, we can infer that if the waker and wakee
>>> are within the same numa_group, they are likely to share data, and it might be
>>> appropriate to place the wakee on top of the waker.
>>>
>>> CC Raghavendra here in case he has any insights.
>>>
>>
>> Agree with your thought here,
>>
> 
> Thanks for taking a look at this, Raghavendra.
> 
>> So I imagine two possible things to explore here.
>>
>> 1) Use task1, task2 numa_group and check if they belong to same
>> numa_group, also check if there is a possibility of M:N relationship
>> by checking if t1/t2->numa_group->nr_tasks > 1 etc
>>
> 
> I see, so do you mean if it is M:N rather than 1:1, we should avoid the
> task been woken up on current CPU to avoid task stacking?

Not sure actually, perhaps depends on usecase. But atleast gives an idea
on the relationship.
Problem here is we only know that they belong to same numa_group,
But we cannot deduce actual relationship (we only know it is > 1)
(1:N or M:N is not known).

>   
>> 2) Given a VMA we can use vma_numab_state pids_active[] if task1, task2
>> (threads) possibly interested in same VMA.
>> Latter one looks to be practically difficult because we don't want to
>> sweep across VMAs perhaps..
>>
> 
> Yeah, we might have to scan the whole VMAs to gather the PID information which
> might be a little costly(or maybe subset of the VMAs). And the pids_active[] is
> for threads rather than process, stacking the threads seem to not be good
> enough(per Mike's comments)
> 
> Anyway, I'm preparing for some full tests to see if there is overall benefit
> from current version. Later let's investigate if numa balance information could
> help here.
> 

