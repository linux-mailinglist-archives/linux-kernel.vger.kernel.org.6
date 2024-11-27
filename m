Return-Path: <linux-kernel+bounces-423970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 862699DAEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD81FB21ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2550F2036FE;
	Wed, 27 Nov 2024 21:22:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC33202F8A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742548; cv=none; b=REVUQ3hTP3OVlD479h+NCrb4zQ6rkCGdEkKiYrdbvWNHk7SjOzsxrm9oCXbghKiAXb8Ggis8yyBh/hZrTIcoYQnP46/AHMQgBgontcWmSctUgnJ1dM2uGb6b62xCTa8jGtQp0sJRhImle/58AIzK72HyWzL5SkIQMefHciu0Qgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742548; c=relaxed/simple;
	bh=OBY6QdrGgNdKd+xDpyFVhVv80DDuvfUoS9ABUoeWb7g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oNTftX38NBrQBu8UmK2DnL6us+ZexSZI95R0zp7MxE3fZAs1oqytKGgpT+YfVnUou+VgRWc21pndGZKSLdj4eA9hFpyz75U+OgyiLR23miDwyDg3jtiwQoKYdHMYFzx7DzmxpQJPvLzZmAp6olHa+Fk/8T6FS4nSYGbe6vFZSvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7a1e95f19so1489795ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732742546; x=1733347346;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RJgiKqNkLqMi9PSMV/v4UIBjSSz0oHYuOxtKnx3sB8=;
        b=TLjquyx7c2mP7QbcUFaYC4dy4I2PMRlqxTj98uoeRySYQG7uIsBdsuJvEaux77uK1i
         Oc++IAnpNFdLIvNRjZKa3V7e+PjFiuZMI3zU4Yb7+ZPWfKyYAl+uNDg6VTYFss8NqyTg
         6SWmnkJNo7282HH47J3ENGPE008qq8xmnEcayKY+pL5FeZcfy9UN1d/A6/50d8BPR4zx
         ZZ1/NfTFaL8sHV0SaUfUfjLa6SL8kTxKjX6Xigpv6+s/ezsMhlk3XuDHPZyOMySkdo1q
         MkZeXsWZWbaMjSM8CYhM3j0O5dPaOrnPUAm0kj0FOyZ4SgI2uluVAPfpNceAnrHEcYtN
         pRSw==
X-Gm-Message-State: AOJu0YxRbHOkdAbPOx/jXiIwOrQaBy8Dx3WBj76fdvCJsDsENGDUxcdN
	z5Q5aAaslIZZoQBG5urs0HnI6bVFHDki5abbQgCisQuhvAgBye2ZWoqmMeofB+dE2jVizuYMusq
	JTdZ5sikXnoUrssELLwmt/bUh5qLLtlF8J9Qf4yRheGssmngCaN1wQ0s=
X-Google-Smtp-Source: AGHT+IFRD6RuHZpTnNRBQCiEtPVohyHg59PIjgfyntPSIy/QYXfBb/yuIKSjZ9Y0PWwagn2/qcFshG7yOjg/FJSBqmzjFmbnVdK4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c547:0:b0:3a7:6c5c:9aa4 with SMTP id
 e9e14a558f8ab-3a7c5564e30mr54571355ab.12.1732742546041; Wed, 27 Nov 2024
 13:22:26 -0800 (PST)
Date: Wed, 27 Nov 2024 13:22:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67478d92.050a0220.253251.0062.GAE@google.com>
Subject: [syzbot] [kernel?] BUG: sleeping function called from invalid context
 in static_key_slow_dec
From: syzbot <syzbot+b26935466701e56cfdc2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5b366eae7193 stmmac: dwmac-intel-plat: fix call balance of..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14c0ab5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64aa0d9945bd5c1
dashboard link: https://syzkaller.appspot.com/bug?extid=b26935466701e56cfdc2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d36e3f2a031f/disk-5b366eae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/baad85a1bbb6/vmlinux-5b366eae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ac0e6e4acdf/bzImage-5b366eae.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b26935466701e56cfdc2@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 16, name: ksoftirqd/0
preempt_count: 100, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by ksoftirqd/0/16:
 #0: ffffffff8e937e60 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937e60 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2561 [inline]
 #0: ffffffff8e937e60 (rcu_callback){....}-{0:0}, at: rcu_core+0xa37/0x17a0 kernel/rcu/tree.c:2823
