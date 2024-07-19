Return-Path: <linux-kernel+bounces-257240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448B1937746
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 879BBB214EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628DC8624A;
	Fri, 19 Jul 2024 11:44:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951AFDDB1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389445; cv=none; b=VZH8iGnjcfUFjokOI8VcfBooYarMObv9eb7GP0F9QvZngm11Z11d6uiNWw9HqHGxcZqB0rKJpnDvjv/QV7weXtE4mP6/2gDLSYXXSaTqHY77rAQ7x9MBN0HmnloO+3JgQ1kmM2a3nLCxH0vF0hHve0G7JIrpWA6cMdt5G/GnKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389445; c=relaxed/simple;
	bh=arru+STp00rsh0zwnzFhwNpQ4Iws+hFSyEYBoJdTcYI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BnbCTINMsasDQeo7eCw8CBSyYYXhIJanAbZgo9RuFt8vzP11KgAX1t03VsE057mJbYNGcx72FUzqGFFNzZtleLRBjJElH6XTjFYmE/EdTPkY/uuwsniAcLqD35Utkq9iCkzbTuuFdowsFHKT7qmPr2X5lnZyqHduLJ2nXIRQSSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81258697716so278354139f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 04:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721389443; x=1721994243;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByDAahjmD/BBCe1O8DnoyGtSX9VJzNFyBdWAC8WFGKg=;
        b=Qt6LlfRvyefcqPGH43fj64FmaW7zNCezX8kUmqtA4octUt+05zZEm5sQZKweKXnSlL
         l/XghRJpm5BsneZD6hD2VAIRsjAsd++izShuzyXj6ORyQRlM6ntcuXUYa+RJnLkyUELd
         sjohOKdAcdhjQ17oxiGhG638WZm7lF1KEXP2c+I6Xp/kjNePOWttAhriWE/PKO5plT+s
         emFh0VECZcdHEMGcGUHEbWMvDK4/sLfmLymkWxAxXO/zVt0DMmSaFKv66+D4AIWT4Zx7
         n+qZlafgf0l0QuUHzVZBzeieVhuidMSJXW2z0NryfHqbCve19pvMNFAz3L3Y9sHkyDTT
         NSpw==
X-Forwarded-Encrypted: i=1; AJvYcCUsQ76NusgKqR2os9UFRMZRIvRzBjRjf8uJ82IGBfdluG5pgeKyIBJM1cBNDEeFyXAOKKGCR41hj7bCwNcfil4V6rw7W3n2GzG9NhE1
X-Gm-Message-State: AOJu0Yzpnz/dnUjRy5lR7BKWF4TMj+1JBJvwVQUY22I3XX+5ZZDBTymJ
	2nBXh3GPDY/a3ZfZy2lnYE2uqRFqE7Pdg5pjDFIHe1gg4qBVxF5CrZ7lWg5YABsASmzD+VgXiXM
	jKDuAKc8J7cZQEpp1/gnn5PMd3mlrAUZryIwwxcKYzzrRpzHvI4yGxao=
X-Google-Smtp-Source: AGHT+IH31x3vtCIizKBqg37Yv7ZZR+n6p2ls0u43h/d/plQuzChRNhwmHyehnlxzHwpgoxRr9VAh1wCMgQX7P4AAuhz+ztYYYOYi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a21:b0:396:dc3a:72f2 with SMTP id
 e9e14a558f8ab-396dc3a7867mr2359375ab.3.1721389442658; Fri, 19 Jul 2024
 04:44:02 -0700 (PDT)
Date: Fri, 19 Jul 2024 04:44:02 -0700
In-Reply-To: <20240719110705.1508-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004003fe061d98360f@google.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
From: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

