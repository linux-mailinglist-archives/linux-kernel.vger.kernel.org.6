Return-Path: <linux-kernel+bounces-229874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC33917566
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B523D283950
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB1DBA55;
	Wed, 26 Jun 2024 01:03:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBCC2579
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719363786; cv=none; b=UuTiEPhdA/4Frs0LGiAx18X63pEx4FiAHdTiqzcX2mul0qaM2qQtxKcUAz1spuaWXCXhIUT7i9UBOT4IPK4sRL4/KZltYTvmNVfCVBqVCF2od4SMVc61CtFTQ2O0C5XLUh+FfIhPM+G1Sx5vDZGcxfqOgb9cjX2dwkgORycAL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719363786; c=relaxed/simple;
	bh=ZG3iGcY2vfnn0RajLCPhjqFv6efZoS+47bvHMDWd79k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HCSEKJkkZWWa+uNXqqJqnQhmvnkt+9b+xbpEN0xbLod4hsTkz/Cyv4b9LQWkSxKGYQZOzN/RidXisMsHW3TPy68tsoVrDBn+2ADTzoyi7bWuRx3fbsrffzugDXVHbt3+FcPnINfP3lYPsMaci7HcU45Rpd3zgc9IfL5x37Gbp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-377160ff0adso11195435ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719363783; x=1719968583;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuEfz0QTfXjfT8hljHKZl3TOqCrRrvM3ErR78vX8oDk=;
        b=KuUllKXVAfZSHF9sjwK+fhRc6gVWLlcEzb4II2vxEMS7PMynt3FKIz3Y1rES2G0CRr
         hxToP9DilIYc8vO9HKAd8LttYZcahxKLVB41rVkNXibiW/oXYswg0RRYsGYLQqlvPKea
         gfRSJkgjWsWwkXH04KeEABXNb3DW/F15wIs0Jt8Kecl7fwanWw8jP7ZyLyBkdFoYucj/
         Zn8B92DUM5Xk+35gMHtjMWh0xJnmVjNDpMBpk28HikRAyQ9I925zP4G2IAaSGlnpvzut
         4bCMKfQ2INtqdvs4peBVkS2vlZJheFShrZ98r+foGVJwmpREnZKtozpidcKEKmobxuo6
         Q6Yw==
X-Gm-Message-State: AOJu0YwdVdsFjpB8l9GnY+7T7AmkzommkjsM1GPunrrhRA7ZpSwHfLqq
	2GPZwXjzpXQ8QRMY01/kyXBP4g+2BwO95A5rDFCvxmonVYL1+/Mc2rENtDDx5a+yL5Rj3D+gd7j
	8pfqZ7q3bv8mDWIwH0vKhfEKVPktL3Ex4KQpVqHwKEAYBz32FKUE9aDg=
X-Google-Smtp-Source: AGHT+IGiP3x8kR7uf7RPtKTlm4Gv64qOQsvHwb1AohkekUXrwqoLsU/WJlJmuWibfu581K5E/nv7ZWGM//WmehS+fS+lJsiWyCWt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8c:b0:375:dad7:a664 with SMTP id
 e9e14a558f8ab-3763f74fbc3mr8224555ab.6.1719363783208; Tue, 25 Jun 2024
 18:03:03 -0700 (PDT)
Date: Tue, 25 Jun 2024 18:03:03 -0700
In-Reply-To: <CAMc0M-80pECBqx0JXP2Jzp8uCLMNxE0jebKwaGiLV-w0DwfhVQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089c2a5061bc09382@google.com>
Subject: Re: [syzbot] [udf?] BUG: unable to handle kernel paging request in __brelse
From: syzbot <syzbot+8c750412421a6826fb6f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

