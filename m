Return-Path: <linux-kernel+bounces-381580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FBC9B011C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D891F22B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA93A1FF7DB;
	Fri, 25 Oct 2024 11:23:39 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5261F8F0E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855417; cv=none; b=GfUA5OSpjmG7OLszmedI6fXZgTDX2dz5Q5sQBZi5tXj08Zqhx2QukAW91dSkM2+rPiuuWUhebBeulOdULs6nQ29EsfiKrd8Ht8RETyx52F6k5oa2TJ2l5/RY+2qtmxUzfqdsgd26zaYBGsrqR2zLTCf4bA6y7MxsF66vHTEWfSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855417; c=relaxed/simple;
	bh=9j86FlvJFGvRE4F9nmNsGfSTZ7ZDrgnhVJX7DLehtqU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RVb5RiSngOf0ZoBnNq8NpethlhcFDtqSa8ogs44oDjhZk5YqiUkoykfsPifbqFx9EJLU1qsEcRnrXLu7XzA2TduEjKg+OjjWKpdJOVFG9wy6wGkbkG13t3s3RPUNEtIA0as/7X7Rsn07758RjZHuOKgt9TuNTbdVw0soriAPvD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so17119695ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729855411; x=1730460211;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSLVacDkImPZzvLpEjA+h1D4PiuIb5TnV+Xu6Y7Y51c=;
        b=lA+gPeojTdnpS2ww6Q7NbMKwo4Syy2BLsV6Z624Pcq11I/YlBVGgFDWM2UGdKiUc2K
         sJxHjAzM25J9Hc4Cb5uwR4e9VSgzBt11sixchPUDGNfRx/rKk+HGBCnLgHHiTiQJK6If
         KmUTr+P/Xc+BAkmKsLve75vv591daqWwT8TPPY1QyCAx5qooA5XS9Cz2ZdDi5gQrg8Fq
         8zn6hmC/8srEsepigLSAuxsdCnrrkgXMHfJhLq2HReDQ5R6/kFIGW6cYlLPtlH+VKhkt
         OtfS7RexjyU/YOc4ZE+WkZmCU2wEZZCQ/65mYb/4JbhE/8El+SfU4ohg3l5TEr4tEDqo
         wlxg==
X-Forwarded-Encrypted: i=1; AJvYcCXg71RGBTxeteyx52rFq//mKaHXBw2eHtHbScGhWlirVp0dkXLA64siMliopiC+jML5QgkmEOsYb9U1P30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMh/OiK0/EZhFUvSuT1iXu0H7U1X1cF8NpMTGMJSpvVO8YLDW+
	3z8o0RQoVl86idCmvzrQHwjlvLItwXSZBKQgBfHSrVZGA6YZBDgR/zcRuQUj1ah1ZfF6PHeK84t
	wQ29PfFsvi/m8VQFl3MfJU/m+vat7n5i3NjMkSB1RHi1CGn+CM8vg5H0=
X-Google-Smtp-Source: AGHT+IHqZMcM1yZ2gik5tnYXGcO8xL5nkk7Wwi6kD8/4A+/LZjewPtM6uZMu38mL/hTDvi6S/0rSEgpkE355KATI9RZb0nyH1HUT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190a:b0:3a0:9043:59ac with SMTP id
 e9e14a558f8ab-3a4d5a16a52mr97771425ab.25.1729855410871; Fri, 25 Oct 2024
 04:23:30 -0700 (PDT)
Date: Fri, 25 Oct 2024 04:23:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b7fb2.050a0220.2e773.0000.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in vms_complete_munmap_vmas
From: syzbot <syzbot+0ca979b86eaec7337a89@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c6d9e43954bf Merge 6.12-rc4 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=139f225f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a2bb21f91d75c65
dashboard link: https://syzkaller.appspot.com/bug?extid=0ca979b86eaec7337a89
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179f225f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bf4a453ec2f/disk-c6d9e439.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e4a2db2a5d95/vmlinux-c6d9e439.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8eb8e481b288/bzImage-c6d9e439.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ca979b86eaec7337a89@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 1-...D
 } 2686 jiffies s: 2593 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 19905 Comm: modprobe Not tainted 6.12.0-rc4-syzkaller-00052-gc6d9e43954bf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:io_serial_out+0x8f/0xb0 drivers/tty/serial/8250/8250_port.c:413
