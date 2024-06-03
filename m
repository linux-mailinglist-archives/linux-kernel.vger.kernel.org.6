Return-Path: <linux-kernel+bounces-198971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5D78D7FDF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81EC1C22556
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E410282885;
	Mon,  3 Jun 2024 10:22:31 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0147A79
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410151; cv=none; b=hr24pV/nz3Ve3QSGt+k8ac0Xja+jZLW+H/EqUi8RS8K8F+QkK+vJ7J+4USRIntQ6pr4JNFmLRtrG46KGKWhEdSJTypl0++YlaVLZ3RNfMVXMXGsjy3dpDvCya5Tw2oaw/IyPxnuLEu9V0TCy2QyMd85z+YhfZpQ8S16cflckSMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410151; c=relaxed/simple;
	bh=P8O0mlEdcLRtewnkjdH+glduMEs3ZBjJKaoHzRAH49E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cX9wCKWluTNq6r+uV9RvxOUG+UFg5rox5QFl9K9di1ROsowYEox8E7xWgotNsDcvXBipN5pwUaIBoqJMzb8QRNuEMNofXPm+AL4aQIzkGhfL/pAOz1cu5QintKkEJQArIC74fyr8VNIaSOdqKRDvEDkr40Xtsl7WkndQDfPvWiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e212ee8008so534923339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 03:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717410149; x=1718014949;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvNfpemdYzl+i0laxJR0apdzWCZE3aC0ixGIpx9nH4E=;
        b=T0Q6tMftWrZscQeAVy9Qv/tnp0RMFxGT6ks5jOTObdThQEuUnzMJDME2TkSGXGcAMg
         jQ7yKxbpk7uEDp1WgF2fWNxfQFpSI0hfRQ27LyLkam47H9n9DennZg7TmOCpmGybKb+h
         oC/ww729nt8/a8PYT/Zmk7Mgt2/zePpIlGl0qfmxACe8tgbgM8gMDe1b0wcuny/77Kqn
         mmL53tttCzgmnC0wpkoyBMaNVklPP5ChadxuZowlKAH2/hTG43gITkX6grwg1f8zfGpc
         eFTNU16ZdiRsoXcKlX/095pfJAtAADKqqlZEFhkl8ZgODIwA3JSl20OF8WLe3nJz2Jsb
         Y9QA==
X-Forwarded-Encrypted: i=1; AJvYcCUyz8JGH78GeOmMdKBS8j5gbuqjbuzl6+oawIIqrr7pq4awXtolBgu5Sh1x6y2Iv02Znjb51Idl422dnZOKf0Jx826YM5iWW3Jt6JAQ
X-Gm-Message-State: AOJu0YyrtCX5OldcSH42XVounKz3oeCQV0WuD13Ox1Cex48V+vnhakr+
	STYKIBtsFHZazNGi5vFjVDKaOSiMjTvP2/sidd4OtHxP4cCks/rTtH/A3lSTGW3EwuUHdIpL/pF
	nK7gaf+noRZVf2hxt4tBwXN3Xz28icSUtA8vNn+9KtpIjf3EMFakP+Y8=
X-Google-Smtp-Source: AGHT+IFh/7YDO4XwMGySSmdXTLwsQD/mlucoDoK6OF+5pqL0fVsazj61fX/ZYSvuCfRli2f6r9XYEDrNUaGIHl2/0hQVLTx3kEV2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f95:b0:7da:19cb:1c7f with SMTP id
 ca18e2360f4ac-7eaffdd311cmr56119839f.0.1717410149080; Mon, 03 Jun 2024
 03:22:29 -0700 (PDT)
