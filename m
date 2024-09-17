Return-Path: <linux-kernel+bounces-331929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A6197B316
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E991C21A84
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BBE17BB25;
	Tue, 17 Sep 2024 16:41:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D417A5B5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726591264; cv=none; b=d3IzqUOgMyJuncVQy9RaLB2kPjO4UdAFJcwj+V+irfvlXAEq6M0YTgsTpx9ObEupZnmX2ZJxCdGluK/zW0olhChmI/V+Dt5dRnAQiJ/5/3/DuXg0Z2X6pWck/AC7AtG37YYNWWLY1lcQfsYgS00ynmdcbN1ICr4kv3GWq+m+IrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726591264; c=relaxed/simple;
	bh=krbQqQxMZtRevOaDBArVDmXFhEqAmbkxMbKn2/vuaAA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uVT4GDyPuwElrjN7Kzrw67Gl16AMbEIyZgNQNYhGESNm3qnF+M5zkotFYwaDBcD3bWngAuYpH3zPP1aHQ3qXi1t1sa/66taMuKIn8TfRDyhVmMPJIG02oH/1gvdzBcV6/GtWWiLsZJTrbXTIwrtQc9GoNUW/8nq3a3Ne/YUEi/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82aad3fa5edso857921139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726591262; x=1727196062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzC6bX7D0tnsgbj5ysx4usorzRP/nDnEvEP/6LqBk0s=;
        b=Yncp0QGyq0YgPMXePsyTDN8UPgvLWJcmokPNzIVD/3uFqfxlZBTjOoczSZhnWX37Xb
         boGMeNqWjkmrrZJB/499dkOCj2rtFh9sBv9BEYO+Bfg0ZiE1HDdZqY319j87XuB1fADm
         Io9+8iM/RjQC3jPwZEcTjNWW+LVXEUZ7NdAPLD/pU3fg25dhbcbGUnw+2sXVuSopcQo5
         JksryRLEIv2gv9vml3YpNwIFT3QrdgamLKVCZqoRXtKRA7MPPkPU8lqHmFo7DaEWwitl
         o8/Uc9w3MpTPPnaHd7zLyBqMymuNu5Z/JvCms+68Kb0U+r89m1jGDbj46ayqrd7MSr/M
         bgYw==
X-Gm-Message-State: AOJu0YxiL+fFNSeHmkuQ4EgFpu9Md8SL/BI1oJAerFEcEei/naPoCldp
	4pwk2+ytZq6KWJRJGuje+F/Ck6owW0q1r1LB0Vhj3V4X/L08YKW6KQrNieYKN1pFlVQhz8JtDk9
	le21shooPXpXVk7tupEnQ6fD41bMTdIDczAU7+VlzUdA28aOV9JwXK3E=
X-Google-Smtp-Source: AGHT+IH8Zp5RobLvhRtHa3eLQIIL1pTWnzgAS3qo6xZRYXtwfTDq8RSVWOgloRVNHKJrNKjeLXylU/DeDClsFLFlwdt2753cEF4M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:874f:0:b0:3a0:8f20:36f2 with SMTP id
 e9e14a558f8ab-3a08f203939mr111475035ab.20.1726591262227; Tue, 17 Sep 2024
 09:41:02 -0700 (PDT)
Date: Tue, 17 Sep 2024 09:41:02 -0700
In-Reply-To: <CAABpPxQfOeRrSwxu3NZCVRQUcEguEqabK6DJ9GPFJ2twY+EdPw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db93bc0622535ab1@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_write_cluster_by_desc
From: syzbot <syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pvmohammedanees2003@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in ocfs2_get_system_file_inode

ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
======================================================
WARNING: possible circular locking dependency detected
6.11.0-syzkaller-g2f27fce67173-dirty #0 Not tainted
------------------------------------------------------
syz.0.18/5725 is trying to acquire lock:
ffff888011b655a8 (&osb->system_file_mutex){+.+.}-{3:3}, at: ocfs2_get_system_file_inode+0x18f/0x7b0 fs/ocfs2/sysfile.c:101

