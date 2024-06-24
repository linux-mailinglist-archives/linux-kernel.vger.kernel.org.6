Return-Path: <linux-kernel+bounces-228086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD16915AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B431280F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E71E1A2561;
	Mon, 24 Jun 2024 23:41:30 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554917BA7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719272489; cv=none; b=ToojZd9jGqRN6UEy9XgD6JAwEbgf/ml5Lgg+uUgqorIvUBQJyJZBqZUtaxmIAJxc6yzZ9pSgfxem3wKZRv1BIjVqKpMTVWFjx2fTXfqs6sx6MR/aiNEBIDTC4l2WBEHY1SnGALwbSA23kGSA+IbFNPlsJCDcWI2jq6pCuNAngog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719272489; c=relaxed/simple;
	bh=9y1ubc429bTyTJpP04YEEVqAuqXJ2ifnMRP9fzfE0Tw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LNZkc5hTPDJL+2vPPT+gK2/BiJQh7r4wLSYHp+PRCzzIfBghwhTBhsj/fbpKJSSmpS75w/x5nlJnDPaEz5xo8QibIZYqWL1IbKRxzWm43AlhYNoPAxoEoewiv0dM+VQQXKxRuNtCKU264JK1arr0b7UBb89BlL8GwwCCSGnZRHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7ebea0e968eso700582639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719272486; x=1719877286;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbIr7bw+t35+4vmqfFfwhsAD6zcBCniVy7GqNQp6VmY=;
        b=pfmgF0YaoqeBK1agXMN2ebb0QMdB+N+qGuTbosCSvErrOY/nx48M73xGEPaIe5Bs9f
         3CeHiWB0jy4Q3KJ2WZp/nH+EF2vv6uh1ePFWGFwK0EGr59HCRjQJzb8NgBuIgyCM95un
         pzTCFzIOnfV04JgA42cPzWYykNbitSZmX380AvrXSNC8ThaRAypoY5QYw4WvWa9beoG8
         z6l1DyXtZNi5m71xL8YNvVMIcKctABS0MdqSQXvYcbDmBj9VbrgQOZhFxirGGT5h/SbL
         aqeb9s86hEALVpgwrTL+URXJ2749VhTXpwm8AfnsFIvHydNXsAnx13EzK6ywRJ9S/kN1
         IdEA==
X-Forwarded-Encrypted: i=1; AJvYcCVAWYWM2e4WkJvxEf+T2AyJtzBqs7I1cLGB2L6bwKjJlg82yJ0dGN3566lOhj4f96kKPSEdVuYQvygs0IuLaRphfpmjWJIhe7/url9j
X-Gm-Message-State: AOJu0YzzZfHOB7IRBiYky0TrKusAmfDpNAm83retFibsYxRkXWWkqnfX
	klnRGr1R9wN6q91kYJ5RXHluUdYQZIqUIXEpFd6Xmcm0ZSRqnP0XHywnYRtolXoj+bNxCJ3eXdK
	gnhw4QTymehLsGNSa5S39F4KHnECmOhQ6lI8Pl1HDH0bmpVWQhc62frA=
X-Google-Smtp-Source: AGHT+IH5wKEXvT/HITugUPbpWgjs1ahOdI5zOP44xd/fJBffpAKvl2OFIMJmqO+MNVH0T8WWKKGsh/eXC+38yOIfCvOFuZ5rbcLm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8906:b0:4b9:2bc3:46ba with SMTP id
 8926c6da1cb9f-4b9efc00420mr263967173.3.1719272485994; Mon, 24 Jun 2024
 16:41:25 -0700 (PDT)
Date: Mon, 24 Jun 2024 16:41:25 -0700
In-Reply-To: <0000000000007de4c3061ba8ca57@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cccfa2061bab512c@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in __kernfs_remove
From: syzbot <syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com>
To: a.sangwan@samsung.com, dan.j.williams@intel.com, dave.jiang@intel.com, 
	dirk.behme@de.bosch.com, gregkh@linuxfoundation.org, ira.weiny@intel.com, 
	linux-kernel@vger.kernel.org, namjae.jeon@samsung.com, 
	penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, vishal.l.verma@intel.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    626737a5791b Merge tag 'pinctrl-v6.10-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b594ae980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b9ee98d841760c
