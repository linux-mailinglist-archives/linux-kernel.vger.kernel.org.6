Return-Path: <linux-kernel+bounces-383544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB99B1D0F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B091F2169E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6CA13C3CD;
	Sun, 27 Oct 2024 10:07:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5FF29CE8
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730023650; cv=none; b=O1YywIwZVvK26CVKUqu6UKE8/BnDJnYaE7Hwg4RvE3SEu/2mj+495tbvNYoGc4izZqYORoDFH3x07jAq7HxbloGx7zskOCuoGhBBH1XeJ21GdD9g80wm3JjaMzN1HdrDVKcYewJQ3YSEi2zhC8WPzJrWTTmVDEBgT1pIXByK/Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730023650; c=relaxed/simple;
	bh=Kqv/GacjwZXCmPXetHDaiI1LXOhK1XMy1+q06oy/Ldw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t1rbtwb/wBYJ3p9mZF3aI75xQCr0/B+jepa44rvrsUrC4JTjLjZWlricl7IOUouBtPPzhFAkbb8PAiBzsTRQJXuzog4oHLUMOowKIL3nUGO/4pSYtQqil4tL2IjtZo147dnr8dJqcbHIiaTq/FF9rQVdScNXMx9OdC17CwNMX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4f4b5767fso2972815ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 03:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730023647; x=1730628447;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTTc5dtU4YqTgksnxf7GYRJVpUtVEIi1pad1jH0frOQ=;
        b=V3hcZwo2UTaDSJUp+z3t7LwBQgAQ7ta0CGdJJMOMZAr2ZheTVKBhxhL6NL7qX6KCKj
         Fi2aCLhtgkfmWTgCeG4ICH1p7VX8Dqqv3ktAzeQNPwLvqQjAMWP59fPScIyNl8gdB0DS
         SLrZGyt8VnUSBdYCCQfh/4fZwJfgBmYBnZzUk/wbqKd+QpDgbBmqJKXjNBTHI4tFJxyn
         LHqCoOhslGXHLZ2ZessIxpZTYrt9feJLsb6xDAG4frQxiAfT1Mbbrb7feLcPx9PkAfNs
         TEc6dEU0yRwu26mz9bMVoEGmEJTmUpX0uEV834Dbre2NjsH7DagCojsXtRf3c5vE0t4s
         8Flw==
X-Forwarded-Encrypted: i=1; AJvYcCX72UHfhNV2Hdx2nqsz5Oxn2EQgq4L/BKR3iqV9Y1qU6KV618tpm6KfK+/CAFS7CGzhKktmsQDgqZ9DDxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmEillGXjmjeNivYXAD/ov34w6cevsuuB4A1gZilvMQuGCJJV
	cDa5z8DkEwuTOFX0632u02lb27QIH8a/QSdMvBUt8t/wqjvi7NY7GfxjvGcYd8zPyNnIArLR/92
	5SFYfEpUPs9qzOgUMg5O3zLxt/cFxM1jjkyJtYEt34oSvUZSX63eJUdo=
X-Google-Smtp-Source: AGHT+IF6N+Z2TQIbQz0dj+4cGU0LGelaJLlDzfTM+hYsJh/hE8TKKA9mp7T4/L+4DVXG/kuUF81E8NsrzoMfm95yjByT+ZotXlge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc5:b0:3a0:b0dc:1910 with SMTP id
 e9e14a558f8ab-3a4ecddf503mr41058475ab.13.1730023647370; Sun, 27 Oct 2024
 03:07:27 -0700 (PDT)
Date: Sun, 27 Oct 2024 03:07:27 -0700
In-Reply-To: <000000000000e275e7062094d357@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671e10df.050a0220.2b8c0f.01cf.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in page_pool_put_unrefed_netmem
From: syzbot <syzbot+f56a5c5eac2b28439810@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hawk@kernel.org, 
	horms@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e31a8219fbfc Merge tag 'wireless-2024-10-21' of git://git...
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=170bb0e7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=f56a5c5eac2b28439810
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fab24b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c56f57980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a811016509ae/disk-e31a8219.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e9ee079e897a/vmlinux-e31a8219.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3dee0413d35e/bzImage-e31a8219.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f56a5c5eac2b28439810@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5840 at net/core/page_pool.c:753 __page_pool_put_page net/core/page_pool.c:753 [inline]
WARNING: CPU: 0 PID: 5840 at net/core/page_pool.c:753 page_pool_put_unrefed_netmem+0x175/0xb00 net/core/page_pool.c:825
Modules linked in:
CPU: 0 UID: 0 PID: 5840 Comm: syz-executor330 Not tainted 6.12.0-rc4-syzkaller-00168-ge31a8219fbfc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__page_pool_put_page net/core/page_pool.c:753 [inline]
RIP: 0010:page_pool_put_unrefed_netmem+0x175/0xb00 net/core/page_pool.c:825
Code: 74 0e e8 ce 21 ee f7 eb 43 e8 c7 21 ee f7 eb 3c 65 8b 1d 3a d1 5b 76 31 ff 89 de e8 f5 25 ee f7 85 db 74 0b e8 ac 21 ee f7 90 <0f> 0b 90 eb 1d 65 8b 1d 17 d1 5b 76 31 ff 89 de e8 d6 25 ee f7 85
RSP: 0018:ffffc90003d66b50 EFLAGS: 00010093
RAX: ffffffff89a6bc85 RBX: 0000000000000000 RCX: ffff88803401da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff89a6b62a R09: 1ffffd400012b5fd
R10: dffffc0000000000 R11: fffff9400012b5fe R12: 0000000000000000
R13: ffff888034f9f000 R14: ffffea000095afc0 R15: 00000000ffffffff
FS:  000055558d74e380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001040 CR3: 0000000032fd2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tun_ptr_free drivers/net/tun.c:617 [inline]
 __ptr_ring_swap_queue include/linux/ptr_ring.h:571 [inline]
 ptr_ring_resize_multiple_noprof include/linux/ptr_ring.h:643 [inline]
 tun_queue_resize drivers/net/tun.c:3700 [inline]
 tun_device_event+0xaaf/0x1080 drivers/net/tun.c:3720
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 dev_change_tx_queue_len+0x158/0x2a0 net/core/dev.c:9027
 do_setlink+0xff9/0x41f0 net/core/rtnetlink.c:2952
 rtnl_setlink+0x40d/0x5a0 net/core/rtnetlink.c:3230
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f85f58c80e9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff4cd08a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f85f58c80e9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

