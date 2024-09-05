Return-Path: <linux-kernel+bounces-316157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C8996CBE9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B3E1C22EED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E5B4C80;
	Thu,  5 Sep 2024 00:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tc7xahW4"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5121EBFE4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725497147; cv=none; b=S9M7USOGPIwX9keT74Xx0bzEFccrk4kKYkuCWBSIAV00LFvYzeQfVueWhHQD5x6FCTQF3D3YfSULFx/gXftpUMZTZVPT11VKJSLJzuMQQYZUQX2Xle/oxdcq9Hfwd8vX4eNVCP5nx8KmbbmKKG/eaP+91aMzGl6gpYReQkMJcDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725497147; c=relaxed/simple;
	bh=QhGLme8gupERlSIOvuP89on3jA7Cy3p24sZb8qVTGCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgilKA+3u+P8eM/UbA6j3mYgbabc38P4eoMp5IVOxrX6ReMuzNzKKbvTiHzWswI5sFJECHVdJxxvKCS5JJ5XdymTizoaEYkSDnlv6ghf7H3a8XtMTCVcPCM4DGZtSU7Gtzk+eeoPDW34aCAVzuA7/tiE/6PpPbVUzHzC6cFLRak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tc7xahW4; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725497136; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wOQcJBNecoRBU0s0DbrHn2R669s/pjGLLr7afZ2wpAo=;
	b=tc7xahW4sBCMKCXL8ulU1kTM1axa5JpNC8T3IyGfXpjNi82NNSq6c6JGw0ErcotR178RIzCoh9anAPvcttJKeOn5X7sb1mPO1Fq2XDywOpZAfC7Bm2hHT/jQ3Lbx6V25irN03M9tY2eCu8v/TsqryBEm4RugCtDhjWivosQM7gQ=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WEJ3CMy_1725497134)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 08:45:35 +0800
Message-ID: <1bf1bc10-b44f-46a9-8a7d-c3318d7c9bb5@linux.alibaba.com>
Date: Thu, 5 Sep 2024 08:45:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: Tidy up shmem mTHP controls and stats
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, Gavin Shan <gshan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240808111849.651867-1-ryan.roberts@arm.com>
 <20240808111849.651867-3-ryan.roberts@arm.com>
 <747d1319-f746-4379-bf88-a0f6c3f558b4@linux.alibaba.com>
 <f7ced14c-8bc5-405f-bee7-94f63980f525@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <f7ced14c-8bc5-405f-bee7-94f63980f525@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/4 18:47, Ryan Roberts wrote:
