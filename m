Return-Path: <linux-kernel+bounces-362199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5164F99B204
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05525B22389
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5EA1448F2;
	Sat, 12 Oct 2024 08:11:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362FA137742
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728720665; cv=none; b=qf0ICO++FiQKvbArHUWlj3Crmp86LZe5qY0sR5ms9u8rwpr+YmnTf8/B1tKw7GOMMjdEqH76aLNA/Olug4sp31oPi/Ob/ANK/eOE9A+DgC2Dt8tltARzzMed9QG+WSp3tGbl/yybMnTqh6N8EzJxKFysQy1A9ybrCMS/cWouRSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728720665; c=relaxed/simple;
	bh=/dllHqrZTYD3yejPCAAu/Ac7uluspkIUMl6XfrUvcak=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HQhsQoac8vWBrDHpaAnlLoht1YPU7iphH6LYSLFYR+H/SrH0MaR8iwtpM8Q2aaKTyyFMW7R5QG83d7ZhPSbgdS2TyJMrOpRAz3gJoU0CXyv7xwfEu7GYgRXMapfeFRMX6uI5pb9jmu7iaIFmW7kuSJL2mlas0eQYi93E6JOcYSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1925177fdso28328025ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 01:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728720663; x=1729325463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEP6NJUvvmvmEaBBgxxq0Jt0JemSwvb6ZaKtPtBgP0w=;
        b=wpNPqlwhNDjbY/FNrsDsAEquBu5RIWzsCMKvpVcrDwQOa4hzZ2NpoP8Dv+7//t5SQR
         mrcvJ7TZ0H+tGFT+LbtLHC+B1HOrAfvQrAyLW5eKg2QhhP1h2TlX0Sm+L9odyHej+i0V
         BXeiy9iKmRhTWwPmZdB3n1Z7aoLY1RxCVbljC4zyyCfr7BoBw+ySe/DxkgY92RglIbg1
         Vsm9zB9ion4HjpGxtUyXqcXYoYoQtyPA52tLrw8OoGj/tQ+GnLWbXz0Xsv1rPB3htSDt
         LBWEJUSpTPwpRobwtOPQ6dlRy0SiGOc5jcSHqmqG+OF5f5NkkS5DN/2WViuEHYnGtNPo
         sx/A==
X-Gm-Message-State: AOJu0YyRjChHTq18KP13cpucTnXPJXnvgHzneAAmIMyYhfJfwufUz1FO
	mMVzKAwgZo/e1u15ZqwO+bvJoh2DbOBE9BCmc4V1DLM47iauFHyIz9O9+76+E4KzFbcjoHtgFlv
	zYubcAEQP2ISKh+FZXd8Ylr47zfCjxnuTOfKxJywslWX86P/wpKwgQpg=
X-Google-Smtp-Source: AGHT+IEgRfk1PMYa3QTnbBEWPDmtLBNW36GFNA3JrxIVaXjC0h1G0MfEgNoHtqa2+IpA+M0wYYBqguL92+hDiNW5HUkCGpuvNF1v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:3a3:4175:79d2 with SMTP id
 e9e14a558f8ab-3a3b5f7c8f4mr50901525ab.14.1728720663385; Sat, 12 Oct 2024
 01:11:03 -0700 (PDT)
Date: Sat, 12 Oct 2024 01:11:03 -0700
In-Reply-To: <CAHiZj8jjsotVt8gShhM3K+Bq0ytXXx89zFzrjjB+RGZXe_zEeQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670a2f17.050a0220.3e960.0021.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in __exfat_get_dentry_set

loop0: detected capacity change from 0 to 256
exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0x726052d3, utbl_chksum : 0xe619d30d)
=====================================================
BUG: KMSAN: uninit-value in __exfat_get_dentry_set+0x10db/0x14d0 fs/exfat/dir.c:805
 __exfat_get_dentry_set+0x10db/0x14d0 fs/exfat/dir.c:805
 exfat_get_dentry_set+0x58/0xec0 fs/exfat/dir.c:860
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
 loop_workfn+0x48/0x60 drivers/block/loop.c:1969
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
 loop_workfn+0x48/0x60 drivers/block/loop.c:1969
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4756
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

CPU: 0 UID: 0 PID: 5987 Comm: syz.0.15 Not tainted 6.12.0-rc2-syzkaller-00291-g09f6b0c8904b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


Tested on:

commit:         09f6b0c8 Merge tag 'linux_kselftest-fixes-6.12-rc3' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121adfd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=01218003be74b5e1213a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b2dfd0580000