000000004 RCX: 00007f16355169a4
[   77.925908][ T5123] RDX: 0000000000080241 RSI: 00007ffdfe129aa8 RDI: 000=
00000ffffff9c
[   77.933973][ T5123] RBP: 00007ffdfe129aa8 R08: 0000000000000004 R09: 000=
0000000000001
[   77.941941][ T5123] R10: 00000000000001b6 R11: 0000000000000246 R12: 000=
0000000080241
[   77.949919][ T5123] R13: 0000564c2dea772e R14: 0000000000000001 R15: 000=
0564c54a87910
[   77.957990][ T5123]  </TASK>
[   79.072791][   T52] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   79.084835][   T52] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   79.139568][  T954] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   79.147896][  T954] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   80.161190][ T5171] chnl_net:caif_netlink_parms(): no params data found
[   80.226537][ T5171] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   80.234952][ T5171] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   80.242559][ T5171] bridge_slave_0: entered allmulticast mode
[   80.250004][ T5171] bridge_slave_0: entered promiscuous mode
[   80.260448][ T5171] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   80.268278][ T5171] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   80.275827][ T5171] bridge_slave_1: entered allmulticast mode
[   80.282658][ T5171] bridge_slave_1: entered promiscuous mode
[   80.317410][ T5171] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   80.330688][ T5171] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   80.364820][ T5171] team0: Port device team_slave_0 added
[   80.374222][ T5171] team0: Port device team_slave_1 added
[   80.400065][ T5171] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   80.408563][ T5171] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   80.435396][ T5171] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   80.449395][ T5171] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   80.457071][ T5171] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   80.483397][ T5171] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   80.528875][ T5171] hsr_slave_0: entered promiscuous mode
[   80.535390][ T5171] hsr_slave_1: entered promiscuous mode
[   80.655971][ T5171] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   80.668502][ T5171] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   80.686394][ T5171] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   80.696155][ T5171] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   80.783576][ T5171] 8021q: adding VLAN 0 to HW filter on device bond0
[   80.807270][ T5171] 8021q: adding VLAN 0 to HW filter on device team0
[   80.821233][ T5178] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   80.828982][ T5178] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   80.851280][   T25] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   80.858595][   T25] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   81.019917][ T5171] 8021q: adding VLAN 0 to HW filter on device batadv0
[   81.067045][ T5171] veth0_vlan: entered promiscuous mode
[   81.080023][ T5171] veth1_vlan: entered promiscuous mode
[   81.112414][ T5171] veth0_macvtap: entered promiscuous mode
[   81.123514][ T5171] veth1_macvtap: entered promiscuous mode
[   81.142700][ T5171] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   81.160004][ T5171] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   81.175579][ T5171] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   81.184974][ T5171] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   81.196100][ T5171] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   81.205347][ T5171] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   81.340008][ T5171] syz-executor.0 (5171) used greatest stack depth: 185=
44 bytes left
[   81.374166][   T12] netdevsim netdevsim0 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   81.460796][   T12] netdevsim netdevsim0 netdevsim2 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   81.586247][   T12] netdevsim netdevsim0 netdevsim1 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   81.688637][   T12] netdevsim netdevsim0 netdevsim0 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
2024/06/26 01:02:13 executed programs: 0
[   81.879724][ T4491] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   81.889472][ T4491] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   81.897911][ T4491] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   81.907303][ T4491] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   81.915301][ T4491] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > =
3
[   81.923838][ T4491] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   82.061445][ T5198] chnl_net:caif_netlink_parms(): no params data found
[   82.122761][ T5198] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   82.130887][ T5198] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   82.139441][ T5198] bridge_slave_0: entered allmulticast mode
[   82.147751][ T5198] bridge_slave_0: entered promiscuous mode
[   82.157198][ T5198] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   82.164749][ T5198] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   82.171921][ T5198] bridge_slave_1: entered allmulticast mode
[   82.179360][ T5198] bridge_slave_1: entered promiscuous mode
[   82.209689][ T5198] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   82.221577][ T5198] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   82.254100][ T5198] team0: Port device team_slave_0 added
[   82.261951][ T5198] team0: Port device team_slave_1 added
[   82.296217][ T5198] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   82.303353][ T5198] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   82.329624][ T5198] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   82.345219][ T5198] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   82.352226][ T5198] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   82.380583][ T5198] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   82.423103][ T5198] hsr_slave_0: entered promiscuous mode
[   82.430159][ T5198] hsr_slave_1: entered promiscuous mode
[   82.436978][ T5198] debugfs: Directory 'hsr0' with parent 'hsr' already =
present!
[   82.445117][ T5198] Cannot create hsr debugfs directory
[   83.944211][ T4491] Bluetooth: hci0: command tx timeout
[   86.023227][ T4491] Bluetooth: hci0: command tx timeout
[   86.162559][   T12] bridge_slave_1: left allmulticast mode
[   86.174184][   T12] bridge_slave_1: left promiscuous mode
[   86.181283][   T12] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   86.212317][   T12] bridge_slave_0: left allmulticast mode
[   86.222321][ T5209] BUG: sleeping function called from invalid context a=
t include/linux/sched/mm.h:337
[   86.223265][   T12] bridge_slave_0: left promiscuous mode
[   86.232142][ T5209] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pi=
d: 5209, name: udevd
[   86.238553][   T12] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   86.247080][ T5209] preempt_count: 1, expected: 0
[   86.259208][ T5209] RCU nest depth: 0, expected: 0
[   86.264443][ T5209] 4 locks held by udevd/5209:
[   86.269145][ T5209]  #0: ffff88802ff52420 (sb_writers#5){.+.+}-{0:0}, at=
: mnt_want_write+0x3f/0x90
[   86.278591][ T5209]  #1: ffff88807bad1660 (&type->i_mutex_dir_key#5/1){+=
.+.}-{3:3}, at: do_renameat2+0x62c/0x13f0
[   86.289383][ T5209]  #2: ffff888020aa82c8 (&sb->s_type->i_mutex_key#12/4=
){+.+.}-{3:3}, at: vfs_rename+0x6a2/0xf00
[   86.300354][ T5209]  #3: ffff88807bad1410 (&simple_offset_lock_class){+.=
+.}-{2:2}, at: mtree_alloc_cyclic+0x217/0x330
[   86.311353][ T5209] Preemption disabled at:
[   86.311369][ T5209] [<0000000000000000>] 0x0
[   86.320591][ T5209] CPU: 1 UID: 0 PID: 5209 Comm: udevd Tainted: G      =
  W          6.10.0-rc5-next-20240625-syzkaller-08232-g0fc4bfab2cd4-dirty #=
