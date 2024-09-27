Return-Path: <linux-kernel+bounces-341377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 624AA987F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E0E1F24405
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DA8177991;
	Fri, 27 Sep 2024 07:17:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789801D5ADE
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421428; cv=none; b=q1F/E6p+Wr5t3R2wAinH2owvt1XbUDhS4KMNnOvRq5PlrKOJ4zOPUvUhsnxVMnevWh2/LDYcGilclH9AEpz+TYbzqQGf/E4S/tqR8nKj2DuoZPWIHgXmXYKw1sxVCziFV/VLxCdiHMyiSRB+QF6C5XoXGjfh/qeSQdpCmcHEnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421428; c=relaxed/simple;
	bh=/tNrD42wGriZ1ZDsk9S8Acc6m+yFiynqKbzppadSkFE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rYn528uySD7/3cDdTJ6I3m3OV6gTz9eGu0/bczcJPgjk7vqkPJnjFBpiE/H+Kq47I1rPporqzxvjzkwRWi0W0hD2RVrQITwVs5JwPqNTG6O2TP+Dxd4dV6aLiCl36y/f4eqg3BfGpZX7kg00KtPJn/hasNUgNtBBujqQig0oTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1a2af837dso26221005ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727421425; x=1728026225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VlUafZ58VI5RCXr1Aw4EF9SLN9XMPDHQiA0D+OyhxM=;
        b=dhSB4fPOE0REQOuiyPxrQnnxdZDVkdYMX7nyAKDOYsQQH4gLl+XkP8KzRKpRCNrWNJ
         vA7BZp8GQ1DIOOvjC1/2drU8Jnyiut2d15AKi/T+10fm6d/lStxUSChAk/fZcpPNzKNp
         GgKyCwRLUAeqXKz10Fe4F9rAKuMFyJA9bwIzwyF+d6Ql8FoUjawOfrQxlagG0mAEjjHf
         QIchHllPstDEhW3gZSRGuX7dad+1e0L3fUv5Vmw3dL2QJMzQryGOMxUa/W5Jqy8wF8cF
         vlNeN0nd+AnZ437/cYPcvi+y81r4lI86dtqYAbO0jHCW/BfquvwBapzThHrwSli8KLa7
         C08g==
X-Gm-Message-State: AOJu0YwsNtx1O22LzLbX/gHxR1w9Iu7PDCf197ndlfVflErmmvJzOEfc
	kJPwBu5qbpbVKmAl9VEYtIKdrablwfLYcmKwRItkAPBbIWgikT79C8dlysBiAPF5heAbIMKKhLa
	L482QT/euSKzzgbwNd5ms3mITPDwgcVQ1ac+KswiPG8dmaaaNDsaN53Y=
X-Google-Smtp-Source: AGHT+IEV3dnyMKIOomiWztunHhy6pGNM7TiY22plt3pyQnkppLhV+7YI1DynxgUYrmfQOStzDMeceLYHAJZqH1VCg3WMPtFc5nl6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2141:b0:3a2:6402:96b9 with SMTP id
 e9e14a558f8ab-3a344638922mr21343005ab.9.1727421425511; Fri, 27 Sep 2024
 00:17:05 -0700 (PDT)
Date: Fri, 27 Sep 2024 00:17:05 -0700
In-Reply-To: <20240927070001.3435349-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f65bf1.050a0220.46d20.0010.GAE@google.com>
Subject: Re: [syzbot] [squashfs?] possible deadlock in fsnotify_destroy_mark
From: syzbot <syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in fsnotify_destroy_mark

======================================================
WARNING: possible circular locking dependency detected
6.11.0-syzkaller-11558-g075dbe9f6e3c-dirty #0 Not tainted
------------------------------------------------------
kswapd0/80 is trying to acquire lock:
ffff888051323930 (&group->mark_mutex){+.+.}-{3:3}, at: fsnotify_group_lock include/linux/fsnotify_backend.h:270 [inline]
ffff888051323930 (&group->mark_mutex){+.+.}-{3:3}, at: fsnotify_destroy_mark+0x38/0x3c0 fs/notify/mark.c:578

but task is already holding lock:
ffffffff8ea37100 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6844 [inline]
ffffffff8ea37100 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbb4/0x3590 mm/vmscan.c:7226

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       __fs_reclaim_acquire mm/page_alloc.c:3834 [inline]
       fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3848
       might_alloc include/linux/sched/mm.h:327 [inline]
       slab_pre_alloc_hook mm/slub.c:4037 [inline]
       slab_alloc_node mm/slub.c:4115 [inline]
       __kmalloc_cache_noprof+0x3d/0x2c0 mm/slub.c:4291
       kmalloc_noprof include/linux/slab.h:878 [inline]
       kzalloc_noprof include/linux/slab.h:1014 [inline]
       fsnotify_attach_info_to_sb fs/notify/mark.c:626 [inline]
       fsnotify_add_mark_list fs/notify/mark.c:718 [inline]
       fsnotify_add_mark_locked+0x3b2/0xdc0 fs/notify/mark.c:803
       fsnotify_add_inode_mark_locked include/linux/fsnotify_backend.h:814 [inline]
       inotify_new_watch fs/notify/inotify/inotify_user.c:620 [inline]
       inotify_update_watch fs/notify/inotify/inotify_user.c:647 [inline]
       __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:786 [inline]
       __se_sys_inotify_add_watch+0xa83/0x1060 fs/notify/inotify/inotify_user.c:729
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&group->mark_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3158 [inline]
       check_prevs_add kernel/locking/lockdep.c:3277 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       fsnotify_group_lock include/linux/fsnotify_backend.h:270 [inline]
       fsnotify_destroy_mark+0x38/0x3c0 fs/notify/mark.c:578
       fsnotify_destroy_marks+0x14a/0x660 fs/notify/mark.c:934
       fsnotify_inoderemove include/linux/fsnotify.h:264 [inline]
       dentry_unlink_inode+0x2e0/0x430 fs/dcache.c:408
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
       kswapd+0x1bb4/0x3590 mm/vmscan.c:7226
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&group->mark_mutex);
                               lock(fs_reclaim);
  lock(&group->mark_mutex);

 *** DEADLOCK ***

2 locks held by kswapd0/80:
 #0: ffffffff8ea37100 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6844 [inline]
 #0: ffffffff8ea37100 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbb4/0x3590 mm/vmscan.c:7226
 #1: ffff8880003380e0 (&type->s_umount_key#54){.+.+}-{3:3}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff8880003380e0 (&type->s_umount_key#54){.+.+}-{3:3}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196

stack backtrace:
CPU: 0 UID: 0 PID: 80 Comm: kswapd0 Not tainted 6.11.0-syzkaller-11558-g075dbe9f6e3c-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2203
 check_prev_add kernel/locking/lockdep.c:3158 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 fsnotify_group_lock include/linux/fsnotify_backend.h:270 [inline]
 fsnotify_destroy_mark+0x38/0x3c0 fs/notify/mark.c:578
 fsnotify_destroy_marks+0x14a/0x660 fs/notify/mark.c:934
 fsnotify_inoderemove include/linux/fsnotify.h:264 [inline]
 dentry_unlink_inode+0x2e0/0x430 fs/dcache.c:408
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
 kswapd+0x1bb4/0x3590 mm/vmscan.c:7226
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         075dbe9f Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13eaba80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f49dd07427b3bf8
dashboard link: https://syzkaller.appspot.com/bug?extid=c679f13773f295d2da53
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1736bb3b980000


