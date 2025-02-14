Return-Path: <linux-kernel+bounces-514746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB65A35B01
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B53D188C2D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7292505C2;
	Fri, 14 Feb 2025 09:59:24 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB3245AFC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527163; cv=none; b=QFo3FJD5Yr7w05q9bg9n4IEgMCoyyAGgnt/IJdsjzxoO3WOAwriM5S7JP46P6frK+icp65Z+eXJqwewj54u36aDsjlKeLP2y52YplVYRVZErzFEih3iUeYjFmG5bkb5RHBNwCNU7hGXPfMzsjYJjgz+eGLLx+9FQqaXknMcsKf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527163; c=relaxed/simple;
	bh=4MxrVFy88TBS6bpwTDVzMtKIBFHNvvMCTimPTA0x7VU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R1HiaEsn0zLYJiEfqHRcKSlmEPAugl0NJlvzF934+XYBFT2kaJmYsV+prlo2tZY0g919bwBTiKRAYwS/Knw1XAc6IfUpzWr9EgPAfesPVwdqGVNvfk7vOfnKKX3mn3qY2Dh2CQJISJ1k86SYwfo+6yP4HZK7uE7ujqMq4wfsPKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cfba1ca53bso13510455ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739527161; x=1740131961;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pO9vi0rb1UFYB8bG53BM6YGHkQtc6g+KGVEW9G3592c=;
        b=b83Aw0GF5XH4HwkfxANM2a8vxJKOzaCtbl2IO+bzZb3sN1rtpDa+iyvW7e3gKHfEah
         dvIO0cSIAZIGJ8Qm6rkHoi+kPIySqc8qn841hTOAXnRd1Y+ss0qZaFHK4Fiw/Bj3+rVH
         bFh8Oq9GY/xzvdVbsTMfj/TEfdv9Xgt7diuiT6cDX9fGfUO4IgXT82YF4P3arL4GV2Sc
         Fh/eg1vnbPFtM9nmh8IWyPjZNBctoTtHDpHU/m54b2wYLdQm/ttj8CXWIixQzg1HaAmJ
         OlqODREYQ9oC4fo4ucC2B8UJ61l7aXBL97S8w2g93jn+uhCQhDQTk5YQiXXHsMQ4yqQB
         5z8g==
X-Gm-Message-State: AOJu0YzYCy7z3FcHSBXWjua0ZfhQwKvW/roPH57KE2SBSpNt+a4yJqyk
	/el+wbdUvXy0XpI6d5C0Ilg1+XBWjxliMwnupxxqZkrrRFv3QRY4O8nZJg/+oUN6pt40KB81mI3
	Fwju5HTIcuzMG+WaGAcGiBk5UGx1lQUBYBwQ0pjFPS+OiFWdf+EIXYLZGaA==
X-Google-Smtp-Source: AGHT+IG7a/ROwwn2nM3Ej2BJE4hyiZzct5fM2SJJYc9UDs2l7JbYEg5EVD3Hclo+5cQ4ycspon+fYfbby4qS72r39jTJ8bLJo8iv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218d:b0:3cf:b87b:8fde with SMTP id
 e9e14a558f8ab-3d17bfe505fmr72909545ab.17.1739527160755; Fri, 14 Feb 2025
 01:59:20 -0800 (PST)
Date: Fri, 14 Feb 2025 01:59:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67af13f8.050a0220.21dd3.0038.GAE@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Read in idr_for_each
From: syzbot <syzbot+a2b84e569d06ca3a949c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    09fbf3d50205 Merge tag 'tomoyo-pr-20250211' of git://git.c..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b48718580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b4ba914aa7feffc
dashboard link: https://syzkaller.appspot.com/bug?extid=a2b84e569d06ca3a949c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0cb4344f4ddf/disk-09fbf3d5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9feb281ff6c6/vmlinux-09fbf3d5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cfb2666179f2/bzImage-09fbf3d5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2b84e569d06ca3a949c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in radix_tree_next_slot include/linux/radix-tree.h:424 [inline]
BUG: KASAN: slab-use-after-free in idr_for_each+0x252/0x270 lib/idr.c:202
Read of size 8 at addr ffff88805354a3f0 by task syz.0.13243/4790

CPU: 0 UID: 0 PID: 4790 Comm: syz.0.13243 Tainted: G     U             6.14.0-rc2-syzkaller-00039-g09fbf3d50205 #0
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 radix_tree_next_slot include/linux/radix-tree.h:424 [inline]
 idr_for_each+0x252/0x270 lib/idr.c:202
 shm_destroy_orphaned+0x85/0x90 ipc/shm.c:435
 proc_ipc_dointvec_minmax_orphans+0xca/0xe0 ipc/ipc_sysctl.c:32
 proc_sys_call_handler+0x3c6/0x5a0 fs/proc/proc_sysctl.c:601
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcfe838cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcfe9214038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fcfe85a5fa0 RCX: 00007fcfe838cde9
RDX: 000000000000fdef RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fcfe840e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fcfe85a5fa0 R15: 00007ffc477f12e8
 </TASK>

