Return-Path: <linux-kernel+bounces-215994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2696A9099B8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 21:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9932829EB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C5B27442;
	Sat, 15 Jun 2024 19:43:20 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA36861FC3
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718480600; cv=none; b=THf7DH5hoB51R6fxfzwlADPi6iLwChO2wZfZbOQhdAyyuKps5MQxsCFNA7Ougfpj4Fp3Qjp2cRKajtvTxnYCwXaY9c430up4PImS5k9/8vMBSfAMDMBF+8NJC6I16ho+ZoVXjV/ly5g9R9B5qtPUwFpewWP3fAS+A/6NMB9RdjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718480600; c=relaxed/simple;
	bh=c6pOMN0SBvY/UZhCBHHqYwuAVyKrR30GSxBlwKk/OeE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eQoRL6Nb7jrZF3YhpgY73S/qh7bbz0kYSTLdGni+iytBEUV7/xAy6tyHNEK+yBOs/LgQW5D9EHdSRFjqDJ0dFZzvnOJn2GQugSOgT4kyPSwf32ApcR3sGv4uJnGDytg7PC7XgCokEGzvhLQPie3mHGL5MXc8BokW+ckUXNjZgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e91ad684e4so372315539f.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 12:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718480598; x=1719085398;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2k9+PA/DbbkrN8dmf4cZVGncJCQWsxaojMXNBQZYdZk=;
        b=EvfWg9IxdCE3K9FCwOSl7POUQeBXv+NG+Rj4XxH55CT+J61ZtmQrTaS81PtUN6Q97/
         LcT9VxJZ+12ebrZBRcQmuymCik6jyVMmkum5bFWcBnCnNOW4Rt+lbHzhG19vWY7XsFpv
         iD1vePx2TxGXOMUT7sESZ/cjOFOpF++LZmmnMxT957IL0gUcQaYdtB4JJbtVpFZQbkze
         1+L0yCJohdHQfXvOTAdV1X6Ke+GfgjJSLRTHcwRB54aTKWfsDnD++6TEcWNtZbcqHFL2
         Uqei5GT/8fCEsIzPQoCgc1rq9dIvpEEw02H7E81GYtyGhRNtFDH9q7betmQhFRtCoZ4J
         kC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNSw+BLacOVCtgTtPsz1PmC7bj1SD133tapc8y+FsM6Gfq/rVEMFOIlJ38njrQ5J/nrB8VHeEt2+wqQC0Byn88OzPGKncMlGckSw1w
X-Gm-Message-State: AOJu0YwiGPlZfPuGm8JoALeRg014rLVOBY7hhXcplxSaEKXMsQreg+yD
	CoJQ5wHGR1JMqPOvdiNqAHr8PDUhCLhnYyR7xjHQrpS4G/WaC4alBYoKFi36VA93/SBilnLyp9D
	/v21eneJdBJIOerwOqmTfBbjRLaGfogBrL4aaViVp29mPglsPXXGTbfA=
X-Google-Smtp-Source: AGHT+IEE+zQ6jRoRogixEwKQRl6ZJiIqwZVCx8V+lvnuxuOjj7QAVdQrq4qyBmcoEAA2DrjOoIz/KEk6hfAuYcfEwDM4vSpF1GM2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14c6:b0:4b9:32f8:574f with SMTP id
 8926c6da1cb9f-4b9640dbfcamr244847173.5.1718480597992; Sat, 15 Jun 2024
 12:43:17 -0700 (PDT)
Date: Sat, 15 Jun 2024 12:43:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098d783061af2f133@google.com>
Subject: [syzbot] [nilfs?] KMSAN: uninit-value in nilfs_add_checksums_on_logs (3)
From: syzbot <syzbot+206133fb2e7b32bba4be@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d26ada980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=206133fb2e7b32bba4be
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+206133fb2e7b32bba4be@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in crc32_body lib/crc32.c:110 [inline]
BUG: KMSAN: uninit-value in crc32_le_generic lib/crc32.c:179 [inline]
BUG: KMSAN: uninit-value in crc32_le_base+0x43c/0xd80 lib/crc32.c:197
 crc32_body lib/crc32.c:110 [inline]
 crc32_le_generic lib/crc32.c:179 [inline]
 crc32_le_base+0x43c/0xd80 lib/crc32.c:197
 nilfs_segbuf_fill_in_data_crc fs/nilfs2/segbuf.c:224 [inline]
 nilfs_add_checksums_on_logs+0xb80/0xe40 fs/nilfs2/segbuf.c:327
 nilfs_segctor_do_construct+0x9876/0xdeb0 fs/nilfs2/segment.c:2078
 nilfs_segctor_construct+0x1eb/0xe30 fs/nilfs2/segment.c:2381
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2489 [inline]
 nilfs_segctor_thread+0xc50/0x11e0 fs/nilfs2/segment.c:2573
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
 generic_perform_write+0x4c1/0xc60 mm/filemap.c:3982
 __generic_file_write_iter+0x20a/0x460 mm/filemap.c:4069
 generic_file_write_iter+0x103/0x5b0 mm/filemap.c:4095
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

CPU: 0 PID: 5368 Comm: segctord Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
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

