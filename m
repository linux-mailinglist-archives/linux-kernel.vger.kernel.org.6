Return-Path: <linux-kernel+bounces-296162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0736E95A669
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D96D1F21973
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBCB17107F;
	Wed, 21 Aug 2024 21:20:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19186AFA
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275206; cv=none; b=DFOIci+YjqGibrW6+YOxNnpKu9PebEQ6yhtPol8gVJLOgBld7Z9Xh6QvNN9hu9sNVFNrEyG8ugi8or+jK7arFOLlA9cOeeeDraGauoVC2nXs2T1lqLHo8Rf2/sIwHuEy5T6otWLvYfo2XWg2ScgRn5QzBMA5B/IdM7Z91BE4lVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275206; c=relaxed/simple;
	bh=Kd3L81j8PZf4kC3h7ERxTdToS53WFFZHog43o/0+vfM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OFcJurgV7S/cy4+Yc8GQZGCpuIdkm5Vcku8FpNdmAtKl2cUQj9Y48d0xxtuaiHsuB0iLwPJtyF8hVxELLrcFV6SPdryAH2ojxfpGnUcaZCvlkl1jVwi3DgHy1jmRtyC71KdUcsYpxF0u9qthiMY4JICRs8ofR0MdTaAniYVKP28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d47fe875cso1383885ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275203; x=1724880003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1641SD+voyXBWG2bdhdWKDpWTslt3pzRDnHuMiHqDaw=;
        b=uYUEhtXjnPCyy+m0HpuUvCt+/K7q0Hcr/HDZuzz0TVGdp1N7kFTubIAVlj3LfIQuLw
         RDbrDPF8SebMRBY7y6MckNMAq6+9Xhzg1XIrsfSPp25OhnP/e8CYhO/3qfWJOG8GyrsH
         RwxDrJyKd+G2QoCq3C2KBzXmSR3m52eBbTiNhYiczXUcA8gT+Y7HfplJ6C3GMI6V6udh
         6jAI/eO431g/1edSvd8M5ao+TfsblV9tRRNQmlQRoAIJna4VS8EiF3aOZo/2wXUj9CVw
         QHHpFersQ26EVanD9lkYs9cxM64uPzsHfzMud65OEimYcRRVlDu9aS840lL9bxY2Rjsa
         BbVg==
X-Forwarded-Encrypted: i=1; AJvYcCVJv3Xyot6QMA0HuGDUIlE8vubz4bAAA56xP2W6R8eBVLEJ5e8I8p60q+B8zab6c6UhfqTMAAC6WXk3Rn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc0yL7Ux/psxFZ+flwQ/c04cnuIRHAsxlLQX+RsgawzUmoSfoc
	3nOtFz6VUFpb3vlRWyWb8sPez4MLYibKqIJY0b9LbUCgKHTSvIBg5R8dBWwKjUwvmruC7GcrLOa
	nvoMxlnTH/XY60eHIXA4pKH/D3yMl4gc2z/mQqepVfOeLT1nczjxS8IA=
X-Google-Smtp-Source: AGHT+IG29L5iIlHSk82/Dt8VbiFqg765x5IV1fk5G5HdjCf5garkJnhGlIwHWOtr+fx0+C3zh216iBzNS+idVslaBu1AwU3Fcusq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc4:b0:39a:e9f5:5ed5 with SMTP id
 e9e14a558f8ab-39d6c2c3c1fmr2971125ab.0.1724275203447; Wed, 21 Aug 2024
 14:20:03 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:20:03 -0700
In-Reply-To: <20240821210432.146003-1-djahchankoike@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff2d7a0620381afe@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_try_remove_refcount_tree
From: syzbot <syzbot+1fed2de07d8e11a3ec1b@syzkaller.appspotmail.com>
To: djahchankoike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in ocfs2_get_system_file_inode

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc4-syzkaller-00019-gb311c1b497e5-dirty #0 Not tainted
------------------------------------------------------
syz.0.20/5691 is trying to acquire lock:
ffff8880424195a8 (&osb->system_file_mutex){+.+.}-{3:3}, at: ocfs2_get_system_file_inode+0x18f/0x7b0 fs/ocfs2/sysfile.c:101

