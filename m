Return-Path: <linux-kernel+bounces-296627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691FE95ACF3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 921B0B21A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4A756766;
	Thu, 22 Aug 2024 05:37:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A536B11
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724305047; cv=none; b=rnPtVXe0tYu5qx1+QRmAuMDVWsLC8Eh9x6HSdm12WnWXXN6yddTQFdawjM+c6lGvNLuB9VWtVtobgAJ3N2tIm7DLb8kW0kwXzgQQkOSv3w2x7bY0Q58lAP6ZYrSbjsTVnw2q9oA7LgcvRPpXopYao5eud7WGurXN0yDFyuxhO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724305047; c=relaxed/simple;
	bh=HgtOd5tMspXXVkSs0jzQ28H44IM9HbaCCbyQhtuZmEE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nihNFkYY3Q5TFQkIFLnRPKOmxZHpG1I4Rg/7OxcY+p1LAopNZBrZjfzXs7jlyk+Zt+HjOeAXutVVDGL1laxntYg2Sbfp3hb1uueabrigYKUJ1fZkZgaPd7d3HuwCGV21i40GOh3kNcJQZ3LBJQfY4sPkIJsD3iYJRa3GjQXgJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d2ced7e8eso4278675ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 22:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724305044; x=1724909844;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kcy8YcvmVxTnRaavase9fPoDrlb1X8h1ZIhQce+NuB4=;
        b=vRsp2K5O2bl48J/zlBS5LuXU0skwgZOcQNHTDi0uFagAkIcgkl5tt2Y+Gv/x2ugplj
         wi8W5h0M3ALxxNlL6Q8WuvLR39t1INmzi+s/IxypJpuMgcN36QuhvCbUj8sQVj1jJCOd
         BuEYEjGx9WzZVkk/aNtqnT97z2O8JlAJgKmIPvDZVAqKT/eaMcaatxIiOZOGWUooJ3NZ
         yT56fD+ueJaQVd9sBkWsRXa1tsh3oNXlYlhId2CfpEwk73LqvEryHkrZzeJQB5Xn2nlY
         tvll7kOMBpUfYIYVH7htxrso8ClmCyZ4WDJ37qWW3sRzzGB1txpsi0RhiqZz06YWxAe7
         hKgw==
X-Forwarded-Encrypted: i=1; AJvYcCUnjOvycr1grNOjOElyhNT0QvowFBP914UKv5CLyMcYOTRdGz32/2tLH2N6pAte2MtfNYqfH0Zrm+5wjMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/U+QWQoTDKpC5cT9cmSO4kl3xJ1CD+vEmZPFURwlDSzFRpsP+
	HAh1QGb8R7T30Xyu8rx+SvVSgCMzGS30Unn2IFY++Jpd0aAzZcNdpw5J7N1CVOYWsySjS+deXLS
	jwDUfMWkW322iNM2U4u9FcBB7HpeWfL8ViMd8l9iPMz73u2tJfTHhwkI=
X-Google-Smtp-Source: AGHT+IFErlGirwHY+QT3WZE4cmSgU/l/uxjPAItqPcawsTWMVmTYRnCERzFigE438B0pTAvd0kcAntpoUGxXUs+vepE0ZMcC8s06
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa4:b0:39d:3043:1f20 with SMTP id
 e9e14a558f8ab-39d6c3d91b6mr2612975ab.5.1724305044613; Wed, 21 Aug 2024
 22:37:24 -0700 (PDT)
Date: Wed, 21 Aug 2024 22:37:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab44fc06203f0d28@google.com>
Subject: [syzbot] [jfs?] KASAN: slab-use-after-free Read in lmLogInit
From: syzbot <syzbot+d16facb00df3f446511c@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    df6cbc62cc9b Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1076a713980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=d16facb00df3f446511c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1702b429980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-df6cbc62.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f4768d9245d4/vmlinux-df6cbc62.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0597825de2fb/bzImage-df6cbc62.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ac22370a3ae0/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d16facb00df3f446511c@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
lbmIODone: I/O error in JFS log
==================================================================
BUG: KASAN: slab-use-after-free in lbmLogShutdown fs/jfs/jfs_logmgr.c:1863 [inline]
BUG: KASAN: slab-use-after-free in lmLogInit+0xc9f/0x1c90 fs/jfs/jfs_logmgr.c:1416
Read of size 8 at addr ffff88801deb8e18 by task syz.0.95/5566

CPU: 0 UID: 0 PID: 5566 Comm: syz.0.95 Not tainted 6.11.0-rc3-syzkaller-00306-gdf6cbc62cc9b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 lbmLogShutdown fs/jfs/jfs_logmgr.c:1863 [inline]
 lmLogInit+0xc9f/0x1c90 fs/jfs/jfs_logmgr.c:1416
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x55e/0x1040 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xf1/0x6a0 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x681/0xc50 fs/jfs/super.c:565
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff94457b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff943ffee68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ff943ffeef0 RCX: 00007ff94457b0ba
RDX: 0000000020005d40 RSI: 0000000020005d80 RDI: 00007ff943ffeeb0
RBP: 0000000020005d40 R08: 00007ff943ffeef0 R09: 0000000000000810
R10: 0000000000000810 R11: 0000000000000246 R12: 0000000020005d80
R13: 00007ff943ffeeb0 R14: 0000000000005e1a R15: 0000000020000400
 </TASK>

Allocated by task 5566:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4189
 kmalloc_noprof include/linux/slab.h:681 [inline]
 lbmLogInit fs/jfs/jfs_logmgr.c:1822 [inline]
 lmLogInit+0x3b4/0x1c90 fs/jfs/jfs_logmgr.c:1270
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x55e/0x1040 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xf1/0x6a0 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x681/0xc50 fs/jfs/super.c:565
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5566:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x149/0x360 mm/slub.c:4594
 lbmLogShutdown fs/jfs/jfs_logmgr.c:1865 [inline]
 lmLogInit+0xccd/0x1c90 fs/jfs/jfs_logmgr.c:1416
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x55e/0x1040 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xf1/0x6a0 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x681/0xc50 fs/jfs/super.c:565
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801deb8e00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 24 bytes inside of
 freed 192-byte region [ffff88801deb8e00, ffff88801deb8ec0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1deb8
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff8880158413c0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 13566750501, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3442
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4700
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4184
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 call_usermodehelper_setup+0x8e/0x270 kernel/umh.c:363
 kobject_uevent_env+0x680/0x8e0 lib/kobject_uevent.c:628
 driver_register+0x2d6/0x320 drivers/base/driver.c:254
 usb_register_driver+0x209/0x3c0 drivers/usb/core/driver.c:1082
 do_one_initcall+0x248/0x880 init/main.c:1267
 do_initcall_level+0x157/0x210 init/main.c:1329
 do_initcalls+0x3f/0x80 init/main.c:1345
 kernel_init_freeable+0x435/0x5d0 init/main.c:1578
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801deb8d00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801deb8d80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88801deb8e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88801deb8e80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88801deb8f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

