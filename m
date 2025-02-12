Return-Path: <linux-kernel+bounces-510955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5565A32410
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206813A62E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21640209F35;
	Wed, 12 Feb 2025 10:57:34 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284A209691
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357853; cv=none; b=HmzhMbvWpNbpPNrxfivu5a8aXgmhb/WxFRwChUR/nZ+Lh4awUcNbIBVI/FqKa9HIWqpIjoG2wGpxtyWFHV6ftgS6gJvoHsjbC/dvfjXTrXF2HJCasAoaN9ykj3MAJbWToR0/SvjImHC+8CgIR5K16hZFn1goGkH36rCGv8rkdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357853; c=relaxed/simple;
	bh=uOqU5Zwn1l8nB2s9CYubx47gw9guir3KdG8NYeULM3w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TwN8sXvsw1Hohx25xdsAz2He9S6/lP72MPW1HjFKSXzUBxXNWd6H73TBwehPTECdfq208ZO1L9DzjpoNPHT1kkWI5CP4FeT+hJ7ozAUNMXjyIZ1s+VVTKzNVCCoerBkD9E9oB9xF7qB+yP9fAffQt5Uc2DBoJwk7UpcVpPYSmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d13d1f8420so42462935ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357850; x=1739962650;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+vnwAF68RHU4ZynhNRDv2ih1IafQUFhBsL9H42yE/U=;
        b=fdfKEWIci1Yu4TazCApp9P//zZi7f3/iQ7C62GLCvJdgWMkeB0N60MWhUvXmqv4uUR
         KLvkqOuGrv1cdzVdaiDoUjeTP0UpuyOSIXeREWGMcW/bot+3MBOyVBbyTDYjJksJgai7
         6NVI61ui5MarPszW++z8eD2dnomcBospH/xg4xMTBcgk573Pdmwfx8N+z+OBFRVSxRcc
         30YOQMtJQYZw5wg2qYtzDQYQ63cAF+ZLd9Zn1VJQ5kC8mbtIhkgSvsEOGKUIN+isuTDy
         NQmo9X6kziPl3sIP2fo5HTG13iNT2iGu5HqQaOOLMPs7vE9G3ooPMz5zkooXiJdGfQVY
         qe2A==
X-Forwarded-Encrypted: i=1; AJvYcCXLyY5TNGZNdDpm6ceHbo74juuKRewJlw+T6DEqoHCpute7HwbsxmXRP2m+RXJdWU9k1l9OPrR5ba4dzw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Wb2N0nnY+IlJ6SD3HF8GCrKw4a3XyYCDR09inhdK6cWosw42
	TWvBu4fkJDYvlBc+OVfyUKwSfCZmEcFBA4rCB37BepxnHOpJFZrYPqOHOUgp2pDM10lPrpmCr2b
	UFuEFrzOJHfOINjjBceGQ1P//Sw+nJKIt/6J9GhHvbhMwGyFTZLXgu0M=
X-Google-Smtp-Source: AGHT+IEo/NNPEtaA7SrgcHVxqZvzthgRG4gD03QiFAMNwRi92u8PGd3e3tplGSTdJ4BVvcDxXbHWymcvW28Fojro2KVuft+erZHf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0d:b0:3d0:10ec:cc36 with SMTP id
 e9e14a558f8ab-3d17bf3acdamr22126015ab.11.1739357850608; Wed, 12 Feb 2025
 02:57:30 -0800 (PST)
Date: Wed, 12 Feb 2025 02:57:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ac7e9a.050a0220.3d72c.0150.GAE@google.com>
Subject: [syzbot] [jfs?] KASAN: slab-out-of-bounds Read in ea_get (4)
From: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7ee983c850b4 Merge tag 'drm-fixes-2025-02-08' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a8dca4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1909f2f0d8e641ce
dashboard link: https://syzkaller.appspot.com/bug?extid=4e6e7e4279d046613bc5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bf61b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a8dca4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7ee983c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f2f78699fc41/vmlinux-7ee983c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca55e6e8dd01/bzImage-7ee983c8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b234819f8863/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10a8dca4580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com

ffff88804566b698: 90 b6 66 45 80 88 ff ff 00 00 00 00 00 00 00 00  ..fE............
ffff88804566b6a8: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
ffff88804566b6b8: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
==================================================================
BUG: KASAN: slab-out-of-bounds in hex_dump_to_buffer+0x731/0xba0 lib/hexdump.c:193
Read of size 1 at addr ffff88804566b6d0 by task syz-executor271/5307

