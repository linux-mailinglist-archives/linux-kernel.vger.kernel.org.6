Return-Path: <linux-kernel+bounces-211915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC159058C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BF71F22B21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A708181305;
	Wed, 12 Jun 2024 16:26:28 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D99A180A69
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209586; cv=none; b=QWZgp8rKI3p8VgPV2HfMH1N4tLw9lT2gmkzMatOHwV8AGO2RquqCRhvkkyHp/vrKcgzLsvdvvRg0eijhdKAnV3cATS0MOYeBmno0VXKb3dZZ2iO4dT23WZCtAg7S8du/SIfOy7Qf2GkXPQti2dNkS+5sceuW0tUJkm3nFsh7gMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209586; c=relaxed/simple;
	bh=Xl2Qhj8wIAn+dtebmrDRsICMdSlVehfMtdSDA+aOHJE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R7W3FJxH8dbA52f8EvIYWqzwENLvNVBnqyIPJBgsNMod1+ATAo9PHWYypJUc+kOREkyImpu25/wlgqTrNmiTf60/BhGdbyv0bZj7cxooN3+4FecqyQoa16F6kTg6hjYzfY4hUcnZvv/l8NO5Sz7zEg/hXGFh3uB/UpQLmII9//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-375a1dbdd4dso22633625ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718209583; x=1718814383;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+z5tmN7A4axkxurrYHoBVfTrYUjriYxOv7wf7h/nfU=;
        b=osJMoDYiEztCTgj0TWBvqrPYFXPxeC0G1UtJ/3L0WPfPFfaANatk+7bq5JF2Xgm2vx
         YlppQ5qvAvm8rUJFpKpnzlFa04izY2JfW7gd2vlAcBme5cL1k/AlOIQFGKyLbPj+6oIs
         6nnaVKLMnMCA3NXug2/i7ampgyQRX5TDnjYxFd4nzM3suNSbUmnGI9iGvSg79qFeieX0
         mNRszYcLWpml2OpocP5nr1zXTtdibxC7EsxC0+nzcSzgCjXburlSCJKEoB6pwuq8KXb3
         Ab7XRz71G4E2/eXKQ0BSsQiOomloR4TU68Em721fLc12VuqGBDWxEAs5PLwLn0WK6hDs
         QvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoCCBxe5QUzTDtNBu9P5yspR5F9SukV7rgVvPiqUKBgm4joJzMrN9XUsDbeNmaVhycTsbAG1WNB3WXffiSEcdEr8nVApZUrDzSejXS
X-Gm-Message-State: AOJu0YxAmNnO8iHcULzBcXKTHWHuVRN8FQeDMBaSPYxqlH8w2w495NpR
	g9mgS8HYXa4vbY/ikyIIzsLgy3a4xzvVxUlieYakqNUTKwza6Ype/+aNCkWxe8CwRUyRqRjD3wt
	bn2xc/O/6VEIOICibKilYOBL2h5MlOBGEZjzt1eNXtLD48ouk2eU1jn4=
X-Google-Smtp-Source: AGHT+IHJSulJp+6RTobFegc7GqRB0HCgNKxD3BSz50f2C5iKMcXBp5IdAfYdUhyLsQlAmITstu17lCdeVdhpieoOCuuWsI1t7igu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca06:0:b0:375:ae14:145b with SMTP id
 e9e14a558f8ab-375cd1afdb7mr1445105ab.6.1718209583335; Wed, 12 Jun 2024
 09:26:23 -0700 (PDT)
Date: Wed, 12 Jun 2024 09:26:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd5b9f061ab3d7a4@google.com>
Subject: [syzbot] [usb?] INFO: task hung in uevent_show
From: syzbot <syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d35b2284e966 Add linux-next specific files for 20240607
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10b6d55a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bf5cd6bcca7343
dashboard link: https://syzkaller.appspot.com/bug?extid=edd9fe0d3a65b14588d5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10905c26980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1122da8c980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0055a00a2cb/disk-d35b2284.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/192cbb8cf833/vmlinux-d35b2284.xz
kernel image: https://storage.googleapis.com/syzbot-assets/57804c9c9319/bzImage-d35b2284.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com

INFO: task udevd:5124 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc2-next-20240607-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:24272 pid:5124  tgid:5124  ppid:4544   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5192 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1009 [inline]
 uevent_show+0x17d/0x340 drivers/base/core.c:2743
 dev_attr_show+0x55/0xc0 drivers/base/core.c:2437
 sysfs_kf_seq_show+0x331/0x4c0 fs/sysfs/file.c:59
 seq_read_iter+0x445/0xd60 fs/seq_file.c:230
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9c4/0xbd0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8d31d16b6a
RSP: 002b:00007ffd50ac7858 EFLAGS: 00000246
 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056111138c4b0 RCX: 00007f8d31d16b6a
