Return-Path: <linux-kernel+bounces-215636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E4D909544
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 03:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C0F1F223C1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA0819D8AF;
	Sat, 15 Jun 2024 01:41:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62327635
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718415666; cv=none; b=dzvf0g9b7Ji2YHPh3JLTkmsvU/VCgJjXnoG4UH/xQfJlBWI77Tvtc/mfZKtHgn1w7O4rx3clKgWxjRm1VUGOMU8xvrICOgJpYMRHC9ErRBdB+Bqa2NtdFKe5P57fX8hv2ouBTdbT8eaV3Az8H7whi374vXvqt01qoj2S7wpepC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718415666; c=relaxed/simple;
	bh=ar/NM/5Zu7a5xrNZSnV54FA8fwRzQpNM916JMe30/XY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hZRxxJvoHQbteaPWJqRbaAWFeHiiQp2y2i2X9k5NdT+Q140SMmIXGQqEyvV5J8sHMXbDTWKj9KKz1e5ce2CjyXkM9rOaNtRdqwjs1yM+MFOr6g5CewU8eF7PmvmmMgywN+lbW8soNFmdp8xsoP9nbPXDBEFSuKOGdgKlE4jZMOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e94cac3ee5so277089039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718415663; x=1719020463;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GrEMMd6Q3LOs8lm+Lxx4Sw1EO0Zqd0o02wguFyHYpE=;
        b=LBeLY8YU/A0NFgI1P6NnEsp1/T9mdTDqzP4uWLecGzI6kqdaDCafGxuZfKw0FOt4qA
         IjzvTgb9TfmblavGLKIVhvljz3dHc84ic6Jj9vVR+w1h6tXxGo/ALTggPLM7f8SqT/0u
         yY5qw5ClHy8zL6DeIgHZ52iyXozQ86SDfACkLFE3mcFYMTCqbKDe1cZeu1DDcyEs9nRp
         5xJO45LrKDB8Uyvvz1gw4I8C6jWsc7C4OjdClQrZe6VSAegQpjQBKnkD5vw8eqUc5+xI
         ywJyNrdDVa59YMvwyKOwyMNTOcmvxWUXC4bsrMKUw9X10GEmEvc1eJkNUI3Jij4jQ+d/
         Ld+w==
X-Forwarded-Encrypted: i=1; AJvYcCUll3lmzwGPm4HVlyDSENFdYVXPPUOgT/zhes9OHFUS6XY0lSvMIaTt+53DrTFb2gC4x/RtaHzkxMb0jB0874yPQ3fusnjw0oleQzDO
X-Gm-Message-State: AOJu0Yxr0KsI1oysqamGnQ7/eD1mpvxhS9+3NsqmjtPbOZOYob8KpMd7
	T/uCWbjbK4iTwRaYT27UBRli31pYUT4Zbj2ZB94LNljIyr+nYOBlVwJZhX0EPpukdg4AhkIeJy5
	if4SMKtkVQLKcZ3Sna6yzqcuGHK426Xes8qEENru4wZtXiYJwHqdOPhE=
X-Google-Smtp-Source: AGHT+IFiefGZkkZg9arQUUTE6ml28/Ife8UfVS8cOAEb9m2Dz2yq4ta7nDQO1x3xMQr0542wBdl19lwS0/LGDzIIzPMdnA48kuPn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8704:b0:4b9:6688:4fc with SMTP id
 8926c6da1cb9f-4b966880798mr84784173.2.1718415663467; Fri, 14 Jun 2024
 18:41:03 -0700 (PDT)
Date: Fri, 14 Jun 2024 18:41:03 -0700
In-Reply-To: <20240615000441.861-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032ad81061ae3d354@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

5][    T1] usbcore: registered new interface driver snd_usb_variax
[   11.302247][    T1] drop_monitor: Initializing network drop monitor serv=
ice
[   11.311701][    T1] NET: Registered PF_LLC protocol family
[   11.318195][    T1] GACT probability on
[   11.322363][    T1] Mirror/redirect action on
[   11.327179][    T1] Simple TC action Loaded
[   11.335693][    T1] netem: version 1.3
[   11.339922][    T1] u32 classifier
[   11.343467][    T1]     Performance counters on
[   11.348165][    T1]     input device check on
[   11.352648][    T1]     Actions configured
[   11.359550][    T1] nf_conntrack_irc: failed to register helpers
[   11.365771][    T1] nf_conntrack_sane: failed to register helpers
[   11.490881][    T1] nf_conntrack_sip: failed to register helpers
[   11.503091][    T1] xt_time: kernel timezone is -0000
[   11.508580][    T1] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
[   11.515567][    T1] IPVS: Connection hash table configured (size=3D4096,=
 memory=3D32Kbytes)
