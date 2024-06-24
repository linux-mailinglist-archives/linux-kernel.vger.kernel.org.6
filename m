Return-Path: <linux-kernel+bounces-227924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7499091581E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957E61C234DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE81A08B3;
	Mon, 24 Jun 2024 20:40:29 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D999D2233B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261628; cv=none; b=eAfhUwkdOG1HzMlP2h3xiJuuk2jQuocnr1HXjyWP6AzNInzlwIkxeGhwxHN7VAt0DYb6EHBzA//wGvY/T0iBygzrGbL8VLjyW6vkJc53cmvpQX04jluGzVxlj4szt8oxLHui+c+FyqHI3laWula/o3Jh6vdlsg5ejQmMqn1rw/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261628; c=relaxed/simple;
	bh=Mpc6RuIhtGq35kNV5kV5P0M+i7tcW7LuYRo4qPOeA/E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RLNKxT4tyq7Wo51nPts7i6lm62hEa0Uy/oSMnyHfOj3Xsl4UtdrCUyeeOmjCzqQNer/fp1+m6zaVhgJCwoMe+DC8WXwuaL9vsk7u5yMkZscHYF4Z7vhxyvaWeLjP75I6n56LkFjoPZjXNqdTT6OPiw0AvNnCOe5ZlqBFc4KQkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-375c4006a54so54319735ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719261626; x=1719866426;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70YXGsJtgMIoMe+GyrskY30yIVhNPq42YdNAujYuN1M=;
        b=lxd459AuRsWSoxiCCeLO5Uim3NRrLQUjsruV7N2jDkOTKqrV8mUL6RQ1rcKzyFzESv
         wGO757h/ZJZ4of1XJVBVJHjdTeYQFlXWgXBpvz1qxdXHzrOsmr7xMYWp0HEv6wReIAtk
         EEdx2+WjFziZIpDrEVUVF/pb58u9VO3jZOArbt7QdKw3adTFk3QGmikVuBOhbVMJ5qVP
         kkEDOZk0VHnRqub9p56seHbEhqGnO5Q7T3FRO9QRkIumvB8hmqgB5F1cv4+0zOW/3xyG
         HQkOiEbYqE7xdpUU29Ph3ndtHXDCj171jo98bD0svR75TrFEIAe9gRLUMXdw3mL6tkSy
         SzPA==
X-Forwarded-Encrypted: i=1; AJvYcCVmXfR0Nzfr6TXql8Keyn3Ab53o3SNeznmQa92N0PZgYHFukVjhu/AG2aIi1uYXH9LUjyNpjF+MwK38KOrCa5FNVLgS59mDLU53iioi
X-Gm-Message-State: AOJu0YzXtaHyC+BCCUGoA4cvuGwlYke10c33dG4o47WhNLe8/3XLnv46
	HH/MBGPaqsdggu+ldRknPitATGAiCgdBFntcUGlaPo2evajBOKjY4LhZ8gOG4ejTIFpMeBumAr0
	NSZSPLMUJyUiaVnjDwc4L3zwKjqK8GVTmpdCUibjoPFlzty9WwSM6L1c=
X-Google-Smtp-Source: AGHT+IEf5Jmlk7VKVyBK9NJXNjH6sIRCuRe47whvC2iNSgBMaxqfnUsNl903tTW3m3XtQ0rkrCg4iP094PvnjMtG2nS1CIEYWaxM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184f:b0:376:42a0:b2e7 with SMTP id
 e9e14a558f8ab-37642a0b586mr4453725ab.4.1719261625962; Mon, 24 Jun 2024
 13:40:25 -0700 (PDT)