Preemption disabled at:
[<ffffffff81578192>] softirq_handle_begin kernel/softirq.c:395 [inline]
[<ffffffff81578192>] handle_softirqs+0x122/0x980 kernel/softirq.c:530
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc6-syzkaller-00203-g5b366eae7193 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8653
 percpu_down_read include/linux/percpu-rwsem.h:49 [inline]
 cpus_read_lock+0x1b/0x150 kernel/cpu.c:490
 __static_key_slow_dec kernel/jump_label.c:320 [inline]
 static_key_slow_dec+0x49/0xa0 kernel/jump_label.c:336
 nf_tables_chain_destroy+0x3c4/0x4f0 net/netfilter/nf_tables_api.c:2160
 __nft_release_basechain_now net/netfilter/nf_tables_api.c:11442 [inline]
 nft_release_basechain_rcu+0x3fc/0x550 net/netfilter/nf_tables_api.c:11454
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

================================
WARNING: inconsistent lock state
6.12.0-rc6-syzkaller-00203-g5b366eae7193 #0 Tainted: G        W         
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-R} usage.
ksoftirqd/0/16 [HC0[0]:SC1[1]:HE1:SE0] takes:
ffffffff8e7d1d90 (cpu_hotplug_lock){+++?}-{0:0}, at: __static_key_slow_dec kernel/jump_label.c:320 [inline]
ffffffff8e7d1d90 (cpu_hotplug_lock){+++?}-{0:0}, at: static_key_slow_dec+0x49/0xa0 kernel/jump_label.c:336
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
  percpu_down_write+0x54/0x310 kernel/locking/percpu-rwsem.c:229
  cpus_write_lock kernel/cpu.c:508 [inline]
  _cpu_up+0x76/0x580 kernel/cpu.c:1638
  cpu_up+0x184/0x230 kernel/cpu.c:1722
  cpuhp_bringup_mask+0xdf/0x260 kernel/cpu.c:1788
  cpuhp_bringup_cpus_parallel+0xaf/0x160 kernel/cpu.c:1866
  bringup_nonboot_cpus+0x2b/0x50 kernel/cpu.c:1892
  smp_init+0x34/0x150 kernel/smp.c:1009
  kernel_init_freeable+0x417/0x5d0 init/main.c:1572
  kernel_init+0x1d/0x2b0 init/main.c:1469
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
irq event stamp: 1161634
hardirqs last  enabled at (1161634): [<ffffffff8bc76793>] irqentry_exit+0x63/0x90 kernel/entry/common.c:357
hardirqs last disabled at (1161633): [<ffffffff8bc7433e>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1049
softirqs last  enabled at (1161438): [<ffffffff8157b03a>] run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
softirqs last disabled at (1161447): [<ffffffff8157b03a>] run_ksoftirqd+0xca/0x130 kernel/softirq.c:927

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(cpu_hotplug_lock);
  <Interrupt>
    lock(cpu_hotplug_lock);

 *** DEADLOCK ***

1 lock held by ksoftirqd/0/16:
 #0: ffffffff8e937e60 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937e60 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2561 [inline]
 #0: ffffffff8e937e60 (rcu_callback){....}-{0:0}, at: rcu_core+0xa37/0x17a0 kernel/rcu/tree.c:2823

stack backtrace:
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Tainted: G        W          6.12.0-rc6-syzkaller-00203-g5b366eae7193 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_usage_bug+0x62e/0x8b0 kernel/locking/lockdep.c:4038
 valid_state+0x13a/0x1c0 kernel/locking/lockdep.c:4052
 mark_lock_irq+0xbb/0xc20 kernel/locking/lockdep.c:4263
 mark_lock+0x223/0x360 kernel/locking/lockdep.c:4725
 __lock_acquire+0xbf9/0x2050 kernel/locking/lockdep.c:5156
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 cpus_read_lock+0x42/0x150 kernel/cpu.c:490
 __static_key_slow_dec kernel/jump_label.c:320 [inline]
 static_key_slow_dec+0x49/0xa0 kernel/jump_label.c:336
 nf_tables_chain_destroy+0x3c4/0x4f0 net/netfilter/nf_tables_api.c:2160
 __nft_release_basechain_now net/netfilter/nf_tables_api.c:11442 [inline]
 nft_release_basechain_rcu+0x3fc/0x550 net/netfilter/nf_tables_api.c:11454
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
BUG: scheduling while atomic: ksoftirqd/0/16/0x00000101
INFO: lockdep is turned off.
Modules linked in:
Preemption disabled at:
[<ffffffff81578192>] softirq_handle_begin kernel/softirq.c:395 [inline]
[<ffffffff81578192>] handle_softirqs+0x122/0x980 kernel/softirq.c:530


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

