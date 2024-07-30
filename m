Return-Path: <linux-kernel+bounces-267459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9204A9411C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077CA1F23B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0119E7ED;
	Tue, 30 Jul 2024 12:25:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E931187340
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342305; cv=none; b=GP1kshL0+GTZ3wIyWncd220qjFWS2Aj/MsVmntEXh8rPxcHKrJUL0P13bZrXFnRkCZOgJfaLhR8tVcI3fy+2rutRGStbdtc1iPjojtCxwaID3OilGPhQNn4+rfMdWkpdY0c8gnDCiIv5MzdkDXwY+ZtKMy+JxSFBv+tFfUx1mEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342305; c=relaxed/simple;
	bh=ZkbFgQUQl6QIuCFRecZ1upOH/YdOy0WJN3bGt18p9IA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=brtUCc2BdIxWi6EBMpe+62XlejRDjJ6vNH362P/KSMIeBiwACpf3fiwf8eM2xRu1tkuMLOjrpthJ4lFp2w4eOw8SfdiENKuXEQxLNDzPskExYqrWAXQzNwtyhylF2hNXJfAdm9o71rVsoBzNftf7WiKZT0QX7NJzJwFcdS2H2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81faf98703eso231403539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722342303; x=1722947103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRpjwCOSzqPRjQWgyN3lJi092/xoyDF16/+54qfIThE=;
        b=rU3TTLQiTxzYIRCV5nyKp6x67CGh9gp4nPUw4rHcsYnGgot86Jk+6Kgev3AlmnQ6Ym
         sxhfX7WyVwAneKvdtmyq82GnHYSOqUhLdLq/Bba4c7hdnodHdMGk93w1HLbYjX+IW3qj
         3ngCJ5OIpvEPimgMrES0Fq+EU7ZZxw4RJ5RsnLz0XPyGaJ7dFDKFHd1eopWj4hF8VDw2
         FBxUwOcK2GucLMoAALEIY7oxvW1Ois5ye9RXDB4u0K2B0rja1kbFjIMTKOIp0pHpju/2
         L0JVb5unWT8s9zIq2NpbAQ3JUYNfTOZPNkODlo2DOgUaEK3ejM6u2+UNTeTbyJQnAhXv
         EIiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWthroLwuAfUL3FV6zcgrYrYEIixRgPI4iWXObpuCDcmZQhrn2CSRlC9RNDDdrF7mqj7p8lcXbnkyUhbPhZBzj8H+XDczruP+RI29vz
X-Gm-Message-State: AOJu0YwU+L9S8qql+oJ9oSPjwUb7pw5JWsqe8UznWX2EXVNpWU2IH8Hx
	Nk4nDOoggrBr81zUp/aLjmbBdHlYEJ7gkHrQVr59gNvn4g8stj/bHwJ2K1p6//tuqE7Kvktg0Zw
	ZB3GFC1CUHEyHtSX5YQZx4z7d0j3KTXCU3dh/KA6bemGUl6GqSxIDYx4=
X-Google-Smtp-Source: AGHT+IHtOZL7VMespYlHzIz693KCE7SsbA3sl60DBpKtEEz5xQbmAVMAqnYqpe4EblgCvtUeWBzo7CaRQkoEdrBzxD+b62uTP7Xf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e1:b0:397:ca8e:d377 with SMTP id
 e9e14a558f8ab-39aec138eaemr6532105ab.0.1722342303039; Tue, 30 Jul 2024
 05:25:03 -0700 (PDT)
Date: Tue, 30 Jul 2024 05:25:03 -0700
In-Reply-To: <20240730120121.23576-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000279104061e761153@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in mpls_net_exit