e: registered new interface driver legousbtower
[   14.297706][    T1] usbcore: registered new interface driver usbtest
[   14.301236][    T1] usbcore: registered new interface driver usb_ehset_t=
est
[   14.304304][    T1] usbcore: registered new interface driver trancevibra=
tor
[   14.307099][    T1] usbcore: registered new interface driver uss720
[   14.308543][    T1] uss720: USB Parport Cable driver for Cables using th=
e Lucent Technologies USS720 Chip
[   14.309426][    T1] uss720: NOTE: this is a special purpose driver to al=
low nonstandard
[   14.310212][    T1] uss720: protocols (eg. bitbang) over USS720 usb to p=
arallel cables
[   14.317207][    T1] uss720: If you just want to connect to a printer, us=
e usblp instead
[   14.320387][    T1] usbcore: registered new interface driver usbsevseg
[   14.325623][    T1] usbcore: registered new interface driver yurex
[   14.346261][    T1] usbcore: registered new interface driver chaoskey
[   14.349153][    T1] usbcore: registered new interface driver sisusb
[   14.357883][    T1] usbcore: registered new interface driver lvs
[   14.363246][    T1] usbcore: registered new device driver onboard-usb-de=
v
[   14.435704][    T1] dummy_hcd dummy_hcd.0: USB Host+Gadget Emulator, dri=
ver 02 May 2005
[   14.438586][    T1] dummy_hcd dummy_hcd.0: Dummy host controller
[   14.452253][    T1] dummy_hcd dummy_hcd.0: new USB bus registered, assig=
ned bus number 1
[   14.478915][    T1] usb usb1: New USB device found, idVendor=3D1d6b, idP=
roduct=3D0002, bcdDevice=3D 6.10
[   14.480377][    T1] usb usb1: New USB device strings: Mfr=3D3, Product=
=3D2, SerialNumber=3D1
[   14.482305][    T1] usb usb1: Product: Dummy host controller
[   14.483107][    T1] usb usb1: Manufacturer: Linux 6.10.0-rc7-syzkaller-0=
0266-g4d145e3f830b-dirty dummy_hcd
[   14.484296][    T1] usb usb1: SerialNumber: dummy_hcd.0
[   14.523742][    T1] hub 1-0:1.0: USB hub found
[   14.527088][    T1] hub 1-0:1.0: 1 port detected
[   14.618793][    T1] gadgetfs: USB Gadget filesystem, version 24 Aug 2004
[   14.704674][    T1] mousedev: PS/2 mouse device common for all mice
[   14.725075][    T1] usbcore: registered new interface driver iforce
[   14.733727][    T1] usbcore: registered new interface driver xpad
[   14.736935][    T1] usbcore: registered new interface driver ati_remote2
[   14.737869][    T1] cm109: Keymap for Komunikate KIP1000 phone loaded
[   14.741372][    T1] usbcore: registered new interface driver cm109
[   14.743785][    T1] cm109: CM109 phone driver: 20080805 (C) Alfred E. He=
ggestad
[   14.746244][    T1] usbcore: registered new interface driver ims_pcu
[   14.748144][    T1] usbcore: registered new interface driver keyspan_rem=
ote
[   14.815429][    T1] rtc-pl031 9010000.pl031: registered as rtc0
[   14.829699][    T1] i2c_dev: i2c /dev entries driver
[   14.835787][    T1] usbcore: registered new interface driver i2c-tiny-us=
b
[   14.894702][    T1] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is di=
sabled. Duplicate IMA measurements will not be recorded in the IMA log.
[   14.895758][    T1] device-mapper: uevent: version 1.0.3
[   14.909774][    T1] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) init=
ialised: dm-devel@lists.linux.dev
[   14.923944][    T1] device-mapper: multipath round-robin: version 1.2.0 =
loaded
[   14.924551][    T1] device-mapper: multipath queue-length: version 0.2.0=
 loaded
[   14.925504][    T1] device-mapper: multipath service-time: version 0.3.0=
 loaded
