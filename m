Return-Path: <linux-kernel+bounces-363314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521FA99C07D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DF6B21F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3531459FD;
	Mon, 14 Oct 2024 06:57:26 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC5145346
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889045; cv=none; b=EdXQcKY3t+lP+J+7G1VRTCAuixQEDpym9AdHo+qgnUcRW6XSy+slZWeJuGfct4/pW/2MFErMIDaCcc2WNJcXYwfV/ay4vrdX2dUgPKkd6iBVuoRfgONCBC8HwN5Dsj2eH1YQ+DDCUAZFpGZ2TghqnRubq0hfsLc2GdyU6ESgGho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889045; c=relaxed/simple;
	bh=aiNkIG+l262QS4Nn6dXiq3WQjfmegRMEQuhxxcLXIgM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C4ecxKjl5dIc1LTitq8MxmHsPeUtsyFnFqVita4h3C0LUEbDXd4gbl7OQ+FS640OkzUApWyn2U/edrTSsThKn+1Dtl0SOcP99Fr0CWf94eY5YZH0hV87ygKfuCPrdg+Mo1B6hrsMxIIEjynlmsgsaVx86Pxt79SF4bbXRN1m76I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c5b90293so8805025ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728889043; x=1729493843;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhdDSiwG1x+TZlCmAe/V/V6LX90Zjz9ccxow5Rcow8A=;
        b=v3WHR0XDb84BK03uznIaOqmv1mEreEKl9k9185mhz3DpLv0+dQH3iTVqoAZDRtXs4g
         fYvbc+dd7oPActR8tr0efjZqN/X9d4UaLYkY5KcOlp7mgXnT/CRDs49qlRzgCI/23A99
         7Wms4oTnDwKL4V7GMo+ov6a7wG5C3zFkOSVVBnrBPuwKjLrQ3z4YiW55fIzjs46V1ZAJ
         sUlOvuwlGEePq4EFKL6/i4OtEoczxklHA7GNibCAdslaRZPZBLYGsb6N2lOx6g0DHGwu
         h4++iA8M4Y1bYN08Hglzuxf0N5DrD4y70fgKpLX3QgJKkcQlnsEefgOIteu2F3DVpW87
         MbLg==
X-Forwarded-Encrypted: i=1; AJvYcCXjX6ehV2pNOeu+BYcoP4k1DAp3k2IXEZQjgBGLxkWgBidtptowSEVRoHkjE70UOkujpKPb4Ft6W9TU2sY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+peGq9lTEgnKKpPU0uhuA0C73POA4Jsc0l0nPXoGy8QIqEna
	Uj8Vwae9pwbbpUweDBKejdxVYanDhMcdsdb+w1XcGMuybks7nJ/mtAVsO5Y1evJpX6hzo4nnCMG
	Ph0PjtecQwRmnSjcARr0ZkEzBhXojxJHIcqaWHr3L48OlNrFOIRKtwHI=
X-Google-Smtp-Source: AGHT+IHtVChGjj7e52cq/HQ53Pq+5uFRwRRkUB0JB636QyRDyNuGL7DBMFdNL/ak8L5RTg7oKY8MQA+eUL8/g8NyWHBnBhbPKoPr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:3a0:92e5:af68 with SMTP id
 e9e14a558f8ab-3a3b5f8c4b2mr76982215ab.15.1728889043193; Sun, 13 Oct 2024
 23:57:23 -0700 (PDT)
Date: Sun, 13 Oct 2024 23:57:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cc0d3.050a0220.4cbc0.0046.GAE@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in kernfs_fop_write_iter (2)
From: syzbot <syzbot+1cfd86253864f61b533e@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b983b271662b misc: sgi-gru: Don't disable preemption in GR..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d53780580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb6ea01107fa96bd
dashboard link: https://syzkaller.appspot.com/bug?extid=1cfd86253864f61b533e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-b983b271.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a81cb8020fb3/vmlinux-b983b271.xz
kernel image: https://storage.googleapis.com/syzbot-assets/912e503e8fb2/bzImage-b983b271.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1cfd86253864f61b533e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc2-syzkaller-00061-gb983b271662b #0 Not tainted
------------------------------------------------------
syz.1.1735/11566 is trying to acquire lock:
ffff8880336f9088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325

