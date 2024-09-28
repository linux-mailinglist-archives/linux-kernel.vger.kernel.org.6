Return-Path: <linux-kernel+bounces-342382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9AA988E46
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 09:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B57280C55
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 07:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E66319DFB5;
	Sat, 28 Sep 2024 07:43:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1596D19DF8B
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727509410; cv=none; b=o6ZyAWn8aV3PUJwuaTbypAu91B2i5una4xyiuiqNJ4RLo72HK9+RodbbHb7MM/x6843waKi5SCkboiIHbsCOM6S2f+rvSDOn61sfA0vgd4ELx3ZEJ6rW8EeM+1M+TnEASM+3U1iO/b8qeIlDuSUGAJkMfLgQo1J/+RvcF5UiLXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727509410; c=relaxed/simple;
	bh=fk9gG4gQalEMc0N1bhMZCxxE0ByNLA57AB45kz8KLdc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lmGcYEYd9DpoRX4QBN2n9BMp/tvGscDS/7UIH4aPFGUlJHYbr9BCzT7UmsgIt37YQOX7dJFAre58I57sG8n+sSO59FGcN+0z3G7+eSW87Dhe5sUUWkPjJ1krlIxbL8ey5BVVJi5n/HVdznKHwA1wr2R3eRmnEqyxJIq/JFW4Meo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3479460f4so15762145ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 00:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727509408; x=1728114208;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HtGmfFQ4rTZm4/FqmOVqkSPdMe1H411qdUEqUKengqw=;
        b=BJa2jsOHMI3io7yjWxxg/Iw4ezldXriv3eO5W/ljlgOK3Cef5BJ6wW6T0hynwTg3xy
         vEaby+5eJ6wNEMr8DzF57OKunln1wf2hhfHlBae76GYvESQ3xjcdhXXTaf45ltYBPCpP
         Ki+dF4clwPN4/P2eIU9NYhP+F3Kx2kS6Y5aSWLXEGlQ1+wTryYrAFBMAPuKI0EQtEleM
         ZyujLsqZMzaMzghhSnMbMQD5iSi0Vzvi7v+IH5qhqxxoZGgjLQGD55WO5+i4d1R3pYKM
         7RkrHiAFHaQeWB7bGUySPBRotQWUzNV9dnkGvUaMvnLLn1K9ggSf+7yDUYTBYDFqaKAy
         hX4w==
X-Forwarded-Encrypted: i=1; AJvYcCVY8x097t0CIJV0uOsGBBeRZHb5zXqFPY0664hd0AGvCwYXzJry66R18ZiC3mWrSp3wXfbj4Nf0MLS940Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2/eBVhH/zH+LQiJeFbs86IXy3KieIJ2b0p8tq1gfYi1DZ/l0
	dolpYvY/ZEIwqZhQLuDjAbK3AfdreQLjuWBUDzMigSxAtOPRjbZAfPiw3Vu4jnrFr0yRwksMSBb
	t4c/4/7+ZfAoBMVRzHRmB+hyYyvOScr4Nd3N5uN4Mup5SLH9F6qceWIY=
X-Google-Smtp-Source: AGHT+IFcWue9Y2GaKT1PfcYdcnRS4BLO1UvY+S4vT1eBKqjRYvcV2dDYezsfqK+slYAThKXzQ+pbb+6BXCHzQYhgnGTxiu8fKW9H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4c:0:b0:3a3:449b:5989 with SMTP id
 e9e14a558f8ab-3a3452ba439mr49601785ab.21.1727509408212; Sat, 28 Sep 2024
 00:43:28 -0700 (PDT)
Date: Sat, 28 Sep 2024 00:43:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f7b3a0.050a0220.46d20.0038.GAE@google.com>
Subject: [syzbot] [mm?] possible deadlock in shmem_file_write_iter
From: syzbot <syzbot+288aa6838b3263f52e7e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e477dba5442c Merge tag 'for-6.12/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102ade27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=288aa6838b3263f52e7e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be1e82b0133d/disk-e477dba5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8d9e4b1a6733/vmlinux-e477dba5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b79025eddfb1/bzImage-e477dba5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+288aa6838b3263f52e7e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-syzkaller-11624-ge477dba5442c #0 Not tainted
------------------------------------------------------
syz.2.1702/9983 is trying to acquire lock:
ffff888028091e18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153

