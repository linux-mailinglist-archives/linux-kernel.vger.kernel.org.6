Return-Path: <linux-kernel+bounces-215834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C28D9097AF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 12:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22839B218C1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42526381BA;
	Sat, 15 Jun 2024 10:39:22 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE2F2CCD0
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718447961; cv=none; b=GXiDjzokEfqjbxEYKjNFz0eNc2SyIxATy1nFgoNthbZuf0Kxt5Od+3rWZhsCzxazwEgFcLBEdFrmzFoOw37ohImYdGGcti+/dCneKf7XlIZfcUdXOZs+ja55XCAHOFgAzzT9vncyuzzrHi4wIBKAvMGz8kt3K6uLovrp7w3TLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718447961; c=relaxed/simple;
	bh=1DPEdGU2FZIDxzfeaBWgeXWOaPkbA0CfAkvMbgwVn6s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oince804cse4h6VMssY3/0Jp1hkg3KfQzxSRHN8Pg6NCcvWxaJsI6HOtZgyw+pvFsnSJ/i3TKjpdsrUfRX/0+LvPS9Kn6oUv3UhxnxEY02moL61VNhCNLzDhLbwtIUiqKr2cfAG4fyiBPRW/RNNyGCG/v+kGdPfFmt1UhHGD6hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-375ea274166so9843275ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 03:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718447959; x=1719052759;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKpeRtZQ/N1/ixlPFk9kWWY3CcSnO5A5LzYfoRpvtTE=;
        b=Z9RTTcy+L1C31e2Q+mEXT8zMBd+ORUsOvkSQQh3rrydNfxlS4kxxXAVa0VK39CNJeB
         W9eRmhHJXAyQmQ13MEOue55WcxpsLCO7fwwHpckWUE4p7foXliKeGwI2kJE48KbvJ22z
         yjoDufzVcTz/HobtcNcrtPqiKFR6Ga0tqlie5gPrh3TNS22Vip4CSdhCaBv2+QaHXIgY
         F8ooo0VJDeYzKH3TQumT7wFVmszZoABrECLkhZkrg6zhj5lwnkytsNNcl4fk+pdtaWfO
         jfgK6xW4XsT//N6mQyRSU6/JjklCSkhCEBUuftXa5ZS+m8oDfUOx4mDfpA1d3XObDqfk
         MztQ==
X-Forwarded-Encrypted: i=1; AJvYcCVybxUTdF0vamcOHot0rrl/C8daevZERhoTOKLTScicnYVst6yYZkPsXIE/H4EQYZYD+SW2Q4Lo8L+PPz5f/Evf2FjF5tlINT2RKyPf
X-Gm-Message-State: AOJu0YyB1UsOJpeWR64kuXYW0o2XGaNO3pCC2NIaTptw6ijgD4UJ01Ni
	moU8A5qGk8cVEdcF1gC7RZ3/lQ4Y5J7Oi/75+/GaooeLk0X7leqZ/TWg1rme6ZJG5altrfEQBRv
	gRH29DqXPgk9mUjzFzzenP6RUmk6nUyHU3nDt2Xe7YLVlpLNfscGUvu0=
X-Google-Smtp-Source: AGHT+IE4tJZTc44BMkwrqpmHb27MzbZxBg4YjVSKjONhqOUYyQJUYRNvkcDCA7fk9VTmY3PpIXfFA+mJhmgNfs/SfyDn4xqeitvV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cc:b0:375:ae14:145b with SMTP id
 e9e14a558f8ab-375e1014777mr3007625ab.6.1718447959578; Sat, 15 Jun 2024
 03:39:19 -0700 (PDT)
Date: Sat, 15 Jun 2024 03:39:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000322bec061aeb58a3@google.com>
Subject: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_get_doit
From: syzbot <syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	kolga@netapp.com, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	neilb@suse.de, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cea2a26553ac mailmap: Add my outdated addresses to the map..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169fd8ee980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=4207adf14e7c0981d28d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1f7ce933512f/disk-cea2a265.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ce3b9940616/vmlinux-cea2a265.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19e24094ea37/bzImage-cea2a265.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com

INFO: task syz-executor.1:17770 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller-00022-gcea2a26553ac #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:23800 pid:17770 tgid:17767 ppid:11381  flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_listener_get_doit+0x115/0x5d0 fs/nfsd/nfsctl.c:2124
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb16/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f24ed27cea9
RSP: 002b:00007f24ee0080c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f24ed3b3f80 RCX: 00007f24ed27cea9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
RBP: 00007f24ed2ebff4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

