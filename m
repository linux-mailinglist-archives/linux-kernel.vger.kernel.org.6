Return-Path: <linux-kernel+bounces-214295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5F0908267
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25ACD1F23DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C9820317;
	Fri, 14 Jun 2024 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iMpgJrQV"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1420E3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718335031; cv=fail; b=S3IfNOiThNF2KfpIOTt1Pc8XPccPG+LZs5a61F/uuGsJhb/Itf2PLj/eEYnzaANHzj6CasW+gGCHDNU0xo1/XBu5Vccds77weg2HzPownDBW/xGg8qdgAX2uMr+6YDBmkipUqqYqu0DumMkW1VnSqro58sRwzM43zOcoSJjTY30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718335031; c=relaxed/simple;
	bh=ykqidsgFAoNxDR87IAUjprEGWq5CDvgu4XQkflklKHI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=OZ8+HPAD5omjzkIHRhrHHi3bKFmVHDvZHbh2a/JdSNLXpn2LuoHL8z75rvcfN4zCQbgMJFoOJ7PTfSjmB2eLcRMH2Bq+lj5O7qKo4FTNqNIbhoEEPcC97wmEwdtoXMMeij1oyfZv2x/O1SS6EclRhr4s84VZ5EbCM99fnudZqaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iMpgJrQV; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJaV+Cf8dD4T/7YhcBCCQ2EvOSlvoinJGb2IB9dYb8VGiV8HmpgeEp2k6FhJG8nJkJs46lo2/UPk7vM/aLqAxhDSRt/qaFTn2aPQJpjTqrdfQ3wzQH9hzJkx1+sKyz9xUG0W992B+2Vlv0yWA+44nUuTw3XxuuW5UmAZwvs+DNTI7RdIqTbHmPKPEHPbUddgxgJAJxc+Mb2ymZyJeAbm0VCaV+wyxnJ8AuI5bXjuY6wa34f2mj9yJJorjTX9Ouz8/Af8EsTbhiaKMSZxh+uowyG5Op1A+0bTPa1hpLMDTdrSVlsFcAJvVEwdjwVOtoNCbtkejhuO1sfajCqOi6o9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4up+KkEKzR6JuI/z2bXW8rhjZOi2hDaceFvJ66SbO4=;
 b=AOuE0p4Uponh1DMJv+Ewvd4K+fmxvtAkN8pjf0JQOlLN77I1lCd+UA60UR7lfBy8EGJgFcfbwMK3OB5iy0epBlrcf64cuu32g4XEMqsr64XPfIKWOmogmd5pv/KO2n+yOmLrn5B+2nQN3SKy61HDb4HNXX4zjxZpARgY+8Y7N2ZLDnSLxA1A2qshhYSDBl5xw434zsipLBe5v+VlTdaxeMUGP5tSko4v/CCipbldJ6AMECceFgXuHMBZC46O5cCrwiv5DerPxdBrxPr+4tlLYbnUpufbzl0OjQuuix5jz8pqoRFGvgTOmlAaWcsRNRLY4hHimK4Nw/EPV9NrK5yXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4up+KkEKzR6JuI/z2bXW8rhjZOi2hDaceFvJ66SbO4=;
 b=iMpgJrQVSPa+I5zvKr6dmvZ4DSijjUQQgPYB61OadNzMsVNgj7K5zfRuAsumOLXETmLlA/pHy2GOWVpEEJYL5uHQOFWpoX8nJozdJdOuUgBa+agjrxu4fHaYEbpVlyZyJdX/q8CFkG3Qq5kDHX+tsIs98qwh1ZXRWFH1nlv9tlw=
