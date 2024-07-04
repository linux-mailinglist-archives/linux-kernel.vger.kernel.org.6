Return-Path: <linux-kernel+bounces-241717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC34927E54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 22:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843441F24A48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E49143755;
	Thu,  4 Jul 2024 20:47:22 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C76131736
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720126041; cv=none; b=HCa0hsBT5N3UTHYb8K9F7fOuf3m+ip9agGpGB69Vk+NfsDWrjKc7zyZW4u8poF4yi5ClI200NOVBbohbrbI8qQo6V2tZKJ8sh9IxOK8AJHb8bxGqSMYZr+kk/5kV/9Fidac81KeeEXRiegMNhedQg6M0ETFs8Ijx4ZjVxGW6zYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720126041; c=relaxed/simple;
	bh=S5HqlRk3b/2Q4kQjCtQP6F2tRnwAPUUFU+bMUaAHsoM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gqd8Vz1nYzx2LZCf1rOQfLpTjbbslL8gBwrVNtcvPG+bXlRSZjGnLokYEhOLLYbcb4XeLDutZzDWEnpRXGJXBgGCVpi8DtfOZx7eYAAPV3m8HezZUNnkqiwCcUwC/dL8vsjiUQ9mrc1IXrbKns4fVPQdfV3uiQuP5nzbLNaYGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f61da2de1eso116642939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 13:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720126039; x=1720730839;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpHVdTz7dNOJp1MZT9ljgUFnR3O7FBNavr4wLDa+DUo=;
        b=aJ5wEWx8WJl2TKG1lI+eNSi8gyuErbAFTgClZdkHxeKJE7HOnRB0x00mVql/gIYvEf
         EpBDaLl246MHOhUFbH33RlxIzN8bV+DilMVZcGiWqTcyKvMUkmi38ccXoFpLhjnexCwR
         jmr4Mjrrzyv5frt+vfDhCFFXUxFOE2EmWi5FXLLN8M1tQ+6O3EsnLLqVsxynxngJ+cse
         hgqLcrjTgZiY5MC/CcWzZVp1ivBVvb84v1RuQV+1ljECYSqAhuZ8z84bYcn6nPze/uYa
         NKGgRrfX1MA4baUJBmk76srTvHCf1TYuEL237xtQDHTcWTVdm141oXNq9cn377OkuL2S
         a5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCV/VTV59RvmV/kIqE1syxKjH2kobO+MncCppLicXyUaOkff5Oe275u/XzsPn2QDAZRM0Mvux7zCQ2Tv+vFmQ4tQO5jXrMtrv1aDIuO0
X-Gm-Message-State: AOJu0YwC1he4P/sCPC8/93T4nwMKiyheOYpyQ6kZOv2Us4WzqXCWm0Rd
	arMnWJdg3F1ZgNHdUxG6i9PqhbOP/2WnFvTCOQ85AcY8inGjNsxDrrpitUMPfgS7mNOOE18nS2Y
	RYiZAAekwzQeotWVHVxOtY/39wN92L65MNKVyfirXIlqjhm/Qh9NQisM=
X-Google-Smtp-Source: AGHT+IH0kCTIvS4rZWt8o3gZK8z59LI0fYO8NQFmNKPoqmFdRaAqg0dEFkYXCHXqs6s9ZCbjJAojzO1riJhiLXaYHM0YNuEq8oJ/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d90:b0:7eb:98cb:d769 with SMTP id
 ca18e2360f4ac-7f66e023d09mr16466839f.3.1720126039669; Thu, 04 Jul 2024
 13:47:19 -0700 (PDT)
Date: Thu, 04 Jul 2024 13:47:19 -0700
In-Reply-To: <000000000000ce42b9061c54d76a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000904fae061c720d44@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in rate_control_rate_init (3)
From: syzbot <syzbot+9bdc0c5998ab45b05030@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    aa77b1128016 net: dsa: microchip: lan937x: Add error handl..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12e4f06e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e4644e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108cedc1980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c24cba42b8d2/disk-aa77b112.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/988109eb0cd8/vmlinux-aa77b112.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f7845e638463/bzImage-aa77b112.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bdc0c5998ab45b05030@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5095 at net/mac80211/rate.c:48 rate_control_rate_init+0x588/0x5f0 net/mac80211/rate.c:48
Modules linked in:
CPU: 0 PID: 5095 Comm: syz-executor313 Not tainted 6.10.0-rc5-syzkaller-01209-gaa77b1128016 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:rate_control_rate_init+0x588/0x5f0 net/mac80211/rate.c:48
Code: 00 00 00 e8 1a 72 01 f7 f0 41 80 8d 82 01 00 00 20 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 39 aa 9b f6 90 <0f> 0b 90 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d eb 65 89 e9 80
RSP: 0018:ffffc90003627058 EFLAGS: 00010293
RAX: ffffffff8afa7ce7 RBX: ffff88802262eb98 RCX: ffff88802c188000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff8afa7952 R09: 1ffffffff25f78b0
R10: dffffc0000000000 R11: fffffbfff25f78b1 R12: ffff8880227d8e20
R13: ffff888021078000 R14: 1ffff1100420f00a R15: 0000000000000000
FS:  0000555575af5380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001080 CR3: 000000001f8c2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sta_apply_auth_flags+0x1b6/0x410 net/mac80211/cfg.c:1711
 sta_apply_parameters+0xe23/0x1550 net/mac80211/cfg.c:2061
 ieee80211_add_station+0x3da/0x630 net/mac80211/cfg.c:2127
 rdev_add_station+0x11b/0x2b0 net/wireless/rdev-ops.h:201
 nl80211_new_station+0x1d53/0x2550 net/wireless/nl80211.c:7683
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f465b7bbb99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe52ee7d48 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f465b7bbb99
RDX: 0000000000000000 RSI: 0000000020001080 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000003a28
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

