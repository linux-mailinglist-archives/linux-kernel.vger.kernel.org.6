Return-Path: <linux-kernel+bounces-390945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC8E9B8055
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914DE1C21D97
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F8D1BD51F;
	Thu, 31 Oct 2024 16:39:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3481BD4F1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392746; cv=none; b=b0GY+QbhRG5kPtycptBmmINsRkcHYP5HH8oHuUStVPXqp1ard6orCna4moJEPvC8eCo79hnSMhGR382qCBBV5RVHdFg0cGkI+0irEdSdupKbeDHyyx9YwWb57c4t32kc6Xi+tV4ScFkSW4BM2OMUCMXf2ksDdN6xFUa9mf8Tngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392746; c=relaxed/simple;
	bh=qIcJtBx7AC2Z99whdQ6UxJ6KJExhot2ie0Qb9lOeaw8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RHZ70KZ+vq1+VomFfJ/FC/XhWKeynHVZ0ZtgTFUfroknBSx1zMtaJTVVHDk1JCaXjGQCpywnZj4lAzqfP9WR8/NfhHHmbBwi7WRFxNkEDfk8P+IHQhd4AIHSXunqDDY4Jm1ki+YV1b0eVlkZ+gMm3G3CguOoou5aUMBQzKR3shI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso14294735ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730392743; x=1730997543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bl8Z3kujvKX53cjVt+X96WtZuZmXfaa7rZ+PsTBj2qw=;
        b=YyJ3wDZjZRfDIAtJlebw/FtryKgizM8MXASZ0rB1/h2K2g3HJKHlyTOUkum0VOfWYZ
         /hh6U6pQ/+xdmRB/RwpRdS7iCJvPLFGoc65gjSJLNbtApflokXoKeN+mCSnxj/Jkqlhc
         SnWUWDPMydhdgPSvHwDvDHiPTFV15Sm9NH54UU8GRdFptmwHBw9yg7EtByo4dtIGg1ol
         SYioJqgnb5o2h3TiEobaNRwB0WHR2KY5tOVw2xPrjnZdUIAhDXUeZdREowxFIkaW3PGJ
         UoI753f5ivwSV45NWkrIcwu/Vpt9KLrjKdEPguU5UQXR5n27YjTrbR1yhp5EZm5LkZw6
         4J4w==
X-Forwarded-Encrypted: i=1; AJvYcCX7Ml2XIepe/Qm+Ye/6SEhHHd1YgneLOZGf/E/vBbPY7ltlLG7LxqJ2r2vz/MitR51SagZ2qYA2VmiX4Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxZTgPAURYVRbxR4Q7BoLygfm/kbxB04n8/VbE5GR5Y7I+FCS
	ZT3rucq3RzU2imwnBgRBnPD4sHS1UCs+qqdf0gwszrhT2R1RK3UoARP0kDIXuy/dzqRt9EC/HHh
	0Mas6ICKon3MB1jyyGRgPshZ/FWGOLp7L+rmdUhwahUY7cotmnocxNKs=
X-Google-Smtp-Source: AGHT+IGVhiC2C3WyMeboY4rTlsmdsx4Qc/T+pVNtssG56JzlrnhHJlWhfWVdIWzU60AovKeHsCBiE3KC9QGEmu2h1mrMNmoP8P2x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:dacf:0:b0:3a6:afae:7539 with SMTP id
 e9e14a558f8ab-3a6afae77e5mr7154235ab.9.1730392742848; Thu, 31 Oct 2024
 09:39:02 -0700 (PDT)
Date: Thu, 31 Oct 2024 09:39:02 -0700
In-Reply-To: <tencent_63962A37B84AAC7481767167DE3C67373009@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6723b2a6.050a0220.35b515.0164.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KMSAN: kernel-infoleak in pipe_read
From: syzbot <syzbot+41ebd857f013384237a9@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: kernel-infoleak in pipe_read

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:30 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:300 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:328 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x2f3/0x2b30 lib/iov_iter.c:185
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:30 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:300 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0x2f3/0x2b30 lib/iov_iter.c:185
 copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362
 pipe_read+0x88c/0x21a0 fs/pipe.c:327
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0xcdf/0xf50 fs/read_write.c:569
 ksys_read+0x24f/0x4c0 fs/read_write.c:712
 __do_sys_read fs/read_write.c:722 [inline]
 __se_sys_read fs/read_write.c:720 [inline]
 __x64_sys_read+0x93/0xe0 fs/read_write.c:720
 x64_sys_call+0x3055/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:1
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_bvec include/linux/iov_iter.h:123 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0xe5a/0x2b30 lib/iov_iter.c:185
 copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362
 shmem_file_read_iter+0xa09/0x12b0 mm/shmem.c:3164
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
 copy_page_from_iter_atomic+0x1284/0x3090 lib/iov_iter.c:482
 copy_folio_from_iter_atomic include/linux/uio.h:201 [inline]
 generic_perform_write+0x8d1/0x1080 mm/filemap.c:4066
 shmem_file_write_iter+0x2ba/0x2f0 mm/shmem.c:3218
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

Bytes 0-1023 of 1024 are uninitialized
Memory access of size 1024 starts at ffff888039552400
Data copied to user address 000055558b7cbba0

CPU: 0 UID: 0 PID: 6309 Comm: syz-executor Not tainted 6.12.0-rc5-syzkaller-00063-g0fc810ae3ae1-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


Tested on:

commit:         0fc810ae x86/uaccess: Avoid barrier_nospec() in 64-bit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1028ae87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d4311df74eee96f
dashboard link: https://syzkaller.appspot.com/bug?extid=41ebd857f013384237a9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16fd2630580000


