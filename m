Return-Path: <linux-kernel+bounces-307978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B76E09655D4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49378283903
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207B13DDA3;
	Fri, 30 Aug 2024 03:43:22 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D808567F
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724989402; cv=none; b=KNBxWwGevgIR1+SWsm7Aiqd3bJ4hZPlcM+b5V8luAvcwfLI3ktB2cN14n5EqdvAV+eTNV69MiuJiD4UwSYu8jXVP5Kh1W7M1LOYn8aW4EHWbCVFgYGtZoaJa8aSOXNLXBkZcozHI9bbtGW7H5NuZkk7IL6vLrXOWrsSMTK1GJzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724989402; c=relaxed/simple;
	bh=duqhCAeM6f0QdZ7iOt7sBLa/TOVjGfQyvp81lVfJIgY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N4/wa8dSSrkThbJcWr2ziTii5kYU/gB1XOWmQRo5R/C462RKPwgXZKYZcYxZB3rdVBuBZL8t7EjGivEQLeVcoyAhaDik2rZejgOByhcGR+79lgJfd2a1h9lfTZ7RrXki2IDohtCOrkMSsb1Y+eBzKVByBauVMK3u4QUxKRe6DJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82237e575f7so149469939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724989399; x=1725594199;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ki8PQIcXDkacX2lA/3DWotvPYQk+dRj1w18m8Yp7xCg=;
        b=d6bRfiLthXPocyq/7NEHh46vmlS8QhQLL+MlrLlF+cuFVJX5pBSSTMrPiP86ilUD1f
         YYHfn/FuJtcOhFWdAoLbWGi4seO+rAD6KOBoxEcyCwMoXabiRj2q/lh5RyCSksCxF4/n
         6K7sMvWWVlcUuu5DoRJi76hUk7qAaEGCMQ5gH9dja98CfXv6WR1w6i230oNQ2ausnQYS
         cxdzSEdMmdwDxUCm2ztETaFa9nBic9uGcIm3ItCQfgwXXAKK6VU7flUHji4V7p6pvdk3
         Ds9ZD4oqS+BLDlcdVtEqn+I/i2EuGYmDbiWyd2+0M5A7V2goLuMBSZpiCf9M+5U4iQSo
         Pbug==
X-Forwarded-Encrypted: i=1; AJvYcCU4musPoEw5sHDyUoX2IA6rSNOsg722veu+8Fhc0GNUmsLzQWnowljE3MuEavba2uzlIoegzsl+9Zuq31Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvR3xXf4mzIsZLrnHsZmytFmTsYrQVYxsTNbTN1cQpNmbCvNdL
	QdpX93DV7WfChfismZxyUvk2oMBaBfdmLfSGXH6LVYuSi+sCX8ZNYfOqNBpsfcDMcm/164HfjNF
	P6Jq/s3DDhiBhDpKB6w7XuF879PaenbmbBOU16mcfZPzTqy+06YNp2rA=
X-Google-Smtp-Source: AGHT+IEz+gc9DImSPOw7qfjKIi22ZBa0AqyfyjH9FXru6AI6kmG6RllOKbUx76SoyJUzgMI+GT1XiBocZFVTCbGMe0XKC3dI9Ra9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8624:b0:4c0:a8a5:81f5 with SMTP id
 8926c6da1cb9f-4d017e9b260mr31640173.4.1724989399569; Thu, 29 Aug 2024
 20:43:19 -0700 (PDT)
Date: Thu, 29 Aug 2024 20:43:19 -0700
In-Reply-To: <00000000000040b643061ca951fe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006728710620de641e@google.com>
Subject: Re: [syzbot] [usb?] possible deadlock in assign_fw
From: syzbot <syzbot+e70e4c6f6eee43357ba7@syzkaller.appspotmail.com>
To: dakr@redhat.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mcgrof@kernel.org, rafael@kernel.org, 
	russ.weight@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d5d547aa7b51 Merge tag 'random-6.11-rc6-for-linus' of git:..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1493808f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d76559f775f44ba6
dashboard link: https://syzkaller.appspot.com/bug?extid=e70e4c6f6eee43357ba7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ee2b7b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177c7b7b980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/28e0e4e1eeef/disk-d5d547aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72b0f7665fc8/vmlinux-d5d547aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/96e3870a77f6/bzImage-d5d547aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e70e4c6f6eee43357ba7@syzkaller.appspotmail.com

