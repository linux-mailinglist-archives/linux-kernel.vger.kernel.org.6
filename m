Return-Path: <linux-kernel+bounces-357744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FFD99751C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF2A1F235BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095751DF734;
	Wed,  9 Oct 2024 18:51:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234E13AD11
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499866; cv=none; b=N3RXCwBEM5jij01e8Kht/JzP780raIH0MJ9iaPEJtzV2ZgvHJr/3WHCtQFvViWzqv0MaHzv/47dOmJ2r8Wt69YZ0Q5CfxkSTOlCBVwU+3xtlHfGidIaw5EVIKgwhDwGN95Zp75AMonFGOLqQStXmTX7CZkV3VNnogUFZiTGYroY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499866; c=relaxed/simple;
	bh=6OYOEKifX6KOkhN5jnfY5Ekbuuhj+D3zwKEfoYJpUxE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IRYW6M3ArT5Mc1tDptHEZbF3o7n5+tk92XiaK4MJvMwsWvryobWmLCEetwjnmdffkktpLqpUUtCdTHtNNLKyJ+fyAaF7kZ0KKFkjBKsqK1i9LpN8njC8LnFN+aKUafpvWk0qADsQBRTQBfBLhlBkBG/1TfD4INfcL/cRrIWVe9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3466d220dso2162005ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728499863; x=1729104663;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/BcLt8fUX00BClcjVT7vWjmhc32lUsVrgITq0GsOeY=;
        b=XYe+1R7y+yDTX+2KASceyaWZJJvt2rcCQfzsUL2R2cIvghtMP8n7zUdcPTbCVSy68p
         jGq9IYF7Qo7LQHf/53O8v6cA2L86OcXh3ajEkZk4U1HpQds1rAfQjAdW+hCzI3qjYBxC
         f7VF93MsaQSn2O7viZrcmydjcrzPY2MSNgWTZqBUGJ/EChIeMrbA+XXksEu2gadYhhUz
         olPx+VvHqZ83HXrg/4S0oc/MeqoVsMCvs1LL0GaoJjIUXHrXRQ6Dg3tfLpVbrqlNPeHW
         vxsuOKbVIiVqBMZGbFzfoVFQ7OMbXxIMIOEKnNDbb/xC9+nlWQeLXJ314n52fAc+biMw
         c1xA==
X-Forwarded-Encrypted: i=1; AJvYcCXacUN8jpNMhwAD9l/uPPtBoyVLYQlcily1Y3E79FRz8auHFPCIKEMs7Sl4f1xCavE+8xXVitUe+q+Gu2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyanzTzHEYGnET5CSvvm9Yo8TLgvTjoaeR+f3AJBkvXmLrrAQEH
	LcE/LhsNWtWohVmXuldTQf1IH1AgX4/eRIEWVFyW4OgyFVpco92EHijcVmO0TVlrYUuhbDEq/Z6
	5iIorRxjkXChiJh68up7qdR4Ht7sayH40fa5yGtvBL+XYMknX8e3jQPU=
X-Google-Smtp-Source: AGHT+IGd+093b3a11IN1ikG+KcTVn0aXL7JuqvokbEegmPYb/OvJwENq0DkMpHvt9t2B2sSaAXC5zC55QuA94kKALZC6disjWjeU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:3a2:f7b1:2f89 with SMTP id
 e9e14a558f8ab-3a397d1ad5emr42541845ab.18.1728499863256; Wed, 09 Oct 2024
 11:51:03 -0700 (PDT)
Date: Wed, 09 Oct 2024 11:51:03 -0700
In-Reply-To: <tencent_71B14BCF1B112524BA87BB2B339C9E6F1B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706d097.050a0220.1139e6.000a.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in getname_kernel (2)
From: syzbot <syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

