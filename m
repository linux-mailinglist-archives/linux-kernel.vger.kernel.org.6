Return-Path: <linux-kernel+bounces-421734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6019D8F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B9916A85E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23D612F5A5;
	Tue, 26 Nov 2024 00:00:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ACCB652
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579229; cv=none; b=W+5SoElOW6HiEmucE9XCPisky8d3FUYyBSs6ks7NV8S177GPmh+19I3H/uvbsEBTYscxkZf3GQuoJhacxFz9Trd3/w2pmBtLaLF769H2k7lozIMKvXi6Wt/NJkfIyd/fgB0DXn6p1iZLTQrRWFlynfGBG7ZKsBC9JwjU6/lGaOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579229; c=relaxed/simple;
	bh=DrDj1QnSaXb9gP/ddPpMjwe9GWEB9Z5CV4wUQVaggsc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CNwC4DlyC3TZBJ5t/PU38tIznK2oBmE7R+w7gD8iSjEjDJDp0sT7VbbnN9Nx58iNY7c01fJnyM9joSXN5hwIsunmsIJ5dSuY3SEEq3w/fdDALLl/ae/kX6cRaYdXKx+1xJUCHYJ07qnYnyvEatPH3sSLKW7t+DySik8AWM5xBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7807feadfso50320315ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732579226; x=1733184026;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUtWS5qjzF/HtNV8zGu1x5TqkoyxEFzPV4ZzyOZxIF0=;
        b=Jdkbji1u1hWV4nsvPt5axSN7eH1F/JT8ap01VdMeVlHYMCxeTHH9RDtT5GeD+C5SJR
         6cZpLPELB2l5ujo5iHaZBOgFZ/5V3hEDs5r5+sa4/SHGt8sE/1RKGc2QjHjei/YJcCb4
         SvVUX043Tq9EIx6SQojOhbHulwyIADmZQJJxpj3wuFUWBh7ZxokxWwzDGKwxAGWamWi5
         6HZetESgRajCt4qVOquz2AkSFPeeyNoyu34nyZcz9edjTPQQ1HSsBPd4uQOdbeO6mK/L
         RISJkae6azwudP7AvvDM8E+xl+oBRU8du4rrbU8YStYW3DSJsL1EPzRV7ehKqyFv2ZmL
         GzAA==
X-Forwarded-Encrypted: i=1; AJvYcCVY314Hta+exqqBPdqM7bb1ylT0uOja4R9Kq4GHk4nwVUaN/qn9ioep0PeYzgFqd7txGsCrHdQUUygUcgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9J9n441vjkW1hTHd4lp9QrXT7q2Yjp/W/Y4yPe8tc11oMrtOC
	Z9uwOBQ8PAh0rWW6K4biCOiRtwiAfjrG03IJPEEv2+GP7CPjuihrB4RL4HbgrE/Rl7tJCzhxM2d
	hJXI2OnWkChOPS3mFqwXQ8Crqws4q4+wb8DseOprlQ3LWXFk4f1PKOe4=
X-Google-Smtp-Source: AGHT+IHO24vWuGFU2CS94uRrLsz4ctDQI2CFfReVD+W/pef2JKJZ4T3zRuXmo737AJc1/wGbLLyZ6zlQeTAm31SHMCKrr5n2zmwE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a62:b0:3a7:6f1c:a084 with SMTP id
 e9e14a558f8ab-3a79afec520mr177867135ab.23.1732579226543; Mon, 25 Nov 2024
 16:00:26 -0800 (PST)
