Return-Path: <linux-kernel+bounces-411966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F7F9D01D0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 02:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61A6284E38
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 01:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80809B652;
	Sun, 17 Nov 2024 01:25:26 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B866137E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731806726; cv=none; b=lHAVTRqk/gch+x12UCiMQ8uoZJ6mj872nI/8GD0D0HAH9xgocR4U3ZMxGOxWD5hWOx7jcN6cIW8LPmy1ciJ+0eofwkXCxTB/eAY7RHJw+0nl2AQU7Bbj66s/18Jq3XCErJLO1PhirOa03fnwHQeVc7n2XBeL3uhWrMHefw5uLx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731806726; c=relaxed/simple;
	bh=gtPVxxPW4PoI21b3gdNjKoJz+BVY9CMj1xfqOAcx6N8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WkLzEYo5M+XWliSm7eLsRLG5KfyCgwTZW1QiY+RUrkwkb6rcjTqp2TAEwRyUHTEriJh3Y2JQS5T90a22AIIKM/krry+B+ZBYujBYwv6pZkVtZ0UnOJ/NA1RrScRpzhsk3Bog75rk7DpALYzgBQJXUmkq0mM0HSzNAa0fAUWszl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abb2b6d42so199851439f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 17:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731806723; x=1732411523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1ga9Foh74NctgQmJhdZFj8i06xTH41lukCFxYSYprM=;
        b=qM6cKWC+AAUpiGiWMEDc9/dfNmBmOYjIZpvQlxIR/ZLOg7N6gw6hTWS6ltbiKmABVY
         faAi/9SOj//qsOrKrooSwy/KwUpEY2o9M9ssx6yrPl18993g6lytDD+uHHAQNpJySi55
         jCKy0oZDYNhMd5U5qXQHVD9vKnI31J0npsdy9sGitSQRwI7H5Fo5iKPny9vTmrw8N1Tk
         h7oII6AiAGU8rB1LXaSIZUv/9AGrZheWxYXFWoYNc2oilEKNVZiY2dlxImiU4SRr0bFE
         JHhOiiKXbA8yP690zzROX2/GpHGZHGJ6RG0b2RM9GkRcpQCp1HywaXWHqTsRfX+JjSIw
         DbJA==
X-Forwarded-Encrypted: i=1; AJvYcCW3remVLaXLbGSPq5EA78ZEY/7WuBHTiYoW8QS0XOHmWEPfnU9aQqiMtOFoyfRLJFGhJOLiv5uz2ThNdbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2qdYLD4ph/bFqiILxRUxMg1NBG9Z8pHv03gMEkfia7WyLHfel
	1OE3lXYnSnk8ZoK3JFkF5MudP+8TP9aYQv+hrjt07GdPe+FBDyMyw9wsvO3dLrPdMcxFJ6L42tG
	4prUIOiPfNLKufayse4Ma+EuKv4qBcIMNMRVs6rhYAGksm0ybzOCor+Q=
X-Google-Smtp-Source: AGHT+IFtiUrLXO7vesCVY4cJj4AioE4fjzZwhL0G4PlI05cb3OWi6E0rbbSZDcMUVNJP+OwFVXl4+/GOgrtapriEiYdamKeZtyos
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:3a7:1e4b:f32d with SMTP id
 e9e14a558f8ab-3a748079ecbmr74476985ab.17.1731806723647; Sat, 16 Nov 2024
 17:25:23 -0800 (PST)
Date: Sat, 16 Nov 2024 17:25:23 -0800
In-Reply-To: <00000000000093a1ca0621e8d336@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67394603.050a0220.e1c64.000e.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_page_mkwrite
From: syzbot <syzbot+2e6495950edcf7fbfccf@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b5a24181e461 Merge tag 'trace-ringbuffer-v6.12-rc7-2' of g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14ecd2c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=2e6495950edcf7fbfccf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f252e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ecd2c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/048c0136cb21/disk-b5a24181.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5667b33e03d5/vmlinux-b5a24181.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1413f6952b55/bzImage-b5a24181.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/2e0d55b52167/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/82e694655642/mount_7.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e6495950edcf7fbfccf@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc7-syzkaller-00192-gb5a24181e461 #0 Not tainted
------------------------------------------------------
syz-executor420/5970 is trying to acquire lock:
ffff88807839b120 (&ocfs2_file_ip_alloc_sem_key){++++}-{3:3}, at: ocfs2_page_mkwrite+0x346/0xed0 fs/ocfs2/mmap.c:142