Date: Mon, 24 Jun 2024 13:40:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007de4c3061ba8ca57@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in __kernfs_remove
From: syzbot <syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    626737a5791b Merge tag 'pinctrl-v6.10-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143a383e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b9ee98d841760c
dashboard link: https://syzkaller.appspot.com/bug?extid=4762dd74e32532cda5ff
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-626737a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1cffeb16f347/vmlinux-626737a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b20910e32f0e/bzImage-626737a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc5-syzkaller-00012-g626737a5791b #0 Not tainted
------------------------------------------------------
udevd/6164 is trying to acquire lock:
ffff88801d0ffe18 (kn->active#5){++++}-{0:0}, at: __kernfs_remove+0x281/0x670 fs/kernfs/dir.c:1486

but task is already holding lock:
ffff888022a504c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_release+0x166/0x6f0 block/bdev.c:1080

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       bdev_open+0x41a/0xe50 block/bdev.c:897
       bdev_file_open_by_dev block/bdev.c:1011 [inline]
       bdev_file_open_by_dev+0x17d/0x210 block/bdev.c:986
       disk_scan_partitions+0x1ed/0x320 block/genhd.c:367
       device_add_disk+0xe97/0x1250 block/genhd.c:510
       pmem_attach_disk+0x9fe/0x1400 drivers/nvdimm/pmem.c:578
       nd_pmem_probe+0x1a9/0x1f0 drivers/nvdimm/pmem.c:651
       nvdimm_bus_probe+0x169/0x5d0 drivers/nvdimm/bus.c:91
       call_driver_probe drivers/base/dd.c:578 [inline]
       really_probe+0x23e/0xa90 drivers/base/dd.c:656
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
       __driver_attach+0x283/0x580 drivers/base/dd.c:1214
       bus_for_each_dev+0x13c/0x1d0 drivers/base/bus.c:368
       bus_add_driver+0x2e9/0x690 drivers/base/bus.c:673
       driver_register+0x15c/0x4b0 drivers/base/driver.c:246
       __nd_driver_register+0x103/0x1a0 drivers/nvdimm/bus.c:619
       do_one_initcall+0x128/0x700 init/main.c:1267
       do_initcall_level init/main.c:1329 [inline]
       do_initcalls init/main.c:1345 [inline]
       do_basic_setup init/main.c:1364 [inline]
       kernel_init_freeable+0x69d/0xca0 init/main.c:1578
       kernel_init+0x1c/0x2b0 init/main.c:1467
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (&nvdimm_namespace_key){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       device_lock include/linux/device.h:1009 [inline]
       uevent_show+0x188/0x3b0 drivers/base/core.c:2743
       dev_attr_show+0x53/0xe0 drivers/base/core.c:2437
       sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
       seq_read_iter+0x4fa/0x12c0 fs/seq_file.c:230
       kernfs_fop_read_iter+0x41a/0x590 fs/kernfs/file.c:279
       new_sync_read fs/read_write.c:395 [inline]
       vfs_read+0x869/0xbd0 fs/read_write.c:476
       ksys_read+0x12f/0x260 fs/read_write.c:619
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (kn->active#5){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       kernfs_drain+0x48f/0x590 fs/kernfs/dir.c:500
       __kernfs_remove+0x281/0x670 fs/kernfs/dir.c:1486
       kernfs_remove_by_name_ns+0xb2/0x130 fs/kernfs/dir.c:1694
       sysfs_remove_file include/linux/sysfs.h:773 [inline]
       device_remove_file drivers/base/core.c:3061 [inline]
       device_remove_file drivers/base/core.c:3057 [inline]
       device_del+0x381/0x9f0 drivers/base/core.c:3866
       drop_partition+0x109/0x1c0 block/partitions/core.c:273
       bdev_disk_changed+0x24d/0x14f0 block/partitions/core.c:664
       __loop_clr_fd+0x392/0x850 drivers/block/loop.c:1208
       lo_release+0x188/0x1c0 drivers/block/loop.c:1758
       blkdev_put_whole+0xad/0xf0 block/bdev.c:673
       bdev_release+0x496/0x6f0 block/bdev.c:1096
       blkdev_release+0x15/0x20 block/fops.c:623
       __fput+0x408/0xbb0 fs/file_table.c:422
       __fput_sync+0x47/0x50 fs/file_table.c:507
       __do_sys_close fs/open.c:1555 [inline]
       __se_sys_close fs/open.c:1540 [inline]
       __x64_sys_close+0x86/0x100 fs/open.c:1540
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
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

1 lock held by udevd/6164:
 #0: ffff888022a504c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_release+0x166/0x6f0 block/bdev.c:1080

stack backtrace:
CPU: 1 PID: 6164 Comm: udevd Not tainted 6.10.0-rc5-syzkaller-00012-g626737a5791b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 kernfs_drain+0x48f/0x590 fs/kernfs/dir.c:500
 __kernfs_remove+0x281/0x670 fs/kernfs/dir.c:1486
 kernfs_remove_by_name_ns+0xb2/0x130 fs/kernfs/dir.c:1694
 sysfs_remove_file include/linux/sysfs.h:773 [inline]
 device_remove_file drivers/base/core.c:3061 [inline]
 device_remove_file drivers/base/core.c:3057 [inline]
 device_del+0x381/0x9f0 drivers/base/core.c:3866
 drop_partition+0x109/0x1c0 block/partitions/core.c:273
 bdev_disk_changed+0x24d/0x14f0 block/partitions/core.c:664
 __loop_clr_fd+0x392/0x850 drivers/block/loop.c:1208
 lo_release+0x188/0x1c0 drivers/block/loop.c:1758
 blkdev_put_whole+0xad/0xf0 block/bdev.c:673
 bdev_release+0x496/0x6f0 block/bdev.c:1096
 blkdev_release+0x15/0x20 block/fops.c:623
 __fput+0x408/0xbb0 fs/file_table.c:422
 __fput_sync+0x47/0x50 fs/file_table.c:507
 __do_sys_close fs/open.c:1555 [inline]
 __se_sys_close fs/open.c:1540 [inline]
 __x64_sys_close+0x86/0x100 fs/open.c:1540
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feede7170a8
Code: 48 8b 05 83 9d 0d 00 64 c7 00 16 00 00 00 83 c8 ff 48 83 c4 20 5b c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 5b 48 8b 15 51 9d 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffcb56bae78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007feedeab80e0 RCX: 00007feede7170a8
RDX: 000055e713b8acf1 RSI: 00007ffcb56ba678 RDI: 0000000000000008
RBP: 000055e24da11ce0 R08: 0000000000000006 R09: 7dad85b31cc777c1
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000002
R13: 000055e24da17d80 R14: 0000000000000008 R15: 000055e24d9c72c0
 </TASK>
udevd[6164]: inotify_add_watch(7, /dev/loop1p4, 10) failed: No such file or directory
I/O error, dev loop3, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0


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