RDX: 0000000000001000 RSI: 00005611113a1d90 RDI: 0000000000000008
RBP: 000056111138c4b0 R08: 0000000000000008 R09: 0000000000000008
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffd50ac7d38 R15: 000000000000000a
 </TASK>
INFO: task udevd:5126 blocked for more than 145 seconds.
      Not tainted 6.10.0-rc2-next-20240607-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:24864 pid:5126  tgid:5126  ppid:4544   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5192 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1009 [inline]
 uevent_show+0x17d/0x340 drivers/base/core.c:2743
 dev_attr_show+0x55/0xc0 drivers/base/core.c:2437
 sysfs_kf_seq_show+0x331/0x4c0 fs/sysfs/file.c:59
 seq_read_iter+0x445/0xd60 fs/seq_file.c:230
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9c4/0xbd0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8d31d16b6a
RSP: 002b:00007ffd50ac7858 EFLAGS: 00000246
 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056111138c4b0 RCX: 00007f8d31d16b6a
RDX: 0000000000001000 RSI: 00005611113a1d90 RDI: 0000000000000008
RBP: 000056111138c4b0 R08: 0000000000000008 R09: 0000000000000008
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffd50ac7d38 R15: 000000000000000a
 </TASK>
INFO: task udevd:5131 blocked for more than 146 seconds.
      Not tainted 6.10.0-rc2-next-20240607-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:24864 pid:5131  tgid:5131  ppid:4544   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5192 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1009 [inline]
 uevent_show+0x17d/0x340 drivers/base/core.c:2743
 dev_attr_show+0x55/0xc0 drivers/base/core.c:2437
 sysfs_kf_seq_show+0x331/0x4c0 fs/sysfs/file.c:59
 seq_read_iter+0x445/0xd60 fs/seq_file.c:230
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9c4/0xbd0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8d31d16b6a
RSP: 002b:00007ffd50ac7858 EFLAGS: 00000246
 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056111138c4b0 RCX: 00007f8d31d16b6a
RDX: 0000000000001000 RSI: 00005611113a1d90 RDI: 0000000000000008
RBP: 000056111138c4b0 R08: 0000000000000008 R09: 0000000000000008
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffd50ac7d38 R15: 000000000000000a
 </TASK>
INFO: task udevd:5145 blocked for more than 147 seconds.
      Not tainted 6.10.0-rc2-next-20240607-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:23664 pid:5145  tgid:5145  ppid:4544   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5192 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1009 [inline]
 uevent_show+0x17d/0x340 drivers/base/core.c:2743
 dev_attr_show+0x55/0xc0 drivers/base/core.c:2437
 sysfs_kf_seq_show+0x331/0x4c0 fs/sysfs/file.c:59
 seq_read_iter+0x445/0xd60 fs/seq_file.c:230
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9c4/0xbd0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8d31d16b6a
RSP: 002b:00007ffd50ac7858 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056111138c4b0 RCX: 00007f8d31d16b6a
RDX: 0000000000001000 RSI: 00005611113a1d90 RDI: 0000000000000008
RBP: 000056111138c4b0 R08: 0000000000000008 R09: 0000000000000000
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffd50ac7d38 R15: 000000000000000a
 </TASK>
INFO: task udevd:5146 blocked for more than 147 seconds.
      Not tainted 6.10.0-rc2-next-20240607-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:25808 pid:5146  tgid:5146  ppid:4544   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5192 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1009 [inline]
 uevent_show+0x17d/0x340 drivers/base/core.c:2743
 dev_attr_show+0x55/0xc0 drivers/base/core.c:2437
 sysfs_kf_seq_show+0x331/0x4c0 fs/sysfs/file.c:59
 seq_read_iter+0x445/0xd60 fs/seq_file.c:230
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9c4/0xbd0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8d31d16b6a
RSP: 002b:00007ffd50ac7858 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056111138c4b0 RCX: 00007f8d31d16b6a
RDX: 0000000000001000 RSI: 00005611113a1d90 RDI: 0000000000000008
RBP: 000056111138c4b0 R08: 0000000000000008 R09: 0000000000000020
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffd50ac7d38 R15: 000000000000000a
 </TASK>