Code: 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1c 66 03 5d 40 44 89 e8 89 da ee <5b> 5d 41 5c 41 5d c3 cc cc cc cc e8 31 f0 0d ff eb a0 e8 ba f0 0d
RSP: 0018:ffffc900001b7f58 EFLAGS: 00000002
RAX: 0000000000000034 RBX: 00000000000003f8 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: ffffffff82a08975 RDI: ffffffff93637660
RBP: ffffffff93637620 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000034 R14: ffffffff82a08910 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200012b8 CR3: 000000011b4b4000 CR4: 00000000003506f0
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
 vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:68
 _printk+0xc8/0x100 kernel/printk/printk.c:2432
 printk_stack_address arch/x86/kernel/dumpstack.c:72 [inline]
 show_trace_log_lvl+0x21f/0x3d0 arch/x86/kernel/dumpstack.c:285
 sched_show_task kernel/sched/core.c:7604 [inline]
 sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7579
 show_state_filter+0xee/0x320 kernel/sched/core.c:7649
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xed/0x150 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1522 [inline]
 kbd_event+0xcbd/0x17a0 drivers/tty/vt/keyboard.c:1541
 input_handler_events_default+0x116/0x1b0 drivers/input/input.c:2549
 input_pass_values+0x777/0x8e0 drivers/input/input.c:126
 input_event_dispose drivers/input/input.c:352 [inline]
 input_handle_event+0xb30/0x14d0 drivers/input/input.c:369
 input_event drivers/input/input.c:398 [inline]
 input_event+0x83/0xa0 drivers/input/input.c:390
 hidinput_hid_event+0xa12/0x2410 drivers/hid/hid-input.c:1719
 hid_process_event+0x4b7/0x5e0 drivers/hid/hid-core.c:1540
 hid_input_array_field+0x535/0x710 drivers/hid/hid-core.c:1652
 hid_process_report drivers/hid/hid-core.c:1694 [inline]
 hid_report_raw_event+0xa02/0x11c0 drivers/hid/hid-core.c:2040
 __hid_input_report.constprop.0+0x341/0x440 drivers/hid/hid-core.c:2110
 hid_irq_in+0x35e/0x870 drivers/hid/usbhid/hid-core.c:285
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
RIP: 0010:ma_dead_node lib/maple_tree.c:561 [inline]
RIP: 0010:mas_prev_node+0x197/0x10b0 lib/maple_tree.c:4476
Code: 0f 84 58 ff ff ff bb 01 00 00 00 e8 23 0b 74 fa 89 d8 48 83 c4 38 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 09 0b 74 fa <48> b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 80 3c 02 00 0f
RSP: 0018:ffffc900037e7628 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffffc900037e7760 RCX: ffffffff86e1e691
RDX: ffff88811adc57c0 RSI: ffffffff86e1e7b7 RDI: 0000000000000007
RBP: ffff88811dd9e200 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc900037e7778 R15: ffff88811dd9e400
 mas_dfs_postorder lib/maple_tree.c:7089 [inline]
 mt_validate+0x2203/0x41b0 lib/maple_tree.c:7607
 validate_mm+0xae/0x4d0 mm/vma.c:534
 vms_complete_munmap_vmas+0x62c/0x9a0 mm/vma.c:1159
 mmap_region+0x4ce/0x2910 mm/mmap.c:1543
 do_mmap+0xc00/0xfc0 mm/mmap.c:496
 vm_mmap_pgoff+0x1ba/0x350 mm/util.c:588
 ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:79 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:79
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f551d6a0b74
Code: 63 08 44 89 e8 5b 41 5c 41 5d c3 41 89 ca 41 f7 c1 ff 0f 00 00 74 0c c7 05 f5 46 01 00 16 00 00 00 eb 17 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 0c f7 d8 89 05 dc 46 01 00 48 83 c8 ff c3 0f
RSP: 002b:00007fffe534c9e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fffe534ca60 RCX: 00007f551d6a0b74
RDX: 0000000000000001 RSI: 0000000000053000 RDI: 00007f551d554000
RBP: 00007fffe534d180 R08: 0000000000000000 R09: 000000000014b000
R10: 0000000000000812 R11: 0000000000000246 R12: 00007f551d67d5c0
R13: 00007fffe534d208 R14: 000000000014ab8e R15: 0000000000000000
 </TASK>
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0b86606ad5
RSP: 002b:00007ffc505a9cb0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 0000560d8c2afee0 RCX: 00007f0b86606ad5
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000560d8c2b8fe0
RBP: 00007ffc505aa000 R08: 0000000000000008 R09: 0000560d5ee1d3d0
R10: 00007ffc505aa000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000560d5ee1d610 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:26928 pid:2589  tgid:2589  ppid:2586   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0b86606ad5
RSP: 002b:00007ffc505a9cb0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 0000560d8c2afee0 RCX: 00007f0b86606ad5
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000560d8c2b8fe0
RBP: 00007ffc505aa000 R08: 0000000000000008 R09: 0000560d5ee1d3d0
R10: 00007ffc505aa000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000560d5ee1d610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:sshd            state:S stack:27504 pid:2605  tgid:2605  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f05620eaad5
RSP: 002b:00007ffde59a6300 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 0000562e1fb6ea80 RCX: 00007f05620eaad5
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000562e1fb74900
RBP: 0000000000000064 R08: 0000000000000008 R09: 0000000000000000
R10: 00007ffde59a64b8 R11: 0000000000000246 R12: 0000562e1fb74900
R13: 00007ffde59a64b8 R14: 0000000000000002 R15: 0000562e1fb748ec
 </TASK>