but task is already holding lock:
ffff888027fa3868 (&pipe->mutex){+.+.}-{3:3}, at: pipe_lock fs/pipe.c:92 [inline]
ffff888027fa3868 (&pipe->mutex){+.+.}-{3:3}, at: pipe_lock+0x64/0x80 fs/pipe.c:89

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&pipe->mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       pipe_lock fs/pipe.c:92 [inline]
       pipe_lock+0x64/0x80 fs/pipe.c:89
       iter_file_splice_write+0x1eb/0x10b0 fs/splice.c:687
       do_splice_from fs/splice.c:941 [inline]
       do_splice+0x145c/0x1f60 fs/splice.c:1354
       __do_splice+0x327/0x360 fs/splice.c:1436
       __do_sys_splice fs/splice.c:1652 [inline]
       __se_sys_splice fs/splice.c:1634 [inline]
       __x64_sys_splice+0x1cd/0x270 fs/splice.c:1634
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (sb_writers#6){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1716 [inline]
       sb_start_write include/linux/fs.h:1852 [inline]
       mnt_want_write+0x6f/0x450 fs/namespace.c:515
       ovl_create_object+0x12e/0x300 fs/overlayfs/dir.c:642
       lookup_open.isra.0+0x1174/0x14c0 fs/namei.c:3595
       open_last_lookups fs/namei.c:3694 [inline]
       path_openat+0x904/0x2d60 fs/namei.c:3930
       do_filp_open+0x1dc/0x430 fs/namei.c:3960
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
       do_sys_open fs/open.c:1430 [inline]
       __do_sys_creat fs/open.c:1506 [inline]
       __se_sys_creat fs/open.c:1500 [inline]
       __x64_sys_creat+0xcd/0x120 fs/open.c:1500
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
       inode_lock_shared include/linux/fs.h:825 [inline]
       lookup_slow fs/namei.c:1748 [inline]
       walk_component+0x342/0x5b0 fs/namei.c:2053
       lookup_last fs/namei.c:2556 [inline]
       path_lookupat+0x17f/0x770 fs/namei.c:2580
       filename_lookup+0x1e5/0x5b0 fs/namei.c:2609
       kern_path+0x35/0x50 fs/namei.c:2717
       lookup_bdev+0xd9/0x280 block/bdev.c:1164
       resume_store+0x1d8/0x460 kernel/power/hibernate.c:1239
       kobj_attr_store+0x55/0x80 lib/kobject.c:840
       sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:136
       kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:590 [inline]
       vfs_write+0x6b5/0x1140 fs/read_write.c:683
       ksys_write+0x12f/0x260 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&of->mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
       iter_file_splice_write+0x90f/0x10b0 fs/splice.c:743
       do_splice_from fs/splice.c:941 [inline]
       do_splice+0x145c/0x1f60 fs/splice.c:1354
       __do_splice+0x327/0x360 fs/splice.c:1436
       __do_sys_splice fs/splice.c:1652 [inline]
       __se_sys_splice fs/splice.c:1634 [inline]
       __x64_sys_splice+0x1cd/0x270 fs/splice.c:1634
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &of->mutex --> sb_writers#6 --> &pipe->mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&pipe->mutex);
                               lock(sb_writers#6);
                               lock(&pipe->mutex);
  lock(&of->mutex);

 *** DEADLOCK ***

2 locks held by syz.1.1735/11566:
 #0: ffff888029218420 (sb_writers#9){.+.+}-{0:0}, at: __do_splice+0x327/0x360 fs/splice.c:1436
 #1: ffff888027fa3868 (&pipe->mutex){+.+.}-{3:3}, at: pipe_lock fs/pipe.c:92 [inline]
 #1: ffff888027fa3868 (&pipe->mutex){+.+.}-{3:3}, at: pipe_lock+0x64/0x80 fs/pipe.c:89

stack backtrace:
CPU: 3 UID: 0 PID: 11566 Comm: syz.1.1735 Not tainted 6.12.0-rc2-syzkaller-00061-gb983b271662b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x41c/0x610 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 iter_file_splice_write+0x90f/0x10b0 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 do_splice+0x145c/0x1f60 fs/splice.c:1354
 __do_splice+0x327/0x360 fs/splice.c:1436
 __do_sys_splice fs/splice.c:1652 [inline]
 __se_sys_splice fs/splice.c:1634 [inline]
 __x64_sys_splice+0x1cd/0x270 fs/splice.c:1634
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2d5977dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2d5a4c5038 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007f2d59936058 RCX: 00007f2d5977dff9
RDX: 000000000000000f RSI: 0000000000000000 RDI: 000000000000000d
RBP: 00007f2d597f0296 R08: 000000000000bfd1 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f2d59936058 R15: 00007ffebf2e0bd8
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

