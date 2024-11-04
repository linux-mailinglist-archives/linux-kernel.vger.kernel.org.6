Return-Path: <linux-kernel+bounces-394702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D209BB303
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787F11C20DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2219B1D414B;
	Mon,  4 Nov 2024 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zX0lljsI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yIiOdmro";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zX0lljsI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yIiOdmro"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC811D3590
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718687; cv=none; b=k88LCCblfd8x2HM6HLuFP9Yt6qdnKV9ROR6FrQwVQy0uyQIyAMT+2FJUPNcatcRIJ+z5EdIhD3RXYa/bivTIiqf5AvDqx8PyN6Lwj5e24FEJQWrJlx1guyCXsSfv2ApQqOGTq58/U6QazdrKLaXe6Fyf2/tIvCk9ojZEKHIq44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718687; c=relaxed/simple;
	bh=C9ms3oZFJTgmdk/v5kDkO1/USJFb4WanG/Kk3iDrqpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u14USv7K36x6EfzXhFinolznistfh3QAj6sJfQw31/qlSGgv4ujYVVyNZ4FwY9yNDEcVi0y/IXZx72/yHe+aXsNzjelzC96NfYHoIcj+hyS4LpoMGfF+Inmf3oclAFd22RaUGNfnOdUd7Qt4N0KZZynaYj2UNlABr72vwOFe33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zX0lljsI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yIiOdmro; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zX0lljsI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yIiOdmro; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C202621B84;
	Mon,  4 Nov 2024 11:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730718682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+4yhzs5jViImr82BdwEGFsWSG/IPe6FPIrk4KX77kao=;
	b=zX0lljsIWleNTZEz1RZSuH21WUW9IZI01RY3Tthff7XJpF6UT4k1EO7G1MhJ+RrxgytOF+
	A8BXUlvT4HjZPVgPSfpqiBoeAROZhj/Ql/gIWurz2QTOE1izLHDB8RzAbX6a/oBPlfe9tb
	chB4SaA/bu8nrRUvg5kpne0DTroMbvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730718682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+4yhzs5jViImr82BdwEGFsWSG/IPe6FPIrk4KX77kao=;
	b=yIiOdmroRvwwpA5bJd3DrkM3gns/1S12Lsu+ZJChBgfex8Ar5bUAj19HTOg9Z435SEfjdP
	F0dJ7qzh8pXimtAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730718682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+4yhzs5jViImr82BdwEGFsWSG/IPe6FPIrk4KX77kao=;
	b=zX0lljsIWleNTZEz1RZSuH21WUW9IZI01RY3Tthff7XJpF6UT4k1EO7G1MhJ+RrxgytOF+
	A8BXUlvT4HjZPVgPSfpqiBoeAROZhj/Ql/gIWurz2QTOE1izLHDB8RzAbX6a/oBPlfe9tb
	chB4SaA/bu8nrRUvg5kpne0DTroMbvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730718682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+4yhzs5jViImr82BdwEGFsWSG/IPe6FPIrk4KX77kao=;
	b=yIiOdmroRvwwpA5bJd3DrkM3gns/1S12Lsu+ZJChBgfex8Ar5bUAj19HTOg9Z435SEfjdP
	F0dJ7qzh8pXimtAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D9E11373E;
	Mon,  4 Nov 2024 11:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fNMNJtqrKGfIPgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 04 Nov 2024 11:11:22 +0000
Message-ID: <ee48b6e9-3f7a-49aa-ae5b-058b5ada2172@suse.cz>
Date: Mon, 4 Nov 2024 12:11:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING: locking bug in __rmqueue_pcplist
Content-Language: en-US
To: syzbot <syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com>,
 Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 kasan-dev <kasan-dev@googlegroups.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>
