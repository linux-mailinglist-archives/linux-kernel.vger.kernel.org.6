Return-Path: <linux-kernel+bounces-361400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A3B99A7AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EA71C2617C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DE6194AD9;
	Fri, 11 Oct 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es/qYfJN"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8AE198822
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660540; cv=none; b=n1myCRQaZgWEBAg5yratBkmvHBTcuqYqqybvnV1D9Aj/oF/vrANKCiM7CIzAIoUHGmYKp6/i8qrqTy0tBIJYl19Z+JdusyNZ2bSc8Bemp+/SMYKDzAw8U+jBK1GcVRXtIW4anx75Ndl1K9GPHijVNPDFM7rnCxhTXDIxCYexV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660540; c=relaxed/simple;
	bh=dWfSMRhPXLdMBuOajIQ6kX8dAT6EZFkA8GULEQ79hgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxZM8/iA0Gl0L7M+2CyACn5jIkzJXvbay3IgfNVrnBFtFhWivaaTDUSeM7F93ISTF36vfiuUgDYOe2LYhzFVabcdi+A7DmZnw8lcwAYK39L8gzrug7BL4KhsOoSd9ZAx6cCg7oPVc2Q7EFQSRU/8MY1wh4vH2NpRzkgY34JzcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es/qYfJN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so23325375e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728660537; x=1729265337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QfeLlDeGoy15GkYfRzwOhf7k1SABlIBrHrFgJUAl1NM=;
        b=Es/qYfJNFSE+L35sv6yTFa8nwzHfdIIZDIIlcrUb+mXmvZ+o5azP+N64gGOVkQiU3R
         9Tnd1M/FPznJWg5EkaLTYUdCagZUI7/zYFA0RWdApj/HiTRx+2c5WcAL2dPMbc+gxO2+
         2eCB5VoQl5eBPzpyk1L0nE+S2z725cz5Ik7HIqLlRwry9uZoHuXydeB8VC8NdHrE6LZI
         3tFc1X8NUQ5rMJUEoaL1kwh+LUerPxNDqhwCr1Exnaq3D5TDae2ggtCz8jsJq095Y+sr
         qTsptqjQYCn8wlqxewA0SjLyt4O6HnKVB/+tVIiuZ5fnlncm7TmptBGh4QGc9FzuRYsI
         /TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728660537; x=1729265337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfeLlDeGoy15GkYfRzwOhf7k1SABlIBrHrFgJUAl1NM=;
        b=sWqj3nunkQ8tueThjWum+In0f3fOe3556aFCwTUwEuDGVBMp2AFASEKWhswHBQopRr
         SHmAU2jNS2dreUlCkq9FyKoll16y5Lu9wzkxb2YAJ9d0FLdwuIdvZ2UXjYFlhMJWcC8W
         NofxxHIp90if/7GbYAHHD6AdefGHVsrLZ/Memv1ZVlxi2xINWEA3hB19lSkA8yHD456+
         b+UxkupbmsgsbOeXMWbTQXbWNbhqmwWwIeGwrzYH75I4o08C1mTTFu67Tyw1HmMP6gp1
         8Uc1gC733odAgTCyVlRPwJTWg35837WwoIq2wpKJpBRc9mGlLTTYdVIUuxWK1KCa9sDn
         y+ag==
X-Gm-Message-State: AOJu0YyvaNNeDG14TZovQ49UMBbdlW4RBxm/m9n2Qcar3D+wehIXbzLX
	r6Cb4UDm/PczDZZwA6eIYnDV9jLIJsAa6F1Alvrr3sZXN9GhclOY
X-Google-Smtp-Source: AGHT+IFiYNn0Vu8/fVp3Xcz00kgEobjz4zWGlz2LGaYY+9bFDEr3UCLxma0vWBmncQPG/CG17tmCOw==
X-Received: by 2002:a05:600c:202:b0:42f:6878:a683 with SMTP id 5b1f17b1804b1-4311df24e62mr28368455e9.22.1728660536696;
        Fri, 11 Oct 2024 08:28:56 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff785sm44995805e9.13.2024.10.11.08.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 08:28:56 -0700 (PDT)
Message-ID: <684ffb0a-2cc0-4ea3-b5f7-b0518ed2e83d@gmail.com>
Date: Fri, 11 Oct 2024 16:28:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] KMSAN: uninit-value in swap_writepage
To: Andrew Morton <akpm@linux-foundation.org>,
 syzbot <syzbot+febb2473441bfb8fb380@syzkaller.appspotmail.com>,
 Hugh Dickins <hughd@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, Nhat Pham <nphamcs@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Chengming Zhou <chengming.zhou@linux.dev>
