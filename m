Return-Path: <linux-kernel+bounces-396634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875259BCFD9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FBF28381C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8A01D9A7B;
	Tue,  5 Nov 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3KOnnyI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FFE1D9A69
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818607; cv=none; b=BgiqxuhDqKcf3tuKAQ5dL6DSX39By6QiVsa90gSxFNIbEAgbazkc5VySfeep1YKqoKQoraR6y5HMI/6ZTei5CzW6Ky/3yPbqcoFayTB0VFy+cX2qIKukK1AnPmeU8SdH9vhGKg7GnosFTiJp3k3sXrNTtGTgSj9jYs7/tz84d7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818607; c=relaxed/simple;
	bh=k25PIn9GGH/JkYnFNXcEmQJZdkjy2v+IgpSNZn7nQIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kC7WNeI09zVtax+Z/FtiY7pyOw4Bc37hLYZYWUSGr9XYvwAPCtYQ6zeGcyuXdBq46o7KFBkT8H0+b1KCF5ctWMnRNBghnPZfXFe8/lrQSNL5woxaxvA36MlOYYbG96hthkcxDnjHqqWvCnwjJi26p9quv8U6minW9/fN6MiRH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3KOnnyI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730818604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ygUCRe387Bfh8yvPrglacJBxF8hIhd+9Xh4KzBMbrFA=;
	b=A3KOnnyIdeludiaxkipYUgCGPO8XX283EGkAuFqiJ0gTus19E3wiGsfXHfJwYc4x0NnmzW
	nO1gCPdXTblFT5us5bpiZwdKQ3uqJ/ZsgIa1xqmtJCBZ038kJMpV0hehbaQwNJoVxu5cTG
	pObYuq5Mb1grmf95WM/Mz/0i04jOpgs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-59PQEo5gMGeHO2AMRxUElw-1; Tue, 05 Nov 2024 09:56:43 -0500
X-MC-Unique: 59PQEo5gMGeHO2AMRxUElw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d5116f0a6so2863048f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730818602; x=1731423402;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ygUCRe387Bfh8yvPrglacJBxF8hIhd+9Xh4KzBMbrFA=;
        b=gaF1MQmCDRj4xlELBJHxQusTMAfEsspIuWhee5xcbGcxgkweNIBEnAnQfwQII8EauX
         P6XowFWz6HIRRueGk+CnwOWU6pZcZQv3ikxtuHt5Qg/MRBczHDF3hup12oYpymlnDvS0
         IjOsb11lNL0V1IiYbEwIWU87Xm3pAtrvZ3UJyf1/PbE0UpDRkLAzq5Dgtv1EcRdvUFY1
         ztaQMxMwT1KUWuHOdh0TK+D8qogFMrOcGzS29/R203bdOFyC/Mbvr3L93+Ws0GnoW8Gt
         HrQZGR8l1HXZ2XaKo8IeAL4sh7rHnjfCc4dem32xGxf8oL4dxEq6/tf8WfwtEYVL7BC+
         /9HA==
X-Forwarded-Encrypted: i=1; AJvYcCUBVdRgMZaHjAnNfwiHbXy7Jjly6xH8nriXdLxvR7SYIbut+aGRWZ2UibSvRREoodyGCd47zKT0Vl/PL/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTaQ/31BNo2S5wCyUg9fjTKOi/3yG1AwnRYcMay4ANy0BynKSb
	0MuAcpAGIpf/YvxzbBbZ7KaAl9EDi+qUp+8HwiY4dSACB3K2VPrMEe3qMsb3wACD23S2KwSfQoF
	95OkQuEcvHXwGGjhhyryEWX/3hC36J3DQWDJv0fBr63MAmIMxsKvcB8NrnBEi6w==
