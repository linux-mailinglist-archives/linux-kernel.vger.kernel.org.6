Return-Path: <linux-kernel+bounces-419097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CDC9D6979
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 15:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D774B21BBF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBEE27466;
	Sat, 23 Nov 2024 14:42:27 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226C6566A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732372946; cv=none; b=MZ+Q57yGkloZ22FEiTh24W3PU1kC5HsBB7ZjI75uF5FxyDcSFq9CooK+xxnPWizR0N7fv0/Eub/zqqeZA+ArHikADI3ROoHhpvBr+dvCu9//KaKLvcey3Z7Akzwretevw+M+73ntek+5717Du3EQAonyHPvshlsykPyYEBra9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732372946; c=relaxed/simple;
	bh=m1ukp/mH0jgowhPxHHcWZP7SP4ldWd7ElzjnMfWXgNU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UBf8+IbShtfhxELV0VeDjsyp7Qu8gqjP+A2Ds9cqrdPL5Y6pDfmjbXhpo9IXhu5jpst1kmv4Qs1t91/yPSMGvHhONmtNL5oaW/fpYZSkqP98JUenyzBPmRtWONv3xEL1uSiY9koo2p/kSxC7oMjKATJRe2nNp43BvWqXoeVWHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83b6628a71fso339870339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 06:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732372944; x=1732977744;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WI8J8BE3hW4twZ1XZwA9tuZWnZFyxriFR1xxuZXZtQk=;
        b=Fz/sVn3eTOS9eMDzgMJfLbB3xmbeLRPYjr8uvDPF5YjLxLW5iE7mNlWWnpXA0SSP5L
         FIjVdywyTXWOvDukKV/X1rKIjOjBS8vQHD+AoC/Z3b4NsopU4cpd5GQDY5F486OyrL02
         DK6E84chr15bW8vxQOngrN5QAhiQTSV5aZJz1w0BGYpdflKV2cGquZbHPAEREdBi6AVa
         Q9FwwqQct8s4Sim3bnOGiTvNI7HDwARsKf/RZxzgUffMdj5/g1N/v5ipSEJU5VMRqZUh
         CZkeUixoz4xEh0AoTcx/mIUgHRlwWH4SCriO0m2GxdtHnNfERDgUWvHPID+AakpHCEN3
         Ch9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWY0qeJJLnXXWsWgVI8Ip1TkxQ+ikjHbGl2Ywz+ryo5UbVMpBKgH8800WJKco703qNVV1ynWKi9lvwXtlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLT+whP2WPZO9QWIC8JZSvGOzZEzOM4DcmoAUyOmSriVTs2e0
	A4PZYEpz+kna9/lxJdr/fXKVtv2kP2WlMi6IK2RmLH6oC9rgF77xVkeY7K1lGH6/S+0l+QtF7YJ
	bdbNiNkQdpQulh5lHz30/Ul1UdGyWjDvX9nQF2k7McB0HrXN7ZFTKY+s=
X-Google-Smtp-Source: AGHT+IHXfjeVTOwh0Pb2EPkWG7zvD2MYJI5BMsCDNgwI7NPYJVDgBuu87pWxpC3+Ac3dHSRTqIyeSbH1bejPiygyKVMFbi3ZBxSt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda8:0:b0:3a7:7ded:53b9 with SMTP id
 e9e14a558f8ab-3a79af33320mr71782215ab.20.1732372944334; Sat, 23 Nov 2024
 06:42:24 -0800 (PST)