task:getty           state:S stack:25424 pid:2607  tgid:2607  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 wait_woken+0x175/0x1c0 kernel/sched/wait.c:423
 n_tty_read+0x10fb/0x1480 drivers/tty/n_tty.c:2277
 iterate_tty_read drivers/tty/tty_io.c:856 [inline]
 tty_read+0x30e/0x5b0 drivers/tty/tty_io.c:931
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x86e/0xbd0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6c70d89b6a
RSP: 002b:00007ffc9581ce88 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00005583c32fe2c0 RCX: 00007f6c70d89b6a
RDX: 0000000000000001 RSI: 00007ffc9581cea0 RDI: 0000000000000000
RBP: 00005583c32fe320 R08: 0000000000000000 R09: 9daa30ea851d932b
R10: 0000000000000010 R11: 0000000000000246 R12: 00005583c32fe35c
R13: 00007ffc9581cea0 R14: 0000000000000000 R15: 00005583c32fe35c
 </TASK>
task:dhcpcd          state:S stack:26368 pid:2609  tgid:2609  ppid:2587   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0b86606ad5
RSP: 002b:00007ffc505a9cb0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 0000560d8c2afee0 RCX: 00007f0b86606ad5
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000560d8c2bad50
RBP: 00007ffc505aa000 R08: 0000000000000008 R09: 0000000000000000
R10: 00007ffc505aa000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000560d5ee1d610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:sshd            state:S stack:25424 pid:2648  tgid:2648  ppid:2605   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_hrtimeout_range_clock+0x272/0x3b0 kernel/time/hrtimer.c:2281
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa545e84ad5
RSP: 002b:00007fff2db4b070 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00000000000668a0 RCX: 00007fa545e84ad5
RDX: 00007fff2db4b090 RSI: 0000000000000004 RDI: 000055bf5a7a8b00
RBP: 000055bf5a7a75c0 R08: 0000000000000008 R09: 0000000000000000
R10: 00007fff2db4b178 R11: 0000000000000246 R12: 000055bf2267aaa4
R13: 0000000000000001 R14: 000055bf2267b3e8 R15: 00007fff2db4b0f8
 </TASK>
task:syz-execprog    state:S stack:25424 pid:2650  tgid:2650  ppid:2648   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_waitid+0x116/0x180 kernel/exit.c:1775
 __do_sys_waitid+0x212/0x250 kernel/exit.c:1788
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x40708e
RSP: 002b:000000c000079d60 EFLAGS: 00000212 ORIG_RAX: 00000000000000f7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 000000000040708e
RDX: 000000c000079e48 RSI: 0000000000000a5f RDI: 0000000000000001
RBP: 000000c000079da0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000001000004 R11: 0000000000000212 R12: 000000c000079e90
R13: 0000000000000000 R14: 000000c001fe1180 R15: 0000000000000001
 </TASK>
task:syz-execprog    state:S stack:27856 pid:2651  tgid:2650  ppid:2648   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
 __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
 futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
 do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x476343
RSP: 002b:000000c000061e80 EFLAGS: 00000202 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000004038860
RBP: 000000c000061ec8 R08: 0000000000000000 R09: 0000000000000000
R10: 000000c000061eb8 R11: 0000000000000202 R12: 000000c000061eb8
R13: 000000c00007e008 R14: 000000c000006540 R15: 0fffffffffffffff
 </TASK>
task:syz-execprog    state:S stack:27360 pid:2652  tgid:2650  ppid:2648   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
 __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
 futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
 do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x476343
RSP: 002b:000000c00007b6e0 EFLAGS: 00000286 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000040abfa0
RBP: 000000c00007b728 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00000000004725e0
R13: 000000c001921808 R14: 000000c001fe1a40 R15: 00003fffffffffff
 </TASK>
task:syz-execprog    state:S stack:26816 pid:2653  tgid:2650  ppid:2648   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
 __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
 futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
 do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x476343
