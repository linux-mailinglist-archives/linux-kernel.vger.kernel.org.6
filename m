Return-Path: <linux-kernel+bounces-341847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4689498870B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0114B281ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A2C13E41D;
	Fri, 27 Sep 2024 14:23:34 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD011339A4
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447013; cv=none; b=EOSuI8g7bvVn01l3gFhuXu6JtPgALRoI2b+lj57cXWVoVAZ94EHMgvh7jWkpd3SVyfw1rITVTQdle5s9he2edLJlBRT0L0MPhF7rz5yFN/3KKYzIk53UP4ibVEO/awjkFwLxH29F5uySgMmtcvi8Qyt7x0Xulh8pN0SWCgNB18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447013; c=relaxed/simple;
	bh=JymrnqC2lz87Eacl+tCah6sVaBvD8MbY3By/+dKfapg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QgsPYR64u1KqFVNbYaMOSz1R8ua8sI8JpoonluWlSW+5bOLi0x4detYnUrF5wxipIfc7T7Ab9vPsLWepb58Zj/YjYXe2tv/PzHrlZ93H9HttAQBgr8KYJNM51oKW9wLA//0Xg+4a0NY8EspuVuI9uvFhakbDxBmznR+v8VnkVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a342e7e49cso20949305ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727447010; x=1728051810;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIX1aRyZ/+eXdZyPCsUUqJhoJLNXQcqE8OBSK1s6HW4=;
        b=sDY9IRARPRyqSXUInH5QCHMp1liCSlJ/e7yicUmLbFmAaSkc67TBWrxwgEo9vWKbE0
         PpgSqz9cQBlgmXr/Xhj/WEIWpL++Bd5oMfxdDIYLnUImYi/4+Pn677qAVUhsaQbk4lq4
         qbSNh+NvSIhmxnHmS1dtLM0B2HhVDRl/qxD7KvZiVWDc20328+k14aOUu8pgAdQTC2MZ
         V+hOoRGWjY/HNHuge3OiPPAL46mcZzVM+lkEJhW5/703jpg8Sko1VsX+QPDz3Fe5om9/
         5Yinh3LvSIuv7EG8DZ9CtU53j9KZviNDarH3iM4WNLRUBCi8ifT3aZe7cx6tJky7H6CS
         LBbg==
X-Forwarded-Encrypted: i=1; AJvYcCUHTHZN0NIQRVAHjNlIce2mn8Lng5o9rv4pmAbetIv8BcmJ5yMQyX1DNf+OTNTJuxJ9tET1c2IwJ+/UBIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBq+6L2/KZ7udPNTn7WHwrpvB9k2lTH8zEoGEfZDqinLQOQY6K
	5ICU9QcI39/mLnvPFSJ7Y9xn4Z8/r33urnc0GZ539UJu1VPk8jE7lBgc/AQwoy/IJm7p9Jxt0CO
	CLRtebTKOyzNUtNuauctsts5Cn7bFUZF9dCtIS2mmpmFSP5ox4u7TtVE=
X-Google-Smtp-Source: AGHT+IGEdLX5xH+jlJ9bAYqsNhZN35m64g/pGfksFBl5v8D9rBDM30FUE0Qx808pfTmq3nQr+1AMGWrc+KyaTNfPzo1grAX4xHPk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c2:b0:3a2:6ce9:19c6 with SMTP id
 e9e14a558f8ab-3a3451c3a1emr24361235ab.25.1727447010143; Fri, 27 Sep 2024
 07:23:30 -0700 (PDT)
Date: Fri, 27 Sep 2024 07:23:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6bfe2.050a0220.38ace9.001b.GAE@google.com>
Subject: [syzbot] [jfs?] KASAN: slab-use-after-free Read in dbAdjCtl
From: syzbot <syzbot+b8a0f41c444f996ecaad@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0babf683783d Merge tag 'pinctrl-v6.11-4' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11289900580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=b8a0f41c444f996ecaad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-0babf683.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b153c86536a6/vmlinux-0babf683.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef8726833cde/bzImage-0babf683.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8a0f41c444f996ecaad@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
==================================================================
BUG: KASAN: slab-use-after-free in dbAdjCtl+0x83d/0x9c0 fs/jfs/jfs_dmap.c:2553
Read of size 4 at addr ffff88800e598018 by task syz.0.0/5110

