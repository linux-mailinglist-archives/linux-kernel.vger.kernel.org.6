Return-Path: <linux-kernel+bounces-327858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8A3977BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDC3281566
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380741D58BB;
	Fri, 13 Sep 2024 09:12:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638331BD4EA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218726; cv=none; b=kbczV+zKgqblDS/Werkwsj4d0FYX1kodgaXwUJYnyTOYN8EQGr1etmdPkXtyv4SM1YiPPy7DEzVhHrA2QRNIDmwlare29xx6Xoa/sSxmTPh3eTxxiHv0ZwP+7NHYshtWnl4M202pBfvCqIkJb72HBslSnUcLsls486cZBYufOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218726; c=relaxed/simple;
	bh=yJU4drUzRIoLIlSqGNV5DRhSaWO2Pp6w+xPWIuf+unA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nX8iBQZKUOF8j07EJerBIlNDSGzUJ5Qq0SnGQjcPVP5RhsdlCFLFFcClm5MZ/TXyQIFcKCoylZwMCmaqbPoBwINgbpD8kTm+snUAx0wq9/hD9YcR0WiYelxmNN2mChW+cjxS67LxFeyPocibaY6LP8cQqPyGL8DqekIP98vzYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a087f805c1so17017305ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726218722; x=1726823522;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ifp0OHiQ4goabvpmIltXcqNWYDgWu7QOxgnsFBzY9IY=;
        b=IdYKGj5W4kvgQEH8hE5SpEGdDHicHw8wjxGb+Mc7TUERw0bAJaxE7v1rbJlEcPxOsi
         00ySRYHjH8ZISnWenJDhp7HxrrwbLEa73dfxvDhPafunilotS2QGlFacKCVNuhNtORKU
         US3kog1JrtyeH+T6eOGBfrBYndlTBPJz1Kn5aLkjajHbgT4MCNXfBxdiSB+dJNu0Nq/6
         oSImhnWMmSLs1mRSJQbB9GbrrgDM4sJGBtkiFUKl28Y2EgDzAOfNNRiOXy5SQjLXGUlU
         n0zYplh51jGCB0zj56WfHAvDogIHI5txyXBhx+aN1I+AjzmLMB/I/Hp5bJS3BvwjKAfY
         6ruQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0xK6TQKyDo/AfQ1xsnEDlyW+7aXrhmhxyl0EjXwGY/PmlGrBU44PDCZ7rgHFFpXM+n19nktzmGwdzvc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6jqsCfa8uJo6GDhAjIau4cPq0MbBui9sf1qRl3PFRh0Lazrt
	83gyrHMlnmw+GB8zr7lbopYTR55ZpvH8aIV6zw20HSSKW5TEcQswbKsqNaXpsvu/fit4UfpdqF3
	M+g9dSXO0HWEBbX2G9f0doN7n310GeipSyPfdmc2ikNGu7uwhXrS8fbA=
X-Google-Smtp-Source: AGHT+IEaTB7ogmYkF61pN6XSeTlFIRx6cgUZC8zbTRlxzZOZH0aSyBJmehwaqbY7aqG3fpY6pBC5RWzs/LxbiH+bcxR5Ux59I7RQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc9:b0:382:b82b:6e48 with SMTP id
 e9e14a558f8ab-3a0848c9171mr52632985ab.9.1726218722423; Fri, 13 Sep 2024
 02:12:02 -0700 (PDT)
Date: Fri, 13 Sep 2024 02:12:02 -0700
In-Reply-To: <CACb6ct3x-hicbOn5ntiSUJdd3iPSmmnYcof4qH2ibauO7SG1KQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e401e2.050a0220.2e1f95.0000.GAE@google.com>
Subject: Re: [syzbot] [crypto?] [ntfs3?] KMSAN: uninit-value in sw842_compress
From: syzbot <syzbot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com>
To: ksjoe30@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

