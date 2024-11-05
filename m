Return-Path: <linux-kernel+bounces-396429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 935889BCCFA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53152282777
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4491D54E1;
	Tue,  5 Nov 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FOYwyeIL"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2371CEAA2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730810717; cv=none; b=V5w5+OyGw/omoeqdUZiJh+GjlAHFFC0xNuzC86By8JSx4pMFBKCoaJ9TH45m4xFj7eWC+P3JfEOXWMFH42wx/U80xf/IGCY/lyQEeGMIhFmPWoIhx0o9LAW6Haz9Y96pDdQXOY+gOFPjkNI5GL44Fna4FQyGVGgvkcB0GITvl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730810717; c=relaxed/simple;
	bh=chROV4BTpW9k5jLxdPR3JTP/xWjq6S7imIoHGKKIFbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gP2ozZmm5W9C9aI1Fln12/4zLE7Y4phrpkVBPtqdsxddi5Yc6NjgbWSwAV3/8CZxIyVSv+BxwvHcKbGE/BfBbA629I76qHv/0TTB8QJ808N525TneC5WNhU/MdUnuXcE5jJrUlD7Nrp/YQjpZECeE8lUKskcvsikWduOn+cUw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FOYwyeIL; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730810707; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uH3O49gahpCwXHsJg8KTfuuSAcNk/93y+You62c87eg=;
	b=FOYwyeIL86b8OVUnFIz+yLBA1kxDE9y0jQiIMmt30kou/d0meHYJaOyrmvLzZGzsDGlWQNyv0PiO03MJCstsXKB+ONLRybaGRcYZhTcyRGwGTB0xfDxBwKDIWUfWbj4+KWbr/Nhc9SNleTb/JSiAz4EqBSVwLjkElarvCXHiRpI=
Received: from 30.74.144.123(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WImyVVm_1730810704 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 20:45:04 +0800
Message-ID: <8172f4fb-17ce-4df9-a8cf-f2bed0910370@linux.alibaba.com>
Date: Tue, 5 Nov 2024 20:45:01 +0800
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
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <99a3cc07-bdc3-48e2-ab5c-6f4de1bd2e7b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/31 18:46, David Hildenbrand wrote:
[snip]

>>> I don't like that:
>>>
>>> (a) there is no way to explicitly enable/name that new behavior.
>>
>> But this is similar to other file systems that enable large folios
>> (setting mapping_set_large_folios()), and I haven't seen any other file
>> systems supporting large folios requiring a new Kconfig. Maybe tmpfs is
>> a bit special?
> 
> I'm afraid I don't have the energy to explain once more why I think 
> tmpfs is not just like any other file system in some cases.
> 
> And distributions are rather careful when it comes to something like 
> this ...
> 
>>
>> If we all agree that tmpfs is a bit special when using huge pages, then
>> fine, a Kconfig option might be needed.
>>
>>> (b) "always" etc. are only concerned about PMDs.
>>
>> Yes, currently maintain the same semantics as before, in case users
>> still expect THPs.
> 
> Again, I don't think that is a reasonable approach to make PMD-sized 
> ones special here. It will all get seriously confusing and inconsistent.

I agree PMD-sized should not be special. This is all for backward 
compatibility with the ‘huge=’ mount option, and adding a new kconfig is 
also for this purpose.

> THPs are opportunistic after all, and page fault behavior will remain 
> unchanged (PMD-sized) for now. And even if we support other sizes during 
> page faults, we'd like start with the largest size (PMD-size) first, and 
> it likely might just all work better than before.
> 
> Happy to learn where this really makes a difference.
> 
> Of course, if you change the default behavior (which you are planning), 
> it's ... a changed default.
> 
> If there are reasons to have more tunables regarding the sizes to use, 
> then it should not be limited to PMD-size.

I have tried to modify the code according to your suggestion (not tested 
yet). These are what you had in mind?

static inline unsigned int
shmem_mapping_size_order(struct address_space *mapping, pgoff_t index, 
loff_t write_end)
{
         unsigned int order;
         size_t size;

         if (!mapping_large_folio_support(mapping) || !write_end)
                 return 0;

         /* Calculate the write size based on the write_end */
         size = write_end - (index << PAGE_SHIFT);
         order = filemap_get_order(size);
         if (!order)
                 return 0;

         /* If we're not aligned, allocate a smaller folio */
         if (index & ((1UL << order) - 1))
                 order = __ffs(index);

         order = min_t(size_t, order, MAX_PAGECACHE_ORDER);
         return order > 0 ? BIT(order + 1) - 1 : 0;
}

static unsigned int shmem_huge_global_enabled(struct inode *inode, 
pgoff_t index,
                                               loff_t write_end, bool 
shmem_huge_force,
                                               unsigned long vm_flags)
{
         bool is_shmem = inode->i_sb == shm_mnt->mnt_sb;
         unsigned long within_size_orders;
         unsigned int order;
         loff_t i_size;

         if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
                 return 0;
         if (!S_ISREG(inode->i_mode))
                 return 0;
         if (shmem_huge == SHMEM_HUGE_DENY)
                 return 0;
         if (shmem_huge_force || shmem_huge == SHMEM_HUGE_FORCE)
                 return BIT(HPAGE_PMD_ORDER);

         switch (SHMEM_SB(inode->i_sb)->huge) {
         case SHMEM_HUGE_NEVER:
                 return 0;
         case SHMEM_HUGE_ALWAYS:
                 if (is_shmem || IS_ENABLED(CONFIG_USE_ONLY_THP_FOR_TMPFS))
                         return BIT(HPAGE_PMD_ORDER);

                 return shmem_mapping_size_order(inode->i_mapping, 
index, write_end);
         case SHMEM_HUGE_WITHIN_SIZE:
                 if (is_shmem || IS_ENABLED(CONFIG_USE_ONLY_THP_FOR_TMPFS))
                         within_size_orders = BIT(HPAGE_PMD_ORDER);
                 else
                         within_size_orders = 
shmem_mapping_size_order(inode->i_mapping,
 
index, write_end);

                 order = highest_order(within_size_orders);
                 while (within_size_orders) {
                         index = round_up(index + 1, 1 << order);
                         i_size = max(write_end, i_size_read(inode));
                         i_size = round_up(i_size, PAGE_SIZE);
                         if (i_size >> PAGE_SHIFT >= index)
                                 return within_size_orders;

                         order = next_order(&within_size_orders, order);
                 }
                 fallthrough;
         case SHMEM_HUGE_ADVISE:
                 if (vm_flags & VM_HUGEPAGE) {
                         if (is_shmem || IS_ENABLED(USE_ONLY_THP_FOR_TMPFS))
                                 return BIT(HPAGE_PMD_ORDER);

                         return shmem_mapping_size_order(inode->i_mapping,
                                                         index, write_end);
                 }
                 fallthrough;
         default:
                 return 0;
         }
}

1) Add a new 'CONFIG_USE_ONLY_THP_FOR_TMPFS' kconfig to keep ‘huge=’ 
mount option compatibility.
2) For tmpfs write(), if CONFIG_USE_ONLY_THP_FOR_TMPFS is not enabled, 
then will get the possible huge orders based on the write size.
3) For tmpfs mmap() fault, always use PMD-sized huge order.
4) For shmem, ignore the write size logic and always use PMD-sized THP 
to check if the global huge is enabled.

