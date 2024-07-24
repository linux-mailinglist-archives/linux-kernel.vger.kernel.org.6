Return-Path: <linux-kernel+bounces-261002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8838B93B164
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A41B1F24C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1746158A37;
	Wed, 24 Jul 2024 13:14:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDCF155A24
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826863; cv=none; b=KmsmvYFHf+DfY5wD3ZV8HlUNBHnx0gliLATQfMz8lwZnBLrbRWVBChiXEv1WI31vhuyaqo9UQYyiufB+/FtWra14GRAkjyYicRiV9BC88KXL2iV+VukmaIb+GfX1MQnVgmTnTY0eCnH9Qk/KGRh9SZx7+7D3zlASY9ZDLXq61d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826863; c=relaxed/simple;
	bh=IddjQWElizIc+qI8LP1XC1RCgiTGnuHzdZqChQuPjKg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=btm0sLwfHWb7B0zHrmk7IjHBs4Tkf7SKirwCIBo1YBAafD6DrVf9D6qcrqwVw6CLiNEyTRji84jOaU++eFSbvOMslvfH5xNHx/Q9JtRaYfNE257rr9z218ytepfl0qWcPXbT3KM9+wOyjdOaCMDFeXwstsuAlBGnTUhVRrGVMwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39915b8e08dso84253845ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 06:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721826861; x=1722431661;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2gccljokEIWYvf68SwAhWPSJuCBs56qP6EOy/DnBtg=;
        b=kGjxr1ovjKyzBTrmTDszCmDUAloLrp8mSts1mRbJVPHYSftia2YdyfD/NirWLzkDPn
         BZHwP/lXomyBNjDVPd53sIvBF3GtQH3pWliIiyA9WmsOLUXHCmPT4bg/N+DaP87uCC7d
         dcrZQwwwZNnlpREwVOggzfxYOSMfzf28+HsGYWdXAM100sU2eK85LvYPOc567p61tyUa
         617IXAWEcyhOnVeGcpVAm5bOUy5T97uEPPf6YY6d87izHnnnDd9xXpcOFzPVneXY9ePb
         jNygZHcY/2czhurKNlb/kWM7y3mPC7OkHERhlRFEWN+wXgfp+FiK8RNXCQ77Vng37UoC
         GDrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaniRNow+khhbb8fhyQv8ij+hgKPTaIywdIqsLWwln+SJlGiQnT1YdLuVnlQr6PzB14GMmHG1v5cjB77MUwSYwW/j5oTvuw/52RPFG
X-Gm-Message-State: AOJu0Yw3pH2OIVMQscNlljnif8zC5zF1wQVpPxDNqgN1DY8GxCck8pw0
	FPQGs4IjgL4ASIXs0FifOH4yu6UX8rfjqPLNQwEv589OgjF4pRA4dDLrid4e/5LP3WOnj8RhtwD
	bNXnr0IYIEr4ugmbwYY6yttnPw4i5SPCBbrKxK6UGXaMIztEw+3FrLR0=
X-Google-Smtp-Source: AGHT+IEWzJeBz5WQC2ZMfw7s8+dd/ZOqNQLDKOEYsJul7ykX+pcgecdHHRlLh7rfUDpouoo+AXZpzqdjU0k3i0/1YEMLyiL/DGJ1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174a:b0:375:a55e:f5fc with SMTP id
 e9e14a558f8ab-398e430f50cmr10840565ab.1.1721826861102; Wed, 24 Jul 2024
 06:14:21 -0700 (PDT)
Date: Wed, 24 Jul 2024 06:14:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006bd089061dfe0e2c@google.com>
Subject: [syzbot] [jfs?] WARNING: bad unlock balance in clear_inode
From: syzbot <syzbot+a3473a74b23ecf1ceb67@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7846b618e0a4 Merge tag 'rtc-6.11' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127ff749980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=a3473a74b23ecf1ceb67
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/43e8dc30bfe7/disk-7846b618.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2563411f0b58/vmlinux-7846b618.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19d3b69b2212/bzImage-7846b618.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3473a74b23ecf1ceb67@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
6.10.0-syzkaller-11323-g7846b618e0a4 #0 Not tainted
-------------------------------------
syz-executor/5089 is trying to release lock (&xa->xa_lock) at:
[<ffffffff820eab99>] spin_unlock_irq include/linux/spinlock.h:401 [inline]
[<ffffffff820eab99>] clear_inode+0x69/0x160 fs/inode.c:625
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor/5089:
 #0: ffff88807a6160e0 (&type->s_umount_key#76){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88807a6160e0 (&type->s_umount_key#76){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88807a6160e0 (&type->s_umount_key#76){+.+.}-{3:3}, at: deactivate_super+0xb5/0xf0 fs/super.c:505

stack backtrace:
CPU: 1 PID: 5089 Comm: syz-executor Not tainted 6.10.0-syzkaller-11323-g7846b618e0a4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_unlock_imbalance_bug+0x256/0x2c0 kernel/locking/lockdep.c:5199
 __lock_release kernel/locking/lockdep.c:5436 [inline]
 lock_release+0x5cb/0xa30 kernel/locking/lockdep.c:5780
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:157 [inline]
 _raw_spin_unlock_irq+0x16/0x50 kernel/locking/spinlock.c:202
 spin_unlock_irq include/linux/spinlock.h:401 [inline]
 clear_inode+0x69/0x160 fs/inode.c:625
 jfs_evict_inode+0xb5/0x440 fs/jfs/inode.c:166
 evict+0x2a8/0x630 fs/inode.c:669
 dispose_list fs/inode.c:702 [inline]
 evict_inodes+0x5f9/0x690 fs/inode.c:752
 generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1685
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:222
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efd9e576e87
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd624f0338 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007efd9e576e87
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd624f03f0
RBP: 00007ffd624f03f0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd624f14b0
R13: 00007efd9e5e344c R14: 000000000001bd13 R15: 000000000001ba3e
 </TASK>
EXT4-fs (loop2): unmounting filesystem 76b65be2-f6da-4727-8c75-0525a5b65a09.


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

