Return-Path: <linux-kernel+bounces-332622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A9A97BC06
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2D31F23313
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C351898EC;
	Wed, 18 Sep 2024 12:13:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063CD3C3C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726661584; cv=none; b=aHyoy7oMKprcF+sy/RBLlfqxZ5+QabA5NTdqXKR7PQzLzpg3yvHVLzZx1lN2JAxWUkh1H6r59iOa2+WPEW8E8rpbd7iCICkz9bKWzT50TCHnssTKAHCqMmr6cf4GStbznfy7CNEqjQJ1ooIUkQS3xFCgaLSl/p3f9NrGBc/Y2EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726661584; c=relaxed/simple;
	bh=qcXpYq+w2v8Ow1pbUzH5ZeGvb+wsXJrGa8v7Mxcurw4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=goPe4OPPYNc0/ucDgQTOkKC1ZyLYPOyre6Gbp6cPL72PjQI3/ticeHHxPFv02pe8EqtHHa0Wtv22wFlK+6sNQ1f7gHpCRXANA6MkQEtcZ+FeEfd4os8KEr/Re4raSiRgOte+sc9g04GLVObdWmGbpEZdSuJzP/whrTgK7afhs1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f5605c674so114085325ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 05:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726661582; x=1727266382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJwUEyA0vWvs26KMntXooQTuU0pJnIbU+2vuTjS79iA=;
        b=JfSTtrUSESbfRY4c9oA8xkSmR0yk98Co3BbuadlYNRK4YVvb+N96U/wiFRc6VdFUK3
         xDEmC8G+3UXU71+T5kx7eKSI9JBIA1ejiqnf1tbWzsw/2caaDUmVhL8N7wioTG1+Iva6
         pEKY9gqpO+JHAyOYnwJ9oCHySCUk+UmJ4FIGiqsl+xKM2QXUIkxe4rZYADU1Z1kaBhpi
         EL47F3NRdD18w1NMnj26nWhYpXlpOJI76qAmPJWWxmpMxjiU/CzTL7T+qClq/krMhG32
         8qjN7S/IZdoegj4K9TbM5/Z2hQ9sjjM+UvkT8F1C4KpmTygInbDq1MtP7r5PikUay2bH
         yFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQsodQliCsuW+tkdTR253UXQCqfbVOpBQHgBSmuySNk0o4JAYk2kOHITMLeIhYCSrtVg1jH6rjTNBD3ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4FrxgFdlgED5NFMZ1aGkdJwhpeRjDcvTmnddQH94hCarqa89
	mDb1FtUpVJcuj5npi0lMKIYgFbuZADnO+UzzM4tnqdUQ8fhKduYH+Xz9hWIQ/6mNyFw3AKMq8rf
	y9RPJrs8XxsaGeQUzyEzyDJC0XAq6dUMHrywvh0G8oE3ao/m/3mKA6no=
X-Google-Smtp-Source: AGHT+IHndQv1+ysWOVBYLhYVA/9IGhgBWmQkVKbk9VnXhaLzPfcatvn5Lr9NnL8TVylKIinU2fQn3PCIrLXjuzIpIqbTlBOQVfzp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c5:b0:3a0:b23a:81f2 with SMTP id
 e9e14a558f8ab-3a0b23a8477mr49452825ab.12.1726661582024; Wed, 18 Sep 2024
 05:13:02 -0700 (PDT)
Date: Wed, 18 Sep 2024 05:13:02 -0700
In-Reply-To: <20240918090515.212605-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e8a5a062263ba5d@google.com>
Subject: Re: [syzbot] [net?] [s390?] general protection fault in smc_diag_dump_proto
From: syzbot <syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in smc_diag_dump_proto

