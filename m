Return-Path: <linux-kernel+bounces-390472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF069B7A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1ABEB23805
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC3E19C56C;
	Thu, 31 Oct 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vn1Ce1FU"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9B19C553
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377008; cv=none; b=fijEkWUDtOj7cJRtCSITISfEAsUWq3R/7G8PTxcPb9yRu8nbEqcD+5oZRFohp4qWFbJASoqsQ//qiA2v+2F9+lB2N84DCnvVpaEnWz+txeBzuUpYthWYHLD9s1LNdB+n9nSmnzhxOtxu7a/NoQcq8nyAO1JwZT+J9dMct+LHX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377008; c=relaxed/simple;
	bh=+tjUsITjRwrBBGzlrtZ5bICHShzBeGVafw3DGKXrGXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=sNWRwAwzoLNSWZ9zziFMjBHUrW9ogIA07qKt55E5DS6lm+TFLWWybhlgdCKOwWql5qmhfnkotHYrlR/e/rQ/bvY4fPVJE5DQWuFtxUL0xIm2kdmQojQgRKXsnhsVVCtAfP/Bz2ilCW5mXrgSMiqYDVBYEJMSKzQEzzdH8FdyH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Vn1Ce1FU; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241031121636euoutp02c83637a14850604841307661d7e31aba~DiLXBrfc03092730927euoutp02g
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:16:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241031121636euoutp02c83637a14850604841307661d7e31aba~DiLXBrfc03092730927euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730376996;
	bh=iUJjCDTLshP5pVLtqMzOERGVn81mbUsaTvGw4ICQGpQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Vn1Ce1FUyiL09mHEsthEvm5FN7mYNFbEKhPKcw/yuzL6FxiKSmZXXHu7fxeOio0/Z
	 3wCgvhMw7bOfyDv81aaBGjIkDDoQuEUkdPxMUBiVq7E+1WGO5xujApXg7tvn3dfJ25
	 KUI164r9TIZKlW0AFXwUKiYun3E0XTERHaeIvSaM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241031121635eucas1p2e27860bfd5edd39e67999e6b0710317d~DiLW7c_NA1246112461eucas1p2n;
	Thu, 31 Oct 2024 12:16:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 7A.9C.20397.32573276; Thu, 31
	Oct 2024 12:16:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241031121635eucas1p19f01e659d411ceac3b934641bdb457b0~DiLWnzCOB1258212582eucas1p1d;
	Thu, 31 Oct 2024 12:16:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241031121635eusmtrp2665f57c835f80a7d3b08bb54c71103e3~DiLWnO2IN1205412054eusmtrp2S;
	Thu, 31 Oct 2024 12:16:35 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-0a-67237523c8ac
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F0.92.19920.32573276; Thu, 31
	Oct 2024 12:16:35 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241031121634eusmtip12710baa60b062916a06602e475ee23e3~DiLVgAQaF0228202282eusmtip1y;
	Thu, 31 Oct 2024 12:16:34 +0000 (GMT)
Message-ID: <82382d49-cbd1-4a03-9402-bc7d41bca9b9@samsung.com>
Date: Thu, 31 Oct 2024 13:16:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] clockevents: Shutdown and unregister current
 clockevents at CPUHP_AP_TICK_DYING
