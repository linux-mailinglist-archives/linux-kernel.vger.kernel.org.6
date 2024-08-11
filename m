Return-Path: <linux-kernel+bounces-282418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E1994E3B7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 00:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4FA282206
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D71D161326;
	Sun, 11 Aug 2024 22:40:22 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733BE14D2B7
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723416022; cv=none; b=GkNLdB6ruG6fIO/0BFGHU+a0P01d/JJ5sQ5r8rrtth+iXgdT4XP0gvALjtcbRM8qwraHOy6kOqHPK26pzu9MShsvkakvh2oZutjQRWgGB8Fm+g+QlYw7L50BFhAOq6CEUxj6ewBIey8qnXe4pZuUrmp3H+KqO2yeavFmm9kQ9R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723416022; c=relaxed/simple;
	bh=leUMh2qo7QzZpKBDzT9KqI/UJuSQUCBZiZbeCLhNtD0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G6ro0pti0JpDKenaTGZczzVRc5ETJOigDPl7JxLSCMtcb8VUGlpQt0YJEsllvJNfqwM5G9D76a9Q8bXXR1euH6LwrSmitJPNnxUKgtp/QNzk+jATTqOBK+h9sSa73lL4VSA4uldpF2u4f6DAtFLhPhg8Y8SZ8THptw8vEqp8hp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3f65b494so51681265ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723416019; x=1724020819;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tYasqZF3YtZYdGmEDfK9JZOWuAd4dwul38b2+jaoZB0=;
        b=XKtmV9G/qEerheCQFE1N/gYHHWJm7B3IFutRkdXjwkdlmouItMbZ2EhtXN4GlXxblk
         TMQTAH8d+uHuWHaXeeSH0ELNbNDELmAFuEbnCdrEXP7u/glFn0oCXNGrhto+B6BVdZ5N
         yQZphbicUuSDeGkWgBaCOTn0MUypQO6O/67Gk+tnjxvUoXQum4ALIutzzNn3NaqvGhLh
         xtjXCo1R2qrOPNq+s5Ljh7kMJsaCB3LyNmgTvYTUND978XGHWmbLdRUv6adKe/lLo1jc
         PK7nenV5Zc/DOOpoy/OHy+8o9xuughwMgpntbUvRj7j3iSiYz9kO/9JpGZpJEKsPb+NP
         Q/mA==
X-Forwarded-Encrypted: i=1; AJvYcCXU4dB4WtAF7l0oA2smOlMPuvskQqtOitAA05QOQ0ytkS9+1UOgkc5xPCnulYuSqPIsW7e0lOKSRCB2F8p90w0m3PORbTjdTe5blMoY
X-Gm-Message-State: AOJu0Yxb3164xpdRHL0Gz4HADZE7/2yjxJCGrVLBGT/L5qzNCc270ijY
	97mPmaOcGs+fMRgCPOC1+An0pFilSEAzEf3bm2NXTA1tBSUibQHcIPSMmZH3q1sxhY6IyVUrQut
	5yTgwpjC+iSzJjM9JfmTafkB/PEqk4cKwS7pgr/KLLUcOFEfXfnT/ZbM=
X-Google-Smtp-Source: AGHT+IHmY4MDamWEAhHDqqB71m/5l8EMGICS066NNiRPB/6kV89zDidJUKDw9w4DDGdL9mw+JjaItth+qM2l8NUGAmjXWbCCuCk0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:862a:b0:4c0:a90d:4a78 with SMTP id
 8926c6da1cb9f-4ca6ee06dd2mr147893173.6.1723416019545; Sun, 11 Aug 2024
 15:40:19 -0700 (PDT)
Date: Sun, 11 Aug 2024 15:40:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a53ecf061f700fbf@google.com>
Subject: [syzbot] [usb?] KMSAN: uninit-value in bcmp (3)
From: syzbot <syzbot+0399100e525dd9696764@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a0e38264012 Merge tag 'for-6.11-rc2-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bd11c9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=305509ad8eb5f9b8
dashboard link: https://syzkaller.appspot.com/bug?extid=0399100e525dd9696764
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/31249d4202ea/disk-6a0e3826.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b1dd9804fd7/vmlinux-6a0e3826.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a3a8887ee631/bzImage-6a0e3826.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in memcmp lib/string.c:665 [inline]
BUG: KMSAN: uninit-value in bcmp+0xc3/0x1c0 lib/string.c:697
 memcmp lib/string.c:665 [inline]
 bcmp+0xc3/0x1c0 lib/string.c:697
 iowarrior_callback+0x3fe/0xa30 drivers/usb/misc/iowarrior.c:185
 __usb_hcd_giveback_urb+0x572/0x840 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x157/0x720 drivers/usb/core/hcd.c:1734
 dummy_timer+0xd3f/0x6aa0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x564/0xe40 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x3ab/0x1490 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0xa6/0x3a0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x7e/0x90 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 native_irq_enable arch/x86/include/asm/irqflags.h:42 [inline]
 arch_local_irq_enable arch/x86/include/asm/irqflags.h:97 [inline]
 raw_spin_rq_unlock_irq kernel/sched/sched.h:1427 [inline]
 finish_lock_switch kernel/sched/core.c:4942 [inline]
 finish_task_switch+0x19a/0x8f0 kernel/sched/core.c:5060
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0x2094/0x6580 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x13d/0x380 kernel/sched/core.c:6621
 smpboot_thread_fn+0x704/0xa60 kernel/smpboot.c:160
 kthread+0x3dd/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3994 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kmalloc_array_noprof include/linux/slab.h:726 [inline]
 iowarrior_probe+0x10ea/0x1b90 drivers/usb/misc/iowarrior.c:836
 usb_probe_interface+0xd6f/0x1350 drivers/usb/core/driver.c:399
 really_probe+0x4db/0xd90 drivers/base/dd.c:657
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:799
 driver_probe_device+0x72/0x890 drivers/base/dd.c:829
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:957
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1029
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1078
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
 device_add+0x13aa/0x1ba0 drivers/base/core.c:3679
 usb_set_configuration+0x31c9/0x38d0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x109/0x2a0 drivers/usb/core/generic.c:254
 usb_probe_device+0x3a7/0x690 drivers/usb/core/driver.c:294
 really_probe+0x4db/0xd90 drivers/base/dd.c:657
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:799
 driver_probe_device+0x72/0x890 drivers/base/dd.c:829
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:957
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1029
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1078
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
 device_add+0x13aa/0x1ba0 drivers/base/core.c:3679
 usb_new_device+0x15f4/0x2470 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x4ff8/0x72d0 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea5/0x1520 kernel/workqueue.c:3390
 kthread+0x3dd/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.11.0-rc2-syzkaller-00027-g6a0e38264012 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


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