but task is already holding lock:
ffff88804e85a2e0 (&ocfs2_file_ip_alloc_sem_key){++++}-{3:3}, at: ocfs2_write_begin+0x1d1/0x3a0 fs/ocfs2/aops.c:1901

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

3 locks held by syz.0.20/5691:
 #0: ffff88804f948420 (sb_writers#12){.+.+}-{0:0}, at: do_coredump+0x1adc/0x2a30 fs/coredump.c:766
 #1: ffff88804e85a640 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #1: ffff88804e85a640 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: ocfs2_file_write_iter+0x46a/0x1f60 fs/ocfs2/file.c:2387
 #2: ffff88804e85a2e0 (&ocfs2_file_ip_alloc_sem_key){++++}-{3:3}, at: ocfs2_write_begin+0x1d1/0x3a0 fs/ocfs2/aops.c:1901

stack backtrace:
CPU: 0 UID: 0 PID: 5691 Comm: syz.0.20 Not tainted 6.11.0-rc4-syzkaller-00019-gb311c1b497e5-dirty #0
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
RIP: 0033:0x7f58d97799c1
Code: 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 73 01 <c3> 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
RSP: 002b:ffffffffffffffe0 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007f58d9915f80 RCX: 00007f58d97799b9
RDX: 0000000000000000 RSI: ffffffffffffffe0 RDI: 0000000004008011
RBP: 00007f58d97e78d8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f58d9915f80 R15: 00007ffc8b417b38
 </TASK>
OCFS2: ERROR (device loop0): int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *, handle_t *, u32, u32, struct ocfs2_suballoc_result *): Chain allocator dinode 23 has 4294967295 used bits but only 16777215 total
On-disk corruption discovered. Please run fsck.ocfs2 once the filesystem is unmounted.
OCFS2: Returning error to the calling process.
(syz.0.20,5691,0):ocfs2_claim_suballoc_bits:2038 ERROR: status = -5
(syz.0.20,5691,0):__ocfs2_claim_clusters:2412 ERROR: status = -5
(syz.0.20,5691,0):__ocfs2_claim_clusters:2420 ERROR: status = -5
(syz.0.20,5691,0):ocfs2_local_alloc_new_window:1197 ERROR: status = -5
(syz.0.20,5691,0):ocfs2_local_alloc_new_window:1222 ERROR: status = -5
(syz.0.20,5691,0):ocfs2_local_alloc_slide_window:1296 ERROR: status = -5
(syz.0.20,5691,0):ocfs2_local_alloc_slide_window:1315 ERROR: status = -5
(syz.0.20,5691,0):ocfs2_reserve_local_alloc_bits:672 ERROR: status = -5
(syz.0.20,5691,0):ocfs2_reserve_local_alloc_bits:710 ERROR: status = -5
(syz.0.20,5691,0):ocfs2_reserve_clusters_with_limit:1170 ERROR: status = -5
(syz.0.20,5691,0):ocfs2_reserve_clusters_with_limit:1219 ERROR: status = -5
(syz.0.20,5691,0):ocfs2_convert_inline_data_to_extents:7080 ERROR: status = -5
(syz.0.20,5691,0):ocfs2_try_to_write_inline_data:1564 ERROR: status = -5
(syz.0.20,5691,0):ocfs2_write_begin_nolock:1676 ERROR: status = -5
(syz.0.20,5691,0):ocfs2_write_begin:1906 ERROR: status = -5
ocfs2: Unmounting device (7,0) on (node local)


Tested on:

commit:         b311c1b4 Merge tag '6.11-rc4-server-fixes' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16dfa42b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=1fed2de07d8e11a3ec1b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178f93d5980000


