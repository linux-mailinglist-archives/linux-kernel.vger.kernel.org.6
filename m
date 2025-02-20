Return-Path: <linux-kernel+bounces-524360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA6A3E206
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC9B7A072F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ECB215055;
	Thu, 20 Feb 2025 17:14:26 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C21B0F33
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071666; cv=none; b=fQZAHVL5zm8wh+mIFsZb6nPy+NI02zwLQFSvBtWJirLJIY2ooSdNLBsyIy6FizdVBxIey0UiygUtB+/BLjrepK4OwXFAJH2sFuX8F0NwB8Z4dEg3c6C/yhEdyKdcqRTdmMR/7oBQpw8ZT74xcQ2jn1aa6lqDe4u9WU5yBdAaSus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071666; c=relaxed/simple;
	bh=igE47N6rb90fbi7jP/FYjggnIIIz98KFKnJXLr5mDJg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g5SYtrhs4qghv19oVqP9h/U5ZbhWzviGbn+7UwP+V99Ob9YfTDx79VG8j2ZZtVmlWZE5j5G4N0IuLVVTt+4YltwOhTP9AUgSGHb3PJJSeLy55GXVLgI7r5n5HAh00T8+G3Z4GX7/t2g/Q94nTpKOTA+RUh2+heEDbdsl4kXN/fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d2b6d933baso25733215ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740071663; x=1740676463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxzcrVz1DPpv4NyrxYkFgPqltPj5eMB8f6b7VADP8sk=;
        b=ilKQq4pZuOOq0HYE8FluBQssym8t8SwOLN7Fo0PnqFVBONn6+4DzSviuXe0qdvoiAw
         7T72aN44ATyoZf9+iN0CNK4eU+cqM+TTSeUbS1fhPMU9kqY+VhreopTZN32zZUFYHuxv
         nDNfjXxYxsWI0CpBTc67+zb6bo2kACbgvYhYJrRRCL15MeFX7l/YtUJnLwGIVPud5oI3
         1szjdyktOCIcssY4PM1RUEi6qAiSt/9/Zqo7QW61PoRp4tHKe/W1gy68to0fd/1BKbt3
         ksUIFnx7NmqN2GCNmvonPtMAsAAJQDAX/qSe6k5FOmDqhL5Am52mT6CTUDKmx3k3HMgo
         WvXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgUsKhXt/5kC+aOIPh5WI2MVuG18xAnUCliLtK9ORP5A6lN0Wo1/MIYgTSk+Aer7OlPODbP6T/QPBIHfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywng47sP14lLweIWhY66BwWpBITniGyDGFeOl6csABdRNOH7upi
	skUeSswypP9K36CKF44CsX1h6U2gnfSloGJtrDAyucKpSj8spGg66OVemRa9ORHkJ6+J1yJklEG
	L5XCZIlsP2K/36t+cb2PxtMPw93Dpctga6ud9hpSUTpjgRTwptuZlCCo=
X-Google-Smtp-Source: AGHT+IHdXIvN5gk3IYimZXexLjyS93xdfjq7LCu1lRf+/DKhODBCEWR9bWtFLZG+xnGrQefsB4cvF1v1Idcsx67jq+mxzA27VOnR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1849:b0:3ce:8ed9:ca94 with SMTP id
 e9e14a558f8ab-3d2c25deed3mr34038625ab.14.1740071663454; Thu, 20 Feb 2025
 09:14:23 -0800 (PST)
Date: Thu, 20 Feb 2025 09:14:23 -0800
In-Reply-To: <67b74f01.050a0220.14d86d.02d8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b762ef.050a0220.14d86d.02f0.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __ipv6_addr_type
From: syzbot <syzbot+93ab4a777bafb9d9f960@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	eric.dumazet@gmail.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, maheshb@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    87a132e73910 Merge tag 'mm-hotfixes-stable-2025-02-19-17-4..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=109a5498580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cf1217edc1cc7da
dashboard link: https://syzkaller.appspot.com/bug?extid=93ab4a777bafb9d9f960
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125b75b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14433ba4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/21aef40bc697/disk-87a132e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d449987c6c11/vmlinux-87a132e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/14c5f26d8765/bzImage-87a132e7.xz

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
 __dev_queue_xmit+0x366a/0x57d0 net/core/dev.c:4584
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
 __dev_queue_xmit+0x366a/0x57d0 net/core/dev.c:4584
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

CPU: 1 UID: 0 PID: 5864 Comm: syz-executor285 Not tainted 6.14.0-rc3-syzkaller-00079-g87a132e73910 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

