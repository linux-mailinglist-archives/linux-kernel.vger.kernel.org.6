Return-Path: <linux-kernel+bounces-199145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A40198D82FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E52B23AB6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2253612C550;
	Mon,  3 Jun 2024 12:55:26 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2927012CDBC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419322; cv=none; b=dFeL+ZN+Lv6GkY6OpBZw1DmaAAg33zQs//bmBAwH4fqWI2efpiuh9gOw+42mcK9TPscNVy0JFWk1GNbSvrmjNm9sNm6RkXXEDhBH7c3gmmzBNM7UtxLz7oiqebOuvaVl81KPfFguqGnEw1SE1cNp3Oul7Uc87Q2ElktnCdIA+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419322; c=relaxed/simple;
	bh=mRxHyq55lDdM2BHWSFFEJ1rN2qcs9zMcj9BNNfwaTkg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rz2Tbl1zv+pJfxWxVcLGkEke5WcPG7vPy4PqIF1ZKsZdjcyaaDXM3p3K5ST5DScJQCn/vkiNDQXlWSz3aduscid+4z0j1lIg5OCsQseGVo/wUUrv5ZMljbHvIe4g9Ijgz4jw/XE+GkMJ850erJAyhzSzIYTOsGrtu6cMMyVIPo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-37490e4eab9so21707845ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419318; x=1718024118;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1shOlC2IMnrGkm9Brin0PEVqB+U2ImSN3h7IOknuKM=;
        b=hDRpKfeU+cjACj37zY6ZhCX0GT91yTteWbg8Um/vouxyW4gtQNMoXtIcyzhC5Bm6qr
         UXkXItXNWUOML5NwMhkASWNw015YYPhkNryIcWbb58+0w8DUKvuj3yQ9kXoLvmG20WW0
         vAz46XP9TMcE+o6oDIvrE45EV/G3vMM63eSYWv8OynU2U+fBoGnqQsDEaOD/MxtLzcK/
         km1wd3qEgAbPDamoQFRSozd7c9AkDKNtaKeshQ2fTow3WaUwEQ5GXwZLrhaXpCH/9E5K
         KEiIDFbLIbqPG5i09ogah+p/HhQ+gIKlFNg3lzDaP7VbleklD0AftN5psaL+HTC8a+TM
         vxoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXgFpH8TX30aJeYkTAJv2FYPXVYYq+3gZ0iPfaf0ORGGFmukvfYc92BTkUV1vourEc6wh94/sRuGuwDB7zPrNP0wjkNOIYM0MGiDly
X-Gm-Message-State: AOJu0Yzv8GtDtFml/q99pt1uyzag+P9vLFsQ/mOjEdg06vT47gSdlONk
	u+8TdmUbmASbzn4fy+Td+pdfTJwEX/ZHTAVN3CnESgxXSSDnyOuys/gmovBlxtmMYJzsnWhxxM6
	7OgdpUPA3dYBa5L16IKb3kpWA7RylTLlOUs2gc05TBC0ecEtsU8bgA9k=
X-Google-Smtp-Source: AGHT+IF7dLXVHWqxaS0r/NamWzEyctsfzNmbyQaQXoBJCAFk6cH6zIa0+O3et8RE6nV0nuixbnYdnILrhBTUg1SPq7ycibbmYScx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1e:b0:374:a422:ba7 with SMTP id
 e9e14a558f8ab-374a4220e6emr1023695ab.2.1717419318258; Mon, 03 Jun 2024
 05:55:18 -0700 (PDT)