INFO: task kworker/u32:2:40 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc1-syzkaller-g94ede2a3e913-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u32:2   state:D stack:23792 pid:40    tgid:40    ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 mpls_net_exit+0x83/0x350 net/mpls/af_mpls.c:2708
 ops_exit_list+0xb0/0x180 net/core/net_namespace.c:173
 cleanup_net+0x5b7/0xbf0 net/core/net_namespace.c:640
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u32:8:1114 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc1-syzkaller-g94ede2a3e913-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u32:8   state:D stack:25456 pid:1114  tgid:1114  ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 addrconf_dad_work+0xcf/0x1500 net/ipv6/addrconf.c:4194
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/u32:2/40:
 #0: ffff8880166f4948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90000987d80 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fa09250 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xbb/0xbf0 net/core/net_namespace.c:594
 #3: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: mpls_net_exit+0x83/0x350 net/mpls/af_mpls.c:2708
1 lock held by khungtaskd/41:
 #0: ffffffff8ddb53a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8ddb53a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8ddb53a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6620
3 locks held by kworker/2:2/834:
 #0: ffff888015888948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90005207d80 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0x51/0xc0 net/core/link_watch.c:276
3 locks held by kworker/u32:8/1114:
 #0: ffff88801a131148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90005d87d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x1500 net/ipv6/addrconf.c:4194
1 lock held by dhcpcd/5046:
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
2 locks held by getty/5136:
 #0: ffff888108c220a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000cb2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
3 locks held by kworker/2:3/5193:
 #0: ffff888015889948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc900031efd80 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x84/0x1140 net/wireless/reg.c:2480
3 locks held by syz.0.15/5889:
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
 #1: ffff88802dba8d40 (team->team_lock_key#4){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975
 #2: ffff88802dba8d40 (team->team_lock_key#4/1){+.+.}-{3:3}, at: team_port_change_check drivers/net/team/team_core.c:2950 [inline]
 #2: ffff88802dba8d40 (team->team_lock_key#4/1){+.+.}-{3:3}, at: team_device_event+0x2cd/0x770 drivers/net/team/team_core.c:2973
1 lock held by syz-executor/5891:
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/5897:
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/5902:
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 41 Comm: khungtaskd Not tainted 6.11.0-rc1-syzkaller-g94ede2a3e913-dirty #0
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
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc1-syzkaller-g94ede2a3e913-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:asm_sysvec_call_function_single+0x0/0x20 arch/x86/include/asm/idtentry.h:709
Code: 86 51 f1 ff e9 f1 05 00 00 90 f3 0f 1e fa 0f 01 ca fc 6a ff e8 a1 04 00 00 48 89 c4 48 89 e7 e8 a6 50 f1 ff e9 d1 05 00 00 90 <f3> 0f 1e fa 0f 01 ca fc 6a ff e8 81 04 00 00 48 89 c4 48 89 e7 e8
RSP: 0018:ffffffff8da07df8 EFLAGS: 00000046
RAX: 00000000000f1f55 RBX: 0000000000000000 RCX: ffffffff8b118529
RDX: 0000000000000000 RSI: ffffffff8b4cc580 RDI: ffffffff8bb08c00
RBP: fffffbfff1b52af8 R08: 0000000000000001 R09: ffffed100d606fd9
R10: ffff88806b037ecb R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff8da957c0 R14: ffffffff9012a4d8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005565cd2c32b8 CR3: 000000001be34000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
RIP: 0010:default_idle+0xf/0x20 arch/x86/kernel/process.c:743
Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d a3 ff 34 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffffff8da07e20 EFLAGS: 00000246
 </TASK>
NMI backtrace for cpu 3 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 3 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 3 skipped: idling at default_idle+0xf/0x20 arch/x86/kernel/process.c:742
NMI backtrace for cpu 2 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 2 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 2 skipped: idling at default_idle+0xf/0x20 arch/x86/kernel/process.c:742


Tested on:

commit:         94ede2a3 profiling: remove stale percpu flip buffer va..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12305623980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04fc17f2c61c03
dashboard link: https://syzkaller.appspot.com/bug?extid=b668da2bc4cb9670bf58
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b963a1980000