INFO: task udevd:5154 blocked for more than 148 seconds.
      Not tainted 6.10.0-rc2-next-20240607-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:24864 pid:5154  tgid:5154  ppid:4544   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5192 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1009 [inline]
 uevent_show+0x17d/0x340 drivers/base/core.c:2743
 dev_attr_show+0x55/0xc0 drivers/base/core.c:2437
 sysfs_kf_seq_show+0x331/0x4c0 fs/sysfs/file.c:59
 seq_read_iter+0x445/0xd60 fs/seq_file.c:230
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9c4/0xbd0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8d31d16b6a
RSP: 002b:00007ffd50ac7858 EFLAGS: 00000246
 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056111138c4b0 RCX: 00007f8d31d16b6a
RDX: 0000000000001000 RSI: 00005611113a1d90 RDI: 0000000000000008
RBP: 000056111138c4b0 R08: 0000000000000008 R09: 0000000000000000
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffd50ac7d38 R15: 000000000000000a
 </TASK>

Showing all locks held in the system:
7 locks held by kworker/0:0/8:
 #0: ffff88801cae1948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff88801cae1948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc900000d7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900000d7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff888023dcf190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888023dcf190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff88802ce55190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff88802ce55190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #4: ffff88802df86160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff88802df86160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #5: ffff88802df87088 (&ictx->lock){+.+.}-{3:3}, at: imon_init_intf0 drivers/media/rc/imon.c:2236 [inline]
 #5: ffff88802df87088 (&ictx->lock){+.+.}-{3:3}, at: imon_probe+0x3ec/0x31b0 drivers/media/rc/imon.c:2437
 #6: ffffffff8f0abb28 (input_mutex){+.+.}-{3:3}, at: input_register_device+0xade/0x1090 drivers/input/input.c:2463
1 lock held by khungtaskd/30:
 #0: ffffffff8e334520 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e334520 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e334520 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6689
7 locks held by kworker/0:3/1163:
 #0: ffff88801cae1948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff88801cae1948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc90004797d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc90004797d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff888023d9f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888023d9f190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff88802e3b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff88802e3b9190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #4: ffff88802e2c1160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff88802e2c1160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #5: ffff88802e2c3088 (&ictx->lock){+.+.}-{3:3}, at: imon_init_intf0 drivers/media/rc/imon.c:2236 [inline]
 #5: ffff88802e2c3088 (&ictx->lock){+.+.}-{3:3}, at: imon_probe+0x3ec/0x31b0 drivers/media/rc/imon.c:2437
 #6: ffffffff8f0abb28 (input_mutex){+.+.}-{3:3}, at: input_register_device+0xade/0x1090 drivers/input/input.c:2463
1 lock held by acpid/4529:
 #0: ffffffff8e3398f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #0: ffffffff8e3398f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:959
1 lock held by klogd/4533:
 #0: ffff8880b943e8d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
2 locks held by getty/4845:
 #0: ffff88802a7250a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
7 locks held by kworker/0:1/5123:
 #0: ffff88801cae1948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff88801cae1948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc9000364fd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc9000364fd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff888023e37190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888023e37190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff88802d65c190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff88802d65c190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #4: ffff88802e2c2160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff88802e2c2160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #5: ffff88802e2c5088 (&ictx->lock){+.+.}-{3:3}, at: imon_init_intf0 drivers/media/rc/imon.c:2236 [inline]
 #5: ffff88802e2c5088 (&ictx->lock){+.+.}-{3:3}, at: imon_probe+0x3ec/0x31b0 drivers/media/rc/imon.c:2437
 #6: ffffffff8f0abb28 (input_mutex){+.+.}-{3:3}, at: input_register_device+0xade/0x1090 drivers/input/input.c:2463
4 locks held by udevd/5124:
 #0: ffff88801f115790 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: ffff888023ac2888 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: ffff888023d23b48 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: ffff888023d9f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888023d9f190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x17d/0x340 drivers/base/core.c:2743
7 locks held by kworker/0:2/5125:
 #0: ffff88801cae1948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff88801cae1948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc9000366fd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc9000366fd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff888023e1f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888023e1f190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff888024da8190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888024da8190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #4: ffff88802e2c7160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff88802e2c7160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1003
 #5: ffff88802d2e8088 (&ictx->lock){+.+.}-{3:3}, at: imon_init_intf0 drivers/media/rc/imon.c:2236 [inline]
 #5: ffff88802d2e8088 (&ictx->lock){+.+.}-{3:3}, at: imon_probe+0x3ec/0x31b0 drivers/media/rc/imon.c:2437
 #6: ffffffff8f0abb28 (input_mutex){+.+.}-{3:3}, at: input_register_device+0xade/0x1090 drivers/input/input.c:2463
