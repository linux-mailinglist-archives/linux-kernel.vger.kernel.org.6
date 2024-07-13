Return-Path: <linux-kernel+bounces-251505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77049305A7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F01CB214FD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C2F130AC8;
	Sat, 13 Jul 2024 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hOcZHyJ8"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC294AEC6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720875260; cv=none; b=ARM3V1UZu9gea0pt3UZjUTNmW07qVc4WjGWgI1ADDYg783JQyJyomqs5mM1svzhE/q4buxL0L720scXYW3nwVqNAppcf1EciN+AArV4hcNcNBOfvRtMzL1FtNivSQNhwhvX/92IkiTvMvRZjL4W6kScNdJhsYK/DHjU7Hm8nGpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720875260; c=relaxed/simple;
	bh=Dm2ZCQFzCflulnLv9Xj4xWzHEwkM13XkBjwgtQ4GFg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzwaWDbi/qdehZ/FG4EgLUNhDarYBx82ZC5FxPJ63ko3bxOmj84wtwhvZwlcpcuqG6qR3ls4FIo8AZ2RypnOf4O0/k6SoRurhVzUL2janYycAx9b3KpsdMGQcrLmcvhQG0V1AegUJNgA4FNJXK9CCfDo4uVFZyPwrdSxJ+ozYQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hOcZHyJ8; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720875249; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=U3/MbRKAUT1nHEYQQc4tHTxgsmxngVtkmZqCwxsFAJo=;
	b=hOcZHyJ8aEHgWtbfXRHZ78SqPlVmltQnhte4xLe43AvW1IYRpLXEdJg8ywWF6QIDlnbcw2gElyUn4x9heZ9FDTYAMA+rryVCaF4zrfq/ZlyxS9fyKFuAjxEg7dS/7jcGAQlg3+BqzqVW6rPXHg3N48yw+JwvVfaCxLjnkEh2sOw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WAR-9Iw_1720875246;
Received: from 30.32.91.177(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAR-9Iw_1720875246)
          by smtp.aliyun-inc.com;
          Sat, 13 Jul 2024 20:54:08 +0800
Message-ID: <b8d1dc3c-ee05-450e-961e-b13dded06a78@linux.alibaba.com>
Date: Sat, 13 Jul 2024 20:54:06 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <29f0fc5a-c2b7-4925-9bdb-fd2abe5383ae@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/13 19:00, Ryan Roberts wrote:
> [...]
> 
>>> +static int thpsize_create(int order, struct kobject *parent)
>>>    {
>>>        unsigned long size = (PAGE_SIZE << order) / SZ_1K;
>>> +    struct thpsize_child *stats;
>>>        struct thpsize *thpsize;
>>>        int ret;
>>>    +    /*
>>> +     * Each child object (currently only "stats" directory) holds a
>>> +     * reference to the top-level thpsize object, so we can drop our ref to
>>> +     * the top-level once stats is setup. Then we just need to drop a
>>> +     * reference on any children to clean everything up. We can't just use
>>> +     * the attr group name for the stats subdirectory because there may be
>>> +     * multiple attribute groups to populate inside stats and overlaying
>>> +     * using the name property isn't supported in that way; each attr group
>>> +     * name, if provided, must be unique in the parent directory.
>>> +     */
>>> +
>>>        thpsize = kzalloc(sizeof(*thpsize), GFP_KERNEL);
>>> -    if (!thpsize)
>>> -        return ERR_PTR(-ENOMEM);
>>> +    if (!thpsize) {
>>> +        ret = -ENOMEM;
>>> +        goto err;
>>> +    }
>>> +    thpsize->order = order;
>>>          ret = kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, parent,
>>>                       "hugepages-%lukB", size);
>>>        if (ret) {
>>>            kfree(thpsize);
>>> -        return ERR_PTR(ret);
>>> +        goto err;
>>>        }
>>>    -    ret = sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
>>> -    if (ret) {
>>> +    stats = kzalloc(sizeof(*stats), GFP_KERNEL);
>>> +    if (!stats) {
>>>            kobject_put(&thpsize->kobj);
>>> -        return ERR_PTR(ret);
>>> +        ret = -ENOMEM;
>>> +        goto err;
>>>        }
>>>    -    ret = sysfs_create_group(&thpsize->kobj, &stats_attr_group);
>>> +    ret = kobject_init_and_add(&stats->kobj, &thpsize_child_ktype,
>>> +                   &thpsize->kobj, "stats");
>>> +    kobject_put(&thpsize->kobj);
>>>        if (ret) {
>>> -        kobject_put(&thpsize->kobj);
>>> -        return ERR_PTR(ret);
>>> +        kfree(stats);
>>> +        goto err;
>>>        }
>>>    -    thpsize->order = order;
>>> -    return thpsize;
>>> +    if (BIT(order) & THP_ORDERS_ALL_ANON) {
>>> +        ret = sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
>>> +        if (ret)
>>> +            goto err_put;
>>> +
>>> +        ret = sysfs_create_group(&stats->kobj, &stats_attr_group);
>>> +        if (ret)
>>> +            goto err_put;
>>> +    }
>>> +
>>> +    if (BIT(order) & PAGECACHE_LARGE_ORDERS) {
>>> +        ret = sysfs_create_group(&stats->kobj, &file_stats_attr_group);
>>> +        if (ret)
>>> +            goto err_put;
>>> +    }
>>> +
>>> +    list_add(&stats->node, &thpsize_child_list);
>>> +    return 0;
>>> +err_put:
>>
>> IIUC, I think you should call 'sysfs_remove_group' to remove the group before
>> putting the kobject.
> 
> Are you sure about that? As I understood it, sysfs_create_group() was
> conceptually modifying the state of the kobj, so when the kobj gets destroyed,
> all its state is tidied up. __kobject_del() (called on the last kobject_put())
> calls sysfs_remove_groups() and tidies up the sysfs state as far as I can see?

IIUC, __kobject_del() only removes the ktype defaut groups by 
'sysfs_remove_groups(kobj, ktype->default_groups)', but your created 
groups are not added into the ktype->default_groups. That means you 
should mannuly remove them, or am I miss something?

