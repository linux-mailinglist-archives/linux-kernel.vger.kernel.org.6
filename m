Return-Path: <linux-kernel+bounces-401386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 409779C198F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F6F1F241BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4411E1C14;
	Fri,  8 Nov 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvPBNWxm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2BD1E1055
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059741; cv=none; b=fQb1GzRf1bVJN6BrKRD+nN/MxxX3DvbhVJCVi0fldeBuAlQLimsp4C9sDOCZUHiuqMIESMlXMqszjbZm1lMQys78PrW6HyW5T+PcxfdWsom9qUQNyFJoamTzOo7dlMoS2RpXxrVaLRjkjzKs+90bEGEmRKHCLsNqdzA99FlNz7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059741; c=relaxed/simple;
	bh=ISsfMjr9UFjlL720g04ze5F1li+MTPBtBeoJz+4wwn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttDJMprFfLqnOrRjw5qHvUi0nBmMHtOQLL5QLoPn1m8FV7jXVI/uwA33l1CHikNLEHSWoH2MqwYh6asAI1wj+Nzlg2VD7ytVuLzmuE18xkQbI/ify0xgqDkQVQU7WhDTP6Xm+NRar/+9I8Yj2YnGC8mz3KpyRjW36ckuFkIsN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvPBNWxm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731059737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/ShAaFkNM64cfrAb6HFzJnDhmUIANJ/RZjqK2C1xQO8=;
	b=UvPBNWxm1st6nx/hVxct2bluSAkbGQQU/Pch2acGvy2dWAropJucYCUS+5iISKmvOqp2e+
	vzWZONibCb6uhKAWmNqro4nuiZigeSo7pZizBJuzKkxGFqs7wmztNweZbCZ6HVhsVho+un
	i98WK25jNw1/K2/flW6ZCDxAIPLSrG4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-xS8Q3kwDOle1ZG7yGfnsGQ-1; Fri, 08 Nov 2024 04:55:35 -0500
X-MC-Unique: xS8Q3kwDOle1ZG7yGfnsGQ-1
X-Mimecast-MFC-AGG-ID: xS8Q3kwDOle1ZG7yGfnsGQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-431ad45828aso13143325e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731059734; x=1731664534;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ShAaFkNM64cfrAb6HFzJnDhmUIANJ/RZjqK2C1xQO8=;
        b=Ghyb+iz7XLGn24N/aYZHpuWBpUBDug16domJqUzK7vNaO1ElOr8wvoMFHU3czjW+c4
         eEXJmm3CzRho+exroIRZcMKAWuGM10ZfjazD/tI6woXLfZYC5/2D5/6g4jeDp2N5YyLB
         AnORKsuptWvMUAMRN+r2Z9yk4ZiSDL7n6fvEcGiBqb17WRoIT4iKY/RhTKDGfbc+G8EQ
         FvknJRxp6mRwomkz3CDcMYs+bEXoyVLqD9Hp4MDeEC2LjZBL9BMNBBQ/dFSZ7FtTdPpe
         LJoAA5ArXhjjhLZkwOOsbNPxsqHv3nSpP5NwVYZxSMpgBcXgkIhRAy2tdoSU1qEmGrHp
         pkig==
X-Forwarded-Encrypted: i=1; AJvYcCWWOz7ZX5+41YDRQJZfBB5mmTWzC7wtlUP3MqJm2P7JGwbOydFh2y1XozxJ2ZzxZRqrVK68i5rIAjvQFPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytPEEkmHFgKDVs7dp4c4He9cG3itC0ox4MgXYZxKEv8ZwIV4gh
	YTYDEKMOYkPr6eU7rArQUCsfWRFYwXgepuDFE6Kbnwp08/8Pvxj6+HlqdbWT73ozzAVtkdpmkMj
	5HHWF9/dGzKbKqCq2HBsIepZWQav60hS6dKFQe2NysnQKr5yF8Sd2/gvIeszfPA==
X-Received: by 2002:a5d:6d8f:0:b0:37d:4ebe:1644 with SMTP id ffacd0b85a97d-381f18854dcmr1772563f8f.43.1731059734210;
        Fri, 08 Nov 2024 01:55:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkJhqZzrg3UKGSvxLjDvIaMQNyAolKmadfv2qpgrWgeUuIJ0ILkTX2A3yMo4NyhnUjRWt9xw==
