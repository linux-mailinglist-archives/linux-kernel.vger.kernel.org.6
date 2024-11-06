Return-Path: <linux-kernel+bounces-397573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1249BDD83
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D901B22859
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2118D649;
	Wed,  6 Nov 2024 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aK/60dNA"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5563B64D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 03:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730863071; cv=none; b=GsM0+/ZQToWRZ89yWNYcN/rujMEmBptXakuBQnFlIKkZSdlF8pBdOCfVYZnwLSkJ2Rw6zZx+lnyiYlYKQ/G7gkRoelgHb7Nn7hG6NW0bmqRGhpzdi1Dzo0/sfjxQfDarhFYKGwlu9qyE92I+NYs5mI3OwlAf36XSGuyPP2PXtYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730863071; c=relaxed/simple;
	bh=zVuoNoKnHAz8i+1uE7GjvTiUq85k8jUd87ogGp99lsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efHpBfdQUkaAb3ZzaX1jOQ7KJmRjZTCvEYobI+3hBV1paeRSqzL15iFMeDL1ihYxwcLo01FqN6gDxowF9rO99BL0BtfBDGQv/hzlhGxdhJvlEcaJ4hVHQf7wREc2aqB0cCHLkzwYV+NtHJhPmA7q9I6aIQGoo6w3xXFKO0hAwug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aK/60dNA; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730863066; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BTNcBJBLFbJi5RSiAAN8uvJZe6l9iB4IoderHiDiuDU=;
	b=aK/60dNAJ6Zl7GU0lMsxnQ18mJB0grQykBzJzl/mU6+QE4O/RaER2sBNs2RIgXEv0gt62AMveyhpL9JUdoU9qRM9CLQuFB2ZFOwZI9VK9o3ZaWlPDf+0NUI41yjkCN9T8+dKMrdylSENfB0p5As8nqPmGE4lBzSJYC0Z1te37CY=
