Return-Path: <linux-kernel+bounces-341545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B2998817A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AAC280FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21711BAEC0;
	Fri, 27 Sep 2024 09:42:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EAD16B75C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430126; cv=none; b=riw3OQBo2ktu0PSqcL7tt+QbTG+0QGvKDkpsdpHdzxlaivgd0L3Or+Ix4ZOcOrHzUb6mcgpcnPndfWWoPJM0z08rKcYH959X7bbQfWXpDLFFvsjrMeAfHgM9Xoum19yzicTTMnz8zINnGgp4Y4TQe6UxnTgzfF6TahvseZ1Rm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430126; c=relaxed/simple;
	bh=ExE4sdAOaSHy4Ky7Pd3vZbMQ1jh+h1Zk5ViszV59/uQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Uwj39pFfcziSWjebi2kl63LQq+w80jnROgxD4bixMBdn6DArykmAMPW/JGT3UTMe8AQcY2vWcaK3VJdit1YFMt/PPOC5KN3YJUyNst/g/VEBgNhFP9epg4zCba+WYwrqG+/9YMLu59SbWsYz1z7FTXLx21NbrE/HFt2Nlb0jfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1a2af837dso26956885ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727430124; x=1728034924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl6dhnPMSgzIsMUN8oLnDOXDXKAHcQSlvS8jSp5ywzE=;
        b=A3CUoZ10c9DkyPz5WtWWussINh9miK/oLAJu8926GHVFGMGw3evUK1u07lMaZbevyP
         WNOHkbCaAp5gPyiE8hK6G9Gj+zeN/u2YlrcN0efUJYSzAEngXoDmi3F1dZnbqL4Zuvk9
         IyzF8ck156YZILJ0KO43kJ2Xl1fy98hErQBymdllHgCUc+wbQVlhn8xEEeSJVC1QJT+j
         BrCQwOw+efmgVPLtt2qxNvbvdYInNqnbhgsrNIfVR0kgMJ/iRI3Rjtb+ftJEURwJ8uuX
         TYd09U3MGWsGaYsnq1ZHte1j8pTYKnMRzUHIrCk+kUwHT1cGzwfO/4KbtFMTfzGK4oMo
         tlbQ==
X-Gm-Message-State: AOJu0YwnqgKN8lbgcEacEkFRALmRRB8IIKUyjqIJfWdSJe9Q7O8u3R+k
	CS/espiiYX4zhOAWdH4u/+hYmeytB833h0qKZtmPdihQh/YW+yuAshNPqov4qwK2TetE1Mre4AZ
	Kcpv1mchVsqqlJpis1AzJr8Kgi7cc/v4QaTloXzhFSlwPF2h5RbL8KlA=
X-Google-Smtp-Source: AGHT+IEKoYWJwxqJusHVyEtQykQZQ8RmwSd47Dc9C7J6zkmOhA9vNj1T0Q+khvAODqmaRVlu/ILtEThGA4m4rwfv4SMJu1+PX1ls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1945:b0:39f:507a:6170 with SMTP id
 e9e14a558f8ab-3a344638a4amr22219415ab.8.1727430123925; Fri, 27 Sep 2024
 02:42:03 -0700 (PDT)
Date: Fri, 27 Sep 2024 02:42:03 -0700
In-Reply-To: <20240927092714.465114-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f67deb.050a0220.46d20.0015.GAE@google.com>
Subject: Re: [syzbot] [keyrings?] [lsm?] [ext4?] possible deadlock in
 keyring_clear (2)
From: syzbot <syzbot+1b2d1134e0b675176a15@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in keyring_clear

======================================================
WARNING: possible circular locking dependency detected
6.11.0-syzkaller-11558-g075dbe9f6e3c-dirty #0 Not tainted
------------------------------------------------------
kswapd0/73 is trying to acquire lock:
ffff88803d6355d8 (&type->lock_class){+.+.}-{3:3}, at: keyring_clear+0xb2/0x350 security/keys/keyring.c:1655

