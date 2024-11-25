Return-Path: <linux-kernel+bounces-421007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8174A9D858D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CDA168E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4471019F475;
	Mon, 25 Nov 2024 12:41:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0382F199EB7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732538485; cv=none; b=Q2dj5qSGf15mhcL6jSPEqPIx92JBySXeyaaR3HEKdagdvIeI/5os7ZaWX7VUpCpCViF5bP1dKleolY9lX7wVgutXpnz613Mndaoa9wTfGCZHbw2zI+/cNR/DO9ef/2qSdCO2FMXPCNHimmzUhtLmUeKwmyu8XHq4E8Z/0n66yEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732538485; c=relaxed/simple;
	bh=5Q9L81jn7hULPbu6trXuIMECP7YDHINg2ojX1G80uaI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D4QHa0GXqxFmztb6+GZlV0WImy9qSD7+sh0/jAodCxR+fe7uwLB1Fa3u3Yzs6jCsM4A3mLRN5zN4n7G6EhrrVrKABd5xT2jGkUBmpJSvh+LmP7ZEFhqn0qoJzTZI4J0tWFbGe/iVizZe0ytprKpF6jz7qUMbBghgsd5hry7ndA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a794990ef3so35185155ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732538483; x=1733143283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euSAAuk7huTYwElhTsQhtYtA71Wz6NJWASwxT/CmTsg=;
        b=VZL9Qw8V8jBWQ7pXVR1rdk5CEYSOnrrzJPcYJwBBvVewbYgTg/oKb8Q5OlAOjx/LE6
         T550h2dYSAJ66U74uKjowjYi4NZqhjOhuyJrBgGUGb+iY6JgkE0R5RPV8B6WZv32zIwS
         Xvr9ZtXof0yAyHVbEyYpm1GhpMJny7fsWPLwDJarcY+3JlkxcVxhOe3FHXIXhBSbo2a6
         wQWabsj4fcUoIUP02N1oT9yzYHHFb60gwW/7vQ10Wi/VmEKwi7DELX02u51cFJ39lWAm
         GHruo+qU2J0CctDrsZ1ddYpIz7/mQOmSnO7iehYjzFSsMsVxL8ER2pq96MNcvj/0ykjl
         o7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVrddv8HMqzs+q2blishcGg+9RWa8ODBWoVxwA/h4WoYkAHRjL3pSP5nZHXnYDtY8OPCWZGhAll/VFABiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaYXMESBezWrAlXla/yCRX0DH01pYWB4s/SluZHUc9N20Ncg4k
	TNcz7w2upCM9zmvvXK4W+8Uii8ZSehsh3KHwCi1/pvfi2Bg/ny75iy0v6q7hTWJBO40smLNJFi8
	PKrn0f3qzYnf+lyWt39nR1dUInGzqfNJUhShvDZpajaSFiYOH8ul5Kbs=
X-Google-Smtp-Source: AGHT+IGXDWlLYqxBQzFMAdM2WrAqBhDPBsQmuzARLj7h18kvLLNbtS8AqlU9eFnSHTwYG2MQ6XHrwujisIIwOzB8fXZE2A0nd0iJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1541:b0:3a7:a99f:eab8 with SMTP id
 e9e14a558f8ab-3a7a99fee5fmr50619985ab.2.1732538483145; Mon, 25 Nov 2024
 04:41:23 -0800 (PST)
Date: Mon, 25 Nov 2024 04:41:23 -0800
In-Reply-To: <6738c3ba.050a0220.bb738.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67447073.050a0220.1cc393.007b.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING: locking bug in get_random_u8
From: syzbot <syzbot+7f4f9a43a9c78eaee04f@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, bigeasy@linutronix.de, boqun.feng@gmail.com, 
	hdanton@sina.com, jason@zx2c4.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ee775f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bc8a5565eebec6
dashboard link: https://syzkaller.appspot.com/bug?extid=7f4f9a43a9c78eaee04f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1612dee8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbaabe559df8/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5fe0afceb260/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f4f9a43a9c78eaee04f@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
6.12.0-syzkaller-09073-g9f16d5e6f220 #0 Not tainted
-----------------------------
sshd/5973 is trying to lock:
ffff88806a63af60 (batched_entropy_u8.lock){..-.}-{3:3}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff88806a63af60 (batched_entropy_u8.lock){..-.}-{3:3}, at: get_random_u8+0xef/0x7f0 drivers/char/random.c:551
other info that might help us debug this:
context-{2:2}
2 locks held by sshd/5973:
 #0: ffffffff8e1bba80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1bba80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1bba80 (rcu_read_lock){....}-{1:3}, at: lock_vma_under_rcu+0xe4/0x980 mm/memory.c:6272
 #1: ffff88806a63ebd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:598
