Return-Path: <linux-kernel+bounces-295282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEE295994A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6063E1C233E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FF6205A88;
	Wed, 21 Aug 2024 09:48:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C26205A82
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233684; cv=none; b=DP8MGV2MnfSa1qXF6vXOsy43YwIJixEYeIOp1PMU+jujUc0QVA3I106pwi2FCLgFbqgagsJgmBdZC5QSByzJQnK0JU5r/rY+0EV/3icoApj0UQeCF24eAFttY+gWgPIA0EEbLPdTPNa4GYxabatjqSOF1RwqOPJMjxAdu16B9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233684; c=relaxed/simple;
	bh=uHQIt+5n7BGWifdO30D3Rrir/LBlY/LG8DjtaPKk/9c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bGhLEZ6xgczg431GfzDffbqoB/OiXmZn2DL/zkzLurMf4WlDdiZb8dvsvLjCP+jYNJnoyZc5RFYSgex/+xHnvZVoDaA+tBSq/gQ9lxUg+KHkHfPObeOMLtOAPbkOc+wvASgvI4PnIOwbfEcr5zpJPM/E+4O+0xYrmzUeoAW5Sgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f968e53b0so604959839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724233682; x=1724838482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRKUWVoZ20Z2BmemCfk5yHKSZO93Ftw7487KRucYk0I=;
        b=plTYuPOfc0HLJ+wSUy/o8H3cy0yHkl9DHosGP3lQd8E/1gY6QTnNmgpICEHLO03uy/
         S+7ahohhYsxemksUrOZc/rtw8P8/yvOVabNQ7CZQONkDcA3muZdiNfgiw7wMVvbzA8N4
         7s+V81MgppS+HN3o2BJsXNPm+bMZG49CuaqTLA7xeeL3kO1TterQ3o4mgIsMYPpU9BVz
         zvV88jm7oPHa3s+C57CamGBCxxPUom6gg8Dk6bGRR0Tvzb/nM4VFV5pn1WP6FwK9mryF
         m8qrrH01vFV7j0+jXPa9UkKZBCUNcaAeBa4ZSTeK4d6cuLyZ3+9U+MeGhIZ45jOgoQvF
         raZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSq7DpmPW7W1VGFUzuJmZoIb0ogXMqDP7I7ZDX1NJLE5XPXkMirJs20vp9K+sq5oA17fCTWu9+7+kf6hE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqsfpaw+KLYeP2stwErRoeBtKC0JJ8Ps1KN9/qhQ6k1LavGtnk
	s+QsjZ0oXc7ryAIq1Wo6ROt8Bz98bCfr+DE/bySnEOZdo/xVlZe9Ui4t69L4PCQg4TMhCtRhmXq
	U49e2n+RnGMU8mueHJuRXO65H5c3ckTR7B2ossSZWW7qOfqcV/J+LxW4=
X-Google-Smtp-Source: AGHT+IGP7JeamJ9EiMo1eeZrDluS9kudANA3KPcBKMJRdGKi4/4jSjESQGOo1Tev5Ogrj4q74doPfDWzZeZ2bJxqJbaaj9fv6sNK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410b:b0:4c2:2ad5:bfd0 with SMTP id
 8926c6da1cb9f-4ce626bc407mr69472173.0.1724233682002; Wed, 21 Aug 2024
 02:48:02 -0700 (PDT)
Date: Wed, 21 Aug 2024 02:48:01 -0700
In-Reply-To: <tencent_3BC9CCA2E7ED86CB52D9C66449BE2EC72E06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020382906202e7042@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_try_remove_refcount_tree
From: syzbot <syzbot+1fed2de07d8e11a3ec1b@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in ocfs2_get_system_file_inode

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc3-syzkaller-00066-g1fb918967b56-dirty #0 Not tainted
------------------------------------------------------
syz.0.18/5710 is trying to acquire lock:
ffff88804e4b95a8 (&osb->system_file_mutex){+.+.}-{3:3}, at: ocfs2_get_system_file_inode+0x18f/0x7b0 fs/ocfs2/sysfile.c:101

