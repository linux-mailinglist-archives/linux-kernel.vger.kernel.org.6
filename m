Return-Path: <linux-kernel+bounces-269289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A65F943110
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9DAB22750
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4081B1425;
	Wed, 31 Jul 2024 13:39:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A664F1AD9CB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433147; cv=none; b=bPeKD9nCYQGhAVJtZ4KsTp5DGFT+uKR5D5izM0rv+3OaqXUy+Xm4YD1/tzlHNRumFBeIps8O7wtVGwVS+JQelzxkXQqBJGNFYnwQzFVktsvKYOebvyaLnQqUWNePIlWmym01saT1pLE3RscRZrNUERELwntvlQWt+CofF/6JA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433147; c=relaxed/simple;
	bh=2FbVn/ZMO9BnXPZCn5KQpLlvFegC+WVUKKZU1A77vVM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ea3HK4tiFC+Cin4wsE42XrSwHJkNS3oJk2xC+UNl/ua249jfwABovnK/X2aeEyFwm7AD6kuYHPSyZa10ASFwiqF9oLElw0MWjbZVMXWOQhwZ+JrXFuUwshHAuZy48ULxLsNOOyoa0xnB3udKFM1c/cxryMaeo+psDGQACRPUnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39a1d269982so101501345ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722433145; x=1723037945;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/JVx5ti0sDY/cb/UO2p3aeQVthg0ZbcHD88tall3YF8=;
        b=ppXz2ODtK40keQWGGmpZonqmQuZlJ9VDWQBmGW8vvfdKYSFQf955lVcmNzQ3df/l2T
         xwiEyIuzTSg4KHnSUcn0ExaWYsyZ6DR6FKlVUdwArkfO/KTFj8pMLLweJWat+/xXK41B
         xsVlOHY43GofcdSoYtbFV5x5jUIdCeoaaaT/xcfaLMbg5OwmzoOsCi7SYXvdKGN70hUA
         8l2x4Eo/hzZKm9CSER7v//wzhgdQpLUysaQaJ4Ldl2FKg/vs0i//LAVkGmYgpH77Raab
         tpZcWRcx+Dw9tArADWcLrTu7KuneONvT/jh5eq6NEcqgIknwu3MW7mHRAakTQq5lunAh
         9nPA==
X-Forwarded-Encrypted: i=1; AJvYcCWCahf9aaRd5sVVKI2YBqPd6GtMed32anrrWd2NY2hvzrIj8hNaEjmr058fyQJnOq5zMrxGPYaRTZ2DMf9jg3YiQzeu3R3ATseh/kLm
X-Gm-Message-State: AOJu0YwsTzx7UDOTwpU7uxbtFxtHGmsMU0F45zyqsFPMYhLt4ZH8rePQ
	eTzr59v/1loGTSanmXYmaMNDATtR8HhjnYjs33OXwLKXwH7vlU38zoFIae5a3/Nr0gGTRtsbOk3
	/BdcawEpZB89HqiS6npEZhxGQw2TT3XjlMKeZW5mfo0yds10wFOFOmE0=
X-Google-Smtp-Source: AGHT+IEsJEtVdp/0LPNgfOdkp3ImBeMC8ZTdnKUMRsbwQH77phuDTmhvm+DD7AuDB9oGeEkOXiv25yD3IU04JuH/VQ4qkx5NcYoE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1546:b0:398:3831:4337 with SMTP id
 e9e14a558f8ab-39aec427281mr9625815ab.5.1722433144804; Wed, 31 Jul 2024
 06:39:04 -0700 (PDT)
Date: Wed, 31 Jul 2024 06:39:04 -0700
In-Reply-To: <20240731131908.13019-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bee93f061e8b3736@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in team_device_event

dummy0: left promiscuous mode
dummy0: entered promiscuous mode
============================================
WARNING: possible recursive locking detected
6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0 Not tainted
--------------------------------------------
syz.0.15/5889 is trying to acquire lock:
ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_port_change_check drivers/net/team/team_core.c:2950 [inline]
ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973

but task is already holding lock:
ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(team->team_lock_key#2);
  lock(team->team_lock_key#2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.0.15/5889:
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
 #1: ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975

stack backtrace:
CPU: 1 UID: 0 PID: 5889 Comm: syz.0.15 Not tainted 6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0
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
 do_setlink+0x306d/0x4060 net/core/rtnetlink.c:2907
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
RIP: 0033:0x7fc07ed77299
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc07fb7f048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc07ef05f80 RCX: 00007fc07ed77299
RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000012
RBP: 00007fc07ede48e6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc07ef05f80 R15: 00007ffeb5c0d528
 </TASK>


Tested on:

commit:         e4fc196f Merge tag 'for-6.11-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101f2555980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04fc17f2c61c03
dashboard link: https://syzkaller.appspot.com/bug?extid=b668da2bc4cb9670bf58
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e8c2f9980000