CPU: 0 UID: 0 PID: 5307 Comm: syz-executor271 Not tainted 6.14.0-rc1-syzkaller-00181-g7ee983c850b4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 hex_dump_to_buffer+0x731/0xba0 lib/hexdump.c:193
 print_hex_dump+0x13f/0x250 lib/hexdump.c:276
 ea_get+0xd30/0x12e0 fs/jfs/xattr.c:565
 __jfs_setxattr+0xfc/0x1190 fs/jfs/xattr.c:675
 __jfs_xattr_set+0xf9/0x180 fs/jfs/xattr.c:936
 __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
 vfs_setxattr+0x221/0x430 fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x2af/0x430 fs/xattr.c:665
 path_setxattrat+0x440/0x510 fs/xattr.c:713
 __do_sys_lsetxattr fs/xattr.c:754 [inline]
 __se_sys_lsetxattr fs/xattr.c:750 [inline]
 __x64_sys_lsetxattr+0xbf/0xe0 fs/xattr.c:750
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fee5a1fde19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff6b319538 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 00007fee5a247095 RCX: 00007fee5a1fde19
RDX: 0000000000000000 RSI: 0000400000002580 RDI: 0000400000000080
RBP: 00007fee5a27a5f0 R08: 0000000000000001 R09: 00005555596ac4c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff6b319560
R13: 00007fff6b319788 R14: 431bde82d7b634db R15: 00007fee5a24703b
 </TASK>

Allocated by task 5307:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_lru_noprof+0x1dd/0x390 mm/slub.c:4183
 jfs_alloc_inode+0x28/0x70 fs/jfs/super.c:105
 alloc_inode+0x65/0x1a0 fs/inode.c:336
 iget_locked+0xf1/0x5a0 fs/inode.c:1487
 jfs_iget+0x23/0x3e0 fs/jfs/inode.c:29
 jfs_lookup+0x226/0x410 fs/jfs/namei.c:1469
 __lookup_slow+0x296/0x400 fs/namei.c:1793
 lookup_slow+0x53/0x70 fs/namei.c:1810
 walk_component+0x2e1/0x410 fs/namei.c:2114
 lookup_last fs/namei.c:2612 [inline]
 path_lookupat+0x16f/0x450 fs/namei.c:2636
 filename_lookup+0x2a3/0x670 fs/namei.c:2665
 filename_setxattr+0xb9/0x430 fs/xattr.c:660
 path_setxattrat+0x440/0x510 fs/xattr.c:713
 __do_sys_lsetxattr fs/xattr.c:754 [inline]
 __se_sys_lsetxattr fs/xattr.c:750 [inline]
 __x64_sys_lsetxattr+0xbf/0xe0 fs/xattr.c:750
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88804566ae18
 which belongs to the cache jfs_ip of size 2232
The buggy address is located 0 bytes to the right of
 allocated 2232-byte region [ffff88804566ae18, ffff88804566b6d0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x45668
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801f64b780 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800d000d 00000000f5000000 0000000000000000
head: 04fff00000000040 ffff88801f64b780 dead000000000122 0000000000000000
head: 0000000000000000 00000000800d000d 00000000f5000000 0000000000000000
head: 04fff00000000003 ffffea0001159a01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 5307, tgid 5307 (syz-executor271), ts 63066622694, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x292/0x710 mm/page_alloc.c:4739
 alloc_pages_mpol+0x311/0x660 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab+0x8f/0x3a0 mm/slub.c:2587
 new_slab mm/slub.c:2640 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3826
 __slab_alloc+0x58/0xa0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 kmem_cache_alloc_lru_noprof+0x26c/0x390 mm/slub.c:4183
 jfs_alloc_inode+0x28/0x70 fs/jfs/super.c:105
 alloc_inode+0x65/0x1a0 fs/inode.c:336
 new_inode_pseudo fs/inode.c:1174 [inline]
 new_inode+0x22/0x1d0 fs/inode.c:1193
 jfs_fill_super+0x570/0xd90 fs/jfs/super.c:511
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88804566b580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88804566b600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88804566b680: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
                                                 ^
 ffff88804566b700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88804566b780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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

