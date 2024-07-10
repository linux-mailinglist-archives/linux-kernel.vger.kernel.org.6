Return-Path: <linux-kernel+bounces-246939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDCC92C91A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D9C1F2400F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D682B9DD;
	Wed, 10 Jul 2024 03:26:01 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318DD282F7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720581960; cv=none; b=MvNQmBSNjevpaP0Sr2CgWo3BfHE7ZseGjRzKe93SKNcWHvC6rFrN/Ipl5hyQ7KlZm5hrES6ysOTs59rFaFye9vcAeHWTbCJVWeqrOphfM5dEeGwyJLFxLW+kq2QR95McNASIr1ufRsu/440jzs9Bvi4p/jnr1P4WrPYEWyUrjDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720581960; c=relaxed/simple;
	bh=VE6atJTl8AJuOMhGNOUbAMjs+mCPoGHq0O278org0aY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kr8b55ioehS4qMm5/DtH0I9HTM7Mq06WrdCxyfLQ4LUT7y3sRIdw9GhgmJTgKzWBQLCSGMBVQBt24o5DBAB6v/8gsXKLyIxab+B5oD+gGIwYXqDJcWi5r5ypmD2C2yHIIoH4bM/c/lsH798pBlAzGWEXRVYICIT7qS4R6CEZQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WJjrY6Rj1zdgvg;
	Wed, 10 Jul 2024 11:24:13 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FE6514041B;
	Wed, 10 Jul 2024 11:25:54 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jul 2024 11:25:53 +0800
Subject: Re: [PATCH RESEND] mm/hugetlb: fix kernel NULL pointer dereference
 when migrating hugetlb folio
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <muchun.song@linux.dev>, <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240709120433.4136700-1-linmiaohe@huawei.com>
 <f40218df-40bf-c0e4-5463-c07023c10b4a@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <070b6acd-e60f-b2c8-18c7-9a9d3806f273@huawei.com>
