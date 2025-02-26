Return-Path: <linux-kernel+bounces-532952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF09BA45419
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEC7175CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B4B25B66D;
	Wed, 26 Feb 2025 03:40:33 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415D25A34F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740541232; cv=none; b=tLumG9IC2X8jOaL8HyG0ZI7AFTGTbF5MnHkqo7yKh3bpqrOvgTEJaDsJcgbHLstoF+NEl+FzEXw+NZPjI4rDeBbmo5s8ahyMsCeuOmKMg9vfaJAo/gUhnIDvB4LwtIsx0ZkRPeQcT8z3AsIQS2SfbhX6sdY0fcaxo9ee5sf4zps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740541232; c=relaxed/simple;
	bh=9RmG2CUtQhz8dpx9PfKiaPgBojOduYmuq0/qLAIusns=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=babcVxy3CjwHr2p7Io8rJ4gnCnRSn56bfWJkUokM2fBYW/pXPAiCut90XM9RLTqvGi29hGxdab6myUS0Njb5LR0qLSa069rw4FHGjcZZBvX/Xh6d70Gh0oX2y34GaOalEyaDKSzX0guRbQe1xdn04E/Akd5g/ZDZkTYnXWFCujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so129226065ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740541230; x=1741146030;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYlr1BfBAxtih4uEJkLadMpvFmuQPnr81xKVAMbwl08=;
        b=Ts6EM/HHYweOgdluEOuhHIIn+NQ8VkEliWhaVfESiEQFIuYBMXjhgIJ6M4hfZnTne0
         BLmQmc5pJPOnVLfYk51zWje+zzfl0ejzphRFYX5K9KDL8/kGv53Bx+iukGFV0/B1mm9U
         3rZRFxBZ9jMkMKszk02K/pg8qmr+oePDS/piuHKEaCV1ATtimrkRBQq2p+IJyQSpvr5W
         MjhJlTTNi0w2NOSX+93jFXxwDiLd4E8hW6CjkW/kYD87Bm3l/U04STibvwc5JsWv4Q1F
         z9/Z6ugHMI7IYOp4EZkgfP1kduhUY0Gv33hbgMOWmVLQNeODzg2mCeMcPqjorhfxns3s
         HT8g==
X-Forwarded-Encrypted: i=1; AJvYcCW5RLytIJh0wBCgBJGHeHIKISS2qfl/8ICo9PDlx2Rz6EEV/XMqoeJNh+d5hAewSN40pMkfoVMx4YIjFcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUVwZQ109vvUrZjDibFnBaDp0pK/1PP3m7TVZ5JknspGnjEkky
	W8U7nEaMQVbiHtEf77eJfpB2uhP1B/Ek9g9dVMa9JbyQ/fXo5EpB8W6FmGzwW0vavtbYGNmOwzD
	fE3YD4TZbG9PsG7ys54wejq5szTEsjeQhYh4scbYj0sw23XX9wU0wjjs=
X-Google-Smtp-Source: AGHT+IG+0UPDE4sw0XM3Z1Mt+7oJYO5ic6fn24uQK7RYU9VOn1WN8I6naPdiAbGSqljFQKEipoZK5+LSgVWhWC9vfjpMmZSPb27E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c6:b0:3d0:618c:1b22 with SMTP id
 e9e14a558f8ab-3d2cb492ea0mr183406435ab.11.1740541230326; Tue, 25 Feb 2025
 19:40:30 -0800 (PST)
Date: Tue, 25 Feb 2025 19:40:30 -0800
In-Reply-To: <679b398d.050a0220.48cbc.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67be8d2e.050a0220.38b081.0001.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_prep_channel
From: syzbot <syzbot+c90039fcfb40175abe28@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2a1944bff549 Merge tag 'riscv-for-linus-6.14-rc5' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d61c98580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b4c41bdaeea1964
dashboard link: https://syzkaller.appspot.com/bug?extid=c90039fcfb40175abe28
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128877a4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2a1944bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/55cab1eab779/vmlinux-2a1944bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54e689976766/bzImage-2a1944bf.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/58549eaf3f08/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c90039fcfb40175abe28@syzkaller.appspotmail.com

wlan1: No basic rates, using min rate instead
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5621 at net/mac80211/mlme.c:1012 ieee80211_determine_chan_mode net/mac80211/mlme.c:1012 [inline]
WARNING: CPU: 0 PID: 5621 at net/mac80211/mlme.c:1012 ieee80211_prep_channel+0x389b/0x5120 net/mac80211/mlme.c:5666
Modules linked in:
CPU: 0 UID: 0 PID: 5621 Comm: syz.0.16 Not tainted 6.14.0-rc4-syzkaller-00015-g2a1944bff549 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ieee80211_determine_chan_mode net/mac80211/mlme.c:1012 [inline]
RIP: 0010:ieee80211_prep_channel+0x389b/0x5120 net/mac80211/mlme.c:5666
Code: c6 05 e7 7f 95 04 01 48 c7 c7 37 1c 4b 8d be 78 03 00 00 48 c7 c2 a0 1d 4b 8d e8 10 9f 0b f6 e9 7e ca ff ff e8 e6 44 30 f6 90 <0f> 0b 90 48 8b 7c 24 30 e8 58 fb 8b f6 48 c7 44 24 30 ea ff ff ff
RSP: 0018:ffffc90002d5e500 EFLAGS: 00010293
RAX: ffffffff8b91791a RBX: 0000000000000000 RCX: ffff88801f218000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002d5e850 R08: ffffffff8b914e39 R09: ffffffff8b601699
R10: 000000000000000e R11: ffff88801f218000 R12: dffffc0000000000
R13: ffff88804f53a758 R14: ffffc90002d5e710 R15: ffffc90002d5e750
FS:  00007f7858fdd6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7a8f18b440 CR3: 0000000011d4c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_prep_connection+0xda1/0x1310 net/mac80211/mlme.c:8538
 ieee80211_mgd_auth+0xedb/0x1750 net/mac80211/mlme.c:8828
 rdev_auth net/wireless/rdev-ops.h:486 [inline]
 cfg80211_mlme_auth+0x59f/0x970 net/wireless/mlme.c:291
 cfg80211_conn_do_work+0x601/0xeb0 net/wireless/sme.c:183
 cfg80211_sme_connect net/wireless/sme.c:626 [inline]
 cfg80211_connect+0x190a/0x22f0 net/wireless/sme.c:1525
 nl80211_connect+0x19ec/0x2140 net/wireless/nl80211.c:12236
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
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2573
 ___sys_sendmsg net/socket.c:2627 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7859d8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7858fdd038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f7859fa6080 RCX: 00007f7859d8d169
RDX: 0000000000000000 RSI: 00004000000001c0 RDI: 0000000000000009
RBP: 00007f7859e0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f7859fa6080 R15: 00007fffabdddad8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

