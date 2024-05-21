Return-Path: <linux-kernel+bounces-185530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2018CB65B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6101B212CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B61149DF4;
	Tue, 21 May 2024 23:42:35 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D99475
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716334955; cv=none; b=GHrxXYIIjh130Bap1lOEvMph98hOP7xXav006Vwkha5H10Afj/AR9cSjeHfKXzM9DVTHmAXaze0nT/QaEVc5MVinlntquWHdx6iZiGqQ/gXfOtwDM/ABJ2cAGUWlbw7vLSHOfl8wKJyA00lpWZ0MJkyAMH4z/mZWISMaPm27aPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716334955; c=relaxed/simple;
	bh=HZhmePRTKTHrYpZPjBn6d7/6xh/WygoeEVn68YOyzic=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hrpxSOfC/l6hA8KCg/9eDT28C06qE4GXb0josLvh2VwUFo810Q9Fdw4KiCAKFwWi2VEETM3m/K5ptaAY4uh3V60cJfGch8AV5Ve2TklUxEURVXvccLoRbl4cpo1RGrI/sEl5O3iFgwV3vxPt8UJxmbEUtpRpq99PWdqk9lhJY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1fe2ba2e1so936683639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716334953; x=1716939753;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25Dd6Na6+eHGBhrM7XVMQB+D9RCYmI2189ws6whiqso=;
        b=TwrfhQng8fXks91HgAajHj1LtdQLkebTzP3FjDjmpfYOWeaF05DdyihYFtF+bcTsO3
         iLOsMrX4OVhOcGCLjLfyalgGopPyQleOlUx3V5Xgse1PnzkHCdwFhFViNSFh0+17U+5q
         aYdyO4Z6m4pCVyO6PGkd6lD8AryWRL8oFXRBVmcmgIqqvtBJ3oA+T//mNUbtMV6R4yaY
         zfMnbjb/ClapilqTuRQ4A7QLVCMOi53o6+EoqIQrEU4c9LrQWPpYkSSixjfF/QwSRti/
         RkAuGfWMMk+zShkWJR+HJ1YukqIhWW9Q+9Y0/2hWNRz3AaLTAFDk9CFGRxkEVbqn2hl8
         DG9A==
X-Forwarded-Encrypted: i=1; AJvYcCXeFLPK/hODFo79X8elL2GHuKB6tzZmjbCRY96si5WTRx3CXSSpQ5e2QSKyj8RTj3wlh38YlDpXM4gy705/q/7jkZybsRRnugzRX1r4
X-Gm-Message-State: AOJu0YwNSvJBHDNSLoyJdSclgjLanz0JIZaEOLwi9PBXM970VuroY5ju
	kJpDRWIS+q0lSHvRImiz/yaYVhEXxbH++Rd0ZUwp/BXRMiUA88bxN67pyoY7CiDASlBpYwzylFw
	4bbhg+wVRgCLDUJ+cfuaoz6sGTM0VLs+qIQr4hjqBtUu6sijxx1NQoQo=
X-Google-Smtp-Source: AGHT+IFaWRqK1mJzmahkIPH+Miwd1rLQcyq+s4iziRLc6K/XXfkDajqOSBv6682mT5bSjogXlXijjbdIPzg2f/qo/b7zvJk/uSi7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1565:b0:36c:c5f4:8dd3 with SMTP id
 e9e14a558f8ab-371f910e416mr438825ab.3.1716334952835; Tue, 21 May 2024
 16:42:32 -0700 (PDT)
