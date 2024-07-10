Return-Path: <linux-kernel+bounces-248245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BF292DA8C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038B71C22198
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FA512B171;
	Wed, 10 Jul 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SsnLi0Ed"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624AF12BE9E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720645503; cv=none; b=qUtV4MF9xYoWUdnoCBE18+B1hJDdRYcSkESaD+rU11edRAT66qHoNikp3UiCu1ha5ggHZllUOJz6ZYilw6FPeESO9FGKnGODRSw6PPYlRBg3L8kX79ZCt8GSijPHVduvk33fEIiqskJ3BH8HkohEoWq3JtHKz/nXLUgTq3VY6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720645503; c=relaxed/simple;
	bh=145qtbv+/+42VwyHhV43QSgLYYtGGwAOfGZblAIbB/g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AqBrmQ+vE18FJ53NXoN6QDDwg84qDBNCs5VopPULU/vVyDyxuga21uV6KMdLYIinj1vQSrubU2OGJbNP6NyoPB78amOeYszeNmLwSxjJPFg5NImtul8Tlpq6OEcKGXWybGaaM48Xp69eZhJn96PUJqU3v1eB8RY0O8RhhyNZRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SsnLi0Ed; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c74f6e5432so109228eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720645500; x=1721250300; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cVmkM5pkmjEc9AXEIMTtLe8LcvIhr2TG4wt8+Ccj5v8=;
        b=SsnLi0EddKqohl5n63/k+u0/hu/KiJ60mf2wGCUoTD6PozSOMrESk+SMwORdp1gbFP
         tWPo6QaPg+444GWqlxd8d2jBcI6/BVcu1jZrZgMKuib+yYLYnrHmuXfDcCmHvl+DK1z7
         0oyY/qOyw1dvnGgciUifLrsI4ls45NsJZkupp3ijByJAs16TVy0yIJNTnN0VpaJOMgkm
         B3YZjZAeJVSSkMhililXy92ttQcIbP5Y3sUw3FSGfaGXrLvQIW37Wq8SdiJgJhzL1AmL
         x8+eFJjaNsebfpO4y/22yVNOCdMiZEjvuCp8GjTMTLn+HdOC6oJWe8kCBqiWecNl2LkQ
         Q+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720645500; x=1721250300;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVmkM5pkmjEc9AXEIMTtLe8LcvIhr2TG4wt8+Ccj5v8=;
        b=oXVg+7VRYtwkN7WGT04hsMXH7AQj25C6ZLZDhToBOtvzNUtFjGH6rrjDjsuBiVMnU2
         5sO3F47qpq5D4Ab3GXAcGg90x2+qnCfxuVFqnCJaQNyTPuCQ27QaW36Kp2KntQphcs6T
         RBCqrwzh2dC7CLzbjgkeUgxdIpuwwHOFYQ6EGtu7NPsC/2H15tJToxfamUPIeG2g/0gw
         g9K4cYFvjy8trGMGdOMfZIE8vU/yZbCyvddJFfQiTEDyMCZWlGT5iHhbyVLth3aoYWwz
         gkMzWDE1WS0s3gYIdXE1jreG/UeuKiRD/KyY6Eg6uinhiB+WrfZ1JRikO3DfEty44vwo
         B9jA==
X-Forwarded-Encrypted: i=1; AJvYcCXiFMGIDwsIdsT3Z3V15Hy+Vvec8Q3cLe5y07mecUNlpkbwWGV2sibbr4gOd+LO+OOEYQB03euVhoB5AY4fj4ZC3OHmcPaa1UFW20a/
X-Gm-Message-State: AOJu0Ywdo6tZm5DQli3GWU1KzXsCFbAGMWIUjjj+iHOq8QE5J2odWqcC
	a9lnjnBI5URZzVL3mLp32D315H8Eld2kH2JIMZoZyna5lyRsJMgoBwEyXHjldR/hZeTu9sMUNFh
	3kA==
X-Google-Smtp-Source: AGHT+IFUZ5kQeBLmF75YbeZxVoaVrli5RZC6+DHIVE7ZVFUU01lkYMr4LdOs/bX9zS2V50KlbvQ1sw==
X-Received: by 2002:a4a:44c3:0:b0:5c2:27ea:85b2 with SMTP id 006d021491bc7-5c68e498bb5mr6005786eaf.8.1720645500172;
        Wed, 10 Jul 2024 14:05:00 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c7afecfb7bsm375353eaf.31.2024.07.10.14.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:04:59 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:04:46 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: syzbot <syzbot+a2cc273ad0e5a4c15302@syzkaller.appspotmail.com>
cc: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: corrupted list in
 __folio_undo_large_rmappable
