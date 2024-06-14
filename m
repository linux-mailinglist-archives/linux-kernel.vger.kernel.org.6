Return-Path: <linux-kernel+bounces-214292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967EA908255
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4082E2831B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543E11836D0;
	Fri, 14 Jun 2024 03:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ff+MjqvL"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D719D880
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334736; cv=fail; b=u5XBTE5985iVl8SHVkBFbF4VSV4jkiAct7EMLeuRoqsuOpWzZNtt0PNVMIAkT0wZvLCl0B5jx8Z7gr9oBJTqP2+yhi/6Q1ob9Edg+OkJ4nKKE/4/32S5nGmXkLlYfibBDwBdluq1I8NL8j6DZ+stGDOn4VVDUEwBNpQVj7r6ymE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334736; c=relaxed/simple;
	bh=wPfAjNm+6a1w+PORoVmHyftISqaeCQnOtjFgUmY06pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hx8o/B8z+HCSOdQQM6m9ajbhut9wBQPOO/yLqtjiBM8t+M9aCz+7pmIEe2qZMmIR6DqMCUok+akCeEbwK1hMfXgre0aAXcs7p1L0K8wEHDwhHBLgVRqPr/urdJRnDNdh9PUX7IGNXXL6Tv4gUrnTXVgS8f6EkEeRcqH2KbBEULM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ff+MjqvL; arc=fail smtp.client-ip=40.107.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H37bDTgOvNx7mgAMCQv9dQTEVMMdkYlsMXlTMpIwzHYDD6w57YFq8+j5YGd7ofdzQ/S3QUtkufo3S3camcONU/lApqejRxopKShj4L/OB1z/IOKWrYtPqNMqrvcPebPe+MwfkyxjVUZtIsARRRKLi+WSlCoUuHBBADE5q6N9nexeisaWCo/d7DoR6QW5cS1cungdh9PK6F/CQPJj7qQGYtudP+HQiYnVfor6vpzKtW8BqDrLiYlB//1Boi52DwFFRYkaUYvA5na7XSA3mDzIkHFWI+HoAHiNEPQlpElFP/JTe3VeN+qvjgsVreKXjhomtrkbRNTQ+WZhIiObPxiiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhEFF9AfwdmrmKvtt0EFzM12CKcIYTQvA2p36oUirKk=;
 b=TyK753XN9B8JGbuAnLt6LdeiSkTW9D5pcnBt6PLZK6/R0JD/auAQCpP/6sjFHZYUcn1VeS7BIIQOLzxTPNhTMKudpJsVZVibG9jwVTfpu+XRedLId+SRjZXhUrzDQU63gjyqg0yfiIn7To7d1AT9KGmeparmxwsUgmOsidDGf+i0UxKioAAgB8yuBhPNtyJqUj5RaW7wRReokjUwIBeBbip4oBZpCYGQzqKzJmBHmFdrFd43ZdK9rNVhEF5t9oqMQee8ii9wDU6Z2zvuKYEbgKsvQazIM5wY6w06h4T0jIeO7LxhqdzypfAAJjsBEQZiPvVEhlrexMl4k6jxhe4X2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhEFF9AfwdmrmKvtt0EFzM12CKcIYTQvA2p36oUirKk=;
 b=ff+MjqvL471dh6tu2Fr8J4pId+i4y0zYxc89nFrBNvvVYvTVcXIk9Z8TJQcs6tD5qMM0a+gJuaEzsBSK3xyTlloZhH4WKSLrjPrPh4lMXqovdtZUbJQ6hPk32OnD3rxe6xHJBlCn2/TfNHX7o9HEiSa1roND19Xm3+6MD0mK6EA=
