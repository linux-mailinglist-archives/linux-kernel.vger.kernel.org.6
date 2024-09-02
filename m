Return-Path: <linux-kernel+bounces-311303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31A968755
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD3C1C23960
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D61619E989;
	Mon,  2 Sep 2024 12:14:28 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701A19E99C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279267; cv=none; b=O1me6XHQwacPEolKv/fb8EFsscVsk0yT/4RpZ8jPCa5zQqehV1X58zvXcbqD98s0L6WMCjGXdjccGtihwoi8cncxjCq+0X/iW3NR8N7OvWeCnZpHvBGFcFpi+DjSbAl6gohdn6xJW71rHyYvgVDHmisCZ0LKA2AC+GLgbfoGrTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279267; c=relaxed/simple;
	bh=vbmTo3sYFCJ+q3zU7bPOiHT3IQKqKpeCsdBl5k+4OHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I/6z6OCaL6qh9Cg8eBKQK/c11xB2/oqwBYZMjH23aL5NBlsxAm27WgeS9MuK/Ea73xuTJ2+XUgFL5Q9HX3PmL5NQRqfS2/RpW7p6y6FhNuUBu2OuGSKUSadTF4jXFwVJK+ydmdCrq5rB6QjkeYNN+ZEMCzxwaphA6Jr00KFQ0LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wy73N1KYhz9sSN;
	Mon,  2 Sep 2024 14:14:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xFw8JZhbhWWi; Mon,  2 Sep 2024 14:14:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wy73N0G7tz9sS7;
	Mon,  2 Sep 2024 14:14:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EAB918B76C;
	Mon,  2 Sep 2024 14:14:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id drJLpxYo544D; Mon,  2 Sep 2024 14:14:23 +0200 (CEST)
Received: from [192.168.234.167] (unknown [192.168.234.167])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 86A878B763;
	Mon,  2 Sep 2024 14:14:23 +0200 (CEST)
Message-ID: <096cd294-8ce7-4866-aa40-17807b072f45@csgroup.eu>
Date: Mon, 2 Sep 2024 14:14:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] static_call: Fix a wild-memory-access bug in
 static_call_del_module()
To: Jinjie Ruan <ruanjinjie@huawei.com>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>
References: <20230915082126.4187913-1-ruanjinjie@huawei.com>
 <0f339f49-bb8d-e28d-c9d6-8f16bd62995d@huawei.com>
 <d6c0cfeb-f4bd-4564-84e4-a0db71608a6b@csgroup.eu>
 <f9e9e640-dd43-c808-7ac0-961728e205a2@huawei.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <f9e9e640-dd43-c808-7ac0-961728e205a2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/09/2024 à 14:07, Jinjie Ruan a écrit :
> 
> 
> On 2024/9/2 20:06, Christophe Leroy wrote:
>> Hi,
>>
>> Le 02/09/2024 à 14:01, Jinjie Ruan a écrit :
>>> Hi, it seems that this bug still exit.
>>
>> Can you provide more details ?
>>
>> In particular, what makes you think it is the exact same bug ?
> 
> I apply this patch, and the problem not occurs.

Ah, you mean the patch hasn't been applied yet ?

I thought you were telling that despite the patch the problem was still 
there.

Christophe

