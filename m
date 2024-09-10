Return-Path: <linux-kernel+bounces-322578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776C2972B11
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8021A1C203A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B130317DFE8;
	Tue, 10 Sep 2024 07:43:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638A17E00F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954185; cv=none; b=eaCyXR4MvUgQV1y0Ye6hgBSNNoNb6wbX7fkqCYatC8UmzpWXRss2YHwxilc6fym9Fifak+qsv7PrqN8fEJhXuVI3IbJgzcoCxbrd41E5neQjylQRIZ4VRp8YRcj8C14uyALbOxEKqEDYxFvwww+m4VMLKeU7ga5aoWRSi7GkFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954185; c=relaxed/simple;
	bh=VqEhg58GHeNMXL4H70GZW+HvRSH/75fVgE48AbuAaTw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KU6LY8nOxtzTdHc8vNDVF/IFbZs0TrPVcGT3UouIWSY7QUgaVNXyVDrKG3/uzM7d9p+OJJWrni9Plelyz+5X7c4qshC5MF5p5I6wFEa1cnCjqzXB14qp1PDTRH+C9AzDc2qLDVNuXur5MnNw4pgxew1hbVZtFTfBu1EzR/woHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82aa9477f54so395147539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954183; x=1726558983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsPGhNMm8jYHBNO57Qm7vLZDfVQNqZEJVm9v1YYtiao=;
        b=DWOd8GlPKGNy8LQucliDRgaVJm+xFp+Qsg9r0yQylPi2XppVnW14IISmI27q8+NWCo
         8FBdF0o/PLuIFTwAcmTAeA0MxQwaVwb2FBmR+RIF0+tmS2zr9PRFoIYjbN0YgnMDKFUj
         KSyhr3Y0e+Ea9CWF3PckdDWv+3cPUEz6heUi261DxzqUIUkS4K4uzCatTG8lyBV5dCE2
         l7wtNYOPHC9q7Y0vst5dqCpOSYHVlw8qwW1QcMJlWqZRLCcUF/LoadEmels/eZMk3k3x
         kfqg1MdmeiFh+nHmSVh0SKEcgTfAZ9Rv/uoDeq4xOVAn7P/oDc3pj3/P08u35XJIBrQC
         kJLw==
X-Forwarded-Encrypted: i=1; AJvYcCUbrqzo+IQ9QAHM0h6sjD6h3j74R1WoK2WpKPfp9844UG9P0son6HIsd3DAU6IKuxbwzWmQ5fHWXJDpYUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC0AKkonzPvvl8tNOa8zARg2J3YtFqkEdZxPrAlNbWV8YqCkxL
	hX9EC56IlOwy6FndCk4bnEhR7TfDlyDhUBCdnmm9bKbzQkQFJuJTL0c5/NiRnOQpPYzVGPvrT2s
	u1SkQ/bCyn4gk0rBXCRz1S1hufoKtS3QsrPGZ3lJnbBG1tRQmaZZfyv8=
X-Google-Smtp-Source: AGHT+IFyJclb23fBSKviOupnnoHYe4rIQTpf4t9POfg9SQf4tRP3jsQWa8t2ulgbXLund19iXB7nJulSlXKn9NUwYT62LgiD6vRq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1505:b0:81f:68e7:aab5 with SMTP id
 ca18e2360f4ac-82cfaf5eaadmr228778639f.0.1725954182693; Tue, 10 Sep 2024
 00:43:02 -0700 (PDT)
Date: Tue, 10 Sep 2024 00:43:02 -0700
In-Reply-To: <tencent_B068E96703AA4446F774176E66C1B3778305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f558c40621bf05a6@google.com>
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
From: syzbot <syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in mptcp_pm_del_add_timer

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 UID: 0 PID: 6054 Comm: syz.1.16 Not tainted 6.11.0-rc7-syzkaller-gbc83b4d1f086-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__list_del_entry_valid_or_report+0x23/0x140 lib/list_debug.c:49
Code: 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 41 54 53 49 89 ff 49 bc 00 00 00 00 00 fc ff df 48 83 c7 08 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 05 e8 f1 a5 40 fd 49 8b 5f 08 4c 89 f8 48 c1 e8
RSP: 0018:ffffc900032172a0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff88801295ac90 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000003 R09: fffff52000642e48
R10: dffffc0000000000 R11: fffff52000642e48 R12: dffffc0000000000
R13: ffff888028988a48 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fe27a4d56c0(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdededd998 CR3: 000000006406c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 mptcp_pm_del_add_timer+0x173/0x2c0 net/mptcp/pm_netlink.c:353
 remove_anno_list_by_saddr net/mptcp/pm_netlink.c:1472 [inline]
 mptcp_pm_remove_addrs_and_subflows net/mptcp/pm_netlink.c:1689 [inline]
 mptcp_nl_remove_addrs_list net/mptcp/pm_netlink.c:1720 [inline]
 mptcp_pm_nl_flush_addrs_doit+0x670/0xdd0 net/mptcp/pm_netlink.c:1761
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe279779eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe27a4d5038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe279915f80 RCX: 00007fe279779eb9
RDX: 0000000001000000 RSI: 0000000020000300 RDI: 0000000000000003
RBP: 00007fe2797e793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe279915f80 R15: 00007fe279a3fa28
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x23/0x140 lib/list_debug.c:49
Code: 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 41 54 53 49 89 ff 49 bc 00 00 00 00 00 fc ff df 48 83 c7 08 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 05 e8 f1 a5 40 fd 49 8b 5f 08 4c 89 f8 48 c1 e8
RSP: 0018:ffffc900032172a0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff88801295ac90 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000003 R09: fffff52000642e48
R10: dffffc0000000000 R11: fffff52000642e48 R12: dffffc0000000000
R13: ffff888028988a48 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fe27a4d56c0(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdededd998 CR3: 000000006406c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	f3 0f 1e fa          	endbr64
   b:	41 57                	push   %r15
   d:	41 56                	push   %r14
   f:	41 54                	push   %r12
  11:	53                   	push   %rbx
  12:	49 89 ff             	mov    %rdi,%r15
  15:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
  1c:	fc ff df
  1f:	48 83 c7 08          	add    $0x8,%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 05                	je     0x36
  31:	e8 f1 a5 40 fd       	call   0xfd40a627
  36:	49 8b 5f 08          	mov    0x8(%r15),%rbx
  3a:	4c 89 f8             	mov    %r15,%rax
  3d:	48                   	rex.W
  3e:	c1                   	.byte 0xc1
  3f:	e8                   	.byte 0xe8


Tested on:

commit:         bc83b4d1 Merge tag 'bcachefs-2024-09-09' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1555a807980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16746797980000


