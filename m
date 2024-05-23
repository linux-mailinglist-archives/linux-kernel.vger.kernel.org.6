Return-Path: <linux-kernel+bounces-187557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6611B8CD398
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39DE28182C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD6414A636;
	Thu, 23 May 2024 13:16:38 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E9D1D52D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470197; cv=none; b=JoUjRW6a6AX9/3Txlm/KqgTmS6KnMobdR3gTipdfC85fw2NqoTAkmMRKElzt8HIB0+N9wzPUul2oEIMV6ZyJW6MsUojEF5JPHV7Ap7Fsb6R5d2AvPgTH0L7zhBxPCEnkDETxe20jyjizPi9QFVjVQFdlnkuqk8cysGFTsPAUxIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470197; c=relaxed/simple;
	bh=SzDyxlsy6HQh6xXquatY7ggVUX2Hh6F67puHdtF74G0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IZnmSUYHOon/LoNyceNW96uvpD74UAWunxKYWHWeMkYOItuwshYtXmBbAU/p3h+cf9tmqi3NDXmlDvhsWO8Pi/0IwlzT5OFE6n1I5XQf7+w53DV5Pm7Mtt9HJeTeKw9/joPwn0tTwCK8WV+d4JN0Fpmuy0lN792n0Ij/Qp/PgaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-37375e83ee8so7219405ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716470195; x=1717074995;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/b1QSHj/oNmJ37ZzSgaNh87XtgqxRB2+ruSPN5K7G4=;
        b=g0eSA1arVyalPpXytyp975nO6tKUFgv04mb6VGKG9NIKydXSM84Ob6sSn5qqv6yZhN
         eDsUg7Q5UggoR1qHPa3b78Fcvx1q6u7b3fuvjhv1YYk3Z1UIbwLwVo5U2e4wWm1Q2j1k
         COYk3+5RDdYCUUDsHY0fIq0JnBjYZh4h79wBAT4Mi4H40EOvKP4vXd8OHHZxglZy5xNz
         79jvhjmhAXmi7+P2RYcWJ1BTnV60CZUtxtpTB9p/ZmKP6ME7E0RWFryD3K+DjCjrnZp5
         9Ma0QQBEYa/GsW8dWmUZwBRk/ez/DBfxSxVg6svR6Wz1BI4sJvSTiWYP/pgF2cqzua42
         dWzw==
X-Forwarded-Encrypted: i=1; AJvYcCW8Zsk9q/HCvL8m9yBH0jGjCGtOlqA4fXJR0No4CVWsPz9imlvnKkCtMBF9HQQ2z7xxwYX69OwKJ8l06AAsnLB8JUlVQnmFaHhwRdO8
X-Gm-Message-State: AOJu0YyYOhIKc+nEWmdla088HF+nqGdtYyIR7LVm/WruQBAeCVbxTlSs
	ok2SIWCeytWEolKp+F5JIgAtdleov14isvmvMkF302/9MIwMmXx66fIWUpJAO6M3pFgnqzGaUCa
	Wyp6W29IqQ44/ftWzsjk8iKsVosDilkJBqQdMOe361l4sQNeWytSAyW0=
X-Google-Smtp-Source: AGHT+IGQO6esXJ2/nFmhMbmVrQW3xdbSadjUejkzQBkIG3Ta384OgrwGM8C27QP8Y1uhinS5X5gzMj47yxGvVmwHI4QYa8mWmMNM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c21:b0:36c:5228:462 with SMTP id
 e9e14a558f8ab-371fc6e2dd8mr3530905ab.3.1716470194838; Thu, 23 May 2024
 06:16:34 -0700 (PDT)
Date: Thu, 23 May 2024 06:16:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b35a206191edc5b@google.com>
Subject: [syzbot] [udf?] possible deadlock in mempool_alloc
From: syzbot <syzbot+643b5ab661c7d54b7c84@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0450d2083be6 Merge tag '6.10-rc-smb-fix' of git://git.samb..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11281592980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11eee78d9c5171fd
dashboard link: https://syzkaller.appspot.com/bug?extid=643b5ab661c7d54b7c84
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-0450d208.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/93488b2dd484/vmlinux-0450d208.xz
kernel image: https://storage.googleapis.com/syzbot-assets/86e4c49ad04d/bzImage-0450d208.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+643b5ab661c7d54b7c84@syzkaller.appspotmail.com

