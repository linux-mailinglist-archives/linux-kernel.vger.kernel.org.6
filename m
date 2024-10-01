Return-Path: <linux-kernel+bounces-346670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B7A98C756
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973C31F2520B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C351CCECE;
	Tue,  1 Oct 2024 21:10:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D191BDAAA
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817027; cv=none; b=ZpRV+DeXpH0DVtUIfHDH9ixVa6Es9CQsMio4Gva3JG2Hg/9ayUgbmrVdupu6oUB9PFa66ZXUuTUNBcnrU8JRDowvtoVEdc8cfR8PcGizI5tAfGYaETr38fNHCT3yF0gpB8f0pCbYx4Xy/xpglnek3fqjxrwEzVsk5CylBZ7grGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817027; c=relaxed/simple;
	bh=nzZXE2rFDxJpGlUmCzAifj6nniiHNmhksCcqZL53Uak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YKm12pFOE8JbwLqyl2hk86SA9uqlmeUCFf0laXnV7nLwdcQyw7Ak/bntPIRHUq0gCu77b0rWNe0SO6CxEvgVGm/hND1sLn8NdZT846ZO2AuL5nGuvtvNnX1E5lMTexnnJ5QXXn7+CqM67UuLfuK11qi6UmFaAWNC5ewIk4pgiDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cf261659bso903995039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 14:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727817025; x=1728421825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flCnjCcVqWpBCsKfIc7rz2J7R5LekLi7bYR8D+2EVXs=;
        b=WAQnW2Z0AWxvYrxO0G5p2y/SOUS43vpoFbeWe7qlFi+0+9CsbEHuGbGnmkCR0T2D0C
         3l8j01LvLL9Bqb3ayNMAP/tx9uNM4CBE+pAuOU2kE5faaJRhaDexFYnkkmLSrJm9Qt4c
         kJODy1ByJJv9BodUbGJE1YLC4oPzOWj+hZnyfKreSdAfk7/+EeMigKixFuw8B0TjE5hE
         tuhOAMBW7vj9plO1g96FmERc/ZIVGYVI9F7gnKImzR/7G9r1SHU3RS/tMHWimBqM3oM6
         wl0qwl3JDO9QF268M3hj3J1dtOlvWT18kDrN6LLjERH/OE8PBJAFS/jrW1/ls9/FgmeK
         iHbg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Iby08Obgh4TeRKzi+tmqsIo3Hjml+6iHmG9iSXivpjNLj4C1v9+UO15jRoVJfcTrmi/zGETRfJoEzjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+W3SI19yV0VNxCoKRh5XyzhQ6FrJ06A1yM1vPgJ0qDCvjKbz7
	T91GjG3q3lX8vvnyROe8d2MUI6q+72TdlwZeQCwy1R8+gj/WKEq5NhghBF2CIJLPYah2xZ+5nId
	cH1yJ9yenXG7XbScfw0wqRVd11WyusJ/CKu61i2To6EUr6qKxW6pDpWQ=
X-Google-Smtp-Source: AGHT+IGf7QW1B3RGDu1SWJij9uerLEYcsa9Fo+vCtGybZV7Z6+V0mH+NxWZM6/3vejmAWdACuq4XmEDwDySrM3Jp3ssZX7KTq3cB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cf:b0:3a0:a641:b7c7 with SMTP id
 e9e14a558f8ab-3a3659182ccmr8725995ab.4.1727817024957; Tue, 01 Oct 2024
 14:10:24 -0700 (PDT)
Date: Tue, 01 Oct 2024 14:10:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc6540.050a0220.f28ec.04d3.GAE@google.com>
Subject: [syzbot] [v9fs?] WARNING in v9fs_mount
From: syzbot <syzbot+1c018c127418a60b7e34@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e477dba5442c Merge tag 'for-6.12/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1201de27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35e823d88dbbbfe5
dashboard link: https://syzkaller.appspot.com/bug?extid=1c018c127418a60b7e34
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e477dba5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b9ec64056ebb/vmlinux-e477dba5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/87b5c9bcdaed/bzImage-e477dba5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c018c127418a60b7e34@syzkaller.appspotmail.com

------------[ cut here ]------------
kmem_cache of name '9p-fcall-cache' already exists
WARNING: CPU: 3 PID: 9437 at mm/slab_common.c:107 kmem_cache_sanity_check mm/slab_common.c:107 [inline]
WARNING: CPU: 3 PID: 9437 at mm/slab_common.c:107 __kmem_cache_create_args+0xb0/0x3c0 mm/slab_common.c:294
Modules linked in:
CPU: 3 UID: 0 PID: 9437 Comm: syz.2.942 Not tainted 6.11.0-syzkaller-11624-ge477dba5442c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:107 [inline]
RIP: 0010:__kmem_cache_create_args+0xb0/0x3c0 mm/slab_common.c:294
Call Trace:
 v9fs_mount+0xc6/0xa50 fs/9p/vfs_super.c:122
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1800
 do_new_mount fs/namespace.c:3507 [inline]
 path_mount+0x6e1/0x1f10 fs/namespace.c:3834
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
RDX: 00000000200004c0 RSI: 0000000000000000 RDI: 0000000000000000
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x3d/0x1f0 lib/dump_stack.c:120
 check_panic_on_warn+0xab/0xb0 kernel/panic.c:243
 __report_bug lib/bug.c:199 [inline]
 report_bug+0x3c0/0x580 lib/bug.c:219
 handle_bug+0x54/0xa0 arch/x86/kernel/traps.c:285
 exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:309
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:107 [inline]
RIP: 0010:__kmem_cache_create_args+0xb0/0x3c0 mm/slab_common.c:294
Code: 98 48 3d d0 b7 f1 8d 74 25 48 8b 7b 60 48 89 ee e8 b5 06 33 09 85 c0 75 e0 90 48 c7 c7 30 f7 57 8d 48 89 ee e8 b1 cc 7e ff 90 <0f> 0b 90 90 be 20 00 00 00 48 89 ef e8 3f 08 33 09 48 85 c0 0f 85
RSP: 0018:ffffc9000e2c78f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888022e33b80 RCX: ffffc9002afd6000
RDX: 0000000000040000 RSI: ffffffff814dc916 RDI: 0000000000000001
RBP: ffffffff8ca1d8e0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000020018 R14: ffffc9000e2c79e0 R15: 0000000000020018
 kmem_cache_create_usercopy include/linux/slab.h:361 [inline]
 p9_client_create+0xe04/0x1150 net/9p/client.c:1042
 v9fs_session_init+0x1f8/0x1a80 fs/9p/v9fs.c:410
 v9fs_mount+0xc6/0xa50 fs/9p/vfs_super.c:122
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1800
 do_new_mount fs/namespace.c:3507 [inline]
 path_mount+0x6e1/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount fs/namespace.c:4032 [inline]
 __ia32_sys_mount+0x292/0x310 fs/namespace.c:4032
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f85579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f570656c EFLAGS: 00000296 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000200001c0 RCX: 0000000020000480
RDX: 00000000200004c0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..
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