Date: Tue, 21 May 2024 16:42:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002dfd6e0618ff5f9f@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in ntfs_file_release
From: syzbot <syzbot+b14d0f52a28b512d7b94@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ff2632d7d08e Merge tag 'powerpc-6.10-1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16839adc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1cd4092753f97c5
dashboard link: https://syzkaller.appspot.com/bug?extid=b14d0f52a28b512d7b94
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bfc388454a52/disk-ff2632d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/da1638631dd4/vmlinux-ff2632d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6249354c3233/bzImage-ff2632d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b14d0f52a28b512d7b94@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-08410-gff2632d7d08e #0 Not tainted
------------------------------------------------------
syz-executor.2/24188 is trying to acquire lock:
ffff88805b815a30 (&ni->file.run_lock#3){++++}-{3:3}, at: ntfs_file_release+0x184/0x220 fs/ntfs3/file.c:1179

but task is already holding lock:
ffff88805b815980 (&ni->ni_lock#2/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1123 [inline]
ffff88805b815980 (&ni->ni_lock#2/4){+.+.}-{3:3}, at: ntfs_file_release+0x175/0x220 fs/ntfs3/file.c:1178

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ni->ni_lock#2/4){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       ni_lock fs/ntfs3/ntfs_fs.h:1123 [inline]
       ntfs_fallocate+0x9af/0x1120 fs/ntfs3/file.c:556
       vfs_fallocate+0x4b8/0xf70 fs/open.c:330
       ksys_fallocate fs/open.c:353 [inline]
       __do_sys_fallocate fs/open.c:361 [inline]
       __se_sys_fallocate fs/open.c:359 [inline]
       __x64_sys_fallocate+0xd5/0x140 fs/open.c:359
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (mapping.invalidate_lock#9){++++}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       filemap_invalidate_lock_shared include/linux/fs.h:846 [inline]
       filemap_fault+0x275/0x2630 mm/filemap.c:3277
       __do_fault+0x10a/0x490 mm/memory.c:4526
       do_shared_fault mm/memory.c:4949 [inline]
       do_fault mm/memory.c:5023 [inline]
       do_pte_missing mm/memory.c:3875 [inline]
       handle_pte_fault mm/memory.c:5295 [inline]
       __handle_mm_fault+0x3148/0x4a80 mm/memory.c:5436
       handle_mm_fault+0x476/0xa00 mm/memory.c:5601
       do_user_addr_fault+0x2e5/0x1010 arch/x86/mm/fault.c:1383
       handle_page_fault arch/x86/mm/fault.c:1475 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1533
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       filldir+0x28c/0x5e0 fs/readdir.c:293
       dir_emit_dot include/linux/fs.h:3592 [inline]
       dir_emit_dots include/linux/fs.h:3603 [inline]
       ntfs_readdir+0x851/0x1090 fs/ntfs3/dir.c:414
       iterate_dir+0x292/0x9e0 fs/readdir.c:110
       __do_sys_getdents fs/readdir.c:326 [inline]
       __se_sys_getdents fs/readdir.c:311 [inline]
       __x64_sys_getdents+0x14f/0x2d0 fs/readdir.c:311
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       __might_fault mm/memory.c:6215 [inline]
       __might_fault+0x11b/0x190 mm/memory.c:6208
       _copy_to_user+0x2b/0xc0 lib/usercopy.c:36
       copy_to_user include/linux/uaccess.h:191 [inline]
       fiemap_fill_next_extent+0x232/0x390 fs/ioctl.c:145
       ni_fiemap+0x444/0xc10 fs/ntfs3/frecord.c:2065
       ntfs_fiemap+0xc9/0x120 fs/ntfs3/file.c:1206
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x404/0x1ad0 fs/ioctl.c:838
       __do_sys_ioctl fs/ioctl.c:902 [inline]
       __se_sys_ioctl fs/ioctl.c:890 [inline]
       __x64_sys_ioctl+0x116/0x220 fs/ioctl.c:890
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ni->file.run_lock#3){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       ntfs_file_release+0x184/0x220 fs/ntfs3/file.c:1179
       __fput+0x270/0xb80 fs/file_table.c:422
       task_work_run+0x14e/0x250 kernel/task_work.c:180
       exit_task_work include/linux/task_work.h:38 [inline]
       do_exit+0xa7d/0x2c10 kernel/exit.c:878
       do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
       __do_sys_exit_group kernel/exit.c:1038 [inline]
       __se_sys_exit_group kernel/exit.c:1036 [inline]
       __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  
&ni->file.run_lock#3 --> mapping.invalidate_lock#9 --> &ni->ni_lock#2
/4

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->ni_lock
#2/4);
                               lock(mapping.invalidate_lock#9);
                               lock(&ni->ni_lock#2/4);
  lock(&ni->file.run_lock#3);

 *** DEADLOCK ***

1 lock held by syz-executor.2/24188:
 #0: ffff88805b815980 (&ni->ni_lock#2/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1123 [inline]
 #0: ffff88805b815980 (&ni->ni_lock#2/4){+.+.}-{3:3}, at: ntfs_file_release+0x175/0x220 fs/ntfs3/file.c:1178

stack backtrace:
CPU: 1 PID: 24188 Comm: syz-executor.2 Not tainted 6.9.0-syzkaller-08410-gff2632d7d08e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
 ntfs_file_release+0x184/0x220 fs/ntfs3/file.c:1179
 __fput+0x270/0xb80 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa7d/0x2c10 kernel/exit.c:878
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb36fa7cee9
Code: Unable to access opcode bytes at 0x7fb36fa7cebf.
RSP: 002b:00007ffe2fc5daf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00007fb36fa7cee9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 00007fb36fa00000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

