Return-Path: <linux-kernel+bounces-246471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2501392C22C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484E61C2330F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99A18FA3D;
	Tue,  9 Jul 2024 17:09:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF8218FA26
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544964; cv=none; b=KNG5ORlcopDR7F8fRLI60XwLN0OnswLvw9NgZYkTdkbYCgnVHzhF+JRFTcgAitokcC4x5wqA8ovUIkity4CESgx9rdDW+6qqaQuf2LJbu9XaiZCjwG6R+5smrdsX+QNYdZ2jT0kh1/ffMRo00v9PMY5lw1isuqA5acJ03YeIWfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544964; c=relaxed/simple;
	bh=MaBmQ0+bDWF2YJ72ALRbEOARF4Is16ZIuFCOwWLyK9Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pgVn8DeW6NS6YLb4I1NUOvaWypHBTUHx/pAsFwQRWj0y2lAI8JSafOBNiXOYr6F7k6/AdD6Bu4bVjGy5H1m4F/Se0VaMm8SmYgkcWO3MIPKIGR7FrewHfRkl6mlheCnHOYHUnZIt+cY1XALIBAv9xtugrJndqRrCS88s0l1y6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f657f37e96so689250239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 10:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720544962; x=1721149762;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+D1Voiw7ujAt3NBd1r6g/UHFAIgushWSPCQIFHyzHs=;
        b=Uo5qRqMjn4v4nygRFB8/7XBf4zP6PVw2WdQht17B270z0OOa7rHRdHf9dHYqr1APvc
         jxBtbqp6RN7WX/q7NIeHiNeXuq6f/aFmshX6xq+NwSY+IZCSQnkoddpSIvmlkGtjRaze
         MaMe+wvQQXkF6Sp0mnp/OxvbDvDMJGNNhlY8NBr+8uQWDMtmpizQR4nWzT4qvzZxuyT/
         L0FH0gbFr/iBFpOQ1KK9aEFndmfh8LTF99vrZYHkx/TJ34q5UWqV9kMaU5KqTbi25hh/
         t0jRTQ0D2LvAiuSyxYwN+eNWd3wfpm5B9TYAgPLAjDZIaj4xlarzV45aD64ZcGNWScyt
         L73g==
X-Forwarded-Encrypted: i=1; AJvYcCUIwUlKrgW/OOsRb+HOXkNVxx5gtvDa85q557S3sDgwg3Jz+oPx/2/DMxK/xiDYWpZYyWzZmpwV+GnNPpvuNXjT74MdsujNlN7As/X5
X-Gm-Message-State: AOJu0YxGnD7MhRkiSOiY4tTzkM0JsAfcw5CNEnPr+1B18qbc2YUDc7cP
	ebMq4p5qWmIW6sZQ+DLK/unEfSRfKA0rDVkMguRzipV6ALI9yaliznIn+1/mdYndVAyFOBl2Lp3
	Kh9tmttdh9mxA+9jpnq4YYx00Tf224zyiinYNW/fGqdbEQL/7TowkHvw=
X-Google-Smtp-Source: AGHT+IH6VZPv1oOErS/B8L2UmP+Rc/uXHaknA97U0FoXEs2YLS0KBjws1f8+LwQBeMbdOyBTtSj8gAV7HDUYNiPyvxiQErWPl/IJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14ca:b0:7f9:51b5:b98a with SMTP id
 ca18e2360f4ac-7fff9e4336cmr22141739f.0.1720544962275; Tue, 09 Jul 2024
 10:09:22 -0700 (PDT)
Date: Tue, 09 Jul 2024 10:09:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bfcc9061cd39752@google.com>
Subject: [syzbot] [bpf?] [net?] stack segment fault in cpu_map_redirect
From: syzbot <syzbot+6fc359860535c8a466fa@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, toke@redhat.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0b58e108042b Add linux-next specific files for 20240703
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17a85c9e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed034204f2e40e53
dashboard link: https://syzkaller.appspot.com/bug?extid=6fc359860535c8a466fa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14aca369980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a6f6e1980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d079762feae/disk-0b58e108.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e53996c8d8c2/vmlinux-0b58e108.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0bf21cdd844/bzImage-0b58e108.xz

