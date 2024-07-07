Return-Path: <linux-kernel+bounces-243607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C4292985D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212341F20F02
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9982C87A;
	Sun,  7 Jul 2024 14:43:21 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6E82BCF5
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720363401; cv=none; b=kWYPDGQM0nJnaTLE5+PSSu9AOodAAS5pPIA+gFFR0TnxzJBuoDw2/C1cf/rglA5mCe6veULiukE1OH8pZzRgLnli20An+dyPatVUj+AJCniikXKT1d6n2YXwS4El9MFN3uUxuKL/c17n4oz/8yt1NQCWELlZtu5dOBkS4QYj760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720363401; c=relaxed/simple;
	bh=7j7KGSNrjRFsy3ZW44XyrY0u1nboPRJSmNDijIqvb2E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dxdLX8U7tD0YqgcYHxwuWgaObUkFQ6qA3xylLw45ejgB/P3e/cqWp1AyuIDpR+Sl/1NSQZEjHVW5i3QyiCulLku56/vLdd1CDdZIc7YXrdUjRaTbTkTcGf+8NLMi3v8056qKW4bkaqLAIwie8fVkDBOkVD1Ev7ixoDQeFVM12dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f639551768so406791539f.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 07:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720363398; x=1720968198;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1dG4nqad4PESsTrAmwiussy5msbP8NdIzbFRyO+5oA=;
        b=jBnsl8nM4skoiyd2+u1j0pGaL9IunH5HgwMrmGDbxPcsCLN4qbRK80oLXmw7AZGcQz
         6v1ugLdvp/IjXTC8ztsUeyje0MgbY+cuWfRb0wQX+efjj3+FBqxT7ka2uDn6TyT9zfoM
         HzOuc1LHprlhD5dTXNUQdtwjvMEIsLVbDjLasjiR4Sj7n0tGSLYWuYHEQHJbr4B90+mR
         Q2VYw3F8XKdohuqw6KDCzTFbqXknYTgT3nYDlazOxO9uAx/EwiqFbCLfTA8VJXK4Zm6Y
         jZ8ZR5qJR3HfpGB+0MtYAo+esYP7Xy19cq9BikD1yg14XykGglECbMlBzim1tf3GGaG5
         XmtA==
X-Forwarded-Encrypted: i=1; AJvYcCUB4BYaEMXt1tb6Ef71gNX4lnZh6oULUNiMGGt2H+Vkjd5k/w3Fg6c31iXlD3QYJIqVJgHv2veyHQ/QlFvVrXUpaPK56lfTZpJffl4x
X-Gm-Message-State: AOJu0YwkTmM0Gmd8gToc7bsLcYo5z69kpb6ymhMnjxeFs+m0f+nGcpYr
	cgnpHE4QIVAu76HQNq+iuPcT59ROCSsjvGWaHa937IRIIA7fu6lajl/4tHQl0XPpSmiTBRbvReG
	HAsrzinBze1g9a8mvs11cXHCr7A/wzE3sO/KxbIJnlGpLRphWQoTc2vo=
X-Google-Smtp-Source: AGHT+IGZsZ3PwhnP16DjjOH+83aQd/N6lFHFSBmYcy/NcuASx4xuDDNm2AsYiPiJbYTEJqkb043ldf9ydKF82LDH/vTi0kwGX8lX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1650:b0:4c0:8165:c391 with SMTP id
 8926c6da1cb9f-4c08165c540mr466800173.4.1720363398504; Sun, 07 Jul 2024
 07:43:18 -0700 (PDT)
Date: Sun, 07 Jul 2024 07:43:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040b643061ca951fe@google.com>
Subject: [syzbot] [kernel?] possible deadlock in assign_fw
From: syzbot <syzbot+e70e4c6f6eee43357ba7@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, rafael@kernel.org, russ.weight@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e9d22f7a6655 Merge tag 'linux_kselftest-fixes-6.10-rc7' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1471b399980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=864caee5f78cab51
dashboard link: https://syzkaller.appspot.com/bug?extid=e70e4c6f6eee43357ba7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c3dd72a93425/disk-e9d22f7a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d79986da9dc/vmlinux-e9d22f7a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0df271bec574/bzImage-e9d22f7a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e70e4c6f6eee43357ba7@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000006e R14: 00007f30c0504038 R15: 00007f30c062fa68
 </TASK>
