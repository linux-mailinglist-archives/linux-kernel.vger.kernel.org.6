Return-Path: <linux-kernel+bounces-572304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8FAA6C8E6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A33188E71A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EB61C5F1E;
	Sat, 22 Mar 2025 10:04:09 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AF2172BD5
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742637848; cv=none; b=D5ys5hh+IdUOjo0NdNjaGc8iz4LV+AQoXaFSXFZh1lksZnXpsdTeSVsYuDuhq3jMvs3olK0Og0cpaoeG9nQCUkLOemX+kvcAKS77pMTobnlKxnaiej/tqUhWsHytmUzwZzrOFox6xrKSrM9GQ3sCqkCG6B4nZDlFFEGYsU69968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742637848; c=relaxed/simple;
	bh=oj1Igs3QBEvZNrFATGpIPFCLMe1BUEtx8R4spYLcQJA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t8+I49KGb74p/dtC7hE4DeFajXXIOK06t47PukMWZN0Web8ZIvM/yn9uBh8MZZ+DaDqEJ/T2IIPJAN8Eh2k/Qw0m6XK5/qFsWs4/aLckr8V/jmj/IgKBeICRvPVTPHYpoa3FdJoCciA3vPcYwGK1QeoPgKwa+DhrFj6xEHPwfoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d451ad5b2dso39094745ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 03:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742637845; x=1743242645;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZRJmdxwfLQndDnqf46lPRgckqAQZVABmugO9bO2/o8=;
        b=qRnXuU4hHCA7Q3V+/AT3XX5MBThvIt3vlTtdLW80Hx3qYxfC9+V5H1QNERSzGuAh/3
         xGnyO0llwl4CGrz0oHLFTZsFtsfEuGg0XjVC2p/5CEIbKeJHUHPnb11AAlXnnbKzCa6D
         4hjd3R+CXmxtI9eznsB3OfdrbOHtb8glfi+l30LcFy413DmGjvamw6A8nVKzNNqqNKjY
         ago23h9rz9PgUXlH2FJGR2HSTtml1HAgiPVTr6gehfcE+BfAv5yUe4hEMGwo+gn+lqgb
         a56BU3lNs09fSEcxO0vCKUz9ovTUwL6+jiWmx+5Y/f7Ba1dYMgCkaxkVodKA7G/lrcvk
         L8wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkQeLkSesDO85Ouey+jiAWFqL9hQ4G8gZ4iJEun1dFCNr0bcA6cpJGnBOzoes81eMl18BXEH3n4dCzVhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Pq3J6DW1Bnqh5zNLxCM0eENkrx8QvTeeM2bBsWQu9zfBjwEN
	B+gpTvzfb4nFJ5TeLlnTHw9R+4iLRB1wQx32oMxFRSj5lD/zXgPt2Q/vmnWxlA8pc5z1SG6MSCx
	wltRzyiW9RhaYimjCo1I/ytX6L1bxYoIDNt68xjjN+IV9CuLL1+93jRY=
X-Google-Smtp-Source: AGHT+IEHPg92hC6eejgLC9X1pcfhxQzBhKzRtkctlmGmRSN/iRZWx+0GazE/lsA4SSAsDOkxMLA2ebDZgmLKKU5gIjohupvcNrGq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:318a:b0:3d5:890b:d9e1 with SMTP id
 e9e14a558f8ab-3d595ec52f0mr70596655ab.1.1742637843551; Sat, 22 Mar 2025
 03:04:03 -0700 (PDT)
Date: Sat, 22 Mar 2025 03:04:03 -0700
In-Reply-To: <20250322093737.197101-1-duttaditya18@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67de8b13.050a0220.31a16b.0030.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in add_missing_indices
From: syzbot <syzbot+b974bd41515f770c608b@syzkaller.appspotmail.com>
To: duttaditya18@gmail.com, jfs-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

