Return-Path: <linux-kernel+bounces-191025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E58D05B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D992908C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EE217E8F2;
	Mon, 27 May 2024 15:00:37 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37917E8E3
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822034; cv=none; b=UvKJ/VEzB8M0V6B30XYSDBZfYufQSv/x+RvF5futTVkdxGnQDnMJxEgG9wT+uK0oBgQVEG/+QhajuQtT1YTOLelBzK6HUfpu26dNwLMSl6lxFkMdt7huGeM/O2+090eMIEwoMAndzkJ8vswNnqt2AWvQh07s/CKNP+6WZDyF8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822034; c=relaxed/simple;
	bh=RR3iBiS2k7lLE4lqJpwV7q+kNhSWTnPG7lXEvhuML9s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hmrT/f+CZ/DguyjnsQU+95Vr8k3s3py+blRB/jglUUPL6fy/5lyRi6trQkZ9u123De/SwIc5pCRkgblorjfzuNT6PumqbnIPUXZOQeSYlPBUfl3fnM+ulF9n7tMCZGdNfQ5FlQCXI6bDW+vK+dhTK3MzotMx+yvSiivTv5v/VPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7ea87fb4fdfso161166939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716822030; x=1717426830;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUU42q8A4mXbkcKsUDzAC90jAnS+vHT8Fkk0W2VGVyE=;
        b=D6sjJYapQfzHunyNg4EIFR+7XM5L8UIOFQSFLmxFfMhsLsnynaCT8D9kBIGbCS0R68
         6FiX8CAvg0bXP06as1/6uNkkuL3yOJbE5nI7eT74e6tLHsQdXKjZfg7yJE1GZ88ozLvQ
         0TzZ77WEPnb21mCBq9Y2lTHLt53tI/FGhplRyReZWNdFT5jQIsKc7KRUiusGyfCBP7f6
         V8CyA/JzKm8KPnoUYrdhT5mXscUf+JeUD/7hqyKT7ckTxoqo10IWsHzXxAMgD/Fe3mC2
         ZykjRR9MSxLAAcX6zlPBwmTlGpkNGo30EsMzKJiX+p/cluxq4GCQOEcByeXeaL8BGEiZ
         kXxg==
X-Forwarded-Encrypted: i=1; AJvYcCVMSftQeqy2I2qehyFtePC1X547Lls4IK7A7YdGkscgMPaSjz6EQr+qbuyxVJwYQUOy5UvM+y3Fu4qV3r/2hpUjMvF4n639uXAg/ScU
X-Gm-Message-State: AOJu0YyDrnZJF2R9l+elqRzF4ocgeIZeWkaPyogO1oeICavTE5L5szyi
	yGCBqxv9eWJuKG0zAGaaHSioTm4QxtO1FBKb+aYe09hvJz69r91fSZLQI/6wpdul7NcuLCiTG7u
	RrEJpB0OMaAlaL+8dA6m9fV+kAXiWtWlW7Sz7HteCWOVepRKOrteQ8xY=
X-Google-Smtp-Source: AGHT+IGwQFJ9oi8y4DNXtJyX9CgKjirXjVl/SQ0xboi8O3x2pke9UJzS6TNNXMkepbOENzqczyvcdeIvdEnEOuVWKBsvEmRDdZr0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14d1:b0:4b0:7e11:8d19 with SMTP id
 8926c6da1cb9f-4b07e119393mr229210173.5.1716822030151; Mon, 27 May 2024
 08:00:30 -0700 (PDT)
Date: Mon, 27 May 2024 08:00:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ffe8e061970c77b@google.com>
Subject: [syzbot] [usb?] INFO: rcu detected stall in schedule (7)
From: syzbot <syzbot+005409b89b9a9675cb2a@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, oneukum@suse.com, peterz@infradead.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3689b0ef08b7 Add linux-next specific files for 20240523
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10b07784980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62be2ac813b33670
dashboard link: https://syzkaller.appspot.com/bug?extid=005409b89b9a9675cb2a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b23768980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14179e8a980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d419c45ce6a6/disk-3689b0ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0965ad9f9d7/vmlinux-3689b0ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/996054c29da2/bzImage-3689b0ef.xz