Date: Mon, 03 Jun 2024 03:22:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000deb5250619f9b5f4@google.com>
Subject: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in __hrtimer_run_queues
From: syzbot <syzbot+558f67d44ad7f098a3de@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1422a73c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
dashboard link: https://syzkaller.appspot.com/bug?extid=558f67d44ad7f098a3de
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15583162980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c1b514980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75957361122b/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c766b0ec377/Image-4a4be1ad.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+558f67d44ad7f098a3de@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000090
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 52-bit VAs, pgdp=000000004605bb80
[0000000000000090] pgd=08000000464ee003, p4d=08000000472aa003, pud=08000000471b8003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3192 Comm: syz-executor607 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
Hardware name: linux,dummy-virt (DT)
pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : rb_next+0x1c/0x54 lib/rbtree.c:505
lr : rb_erase_cached include/linux/rbtree.h:124 [inline]
lr : timerqueue_del+0x38/0x70 lib/timerqueue.c:57
sp : ffff800080003e70
x29: ffff800080003e70 x28: 0000000000000000 x27: fff000007f8cf780
x26: 0000000000000001 x25: 00000000000000c0 x24: 0000001f0198bc90
x23: fff000007f8cf780 x22: fff000007f8cf7e0 x21: fff000007f8cf780
x20: fff000007f8cf7e0 x19: ffff800088c3bd60 x18: 0000000000000000
x17: fff07ffffd319000 x16: ffff800080000000 x15: 0000ffffef309d38
x14: 00000000000003bb x13: 0000000000000000 x12: ffff8000825e0028
x11: 0000000000000001 x10: 0000000000000200 x9 : 0000000000200000
x8 : 0008000000000000 x7 : ff7ffffffffffbff x6 : 00000000019a23f5
x5 : fff07ffffd319000 x4 : 000000000a2dca90 x3 : ffff800088c3bd60
x2 : ff7000007f8cf8e8 x1 : 0000000000000080 x0 : 0000000000000080
Call trace:
 rb_next+0x1c/0x54 lib/rbtree.c:505
 __remove_hrtimer kernel/time/hrtimer.c:1118 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1667 [inline]
 __hrtimer_run_queues+0x104/0x1bc kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0xe8/0x244 kernel/time/hrtimer.c:1813
 timer_handler drivers/clocksource/arm_arch_timer.c:674 [inline]
 arch_timer_handler_phys+0x2c/0x44 drivers/clocksource/arm_arch_timer.c:692
 handle_percpu_devid_irq+0x84/0x130 kernel/irq/chip.c:942
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:691 [inline]
 generic_handle_domain_irq+0x2c/0x44 kernel/irq/irqdesc.c:747
 gic_handle_irq+0x40/0xc4 drivers/irqchip/irq-gic.c:370
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:889
 do_interrupt_handler+0x80/0x84 arch/arm64/kernel/entry-common.c:310
 __el1_irq arch/arm64/kernel/entry-common.c:536 [inline]
 el1_interrupt+0x34/0x64 arch/arm64/kernel/entry-common.c:551
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:556
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:594
 __clear_young_dirty_ptes arch/arm64/include/asm/pgtable.h:1311 [inline]
 contpte_clear_young_dirty_ptes+0x68/0x128 arch/arm64/mm/contpte.c:389
 walk_pmd_range mm/pagewalk.c:143 [inline]
 walk_pud_range mm/pagewalk.c:221 [inline]
 walk_p4d_range mm/pagewalk.c:256 [inline]
 walk_pgd_range+0x4b0/0x8a4 mm/pagewalk.c:293
 __walk_page_range+0x178/0x180 mm/pagewalk.c:395
 walk_page_range+0x144/0x224 mm/pagewalk.c:521
 madvise_free_single_vma+0x134/0x2bc mm/madvise.c:815
 madvise_dontneed_free mm/madvise.c:929 [inline]
 madvise_vma_behavior+0x1d0/0x790 mm/madvise.c:1046
 madvise_walk_vmas+0xbc/0x12c mm/madvise.c:1268
 do_madvise+0x160/0x418 mm/madvise.c:1464
 __do_sys_madvise mm/madvise.c:1481 [inline]
 __se_sys_madvise mm/madvise.c:1479 [inline]
 __arm64_sys_madvise+0x24/0x34 mm/madvise.c:1479
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:152
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: 54000200 f9400401 b4000141 aa0103e0 (f9400821) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	54000200 	b.eq	0x40  // b.none
   4:	f9400401 	ldr	x1, [x0, #8]
   8:	b4000141 	cbz	x1, 0x30
   c:	aa0103e0 	mov	x0, x1
* 10:	f9400821 	ldr	x1, [x1, #16] <-- trapping instruction


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

