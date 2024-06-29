Return-Path: <linux-kernel+bounces-234712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A14091C9BB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E0E284572
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC464C;
	Sat, 29 Jun 2024 00:14:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886B365
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 00:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719620046; cv=none; b=Rd4SxCnZlAdF9cPBQrR2hKIH7o5cCbmPOMQuAGv0rGwOZ0ZjG7TUMt35c2Um38XufiswllC1Hinyp4lI4LOrLDgQBcbIyOOC1yb7U9iCM25iGJaYybsW7ZqMNgRj43D2ySECgF6OQVLKegy61mlJHHG/L2S10Po7OVANfHsKMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719620046; c=relaxed/simple;
	bh=HAyuOMpIa2tmGIsj1yAUPksip4NWZXQ5+at8AiPpbmk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AL5VLS0hZZSdG53sJLQ9cdQKlIHkqLg4EipRoZjuE1fgdwziy6HYijwDhiGQU0W5AawAY40IXCYKzqZYF3Xbexd12/6bEtytvTdf13OmIZNDwsa+WXIF+n4NCWrOImSiqqsKLwKD6tNHXdXfgTnnLdSsuYrVk3Z6UtUOarLiOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f61fca8c40so120877839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719620044; x=1720224844;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2E4/GsjMcjQZAkl8AL3UR0DgYZ4i/2dksjd4KlVUDB0=;
        b=wpS1uiekwD6KKpjq/51iboWsLxLwY9MRowoysS/dW1qP1mBiMtwoJhIlYQ/wIo8VWQ
         vLx3eYsXKteIKCK8MUJm/h8LVS4xB73vHzzpcGZJBcsNHeCG/ci46VoSlGDi8fRPW7fM
         QQg6CMUxLPlw9ttyv8srbFef4yl2uWrmeqyKsUnR+goxpUsODrmIW2jr5TXjGNb1DErk
         +wC+S8LIwE10hc6A51FUmwEaANa1pTLlTP7634dtrNAlhaOfDJx20NP9isUqu2ltFRS6
         772ayfeJ3JJMwwDKxYejcencdUBaqX22JqyfL4G43UhPTL9uURjbTbjj1RvDEFp2KPZk
         L8fg==
X-Gm-Message-State: AOJu0YyLsA1fzu3BAVD9jIG4ZKRHV8WDGB9uVcdNbgRBraCQPDsbB1CB
	8qH0M2FR7lajel7OlpMURj8l6tYz5rJc1sge7xjcx4ct9b6rkz1M7YXfNVyZidCanC1CqouJ/6g
	0hefUttdMmy9keb0/tr/Vq/jFtflpSPhX7NLWxIOXk3OLfYJPYvGvgDU=
X-Google-Smtp-Source: AGHT+IEHHkNBIx5aAFbqAhsmVMOf0PpVNjlmuySqV8T5vWVUvIGpIUAqWI1cq0iEM52Uu+waxrf2jlMhKPh6g/1dEAi6tAXPiXSJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2504:b0:4b0:b123:d9d with SMTP id
 8926c6da1cb9f-4b9efc75e9amr1374785173.5.1719620043855; Fri, 28 Jun 2024
 17:14:03 -0700 (PDT)
Date: Fri, 28 Jun 2024 17:14:03 -0700
In-Reply-To: <CAMc0M-_zYDKOk0KYd_zBOC1XeC2JvyCUNhHZU8be5S4sW3FS7g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dce49b061bfc3dbc@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_mode_create_lease_ioctl
From: syzbot <syzbot+6754751ad05524dae739@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fg: CoreSight Configuration manager initialised
[    5.554271][    T1] gnss: GNSS driver registered with major 478
[    5.614826][    T1] usbcore: registered new interface driver snd-usb-aud=
io
[    5.616707][    T1] usbcore: registered new interface driver snd-ua101
[    5.618430][    T1] usbcore: registered new interface driver snd-usb-cai=
aq
[    5.620204][    T1] usbcore: registered new interface driver snd-usb-6fi=
re
[    5.622004][    T1] usbcore: registered new interface driver snd-usb-hif=
ace
[    5.623809][    T1] usbcore: registered new interface driver snd-bcd2000
[    5.625591][    T1] usbcore: registered new interface driver snd_usb_pod
[    5.627398][    T1] usbcore: registered new interface driver snd_usb_pod=
hd
[    5.629181][    T1] usbcore: registered new interface driver snd_usb_ton=
eport
[    5.631021][    T1] usbcore: registered new interface driver snd_usb_var=
iax
[    5.678593][    T1] NET: Registered PF_LLC protocol family
[    5.679960][    T1] GACT probability on
[    5.680831][    T1] Mirror/redirect action on
[    5.681938][    T1] Simple TC action Loaded
[    5.684540][    T1] netem: version 1.3
[    5.685447][    T1] u32 classifier
[    5.686408][    T1]     Performance counters on
[    5.687365][    T1]     input device check on
[    5.688298][    T1]     Actions configured
[    5.699675][    T1] xt_time: kernel timezone is -0000
[    5.700966][    T1] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
[    5.702524][    T1] IPVS: Connection hash table configured (size=3D4096,=
 memory=3D32Kbytes)