t Branch Prediction Barrier
[    0.233228] Spectre V2 : User space: Mitigation: STIBP via seccomp and p=
rctl
[    0.234229] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl and seccomp
[    0.235273] TAA: Mitigation: Clear CPU buffers
[    0.236227] MDS: Mitigation: Clear CPU buffers
[    0.237511] Freeing SMP alternatives memory: 40K
[    0.341387] smpboot: CPU0: Intel(R) Xeon(R) CPU @ 2.20GHz (family: 0x6, =
model: 0x4f, stepping: 0x0)
[    0.342342] Performance Events: unsupported p6 CPU model 79 no PMU drive=
r, software events only.
[    0.343304] rcu: Hierarchical SRCU implementation.
[    0.344161] smp: Bringing up secondary CPUs ...
[    0.344313] x86: Booting SMP configuration:
[    0.345227] .... node  #0, CPUs:      #1
[    0.101781] kvm-clock: cpu 1, msr ab0a2041, secondary cpu clock
[    0.346631] kvm-stealtime: cpu 1, msr 237b15200
[    0.348334] MDS CPU bug present and SMT on, data leak possible. See http=
s://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more de=
tails.
[    0.349230] TAA CPU bug present and SMT on, data leak possible. See http=
s://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html=
 for more details.
[    0.350234] smp: Brought up 1 node, 2 CPUs
[    0.350810] smpboot: Max logical packages: 1
[    0.351228] smpboot: Total of 2 processors activated (8800.63 BogoMIPS)
[    0.352460] devtmpfs: initialized
[    0.353294] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    0.353284] kworker/u4:0 (22) used greatest stack depth: 14336 bytes lef=
t
[    0.354234] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.357373] RTC time:  9:02:57, date: 09/13/24
[    0.359244] NET: Registered protocol family 16
[    0.359931] audit: initializing netlink subsys (disabled)
[    0.361244] audit: type=3D2000 audit(1726218177.184:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.361614] kworker/u4:1 (28) used greatest stack depth: 13936 bytes lef=
t
[    0.363236] cpuidle: using governor menu
[    0.363337] ACPI: bus type PCI registered
[    0.364372] PCI: Using configuration type 1 for base access
[    0.373228] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.374282] ACPI: Added _OSI(Module Device)
[    0.375233] ACPI: Added _OSI(Processor Device)
[    0.376233] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.377003] ACPI: Added _OSI(Processor Aggregator Device)
[    0.377233] ACPI: Added _OSI(Linux-Dell-Video)
[    0.377886] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.379869] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.381674] ACPI: Interpreter enabled
[    0.382248] ACPI: (supports S0 S3 S4 S5)
[    0.383229] ACPI: Using IOAPIC for interrupt routing
[    0.384235] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.385415] ACPI: Enabled 16 GPEs in block 00 to 0F
[    0.390247] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.391232] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I]
[    0.392256] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.393238] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    0.394358] PCI host bridge to bus 0000:00
[    0.395229] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]
[    0.396163] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]
[    0.397229] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.398228] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfeff=
f window]
[    0.399229] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.434280] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX=
4 ACPI
[    0.547277] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.549289] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.551285] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.553288] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.555248] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    0.556431] pci 0000:00:05.0: vgaarb: setting as boot VGA device
[    0.557203] pci 0000:00:05.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    0.558231] pci 0000:00:05.0: vgaarb: bridge control possible
[    0.559227] vgaarb: loaded
[    0.560232] SCSI subsystem initialized
[    0.560305] ACPI: bus type USB registered
[    0.561274] usbcore: registered new interface driver usbfs
[    0.562273] usbcore: registered new interface driver hub
[    0.562273] usbcore: registered new device driver usb
[    0.563253] pps_core: LinuxPPS API ver. 1 registered
[    0.564228] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.565235] PTP clock support registered
[    0.566249] EDAC MC: Ver: 3.0.0
[    0.567225] Advanced Linux Sound Architecture Driver Initialized.
[    0.567303] PCI: Using ACPI for IRQ routing
[    0.569227] NetLabel: Initializing
[    0.569228] NetLabel:  domain hash size =3D 128
[    0.569834] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.570252] NetLabel:  unlabeled traffic allowed by default
[    0.571325] clocksource: Switched to clocksource kvm-clock
[    0.580325] VFS: Disk quotas dquot_6.6.0
[    0.581125] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.582192] pnp: PnP ACPI init
[    0.583276] pnp: PnP ACPI: found 7 devices
[    0.590974] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.592383] NET: Registered protocol family 2
[    0.593291] IP idents hash table entries: 131072 (order: 8, 1048576 byte=
s)
[    0.595192] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4,=
 65536 bytes)