To: Frederic Weisbecker <frederic@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner
	<tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20241029125451.54574-3-frederic@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87rKpcrpBk0/TC3eXVjOZjHvs6zF
	gqa9rBaXd81hs9i8aSqzA6vHplWdbB53ru1h83h37hy7x+dNcgEsUVw2Kak5mWWpRfp2CVwZ
	Z7rnMRXsqK+Y9u4nUwPj5cwuRk4OCQETiea+u8xdjFwcQgIrGCVWzPvPCOF8YZToan8C5Xxm
	lDh/fwcLTMvyNZ/ZIRLLGSVm/vgG1f+RUeL3x1mMIFW8AnYSp15/BbNZBFQluvp3sELEBSVO
	znwCNklUQF7i/q0Z7CC2sECOxOqGZ2D1IgIhEhuajrCCDGUWaGWUODGnlQkkwSwgLnHryXww
	m03AUKLrbRcbiM0pYCnx+MUTZogaeYnmrbPBLpIQOMEhsXvTNUaIu10k5s+ewgxhC0u8Or6F
	HcKWkfi/E2QoSEM7o8SC3/ehnAmMEg3Pb0F1W0vcOfcLaB0H0ApNifW79CHCjhL3N5wGC0sI
	8EnceCsIcQSfxKRt05khwrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkMJlFpI3ZyF5ZxbC3gWM
	LKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECE83pf8e/7mBc8eqj3iFGJg7GQ4wSHMxK
	IrwfCpTThXhTEiurUovy44tKc1KLDzFKc7AoifOqpsinCgmkJ5akZqemFqQWwWSZODilGphK
	/h7j3in/N05j+iS/bRLBx/+LB/A/2P3W3t6xUumTmsDPrVZrPdlV3imcvfGCaV2Dvfme+PsW
	m38smxThckLYp/2YtprS0tr4aV+i69evfsi9UaRRxC2y/I/3ch3O4KffJNuXr7dnO1kdt2oi
	N5vEkxzDWYum8h67crp88u1wHbn04snHmzq55s1R8q07tsPaan5M08PuBaLbfoUFalvVHqqu
	PLc5pc3KhzuyxKEqxvT/x5Ven+bq//ZXr7k9Y7rZ0gmn+KO52F7b+yw6sKwxUYIn5YjonvrS
	f9sdrvN4s0jKeOc7rTbdOcNz3vbT82PWLD/lkRy+YnpF7YaFq3917nCM7nD1WjwjfP/8YCUl
	luKMREMt5qLiRAAfE+CWowMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xu7rKpcrpBhM/KFq8u7CczWLeZ1mL
	BU17WS0u75rDZrF501RmB1aPTas62TzuXNvD5vHu3Dl2j8+b5AJYovRsivJLS1IVMvKLS2yV
	og0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyznTPYyrYUV8x7d1PpgbGy5ld
	jJwcEgImEsvXfGYHsYUEljJKfJ9RDBGXkTg5rYEVwhaW+HOti62LkQuo5j2jxL/PC8AaeAXs
	JE69/soIYrMIqEp09e9ghYgLSpyc+YQFxBYVkJe4f2sGWL2wQI7E6oZnYPUiAiESL7c8ZAIZ
	yizQzigx9cJsoCIOoA3pEuePuYLUMAuIS9x6Mp8JxGYTMJToegtyBCcHp4ClxOMXT5ghaswk
	urZ2MULY8hLNW2czT2AUmoXkjFlIRs1C0jILScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5
	uZsYgTG17djPzTsY5736qHeIkYmD8RCjBAezkgjvhwLldCHelMTKqtSi/Pii0pzU4kOMpsCw
	mMgsJZqcD4zqvJJ4QzMDU0MTM0sDU0szYyVxXrfL59OAnkwsSc1OTS1ILYLpY+LglGpgsriY
	6vngufi3VdMrdAOz9VPbFV135558wqfDI89tekvuRx7/nANfmASkBeWX/9ZQcHGK/Niz9vA2
	iVpljkcrCvkdZs9eGOZg8Pm3f/oFwebrvrPm3M3O5HwW/fMBZ8BG/4SXM+sep2+caNB17naV
	3AXNU2/upGnMe3NfPz6zxJnJN7V8/WeFSBb2F+fyozZO2RfloaEjo3s/d1qYe2PNlKP5jXci
	6kqXC5ilrZ29pXpf2cKCesXqu6nzTjzj+eV5+eSPtV82Cyi88HfXPrmma8Kq3xMrpj1PXBhS
	H2T1ZlHp18iqC8KNlZbB1wv8nyx26PALcsoWXL/3WPxz1tf/lwWdSpq2nllAI/HUIX0pJZbi
	jERDLeai4kQAu2bOtjIDAAA=
X-CMS-MailID: 20241031121635eucas1p19f01e659d411ceac3b934641bdb457b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241031121635eucas1p19f01e659d411ceac3b934641bdb457b0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241031121635eucas1p19f01e659d411ceac3b934641bdb457b0
References: <20241029125451.54574-1-frederic@kernel.org>
	<20241029125451.54574-3-frederic@kernel.org>
	<CGME20241031121635eucas1p19f01e659d411ceac3b934641bdb457b0@eucas1p1.samsung.com>