Date: Mon, 03 Jun 2024 05:55:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006541c50619fbd892@google.com>
Subject: [syzbot] [usb?] INFO: rcu detected stall in process_one_work (9)
From: syzbot <syzbot+445ada2020fd8c1f5377@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1613e604df0c Linux 6.10-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1114cfd6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=646e4dd5bdb5b575
dashboard link: https://syzkaller.appspot.com/bug?extid=445ada2020fd8c1f5377
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14671a16980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1249a6ba980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c7dc561d5a63/disk-1613e604.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8d0fe2626396/vmlinux-1613e604.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a4ff6c60c817/bzImage-1613e604.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+445ada2020fd8c1f5377@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-....
 } 2686 jiffies s: 1033 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 1 to CPUs 0:
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
NMI backtrace for cpu 0
CPU: 0 PID: 2577 Comm: kworker/0:6 Not tainted 6.10.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: mm_percpu_wq vmstat_update
RIP: 0010:io_serial_out+0x8f/0xb0 drivers/tty/serial/8250/8250_port.c:413
Code: 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1c 66 03 5d 40 44 89 e8 89 da ee <5b> 5d 41 5c 41 5d c3 cc cc cc cc e8 51 05 0b ff eb a0 e8 da 05 0b
RSP: 0018:ffffc900000075c0 EFLAGS: 00000002
RAX: 000000000000005b RBX: 00000000000003f8 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: ffffffff829a9955 RDI: ffffffff8d71fc60
RBP: ffffffff8d71fc20 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000000
R13: 000000000000005b R14: ffffffff829a98f0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881f6400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffe156bf38 CR3: 0000000111c66000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_out drivers/tty/serial/8250/8250.h:122 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3322 [inline]
 serial8250_console_write+0xce7/0x1090 drivers/tty/serial/8250/8250_port.c:3393
 console_emit_next_record kernel/printk/printk.c:2928 [inline]
 console_flush_all+0x53c/0xd70 kernel/printk/printk.c:2994
 console_unlock+0xae/0x290 kernel/printk/printk.c:3063
 vprintk_emit kernel/printk/printk.c:2345 [inline]
 vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2300
 dev_vprintk_emit drivers/base/core.c:4951 [inline]
 dev_printk_emit+0xfb/0x140 drivers/base/core.c:4962
 __dev_printk+0xf5/0x270 drivers/base/core.c:4974
 _dev_err+0xe5/0x120 drivers/base/core.c:5017
 urb_ctl_callback+0x1eb/0x2f0 drivers/input/misc/yealink.c:454
 __usb_hcd_giveback_urb+0x364/0x5c0 drivers/usb/core/hcd.c:1648
 usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1732
 dummy_timer+0x17f6/0x3900 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x8b/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
Code: 90 f3 0f 1e fa 53 48 8b 74 24 08 48 89 fb 48 83 c7 18 e8 da 3c 9c fa 48 89 df e8 c2 b9 9c fa e8 8d 57 c5 fa fb bf 01 00 00 00 <e8> 02 30 91 fa 65 8b 05 83 9c 6e 79 85 c0 74 06 5b c3 cc cc cc cc
RSP: 0018:ffffc9000148fcb8 EFLAGS: 00000206
RAX: 00000000000012f3 RBX: ffff8881f643c7c0 RCX: 1ffffffff137b4d9
RDX: 0000000000000000 RSI: ffffffff86c7d680 RDI: 0000000000000001
RBP: ffff8881f6438400 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff89bde057 R11: 0000000000000001 R12: ffff888104b5ba00
R13: 0000000000000000 R14: 0000000000000001 R15: ffff8881000aa800
 process_one_work+0x849/0x1b60 kernel/workqueue.c:3200
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.123 msecs
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
raw-gadget.4 gadget.4: ignoring, device is not running
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: unexpected response 0
raw-gadget.4 gadget.4: ignoring, device is not running
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 3-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_ctl_callback - usb_submit_urb failed -19
yealink 4-1:36.0: urb_irq_callback - urb status -71
raw-gadget.4 gadget.4: ignoring, device is not running
yealink 4-1:36.0: unexpected response 0
raw-gadget.4 gadget.4: ignoring, device is not running
yealink 4-1:36.0: urb_ctl_callback - urb status -71
raw-gadget.4 gadget.4: ignoring, device is not running
yealink 4-1:36.0: urb_irq_callback - urb status -71
raw-gadget.4 gadget.4: ignoring, device is not running
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
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_ca

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