X-Received: by 2002:a5d:6d8f:0:b0:37d:4ebe:1644 with SMTP id ffacd0b85a97d-381f18854dcmr1772541f8f.43.1731059733662;
        Fri, 08 Nov 2024 01:55:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:b600:4a55:861a:f768:72a8? (p200300cbc70fb6004a55861af76872a8.dip0.t-ipconnect.de. [2003:cb:c70f:b600:4a55:861a:f768:72a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97e4d2sm4124487f8f.32.2024.11.08.01.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 01:55:32 -0800 (PST)
Message-ID: <412298ff-80bc-4111-8c72-29a5263a5d32@redhat.com>
Date: Fri, 8 Nov 2024 10:55:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix __wp_page_copy_user fallback path for remote mm
To: Asahi Lina <lina@asahilina.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Sergio Lopez Pascual <slp@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 Alistair Popple <apopple@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
References: <20241101-mm-remote-pfn-v1-1-080b609270b7@asahilina.net>
 <c00226ea-6e29-4432-a1c4-a25e9e05df9c@redhat.com>
 <2d8380b9-3d03-4263-b5bf-7e0227c83ba9@asahilina.net>
 <0977a33b-8318-43a5-a5a1-4eb8c93ca270@redhat.com>
 <64d386e8-6684-4213-8aba-7d1daf94f2cf@asahilina.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <64d386e8-6684-4213-8aba-7d1daf94f2cf@asahilina.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.11.24 18:32, Asahi Lina wrote:
> On 11/8/24 2:14 AM, David Hildenbrand wrote:
>> On 07.11.24 17:43, Asahi Lina wrote:
>>> On 11/5/24 9:03 PM, David Hildenbrand wrote:
>>>> On 01.11.24 13:08, Asahi Lina wrote:
>>>>> If the source page is a PFN mapping, we copy back from userspace.
>>>>> However, if this fault is a remote access, we cannot use
>>>>> __copy_from_user_inatomic. Instead, use access_remote_vm() in this
>>>>> case.
>>>>>
>>>>> Fixes WARN and incorrect zero-filling when writing to CoW mappings in
>>>>> a remote process, such as when using gdb on a binary present on a DAX
>>>>> filesystem.
>>>>>
>>>>> [  143.683782] ------------[ cut here ]------------
>>>>> [  143.683784] WARNING: CPU: 1 PID: 350 at mm/memory.c:2904
>>>>> __wp_page_copy_user+0x120/0x2bc
>>>>> [  143.683793] CPU: 1 PID: 350 Comm: gdb Not tainted 6.6.52 #1
>>>>> [  143.683794] Hardware name: linux,dummy-virt (DT)
>>>>> [  143.683795] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS
>>>>> BTYPE=--)
>>>>> [  143.683796] pc : __wp_page_copy_user+0x120/0x2bc
>>>>> [  143.683798] lr : __wp_page_copy_user+0x254/0x2bc
>>>>> [  143.683799] sp : ffff80008272b8b0
>>>>> [  143.683799] x29: ffff80008272b8b0 x28: 0000000000000000 x27:
>>>>> ffff000083bad580
>>>>> [  143.683801] x26: 0000000000000000 x25: 0000fffff7fd5000 x24:
>>>>> ffff000081db04c0
>>>>> [  143.683802] x23: ffff00014f24b000 x22: fffffc00053c92c0 x21:
>>>>> ffff000083502150
>>>>> [  143.683803] x20: 0000fffff7fd5000 x19: ffff80008272b9d0 x18:
>>>>> 0000000000000000
>>>>> [  143.683804] x17: ffff000081db0500 x16: ffff800080fe52a0 x15:
>>>>> 0000fffff7fd5000
>>>>> [  143.683804] x14: 0000000000bb1845 x13: 0000000000000080 x12:
>>>>> ffff80008272b880
>>>>> [  143.683805] x11: ffff000081d13600 x10: ffff000081d13608 x9 :
>>>>> ffff000081d1360c
>>>>> [  143.683806] x8 : ffff000083a16f00 x7 : 0000000000000010 x6 :
>>>>> ffff00014f24b000
>>>>> [  143.683807] x5 : ffff00014f24c000 x4 : 0000000000000000 x3 :
>>>>> ffff000083582000
>>>>> [  143.683807] x2 : 0000000000000f80 x1 : 0000fffff7fd5000 x0 :
>>>>> 0000000000001000
>>>>> [  143.683808] Call trace:
>>>>> [  143.683809]  __wp_page_copy_user+0x120/0x2bc
>>>>> [  143.683810]  wp_page_copy+0x98/0x5c0
>>>>> [  143.683813]  do_wp_page+0x250/0x530
>>>>> [  143.683814]  __handle_mm_fault+0x278/0x284
>>>>> [  143.683817]  handle_mm_fault+0x64/0x1e8
>>>>> [  143.683819]  faultin_page+0x5c/0x110
>>>>> [  143.683820]  __get_user_pages+0xc8/0x2f4
>>>>> [  143.683821]  get_user_pages_remote+0xac/0x30c
>>>>> [  143.683823]  __access_remote_vm+0xb4/0x368
>>>>> [  143.683824]  access_remote_vm+0x10/0x1c
>>>>> [  143.683826]  mem_rw.isra.0+0xc4/0x218
>>>>> [  143.683831]  mem_write+0x18/0x24
>>>>> [  143.683831]  vfs_write+0xa0/0x37c
>>>>> [  143.683834]  ksys_pwrite64+0x7c/0xc0
>>>>> [  143.683834]  __arm64_sys_pwrite64+0x20/0x2c
>>>>> [  143.683835]  invoke_syscall+0x48/0x10c
>>>>> [  143.683837]  el0_svc_common.constprop.0+0x40/0xe0
>>>>> [  143.683839]  do_el0_svc+0x1c/0x28
>>>>> [  143.683841]  el0_svc+0x3c/0xdc
>>>>> [  143.683846]  el0t_64_sync_handler+0x120/0x12c
>>>>> [  143.683848]  el0t_64_sync+0x194/0x198
>>>>> [  143.683849] ---[ end trace 0000000000000000 ]---
>>>>>
>>>>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>>>>> ---
>>>>>     mm/memory.c | 7 ++++++-
>>>>>     1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index
>>>>> 3ccee51adfbbd007b24331fe6874265f231a877b..dba25d9734063ac02cdaeb0a5cd5432473f6372e 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -3081,13 +3081,18 @@ static inline int __wp_page_copy_user(struct
>>>>> page *dst, struct page *src,
>>>>>                 update_mmu_cache_range(vmf, vma, addr, vmf->pte, 1);
>>>>>         }
>>>>>     +    /* If the mm is a remote mm, copy in the page using
>>>>> access_remote_vm() */
>>>>> +    if (current->mm != mm) {
>>>>> +        if (access_remote_vm(mm, (unsigned long)uaddr, kaddr,
>>>>> PAGE_SIZE, 0) != PAGE_SIZE)
>>>>
>>>> access_remote_vm() will do a mmap_read_lock_killable() and then call
>>>> into get_user_page_vma_remote() -- fortunately read-access, otherwise
>>>> we'd be in trouble :) .
>>>>
>>>> So we should already be holding the mmap read lock from the previous
>>>> access_remote_vm() users (who we end up here) ... doesn't this complain
>>>> with lockdep about recursive locking?
>>>>
>>>> I keep forgetting locking rules, so I might just be wrong.
>>>
>>> You're right, this complains with lockdep:
>>>
>>> [   23.154031]
>>> [   23.154093] ============================================
>>> [   23.154193] WARNING: possible recursive locking detected
>>> [   23.154229] 6.6.52 #2 Not tainted
>>> [   23.154270] --------------------------------------------
>>> [   23.154306] gdb/349 is trying to acquire lock:
>>> [   23.154343] ffff0000862e3450 (&mm->mmap_lock){++++}-{3:3}, at:
>>> __access_remote_vm+0x3c/0x3a8
>>> [   23.154431]
>>> [   23.154431] but task is already holding lock:
>>> [   23.154474] ffff0000862e3450 (&mm->mmap_lock){++++}-{3:3}, at:
>>> __access_remote_vm+0x3c/0x3a8
>>> [   23.154553]
>>> [   23.154553] other info that might help us debug this:
>>> [   23.154598]  Possible unsafe locking scenario:
>>> [   23.154598]
>>> [   23.154641]        CPU0
>>> [   23.154665]        ----
>>> [   23.154685]   lock(&mm->mmap_lock);
>>> [   23.154712]   lock(&mm->mmap_lock);
>>> [   23.154741]
>>> [   23.154741]  *** DEADLOCK ***
>>> [   23.154741]
>>> [   23.154790]  May be due to missing lock nesting notation
>>> [   23.154790]
>>> [   23.154838] 2 locks held by gdb/349:
>>> [   23.154868]  #0: ffff0000835b53f8 (sb_writers#4){.+.+}-{0:0}, at:
>>> vfs_write+0x84/0x2e0
>>> [   23.154945]  #1: ffff0000862e3450 (&mm->mmap_lock){++++}-{3:3}, at:
>>> __access_remote_vm+0x3c/0x3a8
>>> [   23.155023]
>>> [   23.155023] stack backtrace:
>>> [   23.155060] CPU: 5 PID: 349 Comm: gdb Not tainted 6.6.52 #2
>>> [   23.155112] Hardware name: linux,dummy-virt (DT)
>>> [   23.155148] Call trace:
>>> [   23.155167]  dump_backtrace+0x98/0x118
>>> [   23.155209]  show_stack+0x18/0x24
>>> [   23.155240]  dump_stack_lvl+0x60/0xac
>>> [   23.155292]  dump_stack+0x18/0x24
>>> [   23.155320]  print_deadlock_bug+0x260/0x34c
>>> [   23.155364]  validate_chain+0x364/0x4c0
>>> [   23.155393]  __lock_acquire+0x564/0xb64
>>> [   23.155420]  lock_acquire.part.0+0x9c/0x1bc
>>> [   23.155448]  lock_acquire+0x9c/0x140
>>> [   23.155477]  down_read_killable+0x44/0x158
>>> [   23.155521]  __access_remote_vm+0x3c/0x3a8
>>> [   23.155562]  __wp_page_copy_user+0x13c/0x3a8
>>> [   23.155611]  wp_page_copy+0x98/0x4d8
>>> [   23.155640]  do_wp_page+0x290/0x594
>>> [   23.155671]  __handle_mm_fault+0x258/0x25c
>>> [   23.155712]  handle_mm_fault+0x64/0x1f0
>>> [   23.155755]  faultin_page+0x64/0x138
>>> [   23.155798]  __get_user_pages+0x11c/0x340
>>> [   23.155843]  get_user_pages_remote+0xc4/0x404
>>> [   23.155895]  __access_remote_vm+0xf4/0x3a8
>>> [   23.155922]  access_remote_vm+0x10/0x1c
>>> [   23.155952]  mem_rw.isra.0+0xc4/0x218
>>> [   23.155996]  mem_write+0x18/0x24
>>> [   23.156023]  vfs_write+0xa4/0x2e0
>>> [   23.156066]  ksys_pwrite64+0x7c/0xc0
>>> [   23.156109]  __arm64_sys_pwrite64+0x20/0x2c
>>> [   23.156152]  invoke_syscall+0x48/0x10c
>>> [   23.156196]  el0_svc_common.constprop.0+0x40/0xe0
>>> [   23.156249]  do_el0_svc+0x1c/0x28
>>> [   23.156293]  el0_svc+0x54/0x140
>>> [   23.156334]  el0t_64_sync_handler+0x120/0x12c
>>> [   23.156384]  el0t_64_sync+0x194/0x198
>>>
>>> I guess the locking implementation is recursive so that's why this
>>> didn't actually deadlock...
>>>
>>> I'm not sure what the right way to do this is then. The underlying
>>> reason why the fallback code is being called is that do_wp_page() calls
>>> vm_normal_page(), which returns NULL for VM_PFNMAP pages. So vmf->page
>>> is NULL and __wp_page_copy_user has to use the fallback path. However,
>>> the reason GUP works is that follow_page_pte() and friends have a
>>> specific fallback path for the pte_devmap() case that grabs a struct
>>> page anyway. Maybe similar logic should be in do_wp_page() so it can
>>> grab a struct page for PFN mappings too?
>>
>> There is currently WIP to remove pte_devmap() and make vm_normal_page()
>> return these pages as well.
>>
>> But that would not be in VM_PFNMAP mappings, because VM_PFNMAP means
>> "don't you ever look at the struct page".
>>
>> Likely, you do not have a VM_PFNMAP mapping here but instead a
>> VM_MIXEDMAP mapping(or likely no special mapping at all)?
>>
>> vm_normal_page() returns NULL for pte_devmap(), independent of
>> VM_PFNMAP, because pte_special() should succeed on them.
>>
>>
>>
>> I recall that there is still a problem with false-positives on
>> folio_test_anon() with ZONE_DEVICE pages, so it's maybe not that
>> easy ... and the whole get_dev_pagemap() stuff is nasty.
>>
>> Likely we would have to do what GUP does, and temporarily grab a pgmap
>> reference. Gah.
>>
>>
>> So if we sort out the pagemap stuff and the possibly wrong
>> folio_test_anon() on some ZONE_DEVICE pages (but not all, because IIRC
>> DEVICE_PRIVATE can be anon ...), it might be doable.
>>
>> But it sounds ugly, especially because that code might change soon and
>> not require messing with ZONE_DEVICE pages on that level.
>>
>> And then, we'd not be able to handle VM_PFNMAP cleanly ...
>>
>>
>> Maybe we could test if the PFN has a directmap and simply read using
>> that? I mean, that's what kmap_local_page() ends up doing on systems
>> without highmem ... and without !defined(HASHED_PAGE_VIRTUAL) && !
>> defined(WANT_PAGE_VIRTUAL) the kmap_local_page() really just is a
>> page_to_virt(), which is mostly mapping a PFN to the corresponding
>> virtual address ...
>>
>> But it doesn't universally work ...
>>
>>>
>>> Or if the problem is just the lock, would just eliding the locking work?
>>> I guess that only works if all the calls into wp_page_copy() are
>>> guaranteed to hold the mmap lock already, but I don't know if that is
>>> true...
>>
>> The whole "GUP recursively calling into GUP" code looks concerning.
>> Could we even trigger a case where we get a recursive page fault handler
>> call, because of some odd race? (concurrent MADV_DONTNEED or similar)
>>
>> I think we should much rather fail this remote fault if there is no easy
>> way to make it work right now.
>>
>> At least I suspect this is primarily a "debugger" scenario that didn't
>> work so far and we could leave it "not working because not supported" in
>> a nicer way?
>>
>>
>> If this really must succeed, I can spend some time thinking about how to
>> do this cleaner ...
> 
> Well, this breaks debuggers in general on a virtiofs VM mounted with
> DAX, which is a sensible use case I think. One reason to use DAX is
> avoiding duplication of the page cache between the host and the guest
> (or multiple guests).
> 
> I think the main reason not that many people are trying DAX across the
> board for virtiofs is various bugs that have been slowly fixed, and this
> would be one of the remaining ones...
> 
> (Full disclosure: For the use case I'm working on we're no longer
> mounting the whole rootfs with DAX right now (only a subset) since we're
> still evaluating the performance, but I'd like to keep the option open
> and having it break debuggers is kind of a blocker...)

Thanks for the information. So it never worked and we primarily care about
virtio-fs DAX support, not some VM_PFNMAP mappings or other DAX mappings.


We should first fix the warning using something like:

 From 1ca7e9cf8067112ccaeb3c67230093d3aef8f2a3 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 8 Nov 2024 10:34:01 +0100
Subject: [PATCH] mm/memory: silence warning in __wp_page_copy_user() on remote
  faults without a src page

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/memory.c | 36 ++++++++++++++++--------------------
  1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 209885a4134f7..720b20f71ba61 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3038,28 +3038,29 @@ static inline int pte_unmap_same(struct vm_fault *vmf)
  	return same;
  }
  
-/*
- * Return:
- *	0:		copied succeeded
- *	-EHWPOISON:	copy failed due to hwpoison in source page
- *	-EAGAIN:	copied failed (some other reason)
- */
-static inline int __wp_page_copy_user(struct page *dst, struct page *src,
-				      struct vm_fault *vmf)
+static inline vm_fault_t __wp_page_copy_user(struct page *dst, struct page *src,
+		struct vm_fault *vmf)
  {
-	int ret;
  	void *kaddr;
  	void __user *uaddr;
  	struct vm_area_struct *vma = vmf->vma;
  	struct mm_struct *mm = vma->vm_mm;
  	unsigned long addr = vmf->address;
+	vm_fault_t ret = 0;
  
  	if (likely(src)) {
  		if (copy_mc_user_highpage(dst, src, addr, vma))
-			return -EHWPOISON;
+			return VM_FAULT_HWPOISON;
  		return 0;
  	}
  
+	/*
+	 * We cannot copy from user, so remote faults without a page are not
+	 * supported for now.
+	 */
+	if (mm != current->mm)
+		return VM_FAULT_SIGSEGV;
+
  	/*
  	 * If the source page was a PFN mapping, we don't have
  	 * a "struct page" for it. We do a best-effort copy by
@@ -3086,7 +3087,7 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
  			 */
  			if (vmf->pte)
  				update_mmu_tlb(vma, addr, vmf->pte);
-			ret = -EAGAIN;
+			ret = VM_FAULT_RETRY;
  			goto pte_unlock;
  		}
  
@@ -3111,7 +3112,7 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
  			/* The PTE changed under us, update local tlb */
  			if (vmf->pte)
  				update_mmu_tlb(vma, addr, vmf->pte);
-			ret = -EAGAIN;
+			ret = VM_FAULT_RETRY;
  			goto pte_unlock;
  		}
  