The issue was bisected to:

commit 401cb7dae8130fd34eb84648e02ab4c506df7d5e
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Jun 20 13:22:04 2024 +0000

    net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16373059980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15373059980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11373059980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6fc359860535c8a466fa@syzkaller.appspotmail.com
Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")

Oops: stack segment: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5103 Comm: syz-executor681 Not tainted 6.10.0-rc6-next-20240703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:__bpf_xdp_redirect_map include/linux/filter.h:1699 [inline]
RIP: 0010:cpu_map_redirect+0x5c/0x470 kernel/bpf/cpumap.c:643
Code: 81 c3 00 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 62 6b 3d 00 4c 8b 2b 49 8d 5d 38 48 89 dd 48 c1 ed 03 <42> 0f b6 44 35 00 84 c0 0f 85 fd 02 00 00 44 8b 33 44 89 f6 83 e6
RSP: 0018:ffffc9000395f960 EFLAGS: 00010202
RAX: 1ffff110051dd300 RBX: 0000000000000038 RCX: ffff888028ee8000
RDX: 0000000000000000 RSI: 000000000395f9b0 RDI: ffff88802ec3fc00
RBP: 0000000000000007 R08: 0000000000000007 R09: ffffffff81b5ee2f
R10: 0000000000000004 R11: ffff888028ee8000 R12: 000000000395f9b0
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88802ec3fc00
FS:  000055556a17a380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000099d4b98 CR3: 0000000021f40000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_prog_ec9efaa32d58ce69+0x56/0x5a
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 tun_build_skb drivers/net/tun.c:1711 [inline]
 tun_get_user+0x3321/0x4560 drivers/net/tun.c:1819
 tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2048
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f40ef4f8070
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 51 e0 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffcf4c50d48 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f40ef4f8070
RDX: 0000000000000022 RSI: 0000000020000a40 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffc0000000d R09: 00007ffc0000000d
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:__bpf_xdp_redirect_map include/linux/filter.h:1699 [inline]
RIP: 0010:cpu_map_redirect+0x5c/0x470 kernel/bpf/cpumap.c:643
Code: 81 c3 00 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 62 6b 3d 00 4c 8b 2b 49 8d 5d 38 48 89 dd 48 c1 ed 03 <42> 0f b6 44 35 00 84 c0 0f 85 fd 02 00 00 44 8b 33 44 89 f6 83 e6
RSP: 0018:ffffc9000395f960 EFLAGS: 00010202
RAX: 1ffff110051dd300 RBX: 0000000000000038 RCX: ffff888028ee8000
RDX: 0000000000000000 RSI: 000000000395f9b0 RDI: ffff88802ec3fc00
RBP: 0000000000000007 R08: 0000000000000007 R09: ffffffff81b5ee2f
R10: 0000000000000004 R11: ffff888028ee8000 R12: 000000000395f9b0
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88802ec3fc00
FS:  000055556a17a380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000099d4b98 CR3: 0000000021f40000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	81 c3 00 18 00 00    	add    $0x1800,%ebx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 62 6b 3d 00       	call   0x3d6b7e
  1c:	4c 8b 2b             	mov    (%rbx),%r13
  1f:	49 8d 5d 38          	lea    0x38(%r13),%rbx
  23:	48 89 dd             	mov    %rbx,%rbp
  26:	48 c1 ed 03          	shr    $0x3,%rbp
* 2a:	42 0f b6 44 35 00    	movzbl 0x0(%rbp,%r14,1),%eax <-- trapping instruction
  30:	84 c0                	test   %al,%al
  32:	0f 85 fd 02 00 00    	jne    0x335
  38:	44 8b 33             	mov    (%rbx),%r14d
  3b:	44 89 f6             	mov    %r14d,%esi
  3e:	83                   	.byte 0x83
  3f:	e6                   	.byte 0xe6


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

