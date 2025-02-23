Return-Path: <linux-kernel+bounces-527654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A47A4A40DCA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDEE173F3B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A43203719;
	Sun, 23 Feb 2025 09:51:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368811FECC5
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304264; cv=none; b=a0AKJwLHBPHjO8c88p07d+YkwJRhw4MYCXScS9fx4Qtp/dMwuOiwL6GrZ/tMtzA1Q0bHbfbVLdV44rPKojRdAUVNhPAUGvtB2Kvv7mimZOC+QWEHAJaBzcUNSrXl20g4ALuZJVCH4qZjwJtaCHrU6ozz1B1ZZ2B1urEMansvv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304264; c=relaxed/simple;
	bh=rjb1M7iZWzFVYPz8NOl3wbEqo6q2VNg41tw2WJfMd/s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YLKTEPTbB7EfpDQVFA5mnGvbFJRF4B/EhzPO31jndOYOWiz1UEZmeZ2iY5JJuXSn0afapH7RwykNFqsxPZAkh6D5ZgUYbGITBMDxnlrBbwgHjLEvCxDzs8v62oYZeAsb+OPDR0oc3SjTSBj5zoLOpcWlBPXk4GvJRRKLtNADBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2a40e470fso27437265ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 01:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740304261; x=1740909061;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wAcuquWpfFngia0wdI2GbSX4fLFRV8R6SF2GzZrs5c=;
        b=rwUVxI8U/fjrH0egOHwVQoXv+rwfdKm7/EYi58LX/d9pZ5NChLIK1uVK0nCj3KXku2
         u5HbbgQgvuZ/+XcmieUv1gqiLI0EGAGNmcpscPdMhEHk2jhGL55tH6rbKWbDycHJzU9g
         8LXkH5hjpzdwkLFnksz8DjS01bdf0U3znv4IN0wH1gvYlumcu4o00XUgsSvvbcDDel06
         wF1fiLp1wSwpZrUlvHS+vm6qqvmZsFC6EDxcBk+jPcfQfREVCUFkYlyNp7p5bsAKQZO8
         fyU/+2xVH/L/qce6IPkuU/nrz15DTUNhvUogQUnXeBm22OVguyrBmkJyvKw/suYfylDA
         z68g==
X-Forwarded-Encrypted: i=1; AJvYcCWPvyQIeLDXZgjKMnvYmz6GvqFbEbJEJ7BAgsA9IbJEMjyG0ppmH+cwmaRIpVu7owHWo5HrUQ4pAktG7VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMY6IlEE3PdXZ9CASP8fDVPyZbTKOhrg6CkIS4khEFpn/lBfZh
	AXox41FmHeQzrtNQHHzVRw+vjuQiKJR4enpCwfKTc3S+LyGhL7YP3G1OHUa8l10TcyLk2qRgDry
	87hFQ4FuHx16oq0HKC+HDPSp/OClskKmSFeB4pSkaP4wTYsdqk8Rw+S4=
X-Google-Smtp-Source: AGHT+IGxTJOVrI0MSMeqxPXpiC37uS2AdCA8geNNX6zKVQkdMJ5IpkK0xyNXz4oyes+iPp8ovG3bF4bt9pw8Ebcf5XipM5U6DzMa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f04:b0:3cf:b87b:8fde with SMTP id
 e9e14a558f8ab-3d2caefdc5cmr86598605ab.17.1740304261336; Sun, 23 Feb 2025
 01:51:01 -0800 (PST)
