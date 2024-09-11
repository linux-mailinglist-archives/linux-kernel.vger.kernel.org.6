Return-Path: <linux-kernel+bounces-325113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B001975527
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E247B21C20
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EBB19DFA2;
	Wed, 11 Sep 2024 14:21:37 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D82187336
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064497; cv=none; b=AcvJYFFCTEFiirhv2JRqFK5n6N43UO3hDVvstH/WKWxcMcIs8CYNLSvy8VWgpnNdUCHIpX6K4Kj4aARbRjhEJJ0Tgr6vkU3Ilg2pHB+nN74fA0HGWggwyrGcvsgDC7y4rgwAlsk9Px+bmgnWBMMR/7A8TNcsbZpMd+VtPd3Ipa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064497; c=relaxed/simple;
	bh=tPZtktx+8f9zv5An2qSQ7m8UFB5W1VItbVFAn9pQ8Z4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z2Tiqiv1tDRHkcLyc0F2fNlAEmE3JTEFfVcscafTn+s75rA/sWjxjelHxx84sVGsLEI8Di7aEUCrTHF6c+G3p0PdGJhiCdvHXVGmOBTjTJ1Q8J46Blbow4YCzy7AI47+9o7/VBPg8EYPe3CBh3H8BNY0KWWM/ucg+43AmUeAETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f4e119c57so23810975ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064494; x=1726669294;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/+Iifr0WVaTw0ZZK++J2Xkn62aEoOLQ32PE+LD7CCw=;
        b=kPWqyvugq6XVMp6sY2STwzlm1Vh2tnCgmeFm3iWesPkLcqC2cXP1hAEtY2P37WB2YW
         012pKXue6QJ2432F6VbvS42nAxQlWBnh+SA8hfrip8fZ731QwVGJxjq3tg61gAaV5JPK
         sp6Mp7ex1hJZm0fANJ6C3PSUD9p/WiWKb3Sr/Ub/quSEQhJoCNumWOPYrE2s34NFrbXw
         MPTMaY+o6FXO+Mg6LtQMejanr7qlGzTFQ7869fN0P3YyphVi1ymszj6qcktuWy4tib1w
         X5+z2kiS+s/9AvrgBo/JIrZ8CZ9GeL6gFNXZejLzd3BZSaSkZYVS1SF/EQ7JFt70HB+M
         MARA==
X-Forwarded-Encrypted: i=1; AJvYcCUM5g9CDN1GutqZos6I3GjjqCFzil7hMQxmMw7uzygCJiBRprolLyIyPHJv8lR3rqCsj3EMbyGNxJzt8bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVTxwsdcp0ZJOrsXU0pf9aBUHDzRp/NwcvZZwNgXIYoMzVTWa
	h/yb9YuKEKHQDVxejXNkS6suaihRT2E4Wxnd9pTVbq1krE9sCpiYgcoxUvRCTjffiGpDm6UfVdy
	BMzFENSbL7KzjaV9TzHCsNNLWvwp2cujAuDACK8Ce+9rhlQuEpmEsJOg=
X-Google-Smtp-Source: AGHT+IE8raWptSauVzlt3vXWps/FepFM5SZqEGTmzuvQCtwU8wuWUD91thsiCxU6fvoUgOfgxIITsIn+nK8je8Y7hIvHlJ8gZ+3k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d12:b0:3a0:4eef:8e17 with SMTP id
 e9e14a558f8ab-3a07422fb7dmr32285325ab.11.1726064494452; Wed, 11 Sep 2024
 07:21:34 -0700 (PDT)
