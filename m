Return-Path: <linux-kernel+bounces-294635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0082695908C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F1C1F23A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E61C7B88;
	Tue, 20 Aug 2024 22:36:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33115C13C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193386; cv=none; b=hgfbcCM2G0yRs3hb4m7yRN5japxRFHjoB0lRDBBwBo/04D2fxZFuR0Z2k/TqeJNBX8MTLWHntHEBKt1naNWdFQ9THmDMni5k4bfir+SVj2rE+h0oFCn5u+aqQ2U8xq8PU7OSwW+MIR9GEHysBqa8vCOwiIVwSjmgJtCoKhsBKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193386; c=relaxed/simple;
	bh=KOOOBjFdUcWZk4tiVZiSRFoUyiCL+Zl21fym9LPNtXk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CoYMWKt3Xb5AzBgzXs9l20IC5i6zGW14lVMXMkkX6PxdzSkN5tQIKkdEJJzXb7SQfXNv2iN/EjUX4MfRDSUNvHYSALKzaonGTE0LbqsrYilYF4n/ZdbD/4vnHs0xZDRkgoPx7MJzyF9l9dnuZqXywYrtGpFoJt5C82PYRSxRrAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d4b5b9fa0so32199185ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724193384; x=1724798184;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWosG0/LZOdl1yuhsDIel4x+Ju/tuW8xutAHutnr2Xs=;
        b=w03dYOPTSzkcK992BbyXBDJrnCX68Mn+SaUxeKysQcdeUIl5wLh/4dkHGpUk6Vqa+K
         FxXY5p9z7RNV0065dDEmQsODOwcKV3R5h+d8QZasTie9n/F+zg5wJUYw4eZd3UWryVRV
         2r5mDsFHmpgewH2Xa5HZv3APV1JqqmdwUNNvNqPUjmzkh2mV1Yg8K3KNydrTwShzwHK5
         GNVon8NYaKnXJmPr9cz8c3ulHJB1E/m1bYqwGPOFNroUkTh6xXN+Y9oMc+UNGfDimONB
         p8cqc6r+n9UKJ0/1CXjaEHOMfWBTGF37E5a/nxc7QDeOc5qpWkVyhoIW7+BOZ/jHB/IR
         9w9Q==
X-Gm-Message-State: AOJu0YxNO68kLHdVbVE5y4B2rmuhYy7TeT5mLvI5RjN3iXG64HtLNG07
	sLSFRszicMLtmFlaAYPkUmszXygT5KNcUBRo0Pflxvnk6lXycohTXCaXM8L6EwrZgOLmTqPqZbe
	memoBbGSr/jSpbK3BJHNdZecwDGQq/f1Zy3AbHp7Sg9zMdV15FTTTfsc=
X-Google-Smtp-Source: AGHT+IF4UH8TptqoVg+U5speKC8B93bzfTmw9ts19AuINqjMqqbdfaeEoDviBye4hV3E/VX3tXWlWWvmdh0rFeO0Fs/byyZ1reaX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c04:b0:39d:1a4c:b853 with SMTP id
 e9e14a558f8ab-39d6c5cbb95mr235535ab.6.1724193384416; Tue, 20 Aug 2024
 15:36:24 -0700 (PDT)
Date: Tue, 20 Aug 2024 15:36:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033d3ce0620250e5f@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in sched_ttwu_pending
From: syzbot <syzbot+d0b64fece0a7107b3761@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    670c12ce09a8 Merge tag 'for-6.11/dm-fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138e5bd3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=d0b64fece0a7107b3761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c3073329e9b/disk-670c12ce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d8cf388cb086/vmlinux-670c12ce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f8bfb3cf4d1a/bzImage-670c12ce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d0b64fece0a7107b3761@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 0 at kernel/locking/lockdep.c:231 hlock_class kernel/locking/lockdep.c:231 [inline]
WARNING: CPU: 1 PID: 0 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4772 [inline]
WARNING: CPU: 1 PID: 0 at kernel/locking/lockdep.c:231 __lock_acquire+0x58c/0x2040 kernel/locking/lockdep.c:5092
Modules linked in:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.0-rc3-syzkaller-00221-g670c12ce09a8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:231 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4772 [inline]
RIP: 0010:__lock_acquire+0x58c/0x2040 kernel/locking/lockdep.c:5092
Code: 00 00 83 3d 75 2d a8 0e 00 75 23 90 48 c7 c7 00 d4 0a 8c 48 c7 c6 a0 d6 0a 8c e8 4f d8 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc90000a18b90 EFLAGS: 00010046
RAX: 3292b9acfb26c100 RBX: 0000000000001cd8 RCX: ffff8880182f0000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8155b4d2 R09: 1ffff1101726519a
R10: dffffc0000000000 R11: ffffed101726519b R12: ffff8880182f0000
R13: 0000000000001cd8 R14: 1ffff1100305e160 R15: ffff8880182f0b00
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020028000 CR3: 000000005d072000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:568
 raw_spin_rq_lock kernel/sched/sched.h:1415 [inline]
 _raw_spin_rq_lock_irqsave kernel/sched/sched.h:1435 [inline]
 rq_lock_irqsave kernel/sched/sched.h:1700 [inline]
 sched_ttwu_pending+0x182/0x740 kernel/sched/core.c:3674
 csd_do_func kernel/smp.c:134 [inline]
 __flush_smp_call_function_queue+0x1146/0x1690 kernel/smp.c:559
 __sysvec_call_function_single+0xb8/0x430 arch/x86/kernel/smp.c:271
 instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
 sysvec_call_function_single+0x9e/0xc0 arch/x86/kernel/smp.c:266
 </IRQ>
 <TASK>
 asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:709
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
RIP: 0010:acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:112
Code: 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 40 d7 03 00 48 f7 00 08 00 00 00 75 10 eb 07 0f 00 2d 95 4b b3 00 f3 0f 1e fa fb f4 <fa> e9 d4 6f 39 00 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc900001a7d08 EFLAGS: 00000246
RAX: ffff8880182f0000 RBX: ffff88801daa8864 RCX: 0000000001aa1b61
RDX: 0000000000000001 RSI: ffff88801daa8800 RDI: ffff88801daa8864
RBP: 000000000003a6b8 R08: ffff8880b9337c7b R09: 1ffff11017266f8f
R10: dffffc0000000000 R11: ffffffff8bb6cce0 R12: ffff8880167e6800
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8f0dd380
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:702
 cpuidle_enter_state+0x114/0x480 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:230 [inline]
 do_idle+0x375/0x5d0 kernel/sched/idle.c:326
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:424
 start_secondary+0x100/0x100 arch/x86/kernel/smpboot.c:313
 common_startup_64+0x13e/0x147
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	65 48 8b 04 25 40 d7 	mov    %gs:0x3d740,%rax
  10:	03 00
  12:	48 f7 00 08 00 00 00 	testq  $0x8,(%rax)
  19:	75 10                	jne    0x2b
  1b:	eb 07                	jmp    0x24
  1d:	0f 00 2d 95 4b b3 00 	verw   0xb34b95(%rip)        # 0xb34bb9
  24:	f3 0f 1e fa          	endbr64
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	e9 d4 6f 39 00       	jmp    0x397004
  30:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  37:	00 00
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


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

