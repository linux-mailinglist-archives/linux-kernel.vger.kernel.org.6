Return-Path: <linux-kernel+bounces-552168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FFCA57673
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EE917906D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FF714B086;
	Sat,  8 Mar 2025 00:01:26 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F26FBF
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392085; cv=none; b=hBEX1e5OFnJEZil5KvEw06eBHDHX+V30bOra8X70FDdTi2H6yTGmI9apb/lVSIN87kfxcL29msRPFxfsu0v/Oyx+vwCy+9wyq7xaRl/AAwNXDeEfL9MLls4sgfuTJip5e6BWEiDt8FGby6lndBtYEz3ua+ZRp3/I6LxdEFdGXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392085; c=relaxed/simple;
	bh=fz1nK46pFYnMhlF2+BNxIg87IvvPu6orE2AvipFlJiA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AnNWPsoqgr7x2HHB0SpQ5vl5eBPf2sxngucbn/n6aSLYx/9ebYeF3YJcziZPjEF+A+WvFcel3JB2Rq/4VUyJ29IgfSPqO5iKnC/jOHoDws5v9Cvz3ymemB9UmLB3/jQdeRBzdq6smF3pxw/yUBaHxjrbPU7lMVHQNlOXUKW1tgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85aef819601so510413939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 16:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741392082; x=1741996882;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vkzX2jZY3i9fq06qmBpkNfr2Pob81IJ9KiDRVpOA3Dw=;
        b=VUVs3uXqKXQyQe3nSZYbb8mDomiu/A7bulHyDiW/rXeGqkAkfjw25roEgmn55FZ0Lb
         mj03tfWt9i6gtC7UnuTNTRaSatvxa7bBETLN7ZpzdKjPSsXiA2U6TMEqZzg3Mh3rz7l5
         ShcKKJfU21GX9JQGeMbDgHXNfAVlGRazSMHO6zrE9kBoUE9O4ByJBS59q/052iy6J9pc
         52PbagkDKHfsbo2oKYHHe3X82Q2xokUJqeVu3T3Ag4clGaaoLyCuFFLX2jJ7H62yf2Ct
         C8Jur2ynzhKNr01VhR70DtAAySpFj6xgKphDzihZIhrE5fm7Pr3Fc3yefWI2cz/cmb8i
         z9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdv0Nca9oWddjK1nItOwU9sIw0fvDY2tjKBHz32P5AjYEkEK0MtGKYjZ3OLuYzCbN5PHSyCu23lFcDJp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY82r6spV2BKM3dbSY7Uxhogr3GkZK24BAVHdoK6G+SX0EUPva
	y7uMENVxirBJ1th4mnVoB1IzS9hsf/I0c4366lXfrxh14+TXPsWnGQEt4jpBa0nX39wzf+TEPX7
	B9JMaBLphckxjjRRFimtfWl17E6yOwC3f/KymjIOhzlS7tuwqLM7W35Y=
X-Google-Smtp-Source: AGHT+IEWpPUhIjJy2F84jIIeuQMtopJdFGWux5rJRE6VGWshbOnX4Z3R4+9QeBVMTaaL0uhEDpBiIHDEAlyj/rzMLuydDRPCPlz4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11:b0:3d4:35d3:87d3 with SMTP id
 e9e14a558f8ab-3d44187b8b4mr70256235ab.4.1741392081958; Fri, 07 Mar 2025
 16:01:21 -0800 (PST)
Date: Fri, 07 Mar 2025 16:01:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb88d1.050a0220.d8275.022d.GAE@google.com>
Subject: [syzbot] [netfilter?] WARNING in dev_setup_tc
From: syzbot <syzbot+0afb4bcf91e5a1afdcad@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    865eddcf0afb Merge branch 'mlx5-misc-enhancements-2025-03-..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12fcc878580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbc61e4c6e816b7b
dashboard link: https://syzkaller.appspot.com/bug?extid=0afb4bcf91e5a1afdcad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/15388530d696/disk-865eddcf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfd22998e59b/vmlinux-865eddcf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ecc6b8f2a90d/bzImage-865eddcf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0afb4bcf91e5a1afdcad@syzkaller.appspotmail.com

------------[ cut here ]------------
RTNL: assertion failed at net/core/dev.c (1769)
WARNING: CPU: 1 PID: 10093 at net/core/dev.c:1769 dev_setup_tc+0x315/0x360 net/core/dev.c:1769
Modules linked in:
CPU: 1 UID: 0 PID: 10093 Comm: syz.2.1168 Not tainted 6.14.0-rc5-syzkaller-01096-g865eddcf0afb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:dev_setup_tc+0x315/0x360 net/core/dev.c:1769
Code: cc 49 89 ee e8 dc da f7 f7 c6 05 c0 39 5d 06 01 90 48 c7 c7 a0 5e 2e 8d 48 c7 c6 80 5e 2e 8d ba e9 06 00 00 e8 3c 97 b7 f7 90 <0f> 0b 90 90 e9 66 fd ff ff 89 d1 80 e1 07 38 c1 0f 8c aa fd ff ff
RSP: 0018:ffffc90003b8eed0 EFLAGS: 00010246
RAX: 587f1d6754f87800 RBX: 0000000000000000 RCX: 0000000000080000
RDX: ffffc90010d68000 RSI: 00000000000049c3 RDI: 00000000000049c4
RBP: ffff8880250f8008 R08: ffffffff81818e32 R09: fffffbfff1d3a67c
R10: dffffc0000000000 R11: fffffbfff1d3a67c R12: ffffc90003b8f070
R13: ffffffff8d4ab1c0 R14: ffff8880250f8008 R15: ffff8880250f8000
FS:  00007f58e67f66c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000030ed6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nf_flow_table_offload_cmd net/netfilter/nf_flow_table_offload.c:1178 [inline]
 nf_flow_table_offload_setup+0x2ff/0x710 net/netfilter/nf_flow_table_offload.c:1198
 nft_register_flowtable_net_hooks+0x24c/0x570 net/netfilter/nf_tables_api.c:8918
 nf_tables_newflowtable+0x19f4/0x23d0 net/netfilter/nf_tables_api.c:9139
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:524 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:647 [inline]
 nfnetlink_rcv+0x14e3/0x2ab0 net/netfilter/nfnetlink.c:665
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f58e898d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f58e67f6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f58e8ba6160 RCX: 00007f58e898d169
RDX: 0000000000000000 RSI: 0000400000000300 RDI: 000000000000000c
RBP: 00007f58e8a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f58e8ba6160 R15: 00007fff6c4048f8
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