RSP: 002b:000000c000093cf8 EFLAGS: 00000286 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000c00007f148
RBP: 000000c000093d40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 000000c000066008
R13: 0000000000000001 R14: 000000c000006c40 R15: 0000000000000001
 </TASK>
task:syz-execprog    state:S stack:26048 pid:2654  tgid:2650  ppid:2648   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
 __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
 futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
 do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x476343
RSP: 002b:000000c0015dfe48 EFLAGS: 00000286 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000c00057d948
RBP: 000000c0015dfe90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000448320
R13: 000000c00007af94 R14: 000000c00189ea80 R15: 0000000000000007
 </TASK>
task:syz-execprog    state:S stack:30176 pid:2656  tgid:2650  ppid:2648   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
 __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
 futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
 do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x476343
RSP: 002b:000000c0015e3ef0 EFLAGS: 00000286 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000040abe18
RBP: 000000c0015e3f38 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00000000004725e0
R13: 000000c00007f808 R14: 000000c001fe1880 R15: 0001ffffffffffff
 </TASK>
task:syz-execprog    state:S stack:26848 pid:2657  tgid:2650  ppid:2648   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
 __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
 futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
 do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x476343
RSP: 002b:000000c0021e7cf8 EFLAGS: 00000286 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000c001921948
RBP: 000000c0021e7d40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000024
R13: 0000000000000001 R14: 000000c001fe1dc0 R15: 0000000000000001
 </TASK>
task:syz-execprog    state:S stack:27440 pid:2658  tgid:2650  ppid:2648   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
 __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
 futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
 do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x476343
RSP: 002b:000000c0021e3cf8 EFLAGS: 00000286 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000476343
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000c0028e6148
RBP: 000000c0021e3d40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 000000000000002f
R13: 0000000000000001 R14: 000000c0028bd500 R15: 0000000000000001
 </TASK>
task:syz-execprog    state:S stack:27520 pid:14574 tgid:2650  ppid:2648   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_hrtimeout_range_clock+0x272/0x3b0 kernel/time/hrtimer.c:2281
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 do_compat_epoll_pwait.part.0+0x26/0x1d0 fs/eventpoll.c:2493
 do_epoll_pwait fs/eventpoll.c:2500 [inline]
 __do_sys_epoll_pwait fs/eventpoll.c:2506 [inline]
 __se_sys_epoll_pwait fs/eventpoll.c:2500 [inline]
 __x64_sys_epoll_pwait+0x20c/0x330 fs/eventpoll.c:2500
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x40708e
RSP: 002b:000000c0014ad6d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000119
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000040708e
RDX: 0000000000000080 RSI: 000000c0014ad774 RDI: 0000000000000004
RBP: 000000c0014ad718 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000003e7 R11: 0000000000000246 R12: 000000c0014ad7a8
R13: 0000000000000001 R14: 000000c001dc6700 R15: 0000000000000001
 </TASK>
task:syz-executor    state:S stack:23472 pid:2655  tgid:2655  ppid:2654   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_hrtimeout_range_clock+0x272/0x3b0 kernel/time/hrtimer.c:2281
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_select+0x12ec/0x17b0 fs/select.c:604
 core_sys_select+0x459/0xb80 fs/select.c:678
 do_pselect.constprop.0+0x1a0/0x1f0 fs/select.c:760
 __do_sys_pselect6 fs/select.c:803 [inline]
 __se_sys_pselect6 fs/select.c:794 [inline]
 __x64_sys_pselect6+0x183/0x240 fs/select.c:794
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9c9998ddbc
RSP: 002b:00007ffeade2b3a0 EFLAGS: 00000202 ORIG_RAX: 000000000000010e
RAX: ffffffffffffffda RBX: 00007ffeade2b4d0 RCX: 00007f9c9998ddbc
RDX: 0000000000000000 RSI: 00007ffeade2b4d0 RDI: 0000000000000025
RBP: 00007ffeade2b900 R08: 00007ffeade2b3d0 R09: 00007ffeade2b3e0
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffeade2b750
R13: 0000000000000000 R14: 585858582e7a7973 R15: 00007ffeade2b560
 </TASK>
