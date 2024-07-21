Return-Path: <linux-kernel+bounces-258157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FF493848A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 14:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C555CB20C0C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C49160877;
	Sun, 21 Jul 2024 12:02:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6826AF7
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721563327; cv=none; b=nFiZE67SxfuIGbvk0uN5mYssXsw6foQZI29AuA6KTOEFs9VCGGK57SGRWOQX8FVe/sZpxuOBHm9alNZpyBIOKLq83RNKABj97VQ0jywnl1wvZ1Qj+GZgDDapIN8Mm3PJWtR2TiqiI4BlVYk6+4K5QZI1Rhy6NJ/sypxn9DkT7BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721563327; c=relaxed/simple;
	bh=ZsY2NKhSsXcJlYpLo8fzkXi+fWRpVMvtIN2BTSTFPpY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o92r2s25nkHLN46wkiUJxyYGq64fczuqSIFqyvDdEugiomutbJ93M/WR1Q31q+hTu3SBVgMOa6aAck7VMx4ksM2oIXcUbYNuf2Ej7WDsyqjLkbo7JZ+9U93JFwRIxhSNcqlAKuUMuJAoaJgrIdFQyPfug8fHLwpcX8/kOiEas14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81ad0e64ff4so272727039f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 05:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721563324; x=1722168124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNd/LWwDJMnSLS3WHwVrJzLxQNKX/XJiiup50VYnANU=;
        b=fknJ06hJZOXQ0CikX0SEMAq48KwpvDlUFgODrBymgT0alN4WVz3Ao7b3WtPvRw9pbL
         CGCIlobUJxMzbcngc7LXD8rmQscbmlgoz44kgXY7tg6B1gRF6CKWsZ3zhCEidDtM7m9e
         US3c0FddOkpx8yqhDmjU2niz3PBO88Bj6Nn/3OQClFFz1xnt8cAHVduScI/1nlQbPs6r
         7v+G84NN0LsZ2L8jIaZkufRQGv6dWXJImLko+PAbvfNBd5s9nmSCRqyEWKp8uGyyy3Dx
         nbaKw8HB8EpU0+/MSiucvQVGlK1XJpyA3D9opWGqF8Cv7WXxmR2j/IIZCogaKhPRAzA0
         HpwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3/s+FbOp4pbLpY1PlOiPs5CC4ddZsP7W+btA8TWpdyfC3d+ecUe+l5xX30tk/F4W5tzcFB1o9JOF/XptBkeX/aF2hajrzDcH9GtT4
X-Gm-Message-State: AOJu0YynJ7jh4keu0jnZ3GdUJyjf3GtMuVtFdrCA07VC1qa7RKHLv4PO
	2RNaYdsdpWM+hNPsbIGYKZj9EGdVnZBKCCVjFfHSjUUVBXoogN+9eDcc3MGuTVEpsHZMqjkyYWY
	T4ZwbK7iiWvC9zHQYhLIkzrOD3i/nh2IMGgCzImCaze9nUkp3PUDXhg0=
X-Google-Smtp-Source: AGHT+IHYH1jReRyGZS7C7pnlqp3Wz/f+kudgT0TiAunfixKb18YFNmzinU90kq8Sb42z36r91fSxLF6UOM5eBW1qJtrfxHG/lWmG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3793:b0:4c0:8165:c391 with SMTP id
 8926c6da1cb9f-4c23fe04b41mr356827173.4.1721563324565; Sun, 21 Jul 2024
 05:02:04 -0700 (PDT)
Date: Sun, 21 Jul 2024 05:02:04 -0700
In-Reply-To: <20240721113702.235104-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b5df5061dc0b280@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in __cpu_map_flush