s2_ap_driver
[   10.319275][    T1] comedi: version 0.7.76 - http://www.comedi.org
[   10.322568][    T1] usbcore: registered new interface driver dt9812
[   10.325416][    T1] usbcore: registered new interface driver ni6501
[   10.327201][    T1] usbcore: registered new interface driver usbdux
[   10.329379][    T1] usbcore: registered new interface driver usbduxfast
[   10.332121][    T1] usbcore: registered new interface driver usbduxsigma
[   10.334088][    T1] usbcore: registered new interface driver vmk80xx
[   10.337211][    T1] usbcore: registered new interface driver r8712u
[   10.338343][    T1] greybus: registered new driver hid
[   10.340298][    T1] greybus: registered new driver gbphy
[   10.341827][    T1] gb_gbphy: registered new driver usb
[   10.349219][    T1] asus_wmi: ASUS WMI generic driver loaded
[   10.361679][    T1] gnss: GNSS driver registered with major 493
[   10.368815][    T1] usbcore: registered new interface driver gnss-usb
[   10.370709][    T1] usbcore: registered new interface driver hdm_usb
[   10.444816][    T1] usbcore: registered new interface driver snd-usb-aud=
io
[   10.448305][    T1] usbcore: registered new interface driver snd-ua101
[   10.450555][    T1] usbcore: registered new interface driver snd-usb-usx=
2y
[   10.452954][    T1] usbcore: registered new interface driver snd-usb-us1=
22l
[   10.454894][    T1] usbcore: registered new interface driver snd-usb-cai=
aq
[   10.456790][    T1] usbcore: registered new interface driver snd-usb-6fi=
re
[   10.458789][    T1] usbcore: registered new interface driver snd-usb-hif=
ace
[   10.460996][    T1] usbcore: registered new interface driver snd-bcd2000
[   10.463111][    T1] usbcore: registered new interface driver snd_usb_pod
[   10.466398][    T1] usbcore: registered new interface driver snd_usb_pod=
hd
[   10.468273][    T1] usbcore: registered new interface driver snd_usb_ton=
eport
[   10.469725][    T1] usbcore: registered new interface driver snd_usb_var=
iax
[   10.474004][    T1] drop_monitor: Initializing network drop monitor serv=
ice
[   10.476401][    T1] NET: Registered PF_LLC protocol family
[   10.477481][    T1] GACT probability on
[   10.478257][    T1] Mirror/redirect action on
[   10.479172][    T1] Simple TC action Loaded
[   10.482782][    T1] netem: version 1.3
[   10.483673][    T1] u32 classifier
[   10.484180][    T1]     Performance counters on
[   10.484834][    T1]     input device check on
[   10.486023][    T1]     Actions configured
[   10.489157][    T1] nf_conntrack_irc: failed to register helpers
[   10.490084][    T1] nf_conntrack_sane: failed to register helpers
[   10.598437][    T1] nf_conntrack_sip: failed to register helpers
[   10.604205][ T2709] kworker/u8:5 (2709) used greatest stack depth: 24784=
 bytes left
[   10.604399][    T1] xt_time: kernel timezone is -0000
[   10.606687][    T1] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
[   10.607753][    T1] IPVS: Connection hash table configured (size=3D4096,=
 memory=3D32Kbytes)
