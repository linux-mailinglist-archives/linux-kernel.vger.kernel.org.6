Return-Path: <linux-kernel+bounces-333734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127BA97CD16
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC581C21838
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D14119F49D;
	Thu, 19 Sep 2024 17:34:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9012417999
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726767246; cv=none; b=Nesb26lCSO3G2oW5z9gzPKMk4X6wwTa2TF1oqyp0i0SWoM5jpANAgmyxnWe0/BxMscXmBDZo+4hu9x7/LvDvblBKphl/MI5zyjzAQZp9F6nk8xhfc/TlCnqm4L5PPy30oKHYIBYIjYs3dmo+iBnLY8bUO5vWfornIpnepTYrHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726767246; c=relaxed/simple;
	bh=J+XLdWVkE9DVTpaGWhow8mKZf/rfAJJU+hMDDYV6gLw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sUdoIBmTs8tekJHnF4d1P3QWvoqWT+FEnsBPisGFPSQ/aEOOVNTdlKFhwYBO2aeLphWpLi5cvDWdBSArtfhdQOVceMRFfeEI/zsA9VezplQ28yVUDnntMJiGGzDfXa0YLJoexEpn3+L7oMjCwrMTkUohHcQlHUpPZLiZNntF40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a09aecb414so13394465ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 10:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726767243; x=1727372043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBVfmvmI7uEP9sypOD/a7QeCx7P4D7SBlCJXMHhqTEk=;
        b=AWwBwvlGZjg9Oi8km/L13/yRJa0mQ03XE+tG7cBgSVDZZOO1VHgHvOU+1tfAoNBM63
         OJdhUPv2B+hO5rT0XwNis3s6vrhaiNgFy9eIecFKzizpmY6zrThwGQ5DI2QxK4HsysPu
         2kR1duU1sKpVW6E/Kn+vA8+DpWQcDj9l4pxi9M4m2znCqQqQdQ/bAeFR2A+L9qQrPNAE
         ptfbzMyKVVacgBge64thtuvyNPGPh2t2jIM/Vs8uoyUhZe6poRZUG/l4MgqygtJDiFZM
         tTKj9AP0Wc5+a1PPxv/AbU1UTTspQQrtg7sHOWfRvZY7+6Yig0ecWJDhN4cpLv5k2HwM
         S9zg==
X-Forwarded-Encrypted: i=1; AJvYcCUmFM4wB/iBgHa1PZ7DwwSBHRocJ9+zZ9iYLYKJrrw6BTDn22pkIKptjdAI2o+LbeQR/2BwGMWCDwkxOeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5xFZEVNoGOFOoOBPNUqxJ8SETE1irjsIc+pSG04Kb4/pOlH5t
	cYaBG2zf22ZG2bV54BmEeX0VcWAhCR6/dYTCimUm9ZswdAmcHIdms5eqEVoJThHJs5lGO//cHZ9
	f2bseTr4JCOYJ240TjYjVJ56RjGBx99ZgTmDomFYoFRmGf1/iDqphcT0=
X-Google-Smtp-Source: AGHT+IEFuwtfgnf/Upy9tGYJ5xAFXhjwhy59JFq7RrvDXjYv9IPcVPe1yP3pUEzp/eYF4ZvW3mAIND+uNRACSOxKcHKJM7hUgyyH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1785:b0:3a0:a385:9129 with SMTP id
 e9e14a558f8ab-3a0c8b75a66mr3534565ab.0.1726767243590; Thu, 19 Sep 2024
 10:34:03 -0700 (PDT)
Date: Thu, 19 Sep 2024 10:34:03 -0700
In-Reply-To: <20240919124307.28121-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec608b.050a0220.29194.003a.GAE@google.com>
Subject: Re: [syzbot] [net?] [s390?] general protection fault in smc_diag_dump_proto
From: syzbot <syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in smc_diag_dump_proto

Oops: general protection fault, probably for non-canonical address 0xfbd5a5d5a0000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead0000001f]
CPU: 0 UID: 0 PID: 6342 Comm: syz.0.53 Not tainted 6.11.0-syzkaller-07337-g2004cef11ea0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump net/smc/smc_diag.c:89 [inline]
RIP: 0010:smc_diag_dump_proto+0x6d9/0x3270 net/smc/smc_diag.c:217
Code: 80 3c 2c 00 74 08 48 89 df e8 e3 0e 96 f6 48 89 5c 24 30 48 8b 1b 48 85 db 0f 84 2d 02 00 00 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 b8 0e 96 f6 48 8b 44 24 28 4c 8d
RSP: 0018:ffffc90002f2eb00 EFLAGS: 00010a06
RAX: 1bd5a9d5a0000003 RBX: dead4ead00000018 RCX: ffff8880205c1e00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffffc90002f2ef90 R08: ffffffff8999ab82 R09: 1ffff1100fa0900b
R10: dffffc0000000000 R11: ffffed100fa0900c R12: 1ffff1100fa090c5
R13: dffffc0000000000 R14: ffff88807d048000 R15: ffff888022a68010
FS:  00007f5b5848e6c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5b5848dfa8 CR3: 00000000279b8000 CR4: 00000000003506f0
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
RIP: 0033:0x7f5b57775f19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5b5848e048 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007f5b57906038 RCX: 00007f5b57775f19
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f5b577e4e68 R08: 0000000080000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f5b57906038 R15: 00007ffdbb5552f8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump net/smc/smc_diag.c:89 [inline]
RIP: 0010:smc_diag_dump_proto+0x6d9/0x3270 net/smc/smc_diag.c:217
Code: 80 3c 2c 00 74 08 48 89 df e8 e3 0e 96 f6 48 89 5c 24 30 48 8b 1b 48 85 db 0f 84 2d 02 00 00 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 b8 0e 96 f6 48 8b 44 24 28 4c 8d
RSP: 0018:ffffc90002f2eb00 EFLAGS: 00010a06
RAX: 1bd5a9d5a0000003 RBX: dead4ead00000018 RCX: ffff8880205c1e00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffffc90002f2ef90 R08: ffffffff8999ab82 R09: 1ffff1100fa0900b
R10: dffffc0000000000 R11: ffffed100fa0900c R12: 1ffff1100fa090c5
R13: dffffc0000000000 R14: ffff88807d048000 R15: ffff888022a68010
FS:  00007f5b5848e6c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5b5848dfa8 CR3: 00000000279b8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	80 3c 2c 00          	cmpb   $0x0,(%rsp,%rbp,1)
   4:	74 08                	je     0xe
   6:	48 89 df             	mov    %rbx,%rdi
   9:	e8 e3 0e 96 f6       	call   0xf6960ef1
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
  34:	e8 b8 0e 96 f6       	call   0xf6960ef1
  39:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  3e:	4c                   	rex.WR
  3f:	8d                   	.byte 0x8d


Tested on:

commit:         2004cef1 Merge tag 'sched-core-2024-09-19' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1228b69f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45ec9bead13b378d
dashboard link: https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=114ba607980000


