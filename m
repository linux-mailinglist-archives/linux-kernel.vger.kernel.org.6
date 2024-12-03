Return-Path: <linux-kernel+bounces-429998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BF79E2AA1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BF1163E53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE871FCD14;
	Tue,  3 Dec 2024 18:18:29 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8981FBEA5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249909; cv=none; b=qeG9PtstLW+VkWj38WMVxQys/3V8wbG/sKWN2jZZxh0ecAm3Z9ho6KxNoQGqwfiA8RncbX/4bhS8FM6/ujkn8Pu/LjYCcrJC3G7325ZwevRpnaHY6IerexgVswTNq8iCppduSDCRyjJaR7jRrv00RDYQyg9onJ5+nc5moFlqKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249909; c=relaxed/simple;
	bh=Y/LATXzbXBs1wuBH8LCeQx8wtNBrawUJlxEPBbZRTgU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BIkE8aovWem2A3N+R4mRvsXTZExqEgntst5GxcKh7vLCfIxl+oWatCdMPM9fnllgQsaVfSOMeER+uynB4Lv2MTUpGixsDetxT7GKL0yetRwGP1kAIyFz4q8xhMF88+VckpCzSx2v/NFlLrNK/05+d2TpYc6OG1WDZbfgL9RcWkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7cf41b54eso115366115ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 10:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733249907; x=1733854707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H8RBZ0U7YFVbawuroNmqKmJopoxRovlVXxs2fuXsgOQ=;
        b=YwMIW9M8r0J0Aw5HHWe2wXWDvEEnJwtZ1HvNfZgBG7zQ66c0T/g+oK3EBmdya0i2Wb
         scDqpcLpfqdhW9Y2p4cjTNtNuWdOu7Lqg1CymUj/7OuIOMy6yRlrQtJC07pt2MJaNmK2
         PUUq0LcrNLwKyEOajWmXRrppKjIOu9f9eqr1z8Hk+od4KPr/2tUBQri7JIpsILooijSf
         WoR2vmgem2gUtbmuWNflc9mGSLnHJEuFJNc1OAwQfIncddMKxDgbg3xEV/GTq/6FnObV
         3LZc0tV20o34SsaLQGJlK0N9nlWHdkVTM6FOm0fBNr/KPQGXPYq9d9r12vX2RNCLgDre
         gI1w==
X-Forwarded-Encrypted: i=1; AJvYcCU56/qMBDAG6J937BA5ay+JYUsAkGn/6rPBP7DvViGmta8TQPARGdQV9YsSHzeejqoPk6KsMd+Rhy/zQmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTatbOvb+saFxhtvbjCc+wd8b+LUMerUvhrns4OOUtspAcNYrH
	Iom6PkyxeMi/49wH/U8/mAquJYxvxu8UmChZ8e8QJsrWNkwDGTjJbmlJYesKdJbdt/7MzTZp4B3
	w9v7Jhb89kR4VIsufbvMtnCf3Tn2QrpxugYIRJu1jnfy8s4GLKwiiWf4=
X-Google-Smtp-Source: AGHT+IE4Hbak9jaVQvKtwxtOhqhG4SJFknf1eSnld1wtG3nbW0JHuSbM2fVwB1KsKRd7SDcinMCufy5c4+ZW7alz19YQCaw6QjC4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184b:b0:3a7:4826:b057 with SMTP id
 e9e14a558f8ab-3a7fedb4c6fmr16352255ab.21.1733249906967; Tue, 03 Dec 2024
 10:18:26 -0800 (PST)
Date: Tue, 03 Dec 2024 10:18:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f4b72.050a0220.17bd51.004a.GAE@google.com>
Subject: [syzbot] [net?] WARNING in geneve_xmit (2)
From: syzbot <syzbot+3ec5271486d7cb2d242a@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aaf20f870da0 Merge tag 'rpmsg-v6.13' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167d0f78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a51a585c6e636e05
dashboard link: https://syzkaller.appspot.com/bug?extid=3ec5271486d7cb2d242a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a124d816c6b8/disk-aaf20f87.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72ab15012016/vmlinux-aaf20f87.xz
kernel image: https://storage.googleapis.com/syzbot-assets/70a3dde18fe5/bzImage-aaf20f87.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ec5271486d7cb2d242a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 skb_mac_header include/linux/skbuff.h:3052 [inline]
WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 eth_hdr include/linux/if_ether.h:24 [inline]
WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 geneve_xmit_skb drivers/net/geneve.c:898 [inline]
WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 geneve_xmit+0x4c38/0x5730 drivers/net/geneve.c:1039
Modules linked in:
CPU: 0 UID: 0 PID: 11635 Comm: syz.4.1423 Not tainted 6.12.0-syzkaller-10296-gaaf20f870da0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:skb_mac_header include/linux/skbuff.h:3052 [inline]
RIP: 0010:eth_hdr include/linux/if_ether.h:24 [inline]
RIP: 0010:geneve_xmit_skb drivers/net/geneve.c:898 [inline]
RIP: 0010:geneve_xmit+0x4c38/0x5730 drivers/net/geneve.c:1039
Code: 21 c6 02 e9 35 d4 ff ff e8 a5 48 4c fb 90 0f 0b 90 e9 fd f5 ff ff e8 97 48 4c fb 90 0f 0b 90 e9 d8 f5 ff ff e8 89 48 4c fb 90 <0f> 0b 90 e9 41 e4 ff ff e8 7b 48 4c fb 90 0f 0b 90 e9 cd e7 ff ff
RSP: 0018:ffffc90003b2f870 EFLAGS: 00010283
RAX: 000000000000037a RBX: 000000000000ffff RCX: ffffc9000dc3d000
RDX: 0000000000080000 RSI: ffffffff86428417 RDI: 0000000000000003
RBP: ffffc90003b2f9f0 R08: 0000000000000003 R09: 000000000000ffff
R10: 000000000000ffff R11: 0000000000000002 R12: ffff88806603c000
R13: 0000000000000000 R14: ffff8880685b2780 R15: 0000000000000e23
FS:  00007fdc2deed6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30a1dff8 CR3: 0000000056b8c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
 netdev_start_xmit include/linux/netdevice.h:5011 [inline]
 __dev_direct_xmit+0x58a/0x720 net/core/dev.c:4490
 dev_direct_xmit include/linux/netdevice.h:3181 [inline]
 packet_xmit+0x1e4/0x360 net/packet/af_packet.c:285
 packet_snd net/packet/af_packet.c:3146 [inline]
 packet_sendmsg+0x2700/0x5660 net/packet/af_packet.c:3178
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 __sys_sendto+0x488/0x4f0 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdc2d180809
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdc2deed058 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fdc2d345fa0 RCX: 00007fdc2d180809
RDX: 000000000000000e RSI: 0000000020000340 RDI: 0000000000000003
RBP: 00007fdc2d1f393e R08: 0000000020000140 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fdc2d345fa0 R15: 00007ffff90ca148
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

