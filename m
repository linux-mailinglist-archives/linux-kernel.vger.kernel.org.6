Return-Path: <linux-kernel+bounces-263974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 759E093DD63
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 07:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD30FB2300B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 05:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26CB28DB3;
	Sat, 27 Jul 2024 05:13:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCC32837B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 05:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722057185; cv=none; b=OFraWNSjlfBG9FE8edldPIJv8X/0RiY2syyQKMtfV7k5ZmkWzG11CHDb02ZkY6cD/gQ0ZhxSHT/dxNaSmlfkIwDI3SpISqwSRwhSJsVHhShpgNT1+tiBX+IsSjjcm4Tf6ryh62EOwpJWOU/oilypNrRC63YvYGGz8DtX+ctkgLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722057185; c=relaxed/simple;
	bh=2SdzbMbKetyOq6aiW8rGCsEpvvBXeqBuB0pxvpjhilo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oFgFsfasyvvLaeH2kv2SSb8Y2rvBVQigCG2zZsBCFHrb4H8v2pzehbd45bLmPpak1OEgGjYIMj9cS2PfHdCArSNPbowdPw1chufmoDmQT5DnKJlolB4eWStf8P0KpsbJhQ/0cnj1AY4V13oa47pun9fxNsLWlPD72bueHk1bY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3962d4671c7so33960815ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 22:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722057182; x=1722661982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGsqahu58KpiJY1Lzx2noOn1kT1tsFzbw3GXdyxKvsY=;
        b=Cz0tKjdhXaCtXLzo3PsZsPOcyW/K6VI5ggvY81Tv9eSTLJsJTxVCmKB/FaIdvwGkKs
         fa9XrjuEVlawAyeKkVS7lOnV8OpObygxwUMovqFSetvloF6eHDynJm+U7nIkb3j9qb9H
         jiLbxPw3OgHc2I3p5RtbkPQPwnAhkplaMkOPxWhXMI+P3WysOjBEpYIEI9IhINBQiP3d
         DzsBLtEZGgJciNtXjaGaWJPHTIUhd2f+kDtu1y/Jp70EAKAQoKjNZDnT6lTPxtwn792A
         4mjMUHStLNTxRK4iY9Lf3wpebGH0ycNgMsCNGnmE25U41r0XSUcG04f/jkTz1SbcaZbn
         Wcmw==
X-Forwarded-Encrypted: i=1; AJvYcCXd0q4w/UQEsjtK1HhGJkbtnOORZefobhnNfAR7r0Ks+wMftQnvjUcjCMBy00bQO/LJgifzSkQoG6jGAohNE8TeZjvR8e4gRpOyXQAH
X-Gm-Message-State: AOJu0YwJ4AIWeU7+zqqxvbuYM5Ytdbr8CUe08NPhq5cFZl25WzhWFbYP
	A6ZI6mPugD5KxCFKXsTjNzPfk3YiltilhAWEhul87+FByDOfxEcTPg0vsr92zK7jOtYBW0i4m02
	R29CmeIsX5hO9++DnPpdHPmPjxe0w7PXlD+oqZCUt/nE6LzGEzNE0h7A=
X-Google-Smtp-Source: AGHT+IGCXSE7BJxUBOtOmU5xOrKimr1wqp+nwI9rWbCCaMdyQLxKe2fNjvCx6hlQO/KEZdSGmfaSa/XZXj6SWvSD9+HKxv5X6TUf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138c:b0:376:417e:c2b2 with SMTP id
 e9e14a558f8ab-39aec427d26mr1110975ab.5.1722057182428; Fri, 26 Jul 2024
 22:13:02 -0700 (PDT)
Date: Fri, 26 Jul 2024 22:13:02 -0700
In-Reply-To: <tencent_411BA74B731B5425C2BA5ABB2C33119EE808@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a461e1061e33ae11@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in f2fs_stop_gc_thread

INFO: task syz.1.294:8828 blocked for more than 143 seconds.
      Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.294       state:D stack:23808 pid:8828  tgid:8827  ppid:5828   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2557
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 kthread_stop+0x19e/0x630 kernel/kthread.c:710
 f2fs_stop_gc_thread+0x65/0xb0 fs/f2fs/gc.c:210
 f2fs_do_shutdown+0x258/0x550 fs/f2fs/file.c:2284
 f2fs_ioc_shutdown fs/f2fs/file.c:2327 [inline]
 __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4327
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6582b75b59
RSP: 002b:00007f65825ff048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6582d05f60 RCX: 00007f6582b75b59
RDX: 0000000020000140 RSI: 000000008004587d RDI: 0000000000000005
RBP: 00007f6582be4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f6582d05f60 R15: 00007fff126c76c8
 </TASK>
INFO: task syz.1.294:8849 blocked for more than 144 seconds.
      Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.294       state:D stack:26464 pid:8849  tgid:8827  ppid:5828   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1580
 vfs_cmd_reconfigure fs/fsopen.c:262 [inline]
 vfs_fsconfig_locked fs/fsopen.c:292 [inline]
 __do_sys_fsconfig fs/fsopen.c:473 [inline]
 __se_sys_fsconfig+0xb64/0xf80 fs/fsopen.c:345
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6582b75b59
RSP: 002b:00007f65825de048 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007f6582d06038 RCX: 00007f6582b75b59
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007f6582be4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f6582d06038 R15: 00007fff126c76c8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e336e60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #0: ffffffff8e336e60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #0: ffffffff8e336e60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6620
3 locks held by kworker/u8:5/144:
2 locks held by getty/4844:
 #0: ffff88802afe40a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
2 locks held by syz.1.294/8828:
 #0: ffff88801fb32420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write_file+0x61/0x200 fs/namespace.c:559
 #1: ffff88801fb320e0 (&type->s_umount_key#53){++++}-{3:3}, at: f2fs_do_shutdown+0x250/0x550 fs/f2fs/file.c:2283
