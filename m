Return-Path: <linux-kernel+bounces-226457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EEF913E96
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF9C28144D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CCC1850A3;
	Sun, 23 Jun 2024 21:42:22 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85024085D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719178941; cv=none; b=TU56yd1/uOUGk19y1whgLIfD2JqKBo3eeqfMvAvQ9uwYAjywjvcOeacc33cQ/UeoRENuyX9x6K7Wv7JgfL3D/qH/wl9pXZQxB2+hXlvhI+NShPdAqBEB9GBgepjJaOM1f3K6ZCx89szdwWgcc7g7+TP8WGRlAvMcbFbvmro6Am8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719178941; c=relaxed/simple;
	bh=n8WkbQfKFP+Tm0660dvYTCTWhLFB0rtAaCFXjhVrdl8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OSPANxrMBFjdR7HqfM8LINnwGj86aTiS/kMrDrCA5m2ze4ceWZRn5vgW+SlKM7VnRSMv6TH1sTwjJ6lU2x8uf8OUc3VtCGuAPUX9QEf/dgISmY0rhpgqWCglVM/npC+wZ++iNwPOCGLSU/O1WLnlh97gIUdcSpfL7NHdONUCGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-375d2ddeffbso44867025ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719178939; x=1719783739;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rhSUyTHpYnMAQ3Y600yeB/qOpsdPrjtPt6dT1YYdmA=;
        b=ed+ob7+tZq+kd7kyc5WIHYtbO9L2LnbF80cDV+SWc+cguN2e/t/y4xrkXSayXTQzUY
         OM/ssBdLT8/EbA8QPb4nw3syPHebAQeXGFtLxWBECRrhVJ18fWrkIJ0rN4ePVdIBbDqL
         rurmHSlGduK1Y83989gsx4m8z76nuHy42EpSesT2TncZAqE/iHm1OwANd54p+dUFQXFN
         pckKuaA/AgFMx7Hj2I2LzbH3z6DTUJMP0uk1gpLlBaU+ZiuSCL6yfrTJ4li4dn1cb7yo
         AoaVfNRNPRR4HXPwuxZy/5xHC3q8escQmzxZNUUFadItpgBZNrrANybxUdAmNc6gIHXF
         xfPg==
X-Forwarded-Encrypted: i=1; AJvYcCVXj5pyxdvQo6BonYvr6XwfO4/NWRoc4DmcRS3rnCXX7z1cnufCEPlwEl+JDf9ireGcdGMNs5ZhJoEZ0rt1X2uDkmy2LURGpUJ/q+AV
X-Gm-Message-State: AOJu0YwmQxKvbTP4h/pBzaOGadHDS07aQ1V7wV2BhuiD0XEHKn8AQ3bx
	x9Za398Rr8cCG+7Rp6IvIduWM4aIZk6GzJU58l1RlCF3LatTVWeJBO+1R2W6VPZmJ4e8w3Y+6ev
	Yz0pAIfCEWighHaCY+iBD6yzZ5wh9La/NtPfC+xOjY4SND3Qnm5jQ9I8=
X-Google-Smtp-Source: AGHT+IFvACzKSZbwHs75b1ZIGtz45qBMKskOwvrlk3yXrhGsKDwc0qwBxd+g47iVzaSLbgHTKU9pOlzqp9rotLZreLtOGR+6twT6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c268:0:b0:375:8a85:eacd with SMTP id
 e9e14a558f8ab-3763f6c7aabmr2165935ab.3.1719178939023; Sun, 23 Jun 2024
 14:42:19 -0700 (PDT)
Date: Sun, 23 Jun 2024 14:42:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f75434061b9589eb@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_free_reserved_data_space_noquota (2)
From: syzbot <syzbot+9b4407a256ad8ed1d5c8@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112f8c1e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0d76ceef02b39
dashboard link: https://syzkaller.appspot.com/bug?extid=9b4407a256ad8ed1d5c8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13cdb5bfbafa/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a14f5d07f81/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b4407a256ad8ed1d5c8@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 2 PID: 7088 at fs/btrfs/space-info.h:208 btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:208 [inline]
WARNING: CPU: 2 PID: 7088 at fs/btrfs/space-info.h:208 btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:240 [inline]
WARNING: CPU: 2 PID: 7088 at fs/btrfs/space-info.h:208 btrfs_free_reserved_data_space_noquota+0x3de/0x550 fs/btrfs/delalloc-space.c:179
Modules linked in:
CPU: 2 PID: 7088 Comm: syz-executor.2 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:208 [inline]
RIP: 0010:btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:240 [inline]
RIP: 0010:btrfs_free_reserved_data_space_noquota+0x3de/0x550 fs/btrfs/delalloc-space.c:179
Code: ea 03 80 3c 02 00 0f 85 64 01 00 00 4c 8b 73 60 48 89 ef 4c 89 f6 e8 71 68 df fd 49 39 ee 0f 83 65 fe ff ff e8 f3 6d df fd 90 <0f> 0b 90 e9 62 fe ff ff e8 e5 6d df fd 48 8d 7b 18 be ff ff ff ff
RSP: 0018:ffffc900042af5c8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801e0fb800 RCX: ffffffff83af21cf
RDX: ffff88801d02c880 RSI: ffffffff83af21dd RDI: 0000000000000006
RBP: 0000000000800000 R08: 0000000000000006 R09: 0000000000800000
R10: 00000000005cd000 R11: 0000000000000003 R12: ffff888011fb8000
R13: 0000000000000000 R14: 00000000005cd000 R15: ffffffffff800000
FS:  0000000000000000(0000) GS:ffff88802c200000(0063) knlGS:00000000f5ed1b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000c0018a2000 CR3: 0000000000822000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_free_reserved_data_space+0xc1/0x100 fs/btrfs/delalloc-space.c:199
 btrfs_dio_iomap_begin+0xbbc/0x1e40 fs/btrfs/inode.c:7752
 iomap_iter+0x61f/0x1080 fs/iomap/iter.c:91
 __iomap_dio_rw+0x6ba/0x1c70 fs/iomap/direct-io.c:659
 btrfs_dio_write+0xb1/0xf0 fs/btrfs/inode.c:7890
 btrfs_direct_write fs/btrfs/file.c:1554 [inline]
 btrfs_do_write_iter+0x901/0x10c0 fs/btrfs/file.c:1695
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6b6/0x1140 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72df579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5ed15ac EFLAGS: 00000292 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000000000
RDX: 0000000000800000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
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