References: <670793eb.050a0220.8109b.0003.GAE@google.com>
 <20241010142355.92225576a955836a67ef746a@linux-foundation.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20241010142355.92225576a955836a67ef746a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/10/2024 22:23, Andrew Morton wrote:
> On Thu, 10 Oct 2024 01:44:27 -0700 syzbot <syzbot+febb2473441bfb8fb380@syzkaller.appspotmail.com> wrote:
> 
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    fc20a3e57247 Merge tag 'for-linus-6.12a-rc2-tag' of git://..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11cdfd27980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d302f14701986aa0
>> dashboard link: https://syzkaller.appspot.com/bug?extid=febb2473441bfb8fb380
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/5b4b9aca7b75/disk-fc20a3e5.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/b22e17636ec0/vmlinux-fc20a3e5.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/5266e625be99/bzImage-fc20a3e5.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+febb2473441bfb8fb380@syzkaller.appspotmail.com
> 
> Thanks.  I'm guessing that shmem symlinks aren't initializing the whole
> page (folio) and that has tripped up Usama's "store zero pages to be
> swapped out in a bitmap" feature - it's checking the uninitialized part
> of the page for zeroness.
> 

This is a very similar bug to the one in https://lore.kernel.org/all/000000000000d0f165061a6754c3@google.com/
(Thanks Nhat for pointing this out!)

As Hugh mentioned in that thread, its likely not a bug in (z)swap.

Its just working with the folio that was given to it, and it should probably be
initialized before swap_writepage is called.

I havent worked on shmem code before, but will try to have a look.
Hugh mentioned in the other thread that shmem can keep uninitialized 
data pages around, but should be zeroing what's still uninitialized before
it can reach the outside world. Maybeshmem_symlink gets a folio
that wasnt initialized?

Thanks,
Usama  

> 
>> =====================================================
>> BUG: KMSAN: uninit-value in is_folio_zero_filled mm/page_io.c:189 [inline]
>> BUG: KMSAN: uninit-value in swap_writepage+0x536/0x12b0 mm/page_io.c:259
>>  is_folio_zero_filled mm/page_io.c:189 [inline]
>>  swap_writepage+0x536/0x12b0 mm/page_io.c:259
>>  shmem_writepage+0x2117/0x2450 mm/shmem.c:1567
>>  pageout mm/vmscan.c:688 [inline]
>>  shrink_folio_list+0x5e78/0x7dd0 mm/vmscan.c:1366
>>  evict_folios+0x9813/0xbaf0 mm/vmscan.c:4583
>>  try_to_shrink_lruvec+0x13a3/0x1750 mm/vmscan.c:4778
>>  shrink_one+0x646/0xd20 mm/vmscan.c:4816
>>  shrink_many mm/vmscan.c:4879 [inline]
>>  lru_gen_shrink_node mm/vmscan.c:4957 [inline] 
>>  shrink_node+0x451a/0x50f0 mm/vmscan.c:5937
>>  kswapd_shrink_node mm/vmscan.c:6765 [inline]
>>  balance_pgdat mm/vmscan.c:6957 [inline]
>>  kswapd+0x25e2/0x42f0 mm/vmscan.c:7226
>>  kthread+0x3e2/0x540 kernel/kthread.c:389
>>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>
>> Uninit was created at:
>>  __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4756
>>  alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
>>  folio_alloc_mpol_noprof+0x55/0x180 mm/mempolicy.c:2283
>>  shmem_alloc_folio mm/shmem.c:1774 [inline]
>>  shmem_alloc_and_add_folio+0xc33/0x1c30 mm/shmem.c:1813
>>  shmem_get_folio_gfp+0xacd/0x1f30 mm/shmem.c:2335
>>  shmem_get_folio mm/shmem.c:2441 [inline]
>>  shmem_symlink+0x528/0xa20 mm/shmem.c:3834
>>  vfs_symlink+0x1ed/0x460 fs/namei.c:4615
>>  do_symlinkat+0x257/0x8a0 fs/namei.c:4641
>>  __do_sys_symlink fs/namei.c:4662 [inline]
>>  __se_sys_symlink fs/namei.c:4660 [inline]
>>  __x64_sys_symlink+0xe0/0x140 fs/namei.c:4660
>>  x64_sys_call+0x30e8/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:89
>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> CPU: 1 UID: 0 PID: 80 Comm: kswapd0 Tainted: G        W          6.12.0-rc1-syzkaller-00330-gfc20a3e57247 #0
>> Tainted: [W]=WARN
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>> =====================================================
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup


