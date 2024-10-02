Return-Path: <linux-kernel+bounces-346908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6B998CADE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8F91F21E57
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B4B79D0;
	Wed,  2 Oct 2024 01:34:25 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773C063CB
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727832865; cv=none; b=iO1JPA0H3swDTxwSt8awXh8bntTO082rR5BRXLmSgh30iT6lqLKf3aJf3CjEFrhu9Y11frO4ujVgbmC/EfKSEWgz6FBAMsEfJeUb5MzaDFNThKwvt6sFKg5tfpWCEs1cwlSk/PnzeZUYM5zQ4tdtgTfNdxqR8hU6gjJVv2rt43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727832865; c=relaxed/simple;
	bh=h1b3TPOxtsU1rkVURVLVF1xvIQpIhieQiBqgzQ0hMvo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uhHyhHt4CsQH/ciq3PkP+FY17+y1eKXUzDNoowmSonsQ/msqWZZlX6rIzzkoWH2wnCZrmWPxnGsVg0ZeBpI+QdQZIMEuRT4xs0FdN/o2+Zm3o9cv3jRF6Pede5+0ttndZtfYUkx1hVFZ9AN9Qf+apOX44BXX2y+StocxQwE/CVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1a8b992d3so4189325ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 18:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727832862; x=1728437662;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svV0C64KdfapKroNm/F5vMM5FHh3Dyd+/CtcEb1H6XI=;
        b=UuQi1wo4QD/5MpUfd3iAQuh7Ed2OLCThdTmih+8ygtJSGCOQQMGsKJMcIgeRPiy4L4
         pm40T3aP8UKgj/splRxKRLRQs3W+gKIz6LSVeb2UYsQ0/XmxhDtXPexAPnRp79Ur6UM0
         IoKm3ciGAZyI10btIwf++csl3ypwaebZ1JWFDGzgV8u61MTA3sp+GXXhXZcPNOQzU8wL
         tsNbwwA8hllonbAULiz3rVyeLx89t8PqVXxXDNGGAiIL2VVyrto5Rc3C+LkBFXmsEQEX
         tHfIWPh5T9l7t+kVkHCGNAHd0/2i1DN82lyUABr8LERaQ2xsm5W7Gw11RcSF3TVBfJF/
         sZ4A==
X-Forwarded-Encrypted: i=1; AJvYcCWoNqN3nBtkauno5szXyS8axFXjEkxBB8sc0aLlYcD0PFWBdamA31XUfZUcz0yXuTyB5vTQHDPL+iu6h64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0Am2KMLmLc3ja8FmFYUoxvWtDmHcM8YNNx3vUla/LgMCopR1
	QebsC3e3NXGs8xUJWZR1Qie/SL4cBHc5afTRbuO9nPahkPFKlGuX1F4pMN2XG3ZpG/MVmXtF0FZ
	y16ihXlQNYpmkFgV4AYCBI0Zh5BwqLpyAYQEDCR3QVbyY/ofMBlsiE1s=
X-Google-Smtp-Source: AGHT+IFYbZOxogTtpIylgIptOk+VODMqRsNsoUuDu8O2yVYuQsXJJ+FXz5JDeXZlbP/goEXKZSEOTNexIH03qSSU/UzbZmWkAdFj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160e:b0:39f:4e36:4b93 with SMTP id
 e9e14a558f8ab-3a35eb0c614mr38152105ab.6.1727832862589; Tue, 01 Oct 2024
 18:34:22 -0700 (PDT)
Date: Tue, 01 Oct 2024 18:34:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fca31e.050a0220.f28ec.04e4.GAE@google.com>
Subject: [syzbot] [gfs2?] KMSAN: uninit-value in inode_go_dump (5)
From: syzbot <syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ad46e8f95e93 Merge tag 'pm-6.12-rc1-2' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17908d9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85d8f50d88ddf2a
dashboard link: https://syzkaller.appspot.com/bug?extid=aa0730b0a42646eb1359
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10508d9f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103a9e80580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/265feec46ffa/disk-ad46e8f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0f41ea693d3/vmlinux-ad46e8f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/45082d33d192/bzImage-ad46e8f9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fcd037c3d108/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com

gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: fatal: filesystem consistency error - inode = 1 19, function = gfs2_dinode_in, file = fs/gfs2/glops.c, line = 399
gfs2: fsid=syz:syz.0: G:  s:SH n:2/13 f:aqobnN t:SH d:EX/0 a:0 v:0 r:2 m:20 p:1
gfs2: fsid=syz:syz.0:  H: s:SH f:eEcH e:0 p:0 [(none)] init_inodes+0x125/0x510 fs/gfs2/ops_fstype.c:864
=====================================================
BUG: KMSAN: uninit-value in inode_go_dump+0x475/0x4b0 fs/gfs2/glops.c:541
 inode_go_dump+0x475/0x4b0 fs/gfs2/glops.c:541
 gfs2_dump_glock+0x221c/0x2340 fs/gfs2/glock.c:2436
 gfs2_consist_inode_i+0x19f/0x230 fs/gfs2/util.c:457
 gfs2_inode_refresh+0x12d7/0x1590 fs/gfs2/glops.c:482
 inode_go_instantiate+0x6e/0xc0 fs/gfs2/glops.c:501
 gfs2_instantiate+0x272/0x4c0 fs/gfs2/glock.c:468
 gfs2_glock_holder_ready fs/gfs2/glock.c:1345 [inline]
 gfs2_glock_wait+0x2a4/0x3e0 fs/gfs2/glock.c:1365
 gfs2_glock_nq+0x2777/0x34b0 fs/gfs2/glock.c:1622
 gfs2_glock_nq_init fs/gfs2/glock.h:238 [inline]
 init_journal+0x12cc/0x3a40 fs/gfs2/ops_fstype.c:770
 init_inodes+0x125/0x510 fs/gfs2/ops_fstype.c:864
 gfs2_fill_super+0x3a8b/0x45a0 fs/gfs2/ops_fstype.c:1249
 get_tree_bdev+0x684/0x890 fs/super.c:1635
 gfs2_get_tree+0x5c/0x340 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1800
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4032
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4032
 x64_sys_call+0x255a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4756
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof+0x1bf/0x1e0 mm/mempolicy.c:2345
 alloc_slab_page mm/slub.c:2413 [inline]
 allocate_slab+0x33a/0x1250 mm/slub.c:2579
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0x12ef/0x35e0 mm/slub.c:3819
 __slab_alloc mm/slub.c:3909 [inline]
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 kmem_cache_alloc_lru_noprof+0x584/0xb30 mm/slub.c:4154
 gfs2_alloc_inode+0x66/0x210 fs/gfs2/super.c:1536
 alloc_inode+0x86/0x460 fs/inode.c:263
 iget5_locked+0xa9/0x1d0 fs/inode.c:1333
 gfs2_inode_lookup+0xbe/0x1440 fs/gfs2/inode.c:124
 gfs2_lookup_root fs/gfs2/ops_fstype.c:440 [inline]
 init_sb+0xd71/0x1780 fs/gfs2/ops_fstype.c:507
 gfs2_fill_super+0x33f2/0x45a0 fs/gfs2/ops_fstype.c:1216
 get_tree_bdev+0x684/0x890 fs/super.c:1635
 gfs2_get_tree+0x5c/0x340 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1800
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4032
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4032
 x64_sys_call+0x255a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5182 Comm: syz-executor574 Not tainted 6.11.0-syzkaller-11728-gad46e8f95e93 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


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

