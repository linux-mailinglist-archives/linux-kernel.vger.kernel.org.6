Return-Path: <linux-kernel+bounces-315290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9695896C084
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB861F263B9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DCF1DC062;
	Wed,  4 Sep 2024 14:30:23 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4EF1DB548
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460223; cv=none; b=TO/nlq+juMnyj/69M2v2f0SgDjosREW6Ic+3l5EzlSPVsnF3z6QQXUYpVVQjXNVHpQKdRa2vCMQGIPwTCkD1muqRIgZnzgysFvBVAr0YuIu9Zve4w8kmoXbU9382DI+KvnefYf792teH+dfrvgia0Hp8ab6GsfipWYV4d4RmU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460223; c=relaxed/simple;
	bh=l9cagTwSN1QUfhMI5FsA2d2/XWo2O0HK5kpy3Hk0/4I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T94Zd9d71djN1S8EpZ6YKVE/orh7g1oDIL7IiQ1byl4PCotYHwugYUaFEc+gWujxqnyF5pzoSDyPquXXt2eWdMTftHgolrr4/pipBcX65vrzIw+462L2mfgxwYSRzmElesCM5GMYKtXyL822bYOSETtt5hYfG+zaqAfmjJCfHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d2ceca837so86540185ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460221; x=1726065021;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mocIEAwFVVs0XX0w8cLgNndq8nrxkwOi/brEwBFJSMQ=;
        b=bSZ41mYYS0uBCywOsQpprLuznV8EPNFvlJ0Vxay5OCyobIvUVJAyrqc0YMQJh8i6Bm
         u9fr6aDsr4lhcwHN+tDUaU68wNMZTVauNIIHib1IkTwbZOXhhZud7QCNwtcDWiWlKF7o
         svC9e2738fX3CyIAYg9sauilaDclFfJGX05jxoTl5n4neCgNmEWVFP6OOrXP52Ze2cHt
         uwJmPIrO5VfjqermUpUaIfZtGgblOA/kTQJz6e+Bhr3/l27KGCxXhbwiadikRtf3VjPd
         O4uu1rVljLwyGDFh/loTZEixU4iq7tTL/u18/ACSDfZmLcmuBVGWHHCybYV+Il+Eo/UF
         8CFw==
X-Forwarded-Encrypted: i=1; AJvYcCVP+rvFn6We2X9nkzrjio9pYtHiiXdj/7a7Mt/uPr3L3AU1v7OTdI5sT8es1H3iBn9f0wvDzxV4Uia2V2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeFIaA8iUWiJ1gzEoTUMIMpVbpVW5Ih2P5UCY2gqehFs/9I0dB
	rmkLEYAa+XOKuNzGBZ7cGovd2fkMKE65vj9D6ohO6hIBRawv0r+C6sG7vS3kWSUt+tTU0E/WT1k
	u7SL0ZceqZKii7jemmVVaVFs+OcoMJrpXE2fKcCiDI2HtF5QL1g9MINs=
X-Google-Smtp-Source: AGHT+IGCW+XdMjN5OuiSaAwkUD0dfDBdbbfmbhvD04Ckie+PKqzkBHKFjq4PacrouebAReSwBJOxBllVwFnWxPpiz1a4L7bHgggK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda8:0:b0:396:ec3b:df63 with SMTP id
 e9e14a558f8ab-39f4107768bmr9478125ab.4.1725460220719; Wed, 04 Sep 2024
 07:30:20 -0700 (PDT)
Date: Wed, 04 Sep 2024 07:30:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087cbd706214c0321@google.com>
Subject: [syzbot] [wpan?] KASAN: global-out-of-bounds Read in
 mac802154_header_create (2)
From: syzbot <syzbot+844d670c418e0353c6a8@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, 
	miquel.raynal@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1934261d8974 Merge tag 'input-for-v6.11-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12224d43980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62bf36773c1381f1
dashboard link: https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1934261d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f83b13c08c6/vmlinux-1934261d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5586153bd20f/bzImage-1934261d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+844d670c418e0353c6a8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in get_unaligned_be64 include/asm-generic/unaligned.h:67 [inline]
BUG: KASAN: global-out-of-bounds in ieee802154_be64_to_le64 include/net/mac802154.h:363 [inline]
BUG: KASAN: global-out-of-bounds in mac802154_header_create+0x50d/0x540 net/mac802154/iface.c:448
Read of size 8 at addr ffffffff8bf93980 by task dhcpcd/5055

CPU: 2 UID: 0 PID: 5055 Comm: dhcpcd Not tainted 6.11.0-rc5-syzkaller-00219-g1934261d8974 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 get_unaligned_be64 include/asm-generic/unaligned.h:67 [inline]
 ieee802154_be64_to_le64 include/net/mac802154.h:363 [inline]
 mac802154_header_create+0x50d/0x540 net/mac802154/iface.c:448
 dev_hard_header include/linux/netdevice.h:3159 [inline]
 vlan_dev_hard_header+0x13f/0x520 net/8021q/vlan_dev.c:83
 dev_hard_header include/linux/netdevice.h:3159 [inline]
 lapbeth_data_transmit+0x2a0/0x350 drivers/net/wan/lapbether.c:257
 lapb_data_transmit+0x93/0xc0 net/lapb/lapb_iface.c:447
 lapb_transmit_buffer+0xce/0x390 net/lapb/lapb_out.c:149
 lapb_send_control+0x1c8/0x320 net/lapb/lapb_subr.c:251
 lapb_establish_data_link+0xeb/0x110 net/lapb/lapb_out.c:163
 lapb_device_event+0x398/0x570 net/lapb/lapb_iface.c:512
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 __dev_notify_flags+0x12d/0x2e0 net/core/dev.c:8877
 dev_change_flags+0x10c/0x160 net/core/dev.c:8915
 devinet_ioctl+0x127a/0x1f10 net/ipv4/devinet.c:1177
 inet_ioctl+0x3aa/0x3f0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f579ea11d49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007fffb68eedc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f579e9436c0 RCX: 00007f579ea11d49
RDX: 00007fffb68fefb8 RSI: 0000000000008914 RDI: 000000000000000c
RBP: 00007fffb690f178 R08: 00007fffb68fef78 R09: 00007fffb68fef28
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffb68fefb8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>

The buggy address belongs to the variable:
 bcast_addr+0x0/0x14a0

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xbf93
flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002000 ffffea00002fe4c8 ffffea00002fe4c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff8bf93880: 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9 f9
 ffffffff8bf93900: f9 f9 f9 f9 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
>ffffffff8bf93980: 06 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 06 f9 f9
                   ^
 ffffffff8bf93a00: f9 f9 f9 f9 03 f9 f9 f9 f9 f9 f9 f9 00 00 00 00
 ffffffff8bf93a80: 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 04 f9 f9
==================================================================


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

