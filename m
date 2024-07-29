Return-Path: <linux-kernel+bounces-265283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9799993EEEA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA8D281F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5356512C491;
	Mon, 29 Jul 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WsuV0N8v"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D284A2F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239310; cv=fail; b=pIwtp5D5kYDJSZdRggGtNBD4cpWljzWBlCPmGCKE6o9NSqy2ru+fkuzndRVKzgdXTx/WPsGL+pzyzxG6hlz2h27rRzENfk4ii1CCC/uF7i9iK7tK2JmoBNsLmOEpWkTeSwaqIbG20Fa8xHkn6Iq01i9r5BPnSPlsoh9UKqtHDNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239310; c=relaxed/simple;
	bh=plABEntOfYNLBhfKI2gDycqfyoeK1Glzl9I6H87axKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HTvYxYc6R8lvSKS40tKOwxHhI/LwpljOw6OiTC0oYoh6LgxejfgQyARleo8RlIMBoMJTsIEMdwbrxvzmBOYNFV2xkjjo0UieL7o5nwN8VTYbIejpctViZFr4/T3TiPzPU/flE+4WfXGlhFz5x0Oob6vARZEMQefdh2CyEx1MElY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WsuV0N8v; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCT3T4bnzK77PZJ/YBZMytFigh0ZzpP8YXPo06bRXNRoj6PsCo5ktn8OiymE7PYzYLbwBfq9lUaCuRlG3Hth8dqOU/E5JsMhaPWDIImWWSsgXNKMzpcC494+w38iFWX1b72prmaHUBP1xp1sibBOtyQRQFaHcBjRqji/j42D97r7g5S3Oc4bSAI+xmfg7rEQGTQ7Jj9VKRlaGSialVAxhlb0m3sapC8Qia6rpB1torpVXnpfLd84iyoNCLuOXLzq3ZwGTGZ4YCwZFl4VBE4Ix8c+YwBZFyNsEXwTkRDdAf9IGafpB1rxTg287/ob2ilM/a15HXVYlAlrXHu6tMg48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oC2Qiw75u4FEXTnYXJYc6TqZkbDAi1SBUp7qL/+Ffg=;
 b=iqyr9IQuLeeXEATWYJT+G/vVpI4Dgv4Jk8lGsurzkRO2DDujeqAF3VBt4i7QJPCxx5ahwxlhCeDIArRZJD7rUskb9z6UzR+Ces8Pb4FdDtD5NZRqibMGV4ZcipIbZt4fzzhxsPZPZDswLaAicU1n+bcdKFKotYl+3AM0zT4wYPiEeGPD1eJsg/o/nzVPO4/IiZ0nogUK0Keo4UfvjnBlXB/sCoNjqays+e+NItjS3vHxCoJT1dnii/ppvQoYvBJYjNBhnuj4ExnXWJILXfiS1oceyZiTNM8yWaS7RKk3ZIVy6+F2Y216Yj4xROIHsU7OIgfKOnE4cSbniYTYfG+C3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oC2Qiw75u4FEXTnYXJYc6TqZkbDAi1SBUp7qL/+Ffg=;
 b=WsuV0N8va0Fq5qb1mGZaSmQjdD63AGI0D7eERokv1ejD4x52vBSTM6qbPdo3Dq+7DvB0gegaxNiDBFw/OeWybKGTX19b0Op+Hcc/RFyfps7tsVi7FXGBPQqmzrSJkP7HNutVsdT6LSeR5xrcMazWlMo+MOpJi3Lmt9W4qF6baj8=
Received: from SJ0PR03CA0136.namprd03.prod.outlook.com (2603:10b6:a03:33c::21)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 07:48:26 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::6b) by SJ0PR03CA0136.outlook.office365.com
 (2603:10b6:a03:33c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Mon, 29 Jul 2024 07:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 29 Jul 2024 07:48:24 +0000
Received: from [10.136.40.92] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 02:48:19 -0500
Message-ID: <172eaa76-0ee9-8c7d-df33-77e9696bb236@amd.com>
Date: Mon, 29 Jul 2024 13:18:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] psi: Inherit parent cgroup psi enable state
Content-Language: en-US
To: Chuyi Zhou <zhouchuyi@bytedance.com>
CC: <chengming.zhou@linux.dev>, <linux-kernel@vger.kernel.org>,
	<tj@kernel.org>, <hannes@cmpxchg.org>, <mkoutny@suse.com>,
	<surenb@google.com>, <peterz@infradead.org>