Buffer I/O error on dev loop1, logical block 1434, async page read
Buffer I/O error on dev loop1, logical block 1435, async page read
======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-08995-g0450d2083be6 #0 Not tainted
------------------------------------------------------
syz-executor.1/22245 is trying to acquire lock:
ffffffff8dd3a8c0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:312 [inline]
ffffffff8dd3a8c0 (fs_reclaim){+.+.}-{0:0}, at: mempool_alloc+0xd9/0x390 mm/mempool.c:398

but task is already holding lock:
ffff888068818448 (mapping.invalidate_lock#11){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:846 [inline]
ffff888068818448 (mapping.invalidate_lock#11){++++}-{3:3}, at: filemap_fault+0x5cb/0x2630 mm/filemap.c:3296

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (mapping.invalidate_lock#11){++++}-{3:3}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       filemap_invalidate_lock include/linux/fs.h:836 [inline]
       udf_setsize+0x256/0x1180 fs/udf/inode.c:1254
       udf_evict_inode+0x361/0x590 fs/udf/inode.c:144
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4774
       shrink_many mm/vmscan.c:4835 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
       shrink_node mm/vmscan.c:5894 [inline]
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       mempool_alloc+0xd9/0x390 mm/mempool.c:398
       bio_alloc_bioset+0x480/0x8b0 block/bio.c:554
       bio_alloc include/linux/bio.h:437 [inline]
       do_mpage_readpage+0xf30/0x17c0 fs/mpage.c:297
       mpage_read_folio+0xa9/0x140 fs/mpage.c:399
       udf_read_folio+0x8b/0xe0 fs/udf/inode.c:235
       filemap_read_folio+0xe5/0x2c0 mm/filemap.c:2331
       filemap_fault+0x1458/0x2630 mm/filemap.c:3381
       __do_fault+0x10a/0x490 mm/memory.c:4526
       do_read_fault mm/memory.c:4889 [inline]
       do_fault mm/memory.c:5019 [inline]
       do_pte_missing mm/memory.c:3875 [inline]
       handle_pte_fault mm/memory.c:5295 [inline]
       __handle_mm_fault+0x371d/0x4a80 mm/memory.c:5436
       handle_mm_fault+0x476/0xa00 mm/memory.c:5601
       do_user_addr_fault+0x2e5/0x1010 arch/x86/mm/fault.c:1383
       handle_page_fault arch/x86/mm/fault.c:1475 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1533
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
       raw_copy_from_user arch/x86/include/asm/uaccess_64.h:125 [inline]
       _copy_from_user+0xc1/0xf0 lib/usercopy.c:23
       copy_from_user include/linux/uaccess.h:183 [inline]
       copy_from_bpfptr_offset include/linux/bpfptr.h:53 [inline]
       copy_from_bpfptr include/linux/bpfptr.h:59 [inline]
       __sys_bpf+0x22b/0x58f0 kernel/bpf/syscall.c:5660
       __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
       __ia32_sys_bpf+0x76/0xe0 kernel/bpf/syscall.c:5792
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(mapping.invalidate_lock#11);
                               lock(fs_reclaim);
                               lock(mapping.invalidate_lock#11);
  lock(fs_reclaim);

 *** DEADLOCK ***

1 lock held by syz-executor.1/22245:
 #0: ffff888068818448 (mapping.invalidate_lock#11){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:846 [inline]
 #0: ffff888068818448 (mapping.invalidate_lock#11){++++}-{3:3}, at: filemap_fault+0x5cb/0x2630 mm/filemap.c:3296

stack backtrace:
CPU: 3 PID: 22245 Comm: syz-executor.1 Not tainted 6.9.0-syzkaller-08995-g0450d2083be6 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
 fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
 might_alloc include/linux/sched/mm.h:312 [inline]
 mempool_alloc+0xd9/0x390 mm/mempool.c:398
 bio_alloc_bioset+0x480/0x8b0 block/bio.c:554
 bio_alloc include/linux/bio.h:437 [inline]
 do_mpage_readpage+0xf30/0x17c0 fs/mpage.c:297
 mpage_read_folio+0xa9/0x140 fs/mpage.c:399
 udf_read_folio+0x8b/0xe0 fs/udf/inode.c:235
 filemap_read_folio+0xe5/0x2c0 mm/filemap.c:2331
 filemap_fault+0x1458/0x2630 mm/filemap.c:3381
 __do_fault+0x10a/0x490 mm/memory.c:4526
 do_read_fault mm/memory.c:4889 [inline]
 do_fault mm/memory.c:5019 [inline]
 do_pte_missing mm/memory.c:3875 [inline]
 handle_pte_fault mm/memory.c:5295 [inline]
 __handle_mm_fault+0x371d/0x4a80 mm/memory.c:5436
 handle_mm_fault+0x476/0xa00 mm/memory.c:5601
 do_user_addr_fault+0x2e5/0x1010 arch/x86/mm/fault.c:1383
 handle_page_fault arch/x86/mm/fault.c:1475 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1533
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
RIP: 0010:raw_copy_from_user arch/x86/include/asm/uaccess_64.h:125 [inline]
RIP: 0010:_copy_from_user+0xc1/0xf0 lib/usercopy.c:23
Code: 89 df e8 f2 ea 0e fd 4d 85 f6 75 9e e8 98 f0 0e fd 0f ae e8 89 ee 4c 89 ef e8 2b 33 6c fd 0f 01 cb 48 89 e9 4c 89 ef 48 89 de <f3> a4 0f 1f 00 48 89 cb 0f 01 ca e9 73 ff ff ff e8 6a f0 0e fd 48
RSP: 0018:ffffc9000425fc10 EFLAGS: 00050246
RAX: 0000000000000001 RBX: 0000000020000540 RCX: 0000000000000020
RDX: fffff5200084bfba RSI: 0000000020000540 RDI: ffffc9000425fdb0
RBP: 0000000000000020 R08: 0000000000000001 R09: fffff5200084bfb9
R10: ffffc9000425fdcf R11: 0000000000000000 R12: 0000000020000560
R13: ffffc9000425fdb0 R14: 0000000000000000 R15: ffffc9000425fdb0
 copy_from_user include/linux/uaccess.h:183 [inline]
 copy_from_bpfptr_offset include/linux/bpfptr.h:53 [inline]
 copy_from_bpfptr include/linux/bpfptr.h:59 [inline]
 __sys_bpf+0x22b/0x58f0 kernel/bpf/syscall.c:5660
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __ia32_sys_bpf+0x76/0xe0 kernel/bpf/syscall.c:5792
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72f9579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5eeb5ac EFLAGS: 00000292 ORIG_RAX: 0000000000000165
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000020000540
RDX: 0000000000000020 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 df                	mov    %ebx,%edi
   2:	e8 f2 ea 0e fd       	call   0xfd0eeaf9
   7:	4d 85 f6             	test   %r14,%r14
   a:	75 9e                	jne    0xffffffaa
   c:	e8 98 f0 0e fd       	call   0xfd0ef0a9
  11:	0f ae e8             	lfence
  14:	89 ee                	mov    %ebp,%esi
  16:	4c 89 ef             	mov    %r13,%rdi
  19:	e8 2b 33 6c fd       	call   0xfd6c3349
  1e:	0f 01 cb             	stac
  21:	48 89 e9             	mov    %rbp,%rcx
  24:	4c 89 ef             	mov    %r13,%rdi
  27:	48 89 de             	mov    %rbx,%rsi
* 2a:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping instruction
  2c:	0f 1f 00             	nopl   (%rax)
  2f:	48 89 cb             	mov    %rcx,%rbx
  32:	0f 01 ca             	clac
  35:	e9 73 ff ff ff       	jmp    0xffffffad
  3a:	e8 6a f0 0e fd       	call   0xfd0ef0a9
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

