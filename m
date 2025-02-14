Return-Path: <linux-kernel+bounces-514472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41E3A35775
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059453AA54C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D0B20370C;
	Fri, 14 Feb 2025 06:55:22 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A34E1DE8B6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516121; cv=none; b=FOKSD4eBtVUEMZHcziQ74J64WYQJ34HeD0Fisqv743mNeRgiJ3AfCWJ6ZKLXjpGV8rOWobtvusrre91tHXOdDtRdsIII0VfWpjM43w70O5S4XAkQy9t+3im0HmLhj9U//wg+Gz+jUvmwkzzn240nJ+CzXE2HEFzU5D+YFvHkUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516121; c=relaxed/simple;
	bh=a73UfzxNIq/V2/0VlnPixRfE7CtnBAjp4UW9qxdoE5w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rYN2QdrWuZoMmvDNLQb4H4G8ZFcMQ5QKn+nzNlKiPc7QPz/DvLUiHdKSraSjZyqEXnXucs8cYaqL31g3dhgVBExdMFqkJpaLWr410NzCz92shPMIjZoCeYOP3dIKkoMJq778fiso8DK7wWBfVVVRZxj8CkeAxb+cmFlfmDPJGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d145b7ba54so11229475ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739516119; x=1740120919;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvhSJKlXu2vdv5jVgpbCFsB6zIQDcJPgAt6yW1vxj1E=;
        b=OrTDoXt3hoqUvRafv0uQRepKz9BOo0XXHBz5u/MH3nwIKaUbL9Iahvn05KlE1aB69F
         eEuobuUb7Y7VDya1AhMDSouM5Bda4pJFxEKek03J0H0/t08Lj45KpfrrssJfx3chbO2k
         io3fhhW9VYlyDZ9NHHG/KpppVX/z/i8kKJYEVpfrS79u79+yA6+3rO+1yK+km4dGFmIr
         +0LB/pZOonfYY9Ob86kWv/8rredBBm5D/kJuEN0gaMKzZhktnpI2Khg1KeCxh7UniVm5
         slwIQB7/c7HLkK87P9aBOhALS6T4guYOtrh3jKBcq+QZ03Q1dzaIKQlNErWBVodPRBWq
         dq9w==
X-Forwarded-Encrypted: i=1; AJvYcCV+vjsafwIt1fJ9YpU48cG7vYaCjD4Mcy6GGDoZAf9FvklcILNAAW7WNVWP+VTgsAmmFGEfyY5qH9fPlhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIE+fPsMI0opRQcyfKfNDZXuDERMZcUv2STlvwFWeqtPM5cUmm
	rwi7utvkHwTKFk31goJRqggA4NrNWQS3OeBnlB++1eX3tbJKgyqzH3eawJAsKeNUpC4W/62+UtO
	3pMtiC/JVRPzUtAvnRFurr5aqPr7T0y2TXV2/zQ3ubP0dC8fef9Q6lYM=
X-Google-Smtp-Source: AGHT+IGh3j1qyeR4o8P2RJa9XV053OJv8zmkAXSP2xAWhm1Z5foIkp1IIK3xIlB9NxRvTWnlCDzJ4j3Qebi/68HD+orFqlAB1icj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c7:b0:3d0:4eaa:e480 with SMTP id
 e9e14a558f8ab-3d18c2151e9mr45166905ab.3.1739516119060; Thu, 13 Feb 2025
 22:55:19 -0800 (PST)
Date: Thu, 13 Feb 2025 22:55:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67aee8d7.050a0220.21dd3.0031.GAE@google.com>
Subject: [syzbot] [ntfs3?] BUG: unable to handle kernel paging request in mi_init
From: syzbot <syzbot+8282d8328968be03242e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ab68d7eb7b1a Merge tag 'loongarch-fixes-6.14-1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c281b8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c2347dd6174fbe2
dashboard link: https://syzkaller.appspot.com/bug?extid=8282d8328968be03242e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ab68d7eb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c21c98f96a97/vmlinux-ab68d7eb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d84966ad5d14/bzImage-ab68d7eb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8282d8328968be03242e@syzkaller.appspotmail.com

