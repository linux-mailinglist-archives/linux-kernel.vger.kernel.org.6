Return-Path: <linux-kernel+bounces-331445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D397ACFF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7091C2127A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045861531C5;
	Tue, 17 Sep 2024 08:41:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0381013D889
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562487; cv=none; b=po2JtyINBlp5WLmvlMm0m49Ym7vYWUueNmayxfso9sHkBHFbgMwJA1IqBfxCJVtPq3bEQiZsI33QErH8EdUhd85G/nRd4KeiV8NwN4Yn0JY20cbqiMFnfLbz4SH7E4m4jRPNuGI0Xp0x1l7bCFXxmpsEz9bf4jVyx6zf3rFDxF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562487; c=relaxed/simple;
	bh=KJZX0xwQ0LvOu2NyTdx/42mrTiMXdW9i7AW2KT1Kzp8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pdKOSvk/wLtBZQ/5tV9p6+FY6Ar70zksHeaj4BFknx9G6I9NaIstHkzIGTVxEg0jffztxR9mPYwGbLcF1NlDvWj2dH1AtTPVIsEgsVnF639FsZuhqQQ9u/npjjSN1AsAW9fYeg+fP3XubvYxuepdQQ/B37qXCLEBeF4kB2Zh3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f510b3f81so100447565ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726562485; x=1727167285;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1GbxJY/SaqP/ls656/lh8lA7/iftAcnVWmDpAHENKNc=;
        b=R+AODlRb12XfmVvIJBD2un/VzsGt/MQSlh1DQ1Y6OmZDEpCpfOosQFwF0e5hMl4Oe7
         He4+gLS1hsjxj/Pjw31FJrA2R6K3CQBpMud4jUjXvXasatCjrGW73jaHocOw6h3u+gTi
         EA73ZwWdm5Wb40oA967w6C5hw+trvRrtRZE23n4ApPlBT8v/AX6R81wxQAP0hjkcNIm/
         pJ0rbiTVbZ/yTBiRhPMaeKpYGZmr+9Co+R+dIiGC9DHbGtVzHQNEdiGUzXigi0MndJg7
         0NKHUXXFtq3EolalBOU7Nmsz00NjF0syJWBSXZw6oPXYq3Oerb6znHGgEwBKyJqnhkss
         gFGg==
X-Forwarded-Encrypted: i=1; AJvYcCU6GY4Z+6coGo7ZIwBKNm+lCQyNXhWAJozoP6YDGYp/ZDj1YqKTgGgqV7UX2yN2vjffHcL88mTtTpVa2Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJhbTJApTUrL7ojL0S5nQZeDSyqlpOwrqYoGjxkuuM/kN0de+
	kJH/IVbFHFn+EA+hH9WhBceuz3wTMRsKR7d540tGBFKVrVXbSbFoBb18SnyrYIY9sSqjB9iJm8k
	ZbHgl1Ghzl+86qdZdQ+l9Syd9uJin8YTSlzE5R5eJ01JfJpqqpv3hQGM=
X-Google-Smtp-Source: AGHT+IEVE+mmkKDEjBlpz5d/VwaatKN31WsZkAxPamlwq0678Pabz05+Wlo3Yjg2XI1286qIJO0t5FfJC4vcqW9j7ZubSDb7fdEB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a084611b38mr141704115ab.1.1726562485032; Tue, 17 Sep 2024
 01:41:25 -0700 (PDT)
Date: Tue, 17 Sep 2024 01:41:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a6cd706224ca720@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in f2fs_invalidate_blocks
From: syzbot <syzbot+33379ce4ac76acf7d0c7@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    196145c606d0 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1051f100580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=33379ce4ac76acf7d0c7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-196145c6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4567b7dd8173/vmlinux-196145c6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79fbae030fbb/bzImage-196145c6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33379ce4ac76acf7d0c7@syzkaller.appspotmail.com

UDPLite6: UDP-Lite is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:2519!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5111 Comm: syz.0.0 Not tainted 6.11.0-rc7-syzkaller-00097-g196145c606d0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:f2fs_invalidate_blocks+0x35f/0x370 fs/f2fs/segment.c:2519
Code: 2f fe fd e9 7f fe ff ff e8 6e e7 96 fd 44 89 ee 48 c7 c7 30 29 f1 8e 48 89 da e8 9c b0 ef 00 e9 fb fd ff ff e8 52 e7 96 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0000:ffffc90002fff840 EFLAGS: 00010287
RAX: ffffffff83fca55e RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000b7e9000 RSI: 00000000000063bf RDI: 00000000000063c0
RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff83fca3ce
R10: 0000000000000003 R11: ffff88800023c880 R12: ffffc90002fffa48
R13: 00000000ffffffff R14: ffff888011e3c000 R15: 0000000000000000
FS:  00007f843cafe6c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffed846bd20 CR3: 000000003d572000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 truncate_node+0x1a4/0x6f0 fs/f2fs/node.c:909
 f2fs_remove_inode_page+0x5c2/0x870 fs/f2fs/node.c:1288
 f2fs_evict_inode+0x879/0x15c0 fs/f2fs/inode.c:851
 evict+0x532/0x950 fs/inode.c:704
 __dentry_kill+0x20d/0x630 fs/dcache.c:615
 dput+0x19f/0x2b0 fs/dcache.c:857
 __fput+0x5f8/0x8a0 fs/file_table.c:430
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f843bd7def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f843cafe038 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f843bf36058 RCX: 00007f843bd7def9
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000000000007
RBP: 00007f843bdf0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f843bf36058 R15: 00007ffd271d7608
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_invalidate_blocks+0x35f/0x370 fs/f2fs/segment.c:2519
Code: 2f fe fd e9 7f fe ff ff e8 6e e7 96 fd 44 89 ee 48 c7 c7 30 29 f1 8e 48 89 da e8 9c b0 ef 00 e9 fb fd ff ff e8 52 e7 96 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0000:ffffc90002fff840 EFLAGS: 00010287
RAX: ffffffff83fca55e RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000b7e9000 RSI: 00000000000063bf RDI: 00000000000063c0
RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff83fca3ce
R10: 0000000000000003 R11: ffff88800023c880 R12: ffffc90002fffa48
R13: 00000000ffffffff R14: ffff888011e3c000 R15: 0000000000000000
FS:  00007f843cafe6c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e3c26bf118 CR3: 000000003d572000 CR4: 0000000000350ef0
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