but task is already holding lock:
ffff888011b74da0 (&ocfs2_file_ip_alloc_sem_key){++++}-{3:3}, at: ocfs2_write_begin+0x1d1/0x3a0 fs/ocfs2/aops.c:1901

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ocfs2_file_ip_alloc_sem_key){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       ocfs2_read_virt_blocks+0x2ca/0xa50 fs/ocfs2/extent_map.c:976
       ocfs2_read_dir_block fs/ocfs2/dir.c:508 [inline]
       ocfs2_find_entry_el fs/ocfs2/dir.c:715 [inline]
       ocfs2_find_entry+0x43b/0x2780 fs/ocfs2/dir.c:1080
       ocfs2_find_files_on_disk+0xff/0x360 fs/ocfs2/dir.c:1980
       ocfs2_lookup_ino_from_name+0xb1/0x1e0 fs/ocfs2/dir.c:2002
       _ocfs2_get_system_file_inode fs/ocfs2/sysfile.c:136 [inline]
       ocfs2_get_system_file_inode+0x305/0x7b0 fs/ocfs2/sysfile.c:112
       ocfs2_init_global_system_inodes+0x32c/0x730 fs/ocfs2/super.c:457
       ocfs2_initialize_super fs/ocfs2/super.c:2250 [inline]
       ocfs2_fill_super+0x3068/0x5880 fs/ocfs2/super.c:994
       mount_bdev+0x20a/0x2d0 fs/super.c:1679
       legacy_get_tree+0xee/0x190 fs/fs_context.c:662
       vfs_get_tree+0x90/0x2a0 fs/super.c:1800
       do_new_mount+0x2be/0xb40 fs/namespace.c:3472
       do_mount fs/namespace.c:3812 [inline]
       __do_sys_mount fs/namespace.c:4020 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&osb->system_file_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ocfs2_get_system_file_inode+0x18f/0x7b0 fs/ocfs2/sysfile.c:101
       ocfs2_reserve_local_alloc_bits+0x107/0x2870 fs/ocfs2/localalloc.c:627
       ocfs2_reserve_clusters_with_limit+0x1b8/0xb60 fs/ocfs2/suballoc.c:1166
       ocfs2_convert_inline_data_to_extents+0x29d/0x17f0 fs/ocfs2/alloc.c:7078
       ocfs2_try_to_write_inline_data fs/ocfs2/aops.c:1562 [inline]
       ocfs2_write_begin_nolock+0x1c79/0x4d30 fs/ocfs2/aops.c:1669
       ocfs2_write_begin+0x205/0x3a0 fs/ocfs2/aops.c:1903
       generic_perform_write+0x399/0x840 mm/filemap.c:4019
       ocfs2_file_write_iter+0x17b4/0x1f60 fs/ocfs2/file.c:2455
       __kernel_write_iter+0x40d/0x900 fs/read_write.c:523
       __kernel_write+0x120/0x180 fs/read_write.c:543
       __dump_emit+0x237/0x360 fs/coredump.c:816
       elf_core_dump+0x35e0/0x4720 fs/binfmt_elf.c:2095
       do_coredump+0x1b04/0x2a30 fs/coredump.c:767
       get_signal+0x13fa/0x1740 kernel/signal.c:2902
       arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
       exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       irqentry_exit_to_user_mode+0x79/0x280 kernel/entry/common.c:231
       exc_page_fault+0x590/0x8c0 arch/x86/mm/fault.c:1542
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ocfs2_file_ip_alloc_sem_key);
                               lock(&osb->system_file_mutex);
                               lock(&ocfs2_file_ip_alloc_sem_key);
  lock(&osb->system_file_mutex);

 *** DEADLOCK ***

3 locks held by syz.0.18/5710:
 #0: ffff88804e4fc420 (sb_writers#12){.+.+}-{0:0}, at: do_coredump+0x1adc/0x2a30 fs/coredump.c:766
 #1: ffff888011b75100 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #1: ffff888011b75100 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: ocfs2_file_write_iter+0x46a/0x1f60 fs/ocfs2/file.c:2387
 #2: ffff888011b74da0 (&ocfs2_file_ip_alloc_sem_key){++++}-{3:3}, at: ocfs2_write_begin+0x1d1/0x3a0 fs/ocfs2/aops.c:1901

