Return-Path: <linux-kernel+bounces-563115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B27CA6371E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 20:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302003A8536
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594101EBFE6;
	Sun, 16 Mar 2025 19:00:38 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240C21E1E0E
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742151637; cv=none; b=t1ze6WrmmLzyRrgcoUfEAa52G/KEkAvplJ/ywhJK6JGT/R9g+DQ/vM8bGImvpipnCG0uppvqhunwsFIqbLELwHqbVawSv4SbkG71qX6DinCCObEMI/LGmjcqd4cA0sm9hVd7JcTxG7gGUBy/Hp5L/yOws/bO2QSl62xlPbKs6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742151637; c=relaxed/simple;
	bh=hxhcxjzlgkH2HaRHW3cwp0rMhB9w/VzYprzuwm8IR1U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r9zZiDSdrLCZGiUnNko6Tr+lKEKKsKqSZAQznVtjJBp+EL6Mj4i5KO4WinCZzglvt2ozw2joQE6bitFWcbMjQ4+JG3t7bJTUrQB0ZuHviiv0relpa9jC9u1tcm/LRVMf4oMMJ1rcVGowoFvUg/qo5OsRCoerbnDK2OmjXNNtLsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d434c328dbso71946045ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 12:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742151635; x=1742756435;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxbhjTrMG45wUnXDZLEI8AwhrNmeEk2XCaJR/1Yozy4=;
        b=K9Mteh0Y6C7eUusRbd/BNV1jQqcDzvk4WrNDW+2XlPe45zYec0r/Hhd55JfQzxMSWS
         5lSy9BBNAD3tuIBTv6ciusiDevL74cSFfEpjqfBJI62lp2HwNbWjym2e/FGktw8SD5Pv
         OuqoKpRFFNSVYiFIkxtbAHz8vChKM1rKEE86PHCtrn14KDW+B2bw+wBNPAt4ooOe14/T
         8dX3nBt6h2qbZ6mKdfD+mrCFhqAL14S3vhSdoG9QfDrq2KfHh/js7anBL/qbL+QwsxRl
         2fhxGMw5DIq7vNBd+pj62S+hNXmI6HnCsX/3ci1EBCUDWpNLiZmZIm9ZC1LIMwUP19rY
         /nBA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Xdqs+IWNQ7G1hzHpRTo3jwHzT6abKh2a56ruR7bG9mxxzc29xivpN/uhfutmBn8H+1albiXBQtFJ9iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbypgfPY5RXZIQmKcrEijXKQahIfxtn8i+0JQIPde2upDK5ojh
	tStW167WxEFiJX67/hI2xlc68QF3H2cQ9noPqEDnGV+xkaZ348iBr8PoQLNIR3W7oWjBBg1FO7s
	09bDmOlRbkTF1RV8JT9g5ikvu7hfonBVR2HCKJ0bL035QsPHgh56lkr0=
X-Google-Smtp-Source: AGHT+IFNA8UYDFO+pCuEz4LKNUB0dm0nCyUAq4KQEjTKLUh/3EH+VXqVy9eTupRmqxOCJCksABpUsI1NZAzsZuulJ3ebhSMmC819
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3397:b0:3d3:dd60:bc37 with SMTP id
 e9e14a558f8ab-3d483a90667mr131245585ab.22.1742151635223; Sun, 16 Mar 2025
 12:00:35 -0700 (PDT)
Date: Sun, 16 Mar 2025 12:00:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d71fd3.050a0220.3657bb.0003.GAE@google.com>
Subject: [syzbot] [kernel?] upstream test error: KASAN: slab-use-after-free
 Write in binder_add_device (2)
From: syzbot <syzbot+35a5dd7a84685f5f9844@syzkaller.appspotmail.com>
To: arve@android.com, brauner@kernel.org, cmllamas@google.com, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    29281a76709c Merge tag 'kvmarm-fixes-6.14-2' into kvmarm-m..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git fuzzme
console output: https://syzkaller.appspot.com/x/log.txt?x=1155cfa8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ab4d8c35f4d2e97
dashboard link: https://syzkaller.appspot.com/bug?extid=35a5dd7a84685f5f9844
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-29281a76.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1ca228f9e75/vmlinux-29281a76.xz
kernel image: https://storage.googleapis.com/syzbot-assets/22c8671002d3/Image-29281a76.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35a5dd7a84685f5f9844@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hlist_add_head include/linux/list.h:1026 [inline]
BUG: KASAN: slab-use-after-free in binder_add_device+0x54/0x8c drivers/android/binder.c:6932
Write of size 8 at addr 81f00000124ffa08 by task syz-executor/3323
Pointer tag: [81], memory tag: [84]

