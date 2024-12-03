Return-Path: <linux-kernel+bounces-429614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6F49E1EBA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95460B2D90B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AA31EE006;
	Tue,  3 Dec 2024 14:02:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE81E3789
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234524; cv=none; b=HjpXLEBpzCGiBiSUk0Nt4XHo+zlymfPEJf0fqVcwU2O7id2xyl1lWNQ6IYcCehS3pOvUYs3N5T6DBv4I+aaoOWcdyIrf8oaQjTbR2SpkA4Z3wHgEg9rDwaCMyUf0niYcdbUTSQibleOTdIrvPq35p3diR2su2g4BNvGBXwk/Sz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234524; c=relaxed/simple;
	bh=E8u1TWWdZJl4M3l4V1IzawFUuuZpnrjf6FeSelEyiXg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VNDkbmhJCTnHdKW2wjNEX1urFBFjx+XrG4Ol04DRsrLN5Mr68lMmE45DU7XJT4F/WSxLnNkli2y3fXzE04u+7yPIDgIWOzjLdkL5LF922xpzJOlqgDwRkzrM1IC/EE/zfWy4MGjag3MlSeP4Igmu00YtjYsGSfKiO90kKCkQKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7c8259214so60886765ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234522; x=1733839322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf59iyNYHTQYltYoXI56oW7ioX5QddlZC/ej7xq/2/Q=;
        b=mLVgwMalb+iyPPKl0U5N/ZTFQwDq3UhoeDUxRVCbzEKdCdtEUvNHD4GMa3xodcJQs7
         uLAjI604Fupgn3uJjm0ACs7N29Mt5iylZ57KtN8V4IQOHs+A7Mq19u9vlxkS+Z/e965E
         WKntqnqTyAiBUV9OF8xOClsz3Bdx8KsNVxLIjXHKf0aHIOGXbzH6INdEpAjgmVfxMNpe
         Sp6uw0A+ByaINXj/QbotDXCRkqiVc4RYysGEQUhDhe0f71RVm6m5XlaEyKnMBVT27e27
         Zhv/AgBqNfDAwUZu03XcigRgoMzLKR6ZMU0kYcf6q/pimumrvpt1oLIAkPatbGfy+Z8O
         +QAg==
X-Forwarded-Encrypted: i=1; AJvYcCWO7cvziiwLJ3vnlm0PBcaajAe+1tuwEyGVuUVikE+JwXmN0JVSHMyb/bbfbmOpG3jVCMLH0lI5m1m4TGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyUMm5KTzxoMlg4+KB1Yk95Nw8F+s3m/Ds1SpXU963GyYLQ2s
	nx+vb5ax2dAh5ETiR0iSqpTQkMChVknlkWg6a2lyUvv3XWLEHYq/0THUq/HraXiazU+sCX3+FWZ
	BVtbuLPvs9BoxsLB+tDS4I/LhJKo6ML9H2b0oisrXx5QjsSQN5T7FS/Q=
X-Google-Smtp-Source: AGHT+IF+UuKL6g5PomTXVc4N17NT/oIZMMnvEgBecGNHdkkkN7/bvCdTD7aCLyxYbnIBgEe1zDLlCe+N8f38rwIQO7rh1Tx1y2n1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2603:b0:3a7:fd5a:8b8a with SMTP id
 e9e14a558f8ab-3a7fd5a8d3amr12427785ab.12.1733234521810; Tue, 03 Dec 2024
 06:02:01 -0800 (PST)
Date: Tue, 03 Dec 2024 06:02:01 -0800
In-Reply-To: <20241203132852.9HSi0%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f0f59.050a0220.17bd51.0046.GAE@google.com>
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
 ip6_tnl_xmit+0x3526/0x3980 net/ipv6/ip6_tunnel.c:1283
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
 ip6_tnl_xmit+0x3657/0x3980 net/ipv6/ip6_tunnel.c:1279
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
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 skb_copy_expand+0x1f6/0x1090 net/core/skbuff.c:2499
 ip6_tnl_xmit+0x2191/0x3980 net/ipv6/ip6_tunnel.c:1227
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

CPU: 1 UID: 0 PID: 6676 Comm: syz.0.15 Not tainted 6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


Tested on:

commit:         cdd30ebb module: Convert symbol namespace to string li..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=135ec0f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46e22a9795a5542
dashboard link: https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145b75e8580000


