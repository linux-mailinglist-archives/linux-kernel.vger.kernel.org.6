Return-Path: <linux-kernel+bounces-226275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C713913C59
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB1A283440
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7011822C3;
	Sun, 23 Jun 2024 15:29:27 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74413146A7D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156566; cv=none; b=mQY3TfE3TVu1qXzN00TunKC9xrZRsvkqy8uv7I3tmDWlbXiYL9CGrZ6yxs9hL2ELqwRSZZueZKZO+PYOg1V/rjI83YsdDR1ctJAF3JN8eGvcaD+LKneLXT5D/kMXJevLtJZv4en87RP2Np+kCuUerqtj7++ZYopFy0kdyf0NYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156566; c=relaxed/simple;
	bh=5GzQNXCfF8EdbfC3H4E9VS+tvgTWS1crHKs96+wLw5I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ro0hnM4ptuPgCLMbcH2xYiAtmt9XCLGocKQu3wBX+UbR3EfVJi4HLk3jtC7jpyVdQTltqz5gxnsusNPu1ujB8YmcYJmF46v8gCpEtSIxk1mpE2Jx1laFuURIYyYtn+IcU67jE6Adq3h2K2Z1yh2HBX4rCSpBloiRVeaBDuYe6E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-37624b11960so34865255ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719156564; x=1719761364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EP0r5vjIqTOj5wt9p5RxoVOv4/EypeRrWumP8Iu8xTU=;
        b=LUhd38FFRHLKqvRy8QlkfGv91L7nOIl9UxwwJmOfeVEHJBs1jZ2f8YayGu/N4LnEcf
         KkdxE7j06pU67sruED0kB4mqJ2B9YCQEhVesVCIlFzSDVO0q28HP0/osIn4dAtjv+nTr
         /T3vLtfTU/Nw0l8yKP+pmYozY7qSZQXft+J6N2nwNBMPxneIKSNuyPJS3Ee4Oy36kmRW
         JhCSyoxgQ+RVlPMUAxLe+ukuOF08H/sCXgA67BktPOP4S7U8Vc1hTvU4Uxe4LZjoXbjr
         rQIdayoO2iA2o7nwOHBlgxWdfsTQXkhZMMd2H6yjH+lVYudq25azld+BB5KLHOlRG9Xy
         /1Lg==
X-Forwarded-Encrypted: i=1; AJvYcCX6IuI4pARdZwb2BVD/d2N06NzgXt1+oLpR3umIXDo7dZroFa4mQg+6txYEN/OVfZvEvs/d8XpRUBAwyeLK7FPrWLtNtz3K9TbKIHca
X-Gm-Message-State: AOJu0YxypPUofS/7/IGCdDR/4YshxhO9x6gKcy/sS/rZG/galNaqICEz
	nVKH5z/RcxncNtvQ3OwAyvY/lPMCr+WJUN8negOQsBa9Lh1xJKW8qLezyw42BRHHh2jy1FYZHuM
	p7/bzSYr1LBddGOymxFVndr19y6ZMnUBcF1R4R0TeMupd4dnXd5ERe/A=
X-Google-Smtp-Source: AGHT+IFqnPdpAhkaCMlzEMZuVA/C2S6JDfh8pY3BlYKXaqSV5TpYTSaMd5hwBP7t8YgYtHTf5gVQGwAtwWvzgO6DJ3GECpny+vp9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:0:b0:36c:4b17:e05d with SMTP id
 e9e14a558f8ab-3763e16d8a6mr3431835ab.4.1719156564589; Sun, 23 Jun 2024
 08:29:24 -0700 (PDT)
Date: Sun, 23 Jun 2024 08:29:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000589156061b90544f@google.com>
Subject: [syzbot] [can?] INFO: task hung in cangw_pernet_exit_batch (3)
From: syzbot <syzbot+21ad8c05e3792b6ffd14@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, mkl@pengutronix.de, 
	netdev@vger.kernel.org, pabeni@redhat.com, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16dd1f2e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=21ad8c05e3792b6ffd14
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/27e64d7472ce/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1c494bb5c9c/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/752498985a5e/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+21ad8c05e3792b6ffd14@syzkaller.appspotmail.com

INFO: task kworker/u8:1:12 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:1    state:D stack:18160 pid:12    tgid:12    ppid:2      flags:0x00004000
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
 cangw_pernet_exit_batch+0x20/0x90 net/can/gw.c:1257
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x89f/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:6:5181 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:20976 pid:5181  tgid:5181  ppid:2      flags:0x00004000
Workqueue: events_power_efficient crda_timeout_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4


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

