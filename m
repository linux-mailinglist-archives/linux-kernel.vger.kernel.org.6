Return-Path: <linux-kernel+bounces-296810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695A995AF69
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6D1B20F89
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AC415351A;
	Thu, 22 Aug 2024 07:39:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F732A933
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312345; cv=none; b=K1SwxeDomYoPqoQv2b8j9JgSVLsbwliIgnk8haKs6fCchJOA4xzjouFPu4jrcqY1cx1Ntn/iyAY+dKzj4ylZKM5z7ghrIbnu72UqFw//R9fpc5pOzSezPcuki1+cAEZLPhjck9/hUXEmpkoZqF1YFRC44V3spHgTO1Nh+mni8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312345; c=relaxed/simple;
	bh=wdhQZCdsNIPULJGdc0AxeOUPMp5tmNGROy3P988dYc8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rhq3W5q66CqRjL7FrRGSqrrNmnaA5u2bvEbkqOA4v5Fbn78CjUYFL3NirN9iYWEATv3uT75ULEocJmk6g+UcPJ1E3whzWgZ90ujbD9v0RkUi92MQqIvA3fbpQ1Yr8d6prsoGqBgS3DX4CwrVV++e2oBiY38ApXcwPltN4gtcrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-824cae494e3so50378739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724312343; x=1724917143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDqu3sfdeZUzH4nBj4HXyhO6RxaxSyk6xAXXg50J1uc=;
        b=r8PRl862Rf0msXq6MHzbagMwP0Eh9tsX9eFacWAA7Qsy/J71Io8wxsxvf59W0P7E/j
         iYYGjlLitl8HfNehpekcIGsrwzM6seZFNcB1aFA5vW6l0hcKKIGi0o2yy4wup7NHDrkq
         2Wrjy9icfWqcmXMFphp1TR94ocVdxii+TJkYqGIDcOqDFlIEGiBUv8WEbSwPxZ/JX9m1
         GgEw2D34HoY3YvBTJx7QI4+ghnL62LD9+efkemo+07dBLWnWpWDKalXH8BohvkJVmpkO
         7UdHY9Ml+Hzw3QMwCkQhkLo5av1By9nI5DrtnHdxvUO1dmpjxCS3D/Zk/VedofWpTFuT
         P0AQ==
X-Gm-Message-State: AOJu0Ywm69ie0x5p8eZwWHWc7gvJqEtVQ3LB0kYpn84aHSEv0sCJTEcA
	BIaRypQ4hfDKWMq2mo8a65j4WM/ujz1vIM8s76SAX/cXRzFVvEu9EKM14yJMxSjQ7DBIhDRvRu/
	n8KD3nwFe0EG2uoUylJle7K6LDEGMMFAxaVPI2kkxSLxwglfpXnTOzn0=
X-Google-Smtp-Source: AGHT+IHq9iv3dwTNuRO+O6pYaIKyV7dQDCjqKR4YDNXbPcYViF5DiZ9pjPMcumsoztkMrNBaY0lIUD9HTmULECP4U8bAynAB06f8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b41:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-39d6c3d20ffmr4257715ab.4.1724312343203; Thu, 22 Aug 2024
 00:39:03 -0700 (PDT)
Date: Thu, 22 Aug 2024 00:39:03 -0700
In-Reply-To: <20240822071823.1329392-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2ebce062040c030@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in lmLogInit
From: syzbot <syzbot+d16facb00df3f446511c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in lmLogInit

syz.0.727: attempt to access beyond end of device
loop0: rw=2049, sector=30728, nr_sectors = 8 limit=0
lbmIODone: I/O error in JFS log
==================================================================
BUG: KASAN: slab-use-after-free in lbmLogShutdown fs/jfs/jfs_logmgr.c:1863 [inline]
BUG: KASAN: slab-use-after-free in lmLogInit+0xc9f/0x1c90 fs/jfs/jfs_logmgr.c:1416
Read of size 8 at addr ffff888040e8ae18 by task syz.0.727/7934

CPU: 0 UID: 0 PID: 7934 Comm: syz.0.727 Not tainted 6.11.0-rc3-syzkaller-00306-gdf6cbc62cc9b-dirty #0
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
RIP: 0033:0x7f7c1457b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7c1530be68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f7c1530bef0 RCX: 00007f7c1457b0ba
RDX: 0000000020005d40 RSI: 0000000020005d80 RDI: 00007f7c1530beb0
RBP: 0000000020005d40 R08: 00007f7c1530bef0 R09: 0000000000000810
R10: 0000000000000810 R11: 0000000000000246 R12: 0000000020005d80
R13: 00007f7c1530beb0 R14: 0000000000005e1a R15: 0000000020000400
 </TASK>

Allocated by task 7934:
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

Freed by task 7934:
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

The buggy address belongs to the object at ffff888040e8ae00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 24 bytes inside of
 freed 192-byte region [ffff888040e8ae00, ffff888040e8aec0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x40e8a
anon flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 04fff00000000000 ffff8880158413c0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5543, tgid 5543 (syz-executor), ts 167948790919, free_ts 164683488006
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
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 ops_init+0x8b/0x610 net/core/net_namespace.c:129
 setup_net+0x515/0xca0 net/core/net_namespace.c:343
 copy_net_ns+0x4e2/0x7b0 net/core/net_namespace.c:508
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x619/0xc10 kernel/fork.c:3328
 __do_sys_unshare kernel/fork.c:3399 [inline]
 __se_sys_unshare kernel/fork.c:3397 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3397
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
page last free pid 5500 tgid 5500 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_folios+0x103a/0x1b00 mm/page_alloc.c:2660
 folios_put_refs+0x76e/0x860 mm/swap.c:1039
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 unmap_region+0x2df/0x350 mm/mmap.c:2441
 do_vmi_align_munmap+0x1122/0x18c0 mm/mmap.c:2754
 do_vmi_munmap+0x261/0x2f0 mm/mmap.c:2830
 __vm_munmap+0x1fc/0x400 mm/mmap.c:3109
 __do_sys_munmap mm/mmap.c:3126 [inline]
 __se_sys_munmap mm/mmap.c:3123 [inline]
 __x64_sys_munmap+0x68/0x80 mm/mmap.c:3123
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888040e8ad00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888040e8ad80: 00 00 00 00 00 00 00 06 fc fc fc fc fc fc fc fc
>ffff888040e8ae00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888040e8ae80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888040e8af00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         df6cbc62 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1728576b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=d16facb00df3f446511c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d3cbd5980000