X-Received: by 2002:a05:6000:2c8:b0:37c:d1bc:2666 with SMTP id ffacd0b85a97d-381c7a472f7mr15455491f8f.4.1730818601948;
        Tue, 05 Nov 2024 06:56:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1TNbjayvy2/PVTYGwIyqMdeNwMREv46iY/ZwHsgl4PK0utmWah382/qwIU06ROze4xAF+eg==
X-Received: by 2002:a05:6000:2c8:b0:37c:d1bc:2666 with SMTP id ffacd0b85a97d-381c7a472f7mr15455466f8f.4.1730818601445;
        Tue, 05 Nov 2024 06:56:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:db00:b0d7:66ca:e3e9:6528? (p200300cbc73bdb00b0d766cae3e96528.dip0.t-ipconnect.de. [2003:cb:c73b:db00:b0d7:66ca:e3e9:6528])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113dd7fsm16561984f8f.70.2024.11.05.06.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 06:56:40 -0800 (PST)
Message-ID: <01f91147-c66f-4501-bd55-3ff04088e337@redhat.com>
Date: Tue, 5 Nov 2024 15:56:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Daniel Gomez <d@kruces.com>,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8172f4fb-17ce-4df9-a8cf-f2bed0910370@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.11.24 13:45, Baolin Wang wrote:
> 
> 
> On 2024/10/31 18:46, David Hildenbrand wrote:
> [snip]
> 
>>>> I don't like that:
>>>>
>>>> (a) there is no way to explicitly enable/name that new behavior.
>>>
>>> But this is similar to other file systems that enable large folios
>>> (setting mapping_set_large_folios()), and I haven't seen any other file
>>> systems supporting large folios requiring a new Kconfig. Maybe tmpfs is
>>> a bit special?
>>
>> I'm afraid I don't have the energy to explain once more why I think
>> tmpfs is not just like any other file system in some cases.
>>
>> And distributions are rather careful when it comes to something like
>> this ...
>>
>>>
>>> If we all agree that tmpfs is a bit special when using huge pages, then
>>> fine, a Kconfig option might be needed.
>>>
>>>> (b) "always" etc. are only concerned about PMDs.
>>>
>>> Yes, currently maintain the same semantics as before, in case users
>>> still expect THPs.
>>
>> Again, I don't think that is a reasonable approach to make PMD-sized
>> ones special here. It will all get seriously confusing and inconsistent.
> 
> I agree PMD-sized should not be special. This is all for backward
> compatibility with the ‘huge=’ mount option, and adding a new kconfig is
> also for this purpose.
> 
>> THPs are opportunistic after all, and page fault behavior will remain
>> unchanged (PMD-sized) for now. And even if we support other sizes during
>> page faults, we'd like start with the largest size (PMD-size) first, and
>> it likely might just all work better than before.
>>
>> Happy to learn where this really makes a difference.
>>
>> Of course, if you change the default behavior (which you are planning),
>> it's ... a changed default.
>>
>> If there are reasons to have more tunables regarding the sizes to use,
>> then it should not be limited to PMD-size.
> 
> I have tried to modify the code according to your suggestion (not tested
> yet). These are what you had in mind?
> 
> static inline unsigned int
> shmem_mapping_size_order(struct address_space *mapping, pgoff_t index,
> loff_t write_end)
> {
>           unsigned int order;
>           size_t size;
> 
>           if (!mapping_large_folio_support(mapping) || !write_end)
>                   return 0;
> 
>           /* Calculate the write size based on the write_end */
>           size = write_end - (index << PAGE_SHIFT);
>           order = filemap_get_order(size);
>           if (!order)
>                   return 0;
> 
>           /* If we're not aligned, allocate a smaller folio */
>           if (index & ((1UL << order) - 1))
>                   order = __ffs(index);
> 
>           order = min_t(size_t, order, MAX_PAGECACHE_ORDER);
>           return order > 0 ? BIT(order + 1) - 1 : 0;
> }
> 
> static unsigned int shmem_huge_global_enabled(struct inode *inode,
> pgoff_t index,
>                                                 loff_t write_end, bool
> shmem_huge_force,
>                                                 unsigned long vm_flags)
> {
>           bool is_shmem = inode->i_sb == shm_mnt->mnt_sb;
>           unsigned long within_size_orders;
>           unsigned int order;
>           loff_t i_size;
> 
>           if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
>                   return 0;
>           if (!S_ISREG(inode->i_mode))
>                   return 0;
>           if (shmem_huge == SHMEM_HUGE_DENY)
>                   return 0;
>           if (shmem_huge_force || shmem_huge == SHMEM_HUGE_FORCE)
>                   return BIT(HPAGE_PMD_ORDER);
> 
>           switch (SHMEM_SB(inode->i_sb)->huge) {
>           case SHMEM_HUGE_NEVER:
>                   return 0;
>           case SHMEM_HUGE_ALWAYS:
>                   if (is_shmem || IS_ENABLED(CONFIG_USE_ONLY_THP_FOR_TMPFS))
>                           return BIT(HPAGE_PMD_ORDER);
> 
>                   return shmem_mapping_size_order(inode->i_mapping,
> index, write_end);
>           case SHMEM_HUGE_WITHIN_SIZE:
>                   if (is_shmem || IS_ENABLED(CONFIG_USE_ONLY_THP_FOR_TMPFS))
>                           within_size_orders = BIT(HPAGE_PMD_ORDER);
>                   else
>                           within_size_orders =
> shmem_mapping_size_order(inode->i_mapping,
>   
> index, write_end);
> 
>                   order = highest_order(within_size_orders);
>                   while (within_size_orders) {
>                           index = round_up(index + 1, 1 << order);
>                           i_size = max(write_end, i_size_read(inode));
>                           i_size = round_up(i_size, PAGE_SIZE);
>                           if (i_size >> PAGE_SHIFT >= index)
>                                   return within_size_orders;
> 
>                           order = next_order(&within_size_orders, order);
>                   }
>                   fallthrough;
>           case SHMEM_HUGE_ADVISE:
>                   if (vm_flags & VM_HUGEPAGE) {
>                           if (is_shmem || IS_ENABLED(USE_ONLY_THP_FOR_TMPFS))
>                                   return BIT(HPAGE_PMD_ORDER);
> 
>                           return shmem_mapping_size_order(inode->i_mapping,
>                                                           index, write_end);
>                   }
>                   fallthrough;
>           default:
>                   return 0;
>           }
> }
> 
> 1) Add a new 'CONFIG_USE_ONLY_THP_FOR_TMPFS' kconfig to keep ‘huge=’
> mount option compatibility.
> 2) For tmpfs write(), if CONFIG_USE_ONLY_THP_FOR_TMPFS is not enabled,
> then will get the possible huge orders based on the write size.
> 3) For tmpfs mmap() fault, always use PMD-sized huge order.
> 4) For shmem, ignore the write size logic and always use PMD-sized THP
> to check if the global huge is enabled.
> 
> However, in case 2), if 'huge=always' and write size is less than 4K, so
> we will allocate small pages, that will break the 'huge' semantics?
> Maybe it's not something to worry too much about.