In-Reply-To: <0000000000002b7de9061cea92b7@google.com>
Message-ID: <e6ff0084-82e8-3d73-2db1-8b07f60cb6a9@google.com>
References: <0000000000002b7de9061cea92b7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jul 2024, syzbot wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    82d01fe6ee52 Add linux-next specific files for 20240709
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14904441980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=95a20e7acf357998
> dashboard link: https://syzkaller.appspot.com/bug?extid=a2cc273ad0e5a4c15302
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15882a49980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172aba49980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/12dcacb06142/disk-82d01fe6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6ef954821378/vmlinux-82d01fe6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9ebf01d42887/bzImage-82d01fe6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a2cc273ad0e5a4c15302@syzkaller.appspotmail.com
> 
> list_del corruption, ffffea0001eb8090->next is NULL
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:53!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 UID: 0 PID: 5105 Comm: syz-executor331 Not tainted 6.10.0-rc7-next-20240709-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> RIP: 0010:__list_del_entry_valid_or_report+0xd0/0x140 lib/list_debug.c:52
> Code: 06 e2 42 fd 48 8b 13 4c 39 fa 75 6b b0 01 5b 41 5c 41 5e 41 5f c3 cc cc cc cc 48 c7 c7 a0 9b 20 8c 4c 89 fe e8 71 e0 d7 06 90 <0f> 0b 48 c7 c7 00 9c 20 8c 4c 89 fe e8 5f e0 d7 06 90 0f 0b 48 c7
> RSP: 0018:ffffc900034df410 EFLAGS: 00010046
> RAX: 0000000000000033 RBX: ffff888140e81000 RCX: f885dda17ff31200
> RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
> RBP: ffffea0001eb8090 R08: ffffffff8173a779 R09: 1ffff9200069be1c
> R10: dffffc0000000000 R11: fffff5200069be1d R12: dffffc0000000000
> R13: dffffc0000000000 R14: 0000000000000000 R15: ffffea0001eb8090
> FS:  00007fe27183f6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200d1a00 CR3: 0000000021fbe000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __list_del_entry_valid include/linux/list.h:124 [inline]
>  __list_del_entry include/linux/list.h:215 [inline]
>  list_del_init include/linux/list.h:287 [inline]
>  __folio_undo_large_rmappable+0x104/0x230 mm/huge_memory.c:3289
>  __folio_migrate_mapping+0x6c1/0x3490 mm/migrate.c:418
>  __migrate_folio mm/migrate.c:693 [inline]
>  migrate_folio+0x111/0x260 mm/migrate.c:720
>  move_to_new_folio+0x306/0x12e0
>  unmap_and_move_huge_page mm/migrate.c:1444 [inline]
>  migrate_hugetlbs mm/migrate.c:1563 [inline]
>  migrate_pages+0xb74/0x3460 mm/migrate.c:1960
>  do_mbind mm/mempolicy.c:1388 [inline]
>  kernel_mbind mm/mempolicy.c:1531 [inline]
>  __do_sys_mbind mm/mempolicy.c:1605 [inline]
>  __se_sys_mbind+0x1490/0x19f0 mm/mempolicy.c:1601
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe2718a4d39
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fe27183f208 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
> RAX: ffffffffffffffda RBX: 00007fe27192f338 RCX: 00007fe2718a4d39
> RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000000020199000
> RBP: 00007fe27192f330 R08: 0000000000000000 R09: 0000000000000003
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe2718fc604
> R13: 00007fe2718fc008 R14: 7277682f7665642f R15: 00000000ffffff1f
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__list_del_entry_valid_or_report+0xd0/0x140 lib/list_debug.c:52
> Code: 06 e2 42 fd 48 8b 13 4c 39 fa 75 6b b0 01 5b 41 5c 41 5e 41 5f c3 cc cc cc cc 48 c7 c7 a0 9b 20 8c 4c 89 fe e8 71 e0 d7 06 90 <0f> 0b 48 c7 c7 00 9c 20 8c 4c 89 fe e8 5f e0 d7 06 90 0f 0b 48 c7
> RSP: 0018:ffffc900034df410 EFLAGS: 00010046
> RAX: 0000000000000033 RBX: ffff888140e81000 RCX: f885dda17ff31200
> RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
> RBP: ffffea0001eb8090 R08: ffffffff8173a779 R09: 1ffff9200069be1c
> R10: dffffc0000000000 R11: fffff5200069be1d R12: dffffc0000000000
> R13: dffffc0000000000 R14: 0000000000000000 R15: ffffea0001eb8090
> FS:  00007fe27183f6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200d1a00 CR3: 0000000021fbe000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

#syz fix: mm/hugetlb: fix kernel NULL pointer dereference when migrating hugetlb folio

