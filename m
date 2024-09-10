Return-Path: <linux-kernel+bounces-322417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C30579728C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4768C1F252DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C52152E1C;
	Tue, 10 Sep 2024 05:07:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0458112E48
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944845; cv=none; b=X0DucVd6RBQ7cB/ShKo7/484GKFIDZ5Ri91weuN35OiDSC4y0ytMIJujBUkpAN1be3xm1GFpusE1l6sLFJ1zmnOt66INPjQD5pFFUVzjJC1EEJ6mFqizIQWU6/gpMkoIaL1f2CeytaU5DmukCD7UK9tuujNjEF+nEOW5+IvfDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944845; c=relaxed/simple;
	bh=7S0hJvHbgmqAAcLRKrVDTR4MAxUmyxt2GoK4gTWdgl0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EQybiWLNfLaXYnaPeBor4IvOPsljkJz/q+lVXAfKhROkMdZFDax9JD0t9Rd4zjEUGqzduP5o2pXbHP1qMnkIXdYled4YAq/pQ3g3RUgJdZnzdPLqD8AxKaTO6ApCgcSdMH9Kpkz4XFEhEFj7IHw98ezq7LICCwWZuV7gYj7Pv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cda24c462so483367739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725944843; x=1726549643;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9SXDnA9lKkNsCLkNce6CxppRr00jEciXixLlw0VSjBE=;
        b=V/XlEs6ZfEvOJT8wlUY+N/0Bto96Vd1uAtDqZAvJBadnbqkbr3KNCaAhliRNKH+p+S
         yzvaGaTmcKL9JYi4YDFSenI2Pm5K3+jxnC2RoDNwfmMdlBr/oPlJKmIN4skPMy262MXC
         ElJ9XOJjfGewPAvnz7vLZI8aN0GKLyyocu+hG4LEtk40cfcQaDf+7+2npdXoEBrIBuli
         aw+OMpqv9WmD2GqavP+EqUIA//z9xWyRIdvrPSU42hAZXZR4ASwm9m5ziM2TukXq+ZDx
         o2oWQub5L0HMJqUvEFmH2NwJaZ3Ru/uykzLQEin6t6CFMavPzf2kIhpNLKGNmuqv3OcI
         etdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuybXc090q3Dh4DRHxwA1NbGWsqR9W7hXtAGwMW2jD2ruWc/Bzli8OSroTv5utKa88+eKT0MSOrQePCzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEooMXFGfY82AUWC+v+5q8T5ufN5LX37XwJYRoiP7uaMTOxiVB
	j5lKOe6v58dj5AP25K8b0O+rNe5AUGEYN1LScwe10aVkc8YbmWh7l6t3kf1BomQ7iJN49jrUqr/
	2io+pTx1ntNCQZaiQDpwSHN2i1kVvmkDv9k4kdObj6ignNFuIQiwweJo=
X-Google-Smtp-Source: AGHT+IEwpDfwB6ArkQjelJh8a31HAPBFZgJF9m4oZsj7M+t8s5OCZmA+7WhhFRFy6+E8g2vE6COrRNFzow29zYnFeZcZ5NzRb6ra
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6303:b0:82a:a998:ebab with SMTP id
 ca18e2360f4ac-82aa998f645mr931223739f.11.1725944843110; Mon, 09 Sep 2024
 22:07:23 -0700 (PDT)
Date: Mon, 09 Sep 2024 22:07:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000469efa0621bcd98a@google.com>
Subject: [syzbot] [ocfs2?] possible deadlock in ocfs2_xattr_set
From: syzbot <syzbot+ba9a789bd1f4d21fcefe@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b831f83e40a2 Merge tag 'bpf-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a2affb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=ba9a789bd1f4d21fcefe
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-b831f83e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab02bf22935d/vmlinux-b831f83e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1101078451d/bzImage-b831f83e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba9a789bd1f4d21fcefe@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc6-syzkaller-00183-gb831f83e40a2 #0 Not tainted
------------------------------------------------------
syz.0.0/5118 is trying to acquire lock:
ffff88803f583480 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:800 [inline]
ffff88803f583480 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{3:3}, at: ocfs2_xattr_set+0xe9e/0x1930 fs/ocfs2/xattr.c:3623

