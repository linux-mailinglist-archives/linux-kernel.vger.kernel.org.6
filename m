Return-Path: <linux-kernel+bounces-261659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAB093BA6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F6F28441A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01D86FC6;
	Thu, 25 Jul 2024 01:54:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2326112
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721872447; cv=none; b=FE5v7OL/SJdTlHup4kzebtzH7tXCHBD99D2xE7pT/A5QESGkdqLBlfT79EhwXAzAgNMx6CuJMSspWhlQTT/Ej2meBUoUy5zjq1UDiVX6jixAVNpo9z8ShMt3gk81oTre4yrlrvqQEVDVi1V0BSA+sWDVUMehfaMRVCWPisEm980=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721872447; c=relaxed/simple;
	bh=CPBV69GgU8A0yxbxNl5wDyj4kTu+v8nXYbdlB3ihQtc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OcbthBnta0vTb9uyLAPkxfCkKJWQSQhVIKhGk5B/ypNVuaHfAivyO5yfDFNhfvhdG/I2/Rh4zsDsS2DvY5rKK/7mhQQKA2l1jPT3VpAt5ROZdltMspevJpwU9ybyy3MqfMJaMEXJazv9Hpbt1WoVfOrFZ+fCq86iOM2PVCHo4mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-807b123d985so76757739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721872444; x=1722477244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzOZzscHhOAOpfLx/SXvSaMiDrcJhElTn4Bk5Gc9U7U=;
        b=xKpC1anXyvGwE0sUJ3UnDj/OVJC8SbMQsDkicR++MElIh70Cr9SjrqtnsuHKWxfrR7
         SUFE/1y/vFN/NiLj5puXoqmPs9bT9xUT8jvUWpE0vEyL7wE7fYaa1lNij5QS4cG+XUzm
         WUzGJxbmv+bpKbA4pa88y80arThdHjsvt5jtPoyhN0J72GXhaEqQVjGPcYvYT7jhYtGp
         q+8mRjNmtU/OUmsaa9VFVHMKCbokl7WXRhwyFg+8mBbicf5AiQPgTPEi0WKprDKJE4VA
         CwZKBt0z47q0XPQBffyzHO62qBGs3Fmrwx+myXi5crRHjqZS0q8dEVNcgH+CBJUQppoE
         0EcQ==
X-Gm-Message-State: AOJu0YxOGaV9hNNNT/EupsxmLrrfdd+XYsmUMHc4O/eNNPMA3Le+4y8o
	Tbi4Z4PbXYcLzvk1tuolZ20UbQotGyBqBIgMIi/kYkA2wnetJSPMaWmOe2xxsN891/p/L5Rexgv
	GyN7V3Sc2u2p7qWcpR21gQ8ZO5WO6Pp1Ivq6B9cnoy+yDKARAnffvpjU=
X-Google-Smtp-Source: AGHT+IETX4tDU08Molg74WDgdMXZ4yxmXq3C4ox5D1ubYDnpkoNd/R+mzsx9th3QoYN6q6RmR+/KlyvuSvV5B8dn5Mq5vmTdx6O5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8711:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4c2a1174f48mr16732173.4.1721872444662; Wed, 24 Jul 2024
 18:54:04 -0700 (PDT)
Date: Wed, 24 Jul 2024 18:54:04 -0700
In-Reply-To: <20240725013244.474343-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069b574061e08abd8@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in f2fs_stop_gc_thread

INFO: task syz.3.52:6722 blocked for more than 143 seconds.
      Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.52        state:D stack:26464 pid:6722  tgid:6680  ppid:5910   flags:0x00004004
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
 f2fs_do_shutdown+0x250/0x550 fs/f2fs/file.c:2285
 f2fs_ioc_shutdown fs/f2fs/file.c:2327 [inline]
 __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4327
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f24e1d75b59
RSP: 002b:00007f24e17ff048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f24e1f06038 RCX: 00007f24e1d75b59
RDX: 0000000020000140 RSI: 000000008004587d RDI: 0000000000000005
RBP: 00007f24e1de4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f24e1f06038 R15: 00007ffdd92ac938
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e336e60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #0: ffffffff8e336e60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #0: ffffffff8e336e60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6620
3 locks held by kworker/u8:2/35:
5 locks held by kworker/u8:8/1113:
2 locks held by getty/4843:
 #0: ffff88802aa340a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
1 lock held by syz.3.52/6722:
 #0: ffff88807c804420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write_file+0x61/0x200 fs/namespace.c:559
1 lock held by syz.4.98/7235:
 #0: ffff88807d5a2420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write_file+0x61/0x200 fs/namespace.c:559
1 lock held by syz.1.241/8092:
 #0: ffff88802c114420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write_file+0x61/0x200 fs/namespace.c:559
1 lock held by syz.2.274/8239:
 #0: ffff88807b344420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write_file+0x61/0x200 fs/namespace.c:559
1 lock held by syz.4.422/8825:
2 locks held by syz.1.423/8831:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 35 Comm: kworker/u8:2 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x0/0x90 kernel/kcov.c:303
Code: 10 48 89 74 0a 18 4c 89 44 0a 20 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 4c 8b 04 24 65 48 8b 14 25 40 d5 03 00 65 8b 05 30 8e
RSP: 0018:ffffc90000ab7838 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 000000000000004c RCX: ffff88801b293c00
RDX: 0000000000000000 RSI: 000000000000004c RDI: 0000000000000024
RBP: ffffc90000ab7ae8 R08: 0000000000000005 R09: ffffffff8af5c942
R10: 0000000000000006 R11: ffff88801b293c00 R12: dffffc0000000000
R13: ffff8880428fccc0 R14: ffff88802b095e50 R15: 1ffff92000156f20
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f834aa06000 CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1572 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x3f3/0x2d70 net/mac80211/ibss.c:1606
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
console output: https://syzkaller.appspot.com/x/log.txt?x=101229f1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1204adad980000