task:kworker/u8:8    state:I stack:24304 pid:3821  tgid:3821  ppid:2      flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:3     state:I stack:28976 pid:5497  tgid:5497  ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/1:3     state:I stack:21728 pid:5499  tgid:5499  ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/1:4     state:I stack:22544 pid:5505  tgid:5505  ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/1:5     state:I stack:27232 pid:5508  tgid:5508  ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:4     state:D stack:23184 pid:10098 tgid:10098 ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 ___down_common+0x2d7/0x460 kernel/locking/semaphore.c:225
 __down_common kernel/locking/semaphore.c:246 [inline]
 __down+0x20/0x30 kernel/locking/semaphore.c:254
 down+0x74/0xa0 kernel/locking/semaphore.c:63
 hid_device_remove+0x29/0x260 drivers/hid/hid-core.c:2749
 device_remove+0xc8/0x170 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3864
 hid_remove_device drivers/hid/hid-core.c:2939 [inline]
 hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2959
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1458
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3864
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:syz-executor    state:D stack:23840 pid:18831 tgid:18831 ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
 synchronize_rcu_expedited+0x290/0x450 kernel/rcu/tree_exp.h:976
 namespace_unlock+0x1b5/0x490 fs/namespace.c:1703
 drop_collected_mounts fs/namespace.c:2225 [inline]
 put_mnt_ns fs/namespace.c:5553 [inline]
 put_mnt_ns+0xf4/0x130 fs/namespace.c:5549
 free_nsproxy+0x47/0x470 kernel/nsproxy.c:193
 put_nsproxy include/linux/nsproxy.h:118 [inline]
 switch_task_namespaces+0xeb/0x100 kernel/nsproxy.c:251
 do_exit+0xad8/0x2ce0 kernel/exit.c:938
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x147/0x260 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f054e954213
RSP: 002b:00007ffd383c1948 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: fffffffffffffe00 RBX: 0000000000000004 RCX: 00007f054e954213
RDX: 0000000040000000 RSI: 00007ffd383c197c RDI: 00000000ffffffff
RBP: 00007ffd383c197c R08: 000000000000f84a R09: 00007f054f64f080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 00000000000676e9 R15: 00007ffd383c19d0
 </TASK>
task:syz-executor    state:S stack:26144 pid:19691 tgid:19691 ppid:2655   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8158d54213
RSP: 002b:00007ffd5db7dc78 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000004cec RCX: 00007f8158d54213
RDX: 0000000040000000 RSI: 00007ffd5db7dc8c RDI: 00000000ffffffff
RBP: 00007ffd5db7dc8c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd5db7dd10
R13: 00007ffd5db7dd18 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
task:syz-executor    state:D stack:23520 pid:19692 tgid:19692 ppid:19691  flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 io_schedule+0xbf/0x130 kernel/sched/core.c:7574
 bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:101 [inline]
 do_get_write_access+0x933/0x1270 fs/jbd2/transaction.c:1096
 jbd2_journal_get_write_access+0x1d6/0x280 fs/jbd2/transaction.c:1245
 __ext4_journal_get_write_access+0x6a/0x390 fs/ext4/ext4_jbd2.c:239
 __ext4_new_inode+0xda1/0x4ec0 fs/ext4/ialloc.c:1088
 ext4_mkdir+0x283/0xb70 fs/ext4/namei.c:3017
 vfs_mkdir+0x57d/0x860 fs/namei.c:4257
 do_mkdirat+0x1b1/0x390 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x83/0xb0 fs/namei.c:4293
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8158d5c897
RSP: 002b:00007ffd5db7dc78 EFLAGS: 00000202 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f8158dd0685 RCX: 00007f8158d5c897
RDX: 00000000000001ff RSI: 00007f8158dd0685 RDI: 00000000ffffff9c
RBP: 00007ffd5db7dd10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd5db7dd10
R13: 00007ffd5db7dd18 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
task:syz-executor    state:S stack:26144 pid:19695 tgid:19695 ppid:2655   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a822c4213
RSP: 002b:00007fff9e1542b8 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000004cf5 RCX: 00007f4a822c4213
RDX: 0000000040000000 RSI: 00007fff9e1542cc RDI: 00000000ffffffff
RBP: 00007fff9e1542cc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff9e154350
R13: 00007fff9e154358 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
task:syz-executor    state:D stack:26784 pid:19701 tgid:19701 ppid:19695  flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_state+0x1c/0x40 kernel/sched/completion.c:264
 call_usermodehelper_exec+0x3c4/0x4d0 kernel/umh.c:442
 call_modprobe kernel/module/kmod.c:103 [inline]
 __request_module+0x3f6/0x6c0 kernel/module/kmod.c:173
 __rtnl_newlink+0x64c/0x1920 net/core/rtnetlink.c:3748
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3772
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 __sys_sendto+0x479/0x4d0 net/socket.c:2214
 __do_sys_sendto net/socket.c:2226 [inline]
 __se_sys_sendto net/socket.c:2222 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2222
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a822cfe33
RSP: 002b:00007fff9e1539c8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f4a82fb4620 RCX: 00007f4a822cfe33
RDX: 0000000000000068 RSI: 00007f4a82fb4670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007fff9e1539e4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f4a82fb4670 R15: 0000000000000000
 </TASK>
