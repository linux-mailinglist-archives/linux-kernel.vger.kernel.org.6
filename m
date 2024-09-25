Return-Path: <linux-kernel+bounces-338002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 629B3985223
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA191F24A66
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88AE14F9FF;
	Wed, 25 Sep 2024 04:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y9tc/8Tb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6211E49E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727240088; cv=fail; b=r+AzanhycQ1AZNmxMoa+C8KeQggfszGpLo8y+E3mZq83zEAXLrvzg+UU5c96nzj0d3yzu1pu83OoPycy5eKdH/l3B3YKAlq7DM6JINoGwihvsMGJNyAj43meFBuAaSXOOB3EYFHhp0a/2Bb9cCJLcxgMe2xUIGLBrUQK/avm25w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727240088; c=relaxed/simple;
	bh=S9oSRoX0KbKWdJTuK3ffAYvkkZfioj2v/nVxVX+cffc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b2tkGcQn/keeT80RkOb/pD13s23+X/S4xAzHSFPMdL5HV7pzWGzj3xDra87dywZ4vV3QQV+l+hq/gpVrefRCVwhYizs+wZ2G5I0JvAjL+9SJGaNg7WxvSzx4efEaJOrR8VaJSNLTXpG0y76BauBwDsENHvF06Zwq7TboS4mYPLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y9tc/8Tb; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kL95d2baGkvtQpvUM/vSLb/OWKJT/BYFCLVU1N/pmeqWrluJHuQYvXyhTCegonA7zLwhi3AUrtU9IRGnDbDAg+FrGJf97dmAUlW/3dH8v4tJLZu0G4tRZagqPk2q8JTzngi5pBkbTp+4T7g0TU7/zTpg2fopj8gjhCH85QgqaDs5fSUKAXRoVFN1wEcapDRSXMR94osN1wdHLAAG/Q/+dv8n4Pko1Wizl6A21xIAZ42E61fpX861poyMtEln/gsIT7xkC6eBFsuJPmVomhh9D8Q3ngUEu9aHisTLIN16NVdW8BKU7m6zcmGy+5UgrxwFZwkgR+RveoAMtqLBO6MWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7jHa4wg2C5ibLyV+2jdJiJNcqYb8fPczHD02toZ3+k=;
 b=d7+p8P5H+6ClduLg31R+NqD+Avcc9Gq//WAnbuWFdDyh8cHlJI/Gx7bHtPmF8vCmpOEYdhoZT9g5tMoWbhV+kUz7eklkeQ6zVmkRnJ5/zPOeoT5LNd6h25wxdlt2+Fme1wb8RRNhQbKmges0/a0OjVY/BakIfQleUL43NgKxkzNvPljViVbBgGfK/ADgQUFwUP3hwtvmKXoIjXwYTfIvw6XibnjYBXSgF18pMlKfbaJCFB/9fsR+5iD82zYrTtHR8Yh8JqzozQmPg9z8gWzeyahfNNiyEJqDjZk3HirwmZ6uh64lwQORfmpKW9mjGP7z4E+66VrcgfjkUq4H0hbheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7jHa4wg2C5ibLyV+2jdJiJNcqYb8fPczHD02toZ3+k=;
 b=y9tc/8Tbkfl6pfJGycNxVwkQy86UQJugG0TyDuH4gE9LZUE9DEcCPeuNnEqyzrgsXstDXupwAfx78oKLYiRPD1/Fq341KeGPEUHBhh8zfXV3wMN5lt0EoU2cMhy3dyywviAwXZa5ldNZdsGRXGEZ2hxnYRHcIpDogdIrNX/iz24=
