Return-Path: <linux-kernel+bounces-277167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E34949D6A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1091C21FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78D15E5B5;
	Wed,  7 Aug 2024 01:39:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A215DBA5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722994744; cv=none; b=QOmZRo5EE4jGoBNJ6SBOi1rDG+/Xq0Oi1Od2YFzXPtegFkZVlIpjiKsx3he79aSHCODeJdDbe35TvqEYnv2LqDvHDCzK0PTZXjg8QaZ4ZJe/qflNzivWBkpUoT8TWh7BkaAoul8r4VvNTjW5LdcSMMTofkNaJOHFA3uaCIyP6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722994744; c=relaxed/simple;
	bh=vBorneo7NNjztSavhEh6/9iqIz87QxLbG4KQd3uvXgE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KvCGWA2vuKz1lfqq/GhSmZZZ3MIPioTCEHxre5D8o25KOAZqOujJmuXozkNCU3ZUBNaWU/L2RhlhoORvZYA7VvRhDrfCplQXv0py9YYsqL1rVivHTkdtbWdqpCPPT5mYArTOwrE9VPuhK2HUR6F4qYryfRLDJjuLx6RNl4h9h2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8223aed779aso152340139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 18:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722994742; x=1723599542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zpBYwB2iO0E5wdHoCC5ZBXqg6tZgbJBaFHzCxiDVXs=;
        b=hZqK3vUvUzD1T+c0s7sdE5+pbnHXYdIl9vWlVJnE6ft06sRyCfEAs/R5FbLVCzPuTz
         0ZrryCWWlpzHKXQYKCs76/c7JWRON4aXdMeputzyZY0vIwynweDxS7uSwv1i6Bu1zgcB
         OkMBzczW9+FVyJ3O9FtK+x/s4C/v/taXrHsDIpSoxqHEgd7yPSems7bIFQI7GMkTOP5z
         jnpurFsUdFkW/Qk2+0rSRBDQYkzE4J6lapFYOmJsgO2cmrjj0HwhT1L0RigVGQgHyUBV
         VDse6Ph33zS/yiFOnqTqA4FlZ/T7/E/hsLMuGsuMaWg6rAzH+FDwcZqK8xVFEVDqbOND
         HNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3NnQclfY4WbLPrzMBdU7YY3qKXHkqTsh5isUOqn/9WfTgWdOSCdFG7dSNrABXoXiw+kPd4xYnb0b65pGccZ/zGZXSxraLVnZ9IXOC
X-Gm-Message-State: AOJu0YyIPbRQ3tm87E8RcY04cC/qM3wks0uHWjjQUkBFNl9ZjD8UzSc2
	yGND3xjAgPSgjwE6Z/4IS+wsTvrK8p2mfUXCjtrCcyljjW71N40hW819dgWI8eum0ZjHfnYAKtA
	CeRiOvQlOap4DjxrbROHfy6q1axHBcGre20xkTKC6bojEmilOeYTibF4=
X-Google-Smtp-Source: AGHT+IEq2WkNpgIbzyf5/az3sUv6jIfJ6vd2RHnI31JDrOU2P5VlRLWToa+NxKSQWuzj45Fyw0adBzUkI9FcF7/TkxaA0zAR9Gla
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640c:b0:81f:c103:3e73 with SMTP id
 ca18e2360f4ac-81fd434b50emr36169739f.1.1722994741772; Tue, 06 Aug 2024
 18:39:01 -0700 (PDT)
