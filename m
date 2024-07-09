Return-Path: <linux-kernel+bounces-245145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1439C92AEEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E90B215C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BF12BD05;
	Tue,  9 Jul 2024 04:05:22 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF52639
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720497922; cv=none; b=tWMfJyLPxvuloLi8C1pSUhoPkd7n7Uh/WrpjJtdl7dTKO0JjDl1DgW02X7sRFGqf5BxlIoYCSzO5qlbCuWe3neyv6N5n34qP/bBKH5Sguis8k502pmE8TV7qJ/QEdxjdj4UPtQ97qfs5ze1OK+K6ZkkVDD51XQVPf0WZrSqtw7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720497922; c=relaxed/simple;
	bh=/BDlfLFMCQnAdV+74SMFqZTVtoalJa9cAgO3E4koz18=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i38yM5mW9PkGMeB5HW2cWupTF/MBgkESckutsBryRm1YszKXEb8j5y3zPJkxzbLX1dScDth+pHekYuykoKq85lCyHbyj04rdm+BtaHVLHsmL20y5RMJk42YDM5OmXJegpocV5VWwkYnImI/UcTvJT9N3ndMk2o7w7D4xjmhEnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WJ6hc5FCVz1T5vW;
	Tue,  9 Jul 2024 12:00:16 +0800 (CST)
Received: from kwepemf500005.china.huawei.com (unknown [7.202.181.243])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B58C1402E1;
	Tue,  9 Jul 2024 12:04:57 +0800 (CST)
Received: from [10.67.111.212] (10.67.111.212) by
 kwepemf500005.china.huawei.com (7.202.181.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jul 2024 12:04:56 +0800
Message-ID: <22653c39-93a5-4958-a6fc-e31885f49373@huawei.com>
Date: Tue, 9 Jul 2024 12:04:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: set burst to 0 when remove the restriction
 on cfs bandwidth
To: Tejun Heo <tj@kernel.org>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>,
	<changhuaixin@linux.alibaba.com>, <shanpeic@linux.alibaba.com>,
	<dtcccc@linux.alibaba.com>, <vishalc@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <yusongping@huawei.com>, <zhaowenhui8@huawei.com>
References: <20240708120053.861037-1-serein.chengyu@huawei.com>
 <ZowrFHHXNds36Nsb@slm.duckdns.org>
Content-Language: en-US
From: Cheng Yu <serein.chengyu@huawei.com>
In-Reply-To: <ZowrFHHXNds36Nsb@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500005.china.huawei.com (7.202.181.243)

Hi,

On 2024/7/9 2:08, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jul 08, 2024 at 08:00:53PM +0800, Cheng Yu wrote:
>> From: Zhao Wenhui <zhaowenhui8@huawei.com>
>>
>> In the cpu subsystem of cgroup v1 and v2, we set the restriction on cfs
>> bandwidth by setting the quota and burst value. Later, when we remove
>> the restriction by setting the quota to the default value, the burst
>> value should also be forced to the its default value of zero.
> 
> Explaining a bit why burst value should become zero can be helpful - ie.
> what happens when quota is not set but burst is limited?

When the restriction on cfs bandwidth is removed, the purpose of setting
burst value to zero is to avoid ambiguity.

> 
> ...
>> @@ -10840,6 +10840,12 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>>  				     burst + quota > max_cfs_runtime))
>>  		return -EINVAL;
>>  
>> +	/*
>> +	 * Ensure burst equals to zero when quota is -1.
>> +	 */
>> +	if (quota == RUNTIME_INF && burst)
>> +		return -EINVAL;
> 
> This happening would be a bug, right? Would it make more sense to use
> WARN_ON_ONCE()?

As Vishal Chourasia mentioned, it can prevent setting excessively large
burst value. Using WARN_ON_ONCE() does not have this effect.

> 
> Thanks.
> 

Thanks
--
Cheng Yu