However, in case 2), if 'huge=always' and write size is less than 4K, so 
we will allocate small pages, that will break the 'huge' semantics? 
Maybe it's not something to worry too much about.

>>> huge=never: No THPs of any size
>>> huge=always: THPs of any size
>>> huge=fadvise: like "always" but only with fadvise/madvise
>>> huge=within_size: like "fadvise" but respect i_size
>>>
>>> "huge=" default depends on a Kconfig option.
>>>
>>> With that we:
>>>
>>> (1) Maximize the cases where we will use large folios of any sizes
>>>       (which Willy cares about).
>>> (2) Have a way to disable them completely (which I care about).
>>> (3) Allow distros to keep the default unchanged.
>>>
>>> Likely, for now we will only try allocating PMD-sized THPs during page
>>> faults, and allocate different sizes only during write(). So the effect
>>> for many use cases (VMs, DBs) that primarily mmap() tmpfs files will be
>>> completely unchanged even with "huge=always".
>>>
>>> It will get more tricky once we change that behavior as well, but that's
>>> something to likely figure out if it is a real problem at at different
>>> day :)
>>>
>>>
>>> I really preferred using the sysfs toggles (as discussed with Hugh in
>>> the meeting back then), but I can also understand why we at least want
>>> to try making tmpfs behave more like other file systems. But I'm a bit
>>> more careful to not ignore the cases where it really isn't like any
>>> other file system.
>>
>> That's also my previous thought, but Matthew is strongly against that.
>> Let's step by step.
> 
> Yes, I understand his view as well.
> 
> But I won't blindly agree to the "tmpfs is just like any other file 
> system" opinion :)
> 
>  > >> If we start making PMD-sized THPs special in any non-configurable 
> way,
>>> then we are effectively off *worse* than allowing to configure them
>>> properly. So if someone voices "but we want only PMD-sized" ones, the
>>> next one will say "but we only want cont-pte sized-ones" and then we
>>> should provide an option to control the actual sizes to use differently,
>>> in some way. But let's see if that is even required.
>>
>> Yes, I agree. So what I am thinking is, the 'huge=' option should be
>> gradually deprecated in the future and eventually tmpfs can allocate any
>> size large folios as default.
> 
> Let's be realistic, it won't get removed any time soon. ;)
> 
> So changing "huge=always" etc. semantics to reflect our new size 
> options, and then try changing the default (with the option for 
> people/distros to have the old default) is a reasonable approach, at 
> least to me.
> 
> I'm trying to stay open-minded here, but the proposal I heard so far is 
> not particularly appealing.
> 