task:syz-executor    state:S stack:26144 pid:19703 tgid:19703 ppid:2655   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fde24274213
RSP: 002b:00007ffe2cb21668 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000004cfa RCX: 00007fde24274213
RDX: 0000000040000000 RSI: 00007ffe2cb2167c RDI: 00000000ffffffff
RBP: 00007ffe2cb2167c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe2cb21700
R13: 00007ffe2cb21708 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
task:syz-executor    state:S stack:26144 pid:19705 tgid:19705 ppid:2655   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 do_wait+0x1dd/0x570 kernel/exit.c:1697
 kernel_wait4+0x16c/0x280 kernel/exit.c:1851
 __do_sys_wait4+0x15f/0x170 kernel/exit.c:1879
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0d48944213
RSP: 002b:00007ffe7efd71e8 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000004cfd RCX: 00007f0d48944213
RDX: 0000000040000000 RSI: 00007ffe7efd71fc RDI: 00000000ffffffff
RBP: 00007ffe7efd71fc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe7efd7280
R13: 00007ffe7efd7288 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
task:syz-executor    state:D stack:22832 pid:19706 tgid:19706 ppid:19703  flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 io_schedule+0xbf/0x130 kernel/sched/core.c:7574
 bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:101 [inline]
 do_get_write_access+0x933/0x1270 fs/jbd2/transaction.c:1096
 jbd2_journal_get_write_access+0x1d6/0x280 fs/jbd2/transaction.c:1245
 __ext4_journal_get_write_access+0x6a/0x390 fs/ext4/ext4_jbd2.c:239
 __ext4_new_inode+0xda1/0x4ec0 fs/ext4/ialloc.c:1088
 ext4_mkdir+0x283/0xb70 fs/ext4/namei.c:3017
 vfs_mkdir+0x57d/0x860 fs/namei.c:4257
 do_mkdirat+0x1b1/0x390 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x83/0xb0 fs/namei.c:4293
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fde2427c897
RSP: 002b:00007ffe2cb21668 EFLAGS: 00000206 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007fde242f0685 RCX: 00007fde2427c897
RDX: 00000000000001ff RSI: 00007fde242f0685 RDI: 00000000ffffff9c
RBP: 00007ffe2cb21700 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffe2cb21700
R13: 00007ffe2cb21708 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
task:syz-executor    state:D stack:24784 pid:19709 tgid:19709 ppid:19705  flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 io_schedule+0xbf/0x130 kernel/sched/core.c:7574
 bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:101 [inline]
 do_get_write_access+0x933/0x1270 fs/jbd2/transaction.c:1096
 jbd2_journal_get_write_access+0x1d6/0x280 fs/jbd2/transaction.c:1245
 __ext4_journal_get_write_access+0x6a/0x390 fs/ext4/ext4_jbd2.c:239
 __ext4_new_inode+0xda1/0x4ec0 fs/ext4/ialloc.c:1088
 ext4_mkdir+0x283/0xb70 fs/ext4/namei.c:3017
 vfs_mkdir+0x57d/0x860 fs/namei.c:4257
 do_mkdirat+0x1b1/0x390 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x83/0xb0 fs/namei.c:4293
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0d4894c897
RSP: 002b:00007ffe7efd71e8 EFLAGS: 00000202 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f0d489c0685 RCX: 00007f0d4894c897
RDX: 00000000000001ff RSI: 00007f0d489c0685 RDI: 00000000ffffff9c
RBP: 00007ffe7efd7280 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe7efd7280
R13: 00007ffe7efd7288 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
task:syz.3.53        state:D stack:27856 pid:19844 tgid:19844 ppid:18831  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 synchronize_rcu_expedited+0x392/0x450 kernel/rcu/tree_exp.h:991
 module_remove_driver+0x2e/0x260 drivers/base/module.c:106
 bus_remove_driver+0x143/0x2c0 drivers/base/bus.c:745
 driver_unregister+0x76/0xb0 drivers/base/driver.c:274
 usb_gadget_unregister_driver+0x49/0x70 drivers/usb/gadget/udc/core.c:1732
 raw_release+0x1ae/0x2b0 drivers/usb/gadget/legacy/raw_gadget.c:462
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xadd/0x2ce0 kernel/exit.c:939
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x147/0x260 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f054e95dff9
RSP: 002b:00007ffd383c1718 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffdfc RBX: 00007ffd383c1840 RCX: 00007f054e95dff9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f054eb15f8c
RBP: 00007f054eb15f8c R08: 00007f054f64f080 R09: 00007ffd383c1a0f
R10: 00007ffd383c1820 R11: 0000000000000246 R12: 0000000000067cb1
R13: 00007ffd383c1820 R14: 000000000000015e R15: 0000000000067b53
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:19905 tgid:19905 ppid:50     flags:0x0000400a
Call Trace:
 <IRQ>
 sched_show_task kernel/sched/core.c:7604 [inline]
 sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7579
 show_state_filter+0xee/0x320 kernel/sched/core.c:7649
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xed/0x150 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1522 [inline]
 kbd_event+0xcbd/0x17a0 drivers/tty/vt/keyboard.c:1541
 input_handler_events_default+0x116/0x1b0 drivers/input/input.c:2549
 input_pass_values+0x777/0x8e0 drivers/input/input.c:126
 input_event_dispose drivers/input/input.c:352 [inline]
 input_handle_event+0xb30/0x14d0 drivers/input/input.c:369
 input_event drivers/input/input.c:398 [inline]
 input_event+0x83/0xa0 drivers/input/input.c:390
 hidinput_hid_event+0xa12/0x2410 drivers/hid/hid-input.c:1719
 hid_process_event+0x4b7/0x5e0 drivers/hid/hid-core.c:1540
 hid_input_array_field+0x535/0x710 drivers/hid/hid-core.c:1652
 hid_process_report drivers/hid/hid-core.c:1694 [inline]
 hid_report_raw_event+0xa02/0x11c0 drivers/hid/hid-core.c:2040
 __hid_input_report.constprop.0+0x341/0x440 drivers/hid/hid-core.c:2110
 hid_irq_in+0x35e/0x870 drivers/hid/usbhid/hid-core.c:285
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
RIP: 0010:ma_dead_node lib/maple_tree.c:561 [inline]
RIP: 0010:mas_prev_node+0x197/0x10b0 lib/maple_tree.c:4476
Code: 0f 84 58 ff ff ff bb 01 00 00 00 e8 23 0b 74 fa 89 d8 48 83 c4 38 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 09 0b 74 fa <48> b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 80 3c 02 00 0f
RSP: 0018:ffffc900037e7628 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffffc900037e7760 RCX: ffffffff86e1e691
RDX: ffff88811adc57c0 RSI: ffffffff86e1e7b7 RDI: 0000000000000007
RBP: ffff88811dd9e200 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc900037e7778 R15: ffff88811dd9e400
 mas_dfs_postorder lib/maple_tree.c:7089 [inline]
 mt_validate+0x2203/0x41b0 lib/maple_tree.c:7607
 validate_mm+0xae/0x4d0 mm/vma.c:534
 vms_complete_munmap_vmas+0x62c/0x9a0 mm/vma.c:1159
 mmap_region+0x4ce/0x2910 mm/mmap.c:1543
 do_mmap+0xc00/0xfc0 mm/mmap.c:496
 vm_mmap_pgoff+0x1ba/0x350 mm/util.c:588
 ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:79 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:79
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f551d6a0b74
Code: 63 08 44 89 e8 5b 41 5c 41 5d c3 41 89 ca 41 f7 c1 ff 0f 00 00 74 0c c7 05 f5 46 01 00 16 00 00 00 eb 17 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 0c f7 d8 89 05 dc 46 01 00 48 83 c8 ff c3 0f
RSP: 002b:00007fffe534c9e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fffe534ca60 RCX: 00007f551d6a0b74
RDX: 0000000000000001 RSI: 0000000000053000 RDI: 00007f551d554000
RBP: 00007fffe534d180 R08: 0000000000000000 R09: 000000000014b000
R10: 0000000000000812 R11: 0000000000000246 R12: 00007f551d67d5c0
R13: 00007fffe534d208 R14: 000000000014ab8e R15: 0000000000000000
 </TASK>
