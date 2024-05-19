Return-Path: <linux-kernel+bounces-183088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 108248C945F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 13:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74351B20FB3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48BB446A2;
	Sun, 19 May 2024 11:14:33 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45317C7F
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716117273; cv=none; b=ZW2MCk2NiaBp+XcQM2NCL/WajBGnzktvPGOhCp+9S8OrihtIDWXct0D6489lU5DoxRA7RqgsBPcFN6ruJbKWz2sPCDK+US4ONFnNKUVhP04lIwdc/S9V/MGkgHL9XctTN2FaWwsTRcqoBcPxhluVanRDwiqZ8W/wghJps0Z+2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716117273; c=relaxed/simple;
	bh=TE/dYHUWdFqr94tCntvaxfb0WU+Nf8iKVxC8ogi1uXo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=COktVlDJzMJwoqnCyUM9VMDoaKnLJeHENnf7KtBZrkqBTFYn/lwhecI7fZhw84B+NDfbOzRyvlwU3v7PmOxQLkOCDAPQ5iUna636IUUx4ARx0HxYGjLuKI3PrHlWclWUNcA7e1v4ZsH582DUVBMVJUR3+ZgF3OXV25m2+VIFOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-36db326c42aso38334105ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 04:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716117271; x=1716722071;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KI/jM/0zAOn5DrFOjZOOmDUv+lX+OMNUuitu/9jvMQA=;
        b=n8PCYDa2+BVIl6vxlsvGgtoCYYXq2vri2MR7p7OShj6zqERBun2ntON7pUOmW9+2aU
         vsIEgkxk88a+DROj3sHbpT738KUCwnOFYt1ulhqogdM8G5Oaldj2ckf2wAVJpacGGsBj
         bSVi4RCDLGJLDSfxjOk2Sl/JbH1/3bpJthuh0GOO2T4pKtKylk6iXhgPGwLsbo5wfUZ+
         em/xhZnuBljB9FEAYHA/Gp8asGjnnRv93LL/nLqiWsZxI04TMCuB7ZS2uKIRZnZpnEGQ
         b+F4aML+R0yHd9Nc7m/9EvhVMqDc75UACp/ZDHFhG4zL+nREAFq05vGpu99VcBR/qian
         P7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkY5OoN1zZQjd50LAP+5qO1tZGb4DGsAaXfJJftwcpA6ld7xDGOZBXg/yTQaOOaWR9W9+s+oAIV3WvFTqlLt4Gsq7EbJR4hJsnK0ir
X-Gm-Message-State: AOJu0YzliBc842Wr5BnoTX0JQvKuFnM30n7XTtYxX9LEl1uUY/vxegCh
	ZNKs5j8IQpNyAvQgMOy0fnKW8W+63s2jo/7jc+6xopnMuiVO4FAC0wT0G9d64nKwG5BiccEMKFa
	7Y6/T/6U1m+ItzS/rkVItsrF01sFimjnnyNVPEykofPpavgxWSRbl1/8=
X-Google-Smtp-Source: AGHT+IEbWQvoEqXVGAXqJ5jBYJl/1FuEIv+QevyAC2qAarl9nJ7cOQYrSiaPI4B6+k0+lavWvokDmVGD3v6KU7vPwkDmVI3jE9Wr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cc:b0:36d:d38e:3520 with SMTP id
 e9e14a558f8ab-36dd38e353cmr1564485ab.4.1716117270997; Sun, 19 May 2024
 04:14:30 -0700 (PDT)
Date: Sun, 19 May 2024 04:14:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054bc390618ccb092@google.com>
Subject: [syzbot] [wireless?] WARNING in minstrel_ht_update_caps
From: syzbot <syzbot+d805aca692aded25f888@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0450d2083be6 Merge tag '6.10-rc-smb-fix' of git://git.samb..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c09b3f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=d805aca692aded25f888
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/227283491c2c/disk-0450d208.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d5c9b39757fa/vmlinux-0450d208.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ab6928507ba/bzImage-0450d208.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d805aca692aded25f888@syzkaller.appspotmail.com

netlink: 32 bytes leftover after parsing attributes in process `syz-executor.3'.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6963 at include/net/mac80211.h:6962 rate_lowest_index include/net/mac80211.h:6962 [inline]
WARNING: CPU: 1 PID: 6963 at include/net/mac80211.h:6962 minstrel_ht_update_caps+0x44a/0x17e0 net/mac80211/rc80211_minstrel_ht.c:1733
Modules linked in:
CPU: 1 PID: 6963 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-08995-g0450d2083be6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:rate_lowest_index include/net/mac80211.h:6962 [inline]
RIP: 0010:minstrel_ht_update_caps+0x44a/0x17e0 net/mac80211/rc80211_minstrel_ht.c:1733
Code: da e8 ca bc cf f9 e9 24 ff ff ff e8 80 65 7b f6 eb 17 e8 79 65 7b f6 eb 14 e8 72 65 7b f6 49 c1 fd 38 eb 0c e8 67 65 7b f6 90 <0f> 0b 90 45 31 ed 49 bf 00 00 00 00 00 fc ff df 48 8b 3c 24 4c 8b
RSP: 0018:ffffc9000929ef80 EFLAGS: 00010287
RAX: ffffffff8b1acc49 RBX: 000000000000000c RCX: 0000000000040000
RDX: ffffc90009e54000 RSI: 0000000000004ebd RDI: 0000000000004ebe
RBP: 0000000000000000 R08: ffffffff8b1acb65 R09: ffff88806ddec008
R10: dffffc0000000000 R11: ffffed100dbbdd49 R12: 1ffff11008d33614
R13: 0b00000000000000 R14: ffff88804699b0a0 R15: 0100000000000000
FS:  00007fb6f84146c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fed23961d58 CR3: 0000000028cca000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 rate_control_rate_init+0x3d1/0x5f0 net/mac80211/rate.c:63
 sta_apply_auth_flags+0x1b6/0x410 net/mac80211/cfg.c:1710
 sta_apply_parameters+0xe20/0x1550 net/mac80211/cfg.c:2043
 ieee80211_add_station+0x3da/0x630 net/mac80211/cfg.c:2109
 rdev_add_station+0x11d/0x2b0 net/wireless/rdev-ops.h:201
 nl80211_new_station+0x1d53/0x2550 net/wireless/nl80211.c:7624
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb16/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb6f767cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb6f84140c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb6f77abf80 RCX: 00007fb6f767cee9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007fb6f76c949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fb6f77abf80 R15: 00007ffe9914aca8
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

