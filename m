Return-Path: <linux-kernel+bounces-205405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD1A8FFB14
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF001F26B5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A4C49646;
	Fri,  7 Jun 2024 04:57:29 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9A19D89B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736249; cv=none; b=PrDXtS0QcW+9ILR6jpC6xp2CRGY4Oe3yRdupvMeaAk/Oa22PoYXywdASDOa9gZpid3S0PZDf+GcwibZd1zuM74t0OPr0GSB4E8EsT6PY0BG8/n6kfMkRSLXn7A5o6x8baFWJVIgr2j9TeqXWMuGyicPQ2TQ1cIBYj2Fx/AezE08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736249; c=relaxed/simple;
	bh=6OD0xpFPZkTaJDfzgkNIn1ThLeqG04e6y9RJKhVDwLI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jcx/YKLR960kBdD9Mh+HgonYZDuJABzQxu8sM8rtQIzdB2dNn0Z2OE2F5+MrspP1+XCsp1dN0b1d61+UL7RbPTHuBXuM2YT8W9aS2nvaQ/02xzW71bcPFLDrlHAVBdWlfPzErl1KfySuhD6b2lxkNXjZWBRgP2wb5T0eihiiqsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3738732f988so16589565ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 21:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717736247; x=1718341047;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cr/SfK1pOXqM6uFGJaw3V4OyD5ZDEqPY6c9E2HKFZwM=;
        b=s/9avjXXZwEStMkZrPw5XBTinqAEGS9kvLxnrDBMYOscW8YHrLn2zIoBtbXOBJSfrc
         ICoV9fJGZd4LHVcOzrLKVytrKOvhdpwnkhSEbFFIzOO2JivBLbWXIWaT9bXuqeZA5/L5
         U05m0fUAX/36a5YFlM2LMnJIrIRYylaVX0HD3xDDCZQFzOmItlt006oOsolYF2l+TXL3
         7CUJYwP1slRyAsxNFDXJCMXBQm3DI7OFHtrO3AhAmFpjn47qep7dJqZ4aIauaXGJQcm9
         awuBjRRmIArVfVSKngnlX8DyItm9k/FMNKX9Jk0nlhCxhFxyDVeQmwgXb/utQ4LyO815
         kA/w==
X-Forwarded-Encrypted: i=1; AJvYcCWTAxAo9y0dVmKkWHO/jUql9eEgvPZddDDZLdN4v73EPUyUaMGq+ZcQIi3xO1upQ5ajZSm3qrKC3Jw20VL2InUvm/n07dhOtI0Wlo1t
X-Gm-Message-State: AOJu0Yz1ghIMXlkuaTZTG/e69N5BXyou/mYzxmCDDGvDl9hoEeJ26tr1
	CT62L5lhmrQYvQ/WvEwGuXYU2xR0Vbhm5UxAqdd+4VIqFxvdfAWVB8lgwqIZlnQUU2UIe9M8LAI
	6A5ugEf/lbM15UAlJZ/tG2JxNoGdZgeihR4qWFb1z+J7o0PajzCAl4bo=
X-Google-Smtp-Source: AGHT+IHlbWYbF25MPpKyn+KIS12CakPBE0evmdRZfs9FDRwdybMNwxbl3x1Fk2RRxCF/XeyUYal1VW0Fd0hKtP4QcC9NgZrnWaqC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c49:b0:374:a2db:d6b0 with SMTP id
 e9e14a558f8ab-375802fd4b9mr1311245ab.2.1717736246857; Thu, 06 Jun 2024
 21:57:26 -0700 (PDT)
Date: Thu, 06 Jun 2024 21:57:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfe31a061a45a2cb@google.com>
Subject: [syzbot] [btrfs?] KMSAN: uninit-value in deflate_fast
From: syzbot <syzbot+1d896c57cf020d5e4151@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1736345a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=1d896c57cf020d5e4151
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d896c57cf020d5e4151@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in deflate_fast+0xfe1/0x2f70 lib/zlib_deflate/deflate.c:949
 deflate_fast+0xfe1/0x2f70 lib/zlib_deflate/deflate.c:949
 zlib_deflate+0x1d14/0x2920 lib/zlib_deflate/deflate.c:410
 zlib_compress_pages+0xd89/0x2020 fs/btrfs/zlib.c:178
 compression_compress_pages fs/btrfs/compression.c:99 [inline]
 btrfs_compress_pages+0x2aa/0x460 fs/btrfs/compression.c:1010
 compress_file_range+0xf50/0x25d0 fs/btrfs/inode.c:948
 btrfs_work_helper+0x52f/0x18d0 fs/btrfs/async-thread.c:314
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 read_buf lib/zlib_deflate/deflate.c:520 [inline]
 fill_window+0x2073/0x2600 lib/zlib_deflate/deflate.c:816
 deflate_fast+0x1a9/0x2f70 lib/zlib_deflate/deflate.c:938
 zlib_deflate+0x1d14/0x2920 lib/zlib_deflate/deflate.c:410
 zlib_compress_pages+0xd89/0x2020 fs/btrfs/zlib.c:178
 compression_compress_pages fs/btrfs/compression.c:99 [inline]
 btrfs_compress_pages+0x2aa/0x460 fs/btrfs/compression.c:1010
 compress_file_range+0xf50/0x25d0 fs/btrfs/inode.c:948
 btrfs_work_helper+0x52f/0x18d0 fs/btrfs/async-thread.c:314
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:122 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 copy_page_from_iter_atomic+0x12b7/0x2ae0 lib/iov_iter.c:481
 btrfs_copy_from_user+0x176/0x4c0 fs/btrfs/file.c:59
 btrfs_buffered_write+0x119a/0x2ab0 fs/btrfs/file.c:1339
 btrfs_do_write_iter+0x395/0x2270 fs/btrfs/file.c:1688
 btrfs_file_write_iter+0x38/0x50 fs/btrfs/file.c:1705
 __kernel_write_iter+0x64d/0xc80 fs/read_write.c:523
 dump_emit_page fs/coredump.c:895 [inline]
 dump_user_range+0x8dc/0xee0 fs/coredump.c:956
 elf_core_dump+0x57c7/0x5ae0 fs/binfmt_elf.c:2083
 do_coredump+0x32d5/0x4920 fs/coredump.c:769
 get_signal+0x267e/0x2d00 kernel/signal.c:2896
 arch_do_signal_or_restart+0x53/0xcb0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x5d/0x160 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x1e0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
 dump_user_range+0x4a/0xee0 fs/coredump.c:940
 elf_core_dump+0x57c7/0x5ae0 fs/binfmt_elf.c:2083
 do_coredump+0x32d5/0x4920 fs/coredump.c:769
 get_signal+0x267e/0x2d00 kernel/signal.c:2896
 arch_do_signal_or_restart+0x53/0xcb0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x5d/0x160 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x1e0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 4424 Comm: kworker/u8:28 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: btrfs-delalloc btrfs_work_helper
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

