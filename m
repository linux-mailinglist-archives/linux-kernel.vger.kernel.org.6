Return-Path: <linux-kernel+bounces-243506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5F09296EE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 09:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE59C2817AE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 07:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDE2AD53;
	Sun,  7 Jul 2024 07:04:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA77FF
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335846; cv=none; b=WL5vK13ElRfMfEFdyEdQeD6cwtKmXOvRgXwVQT1BiVkq0E3Z29jotfNTs1ivgAxipbgVpy/E3qDs9Wmh1M+JmMnEOlvisZSEDKZE6qBYkw5IIOx5A0AX5cVaggqCcdZJXX4BSpjVJIAiYFLJ2uKa+D/qKhfD4gptDzz0lDPqhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335846; c=relaxed/simple;
	bh=99oo8m2yx1DZ7olB8tPBZD30Kc+veoqjQsO4NbHACw4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uPS5WW1UGSoyUrWKtVHP9cawVQlP4o3nSR/U6j1AU8hkt2fsKwEugouGB+ckAyVC3L/BmvUt4lrdo4vjLlIZep/1HdUlKIkauSpurc4DKrqyyOG4ah9R9Z4qVYlTYSP0tK0jTIJcngQlYV9ChOF7WgtaHgX+YN/XqxFI/VGurLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f66b3d69a8so336740739f.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 00:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335844; x=1720940644;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEoCaFHCvhPG163TA8TZ7jfSpATJzJioA8DKSBX0PTg=;
        b=dmKvwLKUlfWpx5UREQd0XBErymltlmHTxNnG+yVR5w4uKI47nuYcou8KWhBgHFMz8x
         5ZV6nkLMnVXWhysINGIHfXgx6585dFzC9nGO1INrZ8W0SBCpPg7bCAsCyhNiVGSSX2yX
         J00ww2vtPbPSYMrMA6eTA83BOzDcD+BFshAmKgusdYOP/o0OdVoYzChxbP4DV3ue1e9D
         slUD/TOrF98fTpJzghD1Lg1VW4XMJ3I0LW2AiHzhjmXjCtkfY93FL81hTjn20WPx99JC
         0qYDiki75fJC1EU2RigHr/1i3L28lG3A8gZFB5NwV1wQtESLXqf/LHebKp/EJTGZ+Ief
         63yA==
X-Forwarded-Encrypted: i=1; AJvYcCXs0nGl4N6nkBayao5ePD6XOrSEukmOxBd1TV9W9woTH8rd+Kljsm7ZZRcAE+6hkZCKGrdJsnInsLrcEMBuPsbzX1FJ+7YfxpKWiJCJ
X-Gm-Message-State: AOJu0YzMIrNBOM7UB8KM3oelcVNm3urckyUKRIXnjC08VoGfPMbZbis/
	p77c1BQhsILL41FF4Yvjbo5iYiXh4GJ5hA6Ds2ci6Iz/ndoaa/r13UZX4KJeP3bM18LmSvGVOC4
	r6FWkdOeiW1QEl62Q6HQ6X33ML6swOvGgTy4hz+axqueOC9VvXDY6IUI=
X-Google-Smtp-Source: AGHT+IGNEz/CgJPJ+Av9dx94HenMOJ2nlwD3jLJGjXJfBqxa1w6fP00jy+ZJK/Tcgos97Gg4tYUBKM4nIvh9Po3QUBps6PLR9/qK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c4:b0:7f7:e26e:bc7c with SMTP id
 ca18e2360f4ac-7f7e26ebdf8mr21366939f.1.1720335842024; Sun, 07 Jul 2024
 00:04:02 -0700 (PDT)
Date: Sun, 07 Jul 2024 00:04:02 -0700
In-Reply-To: <20240707060654.3822-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c233a7061ca2e6ee@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
From: syzbot <syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

