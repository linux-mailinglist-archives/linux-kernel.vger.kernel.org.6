Return-Path: <linux-kernel+bounces-289157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57014954285
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CE21F2122C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B749182C8E;
	Fri, 16 Aug 2024 07:16:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE620E3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792566; cv=none; b=P89SlaB2L3oPo/O2CADcRj3KxnBlDDl4x/+2GgVv0u2pk52QLL/FXqrvGp+UyzhCHMPHZNjRa0pmyBMbSMHy0TYyyyaxZdMXoXSsmvys4ayswlFNv03I/YAp5Z5MOAz+pFEccs6hW+VwShiqpIYEeWCFDn3p6CEHD4VU6vkfPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792566; c=relaxed/simple;
	bh=xuLIIRkXXwa+HMJayMJ0fynXRh/lwU3o0ZTOTflqnLc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Eneh1btpLLO8lhrCqTrjTtxSkkkXnFdqfRW/Fp+fL3FsmG+q9KDCpqorJuj5fni0PbO5/o7s9TgLuTRWMJQHC2ggMUyxTd1gct/fLsGiZwlBmNufVX+7K6eUpmqH3XsTZNTn7uyPCjaU9SDmgjH8bX4PXS5htBuunw+6szaxsas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-821dabd4625so169512039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792564; x=1724397364;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKQWVOsvijASusqy2jVtEN7D1LhL+ifNr+8eAVhJabA=;
        b=H0LL5RgKPtDvzyK0EZMx/OGGUQY4qSGNWtKJ2dCNLt2KI7l7W3Qn1QaTsGd7QkQMDc
         M1F+6BeW10o2ondh4WGUDsArKHhQmWwxsyMkfrXv4oErDTZg0/2ZzxdGVYqr4C8brXRu
         9jgmvQsEaojH1w3faF/GnQIZXkaKXY6QchUq50SuQ9vxAMcARm8fBZSpyZhAdmBYG1fG
         9BNrrKv0Xo1n6YL6cqNZf7rIrqzgS12w3mOzszzCYeGw6wAHvzM6LBLJXK1ax+udVRq1
         Hr6ne6Ozc3+V6nAS2volCcnnUKPuXu8xHXHLQ6izqHfqf9T2sFnz3eLJISWwPfwqzF6o
         tgYg==
X-Gm-Message-State: AOJu0YwjM3OaEubFh6TJnAHceRXjx5WXNvvfgLL5OoPyuQvXcVmFsTj5
	Q0SNNWBS96IIIt6cUtvrcq67+9ltmdr9PaJj/cMWTYxpFxsSXd4BNlLBUsR0hYKM4QpWFTooOEA
	YjBJucwMmR7BIkyz4UFDcw64g4XbLxid/EK+Ei6jz7BHCxM/y0+wof44=
X-Google-Smtp-Source: AGHT+IEhvFiecD9sdk6khvkUGjJ2lT2fYvq7tCQH7Q/8hduslCX7NSlw0IbQU/3RwTv78HZ39u53Wie00/Kyl7mrD7Dm/g3mzWvK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6087:b0:81f:7d7d:89fd with SMTP id
 ca18e2360f4ac-824f25e0148mr7077539f.1.1723792564033; Fri, 16 Aug 2024
 00:16:04 -0700 (PDT)
