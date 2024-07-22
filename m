Return-Path: <linux-kernel+bounces-258494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CEF9388CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A48C1C20DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056CE17BA7;
	Mon, 22 Jul 2024 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZRcWX3Ox"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D33175BF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721628847; cv=none; b=Q8wxFZuY3Yo/uasMVls5d5ROiRn401+axcqCL2WMsRVaI+6VkLTjLb/hp7D1dMWidaOXYDYHzGwTsAugvN1pxLhPAdpq+/JEkVD8ZMNzfGOChxX72CJcHp2RXwCU862uchIxsxHahz+eYOccfJlI02nQMPJHrthpRe1nQKG8YGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721628847; c=relaxed/simple;
	bh=e5PdcQQLSegQIN/YKPGsF7+oL60zEbjv5y9SEACNH7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qF4rvosTwQCOpwOGbhmHPHamMT2OYss+Q1YPlqQQ78HtIfawvHYEh5AzZoUa87Lt+YrhL6Ji/7tGK0JdiOuSA25AMU6kL3MjYpP0qIhlgOROQlmuFFTul3k8c6VjqYw1kAfKJgHWC071A8Z0NmGhwHutygCA5pUpXAhKn+uPlsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZRcWX3Ox; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721628842; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=psWoa8gs4DgPKMVzS4Tt55VRNtl5XNEvd7BQaoJFa24=;
	b=ZRcWX3OxgCEQ3E1kOJmjk5ElORKjmS6oOEW9GXSiX3q573+n0267FrUzG52fnsKjFE4s91WJZPxA1IJmkkoLfBYE0Flny/49X7Bnq6Q0yN1ON7YRlB8e6Sljm2aB+nq0D8ram8tgjRGHhjwiZtHlz6jxVCktNhnLAmJggm6XiV8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WAzT8Iy_1721628840;
Received: from 30.97.56.74(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAzT8Iy_1721628840)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 14:14:01 +0800
Message-ID: <9a7c863d-b64e-4278-bb5b-db777736ab6e@linux.alibaba.com>
Date: Mon, 22 Jul 2024 14:14:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm: Tidy up shmem mTHP controls and stats
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, Gavin Shan <gshan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240716135907.4047689-1-ryan.roberts@arm.com>
 <20240716135907.4047689-3-ryan.roberts@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240716135907.4047689-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/16 21:59, Ryan Roberts wrote:
> Previously we had a situation where shmem mTHP controls and stats were
> not exposed for some supported sizes and were exposed for some
> unsupported sizes. So let's clean that up.
> 
> Anon mTHP can support all large orders (2, PMD_ORDER). But shmem can
> support all large orders (1, MAX_PAGECACHE_ORDER). However, per-size
> shmem controls and stats were previously being exposed for all the anon
> mTHP orders, meaning order-1 was not present, and for arm64 64K base
> pages, orders 12 and 13 were exposed but were not supported internally.
> 
> Tidy this all up by defining ctrl and stats attribute groups for anon
> and file separately. Anon ctrl and stats groups are populated for all
> orders in THP_ORDERS_ALL_ANON and file ctrl and stats groups are
> populated for all orders in THP_ORDERS_ALL_FILE_DEFAULT.

Make sense.

> 
> The side-effect of all this is that different hugepage-*kB directories
> contain different sets of controls and stats, depending on which memory
> types support that size. This approach is preferred over the
> alternative, which is to populate dummy controls and stats for memory
> types that do not support a given size.

OK.

> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   mm/huge_memory.c | 110 ++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 80 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f4be468e06a4..578ac212c172 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -463,8 +463,8 @@ static void thpsize_release(struct kobject *kobj);
>   static DEFINE_SPINLOCK(huge_anon_orders_lock);
>   static LIST_HEAD(thpsize_list);
>   
> -static ssize_t thpsize_enabled_show(struct kobject *kobj,
> -				    struct kobj_attribute *attr, char *buf)
> +static ssize_t anon_enabled_show(struct kobject *kobj,
> +				 struct kobj_attribute *attr, char *buf)
>   {
>   	int order = to_thpsize(kobj)->order;
>   	const char *output;
> @@ -481,9 +481,9 @@ static ssize_t thpsize_enabled_show(struct kobject *kobj,
>   	return sysfs_emit(buf, "%s\n", output);
>   }
>   
> -static ssize_t thpsize_enabled_store(struct kobject *kobj,
> -				     struct kobj_attribute *attr,
> -				     const char *buf, size_t count)
> +static ssize_t anon_enabled_store(struct kobject *kobj,
> +				  struct kobj_attribute *attr,
> +				  const char *buf, size_t count)
>   {
>   	int order = to_thpsize(kobj)->order;
>   	ssize_t ret = count;
> @@ -525,19 +525,27 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
>   	return ret;
>   }
>   
> -static struct kobj_attribute thpsize_enabled_attr =
> -	__ATTR(enabled, 0644, thpsize_enabled_show, thpsize_enabled_store);
> +static struct kobj_attribute anon_enabled_attr =
> +	__ATTR(enabled, 0644, anon_enabled_show, anon_enabled_store);
>   
> -static struct attribute *thpsize_attrs[] = {
> -	&thpsize_enabled_attr.attr,
> +static struct attribute *anon_ctrl_attrs[] = {
> +	&anon_enabled_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group anon_ctrl_attr_grp = {
> +	.attrs = anon_ctrl_attrs,
> +};
> +
> +static struct attribute *file_ctrl_attrs[] = {
>   #ifdef CONFIG_SHMEM
>   	&thpsize_shmem_enabled_attr.attr,
>   #endif
>   	NULL,
>   };
>   
> -static const struct attribute_group thpsize_attr_group = {
> -	.attrs = thpsize_attrs,
> +static const struct attribute_group file_ctrl_attr_grp = {
> +	.attrs = file_ctrl_attrs,
>   };
>   
>   static const struct kobj_type thpsize_ktype = {
> @@ -583,57 +591,99 @@ DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>   DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>   DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>   
> -static struct attribute *stats_attrs[] = {
> +static struct attribute *anon_stats_attrs[] = {
>   	&anon_fault_alloc_attr.attr,
>   	&anon_fault_fallback_attr.attr,
>   	&anon_fault_fallback_charge_attr.attr,
>   	&swpout_attr.attr,
>   	&swpout_fallback_attr.attr,
> -	&shmem_alloc_attr.attr,
> -	&shmem_fallback_attr.attr,
> -	&shmem_fallback_charge_attr.attr,
>   	&split_attr.attr,
>   	&split_failed_attr.attr,
>   	&split_deferred_attr.attr,
>   	NULL,
>   };
>   
> -static struct attribute_group stats_attr_group = {
> +static struct attribute_group anon_stats_attr_grp = {
> +	.name = "stats",
> +	.attrs = anon_stats_attrs,
> +};
> +
> +static struct attribute *file_stats_attrs[] = {
> +#ifdef CONFIG_SHMEM
> +	&shmem_alloc_attr.attr,
> +	&shmem_fallback_attr.attr,
> +	&shmem_fallback_charge_attr.attr,

Shmem should also support swpout_* counters.

