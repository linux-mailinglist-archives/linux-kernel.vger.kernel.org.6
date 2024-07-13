Return-Path: <linux-kernel+bounces-251477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1415C930550
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 13:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59B21F21A81
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 11:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A487B1304BA;
	Sat, 13 Jul 2024 11:00:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BF44C8E
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720868424; cv=none; b=PSK5393Z8qxLTvE1MYLeo/tssvIstN3YQP1fd9c+5x6j2RP9dtQ04sheuQyTDQFhnqM9TmWLJJ1k3X+rxnfQn+9COD3V+pLQH2g3DN3v928LOJiYZNe+AwduWaSSoT6CYBPS/fR5DeS0MIGif62ArckIWzBRdSFxrAeQxqT53vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720868424; c=relaxed/simple;
	bh=za8GJePHbde6ibSyF+V7A1Vc3XNv0ML3aq9IDgytorQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXDrIPPdLUSrycloIPTSV9iw10QPBbTftx8hBSMkWlAFyUPkQeqxnnIoJWQPzKq0609rWHPB0yd80xiSiKFuj/+Ay63v0vNx81OkOCdWmETH+kohkm7e6GuLvPuiBYShSM2P7Gp7c4VUsHVUOC4l+9U8GEsYjPLDX1ctA6xJUtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE9461007;
	Sat, 13 Jul 2024 04:00:45 -0700 (PDT)
Received: from [10.57.77.253] (unknown [10.57.77.253])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 129FD3F762;
	Sat, 13 Jul 2024 04:00:18 -0700 (PDT)
Message-ID: <29f0fc5a-c2b7-4925-9bdb-fd2abe5383ae@arm.com>
Date: Sat, 13 Jul 2024 12:00:17 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <9e0d84e5-2319-4425-9760-2c6bb23fc390@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[...]

>> +static int thpsize_create(int order, struct kobject *parent)
>>   {
>>       unsigned long size = (PAGE_SIZE << order) / SZ_1K;
>> +    struct thpsize_child *stats;
>>       struct thpsize *thpsize;
>>       int ret;
>>   +    /*
>> +     * Each child object (currently only "stats" directory) holds a
>> +     * reference to the top-level thpsize object, so we can drop our ref to
>> +     * the top-level once stats is setup. Then we just need to drop a
>> +     * reference on any children to clean everything up. We can't just use
>> +     * the attr group name for the stats subdirectory because there may be
>> +     * multiple attribute groups to populate inside stats and overlaying
>> +     * using the name property isn't supported in that way; each attr group
>> +     * name, if provided, must be unique in the parent directory.
>> +     */
>> +
>>       thpsize = kzalloc(sizeof(*thpsize), GFP_KERNEL);
>> -    if (!thpsize)
>> -        return ERR_PTR(-ENOMEM);
>> +    if (!thpsize) {
>> +        ret = -ENOMEM;
>> +        goto err;
>> +    }
>> +    thpsize->order = order;
>>         ret = kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, parent,
>>                      "hugepages-%lukB", size);
>>       if (ret) {
>>           kfree(thpsize);
>> -        return ERR_PTR(ret);
>> +        goto err;
>>       }
>>   -    ret = sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
>> -    if (ret) {
>> +    stats = kzalloc(sizeof(*stats), GFP_KERNEL);
>> +    if (!stats) {
>>           kobject_put(&thpsize->kobj);
>> -        return ERR_PTR(ret);
>> +        ret = -ENOMEM;
>> +        goto err;
>>       }
>>   -    ret = sysfs_create_group(&thpsize->kobj, &stats_attr_group);
>> +    ret = kobject_init_and_add(&stats->kobj, &thpsize_child_ktype,
>> +                   &thpsize->kobj, "stats");
>> +    kobject_put(&thpsize->kobj);
>>       if (ret) {
>> -        kobject_put(&thpsize->kobj);
>> -        return ERR_PTR(ret);
>> +        kfree(stats);
>> +        goto err;
>>       }
>>   -    thpsize->order = order;
>> -    return thpsize;
>> +    if (BIT(order) & THP_ORDERS_ALL_ANON) {
>> +        ret = sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
>> +        if (ret)
>> +            goto err_put;
>> +
>> +        ret = sysfs_create_group(&stats->kobj, &stats_attr_group);
>> +        if (ret)
>> +            goto err_put;
>> +    }
>> +
>> +    if (BIT(order) & PAGECACHE_LARGE_ORDERS) {
>> +        ret = sysfs_create_group(&stats->kobj, &file_stats_attr_group);
>> +        if (ret)
>> +            goto err_put;
>> +    }
>> +
>> +    list_add(&stats->node, &thpsize_child_list);
>> +    return 0;
>> +err_put:
> 
> IIUC, I think you should call 'sysfs_remove_group' to remove the group before
> putting the kobject.

Are you sure about that? As I understood it, sysfs_create_group() was
conceptually modifying the state of the kobj, so when the kobj gets destroyed,
all its state is tidied up. __kobject_del() (called on the last kobject_put())
calls sysfs_remove_groups() and tidies up the sysfs state as far as I can see?

> 
>> +    kobject_put(&stats->kobj);
>> +err:
>> +    return ret;
>>   }