Received: from MN2PR04CA0014.namprd04.prod.outlook.com (2603:10b6:208:d4::27)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 03:12:11 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::cf) by MN2PR04CA0014.outlook.office365.com
 (2603:10b6:208:d4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Fri, 14 Jun 2024 03:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 03:12:11 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 22:12:05 -0500
Message-ID: <9d83771f-3d12-25f0-c3f8-70dd7942e9ce@amd.com>
Date: Fri, 14 Jun 2024 08:41:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Content-Language: en-US
To: Chen Yu <yu.c.chen@intel.com>, Chunxin Zang <spring.cxz@gmail.com>
CC: Honglei Wang <jameshongleiwang@126.com>, <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, Mike Galbraith <efault@gmx.de>,
	<linux-kernel@vger.kernel.org>, <yangchen11@lixiang.com>, Jerry Zhou
	<zhouchunhua@lixiang.com>, Chunxin Zang <zangchunxin@lixiang.com>
References: <20240529141806.16029-1-spring.cxz@gmail.com>
 <ZmKVjmuC4kGrUH5V@chenyu5-mobl2>
 <2E6EB0D6-D913-4205-B7DD-35EF4FA25667@gmail.com>
 <Zmrd2hwqHB8RQjqB@chenyu5-mobl2>
 <112FECA8-5D21-406F-814C-ACBE63351CBB@gmail.com>
 <ZmryuDqw2fEhHNni@chenyu5-mobl2>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZmryuDqw2fEhHNni@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: a7cf57f5-50b5-432e-a9e8-08dc8c1fc87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|1800799019|7416009|376009|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b25wM2NrUjd2UStGaDhFd0VyTWxqR3crVnRFQS96VVhLV3RHNm5JRitjM3Nl?=
 =?utf-8?B?cHYxOTlJS01McDBwWWZXTE1jL1JyWlRlSFozMFRwbE1RYzhBY1BnVlRUeVdw?=
 =?utf-8?B?SmcvZWwwbVVRamkrcUFWTVV0Y0hESlZ2aVpWcEZFLzJ1UTZTZXBxQXpkUEs3?=
 =?utf-8?B?bkE2WVBka2syeW5ka2p4ckhrOXhqSjJxSHE1WXRNTkhFcmlQOVc4SFE4WTBV?=
 =?utf-8?B?b1VKZHVxTEQ3ZzVDay9jbVY5U1RPZ3ZkVHRJSGxUL1ZZbTNsWjllV2tUTTRj?=
 =?utf-8?B?eW1xY2dGMmVubytZaUJPNThuZGw0TWlPRlQwKzJ2WFZYelZkbXNZaW5pTk0r?=
 =?utf-8?B?b3RJTi9YamFCUWsrc29oTXBkemhTNHd6SHljV1cxYlM3YmNzU2x0N1RRRTZp?=
 =?utf-8?B?RE5EM3hHQzlMT2wySisyR0hUcWR0NmRIZ3dwZ2lNOGVQcG5NVjdDMlpsTFYv?=
 =?utf-8?B?Nk5iZlA4eTQrWUZ4YnZXR3hDVmtPa0dHQmpRTDFmYVgxcVVvc0NBY29TTzRS?=
 =?utf-8?B?enV4dkRTb1JwWWtSR1AzNHREcllyK0FvSnVEQzl2dkpXSDBDdmdmOFVsUXlN?=
 =?utf-8?B?VmY3bGNST3AxV0JDZjVOMk1zRkRYM1RoZ2lvUDBDZjdvRmk2TjZIblVwaUJ2?=
 =?utf-8?B?cHZxWkl3WHU3RGVsWmh1b2l3dGI4aGMvdEVvMU9FNlR2bXFuYmNLdTRvOFhG?=
 =?utf-8?B?LzU2Q3RhOEk5TEJVMms5dDduSGg2VWwzODA3NGs0cUxiSS9MdFg2R3dSV0c3?=
 =?utf-8?B?eWdFTUN2eGVUNVB2RHJDYUVzUllpaDdYdlU1MWwyTS9YK29UcUl2RzJVRkI1?=
 =?utf-8?B?aElVLzI1ZmR2bHoyVlBHVkNYMXZ0MTN4WDM4SVd0dTdKeHQ1Mm1KQnpEMzhF?=
 =?utf-8?B?U2RqRnducHU3TEp4a29WVVBJMEFXVjQ4NnFTTzQ4STY4aWxyZG1hSzlORWFT?=
 =?utf-8?B?MmNtOCtlTmtKWE92eFlkUVpQTnVJMDhXY3dOWmpydTAyeUY5azRCdHlYV3Nx?=
 =?utf-8?B?dVZ5Vi9CaXNFa0F2bWNxOWtlQ3A0ZFVkOVp0dFVEbW00ZmJPK3VmbGEyalBD?=
 =?utf-8?B?em1XY2dleGcyc3MwV0VobTBxc0xkamUzZjZFYTlNRDBweGR2ejlkdlJ4SVda?=
 =?utf-8?B?WU9WR05ubmJueU5qT0tOSVQvLzNUMWN4a01HcnNqY01YcWxkRUVXaXpsY3Vs?=
 =?utf-8?B?OUJaaVNTMmQ4dzhOd1Vib21ncDdSWVBuM2E2bkFhUEZlWTBHZVpUbW14MkZx?=
 =?utf-8?B?cVZ5QXRQa2NKWkI0QUxQYkZRbU9QYnhVM3BZWXJpL1hXVUlBbERodVpCVk9u?=
 =?utf-8?B?N1ZWZXR2Q0tDZitDVE83TXFIU3dFV0Z6NkFZckxKV3BiZTIwVjE1YU5OSjhm?=
 =?utf-8?B?SVpOT3U3bEd4K3NWWGcxTjFxcEYzOUFObjZLWW9MRi9tR09TbkNiYUJQc3Ju?=
 =?utf-8?B?amliR1ZHT0JtTXFyWDQ5MHBod3pheldLam5WT3FhaFpYencxY3ZwTXdpWUZY?=
 =?utf-8?B?bzA3enVoazhCcjIwcS8rZlJzbHptOHZlRnhjQTlOVldwcmRCckJwdVpwaTRo?=
 =?utf-8?B?VUpnS3I1V05QTFFxcmJQcXh2d050dnBiSC9uaU9xZUtwRXNWb3I1YXZKaVBv?=
 =?utf-8?B?bnBzRm5QcG84ZFJMM2JwWE10NjQrMWpxODRTZHA2SkhLY0ZBTHZKaGVOczNO?=
 =?utf-8?B?YXIxNUhuU0dtRzJVZ1pCWXpVckNPL0pHajhuNmt4QkNqTDNUSHRtUlg0T2hk?=
 =?utf-8?B?QmpjelVQL1NNTUpOOUlha3FGTmV0aENDaFhvWHhUR1U3ajBBZW5JMXNIMWYy?=
 =?utf-8?B?TERNSzQ1RlFYWEJnMnNGTXRzTEJxd3E0cjNFRkdqdGdJNzlPeUNheDQvUVdX?=
 =?utf-8?B?YTVmYVU2cVBHc0JHSzlkc0VpOUxFOFFiUW1IRnkzVThkNnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(36860700008)(1800799019)(7416009)(376009)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 03:12:11.3133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cf57f5-50b5-432e-a9e8-08dc8c1fc87d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

Hello Chenyu,

Sorry, I'm a bit late to the thread but ...

On 6/13/2024 6:53 PM, Chen Yu wrote:
> [..snip..]
>>>
>>> I wonder if we can only take care of the NO_RUN_TO_PARITY case? Something like this,
>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 03be0d1330a6..5e49a15bbdd3 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -745,6 +745,21 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>>         return vruntime_eligible(cfs_rq, se->vruntime);
>>>> }
>>>>
>>>> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>> +{
>>> if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1 ||
>>>      !entity_eligible(cfs_rq, se))
>>> return false;
>>>
>>> return true;
>>>
>>> Thoughts?
>>>
>>
>> This does indeed look better. In that case, do I need to make the changes this way and send
>> out a version 3?
> 
> If you mean the following changes, maybe we can continue the discussion here.
> This is just my 2 cents, not sure what others think of it. Anyway, I can launch some tests.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..c0fdb25f0695 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -744,6 +744,15 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   	return vruntime_eligible(cfs_rq, se->vruntime);
>   }
>   
> +static bool check_curr_preempt(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> +{
> +	if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1 ||
> +	    !entity_eligible(cfs_rq, curr))

Shouldn't this return false if "entity_eligible(cfs_rq, curr)" returns 
true since curr is still vruntime eligible on cfs_rq?

Would it better to have check_curr_preempt() as follows:

	if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1)
		return false;

	return entity_eligible(cfs_rq, curr);

which returns false if curr is ineligible and scheduler can go ahead and 
and call schedule to evaluate the next best step?

Please let me know if I'm missing something.

> +		return false;
> +
> +	return true;
> +}
> +
>   static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
>   {
>   	u64 min_vruntime = cfs_rq->min_vruntime;
> [..snip..]

-- 
Thanks and Regards,
Prateek

