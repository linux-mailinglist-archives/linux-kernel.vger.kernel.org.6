Return-Path: <linux-kernel+bounces-331850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8D297B1F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4530E1F22EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7E91BAEFB;
	Tue, 17 Sep 2024 15:14:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2F31B9847
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586065; cv=none; b=IxETTe8PTtvLmhIfzyPlag/isJEF/xWxjv2CwUebIAPLIc9ur3//L1uCgkvnhVYJ2Ua5EALw48kgF5MGmAms/usUZny8xGJQ2hy+frcQW+d1CksaQdCOSFClzCBJXgpMPB39nMS128cTfxCetcZ8tn1H7AeGn4PfFxgtrIdlKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586065; c=relaxed/simple;
	bh=Raa5QJe6wakS5nt5o0NGkr2UTI/U+vKnSbCFrTfAFQQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ss6eDhTcILtdU4CH71//9CnInsWDuHtBjKgMhMee+La3i0iEEgf5Pags49Fa5ZrExyK5xz1CGUBPJCq0sUMzUrO/a5XQL/77AsR0RR+lF5VOr0OhL2t2wpJ9hjFCPF2kNmVcTVL2aJ8O44cVF7D+glOw0MIIbSYfc1D7ifUzH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a045e7ed57so98978915ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726586062; x=1727190862;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtND32/SYm0OgRTQZPOmIj3ViiVDp+IloAgloyjqPZM=;
        b=dg3uV1UMuw5n0oaxxnRhCNaIxF0AzSA6d1/pRvUtmjSO1PmdMjA/+hxtgQ9MwTsSjM
         tlrSh6Y7a78LKX4Z4KBLLT1XFJ8picIfqTN5WxSodPgGIYkYun1OhUYG7XQWN87Fonwc
         p1zjpSnJuwKFVgtFgtZK6yEVMjuB/EqwKswauslFMpu1glTZqDWVb6+MVRidlj9FvYXQ
         1OPiPqhJOEagYggpd1Hn/mpmCIV0blJatyDMBDGSfQBa1DX57qzOtmuOUo8I0pvYDroh
         hIejKx345zZE2k5+NmZbOJb1Sl6L7hs92lomi7t2PoM+/DSulvmv/sEKDgcRfLilJOkU
         8+OA==
X-Forwarded-Encrypted: i=1; AJvYcCXaf+FCRvzeHdZEpu3IRX48ws8NBOlN9ia+k0qCGYS3ejghQA2+IkpjBE0+U1fzP/RMTin3PRsTI4/tniE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNUtTBHxTOCAB+uWcCjulA2xQW9sMap3DanpD1wWZT7k+14Uxd
	pQ7/x9kYeRSQTwx8C01R1k9oua7DDpGoTRyjlhcu3fgzPmkTWhANvE38YEq7HsUiKYDHsetupF9
	gfP0EqNlQ93yGkUu2cLA5K+797thDBSxU8U6Q+cyqo2A+hMbDmqkUFRE=
X-Google-Smtp-Source: AGHT+IETDPpkSfbGfGgnqnk4VyZm99w66bk6EGEmt45LYmvODtc5mgVFx7WeKNKGlGuH8JFsqbUqV00/AXGl10W5qD3jfroAa9ts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d85:b0:3a0:8dc8:4cd with SMTP id
 e9e14a558f8ab-3a08dc80569mr134333065ab.23.1726586062618; Tue, 17 Sep 2024
 08:14:22 -0700 (PDT)
Date: Tue, 17 Sep 2024 08:14:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000efd5da06225224a6@google.com>
Subject: [syzbot] [batman?] INFO: rcu detected stall in batadv_bla_periodic_work
 (2)
From: syzbot <syzbot+fc38cf2d6e727d8415c7@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com, 
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    196145c606d0 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13eb27c7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28869f34c32848cf
dashboard link: https://syzkaller.appspot.com/bug?extid=fc38cf2d6e727d8415c7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15be7807980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/94719b44a92c/disk-196145c6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc25f4396b64/vmlinux-196145c6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d587a9ecda3e/bzImage-196145c6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fc38cf2d6e727d8415c7@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-...D } 2684 jiffies s: 3397 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 29 Comm: kworker/u8:2 Not tainted 6.11.0-rc7-syzkaller-00097-g196145c606d0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bat_events batadv_bla_periodic_work
RIP: 0010:kasan_check_range+0x14f/0x1a0 mm/kasan/generic.c:190
Code: 83 c0 01 49 89 d3 48 39 d0 74 11 80 38 00 74 ef 4d 8d 1c 2c 48 85 c0 48 89 c2 75 93 48 89 da 4c 89 d8 4c 29 da e9 2c ff ff ff <5b> b8 01 00 00 00 5d 41 5c c3 cc cc cc cc b8 01 00 00 00 c3 cc cc
RSP: 0018:ffffc90000007a68 EFLAGS: 00000046
RAX: fffffbfff2d248e1 RBX: fffffbfff2d248e1 RCX: ffffffff8168d93e
RDX: fffffbfff2d248e1 RSI: 0000000000000008 RDI: ffffffff96924700
RBP: fffffbfff2d248e0 R08: 0000000000000000 R09: fffffbfff2d248e0
R10: ffffffff96924707 R11: 0000000000000000 R12: 0000000000000002
R13: ffff88801d698b58 R14: 0000000000000001 R15: ffff88801d698000
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557158cde858 CR3: 000000000db7c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hlock_class+0x4e/0x130 kernel/locking/lockdep.c:227
 check_wait_context kernel/locking/lockdep.c:4772 [inline]
 __lock_acquire+0x415/0x3cb0 kernel/locking/lockdep.c:5092
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 debug_object_activate+0x199/0x540 lib/debugobjects.c:709
 debug_hrtimer_activate kernel/time/hrtimer.c:423 [inline]
 debug_activate kernel/time/hrtimer.c:478 [inline]
 enqueue_hrtimer+0x25/0x3c0 kernel/time/hrtimer.c:1085
 __run_hrtimer kernel/time/hrtimer.c:1706 [inline]
 __hrtimer_run_queues+0xaac/0xcc0 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x111/0x1a0 mm/kasan/generic.c:189
Code: 44 89 c2 e8 a1 ea ff ff 83 f0 01 5b 5d 41 5c c3 cc cc cc cc 48 85 d2 74 4f 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 41 80 38 00 <74> f2 eb b2 41 bc 08 00 00 00 45 29 dc 49 8d 14 2c eb 0c 48 83 c0
RSP: 0018:ffffc90000a57a58 EFLAGS: 00000246
RAX: fffffbfff20289b3 RBX: fffffbfff20289b4 RCX: ffffffff8169d04b
RDX: fffffbfff20289b4 RSI: 0000000000000008 RDI: ffffffff90144d98
RBP: fffffbfff20289b3 R08: 0000000000000000 R09: fffffbfff20289b3
R10: ffffffff90144d9f R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8ddb9fe0 R15: 0000000000000000
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 cpumask_test_cpu include/linux/cpumask.h:562 [inline]
 cpu_online include/linux/cpumask.h:1105 [inline]
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0xbb/0x560 kernel/locking/lockdep.c:5730
 rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 rcu_read_lock include/linux/rcupdate.h:838 [inline]
 batadv_bla_purge_claims+0x160/0x780 net/batman-adv/bridge_loop_avoidance.c:1289
 batadv_bla_periodic_work+0x51/0x9e0 net/batman-adv/bridge_loop_avoidance.c:1444
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

