Return-Path: <linux-kernel+bounces-252074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16D930DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430D8281554
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0D013BC3D;
	Mon, 15 Jul 2024 06:23:50 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9421E89C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721024630; cv=none; b=RxoEXvYXduxMJO8ahQLbYudL5bMJnw+oMKSV06fwsUS/u2UroUH05iW0tNsuIYFPa9zQwZq+UrvPbjTQD42ZWI0qS7p8lCCXD9AnWvE4S0mk3wU/7aS2t2Cxum6VNE07rwDvzbk7aHpgN9mv1u2Eg4TzkjlU6mGgP0jPSM8OM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721024630; c=relaxed/simple;
	bh=XXCUXGWPSSzklNSCq2m8DSQ0Hyy3sM2PBwlUqsyAC4k=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f+uTmdK3dAWklpx6ddovsNMe+eHusV+g7zi2R30SA4IFdXuqQuLf0hVhWGyCsa1Yl2Of/323d+h3wtELYO/j+BkrwTP2P1yJvOqN7qO6V8C0t9kCiVUM4sTIHq5gtM2H/6dh8USroFtnYqPr/i1eiSBsoZpGfcngOFVs69x7tlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WMsVc3nDhzQllW;
	Mon, 15 Jul 2024 14:19:36 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E195140158;
	Mon, 15 Jul 2024 14:23:37 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Jul 2024 14:23:37 +0800
Subject: Re: [PATCH] mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page))
 when unpoison memory
To: Andrew Morton <akpm@linux-foundation.org>
CC: <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240712064249.3882707-1-linmiaohe@huawei.com>
 <20240712140921.9aa90b18d22e67417d59dfc1@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8fe349f9-d3d3-65ab-6045-da0bd19249ea@huawei.com>
Date: Mon, 15 Jul 2024 14:23:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240712140921.9aa90b18d22e67417d59dfc1@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/13 5:09, Andrew Morton wrote:
> On Fri, 12 Jul 2024 14:42:49 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> When I did memory failure tests recently, below panic occurs:
>>
>> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(page))
>> kernel BUG at include/linux/page-flags.h:616!
>> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>> CPU: 3 PID: 720 Comm: bash Not tainted 6.10.0-rc1-00195-g148743902568 #40
>> RIP: 0010:unpoison_memory+0x2f3/0x590
>> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
>> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
>> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
>> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
>> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
>> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
>> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
>> Call Trace:
>>  <TASK>
>>  unpoison_memory+0x2f3/0x590
>>  simple_attr_write_xsigned.constprop.0.isra.0+0xb3/0x110
>>  debugfs_attr_write+0x42/0x60
>>  full_proxy_write+0x5b/0x80
>>  vfs_write+0xd5/0x540
>>  ksys_write+0x64/0xe0
>>  do_syscall_64+0xb9/0x1d0
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f08f0314887
>> RSP: 002b:00007ffece710078 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f08f0314887
>> RDX: 0000000000000009 RSI: 0000564787a30410 RDI: 0000000000000001
>> RBP: 0000564787a30410 R08: 000000000000fefe R09: 000000007fffffff
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
>> R13: 00007f08f041b780 R14: 00007f08f0417600 R15: 00007f08f0416a00
>>  </TASK>
>> Modules linked in: hwpoison_inject
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:unpoison_memory+0x2f3/0x590
>> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
>> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
>> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
>> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
>> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
>> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
>> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
>> Kernel panic - not syncing: Fatal exception
>> Kernel Offset: 0x31c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> ---[ end Kernel panic - not syncing: Fatal exception ]---
>>
>> The root cause is that unpoison_memory() tries to check the PG_HWPoison
>> flags of an uninitialized page. So VM_BUG_ON_PAGE(PagePoisoned(page)) is
>> triggered.
> 
> I'm not seeing the call path.  Is this BUG happening via
> 
> static __always_inline void __ClearPage##uname(struct page *page)	\
> {									\
> 	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
> 	page->page_type |= PG_##lname;					\
> }
> 
> ?
> 
> If so, where's the callsite?

It is BUG on PF_ANY():

PAGEFLAG(HWPoison, hwpoison, PF_ANY)

#define PF_ANY(page, enforce)	PF_POISONED_CHECK(page)

#define PF_POISONED_CHECK(page) ({					\
	VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);		\
	page; })

#define	PAGE_POISON_PATTERN	-1l
static inline int PagePoisoned(const struct page *page)
{
	return READ_ONCE(page->flags) == PAGE_POISON_PATTERN;
}

The offlined pages will have page->flags set to PAGE_POISON_PATTERN while pfn is still valid:

offline_pages
  remove_pfn_range_from_zone
    page_init_poison
      memset(page, PAGE_POISON_PATTERN, size);

> 
>> This can be reproduced by below steps:
>> 1.Offline memory block:
>>  echo offline > /sys/devices/system/memory/memory12/state
>> 2.Get offlined memory pfn:
>>  page-types -b n -rlN
>> 3.Write pfn to unpoison-pfn
>>  echo <pfn> > /sys/kernel/debug/hwpoison/unpoison-pfn
>>
> 
> I guess cc:stable.  It looks old?  Can you help to identify the Fixes:
> target?

Since memory unpoison is only used for testing and users usually won't pass in a offlined pfn (memory
offline itself should be rare too). So I think this doesn't deserve cc statble. But If a Fixes tag is
required, I think it should be:

Fixes: f165b378bbdf ("mm: uninitialized struct page poisoning sanity checking")

Thanks.
.