Received: from 30.74.144.138(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WIpcbQW_1730863063 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 11:17:44 +0800
Message-ID: <fc6bc624-e84b-41c7-9deb-040f7ce8ee41@linux.alibaba.com>
Date: Wed, 6 Nov 2024 11:17:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: David Hildenbrand <david@redhat.com>, Daniel Gomez <d@kruces.com>,
 Daniel Gomez <da.gomez@samsung.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 hughd@google.com, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <CGME20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a@eucas1p1.samsung.com>
 <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
 <D51IU4N746MI.FDS6C7GYO4RP@samsung.com>
 <c59f2881-fbbb-41b1-830d-9d81f36ecc0b@linux.alibaba.com>
 <486a72c6-5877-4a95-a587-2a32faa8785d@redhat.com>
 <7eb412d1-f90e-4363-8c7b-072f1124f8a6@linux.alibaba.com>
 <1b0f9f94-06a6-48ac-a68e-848bce1008e9@redhat.com>
 <D53Z7I8D6MRB.XN14XUEFQFG7@kruces.com>
 <cbadd5fe-69d5-4c21-8eb8-3344ed36c721@redhat.com>
 <7ca333ba-f9bc-4f78-8f5b-1035ca91c2d5@redhat.com>
 <0b7671fd-3fea-4086-8a85-fe063a62fa80@linux.alibaba.com>
 <d758a4f4-e0e6-4a78-beb4-e513de229310@redhat.com>
 <2782890e-09dc-46bd-ab86-1f8974c7eb7a@linux.alibaba.com>
 <99a3cc07-bdc3-48e2-ab5c-6f4de1bd2e7b@redhat.com>
 <8172f4fb-17ce-4df9-a8cf-f2bed0910370@linux.alibaba.com>
 <01f91147-c66f-4501-bd55-3ff04088e337@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <01f91147-c66f-4501-bd55-3ff04088e337@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/5 22:56, David Hildenbrand wrote:
> On 05.11.24 13:45, Baolin Wang wrote:
>>
>>
>> On 2024/10/31 18:46, David Hildenbrand wrote:
>> [snip]
>>
>>>>> I don't like that:
>>>>>
>>>>> (a) there is no way to explicitly enable/name that new behavior.
>>>>
>>>> But this is similar to other file systems that enable large folios
>>>> (setting mapping_set_large_folios()), and I haven't seen any other file
>>>> systems supporting large folios requiring a new Kconfig. Maybe tmpfs is
>>>> a bit special?
>>>
>>> I'm afraid I don't have the energy to explain once more why I think
>>> tmpfs is not just like any other file system in some cases.
>>>
>>> And distributions are rather careful when it comes to something like
>>> this ...
>>>
>>>>
>>>> If we all agree that tmpfs is a bit special when using huge pages, then
>>>> fine, a Kconfig option might be needed.
>>>>
>>>>> (b) "always" etc. are only concerned about PMDs.
>>>>
>>>> Yes, currently maintain the same semantics as before, in case users
>>>> still expect THPs.
>>>
>>> Again, I don't think that is a reasonable approach to make PMD-sized
>>> ones special here. It will all get seriously confusing and inconsistent.
>>
>> I agree PMD-sized should not be special. This is all for backward
>> compatibility with the ‘huge=’ mount option, and adding a new kconfig is
>> also for this purpose.
>>
>>> THPs are opportunistic after all, and page fault behavior will remain
>>> unchanged (PMD-sized) for now. And even if we support other sizes during
>>> page faults, we'd like start with the largest size (PMD-size) first, and
>>> it likely might just all work better than before.
>>>
>>> Happy to learn where this really makes a difference.
>>>
>>> Of course, if you change the default behavior (which you are planning),
>>> it's ... a changed default.
>>>
>>> If there are reasons to have more tunables regarding the sizes to use,
>>> then it should not be limited to PMD-size.
>>
>> I have tried to modify the code according to your suggestion (not tested
>> yet). These are what you had in mind?
>>
>> static inline unsigned int
>> shmem_mapping_size_order(struct address_space *mapping, pgoff_t index,
>> loff_t write_end)
>> {
>>           unsigned int order;
>>           size_t size;
>>
>>           if (!mapping_large_folio_support(mapping) || !write_end)
>>                   return 0;
>>
>>           /* Calculate the write size based on the write_end */
>>           size = write_end - (index << PAGE_SHIFT);
>>           order = filemap_get_order(size);
>>           if (!order)
>>                   return 0;
>>
>>           /* If we're not aligned, allocate a smaller folio */
>>           if (index & ((1UL << order) - 1))
>>                   order = __ffs(index);
>>
>>           order = min_t(size_t, order, MAX_PAGECACHE_ORDER);
>>           return order > 0 ? BIT(order + 1) - 1 : 0;
>> }
>>
>> static unsigned int shmem_huge_global_enabled(struct inode *inode,
>> pgoff_t index,
>>                                                 loff_t write_end, bool
>> shmem_huge_force,
>>                                                 unsigned long vm_flags)
>> {
>>           bool is_shmem = inode->i_sb == shm_mnt->mnt_sb;
>>           unsigned long within_size_orders;
>>           unsigned int order;
>>           loff_t i_size;
>>
>>           if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
>>                   return 0;
>>           if (!S_ISREG(inode->i_mode))
>>                   return 0;
>>           if (shmem_huge == SHMEM_HUGE_DENY)
>>                   return 0;
>>           if (shmem_huge_force || shmem_huge == SHMEM_HUGE_FORCE)
>>                   return BIT(HPAGE_PMD_ORDER);
>>
>>           switch (SHMEM_SB(inode->i_sb)->huge) {
>>           case SHMEM_HUGE_NEVER:
>>                   return 0;
>>           case SHMEM_HUGE_ALWAYS:
>>                   if (is_shmem || 
>> IS_ENABLED(CONFIG_USE_ONLY_THP_FOR_TMPFS))
>>                           return BIT(HPAGE_PMD_ORDER);
>>
>>                   return shmem_mapping_size_order(inode->i_mapping,
>> index, write_end);
>>           case SHMEM_HUGE_WITHIN_SIZE:
>>                   if (is_shmem || 
>> IS_ENABLED(CONFIG_USE_ONLY_THP_FOR_TMPFS))
>>                           within_size_orders = BIT(HPAGE_PMD_ORDER);
>>                   else
>>                           within_size_orders =
>> shmem_mapping_size_order(inode->i_mapping,
>> index, write_end);
>>
>>                   order = highest_order(within_size_orders);
>>                   while (within_size_orders) {
>>                           index = round_up(index + 1, 1 << order);
>>                           i_size = max(write_end, i_size_read(inode));
>>                           i_size = round_up(i_size, PAGE_SIZE);
>>                           if (i_size >> PAGE_SHIFT >= index)
>>                                   return within_size_orders;
>>
>>                           order = next_order(&within_size_orders, order);
>>                   }
>>                   fallthrough;
>>           case SHMEM_HUGE_ADVISE:
>>                   if (vm_flags & VM_HUGEPAGE) {
>>                           if (is_shmem || 
>> IS_ENABLED(USE_ONLY_THP_FOR_TMPFS))
>>                                   return BIT(HPAGE_PMD_ORDER);
>>
>>                           return 
>> shmem_mapping_size_order(inode->i_mapping,
>>                                                           index, 
>> write_end);
>>                   }
>>                   fallthrough;
>>           default:
>>                   return 0;
>>           }
>> }
>>
>> 1) Add a new 'CONFIG_USE_ONLY_THP_FOR_TMPFS' kconfig to keep ‘huge=’
>> mount option compatibility.
>> 2) For tmpfs write(), if CONFIG_USE_ONLY_THP_FOR_TMPFS is not enabled,
>> then will get the possible huge orders based on the write size.
>> 3) For tmpfs mmap() fault, always use PMD-sized huge order.
>> 4) For shmem, ignore the write size logic and always use PMD-sized THP
>> to check if the global huge is enabled.
>>
>> However, in case 2), if 'huge=always' and write size is less than 4K, so
>> we will allocate small pages, that will break the 'huge' semantics?
>> Maybe it's not something to worry too much about.
> 
> Probably I didn't express clearly what I think we should, because this is
> not quite what I had in mind.
> 
> I would use the CONFIG_USE_ONLY_THP_FOR_TMPFS way of doing it only if
> really required. As raised, if someone needs finer control, providing that
> only for a single size is rather limiting.