Probably I didn't express clearly what I think we should, because this is
not quite what I had in mind.

I would use the CONFIG_USE_ONLY_THP_FOR_TMPFS way of doing it only if
really required. As raised, if someone needs finer control, providing that
only for a single size is rather limiting.



This is what I hope we can do (doc update to show what I mean):

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 5034915f4e8e8..d7d1a9acdbfc5 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -349,11 +349,24 @@ user, the PMD_ORDER hugepage policy will be overridden. If the policy for
  PMD_ORDER is not defined within a valid ``thp_shmem``, its policy will
  default to ``never``.
  
-Hugepages in tmpfs/shmem
-========================
+tmpfs/shmem
+===========
  
-You can control hugepage allocation policy in tmpfs with mount option
-``huge=``. It can have following values:
+Traditionally, tmpfs only supported a single huge page size ("PMD"). Today,
+it also supports smaller sizes just like anonymous memory, often referred
+to as "multi-size THP" (mTHP). Huge pages of any size are commonly
+represented in the kernel as "large folios".
+
+While there is fine control over the huge page sizes to use for the internal
+shmem mount (see below), ordinary tmpfs mounts will make use of all
+available huge page sizes without any control over the exact sizes,
+behaving more like other file systems.
+
+tmpfs mounts
+------------
+
+The THP allocation policy for tmpfs mounts can be adjusted using the mount
+option: ``huge=``. It can have following values:
  
  always
      Attempt to allocate huge pages every time we need a new page;
