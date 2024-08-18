Return-Path: <linux-kernel+bounces-291001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA9B955C20
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD939281E0C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 10:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B51818037;
	Sun, 18 Aug 2024 10:41:30 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADF946C
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977689; cv=none; b=lQFDDUIPHhKY6KLrBu4qu0g2MdjT0ogrBjROzjYcEw8cRNqGJLIwvK3QuN31bCsLQjVVSHY78FCOtPzrMA0h9QRNkIIoHVaEH/RlEdachV6Q+8OGfutzsI0PW//Q3yPF+yQ+54ps+bE3Hne6TGX/s4j76sGoOTkDYWxzcukH3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977689; c=relaxed/simple;
	bh=TnW8i2UGfstGIRsEON/phMMJqVdQoTtnR+ybEcPJH9o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fyVdsa+4x0F3NLTxrN2TqJiS+qCsmEUTGJLQ0h3uFFAdtcSa3mazCZKgzaLw8ggm3gG2N3kWcb03QltAx5InrOweN06WKS78q30KYMw+5M93PVjYMtHs0eQySjOXvmnZsHAjGRkEqgLv7xfXciI1tqamy3A1PH5Febe7MNyz7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-821dabd4625so347917439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 03:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723977687; x=1724582487;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rd5w9063sJbdbJRc5XRLD4j7R/MndzI38o1VODkYecE=;
        b=Q8Idsqit8XoJxLfNwVJ/PeM1eN21jaBWpkTdlG7PNhjhAuaPylutfMfa4ZG9HFt72G
         rIAtRjQmD4g6ulINaoIjs1Sjca2B8nBU5GkZ51Sd57yVZg+mWOfz7UcmYq9Rojr6sCap
         77eXAsogU1GUAW2WPdsAl23kXUahJ8IKDXDEu2/FcPSPU4SbkVzPCu0n3K1Vf7JEr+MG
         IyCwnhFK+F0tflxDu8DtmhMdN5WjoBGNKpiiRgjRybdPJ40I/cO2WkUtXYISFywqWgWC
         Th3nvnz3gX0fxaWnDTNAjmbIB9uFmWH3LEZstgzS7J84NqAh0+S5BdBFuwQ8U0iLHrns
         AYyg==
X-Forwarded-Encrypted: i=1; AJvYcCX6EHd9cd+t2AzpkMqw7eUREEsbqXJVv8ImHuJ0fDQ9BvqViM9UJAX9t+l9KhFesur8YoCj/6aDxCsa3Ge+RebiGLW2pfTkFtVJeImT
X-Gm-Message-State: AOJu0Yx21Hd4jEJD/hg16/nokXyK6fSvJEhdzbWGG4xHvAsdPG+tA9Cs
	Hu7mD85NUelr06MrccN0C2geGsbKsjaOPeYyAbz4CzBhEsAEXhgifAbFCA9IyOp/uDEGHc4R8yJ
	bensE5CYLDayfISu/0kGl9ryBLWWPajFbvfImAIIn713yPxhRzE3yzGs=
X-Google-Smtp-Source: AGHT+IHUvrPsmfW5rrivHWUkbqOisU6xGQ1q0q35yUDoXiI4M2bd+GH8lW9YF0130HZgmq066orZQInRKDNAg1qKTsUjFOfuBWLH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:408e:b0:4c0:9a05:44d0 with SMTP id
 8926c6da1cb9f-4cce15bc05cmr497146173.1.1723977687343; Sun, 18 Aug 2024
 03:41:27 -0700 (PDT)
Date: Sun, 18 Aug 2024 03:41:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7b20f061ff2d56a@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode (3)
From: syzbot <syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9d5906799f7d Merge tag 'selinux-pr-20240814' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152a1a05980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92c0312151c4e32e
dashboard link: https://syzkaller.appspot.com/bug?extid=ebea2790904673d7c618
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/446819619a5c/disk-9d590679.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14a59529d386/vmlinux-9d590679.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04e89692a4c8/bzImage-9d590679.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/f2fs/inode.c:896!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5938 Comm: syz-executor Not tainted 6.11.0-rc3-syzkaller-00036-g9d5906799f7d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
Code: 2e b6 ab fd 31 ff 89 de e8 25 b6 ab fd 40 84 ed 75 28 e8 1b b3 ab fd e9 3c ec ff ff e8 11 b3 ab fd 90 0f 0b e8 09 b3 ab fd 90 <0f> 0b e8 01 b3 ab fd 90 0f 0b 90 e9 fc fe ff ff e8 f3 b2 ab fd e8
RSP: 0018:ffffc90009cf7928 EFLAGS: 00010293
RAX: ffffffff83e7c5c7 RBX: 0000000000000002 RCX: ffff888019f50000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83e7bfb0 R09: 1ffff1100b106843
R10: dffffc0000000000 R11: ffffed100b106844 R12: ffff888057150000
R13: ffff888058834218 R14: ffff888058833d78 R15: dffffc0000000000
FS:  0000555586684500(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcd737bd000 CR3: 0000000018b5c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 evict+0x532/0x950 fs/inode.c:704
 dispose_list fs/inode.c:747 [inline]
 evict_inodes+0x5f9/0x690 fs/inode.c:797
 generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1696
 kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcd7cd7ad27
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe52115828 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fcd7cd7ad27
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe521158e0
RBP: 00007ffe521158e0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe52116960
R13: 00007fcd7cde778c R14: 0000000000021420 R15: 00007ffe521169a0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
Code: 2e b6 ab fd 31 ff 89 de e8 25 b6 ab fd 40 84 ed 75 28 e8 1b b3 ab fd e9 3c ec ff ff e8 11 b3 ab fd 90 0f 0b e8 09 b3 ab fd 90 <0f> 0b e8 01 b3 ab fd 90 0f 0b 90 e9 fc fe ff ff e8 f3 b2 ab fd e8
RSP: 0018:ffffc90009cf7928 EFLAGS: 00010293
RAX: ffffffff83e7c5c7 RBX: 0000000000000002 RCX: ffff888019f50000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83e7bfb0 R09: 1ffff1100b106843
R10: dffffc0000000000 R11: ffffed100b106844 R12: ffff888057150000
R13: ffff888058834218 R14: ffff888058833d78 R15: dffffc0000000000
FS:  0000555586684500(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcd737bd000 CR3: 0000000018b5c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