[   14.964334][    T1] ledtrig-cpu: registered to indicate activity on CPUs
[   14.996590][    T1] iscsi: registered transport (iser)
[   15.005451][    T1] SoftiWARP attached
[   15.044338][    T1] hid: raw HID events driver (C) Jiri Kosina
[   15.052186][    T1] usbcore: registered new interface driver usbhid
[   15.052623][    T1] usbhid: USB HID core driver
[   15.082727][    T1] usbcore: registered new interface driver es2_ap_driv=
er
[   15.084118][    T1] greybus: registered new driver hid
[   15.086685][    T1] greybus: registered new driver gbphy
[   15.088955][    T1] gb_gbphy: registered new driver usb
[   15.138911][    T1] hw perfevents: enabled with armv8_pmuv3 PMU driver, =
7 counters available
[   15.179956][    T1]  cs_system_cfg: CoreSight Configuration manager init=
ialised
[   15.293156][    T1] gnss: GNSS driver registered with major 495
[   15.885241][    T1] usbcore: registered new interface driver snd-usb-aud=
io
[   15.887644][    T1] usbcore: registered new interface driver snd-ua101
[   15.890191][    T1] usbcore: registered new interface driver snd-usb-cai=
aq
[   15.893217][    T1] usbcore: registered new interface driver snd-usb-6fi=
re
[   15.895807][    T1] usbcore: registered new interface driver snd-usb-hif=
ace
[   15.898509][    T1] usbcore: registered new interface driver snd-bcd2000
[   15.903568][    T1] usbcore: registered new interface driver snd_usb_pod
[   15.906285][    T1] usbcore: registered new interface driver snd_usb_pod=
hd
[   15.909046][    T1] usbcore: registered new interface driver snd_usb_ton=
eport
[   15.911554][    T1] usbcore: registered new interface driver snd_usb_var=
iax
[   16.087511][    T1] NET: Registered PF_LLC protocol family
[   16.089481][    T1] GACT probability on
[   16.090238][    T1] Mirror/redirect action on
[   16.092998][    T1] Simple TC action Loaded
[   16.122423][    T1] netem: version 1.3
[   16.124519][    T1] u32 classifier
[   16.125078][    T1]     Performance counters on
[   16.125772][    T1]     input device check on
[   16.126376][    T1]     Actions configured
[   16.179092][    T1] xt_time: kernel timezone is -0000
[   16.181605][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   16.203257][    T1] gre: GRE over IPv4 demultiplexor driver
[   16.204163][    T1] ip_gre: GRE over IPv4 tunneling driver
[   16.264721][    T1] IPv4 over IPsec tunneling driver
[   16.294064][    T1] Initializing XFRM netlink socket
[   16.297117][    T1] IPsec XFRM device driver
[   16.303386][    T1] NET: Registered PF_INET6 protocol family
[   16.418730][    T1] Segment Routing with IPv6
[   16.419572][    T1] RPL Segment Routing with IPv6
[   16.424115][    T1] In-situ OAM (IOAM) with IPv6
[   16.428352][    T1] mip6: Mobile IPv6
[   16.466648][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   16.529372][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   16.558126][    T1] NET: Registered PF_PACKET protocol family
[   16.559607][    T1] NET: Registered PF_KEY protocol family
[   16.566730][    T1] can: controller area network core
[   16.568802][    T1] NET: Registered PF_CAN protocol family
[   16.569250][    T1] can: raw protocol
[   16.569733][    T1] can: broadcast manager protocol
[   16.570472][    T1] can: netlink gateway - max_hops=3D1
[   16.573717][    T1] can: SAE J1939
[   16.574698][    T1] can: isotp protocol (max_pdu_size 8300)
[   16.582209][    T1] NET: Registered PF_KCM protocol family
[   16.590346][    T1] l2tp_core: L2TP core driver, V2.0
[   16.593329][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   16.594457][    T1] l2tp_netlink: L2TP netlink interface
[   16.597132][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   16.598043][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   16.599157][    T1] 8021q: 802.1Q VLAN Support v1.8
[   16.607654][    T1] sctp: Hash tables configured (bind 256/256)
[   16.622478][    T1] NET: Registered PF_RDS protocol family
[   16.629612][    T1] Registered RDS/infiniband transport
[   16.642670][    T1] Registered RDS/tcp transport
[   16.648213][    T1] NET: Registered PF_SMC protocol family
[   16.649869][    T1] 9pnet: Installing 9P2000 support
[   16.653711][    T1] Key type dns_resolver registered
[   16.654882][    T1] Key type ceph registered
[   16.659347][    T1] libceph: loaded (mon/osd proto 15/24)
[   16.668663][    T1] NET: Registered PF_VSOCK protocol family
[   20.295912][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 1 crossnode level
[   20.309756][    T1] registered taskstats version 1
[   20.321210][    T1] Loading compiled-in X.509 certificates
[   20.369974][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 6c63633801075204133449b0eb59bc21f2576981'
[   21.380327][    T1] zswap: loaded using pool lzo/zsmalloc
[   21.402152][    T1] Demotion targets for Node 0: null
[   21.411574][    T1] Key type .fscrypt registered
[   21.412362][    T1] Key type fscrypt-provisioning registered
[   21.424092][    T1] Key type big_key registered
[   21.425656][    T1] Key type encrypted registered
[   21.427809][    T1] ima: No TPM chip found, activating TPM-bypass!
[   21.428900][    T1] Loading compiled-in module X.509 certificates
[   21.472947][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 6c63633801075204133449b0eb59bc21f2576981'
[   21.475516][    T1] ima: Allocated hash algorithm: sha256
[   21.484104][    T1] ima: No architecture policies found
[   21.490290][    T1] evm: Initialising EVM extended attributes:
[   21.491927][    T1] evm: security.selinux (disabled)
[   21.492648][    T1] evm: security.SMACK64
[   21.493207][    T1] evm: security.SMACK64EXEC
[   21.493811][    T1] evm: security.SMACK64TRANSMUTE
[   21.494403][    T1] evm: security.SMACK64MMAP
[   21.494964][    T1] evm: security.apparmor (disabled)
[   21.495611][    T1] evm: security.ima
[   21.496119][    T1] evm: security.capability
[   21.496682][    T1] evm: HMAC attrs: 0x1
[   21.536239][    T1] printk: legacy console [netcon0] enabled
[   21.537332][    T1] netconsole: network logging started
[   21.543371][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   21.572025][    T1] input: gpio-keys as /devices/platform/gpio-keys/inpu=
t/input0
[   21.608832][    T1] rdma_rxe: loaded
[   21.626032][    T1] clk: Disabling unused clocks
[   21.626755][    T1] PM: genpd: Disabling unused power domains
[   21.627535][    T1] ALSA device list:
[   21.627890][    T1]   #0: Dummy 1
[   21.628215][    T1]   #1: Loopback 1
[   21.628521][    T1]   #2: Virtual MIDI Card 1
[   21.650309][    T1] md: Skipping autodetection of RAID arrays. (raid=3Da=
utodetect will force)
[   21.843600][    T1] EXT4-fs (vda): mounted filesystem 126e38a5-b482-40da=
-8f06-bd78886e02c1 ro with ordered data mode. Quota mode: none.
[   21.846818][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 253:0.
[   21.863144][    T1] devtmpfs: mounted
[   22.026437][    T1] Freeing unused kernel memory: 1472K
[   22.034062][    T1] Run /sbin/init as init process
[   22.160148][    T1] ------------[ cut here ]------------
[   22.167295][    T1] kernel BUG at mm/rmap.c:1152!
[   22.168319][    T1] Internal error: Oops - BUG: 00000000f2000800 [#1] PR=
EEMPT SMP
[   22.169624][    T1] Modules linked in:
[   22.171306][    T1] CPU: 1 PID: 1 Comm: init Not tainted 6.10.0-rc7-syzk=
aller-00266-g4d145e3f830b-dirty #0
[   22.172600][    T1] Hardware name: linux,dummy-virt (DT)
[   22.173409][    T1] pstate: 01400009 (nzcv daif +PAN -UAO -TCO +DIT -SSB=
S BTYPE=3D--)
[   22.174329][    T1] pc : folio_add_file_rmap_ptes+0x188/0x18c
[   22.176361][    T1] lr : set_pte_range+0xc8/0x204
[   22.176910][    T1] sp : ffff80008297bb10
[   22.177404][    T1] x29: ffff80008297bb10 x28: 0000000000000000 x27: fff=
fc1ffc009fcc0
[   22.178589][    T1] x26: 0000000000000000 x25: ffffc1ffc009fcc0 x24: fbf=
0000003783d80
[   22.179678][    T1] x23: ffffc1ffc009fcc0 x22: 0000ffff8aaa7000 x21: 000=
0000000000001
[   22.180638][    T1] x20: ffff80008297bd08 x19: ffffc1ffc009fcc0 x18: fff=
fffffffffffff
[   22.181621][    T1] x17: 0000000000000000 x16: 1e1e000000906d61 x15: 000=
0000000000001
[   22.182685][    T1] x14: ffffffffffffffff x13: 0000000000000000 x12: fff=
f800081e6a3e8
[   22.183750][    T1] x11: 0000000000000001 x10: fff00000061ad538 x9 : f0f=
0000004836b00
[   22.184873][    T1] x8 : 0000000000000010 x7 : 000000000000001f x6 : fff=
fc1ffc0000000
[   22.185831][    T1] x5 : 0000000000000000 x4 : 0000ffff8aaa7000 x3 : fbf=
0000003783d80
[   22.186755][    T1] x2 : 0000000000000001 x1 : ffffc1ffc009fcc0 x0 : 000=
00000ffffffff
[   22.188006][    T1] Call trace:
[   22.188634][    T1]  folio_add_file_rmap_ptes+0x188/0x18c
[   22.189523][    T1]  set_pte_range+0xc8/0x204
[   22.190194][    T1]  filemap_map_pages+0x1c8/0x69c
[   22.190782][    T1]  __handle_mm_fault+0xd20/0x1b30
[   22.191394][    T1]  handle_mm_fault+0x68/0x280
[   22.191967][    T1]  do_page_fault+0xf8/0x480
[   22.192558][    T1]  do_translation_fault+0xac/0xbc
[   22.193144][    T1]  do_mem_abort+0x44/0x94
[   22.193801][    T1]  el0_ia+0xa4/0x118
[   22.194388][    T1]  el0t_64_sync_handler+0xd0/0x12c
[   22.195034][    T1]  el0t_64_sync+0x19c/0x1a0
[   22.196199][    T1] Code: 52800022 52800241 9401cc4e 17ffffd3 (d4210000)=
=20
[   22.197334][    T1] ---[ end trace 0000000000000000 ]---
[   22.198247][    T1] Kernel panic - not syncing: Oops - BUG: Fatal except=
ion
[   22.199304][    T1] SMP: stopping secondary CPUs
[   22.200826][    T1] Kernel Offset: disabled
[   22.201438][    T1] CPU features: 0x00,00000006,8f17bd7c,1767f6bf
[   22.202609][    T1] Memory Limit: none
[   22.203551][    T1] Rebooting in 86400 seconds..


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
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
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
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build1339368986=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at eaeb5c15a
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
/syzkaller/prog.GitRevision=3Deaeb5c15ad704753a93bc8f8c7fc422d2a189581 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240711-172551'" "-tags=
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
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"eaeb5c15ad704753a93bc8f8c7fc422d2a=
189581\"
/usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin/l=
d: /tmp/cc8XHKWX.o: in function `test_cover_filter()':
executor.cc:(.text+0xfabc): warning: the use of `tempnam' is dangerous, bet=
ter use `mkstemp'
/usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin/l=
d: /tmp/cc8XHKWX.o: in function `Connection::Connect(char const*, char cons=
t*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x148): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D142afab5980000


Tested on:

commit:         4d145e3f Merge tag 'i2c-for-6.10-rc8' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6b5a15443200e31
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dec4b7d82bb051330f=
15a
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GN=
U Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D15d65ab59800=
00


