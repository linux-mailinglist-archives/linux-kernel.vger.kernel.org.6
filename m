Return-Path: <linux-kernel+bounces-404134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF61F9C3F88
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D233A1C2190F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8462519CCF5;
	Mon, 11 Nov 2024 13:26:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F8515575E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331566; cv=none; b=Vf8B4qFbipTmQllm3LgFp7BvCpe+Zjjp71LJzdFr6Yjra6oIHi9glsWlF5dg+MPSObw/NiWMgbbFTz0jXw3GMeRjaYgA3Sew0l+oRlRFyM7Q7b5RyztHzuNuaWa2FzkaZJkWV+TmK8eFg7cYFczjQRYU3hFgZ1xxCBVYIDXIUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331566; c=relaxed/simple;
	bh=AKUHsrVp6smF5YRAiPGfcHtFbrSI4K+HKV8tBDWyoMA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gbVyDPVxLyMGhyPMREMinrgm5/GodDYiLmWGDs3fKQRGLNtKbxsTWqItrvmnFiELro8sd1ZiPnkWGkGNmm1SpGyBp7sd4fqOhE3sSx2aM3AuhDJjOF9Lvbp6Jr+1u4dK3+0LNZrFPfzovUA8DaQgVKHnOXDnx8Grd/43/Ki3wnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6b563871eso55664895ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 05:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731331563; x=1731936363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJmR1PZgnF8BEdMQ8ylU/NCmxoSqpm/5qI54PdVqLqM=;
        b=lAnOQQcO0aZFb6wtuSULztpriPGk38fMIa7maN/AtizZBz0Xl+uDiOREk9xiLlyd1n
         gucX4Nc87NY3OxQVy6QiKgiPWO+6OD3YHxh24ayrINtkZiInfgyE7w830jOHKyu0rVzs
         IDxejFrfGmNsdA8IEMzzbmhsQJFkbSW/pPVqOdsskKjrl3qhvaBBByF6/rrGPHhCZZfs
         Q2ar8j+XnPkt6PLzqsFB0RVzg6pRk5wKl3HfBe/C5BOLdtTBIGYUw+ddf747TGLLSAHA
         GXgewc+yDtNWAxL4GCTAWUvHxaoClcc09c13LtLbanCxg/g6H8yWYqFNeDtj0rGUuJpR
         /Yhg==
X-Forwarded-Encrypted: i=1; AJvYcCW3siq4CdJpHrHd2s4/fSyMRCV1Vtjf1BC88i3gciXof+9ugLXeOCBxJlL63vgZUnRmLxoh+o4wNTcRLmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLSgdy/P/PQxokwuIEoctXsNfCh4gCnwoNIs/wzCbf3gCjOQZo
	SGpj+2Q6YKrXHZdi4PO7UHwl/rRWJHXdjPsTokhrxBxY/Oz9M6X5ypl0akrEzqFCvT5z1FgUIwr
	VLVga/4/s3tc9kvVkGAxj6JxRIv16IHZ3EpcvV6qZBtodcebR2cY5N/E=
X-Google-Smtp-Source: AGHT+IEOvgGyqLVmYN4Npw0lqmNrv4Xwpxf1bTg7Z9NDIDFK1HqSifmrYOwjs99APDRWbFK4hJrwzDmMOvqcMJLEK70seflnF6aO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190e:b0:39b:330b:bb25 with SMTP id
 e9e14a558f8ab-3a6f19e2863mr128870485ab.12.1731331563393; Mon, 11 Nov 2024
 05:26:03 -0800 (PST)
Date: Mon, 11 Nov 2024 05:26:03 -0800
In-Reply-To: <tencent_29BA7ABBA933079E391B774B921B61255908@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673205eb.050a0220.a83d0.0014.GAE@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_file_extend (2)
From: syzbot <syzbot+4cba2fd444e9a16ae758@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in hfsplus_file_extend

loop0: detected capacity change from 0 to 1024
hfsplus: inconsistency in B*Tree (128,1,255,1,0)
======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc7-syzkaller-g2d5404caa8c7-dirty #0 Not tainted
------------------------------------------------------
syz.0.15/5813 is trying to acquire lock:
ffff8880569a0108 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x21b/0x1b70 fs/hfsplus/extents.c:460

