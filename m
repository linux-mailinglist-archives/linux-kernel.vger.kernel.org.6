Return-Path: <linux-kernel+bounces-426574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059B99DF520
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 10:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43123B20FEA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F6C82D98;
	Sun,  1 Dec 2024 09:40:31 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A02CA8
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733046030; cv=none; b=dyoPvnAC9NY7P55qD0zwr6cL1s5GDCnhPezeQqAXtsxo61QEvmh7nY/kZFJVxgg5YFEWYPU4f2Nzb4J7ZjVeVRkB0LGmI6m2NAe47n3+N7iHdx4CY105YYgdHIHCA1sBX2jZMEc/QHzSjMJqi6FOWg5JdFP08lVZUz4fg2fh1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733046030; c=relaxed/simple;
	bh=qKjMqBAwBGQ5vd/R1CCxn/JZSm+JPzWecVHphKP7h4w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FC8TO4Ho2niquaWOaaf010HChqYFdN4gXwfbZzY5CcQCJUw2rSC4z62hMcQNzMoleZ+vk0ffucJBxwBBc8VrGOxDB1O03CT1r437/H8dYhpiPtjyPD4VwMfBczFMP80PKnLQe/Cm0AuIh30xx/YNVyRyC1P6Rm0Iu9jJvyZxppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a78c40fa96so28215055ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 01:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733046028; x=1733650828;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+64qH9DDZzuxbucfu1Sho8Z4RI5Z31rvkXDXs5UDVl4=;
        b=j7MCjoGgmyupmPXY8YwTdlj7dxgjMZEoDSG50EDgHdl9b6CC5rBVXyhQuoS1G7dwvc
         HEIRbNwgY/x2kUO45bmRbSOJ6hs9Njzcr9CP2/RUkGdF2MbX+9/oPZ0ePTX6ood49Wi+
         GGjHDCC2g6pteeHRwnV1ewCOuz0a1He0+7Grh/J+jKOUJ6lNOyvF4mTX+Sos8iu87mSV
         C+pC3upEbs59fIX1FqKr6B8IB5jNSh0LesUQO52uZOK+Boibh4HXeZ/QMjVZZ9bjzqAo
         u5+Z62AcpewXXxMWNe9agvWxd/G/ZnuxzrIgmT5/AT3Vx8xtnMGD6rQH2eJWQPcblqSN
         p5iw==
X-Forwarded-Encrypted: i=1; AJvYcCU8QuhkCR6F+GE579xYJaB6tK9ChDxHSrHv4Fo2lFQeftT86VJZJL81tJ3SOEdlXYo4kG38zYxyPteKC74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJXzLmJ7kQkXCOUyll5o5CHyG4/5YFHfTdtzuyTdJIf9STVVlY
	ALYUc48rXZgWXsqcX8KtTBYAxSwSxGSkoYy8NvAJcGbvP9X4tVC0ycsaK+zm6a0Lyl+4chzzMd0
	1QOb6NkpEkCx9n2HWErs5H2iqqPUcjLURYX5xuDKLjj8DN7tFTl7nqBk=
X-Google-Smtp-Source: AGHT+IGDiNuUUIalgJyuZHIVSQ2zuj8QXA5Kx819ZDCVFfz+xg/47lmSa0bz5pirnJa6Bf2E2iag8fkFRfNdn/fgcF9HC6Z3jU34
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ca:b0:3a7:81c6:be7e with SMTP id
 e9e14a558f8ab-3a7c5580433mr146839775ab.13.1733046028528; Sun, 01 Dec 2024
 01:40:28 -0800 (PST)
