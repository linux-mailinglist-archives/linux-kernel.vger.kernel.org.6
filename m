Return-Path: <linux-kernel+bounces-512344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4692AA337CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB807A1DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462D20764B;
	Thu, 13 Feb 2025 06:17:27 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476B7204F85
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739427447; cv=none; b=H5a+bGBJc7yAVK7cxoQl0g3ffROaaWNeRTAz8OHQ/qcgl6rQqW5txFl/NXVV8RzehHuYX70xQg3OtfLDW8Ctn2KXEFxgrrCjh0pz9NA9BopGFvC+eSbO/KAzF6hDyU//ZnBZSj5jvi6zDb6oQSltc2clT/rWaxu3A1/sIHadxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739427447; c=relaxed/simple;
	bh=GdSePiCTMC1pHCBgWU1dcTjP/ieVFcIZLTEfgNUidsA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sMEMkE/KshbsePWboQilrVkGGr82BxWNltox0ckRA/CvREbJ5B37jQDyy4Ezv+A8UALiu1ZvLNepLZldDGex3gIDT11DC20m0IMl1Qvsqqf0yTUBHOp1iC6EXUTrXaIkkyaKqwTfB1i09WYmeP3Y8V9uBe1rSTdG86MjZrAH+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so10338615ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739427444; x=1740032244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErLpT+owluUcVoxZIbGCIZMLGWbp2TEoymv0LgM8X3s=;
        b=IKeJs4awTk0ms4CTFgUyPKvXkg/V/AIlEUfA8R5IkgMDhgBsimC2Z5Z6lnd4M8++vX
         psXdZ+jc4ead/c5/n50hQCleWvlunG7IS/D6a0CLgZT6TN3RwvvkhzGfQ+HE9ZCh+eRD
         J0PVDVNkJufigTG3cKAYhJiy5Jk7f0GBeSM7QVOUkoqJelt/DGIW9moQtPJtZ7Inl6S0
         bzh1HURjaw0RNv6rqmczgdX4JrgpxzmAf8COsBll1y6CkgrnUyfpRZ1RZpPddkrdaFBO
         pwkp46M6x4SgpNB9Dgfm5/6eWnE/YTkr3fKN/7m/dVel3fyZUReCQMvOCq9DDq9AR867
         A+dg==
X-Forwarded-Encrypted: i=1; AJvYcCWfLptJrfC/xLgvLn7JrWVSJETjBvhzK1iObOD5KAlwE5DcFYNdq0MLwaCHalV5emv44wDvXyUb/oF8uIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCc6zHcNzog9HPC18+UDW13YkAIXlUX9AGouMzvr0lMkdd+jJB
	NixOn61tS/ag0prg4WmptSAnrZF1yBwLF8Htsi7N09q5i8vvKIhl6vrQK1r64GVZ8Kp7f9tgqPF
	ivgJ9XXJraxNQL54PSVtMY+22lQwlvxKKyz8t8zo6zWMbYfL0KsLATuc=
X-Google-Smtp-Source: AGHT+IGyhBu9JRj2DsigdpzAQy/l26YGNG9bP/Tk4dK+Sw5lefnGMD7J7VD50K/1ErN48XqFRgWjkZ3m2LUnzD+2qD4J8wesNXEK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1787:b0:3d0:618c:1b22 with SMTP id
 e9e14a558f8ab-3d17bf3791emr49751825ab.11.1739427444332; Wed, 12 Feb 2025
 22:17:24 -0800 (PST)
Date: Wed, 12 Feb 2025 22:17:24 -0800
In-Reply-To: <000000000000ab44fc06203f0d28@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ad8e74.050a0220.110943.0058.GAE@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in lmLogInit
From: syzbot <syzbot+d16facb00df3f446511c@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4dc1d1bec898 Merge tag 'mfd-fixes-6.14' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e47bdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c2347dd6174fbe2
dashboard link: https://syzkaller.appspot.com/bug?extid=d16facb00df3f446511c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a8caa4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13dde3f8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4dc1d1be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69a70e883a61/vmlinux-4dc1d1be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5f11135c484/bzImage-4dc1d1be.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5c023dde1d54/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=15dde3f8580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d16facb00df3f446511c@syzkaller.appspotmail.com

