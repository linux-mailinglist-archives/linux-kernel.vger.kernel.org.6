Return-Path: <linux-kernel+bounces-229370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D8A916EED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960AB2881E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD58176FCE;
	Tue, 25 Jun 2024 17:13:23 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BCC2F56
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335602; cv=none; b=S7MudnyZMdNpxiG9Iwvn5qGMY/gqNg2m5xQfljxGvfBjmTzgZseCWH8RJBaEvBMTgiJDXXEJDt6Vgwhahxsg890+W/SdKDAKA4pEYSzmd4KSWuD9MZFHVXWc3BXF4lnOSzZabSv3QCcbFgkoGKuiR5/bIKXAc4M1Dx3MqgNqJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335602; c=relaxed/simple;
	bh=SwA6L18jVnsQnP5oylGcLVnYuhMpZRsgDXJMb7sAShg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bjsQKFhl/wCkG1veyY/4k8TlipT5PTYlKXZXNt5P/Cl0D/tdohyi661HYcjsQBtlAYNpGvS3M6nBxoFgfKfwDl4scohumuZt32cDGI+5mfcZOpQJARlP1uhQU/WnDWE9Cd39GOGMkwxpCl3wBctIh6SVnSE5zqrmnMgkXFJ1l7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7f38c10cab9so725706139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719335600; x=1719940400;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66Kmmjskmo4ThUWDPQshbHLXKPhwsOZMZT3UJK7tO44=;
        b=fvqatBd937Ztk0E7bd8wRx0a4s3OCfP+ba0E8NKUKO36zoY73ka5ix/NLFeeDQ3aJM
         JbV47TWrD531dSXJU8/grHDik95eIyNOpnoT/IQC1o8tsapNm3ir39AiQTfUuI2ihwWl
         7huLesVlR66rzeeD/kzl87PEit0MHesMYr+MO2NBe8vu4bHTETFkHN2Z3jNrDg9pbj0U
         WIVZPvMN7xkuVVYnjeEejsPEPEtLM/CxHTy6hmYOoSHPrmEPXxuKJz/ugj9pLUlh9ci+
         mbholklM16FZ/Jo55osrIefxKXF/64a+T7fhHvNR5aGCfWj0C0xd3tVMzqkIhGuoNRtW
         2wUA==
X-Forwarded-Encrypted: i=1; AJvYcCXWRfIxz60vLhI572eflo4eA4Z/R1Z9FItEDNicne3v3U7ZR2F0ex8ZCCiIv6g5JsxMjqXdORIe7B6XZFaCU30vhkH8gaMBy6Cfggju
X-Gm-Message-State: AOJu0YxaLofFlt/z8RF5djpt0JILKB3WDE0Kj/FQ+ufU94HfgntwIH/u
	F8J9IEVHz7BfCw0MtAa2e+SDlkgKViI1c0q30WH3IRFlA/ML5zgiiwSnqsKxYS2p+B7Gjh/j1kk
	70YVduyKanoDk4eNC294vBQB1pBrmU4dU+ArwrBw9zr/jvhqk3fnGYBI=
X-Google-Smtp-Source: AGHT+IF678WmByhJxCl8VeB0CE622WNItxdmTPkKZleV/fX3UFFXiPFRTZBnUJpQ/+hSPD4DnlY2J97Ngw8XjXT6T7VN6z/vO9Xq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1688:b0:4b9:32f8:574f with SMTP id
 8926c6da1cb9f-4b9ed085e63mr562975173.5.1719335600372; Tue, 25 Jun 2024
 10:13:20 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:13:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5c648061bba03cd@google.com>
Subject: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in bch2_sb_errors_from_cpu
From: syzbot <syzbot+a2bc0e838efd7663f4d9@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66cc544fd75c Merge tag 'dmaengine-fix-6.10' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a7e5ea980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3820d4fff43c7a3
dashboard link: https://syzkaller.appspot.com/bug?extid=a2bc0e838efd7663f4d9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107ed151980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1765c589980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-66cc544f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be894c048296/vmlinux-66cc544f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/edc3f9fbd3ca/bzImage-66cc544f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3d5362aaefc3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2bc0e838efd7663f4d9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in bch2_sb_errors_from_cpu+0x255/0x280 fs/bcachefs/sb-errors.c:122
Read of size 8 at addr ffff88801ac73100 by task kworker/u32:2/45