@@ -368,19 +381,20 @@ within_size
  advise
      Only allocate huge pages if requested with fadvise()/madvise();
  
-The default policy is ``never``.
+Remember, that the kernel may use huge pages of all available sizes, and
+that no fine control as for the internal tmpfs mount is available.
+
+The default policy in the past was ``never``, but it can now be adjusted
+using the CONFIG_TMPFS_TRANSPARENT_HUGEPAGE_ALWAYS,
+CONFIG_TMPFS_TRANSPARENT_HUGEPAGE_NEVER etc.
  
  ``mount -o remount,huge= /mountpoint`` works fine after mount: remounting
  ``huge=never`` will not attempt to break up huge pages at all, just stop more
  from being allocated.
  
-There's also sysfs knob to control hugepage allocation policy for internal
-shmem mount: /sys/kernel/mm/transparent_hugepage/shmem_enabled. The mount
-is used for SysV SHM, memfds, shared anonymous mmaps (of /dev/zero or
-MAP_ANONYMOUS), GPU drivers' DRM objects, Ashmem.
-
-In addition to policies listed above, shmem_enabled allows two further
-values:
+In addition to policies listed above, the sysfs knob
+/sys/kernel/mm/transparent_hugepage/shmem_enabled will affect the
+allocation policy of tmpfs mounts, when set to the following values:
  
  deny
      For use in emergencies, to force the huge option off from
@@ -388,13 +402,26 @@ deny
  force
      Force the huge option on for all - very useful for testing;
  
-Shmem can also use "multi-size THP" (mTHP) by adding a new sysfs knob to
-control mTHP allocation:
-'/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/shmem_enabled',
-and its value for each mTHP is essentially consistent with the global
-setting.  An 'inherit' option is added to ensure compatibility with these
-global settings.  Conversely, the options 'force' and 'deny' are dropped,
-which are rather testing artifacts from the old ages.
+
+shmem / internal tmpfs
+----------------------
+
+The mount internal tmpfs mount is used for SysV SHM, memfds, shared anonymous
+mmaps (of /dev/zero or MAP_ANONYMOUS), GPU drivers' DRM  objects, Ashmem.
+
+To control the THP allocation policy for this internal tmpfs mount, the
+sysfs knob /sys/kernel/mm/transparent_hugepage/shmem_enabled and the knobs
+per THP size in
+'/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/shmem_enabled'
+can be used.
+
+The global knob has the same semantics as the ``huge=`` mount options
+for tmpfs mounts, except that the different huge page sizes can be controlled
+individually, and will only use the setting of the global knob when the
+per-size knob is set to 'inherit'.
+
+The options 'force' and 'deny' are dropped for the individual sizes, which
+are rather testing artifacts from the old ages.
  
  always
      Attempt to allocate <size> huge pages every time we need a new page;
diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 56a26c843dbe9..10de8f706d07b 100644



There is this question of "do we need the old way of doing it and only
allocate PMDs". For that, likely a config similar to the one you propose might
make sense, but I would want to see if there is real demand for that. In particular:
for whom the smaller sizes are a problem when bigger (PMD) sizes were
enabled in the past.

-- 
Cheers,

David / dhildenb


