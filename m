Return-Path: <linux-kernel+bounces-291270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA3B956022
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB8F281F3F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B558115539A;
	Sun, 18 Aug 2024 23:22:24 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB6913210D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724023343; cv=none; b=HxwwcWMUinrzKLe2Vk5BEh4qBiF4VnJ/bzKaXogJ54TbsKAan+OwGBU2Ut8NX2HDRZKGu93OpPxzPJFZkr+fB9/1WQFg+IE+BUXFnbPfpgRjWNhlIEBejnUigcSHn0dpal4lCgtYMyLlO4qOlN/U0kZ2PE41g9RodCu8GAUnDNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724023343; c=relaxed/simple;
	bh=BH2BMr4GHTwNAt3MET8S0hR8r4nrj5DypS0AqXAJ0js=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EXYGSmZEAuXxEOBefIjj0bFZNEvy8P9QWP4t8Q331Cb3f5NpT23x4T1rvosFeAvnqLGmbUrQtPWpe8+hci4XO+/srNJ/EGnEqVIM/ja8rpozyMHIYOPLRwrNDczUAlF+d8VMJlbw8DNVLb8P3oR1PU7GdtZertGdQwTszJ6RFsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-824cad19812so366242439f.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 16:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724023341; x=1724628141;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFETBmQxO3AboMC0uEMbJaW2odUMVjwePpXJQCbblJ4=;
        b=hrU0n6lO8VikmvscbrA70xshM87SKK5/j9EdlwSArZTiAC06emneEvNqDb2luMvjOm
         n7n5BWwUpykP8JtqIXrlq26L5l1J4Li0ebQcKJyuuL5xF4cuHPfnm5U/kXzsJ40oPGE9
         XEo/jR2p4aKaa5PCoNFlaNNDI1NK8hxK9Kxb/z4Pm2ypEAvn3ta7zpwwc1vR7R5iSOrd
         RBIRn7//AfAF/i350D6efGYCdNOSorT1bQpUF/wcIYdM1StEwiI3PrN9EvMSokQE0+K+
         H8PPvO+vXrYcUa2V5Z8N6+l2z0bUm1V5tDgn9uUnuXsPLO6jI2eLIXmqnXuxumAKQTPh
         9sLw==
X-Forwarded-Encrypted: i=1; AJvYcCWCuSK1O9JoeZlBdM4UR0nqgw/f0A44aLiMmPYquLG0ZWIgKiWLEkAZunls3mPUJi3UbFqSeH8nV1IeAeZ3HcT39mD2rZPYdLwYDMtF
X-Gm-Message-State: AOJu0YzPAn1kLwgqgL0g8D7QRI5IIz5EFEj51Zqv8cSozJiIa6yDAtNN
	bjX2QcetVlOfSdy/t2qGjR0LOHIF0b8NjWLIxslaBoY1OvNwoEPpuZdzI9BSUZM4D+FV2H2o43Q
	drC3VF+1pD8H1qslmQebB1L4aX9C8USC0LVwokBumzZ+Lskn5UBqsYg4=
X-Google-Smtp-Source: AGHT+IGxEP1urpslxP2JwDwSUMDLDWicgTGmKzsmu9Pq39vz2ZwyPyWLwuA0ErVTSEoGSJGVJn8d2wmFaQixQ9AD2vaZBUSy30Xn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cc3:b0:81f:904a:51b1 with SMTP id
 ca18e2360f4ac-8250f4bf8acmr10368039f.1.1724023341305; Sun, 18 Aug 2024
 16:22:21 -0700 (PDT)
Date: Sun, 18 Aug 2024 16:22:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7e279061ffd7610@google.com>
Subject: [syzbot] [ocfs2?] possible deadlock in ocfs2_evict_inode
From: syzbot <syzbot+b225d4dfce6219600c42@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7a5aa4b3c00 Merge tag 'perf-tools-fixes-for-v6.11-2024-08..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10490ad5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=b225d4dfce6219600c42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d7a5aa4b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af15738cca6c/vmlinux-d7a5aa4b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62dacb1384ee/bzImage-d7a5aa4b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b225d4dfce6219600c42@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc3-syzkaller-00156-gd7a5aa4b3c00 #0 Not tainted
------------------------------------------------------
kswapd0/78 is trying to acquire lock:
ffff888011f589c0 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#2){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
ffff888011f589c0 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#2){+.+.}-{3:3}, at: ocfs2_remove_inode fs/ocfs2/inode.c:655 [inline]
ffff888011f589c0 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#2){+.+.}-{3:3}, at: ocfs2_wipe_inode fs/ocfs2/inode.c:818 [inline]
ffff888011f589c0 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#2){+.+.}-{3:3}, at: ocfs2_delete_inode fs/ocfs2/inode.c:1079 [inline]
ffff888011f589c0 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#2){+.+.}-{3:3}, at: ocfs2_evict_inode+0x209f/0x4680 fs/ocfs2/inode.c:1216

