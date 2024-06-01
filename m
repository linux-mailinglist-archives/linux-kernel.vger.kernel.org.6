Return-Path: <linux-kernel+bounces-197756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB0B8D6EB8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886A11F2594A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 07:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949351865B;
	Sat,  1 Jun 2024 07:48:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC114267
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717228087; cv=none; b=ODypTo26vS7acZUUECgvOMzZqF8xKfa1Kc35S6LKN3BvH49M4SVcUSCVeWRYuiioxg23Lte7q3+Uj/+CCeb/RIHw+HnvS8+L7jSagLyHsRsN2xBrFIWJYaO67wbERxzAFAAPhd/oREYewK/iy07Xhid5qgZL7/RUyeNe4p14gas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717228087; c=relaxed/simple;
	bh=g2oXQMScMrJUnBNDIVCkpUMr55cHq1oZEz8dQStDicU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SzyaIS/7D+bHUdwDIfR4vrrPxG98zGIfW9J4GFx3C2xea2GMKjuClj6JXGDmiYMP54j41T5jX9JqPGXHutx/XYJRrK4cx9s0dqj5Mcja8yWAIKMVJSmv+0X3Y2nrbbrl19esSK9tqT94h4tKfJjBFncI3uc58Gnx6/BM+FDCGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3748be0ae92so13358815ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 00:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717228085; x=1717832885;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JrqemqWJdm9KHMuPuH3cUK5vDDVcuZdAJCzrhap5gw=;
        b=hDqy+0oBssZOKuMo4eheztI4HjuoU1EEM4A1FurrW8W43PaL5dvBmTPy0QsCETp5z5
         gNqsi/3fXbp8q5znaJrmad8zQ0AnTNahbSGlGMiD7+4yz0IR+Wb6w86Y0ud/OwyE8z45
         E30HfK4f2zPJMBghqCqvRhJsEiKjzFSRWBuebHe5MZPpW8VI8YUmSxy2DTWS6LBgshiM
         byOhSVciUL3gjEKZefiggTFv6X0/3CC8Jlg62gFnyMa6rCO4KPpvQfdt+NIFez9F46nP
         t3qTxGr4YPG4X3tTJCPgPehcDLboCaVH3Z4SeiZvFKpKQ9ZzSqxldjTp7ZIHZLO990kt
         R/6w==
X-Forwarded-Encrypted: i=1; AJvYcCWqZuT7JSZfcqxL40BH3fO13TlLtj1y/Qpowb5npwLo5fG7z06F+dnRQZltUMEOHOc1Qx4+DhrU6qtJDFTlC13hdAWc7ccQ5QfEBHQS
X-Gm-Message-State: AOJu0Yyw1+pFC0mB1iMkRguN6Ue0K7jKg6lSquADuRCnltLe7V1aRCmG
	ObwSfwx0XKN7Le2xB0E44qef5iL7t72sCH1X/y/36/qXRu7QQKG/uYoAHswC0EUYEjApgKtjfJF
	x/ok2827dW7RZdhXH3X9AjaBsod+XpBYTSZ7ap3DPA1t1nsVTd+8m9K4=
X-Google-Smtp-Source: AGHT+IHJ4bJ4Luv6Z+Ez58GSbnGB5wbLW5/VYVa4FSEtT8WnvA8Ttw4orHQfeUPXjKShzSzWrI24nzG95FD9+6GYXRSNixI18F+d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b08:b0:371:139d:ba7e with SMTP id
 e9e14a558f8ab-3748b9d5742mr2027755ab.3.1717228084887; Sat, 01 Jun 2024
 00:48:04 -0700 (PDT)
Date: Sat, 01 Jun 2024 00:48:04 -0700
In-Reply-To: <20240601070117.3481-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff92160619cf5164@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in kcompactd (2)
From: syzbot <syzbot+54594368fbd5a4f1754a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:


