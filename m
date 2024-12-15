Return-Path: <linux-kernel+bounces-446238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC8C9F2196
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 01:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858C71885C78
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 00:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D4A1FDD;
	Sun, 15 Dec 2024 00:28:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85415C0
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734222485; cv=none; b=YmSADSNayiLVKHf8zpjVRRWzUGWlnhZ47vN0yd7BxfCYBYEy1J7SMPND+rpBPGKpKBKoLQyEP91jEEXiNBQSXOZKwnJ/YnS4pjSoUeKbELlLznpyF1xP9dpCZ8sdShPbEsTgGHYDeWZbNAhsUL1lwx08nCDwrLQonpD0lc7xLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734222485; c=relaxed/simple;
	bh=0tPBbNN6LtDc+DXidEzKcuqWD3DGnD2Hd3m9InHtYSA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e9nL0uEByI4jBwI1A5ZVCAe39/WA79aHyOK515QpHHzOb1gw8/uPT3af/zLMjkb4SX6fo5PyJLv5Yui16osgmE1VJMiFdj0j4vRICnq0qqPCoiqHd+KThNPjxEH9oNzLkFB3OAw1aauRmyOjfnv4zffHtaENtQg5cZEh9bymYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7e4bfae54so29094735ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 16:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734222482; x=1734827282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVLLjVk50PuPmV+2XaaCaMLDde0KwvSVKVmde9TwDVo=;
        b=WDBUEp3i6W8BGvnmOJlQcRiZjMHdrlipNuWvlHXdHFptUwF2Yq9qSWz5ktddkkNwaG
         UBTr/780GlyRECc/somC9wS21JVwoMWmbjRtQ7b2xbitLRP8eux2gKtn8EpX/Z8Exdwg
         041LyWURVHfkW7Nv21o5pdDrzJas9D81M4XZYE2Kp25T87GeRjivqT1co5E7nrUoESyn
         cEaGzeOFmeEWHsCojlzX+luGZWs49jWW6J19WrZ4d35PIZ1lHLw+5Qej4dvMImb7KwNM
         fg1sEFqbKxbUsGuM6ukLYVT+7Av19OSaFO1gvjj+lbUnUxXHidctVUPGj3UNOuNe3i1G
         PIKQ==
X-Gm-Message-State: AOJu0YyZ8CcnTVuc6Uw0CksvQK0AJerJnlJ/xTjm7M91XI8f6GeFrHZm
	3LTVQNG3zJvoM2u+EdYTape8zF/c9ROk5aGu2jx2Udq9XgF9UQeDpbS7DeEoOAHbqflTAfY6Nuv
	PgGm9x+zSRwPvfaKuGdwQDvtO9FkHYDSM5CUOmUkYTvq0wkKvLDw0HKA=
X-Google-Smtp-Source: AGHT+IH9isbiZxVXZD6T8gGucCuT4xbYcATVGATHnRD8ROoK3smhf47/z4DH9GJVKkBAoGHYQOiktvflE4W9WcceEMPK4AaK5CDt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:310d:b0:3a7:fe8c:b015 with SMTP id
 e9e14a558f8ab-3aff925703cmr92718895ab.24.1734222482710; Sat, 14 Dec 2024
 16:28:02 -0800 (PST)
Date: Sat, 14 Dec 2024 16:28:02 -0800
In-Reply-To: <D6BRVBRSQUKU.156D85K99VIYJ@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e2292.050a0220.37aaf.00df.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] KMSAN: uninit-value in ip6table_mangle_hook (3)
From: syzbot <syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in ip6table_mangle_hook