On 29.10.2024 13:54, Frederic Weisbecker wrote:
> The way the clockevent devices are finally stopped while a CPU is
> offlining is currently chaotic. The layout being by order:
>
> 1) tick_sched_timer_dying() stops the tick and the underlying clockevent
>    but only for oneshot case. The periodic tick and its related
>    clockevent still runs.
>
> 2) tick_broadcast_offline() detaches and stops the per-cpu oneshot
>    broadcast and append it to the released list.
>
> 3) Some individual clockevent drivers stop the clockevents (a second time if
>    the tick is oneshot)
>
> 4) Once the CPU is dead, a control CPU remotely detaches and stops
>    (a 3rd time if oneshot mode) the CPU clockevent and adds it to the
>    released list.
>
> 5) The released list containing the broadcast device released on step 2)
>     and the remotely detached clockevent from step 4) are unregistered.
>
> These random events can be factorized if the current clockevent is
> detached and stopped by the dying CPU at the generic layer, that is
> from the dying CPU:
>
> a) Stop the tick
> b) Stop/detach the underlying per-cpu oneshot broadcast clockevent
> c) Stop/detach the underlying clockevent
> d) Release / unregister the clockevents from b) and c)
> e) Release / unregister the remaining clockevents from the dying CPU.
>     This part could be performed by the dying CPU
>
> This way the drivers and the tick layer don't need to care about
> clockevent operations during cpuhotplug down. This also unifies the tick
> behaviour on offline CPUs between oneshot and periodic modes, avoiding
> offline ticks altogether for sanity.
>
> Adopt the simplification and verify no further clockevent can be
> registered for the dying CPU after the final release.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

