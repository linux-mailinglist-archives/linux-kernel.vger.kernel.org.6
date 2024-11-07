Return-Path: <linux-kernel+bounces-400666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3159C10B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D869B24091
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194A12194A9;
	Thu,  7 Nov 2024 21:09:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101AF216420
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013744; cv=none; b=JYScpV5ZFKvMPsslRWmj2YYNHObb0kfLBElGrQkJEa+MKsMDR+tvBwPUn6NMYEDWFBWZ+0yVG0mUYf28XSLLa7XlGmzwb9/sGBMrUrSJRwdsR35WMyMCzhBtTlI6gK4NN35Sjhk1Eo4TOlcBpwVuwrx22QZuP069GIBvh+GZoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013744; c=relaxed/simple;
	bh=U92mdyHK/ybpXL2RIkz7atitE2T8kQwGQAyUtTZjOFY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IPdnLu3tTFzVw7WcqY7AoxUPMgaIrmmxVQO+vMCx2M4rnzcygesWqTsYd3qLa9VI2MP4mwZckyc9QXDMyF20CDT3j0Ttvq4vK6/M+6HEFfJ96kNDX7s5xr6Ed9nuvWRj+lbU00OWY1Ez9qnOkYq6MTjEwIuaPCihzphw7/ZYBIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83acb657f91so163830839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 13:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013742; x=1731618542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeBi7rqjhRanwDMj6bmJtqHOQbGuuMamXNnPebQHZrw=;
        b=MEspt34BP69grEaTb7Ha4UnpzCW8g3La7Vyzy7faCZjq28vw/ir/SW90f0+b4ho2Q4
         0DxPc5sTPFoPyCHj8e149JYh9fw5kptvta8y920eZYidbSPlhIseYWv/OuWANJwyeBpe
         QW7pJ6xdyH+p9XICF55lUkT+xEnllYAsW76t/nmpXXsZX7T+Snin6dCCrSPhc4rOx1kI
         7YH/PX3jzez502G6wckt7tB2EyloqKbV836CnufeIZqGw+qAQaF5IX0n1R9FsaybB9D6
         dZ4GA3MKWHeXCpACtfIk9qVM4NgU3BToLtNdl/seedV/KPugv5ox9df/0uTGWd17znyK
         dSWw==
X-Forwarded-Encrypted: i=1; AJvYcCV9DorJ1ppsXAVvX32wioHTQYfl5AzwVbITfoIG+gLO+tnneDxnoYn6IBMzCGdxOwj/TeiL9YN3BCJkdI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWlV6h1uSfSvP1XD9Sbhdeq8nz5TPGcBJfI39uDBu6oT9QccK
	7koCm+jXp+UyajoS6c70SuHAX6XMV5LILkoNgy8zB/DS9Y685aJoSnjOjLEtFs41KDX0rt35GTr
	TC4xgseGp4WbnrUwcO3jeRJpJR8s0xe+KzGACWWlxLmDsRZCG4qz7jkI=
X-Google-Smtp-Source: AGHT+IH0ePxMfRa264gshUWQ2i9a6rUXNGl30UAu52r8v9OtbzUUINZctiB0O8gPRKLXLVoqK8QDgCghYa+MrSeVMaspIpkh6E7q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ee:b0:3a6:b0d0:ee2d with SMTP id
 e9e14a558f8ab-3a6f19c6039mr7437465ab.9.1731013742217; Thu, 07 Nov 2024
 13:09:02 -0800 (PST)
Date: Thu, 07 Nov 2024 13:09:02 -0800
In-Reply-To: <672d291f.050a0220.38e85e.a404@mx.google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d2c6e.050a0220.0db4.01ac.GAE@google.com>
Subject: Re: [syzbot] [net?] [s390?] general protection fault in
 __smc_diag_dump (3)
From: syzbot <syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com>
To: crashfixer001@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in __smc_diag_dump

Oops: general protection fault, probably for non-canonical address 0xdffffc0000002c03: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000000016018-0x000000000001601f]
CPU: 1 UID: 0 PID: 6134 Comm: syz.0.50 Not tainted 6.12.0-rc6-syzkaller-g80fb25341631 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump.constprop.0+0x3e2/0x2500 net/smc/smc_diag.c:89
Code: 4c 8b b3 58 05 00 00 4d 85 f6 0f 84 f6 02 00 00 e8 83 62 d1 f6 49 8d 7e 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 86 1c 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffffc90002f8f160 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88802861e780 RCX: ffffffff88ff0104
RDX: 0000000000002c03 RSI: ffffffff8abb41ed RDI: 0000000000016018
RBP: ffff88807446e5e0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88807ca98000 R14: 0000000000016000 R15: 0000000000000002
FS:  00007f91ea7fe6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f91ea7ddd58 CR3: 000000007a980000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
 smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
 netlink_dump+0x552/0xcc0 net/netlink/af_netlink.c:2326
 __netlink_dump_start+0x6d9/0x980 net/netlink/af_netlink.c:2441
 netlink_dump_start include/linux/netlink.h:339 [inline]
 smc_diag_handler_dump+0x1fb/0x240 net/smc/smc_diag.c:251
 __sock_diag_cmd net/core/sock_diag.c:249 [inline]
 sock_diag_rcv_msg+0x437/0x790 net/core/sock_diag.c:287
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2607
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2661
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f91eb57dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f91ea7fe038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f91eb735f80 RCX: 00007f91eb57dff9
RDX: 000000000400c000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00007f91eb5f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f91eb735f80 R15: 00007fff7cd545b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump.constprop.0+0x3e2/0x2500 net/smc/smc_diag.c:89
Code: 4c 8b b3 58 05 00 00 4d 85 f6 0f 84 f6 02 00 00 e8 83 62 d1 f6 49 8d 7e 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 86 1c 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffffc90002f8f160 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88802861e780 RCX: ffffffff88ff0104
RDX: 0000000000002c03 RSI: ffffffff8abb41ed RDI: 0000000000016018
RBP: ffff88807446e5e0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88807ca98000 R14: 0000000000016000 R15: 0000000000000002
FS:  00007f91ea7fe6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f91ea7ddd58 CR3: 000000007a980000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	4c 8b b3 58 05 00 00 	mov    0x558(%rbx),%r14
   7:	4d 85 f6             	test   %r14,%r14
   a:	0f 84 f6 02 00 00    	je     0x306
  10:	e8 83 62 d1 f6       	call   0xf6d16298
  15:	49 8d 7e 18          	lea    0x18(%r14),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 86 1c 00 00    	jne    0x1cba
  34:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3b:	fc ff df
  3e:	4d                   	rex.WRB
  3f:	8b                   	.byte 0x8b


Tested on:

commit:         80fb2534 Merge tag 'pwm/for-6.12-rc7-fixes' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1438fd5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f17c54526422c3
dashboard link: https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