UDPLite6: UDP-Lite is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Different NTFS sector size (1024) and media sector size (512).
BUG: unable to handle page fault for address: ffffed110a52075b
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 5ffcd067 P4D 5ffcd067 PUD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5319 Comm: syz.0.0 Not tainted 6.14.0-rc2-syzkaller-00056-gab68d7eb7b1a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:mi_init+0x86/0xe0 fs/ntfs3/record.c:105
Code: 89 f0 48 c1 e8 03 42 0f b6 04 20 84 c0 75 5d 41 8b 3e be 40 0c 00 00 e8 18 91 00 ff 48 89 c5 48 83 c3 20 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 9b ed 0b ff 48 89 2b 31 c9 48 85
RSP: 0018:ffffc9000d2f7690 EFLAGS: 00010a06
RAX: 1ffff1100a52075c RBX: ffff888052903ae0 RCX: 0000000000000800
RDX: 0000000000000400 RSI: ffffffff8c608ca0 RDI: ffffffff8c608c60
RBP: ffff8880367f4000 R08: 0000000000000c40 R09: 00000000ffffffff
R10: dffffc0000000000 R11: fffffbfff285f729 R12: dffffc00ffffffff
R13: ffff888035c16000 R14: ffff888035c16030 R15: 000000000000000a
FS:  00007fec9fdc16c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed110a52075b CR3: 00000000432c4000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ntfs_read_mft fs/ntfs3/inode.c:54 [inline]
 ntfs_iget5+0x372/0x3800 fs/ntfs3/inode.c:540
 ntfs_fill_super+0x3e8e/0x4730 fs/ntfs3/super.c:1477
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fec9ef8e58a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fec9fdc0e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fec9fdc0ef0 RCX: 00007fec9ef8e58a
RDX: 000040000001f800 RSI: 000040000001f840 RDI: 00007fec9fdc0eb0
RBP: 000040000001f800 R08: 00007fec9fdc0ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000040000001f840
R13: 00007fec9fdc0eb0 R14: 000000000001f813 R15: 0000400000000040
 </TASK>
Modules linked in:
CR2: ffffed110a52075b
---[ end trace 0000000000000000 ]---
RIP: 0010:mi_init+0x86/0xe0 fs/ntfs3/record.c:105
Code: 89 f0 48 c1 e8 03 42 0f b6 04 20 84 c0 75 5d 41 8b 3e be 40 0c 00 00 e8 18 91 00 ff 48 89 c5 48 83 c3 20 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 9b ed 0b ff 48 89 2b 31 c9 48 85
RSP: 0018:ffffc9000d2f7690 EFLAGS: 00010a06
RAX: 1ffff1100a52075c RBX: ffff888052903ae0 RCX: 0000000000000800
RDX: 0000000000000400 RSI: ffffffff8c608ca0 RDI: ffffffff8c608c60
RBP: ffff8880367f4000 R08: 0000000000000c40 R09: 00000000ffffffff
R10: dffffc0000000000 R11: fffffbfff285f729 R12: dffffc00ffffffff
R13: ffff888035c16000 R14: ffff888035c16030 R15: 000000000000000a
FS:  00007fec9fdc16c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed110a52075b CR3: 00000000432c4000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 f0                	mov    %esi,%eax
   2:	48 c1 e8 03          	shr    $0x3,%rax
   6:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax
   b:	84 c0                	test   %al,%al
   d:	75 5d                	jne    0x6c
   f:	41 8b 3e             	mov    (%r14),%edi
  12:	be 40 0c 00 00       	mov    $0xc40,%esi
  17:	e8 18 91 00 ff       	call   0xff009134
  1c:	48 89 c5             	mov    %rax,%rbp
  1f:	48 83 c3 20          	add    $0x20,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 9b ed 0b ff       	call   0xff0bedd4
  39:	48 89 2b             	mov    %rbp,(%rbx)
  3c:	31 c9                	xor    %ecx,%ecx
  3e:	48                   	rex.W
  3f:	85                   	.byte 0x85


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

