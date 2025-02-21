Return-Path: <linux-kernel+bounces-525128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049EA3EB26
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0544D3BF09C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548011F419E;
	Fri, 21 Feb 2025 03:16:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBE4EEB3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107765; cv=none; b=Ki8tI0yuBsGtoA3kdAGKb/IFG7B6CYqiM+qCqD/1+R7QZzHwQ0PTNlROUWTPonrKnw+IyNavDQLjJ4UWNCyP1X7dG+cJbBjnoHz9ggRGdckLOF1oRA1MHrnHLTxeEAdAOp5tyxnIWVM5AZ7XV8qANnRaqeuPK4DRN4uiDgNIknE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107765; c=relaxed/simple;
	bh=JRay5jObY05M1Pb5FaXVp42vVD67O/m+TADngBpIpSQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J4J26fcBmxy82lhPVSLNGlWjRShqj1ECbLbTsKzdceH0ykTyOx4AZEj9NZDW6cZBQGPM6TaZkR9/x/I08NOLG0Bu4gsRChljARNyW/V7sayWZaalmMLJOp7hMl22L4MpnkPAwm9H5KI0JtLTrvAEOBxS6ZSdxwVA9eWFA9PrUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2b6d933c1so28701645ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740107763; x=1740712563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3P76AitDE/4E9OY3L5QINHGgIN4J+bOwGujibRrzhmw=;
        b=YT5w9ZLz5qCdoJoxQLr6LySsGL7vzjFsFmGmRlYFcdOfzq3r2AQ1ttTM2PUSPYmttB
         vyTJQ36D7JAoHkDF30aQ5exdVy1EDDPW3AGz12kVnhpWZy4lMp3oZg+69hyyTSYoNhj2
         i6WPs5bcAiV2XAk6vm7bYhqQ3dRfB/GIZBYqTBy6RS/IAG+eoU7bmV0XLo2ujNz26dxM
         /cEszLQyq9ZPyN0VwI4YRuYtNqe+96cWApA8vwY/9reMqoU1wNltvq5hyG+YTwLwh5IC
         9tZE50X2GXxRRdzl6U76G1jD7OQoMjAZ4Mnh50AN2pDRUdYuHF/oF+4nSAHYNKQkGyMo
         IrkA==
X-Gm-Message-State: AOJu0Yybkp7fFjOaAOHz1cK6m2GPSXZI2idpNdOj9fdkEc4bcN7UApWf
	tnVk5ORRjBxP1NkVMccOOyu2tsJ8SmZAwM3PmvuStua+Q/43AS0L5/91ECVr2eayBrj34LycYHf
	V9Rn7Mf7kixD2CfFZRf7t4Ek8TmLKVMoaubY1LSzDj/Ms2YuFiWTgLtM=
X-Google-Smtp-Source: AGHT+IFGyuNs3pe62c+8Tij7YS7F1nHK4NOISDSsJ5KZqGAaT6mNQQdPMHbT6HOE24uIhZ8ZBpFKJgu0rwAnGYSr/GXDr8FdqikV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1526:b0:3d0:4a82:3f43 with SMTP id
 e9e14a558f8ab-3d2cb43281cmr14040665ab.5.1740107762960; Thu, 20 Feb 2025
 19:16:02 -0800 (PST)
Date: Thu, 20 Feb 2025 19:16:02 -0800
In-Reply-To: <20250221025728.2024114-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b7eff2.050a0220.14d86d.030a.GAE@google.com>
Subject: Re: [syzbot] [pm?] possible deadlock in lock_system_sleep
From: syzbot <syzbot+ace60642828c074eb913@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in lock_system_sleep

======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc3-syzkaller-g334426094588-dirty #0 Not tainted
------------------------------------------------------
syz.0.16/6798 is trying to acquire lock:
ffffffff8e0828c8 (system_transition_mutex){+.+.}-{4:4}, at: lock_system_sleep+0x87/0xa0 kernel/power/main.c:56