stack backtrace:
CPU: 0 UID: 0 PID: 5973 Comm: sshd Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x878/0x3c40 kernel/locking/lockdep.c:5176
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 get_random_u8+0x107/0x7f0 drivers/char/random.c:551
 get_random_u32_below include/linux/random.h:78 [inline]
 kfence_guarded_alloc mm/kfence/core.c:421 [inline]
 __kfence_alloc+0x4e8/0x15f0 mm/kfence/core.c:1136
 kfence_alloc include/linux/kfence.h:129 [inline]
 slab_alloc_node mm/slub.c:4118 [inline]
 __kmalloc_cache_noprof+0x1e4/0x300 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:879 [inline]
 add_stack_record_to_list mm/page_owner.c:172 [inline]
 inc_stack_record_count mm/page_owner.c:214 [inline]
 __set_page_owner+0x34d/0x560 mm/page_owner.c:329
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 stack_depot_save_flags+0x566/0x8f0 lib/stackdepot.c:627
 kasan_save_stack+0x42/0x60 mm/kasan/common.c:48
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 task_work_add+0xc0/0x3b0 kernel/task_work.c:77
 task_tick_numa kernel/sched/fair.c:3607 [inline]
 task_tick_fair+0x524/0x8e0 kernel/sched/fair.c:13054
 sched_tick+0x1dd/0x4f0 kernel/sched/core.c:5652
 update_process_times+0x19c/0x2d0 kernel/time/timer.c:2524
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x376/0x530 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 __hrtimer_run_queues+0x5fb/0xae0 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x392/0x8e0 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x400 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x9f/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_preemption_disabled+0x2/0xe0 lib/smp_processor_id.c:13
Code: 0f 65 8b 05 5c b2 d3 74 85 c0 74 04 90 0f 0b 90 e9 53 fc ff ff 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 54 <55> 53 48 83 ec 08 65 8b 1d ad 02 d5 74 65 8b 05 a2 02 d5 74 a9 ff
RSP: 0000:ffffc90003e1fc58 EFLAGS: 00000282
RAX: 0000000000000001 RBX: ffff88803221720c RCX: ffffffff8b1a7dad
RDX: 0000000000000001 RSI: ffffffff8bd1e0c0 RDI: ffffffff8bd1e100
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000006
R13: 0000000000000000 R14: 0000000000000300 R15: 00007f9bd4999fff
 rcu_lockdep_current_cpu_online+0x35/0x150 kernel/rcu/tree.c:4777
 rcu_read_lock_held_common kernel/rcu/update.c:113 [inline]
 rcu_read_lock_held+0x27/0x50 kernel/rcu/update.c:349
 mt_slot lib/maple_tree.c:803 [inline]
 mtree_range_walk+0x25b/0xbe0 lib/maple_tree.c:2802
 mas_state_walk lib/maple_tree.c:3620 [inline]
 mas_walk+0x4f9/0x910 lib/maple_tree.c:4946
 lock_vma_under_rcu+0x2b5/0x980 mm/memory.c:6274
 do_user_addr_fault+0x457/0x13f0 arch/x86/mm/fault.c:1329
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x55f75beb0823
Code: 4c 89 ed 4c 89 e7 f3 aa eb 48 4c 89 e7 e8 95 48 f7 ff 48 89 c5 48 85 c0 74 38 48 89 c7 4c 89 ee 4d 39 f4 76 11 4c 89 f1 31 c0 <f3> a4 4c 89 e1 4c 29 f1 f3 aa eb 05 4c 89 e1 f3 a4 4c 89 ef 48 83
RSP: 002b:00007ffed36adfb0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000360000 RCX: 0000000000228010
RDX: 0000000000000002 RSI: 00007f9bd3f8c000 RDI: 00007f9bd461e000
RBP: 00007f9bd44ee010 R08: 00007f9bd44ee010 R09: 0000000000000000
R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000360000
R13: 00007f9bd3e5c010 R14: 0000000000358000 R15: 00007ffed36ae168
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	65 8b 05 5c b2 d3 74 	mov    %gs:0x74d3b25c(%rip),%eax        # 0x74d3b263
   7:	85 c0                	test   %eax,%eax
   9:	74 04                	je     0xf
   b:	90                   	nop
   c:	0f 0b                	ud2
   e:	90                   	nop
   f:	e9 53 fc ff ff       	jmp    0xfffffc67
  14:	0f 1f 00             	nopl   (%rax)
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	90                   	nop
  26:	90                   	nop
  27:	41 54                	push   %r12
* 29:	55                   	push   %rbp <-- trapping instruction
  2a:	53                   	push   %rbx
  2b:	48 83 ec 08          	sub    $0x8,%rsp
  2f:	65 8b 1d ad 02 d5 74 	mov    %gs:0x74d502ad(%rip),%ebx        # 0x74d502e3
  36:	65 8b 05 a2 02 d5 74 	mov    %gs:0x74d502a2(%rip),%eax        # 0x74d502df
  3d:	a9                   	.byte 0xa9
  3e:	ff                   	.byte 0xff


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

