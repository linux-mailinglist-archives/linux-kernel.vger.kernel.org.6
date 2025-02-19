Return-Path: <linux-kernel+bounces-521510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99181A3BE44
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6773F163B31
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FB51DED62;
	Wed, 19 Feb 2025 12:37:21 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5C28629B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968641; cv=none; b=O3upN9Gqh21OzRJwUNMq1sYQf7WRfvRR04cnkb7bNy0GsCx/alDPSsBiW/s6epwZf1L4z1dllMP2y7RigbT41j2WopbWA1qI5CH8dXqlsVCwerKgSvMI7d0HKBTVTuP1s2RNXpKjLutPNRdThcK25GJP6WxdAHl5RDxUts+Y5l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968641; c=relaxed/simple;
	bh=fr+FGwweffdvMwX96xjd42EBVdf6OIH88lgJo1Nuat0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C+xfbk28bIag/BADKWpDqcmPvhtuFxX8KzICt3xOOq/zTxbZvXImC75/ZUjBpx7YG2ev2QT63d1ZcOd168kA/n7jQ12zUb0yUPlzyEeOaHDNizVy7QnrRdTC37KZN0UL7JCiodfPM2Y/kvgaZu2ebJHYlqv9CZXaKxK8sLN43QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-8559d67a0daso479872239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968639; x=1740573439;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CV8UhaeaHQzGOcLoJQO51E4uQ6mLpnmwrYcZ81MLIQg=;
        b=bn/BCOL/b5eIcbcE/bcgihG+u9gkJuK/RdDH9/k5fr7lGtliWJ75EMpEhoBbUzmAiu
         muhRSPOBUgXziRCrqoiurZS/mzRtQ4mryHmov/M3DUBzYh0c6DmAmpfbDEQmLdBJOBTv
         mufBlIv68ziCI+0aaLmVADkssvvY73qb/1CHWvYbV62enCbF97kJd0flUY+WDavmBK2/
         geft81OMk5TljVUZdtlKrEaILBBY5BnwbFjjk94HDDGm8XuvNacztZsvshh7CEtwpcta
         8z5932Y2kQ/srsEN+5JORwBPTJ7dm7eNtVnv99E4phx12hCqbkHRTt+br9jXRdb+TpS8
         abvg==
X-Forwarded-Encrypted: i=1; AJvYcCXG5xPQ2rbqVBi51ZH2v5o6JzQ0jm+Q5zK39jOaXoli8YbHTVZxOuRVJFE8CF0RdFM9RRIvIK7ZVfvi+UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz31ZBzeN6XDzfkQhNJggb4RLFBxhWoWYy22KXlCE489XMKrY2C
	PQiTEx67iRIfeuhHKg8/t4RzncgovYpao5iBdMf9gQDppQEzE6+p6klIszloR+fbfJ2lt/df7KZ
	SRFZN4+SGQ4brxHr0Q2bo5UEAiT1YSfopAFUEa2JPI+cK8+kfA047SLM=
X-Google-Smtp-Source: AGHT+IGldWd8pvHkwlYNMlExcruiWqubcvG79XG//cybN0VmTtnfRuAD5iUVgnHZOQ1R6Jh33IoTdawSI3G9JZC1GBNlEG5qU1Sl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0c:0:b0:3d0:618c:1b22 with SMTP id
 e9e14a558f8ab-3d28088673emr146166245ab.11.1739968638545; Wed, 19 Feb 2025
 04:37:18 -0800 (PST)
Date: Wed, 19 Feb 2025 04:37:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b5d07e.050a0220.14d86d.00e6.GAE@google.com>
Subject: [syzbot] [jfs?] KMSAN: uninit-value in diFree
From: syzbot <syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6537cfb395f3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=103bc7f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cf1217edc1cc7da
dashboard link: https://syzkaller.appspot.com/bug?extid=df6cdcb35904203d2b6d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131d2fdf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16321498580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b4a6e38bb6d/disk-6537cfb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/96b70942c42c/vmlinux-6537cfb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd3dc281a360/bzImage-6537cfb3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f4c577f978b2/mount_1.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14d09ae4580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com

ERROR: (device loop0): diUpdatePMap: the iag is outside the map
ERROR: (device loop0): remounting filesystem as read-only
=====================================================
BUG: KMSAN: uninit-value in hex_dump_to_buffer+0x888/0x1100 lib/hexdump.c:171
 hex_dump_to_buffer+0x888/0x1100 lib/hexdump.c:171
 print_hex_dump+0x13d/0x3e0 lib/hexdump.c:276
 diFree+0x5ba/0x4350 fs/jfs/jfs_imap.c:876
 jfs_evict_inode+0x510/0x550 fs/jfs/inode.c:156
 evict+0x723/0xd10 fs/inode.c:796
 iput_final fs/inode.c:1946 [inline]
 iput+0x97b/0xdb0 fs/inode.c:1972
 txUpdateMap+0xf3e/0x1150 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x627/0x11d0 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4121 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 __kmalloc_cache_noprof+0x8e3/0xdf0 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 diMount+0x61/0x7f0 fs/jfs/jfs_imap.c:105
 jfs_mount+0xa8e/0x11d0 fs/jfs/jfs_mount.c:176
 jfs_fill_super+0xa47/0x17c0 fs/jfs/super.c:523
 get_tree_bdev_flags+0x6ec/0x910 fs/super.c:1636
 get_tree_bdev+0x37/0x50 fs/super.c:1659
 jfs_get_tree+0x34/0x40 fs/jfs/super.c:635
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3560
 path_mount+0x742/0x1f10 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x71f/0x800 fs/namespace.c:4088
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4088
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 113 Comm: jfsCommit Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
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

