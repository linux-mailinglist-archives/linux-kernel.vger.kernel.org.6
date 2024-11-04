Return-Path: <linux-kernel+bounces-395346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A59BBCB1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900F41F23365
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DAB1CACD0;
	Mon,  4 Nov 2024 17:57:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3A1C9DDF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743046; cv=none; b=OG9jId0iD1isw1urH9XAKrIb+rgGURiaxvZJPggEATgPwSJF5g+LZUy1I4g+AjMEEYgbPDNyEKpc1LcVCokofZx5IefFjVjB81NMiU5tY9yoNtM7WKxhLfTy1g1BFv8k7ZHilcwBiPrcCKFb2kIPXhxwlfxv7souHqFvPeYLvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743046; c=relaxed/simple;
	bh=8MqcOyvUqUERJNr9N3HgiOykTgPsUbtfG/Pz+eYsU08=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ocDfTz3zWnK5cYWJkuwSj+/btX9bq/r/Cm6I9kcfDlIfx3L4g5Lb/UhRBCAq0FrcflGYQakq6DkjOKhmVI+1O8Td+d7lEGOcEL0MF5ALlJjSnohsjWawnvVOgyujRP3jku64jrlaDF9fhvuyMD00DQNWEL/HnboTw5VXIaYYFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b963ca02so30066225ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730743044; x=1731347844;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SsGk8Gig4Y5zUHSdkdJdpDHcldwzW4jJTryDo69039M=;
        b=MCXgc/HcmT6tFwuHKeyK7WlPDlWCv4sxOB+OJOFCHT8smD6ooNsPGTQ000eDLhKdLD
         D57Nx7VIk67iXkgLGAuHcRMuYfEqpLAxbR3DLFZq+93KPK64EgbVaAe8RYgMTjPEMHV0
         HA7O4vJSXACoWeU245IZ4BhJsu53rVnJLiDqlDryAhbV4wDveS2OcsVHUzTshlQyTW5J
         zuOWWtPet0sxnrrMi3Ug7xAc9K6XUvvLOp89bepR3YThKWIoouCbjPrL39UoFOS4oLHC
         6Q0uOsrvDhlCl/FG//2s2buCjpXEBVb7PLqWaQAT2UIV/A9PNE6eizJSgXjl/8gl+3b6
         s5pw==
X-Forwarded-Encrypted: i=1; AJvYcCXYzV5K30ypWYB8nOEpFKaQQHyebubzH6MB4eSEKOU+5fKVPQ7cATzGfOJQ2shWrHbZ28KwSPRYvqWOB+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx4+7TsopaSU4WXxN6FmfJ8xJ6gdyNfGm16ov5+l2TvlxJM1WP
	UR3dQ+hea+CvdULJiH23et5fbV76eryFJmuiYj8TDdCxzyoR6v4cLLOX2o7OHEXBcr9Uck7B6cz
	NvyUpe3oSEgH7S1riOh4CSwIahWfoIeqgfIjlcgfwvDFX6ESULNx7N04=
X-Google-Smtp-Source: AGHT+IHNm/r2jJ7YoHCyWynwqzaSkbCworUFibcJvDINc0u8mFnbnpz2YIkbO3+wvKR463Z5NmqsF0sqqMfejgJNLNwtdYa3o1ps
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c569:0:b0:3a5:dd45:ebe3 with SMTP id
 e9e14a558f8ab-3a617578c75mr159080565ab.26.1730743044139; Mon, 04 Nov 2024
 09:57:24 -0800 (PST)
