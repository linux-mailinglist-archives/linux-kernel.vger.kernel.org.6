Return-Path: <linux-kernel+bounces-255988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7233E934770
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF641F22A42
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75FF42058;
	Thu, 18 Jul 2024 05:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geITYA5b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD7639
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279723; cv=none; b=gt7XtSDGCizD4sjN7CJN0TgxkY3Vr8Pzhfezl06KGjHBMgjloBXFx3q3UHCceFYvK4LFYjmepN5F7Qxxx/YLjmvB++9wBka8WrCjvhhi4S94ty/9iuMXkprDDT2rk/kYVcKtnhbkrJKrXsDWfzv35aW76IAFlU4nfCsw81Pq3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279723; c=relaxed/simple;
	bh=L8R/3l9yexu6DQaBpf8oCX4Qo/jjv59pY7eU81mFU2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuLSJuSYlPx1QAINs3mN1G1y73wwfEKs/z235RWQAftOclRLQSPHGDHB2G4oL9Spum2E+1CI49u4xFe6NbssRNE0BiKBdo87To2F5Y/YYetqVd7P6tKiopB8LUo5N3o0BSx68R/WQdisN3An8UPC5Nbd92oFxBpnzN3Jg8fLNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=geITYA5b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721279720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z8BV6glPyzBnvyrYTqzm1cIHFq/JFvhDH2reEEqEVj0=;
	b=geITYA5bkoMQkUYPaBDBJYNdFrgw9l0LgG9W2MrvL7+VYlL1XGEg8vFZdSyQ/FWLtwq0Vt
	WwXbLtJrNYbzcNP6t8FPaxvG8KTOWyBrwnUai0kkU1WNLSiTsZMi2Q8SrjtyifwZU2FW5x
	PBSxiOlHBVAYaBnht25cpMYHp+S1/vE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-JZUhgt2wMMSH2yDXugGYYA-1; Thu, 18 Jul 2024 01:15:19 -0400
X-MC-Unique: JZUhgt2wMMSH2yDXugGYYA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4266d0183feso2986145e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721279718; x=1721884518;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z8BV6glPyzBnvyrYTqzm1cIHFq/JFvhDH2reEEqEVj0=;
        b=PtobeWoxOZm0kxSVBv3cVn37YIyQwJfR+o0R7PVwdPlcd8hyVJzwy0DsfGGKET5NT2
         0FVJbJN1M61z69vXRLlsAIRk7p6Dl3HRUqRswkkR6E1EzbuEV3VEU0bthuSiBCP45yJK
         KflS511Q/WDKeswnWI8dqtzddcVAqOXOvyMsW4dMbreCQ1JBjZS54CV8/VBvCQM3twQm
         diEMfJtAiLzEMzPWqSTS+ytz70PD238QZc1axk8cy/Jv/ySuwuydjfadMtQZcx8g+SgV
         Qcgl+jlgnijQ8e9kEFpvuzDrv5CdFWaydX5jUVrodyIhxA8XocGXO0UjLT7DL/x67k+7
         Jv5A==
X-Forwarded-Encrypted: i=1; AJvYcCXWz0Tk8yaHnuQkfSU5Os7k5b+i0AVPwo0zRpvFj3nI3O/lu3GHZId0oFE7LDElvGiTc5nXB7fIZyNfDBmhgGvY7rJkgT340jL96Mbb
X-Gm-Message-State: AOJu0Yxbz0jsDzgNDs3D7soJwZrzO03NElJLxDy4gKvLHa3V59aZU+DY
	NjFdRRXtjPD14fr93RLxnqLFDBZk4V9YsZ0O2/odRd1m/EKtrxf0j3beOto5RJfnr6MOn4tn93M
	JmPptP3tSL63pBQwgAsTQE4xf8fov4z/vQXNZ0OohxUFQBFh2aZM7AJtI7HpwwA==
X-Received: by 2002:a05:600c:c12:b0:426:6ea0:d5b8 with SMTP id 5b1f17b1804b1-427c2cefebemr26324975e9.29.1721279717795;
        Wed, 17 Jul 2024 22:15:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBO9ppEohATWkgzmpXQeObSYcFU4YgmYBGGw3g6ekUjgOYzOjeQpVZnzouUadlSmlMNCVcuA==
