Return-Path: <linux-kernel+bounces-195624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1022C8D4F72
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F78284F15
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E4200C1;
	Thu, 30 May 2024 15:51:39 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6641CD2C
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084299; cv=none; b=GPtIUNtpByJgSgqAmn529347gy+lA1vMP33RrojqWCCZLyb9lvAo6hhpDBmkfwVvPHDyYRnmPQ+PbvfG0IkP6M5Gzyaf4Fv6YtUl5lfs5Zl8vdjBVn6X8Ilg/NDMoSrIsV8LKQoZP8VBe+O69MP69sYeIK9tG+Aw4A/1b0f359E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084299; c=relaxed/simple;
	bh=AAg3yoZ6XeD1rZzVE91N4sCZcy/sC+u/wpdxd7uREec=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P1/AYSHIuBaW5cHTpVkwAuNCsYJduQAjDIRINUWku4TVRh5hxNQuBPCVnShp0+hYTVgtzbubWOj2zRlh0Id43A7rJiz6KhyLotyMMlchUl+SPSZN7tp9PruEjzQwxgOC2zmHAncFWshjCPGq7kfBYDLV7GqjEeA/izfEZ2VTRRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3748623a318so4290985ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717084296; x=1717689096;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MaeDsf45jssNtIrMiWd2xRsbDJ1KDWb4jZqvegllXqQ=;
        b=uIRGVXpPQ92xmLoIsJD+tL3R4FvJvBtmbrZNBzmcv/CiR2HWO/Kasf3QF71SUksOiA
         g/zm+RRE4jTHjmefoYQmVBmkbTaQr0JZ1b/OHNEvGs75EJnaPOZbip+dakGPJgLZE3dg
         eNi+cx+RrznquxctxxU489/lbzu0FS9oRl53y9jM1aMtpOsnrygqNR3Ek3AGSgkA+oWY
         mrI/dGHn+2l1VFFt1J+FkGvIgvyKmt1buUNhUW9ngcrEuWZO+g869j1QQL2kCsSILM6F
         Z/B8/aNeC8mbrYvn1XdauFR4WivTE80sfJuCv9beVmmFXXE6MGPfrXM7KSu6gy8Sxq16
         HQdA==
X-Forwarded-Encrypted: i=1; AJvYcCXhzrDHdxrdVdX9M77V0GInITXXIUSQi56bi0cFKCz0zNczl3gE1OqeHGQh6yqQQsnSmxXLbeA0aIGhcQmX5XHiMTIBPzEuwUyZYHPL
X-Gm-Message-State: AOJu0YztG0AEYf+JFeeeGbKm8ca7adEtZRMxbaAukdiB145UATtJR/2Z
	SuIGHhDNs1nHu/wFlodwSR0UfqWqroU9OyCKBptG45B7PGPmEfrqzmd57OSJ5fqFNCtmbDZGBGy
	D2EQSyUVdll//GX0/kspyo2ztVfxf7775c48juWaf8aBwzYBzlzf5BFQ=
X-Google-Smtp-Source: AGHT+IHQF7r6jOFYLi6+dhAtJYuZs50Qwkgwh8LAtSH3GPe4KMX69EjuzFiz5n0jZr95OoANfKc4NI/+4VcmJPH/wfvNVoYekXax
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:374:598b:3fec with SMTP id
 e9e14a558f8ab-3747dfcb08amr1261245ab.5.1717084296702; Thu, 30 May 2024
 08:51:36 -0700 (PDT)
Date: Thu, 30 May 2024 08:51:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008dfcc10619add74a@google.com>
Subject: [syzbot] [xfs?] WARNING: locking bug in xfs_inode_mark_reclaimable
From: syzbot <syzbot+07620ae683e780f6a943@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c13320499ba0 Merge tag '6.10-rc-smb3-fixes-part2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1237c344980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e70c03a304f3c3ef
dashboard link: https://syzkaller.appspot.com/bug?extid=07620ae683e780f6a943
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c1332049.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d89011b261c/vmlinux-c1332049.xz
kernel image: https://storage.googleapis.com/syzbot-assets/86f1a107597e/bzImage-c1332049.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07620ae683e780f6a943@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 6275 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 6275 at kernel/locking/lockdep.c:232 hlock_class+0xfa/0x130 kernel/locking/lockdep.c:221
Modules linked in:
CPU: 0 PID: 6275 Comm: syz-executor.2 Not tainted 6.9.0-syzkaller-12398-gc13320499ba0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:hlock_class+0xfa/0x130 kernel/locking/lockdep.c:221
Code: b6 14 11 38 d0 7c 04 84 d2 75 43 8b 05 33 33 77 0e 85 c0 75 19 90 48 c7 c6 00 bd 2c 8b 48 c7 c7 a0 b7 2c 8b e8 97 47 e5 ff 90 <0f> 0b 90 90 90 31 c0 eb 9e e8 f8 f8 7f 00 e9 1c ff ff ff 48 c7 c7
RSP: 0018:ffffc90003ee7918 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000ec4 RCX: ffffffff81510229
RDX: ffff88801e15c880 RSI: ffffffff81510236 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000002d2d2d2d R12: 0000000000000000
R13: 0000000000000000 R14: ffff88801e15d3b0 R15: 0000000000000ec4
FS:  0000000000000000(0000) GS:ffff88802c000000(0063) knlGS:0000000057702400
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000005757f480 CR3: 0000000056d70000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 check_wait_context kernel/locking/lockdep.c:4773 [inline]
 __lock_acquire+0x3f2/0x3b30 kernel/locking/lockdep.c:5087
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 touch_work_lockdep_map kernel/workqueue.c:3894 [inline]
 start_flush_work kernel/workqueue.c:4148 [inline]
 __flush_work+0x477/0xc60 kernel/workqueue.c:4181
 xfs_inodegc_queue fs/xfs/xfs_icache.c:2119 [inline]
 xfs_inode_mark_reclaimable+0x6e8/0xf60 fs/xfs/xfs_icache.c:2149
 destroy_inode+0xc4/0x1b0 fs/inode.c:311
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 do_unlinkat+0x613/0x750 fs/namei.c:4414
 __do_sys_unlink fs/namei.c:4455 [inline]
 __se_sys_unlink fs/namei.c:4453 [inline]
 __ia32_sys_unlink+0xc6/0x110 fs/namei.c:4453
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf725c579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffb18bcc EFLAGS: 00000296 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00000000ffb18c70 RCX: 0000000000008000
RDX: 00000000f73b2ff4 RSI: 0000000000000000 RDI: 00000000ffb19d10
RBP: 00000000ffb18c70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
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

