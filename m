Return-Path: <linux-kernel+bounces-552893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BBDA5808A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 05:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D385C16C213
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 04:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B6C6F06B;
	Sun,  9 Mar 2025 04:20:30 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA77E1
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741494029; cv=none; b=PXDZr6qcF8IzZeH62UrqOb6vgAZz+NF5vTWTZgSE4D+NEYHM+yWIr3btxxOA7PFiYPSR+/9/xUOgvuFKgP/FEslid8GjKxS6YhUvGozxtdmdskga3AheuG7XHDAc3LUFP9eh+W2n3aSTzRn3EgpaAoA0GIlIp8/1HuTviS4KpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741494029; c=relaxed/simple;
	bh=c3iEILmMaI3wm4BVuqP15UdfumtGnIke2aK+krIg77o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C7pd2v1tjbbuCRYwiKtGAbPnmlFp/knNTwFVjymE+biXP5MZisGUwT4eZqxfFZFfuEWtxur/+KpW8xagkJ/dMF2I39p6AU/HKyLbA5Qrzr7vwrWZCD/qva+mysYrXXYJOqk+nTps2XKaAYmY9kkASbjUHUDPQchj65fKgbPbWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d458e61faaso528035ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 20:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741494027; x=1742098827;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/UH17kZrHMXEPFewjUY9W+3Aerf116lSltEAhuXFIo=;
        b=R5Yr1ZK4oqZQIvcLgUKio0UNRNgXaYUcR2anUHfIRkgbw1ht0l8K0ecyKl/1E0LvtM
         RDW5SluR6oD3R1NJDXXUsURdFcFt0I19ext5cGJCTIg/Uz6vj/axI9dkajAqEO0U8bkI
         ZYSOSz6LlMgTYetTBUjE3SGFEwvu6qoU/MPUnpmRiWmzhofX/qDcmYZnn2Y3lAwNkFe6
         Dp4TbsHe2SVMKIJcAvqzQYSWeygKmsSCeihpkZEMfE95Mz6G+Y9Ll0kpgAGFCxeykbRN
         p/pJqmGCZLTX81G+8UQgIjbBMlgmXuHjVgqcDjMrpKjArRh/reo5XtjI4NWCjzaRwvpL
         W99g==
X-Forwarded-Encrypted: i=1; AJvYcCVOE88GtVVwozAJfOoS/0svx/Hgl33lbAe7eKuys0GxQfVd1eAgD5VtDiRCaYtyc1Xoc35vaYClBL8bu0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQJCvyR8YA0kkeB74Mkh7b4o7Kc6uTi88/I4jBJTc/z5SUV+1
	XFpX1I5ul5K5JsZY7hiSicAVJ559S5YlHxc0CsJZQk2ftdaQNaIONBV1M9MRuvQLFZBz4EtsBX5
	f1E9es0XvwrYZz+4C2Qb4M2V8BI6Q31Fouf3fi9kazfw5zS62wbEBzG8=
X-Google-Smtp-Source: AGHT+IHDEYq6+r+fSeqABiqc5io40EK/346/74NTBlIzePbQPJCeoWX0l9EdPiLTtsOkY1RZioysnIIhzbeZKLsN83V+j7FrJXLi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:10:b0:3d3:fa69:6755 with SMTP id
 e9e14a558f8ab-3d44aeafd29mr58939525ab.5.1741494027083; Sat, 08 Mar 2025
 20:20:27 -0800 (PST)
Date: Sat, 08 Mar 2025 20:20:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cd170b.050a0220.23b02d.0000.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_extent_crc_append (2)
From: syzbot <syzbot+79e4e34c2a37d5a9c1f7@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    48a5eed9ad58 Merge tag 'devicetree-fixes-for-6.14-2' of gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10a275a8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d47ea4b9912d894
dashboard link: https://syzkaller.appspot.com/bug?extid=79e4e34c2a37d5a9c1f7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134ed7a0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16630254580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f1f7744db24/disk-48a5eed9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0abefd13fceb/vmlinux-48a5eed9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a1858ec33bb8/bzImage-48a5eed9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f81e1c2bd91c/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79e4e34c2a37d5a9c1f7@syzkaller.appspotmail.com

