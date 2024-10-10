Return-Path: <linux-kernel+bounces-358528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC799806C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CB2CB239AF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8C11CDFD9;
	Thu, 10 Oct 2024 08:25:37 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6C1CDFD8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548736; cv=none; b=ZNhM59eoSu08JyN5e05vd8EUK6Hd2D30ud5OsvsMvooSW4hlaWaF9uZmFDvzx4gQHe2y3DAMNNFkgzipO8y9eILd1oGunMg69pXCUY49j0WnGaNLdbUuZLXjVW6LJBoL1+HhzqzVYOxstyTzpjGtAHHzLeocwYU8mY0ic7f6KMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548736; c=relaxed/simple;
	bh=bAuxGXV/nTkouRxYAlhIyk3B3Q+eytFV+8bTgFwLbo8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SOglAAbSRBfLyIWw7VBCY1FuMSOWSv6Ms0HMV07uN5ZYQJ97Zm76OtFx493r/4jKlrqvIHt61stxIK066mYM5kzgZQha0scBW4YFWWzyJ+B0ksXFA5fdXtPvHAUBEvau8zkZFJUWGXXwiMygAAWV0hGo8S75WoCDT9mRlZaNOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a8a4174dso6819255ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728548733; x=1729153533;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhWZlnyGJc22smXm4IruYIWxrurH+hpUjQiuMmgKkjg=;
        b=wjZLe05F7jchk59AvXTa8HtelZjl8i3JI4M8FA+0A3Mxg+1X5bcF5GmjEZ9FviysOQ
         kpLweUCnyWhO2biage+1gcnEMDintu8t7Pahh5pGrDaNQ/QnOIi6OnGRPGC2Uq+f5zzc
         afX760SkVjUeJw4HRFAsmvbOOINV/HANtGUnf5aetEkjCyqzRZAgCWxESls1OM7FN+9S
         wC6hKcnYsaGsyX7WLxZdIG7wdeGz7EsCBh3xjiIKMJUKAPYMrAoIuNzIICOIGTY9QEqw
         CMYTAQ1HNrXEVxIOhrIZ4CGf2tDx80bDExTbUentLZ5gp/SX60wC5z1yk4C7O94uAOBQ
         VXsw==
X-Gm-Message-State: AOJu0Yz9iomgJ8zVGodw+NKwkE9Jg6cGjQ6MKV7e8SOlBNVb245fWQrd
	gzVtus6le0+mb8hUc1FXbeMqi5tv+mz3/OVgE73Qq6KQD9Ar6gkIqXW1qQ3Wm0CXu6ri8tTANaY
	2W51H5V2i+J2ZfJn5rdDYAD7iknDVQ+ZGIcuSNGCoQFIfMGIjLrUHelM=
X-Google-Smtp-Source: AGHT+IH3oi9yHCzGX756Wfd24GG0ISBhAqIVgUjC8l62QgNdvo7jWpYMAAgorri8BZa0E7b+Rwz5ilVAwhivwx6970/gEdW/mPUd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d48:b0:3a1:a3bd:adcc with SMTP id
 e9e14a558f8ab-3a397ce56b2mr43683915ab.6.1728548733196; Thu, 10 Oct 2024
 01:25:33 -0700 (PDT)
Date: Thu, 10 Oct 2024 01:25:33 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67078f7d.050a0220.1139e6.001e.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_g=
et_link_ksettings
Author: cmeiohas@nvidia.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git fo=
r-next

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index 93c6d27b5d8f..eafdf1741582 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2062,19 +2062,14 @@ void ib_dispatch_event_clients(struct ib_event *eve=
nt)
=C2=A0=C2=A0=C2=A0=C2=A0 up_read(&event->device->event_handler_rwsem);
=C2=A0}

