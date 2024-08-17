Return-Path: <linux-kernel+bounces-290669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E092B95571D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 12:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4EC1C2106C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52F91494C9;
	Sat, 17 Aug 2024 10:09:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E550328B6
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723889348; cv=none; b=CCyrBA+fF5y1ocTGELGGtAVL8jGvmoQn7TvpePzAT7putMyRZOCwK04kiTxygFuSLKoKIMItB2F4mLNi8vBdMO0wwrcJ6n0KRboVDJ68BcDwyaRT5IY4kjszx1WToxKyEs25Ocn/0JkZg6YY4UC93pEeXGQEL1TD7zOZqC+/bjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723889348; c=relaxed/simple;
	bh=ewHlYIWUpq5FkiZ4QUu5bnndmQi931+hKU46fzXUhw4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pr2xcYCVS/DB/pyrQ8w4+NkUuiivkHNW4JdsPxfh8Fxn/VZDzy6k2krJQa3o/CuunQKZ/cHpE0Mssd4kLfeyG0A0RO/gpmafuvPt+jWNEoBFca9yLltAdLPEu/KvpdqA3NCbEHldFZ4f/ij9GYrFDKzuGUv5QnsZpNf9I+I+as0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-824d69be8f7so265353639f.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 03:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723889346; x=1724494146;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btpFQXawrFTuU02V8eBttUtf52VrdOW+PG0eD4n4qjQ=;
        b=hRnkQkTAbHfFK66Hsy3eTg8+uQw8CX6Wl6wrU46VKviQaY0DRbX2h5BD5pLwo9RiZp
         4vnlBmYWeAtqzIGVYY5xy85yXkepNsk7XjFMWeBSH12HIe/1Uh5ytbWK1w7+8Ka+jHXW
         W7/AfzIUmtp3zxVI3IcrvA4306SmNDNEqVhQhIexO1Cf++D1T6X2bX+DoSCM1bDsPELI
         dZSQ8F9CO15o2loQ7dvf+0Nxt6l7DiyemyWEJ+AoBAPV9IZLISi8lpU7aZbgf8NPKOT8
         eL88oUt030ZTPI1EIGEg1q7eOdUpEXXOcuLmYszqVHfC+GEjbrKdavjtfFKXEVRSUKd7
         QiIA==
X-Forwarded-Encrypted: i=1; AJvYcCVetstEDZePv3geCyXjaT+AiOXMG08KFMZL6bB5shcxdwLHYLxmi6TTsaa1MtTD605ZtBMhfUfNr/2TGzip+evSjY5M1PHpDx0BuE2k
X-Gm-Message-State: AOJu0YxBuWqNMklHYAGQog/ppP3eYrA0OVj3x7YP7ymbzcL9Vhg2hmsn
	zC0aXPiYUSMZhQkBky7G5uCjwEu5DR3DAzPMIfP5LG+PdjE0x24Sg/TvOa5cpMwrY+JqvDgPPWf
	MjBwSPGftsOwFcfuNw5bSoW+81DaCozMK6qs9hLVioCQiL9x32UAqnJA=
X-Google-Smtp-Source: AGHT+IHis9aevFyuxokam3AEmfDxwy4wEpix5781e10Tr5MOVnoGCe4lKn/kCjseoVt6MsXhN3Z/5olyGumQuNKZLNTa2R8uUOtg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:831e:b0:4b9:def5:3dcb with SMTP id
 8926c6da1cb9f-4cce15d71d1mr326157173.2.1723889345701; Sat, 17 Aug 2024
 03:09:05 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:09:05 -0700
In-Reply-To: <20240817083158.2079-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015383c061fde4435@google.com>
Subject: Re: [syzbot] [cgroups?] possible deadlock in task_rq_lock
From: syzbot <syzbot+ca14b36a46a8c541b509@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering=
 an issue:
general protection fault in __alloc_workqueue

workqueue: Failed to create a rescuer kthread for wq "wg-crypt-=18": -EINTR
Oops: general protection fault, probably for non-canonical address 0xdffffc=
0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 6468 Comm: syz-executor Not tainted 6.11.0-rc3-next-2024=
0816-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 08/06/2024
RIP: 0010:__lock_acquire+0x69/0x2040 kernel/locking/lockdep.c:5010
Code: b6 04 30 84 c0 0f 85 87 16 00 00 45 31 f6 83 3d 48 05 a9 0e 00 0f 84 =
ac 13 00 00 89 54 24 54 89 5c 24 68 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 1=
2 4c 89 ff e8 49 5c 8c 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc9000438ec30 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff20318b6 R12: ffff88802b189e00
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  000055556e398500(0000) GS:ffff8880b9000000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555911bd808 CR3: 00000000702f8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
 touch_wq_lockdep_map kernel/workqueue.c:3876 [inline]
 __flush_workqueue+0x1e3/0x1770 kernel/workqueue.c:3918
 drain_workqueue+0xc9/0x3a0 kernel/workqueue.c:4082
 destroy_workqueue+0xba/0xc40 kernel/workqueue.c:5830
 __alloc_workqueue+0x1c30/0x1fb0 kernel/workqueue.c:5745
 alloc_workqueue+0xd6/0x210 kernel/workqueue.c:5758
 wg_newlink+0x260/0x640 drivers/net/wireguard/device.c:343
 rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
 rtnl_newlink+0x1591/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a8/0x500 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f52c6b7bd0c
Code: 2a 5a 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b =
54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff f=
f 77 34 89 ef 48 89 44 24 08 e8 70 5a 02 00 48 8b
RSP: 002b:00007ffdb7bbca90 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f52c7844620 RCX: 00007f52c6b7bd0c
RDX: 000000000000003c RSI: 00007f52c7844670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffdb7bbcae4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f52c7844670 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x69/0x2040 kernel/locking/lockdep.c:5010
Code: b6 04 30 84 c0 0f 85 87 16 00 00 45 31 f6 83 3d 48 05 a9 0e 00 0f 84 =
ac 13 00 00 89 54 24 54 89 5c 24 68 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 1=
2 4c 89 ff e8 49 5c 8c 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc9000438ec30 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff20318b6 R12: ffff88802b189e00
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  000055556e398500(0000) GS:ffff8880b9000000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555911bd808 CR3: 00000000702f8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b6 04                	mov    $0x4,%dh
   2:	30 84 c0 0f 85 87 16 	xor    %al,0x1687850f(%rax,%rax,8)
   9:	00 00                	add    %al,(%rax)
   b:	45 31 f6             	xor    %r14d,%r14d
   e:	83 3d 48 05 a9 0e 00 	cmpl   $0x0,0xea90548(%rip)        # 0xea9055d
  15:	0f 84 ac 13 00 00    	je     0x13c7
  1b:	89 54 24 54          	mov    %edx,0x54(%rsp)
  1f:	89 5c 24 68          	mov    %ebx,0x68(%rsp)
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1) <-- trapping instruct=
ion
  2e:	74 12                	je     0x42
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 49 5c 8c 00       	call   0x8c5c81
  38:	48                   	rex.W
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


Tested on:

commit:         367b5c3d Add linux-next specific files for 20240816
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git
console output: https://syzkaller.appspot.com/x/log.txt?x=3D1191c45b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61ba6f3b22ee546=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dca14b36a46a8c541b=
509
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16a7edf59800=
00


