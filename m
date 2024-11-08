Return-Path: <linux-kernel+bounces-401398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3139C19BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0499287D24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3281E0DF9;
	Fri,  8 Nov 2024 10:00:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF31E22F5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060006; cv=none; b=ETD3tIqaiM3bvvRPm+hFwaK+WbkTaIdALutbf16/F+FTQVi55f6HhPZnSj5gjKmw0St7w/kjgIhWwNN4++ddw3+zGb+vtu7r+PrzHD+CPj3e3Yc3y7SBPO+gOrWaLYhr42v9jgDqHbFk94M41s9WXJMxvpHmzwd61GOXKfZfIzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060006; c=relaxed/simple;
	bh=ySTj2NCCOQN4QuJXFYRYsE+sW6gvVz0yKfnAmeJNgrM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CQ0yUKYjaVMsxFpeJZjpbaax+i8Y5r2tDzV+QbBiYFHeqxkXMGJufMZETOmgJd2goQlHnitnwlSS66NgN5xjoWXzlr5Vh5nRyE5Ef8XAQIZ8M/FquSDF7xdGmMJtnzHKkHJ5hDaUq9BVToDngF+UiiRysbinyq6AMJ4fc+fGcTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83abe8804a5so197055539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 02:00:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060004; x=1731664804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=koHuWKsnxY0y7hPSHIVgk8jb1AlYEvZUkk1dGEKV1FU=;
        b=J0dl0OAC5iRFNpZkK9TXZFgG/zaOpN+mRyEhp2HowdwbfejjkiPMcENxlYJq4ypdv4
         PIgid1fqv/zcKCO1l8SuXvW+xtC15Lqzoe4gZWAXcocOZmWz/QlFOzfOqaNgDHkfFZmb
         s0gausa9DABWgf3vTRuH5t2F0kUx+Sf11tMnx11OVepRLQJCgqwh7sz4Iz8oVvTj1BJT
         6mMT0r0iH9RGs8+I865w8D0kKsqkRISfJHSNv6rT4ePIcw6dxFgXGcEUrl+W8xa3G36F
         92qOmJ5x0Mrw8o44uFfChrk9DmcQUVAI8T4Z/HxVfkkyfy/2rSS7GIVHDLSDAR2gAJzK
         nUag==
X-Gm-Message-State: AOJu0YxeiQPeGmuYWLaE6oSZJW1zhrHdQiI+xMwh/L/Jrv5TaU8wRbqQ
	9POCVxh2LfUEWjpW9MiFkMCE5PU5UW6lU1vjTlg2bmM3wGJZiepH3N4VUGLcW09sd9whK5Hc3m8
	xBamwYbsSVWJw7cOsUPnG1P85OxUp8+0i+ovmTqAjcs2rFWu9CJa0dL4=
X-Google-Smtp-Source: AGHT+IFIGGO60nG2MyyYOITKbvPQGx67avR/mA/PrS8jUsDEnKB6/5Bd6lIVNArll/3mrVoajxIL0D2zVFULwp61QdvO1vwo2sHB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b09:b0:3a1:f549:7272 with SMTP id
 e9e14a558f8ab-3a6f1a4548amr28135775ab.23.1731060002977; Fri, 08 Nov 2024
 02:00:02 -0800 (PST)
Date: Fri, 08 Nov 2024 02:00:02 -0800
In-Reply-To: <20241108093138.1464769-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672de122.050a0220.69fce.000c.GAE@google.com>
Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: corrupted list in ieee802154_if_remove

sd: ffff88807ee54cc0, sdl: dead000000000100, dev: dead000000000122,  
list_del corruption, ffff88807ee54cc0->next is LIST_POISON1 (dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:58!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 6812 Comm: syz.3.18 Not tainted 6.12.0-rc6-syzkaller-00169-g906bd684e4b1-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
Code: e8 21 8f 00 07 90 0f 0b 48 c7 c7 20 39 60 8c 4c 89 fe e8 0f 8f 00 07 90 0f 0b 48 c7 c7 80 39 60 8c 4c 89 fe e8 fd 8e 00 07 90 <0f> 0b 48 c7 c7 e0 39 60 8c 4c 89 fe e8 eb 8e 00 07 90 0f 0b 48 c7
RSP: 0018:ffffc90002f1f3a8 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 6cee37bacfc70200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff8174a12c R09: fffffbfff1cf9fd0
R10: dffffc0000000000 R11: fffffbfff1cf9fd0 R12: dffffc0000000000
R13: ffff88807ee54cc0 R14: dead000000000100 R15: ffff88807ee54cc0
FS:  00007fe011db66c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcd5e5db08 CR3: 00000000223b6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_rcu include/linux/rculist.h:157 [inline]
 ieee802154_if_remove+0x175/0x2e0 net/mac802154/iface.c:691
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
RIP: 0033:0x7fe010f7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe011db6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe011135f80 RCX: 00007fe010f7e719
RDX: 0000000004000000 RSI: 0000000020000b00 RDI: 0000000000000005
RBP: 00007fe010ff139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe011135f80 R15: 00007fff11a4f838
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
Code: e8 21 8f 00 07 90 0f 0b 48 c7 c7 20 39 60 8c 4c 89 fe e8 0f 8f 00 07 90 0f 0b 48 c7 c7 80 39 60 8c 4c 89 fe e8 fd 8e 00 07 90 <0f> 0b 48 c7 c7 e0 39 60 8c 4c 89 fe e8 eb 8e 00 07 90 0f 0b 48 c7
RSP: 0018:ffffc90002f1f3a8 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 6cee37bacfc70200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff8174a12c R09: fffffbfff1cf9fd0
R10: dffffc0000000000 R11: fffffbfff1cf9fd0 R12: dffffc0000000000
R13: ffff88807ee54cc0 R14: dead000000000100 R15: ffff88807ee54cc0
FS:  00007fe011db66c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcd5e5db08 CR3: 00000000223b6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         906bd684 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b9c0c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=347f0ef7656eeb41
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f4cea7980000


