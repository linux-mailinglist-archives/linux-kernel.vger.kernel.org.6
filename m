Return-Path: <linux-kernel+bounces-193503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BAF8D2D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 092FAB27FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3415EFC9;
	Wed, 29 May 2024 06:20:54 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49AD1391
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963653; cv=none; b=MO83X9/qCjy5f2nFZ/lFvY80h8bk5SdiB6rkV+7UN9ZwznW0MCjGhBIuV+0MMHECbF3qLbTGkQe97zF0Mrp+NnkCQxefUmb2gaG1J/i6Wc1yBHvuvlZONpWghkpcOhPjbZx9/qIj9LA/Xz6/yFKtvdf9pPveq4U1Ij9LVNe8POA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963653; c=relaxed/simple;
	bh=DjbOGAclJVdyRt4mD6ki6T6PGnHsWxWRXoaHnmm0iPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gq4SlyWkzSwiqtnGxlta8VkuHHeoH2WKt0SxjSp0PCg75gsBaUOUV4Uxg401N/i0w6zQWktLAqRXBiZz1iOxHsdI9zzGyQqzYQxbIXZnDQoAjdZ1eurdld+qpqIgEYa4j0q9Fo1BfRi1HsMEFsP/Nlp79ZTCMW2IQHudcNc8hp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Vpzfc4H8hzlWqC;
	Wed, 29 May 2024 14:16:24 +0800 (CST)
Received: from kwepemf500005.china.huawei.com (unknown [7.202.181.243])
	by mail.maildlp.com (Postfix) with ESMTPS id DCAD5180A9C;
	Wed, 29 May 2024 14:20:46 +0800 (CST)
Received: from [10.67.111.212] (10.67.111.212) by
 kwepemf500005.china.huawei.com (7.202.181.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 29 May 2024 14:20:45 +0800
Message-ID: <a0969967-c3ed-41ad-b7bb-805227281bbd@huawei.com>
Date: Wed, 29 May 2024 14:20:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: set burst to zero when set max to cpu.max
To: Benjamin Segall <bsegall@google.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <mgorman@suse.de>, <bristot@redhat.com>,
	<vschneid@redhat.com>, <changhuaixin@linux.alibaba.com>,
	<shanpeic@linux.alibaba.com>, <dtcccc@linux.alibaba.com>, <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <yusongping@huawei.com>, <zhaowenhui8@huawei.com>,
	<liaoqixin@huawei.com>
References: <20240522031007.643498-1-serein.chengyu@huawei.com>
 <20240522031007.643498-3-serein.chengyu@huawei.com>
 <xm268qzt4jnx.fsf@google.com>
Content-Language: en-US
From: Cheng Yu <serein.chengyu@huawei.com>
In-Reply-To: <xm268qzt4jnx.fsf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500005.china.huawei.com (7.202.181.243)

On 2024/5/29 7:10, Benjamin Segall wrote:
> Cheng Yu <serein.chengyu@huawei.com> writes:
> 
>> In the cgroup v2 cpu subsystem, assuming we have a cgroup named 'test',
>> and we set cpu.max and cpu.max.burst:
>>     # echo 1000000 > /sys/fs/cgroup/test/cpu.max
>>     # echo 1000000 > /sys/fs/cgroup/test/cpu.max.burst
>>
>> Next we remove the restriction on cfs bandwidth:
>>     # echo max > /sys/fs/cgroup/test/cpu.max
>>     # cat /sys/fs/cgroup/test/cpu.max
>>     max 100000
>>     # cat /sys/fs/cgroup/test/cpu.max.burst
>>     1000000
>>
>> Now we expect that the value of burst should be 0. When the burst is 0,
>> it means that the restriction on burst is cancelled.
>>
>> Fixes: f4183717b370 ("sched/fair: Introduce the burstable CFS controller")
>> Reported-by: Qixin Liao <liaoqixin@huawei.com>
>> Signed-off-by: Cheng Yu <serein.chengyu@huawei.com>
> 
> Yeah, makes sense. My general assumption would be to put these in one
> patch, but if there's a convention to separate v1 and v2 that I've
> missed, I have no opinion.
> 
> Reviewed-by: Ben Segall <bsegall@google.com>
> 
Thanks for the advice. I will submit a v2 patch that includes both cgroup v1 and v2 modification.

>> ---
>>  kernel/sched/core.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index e9198e30bb74..982d357b3983 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -11414,8 +11414,11 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
>>  	int ret;
>>  
>>  	ret = cpu_period_quota_parse(buf, &period, &quota);
>> -	if (!ret)
>> +	if (!ret) {
>> +		if (quota == RUNTIME_INF)
>> +			burst = 0;
>>  		ret = tg_set_cfs_bandwidth(tg, period, quota, burst);
>> +	}
>>  	return ret ?: nbytes;
>>  }
>>  #endif

