Return-Path: <linux-kernel+bounces-241314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498E29279A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3AB2283867
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFFB1B120D;
	Thu,  4 Jul 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apVwVwsP"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761531B011C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105824; cv=none; b=vFvMPRiIyNNGpIEDbdZyLtw2QL7JUULXBkOb6t25ZpfTwstPjUADavfRPSORdnLo72k4NlHQZuO64ZxsRVfqOBMssuTD6vGEfjhE+IB5CVIuxQQVVIBOmNE/hqDvIctnPKEKc37KShTaV6Pm4UkJh9NhPWNVYDihCgVyfnC45YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105824; c=relaxed/simple;
	bh=r4udnBaj6YRLp4v4Ugx8Qq0XGltiT5GpmgtvmstJLeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIzb5PzmLgbvE5DJ2ogBu+ItytQUHWVt4xWU7gmKYlt/NJ4lVxTxe8A0bEED1z6c9tOLhXBTIBEx67Y8Dp+yVJgE+Q1NqHolIQRa4O8BY+WUjAtLcyqzDhB27LFd5kEpZhS8V7zEza1KoaBUBoDPCpkqDBvJiRqQ623Mv78l79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apVwVwsP; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-380dacc983eso198065ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720105821; x=1720710621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2qUoowFbDQCBzxP2SPpspKS2wet/1041yVkEVSDgZO0=;
        b=apVwVwsPxXix1LdiArZosppSZbW3KpWtCU0VeQOFQp2uzCvjKJwfo1mESoARnKZ+Pe
         qVUdefjzMc71EGy95SciBj241/4OovGZo/6+7GgnDGsDjOhmutML92QxZPx6DmxzpuZw
         DKbb5qoSmA+nIV3BG1omnvYsMld38zB6FljZ6qTfegus3+diy1s12ym14XBWOCWQFRm8
         e7cv7Jv83G/XWh1O3MxsYgiC6tTGjiElN/k7WT4kZBfGc5Zd9GquodvOmxBscMW/uDVH
         w2CZqeoi9dJFDmcfI4hO4fdpieJeZc2Sj5zgSaFHAtZadsAKG2g6JUzxCrVptQvvnFQd
         1UlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105821; x=1720710621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qUoowFbDQCBzxP2SPpspKS2wet/1041yVkEVSDgZO0=;
        b=B3OSevjUIsc0vWRITkCbIOH/WF+o1xId9b2TNRgp5OeRgRxdghSet7VRgLu3VvCQi3
         Slj0h/wdt+SlVBALvgkiodAUrDNQXfNvTlK2Z23pbMzvA1NgX3pLzYyq11soyhkjZWIp
         RdI9k0nSz223gvlj+oBCLCvAPF+5S1A/njBf8VHn2F4vZAwVfEkQryrgVE6Td9UbaLun
         12IgzOLrmnvcWb5znqIaXdQvb19NFAUVuNcZQVhRVGQMs1T435FxQ57ASdzQMN9/mQtz
         zV+fmBxlrwIfSrlyyTvUz6INXIwRPzSIuKJUueZA0+YLeb7mbDIOERK63fvAOlk5AYs+
         c5IQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Gp06fIaM6HVE9QKPFVJKh/wrcLDuQFn2bNhdoJRNpKXUFTVkO2p6rrDgpG1dDulByze4wf4/TQ52p/n4gX21UYgKu3UTC4y4wjxB
X-Gm-Message-State: AOJu0YxTvbwgGEPEyPE6lklzH0ypnn+ZznrLVPLMMSaomkNUokACVIUc
	MisPh0cok4kBhSwqvb9+WbIWgkmA4GphB+IFc2CsxeBAF3V5Y4seHsvOK0vU06cwhMEQTleOdGK
	W04tY3h4UePK4iYmv203X9HMpmwiMznxL5eIQ
X-Google-Smtp-Source: AGHT+IGPWKO5FKJ2fEu6zLeEKjJbZXqdOIVa5xtjLJsTxoHOU3ajpBk1MEY8w+4Zs9Yy/2z+E84CQ3VZZ4Opc8xa+1s=
X-Received: by 2002:a05:6e02:20cb:b0:376:44b9:c363 with SMTP id
 e9e14a558f8ab-3834e6e04c6mr2952085ab.6.1720105821008; Thu, 04 Jul 2024
 08:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e9f499061c6d4d7a@google.com>
In-Reply-To: <000000000000e9f499061c6d4d7a@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Jul 2024 17:10:03 +0200
Message-ID: <CACT4Y+baAj7jgmFeudX2tP=tPan5vtOY7dE2anLgRFKS3Hb2Jw@mail.gmail.com>
Subject: Re: [syzbot] [net?] KCSAN: data-race in __dev_change_flags /
 is_upper_ndev_bond_master_filter (9)