References: <20240729034100.1876510-1-zhouchuyi@bytedance.com>
 <0a6182b4-e5e8-0eb6-234a-9097fffe5069@amd.com>
 <1cc3630c-6b2c-4eee-9757-873c17d42e9e@bytedance.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <1cc3630c-6b2c-4eee-9757-873c17d42e9e@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c10f4d-d5ff-401e-9751-08dcafa2d3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUJIdk4yRFlRNHFaYjc2aGRtLzZnbTh4aFBEZHFLTW51OVRQVlF6TThET3pK?=
 =?utf-8?B?RGd6UEpjd08yOVZUOHJGeGNYdDdybDVSSDRPNFE5SURtRXppanp2VllQWTVV?=
 =?utf-8?B?MURUa3RFMGxUanRXbHBNSmw1b0NXdnFGdERJZjN5UGRkRzduZ0c3SDdWOVkw?=
 =?utf-8?B?SVhaNEZTdDcyZ3laVGwyK0JvL0VKSVJ6VTdnYlk4Zmd3c290MmpONDJFaURt?=
 =?utf-8?B?U2g3T3JhZWE5YUZXbHhydHl5SnpkcDNhR0xta2txV2l1dUlXRFEyNTJxNVQ2?=
 =?utf-8?B?NlQwSVhkYzN6elR6c2RHbnNXYm9ka09sZ3R1RTlob1VidWxtRG1tSGZCeHha?=
 =?utf-8?B?bjh2bTlHMlQzMDJqY09jWjI3dlFZR0J6UlJ2WXhkSXZHcGNjZGt0bmt0Z3RZ?=
 =?utf-8?B?bGtYUHlRckFDMU1lY2F0RmtWb1diU3VNRTVaQnFxaFpoVEdBanFKejhTS01J?=
 =?utf-8?B?ZkNONkx2OW5ha0JpRytJbTdhMk5nK0pVeThSWEI4dlRUcGowMzJsalZteldY?=
 =?utf-8?B?bWIva1ZNRE5sQXlHWXlSL240VFZZYmFwejFWaHZLY1pZbERPSmVraFJHQlFr?=
 =?utf-8?B?RjU2S1hPM1ZvYUNBYmNLR1Mzbmo5YWNTcHVmTVppdlFpMXdyb04rWVNYSi9V?=
 =?utf-8?B?QVlSWXNoVlAzOTB0M3ozMlBsazZIelZQZ1ZWcFBxbzVJdHFIcUhkMEowc3pM?=
 =?utf-8?B?NUZKN284eVRqb0R5QjFEbzZmYVBJb2xoZTFENUpROC9yc1ZiVVoybUdSRWFl?=
 =?utf-8?B?VnZicExzWDJjUldadUZhMjRvYU5EZUxhNjMxV2JCYmhUNWZ4VlMvUGNMckF2?=
 =?utf-8?B?aVV5eHlqSDFrZGdpaGhvOEJIREN1RUoySXE1eW9zN0hDMlFNSmlxdldSMTBn?=
 =?utf-8?B?VnBWUDBrc1lRQnJKQzdnL3htOWVsTmtZYml1M25XL1Qzak9wNGRNeUVOZnUv?=
 =?utf-8?B?T1hhU0Y2T0ZvM1ZvSlpCc2tlRVc5WjVaQWdTN1Y4N1pqT0UzbXpmbkx1a2lr?=
 =?utf-8?B?TzMzcVNrM29oQUVyd3ZTcWp4Z29RbVN0K3NMSjhEc1pia3hjZnQrTzMvSmI3?=
 =?utf-8?B?SzlyV3l1R3hpYmRhOFYwNFppN005ZWFsMEt5TFpDMTlmY0h4d1h2N1pKVFFK?=
 =?utf-8?B?ajg5QzUvR3RkNWMxSktBU1lxOGVaUkVNL1I3SmR1WDF0bXRsUVhMc1ZSUlVz?=
 =?utf-8?B?dDhQU2ttUlJtM2s1ck84WldEMytRamJkZitlVWlubm9kM2VnYzVsbHdsNmw1?=
 =?utf-8?B?eVVKZHk0bS9nZStZaTVsR2dJbklPbWhWcU9qZ29peWxVNDJGR0ZhMkMxNHd3?=
 =?utf-8?B?dWpJUTJCc3QwcCtybUFxZE0rdWw5SHQxRklJT1FoUnhYQUl3blVpdmZNWjNI?=
 =?utf-8?B?eFZJVFBCcGVvbTZvR1lpWldqMmhwQitpVHoxZ244VTNxT0J0UTR4U0IxeVhU?=
 =?utf-8?B?cm5CU0pHUXg3N3RxRXh0QWI5QXBMcXIxZFIzdEh2dDk1L0w5dVdPRDdVNUU2?=
 =?utf-8?B?ZWQyUUdWU0JxQjJTc25KWHFlSk8rWVcxNVllOEFBb20yeWJqV0hPcXh4cTUr?=
 =?utf-8?B?dUF2K0pUb29uMnl4bHpLcEYxR2hLZmQ4bnUxUmNoaThNMmoxMWxFTmowN2V0?=
 =?utf-8?B?bVB4R0lxSER4RDFlcHZCTUJ4RHJJRkZSdS84a2ZYS240NGswUWpzaDhCelEz?=
 =?utf-8?B?VU8wZEE2Qi9XWXphWnYxcUMrQnRJUVEzTHJnZ25tNU5WVjYrMlVRV0VJaUpz?=
 =?utf-8?B?Q1cra1dUV0tOM2o4eWZFTVJxdnpXVVI4V3ZMcllGTDBpTW9FWndtaVE1RlZ5?=
 =?utf-8?B?TGVkOVNlNHZtdlU2OXl2T0tTNVI4S1Y1RUVNdUdISFhTYjVjS3h3VFBncVlr?=
 =?utf-8?B?cVRzQjVsMFVvVGJuL3lJV0dGcTNmWXNvaEFYdzhFbFkwcnBNVGk2SFRnb083?=
 =?utf-8?Q?dNYvnnAtQvT9cWqhez/esRl11Ud37RhG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 07:48:24.8884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c10f4d-d5ff-401e-9751-08dcafa2d3a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498

