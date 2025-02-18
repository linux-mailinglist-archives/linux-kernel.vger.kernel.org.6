Return-Path: <linux-kernel+bounces-519992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4D9A3A473
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 160A77A138D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E979F26FD9A;
	Tue, 18 Feb 2025 17:38:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B64211499
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900285; cv=none; b=b0OavF7xJCTlpU7N34r9tsAc/OLrizPdonqBm9XvMf/JIhsQu8l9xPgn8nI/25MsLadFsKKQnN76iL8n0pGQuMElBiFBzWGrST8vqPjk9RtT3gtxQGHeS+NalJ3YuG4sn95GGsgd1FHZudg7slUGtwwriGrQDb5nP/qVLDZvZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900285; c=relaxed/simple;
	bh=brv5k9wqh0z9ruqPtExG1VpG0i06cRYDDw3D3oXEcxQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=URbc8LlYB+QrhnwKJsu1qt7klMm7PMO2PzqoMYQSwhTjQN6CH+hwkoNUqcaWNbRazCM2J4YNV4/0J4PtwFj96uAjicLipQayVsTY1K/ZArhnJj+ALxCPfReZYj3zq2PnyBQgyqvp/KRSkVDzbva5u3XuZSw1TeFGvake0OXlk90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d197cf2ec9so39326045ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739900283; x=1740505083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PtRNiZHbqqmIrhN/td9hLdsB8qso2d1u1U24dsYNOQ=;
        b=LbBaT9Si695USEmipcPio/YSich9nE0AT1Pqkongvlk0kGDvtfv7IEqKH3KkrjrxH/
         7IdIgbNz8RTbZQX50rXKbTmDkDjOD0RPngLaStLo6xHL27j1fdzffQD+uEmA8xPogoSL
         WOrcAS6NCo4o9bap+wdX0how+5CT8IO10pgPWJMs8D2Ry7ShQuRZtkjvfZMn5148oLOo
         McVshjKiyqMTVptUPWI22ijtlPF2XqDvfA/uxg4feAU9wgWP+0wdO6U51vOUncZZri3m
         OAZijMkeqabLFkuQTZnWE0wxurQ9jy6JTAtFsqIEYPQ41/pTlizT8tjsIN9ACde4hCSV
         eEGw==
X-Gm-Message-State: AOJu0YyJk4LBmIMwrnSDZnt4nTStWm2rwRRQ5djwoea7F7XOMAurNGRL
	4qtOdaeI3++dSm+/InBc7DnL7g1XRWKVekG7ovKsf0pwjUdiijG0+Vj38bGHqyOc1ctZ8f1Bp8p
	7emuiEOPpIP3uXx86e041DqPLDXIRaI9I/f9zeEzmqoZGMSXkrudrDZ8=
X-Google-Smtp-Source: AGHT+IF/EnaaC0DZxRrdp73/8FfsGpd3qRvO55EPDG9ir/0UweOfj1SYeeeqgC10s/o5f8mN4D9ZCCkKrqxnt6XH6mEqNdzT8LeX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4d:b0:3d0:27f5:1b6c with SMTP id
 e9e14a558f8ab-3d2808d6429mr101570115ab.14.1739900282161; Tue, 18 Feb 2025
 09:38:02 -0800 (PST)
Date: Tue, 18 Feb 2025 09:38:02 -0800
In-Reply-To: <B2F37A7F-BE18-495F-9350-6D7D47198FFD@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b4c57a.050a0220.14d86d.0009.GAE@google.com>
Subject: Re: [syzbot] [mm?] [bcachefs?] WARNING in lock_list_lru_of_memcg
From: syzbot <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel NULL pointer dereference in qlist_free_all

BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 3f9de067 P4D 3f9de067 PUD 40014067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5357 Comm: kworker/0:3 Not tainted 6.14.0-rc3-syzkaller-g2408a807bfc3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events nsim_fib_event_work
RIP: 0010:qlink_to_cache mm/kasan/quarantine.c:131 [inline]
RIP: 0010:qlist_free_all+0x69/0x140 mm/kasan/quarantine.c:176
Code: e8 06 48 83 e0 c0 49 8b 4c 05 08 f6 c1 01 0f 85 a8 00 00 00 4c 01 e8 66 90 0f b6 48 33 c1 e1 18 81 f9 00 00 00 f5 48 0f 45 c5 <48> 8b 58 08 4d 8b 34 24 48 63 83 c0 00 00 00 49 29 c4 48 89 df 4c
RSP: 0018:ffffc9000d477568 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000ff000000
RDX: 0000000000000000 RSI: 0000000013ec5780 RDI: 000000001fffffff
RBP: 0000000000000000 R08: ffffffff816eac95 R09: ffffffff82290c0f
R10: dffffc0000000000 R11: fffffbfff28a8d0f R12: ffffffff93ec5780
R13: ffffea0000000000 R14: ffffffff93ec5780 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 00000000365b0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 __kmalloc_cache_noprof+0x1d9/0x390 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 nsim_fib4_rt_create drivers/net/netdevsim/fib.c:280 [inline]
 nsim_fib4_rt_insert drivers/net/netdevsim/fib.c:426 [inline]
 nsim_fib4_event drivers/net/netdevsim/fib.c:464 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:884 [inline]
 nsim_fib_event_work+0xe02/0x3f00 drivers/net/netdevsim/fib.c:1493
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
CR2: 0000000000000008
---[ end trace 0000000000000000 ]---
RIP: 0010:qlink_to_cache mm/kasan/quarantine.c:131 [inline]
RIP: 0010:qlist_free_all+0x69/0x140 mm/kasan/quarantine.c:176
Code: e8 06 48 83 e0 c0 49 8b 4c 05 08 f6 c1 01 0f 85 a8 00 00 00 4c 01 e8 66 90 0f b6 48 33 c1 e1 18 81 f9 00 00 00 f5 48 0f 45 c5 <48> 8b 58 08 4d 8b 34 24 48 63 83 c0 00 00 00 49 29 c4 48 89 df 4c
RSP: 0018:ffffc9000d477568 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000ff000000
RDX: 0000000000000000 RSI: 0000000013ec5780 RDI: 000000001fffffff
RBP: 0000000000000000 R08: ffffffff816eac95 R09: ffffffff82290c0f
R10: dffffc0000000000 R11: fffffbfff28a8d0f R12: ffffffff93ec5780
R13: ffffea0000000000 R14: ffffffff93ec5780 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 00000000365b0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 06 48 83 e0       	call   0xe083480b
   5:	c0 49 8b 4c          	rorb   $0x4c,-0x75(%rcx)
   9:	05 08 f6 c1 01       	add    $0x1c1f608,%eax
   e:	0f 85 a8 00 00 00    	jne    0xbc
  14:	4c 01 e8             	add    %r13,%rax
  17:	66 90                	xchg   %ax,%ax
  19:	0f b6 48 33          	movzbl 0x33(%rax),%ecx
  1d:	c1 e1 18             	shl    $0x18,%ecx
  20:	81 f9 00 00 00 f5    	cmp    $0xf5000000,%ecx
  26:	48 0f 45 c5          	cmovne %rbp,%rax
* 2a:	48 8b 58 08          	mov    0x8(%rax),%rbx <-- trapping instruction
  2e:	4d 8b 34 24          	mov    (%r12),%r14
  32:	48 63 83 c0 00 00 00 	movslq 0xc0(%rbx),%rax
  39:	49 29 c4             	sub    %rax,%r12
  3c:	48 89 df             	mov    %rbx,%rdi
  3f:	4c                   	rex.WR


Tested on:

commit:         2408a807 Merge tag 'vfs-6.14-rc4.fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113477df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=38a0cbd267eff2d286ff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=114603a4580000