-static int iw_query_port(struct ib_device *device,
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 u32 port_num,
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct ib_port_attr *port_attr)
+static int iw_query_port(struct ib_device *device, u32 port_num,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct i=
b_port_attr *port_attr,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct n=
et_device *netdev)
=C2=A0{
=C2=A0=C2=A0=C2=A0=C2=A0 struct in_device *inetdev;
-=C2=A0=C2=A0=C2=A0 struct net_device *netdev;

=C2=A0=C2=A0=C2=A0=C2=A0 memset(port_attr, 0, sizeof(*port_attr));

-=C2=A0=C2=A0=C2=A0 netdev =3D ib_device_get_netdev(device, port_num);
-=C2=A0=C2=A0=C2=A0 if (!netdev)
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
-
=C2=A0=C2=A0=C2=A0=C2=A0 port_attr->max_mtu =3D IB_MTU_4096;
=C2=A0=C2=A0=C2=A0=C2=A0 port_attr->active_mtu =3D ib_mtu_int_to_enum(netde=
v->mtu);

@@ -2097,7 +2092,6 @@ static int iw_query_port(struct ib_device *device,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_unlock();
=C2=A0=C2=A0=C2=A0=C2=A0 }

-=C2=A0=C2=A0=C2=A0 dev_put(netdev);
=C2=A0=C2=A0=C2=A0=C2=A0 return device->ops.query_port(device, port_num, po=
rt_attr);
=C2=A0}