task:syz-executor    state:D stack:26144 pid:20285 tgid:20285 ppid:2655   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 io_schedule+0xbf/0x130 kernel/sched/core.c:7574
 bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:101 [inline]
 do_get_write_access+0x933/0x1270 fs/jbd2/transaction.c:1096
 jbd2_journal_get_write_access+0x1d6/0x280 fs/jbd2/transaction.c:1245
 __ext4_journal_get_write_access+0x6a/0x390 fs/ext4/ext4_jbd2.c:239
 ext4_reserve_inode_write+0x13b/0x270 fs/ext4/inode.c:5773
 __ext4_mark_inode_dirty+0x1a6/0x890 fs/ext4/inode.c:5947
 ext4_dirty_inode+0xd9/0x130 fs/ext4/inode.c:5984
 __mark_inode_dirty+0x1f6/0xe60 fs/fs-writeback.c:2493
 mark_inode_dirty include/linux/fs.h:2474 [inline]
 ext4_setattr+0x33e/0x26e0 fs/ext4/inode.c:5508
 notify_change+0x6a6/0x1230 fs/attr.c:503
 chmod_common+0x1f6/0x450 fs/open.c:653
 do_fchmodat fs/open.c:701 [inline]
 __do_sys_chmod fs/open.c:725 [inline]
 __se_sys_chmod fs/open.c:723 [inline]
 __x64_sys_chmod+0x108/0x1c0 fs/open.c:723
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f97877ec837
RSP: 002b:00007ffc4f4c0eb8 EFLAGS: 00000202 ORIG_RAX: 000000000000005a
RAX: ffffffffffffffda RBX: 00007ffc4f4c0f20 RCX: 00007f97877ec837
RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffc4f4c0f20
RBP: 0000000000000002 R08: 0000000000000004 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000202 R12: 00007ffc4f4c0f20
R13: 00007ffc4f4c0f28 R14: 0000000000000009 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:4/50:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000527d80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by getty/2607:
 #0: ffff88810ff760a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
