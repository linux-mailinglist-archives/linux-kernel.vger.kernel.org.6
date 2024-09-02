Return-Path: <linux-kernel+bounces-310885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD39968278
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0D91F21B9F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FBF186E3B;
	Mon,  2 Sep 2024 08:54:30 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE29186E29
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267270; cv=none; b=uA8gsfxNEIdlIsWkalyQL66FpKFxk1+wwXn0kaNBlri66FhvcEBsSmL64cP/n4wELFPr/PTBelx72Tx6qWMTosy2pAnxLMzGewAmB3PF2/b4nhhEvm24x+QNIY9H7nOkQKQZIgGlZwnxRMW3/aerUeSdGwk9q1sfQtdyVJ8G9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267270; c=relaxed/simple;
	bh=CAATabSCr5CKZj+7nol0qkzBbFz1DplMI5QO7FJBzGI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OToWB66YYKFStKK2GPxeFUNwRQVmIQW+xfhUuaKnvZF+0zFCB/TMOT9xB6eNO2l/I/osCH9Gj9WLyW3qRPvzqMs88uFEJWfqXOSYzgP0IhRz8xMS1l9xuxlNWwU55zN8vIQydka+BBsGHHFKa4rMZTG5LMn9usDqUKJXTU6Ct1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a2cd95bf7so348863439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725267268; x=1725872068;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/CIsymnBzIqW1PBO0525sxPG7c5ImAMzTvr4SODwBk=;
        b=gFqYh5QWzBaJrW4G0MyCAWyxOsVB7d2y/WgUgBDnJtbMshggJReAc4R+XODLN0nCb6
         kUlyX0U846rb6uMJw38Y/mYW3bulY6j+/skJxH4Ua1xJTyAVavWPeL/nJ8Vdq4OiwahB
         i3X0ZsMZxde06/1dgjJxdue4GRR83TZRZeRLVwkJg3fsoFbwArwU6ev+bR0QBuUcnU7X
         8IA1pVXLlT3zlVxsI//fyFrtmlw1QEPHkd5kcoUlTohABtaG4FN7ry5i+glGS4eYvLaX
         1JAEG5bxVq+iGCvlwcgaL5ZGNDLFUlQ0KMd7rTTZxET7zQsGdAX5T5YFk/jHKN8bztCe
         GXNg==
X-Forwarded-Encrypted: i=1; AJvYcCVab5GX0ZRlX315mK/BxJLgeeZoXWVcDvE2S7tg42ULcZQ6fWQ8ETlz3yX4ex6HfnQjQVgynPwRWf48DD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rkOQdJpKdYEo+w9cy4jnC7ecLoj4cw1NWsjwxrCkOstpVjMD
	3SFqpOR/63gTBfaQuJwh+Qsh14u8tX1IBrMOXsZOIDZ1NeOjQh4nMRnvLTQA9+ByJ9SjEBm04MQ
	LDpHAZv+o1+T//05452pLLT6DpD1XHUzKSB4ZKrILzrNmdCiiU0/3xZk=
X-Google-Smtp-Source: AGHT+IHdEqahd/WpfkzJfahG0HAilrL2z+XzKuERzqkNKckNS21qCjTnadX9f3/YE6tajvhTbCtXXpf+hidjUHSKTskreDTziCRb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1805:b0:39d:1ca5:3903 with SMTP id
 e9e14a558f8ab-39f40f042d4mr8857135ab.1.1725267268010; Mon, 02 Sep 2024
 01:54:28 -0700 (PDT)