Date: Mon, 25 Nov 2024 16:00:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67450f9a.050a0220.21d33d.0002.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_trans_start_alloc_update
From: syzbot <syzbot+f02ee424846cc4e04e04@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124736e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef9abe59471e0aee
dashboard link: https://syzkaller.appspot.com/bug?extid=f02ee424846cc4e04e04
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164736e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12347b78580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/25d599464308/disk-06afb0f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0846a79f5c2a/vmlinux-06afb0f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a69b15a49da1/bzImage-06afb0f3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/da403496381c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f02ee424846cc4e04e04@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bch2_alloc_to_v4_mut_inlined fs/bcachefs/alloc_background.c:447 [inline]
BUG: KMSAN: uninit-value in bch2_trans_start_alloc_update_noupdate fs/bcachefs/alloc_background.c:472 [inline]
BUG: KMSAN: uninit-value in bch2_trans_start_alloc_update+0x674/0x14b0 fs/bcachefs/alloc_background.c:487
 bch2_alloc_to_v4_mut_inlined fs/bcachefs/alloc_background.c:447 [inline]
 bch2_trans_start_alloc_update_noupdate fs/bcachefs/alloc_background.c:472 [inline]
 bch2_trans_start_alloc_update+0x674/0x14b0 fs/bcachefs/alloc_background.c:487
 bch2_trigger_pointer fs/bcachefs/buckets.c:588 [inline]
 __trigger_extent+0x2425/0x6810 fs/bcachefs/buckets.c:740
 bch2_trigger_extent+0x90e/0x11a0 fs/bcachefs/buckets.c:869
 bch2_key_trigger fs/bcachefs/bkey_methods.h:87 [inline]
 bch2_key_trigger_old fs/bcachefs/bkey_methods.h:101 [inline]
 btree_update_nodes_written_trans fs/bcachefs/btree_update_interior.c:651 [inline]
 btree_update_nodes_written fs/bcachefs/btree_update_interior.c:723 [inline]
 btree_interior_update_work+0x1661/0x4870 fs/bcachefs/btree_update_interior.c:861
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_u64s_small fs/bcachefs/util.h:393 [inline]
 bkey_reassemble fs/bcachefs/bkey.h:513 [inline]
 btree_key_cache_create fs/bcachefs/btree_key_cache.c:259 [inline]
 btree_key_cache_fill+0x13da/0x3d60 fs/bcachefs/btree_key_cache.c:309
 bch2_btree_path_traverse_cached+0x988/0xe20 fs/bcachefs/btree_key_cache.c:361
 bch2_btree_path_traverse_one+0x749/0x47b0 fs/bcachefs/btree_iter.c:1159
 bch2_btree_path_traverse fs/bcachefs/btree_iter.h:247 [inline]
 bch2_btree_iter_peek_slot+0x10b7/0x3950 fs/bcachefs/btree_iter.c:2629
 __bch2_bkey_get_iter fs/bcachefs/btree_iter.h:575 [inline]
 bch2_bkey_get_iter fs/bcachefs/btree_iter.h:589 [inline]
 bch2_trans_start_alloc_update_noupdate fs/bcachefs/alloc_background.c:464 [inline]
 bch2_trans_start_alloc_update+0x3d8/0x14b0 fs/bcachefs/alloc_background.c:487
 bch2_trigger_pointer fs/bcachefs/buckets.c:588 [inline]
 __trigger_extent+0x2425/0x6810 fs/bcachefs/buckets.c:740
 bch2_trigger_extent+0x90e/0x11a0 fs/bcachefs/buckets.c:869
 bch2_key_trigger fs/bcachefs/bkey_methods.h:87 [inline]
 bch2_key_trigger_old fs/bcachefs/bkey_methods.h:101 [inline]
 btree_update_nodes_written_trans fs/bcachefs/btree_update_interior.c:651 [inline]
 btree_update_nodes_written fs/bcachefs/btree_update_interior.c:723 [inline]
 btree_interior_update_work+0x1661/0x4870 fs/bcachefs/btree_update_interior.c:861
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 ___kmalloc_large_node+0x22c/0x370 mm/slub.c:4219
 __kmalloc_large_node_noprof+0x3f/0x1e0 mm/slub.c:4236
 __do_kmalloc_node mm/slub.c:4252 [inline]
 __kmalloc_node_noprof+0x9d6/0xf50 mm/slub.c:4270
 __kvmalloc_node_noprof+0xc0/0x2d0 mm/util.c:658
 btree_node_data_alloc fs/bcachefs/btree_cache.c:153 [inline]
 __bch2_btree_node_mem_alloc+0x2be/0xa80 fs/bcachefs/btree_cache.c:198
 bch2_fs_btree_cache_init+0x4e4/0xb50 fs/bcachefs/btree_cache.c:653
 bch2_fs_alloc fs/bcachefs/super.c:917 [inline]
 bch2_fs_open+0x4d3a/0x5b40 fs/bcachefs/super.c:2065
 bch2_fs_get_tree+0x983/0x22d0 fs/bcachefs/fs.c:2157
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4034
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4034
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 75 Comm: kworker/u8:5 Not tainted 6.12.0-syzkaller-07834-g06afb0f36106 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: btree_update btree_interior_update_work
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

