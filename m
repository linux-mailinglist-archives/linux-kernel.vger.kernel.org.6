Return-Path: <linux-kernel+bounces-258572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8279389EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B39728185C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66F1B960;
	Mon, 22 Jul 2024 07:17:06 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAD5288B1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632625; cv=none; b=oYIybyhLxCDYFXPsmf3OBrF4NrJVzfMWMjFGE4eW1FDf+fb6HSESiVDta4Z82ZioS06yuJcjJ94XvtVh25zk9uqqHtzVydmspgZhgw80aVtz7SHUs2U6wKOhwnGi/lYKiQ8XKDjPbYemh6rvIQWRriAtVEDsNhvxRNxMtjs37+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632625; c=relaxed/simple;
	bh=02H5MdfWCLeVQl4Cp/E/DdSWzSnVbh5Hb1GYdeUzX8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VAiFqNgdgiMUu9Fd+XL4he38BGbDym+TlMEaPCnpj9XECPqyOpzomZhOgWIe2dv2Scergv/wV42yAhYix0HKEk4hsCBO+62b624xr4iVpwmAQREbJOgQO5a1y8Y4KeGPTbdTX92DwPAo9DxVcWRSE8LhBleVvPkNOidq9+lKnzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WSBQk3yrxznbss;
	Mon, 22 Jul 2024 15:16:14 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id 15404140415;
	Mon, 22 Jul 2024 15:17:00 +0800 (CST)
Received: from [10.45.188.173] (10.45.188.173) by
 kwepemg200007.china.huawei.com (7.202.181.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Jul 2024 15:16:58 +0800
Message-ID: <14c3db2b-5de2-4f1c-b4d4-6183568b8c24@huawei.com>
Date: Mon, 22 Jul 2024 15:16:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Decrease cfs bandwidth usage in
 task_group destruction
To: Chuyi Zhou <zhouchuyi@bytedance.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>
CC: <chengming.zhou@linux.dev>, <linux-kernel@vger.kernel.org>,
	<joshdon@google.com>
References: <20240721125208.5348-1-zhouchuyi@bytedance.com>
 <20240721125208.5348-2-zhouchuyi@bytedance.com>
 <91e88019-52f7-4fa6-a14b-ca5ecb8e63cf@huawei.com>
 <d0918be2-8d4e-427d-ac98-32aecffe3a3b@bytedance.com>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <d0918be2-8d4e-427d-ac98-32aecffe3a3b@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200007.china.huawei.com (7.202.181.34)

hi

在 2024/7/22 14:04, Chuyi Zhou 写道:
> Hello
> 
> 在 2024/7/22 11:47, Zhang Qiao 写道:
>>
>>
>> Hi, Chuyi
>>
>> 在 2024/7/21 20:52, Chuyi Zhou 写道:
>>> The static key __cfs_bandwidth_used is used to indicate whether bandwidth
>>> control is enabled in the system. Currently, it is only decreased when a
>>> task group disables bandwidth control. This is incorrect because if there
>>> was a task group in the past that enabled bandwidth control, the
>>> __cfs_bandwidth_used will never go to zero, even if there are no task_group
>>> using bandwidth control now.
>>>
>>> This patch tries to fix this issue by decrsasing bandwidth usage in
>>> destroy_cfs_bandwidth().
>>>
>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>> ---
>>>   kernel/sched/fair.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index b1e07ce90284..7ad50dc31a93 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6447,6 +6447,9 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>>>       hrtimer_cancel(&cfs_b->period_timer);
>>>       hrtimer_cancel(&cfs_b->slack_timer);
>>>   +    if (cfs_b->quota != RUNTIME_INF)
>>> +        cfs_bandwidth_usage_dec();
>>
>> This calls static_key_slow_dec_cpuslocked, but destroy_cfs_bandwidth
>> isn't holding the hotplug lock [1].
>>
>> For fixing this issue, i also sent a patch, but it be not merged into mainline [2].
>>
>> [1]: https://lore.kernel.org/all/20210712162655.w3j6uczwbfkzazvt@oracle.com/
>> [2]: https://lore.kernel.org/all/20210910094139.184582-1-zhangqiao22@huawei.com/
>>
> 
> Thanks for your information.
> 
> I think maybe cfs_bandwidth_usage_dec() should be moved to other more suitable places where could
> hold hotplug lock(e.g. cpu_cgroup_css_released()). I would do some test to verify it.
> 

The cpu_cgroup_css_released() also doesn't seem to be in the cpu hotplug lock-holding context.


> Thanks.
> 
> 
> 
> 
> 

