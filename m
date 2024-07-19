Return-Path: <linux-kernel+bounces-256944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0789372E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 05:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 173EFB218A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 03:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B55B24A08;
	Fri, 19 Jul 2024 03:55:41 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D06DF71
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 03:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721361340; cv=none; b=hI0KBDW2bU/8Wylm3SFhB8E5N2V0WMQF2migIMSfurZ8UiUnZu7oZhWhMcj/+LvKynqE3YcEyn3+LnhhdkE7sE77YtJwb5U5TsQddwsYOtbbebRaNFqENLSklpKmzwzVxbjbz7fenj3m7zvKoc5XjIeuxqjHcGOTy83XsELaUZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721361340; c=relaxed/simple;
	bh=kEj0kEpyv/SZuPTxZGlVX965wvoiV0y9G1NvmC+09LM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=az+/r1iDSRLAyZeajE8wkvO8Uee0CzKpqBO1CpygTLkyy94/tuyzrpBcOIvut0/Vc67mPqd9SWYNhDBfQfLK74bqL7hZMPW9hfq/useWY4879kOW6BUMgGxyk5/vZB/MkvSc+G3VnoHuMwVRKVdNlx8Fg3Jby9OAqiz2BgvTkRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WQG1k6WStzQmDR;
	Fri, 19 Jul 2024 11:51:22 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C47B180087;
	Fri, 19 Jul 2024 11:55:28 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Jul 2024 11:55:27 +0800
Subject: Re: [PATCH] mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page))
 when unpoison memory
To: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240712064249.3882707-1-linmiaohe@huawei.com>
 <20240712140921.9aa90b18d22e67417d59dfc1@linux-foundation.org>
 <8fe349f9-d3d3-65ab-6045-da0bd19249ea@huawei.com>
 <00e18339-d911-4332-8732-e31bcecbf823@redhat.com>
 <5f8107e2-2b37-d899-f7f2-5a6093d8b089@huawei.com>
 <de73f251-08a0-4122-acfd-1d7fce7540ea@redhat.com>
 <ec6ed1aa-0b6e-df66-1442-93786eabd1ef@huawei.com>
 <dded1b96-8ff3-489a-a92e-b206829feb85@redhat.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f3aa7133-5754-73f4-9ee1-bff1a8637c07@huawei.com>