This patch landed in today's linux-next as commit c80e6e9de6ae 
("clockevents: Shutdown and unregister current clockevents at 
CPUHP_AP_TICK_DYING"). Unfortunately it breaks booting most of my test 
systems (ARM 32bit, ARM 64bit and RISC-V 64bit). Reverting $subject on 
top of linux-next (and fixing the merge conflict) seems to be restoring 
proper boot sequence. Here is a log observed on QEMU's ARM64 'virt' machine:

--->8---

smp: Bringing up secondary CPUs ...
Detected PIPT I-cache on CPU1
------------[ cut here ]------------
WARNING: CPU: 1 PID: 0 at kernel/time/clockevents.c:455 
clockevents_register_device+0x170/0x180
Modules linked in:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.12.0-rc1+ #9324
Hardware name: linux,dummy-virt (DT)
pstate: 200003c5 (nzCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : clockevents_register_device+0x170/0x180
lr : clockevents_config_and_register+0x2c/0x3c
...
Call trace:
  clockevents_register_device+0x170/0x180
  clockevents_config_and_register+0x2c/0x3c
  arch_timer_starting_cpu+0x170/0x294
  cpuhp_invoke_callback+0x16c/0x2b0
  __cpuhp_invoke_callback_range+0x90/0x118
  notify_cpu_starting+0x80/0xac
  secondary_start_kernel+0xe0/0x15c
  __secondary_switched+0xb8/0xbc
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffff800080050f2c>] 
copy_process+0x67c/0x198c
softirqs last  enabled at (0): [<ffff800080050f2c>] 
copy_process+0x67c/0x198c
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
CPU1: Booted secondary processor 0x0000000001 [0x411fd070]
smp: Brought up 1 node, 2 CPUs
SMP: Total of 2 processors activated.
CPU: All CPU(s) started at EL1
CPU features: detected: 32-bit EL0 Support
CPU features: detected: CRC32 instructions
alternatives: applying system-wide alternatives
Memory: 855068K/1048576K available (19008K kernel code, 6526K rwdata, 
15852K rodata, 13824K init, 11422K bss, 90156K reserved, 98304K 
cma-reserved)
devtmpfs: initialized
Callback from call_rcu_tasks() invoked.
Running RCU synchronous self tests
Running RCU synchronous self tests
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 7645041785100000 ns
futex hash table entries: 512 (order: 4, 65536 bytes, linear)
16048 pages in range for non-PLT usage
507568 pages in range for PLT usage
pinctrl core: initialized pinctrl subsystem
NET: Registered PF_NETLINK/PF_ROUTE protocol family
DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(0.580:1): state=initialized audit_enabled=0 res=1
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'power_allocator'
cpuidle: using governor menu
hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
ASID allocator initialised with 65536 entries
Serial: AMBA PL011 UART driver
9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 13, base_baud = 0) is a 
PL011 rev1
printk: legacy console [ttyAMA0] enabled
HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
iommu: Default domain type: Translated
iommu: DMA domain TLB invalidation policy: strict mode
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti 
<giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
scmi_core: SCMI protocol bus registered
FPGA manager framework
Advanced Linux Sound Architecture Driver Initialized.
vgaarb: loaded
clocksource: Switched to clocksource arch_sys_counter
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
NET: Registered PF_INET protocol family
IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 512 (order: 3, 36864 bytes, 
linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 8192 (order: 4, 65536 bytes, linear)
TCP bind hash table entries: 8192 (order: 8, 1179648 bytes, linear)
TCP: Hash tables configured (established 8192 bind 8192)
UDP hash table entries: 512 (order: 4, 81920 bytes, linear)
UDP-Lite hash table entries: 512 (order: 4, 81920 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp-with-tls transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
Initialise system trusted keyrings
workingset: timestamp_bits=42 max_order=18 bucket_order=0
squashfs: version 4.0 (2009/01/31) Phillip Lougher
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
9p: Installing v9fs 9p2000 file system support
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 244)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
pl061_gpio 9030000.pl061: PL061 GPIO chip registered
ledtrig-cpu: registered to indicate activity on CPUs
pci-host-generic 4010000000.pcie: host bridge /pcie@10000000 ranges:
pci-host-generic 4010000000.pcie:       IO 0x003eff0000..0x003effffff -> 
0x0000000000
pci-host-generic 4010000000.pcie:      MEM 0x0010000000..0x003efeffff -> 
0x0010000000
pci-host-generic 4010000000.pcie:      MEM 0x8000000000..0xffffffffff -> 
0x8000000000
pci-host-generic 4010000000.pcie: Memory resource size exceeds max for 
32 bits
pci-host-generic 4010000000.pcie: ECAM at [mem 
0x4010000000-0x401fffffff] for [bus 00-ff]
pci-host-generic 4010000000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff]
pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff]
pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000 conventional PCI 
endpoint
pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
pci_bus 0000:00: resource 5 [mem 0x10000000-0x3efeffff]
pci_bus 0000:00: resource 6 [mem 0x8000000000-0xffffffffff]
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
msm_serial: driver initialized
SuperH (H)SCI(F) driver initialized
STM32 USART driver initialized
brd: module loaded
loop: module loaded
virtio_blk virtio2: 1/0/0 default/read/poll queues
virtio_blk virtio2: [vda] 15106048 512-byte logical blocks (7.73 GB/7.20 
GiB)
virtio_blk virtio3: 1/0/0 default/read/poll queues
virtio_blk virtio3: [vdb] 154688 512-byte logical blocks (79.2 MB/75.5 MiB)
megasas: 07.727.03.00-rc1
physmap-flash 0.flash: physmap platform flash device: [mem 
0x00000000-0x03ffffff]
0.flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 
0x000000 Chip ID 0x000000
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
physmap-flash 0.flash: physmap platform flash device: [mem 
0x04000000-0x07ffffff]
0.flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 
0x000000 Chip ID 0x000000
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
Concatenating MTD devices:
(0): "0.flash"
(1): "0.flash"
into device "0.flash"
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:     1-...!: (0 ticks this GP) idle=81c8/0/0x0 softirq=0/0 fqs=0 
(false positive?)
rcu:     (detected by 0, t=6502 jiffies, g=-1167, q=164 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at default_idle_call+0xa8/0x1f0
rcu: rcu_preempt kthread timer wakeup didn't happen for 6501 jiffies! 
g-1167 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu:     Possible timer handling issue on cpu=1 timer-softirq=0
rcu: rcu_preempt kthread starved for 6502 jiffies! g-1167 f0x0 
RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now 
expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:0     pid:16    tgid:16 ppid:2      
flags:0x00000008
Call trace:
  __switch_to+0xf4/0x168
  __schedule+0x2ec/0xb90
  schedule+0x50/0x15c
  schedule_timeout+0x7c/0x100
  rcu_gp_fqs_loop+0x170/0x8b8
  rcu_gp_kthread+0x27c/0x310
  kthread+0x124/0x128
  ret_from_fork+0x10/0x20

--->8---


> ---
>   include/linux/tick.h        |  2 --
>   kernel/cpu.c                |  2 --
>   kernel/time/clockevents.c   | 33 ++++++++++++++-------------------
>   kernel/time/tick-internal.h |  3 +--
>   4 files changed, 15 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index 72744638c5b0..b0c74bfe0600 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -20,12 +20,10 @@ extern void __init tick_init(void);
>   extern void tick_suspend_local(void);
>   /* Should be core only, but XEN resume magic and ARM BL switcher require it */
>   extern void tick_resume_local(void);
> -extern void tick_cleanup_dead_cpu(int cpu);
>   #else /* CONFIG_GENERIC_CLOCKEVENTS */
>   static inline void tick_init(void) { }
>   static inline void tick_suspend_local(void) { }
>   static inline void tick_resume_local(void) { }
> -static inline void tick_cleanup_dead_cpu(int cpu) { }
>   #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
>   
>   #if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_HOTPLUG_CPU)
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index d293d52a3e00..895f3287e3f3 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1338,8 +1338,6 @@ static int takedown_cpu(unsigned int cpu)
>   
>   	cpuhp_bp_sync_dead(cpu);
>   
> -	tick_cleanup_dead_cpu(cpu);
> -
>   	/*
>   	 * Callbacks must be re-integrated right away to the RCU state machine.
>   	 * Otherwise an RCU callback could block a further teardown function
> diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> index 4af27994db93..4ac562ef7f40 100644
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -452,6 +452,9 @@ void clockevents_register_device(struct clock_event_device *dev)
>   {
>   	unsigned long flags;
>   
> +	if (WARN_ON_ONCE(cpu_is_offline(raw_smp_processor_id())))
> +		return;
> +
>   	/* Initialize state to DETACHED */
>   	clockevent_set_state(dev, CLOCK_EVT_STATE_DETACHED);
>   
> @@ -618,39 +621,30 @@ void clockevents_resume(void)
>   
>   #ifdef CONFIG_HOTPLUG_CPU
>   
> -# ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>   /**
> - * tick_offline_cpu - Take CPU out of the broadcast mechanism
> + * tick_offline_cpu - Shutdown all clock events related
> + *                    to this CPU and take it out of the
> + *                    broadcast mechanism.
>    * @cpu:	The outgoing CPU
>    *
> - * Called on the outgoing CPU after it took itself offline.
> + * Called by the dying CPU during teardown.
>    */
>   void tick_offline_cpu(unsigned int cpu)
> -{
> -	raw_spin_lock(&clockevents_lock);
> -	tick_broadcast_offline(cpu);
> -	raw_spin_unlock(&clockevents_lock);
> -}
> -# endif
> -
> -/**
> - * tick_cleanup_dead_cpu - Cleanup the tick and clockevents of a dead cpu
> - * @cpu:	The dead CPU
> - */
> -void tick_cleanup_dead_cpu(int cpu)
>   {
>   	struct clock_event_device *dev, *tmp;
> -	unsigned long flags;
>   
> -	raw_spin_lock_irqsave(&clockevents_lock, flags);
> +	raw_spin_lock(&clockevents_lock);
>   
> +	tick_broadcast_offline(cpu);
>   	tick_shutdown(cpu);
> +
>   	/*
>   	 * Unregister the clock event devices which were
> -	 * released from the users in the notify chain.
> +	 * released above.
>   	 */
>   	list_for_each_entry_safe(dev, tmp, &clockevents_released, list)
>   		list_del(&dev->list);
> +
>   	/*
>   	 * Now check whether the CPU has left unused per cpu devices
>   	 */
> @@ -662,7 +656,8 @@ void tick_cleanup_dead_cpu(int cpu)
>   			list_del(&dev->list);
>   		}
>   	}
> -	raw_spin_unlock_irqrestore(&clockevents_lock, flags);
> +
> +	raw_spin_unlock(&clockevents_lock);
>   }
>   #endif
>   
> diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
> index 5f2105e637bd..faac36de35b9 100644
> --- a/kernel/time/tick-internal.h
> +++ b/kernel/time/tick-internal.h
> @@ -25,6 +25,7 @@ extern int tick_do_timer_cpu __read_mostly;
>   extern void tick_setup_periodic(struct clock_event_device *dev, int broadcast);
>   extern void tick_handle_periodic(struct clock_event_device *dev);
>   extern void tick_check_new_device(struct clock_event_device *dev);
> +extern void tick_offline_cpu(unsigned int cpu);
>   extern void tick_shutdown(unsigned int cpu);
>   extern void tick_suspend(void);
>   extern void tick_resume(void);
> @@ -142,10 +143,8 @@ static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_
>   #endif /* !(BROADCAST && ONESHOT) */
>   
>   #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_CPU)
> -extern void tick_offline_cpu(unsigned int cpu);
>   extern void tick_broadcast_offline(unsigned int cpu);
>   #else
> -static inline void tick_offline_cpu(unsigned int cpu) { }
>   static inline void tick_broadcast_offline(unsigned int cpu) { }
>   #endif
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


