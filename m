Return-Path: <linux-kernel+bounces-426924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0DD9DFA1F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C17B1626C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17081F8AC5;
	Mon,  2 Dec 2024 05:06:39 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FEA15A8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 05:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733115999; cv=none; b=TgCrdLKIMz0u6Bnk3nkrjACnEV0SHaZP7VKInmm6Lv8Z21s/uy+iAHD29ehaFM9PR023+7ZOo2LwpA5chBM0jdG2pxI2RQQtEkUJhZWlOnvqaRLJpJkEfeClInhHWWxYiJ07RdtyoZR94CIYbVyShVquoWlZrETTjmW4SpZstBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733115999; c=relaxed/simple;
	bh=phNwibU8ifGN8XD5PmUFDia5cRK1h4r/oJFOUkxKCw0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rchR8RijFQ+WqHWHWOF/ptgsSstREquLcD/zxN4aU2ArRitlUSDJeBZrTcI0/osCwlvQE0B2OBNKRiGjDnE3uaGYzLeUl3WPV18LZjVj7GuGCsULkXrHqg9PfX2M/qM4013oGRuJCO9+IK/FYDNFfoMHwc0O+jfjJkqjpgraAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 08EEE72C8CC;
	Mon,  2 Dec 2024 07:58:31 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id F31FA36D0178;
	Mon,  2 Dec 2024 07:58:30 +0300 (MSK)
Date: Mon, 2 Dec 2024 07:58:30 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: v6.13-rc1: Internal error: Oops - Undefined instruction:
 0000000002000000 [#1] SMP
Message-ID: <20241202045830.e4yy3nkvxtzaybxk@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hi,

v6.13-rc1 exhibits a boot failure on aarch64 under KVM. (QEMU 9.1.1, CPU
Kunpeng-920). Boot log:

+ time qemu-system-aarch64 -M accel=kvm:tcg -smp cores=8 -m 4096 -serial mon:stdio -nodefaults -nographic -no-reboot -fsdev local,id=root,path=/,security_model=none,multidevs=remap -device virtio-9p-pci,fsdev=root,mount_tag=virtio-9p:/ -device virtio-rng-pci -kernel /usr/src/tmp/kernel-image-6.13-buildroot/boot/vmlinuz-6.13.0-6.13-alt0.rc1 -initrd /usr/src/tmp/initramfs-6.13.0-6.13-alt0.rc1.img -sandbox on,spawn=deny -M virt,gic-version=3 -cpu max -append 'console=ttyAMA0 mitigations=off nokaslr  panic=-1 SCRIPT=/usr/src/tmp/vm.SchsIm2FjB earlycon earlyprintk=serial ignore_loglevel debug rddebug'
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x481fd010]
[    0.000000] Linux version 6.13.0-6.13-alt0.rc1 (builder@localhost.localdomain) (gcc-14 (GCC) 14.2.1 20241028 (ALT Sisyphus 14.2.1-alt1), GNU ld (GNU Binutils) 2.43.1.20241025) #1 SMP PREEMPT_DYNAMIC Mon Dec  2 03:33:29 UTC 2024
[    0.000000] KASLR disabled on command line
[    0.000000] random: crng init done
[    0.000000] Machine model: linux,dummy-virt
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] efi: UEFI not found.
[    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
[    0.000000] printk: legacy bootconsole [pl11] enabled
[    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
[    0.000000] NUMA: Faking a node at [mem 0x0000000040000000-0x000000013fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x13f7f3540-0x13f7f947f]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x000000013fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000013fffffff]
[    0.000000] cma: Reserved 256 MiB at 0x00000000f0000000 on node -1
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] smccc: KVM: hypervisor services detected (0x00000000 0x00000000 0x00000000 0x00000003)
[    0.000000] percpu: Embedded 34 pages/cpu s100632 r8192 d30440 u139264
[    0.000000] pcpu-alloc: s100632 r8192 d30440 u139264 alloc=34*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
[    0.000000] Internal error: Oops - Undefined instruction: 0000000002000000 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.13.0-6.13-alt0.rc1 #1
[    0.000000] Hardware name: linux,dummy-virt (DT)
[    0.000000] pstate: 004000c5 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : __cpuinfo_store_cpu+0xe8/0x240
[    0.000000] lr : cpuinfo_store_boot_cpu+0x34/0x88
[    0.000000] sp : ffff800082013df0
[    0.000000] x29: ffff800082013df0 x28: 000000000000008e x27: ffff800081e38128
[    0.000000] x26: ffff800081702190 x25: ffff80008201f040 x24: ffff0000ff7d1d00
[    0.000000] x23: ffff80008201ec00 x22: ffff800081e39100 x21: ffff8000816f9750
[    0.000000] x20: ffff800081f55280 x19: ffff0000ff6be2e0 x18: 0000000000000000
[    0.000000] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    0.000000] x14: 000000000000002f x13: 000000013f7f9490 x12: 0000008000000000
[    0.000000] x11: 0000000000000000 x10: 00000000007f8000 x9 : 000000013f808000
[    0.000000] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000013f7f94c0
[    0.000000] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 1100010011111111
[    0.000000] x2 : 0000000000000001 x1 : 0000000084448004 x0 : ffff0000ff6be2e0
[    0.000000] Call trace:
[    0.000000]  __cpuinfo_store_cpu+0xe8/0x240 (P)
[    0.000000]  cpuinfo_store_boot_cpu+0x34/0x88 (L)
[    0.000000]  cpuinfo_store_boot_cpu+0x34/0x88
[    0.000000]  smp_prepare_boot_cpu+0x30/0x58
[    0.000000]  start_kernel+0x514/0x9d0
[    0.000000]  __primary_switched+0x88/0x98
[    0.000000] Code: f100085f 54000600 f2580c7f 54000060 (d538a482)
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] Rebooting in 600 seconds..

Thanks,