Date: Fri, 19 Jul 2024 11:55:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dded1b96-8ff3-489a-a92e-b206829feb85@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/18 13:15, David Hildenbrand wrote:
> On 18.07.24 05:04, Miaohe Lin wrote:
>> On 2024/7/17 17:01, David Hildenbrand wrote:
>>> On 16.07.24 04:34, Miaohe Lin wrote:
>>>> On 2024/7/16 0:16, David Hildenbrand wrote:
>>>>> On 15.07.24 08:23, Miaohe Lin wrote:
>>>>>> On 2024/7/13 5:09, Andrew Morton wrote:
>>>>>>> On Fri, 12 Jul 2024 14:42:49 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>>>>
>>>>>>>> When I did memory failure tests recently, below panic occurs:
>>>>>>>>
>>>>>>>> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(page))
>>>>>>>> kernel BUG at include/linux/page-flags.h:616!
>>>>>>>> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>>>>>>> CPU: 3 PID: 720 Comm: bash Not tainted 6.10.0-rc1-00195-g148743902568 #40
>>>>>>>> RIP: 0010:unpoison_memory+0x2f3/0x590
>>>>>>>> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
>>>>>>>> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
>>>>>>>> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
>>>>>>>> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
>>>>>>>> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
>>>>>>>> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
>>>>>>>> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
>>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>>> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
>>>>>>>> Call Trace:
>>>>>>>>     <TASK>
>>>>>>>>     unpoison_memory+0x2f3/0x590
>>>>>>>>     simple_attr_write_xsigned.constprop.0.isra.0+0xb3/0x110
>>>>>>>>     debugfs_attr_write+0x42/0x60
>>>>>>>>     full_proxy_write+0x5b/0x80
>>>>>>>>     vfs_write+0xd5/0x540
>>>>>>>>     ksys_write+0x64/0xe0
>>>>>>>>     do_syscall_64+0xb9/0x1d0
>>>>>>>>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>>>>> RIP: 0033:0x7f08f0314887
>>>>>>>> RSP: 002b:00007ffece710078 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>>>>>>> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f08f0314887
>>>>>>>> RDX: 0000000000000009 RSI: 0000564787a30410 RDI: 0000000000000001
>>>>>>>> RBP: 0000564787a30410 R08: 000000000000fefe R09: 000000007fffffff
>>>>>>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
>>>>>>>> R13: 00007f08f041b780 R14: 00007f08f0417600 R15: 00007f08f0416a00
>>>>>>>>     </TASK>
>>>>>>>> Modules linked in: hwpoison_inject
>>>>>>>> ---[ end trace 0000000000000000 ]---
>>>>>>>> RIP: 0010:unpoison_memory+0x2f3/0x590
>>>>>>>> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
>>>>>>>> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
>>>>>>>> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
>>>>>>>> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
>>>>>>>> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
>>>>>>>> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
>>>>>>>> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
>>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>>> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
>>>>>>>> Kernel panic - not syncing: Fatal exception
>>>>>>>> Kernel Offset: 0x31c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>>>>>>> ---[ end Kernel panic - not syncing: Fatal exception ]---
>>>>>>>>
>>>>>>>> The root cause is that unpoison_memory() tries to check the PG_HWPoison
>>>>>>>> flags of an uninitialized page. So VM_BUG_ON_PAGE(PagePoisoned(page)) is
>>>>>>>> triggered.
>>>>>>>
>>>>>>> I'm not seeing the call path.  Is this BUG happening via
>>>>>>>
>>>>>>> static __always_inline void __ClearPage##uname(struct page *page)    \
>>>>>>> {                                    \
>>>>>>>       VM_BUG_ON_PAGE(!Page##uname(page), page);            \
>>>>>>>       page->page_type |= PG_##lname;                    \
>>>>>>> }
>>>>>>>
>>>>>>> ?
>>>>>>>
>>>>>>> If so, where's the callsite?
>>>>>>
>>>>>> It is BUG on PF_ANY():
>>>>>>
>>>>>> PAGEFLAG(HWPoison, hwpoison, PF_ANY)
>>>>>>
>>>>>> #define PF_ANY(page, enforce)    PF_POISONED_CHECK(page)
>>>>>>
>>>>>> #define PF_POISONED_CHECK(page) ({                    \
>>>>>>       VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);        \
>>>>>>       page; })
>>>>>>
>>>>>> #define    PAGE_POISON_PATTERN    -1l
>>>>>> static inline int PagePoisoned(const struct page *page)
>>>>>> {
>>>>>>       return READ_ONCE(page->flags) == PAGE_POISON_PATTERN;
>>>>>> }
>>>>>>
>>>>>> The offlined pages will have page->flags set to PAGE_POISON_PATTERN while pfn is still valid:
>>>>>>
>>>>>> offline_pages
>>>>>>      remove_pfn_range_from_zone
>>>>>>        page_init_poison
>>>>>>          memset(page, PAGE_POISON_PATTERN, size);
>>>>>
>>>>> Worth noting that this happens after __offline_isolated_pages() marked the covering sections as offline.
>>>>>
>>>>> Are we missing a pfn_to_online_page() check somewhere, or are we racing with offlining code that marks the section offline?
>>>>
>>>> I was thinking about to use pfn_to_online_page() instead of pfn_to_page() in unpoison_memory() so we can get rid of offlined pages.
>>>> But there're ZONE_DEVICE pages. They're not-onlined too. And unpoison_memory() should work for them. So we can't simply use
>>>> pfn_to_online_page() in that. Or am I miss something?
>>>
>>> Right, pfn_to_online_page() does not detect ZONE_DEVICE. That has to be handled separately if pfn_to_online_page() would fail.
>>>
>>> ... which is what we do in memory_failure():
>>>
>>> p = pfn_to_online_page(pfn);
>>> if (!p) {
>>>      if (pfn_valid(pfn)) {
>>>          pgmap = get_dev_pagemap(pfn, NULL);
>>>          put_ref_page(pfn, flags);
>>>          if (pgmap) {
>>>              ...
>>>          }
>>>      }
>>>      ...
>>> }
>>
>> Yup, this will be a good alternative. But will it be better to simply check PagePoisoned() instead?
> 
> The memmap of offline memory sections shall not be touched, so .... don't touch it ;)
> 
> Especially because that PagePoisoned() check is non-sensical without poisoining-during-memmap-init. You would still work with memory in offline sections.
> 
> I think the code is even wrong in that regard: we allow for memory offlining to work with HWPoisoned pages, see __offline_isolated_pages(). Staring at unpoison_memory(), we might be putting these pages back to the buddy? Which is completely wrong.

I agree with you. Thanks for detailed explanation. :)
Thanks David.
.