OK. I misunderstood your points.

> This is what I hope we can do (doc update to show what I mean):

Thanks for updating the doc. I'd like to include them in the next version.

> diff --git a/Documentation/admin-guide/mm/transhuge.rst 
> b/Documentation/admin-guide/mm/transhuge.rst
> index 5034915f4e8e8..d7d1a9acdbfc5 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -349,11 +349,24 @@ user, the PMD_ORDER hugepage policy will be 
> overridden. If the policy for
>   PMD_ORDER is not defined within a valid ``thp_shmem``, its policy will
>   default to ``never``.
> 
> -Hugepages in tmpfs/shmem
> -========================
> +tmpfs/shmem
> +===========
> 
> -You can control hugepage allocation policy in tmpfs with mount option
> -``huge=``. It can have following values:
> +Traditionally, tmpfs only supported a single huge page size ("PMD"). 
> Today,
> +it also supports smaller sizes just like anonymous memory, often referred
> +to as "multi-size THP" (mTHP). Huge pages of any size are commonly
> +represented in the kernel as "large folios".
> +
> +While there is fine control over the huge page sizes to use for the 
> internal
> +shmem mount (see below), ordinary tmpfs mounts will make use of all
> +available huge page sizes without any control over the exact sizes,
> +behaving more like other file systems.
> +
> +tmpfs mounts
> +------------
> +
> +The THP allocation policy for tmpfs mounts can be adjusted using the mount
> +option: ``huge=``. It can have following values:
> 
>   always
>       Attempt to allocate huge pages every time we need a new page;
> @@ -368,19 +381,20 @@ within_size
>   advise
>       Only allocate huge pages if requested with fadvise()/madvise();
> 
> -The default policy is ``never``.
> +Remember, that the kernel may use huge pages of all available sizes, and
> +that no fine control as for the internal tmpfs mount is available.
> +
> +The default policy in the past was ``never``, but it can now be adjusted
> +using the CONFIG_TMPFS_TRANSPARENT_HUGEPAGE_ALWAYS,
> +CONFIG_TMPFS_TRANSPARENT_HUGEPAGE_NEVER etc.
> 
>   ``mount -o remount,huge= /mountpoint`` works fine after mount: remounting
>   ``huge=never`` will not attempt to break up huge pages at all, just 
> stop more
>   from being allocated.
> 
> -There's also sysfs knob to control hugepage allocation policy for internal
> -shmem mount: /sys/kernel/mm/transparent_hugepage/shmem_enabled. The mount
> -is used for SysV SHM, memfds, shared anonymous mmaps (of /dev/zero or
> -MAP_ANONYMOUS), GPU drivers' DRM objects, Ashmem.
> -
> -In addition to policies listed above, shmem_enabled allows two further
> -values:
> +In addition to policies listed above, the sysfs knob
> +/sys/kernel/mm/transparent_hugepage/shmem_enabled will affect the
> +allocation policy of tmpfs mounts, when set to the following values:
> 
>   deny
>       For use in emergencies, to force the huge option off from
> @@ -388,13 +402,26 @@ deny
>   force
>       Force the huge option on for all - very useful for testing;
> 
> -Shmem can also use "multi-size THP" (mTHP) by adding a new sysfs knob to
> -control mTHP allocation:
> -'/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/shmem_enabled',
> -and its value for each mTHP is essentially consistent with the global
> -setting.  An 'inherit' option is added to ensure compatibility with these
> -global settings.  Conversely, the options 'force' and 'deny' are dropped,
> -which are rather testing artifacts from the old ages.
> +
> +shmem / internal tmpfs
> +----------------------
> +
> +The mount internal tmpfs mount is used for SysV SHM, memfds, shared 
> anonymous
> +mmaps (of /dev/zero or MAP_ANONYMOUS), GPU drivers' DRM  objects, Ashmem.
> +
> +To control the THP allocation policy for this internal tmpfs mount, the
> +sysfs knob /sys/kernel/mm/transparent_hugepage/shmem_enabled and the knobs
> +per THP size in
> +'/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/shmem_enabled'
> +can be used.
> +
> +The global knob has the same semantics as the ``huge=`` mount options
> +for tmpfs mounts, except that the different huge page sizes can be 
> controlled
> +individually, and will only use the setting of the global knob when the
> +per-size knob is set to 'inherit'.
> +
> +The options 'force' and 'deny' are dropped for the individual sizes, which
> +are rather testing artifacts from the old ages.
> 
>   always
>       Attempt to allocate <size> huge pages every time we need a new page;
> diff --git a/Documentation/filesystems/tmpfs.rst 
> b/Documentation/filesystems/tmpfs.rst
> index 56a26c843dbe9..10de8f706d07b 100644
> 
> 
> 
> There is this question of "do we need the old way of doing it and only
> allocate PMDs". For that, likely a config similar to the one you propose 
> might
> make sense, but I would want to see if there is real demand for that. In 
> particular:
> for whom the smaller sizes are a problem when bigger (PMD) sizes were
> enabled in the past.

I am also not sure if such a case exists. I can remove this kconfig for 
now, and we can consider it again if someone really complains this in 
the future.

