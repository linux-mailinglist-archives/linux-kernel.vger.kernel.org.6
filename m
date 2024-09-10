Return-Path: <linux-kernel+bounces-323041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4969736E2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046991F2538A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12CC18FC80;
	Tue, 10 Sep 2024 12:11:43 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A418DF8F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970303; cv=none; b=j+XfyHbFpEQ5DVg2MV5Do+0+RQPwF6kfbT4wUTB1LmNz8ITJwreLoCHZNC3K0qEcPBYEgqtcSclsJAioR8ixMdDpRpLpMSM/NHqTjfv2XEy70hDphOsIWL1B4d8j6fie3xaeHVwrr88IPVnDWXERtWxp4ny2yU57qPAWqwTTx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970303; c=relaxed/simple;
	bh=Vi78Wc2S72zvBgn9JMBev6eun77uCIzACe0oZKG8DcM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bsBdzDAPc350kuwBnuM0NgqoxU2zWSHQclVBMzuvC4lKIR7KU7QYoHWz8hmTCWNn6M3RBoHr5AjudJxszpTP7JAoRx4K9zKAek44J05CqZ4mMkFvkTLXJ6SuO4iEQT7Rnc5nJjLQ42EILBN1v2dYqsJlFL917S7vevPKFzunm54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X32bw6jxFz1S9fr;
	Tue, 10 Sep 2024 20:11:08 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FE841A0188;
	Tue, 10 Sep 2024 20:11:37 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Sep 2024 20:11:36 +0800
Message-ID: <26e53efe-7a54-499a-8d3f-345d29d90348@huawei.com>
Date: Tue, 10 Sep 2024 20:11:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <ying.huang@intel.com>,
	<akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
	<dmaluka@chromium.org>, <liushixin2@huawei.com>,
	<wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, proc: collect percpu free pages into the free pages
Content-Language: en-US
To: <mhocko@suse.com>
References: <20240830014453.3070909-1-mawupeng1@huawei.com>
 <87a5guh2fb.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2ee7cb17-9003-482c-9741-f1f51f61ab4b@huawei.com>
 <871q22hmga.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <193da117-30b8-425a-b095-6fd8aca1c987@huawei.com>
 <ZtbERGm8CJsOwx73@tiehlicka>
 <ed533d8b-40b7-447f-8453-e03b291340fa@huawei.com>
 <ZtgMHFQ4NwdvL7_e@tiehlicka>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <ZtgMHFQ4NwdvL7_e@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2024/9/4 15:28, Michal Hocko wrote:
> On Wed 04-09-24 14:49:20, mawupeng wrote:
>>
>>
>> On 2024/9/3 16:09, Michal Hocko wrote:
>>> On Tue 03-09-24 09:50:48, mawupeng wrote:
>>>>> Drain remote PCP may be not that expensive now after commit 4b23a68f9536
>>>>> ("mm/page_alloc: protect PCP lists with a spinlock").  No IPI is needed
>>>>> to drain the remote PCP.
>>>>
>>>> This looks really great, we can think a way to drop pcp before goto slowpath
>>>> before swap.
>>>
>>> We currently drain after first unsuccessful direct reclaim run. Is that
>>> insufficient? 
>>
>> The reason i said the drain of pcp is insufficient or expensive is based
>> on you comment[1] :-）. Since IPIs is not requiered since commit 4b23a68f9536
>> ("mm/page_alloc: protect PCP lists with a spinlock"). This could be much
>> better.
>>
>> [1]: https://lore.kernel.org/linux-mm/ZWRYZmulV0B-Jv3k@tiehlicka/
> 
> there are other reasons I have mentioned in that reply which play role
> as well.
> 
>>> Should we do a less aggressive draining sooner? Ideally
>>> restricted to cpus on the same NUMA node maybe? Do you have any specific
>>> workloads that would benefit from this?
>>
>> Current the problem is amount the pcp, which can increase to 4.6%(24644M)
>> of the total 512G memory.
> 
> Why is that a problem? 

MemAvailable
              An estimate of how much memory is available for starting new
              applications, without swapping. Calculated from MemFree,
              SReclaimable, the size of the file LRU lists, and the low
              watermarks in each zone.

The PCP memory is essentially available memory and will be reclaimed before OOM.
In essence, it is not fundamentally different from reclaiming file pages, as both
are reclaimed within __alloc_pages_direct_reclaim. Therefore, why shouldn't it be
included in MemAvailable to avoid confusion.

__alloc_pages_direct_reclaim
  __perform_reclaim
  if (!page && !drained)
    drain_all_pages(NULL);


> Just because some tools are miscalculating memory
> pressure because they are based on MemAvailable? Or does this lead to
> performance regressions on the kernel side? In other words would the
> same workload behaved better if the amount of pcp-cache was reduced
> without any userspace intervention?

