Return-Path: <linux-kernel+bounces-416944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26BC9D4CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B181F22DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1330B1D2F74;
	Thu, 21 Nov 2024 12:18:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA241369AA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732191507; cv=none; b=qIFzURfJfNW7A1+z7IK4CZySe6YAT4wGMRxHVzWZbQnIVkubdk825Ygu74raNMz+SC/zRghFTldk7EhXOa6Hi8nihfZiPWjkvfLesKy6MPsHcZvf4YchQAvLJ+P2YqkAjcD3EHZp/PtDJMW+6GV0aX2SzYTstSNcXBJZbUvV+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732191507; c=relaxed/simple;
	bh=8wg3tzd15OXyL0GvbrRkk/nBMec0bBE5kDQIjzFxMUI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WpAlffhHH3GHNf0hVNR1IquIgQ35oDN1kn8cL/+MyM4wcFVXiyeoFJtfH0BTKciaEfriElsdEsNt72TJdc54pUntYZcJHO0f0Juz8qLd/+NzGApesNybDaUknK5NHBSr6d4CrJu7DC3J/zqE14PWZ7j2umjWllbVAdGRIBbQsfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a78c40fa96so8219585ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732191505; x=1732796305;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqex2r6AbG5ALIn5qBQF13FXINwV1XpbApxBY8K56yU=;
        b=MUeTuN5JiNDK0JECz00gJiO3QeaBMxLYuSNw87ErF9+AoFjOUmPpDnRl6Jawyvzfut
         5RiHC4HMGY0ypLXDsPIqX/EwlqHDxrUnjiYIWdOxGFYBieVVM6NY3wiJf/8BDZ4qZakZ
         4wZkv6FdIIA0pmWv4Zn/6sGEtGL/0TvN2QOTRHsw4miH2jaFsa3KQ0Xccy05FCNbUhM/
         uBK8rHV0oRVYnraD4Eitt0cZjm26YaeZtUaUyMw78xrrW66gKkFyGCit4SWGDV9vS8QH
         7ooNnmmLtMLWIwL0IGDQdW+cacsz1sBhisJjFcJAhf4M7tBJ+gUnQXDBY6DXJe1xD2T9
         h3cA==
X-Forwarded-Encrypted: i=1; AJvYcCW+0omRoZEFIXB/SY6n3HaaxMVkKaB8BXg4IpIAggycATyCu4parNMAcP50TqLrPfEhE/hDJxWgWAUKrsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0a0N+L1mCi+X/crCugn1aEpQxP3R9SyxNlR4T2fSRw9h1LRW
	BgsGp/arqqpUNqlQKoJLAncHP79eHqXLIQ+8irsgUtsZG90ryS35WdqsMBFGL8SKMDvvxsUcYQc
	SR75m/vvHcekjUiZncmmQOY2Q9GDiqtjp7IoTHFuMKJUMejV30kQXg/w=
X-Google-Smtp-Source: AGHT+IE0Tznq9rP7nboEkE+3mBayO4aZoUYu6RGrXil7Qk2ooBueLj7vo7BxEyzvSjpHqsHIzYlc8DHgJ9+rj+O+RpJ8PkfHKtAw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b87:b0:3a7:87f2:b010 with SMTP id
 e9e14a558f8ab-3a787f2b18fmr64875585ab.5.1732191505074; Thu, 21 Nov 2024
 04:18:25 -0800 (PST)
Date: Thu, 21 Nov 2024 04:18:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673f2511.050a0220.3c9d61.016e.GAE@google.com>
Subject: [syzbot] [jfs?] possible deadlock in diFree (2)
From: syzbot <syzbot+355da3b3a74881008e8f@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a5df3796467 Merge tag 'mm-hotfixes-stable-2024-11-16-15-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17315378580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95b7d4b29182ed62
dashboard link: https://syzkaller.appspot.com/bug?extid=355da3b3a74881008e8f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d4db5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bef130580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4a5df379.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cb509a18129b/vmlinux-4a5df379.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4a4deaeedf54/bzImage-4a5df379.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/041539d17a26/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+355da3b3a74881008e8f@syzkaller.appspotmail.com

ERROR: (device loop0): remounting filesystem as read-only
ERROR: (device loop0): duplicateIXtree: 
============================================
WARNING: possible recursive locking detected
6.12.0-rc7-syzkaller-00212-g4a5df3796467 #0 Not tainted
--------------------------------------------
syz-executor301/5309 is trying to acquire lock:
ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diFree+0x37c/0x2fb0 fs/jfs/jfs_imap.c:889

but task is already holding lock:
ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diAlloc+0x1b6/0x1630

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(imap->im_aglock[index]));
  lock(&(imap->im_aglock[index]));

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz-executor301/5309:
 #0: ffff8880422a4420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88804755b390 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
 #1: ffff88804755b390 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: filename_create+0x260/0x540 fs/namei.c:4026
 #2: ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diAlloc+0x1b6/0x1630
 #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diNewIAG fs/jfs/jfs_imap.c:2460 [inline]
 #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
 #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diAllocAG+0x4b7/0x1e50 fs/jfs/jfs_imap.c:1669
 #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diNewIAG fs/jfs/jfs_imap.c:2477 [inline]
 #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
 #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diAllocAG+0x869/0x1e50 fs/jfs/jfs_imap.c:1669

stack backtrace:
CPU: 0 UID: 0 PID: 5309 Comm: syz-executor301 Not tainted 6.12.0-rc7-syzkaller-00212-g4a5df3796467 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 diFree+0x37c/0x2fb0 fs/jfs/jfs_imap.c:889
 jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
 evict+0x4e8/0x9b0 fs/inode.c:725
 diFreeSpecial fs/jfs/jfs_imap.c:552 [inline]
 duplicateIXtree+0x3c6/0x550 fs/jfs/jfs_imap.c:3022
 diNewIAG fs/jfs/jfs_imap.c:2597 [inline]
 diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
 diAllocAG+0x17dc/0x1e50 fs/jfs/jfs_imap.c:1669
 diAlloc+0x1d2/0x1630 fs/jfs/jfs_imap.c:1590
 ialloc+0x8f/0x900 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1c5/0xba0 fs/jfs/namei.c:225
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
 do_mkdirat+0x264/0x3a0 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc96b45f879
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca87793b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007ffca8779588 RCX: 00007fc96b45f879
RDX: 0000000000000000 RSI: 00000000200005c0 RDI: 00000000ffffff9c
RBP: 00007fc96b4d9610 R08: 00007ffca8779588 R09: 00007ffca8779588
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffca8779578 R14: 0000000000000001 R15: 0000000000000001
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