7.299426][ T6437]  evict+0x444/0x978
[   57.300436][ T6437]  iput+0x740/0x8e8
[   57.301425][ T6437]  dentry_unlink_inode+0x3a0/0x4e0
[   57.302787][ T6437]  __dentry_kill+0x178/0x5e8
[   57.303966][ T6437]  shrink_kill+0xd4/0x2cc
[   57.305091][ T6437]  shrink_dentry_list+0x31c/0x768
[   57.306403][ T6437]  shrink_dcache_parent+0xc4/0x374
[   57.307725][ T6437]  do_one_tree+0x30/0xfc
[   57.308817][ T6437]  shrink_dcache_for_umount+0xd8/0x188
[   57.310208][ T6437]  generic_shutdown_super+0x68/0x2bc
[   57.311588][ T6437]  kill_litter_super+0x74/0xb8
[   57.312815][ T6437]  binderfs_kill_super+0x44/0x9c
[   57.314091][ T6437]  deactivate_locked_super+0xc4/0x12c
[   57.315477][ T6437]  deactivate_super+0xe0/0x100
[   57.316708][ T6437]  cleanup_mnt+0x34c/0x3dc
[   57.317880][ T6437]  __cleanup_mnt+0x20/0x30
[   57.319022][ T6437]  task_work_run+0x230/0x2e0
[   57.320203][ T6437]  do_exit+0x4e8/0x1acc
[   57.321325][ T6437]  do_group_exit+0x194/0x22c
[   57.322516][ T6437]  get_signal+0x1418/0x1534
[   57.323687][ T6437]  do_signal+0x22c/0x39e4
[   57.324803][ T6437]  do_notify_resume+0x74/0x1f4
[   57.326054][ T6437]  el0_svc+0xac/0x168
[   57.327137][ T6437]  el0t_64_sync_handler+0x84/0x108
[   57.328474][ T6437]  el0t_64_sync+0x198/0x19c
[   57.329650][ T6437]=20
[   57.330236][ T6437] The buggy address belongs to the object at ffff0000c=
6dd0800
[   57.330236][ T6437]  which belongs to the cache kmalloc-512 of size 512
[   57.333883][ T6437] The buggy address is located 8 bytes inside of
[   57.333883][ T6437]  freed 512-byte region [ffff0000c6dd0800, ffff0000c6=
dd0a00)
[   57.337465][ T6437]=20
[   57.338058][ T6437] The buggy address belongs to the physical page:
[   57.339720][ T6437] page: refcount:0 mapcount:0 mapping:0000000000000000=
 index:0xffff0000c6dd3000 pfn:0x106dd0
