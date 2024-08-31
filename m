Return-Path: <linux-kernel+bounces-310016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F48967320
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 21:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6628828279F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 19:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0DF14B971;
	Sat, 31 Aug 2024 19:27:21 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239D524F
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725132440; cv=none; b=A0/Ynw2o3n73qXqKB5HVEokYgNQYZZNRW19ARfL4KwkSrEj2Dyu03HkRVRKzhoZCDtyVS4m+d/TDKHeEp1pMks5j2yuDP4BO0QNnruNLK6iPxz0s7rfrPKpErSDBP3czAzH0TadaHhRsC4cT81Wo7VzivuHnBFoWC48Pcv96TX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725132440; c=relaxed/simple;
	bh=i0rfvjZ6IXwr4pipi5oVmD/I324+LzHHdEG6LEERT0s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c/rOK92EJcKJrnGx3Ne+VO9JV0E+WWjy7FvsWl3r8LRsMxaTmNuUSptuRKteaO8DCtY2/oowx5wj//EVcNPJ7xpc/iW2YlkBVCY2Wu1GCJv3thsh4HLjeb49RJ7ZRhrEfzs79uQcXZsc8TC43JRutUtBczmjA2Y1A5aRDtE1oh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f53b1932aso4493045ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 12:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725132438; x=1725737238;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkhH1aHGr9SFTGNlf74HsVh1z1o4wbFgwgaZN309IOk=;
        b=tyeKpoS1Uf7v/Ch8ZzzCq9R3MgY+/oaCn0qJkceopFKsfUN1c081qtFoHOoSi1/xRF
         Ndd+O2ByFy6nwzDDTIvvuGJ0q19XAEslcHjRgw6tltH+FU1eRUSmxVqyFCAB4aCYJk9x
         5DrY9fbEyv2lPW5Tejiuj87K6tiL7KQotIgh4lgSerQ6GyFm0ITVgpn5KgwSW4Lh0+QR
         SwiE540Bqv67EUZTyR5POM5BfF0B9lQS7YOYo+DK5W9d3jGTzLwlGUDWQLNZTkMZlyuU
         Zwe03NUFyE7h9bcyGxA3HL3fElOCIynOmet6dUVmFQT53iKh31J+10EOcn9x+lEshHjn
         geFA==
X-Forwarded-Encrypted: i=1; AJvYcCVPTbzUq3UzK6uvROdFkbU75mVIGzT/EvG6/EBzRhxzgK3GzD4bwItN6fvUratJI3ZWatlUkG6ybnRYWbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0390Mt7I433dlBiqA21xaqmTAY4DAKw7KSD3t9O76l/VR4nWG
	blX66Qz5RCnA5K8MhQOOPfMsvwUEhcrmeJKSMtnauLpibNaGT6jakHDnXEMyWeiIwdFXayHLM0W
	21lELGiXEIcgNDzMlfKGEkNWSDQdWE71x3+hNgLecfeLqoNhCr5s+680=
X-Google-Smtp-Source: AGHT+IH8OPmEVZYFQrWEwQfsDMWM2uWQZNlZ8e6fByoufblqfA8dQjk9Y56aEEbUek5TyE2PV/GjzM9FnXvihV5j8UW7Wb6YPSR2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d83:b0:39d:3043:1f20 with SMTP id
 e9e14a558f8ab-39f410838a3mr4706725ab.5.1725132438321; Sat, 31 Aug 2024
 12:27:18 -0700 (PDT)
