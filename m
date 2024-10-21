Return-Path: <linux-kernel+bounces-373524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03679A5833
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E17A1F20FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 00:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B057462;
	Mon, 21 Oct 2024 00:40:37 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D401FDD
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729471237; cv=none; b=HDyWox+NAFJS/QMX1DTrZSl+/yEhgjC1Go9DMieTwbIq1VP7yXVvopZZTb/6VoFIlwNJ7vMHziGQDBRgZdPqygFxu9P73KdPu2zetSmKL1lJl3xdRFLTSUL77gmX6yAuJpVZQQw53ZQ/LOb0NuQBm6YUg/agSQTwizth04ivNwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729471237; c=relaxed/simple;
	bh=YDSUl+oTjwOsxdJ4cQ0UPiNbzptzZIDgQSCu2sh9M30=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dCr/frpV4N5YcfIrBfWZcf0ZAz9bI/qzMLtNXhHiaVZFeJeJCGXLa0UedqOu+S1rU6vD89KfdHsNflc+BfpQMo+kVPv45HQGLQAj8isvNGgOiMEWv3IA7NSqWuiQ3mrBriGI6RO8GePQ6/UGgcimZl4Doz7FcbBeABpDjHDvuNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b4395dedso36228075ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 17:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729471234; x=1730076034;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsY3dWlh/LzELHSyrae1TYpmYyLRquBWbH9nTXICvDA=;
        b=Nb0zKL397po2itAKDNUDnOeYZo4HVnJJrc5TUtyRp5gfGgIDzrkjkQm0TZGBJ5UdYE
         qTIjOhnBkkY/qNiSEz1LPNNJBcSXh4Frl7O1QiynwOIo3nHCqORP5pOILaCsaISNEBnt
         Gv8DLFOPgMT2TJthLTSublGrC6A4Rq6QsE435qqW+VKorl+dUOKde5iZrTHsc/g15/lH
         rfGW2PmRKrFSOxoZCDTXCNNfLWO5o2Aw6qxXoTWQz8imEaIXSgYDEb2eTtEA/UMrBluD
         59wS+siYjmQECgyYeiW5XXeP0VTshAMZ5Pzou79VmTEDPISOYkQKqfw7FevI301u6SgU
         oeYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXAn4FdjlCZohtC4K4PagrF36YfPfsigwOBVXy2b246ocVdG3H8Q29oGIxRUc62NMmLHfceJeN0/cuvX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfXw2ZUOFVKBlb6qWxddtApxyg8UxfPqQQwWRG0ZE6+8VddQL2
	M32kkYI79CFDJhyoZo1q8i1kv8j1xIaBwP+6uAoIQbKi0GcNG7xAnhi67z2fZ9xWIgmmS4bGLxM
	+IA3/UyCeHGeimzjHiNYUJ4hLXFzwdkfCeXvKkBpUeRzlQrJ9FJhB1ow=
X-Google-Smtp-Source: AGHT+IFBQbZL0GQhdLU1mia+b8nYr0R623HYtRlQxWXrlUwEQfBqDZC3iBpOUThq3+0pHaoOJdsz2ee+EP4xGNvJTmaU/hnHELcv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:3a0:9a32:dedc with SMTP id
 e9e14a558f8ab-3a3f405d059mr84487785ab.6.1729471234121; Sun, 20 Oct 2024
 17:40:34 -0700 (PDT)
Date: Sun, 20 Oct 2024 17:40:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6715a302.050a0220.10f4f4.003a.GAE@google.com>
Subject: [syzbot] [bfs?] possible deadlock in bfs_lookup
From: syzbot <syzbot+217317969b6cefff1415@syzkaller.appspotmail.com>
To: aivazian.tigran@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c964ced77262 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1315f45f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=217317969b6cefff1415
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c964ced7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e937ef58569a/vmlinux-c964ced7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1df9880ca4b/bzImage-c964ced7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+217317969b6cefff1415@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc3-syzkaller-00087-gc964ced77262 #0 Not tainted
------------------------------------------------------
syz.0.0/5114 is trying to acquire lock:
ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:318 [inline]
ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4036 [inline]
ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4114 [inline]
ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_lru_noprof+0x42/0x2b0 mm/slub.c:4153