X-Received: by 2002:a05:600c:c12:b0:426:6ea0:d5b8 with SMTP id 5b1f17b1804b1-427c2cefebemr26324885e9.29.1721279717329;
        Wed, 17 Jul 2024 22:15:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:5600:ce68:1c28:4ec7:6e23? (p200300cbc71e5600ce681c284ec76e23.dip0.t-ipconnect.de. [2003:cb:c71e:5600:ce68:1c28:4ec7:6e23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7840aa2sm20478255e9.37.2024.07.17.22.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 22:15:16 -0700 (PDT)
Message-ID: <dded1b96-8ff3-489a-a92e-b206829feb85@redhat.com>
Date: Thu, 18 Jul 2024 07:15:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page))
 when unpoison memory
To: Miaohe Lin <linmiaohe@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: nao.horiguchi@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240712064249.3882707-1-linmiaohe@huawei.com>
 <20240712140921.9aa90b18d22e67417d59dfc1@linux-foundation.org>
 <8fe349f9-d3d3-65ab-6045-da0bd19249ea@huawei.com>
 <00e18339-d911-4332-8732-e31bcecbf823@redhat.com>
 <5f8107e2-2b37-d899-f7f2-5a6093d8b089@huawei.com>
 <de73f251-08a0-4122-acfd-1d7fce7540ea@redhat.com>
 <ec6ed1aa-0b6e-df66-1442-93786eabd1ef@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ec6ed1aa-0b6e-df66-1442-93786eabd1ef@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.07.24 05:04, Miaohe Lin wrote:
