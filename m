Return-Path: <linux-kernel+bounces-285292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EE6950BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDE6281714
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DA21A38D0;
	Tue, 13 Aug 2024 17:56:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A022F11
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571783; cv=none; b=C2d7o5GrSve8bdeaDAZFqWCLFFdwMEhHbFUBzRP2XaLMut9/qyqGdySnuCpe8MVFeL0C16zcfj2ieDdWm1PmS719VtrxNv+PKhmuoOTn3A5CvWh2wwrLKbS4S0COZwk85cOeDn1X0ex/GxwJuyjPxEwhj1H0NGFhPEYINrXaMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571783; c=relaxed/simple;
	bh=tCPCJ/TpJCda4BgwZL+Ym/aFi3VCjhUXEV2ViGdNsxQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=i1UL3B0fEeC0L4n86l8oZrMP95w9YstvcliB7MCAiCHjEcuIlC6NN4dMrMCmsdd507HrMxY0njVjVuSgzYCUHLuNS1/vTzpntnh0OxsUfgQPOZmm1j5LabOirUUmDszex3Y5crZcekm+N6ZwSnCK2+TwHeTQWuW8chGyYT3bjAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8edd7370so731277339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723571781; x=1724176581;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhLZCqzwDFLBPIoFDag5GyusiC/lZjZlVdw7TtMKxkg=;
        b=hQkIR0qQ+c30/TdVcn0EKbLZ9S1iWLmnaH/21OU+wxY0kAAeHtjVr5Etkv8XgmWIlg
         XQGKJW1UJ3w6IowHCOXV8w3K4kNwJT5wJUe4KzjzhKLDezn7FTG7PN4S7d6QgxIX+lee
         vZqQguMpvKJoHXXxxjdwA6Q+DQd+rjM7RU3oj/3y1jT0vz/UlOUSyDBv0+rHrpICgq6x
         wOZQiO62G67FFbsAN8LWu2F3dmZFfzAx2UZMHRClnnl9wDUHqqVRRE726yM2O64aILHC
         6qYQFdpWIQoDc9idkh8L7wYriCkZehCC4zC6Ht/vJa/9gklt4GpcHUG280mHCb7V6Ire
         zh6g==
X-Forwarded-Encrypted: i=1; AJvYcCXtdwvuOBoB8hI0ePgZudjK9tcAaVc++5rMbBaCpiI2PyWWBKfgFrLcOKG9HTVtEha3VQqsNiuKysoCa9Mtz+ihHbZGQPNNhvypOuq0
X-Gm-Message-State: AOJu0Yx6v3YcB7vQAk2vsmAHLWS2mTaothTMy8rQbCny3yHtvPNOTk9Z
	uYK/UI4yj3QUV5fz7hfdTPoBYcVSWOzE1a/fUwZv2SZAI1NgphdjmKchDJqfZrpxQn0jlxdmDpR
	6O6WV6oBwNH47I6vCThTujB32GMNWqUqdP+9+emx7Gk/TzllojLIxRDk=
X-Google-Smtp-Source: AGHT+IEViqgu+EBcH9mSvm3xuwiktyHxtfQ/wtAqkbCOOcV+hmpjwai+VPqJNaRo2ss2yIU48A5sijwVPyR9LjUBZtuyvyZKJAjP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6209:b0:803:85e8:c40b with SMTP id
 ca18e2360f4ac-824dadde687mr341039f.3.1723571781437; Tue, 13 Aug 2024 10:56:21
 -0700 (PDT)
Date: Tue, 13 Aug 2024 10:56:21 -0700
In-Reply-To: <AS4PR10MB5766C0B97CCA5D2A1D2F8CD0F5862@AS4PR10MB5766.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c722e7061f945377@google.com>
Subject: Re: [syzbot] [wpan?] WARNING in cfg802154_switch_netns (2)
From: syzbot <syzbot+e0bd4e4815a910c0daa8@syzkaller.appspotmail.com>
To: r.vuijk@sownet.nl
Cc: r.vuijk@sownet.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz unsubscribe
>
> ________________________________
> From: syzbot <syzbot+e0bd4e4815a910c0daa8@syzkaller.appspotmail.com>
> Sent: Tuesday, August 13, 2024 7:42:25 PM
> To: alex.aring@gmail.com <alex.aring@gmail.com>; davem@davemloft.net <dav=
em@davemloft.net>; edumazet@google.com <edumazet@google.com>; kuba@kernel.o=
rg <kuba@kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kerne=
l.org>; linux-wpan@vger.kernel.org <linux-wpan@vger.kernel.org>; miquel.ray=
nal@bootlin.com <miquel.raynal@bootlin.com>; netdev@vger.kernel.org <netdev=
@vger.kernel.org>; pabeni@redhat.com <pabeni@redhat.com>; stefan@datenfreih=
afen.org <stefan@datenfreihafen.org>; syzkaller-bugs@googlegroups.com <syzk=
aller-bugs@googlegroups.com>
> Subject: [syzbot] [wpan?] WARNING in cfg802154_switch_netns (2)
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ee9a43b7cfe2 Merge tag 'net-6.11-rc3' of git://git.kernel=
...
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13da25d398000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3De8a2eef9745ad=
e09
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De0bd4e4815a910c=
0daa8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9227adf96f75/dis=
k-ee9a43b7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c65c46b78c57/vmlinu=
x-ee9a43b7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/467d374f18b9/b=
zImage-ee9a43b7.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+e0bd4e4815a910c0daa8@syzkaller.appspotmail.com
>
> RBP: 00007f2c78995090 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 0000000000000000 R14: 00007f2c77d05f80 R15: 00007fff6de33538
>  </TASK>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 8054 at net/ieee802154/core.c:258 cfg802154_switch_n=
etns+0x37f/0x390 net/ieee802154/core.c:258
> Modules linked in:
> CPU: 1 UID: 0 PID: 8054 Comm: syz.0.839 Not tainted 6.11.0-rc2-syzkaller-=
00111-gee9a43b7cfe2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/27/2024
> RIP: 0010:cfg802154_switch_netns+0x37f/0x390 net/ieee802154/core.c:258
> Code: a3 2b f6 90 0f 0b 90 43 80 3c 3e 00 75 8d eb 93 e8 c6 a3 2b f6 e9 8=
b fe ff ff e8 bc a3 2b f6 e9 81 fe ff ff e8 b2 a3 2b f6 90 <0f> 0b 90 e9 73=
 fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90
> RSP: 0018:ffffc9000337f408 EFLAGS: 00010293
> RAX: ffffffff8b67d3ce RBX: 00000000fffffff4 RCX: ffff8880215f3c00
> RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
> RBP: ffff88802324e198 R08: ffffffff8b67d23d R09: 1ffff11004649c3a
> R10: dffffc0000000000 R11: ffffed1004649c3b R12: 0000000000000000
> R13: 0000000000000000 R14: ffff88802324e078 R15: dffffc0000000000
> FS:  00007f2c789956c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff818548d58 CR3: 000000007f648000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  nl802154_wpan_phy_netns+0x13d/0x210 net/ieee802154/nl802154.c:1292
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>  genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
>  ___sys_sendmsg net/socket.c:2651 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2c77b779f9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2c78995038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f2c77d05f80 RCX: 00007f2c77b779f9
> RDX: 0000000000000000 RSI: 0000000020000200 RDI: 000000000000000e
> RBP: 00007f2c78995090 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 0000000000000000 R14: 00007f2c77d05f80 R15: 00007fff6de33538
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

Command #1:
unknown command "unsubscribe"


