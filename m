Return-Path: <linux-kernel+bounces-212908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DFC90680D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241011C24865
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2A913D88E;
	Thu, 13 Jun 2024 09:01:29 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0513C9D5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269288; cv=none; b=beq6JCHBcA6H0rgEmUDQozGq4YDyR0Y6f4GHC9SAqkOyr1QnzYagFBDgSVoDxZFrZIv6lzVBKJ+e0EplWRuD1gK3avo+kw6YrxPQdonWrWvPb9Q1bKd91bJtAoWtp2U0IM+BYrRyMWn+AO68PT+ypQrwUMkz6uJpYt3MpcTeRNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269288; c=relaxed/simple;
	bh=zDQfReszuaU0SBuUkzOBkGk0heHhS+XHS45L0W88biY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P4aNlCuQj6oi0XvzzU+ZvWv1pi5z4FQWfC13Tt6Do9Jl/Q3B0QkCwX/Xz1homtz3LJMgK316B/rEUvvnZftuj32j6BLkNz2WvdBog8KQeYxqhd7A672AYPkW4Bw8jXDFonEAtCZBiv2OFUJEqVbvYA+evIijXrCGI9T+c0MwCNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7ebd7c57a35so89611039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718269286; x=1718874086;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJ0P9PPpSPipQKnsMFKPK1AUyVT5U3lPgM2J/2QP/Wo=;
        b=D9gCmKGwmGv+vSIrExs4bxwdGPOj+db5dVsuR6neZ5r6gQIjhnSYU0yhusQru/BpsR
         6O1C7FmkfgGEC6U0N52MrG6iJvb9RlUuDiNn59sP75vwdyG2vjzlPvKqhLBy9891egnS
         oyfOjAD8H9NgQWrDrY1yedL0v4HOKZVFALP6LMWk7gSK2dsS6NVHipztNneDTorkALnL
         52KR8Ofxa6JxKMpB2zmJi1Z/Az3Uqgeba2qHP4To6FXzq5iWRkeWXRjm9n/uO6PsH8I4
         Ib/ExdHFohMAzaZTuI1N9vBBZ2/tAg1VGI6R6IyYQbwB6cXGXUXovhOcKr5kV3xlMBKC
         8ypw==
X-Forwarded-Encrypted: i=1; AJvYcCUNOY1BEeNnX+qDPe7y/JBr1ZctMyXcCGBeMhPK5mcpUnYpuMaR31pHJbV6RyZWbA2Juu7zPALWr2qcU98yN+zc3YRxr3m3UMdVLp7l
X-Gm-Message-State: AOJu0YzZq/4/s/s9Q6mjHX7ye2j7JRF90De5XDWjRnYZCfY79SgarQO9
	8Ltd2ksThnUGHj7R8cGH2N4t7qwAbQf73LapxxHUkRge3K7NoYwPqY3efLl7g26JRtz7xidtxF2
	/b36KRAiRi7swX1e5TSQcmWT11TOHxFHU+NBFa05CL4TCfX4PwXO0C4g=
X-Google-Smtp-Source: AGHT+IHBwQ1lxfk63ByiZP5u96AF5hted6fq87tFuZWyeJs+2VhWvmsFkrTunSQyNOZ6wgL9HKIt207hEibfABtpJQCaKXT89wYc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25c3:b0:488:e34a:5f76 with SMTP id
 8926c6da1cb9f-4b93ec0ef35mr294959173.1.1718269286392; Thu, 13 Jun 2024
 02:01:26 -0700 (PDT)
Date: Thu, 13 Jun 2024 02:01:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071b6ee061ac1be53@google.com>
Subject: [syzbot] [net?] INFO: task hung in mpls_net_exit (2)
From: syzbot <syzbot+a8b8d28a9e1a02270f42@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    83a7eefedc9b Linux 6.10-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a2c82e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
dashboard link: https://syzkaller.appspot.com/bug?extid=a8b8d28a9e1a02270f42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e8762812d56/disk-83a7eefe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29ef4962890d/vmlinux-83a7eefe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1a5e4d91d135/bzImage-83a7eefe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a8b8d28a9e1a02270f42@syzkaller.appspotmail.com

INFO: task kworker/u8:11:2895 blocked for more than 144 seconds.
      Not tainted 6.10.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:11   state:D stack:22712 pid:2895  tgid:2895  ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 mpls_net_exit+0x7d/0x2a0 net/mpls/af_mpls.c:2708
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:3:5107 blocked for more than 144 seconds.
      Not tainted 6.10.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:21912 pid:5107  tgid:5107  ppid:2      flags:0x00004000
Workqueue: events linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 linkwatch_event+0xe/0x60 net/core/link_watch.c:276
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244


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

