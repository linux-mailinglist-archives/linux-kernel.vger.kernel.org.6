Return-Path: <linux-kernel+bounces-217726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE0590B370
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CBA1F2211A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F44C14F129;
	Mon, 17 Jun 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="IDmxik7T"
Received: from qs51p00im-qukt01080302.me.com (qs51p00im-qukt01080302.me.com [17.57.155.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F094114EC78
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634139; cv=none; b=SXgpk1ZMaOboYCx2DEvoCPKJlpcjBBH5EnbDMHFminYZukqRVLO7Zk2WF2IIeXEKs/oi7DyDGeqmucjjx2E2+EBEE9Gck4NwB9NTpvcz2OanicWqg5hDdDySqv5b+uE4kDzowsul5vyXaxpEh0u2HzzJtxtTd/xlDRcP38ExWxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634139; c=relaxed/simple;
	bh=Ra5/3C+HDYcPKIJ2ltmzN9uKdC5/OaK189DSmXeqlOg=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=Bof2LMxw6jCxLnHuMMRaI5H3qwlZNBCNfo32YDWD/oVievysCRDXq7MeM+B8wascDIEq1neNabvEAX/2ktT8Yy6NE1yrQjDHfBC8nDo2uGCdfQXn5SvtCIGrGWvI9cHTA+toq+EJsG7ApiKMJrdKYRN+rccYWplj6lr65OfS128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=IDmxik7T; arc=none smtp.client-ip=17.57.155.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
	t=1718634135; bh=EwljAHZFVFVFUrqhRvfyAHEkQWUZrcxcc9RIUg/HG2Q=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
	b=IDmxik7TbWYbFgqtaICr+uW1WtHJ0W+w+8I1LKfp7BOCAnHMmpUrSt+aM5xV6XbUs
	 MKqu05ofCiEbVb8RfdErf2ZCvLKTWOOekG0aw2ETjb8vpQ4Ru5SaoLPHF+3+X8/DgL
	 J2qtqELl8oqi0v9v1uyXdLHCC/Qk/SkS0aoIi0pouRWiHMzHuYZuxRTYWVa83kqdYa
	 UUid+Xq+AaGy8QL4Kwx2aR5lqT5ShSnrVIiA8xBQw4oHXRwJ73vPqmI6tqwMLjd91v
	 J+q9rbuOFTx6ufXYTPpQ2Z6mMQlamT2ZZRHYSTxdPiqwCKDn55c3QXsRPL1GLKcw++
	 BBvNC7HzMmxRg==
Received: from [172.20.144.3] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080302.me.com (Postfix) with ESMTPSA id F2C7C114040C;
	Mon, 17 Jun 2024 14:22:12 +0000 (UTC)
From: Gagan Sidhu <broly@mac.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
Message-Id: <418F591B-BA4C-4203-8144-40177E6706F0@mac.com>
Date: Mon, 17 Jun 2024 08:21:54 -0600
Cc: linux-mtd@lists.infradead.org
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-GUID: s4bH_R5wyPW5-N0pfJK2ZzD9SUve2z0e
X-Proofpoint-ORIG-GUID: s4bH_R5wyPW5-N0pfJK2ZzD9SUve2z0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_12,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2406170112

hi,

this patch isn=E2=80=99t a good one.

it must be reverted.

the problem with mr wang's changes is that it breaks expected mounting =
behaviour of a filesystem within an UBI, as is the case for openwrt.

i am surprised no one has raised the issue about this. i see mr raynal =
did raise an issue with one of mr zhihao=E2=80=99s fundamental errors:

https://lore.kernel.org/lkml/20231027194026.1bc32dfe@xps-13/

> Therefore, this problem can be avoided by preventing gluebi
> from creating mtdblock devices.

this is absolutely wrong.

typically what happens is we will wrap a squashfs filesystem inside a =
UBI layer. openwrt people call this =E2=80=9Cubinising=E2=80=9D the root =
filesystem.

then, after we label the appropriate nand partitions as =E2=80=98uimage,fw=
=E2=80=99 to call the right mtdsplit, the mtd_ubi subsystem works its =
magic automatically, as long as the root partition is named =
=E2=80=9Crootfs=E2=80=9D.

at that point, the rootfs will be *AUTOMATICALLY* mounted AND booted =
from BY THE KERNEL. that is, no cmdline hacks are required.

this patch breaks that behaviour since mr wang=E2=80=99s additional =
conditions result in the failure of the partition to get added to the =
mtd list, and thus fails mount.

i have attached a log of this behaviour. and by removing mr wang=E2=80=99s=
 =E2=80=9Cfixes=E2=80=9D, it mounts as we would expect.

this change must be reverted. extremely surprised the openwrt team has =
not raised issues over this by now.

```


3: System Boot system code via Flash.
## Booting image at bc180000 ...
   Image Name:   DD-WRT v24 Linux Kernel Imag
   Image Type:   MIPS Linux Kernel Image (lzma compressed)
   Data Size:    3875031 Bytes =3D  3.7 MB
   Load Address: 80001000
   Entry Point:  807d9e20
............................................................   Verifying =
Checksum ... OK
   Uncompressing Kernel Image ... OK
No initrd
## Transferring control to Linux (at address 807d9e20) ...
## Giving linux memsize in MB, 256

Starting kernel ...

[    0.000000] Linux version 4.14.348-openela-rt159 (
Gagan@GagansMacPro.local
) (gcc version 14.1.0 (GCC)) #5426 SMP Sat Jun 15 07:23:17 MDT 2024
[    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 0001992f (MIPS 1004Kc)
[    0.000000] MIPS: machine is D-Link DIR-2640 rev. A1
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 10000000 @ 00000000 (usable)
[    0.000000] VPE topology {2,2} total 4
[    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 =
bytes.
[    0.000000] Primary data cache 32kB, 4-way, PIPT, no aliases, =
linesize 32 bytes
[    0.000000] MIPS secondary cache 256kB, 8-way, linesize 32 bytes.
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x000000000fffffff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000] Initmem setup node 0 [mem =
0x0000000000000000-0x000000000fffffff]
[    0.000000] percpu: Embedded 15 pages/cpu s30672 r8192 d22576 u61440
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: =
65024
[    0.000000] Kernel command line: console=3DttyS0,57600n8
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 12288 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] log_buf_len: 32768 bytes
[    0.000000] early log buf free: 14216(86%)
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 =
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 =
bytes)
[    0.000000] Writing ErrCtl register=3D000412fa
[    0.000000] Readback ErrCtl register=3D000412fa
[    0.000000] Memory: 247980K/262144K available (8061K kernel code, =
892K rwdata, 1568K rodata, 280K init, 733K bss, 14164K reserved, 0K =
cma-reserved, 0K highmem)
[    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D4, =
Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS: 256
[    0.000000] CPU Clock: 880MHz
[    0.000000] clocksource: GIC: mask: 0xffffffffffffffff max_cycles: =
0xcaf478abb4, max_idle_ns: 440795247997 ns
[    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 4343773742 ns
[    0.000009] sched_clock: 32 bits at 440MHz, resolution 2ns, wraps =
every 4880645118ns
[    0.015565] Calibrating delay loop... 583.68 BogoMIPS (lpj=3D1167360)
[    0.055919] pid_max: default: 4096 minimum: 301
[    0.065064] Mount-cache hash table entries: 1024 (order: 0, 4096 =
bytes)
[    0.078089] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 =
bytes)
[    0.093805] Hierarchical SRCU implementation.
[    0.103082] smp: Bringing up secondary CPUs ...
[    0.113986] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 =
bytes.
[    0.113994] Primary data cache 32kB, 4-way, PIPT, no aliases, =
linesize 32 bytes
[    0.114004] MIPS secondary cache 256kB, 8-way, linesize 32 bytes.
[    0.114122] CPU1 revision is: 0001992f (MIPS 1004Kc)
[    0.140246] Synchronize counters for CPU 1: done.
[    0.205804] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 =
bytes.
[    0.205812] Primary data cache 32kB, 4-way, PIPT, no aliases, =
linesize 32 bytes
[    0.205818] MIPS secondary cache 256kB, 8-way, linesize 32 bytes.
[    0.205878] CPU2 revision is: 0001992f (MIPS 1004Kc)
[    0.239402] Synchronize counters for CPU 2: done.
[    0.300999] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 =
bytes.
[    0.301006] Primary data cache 32kB, 4-way, PIPT, no aliases, =
linesize 32 bytes
[    0.301013] MIPS secondary cache 256kB, 8-way, linesize 32 bytes.
[    0.301082] CPU3 revision is: 0001992f (MIPS 1004Kc)
[    0.327024] Synchronize counters for CPU 3: done.
[    0.386624] smp: Brought up 1 node, 4 CPUs
[    0.395319] devtmpfs: initialized
[    0.405072] clocksource: jiffies: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.424361] futex hash table entries: 16 (order: -3, 512 bytes)
[    0.436154] pinctrl core: initialized pinctrl subsystem
[    0.447323] NET: Registered protocol family 16
[    0.456700] cpuidle: using governor menu
[    0.484220] pull PCIe RST: RALINK_RSTCTRL =3D 4000000
[    0.794105] release PCIe RST: RALINK_RSTCTRL =3D 7000000
[    0.804176] ***** Xtal 40MHz *****
[    0.810918] release PCIe RST: RALINK_RSTCTRL =3D 7000000
[    0.821113] Port 0 N_FTS =3D 1b105000
[    0.828025] Port 1 N_FTS =3D 1b105000
[    0.834937] Port 2 N_FTS =3D 1b102800
[    1.992951] PCIE2 no card, disable it(RST&CLK)
[    2.001641]  -> 21007f2
[    2.006479] PCIE0 enabled
[    2.011663] PCIE1 enabled
[    2.016858] PCI host bridge /pcie@1e140000 ranges:
[    2.026367]  MEM 0x0000000060000000..0x000000006fffffff
[    2.036726]   IO 0x000000001e160000..0x000000001e16ffff
[    2.047093] PCI coherence region base: 0x60000000, mask/settings: =
0xf0000002
[    2.066762] mt7621_gpio 1e000600.gpio: registering 32 gpios
[    2.078058] mt7621_gpio 1e000600.gpio: registering 32 gpios
[    2.089214] mt7621_gpio 1e000600.gpio: registering 32 gpios
[    2.100683] vgaarb: loaded
[    2.106249] SCSI subsystem initialized
[    2.113766] usbcore: registered new interface driver usbfs
[    2.124606] usbcore: registered new interface driver hub
[    2.135129] usbcore: registered new device driver usb
[    2.145477] i2c-mt7621 1e000900.i2c: clock 100KHz, re-start not =
support
[    2.158813] PCI host bridge to bus 0000:00
[    2.166839] pci_bus 0000:00: root bus resource [mem =
0x60000000-0x6fffffff]
[    2.180477] pci_bus 0000:00: root bus resource [io  =
0x1e160000-0x1e16ffff]
[    2.194129] pci_bus 0000:00: root bus resource [??? 0x00000000 flags =
0x0]
[    2.207606] pci_bus 0000:00: No busn resource found for root bus, =
will use [bus 00-ff]
[    2.224155] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, =
limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 4.000 Gb/s with =
5 GT/s x1 link)
[    2.251939] pci 0000:02:00.0: 2.000 Gb/s available PCIe bandwidth, =
limited by 2.5 GT/s x1 link at 0000:00:01.0 (capable of 4.000 Gb/s with =
5 GT/s x1 link)
[    2.279470] pci 0000:00:00.0: BAR 0: no space for [mem size =
0x80000000]
[    2.292494] pci 0000:00:00.0: BAR 0: failed to assign [mem size =
0x80000000]
[    2.306313] pci 0000:00:01.0: BAR 0: no space for [mem size =
0x80000000]
[    2.319449] pci 0000:00:01.0: BAR 0: failed to assign [mem size =
0x80000000]
[    2.333277] pci 0000:00:00.0: BAR 8: assigned [mem =
0x60000000-0x600fffff]
[    2.346755] pci 0000:00:01.0: BAR 8: assigned [mem =
0x60100000-0x601fffff]
[    2.360233] pci 0000:00:00.0: BAR 1: assigned [mem =
0x60200000-0x6020ffff]
[    2.373709] pci 0000:00:01.0: BAR 1: assigned [mem =
0x60210000-0x6021ffff]
[    2.387208] pci 0000:01:00.0: BAR 0: assigned [mem =
0x60000000-0x600fffff 64bit]
[    2.401712] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.411548] pci 0000:00:00.0:   bridge window [mem =
0x60000000-0x600fffff]
[    2.425039] pci 0000:02:00.0: BAR 0: assigned [mem =
0x60100000-0x601fffff 64bit]
[    2.439555] pci 0000:00:01.0: PCI bridge to [bus 02]
[    2.449396] pci 0000:00:01.0:   bridge window [mem =
0x60100000-0x601fffff]
[    2.463554] clocksource: Switched to clocksource GIC
[    2.474753] NET: Registered protocol family 2
[    2.483561] IP idents hash table entries: 4096 (order: 3, 32768 =
bytes)
[    2.497245] TCP established hash table entries: 2048 (order: 1, 8192 =
bytes)
[    2.511002] TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
[    2.523798] TCP: Hash tables configured (established 2048 bind 2048)
[    2.536493] UDP hash table entries: 128 (order: 0, 4096 bytes)
[    2.547983] UDP-Lite hash table entries: 128 (order: 0, 4096 bytes)
[    2.560657] NET: Registered protocol family 1
[    2.659518] 4 CPUs re-calibrate udelay(lpj =3D 1163264)
[    2.670337] workingset: timestamp_bits=3D30 max_order=3D16 =
bucket_order=3D0
[    2.689246] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.709543] io scheduler noop registered
[    2.717554] io scheduler cfq registered (default)
[    2.726769] io scheduler mq-deadline registered
[    2.735774] io scheduler kyber registered
[    2.744477] mtk_hsdma 1e007000.hsdma: Using 3 as missing dma-requests =
property
[    2.758985] mtk_hsdma 1e007000.hsdma: MediaTek HSDMA driver =
registered
[    2.823896] serial8250_init
[    2.829315] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    2.843297] console [ttyS0] disabled
[    2.850333] 1e000c00.uartlite: ttyS0 at MMIO 0x1e000c00 (irq =3D 19, =
base_baud =3D 3125000) is a 16550A
[    2.868297] console [ttyS0] enabled
[    2.868297] console [ttyS0] enabled
[    2.882070] bootconsole [early0] disabled
[    2.882070] bootconsole [early0] disabled
[    2.898446] Ralink gpio driver initialized:power_gpio[8]
[    2.910106] MediaTek Nand driver init, version v2.1 Fix AHB virt2phys =
error
[    2.924094] Enable NFI Clock
[    2.929829] # MTK NAND # : Use HW ECC
[    2.937139] Device not found, ID: c8d1
[    2.944610] Not Support this Device!
[    2.952075] chip_mode=3D00000001
[    2.958157] Support this Device in MTK table! c8d1
[    2.968055] [NAND]select ecc bit:4, sparesize :64 spare_per_sector=3D16=

[    2.980930] nand: device found, Manufacturer ID: 0xc8, Chip ID: 0xd1
[    2.993590] nand: ESMT NAND 128MiB 3,3V 8-bit
[    3.002281] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, =
OOB size: 64
[    3.017376] Scanning device for bad blocks
[    3.169277] MT7621-NAND: parsing partitions cmdlinepart
[    3.180264] MT7621-NAND: got parser (null)
[    3.188484] 9 fixed-partitions partitions found on MTD device =
MT7621-NAND
[    3.202005] Creating 9 MTD partitions on "MT7621-NAND":
[    3.212430] 0x000000000000-0x000000080000 : "Bootloader"
[    3.224024] 0x0000000c0000-0x000000100000 : "Config"
[    3.234684] 0x000000100000-0x000000140000 : "Factory"
[    3.245518] 0x000000140000-0x000000180000 : "Config2"
[    3.256379] 0x000000180000-0x000002d80000 : "sysv"
[    3.895176] 1 squashfs-split partitions found on MTD device sysv
[    3.907164] 0x0000005c1000-0x000002d60000 : "ddwrt"
[    3.920925] 2 uimage-fw partitions found on MTD device sysv
[    3.932031] Creating 2 MTD partitions on "sysv":
[    3.941232] 0x000000000000-0x000000400000 : "kernel"
[    3.951995] 0x000000400000-0x000002c00000 : "ubi"
[    3.962325] 0x000002d80000-0x000004d80000 : "private"
[    3.973322] 0x000004d80000-0x000007580000 : "firmware2"
[    3.984759] 0x000007580000-0x000007b80000 : "mydlink"
[    3.995699] 0x000007b80000-0x000008000000 : "reserved"
[    4.006687] [mtk_nand] probe successfully!
[    4.015584] Signature matched and data read!
[    4.024090] load_fact_bbt success 1023
[    4.031931] tun: Universal TUN/TAP device driver, 1.6
[    4.042377] CHIP_ID =3D MT7621
[    4.048133] WAN at P4
[    4.052659] GMAC1 support rgmii
[    4.058911] GE1_RGMII_FORCE_1000
[    4.065348] GMAC2 support rgmii
[    4.071606] RGMII_AN (Internal GigaPhy)
[    4.079973] STD_v0.1  1024 rx/2048 tx descriptors allocated, mtu =3D =
1500!
[    4.094358] set CLK_CFG_0 =3D 0x40a00020!!!!!!!!!!!!!!!!!!1
[    4.105108] trgmii_set_7621 Completed!!
[    4.324297] MT7530 Reset Completed!!
[    4.340754] trgmii_set_7530 Completed!!
[    4.348739] change HW-TRAP to 0x17c8f
[    4.360357] set LAN/WAN LLLLW
[    4.374100] eth3: =3D=3D=3D> virtualif_open
[    4.381646] =3D=3D MT7530 MCM =3D=3D
[    4.387482] PPP generic driver version 2.4.2
[    4.396233] PPP BSD Compression module registered
[    4.405603] PPP Deflate Compression module registered
[    4.415687] PPP MPPE Compression module registered
[    4.425229] NET: Registered protocol family 24
[    4.434106] register mt_drv
[    4.439738] bus=3D0x1, slot =3D 0x0, irq=3D0x0
[    4.472239]
[    4.472239] =3D=3D pAd =3D c0181000, size =3D 6632704, Status=3D0 =3D=3D=

[    4.486132] pAd->PciHif.CSRBaseAddress =3D0xc0080000, =
csr_addr=3D0xc0080000!
[    4.499531] RTMPInitPCIeDevice():device_id=3D0x7615
[    4.508911] mt_pci_chip_cfg(): HWVer=3D0x8a10, FWVer=3D0x8a10, =
pAd->ChipID=3D0x7615
[    4.523136] mt_pci_chip_cfg(): HIF_SYS_REV=3D0x76150001
[    4.533196] AP Driver version-5.1.0.0
[    4.540493] RtmpChipOpsHook(223): Not support for HIF_MT yet! =
MACVersion=3D0x0
[    4.554527] mt7615_init()-->
[    4.560266] Use 1st ePAeLNA default bin.
[    4.568078] Use 0st /etc/wlan/mt7615e.eeprom.bin default bin.
[    4.579550] <--mt7615_init()
[    4.589234] <-- RTMPAllocTxRxRingMemory, Status=3D0
[    4.599438] bus=3D0x2, slot =3D 0x1, irq=3D0x0
[    4.631995]
[    4.631995] =3D=3D pAd =3D c0901000, size =3D 6632704, Status=3D0 =3D=3D=

[    4.645884] pAd->PciHif.CSRBaseAddress =3D0xc0800000, =
csr_addr=3D0xc0800000!
[    4.659234] RTMPInitPCIeDevice():device_id=3D0x7615
[    4.668612] mt_pci_chip_cfg(): HWVer=3D0x8a10, FWVer=3D0x8a10, =
pAd->ChipID=3D0x7615
[    4.682820] mt_pci_chip_cfg(): HIF_SYS_REV=3D0x76150001
[    4.692879] AP Driver version-5.1.0.0
[    4.700175] RtmpChipOpsHook(223): Not support for HIF_MT yet! =
MACVersion=3D0x0
[    4.714208] mt7615_init()-->
[    4.719946] Use 2nd ePAeLNA default bin.
[    4.727767] Use 1st /etc/wlan/mt7615e.eeprom.bin default bin.
[    4.739224] <--mt7615_init()
[    4.748896] <-- RTMPAllocTxRxRingMemory, Status=3D0
[    4.759057] rdm_major =3D 255
[    4.765124] xhci-mtk 1e1c0000.xhci: xHCI Host Controller
[    4.775743] xhci-mtk 1e1c0000.xhci: new USB bus registered, assigned =
bus number 1
[    4.799681] xhci-mtk 1e1c0000.xhci: hcc params 0x01401198 hci version =
0x96 quirks 0x0000000000290010
[    4.817950] xhci-mtk 1e1c0000.xhci: irq 22, io mem 0x1e1c0000
[    4.830260] hub 1-0:1.0: USB hub found
[    4.837822] hub 1-0:1.0: 2 ports detected
[    4.846283] xhci-mtk 1e1c0000.xhci: xHCI Host Controller
[    4.856910] xhci-mtk 1e1c0000.xhci: new USB bus registered, assigned =
bus number 2
[    4.871846] xhci-mtk 1e1c0000.xhci: Host supports USB 3.0  SuperSpeed
[    4.884885] usb usb2: We don't know the algorithms for LPM for this =
host, disabling LPM.
[    4.901675] hub 2-0:1.0: USB hub found
[    4.909226] hub 2-0:1.0: 1 port detected
[    4.917608] usbcore: registered new interface driver usblp
[    4.928659] usbcore: registered new interface driver usb-storage
[    4.940727] usbcore: registered new interface driver usbserial
[    5.007737] rtc-pcf8563 0-0051: registered as rtc0
[    5.031606] i2c /dev entries driver
[    5.038842] Ralink APSoC Hardware Watchdog Timer
[    5.049311] usbcore: registered new interface driver usbhid
[    5.060419] usbhid: USB HID core driver
[    5.068615] u32 classifier
[    5.074005]     Performance counters on
[    5.081638]     Actions configured
[    5.088434] Netfilter messages via NETLINK v0.30.
[    5.098071] nf_conntrack version 0.5.0 (4096 buckets, 16384 max)
[    5.110321] ctnetlink v0.93: registering with nfnetlink.
[    5.121402] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    5.132985] ip_tables: (C) 2000-2006 Netfilter Core Team
[    5.144546] NET: Registered protocol family 10
[    5.155889] Segment Routing with IPv6
[    5.163303] NET: Registered protocol family 17
[    5.172292] Bridge firewalling registered
[    5.180281] 8021q: 802.1Q VLAN Support v1.8
[    5.189452] registered taskstats version 1
[    5.198914] searching for nvram
[    5.279016] found nvram at 0, name:Config, contributed bytes:262144
[    5.328401] nvram empty
[    5.407013] found nvram at 1, name:Config2, contributed bytes:262144
[    5.456567] nvram empty
[    5.462504] auto-attach mtd7
[    5.462525] ubi0: default fastmap pool size: 15
[    5.477309] ubi0: default fastmap WL pool size: 7
[    5.486683] ubi0: attaching mtd7
[    5.811240] UBI: EOF marker found, PEBs from 273 will be erased
[    5.811299] ubi0: scanning is finished
[    5.874546] gluebi (pid 1): gluebi_resized: got update notification =
for unknown UBI device 0 volume 1
[    5.892927] ubi0: volume 1 ("rootfs_data") re-sized from 9 to 28 LEBs
[    5.906683] ubi0: attached mtd7 (name "ubi", size 40 MiB)
[    5.917446] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 =
bytes
[    5.931132] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size =
2048
[    5.944654] ubi0: VID header offset: 2048 (aligned 2048), data =
offset: 4096
[    5.958513] ubi0: good PEBs: 320, bad PEBs: 0, corrupted PEBs: 0
[    5.970472] ubi0: user volume: 2, internal volumes: 1, max. volumes =
count: 128
[    5.984859] ubi0: max/mean erase counter: 1/0, WL threshold: 4096, =
image sequence number: 1613475955
[    6.003045] ubi0: available PEBs: 0, total reserved PEBs: 320, PEBs =
reserved for bad PEB handling: 15
[    6.021426] rootfs: parsing partitions cmdlinepart
[    6.021444] ubi0: background thread "ubi_bgt0d" started, PID 97
[    6.043694] rootfs: got parser (null)
[    6.051426] mtd: device 12 (rootfs) set to be root filesystem
[    6.062891] rootfs_data: parsing partitions cmdlinepart
[    6.073669] rootfs_data: got parser (null)
[    6.211240] block ubiblock0_0: created from ubi0:0(rootfs)
[    6.259545] rtc-pcf8563 0-0051: hctosys: unable to read the hardware =
clock
[    6.282125] VFS: Cannot open root device "(null)" or =
unknown-block(31,12): error -6
[    6.297406] Please append a correct "root=3D" boot option; here are =
the available partitions:
[    6.314054] 1f00             512 mtdblock0
[    6.314060]  (driver?)
[    6.327077] 1f01             256 mtdblock1
[    6.327081]  (driver?)
[    6.340101] 1f02             256 mtdblock2
[    6.340105]  (driver?)
[    6.353124] 1f03             256 mtdblock3
[    6.353129]  (driver?)
[    6.366153] 1f04           45056 mtdblock4
[    6.366158]  (driver?)
[    6.379175] 1f05           40572 mtdblock5
[    6.379179]  (driver?)
[    6.392217] 1f06            4096 mtdblock6
[    6.392222]  (driver?)
[    6.405240] 1f07           40960 mtdblock7
[    6.405244]  (driver?)
[    6.418272] 1f08           32768 mtdblock8
[    6.418277]  (driver?)
[    6.431296] 1f09           40960 mtdblock9
[    6.431300]  (driver?)
[    6.444324] 1f0a            6144 mtdblock10
[    6.444328]  (driver?)
[    6.457518] 1f0b            4608 mtdblock11
[    6.457523]  (driver?)
[    6.470720] fe00           33604 ubiblock0_0
[    6.470724]  (driver?)
[    6.484090] Kernel panic - not syncing: VFS: Unable to mount root fs =
on unknown-block(31,12)
[    6.500892] Rebooting in 1 seconds..

```

bless,
g



Thanks,
Gagan


