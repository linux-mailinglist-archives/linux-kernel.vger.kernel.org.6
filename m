Return-Path: <linux-kernel+bounces-543008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C64A4D076
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59319171EE2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB3742077;
	Tue,  4 Mar 2025 01:01:29 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13818D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050088; cv=none; b=fkD+eY7lF1txKl3E1nmbtRVjYb6zklvJ828MqJJYgvnJ47A2R65jqzsUt+heoFpX/pZlZbZShrWZ0Hh9DQ0vBxE5xC7CLqYIIEzcL4PxKZFLBTW2bge6sOqQN2p+TXzrQHpYx4QoV1NzT2ioDIHZ1XLcMHAO4eJ3bEjLCmwLV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050088; c=relaxed/simple;
	bh=n2+xaOlkLWs+xjeOgT2HGWy/plfykuL9kjEK0RuGT+o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j91MVEhFE6+DpXAFKqrUerF5b3Sn1C0wgcgNzrW7JG+EqAgo2T+lEGedJo4G7I8NcWR6Xy/O3Et9OzFdTQbuSEBnjGfAuer+QW1lq+F0YFXMnBJU1EkQ3p+9cHCiOBxfON0KV/sxN8ILp4aUIaPftoHHgogD7upgAuJJnszstLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d060cfe752so47783455ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 17:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741050086; x=1741654886;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ggAzNV9vb43xj1jb6gbzWNpLyhz275iEsN9bMiszOc=;
        b=tTOoiGKo65nscyi8/81CKM+RN21XxYicrWz5+ILHaOZ9oRahHaCp7s+KlVKEWTXw8Y
         uGDSp6GMutBMOaBFU99cNvaLdR91dv64fShyJzo0RUxhEjk/lEgcmXsarVCt+jn0M3H1
         aHDjklCIGsId2qjpgm9CftQGcTVXSCOY1PHspV8HfgJNxcwoGDfi8sh/eBwU+fFEs1WM
         0TOuxujK5uz9E34mX9D0hbKDHOhXLHzVhlWrhswuYduLHIRNajsJrExs0TjCK4CWcq9y
         r1CAqD+szED7YjNwoCnk5nMW/apx+MeulBSF/wiipQaeipRW+ymhATudBq8kcuSRImyA
         tRog==
X-Forwarded-Encrypted: i=1; AJvYcCXd1MJmbT1bX8tw9lAV9PCyGGHSqKCPsYz/cHokPwWd6hLXbHDrra920TZvio16pEOQE1wdmEhDFT5M5ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9uqCFwV4QS9fdCoAkAemM3CrJSq75eikS47605COTssT1QpbF
	uR23zHCZjCU6/O3pfOE7i5hsxY1fJrZtt7SvUrr0PK1icD4efGZdOQCHrtH5uaDDxPufMXxPcru
	Sj4WJ4ocdfOofMJuc+VE83M0ZjZo6KGVMvICx3uUyX0T8oWm/oOMrovo=
X-Google-Smtp-Source: AGHT+IGViILyhDJA2S+W/0tk1fQCkMWUZjAwwmF8S5FO/vtplrEE7hVUdDMC3iJxbzxs3cCwZLladWTqd1XAd/hyknEe0miyYxPK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1528:b0:3d1:4b97:4f2d with SMTP id
 e9e14a558f8ab-3d3e6e458bamr145679475ab.5.1741050086393; Mon, 03 Mar 2025
 17:01:26 -0800 (PST)