> On 2024/7/17 17:01, David Hildenbrand wrote:
>> On 16.07.24 04:34, Miaohe Lin wrote:
>>> On 2024/7/16 0:16, David Hildenbrand wrote:
>>>> On 15.07.24 08:23, Miaohe Lin wrote:
>>>>> On 2024/7/13 5:09, Andrew Morton wrote:
>>>>>> On Fri, 12 Jul 2024 14:42:49 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>>>
>>>>>>> When I did memory failure tests recently, below panic occurs:
>>>>>>>
>>>>>>> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(page))
>>>>>>> kernel BUG at include/linux/page-flags.h:616!
>>>>>>> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>>>>>> CPU: 3 PID: 720 Comm: bash Not tainted 6.10.0-rc1-00195-g148743902568 #40
>>>>>>> RIP: 0010:unpoison_memory+0x2f3/0x590
>>>>>>> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
>>>>>>> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
>>>>>>> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
>>>>>>> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
>>>>>>> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
>>>>>>> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
>>>>>>> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
>>>>>>> Call Trace:
>>>>>>>     <TASK>
>>>>>>>     unpoison_memory+0x2f3/0x590
>>>>>>>     simple_attr_write_xsigned.constprop.0.isra.0+0xb3/0x110
>>>>>>>     debugfs_attr_write+0x42/0x60
>>>>>>>     full_proxy_write+0x5b/0x80
>>>>>>>     vfs_write+0xd5/0x540
>>>>>>>     ksys_write+0x64/0xe0
>>>>>>>     do_syscall_64+0xb9/0x1d0
>>>>>>>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>>>> RIP: 0033:0x7f08f0314887
>>>>>>> RSP: 002b:00007ffece710078 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>>>>>> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f08f0314887
>>>>>>> RDX: 0000000000000009 RSI: 0000564787a30410 RDI: 0000000000000001
>>>>>>> RBP: 0000564787a30410 R08: 000000000000fefe R09: 000000007fffffff
>>>>>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
>>>>>>> R13: 00007f08f041b780 R14: 00007f08f0417600 R15: 00007f08f0416a00
>>>>>>>     </TASK>
>>>>>>> Modules linked in: hwpoison_inject
>>>>>>> ---[ end trace 0000000000000000 ]---
>>>>>>> RIP: 0010:unpoison_memory+0x2f3/0x590
>>>>>>> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
>>>>>>> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
>>>>>>> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
>>>>>>> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
>>>>>>> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
>>>>>>> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
>>>>>>> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
>>>>>>> Kernel panic - not syncing: Fatal exception
>>>>>>> Kernel Offset: 0x31c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>>>>>> ---[ end Kernel panic - not syncing: Fatal exception ]---
>>>>>>>
>>>>>>> The root cause is that unpoison_memory() tries to check the PG_HWPoison
>>>>>>> flags of an uninitialized page. So VM_BUG_ON_PAGE(PagePoisoned(page)) is
>>>>>>> triggered.
>>>>>>
>>>>>> I'm not seeing the call path.  Is this BUG happening via
>>>>>>
>>>>>> static __always_inline void __ClearPage##uname(struct page *page)    \
>>>>>> {                                    \
>>>>>>       VM_BUG_ON_PAGE(!Page##uname(page), page);            \
>>>>>>       page->page_type |= PG_##lname;                    \
>>>>>> }
>>>>>>
>>>>>> ?
>>>>>>
>>>>>> If so, where's the callsite?
>>>>>
>>>>> It is BUG on PF_ANY():
>>>>>
>>>>> PAGEFLAG(HWPoison, hwpoison, PF_ANY)
>>>>>
>>>>> #define PF_ANY(page, enforce)    PF_POISONED_CHECK(page)
>>>>>
>>>>> #define PF_POISONED_CHECK(page) ({                    \
>>>>>       VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);        \
>>>>>       page; })
>>>>>
>>>>> #define    PAGE_POISON_PATTERN    -1l
>>>>> static inline int PagePoisoned(const struct page *page)
>>>>> {
>>>>>       return READ_ONCE(page->flags) == PAGE_POISON_PATTERN;
>>>>> }
>>>>>
>>>>> The offlined pages will have page->flags set to PAGE_POISON_PATTERN while pfn is still valid:
>>>>>
>>>>> offline_pages
>>>>>      remove_pfn_range_from_zone
>>>>>        page_init_poison
>>>>>          memset(page, PAGE_POISON_PATTERN, size);
>>>>
>>>> Worth noting that this happens after __offline_isolated_pages() marked the covering sections as offline.
>>>>
>>>> Are we missing a pfn_to_online_page() check somewhere, or are we racing with offlining code that marks the section offline?
>>>
>>> I was thinking about to use pfn_to_online_page() instead of pfn_to_page() in unpoison_memory() so we can get rid of offlined pages.
>>> But there're ZONE_DEVICE pages. They're not-onlined too. And unpoison_memory() should work for them. So we can't simply use
>>> pfn_to_online_page() in that. Or am I miss something?
>>
>> Right, pfn_to_online_page() does not detect ZONE_DEVICE. That has to be handled separately if pfn_to_online_page() would fail.
>>
>> ... which is what we do in memory_failure():
>>
>> p = pfn_to_online_page(pfn);
>> if (!p) {
>>      if (pfn_valid(pfn)) {
>>          pgmap = get_dev_pagemap(pfn, NULL);
>>          put_ref_page(pfn, flags);
>>          if (pgmap) {
>>              ...
>>          }
>>      }
>>      ...
>> }
> 
> Yup, this will be a good alternative. But will it be better to simply check PagePoisoned() instead?

The memmap of offline memory sections shall not be touched, so .... 
don't touch it ;)

Especially because that PagePoisoned() check is non-sensical without 
poisoining-during-memmap-init. You would still work with memory in 
offline sections.

I think the code is even wrong in that regard: we allow for memory 
offlining to work with HWPoisoned pages, see __offline_isolated_pages(). 
Staring at unpoison_memory(), we might be putting these pages back to 
the buddy? Which is completely wrong.


... not to mention that a function called "unpoison_memory()" doing 
nothing when it finds PagePoison() is completely confusing. Last but not 
least, take a look at the number of users of PagePoison().

Likely PagePoison() warrants a cleanup, but I am not sure yet what's the 
right thing to do.

-- 
Cheers,

David / dhildenb


