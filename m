Return-Path: <linux-kernel+bounces-266016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D593F948
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F141F22FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB8C157A41;
	Mon, 29 Jul 2024 15:23:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C531E4A2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266606; cv=none; b=naJYiV+GUl97mSvw1yJjVGILoBLnX1dcKGPr07mRxZ6kSpmjZlP+dXWws1y+uVnILRnIAeYkp6cSMQM9hMs5HzvUHXnhQGPPXw2A2/1OK6hrsbQ84nuxhDYtKaY1XPOA+3ywzvR45Fl+cBpjsrJbDyMKlB+hQO9HKqGQPkAyx9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266606; c=relaxed/simple;
	bh=qYomeXMkVFuXrgdGSB8/1iMUmIyedm6/4wkFQU+rvMM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MwZaJmTvC+51RN54ZW83dlN0v/TNz913lsUA98V2CttWvvZqkj44clQWhegYj/zZkFs9T0NoLzuHW4HDof+aa80oqKgMvYLVqPm1Nv4RExfgDCIspd+ipGf8cjZDwNt5DrCU+ufnmLSceHF72ldOtg3g+Ah/mO0zM8IsfdsGhAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f86fc9fdaso572233639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722266604; x=1722871404;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ug6pUn7w8BPfCU3F0BD0f8l6pYsg9PaPyBynog0myRk=;
        b=lNF6MU8yWsFZQnmT1lcDaQ0LoADb7LUmIyBaRa1ret/mSmbdaOHfOr67Y2plikX4fe
         LOpM7fXM1Mq6UcpKNDNV49SLe/2Cnt7hQM0LR2BWmcIEajFUMiJVyrTmpM0B1RL5JVCn
         0zAJgKZGr69Ojb7/NtZmqywLVA56SvS5eRhPOOA76tgX8CGahuqyTEA/OnjbRKVm4gY+
         x+e6XeDeeGtzvmeUAl30Kuaz1BoHZNnINDC02w/UiSH37XG22ioMq/DULDjhjT+n+DFn
         ndQhNaxGdI2a517qMHYT4PV95vUhpSzJVBh0O5H4a1S7lAGeFq8fo4+G8ftv0IZddOox
         J9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYWjINUVhoSZInYuN6+YUR6wp1ihjU/P4IyROyw5wEndIwcqy9Lnqxh/atpq64HgZLMLXYOjUM7To4HLHhutWkPrZTa3UE5FZ9iFq5
X-Gm-Message-State: AOJu0Yx75sZXMfdu5vSq6lJg9XD/oxKksuQXGaITRcv5zEdpbLDWEf4S
	7OSqpe7e8ceqBA6DikXlNubTQfi3WMOyIwYdsS9f/Re2eu49s0xCh02Bf2C/H5oW4nj1go2yaOI
	iZin/zCxAQMHqNgkyEFlH68DZ358lYSuZ0jgt7JjioVq4sHBcAjcueEg=
X-Google-Smtp-Source: AGHT+IFrRIj/C3ns4WiWQ7hSHn7roIVoQmhlw74yzJcq7hLTEbmG5h/INNA8BTlF5kIDTscFN5JlrUDfbgpQS/9Uo57Ffbqn76qP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:264f:b0:4c2:8e08:f579 with SMTP id
 8926c6da1cb9f-4c63f1e9e23mr360973173.2.1722266603795; Mon, 29 Jul 2024
 08:23:23 -0700 (PDT)
Date: Mon, 29 Jul 2024 08:23:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020c8d0061e647124@google.com>
Subject: [syzbot] [net?] INFO: task hung in addrconf_dad_work (5)
From: syzbot <syzbot+82ccd564344eeaa5427d@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dc1c8034e31b minmax: simplify min()/max()/clamp() implemen..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135baf03980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b0cca2f3880513d
dashboard link: https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/29a310f3ad21/disk-dc1c8034.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d35d3afb396/vmlinux-dc1c8034.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed329ce5166e/bzImage-dc1c8034.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82ccd564344eeaa5427d@syzkaller.appspotmail.com

INFO: task kworker/u8:2:35 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc1-syzkaller-00004-gdc1c8034e31b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:2    state:D stack:20272 pid:35    tgid:35    ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4194
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task dhcpcd:4884 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc1-syzkaller-00004-gdc1c8034e31b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:21632 pid:4884  tgid:4884  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f2/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa250dd6a4b
RSP: 002b:00007fff5e4c9d68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00005616070a494f RCX: 00007fa250dd6a4b
RDX: 0000000000000000 RSI: 00007fff5e4c9db0 RDI: 0000000000000010
RBP: 00007fff5e4ce8a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000010
R13: 00007fff5e4cde10 R14: 0000000000000000 R15: 0000561624964ba0
 </TASK>
INFO: task kworker/1:11:6096 blocked for more than 146 seconds.
      Not tainted 6.11.0-rc1-syzkaller-00004-gdc1c8034e31b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:11    state:D
 stack:19768 pid:6096  tgid:6096  ppid:2      flags:0x00004000
Workqueue: events linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 linkwatch_event+0xe/0x60 net/core/link_watch.c:276
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:0:9989 blocked for more than 148 seconds.
      Not tainted 6.11.0-rc1-syzkaller-00004-gdc1c8034e31b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D stack:21208 pid:9989  tgid:9989  ppid:2      flags:0x00004000
Workqueue: events switchdev_deferred_process_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor:12923 blocked for more than 149 seconds.
      Not tainted 6.11.0-rc1-syzkaller-00004-gdc1c8034e31b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D
 stack:20992 pid:12923 tgid:12923 ppid:1      flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f2/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f365877902c
RSP: 002b:00007ffd4ffb8c30 EFLAGS: 00000293
 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f3659434620 RCX: 00007f365877902c
RDX: 0000000000000020 RSI: 00007f3659434670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd4ffb8c84 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f3659434670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:13157 blocked for more than 151 seconds.
      Not tainted 6.11.0-rc1-syzkaller-00004-gdc1c8034e31b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D
 stack:19152 pid:13157 tgid:13157 ppid:1      flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 wg_set_device+0x102/0x2160 drivers/net/wireguard/netlink.c:504
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb16/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f2/0x990 net/netlink/af_netlink.c:1357


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