Date: Mon, 03 Mar 2025 17:01:26 -0800
In-Reply-To: <6742b399.050a0220.1cc393.0033.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c650e6.050a0220.1dee4d.01c8.GAE@google.com>
Subject: Re: [syzbot] [usb?] general protection fault in dummy_timer (2)
From: syzbot <syzbot+faf3a6cf579fc65591ca@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    811d22141369 usb: dwc3: exynos: add support for exynos7870
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1690e464580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f429368eda610a89
dashboard link: https://syzkaller.appspot.com/bug?extid=faf3a6cf579fc65591ca
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11500697980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c0764bd2a6ef/disk-811d2214.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8d014106735/vmlinux-811d2214.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80062d83482e/bzImage-811d2214.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+faf3a6cf579fc65591ca@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000060: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000300-0x0000000000000307]
CPU: 0 UID: 0 PID: 7918 Comm: syz-executor Not tainted 6.14.0-rc3-syzkaller-00056-g811d22141369 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:strcmp+0x5b/0xb0 lib/string.c:277
Code: fa 48 c1 e8 03 83 e2 07 42 0f b6 04 28 38 d0 7f 04 84 c0 75 58 0f b6 6b ff 4c 8d 66 01 48 89 f0 48 89 f2 48 c1 e8 03 83 e2 07 <42> 0f b6 04 28 38 d0 7f 04 84 c0 75 2c 41 3a 6c 24 ff 74 ae 19 c0
RSP: 0018:ffffc90000007848 EFLAGS: 00010046
RAX: 0000000000000060 RBX: ffffffff8747ce21 RCX: ffffffff8fb2a5e8
RDX: 0000000000000000 RSI: 0000000000000300 RDI: ffffffff8747ce20
RBP: 0000000000000026 R08: 0000000000000001 R09: dffffc0000000000
R10: ffffffff8fb2a5f8 R11: ffffffff8fb2a5e8 R12: 0000000000000301
R13: dffffc0000000000 R14: 00000000000003b1 R15: ffffffff934e19e0
FS:  000055558b609500(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f143e94aea2 CR3: 000000012b09c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 count_matching_names kernel/locking/lockdep.c:877 [inline]
 register_lock_class+0x63b/0x1240 kernel/locking/lockdep.c:1342
 __lock_acquire+0x135/0x3c40 kernel/locking/lockdep.c:5103
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 complete_with_flags kernel/sched/completion.c:20 [inline]
 complete+0x1d/0x200 kernel/sched/completion.c:47
 transfer drivers/usb/gadget/udc/dummy_hcd.c:1523 [inline]
 dummy_timer+0x1c37/0x3960 drivers/usb/gadget/udc/dummy_hcd.c:1978
 __run_hrtimer kernel/time/hrtimer.c:1801 [inline]
 __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1865
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1882
 handle_softirqs+0x206/0x8d0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xfa/0x160 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire.part.0+0x155/0x380 kernel/locking/lockdep.c:5816
Code: b8 ff ff ff ff 65 0f c1 05 90 2f aa 7e 83 f8 01 0f 85 d0 01 00 00 9c 58 f6 c4 02 0f 85 e5 01 00 00 48 85 ed 0f 85 b6 01 00 00 <48> b8 00 00 00 00 00 fc ff df 48 01 c3 48 c7 03 00 00 00 00 48 c7
RSP: 0018:ffffc9000446fc98 EFLAGS: 00000206
RAX: 0000000000000046 RBX: 1ffff9200088df94 RCX: 00000000521e9cf7
RDX: 0000000000000001 RSI: ffffffff87281ac0 RDI: ffffffff8747c1a0
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff1f5cdc0
R10: ffffffff8fae6e07 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff88ebe3c0 R14: 0000000000000000 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock_sched include/linux/rcupdate.h:941 [inline]
 fd_install+0xc0/0x750 fs/file.c:639
 do_sys_openat2+0x1a4/0x1e0 fs/open.c:1433
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f143e88ba51
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d fa 1a 1f 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007ffc6205c990 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000080001 RCX: 00007f143e88ba51
RDX: 0000000000080001 RSI: 00007f143e90fadc RDI: 00000000ffffff9c
RBP: 00007f143e90fadc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000004
R13: 00007ffc6205ca30 R14: 00000000000aeedc R15: 00007ffc6205cfa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strcmp+0x5b/0xb0 lib/string.c:277
Code: fa 48 c1 e8 03 83 e2 07 42 0f b6 04 28 38 d0 7f 04 84 c0 75 58 0f b6 6b ff 4c 8d 66 01 48 89 f0 48 89 f2 48 c1 e8 03 83 e2 07 <42> 0f b6 04 28 38 d0 7f 04 84 c0 75 2c 41 3a 6c 24 ff 74 ae 19 c0
RSP: 0018:ffffc90000007848 EFLAGS: 00010046
RAX: 0000000000000060 RBX: ffffffff8747ce21 RCX: ffffffff8fb2a5e8
RDX: 0000000000000000 RSI: 0000000000000300 RDI: ffffffff8747ce20
RBP: 0000000000000026 R08: 0000000000000001 R09: dffffc0000000000
R10: ffffffff8fb2a5f8 R11: ffffffff8fb2a5e8 R12: 0000000000000301
R13: dffffc0000000000 R14: 00000000000003b1 R15: ffffffff934e19e0
FS:  000055558b609500(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f143e94aea2 CR3: 000000012b09c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	fa                   	cli
   1:	48 c1 e8 03          	shr    $0x3,%rax
   5:	83 e2 07             	and    $0x7,%edx
   8:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax
   d:	38 d0                	cmp    %dl,%al
   f:	7f 04                	jg     0x15
  11:	84 c0                	test   %al,%al
  13:	75 58                	jne    0x6d
  15:	0f b6 6b ff          	movzbl -0x1(%rbx),%ebp
  19:	4c 8d 66 01          	lea    0x1(%rsi),%r12
  1d:	48 89 f0             	mov    %rsi,%rax
  20:	48 89 f2             	mov    %rsi,%rdx
  23:	48 c1 e8 03          	shr    $0x3,%rax
  27:	83 e2 07             	and    $0x7,%edx
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	38 d0                	cmp    %dl,%al
  31:	7f 04                	jg     0x37
  33:	84 c0                	test   %al,%al
  35:	75 2c                	jne    0x63
  37:	41 3a 6c 24 ff       	cmp    -0x1(%r12),%bpl
  3c:	74 ae                	je     0xffffffec
  3e:	19 c0                	sbb    %eax,%eax


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