Oops: general protection fault, probably for non-canonical address 0xdffffc00000a2403: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000000512018-0x000000000051201f]
CPU: 0 UID: 0 PID: 6007 Comm: syz.1.56 Not tainted 6.11.0-syzkaller-05026-g39b3f4e0db5d-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump net/smc/smc_diag.c:89 [inline]
RIP: 0010:smc_diag_dump_proto+0x6d9/0x3270 net/smc/smc_diag.c:217
Code: 80 3c 2c 00 74 08 48 89 df e8 13 47 96 f6 48 89 5c 24 30 48 8b 1b 48 85 db 0f 84 2d 02 00 00 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 e8 46 96 f6 48 8b 44 24 28 4c 8d
RSP: 0018:ffffc9000232eb00 EFLAGS: 00010206
RAX: 00000000000a2403 RBX: 0000000000512018 RCX: ffff888021765a00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffffc9000232ef90 R08: ffffffff89984322 R09: 1ffff1100478378b
R10: dffffc0000000000 R11: ffffed100478378c R12: 1ffff1100478382b
R13: dffffc0000000000 R14: ffff888023c1bc00 R15: ffff88806a9a8010
FS:  00007f10eb3d36c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f10eb3d2fa8 CR3: 0000000029d36000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 smc_diag_dump+0x59/0xa0 net/smc/smc_diag.c:236
 netlink_dump+0x647/0xd80 net/netlink/af_netlink.c:2325
 __netlink_dump_start+0x5a2/0x790 net/netlink/af_netlink.c:2440
 netlink_dump_start include/linux/netlink.h:339 [inline]
 smc_diag_handler_dump+0x1ab/0x250 net/smc/smc_diag.c:251
 sock_diag_rcv_msg+0x3dc/0x5f0
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_sendmsg+0x134/0x200 net/socket.c:768
 splice_to_socket+0xa10/0x10b0 fs/splice.c:889
 do_splice_from fs/splice.c:941 [inline]
 do_splice+0xd68/0x18e0 fs/splice.c:1354
 __do_splice fs/splice.c:1436 [inline]
 __do_sys_splice fs/splice.c:1652 [inline]
 __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f10ea575f19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f10eb3d3048 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007f10ea706038 RCX: 00007f10ea575f19
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f10ea5e4e68 R08: 0000000080000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f10ea706038 R15: 00007ffc7d1ca708
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump net/smc/smc_diag.c:89 [inline]
RIP: 0010:smc_diag_dump_proto+0x6d9/0x3270 net/smc/smc_diag.c:217
Code: 80 3c 2c 00 74 08 48 89 df e8 13 47 96 f6 48 89 5c 24 30 48 8b 1b 48 85 db 0f 84 2d 02 00 00 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 e8 46 96 f6 48 8b 44 24 28 4c 8d
RSP: 0018:ffffc9000232eb00 EFLAGS: 00010206
RAX: 00000000000a2403 RBX: 0000000000512018 RCX: ffff888021765a00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffffc9000232ef90 R08: ffffffff89984322 R09: 1ffff1100478378b
R10: dffffc0000000000 R11: ffffed100478378c R12: 1ffff1100478382b
R13: dffffc0000000000 R14: ffff888023c1bc00 R15: ffff88806a9a8010
FS:  00007f10eb3d36c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f10eb3d2fa8 CR3: 0000000029d36000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	80 3c 2c 00          	cmpb   $0x0,(%rsp,%rbp,1)
   4:	74 08                	je     0xe
   6:	48 89 df             	mov    %rbx,%rdi
   9:	e8 13 47 96 f6       	call   0xf6964721
   e:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
  13:	48 8b 1b             	mov    (%rbx),%rbx
  16:	48 85 db             	test   %rbx,%rbx
  19:	0f 84 2d 02 00 00    	je     0x24c
  1f:	48 83 c3 18          	add    $0x18,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 e8 46 96 f6       	call   0xf6964721
  39:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  3e:	4c                   	rex.WR
  3f:	8d                   	.byte 0x8d


Tested on:

commit:         39b3f4e0 Merge tag 'hardening-v6.12-rc1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a1c4a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c3b301db2ae9f24
dashboard link: https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

