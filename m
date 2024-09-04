Return-Path: <linux-kernel+bounces-314800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930A496B8E4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1761C21078
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F351CC175;
	Wed,  4 Sep 2024 10:47:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C692635
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446854; cv=none; b=Ny96CS2UHkvOA82Wb82bUImAK7Tam2BDC51d+z9qBIdPGG4Qij+7sKOTu/VclTeNl8wHut0s66gSu+Jls/aXEvhGKzdhJTmx1tXnPXFJNX08kQvJiy5u00qWaDZbuoHqRZsAEtLbHnDtFLxhf1vqnbut2dKffDhfiEnXiuPkkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446854; c=relaxed/simple;
	bh=t2XVLFemD5Kopy4SWLyufY4bCf1EvtXVF+nLjaeWgi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoklzjCqXm8kgUM0Q7yjt0FNGIaW+BydVzn/Q19yf+EU73jU9T86sBIwlAg+yHnE+BbX10N+ZanTvleyhNm5WvgBab8jhTo7noxTJR57poy/b7jjcRePFh/fdkpA599r1H7M6DxCTWEP5fG1xaHugRccYMMcQiUXtkE7eBy1RZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19CA7FEC;
	Wed,  4 Sep 2024 03:47:58 -0700 (PDT)
Received: from [10.57.87.65] (unknown [10.57.87.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D4423F73B;
	Wed,  4 Sep 2024 03:47:30 -0700 (PDT)
Message-ID: <f7ced14c-8bc5-405f-bee7-94f63980f525@arm.com>
Date: Wed, 4 Sep 2024 11:47:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: Tidy up shmem mTHP controls and stats
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, Gavin Shan <gshan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240808111849.651867-1-ryan.roberts@arm.com>
 <20240808111849.651867-3-ryan.roberts@arm.com>
 <747d1319-f746-4379-bf88-a0f6c3f558b4@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <747d1319-f746-4379-bf88-a0f6c3f558b4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrew,


On 09/08/2024 09:31, Baolin Wang wrote:
> 
> 
> On 2024/8/8 19:18, Ryan Roberts wrote:
>> Previously we had a situation where shmem mTHP controls and stats were
>> not exposed for some supported sizes and were exposed for some
>> unsupported sizes. So let's clean that up.
>>
>> Anon mTHP can support all large orders [2, PMD_ORDER]. But shmem can
>> support all large orders [1, MAX_PAGECACHE_ORDER]. However, per-size
>> shmem controls and stats were previously being exposed for all the anon
>> mTHP orders, meaning order-1 was not present, and for arm64 64K base
>> pages, orders 12 and 13 were exposed but were not supported internally.
>>
>> Tidy this all up by defining ctrl and stats attribute groups for anon
>> and file separately. Anon ctrl and stats groups are populated for all
>> orders in THP_ORDERS_ALL_ANON and file ctrl and stats groups are
>> populated for all orders in THP_ORDERS_ALL_FILE_DEFAULT.
>>
>> Additionally, create "any" ctrl and stats attribute groups which are
>> populated for all orders in (THP_ORDERS_ALL_ANON |
>> THP_ORDERS_ALL_FILE_DEFAULT). swpout stats use this since they apply to
>> anon and shmem.
>>
>> The side-effect of all this is that different hugepage-*kB directories
>> contain different sets of controls and stats, depending on which memory
>> types support that size. This approach is preferred over the
>> alternative, which is to populate dummy controls and stats for memory
>> types that do not support a given size.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   mm/huge_memory.c | 144 +++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 114 insertions(+), 30 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0c3075ee00012..082d86b7c6c2f 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -482,8 +482,8 @@ static void thpsize_release(struct kobject *kobj);
>>   static DEFINE_SPINLOCK(huge_anon_orders_lock);
>>   static LIST_HEAD(thpsize_list);
>>   -static ssize_t thpsize_enabled_show(struct kobject *kobj,
>> -                    struct kobj_attribute *attr, char *buf)
>> +static ssize_t anon_enabled_show(struct kobject *kobj,
>> +                 struct kobj_attribute *attr, char *buf)
>>   {
>>       int order = to_thpsize(kobj)->order;
>>       const char *output;
>> @@ -500,9 +500,9 @@ static ssize_t thpsize_enabled_show(struct kobject *kobj,
>>       return sysfs_emit(buf, "%s\n", output);
>>   }
>>   -static ssize_t thpsize_enabled_store(struct kobject *kobj,
>> -                     struct kobj_attribute *attr,
>> -                     const char *buf, size_t count)
>> +static ssize_t anon_enabled_store(struct kobject *kobj,
>> +                  struct kobj_attribute *attr,
>> +                  const char *buf, size_t count)
>>   {
>>       int order = to_thpsize(kobj)->order;
>>       ssize_t ret = count;
>> @@ -544,19 +544,35 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
>>       return ret;
>>   }
>>   -static struct kobj_attribute thpsize_enabled_attr =
>> -    __ATTR(enabled, 0644, thpsize_enabled_show, thpsize_enabled_store);
>> +static struct kobj_attribute anon_enabled_attr =
>> +    __ATTR(enabled, 0644, anon_enabled_show, anon_enabled_store);
>>   -static struct attribute *thpsize_attrs[] = {
>> -    &thpsize_enabled_attr.attr,
>> +static struct attribute *anon_ctrl_attrs[] = {
>> +    &anon_enabled_attr.attr,
>> +    NULL,
>> +};
>> +
>> +static const struct attribute_group anon_ctrl_attr_grp = {
>> +    .attrs = anon_ctrl_attrs,
>> +};
>> +
>> +static struct attribute *file_ctrl_attrs[] = {
>>   #ifdef CONFIG_SHMEM
>>       &thpsize_shmem_enabled_attr.attr,
>>   #endif
>>       NULL,
>>   };
>>   -static const struct attribute_group thpsize_attr_group = {
>> -    .attrs = thpsize_attrs,
>> +static const struct attribute_group file_ctrl_attr_grp = {
>> +    .attrs = file_ctrl_attrs,
>> +};
>> +
>> +static struct attribute *any_ctrl_attrs[] = {
>> +    NULL,
>> +};
>> +
>> +static const struct attribute_group any_ctrl_attr_grp = {
>> +    .attrs = any_ctrl_attrs,
>>   };
> 
> I wonder why adding a NULL group?
> 
>>     static const struct kobj_type thpsize_ktype = {
>> @@ -595,64 +611,132 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback,
>> MTHP_STAT_ANON_FAULT_FALLBACK);
>>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge,
>> MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>   DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>>   DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>> +#ifdef CONFIG_SHMEM
>>   DEFINE_MTHP_STAT_ATTR(shmem_alloc, MTHP_STAT_SHMEM_ALLOC);
>>   DEFINE_MTHP_STAT_ATTR(shmem_fallback, MTHP_STAT_SHMEM_FALLBACK);
>>   DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
>> +#endif
>>   DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>>   DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>>   DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>>   -static struct attribute *stats_attrs[] = {
>> +static struct attribute *anon_stats_attrs[] = {
>>       &anon_fault_alloc_attr.attr,
>>       &anon_fault_fallback_attr.attr,
>>       &anon_fault_fallback_charge_attr.attr,
>> +#ifndef CONFIG_SHMEM
>>       &swpout_attr.attr,
>>       &swpout_fallback_attr.attr,
>> -    &shmem_alloc_attr.attr,
>> -    &shmem_fallback_attr.attr,
>> -    &shmem_fallback_charge_attr.attr,
>> +#endif
>>       &split_attr.attr,
>>       &split_failed_attr.attr,
>>       &split_deferred_attr.attr,
>>       NULL,
>>   };
>>   -static struct attribute_group stats_attr_group = {
>> +static struct attribute_group anon_stats_attr_grp = {
>> +    .name = "stats",
>> +    .attrs = anon_stats_attrs,
>> +};
>> +
>> +static struct attribute *file_stats_attrs[] = {
>> +#ifdef CONFIG_SHMEM
>> +    &shmem_alloc_attr.attr,
>> +    &shmem_fallback_attr.attr,
>> +    &shmem_fallback_charge_attr.attr,
>> +#endif
>> +    NULL,
>> +};
>> +
>> +static struct attribute_group file_stats_attr_grp = {
>> +    .name = "stats",
>> +    .attrs = file_stats_attrs,
>> +};
>> +
>> +static struct attribute *any_stats_attrs[] = {
>> +#ifdef CONFIG_SHMEM
>> +    &swpout_attr.attr,
>> +    &swpout_fallback_attr.attr,
>> +#endif
> 
> Sorry I did not point it out in early version. I think file pages and shmem can
> also be split, while 'split_deferred' is only for anonymous page. So I think the
> any_stats_attrs should be:
> static struct attribute *any_stats_attrs[] = {
> #ifdef CONFIG_SHMEM
>     &swpout_attr.attr,
>     &swpout_fallback_attr.attr,
> #endif
>     &split_attr.attr,
>     &split_failed_attr.attr,
>     NULL,
> };

Could you please squash the following into this patch, which is already in
mm-unstable? I'm hoping this sufficient and I don't need to send a whole new
revision since there are changes on top of this in mm-unstable, which makes
things tricky.

----8<-----

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 382938e46f96f..5905957b1f70d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -631,8 +631,6 @@ static struct attribute *anon_stats_attrs[] = {
        &swpout_attr.attr,
        &swpout_fallback_attr.attr,
 #endif
-       &split_attr.attr,
-       &split_failed_attr.attr,
        &split_deferred_attr.attr,
        &nr_anon_attr.attr,
        &nr_anon_partially_mapped_attr.attr,
@@ -663,6 +661,8 @@ static struct attribute *any_stats_attrs[] = {
        &swpout_attr.attr,
        &swpout_fallback_attr.attr,
 #endif
+       &split_attr.attr,
+       &split_failed_attr.attr,
        NULL,
 };

----8<-----

Thanks,
Ryan