but task is already holding lock:
ffff8880409598d8 (&info->bfs_lock){+.+.}-{3:3}, at: bfs_lookup+0x139/0x270 fs/bfs/dir.c:136

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&info->bfs_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       bfs_evict_inode+0x272/0x510 fs/bfs/inode.c:182
       evict+0x4e8/0x9b0 fs/inode.c:725
       __dentry_kill+0x20d/0x630 fs/dcache.c:615
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1060
       shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1087
       prune_dcache_sb+0x10f/0x180 fs/dcache.c:1168
       super_cache_scan+0x34f/0x4b0 fs/super.c:221
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
       shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
       shrink_one+0x43b/0x850 mm/vmscan.c:4818
       shrink_many mm/vmscan.c:4879 [inline]
       lru_gen_shrink_node mm/vmscan.c:4957 [inline]
       shrink_node+0x3799/0x3de0 mm/vmscan.c:5937
       kswapd_shrink_node mm/vmscan.c:6765 [inline]
       balance_pgdat mm/vmscan.c:6957 [inline]
       kswapd+0x1ca3/0x3700 mm/vmscan.c:7226
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __fs_reclaim_acquire mm/page_alloc.c:3834 [inline]
       fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3848
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4036 [inline]
       slab_alloc_node mm/slub.c:4114 [inline]
       kmem_cache_alloc_lru_noprof+0x42/0x2b0 mm/slub.c:4153
       bfs_alloc_inode+0x28/0x40 fs/bfs/inode.c:239
       alloc_inode+0x65/0x1a0 fs/inode.c:265
       iget_locked+0xf1/0x5a0 fs/inode.c:1418
       bfs_iget+0x28/0xac0 fs/bfs/inode.c:41
       bfs_lookup+0x1ca/0x270 fs/bfs/dir.c:141
       lookup_open fs/namei.c:3573 [inline]
       open_last_lookups fs/namei.c:3694 [inline]
       path_openat+0x11a7/0x3590 fs/namei.c:3930
       do_filp_open+0x235/0x490 fs/namei.c:3960
       do_open_execat fs/exec.c:901 [inline]
       open_exec+0xc0/0x2b0 fs/exec.c:935
       bm_register_write+0xc1c/0x15e0 fs/binfmt_misc.c:830
       vfs_write+0x29c/0xc90 fs/read_write.c:681
       ksys_write+0x183/0x2b0 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&info->bfs_lock);
                               lock(fs_reclaim);
                               lock(&info->bfs_lock);
  lock(fs_reclaim);

 *** DEADLOCK ***

4 locks held by syz.0.0/5114:
 #0: ffff88801e34ad38 (&f->f_pos_lock){+.+.}-{3:3}, at: fdget_pos+0x24e/0x320 fs/file.c:1160
 #1: ffff88801a84e420 (sb_writers#10){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #1: ffff88801a84e420 (sb_writers#10){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #2: ffff8880007d8160 (&type->i_mutex_dir_key#7){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:825 [inline]
 #2: ffff8880007d8160 (&type->i_mutex_dir_key#7){++++}-{3:3}, at: open_last_lookups fs/namei.c:3693 [inline]
 #2: ffff8880007d8160 (&type->i_mutex_dir_key#7){++++}-{3:3}, at: path_openat+0x88b/0x3590 fs/namei.c:3930
 #3: ffff8880409598d8 (&info->bfs_lock){+.+.}-{3:3}, at: bfs_lookup+0x139/0x270 fs/bfs/dir.c:136

stack backtrace:
CPU: 0 UID: 0 PID: 5114 Comm: syz.0.0 Not tainted 6.12.0-rc3-syzkaller-00087-gc964ced77262 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __fs_reclaim_acquire mm/page_alloc.c:3834 [inline]
 fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3848
 might_alloc include/linux/sched/mm.h:318 [inline]
 slab_pre_alloc_hook mm/slub.c:4036 [inline]
 slab_alloc_node mm/slub.c:4114 [inline]
 kmem_cache_alloc_lru_noprof+0x42/0x2b0 mm/slub.c:4153
 bfs_alloc_inode+0x28/0x40 fs/bfs/inode.c:239
 alloc_inode+0x65/0x1a0 fs/inode.c:265
 iget_locked+0xf1/0x5a0 fs/inode.c:1418
 bfs_iget+0x28/0xac0 fs/bfs/inode.c:41
 bfs_lookup+0x1ca/0x270 fs/bfs/dir.c:141
 lookup_open fs/namei.c:3573 [inline]
 open_last_lookups fs/namei.c:3694 [inline]
 path_openat+0x11a7/0x3590 fs/namei.c:3930
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_open_execat fs/exec.c:901 [inline]
 open_exec+0xc0/0x2b0 fs/exec.c:935
 bm_register_write+0xc1c/0x15e0 fs/binfmt_misc.c:830
 vfs_write+0x29c/0xc90 fs/read_write.c:681
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2a78d7dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2a79bf4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2a78f35f80 RCX: 00007f2a78d7dff9
RDX: 000000000000003f RSI: 0000000020000200 RDI: 0000000000000005
RBP: 00007f2a78df0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2a78f35f80 R15: 00007ffe29710148
 </TASK>
binfmt_misc: register: failed to install interpreter file ./file0


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

