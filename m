Return-Path: <linux-kernel+bounces-289220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174FC95434C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25989B2A522
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01A513C66F;
	Fri, 16 Aug 2024 07:45:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C413B588
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794304; cv=none; b=TINNsiCTpDciPIoQHpyAPe6RtuYMXJijJz22T00wvv1FYMB7LPLNsnGGPR3ZBBCCkMPNca/GrBPhZcDzJQOfVASIOek1h+VXJmE1bRrV+QpLwSMfKyu0gIKzs+fi+m3Tqbf4Hj9doh8D3iD+3mDzZSaophMb6uexhQxPave/jG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794304; c=relaxed/simple;
	bh=KXYXJNoPj4RraPr1cnqkt8Y3TRHNGpZsxnxtn9TFF+E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XvSZ8MvzYkvhATHx1KKe/Y4qX/FzNL8vCWeW2x1vh4jNVpXJRPsEnifg2z5V4HgHQ14yspxpDfWtlTD/qaPIycUZVAl/htRGE/1LRW+LGI/acQa8EaREaJ+tkK802656DSpnkxHO2DURlSxSf6cxfempmChe6oVOCXcuzNzVWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d27200924so6886125ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723794302; x=1724399102;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSOI2iVZQjOtg7JrANpNgiqgu/vTAW36z8T/RD4UL6g=;
        b=hO5TfNOb3vtbDzw+7rt7pKFSDD+eXhHoBlep8fKgCQYtSk1K4rrdHoRO2xVFsHhZYV
         syEuoU6k1gRZYetTyXmupRAtV7hny0YMF7cjx68a4yRYTcUS6qFV/T8dsJ6BUkwFbNci
         IUaWcQEwp4RxVwDU93nyNBT3XsbfTJRjskvGYFShIJnrpLVJKWWTDje6glx72BXt12mS
         3oEu1XczYrOak7vkR+1w5duEurhfkeCsqRJZ60+1+JHnW1OKbVjcXJivGgvb2Z7M7f26
         3N9x/V2GODTlRwbHJxZv2+OgUp3TBNklr2Ljprg86yAME5yKbf4jAtzcN4X6EF6TYDO+
         OjTg==
X-Gm-Message-State: AOJu0YxOZruUhaZi1QQinTqI8PAJp9QqJ/pC7gp1oUJv45DNVvTqvipG
	EdJ+9FHYMPs05OZDZPXlotNkbresOjkRCTa1mgruPunVXluEkFuVRV0MYx8K+8Ix7pS18F+Xbck
	uoYS8SFFV+Lebaxd9G1uryQ9aplIk9yvgt8+ItPAird0w/ua6jWqTnZo=
X-Google-Smtp-Source: AGHT+IEGAPjMlOy1xnyTs3qiasO4NsPeT7wc5H3gINI3gCce/QeyYnTXl+x8A3FaYXgk6d5r9zrixwCfsAtwe8r+ORUjacoHpcfe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:b0:396:256a:2e01 with SMTP id
 e9e14a558f8ab-39d2751a9ecmr1672895ab.1.1723794301739; Fri, 16 Aug 2024
 00:45:01 -0700 (PDT)
