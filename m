Return-Path: <linux-kernel+bounces-351897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFFF991760
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF551C212AB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC630154BE2;
	Sat,  5 Oct 2024 14:32:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B172E400
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728138746; cv=none; b=YsLr9ocwF8rKWAk866tolaetMaebii2A7tOrOpUOcVZSxn8sIqam6OXmRyOk9he7UNv7eGXZIvm7VbO49tTm3a7KUtT2v4ENAs6tseaCj6lAEsLxVFiNswlMxiDHDN+fkKRolmsVmEY0O9cenjw+oLZ5MHffwyLLoOmHBGrY7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728138746; c=relaxed/simple;
	bh=GKJd2ReIw4+3NYPei0ODfAipFkzkdg4zsSHI72aZFJc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AObOiFpd2B+w1qUFBygHNvwRfbVtE844tjey6n3GHSeQekvoKS+w2qJcJaphSoDwhzd8h2wzWmU/JjSULwWxcnM33yfNXzrucbr2icG67UzPiaFk7JqXS/bwu1Y9nNUqeQVabZAyMbd1nqZwTs9wNVOkcRTQazLlYY+yR5n8V2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1925177fdso36000135ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 07:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728138744; x=1728743544;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omP9sEihr9wO02LK8eK99B+cjoHqjzL9JX7fZa4TN2o=;
        b=qDzz0hhTL8OmWZAY8FpnpoFTkzGBoBfAy8pKrfWd2B2k1guEXfrQUhv19R8l1C7EN1
         FEJ7CY5k46ZanPq0T8Y0W5KunJ/1jN81vGAHALpM9WjxoudU8h3sbx8mndEidnKtcuFR
         hMmZcDxaVSgOQGoe2+UOIlnafFoCrKtY4uPCa0m52FPV9RnFMGYUFBIo9fZJBdKp1uLh
         /fkcZMckpqzoWkWNa3at8rVeL4j5C/STe9KgybwsF8BcRBeVGhLpbqudd9g4BUJC3LL3
         3+oNZ4DQ7r0siCgDSmCpkDLJjKN+OQ29PvSZoMo2hLQ9cg23N0gxvdRj9y86wRQdySuw
         JU6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZrG1QPz7CheaW0YLfgP0Rvw8QMd2LQPUvLG7up3EFCNmP55zZrcLwF/4yttRxSVJTdOipiE8Nzwj48lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdHOIO49M0St5Iofc6HAwZey6Ut42f2QyZU6NRcAhWMEfD1g2h
	OSIQPY8Vyf1GEk3QsXw70FHO5b1TkvVLQJuXsulSJjwQZxh8b2fofUHGQggPYY7s3tqMnF0RZjx
	GDFqLaea8HHSun9kerGN5m6mwP4Mxc42LS3LHoxmYMqHTOcy6Ev3huME=
X-Google-Smtp-Source: AGHT+IGzPelBqbW54LHqOThYsDx7fxoy/YgJziMrYagsHprUnH4KYCh1D14gLy0t6yaBuEu/OcU0L+4U9T5w+fJ+6milKMII3mX1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a21:b0:3a0:933a:2a0a with SMTP id
 e9e14a558f8ab-3a375999a8bmr49502035ab.7.1728138743838; Sat, 05 Oct 2024
 07:32:23 -0700 (PDT)
Date: Sat, 05 Oct 2024 07:32:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67014df7.050a0220.49194.04c0.GAE@google.com>
Subject: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16cf7dd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1fd45f2013d812f
dashboard link: https://syzkaller.appspot.com/bug?extid=01218003be74b5e1213a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cf7dd0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d06580580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16d4da549bf4/disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a01bc9a0e174/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93f4dfad6909/bzImage-e32cde8d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/433ba0700154/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com

exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0x726052d3, utbl_chksum : 0xe619d30d)
=====================================================
BUG: KMSAN: uninit-value in __exfat_get_dentry_set+0x10ca/0x14d0 fs/exfat/dir.c:804
 __exfat_get_dentry_set+0x10ca/0x14d0 fs/exfat/dir.c:804
 exfat_get_dentry_set+0x58/0xec0 fs/exfat/dir.c:859
 __exfat_write_inode+0x3c1/0xe30 fs/exfat/inode.c:46
 __exfat_truncate+0x7f3/0xbb0 fs/exfat/file.c:211
 exfat_truncate+0xee/0x2a0 fs/exfat/file.c:257
 exfat_write_failed fs/exfat/inode.c:421 [inline]
 exfat_direct_IO+0x5a3/0x900 fs/exfat/inode.c:485
 generic_file_direct_write+0x275/0x6a0 mm/filemap.c:3977
 __generic_file_write_iter+0x242/0x460 mm/filemap.c:4141
 exfat_file_write_iter+0x894/0xfb0 fs/exfat/file.c:598
 do_iter_readv_writev+0x88a/0xa30
 vfs_writev+0x56a/0x14f0 fs/read_write.c:1064
 do_pwritev fs/read_write.c:1165 [inline]
 __do_sys_pwritev2 fs/read_write.c:1224 [inline]
 __se_sys_pwritev2+0x280/0x470 fs/read_write.c:1215
 __x64_sys_pwritev2+0x11f/0x1a0 fs/read_write.c:1215
 x64_sys_call+0x2edb/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:329
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_bvec include/linux/iov_iter.h:123 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0xe53/0x2b30 lib/iov_iter.c:185
 copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362
 shmem_file_read_iter+0xa09/0x12b0 mm/shmem.c:3167
 do_iter_readv_writev+0x88a/0xa30
 vfs_iter_read+0x278/0x760 fs/read_write.c:923
 lo_read_simple drivers/block/loop.c:283 [inline]
 do_req_filebacked drivers/block/loop.c:516 [inline]
 loop_handle_cmd drivers/block/loop.c:1910 [inline]
 loop_process_work+0x20fc/0x3750 drivers/block/loop.c:1945
 loop_rootcg_workfn+0x2b/0x40 drivers/block/loop.c:1976
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:123 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 copy_page_from_iter_atomic+0x12b7/0x3100 lib/iov_iter.c:481
 copy_folio_from_iter_atomic include/linux/uio.h:201 [inline]
 generic_perform_write+0x8d1/0x1080 mm/filemap.c:4066
 shmem_file_write_iter+0x2ba/0x2f0 mm/shmem.c:3221
 do_iter_readv_writev+0x88a/0xa30
 vfs_iter_write+0x44d/0xd40 fs/read_write.c:988
 lo_write_bvec drivers/block/loop.c:243 [inline]
 lo_write_simple drivers/block/loop.c:264 [inline]
 do_req_filebacked drivers/block/loop.c:511 [inline]
 loop_handle_cmd drivers/block/loop.c:1910 [inline]
 loop_process_work+0x15e6/0x3750 drivers/block/loop.c:1945
 loop_rootcg_workfn+0x2b/0x40 drivers/block/loop.c:1976
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4756
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1010
 __filemap_get_folio+0xac4/0x1550 mm/filemap.c:1952
 block_write_begin+0x6e/0x2b0 fs/buffer.c:2226
 exfat_write_begin+0xfb/0x400 fs/exfat/inode.c:434
 exfat_extend_valid_size fs/exfat/file.c:553 [inline]
 exfat_file_write_iter+0x474/0xfb0 fs/exfat/file.c:588
 do_iter_readv_writev+0x88a/0xa30
 vfs_writev+0x56a/0x14f0 fs/read_write.c:1064
 do_pwritev fs/read_write.c:1165 [inline]
 __do_sys_pwritev2 fs/read_write.c:1224 [inline]
 __se_sys_pwritev2+0x280/0x470 fs/read_write.c:1215
 __x64_sys_pwritev2+0x11f/0x1a0 fs/read_write.c:1215
 x64_sys_call+0x2edb/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:329
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5188 Comm: syz-executor221 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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

