Return-Path: <linux-kernel+bounces-565343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DCCA66626
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B753C189A95C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD2EEEBD;
	Tue, 18 Mar 2025 02:17:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF06D190485
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742264224; cv=none; b=dmjI9JYQNXKhvffISy204GYUm4p0x4VviX5LGnoelg6ovZ1u3cidZe06ZRpeedzdAmWq0VOnq31zuC/xN+T/FBcK3TeQtuQBkHxKV54Slrvc66Vgm4yLq3BWVJ2cEOywht1AA2W1oSDi071FH/Au+kiQhXUiny7npBtrCbLpIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742264224; c=relaxed/simple;
	bh=2SKftFk0Pyj02l/NBZNOxaCozHDZ/80dhyU0sDn26MM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AP67BRt8xzmHA+1MnTPlGceNawf06zykqWQxaus66o9Oj1lITvz3w8EJrzuWZA8A0yRKmYVv8Q8bTUrfXtMCUrHhffB2QmyRcoQc99FVgbIJDrkjcOX6FCowOz4WoC8fhTkCx/X4q1qI5EGBax9qyTSGawPkpvdXBImYUA4rIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b33f8a602so486462939f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 19:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742264222; x=1742869022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOQoXFWkVKfcGJwJOIuAg8+o9136Gz1KxbpP++aLK9I=;
        b=QAdhyRo36ooVBJTw7JX+FN9GVeT3evd1UEfwT5EW/oQSF6tKaz5W4jogQlVI/FNXmj
         X/mV07FUnNemsHdzcg6ZMnFpy7n+a2rUavBfJZkIhEXpE4b5sMTXZ5vsNoBTiorWxDiw
         QygtZsXzh5LyDtbaWFishxxpkgEi1+bC8yK/LXxlKgG3RqCIEFkjFuH/rSC6IW1DnpXM
         U2ZZ8NZ1CIcXDBtcRAYiQoBk4xq7pP4eNYlm8s6x7OIBib5JoSLT5BvJrv/JLvTa0UHD
         EsdDkvkx6Icj+3koQRghyOw3y4AIsWop0pO0YSRU131ioOklZflp5ZOFwXpnLe8NvC5o
         XEXA==
X-Forwarded-Encrypted: i=1; AJvYcCWqYT85SPrvzsTLXtGbULNMWKj8P+lHVBX+swiB6VjJQeBeKUt9GZej205nMfCTGNh6qcS8GE9VxEw5dW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//zm+a12sQsNK1hB6VHwdn3hjVDsrPY1rHPA4A5FwjveMYmRb
	6Nd072huVZrScP4Kvs8SOqzX4Dmue+u82wq90O0y0uO00x55V0gzPGFHvjET6PVqVx+QEb/8Vlp
	Zv9XjaSc5gT3Gb7PHsP0+RWWw30TyVsgyswa8VfoW03aIVRxGLCEzVfM=
X-Google-Smtp-Source: AGHT+IGinpj4DJ7oTOMwy7sHcbnEwTbOvX6b5X2uOyBw5WMAwyFizPWl4thvY7El3gI+hVKZus1lpAvrzBPFr983cTFJOZhDkYze
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3686:b0:3d4:3ac3:4ca2 with SMTP id
 e9e14a558f8ab-3d57ba0ed3fmr23921885ab.16.1742264221878; Mon, 17 Mar 2025
 19:17:01 -0700 (PDT)
Date: Mon, 17 Mar 2025 19:17:01 -0700
In-Reply-To: <tencent_4C2A333C9EDB1B264B0E1B0425E2BACBBB08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d8d79d.050a0220.2ca2c6.00c5.GAE@google.com>
Subject: Re: [syzbot] [wireless?] INFO: trying to register non-static key in cfg80211_dev_free
From: syzbot <syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: trying to register non-static key in cfg80211_dev_free

