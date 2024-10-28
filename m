Return-Path: <linux-kernel+bounces-386070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F99B3EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE306283AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B41B1FB89D;
	Mon, 28 Oct 2024 23:57:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061C1DFDB9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159844; cv=none; b=BPjlZxD049pOQ0ON85U49AG/8XvCITiuoFUJ2ICqZ+k+4HyKKNafOh4K7FnAeYeAZlWxpF8nQznsoiGwY7WK8kAkOshLB0hWn0hWSxVUVe420dCrQQCn4rCqV254xTgm1u/Te+oYVD4KNuS8h6xIZ3AUcyWDEi9msxSSXXmshLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159844; c=relaxed/simple;
	bh=JSAgChZeD4Eb9IozTJE80b3eyOBu7xOBALYknD+8rkQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c0TW+OzsqT9vjEsHL57o/lwxyL8IvfCKvi9gVdWAFtd9RmFokGd5uE8dMDR6/eFbpCjnTObCuKIaWZo3QoAWKlnv1HfrNpQc7YdmgN9/Rk3q6TMHsun6plGMIee5A7WNpK3KgckuKPAT4O6TtoJCptPj6FmhPV9cI7pcofNCy5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4f113d2c8so22810225ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730159841; x=1730764641;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnvBNJ94FOi5B5HFHo9/CsJQbRxCRr0sZ6M9tNoPcrI=;
        b=BquFJCHuHqTX+s87PNbwlS3jxinOCZOLm0gQPA1Zl7/KmbelC3Vk+1bpsOZaEM0cea
         GNlke4iD9axs1TPfta1Ox1Hm6SSyxmbgPbYFZdbrv2hnrhGSTw8JqKbdyXHV9Bhv0Lxk
         0hhYp+9BJgL/PatI67nhMiePr8KnQp/HSEfV2lRVhz3blLzQOo89LksDppGJOUmk2gtC
         o9wEWsY+V1irx2v+5+C0bDqW+IzAM/5ha8g74gStffvXqDzIF6aDMXx781Zo2FP6VPvp
         vQV7hGfyuWMCkWUHLFzKvhmkHloAyhD4coEgAYOOwrIjWRKZ4+Hksi4afRGbTfrpcpGM
         rlTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI+94Xq78TSn+WTIjYasTAPM82GoSztCxaxceC2333vzzloNpfLeGb/V9t7w6VNpAoBSHRRpr9YYXeNTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAxnbMNIfDzIBUTwsyC/TfiKYO5BcGngfIeOTnghTW+RPZP4D2
	ezAPCjHft4C1WyxiefNRVKSimyv1SyeW8vk39wASW5xs7X8E0BaaeXlH6RBbyEms07IH3qsU93/
	99eBV3oeSAD/1fkFiZBGRI7UUtnAdAm8ePs58I7xraOzAFsQltXJFrx8=
X-Google-Smtp-Source: AGHT+IHmbQm1FfjPhMFLh6Itg5JiirSNsMI9Ut/PpvACE/Gl5hXO1q/6lII1qUk3DDqmozVtfdIrtSYETil57NqA6wgVi++H3FyL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1528:b0:3a2:7651:9846 with SMTP id
 e9e14a558f8ab-3a4ed295a05mr89773055ab.13.1730159841172; Mon, 28 Oct 2024
 16:57:21 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:57:21 -0700
In-Reply-To: <00000000000044832c06209859bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672024e1.050a0220.11b624.04b7.GAE@google.com>
Subject: Re: [syzbot] [sctp?] KMSAN: uninit-value in sctp_sf_ootb
From: syzbot <syzbot+f0cbb34d39392f2746ca@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    819837584309 Linux 6.12-rc5
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1211e940580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d4311df74eee96f
dashboard link: https://syzkaller.appspot.com/bug?extid=f0cbb34d39392f2746ca
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11eb3230580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f36ca7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dfa054090a8f/disk-81983758.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/54edfdbd151e/vmlinux-81983758.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d63a317b80f9/bzImage-81983758.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0cbb34d39392f2746ca@syzkaller.appspotmail.com

syz-executor341 uses obsolete (PF_INET,SOCK_PACKET)
=====================================================
BUG: KMSAN: uninit-value in sctp_sf_ootb+0x7f5/0xce0 net/sctp/sm_statefuns.c:3712
 sctp_sf_ootb+0x7f5/0xce0 net/sctp/sm_statefuns.c:3712
 sctp_do_sm+0x181/0x93d0 net/sctp/sm_sideeffect.c:1166
 sctp_endpoint_bh_rcv+0xc38/0xf90 net/sctp/endpointola.c:407
 sctp_inq_push+0x2ef/0x380 net/sctp/inqueue.c:88
 sctp_rcv+0x3831/0x3b20 net/sctp/input.c:243
 sctp4_rcv+0x42/0x50 net/sctp/protocol.c:1159
 ip_protocol_deliver_rcu+0xb51/0x13d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:449
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core net/core/dev.c:5666 [inline]
 __netif_receive_skb+0x319/0xa00 net/core/dev.c:5779
 netif_receive_skb_internal net/core/dev.c:5865 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5924
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1550
 tun_get_user+0x5783/0x6c60 drivers/net/tun.c:2007
 tun_chr_write_iter+0x3ac/0x5d0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xb2b/0x1540 fs/read_write.c:683
 ksys_write+0x24f/0x4c0 fs/read_write.c:736
 __do_sys_write fs/read_write.c:748 [inline]
 __se_sys_write fs/read_write.c:745 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:745
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 alloc_skb_with_frags+0xc8/0xd00 net/core/skbuff.c:6612
 sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2883
 tun_alloc_skb drivers/net/tun.c:1526 [inline]
 tun_get_user+0x20f4/0x6c60 drivers/net/tun.c:1851
 tun_chr_write_iter+0x3ac/0x5d0 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xb2b/0x1540 fs/read_write.c:683
 ksys_write+0x24f/0x4c0 fs/read_write.c:736
 __do_sys_write fs/read_write.c:748 [inline]
 __se_sys_write fs/read_write.c:745 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:745
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5818 Comm: syz-executor341 Not tainted 6.12.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

