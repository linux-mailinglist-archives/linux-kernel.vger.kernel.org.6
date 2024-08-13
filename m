Return-Path: <linux-kernel+bounces-285482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF57950E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91866B22D60
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2318C1A7041;
	Tue, 13 Aug 2024 20:40:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE6438FB9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723581628; cv=none; b=UKTZUJ+juDapTbjaji+aBU53/1Sat8Jpte2yrP5hMIbZipVNJ9LRDZNRv66Ho6hK4IECr4yGsjGCMmfn9OkiHGfOGj5iZiBY2BEZk4wzUbBwdV2/a7dLi0SoxdgYzaCdjdWe8RigpLFpRCNKuH57ckrO9ypZC9aCmPDNZe8/A2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723581628; c=relaxed/simple;
	bh=JHHf1rDCcPvYXf15cBRI/AIGAEGS9yGyh8oEPQ2nIPw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ESeiHJ/SYjsjqx0u1i1gSF+sDOGgBdQrXY1YobbWF4UNpxz3zHkEc8uXHx/x1N1SUrN5O6dY32pryTd4dKZBCCmWkvBwo451tGmPhWat0e63IqbcwL7HjQ2UgowDwVIV3eCY7/iwdWsPDzS6HMZA9/wJQSSfVc8yWW6bYuODSUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39a1ba36524so76051865ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723581626; x=1724186426;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BU0KGrGX1sBcnEBop1HVArd3Vu2HF2iHjDN7iGbm58w=;
        b=CW6iTwSD5VBioEzfySDFxdAPzAehrNcxIn8hgkyn2IoKGcB+AujIsT/igjlL+oULS/
         nbXbJK0Xh9vccAJs+S239LD6VmdjE+WaV1kY8tcA9ND9SxE5P97hyxYACHgGQoEuLHr6
         uqrqamqZ9uQttHJTC7IPm50rhW5x+LG+annvezpMWCBcg9KvGsOdWeukbnRZNhCSRtQW
         qr+9N06suiAfTiBIkwy5xuSKzitfOEXR9MfCrWZqIVUuxi0nkflEkbZICawcdeb0pq5P
         4hng2RAchnrH/KmIrgfJZq/tMEIQoFcK7Rn4x3Js5UTy5xbxr1SCu+2ZBdfFHzNBu92q
         0RiA==
X-Forwarded-Encrypted: i=1; AJvYcCUe/O82SuPa1+xJ+W/YI3BIM488jX1+4Xd19RV1drwQfjBXb8Fbly65mlCtG1O/nEDAr6S00hjnZZ4Om61vYNUpTelntDPPwze2zNWI
X-Gm-Message-State: AOJu0YxXZD4O3tGtw5eiRZ32kYTCzWqqhwSJB//6E60qlOF40RUhatfn
	wK1u7nGNZGXAAHEScXLIg7YV99nVmsS7IbEKBRzaXNVtqYLnkzN7pK/dFoXGx6BGWXZBdX+jjez
	qI4dIlCnIgm7CjiJyBx/niVF3qhUzNRGDp+JMRNCwdfq73zY7J19eCys=
X-Google-Smtp-Source: AGHT+IF+aEOzXIBoMuDcx6ib+UuKZRchssyFKP+sWOFsd2Jv+FBMl7+5iolBMJgHykK9Xg8V+5eodt65KeAj8sT+VEjXbuZq1A8N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b23:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39d1244769amr774765ab.1.1723581626136; Tue, 13 Aug 2024
 13:40:26 -0700 (PDT)
Date: Tue, 13 Aug 2024 13:40:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000916e55061f969e14@google.com>
Subject: [syzbot] [kernel?] KCSAN: data-race in next_expiry_recalc /
 update_process_times (2)
From: syzbot <syzbot+bf285fcc0a048e028118@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6b4aa469f049 Merge tag '6.11-rc3-ksmbd-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157bd96b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31ece081c16313f0
dashboard link: https://syzkaller.appspot.com/bug?extid=bf285fcc0a048e028118
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf019ab0b1a3/disk-6b4aa469.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b052d8a52fbd/vmlinux-6b4aa469.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07bf313382f0/bzImage-6b4aa469.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf285fcc0a048e028118@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in next_expiry_recalc / update_process_times

write to 0xffff888237c1de58 of 8 bytes by interrupt on cpu 1:
 next_expiry_recalc+0x187/0x1e0 kernel/time/timer.c:1967
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x2ee/0x640 kernel/time/timer.c:2428
 timer_expire_remote+0x2f/0x40 kernel/time/timer.c:2180
 tmigr_handle_remote_cpu kernel/time/timer_migration.c:930 [inline]
 tmigr_handle_remote_up kernel/time/timer_migration.c:1021 [inline]
 __walk_groups kernel/time/timer_migration.c:533 [inline]
 tmigr_handle_remote+0x4f6/0x940 kernel/time/timer_migration.c:1080
 run_timer_softirq+0x5f/0x70 kernel/time/timer.c:2451
 handle_softirqs+0xc3/0x280 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0x3e/0x90 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x73/0x80 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
 syscall_enter_from_user_mode_work include/linux/entry-common.h:165 [inline]
 syscall_enter_from_user_mode include/linux/entry-common.h:198 [inline]
 do_syscall_64+0x9a/0x1c0 arch/x86/entry/common.c:79
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888237c1de58 of 8 bytes by interrupt on cpu 0:
 run_local_timers kernel/time/timer.c:2466 [inline]
 update_process_times+0x8a/0x180 kernel/time/timer.c:2484
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x250/0x2d0 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x20d/0x5e0 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x210/0x7b0 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x5c/0x1a0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x6e/0x80 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
 native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
 arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
 acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:111
 acpi_idle_do_entry+0x1d/0x30 drivers/acpi/processor_idle.c:568
 acpi_idle_enter+0x96/0xb0 drivers/acpi/processor_idle.c:702
 cpuidle_enter_state+0xcf/0x270 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x40/0x70 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:230 [inline]
 do_idle+0x195/0x230 kernel/sched/idle.c:326
 cpu_startup_entry+0x25/0x30 kernel/sched/idle.c:424
 rest_init+0xef/0xf0 init/main.c:747
 start_kernel+0x581/0x5e0 init/main.c:1103
 x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0x9a/0xa0 arch/x86/kernel/head64.c:488
 common_startup_64+0x12c/0x137

value changed: 0x00000000fffff045 -> 0x00000000fffff048

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc3-syzkaller-00010-g6b4aa469f049 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
==================================================================


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

