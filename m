Return-Path: <linux-kernel+bounces-356803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B387A9966EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD7BB24467
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA0018E754;
	Wed,  9 Oct 2024 10:20:25 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19215382F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469225; cv=none; b=ieBD9a+KtEbsF9jiCkjRH4pAhwNTWK3SLvzrzcz6gIyIcoDMgQ4ctSWK61o1xqwNO9Lr11N+L5AtX8m1II4GLJXWf/eXvJo++khWGNMbfbucoT3QomHdncrPNloWTygF80fMAFvU+S2T1TPQE8ZNiY2R3j/Obm/YZouEEH3o6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469225; c=relaxed/simple;
	bh=qK4KQaIt3lrNwLlYXxWRnQeo7+2COMKtaUQGshtOGZg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WNKgNgdOxY4b92ovOI5sLX+yyKO4jFi/69l+j3rZvFqLgi9Z3YPUIkZIHdPZTLXc/AEoBhl/5zHs96Dty+PsAqfm1LzACAZyWymO1duksjrknt7iBqWCn1HNGarVn7x2bxFjLbkjhUoTor622q7d3ziX6G/H8pxfBUTiwE36Po4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0ce7e621aso59966405ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 03:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728469223; x=1729074023;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msJj4GiB8/jRjpLDDXAICgBBp9XCST7mD/0ou7XdrLU=;
        b=vwzx7NOKQyrHh9zvhrLJr+czou7gzTYABm12Bk4Sy3Cl0sZ3DZ8PCb7+CUXbXxO+J0
         DA8UJ6Ayqb0wrt9Ypb23dtxRLE4TKoSP6yHX8/TH0EWVh+UwIJuGTi/mf4usAFTujbAl
         zrmCLhdB2u7ac2sXR/ngJM+y3WYeY9G4M/Xr+pP/REVPnaHhNJuivAmd+g/k9enecXkD
         n+2C/wmCJ3LyqpCv/9gP918iHJLZ6DRuZfuK34WsH2YkzWlVzZtRTFsb8SthJHqP8RBa
         VLUUul7qhE1VMc3HSzdPv6fyXvs0C3rU7uWB+gJW6bqfwc+FVMZ5J/R86+4cTU9F0HUc
         VATQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJHYJdxxxuaUrLzZ1spa0ISWT9YAZucOMJ5LV9Q7iGD3FRId5ZE41aOjNamL34vuDHZG/5pGi3Wo6ELPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8TzeTMAVwSZPbtKROIETHzdXCl8x+2YcmlFm5qrjOlsOskf6e
	W+NanB2fWtn0ys8FEulEGsQldDAmVd03o6nWBTjxlXs3rSX81p4KSpw5bPe/Jx6AqeS/g0GtzOe
	B3dJ0nDpUQIONMDq84I0n6yHGXFWt9RwXIqGrqZe+QOGjvmVYwNrb2Ok=
X-Google-Smtp-Source: AGHT+IHzuK32eKNDgGIe5IK0Pc7jlPryOsh91ka5RJTr7nA7zaFq5OmjVp1xf3Jbyg2dod17W8Ca6DzvkMidbEzMcsDAFd9Gb9fU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:3a0:9244:191d with SMTP id
 e9e14a558f8ab-3a397d10ce2mr16425715ab.16.1728469223017; Wed, 09 Oct 2024
 03:20:23 -0700 (PDT)
Date: Wed, 09 Oct 2024 03:20:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670658e6.050a0220.22840d.0012.GAE@google.com>
Subject: [syzbot] [kernfs?] INFO: task hung in fdget_pos
From: syzbot <syzbot+0ee1ef35cf7e70ce55d7@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc20a3e57247 Merge tag 'for-linus-6.12a-rc2-tag' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110fb307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9775e9a1af839423
dashboard link: https://syzkaller.appspot.com/bug?extid=0ee1ef35cf7e70ce55d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0a79f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64ef5d6cfda3/disk-fc20a3e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/42c0ee676795/vmlinux-fc20a3e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a3072d6383ea/bzImage-fc20a3e5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a8f928c45431/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ee1ef35cf7e70ce55d7@syzkaller.appspotmail.com

INFO: task syz.2.17:5434 blocked for more than 159 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00330-gfc20a3e57247 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.17        state:D stack:27424 pid:5434  tgid:5432  ppid:5316   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 fdget_pos+0x24e/0x320 fs/file.c:1160
 ksys_read+0x7e/0x2b0 fs/read_write.c:703
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f993c77dff9
RSP: 002b:00007f993d54e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f993c936058 RCX: 00007f993c77dff9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f993c7f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f993c936058 R15: 00007fffb8436518
 </TASK>
INFO: task syz.3.18:5439 blocked for more than 167 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00330-gfc20a3e57247 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.18        state:D stack:27424 pid:5439  tgid:5436  ppid:5317   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 fdget_pos+0x24e/0x320 fs/file.c:1160
 ksys_read+0x7e/0x2b0 fs/read_write.c:703
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1134d7dff9
RSP: 002b:00007f1135adc038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f1134f36058 RCX: 00007f1134d7dff9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f1134df0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f1134f36058 R15: 00007ffe6e122188
 </TASK>
INFO: task syz.4.19:5441 blocked for more than 168 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00330-gfc20a3e57247 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.19        state:D stack:27424 pid:5441  tgid:5438  ppid:5327   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 fdget_pos+0x24e/0x320 fs/file.c:1160
 ksys_read+0x7e/0x2b0 fs/read_write.c:703
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4c9ad7dff9
RSP: 002b:00007f4c9bc43038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000


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