> 
>>
>> Christophe
>>
>>
>>>
>>> On 2023/9/15 16:21, Jinjie Ruan wrote:
>>>> Inject fault while probing btrfs.ko, if the first kzalloc() fails
>>>> in __static_call_init(), key->mods will no be initialized. And then
>>>> in static_call_del_module() the site_mod->mod will cause
>>>> wild-memory-access as below:
>>>>
>>>> So assign key->mods to NULL in __static_call_init() if it fails
>>>> to fix the issue. And if kzalloc fails, it will just return in init
>>>> func, so it should break if it the key->mods is NULL in exit func.
>>>>
>>>>    general protection fault, probably for non-canonical address
>>>> 0xeb800159c89f94a0: 0000 [#1] PREEMPT SMP KASAN
>>>>    KASAN: maybe wild-memory-access in range
>>>> [0x5c002ace44fca500-0x5c002ace44fca507]
>>>>    CPU: 2 PID: 1843 Comm: modprobe Tainted: G        W        N
>>>> 6.6.0-rc1+ #60
>>>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>>> 1.13.0-1ubuntu1.1 04/01/2014
>>>>    RIP: 0010:static_call_del_module+0x113/0x280
>>>>    Code: 3c 20 00 0f 85 ef 00 00 00 49 8b 6e 08 48 85 ed 75 0d eb 75
>>>> 48 85 db 74 70 49 89 ef 48 89 dd 48 8d 7d 08 48 89 f8 48 c1 e8 03
>>>> <42> 80 3c 20 00 75 78 48 89 e8 4c 8b 6d 08 48 c1 e8 03 42 80 3c 20
>>>>    RSP: 0018:ffff888101d3f860 EFLAGS: 00010206
>>>>    RAX: 0b800559c89f94a0 RBX: 5c002ace44fca4f8 RCX: ffffffffa0210f00
>>>>    RDX: ffffffffa0210ed4 RSI: ffffffffa0210edc RDI: 5c002ace44fca500
>>>>    RBP: 5c002ace44fca4f8 R08: 0000000000000000 R09: ffffed10233e4eea
>>>>    R10: ffffed10233e4ee9 R11: ffff888119f2774b R12: dffffc0000000000
>>>>    R13: 80002ace3cfca4f8 R14: ffffffff85196de0 R15: ffffffff84ee9f99
>>>>    FS:  00007f4ff6faa540(0000) GS:ffff888119f00000(0000)
>>>> knlGS:0000000000000000
>>>>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>    CR2: 00007ffc3d1f19e8 CR3: 0000000109fa6001 CR4: 0000000000170ee0
>>>>    DR0: ffffffff8faefce8 DR1: ffffffff8faefce9 DR2: ffffffff8faefcea
>>>>    DR3: ffffffff8faefceb DR6: 00000000ffff0ff0 DR7: 0000000000000600
>>>>    Call Trace:
>>>>     <TASK>
>>>>     ? __die_body+0x1b/0x60
>>>>     ? die_addr+0x43/0x70
>>>>     ? exc_general_protection+0x121/0x210
>>>>     ? asm_exc_general_protection+0x22/0x30
>>>>     ? static_call_del_module+0x113/0x280
>>>>     ? __SCT__tp_func_ipi_exit+0x8/0x8
>>>>     static_call_module_notify+0x27f/0x390
>>>>     ? rcu_segcblist_inc_len+0x17/0x20
>>>>     notifier_call_chain+0xbf/0x280
>>>>     notifier_call_chain_robust+0x7f/0xe0
>>>>     ? notifier_call_chain+0x280/0x280
>>>>     ? kasan_quarantine_put+0x46/0x160
>>>>     blocking_notifier_call_chain_robust+0x5b/0x80
>>>>     load_module+0x4d1d/0x69f0
>>>>     ? module_frob_arch_sections+0x20/0x20
>>>>     ? update_cfs_group+0x10c/0x2a0
>>>>     ? __wake_up_common+0x10b/0x5d0
>>>>     ? kernel_read_file+0x3ca/0x510
>>>>     ? __x64_sys_fsconfig+0x650/0x650
>>>>     ? __schedule+0xa0b/0x2a60
>>>>     ? init_module_from_file+0xd2/0x130
>>>>     init_module_from_file+0xd2/0x130
>>>>     ? __ia32_sys_init_module+0xa0/0xa0
>>>>     ? _raw_spin_lock_irqsave+0xe0/0xe0
>>>>     ? ptrace_stop+0x487/0x790
>>>>     idempotent_init_module+0x32d/0x6a0
>>>>     ? init_module_from_file+0x130/0x130
>>>>     ? __fget_light+0x57/0x500
>>>>     __x64_sys_finit_module+0xbb/0x130
>>>>     do_syscall_64+0x35/0x80
>>>>     entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>>    RIP: 0033:0x7f4ff691b839
>>>>    Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8
>>>> 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05
>>>> <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
>>>>    RSP: 002b:00007ffc07b09718 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>>>>    RAX: ffffffffffffffda RBX: 000055978f13e070 RCX: 00007f4ff691b839
>>>>    RDX: 0000000000000000 RSI: 000055978da1bc2e RDI: 0000000000000003
>>>>    RBP: 000055978da1bc2e R08: 0000000000000000 R09: 000055978f13ddb0
>>>>    R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
>>>>    R13: 000055978f13e020 R14: 0000000000040000 R15: 000055978f13ddb0
>>>>     </TASK>
>>>>    Modules linked in: tifm_core(+)
>>>>    Dumping ftrace buffer:
>>>>       (ftrace buffer empty)
>>>>    ---[ end trace 0000000000000000 ]---
>>>>    RIP: 0010:static_call_del_module+0x113/0x280
>>>>    Code: 3c 20 00 0f 85 ef 00 00 00 49 8b 6e 08 48 85 ed 75 0d eb 75
>>>> 48 85 db 74 70 49 89 ef 48 89 dd 48 8d 7d 08 48 89 f8 48 c1 e8 03
>>>> <42> 80 3c 20 00 75 78 48 89 e8 4c 8b 6d 08 48 c1 e8 03 42 80 3c 20
>>>>    RSP: 0018:ffff888101d3f860 EFLAGS: 00010206
>>>>    RAX: 0b800559c89f94a0 RBX: 5c002ace44fca4f8 RCX: ffffffffa0210f00
>>>>    RDX: ffffffffa0210ed4 RSI: ffffffffa0210edc RDI: 5c002ace44fca500
>>>>    RBP: 5c002ace44fca4f8 R08: 0000000000000000 R09: ffffed10233e4eea
>>>>    R10: ffffed10233e4ee9 R11: ffff888119f2774b R12: dffffc0000000000
>>>>    R13: 80002ace3cfca4f8 R14: ffffffff85196de0 R15: ffffffff84ee9f99
>>>>    FS:  00007f4ff6faa540(0000) GS:ffff888119f00000(0000)
>>>> knlGS:0000000000000000
>>>>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>    CR2: 00007ffc3d1f19e8 CR3: 0000000109fa6001 CR4: 0000000000170ee0
>>>>    DR0: ffffffff8faefce8 DR1: ffffffff8faefce9 DR2: ffffffff8faefcea
>>>>    DR3: ffffffff8faefceb DR6: 00000000ffff0ff0 DR7: 0000000000000600
>>>>    Kernel panic - not syncing: Fatal exception
>>>>    Dumping ftrace buffer:
>>>>       (ftrace buffer empty)
>>>>    Kernel Offset: disabled
>>>>    Rebooting in 1 seconds..
>>>>
>>>> Fixes: 8fd4ddda2f49 ("static_call: Don't make __static_call_return0
>>>> static")
>>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>>> ---
>>>>    kernel/static_call_inline.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
>>>> index 639397b5491c..e7aa70d33530 100644
>>>> --- a/kernel/static_call_inline.c
>>>> +++ b/kernel/static_call_inline.c
>>>> @@ -256,8 +256,10 @@ static int __static_call_init(struct module *mod,
>>>>                }
>>>>                  site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
>>>> -            if (!site_mod)
>>>> +            if (!site_mod) {
>>>> +                key->mods = NULL;
>>>>                    return -ENOMEM;
>>>> +            }
>>>>                  /*
>>>>                 * When the key has a direct sites pointer, extract
>>>> @@ -422,7 +424,7 @@ static void static_call_del_module(struct module
>>>> *mod)
>>>>                ;
>>>>              if (!site_mod)
>>>> -            continue;
>>>> +            break;
>>>>              *prev = site_mod->next;
>>>>            kfree(site_mod);
>>