[    0.596433] TCP established hash table entries: 65536 (order: 7, 524288 =
bytes)
[    0.597549] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.598661] TCP: Hash tables configured (established 65536 bind 65536)
[    0.599636] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.600500] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.601494] NET: Registered protocol family 1
[    0.602346] RPC: Registered named UNIX socket transport module.
[    0.603270] RPC: Registered udp transport module.
[    0.603959] RPC: Registered tcp transport module.
[    0.604648] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.605680] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.606569] pci 0000:00:05.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.607780] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.608649] software IO TLB: mapped [mem 0xbbffd000-0xbfffd000] (64MB)
[    0.609637] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 107374=
18240 ms ovfl timer
[    0.611144] RAPL PMU: hw unit of domain pp0-core 2^-0 Joules
[    0.611974] RAPL PMU: hw unit of domain package 2^-0 Joules
[    0.612737] RAPL PMU: hw unit of domain dram 2^-16 Joules
[    0.613501] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb=
6c80a799, max_idle_ns: 440795272342 ns
[    0.615219] Scanning for low memory corruption every 60 seconds
[    0.616680] Initialise system trusted keyrings
[    0.617443] workingset: timestamp_bits=3D56 max_order=3D21 bucket_order=
=3D0
[    0.620806] NFS: Registering the id_resolver key type
[    0.621695] Key type id_resolver registered
[    0.622358] Key type id_legacy registered
[    0.625266] Key type asymmetric registered
[    0.625855] Asymmetric key parser 'x509' registered
[    0.626648] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    0.627648] io scheduler noop registered
[    0.628206] io scheduler deadline registered
[    0.628835] io scheduler cfq registered (default)
[    0.629506] io scheduler mq-deadline registered
[    0.630141] io scheduler kyber registered
[    0.630926] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0
[    0.631962] ACPI: Power Button [PWRF]
[    0.632576] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/inpu=
t/input1
[    0.633600] ACPI: Sleep Button [SLPF]
[    0.636091] PCI Interrupt Link [LNKC] enabled at IRQ 11
[    0.636921] virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driv=
er
[    0.642090] PCI Interrupt Link [LNKD] enabled at IRQ 10
[    0.642888] virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driv=
er
[    0.649581] PCI Interrupt Link [LNKB] enabled at IRQ 10
[    0.650373] virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driv=
er
[    0.654995] virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driv=
er
[    0.670716] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.693031] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    0.715987] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) =
is a 16550A
[    0.739118] 00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D 115200) =
is a 16550A
[    0.762116] 00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D 115200) =
is a 16550A
[    0.764122] Non-volatile memory driver v1.3
[    0.764885] Linux agpgart interface v0.103
[    0.767721] loop: module loaded
[    0.807436] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    0.808493] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.809449] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-=
NAPI
[    0.810633] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.811513] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    0.812734] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.813744] sky2: driver version 1.30
[    0.814550] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.815443] ehci-pci: EHCI PCI platform driver
[    0.816075] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.817012] ohci-pci: OHCI PCI platform driver
[    0.817610] uhci_hcd: USB Universal Host Controller Interface driver
[    0.818556] usbcore: registered new interface driver usblp
[    0.819172] usbcore: registered new interface driver usb-storage
[    0.820220] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    0.821924] i8042: Warning: Keylock active
[    0.824090] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.825039] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.826219] rtc_cmos 00:00: RTC can wake from S4
[    0.827575] rtc_cmos 00:00: registered as rtc0
[    0.828412] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram
[    0.829685] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised:=
 dm-devel@redhat.com
