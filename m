Return-Path: <linux-kernel+bounces-387986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB22B9B58C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40F5B224C3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75471946B;
	Wed, 30 Oct 2024 00:43:33 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF65FEE4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249013; cv=none; b=lYYg8MasESug5ZH4r2EW8IZsXLdmazfl1luJEBNieEys0qybpboCZlUEpqeIeAUu6C96fbV/wOQe8Pb2f2uARespUVBvSYAbSi8BBwjzjnntprueKdh7Gu4hp3xJ1Zlo2NjWgNMxRK72hGQPKB7PA8iH+lY2G8pvlu/mdAago7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249013; c=relaxed/simple;
	bh=ol7WQKQUf9T8FKPeHsgEOQ97oyaeJKX4zFyifPcMc0c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Sxvg7QjduN5qoz07Wsizm/Erj3QzpsDRREZsnlKVB3AwIzWgqGj1TkJeqD9gec7GlLoccaIMiDIrX/4Jjo4EUPqnPz8UOW3eRTQmD5sgSIut9RQHo2uZ55sT5Y2qHGNBVAF2ffxnoTQaVpKBTa24MsT7NKGHauqmMRDPwZaBvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4e41e2732so46178385ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730249010; x=1730853810;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrVziyw9d/yKzZBgMOjBwBHoEbjCcTX8eHplk7sIv5c=;
        b=hyNxyPcTl+6VYSpUf115y/m4Gajuz9OJG0VmYuwQ6VkfwU4j0Ci3CP87XQAfXkSv7M
         ZQVof4N2AE9SayiLZlxzGWWdBE6UAdzU2AmMmS9UL/aJbCUVYm1P8KIIuRRPE6za8FBj
         At+gb0c9KfeZQZ0lktL3FjeRl59lniYUKMjA143KPtq4BM37bEVW1Wt99sjkV9deraUi
         WEna555EoGfoo10xpCVFV5SA+WytK9b2GEGD0+9IZ9h/6x5SjcchRI1sWaawB7j0SuD/
         ebw0U2fEr4oVK7c7KasDtHmuqY7Ajao0oMwvFgS4QwJZr2Ls3owTa9wxl4zyC2OGsxxL
         inDg==
X-Forwarded-Encrypted: i=1; AJvYcCWqbsk/Fk4xY0TV0ACRPJEDlH56x+RhPnxOjkXUyEGWQCuMTdpl7x/KsqU5il56LxGVLxFW4QQhHf+HB0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRI/a9DylH7gPr9Z0HijzqWJf1XddD2cIF78Bb1lp9E97b3APD
	aLTJ56Mz7Hg2Jtw1WaJdmVFzlEiezs041qT0OzqFCITBk7HUW7uTGiB8FssEPYtXiWXqa2SvGPA
	inAf8+xjfThfNwHvP+bJ7PvY9vVi5VqnzvEtVfEG6s4KDNJfR0KTZMNI=
X-Google-Smtp-Source: AGHT+IG1bHHi2lrQPNYamH2hQw54PL7IvywqSZ10B1qPghN9iqPDzd/iIhDIsxYlIIV1ximBNmN6paRHLaiv+i7EZ3AodxEkCKeD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:3a3:b439:5d09 with SMTP id
 e9e14a558f8ab-3a4ed292f98mr153107255ab.11.1730249009934; Tue, 29 Oct 2024
 17:43:29 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:43:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67218131.050a0220.4735a.0265.GAE@google.com>
