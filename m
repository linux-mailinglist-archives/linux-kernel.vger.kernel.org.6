Return-Path: <linux-kernel+bounces-444767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF169F0C42
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5292820E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527071DEFEC;
	Fri, 13 Dec 2024 12:30:30 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC41C3C0F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093029; cv=none; b=thfQDUM4fjH97GU2UPzwEW9c3w7wQ+8H1N5x/zyc/bp/Gzz6jj3TdOtJ0035tcHcYm77gO7/8S/PdRtiY+YQwQi3WP4WZi600/qNYDA03XzDHxYHQ1CwSunjFn2lxOxH1Xo6gpLZH+ZlCytVU/se9BCW3/p1Ggmlrl6j5YgJDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093029; c=relaxed/simple;
	bh=8OGM1raK/8vivkCSo9Ap2751L5+sSe5un9KY/Av/nh0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ktZFafK9UZ/Pjo7JCP0Ch6UNqkehNsdPfEh4d9GMMuzD5G1+ufDo9bK+n4qpvoolkd64jkZATNYG6Kdcre1n+ExvEVq3V4+ACVuel4umR5vzr9Ya3hDGy/A0GoduDOAmkSi1hoMxdLRDn+IY2cYO1TVO5zpmxg/wG1KIdFOZL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-844dadd9bdcso318349639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734093025; x=1734697825;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3A8RlaKJD15/a+kfFGaspTfrEe6hXXSG8+izJ+pp+M=;
        b=lKq0JtXbVqh0FHWx+nZmnzQkyaRCezeYDkmZxxllWjo7bxFeMCK3FZA+8Z2TGMlq85
         jH3F6vffVdEnAb4Wlet0x0pZ914Kpb1F0z9yptWEzfdKg2f9/FHQbguays6XmMRLJBLN
         6ur9tSvU0AKhxCmEsyQfgiUxZI3sD/2Wrwunshno+sjP/D83Z4i5KRL0nWQbYstd4aQR
         qbpAIlsjCc3wORg0/rPzQ8ttOBps+9MBNBoHllSWFlIIg8o0eS36mW1qVOQbgWrmQIpG
         VuPJGdwAQildZJpu5vHHXT696zycUeGnow3dJ8oFf+eLDfOI7DVGnnMlA1TcNvplFoL3
         +YCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuzYnIGh01DuhqUGK2jvSOvQ88yL1tGvWo3hQ7kLV1gi2VluHYI2O1Cc6yD/jgeSyTk70LzDUpTOhv6fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDVLxTZBFPyS4wYf/6uOzAeabC8N0DXFhqSL6w31d3wamksKt
	mbpCzlh16xWOMO+p+Qjm281fh5YHVS6UNtwERDqQIQ2gSVr471hvZMObvH1JZDm6WwjAwk/Z778
	Dkqr6diOU2alJs/JnEZ9gmKscnWpIo5aiIAyVNRuOIadPbVoxRNcEipM=
X-Google-Smtp-Source: AGHT+IE3ezJ4xa0Tql3aWVMl89qDDJ5xCqdkWR6wS8RdjtuKn9kSAsEvJabCRtqRaguCmRn0+gYpDm8klOi5Is6k3/8fyV/P7pR7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a84:b0:3a7:e147:812f with SMTP id
 e9e14a558f8ab-3afee3c5b42mr31468565ab.12.1734093025013; Fri, 13 Dec 2024
 04:30:25 -0800 (PST)