4 locks held by udevd/5126:
 #0: ffff88802242d540 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: ffff88802df98088 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: ffff888023d490f8 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: ffff888023e37190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888023e37190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x17d/0x340 drivers/base/core.c:2743
6 locks held by kworker/0:4/5130:
 #0: ffff88801cae1948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff88801cae1948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc900036afd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900036afd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff888023ebf190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888023ebf190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff888022cab190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888022cab190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x103/0x950 drivers/usb/core/hub.c:2295
 #4: ffff88801168d160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff88801168d160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1093 [inline]
 #4: ffff88801168d160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1290
 #5: ffffffff8f0abb28 (input_mutex){+.+.}-{3:3}, at: __input_unregister_device+0x308/0x630 drivers/input/input.c:2293
4 locks held by udevd/5140:
 #0: ffff88802b704d58 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: ffff8880246cf088 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: ffff888023d3cf08 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: ffff888023e1f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888023e1f190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x17d/0x340 drivers/base/core.c:2743
4 locks held by udevd/5145:
 #0: ffff8880237598b8 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: ffff888029ff9488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: ffff888023d23b48 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: ffff888023d9f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888023d9f190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x17d/0x340 drivers/base/core.c:2743
4 locks held by udevd/5146:
 #0: ffff88801f2d28b8 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: ffff8880233cf888 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: ffff888023d30d28 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: ffff888023dcf190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888023dcf190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x17d/0x340 drivers/base/core.c:2743
4 locks held by udevd/5148:
 #0: ffff88802242d418 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: ffff88802df98488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: ffff888023d490f8 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: ffff888023e37190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888023e37190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x17d/0x340 drivers/base/core.c:2743
4 locks held by udevd/5154:
 #0: ffff88801f2d2b08 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: ffff88801b6ab488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: ffff888023d30d28 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: ffff888023dcf190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888023dcf190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x17d/0x340 drivers/base/core.c:2743
4 locks held by udevd/5155:
 #0: ffff88802d909790 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: ffff8880246cf488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: ffff888023d3cf08 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: ffff888023e1f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888023e1f190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x17d/0x340 drivers/base/core.c:2743

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc2-next-20240607-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:91 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:117
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:144
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5412 Comm: syz-executor299 Not tainted 6.10.0-rc2-next-20240607-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:PageTail include/linux/page-flags.h:284 [inline]
RIP: 0010:const_folio_flags include/linux/page-flags.h:312 [inline]
RIP: 0010:folio_test_head include/linux/page-flags.h:837 [inline]
RIP: 0010:folio_test_large include/linux/page-flags.h:858 [inline]
RIP: 0010:folio_order include/linux/mm.h:1110 [inline]
RIP: 0010:free_unref_folios+0xb3/0x1b00 mm/page_alloc.c:2666
Code: 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 51 6c 0d 00 4c 8b 3b 4d 8d 77 08 4d 89 f5 49 c1 ed 03 43 80 7c 25 00 00 <74> 08 4c 89 f7 e8 33 6c 0d 00 49 8b 06 a8 01 0f 85 76 19 00 00 0f
RSP: 0018:ffffc900037cf2e8 EFLAGS: 00000246
RAX: 1ffff920006f9eb2 RBX: ffffc900037cf590 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000000000000000c RDI: ffffed100fff7200
RBP: ffffc900037cf520 R08: dffffc0000000000 R09: 0000000000000000
R10: ffffed100fff7000 R11: fffffbfff25f92df R12: dffffc0000000000
R13: 1ffffd400014ced9 R14: ffffea0000a676c8 R15: ffffea0000a676c0
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056111152d000 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 folios_put_refs+0x76e/0x860 mm/swap.c:1020
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3395
 __mmput+0x115/0x390 kernel/fork.c:1341
 exit_mm+0x220/0x310 kernel/exit.c:565
 do_exit+0x9aa/0x28e0 kernel/exit.c:861
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 get_signal+0x16a1/0x1740 kernel/signal.c:2909
 arch_do_signal_or_restart+0x96/0x830 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8397a1d62b
Code: Unable to access opcode bytes at 0x7f8397a1d601.
RSP: 002b:00007ffd01a9d2a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007f8397a1d62b
RDX: 00007ffd01a9e320 RSI: 0000000080085502 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 0000000000000010 R09: 00302e6364755f79
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000ade66
R13: 00007ffd01a9f34c R14: 00007ffd01a9f360 R15: 00007ffd01a9f350
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.570 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

