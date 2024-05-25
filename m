Return-Path: <linux-kernel+bounces-189547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CFA8CF17A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAF428174B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 21:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235A712838A;
	Sat, 25 May 2024 21:52:28 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0A86621
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716673947; cv=none; b=WntRAst1jXzTI9WsLaAQ9WIq9Oz7OjdaOIDzZGwndwCPu7Lb1AIO2JBpFoqr/H8wyQSfT7+JjcFSA7L/jhtwXJ8Gmh2dsovCDW91Pb2OBpOgsq5zbYCZLfnNTlCwfCSgJzB/8ARO5RbDHDeCzvtBfpbpHkCelsfyQ81lGhlmOXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716673947; c=relaxed/simple;
	bh=CLyxtdNpcyogzyl+g5m5bWPA6gdn3KKG4D49RMTfkxc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CL9JSpl2kpnnxPU4TC9v6cAgeXYSdrXXJC7OUoG10iyKoeG/Xfj8e/EEdiXU0wO+9taLz+otqOng8l6UjzlSSED9gkzJJJUuxnowwwWwybSc3M+uBVqQyv+IxXKtICVdjlop6jDB10UImy8zLROC9wOEY5RLz4Cq9o/ISrBHSGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e8e2ea7b4bso275314839f.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 14:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716673945; x=1717278745;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqJhjMCKzznIWTWoDPHhOTRHgAuIblANQW6X9sHID+k=;
        b=LCrZc0WU0PyFvC0MSrvvTJLlro+WmK9q5+2IRCZhMbmkgVMN1oeIz4wzDhseFnLGvQ
         S/s5TnyZLp8OQ+KkKeguGyt1USC4ww5230zrZEQVsX5kn/RZgO0KkzZEkR6uZDL4Nf9B
         1WeI+YXcxKX7u6MNkaNN1oSABivnPSwel/phynKotbB08nEq4dXtndJPvmkvBZ412HcX
         Q6DqS47gdA2BKJdNceYLLrelL+e8sfXzBRb//zShQ58D8F1jGtYh/hecdDW2VDK/TbAL
         tdj3g9C9E+HOPI6W+f5rvZ0UelpYQz3S1zE8fIhjW8fJeb7oJE1mXMXq8AMKVQBwzuXb
         F6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvZfciL2n+Q3Id8e/v5ur3FzgWFXtrvYyqo/m6X4hTuv5l45D/w2E4PS5KDAUDMoYYIC9nfaEbSZfF6lDo05yjhP7jL8z0WzZz3gq/
X-Gm-Message-State: AOJu0Ywd4g6gKMF3dlI3Dmwc9umpkwsoFbz82wm5wjBUJ/VEOMFfO02n
	f+P7S3rGHOi/dpyRya1+gmtTtAS6bXszG95fDjP+w9NB9x8HflDlzYYD1ujTRGtkpHBi1i/YBt7
	e5LxpHehh0NNNoIwvLVT0CeBotvEiDFjH8NHR7rMSZZXJP70/Byefbak=
X-Google-Smtp-Source: AGHT+IF/uwKTCacGAd0CJH/WLtT+Z/9DJ+wcOCZOzbaYQ1cx9ToolQMWVL6ZnA1f/XHwYMzYKjYyFpoIfR45fQmjfAMd2QxObOgo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a8:b0:488:77ea:f194 with SMTP id
 8926c6da1cb9f-4b03fbb8dc1mr281069173.5.1716673945305; Sat, 25 May 2024
 14:52:25 -0700 (PDT)
Date: Sat, 25 May 2024 14:52:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4935a06194e4cc7@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in collect_percpu_times
From: syzbot <syzbot+97f26f162079653e77b8@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2a8120d7b482 Merge tag 's390-6.10-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145dd452980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5dd4fde1337a9e18
dashboard link: https://syzkaller.appspot.com/bug?extid=97f26f162079653e77b8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2a8120d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78c72ae6bdaf/vmlinux-2a8120d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99dbb805b738/bzImage-2a8120d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97f26f162079653e77b8@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "->pcpu, cpu)->seq" with key __key.9, but found a different class "&per_cpu_ptr(group->pcpu, cpu)->seq" with the same key
WARNING: CPU: 3 PID: 57 at kernel/locking/lockdep.c:932 look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Modules linked in:
CPU: 3 PID: 57 Comm: kworker/3:1 Not tainted 6.9.0-syzkaller-10713-g2a8120d7b482 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events psi_avgs_work
RIP: 0010:look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Code: c7 c7 a0 b5 2c 8b e8 3c d2 72 f6 90 0f 0b 90 90 90 31 db eb be c6 05 43 e6 ed 04 01 90 48 c7 c7 c0 b8 2c 8b e8 1e d2 72 f6 90 <0f> 0b 90 90 e9 62 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90
RSP: 0000:ffffc9000077f6f8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffffff94205020 RCX: ffffffff81510229
RDX: ffff888019080000 RSI: ffffffff81510236 RDI: 0000000000000001
RBP: ffffffff92e32ba0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 20676e696b6f6f4c R12: ffffe8ffad14b848
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff94adaba0
FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000ee176000 CR3: 0000000026c9c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0xb1/0x1230 kernel/locking/lockdep.c:1284
 __lock_acquire+0x111/0x3b30 kernel/locking/lockdep.c:5014
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
 get_recent_times kernel/sched/psi.c:261 [inline]
 collect_percpu_times+0x6cf/0xb70 kernel/sched/psi.c:359
 psi_avgs_work+0x9c/0x210 kernel/sched/psi.c:566
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