bcachefs (loop0): check_allocations... done
bcachefs (loop0): going read-write
bcachefs (loop0): done starting filesystem
=====================================================
BUG: KMSAN: uninit-value in variable__ffs arch/x86/include/asm/bitops.h:251 [inline]
BUG: KMSAN: uninit-value in extent_entry_type fs/bcachefs/extents.h:59 [inline]
BUG: KMSAN: uninit-value in extent_entry_bytes fs/bcachefs/extents.h:68 [inline]
BUG: KMSAN: uninit-value in extent_entry_u64s fs/bcachefs/extents.h:81 [inline]
BUG: KMSAN: uninit-value in bch2_extent_crc_append+0x7c2/0x830 fs/bcachefs/extents.c:593
 variable__ffs arch/x86/include/asm/bitops.h:251 [inline]
 extent_entry_type fs/bcachefs/extents.h:59 [inline]
 extent_entry_bytes fs/bcachefs/extents.h:68 [inline]
 extent_entry_u64s fs/bcachefs/extents.h:81 [inline]
 bch2_extent_crc_append+0x7c2/0x830 fs/bcachefs/extents.c:593
 init_append_extent+0x466/0x1050 fs/bcachefs/io_write.c:729
 bch2_write_extent fs/bcachefs/io_write.c:1073 [inline]
 __bch2_write+0x54a9/0x8490 fs/bcachefs/io_write.c:1487
 bch2_write+0xc98/0x1af0 fs/bcachefs/io_write.c:1659
 closure_queue include/linux/closure.h:270 [inline]
 closure_call include/linux/closure.h:432 [inline]
 bch2_writepage_do_io fs/bcachefs/fs-io-buffered.c:469 [inline]
 bch2_writepages+0x24a/0x3c0 fs/bcachefs/fs-io-buffered.c:652
 do_writepages+0x427/0xc30 mm/page-writeback.c:2687
 filemap_fdatawrite_wbc mm/filemap.c:389 [inline]
 __filemap_fdatawrite_range mm/filemap.c:422 [inline]
 file_write_and_wait_range+0x6f2/0x7b0 mm/filemap.c:797
 bch2_fsync+0xb6/0x510 fs/bcachefs/fs-io.c:228
 vfs_fsync_range+0x1f9/0x260 fs/sync.c:187
 generic_write_sync include/linux/fs.h:2970 [inline]
 bch2_write_iter+0x4dce/0x50f0 fs/bcachefs/fs-io-buffered.c:1072
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xb34/0x1540 fs/read_write.c:679
 ksys_write+0x240/0x4b0 fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:739
 x64_sys_call+0x3161/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 bch2_extent_crc_pack+0x686/0x6b0 fs/bcachefs/extents.c:549
 bch2_extent_crc_append+0x645/0x830 fs/bcachefs/extents.c:591
 init_append_extent+0x466/0x1050 fs/bcachefs/io_write.c:729
 bch2_write_extent fs/bcachefs/io_write.c:1073 [inline]
 __bch2_write+0x54a9/0x8490 fs/bcachefs/io_write.c:1487
 bch2_write+0xc98/0x1af0 fs/bcachefs/io_write.c:1659
 closure_queue include/linux/closure.h:270 [inline]
 closure_call include/linux/closure.h:432 [inline]
 bch2_writepage_do_io fs/bcachefs/fs-io-buffered.c:469 [inline]
 bch2_writepages+0x24a/0x3c0 fs/bcachefs/fs-io-buffered.c:652
 do_writepages+0x427/0xc30 mm/page-writeback.c:2687
 filemap_fdatawrite_wbc mm/filemap.c:389 [inline]
 __filemap_fdatawrite_range mm/filemap.c:422 [inline]
 file_write_and_wait_range+0x6f2/0x7b0 mm/filemap.c:797
 bch2_fsync+0xb6/0x510 fs/bcachefs/fs-io.c:228
 vfs_fsync_range+0x1f9/0x260 fs/sync.c:187
 generic_write_sync include/linux/fs.h:2970 [inline]
 bch2_write_iter+0x4dce/0x50f0 fs/bcachefs/fs-io-buffered.c:1072
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xb34/0x1540 fs/read_write.c:679
 ksys_write+0x240/0x4b0 fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:739
 x64_sys_call+0x3161/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_frozen_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4762
 alloc_pages_mpol+0x4cd/0x890 mm/mempolicy.c:2270
 alloc_frozen_pages_noprof+0x1bf/0x1e0 mm/mempolicy.c:2341
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab+0x23a/0x1110 mm/slub.c:2587
 new_slab mm/slub.c:2640 [inline]
 ___slab_alloc+0x1287/0x3540 mm/slub.c:3826
 __slab_alloc mm/slub.c:3916 [inline]
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 kmem_cache_alloc_noprof+0x84e/0xe10 mm/slub.c:4171
 mempool_alloc_slab+0x36/0x50 mm/mempool.c:559
 mempool_init_node+0x202/0x4d0 mm/mempool.c:217
 mempool_init_noprof+0x57/0x70 mm/mempool.c:246
 bioset_init+0x279/0xb30 block/bio.c:1707
 bch2_fs_fs_io_buffered_init+0x4a/0xc0 fs/bcachefs/fs-io-buffered.c:1084
 bch2_fs_alloc fs/bcachefs/super.c:934 [inline]
 bch2_fs_open+0x5654/0x5ba0 fs/bcachefs/super.c:2064
 bch2_fs_get_tree+0x98a/0x24e0 fs/bcachefs/fs.c:2190
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3560
 path_mount+0x742/0x1f10 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x71f/0x800 fs/namespace.c:4088
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4088
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5782 Comm: syz-executor407 Not tainted 6.14.0-rc5-syzkaller-00016-g48a5eed9ad58 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
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

