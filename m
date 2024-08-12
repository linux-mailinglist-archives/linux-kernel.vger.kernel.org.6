Return-Path: <linux-kernel+bounces-283681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 310AF94F7B3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216951C22409
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493811922D7;
	Mon, 12 Aug 2024 19:49:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321E0142624
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492146; cv=none; b=mjYNpLd+kAmJeYTluiCCVL4huCXKiUd/2cakcboTX0qmeucnHSyP/tqwZY4P1l1x9RQKljAua+9Mw6cniCmunWa5oTQkdv0QwkBM4rpBB8XrdwihhNkAcXgbJWLx4Yh42NLpNv30XZ9XmQVa5/jcMjRtGIhckTqz0ECSHTS6O+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492146; c=relaxed/simple;
	bh=+ngI/rPEth2TIjbsNxW592KbIkTG2SQUHe6tJLGh/5Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ID3l5sY/ovuIqfeaVeVNA4ec8kzOUADgBqWh2H+3bWMjFWwjGHINHzAH+gz7E8cqBNQg52QnWZOAL0WgYxZZdsB5TTKGj5BjkZKkyPEpW+nkYExAU3GBjYXMVZ0BlNpi9YrFngFbIdDpaYsJpLdN44jRV63RYOGvEITDIByKTrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3b5858e6so58072695ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723492144; x=1724096944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=625tls8MIOO4kWZKE31jfpJTp71KjYAhFNLTiVf3pVI=;
        b=mvS/zG9L9Ht9sW01BUkJMfiqw8hlw9jaxMPV0op4xMFl/xBkiUnn0deQ6iFUf2VT/A
         gqYoIQOKfw9INmbD+AelssC2oMYlfTJSDrio6vpx8niwWgzeIKgJaU/0u70V6y8u5oQZ
         ElPeAJsrXJu3HAkYqrbE3qKNCPCtKNaWDK9I1XDPv4hc5FxTHY0fUDIjUPboHfPXFYhi
         oZUOQAuusnarXyG81sQQBLF1pcDUnDdrmbK3x9NWK/fuvfV1iY9j1/rE0L0vJPJ09yKr
         Vb3h4UrE+z19xhSzoEKxM6+vQQDaZ4rw4H64gIEZWlcq5YBZ9nrkvF9KtWZQla+K1R2y
         saSA==
X-Gm-Message-State: AOJu0Yzort+lgWGwvHvhWqN57fa70akwPx7DMI5KzTJs6SATvRKERIJQ
	MLuPK3iqErldyaipRBmRGA5zBHZv6BbLkukX20NXwi5oE5X80Jyq28IohAHeTNdcmtT604rKdrc
	ubYX6WwUGtALpAxQ2qdqqpLcEI8Spk0Poh8BLfK52Z98DqpRyp5LqHxs=
X-Google-Smtp-Source: AGHT+IGWyADHBEa7Zyo5cOLgQki80BCxMPrp9hcyEdvFQusc93mF/M8k+PziWaKQ/JWHW/QGUtZjm92Ct7SeY9korqogYGR4K0o7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c8:b0:396:1fc1:7034 with SMTP id
 e9e14a558f8ab-39c476977d9mr637255ab.0.1723492144182; Mon, 12 Aug 2024
 12:49:04 -0700 (PDT)