dashboard link: https://syzkaller.appspot.com/bug?extid=4762dd74e32532cda5ff
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f21cea980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c4963e980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-626737a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1cffeb16f347/vmlinux-626737a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b20910e32f0e/bzImage-626737a5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/67438b2787f0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com

Buffer I/O error on dev loop0p1, logical block 8, async page read
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc5-syzkaller-00012-g626737a5791b #0 Not tainted
------------------------------------------------------
udevd/5224 is trying to acquire lock:
ffff888029878a58 (kn->active#5){++++}-{0:0}, at: __kernfs_remove+0x281/0x670 fs/kernfs/dir.c:1486

but task is already holding lock:
ffff8880219b84c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0x41a/0xe50 block/bdev.c:897

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
       blkdev_get_whole+0x187/0x290 block/bdev.c:700
       bdev_open+0x2c7/0xe50 block/bdev.c:909
       blkdev_open+0x17b/0x1f0 block/fops.c:615
       do_dentry_open+0x910/0x1930 fs/open.c:955
       do_open fs/namei.c:3650 [inline]
       path_openat+0x1e3a/0x29f0 fs/namei.c:3807
       do_filp_open+0x1dc/0x430 fs/namei.c:3834
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1405
       do_sys_open fs/open.c:1420 [inline]
       __do_sys_openat fs/open.c:1436 [inline]
       __se_sys_openat fs/open.c:1431 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1431
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

1 lock held by udevd/5224:
 #0: ffff8880219b84c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0x41a/0xe50 block/bdev.c:897

stack backtrace:
CPU: 2 PID: 5224 Comm: udevd Not tainted 6.10.0-rc5-syzkaller-00012-g626737a5791b #0
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
 blkdev_get_whole+0x187/0x290 block/bdev.c:700
 bdev_open+0x2c7/0xe50 block/bdev.c:909
 blkdev_open+0x17b/0x1f0 block/fops.c:615
 do_dentry_open+0x910/0x1930 fs/open.c:955
 do_open fs/namei.c:3650 [inline]
 path_openat+0x1e3a/0x29f0 fs/namei.c:3807
 do_filp_open+0x1dc/0x430 fs/namei.c:3834
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc33c7979a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffc38f9eb40 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00005569ecaa5ab0 RCX: 00007fc33c7979a4
RDX: 00000000000a0800 RSI: 00005569eca8bfb0 RDI: 00000000ffffff9c
RBP: 00005569eca8bfb0 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 00005569ecaa7820 R14: 0000000000000001 R15: 00005569eca722c0
 </TASK>
blk_print_req_error: 53 callbacks suppressed
I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
udevd[5224]: inotify_add_watch(7, /dev/loop0p1, 10) failed: No such file or directory
udevd[5224]: inotify_add_watch(7, /dev/loop0p1, 10) failed: No such file or directory
I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
udevd[5224]: inotify_add_watch(7, /dev/loop0p1, 10) failed: No such file or directory
I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
udevd[5224]: inotify_add_watch(7, /dev/loop0p1, 10) failed: No such file or directory
I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
I/O error, dev loop0, sector 108 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
Buffer I/O error on dev loop0p1, logical block 8, async page read
udevd[5224]: inotify_add_watch(7, /dev/loop0p1, 10) failed: No such file or directory
blk_print_req_error: 138 callbacks suppressed
I/O error, dev loop0, sector 108 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
udevd[5224]: inotify_add_watch(7, /dev/loop0p1, 10) failed: No such file or directory
udevd[5224]: inotify_add_watch(7, /dev/loop0p1, 10) failed: No such file or directory


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

