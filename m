Return-Path: <linux-kernel+bounces-204597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74E8FF10B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8016228DDCA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA1919755C;
	Thu,  6 Jun 2024 15:45:29 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0318F196DB0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688728; cv=none; b=TBx5pdUw1m3ghKUcqz3rmIKYktHCRstjgjnG7/BRV2weuZh9ATXKB6Z4mpSOaNquKYxoehwnMJZwJ8rlMBwJyUeLjfWCXZ2i4L7R+UU2rG6c9u/nJDX/M9IClN+fQZekWy0hORvaiPNhmz5RT8DgJEAUnmaPz6VzvDxEZZCaRsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688728; c=relaxed/simple;
	bh=cS+w42K47jFJAEppSvASxFbtW1NbsLYSF4kln3BjWkU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tG8OnmSAfmzbYXqXdoRItkXU4+e+W7m0kQUK1myn2DgiESn47Xwbk7agvM/DnjZa2EEmlpGoxpSPSWtOce4rL4ymHd+slZlTP5jshhrWyiNuo+gnNyEjzjNYDNe2tFX90KZnI3aPrX4sVTDbr5ZpTOEkuMrpMUvZEO8dGyAy7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3737b3ee909so10683375ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688726; x=1718293526;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcJjBcQjsiomLxADg06X2dHReObIPOPPMgQFtADOjIQ=;
        b=HLvgDCcWDgNEii7sT0ElYSgwwEwqQ+1c/RTUjmjDvSIwgmpF5ulMM51/kxKoiq9yf/
         Pjx91tCOgG/Z4wq7KLesjNMinvsbdh0DmzBsUdyMDVlYdCuRDbF2eRToXWEFxU7IfIEu
         cg7i0HP7E7t2iWmt2BjdRXNzbLyBFuS72vccboEJjcQf//nVJ3SijFPkyZi37Pk+q1Tk
         jIuviYsdINYKTOUIvw3rd4SJMAdyNK9I7UM4URxQi46AUuBWTRM1f4gm8OnZde3iJtNu
         6ZFAToBqZsoGKh6gkuCYSB+irSvOZli+HXHCOEVM2Ueqy6dPLFCsjH+780W0gd2Wcjl6
         /g2A==
X-Forwarded-Encrypted: i=1; AJvYcCWl2Vd+MAHRMbWIweERIeJP0LDJxUCnpI8g4cstw/E3GLhpyh+PZghDqQJEH+e5t4WMfY+PiLPKZQMaOePgTskDwr50qZUls6vprpAL
X-Gm-Message-State: AOJu0YybM7dFeOLWAeOrPLd4AhmHDLE8rDUpmB7J1QIkhOD6Io2Uv7nF
	41KB3wDA7riSQ+JU9NJsgUj/i2KLTUuv5MhYp9oBEAZwxPsIFecfO58gScm+dS82L+VfDtNl6s9
	Vba3YLmoCXvuUl907t4qZvCU/rH5CQ2nfS1oJuCBcVjs/ricDEmeHbTs=
X-Google-Smtp-Source: AGHT+IEG+fp/6y3Je1YYAE9GzZIqKcEY+J2VkjnePlKVW2lAraFrdhU88X70CABdD4Jwqv0+4+blEtYRq/jy3INZR1RpATw9DHiO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda4:0:b0:374:5a8c:c011 with SMTP id
 e9e14a558f8ab-375803c3a16mr50445ab.4.1717688726325; Thu, 06 Jun 2024 08:45:26
 -0700 (PDT)
Date: Thu, 06 Jun 2024 08:45:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e23a3061a3a92b6@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in wiphy_unregister (2)
From: syzbot <syzbot+abba31ed4fc4178349e9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ab795141095 Merge tag 'cxl-fixes-6.10-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1671b2f2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0e2e3f7ede77526
dashboard link: https://syzkaller.appspot.com/bug?extid=abba31ed4fc4178349e9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/613f40485ad9/disk-2ab79514.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f6673b48420/vmlinux-2ab79514.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9659affc7dfc/bzImage-2ab79514.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+abba31ed4fc4178349e9@syzkaller.appspotmail.com

INFO: task kworker/u8:2:35 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc2-syzkaller-00010-g2ab795141095 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:2    state:D stack:23032 pid:35    tgid:35    ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 wiphy_unregister+0x236/0xaa0 net/wireless/core.c:1096
 ieee80211_unregister_hw+0x1e2/0x2c0 net/mac80211/main.c:1675
 mac80211_hwsim_del_radio+0x2c2/0x4c0 drivers/net/wireless/virtual/mac80211_hwsim.c:5576
 hwsim_exit_net+0x5c1/0x670 drivers/net/wireless/virtual/mac80211_hwsim.c:6453
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x804/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task dhcpcd:4754 blocked for more than 144 seconds.
      Not tainted 6.10.0-rc2-syzkaller-00010-g2ab795141095 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:20384 pid:4754  tgid:4754  ppid:4753   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 devinet_ioctl+0x2ce/0x1bc0 net/ipv4/devinet.c:1101
 inet_ioctl+0x3d7/0x4f0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0x15a/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f49d5ed49
RSP: 002b:00007ffe50118268 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2f49c906c0 RCX: 00007f2f49d5ed49
RDX: 00007ffe50128458 RSI: 0000000000008914 RDI: 0000000000000011
RBP: 00007ffe50138618 R08: 00007ffe50128418 R09: 00007ffe501283c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe50128458 R14: 0000000000000028 R15: 0000000000008914
 </TASK>
INFO: task kworker/0:7:5217 blocked for more than 144 seconds.
      Not tainted 6.10.0-rc2-syzkaller-00010-g2ab795141095 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:7     state:D stack:19376 pid:5217 


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

