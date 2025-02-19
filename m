Return-Path: <linux-kernel+bounces-522049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4E0A3C54D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE611892C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD21FECA3;
	Wed, 19 Feb 2025 16:37:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1BD212F83
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983024; cv=none; b=bX959ubm9h46/88PKrU75dJY1JAeX3N1dH/3jUQE2Avwhs3WF7o+R6LQ3Dl5Br2cr5i/CN1b3zTBtBFf0h98SU5gWVGQgyiWHy2/jmctGKi68GiK0cVivXjdaj1LZ+YrCZXtPOpfFOT9j5SDMRwO61elDKImEKBMz2mwIDtUUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983024; c=relaxed/simple;
	bh=MumPnFtZBttP0cpGAujchTVlCrGubX02XfmwGtIwkc8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X92pLGoRjKU1vokbNJoYNcnJKe68uiUHtLW58CgyuNw5CjZ+Qvej7N5kGbm2ZXsQ0SC+txxX/WCAzMlx3LOew984GVrnNMs9ZjkVbZOmCAdrvQmAC9bWGLQkVdP/MAMyCsb0xvbGjRT+bQ3TqUMDlR9/rg2mLjb7GJ9xKr3HIJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d1a365d10fso95715ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739983022; x=1740587822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hiqv5qoK2NFncU8CtvmpmTNQ0PTNuFD0TFT+7vIIhg=;
        b=XN0BZ6rJbPFX6n9WllaqCUUeXYqwAp5BqCCP9UrCsJGiOkWOfD7cVTgcR290SaUi5G
         UVB/I6GxnHmPY9uzEzAkSImJ0PHqumy2cspYfPeLItdwieV3NVLbj1vbRYrHhbhTZySu
         HGePmh+oBdIP/n+NZFGCI0p680hBXBtc4YqcNIcczT2hk2eQXnwGnjAeb0Tk7CRIRnaH
         r9VM7Vl5yooXgs9j2M+j6evP4cbdZPDAOZfK8bcuzV5M/AzCAH3n2oa/zVjGn2t2Y2gL
         h4Gs/S3UBK6FZctSyg3CGH5aiOaVbUMnDaON2uKf96EQnRrrc3rcDa13y8rOoi8Bad32
         b0/Q==
X-Gm-Message-State: AOJu0Yxk0koel5sijYIREbRw3vK+MpXs2ECaf3I1z0Q+EMx/dFICknTi
	tBlf19O4G4eRCnHmC5vn1/LCVlwcGR2IUFu4ZUbdFhvPRFnzXjqcY+n0H6sYkYP75QeFUM/vcgw
	yYZzHRdPgHwZgLbkvlDfUNJoYRtCBRvHdhHRL2Zfx+wL/+bnhndoBVXg=
X-Google-Smtp-Source: AGHT+IGEwaR9+xOqFd8DT98dRIauBCrMHbza0TQHqsyXa8HRTNOu+XYISZAs5MAkEgUlMgRurD4KUL1UNm4X0aPXs5sqrQaR7une
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:0:b0:3d1:4a69:e58f with SMTP id
 e9e14a558f8ab-3d2b4adf2edmr47551325ab.2.1739983021699; Wed, 19 Feb 2025
 08:37:01 -0800 (PST)
Date: Wed, 19 Feb 2025 08:37:01 -0800
In-Reply-To: <984ABB17-1380-4581-B8AD-5E233B167856@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b608ad.050a0220.14d86d.0151.GAE@google.com>
Subject: Re: [syzbot] [mm?] [bcachefs?] WARNING in lock_list_lru_of_memcg
From: syzbot <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: corrupted list in new_inode

 slab debugfs_inode_cache start ffff888045d00a30 pointer offset 448 size 1176
list_add corruption. next->prev should be prev (ffff888030eb09c0), but was 0000000000000000. (next=ffff888045d00bf0).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:31!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5848 Comm: syz-executor Not tainted 6.14.0-rc3-syzkaller-g6537cfb395f3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__list_add_valid_or_report+0xf3/0x130 lib/list_debug.c:29
Code: e9 0a fd 42 80 7c 2d 00 00 74 08 48 89 df e8 64 dd 2c fd 49 8b 56 08 48 c7 c7 80 ef 80 8c 4c 89 e6 4c 89 f1 e8 ce e8 2a fc 90 <0f> 0b 4c 89 e7 e8 53 e9 0a fd 42 80 3c 2b 00 74 08 4c 89 e7 e8 34
RSP: 0018:ffffc9000cdced78 EFLAGS: 00010246
RAX: 0000000000000075 RBX: ffff888045d00bf8 RCX: 77c72d62d2106c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 1ffff11008ba017f R08: ffffffff81a1108c R09: fffffbfff1d3a614
R10: dffffc0000000000 R11: fffffbfff1d3a614 R12: ffff888030eb09c0
R13: dffffc0000000000 R14: ffff888045d00bf0 R15: ffff888045d01108
FS:  0000555584544500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffa5c4d56c0 CR3: 000000003f29a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 inode_sb_list_add fs/inode.c:617 [inline]
 new_inode+0xc7/0x1d0 fs/inode.c:1195
 debugfs_get_inode fs/debugfs/inode.c:72 [inline]
 debugfs_create_dir+0xf6/0x430 fs/debugfs/inode.c:597
 wiphy_register+0x1a59/0x2650 net/wireless/core.c:1015
 ieee80211_register_hw+0x35d9/0x42e0 net/mac80211/main.c:1587
 mac80211_hwsim_new_radio+0x2ae8/0x4a40 drivers/net/wireless/virtual/mac80211_hwsim.c:5558
 hwsim_new_radio_nl+0xece/0x2290 drivers/net/wireless/virtual/mac80211_hwsim.c:6242
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb1f/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2543
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:733
 __sys_sendto+0x363/0x4c0 net/socket.c:2187
 __do_sys_sendto net/socket.c:2194 [inline]
 __se_sys_sendto net/socket.c:2190 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2190
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd5e5b8ec7c
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007ffc35ff7120 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fd5e68d4620 RCX: 00007fd5e5b8ec7c
RDX: 0000000000000024 RSI: 00007fd5e68d4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffc35ff7174 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fd5e68d4670 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0xf3/0x130 lib/list_debug.c:29
Code: e9 0a fd 42 80 7c 2d 00 00 74 08 48 89 df e8 64 dd 2c fd 49 8b 56 08 48 c7 c7 80 ef 80 8c 4c 89 e6 4c 89 f1 e8 ce e8 2a fc 90 <0f> 0b 4c 89 e7 e8 53 e9 0a fd 42 80 3c 2b 00 74 08 4c 89 e7 e8 34
RSP: 0018:ffffc9000cdced78 EFLAGS: 00010246
RAX: 0000000000000075 RBX: ffff888045d00bf8 RCX: 77c72d62d2106c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 1ffff11008ba017f R08: ffffffff81a1108c R09: fffffbfff1d3a614
R10: dffffc0000000000 R11: fffffbfff1d3a614 R12: ffff888030eb09c0
R13: dffffc0000000000 R14: ffff888045d00bf0 R15: ffff888045d01108
FS:  0000555584544500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffa5c4d56c0 CR3: 000000003f29a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         6537cfb3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1334b5b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=38a0cbd267eff2d286ff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142f4ba4580000


