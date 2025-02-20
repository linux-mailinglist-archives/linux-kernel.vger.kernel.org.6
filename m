Return-Path: <linux-kernel+bounces-524111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC84A3DF4B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA3E3B5DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95C3211291;
	Thu, 20 Feb 2025 15:49:24 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691F20E6EE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066564; cv=none; b=Lw88bOSNBJRIMBuCQ19wJ1qlGP4CjMp7aMRq/Ppr7Ct4tQdxTNoWFkg8F9fDtAlsadILD/FKcDlrM6s5XF/FKzR96Kug6EQVnqMdwUAuNN9y33xktvEC35iC6FWwnfT3yHf+doHLPsAuPDMY5O/qJcF1CHdxQ/QP7dGIY/S7PW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066564; c=relaxed/simple;
	bh=BtzTVKwyYoFq3h8BdxnfMQT0iTCdQGmFSBTocmzD1fY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R2j6ioIAx+NcCoTlUcQjWfc9a5yEK0vwDuc6SpSbRKpSlJIsZX9ASquq41CtkCQX/2+S+Yu+kHN57GpcdoMn7wkCZIPoMra9miQb+wbGzK/ui/KOgKou2muOX5rmMIMwYcrJvyqp5kwxWgrgyxa9scU1IDfX+kWC4UzGiA+4FqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d2b3882ff5so9570415ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066561; x=1740671361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wf8Jm20JDBfz5v2Jj0rJj5c2Yij2ZpEF6exwzlMhtyU=;
        b=s3W8UcGzMEbR9hfGbMArdXXKEcRpf0Pf1UvFBsmymcdIRbwd+aFKr0dnHMONxjtrSV
         SIpnoLzHe6O/6YysLXB5EbDoxiFUs8FncYz2dJgkI8HwrM9R3zO6nkC8BHQKezBAid0p
         FRHMZIRK8u2JOkglWdx9nlQ2jLr/c9YLv756zhjzPzaaxkxvpvaXC+j5/FXcdwbqFcE7
         1GbfCC0uBY/ZmymFbL5nEJygh8f9HldunAv2uZWT4wlQJY3xJ2No//QBiANWkNjAFYVS
         4P5PyaCbta+pFkTRQGvhVUUwNyUwxw8rp69jvkh5zfoBCP5utX7YTGmpUGkQEKgMMglA
         a4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXTDe1NtxRP5u2WD0sE+OCZV+GwhmQuQVsiW5tifd+kkjrPGno76zzNNzV5zjkZxIISkDTvdoHcpvoY14=@vger.kernel.org
X-Gm-Message-State: AOJu0YywlzRE87Jel3QSUyrJq2oxRo3RUtHVdYOVUjtJzSYPs/nDBK4u
	Eiyh48WSp+OJi9R0VQrauYd2CF5zR6zaOAYTyAwgPJ10F0Vmt1Jkq46YNpECh+FJQYefgkpomiK
	PYbTbGIw5Q+L8wnDN2Og5FlmUzcFYe618lg5fhq75UBm3IuPrnBH6v0A=
X-Google-Smtp-Source: AGHT+IFG+Vu3WzQSx3a0Yr35JXD7UykQ+Y2qZ7Iqihca6ZPy+CAPIcujlZCMwzVCfL79X3uBRcegGL1/bZnD+rTcmvutdH7S9wCb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2143:b0:3d1:99bd:5503 with SMTP id
 e9e14a558f8ab-3d2b536ef9dmr80148875ab.14.1740066561655; Thu, 20 Feb 2025
 07:49:21 -0800 (PST)