=====================================================
BUG: KMSAN: uninit-value in ip6t_mangle_out net/ipv6/netfilter/ip6table_mangle.c:56 [inline]
BUG: KMSAN: uninit-value in ip6table_mangle_hook+0x97d/0x9c0 net/ipv6/netfilter/ip6table_mangle.c:72
 ip6t_mangle_out net/ipv6/netfilter/ip6table_mangle.c:56 [inline]
 ip6table_mangle_hook+0x97d/0x9c0 net/ipv6/netfilter/ip6table_mangle.c:72
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xf4/0x400 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 __ip6_local_out+0x5ac/0x640 net/ipv6/output_core.c:143
 ip6_local_out+0x4c/0x210 net/ipv6/output_core.c:153
 ip6tunnel_xmit+0x129/0x460 include/net/ip6_tunnel.h:161
 ip6_tnl_xmit+0x345d/0x3900 net/ipv6/ip6_tunnel.c:1281
 __gre6_xmit+0x14b9/0x1550 net/ipv6/ip6_gre.c:815
 ip6gre_xmit_ipv4 net/ipv6/ip6_gre.c:839 [inline]
 ip6gre_tunnel_xmit+0x18f7/0x2030 net/ipv6/ip6_gre.c:922
 __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
 netdev_start_xmit include/linux/netdevice.h:5011 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3606
 sch_direct_xmit+0x399/0xd40 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3827 [inline]
 __dev_queue_xmit+0x30b9/0x57d0 net/core/dev.c:4400
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3146 [inline]
 packet_sendmsg+0x91ae/0xa6f0 net/packet/af_packet.c:3178
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 __sys_sendto+0x594/0x750 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0x125/0x1d0 net/socket.c:2200
 x64_sys_call+0x346a/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 ip6_tnl_xmit+0x3584/0x3900 net/ipv6/ip6_tunnel.c:1277
 __gre6_xmit+0x14b9/0x1550 net/ipv6/ip6_gre.c:815
 ip6gre_xmit_ipv4 net/ipv6/ip6_gre.c:839 [inline]
 ip6gre_tunnel_xmit+0x18f7/0x2030 net/ipv6/ip6_gre.c:922
 __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
 netdev_start_xmit include/linux/netdevice.h:5011 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3606
 sch_direct_xmit+0x399/0xd40 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3827 [inline]
 __dev_queue_xmit+0x30b9/0x57d0 net/core/dev.c:4400
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3146 [inline]
 packet_sendmsg+0x91ae/0xa6f0 net/packet/af_packet.c:3178
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 __sys_sendto+0x594/0x750 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0x125/0x1d0 net/socket.c:2200
 x64_sys_call+0x346a/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4125 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_node_track_caller_noprof+0x945/0x1240 mm/slub.c:4317
 kmalloc_reserve+0x23e/0x4a0 net/core/skbuff.c:609
 pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
 skb_realloc_headroom+0x140/0x2b0 net/core/skbuff.c:2355
 ip6_tnl_xmit+0x2106/0x3900 net/ipv6/ip6_tunnel.c:1227
 __gre6_xmit+0x14b9/0x1550 net/ipv6/ip6_gre.c:815
 ip6gre_xmit_ipv4 net/ipv6/ip6_gre.c:839 [inline]
 ip6gre_tunnel_xmit+0x18f7/0x2030 net/ipv6/ip6_gre.c:922
 __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
 netdev_start_xmit include/linux/netdevice.h:5011 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3606
 sch_direct_xmit+0x399/0xd40 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3827 [inline]
 __dev_queue_xmit+0x30b9/0x57d0 net/core/dev.c:4400
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3146 [inline]
 packet_sendmsg+0x91ae/0xa6f0 net/packet/af_packet.c:3178
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 __sys_sendto+0x594/0x750 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0x125/0x1d0 net/socket.c:2200
 x64_sys_call+0x346a/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6553 Comm: syz.0.15 Not tainted 6.13.0-rc2-syzkaller-00333-ga0e3919a2df2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
=====================================================


Tested on:

commit:         a0e3919a Merge tag 'usb-6.13-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16813cdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f52f17eef5016d2
dashboard link: https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

