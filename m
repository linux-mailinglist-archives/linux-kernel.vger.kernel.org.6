Return-Path: <linux-kernel+bounces-572959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33175A6D0CA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D0C188F646
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A84157A6C;
	Sun, 23 Mar 2025 19:30:27 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E22AF04
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742758227; cv=none; b=oAHT8NkKimzvzfGRQxNTT/MDQm6waoGW33SY67ArJGn/g9jMy2I9/j5BMkpyZU9gw/3ONSIMfNMFFK4sgJzpGH0zuoWr11PAsS8EswYD8hVVtEHo2kusauU8Y4JLkV/BjCI2naWXipg/Ue0rQX9KMUO+1JL1fmItwm2/Xoa/bgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742758227; c=relaxed/simple;
	bh=2ohNy7YKATBnBnc136deKUAk3RTDWIRo3YkHr24U4Rw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mUb62WS3JgkZfBGdk3Ugrw5dHM5Sh2wPcHb8eJLUN6H8vdbFxFd4cj4Xo/n5lF8yc2Sr9V/eeggIhjusXE3HLvnkDLgeaSs27NpNH7e9m/t3ldlNEIJL1MCoKQPUq/cn09p5xYVi1oCN7THigw/h/+/eMOCvECYFRm97ICsdf6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85e15e32379so328186439f.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742758224; x=1743363024;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBdbNcX35k7KZavDe8NK2BNik7XoCQAB+GSEaX7GVKw=;
        b=G2gBWVXm4LvFE0TsCvl3mcRVeBecCK0b9KxilMTD396VkXAvTse2GYTuBYb/B6wzpM
         l9xd0+wgMSwGA8Z7+KiUS687sz1Qk2ySGFluPdxKIG0J+3GH+1nvm8ATvjFUSXstFTcj
         rmArPvzf3c2OlEPQ3GYInwxv3quOatNVmLI9hoBB8f1VSQ8iyt475xjIK81o21iIRGz1
         Hdi5LLKVffr17CF1wDR+/EFTVS+NLSWM1cUw8fFlCHYjS0NPRbP5u63Fy6a1e8tWMWL2
         PyJso8z8REOYXdr/RKfbUJFBfruHKkjMQBJMq5EFqQ1JJ1fkn0ClLjQ7egaoG6QDv3gP
         JCBw==
X-Forwarded-Encrypted: i=1; AJvYcCWxXc0qP8pJKGU21r4gHGmS6ABLUI+90nIXrbBUYtOjU5GrUSMGGjtB44yiAGtLZ68C7406g+b3B/7LoGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyECmE1TWJ6cpztEbxPVNYpAD1slnKkGQsMvXuNJZCxdF96ZpIK
	QDUIbbJHu0g2jiak3Tj6pUa/X/RfnqhIUFUK6ySR8ZaOz2jjL9l7LPwQrzpg1XhNXK9HMvfGF3B
	sSimxNH39m+jrfEZLXwqcZcHb6A8AoNyOYyFi+19YTAXGPqPMjWqXTQQ=
X-Google-Smtp-Source: AGHT+IGdAfspnFJau/nx7QI/bP4UmwZEZnEWUxrdOwsULAo5UQUbuqNUGzIAxpI6B8ihAdzW+mZOGNsg28jHvVx91uf45AZIOI/K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:3d4:6dd2:3989 with SMTP id
 e9e14a558f8ab-3d5961865f7mr102804875ab.20.1742758224512; Sun, 23 Mar 2025
 12:30:24 -0700 (PDT)
Date: Sun, 23 Mar 2025 12:30:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e06150.050a0220.21942d.0005.GAE@google.com>
Subject: [syzbot] [f2fs?] INFO: task hung in f2fs_grab_cache_page
From: syzbot <syzbot+cc448dcdc7ae0b4e4ffa@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    81e4f8d68c66 Merge tag 'pmdomain-v6.14-rc4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139a6004580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27515cfdbafbb90d
dashboard link: https://syzkaller.appspot.com/bug?extid=cc448dcdc7ae0b4e4ffa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12756e98580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e3744c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-81e4f8d6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/285c520dda1c/vmlinux-81e4f8d6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/048e25a8dfed/bzImage-81e4f8d6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/52a1b1c7431f/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=159a6004580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc448dcdc7ae0b4e4ffa@syzkaller.appspotmail.com

