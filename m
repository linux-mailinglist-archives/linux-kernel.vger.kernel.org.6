Return-Path: <linux-kernel+bounces-267403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E88B941108
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2546B27CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF601A01D5;
	Tue, 30 Jul 2024 11:45:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13281A01BC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339906; cv=none; b=Os1ks55jwecLqK3Gakkid6KVKmq+MYdbgnRPVxNXSG/InmEyVJs9i/tf/sEk81dvy5BcvoTRZhBYjZbyf1vS8Dwcjb5olVYc/1v9JxjY6u+bZ4UjYNHbeW8hXNqX5hal1flgZ0GDmcpZnRVi21CRuz1NTZGlu/PNPVIOJ4l+mPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339906; c=relaxed/simple;
	bh=HIhJ6nzftJig0rR0oXPJsLNdJz2tutnSizq7uLT4ubU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HKKXB0NoETfLTMTOrvEeUozFq6uJjt2ZpWGvAhBlv/WwP8XmFZPoTjTEnTpYt5Hke+YbRoThtIPJ0pAo2N57MSLm7NEMUrVtHIP8AcnZ8CGf2vXPBjqm6jm4Xz3leMOeiPL6Z9hWPLSp2yVnKFGyuSPGXns+0EjYQxoBSS6n8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f89e62706so691677639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722339904; x=1722944704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSB+D+QP8OQEhHqShzU1kDcTsOaIHNBsemUCnT2Vc2M=;
        b=G/HqwyyxxQb01rkHivd82wiARyt7g1qREodij0PBGtIKV0l39qtB6SAN37VqZDI3fD
         z5Px86XLgHa1ULcqoluOUUj4cSG+x5YCh9lvUjS2X3+MHOY2ps+u0Tf2GCrx/OfxzA4h
         f/pXtR2P/Hd2GOzn0STWIXdWbjtjJsUCC9xuVzue/d7rdWE+QGgw7x7SHZ+Tkwbgw18f
         k4o7EDBrY4id5BujnjBNnjqPZJwQIA6tWjSwfaEbc8ZXsszLlCDXxoeMhq51QdxATbjs
         s2FsZVNcBy5CCSEj6BiDOEyDT9zRPRuz+YNd4EWgtcCqP3Ssh6oNimDzoXXBjG4oWk3s
         CgEg==
X-Forwarded-Encrypted: i=1; AJvYcCUiv7R68Jb66erjLrMLU0ev393Oya9uBkR7gKXzhGwgmCVJnoj4jngiJivnT8J+JBWCABWjeEgrmEcLixS4XhTqA81JXFhi4AwSEYZ7
X-Gm-Message-State: AOJu0YzXo5te46G3/dV64NaaLGJ3v7a6/4H+4VgpVjSKfIULsK2PUQZO
	rq62KgRFW0KzAUgOKIOa4W++tTaE4Lsz4SzOApjmXR70XBilft1gWPN8jyXrU5rd1VjRY3jSkvq
	91Zzes4gl4qAjH//n0d7RArU/0gP90rJfUmJPOvKjxo5BEkPQ7NVmtlA=
X-Google-Smtp-Source: AGHT+IGEAA9vg6T0ZF2s1XaJ6Ytik1FG6vEIEfbVjKkaf5oXBDjldCpuhzlDbMNbfqijKBI1VABH7nf/18Gx2vgKag4RdU7qEpvf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2395:b0:4c0:a8a5:81dc with SMTP id
 8926c6da1cb9f-4c64d6f0080mr665043173.6.1722339903643; Tue, 30 Jul 2024
 04:45:03 -0700 (PDT)
Date: Tue, 30 Jul 2024 04:45:03 -0700
In-Reply-To: <20240730112225.20076-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023b4b4061e75820e@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in team_device_event

netlink: 'syz.0.15': attribute type 10 has an invalid length.
dummy0: left promiscuous mode
dummy0: entered promiscuous mode
============================================
WARNING: possible recursive locking detected
6.11.0-rc1-syzkaller-g94ede2a3e913 #0 Not tainted
--------------------------------------------
syz.0.15/5896 is trying to acquire lock:
ffff88801e9d4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_port_change_check drivers/net/team/team_core.c:2950 [inline]
ffff88801e9d4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973

but task is already holding lock:
ffff88801e9d4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(team->team_lock_key#2);
  lock(team->team_lock_key#2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.0.15/5896:
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
 #1: ffff88801e9d4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975

stack backtrace:
CPU: 1 UID: 0 PID: 5896 Comm: syz.0.15 Not tainted 6.11.0-rc1-syzkaller-g94ede2a3e913 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_deadlock kernel/locking/lockdep.c:3061 [inline]
 validate_chain kernel/locking/lockdep.c:3855 [inline]
 __lock_acquire+0x2167/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 team_port_change_check drivers/net/team/team_core.c:2950 [inline]
 team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 __dev_notify_flags+0x12d/0x2e0 net/core/dev.c:8876
 dev_change_flags+0x10c/0x160 net/core/dev.c:8914
 vlan_device_event+0xdfc/0x2120 net/8021q/vlan.c:468
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 dev_open net/core/dev.c:1515 [inline]
 dev_open+0x144/0x160 net/core/dev.c:1503
 team_port_add drivers/net/team/team_core.c:1216 [inline]
 team_add_slave+0xacd/0x20e0 drivers/net/team/team_core.c:1976
 do_set_master+0x1bc/0x230 net/core/rtnetlink.c:2701
 do_setlink+0xcaf/0x3ff0 net/core/rtnetlink.c:2907
 __rtnl_newlink+0xc35/0x1960 net/core/rtnetlink.c:3696
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2597
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f16bd377299
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f16be089048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f16bd506058 RCX: 00007f16bd377299
RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000012
RBP: 00007f16bd3e48e6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f16bd506058 R15: 00007ffebae71978
 </TASK>


Tested on:

commit:         94ede2a3 profiling: remove stale percpu flip buffer va..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b92c6d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04fc17f2c61c03
dashboard link: https://syzkaller.appspot.com/bug?extid=b668da2bc4cb9670bf58
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

