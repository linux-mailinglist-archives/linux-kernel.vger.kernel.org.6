Return-Path: <linux-kernel+bounces-290871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A5B955A0E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 01:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DB71C20C06
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 23:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C206839F4;
	Sat, 17 Aug 2024 23:03:51 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435D8C1F
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723935830; cv=none; b=QZQl6M4OD3Q5l0CqcPxJ3Fq2F1MNT3vXfrfZWdbBTsxgMfRnKaL4eb/F7mAdha3ggwPSXI3/8bkCN2s8MdbvVKgOqt6KziJdOY/4uYYveTRhgw3o+ALRgwTkgUm+E4UxHnqeo7pWyHI8OjGLJsZfKJI/jovUvepxAg5e59wWQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723935830; c=relaxed/simple;
	bh=4zkjXeiTFnwoy6RRWJElHwmH1rdJCaRdOWRdvd/UpFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=upKnV32YDRib/3X0RIJe3KOI2f56KigLV0wLYIQFq8TBE+3zeM03AteiaBi2OXATkMoI/e/K94U5E5aynVqkEBBUbnTVlD3qofypQSnQz7KopO8U9OsmBbo7QwwvZ4JQT/nxSmH/A7OgMQSlvO8/8jpk49xqnuQI14D1UU6zHXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.92])
	by sina.com (10.185.250.22) with ESMTP
	id 66C12A0B00001450; Sat, 18 Aug 2024 06:54:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6576037602641
X-SMAIL-UIID: 67E56DD24A0A474985B5CABD51BC7930-20240818-065405-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ca14b36a46a8c541b509@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	vincent.guittot@linaro.org
Subject: Re: [syzbot] [cgroups?] possible deadlock in task_rq_lock
Date: Sun, 18 Aug 2024 06:53:56 +0800
Message-Id: <20240817225356.730-1-hdanton@sina.com>
In-Reply-To: <00000000000092ef86061fdb849b@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Aug 2024 23:52:22 -0700
>
>-> #0 ((console_sem).lock){-.-.}-{2:2}:
>       check_prev_add kernel/locking/lockdep.c:3136 [inline]
>       check_prevs_add kernel/locking/lockdep.c:3255 [inline]
>       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3871
>       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5145
>       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
>       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>       down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
>       __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:323
>       console_trylock kernel/printk/printk.c:2754 [inline]
>       console_trylock_spinning kernel/printk/printk.c:1958 [inline]
>       vprintk_emit+0x2aa/0x7c0 kernel/printk/printk.c:2347
>       _printk+0xd5/0x120 kernel/printk/printk.c:2373
>       __report_bug lib/bug.c:195 [inline]
>       report_bug+0x346/0x500 lib/bug.c:219
>       handle_bug+0x60/0x90 arch/x86/kernel/traps.c:285
>       exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:309
>       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
>       lockdep_assert_rq_held kernel/sched/sched.h:1476 [inline]

It looks no way to me to fix the lockdep assert without breaking the safe
locking order in double_rq_lock().

>       rq_clock kernel/sched/sched.h:1624 [inline]
>       replenish_dl_new_period kernel/sched/deadline.c:777 [inline]
>       update_curr_dl_se+0x66f/0x920 kernel/sched/deadline.c:1511
>       update_curr+0x575/0xb20 kernel/sched/fair.c:1176
>       put_prev_entity+0x3d/0x210 kernel/sched/fair.c:5505
>       put_prev_task_fair+0x4d/0x80 kernel/sched/fair.c:8686
>       put_prev_task kernel/sched/sched.h:2423 [inline]
>       put_prev_task_balance+0x11d/0x190 kernel/sched/core.c:5886
>       __pick_next_task+0xc6/0x2f0 kernel/sched/core.c:5946
>       pick_next_task kernel/sched/core.c:6012 [inline]
>       __schedule+0x725/0x4ad0 kernel/sched/core.c:6594
>       preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6961
>       irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
>       asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
>       lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5766
>       down_read_trylock+0x24f/0x3c0 kernel/locking/rwsem.c:1568
>       mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
>       get_mmap_lock_carefully mm/memory.c:6033 [inline]
>       lock_mm_and_find_vma+0x32/0x2f0 mm/memory.c:6093
>       do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
>       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
>       exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
>       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
>       __put_user_4+0x11/0x20 arch/x86/lib/putuser.S:86
>       schedule_tail+0x96/0xb0 kernel/sched/core.c:5205
>       ret_from_fork+0x24/0x80 arch/x86/kernel/process.c:143
>       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