stack backtrace:
CPU: 0 UID: 0 PID: 5710 Comm: syz.0.18 Not tainted 6.11.0-rc3-syzkaller-00066-g1fb918967b56-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ocfs2_get_system_file_inode+0x18f/0x7b0 fs/ocfs2/sysfile.c:101
 ocfs2_reserve_local_alloc_bits+0x107/0x2870 fs/ocfs2/localalloc.c:627
 ocfs2_reserve_clusters_with_limit+0x1b8/0xb60 fs/ocfs2/suballoc.c:1166
 ocfs2_convert_inline_data_to_extents+0x29d/0x17f0 fs/ocfs2/alloc.c:7078
 ocfs2_try_to_write_inline_data fs/ocfs2/aops.c:1562 [inline]
 ocfs2_write_begin_nolock+0x1c79/0x4d30 fs/ocfs2/aops.c:1669
 ocfs2_write_begin+0x205/0x3a0 fs/ocfs2/aops.c:1903
 generic_perform_write+0x399/0x840 mm/filemap.c:4019
 ocfs2_file_write_iter+0x17b4/0x1f60 fs/ocfs2/file.c:2455
 __kernel_write_iter+0x40d/0x900 fs/read_write.c:523
 __kernel_write+0x120/0x180 fs/read_write.c:543
 __dump_emit+0x237/0x360 fs/coredump.c:816
 elf_core_dump+0x35e0/0x4720 fs/binfmt_elf.c:2095
 do_coredump+0x1b04/0x2a30 fs/coredump.c:767
 get_signal+0x13fa/0x1740 kernel/signal.c:2902
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x79/0x280 kernel/entry/common.c:231
 exc_page_fault+0x590/0x8c0 arch/x86/mm/fault.c:1542
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f9a89b799c1
Code: 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 73 01 <c3> 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
RSP: 002b:ffffffffffffffe0 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007f9a89d15f80 RCX: 00007f9a89b799b9
RDX: 0000000000000000 RSI: ffffffffffffffe0 RDI: 0000000004008011
RBP: 00007f9a89be78d8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9a89d15f80 R15: 00007fff4ea50e98
 </TASK>
OCFS2: ERROR (device loop0): int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *, handle_t *, u32, u32, struct ocfs2_suballoc_result *): Chain allocator dinode 23 has 4294967295 used bits but only 16777215 total
On-disk corruption discovered. Please run fsck.ocfs2 once the filesystem is unmounted.
OCFS2: Returning error to the calling process.
(syz.0.18,5710,0):ocfs2_claim_suballoc_bits:2038 ERROR: status = -5
(syz.0.18,5710,0):__ocfs2_claim_clusters:2412 ERROR: status = -5
(syz.0.18,5710,0):__ocfs2_claim_clusters:2420 ERROR: status = -5
(syz.0.18,5710,0):ocfs2_local_alloc_new_window:1197 ERROR: status = -5
(syz.0.18,5710,0):ocfs2_local_alloc_new_window:1222 ERROR: status = -5
(syz.0.18,5710,0):ocfs2_local_alloc_slide_window:1296 ERROR: status = -5
(syz.0.18,5710,0):ocfs2_local_alloc_slide_window:1315 ERROR: status = -5
(syz.0.18,5710,0):ocfs2_reserve_local_alloc_bits:672 ERROR: status = -5
(syz.0.18,5710,0):ocfs2_reserve_local_alloc_bits:710 ERROR: status = -5
(syz.0.18,5710,0):ocfs2_reserve_clusters_with_limit:1170 ERROR: status = -5
(syz.0.18,5710,0):ocfs2_reserve_clusters_with_limit:1219 ERROR: status = -5
(syz.0.18,5710,0):ocfs2_convert_inline_data_to_extents:7080 ERROR: status = -5
(syz.0.18,5710,0):ocfs2_try_to_write_inline_data:1564 ERROR: status = -5
(syz.0.18,5710,0):ocfs2_write_begin_nolock:1676 ERROR: status = -5
(syz.0.18,5710,0):ocfs2_write_begin:1906 ERROR: status = -5
ocfs2: Unmounting device (7,0) on (node local)


Tested on:

commit:         1fb91896 Merge tag 'for-6.11-rc3-tag' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=129badf3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=1fed2de07d8e11a3ec1b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e96ea3980000


