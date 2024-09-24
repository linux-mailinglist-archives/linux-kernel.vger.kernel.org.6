Return-Path: <linux-kernel+bounces-336930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FEF9842BB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4B51C219AB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0056C15667D;
	Tue, 24 Sep 2024 09:55:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F1481741
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171726; cv=none; b=gvIlNZrrHAsNmp8jIMdz8Y/3n+LjN47bZjRs1WIlQDsiqg62kJ78XgwziW/6yGx0vG9DzblIjdcM0vEacqAUm51Y2JddqupVz9lMultKsjqISnf17TdASlmOOxtUOfjYts4AcgNeEGjrFZjcr366uSpf1bllmTop+V++eXMbmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171726; c=relaxed/simple;
	bh=yFvKR2sGhE0+kxDoQ+6dSgI1whRDI7/WaDxLGjGa9wA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GQqDDAyy6D2VPKtrcdqFk/dbuh9MZWOcDdYisElBrK3YU5JBEQAd0qkifzKABAz+8lM57spIb1TQk7KkPWgf+0Y4DPAqhhrk+VC52lRUkpdGI2ugF+tNzERHu2InW6eEIRLO5mpNkeSEJeOnWATY5YFbz8avHxs9JYR8xcFDPb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cd9c20b2bso730967439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727171724; x=1727776524;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHG6tr2pgwfTXV9tJzIhznVuSbyduy3fmuYBlcIRvW8=;
        b=GmxL6aMWsV3EiF/i1TQtOMy9fjwoWPUifQW160mfIyK7KihA+/IixhuiFx5cYlWcY4
         QfoiRPFUFfcBJyS+KEXh7n8cVL1gMT4AT9qTwRp2Y4DQoWR3gjr2yjgbC7SRXaj6jQ5t
         vVk0V7r7oXGp3AMpf2+eKMxy4avHHEDiWAlZR29rZEfIFASpreN6miI445Sz7weSsgmG
         oWtLM0xoxMOTQvwpiPtoKc+pfX0yxQeta3Kh4EYLxSidU4WJ99YYhP87Bhy3Q/G6nYMX
         vPTVgFTrPygf2i0xSEB5jO/OP+1PsmGFzqKce7/u8dQHCQwC2KQDqIoW90ivwLJAXUDb
         rpKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9W8Y/0qUbGMnxcDy8kanWfM8ESpaDpHEr2p1jPxlJWOManYDbtEANwfsmOGvty2e9n58Jz9Kj2oYN69A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZuMCoCW4ecvFFivBf9fqLmRJV0215P9uX5hbz3r+54xeh6tSw
	DzvbRhHGOlVoq/o14Z03x35kQunChNLVAf60GiJfbJmxzse02Wpu3btn2AljbczzhH5EsR1x7e0
	EqrYqQn8Aj9byo96vN4Z4BqhMEUBib2Bi8Ir8tF8tjbxrtKzW24u4b24=
X-Google-Smtp-Source: AGHT+IHA7AuE5ACxSmnWHiZF8xgdFVhF6pLFnfdeALjzQVb94LCp3O8U0f4lVsinU+Gb7HRPyzln0+IU/eMXBCgSnZI+rraPVl1q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3a0:9238:d38 with SMTP id
 e9e14a558f8ab-3a0c8ca4dfbmr139817965ab.10.1727171723830; Tue, 24 Sep 2024
 02:55:23 -0700 (PDT)