@@ -2135,13 +2129,27 @@ int ib_query_port(struct ib_device *device,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 port_num,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ib_port=
_attr *port_attr)
=C2=A0{
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct net_device *netdev =3D NULL;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
+
=C2=A0=C2=A0=C2=A0=C2=A0 if (!rdma_is_port_valid(device, port_num))
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rdma_protocol_iwarp(device, port_=
num) ||
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rdma_protocol=
_roce(device, port_num)) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 netdev =3D ib_device_get_netdev(device, port_num);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (!netdev)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV=
;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
+
=C2=A0=C2=A0=C2=A0=C2=A0 if (rdma_protocol_iwarp(device, port_num))
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return iw_query_port(device, po=
rt_num, port_attr);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ret =3D iw_query_port(device, port_num, port_attr, netdev);
=C2=A0=C2=A0=C2=A0=C2=A0 else
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return __ib_query_port(device, =
port_num, port_attr);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ret =3D __ib_query_port(device, port_num, port_attr);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (netdev)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 dev_put(netdev);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
+
=C2=A0}
=C2=A0EXPORT_SYMBOL(ib_query_port);

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rx=
e/rxe_net.c
index 75d1407db52d..c5d439bebc24 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -605,6 +605,7 @@ static int rxe_notify(struct notifier_block *not_blk,

=C2=A0=C2=A0=C2=A0=C2=A0 switch (event) {
=C2=A0=C2=A0=C2=A0=C2=A0 case NETDEV_UNREGISTER:
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ib_device_set_netdev(&rxe->ib_d=
ev, NULL, 1);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ib_unregister_device_queue=
d(&rxe->ib_dev);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
=C2=A0=C2=A0=C2=A0=C2=A0 case NETDEV_UP:
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/s=
iw/siw_main.c
index 17abef48abcd..1b7d34798783 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -400,6 +400,7 @@ static int siw_netdev_event(struct notifier_block *nb, =
unsigned long event,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;

=C2=A0=C2=A0=C2=A0=C2=A0 case NETDEV_UNREGISTER:
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ib_device_set_netdev(&sdev->bas=
e_dev, NULL, 1);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ib_unregister_device_queue=
d(&sdev->base_dev);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;


On 08/10/2024 15:24, syzbot wrote:
> External email: Use caution opening links or attachments
>
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggeri=
ng an issue:
> KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in __ethtool_get_link_ksettings+0x6e/0x19=
0 net/ethtool/ioctl.c:442
> Read of size 8 at addr ffff8880673be308 by task kworker/0:1/9
>
> CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.12.0-rc2-syzkaller-g=
615b94746a54-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Workqueue: events smc_ib_port_event_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  __ethtool_get_link_ksettings+0x6e/0x190 net/ethtool/ioctl.c:442
>  ib_get_eth_speed+0x160/0x800 drivers/infiniband/core/verbs.c:1996
>  rxe_query_port+0x76/0x260 drivers/infiniband/sw/rxe/rxe_verbs.c:55
>  __ib_query_port drivers/infiniband/core/device.c:2105 [inline]
>  ib_query_port+0x208/0x870 drivers/infiniband/core/device.c:2147
>  smc_ib_remember_port_attr net/smc/smc_ib.c:364 [inline]
>  smc_ib_port_event_work+0x14e/0xa50 net/smc/smc_ib.c:388
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
> Allocated by task 5967:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:257 [inline]
>  __do_kmalloc_node mm/slub.c:4264 [inline]
>  __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4270
>  __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
>  alloc_netdev_mqs+0x9b/0x1000 net/core/dev.c:11097
>  rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3374
>  rtnl_newlink_create net/core/rtnetlink.c:3500 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
>  rtnl_newlink+0x1423/0x20a0 net/core/rtnetlink.c:3743
>  rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6646
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:729 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:744
>  __sys_sendto+0x39b/0x4f0 net/socket.c:2209
>  __do_sys_sendto net/socket.c:2221 [inline]
>  __se_sys_sendto net/socket.c:2217 [inline]
>  __x64_sys_sendto+0xde/0x100 net/socket.c:2217
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 11:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:230 [inline]
>  slab_free_hook mm/slub.c:2342 [inline]
>  slab_free mm/slub.c:4579 [inline]
>  kfree+0x1a0/0x440 mm/slub.c:4727
>  device_release+0x99/0x1c0
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x22f/0x480 lib/kobject.c:737
>  netdev_run_todo+0xe79/0x1000 net/core/dev.c:10816
>  default_device_exit_batch+0xa24/0xaa0 net/core/dev.c:11949
>  ops_exit_list net/core/net_namespace.c:178 [inline]
>  cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:626
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> The buggy address belongs to the object at ffff8880673be000
>  which belongs to the cache kmalloc-cg-4k of size 4096
> The buggy address is located 776 bytes inside of
>  freed 4096-byte region [ffff8880673be000, ffff8880673bf000)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x673b=
8
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> memcg:ffff888031406a41
> flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff88801ac4f500 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000040004 00000001f5000000 ffff888031406a41
> head: 00fff00000000040 ffff88801ac4f500 dead000000000122 0000000000000000
> head: 0000000000000000 0000000000040004 00000001f5000000 ffff888031406a41
> head: 00fff00000000003 ffffea00019cee01 ffffffffffffffff 0000000000000000
> head: 0000000700000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(=
__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), =
pid 5982, tgid 5982 (syz-executor), ts 102124010087, free_ts 96435310364
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>  prep_new_page mm/page_alloc.c:1545 [inline]
>  get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
>  alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>  alloc_slab_page+0x6a/0x120 mm/slub.c:2412
>  allocate_slab+0x5a/0x2f0 mm/slub.c:2578
>  new_slab mm/slub.c:2631 [inline]
>  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
>  __slab_alloc+0x58/0xa0 mm/slub.c:3908
>  __slab_alloc_node mm/slub.c:3961 [inline]
>  slab_alloc_node mm/slub.c:4122 [inline]
>  __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4290
>  kmalloc_noprof include/linux/slab.h:878 [inline]
>  kzalloc_noprof include/linux/slab.h:1014 [inline]
>  snmp6_alloc_dev net/ipv6/addrconf.c:359 [inline]
>  ipv6_add_dev+0x570/0x1220 net/ipv6/addrconf.c:409
>  addrconf_notify+0x6a7/0x1020 net/ipv6/addrconf.c:3655
>  notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
>  call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
>  call_netdevice_notifiers net/core/dev.c:2048 [inline]
>  register_netdevice+0x167f/0x1b00 net/core/dev.c:10524
>  veth_newlink+0x855/0xce0 drivers/net/veth.c:1861
>  rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
>  rtnl_newlink+0x1591/0x20a0 net/core/rtnetlink.c:3743
>  rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6646
> page last free pid 5869 tgid 5869 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1108 [inline]
>  free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
>  folios_put_refs+0x76c/0x860 mm/swap.c:1007
>  free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
>  __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
>  tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
>  tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
>  tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
>  tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
>  vms_clear_ptes+0x437/0x530 mm/vma.c:1096
>  vms_complete_munmap_vmas+0x208/0x910 mm/vma.c:1140
>  do_vmi_align_munmap+0x613/0x730 mm/vma.c:1349
>  do_vmi_munmap+0x24e/0x2d0 mm/vma.c:1397
>  __vm_munmap+0x24c/0x480 mm/mmap.c:1600
>  __do_sys_munmap mm/mmap.c:1617 [inline]
>  __se_sys_munmap mm/mmap.c:1614 [inline]
>  __x64_sys_munmap+0x68/0x80 mm/mmap.c:1614
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffff8880673be200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880673be280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff8880673be300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                       ^
>  ffff8880673be380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880673be400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Tested on:
>
> commit:         615b9474 RDMA/hns: Disassociate mmap pages for all uct..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma=
.git for-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D131b170798000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7cd9e7e4a8a0a=
15b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5fe14f2ff4ccbac=
e9a26
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D17698f9f98=
0000
>
>