RBP: 00007f4a52781090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f4a51ba5fa0 R15: 00007fff60422438
 </TASK>
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 6546 Comm: syz.0.16 Not tainted 6.14.0-rc7-syzkaller-g4701f33a1070-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 assign_lock_key kernel/locking/lockdep.c:983 [inline]
 register_lock_class+0xc39/0x1240 kernel/locking/lockdep.c:1297
 __lock_acquire+0x135/0x3c40 kernel/locking/lockdep.c:5103
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 cfg80211_dev_free+0x2b1/0x420 net/wireless/core.c:1197
 device_release+0xa1/0x240 drivers/base/core.c:2568
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3774
 wiphy_free net/wireless/core.c:1226 [inline]
 wiphy_new_nm+0x1c1f/0x2160 net/wireless/core.c:562
 ieee80211_alloc_hw_nm+0x1b7a/0x2260 net/mac80211/main.c:835
 mac80211_hwsim_new_radio+0x1d6/0x54e0 drivers/net/wireless/virtual/mac80211_hwsim.c:5185
 hwsim_new_radio_nl+0xb42/0x12b0 drivers/net/wireless/virtual/mac80211_hwsim.c:6242
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2533
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1882
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg net/socket.c:733 [inline]
 ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
 __sys_sendmsg+0x16e/0x220 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a5198d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4a52781038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4a51ba5fa0 RCX: 00007f4a5198d169
RDX: 0000000020000000 RSI: 0000400000000140 RDI: 0000000000000003
RBP: 00007f4a52781090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f4a51ba5fa0 R15: 00007fff60422438
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6546 at net/wireless/core.c:1198 cfg80211_dev_free+0x324/0x420 net/wireless/core.c:1198
Modules linked in:
CPU: 0 UID: 0 PID: 6546 Comm: syz.0.16 Not tainted 6.14.0-rc7-syzkaller-g4701f33a1070-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:cfg80211_dev_free+0x324/0x420 net/wireless/core.c:1198
Code: 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 e6 00 00 00 49 8b 9d 08 0e 00 00 e9 2e fd ff ff e8 4d 10 11 f7 90 <0f> 0b 90 eb b2 4c 89 ff e8 bf 22 74 f7 e9 04 ff ff ff 48 89 ef e8
RSP: 0018:ffffc90003fff1b8 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000293 RCX: ffffffff81972ead
RDX: ffff88802d654880 RSI: ffffffff8aa8e213 RDI: ffffc90003fff128
RBP: ffff88802c9d8e08 R08: 0000000000000001 R09: fffff520007ffe25
R10: 0000000000000003 R11: 0000000000000001 R12: ffff88802c9d86a8
R13: ffff88802c9d8000 R14: ffff88802c9d86b8 R15: 0000000000000000
FS:  00007f4a527816c0(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000400000001ac0 CR3: 0000000030dea000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 device_release+0xa1/0x240 drivers/base/core.c:2568
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3774
 wiphy_free net/wireless/core.c:1226 [inline]
 wiphy_new_nm+0x1c1f/0x2160 net/wireless/core.c:562
 ieee80211_alloc_hw_nm+0x1b7a/0x2260 net/mac80211/main.c:835
 mac80211_hwsim_new_radio+0x1d6/0x54e0 drivers/net/wireless/virtual/mac80211_hwsim.c:5185
 hwsim_new_radio_nl+0xb42/0x12b0 drivers/net/wireless/virtual/mac80211_hwsim.c:6242
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2533
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1882
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg net/socket.c:733 [inline]
 ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
 __sys_sendmsg+0x16e/0x220 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a5198d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4a52781038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4a51ba5fa0 RCX: 00007f4a5198d169
RDX: 0000000020000000 RSI: 0000400000000140 RDI: 0000000000000003
RBP: 00007f4a52781090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f4a51ba5fa0 R15: 00007fff60422438
 </TASK>


Tested on:

commit:         4701f33a Linux 6.14-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10466474580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e330e9768b5b8ff
dashboard link: https://syzkaller.appspot.com/bug?extid=aaf0488c83d1d5f4f029
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1684c44c580000