6 locks held by kworker/0:4/10098:
 #0: ffff888105ef6d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000209fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109b12190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109b12190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811366e190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88811366e190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff8881052c8160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff8881052c8160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff8881052c8160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffff88812f6f9a20 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #5: ffff88812f6f9a20 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #5: ffff88812f6f9a20 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
1 lock held by syz-executor/18831:
 #0: ffffffff88ec6a38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
3 locks held by syz-executor/19692:
 #0: ffff8881144343f8 (sb_writers#5){.+.+}-{0:0}, at: filename_create+0x10d/0x530 fs/namei.c:4019
 #1: ffff888118dd03f8 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
 #1: ffff888118dd03f8 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: filename_create+0x1c2/0x530 fs/namei.c:4026
 #2: ffff888114480958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf6c/0x1430 fs/jbd2/transaction.c:448
3 locks held by syz-executor/19706:
 #0: ffff8881144343f8 (sb_writers#5){.+.+}-{0:0}, at: filename_create+0x10d/0x530 fs/namei.c:4019
 #1: ffff888118dd1798 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
 #1: ffff888118dd1798 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: filename_create+0x1c2/0x530 fs/namei.c:4026
 #2: ffff888114480958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf6c/0x1430 fs/jbd2/transaction.c:448
3 locks held by syz-executor/19709:
 #0: ffff8881144343f8 (sb_writers#5){.+.+}-{0:0}, at: filename_create+0x10d/0x530 fs/namei.c:4019
 #1: ffff888118dd2168 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
 #1: ffff888118dd2168 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: filename_create+0x1c2/0x530 fs/namei.c:4026
 #2: ffff888114480958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf6c/0x1430 fs/jbd2/transaction.c:448
1 lock held by syz.3.53/19844:
 #0: ffffffff88ec6a38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:297
5 locks held by modprobe/19905:
 #0: ffff88812f699d58 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #0: ffff88812f699d58 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x160/0x350 mm/util.c:586
 #1: ffff8881056b9230 (&dev->event_lock){..-.}-{2:2}, at: input_event drivers/input/input.c:397 [inline]
 #1: ffff8881056b9230 (&dev->event_lock){..-.}-{2:2}, at: input_event+0x70/0xa0 drivers/input/input.c:390
 #2: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: input_pass_values+0x8b/0x8e0 drivers/input/input.c:118
 #3: ffffffff89387a58 (kbd_event_lock){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffffffff89387a58 (kbd_event_lock){..-.}-{2:2}, at: kbd_event+0x8a/0x17a0 drivers/tty/vt/keyboard.c:1535
 #4: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #4: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #4: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
3 locks held by syz-executor/20285:
 #0: ffff8881144343f8 (sb_writers#5){.+.+}-{0:0}, at: chmod_common+0x106/0x450 fs/open.c:643
 #1: ffff888118dd2b38 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff888118dd2b38 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: chmod_common+0x171/0x450 fs/open.c:647
 #2: ffff888114480958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf6c/0x1430 fs/jbd2/transaction.c:448

=============================================

keytouch 0003:0926:3333.0013: can't resubmit intr, dummy_hcd.3-1/input0, status -19
keytouch 0003:0926:3333.0013: usb_submit_urb(ctrl) failed: -19


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