Date: Wed, 11 Sep 2024 07:21:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d35070621d8b525@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in mnt_want_write (4)
From: syzbot <syzbot+8dcad7af57014dff2591@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b31c44928842 Merge tag 'linux_kselftest-kunit-fixes-6.11-r..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1308189f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc7fa3453562e8b
dashboard link: https://syzkaller.appspot.com/bug?extid=8dcad7af57014dff2591
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f2afb4b42efc/disk-b31c4492.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/756a492884c9/vmlinux-b31c4492.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1506f34ecf8a/bzImage-b31c4492.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8dcad7af57014dff2591@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc6-syzkaller-00308-gb31c44928842 #0 Not tainted
------------------------------------------------------
syz.0.571/10510 is trying to acquire lock:
ffff888065736420 (sb_writers#5){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515

but task is already holding lock:
ffff88805de73b38 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock include/linux/fs.h:800 [inline]
ffff88805de73b38 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: open_last_lookups fs/namei.c:3644 [inline]
ffff88805de73b38 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: path_openat+0x7fb/0x3470 fs/namei.c:3883

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       inode_lock_shared include/linux/fs.h:810 [inline]
       lookup_slow+0x45/0x70 fs/namei.c:1734
       walk_component+0x2e1/0x410 fs/namei.c:2039
       lookup_last fs/namei.c:2542 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2566
       filename_lookup+0x256/0x610 fs/namei.c:2595
       kern_path+0x35/0x50 fs/namei.c:2703
       lookup_bdev+0xc5/0x290 block/bdev.c:1157
       resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
       kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa72/0xc90 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&of->mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
       traverse+0x14f/0x550 fs/seq_file.c:106
       seq_read_iter+0xc5e/0xd60 fs/seq_file.c:195
       copy_splice_read+0x662/0xb60 fs/splice.c:365
       do_splice_read fs/splice.c:985 [inline]
       splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
       do_sendfile+0x515/0xe20 fs/read_write.c:1301
       __do_sys_sendfile64 fs/read_write.c:1362 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&p->lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
       copy_splice_read+0x662/0xb60 fs/splice.c:365
       do_splice_read fs/splice.c:985 [inline]
       splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
       do_sendfile+0x515/0xe20 fs/read_write.c:1301
       __do_sys_sendfile64 fs/read_write.c:1362 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&pipe->mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       iter_file_splice_write+0x335/0x14e0 fs/splice.c:687
       do_splice_from fs/splice.c:941 [inline]
       do_splice+0xd77/0x1900 fs/splice.c:1354
       __do_splice fs/splice.c:1436 [inline]
       __do_sys_splice fs/splice.c:1652 [inline]
       __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_writers#5
){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1676 [inline]
       sb_start_write+0x4d/0x1c0 include/linux/fs.h:1812
       mnt_want_write+0x3f/0x90 fs/namespace.c:515
       ovl_create_object+0x13b/0x370 fs/overlayfs/dir.c:642
       lookup_open fs/namei.c:3578 [inline]
       open_last_lookups fs/namei.c:3647 [inline]
       path_openat+0x1a9a/0x3470 fs/namei.c:3883
       do_filp_open+0x235/0x490 fs/namei.c:3913
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
       do_sys_open fs/open.c:1431 [inline]
       __do_sys_creat fs/open.c:1507 [inline]
       __se_sys_creat fs/open.c:1501 [inline]
       __x64_sys_creat+0x123/0x170 fs/open.c:1501
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sb_writers#5 --> &of->mutex --> &ovl_i_mutex_dir_key[depth]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ovl_i_mutex_dir_key[depth]);
                               lock(&of->mutex);
                               lock(&ovl_i_mutex_dir_key[depth]);
  rlock(sb_writers#5);

 *** DEADLOCK ***

2 locks held by syz.0.571/10510:
 #0: 
ffff888023f38420 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88805de73b38 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock include/linux/fs.h:800 [inline]
 #1: ffff88805de73b38 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: open_last_lookups fs/namei.c:3644 [inline]
 #1: ffff88805de73b38 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: path_openat+0x7fb/0x3470 fs/namei.c:3883

stack backtrace:
CPU: 0 UID: 0 PID: 10510 Comm: syz.0.571 Not tainted 6.11.0-rc6-syzkaller-00308-gb31c44928842 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
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
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1676 [inline]
 sb_start_write+0x4d/0x1c0 include/linux/fs.h:1812
 mnt_want_write+0x3f/0x90 fs/namespace.c:515
 ovl_create_object+0x13b/0x370 fs/overlayfs/dir.c:642
 lookup_open fs/namei.c:3578 [inline]
 open_last_lookups fs/namei.c:3647 [inline]
 path_openat+0x1a9a/0x3470 fs/namei.c:3883
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_creat fs/open.c:1507 [inline]
 __se_sys_creat fs/open.c:1501 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1501
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb30f77cef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb3104d6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fb30f936058 RCX: 00007fb30f77cef9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007fb30f7ef046 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb30f936058 R15: 00007fffff90dd88
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