Allocated by task 1798:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x1c8/0x3b0 mm/slub.c:4171
 radix_tree_node_alloc.constprop.0+0x1e8/0x350 lib/radix-tree.c:253
 idr_get_free+0x528/0xa40 lib/radix-tree.c:1506
 idr_alloc_u32+0x191/0x2f0 lib/idr.c:46
 idr_alloc_cyclic+0x10c/0x230 lib/idr.c:125
 ipc_idr_alloc ipc/util.c:230 [inline]
 ipc_addid+0x697/0x1f50 ipc/util.c:305
 newseg+0x674/0xe60 ipc/shm.c:775
 ipcget_public ipc/util.c:415 [inline]
 ipcget+0x866/0xd80 ipc/util.c:676
 ksys_shmget ipc/shm.c:839 [inline]
 __do_sys_shmget ipc/shm.c:844 [inline]
 __se_sys_shmget ipc/shm.c:842 [inline]
 __x64_sys_shmget+0x13f/0x1b0 ipc/shm.c:842
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 16:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kmem_cache_free+0x2e2/0x4d0 mm/slub.c:4711
 rcu_do_batch kernel/rcu/tree.c:2546 [inline]
 rcu_core+0x79d/0x14d0 kernel/rcu/tree.c:2802
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
 run_ksoftirqd kernel/softirq.c:950 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:942
 smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xb8/0xd0 mm/kasan/generic.c:548
 __call_rcu_common.constprop.0+0x9a/0x870 kernel/rcu/tree.c:3065
 radix_tree_node_free lib/radix-tree.c:310 [inline]
 delete_node+0x1fc/0x8e0 lib/radix-tree.c:573
 __radix_tree_delete+0x193/0x3d0 lib/radix-tree.c:1379
 radix_tree_delete_item+0xeb/0x230 lib/radix-tree.c:1430
 ipc_rmid+0x10b/0x3e0 ipc/util.c:501
 shm_rmid ipc/shm.c:275 [inline]
 shm_destroy+0x2d7/0x6d0 ipc/shm.c:336
 shm_try_destroy_orphaned ipc/shm.c:426 [inline]
 shm_try_destroy_orphaned+0x1a8/0x270 ipc/shm.c:409
 idr_for_each+0x141/0x270 lib/idr.c:208
 shm_destroy_orphaned+0x85/0x90 ipc/shm.c:435
 proc_ipc_dointvec_minmax_orphans+0xca/0xe0 ipc/ipc_sysctl.c:32
 proc_sys_call_handler+0x3c6/0x5a0 fs/proc/proc_sysctl.c:601
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88805354a3c0
 which belongs to the cache radix_tree_node of size 576
The buggy address is located 48 bytes inside of
 freed 576-byte region [ffff88805354a3c0, ffff88805354a600)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880535498c0 pfn:0x53548
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802f32c001
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801b04fdc0 ffffea00008e6010 ffff88801b04ed08
raw: ffff8880535498c0 0000000000170013 00000000f5000000 ffff88802f32c001
head: 00fff00000000240 ffff88801b04fdc0 ffffea00008e6010 ffff88801b04ed08
head: ffff8880535498c0 0000000000170013 00000000f5000000 ffff88802f32c001
head: 00fff00000000002 ffffea00014d5201 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Reclaimable, gfp_mask 0x52830(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_RECLAIMABLE), pid 15204, tgid 15203 (syz.4.4472), ts 346641279489, free_ts 344707683829
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x221/0x2470 mm/page_alloc.c:4739
 alloc_pages_mpol+0x1fc/0x540 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2587 [inline]
 new_slab+0x23d/0x330 mm/slub.c:2640
 ___slab_alloc+0xbfa/0x1600 mm/slub.c:3826
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 kmem_cache_alloc_noprof+0xeb/0x3b0 mm/slub.c:4171
 radix_tree_node_alloc.constprop.0+0x1e8/0x350 lib/radix-tree.c:253
 idr_get_free+0x528/0xa40 lib/radix-tree.c:1506
 idr_alloc_u32+0x191/0x2f0 lib/idr.c:46
 idr_alloc_cyclic+0x10c/0x230 lib/idr.c:125
 __kernfs_new_node+0x11b/0x890 fs/kernfs/dir.c:630
 kernfs_new_node+0x186/0x240 fs/kernfs/dir.c:700
 __kernfs_create_file+0x53/0x350 fs/kernfs/file.c:1034
 sysfs_add_file_mode_ns+0x1ff/0x3b0 fs/sysfs/file.c:313
page last free pid 15144 tgid 15144 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0x6db/0xfb0 mm/page_alloc.c:2660
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_node_noprof+0x1ca/0x3b0 mm/slub.c:4216
 alloc_task_struct_node kernel/fork.c:180 [inline]
 dup_task_struct kernel/fork.c:1119 [inline]
 copy_process+0x49c/0x6f20 kernel/fork.c:2233
 kernel_clone+0xfd/0x960 kernel/fork.c:2815
 __do_sys_clone3+0x1f9/0x270 kernel/fork.c:3119
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805354a280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88805354a300: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff88805354a380: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                             ^
 ffff88805354a400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805354a480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

