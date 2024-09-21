Return-Path: <linux-kernel+bounces-334989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0DE97DF67
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 00:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26361C20B65
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB972154BFE;
	Sat, 21 Sep 2024 22:28:21 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54311547CD
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726957701; cv=none; b=e1m8C9svu5YxXz8ZVBQV3vHGd8jHCQB52IQHmmNLwcUxy2aOds2iji5+zSX10XYh0+9jBH+K1Zgf5+A/uRSTDhWdxu7mfxEZhbx2W/+AHV2bg9U7i99EJ1JbjurnRhNmJa64gXDn1qINJDmAyCGGCf2jhv35/AfvhARbGoEix/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726957701; c=relaxed/simple;
	bh=0Q4HkTh2bOZXe5TULkbzgJQ1zgaw36FPGS6nye4B3OU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I94s34fHstkLXr84aveESiBs4ljS9kBlydFm+Iwo+GJwoCPtVtSGH0h3/TwVrEvS7GXz1mKsLMzKU/D0sMFRn1+Lao58rodgKIzNXeAk4+cEWbdflF8CfCMrwjy7AYL1mczybB+F9n6s5UB7stjOPIBp8QhMWfzif/rkWe8+toM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0ce7e621aso14266195ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 15:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726957699; x=1727562499;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jYY8LyLfZxvZNrxt0J8hPTdfzursAHXph1TedcuT3I=;
        b=pN3BZiAwWlAoleqCGMM6Bt+HVUpWLfI9IfLCcXuIUf3pelsYI3IQF16vs6qa/XIrKj
         Vgtm1bidAf4lfOfIB21rvFdipPx55yVx/faIBfI3lKv/rZocN/6wDQ2X4gGy4lTCUMnB
         PeBuQ4dllW5/7EXib0CitEt8aKsKi0wKb7uUVTJofL+dx3FdQfLiKkdixTJPFzPFjQOs
         X6K+Qz1ByYoP+3er044yP6LtLXVClGtx4f5ErzI4/F5ZUDRTgihjA7qZ0Cb6TUMIQ+lq
         GDfLi+guNrAbVaHqdOhHdV3i5fe29rW7TtI9Y8MVPYsBB9/JNxDr0ueSK+YM6GtXzADw
         SFMQ==
X-Gm-Message-State: AOJu0YyOqgMIiTLsaErmE/Kf7wNQrjywP5tO/ThsZkTx0Ht22tA6Ow88
	qM/OGUrEPeK+0OXZGoexgY//TPLxJ+VPjyRe9VFWZR6Dk0WKSFf6KmfbCpFA0FxK27XWMqU+IjO
	AyVyVUoxqkwrTlGZxEQsNMvT0j27DszAoYqp+7SO/jVTsB/b+9uSd1dc=
X-Google-Smtp-Source: AGHT+IHFMznQt1tZzezDV7UK5B3djkLkpISyXVd96kJQUAgfhCxrA1sKBYyH+t59tUtdgoQP+0DegfBL07YRYeMvVIqpSMG0RKuU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1805:b0:3a0:ab71:ed38 with SMTP id
 e9e14a558f8ab-3a0c9d39acfmr65726875ab.14.1726957698753; Sat, 21 Sep 2024
 15:28:18 -0700 (PDT)
Date: Sat, 21 Sep 2024 15:28:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ef4882.050a0220.3195df.006e.GAE@google.com>
Subject: [syzbot] [sound?] kernel BUG in snd_pcm_mmap_data_fault
From: syzbot <syzbot+4bf62a7b1d0f4fdb7ae2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13691207980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a69c66e868285a9d
dashboard link: https://syzkaller.appspot.com/bug?extid=4bf62a7b1d0f4fdb7ae2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a430d95c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c522024ada4/vmlinux-a430d95c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b20faf992428/bzImage-a430d95c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4bf62a7b1d0f4fdb7ae2@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 UID: 0 PID: 6703 Comm: syz.3.325 Not tainted 6.11.0-syzkaller-02574-ga430d95c5efa #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__phys_addr+0xd8/0x150 arch/x86/mm/physaddr.c:28
Code: 48 d3 e8 48 89 c5 48 89 c6 e8 04 ee 4c 00 48 85 ed 75 11 e8 8a eb 4c 00 48 89 d8 5b 5d 41 5c c3 cc cc cc cc e8 79 eb 4c 00 90 <0f> 0b e8 71 eb 4c 00 48 c7 c0 10 60 ba 8d 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc9000c01f550 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000778000000000 RCX: ffffffff813e38c0
RDX: ffff888024ecc880 RSI: ffffffff813e3947 RDI: 0000000000000006
RBP: 0000000080000000 R08: 0000000000000006 R09: 0000000080000000
R10: 0000778000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88801e93d000 R15: ffffc9000c01f680
FS:  0000000000000000(0000) GS:ffff88802b800000(0063) knlGS:00000000f5716b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020bff000 CR3: 0000000025f2a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 snd_pcm_mmap_data_fault+0x3f2/0x4c0 sound/core/pcm_native.c:3793
 __do_fault+0x10a/0x490 mm/memory.c:4672
 do_read_fault mm/memory.c:5078 [inline]
 do_fault mm/memory.c:5208 [inline]
 do_pte_missing mm/memory.c:3964 [inline]
 handle_pte_fault mm/memory.c:5538 [inline]
 __handle_mm_fault+0x3b47/0x5470 mm/memory.c:5681
 handle_mm_fault+0x498/0xa60 mm/memory.c:5849
 faultin_page mm/gup.c:1207 [inline]
 __get_user_pages+0x475/0x15c0 mm/gup.c:1506
 __get_user_pages_locked mm/gup.c:1773 [inline]
 __gup_longterm_locked+0x22e/0x1b30 mm/gup.c:2502
 pin_user_pages_remote+0xee/0x150 mm/gup.c:3541
 process_vm_rw_single_vec mm/process_vm_access.c:106 [inline]
 process_vm_rw_core.constprop.0+0x439/0x9f0 mm/process_vm_access.c:216
 process_vm_rw+0x301/0x360 mm/process_vm_access.c:284
 __do_sys_process_vm_readv mm/process_vm_access.c:296 [inline]
 __se_sys_process_vm_readv mm/process_vm_access.c:292 [inline]
 __ia32_sys_process_vm_readv+0xdf/0x1b0 mm/process_vm_access.c:292
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f92579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f571656c EFLAGS: 00000296 ORIG_RAX: 000000000000015b
RAX: ffffffffffffffda RBX: 00000000000000e8 RCX: 0000000020008400
RDX: 0000000000000002 RSI: 0000000020000400 RDI: 00000000000002db
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0xd8/0x150 arch/x86/mm/physaddr.c:28
Code: 48 d3 e8 48 89 c5 48 89 c6 e8 04 ee 4c 00 48 85 ed 75 11 e8 8a eb 4c 00 48 89 d8 5b 5d 41 5c c3 cc cc cc cc e8 79 eb 4c 00 90 <0f> 0b e8 71 eb 4c 00 48 c7 c0 10 60 ba 8d 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc9000c01f550 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000778000000000 RCX: ffffffff813e38c0
RDX: ffff888024ecc880 RSI: ffffffff813e3947 RDI: 0000000000000006
RBP: 0000000080000000 R08: 0000000000000006 R09: 0000000080000000
R10: 0000778000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88801e93d000 R15: ffffc9000c01f680
FS:  0000000000000000(0000) GS:ffff88802b800000(0063) knlGS:00000000f5716b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00005583dfdec000 CR3: 0000000025f2a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