Date: Sat, 23 Nov 2024 06:42:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6741e9d0.050a0220.1cc393.0014.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in loop_set_status
From: syzbot <syzbot+9b145229d11aa73e4571@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125a81c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95b76860fd16c857
dashboard link: https://syzkaller.appspot.com/bug?extid=9b145229d11aa73e4571
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-06afb0f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ff08aa7bdbd/vmlinux-06afb0f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/158d6d864710/bzImage-06afb0f3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b145229d11aa73e4571@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
XFS (loop0): Ending clean mount
XFS (loop0): Quotacheck needed: Please wait.
XFS (loop0): Quotacheck: Done.
loop0: detected capacity change from 32768 to 64
======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-07834-g06afb0f36106 #0 Not tainted
------------------------------------------------------
syz.0.0/5326 is trying to acquire lock:
ffffffff8ea3ee80 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:318 [inline]
ffffffff8ea3ee80 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4036 [inline]
ffffffff8ea3ee80 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4114 [inline]
ffffffff8ea3ee80 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_noprof+0x3d/0x2c0 mm/slub.c:4290

but task is already holding lock:
ffff888034429e00 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: loop_set_status+0x1e4/0x8f0 drivers/block/loop.c:1267

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x23a0 block/blk-mq.c:3092
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       xfs_buf_ioapply_map+0x461/0x5d0 fs/xfs/xfs_buf.c:1586
       _xfs_buf_ioapply+0x307/0x660 fs/xfs/xfs_buf.c:1674
       __xfs_buf_submit+0x34f/0x7f0 fs/xfs/xfs_buf.c:1758
       xfs_buf_submit fs/xfs/xfs_buf.c:61 [inline]
       _xfs_buf_read fs/xfs/xfs_buf.c:809 [inline]
       xfs_buf_read_map+0x431/0xa60 fs/xfs/xfs_buf.c:873
       xfs_trans_read_buf_map+0x260/0xad0 fs/xfs/xfs_trans_buf.c:304
       xfs_trans_read_buf fs/xfs/xfs_trans.h:213 [inline]
       xfs_read_agf+0x2dc/0x630 fs/xfs/libxfs/xfs_alloc.c:3378
       xfs_alloc_read_agf+0x196/0xbe0 fs/xfs/libxfs/xfs_alloc.c:3413
       xfs_alloc_fix_freelist+0x608/0x1bd0 fs/xfs/libxfs/xfs_alloc.c:2877
       xfs_alloc_vextent_prepare_ag+0xf9/0x6b0 fs/xfs/libxfs/xfs_alloc.c:3543
       xfs_alloc_vextent_iterate_ags+0x141/0x960 fs/xfs/libxfs/xfs_alloc.c:3727
       xfs_alloc_vextent_start_ag+0x3f6/0x950 fs/xfs/libxfs/xfs_alloc.c:3816
       xfs_bmap_btalloc_best_length fs/xfs/libxfs/xfs_bmap.c:3768 [inline]
       xfs_bmap_btalloc fs/xfs/libxfs/xfs_bmap.c:3813 [inline]
       xfs_bmapi_allocate+0x18fa/0x3450 fs/xfs/libxfs/xfs_bmap.c:4226
       xfs_bmapi_write+0xbac/0x1b40 fs/xfs/libxfs/xfs_bmap.c:4555
       xfs_dquot_disk_alloc+0x5f4/0xe20 fs/xfs/xfs_dquot.c:355
       xfs_qm_dqread+0x1a3/0x650 fs/xfs/xfs_dquot.c:694
       xfs_qm_dqget+0x2bb/0x6f0 fs/xfs/xfs_dquot.c:906
       xfs_qm_quotacheck_dqadjust+0xea/0x5a0 fs/xfs/xfs_qm.c:1299
       xfs_qm_dqusage_adjust+0x5e1/0x850 fs/xfs/xfs_qm.c:1421
       xfs_iwalk_ag_recs+0x4e1/0x820 fs/xfs/xfs_iwalk.c:209
       xfs_iwalk_run_callbacks+0x218/0x470 fs/xfs/xfs_iwalk.c:370
       xfs_iwalk_ag+0xa9a/0xbb0 fs/xfs/xfs_iwalk.c:476
       xfs_iwalk_ag_work+0xfb/0x1b0 fs/xfs/xfs_iwalk.c:625
       xfs_pwork_work+0x7f/0x190 fs/xfs/xfs_pwork.c:47
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (&xfs_nondir_ilock_class){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
       xfs_reclaim_inode fs/xfs/xfs_icache.c:1037 [inline]
       xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1729 [inline]
       xfs_icwalk_ag+0x120e/0x1ad0 fs/xfs/xfs_icache.c:1811
       xfs_icwalk fs/xfs/xfs_icache.c:1859 [inline]
       xfs_reclaim_inodes_nr+0x2b0/0x390 fs/xfs/xfs_icache.c:1103
       super_cache_scan+0x40f/0x4b0 fs/super.c:227
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:437
       shrink_slab+0x1093/0x14d0 mm/shrinker.c:664
       shrink_one+0x43b/0x850 mm/vmscan.c:4824
       shrink_many mm/vmscan.c:4885 [inline]
       lru_gen_shrink_node mm/vmscan.c:4963 [inline]
       shrink_node+0x3789/0x3e10 mm/vmscan.c:5943
       kswapd_shrink_node mm/vmscan.c:6771 [inline]
       balance_pgdat mm/vmscan.c:6963 [inline]
       kswapd+0x1ca9/0x3700 mm/vmscan.c:7232
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __fs_reclaim_acquire mm/page_alloc.c:3851 [inline]
       fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3865
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4036 [inline]
       slab_alloc_node mm/slub.c:4114 [inline]
       __kmalloc_cache_noprof+0x3d/0x2c0 mm/slub.c:4290
       kmalloc_noprof include/linux/slab.h:879 [inline]
       kzalloc_noprof include/linux/slab.h:1015 [inline]
       kobject_uevent_env+0x28b/0x8e0 lib/kobject_uevent.c:540
       set_capacity_and_notify+0x206/0x240 block/genhd.c:95
       loop_set_size drivers/block/loop.c:232 [inline]
       loop_set_status+0x584/0x8f0 drivers/block/loop.c:1285
       lo_ioctl+0xcbc/0x1f50
       blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &xfs_nondir_ilock_class --> &q->q_usage_counter(io)#17

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#17);
                               lock(&xfs_nondir_ilock_class);
                               lock(&q->q_usage_counter(io)#17);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz.0.0/5326:
 #0: ffff88803465c360 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_set_status+0x2a/0x8f0 drivers/block/loop.c:1251
 #1: ffff888034429e00 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: loop_set_status+0x1e4/0x8f0 drivers/block/loop.c:1267
 #2: ffff888034429e38 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: loop_set_status+0x1e4/0x8f0 drivers/block/loop.c:1267

stack backtrace:
CPU: 0 UID: 0 PID: 5326 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-07834-g06afb0f36106 #0
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
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __fs_reclaim_acquire mm/page_alloc.c:3851 [inline]
 fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3865
 might_alloc include/linux/sched/mm.h:318 [inline]
 slab_pre_alloc_hook mm/slub.c:4036 [inline]
 slab_alloc_node mm/slub.c:4114 [inline]
 __kmalloc_cache_noprof+0x3d/0x2c0 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:879 [inline]
 kzalloc_noprof include/linux/slab.h:1015 [inline]
 kobject_uevent_env+0x28b/0x8e0 lib/kobject_uevent.c:540
 set_capacity_and_notify+0x206/0x240 block/genhd.c:95
 loop_set_size drivers/block/loop.c:232 [inline]
 loop_set_status+0x584/0x8f0 drivers/block/loop.c:1285
 lo_ioctl+0xcbc/0x1f50
 blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c5d37e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2c5e225038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2c5d535fa0 RCX: 00007f2c5d37e819
RDX: 00000000200007c0 RSI: 0000000000004c04 RDI: 0000000000000007
RBP: 00007f2c5d3f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2c5d535fa0 R15: 00007ffd88628868
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