Oops: general protection fault, probably for non-canonical address 0xdffffc00248b33c0: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000124599e00-0x0000000124599e07]
CPU: 0 PID: 8590 Comm: syz.0.1336 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__cpu_map_flush+0x42/0xd0
Code: e8 83 d9 d6 ff 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 bd ce 39 00 49 8b 1e 4c 39 f3 74 77 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 9f ce 39 00 4c 8b 23 48 8d 7b c0
RSP: 0018:ffffc90000007b10 EFLAGS: 00010206
RAX: 00000000248b33c0 RBX: 0000000124599e00 RCX: ffff888024599e00
RDX: 0000000080000101 RSI: 0000000000000010 RDI: ffffc900041d7800
RBP: dffffc0000000000 R08: ffffffff895fbdfa R09: 1ffffffff1f5d13d
R10: dffffc0000000000 R11: fffffbfff1f5d13e R12: ffffc900041d7800
R13: ffffc900041d7820 R14: ffffc900041d7800 R15: dffffc0000000000
FS:  00007feec5f366c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feec5306030 CR3: 0000000022d0e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 xdp_do_check_flushed+0x136/0x240 net/core/filter.c:4304
 __napi_poll+0xe4/0x490 net/core/dev.c:6774
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5062
Code: c9 50 e8 19 b6 0b 00 48 83 c4 08 4c 89 f7 e8 7d 38 00 00 0f 1f 44 00 00 4c 89 f7 e8 50 1b 2e 0a e8 8b f2 36 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffc900041d77a8 EFLAGS: 00000286
RAX: b5a136e6a96a7500 RBX: ffff888024599e00 RCX: ffffffff947c8703
RDX: dffffc0000000000 RSI: ffffffff8bcacd20 RDI: ffffffff8c1f9a40
RBP: ffffc900041d77f0 R08: ffffffff8fae89ef R09: 1ffffffff1f5d13d
R10: dffffc0000000000 R11: fffffbfff1f5d13e R12: 1ffff11017287eb3
R13: dffffc0000000000 R14: ffff8880b943e800 R15: ffff8880b943f598
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0x17b6/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 futex_wait_queue+0x14e/0x1d0 kernel/futex/waitwake.c:370
 __futex_wait+0x17f/0x320 kernel/futex/waitwake.c:669
 futex_wait+0x101/0x360 kernel/futex/waitwake.c:697
 do_futex+0x33b/0x560 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex+0x3f9/0x480 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feec5175b59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feec5f360f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007feec5305f68 RCX: 00007feec5175b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007feec5305f68
RBP: 00007feec5305f60 R08: 00007feec5f366c0 R09: 00007feec5f366c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007feec5305f6c
R13: 000000000000000b R14: 00007ffc29b39510 R15: 00007ffc29b395f8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__cpu_map_flush+0x42/0xd0
Code: e8 83 d9 d6 ff 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 bd ce 39 00 49 8b 1e 4c 39 f3 74 77 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 9f ce 39 00 4c 8b 23 48 8d 7b c0
RSP: 0018:ffffc90000007b10 EFLAGS: 00010206
RAX: 00000000248b33c0 RBX: 0000000124599e00 RCX: ffff888024599e00
RDX: 0000000080000101 RSI: 0000000000000010 RDI: ffffc900041d7800
RBP: dffffc0000000000 R08: ffffffff895fbdfa R09: 1ffffffff1f5d13d
R10: dffffc0000000000 R11: fffffbfff1f5d13e R12: ffffc900041d7800
R13: ffffc900041d7820 R14: ffffc900041d7800 R15: dffffc0000000000
FS:  00007feec5f366c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feec5306030 CR3: 0000000022d0e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 83 d9 d6 ff       	call   0xffd6d988
   5:	4c 89 f0             	mov    %r14,%rax
   8:	48 c1 e8 03          	shr    $0x3,%rax
   c:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  11:	74 08                	je     0x1b
  13:	4c 89 f7             	mov    %r14,%rdi
  16:	e8 bd ce 39 00       	call   0x39ced8
  1b:	49 8b 1e             	mov    (%r14),%rbx
  1e:	4c 39 f3             	cmp    %r14,%rbx
  21:	74 77                	je     0x9a
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 9f ce 39 00       	call   0x39ced8
  39:	4c 8b 23             	mov    (%rbx),%r12
  3c:	48 8d 7b c0          	lea    -0x40(%rbx),%rdi


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ac4595980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=154c8cad980000


