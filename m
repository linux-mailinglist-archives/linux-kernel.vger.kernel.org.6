Return-Path: <linux-kernel+bounces-280605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11DB94CCC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8392867DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6CD18F2F8;
	Fri,  9 Aug 2024 08:54:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FCB129E9C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193689; cv=none; b=Qu0oHzRtI+o9ziJ+ahlH5Sm4p0Ka3sMCXBhn5jwqFF/yuxiu1SN30Kne4BvesdTrgozCTb2XWjWWr+/PYrdFbfbWfQFtr5i5T2myLIBnVcRw6as0HEDaOxkDTRADawWvFvB/pdlHHvh9iLsGHW8lFlYWWJOgBmelAcVQbJTMM08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193689; c=relaxed/simple;
	bh=lZRzEPxSEGnkmFF/F7PsReUM/FSxcaffIsBGEuIMqSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QE9ovbq4clvtuFYFPsMpyRkYk/++Qa+v7BamkV2rI7aKx8QfLJlO/OslAm437uNZ9sHNw6pOF/gba8q0VyT1UgU8f2c5A/ZAA/1L7RoHfOKzkd1ZgL4VLkCsONCiBoL1onNCGCJwSy89T20xFlut2Hd+GIBetHpQgX2vPHiGJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WgHlV4B9tzyP0V;
	Fri,  9 Aug 2024 16:54:14 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (unknown [7.185.36.162])
	by mail.maildlp.com (Postfix) with ESMTPS id E5CE21800FF;
	Fri,  9 Aug 2024 16:54:37 +0800 (CST)
Received: from [10.67.110.25] (10.67.110.25) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 9 Aug
 2024 16:54:37 +0800
Message-ID: <662f5f0f-3cc5-3cdd-e076-232ef1d7432e@huawei.com>
Date: Fri, 9 Aug 2024 16:54:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] sched/fair: set burst to 0 when remove the restriction
 on cfs bandwidth
To: Cheng Yu <serein.chengyu@huawei.com>, Tejun Heo <tj@kernel.org>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>,
	<changhuaixin@linux.alibaba.com>, <shanpeic@linux.alibaba.com>,
	<dtcccc@linux.alibaba.com>, <vishalc@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <yusongping@huawei.com>
References: <20240708120053.861037-1-serein.chengyu@huawei.com>
 <ZowrFHHXNds36Nsb@slm.duckdns.org>
 <22653c39-93a5-4958-a6fc-e31885f49373@huawei.com>
From: "zhaowenhui (A)" <zhaowenhui8@huawei.com>
In-Reply-To: <22653c39-93a5-4958-a6fc-e31885f49373@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500022.china.huawei.com (7.185.36.162)



> Hi,
> 
> On 2024/7/9 2:08, Tejun Heo wrote:
>> Hello,
>>
>> On Mon, Jul 08, 2024 at 08:00:53PM +0800, Cheng Yu wrote:
>>> From: Zhao Wenhui <zhaowenhui8@huawei.com>
>>>
>>> In the cpu subsystem of cgroup v1 and v2, we set the restriction on cfs
>>> bandwidth by setting the quota and burst value. Later, when we remove
>>> the restriction by setting the quota to the default value, the burst
>>> value should also be forced to the its default value of zero.
>>
>> Explaining a bit why burst value should become zero can be helpful - ie.
>> what happens when quota is not set but burst is limited?
> 
> When the restriction on cfs bandwidth is removed, the purpose of setting
> burst value to zero is to avoid ambiguity.
> 
>>
>> ...
>>> @@ -10840,6 +10840,12 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>>>   				     burst + quota > max_cfs_runtime))
>>>   		return -EINVAL;
>>>   
>>> +	/*
>>> +	 * Ensure burst equals to zero when quota is -1.
>>> +	 */
>>> +	if (quota == RUNTIME_INF && burst)
>>> +		return -EINVAL;
>>
>> This happening would be a bug, right? Would it make more sense to use
>> WARN_ON_ONCE()?
> 
> As Vishal Chourasia mentioned, it can prevent setting excessively large
> burst value. Using WARN_ON_ONCE() does not have this effect.
> 
>>
>> Thanks.
>>
> 
> Thanks
> --
> Cheng Yu

Friendly ping. Any more question about this patch?

Regards,
Zhao wenhui

