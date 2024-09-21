Return-Path: <linux-kernel+bounces-334894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2373597DE08
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660381F2194A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CBF175D2F;
	Sat, 21 Sep 2024 17:06:23 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBAE219F3
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726938382; cv=none; b=HvRFaoHvEKKgoWbeSbw7BteL4yLcDXmMRjghdxM77xVHQG2J8saWq7gpuqWDVlHLG4Cf8OqLE66xasb4v0yehtTHrnQlCM6Mp5TefdPs1wvEzDeEiwp0OSREurgI49BNHEuFr25jDxhsnrmLtSKvJKRfKBT1O9sOQcchXhXjQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726938382; c=relaxed/simple;
	bh=dtVUXWX+rLy/VTMfxaQ29uYYsqXrbsb30iG99nf3t5g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KXqTQd1anbyw7dYY9l7GHqQx9t23GsnhkNLSUnVgPcACzAxsAp6QdxKa4kSesVTmzdUXO5RxSP0BrQiafzBwrMPXCn42ffKY0+tYHWYVcUis5z5+GUfvm/K/iTizeAzo9AlvuWJDCtliHxgNizQJz9n1enSOBQ82232Gn35gCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cda2c8997so383433239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 10:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726938380; x=1727543180;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afaAwm0b14XWvBj1DX4vRJoa4sjFMZOweDbI+pSrVkw=;
        b=dzleJXEBWH7A15rEu1ZOfthnRXVO566lISuci8QQp46pmqdNjTSzXZdc2DIV+LIOa5
         oYhTYlPeCgDSd0vO1Z6Lp6qcFMMRNIIefiSnIr1Dxf8lCTtxJ6zqOpzTe9xLj2SRE3oi
         sYYRvWKdOblwATXsW0RQyu74l+b2FV2e5GTIH5IRl7/M08twXnrizphlGFsyr6ryO5oC
         OBZxdWpjWYW8Aha01kIKPtO54LCfBVND21zytMZXLVAkGjZ22eEwnuhWeLp+8M1vUG+9
         FUxHOJqHoqfC6kb0NUjN5oncwAnQvZ8wOA7c8zImv97/w5GSD3595fOqmisVEyUr/4GH
         19Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Z9aUZqq/eOR34+20evnhuyF0NitQwk+x2Ieuq9u5/rh03d0+mfv/0uUOqoEpYeSDfKmcaqMC8SD1Mr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiXGnwf6UbC3csQclLskINW+VVjhjfg6OOwy6Wm7ooj80Wg1D
	ylN190tH0tzuaxOa1Cv6TT1GxnZKIDkVA5yJpAj5xPuazN9ofkthSrmIbqoMbP8Uz/KMEgskE1w
	Jelnc8LniZO0hw71yp8GvdeiBKfWVRHoLg7LMYxlOlj66PyAwlwiC1rc=
X-Google-Smtp-Source: AGHT+IGYLenllcxlkXPoIoruSqoN6o/CaZI2uvM6FTcCCUZUjQqHrDD0NHIvXBfHuss4E8DYK4KBoUHp6dldzxWOfMTaGrx4Y8bb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c544:0:b0:3a0:91e7:67cc with SMTP id
 e9e14a558f8ab-3a0c8ceecd2mr63888635ab.13.1726938380225; Sat, 21 Sep 2024
 10:06:20 -0700 (PDT)