References: <67275485.050a0220.3c8d68.0a37.GAE@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <67275485.050a0220.3c8d68.0a37.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	REDIRECTOR_URL(0.00)[goo.gl];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[39f85d612b7c20d8db48];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[syzkaller.appspotmail.com,oracle.com,linux-foundation.org,google.com,vger.kernel.org,kvack.org,googlegroups.com,linutronix.de,gmail.com,infradead.org,redhat.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On 11/3/24 11:46, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1648155f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
> dashboard link: https://syzkaller.appspot.com/bug?extid=39f85d612b7c20d8db48
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16806e87980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com
> 
> =============================
> [ BUG: Invalid wait context ]
> 6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
> -----------------------------
> syz.0.49/6178 is trying to lock:
> ffff88813fffc298 (&zone->lock){-.-.}-{3:3}, at: rmqueue_bulk mm/page_alloc.c:2328 [inline]
> ffff88813fffc298 (&zone->lock){-.-.}-{3:3}, at: __rmqueue_pcplist+0x4c6/0x2b70 mm/page_alloc.c:3022
> other info that might help us debug this:
> context-{2:2}

Seems like another fallout of
560af5dc839e ("lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING")

> 4 locks held by syz.0.49/6178:
>  #0: ffff888031745be0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:189 [inline]
>  #0: ffff888031745be0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x165/0xcb0 mm/mmap.c:1677
>  #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x82/0x380 mm/pgtable-generic.c:287
>  #2: ffff88803007c978 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #2: ffff88803007c978 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: __pte_offset_map_lock+0x1ba/0x300 mm/pgtable-generic.c:402
>  #3: ffff8880b8744618 (&pcp->lock){+.+.}-{3:3}, at: spin_trylock include/linux/spinlock.h:361 [inline]
>  #3: ffff8880b8744618 (&pcp->lock){+.+.}-{3:3}, at: rmqueue_pcplist mm/page_alloc.c:3051 [inline]
>  #3: ffff8880b8744618 (&pcp->lock){+.+.}-{3:3}, at: rmqueue mm/page_alloc.c:3095 [inline]
>  #3: ffff8880b8744618 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x7e2/0x3870 mm/page_alloc.c:3492
> stack backtrace:
> CPU: 1 UID: 0 PID: 6178 Comm: syz.0.49 Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
>  check_wait_context kernel/locking/lockdep.c:4898 [inline]
>  __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>  rmqueue_bulk mm/page_alloc.c:2328 [inline]
>  __rmqueue_pcplist+0x4c6/0x2b70 mm/page_alloc.c:3022
>  rmqueue_pcplist mm/page_alloc.c:3064 [inline]
>  rmqueue mm/page_alloc.c:3095 [inline]
>  get_page_from_freelist+0x895/0x3870 mm/page_alloc.c:3492
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4771
>  alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>  stack_depot_save_flags+0x666/0x830 lib/stackdepot.c:627
>  save_stack+0x109/0x1f0 mm/page_owner.c:157
>  __set_page_owner+0x92/0x800 mm/page_owner.c:320
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1541
>  prep_new_page mm/page_alloc.c:1549 [inline]
>  get_page_from_freelist+0x3725/0x3870 mm/page_alloc.c:3495
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4771
>  alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>  stack_depot_save_flags+0x666/0x830 lib/stackdepot.c:627
>  kasan_save_stack+0x4f/0x60 mm/kasan/common.c:48
>  __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
>  task_work_add+0xd9/0x490 kernel/task_work.c:77

It seems the decision if stack depot is allowed to allocate here depends on
TWAF_NO_ALLOC added only recently. So does it mean it doesn't work as intended?

>  __run_posix_cpu_timers kernel/time/posix-cpu-timers.c:1219 [inline]
>  run_posix_cpu_timers+0x6ac/0x810 kernel/time/posix-cpu-timers.c:1418
>  tick_sched_handle kernel/time/tick-sched.c:276 [inline]
>  tick_nohz_handler+0x37c/0x500 kernel/time/tick-sched.c:297
>  __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
>  __hrtimer_run_queues+0x551/0xd50 kernel/time/hrtimer.c:1755
>  hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1817
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
>  __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
>  sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1049
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:variable_ffs arch/x86/include/asm/bitops.h:321 [inline]
> RIP: 0010:handle_softirqs+0x1e3/0x980 kernel/softirq.c:542
> Code: 7c 24 70 45 0f b7 e4 48 c7 c7 20 c5 09 8c e8 c4 6c 6c 0a 65 66 c7 05 32 53 ac 7e 00 00 e8 05 67 45 00 fb 49 c7 c6 c0 a0 60 8e <b8> ff ff ff ff 41 0f bc c4 41 89 c7 41 ff c7 0f 84 eb 03 00 00 44
> RSP: 0018:ffffc90000a18e40 EFLAGS: 00000286
> RAX: 959a1636e72c7c00 RBX: ffffc90000a18ee0 RCX: ffffffff8170c69a
> RDX: dffffc0000000000 RSI: ffffffff8c0ad3a0 RDI: ffffffff8c604dc0
> RBP: ffffc90000a18f50 R08: ffffffff942cd847 R09: 1ffffffff2859b08
> R10: dffffc0000000000 R11: fffffbfff2859b09 R12: 0000000000000010
> R13: 0000000000000000 R14: ffffffff8e60a0c0 R15: 1ffff11003cec000
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
>  common_interrupt+0xb9/0xd0 arch/x86/kernel/irq.c:278
>  </IRQ>
>  <TASK>
>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
> RIP: 0010:zap_pmd_range mm/memory.c:1753 [inline]
> RIP: 0010:zap_pud_range mm/memory.c:1782 [inline]
> RIP: 0010:zap_p4d_range mm/memory.c:1803 [inline]
> RIP: 0010:unmap_page_range+0x1ffd/0x4230 mm/memory.c:1824
> Code: 02 00 00 4c 8d bc 24 c0 02 00 00 48 8b 44 24 48 48 98 48 89 c1 48 c1 e1 0c 49 01 cd 4c 3b ac 24 98 00 00 00 0f 84 44 14 00 00 <4c> 89 6c 24 28 48 8b 5c 24 38 48 8d 1c c3 e8 50 01 b2 ff e9 ec e9
> RSP: 0018:ffffc9000303f560 EFLAGS: 00000287
> RAX: 0000000000000001 RBX: ffff88803023b5c8 RCX: 0000000000001000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000303f890 R08: ffffffff81e30b9c R09: 1ffffd4000333df6
> R10: dffffc0000000000 R11: fffff94000333df7 R12: dffffc0000000000
> R13: 00000000200ba000 R14: ffffc9000303f7e0 R15: ffffc9000303f820
>  unmap_vmas+0x3cc/0x5f0 mm/memory.c:1914
>  exit_mmap+0x292/0xcb0 mm/mmap.c:1693
>  __mmput+0x115/0x390 kernel/fork.c:1344
>  exit_mm+0x220/0x310 kernel/exit.c:570
>  do_exit+0x9b2/0x28e0 kernel/exit.c:925
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1087
>  __do_sys_exit_group kernel/exit.c:1098 [inline]
>  __se_sys_exit_group kernel/exit.c:1096 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1096
>  x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7faae5f7e719
> Code: Unable to access opcode bytes at 0x7faae5f7e6ef.
> RSP: 002b:00007ffc97dbc998 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007faae5f7e719
> RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00007ffc97dbc9ec R08: 00007ffc97dbca7f R09: 0000000000013547
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000032
> R13: 0000000000013547 R14: 0000000000013547 R15: 00007ffc97dbca40
>  </TASK>
> ----------------
> Code disassembly (best guess):
>    0:	7c 24                	jl     0x26
>    2:	70 45                	jo     0x49
>    4:	0f b7 e4             	movzwl %sp,%esp
>    7:	48 c7 c7 20 c5 09 8c 	mov    $0xffffffff8c09c520,%rdi
>    e:	e8 c4 6c 6c 0a       	call   0xa6c6cd7
>   13:	65 66 c7 05 32 53 ac 	movw   $0x0,%gs:0x7eac5332(%rip)        # 0x7eac534f
>   1a:	7e 00 00
>   1d:	e8 05 67 45 00       	call   0x456727
>   22:	fb                   	sti
>   23:	49 c7 c6 c0 a0 60 8e 	mov    $0xffffffff8e60a0c0,%r14
> * 2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax <-- trapping instruction
>   2f:	41 0f bc c4          	bsf    %r12d,%eax
>   33:	41 89 c7             	mov    %eax,%r15d
>   36:	41 ff c7             	inc    %r15d
>   39:	0f 84 eb 03 00 00    	je     0x42a
>   3f:	44                   	rex.R
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