but task is already holding lock:
ffff88803a3f5f40 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
ffff88803a3f5f40 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]){+.+.}-{3:3}, at: ocfs2_wipe_inode fs/ocfs2/inode.c:776 [inline]
ffff88803a3f5f40 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]){+.+.}-{3:3}, at: ocfs2_delete_inode fs/ocfs2/inode.c:1079 [inline]
ffff88803a3f5f40 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]){+.+.}-{3:3}, at: ocfs2_evict_inode+0x1b17/0x4680 fs/ocfs2/inode.c:1216

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:799 [inline]
       ocfs2_wipe_inode fs/ocfs2/inode.c:776 [inline]
       ocfs2_delete_inode fs/ocfs2/inode.c:1079 [inline]
       ocfs2_evict_inode+0x1b17/0x4680 fs/ocfs2/inode.c:1216
       evict+0x532/0x950 fs/inode.c:704
       ocfs2_dentry_iput+0x232/0x380 fs/ocfs2/dcache.c:411
       __dentry_kill+0x20d/0x630 fs/dcache.c:610
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1055
       shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1082
       prune_dcache_sb+0x10f/0x180 fs/dcache.c:1163
       super_cache_scan+0x34f/0x4b0 fs/super.c:221
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
       shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
       shrink_one+0x43b/0x850 mm/vmscan.c:4815
       shrink_many mm/vmscan.c:4876 [inline]
       lru_gen_shrink_node mm/vmscan.c:4954 [inline]
       shrink_node+0x3799/0x3de0 mm/vmscan.c:5934
       kswapd_shrink_node mm/vmscan.c:6762 [inline]
       balance_pgdat mm/vmscan.c:6954 [inline]
       kswapd+0x1bcd/0x35a0 mm/vmscan.c:7223
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (&osb->nfs_sync_rwlock){.+.+}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       ocfs2_nfs_sync_lock+0x109/0x260 fs/ocfs2/dlmglue.c:2876
       ocfs2_delete_inode fs/ocfs2/inode.c:1030 [inline]
       ocfs2_evict_inode+0x3e5/0x4680 fs/ocfs2/inode.c:1216
       evict+0x532/0x950 fs/inode.c:704
       ocfs2_dentry_iput+0x232/0x380 fs/ocfs2/dcache.c:411
       __dentry_kill+0x20d/0x630 fs/dcache.c:610
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1055
       shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1082
       prune_dcache_sb+0x10f/0x180 fs/dcache.c:1163
       super_cache_scan+0x34f/0x4b0 fs/super.c:221
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
       shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
       shrink_one+0x43b/0x850 mm/vmscan.c:4815
       shrink_many mm/vmscan.c:4876 [inline]
       lru_gen_shrink_node mm/vmscan.c:4954 [inline]
       shrink_node+0x3799/0x3de0 mm/vmscan.c:5934
       kswapd_shrink_node mm/vmscan.c:6762 [inline]
       balance_pgdat mm/vmscan.c:6954 [inline]
       kswapd+0x1bcd/0x35a0 mm/vmscan.c:7223
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __fs_reclaim_acquire mm/page_alloc.c:3823 [inline]
       fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3837
       might_alloc include/linux/sched/mm.h:334 [inline]
       slab_pre_alloc_hook mm/slub.c:3939 [inline]
       slab_alloc_node mm/slub.c:4017 [inline]
       __kmalloc_cache_noprof+0x3d/0x2c0 mm/slub.c:4184
       kmalloc_noprof include/linux/slab.h:681 [inline]
       kzalloc_noprof include/linux/slab.h:807 [inline]
       ocfs2_reserve_new_metadata_blocks+0x117/0x9c0 fs/ocfs2/suballoc.c:966
       ocfs2_mknod+0x143a/0x2b40 fs/ocfs2/namei.c:345
       ocfs2_mkdir+0x1ab/0x480 fs/ocfs2/namei.c:655
       vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4210
       do_mkdirat+0x264/0x3a0 fs/namei.c:4233
       __do_sys_mkdirat fs/namei.c:4248 [inline]
       __se_sys_mkdirat fs/namei.c:4246 [inline]
       __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4246
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#2){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:799 [inline]
       ocfs2_remove_inode fs/ocfs2/inode.c:655 [inline]
       ocfs2_wipe_inode fs/ocfs2/inode.c:818 [inline]
       ocfs2_delete_inode fs/ocfs2/inode.c:1079 [inline]
       ocfs2_evict_inode+0x209f/0x4680 fs/ocfs2/inode.c:1216
       evict+0x532/0x950 fs/inode.c:704
       ocfs2_dentry_iput+0x232/0x380 fs/ocfs2/dcache.c:411
       __dentry_kill+0x20d/0x630 fs/dcache.c:610
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1055
       shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1082
       prune_dcache_sb+0x10f/0x180 fs/dcache.c:1163
       super_cache_scan+0x34f/0x4b0 fs/super.c:221
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
       shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
       shrink_one+0x43b/0x850 mm/vmscan.c:4815
       shrink_many mm/vmscan.c:4876 [inline]
       lru_gen_shrink_node mm/vmscan.c:4954 [inline]
       shrink_node+0x3799/0x3de0 mm/vmscan.c:5934
       kswapd_shrink_node mm/vmscan.c:6762 [inline]
       balance_pgdat mm/vmscan.c:6954 [inline]
       kswapd+0x1bcd/0x35a0 mm/vmscan.c:7223
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &ocfs2_sysfile_lock_key[args->fi_sysfile_type]#2 --> &osb->nfs_sync_rwlock --> &ocfs2_sysfile_lock_key[args->fi_sysfile_type]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ocfs2_sysfile_lock_key[args->fi_sysfile_type]);
                               lock(&osb->nfs_sync_rwlock);
                               lock(&ocfs2_sysfile_lock_key[args->fi_sysfile_type]);
  lock(&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#2);

 *** DEADLOCK ***

4 locks held by kswapd0/78:
 #0: ffffffff8ea2fce0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6841 [inline]
 #0: ffffffff8ea2fce0 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbb4/0x35a0 mm/vmscan.c:7223
 #1: ffff8880460f20e0 (&type->s_umount_key#47){.+.+}-{3:3}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff8880460f20e0 (&type->s_umount_key#47){.+.+}-{3:3}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196
 #2: ffff88803b050bd0 (&osb->nfs_sync_rwlock){.+.+}-{3:3}, at: ocfs2_nfs_sync_lock+0x109/0x260 fs/ocfs2/dlmglue.c:2876
 #3: ffff88803a3f5f40 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #3: ffff88803a3f5f40 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]){+.+.}-{3:3}, at: ocfs2_wipe_inode fs/ocfs2/inode.c:776 [inline]
 #3: ffff88803a3f5f40 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]){+.+.}-{3:3}, at: ocfs2_delete_inode fs/ocfs2/inode.c:1079 [inline]
 #3: ffff88803a3f5f40 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]){+.+.}-{3:3}, at: ocfs2_evict_inode+0x1b17/0x4680 fs/ocfs2/inode.c:1216

stack backtrace:
CPU: 0 UID: 0 PID: 78 Comm: kswapd0 Not tainted 6.11.0-rc3-syzkaller-00156-gd7a5aa4b3c00 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 down_write+0x99/0x220 kernel/locking/rwsem.c:1579
 inode_lock include/linux/fs.h:799 [inline]
 ocfs2_remove_inode fs/ocfs2/inode.c:655 [inline]
 ocfs2_wipe_inode fs/ocfs2/inode.c:818 [inline]
 ocfs2_delete_inode fs/ocfs2/inode.c:1079 [inline]
 ocfs2_evict_inode+0x209f/0x4680 fs/ocfs2/inode.c:1216
 evict+0x532/0x950 fs/inode.c:704
 ocfs2_dentry_iput+0x232/0x380 fs/ocfs2/dcache.c:411
 __dentry_kill+0x20d/0x630 fs/dcache.c:610
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1055
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1082
 prune_dcache_sb+0x10f/0x180 fs/dcache.c:1163
 super_cache_scan+0x34f/0x4b0 fs/super.c:221
 do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
 shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
 shrink_one+0x43b/0x850 mm/vmscan.c:4815
 shrink_many mm/vmscan.c:4876 [inline]
 lru_gen_shrink_node mm/vmscan.c:4954 [inline]
 shrink_node+0x3799/0x3de0 mm/vmscan.c:5934
 kswapd_shrink_node mm/vmscan.c:6762 [inline]
 balance_pgdat mm/vmscan.c:6954 [inline]
 kswapd+0x1bcd/0x35a0 mm/vmscan.c:7223
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

