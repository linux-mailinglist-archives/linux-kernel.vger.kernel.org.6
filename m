Return-Path: <linux-kernel+bounces-314761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542D896B819
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5CF1F218F6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16B1CEEAB;
	Wed,  4 Sep 2024 10:18:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152821EBFEB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445129; cv=none; b=Qp64aLf2tAIDLtk8N7n3x1Uqvovkq7a/9gBasSc4RwJRMZdHcM1M3lsBlM4TAIhACs6Coh/HYiU9c2P0vmtd0G+w8Dt6RxBzm633bBEwYbc+5S6O5Np5sIU1OiTakXCAzMa06p2DbLC1d2UediVPoi2j2D4wqq92G5Kc8goKSEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445129; c=relaxed/simple;
	bh=X9luuGaOYVhD/0UEqNofrFLgoGL4FNEdet6VMrvhIuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoOvmPMWTVkJXopHjoQCZpUyohRroefFwFKOOBjHF6/9Q4BifGEnK8npRLXqEXqX4TGmp6wLwlrtAdKZDbtYrK9kl2ksJMo09+qUkccM8Sll3aCRsWIA/k/v9B99+OV0yOziCUGrbxOzo5G7/vvQqt9VZYF++NpJOZqhNtzOylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B552FEC;
	Wed,  4 Sep 2024 03:19:13 -0700 (PDT)
