Return-Path: <linux-kernel+bounces-341834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 221489886CB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69572B21B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7643186614;
	Fri, 27 Sep 2024 14:15:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCF015B987
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446505; cv=none; b=j2aGJpFzlrBUXIPcYmGeILdXCzccqnxajzx002htmFxGUtrbpu0OBKnzKflJ8YzBYN3EXSlWBcSCjiMjs0u2BuGKUZgwTFJcsgAbLdP63B2leXwMn+cxJAORf1kuJu4m0ED9gOlQ2vWZQKrx8g6xpJt6sTcqvDMcaDm2/gxgEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446505; c=relaxed/simple;
	bh=CIQGt0veWmuCH4US93kWGb8KpY/MtM8019/3Kf6GT9M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Vsfy7I64K95gSVkGxb3mPj1+Fy4vi0A1E/Ej/2n/mS79guG8lzcA9eS8PeD9Rz5AuitxXw2bRPNeFhTdx9SBc1eY4RxOEr6yyZEWgfIThNyoV9h0/7AdmNIoQ4zyMYzYjSscJsCtl9FU84z6+kHLcAYrIvJyvOVMvypSTpSJKZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1a6d8bb03so28540635ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727446503; x=1728051303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4FEr2sGg4s9+uzzm2gSEJ0Vv5KVit8beITpkqSwQPNI=;
        b=OKKBrXiHaQX4LWXM1oFhD05NTj9AzbGHlBQ+x+NiZmEk5thUEGqP1y9CbIAJmNN2KR
         qlFyIlK+IKiwuvhVEecG1VUyysJPJBbl5Ulxd1vKvwoyYXFqZBpcK1DOdzM+xrLYZpv/
         qHBvVt1Z8sNlctcAgtzND6162ou3ruw+tpLnNxD/28ExLXOWy1mLGTX8FdMnWQGkhtPI
         /7/nIbZ6N/BhkFSOpJEmNWeTSA6JsFFno9pgJiha8Ju03a5zDgpCTRVN88+RPW7ESHUS
         ARiHfu854YA16mIL7oPZCOucGBOW5EtbZTZocwyBBet9/sunSwd+4eIlEJX8H7wRW5UN
         dhOQ==
X-Gm-Message-State: AOJu0Yw53/uRX1V3cuF0wJAvaQKJSqFRqaTkebAqPH0WmVLhJ8jgLYz9
	U31RUgU4XsaHx1emF2J30ZxVOqKw0US0D1YLsBzImOXzm+xIbfag5vqTMtFyY+hcs9MRh0e8V1x
	jFrLyla1CxNFqvVpG5FM9w1Y467xBILxVQFIZz5dSEZj0k09cd9x6LMc=
X-Google-Smtp-Source: AGHT+IE6Ar7yDjGa0NdvCJ5C6q1JpGQIBWKb0bqtttrBDnNr/cM0p2i1OZykcdRM3Zwj0+fKLmmm1Bk9KFTZiz/kEje5chyN+Sts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c27:b0:3a0:9fa5:8f1 with SMTP id
 e9e14a558f8ab-3a3452c29a7mr30417345ab.24.1727446503001; Fri, 27 Sep 2024
 07:15:03 -0700 (PDT)
Date: Fri, 27 Sep 2024 07:15:02 -0700
In-Reply-To: <20240927140018.2164259-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6bde6.050a0220.38ace9.0017.GAE@google.com>
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
kswapd0/79 is trying to acquire lock:
ffff88804acb05d8 (&type->lock_class){+.+.}-{3:3}, at: keyring_clear+0xb2/0x350 security/keys/keyring.c:1655

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
       assoc_array_clear+0x78/0x1a0 lib/assoc_array.c:1284
       keyring_clear+0xc5/0x350 security/keys/keyring.c:1657
       fscrypt_put_master_key+0xc8/0x190 fs/crypto/keyring.c:79
       fscrypt_initiate_key_removal fs/crypto/keyring.c:137 [inline]
       fscrypt_destroy_keyring+0x1a7/0x2d0 fs/crypto/keyring.c:259
       generic_shutdown_super+0x14a/0x2d0 fs/super.c:648
       kill_block_super+0x44/0x90 fs/super.c:1696
       ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7320
       deactivate_locked_super+0xc4/0x130 fs/super.c:473
       cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
       task_work_run+0x24f/0x310 kernel/task_work.c:228
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
       do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
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

2 locks held by kswapd0/79:
 #0: ffffffff8ea37100 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6844 [inline]
 #0: ffffffff8ea37100 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x3700 mm/vmscan.c:7226
 #1: ffff8880007640e0 (&type->s_umount_key#32){++++}-{3:3}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff8880007640e0 (&type->s_umount_key#32){++++}-{3:3}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196

stack backtrace:
CPU: 0 UID: 0 PID: 79 Comm: kswapd0 Not tainted 6.11.0-syzkaller-11558-g075dbe9f6e3c-dirty #0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=164306a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6cf7b6189844756
dashboard link: https://syzkaller.appspot.com/bug?extid=1b2d1134e0b675176a15
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a4959f980000


