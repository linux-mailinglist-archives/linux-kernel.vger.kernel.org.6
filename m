Return-Path: <linux-kernel+bounces-240420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3528926D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBF31C21C64
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D642179A8;
	Thu,  4 Jul 2024 02:28:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F386168BE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060085; cv=none; b=dFMVqUJx+9PZpY1jfO10KYSDCCw/+BVrpBJCWyw6eoo4MOTcu4XX8rLxmYOaUxDOMgCXG2HM0dr9nsfioOWTjCGMIvZWunmRDkydExVPXseVrQ+YZDyXn4x/Rulyi0McjFikYxjM60V5OitrZ+syxQj2lIFQ1Tpu8kczAsTn1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060085; c=relaxed/simple;
	bh=hhhxzwpX44B8Qymm4rvTYsAP4QfF+viT5wXoiWVruq4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PvlDXtzwKTRHvLPPnnzZZ5NNE1ZnYspKkyICVxZmqtLG01JgxuKssWJ/qw9+MTzxUgp9qvq4VpnP2ZYeOB58UKPF0ipcon/FgBbizXzVygZMOucbknrMJPwfcyZPBBpF/yLUCNwKfpTxvA6bEcVPJndcwUidFJifKgBSZCnM7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f61da2de1eso23487639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 19:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720060083; x=1720664883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHyJR8Pn1qxc2ppJRzmX9AtyXlCWE1XERxx2eLyx+vw=;
        b=i5nYiBsZ8uPc0b+kHuvAXZl6t8htBAaLLSnIqZ7V7lvOoAgjByYB9iGNHxjKtb7cP1
         VdoHrsAXfB/qAbMLWmgHtgIsFoE3OZ7rz0U9xMZ10lbXFw4i/+Za01Ko5IIJKKQYZCQ2
         2euw8g7nDr975WQH9SScALwLWqYrK1DoAihOkAq/s2BP+8SbocMDDx+HBeK1FdLDRUNk
         o2nzT97nwUdbj9US+0G/pFmZ1ELiIi1SVaKEw0F1ZqzI7Jm6dSKhgiLA3b7QzalAJbtl
         G8U/OiUJmY9fHa6RQCZumJBwWIUwvuZAY3CC/3Sm7oA6dR5KVYAOXe9Ed/m/6oAUV63m
         1kZA==
X-Gm-Message-State: AOJu0Yzi3e2ecf78TMY4aN8SXwhrQnBslNby/nVHVARr7BvnmSyeKtIc
	qig62oTw+OkG9BLI+RPx2Mla4fPOAjHRY3Q2ssECDQoib4cg5TegEP0Effzy5NkrC1G1jAP1hRs
	R0AYjFdEUP4K6/Gztiex41zE3VvRPiBo1wV9nFXKSbQCW+rEuwQ0s0a8=
X-Google-Smtp-Source: AGHT+IEwPRIPFUva+bz6DWj898ZsJ5oqjp81lKwrlC9izUlVWWFEUKzy/h8uO/6TJm7jpiXZn2mYlMvv4OY3opiNRxCTfg/Ej5IE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35aa:b0:4b9:e249:e917 with SMTP id
 8926c6da1cb9f-4bf63375e07mr6225173.6.1720060083282; Wed, 03 Jul 2024 19:28:03
 -0700 (PDT)
Date: Wed, 03 Jul 2024 19:28:03 -0700
In-Reply-To: <20240704015732.1230654-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041b63a061c62b2c9@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in follow_pte
From: syzbot <syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in get_pat_info

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc6-syzkaller-00055-g734610514cb0-dirty #0 Not tainted
------------------------------------------------------
syz.0.15/5748 is trying to acquire lock:
ffff888024dc6098 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
ffff888024dc6098 (&mm->mmap_lock){++++}-{3:3}, at: follow_phys arch/x86/mm/pat/memtype.c:957 [inline]
ffff888024dc6098 (&mm->mmap_lock){++++}-{3:3}, at: get_pat_info+0xfe/0x640 arch/x86/mm/pat/memtype.c:995

