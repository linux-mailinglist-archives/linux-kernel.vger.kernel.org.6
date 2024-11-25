Return-Path: <linux-kernel+bounces-421114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C999D8715
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571C9B2E849
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8E118872F;
	Mon, 25 Nov 2024 13:43:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E411AC456
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542187; cv=none; b=uRaLCaQrHwEXwpOf98a4bGIRGMRBv6VY9xB1DhowyrYBAwuVuktxVLgU4WwzR9kLxqGbt0ImCXVpOIM1uKOmD7XHRY2khvlcISrrZ1O+lo/xmjgiMZERMlel3RyVPhT0Mo5ejCj+7rS4cUDYANwlLobwBcMBZjZUIu8dwAjappo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542187; c=relaxed/simple;
	bh=px0qebGkQBzyzPeOwngZyyuMUs5GfX3hsrclC/ToxOI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Rfrxi3Ka53CQRO17AWK3PWUiw+JRHWWJzCCXmAV7evmIOrmqEj99YQt339+TD7U46g4hYWkHkmIdtXEsp1xu+KgQTtMi9sbG4sPMUjbOMvUWJbnv0mxooXamgkjYbudJqXq3qoU7QaiB87b6CbfCkOafOMvaZCarE3WZ33l8938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a794990ef3so35761375ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 05:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732542184; x=1733146984;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZNer8GWLIj8J1tYWvUswoHJmORLtQFRQq6mGHoh8Q4=;
        b=Mqf8pnIeSmwqThpEpQEJ6G93nR93euY6YJqdShyx4AWsydk88Gy74QEQ+ClQPeLr3L
         na5BuoFXQw+o7HRiRzlp2GYNtQrTAOinDCEfikLiFE05kp1JzYfYtEJRLZDfiWjNzTFw
         /dTe1jfHhv883it3I3AR6TfBRqYblwWqKc4Px3hUeoEG0T3ztqPgX5T7PoRYSRg2ssc4
         SkEFKTXkbrFi6qu5O78jjQ7u6wjXBrpNwtSIs4iySM6tTALXPnSNUkLKZiKzwerfgbfB
         qAPvByY3nfYORX9lCafY/ok8j64Igyuybet//R0LQYztcdry4nIPKRqDUhPU345dquVt
         UfYg==
X-Forwarded-Encrypted: i=1; AJvYcCWoKlp0yczfr+I/4h5Sr4Z9+TsAl1zqOlJKZMhvtZZHIcvIqUfAMhJ0/eG/9ly1BvhEApTTX46Do4mlLh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/O0p9UnrTxqZw2mm1Pr1syGgKg+A4BBQPTUv4OAqC3vz/vMY1
	be1DDIcjk522kgaIF1HjzwnEFWNwVsJaUPDji1jjhgowJ16d9+ghrGmZF4UCTpCYN8+hUF+wqx4
	8AiBg5dxHYIhknkVK+sEf53tJEikw2/vBpMmfwRj1rK6IN15WgHPI7R8=
X-Google-Smtp-Source: AGHT+IEk1r3lKkkXCkBIish8GLITOxiEwJU6sy5NzRrLZ60zF4MmZILpplJtnpgdlixhhXTXf4zMEJ1k0vFzedpQDDX04bu5jsc3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2d:b0:3a7:ac9e:102f with SMTP id
 e9e14a558f8ab-3a7ac9e12cfmr56993245ab.1.1732542184240; Mon, 25 Nov 2024
 05:43:04 -0800 (PST)