Received: from [10.57.87.65] (unknown [10.57.87.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A01EC3F66E;
	Wed,  4 Sep 2024 03:18:45 -0700 (PDT)
Message-ID: <069185e0-80db-46a7-8852-2381db28cc97@arm.com>
Date: Wed, 4 Sep 2024 11:18:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: Tidy up shmem mTHP controls and stats
Content-Language: en-GB
To: Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 Gavin Shan <gshan@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240808111849.651867-1-ryan.roberts@arm.com>
 <20240808111849.651867-3-ryan.roberts@arm.com>
 <747d1319-f746-4379-bf88-a0f6c3f558b4@linux.alibaba.com>
 <14823123-79e3-4c7d-8501-8c46c6ec13c7@arm.com>
 <b8ba33c7-3fe7-4b0d-a43d-8a796818bc34@linux.alibaba.com>
 <CAGsJ_4z+yERPLwzm-8Mkx8MsNZAz0zZWycZfuGRjOc4kxS=HwQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4z+yERPLwzm-8Mkx8MsNZAz0zZWycZfuGRjOc4kxS=HwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/09/2024 02:53, Barry Song wrote:
> On Tue, Sep 3, 2024 at 1:15 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/9/2 17:58, Ryan Roberts wrote:
>>> Hi Baolin,
>>>
>>> Thanks for the review - I've been out on Paternity leave so only getting around
>>> to replying now...
>>
>> No worries :)
>>
>>> On 09/08/2024 09:31, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2024/8/8 19:18, Ryan Roberts wrote:
>>>>> Previously we had a situation where shmem mTHP controls and stats were
>>>>> not exposed for some supported sizes and were exposed for some
>>>>> unsupported sizes. So let's clean that up.
>>>>>
>>>>> Anon mTHP can support all large orders [2, PMD_ORDER]. But shmem can
>>>>> support all large orders [1, MAX_PAGECACHE_ORDER]. However, per-size
>>>>> shmem controls and stats were previously being exposed for all the anon
>>>>> mTHP orders, meaning order-1 was not present, and for arm64 64K base
>>>>> pages, orders 12 and 13 were exposed but were not supported internally.
>>>>>
>>>>> Tidy this all up by defining ctrl and stats attribute groups for anon
>>>>> and file separately. Anon ctrl and stats groups are populated for all
>>>>> orders in THP_ORDERS_ALL_ANON and file ctrl and stats groups are
>>>>> populated for all orders in THP_ORDERS_ALL_FILE_DEFAULT.
>>>>>
>>>>> Additionally, create "any" ctrl and stats attribute groups which are
>>>>> populated for all orders in (THP_ORDERS_ALL_ANON |
>>>>> THP_ORDERS_ALL_FILE_DEFAULT). swpout stats use this since they apply to
>>>>> anon and shmem.
>>>>>
>>>>> The side-effect of all this is that different hugepage-*kB directories
>>>>> contain different sets of controls and stats, depending on which memory
>>>>> types support that size. This approach is preferred over the
>>>>> alternative, which is to populate dummy controls and stats for memory
>>>>> types that do not support a given size.
>>>>>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>>    mm/huge_memory.c | 144 +++++++++++++++++++++++++++++++++++++----------
>>>>>    1 file changed, 114 insertions(+), 30 deletions(-)
>>>>>
>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>> index 0c3075ee00012..082d86b7c6c2f 100644
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -482,8 +482,8 @@ static void thpsize_release(struct kobject *kobj);
>>>>>    static DEFINE_SPINLOCK(huge_anon_orders_lock);
>>>>>    static LIST_HEAD(thpsize_list);
>>>>>    -static ssize_t thpsize_enabled_show(struct kobject *kobj,
>>>>> -                    struct kobj_attribute *attr, char *buf)
>>>>> +static ssize_t anon_enabled_show(struct kobject *kobj,
>>>>> +                 struct kobj_attribute *attr, char *buf)
>>>>>    {
>>>>>        int order = to_thpsize(kobj)->order;
>>>>>        const char *output;
>>>>> @@ -500,9 +500,9 @@ static ssize_t thpsize_enabled_show(struct kobject *kobj,
>>>>>        return sysfs_emit(buf, "%s\n", output);
>>>>>    }
>>>>>    -static ssize_t thpsize_enabled_store(struct kobject *kobj,
>>>>> -                     struct kobj_attribute *attr,
>>>>> -                     const char *buf, size_t count)
>>>>> +static ssize_t anon_enabled_store(struct kobject *kobj,
>>>>> +                  struct kobj_attribute *attr,
>>>>> +                  const char *buf, size_t count)
>>>>>    {
>>>>>        int order = to_thpsize(kobj)->order;
>>>>>        ssize_t ret = count;
>>>>> @@ -544,19 +544,35 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
>>>>>        return ret;
>>>>>    }
>>>>>    -static struct kobj_attribute thpsize_enabled_attr =
>>>>> -    __ATTR(enabled, 0644, thpsize_enabled_show, thpsize_enabled_store);
>>>>> +static struct kobj_attribute anon_enabled_attr =
>>>>> +    __ATTR(enabled, 0644, anon_enabled_show, anon_enabled_store);
>>>>>    -static struct attribute *thpsize_attrs[] = {
>>>>> -    &thpsize_enabled_attr.attr,
>>>>> +static struct attribute *anon_ctrl_attrs[] = {
>>>>> +    &anon_enabled_attr.attr,
>>>>> +    NULL,
>>>>> +};
>>>>> +
>>>>> +static const struct attribute_group anon_ctrl_attr_grp = {
>>>>> +    .attrs = anon_ctrl_attrs,
>>>>> +};
>>>>> +
>>>>> +static struct attribute *file_ctrl_attrs[] = {
>>>>>    #ifdef CONFIG_SHMEM
>>>>>        &thpsize_shmem_enabled_attr.attr,
>>>>>    #endif
>>>>>        NULL,
>>>>>    };
>>>>>    -static const struct attribute_group thpsize_attr_group = {
>>>>> -    .attrs = thpsize_attrs,
>>>>> +static const struct attribute_group file_ctrl_attr_grp = {
>>>>> +    .attrs = file_ctrl_attrs,
>>>>> +};
>>>>> +
>>>>> +static struct attribute *any_ctrl_attrs[] = {
>>>>> +    NULL,
>>>>> +};
>>>>> +
>>>>> +static const struct attribute_group any_ctrl_attr_grp = {
>>>>> +    .attrs = any_ctrl_attrs,
>>>>>    };
>>>>
>>>> I wonder why adding a NULL group?
>>>
>>> It made everything a bit more generic and therefore extensible. Its my
>>> preference to leave it as is, but will remove it if you insist.
>>
>> My preference is we should add it when necessary, but but I don't have a
>> strong opinion. Let's see what other guys prefer, David, Barry?
> 
> I'm fine with either option. Adding a NULL control group makes it
> easier for lazy
> people like me to understand the current status, as it clearly
> indicates that there
> isn't a shared control group for file, shmem, and anon at the moment. :-)

Thanks for the feedback, I'm going to leave it as is in the next version then.

> 
> Thanks
> Barry