Hello Chuyi,

On 7/29/2024 12:01 PM, Chuyi Zhou wrote:
> Hello,
> 
> 在 2024/7/29 12:45, K Prateek Nayak 写道:
>> Hello Chuyi,
>>
>> On 7/29/2024 9:11 AM, Chuyi Zhou wrote:
>>> Currently when a parent cgroup disables psi through cgroup.pressure, newly
>>> created child cgroups do not inherit the psi state of the parent cgroup.
>>>
>>> This patch tries to solve this issue. When a child cgroup is created, it
>>> would inherit the psi enabled state of the parent in group_init().
>>> Once the enable state is found to be false in the css_populate_dir(), the
>>> {cpu, io, memory}.pressure files will be hidden using cgroup_file_show().
>>>
>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>> ---
>>>   kernel/cgroup/cgroup.c | 21 +++++++++++++++++++--
>>>   kernel/sched/psi.c     |  4 ++--
>>>   2 files changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>>> index c8e4b62b436a4..775fe528efcad 100644
>>> --- a/kernel/cgroup/cgroup.c
>>> +++ b/kernel/cgroup/cgroup.c
>>> @@ -1719,6 +1719,24 @@ static void css_clear_dir(struct cgroup_subsys_state *css)
>>>       }
>>>   }
>>> +static int populate_psi_files(struct cgroup_subsys_state *css)
>>> +{
>>> +    struct cgroup *cgrp = css->cgroup;
>>> +    int ret, i;
>>> +
>>> +    ret = cgroup_addrm_files(css, cgrp, cgroup_psi_files, true);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    if (cgrp->psi && !cgrp->psi->enabled) {
>>> +        for (i = 0; i < NR_PSI_RESOURCES; i++)
>>> +            cgroup_file_show(&cgrp->psi_files[i], 0);
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +
>>>   /**
>>>    * css_populate_dir - create subsys files in a cgroup directory
>>>    * @css: target css
>>> @@ -1742,8 +1760,7 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
>>>                   return ret;
>>>               if (cgroup_psi_enabled()) {
>>> -                ret = cgroup_addrm_files(css, cgrp,
>>> -                             cgroup_psi_files, true);
>>> +                ret = populate_psi_files(css);
>>>                   if (ret < 0) {
>>>                       cgroup_addrm_files(css, cgrp,
>>>                                  cgroup_base_files, false);
>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>> index 020d58967d4e8..d0aa17b368819 100644
>>> --- a/kernel/sched/psi.c
>>> +++ b/kernel/sched/psi.c
>>> @@ -180,7 +180,7 @@ static void group_init(struct psi_group *group)
>>>   {
>>>       int cpu;
>>> -    group->enabled = true;
>>> +    group->enabled = group->parent ? group->parent->enabled : true;
>>
>> Since this is only the init path, if the user later enables PSI
>> accounting for a parent, should it not re-evaluate it for the groups
>> down the hierarchy?
>>
>> Looking at "cgroup_pressure_write()", I could not spot it calling
>> "css_populate_dir()". Should it not walk the hierarchy and do a
>> "cgroup_file_show()" considering the changes in you patch?
>>
>> (P.S. I'm not too familiar with this piece of code so please do let me
>>   know if I missed something obvious)
> 
> Perhaps my description in the commit log was not clear enough. This patch is intended to make child cgroups inherit the state of the parent node *during initialization*.

Ah! i see. Thank you for clarifying :)

> The cgroup.pressure interface remains the same as before, only changing the enable state at the current level.
> 
> In production environments, the overhead of PSI could be significant on some machines (with many deep levels of cgroups). For certain tasks (such as /sys/fs/cgroup/offline/pod_xxx), we may not need to monitor their PSI metrics. With this patch, after disabling /sys/fs/cgroup/offline/cgroup.pressure, any subsequently deployed offline pods will not enable PSI. Although users can disable PSI by traversing all cgroups under /sys/fs/cgroup/offline/, this may not be convenient enough.
> 
> Thanks.

-- 
Thanks and Regards,
Prateek