0
[   86.334382][ T5209] Tainted: [W]=3DWARN
[   86.338174][ T5209] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[   86.348687][ T5209] Call Trace:
[   86.352303][ T5209]  <TASK>
[   86.355247][ T5209]  dump_stack_lvl+0x241/0x360
[   86.359967][ T5209]  ? __pfx_dump_stack_lvl+0x10/0x10
[   86.365295][ T5209]  ? __pfx__printk+0x10/0x10
[   86.369900][ T5209]  __might_resched+0x5d4/0x780
[   86.374790][ T5209]  ? __pfx___might_resched+0x10/0x10
[   86.380177][ T5209]  ? fs_reclaim_acquire+0x93/0x140
[   86.385996][ T5209]  ? mas_alloc_nodes+0x26c/0x840
[   86.390940][ T5209]  kmem_cache_alloc_noprof+0x5d/0x2a0
[   86.396318][ T5209]  mas_alloc_nodes+0x26c/0x840
[   86.401173][ T5209]  mas_wr_preallocate+0x4ca/0x6b0
[   86.406201][ T5209]  mas_alloc_cyclic+0x3f7/0xae0
[   86.411064][ T5209]  ? __pfx_mas_alloc_cyclic+0x10/0x10
[   86.416623][ T5209]  ? do_raw_spin_lock+0x14f/0x370
[   86.421845][ T5209]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   86.427810][ T5209]  ? do_raw_spin_unlock+0x13c/0x8b0
[   86.433413][ T5209]  mtree_alloc_cyclic+0x239/0x330
[   86.438638][ T5209]  ? _raw_spin_unlock+0x28/0x50
[   86.444984][ T5209]  ? __pfx_mtree_alloc_cyclic+0x10/0x10
[   86.451111][ T5209]  simple_offset_rename+0x2dc/0x390
[   86.456356][ T5209]  ? vfs_rename+0x5ee/0xf00
[   86.461103][ T5209]  ? __pfx_simple_offset_rename+0x10/0x10
[   86.467664][ T5209]  ? __down_write_common+0x162/0x200
[   86.473302][ T5209]  ? __pfx___down_write_common+0x10/0x10
[   86.479723][ T5209]  shmem_rename2+0xf8/0x350
[   86.484437][ T5209]  ? __pfx_shmem_rename2+0x10/0x10
[   86.489649][ T5209]  vfs_rename+0xbdb/0xf00
[   86.494249][ T5209]  ? __pfx_vfs_rename+0x10/0x10
[   86.499467][ T5209]  ? security_path_rename+0x18b/0x220
[   86.505023][ T5209]  do_renameat2+0xd94/0x13f0
[   86.509806][ T5209]  ? __pfx_do_renameat2+0x10/0x10
[   86.515119][ T5209]  ? __virt_addr_valid+0x183/0x520
[   86.520241][ T5209]  ? __virt_addr_valid+0x44e/0x520
[   86.525390][ T5209]  ? __phys_addr_symbol+0x2f/0x70
[   86.530730][ T5209]  ? __might_fault+0xc6/0x120
[   86.535925][ T5209]  ? getname_flags+0x1e3/0x540
[   86.541095][ T5209]  __x64_sys_rename+0x82/0x90
[   86.546660][ T5209]  do_syscall_64+0xf3/0x230
[   86.551391][ T5209]  ? clear_bhb_loop+0x35/0x90
[   86.556119][ T5209]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   86.562187][ T5209] RIP: 0033:0x7f163549a93b
[   86.566596][ T5209] Code: 48 8b 15 f0 64 15 00 83 c8 ff 64 83 3a 15 75 0=
e 48 8b 7c 24 08 e8 d5 d4 07 00 f7 d8 19 c0 48 83 c4 18 c3 b8 52 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 be 64 15 00 f7 d8 64 89 02 48 83
[   86.586563][ T5209] RSP: 002b:00007ffdfe129608 EFLAGS: 00000202 ORIG_RAX=
: 0000000000000052
[   86.595081][ T5209] RAX: ffffffffffffffda RBX: 0000564c2dec2101 RCX: 000=
07f163549a93b
[   86.603766][ T5209] RDX: 00005649306fb29b RSI: 00007ffdfe129628 RDI: 000=
07ffdfe129a28
[   86.612096][ T5209] RBP: 0000564c54aabc30 R08: 0000000000000006 R09: 9ba=
066a62e2808e1
[   86.620286][ T5209] R10: 000000000000010f R11: 0000000000000202 R12: 000=
0564c54aabe00
[   86.628562][ T5209] R13: 00007ffdfe129628 R14: 00007ffdfe129a28 R15: 000=
0564c2deacec8
[   86.637071][ T5209]  </TASK>
[   86.913568][   T12] bond0 (unregistering): (slave bond_slave_0): Releasi=
ng backup interface
[   86.926689][   T12] bond0 (unregistering): (slave bond_slave_1): Releasi=
ng backup interface
[   86.937052][   T12] bond0 (unregistering): Released all slaves
[   87.084220][   T12] hsr_slave_0: left promiscuous mode
[   87.091276][   T12] hsr_slave_1: left promiscuous mode
[   87.104321][   T12] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_0
[   87.112586][   T12] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[   87.126789][   T12] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_1
[   87.136130][   T12] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[   87.166260][   T12] veth1_macvtap: left promiscuous mode
[   87.172900][   T12] veth0_macvtap: left promiscuous mode
[   87.180497][   T12] veth1_vlan: left promiscuous mode
[   87.188068][   T12] veth0_vlan: left promiscuous mode


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
GOVERSION=3D'go1.21.4'
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
 -ffile-prefix-map=3D/tmp/go-build1883955012=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at edc5149ad2
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
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dedc5149ad2ab7a38db6b3bcb1b594e0264a92163 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240621-090414'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dedc5149ad2ab7a38db6b3bcb1b594e0264a92163 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240621-090414'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"edc5149ad2ab7a38db6b3bcb1b594e0264=
a92163\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D136f0d61980000


Tested on:

commit:         0fc4bfab Add linux-next specific files for 20240625
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddf444fac2868e4e=
3
dashboard link: https://syzkaller.appspot.com/bug?extid=3D8c750412421a6826f=
b6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13f7f0c69800=
00