but task is already holding lock:
ffff88803f584e38 (&oi->ip_xattr_sem){++++}-{3:3}, at: ocfs2_xattr_set+0x633/0x1930 fs/ocfs2/xattr.c:3584

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&oi->ip_xattr_sem){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       ocfs2_init_acl+0x397/0x930 fs/ocfs2/acl.c:366
       ocfs2_mknod+0x1c05/0x2b40 fs/ocfs2/namei.c:408
       ocfs2_create+0x1ab/0x480 fs/ocfs2/namei.c:672
       lookup_open fs/namei.c:3578 [inline]
       open_last_lookups fs/namei.c:3647 [inline]
       path_openat+0x1a9a/0x3470 fs/namei.c:3883
       do_filp_open+0x235/0x490 fs/namei.c:3913
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
       do_sys_open fs/open.c:1431 [inline]
       __do_sys_openat fs/open.c:1447 [inline]
       __se_sys_openat fs/open.c:1442 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (jbd2_handle){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       start_this_handle+0x1eb4/0x2110 fs/jbd2/transaction.c:448
       jbd2__journal_start+0x2da/0x5d0 fs/jbd2/transaction.c:505
       jbd2_journal_start+0x29/0x40 fs/jbd2/transaction.c:544
       ocfs2_start_trans+0x3c9/0x700 fs/ocfs2/journal.c:352
       ocfs2_mknod+0x150c/0x2b40 fs/ocfs2/namei.c:359
       ocfs2_create+0x1ab/0x480 fs/ocfs2/namei.c:672
       lookup_open fs/namei.c:3578 [inline]
       open_last_lookups fs/namei.c:3647 [inline]
       path_openat+0x1a9a/0x3470 fs/namei.c:3883
       do_filp_open+0x235/0x490 fs/namei.c:3913
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
       do_sys_open fs/open.c:1431 [inline]
       __do_sys_openat fs/open.c:1447 [inline]
       __se_sys_openat fs/open.c:1442 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&journal->j_trans_barrier){.+.+}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       ocfs2_start_trans+0x3be/0x700 fs/ocfs2/journal.c:350
       ocfs2_mknod+0x150c/0x2b40 fs/ocfs2/namei.c:359
       ocfs2_create+0x1ab/0x480 fs/ocfs2/namei.c:672
       lookup_open fs/namei.c:3578 [inline]
       open_last_lookups fs/namei.c:3647 [inline]
       path_openat+0x1a9a/0x3470 fs/namei.c:3883
       do_filp_open+0x235/0x490 fs/namei.c:3913
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
       do_sys_open fs/open.c:1431 [inline]
       __do_sys_openat fs/open.c:1447 [inline]
       __se_sys_openat fs/open.c:1442 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (sb_internal#2){.+.+}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1676 [inline]
       sb_start_intwrite include/linux/fs.h:1859 [inline]
       ocfs2_start_trans+0x2b9/0x700 fs/ocfs2/journal.c:348
       ocfs2_remove_btree_range+0x8e4/0x1860 fs/ocfs2/alloc.c:5752
       ocfs2_commit_truncate+0xcca/0x2560 fs/ocfs2/alloc.c:7353
       ocfs2_truncate_file+0xd0e/0x1560 fs/ocfs2/file.c:509
       ocfs2_setattr+0x1217/0x1f50 fs/ocfs2/file.c:1208
       notify_change+0xbca/0xe90 fs/attr.c:503
       do_truncate+0x220/0x310 fs/open.c:65
       vfs_truncate+0x2e1/0x3b0 fs/open.c:111
       do_sys_truncate+0xdb/0x190 fs/open.c:134
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:800 [inline]
       ocfs2_xattr_set+0xe9e/0x1930 fs/ocfs2/xattr.c:3623
       __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
       __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
       vfs_setxattr+0x221/0x430 fs/xattr.c:321
       do_setxattr fs/xattr.c:629 [inline]
       path_setxattr+0x37e/0x4d0 fs/xattr.c:658
       __do_sys_lsetxattr fs/xattr.c:683 [inline]
       __se_sys_lsetxattr fs/xattr.c:679 [inline]
       __x64_sys_lsetxattr+0xb8/0xd0 fs/xattr.c:679
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6 --> jbd2_handle --> &oi->ip_xattr_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&oi->ip_xattr_sem);
                               lock(jbd2_handle);
                               lock(&oi->ip_xattr_sem);
  lock(&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6);

 *** DEADLOCK ***

3 locks held by syz.0.0/5118:
 #0: ffff88804ab5a420 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88803f585100 (&sb->s_type->i_mutex_key#19){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:800 [inline]
 #1: ffff88803f585100 (&sb->s_type->i_mutex_key#19){+.+.}-{3:3}, at: vfs_setxattr+0x1e1/0x430 fs/xattr.c:320
 #2: ffff88803f584e38 (&oi->ip_xattr_sem){++++}-{3:3}, at: ocfs2_xattr_set+0x633/0x1930 fs/ocfs2/xattr.c:3584

stack backtrace:
CPU: 0 UID: 0 PID: 5118 Comm: syz.0.0 Not tainted 6.11.0-rc6-syzkaller-00183-gb831f83e40a2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 down_write+0x99/0x220 kernel/locking/rwsem.c:1579
 inode_lock include/linux/fs.h:800 [inline]
 ocfs2_xattr_set+0xe9e/0x1930 fs/ocfs2/xattr.c:3623
 __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
 vfs_setxattr+0x221/0x430 fs/xattr.c:321
 do_setxattr fs/xattr.c:629 [inline]
 path_setxattr+0x37e/0x4d0 fs/xattr.c:658
 __do_sys_lsetxattr fs/xattr.c:683 [inline]
 __se_sys_lsetxattr fs/xattr.c:679 [inline]
 __x64_sys_lsetxattr+0xb8/0xd0 fs/xattr.c:679
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd4c4f7cef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd4c5d46038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 00007fd4c5135f80 RCX: 00007fd4c4f7cef9
RDX: 0000000020000180 RSI: 0000000020000140 RDI: 0000000020000100
RBP: 00007fd4c4fef01e R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000027 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd4c5135f80 R15: 00007fffe9f7afe8
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

