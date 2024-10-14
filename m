Return-Path: <linux-kernel+bounces-363119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3675499BE14
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 05:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576761C2111B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C79B7404E;
	Mon, 14 Oct 2024 03:15:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233555C29
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875704; cv=none; b=si7DPbXo3a04+EPEE/AWLFzcGE3xRv85PAmr9EwzRA9l6PbG4vqNYV9Crsd4iBZmiVsEu9+sN9AJ0dTZVY39sWUusUCE/iEGmzOoMeWjIk/sHmPmNXi1uXPZCSb/rd5/+8qRfPvytqFn35znB9FzRChAHgmf7q8KCphQEBLrkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875704; c=relaxed/simple;
	bh=iVLfpHKApjoKu6eP2+nvNJx+oTmlYOHX8CW6KH+B8PY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=duq293+j6FQTHdtdC/r2f94wMf72gtfFM0nnk336aTJ+/rUzvhLSkjZ17DjyIFKJC9h62G6IUKS92eVrkiWVA39dDisOygp3NO7pTVnPKdnfKdsXHamYd0HdiR/E0H9CMAlxB+uYvtX/qd2vfxypr2XZWSaoxBJp+DqYsAJdmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3ae775193so27826865ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 20:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728875702; x=1729480502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsyYBXtsYMGaObkSqE1i1LWfzWKU9eVdPqDS2W9ueWY=;
        b=WDCgQP1zk6PEa6rYsfBGkCa5DU2sklmrFwGC7AyaKtiSMrW+37+V6JV0kJfFMAH+cT
         1IDso7c1DmPeC+30NpEUthml5Z3e1m1ooj8b4IXkW2xOohXvvw84b/QBSkfxzszvCNrS
         xOlliE5QoVdMlKEofAFA8gc9nGX8pouAsLSYsnT4i+F14abUouJtwa7f3LDAQ9jjwwMb
         S3cLmWS73TfW+uG4V0rFXVIt/XBjgOubUIg7/fQjoSUpoXM7Hh68hJLH7YBpjaNXPJ/7
         doH/+c7MKqURMHpL6EuE0IMOCsP+h81oYTtzG1x+dp9JEWpOJAvsK5Meutt6S915mJ7D
         UpJQ==
X-Gm-Message-State: AOJu0YyGAaLOiNmXtBq2a2s84LvHT54yPvzv27KC6MPhV+3zUPWDoDuS
	iFw/z3Rba0aR4ehS0zzKlJb9/ZUF29o66ZJOWjByoLpnjQ4KN+nh/LZKR63xfPSTdJHvv1iCBKa
	cy93TL8Ks/7k+QLDjKc/4tgZWLXPRqGlL7TjgKA/K2BSnqxpeqpOHIRY=
X-Google-Smtp-Source: AGHT+IFJ0wOpTQeAmevRy29Qjvb9ciRdsg0ymflsYFnVVKlqOqywr8ohkvOE8eosyo4TDCFWTP8eLv5mbS+sqVGxjG24KOp10zY2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c8:b0:3a3:b497:f951 with SMTP id
 e9e14a558f8ab-3a3bce11c75mr35150865ab.23.1728875702389; Sun, 13 Oct 2024
 20:15:02 -0700 (PDT)
Date: Sun, 13 Oct 2024 20:15:02 -0700
In-Reply-To: <20241014025315.3272265-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670c8cb6.050a0220.3e960.0051.GAE@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in cfg80211_event_work (4)
From: syzbot <syzbot+5506b2556159a1ab6923@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in linkwatch_event

INFO: task kworker/u4:4:72 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc3-syzkaller-g6485cf5ea253-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:4    state:D stack:22040 pid:72    tgid:72    ppid:2      flags:0x00004000
Workqueue: events_unbound linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 linkwatch_event+0xe/0x60 net/core/link_watch.c:276
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u4:5:1026 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc3-syzkaller-g6485cf5ea253-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:5    state:D stack:18672 pid:1026  tgid:1026  ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor:5592 blocked for more than 148 seconds.
      Not tainted 6.12.0-rc3-syzkaller-g6485cf5ea253-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20608 pid:5592  tgid:5592  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 __sys_sendto+0x39b/0x4f0 net/socket.c:2214
 __do_sys_sendto net/socket.c:2226 [inline]
 __se_sys_sendto net/socket.c:2222 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2222
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f039737fe8c
RSP: 002b:00007ffdccf85eb0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f0398064620 RCX: 00007f039737fe8c
RDX: 0000000000000040 RSI: 00007f0398064670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffdccf85f04 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f0398064670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:5596 blocked for more than 150 seconds.
      Not tainted 6.12.0-rc3-syzkaller-g6485cf5ea253-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20992 pid:5596  tgid:5596  ppid:1      flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 __sys_sendto+0x39b/0x4f0 net/socket.c:2214
 __do_sys_sendto net/socket.c:2226 [inline]
 __se_sys_sendto net/socket.c:2222 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2222
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0717b7fe8c
RSP: 002b:00007ffd44c63d10 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f0718864620 RCX: 00007f0717b7fe8c
RDX: 000000000000002c RSI: 00007f0718864670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd44c63d64 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f0718864670 R15: 0000000000000000


Tested on:

commit:         6485cf5e Merge tag 'hid-for-linus-2024101301' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132ca887980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=5506b2556159a1ab6923
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11bb4727980000