2 locks held by syz.1.294/8849:
 #0: ffff88807eccac70 (&fc->uapi_mutex){+.+.}-{3:3}, at: __do_sys_fsconfig fs/fsopen.c:471 [inline]
 #0: ffff88807eccac70 (&fc->uapi_mutex){+.+.}-{3:3}, at: __se_sys_fsconfig+0x9a7/0xf80 fs/fsopen.c:345
 #1: ffff88801fb320e0 (&type->s_umount_key#53){++++}-{3:3}, at: vfs_cmd_reconfigure fs/fsopen.c:262 [inline]
 #1: ffff88801fb320e0 (&type->s_umount_key#53){++++}-{3:3}, at: vfs_fsconfig_locked fs/fsopen.c:292 [inline]
 #1: ffff88801fb320e0 (&type->s_umount_key#53){++++}-{3:3}, at: __do_sys_fsconfig fs/fsopen.c:473 [inline]
 #1: ffff88801fb320e0 (&type->s_umount_key#53){++++}-{3:3}, at: __se_sys_fsconfig+0xb64/0xf80 fs/fsopen.c:345
2 locks held by syz.4.517/10408:
 #0: ffff88802a168420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write_file+0x61/0x200 fs/namespace.c:559
 #1: ffff88802a1680e0 (&type->s_umount_key#53){++++}-{3:3}, at: f2fs_do_shutdown+0x250/0x550 fs/f2fs/file.c:2283
2 locks held by syz.4.517/10432:
 #0: ffff88801e248470 (&fc->uapi_mutex){+.+.}-{3:3}, at: __do_sys_fsconfig fs/fsopen.c:471 [inline]
 #0: ffff88801e248470 (&fc->uapi_mutex){+.+.}-{3:3}, at: __se_sys_fsconfig+0x9a7/0xf80 fs/fsopen.c:345
 #1: ffff88802a1680e0 (&type->s_umount_key#53){++++}-{3:3}, at: vfs_cmd_reconfigure fs/fsopen.c:262 [inline]
 #1: ffff88802a1680e0 (&type->s_umount_key#53){++++}-{3:3}, at: vfs_fsconfig_locked fs/fsopen.c:292 [inline]
 #1: ffff88802a1680e0 (&type->s_umount_key#53){++++}-{3:3}, at: __do_sys_fsconfig fs/fsopen.c:473 [inline]
 #1: ffff88802a1680e0 (&type->s_umount_key#53){++++}-{3:3}, at: __se_sys_fsconfig+0xb64/0xf80 fs/fsopen.c:345
2 locks held by syz.2.560/10729:
 #0: ffff88807866e420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write_file+0x61/0x200 fs/namespace.c:559
 #1: ffff88807866e0e0 (&type->s_umount_key#53){++++}-{3:3}, at: f2fs_do_shutdown+0x250/0x550 fs/f2fs/file.c:2283
2 locks held by syz.2.560/10730:
 #0: ffff88801cfb5870 (&fc->uapi_mutex){+.+.}-{3:3}, at: __do_sys_fsconfig fs/fsopen.c:471 [inline]
 #0: ffff88801cfb5870 (&fc->uapi_mutex){+.+.}-{3:3}, at: __se_sys_fsconfig+0x9a7/0xf80 fs/fsopen.c:345
 #1: ffff88807866e0e0 (&type->s_umount_key#53){++++}-{3:3}, at: vfs_cmd_reconfigure fs/fsopen.c:262 [inline]
 #1: ffff88807866e0e0 (&type->s_umount_key#53){++++}-{3:3}, at: vfs_fsconfig_locked fs/fsopen.c:292 [inline]
 #1: ffff88807866e0e0 (&type->s_umount_key#53){++++}-{3:3}, at: __do_sys_fsconfig fs/fsopen.c:473 [inline]
 #1: ffff88807866e0e0 (&type->s_umount_key#53){++++}-{3:3}, at: __se_sys_fsconfig+0xb64/0xf80 fs/fsopen.c:345
2 locks held by syz.3.637/11108:
2 locks held by syz.0.640/11110:
2 locks held by syz.2.643/11116:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 12 Comm: kworker/u8:1 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:get_current arch/x86/include/asm/current.h:49 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x8/0x70 kernel/kcov.c:206
Code: 8b 3d 4c 70 4a 0c 48 89 de 5b e9 73 7c 57 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 04 24 <65> 48 8b 0c 25 40 d5 03 00 65 8b 15 70 92 70 7e f7 c2 00 01 ff 00
RSP: 0018:ffffc90000117790 EFLAGS: 00000297
RAX: ffffffff8b03874a RBX: 0000000000000008 RCX: ffff8880172bda00
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000002
RBP: 0000000000000014 R08: ffffffff8b03873b R09: 1ffffffff1f5d135
R10: dffffc0000000000 R11: fffffbfff1f5d136 R12: dffffc0000000000
R13: 0000000000000008 R14: ffff88807e0c30d0 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1c7a489000 CR3: 000000001f196000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 ieee80211_sta_get_rates+0x20a/0x660 net/mac80211/util.c:1540
 ieee80211_update_sta_info net/mac80211/ibss.c:989 [inline]
 ieee80211_rx_bss_info net/mac80211/ibss.c:1098 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1579 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x11e1/0x2d70 net/mac80211/ibss.c:1606
 ieee80211_iface_process_skb net/mac80211/iface.c:1588 [inline]
 ieee80211_iface_work+0x8a5/0xf20 net/mac80211/iface.c:1642
 cfg80211_wiphy_work+0x2db/0x490 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14b2bea1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146ecebd980000