R13: 0000000000000001 R14: 00746f687370616e R15: 616e732f7665642f
 </TASK>
============================================
WARNING: possible recursive locking detected
6.11.0-rc5-syzkaller-00081-gd5d547aa7b51 #0 Not tainted
--------------------------------------------
syz-executor300/5260 is trying to acquire lock:
ffffffff8f293008 (fw_lock){+.+.}-{3:3}, at: assign_fw+0x56/0x890 drivers/base/firmware_loader/main.c:700

but task is already holding lock:
ffffffff8f293008 (fw_lock){+.+.}-{3:3}, at: device_cache_fw_images drivers/base/firmware_loader/main.c:1519 [inline]
ffffffff8f293008 (fw_lock){+.+.}-{3:3}, at: fw_pm_notify+0x232/0x2f0 drivers/base/firmware_loader/main.c:1572

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(fw_lock);
  lock(fw_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz-executor300/5260:
 #0: ffffffff8f145568 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x390 drivers/char/misc.c:129
 #1: ffffffff8e7eb608 (system_transition_mutex){+.+.}-{3:3}, at: lock_system_sleep+0x60/0xa0 kernel/power/main.c:56
 #2: ffffffff8e80bab0 ((pm_chain_head).rwsem){++++}-{3:3}, at: blocking_notifier_call_chain_robust+0xac/0x1e0 kernel/notifier.c:352
 #3: ffffffff8f293008 (fw_lock){+.+.}-{3:3}, at: device_cache_fw_images drivers/base/firmware_loader/main.c:1519 [inline]
 #3: ffffffff8f293008 (fw_lock){+.+.}-{3:3}, at: fw_pm_notify+0x232/0x2f0 drivers/base/firmware_loader/main.c:1572
 #4: ffffffff8f28e0a8 (dpm_list_mtx){+.+.}-{3:3}, at: device_pm_lock drivers/base/power/main.c:113 [inline]
 #4: ffffffff8f28e0a8 (dpm_list_mtx){+.+.}-{3:3}, at: dpm_for_each_dev+0x2b/0xc0 drivers/base/power/main.c:1961

stack backtrace:
CPU: 0 UID: 0 PID: 5260 Comm: syz-executor300 Not tainted 6.11.0-rc5-syzkaller-00081-gd5d547aa7b51 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_deadlock kernel/locking/lockdep.c:3061 [inline]
 validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3855
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 assign_fw+0x56/0x890 drivers/base/firmware_loader/main.c:700
 _request_firmware+0xd0a/0x12b0 drivers/base/firmware_loader/main.c:917
 request_firmware drivers/base/firmware_loader/main.c:963 [inline]
 cache_firmware drivers/base/firmware_loader/main.c:1301 [inline]
 __async_dev_cache_fw_image+0xe7/0x320 drivers/base/firmware_loader/main.c:1415
 async_schedule_node_domain+0xdc/0x110 kernel/async.c:221
 async_schedule_domain include/linux/async.h:72 [inline]
 dev_cache_fw_image+0x36d/0x3e0 drivers/base/firmware_loader/main.c:1471
 dpm_for_each_dev+0x58/0xc0 drivers/base/power/main.c:1963
 device_cache_fw_images drivers/base/firmware_loader/main.c:1521 [inline]
 fw_pm_notify+0x24a/0x2f0 drivers/base/firmware_loader/main.c:1572
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 notifier_call_chain_robust kernel/notifier.c:128 [inline]
 blocking_notifier_call_chain_robust+0xe8/0x1e0 kernel/notifier.c:353
 pm_notifier_call_chain_robust+0x2c/0x60 kernel/power/main.c:102
 snapshot_open+0x138/0x280 kernel/power/user.c:87
 misc_open+0x313/0x390 drivers/char/misc.c:165
 chrdev_open+0x5b0/0x630 fs/char_dev.c:414
 do_dentry_open+0x970/0x1440 fs/open.c:959
 vfs_open+0x3e/0x330 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2b3e/0x3470 fs/namei.c:3886
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fec1643df29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 1e 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fec163e9208 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fec164c4188 RCX: 00007fec1643df29
RDX: 0000000000000001 RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 00007fec164c4180 R08: 00007fec163e8fa7 R09: 0000000000000038
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fec163e9210
R13: 0000000000000001 R14: 00746f687370616e R15: 616e732f7665642f
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