but task is already holding lock:
ffff88807c820518 (sb_pagefaults){.+.+}-{0:0}, at: do_page_mkwrite+0x198/0x480 mm/memory.c:3162

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_pagefaults){.+.+}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1716 [inline]
       sb_start_pagefault include/linux/fs.h:1881 [inline]
       ocfs2_page_mkwrite+0x222/0xed0 fs/ocfs2/mmap.c:122
       do_page_mkwrite+0x198/0x480 mm/memory.c:3162
       do_shared_fault mm/memory.c:5373 [inline]
       do_fault mm/memory.c:5435 [inline]
       do_pte_missing mm/memory.c:3965 [inline]
       handle_pte_fault+0x11fa/0x6820 mm/memory.c:5766
       __handle_mm_fault mm/memory.c:5909 [inline]
       handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6077
       do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __might_fault+0xc6/0x120 mm/memory.c:6716
       _inline_copy_to_user include/linux/uaccess.h:192 [inline]
       _copy_to_user+0x2c/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:225 [inline]
       fiemap_fill_next_extent+0x235/0x410 fs/ioctl.c:145
       ocfs2_fiemap_inline fs/ocfs2/extent_map.c:725 [inline]
       ocfs2_fiemap+0xc25/0xf80 fs/ocfs2/extent_map.c:762
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1bf8/0x2e40 fs/ioctl.c:841
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ocfs2_file_ip_alloc_sem_key){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       ocfs2_page_mkwrite+0x346/0xed0 fs/ocfs2/mmap.c:142
       do_page_mkwrite+0x198/0x480 mm/memory.c:3162
       do_shared_fault mm/memory.c:5373 [inline]
       do_fault mm/memory.c:5435 [inline]
       do_pte_missing mm/memory.c:3965 [inline]
       handle_pte_fault+0x11fa/0x6820 mm/memory.c:5766
       __handle_mm_fault mm/memory.c:5909 [inline]
       handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6077
       do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

other info that might help us debug this:

Chain exists of:
  &ocfs2_file_ip_alloc_sem_key --> &mm->mmap_lock --> sb_pagefaults

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_pagefaults);
                               lock(&mm->mmap_lock);
                               lock(sb_pagefaults);
  lock(&ocfs2_file_ip_alloc_sem_key);

 *** DEADLOCK ***

2 locks held by syz-executor420/5970:
 #0: ffff8880303d8198 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 #0: ffff8880303d8198 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:6114 [inline]
 #0: ffff8880303d8198 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x32/0x2f0 mm/memory.c:6174
 #1: ffff88807c820518 (sb_pagefaults){.+.+}-{0:0}, at: do_page_mkwrite+0x198/0x480 mm/memory.c:3162

stack backtrace:
CPU: 1 UID: 0 PID: 5970 Comm: syz-executor420 Not tainted 6.12.0-rc7-syzkaller-00192-gb5a24181e461 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 down_write+0x99/0x220 kernel/locking/rwsem.c:1577
 ocfs2_page_mkwrite+0x346/0xed0 fs/ocfs2/mmap.c:142
 do_page_mkwrite+0x198/0x480 mm/memory.c:3162
 do_shared_fault mm/memory.c:5373 [inline]
 do_fault mm/memory.c:5435 [inline]
 do_pte_missing mm/memory.c:3965 [inline]
 handle_pte_fault+0x11fa/0x6820 mm/memory.c:5766
 __handle_mm_fault mm/memory.c:5909 [inline]
 handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6077
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f47ff734108
Code: 48 8b 35 23 50 0b 00 ba 01 cf 20 00 31 c0 bf 4d 00 00 00 e8 5a 46 03 00 66 0f 6f 05 f2 66 08 00 48 b8 2e 2f 66 69 6c 65 31 00 <c7> 04 25 c0 01 00 20 74 72 65 65 48 89 04 25 00 00 00 20 ba 03 00
RSP: 002b:00007ffdcacffc30 EFLAGS: 00010217
RAX: 0031656c69662f2e RBX: 696c6e695f78616d RCX: 00007f47ff768769
RDX: 00007f47ff768769 RSI: 000000000020cf01 RDI: 0000000000000006
RBP: 6569727261626f6e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000246 R12: 00007ffdcacffc5c
R13: 000000000000002d R14: 431bde82d7b634db R15: 00007ffdcacffc90
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