[    5.704746][    T1] IPVS: ipvs loaded.
[    5.705643][    T1] IPVS: [rr] scheduler registered.
[    5.706901][    T1] IPVS: [wrr] scheduler registered.
[    5.708018][    T1] IPVS: [lc] scheduler registered.
[    5.709123][    T1] IPVS: [wlc] scheduler registered.
[    5.710242][    T1] IPVS: [fo] scheduler registered.
[    5.711340][    T1] IPVS: [ovf] scheduler registered.
[    5.712471][    T1] IPVS: [lblc] scheduler registered.
[    5.713610][    T1] IPVS: [lblcr] scheduler registered.
[    5.714765][    T1] IPVS: [dh] scheduler registered.
[    5.715857][    T1] IPVS: [sh] scheduler registered.
[    5.717066][    T1] IPVS: [mh] scheduler registered.
[    5.718160][    T1] IPVS: [sed] scheduler registered.
[    5.719266][    T1] IPVS: [nq] scheduler registered.
[    5.720363][    T1] IPVS: [twos] scheduler registered.
[    5.721640][    T1] IPVS: [sip] pe registered.
[    5.722759][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    5.725755][    T1] gre: GRE over IPv4 demultiplexor driver
[    5.727112][    T1] ip_gre: GRE over IPv4 tunneling driver
[    5.732258][    T1] IPv4 over IPsec tunneling driver
[    5.737153][    T1] Initializing XFRM netlink socket
[    5.739156][    T1] IPsec XFRM device driver
[    5.740433][    T1] NET: Registered PF_INET6 protocol family
[    5.748663][    T1] Segment Routing with IPv6
[    5.749695][    T1] RPL Segment Routing with IPv6
[    5.750919][    T1] In-situ OAM (IOAM) with IPv6
[    5.752137][    T1] mip6: Mobile IPv6
[    5.754848][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    5.759136][    T1] ip6_gre: GRE over IPv6 tunneling driver
[    5.761779][    T1] NET: Registered PF_PACKET protocol family
[    5.763124][    T1] NET: Registered PF_KEY protocol family
[    5.764596][    T1] Bridge firewalling registered
[    5.766655][    T1] NET: Registered PF_X25 protocol family
[    5.767957][    T1] X25: Linux Version 0.2
[    5.772797][    T1] NET: Registered PF_NETROM protocol family
[    5.783449][    T1] NET: Registered PF_ROSE protocol family
[    5.784922][    T1] NET: Registered PF_AX25 protocol family
[    5.786291][    T1] can: controller area network core
[    5.787573][    T1] NET: Registered PF_CAN protocol family
[    5.788797][    T1] can: raw protocol
[    5.789691][    T1] can: broadcast manager protocol
[    5.790814][    T1] can: netlink gateway - max_hops=3D1
[    5.792011][    T1] can: SAE J1939
[    5.792825][    T1] can: isotp protocol (max_pdu_size 8300)
[    5.794397][    T1] Bluetooth: RFCOMM TTY layer initialized
[    5.795654][    T1] Bluetooth: RFCOMM socket layer initialized
[    5.797116][    T1] Bluetooth: RFCOMM ver 1.11
[    5.798151][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.799499][    T1] Bluetooth: BNEP filters: protocol multicast
[    5.800816][    T1] Bluetooth: BNEP socket layer initialized
[    5.802096][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[    5.803361][    T1] Bluetooth: CMTP socket layer initialized
[    5.804618][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    5.806596][    T1] Bluetooth: HIDP socket layer initialized
[    5.809888][    T1] NET: Registered PF_RXRPC protocol family
[    5.811217][    T1] Key type rxrpc registered
[    5.812185][    T1] Key type rxrpc_s registered
[    5.813647][    T1] NET: Registered PF_KCM protocol family
[    5.815384][    T1] lec:lane_module_init: lec.c: initialized
[    5.816776][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[    5.818148][    T1] l2tp_core: L2TP core driver, V2.0
[    5.819296][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[    5.820515][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[    5.821931][    T1] l2tp_netlink: L2TP netlink interface
[    5.823214][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[    5.824657][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[    5.826390][    T1] NET: Registered PF_PHONET protocol family
[    5.827807][    T1] 8021q: 802.1Q VLAN Support v1.8
[    5.836194][    T1] DCCP: Activated CCID 2 (TCP-like)
[    5.837377][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[    5.838965][    T1] DCCP is deprecated and scheduled to be removed in 20=
25, please contact the netdev mailing list
[    5.841512][    T1] sctp: Hash tables configured (bind 32/56)
[    5.843863][    T1] NET: Registered PF_RDS protocol family
[    5.845580][    T1] Registered RDS/infiniband transport
[    5.847501][    T1] Registered RDS/tcp transport
[    5.848551][    T1] tipc: Activated (version 2.0.0)
[    5.849972][    T1] NET: Registered PF_TIPC protocol family
[    5.851789][    T1] tipc: Started in single node mode
[    5.853435][    T1] NET: Registered PF_SMC protocol family
[    5.854739][    T1] 9pnet: Installing 9P2000 support
[    5.856239][    T1] NET: Registered PF_CAIF protocol family
[    5.859758][    T1] NET: Registered PF_IEEE802154 protocol family
[    5.861187][    T1] Key type dns_resolver registered
[    5.862270][    T1] Key type ceph registered
[    5.863561][    T1] libceph: loaded (mon/osd proto 15/24)
[    5.865484][    T1] batman_adv: B.A.T.M.A.N. advanced 2024.2 (compatibil=
ity version 15) loaded
[    5.867585][    T1] openvswitch: Open vSwitch switching datapath
[    5.870517][    T1] NET: Registered PF_VSOCK protocol family
[    5.871927][    T1] mpls_gso: MPLS GSO support
[    6.318229][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 1 crossnode level
[    6.330188][    T1] registered taskstats version 1
[    6.331557][    T1] Loading compiled-in X.509 certificates
[    6.336923][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: d82365048398fac280b79dbcef24e55526f29c91'
[    6.487723][    T1] zswap: loaded using pool lzo/zsmalloc
[    6.491613][    T1] Demotion targets for Node 0: null
[    6.492833][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[    6.496265][    T1] page_owner is disabled
[    6.497624][    T1] Key type .fscrypt registered
[    6.498674][    T1] Key type fscrypt-provisioning registered
[    6.501890][    T1] kAFS: Red Hat AFS client v0.1 registering.
[    6.521210][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[    6.523390][    T1] Key type big_key registered
[    6.524478][    T1] Key type encrypted registered
[    6.525614][    T1] ima: No TPM chip found, activating TPM-bypass!
[    6.527167][    T1] Loading compiled-in module X.509 certificates
[    6.530971][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: d82365048398fac280b79dbcef24e55526f29c91'
[    6.533324][    T1] ima: Allocated hash algorithm: sha256
[    6.534658][    T1] ima: No architecture policies found
[    6.536167][    T1] evm: Initialising EVM extended attributes:
[    6.537466][    T1] evm: security.selinux (disabled)
[    6.538564][    T1] evm: security.SMACK64
[    6.539461][    T1] evm: security.SMACK64EXEC
[    6.540433][    T1] evm: security.SMACK64TRANSMUTE
[    6.541489][    T1] evm: security.SMACK64MMAP
[    6.542478][    T1] evm: security.apparmor (disabled)
[    6.543608][    T1] evm: security.ima
[    6.544426][    T1] evm: security.capability
[    6.545377][    T1] evm: HMAC attrs: 0x1
[    6.549186][    T1] printk: legacy console [netcon0] enabled
[    6.550495][    T1] netconsole: network logging started
[    6.551983][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[    6.554178][    T1] rdma_rxe: loaded
[    6.555332][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[    6.558672][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    6.560977][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[    6.563095][    T1] clk: Disabling unused clocks
[    6.564982][ T2208] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[    6.566138][    T1] PM: genpd: Disabling unused power domains
[    6.567322][ T2208] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[    6.568518][    T1] ALSA device list:
[    6.571132][    T1]   #0: Dummy 1
[    6.571832][    T1]   #1: Loopback 1
[    6.572585][    T1]   #2: Virtual MIDI Card 1
[   64.516640][   T57] nvme nvme0: I/O tag 20 (1014) QID 0 timeout, complet=
ion polled
[   69.626924][ T2208] cfg80211: failed to load regulatory.db
[  125.947012][   T57] nvme nvme0: I/O tag 12 (100c) QID 0 timeout, complet=
ion polled
[  187.386634][   T57] nvme nvme0: I/O tag 13 (100d) QID 0 timeout, complet=
ion polled
[  248.826889][   T57] nvme nvme0: I/O tag 14 (100e) QID 0 timeout, complet=
ion polled
[  284.666278][   T31] INFO: task swapper/0:1 blocked for more than 143 sec=
onds.
[  284.667976][   T31]       Not tainted 6.10.0-rc5-syzkaller-00071-g59ed70=
ca3c29-dirty #0
[  284.669744][   T31] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[  284.671615][   T31] task:swapper/0       state:D stack:0     pid:1     t=
gid:1     ppid:0      flags:0x0000000c
[  284.673819][   T31] Call trace:
[  284.674529][   T31]  __switch_to+0x314/0x560
[  284.675483][   T31]  __schedule+0x14ac/0x24d8
[  284.676569][   T31]  schedule+0xbc/0x238
[  284.677462][   T31]  wait_for_device_probe+0x120/0x1c0
[  284.678613][   T31]  prepare_namespace+0x5c/0x11c
[  284.679676][   T31]  kernel_init_freeable+0x360/0x478
[  284.680802][   T31]  kernel_init+0x24/0x2a0
[  284.681739][   T31]  ret_from_fork+0x10/0x20
[  284.682768][   T31]=20
[  284.682768][   T31] Showing all locks held in the system:
[  284.684437][   T31] 2 locks held by kworker/u8:1/13:
[  284.685537][   T31]  #0: ffff0000c0031148 ((wq_completion)events_unbound=
){+.+.}-{0:0}, at: process_one_work+0x624/0x15b8
[  284.688122][   T31]  #1: ffff800094f97c20 ((work_completion)(&(&kfence_t=
imer)->work)){+.+.}-{0:0}, at: process_one_work+0x6a0/0x15b8
[  284.690763][   T31] 1 lock held by khungtaskd/31:
[  284.691809][   T31]  #0: ffff80008f3779e0 (rcu_read_lock){....}-{1:2}, a=
t: rcu_lock_acquire+0xc/0x44
[  284.693868][   T31] 3 locks held by kworker/u8:5/315:
[  284.694984][   T31]  #0: ffff0000c181d148 ((wq_completion)async){+.+.}-{=
0:0}, at: process_one_work+0x624/0x15b8
[  284.697322][   T31]  #1: ffff8000982f7c20 ((work_completion)(&entry->wor=
k)){+.+.}-{0:0}, at: process_one_work+0x6a0/0x15b8
[  284.699762][   T31]  #2: ffff0000c27d01b0 (&dev->mutex){....}-{3:3}, at:=
 __driver_attach_async_helper+0xc8/0x230
[  284.702020][   T31] 1 lock held by hwrng/1370:
[  284.703020][   T31]  #0: ffff800090adf948 (reading_mutex){+.+.}-{3:3}, a=
t: hwrng_fillfn+0x6c/0x2b4
[  284.705041][   T31]=20
[  284.705542][   T31] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[  284.705542][   T31]=20
[  284.707474][   T31] Kernel panic - not syncing: hung_task: blocked tasks
[  284.708940][   T31] CPU: 0 PID: 31 Comm: khungtaskd Not tainted 6.10.0-r=
c5-syzkaller-00071-g59ed70ca3c29-dirty #0
[  284.711186][   T31] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  284.713328][   T31] Call trace:
[  284.714019][   T31]  dump_backtrace+0x1b8/0x1e4
[  284.715028][   T31]  show_stack+0x2c/0x3c
[  284.715915][   T31]  dump_stack_lvl+0xe4/0x150
[  284.716944][   T31]  dump_stack+0x1c/0x28
[  284.717883][   T31]  panic+0x300/0x884
[  284.718760][   T31]  hung_task_panic+0x0/0x2c
[  284.719773][   T31]  kthread+0x288/0x310
[  284.720697][   T31]  ret_from_fork+0x10/0x20
[  284.721698][   T31] SMP: stopping secondary CPUs
[  284.722840][   T31] Kernel Offset: disabled
[  284.723807][   T31] CPU features: 0x00,00000103,80100128,42017203
[  284.725213][   T31] Memory Limit: none
[  285.124581][   T31] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build636392712=3D/tmp/go-build -gno-record-gcc=
-switches'

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
GOOS=3Dlinux GOARCH=3Darm64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dedc5149ad2ab7a38db6b3bcb1b594e0264a92163 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240621-090414'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_arm64 " -o ./bin/linux_arm64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Darm64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dedc5149ad2ab7a38db6b3bcb1b594e0264a92163 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240621-090414'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_arm64 " -o ./bin/linux_arm64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_arm64
aarch64-linux-gnu-g++ -o ./bin/linux_arm64/syz-executor executor/executor.c=
c \
	-O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-l=
arger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-ove=
rflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -stati=
c-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linux=3D1=
 -DGOARCH_arm64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"edc5149ad2ab7a38db6b3bcb1b594e0264=
a92163\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D17c2e3a9980000


Tested on:

commit:         59ed70ca Merge remote-tracking branch 'tglx/devmsi-arm..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.g=
it for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4e37fbf116261f0=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3D6754751ad05524dae=
739
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D167172d19800=
00