but task is already holding lock:
ffff8880425a8660 (&ocfs2_file_ip_alloc_sem_key){++++}-{3:3}, at: ocfs2_write_begin+0x1d1/0x3a0 fs/ocfs2/aops.c:1901

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ocfs2_file_ip_alloc_sem_key){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       ocfs2_read_virt_blocks+0x2ca/0xa50 fs/ocfs2/extent_map.c:976
       ocfs2_read_dir_block fs/ocfs2/dir.c:508 [inline]
       ocfs2_find_entry_el fs/ocfs2/dir.c:715 [inline]
       ocfs2_find_entry+0x43b/0x2780 fs/ocfs2/dir.c:1080
       ocfs2_find_files_on_disk+0xff/0x360 fs/ocfs2/dir.c:1981
       ocfs2_lookup_ino_from_name+0xb1/0x1e0 fs/ocfs2/dir.c:2003
       _ocfs2_get_system_file_inode fs/ocfs2/sysfile.c:136 [inline]
       ocfs2_get_system_file_inode+0x305/0x7b0 fs/ocfs2/sysfile.c:112
       ocfs2_init_global_system_inodes+0x32c/0x730 fs/ocfs2/super.c:457
       ocfs2_initialize_super fs/ocfs2/super.c:2250 [inline]
       ocfs2_fill_super+0x3068/0x5880 fs/ocfs2/super.c:994
       mount_bdev+0x20a/0x2d0 fs/super.c:1679
       legacy_get_tree+0xee/0x190 fs/fs_context.c:662
       vfs_get_tree+0x90/0x2b0 fs/super.c:1800
       do_new_mount+0x2be/0xb40 fs/namespace.c:3507
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4055 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&osb->system_file_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3158 [inline]
       check_prevs_add kernel/locking/lockdep.c:3277 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ocfs2_get_system_file_inode+0x18f/0x7b0 fs/ocfs2/sysfile.c:101
       ocfs2_reserve_local_alloc_bits+0x107/0x2870 fs/ocfs2/localalloc.c:627
       ocfs2_reserve_clusters_with_limit+0x1b8/0xb60 fs/ocfs2/suballoc.c:1166
       ocfs2_reserve_clusters fs/ocfs2/suballoc.c:1227 [inline]
       ocfs2_lock_allocators+0x30a/0x630 fs/ocfs2/suballoc.c:2746
       ocfs2_write_begin_nolock+0x26f2/0x4ec0 fs/ocfs2/aops.c:1739
       ocfs2_write_begin+0x205/0x3a0 fs/ocfs2/aops.c:1903
       generic_perform_write+0x37e/0x730 mm/filemap.c:4025
       ocfs2_file_write_iter+0x17b1/0x1f50 fs/ocfs2/file.c:2456
       new_sync_write fs/read_write.c:590 [inline]
       vfs_write+0xa6d/0xc90 fs/read_write.c:683
       ksys_write+0x1a0/0x2c0 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ocfs2_file_ip_alloc_sem_key);
                               lock(&osb->system_file_mutex);
                               lock(&ocfs2_file_ip_alloc_sem_key);
  lock(&osb->system_file_mutex);

 *** DEADLOCK ***

4 locks held by syz.0.18/5725:
 #0: ffff88801e452b78 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x24e/0x320 fs/file.c:1187
 #1: ffff888000352420 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2930 [inline]
 #1: ffff888000352420 (sb_writers#12){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #2: ffff8880425a89c0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #2: ffff8880425a89c0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: ocfs2_file_write_iter+0x467/0x1f50 fs/ocfs2/file.c:2388
 #3: ffff8880425a8660 (&ocfs2_file_ip_alloc_sem_key){++++}-{3:3}, at: ocfs2_write_begin+0x1d1/0x3a0 fs/ocfs2/aops.c:1901

stack backtrace:
CPU: 0 UID: 0 PID: 5725 Comm: syz.0.18 Not tainted 6.11.0-syzkaller-g2f27fce67173-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2203
 check_prev_add kernel/locking/lockdep.c:3158 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ocfs2_get_system_file_inode+0x18f/0x7b0 fs/ocfs2/sysfile.c:101
 ocfs2_reserve_local_alloc_bits+0x107/0x2870 fs/ocfs2/localalloc.c:627
 ocfs2_reserve_clusters_with_limit+0x1b8/0xb60 fs/ocfs2/suballoc.c:1166
 ocfs2_reserve_clusters fs/ocfs2/suballoc.c:1227 [inline]
 ocfs2_lock_allocators+0x30a/0x630 fs/ocfs2/suballoc.c:2746
 ocfs2_write_begin_nolock+0x26f2/0x4ec0 fs/ocfs2/aops.c:1739
 ocfs2_write_begin+0x205/0x3a0 fs/ocfs2/aops.c:1903
 generic_perform_write+0x37e/0x730 mm/filemap.c:4025
 ocfs2_file_write_iter+0x17b1/0x1f50 fs/ocfs2/file.c:2456
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x1a0/0x2c0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f50b977def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f50ba5ad038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f50b9935f80 RCX: 00007f50b977def9
RDX: 000000000208e24b RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00007f50b97f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f50b9935f80 R15: 00007ffd3ff0ed38
 </TASK>


Tested on:

commit:         2f27fce6 Merge tag 'sound-6.12-rc1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123c84a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=158deee20b3048ab
dashboard link: https://syzkaller.appspot.com/bug?extid=18a87160c7d64ba2e2f6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1021869f980000


