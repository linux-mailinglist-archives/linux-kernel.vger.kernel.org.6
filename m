Return-Path: <linux-kernel+bounces-281736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC32494DA91
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 06:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85354283D37
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 04:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7002D137742;
	Sat, 10 Aug 2024 04:02:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D13FEC
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 04:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723262525; cv=none; b=FV7kLENr90QwBso+g3oJZ/hAGNyk/c1DCNtWMo2vAREEpkTOhjwbX8pC/E4mQ8/GGeJToLcNisdzn52xdF4el62yyusHCdDwlTAYt0zZxPnIXmATan4WZd3HERER94cp8Hw30bwKlBwYSLVXtGyAk99k39Ezb5Jr5exVfwFNEjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723262525; c=relaxed/simple;
	bh=n489zQ+lnHUHa5DLpWoeh0VGlHr66+OmNS5E4bIt7hs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X2x2pxgwkEyGzfgpdMnGbbY3Al3kX21GooxM2B91r6un8MqdwkTPbpENlHZHegdbcWbfjTBk/3PaR3i42Bs4EoC6WYJrqANcjeo29lch3YjPVZEfJvYI5g6oDqpxdcPCMKze9Q8X59vUuLj+etnj43l32UteKbM2bQgf1ZTiAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8223aed78e2so328458339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 21:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723262523; x=1723867323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cI7/EOSL+zEJ+LIkyTC05n7rzKbtccoJH1s4Qnl/Dgk=;
        b=uOUBkRZqQ/DRzaCtcvD9+Un5IJ7hI/3k9Odv4mir5XKdQTXvrk425FqQrtwpZvSUvP
         FXKWpCm/tKgB4GfhDPJ5b+NvaEKvW3+JnNOpAlUn3/h/LeCHvb2TJRBhewAg99q1wpzH
         UnDn3C6wcVHrbxTskzDFACegzswvjcctvHF1QKLIz9b0Mx5TI4BtZawoMPLuKW5rJqfW
         9ykj5jm9Q4agzMq/FaQf5antAgi7/lrt5WKOTlmmnYL/kmfUb/rorJ2Y/YLFctFnZCb6
         ck+ZaB1r/0KxbnfMaYcUMvm6FIS5DRK5g93rY5mxVcJRNFzhYdFW/5QwCMJCWw0I569E
         UVYw==
X-Forwarded-Encrypted: i=1; AJvYcCWfK1Zr+Jm3ugUtxbOEXUVSfy5O+1BJzq6/xhYRKyy2D2i+m+em+gT/36aAt4jornCQCzMy/9s0+COndO+gpN3jQJdonObojUlswCou
X-Gm-Message-State: AOJu0Yy3KFbYkr8/RU3eJ2X21t7gL5n0CXDxwiTbDNQQKNeQmg0QAWBT
	2UMQu33hnpKLmrxUZnzmyiptGLsLSjeoj5nfPBQvyvp6G79wIFhOlj3xt+ay0nuOe/8N9oUUi18
	T4aEMOXvL+Al+E9kVrier3v7CnGHFXcljJGsGgy1o1YUU54WL3c8NEQo=
X-Google-Smtp-Source: AGHT+IGvVKciEMx8dzDNXSmsJuabAC8D9BMyoWznkpgXNZ7/aMZb5zQd08ZFpAIuGBMGnrEPCOzPrlY0T5uHZzspv1NHeNSPPvrM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6c88:b0:4c2:8e08:f579 with SMTP id
 8926c6da1cb9f-4ca6ece3068mr226622173.2.1723262523323; Fri, 09 Aug 2024
 21:02:03 -0700 (PDT)
Date: Fri, 09 Aug 2024 21:02:03 -0700
In-Reply-To: <tencent_656F489598E922EF0ACE8479566E702EF90A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ecbff061f4c524f@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in v9fs_evict_inode

INFO: task syz-executor:5811 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:23952 pid:5811  tgid:5811  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 netfs_wait_for_outstanding_io include/linux/netfs.h:535 [inline]
 v9fs_evict_inode+0x271/0x310 fs/9p/vfs_inode.c:351
 evict+0x2ed/0x6c0 fs/inode.c:669
 dispose_list+0x117/0x1e0 fs/inode.c:712
 evict_inodes+0x34e/0x450 fs/inode.c:762
 generic_shutdown_super+0xb5/0x3d0 fs/super.c:627
 kill_anon_super+0x3a/0x60 fs/super.c:1237
 v9fs_kill_super+0x3d/0xa0 fs/9p/vfs_super.c:193
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1373
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7b6a1786e7
RSP: 002b:00007ffeeb983478 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f7b6a1786e7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffeeb983530
RBP: 00007ffeeb983530 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffeeb9845b0
R13: 00007f7b6a1e4784 R14: 0000000000028c1d R15: 00007ffeeb9845f0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/40:
 #0: ffffffff8ddb53a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8ddb53a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8ddb53a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6620
2 locks held by getty/5135:
 #0: ffff8880235fb0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000db2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
1 lock held by syz-executor/5811:
 #0: ffff888020a800e0 (&type->s_umount_key#67){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff888020a800e0 (&type->s_umount_key#67){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff888020a800e0 (&type->s_umount_key#67){+.+.}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:505
2 locks held by syz.0.4336/14555:
 #0: ffffffff8ec222b8 (qp_broker_list.mutex){+.+.}-{3:3}, at: vmci_qp_broker_detach+0x14d/0x1370 drivers/misc/vmw_vmci/vmci_queue_pair.c:2095
 #1: ffffffff8ddc0b38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:296

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 40 Comm: khungtaskd Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf4e/0x1280 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 3 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 3 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 3 skipped: idling at default_idle+0xf/0x20 arch/x86/kernel/process.c:742
NMI backtrace for cpu 2 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 2 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 2 skipped: idling at default_idle+0xf/0x20 arch/x86/kernel/process.c:742
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 0 skipped: idling at default_idle+0xf/0x20 arch/x86/kernel/process.c:742


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1265c113980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a5c113980000