[   10.609718][    T1] IPVS: ipvs loaded.
[   10.610454][    T1] IPVS: [rr] scheduler registered.
[   10.611224][    T1] IPVS: [wrr] scheduler registered.
[   10.612068][    T1] IPVS: [lc] scheduler registered.
[   10.612780][    T1] IPVS: [wlc] scheduler registered.
[   10.613556][    T1] IPVS: [fo] scheduler registered.
[   10.614304][    T1] IPVS: [ovf] scheduler registered.
[   10.615149][    T1] IPVS: [lblc] scheduler registered.
[   10.615886][    T1] IPVS: [lblcr] scheduler registered.
[   10.616665][    T1] IPVS: [dh] scheduler registered.
[   10.617614][    T1] IPVS: [sh] scheduler registered.
[   10.618521][    T1] IPVS: [mh] scheduler registered.
[   10.619321][    T1] IPVS: [sed] scheduler registered.
[   10.620373][    T1] IPVS: [nq] scheduler registered.
[   10.621182][    T1] IPVS: [twos] scheduler registered.
[   10.622179][    T1] IPVS: [sip] pe registered.
[   10.623331][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   10.627241][    T1] gre: GRE over IPv4 demultiplexor driver
[   10.628252][    T1] ip_gre: GRE over IPv4 tunneling driver
[   10.637645][    T1] IPv4 over IPsec tunneling driver
[   10.641661][    T1] Initializing XFRM netlink socket
[   10.642642][    T1] IPsec XFRM device driver
[   10.643733][    T1] NET: Registered PF_INET6 protocol family
[   10.656555][    T1] Segment Routing with IPv6
[   10.657375][    T1] RPL Segment Routing with IPv6
[   10.658370][    T1] In-situ OAM (IOAM) with IPv6
[   10.659392][    T1] mip6: Mobile IPv6
[   10.663271][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   10.670008][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   10.674292][    T1] NET: Registered PF_PACKET protocol family
[   10.676334][    T1] NET: Registered PF_KEY protocol family
[   10.677683][    T1] Bridge firewalling registered
[   10.679324][    T1] NET: Registered PF_X25 protocol family
[   10.680368][    T1] X25: Linux Version 0.2
[   10.716733][    T1] NET: Registered PF_NETROM protocol family
[   10.753122][    T1] NET: Registered PF_ROSE protocol family
[   10.754387][    T1] NET: Registered PF_AX25 protocol family
[   10.757938][    T1] can: controller area network core
[   10.758970][    T1] NET: Registered PF_CAN protocol family
[   10.759924][    T1] can: raw protocol
[   10.760534][    T1] can: broadcast manager protocol
[   10.761312][    T1] can: netlink gateway - max_hops=3D1
[   10.762339][    T1] can: SAE J1939
[   10.762919][    T1] can: isotp protocol (max_pdu_size 8300)
[   10.764278][    T1] Bluetooth: RFCOMM TTY layer initialized
[   10.767642][    T1] Bluetooth: RFCOMM socket layer initialized
[   10.768787][    T1] Bluetooth: RFCOMM ver 1.11
[   10.769560][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.770537][    T1] Bluetooth: BNEP filters: protocol multicast
[   10.771518][    T1] Bluetooth: BNEP socket layer initialized
[   10.772349][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   10.773324][    T1] Bluetooth: HIDP socket layer initialized
[   10.778406][    T1] NET: Registered PF_RXRPC protocol family
[   10.779406][    T1] Key type rxrpc registered
[   10.780204][    T1] Key type rxrpc_s registered
[   10.781608][    T1] NET: Registered PF_KCM protocol family
[   10.783775][    T1] lec:lane_module_init: lec.c: initialized
[   10.784692][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   10.785946][    T1] l2tp_core: L2TP core driver, V2.0
[   10.786934][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   10.787969][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   10.789031][    T1] l2tp_netlink: L2TP netlink interface
[   10.789899][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   10.790827][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   10.792073][    T1] NET: Registered PF_PHONET protocol family
[   10.793120][    T1] 8021q: 802.1Q VLAN Support v1.8
[   10.808908][    T1] DCCP: Activated CCID 2 (TCP-like)
[   10.814230][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   10.821673][    T1] DCCP is deprecated and scheduled to be removed in 20=
25, please contact the netdev mailing list
[   10.832766][    T1] sctp: Hash tables configured (bind 32/56)
[   10.840557][    T1] NET: Registered PF_RDS protocol family
[   10.847237][    T1] Registered RDS/infiniband transport
[   10.853730][    T1] Registered RDS/tcp transport
[   10.858656][    T1] tipc: Activated (version 2.0.0)
[   10.864431][    T1] NET: Registered PF_TIPC protocol family
[   10.871052][    T1] tipc: Started in single node mode
[   10.877071][    T1] NET: Registered PF_SMC protocol family
[   10.883181][    T1] 9pnet: Installing 9P2000 support
[   10.888922][    T1] NET: Registered PF_CAIF protocol family
[   10.898506][    T1] NET: Registered PF_IEEE802154 protocol family
[   10.905068][    T1] Key type dns_resolver registered
[   10.910312][    T1] Key type ceph registered
[   10.915415][    T1] libceph: loaded (mon/osd proto 15/24)
[   10.922141][    T1] batman_adv: B.A.T.M.A.N. advanced 2024.2 (compatibil=
ity version 15) loaded
[   10.931398][    T1] openvswitch: Open vSwitch switching datapath
[   10.939441][    T1] NET: Registered PF_VSOCK protocol family
[   10.945999][    T1] mpls_gso: MPLS GSO support
[   10.967691][    T1] IPI shorthand broadcast: enabled
[   10.973087][    T1] AES CTR mode by8 optimization enabled
[   12.104613][    T1] sched_clock: Marking stable (12060025057, 34932274)-=
>(12093279688, 1677643)
[   12.119544][    T1] registered taskstats version 1
[   12.141500][    T1] Loading compiled-in X.509 certificates
[   12.199712][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 34511b135d2758a08a46bc4f061ab8667a62b201'
[   12.396949][    T1] zswap: loaded using pool 842/z3fold
[   12.404836][    T1] Demotion targets for Node 0: null
[   12.410189][    T1] Demotion targets for Node 1: null
[   12.415469][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   14.168414][    T1] Key type .fscrypt registered
[   14.173201][    T1] Key type fscrypt-provisioning registered
[   14.184392][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   14.207263][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   14.215931][    T1] Key type big_key registered
[   14.229036][    T1] Key type encrypted registered
[   14.233923][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   14.240771][    T1] ima: No TPM chip found, activating TPM-bypass!
[   14.247197][    T1] Loading compiled-in module X.509 certificates
[   14.271408][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 34511b135d2758a08a46bc4f061ab8667a62b201'
[   14.282261][    T1] ima: Allocated hash algorithm: sha256
[   14.288286][    T1] ima: No architecture policies found
[   14.294068][    T1] evm: Initialising EVM extended attributes:
[   14.300089][    T1] evm: security.selinux (disabled)
[   14.305769][    T1] evm: security.SMACK64 (disabled)
[   14.310887][    T1] evm: security.SMACK64EXEC (disabled)
[   14.316468][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   14.322337][    T1] evm: security.SMACK64MMAP (disabled)
[   14.327813][    T1] evm: security.apparmor
[   14.332050][    T1] evm: security.ima
[   14.335873][    T1] evm: security.capability
[   14.340547][    T1] evm: HMAC attrs: 0x1
[   14.347257][    T1] PM:   Magic number: 12:295:746
[   14.353400][    T1] printk: legacy console [netcon0] enabled
[   14.359315][    T1] netconsole: network logging started
[   14.365308][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   14.375941][    T1] rdma_rxe: loaded
[   14.380278][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   14.391416][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   14.399964][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   14.409267][  T939] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   14.418937][    T1] clk: Disabling unused clocks
[   14.419013][  T939] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   14.423899][    T1] ALSA device list:
[   14.436380][    T1]   #0: Dummy 1
[   14.439870][    T1]   #1: Loopback 1
[   14.443576][    T1]   #2: Virtual MIDI Card 1
[   14.451100][    T1] md: Waiting for all devices to be available before a=
utodetect
[   14.458822][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   14.465370][    T1] md: Autodetecting RAID arrays.
[   14.470381][    T1] md: autorun ...
[   14.474008][    T1] md: ... autorun DONE.
[   14.538322][    T1] EXT4-fs (sda1): mounted filesystem b4773fba-1738-4da=
0-8a90-0fe043d0a496 ro with ordered data mode. Quota mode: none.
[   14.551126][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   14.578998][    T1] devtmpfs: mounted
[   14.631301][    T1] Freeing unused kernel image (initmem) memory: 26736K
[   14.641332][    T1] Write protecting the kernel read-only data: 219136k
[   14.656226][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1100K
[   14.763403][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   14.771313][    T1] x86/mm: Checking user space page tables
[   14.864011][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   14.877068][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   14.886913][    T1] Run /sbin/init as init process
[   15.655177][ T4652] mount (4652) used greatest stack depth: 23104 bytes =
left
[   15.709114][ T4653] EXT4-fs (sda1): re-mounted b4773fba-1738-4da0-8a90-0=
fe043d0a496 r/w. Quota mode: none.
mount: mounting devtmpfs on /dev failed: Device or resource busy
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   15.856092][ T4657] mount (4657) used greatest stack depth: 20608 bytes =
left
Starting syslogd: OK
Starting acpid: [   76.826513][  T939] cfg80211: failed to load regulatory.=
db


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
GOVERSION=3D'go1.22.7'
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
 -ffile-prefix-map=3D/tmp/go-build1417808173=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 402f1df054
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
/syzkaller/prog.GitRevision=3D402f1df054ddb07ed5bb299d08c781354eb06607 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20241007-221845'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"402f1df054ddb07ed5bb299d08c781354e=
b06607\"
/usr/bin/ld: /tmp/ccIZFOUJ.o: in function `test_cover_filter()':
executor.cc:(.text+0x1424b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/ccIZFOUJ.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D143537d0580000


Tested on:

commit:         b6270c3b Add linux-next specific files for 20241009
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Daa19e8f0089d270=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dcee29f5a48caf10cd=
475
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D169837d05800=
00