============================================
WARNING: possible recursive locking detected
6.10.0-rc6-syzkaller-00061-ge9d22f7a6655 #0 Not tainted
--------------------------------------------
syz.1.2110/15436 is trying to acquire lock:
ffffffff8ec73968 (fw_lock){+.+.}-{3:3}, at: assign_fw+0x56/0x890 drivers/base/firmware_loader/main.c:700

but task is already holding lock:
ffffffff8ec73968 (fw_lock){+.+.}-{3:3}, at: device_cache_fw_images drivers/base/firmware_loader/main.c:1483 [inline]
ffffffff8ec73968 (fw_lock){+.+.}-{3:3}, at: fw_pm_notify+0x232/0x2f0 drivers/base/firmware_loader/main.c:1536

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(fw_lock);
  lock(fw_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz.1.2110/15436:
 #0: ffffffff8eb2f6e8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
 #1: ffffffff8e1e7368 (system_transition_mutex){+.+.}-{3:3}, at: lock_system_sleep+0x60/0xa0 kernel/power/main.c:56
 #2: ffffffff8e2077f0 ((pm_chain_head).rwsem){++++}-{3:3}, at: blocking_notifier_call_chain_robust+0xac/0x1e0 kernel/notifier.c:352
 #3: ffffffff8ec73968 (fw_lock){+.+.}-{3:3}, at: device_cache_fw_images drivers/base/firmware_loader/main.c:1483 [inline]
 #3: ffffffff8ec73968 (fw_lock){+.+.}-{3:3}, at: fw_pm_notify+0x232/0x2f0 drivers/base/firmware_loader/main.c:1536
 #4: ffffffff8ec6ea08 (dpm_list_mtx){+.+.}-{3:3}, at: device_pm_lock drivers/base/power/main.c:113 [inline]
 #4: ffffffff8ec6ea08 (dpm_list_mtx){+.+.}-{3:3}, at: dpm_for_each_dev+0x2b/0xc0 drivers/base/power/main.c:1961

stack backtrace:
CPU: 0 PID: 15436 Comm: syz.1.2110 Not tainted 6.10.0-rc6-syzkaller-00061-ge9d22f7a6655 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 assign_fw+0x56/0x890 drivers/base/firmware_loader/main.c:700
 _request_firmware+0xd0a/0x12b0 drivers/base/firmware_loader/main.c:917
 request_firmware drivers/base/firmware_loader/main.c:963 [inline]
 cache_firmware drivers/base/firmware_loader/main.c:1265 [inline]
 __async_dev_cache_fw_image+0xe7/0x320 drivers/base/firmware_loader/main.c:1379
 async_schedule_node_domain+0xdc/0x110 kernel/async.c:221
 async_schedule_domain include/linux/async.h:72 [inline]
 dev_cache_fw_image+0x36d/0x3e0 drivers/base/firmware_loader/main.c:1435
 dpm_for_each_dev+0x58/0xc0 drivers/base/power/main.c:1963
 device_cache_fw_images drivers/base/firmware_loader/main.c:1485 [inline]
 fw_pm_notify+0x24a/0x2f0 drivers/base/firmware_loader/main.c:1536
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 notifier_call_chain_robust kernel/notifier.c:128 [inline]
 blocking_notifier_call_chain_robust+0xe8/0x1e0 kernel/notifier.c:353
 pm_notifier_call_chain_robust+0x2c/0x60 kernel/power/main.c:102
 snapshot_open+0x1a1/0x280 kernel/power/user.c:77
 misc_open+0x313/0x390 drivers/char/misc.c:165
 chrdev_open+0x5b0/0x630 fs/char_dev.c:414
 do_dentry_open+0x970/0x1450 fs/open.c:955
 vfs_open+0x3e/0x330 fs/open.c:1086
 do_open fs/namei.c:3654 [inline]
 path_openat+0x2c01/0x35f0 fs/namei.c:3813
 do_filp_open+0x235/0x490 fs/namei.c:3840
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1413
 do_sys_open fs/open.c:1428 [inline]
 __do_sys_openat fs/open.c:1444 [inline]
 __se_sys_openat fs/open.c:1439 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1439
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f30c0375bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f30c1120048 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f30c0504038 RCX: 00007f30c0375bd9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007f30c11200a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000006e R14: 00007f30c0504038 R15: 00007f30c062fa68
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