but task is already holding lock:
ffff88803625c0b0 (&tree->tree_lock/1){+.+.}-{3:3}, at: hfsplus_find_init+0x14a/0x1c0 fs/hfsplus/bfind.c:28

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&tree->tree_lock/1){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfsplus_find_init+0x14a/0x1c0 fs/hfsplus/bfind.c:28
       hfsplus_ext_read_extent fs/hfsplus/extents.c:218 [inline]
       hfsplus_file_extend+0x454/0x1b70 fs/hfsplus/extents.c:464
       hfsplus_bmap_reserve+0x105/0x4e0 fs/hfsplus/btree.c:358
       hfsplus_create_attr+0x1c8/0x640 fs/hfsplus/attributes.c:221
       __hfsplus_setxattr+0x6fe/0x22d0 fs/hfsplus/xattr.c:354
       hfsplus_setxattr+0xb0/0xe0 fs/hfsplus/xattr.c:432
       hfsplus_trusted_setxattr+0x40/0x60 fs/hfsplus/xattr_trusted.c:30
       __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
       __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
       vfs_setxattr+0x221/0x430 fs/xattr.c:321
       do_setxattr fs/xattr.c:629 [inline]
       path_setxattr+0x37e/0x4d0 fs/xattr.c:658
       __do_sys_lsetxattr fs/xattr.c:683 [inline]
       __se_sys_lsetxattr fs/xattr.c:679 [inline]
       __x64_sys_lsetxattr+0xb8/0xd0 fs/xattr.c:679
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfsplus_file_extend+0x21b/0x1b70 fs/hfsplus/extents.c:460
       hfsplus_bmap_reserve+0x105/0x4e0 fs/hfsplus/btree.c:358
       __hfsplus_ext_write_extent+0x2af/0x5d0 fs/hfsplus/extents.c:105
       __hfsplus_ext_cache_extent+0x84/0xe10 fs/hfsplus/extents.c:188
       hfsplus_ext_read_extent fs/hfsplus/extents.c:220 [inline]
       hfsplus_file_extend+0x48c/0x1b70 fs/hfsplus/extents.c:464
       hfsplus_bmap_reserve+0x105/0x4e0 fs/hfsplus/btree.c:358
       hfsplus_create_attr+0x1c8/0x640 fs/hfsplus/attributes.c:221
       __hfsplus_setxattr+0x6fe/0x22d0 fs/hfsplus/xattr.c:354
       hfsplus_setxattr+0xb0/0xe0 fs/hfsplus/xattr.c:432
       hfsplus_trusted_setxattr+0x40/0x60 fs/hfsplus/xattr_trusted.c:30
       __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
       __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
       vfs_setxattr+0x221/0x430 fs/xattr.c:321
       do_setxattr fs/xattr.c:629 [inline]
       path_setxattr+0x37e/0x4d0 fs/xattr.c:658
       __do_sys_lsetxattr fs/xattr.c:683 [inline]
       __se_sys_lsetxattr fs/xattr.c:679 [inline]
       __x64_sys_lsetxattr+0xb8/0xd0 fs/xattr.c:679
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tree->tree_lock/1);
                               lock(&HFSPLUS_I(inode)->extents_lock);
                               lock(&tree->tree_lock/1);
  lock(&HFSPLUS_I(inode)->extents_lock);

 *** DEADLOCK ***

5 locks held by syz.0.15/5813:
 #0: ffff888011c4c420 (sb_writers#13){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff8880569a24b8 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff8880569a24b8 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0x1e1/0x430 fs/xattr.c:320
 #2: ffff888040a3a0b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_find_init+0x14a/0x1c0 fs/hfsplus/bfind.c:28
 #3: ffff888040a3e0b0 (&tree->tree_lock/2){+.+.}-{3:3}, at: hfsplus_find_init+0x14a/0x1c0 fs/hfsplus/bfind.c:28
 #4: ffff88803625c0b0 (&tree->tree_lock/1){+.+.}-{3:3}, at: hfsplus_find_init+0x14a/0x1c0 fs/hfsplus/bfind.c:28

stack backtrace:
CPU: 0 UID: 0 PID: 5813 Comm: syz.0.15 Not tainted 6.12.0-rc7-syzkaller-g2d5404caa8c7-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 hfsplus_file_extend+0x21b/0x1b70 fs/hfsplus/extents.c:460
 hfsplus_bmap_reserve+0x105/0x4e0 fs/hfsplus/btree.c:358
 __hfsplus_ext_write_extent+0x2af/0x5d0 fs/hfsplus/extents.c:105
 __hfsplus_ext_cache_extent+0x84/0xe10 fs/hfsplus/extents.c:188
 hfsplus_ext_read_extent fs/hfsplus/extents.c:220 [inline]
 hfsplus_file_extend+0x48c/0x1b70 fs/hfsplus/extents.c:464
 hfsplus_bmap_reserve+0x105/0x4e0 fs/hfsplus/btree.c:358
 hfsplus_create_attr+0x1c8/0x640 fs/hfsplus/attributes.c:221
 __hfsplus_setxattr+0x6fe/0x22d0 fs/hfsplus/xattr.c:354
 hfsplus_setxattr+0xb0/0xe0 fs/hfsplus/xattr.c:432
 hfsplus_trusted_setxattr+0x40/0x60 fs/hfsplus/xattr_trusted.c:30
 __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
 vfs_setxattr+0x221/0x430 fs/xattr.c:321
 do_setxattr fs/xattr.c:629 [inline]
 path_setxattr+0x37e/0x4d0 fs/xattr.c:658
 __do_sys_lsetxattr fs/xattr.c:683 [inline]
 __se_sys_lsetxattr fs/xattr.c:679 [inline]
 __x64_sys_lsetxattr+0xb8/0xd0 fs/xattr.c:679
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb2e7b7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb2e88e4038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 00007fb2e7d35f80 RCX: 00007fb2e7b7e719
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000020000040
RBP: 00007fb2e7bf139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb2e7d35f80 R15: 00007ffc148ca008
 </TASK>


Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a53ea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=4cba2fd444e9a16ae758
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f93ea7980000