CPU: 0 UID: 0 PID: 3323 Comm: syz-executor Not tainted 6.14.0-rc2-syzkaller-g29281a76709c #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x1b4/0x500 mm/kasan/report.c:489
 kasan_report+0xd8/0x138 mm/kasan/report.c:602
 kasan_tag_mismatch+0x28/0x3c mm/kasan/sw_tags.c:175
 __hwasan_tag_mismatch+0x30/0x60 arch/arm64/lib/kasan_sw_tags.S:55
 hlist_add_head include/linux/list.h:1026 [inline]
 binder_add_device+0x54/0x8c drivers/android/binder.c:6932
 binderfs_binder_device_create+0x64c/0x6a0 drivers/android/binderfs.c:210
 binderfs_fill_super+0x5d4/0x814 drivers/android/binderfs.c:729
 vfs_get_super fs/super.c:1280 [inline]
 get_tree_nodev+0x98/0x110 fs/super.c:1299
 binderfs_fs_context_get_tree+0x28/0x38 drivers/android/binderfs.c:749
 vfs_get_tree+0x68/0x1e4 fs/super.c:1814
 do_new_mount+0x218/0x5d8 fs/namespace.c:3560
 path_mount+0x428/0xa64 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount fs/namespace.c:4088 [inline]
 __arm64_sys_mount+0x3dc/0x48c fs/namespace.c:4088
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x78/0x1b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xe8/0x1b0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x40/0x50 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x14c arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

Allocated by task 3311:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
 save_stack_info+0x34/0x144 mm/kasan/tags.c:106
 kasan_save_alloc_info+0x14/0x20 mm/kasan/tags.c:142
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0x9c mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x2cc/0x434 mm/slub.c:4325
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 binderfs_binder_device_create+0x124/0x6a0 drivers/android/binderfs.c:147
 binderfs_fill_super+0x5d4/0x814 drivers/android/binderfs.c:729
 vfs_get_super fs/super.c:1280 [inline]
 get_tree_nodev+0x98/0x110 fs/super.c:1299
 binderfs_fs_context_get_tree+0x28/0x38 drivers/android/binderfs.c:749
 vfs_get_tree+0x68/0x1e4 fs/super.c:1814
 do_new_mount+0x218/0x5d8 fs/namespace.c:3560
 path_mount+0x428/0xa64 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount fs/namespace.c:4088 [inline]
 __arm64_sys_mount+0x3dc/0x48c fs/namespace.c:4088
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x78/0x1b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xe8/0x1b0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x40/0x50 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x14c arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

Freed by task 3311:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
 save_stack_info+0x34/0x144 mm/kasan/tags.c:106
 kasan_save_free_info+0x18/0x24 mm/kasan/tags.c:147
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x64/0x68 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x14c/0x450 mm/slub.c:4757
 binderfs_evict_inode+0x124/0x194 drivers/android/binderfs.c:278
 evict+0x2e4/0x610 fs/inode.c:796
 iput_final fs/inode.c:1946 [inline]
 iput+0x564/0x5d8 fs/inode.c:1972
 dentry_unlink_inode+0x2e0/0x310 fs/dcache.c:440
 __dentry_kill+0x130/0x3e8 fs/dcache.c:643
 shrink_kill+0xf8/0x324 fs/dcache.c:1088
 shrink_dentry_list+0x280/0x4ec fs/dcache.c:1115
 shrink_dcache_parent+0x88/0x21c
 do_one_tree+0x2c/0xc0 fs/dcache.c:1578
 shrink_dcache_for_umount+0x90/0x118 fs/dcache.c:1595
 generic_shutdown_super+0x50/0x214 fs/super.c:620
 kill_anon_super fs/super.c:1237 [inline]
 kill_litter_super+0x64/0x90 fs/super.c:1247
 binderfs_kill_super+0x3c/0x88 drivers/android/binderfs.c:791
 deactivate_locked_super+0xa8/0x110 fs/super.c:473
 deactivate_super+0xdc/0xe0 fs/super.c:506
 cleanup_mnt+0x228/0x298 fs/namespace.c:1413
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1420
 task_work_run+0x154/0x1c4 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x3b8/0x10dc kernel/exit.c:938
 do_group_exit+0xfc/0x13c kernel/exit.c:1087
 get_signal+0xd1c/0xd94 kernel/signal.c:3036
 do_signal+0x17c/0x29a4 arch/arm64/kernel/signal.c:1658
 do_notify_resume+0x7c/0x1b8 arch/arm64/kernel/entry-common.c:148
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xac/0x14c arch/arm64/kernel/entry-common.c:745
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

The buggy address belongs to the object at fff00000124ffa00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 8 bytes inside of
 288-byte region [fff00000124ffa00, fff00000124ffb20)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x524ff
anon flags: 0x1ffc00000000000(node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
page_type: f5(slab)
raw: 01ffc00000000000 28f000000a001900 0000000000000000 0000000000000001
raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 fff00000124ff800: 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01
 fff00000124ff900: 01 01 01 01 fe fe fe fe fe fe fe fe fe fe fe fe
>fff00000124ffa00: 84 84 84 84 84 84 84 84 84 84 84 84 84 84 84 84
                   ^
 fff00000124ffb00: 84 84 fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 fff00000124ffc00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
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