[   57.342360][ T6437] head: order:2 mapcount:0 entire_mapcount:0 nr_pages_=
mapped:0 pincount:0
[   57.344585][ T6437] anon flags: 0x5ffc00000000040(head|node=3D0|zone=3D2=
|lastcpupid=3D0x7ff)
[   57.346663][ T6437] page_type: f5(slab)
[   57.347694][ T6437] raw: 05ffc00000000040 ffff0000c0001c80 0000000000000=
000 0000000000000001
[   57.349947][ T6437] raw: ffff0000c6dd3000 000000000010000c 00000000f5000=
000 0000000000000000
[   57.352181][ T6437] head: 05ffc00000000040 ffff0000c0001c80 000000000000=
0000 0000000000000001
[   57.354462][ T6437] head: ffff0000c6dd3000 000000000010000c 00000000f500=
0000 0000000000000000
[   57.356780][ T6437] head: 05ffc00000000002 fffffdffc31b7401 ffffffffffff=
ffff 0000000000000000
[   57.359060][ T6437] head: 0000000000000004 0000000000000000 00000000ffff=
ffff 0000000000000000
[   57.361371][ T6437] page dumped because: kasan: bad access detected
[   57.363069][ T6437]=20
[   57.363674][ T6437] Memory state around the buggy address:
[   57.365143][ T6437]  ffff0000c6dd0700: fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc
[   57.367267][ T6437]  ffff0000c6dd0780: fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc
[   57.369405][ T6437] >ffff0000c6dd0800: fa fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
[   57.371514][ T6437]                       ^
[   57.372638][ T6437]  ffff0000c6dd0880: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
[   57.374759][ T6437]  ffff0000c6dd0900: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
[   57.376899][ T6437] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   57.383599][ T6437] Disabling lock debugging due to kernel taint
[   58.115605][ T4279] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   58.117733][ T4279] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   58.126718][   T13] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   58.128688][   T13] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   58.244921][ T6478] chnl_net:caif_netlink_parms(): no params data found
[   58.262999][ T6478] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   58.265000][ T6478] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   58.266851][ T6478] bridge_slave_0: entered allmulticast mode
[   58.268702][ T6478] bridge_slave_0: entered promiscuous mode
[   58.271065][ T6478] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   58.273065][ T6478] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   58.274890][ T6478] bridge_slave_1: entered allmulticast mode
[   58.276725][ T6478] bridge_slave_1: entered promiscuous mode
[   58.284565][ T6478] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   58.287976][ T6478] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   58.301618][ T6478] team0: Port device team_slave_0 added
[   58.304562][ T6478] team0: Port device team_slave_1 added
[   58.311150][ T6478] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   58.313047][ T6478] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   58.319801][ T6478] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   58.323279][ T6478] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   58.325087][ T6478] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   58.331871][ T6478] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   58.342983][ T6478] hsr_slave_0: entered promiscuous mode
[   58.344857][ T6478] hsr_slave_1: entered promiscuous mode
[   58.524904][ T6478] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   58.527825][ T6478] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   58.531091][ T6478] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   58.534071][ T6478] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   58.545093][ T6478] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   58.546954][ T6478] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   58.548836][ T6478] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   58.550658][ T6478] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   58.574099][ T6478] 8021q: adding VLAN 0 to HW filter on device bond0
[   58.579075][   T13] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   58.581405][   T13] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   58.588160][ T6478] 8021q: adding VLAN 0 to HW filter on device team0
[   58.592344][   T13] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   58.594257][   T13] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   58.604549][   T13] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   58.606435][   T13] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   58.652607][ T6478] 8021q: adding VLAN 0 to HW filter on device batadv0
[   58.794002][ T6478] veth0_vlan: entered promiscuous mode
[   58.797290][ T6478] veth1_vlan: entered promiscuous mode
[   58.805304][ T6478] veth0_macvtap: entered promiscuous mode
[   58.808030][ T6478] veth1_macvtap: entered promiscuous mode
[   58.812929][ T6478] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   58.816774][ T6478] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   58.819924][ T6478] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   58.822355][ T6478] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   58.824638][ T6478] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   58.826870][ T6478] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   59.181587][ T6504] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   59.183994][ T6504] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   59.186180][ T6504] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   59.188548][ T6504] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   59.190979][ T6504] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > =
3
[   59.193973][ T6504] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   59.553232][  T257] netdevsim netdevsim0 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   59.653590][  T257] netdevsim netdevsim0 netdevsim2 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
1970/01/01 00:00:59 executed programs: 0
[   59.716294][ T5990] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   59.718426][ T5990] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   59.720378][ T5990] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   59.722847][ T5990] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   59.725079][ T5990] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > =
3
[   59.727126][ T5990] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   59.742863][  T257] netdevsim netdevsim0 netdevsim1 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   59.781899][ T6514] chnl_net:caif_netlink_parms(): no params data found
[   59.799281][ T6514] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   59.801138][ T6514] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   59.803268][ T6514] bridge_slave_0: entered allmulticast mode
[   59.805074][ T6514] bridge_slave_0: entered promiscuous mode
[   59.807421][ T6514] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   59.809257][ T6514] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   59.811156][ T6514] bridge_slave_1: entered allmulticast mode
[   59.813176][ T6514] bridge_slave_1: entered promiscuous mode
[   59.820939][ T6514] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   59.824994][ T6514] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   59.833658][ T6514] team0: Port device team_slave_0 added
[   59.835905][ T6514] team0: Port device team_slave_1 added
[   59.843368][ T6514] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   59.845253][ T6514] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   59.852280][ T6514] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   59.856347][ T6514] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   59.858065][ T6514] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   59.864869][ T6514] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   59.877687][ T6514] hsr_slave_0: entered promiscuous mode
[   59.879458][ T6514] hsr_slave_1: entered promiscuous mode
[   59.881038][ T6514] debugfs: Directory 'hsr0' with parent 'hsr' already =
present!
[   59.883460][ T6514] Cannot create hsr debugfs directory
[   61.232999][  T257] netdevsim netdevsim0 netdevsim0 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   61.761844][ T6504] Bluetooth: hci0: command tx timeout
[   62.710778][  T257] bridge_slave_1: left allmulticast mode
[   62.712502][  T257] bridge_slave_1: left promiscuous mode
[   62.714043][  T257] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   62.716970][  T257] bridge_slave_0: left allmulticast mode
[   62.718466][  T257] bridge_slave_0: left promiscuous mode
[   62.719970][  T257] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   63.841936][ T6504] Bluetooth: hci0: command tx timeout
[   64.293085][  T257] bond0 (unregistering): (slave bond_slave_0): Releasi=
ng backup interface
[   64.333054][  T257] bond0 (unregistering): (slave bond_slave_1): Releasi=
ng backup interface
[   64.392493][  T257] bond0 (unregistering): Released all slaves
[   64.469913][  T257] hsr_slave_0: left promiscuous mode
[   64.472182][  T257] hsr_slave_1: left promiscuous mode
[   64.474029][  T257] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_0
[   64.476001][  T257] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[   64.478226][  T257] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_1
[   64.480195][  T257] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[   64.482596][ T2353] ieee802154 phy0 wpan0: encryption failed: -22
[   64.484280][ T2353] ieee802154 phy1 wpan1: encryption failed: -22
[   64.486954][  T257] veth1_macvtap: left promiscuous mode
[   64.488498][  T257] veth0_macvtap: left promiscuous mode
[   64.489971][  T257] veth1_vlan: left promiscuous mode
[   64.491353][  T257] veth0_vlan: left promiscuous mode
[   65.921776][ T6504] Bluetooth: hci0: command tx timeout
[   66.482380][  T257] team0 (unregistering): Port device team_slave_1 remo=
ved
[   66.683057][  T257] team0 (unregistering): Port device team_slave_0 remo=
ved


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.22.7'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build1032201832=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 6e87cfa299
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
go fmt ./sys/... >/dev/null
touch .descriptions
GOOS=3Dlinux GOARCH=3Darm64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D6e87cfa299c98d36e79e8b8718a4126899a3ba2f -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20250120-133027'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_arm64 " -o ./bin/linux_arm64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_arm64
aarch64-linux-gnu-g++ -o ./bin/linux_arm64/syz-executor executor/executor.c=
c \
	-O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-l=
arger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-ove=
rflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -stati=
c-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH_arm6=
4=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"6e87cfa299c98d36e79e8b8718a4126899=
a3ba2f\"
/usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin/l=
d: /tmp/ccpnBTge.o: in function `Connection::Connect(char const*, char cons=
t*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0xd8): warning: Using 'gethostbyname' in statically linked applicati=
ons requires at runtime the shared libraries from the glibc version used fo=
r linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D114d043f980000


Tested on:

commit:         a8dfb216 jfs: add index corruption check to DT_GETPAGE()
git tree:       https://github.com/kleikamp/linux-shaggy.git jfs-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2ad2ff9db77be52=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3Db974bd41515f770c6=
08b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16b895e45800=
00


