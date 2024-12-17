Return-Path: <linux-kernel+bounces-449003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 443929F4852
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040F816E47E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABA21E1C30;
	Tue, 17 Dec 2024 10:04:28 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FB91DFDBB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429867; cv=none; b=k1CXNLhQTstOCImvY+AqjUTJNVTdSizVe6IAf12NySXI3UVKnXv9z3Qxl6WZ52lpyvSQ3ytf3He+WXE0ko+QCV+NguryKJmWVCuar6A1C+7x9z4eRa+mtmOKDIknB6CB19EcRvIWhRoVCE3LKna60Sxrh46lLySfsTRzfRpYxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429867; c=relaxed/simple;
	bh=u/uFfee2ntB4f4h9jMULT1D5I5y6vNwctt6TJ1YyS8I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T6KGdQrwK85H2jAtnyeFUQGk4mylSJ4k453NPnlA+nDrray1UN5AFfrWko/MEE1QoxjblJCTYDvnVTWsatCPspZPtwFJrQZyPallbNXDUKo1r8VNMNN2UZtmKfX+ho6Ec0JZkPry7COezj9e2AKtu4KYDo96Rkc0q9vC5Mr6U/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7de3ab182so107670805ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734429865; x=1735034665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/RiBRtj7P3fN4gpoLCAxlF19YFC9iNzYx9lorZws/c=;
        b=rIhbuvbcxsYiI6NIzlNYHyHmUdS1RK1WowpNKvn0/UTrI7UX3P467pN62m2t4EoNGF
         Vey9pniQt8s95wZBl5NxzRoxhMyv4rPttH/yZ2tYBzabiK+ad3xGsrBETL1UgmLJJHTF
         /ybN5bXRrrK/gvv+U6I7qlDvRIcPVibc48b/5BKzpuzmaeA+PGNMpHwb0A3uVKxeI0EX
         uLm343Lja8IveTdp+3fcNYHp2P6GI4cr5VkEwNP6joUC9scsNlmxa71YBXhvM/vpxd93
         FNdajxm2v8ckCczX+sRUkJNh678UZNra4qawpktvAIgPHttqePVTmukaoyoRdMQ4ilHX
         u+pw==
X-Forwarded-Encrypted: i=1; AJvYcCX1HjWbaLco5AHRaIcKZePNYqmtq8g79Hud2SqNZTO9v2wgbWFp8cBWeZoTP1QBFBG4dphjakBgL/kr8sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTirJbG+n7o/p4NvsSZcXPQX9XpfcSs5PeOLiw5NAKZKSIRYTz
	fM6f0aqLsvWIfd4Ihndvp7TUEHUbZ98z4sU8IBmXjp6HjKYbpc9PtYhVaQbcu2bCfPBnCVLQyGk
	YSav2Ct3ZuHG7sziWG5PZz6xECsnf4HUyN4GN802Z51T6P1khH3gddzg=
X-Google-Smtp-Source: AGHT+IECkkJkFkWOAwA6L9TdB5U20mq6yNiLsl0CDumrdUECtpzRdtA3CBYqNxQT77ByIrpgCd+mdyVsCN8ohxbYfLJ25oy4FLYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a45:b0:3a7:6f5a:e5c7 with SMTP id
 e9e14a558f8ab-3aff461ad34mr139327615ab.4.1734429865343; Tue, 17 Dec 2024
 02:04:25 -0800 (PST)
Date: Tue, 17 Dec 2024 02:04:25 -0800
In-Reply-To: <6729a011.050a0220.2edce.1501.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67614ca9.050a0220.37aaf.0160.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in geneve_udp_encap_recv
From: syzbot <syzbot+c28dd30bc14158282b3b@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f44d154d6e3d Merge tag 'soc-fixes-6.13' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e95730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f1586bab1323870
dashboard link: https://syzkaller.appspot.com/bug?extid=c28dd30bc14158282b3b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133e8b44580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fa4744580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-f44d154d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d57bbc97217e/vmlinux-f44d154d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/345444afe36f/bzImage-f44d154d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c28dd30bc14158282b3b@syzkaller.appspotmail.com

memcpy: detected field-spanning write (size 8) of single field "_Generic(info, const struct ip_tunnel_info * : ((const void *)((info) + 1)), struct ip_tunnel_info * : ((void *)((info) + 1)) )" at ./include/net/ip_tunnels.h:662 (size 0)
WARNING: CPU: 2 PID: 5932 at ./include/net/ip_tunnels.h:662 ip_tunnel_info_opts_set include/net/ip_tunnels.h:662 [inline]
WARNING: CPU: 2 PID: 5932 at ./include/net/ip_tunnels.h:662 geneve_rx drivers/net/geneve.c:244 [inline]
WARNING: CPU: 2 PID: 5932 at ./include/net/ip_tunnels.h:662 geneve_udp_encap_recv+0x239e/0x2a20 drivers/net/geneve.c:401
Modules linked in:
CPU: 2 UID: 0 PID: 5932 Comm: syz-executor272 Not tainted 6.13.0-rc3-syzkaller-00017-gf44d154d6e3d #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ip_tunnel_info_opts_set include/net/ip_tunnels.h:662 [inline]
RIP: 0010:geneve_rx drivers/net/geneve.c:244 [inline]
RIP: 0010:geneve_udp_encap_recv+0x239e/0x2a20 drivers/net/geneve.c:401
Code: 2b e9 ff ff e8 d3 37 4d fb c6 05 cb 02 fb 09 01 90 31 c9 48 c7 c2 a0 e7 14 8c 4c 89 e6 48 c7 c7 80 e8 14 8c e8 53 72 0d fb 90 <0f> 0b 90 90 e9 54 ed ff ff e8 a4 37 4d fb e8 4f 30 c5 02 31 ff 41
RSP: 0018:ffffc900037bf450 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888035210062 RCX: ffffffff815a5079
RDX: ffff8880232f0000 RSI: ffffffff815a5086 RDI: 0000000000000001
RBP: ffffc900037bf570 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000008
R13: ffff88802cbfda00 R14: 0000000000000000 R15: ffff888024a2fb80
FS:  0000555562a2b380(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200002c0 CR3: 00000000230b2000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udp_queue_rcv_one_skb+0xad5/0x18b0 net/ipv4/udp.c:2316
 udp_queue_rcv_skb+0x198/0xd10 net/ipv4/udp.c:2394
 __udp4_lib_mcast_deliver net/ipv4/udp.c:2486 [inline]
 __udp4_lib_rcv+0x25c4/0x34e0 net/ipv4/udp.c:2625
 ip_protocol_deliver_rcu+0x2ff/0x4c0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x316/0x570 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:447 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_rcv+0x2c3/0x5d0 net/ipv4/ip_input.c:567
 __netif_receive_skb_one_core+0x199/0x1e0 net/core/dev.c:5672
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5785
 netif_receive_skb_internal net/core/dev.c:5871 [inline]
 netif_receive_skb+0x13f/0x7b0 net/core/dev.c:5930
 tun_rx_batched.isra.0+0x3eb/0x730 drivers/net/tun.c:1574
 tun_get_user+0x2a16/0x3e40 drivers/net/tun.c:2007
 tun_chr_write_iter+0xdc/0x210 drivers/net/tun.c:2053
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f293ab4f920
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 81 e7 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffff606d388 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffff606d410 RCX: 00007f293ab4f920
RDX: 0000000000000048 RSI: 00000000200001c0 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 00007ffff606d3b0 R14: 00007f293ab9e140 R15: 0000555562a2b338
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

