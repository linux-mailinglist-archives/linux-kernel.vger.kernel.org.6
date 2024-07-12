Return-Path: <linux-kernel+bounces-250073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C44692F3F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9511C220B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5FDBE46;
	Fri, 12 Jul 2024 02:08:45 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39DBA49
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720750125; cv=none; b=oidsEUjO43H3L12Wvl8k48ye/vTohPoDDAsHxTf1DlCP8hzGmIinewlh0N0XMoqVbTxWpqqidfufEPPsVo4M0ORli3dN89S20z8bJWOIouwkj/jVCt7FY6FCcRx08zwOarNUhbe+vGK0XMsqht6bWoIkqcvW2Q7WBdVxS1JMo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720750125; c=relaxed/simple;
	bh=tNCNQS7Dw7J2AA0Cc6RnEjSA39CrtltyEjxuzAgPbO8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FJ++mf0IqbLQM1VKsN6Rac8/za05fPrYRik6JSQ6quaLN40Wh8Nm3IESVJEqax2aSCa5Ua2SCk/M+FtSzL537iviYimpVcMGC/IoV8zIfSGMar5a7RR8tby8Yt2BtamC4+5uygEGxA66y3eJ9f6sRq+RklNpKVg8e3wvv9Miejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WKvzR4DFrz1X4k0;
	Fri, 12 Jul 2024 10:04:19 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id C6C04140337;
	Fri, 12 Jul 2024 10:08:33 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jul 2024 10:08:33 +0800
Subject: Re: [PATCH] mm/hugetlb: fix possible recursive locking detected
 warning
To: Muchun Song <muchun.song@linux.dev>
CC: Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20240711071001.3475337-1-linmiaohe@huawei.com>
 <4A12CD33-A3C4-4328-ACB5-CF08C8202DC9@linux.dev>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ad3dcd0c-4d99-54ae-1f48-77dbbe4a7f44@huawei.com>
Date: Fri, 12 Jul 2024 10:08:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4A12CD33-A3C4-4328-ACB5-CF08C8202DC9@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/11 16:27, Muchun Song wrote:
> 
> 
>> On Jul 11, 2024, at 15:10, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> When tries to demote 1G hugetlb folios, a lockdep warning is observed:
>>
>> ============================================
>> WARNING: possible recursive locking detected
>> 6.10.0-rc6-00452-ga4d0275fa660-dirty #79 Not tainted
>> --------------------------------------------
>> bash/710 is trying to acquire lock:
>> ffffffff8f0a7850 (&h->resize_lock){+.+.}-{3:3}, at: demote_store+0x244/0x460
>>
>> but task is already holding lock:
>> ffffffff8f0a6f48 (&h->resize_lock){+.+.}-{3:3}, at: demote_store+0xae/0x460
>>
>> other info that might help us debug this:
>> Possible unsafe locking scenario:
>>
>>       CPU0
>>       ----
>>  lock(&h->resize_lock);
>>  lock(&h->resize_lock);
>>
>> *** DEADLOCK ***
>>
>> May be due to missing lock nesting notation
>>
>> 4 locks held by bash/710:
>> #0: ffff8f118439c3f0 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x64/0xe0
>> #1: ffff8f11893b9e88 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xf8/0x1d0
>> #2: ffff8f1183dc4428 (kn->active#98){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x100/0x1d0
>> #3: ffffffff8f0a6f48 (&h->resize_lock){+.+.}-{3:3}, at: demote_store+0xae/0x460
>>
>> stack backtrace:
>> CPU: 3 PID: 710 Comm: bash Not tainted 6.10.0-rc6-00452-ga4d0275fa660-dirty #79
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>> Call Trace:
>> <TASK>
>> dump_stack_lvl+0x68/0xa0
>> __lock_acquire+0x10f2/0x1ca0
>> lock_acquire+0xbe/0x2d0
>> __mutex_lock+0x6d/0x400
>> demote_store+0x244/0x460
>> kernfs_fop_write_iter+0x12c/0x1d0
>> vfs_write+0x380/0x540
>> ksys_write+0x64/0xe0
>> do_syscall_64+0xb9/0x1d0
>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7fa61db14887
>> RSP: 002b:00007ffc56c48358 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa61db14887
>> RDX: 0000000000000002 RSI: 000055a030050220 RDI: 0000000000000001
>> RBP: 000055a030050220 R08: 00007fa61dbd1460 R09: 000000007fffffff
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
>> R13: 00007fa61dc1b780 R14: 00007fa61dc17600 R15: 00007fa61dc16a00
>> </TASK>
>>
>> Lockdep considers this an AA deadlock because the different resize_lock
>> mutexes reside in the same lockdep class, but this is a false positive.
>> Place them in distinct classes to avoid these warnings.
>>
>> Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>> mm/hugetlb.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 45fd3bc75332..2004e6d3f7ca 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -4659,6 +4659,8 @@ bool __init __attribute((weak)) arch_hugetlb_valid_size(unsigned long size)
>> return size == HPAGE_SIZE;
>> }
>>
>> +static struct lock_class_key hugetlb_resize_keys[HUGE_MAX_HSTATE];
> 
> It's better to let this into "struct hstate".
> 
>> +
>> void __init hugetlb_add_hstate(unsigned int order)
>> {
>> 	struct hstate *h;
>> @@ -4671,6 +4673,7 @@ void __init hugetlb_add_hstate(unsigned int order)
>> 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));
>> 	h = &hstates[hugetlb_max_hstate++];
>> 	mutex_init(&h->resize_lock);
> 
> mutex_init() already declares a lock_class_key structure by itself, in
> order to avoid this, you should use __mutex_init().

While searching the code, I find we can do this in two ways:
1.__mutex_init with separate lock_class_key
2.mutex_init + lockdep_set_class

These are all fine to me. And I will use __mutex_init and move hugetlb_resize_keys
into "struct hstate" as you suggested.
Thanks.
.