Date: Thu, 20 Feb 2025 07:49:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b74f01.050a0220.14d86d.02d8.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in __ipv6_addr_type
From: syzbot <syzbot+93ab4a777bafb9d9f960@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6537cfb395f3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d4a7f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cf1217edc1cc7da
dashboard link: https://syzkaller.appspot.com/bug?extid=93ab4a777bafb9d9f960
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b4a6e38bb6d/disk-6537cfb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/96b70942c42c/vmlinux-6537cfb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd3dc281a360/bzImage-6537cfb3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+93ab4a777bafb9d9f960@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __ipv6_addr_type+0xa2/0x490 net/ipv6/addrconf_core.c:47
 __ipv6_addr_type+0xa2/0x490 net/ipv6/addrconf_core.c:47
 ipv6_addr_type include/net/ipv6.h:555 [inline]
 ip6_route_output_flags_noref net/ipv6/route.c:2616 [inline]
 ip6_route_output_flags+0x51/0x720 net/ipv6/route.c:2651
 ip6_route_output include/net/ip6_route.h:93 [inline]
 ipvlan_route_v6_outbound+0x24e/0x520 drivers/net/ipvlan/ipvlan_core.c:476
 ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:491 [inline]
 ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:541 [inline]
 ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:605 [inline]
 ipvlan_queue_xmit+0xd72/0x1780 drivers/net/ipvlan/ipvlan_core.c:671
 ipvlan_start_xmit+0x5b/0x210 drivers/net/ipvlan/ipvlan_main.c:223
 __netdev_start_xmit include/linux/netdevice.h:5150 [inline]
 netdev_start_xmit include/linux/netdevice.h:5159 [inline]
 xmit_one net/core/dev.c:3735 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3751
 sch_direct_xmit+0x399/0xd40 net/sched/sch_generic.c:343
 qdisc_restart net/sched/sch_generic.c:408 [inline]
 __qdisc_run+0x14da/0x35d0 net/sched/sch_generic.c:416
 qdisc_run+0x141/0x4d0 include/net/pkt_sched.h:127
 net_tx_action+0x78b/0x940 net/core/dev.c:5484
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
 __do_softirq+0x14/0x1a kernel/softirq.c:595
 do_softirq+0x9a/0x100 kernel/softirq.c:462
 __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:389
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
 __dev_queue_xmit+0x2758/0x57d0 net/core/dev.c:4611
 dev_queue_xmit include/linux/netdevice.h:3311 [inline]
 packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3132 [inline]
 packet_sendmsg+0x93e0/0xa7e0 net/packet/af_packet.c:3164
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:733
 __sys_sendto+0x594/0x750 net/socket.c:2187
 __do_sys_sendto net/socket.c:2194 [inline]
 __se_sys_sendto net/socket.c:2190 [inline]
 __x64_sys_sendto+0x125/0x1d0 net/socket.c:2190
 x64_sys_call+0x346a/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 ipvlan_route_v6_outbound+0x18f/0x520 drivers/net/ipvlan/ipvlan_core.c:466
 ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:491 [inline]
 ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:541 [inline]
 ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:605 [inline]
 ipvlan_queue_xmit+0xd72/0x1780 drivers/net/ipvlan/ipvlan_core.c:671
 ipvlan_start_xmit+0x5b/0x210 drivers/net/ipvlan/ipvlan_main.c:223
 __netdev_start_xmit include/linux/netdevice.h:5150 [inline]
 netdev_start_xmit include/linux/netdevice.h:5159 [inline]
 xmit_one net/core/dev.c:3735 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3751
 sch_direct_xmit+0x399/0xd40 net/sched/sch_generic.c:343
 qdisc_restart net/sched/sch_generic.c:408 [inline]
 __qdisc_run+0x14da/0x35d0 net/sched/sch_generic.c:416
 qdisc_run+0x141/0x4d0 include/net/pkt_sched.h:127
 net_tx_action+0x78b/0x940 net/core/dev.c:5484
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
 __do_softirq+0x14/0x1a kernel/softirq.c:595

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4121 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_node_noprof+0x907/0xe00 mm/slub.c:4216
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1331 [inline]
 alloc_skb_with_frags+0xc8/0xd00 net/core/skbuff.c:6612
 sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2897
 packet_alloc_skb net/packet/af_packet.c:2981 [inline]
 packet_snd net/packet/af_packet.c:3075 [inline]
 packet_sendmsg+0x7722/0xa7e0 net/packet/af_packet.c:3164
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:733
 __sys_sendto+0x594/0x750 net/socket.c:2187
 __do_sys_sendto net/socket.c:2194 [inline]
 __se_sys_sendto net/socket.c:2190 [inline]
 __x64_sys_sendto+0x125/0x1d0 net/socket.c:2190
 x64_sys_call+0x346a/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6373 Comm: syz.3.101 Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
=====================================================


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