Received: from SN6PR16CA0050.namprd16.prod.outlook.com (2603:10b6:805:ca::27)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 04:54:41 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::9f) by SN6PR16CA0050.outlook.office365.com
 (2603:10b6:805:ca::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23 via Frontend
 Transport; Wed, 25 Sep 2024 04:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 04:54:41 +0000
Received: from [10.136.36.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 23:54:37 -0500
Message-ID: <faf91c59-1c5c-d859-a994-88e49236e1e7@amd.com>
Date: Wed, 25 Sep 2024 10:24:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] sched/eevdf: Fix wakeup-preempt by checking
 cfs_rq->nr_running
Content-Language: en-US
To: Chen Yu <yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Valentin
 Schneider <vschneid@redhat.com>, Chunxin Zang <zangchunxin@lixiang.com>,
	<linux-kernel@vger.kernel.org>, Oliver Sang <oliver.sang@intel.com>, Ingo
 Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>
References: <20240923072156.343623-1-yu.c.chen@intel.com>
 <3c969a0b-812e-dedd-b9ed-6378f61d5735@amd.com>
 <CADjb_WRBu8+zhO3ynHE4gferJhvZ=o9Gq1_rUisz143ivjkS0g@mail.gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CADjb_WRBu8+zhO3ynHE4gferJhvZ=o9Gq1_rUisz143ivjkS0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5f68c9-5a0f-4b80-8849-08dcdd1e2a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzdjNW1KU0NXOWpUekR4MFQrMjJRKzZ5bTZIVE5UQ0UxWmVFVGxsK1F5R04x?=
 =?utf-8?B?MG5oOUpzNmd3OG5WZDFaamxqK015WHZCajdiVEZmUFgrQjVEaFZhVmZZbmVw?=
 =?utf-8?B?TiswVjM2WURQdzdIZm13NG9ZdWlrSzVHanVISGdqcGVTTERZSlp0T25Ub1hG?=
 =?utf-8?B?NjZNUU9pVGlLSGlab3R6dzRCTEIwUnRScFhKSXR6M3hCWjNhSm1KVkxHTFJH?=
 =?utf-8?B?RXAvbUdXb1VrQzBUWmd0OERweVQ2NEVxTnNDYlNOU0F3dHhWZ1F4aVBjcVdJ?=
 =?utf-8?B?TktDdzVCUWR6dVFWeGJmK1FlQWtJU2hFcUxqbkd4dEMzaWlXcEFrekkrWEhF?=
 =?utf-8?B?N2E0aWlMeUR6UC9pUVEyYmZKa0FYeU42cU0zcDhoYm44Tlc1SU9JN0lkZ0My?=
 =?utf-8?B?WXhLbDlmODg5V0t1cWgwemhLU2hzTzEvRHlsL1E1NUgrTktENUhvNjJZdXBS?=
 =?utf-8?B?b3B4V20rOFhNR0ZXcEdTdE40bnlockkxanlVS2E5c3cvTGFPZExCQVQ2NWJ0?=
 =?utf-8?B?a2dvTVFXWUwyVUhyYnZQL1Y3amFIUGFlRnVUUkxzaVphQ0VmUFZPNkpsRXQ0?=
 =?utf-8?B?UGtablpZVCtLZTJ4YThpdFNucU44UzVnSUJaTXdsN3hTMmFlQTZQZWdqSko1?=
 =?utf-8?B?VUdsVExsWEZRZXpBL2kydFhjNmorczl0bEk0WDRmaHJ3bE83bElUSWZwckJ2?=
 =?utf-8?B?Q2VlK2dSK0ltQzJ0cHFoWEY5ekVia0d5dE5sMmcxbmk3YXRaQkFFYWdUWmJ4?=
 =?utf-8?B?czlMTEgycmt3dkhOaGVwS0dVRmphWjh5VDZNZmpmV25pNEpoejJFcTJIQmlM?=
 =?utf-8?B?c3lxbllsdzBmbWhYeXRBU056NjZhcDVmRkgzQnlWbXRWYUxiUnZUUldZTWkv?=
 =?utf-8?B?Vm9Ca3ZXWlBycGhHSW1peUFpSW16QlA4QVR0OXc1YUx2TXRMdEdMTGZHVGRX?=
 =?utf-8?B?alNabzdwNGRoZzVZMDFtTVhnWkFHbkpsUy9rVUhSSlhRTDRQL0poSEJmWk9G?=
 =?utf-8?B?YVJiOWlIZVpsK3FjcU1CUXR5QTFlRlpsaU1jRVpUTGoyankxSWZzQ1NhSGhX?=
 =?utf-8?B?U3lHOEhFTmNrNHJKZTQ2MjJRUXpocjdqN0Q4WkFsVmFuRUJjSEZrcmUvZFN3?=
 =?utf-8?B?UFpuN2ZaMm5SS1AvQUN5ZTduZVQ2TjA3WktTMGNzVWkvSzVCTWNLOGJNb2RU?=
 =?utf-8?B?S2lQbkZwT3gvOGZoaXVlektJR2w1ckJ0ZzZBMWQ2Rzl0aktOVFh1TFQ3RHU1?=
 =?utf-8?B?cHBBZ3JKMWVsN0xVbnpyK3JkUTdyalZWYzZoRnRxTFlUckJJMGVRTXhYTW1m?=
 =?utf-8?B?OUlneTM5ZEcwVGtlS1kzNHdVMVF6c2NXMkMvdWJzU3pIU21ERWhEWUh3TUp3?=
 =?utf-8?B?bDdjQ0JOY0hPRXJDN2d4T2FkMFJITmRjQ3R6RWRFcW1GSkR6NmtKS3dxYkUz?=
 =?utf-8?B?Y3dSdXlFdkliMXpqbTZRUm5EbXNsOCs4L0gycVVHakVJdGc1VnNBLzdaa0xJ?=
 =?utf-8?B?R0ppLy9xZFF5K2JYVTFWZFNGcUpxQSt1REJRUGQ2VVJNOWQyM2tPZEhoZnd1?=
 =?utf-8?B?ZDhjbU0yTUpNZGxwYjZkaDBZb09xRVFkMi9yQUhKd0VzNVBXK0dRRnpUeW1z?=
 =?utf-8?B?anBsUXZ6bEFqblNVVythQnorV3dURzNuNyswV0NBcXE3WEQ5YktUaFFYQmF3?=
 =?utf-8?B?cmZFVk9ZRkJpbHB2UDhtWThscGNKRGdqNnI5UkJiYXRTVFpOWjNjS3pSRlQ1?=
 =?utf-8?B?YzVzZnpSV2NnRXlHRFJrVGdSbzBoRWp5MURoaUQyZG5PWmlZTGE3MTBJaWxC?=
 =?utf-8?B?dzU2amRKL1hUbmVxdWhsaHE4dWZsbTNTeFRhMHdYM3loMlVrajV1SDJleHBR?=
 =?utf-8?B?eVluMVhHbUxDZGJ5M2I1UHB6enFTdDhWS2JEdllETFdyVSs3NXpuZnQ2d05V?=
 =?utf-8?Q?IBC14lPBXg5AUEMS7r9o1WqLqZOfx+VM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 04:54:41.0850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5f68c9-5a0f-4b80-8849-08dcdd1e2a83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995

Hello Chenyu,

On 9/24/2024 6:40 PM, Chen Yu wrote:
> [..snip..]
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 225b31aaee55..2859fc7e2da2 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -1025,7 +1025,7 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>        /*
>>>         * The task has consumed its request, reschedule.
>>>         */
>>> -     return true;
>>> +     return (cfs_rq->nr_running > 1);
>>
>> Was there a strong reason why Peter decided to use "rq->nr_running"
>> instead of "cfs_rq->nr_running" with PREEMPT_SHORT in update_curr()?
>>
>> I wonder if it was to force a pick_next_task() cycle to dequeue a
>> possibly delayed entity
>>   but AFAICT, "cfs_rq->nr_running" should
>> account for the delayed entity still on the cfs_rq and perhaps the
>> early return in update_curr() can just be changed to use
>> "cfs_rq->nr_running". Not sure if I'm missing something trivial.
>>
> 85e511df3cec changes
> if (cfs_rq->nr_running > 1)  resched
> to
> if (rq->nr_running == 1) not_resched
> which does lower the bar to trigger resched
> 
> Yes, I think your proposal make sense, the resched should only
> be triggered between 2 cfs tasks,
> and the restore to update_deadline() is not needed, something like below
> in update_curr() could also work:
> 
> if (cfs_rq->nr_running == 1)
>        return;

That seems better IMO unless there was a strong reason for the original
change to use rq->nr_running :)

> 
> thanks,
> Chenyu

-- 
Thanks and Regards,
Prateek