but task is already holding lock:
ffffffff8e07dc68 (param_lock){+.+.}-{4:4}, at: kernel_param_trylock kernel/params.c:614 [inline]
ffffffff8e07dc68 (param_lock){+.+.}-{4:4}, at: param_attr_store+0xe4/0x310 kernel/params.c:586

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (param_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       ieee80211_rate_control_ops_get net/mac80211/rate.c:220 [inline]
       rate_control_alloc net/mac80211/rate.c:266 [inline]
       ieee80211_init_rate_ctrl_alg+0x18d/0x6b0 net/mac80211/rate.c:1015
       ieee80211_register_hw+0x20cd/0x4060 net/mac80211/main.c:1531
       mac80211_hwsim_new_radio+0x304e/0x54e0 drivers/net/wireless/virtual/mac80211_hwsim.c:5558
       init_mac80211_hwsim+0x432/0x8c0 drivers/net/wireless/virtual/mac80211_hwsim.c:6910
       do_one_initcall+0x128/0x700 init/main.c:1257
       do_initcall_level init/main.c:1319 [inline]
       do_initcalls init/main.c:1335 [inline]
       do_basic_setup init/main.c:1354 [inline]
       kernel_init_freeable+0x5c7/0x900 init/main.c:1568
       kernel_init+0x1c/0x2b0 init/main.c:1457
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (rtnl_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       wg_pm_notification drivers/net/wireguard/device.c:80 [inline]
       wg_pm_notification+0x49/0x180 drivers/net/wireguard/device.c:64
       notifier_call_chain+0xb7/0x410 kernel/notifier.c:85
       notifier_call_chain_robust kernel/notifier.c:120 [inline]
       blocking_notifier_call_chain_robust kernel/notifier.c:345 [inline]
       blocking_notifier_call_chain_robust+0xc9/0x170 kernel/notifier.c:333
       pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
       snapshot_open+0x189/0x2b0 kernel/power/user.c:77
       misc_open+0x35a/0x420 drivers/char/misc.c:179
       chrdev_open+0x237/0x6a0 fs/char_dev.c:414
       do_dentry_open+0x735/0x1c40 fs/open.c:956
       vfs_open+0x82/0x3f0 fs/open.c:1086
       do_open fs/namei.c:3830 [inline]
       path_openat+0x1e88/0x2d80 fs/namei.c:3989
       do_filp_open+0x20c/0x470 fs/namei.c:4016
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1428
       do_sys_open fs/open.c:1443 [inline]
       __do_sys_openat fs/open.c:1459 [inline]
       __se_sys_openat fs/open.c:1454 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1454
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 ((pm_chain_head).rwsem){++++}-{4:4}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
       blocking_notifier_call_chain_robust kernel/notifier.c:344 [inline]
       blocking_notifier_call_chain_robust+0xa9/0x170 kernel/notifier.c:333
       pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
       snapshot_open+0x189/0x2b0 kernel/power/user.c:77
       misc_open+0x35a/0x420 drivers/char/misc.c:179
       chrdev_open+0x237/0x6a0 fs/char_dev.c:414
       do_dentry_open+0x735/0x1c40 fs/open.c:956
       vfs_open+0x82/0x3f0 fs/open.c:1086
       do_open fs/namei.c:3830 [inline]
       path_openat+0x1e88/0x2d80 fs/namei.c:3989
       do_filp_open+0x20c/0x470 fs/namei.c:4016
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1428
       do_sys_open fs/open.c:1443 [inline]
       __do_sys_openat fs/open.c:1459 [inline]
       __se_sys_openat fs/open.c:1454 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1454
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (system_transition_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain kernel/locking/lockdep.c:3906 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       lock_system_sleep+0x87/0xa0 kernel/power/main.c:56
       hibernate_compressor_param_set+0x1c/0x210 kernel/power/hibernate.c:1452
       param_attr_store+0x1a7/0x310 kernel/params.c:590
       module_attr_store+0x55/0x80 kernel/params.c:931
       sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
       kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0x5ae/0x1150 fs/read_write.c:679
       ksys_write+0x12b/0x250 fs/read_write.c:731
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  system_transition_mutex --> rtnl_mutex --> param_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(param_lock);
                               lock(rtnl_mutex);
                               lock(param_lock);
  lock(system_transition_mutex);

 *** DEADLOCK ***

5 locks held by syz.0.16/6798:
 #0: ffff8880630bc2b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1192
 #1: ffff8880358a8420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff88803454ac88 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #3: ffff88814caab2d8 (kn->active#4){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #4: ffffffff8e07dc68 (param_lock){+.+.}-{4:4}, at: kernel_param_trylock kernel/params.c:614 [inline]
 #4: ffffffff8e07dc68 (param_lock){+.+.}-{4:4}, at: param_attr_store+0xe4/0x310 kernel/params.c:586

stack backtrace:
CPU: 1 UID: 0 PID: 6798 Comm: syz.0.16 Not tainted 6.14.0-rc3-syzkaller-g334426094588-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x490/0x760 kernel/locking/lockdep.c:2076
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain kernel/locking/lockdep.c:3906 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
 lock_system_sleep+0x87/0xa0 kernel/power/main.c:56
 hibernate_compressor_param_set+0x1c/0x210 kernel/power/hibernate.c:1452
 param_attr_store+0x1a7/0x310 kernel/params.c:590
 module_attr_store+0x55/0x80 kernel/params.c:931
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f77a098cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f77a18af038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f77a0ba6080 RCX: 00007f77a098cde9
RDX: 00000000000040db RSI: 0000400000005900 RDI: 0000000000000004
RBP: 00007f77a0a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f77a0ba6080 R15: 00007fff5c12c868
 </TASK>


Tested on:

commit:         33442609 Merge tag 'for-v6.14-rc' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10943ae4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61cbf5ac8a063ad4
dashboard link: https://syzkaller.appspot.com/bug?extid=ace60642828c074eb913
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129daba4580000


