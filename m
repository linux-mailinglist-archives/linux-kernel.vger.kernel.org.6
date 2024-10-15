Return-Path: <linux-kernel+bounces-365516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6B599E38D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E862845A6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41C1E378C;
	Tue, 15 Oct 2024 10:15:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86191E2851
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987306; cv=none; b=uZHPzPYOT1lMQap8GD8DPVkbriANeao+zbokpKeo2lmPlKIx/b96oBSWEZ6gcCJaGuLWVvDft7W+/cUQLNFJjN19LM1S/h6f4NSB/420Z7fhAqBNnCRoGzR1Ve4eyQPoA5rgTurohtaMdTMwczVYpr/Dc7vtvH73ohyodo/OCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987306; c=relaxed/simple;
	bh=hdhyz1X+zkQdSRvMGamjXwpH63nHZUtp1rS2otRxipM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OS6nQ8/7I5vvvI9IGt2tZ2T25VFJNw+N92q0bemA+m9dtXTmF6K6aIQ/rcfIelO/Ni0FUJ8W3BMRy3QQb3N612z01u/w/sZhUU7znngMc4ruEy22oqc7LxGezUbgC+RMDxgy4KxfRXW0E5So95wGgBFmV0Sr9hDmWNyG4wYQzMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so36436795ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728987304; x=1729592104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rQVsonCa/Q0/w35m3SaSFI9GSoI9r1KX5+Vbjrj6Hg=;
        b=Pjvn5E4aGzsZEqQDI1hgrDD+xfA2uMI9ZQOZsUOw9RMBC/hlsmOxsTXXQMry1rBx5o
         k0g+MiGuGtbVTvmx4Hx6wqZhSHXNNuGGhSFWhPeIKIwwICzkqWOD8hHgAZjTjlnqS+e3
         wjhonJSIf9HIleAuDRW1OnEuDRj5spyN1wjG044TNncm3MujuymZA0kvDT8NiYeawtHw
         aNLqgDOLMRZOKTL8DXAZJdYgv9HOqV0pkdrtriOWw7AXEFDShbywTgARZZXE+XO41pYw
         ssAZzBwpeMt//XMHw3lUFTScTE64u1rTWI9SICpWq2RymoIrOHrKIwwK+3W20AiT8o4B
         9c7g==
X-Forwarded-Encrypted: i=1; AJvYcCX5LUe4FbC4jZenp8saHWiSBjO6XWDQmsNhvmI2ieccf9D1zajVlJfXxzQO8Rt+G544/qfdcmFYOf7f8lE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2rbHQcsmOIwCA5tC7sEMpCP9yua/VHXLF8Yh9GYyUkirGcbsN
	zewThUsh41PYfeqkxbRdT3SKR0M3L171KA6RnT0K3AbPXuZuVaxipBi6ek7WuU8133uR8skz4gx
	IB8luPlZTgp9iZAw3DMIQaHiHJ6rfbmnZ4b9Rr+aFUkC5fkAY9hdyyog=
X-Google-Smtp-Source: AGHT+IHp9nwNKERhezOCB5xsrF/RXMlGypfF0gC8XoT+etCz69wAL3qm8grqAkIMxIfZlDO3PyCW3I2xtTaU+yDRVKu3XrJpZpAm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8d:b0:3a0:b384:219b with SMTP id
 e9e14a558f8ab-3a3b6051030mr97707055ab.26.1728987303885; Tue, 15 Oct 2024
 03:15:03 -0700 (PDT)
Date: Tue, 15 Oct 2024 03:15:03 -0700
In-Reply-To: <tencent_D3FEC641C9842EEB2EE2CC8E67DB86DD9206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e40a7.050a0220.d9b66.0150.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in add_delayed_ref
From: syzbot <syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in ulist_alloc

BTRFS info (device loop0): first mount of filesystem 395ef67a-297e-477c-816d-cd80a5b93e5d
BTRFS info (device loop0): using sha256 (sha256-avx2) checksum algorithm
BTRFS info (device loop0): using free-space-tree
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:321
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6014, name: syz.0.15
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
8 locks held by syz.0.15/6014:
 #0: ffff888032202420 (sb_writers#13){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff888066478d90 (&type->i_mutex_dir_key#8/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:851 [inline]
 #1: ffff888066478d90 (&type->i_mutex_dir_key#8/1){+.+.}-{3:3}, at: filename_create+0x260/0x540 fs/namei.c:4026
 #2: ffff888032202610 (sb_internal#2){.+.+}-{0:0}, at: btrfs_create_common+0x1b2/0x2e0 fs/btrfs/inode.c:6572
 #3: ffff88802e9ce458 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x15e/0xd70 fs/btrfs/transaction.c:313
 #4: ffff88802e9ce480 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x15e/0xd70 fs/btrfs/transaction.c:313
 #5: ffff888078a220f8 (btrfs-tree-01){++++}-{3:3}, at: btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189
 #6: ffff8880302980f8 (btrfs-tree-01/1){+.+.}-{3:3}, at: btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189
 #7: ffff88802174d388 (&cur_trans->delayed_refs.lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #7: ffff88802174d388 (&cur_trans->delayed_refs.lock){+.+.}-{2:2}, at: add_delayed_ref+0x6e6/0x1e70 fs/btrfs/delayed-ref.c:1045
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 6014 Comm: syz.0.15 Not tainted 6.12.0-rc3-next-20241015-syzkaller-04439-gb852e1e7a038-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8653
 might_alloc include/linux/sched/mm.h:321 [inline]
 slab_pre_alloc_hook mm/slub.c:4045 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 __kmalloc_cache_noprof+0x61/0x390 mm/slub.c:4299
 kmalloc_noprof include/linux/slab.h:879 [inline]
 ulist_alloc+0x6e/0x140 fs/btrfs/ulist.c:101
 btrfs_find_all_roots_safe+0xf3/0x4c0 fs/btrfs/backref.c:1748
 btrfs_find_all_roots+0x84/0xf0 fs/btrfs/backref.c:1799
 btrfs_qgroup_trace_extent_post+0x1cd/0x2e0 fs/btrfs/qgroup.c:2105
 add_delayed_ref+0x131c/0x1e70 fs/btrfs/delayed-ref.c:1076
 btrfs_alloc_tree_block+0xdfb/0x1440 fs/btrfs/extent-tree.c:5209
 btrfs_force_cow_block+0x526/0x1da0 fs/btrfs/ctree.c:573
 btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
 btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4314
 btrfs_create_new_inode+0xe27/0x1f60 fs/btrfs/inode.c:6344
 btrfs_create_common+0x1d4/0x2e0 fs/btrfs/inode.c:6578
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
 do_mkdirat+0x264/0x3a0 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8dcbd7dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8dccb5c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f8dcbf35f80 RCX: 00007f8dcbd7dff9
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000005
RBP: 00007f8dcbdf0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8dcbf35f80 R15: 00007ffe00c6dd48
 </TASK>


Tested on:

commit:         b852e1e7 Add linux-next specific files for 20241015
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1186d727980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb0191818709a2b
dashboard link: https://syzkaller.appspot.com/bug?extid=c3a3a153f0190dca5be9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c2045f980000