Date: Sun, 23 Feb 2025 01:51:01 -0800
In-Reply-To: <tencent_2FD373236F497A83B5C45FB762F77786DC05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67baef85.050a0220.bbfd1.0013.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
From: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ource [io  0x0000-0x0cf7 window]
[    3.463325][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xfff=
f window]
[    3.465986][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0=
x000bffff window]
[    3.469157][    T1] pci_bus 0000:00: root bus resource [mem 0xc0000000-0=
xfebfefff window]
[    3.472205][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.473782][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=
 conventional PCI endpoint
[    3.484482][    T1] pci 0000:00:01.0: [8086:7110] type 00 class 0x060100=
 conventional PCI endpoint
[    3.498697][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=
 conventional PCI endpoint
[    3.509581][    T1] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed=
 by PIIX4 ACPI
[    3.517550][    T1] pci 0000:00:03.0: [1af4:1004] type 00 class 0x000000=
 conventional PCI endpoint
[    3.535057][    T1] pci 0000:00:03.0: BAR 0 [io  0xc000-0xc03f]
[    3.537097][    T1] pci 0000:00:03.0: BAR 1 [mem 0xfe800000-0xfe80007f]
[    3.544872][    T1] pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000=
 conventional PCI endpoint
[    3.561393][    T1] pci 0000:00:04.0: BAR 0 [io  0xc040-0xc07f]
[    3.563343][    T1] pci 0000:00:04.0: BAR 1 [mem 0xfe801000-0xfe80107f]
[    3.570338][    T1] pci 0000:00:05.0: [1ae0:a002] type 00 class 0x030000=
 conventional PCI endpoint
[    3.585610][    T1] pci 0000:00:05.0: BAR 0 [mem 0xfe000000-0xfe7fffff]
[    3.588960][    T1] pci 0000:00:05.0: Video device with shadowed ROM at =
[mem 0x000c0000-0x000dffff]
[    3.597791][    T1] pci 0000:00:06.0: [1af4:1002] type 00 class 0x00ff00=
 conventional PCI endpoint
[    3.611209][    T1] pci 0000:00:06.0: BAR 0 [io  0xc080-0xc09f]
[    3.617655][    T1] pci 0000:00:07.0: [1af4:1005] type 00 class 0x00ff00=
 conventional PCI endpoint
[    3.632109][    T1] pci 0000:00:07.0: BAR 0 [io  0xc0a0-0xc0bf]
[    3.635623][    T1] pci 0000:00:07.0: BAR 1 [mem 0xfe802000-0xfe80203f]
[    3.669511][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    3.677322][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    3.687243][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    3.696353][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    3.702587][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    3.721105][    T1] iommu: Default domain type: Translated
[    3.722975][    T1] iommu: DMA domain TLB invalidation policy: lazy mode
[    3.727197][    T1] SCSI subsystem initialized
[    3.745508][    T1] ACPI: bus type USB registered
[    3.747961][    T1] usbcore: registered new interface driver usbfs
[    3.750545][    T1] usbcore: registered new interface driver hub
[    3.752997][    T1] usbcore: registered new device driver usb
[    3.755635][    T1] mc: Linux media interface: v0.10
[    3.757897][    T1] videodev: Linux video capture interface: v2.00
[    3.761166][    T1] pps_core: LinuxPPS API ver. 1 registered
[    3.763309][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    3.767164][    T1] PTP clock support registered
[    3.784211][    T1] EDAC MC: Ver: 3.0.0
[    3.807359][    T1] Advanced Linux Sound Architecture Driver Initialized=
.
[    3.817665][    T1] Bluetooth: Core ver 2.22
[    3.819562][    T1] NET: Registered PF_BLUETOOTH protocol family
[    3.821239][    T1] Bluetooth: HCI device and connection manager initial=
ized
[    3.822978][    T1] Bluetooth: HCI socket layer initialized
[    3.823341][    T1] Bluetooth: L2CAP socket layer initialized
[    3.824795][    T1] Bluetooth: SCO socket layer initialized
[    3.826338][    T1] NET: Registered PF_ATMPVC protocol family
[    3.827830][    T1] NET: Registered PF_ATMSVC protocol family
[    3.829620][    T1] NetLabel: Initializing
[    3.830990][    T1] NetLabel:  domain hash size =3D 128
[    3.833307][    T1] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    3.836266][    T1] NetLabel:  unlabeled traffic allowed by default
[    3.843290][    T1] nfc: nfc_init: NFC Core ver 0.1
[    3.843801][    T1] NET: Registered PF_NFC protocol family
[    3.846041][    T1] PCI: Using ACPI for IRQ routing
[    3.849665][    T1] pci 0000:00:05.0: vgaarb: setting as boot VGA device
[    3.852568][    T1] pci 0000:00:05.0: vgaarb: bridge control possible
[    3.853287][    T1] pci 0000:00:05.0: vgaarb: VGA device added: decodes=
=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    3.863312][    T1] vgaarb: loaded
[    3.918207][    T1] clocksource: Switched to clocksource kvm-clock
[    3.932462][    T1] VFS: Disk quotas dquot_6.6.0
[    3.934309][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4=
096 bytes)
[    3.941793][    T1] pnp: PnP ACPI init
[    3.966334][    T1] pnp: PnP ACPI: found 7 devices
[    4.022143][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xf=
fffff, max_idle_ns: 2085701024 ns
[    4.026722][    T1] NET: Registered PF_INET protocol family
[    4.029726][    T1] IP idents hash table entries: 131072 (order: 8, 1048=
576 bytes, linear)
[    4.057661][    T1] tcp_listen_portaddr_hash hash table entries: 4096 (o=
rder: 6, 294912 bytes, linear)
[    4.061945][    T1] Table-perturb hash table entries: 65536 (order: 6, 2=
62144 bytes, linear)
[    4.065306][    T1] TCP established hash table entries: 65536 (order: 7,=
 524288 bytes, linear)
[    4.079908][    T1] TCP bind hash table entries: 65536 (order: 11, 94371=
84 bytes, vmalloc hugepage)
[    4.095435][    T1] TCP: Hash tables configured (established 65536 bind =
65536)
[    4.099377][    T1] UDP hash table entries: 4096 (order: 8, 1048576 byte=
s, linear)
[    4.103973][    T1] UDP-Lite hash table entries: 4096 (order: 8, 1048576=
 bytes, linear)
[    4.109358][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    4.115024][    T1] RPC: Registered named UNIX socket transport module.
[    4.117573][    T1] RPC: Registered udp transport module.
[    4.119562][    T1] RPC: Registered tcp transport module.
[    4.121568][    T1] RPC: Registered tcp-with-tls transport module.
[    4.123951][    T1] RPC: Registered tcp NFSv4.1 backchannel transport mo=
dule.
[    4.132788][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 windo=
w]
[    4.135225][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff windo=
w]
[    4.137681][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bff=
ff window]
[    4.140403][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfef=
ff window]
[    4.144591][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    4.147415][    T1] PCI: CLS 0 bytes, default 64
[    4.149454][    T1] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)
[    4.152150][    T1] software IO TLB: mapped [mem 0x00000000bbffd000-0x00=
000000bfffd000] (64MB)
[    4.162476][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters=
, 10737418240 ms ovfl timer
[    4.165933][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycle=
s: 0x1fb63109b96, max_idle_ns: 440795265316 ns
[    4.194080][    T1] clocksource: Switched to clocksource tsc
[    4.198133][   T47] kworker/u8:0 (47) used greatest stack depth: 27904 b=
ytes left
[    4.427818][   T57] kworker/u8:0 (57) used greatest stack depth: 27872 b=
ytes left
[    4.443204][   T62] kworker/u8:0 (62) used greatest stack depth: 26864 b=
ytes left
[    7.013884][    T1] Initialise system trusted keyrings
[    7.016895][    T1] workingset: timestamp_bits=3D40 max_order=3D21 bucke=
t_order=3D0
[    7.023563][    T1] NFS: Registering the id_resolver key type
[    7.025658][    T1] Key type id_resolver registered
[    7.027644][    T1] Key type id_legacy registered
[    7.030687][    T1] 9p: Installing v9fs 9p2000 file system support
[    7.074583][    T1] Key type asymmetric registered
[    7.075691][    T1] Asymmetric key parser 'x509' registered
[    7.077398][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 246)
[    7.080437][    T1] io scheduler mq-deadline registered
[    7.082146][    T1] io scheduler kyber registered
[    7.088789][    T1] usbcore: registered new interface driver udlfb
[    7.093006][    T1] usbcore: registered new interface driver smscufx
[    7.097895][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[    7.101275][    T1]=20
[    7.101676][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
[    7.103134][    T1] WARNING: possible recursive locking detected
[    7.105147][    T1] 6.14.0-rc3-syzkaller-00037-gc749f058b437-dirty #0 No=
t tainted
[    7.108027][    T1] --------------------------------------------
[    7.109536][    T1] swapper/0/1 is trying to acquire lock:
[    7.111185][    T1] ffffffff89be7b08 (input_mutex){+.+.}-{4:4}, at: inpu=
t_open_device+0x47/0x370
[    7.111185][    T1]=20
[    7.111185][    T1] but task is already holding lock:
[    7.111185][    T1] ffffffff89be7b08 (input_mutex){+.+.}-{4:4}, at: inpu=
t_register_device+0x98a/0x1130
[    7.111185][    T1]=20
[    7.111185][    T1] other info that might help us debug this:
[    7.111185][    T1]  Possible unsafe locking scenario:
[    7.111185][    T1]=20
[    7.111185][    T1]        CPU0
[    7.111185][    T1]        ----
[    7.111185][    T1]   lock(input_mutex);
[    7.111185][    T1]   lock(input_mutex);
[    7.111185][    T1]=20
[    7.111185][    T1]  *** DEADLOCK ***
[    7.111185][    T1]=20
[    7.111185][    T1]  May be due to missing lock nesting notation
[    7.111185][    T1]=20
[    7.111185][    T1] 2 locks held by swapper/0/1:
[    7.111185][    T1]  #0: ffff888106ab3348 (&dev->mutex){....}-{4:4}, at:=
 __driver_attach+0x278/0x580
[    7.111185][    T1]  #1: ffffffff89be7b08 (input_mutex){+.+.}-{4:4}, at:=
 input_register_device+0x98a/0x1130
[    7.111185][    T1]=20
[    7.111185][    T1] stack backtrace:
[    7.111185][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
4.0-rc3-syzkaller-00037-gc749f058b437-dirty #0
[    7.111185][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 12/27/2024
[    7.111185][    T1] Call Trace:
[    7.111185][    T1]  <TASK>
[    7.111185][    T1]  dump_stack_lvl+0x116/0x1f0
[    7.111185][    T1]  print_deadlock_bug+0x2e3/0x410
[    7.111185][    T1]  __lock_acquire+0x2117/0x3c40
[    7.111185][    T1]  ? __pfx___lock_acquire+0x10/0x10
[    7.111185][    T1]  lock_acquire.part.0+0x11b/0x380
[    7.111185][    T1]  ? input_open_device+0x47/0x370
[    7.111185][    T1]  ? __pfx_lock_acquire.part.0+0x10/0x10
[    7.111185][    T1]  ? rcu_is_watching+0x12/0xc0
[    7.111185][    T1]  ? trace_lock_acquire+0x14e/0x1f0
[    7.111185][    T1]  ? input_register_handle+0x22f/0x5f0
[    7.111185][    T1]  ? input_open_device+0x47/0x370
[    7.111185][    T1]  ? lock_acquire+0x2f/0xb0
[    7.111185][    T1]  ? input_open_device+0x47/0x370
[    7.111185][    T1]  __mutex_lock+0x19b/0xb10
[    7.111185][    T1]  ? input_open_device+0x47/0x370
[    7.111185][    T1]  ? input_open_device+0x47/0x370
[    7.111185][    T1]  ? __pfx___mutex_lock+0x10/0x10
[    7.111185][    T1]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[    7.111185][    T1]  ? __pfx___might_resched+0x10/0x10
[    7.111185][    T1]  ? input_open_device+0x47/0x370
[    7.111185][    T1]  input_open_device+0x47/0x370
[    7.111185][    T1]  kbd_connect+0x103/0x160
[    7.111185][    T1]  input_attach_handler.isra.0+0x181/0x260
[    7.111185][    T1]  input_register_device+0xa84/0x1130
[    7.111185][    T1]  acpi_button_add+0x57a/0xb70
[    7.111185][    T1]  ? __pfx_acpi_button_notify+0x10/0x10
[    7.111185][    T1]  ? __pfx_acpi_button_add+0x10/0x10
[    7.111185][    T1]  acpi_device_probe+0xc6/0x330
[    7.111185][    T1]  ? driver_sysfs_add+0xa5/0x2d0
[    7.111185][    T1]  ? __pfx_acpi_device_probe+0x10/0x10
[    7.111185][    T1]  really_probe+0x23e/0xa90
[    7.111185][    T1]  __driver_probe_device+0x1de/0x440
[    7.111185][    T1]  driver_probe_device+0x4c/0x1b0
[    7.111185][    T1]  __driver_attach+0x283/0x580
[    7.111185][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.111185][    T1]  bus_for_each_dev+0x13c/0x1d0
[    7.111185][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.111185][    T1]  bus_add_driver+0x2e9/0x690
[    7.111185][    T1]  driver_register+0x15c/0x4b0
[    7.111185][    T1]  __acpi_bus_register_driver+0xdf/0x130
[    7.111185][    T1]  ? __pfx_acpi_button_driver_init+0x10/0x10
[    7.111185][    T1]  acpi_button_driver_init+0x82/0x110
[    7.111185][    T1]  do_one_initcall+0x128/0x700
[    7.111185][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.111185][    T1]  ? __kmalloc_noprof+0x22b/0x4d0
[    7.111185][    T1]  ? __asan_register_globals+0x1c/0x80
[    7.111185][    T1]  kernel_init_freeable+0x5c7/0x900
[    7.111185][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.111185][    T1]  kernel_init+0x1c/0x2b0
[    7.111185][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.111185][    T1]  ret_from_fork+0x45/0x80
[    7.111185][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.111185][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.111185][    T1]  </TASK>
[  311.073116][   T11] kworker/u8:0 (11) used greatest stack depth: 25856 b=
ytes left


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
 -ffile-prefix-map=3D/tmp/go-build3073680802=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at b257a9b754
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
/syzkaller/prog.GitRevision=3Db257a9b7546c59d44cd69160b5a65a1bf1f050eb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20250219-145244'" -o ./b=
in/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"b257a9b7546c59d44cd69160b5a65a1bf1=
f050eb\"
/usr/bin/ld: /tmp/ccycsKnp.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D176ba7a4580000


Tested on:

commit:         c749f058 USB: core: Add eUSB2 descriptor and parsing i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.=
git usb-testing
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df429368eda610a8=
9
dashboard link: https://syzkaller.appspot.com/bug?extid=3D0154da2d403396b2b=
d59
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D15535fdf9800=
00