but task is already holding lock:
ffff888077ef3708 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
ffff888077ef3708 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: shmem_file_write_iter+0x80/0x120 mm/shmem.c:3211

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:815 [inline]
       process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
       ima_file_mmap+0x13d/0x2b0 security/integrity/ima/ima_main.c:455
       security_mmap_file+0x7e7/0xa40 security/security.c:2977
       __do_sys_remap_file_pages mm/mmap.c:1692 [inline]
       __se_sys_remap_file_pages+0x6e6/0xa50 mm/mmap.c:1624
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3158 [inline]
       check_prevs_add kernel/locking/lockdep.c:3277 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       down_read_killable+0xca/0xd30 kernel/locking/rwsem.c:1549
       mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153
       get_mmap_lock_carefully mm/memory.c:6108 [inline]
       lock_mm_and_find_vma+0x29c/0x2f0 mm/memory.c:6159
       do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       fault_in_readable+0x165/0x2b0
       fault_in_iov_iter_readable+0x229/0x280 lib/iov_iter.c:94
       generic_perform_write+0x259/0x6d0 mm/filemap.c:4040
       shmem_file_write_iter+0xf9/0x120 mm/shmem.c:3221
       new_sync_write fs/read_write.c:590 [inline]
       vfs_write+0xa6f/0xc90 fs/read_write.c:683
       ksys_write+0x183/0x2b0 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#12);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#12);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

3 locks held by syz.2.1702/9983:
 #0: ffff888054784478 (&f->f_pos_lock){+.+.}-{3:3}, at: fdget_pos+0x24e/0x320 fs/file.c:1187
 #1: ffff88814a584420 (sb_writers#5){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #1: ffff88814a584420 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #2: ffff888077ef3708 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #2: ffff888077ef3708 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: shmem_file_write_iter+0x80/0x120 mm/shmem.c:3211

stack backtrace:
CPU: 1 UID: 0 PID: 9983 Comm: syz.2.1702 Not tainted 6.11.0-syzkaller-11624-ge477dba5442c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2203
 check_prev_add kernel/locking/lockdep.c:3158 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 down_read_killable+0xca/0xd30 kernel/locking/rwsem.c:1549
 mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153
 get_mmap_lock_carefully mm/memory.c:6108 [inline]
 lock_mm_and_find_vma+0x29c/0x2f0 mm/memory.c:6159
 do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:fault_in_readable+0x165/0x2b0 mm/gup.c:2235
Code: b3 ff 4c 8d b3 ff 0f 00 00 48 89 d8 4d 01 e6 49 81 e6 00 f0 ff ff 49 39 c6 72 6b e8 f5 c8 b3 ff 4c 39 f3 74 6e 4c 89 64 24 10 <44> 8a 23 43 0f b6 04 2f 84 c0 75 18 44 88 64 24 40 48 81 c3 00 10
RSP: 0018:ffffc900045c7a40 EFLAGS: 00050283
RAX: ffffffff81e0eba7 RBX: 00000000201e1000 RCX: 0000000000040000
RDX: ffffc9001ddf8000 RSI: 000000000000bffd RDI: 000000000000bffe
RBP: ffffc900045c7af8 R08: ffffffff81e0eb18 R09: ffffffff84b912a9
R10: 0000000000000002 R11: ffff888025213c00 R12: 0000000000200000
R13: dffffc0000000000 R14: 0000000020201000 R15: 1ffff920008b8f50
 fault_in_iov_iter_readable+0x229/0x280 lib/iov_iter.c:94
 generic_perform_write+0x259/0x6d0 mm/filemap.c:4040
 shmem_file_write_iter+0xf9/0x120 mm/shmem.c:3221
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6f/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbca257df39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbca3459038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fbca2735f80 RCX: 00007fbca257df39
RDX: 000000000208e24b RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007fbca25f0216 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbca2735f80 R15: 00007ffd5bf037c8
 </TASK>
----------------
Code disassembly (best guess):
   0:	b3 ff                	mov    $0xff,%bl
   2:	4c 8d b3 ff 0f 00 00 	lea    0xfff(%rbx),%r14
   9:	48 89 d8             	mov    %rbx,%rax
   c:	4d 01 e6             	add    %r12,%r14
   f:	49 81 e6 00 f0 ff ff 	and    $0xfffffffffffff000,%r14
  16:	49 39 c6             	cmp    %rax,%r14
  19:	72 6b                	jb     0x86
  1b:	e8 f5 c8 b3 ff       	call   0xffb3c915
  20:	4c 39 f3             	cmp    %r14,%rbx
  23:	74 6e                	je     0x93
  25:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
* 2a:	44 8a 23             	mov    (%rbx),%r12b <-- trapping instruction
  2d:	43 0f b6 04 2f       	movzbl (%r15,%r13,1),%eax
  32:	84 c0                	test   %al,%al
  34:	75 18                	jne    0x4e
  36:	44 88 64 24 40       	mov    %r12b,0x40(%rsp)
  3b:	48                   	rex.W
  3c:	81                   	.byte 0x81
  3d:	c3                   	ret
  3e:	00 10                	add    %dl,(%rax)


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

