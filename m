Return-Path: <linux-kernel+bounces-258431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070DA9387D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0721F2177B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB611396;
	Mon, 22 Jul 2024 03:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pxsuNdl3"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B9717580
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721620337; cv=none; b=YPIUE2zh3NxLpYlQaKtm8lrkgE1Intz9gzat+rv/r7tdMtF3RF/kMvidYDUDB8uHmRMxr1qdbARLq9O/5oa4DFkCU7WcKhtCxNfMXmhMmjesDOvssmSfYv7cTlpLV04UAq1PN3Lk/FozH7Uu2KW9dNciu0z59Cv4MSblf/HaA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721620337; c=relaxed/simple;
	bh=Yg/PYVDcapMPncEQQkcMV6LJnROgypb2pYdoZuLaDTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8hhID30js6V/9tirLJO6mv8HmS9KYA5ZwPnd5u/mOBeTUoY6WJjJBB7yThscJZ7QPB1hvEQfYcd+NpqJRwpi0Ftksi/AeI29N55S/yu0dqCui07iKgKT22rScRmSij4EfrUrcbjNfORyKlaCMugZcsBpUxiKS2inbDm8HPxO34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pxsuNdl3; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721620332; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZRZsaWjHik4fJ4+vcINy/iv5wgmnKjA60/N2NkOyV/A=;
	b=pxsuNdl3LR7ses0/G0ZHcSLL7sEybGG6eTjmCNWI2EyvxR+dTO2WBotprSIR+EgG/invskbQqR5RXFXle8Amkj+eWDhujyB6UG+eoOxfTN80OWHljLmee0tW8agIFJktG5E1F5f+8/c9djxXju5+avs+3LAX4RdJSyobBup8u1A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WAyfmNo_1721620329;
Received: from 30.97.56.74(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAyfmNo_1721620329)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 11:52:10 +0800
Message-ID: <26e84b0f-68ed-4e98-925e-5799a2ae1164@linux.alibaba.com>
Date: Mon, 22 Jul 2024 11:52:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <ioworker0@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240711072929.3590000-1-ryan.roberts@arm.com>
 <20240711072929.3590000-3-ryan.roberts@arm.com>
 <9e0d84e5-2319-4425-9760-2c6bb23fc390@linux.alibaba.com>
 <29f0fc5a-c2b7-4925-9bdb-fd2abe5383ae@arm.com>
 <b8d1dc3c-ee05-450e-961e-b13dded06a78@linux.alibaba.com>
 <f21c97ea-426a-46e3-900a-42cc039acc6f@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <f21c97ea-426a-46e3-900a-42cc039acc6f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/14 17:05, Ryan Roberts wrote:
> On 13/07/2024 13:54, Baolin Wang wrote:
>>
>>
>> On 2024/7/13 19:00, Ryan Roberts wrote:
>>> [...]
>>>
>>>>> +static int thpsize_create(int order, struct kobject *parent)
>>>>>     {
>>>>>         unsigned long size = (PAGE_SIZE << order) / SZ_1K;
>>>>> +    struct thpsize_child *stats;
>>>>>         struct thpsize *thpsize;
>>>>>         int ret;
>>>>>     +    /*
>>>>> +     * Each child object (currently only "stats" directory) holds a
>>>>> +     * reference to the top-level thpsize object, so we can drop our ref to
>>>>> +     * the top-level once stats is setup. Then we just need to drop a
>>>>> +     * reference on any children to clean everything up. We can't just use
>>>>> +     * the attr group name for the stats subdirectory because there may be
>>>>> +     * multiple attribute groups to populate inside stats and overlaying
>>>>> +     * using the name property isn't supported in that way; each attr group
>>>>> +     * name, if provided, must be unique in the parent directory.
>>>>> +     */
>>>>> +
>>>>>         thpsize = kzalloc(sizeof(*thpsize), GFP_KERNEL);
>>>>> -    if (!thpsize)
>>>>> -        return ERR_PTR(-ENOMEM);
>>>>> +    if (!thpsize) {
>>>>> +        ret = -ENOMEM;
>>>>> +        goto err;
>>>>> +    }
>>>>> +    thpsize->order = order;
>>>>>           ret = kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, parent,
>>>>>                        "hugepages-%lukB", size);
>>>>>         if (ret) {
>>>>>             kfree(thpsize);
>>>>> -        return ERR_PTR(ret);
>>>>> +        goto err;
>>>>>         }
>>>>>     -    ret = sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
>>>>> -    if (ret) {
>>>>> +    stats = kzalloc(sizeof(*stats), GFP_KERNEL);
>>>>> +    if (!stats) {
>>>>>             kobject_put(&thpsize->kobj);
>>>>> -        return ERR_PTR(ret);
>>>>> +        ret = -ENOMEM;
>>>>> +        goto err;
>>>>>         }
>>>>>     -    ret = sysfs_create_group(&thpsize->kobj, &stats_attr_group);
>>>>> +    ret = kobject_init_and_add(&stats->kobj, &thpsize_child_ktype,
>>>>> +                   &thpsize->kobj, "stats");
>>>>> +    kobject_put(&thpsize->kobj);
>>>>>         if (ret) {
>>>>> -        kobject_put(&thpsize->kobj);
>>>>> -        return ERR_PTR(ret);
>>>>> +        kfree(stats);
>>>>> +        goto err;
>>>>>         }
>>>>>     -    thpsize->order = order;
>>>>> -    return thpsize;
>>>>> +    if (BIT(order) & THP_ORDERS_ALL_ANON) {
>>>>> +        ret = sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
>>>>> +        if (ret)
>>>>> +            goto err_put;
>>>>> +
>>>>> +        ret = sysfs_create_group(&stats->kobj, &stats_attr_group);
>>>>> +        if (ret)
>>>>> +            goto err_put;
>>>>> +    }
>>>>> +
>>>>> +    if (BIT(order) & PAGECACHE_LARGE_ORDERS) {
>>>>> +        ret = sysfs_create_group(&stats->kobj, &file_stats_attr_group);
>>>>> +        if (ret)
>>>>> +            goto err_put;
>>>>> +    }
>>>>> +
>>>>> +    list_add(&stats->node, &thpsize_child_list);
>>>>> +    return 0;
>>>>> +err_put:
>>>>
>>>> IIUC, I think you should call 'sysfs_remove_group' to remove the group before
>>>> putting the kobject.
>>>
>>> Are you sure about that? As I understood it, sysfs_create_group() was
>>> conceptually modifying the state of the kobj, so when the kobj gets destroyed,
>>> all its state is tidied up. __kobject_del() (called on the last kobject_put())
>>> calls sysfs_remove_groups() and tidies up the sysfs state as far as I can see?
>>
>> IIUC, __kobject_del() only removes the ktype defaut groups by
>> 'sysfs_remove_groups(kobj, ktype->default_groups)', but your created groups are
>> not added into the ktype->default_groups. That means you should mannuly remove
>> them, or am I miss something?
> 
> That was also putting doubt in my mind. But the sample at
> samples/kobject/kobject-example.c does not call sysfs_remove_group(). It just
> calls sysfs_create_group() in example_init() and calls kobject_put() in
> example_exit(). So I think that's the correct pattern.
> 
> Looking at the code more closely, sysfs_create_group() just creates files for
> each of the attributes in the group. __kobject_del() calls sysfs_remove_dir(),
> who's comment states "we remove any files in the directory before we remove the
> directory" so I'm pretty sure sysfs_remove_group() is not required.

Thanks for the explanation, and I think you are right after checking the 
code again. Sorry for the noise.

