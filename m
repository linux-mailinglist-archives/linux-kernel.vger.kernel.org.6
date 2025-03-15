Return-Path: <linux-kernel+bounces-562452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62903A62824
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 08:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D49E3BD2B8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A111A08AB;
	Sat, 15 Mar 2025 07:35:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5719528DB3
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742024105; cv=none; b=YMqzc1V7Ibz8uHK43toYLdKzAQOlBbQxAvyvqNWX+HS1ZBNtHlX0nF00WgNLbsdeWHH+7t78r7McwheUhbjhYE98ws3ETUpbaB3r6Xuo2WbaAjlD2x2Vl++28Of7Ljyak6vQrO7eXZ9fl+Bw4sur28/Uo6MUXbaDQMpfbG61oEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742024105; c=relaxed/simple;
	bh=55p4Z3g+u6WpU+W0kabRHho1Xe6gShtk3tdKEBvpuys=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m8N7Q+Uyx0q0KES/ZeXa573t132EBSTiM/y4+xtUsdutG/aYvCOrGcttlOEb/2hV++EbMjEs/volXREFYcrt+VA25HyKY7KZSKSQU6B2AySpCr5M1cns185tAHWxQVE0KamkzIDT2jwRkA9lCM62qQ7TQDQOjmXYy6MjXG60h3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2ef1a37beso33005305ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 00:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742024102; x=1742628902;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2q8ZrEwGIRkAfwnOwAuAX0QUPSVGqfXJDsnRu+hiC8=;
        b=V/alAWwwJXxIpbVV4H3jU3G3/D1YXBoSyzJCAJdWqKL2iIW9dAM/IQdk3+fcGfdXw0
         7do5vg4XLy6CBBCtJlR+fyvMF0iwztBaGRD6Tyuq5PoRUfdOBOQ+bOfG8Xig8xSJlGBF
         nJ/TuczfPXLZLpl3R1MvS1XIl4uuO7nM53YtBV8kDKDnTjOB/wdkbztXfFgA94inHtxH
         c0UM7VS0gcrPi+So1ATmiY6wAHKZPpw7lUBV3FKK7Jn3qLSFvmUGEIr8VY2hZBZY41xG
         9gTiD9tHRygj94WPvSZ/lptOp6BflWAvFq2eukKbfwepDlc7SNjMXzhhon581hi2rUBt
         pLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwtTEbmlXnujC43R9TfjoasxjZKBvfpbzL9qb8eymODYnFcDXKrYIccBH6O3T++/+ZJ2G1LxQxT5Qr5QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTEV7incj9RR2o4nW5w/yPqf7Dxh2RguJdZ8YWPWTkkTJ+A4MF
	H83+AytBlmmPQoM7JXZQqTfvhOWCA0c3gO5O832m4ZxoTWFDM5vc9xffihSzLd8zeqADyBPFpoV
	Eewi/zw671zQHH1jnCdbqRXJXs3xhA9Qt4HBMFZvVXqbnG4aW2wQRkKc=
X-Google-Smtp-Source: AGHT+IGQJu4Luv5D0CjL4HlLjCp1t1baK7fo0v9ncw/Q6bmmXGaNV04G7Eb+zHRT6MA/H7EpEl62mHrcNkiSlj+OGMn0+yQbrFrM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d06:b0:3d3:fcff:edae with SMTP id
 e9e14a558f8ab-3d4839f5d33mr42633745ab.3.1742024102391; Sat, 15 Mar 2025
 00:35:02 -0700 (PDT)
Date: Sat, 15 Mar 2025 00:35:02 -0700
In-Reply-To: <tencent_8B2EEC8C8567D4C6F652C48644498B2EC206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d52da6.050a0220.14e108.0053.GAE@google.com>
Subject: Re: [syzbot] [wireless?] possible deadlock in ieee80211_change_mac (3)
From: syzbot <syzbot+30de9d963fdd95d745f8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

