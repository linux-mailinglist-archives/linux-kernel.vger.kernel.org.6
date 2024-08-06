Return-Path: <linux-kernel+bounces-276279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E0B949197
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840EE1C20967
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6171D1F52;
	Tue,  6 Aug 2024 13:32:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B371C579E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951125; cv=none; b=QCEm/AFL5BSbvCJDo0R+0CWBIo+w0ukfkuwALVMxcCCwxWnfSX9XfZn0soTLwPjOjkq1YIL0OsVYMdipi8i0MvT/pbwEgtAL6jszVFnbyJriHGcmwOKLQ/X8NUcBb+CZKeUeJgyInSqWvrDUIkPmAnmjHSuux7+Ey3ZzClcHzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951125; c=relaxed/simple;
	bh=ZK8Ub15m/k4zKfWfKaE9zoMAGaqhrIjn1f0vhnTkhQg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LQn0H51x2x3yr2qTkePWZG5OVfYHrgTjBcXrvZ3peGRQahzgM9TW4SKblDiYHlORmmKtS7Saw8PI7gGDO5sonXF2aSkFPgLMy0XPQSFTmSF99p7RS4YN+7Tqv4VD1ujzDf82qsHoC0Dam0KWid5LCr612ltvQ8g+b0U11aN/G/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f99189f5fso95236339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722951123; x=1723555923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ud5owjxCCY9V1D3LFJJBZv3XvT8pdONCyFfG/rdXgv0=;
        b=nlnL8ASX5Ykc3SiRLi9CMT3LmfHtFSuL/EycDFnW8JNygtlCKkjqqHUJBLYFVDfA6a
         NWr2Pg+OIsrAQ0ieJNUlxnsl8PdQ9SQ0ytYDu7r7EwpsjdFrXO5wY9IVUN5lP96iEFPn
         cgfu1ymloTlFzJYuab8JcL5a+xJkgl343s3DUDuQ683QYiFTw/7oajiICHJE0w+PrWYl
         Ie00CRq4QNAK9Lw3tsmXBkReAjJzk/JLqBc3eESl+3Wl9UUXnqnFiem6TcUYi4KoHnK3
         SpfGZvsWGaTv0vDbbHZrl2HJ0EDQjDgE+7J9NxUg4BdgfRajUoOA67hZv5SN7bUVZW0P
         jPlA==
X-Forwarded-Encrypted: i=1; AJvYcCX3T9h8tZB7AHqJm6R0pE4RHXyEsZNm0ovrMZcBJN9hKAIrTf4kKrFR8BpJhfUPht8gtKGG0j3PypmEIW8RJykSOsdbqLHBVb04Te1W
X-Gm-Message-State: AOJu0Yz3rALly+VBaLesgB1d9CSc+r9keq+gCemfaTunmANRlTfxZu+c
	dGpwNgFWkRICHdjUky6+yMfs5/o4R2IhQm9YeN0ByI5bd2lb7m+Cho4gGQyKik1/+tBeCZPBLD8
	9ty7UwPb7z/gfuqE3wWcBXIiIwXpEo3+f7WtumOUyEuMSabW7K4U1m2Q=
X-Google-Smtp-Source: AGHT+IHtg6A8rdnpNV235JeviuRqCrg9HXorqJiOlrK+osSepWr6FptwkrBmv14/13UAPmGJo5SXwaWvr48sQsC2sE32v+61t9BK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8527:b0:4b9:26f5:3632 with SMTP id
 8926c6da1cb9f-4c8d5740ff1mr392316173.6.1722951123161; Tue, 06 Aug 2024
 06:32:03 -0700 (PDT)
Date: Tue, 06 Aug 2024 06:32:03 -0700
In-Reply-To: <tencent_D1FC92D5864A49986EC02EE50C8967EF4606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a96937061f03d135@google.com>
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
WARNING: CPU: 1 PID: 6087 at lib/refcount.c:28 refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Modules linked in:
CPU: 1 UID: 0 PID: 6087 Comm: syz.0.15 Not tainted 6.10.0-syzkaller-12610-g743ff02152bc-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Code: 00 17 40 8c e8 67 97 a5 fc 90 0f 0b 90 90 eb 99 e8 1b 89 e3 fc c6 05 76 7d 31 0b 01 90 48 c7 c7 60 17 40 8c e8 47 97 a5 fc 90 <0f> 0b 90 90 e9 76 ff ff ff e8 f8 88 e3 fc c6 05 50 7d 31 0b 01 90
RSP: 0018:ffffc90000a186a0 EFLAGS: 00010246
RAX: 20b8440b9615ae00 RBX: ffff8880223e2d64 RCX: ffff88802aba9e00
RDX: 0000000080000101 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff81559432 R09: 1ffff1101726519a
R10: dffffc0000000000 R11: ffffed101726519b R12: ffff88801e5ed868
R13: ffff8880223e2d64 R14: 1ffff11003cbdb18 R15: ffff88801e5ed800
FS:  00007faec5b416c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faec5b40fa8 CR3: 000000007d6f6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 kfree_skb_reason include/linux/skbuff.h:1260 [inline]
 kfree_skb include/linux/skbuff.h:1269 [inline]
 j1939_session_destroy net/can/j1939/transport.c:282 [inline]
 __j1939_session_release net/can/j1939/transport.c:294 [inline]
 kref_put include/linux/kref.h:65 [inline]
 j1939_session_put+0x1e7/0x440 net/can/j1939/transport.c:299
 j1939_tp_cmd_recv net/can/j1939/transport.c:2113 [inline]
 j1939_tp_recv+0x7fe/0x1050 net/can/j1939/transport.c:2161
 j1939_can_recv+0x798/0xbb0 net/can/j1939/main.c:109
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
RSP: 0018:ffffc900035978c0 EFLAGS: 00000206
RAX: 20b8440b9615ae00 RBX: 1ffff920006b2f1c RCX: ffffffff81701f3a
RDX: dffffc0000000000 RSI: ffffffff8bead5a0 RDI: 0000000000000001
RBP: ffffc90003597950 R08: ffffffff9351e8f7 R09: 1ffffffff26a3d1e
R10: dffffc0000000000 R11: fffffbfff26a3d1f R12: dffffc0000000000
R13: 1ffff920006b2f18 R14: ffffc900035978e0 R15: 0000000000000246
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
RIP: 0033:0x7faec4d773b9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faec5b41048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007faec4f05f80 RCX: 00007faec4d773b9
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007faec4de48e6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007faec4f05f80 R15: 00007ffefe95bb18
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
console output: https://syzkaller.appspot.com/x/log.txt?x=13b28ce5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153cb8d3980000


