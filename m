Return-Path: <linux-kernel+bounces-241308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBC4927995
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A374FB229A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB0E1B11EC;
	Thu,  4 Jul 2024 15:07:27 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2C27452
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105647; cv=none; b=Cs+Pnf4jP99bgZfiLGTZb2zh1Yfhe/0oWp7+tHNKWjdzoy5mCfR+lZ/Uevp4oaeqgfLCvCd01RthgnMr+ijcGP3DNozi8K5yqrdzeVmt5S+TO/vGN3Z2WBgvh13Y9/mQxIMXH84p7m7x7uFyR3vtKF4lYFmXTihB9OdXekBGBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105647; c=relaxed/simple;
	bh=2Z6vb5AkzymWZIP3RwX25ms1AEQT6OaADHtOvjs8fwc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VQVvMp4l6h2qNjPIHx1YEtYQ9HpQCKmTiriYnXi1sCUOrzl7T1geZHbn8K3fd98whwVb/C87MQ9C9umcYy/hEzeV4SGjz+V5a9adDjBD0JDvlmUn+PC11dKQBMHY3SxflQAeUhkVFAgSVe1pSbEPrjbwFyax2iAcY4lYPUsaQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f3ccfec801so85881539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105644; x=1720710444;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIWLUwKcN4E4YBb/KHrEqaWQpKvUYaryMcKIZ8sHWTc=;
        b=I5MRV2Cq1b7L43WMLN1zG6BA8+XbxJprvz9WF+S5CgAtlRluGWS55SMsPuzEUTCslk
         l66wiGyppZS3QgYzptsPMaKkqYJZ6if7YKvxJT3zoPPsfpnY4HmkMsswZ9X2XR9X9pe+
         ZygBnYnchBvqQwCxwlLaodg3045n1vIx2tTV9PQqLw3wOEpgxJptnvY0E/SgoOFJGEQ6
         U6TdedTLzaGVLEXNwIn3rzNzEgeSOD3f2ooBIY+m6OUGft5ZnpE1PhH4y3t+vsTPbbXz
         L2F2EeMhhGyexGEDewVzVmECfwkM+f2HaxHSo1UiFqCZEvz3vyeSJtY77GTF2dDUThyd
         Qy4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt+T1pZWdpL2EAJUVBQ2LIsqJg1y3FMc2eLx1maatXlqxo8mYddfffXpqSzxr5zexoLTHSjHb9LFLAl8rJXhuHJbNxpHqdpqtdhpwF
X-Gm-Message-State: AOJu0YwdFdQcP69wza5Lk/Cb9T5Vp6PbKSKuJw7sUqX1RKKYF0JtrOeA
	DvlbOBmwxlHp0P6Sp1pH6nAY7gwgnelpOXLv4kmDTeNY8FSEjsANxebH9Ed72XgMY1bmljn6zsL
	5huEWq54MGnnUlM9z9i/FlbCcw/8DSj08GBIJPiL+vcefJCMQKJgVMZE=
X-Google-Smtp-Source: AGHT+IFXH1LwCSfXIL6qCKS/ewudkwIdR0brNwApgCrQ+Fd9Cva8q8irkjzpibUkMotfCDZOqFuK5f9i3ne7E2giEZ+m+sO/hTdg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:144d:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4bf63c2f6efmr272037173.6.1720105644449; Thu, 04 Jul 2024
 08:07:24 -0700 (PDT)
Date: Thu, 04 Jul 2024 08:07:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9f499061c6d4d7a@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in __dev_change_flags /
 is_upper_ndev_bond_master_filter (9)
From: syzbot <syzbot+113b65786d8662e21ff7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8a9c6c40432e Merge tag 'io_uring-6.10-20240703' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1558eeb9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b9537cd00be479e
dashboard link: https://syzkaller.appspot.com/bug?extid=113b65786d8662e21ff7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f01153f3ec8e/disk-8a9c6c40.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/04b88663a824/vmlinux-8a9c6c40.xz
kernel image: https://storage.googleapis.com/syzbot-assets/63c518cc63c5/bzImage-8a9c6c40.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+113b65786d8662e21ff7@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __dev_change_flags / is_upper_ndev_bond_master_filter

read-write to 0xffff888112fca0b0 of 4 bytes by task 9257 on cpu 1:
 __dev_change_flags+0x9a/0x410 net/core/dev.c:8755
 rtnl_configure_link net/core/rtnetlink.c:3321 [inline]
 rtnl_newlink_create net/core/rtnetlink.c:3518 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
 rtnl_newlink+0x121e/0x1690 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x85e/0x910 net/core/rtnetlink.c:6635
 netlink_rcv_skb+0x12c/0x230 net/netlink/af_netlink.c:2564
 rtnetlink_rcv+0x1c/0x30 net/core/rtnetlink.c:6653
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x58d/0x660 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x5ca/0x6e0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x140/0x180 net/socket.c:745
 ____sys_sendmsg+0x312/0x410 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x1e9/0x280 net/socket.c:2668
 __do_sys_sendmsg net/socket.c:2677 [inline]
 __se_sys_sendmsg net/socket.c:2675 [inline]
 __x64_sys_sendmsg+0x46/0x50 net/socket.c:2675
 x64_sys_call+0xb25/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888112fca0b0 of 4 bytes by task 3104 on cpu 0:
 netif_is_bond_master include/linux/netdevice.h:5020 [inline]
 is_upper_ndev_bond_master_filter+0x2b/0xb0 drivers/infiniband/core/roce_gid_mgmt.c:275
 ib_enum_roce_netdev+0x124/0x1d0 drivers/infiniband/core/device.c:2310
 ib_enum_all_roce_netdevs+0x8a/0x100 drivers/infiniband/core/device.c:2337
 netdevice_event_work_handler+0x15b/0x3c0 drivers/infiniband/core/roce_gid_mgmt.c:626
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3329
 worker_thread+0x526/0x720 kernel/workqueue.c:3409
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

value changed: 0x00001002 -> 0x00008002

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 3104 Comm: kworker/u8:6 Not tainted 6.10.0-rc6-syzkaller-00067-g8a9c6c40432e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: gid-cache-wq netdevice_event_work_handler
==================================================================
netdevsim netdevsim3 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim3 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim3 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim3 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed


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