[    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/inpu=
t0
[    6.315586][    T1] ACPI: button: Power Button [PWRF]
[    6.317572][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN=
:00/input/input1
[    6.319522][    T1] ACPI: button: Sleep Button [SLPF]
[    6.322849][  T160] kworker/u8:2 (160) used greatest stack depth: 25040 =
bytes left
[    6.339104][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[    6.357629][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    6.358659][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for leg=
acy driver
[    6.376651][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[    6.377767][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for leg=
acy driver
[    6.396682][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[    6.397793][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for leg=
acy driver
[    6.410957][    T1] virtio-pci 0000:00:07.0: virtio_pci: leaving for leg=
acy driver
[    6.765156][    T1] N_HDLC line discipline registered with maxframe=3D40=
96
[    6.766554][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[    6.771823][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[    6.782377][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D =
115200) is a 16550A
[    6.793730][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D =
115200) is a 16550A
[    6.802882][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D =
115200) is a 16550A
[    6.817467][    T1] Non-volatile memory driver v1.3
[    6.833852][    T1] Linux agpgart interface v0.103
[    6.838660][    T1] usbcore: registered new interface driver xillyusb
[    6.842888][    T1] ACPI: bus type drm_connector registered
[    6.848740][    T1] [drm] Initialized vgem 1.0.0 for vgem on minor 0
[    6.856871][    T1] [drm] Initialized vkms 1.0.0 for vkms on minor 1
[    6.920872][    T1] Console: switching to colour frame buffer device 128=
x48
[    6.939174][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[    6.940974][    T1] usbcore: registered new interface driver udl
[    6.943622][    T1] usbcore: registered new interface driver gm12u320
[    6.945937][    T1] usbcore: registered new interface driver gud
[    6.996845][    T1] brd: module loaded
[    7.125659][    T1] loop: module loaded
[    7.222154][    T1] zram: Added device: zram0
[    7.231576][    T1] null_blk: disk nullb0 created
[    7.232720][    T1] null_blk: module loaded
[    7.234877][    T1] Guest personality initialized and is inactive
[    7.236894][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[    7.237964][    T1] Initialized host personality
[    7.238752][    T1] usbcore: registered new interface driver rtsx_usb
[    7.241700][    T1] usbcore: registered new interface driver viperboard
[    7.243324][    T1] usbcore: registered new interface driver dln2
[    7.244938][    T1] usbcore: registered new interface driver pn533_usb
[    7.250291][    T1] nfcsim 0.2 initialized
[    7.251327][    T1] usbcore: registered new interface driver port100
[    7.253031][    T1] usbcore: registered new interface driver nfcmrvl
[    7.260121][    T1] Loading iSCSI transport class v2.0-870.
[    7.273577][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.290506][    T1] scsi host0: Virtio SCSI HBA
[    7.346832][    T1] st: Version 20160209, fixed bufsize 32768, s/g segs =
256
[    7.356167][   T67] scsi 0:0:1:0: Direct-Access     Google   PersistentD=
isk   1    PQ: 0 ANSI: 6
[    7.398007][    T1] Rounding down aligned max_sectors from 4294967295 to=
 4294967288
[    7.401815][    T1] db_root: cannot open: /etc/target
[    7.405313][    T1] slram: not enough parameters.
[    7.418587][    T1] ftl_cs: FTL header not found.
[    7.489656][    T1] wireguard: WireGuard 1.0.0 loaded. See www.wireguard=
.com for information.
[    7.491468][    T1] wireguard: Copyright (C) 2015-2019 Jason A. Donenfel=
d <Jason@zx2c4.com>. All Rights Reserved.
[    7.493205][    T1] eql: Equalizer2002: Simon Janes (simon@ncm.com) and =
David S. Miller (davem@redhat.com)
[    7.505905][    T1] MACsec IEEE 802.1AE
[    7.520864][    T1] usbcore: registered new interface driver mvusb_mdio
[    7.522652][    T1] tun: Universal TUN/TAP device driver, 1.6
[    7.610482][    T1] vcan: Virtual CAN interface driver
[    7.611463][    T1] vxcan: Virtual CAN Tunnel driver
[    7.612662][    T1] slcan: serial line CAN interface driver
[    7.613594][    T1] CAN device driver interface
[    7.615490][    T1] usbcore: registered new interface driver usb_8dev
[    7.617483][    T1] usbcore: registered new interface driver ems_usb
[    7.619366][    T1] usbcore: registered new interface driver esd_usb
[    7.621425][    T1] usbcore: registered new interface driver etas_es58x
[    7.622931][    T1] usbcore: registered new interface driver f81604
[    7.625832][    T1] usbcore: registered new interface driver gs_usb
[    7.627854][    T1] usbcore: registered new interface driver kvaser_usb
[    7.629164][    T1] usbcore: registered new interface driver mcba_usb
[    7.630506][    T1] usbcore: registered new interface driver peak_usb
[    7.632412][    T1] usbcore: registered new interface driver ucan
[    7.634580][    T1] e100: Intel(R) PRO/100 Network Driver
[    7.635683][    T1] e100: Copyright(c) 1999-2006 Intel Corporation
[    7.637454][    T1] e1000: Intel(R) PRO/1000 Network Driver
[    7.638344][    T1] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    7.639758][    T1] e1000e: Intel(R) PRO/1000 Network Driver
[    7.640954][    T1] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    7.643738][    T1] mkiss: AX.25 Multikiss, Hans Albas PE1AYX
[    7.644897][    T1] AX.25: bpqether driver version 004
[    7.647261][    T1] PPP generic driver version 2.4.2
[    7.649746][    T1] PPP BSD Compression module registered
[    7.650859][    T1] PPP Deflate Compression module registered
[    7.651804][    T1] PPP MPPE Compression module registered
[    7.653073][    T1] NET: Registered PF_PPPOX protocol family
[    7.654416][    T1] PPTP driver version 0.8.5
[    7.658831][    T1] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channel=
s, max=3D256) (6 bit encapsulation enabled).
[    7.661202][    T1] CSLIP: code copyright 1989 Regents of the University=
 of California.
[    7.662988][    T1] SLIP linefill/keepalive option.
[    7.664045][    T1] hdlc: HDLC support module revision 1.22
[    7.665756][    T1] LAPB Ethernet driver version 0.02
[    7.668387][    T1] usbcore: registered new interface driver ath9k_htc
[    7.670120][    T1] usbcore: registered new interface driver carl9170
[    7.671501][    T1] usbcore: registered new interface driver ath6kl_usb
[    7.673063][    T1] usbcore: registered new interface driver ar5523
[    7.674505][    T1] usbcore: registered new interface driver ath10k_usb
[    7.676436][    T1] usbcore: registered new interface driver plfxlc
[    7.678342][    T1] mac80211_hwsim: initializing netlink
[    7.705471][    T1] list_add double add: new=3Dffff8880277a4da0, prev=3D=
ffff888027870d70, next=3Dffff8880277a4da0.
[    7.707421][    T1] ------------[ cut here ]------------
[    7.708474][    T1] kernel BUG at lib/list_debug.c:37!
[    7.709432][    T1] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PT=
I
[    7.710420][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
4.0-rc6-syzkaller-gbfc6c67ec2d6-dirty #0
[    7.712038][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/12/2025
[    7.713504][    T1] RIP: 0010:__list_add_valid_or_report+0xa4/0x130
[    7.714682][    T1] Code: f7 74 11 b0 01 5b 41 5c 41 5d 41 5e 41 5f 5d c=
3 cc cc cc cc 48 c7 c7 20 03 81 8c 4c 89 fe 4c 89 e2 4c 89 f1 e8 0d 73 2a f=
c 90 <0f> 0b 48 c7 c7 20 01 81 8c e8 fe 72 2a fc 90 0f 0b 48 c7 c7 c0 01
[    7.715028][    T1] RSP: 0000:ffffc90000067300 EFLAGS: 00010246
[    7.715028][    T1] RAX: 0000000000000058 RBX: 1ffff11004f0e1ae RCX: 34f=
309c9fab66800
[    7.715028][    T1] RDX: 0000000000000000 RSI: 0000000080000000 RDI: 000=
0000000000000
[    7.715028][    T1] RBP: 1ffff11004ef49b5 R08: ffffffff81a1458c R09: fff=
ffbfff1d3a69c
[    7.715028][    T1] R10: dffffc0000000000 R11: fffffbfff1d3a69c R12: fff=
f888027870d70
[    7.715028][    T1] R13: dffffc0000000000 R14: ffff8880277a4da0 R15: fff=
f8880277a4da0
[    7.715028][    T1] FS:  0000000000000000(0000) GS:ffff8880b8700000(0000=
) knlGS:0000000000000000
[    7.715028][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.715028][    T1] CR2: 0000000000000000 CR3: 000000000e938000 CR4: 000=
00000003526f0
[    7.715028][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.715028][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.715028][    T1] Call Trace:
[    7.715028][    T1]  <TASK>
[    7.715028][    T1]  ? __die_body+0x5f/0xb0
[    7.715028][    T1]  ? die+0x9e/0xc0
[    7.715028][    T1]  ? do_trap+0x15a/0x3a0
[    7.715028][    T1]  ? __list_add_valid_or_report+0xa4/0x130
[    7.715028][    T1]  ? do_error_trap+0x1dc/0x2c0
[    7.715028][    T1]  ? __list_add_valid_or_report+0xa4/0x130
[    7.715028][    T1]  ? __pfx___mutex_trylock_common+0x10/0x10
[    7.715028][    T1]  ? __pfx_do_error_trap+0x10/0x10
[    7.715028][    T1]  ? handle_invalid_op+0x34/0x40
[    7.715028][    T1]  ? __list_add_valid_or_report+0xa4/0x130
[    7.715028][    T1]  ? exc_invalid_op+0x38/0x50
[    7.715028][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.715028][    T1]  ? __wake_up_klogd+0xcc/0x110
[    7.715028][    T1]  ? __list_add_valid_or_report+0xa4/0x130
[    7.715028][    T1]  cfg80211_register_wdev+0x16a/0x410
[    7.715028][    T1]  cfg80211_register_netdevice+0x19c/0x2c0
[    7.715028][    T1]  ieee80211_if_add+0x119d/0x1780
[    7.715028][    T1]  ieee80211_register_hw+0x3708/0x42e0
[    7.715028][    T1]  ? ieee80211_register_hw+0x1611/0x42e0
[    7.715028][    T1]  ? __pfx_ieee80211_register_hw+0x10/0x10
[    7.715028][    T1]  ? __asan_memset+0x23/0x50
[    7.715028][    T1]  ? __hrtimer_init+0x170/0x250
[    7.715028][    T1]  mac80211_hwsim_new_radio+0x2a89/0x49f0
[    7.715028][    T1]  ? kasan_quarantine_put+0xdc/0x230
[    7.715028][    T1]  ? __pfx_mac80211_hwsim_new_radio+0x10/0x10
[    7.715028][    T1]  ? sysfs_create_groups+0x9b/0x120
[    7.715028][    T1]  ? class_register+0x302/0x380
[    7.715028][    T1]  init_mac80211_hwsim+0x87a/0xb00
[    7.715028][    T1]  ? __pfx_init_mac80211_hwsim+0x10/0x10
[    7.715028][    T1]  ? usb_register_driver+0x2e2/0x380
[    7.715028][    T1]  ? __pfx_init_mac80211_hwsim+0x10/0x10
[    7.715028][    T1]  do_one_initcall+0x248/0x930
[    7.715028][    T1]  ? __pfx_init_mac80211_hwsim+0x10/0x10
[    7.715028][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.715028][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.715028][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.715028][    T1]  do_initcall_level+0x157/0x210
[    7.715028][    T1]  do_initcalls+0x71/0xd0
[    7.715028][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.715028][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.715028][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.715028][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.715028][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.715028][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.715028][    T1]  kernel_init+0x1d/0x2b0
[    7.715028][    T1]  ret_from_fork+0x4b/0x80
[    7.715028][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.715028][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.715028][    T1]  </TASK>
[    7.715028][    T1] Modules linked in:
[    7.769984][    T1] ---[ end trace 0000000000000000 ]---
[    7.771150][    T1] RIP: 0010:__list_add_valid_or_report+0xa4/0x130
[    7.772404][    T1] Code: f7 74 11 b0 01 5b 41 5c 41 5d 41 5e 41 5f 5d c=
3 cc cc cc cc 48 c7 c7 20 03 81 8c 4c 89 fe 4c 89 e2 4c 89 f1 e8 0d 73 2a f=
c 90 <0f> 0b 48 c7 c7 20 01 81 8c e8 fe 72 2a fc 90 0f 0b 48 c7 c7 c0 01
[    7.775821][    T1] RSP: 0000:ffffc90000067300 EFLAGS: 00010246
[    7.776716][    T1] RAX: 0000000000000058 RBX: 1ffff11004f0e1ae RCX: 34f=
309c9fab66800
[    7.777976][    T1] RDX: 0000000000000000 RSI: 0000000080000000 RDI: 000=
0000000000000
[    7.779137][    T1] RBP: 1ffff11004ef49b5 R08: ffffffff81a1458c R09: fff=
ffbfff1d3a69c
[    7.780370][    T1] R10: dffffc0000000000 R11: fffffbfff1d3a69c R12: fff=
f888027870d70
[    7.781997][    T1] R13: dffffc0000000000 R14: ffff8880277a4da0 R15: fff=
f8880277a4da0
[    7.783289][    T1] FS:  0000000000000000(0000) GS:ffff8880b8700000(0000=
) knlGS:0000000000000000
[    7.784799][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.785960][    T1] CR2: 0000000000000000 CR3: 000000000e938000 CR4: 000=
00000003526f0
[    7.787590][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.789103][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.790409][    T1] Kernel panic - not syncing: Fatal exception
[    7.791627][    T1] Kernel Offset: disabled
[    7.792351][    T1] Rebooting in 86400 seconds..


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
GOROOT=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.=
1-go1.23.6.linux-amd64'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod/golang.org/toolchain@v0=
.0.1-go1.23.6.linux-amd64/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.23.6'
GODEBUG=3D''
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
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
 -ffile-prefix-map=3D/tmp/go-build1502864929=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at e28266709d
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
/syzkaller/prog.GitRevision=3De28266709dd2a1d1452d4a5bbf271700e10335c6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20250313-150626'" -o ./b=
in/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"e28266709dd2a1d1452d4a5bbf271700e1=
0335c6\"
/usr/bin/ld: /tmp/ccc6buJh.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D15237874580000


Tested on:

commit:         bfc6c67e net/smc: use the correct ndev to find pnetid ..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Daeeec842a6bdc8b=
9
dashboard link: https://syzkaller.appspot.com/bug?extid=3D30de9d963fdd95d74=
5f8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D14378fa85800=
00