CPU: 0 UID: 0 PID: 5110 Comm: syz.0.0 Not tainted 6.11.0-rc7-syzkaller-00149-g0babf683783d #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 dbAdjCtl+0x83d/0x9c0 fs/jfs/jfs_dmap.c:2553
 dbAllocDmap fs/jfs/jfs_dmap.c:2044 [inline]
 dbAllocDmapLev+0x29c/0x4a0 fs/jfs/jfs_dmap.c:1988
 dbAllocCtl+0x113/0x920 fs/jfs/jfs_dmap.c:1825
 dbAllocAG+0x28f/0x10b0 fs/jfs/jfs_dmap.c:1364
 dbDiscardAG+0x352/0xa20 fs/jfs/jfs_dmap.c:1613
 jfs_ioc_trim+0x433/0x670 fs/jfs/jfs_discard.c:100
 jfs_ioctl+0x2d0/0x3e0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f11dbf7def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f11dcd51038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f11dc135f80 RCX: 00007f11dbf7def9
RDX: 0000000020000080 RSI: 00000000c0185879 RDI: 0000000000000046
RBP: 00007f11dbff0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f11dc135f80 R15: 00007fff1b3a3ca8
 </TASK>

Allocated by task 5110:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4193
 kmalloc_noprof include/linux/slab.h:681 [inline]
 dbMount+0x58/0x9b0 fs/jfs/jfs_dmap.c:164
 jfs_mount+0x1e0/0x830 fs/jfs/jfs_mount.c:121
 jfs_fill_super+0x59c/0xc50 fs/jfs/super.c:556
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5112:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x149/0x360 mm/slub.c:4598
 dbUnmount+0x11d/0x190 fs/jfs/jfs_dmap.c:278
 jfs_mount_rw+0x4ac/0x6a0 fs/jfs/jfs_mount.c:247
 jfs_remount+0x3d1/0x6b0 fs/jfs/super.c:454
 reconfigure_super+0x445/0x880 fs/super.c:1083
 do_remount fs/namespace.c:3012 [inline]
 path_mount+0xc22/0xfa0 fs/namespace.c:3791
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88800e598000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 24 bytes inside of
 freed 2048-byte region [ffff88800e598000, ffff88800e598800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xe598
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac42000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080080008 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac42000 dead000000000122 0000000000000000
head: 0000000000000000 0000000080080008 00000001fdffffff 0000000000000000
head: 00fff00000000003 ffffea0000396601 ffffffffffffffff 0000000000000000
head: 0000000700000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5110, tgid 5109 (syz.0.0), ts 79392504787, free_ts 73278596860
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2325
 allocate_slab+0x5a/0x2f0 mm/slub.c:2488
 new_slab mm/slub.c:2541 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3727
 __slab_alloc+0x58/0xa0 mm/slub.c:3817
 __slab_alloc_node mm/slub.c:3870 [inline]
 slab_alloc_node mm/slub.c:4029 [inline]
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4188
 kmalloc_noprof include/linux/slab.h:681 [inline]
 dbMount+0x58/0x9b0 fs/jfs/jfs_dmap.c:164
 jfs_mount+0x1e0/0x830 fs/jfs/jfs_mount.c:121
 jfs_fill_super+0x59c/0xc50 fs/jfs/super.c:556
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
page last free pid 5091 tgid 5091 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_folios+0x103a/0x1b00 mm/page_alloc.c:2667
 folios_put_refs+0x76e/0x860 mm/swap.c:1039
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3425
 __mmput+0x115/0x390 kernel/fork.c:1345
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x27f0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88800e597f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff88800e597f80: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>ffff88800e598000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88800e598080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88800e598100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

