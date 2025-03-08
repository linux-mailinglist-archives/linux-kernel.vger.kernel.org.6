Return-Path: <linux-kernel+bounces-552167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2B5A5766F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6D03B6A8E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15802182CD;
	Sat,  8 Mar 2025 00:01:25 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE928F3
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392084; cv=none; b=kbVZXm/AlErWBn72kiNcXXeirZihwP7gesG7Al6FdLCnOQp1kiqM3Wp8hE76PSUMEPyib8nqKzBArTf/mGjsF69JTcla2BrAObiucu3V1YjGquauA6ylfFqx/h+gL185/en4wbksdb71J4dlyZCqGTuEqC6ma8h0jU80pVAEe2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392084; c=relaxed/simple;
	bh=JTb9C0DPic752koVYj+XdYiizzZ92RKNneuOjZaUZPs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BMkzAFRQeVHUv3mK51nYYpeqdxeie75M0uc8yHQOz//+QHx9Kfeyi8+23hY/peTOJBVokXdf1ksg8SPsIsxPjMv65DE+6wlTLUfPGnV/Yl/jU3HXc31kCd9eQJA3mmJdeI+i/5pRJxMlzRM5RL0crJPZDdIO6f1s4w6N78ML4js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-849d26dd331so309219939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 16:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741392081; x=1741996881;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sRa1wIeMg9ISz07gwI8bn8Bz+hHteqDa9YLweb3Hxw=;
        b=Wt/Y1dnCEePGu8XvjT5SzeGDwxsYcCv4vhcTctv4jTiiD2YqgNRhqoOxNI1TUnBPNV
         AJVIs7PsZHsqHDyw6/gtlBrbsyh342LQOtWr+eVY3VzX8jXOTwOIxYfwdMwoGtEovFtG
         0DPBYQLymv+yZ0GRY2tQEgj3sUR3Gr+XNEJPm2k79hZQdx+UCVLKB4Hogc5e5C1NwJ+u
         NQpM8Bw4ZL6bflz0ac9Zi1AxS6v/ijMmIZ5En1jgCmI1bBA2wxig75f6FVbVEJSIKQAv
         PWqJIUs5fJX6Nd5wjIMuc4x9PBp/bcecAysY6DhkZXVtw46A7HJCW1Wy5wCxkd4+bcOc
         /Ppw==
X-Forwarded-Encrypted: i=1; AJvYcCUbCncXxZR9u/zHr/JkC+I1AxuXG3lsAHeZ4MPI6P92yFgeuQx31jpKqqTSK+RZHkEuOqjCnyvzynZT3hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAeDFzB2ho2BdlQaBniXS/KfxMSLt/8197R3dQH2c5KDtAgay
	1OAR8eWfzro03V2lVllSgIDh5X+lUALZXOzfxbmT86LjqsI8VCyNWtT5VOZjaZN50RTzgRBrsil
	ICSFSj/ATpNbsxXL/LGwG1GBElL76f16e7Ce4ugZCPYFvbOulTtXbmco=
X-Google-Smtp-Source: AGHT+IH676ZCOgN/MhTUCkWEJaTiT3UDqEeYgcSZDoNksms+A5vyQ2ggHGQcL7JwarDOX8B5onynXCNXVbdH7+D8NBJJVRKNWm8+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378e:b0:3d4:2ea4:6b87 with SMTP id
 e9e14a558f8ab-3d44af34fd9mr11591935ab.11.1741392081443; Fri, 07 Mar 2025
 16:01:21 -0800 (PST)
Date: Fri, 07 Mar 2025 16:01:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb88d1.050a0220.d8275.022b.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in register_netdevice
From: syzbot <syzbot+666871ad20c653deb9a6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    865eddcf0afb Merge branch 'mlx5-misc-enhancements-2025-03-..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16d8c878580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbc61e4c6e816b7b
dashboard link: https://syzkaller.appspot.com/bug?extid=666871ad20c653deb9a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13896a54580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/15388530d696/disk-865eddcf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfd22998e59b/vmlinux-865eddcf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ecc6b8f2a90d/bzImage-865eddcf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+666871ad20c653deb9a6@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.14.0-rc5-syzkaller-01096-g865eddcf0afb #0 Not tainted
--------------------------------------------
dhcpcd/5501 is trying to acquire lock:
ffff88807e6fad28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2765 [inline]
ffff88807e6fad28 (&dev->lock){+.+.}-{4:4}, at: register_netdevice+0x12d8/0x1b70 net/core/dev.c:11008

but task is already holding lock:
ffff88807c708d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2765 [inline]
ffff88807c708d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/linux/netdevice.h:2804 [inline]
ffff88807c708d28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0x120/0x270 net/core/dev_api.c:65

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->lock);
  lock(&dev->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by dhcpcd/5501:
 #0: ffffffff8fed6848 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8fed6848 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x34c/0x1d80 net/ipv4/devinet.c:1121
 #1: ffff88807c708d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2765 [inline]
 #1: ffff88807c708d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/linux/netdevice.h:2804 [inline]
 #1: ffff88807c708d28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0x120/0x270 net/core/dev_api.c:65

stack backtrace:
CPU: 0 UID: 0 PID: 5501 Comm: dhcpcd Not tainted 6.14.0-rc5-syzkaller-01096-g865eddcf0afb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3039
 check_deadlock kernel/locking/lockdep.c:3091 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3893
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
 netdev_lock include/linux/netdevice.h:2765 [inline]
 register_netdevice+0x12d8/0x1b70 net/core/dev.c:11008
 bpq_new_device drivers/net/hamradio/bpqether.c:499 [inline]
 bpq_device_event+0x4b1/0x8d0 drivers/net/hamradio/bpqether.c:542
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 __dev_notify_flags+0x207/0x400
 netif_change_flags+0xf0/0x1a0 net/core/dev.c:9442
 dev_change_flags+0x146/0x270 net/core/dev_api.c:66
 devinet_ioctl+0xea2/0x1d80 net/ipv4/devinet.c:1200
 inet_ioctl+0x3d7/0x4f0 net/ipv4/af_inet.c:1001
 sock_do_ioctl+0x158/0x460 net/socket.c:1190
 sock_ioctl+0x626/0x8e0 net/socket.c:1309
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0cd048dd49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffe158efc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0cd03bf6c0 RCX: 00007f0cd048dd49
RDX: 00007ffe158ffe68 RSI: 0000000000008914 RDI: 0000000000000018
RBP: 00007ffe15910028 R08: 00007ffe158ffe28 R09: 00007ffe158ffdd8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe158ffe68 R14: 0000000000000028 R15: 0000000000008914
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

