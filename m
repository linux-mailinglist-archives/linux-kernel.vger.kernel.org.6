Return-Path: <linux-kernel+bounces-289404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C0C9545DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FAF1F21D03
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6050D149E0B;
	Fri, 16 Aug 2024 09:33:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BD31487CE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800784; cv=none; b=SuCr8iBNvDND7VUzRjNvoP/fj89rlXvb612sCASM+o1zL1P59idiYFnG3xB5VVy05gHJpcc+Tpl/Y1IiEnyNkzpn8C5pMMTST4JT3JDMfdM5bViLvFERXSx8Y30ytVfcZfpIkkwKbpxGrKMHWRUYNc1sXs7FQXPBeKlAeOpT+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800784; c=relaxed/simple;
	bh=07sgOpoBP+P6fXPsIW4WqJi1hjtLNybH3iIxeZkKMkM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VEmfAa/vcjIL+PoVkoef1KvF5hqftQFRGWHU9DH+FxCufywcIM3MzfbqNS9u7PUF+Vc1H0IGvgNS4injTgeVnOvzpSzNcaI1DAmjxgOZo7cFMgeLeZqntRCmsDm8amg32UfDCKEIpMdXIqXDBe3hLxnaGUIueqMFi0GVc9Ekhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82237e575f7so199741139f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723800781; x=1724405581;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhWYZvAHG5jX33qxrkobeTSRLSRRN1tCHn2G8BhPjTA=;
        b=ZLxyesUlVVdVwlZGxKoRtyWTN7Rw96PBjSIDSiCVfFkgJQHeQg1pNo9jAjTqTy8Yol
         6kMcFPg7dpFCjQ8+zdNT85HyU/b2hz/63WvkB4OxhXO00Dk2jBIWmirEECLJcSuYi7KZ
         eqjXsVvISTvPA/fv9kT9YCpwwH31+PZw8NYHq+6EUKZASgriL3vXGt6to7uazcGHqaRK
         6agJs5Gmxm1l6viN9QUrEbagH5OCz0UTp2oHPzDkOVeuLdxa11d1dPkuJ5vBfT3WazeG
         GtzDFKDsd0Fjomcve+0+rMPVckp5UFhB570SdcXyZInay6Y5NZsPIfpTUb1CzYvPINQI
         EIhQ==
X-Gm-Message-State: AOJu0YyYfxM2AX/7IKIH1d+fkyU42XgrdWpOn/YgGwbsiKyR2cID1rVb
	733Ei3kpoGjJ2OLTM8vywpsCeFQN6ibSd/Fc19KmIA69wkK6V0gl12I3C5piFj0noVefvH51BDR
	JTBCQRzzO130ZuOB6U7qAXySXqsgCvhKgbdb775waIHOtRp1YnTldEq4=
X-Google-Smtp-Source: AGHT+IHhboeZW21odb8xmRQvn/8WLZZhHDQID/bHGm26/vf+gj0uyObcJFWY7voPZ5sEuhpL2ClXkZZ4bpCNW6qjeGGC1c4RVUBB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc9:b0:81f:8991:3efe with SMTP id
 ca18e2360f4ac-824f251655cmr8084039f.0.1723800781354; Fri, 16 Aug 2024
 02:33:01 -0700 (PDT)
Date: Fri, 16 Aug 2024 02:33:01 -0700
In-Reply-To: <20240816091139.3070635-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c8f29061fc9a5f4@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
From: syzbot <syzbot+5bdd4953bc58c8fbd6eb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

