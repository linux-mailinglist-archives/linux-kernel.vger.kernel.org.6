Return-Path: <linux-kernel+bounces-312007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC29690D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CE21C22400
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C570A1C2DA8;
	Tue,  3 Sep 2024 01:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wh03pPVH"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517C1C174D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725326148; cv=none; b=OsSQbr+JxjloRYFIPUUrPalM5thZUIU9A76z7/i3HH412KoPFQ1jc7GJRVcSmrlHNLoq5Mcfvex2fCRru8IZmBhBoGZHP1Ha3ixtB+0RIRg0Yt8EBXjJz2eS4/lxlzWVXql/SUFhsOOWbQh1Guru8UOYrTvK3/qT9JdwNNqNS0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725326148; c=relaxed/simple;
	bh=nfx7D0zsq28pLuNZTHDsKrLG9WMaMYzbv0T8g3h6xr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sh3fN6IBzeMIYDRQB8AQIxhXtffw2Ke1T3ShAhHprIHXBxRECauHFFGjY1BC6c63/RN13lOVMa4ww78qNX4HjidPVG/HcKFUMIfbYmNx4zSKQD1ffbJtn3TnE/FRaFqliZXm2y8usfex+LRY2oNep0iNYIw9BD0Kjx7Jwn8mWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wh03pPVH; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725326142; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TzlklaidYy3eFIkRP9DWHLpTDbs7aAqmDcAR3JaO49M=;
	b=wh03pPVHTg06ElxYcxYZJebEKwcg9D0/h5RGctNqpNK0Wy6oSM/Woxr5Ipw6lO4bi9SmLTyfDgHea6NOTjAJbQ89kJAN8fChsNOQvbla60oIlxSjjnIChvN1YMMX6TlWFRTjtoBSa6bsVuGpTSE0YQT4CR0Dmkbbn5iCJFstw7w=
Received: from 30.74.144.108(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WEBErgJ_1725326141)
          by smtp.aliyun-inc.com;
          Tue, 03 Sep 2024 09:15:41 +0800
Message-ID: <b8ba33c7-3fe7-4b0d-a43d-8a796818bc34@linux.alibaba.com>
Date: Tue, 3 Sep 2024 09:15:39 +0800
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
 <14823123-79e3-4c7d-8501-8c46c6ec13c7@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <14823123-79e3-4c7d-8501-8c46c6ec13c7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/2 17:58, Ryan Roberts wrote:
> Hi Baolin,
> 
> Thanks for the review - I've been out on Paternity leave so only getting around
> to replying now...

No worries :)

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
> 
> It made everything a bit more generic and therefore extensible. Its my
> preference to leave it as is, but will remove it if you insist.

My preference is we should add it when necessary, but but I don't have a 
strong opinion. Let's see what other guys prefer, David, Barry?