[   11.524749][    T1] IPVS: ipvs loaded.
[   11.528782][    T1] IPVS: [rr] scheduler registered.
[   11.533974][    T1] IPVS: [wrr] scheduler registered.
[   11.539276][    T1] IPVS: [lc] scheduler registered.
[   11.544387][    T1] IPVS: [wlc] scheduler registered.
[   11.549657][    T1] IPVS: [fo] scheduler registered.
[   11.555055][    T1] IPVS: [ovf] scheduler registered.
[   11.560394][    T1] IPVS: [lblc] scheduler registered.
[   11.565729][    T1] IPVS: [lblcr] scheduler registered.
[   11.571680][    T1] IPVS: [dh] scheduler registered.
[   11.576873][    T1] IPVS: [sh] scheduler registered.
[   11.582006][    T1] IPVS: [mh] scheduler registered.
[   11.587293][    T1] IPVS: [sed] scheduler registered.
[   11.592590][    T1] IPVS: [nq] scheduler registered.
[   11.597745][    T1] IPVS: [twos] scheduler registered.
[   11.603473][    T1] IPVS: [sip] pe registered.
[   11.608323][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   11.618256][    T1] gre: GRE over IPv4 demultiplexor driver
[   11.623995][    T1] ip_gre: GRE over IPv4 tunneling driver
[   11.639361][    T1] IPv4 over IPsec tunneling driver
[   11.649203][    T1] Initializing XFRM netlink socket
[   11.654611][    T1] IPsec XFRM device driver
[   11.660348][    T1] NET: Registered PF_INET6 protocol family
[   11.680421][    T1] Segment Routing with IPv6
[   11.685024][    T1] RPL Segment Routing with IPv6
[   11.690127][    T1] In-situ OAM (IOAM) with IPv6
[   11.695399][    T1] mip6: Mobile IPv6
[   11.703700][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   11.718600][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   11.729457][    T1] NET: Registered PF_PACKET protocol family
[   11.735537][    T1] NET: Registered PF_KEY protocol family
[   11.741796][    T1] Bridge firewalling registered
[   11.747696][    T1] NET: Registered PF_X25 protocol family
[   11.753479][    T1] X25: Linux Version 0.2
[   11.802773][    T1] NET: Registered PF_NETROM protocol family
[   11.854444][    T1] NET: Registered PF_ROSE protocol family
[   11.864814][    T1] NET: Registered PF_AX25 protocol family
[   11.871376][    T1] can: controller area network core
[   11.876845][    T1] NET: Registered PF_CAN protocol family
[   11.883711][    T1] can: raw protocol
[   11.887830][    T1] can: broadcast manager protocol
[   11.892941][    T1] can: netlink gateway - max_hops=3D1
[   11.898365][    T1] can: SAE J1939
[   11.901940][    T1] can: isotp protocol (max_pdu_size 8300)
[   11.909408][    T1] Bluetooth: RFCOMM TTY layer initialized
[   11.915286][    T1] Bluetooth: RFCOMM socket layer initialized
[   11.921464][    T1] Bluetooth: RFCOMM ver 1.11
[   11.926785][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   11.933066][    T1] Bluetooth: BNEP filters: protocol multicast
[   11.939343][    T1] Bluetooth: BNEP socket layer initialized
[   11.945147][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   11.951046][    T1] Bluetooth: CMTP socket layer initialized
[   11.956926][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   11.963861][    T1] Bluetooth: HIDP socket layer initialized
[   11.973494][    T1] NET: Registered PF_RXRPC protocol family
[   11.979356][    T1] Key type rxrpc registered
[   11.983844][    T1] Key type rxrpc_s registered
[   11.989486][    T1] NET: Registered PF_KCM protocol family
[   11.996107][    T1] lec:lane_module_init: lec.c: initialized
[   12.002004][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   12.007965][    T1] l2tp_core: L2TP core driver, V2.0
[   12.013196][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   12.018865][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   12.025374][    T1] l2tp_netlink: L2TP netlink interface
[   12.030971][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   12.037743][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   12.045361][    T1] NET: Registered PF_PHONET protocol family
[   12.051559][    T1] 8021q: 802.1Q VLAN Support v1.8
[   12.071027][    T1] DCCP: Activated CCID 2 (TCP-like)
[   12.076392][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   12.083533][    T1] DCCP is deprecated and scheduled to be removed in 20=
25, please contact the netdev mailing list
[   12.094738][    T1] sctp: Hash tables configured (bind 32/56)
[   12.102401][    T1] NET: Registered PF_RDS protocol family
[   12.108965][    T1] Registered RDS/infiniband transport
[   12.115714][    T1] Registered RDS/tcp transport
[   12.120748][    T1] tipc: Activated (version 2.0.0)
[   12.126839][    T1] NET: Registered PF_TIPC protocol family
[   12.133861][    T1] tipc: Started in single node mode
[   12.140276][    T1] NET: Registered PF_SMC protocol family
[   12.146254][    T1] 9pnet: Installing 9P2000 support
[   12.152095][    T1] NET: Registered PF_CAIF protocol family
[   12.161729][    T1] NET: Registered PF_IEEE802154 protocol family
[   12.168694][    T1] Key type dns_resolver registered
[   12.173882][    T1] Key type ceph registered
[   12.179243][    T1] libceph: loaded (mon/osd proto 15/24)
[   12.186045][    T1] batman_adv: B.A.T.M.A.N. advanced 2024.2 (compatibil=
ity version 15) loaded
[   12.195724][    T1] openvswitch: Open vSwitch switching datapath
[   12.205601][    T1] NET: Registered PF_VSOCK protocol family
[   12.211871][    T1] mpls_gso: MPLS GSO support
[   12.233028][    T1] IPI shorthand broadcast: enabled
[   12.238605][    T1] AVX2 version of gcm_enc/dec engaged.
[   12.244489][    T1] AES CTR mode by8 optimization enabled
[   13.698699][    T1] sched_clock: Marking stable (13660026255, 37434632)-=
>(13707290408, -9829521)
[   13.709929][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 0 crossnode level
[   13.720289][    T1] registered taskstats version 1
[   13.740168][    T1] Loading compiled-in X.509 certificates
[   13.750995][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 63e2efea038bb0653de0db43cf50bc47660eba33'
[   14.070144][    T1] zswap: loaded using pool lzo/zsmalloc
[   14.078019][    T1] Demotion targets for Node 0: null
[   14.083317][    T1] Demotion targets for Node 1: null
[   14.090223][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   16.421449][    T1] Key type .fscrypt registered
[   16.426326][    T1] Key type fscrypt-provisioning registered
[   16.439567][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   16.463960][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   16.472822][    T1] Key type big_key registered
[   16.487177][    T1] Key type encrypted registered
[   16.492433][    T1] ima: No TPM chip found, activating TPM-bypass!
[   16.498975][    T1] Loading compiled-in module X.509 certificates
[   16.508509][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 63e2efea038bb0653de0db43cf50bc47660eba33'
[   16.519514][    T1] ima: Allocated hash algorithm: sha256
[   16.525779][    T1] ima: No architecture policies found
[   16.531809][    T1] evm: Initialising EVM extended attributes:
[   16.538118][    T1] evm: security.selinux (disabled)
[   16.543309][    T1] evm: security.SMACK64
[   16.547518][    T1] evm: security.SMACK64EXEC
[   16.552013][    T1] evm: security.SMACK64TRANSMUTE
[   16.557098][    T1] evm: security.SMACK64MMAP
[   16.562382][    T1] evm: security.apparmor (disabled)
[   16.567636][    T1] evm: security.ima
[   16.571521][    T1] evm: security.capability
[   16.575929][    T1] evm: HMAC attrs: 0x1
[   16.582546][    T1] PM:   Magic number: 12:706:508
[   16.587780][    T1] usb usb40-port6: hash matches
[   16.593014][    T1] bdi 252:0: hash matches
[   16.597651][    T1] pci 0000:00:01.0: hash matches
[   16.603169][    T1] printk: legacy console [netcon0] enabled
[   16.609033][    T1] netconsole: network logging started
[   16.615160][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   16.623286][    T1] rdma_rxe: loaded
[   16.628079][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   16.639538][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   16.647354][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   16.657611][    T1] clk: Disabling unused clocks
[   16.659517][   T45] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   16.662680][    T1] ALSA device list:
[   16.672518][   T45] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   16.676035][    T1]   #0: Dummy 1
[   16.688620][    T1]   #1: Loopback 1
[   16.692338][    T1]   #2: Virtual MIDI Card 1
[   16.700761][    T1] md: Waiting for all devices to be available before a=
utodetect
[   16.708457][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   16.714984][    T1] md: Autodetecting RAID arrays.
[   16.720066][    T1] md: autorun ...
[   16.723703][    T1] md: ... autorun DONE.
[   16.822096][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   16.835388][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   16.866395][    T1] devtmpfs: mounted
[   16.954288][    T1] Freeing unused kernel image (initmem) memory: 25900K
[   16.965105][    T1] Write protecting the kernel read-only data: 212992k
[   16.982735][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 752K
[   17.095445][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   17.103701][    T1] x86/mm: Checking user space page tables
[   17.200694][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   17.210306][    T1] Error -EINVAL opening proc file to set sysctl parame=
ter 'kernel.hung_task_all_cpu_backtrace=3D1'
[   17.221335][    T1] Error -EINVAL opening proc file to set sysctl parame=
ter 'vm.nr_hugepages=3D4'
[   17.230737][    T1] Error -EINVAL opening proc file to set sysctl parame=
ter 'vm.nr_overcommit_hugepages=3D4'
[   17.240776][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   17.250456][    T1] Error -EINVAL opening proc file to set sysctl parame=
ter 'net.core.netdev_unregister_timeout_secs=3D140'
[   17.262827][    T1] Run /sbin/init as init process
[   17.319704][    T1] Starting init: /sbin/init exists but couldn't execut=
e it (error -22)
[   17.328131][    T1] Run /etc/init as init process
[   17.352410][    T1] Run /bin/init as init process
[   17.358988][    T1] Run /bin/sh as init process
[   17.364086][    T1] Starting init: /bin/sh exists but couldn't execute i=
t (error -22)
[   17.372157][    T1] Kernel panic - not syncing: No working init found.  =
Try passing init=3D option to kernel. See Linux Documentation/admin-guide/i=
nit.rst for guidance.
[   17.387558][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc3=
-syzkaller-dirty #0
[   17.396159][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[   17.406298][    T1] Call Trace:
[   17.409570][    T1]  <TASK>
[   17.412494][    T1]  dump_stack_lvl+0x241/0x360
[   17.417178][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[   17.422356][    T1]  ? __pfx__printk+0x10/0x10
[   17.426971][    T1]  ? vscnprintf+0x5d/0x90
[   17.431283][    T1]  panic+0x349/0x860
[   17.435244][    T1]  ? __wake_up_klogd+0xcc/0x110
[   17.440250][    T1]  ? __pfx_panic+0x10/0x10
[   17.444652][    T1]  ? kernel_init+0x18f/0x2b0
[   17.449228][    T1]  ? kernel_execve+0x8f8/0xa10
[   17.453988][    T1]  ? pti_clone_pgtable+0x380/0x3c0
[   17.459085][    T1]  ? __pfx_kernel_init+0x10/0x10
[   17.464022][    T1]  kernel_init+0x25e/0x2b0
[   17.468424][    T1]  ret_from_fork+0x4b/0x80
[   17.472821][    T1]  ? __pfx_kernel_init+0x10/0x10
[   17.477743][    T1]  ret_from_fork_asm+0x1a/0x30
[   17.482498][    T1]  </TASK>
[   17.485802][    T1] Kernel Offset: disabled
[   17.490168][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2391660754=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 8bdc0f2206
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
/syzkaller/prog.GitRevision=3D8bdc0f220628c9347b3581fead4c026272439799 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240424-152314'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D8bdc0f220628c9347b3581fead4c026272439799 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240424-152314'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D8bdc0f220628c9347b3581fead4c026272439799 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240424-152314'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"8bdc0f220628c9347b3581fead4c026272=
439799\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D15dd7646980000


Tested on:

commit:         83a7eefe Linux 6.10-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc79815c08cc1422=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D5d34cc6474499a5ff=
516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13d111de9800=
00


