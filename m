Return-Path: <linux-kernel+bounces-251758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA4393096D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 11:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E581C20B1D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3600F3A8C0;
	Sun, 14 Jul 2024 09:06:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD4923BF
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720947963; cv=none; b=oFUS9nSoV+xpD+4ENIHge2PXL12/TQ/b+EYv2TQ3qHVtxBuNFiD5tbBb6nMOLzt/EEMws9zPiRCtjTnnZc3qKhJXUOher/l3z7LW7W1zv1R9Vhu3idOUQ9dUsTwLZevgrB6ER0RNeXDAYdVKtNmGMwnT3hxWuGAqWId1i7BkzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720947963; c=relaxed/simple;
	bh=gDP7hILhMhp/So2XAjsoMqaM7rJ+yJ4wVTzz9eFShjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AG0OJEPmx9gCtDDnbRfGQoFBG23ry6WVoE3YZKcAb26Xb7UGVSuTvHrpUCSCyjjZhnxN9OkfhTdKr/iXkhrZHDi3gwlTt2XCP+mVLMZLBRzTzfN5+Vq1Mss4oMl088CeSateirlK3BNaLaF+0PMel6AS1goQCyfSfCUgHk4e3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C41BA1042;
	Sun, 14 Jul 2024 02:06:25 -0700 (PDT)
Received: from [10.57.75.41] (unknown [10.57.75.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2915A3F641;
	Sun, 14 Jul 2024 02:05:59 -0700 (PDT)
Message-ID: <f21c97ea-426a-46e3-900a-42cc039acc6f@arm.com>
Date: Sun, 14 Jul 2024 10:05:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <b8d1dc3c-ee05-450e-961e-b13dded06a78@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/07/2024 13:54, Baolin Wang wrote:
> 
> 
> On 2024/7/13 19:00, Ryan Roberts wrote:
>> [...]
>>
>>>> +static int thpsize_create(int order, struct kobject *parent)
>>>>    {
>>>>        unsigned long size = (PAGE_SIZE << order) / SZ_1K;
>>>> +    struct thpsize_child *stats;
>>>>        struct thpsize *thpsize;
>>>>        int ret;
>>>>    +    /*
>>>> +     * Each child object (currently only "stats" directory) holds a
>>>> +     * reference to the top-level thpsize object, so we can drop our ref to
>>>> +     * the top-level once stats is setup. Then we just need to drop a
>>>> +     * reference on any children to clean everything up. We can't just use
>>>> +     * the attr group name for the stats subdirectory because there may be
>>>> +     * multiple attribute groups to populate inside stats and overlaying
>>>> +     * using the name property isn't supported in that way; each attr group
>>>> +     * name, if provided, must be unique in the parent directory.
>>>> +     */
>>>> +
>>>>        thpsize = kzalloc(sizeof(*thpsize), GFP_KERNEL);
>>>> -    if (!thpsize)
>>>> -        return ERR_PTR(-ENOMEM);
>>>> +    if (!thpsize) {
>>>> +        ret = -ENOMEM;
>>>> +        goto err;
>>>> +    }
>>>> +    thpsize->order = order;
>>>>          ret = kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, parent,
>>>>                       "hugepages-%lukB", size);
>>>>        if (ret) {
>>>>            kfree(thpsize);
>>>> -        return ERR_PTR(ret);
>>>> +        goto err;
>>>>        }
>>>>    -    ret = sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
>>>> -    if (ret) {
>>>> +    stats = kzalloc(sizeof(*stats), GFP_KERNEL);
>>>> +    if (!stats) {
>>>>            kobject_put(&thpsize->kobj);
>>>> -        return ERR_PTR(ret);
>>>> +        ret = -ENOMEM;
>>>> +        goto err;
>>>>        }
>>>>    -    ret = sysfs_create_group(&thpsize->kobj, &stats_attr_group);
>>>> +    ret = kobject_init_and_add(&stats->kobj, &thpsize_child_ktype,
>>>> +                   &thpsize->kobj, "stats");
>>>> +    kobject_put(&thpsize->kobj);
>>>>        if (ret) {
>>>> -        kobject_put(&thpsize->kobj);
>>>> -        return ERR_PTR(ret);
>>>> +        kfree(stats);
>>>> +        goto err;
>>>>        }
>>>>    -    thpsize->order = order;
>>>> -    return thpsize;
>>>> +    if (BIT(order) & THP_ORDERS_ALL_ANON) {
>>>> +        ret = sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
>>>> +        if (ret)
>>>> +            goto err_put;
>>>> +
>>>> +        ret = sysfs_create_group(&stats->kobj, &stats_attr_group);
>>>> +        if (ret)
>>>> +            goto err_put;
>>>> +    }
>>>> +
>>>> +    if (BIT(order) & PAGECACHE_LARGE_ORDERS) {
>>>> +        ret = sysfs_create_group(&stats->kobj, &file_stats_attr_group);
>>>> +        if (ret)
>>>> +            goto err_put;
>>>> +    }
>>>> +
>>>> +    list_add(&stats->node, &thpsize_child_list);
>>>> +    return 0;
>>>> +err_put:
>>>
>>> IIUC, I think you should call 'sysfs_remove_group' to remove the group before
>>> putting the kobject.
>>
>> Are you sure about that? As I understood it, sysfs_create_group() was
>> conceptually modifying the state of the kobj, so when the kobj gets destroyed,
>> all its state is tidied up. __kobject_del() (called on the last kobject_put())
>> calls sysfs_remove_groups() and tidies up the sysfs state as far as I can see?
> 
> IIUC, __kobject_del() only removes the ktype defaut groups by
> 'sysfs_remove_groups(kobj, ktype->default_groups)', but your created groups are
> not added into the ktype->default_groups. That means you should mannuly remove
> them, or am I miss something?

That was also putting doubt in my mind. But the sample at
samples/kobject/kobject-example.c does not call sysfs_remove_group(). It just
calls sysfs_create_group() in example_init() and calls kobject_put() in
example_exit(). So I think that's the correct pattern.

Looking at the code more closely, sysfs_create_group() just creates files for
each of the attributes in the group. __kobject_del() calls sysfs_remove_dir(),
who's comment states "we remove any files in the directory before we remove the
directory" so I'm pretty sure sysfs_remove_group() is not required.

By the way, if we do choose to only populate stats if that size can be used by
anon/shmem/file, then I've found sysfs_merge_group() which will simplify adding
named groups without needing to manually create the stats directory as I am in
this version of the patch. I'll migrate to using that approach in v2. Of course
if we decide to take the approach of populating all stats for all sizes, that
problem goes away anyway.

Thanks,
Ryan





