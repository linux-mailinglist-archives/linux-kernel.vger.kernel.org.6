Return-Path: <linux-kernel+bounces-333077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B5E97C32B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE041F21F83
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7538512E4A;
	Thu, 19 Sep 2024 03:31:33 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF687FC0E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726716692; cv=none; b=oHcmPMyc0WJxgZ3Y6Fd7l+kPpp66bh59CuBGNOftDJ2vSasLDAN3bU4asCSmhThuZ3FEa54CiCFtQ3vgq2RZBxnAUTJfO7y14t96nByUXireeqIET/xofbhWNrpiDnEgLeQ2cZQbKCoXP88cVRVJgjbS/nCGB7Z+kls5PwxiLSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726716692; c=relaxed/simple;
	bh=8PaFu6KVj3ZWd+/K709cgVBwh6zIn4pP5z1omXuYc4c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qQjgHgE/ksnDj7A2aP246P2q5x92ke0AzMuYi+8x57ozx/uSmChc7j5SIc3tv1dQWrY1meK1NqbFitexsR9D3AVEA5+MrqcxQNeT5+Kqkjtv48Dz0Bey+giynMRmFV7FrO0T2LZ9dj5sUtMw+sAMUCl+QIQ91eFNG2yp6VQiPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a04c2472f6so5499975ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726716690; x=1727321490;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1XxAU/BMEH/m9hVhXOf8MWPY6MzyRc8FqQrCUPUAlQ=;
        b=wZyszlLDCKwxoF/42KLSQOATBy09uAKmEm88LvjPfe8mAYttFesnbGJHtuLXLStS0l
         q6xZNma1jmVE3iOtl0m+tx04ZanlHHAwUFHq8H9xrPL/bsND1C6boh/amzyfLhVXuJzp
         0O6TMrEnSAMOuypmIVjWXel9cQE9rHZ+KAqsNfoISYDOGx0vk1VTpj6hlsqq60+pdrfD
         bBRdt3yl0aXcPtrjaeTHVl7VOLkDUpMk24rlHQ0Xvg/qdgCA6qXDJbZdTA5G/cWgn+dE
         Smy36RJiG5OIDI/9Cj3KDUEmjKApfYnzSzxSR9folLuP9ENvluiZnHEZeXQJ5LtFFToB
         o+3A==
X-Forwarded-Encrypted: i=1; AJvYcCVyyBl5ke/uOqU80xdH1HJONxEpugFldpuoCwiB79xWVEYIHAJvMVv9WI9+HZWqyocYNQDdGBh1OK+MZjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9n+Olcq9QpHA7TrEw9zqNcxjl5p2q5cylHrH0cjgAPEPzDi9y
	U9obAs3O9jT4bmUCHkYh8dIXFuwXosKEuCNa3/AAoj8uph6NkHy1phik3P9Z2URl8w1WHaibF2H
	I4qIcM/VGI1fQfFV04TZ+P520twJXXWljQilRi6AmKSp13867lv1eK9Y=
X-Google-Smtp-Source: AGHT+IHL4MtUOvb8yloQA2JqRcTSO4Rq6a9UhkXCqhyY69B6DF7BvS1yC9iZOQHUB0vPa9WVBLb2TfIUbicwbDYl2gSRoWiFK4kz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0c:0:b0:3a0:9c99:32d6 with SMTP id
 e9e14a558f8ab-3a09c99366fmr116124945ab.24.1726716690030; Wed, 18 Sep 2024
 20:31:30 -0700 (PDT)
Date: Wed, 18 Sep 2024 20:31:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eb9b11.050a0220.115905.0023.GAE@google.com>
Subject: [syzbot] [jfs?] INFO: task hung in jfs_flush_journal (4)
From: syzbot <syzbot+8ab0d983d2bc3b69ea23@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0babf683783d Merge tag 'pinctrl-v6.11-4' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178b1900580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=8ab0d983d2bc3b69ea23
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aab0f0b09dd6/disk-0babf683.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b97896b7812c/vmlinux-0babf683.xz
kernel image: https://storage.googleapis.com/syzbot-assets/340ce283efd3/bzImage-0babf683.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ab0d983d2bc3b69ea23@syzkaller.appspotmail.com

INFO: task syz.3.87:6007 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc7-syzkaller-00149-g0babf683783d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.87        state:D stack:25424 pid:6007  tgid:5987  ppid:5381   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 jfs_flush_journal+0x72c/0xec0 fs/jfs/jfs_logmgr.c:1564
 jfs_sync_fs+0x80/0xa0 fs/jfs/super.c:684
 sync_filesystem+0x1c8/0x230 fs/sync.c:66
 jfs_remount+0x136/0x6b0 fs/jfs/super.c:432
 reconfigure_super+0x445/0x880 fs/super.c:1083
 vfs_cmd_reconfigure fs/fsopen.c:263 [inline]
 vfs_fsconfig_locked fs/fsopen.c:292 [inline]
 __do_sys_fsconfig fs/fsopen.c:473 [inline]
 __se_sys_fsconfig+0xb6e/0xf80 fs/fsopen.c:345
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fab3817def9
RSP: 002b:00007fab38f50038 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007fab38336058 RCX: 00007fab3817def9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000005
RBP: 00007fab381f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fab38336058 R15: 00007ffdfae0cef8
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:1/9:
 #0: ffff88801a880948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88801a880948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900000e7d00 (deferred_process_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900000e7d00 (deferred_process_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fa79e08 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