[    0.831360] hidraw: raw HID events driver (C) Jiri Kosina
[    0.832320] usbcore: registered new interface driver usbhid
[    0.833381] usbhid: USB HID core driver
[    0.834620] Initializing XFRM netlink socket
[    0.835375] NET: Registered protocol family 10
[    0.836515] Segment Routing with IPv6
[    0.837254] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.838155] NET: Registered protocol family 17
[    0.838961] Key type dns_resolver registered
[    0.840070] mce: Using 32 MCE banks
[    0.840614] sched_clock: Marking stable (739805965, 100781643)->(8607122=
30, -20124622)
[    0.841974] registered taskstats version 1
[    0.842560] Loading compiled-in X.509 certificates
[    0.843835]   Magic number: 8:908:19
[    0.844533] console [netcon0] enabled
[    0.845127] netconsole: network logging started
[    0.846185] ALSA device list:
[    0.847369]   No soundcards found.
[    1.030526] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input2
[    1.446640] random: fast init done
[    1.447709] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/=
i8042/serio1/input/input4
[    1.449201] md: Waiting for all devices to be available before autodetec=
t
[    1.450219] md: If you don't use raid, use raid=3Dnoautodetect
[    1.451193] md: Autodetecting RAID arrays.
[    1.451815] md: autorun ...
[    1.452213] md: ... autorun DONE.
[    1.452772] VFS: Cannot open root device "sda1" or unknown-block(0,0): e=
rror -6
[    1.453832] Please append a correct "root=3D" boot option; here are the =
available partitions:
[    1.455077] Kernel panic - not syncing: VFS: Unable to mount root fs on =
unknown-block(0,0)
[    1.456263] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.19.204 #1
[    1.457133] Hardware name: Google Google Compute Engine/Google Compute E=
ngine, BIOS Google 08/06/2024
[    1.458370] Call Trace:
[    1.458728]  dump_stack+0x69/0x84
[    1.459192]  panic+0xe2/0x236
[    1.459616]  mount_block_root+0x189/0x226
[    1.460186]  mount_root+0x10a/0x127
[    1.460709]  prepare_namespace+0x13a/0x172
[    1.461273]  kernel_init_freeable+0x1f7/0x20c
[    1.461869]  ? rest_init+0xa0/0xa0
[    1.462352]  kernel_init+0x9/0xfc
[    1.462832]  ret_from_fork+0x35/0x40
[    1.463467] Kernel Offset: 0x2c200000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)
[    1.465034] ---[ end Kernel panic - not syncing: VFS: Unable to mount ro=
ot fs on unknown-block(0,0) ]---


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
GOVERSION=3D'go1.22.7'
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
 -ffile-prefix-map=3D/tmp/go-build3057085696=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 9d47f20a1c
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
/syzkaller/prog.GitRevision=3D9d47f20a1c5cfc0e89b8e37d0175d69be81ad9a9 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240903-155700'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"9d47f20a1c5cfc0e89b8e37d0175d69be8=
1ad9a9\"
/usr/bin/ld: /tmp/ccOaDBGX.o: in function `test_cover_filter()':
executor.cc:(.text+0x1412b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/ccOaDBGX.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D14c8549f980000


Tested on:

commit:         196145c6 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dea008021530b2de=
3
dashboard link: https://syzkaller.appspot.com/bug?extid=3D17cae3c0a5b0acdc3=
27d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16e427c79800=
00