Date: Tue, 24 Sep 2024 02:55:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f28c8b.050a0220.c23dd.0027.GAE@google.com>
Subject: [syzbot] [gfs2?] possible deadlock in gfs2_trans_begin
From: syzbot <syzbot+5baab0d4d584f7b68982@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1868f9d0260e Merge tag 'for-linux-6.12-ofs1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b11e9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0b35925215243c6
dashboard link: https://syzkaller.appspot.com/bug?extid=5baab0d4d584f7b68982
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1868f9d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79ecea60635a/vmlinux-1868f9d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e88a1660d19/bzImage-1868f9d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5baab0d4d584f7b68982@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-syzkaller-07462-g1868f9d0260e #0 Not tainted
------------------------------------------------------
kswapd0/78 is trying to acquire lock:
ffff88801fe9a610 (sb_internal#2){.+.+}-{0:0}, at: gfs2_trans_begin+0x71/0xe0 fs/gfs2/trans.c:118

but task is already holding lock:
ffffffff8ea369a0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6821 [inline]
ffffffff8ea369a0 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x3720 mm/vmscan.c:7203

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       __fs_reclaim_acquire mm/page_alloc.c:3825 [inline]
       fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3839
       might_alloc include/linux/sched/mm.h:334 [inline]
       prepare_alloc_pages+0x147/0x5d0 mm/page_alloc.c:4473
       __alloc_pages_noprof+0x166/0x6c0 mm/page_alloc.c:4691
       alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
       alloc_pages_noprof mm/mempolicy.c:2343 [inline]
       folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2350
       filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
       __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
       filemap_grab_folio include/linux/pagemap.h:806 [inline]
       gfs2_unstuff_dinode+0xfb/0x15e0 fs/gfs2/bmap.c:162
       fallocate_chunk fs/gfs2/file.c:1190 [inline]
       __gfs2_fallocate+0xf4e/0x1e00 fs/gfs2/file.c:1337
       gfs2_fallocate+0x35c/0x490 fs/gfs2/file.c:1401
       vfs_fallocate+0x569/0x6e0 fs/open.c:333
       ksys_fallocate fs/open.c:356 [inline]
       __do_sys_fallocate fs/open.c:364 [inline]
       __se_sys_fallocate fs/open.c:362 [inline]
       __x64_sys_fallocate+0xbd/0x110 fs/open.c:362
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&ip->i_rw_mutex){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       gfs2_unstuff_dinode+0xa0/0x15e0 fs/gfs2/bmap.c:161
       fallocate_chunk fs/gfs2/file.c:1190 [inline]
       __gfs2_fallocate+0xf4e/0x1e00 fs/gfs2/file.c:1337
       gfs2_fallocate+0x35c/0x490 fs/gfs2/file.c:1401
       vfs_fallocate+0x569/0x6e0 fs/open.c:333
       ksys_fallocate fs/open.c:356 [inline]
       __do_sys_fallocate fs/open.c:364 [inline]
       __se_sys_fallocate fs/open.c:362 [inline]
       __x64_sys_fallocate+0xbd/0x110 fs/open.c:362
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&sdp->sd_log_flush_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       __gfs2_trans_begin+0x55d/0x950 fs/gfs2/trans.c:87
       gfs2_trans_begin+0x71/0xe0 fs/gfs2/trans.c:118
       alloc_dinode+0x2ef/0x5e0 fs/gfs2/inode.c:418
       gfs2_create_inode+0xf39/0x1b30 fs/gfs2/inode.c:739
       gfs2_atomic_open+0xe5/0x230 fs/gfs2/inode.c:1315
       atomic_open fs/namei.c:3455 [inline]
       lookup_open fs/namei.c:3566 [inline]
       open_last_lookups fs/namei.c:3694 [inline]
       path_openat+0x101b/0x3590 fs/namei.c:3930
       do_filp_open+0x235/0x490 fs/namei.c:3960
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
       do_sys_open fs/open.c:1430 [inline]
       __do_sys_creat fs/open.c:1506 [inline]
       __se_sys_creat fs/open.c:1500 [inline]
       __x64_sys_creat+0x123/0x170 fs/open.c:1500
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_internal#2){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3158 [inline]
       check_prevs_add kernel/locking/lockdep.c:3277 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1715 [inline]
       sb_start_intwrite include/linux/fs.h:1898 [inline]
       __gfs2_trans_begin+0x471/0x950 fs/gfs2/trans.c:76
       gfs2_trans_begin+0x71/0xe0 fs/gfs2/trans.c:118
       gfs2_dirty_inode+0x3e0/0x6b0 fs/gfs2/super.c:520
       __mark_inode_dirty+0x2ee/0xe90 fs/fs-writeback.c:2493
       mark_inode_dirty_sync include/linux/fs.h:2478 [inline]
       iput+0x1f1/0xa50 fs/inode.c:1906
       __dentry_kill+0x20d/0x630 fs/dcache.c:615
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1060
       shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1087
       prune_dcache_sb+0x10f/0x180 fs/dcache.c:1168
       super_cache_scan+0x34f/0x4b0 fs/super.c:221
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
       shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
       shrink_one+0x43b/0x850 mm/vmscan.c:4795
       shrink_many mm/vmscan.c:4856 [inline]
       lru_gen_shrink_node mm/vmscan.c:4934 [inline]
       shrink_node+0x3799/0x3de0 mm/vmscan.c:5914
       kswapd_shrink_node mm/vmscan.c:6742 [inline]
       balance_pgdat mm/vmscan.c:6934 [inline]
       kswapd+0x1cbc/0x3720 mm/vmscan.c:7203
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  sb_internal#2 --> &ip->i_rw_mutex --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&ip->i_rw_mutex);
                               lock(fs_reclaim);
  rlock(sb_internal#2);

 *** DEADLOCK ***

2 locks held by kswapd0/78:
 #0: ffffffff8ea369a0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6821 [inline]
 #0: ffffffff8ea369a0 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x3720 mm/vmscan.c:7203
 #1: ffff88801fe9a0e0 (&type->s_umount_key#47){.+.+}-{3:3}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff88801fe9a0e0 (&type->s_umount_key#47){.+.+}-{3:3}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196

stack backtrace:
CPU: 0 UID: 0 PID: 78 Comm: kswapd0 Not tainted 6.11.0-syzkaller-07462-g1868f9d0260e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2203
 check_prev_add kernel/locking/lockdep.c:3158 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1715 [inline]
 sb_start_intwrite include/linux/fs.h:1898 [inline]
 __gfs2_trans_begin+0x471/0x950 fs/gfs2/trans.c:76
 gfs2_trans_begin+0x71/0xe0 fs/gfs2/trans.c:118
 gfs2_dirty_inode+0x3e0/0x6b0 fs/gfs2/super.c:520
 __mark_inode_dirty+0x2ee/0xe90 fs/fs-writeback.c:2493
 mark_inode_dirty_sync include/linux/fs.h:2478 [inline]
 iput+0x1f1/0xa50 fs/inode.c:1906
 __dentry_kill+0x20d/0x630 fs/dcache.c:615
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1060
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1087
 prune_dcache_sb+0x10f/0x180 fs/dcache.c:1168
 super_cache_scan+0x34f/0x4b0 fs/super.c:221
 do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
 shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
 shrink_one+0x43b/0x850 mm/vmscan.c:4795
 shrink_many mm/vmscan.c:4856 [inline]
 lru_gen_shrink_node mm/vmscan.c:4934 [inline]
 shrink_node+0x3799/0x3de0 mm/vmscan.c:5914
 kswapd_shrink_node mm/vmscan.c:6742 [inline]
 balance_pgdat mm/vmscan.c:6934 [inline]
 kswapd+0x1cbc/0x3720 mm/vmscan.c:7203
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