INFO: task syz-executor140:5308 blocked for more than 143 seconds.
      Not tainted 6.14.0-rc7-syzkaller-00069-g81e4f8d68c66 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor140 state:D stack:24016 pid:5308  tgid:5308  ppid:5306   task_flags:0x400140 flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 io_schedule+0x8d/0x110 kernel/sched/core.c:7690
 folio_wait_bit_common+0x839/0xee0 mm/filemap.c:1317
 __folio_lock mm/filemap.c:1664 [inline]
 folio_lock include/linux/pagemap.h:1163 [inline]
 __filemap_get_folio+0x147/0xb40 mm/filemap.c:1917
 pagecache_get_page+0x2c/0x130 mm/folio-compat.c:87
 find_get_page_flags include/linux/pagemap.h:842 [inline]
 f2fs_grab_cache_page+0x2b/0x320 fs/f2fs/f2fs.h:2776
 __get_node_page+0x131/0x11b0 fs/f2fs/node.c:1463
 read_xattr_block+0xfb/0x190 fs/f2fs/xattr.c:306
 lookup_all_xattrs fs/f2fs/xattr.c:355 [inline]
 f2fs_getxattr+0x676/0xf70 fs/f2fs/xattr.c:533
 __f2fs_get_acl+0x52/0x870 fs/f2fs/acl.c:179
 f2fs_acl_create fs/f2fs/acl.c:375 [inline]
 f2fs_init_acl+0xd7/0x9b0 fs/f2fs/acl.c:418
 f2fs_init_inode_metadata+0xa0f/0x1050 fs/f2fs/dir.c:539
 f2fs_add_inline_entry+0x448/0x860 fs/f2fs/inline.c:666
 f2fs_add_dentry+0xba/0x1e0 fs/f2fs/dir.c:765
 f2fs_do_add_link+0x28c/0x3a0 fs/f2fs/dir.c:808
 f2fs_add_link fs/f2fs/f2fs.h:3616 [inline]
 f2fs_mknod+0x2e8/0x5b0 fs/f2fs/namei.c:766
 vfs_mknod+0x36d/0x3b0 fs/namei.c:4191
 unix_bind_bsd net/unix/af_unix.c:1286 [inline]
 unix_bind+0x563/0xe30 net/unix/af_unix.c:1379
 __sys_bind_socket net/socket.c:1817 [inline]
 __sys_bind+0x1e4/0x290 net/socket.c:1848
 __do_sys_bind net/socket.c:1853 [inline]
 __se_sys_bind net/socket.c:1851 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1851
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f31e6165dc9
RSP: 002b:00007fff2bc5b438 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f31e6165dc9
RDX: 000000000000006e RSI: 0000400000000080 RDI: 0000000000000004
RBP: 00000000000014bb R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000557f R11: 0000000000000246 R12: 00007fff2bc5b480
R13: 00007fff2bc5b560 R14: 431bde82d7b634db R15: 00007f31e61af01d
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/26:
 #0: ffffffff8eb393e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8eb393e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8eb393e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6746
3 locks held by kworker/u4:7/1038:
 #0: ffff888030f3a148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888030f3a148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x98b/0x18e0 kernel/workqueue.c:3319
 #1: ffffc9000256fc60 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000256fc60 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18e0 kernel/workqueue.c:3319
 #2: ffff888011e7c0e0 (&type->s_umount_key#42){.+.+}-{4:4}, at: super_trylock_shared+0x22/0xf0 fs/super.c:562
2 locks held by getty/5107:
 #0: ffff88801f4d90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000019b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x616/0x1770 drivers/tty/n_tty.c:2211
5 locks held by syz-executor140/5308:
 #0: ffff888011e7c420 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:547
 #1: ffff888045a992d8 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:912 [inline]
 #1: ffff888045a992d8 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: filename_create+0x260/0x540 fs/namei.c:4082
 #2: ffff888011fa03b0 (&sbi->cp_rwsem){.+.+}-{4:4}, at: f2fs_down_read fs/f2fs/f2fs.h:2175 [inline]
 #2: ffff888011fa03b0 (&sbi->cp_rwsem){.+.+}-{4:4}, at: f2fs_lock_op fs/f2fs/f2fs.h:2224 [inline]
 #2: ffff888011fa03b0 (&sbi->cp_rwsem){.+.+}-{4:4}, at: f2fs_mknod+0x1f8/0x5b0 fs/f2fs/namei.c:765
 #3: ffff888045a99948 (&fi->i_xattr_sem){.+.+}-{4:4}, at: f2fs_down_read fs/f2fs/f2fs.h:2175 [inline]
 #3: ffff888045a99948 (&fi->i_xattr_sem){.+.+}-{4:4}, at: f2fs_add_dentry+0x9f/0x1e0 fs/f2fs/dir.c:764
 #4: ffff888045a99f70 (&fi->i_sem/1){+.+.}-{4:4}, at: f2fs_down_write_nested fs/f2fs/f2fs.h:2202 [inline]
 #4: ffff888045a99f70 (&fi->i_sem/1){+.+.}-{4:4}, at: f2fs_add_inline_entry+0x431/0x860 fs/f2fs/inline.c:664
2 locks held by f2fs_ckpt-7:0/5310:
 #0: ffff888011fa1350 (&sbi->gc_lock){+.+.}-{4:4}, at: f2fs_down_write fs/f2fs/f2fs.h:2191 [inline]
 #0: ffff888011fa1350 (&sbi->gc_lock){+.+.}-{4:4}, at: __write_checkpoint_sync fs/f2fs/checkpoint.c:1783 [inline]
 #0: ffff888011fa1350 (&sbi->gc_lock){+.+.}-{4:4}, at: __checkpoint_and_complete_reqs+0xcf/0x3b0 fs/f2fs/checkpoint.c:1803
 #1: ffff888011fa0318 (&sbi->cp_global_sem){+.+.}-{4:4}, at: f2fs_down_write fs/f2fs/f2fs.h:2191 [inline]
 #1: ffff888011fa0318 (&sbi->cp_global_sem){+.+.}-{4:4}, at: f2fs_write_checkpoint+0x21f/0x1c80 fs/f2fs/checkpoint.c:1653

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 26 Comm: khungtaskd Not tainted 6.14.0-rc7-syzkaller-00069-g81e4f8d68c66 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:236 [inline]
 watchdog+0x1058/0x10a0 kernel/hung_task.c:399
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