Date: Mon, 12 Aug 2024 12:49:04 -0700
In-Reply-To: <20240812092841.3289430-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007070d061f81c9b6@google.com>
Subject: Re: [syzbot] [net?] [s390?] general protection fault in smc_diag_dump_proto
From: syzbot <syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in smc_diag_dump_proto

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 6159 Comm: syz.0.21 Not tainted 6.10.0-syzkaller-09703-gd7e78951a8b8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump net/smc/smc_diag.c:89 [inline]
RIP: 0010:smc_diag_dump_proto+0x709/0x3270 net/smc/smc_diag.c:217
Code: 08 48 89 df e8 f8 0d 9d f6 48 8b 44 24 28 4c 8d 68 14 48 8b 1b 48 83 c3 0e 48 89 d8 48 c1 e8 03 49 bf 00 00 00 00 00 fc ff df <42> 0f b6 04 38 84 c0 0f 85 46 1b 00 00 0f b7 1b 66 c1 c3 08 4c 89
RSP: 0018:ffffc9000358eb00 EFLAGS: 00010203
RAX: 0000000000000001 RBX: 000000000000000e RCX: ffff888069659e00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffffc9000358ef90 R08: ffffffff8990c562 R09: 1ffff1100eef084b
R10: dffffc0000000000 R11: ffffed100eef084c R12: 1ffff1100eef08e0
R13: ffff8880777f0014 R14: ffff888077784200 R15: dffffc0000000000
FS:  00007fddae9ea6c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fddae9e9fa8 CR3: 00000000736f2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 smc_diag_dump+0x59/0xa0 net/smc/smc_diag.c:236
 netlink_dump+0x647/0xd80 net/netlink/af_netlink.c:2325
 __netlink_dump_start+0x59f/0x780 net/netlink/af_netlink.c:2440
 netlink_dump_start include/linux/netlink.h:339 [inline]
 smc_diag_handler_dump+0x1ab/0x250 net/smc/smc_diag.c:251
 sock_diag_rcv_msg+0x3dc/0x5f0
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_sendmsg+0x134/0x200 net/socket.c:768
 splice_to_socket+0xa13/0x10b0 fs/splice.c:889
 do_splice_from fs/splice.c:941 [inline]
 do_splice+0xd77/0x1900 fs/splice.c:1354
 __do_splice fs/splice.c:1436 [inline]
 __do_sys_splice fs/splice.c:1652 [inline]
 __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fddadb75f19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fddae9ea048 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007fddadd06038 RCX: 00007fddadb75f19
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fddadbe4e68 R08: 0000000080000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fddadd06038 R15: 00007ffc243501f8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump net/smc/smc_diag.c:89 [inline]
RIP: 0010:smc_diag_dump_proto+0x709/0x3270 net/smc/smc_diag.c:217
Code: 08 48 89 df e8 f8 0d 9d f6 48 8b 44 24 28 4c 8d 68 14 48 8b 1b 48 83 c3 0e 48 89 d8 48 c1 e8 03 49 bf 00 00 00 00 00 fc ff df <42> 0f b6 04 38 84 c0 0f 85 46 1b 00 00 0f b7 1b 66 c1 c3 08 4c 89
RSP: 0018:ffffc9000358eb00 EFLAGS: 00010203
RAX: 0000000000000001 RBX: 000000000000000e RCX: ffff888069659e00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffffc9000358ef90 R08: ffffffff8990c562 R09: 1ffff1100eef084b
R10: dffffc0000000000 R11: ffffed100eef084c R12: 1ffff1100eef08e0
R13: ffff8880777f0014 R14: ffff888077784200 R15: dffffc0000000000
FS:  00007fddae9ea6c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fddae9e9fa8 CR3: 00000000736f2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 48 89             	or     %cl,-0x77(%rax)
   3:	df e8                	fucomip %st(0),%st
   5:	f8                   	clc
   6:	0d 9d f6 48 8b       	or     $0x8b48f69d,%eax
   b:	44 24 28             	rex.R and $0x28,%al
   e:	4c 8d 68 14          	lea    0x14(%rax),%r13
  12:	48 8b 1b             	mov    (%rbx),%rbx
  15:	48 83 c3 0e          	add    $0xe,%rbx
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  27:	fc ff df
* 2a:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 46 1b 00 00    	jne    0x1b7d
  37:	0f b7 1b             	movzwl (%rbx),%ebx
  3a:	66 c1 c3 08          	rol    $0x8,%bx
  3e:	4c                   	rex.WR
  3f:	89                   	.byte 0x89


Tested on:

commit:         d7e78951 Merge tag 'net-6.11-rc0' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=137931c5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6f4e2cb79bdcd45
dashboard link: https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1363c96d980000


