Return-Path: <linux-kernel+bounces-403050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645309C3032
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 01:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE21281F5A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 00:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C3CF9D9;
	Sun, 10 Nov 2024 00:59:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48345946F
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731200370; cv=none; b=cpftSXfQ1PRZN/2dDwPwG5osIZYGDFpU9d+Prgo87bwjek+cRm+tjq2mq4DquYvO8QS9H94Bgu8khXhkgrHnH2bme8oMIfKT3p9D/l+y5/KD5B83R7uEXinMrEi30TZ10iDe5s2X9AxXiPJqMr7xwgyQjCSt2ETcgJjQ1eou5oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731200370; c=relaxed/simple;
	bh=JKbcX5+43noGwNyNMvMxOHZ7gIwDMbfzcgi/ddslmSo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iYc7iGz2iF/cWTYbmyXZJYLTA5QK71L5RBp3Wxp5VcEu6A/ZnS63y9YgBBsEIq+ucBBCrYFq3d04m8lP36eL8fnYRHI/gZ9qWc2MVzx6KVg6ucOtfiXzqx6qbWIdo8wZcUsPnnCWR216eWXWtpPQ4YvLjQ+2bMeodv7CzSTLDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ac0354401so418699339f.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 16:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731200365; x=1731805165;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRhNMRs21KjPWDseISUmDTWFisSHvoC2L/F23mnj4t8=;
        b=STURyq56xRZyBDu/y4EvJ2Kj9jzIjLbhFGOew5x2p0sA9jNlnp7+7/P7Jn0c4rR4hl
         Oiei+2vPDFQUQ8NTKkOUXDdHs6n3bjyl07oNykA6jejYAea+hpSkm/jAhC/Oz/Oprfx4
         GgPFnpRoRUT1Au1TlUFruM1Di1LcPUhCnaWYS0a8a2BqTn9DLNrg28H8qWzTNS96iLOJ
         INZr/vypFviTHFSAlTXpsST/vEWSPOLyWMWjvibbVUjEoOY4bvTH5rv7shBHNcgU1M0X
         1qoHdt7qu9nIyklMLlGV0Lyrl7R4AfQ20IolRYXWtmAGEgs39XpRPi0tkhDl4a5RGpla
         UjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxrQEi7DypA0Y/TLOp36rK2uRq1XUHSsxv0U2AYr5oPUBtIHk5isEPjiFbFgqXk4sVShBS/DwpzgmDnvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHckjKndDX5ipFvHmtYHmjtcFUAWkmh/OdkcA7xE7jN234Gdu
	GIhSKf48jnK9XZr/Y2ei2xK91HOzJrHsyYofm7JPMCiLMMdn+W3GB2DYuChMctV4mMb64ZhmO9u
	DHftwmPs/+MJRtpgm1Kx7kG0UiOJtQ0ZRUa/gQjiRWwCI5F5peJALZJ0=
X-Google-Smtp-Source: AGHT+IHQ58LT/KRMlYoKEnfksYZb/4wroez1blubMKaS86m9cC3nlNeh0TjB5cggfvhgbkbRh+5hueiHsRg5qNUuFjPnPCfzBUoV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1385:b0:3a3:e58d:cfe3 with SMTP id
 e9e14a558f8ab-3a6f19edd46mr83149885ab.8.1731200365261; Sat, 09 Nov 2024
 16:59:25 -0800 (PST)
Date: Sat, 09 Nov 2024 16:59:25 -0800
In-Reply-To: <672f73a6.050a0220.138bd5.0041.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6730056d.050a0220.320e73.031c.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in uevent_show (2)
From: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    226ff2e681d0 usb: typec: ucsi: Convert connector specific ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=132b5e30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=358c1689354aeef3
dashboard link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144614e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172b5e30580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e48f2af8afd7/disk-226ff2e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76328e28b54c/vmlinux-226ff2e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab9f75a466a2/bzImage-226ff2e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com

INFO: task udevd:5169 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00103-g226ff2e681d0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:27904 pid:5169  tgid:5169  ppid:2861   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x1042/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9e4a253b6a
RSP: 002b:00007ffc471c56a8 EFLAGS: 00000246
 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055b598d2b6f0 RCX: 00007f9e4a253b6a
RDX: 0000000000001000 RSI: 000055b598e72930 RDI: 0000000000000008
RBP: 000055b598d2b6f0 R08: 0000000000000008 R09: 0000000000000000
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffc471c5b88 R15: 000000000000000a
 </TASK>
INFO: task udevd:5198 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00103-g226ff2e681d0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:27136 pid:5198  tgid:5198  ppid:2861   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x1042/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9e4a253b6a
RSP: 002b:00007ffc471c56a8 EFLAGS: 00000246
 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055b598d2b6f0 RCX: 00007f9e4a253b6a
RDX: 0000000000001000 RSI: 000055b598e72930 RDI: 0000000000000008
RBP: 000055b598d2b6f0 R08: 0000000000000008 R09: 0000000000008000
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffc471c5b88 R15: 000000000000000a
 </TASK>

Showing all locks held in the system:
7 locks held by kworker/1:0/24:
1 lock held by khungtaskd/30:
 #0: 
ffffffff88ebb140
 (
rcu_read_lock
){....}-{1:2}
, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
5 locks held by kworker/1:2/1080:
2 locks held by getty/2919:
 #0: 
ffff888115b080a0
 (
&tty->ldisc_sem
){++++}-{0:0}
, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: 
ffffc900000432f0
 (
&ldata->atomic_read_lock
){+.+.}-{3:3}
, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
6 locks held by kworker/1:1/5068:
1 lock held by udevd/5168:
4 locks held by udevd/5169:
 #0: 