but task is already holding lock:
ffff88801992cb00 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: i_mmap_lock_read include/linux/fs.h:523 [inline]
ffff88801992cb00 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: unmap_mapping_pages mm/memory.c:3765 [inline]
ffff88801992cb00 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: unmap_mapping_range+0xd7/0x280 mm/memory.c:3804

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&mapping->i_mmap_rwsem){++++}-{3:3}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       i_mmap_lock_write include/linux/fs.h:503 [inline]
       vma_link_file+0x7d/0x120 mm/mmap.c:402
       mmap_region+0xdec/0x2760 mm/mmap.c:2959
       do_mmap+0xbc7/0xf60 mm/mmap.c:1397
       vm_mmap_pgoff+0x1ba/0x360 mm/util.c:573
       vm_mmap+0x8e/0xc0 mm/util.c:592
       elf_map fs/binfmt_elf.c:381 [inline]
       elf_load+0x3de/0x880 fs/binfmt_elf.c:408
       load_elf_binary+0xc61/0x4db0 fs/binfmt_elf.c:1132
       search_binary_handler fs/exec.c:1797 [inline]
       exec_binprm fs/exec.c:1839 [inline]
       bprm_execve fs/exec.c:1891 [inline]
       bprm_execve+0x703/0x19b0 fs/exec.c:1867
       kernel_execve+0x3cf/0x4e0 fs/exec.c:2058
       try_to_run_init_process init/main.c:1395 [inline]
       kernel_init+0x14a/0x2b0 init/main.c:1523
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       mmap_read_lock include/linux/mmap_lock.h:144 [inline]
       follow_phys arch/x86/mm/pat/memtype.c:957 [inline]
       get_pat_info+0xfe/0x640 arch/x86/mm/pat/memtype.c:995
       untrack_pfn+0xf7/0x4d0 arch/x86/mm/pat/memtype.c:1108
       unmap_single_vma+0x1bd/0x2b0 mm/memory.c:1819
       zap_page_range_single+0x326/0x560 mm/memory.c:1920
       unmap_mapping_range_vma mm/memory.c:3684 [inline]
       unmap_mapping_range_tree mm/memory.c:3701 [inline]
       unmap_mapping_pages mm/memory.c:3767 [inline]
       unmap_mapping_range+0x1ee/0x280 mm/memory.c:3804
       truncate_pagecache+0x53/0x90 mm/truncate.c:731
       simple_setattr+0xf2/0x120 fs/libfs.c:886
       notify_change+0xec6/0x11f0 fs/attr.c:499
       do_truncate+0x15c/0x220 fs/open.c:65
       handle_truncate fs/namei.c:3308 [inline]
       do_open fs/namei.c:3658 [inline]
       path_openat+0x2860/0x2e50 fs/namei.c:3813
       do_filp_open+0x1dc/0x430 fs/namei.c:3840
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1413
       do_sys_open fs/open.c:1428 [inline]
       __do_sys_openat fs/open.c:1444 [inline]
       __se_sys_openat fs/open.c:1439 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1439
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&mapping->i_mmap_rwsem);
                               lock(&mm->mmap_lock);
                               lock(&mapping->i_mmap_rwsem);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

3 locks held by syz.0.15/5748:
 #0: ffff88801d5e2420 (sb_writers#4){.+.+}-{0:0}, at: do_open fs/namei.c:3647 [inline]
 #0: ffff88801d5e2420 (sb_writers#4){.+.+}-{0:0}, at: path_openat+0x23f0/0x2e50 fs/namei.c:3813
 #1: ffff88801992c830 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #1: ffff88801992c830 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: do_truncate+0x14b/0x220 fs/open.c:63
 #2: ffff88801992cb00 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: i_mmap_lock_read include/linux/fs.h:523 [inline]
 #2: ffff88801992cb00 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: unmap_mapping_pages mm/memory.c:3765 [inline]
 #2: ffff88801992cb00 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: unmap_mapping_range+0xd7/0x280 mm/memory.c:3804

stack backtrace:
CPU: 1 PID: 5748 Comm: syz.0.15 Not tainted 6.10.0-rc6-syzkaller-00055-g734610514cb0-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
 mmap_read_lock include/linux/mmap_lock.h:144 [inline]
 follow_phys arch/x86/mm/pat/memtype.c:957 [inline]
 get_pat_info+0xfe/0x640 arch/x86/mm/pat/memtype.c:995
 untrack_pfn+0xf7/0x4d0 arch/x86/mm/pat/memtype.c:1108
 unmap_single_vma+0x1bd/0x2b0 mm/memory.c:1819
 zap_page_range_single+0x326/0x560 mm/memory.c:1920
 unmap_mapping_range_vma mm/memory.c:3684 [inline]
 unmap_mapping_range_tree mm/memory.c:3701 [inline]
 unmap_mapping_pages mm/memory.c:3767 [inline]
 unmap_mapping_range+0x1ee/0x280 mm/memory.c:3804
 truncate_pagecache+0x53/0x90 mm/truncate.c:731
 simple_setattr+0xf2/0x120 fs/libfs.c:886
 notify_change+0xec6/0x11f0 fs/attr.c:499
 do_truncate+0x15c/0x220 fs/open.c:65
 handle_truncate fs/namei.c:3308 [inline]
 do_open fs/namei.c:3658 [inline]
 path_openat+0x2860/0x2e50 fs/namei.c:3813
 do_filp_open+0x1dc/0x430 fs/namei.c:3840
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1413
 do_sys_open fs/open.c:1428 [inline]
 __do_sys_openat fs/open.c:1444 [inline]
 __se_sys_openat fs/open.c:1439 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1439
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9279375b99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f927a12d048 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f9279503f60 RCX: 00007f9279375b99
RDX: 0000000000000300 RSI: 0000000020000c80 RDI: ffffffffffffff9c
RBP: 00007f92793e4a7a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f9279503f60 R15: 00007fff16c5b6f8
 </TASK>


Tested on:

commit:         73461051 Merge tag 'erofs-for-6.10-rc7-fixes' of git:/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15a417ae980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de2d4dc103148cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=35a4414f6e247f515443
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1775b399980000


