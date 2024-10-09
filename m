Return-Path: <linux-kernel+bounces-356215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F60995DF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D031C231DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534B714389F;
	Wed,  9 Oct 2024 03:00:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8D33CD2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728442826; cv=none; b=HxyqgjBcGZ1w2pOTeAasxOT1JCKOf7EKEkAnx3LyioN1F14wS+hGJoiOawei1fpcUG1hlky6bDc4yv3D0ECQyAsh8J3aUh6E1njgS5qJop+UGbz36VoHJAanjCqXm+oT5BU3e04QmZoZo400ZKukrtNu9qYLjQ8oJwJEAqldgQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728442826; c=relaxed/simple;
	bh=EKzSe3l127c0FtgaRrCDVcFSxZngZ1yfjID+uenub1I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WaSKDn+WCCuDQH362q43wkiHKZXZrBw4k0QFjnNinSHYC7vt9aKrg6tToiS8Jc4TVnQDm2koLnJMMCj0Dl1MIgcoBioKckGxU2ECv+H8ENORG2/LPpWxS1CN35anhPrEjsOom9TcbAd6gXHIoU5PxK45jHIyH2yYSbGGP0mZtlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cfb2e416eso637913139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 20:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728442824; x=1729047624;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WuNXNID054cE2rPIWs4gRPFDIc54AZtiC25l+hHN73Y=;
        b=tfPERvELeFqK9PXAGU92M45+WsOzL0vvfnQvBh9bGn0ejv75lSZm6aj9dTtCKD/DGp
         WLTjvtUEZhoalZlgInW7AKQ2OHyjq5Szz2H9XX7HywFzoRX12HIFx6OkteEeGSXo4IcB
         goyLXSneTahDnLgHBYyprvIlcanzIk25VA1E8P30drugdoQoTvJOyArC0nq9pwnbWODU
         7WLeWUSsreGLx3NyqhwfwFo5MrSJrgCTZyPjMIF1WaQ5XZlNKmSkUXhFoLOKjmOF326O
         yjGTuSgIeRitoXmygDfqchqnBgoW8JaGP9Sz9TStersrVvDk8zKUY8n0Ph73sWG2j0ot
         kQQA==
X-Forwarded-Encrypted: i=1; AJvYcCWpMka9d1veKz2CbQietCIf2ymsgY9Ngg4eb1bi6wdAuq/y5/muRWe3e1yXxyoDVCYCctI6QheHjOvw2vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxILncodYzdeIdjN8MWenOSo2i28alO1kXcrAwoMTHueR40zSgk
	iii1WuTqGVADjJudAAYTEHRZeCxWjPawcYfdnuE1i8eMBK3JW28Gm5M1ja4TOr7ufafbp91vq8q
	izhFq5WMOdApgt1XP8YxmHRzG1kgcl8n+tvy4BLTwSD0tLUk28eo30rQ=
X-Google-Smtp-Source: AGHT+IE+RPoXlva5bWFY8C9q2RKuxt4rLyZtyaJurioxaKBqXnjNcDIafHDhIaFSyNzVyFsya2dXNEAsUzPUCdrqhoXG1+Ha1qL/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1541:b0:3a0:9b27:7d52 with SMTP id
 e9e14a558f8ab-3a397d0fc81mr7872275ab.20.1728442824282; Tue, 08 Oct 2024
 20:00:24 -0700 (PDT)
Date: Tue, 08 Oct 2024 20:00:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6705f1c8.050a0220.22840d.000c.GAE@google.com>
Subject: [syzbot] [usb?] possible deadlock in chaoskey_open
From: syzbot <syzbot+5f1ce62e956b7b19610e@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, keithp@keithp.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a9fe2a8ac53 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1184d307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=5f1ce62e956b7b19610e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1601d380580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1584479f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/883c5319cb52/disk-4a9fe2a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caf4421ed2ef/vmlinux-4a9fe2a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8e3beb01d49/bzImage-4a9fe2a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f1ce62e956b7b19610e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0 Not tainted
------------------------------------------------------
syz-executor233/2673 is trying to acquire lock:
ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_open+0xdd/0x220 drivers/usb/misc/chaoskey.c:274

but task is already holding lock:
ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (minor_rwsem){++++}-{3:3}:
       down_write+0x93/0x200 kernel/locking/rwsem.c:1577
       usb_deregister_dev+0x7c/0x1e0 drivers/usb/core/file.c:186
       chaoskey_disconnect+0xb7/0x2a0 drivers/usb/misc/chaoskey.c:236
       usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
       device_remove drivers/base/dd.c:569 [inline]
       device_remove+0x122/0x170 drivers/base/dd.c:561
       __device_release_driver drivers/base/dd.c:1273 [inline]
       device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
       bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
       device_del+0x396/0x9f0 drivers/base/core.c:3864
       usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
       usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
       hub_port_connect drivers/usb/core/hub.c:5361 [inline]
       hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
       port_event drivers/usb/core/hub.c:5821 [inline]
       hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (chaoskey_list_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       chaoskey_open+0xdd/0x220 drivers/usb/misc/chaoskey.c:274
       usb_open+0x186/0x220 drivers/usb/core/file.c:47
       chrdev_open+0x237/0x6a0 fs/char_dev.c:414
       do_dentry_open+0x6cb/0x1390 fs/open.c:958
       vfs_open+0x82/0x3f0 fs/open.c:1088
       do_open fs/namei.c:3774 [inline]
       path_openat+0x1e6a/0x2d60 fs/namei.c:3933
       do_filp_open+0x1dc/0x430 fs/namei.c:3960
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
       do_sys_open fs/open.c:1430 [inline]
       __do_sys_openat fs/open.c:1446 [inline]
       __se_sys_openat fs/open.c:1441 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1441
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(minor_rwsem);
                               lock(chaoskey_list_lock);
                               lock(minor_rwsem);
  lock(chaoskey_list_lock);

 *** DEADLOCK ***

1 lock held by syz-executor233/2673:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38

stack backtrace:
CPU: 1 UID: 0 PID: 2673 Comm: syz-executor233 Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x41c/0x610 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 chaoskey_open+0xdd/0x220 drivers/usb/misc/chaoskey.c:274
 usb_open+0x186/0x220 drivers/usb/core/file.c:47
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x6cb/0x1390 fs/open.c:958
 vfs_open+0x82/0x3f0 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3933
 do_filp_open+0x1dc/0x430 fs/namei.c:3960
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fab087d4e91
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d fa a1 07 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007ffe8b2c7190 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fab087d4e91
RDX: 0000000000000002 RSI: 00007ffe8b2c7210 RDI: 00000000ffffff9c
RBP: 00007ffe8b2c7210 R08: 000000000000000f R09: 00007ffe8b2c6fa7
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe8b2c72cc
R13: 00007ffe8b2c7300 R14: 00007ffe8b2c72e0 R15: 0000000000000002
 </TASK>


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

