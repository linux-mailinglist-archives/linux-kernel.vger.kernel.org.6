Return-Path: <linux-kernel+bounces-258584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D9C938A18
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BC48B209A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6AC381BA;
	Mon, 22 Jul 2024 07:33:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A36314F9C9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633592; cv=none; b=qtWb7FVQbjgzbE08WlwDMtR/IXIE8OwfxoXB6ZQ21sP6eammKohL/S5CCb7E/7upI7VxF7tZn8fQzE/yg5rzx1HG3FN764kTvd05YphCpictEX17bzozwzeuY13rG2JC4GxJyW23xWvdQg2m1sbMG5/X8GhRB8Zf7fgAp0H07zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633592; c=relaxed/simple;
	bh=+iiQPCCgQmiZG1Rk8Q8zrrvUuq9+0lsyFBwnBEm+1wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLGa5u3utohl2hMCTbjPnTAP6bVk2cPOCE6ZWLLh55wxwqmuKKoHYmy0RkaTrIt0NlUrkiq6v8TOTPSP06cWbyyk6IlW0UzvaLoVARI3Ab4AqFLX39sYlIz8XXLKBCR5y6ADlM7erZEHLcS2/vVygtz+3ftGoadcBZ4PJ9j5JOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ABCEFEC;
	Mon, 22 Jul 2024 00:33:34 -0700 (PDT)
Received: from [10.57.77.243] (unknown [10.57.77.243])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 541E53F766;
	Mon, 22 Jul 2024 00:33:07 -0700 (PDT)
Message-ID: <1732c37b-ab9d-47f7-8bfe-cc7992b632cf@arm.com>
Date: Mon, 22 Jul 2024 08:33:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm: Tidy up shmem mTHP controls and stats
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, Gavin Shan <gshan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240716135907.4047689-1-ryan.roberts@arm.com>
 <20240716135907.4047689-3-ryan.roberts@arm.com>
 <9a7c863d-b64e-4278-bb5b-db777736ab6e@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <9a7c863d-b64e-4278-bb5b-db777736ab6e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/07/2024 07:14, Baolin Wang wrote:
> 
> 
> On 2024/7/16 21:59, Ryan Roberts wrote:
>> Previously we had a situation where shmem mTHP controls and stats were
>> not exposed for some supported sizes and were exposed for some
>> unsupported sizes. So let's clean that up.
>>
>> Anon mTHP can support all large orders (2, PMD_ORDER). But shmem can
>> support all large orders (1, MAX_PAGECACHE_ORDER). However, per-size
>> shmem controls and stats were previously being exposed for all the anon
>> mTHP orders, meaning order-1 was not present, and for arm64 64K base
>> pages, orders 12 and 13 were exposed but were not supported internally.
>>
>> Tidy this all up by defining ctrl and stats attribute groups for anon
>> and file separately. Anon ctrl and stats groups are populated for all
>> orders in THP_ORDERS_ALL_ANON and file ctrl and stats groups are
>> populated for all orders in THP_ORDERS_ALL_FILE_DEFAULT.
> 
> Make sense.
> 
>>
>> The side-effect of all this is that different hugepage-*kB directories
>> contain different sets of controls and stats, depending on which memory
>> types support that size. This approach is preferred over the
>> alternative, which is to populate dummy controls and stats for memory
>> types that do not support a given size.
> 
> OK.
> 
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   mm/huge_memory.c | 110 ++++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 80 insertions(+), 30 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index f4be468e06a4..578ac212c172 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -463,8 +463,8 @@ static void thpsize_release(struct kobject *kobj);
>>   static DEFINE_SPINLOCK(huge_anon_orders_lock);
>>   static LIST_HEAD(thpsize_list);
>>   -static ssize_t thpsize_enabled_show(struct kobject *kobj,
>> -                    struct kobj_attribute *attr, char *buf)
>> +static ssize_t anon_enabled_show(struct kobject *kobj,
>> +                 struct kobj_attribute *attr, char *buf)
>>   {
>>       int order = to_thpsize(kobj)->order;
>>       const char *output;
>> @@ -481,9 +481,9 @@ static ssize_t thpsize_enabled_show(struct kobject *kobj,
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
>> @@ -525,19 +525,27 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
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
>>   };
>>     static const struct kobj_type thpsize_ktype = {
>> @@ -583,57 +591,99 @@ DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>>   DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>>   DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>>   -static struct attribute *stats_attrs[] = {
>> +static struct attribute *anon_stats_attrs[] = {
>>       &anon_fault_alloc_attr.attr,
>>       &anon_fault_fallback_attr.attr,
>>       &anon_fault_fallback_charge_attr.attr,
>>       &swpout_attr.attr,
>>       &swpout_fallback_attr.attr,
>> -    &shmem_alloc_attr.attr,
>> -    &shmem_fallback_attr.attr,
>> -    &shmem_fallback_charge_attr.attr,
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
> 
> Shmem should also support swpout_* counters.

OK, so to put it another way, swpout_* stats are required all orders in
(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE_DEFAULT) if CONFIG_SHMEM is defined,
else all orders in THP_ORDERS_ALL_ANON. Have I understood correctly?

If so, I'll fix that in the next version.