Date: Sat, 31 Aug 2024 12:27:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d4c5e0620ffb2f5@google.com>
Subject: [syzbot] [mm?] KMSAN: uninit-value in zswap_store (2)
From: syzbot <syzbot+d13dc01606d396f1a66e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3e9bff3bbe13 Merge tag 'vfs-6.11-rc6.fixes' of gitolite.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e9fb8d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=522060455c43d52e
dashboard link: https://syzkaller.appspot.com/bug?extid=d13dc01606d396f1a66e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2143e6626450/disk-3e9bff3b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20b63281b398/vmlinux-3e9bff3b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d0aef7b01715/bzImage-3e9bff3b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d13dc01606d396f1a66e@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in zswap_is_folio_same_filled mm/zswap.c:1371 [inline]
BUG: KMSAN: uninit-value in zswap_store+0x13e7/0x2dd0 mm/zswap.c:1438
 zswap_is_folio_same_filled mm/zswap.c:1371 [inline]
 zswap_store+0x13e7/0x2dd0 mm/zswap.c:1438
 swap_writepage+0x11f/0x470 mm/page_io.c:198
 shmem_writepage+0x1a75/0x1f70 mm/shmem.c:1536
 pageout mm/vmscan.c:680 [inline]
 shrink_folio_list+0x577f/0x7cb0 mm/vmscan.c:1360
 evict_folios+0x9bce/0xbc80 mm/vmscan.c:4580
 try_to_shrink_lruvec+0x13a3/0x1750 mm/vmscan.c:4775
 shrink_one+0x646/0xd20 mm/vmscan.c:4813
 shrink_many mm/vmscan.c:4876 [inline]
 lru_gen_shrink_node mm/vmscan.c:4954 [inline]
 shrink_node+0x451a/0x50f0 mm/vmscan.c:5934
 kswapd_shrink_node mm/vmscan.c:6762 [inline]
 balance_pgdat mm/vmscan.c:6954 [inline]
 kswapd+0x257e/0x4290 mm/vmscan.c:7223
 kthread+0x3dd/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:122 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 copy_page_from_iter_atomic+0x12bb/0x2ae0 lib/iov_iter.c:481
 copy_folio_from_iter_atomic include/linux/uio.h:186 [inline]
 generic_perform_write+0x896/0x12e0 mm/filemap.c:4032
 shmem_file_write_iter+0x2bd/0x2f0 mm/shmem.c:3074
 do_iter_readv_writev+0x8a1/0xa40
 vfs_iter_write+0x459/0xd50 fs/read_write.c:895
 lo_write_bvec drivers/block/loop.c:243 [inline]
 lo_write_simple drivers/block/loop.c:264 [inline]
 do_req_filebacked drivers/block/loop.c:511 [inline]
 loop_handle_cmd drivers/block/loop.c:1910 [inline]
 loop_process_work+0x15ec/0x3750 drivers/block/loop.c:1945
 loop_workfn+0x48/0x60 drivers/block/loop.c:1969
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea7/0x14d0 kernel/workqueue.c:3389
 kthread+0x3dd/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4718
 alloc_pages_bulk_noprof+0x19e/0x21e0 mm/page_alloc.c:4643
 btrfs_alloc_page_array fs/btrfs/extent_io.c:704 [inline]
 alloc_eb_folio_array+0x19c/0x750 fs/btrfs/extent_io.c:728
 alloc_extent_buffer+0x75a/0x3ba0 fs/btrfs/extent_io.c:3109
 btrfs_find_create_tree_block+0x46/0x60 fs/btrfs/disk-io.c:614
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:5026 [inline]
 btrfs_alloc_tree_block+0x415/0x1990 fs/btrfs/extent-tree.c:5139
 btrfs_alloc_log_tree_node fs/btrfs/disk-io.c:951 [inline]
 btrfs_add_log_tree+0x1b7/0x7a0 fs/btrfs/disk-io.c:999
 start_log_trans fs/btrfs/tree-log.c:227 [inline]
 btrfs_log_inode_parent+0xa87/0x1c30 fs/btrfs/tree-log.c:7102
 btrfs_log_dentry_safe+0x9a/0x100 fs/btrfs/tree-log.c:7207
 btrfs_sync_file+0x15d9/0x2170 fs/btrfs/file.c:1773
 vfs_fsync_range+0x20d/0x270 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2821 [inline]
 btrfs_do_write_iter+0xa17/0xb60 fs/btrfs/file.c:1515
 btrfs_file_write_iter+0x38/0x50 fs/btrfs/file.c:1525
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb2f/0x1550 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 80 Comm: kswapd0 Tainted: G        W          6.11.0-rc5-syzkaller-00015-g3e9bff3bbe13 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================


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

