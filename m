Return-Path: <linux-kernel+bounces-418682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033369D6445
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7240A161B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C411DFDAB;
	Fri, 22 Nov 2024 18:44:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BD1DF26F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732301066; cv=none; b=HGfCcKvRwcE/WFCrp3psZhkFPhYZwqoxD/8YX8Xo71mmCSJ7p0dppsgPJWOCh964MFdUwQblU8+QbBL7CsDtzxnLb2eNMHREXyF+tLyDM0RPWtC6npB1BwQYOxVts3MTp4Hx3yQ2AhVnNfS5Tpau5vBHtpzqcFLtlJCj02HiCLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732301066; c=relaxed/simple;
	bh=TT0WGwcgJa5PFxmOZWAmQHT63o9zD42O9nipFXhjmv4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Cfn59mcbyVCkNS9Yxxu8wlE86MWztZFUGG5UoR0HQKqfEPoWOXrvjWBor49airF5WaNDjixOC7vZ5THE7xWEAm6YhM5r8cO/5d7TDbRT0t0xCQ75N8LvKDuc1tkKTbQCBTf9smgFFKiwdxLUfsBlxP0v304ctth4S/c42O1jaMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7a72bd3a2so4845215ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732301064; x=1732905864;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovYHuJ2vlkVrLlI7ERokuEMkiHWXbw5n5FzW7/Nf3xA=;
        b=RooaXphbH/Kc51wzlor59LEGy0b8LqABhx/UUXE1nnh+0VrFabluPNbA2kCzjCvmOQ
         B4F5fs/f6VjPyLzXQN2POO9jYANJ74dq9Y6dMZVxkRcAjWq0/ieY7BV6wOWdtOHk0WMq
         293rhK9Z+gtv0VXhYvo6vrfQi8qMcgcOiPuRWglWRC2pEXIST+sJUywCkpZgqOnDeo4X
         B5RCSDV8ZTuDRoJGR+wmER3nKgRWQau085b/1IJ5tTyoPEFZ9cy29jNJV9jDOzx9na6j
         l/6S2ZRaWXvMtGCDaWpTiUJ+drSRO6KzDMCYxh9kg51b1n2xFi5/te/x2q+oFsmmMj/r
         fQQg==
X-Forwarded-Encrypted: i=1; AJvYcCUROFn8SWSWCQYHSt+cvt1TzLI2WagfmNsgeS5tucPMhHbR/VHuqaay0IlWy8gXKSs3HH+a+FkoZstC1/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiWSD+OmKL/KXrEih8m3EtiGmXhClx4+3qkbp1RevLfP/OLRBZ
	xxnWYCGecePX5KUBqGo0aQ3iylLIDdpQ2bZkNJ+JYD8emx6qcT8dNWmnrsR0D7QvNqga+eHKi2s
	SfD06KzlvBgbltuTlYgIB+bmvn6sgELGtxL1bP/L3kQmu0E4PRqjwXCI=
X-Google-Smtp-Source: AGHT+IFsOCNgD1v7Y74keTuT+MAcwV6u9M+XWo4PibhArf6aGmdT44GsDfSebct5vRNnRDqBGZEZ++er90QIAgSqhSWXmaAVgfBT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:3a7:86ab:bebf with SMTP id
 e9e14a558f8ab-3a79af6d1b5mr45296015ab.19.1732301064474; Fri, 22 Nov 2024
 10:44:24 -0800 (PST)
Date: Fri, 22 Nov 2024 10:44:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740d108.050a0220.3c9d61.0197.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in rw_aux_tree_set (2)
From: syzbot <syzbot+ed52fb987e4b52cbfad9@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc39fb56917b Merge tag 'jfs-6.13' of github.com:kleikamp/l..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1346bec0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a5c320d506b5745
dashboard link: https://syzkaller.appspot.com/bug?extid=ed52fb987e4b52cbfad9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16565b78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1746bec0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c35bd17a0dc5/disk-fc39fb56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/900f3f8ce653/vmlinux-fc39fb56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fae5edad1eaf/bzImage-fc39fb56.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/989b3cf7acff/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed52fb987e4b52cbfad9@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bkey_unpack_pos fs/bcachefs/bkey.h:463 [inline]
BUG: KMSAN: uninit-value in rw_aux_tree_set+0x4d2/0x580 fs/bcachefs/bset.c:494
 bkey_unpack_pos fs/bcachefs/bkey.h:463 [inline]
 rw_aux_tree_set+0x4d2/0x580 fs/bcachefs/bset.c:494
 rw_aux_tree_insert_entry+0x6c3/0x970 fs/bcachefs/bset.c:913
 bch2_bset_fix_lookup_table+0xecc/0x13e0
 bch2_bset_insert+0x1621/0x19f0 fs/bcachefs/bset.c:1015
 bch2_btree_bset_insert_key+0xf4e/0x2b60 fs/bcachefs/btree_trans_commit.c:217
 bch2_btree_insert_key_leaf+0x276/0x1050 fs/bcachefs/btree_trans_commit.c:300
 bch2_trans_commit_write_locked fs/bcachefs/btree_trans_commit.c:820 [inline]
 do_bch2_trans_commit fs/bcachefs/btree_trans_commit.c:900 [inline]
 __bch2_trans_commit+0xaf5e/0xd190 fs/bcachefs/btree_trans_commit.c:1121
 bch2_trans_commit fs/bcachefs/btree_update.h:184 [inline]
 btree_update_nodes_written fs/bcachefs/btree_update_interior.c:723 [inline]
 btree_interior_update_work+0x2080/0x4870 fs/bcachefs/btree_update_interior.c:861
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

CPU: 0 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted 6.12.0-syzkaller-05676-gfc39fb56917b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
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