Received: from BLAPR03CA0134.namprd03.prod.outlook.com (2603:10b6:208:32e::19)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 03:17:04 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::87) by BLAPR03CA0134.outlook.office365.com
 (2603:10b6:208:32e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 03:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 03:17:04 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 22:16:56 -0500
Message-ID: <4c285c36-6893-c0c4-1061-0d7e16445e9d@amd.com>
Date: Fri, 14 Jun 2024 08:46:54 +0530
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
From: K Prateek Nayak <kprateek.nayak@amd.com>
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
 <9d83771f-3d12-25f0-c3f8-70dd7942e9ce@amd.com>
In-Reply-To: <9d83771f-3d12-25f0-c3f8-70dd7942e9ce@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0feaa8-f8ab-4dc4-47f1-08dc8c207708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|1800799019|7416009|376009|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUZpcWZUUHhIQnVtQ0x3TitDdkpSd2dLcDErUVBpYWVkTXZlQTF3N3ptaFp0?=
 =?utf-8?B?cTVxelA1VFpUc0l0WVY3cE5QUDF1NklkLzlaajN0TlNEZ3k0ZWFRdUk1WExG?=
 =?utf-8?B?K0ZSV1dDaFd1SnNaSEIzd0JPcnZxY3dWYzlOZDlsejIwaFJxclRxNjdWWFZ4?=
 =?utf-8?B?VUtuY1NnbHpRK2sweG5zNzl6MGI5ODZ0ejM2VkRmeDZJWjMvY2I3MnBZWHhL?=
 =?utf-8?B?c3ByWEl0VU1MVGJrMEE2L3o4cXdhOVJZdXhSWlM5MWRkWGgyZUhZYXlyOWh5?=
 =?utf-8?B?dThVQmJJb1NJdEhxb3hmUzZCcjZWZmVVMXA4TGk0UTJram5qbUx1cTRISitH?=
 =?utf-8?B?QzVDVmtBbnZnVldUUVd1RVlab3NidGl5eklmU0htSEk5OEVvbThubE0xU0pC?=
 =?utf-8?B?djRKVmpWblRpTVJLaUVodlUyaFBSMG4raWNPbzh2dlUxcEo5MGVMOGcrQ2pL?=
 =?utf-8?B?Uk9neHNTRS94T3A4Uzd6T0JyZllQQVhHVHNMWEROYTNGTlpMdHlGYjJEVHJE?=
 =?utf-8?B?bGNNc0JjdU51cldVaTgyS3l6SFBMSHJKT3ZpQjVmSm9XQXNtUTNrOWliVEk0?=
 =?utf-8?B?cjc2bGw2dm51cXNPbU5YdEtacURVK3ZNZk5IaGhJdnQ0K3cvelIzeDRIei9Z?=
 =?utf-8?B?U3QzZ1dQV0UzTHhPbUJpejM5TDFNcW1RZDF2RlJ1eWlLU3VtQlh5R214S2Fj?=
 =?utf-8?B?QW9JOUpoN2kyNFJRdFNwWTZkVkVvaHpWV1lBY2p1Y1F1dW5nMHF5TmVndXBo?=
 =?utf-8?B?VXN5YVcveEk0RnRONWxqWG9yeHMrbmZRUzMvZnFUR3FkbTc1UTc3MU9SMzdL?=
 =?utf-8?B?OE9Da21Ob2NraEplR1c5Vkp0VEppZWg3QzBEcWt6bjdJSGhTd1BQcVVPNjFa?=
 =?utf-8?B?cndVRDQweUtQbVNKTzNnamxOYmh3MkxoUHhpVTg0aUFvNHZZWG5UU3pNaVZx?=
 =?utf-8?B?YS83dlVoRG1aMTJOZVpLbVV4Y1JKK0EwZFFEK21CSHpQcEV1OW5PMHgvZkVN?=
 =?utf-8?B?M1BMcnljMko4QWdESVZISU1KcW1haUlySnZDNzA4UGR5Q3dTVXJ3MGxuQnVM?=
 =?utf-8?B?WUNkWTVMY0JjRUFwb0ZYNThUS2g0OEFGQnlOR0lvNE9ER1FJbXFGbFRzOExJ?=
 =?utf-8?B?Qmg3ZWVUNWNWRk5UU0JOdENNWGpBbzVjU1ZLQnFQRWUrZFFlYW4ycUs3REFS?=
 =?utf-8?B?d2J6RHE0Wi94NTZaMnNIbFVLM1dodERvbVYvNFpnSXlkaFlLU1ZJbzhvdnZK?=
 =?utf-8?B?dHpYL3FpRUhNR0tUeGNwYlBRTVpEL252SUhqcXZncFBrdGY3eGs3dENnQkdz?=
 =?utf-8?B?d1ZFbzc0SGphdm9EelV0RUs0QUZpYlRXdjIveDdTdVZtVzNSZTVXK1orQzAz?=
 =?utf-8?B?dkh4ZEF1QVl3OTRMMVYvLzZ0cngrU01UTklwWGlnMitOYmhud1E4SHBleVdX?=
 =?utf-8?B?ekJTQldXSWwzMG92YjlBcmNzMkcrZVh4dGlZdHNLRjNBRWZWRDBEanR1aGNn?=
 =?utf-8?B?cmJDZlhBSFJodFM3OUc1Q0d5WFY2QS9Wdmpmc1FMVEJGK3N6V3NIMzEwbDkr?=
 =?utf-8?B?bklwYkJCVW4rZDdMVkxxVWViTmhYcmxpbEFJRndiN1VyWVZxLzRFN3BhanNJ?=
 =?utf-8?B?MFNYeUtnT0p2K2Nzc25LYXVEOXRVaXliNXJhc3RpQWNCbE8wNzhHRDRXNHBl?=
 =?utf-8?B?WC9zT0g4Y2Q5TmkwVElnR3NVelM4T2pzZkpYVVlCMU00OW8vNXpNYnY1OUtM?=
 =?utf-8?B?NWlQUFhaRGJFNXBvZmtrZ0pQbmQ3MS84M3pkK1c5S3QvcXBWYmdGa2lJWVNa?=
 =?utf-8?B?eUY2Y2txTndCdGNQcjBMZUZrb1lxMzBnY0VQZ3B1WU1Janp2aEg5YmxlcTJN?=
 =?utf-8?B?UE4yWWlrR1hueFhmT2JmeU03ZW5PMXM2UWtPV1QvYjBDM2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(36860700008)(1800799019)(7416009)(376009)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 03:17:04.1141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0feaa8-f8ab-4dc4-47f1-08dc8c207708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

Hello Chenyu,

On 6/14/2024 8:41 AM, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> Sorry, I'm a bit late to the thread but ...
> 
> On 6/13/2024 6:53 PM, Chen Yu wrote:
>> [..snip..]
>>>>
>>>> I wonder if we can only take care of the NO_RUN_TO_PARITY case? 
>>>> Something like this,
>>>>
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index 03be0d1330a6..5e49a15bbdd3 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -745,6 +745,21 @@ int entity_eligible(struct cfs_rq *cfs_rq, 
>>>>> struct sched_entity *se)
>>>>>         return vruntime_eligible(cfs_rq, se->vruntime);
>>>>> }
>>>>>
>>>>> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, 
>>>>> struct sched_entity *se)
>>>>> +{
>>>> if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1 ||
>>>>      !entity_eligible(cfs_rq, se))
>>>> return false;
>>>>
>>>> return true;
>>>>
>>>> Thoughts?
>>>>
>>>
>>> This does indeed look better. In that case, do I need to make the 
>>> changes this way and send
>>> out a version 3?
>>
>> If you mean the following changes, maybe we can continue the 
>> discussion here.
>> This is just my 2 cents, not sure what others think of it. Anyway, I 
>> can launch some tests.
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 8a5b1ae0aa55..c0fdb25f0695 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -744,6 +744,15 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct 
>> sched_entity *se)
>>       return vruntime_eligible(cfs_rq, se->vruntime);
>>   }
>> +static bool check_curr_preempt(struct cfs_rq *cfs_rq, struct 
>> sched_entity *curr)
>> +{
>> +    if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1 ||
>> +        !entity_eligible(cfs_rq, curr))
> 
> Shouldn't this return false if "entity_eligible(cfs_rq, curr)" returns 
> true since curr is still vruntime eligible on cfs_rq?
> 
> Would it better to have check_curr_preempt() as follows:
> 
>      if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1)
>          return false;
> 
>      return entity_eligible(cfs_rq, curr);

The above return should have been:

	return !entity_eligible(cfs_rq, curr);

Which returns true once curr is not vruntime eligible on cfs_rq.
Sorry for the oversight.

> 
> which returns false if curr is ineligible and scheduler can go ahead and 
> and call schedule to evaluate the next best step?
> 
> Please let me know if I'm missing something.
> 
>> +        return false;
>> +
>> +    return true;
>> +}
>> +
>>   static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
>>   {
>>       u64 min_vruntime = cfs_rq->min_vruntime;
>> [..snip..]
> 

-- 
Thanks and Regards,
Prateek