. Setting the MTU to 1560 would solve the problem.
[   65.749523][ T5188] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   65.794737][ T5188] hsr_slave_0: entered promiscuous mode
[   65.800990][ T5188] hsr_slave_1: entered promiscuous mode
[   65.807988][ T5188] debugfs: Directory 'hsr0' with parent 'hsr' already =
present!
[   65.816311][ T5188] Cannot create hsr debugfs directory
[   65.949582][ T5188] netdevsim netdevsim2 netdevsim0: renamed from eth0
[   65.959631][ T5188] netdevsim netdevsim2 netdevsim1: renamed from eth1
[   65.969541][ T5188] netdevsim netdevsim2 netdevsim2: renamed from eth2
[   65.979136][ T5188] netdevsim netdevsim2 netdevsim3: renamed from eth3
[   66.059668][ T5188] 8021q: adding VLAN 0 to HW filter on device bond0
[   66.079370][ T5188] 8021q: adding VLAN 0 to HW filter on device team0
[   66.091102][ T5170] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   66.098400][ T5170] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   66.116765][ T5170] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   66.124047][ T5170] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   66.159855][ T5188] hsr0: Slave A (hsr_slave_0) is not up; please bring =
it up to get a fully working HSR network
[   66.170938][ T5188] hsr0: Slave B (hsr_slave_1) is not up; please bring =
it up to get a fully working HSR network
[   66.209690][ T5188] 8021q: adding VLAN 0 to HW filter on device batadv0
[   66.250323][ T5188] veth0_vlan: entered promiscuous mode
[   66.267593][ T5188] veth1_vlan: entered promiscuous mode
[   66.295077][ T5188] veth0_macvtap: entered promiscuous mode
[   66.305000][ T5188] veth1_macvtap: entered promiscuous mode
[   66.321220][ T5188] batman_adv: The newly added mac address (aa:aa:aa:aa=
:aa:3e) already exists on: batadv_slave_0
[   66.334443][ T5188] batman_adv: It is strongly recommended to keep mac a=
ddresses unique to avoid problems!
[   66.347433][ T5188] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   66.364590][ T5188] batman_adv: The newly added mac address (aa:aa:aa:aa=
:aa:3f) already exists on: batadv_slave_1
[   66.375515][ T5188] batman_adv: It is strongly recommended to keep mac a=
ddresses unique to avoid problems!
[   66.387573][ T5188] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   66.399784][ T5188] netdevsim netdevsim2 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   66.408658][ T5188] netdevsim netdevsim2 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   66.417776][ T5188] netdevsim netdevsim2 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   66.427420][ T5188] netdevsim netdevsim2 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   66.499007][  T134] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   66.507906][  T134] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   66.537892][   T51] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   66.546807][   T51] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   69.815443][   T12] bridge_slave_1: left allmulticast mode
[   69.821395][   T12] bridge_slave_1: left promiscuous mode
[   69.844241][   T12] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   69.859472][   T12] bridge_slave_0: left allmulticast mode
[   69.867932][   T12] bridge_slave_0: left promiscuous mode
[   69.873969][   T12] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   70.095084][   T12] bond0 (unregistering): (slave bond_slave_0): Releasi=
ng backup interface
[   70.107948][   T12] bond0 (unregistering): (slave bond_slave_1): Releasi=
ng backup interface
[   70.118543][   T12] bond0 (unregistering): Released all slaves
[   70.239777][   T12] hsr_slave_0: left promiscuous mode
[   70.246490][   T12] hsr_slave_1: left promiscuous mode
[   70.255808][   T12] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_0
[   70.265531][   T12] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[   70.283319][   T12] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_1
[   70.290777][   T12] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[   70.316399][   T12] veth1_macvtap: left promiscuous mode
[   70.323105][   T12] veth0_macvtap: left promiscuous mode
[   70.328757][   T12] veth1_vlan: left promiscuous mode
[   70.335500][   T12] veth0_vlan: left promiscuous mode
[   70.689807][   T12] team0 (unregistering): Port device team_slave_1 remo=
ved
[   70.718877][   T12] team0 (unregistering): Port device team_slave_0 remo=
ved
[   71.258531][   T12] netdevsim netdevsim2 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   71.857737][ T1248] ieee802154 phy0 wpan0: encryption failed: -22
[   71.871811][ T1248] ieee802154 phy1 wpan1: encryption failed: -22
[   72.118696][   T12] netdevsim netdevsim2 netdevsim2 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   72.177872][   T12] netdevsim netdevsim2 netdevsim1 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   72.269874][   T12] netdevsim netdevsim2 netdevsim0 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   72.413143][   T12] bridge_slave_1: left allmulticast mode
[   72.418935][   T12] bridge_slave_1: left promiscuous mode
[   72.427494][   T12] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   72.440417][   T12] bridge_slave_0: left allmulticast mode
[   72.448397][   T12] bridge_slave_0: left promiscuous mode
[   72.455186][   T12] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   72.738209][   T12] bond0 (unregistering): (slave bond_slave_0): Releasi=
ng backup interface
[   72.749757][   T12] bond0 (unregistering): (slave bond_slave_1): Releasi=
ng backup interface
[   72.760471][   T12] bond0 (unregistering): Released all slaves
[   73.080824][   T12] ------------[ cut here ]------------
[   73.086430][   T12] WARNING: CPU: 0 PID: 12 at net/wireless/core.c:1197 =
_cfg80211_unregister_wdev+0x46d/0x560
[   73.096902][   T12] Modules linked in:
[   73.100847][   T12] CPU: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.10.0=
-rc6-syzkaller-00223-gc6653f49e4fd-dirty #0
[   73.111921][   T12] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[   73.122420][   T12] Workqueue: netns cleanup_net
[   73.127239][   T12] RIP: 0010:_cfg80211_unregister_wdev+0x46d/0x560
[   73.134251][   T12] Code: 0f b6 04 38 84 c0 0f 85 ec 00 00 00 41 80 65 0=
0 fe 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 04 07 c5 f=
6 90 <0f> 0b 90 e9 61 fc ff ff e8 f6 06 c5 f6 c6 05 2c ac c6 04 01 90 48
[   73.154633][   T12] RSP: 0018:ffffc90000117798 EFLAGS: 00010293
[   73.160724][   T12] RAX: ffffffff8ad120ac RBX: 0000000000000000 RCX: fff=
f8880176c5a00
[   73.169098][   T12] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   73.177679][   T12] RBP: ffff888068618000 R08: ffffffff8ad11d02 R09: 1ff=
ffffff1ebcdac
[   73.186247][   T12] R10: dffffc0000000000 R11: fffffbfff1ebcdad R12: 000=
0000000000001
[   73.194767][   T12] R13: ffff88801cf7ccb0 R14: ffff888068618700 R15: dff=
ffc0000000000
[   73.203072][   T12] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[   73.212323][   T12] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   73.218895][   T12] CR2: 000055f5b8852950 CR3: 000000000e132000 CR4: 000=
00000003506f0
[   73.227244][   T12] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   73.235570][   T12] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   73.243988][   T12] Call Trace:
[   73.247277][   T12]  <TASK>
[   73.250193][   T12]  ? __warn+0x163/0x4e0
[   73.254816][   T12]  ? _cfg80211_unregister_wdev+0x46d/0x560
[   73.260665][   T12]  ? report_bug+0x2b3/0x500
[   73.265522][   T12]  ? _cfg80211_unregister_wdev+0x46d/0x560
[   73.271592][   T12]  ? handle_bug+0x3e/0x70
[   73.276016][   T12]  ? exc_invalid_op+0x1a/0x50
[   73.280956][   T12]  ? asm_exc_invalid_op+0x1a/0x20
[   73.286396][   T12]  ? _cfg80211_unregister_wdev+0xc2/0x560
[   73.292211][   T12]  ? _cfg80211_unregister_wdev+0x46c/0x560
[   73.298035][   T12]  ? _cfg80211_unregister_wdev+0x46d/0x560
[   73.303878][   T12]  ? _cfg80211_unregister_wdev+0x46c/0x560
[   73.309708][   T12]  ieee80211_remove_interfaces+0x525/0x720
[   73.315641][   T12]  ? ieee80211_unregister_hw+0x55/0x2c0
[   73.321227][   T12]  ? __pfx_ieee80211_remove_interfaces+0x10/0x10
[   73.327613][   T12]  ieee80211_unregister_hw+0x5d/0x2c0
[   73.333058][   T12]  mac80211_hwsim_del_radio+0x2c2/0x4c0
[   73.338612][   T12]  ? __pfx_mac80211_hwsim_del_radio+0x10/0x10
[   73.344761][   T12]  hwsim_exit_net+0x5c1/0x670
[   73.349450][   T12]  ? __pfx_hwsim_exit_net+0x10/0x10
[   73.354809][   T12]  ? __ip_vs_dev_cleanup_batch+0x239/0x260
[   73.360650][   T12]  cleanup_net+0x802/0xcc0
[   73.365129][   T12]  ? __pfx_cleanup_net+0x10/0x10
[   73.370092][   T12]  ? process_scheduled_works+0x945/0x1830
[   73.375946][   T12]  process_scheduled_works+0xa2c/0x1830
[   73.381548][   T12]  ? __pfx_process_scheduled_works+0x10/0x10
[   73.387971][   T12]  ? assign_work+0x364/0x3d0
[   73.392920][   T12]  worker_thread+0x86d/0xd50
[   73.397535][   T12]  ? __kthread_parkme+0x169/0x1d0
[   73.402621][   T12]  ? __pfx_worker_thread+0x10/0x10
[   73.407745][   T12]  kthread+0x2f0/0x390
[   73.411959][   T12]  ? __pfx_worker_thread+0x10/0x10
[   73.417079][   T12]  ? __pfx_kthread+0x10/0x10
[   73.421677][   T12]  ret_from_fork+0x4b/0x80
[   73.426151][   T12]  ? __pfx_kthread+0x10/0x10
[   73.430832][   T12]  ret_from_fork_asm+0x1a/0x30
[   73.435683][   T12]  </TASK>
[   73.438739][   T12] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   73.446004][   T12] CPU: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.10.0=
-rc6-syzkaller-00223-gc6653f49e4fd-dirty #0
[   73.456604][   T12] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[   73.466655][   T12] Workqueue: netns cleanup_net
[   73.471414][   T12] Call Trace:
[   73.474709][   T12]  <TASK>
[   73.477655][   T12]  dump_stack_lvl+0x241/0x360
[   73.482346][   T12]  ? __pfx_dump_stack_lvl+0x10/0x10
[   73.487561][   T12]  ? __pfx__printk+0x10/0x10
[   73.492183][   T12]  ? _printk+0xd5/0x120
[   73.496355][   T12]  ? vscnprintf+0x5d/0x90
[   73.500704][   T12]  panic+0x349/0x860
[   73.504805][   T12]  ? __warn+0x172/0x4e0
[   73.509075][   T12]  ? __pfx_panic+0x10/0x10
[   73.513494][   T12]  ? show_trace_log_lvl+0x4e6/0x520
[   73.518728][   T12]  ? ret_from_fork_asm+0x1a/0x30
[   73.523686][   T12]  __warn+0x346/0x4e0
[   73.527674][   T12]  ? _cfg80211_unregister_wdev+0x46d/0x560
[   73.533569][   T12]  report_bug+0x2b3/0x500
[   73.537892][   T12]  ? _cfg80211_unregister_wdev+0x46d/0x560
[   73.543696][   T12]  handle_bug+0x3e/0x70
[   73.547850][   T12]  exc_invalid_op+0x1a/0x50
[   73.552387][   T12]  asm_exc_invalid_op+0x1a/0x20
[   73.557264][   T12] RIP: 0010:_cfg80211_unregister_wdev+0x46d/0x560
[   73.563690][   T12] Code: 0f b6 04 38 84 c0 0f 85 ec 00 00 00 41 80 65 0=
0 fe 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 04 07 c5 f=
6 90 <0f> 0b 90 e9 61 fc ff ff e8 f6 06 c5 f6 c6 05 2c ac c6 04 01 90 48
[   73.583293][   T12] RSP: 0018:ffffc90000117798 EFLAGS: 00010293
[   73.589358][   T12] RAX: ffffffff8ad120ac RBX: 0000000000000000 RCX: fff=
f8880176c5a00
[   73.597318][   T12] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   73.605284][   T12] RBP: ffff888068618000 R08: ffffffff8ad11d02 R09: 1ff=
ffffff1ebcdac
[   73.613250][   T12] R10: dffffc0000000000 R11: fffffbfff1ebcdad R12: 000=
0000000000001
[   73.621239][   T12] R13: ffff88801cf7ccb0 R14: ffff888068618700 R15: dff=
ffc0000000000
[   73.629242][   T12]  ? _cfg80211_unregister_wdev+0xc2/0x560
[   73.635048][   T12]  ? _cfg80211_unregister_wdev+0x46c/0x560
[   73.640870][   T12]  ? _cfg80211_unregister_wdev+0x46c/0x560
[   73.646705][   T12]  ieee80211_remove_interfaces+0x525/0x720
[   73.652529][   T12]  ? ieee80211_unregister_hw+0x55/0x2c0
[   73.658195][   T12]  ? __pfx_ieee80211_remove_interfaces+0x10/0x10
[   73.664568][   T12]  ieee80211_unregister_hw+0x5d/0x2c0
[   73.669955][   T12]  mac80211_hwsim_del_radio+0x2c2/0x4c0
[   73.675512][   T12]  ? __pfx_mac80211_hwsim_del_radio+0x10/0x10
[   73.681583][   T12]  hwsim_exit_net+0x5c1/0x670
[   73.686317][   T12]  ? __pfx_hwsim_exit_net+0x10/0x10
[   73.691541][   T12]  ? __ip_vs_dev_cleanup_batch+0x239/0x260
[   73.697357][   T12]  cleanup_net+0x802/0xcc0
[   73.701800][   T12]  ? __pfx_cleanup_net+0x10/0x10
[   73.706737][   T12]  ? process_scheduled_works+0x945/0x1830
[   73.712531][   T12]  process_scheduled_works+0xa2c/0x1830
[   73.718085][   T12]  ? __pfx_process_scheduled_works+0x10/0x10
[   73.724060][   T12]  ? assign_work+0x364/0x3d0
[   73.728641][   T12]  worker_thread+0x86d/0xd50
[   73.733244][   T12]  ? __kthread_parkme+0x169/0x1d0
[   73.738257][   T12]  ? __pfx_worker_thread+0x10/0x10
[   73.743365][   T12]  kthread+0x2f0/0x390
[   73.747424][   T12]  ? __pfx_worker_thread+0x10/0x10
[   73.752533][   T12]  ? __pfx_kthread+0x10/0x10
[   73.757113][   T12]  ret_from_fork+0x4b/0x80
[   73.761518][   T12]  ? __pfx_kthread+0x10/0x10
[   73.766100][   T12]  ret_from_fork_asm+0x1a/0x30
[   73.770872][   T12]  </TASK>
[   73.774152][   T12] Kernel Offset: disabled
[   73.778533][   T12] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2801630060=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D10e59fbe980000


Tested on:

commit:         c6653f49 Merge tag 'powerpc-6.10-4' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D864caee5f78cab5=
1
dashboard link: https://syzkaller.appspot.com/bug?extid=3D705c61d60b091ef42=
c04
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D116cb7c19800=
00