@@ -3130,8 +3131,6 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
  		}
  	}
  
-	ret = 0;
-
  pte_unlock:
  	if (vmf->pte)
  		pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -3369,23 +3368,20 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
  		goto oom;
  
  	if (!pfn_is_zero) {
-		int err;
-
-		err = __wp_page_copy_user(&new_folio->page, vmf->page, vmf);
-		if (err) {
+		ret = __wp_page_copy_user(&new_folio->page, vmf->page, vmf);
+		if (unlikely(ret)) {
  			/*
  			 * COW failed, if the fault was solved by other,
  			 * it's fine. If not, userspace would re-fault on
  			 * the same address and we will handle the fault
  			 * from the second attempt.
-			 * The -EHWPOISON case will not be retried.
  			 */
  			folio_put(new_folio);
  			if (old_folio)
  				folio_put(old_folio);
  
  			delayacct_wpcopy_end();
-			return err == -EHWPOISON ? VM_FAULT_HWPOISON : 0;
+			return ret == VM_FAULT_RETRY ? 0 : ret;
  		}
  		kmsan_copy_page_meta(&new_folio->page, vmf->page);
  	}
-- 
2.47.0



For MEMORY_DEVICE_FS_DAX, we should probably wait for [1], CCing Alistair and Dan.

As discussed, maybe the following would work (as long as we don't get any
folio_test_anon() false-positives on these MEMORY_DEVICE_FS_DAX), but I'm
not quite happy about leaking these legacy MEMORY_DEVICE_FS_DAX into the
core code, especially as it might soon no longer be necessary.


 From e84309bfa4772485b2340712d7b53a8a7ba1b0fc Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 8 Nov 2024 10:50:42 +0100
Subject: [PATCH] mm/memory: support legacy MEMORY_DEVICE_FS_DAX in
  do_wp_page()

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/memory.c | 28 +++++++++++++++++++++-------
  1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 720b20f71ba61..b3830aba08c53 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3667,7 +3667,9 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
  {
  	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
  	struct vm_area_struct *vma = vmf->vma;
+	struct dev_pagemap *pgmap = NULL;
  	struct folio *folio = NULL;
+	vm_fault_t ret = 0;
  	pte_t pte;
  
  	if (likely(!unshare)) {
@@ -3702,9 +3704,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
  	}
  
  	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
-
-	if (vmf->page)
+	if (likely(vmf->page)) {
  		folio = page_folio(vmf->page);
+	} else if (pte_devmap(vmf->orig_pte)) {
+		pgmap = get_dev_pagemap(pte_pfn(pte), NULL);
+		if (pgmap) {
+			vmf->page = pte_page(pte);
+			folio = page_folio(vmf->page);
+		}
+	}
  
  	/*
  	 * Shared mapping: we are guaranteed to have VM_WRITE and
@@ -3719,8 +3727,10 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
  		 * Just mark the pages writable and/or call ops->pfn_mkwrite.
  		 */
  		if (!vmf->page)
-			return wp_pfn_shared(vmf);
-		return wp_page_shared(vmf, folio);
+			ret = wp_pfn_shared(vmf);
+		else
+			ret = wp_page_shared(vmf, folio);
+		goto out_pgmap;
  	}
  
  	/*
@@ -3736,10 +3746,10 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
  			SetPageAnonExclusive(vmf->page);
  		if (unlikely(unshare)) {
  			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			return 0;
+			goto out_pgmap;
  		}
  		wp_page_reuse(vmf, folio);
-		return 0;
+		goto out_pgmap;
  	}
  	/*
  	 * Ok, we need to copy. Oh, well..
@@ -3752,7 +3762,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
  	if (folio && folio_test_ksm(folio))
  		count_vm_event(COW_KSM);
  #endif
-	return wp_page_copy(vmf);
+	ret = wp_page_copy(vmf);
+out_pgmap:
+	if (unlikely(pgmap))
+		put_dev_pagemap(pgmap);
+	return ret;
  }
  
  static void unmap_mapping_range_vma(struct vm_area_struct *vma,
-- 
2.47.0



[1] https://lkml.kernel.org/r/cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com

-- 
Cheers,

David / dhildenb


