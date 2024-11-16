Return-Path: <linux-kernel+bounces-411930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C3C9D0171
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7F81F231FE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 23:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A605195F22;
	Sat, 16 Nov 2024 23:30:22 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31291621
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731799821; cv=none; b=Da4OZ8CGYapoviB67yw52CxijOcpWFQxDKGRh5WXtZDGHwf9z+YPzU08LdFNaKYR1senNV64bkT3SX23BNXMjm0NT+WIuvdyCSbNpSCcNnYVHOrAa8aXgQnNswAt76yOKU2sSS0PS/sReC8w8008uoNv3egxEtZeclZSI6lUKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731799821; c=relaxed/simple;
	bh=2+43jZtEdQsQkc/UHpXcF7Wa25sr0Iub5uiM4oMeO/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRZOC3KTO4B0pwja8PpR02nmFw53o9FKaiKP/u9tsyCsTBkP4L1nRW+7/xoBzW1RjOJbdD46PyvXLPr7i4MB0pX1vtGuU7xMAbj5Up2c5PoEfrZIvk70puUqnSEZwcXD+VO5yNIdqh9eSO03+c1rppChvjLnjAdiLo+IUXbZH8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.242])
	by sina.com (10.185.250.24) with ESMTP
	id 67392AFA0000290A; Sat, 17 Nov 2024 07:30:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 20108810748372
X-SMAIL-UIID: EFE1C8C429594DEE84BA08F0157769CD-20241117-073007-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: syzbot <syzbot+7f4f9a43a9c78eaee04f@syzkaller.appspotmail.com>,
	Jason@zx2c4.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [syzbot] [kernel?] WARNING: locking bug in get_random_u8
Date: Sun, 17 Nov 2024 07:29:57 +0800
Message-Id: <20241116232957.1223-1-hdanton@sina.com>
In-Reply-To: <6738c3ba.050a0220.bb738.000d.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Loop in lock people.

On Sat, 16 Nov 2024 08:09:30 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14cb0ce8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f4f9a43a9c78eaee04f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9705ecb6a595/disk-929beafb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dbdd1f64b9b8/vmlinux-929beafb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3f70d07a929b/bzImage-929beafb.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7f4f9a43a9c78eaee04f@syzkaller.appspotmail.com
> 
> =============================
> [ BUG: Invalid wait context ]
> 6.12.0-rc6-next-20241108-syzkaller #0 Not tainted
> -----------------------------
> syz.4.319/7686 is trying to lock:
> ffff8880b873a970 (batched_entropy_u8.lock){..-.}-{3:3}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
> ffff8880b873a970 (batched_entropy_u8.lock){..-.}-{3:3}, at: get_random_u8+0x1a0/0xaa0 drivers/char/random.c:551
> other info that might help us debug this:
> context-{2:2}
> no locks held by syz.4.319/7686.
> stack backtrace:
> CPU: 1 UID: 0 PID: 7686 Comm: syz.4.319 Not tainted 6.12.0-rc6-next-20241108-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
>  check_wait_context kernel/locking/lockdep.c:4898 [inline]
>  __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>  local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
>  get_random_u8+0x1bd/0xaa0 drivers/char/random.c:551
>  get_random_u32_below include/linux/random.h:78 [inline]
>  kfence_guarded_alloc+0x9c/0xcd0 mm/kfence/core.c:421
>  __kfence_alloc+0x344/0x370 mm/kfence/core.c:1136
>  kfence_alloc include/linux/kfence.h:129 [inline]
>  slab_alloc_node mm/slub.c:4137 [inline]
>  __kmalloc_cache_noprof+0x2dd/0x390 mm/slub.c:4309
>  kmalloc_noprof include/linux/slab.h:901 [inline]
>  add_stack_record_to_list mm/page_owner.c:172 [inline]
>  inc_stack_record_count mm/page_owner.c:214 [inline]
>  __set_page_owner+0x55f/0x800 mm/page_owner.c:329
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3725/0x3870 mm/page_alloc.c:3510
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4786
>  alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>  stack_depot_save_flags+0x666/0x830 lib/stackdepot.c:627
>  kasan_save_stack+0x4f/0x60 mm/kasan/common.c:48
>  __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
>  task_work_add+0xd9/0x490 kernel/task_work.c:77
>  __run_posix_cpu_timers kernel/time/posix-cpu-timers.c:1223 [inline]
>  run_posix_cpu_timers+0x6ac/0x810 kernel/time/posix-cpu-timers.c:1422
>  tick_sched_handle kernel/time/tick-sched.c:276 [inline]
>  tick_nohz_handler+0x37c/0x500 kernel/time/tick-sched.c:297
>  __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
>  __hrtimer_run_queues+0x551/0xd50 kernel/time/hrtimer.c:1803
>  hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1865
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
>  __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
>  sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
>  </IRQ>

Another locking issue in irq context [1].

[1] https://lore.kernel.org/all/20241102001224.2789-1-hdanton@sina.com/
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
> RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
> Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 ee 14 43 f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 43 99 a6 f5 65 8b 05 64 f3 3c 74 85 c0 74 43 48 c7 04 24 0e 36
> RSP: 0018:ffffc900032efc60 EFLAGS: 00000206
> RAX: 92c7e75658265800 RBX: 1ffff9200065df90 RCX: ffffffff9a3bf903
> RDX: dffffc0000000000 RSI: ffffffff8c0ad880 RDI: 0000000000000001
> RBP: ffffc900032efcf0 R08: ffffffff901c8877 R09: 1ffffffff203910e
> R10: dffffc0000000000 R11: fffffbfff203910f R12: dffffc0000000000
> R13: 1ffff9200065df8c R14: ffffc900032efc80 R15: 0000000000000246
>  spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>  unlock_timer kernel/time/posix-timers.c:128 [inline]
>  do_timer_settime+0x37f/0x3e0 kernel/time/posix-timers.c:908
>  __do_sys_timer_settime kernel/time/posix-timers.c:928 [inline]
>  __se_sys_timer_settime kernel/time/posix-timers.c:914 [inline]
>  __x64_sys_timer_settime+0x19e/0x240 kernel/time/posix-timers.c:914
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