ffff888114560b08
 (
&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: 
ffff88811ea2c088
 (
&of->mutex
#2
){+.+.}-{3:3}
, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: 
ffff8881133e90f8
 (
kn->active
#5
){.+.+}-{0:0}
, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: 
ffff88811e7e9190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:1014 [inline]
, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
5 locks held by kworker/1:3/5180:
4 locks held by udevd/5187:
5 locks held by kworker/1:4/5188:
3 locks held by kworker/1:5/5193:
4 locks held by udevd/5198:
 #0: ffff888114560418
 (
&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: 
ffff88810e326488
 (
&of->mutex
#2
){+.+.}-{3:3}
, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: 
ffff888113ce13c8
 (
kn->active
#5
){.+.+}-{0:0}
, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: 
ffff888105eee190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:1014 [inline]
, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc6-syzkaller-00103-g226ff2e681d0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf0c/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5187 Comm: udevd Not tainted 6.12.0-rc6-syzkaller-00103-g226ff2e681d0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:io_serial_out+0x8f/0xb0 drivers/tty/serial/8250/8250_port.c:413
Code: 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1c 66 03 5d 40 44 89 e8 89 da ee <5b> 5d 41 5c 41 5d c3 cc cc cc cc e8 11 e5 0d ff eb a0 e8 9a e5 0d
RSP: 0000:ffffc900001b8500 EFLAGS: 00000002
RAX: 000000000000005b RBX: 00000000000003f8 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: ffffffff82a096d5 RDI: ffffffff936396a0
RBP: ffffffff93639660 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000005b R14: ffffffff82a09670 R15: 0000000000000000
FS:  00007f9e4a128c80(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9e49821038 CR3: 000000011f1f6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_out drivers/tty/serial/8250/8250.h:142 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3322 [inline]
 serial8250_console_write+0xf9e/0x17c0 drivers/tty/serial/8250/8250_port.c:3393
 console_emit_next_record kernel/printk/printk.c:3092 [inline]
 console_flush_all+0x800/0xc60 kernel/printk/printk.c:3180
 __console_flush_and_unlock kernel/printk/printk.c:3239 [inline]
 console_unlock+0xd9/0x210 kernel/printk/printk.c:3279
 vprintk_emit+0x424/0x6f0 kernel/printk/printk.c:2407
 dev_vprintk_emit drivers/base/core.c:4942 [inline]
 dev_printk_emit+0xfb/0x140 drivers/base/core.c:4953
 __dev_printk+0xf5/0x270 drivers/base/core.c:4965
 _dev_warn+0xe5/0x120 drivers/base/core.c:5009
 usb_rx_callback_intf0+0x11c/0x1a0 drivers/media/rc/imon.c:1768
 __usb_hcd_giveback_urb+0x389/0x6e0 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1734
 dummy_timer+0x17f0/0x3930 drivers/usb/gadget/udc/dummy_hcd.c:1993
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
 handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:___slab_alloc+0x388/0x1760 mm/slub.c:3887
Code: 44 24 28 00 00 00 00 4c 89 e7 48 8d 35 00 00 00 00 e8 9c 9f 8c ff 80 e7 02 0f 85 f1 04 00 00 9c 58 f6 c4 02 0f 85 76 07 00 00 <48> 8b 45 c8 65 48 2b 04 25 28 00 00 00 0f 85 34 11 00 00 48 8d 65
RSP: 0000:ffffc90001e3fb50 EFLAGS: 00000246
RAX: 0000000000000006 RBX: 0000000000000246 RCX: 1ffffffff1f5bc7f
RDX: 0000000000000000 RSI: ffffffff8727f220 RDI: ffffffff8746ec80
RBP: ffffc90001e3fc30 R08: 0000000000000001 R09: fffffbfff1f565c1
R10: ffffffff8fab2e0f R11: 0000000000000000 R12: ffff8881f59420d0
R13: 0000000000000000 R14: 00000000000420d0 R15: ffff888108329240
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x270/0x2b0 mm/slub.c:4141
 ptlock_alloc+0x1f/0x70 mm/memory.c:6918
 ptlock_init include/linux/mm.h:2958 [inline]
 pagetable_pte_ctor include/linux/mm.h:2985 [inline]
 __pte_alloc_one_noprof include/asm-generic/pgalloc.h:73 [inline]
 pte_alloc_one+0x74/0x390 arch/x86/mm/pgtable.c:33
 do_fault_around mm/memory.c:5249 [inline]
 do_read_fault mm/memory.c:5288 [inline]
 do_fault mm/memory.c:5431 [inline]
 do_pte_missing mm/memory.c:3965 [inline]
 handle_pte_fault mm/memory.c:5766 [inline]
 __handle_mm_fault+0x1d49/0x33b0 mm/memory.c:5909
 handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6077
 do_user_addr_fault+0x613/0x12c0 arch/x86/mm/fault.c:1338
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x55b56813c77c
Code: 48 8b 04 25 28 00 00 00 48 89 84 24 18 08 00 00 31 c0 48 c7 84 24 08 08 00 00 00 00 00 00 48 c7 84 24 10 08 00 00 00 00 00 00 <48> 03 6d 38 48 8b 45 00 48 85 c0 74 6c 49 03 84 24 a8 00 00 00 4d
RSP: 002b:00007ffc471c85a0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00007ffc471c8e98 RDI: 000055b598d587e0
RBP: 00007f9e49821000 R08: 0000000000000001 R09: 00007ffc471c87e8
R10: 0000000000000058 R11: 0000000000000000 R12: 000055b598d587e0
R13: 00007ffc471c8e98 R14: 000055b598d61170 R15: 00007ffc471c9309
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