To: syzbot <syzbot+113b65786d8662e21ff7@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 17:07, syzbot
<syzbot+113b65786d8662e21ff7@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8a9c6c40432e Merge tag 'io_uring-6.10-20240703' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1558eeb9980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5b9537cd00be479e
> dashboard link: https://syzkaller.appspot.com/bug?extid=113b65786d8662e21ff7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f01153f3ec8e/disk-8a9c6c40.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/04b88663a824/vmlinux-8a9c6c40.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/63c518cc63c5/bzImage-8a9c6c40.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+113b65786d8662e21ff7@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in __dev_change_flags / is_upper_ndev_bond_master_filter
>
> read-write to 0xffff888112fca0b0 of 4 bytes by task 9257 on cpu 1:
>  __dev_change_flags+0x9a/0x410 net/core/dev.c:8755

This:

dev->flags = (flags & (IFF_DEBUG | IFF_NOTRAILERS | IFF_NOARP |
      IFF_DYNAMIC | IFF_MULTICAST | IFF_PORTSEL |
      IFF_AUTOMEDIA)) |
    (dev->flags & (IFF_UP | IFF_VOLATILE | IFF_PROMISC |
   IFF_ALLMULTI));

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/core/dev.c?id=8a9c6c40432e265600232b864f97d7c675e8be52#n8755

lots of potential to be compiled in a way that temporarily exposes
dev->flags as not having the first or the second part of flags, even
though these flags are supposed to be set before and after the
operation.

I guess randomly missing flags can lead to arbitrary bugs elsewhere.


>  rtnl_configure_link net/core/rtnetlink.c:3321 [inline]
>  rtnl_newlink_create net/core/rtnetlink.c:3518 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
>  rtnl_newlink+0x121e/0x1690 net/core/rtnetlink.c:3743
>  rtnetlink_rcv_msg+0x85e/0x910 net/core/rtnetlink.c:6635
>  netlink_rcv_skb+0x12c/0x230 net/netlink/af_netlink.c:2564
>  rtnetlink_rcv+0x1c/0x30 net/core/rtnetlink.c:6653
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x58d/0x660 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x5ca/0x6e0 net/netlink/af_netlink.c:1905
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x140/0x180 net/socket.c:745
>  ____sys_sendmsg+0x312/0x410 net/socket.c:2585
>  ___sys_sendmsg net/socket.c:2639 [inline]
>  __sys_sendmsg+0x1e9/0x280 net/socket.c:2668
>  __do_sys_sendmsg net/socket.c:2677 [inline]
>  __se_sys_sendmsg net/socket.c:2675 [inline]
>  __x64_sys_sendmsg+0x46/0x50 net/socket.c:2675
>  x64_sys_call+0xb25/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:47
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888112fca0b0 of 4 bytes by task 3104 on cpu 0:
>  netif_is_bond_master include/linux/netdevice.h:5020 [inline]
>  is_upper_ndev_bond_master_filter+0x2b/0xb0 drivers/infiniband/core/roce_gid_mgmt.c:275
>  ib_enum_roce_netdev+0x124/0x1d0 drivers/infiniband/core/device.c:2310
>  ib_enum_all_roce_netdevs+0x8a/0x100 drivers/infiniband/core/device.c:2337
>  netdevice_event_work_handler+0x15b/0x3c0 drivers/infiniband/core/roce_gid_mgmt.c:626
>  process_one_work kernel/workqueue.c:3248 [inline]
>  process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3329
>  worker_thread+0x526/0x720 kernel/workqueue.c:3409
>  kthread+0x1d1/0x210 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> value changed: 0x00001002 -> 0x00008002
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 3104 Comm: kworker/u8:6 Not tainted 6.10.0-rc6-syzkaller-00067-g8a9c6c40432e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> Workqueue: gid-cache-wq netdevice_event_work_handler
> ==================================================================
> netdevsim netdevsim3 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim3 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim3 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim3 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
> bridge_slave_1: left allmulticast mode
> bridge_slave_1: left promiscuous mode
> bridge0: port 2(bridge_slave_1) entered disabled state
> bridge_slave_0: left allmulticast mode
> bridge_slave_0: left promiscuous mode
> bridge0: port 1(bridge_slave_0) entered disabled state
> bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
> bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
> bond0 (unregistering): Released all slaves
> hsr_slave_0: left promiscuous mode
> hsr_slave_1: left promiscuous mode
> batman_adv: batadv0: Interface deactivated: batadv_slave_0
> batman_adv: batadv0: Removing interface: batadv_slave_0
> batman_adv: batadv0: Interface deactivated: batadv_slave_1
> batman_adv: batadv0: Removing interface: batadv_slave_1
> veth1_macvtap: left promiscuous mode
> veth0_macvtap: left promiscuous mode
> veth1_vlan: left promiscuous mode
> veth0_vlan: left promiscuous mode
> team0 (unregistering): Port device team_slave_1 removed
> team0 (unregistering): Port device team_slave_0 removed
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
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000e9f499061c6d4d7a%40google.com.