Date: Mon, 02 Sep 2024 01:54:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7170b06211f16b3@google.com>
Subject: [syzbot] [gfs2?] kernel BUG in gfs2_withdraw
From: syzbot <syzbot+ed42f17ebcb58526788c@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    928f79a188aa Merge tag 'loongarch-fixes-6.11-2' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14987643980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0455552d0b27491
dashboard link: https://syzkaller.appspot.com/bug?extid=ed42f17ebcb58526788c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d2f62b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109fb60b980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ca818b8564/disk-928f79a1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2cae3d4d58a7/vmlinux-928f79a1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d66b706213bc/bzImage-928f79a1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d2e2e3a9aae8/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108f297b980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=128f297b980000
console output: https://syzkaller.appspot.com/x/log.txt?x=148f297b980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed42f17ebcb58526788c@syzkaller.appspotmail.com

gfs2: fsid=_){&.s: fatal: filesystem consistency error - inode = 1 19, function = gfs2_jdesc_check, file = fs/gfs2/super.c, line = 119
gfs2: fsid=_){&.s: G:  s:SH n:2/13 f:aqob t:SH d:EX/0 a:0 v:0 r:2 m:20 p:3
gfs2: fsid=_){&.s:  H: s:SH f:eEcH e:0 p:5212 [syz-executor117] init_journal+0x1881/0x2420 fs/gfs2/ops_fstype.c:806
gfs2: fsid=_){&.s:  I: n:1/19 t:8 f:0x00 d:0x00000200 s:8388608 p:0
gfs2: fsid=_){&.s: about to withdraw this file system
------------[ cut here ]------------
kernel BUG at fs/gfs2/util.c:340!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5212 Comm: syz-executor117 Not tainted 6.11.0-rc5-syzkaller-00079-g928f79a188aa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:gfs2_withdraw+0x1459/0x1460 fs/gfs2/util.c:340
Code: ff ff 48 8b 4c 24 10 80 e1 07 80 c1 03 38 c1 0f 8c 51 fd ff ff 48 8b 7c 24 10 e8 02 2c 14 fe e9 42 fd ff ff e8 48 0f b0 fd 90 <0f> 0b 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900033373c0 EFLAGS: 00010293
RAX: ffffffff83e37c58 RBX: 0000000000000004 RCX: ffff88807b0a0000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffc90003337560 R08: ffffffff83e36aae R09: 1ffff92000666e18
R10: dffffc0000000000 R11: fffff52000666e19 R12: 1ffff11005354815
R13: 1ffff92000666e8c R14: dffffc0000000000 R15: ffff888029aa4340
FS:  0000555569397380(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000007ae7c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_jdesc_check+0x17b/0x2e0
 check_journal_clean+0x162/0x360 fs/gfs2/util.c:69
 init_journal+0x1881/0x2420 fs/gfs2/ops_fstype.c:806
 init_inodes+0xdc/0x320 fs/gfs2/ops_fstype.c:864
 gfs2_fill_super+0x1c18/0x2500 fs/gfs2/ops_fstype.c:1249
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1329
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9b18ad2b3a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd7482ab88 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd7482aba0 RCX: 00007f9b18ad2b3a
RDX: 00000000200124c0 RSI: 0000000020012500 RDI: 00007ffd7482aba0
RBP: 0000000000000004 R08: 00007ffd7482abe0 R09: 0000000000012613
R10: 0000000002800002 R11: 0000000000000282 R12: 0000000002800002
R13: 00007ffd7482abe0 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_withdraw+0x1459/0x1460 fs/gfs2/util.c:340
Code: ff ff 48 8b 4c 24 10 80 e1 07 80 c1 03 38 c1 0f 8c 51 fd ff ff 48 8b 7c 24 10 e8 02 2c 14 fe e9 42 fd ff ff e8 48 0f b0 fd 90 <0f> 0b 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900033373c0 EFLAGS: 00010293
RAX: ffffffff83e37c58 RBX: 0000000000000004 RCX: ffff88807b0a0000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffc90003337560 R08: ffffffff83e36aae R09: 1ffff92000666e18
R10: dffffc0000000000 R11: fffff52000666e19 R12: 1ffff11005354815
R13: 1ffff92000666e8c R14: dffffc0000000000 R15: ffff888029aa4340
FS:  0000555569397380(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000007ae7c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