> Hi Andrew,
> 
> 
> On 09/08/2024 09:31, Baolin Wang wrote:
>>
>>
>> On 2024/8/8 19:18, Ryan Roberts wrote:
>>> Previously we had a situation where shmem mTHP controls and stats were
>>> not exposed for some supported sizes and were exposed for some
>>> unsupported sizes. So let's clean that up.
>>>
>>> Anon mTHP can support all large orders [2, PMD_ORDER]. But shmem can
>>> support all large orders [1, MAX_PAGECACHE_ORDER]. However, per-size
>>> shmem controls and stats were previously being exposed for all the anon
>>> mTHP orders, meaning order-1 was not present, and for arm64 64K base
>>> pages, orders 12 and 13 were exposed but were not supported internally.
>>>
>>> Tidy this all up by defining ctrl and stats attribute groups for anon
>>> and file separately. Anon ctrl and stats groups are populated for all
>>> orders in THP_ORDERS_ALL_ANON and file ctrl and stats groups are
>>> populated for all orders in THP_ORDERS_ALL_FILE_DEFAULT.
>>>
>>> Additionally, create "any" ctrl and stats attribute groups which are
>>> populated for all orders in (THP_ORDERS_ALL_ANON |
>>> THP_ORDERS_ALL_FILE_DEFAULT). swpout stats use this since they apply to
>>> anon and shmem.
>>>
>>> The side-effect of all this is that different hugepage-*kB directories
>>> contain different sets of controls and stats, depending on which memory
>>> types support that size. This approach is preferred over the
>>> alternative, which is to populate dummy controls and stats for memory
>>> types that do not support a given size.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>    mm/huge_memory.c | 144 +++++++++++++++++++++++++++++++++++++----------
>>>    1 file changed, 114 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 0c3075ee00012..082d86b7c6c2f 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -482,8 +482,8 @@ static void thpsize_release(struct kobject *kobj);
>>>    static DEFINE_SPINLOCK(huge_anon_orders_lock);
>>>    static LIST_HEAD(thpsize_list);
>>>    -static ssize_t thpsize_enabled_show(struct kobject *kobj,
>>> -                    struct kobj_attribute *attr, char *buf)
>>> +static ssize_t anon_enabled_show(struct kobject *kobj,
>>> +                 struct kobj_attribute *attr, char *buf)
>>>    {
>>>        int order = to_thpsize(kobj)->order;
>>>        const char *output;
>>> @@ -500,9 +500,9 @@ static ssize_t thpsize_enabled_show(struct kobject *kobj,
>>>        return sysfs_emit(buf, "%s\n", output);
>>>    }
>>>    -static ssize_t thpsize_enabled_store(struct kobject *kobj,
>>> -                     struct kobj_attribute *attr,
>>> -                     const char *buf, size_t count)
>>> +static ssize_t anon_enabled_store(struct kobject *kobj,
>>> +                  struct kobj_attribute *attr,
>>> +                  const char *buf, size_t count)
>>>    {
>>>        int order = to_thpsize(kobj)->order;
>>>        ssize_t ret = count;
>>> @@ -544,19 +544,35 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
>>>        return ret;
>>>    }
>>>    -static struct kobj_attribute thpsize_enabled_attr =
>>> -    __ATTR(enabled, 0644, thpsize_enabled_show, thpsize_enabled_store);
>>> +static struct kobj_attribute anon_enabled_attr =
>>> +    __ATTR(enabled, 0644, anon_enabled_show, anon_enabled_store);
>>>    -static struct attribute *thpsize_attrs[] = {
>>> -    &thpsize_enabled_attr.attr,
>>> +static struct attribute *anon_ctrl_attrs[] = {
>>> +    &anon_enabled_attr.attr,
>>> +    NULL,
>>> +};
>>> +
>>> +static const struct attribute_group anon_ctrl_attr_grp = {
>>> +    .attrs = anon_ctrl_attrs,
>>> +};
>>> +
>>> +static struct attribute *file_ctrl_attrs[] = {
>>>    #ifdef CONFIG_SHMEM
>>>        &thpsize_shmem_enabled_attr.attr,
>>>    #endif
>>>        NULL,
>>>    };
>>>    -static const struct attribute_group thpsize_attr_group = {
>>> -    .attrs = thpsize_attrs,
>>> +static const struct attribute_group file_ctrl_attr_grp = {
>>> +    .attrs = file_ctrl_attrs,
>>> +};
>>> +
>>> +static struct attribute *any_ctrl_attrs[] = {
>>> +    NULL,
>>> +};
>>> +
>>> +static const struct attribute_group any_ctrl_attr_grp = {
>>> +    .attrs = any_ctrl_attrs,
>>>    };
>>
>> I wonder why adding a NULL group?
>>
>>>      static const struct kobj_type thpsize_ktype = {
>>> @@ -595,64 +611,132 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback,
>>> MTHP_STAT_ANON_FAULT_FALLBACK);
>>>    DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge,
>>> MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>>    DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>>>    DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>>> +#ifdef CONFIG_SHMEM
>>>    DEFINE_MTHP_STAT_ATTR(shmem_alloc, MTHP_STAT_SHMEM_ALLOC);
>>>    DEFINE_MTHP_STAT_ATTR(shmem_fallback, MTHP_STAT_SHMEM_FALLBACK);
>>>    DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
>>> +#endif
>>>    DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>>>    DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>>>    DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>>>    -static struct attribute *stats_attrs[] = {
>>> +static struct attribute *anon_stats_attrs[] = {
>>>        &anon_fault_alloc_attr.attr,
>>>        &anon_fault_fallback_attr.attr,
>>>        &anon_fault_fallback_charge_attr.attr,
>>> +#ifndef CONFIG_SHMEM
>>>        &swpout_attr.attr,
>>>        &swpout_fallback_attr.attr,
>>> -    &shmem_alloc_attr.attr,
>>> -    &shmem_fallback_attr.attr,
>>> -    &shmem_fallback_charge_attr.attr,
>>> +#endif
>>>        &split_attr.attr,
>>>        &split_failed_attr.attr,
>>>        &split_deferred_attr.attr,
>>>        NULL,
>>>    };
>>>    -static struct attribute_group stats_attr_group = {
>>> +static struct attribute_group anon_stats_attr_grp = {
>>> +    .name = "stats",
>>> +    .attrs = anon_stats_attrs,
>>> +};
>>> +
>>> +static struct attribute *file_stats_attrs[] = {
>>> +#ifdef CONFIG_SHMEM
>>> +    &shmem_alloc_attr.attr,
>>> +    &shmem_fallback_attr.attr,
>>> +    &shmem_fallback_charge_attr.attr,
>>> +#endif
>>> +    NULL,
>>> +};
>>> +
>>> +static struct attribute_group file_stats_attr_grp = {
>>> +    .name = "stats",
>>> +    .attrs = file_stats_attrs,
>>> +};
>>> +
>>> +static struct attribute *any_stats_attrs[] = {
>>> +#ifdef CONFIG_SHMEM
>>> +    &swpout_attr.attr,
>>> +    &swpout_fallback_attr.attr,
>>> +#endif
>>
>> Sorry I did not point it out in early version. I think file pages and shmem can
>> also be split, while 'split_deferred' is only for anonymous page. So I think the
>> any_stats_attrs should be:
>> static struct attribute *any_stats_attrs[] = {
>> #ifdef CONFIG_SHMEM
>>      &swpout_attr.attr,
>>      &swpout_fallback_attr.attr,
>> #endif
>>      &split_attr.attr,
>>      &split_failed_attr.attr,
>>      NULL,
>> };
> 
> Could you please squash the following into this patch, which is already in
> mm-unstable? I'm hoping this sufficient and I don't need to send a whole new
> revision since there are changes on top of this in mm-unstable, which makes
> things tricky.
> 
> ----8<-----
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 382938e46f96f..5905957b1f70d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -631,8 +631,6 @@ static struct attribute *anon_stats_attrs[] = {
>          &swpout_attr.attr,
>          &swpout_fallback_attr.attr,
>   #endif
> -       &split_attr.attr,
> -       &split_failed_attr.attr,
>          &split_deferred_attr.attr,
>          &nr_anon_attr.attr,
>          &nr_anon_partially_mapped_attr.attr,
> @@ -663,6 +661,8 @@ static struct attribute *any_stats_attrs[] = {
>          &swpout_attr.attr,
>          &swpout_fallback_attr.attr,
>   #endif
> +       &split_attr.attr,
> +       &split_failed_attr.attr,
>          NULL,
>   };

The change looks good to me. Feel free to add
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

