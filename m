Return-Path: <linux-kernel+bounces-405872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4489C5A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC4B2511F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1615F70830;
	Tue, 12 Nov 2024 12:56:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409F70817
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416166; cv=none; b=Mi63TT3vEa6FBoKtMH/hJ5qvfSPztKCpRiv0S+7FSgLLdVEKyuFaFTQTfdJUUq95M/PnwWkx8NZnqLePDaRHZrSTiNf9IfEeX+LlgXhctKdFlwSJMTukrUDoI+x/idOUcAbQ5BnSsYHKTAia/MgRwTi+sckfCoGHlASjk2FoyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416166; c=relaxed/simple;
	bh=C/eQmWUqyn/d7/ShCEFvViJPbW7wNJ2HnjuCl2Lk53I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rqF6e3WsRm//fnoU2PXw69KjuyC+3ft15sIjHBL4CFr3VrVm290NH8O4VkovqvbpWhBO9ncpJ+hxd8IyxITqmNJtbQa9WwRji4LIfxFxPZ9axdfPbTyOhelCppZMZwEG8OvoT3rouO2TA70zs/bon9+QP2+Y9gGfg38JDmwaCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6add3a52eso52436965ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731416164; x=1732020964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fd13ky7VeQx0cLdtaNbeewVPQBzzfGPJFsWVSuR8kYI=;
        b=IExfPPOJN8aToasUNAE+ThGwVMyY8SCIfY0B0QPqqmPEZnIDvoWbkn2fpJkbqVzWrx
         mEef8/sQrr/JtFXcT4mm+oO3/llrQ080nuAeRIrCH04d3Qlu1zJqsmTzPatBITviRfjf
         zpziw9u2HKphw2MR8KXItYKAnwycZpe/qAjPflFN/DMQyJtrpfIXHC9iYj1nbV7AIZzJ
         KtPmQRC5AwVDzhaBmagFcMFahZAsIUXIzfqdzczNY01QdkM9f9C7ufhjqQ1Fg2DbyTUh
         gSrPgXeJc3hhRcAuiTnRb/BfqZA0+0jgSMQ1n1+DUGcfcqtQ/F5Fy4EjpeUTaVsdJs0C
         kavQ==
X-Gm-Message-State: AOJu0YzUeXy5S3mXVbsESsn7HWL6wjaBKfkA++IRS/QTzrhrYK5QXrf3
	PHojrIJCyGLmqKLqSzzEeG/ys48JZLGQtaDQeYZBfyZr8IRqtJEQas36xVzkQxaatUwuEcg5JAq
	QHxnwE11qvhNuxRcTLxXwB4cn2J4QXLJodqTXGBPEokw4GPSq1qIihV0=
X-Google-Smtp-Source: AGHT+IF9md4o2mO//UkTnPq0a9zLSFteuwdhgjoYiwPJRJ3h7jqfTBATanRCTP3XtcNhK9txXWfW4jXV1Qtr4PTN6p7ExYejvyvs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:3a1:a2b4:6665 with SMTP id
 e9e14a558f8ab-3a6f25615c4mr124881045ab.12.1731416164136; Tue, 12 Nov 2024
 04:56:04 -0800 (PST)
Date: Tue, 12 Nov 2024 04:56:04 -0800
In-Reply-To: <20241112123555.561416-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67335064.050a0220.5d845.0004.GAE@google.com>
Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ieee802154_del_iface

------------[ cut here ]------------
kernel BUG at net/core/dev.c:11375!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 7336 Comm: syz.4.73 Not tainted 6.12.0-rc7-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:unregister_netdevice_many_notify+0x1d84/0x1da0 net/core/dev.c:11375
Code: 01 90 48 c7 c7 80 fe 0c 8d 48 c7 c6 60 fe 0c 8d ba 8b 17 00 00 e8 8c 47 c8 f7 90 0f 0b 90 90 e9 67 e8 ff ff e8 9d 51 07 f8 90 <0f> 0b e8 95 51 07 f8 90 0f 0b e8 dd 5e 31 02 66 2e 0f 1f 84 00 00
RSP: 0018:ffffc90004607160 EFLAGS: 00010293
RAX: ffffffff898d8813 RBX: 0000000000000002 RCX: ffff88802c1e5a00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffffc90004607350 R08: ffffffff898d6ca6 R09: 1ffffffff1f98274
R10: dffffc0000000000 R11: fffffbfff1f98275 R12: dead000000000100
R13: ffff888028cf06c1 R14: ffffc900046073a0 R15: 1ffff1100519e031
FS:  00007fc796c396c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005587e87f1950 CR3: 0000000033264000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 unregister_netdevice_many net/core/dev.c:11469 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11343
 rdev_del_virtual_intf_deprecated net/ieee802154/rdev-ops.h:24 [inline]
 ieee802154_del_iface+0x2c0/0x5c0 net/ieee802154/nl-phy.c:323
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
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
RIP: 0033:0x7fc795d7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc796c39038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc795f35f80 RCX: 00007fc795d7e719
RDX: 0000000004000000 RSI: 0000000020000b00 RDI: 0000000000000005
RBP: 00007fc795df139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc795f35f80 R15: 00007ffe0c919b58
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:unregister_netdevice_many_notify+0x1d84/0x1da0 net/core/dev.c:11375
Code: 01 90 48 c7 c7 80 fe 0c 8d 48 c7 c6 60 fe 0c 8d ba 8b 17 00 00 e8 8c 47 c8 f7 90 0f 0b 90 90 e9 67 e8 ff ff e8 9d 51 07 f8 90 <0f> 0b e8 95 51 07 f8 90 0f 0b e8 dd 5e 31 02 66 2e 0f 1f 84 00 00
RSP: 0018:ffffc90004607160 EFLAGS: 00010293
RAX: ffffffff898d8813 RBX: 0000000000000002 RCX: ffff88802c1e5a00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffffc90004607350 R08: ffffffff898d6ca6 R09: 1ffffffff1f98274
R10: dffffc0000000000 R11: fffffbfff1f98275 R12: dead000000000100
R13: ffff888028cf06c1 R14: ffffc900046073a0 R15: 1ffff1100519e031
FS:  00007fc796c396c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f392374d440 CR3: 0000000033264000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e7fe30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f001a7980000