r IPv4 tunneling driver
[   23.104436][    T1] IPv4 over IPsec tunneling driver
[   23.129111][    T1] Initializing XFRM netlink socket
[   23.132613][    T1] IPsec XFRM device driver
[   23.135938][    T1] NET: Registered PF_INET6 protocol family
[   23.172024][    T1] Segment Routing with IPv6
[   23.174892][    T1] RPL Segment Routing with IPv6
[   23.188177][    T1] In-situ OAM (IOAM) with IPv6
[   23.192616][    T1] mip6: Mobile IPv6
[   23.211084][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   23.236201][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   23.259048][    T1] NET: Registered PF_PACKET protocol family
[   23.263139][    T1] NET: Registered PF_KEY protocol family
[   23.278174][    T1] Bridge firewalling registered
[   23.282303][    T1] NET: Registered PF_X25 protocol family
[   23.286074][    T1] X25: Linux Version 0.2
[   23.301416][    T1] NET: Registered PF_NETROM protocol family
[   23.318832][    T1] NET: Registered PF_ROSE protocol family
[   23.322889][    T1] NET: Registered PF_AX25 protocol family
[   23.326765][    T1] can: controller area network core
[   23.347958][    T1] NET: Registered PF_CAN protocol family
[   23.351765][    T1] can: raw protocol
[   23.354415][    T1] can: broadcast manager protocol
[   23.367507][    T1] can: netlink gateway - max_hops=3D1
[   23.371118][    T1] can: SAE J1939
[   23.373498][    T1] can: isotp protocol (max_pdu_size 8300)
[   23.387745][    T1] Bluetooth: RFCOMM TTY layer initialized
[   23.391632][    T1] Bluetooth: RFCOMM socket layer initialized
[   23.395625][    T1] Bluetooth: RFCOMM ver 1.11
[   23.407454][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   23.411410][    T1] Bluetooth: BNEP filters: protocol multicast
[   23.415246][    T1] Bluetooth: BNEP socket layer initialized
[   23.427408][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   23.431143][    T1] Bluetooth: CMTP socket layer initialized
[   23.434852][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   23.457414][    T1] Bluetooth: HIDP socket layer initialized
[   23.464720][    T1] NET: Registered PF_RXRPC protocol family
[   23.477433][    T1] Key type rxrpc registered
[   23.480287][    T1] Key type rxrpc_s registered
[   23.488039][    T1] NET: Registered PF_KCM protocol family
[   23.497666][    T1] lec:lane_module_init: lec.c: initialized
[   23.501477][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   23.505306][    T1] l2tp_core: L2TP core driver, V2.0
[   23.517745][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   23.521466][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   23.525945][    T1] l2tp_netlink: L2TP netlink interface
[   23.547737][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   23.552108][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   23.567741][    T1] NET: Registered PF_PHONET protocol family
[   23.571963][    T1] 8021q: 802.1Q VLAN Support v1.8
[   23.594173][    T1] DCCP: Activated CCID 2 (TCP-like)
[   23.608131][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   23.613720][    T1] DCCP is deprecated and scheduled to be removed in 20=
25, please contact the netdev mailing list
[   23.628421][    T1] sctp: Hash tables configured (bind 32/56)
[   23.638359][    T1] NET: Registered PF_RDS protocol family
[   23.647869][    T1] Registered RDS/infiniband transport
[   23.653106][    T1] Registered RDS/tcp transport
[   23.656293][    T1] tipc: Activated (version 2.0.0)
[   23.678322][    T1] NET: Registered PF_TIPC protocol family
[   23.683663][    T1] tipc: Started in single node mode
[   23.698241][    T1] NET: Registered PF_SMC protocol family
[   23.702447][    T1] 9pnet: Installing 9P2000 support
[   23.724407][    T1] NET: Registered PF_CAIF protocol family
[   23.741904][    T1] NET: Registered PF_IEEE802154 protocol family
[   23.746285][    T1] Key type dns_resolver registered
[   23.757523][    T1] Key type ceph registered
[   23.761109][    T1] libceph: loaded (mon/osd proto 15/24)
[   23.778001][    T1] batman_adv: B.A.T.M.A.N. advanced 2024.2 (compatibil=
ity version 15) loaded
[   23.784139][    T1] openvswitch: Open vSwitch switching datapath
[   23.810825][    T1] NET: Registered PF_VSOCK protocol family
[   23.817925][    T1] mpls_gso: MPLS GSO support
[   23.861386][    T1] IPI shorthand broadcast: enabled
[   23.865022][    T1] AES CTR mode by8 optimization enabled
[   25.942544][    T1] sched_clock: Marking stable (25780052182, 157279919)=
->(25932523814, 4808287)
[   25.962101][    T1] registered taskstats version 1
[   25.993919][    T1] Loading compiled-in X.509 certificates
[   26.012094][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 0c0e0a150e5726d04f45c19ee4cc57d94a35030f'
[   26.505448][    T1] zswap: loaded using pool lzo/zsmalloc
[   26.520389][    T1] Demotion targets for Node 0: null
[   26.523620][    T1] Demotion targets for Node 1: null
[   26.526940][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   26.550142][    T1] Key type .fscrypt registered
[   26.553247][    T1] Key type fscrypt-provisioning registered
[   26.574145][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   26.637518][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   26.643501][    T1] Key type big_key registered
[   26.664453][    T1] Key type encrypted registered
[   26.667489][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   26.671527][    T1] ima: No TPM chip found, activating TPM-bypass!
[   26.675424][    T1] Loading compiled-in module X.509 certificates
[   26.701763][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 0c0e0a150e5726d04f45c19ee4cc57d94a35030f'
[   26.718075][    T1] ima: Allocated hash algorithm: sha256
[   26.722222][    T1] ima: No architecture policies found
[   26.726101][    T1] evm: Initialising EVM extended attributes:
[   26.737364][    T1] evm: security.selinux (disabled)
[   26.741028][    T1] evm: security.SMACK64 (disabled)
[   26.744562][    T1] evm: security.SMACK64EXEC (disabled)
[   26.757379][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   26.761049][    T1] evm: security.SMACK64MMAP (disabled)
[   26.764472][    T1] evm: security.apparmor
[   26.767006][    T1] evm: security.ima
[   26.787401][    T1] evm: security.capability
[   26.790312][    T1] evm: HMAC attrs: 0x1
[   26.798731][    T1] PM:   Magic number: 4:989:373
[   26.802182][    T1] usb usb12-port3: hash matches
[   26.805337][    T1] usb usb11-port4: hash matches
[   26.827596][    T1] vc vcsa1: hash matches
[   26.830885][    T1] printk: legacy console [netcon0] enabled
[   26.834326][    T1] netconsole: network logging started
[   26.848164][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   26.868486][    T1] rdma_rxe: loaded
[   26.872520][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   26.890449][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   26.895777][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   26.918145][    T1] clk: Disabling unused clocks
[   26.921316][    T1] ALSA device list:
[   26.923756][    T1]   #0: Dummy 1
[   26.925729][    T1]   #1: Loopback 1
[   26.929375][   T52] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   26.935114][   T52] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   26.947417][    T1]   #2: Virtual MIDI Card 1
[   26.954352][    T1] md: Waiting for all devices to be available before a=
utodetect
[   26.957038][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   26.977468][    T1] md: Autodetecting RAID arrays.
[   26.979362][    T1] md: autorun ...
[   26.980744][    T1] md: ... autorun DONE.
[   26.997552][    T1] REISERFS warning (device sda1): sh-2006 read_super_b=
lock: bread failed (dev sda1, block 2, size 4096)
[   27.001644][    T1] REISERFS warning (device sda1): sh-2006 read_super_b=
lock: bread failed (dev sda1, block 16, size 4096)
[   27.021249][    T1] EXT4-fs (sda1): unable to read superblock
[   27.024653][    T1] VFS: Cannot open root device "/dev/sda1" or unknown-=
block(8,1): error -5
[   27.037956][    T1] Please append a correct "root=3D" boot option; here =
are the available partitions:
[   27.041263][    T1] 0100            4096 ram0=20
[   27.041287][    T1]  (driver?)
[   27.043940][    T1] 0101            4096 ram1=20
[   27.043948][    T1]  (driver?)
[   27.046555][    T1] 0102            4096 ram2=20
[   27.046563][    T1]  (driver?)
[   27.057380][    T1] 0103            4096 ram3=20
[   27.057391][    T1]  (driver?)
[   27.060287][    T1] 0104            4096 ram4=20
[   27.060299][    T1]  (driver?)
[   27.063150][    T1] 0105            4096 ram5=20
[   27.063161][    T1]  (driver?)
[   27.066465][    T1] 0106            4096 ram6=20
[   27.066477][    T1]  (driver?)
[   27.087452][    T1] 0107            4096 ram7=20
[   27.087471][    T1]  (driver?)
[   27.090349][    T1] 0108            4096 ram8=20
[   27.090362][    T1]  (driver?)
[   27.093127][    T1] 0109            4096 ram9=20
[   27.093140][    T1]  (driver?)
[   27.096078][    T1] 010a            4096 ram10=20
[   27.096090][    T1]  (driver?)
[   27.107410][    T1] 010b            4096 ram11=20
[   27.107429][    T1]  (driver?)
[   27.110269][    T1] 010c            4096 ram12=20
[   27.110282][    T1]  (driver?)
[   27.113126][    T1] 010d            4096 ram13=20
[   27.113137][    T1]  (driver?)
[   27.116130][    T1] 010e            4096 ram14=20
[   27.116142][    T1]  (driver?)
[   27.127407][    T1] 010f            4096 ram15=20
[   27.127426][    T1]  (driver?)
[   27.130355][    T1] fa00       262144000 nullb0=20
[   27.130369][    T1]  (driver?)
[   27.133220][    T1] 103:00000      65536 pmem0=20
[   27.133232][    T1]  driver: nd_pmem
[   27.136290][    T1] 1f00             128 mtdblock0=20
[   27.136303][    T1]  (driver?)
[   27.157434][    T1] 0800         1048729 sda=20
[   27.157454][    T1]  driver: sd
[   27.160153][    T1]   0801         1048576 sda1 00000000-01
[   27.160162][    T1]=20
[   27.163198][    T1] 0b00              64 sr0=20
[   27.163210][    T1]  driver: sr
[   27.166028][    T1] List of all bdev filesystems:
[   27.177369][    T1]  reiserfs
[   27.177385][    T1]  ext3
[   27.178616][    T1]  ext2
[   27.179904][    T1]  ext4
[   27.181179][    T1]  cramfs
[   27.182515][    T1]  squashfs
[   27.183675][    T1]  minix
[   27.184899][    T1]  vfat
[   27.186011][    T1]  msdos
[   27.187002][    T1]  exfat
[   27.197383][    T1]  bfs
[   27.198448][    T1]  iso9660
[   27.199452][    T1]  hfsplus
[   27.200614][    T1]  hfs
[   27.201773][    T1]  vxfs
[   27.202756][    T1]  sysv
[   27.203803][    T1]  v7
[   27.204815][    T1]  hpfs
[   27.205813][    T1]  ntfs3
[   27.206896][    T1]  ufs
[   27.217996][    T1]  efs
[   27.219721][    T1]  affs
[   27.220757][    T1]  romfs
[   27.221828][    T1]  qnx4
[   27.222881][    T1]  qnx6
[   27.223903][    T1]  adfs
[   27.224930][    T1]  fuseblk
[   27.225984][    T1]  udf
[   27.227127][    T1]  omfs
[   27.237365][    T1]  jfs
[   27.238436][    T1]  xfs
[   27.239462][    T1]  nilfs2
[   27.240477][    T1]  befs
[   27.241606][    T1]  ocfs2
[   27.242661][    T1]  gfs2
[   27.243765][    T1]  gfs2meta
[   27.244741][    T1]  f2fs
[   27.245917][    T1]  bcachefs
[   27.246946][    T1]  erofs
[   27.257378][    T1]  zonefs
[   27.258505][    T1]  btrfs
[   27.259630][    T1]=20
[   27.261610][    T1] Kernel panic - not syncing: VFS: Unable to mount roo=
t fs on unknown-block(8,1)
[   27.264759][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
1.0-rc3-syzkaller-00060-gd07b43284ab3-dirty #0
[   27.268717][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   27.273207][    T1] Call Trace:
[   27.274430][    T1]  <TASK>
[   27.275469][    T1]  dump_stack_lvl+0x241/0x360
[   27.278125][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[   27.280109][    T1]  ? vsnprintf+0x184/0x1da0
[   27.281834][    T1]  ? __pfx__printk+0x10/0x10
[   27.283561][    T1]  ? vscnprintf+0x5d/0x90
[   27.285101][    T1]  panic+0x349/0x860
[   27.286521][    T1]  ? __wake_up_klogd+0xcc/0x110
[   27.288252][    T1]  ? __pfx_panic+0x10/0x10
[   27.289874][    T1]  ? __wake_up_klogd+0xcc/0x110
[   27.291647][    T1]  ? do_mount_root+0xfd/0x260
[   27.293479][    T1]  mount_root_generic+0x3c3/0x3e0
[   27.295345][    T1]  ? __pfx_mount_root_generic+0x10/0x10
[   27.297407][    T1]  prepare_namespace+0xc2/0x100
[   27.299195][    T1]  kernel_init_freeable+0x476/0x5d0
[   27.301196][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   27.303231][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   27.305540][    T1]  ? __pfx_kernel_init+0x10/0x10
[   27.307339][    T1]  ? __pfx_kernel_init+0x10/0x10
[   27.309170][    T1]  ? __pfx_kernel_init+0x10/0x10
[   27.311024][    T1]  kernel_init+0x1d/0x2b0
[   27.312612][    T1]  ret_from_fork+0x4b/0x80
[   27.314156][    T1]  ? __pfx_kernel_init+0x10/0x10
[   27.316003][    T1]  ret_from_fork_asm+0x1a/0x30
[   27.317852][    T1]  </TASK>
[   27.319346][    T1] Kernel Offset: disabled
[   27.321027][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1383350581=3D/tmp/go-build -gno-record-gc=
c-switches'

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
/usr/bin/ld: /tmp/ccPkHzAp.o: in function `test_cover_filter()':
executor.cc:(.text+0x13e0b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/ccPkHzAp.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D152dc2fd980000


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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D144be3c59800=
00


