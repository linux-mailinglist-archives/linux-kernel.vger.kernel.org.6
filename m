Return-Path: <linux-kernel+bounces-401427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4229C1A51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D0C1F23638
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C711E32A2;
	Fri,  8 Nov 2024 10:18:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2991DED5A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731061104; cv=none; b=Hft4G6hoojKmGQip+9vNnunkeq3phd6IM4x7pCnMmZvbM9f0g6VRaains631E2zT+o0TY3LFrXAWX5qbOFzYH0Fz00FbWDlqvoLnopFCbpRSg1KtUI4hWBf5LPvNgGm9uZmrTDqY0Xu8PyK4bGJ9exN38iN73wLlWxS/X76AQ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731061104; c=relaxed/simple;
	bh=04KvrC6HdKcsCv1AkSLtJChq0NNBGE848WPtHbR2TJQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ixz7QyXkK/LNso3I3O63FIDniJOov+q8hOaYfvTZerN/jGb4/HJgwWHXyGT0L6+RfUd/g9L/XYSBledoXNEkTqX7ZLyjsdKPdihI+484nqO8j/y3lU881wd8qXUq+5aI5oFPwlllD5aCUWX/M8CDzPd/4UDcXUUroXPMaR4MS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6f3a08573so4631855ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 02:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731061101; x=1731665901;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YL5xe0P89IfOqHVhWaiV91dgxUHxAPg1BtgDYrQr5F0=;
        b=OdmLD5FfkZ/KKEy0Gu4kVMXwDGXT6Oh649sTN7Y9QdWOX/gp9Tq+FHzFyyyOfrKFCY
         ftgUKujW4TUH2V4BEvcsKz7C+9sSc2WUd9CMm8nanp6PQCcYaJwLoPMChhxrKBPJi0yG
         YHx2Xm+7J1z3ESByJGivsNne7LpMS/yPI0uFxztreaAMpdLF1XDTBwh8m0hqdh7hVS/l
         do/JSDk/eHXK2UWoPpm+/AecRJfjJ0PK3BFZlmkBR3Kx81/cmWo7YAVMebMJNgvI6LWx
         pNzicBqxT0nYVDscelMOTev2SR4cOcGu8wFFxfFJ3JwaT2pedol93Dg7mQl0VWpaRmTu
         9XaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvbwKUZVieV16IFobVvc1BVhD/YBFET6fjRQJfAnfL3K3rUBtwF7CDDJZ6t0yFbRcfCVgu3td0Q83vnJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJa3cbA0r9fkTbYIkp0wqY4fAckuqlvL1iLbyE/FE25YorYwTY
	vgH90+5YVyDegWBKTSKozLz/vUlj7KV3oSQ8+57tT0W9epo9wF+d+MbWh2dkiBKSqVnhwTiEqkt
	rCrj+ZGCgOM/EePreq3O465f0oRiY+MIol6OlpSJN5BY+rFFzxskBtQc=
X-Google-Smtp-Source: AGHT+IFbHP7FrN4B2mMjVS3CUHuSi4dNVZvriUIZAXfl03xqRnKFVCBL+MTK5EPJ5+3ODAxc5J/CpIZEqawxjpQ9h7hrXZ9dfPIK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e4:b0:3a6:c472:765e with SMTP id
 e9e14a558f8ab-3a6f19c9f3bmr30555405ab.11.1731061101487; Fri, 08 Nov 2024
 02:18:21 -0800 (PST)
Date: Fri, 08 Nov 2024 02:18:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672de56d.050a0220.69fce.000d.GAE@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in __kernfs_remove (2)
From: syzbot <syzbot+aa419d82b68e6a7e96c5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    59b723cd2adb Linux 6.12-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1035f630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
dashboard link: https://syzkaller.appspot.com/bug?extid=aa419d82b68e6a7e96c5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101e46a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149aad5f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-59b723cd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b98f620edf1/vmlinux-59b723cd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b5d1377ba568/bzImage-59b723cd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6387bac8a9c0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa419d82b68e6a7e96c5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc6-syzkaller #0 Not tainted
------------------------------------------------------
udevd/5325 is trying to acquire lock:
ffff88804002c1e8 (kn->active#5){++++}-{0:0}, at: __kernfs_remove+0x400/0x870 fs/kernfs/dir.c:1486

but task is already holding lock:
ffff88801f9de4c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_release+0x17e/0x700 block/bdev.c:1087

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&disk->open_mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       bdev_open+0xf0/0xc50 block/bdev.c:904
       bdev_file_open_by_dev+0x1b0/0x220 block/bdev.c:1018
       disk_scan_partitions+0x1be/0x2b0 block/genhd.c:367
       device_add_disk+0xd02/0x1000 block/genhd.c:510
       pmem_attach_disk+0xdf7/0x10e0 drivers/nvdimm/pmem.c:576
       nvdimm_bus_probe+0x147/0x4e0 drivers/nvdimm/bus.c:94
       really_probe+0x2b8/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
       bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:370
       bus_add_driver+0x346/0x670 drivers/base/bus.c:675
       driver_register+0x23a/0x320 drivers/base/driver.c:246
       do_one_initcall+0x248/0x880 init/main.c:1269
       do_initcall_level+0x157/0x210 init/main.c:1331
       do_initcalls+0x3f/0x80 init/main.c:1347
       kernel_init_freeable+0x435/0x5d0 init/main.c:1580
       kernel_init+0x1d/0x2b0 init/main.c:1469
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (&nvdimm_namespace_key){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       device_lock include/linux/device.h:1014 [inline]
       uevent_show+0x17d/0x340 drivers/base/core.c:2736
       dev_attr_show+0x55/0xc0 drivers/base/core.c:2430
       sysfs_kf_seq_show+0x331/0x4c0 fs/sysfs/file.c:59
       seq_read_iter+0x43f/0xd70 fs/seq_file.c:230
       new_sync_read fs/read_write.c:488 [inline]
       vfs_read+0x991/0xb70 fs/read_write.c:569
       ksys_read+0x183/0x2b0 fs/read_write.c:712
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (kn->active#5){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       kernfs_drain+0x31c/0x6d0 fs/kernfs/dir.c:500
       __kernfs_remove+0x400/0x870 fs/kernfs/dir.c:1486
       kernfs_remove_by_name_ns+0xdc/0x160 fs/kernfs/dir.c:1694
       sysfs_remove_file include/linux/sysfs.h:773 [inline]
       device_remove_file drivers/base/core.c:3054 [inline]
       device_del+0x56a/0x9b0 drivers/base/core.c:3859
       drop_partition+0x11b/0x180 block/partitions/core.c:273
       bdev_disk_changed+0x2bf/0x13f0 block/partitions/core.c:666
       __loop_clr_fd drivers/block/loop.c:1182 [inline]
       lo_release+0x53e/0x850 drivers/block/loop.c:1739
       bdev_release+0x5dd/0x700
       blkdev_release+0x15/0x20 block/fops.c:639
       __fput+0x23f/0x880 fs/file_table.c:431
       __do_sys_close fs/open.c:1567 [inline]
       __se_sys_close fs/open.c:1552 [inline]
       __x64_sys_close+0x7f/0x110 fs/open.c:1552
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  kn->active#5 --> &nvdimm_namespace_key --> &disk->open_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&disk->open_mutex);
                               lock(&nvdimm_namespace_key);
                               lock(&disk->open_mutex);
  lock(kn->active#5);

 *** DEADLOCK ***

1 lock held by udevd/5325:
 #0: ffff88801f9de4c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_release+0x17e/0x700 block/bdev.c:1087

stack backtrace:
CPU: 0 UID: 0 PID: 5325 Comm: udevd Not tainted 6.12.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 kernfs_drain+0x31c/0x6d0 fs/kernfs/dir.c:500
 __kernfs_remove+0x400/0x870 fs/kernfs/dir.c:1486
 kernfs_remove_by_name_ns+0xdc/0x160 fs/kernfs/dir.c:1694
 sysfs_remove_file include/linux/sysfs.h:773 [inline]
 device_remove_file drivers/base/core.c:3054 [inline]
 device_del+0x56a/0x9b0 drivers/base/core.c:3859
 drop_partition+0x11b/0x180 block/partitions/core.c:273
 bdev_disk_changed+0x2bf/0x13f0 block/partitions/core.c:666
 __loop_clr_fd drivers/block/loop.c:1182 [inline]
 lo_release+0x53e/0x850 drivers/block/loop.c:1739
 bdev_release+0x5dd/0x700
 blkdev_release+0x15/0x20 block/fops.c:639
 __fput+0x23f/0x880 fs/file_table.c:431
 __do_sys_close fs/open.c:1567 [inline]
 __se_sys_close fs/open.c:1552 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1552
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f31211170a8
Code: 48 8b 05 83 9d 0d 00 64 c7 00 16 00 00 00 83 c8 ff 48 83 c4 20 5b c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 5b 48 8b 15 51 9d 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fffbff72f28 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007f31215610e0 RCX: 00007f31211170a8
RDX: 000055bb50865e1f RSI: 00007fffbff72728 RDI: 0000000000000008
RBP: 000055be0b666270 R08: 0000000000000006 R09: e96079c9d5837796
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000002
R13: 000055be0b65a9a0 R14: 0000000000000008 R15: 000055be0b648910
 </TASK>
 loop0: p1 p2 p3
block device autoloading is deprecated and will be removed.
udevd[5325]: inotify_add_watch(7, /dev/loop0p1, 10) failed: No such file or directory
udevd[5325]: inotify_add_watch(7, /dev/loop0p1, 10) failed: No such file or directory
udevd[5325]: inotify_add_watch(7, /dev/loop0p1, 10) failed: No such file or directory
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
udevd[5325]: inotify_add_watch(7, /dev/loop0p1, 10) failed: No such file or directory
udevd[5325]: inotify_add_watch(7, /dev/loop0p1, 10) failed: No such file or directory
udevd[5325]: inotify_add_watch(7, /dev/loop0p1, 10) failed: No such file or directory
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3
 loop0: p1 p2 p3


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