Date: Fri, 16 Aug 2024 00:16:04 -0700
In-Reply-To: <20240816065432.733582-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000722d26061fc7bbae@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
From: syzbot <syzbot+5bdd4953bc58c8fbd6eb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ver
[   22.256176][    T1] gre: GRE over IPv4 demultiplexor driver
[   22.259770][    T1] ip_gre: GRE over IPv4 tunneling driver
[   22.287563][    T1] IPv4 over IPsec tunneling driver
[   22.311919][    T1] Initializing XFRM netlink socket
[   22.315482][    T1] IPsec XFRM device driver
[   22.318978][    T1] NET: Registered PF_INET6 protocol family
[   22.365642][    T1] Segment Routing with IPv6
[   22.368543][    T1] RPL Segment Routing with IPv6
[   22.381211][    T1] In-situ OAM (IOAM) with IPv6
[   22.384937][    T1] mip6: Mobile IPv6
[   22.402582][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   22.423906][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   22.441036][    T1] NET: Registered PF_PACKET protocol family
[   22.444604][    T1] NET: Registered PF_KEY protocol family
[   22.448675][    T1] Bridge firewalling registered
[   22.472037][    T1] NET: Registered PF_X25 protocol family
[   22.475775][    T1] X25: Linux Version 0.2
[   22.491394][    T1] NET: Registered PF_NETROM protocol family
[   22.499054][    T1] NET: Registered PF_ROSE protocol family
[   22.511551][    T1] NET: Registered PF_AX25 protocol family
[   22.516042][    T1] can: controller area network core
[   22.519856][    T1] NET: Registered PF_CAN protocol family
[   22.540813][    T1] can: raw protocol
[   22.543257][    T1] can: broadcast manager protocol
[   22.546276][    T1] can: netlink gateway - max_hops=3D1
[   22.549709][    T1] can: SAE J1939
[   22.560774][    T1] can: isotp protocol (max_pdu_size 8300)
[   22.564738][    T1] Bluetooth: RFCOMM TTY layer initialized
[   22.568297][    T1] Bluetooth: RFCOMM socket layer initialized
[   22.580943][    T1] Bluetooth: RFCOMM ver 1.11
[   22.583931][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   22.587734][    T1] Bluetooth: BNEP filters: protocol multicast
[   22.600814][    T1] Bluetooth: BNEP socket layer initialized
[   22.604465][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   22.608137][    T1] Bluetooth: CMTP socket layer initialized
[   22.620818][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   22.625493][    T1] Bluetooth: HIDP socket layer initialized
[   22.642879][    T1] NET: Registered PF_RXRPC protocol family
[   22.646673][    T1] Key type rxrpc registered
[   22.649692][    T1] Key type rxrpc_s registered
[   22.671739][    T1] NET: Registered PF_KCM protocol family
[   22.676152][    T1] lec:lane_module_init: lec.c: initialized
[   22.679516][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   22.691093][    T1] l2tp_core: L2TP core driver, V2.0
[   22.694470][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   22.698571][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   22.721627][    T1] l2tp_netlink: L2TP netlink interface
[   22.725854][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   22.729901][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   22.741069][    T1] NET: Registered PF_PHONET protocol family
[   22.744990][    T1] 8021q: 802.1Q VLAN Support v1.8
[   22.766151][    T1] DCCP: Activated CCID 2 (TCP-like)
[   22.769445][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   22.791314][    T1] DCCP is deprecated and scheduled to be removed in 20=
25, please contact the netdev mailing list
[   22.798332][    T1] sctp: Hash tables configured (bind 32/56)
[   22.812708][    T1] NET: Registered PF_RDS protocol family
[   22.821126][    T1] Registered RDS/infiniband transport
[   22.826052][    T1] Registered RDS/tcp transport
[   22.828939][    T1] tipc: Activated (version 2.0.0)
[   22.851699][    T1] NET: Registered PF_TIPC protocol family
[   22.856538][    T1] tipc: Started in single node mode
[   22.860624][    T1] NET: Registered PF_SMC protocol family
[   22.871125][    T1] 9pnet: Installing 9P2000 support
[   22.892730][    T1] NET: Registered PF_CAIF protocol family
[   22.904135][    T1] NET: Registered PF_IEEE802154 protocol family
[   22.907774][    T1] Key type dns_resolver registered
[   22.921439][    T1] Key type ceph registered
[   22.924461][    T1] libceph: loaded (mon/osd proto 15/24)
[   22.941318][    T1] batman_adv: B.A.T.M.A.N. advanced 2024.2 (compatibil=
ity version 15) loaded
[   22.946449][    T1] openvswitch: Open vSwitch switching datapath
[   22.963290][    T1] NET: Registered PF_VSOCK protocol family
[   22.966983][    T1] mpls_gso: MPLS GSO support
[   22.998127][    T1] IPI shorthand broadcast: enabled
[   23.010939][    T1] AES CTR mode by8 optimization enabled
[   25.092738][    T1] sched_clock: Marking stable (24940064092, 150641100)=
->(25105710100, -15004908)
[   25.112831][    T1] registered taskstats version 1
[   25.138057][    T1] Loading compiled-in X.509 certificates
[   25.155654][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 1982cdebc9b34f571b35a9e4997953b56129a245'
[   25.634485][    T1] zswap: loaded using pool lzo/zsmalloc
[   25.651413][    T1] Demotion targets for Node 0: null
[   25.654756][    T1] Demotion targets for Node 1: null
[   25.658058][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   25.684439][    T1] Key type .fscrypt registered
[   25.687420][    T1] Key type fscrypt-provisioning registered
[   25.707223][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   25.760940][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   25.767099][    T1] Key type big_key registered
[   25.787630][    T1] Key type encrypted registered
[   25.791182][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   25.795538][    T1] ima: No TPM chip found, activating TPM-bypass!
[   25.799672][    T1] Loading compiled-in module X.509 certificates
[   25.823648][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 1982cdebc9b34f571b35a9e4997953b56129a245'
[   25.830457][    T1] ima: Allocated hash algorithm: sha256
[   25.851170][    T1] ima: No architecture policies found
[   25.855225][    T1] evm: Initialising EVM extended attributes:
[   25.858950][    T1] evm: security.selinux (disabled)
[   25.870767][    T1] evm: security.SMACK64 (disabled)
[   25.874149][    T1] evm: security.SMACK64EXEC (disabled)
[   25.877263][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   25.891255][    T1] evm: security.SMACK64MMAP (disabled)
[   25.900835][    T1] evm: security.apparmor
[   25.903422][    T1] evm: security.ima
[   25.905764][    T1] evm: security.capability
[   25.908451][    T1] evm: HMAC attrs: 0x1
[   25.923759][    T1] PM:   Magic number: 4:468:66
[   25.926702][    T1] misc vhci: hash matches
[   25.940746][    T1] printk: legacy console [netcon0] enabled
[   25.944537][    T1] netconsole: network logging started
[   25.948522][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   25.975449][    T1] rdma_rxe: loaded
[   25.978564][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   25.992849][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   25.997648][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   26.021491][    T1] clk: Disabling unused clocks
[   26.024720][    T1] ALSA device list:
[   26.027272][    T1]   #0: Dummy 1
[   26.029691][    T1]   #1: Loopback 1
[   26.034074][    T8] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   26.039920][    T8] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   26.060993][    T1]   #2: Virtual MIDI Card 1
[   26.069802][    T1] md: Waiting for all devices to be available before a=
utodetect
[   26.080824][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   26.083787][    T1] md: Autodetecting RAID arrays.
[   26.086140][    T1] md: autorun ...
[   26.087847][    T1] md: ... autorun DONE.
[   26.106628][    T1] REISERFS warning (device sda1): sh-2006 read_super_b=
lock: bread failed (dev sda1, block 2, size 4096)
[   26.121102][    T1] REISERFS warning (device sda1): sh-2006 read_super_b=
lock: bread failed (dev sda1, block 16, size 4096)
[   26.137346][    T1] EXT4-fs (sda1): unable to read superblock
[   26.151559][    T1] VFS: Cannot open root device "/dev/sda1" or unknown-=
block(8,1): error -5
[   26.154695][    T1] Please append a correct "root=3D" boot option; here =
are the available partitions:
[   26.157973][    T1] 0100            4096 ram0=20
[   26.157993][    T1]  (driver?)
[   26.170884][    T1] 0101            4096 ram1=20
[   26.170903][    T1]  (driver?)
[   26.173970][    T1] 0102            4096 ram2=20
[   26.173984][    T1]  (driver?)
[   26.177024][    T1] 0103            4096 ram3=20
[   26.177036][    T1]  (driver?)
[   26.179966][    T1] 0104            4096 ram4=20
[   26.179977][    T1]  (driver?)
[   26.190784][    T1] 0105            4096 ram5=20
[   26.190799][    T1]  (driver?)
[   26.193830][    T1] 0106            4096 ram6=20
[   26.193842][    T1]  (driver?)
[   26.196508][    T1] 0107            4096 ram7=20
[   26.196521][    T1]  (driver?)
[   26.199540][    T1] 0108            4096 ram8=20
[   26.199552][    T1]  (driver?)
[   26.220772][    T1] 0109            4096 ram9=20
[   26.220793][    T1]  (driver?)
[   26.223952][    T1] 010a            4096 ram10=20
[   26.223968][    T1]  (driver?)
[   26.227033][    T1] 010b            4096 ram11=20
[   26.227047][    T1]  (driver?)
[   26.230122][    T1] 010c            4096 ram12=20
[   26.230135][    T1]  (driver?)
[   26.240772][    T1] 010d            4096 ram13=20
[   26.240790][    T1]  (driver?)
[   26.243796][    T1] 010e            4096 ram14=20
[   26.243810][    T1]  (driver?)
[   26.246862][    T1] 010f            4096 ram15=20
[   26.246877][    T1]  (driver?)
[   26.249691][    T1] fa00       262144000 nullb0=20
[   26.249703][    T1]  (driver?)
[   26.270789][    T1] 103:00000      65536 pmem0=20
[   26.270811][    T1]  driver: nd_pmem
[   26.273992][    T1] 1f00             128 mtdblock0=20
[   26.274006][    T1]  (driver?)
[   26.277085][    T1] 0800         1048729 sda=20
[   26.277099][    T1]  driver: sd
[   26.280053][    T1]   0801         1048576 sda1 00000000-01
[   26.280067][    T1]=20
[   26.290853][    T1] 0b00              64 sr0=20
[   26.290869][    T1]  driver: sr
[   26.294114][    T1] List of all bdev filesystems:
[   26.296096][    T1]  reiserfs
[   26.296106][    T1]  ext3
[   26.297360][    T1]  ext2
[   26.298565][    T1]  ext4
[   26.299810][    T1]  cramfs
[   26.312965][    T1]  squashfs
[   26.314221][    T1]  minix
[   26.315444][    T1]  vfat
[   26.316555][    T1]  msdos
[   26.317631][    T1]  exfat
[   26.318658][    T1]  bfs
[   26.319813][    T1]  iso9660
[   26.330812][    T1]  hfsplus
[   26.332042][    T1]  hfs
[   26.333198][    T1]  vxfs
[   26.334241][    T1]  sysv
[   26.335241][    T1]  v7
[   26.336320][    T1]  hpfs
[   26.337367][    T1]  ntfs3
[   26.338398][    T1]  ufs
[   26.339540][    T1]  efs
[   26.340648][    T1]  affs
[   26.350766][    T1]  romfs
[   26.351895][    T1]  qnx4
[   26.353012][    T1]  qnx6
[   26.354113][    T1]  adfs
[   26.355194][    T1]  fuseblk
[   26.356334][    T1]  udf
[   26.357517][    T1]  omfs
[   26.358547][    T1]  jfs
[   26.359625][    T1]  xfs
[   26.370782][    T1]  nilfs2
[   26.371842][    T1]  befs
[   26.372831][    T1]  ocfs2
[   26.373926][    T1]  gfs2
[   26.375065][    T1]  gfs2meta
[   26.376173][    T1]  f2fs
[   26.377413][    T1]  bcachefs
[   26.378499][    T1]  erofs
[   26.379765][    T1]  zonefs
[   26.392475][    T1]  btrfs
[   26.393658][    T1]=20
[   26.395611][    T1] Kernel panic - not syncing: VFS: Unable to mount roo=
t fs on unknown-block(8,1)
[   26.398884][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
1.0-rc3-syzkaller-00060-gd07b43284ab3-dirty #0
[   26.402615][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   26.406329][    T1] Call Trace:
[   26.407589][    T1]  <TASK>
[   26.408656][    T1]  dump_stack_lvl+0x241/0x360
[   26.410564][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[   26.412592][    T1]  ? vsnprintf+0x184/0x1da0
[   26.414233][    T1]  ? __pfx__printk+0x10/0x10
[   26.415947][    T1]  ? vscnprintf+0x5d/0x90
[   26.417369][    T1]  panic+0x349/0x860
[   26.418703][    T1]  ? __wake_up_klogd+0xcc/0x110
[   26.420305][    T1]  ? __pfx_panic+0x10/0x10
[   26.421739][    T1]  ? __wake_up_klogd+0xcc/0x110
[   26.423408][    T1]  ? do_mount_root+0xfd/0x260
[   26.424981][    T1]  mount_root_generic+0x3c3/0x3e0
[   26.426675][    T1]  ? __pfx_mount_root_generic+0x10/0x10
[   26.428510][    T1]  prepare_namespace+0xc2/0x100
[   26.430198][    T1]  kernel_init_freeable+0x476/0x5d0
[   26.432199][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   26.434463][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   26.436908][    T1]  ? __pfx_kernel_init+0x10/0x10
[   26.438695][    T1]  ? __pfx_kernel_init+0x10/0x10
[   26.440416][    T1]  ? __pfx_kernel_init+0x10/0x10
[   26.442094][    T1]  kernel_init+0x1d/0x2b0
[   26.443618][    T1]  ret_from_fork+0x4b/0x80
[   26.445243][    T1]  ? __pfx_kernel_init+0x10/0x10
[   26.447182][    T1]  ret_from_fork_asm+0x1a/0x30
[   26.448992][    T1]  </TASK>
[   26.450290][    T1] Kernel Offset: disabled
[   26.451937][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build223168768=3D/tmp/go-build -gno-record-gcc=
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
/usr/bin/ld: /tmp/ccI66zQZ.o: in function `test_cover_filter()':
executor.cc:(.text+0x13e0b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/ccI66zQZ.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D15243fd3980000


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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D176a0cfd9800=
00