The issue was bisected to:

commit b3e40fc85735b787ce65909619fcd173107113c2
Author: Oliver Neukum <oneukum@suse.com>
Date:   Thu May 2 11:51:40 2024 +0000

    USB: usb_parse_endpoint: ignore reserved bits

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f47784980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12f47784980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14f47784980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+005409b89b9a9675cb2a@syzkaller.appspotmail.com
Fixes: b3e40fc85735 ("USB: usb_parse_endpoint: ignore reserved bits")

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... } 2669 jiffies s: 465 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
yealink 1-1:36.0: urb_ctl_callback - urb status -71
NMI backtrace for cpu 1
CPU: 1 PID: 23 Comm: migration/1 Not tainted 6.9.0-next-20240523-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Stopper: 0x0 <- 0x0
RIP: 0010:get_current arch/x86/include/asm/current.h:49 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x8/0x70 kernel/kcov.c:206
Code: 8b 3d 5c 7f 45 0c 48 89 de 5b e9 63 60 5a 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 04 24 <65> 48 8b 0c 25 00 d5 03 00 65 8b 15 80 91 6d 7e f7 c2 00 01 ff 00
RSP: 0018:ffffc90000a17c98 EFLAGS: 00000006
RAX: ffffffff8b83fc32 RBX: ffffffff8bcb7fa0 RCX: ffff8880176b5a00
RDX: 0000000000000002 RSI: ffffffff8f9509e0 RDI: 000000000000005b
RBP: ffffc90000a17d90 R08: 0000000000000001 R09: ffffffff8b83fc1a
R10: 0000000000000002 R11: ffff8880176b5a00 R12: ffffffff8bcb7fa0
R13: ffffffff8bcb7fa0 R14: dffffc0000000000 R15: 000000000000005b
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa4d5698128 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 format_decode+0x212/0x1bb0 lib/vsprintf.c:2558
 vsnprintf+0x14f/0x1da0 lib/vsprintf.c:2776
 sprintf+0xda/0x120 lib/vsprintf.c:3028
 print_time kernel/printk/printk.c:1327 [inline]
 info_print_prefix+0x16b/0x310 kernel/printk/printk.c:1353
 record_print_text kernel/printk/printk.c:1402 [inline]
 printk_get_next_message+0x6da/0xbe0 kernel/printk/printk.c:2855
 console_emit_next_record kernel/printk/printk.c:2895 [inline]
 console_flush_all+0x410/0xfd0 kernel/printk/printk.c:2994
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3063
 vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2345
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4951
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4962
 _dev_err+0x122/0x170 drivers/base/core.c:5017
 urb_ctl_callback+0x1d3/0x290 drivers/input/misc/yealink.c:454
 __usb_hcd_giveback_urb+0x373/0x530 drivers/usb/core/hcd.c:1648
 dummy_timer+0x830/0x45d0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5282
Code: c9 50 e8 e9 cb 0b 00 48 83 c4 08 4c 89 f7 e8 cd 38 00 00 0f 1f 44 00 00 4c 89 f7 e8 f0 dc 2e 0a e8 cb fc 36 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffc900001d7ba8 EFLAGS: 00000286
RAX: b5209054ff53a900 RBX: ffff8880176b5a00 RCX: ffffffff947ae603
RDX: dffffc0000000000 RSI: ffffffff8bcabaa0 RDI: ffffffff8c1fe6c0
RBP: ffffc900001d7bf0 R08: ffffffff8fad53af R09: 1ffffffff1f5aa75
R10: dffffc0000000000 R11: fffffbfff1f5aa76 R12: 1ffff110172a7ea7
R13: dffffc0000000000 R14: ffff8880b953e7c0 R15: ffff8880b953f538
 context_switch kernel/sched/core.c:5411 [inline]
 __schedule+0x17f0/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.272 msecs
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - usb_submit_urb failed -19
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: urb_irq_callback - usb_submit_urb failed -19
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - usb_submit_urb failed -19
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