Subject: [syzbot] [bfs?] general protection fault in bfs_get_block (3)
From: syzbot <syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com>
To: aivazian.tigran@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c71f8fb4dc91 Merge tag 'v6.12-rc4-smb3-client-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121c2a87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=f51a2a34984e4d8888fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169e84a7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c71f8fb4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a47500c947a2/vmlinux-c71f8fb4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8ce30ea9c33/bzImage-c71f8fb4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/01cd1174fb5c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 UID: 0 PID: 7369 Comm: syz.0.496 Not tainted 6.12.0-rc4-syzkaller-00256-gc71f8fb4dc91 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bfs_move_block fs/bfs/file.c:43 [inline]
RIP: 0010:bfs_move_blocks fs/bfs/file.c:57 [inline]
RIP: 0010:bfs_get_block+0xa75/0xb70 fs/bfs/file.c:126
Code: 00 41 8b 0f b8 77 7f ff ff 21 c1 81 c9 08 80 00 00 4c 89 ef 4c 89 f6 e8 29 14 a0 ff 49 89 c5 48 8d 68 28 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 6c 7b 7b ff 4c 8b 75 00 48 8d 7b
RSP: 0018:ffffc9000d36ec50 EFLAGS: 00010206
RAX: 0000000000000005 RBX: ffff888045ebdae0 RCX: ffff88801fa40000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000028 R08: ffffffff822344c7 R09: 1ffffd40002594b6
R10: dffffc0000000000 R11: fffff940002594b7 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000043 R15: ffff888031cfce68
FS:  0000555581ad0500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020007000 CR3: 0000000044902000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2121
 block_write_begin+0x8f/0x120 fs/buffer.c:2231
 bfs_write_begin+0x35/0xd0 fs/bfs/file.c:179
 generic_perform_write+0x344/0x6d0 mm/filemap.c:4054
 generic_file_write_iter+0xae/0x310 mm/filemap.c:4181
 __kernel_write_iter+0x42a/0x940 fs/read_write.c:616
 __kernel_write+0x120/0x180 fs/read_write.c:636
 __dump_emit+0x237/0x360 fs/coredump.c:807
 elf_core_dump+0x360a/0x4770 fs/binfmt_elf.c:2100
 do_coredump+0x2162/0x2ec0 fs/coredump.c:758
 get_signal+0x13fc/0x1740 kernel/signal.c:2902
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x79/0x280 kernel/entry/common.c:231
 exc_page_fault+0x590/0x8c0 arch/x86/mm/fault.c:1542
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7ff939d7e721
Code: 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 73 01 <c3> 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
RSP: 002b:ffffffffffffffe0 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007ff939f35f80 RCX: 00007ff939d7e719
RDX: 0000000000000000 RSI: ffffffffffffffe0 RDI: 0000000004008011
RBP: 00007ff939df132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ff939f35f80 R14: 00007ff939f35f80 R15: 000000000000130d
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bfs_move_block fs/bfs/file.c:43 [inline]
RIP: 0010:bfs_move_blocks fs/bfs/file.c:57 [inline]
RIP: 0010:bfs_get_block+0xa75/0xb70 fs/bfs/file.c:126
Code: 00 41 8b 0f b8 77 7f ff ff 21 c1 81 c9 08 80 00 00 4c 89 ef 4c 89 f6 e8 29 14 a0 ff 49 89 c5 48 8d 68 28 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 6c 7b 7b ff 4c 8b 75 00 48 8d 7b
RSP: 0018:ffffc9000d36ec50 EFLAGS: 00010206
RAX: 0000000000000005 RBX: ffff888045ebdae0 RCX: ffff88801fa40000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000028 R08: ffffffff822344c7 R09: 1ffffd40002594b6
R10: dffffc0000000000 R11: fffff940002594b7 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000043 R15: ffff888031cfce68
FS:  0000555581ad0500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020007000 CR3: 0000000044902000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	41 8b 0f             	mov    (%r15),%ecx
   3:	b8 77 7f ff ff       	mov    $0xffff7f77,%eax
   8:	21 c1                	and    %eax,%ecx
   a:	81 c9 08 80 00 00    	or     $0x8008,%ecx
  10:	4c 89 ef             	mov    %r13,%rdi
  13:	4c 89 f6             	mov    %r14,%rsi
  16:	e8 29 14 a0 ff       	call   0xffa01444
  1b:	49 89 c5             	mov    %rax,%r13
  1e:	48 8d 68 28          	lea    0x28(%rax),%rbp
  22:	48 89 e8             	mov    %rbp,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 ef             	mov    %rbp,%rdi
  33:	e8 6c 7b 7b ff       	call   0xff7b7ba4
  38:	4c 8b 75 00          	mov    0x0(%rbp),%r14
  3c:	48                   	rex.W
  3d:	8d                   	.byte 0x8d
  3e:	7b                   	.byte 0x7b


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