but task is already holding lock:
ffffffff8ea37100 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6844 [inline]
ffffffff8ea37100 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x3700 mm/vmscan.c:7226

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
       assoc_array_insert+0xfe/0x33e0 lib/assoc_array.c:980
       __key_link_begin+0xe5/0x1f0 security/keys/keyring.c:1314
       key_instantiate_and_link+0x2a0/0x510 security/keys/key.c:525
       add_master_key_user+0x222/0x2e0 fs/crypto/keyring.c:400
       add_new_master_key+0x2f8/0x5d0 fs/crypto/keyring.c:451
       do_add_master_key fs/crypto/keyring.c:529 [inline]
       add_master_key+0x419/0x970 fs/crypto/keyring.c:579
       fscrypt_ioctl_add_key+0x3e9/0x590 fs/crypto/keyring.c:752
       __ext4_ioctl fs/ext4/ioctl.c:1537 [inline]
       ext4_ioctl+0x18b1/0x5590 fs/ext4/ioctl.c:1626
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&type->lock_class){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3158 [inline]
       check_prevs_add kernel/locking/lockdep.c:3277 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       keyring_clear+0xb2/0x350 security/keys/keyring.c:1655
       fscrypt_put_master_key+0xc8/0x190 fs/crypto/keyring.c:79
       put_crypt_info+0x275/0x320 fs/crypto/keysetup.c:548
       fscrypt_put_encryption_info+0x40/0x60 fs/crypto/keysetup.c:753
       ext4_clear_inode+0x15b/0x1c0 fs/ext4/super.c:1525
       ext4_evict_inode+0xabc/0xf50 fs/ext4/inode.c:323
       evict+0x4e8/0x9b0 fs/inode.c:723
       __dentry_kill+0x20d/0x630 fs/dcache.c:615
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1060
       shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1087
       prune_dcache_sb+0x10f/0x180 fs/dcache.c:1168
       super_cache_scan+0x34f/0x4b0 fs/super.c:221
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0x878/0x14d0 mm/shrinker.c:626
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

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&type->lock_class);
                               lock(fs_reclaim);
  lock(&type->lock_class);

 *** DEADLOCK ***

2 locks held by kswapd0/73:
 #0: ffffffff8ea37100 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6844 [inline]
 #0: ffffffff8ea37100 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x3700 mm/vmscan.c:7226
 #1: ffff888039c6c0e0 (&type->s_umount_key#32){++++}-{3:3}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff888039c6c0e0 (&type->s_umount_key#32){++++}-{3:3}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196

stack backtrace:
CPU: 0 UID: 0 PID: 73 Comm: kswapd0 Not tainted 6.11.0-syzkaller-11558-g075dbe9f6e3c-dirty #0
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
 down_write+0x99/0x220 kernel/locking/rwsem.c:1579
 keyring_clear+0xb2/0x350 security/keys/keyring.c:1655
 fscrypt_put_master_key+0xc8/0x190 fs/crypto/keyring.c:79
 put_crypt_info+0x275/0x320 fs/crypto/keysetup.c:548
 fscrypt_put_encryption_info+0x40/0x60 fs/crypto/keysetup.c:753
 ext4_clear_inode+0x15b/0x1c0 fs/ext4/super.c:1525
 ext4_evict_inode+0xabc/0xf50 fs/ext4/inode.c:323
 evict+0x4e8/0x9b0 fs/inode.c:723
 __dentry_kill+0x20d/0x630 fs/dcache.c:615
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1060
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1087
 prune_dcache_sb+0x10f/0x180 fs/dcache.c:1168
 super_cache_scan+0x34f/0x4b0 fs/super.c:221
 do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0x878/0x14d0 mm/shrinker.c:626
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
 </TASK>


Tested on:

commit:         075dbe9f Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b4c507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6cf7b6189844756
dashboard link: https://syzkaller.appspot.com/bug?extid=1b2d1134e0b675176a15
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1545159f980000