[   81.944615][ T5146] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   81.951935][ T5146] bridge_slave_0: entered allmulticast mode
[   81.960430][ T5146] bridge_slave_0: entered promiscuous mode
[   81.970387][ T5146] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   81.977775][ T5146] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   81.985453][ T5146] bridge_slave_1: entered allmulticast mode
[   81.992774][ T5146] bridge_slave_1: entered promiscuous mode
[   82.027267][ T5146] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   82.039373][ T5146] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   82.074403][ T5146] team0: Port device team_slave_0 added
[   82.083676][ T5146] team0: Port device team_slave_1 added
[   82.113625][ T5146] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   82.120805][ T5146] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   82.147567][ T5146] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   82.160698][ T5146] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   82.167825][ T5146] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   82.194902][ T5146] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   82.240270][ T5146] hsr_slave_0: entered promiscuous mode
[   82.246999][ T5146] hsr_slave_1: entered promiscuous mode
[   82.453879][ T5146] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   82.478824][ T5146] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   82.496604][ T5146] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   82.509657][ T5146] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   82.562091][ T5146] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   82.569601][ T5146] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   82.578275][ T5146] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   82.585637][ T5146] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   82.713033][ T5146] 8021q: adding VLAN 0 to HW filter on device bond0
[   82.744216][ T5140] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   82.755171][ T5140] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   82.783071][ T5146] 8021q: adding VLAN 0 to HW filter on device team0
[   82.803680][ T5140] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   82.811352][ T5140] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   82.838143][ T5140] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   82.845839][ T5140] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   82.948475][   T29] kauditd_printk_skb: 22 callbacks suppressed
[   82.948493][   T29] audit: type=3D1400 audit(1717227990.019:119): avc:  =
denied  { sys_module } for  pid=3D5146 comm=3D"syz-executor.0" capability=
=3D16  scontext=3Droot:sysadm_r:sysadm_t tcontext=3Droot:sysadm_r:sysadm_t =
tclass=3Dcapability permissive=3D1
[   83.070363][ T5146] 8021q: adding VLAN 0 to HW filter on device batadv0
[   83.118313][ T5146] veth0_vlan: entered promiscuous mode
[   83.131345][ T5146] veth1_vlan: entered promiscuous mode
[   83.168139][ T5146] veth0_macvtap: entered promiscuous mode
[   83.178211][ T5146] veth1_macvtap: entered promiscuous mode
[   83.200264][ T5146] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   83.219446][ T5146] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   83.236833][ T5146] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   83.247593][ T5146] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   83.256441][ T5146] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   83.265850][ T5146] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   83.450515][  T966] netdevsim netdevsim0 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   83.469211][   T29] audit: type=3D1400 audit(1717227990.539:120): avc:  =
denied  { mounton } for  pid=3D5163 comm=3D"syz-executor.0" path=3D"/" dev=
=3D"sda1" ino=3D2 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsystem_u:obj=
ect_r:root_t tclass=3Ddir permissive=3D1
[   83.549010][  T966] netdevsim netdevsim0 netdevsim2 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   83.624282][  T966] netdevsim netdevsim0 netdevsim1 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   83.715583][  T966] netdevsim netdevsim0 netdevsim0 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   84.452113][   T51] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   84.461626][   T51] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   84.515647][ T5140] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   84.524461][ T5140] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   84.539120][   T29] audit: type=3D1400 audit(1717227991.609:121): avc:  =
denied  { mounton } for  pid=3D5178 comm=3D"syz-executor.0" path=3D"/dev/bi=
nderfs" dev=3D"devtmpfs" ino=3D2322 scontext=3Droot:sysadm_r:sysadm_t tcont=
ext=3Droot:object_r:device_t tclass=3Ddir permissive=3D1
[   84.566088][ T5140] ------------[ cut here ]------------
[   84.572557][ T5140] WARNING: CPU: 1 PID: 5140 at net/mac80211/rx.c:5345 =
ieee80211_rx_list+0x14c7/0x2e90
[   84.582391][ T5140] Modules linked in:
[   84.586360][ T5140] CPU: 1 PID: 5140 Comm: kworker/1:3 Not tainted 6.10.=
0-rc1-syzkaller-00267-gcc8ed4d0a848-dirty #0
[   84.597188][ T5140] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[   84.607390][ T5140] Workqueue: events ieee80211_tlw_fn
[   84.612868][ T5140] RIP: 0010:ieee80211_rx_list+0x14c7/0x2e90
[   84.618825][ T5140] Code: 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e ca 19 0=
0 00 8b 53 70 4c 89 ee 48 89 ef e8 a4 da fd ff e9 fa ef ff ff e8 ea 6a 2f f=
7 90 <0f> 0b 90 e9 15 ec ff ff e8 dc 6a 2f f7 90 0f 0b 90 e9 f3 ef ff ff
[   84.638882][ T5140] RSP: 0018:ffffc90003307a30 EFLAGS: 00010293
[   84.645067][ T5140] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff8a5e561c
[   84.653489][ T5140] RDX: ffff88802a5fda00 RSI: ffffffff8a5e6a06 RDI: 000=
0000000000005
[   84.661885][ T5140] RBP: ffff88802d9d18c0 R08: 0000000000000005 R09: 000=
0000000000000
[   84.670144][ T5140] R10: 0000000000000000 R11: 0000000000000002 R12: fff=
f88802d9d18c0
[   84.672636][   T29] audit: type=3D1400 audit(1717227991.729:122): avc:  =
denied  { write } for  pid=3D5077 comm=3D"syz-execprog" path=3D"pipe:[4192]=
" dev=3D"pipefs" ino=3D4192 scontext=3Droot:sysadm_r:sysadm_t tcontext=3Dsy=
stem_u:system_r:sshd_t tclass=3Dfifo_file permissive=3D1
[   84.678546][ T5140] R13: ffff88802d9d1998 R14: 0000000000000000 R15: 000=
0000000000001
2024/06/01 07:46:31 executed programs: 0
[   84.709403][ T5140] FS:  0000000000000000(0000) GS:ffff8880b9300000(0000=
) knlGS:0000000000000000
[   84.718466][ T5140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.725189][ T5140] CR2: 00007f325e4a8e20 CR3: 000000000d97a000 CR4: 000=
00000003506f0
[   84.733402][ T5140] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   84.741553][ T5140] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   84.749611][ T5140] Call Trace:
[   84.753003][ T5140]  <TASK>
[   84.755955][ T5140]  ? show_regs+0x8c/0xa0
[   84.760242][ T5140]  ? __warn+0xe5/0x3c0
[   84.764453][ T5140]  ? ieee80211_rx_list+0x14c7/0x2e90
[   84.769861][ T5140]  ? report_bug+0x3c0/0x580
[   84.774731][ T5140]  ? handle_bug+0x3d/0x70
[   84.779099][ T5140]  ? exc_invalid_op+0x17/0x50
[   84.783938][ T5140]  ? asm_exc_invalid_op+0x1a/0x20
[   84.789143][ T5140]  ? ieee80211_rx_list+0xdc/0x2e90
[   84.794358][ T5140]  ? ieee80211_rx_list+0x14c6/0x2e90
[   84.799676][ T5140]  ? ieee80211_rx_list+0x14c7/0x2e90
[   84.805045][ T5140]  ? hlock_class+0x4e/0x130
[   84.809592][ T5140]  ? __pfx_ieee80211_rx_list+0x10/0x10
[   84.815396][ T5140]  ? __pfx_lock_acquire+0x10/0x10
[   84.820503][ T5140]  ? lock_acquire+0x1b1/0x560
[   84.825288][ T5140]  ? find_held_lock+0x2d/0x110
[   84.830112][ T5140]  ? skb_dequeue+0x126/0x180
[   84.835291][ T5140]  ieee80211_rx_napi+0xdd/0x400
[   84.840191][ T5140]  ? __pfx_ieee80211_rx_napi+0x10/0x10
[   84.845773][ T5140]  ? lockdep_hardirqs_on+0x7c/0x110
[   84.851025][ T5140]  ? _raw_spin_unlock_irqrestore+0x3b/0x80
[   84.857042][ T5140]  ieee80211_tlw_fn+0xd6/0x130
[   84.862090][ T5140]  process_one_work+0x9fb/0x1b60
[   84.867157][ T5140]  ? __pfx_mld_ifc_work+0x10/0x10
[   84.872489][ T5140]  ? __pfx_process_one_work+0x10/0x10
[   84.878201][ T5140]  ? assign_work+0x1a0/0x250
[   84.882986][ T5140]  worker_thread+0x6c8/0xf70
[   84.887707][ T5140]  ? __kthread_parkme+0x148/0x220
[   84.892921][ T5140]  ? __pfx_worker_thread+0x10/0x10
[   84.894637][ T5125] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   84.898054][ T5140]  kthread+0x2c1/0x3a0
[   84.909279][ T5140]  ? _raw_spin_unlock_irq+0x23/0x50
[   84.912900][ T5125] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   84.914681][ T5140]  ? __pfx_kthread+0x10/0x10
[   84.924978][ T5125] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   84.926794][ T5140]  ret_from_fork+0x45/0x80
[   84.935683][ T5125] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   84.938755][ T5140]  ? __pfx_kthread+0x10/0x10
[   84.946745][ T5125] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > =
3
[   84.950428][ T5140]  ret_from_fork_asm+0x1a/0x30
[   84.957954][ T5125] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   84.962370][ T5140]  </TASK>
[   84.972986][ T5140] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   84.980459][ T5140] CPU: 1 PID: 5140 Comm: kworker/1:3 Not tainted 6.10.=
0-rc1-syzkaller-00267-gcc8ed4d0a848-dirty #0
[   84.991319][ T5140] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[   85.001528][ T5140] Workqueue: events ieee80211_tlw_fn
[   85.007106][ T5140] Call Trace:
[   85.010388][ T5140]  <TASK>
[   85.013496][ T5140]  dump_stack_lvl+0x3d/0x1f0
[   85.018103][ T5140]  panic+0x6f5/0x7a0
[   85.022022][ T5140]  ? __pfx_panic+0x10/0x10
[   85.026565][ T5140]  ? show_trace_log_lvl+0x363/0x500
[   85.031964][ T5140]  ? check_panic_on_warn+0x1f/0xb0
[   85.037176][ T5140]  ? ieee80211_rx_list+0x14c7/0x2e90
[   85.042571][ T5140]  check_panic_on_warn+0xab/0xb0
[   85.047700][ T5140]  __warn+0xf1/0x3c0
[   85.051781][ T5140]  ? ieee80211_rx_list+0x14c7/0x2e90
[   85.057169][ T5140]  report_bug+0x3c0/0x580
[   85.061622][ T5140]  handle_bug+0x3d/0x70
[   85.065871][ T5140]  exc_invalid_op+0x17/0x50
[   85.070468][ T5140]  asm_exc_invalid_op+0x1a/0x20
[   85.075450][ T5140] RIP: 0010:ieee80211_rx_list+0x14c7/0x2e90
[   85.081363][ T5140] Code: 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e ca 19 0=
0 00 8b 53 70 4c 89 ee 48 89 ef e8 a4 da fd ff e9 fa ef ff ff e8 ea 6a 2f f=
7 90 <0f> 0b 90 e9 15 ec ff ff e8 dc 6a 2f f7 90 0f 0b 90 e9 f3 ef ff ff
[   85.101245][ T5140] RSP: 0018:ffffc90003307a30 EFLAGS: 00010293
[   85.108038][ T5140] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff8a5e561c
[   85.116881][ T5140] RDX: ffff88802a5fda00 RSI: ffffffff8a5e6a06 RDI: 000=
0000000000005
[   85.124862][ T5140] RBP: ffff88802d9d18c0 R08: 0000000000000005 R09: 000=
0000000000000
[   85.132941][ T5140] R10: 0000000000000000 R11: 0000000000000002 R12: fff=
f88802d9d18c0
[   85.141199][ T5140] R13: ffff88802d9d1998 R14: 0000000000000000 R15: 000=
0000000000001
[   85.149190][ T5140]  ? ieee80211_rx_list+0xdc/0x2e90
[   85.154513][ T5140]  ? ieee80211_rx_list+0x14c6/0x2e90
[   85.159919][ T5140]  ? hlock_class+0x4e/0x130
[   85.164547][ T5140]  ? __pfx_ieee80211_rx_list+0x10/0x10
[   85.170107][ T5140]  ? __pfx_lock_acquire+0x10/0x10
[   85.175318][ T5140]  ? lock_acquire+0x1b1/0x560
[   85.180027][ T5140]  ? find_held_lock+0x2d/0x110
[   85.184947][ T5140]  ? skb_dequeue+0x126/0x180
[   85.189673][ T5140]  ieee80211_rx_napi+0xdd/0x400
[   85.194554][ T5140]  ? __pfx_ieee80211_rx_napi+0x10/0x10
[   85.200441][ T5140]  ? lockdep_hardirqs_on+0x7c/0x110
[   85.205754][ T5140]  ? _raw_spin_unlock_irqrestore+0x3b/0x80
[   85.211578][ T5140]  ieee80211_tlw_fn+0xd6/0x130
[   85.216362][ T5140]  process_one_work+0x9fb/0x1b60
[   85.221362][ T5140]  ? __pfx_mld_ifc_work+0x10/0x10
[   85.226489][ T5140]  ? __pfx_process_one_work+0x10/0x10
[   85.231972][ T5140]  ? assign_work+0x1a0/0x250
[   85.236874][ T5140]  worker_thread+0x6c8/0xf70
[   85.241562][ T5140]  ? __kthread_parkme+0x148/0x220
[   85.246604][ T5140]  ? __pfx_worker_thread+0x10/0x10
[   85.251718][ T5140]  kthread+0x2c1/0x3a0
[   85.255815][ T5140]  ? _raw_spin_unlock_irq+0x23/0x50
[   85.261048][ T5140]  ? __pfx_kthread+0x10/0x10
[   85.265657][ T5140]  ret_from_fork+0x45/0x80
[   85.270174][ T5140]  ? __pfx_kthread+0x10/0x10
[   85.274772][ T5140]  ret_from_fork_asm+0x1a/0x30
[   85.279563][ T5140]  </TASK>
[   85.283148][ T5140] Kernel Offset: disabled
[   85.287609][ T5140] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3235630346=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at f550015e9
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
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Df550015e921148a45f14a8ea6ac8fe1ade4907af -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240527-170128'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Df550015e921148a45f14a8ea6ac8fe1ade4907af -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240527-170128'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++14 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"f550015e921148a45f14a8ea6ac8fe1ade=
4907af\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D14d75314980000


Tested on:

commit:         cc8ed4d0 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D238430243a58f70=
2
dashboard link: https://syzkaller.appspot.com/bug?extid=3D54594368fbd5a4f17=
54a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1428dc169800=
00


