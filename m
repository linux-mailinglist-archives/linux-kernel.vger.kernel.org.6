Return-Path: <linux-kernel+bounces-289431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD3B954621
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145181C24130
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA34170A0D;
	Fri, 16 Aug 2024 09:49:29 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4516EB63
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801769; cv=none; b=fTwchPwgqwSlhJvPHU004uhmKZZmYXf83JXvxaC+9vgX2UP6Gp2O/DPFsrDCPV7rVQJUG5MrU2AoEVYw1/V9QSES0m4j2cXP1oEDBnKUVFtPHK3ojoSG48+FeAVErdDY8ilGt0Kb5ZCFOSZQTEl8MA3ghIVL4esgjYJagape6rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801769; c=relaxed/simple;
	bh=53D+UFgnlzMXNLX1YLXvaHazexPiOJXMDeqggVHAZOk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HWvFJl/SaZIlH5BG3DQFjMUVMZUNy/1xsh7SJX02Fi/C4VzCli45arSQvlPNFEeY99OQO5Xd7bs0TFYn9hsoIVRe0AVvLJqWqitt6pjRNalJ3catFb3mWSm0R3pHIKQlfaITte72axMB1HAWq9/ouKHHGILHYlEdlKZ3vmAXGjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81fb21a0e41so170695539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801765; x=1724406565;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwF8lejhqW3zqOLhy6JPlrla0GOOS2Vo5lEnLSJiW5I=;
        b=Ph/GdRGNTqpRA8Rg8i9ypp01n6SHln+OsI4Iu3z9FKryq7/jKKSbSNs1mVCHc2sUu+
         LuqwsU1E4W8ESX11BtfAzubRF0SHRfZuV3gucY5qbzGP8MLKYwHLBkIgL+3w+JlY4nOc
         8tG0ZR2Zp7RbiveW6PJiQQkHeQ/N9sShMLQYkPPgcczIrOHL46IOtioOssAPCJHPz94X
         blEJh6NxmRyeVU+9okS2+40zXW1V6YxPRPFKM7cJJdRxh5LHMorovm4aQXNzoYVvvQ93
         IEYUS5yYisrM1k5YbPm66dB2U/t/KIhrheLb/EfxMeJ+wobtyNvgEDT8l+2dqhHBtwgl
         wDNw==
X-Forwarded-Encrypted: i=1; AJvYcCXXlMROoV6se7wpn+Uzl9bodT49xf5RuMdyd+lQTNKLjgy479+7hC30M6H9dFs20E0XdQ59ZFUuMeLM04X5oWYjP+o50qwxSTc8IpMN
X-Gm-Message-State: AOJu0YzRB8C0H0EdgJv81UPkFG/e5eICFreyTqPN72JYWhgzHbOoKeV5
	eLmaGsclhKVCC2QHjQ/HRpjLrXSeE6TluHrEuPWCmBjodAw/DcKFklHqd3EAlWHNjZqMDtNJXLu
	G/1dsu23ub4nJi9g5b0PRZ81J6avFrh0P2DvKry/Gv0TI2BrDLm7JiEY=
X-Google-Smtp-Source: AGHT+IHKpt5YEMJf6CIRhhYWXpqCpiVtct1tHDreccCu1UEtwqGyxTbQ2IcTMdGiPR6RPI1aq59G7t7vdZLlA3mmELE0J2JtbB0C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8723:b0:4c2:7a26:278b with SMTP id
 8926c6da1cb9f-4cce16ed0d9mr56095173.5.1723801765682; Fri, 16 Aug 2024
 02:49:25 -0700 (PDT)
Date: Fri, 16 Aug 2024 02:49:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e82f01061fc9df63@google.com>
Subject: [syzbot] [ntfs3?] WARNING in ni_fiemap
From: syzbot <syzbot+1c25748a40fe79b8a119@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7a5aa4b3c00 Merge tag 'perf-tools-fixes-for-v6.11-2024-08..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119023e5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=1c25748a40fe79b8a119
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1307f583980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1651b6d5980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d7a5aa4b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af15738cca6c/vmlinux-d7a5aa4b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62dacb1384ee/bzImage-d7a5aa4b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/60c06f341df1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c25748a40fe79b8a119@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5086 at mm/page_alloc.c:4676 __alloc_pages_noprof+0x36a/0x6c0 mm/page_alloc.c:4676
Modules linked in:
CPU: 0 UID: 0 PID: 5086 Comm: syz-executor272 Not tainted 6.11.0-rc3-syzkaller-00156-gd7a5aa4b3c00 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__alloc_pages_noprof+0x36a/0x6c0 mm/page_alloc.c:4676
Code: a9 00 00 08 00 0f 85 12 01 00 00 44 89 e9 81 e1 7f ff ff ff a9 00 00 04 00 44 0f 45 e9 e9 02 01 00 00 c6 05 fd 87 14 0e 01 90 <0f> 0b 90 83 fb 0a 0f 86 6c fd ff ff 45 31 ed 48 c7 44 24 20 0e 36
RSP: 0018:ffffc90002bdf520 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 000000000000000c RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90002bdf5a8
RBP: ffffc90002bdf628 R08: ffffc90002bdf5a7 R09: 0000000000000000
R10: ffffc90002bdf580 R11: fffff5200057beb5 R12: 1ffff9200057beac
R13: 0000000000040d40 R14: dffffc0000000000 R15: 1ffff9200057bea8
FS:  0000555594e14380(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbb10add0f8 CR3: 000000001be6a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 ___kmalloc_large_node+0x8b/0x1d0 mm/slub.c:4103
 __kmalloc_large_node_noprof+0x1a/0x80 mm/slub.c:4130
 __do_kmalloc_node mm/slub.c:4146 [inline]
 __kmalloc_noprof+0x2ae/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kmalloc_array_noprof include/linux/slab.h:726 [inline]
 ni_fiemap+0x3b4/0x1910 fs/ntfs3/frecord.c:2004
 ntfs_fiemap+0x132/0x180 fs/ntfs3/file.c:1279
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:841
 __do_sys_ioctl fs/ioctl.c:905 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbb10a46ad9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf6462ac8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007fbb10a46ad9
RDX: 00000000200000c0 RSI: 00000000c020660b RDI: 0000000000000004
RBP: 00007fbb10ad95f0 R08: 0000555594e154c0 R09: 0000555594e154c0
R10: 000000000001f36b R11: 0000000000000246 R12: 00007ffcf6462af0
R13: 00007ffcf6462d18 R14: 431bde82d7b634db R15: 00007fbb10a8f03b
 </TASK>


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