Date: Sat, 21 Sep 2024 10:06:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eefd0c.050a0220.3195df.0061.GAE@google.com>
Subject: [syzbot] [udf?] general protection fault in udf_read_folio
From: syzbot <syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a940d9a43e62 Merge tag 'soc-arm-6.12' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1099869f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1653f803fffa3848
dashboard link: https://syzkaller.appspot.com/bug?extid=ddf8715339c89280b6fc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d53500580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134c3fc7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a940d9a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/371e11b6a9e5/vmlinux-a940d9a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/920eb0c53785/bzImage-a940d9a4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2a8d27ffca62/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
./file1: Can't lookup blockdev
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
CPU: 0 UID: 0 PID: 5113 Comm: syz-executor381 Not tainted 6.11.0-syzkaller-03917-ga940d9a43e62 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:file_inode include/linux/fs.h:1123 [inline]
RIP: 0010:udf_read_folio+0x2b/0xc0 fs/udf/inode.c:223
Code: 0f 1e fa 41 57 41 56 41 54 53 49 89 f6 48 89 fb 49 bc 00 00 00 00 00 fc ff df e8 e0 1d 75 fe 48 83 c3 68 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 c6 62 dc fe 49 c7 c7 e8 fe ff ff
RSP: 0018:ffffc9000179f9d8 EFLAGS: 00010202
RAX: 000000000000000d RBX: 0000000000000068 RCX: ffff888000eac880
RDX: 0000000000000000 RSI: ffffea000002ecc0 RDI: 0000000000000000
RBP: ffffc9000179fac0 R08: ffffea000002ecc7 R09: 1ffffd4000005d98
R10: dffffc0000000000 R11: ffffffff831f0c40 R12: dffffc0000000000
R13: 1ffffd4000005d99 R14: ffffea000002ecc0 R15: ffffea000002ecc8
FS:  0000555563e91380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f57a987fe00 CR3: 000000003dd1a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 filemap_read_folio+0x1a0/0x790 mm/filemap.c:2355
 do_read_cache_folio+0x134/0x820 mm/filemap.c:3796
 read_mapping_folio include/linux/pagemap.h:915 [inline]
 erofs_bread+0x499/0xd40 fs/erofs/data.c:41
 erofs_read_superblock fs/erofs/super.c:277 [inline]
 erofs_fc_fill_super+0x345/0x1770 fs/erofs/super.c:621
 vfs_get_super fs/super.c:1280 [inline]
 get_tree_nodev+0xb7/0x140 fs/super.c:1299
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f57b1c85309
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe09300b48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f57b1c85309
RDX: 00000000200005c0 RSI: 0000000020000580 RDI: 0000000020000540
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000004400
R10: 0000000000200000 R11: 0000000000000246 R12: 00007ffe09300b90
R13: 00007ffe09300bd0 R14: 0000000000080000 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:file_inode include/linux/fs.h:1123 [inline]
RIP: 0010:udf_read_folio+0x2b/0xc0 fs/udf/inode.c:223
Code: 0f 1e fa 41 57 41 56 41 54 53 49 89 f6 48 89 fb 49 bc 00 00 00 00 00 fc ff df e8 e0 1d 75 fe 48 83 c3 68 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 c6 62 dc fe 49 c7 c7 e8 fe ff ff
RSP: 0018:ffffc9000179f9d8 EFLAGS: 00010202
RAX: 000000000000000d RBX: 0000000000000068 RCX: ffff888000eac880
RDX: 0000000000000000 RSI: ffffea000002ecc0 RDI: 0000000000000000
RBP: ffffc9000179fac0 R08: ffffea000002ecc7 R09: 1ffffd4000005d98
R10: dffffc0000000000 R11: ffffffff831f0c40 R12: dffffc0000000000
R13: 1ffffd4000005d99 R14: ffffea000002ecc0 R15: ffffea000002ecc8
FS:  0000555563e91380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f57a987fe00 CR3: 000000003dd1a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	0f 1e fa             	nop    %edx
   3:	41 57                	push   %r15
   5:	41 56                	push   %r14
   7:	41 54                	push   %r12
   9:	53                   	push   %rbx
   a:	49 89 f6             	mov    %rsi,%r14
   d:	48 89 fb             	mov    %rdi,%rbx
  10:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
  17:	fc ff df
  1a:	e8 e0 1d 75 fe       	call   0xfe751dff
  1f:	48 83 c3 68          	add    $0x68,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 c6 62 dc fe       	call   0xfedc62ff
  39:	49 c7 c7 e8 fe ff ff 	mov    $0xfffffffffffffee8,%r15


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