Date: Mon, 25 Nov 2024 05:43:04 -0800
In-Reply-To: <CAHiZj8i+q-JFpaoiCYb1Lb7-41HjH_Z_yr7fUmZ=+LVP+=hHWg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67447ee8.050a0220.21d33d.0000.GAE@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
From: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 pci 0000:00:01.0: [8086:7110] type 00 class 0x060100 conventional PCI endp=
oint
[    3.290039][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=
 conventional PCI endpoint
[    3.312848][    T1] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed=
 by PIIX4 ACPI
[    3.318949][    T1] pci 0000:00:03.0: [1af4:1004] type 00 class 0x000000=
 conventional PCI endpoint
[    3.329795][    T1] pci 0000:00:03.0: BAR 0 [io  0xc000-0xc03f]
[    3.337001][    T1] pci 0000:00:03.0: BAR 1 [mem 0xfe800000-0xfe80007f]
[    3.361051][    T1] pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000=
 conventional PCI endpoint
[    3.373573][    T1] pci 0000:00:04.0: BAR 0 [io  0xc040-0xc07f]
[    3.382024][    T1] pci 0000:00:04.0: BAR 1 [mem 0xfe801000-0xfe80107f]
[    3.402560][    T1] pci 0000:00:05.0: [1ae0:a002] type 00 class 0x030000=
 conventional PCI endpoint
[    3.410376][    T1] pci 0000:00:05.0: BAR 0 [mem 0xfe000000-0xfe7fffff]
[    3.434234][    T1] pci 0000:00:05.0: Video device with shadowed ROM at =
[mem 0x000c0000-0x000dffff]
[    3.441110][    T1] pci 0000:00:06.0: [1af4:1002] type 00 class 0x00ff00=
 conventional PCI endpoint
[    3.450821][    T1] pci 0000:00:06.0: BAR 0 [io  0xc080-0xc09f]
[    3.473565][    T1] pci 0000:00:07.0: [1af4:1005] type 00 class 0x00ff00=
 conventional PCI endpoint
[    3.482224][    T1] pci 0000:00:07.0: BAR 0 [io  0xc0a0-0xc0bf]
[    3.488084][    T1] pci 0000:00:07.0: BAR 1 [mem 0xfe802000-0xfe80203f]
[    3.532666][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    3.540225][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    3.546704][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    3.552639][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    3.557841][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    3.574126][    T1] iommu: Default domain type: Translated
[    3.574126][    T1] iommu: DMA domain TLB invalidation policy: lazy mode
[    3.579938][    T1] SCSI subsystem initialized
[    3.588656][    T1] ACPI: bus type USB registered
[    3.590200][    T1] usbcore: registered new interface driver usbfs
[    3.591536][    T1] usbcore: registered new interface driver hub
[    3.592765][    T1] usbcore: registered new device driver usb
[    3.597008][    T1] mc: Linux media interface: v0.10
[    3.597222][    T1] videodev: Linux video capture interface: v2.00
[    3.599410][    T1] pps_core: LinuxPPS API ver. 1 registered
[    3.601032][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    3.603659][    T1] PTP clock support registered
[    3.627151][    T1] EDAC MC: Ver: 3.0.0
[    3.633364][    T1] Advanced Linux Sound Architecture Driver Initialized=
.
[    3.641413][    T1] Bluetooth: Core ver 2.22
[    3.642536][    T1] NET: Registered PF_BLUETOOTH protocol family
[    3.643486][    T1] Bluetooth: HCI device and connection manager initial=
ized
[    3.645664][    T1] Bluetooth: HCI socket layer initialized
[    3.647000][    T1] Bluetooth: L2CAP socket layer initialized
[    3.648804][    T1] Bluetooth: SCO socket layer initialized
[    3.649970][    T1] NET: Registered PF_ATMPVC protocol family
[    3.650883][    T1] NET: Registered PF_ATMSVC protocol family
[    3.652410][    T1] NetLabel: Initializing
[    3.653688][    T1] NetLabel:  domain hash size =3D 128
[    3.654598][    T1] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    3.656547][    T1] NetLabel:  unlabeled traffic allowed by default
[    3.658572][    T1] nfc: nfc_init: NFC Core ver 0.1
[    3.660263][    T1] NET: Registered PF_NFC protocol family
[    3.662155][    T1] PCI: Using ACPI for IRQ routing
[    3.664326][    T1] pci 0000:00:05.0: vgaarb: setting as boot VGA device
[    3.665828][    T1] pci 0000:00:05.0: vgaarb: bridge control possible
[    3.666971][    T1] pci 0000:00:05.0: vgaarb: VGA device added: decodes=
=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    3.667008][    T1] vgaarb: loaded
[    3.672240][    T1] clocksource: Switched to clocksource kvm-clock
[    3.688400][    T1] VFS: Disk quotas dquot_6.6.0
[    3.695631][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4=
096 bytes)
[    3.700793][    T1] netfs: FS-Cache loaded
[    3.703476][    T1] CacheFiles: Loaded
[    3.705257][    T1] TOMOYO: 2.6.0
[    3.706280][    T1] Mandatory Access Control activated.
[    3.712222][    T1] AppArmor: AppArmor Filesystem Enabled
[    3.714157][    T1] pnp: PnP ACPI init
[    3.736384][    T1] pnp: PnP ACPI: found 7 devices
[    3.842531][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xf=
fffff, max_idle_ns: 2085701024 ns
[    3.845775][    T1] NET: Registered PF_INET protocol family
[    3.852225][    T1] IP idents hash table entries: 131072 (order: 8, 1048=
576 bytes, vmalloc)
[    3.865960][    T1] tcp_listen_portaddr_hash hash table entries: 4096 (o=
rder: 6, 294912 bytes, vmalloc)
[    3.869201][    T1] Table-perturb hash table entries: 65536 (order: 6, 2=
62144 bytes, vmalloc)
[    3.873508][    T1] TCP established hash table entries: 65536 (order: 7,=
 524288 bytes, vmalloc)
[    3.886899][    T1] TCP bind hash table entries: 65536 (order: 11, 94371=
84 bytes, vmalloc hugepage)
[    3.899560][    T1] TCP: Hash tables configured (established 65536 bind =
65536)
[    3.905432][    T1] MPTCP token hash table entries: 8192 (order: 7, 7208=
96 bytes, vmalloc)
[    3.913210][    T1] UDP hash table entries: 4096 (order: 8, 1048576 byte=
s, vmalloc)
[    3.919893][    T1] UDP-Lite hash table entries: 4096 (order: 8, 1048576=
 bytes, vmalloc)
[    3.924198][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    3.939126][    T1] RPC: Registered named UNIX socket transport module.
[    3.940606][    T1] RPC: Registered udp transport module.
[    3.942512][    T1] RPC: Registered tcp transport module.
[    3.943938][    T1] RPC: Registered tcp-with-tls transport module.
[    3.945413][    T1] RPC: Registered tcp NFSv4.1 backchannel transport mo=
dule.
[    3.962055][    T1] NET: Registered PF_XDP protocol family
[    3.963139][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 windo=
w]
[    3.964999][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff windo=
w]
[    3.966783][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bff=
ff window]
[    3.969251][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfef=
ff window]
[    3.972090][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    3.974068][    T1] PCI: CLS 0 bytes, default 64
[    3.982313][   T52] BUG: unable to handle page fault for address: ffffff=
ffffffffea
[    3.984585][   T52] #PF: supervisor read access in kernel mode
[    3.986189][   T52] #PF: error_code(0x0000) - not-present page
[    3.987390][   T52] PGD db82067 P4D db82067 PUD db84067 PMD 0=20
[    3.987390][   T52] Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
[    3.987390][   T52] CPU: 1 UID: 0 PID: 52 Comm: kworker/u8:3 Not tainted=
 6.12.0-syzkaller-09073-g9f16d5e6f220-dirty #0
[    3.987390][   T52] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[    3.987390][   T52] Workqueue: async async_run_entry_fn
[    3.987390][   T52] RIP: 0010:__folio_put+0x239/0x470
[    3.987390][   T52] Code: ff ff fb ff ff 80 fa 02 0f 9e c1 84 d2 0f 95 c=
2 84 d1 0f 85 04 02 00 00 3c 01 0f 9e c2 84 c0 0f 95 c0 84 c2 0f 85 f2 01 0=
0 00 <4c> 8b 24 25 ea ff ff ff 31 ff 49 c1 ec 09 41 83 e4 01 44 89 e6 e8
[    3.997515][    T1] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)
[    3.997439][   T52] RSP: 0000:ffffc90000bd7a38 EFLAGS: 00010246
[    4.002041][    T1] software IO TLB: mapped [mem 0x00000000b4600000-0x00=
000000b8600000] (64MB)
[    3.997439][   T52] RAX: fffffbffffffff00 RBX: ffffea00006dfc00 RCX: fff=
fffff81c85201
[    4.004393][    T1] ACPI: bus type thunderbolt registered
[    3.997439][   T52] RDX: fffffbffffffff01 RSI: 0000000000000008 RDI: fff=
fffffffffffea
[    4.007324][   T52] RBP: 1ffff9200017af47 R08: 0000000000000000 R09: fff=
ffbfffffffffe
[    4.007324][   T52] R10: fffffffffffffff1 R11: 0000000000000002 R12: 000=
0000000000002
[    4.010853][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters=
, 10737418240 ms ovfl timer
[    4.007324][   T52] R13: ffffffff91b2f320 R14: ffffffff91b2f320 R15: fff=
f8881472f14c8
[    4.007324][   T52] FS:  0000000000000000(0000) GS:ffff8880b8700000(0000=
) knlGS:0000000000000000
[    4.007324][   T52] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.007324][   T52] CR2: ffffffffffffffea CR3: 000000000db7e000 CR4: 000=
00000003506f0
[    4.007324][   T52] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    4.007324][   T52] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    4.007324][   T52] Call Trace:
[    4.007324][   T52]  <TASK>
[    4.007324][   T52]  ? __die+0x1e/0x60
[    4.007324][   T52]  ? page_fault_oops+0x3b6/0xb80
[    4.007324][   T52]  ? __pfx_page_fault_oops+0x10/0x10
[    4.007324][   T52]  ? __pfx_lock_release+0x10/0x10
[    4.007324][   T52]  ? trace_lock_acquire+0x146/0x1e0
[    4.007324][   T52]  ? is_prefetch.constprop.0+0x9d/0x520
[    4.007324][   T52]  ? lock_acquire+0x2f/0xb0
[    4.007324][   T52]  ? search_bpf_extables+0x36/0x320
[    4.007324][   T52]  ? bpf_ksym_find+0x124/0x1c0
[    4.007324][   T52]  ? __pfx_is_prefetch.constprop.0+0x10/0x10
[    4.007324][   T52]  ? fixup_exception+0x10c/0xaf0
[    4.007324][   T52]  ? kernelmode_fixup_or_oops.constprop.0+0xb8/0xe0
[    4.007324][   T52]  ? __bad_area_nosemaphore+0x390/0x6a0
[    4.007324][   T52]  ? spurious_kernel_fault+0x234/0x3a0
[    4.007324][   T52]  ? hlock_class+0x4e/0x130
[    4.007324][   T52]  ? do_kern_addr_fault+0x5b/0x80
[    4.007324][   T52]  ? exc_page_fault+0xb1/0xc0
[    4.007324][   T52]  ? asm_exc_page_fault+0x26/0x30
[    4.007324][   T52]  ? __folio_put+0x1f1/0x470
[    4.007324][   T52]  ? __folio_put+0x239/0x470
[    4.007324][   T52]  ? __folio_put+0x1ff/0x470
[    4.007324][   T52]  ? __pfx___folio_put+0x10/0x10
[    4.007324][   T52]  ? free_large_kmalloc+0xaa/0x140
[    4.007324][   T52]  ? lockdep_hardirqs_on+0x7c/0x110
[    4.007324][   T52]  unpack_to_rootfs+0x4c6/0x820
[    4.007324][   T52]  ? __pfx_mark_lock+0x10/0x10
[    4.007324][   T52]  ? __pfx_unpack_to_rootfs+0x10/0x10
[    4.007324][   T52]  ? find_held_lock+0x2d/0x110
[    4.007324][   T52]  ? async_run_entry_fn+0x35/0x530
[    4.007324][   T52]  ? __pfx_do_populate_rootfs+0x10/0x10
[    4.007324][   T52]  ? do_populate_rootfs+0x8e/0x770
[    4.007324][   T52]  do_populate_rootfs+0x8e/0x770
[    4.007324][   T52]  ? __pfx_do_populate_rootfs+0x10/0x10
[    4.007324][   T52]  ? kvm_clock_get_cycles+0x40/0x70
[    4.007324][   T52]  ? ktime_get+0x1ac/0x300
[    4.007324][   T52]  ? __pfx_do_populate_rootfs+0x10/0x10
[    4.007324][   T52]  async_run_entry_fn+0x9c/0x530
[    4.007324][   T52]  process_one_work+0x958/0x1b30
[    4.007324][   T52]  ? __pfx_lock_acquire.part.0+0x10/0x10
[    4.007324][   T52]  ? __pfx_process_one_work+0x10/0x10
[    4.007324][   T52]  ? rcu_is_watching+0x12/0xc0
[    4.007324][   T52]  ? assign_work+0x1a0/0x250
[    4.007324][   T52]  worker_thread+0x6c8/0xf00
[    4.007324][   T52]  ? __kthread_parkme+0x148/0x220
[    4.007324][   T52]  ? __pfx_worker_thread+0x10/0x10
[    4.007324][   T52]  kthread+0x2c1/0x3a0
[    4.007324][   T52]  ? _raw_spin_unlock_irq+0x23/0x50
[    4.007324][   T52]  ? __pfx_kthread+0x10/0x10
[    4.007324][   T52]  ret_from_fork+0x45/0x80
[    4.007324][   T52]  ? __pfx_kthread+0x10/0x10
[    4.007324][   T52]  ret_from_fork_asm+0x1a/0x30
[    4.007324][   T52]  </TASK>
[    4.007324][   T52] Modules linked in:
[    4.007324][   T52] CR2: ffffffffffffffea
[    4.007324][   T52] ---[ end trace 0000000000000000 ]---
[    4.007324][   T52] RIP: 0010:__folio_put+0x239/0x470
[    4.007324][   T52] Code: ff ff fb ff ff 80 fa 02 0f 9e c1 84 d2 0f 95 c=
2 84 d1 0f 85 04 02 00 00 3c 01 0f 9e c2 84 c0 0f 95 c0 84 c2 0f 85 f2 01 0=
0 00 <4c> 8b 24 25 ea ff ff ff 31 ff 49 c1 ec 09 41 83 e4 01 44 89 e6 e8
[    4.007324][   T52] RSP: 0000:ffffc90000bd7a38 EFLAGS: 00010246
[    4.007324][   T52] RAX: fffffbffffffff00 RBX: ffffea00006dfc00 RCX: fff=
fffff81c85201
[    4.007324][   T52] RDX: fffffbffffffff01 RSI: 0000000000000008 RDI: fff=
fffffffffffea
[    4.007324][   T52] RBP: 1ffff9200017af47 R08: 0000000000000000 R09: fff=
ffbfffffffffe
[    4.007324][   T52] R10: fffffffffffffff1 R11: 0000000000000002 R12: 000=
0000000000002
[    4.007324][   T52] R13: ffffffff91b2f320 R14: ffffffff91b2f320 R15: fff=
f8881472f14c8
[    4.007324][   T52] FS:  0000000000000000(0000) GS:ffff8880b8700000(0000=
) knlGS:0000000000000000
[    4.007324][   T52] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.007324][   T52] CR2: ffffffffffffffea CR3: 000000000db7e000 CR4: 000=
00000003506f0
[    4.007324][   T52] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    4.007324][   T52] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    4.007324][   T52] Kernel panic - not syncing: Fatal exception
[    4.007324][   T52] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2089203793=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 571351cb80
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
/syzkaller/prog.GitRevision=3D571351cb80e526bf973c8f11c46fa7f3bbc2da1e -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20241118-105802'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"571351cb80e526bf973c8f11c46fa7f3bb=
c2da1e\"
/usr/bin/ld: /tmp/cctrbPCi.o: in function `test_cover_filter()':
executor.cc:(.text+0x1426b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/cctrbPCi.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D16fadee8580000


Tested on:

commit:         9f16d5e6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D47cc5fc1922531f
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9f9a7f73fb079b238=
7a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D126665305800=
00