1 lock held by khungtaskd/30:
 #0: ffffffff8e738320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e738320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e738320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6626
3 locks held by kworker/u8:2/35:
3 locks held by kworker/u8:4/63:
 #0: ffff88802f9d0948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88802f9d0948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900015e7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900015e7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: 
ffffffff8fa79e08 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4194
3 locks held by kworker/u8:8/2992:
3 locks held by kworker/u8:9/3019:
 #0: 
ffff88801a889148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
ffff88801a889148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900098bfd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900098bfd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fa79e08 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
2 locks held by dhcpcd/4890:
 #0: ffff8880226c9678 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: __netlink_dump_start+0x119/0x790 net/netlink/af_netlink.c:2404
 #1: ffffffff8fa79e08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #1: ffffffff8fa79e08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_dumpit+0x99/0x200 net/core/rtnetlink.c:6506
2 locks held by getty/4975:
 #0: ffff88803073d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000312b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}
, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
2 locks held by syz.3.87/6007:
 #0: ffff8880345c3070 (&fc->uapi_mutex){+.+.}-{3:3}, at: __do_sys_fsconfig fs/fsopen.c:471 [inline]
 #0: ffff8880345c3070 (&fc->uapi_mutex){+.+.}-{3:3}, at: __se_sys_fsconfig+0x9a7/0xf80 fs/fsopen.c:345
 #1: ffff88803000c0e0 (&type->s_umount_key#99){++++}-{3:3}, at: vfs_cmd_reconfigure fs/fsopen.c:262 [inline]
 #1: ffff88803000c0e0 (&type->s_umount_key#99){++++}-{3:3}, at: vfs_fsconfig_locked fs/fsopen.c:292 [inline]
 #1: ffff88803000c0e0 (&type->s_umount_key#99){++++}-{3:3}, at: __do_sys_fsconfig fs/fsopen.c:473 [inline]
 #1: ffff88803000c0e0 (&type->s_umount_key#99){++++}-{3:3}, at: __se_sys_fsconfig+0xb64/0xf80 fs/fsopen.c:345
1 lock held by syz.3.121/6546:
 #0: ffff88803000c0e0 (&type->s_umount_key#99){++++}-{3:3}
, at: __super_lock fs/super.c:58 [inline]
, at: super_lock+0x27c/0x400 fs/super.c:120
1 lock held by syz.4.184/7182:
 #0: 
ffff88803000c0e0 (&type->s_umount_key#99){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
ffff88803000c0e0 (&type->s_umount_key#99){++++}-{3:3}, at: super_lock+0x27c/0x400 fs/super.c:120
1 lock held by syz.3.216/7374:
 #0: ffff88803000c0e0 (&type->s_umount_key#99
){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
){++++}-{3:3}, at: super_lock+0x27c/0x400 fs/super.c:120
2 locks held by syz-executor/7671:
 #0: 
ffffffff8fadf570 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fa79e08 (rtnl_mutex){+.+.}-{3:3}, at: nl80211_pre_doit+0x5f/0x8b0 net/wireless/nl80211.c:16547
1 lock held by syz-executor/7899:
 #0: ffffffff8fa79e08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa79e08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz.3.285/7945:
 #0: ffff88803000c0e0 (&type->s_umount_key#99){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88803000c0e0 (&type->s_umount_key#99){++++}-{3:3}, at: super_lock+0x196/0x400 fs/super.c:120
1 lock held by syz-executor/8034:
 #0: ffffffff8fa79e08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa79e08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
8 locks held by syz-executor/8079:
 #0: ffff888033714420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2882 [inline]
 #0: ffff888033714420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x227/0xc90 fs/read_write.c:586
 #1: ffff88806b91ac88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x500 fs/kernfs/file.c:325
 #2: ffff8880268d3a58 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20f/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f314108 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff888021ef50e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff888021ef50e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1094 [inline]
 #4: ffff888021ef50e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1292
 #5: ffff88804db0f250 (&devlink->lock_key#21){+.+.}-{3:3}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8fa79e08 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773
 #7: ffffffff8e73d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:328 [inline]
 #7: ffffffff8e73d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:958
6 locks held by syz.2.308/8221:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc7-syzkaller-00149-g0babf683783d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 53 Comm: kworker/u8:3 Not tainted 6.11.0-rc7-syzkaller-00149-g0babf683783d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bat_events batadv_nc_worker
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4788 [inline]
RIP: 0010:__lock_acquire+0x749/0x2040 kernel/locking/lockdep.c:5092
Code: 41 89 ec ff cd 0f 88 a2 00 00 00 89 eb 83 fd 31 73 79 48 8d 04 9b 48 8d 5c c6 20 48 89 d8 48 c1 e8 03 0f b6 04 10 84 c0 75 18 <8b> 1b 41 0f b6 04 16 84 c0 75 31 41 33 1f f7 c3 00 60 00 00 74 c0
RSP: 0018:ffffc90000bd78f0 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff888020afc728 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffff888020afc6e0 RDI: 000000000000000a
RBP: 0000000000000001 R08: ffffffff93fa6847 R09: 1ffffffff27f4d08
R10: dffffc0000000000 R11: fffffbfff27f4d09 R12: 0000000000000002
R13: ffff888020afc6d8 R14: 1ffff1100415f8ea R15: ffff888020afc750
FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f47e80af440 CR3: 000000000e534000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 rcu_read_lock include/linux/rcupdate.h:838 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0xec/0x610 net/batman-adv/network-coding.c:719
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x870/0xd30 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