syz-executor386: attempt to access beyond end of device
loop0: rw=2049, sector=30728, nr_sectors = 8 limit=0
lbmIODone: I/O error in JFS log
==================================================================
BUG: KASAN: slab-use-after-free in lbmLogShutdown fs/jfs/jfs_logmgr.c:1863 [inline]
BUG: KASAN: slab-use-after-free in lmLogInit+0xc9f/0x1c90 fs/jfs/jfs_logmgr.c:1416
Read of size 8 at addr ffff888050158518 by task syz-executor386/6808

CPU: 0 UID: 0 PID: 6808 Comm: syz-executor386 Not tainted 6.14.0-rc2-syzkaller-00041-g4dc1d1bec898 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 lbmLogShutdown fs/jfs/jfs_logmgr.c:1863 [inline]
 lmLogInit+0xc9f/0x1c90 fs/jfs/jfs_logmgr.c:1416
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x55e/0x1040 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xf1/0x6a0 fs/jfs/jfs_mount.c:257
 jfs_reconfigure+0x632/0x9d0 fs/jfs/super.c:409
 reconfigure_super+0x43a/0x870 fs/super.c:1083
 do_remount fs/namespace.c:3100 [inline]
 path_mount+0xc22/0xfa0 fs/namespace.c:3879
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fea9edf35e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fea9e59b168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fea9ee804a8 RCX: 00007fea9edf35e9
RDX: 0000000000000000 RSI: 0000400000000000 RDI: 0000000000000000
RBP: 00007fea9ee804a0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000001c0030 R11: 0000000000000246 R12: 00007fea9ee804ac
R13: 000000000000000b R14: 00007ffe11bf4590 R15: 00007ffe11bf4678
 </TASK>

Allocated by task 6808:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4325
 kmalloc_noprof include/linux/slab.h:901 [inline]
 lbmLogInit fs/jfs/jfs_logmgr.c:1822 [inline]
 lmLogInit+0x3b4/0x1c90 fs/jfs/jfs_logmgr.c:1270
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x55e/0x1040 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xf1/0x6a0 fs/jfs/jfs_mount.c:257
 jfs_reconfigure+0x632/0x9d0 fs/jfs/super.c:409
 reconfigure_super+0x43a/0x870 fs/super.c:1083
 do_remount fs/namespace.c:3100 [inline]
 path_mount+0xc22/0xfa0 fs/namespace.c:3879
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6808:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x196/0x430 mm/slub.c:4757
 lbmLogShutdown fs/jfs/jfs_logmgr.c:1865 [inline]
 lmLogInit+0xccd/0x1c90 fs/jfs/jfs_logmgr.c:1416
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x55e/0x1040 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xf1/0x6a0 fs/jfs/jfs_mount.c:257
 jfs_reconfigure+0x632/0x9d0 fs/jfs/super.c:409
 reconfigure_super+0x43a/0x870 fs/super.c:1083
 do_remount fs/namespace.c:3100 [inline]
 path_mount+0xc22/0xfa0 fs/namespace.c:3879
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888050158500
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 24 bytes inside of
 freed 192-byte region [ffff888050158500, ffff8880501585c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x50158
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801ac413c0 ffffea0000d893c0 dead000000000002
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4797, tgid 4797 (kworker/0:3), ts 140090156794, free_ts 138950899992
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
 __kmalloc_cache_noprof+0x27b/0x390 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 virtio_gpu_plane_duplicate_state+0x72/0xb0 drivers/gpu/drm/virtio/virtgpu_plane.c:79
 drm_atomic_get_plane_state+0x247/0x500 drivers/gpu/drm/drm_atomic.c:545
 drm_atomic_helper_dirtyfb+0xc5f/0xe60 drivers/gpu/drm/drm_damage_helper.c:171
 drm_fbdev_shmem_helper_fb_dirty+0x151/0x2c0 drivers/gpu/drm/drm_fbdev_shmem.c:117
 drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:376 [inline]
 drm_fb_helper_damage_work+0x275/0x880 drivers/gpu/drm/drm_fb_helper.c:399
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
page last free pid 5356 tgid 5356 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0xe0d/0x10e0 mm/page_alloc.c:2660
 discard_slab mm/slub.c:2684 [inline]
 __put_partials+0x160/0x1c0 mm/slub.c:3153
 put_cpu_partial+0x17c/0x250 mm/slub.c:3228
 __slab_free+0x290/0x380 mm/slub.c:4479
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4171
 getname_flags+0xb7/0x540 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1422
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888050158400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888050158480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888050158500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888050158580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888050158600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

