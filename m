Return-Path: <linux-kernel+bounces-429801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E779E25AD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B576C1604CC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116EF1F76AC;
	Tue,  3 Dec 2024 15:58:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3F1F76AA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241485; cv=none; b=Ous7jk75QDw4i3cPvpA/1PRattV6C+Gi0nherJEkKXbRK/qwiI5rFmiE5utHrId+Hk9zGpofbpsLT6+1tbAW2Qh3eLuiog8zfiQ8LpUCWH6vOgl6ZfqzUHxegoRPbRODSuOsZqKlAX1k0LdsbP6/7JqVsSx2jTJEq8FsrRTz83c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241485; c=relaxed/simple;
	bh=Bq2N3wTRYd+jba+incS8JMqehLWkbZClmloZZc4NU9E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A1wSiojywxilVFJ5WyVxQMHw27OwLVpQyGKwsGqIDD2W0hX8eTXtZhGZNaYbe/kJE2ZtHtcEx15O4BXAjo7WhVeUiRLHBbBngEWh1Ls5z8ZOoyyNkkjcjHfywlUo/iThh//vWT2R0yAZp429i8taYIRQpW7hhU2T7V4hBscsvY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7de3ab182so61721585ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733241483; x=1733846283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaG8YugceXIEOIvkveTaeBEJAokrs9rUT7WfrD18L5w=;
        b=FtbsA2QsbA5iqmsBEHGDTMOc/p6IKUFAzvmJMp/phaY9G1PBJpvpTvJ/dsb+oXWajL
         T+dxwpFbMzVgeLDaHssToCWePPOkh+X5VldG01y4LTfaiU5gd5OyYkvWpixtuhkqaou4
         rC+YRNeQMJeLIGHh/ZoczDfA0zUyfHKvKufiJFlMG+k0GFCqjhBLWXpoe30xPQGRVBbI
         ehY1y5D/hX0AFkZrTqnEIxKIrzZEGGmg5MNHxqhVC9AhtdpGo5FWnmmnPmfhwuEAilY4
         mQsTf/DYYSVKzq59THv5WIAIkNeSPMRL3NwYeHNnRsCtUn6S4PilOl4F3KZHKQV1jgmO
         f70Q==
X-Forwarded-Encrypted: i=1; AJvYcCWESTZKxMlVKlCOcbqXZbSvoFjE19OX6aE56+5fgnffkSuWdnjLVAPHuXGu4sSWPRU8YX8w0xhvXsmpnv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnvZcJ8JZWcUA6EIQM/1zEGrB6BzYAkvGpBs9hZs76J6fJ5oG
	8pctYZM0cOxpT8GeFwnZR/Dg4HQ7QY52fsNh2aISL7rO3h1RrM66wPTkk69SDvrzfYO1uJE/oV1
	mXpGdDkvd/0TyhyCK2c/GRbea3CEZbZMdmC4fVQTUGEVnG+O1ZVXxW3U=
X-Google-Smtp-Source: AGHT+IFprb7v7LlezJWusw++daBvSFJWY8cOQ8lUtyW9Q7e8VY/Dj75ZRogcYikS3HQY5ndDSpjVv8hKDAhIsnASycxHc5RsjtrQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa5:b0:3a7:81a4:a557 with SMTP id
 e9e14a558f8ab-3a7f9ab2850mr35202435ab.24.1733241483101; Tue, 03 Dec 2024
 07:58:03 -0800 (PST)
Date: Tue, 03 Dec 2024 07:58:03 -0800
In-Reply-To: <20241203152813.9_NZw%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f2a8b.050a0220.48a03.003d.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] KMSAN: uninit-value in ip6table_mangle_hook (3)
From: syzbot <syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
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
 slab_post_alloc_hook mm/slub.c:4110 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_node_track_caller_noprof+0x945/0x1240 mm/slub.c:4302
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

CPU: 0 UID: 0 PID: 6621 Comm: syz.0.15 Not tainted 6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


Tested on:

commit:         cdd30ebb module: Convert symbol namespace to string li..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15bcf0df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46e22a9795a5542
dashboard link: https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16eb6fc0580000