Date: Sun, 01 Dec 2024 01:40:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674c2f0c.050a0220.ad585.0034.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_btree_node_get
From: syzbot <syzbot+2b2046c73fcb7e6a0e4e@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    445d9f05fa14 Merge tag 'nfsd-6.13' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112afff7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5486b9d7cc64830
dashboard link: https://syzkaller.appspot.com/bug?extid=2b2046c73fcb7e6a0e4e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7024ceac9339/disk-445d9f05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ebf50afbcd15/vmlinux-445d9f05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e60e080ed9e/bzImage-445d9f05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b2046c73fcb7e6a0e4e@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bch2_btree_node_get+0x605/0x18b0 fs/bcachefs/btree_cache.c:1180
 bch2_btree_node_get+0x605/0x18b0 fs/bcachefs/btree_cache.c:1180
 btree_path_down fs/bcachefs/btree_iter.c:956 [inline]
 bch2_btree_path_traverse_one+0x2c34/0x47b0 fs/bcachefs/btree_iter.c:1182
 bch2_btree_path_traverse fs/bcachefs/btree_iter.h:247 [inline]
 bch2_btree_iter_peek_node+0x2c5/0x15d0 fs/bcachefs/btree_iter.c:1901
 async_btree_node_rewrite_trans fs/bcachefs/btree_update_interior.c:2218 [inline]
 async_btree_node_rewrite_work+0x29d/0x1710 fs/bcachefs/btree_update_interior.c:2249
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_u64s_small fs/bcachefs/util.h:393 [inline]
 bkey_reassemble fs/bcachefs/bkey.h:513 [inline]
 bch2_bkey_buf_reassemble fs/bcachefs/bkey_buf.h:28 [inline]
 btree_node_iter_and_journal_peek+0x866/0x2520 fs/bcachefs/btree_iter.c:898
 btree_path_down fs/bcachefs/btree_iter.c:927 [inline]
 bch2_btree_path_traverse_one+0x254c/0x47b0 fs/bcachefs/btree_iter.c:1182
 bch2_btree_path_traverse fs/bcachefs/btree_iter.h:247 [inline]
 bch2_btree_iter_peek_node+0x2c5/0x15d0 fs/bcachefs/btree_iter.c:1901
 async_btree_node_rewrite_trans fs/bcachefs/btree_update_interior.c:2218 [inline]
 async_btree_node_rewrite_work+0x29d/0x1710 fs/bcachefs/btree_update_interior.c:2249
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 ___kmalloc_large_node+0x22c/0x370 mm/slub.c:4238
 __kmalloc_large_node_noprof+0x3f/0x1e0 mm/slub.c:4255
 __do_kmalloc_node mm/slub.c:4271 [inline]
 __kmalloc_node_noprof+0xc96/0x1250 mm/slub.c:4289
 __kvmalloc_node_noprof+0xc0/0x2d0 mm/util.c:650
 btree_node_data_alloc fs/bcachefs/btree_cache.c:153 [inline]
 bch2_btree_node_mem_alloc+0xa72/0x2ee0 fs/bcachefs/btree_cache.c:832
 __bch2_btree_node_alloc fs/bcachefs/btree_update_interior.c:321 [inline]
 bch2_btree_reserve_get+0x37f/0x2290 fs/bcachefs/btree_update_interior.c:549
 bch2_btree_update_start+0x1af9/0x2d60 fs/bcachefs/btree_update_interior.c:1247
 bch2_btree_split_leaf+0x120/0xc00 fs/bcachefs/btree_update_interior.c:1856
 bch2_trans_commit_error+0x1c0/0x1d60 fs/bcachefs/btree_trans_commit.c:942
 __bch2_trans_commit+0x210f/0xd190 fs/bcachefs/btree_trans_commit.c:1140
 bch2_trans_commit fs/bcachefs/btree_update.h:184 [inline]
 bch2_journal_replay+0x2e3d/0x4d30 fs/bcachefs/recovery.c:317
 bch2_run_recovery_pass fs/bcachefs/recovery_passes.c:191 [inline]
 bch2_run_recovery_passes+0xaf9/0xf80 fs/bcachefs/recovery_passes.c:244
 bch2_fs_recovery+0x447b/0x5b00 fs/bcachefs/recovery.c:861
 bch2_fs_start+0x7b2/0xbd0 fs/bcachefs/super.c:1037
 bch2_fs_get_tree+0x13ea/0x22d0 fs/bcachefs/fs.c:2170
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4034
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:4034
 ia32_sys_call+0x260e/0x4180 arch/x86/include/generated/asm/syscalls_32.h:22
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 0 UID: 0 PID: 7199 Comm: kworker/u8:2 Tainted: G        W          6.12.0-syzkaller-09734-g445d9f05fa14 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: btree_node_rewrite async_btree_node_rewrite_work
=====================================================


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