CPU: 3 PID: 45 Comm: kworker/u32:2 Not tainted 6.10.0-rc4-syzkaller-00164-g66cc544fd75c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: btree_update btree_interior_update_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 bch2_sb_errors_from_cpu+0x255/0x280 fs/bcachefs/sb-errors.c:122
 bch2_write_super+0x12b2/0x37a0 fs/bcachefs/super-io.c:969
 btree_update_new_nodes_mark_sb fs/bcachefs/btree_update_interior.c:626 [inline]
 btree_update_nodes_written fs/bcachefs/btree_update_interior.c:688 [inline]
 btree_interior_update_work+0x46e/0x2cb0 fs/bcachefs/btree_update_interior.c:859
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5596:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4122 [inline]
 __kmalloc_node_noprof+0x215/0x440 mm/slub.c:4129
 kmalloc_node_noprof include/linux/slab.h:681 [inline]
 kvmalloc_node_noprof+0x9d/0x1a0 mm/util.c:634
 kvmalloc_array_node_noprof include/linux/slab.h:800 [inline]
 __bch2_darray_resize+0xd8/0x250 fs/bcachefs/darray.c:12
 __darray_resize fs/bcachefs/darray.h:31 [inline]
 __darray_make_room fs/bcachefs/darray.h:43 [inline]
 bch2_sb_error_count+0x34f/0x4e0 fs/bcachefs/sb-errors.c:102
 __bch2_inode_invalid+0x2c6/0x4d0 fs/bcachefs/inode.c:441
 bch2_inode_v3_invalid+0x1f1/0x2e0 fs/bcachefs/inode.c:529
 bch2_bkey_val_invalid+0x222/0x2f0 fs/bcachefs/bkey_methods.c:143
 bch2_btree_node_read_done+0x3294/0x4fe0 fs/bcachefs/btree_io.c:1232
 btree_node_read_work+0x567/0x1060 fs/bcachefs/btree_io.c:1345
 bch2_btree_node_read+0x8b3/0xe40 fs/bcachefs/btree_io.c:1730
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1769 [inline]
 bch2_btree_root_read+0x2ca/0x690 fs/bcachefs/btree_io.c:1793
 read_btree_roots fs/bcachefs/recovery.c:475 [inline]
 bch2_fs_recovery+0x1ba8/0x3db0 fs/bcachefs/recovery.c:803
 bch2_fs_start+0x2e9/0x600 fs/bcachefs/super.c:1035
 bch2_fs_open+0xfa0/0x1110 fs/bcachefs/super.c:2127
 bch2_mount+0xe2c/0x1230 fs/bcachefs/fs.c:1919
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5596:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4558
 kvfree+0x47/0x50 mm/util.c:680
 __bch2_darray_resize+0x185/0x250 fs/bcachefs/darray.c:18
 __darray_resize fs/bcachefs/darray.h:31 [inline]
 __darray_make_room fs/bcachefs/darray.h:43 [inline]
 bch2_sb_error_count+0x34f/0x4e0 fs/bcachefs/sb-errors.c:102
 bch2_fsck_err+0x180/0x1730 fs/bcachefs/error.c:210
 bch2_bucket_ref_update+0xcd3/0xf80 fs/bcachefs/buckets.c:834
 __mark_pointer+0x10c/0x410 fs/bcachefs/buckets.c:1000
 bch2_trigger_pointer.constprop.0+0xce4/0x25c0 fs/bcachefs/buckets.c:1037
 __trigger_extent+0x414/0xc00 fs/bcachefs/buckets.c:1176
 bch2_trigger_extent+0x4ee/0x5d0 fs/bcachefs/buckets.c:1261
 bch2_key_trigger fs/bcachefs/bkey_methods.h:88 [inline]
 bch2_key_trigger_new fs/bcachefs/bkey_methods.h:116 [inline]
 run_one_trans_trigger fs/bcachefs/btree_trans_commit.c:517 [inline]
 run_btree_triggers+0x6f1/0xd10 fs/bcachefs/btree_trans_commit.c:544
 bch2_trans_commit_run_triggers fs/bcachefs/btree_trans_commit.c:576 [inline]
 __bch2_trans_commit+0x366/0x7ad0 fs/bcachefs/btree_trans_commit.c:1022
 bch2_trans_commit fs/bcachefs/btree_update.h:170 [inline]
 bch2_extent_update+0x494/0xa40 fs/bcachefs/io_write.c:326
 bch2_fpunch_at+0x7e6/0xbc0 fs/bcachefs/io_misc.c:184
 __bch2_resume_logged_op_truncate+0x4ce/0x7a0 fs/bcachefs/io_misc.c:260
 bch2_truncate+0x1e1/0x220 fs/bcachefs/io_misc.c:291
 bchfs_truncate+0x90c/0xd70 fs/bcachefs/fs-io.c:476
 bch2_setattr+0x1ab/0x250 fs/bcachefs/fs.c:918
 notify_change+0x742/0x11f0 fs/attr.c:497
 do_truncate+0x15c/0x220 fs/open.c:65
 vfs_truncate+0x3ef/0x4e0 fs/open.c:111
 do_sys_truncate fs/open.c:134 [inline]
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __x64_sys_truncate+0x177/0x1f0 fs/open.c:144
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801ac73100
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes inside of
 freed 16-byte region [ffff88801ac73100, ffff88801ac73110)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ac73
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000000 ffff888015442640 ffffea0000675400 dead000000000002
raw: 0000000000000000 0000000000800080 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (init), ts 23767929677, free_ts 22379130869
 create_dummy_stack mm/page_owner.c:94 [inline]
 register_dummy_stack+0x8a/0xd0 mm/page_owner.c:100
 init_page_owner+0x48/0xbf0 mm/page_owner.c:118
 invoke_init_callbacks mm/page_ext.c:148 [inline]
 page_ext_init+0x6af/0xaa0 mm/page_ext.c:493
 mm_core_init+0x68d/0x740 mm/mm_init.c:2725
page last free pid 8 tgid 8 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2583
 vfree+0x181/0x7a0 mm/vmalloc.c:3346
 delayed_vfree_work+0x56/0x70 mm/vmalloc.c:3267
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88801ac73000: 00 00 fc fc fa fb fc fc fa fb fc fc fa fb fc fc
 ffff88801ac73080: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>ffff88801ac73100: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
                   ^
 ffff88801ac73180: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
 ffff88801ac73200: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
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