Date: Wed, 10 Jul 2024 11:25:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f40218df-40bf-c0e4-5463-c07023c10b4a@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/10 8:14, Hugh Dickins wrote:
> On Tue, 9 Jul 2024, Miaohe Lin wrote:
> 
>> A kernel crash was observed when migrating hugetlb folio:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000008
>> PGD 0 P4D 0
>> Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
>> CPU: 0 PID: 3435 Comm: bash Not tainted 6.10.0-rc6-00450-g8578ca01f21f #66
>> RIP: 0010:__folio_undo_large_rmappable+0x70/0xb0
>> RSP: 0018:ffffb165c98a7b38 EFLAGS: 00000097
>> RAX: fffffbbc44528090 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: ffffa30e000a2800 RSI: 0000000000000246 RDI: ffffa3153ffffcc0
>> RBP: fffffbbc44528000 R08: 0000000000002371 R09: ffffffffbe4e5868
>> R10: 0000000000000001 R11: 0000000000000001 R12: ffffa3153ffffcc0
>> R13: fffffbbc44468000 R14: 0000000000000001 R15: 0000000000000001
>> FS:  00007f5b3a716740(0000) GS:ffffa3151fc00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000008 CR3: 000000010959a000 CR4: 00000000000006f0
>> Call Trace:
>>  <TASK>
>>  __folio_migrate_mapping+0x59e/0x950
>>  __migrate_folio.constprop.0+0x5f/0x120
>>  move_to_new_folio+0xfd/0x250
>>  migrate_pages+0x383/0xd70
>>  soft_offline_page+0x2ab/0x7f0
>>  soft_offline_page_store+0x52/0x90
>>  kernfs_fop_write_iter+0x12c/0x1d0
>>  vfs_write+0x380/0x540
>>  ksys_write+0x64/0xe0
>>  do_syscall_64+0xb9/0x1d0
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f5b3a514887
>> RSP: 002b:00007ffe138fce68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f5b3a514887
>> RDX: 000000000000000c RSI: 0000556ab809ee10 RDI: 0000000000000001
>> RBP: 0000556ab809ee10 R08: 00007f5b3a5d1460 R09: 000000007fffffff
>> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
>> R13: 00007f5b3a61b780 R14: 00007f5b3a617600 R15: 00007f5b3a616a00
>>
>> It's because hugetlb folio is passed to __folio_undo_large_rmappable()
>> unexpectedly. large_rmappable flag is imperceptibly set to hugetlb folio
>> since commit f6a8dd98a2ce ("hugetlb: convert alloc_buddy_hugetlb_folio to
>> use a folio"). Then commit be9581ea8c05 ("mm: fix crashes from deferred
>> split racing folio migration") makes folio_migrate_mapping() call
>> folio_undo_large_rmappable() triggering the bug. Fix this issue by
>> clearing large_rmappable flag for hugetlb folios. They don't need that
>> flag set anyway.
> 
> Gosh, thanks a lot for catching this: it had not crossed my mind that
> a folio which passes (folio_test_large and) folio_test_large_rmappable
> might not be suitable for folio_undo_large_rmappable.
> 
>>
>> Fixes: f6a8dd98a2ce ("hugetlb: convert alloc_buddy_hugetlb_folio to use a folio")
> 
> That's in 6.10-rc, isn't it?
> 
>> Fixes: be9581ea8c05 ("mm: fix crashes from deferred split racing folio migration")
> 
> And that's in mm-hotfixes-stable intended for 6.10 final.
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: <stable@vger.kernel.org>
> 
> So if all goes to plan, this shouldn't need the Cc stable.

I think you are right. Cc stable should be removed. But this patch has been merged into
mm-hotfixes-stable branch, so might Andrew can kindly help modify this?

> 
> I certainly deserve blame for not thinking of this possibility: but how
> was it working before my commit, when the folio_undo_large_rmappable()
> was being called from mem_cgroup_migrate()?  I think that was just as
> liable to crash too.

I reproduced the crash today with commit be9581ea8c05 ("mm: fix crashes from deferred split racing folio migration") reverted:

BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0
Oops: 0002 [#1] PREEMPT SMP NOPTI
CPU: 11 PID: 1481 Comm: bash Not tainted 6.9.0-rc4-00265-gf6a8dd98a2ce-dirty #76
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:folio_undo_large_rmappable+0xa0/0xe0
RSP: 0018:ffffa4104950fbd0 EFLAGS: 00000097
RAX: ffff9e06001c8800 RBX: ffffc8f6614f0090 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000286 RDI: ffff9e060b23db98
RBP: ffffc8f6614f0000 R08: 0000000000002453 R09: ffffffffaead2a48
R10: 0000000000000000 R11: 0000000000000001 R12: ffff9e060b23db98
R13: 0000000000000000 R14: 0000000000000000 R15: ffffa4104950fcc8
FS:  00007f6821eb0740(0000) GS:ffff9e0ddfcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000000884502000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 mem_cgroup_migrate+0x186/0x1d0
 migrate_folio_extra+0x5c/0x90
 move_to_new_folio+0xff/0x250
 migrate_pages+0x702/0xd20
 soft_offline_page+0x29b/0x7a0
 soft_offline_page_store+0x52/0x90
 kernfs_fop_write_iter+0x12c/0x1d0
 vfs_write+0x387/0x550
 ksys_write+0x64/0xe0
 do_syscall_64+0xc2/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6821d14887
RSP: 002b:00007ffeecdb19a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f6821d14887
RDX: 000000000000000c RSI: 0000563cfd799e10 RDI: 0000000000000001
RBP: 0000563cfd799e10 R08: 00007f6821dd1460 R09: 000000007fffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
R13: 00007f6821e1b780 R14: 00007f6821e17600 R15: 00007f6821e16a00

This requires memory_hugetlb_accounting is enabled on cgroup2. Or folio_memcg of hugetlb folio will be NULL
and thus simply return before calling folio_undo_large_rmappable() in mem_cgroup_migrate().
memory_hugetlb_accounting isnot enable in my test env, so I didn't trigger this bug earlier.

So Fixes: be9581ea8c05 ("mm: fix crashes from deferred split racing folio migration") tag might also be removed?

> 
> I would like to hear definitively from Matthew, whether a hugetlb page
> should or should not be reported as large_rmappable - is your patch here
> just fixing a surprise, or in danger of adding another surprise somewhere?

IIUC, large_rmappable is only used for thp. See below code:

static inline bool is_transparent_hugepage(const struct folio *folio)
{
	if (!folio_test_large(folio))
		return false;

	return is_huge_zero_folio(folio) ||
		folio_test_large_rmappable(folio);
}

But I might be miss something.
Thanks.
.