Date: Fri, 16 Aug 2024 00:45:01 -0700
In-Reply-To: <20240816072319.3047417-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005741f061fc8232f@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
From: syzbot <syzbot+5bdd4953bc58c8fbd6eb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 over IPv4 tunneling driver
[   22.681196][    T1] IPv4 over IPsec tunneling driver
[   22.689324][    T1] Initializing XFRM netlink socket
[   22.700521][    T1] IPsec XFRM device driver
[   22.704012][    T1] NET: Registered PF_INET6 protocol family
[   22.744667][    T1] Segment Routing with IPv6
[   22.747583][    T1] RPL Segment Routing with IPv6
[   22.759923][    T1] In-situ OAM (IOAM) with IPv6
[   22.763258][    T1] mip6: Mobile IPv6
[   22.782112][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   22.803545][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   22.821928][    T1] NET: Registered PF_PACKET protocol family
[   22.825832][    T1] NET: Registered PF_KEY protocol family
[   22.840132][    T1] Bridge firewalling registered
[   22.843436][    T1] NET: Registered PF_X25 protocol family
[   22.846894][    T1] X25: Linux Version 0.2
[   22.863254][    T1] NET: Registered PF_NETROM protocol family
[   22.880740][    T1] NET: Registered PF_ROSE protocol family
[   22.884479][    T1] NET: Registered PF_AX25 protocol family
[   22.888083][    T1] can: controller area network core
[   22.900025][    T1] NET: Registered PF_CAN protocol family
[   22.903314][    T1] can: raw protocol
[   22.905604][    T1] can: broadcast manager protocol
[   22.908918][    T1] can: netlink gateway - max_hops=3D1
[   22.929939][    T1] can: SAE J1939
[   22.932186][    T1] can: isotp protocol (max_pdu_size 8300)
[   22.936079][    T1] Bluetooth: RFCOMM TTY layer initialized
[   22.949748][    T1] Bluetooth: RFCOMM socket layer initialized
[   22.953701][    T1] Bluetooth: RFCOMM ver 1.11
[   22.956607][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   22.969813][    T1] Bluetooth: BNEP filters: protocol multicast
[   22.973928][    T1] Bluetooth: BNEP socket layer initialized
[   22.977586][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   22.989689][    T1] Bluetooth: CMTP socket layer initialized
[   22.993460][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   22.997816][    T1] Bluetooth: HIDP socket layer initialized
[   23.022653][    T1] NET: Registered PF_RXRPC protocol family
[   23.026158][    T1] Key type rxrpc registered
[   23.029041][    T1] Key type rxrpc_s registered
[   23.040527][    T1] NET: Registered PF_KCM protocol family
[   23.050194][    T1] lec:lane_module_init: lec.c: initialized
[   23.054077][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   23.058006][    T1] l2tp_core: L2TP core driver, V2.0
[   23.080024][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   23.083713][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   23.088086][    T1] l2tp_netlink: L2TP netlink interface
[   23.099814][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   23.104218][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   23.108941][    T1] NET: Registered PF_PHONET protocol family
[   23.129957][    T1] 8021q: 802.1Q VLAN Support v1.8
[   23.150332][    T1] DCCP: Activated CCID 2 (TCP-like)
[   23.153773][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   23.158446][    T1] DCCP is deprecated and scheduled to be removed in 20=
25, please contact the netdev mailing list
[   23.180124][    T1] sctp: Hash tables configured (bind 32/56)
[   23.184931][    T1] NET: Registered PF_RDS protocol family
[   23.200156][    T1] Registered RDS/infiniband transport
[   23.205108][    T1] Registered RDS/tcp transport
[   23.208128][    T1] tipc: Activated (version 2.0.0)
[   23.220459][    T1] NET: Registered PF_TIPC protocol family
[   23.225718][    T1] tipc: Started in single node mode
[   23.240226][    T1] NET: Registered PF_SMC protocol family
[   23.244293][    T1] 9pnet: Installing 9P2000 support
[   23.265164][    T1] NET: Registered PF_CAIF protocol family
[   23.282869][    T1] NET: Registered PF_IEEE802154 protocol family
[   23.287199][    T1] Key type dns_resolver registered
[   23.300985][    T1] Key type ceph registered
[   23.304269][    T1] libceph: loaded (mon/osd proto 15/24)
[   23.309066][    T1] batman_adv: B.A.T.M.A.N. advanced 2024.2 (compatibil=
ity version 15) loaded
[   23.320247][    T1] openvswitch: Open vSwitch switching datapath
[   23.333192][    T1] NET: Registered PF_VSOCK protocol family
[   23.349795][    T1] mpls_gso: MPLS GSO support
[   23.376493][    T1] IPI shorthand broadcast: enabled
[   23.389830][    T1] AES CTR mode by8 optimization enabled
[   25.056289][    T1] sched_clock: Marking stable (24900059923, 149540500)=
->(25060936007, -11335584)
[   25.091540][    T1] registered taskstats version 1
[   25.116888][    T1] Loading compiled-in X.509 certificates
[   25.144534][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 218caf1c31104bcbdeaa60830551d7c075b8594c'
[   25.644688][    T1] zswap: loaded using pool lzo/zsmalloc
[   25.660280][    T1] Demotion targets for Node 0: null
[   25.663600][    T1] Demotion targets for Node 1: null
[   25.666959][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   25.692171][    T1] Key type .fscrypt registered
[   25.695044][    T1] Key type fscrypt-provisioning registered
[   25.715809][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   25.770730][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   25.776557][    T1] Key type big_key registered
[   25.797883][    T1] Key type encrypted registered
[   25.809915][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   25.814222][    T1] ima: No TPM chip found, activating TPM-bypass!
[   25.818000][    T1] Loading compiled-in module X.509 certificates
[   25.834512][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 218caf1c31104bcbdeaa60830551d7c075b8594c'
[   25.859718][    T1] ima: Allocated hash algorithm: sha256
[   25.863869][    T1] ima: No architecture policies found
[   25.868279][    T1] evm: Initialising EVM extended attributes:
[   25.879666][    T1] evm: security.selinux (disabled)
[   25.882959][    T1] evm: security.SMACK64 (disabled)
[   25.886230][    T1] evm: security.SMACK64EXEC (disabled)
[   25.889490][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   25.909650][    T1] evm: security.SMACK64MMAP (disabled)
[   25.912931][    T1] evm: security.apparmor
[   25.915513][    T1] evm: security.ima
[   25.917844][    T1] evm: security.capability
[   25.929845][    T1] evm: HMAC attrs: 0x1
[   25.939691][    T1] PM:   Magic number: 4:983:571
[   25.942784][    T1] misc uhid: hash matches
[   25.945813][    T1] usbmon usbmon11: hash matches
[   25.948890][    T1] tty ptyb3: hash matches
[   25.970260][    T1] printk: legacy console [netcon0] enabled
[   25.973618][    T1] netconsole: network logging started
[   25.977424][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   25.994861][    T1] rdma_rxe: loaded
[   25.997880][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   26.012178][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   26.017897][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   26.042070][    T9] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   26.049216][    T9] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   26.055580][    T1] clk: Disabling unused clocks
[   26.058896][    T1] ALSA device list:
[   26.071544][    T1]   #0: Dummy 1
[   26.073615][    T1]   #1: Loopback 1
[   26.076029][    T1]   #2: Virtual MIDI Card 1
[   26.094145][    T1] md: Waiting for all devices to be available before a=
utodetect
[   26.097217][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   26.109741][    T1] md: Autodetecting RAID arrays.
[   26.111848][    T1] md: autorun ...
[   26.113413][    T1] md: ... autorun DONE.
[   26.131264][    T1] REISERFS warning (device sda1): sh-2006 read_super_b=
lock: bread failed (dev sda1, block 2, size 4096)
[   26.136001][    T1] REISERFS warning (device sda1): sh-2006 read_super_b=
lock: bread failed (dev sda1, block 16, size 4096)
[   26.160783][    T1] EXT4-fs (sda1): unable to read superblock
[   26.163576][    T1] VFS: Cannot open root device "/dev/sda1" or unknown-=
block(8,1): error -5
[   26.166627][    T1] Please append a correct "root=3D" boot option; here =
are the available partitions:
[   26.169476][    T1] 0100            4096 ram0=20
[   26.169487][    T1]  (driver?)
[   26.180457][    T1] 0101            4096 ram1=20
[   26.180475][    T1]  (driver?)
[   26.183555][    T1] 0102            4096 ram2=20
[   26.183570][    T1]  (driver?)
[   26.186554][    T1] 0103            4096 ram3=20
[   26.186567][    T1]  (driver?)
[   26.189464][    T1] 0104            4096 ram4=20
[   26.189477][    T1]  (driver?)
[   26.209634][    T1] 0105            4096 ram5=20
[   26.209649][    T1]  (driver?)
[   26.212722][    T1] 0106            4096 ram6=20
[   26.212736][    T1]  (driver?)
[   26.215719][    T1] 0107            4096 ram7=20
[   26.215732][    T1]  (driver?)
[   26.218673][    T1] 0108            4096 ram8=20
[   26.218685][    T1]  (driver?)
[   26.229675][    T1] 0109            4096 ram9=20
[   26.229693][    T1]  (driver?)
[   26.232562][    T1] 010a            4096 ram10=20
[   26.232570][    T1]  (driver?)
[   26.235354][    T1] 010b            4096 ram11=20
[   26.235363][    T1]  (driver?)
[   26.238332][    T1] 010c            4096 ram12=20
[   26.238342][    T1]  (driver?)
[   26.249650][    T1] 010d            4096 ram13=20
[   26.249668][    T1]  (driver?)
[   26.252611][    T1] 010e            4096 ram14=20
[   26.252625][    T1]  (driver?)
[   26.255434][    T1] 010f            4096 ram15=20
[   26.255442][    T1]  (driver?)
[   26.258333][    T1] fa00       262144000 nullb0=20
[   26.258345][    T1]  (driver?)
[   26.279671][    T1] 103:00000      65536 pmem0=20
[   26.279692][    T1]  driver: nd_pmem
[   26.282874][    T1] 1f00             128 mtdblock0=20
[   26.282884][    T1]  (driver?)
[   26.285857][    T1] 0800         1048729 sda=20
[   26.285870][    T1]  driver: sd
[   26.288603][    T1]   0801         1048576 sda1 00000000-01
[   26.288611][    T1]=20
[   26.299682][    T1] 0b00              64 sr0=20
[   26.299699][    T1]  driver: sr
[   26.302605][    T1] List of all bdev filesystems:
[   26.304416][    T1]  reiserfs
[   26.304425][    T1]  ext3
[   26.305640][    T1]  ext2
[   26.306861][    T1]  ext4
[   26.308117][    T1]  cramfs
[   26.309245][    T1]  squashfs
[   26.319666][    T1]  minix
[   26.320940][    T1]  vfat
[   26.322017][    T1]  msdos
[   26.323033][    T1]  exfat
[   26.324192][    T1]  bfs
[   26.325302][    T1]  iso9660
[   26.326334][    T1]  hfsplus
[   26.327509][    T1]  hfs
[   26.328690][    T1]  vxfs
[   26.339674][    T1]  sysv
[   26.340817][    T1]  v7
[   26.341954][    T1]  hpfs
[   26.343111][    T1]  ntfs3
[   26.344309][    T1]  ufs
[   26.345378][    T1]  efs
[   26.346401][    T1]  affs
[   26.347433][    T1]  romfs
[   26.348547][    T1]  qnx4
[   26.359671][    T1]  qnx6
[   26.360786][    T1]  adfs
[   26.361863][    T1]  fuseblk
[   26.362902][    T1]  udf
[   26.363882][    T1]  omfs
[   26.364680][    T1]  jfs
[   26.365583][    T1]  xfs
[   26.366568][    T1]  nilfs2
[   26.367552][    T1]  befs
[   26.368645][    T1]  ocfs2
[   26.379647][    T1]  gfs2
[   26.380792][    T1]  gfs2meta
[   26.381833][    T1]  f2fs
[   26.382986][    T1]  bcachefs
[   26.384069][    T1]  erofs
[   26.385244][    T1]  zonefs
[   26.386313][    T1]  btrfs
[   26.387398][    T1]=20
[   26.389346][    T1] Kernel panic - not syncing: VFS: Unable to mount roo=
t fs on unknown-block(8,1)
[   26.392612][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
1.0-rc3-syzkaller-00060-gd07b43284ab3-dirty #0
[   26.396470][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   26.400373][    T1] Call Trace:
[   26.401573][    T1]  <TASK>
[   26.402632][    T1]  dump_stack_lvl+0x241/0x360
[   26.404395][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[   26.406180][    T1]  ? vsnprintf+0x184/0x1da0
[   26.407823][    T1]  ? __pfx__printk+0x10/0x10
[   26.409469][    T1]  ? vscnprintf+0x5d/0x90
[   26.411073][    T1]  panic+0x349/0x860
[   26.412545][    T1]  ? __wake_up_klogd+0xcc/0x110
[   26.414317][    T1]  ? __pfx_panic+0x10/0x10
[   26.415927][    T1]  ? __wake_up_klogd+0xcc/0x110
[   26.417650][    T1]  ? do_mount_root+0xfd/0x260
[   26.419401][    T1]  mount_root_generic+0x3c3/0x3e0
[   26.421379][    T1]  ? __pfx_mount_root_generic+0x10/0x10
[   26.423297][    T1]  prepare_namespace+0xc2/0x100
[   26.425107][    T1]  kernel_init_freeable+0x476/0x5d0
[   26.426851][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   26.428845][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   26.431064][    T1]  ? __pfx_kernel_init+0x10/0x10
[   26.432937][    T1]  ? __pfx_kernel_init+0x10/0x10
[   26.434692][    T1]  ? __pfx_kernel_init+0x10/0x10
[   26.436525][    T1]  kernel_init+0x1d/0x2b0
[   26.438222][    T1]  ret_from_fork+0x4b/0x80
[   26.439816][    T1]  ? __pfx_kernel_init+0x10/0x10
[   26.441580][    T1]  ret_from_fork_asm+0x1a/0x30
[   26.443380][    T1]  </TASK>
[   26.444764][    T1] Kernel Offset: disabled
[   26.446251][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build763184766=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at e4bacdaf3
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
/syzkaller/prog.GitRevision=3De4bacdaf3417006ad6aa0d911a44b49bb25a6e1a -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240814-175600'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"e4bacdaf3417006ad6aa0d911a44b49bb2=
5a6e1a\"
/usr/bin/ld: /tmp/ccOQlpqV.o: in function `test_cover_filter()':
executor.cc:(.text+0x13e0b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/ccOQlpqV.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11837cfd980000


Tested on:

commit:         d07b4328 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7229118d88b4a71=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3D5bdd4953bc58c8fbd=
6eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D14a95dcb9800=
00


