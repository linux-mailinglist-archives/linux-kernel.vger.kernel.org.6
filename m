Return-Path: <linux-kernel+bounces-425663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E439DE8A9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CFBB22E21
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7314413AA26;
	Fri, 29 Nov 2024 14:38:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8683CD2
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732891110; cv=none; b=fYegUjwIj820qso3D7MV+41h4fKFWuS+JEeNdCVrNOMsWNoZdbT9bE25LwHet0r0Crlr8ttSstc9oy6Ggy/ifBtDEvrx7bGr+SkK6445NqsFlk24nH/5EvUyuKghYz+7Q1Amt+U4r8ykjHs7Dwx4L2glFywYu8/q0Oq+OrT9y9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732891110; c=relaxed/simple;
	bh=e5WsLUQCwSDH4xtec1PFjmZz3cCHWEcQCr8SycRCRE8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pF7a801mktjB4xUAWcVNESvcXNe3dPd4TQhciJTgE+o9eS0iz97Ntvmfu+35OH8B+JZJAEmiTsvNI6FR+aoLj5oWpjDNXbw0yWLm/duYpIGdQr8hYBcXrVqDOYsIm+i2t5zMZdj8+ihfTEnNiDdM89eKUaVzD+6qacXw8CyKAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a78589df29so19503625ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 06:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732891106; x=1733495906;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hj1U9eHo0e7boFaocjYSwnKXwMIgB6QaxAEj/QMXq4E=;
        b=igaZWZodROLfrBzIeEIvKoFI4Dy5/0awqgL50M7XWFaHIXOxWfmUUb2E2sCQwDz5Wv
         S8FI0LQiqFn7JYze3b+SawECByU7dGKVchgKTR1LOyeOiINSn0sGQm0QdaKy97uXoSmM
         UorSMK662Vd3ShWWryMMmrQ+fwMZkfABoQdZtmpvYaiE1Tz7T/E1VWxB2J8lY7q+EaoD
         3ijxs2//zYvjnKkRaMFeZ3JdEOHVzC2ipRnkhRHD1H+ewY+FmCzVsv9N43hH+uxwtwT5
         lsoe04treewJYwAeqUQ2pvhFL5+GxvjfODzrm+EWOfguUtOI3oF/ctMFu6Uck2cGU2T6
         4Abw==
X-Forwarded-Encrypted: i=1; AJvYcCXXsxrquvG1TnXQmKJ1/5uSy7fH9lDlPP0TjnDkypKAXCDvsVH2ppaJ20XMf2EO+XI/lPViHWpwwYa+muo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyonNKhty/7QTfhE3i587hXpIzv3rMBvYeXh9/FD/n7FWKxjgT0
	RDPDQ9mhuaL5TVneP7N3z1h3lSZ0xEMdpCnYWjSrRd/ynLspydP4RaMDfo2AWjKHhBO6sNmj5yO
	RSv6BitwnhxjQIXEBaTV4TIFJZlVMjg1Ci0cwKgSydvFmebi3/lWccek=
X-Google-Smtp-Source: AGHT+IHWo+2QBobSBb2opTRxIDyO/gK9uM+5+itaXZKJjprlXAL5ylCym9Mk9HwBy2d1plZ5mhD16A7O14azdhmyDuJ3cJD/BNHc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:3a7:78bd:e486 with SMTP id
 e9e14a558f8ab-3a7c552405fmr126764205ab.5.1732891106537; Fri, 29 Nov 2024
 06:38:26 -0800 (PST)
Date: Fri, 29 Nov 2024 06:38:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6749d1e2.050a0220.253251.00b7.GAE@google.com>
Subject: [syzbot] [kernel?] KCSAN: data-race in kick_pool / wq_worker_running
From: syzbot <syzbot+f8761b2f358f6a1dec5e@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7af08b57bcb9 Merge tag 'trace-v6.13-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a39f5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77174711582263a3
dashboard link: https://syzkaller.appspot.com/bug?extid=f8761b2f358f6a1dec5e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/13ed5c4111d5/disk-7af08b57.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b14531c093bd/vmlinux-7af08b57.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0ddfac565b6b/bzImage-7af08b57.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8761b2f358f6a1dec5e@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in kick_pool / wq_worker_running

read-write to 0xffff888237d2e8a4 of 4 bytes by task 3377 on cpu 1:
 wq_worker_running+0x98/0x130 kernel/workqueue.c:1400
 schedule_timeout+0xb8/0x160 kernel/time/sleep_timeout.c:99
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common+0xfb/0x1c0 kernel/sched/completion.c:127
 usb_start_wait_urb+0xdc/0x190 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
 usb_control_msg+0x182/0x240 drivers/usb/core/message.c:154
 get_port_status drivers/usb/core/hub.c:604 [inline]
 hub_ext_port_status+0xbf/0x480 drivers/usb/core/hub.c:621
 usb_hub_port_status drivers/usb/core/hub.c:671 [inline]
 port_event drivers/usb/core/hub.c:5714 [inline]
 hub_event+0x538/0x2910 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3310
 worker_thread+0x51d/0x6f0 kernel/workqueue.c:3391
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

read to 0xffff888237d2e8a4 of 4 bytes by task 3399 on cpu 0:
 need_more_worker kernel/workqueue.c:934 [inline]
 kick_pool+0x4d/0x2c0 kernel/workqueue.c:1240
 __queue_work+0x8bb/0xb40 kernel/workqueue.c:2340
 queue_work_on+0xd3/0x180 kernel/workqueue.c:2390
 wg_queue_enqueue_per_peer_tx+0x124/0x260 drivers/net/wireguard/queueing.h:188
 wg_packet_encrypt_worker+0xa00/0xbb0 drivers/net/wireguard/send.c:305
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3310
 worker_thread+0x51d/0x6f0 kernel/workqueue.c:3391
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

value changed: 0x00000000 -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3399 Comm: kworker/0:4 Not tainted 6.12.0-syzkaller-10689-g7af08b57bcb9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: wg-crypt-wg1 wg_packet_encrypt_worker
==================================================================


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