Date: Mon, 04 Nov 2024 09:57:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67290b04.050a0220.2edce.14f8.GAE@google.com>
Subject: [syzbot] [udf?] possible deadlock in udf_free_blocks
From: syzbot <syzbot+d472c32c5dd4cd2fb5c5@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0fc810ae3ae1 x86/uaccess: Avoid barrier_nospec() in 64-bit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1106e55f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=d472c32c5dd4cd2fb5c5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0fc810ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/35cb2385689e/vmlinux-0fc810ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/32b7d90faa74/bzImage-0fc810ae.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d472c32c5dd4cd2fb5c5@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
UDF-fs: error (device loop0): udf_read_tagged: tag checksum failed, block 99: 0x27 != 0x4d
UDF-fs: error (device loop0): udf_read_tagged: tag checksum failed, block 160: 0xd2 != 0xd4
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
============================================
WARNING: possible recursive locking detected
6.12.0-rc5-syzkaller-00063-g0fc810ae3ae1 #0 Not tainted
--------------------------------------------
syz.0.0/5328 is trying to acquire lock:
ffff8880432e6128 (&sbi->s_alloc_mutex){+.+.}-{3:3}, at: udf_table_free_blocks fs/udf/balloc.c:375 [inline]
ffff8880432e6128 (&sbi->s_alloc_mutex){+.+.}-{3:3}, at: udf_free_blocks+0x9ff/0x2270 fs/udf/balloc.c:677

but task is already holding lock:
ffff8880432e6128 (&sbi->s_alloc_mutex){+.+.}-{3:3}, at: udf_table_prealloc_blocks fs/udf/balloc.c:516 [inline]
ffff8880432e6128 (&sbi->s_alloc_mutex){+.+.}-{3:3}, at: udf_prealloc_blocks+0x820/0x13d0 fs/udf/balloc.c:701

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&sbi->s_alloc_mutex);
  lock(&sbi->s_alloc_mutex);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz.0.0/5328:
 #0: ffff8880438b6420 (sb_writers#11){.+.+}-{0:0}, at: direct_splice_actor+0x49/0x220 fs/splice.c:1163
 #1: ffff888043f24f60 (&sb->s_type->i_mutex_key#19){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff888043f24f60 (&sb->s_type->i_mutex_key#19){+.+.}-{3:3}, at: udf_file_write_iter+0x6f/0x660 fs/udf/file.c:95
 #2: ffff888043f24d90 (&ei->i_data_sem#2){++++}-{3:3}, at: udf_map_block+0x3b7/0x5340 fs/udf/inode.c:439
 #3: ffff8880432e6128 (&sbi->s_alloc_mutex){+.+.}-{3:3}, at: udf_table_prealloc_blocks fs/udf/balloc.c:516 [inline]
 #3: ffff8880432e6128 (&sbi->s_alloc_mutex){+.+.}-{3:3}, at: udf_prealloc_blocks+0x820/0x13d0 fs/udf/balloc.c:701

stack backtrace:
CPU: 0 UID: 0 PID: 5328 Comm: syz.0.0 Not tainted 6.12.0-rc5-syzkaller-00063-g0fc810ae3ae1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 udf_table_free_blocks fs/udf/balloc.c:375 [inline]
 udf_free_blocks+0x9ff/0x2270 fs/udf/balloc.c:677
 udf_delete_aext+0x70a/0xed0 fs/udf/inode.c:2372
 udf_table_prealloc_blocks fs/udf/balloc.c:543 [inline]
 udf_prealloc_blocks+0xf2b/0x13d0 fs/udf/balloc.c:701
 udf_prealloc_extents fs/udf/inode.c:1052 [inline]
 inode_getblk fs/udf/inode.c:910 [inline]
 udf_map_block+0x284a/0x5340 fs/udf/inode.c:447
 __udf_get_block+0x126/0x410 fs/udf/inode.c:461
 __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2121
 block_write_begin+0x8f/0x120 fs/buffer.c:2231
 udf_write_begin+0x104/0x350 fs/udf/inode.c:256
 generic_perform_write+0x344/0x6d0 mm/filemap.c:4054
 __generic_file_write_iter+0x1b5/0x230 mm/filemap.c:4152
 udf_file_write_iter+0x2fc/0x660 fs/udf/file.c:111
 iter_file_splice_write+0xbfa/0x1510 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11b/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1233
 do_sendfile+0x561/0xe10 fs/read_write.c:1388
 __do_sys_sendfile64 fs/read_write.c:1455 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe35557e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe35644a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fe355735f80 RCX: 00007fe35557e719
RDX: 0000000000000000 RSI: 000000000000000a RDI: 000000000000000a
RBP: 00007fe3555f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000800000009 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe355735f80 R15: 00007ffcceb987c8
 </TASK>


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