Date: Tue, 06 Aug 2024 18:39:01 -0700
In-Reply-To: <tencent_AA68577B46C9D3704361497763B7E44E5705@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000889130061f0df9ea@google.com>
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
From: syzbot <syzbot+ad601904231505ad6617@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: refcount bug in j1939_session_put

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 6083 at lib/refcount.c:28 refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Modules linked in:
CPU: 0 UID: 0 PID: 6083 Comm: syz.0.15 Not tainted 6.10.0-syzkaller-12610-g743ff02152bc-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Code: 00 17 40 8c e8 67 97 a5 fc 90 0f 0b 90 90 eb 99 e8 1b 89 e3 fc c6 05 76 7d 31 0b 01 90 48 c7 c7 60 17 40 8c e8 47 97 a5 fc 90 <0f> 0b 90 90 e9 76 ff ff ff e8 f8 88 e3 fc c6 05 50 7d 31 0b 01 90
RSP: 0018:ffffc90000007698 EFLAGS: 00010246
RAX: 6323259a0841a200 RBX: ffff88802b9bdea4 RCX: ffff888022580000
RDX: 0000000080000101 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff81559432 R09: 1ffff1101724519a
R10: dffffc0000000000 R11: ffffed101724519b R12: ffff88801e999868
R13: ffff88802b9bdea4 R14: ffff8880251b4000 R15: ffff88801e999800
FS:  00007fec0e7436c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000007d7b2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 kfree_skb_reason include/linux/skbuff.h:1260 [inline]
 kfree_skb include/linux/skbuff.h:1269 [inline]
 j1939_session_destroy net/can/j1939/transport.c:283 [inline]
 __j1939_session_release net/can/j1939/transport.c:295 [inline]
 kref_put include/linux/kref.h:65 [inline]
 j1939_session_put+0x230/0x4b0 net/can/j1939/transport.c:300
 j1939_tp_cmd_recv net/can/j1939/transport.c:2114 [inline]
 j1939_tp_recv+0x7fe/0x1050 net/can/j1939/transport.c:2162
 j1939_can_recv+0x732/0xb20 net/can/j1939/main.c:108
 deliver net/can/af_can.c:572 [inline]
 can_rcv_filter+0x359/0x7f0 net/can/af_can.c:606
 can_receive+0x31c/0x470 net/can/af_can.c:663
 can_rcv+0x144/0x260 net/can/af_can.c:687
 __netif_receive_skb_one_core net/core/dev.c:5660 [inline]
 __netif_receive_skb+0x2e0/0x650 net/core/dev.c:5774
 process_backlog+0x662/0x15b0 net/core/dev.c:6107
 __napi_poll+0xcb/0x490 net/core/dev.c:6771
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
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 0e 9c 3b f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 63 c1 a3 f5 65 8b 05 64 b7 44 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc9000320f8c0 EFLAGS: 00000206
RAX: 6323259a0841a200 RBX: 1ffff92000641f1c RCX: ffffffff81701f3a
RDX: dffffc0000000000 RSI: ffffffff8bead5a0 RDI: 0000000000000001
RBP: ffffc9000320f950 R08: ffffffff9351e90f R09: 1ffffffff26a3d21
R10: dffffc0000000000 R11: fffffbfff26a3d22 R12: dffffc0000000000
R13: 1ffff92000641f18 R14: ffffc9000320f8e0 R15: 0000000000000246
 j1939_sk_send_loop net/can/j1939/socket.c:1164 [inline]
 j1939_sk_sendmsg+0xe01/0x14c0 net/can/j1939/socket.c:1277
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fec0d9773b9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fec0e743048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fec0db05f80 RCX: 00007fec0d9773b9
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007fec0d9e48e6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fec0db05f80 R15: 00007ffcb6839088
 </TASK>
----------------
Code disassembly (best guess):
   0:	9c                   	pushf
   1:	8f 44 24 20          	pop    0x20(%rsp)
   5:	42 80 3c 23 00       	cmpb   $0x0,(%rbx,%r12,1)
   a:	74 08                	je     0x14
   c:	4c 89 f7             	mov    %r14,%rdi
   f:	e8 0e 9c 3b f6       	call   0xf63b9c22
  14:	f6 44 24 21 02       	testb  $0x2,0x21(%rsp)
  19:	75 52                	jne    0x6d
  1b:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 63 c1 a3 f5       	call   0xf5a3c192 <-- trapping instruction
  2f:	65 8b 05 64 b7 44 74 	mov    %gs:0x7444b764(%rip),%eax        # 0x7444b79a
  36:	85 c0                	test   %eax,%eax
  38:	74 43                	je     0x7d
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	04 24                	add    $0x24,%al
  3e:	0e                   	(bad)
  3f:	36                   	ss


Tested on:

commit:         743ff021 ethtool: Don't check for NULL info in prepare..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=141bc85d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1221dff9980000