Date: Fri, 13 Dec 2024 04:30:24 -0800
In-Reply-To: <00000000000046efb605fec3def0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675c28e0.050a0220.17d782.000d.GAE@google.com>
Subject: Re: [syzbot] [arm?] WARNING in delayed_work_timer_fn
From: syzbot <syzbot+e13e654d315d4da1277c@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2e7aff49b5da Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11ed5be8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=696fb014d05da3a3
dashboard link: https://syzkaller.appspot.com/bug?extid=e13e654d315d4da1277c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10192d44580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef408f67fde3/disk-2e7aff49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/414ac17a20dc/vmlinux-2e7aff49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a93415d2a7e7/Image-2e7aff49.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e13e654d315d4da1277c@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6023 at kernel/workqueue.c:2257 current_wq_worker kernel/workqueue_internal.h:69 [inline]
WARNING: CPU: 1 PID: 6023 at kernel/workqueue.c:2257 is_chained_work kernel/workqueue.c:2199 [inline]
WARNING: CPU: 1 PID: 6023 at kernel/workqueue.c:2257 __queue_work+0xe50/0x1308 kernel/workqueue.c:2256
Modules linked in:
CPU: 1 UID: 0 PID: 6023 Comm: klogd Not tainted 6.13.0-rc2-syzkaller-g2e7aff49b5da #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 404000c5 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __queue_work+0xe50/0x1308 kernel/workqueue_internal.h:69
lr : current_wq_worker kernel/workqueue_internal.h:69 [inline]
lr : is_chained_work kernel/workqueue.c:2199 [inline]
lr : __queue_work+0xe50/0x1308 kernel/workqueue.c:2256
sp : ffff800080017b40
x29: ffff800080017b90 x28: dfff800000000000 x27: ffff700010002f88
x26: dfff800000000000 x25: ffff0000d1c63800 x24: 0000000000000008
x23: 1fffe0001b14d791 x22: ffff0000d1c639c0 x21: 0000000000000100
x20: ffff0000d8a6bc80 x19: ffff0000da2f0930 x18: 1fffe000366c5e7e
x17: ffff800123d64000 x16: ffff80008326d65c x15: 0000000000000002
x14: 1ffff00011f300ca x13: dfff800000000000 x12: 00000000b1aebe1c
x11: 00000000beaa9035 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d8a6bc80 x7 : ffff8000805819c0 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008df6a320
x2 : ffff0000da2f0930 x1 : 0000000000000100 x0 : 0000000000000000
Call trace:
 current_wq_worker kernel/workqueue_internal.h:69 [inline] (P)
 is_chained_work kernel/workqueue.c:2199 [inline] (P)
 __queue_work+0xe50/0x1308 kernel/workqueue.c:2256 (P)
 current_wq_worker kernel/workqueue_internal.h:69 [inline] (L)
 is_chained_work kernel/workqueue.c:2199 [inline] (L)
 __queue_work+0xe50/0x1308 kernel/workqueue.c:2256 (L)
 delayed_work_timer_fn+0x74/0x90 kernel/workqueue.c:2485
 call_timer_fn+0x1b4/0x8b8 kernel/time/timer.c:1793
 expire_timers kernel/time/timer.c:1839 [inline]
 __run_timers kernel/time/timer.c:2418 [inline]
 __run_timer_base+0x59c/0x7b4 kernel/time/timer.c:2430
 run_timer_base kernel/time/timer.c:2439 [inline]
 run_timer_softirq+0xcc/0x194 kernel/time/timer.c:2449
 handle_softirqs+0x320/0xd34 kernel/softirq.c:554
 __do_softirq+0x14/0x20 kernel/softirq.c:588
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:891
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:86
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0x1d8/0x544 kernel/softirq.c:655
 irq_exit_rcu+0x14/0x84 kernel/softirq.c:671
 __el1_irq arch/arm64/kernel/entry-common.c:561 [inline]
 el1_interrupt+0x38/0x68 arch/arm64/kernel/entry-common.c:575
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:580
 el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:596
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P)
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline] (P)
 raw_spin_rq_unlock_irq kernel/sched/sched.h:1526 [inline] (P)
 finish_lock_switch+0xc0/0x1e4 kernel/sched/core.c:5123 (P)
 raw_spin_rq_unlock_irq kernel/sched/sched.h:1526 [inline] (L)
 finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5123 (L)
 finish_task_switch+0x120/0x608 kernel/sched/core.c:5241
 context_switch kernel/sched/core.c:5372 [inline]
 __schedule+0x1748/0x27f0 kernel/sched/core.c:6756
 preempt_schedule_irq+0x80/0x188 kernel/sched/core.c:7078
 arm64_preempt_schedule_irq arch/arm64/kernel/entry-common.c:301 [inline]
 __el1_irq arch/arm64/kernel/entry-common.c:563 [inline]
 el1_interrupt+0x4c/0x68 arch/arm64/kernel/entry-common.c:575
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:580
 el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:596
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P)
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline] (P)
 do_notify_resume+0x5c/0x1f4 arch/arm64/kernel/entry-common.c:133 (P)
 do_notify_resume+0x58/0x1f4 arch/arm64/kernel/entry-common.c:133 (L)
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_interrupt+0xc8/0x248 arch/arm64/kernel/entry-common.c:832
 __el0_irq_handler_common+0x18/0x24 arch/arm64/kernel/entry-common.c:837
 el0t_64_irq_handler+0x10/0x1c arch/arm64/kernel/entry-common.c:842
 el0t_64_irq+0x198/0x19c arch/arm64/kernel/entry.S:601
irq event stamp: 35689
hardirqs last  enabled at (35688): [<ffff80008b687f2c>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (35688): [<ffff80008b687f2c>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (35689): [<ffff80008b6a9b44>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (35689): [<ffff80008b6a9b44>] _raw_spin_lock_irq+0x28/0x70 kernel/locking/spinlock.c:170
softirqs last  enabled at (34558): [<ffff800080129934>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (35685): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

