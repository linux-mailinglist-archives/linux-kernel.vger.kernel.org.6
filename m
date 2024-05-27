Return-Path: <linux-kernel+bounces-191367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A34198D0CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74DE1F232B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A7915FCE9;
	Mon, 27 May 2024 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EFFa+i+G"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1116130B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837763; cv=none; b=MbNrldGj1PwyHhsPK1snslOkx1OJb2OufVH3IllOyhnexeFTIJ9/NTTMq09Dpk4ErSw2FLZyw49idX//unRyZMvTZ8Cs9sdOhW05RXFk6oWBtxXe8gKjQ/2rpi7BHdvUADDWkBqpznebt9E1ZstE3+AaeEcKwt1FlIzrlVW1q/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837763; c=relaxed/simple;
	bh=7SIBd1dZg+sQ3oJuxaRTjyWQr5Pp04GGFxBZwQQfCqE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T41pAPdReNfxPQs+GhNUpdcxi57IG/SX6pBq+WTfCFTz5Z5si6DbKTUdAwKf4Cz0dUqzPDTGqHbPaKnGH73XaIoLCyuHjJLArhzHSVT85oq/QPmQlusT5p20Zs31WwNNq8pK52v32CdoBr3Dws9ySCJqUlXHqC+pw1LH6qefSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EFFa+i+G; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A664340E01A1;
	Mon, 27 May 2024 19:22:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UVt2surLECIA; Mon, 27 May 2024 19:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716837739; bh=DY/0TNNkylcW2kiekcluxMHp+2deYB/BFFdiKEf37fE=;
	h=Date:From:To:Cc:Subject:From;
	b=EFFa+i+G0XbO0lOKPHGUoFaYQB6wMTd955TZyI132d0kcw7mYlUMlX4w4ikXZUXWL
	 25rTs32yZdrHJpTTqX+DN5iAQ4SxFaA8LoyU26ajg2wTKHW058Y/yCLcEg6hWfxwkr
	 DJZFLrvarpQ1O5dPXPO7S896iIGA2KPS8iLrg5K7uR/0TJZQTLfx67Q/mYQY3o2K51
	 udi4d4rDfwSmFaM2YS48emyzFmbllDFJ51zFh3qC5EWVXoUcTn9RzDjv95qu0zpM/T
	 QExfub30mbIOu1D/QtA3H+B1qJFu0bwBB7RCgQgO6rlSmg9OKJ/94ieSk1oC6OPIhz
	 U/tX0Ltg6h1IFKy7xpivSwC4vSX46+Za83b8B17dc5SVPwNwdMQFtDoG5/kphvMu+X
	 M22TmkWUE7ijjutRfb5NVKNGeasUIPaBvI7oJydMRBcc8gfotQ/DvmSNGU7Cnh2b7V
	 kjn2ti+BCYqNlYEP7YovKYJlDBVO4539cZZ2KiPpy3piQhNsJgKulNJKiGJFAcCKyv
	 9dWiuTC3rJpbycUVamVE1EDmVna8960DJT+ar2hkjSaxhtDcRG9yOdq1rw1VbW59/h
	 mcz2EwAGzdBPSxC6YnhlvsbYkYDX74Fx47Goz7EAM1DlB01AUckYlFPBoXWxVw9BiR
	 NAJjtM3fkufTcyMTJsC6Ys2w=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EAE9C40E0177;
	Mon, 27 May 2024 19:22:13 +0000 (UTC)
Date: Mon, 27 May 2024 21:21:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: c4cb23111103 ("iommu/amd: Add support for enable/disable IOPF")
Message-ID: <20240527192159.GEZlTdV7OoOuJrHmI0@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

my old CZ laptop doesn't like the locking in that patch in $Subject.

I mean, I think it is the culprit as it appears in the splat below which
starts at this timestamp:

[    0.938693] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585

[    0.938739] =============================
[    0.938740] [ BUG: Invalid wait context ]
[    0.938742] 6.10.0-rc1+ #1 Not tainted
[    0.938745] -----------------------------
[    0.938746] swapper/0/1 is trying to lock:
[    0.938748] ffffffff8c9f01d8 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x78/0x4a0
[    0.938767] other info that might help us debug this:

Full dmesg:

[    0.000000] Linux version 6.10.0-rc1+ (boris@zn) (gcc (Debian 13.2.0-9) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41.50.20231227) #1 SMP PREEMPT_DYNAMIC Mon May 27 20:58:30 CEST 2024
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.10.0-rc1+ root=/dev/sda2 ro root=/dev/sda2 console=ttyS0,115200 console=tty0 ignore_loglevel log_buf_len=16M resume=/dev/sda1 no_console_suspend rdrand=force
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ebff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000009bacefff] usable
[    0.000000] BIOS-e820: [mem 0x000000009bacf000-0x000000009c8cefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009c8cf000-0x000000009cfcefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000009cfcf000-0x000000009cffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000009cfff000-0x000000009cffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d0900000-0x00000000d09fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedf1000-0x00000000fedf1fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000043effffff] usable
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] last_pfn = 0x43f000 max_arch_pfn = 0x400000000
[    0.000000] MTRR map: 6 entries (3 fixed + 3 variable; max 20), built from 9 variable MTRRs
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] last_pfn = 0x9d000 max_arch_pfn = 0x400000000
[    0.000000] Using GB pages for direct mapping
[    0.000000] RAMDISK: [mem 0x34901000-0x36477fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FBE30 000024 (v02 HPQOEM)
[    0.000000] ACPI: XSDT 0x000000009CFFE120 0000C4 (v01 HPQOEM SLIC-BPC 00000001      01000013)
[    0.000000] ACPI: FACP 0x000000009CFF8000 00010C (v05 HPQOEM SLIC-BPC 00000001 HP   00000001)
[    0.000000] ACPI: DSDT 0x000000009CFE0000 01012E (v02 HPQOEM 807E     00000000 INTL 20121018)
[    0.000000] ACPI: FACS 0x000000009CF85000 000040
[    0.000000] ACPI: SSDT 0x000000009CFFC000 000108 (v02 HP     ShmTable 00000001 INTL 20121018)
[    0.000000] ACPI: UEFI 0x000000009CFFB000 000042 (v01                 00000000      00000000)
[    0.000000] ACPI: TCPA 0x000000009CFFA000 000032 (v02 HPQOEM EDK2     00000002      01000013)
[    0.000000] ACPI: SSDT 0x000000009CFF9000 0003B8 (v02 HPQOEM TcgTable 00001000 INTL 20121018)
[    0.000000] ACPI: ASF! 0x000000009CFF7000 00006E (v32 HPQOEM 807E     00000001 HP   00000001)
[    0.000000] ACPI: MSDM 0x000000009CFF6000 000055 (v03 HPQOEM SLIC-BPC 00000000 HP   00000001)
[    0.000000] ACPI: SLIC 0x000000009CFF5000 000176 (v01 HPQOEM SLIC-BPC 00000001 HP   00000001)
[    0.000000] ACPI: WSMT 0x000000009CFF4000 000028 (v01 HPQOEM 807E     00000001 HP   00000001)
[    0.000000] ACPI: HPET 0x000000009CFF3000 000038 (v01 HPQOEM 807E     00000001 HP   00000001)
[    0.000000] ACPI: APIC 0x000000009CFF2000 000090 (v02 HPQOEM 807E     00000001 HP   00000001)
[    0.000000] ACPI: MCFG 0x000000009CFF1000 00003C (v01 HPQOEM 807E     00000001 HP   00000001)
[    0.000000] ACPI: SSDT 0x000000009CFDE000 000854 (v01 AMD    AGESA    00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x000000009CFD5000 00873A (v02 AMD    AGESA    00000002 MSFT 04000000)
[    0.000000] ACPI: IVRS 0x000000009CFD4000 0000D0 (v02 AMD    AGESA    00000001 AMD  00000000)
[    0.000000] ACPI: SSDT 0x000000009CFDF000 0007EA (v01 AMD    CPMADPS4 00000001 INTL 20121018)
[    0.000000] ACPI: SSDT 0x000000009CFD2000 0015F0 (v01 AMD    CPMCMN   00000001 INTL 20121018)
[    0.000000] ACPI: FPDT 0x000000009CFD1000 000044 (v01 HPQOEM EDK2     00000002      01000013)
[    0.000000] ACPI: BGRT 0x000000009CFD0000 000038 (v01 HPQOEM EDK2     00000002      01000013)
[    0.000000] ACPI: SSDT 0x000000009CFFD000 000260 (v02 HP     PwrCtlEv 00000001 INTL 20121018)
[    0.000000] ACPI: Reserving FACP table memory at [mem 0x9cff8000-0x9cff810b]
[    0.000000] ACPI: Reserving DSDT table memory at [mem 0x9cfe0000-0x9cff012d]
[    0.000000] ACPI: Reserving FACS table memory at [mem 0x9cf85000-0x9cf8503f]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9cffc000-0x9cffc107]
[    0.000000] ACPI: Reserving UEFI table memory at [mem 0x9cffb000-0x9cffb041]
[    0.000000] ACPI: Reserving TCPA table memory at [mem 0x9cffa000-0x9cffa031]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9cff9000-0x9cff93b7]
[    0.000000] ACPI: Reserving ASF! table memory at [mem 0x9cff7000-0x9cff706d]
[    0.000000] ACPI: Reserving MSDM table memory at [mem 0x9cff6000-0x9cff6054]
[    0.000000] ACPI: Reserving SLIC table memory at [mem 0x9cff5000-0x9cff5175]
[    0.000000] ACPI: Reserving WSMT table memory at [mem 0x9cff4000-0x9cff4027]
[    0.000000] ACPI: Reserving HPET table memory at [mem 0x9cff3000-0x9cff3037]
[    0.000000] ACPI: Reserving APIC table memory at [mem 0x9cff2000-0x9cff208f]
[    0.000000] ACPI: Reserving MCFG table memory at [mem 0x9cff1000-0x9cff103b]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9cfde000-0x9cfde853]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9cfd5000-0x9cfdd739]
[    0.000000] ACPI: Reserving IVRS table memory at [mem 0x9cfd4000-0x9cfd40cf]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9cfdf000-0x9cfdf7e9]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9cfd2000-0x9cfd35ef]
[    0.000000] ACPI: Reserving FPDT table memory at [mem 0x9cfd1000-0x9cfd1043]
[    0.000000] ACPI: Reserving BGRT table memory at [mem 0x9cfd0000-0x9cfd0037]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9cffd000-0x9cffd25f]
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000043effffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x43effc000-0x43effdfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000043effffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000009bacefff]
[    0.000000]   node   0: [mem 0x000000009cfff000-0x000000009cffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000043effffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000043effffff]
[    0.000000] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 98 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 5424 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 12288 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 5, version 33, address 0xfec01000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.000000] CPU topo: Max. logical packages:   1
[    0.000000] CPU topo: Max. logical dies:       1
[    0.000000] CPU topo: Max. dies per package:   1
[    0.000000] CPU topo: Max. threads per core:   2
[    0.000000] CPU topo: Num. cores per package:     2
[    0.000000] CPU topo: Num. threads per package:   4
[    0.000000] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x9bacf000-0x9c8cefff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x9c8cf000-0x9cfcefff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x9cfcf000-0x9cffefff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x9d000000-0xd08fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xd0900000-0xd09fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xd0a00000-0xf7ffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfec0ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfec11000-0xfed7ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed80fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfed81000-0xfedf0fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfedf1000-0xfedf1fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfedf2000-0xfedfffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] [mem 0x9d000000-0xd08fffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:16 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 64 pages/cpu s225280 r8192 d28672 u524288
[    0.000000] pcpu-alloc: s225280 r8192 d28672 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.10.0-rc1+ root=/dev/sda2 ro root=/dev/sda2 console=ttyS0,115200 console=tty0 ignore_loglevel log_buf_len=16M resume=/dev/sda1 no_console_suspend rdrand=force
[    0.000000] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-6.10.0-rc1+", will be passed to user space.
[    0.000000] random: crng init done
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.000000] Fallback order for Node 0: 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 4041325
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off, mlocked free:off
[    0.000000] stackdepot: allocating hash table via alloc_large_system_hash
[    0.000000] stackdepot hash table entries: 1048576 (order: 12, 16777216 bytes, linear)
[    0.000000] software IO TLB: area num 4.
[    0.000000] Memory: 15577020K/16165300K available (14336K kernel code, 116373K rwdata, 5532K rodata, 2860K init, 51544K bss, 588024K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] ftrace: allocating 38260 entries in 150 pages
[    0.000000] ftrace: allocated 150 pages with 4 groups
[    0.000000] Dynamic Preempt: full
[    0.000000] Running RCU self tests
[    0.000000] Running RCU synchronous self tests
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU lockdep checking is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=4.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] Running RCU synchronous self tests
[    0.000000] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
[    0.000000] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
[    0.000000] NR_IRQS: 4352, nr_irqs: 1000, preallocated irqs: 16
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] printk: legacy console [tty0] enabled
[    0.000000] printk: legacy console [ttyS0] enabled
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8192
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.000000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.000000] ... CHAINHASH_SIZE:          32768
[    0.000000]  memory used by lock dependency info: 6429 kB
[    0.000000]  memory used for stack traces: 4224 kB
[    0.000000]  per task-struct memory footprint: 1920 bytes
[    0.000000] ACPI: Core revision 20240322
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] AMD-Vi: Using global IVHD EFR:0x77ef22294ada, EFR2:0x0
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.024000] tsc: PIT calibration matches HPET. 1 loops
[    0.024000] tsc: Detected 2096.112 MHz processor
[    0.000028] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e36d7c6d3a, max_idle_ns: 440795267907 ns
[    0.000466] Calibrating delay loop (skipped), value calculated using timer frequency.. 4192.22 BogoMIPS (lpj=8384448)
[    0.000997] LVT offset 1 assigned for vector 0xf9
[    0.004471] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.004724] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.005016] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.005365] Spectre V2 : Mitigation: Retpolines
[    0.005560] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.005858] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.006103] Spectre V2 : Enabling Speculation Barrier for firmware calls
[    0.006349] RETBleed: Mitigation: untrained return thunk
[    0.006571] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.006915] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.007277] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.007583] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.007819] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.008055] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.008285] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.026568] Freeing SMP alternatives memory: 32K
[    0.026805] pid_max: default: 32768 minimum: 301
[    0.027486] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.027879] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.031000] Running RCU synchronous self tests
[    0.031271] Running RCU synchronous self tests
[    0.139845] smpboot: CPU0: AMD PRO A12-8800B R7, 12 Compute Cores 4C+8G (family: 0x15, model: 0x60, stepping: 0x1)
[    0.140460] Running RCU Tasks wait API self tests
[    0.240652] Running RCU Tasks Rude wait API self tests
[    0.241065] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.241408] ... version:                0
[    0.241596] ... bit width:              48
[    0.241785] ... generic registers:      6
[    0.241970] ... value mask:             0000ffffffffffff
[    0.242203] ... max period:             00007fffffffffff
[    0.242435] ... fixed-purpose events:   0
[    0.242597] ... event mask:             000000000000003f
[    0.243055] signal: max sigframe size: 1776
[    0.243505] rcu: Hierarchical SRCU implementation.
[    0.243720] rcu: 	Max phase no-delay instances is 1000.
[    0.251078] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.251810] smp: Bringing up secondary CPUs ...
[    0.252754] smpboot: x86: Booting SMP configuration:
[    0.252996] .... node  #0, CPUs:      #2 #1 #3
[    0.262464] smp: Brought up 1 node, 4 CPUs
[    0.262464] smpboot: Total of 4 processors activated (16768.89 BogoMIPS)
[    0.270034] devtmpfs: initialized
[    0.274291] ACPI: PM: Registering ACPI NVS region [mem 0x9c8cf000-0x9cfcefff] (7340032 bytes)
[    0.279742] Running RCU synchronous self tests
[    0.280031] Running RCU synchronous self tests
[    0.280492] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.280924] futex hash table entries: 1024 (order: 5, 131072 bytes, linear)
[    0.281538] pinctrl core: initialized pinctrl subsystem
[    0.282812] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.284671] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[    0.285001] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.285349] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.286504] thermal_sys: Registered thermal governor 'fair_share'
[    0.286508] thermal_sys: Registered thermal governor 'bang_bang'
[    0.286770] thermal_sys: Registered thermal governor 'step_wise'
[    0.287025] thermal_sys: Registered thermal governor 'user_space'
[    0.287517] cpuidle: using governor ladder
[    0.288472] cpuidle: using governor menu
[    0.288766] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.289014] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.289902] PCI: ECAM [mem 0xf8000000-0xfbffffff] (base 0xf8000000) for domain 0000 [bus 00-3f]
[    0.290303] PCI: Using configuration type 1 for base access
[    0.290702] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.291050] mtrr: probably your BIOS does not setup all CPUs.
[    0.291315] mtrr: corrected configuration.
[    0.292570] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.293011] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.293011] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.293147] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.293442] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.296514] Demotion targets for Node 0: null
[    0.297385] ACPI: Added _OSI(Module Device)
[    0.297603] ACPI: Added _OSI(Processor Device)
[    0.297815] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.298035] ACPI: Added _OSI(Processor Aggregator Device)
[    0.348530] Callback from call_rcu_tasks_rude() invoked.
[    0.505203] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    0.536260] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.557134] Callback from call_rcu_tasks() invoked.
[    0.605098] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    0.606861] ACPI: EC: EC started
[    0.607055] ACPI: EC: interrupt blocked
[    0.631011] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.631264] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
[    0.631578] ACPI: Interpreter enabled
[    0.631923] ACPI: PM: (supports S0 S3 S4 S5)
[    0.632132] ACPI: Using IOAPIC for interrupt routing
[    0.634515] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.634896] PCI: Using E820 reservations for host bridge windows
[    0.637389] ACPI: Enabled 8 GPEs in block 00 to 1F
[    0.667541] ACPI: \_SB_.P0U2: New power resource
[    0.668226] ACPI: \_SB_.P3U2: New power resource
[    0.675100] ACPI: \_SB_.P0U3: New power resource
[    0.675700] ACPI: \_SB_.P3U3: New power resource
[    0.686760] ACPI: \_SB_.PCI0.HDEF.APPR: New power resource
[    0.691792] ACPI: \_SB_.P0ST: New power resource
[    0.692472] ACPI: \_SB_.P3ST: New power resource
[    0.707821] ACPI: \_SB_.PRU0: New power resource
[    0.708357] ACPI: \_SB_.PRU1: New power resource
[    0.708793] ACPI: \_SB_.PRUD: New power resource
[    0.709278] ACPI: \_SB_.PRI0: New power resource
[    0.709872] ACPI: \_SB_.PRI1: New power resource
[    0.710394] ACPI: \_SB_.PRI2: New power resource
[    0.710866] ACPI: \_SB_.PRI3: New power resource
[    0.711338] ACPI: \_SB_.PRID: New power resource
[    0.716241] ACPI: \_SB_.P0SD: New power resource
[    0.716764] ACPI: \_SB_.P3SD: New power resource
[    0.740329] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.740548] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.742142] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    0.744311] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.744963] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.745593] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf8000000-0xfbffffff] for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.747035] acpi PNP0A08:00: ignoring host bridge window [mem 0x000cc000-0x000cffff window] (conflicts with Video ROM [mem 0x000c0000-0x000cfdff])
[    0.749768] PCI host bridge to bus 0000:00
[    0.749976] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.750267] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.750554] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.750876] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000cbfff window]
[    0.751196] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000effff window]
[    0.751510] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff window]
[    0.751787] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfed3ffff window]
[    0.752065] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.752922] pci 0000:00:00.0: [1022:1576] type 00 class 0x060000 conventional PCI endpoint
[    0.753826] pci 0000:00:00.2: [1022:1577] type 00 class 0x080600 conventional PCI endpoint
[    0.754463] pci 0000:00:01.0: [1002:9874] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
[    0.754855] pci 0000:00:01.0: BAR 0 [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.755154] pci 0000:00:01.0: BAR 2 [mem 0xd0000000-0xd07fffff 64bit pref]
[    0.755448] pci 0000:00:01.0: BAR 4 [io  0x2000-0x20ff]
[    0.755659] pci 0000:00:01.0: BAR 5 [mem 0xd0c00000-0xd0c3ffff]
[    0.755887] pci 0000:00:01.0: ROM [mem 0xfffe0000-0xffffffff pref]
[    0.756471] pci 0000:00:01.0: enabling Extended Tags
[    0.756471] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.757071] pci 0000:00:01.0: supports D1 D2
[    0.757314] pci 0000:00:01.0: PME# supported from D1 D2 D3hot
[    0.758702] pci 0000:00:01.1: [1002:9840] type 00 class 0x040300 PCIe Root Complex Integrated Endpoint
[    0.759101] pci 0000:00:01.1: BAR 0 [mem 0xd0c60000-0xd0c63fff 64bit]
[    0.759405] pci 0000:00:01.1: enabling Extended Tags
[    0.759689] pci 0000:00:01.1: supports D1 D2
[    0.760174] pci 0000:00:02.0: [1022:157b] type 00 class 0x060000 conventional PCI endpoint
[    0.761360] pci 0000:00:02.1: [1022:157c] type 01 class 0x060400 PCIe Root Port
[    0.761744] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.761982] pci 0000:00:02.1:   bridge window [mem 0xd0800000-0xd08fffff 64bit pref]
[    0.762312] pci 0000:00:02.1: enabling Extended Tags
[    0.762622] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.763609] pci 0000:00:02.3: [1022:157c] type 01 class 0x060400 PCIe Root Port
[    0.763945] pci 0000:00:02.3: PCI bridge to [bus 02]
[    0.764173] pci 0000:00:02.3:   bridge window [mem 0xd0b00000-0xd0bfffff]
[    0.764537] pci 0000:00:02.3: enabling Extended Tags
[    0.764841] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.765959] pci 0000:00:02.5: [1022:157c] type 01 class 0x060400 PCIe Root Port
[    0.766294] pci 0000:00:02.5: PCI bridge to [bus 03]
[    0.766540] pci 0000:00:02.5: enabling Extended Tags
[    0.766841] pci 0000:00:02.5: PME# supported from D0 D3hot D3cold
[    0.767768] pci 0000:00:03.0: [1022:157b] type 00 class 0x060000 conventional PCI endpoint
[    0.768782] pci 0000:00:08.0: [1022:1578] type 00 class 0x108000 conventional PCI endpoint
[    0.769136] pci 0000:00:08.0: BAR 0 [mem 0xd0c40000-0xd0c5ffff 64bit pref]
[    0.769473] pci 0000:00:08.0: BAR 2 [mem 0xd0a00000-0xd0afffff]
[    0.769781] pci 0000:00:08.0: BAR 3 [mem 0xd0c6f000-0xd0c6ffff]
[    0.770043] pci 0000:00:08.0: BAR 5 [mem 0xd0c6a000-0xd0c6bfff]
[    0.770919] pci 0000:00:09.0: [1022:157d] type 00 class 0x060000 conventional PCI endpoint
[    0.771519] pci 0000:00:09.2: [1022:157a] type 00 class 0x040300 conventional PCI endpoint
[    0.771870] pci 0000:00:09.2: BAR 0 [mem 0xd0c64000-0xd0c67fff]
[    0.772189] pci 0000:00:09.2: PME# supported from D0 D3hot D3cold
[    0.773097] pci 0000:00:10.0: [1022:7914] type 00 class 0x0c0330 PCIe Root Complex Integrated Endpoint
[    0.773498] pci 0000:00:10.0: BAR 0 [mem 0xd0c68000-0xd0c69fff 64bit]
[    0.773954] pci 0000:00:10.0: PME# supported from D0 D3hot D3cold
[    0.774912] pci 0000:00:11.0: [1022:7901] type 00 class 0x010601 conventional PCI endpoint
[    0.775268] pci 0000:00:11.0: BAR 0 [io  0x2118-0x211f]
[    0.775507] pci 0000:00:11.0: BAR 1 [io  0x2124-0x2127]
[    0.775746] pci 0000:00:11.0: BAR 2 [io  0x2110-0x2117]
[    0.775982] pci 0000:00:11.0: BAR 3 [io  0x2120-0x2123]
[    0.776222] pci 0000:00:11.0: BAR 4 [io  0x2100-0x210f]
[    0.776498] pci 0000:00:11.0: BAR 5 [mem 0xd0c6c000-0xd0c6c3ff]
[    0.776781] pci 0000:00:11.0: PME# supported from D3hot
[    0.777804] pci 0000:00:12.0: [1022:7908] type 00 class 0x0c0320 conventional PCI endpoint
[    0.778160] pci 0000:00:12.0: BAR 0 [mem 0xd0c6d000-0xd0c6d0ff]
[    0.778515] pci 0000:00:12.0: supports D1 D2
[    0.778712] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.779615] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 conventional PCI endpoint
[    0.780587] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional PCI endpoint
[    0.781832] pci 0000:00:18.0: [1022:1570] type 00 class 0x060000 conventional PCI endpoint
[    0.782421] pci 0000:00:18.1: [1022:1571] type 00 class 0x060000 conventional PCI endpoint
[    0.783015] pci 0000:00:18.2: [1022:1572] type 00 class 0x060000 conventional PCI endpoint
[    0.783601] pci 0000:00:18.3: [1022:1573] type 00 class 0x060000 conventional PCI endpoint
[    0.784199] pci 0000:00:18.4: [1022:1574] type 00 class 0x060000 conventional PCI endpoint
[    0.784891] pci 0000:00:18.5: [1022:1575] type 00 class 0x060000 conventional PCI endpoint
[    0.786266] pci 0000:01:00.0: [14e4:1687] type 00 class 0x020000 PCIe Endpoint
[    0.786631] pci 0000:01:00.0: BAR 0 [mem 0xd0820000-0xd082ffff 64bit pref]
[    0.786968] pci 0000:01:00.0: BAR 2 [mem 0xd0810000-0xd081ffff 64bit pref]
[    0.787300] pci 0000:01:00.0: BAR 4 [mem 0xd0800000-0xd080ffff 64bit pref]
[    0.787835] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.788227] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x1 link at 0000:00:02.1 (capable of 4.000 Gb/s with 5.0 GT/s PCIe x1 link)
[    0.789648] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.790244] pci 0000:02:00.0: [8086:095a] type 00 class 0x028000 PCIe Endpoint
[    0.790588] pci 0000:02:00.0: BAR 0 [mem 0xd0b00000-0xd0b01fff 64bit]
[    0.791124] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.792858] pci 0000:00:02.3: PCI bridge to [bus 02]
[    0.793388] pci 0000:00:02.5: PCI bridge to [bus 03]
[    0.801711] ACPI: IRQ 3 override to edge(!), high(!)
[    0.803814] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.804103] ACPI: PCI: Interrupt link LNKA disabled
[    0.805025] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.805280] ACPI: PCI: Interrupt link LNKB disabled
[    0.806203] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.806459] ACPI: PCI: Interrupt link LNKC disabled
[    0.807327] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.807583] ACPI: PCI: Interrupt link LNKD disabled
[    0.808584] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.808841] ACPI: PCI: Interrupt link LNKE disabled
[    0.809749] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.810005] ACPI: PCI: Interrupt link LNKF disabled
[    0.810745] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.811001] ACPI: PCI: Interrupt link LNKG disabled
[    0.811729] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.811983] ACPI: PCI: Interrupt link LNKH disabled
[    0.814366] ACPI: EC: interrupt unblocked
[    0.814581] ACPI: EC: event unblocked
[    0.814759] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.814989] ACPI: EC: GPE=0x3
[    0.815147] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
[    0.815448] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
[    0.816113] iommu: Default domain type: Translated
[    0.816306] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.818609] SCSI subsystem initialized
[    0.820763] libata version 3.00 loaded.
[    0.821397] ACPI: bus type USB registered
[    0.821800] usbcore: registered new interface driver usbfs
[    0.822107] usbcore: registered new interface driver hub
[    0.824548] usbcore: registered new device driver usb
[    0.825748] EDAC MC: Ver: 3.0.0
[    0.826223] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    0.826609] PCI: Using ACPI for IRQ routing
[    0.828783] PCI: pci_cache_line_size set to 64 bytes
[    0.829136] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
[    0.829478] e820: reserve RAM buffer [mem 0x9bacf000-0x9bffffff]
[    0.829788] e820: reserve RAM buffer [mem 0x9d000000-0x9fffffff]
[    0.830047] e820: reserve RAM buffer [mem 0x43f000000-0x43fffffff]
[    0.832687] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    0.832826] pci 0000:00:01.0: vgaarb: bridge control possible
[    0.833073] pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.833444] vgaarb: loaded
[    0.833650] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.833874] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.836510] clocksource: Switched to clocksource tsc-early
[    0.839639] pnp: PnP ACPI init
[    0.841323] system 00:01: [io  0x0400-0x04cf] has been reserved
[    0.841643] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.841911] system 00:01: [io  0x04d6] has been reserved
[    0.842156] system 00:01: [io  0x0680-0x06ff] has been reserved
[    0.842420] system 00:01: [io  0x077a] has been reserved
[    0.842727] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.843033] system 00:01: [io  0x0c14] has been reserved
[    0.843277] system 00:01: [io  0x0c50-0x0c52] has been reserved
[    0.843543] system 00:01: [io  0x0c6c] has been reserved
[    0.843785] system 00:01: [io  0x0c6f] has been reserved
[    0.844001] system 00:01: [io  0x0cd0-0x0cdb] has been reserved
[    0.844236] system 00:01: [io  0x0840-0x0847] has been reserved
[    0.845414] system 00:02: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.847153] system 00:05: [io  0x0200-0x023f] has been reserved
[    0.847468] system 00:05: [mem 0xfedf1000-0xfedf1fff] has been reserved
[    0.848855] system 00:06: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.849154] system 00:06: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.849447] system 00:06: [mem 0xfec20000-0xfec20fff] has been reserved
[    0.855190] pnp: PnP ACPI: found 8 devices
[    0.873336] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.873964] NET: Registered PF_INET protocol family
[    0.875010] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.879338] tcp_listen_portaddr_hash hash table entries: 8192 (order: 7, 589824 bytes, linear)
[    0.879980] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.880326] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.881130] TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc hugepage)
[    0.889141] TCP: Hash tables configured (established 131072 bind 65536)
[    0.889781] UDP hash table entries: 8192 (order: 8, 1310720 bytes, linear)
[    0.890666] UDP-Lite hash table entries: 8192 (order: 8, 1310720 bytes, linear)
[    0.891941] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.892284] pci 0000:00:02.1: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    0.892632] pci 0000:00:02.1: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size 200000 add_align 100000
[    0.893058] pci 0000:00:02.3: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
[    0.893401] pci 0000:00:02.3: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    0.893887] pci 0000:00:02.5: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
[    0.894189] pci 0000:00:02.5: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
[    0.894637] pci 0000:00:02.5: bridge window [mem 0x00100000-0x000fffff] to [bus 03] add_size 200000 add_align 100000
[    0.895133] pci 0000:00:02.1: bridge window [mem 0xd0d00000-0xd0efffff]: assigned
[    0.895450] pci 0000:00:02.3: bridge window [mem 0xd0f00000-0xd10fffff 64bit pref]: assigned
[    0.895797] pci 0000:00:02.5: bridge window [mem 0xd1100000-0xd12fffff]: assigned
[    0.896087] pci 0000:00:02.5: bridge window [mem 0xd1300000-0xd14fffff 64bit pref]: assigned
[    0.896394] pci 0000:00:02.1: bridge window [io  0x1000-0x1fff]: assigned
[    0.896646] pci 0000:00:02.3: bridge window [io  0x3000-0x3fff]: assigned
[    0.896904] pci 0000:00:02.5: bridge window [io  0x4000-0x4fff]: assigned
[    0.897206] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.897433] pci 0000:00:02.1:   bridge window [io  0x1000-0x1fff]
[    0.897700] pci 0000:00:02.1:   bridge window [mem 0xd0d00000-0xd0efffff]
[    0.897977] pci 0000:00:02.1:   bridge window [mem 0xd0800000-0xd08fffff 64bit pref]
[    0.898264] pci 0000:00:02.3: PCI bridge to [bus 02]
[    0.898457] pci 0000:00:02.3:   bridge window [io  0x3000-0x3fff]
[    0.898734] pci 0000:00:02.3:   bridge window [mem 0xd0b00000-0xd0bfffff]
[    0.899034] pci 0000:00:02.3:   bridge window [mem 0xd0f00000-0xd10fffff 64bit pref]
[    0.899356] pci 0000:00:02.5: PCI bridge to [bus 03]
[    0.899578] pci 0000:00:02.5:   bridge window [io  0x4000-0x4fff]
[    0.899841] pci 0000:00:02.5:   bridge window [mem 0xd1100000-0xd12fffff]
[    0.900098] pci 0000:00:02.5:   bridge window [mem 0xd1300000-0xd14fffff 64bit pref]
[    0.900389] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.900621] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.900852] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.901139] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000cbfff window]
[    0.901426] pci_bus 0000:00: resource 8 [mem 0x000d0000-0x000effff window]
[    0.901717] pci_bus 0000:00: resource 9 [mem 0xc0000000-0xdfffffff window]
[    0.902005] pci_bus 0000:00: resource 10 [mem 0xf0000000-0xfed3ffff window]
[    0.902294] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    0.902576] pci_bus 0000:01: resource 1 [mem 0xd0d00000-0xd0efffff]
[    0.902886] pci_bus 0000:01: resource 2 [mem 0xd0800000-0xd08fffff 64bit pref]
[    0.903188] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.903430] pci_bus 0000:02: resource 1 [mem 0xd0b00000-0xd0bfffff]
[    0.903695] pci_bus 0000:02: resource 2 [mem 0xd0f00000-0xd10fffff 64bit pref]
[    0.903988] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
[    0.904201] pci_bus 0000:03: resource 1 [mem 0xd1100000-0xd12fffff]
[    0.904433] pci_bus 0000:03: resource 2 [mem 0xd1300000-0xd14fffff 64bit pref]
[    0.905534] pci 0000:00:01.1: D0 power state depends on 0000:00:01.0
[    0.926535] pci 0000:00:10.0: quirk_usb_early_handoff+0x0/0x790 took 20060 usecs
[    0.926964] pci 0000:00:10.0: PME# does not work under D0, disabling it
[    0.928560] PCI: CLS 64 bytes, default 64
[    0.928848] AMD-Vi: [Firmware Warn]: EFR mismatch. Use IVHD EFR (0x37ef22294ada : 0x77ef22294ada), EFR2 (0x0 : 0x0).
[    0.929283] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.929415] Unpacking initramfs...
[    0.930680] pci 0000:00:01.0: Adding to iommu group 0
[    0.931118] pci 0000:00:01.1: Adding to iommu group 0
[    0.931527] pci 0000:00:02.0: Adding to iommu group 1
[    0.931829] pci 0000:00:02.1: Adding to iommu group 1
[    0.932130] pci 0000:00:02.3: Adding to iommu group 1
[    0.932431] pci 0000:00:02.5: Adding to iommu group 1
[    0.932787] pci 0000:00:03.0: Adding to iommu group 2
[    0.933120] pci 0000:00:08.0: Adding to iommu group 3
[    0.933489] pci 0000:00:09.0: Adding to iommu group 4
[    0.933809] pci 0000:00:09.2: Adding to iommu group 4
[    0.934183] pci 0000:00:10.0: Adding to iommu group 5
[    0.934526] pci 0000:00:11.0: Adding to iommu group 6
[    0.934960] pci 0000:00:12.0: Adding to iommu group 7
[    0.935318] pci 0000:00:14.0: Adding to iommu group 8
[    0.935624] pci 0000:00:14.3: Adding to iommu group 8
[    0.936061] pci 0000:00:18.0: Adding to iommu group 9
[    0.936363] pci 0000:00:18.1: Adding to iommu group 9
[    0.936663] pci 0000:00:18.2: Adding to iommu group 9
[    0.936968] pci 0000:00:18.3: Adding to iommu group 9
[    0.937275] pci 0000:00:18.4: Adding to iommu group 9
[    0.937585] pci 0000:00:18.5: Adding to iommu group 9
[    0.937885] pci 0000:01:00.0: Adding to iommu group 1
[    0.938166] pci 0000:02:00.0: Adding to iommu group 1
[    0.938693] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585

[    0.938739] =============================
[    0.938740] [ BUG: Invalid wait context ]
[    0.938742] 6.10.0-rc1+ #1 Not tainted
[    0.938745] -----------------------------
[    0.938746] swapper/0/1 is trying to lock:
[    0.938748] ffffffff8c9f01d8 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x78/0x4a0
[    0.938767] other info that might help us debug this:
[    0.938768] context-{5:5}
[    0.938769] 7 locks held by swapper/0/1:
[    0.938772]  #0: ffff888101a91310 (&group->mutex){+.+.}-{4:4}, at: bus_iommu_probe+0x70/0x160
[    0.938790]  #1: ffff888101d1f1b8 (&domain->lock){....}-{3:3}, at: amd_iommu_attach_device+0xa5/0x700
[    0.938799]  #2: ffff888101cc3d18 (&dev_data->lock){....}-{3:3}, at: amd_iommu_attach_device+0xc5/0x700
[    0.938806]  #3: ffff888100052830 (&iommu->lock){....}-{2:2}, at: amd_iommu_iopf_add_device+0x3f/0xa0
[    0.938813]  #4: ffffffff8945a340 (console_lock){+.+.}-{0:0}, at: _printk+0x48/0x50
[    0.938822]  #5: ffffffff8945a390 (console_srcu){....}-{0:0}, at: console_flush_all+0x58/0x4e0
[    0.938867]  #6: ffffffff82459f80 (console_owner){....}-{0:0}, at: console_flush_all+0x1f0/0x4e0
[    0.938872] stack backtrace:
[    0.938874] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc1+ #1
[    0.938877] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[    0.938879] Call Trace:
[    0.938881]  <TASK>
[    0.938884]  dump_stack_lvl+0x71/0xa0
[    0.938891]  __lock_acquire+0x8ae/0x24a0
[    0.938895]  ? stack_trace_save+0x39/0x50
[    0.938900]  lock_acquire+0xe0/0x2f0
[    0.938903]  ? serial8250_console_write+0x78/0x4a0
[    0.938907]  _raw_spin_lock_irqsave+0x41/0x60
[    0.938911]  ? serial8250_console_write+0x78/0x4a0
[    0.938914]  serial8250_console_write+0x78/0x4a0
[    0.938918]  ? lock_release+0xbf/0x280
[    0.938921]  ? console_flush_all+0x1f0/0x4e0
[    0.938923]  console_flush_all+0x210/0x4e0
[    0.938926]  ? console_flush_all+0x1f0/0x4e0
[    0.938929]  console_unlock+0x34/0x110
[    0.938932]  vprintk_emit+0x170/0x390
[    0.938935]  _printk+0x48/0x50
[    0.938938]  ? lock_is_held_type+0x82/0xf0
[    0.938942]  __might_resched+0xd7/0x290
[    0.938945]  __mutex_lock+0x3c/0xba0
[    0.938950]  ? iopf_queue_add_device+0x58/0x200
[    0.938952]  ? amd_iommu_iopf_add_device+0x3f/0xa0
[    0.938955]  iopf_queue_add_device+0x58/0x200
[    0.938958]  amd_iommu_iopf_add_device+0x5c/0xa0
[    0.938960]  ? pci_enable_pri+0x9d/0xe0
[    0.938964]  amd_iommu_attach_device+0x55d/0x700
[    0.938969]  __iommu_attach_device+0x2f/0xf0
[    0.938973]  __iommu_device_set_domain+0x6f/0xd0
[    0.938977]  __iommu_group_set_domain_internal+0x68/0x120
[    0.938980]  iommu_setup_default_domain+0x497/0x560
[    0.938983]  bus_iommu_probe+0xa9/0x160
[    0.938986]  iommu_device_register+0xac/0xf0
[    0.938988]  state_next+0xad8/0x20e0
[    0.938994]  ? add_device_randomness+0x6f/0x90
[    0.938997]  ? lock_release+0xbf/0x280
[    0.939000]  ? __pfx_pci_iommu_init+0x10/0x10
[    0.939005]  amd_iommu_init+0x1c/0x50
[    0.939008]  pci_iommu_init+0xe/0x40
[    0.939010]  do_one_initcall+0x60/0x2c0
[    0.939016]  kernel_init_freeable+0x1b2/0x360
[    0.939020]  ? __pfx_ignore_unknown_bootoption+0x10/0x10
[    0.939022]  ? __pfx_kernel_init+0x10/0x10
[    0.939025]  kernel_init+0x16/0x1c0
[    0.939027]  ret_from_fork+0x4c/0x60
[    0.939030]  ? __pfx_kernel_init+0x10/0x10
[    0.939033]  ret_from_fork_asm+0x1a/0x30
[    0.939037]  </TASK>
[    0.950711] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
[    0.950711] preempt_count: 3, expected: 0
[    0.950711] RCU nest depth: 0, expected: 0
[    0.950711] INFO: lockdep is turned off.
[    0.950711] irq event stamp: 1161560
[    0.950711] hardirqs last  enabled at (1161559): [<ffffffff81160bce>] __call_rcu_common.constprop.0+0x14e/0x2f0
[    0.950711] hardirqs last disabled at (1161560): [<ffffffff81b5643c>] _raw_spin_lock_irqsave+0x5c/0x60
[    0.954746] softirqs last  enabled at (1157788): [<ffffffff8109f46b>] irq_exit_rcu+0x7b/0xa0
[    0.954746] softirqs last disabled at (1157775): [<ffffffff8109f46b>] irq_exit_rcu+0x7b/0xa0
[    0.954746] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc1+ #1
[    0.954746] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[    0.954746] Call Trace:
[    0.954746]  <TASK>
[    0.954746]  dump_stack_lvl+0x71/0xa0
[    0.954746]  __might_resched+0x171/0x290
[    0.954746]  __mutex_lock+0x3c/0xba0
[    0.954746]  ? iopf_queue_add_device+0x58/0x200
[    0.954746]  ? amd_iommu_iopf_add_device+0x3f/0xa0
[    0.954746]  iopf_queue_add_device+0x58/0x200
[    0.954746]  amd_iommu_iopf_add_device+0x5c/0xa0
[    0.954746]  ? pci_enable_pri+0x9d/0xe0
[    0.954746]  amd_iommu_attach_device+0x55d/0x700
[    0.954746]  __iommu_attach_device+0x2f/0xf0
[    0.954746]  __iommu_device_set_domain+0x6f/0xd0
[    0.954746]  __iommu_group_set_domain_internal+0x68/0x120
[    0.954746]  iommu_setup_default_domain+0x497/0x560
[    0.958711]  bus_iommu_probe+0xa9/0x160
[    0.958711]  iommu_device_register+0xac/0xf0
[    0.958711]  state_next+0xad8/0x20e0
[    0.958711]  ? add_device_randomness+0x6f/0x90
[    0.958711]  ? lock_release+0xbf/0x280
[    0.958711]  ? __pfx_pci_iommu_init+0x10/0x10
[    0.958711]  amd_iommu_init+0x1c/0x50
[    0.958711]  pci_iommu_init+0xe/0x40
[    0.958711]  do_one_initcall+0x60/0x2c0
[    0.958711]  kernel_init_freeable+0x1b2/0x360
[    0.958711]  ? __pfx_ignore_unknown_bootoption+0x10/0x10
[    0.958711]  ? __pfx_kernel_init+0x10/0x10
[    0.958711]  kernel_init+0x16/0x1c0
[    0.958711]  ret_from_fork+0x4c/0x60
[    0.958711]  ? __pfx_kernel_init+0x10/0x10
[    0.958711]  ret_from_fork_asm+0x1a/0x30
[    0.958711]  </TASK>
[    0.971265] AMD-Vi: Extended features (0x77ef22294ada, 0x0): PPR NX GT IA GA PC GA_vAPIC
[    0.971633] AMD-Vi: Interrupt remapping enabled
[    0.972456] AMD-Vi: Virtual APIC enabled
[    0.972643] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.972913] software IO TLB: mapped [mem 0x0000000097acf000-0x000000009bacf000] (64MB)
[    0.973294] LVT offset 0 assigned for vector 0x400
[    0.977551] perf: AMD IBS detected (0x000007ff)
[    0.978124] amd_uncore: 4 amd_nb counters detected
[    0.978398] amd_uncore: 0 amd_l2 counters detected
[    0.981519] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    0.984829] Initialise system trusted keyrings
[    0.985250] workingset: timestamp_bits=61 max_order=22 bucket_order=0
[    0.986617] 9p: Installing v9fs 9p2000 file system support
[    0.987125] Key type asymmetric registered
[    0.987315] Asymmetric key parser 'x509' registered
[    0.987657] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.995674] pcieport 0000:00:02.1: PME: Signaling with IRQ 26
[    0.996125] pcieport 0000:00:02.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.998705] pcieport 0000:00:02.3: PME: Signaling with IRQ 27
[    0.999157] pcieport 0000:00:02.3: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.001189] pcieport 0000:00:02.5: PME: Signaling with IRQ 28
[    1.001620] pcieport 0000:00:02.5: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.026421] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
[    1.027327] ACPI: \_PR_.C000: Found 2 idle states
[    1.029105] ACPI: \_PR_.C001: Found 2 idle states
[    1.029875] ACPI: \_PR_.C002: Found 2 idle states
[    1.030657] ACPI: \_PR_.C003: Found 2 idle states
[    1.044692] thermal LNXTHERM:00: registered as thermal_zone0
[    1.044958] ACPI: thermal: Thermal Zone [CPUZ] (43 C)
[    1.050728] thermal LNXTHERM:01: registered as thermal_zone1
[    1.050996] ACPI: thermal: Thermal Zone [GFXZ] (0 C)
[    1.056314] thermal LNXTHERM:02: registered as thermal_zone2
[    1.056595] ACPI: thermal: Thermal Zone [EXTZ] (0 C)
[    1.063359] thermal LNXTHERM:03: registered as thermal_zone3
[    1.063626] ACPI: thermal: Thermal Zone [LOCZ] (0 C)
[    1.074862] thermal LNXTHERM:04: registered as thermal_zone4
[    1.075125] ACPI: thermal: Thermal Zone [BATZ] (0 C)
[    1.148184] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.152277] Linux agpgart interface v0.103
[    1.153533] ACPI: bus type drm_connector registered
[    1.155784] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[    1.157732] ahci 0000:00:11.0: version 3.0
[    1.158943] ahci 0000:00:11.0: AHCI vers 0001.0300, 32 command slots, 6 Gbps, SATA mode
[    1.159274] ahci 0000:00:11.0: 2/2 ports implemented (port mask 0x3)
[    1.159539] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp fbs pio slum part deso sadm sds 
[    1.161987] scsi host0: ahci
[    1.163004] scsi host1: ahci
[    1.163574] ata1: SATA max UDMA/133 abar m1024@0xd0c6c000 port 0xd0c6c100 irq 19 lpm-pol 0
[    1.163910] ata2: SATA max UDMA/133 abar m1024@0xd0c6c000 port 0xd0c6c180 irq 19 lpm-pol 0
[    1.166402] tun: Universal TUN/TAP device driver, 1.6
[    1.168546] ehci-pci 0000:00:12.0: EHCI Host Controller
[    1.168837] ehci-pci 0000:00:12.0: new USB bus registered, assigned bus number 1
[    1.169171] ehci-pci 0000:00:12.0: debug port 2
[    1.169633] ehci-pci 0000:00:12.0: irq 18, io mem 0xd0c6d000
[    1.188671] ehci-pci 0000:00:12.0: USB 2.0 started, EHCI 1.00
[    1.189355] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.10
[    1.189695] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.189995] usb usb1: Product: EHCI Host Controller
[    1.190211] usb usb1: Manufacturer: Linux 6.10.0-rc1+ ehci_hcd
[    1.190457] usb usb1: SerialNumber: 0000:00:12.0
[    1.191487] hub 1-0:1.0: USB hub found
[    1.191718] hub 1-0:1.0: 2 ports detected
[    1.192645] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    1.192923] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[    1.193911] xhci_hcd 0000:00:10.0: hcc params 0x014040c3 hci version 0x100 quirks 0x0000000000000010
[    1.196417] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    1.196792] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 3
[    1.197114] xhci_hcd 0000:00:10.0: Host supports USB 3.0 SuperSpeed
[    1.200709] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.10
[    1.201048] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.202107] usb usb2: Product: xHCI Host Controller
[    1.202322] usb usb2: Manufacturer: Linux 6.10.0-rc1+ xhci-hcd
[    1.202558] usb usb2: SerialNumber: 0000:00:10.0
[    1.203554] hub 2-0:1.0: USB hub found
[    1.203795] hub 2-0:1.0: 4 ports detected
[    1.212028] usb usb3: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.212586] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.10
[    1.212926] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.213227] usb usb3: Product: xHCI Host Controller
[    1.213442] usb usb3: Manufacturer: Linux 6.10.0-rc1+ xhci-hcd
[    1.213690] usb usb3: SerialNumber: 0000:00:10.0
[    1.214672] hub 3-0:1.0: USB hub found
[    1.214899] hub 3-0:1.0: 4 ports detected
[    1.223534] usbcore: registered new interface driver usb-storage
[    1.224052] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    1.225631] i8042: Detected active multiplexing controller, rev 1.1
[    1.226612] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.227065] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    1.227460] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    1.227839] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    1.228212] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    1.229008] mousedev: PS/2 mouse device common for all mice
[    1.229495] rtc_cmos 00:00: RTC can wake from S4
[    1.230741] rtc_cmos 00:00: registered as rtc0
[    1.230988] rtc_cmos 00:00: setting system clock to 2024-05-27T21:02:02 UTC (1716843722)
[    1.231467] rtc_cmos 00:00: alarms up to one month, 114 bytes nvram, hpet irqs
[    1.231857] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
[    1.233682] hid: raw HID events driver (C) Jiri Kosina
[    1.234071] usbcore: registered new interface driver usbhid
[    1.234315] usbhid: USB HID core driver
[    1.234810] NET: Registered PF_INET6 protocol family
[    1.236520] Segment Routing with IPv6
[    1.236760] In-situ OAM (IOAM) with IPv6
[    1.237002] mip6: Mobile IPv6
[    1.237162] NET: Registered PF_PACKET protocol family
[    1.237420] 9pnet: Installing 9P2000 support
[    1.237697] x86/pm: family 0x15 cpu detected, MSR saving is needed during suspending.
[    1.239962] microcode: Current revision: 0x0600611a
[    1.244835] IPI shorthand broadcast: enabled
[    1.247100] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.264832] sched_clock: Marking stable (1288013804, -23539694)->(1266483896, -2009786)
[    1.265571] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    1.266123] registered taskstats version 1
[    1.266320] Loading compiled-in X.509 certificates
[    1.283640] Demotion targets for Node 0: null
[    1.284081] kmemleak: Kernel memory leak detector initialized (mem pool available: 15768)
[    1.284085] kmemleak: Automatic memory scanning thread started
[    1.406982] printk: legacy console [netcon0] enabled
[    1.407222] netconsole: network logging started
[    1.407929] RAS: Correctable Errors collector initialized.
[    1.448713] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.451474] Freeing initrd memory: 28124K
[    1.607861] usb 1-1: New USB device found, idVendor=0438, idProduct=7900, bcdDevice= 0.18
[    1.608210] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.610925] hub 1-1:1.0: USB hub found
[    1.611490] hub 1-1:1.0: 4 ports detected
[    1.640732] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.642328] ata2.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[    1.642669] ata2.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
[    1.643009] ata2.00: ATA-9: SanDisk SD7SN6S-256G-1006, X3511006, max UDMA/133
[    1.643695] ata2.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.644692] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.646457] ata2.00: Features: Dev-Sleep
[    1.647338] ata1.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[    1.647659] ata1.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
[    1.648360] ata1.00: supports DRM functions and may not be fully accessible
[    1.648692] ata1.00: ATA-9: Samsung SSD 850 EVO 250GB, EMT02B6Q, max UDMA/133
[    1.649770] ata2.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[    1.650090] ata2.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
[    1.650930] ata1.00: 488397168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.652291] ata1.00: Features: Trust Dev-Sleep NCQ-sndrcv
[    1.652545] ata2.00: configured for UDMA/133
[    1.653389] ata1.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[    1.653707] ata1.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
[    1.654249] ata1.00: supports DRM functions and may not be fully accessible
[    1.657970] ata1.00: configured for UDMA/133
[    1.659129] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 850  2B6Q PQ: 0 ANSI: 5
[    1.661489] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.661831] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
[    1.662201] sd 0:0:0:0: [sda] Write Protect is off
[    1.662427] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.662475] scsi 1:0:0:0: Direct-Access     ATA      SanDisk SD7SN6S- 1006 PQ: 0 ANSI: 5
[    1.662641] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.663623] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    1.664871] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    1.665024] sd 1:0:0:0: [sdb] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    1.665448] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[    1.665773] sd 1:0:0:0: [sdb] Write Protect is off
[    1.665962]  sda: sda1 sda2 sda3 < sda5 >
[    1.666010] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.666475] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.666913] sd 1:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
[    1.667089] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.668702]  sdb: sdb1 sdb2 sdb3 sdb4
[    1.670786] sd 1:0:0:0: [sdb] Attached SCSI disk
[    1.671314] PM: Image not found (code -22)
[    1.672021] clk: Disabling unused clocks
[    1.679298] Freeing unused decrypted memory: 2036K
[    1.681885] Freeing unused kernel image (initmem) memory: 2860K
[    1.682194] Write protecting the kernel read-only data: 20480k
[    1.684173] Freeing unused kernel image (rodata/data gap) memory: 612K
[    1.756417] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.756798] Run /init as init process
[    1.756975]   with arguments:
[    1.757162]     /init
[    1.757285]   with environment:
[    1.757437]     HOME=/
[    1.757562]     TERM=linux
[    1.757699]     BOOT_IMAGE=/boot/vmlinuz-6.10.0-rc1+
[    1.824036] systemd-udevd[1193]: Starting version 244.3-1
[    1.828165] systemd-udevd[1195]: /usr/lib/udev/rules.d/50-udev-default.rules:24 The line takes no effect, ignoring.
[    1.828633] systemd-udevd[1195]: /usr/lib/udev/rules.d/50-udev-default.rules:25 The line takes no effect, ignoring.
[    1.829065] systemd-udevd[1195]: /usr/lib/udev/rules.d/50-udev-default.rules:29 The line takes no effect, ignoring.
[    1.829489] systemd-udevd[1195]: /usr/lib/udev/rules.d/50-udev-default.rules:32 The line takes no effect, ignoring.
[    1.829879] systemd-udevd[1195]: /usr/lib/udev/rules.d/50-udev-default.rules:33 The line takes no effect, ignoring.
[    1.830249] systemd-udevd[1195]: /usr/lib/udev/rules.d/50-udev-default.rules:34 The line takes no effect, ignoring.
[    1.830624] systemd-udevd[1195]: /usr/lib/udev/rules.d/50-udev-default.rules:35 The line takes no effect, ignoring.
[    1.831040] systemd-udevd[1195]: /usr/lib/udev/rules.d/50-udev-default.rules:36 The line takes no effect, ignoring.
[    1.831458] systemd-udevd[1195]: /usr/lib/udev/rules.d/50-udev-default.rules:37 The line takes no effect, ignoring.
[    1.912586] usb 1-1.3: new high-speed USB device number 3 using ehci-pci
[    1.988582] tsc: Refined TSC clocksource calibration: 2096.065 MHz
[    1.988951] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1e36ab33d65, max_idle_ns: 440795245607 ns
[    1.989595] clocksource: Switched to clocksource tsc
[    2.027839] usb 1-1.3: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=88.31
[    2.028240] usb 1-1.3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.028602] usb 1-1.3: Product: USB2.0 Hub
[    2.031021] hub 1-1.3:1.0: USB hub found
[    2.032327] hub 1-1.3:1.0: 4 ports detected
[    2.157322] wmi_bus wmi_bus-PNP0C14:00: [Firmware Info]: DF4E63B6-3BBC-4858-9737-C74F82F821F3 has zero instances
[    2.158157] wmi_bus wmi_bus-PNP0C14:00: [Firmware Info]: 8F1F6436-9F42-42C8-BADC-0E9424F20C9A has zero instances
[    2.189780] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.198444] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input5
[    3.162581] input: PS/2 Generic Mouse as /devices/platform/i8042/serio2/input/input7
[    3.899206] psmouse serio3: synaptics: queried max coordinates: x [..5670], y [..4758]
[    3.930200] psmouse serio3: synaptics: queried min coordinates: x [1360..], y [1198..]
[    3.931410] psmouse serio3: synaptics: Your touchpad (PNP: SYN3035 SYN0100 SYN0002 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
[    3.988741] psmouse serio3: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf00123/0x840300/0x2e800/0x0, board id: 3139, fw id: 2000742
[    4.025083] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio3/input/input8
[   10.856434] [drm] amdgpu kernel modesetting enabled.
[   10.890571] [drm] initializing kernel modesetting (CARRIZO 0x1002:0x9874 0x103C:0x807E 0xC4).
[   10.890992] [drm] register mmio base: 0xD0C00000
[   10.891195] [drm] register mmio size: 262144
[   10.892137] [drm] add ip block number 0 <vi_common>
[   10.892373] [drm] add ip block number 1 <gmc_v8_0>
[   10.892638] [drm] add ip block number 2 <cz_ih>
[   10.892879] [drm] add ip block number 3 <gfx_v8_0>
[   10.893088] [drm] add ip block number 4 <sdma_v3_0>
[   10.893301] [drm] add ip block number 5 <powerplay>
[   10.893513] [drm] add ip block number 6 <dm>
[   10.893705] [drm] add ip block number 7 <uvd_v6_0>
[   10.893888] [drm] add ip block number 8 <vce_v3_0>
[   10.909200] [drm] BIOS signature incorrect 5b 7
[   10.909445] resource: resource sanity check: requesting [mem 0x00000000000c0000-0x00000000000dffff], which spans more than PCI Bus 0000:00 [mem 0x000c0000-0x000cbfff window]
[   10.909994] caller pci_map_rom+0x68/0x1d0 mapping multiple BARs
[   10.910309] amdgpu 0000:00:01.0: amdgpu: Fetched VBIOS from ROM BAR
[   10.910561] amdgpu: ATOM BIOS: SWBRT27354.001
[   10.911277] [drm] UVD is enabled in physical mode
[   10.911490] [drm] VCE enabled in physical mode
[   10.911873] amdgpu 0000:00:01.0: vgaarb: deactivate vga console
[   10.913362] Console: switching to colour dummy device 80x25
[   10.913622] amdgpu 0000:00:01.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
[   10.914176] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
[   10.914470] amdgpu 0000:00:01.0: amdgpu: VRAM: 512M 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
[   10.914795] amdgpu 0000:00:01.0: amdgpu: GART: 1024M 0x000000FF00000000 - 0x000000FF3FFFFFFF
[   10.915103] [drm] Detected VRAM RAM=512M, BAR=512M
[   10.915271] [drm] RAM width 128bits UNKNOWN
[   10.916413] [drm] amdgpu: 512M of VRAM memory ready
[   10.916627] [drm] amdgpu: 7622M of GTT memory ready.
[   10.916983] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   10.917360] [drm] PCIE GART of 1024M enabled (table at 0x000000F400A00000).
[   10.924770] amdgpu: hwmgr_sw_init smu backed is smu8_smu
[   10.926839] [drm] Found UVD firmware Version: 1.91 Family ID: 11
[   10.927243] [drm] UVD ENC is disabled
[   10.929264] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
[   10.931202] amdgpu: smu version 18.62.00
[   10.932077] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00000 flags=0x0080]
[   10.932595] AMD-Vi: DTE[0]: 7590000000000003
[   10.932770] AMD-Vi: DTE[1]: 0000100103c30002
[   10.932949] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.933163] AMD-Vi: DTE[3]: 0000000000000000
[   10.933338] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00300 flags=0x0080]
[   10.933769] AMD-Vi: DTE[0]: 7590000000000003
[   10.933906] AMD-Vi: DTE[1]: 0000100103c30002
[   10.934038] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.934170] AMD-Vi: DTE[3]: 0000000000000000
[   10.934302] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00440 flags=0x0080]
[   10.934673] AMD-Vi: DTE[0]: 7590000000000003
[   10.934816] AMD-Vi: DTE[1]: 0000100103c30002
[   10.934966] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.935119] AMD-Vi: DTE[3]: 0000000000000000
[   10.935280] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00840 flags=0x0080]
[   10.935727] AMD-Vi: DTE[0]: 7590000000000003
[   10.935881] AMD-Vi: DTE[1]: 0000100103c30002
[   10.936034] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.936188] AMD-Vi: DTE[3]: 0000000000000000
[   10.936342] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00480 flags=0x0080]
[   10.936867] AMD-Vi: DTE[0]: 7590000000000003
[   10.937021] AMD-Vi: DTE[1]: 0000100103c30002
[   10.937175] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.937328] AMD-Vi: DTE[3]: 0000000000000000
[   10.937482] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00200 flags=0x0080]
[   10.937909] AMD-Vi: DTE[0]: 7590000000000003
[   10.938041] AMD-Vi: DTE[1]: 0000100103c30002
[   10.938173] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.938304] AMD-Vi: DTE[3]: 0000000000000000
[   10.938436] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00880 flags=0x0080]
[   10.938834] AMD-Vi: DTE[0]: 7590000000000003
[   10.938988] AMD-Vi: DTE[1]: 0000100103c30002
[   10.939141] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.939294] AMD-Vi: DTE[3]: 0000000000000000
[   10.939448] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea004c0 flags=0x0080]
[   10.939894] AMD-Vi: DTE[0]: 7590000000000003
[   10.940047] AMD-Vi: DTE[1]: 0000100103c30002
[   10.940200] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.940354] AMD-Vi: DTE[3]: 0000000000000000
[   10.940555] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea008c0 flags=0x0080]
[   10.941034] AMD-Vi: DTE[0]: 7590000000000003
[   10.941188] AMD-Vi: DTE[1]: 0000100103c30002
[   10.941341] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.941494] AMD-Vi: DTE[3]: 0000000000000000
[   10.941648] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00800 flags=0x0080]
[   10.942053] AMD-Vi: DTE[0]: 7590000000000003
[   10.942185] AMD-Vi: DTE[1]: 0000100103c30002
[   10.942317] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.942448] AMD-Vi: DTE[3]: 0000000000000000
[   10.942580] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00c00 flags=0x0080]
[   10.943000] AMD-Vi: DTE[0]: 7590000000000003
[   10.943154] AMD-Vi: DTE[1]: 0000100103c30002
[   10.943307] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.943461] AMD-Vi: DTE[3]: 0000000000000000
[   10.943615] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00140 flags=0x0080]
[   10.944047] AMD-Vi: DTE[0]: 7590000000000003
[   10.944200] AMD-Vi: DTE[1]: 0000100103c30002
[   10.944354] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.944551] AMD-Vi: DTE[3]: 0000000000000000
[   10.944711] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00c40 flags=0x0080]
[   10.945196] AMD-Vi: DTE[0]: 7590000000000003
[   10.945349] AMD-Vi: DTE[1]: 0000100103c30002
[   10.945503] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.945656] AMD-Vi: DTE[3]: 0000000000000000
[   10.945810] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00180 flags=0x0080]
[   10.946194] AMD-Vi: DTE[0]: 7590000000000003
[   10.946326] AMD-Vi: DTE[1]: 0000100103c30002
[   10.946457] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.946589] AMD-Vi: DTE[3]: 0000000000000000
[   10.946721] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00580 flags=0x0080]
[   10.947163] AMD-Vi: DTE[0]: 7590000000000003
[   10.947316] AMD-Vi: DTE[1]: 0000100103c30002
[   10.947469] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.947623] AMD-Vi: DTE[3]: 0000000000000000
[   10.947777] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea001c0 flags=0x0080]
[   10.948222] AMD-Vi: DTE[0]: 7590000000000003
[   10.948375] AMD-Vi: DTE[1]: 0000100103c30002
[   10.948586] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.948785] AMD-Vi: DTE[3]: 0000000000000000
[   10.948939] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea005c0 flags=0x0080]
[   10.949384] AMD-Vi: DTE[0]: 7590000000000003
[   10.949537] AMD-Vi: DTE[1]: 0000100103c30002
[   10.949691] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.949840] AMD-Vi: DTE[3]: 0000000000000000
[   10.949972] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00500 flags=0x0080]
[   10.950356] AMD-Vi: DTE[0]: 7590000000000003
[   10.950488] AMD-Vi: DTE[1]: 0000100103c30002
[   10.950620] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.950752] AMD-Vi: DTE[3]: 0000000000000000
[   10.950905] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00900 flags=0x0080]
[   10.951351] AMD-Vi: DTE[0]: 7590000000000003
[   10.951504] AMD-Vi: DTE[1]: 0000100103c30002
[   10.951657] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.951811] AMD-Vi: DTE[3]: 0000000000000000
[   10.951964] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00540 flags=0x0080]
[   10.952396] AMD-Vi: DTE[0]: 7590000000000003
[   10.952596] AMD-Vi: DTE[1]: 0000100103c30002
[   10.952791] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.952944] AMD-Vi: DTE[3]: 0000000000000000
[   10.953098] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00940 flags=0x0080]
[   10.953543] AMD-Vi: DTE[0]: 7590000000000003
[   10.953697] AMD-Vi: DTE[1]: 0000100103c30002
[   10.953847] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.953979] AMD-Vi: DTE[3]: 0000000000000000
[   10.954111] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00640 flags=0x0080]
[   10.954495] AMD-Vi: DTE[0]: 7590000000000003
[   10.954627] AMD-Vi: DTE[1]: 0000100103c30002
[   10.954759] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.954912] AMD-Vi: DTE[3]: 0000000000000000
[   10.955066] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea006c0 flags=0x0080]
[   10.955511] AMD-Vi: DTE[0]: 7590000000000003
[   10.955664] AMD-Vi: DTE[1]: 0000100103c30002
[   10.955818] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.955971] AMD-Vi: DTE[3]: 0000000000000000
[   10.956125] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00a00 flags=0x0080]
[   10.956604] AMD-Vi: DTE[0]: 7590000000000003
[   10.956802] AMD-Vi: DTE[1]: 0000100103c30002
[   10.956955] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.957108] AMD-Vi: DTE[3]: 0000000000000000
[   10.957262] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00340 flags=0x0080]
[   10.957707] AMD-Vi: DTE[0]: 7590000000000003
[   10.957856] AMD-Vi: DTE[1]: 0000100103c30002
[   10.957988] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.958120] AMD-Vi: DTE[3]: 0000000000000000
[   10.958252] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00980 flags=0x0080]
[   10.958636] AMD-Vi: DTE[0]: 7590000000000003
[   10.958768] AMD-Vi: DTE[1]: 0000100103c30002
[   10.958921] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.959074] AMD-Vi: DTE[3]: 0000000000000000
[   10.959228] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00c80 flags=0x0080]
[   10.959673] AMD-Vi: DTE[0]: 7590000000000003
[   10.959827] AMD-Vi: DTE[1]: 0000100103c30002
[   10.959980] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.960133] AMD-Vi: DTE[3]: 0000000000000000
[   10.960291] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00cc0 flags=0x0080]
[   10.960813] AMD-Vi: DTE[0]: 7590000000000003
[   10.960971] AMD-Vi: DTE[1]: 0000100103c30002
[   10.961124] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.961278] AMD-Vi: DTE[3]: 0000000000000000
[   10.961431] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea009c0 flags=0x0080]
[   10.961872] AMD-Vi: DTE[0]: 7590000000000003
[   10.962003] AMD-Vi: DTE[1]: 0000100103c30002
[   10.962135] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.962267] AMD-Vi: DTE[3]: 0000000000000000
[   10.962399] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00d00 flags=0x0080]
[   10.962783] AMD-Vi: DTE[0]: 7590000000000003
[   10.962936] AMD-Vi: DTE[1]: 0000100103c30002
[   10.963090] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.963243] AMD-Vi: DTE[3]: 0000000000000000
[   10.963397] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00380 flags=0x0080]
[   10.963829] AMD-Vi: DTE[0]: 7590000000000003
[   10.963963] AMD-Vi: DTE[1]: 0000100103c30002
[   10.964095] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.964227] AMD-Vi: DTE[3]: 0000000000000000
[   10.964359] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea003c0 flags=0x0080]
[   10.964824] AMD-Vi: DTE[0]: 7590000000000003
[   10.964969] AMD-Vi: DTE[1]: 0000100103c30002
[   10.965123] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.965276] AMD-Vi: DTE[3]: 0000000000000000
[   10.965430] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00700 flags=0x0080]
[   10.965875] AMD-Vi: DTE[0]: 7590000000000003
[   10.966028] AMD-Vi: DTE[1]: 0000100103c30002
[   10.966182] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.966335] AMD-Vi: DTE[3]: 0000000000000000
[   10.966489] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00740 flags=0x0080]
[   10.966911] AMD-Vi: DTE[0]: 7590000000000003
[   10.967042] AMD-Vi: DTE[1]: 0000100103c30002
[   10.967174] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.967306] AMD-Vi: DTE[3]: 0000000000000000
[   10.967438] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00a40 flags=0x0080]
[   10.967827] AMD-Vi: DTE[0]: 7590000000000003
[   10.967981] AMD-Vi: DTE[1]: 0000100103c30002
[   10.968134] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.968287] AMD-Vi: DTE[3]: 0000000000000000
[   10.968441] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00d40 flags=0x0080]
[   10.968966] AMD-Vi: DTE[0]: 7590000000000003
[   10.969119] AMD-Vi: DTE[1]: 0000100103c30002
[   10.969273] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.969426] AMD-Vi: DTE[3]: 0000000000000000
[   10.969580] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00d80 flags=0x0080]
[   10.970002] AMD-Vi: DTE[0]: 7590000000000003
[   10.970134] AMD-Vi: DTE[1]: 0000100103c30002
[   10.970265] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.970397] AMD-Vi: DTE[3]: 0000000000000000
[   10.970529] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00dc0 flags=0x0080]
[   10.970932] AMD-Vi: DTE[0]: 7590000000000003
[   10.971085] AMD-Vi: DTE[1]: 0000100103c30002
[   10.971239] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.971392] AMD-Vi: DTE[3]: 0000000000000000
[   10.971546] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01000 flags=0x0080]
[   10.971978] AMD-Vi: DTE[0]: 7590000000000003
[   10.972132] AMD-Vi: DTE[1]: 0000100103c30002
[   10.972285] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.972438] AMD-Vi: DTE[3]: 0000000000000000
[   10.972638] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00a80 flags=0x0080]
[   10.973122] AMD-Vi: DTE[0]: 7590000000000003
[   10.973275] AMD-Vi: DTE[1]: 0000100103c30002
[   10.973428] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.973582] AMD-Vi: DTE[3]: 0000000000000000
[   10.973735] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00ac0 flags=0x0080]
[   10.974137] AMD-Vi: DTE[0]: 7590000000000003
[   10.974274] AMD-Vi: DTE[1]: 0000100103c30002
[   10.974406] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.974538] AMD-Vi: DTE[3]: 0000000000000000
[   10.974670] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00e00 flags=0x0080]
[   10.975094] AMD-Vi: DTE[0]: 7590000000000003
[   10.975248] AMD-Vi: DTE[1]: 0000100103c30002
[   10.975401] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.975554] AMD-Vi: DTE[3]: 0000000000000000
[   10.975708] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00e40 flags=0x0080]
[   10.976140] AMD-Vi: DTE[0]: 7590000000000003
[   10.976298] AMD-Vi: DTE[1]: 0000100103c30002
[   10.976451] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.976655] AMD-Vi: DTE[3]: 0000000000000000
[   10.976853] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00780 flags=0x0080]
[   10.977298] AMD-Vi: DTE[0]: 7590000000000003
[   10.977451] AMD-Vi: DTE[1]: 0000100103c30002
[   10.977605] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.977758] AMD-Vi: DTE[3]: 0000000000000000
[   10.977906] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea007c0 flags=0x0080]
[   10.978290] AMD-Vi: DTE[0]: 7590000000000003
[   10.978422] AMD-Vi: DTE[1]: 0000100103c30002
[   10.978553] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.978685] AMD-Vi: DTE[3]: 0000000000000000
[   10.978819] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00b00 flags=0x0080]
[   10.979251] AMD-Vi: DTE[0]: 7590000000000003
[   10.979404] AMD-Vi: DTE[1]: 0000100103c30002
[   10.979562] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.979715] AMD-Vi: DTE[3]: 0000000000000000
[   10.979869] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00b40 flags=0x0080]
[   10.980314] AMD-Vi: DTE[0]: 7590000000000003
[   10.980511] AMD-Vi: DTE[1]: 0000100103c30002
[   10.980668] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.980862] AMD-Vi: DTE[3]: 0000000000000000
[   10.981016] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00b80 flags=0x0080]
[   10.981448] AMD-Vi: DTE[0]: 7590000000000003
[   10.981601] AMD-Vi: DTE[1]: 0000100103c30002
[   10.981755] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.981904] AMD-Vi: DTE[3]: 0000000000000000
[   10.982036] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00e80 flags=0x0080]
[   10.982420] AMD-Vi: DTE[0]: 7590000000000003
[   10.982552] AMD-Vi: DTE[1]: 0000100103c30002
[   10.982683] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.982815] AMD-Vi: DTE[3]: 0000000000000000
[   10.982973] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00ec0 flags=0x0080]
[   10.983418] AMD-Vi: DTE[0]: 7590000000000003
[   10.983572] AMD-Vi: DTE[1]: 0000100103c30002
[   10.983725] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.983878] AMD-Vi: DTE[3]: 0000000000000000
[   10.984032] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00bc0 flags=0x0080]
[   10.984508] AMD-Vi: DTE[0]: 7590000000000003
[   10.984665] AMD-Vi: DTE[1]: 0000100103c30002
[   10.984861] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.985014] AMD-Vi: DTE[3]: 0000000000000000
[   10.985168] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00f00 flags=0x0080]
[   10.985600] AMD-Vi: DTE[0]: 7590000000000003
[   10.985757] AMD-Vi: DTE[1]: 0000100103c30002
[   10.985907] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.986039] AMD-Vi: DTE[3]: 0000000000000000
[   10.986171] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00f40 flags=0x0080]
[   10.986555] AMD-Vi: DTE[0]: 7590000000000003
[   10.986686] AMD-Vi: DTE[1]: 0000100103c30002
[   10.986818] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.986972] AMD-Vi: DTE[3]: 0000000000000000
[   10.987125] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00f80 flags=0x0080]
[   10.987571] AMD-Vi: DTE[0]: 7590000000000003
[   10.987724] AMD-Vi: DTE[1]: 0000100103c30002
[   10.987877] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.988031] AMD-Vi: DTE[3]: 0000000000000000
[   10.988188] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea010c0 flags=0x0080]
[   10.988681] AMD-Vi: DTE[0]: 7590000000000003
[   10.988878] AMD-Vi: DTE[1]: 0000100103c30002
[   10.989031] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.989184] AMD-Vi: DTE[3]: 0000000000000000
[   10.989338] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01080 flags=0x0080]
[   10.989783] AMD-Vi: DTE[0]: 7590000000000003
[   10.989930] AMD-Vi: DTE[1]: 0000100103c30002
[   10.990062] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.990194] AMD-Vi: DTE[3]: 0000000000000000
[   10.990326] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01100 flags=0x0080]
[   10.990709] AMD-Vi: DTE[0]: 7590000000000003
[   10.990842] AMD-Vi: DTE[1]: 0000100103c30002
[   10.990996] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.991149] AMD-Vi: DTE[3]: 0000000000000000
[   10.991303] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01040 flags=0x0080]
[   10.991735] AMD-Vi: DTE[0]: 7590000000000003
[   10.991888] AMD-Vi: DTE[1]: 0000100103c30002
[   10.992021] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.992153] AMD-Vi: DTE[3]: 0000000000000000
[   10.992285] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00040 flags=0x0080]
[   10.992716] AMD-Vi: DTE[0]: 7590000000000003
[   10.992892] AMD-Vi: DTE[1]: 0000100103c30002
[   10.993039] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.993192] AMD-Vi: DTE[3]: 0000000000000000
[   10.993346] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00240 flags=0x0080]
[   10.993791] AMD-Vi: DTE[0]: 7590000000000003
[   10.993944] AMD-Vi: DTE[1]: 0000100103c30002
[   10.994098] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.994251] AMD-Vi: DTE[3]: 0000000000000000
[   10.994405] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00080 flags=0x0080]
[   10.994837] AMD-Vi: DTE[0]: 7590000000000003
[   10.994977] AMD-Vi: DTE[1]: 0000100103c30002
[   10.995109] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.995241] AMD-Vi: DTE[3]: 0000000000000000
[   10.995373] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00280 flags=0x0080]
[   10.995756] AMD-Vi: DTE[0]: 7590000000000003
[   10.995896] AMD-Vi: DTE[1]: 0000100103c30002
[   10.996049] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.996202] AMD-Vi: DTE[3]: 0000000000000000
[   10.996356] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea000c0 flags=0x0080]
[   10.996878] AMD-Vi: DTE[0]: 7590000000000003
[   10.997031] AMD-Vi: DTE[1]: 0000100103c30002
[   10.997185] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.997338] AMD-Vi: DTE[3]: 0000000000000000
[   10.997492] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea002c0 flags=0x0080]
[   10.997933] AMD-Vi: DTE[0]: 7590000000000003
[   10.998065] AMD-Vi: DTE[1]: 0000100103c30002
[   10.998197] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.998329] AMD-Vi: DTE[3]: 0000000000000000
[   10.998461] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00400 flags=0x0080]
[   10.998845] AMD-Vi: DTE[0]: 7590000000000003
[   10.998998] AMD-Vi: DTE[1]: 0000100103c30002
[   10.999152] AMD-Vi: DTE[2]: 200000010ebcc013
[   10.999305] AMD-Vi: DTE[3]: 0000000000000000
[   10.999459] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01440 flags=0x0080]
[   10.999904] AMD-Vi: DTE[0]: 7590000000000003
[   11.000058] AMD-Vi: DTE[1]: 0000100103c30002
[   11.000211] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.000364] AMD-Vi: DTE[3]: 0000000000000000
[   11.000563] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01500 flags=0x0080]
[   11.001049] AMD-Vi: DTE[0]: 7590000000000003
[   11.001202] AMD-Vi: DTE[1]: 0000100103c30002
[   11.001355] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.001509] AMD-Vi: DTE[3]: 0000000000000000
[   11.001663] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea011c0 flags=0x0080]
[   11.002082] AMD-Vi: DTE[0]: 7590000000000003
[   11.002213] AMD-Vi: DTE[1]: 0000100103c30002
[   11.002345] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.002477] AMD-Vi: DTE[3]: 0000000000000000
[   11.002609] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01580 flags=0x0080]
[   11.003001] AMD-Vi: DTE[0]: 7590000000000003
[   11.003155] AMD-Vi: DTE[1]: 0000100103c30002
[   11.003308] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.003462] AMD-Vi: DTE[3]: 0000000000000000
[   11.003615] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01400 flags=0x0080]
[   11.004031] AMD-Vi: DTE[0]: 7590000000000003
[   11.004163] AMD-Vi: DTE[1]: 0000100103c30002
[   11.004295] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.004426] AMD-Vi: DTE[3]: 0000000000000000
[   11.004604] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01140 flags=0x0080]
[   11.005030] AMD-Vi: DTE[0]: 7590000000000003
[   11.005184] AMD-Vi: DTE[1]: 0000100103c30002
[   11.005337] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.005490] AMD-Vi: DTE[3]: 0000000000000000
[   11.005648] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01800 flags=0x0080]
[   11.006093] AMD-Vi: DTE[0]: 7590000000000003
[   11.006246] AMD-Vi: DTE[1]: 0000100103c30002
[   11.006400] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.006554] AMD-Vi: DTE[3]: 0000000000000000
[   11.006707] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01480 flags=0x0080]
[   11.007121] AMD-Vi: DTE[0]: 7590000000000003
[   11.007253] AMD-Vi: DTE[1]: 0000100103c30002
[   11.007385] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.007516] AMD-Vi: DTE[3]: 0000000000000000
[   11.007648] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01180 flags=0x0080]
[   11.008060] AMD-Vi: DTE[0]: 7590000000000003
[   11.008213] AMD-Vi: DTE[1]: 0000100103c30002
[   11.008366] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.008563] AMD-Vi: DTE[3]: 0000000000000000
[   11.008727] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea014c0 flags=0x0080]
[   11.009211] AMD-Vi: DTE[0]: 7590000000000003
[   11.009364] AMD-Vi: DTE[1]: 0000100103c30002
[   11.009517] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.009671] AMD-Vi: DTE[3]: 0000000000000000
[   11.009824] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01840 flags=0x0080]
[   11.010210] AMD-Vi: DTE[0]: 7590000000000003
[   11.010342] AMD-Vi: DTE[1]: 0000100103c30002
[   11.010474] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.010605] AMD-Vi: DTE[3]: 0000000000000000
[   11.010738] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01880 flags=0x0080]
[   11.011162] AMD-Vi: DTE[0]: 7590000000000003
[   11.011316] AMD-Vi: DTE[1]: 0000100103c30002
[   11.011469] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.011622] AMD-Vi: DTE[3]: 0000000000000000
[   11.011780] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01540 flags=0x0080]
[   11.012225] AMD-Vi: DTE[0]: 7590000000000003
[   11.012379] AMD-Vi: DTE[1]: 0000100103c30002
[   11.012580] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.012774] AMD-Vi: DTE[3]: 0000000000000000
[   11.012927] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea015c0 flags=0x0080]
[   11.013373] AMD-Vi: DTE[0]: 7590000000000003
[   11.013526] AMD-Vi: DTE[1]: 0000100103c30002
[   11.013679] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.013833] AMD-Vi: DTE[3]: 0000000000000000
[   11.013980] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01200 flags=0x0080]
[   11.014364] AMD-Vi: DTE[0]: 7590000000000003
[   11.014496] AMD-Vi: DTE[1]: 0000100103c30002
[   11.014627] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.014759] AMD-Vi: DTE[3]: 0000000000000000
[   11.014894] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00600 flags=0x0080]
[   11.015326] AMD-Vi: DTE[0]: 7590000000000003
[   11.015479] AMD-Vi: DTE[1]: 0000100103c30002
[   11.015633] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.015786] AMD-Vi: DTE[3]: 0000000000000000
[   11.015940] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01240 flags=0x0080]
[   11.016311] AMD-Vi: DTE[0]: 7590000000000003
[   11.016443] AMD-Vi: DTE[1]: 0000100103c30002
[   11.016626] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.016803] AMD-Vi: DTE[3]: 0000000000000000
[   11.016935] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00100 flags=0x0080]
[   11.017380] AMD-Vi: DTE[0]: 7590000000000003
[   11.017534] AMD-Vi: DTE[1]: 0000100103c30002
[   11.017687] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.017841] AMD-Vi: DTE[3]: 0000000000000000
[   11.017994] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00680 flags=0x0080]
[   11.018440] AMD-Vi: DTE[0]: 7590000000000003
[   11.018593] AMD-Vi: DTE[1]: 0000100103c30002
[   11.018746] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.018904] AMD-Vi: DTE[3]: 0000000000000000
[   11.019042] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01280 flags=0x0080]
[   11.019426] AMD-Vi: DTE[0]: 7590000000000003
[   11.019557] AMD-Vi: DTE[1]: 0000100103c30002
[   11.019689] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.019821] AMD-Vi: DTE[3]: 0000000000000000
[   11.019964] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02000 flags=0x0080]
[   11.020410] AMD-Vi: DTE[0]: 7590000000000003
[   11.020610] AMD-Vi: DTE[1]: 0000100103c30002
[   11.020805] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.020958] AMD-Vi: DTE[3]: 0000000000000000
[   11.021112] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea00fc0 flags=0x0080]
[   11.021544] AMD-Vi: DTE[0]: 7590000000000003
[   11.021697] AMD-Vi: DTE[1]: 0000100103c30002
[   11.021851] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.021996] AMD-Vi: DTE[3]: 0000000000000000
[   11.022128] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01dc0 flags=0x0080]
[   11.022512] AMD-Vi: DTE[0]: 7590000000000003
[   11.022644] AMD-Vi: DTE[1]: 0000100103c30002
[   11.022776] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.022911] AMD-Vi: DTE[3]: 0000000000000000
[   11.023064] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01c40 flags=0x0080]
[   11.023510] AMD-Vi: DTE[0]: 7590000000000003
[   11.023663] AMD-Vi: DTE[1]: 0000100103c30002
[   11.023817] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.023970] AMD-Vi: DTE[3]: 0000000000000000
[   11.024124] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01340 flags=0x0080]
[   11.024602] AMD-Vi: DTE[0]: 7590000000000003
[   11.024801] AMD-Vi: DTE[1]: 0000100103c30002
[   11.024954] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.025108] AMD-Vi: DTE[3]: 0000000000000000
[   11.025261] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01d00 flags=0x0080]
[   11.025697] AMD-Vi: DTE[0]: 7590000000000003
[   11.025854] AMD-Vi: DTE[1]: 0000100103c30002
[   11.026008] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.026144] AMD-Vi: DTE[3]: 0000000000000000
[   11.026276] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02040 flags=0x0080]
[   11.026660] AMD-Vi: DTE[0]: 7590000000000003
[   11.026793] AMD-Vi: DTE[1]: 0000100103c30002
[   11.026929] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.027082] AMD-Vi: DTE[3]: 0000000000000000
[   11.027236] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea013c0 flags=0x0080]
[   11.027668] AMD-Vi: DTE[0]: 7590000000000003
[   11.027825] AMD-Vi: DTE[1]: 0000100103c30002
[   11.027979] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.028132] AMD-Vi: DTE[3]: 0000000000000000
[   11.028286] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01600 flags=0x0080]
[   11.028802] AMD-Vi: DTE[0]: 7590000000000003
[   11.028956] AMD-Vi: DTE[1]: 0000100103c30002
[   11.029109] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.029263] AMD-Vi: DTE[3]: 0000000000000000
[   11.029420] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea018c0 flags=0x0080]
[   11.029866] AMD-Vi: DTE[0]: 7590000000000003
[   11.030019] AMD-Vi: DTE[1]: 0000100103c30002
[   11.030172] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.030326] AMD-Vi: DTE[3]: 0000000000000000
[   11.030479] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01900 flags=0x0080]
[   11.030925] AMD-Vi: DTE[0]: 7590000000000003
[   11.031062] AMD-Vi: DTE[1]: 0000100103c30002
[   11.031194] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.031326] AMD-Vi: DTE[3]: 0000000000000000
[   11.031458] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01940 flags=0x0080]
[   11.031842] AMD-Vi: DTE[0]: 7590000000000003
[   11.031985] AMD-Vi: DTE[1]: 0000100103c30002
[   11.032138] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.032292] AMD-Vi: DTE[3]: 0000000000000000
[   11.032445] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01980 flags=0x0080]
[   11.032970] AMD-Vi: DTE[0]: 7590000000000003
[   11.033124] AMD-Vi: DTE[1]: 0000100103c30002
[   11.033277] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.033431] AMD-Vi: DTE[3]: 0000000000000000
[   11.033584] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea019c0 flags=0x0080]
[   11.034023] AMD-Vi: DTE[0]: 7590000000000003
[   11.034155] AMD-Vi: DTE[1]: 0000100103c30002
[   11.034287] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.034419] AMD-Vi: DTE[3]: 0000000000000000
[   11.034551] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01740 flags=0x0080]
[   11.034938] AMD-Vi: DTE[0]: 7590000000000003
[   11.035091] AMD-Vi: DTE[1]: 0000100103c30002
[   11.035244] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.035398] AMD-Vi: DTE[3]: 0000000000000000
[   11.035551] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea017c0 flags=0x0080]
[   11.035983] AMD-Vi: DTE[0]: 7590000000000003
[   11.036115] AMD-Vi: DTE[1]: 0000100103c30002
[   11.036247] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.036379] AMD-Vi: DTE[3]: 0000000000000000
[   11.036560] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01680 flags=0x0080]
[   11.036992] AMD-Vi: DTE[0]: 7590000000000003
[   11.037145] AMD-Vi: DTE[1]: 0000100103c30002
[   11.037299] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.037452] AMD-Vi: DTE[3]: 0000000000000000
[   11.037610] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01cc0 flags=0x0080]
[   11.038055] AMD-Vi: DTE[0]: 7590000000000003
[   11.038208] AMD-Vi: DTE[1]: 0000100103c30002
[   11.038361] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.038515] AMD-Vi: DTE[3]: 0000000000000000
[   11.038673] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea016c0 flags=0x0080]
[   11.039099] AMD-Vi: DTE[0]: 7590000000000003
[   11.039230] AMD-Vi: DTE[1]: 0000100103c30002
[   11.039362] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.039494] AMD-Vi: DTE[3]: 0000000000000000
[   11.039626] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01d80 flags=0x0080]
[   11.040022] AMD-Vi: DTE[0]: 7590000000000003
[   11.040176] AMD-Vi: DTE[1]: 0000100103c30002
[   11.040329] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.040626] AMD-Vi: DTE[3]: 0000000000000000
[   11.040783] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01640 flags=0x0080]
[   11.041268] AMD-Vi: DTE[0]: 7590000000000003
[   11.041421] AMD-Vi: DTE[1]: 0000100103c30002
[   11.041575] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.041728] AMD-Vi: DTE[3]: 0000000000000000
[   11.041882] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01a40 flags=0x0080]
[   11.042280] AMD-Vi: DTE[0]: 7590000000000003
[   11.042412] AMD-Vi: DTE[1]: 0000100103c30002
[   11.042544] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.042676] AMD-Vi: DTE[3]: 0000000000000000
[   11.042808] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01ac0 flags=0x0080]
[   11.043235] AMD-Vi: DTE[0]: 7590000000000003
[   11.043388] AMD-Vi: DTE[1]: 0000100103c30002
[   11.043541] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.043695] AMD-Vi: DTE[3]: 0000000000000000
[   11.043848] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01a80 flags=0x0080]
[   11.044280] AMD-Vi: DTE[0]: 7590000000000003
[   11.044434] AMD-Vi: DTE[1]: 0000100103c30002
[   11.044650] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.044845] AMD-Vi: DTE[3]: 0000000000000000
[   11.044999] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01b00 flags=0x0080]
[   11.045444] AMD-Vi: DTE[0]: 7590000000000003
[   11.045597] AMD-Vi: DTE[1]: 0000100103c30002
[   11.045751] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.045904] AMD-Vi: DTE[3]: 0000000000000000
[   11.046049] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01b40 flags=0x0080]
[   11.046433] AMD-Vi: DTE[0]: 7590000000000003
[   11.046565] AMD-Vi: DTE[1]: 0000100103c30002
[   11.046697] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.046829] AMD-Vi: DTE[3]: 0000000000000000
[   11.046965] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01b80 flags=0x0080]
[   11.047410] AMD-Vi: DTE[0]: 7590000000000003
[   11.047563] AMD-Vi: DTE[1]: 0000100103c30002
[   11.047717] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.047870] AMD-Vi: DTE[3]: 0000000000000000
[   11.048028] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01bc0 flags=0x0080]
[   11.048518] AMD-Vi: DTE[0]: 7590000000000003
[   11.048675] AMD-Vi: DTE[1]: 0000100103c30002
[   11.048870] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.049023] AMD-Vi: DTE[3]: 0000000000000000
[   11.049177] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01e00 flags=0x0080]
[   11.049622] AMD-Vi: DTE[0]: 7590000000000003
[   11.049776] AMD-Vi: DTE[1]: 0000100103c30002
[   11.049929] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.050071] AMD-Vi: DTE[3]: 0000000000000000
[   11.050203] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02080 flags=0x0080]
[   11.050587] AMD-Vi: DTE[0]: 7590000000000003
[   11.050719] AMD-Vi: DTE[1]: 0000100103c30002
[   11.050851] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.050989] AMD-Vi: DTE[3]: 0000000000000000
[   11.051147] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01780 flags=0x0080]
[   11.051592] AMD-Vi: DTE[0]: 7590000000000003
[   11.051745] AMD-Vi: DTE[1]: 0000100103c30002
[   11.051899] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.052052] AMD-Vi: DTE[3]: 0000000000000000
[   11.052210] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea012c0 flags=0x0080]
[   11.052704] AMD-Vi: DTE[0]: 7590000000000003
[   11.052901] AMD-Vi: DTE[1]: 0000100103c30002
[   11.053054] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.053208] AMD-Vi: DTE[3]: 0000000000000000
[   11.053361] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01300 flags=0x0080]
[   11.053807] AMD-Vi: DTE[0]: 7590000000000003
[   11.053960] AMD-Vi: DTE[1]: 0000100103c30002
[   11.054099] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.054231] AMD-Vi: DTE[3]: 0000000000000000
[   11.054363] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01d40 flags=0x0080]
[   11.054747] AMD-Vi: DTE[0]: 7590000000000003
[   11.054879] AMD-Vi: DTE[1]: 0000100103c30002
[   11.055021] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.055174] AMD-Vi: DTE[3]: 0000000000000000
[   11.055328] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01c80 flags=0x0080]
[   11.055760] AMD-Vi: DTE[0]: 7590000000000003
[   11.055913] AMD-Vi: DTE[1]: 0000100103c30002
[   11.056060] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.056192] AMD-Vi: DTE[3]: 0000000000000000
[   11.056324] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01380 flags=0x0080]
[   11.056785] AMD-Vi: DTE[0]: 7590000000000003
[   11.056917] AMD-Vi: DTE[1]: 0000100103c30002
[   11.057056] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.057213] AMD-Vi: DTE[3]: 0000000000000000
[   11.057366] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01e40 flags=0x0080]
[   11.057798] AMD-Vi: DTE[0]: 7590000000000003
[   11.057952] AMD-Vi: DTE[1]: 0000100103c30002
[   11.058105] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.058259] AMD-Vi: DTE[3]: 0000000000000000
[   11.058417] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01e80 flags=0x0080]
[   11.058862] AMD-Vi: DTE[0]: 7590000000000003
[   11.059015] AMD-Vi: DTE[1]: 0000100103c30002
[   11.059168] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.059322] AMD-Vi: DTE[3]: 0000000000000000
[   11.059476] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01ec0 flags=0x0080]
[   11.059908] AMD-Vi: DTE[0]: 7590000000000003
[   11.060055] AMD-Vi: DTE[1]: 0000100103c30002
[   11.060187] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.060319] AMD-Vi: DTE[3]: 0000000000000000
[   11.060451] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01f00 flags=0x0080]
[   11.060918] AMD-Vi: DTE[0]: 7590000000000003
[   11.061055] AMD-Vi: DTE[1]: 0000100103c30002
[   11.061209] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.061362] AMD-Vi: DTE[3]: 0000000000000000
[   11.061516] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea020c0 flags=0x0080]
[   11.061948] AMD-Vi: DTE[0]: 7590000000000003
[   11.062101] AMD-Vi: DTE[1]: 0000100103c30002
[   11.062255] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.062408] AMD-Vi: DTE[3]: 0000000000000000
[   11.062562] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02100 flags=0x0080]
[   11.062994] AMD-Vi: DTE[0]: 7590000000000003
[   11.063130] AMD-Vi: DTE[1]: 0000100103c30002
[   11.063262] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.063394] AMD-Vi: DTE[3]: 0000000000000000
[   11.063530] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02140 flags=0x0080]
[   11.063901] AMD-Vi: DTE[0]: 7590000000000003
[   11.064043] AMD-Vi: DTE[1]: 0000100103c30002
[   11.064197] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.064350] AMD-Vi: DTE[3]: 0000000000000000
[   11.064551] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02180 flags=0x0080]
[   11.065032] AMD-Vi: DTE[0]: 7590000000000003
[   11.065185] AMD-Vi: DTE[1]: 0000100103c30002
[   11.065338] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.065492] AMD-Vi: DTE[3]: 0000000000000000
[   11.065645] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea021c0 flags=0x0080]
[   11.066072] AMD-Vi: DTE[0]: 7590000000000003
[   11.066204] AMD-Vi: DTE[1]: 0000100103c30002
[   11.066335] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.066467] AMD-Vi: DTE[3]: 0000000000000000
[   11.066599] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02400 flags=0x0080]
[   11.066984] AMD-Vi: DTE[0]: 7590000000000003
[   11.067138] AMD-Vi: DTE[1]: 0000100103c30002
[   11.067291] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.067444] AMD-Vi: DTE[3]: 0000000000000000
[   11.067602] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea025c0 flags=0x0080]
[   11.068047] AMD-Vi: DTE[0]: 7590000000000003
[   11.068201] AMD-Vi: DTE[1]: 0000100103c30002
[   11.068354] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.068553] AMD-Vi: DTE[3]: 0000000000000000
[   11.068710] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02440 flags=0x0080]
[   11.069195] AMD-Vi: DTE[0]: 7590000000000003
[   11.069349] AMD-Vi: DTE[1]: 0000100103c30002
[   11.069502] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.069655] AMD-Vi: DTE[3]: 0000000000000000
[   11.069809] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02480 flags=0x0080]
[   11.070213] AMD-Vi: DTE[0]: 7590000000000003
[   11.070345] AMD-Vi: DTE[1]: 0000100103c30002
[   11.070476] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.070608] AMD-Vi: DTE[3]: 0000000000000000
[   11.070740] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea024c0 flags=0x0080]
[   11.071147] AMD-Vi: DTE[0]: 7590000000000003
[   11.071300] AMD-Vi: DTE[1]: 0000100103c30002
[   11.071454] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.071607] AMD-Vi: DTE[3]: 0000000000000000
[   11.071761] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02800 flags=0x0080]
[   11.072193] AMD-Vi: DTE[0]: 7590000000000003
[   11.072346] AMD-Vi: DTE[1]: 0000100103c30002
[   11.072544] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.072701] AMD-Vi: DTE[3]: 0000000000000000
[   11.072897] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01f40 flags=0x0080]
[   11.073342] AMD-Vi: DTE[0]: 7590000000000003
[   11.073495] AMD-Vi: DTE[1]: 0000100103c30002
[   11.073649] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.073802] AMD-Vi: DTE[3]: 0000000000000000
[   11.073955] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02840 flags=0x0080]
[   11.074340] AMD-Vi: DTE[0]: 7590000000000003
[   11.074472] AMD-Vi: DTE[1]: 0000100103c30002
[   11.074604] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.074735] AMD-Vi: DTE[3]: 0000000000000000
[   11.074867] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01f80 flags=0x0080]
[   11.075294] AMD-Vi: DTE[0]: 7590000000000003
[   11.075447] AMD-Vi: DTE[1]: 0000100103c30002
[   11.075600] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.075754] AMD-Vi: DTE[3]: 0000000000000000
[   11.075907] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02600 flags=0x0080]
[   11.076340] AMD-Vi: DTE[0]: 7590000000000003
[   11.076538] AMD-Vi: DTE[1]: 0000100103c30002
[   11.076694] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.076892] AMD-Vi: DTE[3]: 0000000000000000
[   11.077045] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02380 flags=0x0080]
[   11.077491] AMD-Vi: DTE[0]: 7590000000000003
[   11.077644] AMD-Vi: DTE[1]: 0000100103c30002
[   11.077797] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.077951] AMD-Vi: DTE[3]: 0000000000000000
[   11.078098] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02300 flags=0x0080]
[   11.078482] AMD-Vi: DTE[0]: 7590000000000003
[   11.078614] AMD-Vi: DTE[1]: 0000100103c30002
[   11.078745] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.078877] AMD-Vi: DTE[3]: 0000000000000000
[   11.079011] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02740 flags=0x0080]
[   11.079443] AMD-Vi: DTE[0]: 7590000000000003
[   11.079597] AMD-Vi: DTE[1]: 0000100103c30002
[   11.079750] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.079904] AMD-Vi: DTE[3]: 0000000000000000
[   11.080062] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02340 flags=0x0080]
[   11.080552] AMD-Vi: DTE[0]: 7590000000000003
[   11.080709] AMD-Vi: DTE[1]: 0000100103c30002
[   11.080904] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.081057] AMD-Vi: DTE[3]: 0000000000000000
[   11.081211] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02280 flags=0x0080]
[   11.081656] AMD-Vi: DTE[0]: 7590000000000003
[   11.081810] AMD-Vi: DTE[1]: 0000100103c30002
[   11.081963] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.082109] AMD-Vi: DTE[3]: 0000000000000000
[   11.082241] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02640 flags=0x0080]
[   11.082625] AMD-Vi: DTE[0]: 7590000000000003
[   11.082757] AMD-Vi: DTE[1]: 0000100103c30002
[   11.082888] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.083023] AMD-Vi: DTE[3]: 0000000000000000
[   11.083181] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea027c0 flags=0x0080]
[   11.083626] AMD-Vi: DTE[0]: 7590000000000003
[   11.083779] AMD-Vi: DTE[1]: 0000100103c30002
[   11.083932] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.084086] AMD-Vi: DTE[3]: 0000000000000000
[   11.084244] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea023c0 flags=0x0080]
[   11.084730] AMD-Vi: DTE[0]: 7590000000000003
[   11.084922] AMD-Vi: DTE[1]: 0000100103c30002
[   11.085076] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.085229] AMD-Vi: DTE[3]: 0000000000000000
[   11.085383] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02680 flags=0x0080]
[   11.085828] AMD-Vi: DTE[0]: 7590000000000003
[   11.085981] AMD-Vi: DTE[1]: 0000100103c30002
[   11.086126] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.086257] AMD-Vi: DTE[3]: 0000000000000000
[   11.086389] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02240 flags=0x0080]
[   11.086774] AMD-Vi: DTE[0]: 7590000000000003
[   11.086905] AMD-Vi: DTE[1]: 0000100103c30002
[   11.087041] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.087195] AMD-Vi: DTE[3]: 0000000000000000
[   11.087348] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea022c0 flags=0x0080]
[   11.087780] AMD-Vi: DTE[0]: 7590000000000003
[   11.087934] AMD-Vi: DTE[1]: 0000100103c30002
[   11.088086] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.088218] AMD-Vi: DTE[3]: 0000000000000000
[   11.088350] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea026c0 flags=0x0080]
[   11.088816] AMD-Vi: DTE[0]: 7590000000000003
[   11.088948] AMD-Vi: DTE[1]: 0000100103c30002
[   11.089087] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.089240] AMD-Vi: DTE[3]: 0000000000000000
[   11.089394] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02780 flags=0x0080]
[   11.089839] AMD-Vi: DTE[0]: 7590000000000003
[   11.089993] AMD-Vi: DTE[1]: 0000100103c30002
[   11.090146] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.090300] AMD-Vi: DTE[3]: 0000000000000000
[   11.090457] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02700 flags=0x0080]
[   11.090902] AMD-Vi: DTE[0]: 7590000000000003
[   11.091056] AMD-Vi: DTE[1]: 0000100103c30002
[   11.091191] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.091323] AMD-Vi: DTE[3]: 0000000000000000
[   11.091455] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01fc0 flags=0x0080]
[   11.091839] AMD-Vi: DTE[0]: 7590000000000003
[   11.091970] AMD-Vi: DTE[1]: 0000100103c30002
[   11.092116] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.092269] AMD-Vi: DTE[3]: 0000000000000000
[   11.092427] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02200 flags=0x0080]
[   11.092941] AMD-Vi: DTE[0]: 7590000000000003
[   11.093094] AMD-Vi: DTE[1]: 0000100103c30002
[   11.093247] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.093401] AMD-Vi: DTE[3]: 0000000000000000
[   11.093555] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02500 flags=0x0080]
[   11.094000] AMD-Vi: DTE[0]: 7590000000000003
[   11.094144] AMD-Vi: DTE[1]: 0000100103c30002
[   11.094276] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.094408] AMD-Vi: DTE[3]: 0000000000000000
[   11.094540] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02540 flags=0x0080]
[   11.094924] AMD-Vi: DTE[0]: 7590000000000003
[   11.095061] AMD-Vi: DTE[1]: 0000100103c30002
[   11.095214] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.095367] AMD-Vi: DTE[3]: 0000000000000000
[   11.095525] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea02580 flags=0x0080]
[   11.095970] AMD-Vi: DTE[0]: 7590000000000003
[   11.096124] AMD-Vi: DTE[1]: 0000100103c30002
[   11.096277] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.096430] AMD-Vi: DTE[3]: 0000000000000000
[   11.096631] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01c00 flags=0x0080]
[   11.097113] AMD-Vi: DTE[0]: 7590000000000003
[   11.097266] AMD-Vi: DTE[1]: 0000100103c30002
[   11.097419] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.097573] AMD-Vi: DTE[3]: 0000000000000000
[   11.097727] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01a00 flags=0x0080]
[   11.098162] AMD-Vi: DTE[0]: 7590000000000003
[   11.098293] AMD-Vi: DTE[1]: 0000100103c30002
[   11.098425] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.098557] AMD-Vi: DTE[3]: 0000000000000000
[   11.098689] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea01700 flags=0x0080]
[   11.099078] AMD-Vi: DTE[0]: 7590000000000003
[   11.099232] AMD-Vi: DTE[1]: 0000100103c30002
[   11.099385] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.099539] AMD-Vi: DTE[3]: 0000000000000000
[   11.099693] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03000 flags=0x0080]
[   11.100123] AMD-Vi: DTE[0]: 7590000000000003
[   11.100255] AMD-Vi: DTE[1]: 0000100103c30002
[   11.100387] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.100563] AMD-Vi: DTE[3]: 0000000000000000
[   11.100710] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03280 flags=0x0080]
[   11.101127] AMD-Vi: DTE[0]: 7590000000000003
[   11.101281] AMD-Vi: DTE[1]: 0000100103c30002
[   11.101434] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.101588] AMD-Vi: DTE[3]: 0000000000000000
[   11.101741] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03680 flags=0x0080]
[   11.102187] AMD-Vi: DTE[0]: 7590000000000003
[   11.102340] AMD-Vi: DTE[1]: 0000100103c30002
[   11.102494] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.102647] AMD-Vi: DTE[3]: 0000000000000000
[   11.102801] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03700 flags=0x0080]
[   11.103215] AMD-Vi: DTE[0]: 7590000000000003
[   11.103347] AMD-Vi: DTE[1]: 0000100103c30002
[   11.103478] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.103610] AMD-Vi: DTE[3]: 0000000000000000
[   11.103742] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea036c0 flags=0x0080]
[   11.104138] AMD-Vi: DTE[0]: 7590000000000003
[   11.104291] AMD-Vi: DTE[1]: 0000100103c30002
[   11.104445] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.104645] AMD-Vi: DTE[3]: 0000000000000000
[   11.104838] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03040 flags=0x0080]
[   11.105283] AMD-Vi: DTE[0]: 7590000000000003
[   11.105436] AMD-Vi: DTE[1]: 0000100103c30002
[   11.105589] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.105743] AMD-Vi: DTE[3]: 0000000000000000
[   11.105897] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03580 flags=0x0080]
[   11.106310] AMD-Vi: DTE[0]: 7590000000000003
[   11.106442] AMD-Vi: DTE[1]: 0000100103c30002
[   11.106574] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.106705] AMD-Vi: DTE[3]: 0000000000000000
[   11.106837] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03140 flags=0x0080]
[   11.107249] AMD-Vi: DTE[0]: 7590000000000003
[   11.107402] AMD-Vi: DTE[1]: 0000100103c30002
[   11.107556] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.107709] AMD-Vi: DTE[3]: 0000000000000000
[   11.107863] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea034c0 flags=0x0080]
[   11.108308] AMD-Vi: DTE[0]: 7590000000000003
[   11.108504] AMD-Vi: DTE[1]: 0000100103c30002
[   11.108661] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.108856] AMD-Vi: DTE[3]: 0000000000000000
[   11.109010] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03440 flags=0x0080]
[   11.109455] AMD-Vi: DTE[0]: 7590000000000003
[   11.109609] AMD-Vi: DTE[1]: 0000100103c30002
[   11.109762] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.109915] AMD-Vi: DTE[3]: 0000000000000000
[   11.110073] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03540 flags=0x0080]
[   11.110463] AMD-Vi: DTE[0]: 7590000000000003
[   11.110594] AMD-Vi: DTE[1]: 0000100103c30002
[   11.110726] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.110858] AMD-Vi: DTE[3]: 0000000000000000
[   11.110990] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03480 flags=0x0080]
[   11.111425] AMD-Vi: DTE[0]: 7590000000000003
[   11.111578] AMD-Vi: DTE[1]: 0000100103c30002
[   11.111732] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.111885] AMD-Vi: DTE[3]: 0000000000000000
[   11.112039] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea031c0 flags=0x0080]
[   11.112516] AMD-Vi: DTE[0]: 7590000000000003
[   11.112679] AMD-Vi: DTE[1]: 0000100103c30002
[   11.112870] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.113024] AMD-Vi: DTE[3]: 0000000000000000
[   11.113178] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03740 flags=0x0080]
[   11.113610] AMD-Vi: DTE[0]: 7590000000000003
[   11.113767] AMD-Vi: DTE[1]: 0000100103c30002
[   11.113920] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.114074] AMD-Vi: DTE[3]: 0000000000000000
[   11.114213] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03340 flags=0x0080]
[   11.114597] AMD-Vi: DTE[0]: 7590000000000003
[   11.114729] AMD-Vi: DTE[1]: 0000100103c30002
[   11.114861] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.114993] AMD-Vi: DTE[3]: 0000000000000000
[   11.115135] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03780 flags=0x0080]
[   11.115580] AMD-Vi: DTE[0]: 7590000000000003
[   11.115733] AMD-Vi: DTE[1]: 0000100103c30002
[   11.115887] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.116040] AMD-Vi: DTE[3]: 0000000000000000
[   11.116194] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03380 flags=0x0080]
[   11.116687] AMD-Vi: DTE[0]: 7590000000000003
[   11.116880] AMD-Vi: DTE[1]: 0000100103c30002
[   11.117034] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.117187] AMD-Vi: DTE[3]: 0000000000000000
[   11.117341] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03500 flags=0x0080]
[   11.117773] AMD-Vi: DTE[0]: 7590000000000003
[   11.117930] AMD-Vi: DTE[1]: 0000100103c30002
[   11.118084] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.118222] AMD-Vi: DTE[3]: 0000000000000000
[   11.118354] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea033c0 flags=0x0080]
[   11.118738] AMD-Vi: DTE[0]: 7590000000000003
[   11.118870] AMD-Vi: DTE[1]: 0000100103c30002
[   11.119001] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.119143] AMD-Vi: DTE[3]: 0000000000000000
[   11.119297] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03300 flags=0x0080]
[   11.119742] AMD-Vi: DTE[0]: 7590000000000003
[   11.119896] AMD-Vi: DTE[1]: 0000100103c30002
[   11.120049] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.120203] AMD-Vi: DTE[3]: 0000000000000000
[   11.120356] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03200 flags=0x0080]
[   11.120868] AMD-Vi: DTE[0]: 7590000000000003
[   11.121022] AMD-Vi: DTE[1]: 0000100103c30002
[   11.121175] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.121329] AMD-Vi: DTE[3]: 0000000000000000
[   11.121486] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea035c0 flags=0x0080]
[   11.121931] AMD-Vi: DTE[0]: 7590000000000003
[   11.122085] AMD-Vi: DTE[1]: 0000100103c30002
[   11.122224] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.122356] AMD-Vi: DTE[3]: 0000000000000000
[   11.122488] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03a00 flags=0x0080]
[   11.122872] AMD-Vi: DTE[0]: 7590000000000003
[   11.123003] AMD-Vi: DTE[1]: 0000100103c30002
[   11.123144] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.123298] AMD-Vi: DTE[3]: 0000000000000000
[   11.123451] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03800 flags=0x0080]
[   11.123883] AMD-Vi: DTE[0]: 7590000000000003
[   11.124037] AMD-Vi: DTE[1]: 0000100103c30002
[   11.124185] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.124317] AMD-Vi: DTE[3]: 0000000000000000
[   11.124449] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03840 flags=0x0080]
[   11.124912] AMD-Vi: DTE[0]: 7590000000000003
[   11.125044] AMD-Vi: DTE[1]: 0000100103c30002
[   11.125191] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.125345] AMD-Vi: DTE[3]: 0000000000000000
[   11.125499] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03880 flags=0x0080]
[   11.125944] AMD-Vi: DTE[0]: 7590000000000003
[   11.126097] AMD-Vi: DTE[1]: 0000100103c30002
[   11.126251] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.126404] AMD-Vi: DTE[3]: 0000000000000000
[   11.126558] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea038c0 flags=0x0080]
[   11.127003] AMD-Vi: DTE[0]: 7590000000000003
[   11.127155] AMD-Vi: DTE[1]: 0000100103c30002
[   11.127292] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.127423] AMD-Vi: DTE[3]: 0000000000000000
[   11.127555] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03900 flags=0x0080]
[   11.127939] AMD-Vi: DTE[0]: 7590000000000003
[   11.128071] AMD-Vi: DTE[1]: 0000100103c30002
[   11.128222] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.128376] AMD-Vi: DTE[3]: 0000000000000000
[   11.128573] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03940 flags=0x0080]
[   11.129044] AMD-Vi: DTE[0]: 7590000000000003
[   11.129197] AMD-Vi: DTE[1]: 0000100103c30002
[   11.129351] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.129504] AMD-Vi: DTE[3]: 0000000000000000
[   11.129658] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03980 flags=0x0080]
[   11.130103] AMD-Vi: DTE[0]: 7590000000000003
[   11.130242] AMD-Vi: DTE[1]: 0000100103c30002
[   11.130374] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.130505] AMD-Vi: DTE[3]: 0000000000000000
[   11.130637] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea039c0 flags=0x0080]
[   11.131022] AMD-Vi: DTE[0]: 7590000000000003
[   11.131163] AMD-Vi: DTE[1]: 0000100103c30002
[   11.131317] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.131470] AMD-Vi: DTE[3]: 0000000000000000
[   11.131628] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03c00 flags=0x0080]
[   11.132073] AMD-Vi: DTE[0]: 7590000000000003
[   11.132226] AMD-Vi: DTE[1]: 0000100103c30002
[   11.132379] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.132578] AMD-Vi: DTE[3]: 0000000000000000
[   11.132735] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03c40 flags=0x0080]
[   11.133204] AMD-Vi: DTE[0]: 7590000000000003
[   11.133361] AMD-Vi: DTE[1]: 0000100103c30002
[   11.133515] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.133668] AMD-Vi: DTE[3]: 0000000000000000
[   11.133822] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03c80 flags=0x0080]
[   11.134242] AMD-Vi: DTE[0]: 7590000000000003
[   11.134373] AMD-Vi: DTE[1]: 0000100103c30002
[   11.134505] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.134637] AMD-Vi: DTE[3]: 0000000000000000
[   11.134769] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03cc0 flags=0x0080]
[   11.135161] AMD-Vi: DTE[0]: 7590000000000003
[   11.135314] AMD-Vi: DTE[1]: 0000100103c30002
[   11.135467] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.135621] AMD-Vi: DTE[3]: 0000000000000000
[   11.135779] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03d00 flags=0x0080]
[   11.136224] AMD-Vi: DTE[0]: 7590000000000003
[   11.136377] AMD-Vi: DTE[1]: 0000100103c30002
[   11.136581] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.136772] AMD-Vi: DTE[3]: 0000000000000000
[   11.136926] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03d40 flags=0x0080]
[   11.137371] AMD-Vi: DTE[0]: 7590000000000003
[   11.137525] AMD-Vi: DTE[1]: 0000100103c30002
[   11.137678] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.137832] AMD-Vi: DTE[3]: 0000000000000000
[   11.137985] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03d80 flags=0x0080]
[   11.138395] AMD-Vi: DTE[0]: 7590000000000003
[   11.138526] AMD-Vi: DTE[1]: 0000100103c30002
[   11.138658] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.138790] AMD-Vi: DTE[3]: 0000000000000000
[   11.138922] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03dc0 flags=0x0080]
[   11.139337] AMD-Vi: DTE[0]: 7590000000000003
[   11.139491] AMD-Vi: DTE[1]: 0000100103c30002
[   11.139644] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.139797] AMD-Vi: DTE[3]: 0000000000000000
[   11.139951] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03a40 flags=0x0080]
[   11.140383] AMD-Vi: DTE[0]: 7590000000000003
[   11.140585] AMD-Vi: DTE[1]: 0000100103c30002
[   11.140778] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.140931] AMD-Vi: DTE[3]: 0000000000000000
[   11.141084] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03a80 flags=0x0080]
[   11.141530] AMD-Vi: DTE[0]: 7590000000000003
[   11.141683] AMD-Vi: DTE[1]: 0000100103c30002
[   11.141836] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.141990] AMD-Vi: DTE[3]: 0000000000000000
[   11.142143] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03ac0 flags=0x0080]
[   11.142519] AMD-Vi: DTE[0]: 7590000000000003
[   11.142651] AMD-Vi: DTE[1]: 0000100103c30002
[   11.142783] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.142914] AMD-Vi: DTE[3]: 0000000000000000
[   11.143047] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03b00 flags=0x0080]
[   11.143481] AMD-Vi: DTE[0]: 7590000000000003
[   11.143634] AMD-Vi: DTE[1]: 0000100103c30002
[   11.143788] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.143941] AMD-Vi: DTE[3]: 0000000000000000
[   11.144095] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03b40 flags=0x0080]
[   11.144586] AMD-Vi: DTE[0]: 7590000000000003
[   11.144782] AMD-Vi: DTE[1]: 0000100103c30002
[   11.144935] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.145089] AMD-Vi: DTE[3]: 0000000000000000
[   11.145243] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03b80 flags=0x0080]
[   11.145688] AMD-Vi: DTE[0]: 7590000000000003
[   11.145841] AMD-Vi: DTE[1]: 0000100103c30002
[   11.145995] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.146148] AMD-Vi: DTE[3]: 0000000000000000
[   11.146285] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03bc0 flags=0x0080]
[   11.146669] AMD-Vi: DTE[0]: 7590000000000003
[   11.146801] AMD-Vi: DTE[1]: 0000100103c30002
[   11.146932] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.147064] AMD-Vi: DTE[3]: 0000000000000000
[   11.147208] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03ec0 flags=0x0080]
[   11.147654] AMD-Vi: DTE[0]: 7590000000000003
[   11.147807] AMD-Vi: DTE[1]: 0000100103c30002
[   11.147960] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.148114] AMD-Vi: DTE[3]: 0000000000000000
[   11.148267] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03e00 flags=0x0080]
[   11.148830] AMD-Vi: DTE[0]: 7590000000000003
[   11.148995] AMD-Vi: DTE[1]: 0000100103c30002
[   11.149157] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.149354] AMD-Vi: DTE[3]: 0000000000000000
[   11.149508] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03e40 flags=0x0080]
[   11.149953] AMD-Vi: DTE[0]: 7590000000000003
[   11.150106] AMD-Vi: DTE[1]: 0000100103c30002
[   11.150260] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.150413] AMD-Vi: DTE[3]: 0000000000000000
[   11.150567] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03e80 flags=0x0080]
[   11.151012] AMD-Vi: DTE[0]: 7590000000000003
[   11.151165] AMD-Vi: DTE[1]: 0000100103c30002
[   11.151301] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.151433] AMD-Vi: DTE[3]: 0000000000000000
[   11.151565] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03f00 flags=0x0080]
[   11.151949] AMD-Vi: DTE[0]: 7590000000000003
[   11.152080] AMD-Vi: DTE[1]: 0000100103c30002
[   11.152225] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.152379] AMD-Vi: DTE[3]: 0000000000000000
[   11.152623] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03f40 flags=0x0080]
[   11.153103] AMD-Vi: DTE[0]: 7590000000000003
[   11.153256] AMD-Vi: DTE[1]: 0000100103c30002
[   11.153410] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.153563] AMD-Vi: DTE[3]: 0000000000000000
[   11.153717] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03f80 flags=0x0080]
[   11.154149] AMD-Vi: DTE[0]: 7590000000000003
[   11.154292] AMD-Vi: DTE[1]: 0000100103c30002
[   11.154424] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.154556] AMD-Vi: DTE[3]: 0000000000000000
[   11.154688] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03fc0 flags=0x0080]
[   11.155072] AMD-Vi: DTE[0]: 7590000000000003
[   11.155214] AMD-Vi: DTE[1]: 0000100103c30002
[   11.155368] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.155521] AMD-Vi: DTE[3]: 0000000000000000
[   11.155675] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04200 flags=0x0080]
[   11.156120] AMD-Vi: DTE[0]: 7590000000000003
[   11.156273] AMD-Vi: DTE[1]: 0000100103c30002
[   11.156427] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.156640] AMD-Vi: DTE[3]: 0000000000000000
[   11.156833] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03600 flags=0x0080]
[   11.157278] AMD-Vi: DTE[0]: 7590000000000003
[   11.157431] AMD-Vi: DTE[1]: 0000100103c30002
[   11.157585] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.157738] AMD-Vi: DTE[3]: 0000000000000000
[   11.157892] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03080 flags=0x0080]
[   11.158308] AMD-Vi: DTE[0]: 7590000000000003
[   11.158439] AMD-Vi: DTE[1]: 0000100103c30002
[   11.158571] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.158703] AMD-Vi: DTE[3]: 0000000000000000
[   11.158835] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea030c0 flags=0x0080]
[   11.159230] AMD-Vi: DTE[0]: 7590000000000003
[   11.159383] AMD-Vi: DTE[1]: 0000100103c30002
[   11.159536] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.159690] AMD-Vi: DTE[3]: 0000000000000000
[   11.159843] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03400 flags=0x0080]
[   11.160275] AMD-Vi: DTE[0]: 7590000000000003
[   11.160429] AMD-Vi: DTE[1]: 0000100103c30002
[   11.160632] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.160827] AMD-Vi: DTE[3]: 0000000000000000
[   11.160980] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03100 flags=0x0080]
[   11.161426] AMD-Vi: DTE[0]: 7590000000000003
[   11.161579] AMD-Vi: DTE[1]: 0000100103c30002
[   11.161732] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.161886] AMD-Vi: DTE[3]: 0000000000000000
[   11.162039] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03240 flags=0x0080]
[   11.162447] AMD-Vi: DTE[0]: 7590000000000003
[   11.162579] AMD-Vi: DTE[1]: 0000100103c30002
[   11.162711] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.162843] AMD-Vi: DTE[3]: 0000000000000000
[   11.162975] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea037c0 flags=0x0080]
[   11.163391] AMD-Vi: DTE[0]: 7590000000000003
[   11.163545] AMD-Vi: DTE[1]: 0000100103c30002
[   11.163698] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.163852] AMD-Vi: DTE[3]: 0000000000000000
[   11.164005] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea032c0 flags=0x0080]
[   11.164450] AMD-Vi: DTE[0]: 7590000000000003
[   11.164653] AMD-Vi: DTE[1]: 0000100103c30002
[   11.164844] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.164998] AMD-Vi: DTE[3]: 0000000000000000
[   11.165151] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03180 flags=0x0080]
[   11.165597] AMD-Vi: DTE[0]: 7590000000000003
[   11.165750] AMD-Vi: DTE[1]: 0000100103c30002
[   11.165904] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.166057] AMD-Vi: DTE[3]: 0000000000000000
[   11.166211] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea03640 flags=0x0080]
[   11.166583] AMD-Vi: DTE[0]: 7590000000000003
[   11.166715] AMD-Vi: DTE[1]: 0000100103c30002
[   11.166846] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.166983] AMD-Vi: DTE[3]: 0000000000000000
[   11.167115] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04100 flags=0x0080]
[   11.167552] AMD-Vi: DTE[0]: 7590000000000003
[   11.167706] AMD-Vi: DTE[1]: 0000100103c30002
[   11.167859] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.168013] AMD-Vi: DTE[3]: 0000000000000000
[   11.168166] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04000 flags=0x0080]
[   11.168650] AMD-Vi: DTE[0]: 7590000000000003
[   11.168843] AMD-Vi: DTE[1]: 0000100103c30002
[   11.168997] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.169150] AMD-Vi: DTE[3]: 0000000000000000
[   11.169304] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04040 flags=0x0080]
[   11.169736] AMD-Vi: DTE[0]: 7590000000000003
[   11.169889] AMD-Vi: DTE[1]: 0000100103c30002
[   11.170043] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.170196] AMD-Vi: DTE[3]: 0000000000000000
[   11.170333] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04080 flags=0x0080]
[   11.170717] AMD-Vi: DTE[0]: 7590000000000003
[   11.170848] AMD-Vi: DTE[1]: 0000100103c30002
[   11.170980] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.171112] AMD-Vi: DTE[3]: 0000000000000000
[   11.171256] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea040c0 flags=0x0080]
[   11.171688] AMD-Vi: DTE[0]: 7590000000000003
[   11.171846] AMD-Vi: DTE[1]: 0000100103c30002
[   11.171999] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.172153] AMD-Vi: DTE[3]: 0000000000000000
[   11.172307] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04580 flags=0x0080]
[   11.172827] AMD-Vi: DTE[0]: 7590000000000003
[   11.172981] AMD-Vi: DTE[1]: 0000100103c30002
[   11.173134] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.173287] AMD-Vi: DTE[3]: 0000000000000000
[   11.173441] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea045c0 flags=0x0080]
[   11.173873] AMD-Vi: DTE[0]: 7590000000000003
[   11.174031] AMD-Vi: DTE[1]: 0000100103c30002
[   11.174184] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.174324] AMD-Vi: DTE[3]: 0000000000000000
[   11.174456] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04140 flags=0x0080]
[   11.174840] AMD-Vi: DTE[0]: 7590000000000003
[   11.174972] AMD-Vi: DTE[1]: 0000100103c30002
[   11.175103] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.175245] AMD-Vi: DTE[3]: 0000000000000000
[   11.175398] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04180 flags=0x0080]
[   11.175830] AMD-Vi: DTE[0]: 7590000000000003
[   11.175988] AMD-Vi: DTE[1]: 0000100103c30002
[   11.176141] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.176295] AMD-Vi: DTE[3]: 0000000000000000
[   11.176448] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea041c0 flags=0x0080]
[   11.176967] AMD-Vi: DTE[0]: 7590000000000003
[   11.177121] AMD-Vi: DTE[1]: 0000100103c30002
[   11.177274] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.177428] AMD-Vi: DTE[3]: 0000000000000000
[   11.177581] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04600 flags=0x0080]
[   11.178013] AMD-Vi: DTE[0]: 7590000000000003
[   11.178171] AMD-Vi: DTE[1]: 0000100103c30002
[   11.178313] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.178445] AMD-Vi: DTE[3]: 0000000000000000
[   11.178577] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea043c0 flags=0x0080]
[   11.178961] AMD-Vi: DTE[0]: 7590000000000003
[   11.179093] AMD-Vi: DTE[1]: 0000100103c30002
[   11.179231] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.179384] AMD-Vi: DTE[3]: 0000000000000000
[   11.179538] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04680 flags=0x0080]
[   11.179970] AMD-Vi: DTE[0]: 7590000000000003
[   11.180127] AMD-Vi: DTE[1]: 0000100103c30002
[   11.180281] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.180434] AMD-Vi: DTE[3]: 0000000000000000
[   11.180634] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04700 flags=0x0080]
[   11.181114] AMD-Vi: DTE[0]: 7590000000000003
[   11.181267] AMD-Vi: DTE[1]: 0000100103c30002
[   11.181421] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.181579] AMD-Vi: DTE[3]: 0000000000000000
[   11.181732] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea046c0 flags=0x0080]
[   11.182164] AMD-Vi: DTE[0]: 7590000000000003
[   11.182312] AMD-Vi: DTE[1]: 0000100103c30002
[   11.182444] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.182576] AMD-Vi: DTE[3]: 0000000000000000
[   11.182708] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04640 flags=0x0080]
[   11.183092] AMD-Vi: DTE[0]: 7590000000000003
[   11.183229] AMD-Vi: DTE[1]: 0000100103c30002
[   11.183382] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.183536] AMD-Vi: DTE[3]: 0000000000000000
[   11.183689] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04780 flags=0x0080]
[   11.184121] AMD-Vi: DTE[0]: 7590000000000003
[   11.184277] AMD-Vi: DTE[1]: 0000100103c30002
[   11.184409] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.184588] AMD-Vi: DTE[3]: 0000000000000000
[   11.184762] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04380 flags=0x0080]
[   11.185133] AMD-Vi: DTE[0]: 7590000000000003
[   11.185276] AMD-Vi: DTE[1]: 0000100103c30002
[   11.185429] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.185582] AMD-Vi: DTE[3]: 0000000000000000
[   11.185736] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea042c0 flags=0x0080]
[   11.186181] AMD-Vi: DTE[0]: 7590000000000003
[   11.186335] AMD-Vi: DTE[1]: 0000100103c30002
[   11.186488] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.186642] AMD-Vi: DTE[3]: 0000000000000000
[   11.186795] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04340 flags=0x0080]
[   11.187241] AMD-Vi: DTE[0]: 7590000000000003
[   11.187375] AMD-Vi: DTE[1]: 0000100103c30002
[   11.187507] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.187639] AMD-Vi: DTE[3]: 0000000000000000
[   11.187770] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04300 flags=0x0080]
[   11.188155] AMD-Vi: DTE[0]: 7590000000000003
[   11.188301] AMD-Vi: DTE[1]: 0000100103c30002
[   11.188454] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.188657] AMD-Vi: DTE[3]: 0000000000000000
[   11.188850] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04280 flags=0x0080]
[   11.189295] AMD-Vi: DTE[0]: 7590000000000003
[   11.189448] AMD-Vi: DTE[1]: 0000100103c30002
[   11.189601] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.189755] AMD-Vi: DTE[3]: 0000000000000000
[   11.189908] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04a40 flags=0x0080]
[   11.190330] AMD-Vi: DTE[0]: 7590000000000003
[   11.190462] AMD-Vi: DTE[1]: 0000100103c30002
[   11.190594] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.190726] AMD-Vi: DTE[3]: 0000000000000000
[   11.190858] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04840 flags=0x0080]
[   11.191245] AMD-Vi: DTE[0]: 7590000000000003
[   11.191398] AMD-Vi: DTE[1]: 0000100103c30002
[   11.191552] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.191705] AMD-Vi: DTE[3]: 0000000000000000
[   11.191859] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04880 flags=0x0080]
[   11.192289] AMD-Vi: DTE[0]: 7590000000000003
[   11.192421] AMD-Vi: DTE[1]: 0000100103c30002
[   11.192601] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.192774] AMD-Vi: DTE[3]: 0000000000000000
[   11.192906] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04a00 flags=0x0080]
[   11.193302] AMD-Vi: DTE[0]: 7590000000000003
[   11.193455] AMD-Vi: DTE[1]: 0000100103c30002
[   11.193609] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.193762] AMD-Vi: DTE[3]: 0000000000000000
[   11.193916] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04940 flags=0x0080]
[   11.194348] AMD-Vi: DTE[0]: 7590000000000003
[   11.194505] AMD-Vi: DTE[1]: 0000100103c30002
[   11.194659] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.194812] AMD-Vi: DTE[3]: 0000000000000000
[   11.194966] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea048c0 flags=0x0080]
[   11.195393] AMD-Vi: DTE[0]: 7590000000000003
[   11.195525] AMD-Vi: DTE[1]: 0000100103c30002
[   11.195657] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.195789] AMD-Vi: DTE[3]: 0000000000000000
[   11.195921] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea047c0 flags=0x0080]
[   11.196318] AMD-Vi: DTE[0]: 7590000000000003
[   11.196515] AMD-Vi: DTE[1]: 0000100103c30002
[   11.196672] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.196867] AMD-Vi: DTE[3]: 0000000000000000
[   11.197020] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04900 flags=0x0080]
[   11.197466] AMD-Vi: DTE[0]: 7590000000000003
[   11.197619] AMD-Vi: DTE[1]: 0000100103c30002
[   11.197773] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.197926] AMD-Vi: DTE[3]: 0000000000000000
[   11.198080] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea049c0 flags=0x0080]
[   11.198479] AMD-Vi: DTE[0]: 7590000000000003
[   11.198611] AMD-Vi: DTE[1]: 0000100103c30002
[   11.198743] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.198874] AMD-Vi: DTE[3]: 0000000000000000
[   11.199007] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04c00 flags=0x0080]
[   11.199417] AMD-Vi: DTE[0]: 7590000000000003
[   11.199570] AMD-Vi: DTE[1]: 0000100103c30002
[   11.199724] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.199877] AMD-Vi: DTE[3]: 0000000000000000
[   11.200031] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04c40 flags=0x0080]
[   11.200506] AMD-Vi: DTE[0]: 7590000000000003
[   11.200663] AMD-Vi: DTE[1]: 0000100103c30002
[   11.200859] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.201012] AMD-Vi: DTE[3]: 0000000000000000
[   11.201166] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04c80 flags=0x0080]
[   11.201611] AMD-Vi: DTE[0]: 7590000000000003
[   11.201764] AMD-Vi: DTE[1]: 0000100103c30002
[   11.201918] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.202071] AMD-Vi: DTE[3]: 0000000000000000
[   11.202225] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04d00 flags=0x0080]
[   11.202604] AMD-Vi: DTE[0]: 7590000000000003
[   11.202736] AMD-Vi: DTE[1]: 0000100103c30002
[   11.202868] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.203000] AMD-Vi: DTE[3]: 0000000000000000
[   11.203132] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04cc0 flags=0x0080]
[   11.203562] AMD-Vi: DTE[0]: 7590000000000003
[   11.203715] AMD-Vi: DTE[1]: 0000100103c30002
[   11.203868] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.204022] AMD-Vi: DTE[3]: 0000000000000000
[   11.204175] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04d40 flags=0x0080]
[   11.204658] AMD-Vi: DTE[0]: 7590000000000003
[   11.204849] AMD-Vi: DTE[1]: 0000100103c30002
[   11.205002] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.205156] AMD-Vi: DTE[3]: 0000000000000000
[   11.205310] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04980 flags=0x0080]
[   11.205755] AMD-Vi: DTE[0]: 7590000000000003
[   11.205908] AMD-Vi: DTE[1]: 0000100103c30002
[   11.206062] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.206215] AMD-Vi: DTE[3]: 0000000000000000
[   11.206358] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04dc0 flags=0x0080]
[   11.206743] AMD-Vi: DTE[0]: 7590000000000003
[   11.206874] AMD-Vi: DTE[1]: 0000100103c30002
[   11.207006] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.207138] AMD-Vi: DTE[3]: 0000000000000000
[   11.207275] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04d80 flags=0x0080]
[   11.207720] AMD-Vi: DTE[0]: 7590000000000003
[   11.207874] AMD-Vi: DTE[1]: 0000100103c30002
[   11.208027] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.208181] AMD-Vi: DTE[3]: 0000000000000000
[   11.208334] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05000 flags=0x0080]
[   11.208851] AMD-Vi: DTE[0]: 7590000000000003
[   11.209004] AMD-Vi: DTE[1]: 0000100103c30002
[   11.209157] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.209311] AMD-Vi: DTE[3]: 0000000000000000
[   11.209465] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04ac0 flags=0x0080]
[   11.209910] AMD-Vi: DTE[0]: 7590000000000003
[   11.210063] AMD-Vi: DTE[1]: 0000100103c30002
[   11.210217] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.210361] AMD-Vi: DTE[3]: 0000000000000000
[   11.210493] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04b00 flags=0x0080]
[   11.210877] AMD-Vi: DTE[0]: 7590000000000003
[   11.211009] AMD-Vi: DTE[1]: 0000100103c30002
[   11.211140] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.211276] AMD-Vi: DTE[3]: 0000000000000000
[   11.211434] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04b40 flags=0x0080]
[   11.211879] AMD-Vi: DTE[0]: 7590000000000003
[   11.212032] AMD-Vi: DTE[1]: 0000100103c30002
[   11.212190] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.212343] AMD-Vi: DTE[3]: 0000000000000000
[   11.212546] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04b80 flags=0x0080]
[   11.213024] AMD-Vi: DTE[0]: 7590000000000003
[   11.213177] AMD-Vi: DTE[1]: 0000100103c30002
[   11.213331] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.213484] AMD-Vi: DTE[3]: 0000000000000000
[   11.213638] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04bc0 flags=0x0080]
[   11.214083] AMD-Vi: DTE[0]: 7590000000000003
[   11.214237] AMD-Vi: DTE[1]: 0000100103c30002
[   11.214380] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.214512] AMD-Vi: DTE[3]: 0000000000000000
[   11.214644] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04e00 flags=0x0080]
[   11.215028] AMD-Vi: DTE[0]: 7590000000000003
[   11.215159] AMD-Vi: DTE[1]: 0000100103c30002
[   11.215297] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.215451] AMD-Vi: DTE[3]: 0000000000000000
[   11.215609] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04e40 flags=0x0080]
[   11.216054] AMD-Vi: DTE[0]: 7590000000000003
[   11.216207] AMD-Vi: DTE[1]: 0000100103c30002
[   11.216360] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.216561] AMD-Vi: DTE[3]: 0000000000000000
[   11.216762] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04e80 flags=0x0080]
[   11.217208] AMD-Vi: DTE[0]: 7590000000000003
[   11.217361] AMD-Vi: DTE[1]: 0000100103c30002
[   11.217515] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.217668] AMD-Vi: DTE[3]: 0000000000000000
[   11.217822] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04ec0 flags=0x0080]
[   11.218251] AMD-Vi: DTE[0]: 7590000000000003
[   11.218404] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218556] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.217705] amdgpu 0000:00:01.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring gfx test failed (-110)
[   11.218708] AMD-Vi: DTE[3]: 0000000000000000
[   11.218710] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04f00 flags=0x0080]
[   11.218713] AMD-Vi: DTE[0]: 7590000000000003
[   11.218714] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218716] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218717] AMD-Vi: DTE[3]: 0000000000000000
[   11.218718] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04f40 flags=0x0080]
[   11.218721] AMD-Vi: DTE[0]: 7590000000000003
[   11.218722] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218724] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218725] AMD-Vi: DTE[3]: 0000000000000000
[   11.218726] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04f80 flags=0x0080]
[   11.218729] AMD-Vi: DTE[0]: 7590000000000003
[   11.218730] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218731] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218732] AMD-Vi: DTE[3]: 0000000000000000
[   11.218733] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04fc0 flags=0x0080]
[   11.218736] AMD-Vi: DTE[0]: 7590000000000003
[   11.218737] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218738] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218739] AMD-Vi: DTE[3]: 0000000000000000
[   11.218741] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05240 flags=0x0080]
[   11.218743] AMD-Vi: DTE[0]: 7590000000000003
[   11.218744] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218746] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218747] AMD-Vi: DTE[3]: 0000000000000000
[   11.218749] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05200 flags=0x0080]
[   11.218751] AMD-Vi: DTE[0]: 7590000000000003
[   11.218752] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218754] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218755] AMD-Vi: DTE[3]: 0000000000000000
[   11.218756] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05040 flags=0x0080]
[   11.218759] AMD-Vi: DTE[0]: 7590000000000003
[   11.218760] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218762] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218763] AMD-Vi: DTE[3]: 0000000000000000
[   11.218764] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05080 flags=0x0080]
[   11.218766] AMD-Vi: DTE[0]: 7590000000000003
[   11.218768] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218769] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218770] AMD-Vi: DTE[3]: 0000000000000000
[   11.218772] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea050c0 flags=0x0080]
[   11.218774] AMD-Vi: DTE[0]: 7590000000000003
[   11.218775] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218776] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218777] AMD-Vi: DTE[3]: 0000000000000000
[   11.218779] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05280 flags=0x0080]
[   11.218781] AMD-Vi: DTE[0]: 7590000000000003
[   11.218782] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218783] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218784] AMD-Vi: DTE[3]: 0000000000000000
[   11.218786] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04a80 flags=0x0080]
[   11.218788] AMD-Vi: DTE[0]: 7590000000000003
[   11.218789] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218791] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218792] AMD-Vi: DTE[3]: 0000000000000000
[   11.218793] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04740 flags=0x0080]
[   11.218796] AMD-Vi: DTE[0]: 7590000000000003
[   11.218797] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218799] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218800] AMD-Vi: DTE[3]: 0000000000000000
[   11.218801] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04800 flags=0x0080]
[   11.218803] AMD-Vi: DTE[0]: 7590000000000003
[   11.218804] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218805] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218807] AMD-Vi: DTE[3]: 0000000000000000
[   11.218808] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04400 flags=0x0080]
[   11.218810] AMD-Vi: DTE[0]: 7590000000000003
[   11.218811] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218812] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218814] AMD-Vi: DTE[3]: 0000000000000000
[   11.218815] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04440 flags=0x0080]
[   11.218817] AMD-Vi: DTE[0]: 7590000000000003
[   11.218818] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218819] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218820] AMD-Vi: DTE[3]: 0000000000000000
[   11.218822] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05140 flags=0x0080]
[   11.218824] AMD-Vi: DTE[0]: 7590000000000003
[   11.218826] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218827] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218828] AMD-Vi: DTE[3]: 0000000000000000
[   11.218829] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05440 flags=0x0080]
[   11.218831] AMD-Vi: DTE[0]: 7590000000000003
[   11.218833] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218834] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218835] AMD-Vi: DTE[3]: 0000000000000000
[   11.218836] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05100 flags=0x0080]
[   11.218838] AMD-Vi: DTE[0]: 7590000000000003
[   11.218839] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218840] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218842] AMD-Vi: DTE[3]: 0000000000000000
[   11.218843] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea051c0 flags=0x0080]
[   11.218845] AMD-Vi: DTE[0]: 7590000000000003
[   11.218847] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218848] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218849] AMD-Vi: DTE[3]: 0000000000000000
[   11.218850] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05180 flags=0x0080]
[   11.218853] AMD-Vi: DTE[0]: 7590000000000003
[   11.218854] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218855] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218857] AMD-Vi: DTE[3]: 0000000000000000
[   11.218858] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05400 flags=0x0080]
[   11.218861] AMD-Vi: DTE[0]: 7590000000000003
[   11.218862] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218863] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218864] AMD-Vi: DTE[3]: 0000000000000000
[   11.218866] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05500 flags=0x0080]
[   11.218868] AMD-Vi: DTE[0]: 7590000000000003
[   11.218869] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218870] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218872] AMD-Vi: DTE[3]: 0000000000000000
[   11.218873] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05480 flags=0x0080]
[   11.218875] AMD-Vi: DTE[0]: 7590000000000003
[   11.218877] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218878] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218879] AMD-Vi: DTE[3]: 0000000000000000
[   11.218880] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea054c0 flags=0x0080]
[   11.218883] AMD-Vi: DTE[0]: 7590000000000003
[   11.218884] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218886] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218887] AMD-Vi: DTE[3]: 0000000000000000
[   11.218888] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05540 flags=0x0080]
[   11.218890] AMD-Vi: DTE[0]: 7590000000000003
[   11.218892] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218893] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218894] AMD-Vi: DTE[3]: 0000000000000000
[   11.218895] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea044c0 flags=0x0080]
[   11.218897] AMD-Vi: DTE[0]: 7590000000000003
[   11.218898] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218900] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218901] AMD-Vi: DTE[3]: 0000000000000000
[   11.218903] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04500 flags=0x0080]
[   11.218905] AMD-Vi: DTE[0]: 7590000000000003
[   11.218907] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218908] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218909] AMD-Vi: DTE[3]: 0000000000000000
[   11.218910] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04480 flags=0x0080]
[   11.218912] AMD-Vi: DTE[0]: 7590000000000003
[   11.218914] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218915] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218916] AMD-Vi: DTE[3]: 0000000000000000
[   11.218917] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04540 flags=0x0080]
[   11.218920] AMD-Vi: DTE[0]: 7590000000000003
[   11.218921] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218922] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218924] AMD-Vi: DTE[3]: 0000000000000000
[   11.218926] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea04240 flags=0x0080]
[   11.218928] AMD-Vi: DTE[0]: 7590000000000003
[   11.218930] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218930] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218932] AMD-Vi: DTE[3]: 0000000000000000
[   11.218934] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05580 flags=0x0080]
[   11.218936] AMD-Vi: DTE[0]: 7590000000000003
[   11.218937] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218938] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218940] AMD-Vi: DTE[3]: 0000000000000000
[   11.218942] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05680 flags=0x0080]
[   11.218944] AMD-Vi: DTE[0]: 7590000000000003
[   11.218945] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218947] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218948] AMD-Vi: DTE[3]: 0000000000000000
[   11.218950] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05700 flags=0x0080]
[   11.218952] AMD-Vi: DTE[0]: 7590000000000003
[   11.218954] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218955] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218956] AMD-Vi: DTE[3]: 0000000000000000
[   11.218958] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea057c0 flags=0x0080]
[   11.218960] AMD-Vi: DTE[0]: 7590000000000003
[   11.218961] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218962] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218963] AMD-Vi: DTE[3]: 0000000000000000
[   11.218965] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05840 flags=0x0080]
[   11.218967] AMD-Vi: DTE[0]: 7590000000000003
[   11.218968] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218969] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218970] AMD-Vi: DTE[3]: 0000000000000000
[   11.218972] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05800 flags=0x0080]
[   11.218974] AMD-Vi: DTE[0]: 7590000000000003
[   11.218975] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218976] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218978] AMD-Vi: DTE[3]: 0000000000000000
[   11.218979] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea055c0 flags=0x0080]
[   11.218982] AMD-Vi: DTE[0]: 7590000000000003
[   11.218983] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218985] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218986] AMD-Vi: DTE[3]: 0000000000000000
[   11.218987] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea053c0 flags=0x0080]
[   11.218990] AMD-Vi: DTE[0]: 7590000000000003
[   11.218991] AMD-Vi: DTE[1]: 0000100103c30002
[   11.218992] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.218993] AMD-Vi: DTE[3]: 0000000000000000
[   11.218995] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea052c0 flags=0x0080]
[   11.218997] AMD-Vi: DTE[0]: 7590000000000003
[   11.218999] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219000] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219001] AMD-Vi: DTE[3]: 0000000000000000
[   11.219002] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05640 flags=0x0080]
[   11.219004] AMD-Vi: DTE[0]: 7590000000000003
[   11.219006] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219007] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219008] AMD-Vi: DTE[3]: 0000000000000000
[   11.219010] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05340 flags=0x0080]
[   11.219012] AMD-Vi: DTE[0]: 7590000000000003
[   11.219013] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219014] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219015] AMD-Vi: DTE[3]: 0000000000000000
[   11.219016] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05780 flags=0x0080]
[   11.219018] AMD-Vi: DTE[0]: 7590000000000003
[   11.219019] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219021] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219022] AMD-Vi: DTE[3]: 0000000000000000
[   11.219024] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea056c0 flags=0x0080]
[   11.219026] AMD-Vi: DTE[0]: 7590000000000003
[   11.219027] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219028] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219029] AMD-Vi: DTE[3]: 0000000000000000
[   11.219031] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05380 flags=0x0080]
[   11.219033] AMD-Vi: DTE[0]: 7590000000000003
[   11.219034] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219035] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219036] AMD-Vi: DTE[3]: 0000000000000000
[   11.219037] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05740 flags=0x0080]
[   11.219039] AMD-Vi: DTE[0]: 7590000000000003
[   11.219040] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219042] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219043] AMD-Vi: DTE[3]: 0000000000000000
[   11.219044] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05600 flags=0x0080]
[   11.219046] AMD-Vi: DTE[0]: 7590000000000003
[   11.219047] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219048] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219049] AMD-Vi: DTE[3]: 0000000000000000
[   11.219051] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea05300 flags=0x0080]
[   11.219053] AMD-Vi: DTE[0]: 7590000000000003
[   11.219054] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219055] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219056] AMD-Vi: DTE[3]: 0000000000000000
[   11.219058] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06000 flags=0x0080]
[   11.219060] AMD-Vi: DTE[0]: 7590000000000003
[   11.219061] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219062] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219063] AMD-Vi: DTE[3]: 0000000000000000
[   11.219064] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06540 flags=0x0080]
[   11.219066] AMD-Vi: DTE[0]: 7590000000000003
[   11.219067] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219068] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219069] AMD-Vi: DTE[3]: 0000000000000000
[   11.219070] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06680 flags=0x0080]
[   11.219072] AMD-Vi: DTE[0]: 7590000000000003
[   11.219073] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219074] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219075] AMD-Vi: DTE[3]: 0000000000000000
[   11.219077] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06140 flags=0x0080]
[   11.219079] AMD-Vi: DTE[0]: 7590000000000003
[   11.219080] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219081] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219082] AMD-Vi: DTE[3]: 0000000000000000
[   11.219083] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06400 flags=0x0080]
[   11.219085] AMD-Vi: DTE[0]: 7590000000000003
[   11.219086] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219088] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219089] AMD-Vi: DTE[3]: 0000000000000000
[   11.219090] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea065c0 flags=0x0080]
[   11.219092] AMD-Vi: DTE[0]: 7590000000000003
[   11.219093] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219094] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219095] AMD-Vi: DTE[3]: 0000000000000000
[   11.219096] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06280 flags=0x0080]
[   11.219099] AMD-Vi: DTE[0]: 7590000000000003
[   11.219100] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219101] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219102] AMD-Vi: DTE[3]: 0000000000000000
[   11.219103] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06300 flags=0x0080]
[   11.219105] AMD-Vi: DTE[0]: 7590000000000003
[   11.219106] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219107] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219109] AMD-Vi: DTE[3]: 0000000000000000
[   11.219110] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06480 flags=0x0080]
[   11.219112] AMD-Vi: DTE[0]: 7590000000000003
[   11.219113] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219114] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219115] AMD-Vi: DTE[3]: 0000000000000000
[   11.219117] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06380 flags=0x0080]
[   11.219119] AMD-Vi: DTE[0]: 7590000000000003
[   11.219120] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219121] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219122] AMD-Vi: DTE[3]: 0000000000000000
[   11.219123] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06500 flags=0x0080]
[   11.219126] AMD-Vi: DTE[0]: 7590000000000003
[   11.219127] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219128] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219129] AMD-Vi: DTE[3]: 0000000000000000
[   11.219130] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea066c0 flags=0x0080]
[   11.219132] AMD-Vi: DTE[0]: 7590000000000003
[   11.219133] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219134] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219135] AMD-Vi: DTE[3]: 0000000000000000
[   11.219137] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06640 flags=0x0080]
[   11.219139] AMD-Vi: DTE[0]: 7590000000000003
[   11.219140] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219141] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219142] AMD-Vi: DTE[3]: 0000000000000000
[   11.219144] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06740 flags=0x0080]
[   11.219146] AMD-Vi: DTE[0]: 7590000000000003
[   11.219147] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219149] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219150] AMD-Vi: DTE[3]: 0000000000000000
[   11.219151] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06340 flags=0x0080]
[   11.219154] AMD-Vi: DTE[0]: 7590000000000003
[   11.219155] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219156] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219157] AMD-Vi: DTE[3]: 0000000000000000
[   11.219158] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06080 flags=0x0080]
[   11.219161] AMD-Vi: DTE[0]: 7590000000000003
[   11.219162] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219163] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219165] AMD-Vi: DTE[3]: 0000000000000000
[   11.219166] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea063c0 flags=0x0080]
[   11.219168] AMD-Vi: DTE[0]: 7590000000000003
[   11.219169] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219170] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219171] AMD-Vi: DTE[3]: 0000000000000000
[   11.219172] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06040 flags=0x0080]
[   11.219174] AMD-Vi: DTE[0]: 7590000000000003
[   11.219176] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219177] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219178] AMD-Vi: DTE[3]: 0000000000000000
[   11.219179] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06700 flags=0x0080]
[   11.219181] AMD-Vi: DTE[0]: 7590000000000003
[   11.219182] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219183] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219184] AMD-Vi: DTE[3]: 0000000000000000
[   11.219186] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06100 flags=0x0080]
[   11.219188] AMD-Vi: DTE[0]: 7590000000000003
[   11.219189] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219190] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219191] AMD-Vi: DTE[3]: 0000000000000000
[   11.219192] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06780 flags=0x0080]
[   11.219194] AMD-Vi: DTE[0]: 7590000000000003
[   11.219196] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219197] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219198] AMD-Vi: DTE[3]: 0000000000000000
[   11.219199] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06580 flags=0x0080]
[   11.219201] AMD-Vi: DTE[0]: 7590000000000003
[   11.219202] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219203] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219204] AMD-Vi: DTE[3]: 0000000000000000
[   11.219205] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06a00 flags=0x0080]
[   11.219208] AMD-Vi: DTE[0]: 7590000000000003
[   11.219209] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219210] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219211] AMD-Vi: DTE[3]: 0000000000000000
[   11.219212] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06800 flags=0x0080]
[   11.219214] AMD-Vi: DTE[0]: 7590000000000003
[   11.219216] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219217] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219218] AMD-Vi: DTE[3]: 0000000000000000
[   11.219219] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06840 flags=0x0080]
[   11.219221] AMD-Vi: DTE[0]: 7590000000000003
[   11.219222] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219223] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219224] AMD-Vi: DTE[3]: 0000000000000000
[   11.219225] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06880 flags=0x0080]
[   11.219228] AMD-Vi: DTE[0]: 7590000000000003
[   11.219229] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219230] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219231] AMD-Vi: DTE[3]: 0000000000000000
[   11.219233] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea068c0 flags=0x0080]
[   11.219235] AMD-Vi: DTE[0]: 7590000000000003
[   11.219236] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219237] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219238] AMD-Vi: DTE[3]: 0000000000000000
[   11.219239] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06900 flags=0x0080]
[   11.219242] AMD-Vi: DTE[0]: 7590000000000003
[   11.219243] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219244] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219245] AMD-Vi: DTE[3]: 0000000000000000
[   11.219246] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06940 flags=0x0080]
[   11.219248] AMD-Vi: DTE[0]: 7590000000000003
[   11.219249] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219251] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219252] AMD-Vi: DTE[3]: 0000000000000000
[   11.219254] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06980 flags=0x0080]
[   11.219256] AMD-Vi: DTE[0]: 7590000000000003
[   11.219257] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219258] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219259] AMD-Vi: DTE[3]: 0000000000000000
[   11.219260] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea069c0 flags=0x0080]
[   11.219263] AMD-Vi: DTE[0]: 7590000000000003
[   11.219264] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219265] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219266] AMD-Vi: DTE[3]: 0000000000000000
[   11.219267] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06c00 flags=0x0080]
[   11.219270] AMD-Vi: DTE[0]: 7590000000000003
[   11.219271] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219273] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219274] AMD-Vi: DTE[3]: 0000000000000000
[   11.219275] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06c40 flags=0x0080]
[   11.219277] AMD-Vi: DTE[0]: 7590000000000003
[   11.219279] AMD-Vi: DTE[1]: 0000100103c30002
[   11.219280] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.219281] AMD-Vi: DTE[3]: 0000000000000000
[   11.219282] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06c80 flags=0x0080]
[   11.219293] AMD-Vi: DTE[0]: 7590000000000003
[   11.219621] [drm:amdgpu_device_init [amdgpu]] *ERROR* hw_init of IP block <gfx_v8_0> failed -110
[   11.221525] AMD-Vi: DTE[1]: 0000100103c30002
[   11.221681] amdgpu 0000:00:01.0: amdgpu: amdgpu_device_ip_init failed
[   11.221862] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.222010] amdgpu 0000:00:01.0: amdgpu: Fatal error during GPU init
[   11.222423] AMD-Vi: DTE[3]: 0000000000000000
[   11.222576] amdgpu 0000:00:01.0: amdgpu: amdgpu: finishing device.
[   11.222718] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06cc0 flags=0x0080]
[   11.223045] ------------[ cut here ]------------
[   11.223050] AMD-Vi: DTE[0]: 7590000000000003
[   11.223465] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.225721] AMD-Vi: DTE[1]: 0000100103c30002
[   11.225871] Modules linked in:
[   11.226016] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.226163]  amdgpu(+)
[   11.226309] AMD-Vi: DTE[3]: 0000000000000000
[   11.226724]  i2c_algo_bit
[   11.226871] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06d00 flags=0x0080]
[   11.227016]  drm_exec
[   11.227162] AMD-Vi: DTE[0]: 7590000000000003
[   11.227309]  drm_suballoc_helper
[   11.227723] AMD-Vi: DTE[1]: 0000100103c30002
[   11.227870]  amdxcp
[   11.228016] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.228162]  input_leds
[   11.228308] AMD-Vi: DTE[3]: 0000000000000000
[   11.228851]  drm_buddy
[   11.229002] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06d40 flags=0x0080]
[   11.229151]  led_class
[   11.229338] AMD-Vi: DTE[0]: 7590000000000003
[   11.229484]  psmouse
[   11.229899] AMD-Vi: DTE[1]: 0000100103c30002
[   11.230045]  serio_raw
[   11.230191] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.230338]  gpu_sched
[   11.230483] AMD-Vi: DTE[3]: 0000000000000000
[   11.230898]  drm_display_helper
[   11.231045] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06d80 flags=0x0080]
[   11.231191]  video
[   11.231337] AMD-Vi: DTE[0]: 7590000000000003
[   11.231483]  wmi
[   11.231898] AMD-Vi: DTE[1]: 0000100103c30002

[   11.232190] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.232339] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.232537] AMD-Vi: DTE[3]: 0000000000000000
[   11.232540] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06dc0 flags=0x0080]
[   11.232994] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.233141] AMD-Vi: DTE[0]: 7590000000000003
[   11.233288] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.235040] AMD-Vi: DTE[1]: 0000100103c30002
[   11.235189] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.235334] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.235480] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.235626] AMD-Vi: DTE[3]: 0000000000000000

[   11.236188] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06a40 flags=0x0080]
[   11.236334] RAX: ffff88810919c340 RBX: ffff88810e99bbc8 RCX: 0000000000000000
[   11.236547] AMD-Vi: DTE[0]: 7590000000000003
[   11.236702] RDX: 0000000000000000 RSI: ffff88810e9aeb08 RDI: ffff88810e980000
[   11.237154] AMD-Vi: DTE[1]: 0000100103c30002
[   11.237301] RBP: ffff88810e991d38 R08: 0000000000000001 R09: 0000000000000000
[   11.237447] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.237593] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.237739] AMD-Vi: DTE[3]: 0000000000000000
[   11.238154] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9aeb08
[   11.238302] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06a80 flags=0x0080]
[   11.238447] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.238593] AMD-Vi: DTE[0]: 7590000000000003
[   11.238739] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.239154] AMD-Vi: DTE[1]: 0000100103c30002
[   11.239300] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.239447] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.239593] Call Trace:
[   11.239739] AMD-Vi: DTE[3]: 0000000000000000
[   11.240162]  <TASK>
[   11.240300] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06ac0 flags=0x0080]
[   11.240448]  ? __warn+0x9c/0x1b0
[   11.240653] AMD-Vi: DTE[0]: 7590000000000003
[   11.240803]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.242594] AMD-Vi: DTE[1]: 0000100103c30002
[   11.242745]  ? report_bug+0x188/0x1b0
[   11.242888] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.243303]  ? handle_bug+0x3a/0x70
[   11.243448] AMD-Vi: DTE[3]: 0000000000000000
[   11.243595]  ? exc_invalid_op+0x17/0x70
[   11.243742] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06b00 flags=0x0080]
[   11.243888]  ? asm_exc_invalid_op+0x16/0x20
[   11.244302] AMD-Vi: DTE[0]: 7590000000000003
[   11.244450]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.246463] AMD-Vi: DTE[1]: 0000100103c30002
[   11.246615]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.248581] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.248778]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.250675] AMD-Vi: DTE[3]: 0000000000000000
[   11.250826]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.252826] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06b40 flags=0x0080]
[   11.252967]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.254859] AMD-Vi: DTE[0]: 7590000000000003
[   11.255012]  local_pci_probe+0x53/0xb0
[   11.255152] AMD-Vi: DTE[1]: 0000100103c30002
[   11.255300]  pci_device_probe+0xbc/0x1d0
[   11.255444] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.255861]  really_probe+0xda/0x390
[   11.256005] AMD-Vi: DTE[3]: 0000000000000000
[   11.256152]  ? pm_runtime_barrier+0x61/0xb0
[   11.256299] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06b80 flags=0x0080]
[   11.256445]  ? __pfx___driver_attach+0x10/0x10
[   11.257008] AMD-Vi: DTE[0]: 7590000000000003
[   11.257152]  __driver_probe_device+0x78/0x150
[   11.257339] AMD-Vi: DTE[1]: 0000100103c30002
[   11.257486]  driver_probe_device+0x2d/0xb0
[   11.257631] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.258047]  __driver_attach+0xdc/0x1d0
[   11.258192] AMD-Vi: DTE[3]: 0000000000000000
[   11.258339]  bus_for_each_dev+0x6a/0xb0
[   11.258485] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06bc0 flags=0x0080]
[   11.258632]  bus_add_driver+0x139/0x260
[   11.259046] AMD-Vi: DTE[0]: 7590000000000003
[   11.259193]  driver_register+0x55/0x100
[   11.259338] AMD-Vi: DTE[1]: 0000100103c30002
[   11.259485]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.261411] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.261605]  do_one_initcall+0x60/0x2c0
[   11.261748] AMD-Vi: DTE[3]: 0000000000000000
[   11.261897]  ? kmalloc_trace_noprof+0x272/0x330
[   11.262311] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06ec0 flags=0x0080]
[   11.262456]  ? do_init_module+0x22/0x230
[   11.262602] AMD-Vi: DTE[0]: 7590000000000003
[   11.262751]  do_init_module+0x60/0x230
[   11.262894] AMD-Vi: DTE[1]: 0000100103c30002
[   11.263310]  init_module_from_file+0x89/0xc0
[   11.263455] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.263604]  idempotent_init_module+0xf9/0x270
[   11.263748] AMD-Vi: DTE[3]: 0000000000000000
[   11.263896]  __x64_sys_finit_module+0x7b/0xf0
[   11.264309] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06e00 flags=0x0080]
[   11.264455]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.264652] AMD-Vi: DTE[0]: 7590000000000003
[   11.264830]  do_syscall_64+0x64/0x130
[   11.264975] AMD-Vi: DTE[1]: 0000100103c30002
[   11.265392]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.265536] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.265684] RIP: 0033:0x7fa236745059
[   11.265829] AMD-Vi: DTE[3]: 0000000000000000
[   11.265977] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.266390] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06e40 flags=0x0080]
[   11.266536] RSP: 002b:00007fff70147348 EFLAGS: 00000246
[   11.266682] AMD-Vi: DTE[0]: 7590000000000003
[   11.266828]  ORIG_RAX: 0000000000000139
[   11.266975] AMD-Vi: DTE[1]: 0000100103c30002
[   11.267389] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.267536] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.267682] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.267828] AMD-Vi: DTE[3]: 0000000000000000
[   11.267974] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.268389] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06e80 flags=0x0080]
[   11.268584] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.268771] AMD-Vi: DTE[0]: 7590000000000003
[   11.268917] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.269064] AMD-Vi: DTE[1]: 0000100103c30002
[   11.269481]  </TASK>
[   11.269625] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.269772] irq event stamp: 0
[   11.269917] AMD-Vi: DTE[3]: 0000000000000000
[   11.270063] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.270479] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06f00 flags=0x0080]
[   11.270624] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.270770] AMD-Vi: DTE[0]: 7590000000000003
[   11.270917] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.271063] AMD-Vi: DTE[1]: 0000100103c30002
[   11.271478] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.271624] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.271770] ---[ end trace 0000000000000000 ]---
[   11.271916] AMD-Vi: DTE[3]: 0000000000000000
[   11.272163] ------------[ cut here ]------------
[   11.272522] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06f40 flags=0x0080]
[   11.272682] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.274622] AMD-Vi: DTE[0]: 7590000000000003
[   11.274769] Modules linked in:
[   11.274915] AMD-Vi: DTE[1]: 0000100103c30002
[   11.275062]  amdgpu(+)
[   11.275208] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.275623]  i2c_algo_bit
[   11.275769] AMD-Vi: DTE[3]: 0000000000000000
[   11.275915]  drm_exec
[   11.276062] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06f80 flags=0x0080]
[   11.276207]  drm_suballoc_helper
[   11.276690] AMD-Vi: DTE[0]: 7590000000000003
[   11.276841]  amdxcp
[   11.276991] AMD-Vi: DTE[1]: 0000100103c30002
[   11.277178]  input_leds
[   11.277324] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.277739]  drm_buddy
[   11.277885] AMD-Vi: DTE[3]: 0000000000000000
[   11.278031]  led_class
[   11.278178] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06fc0 flags=0x0080]
[   11.278324]  psmouse
[   11.278738] AMD-Vi: DTE[0]: 7590000000000003
[   11.278885]  serio_raw
[   11.279031] AMD-Vi: DTE[1]: 0000100103c30002
[   11.279177]  gpu_sched
[   11.279323] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.279738]  drm_display_helper
[   11.279884] AMD-Vi: DTE[3]: 0000000000000000
[   11.280031]  video
[   11.280177] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07200 flags=0x0080]
[   11.280323]  wmi
[   11.280871] AMD-Vi: DTE[0]: 7590000000000003

[   11.281158] AMD-Vi: DTE[1]: 0000100103c30002
[   11.281347] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.281492] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.281907] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.282053] AMD-Vi: DTE[3]: 0000000000000000
[   11.282203] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.283960] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea060c0 flags=0x0080]
[   11.284107] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.284253] AMD-Vi: DTE[0]: 7590000000000003
[   11.284400] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.284606] AMD-Vi: DTE[1]: 0000100103c30002

[   11.285211] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.285357] RAX: ffff88810919c348 RBX: ffff88810e99c500 RCX: 0000000000000000
[   11.285503] AMD-Vi: DTE[3]: 0000000000000000
[   11.285650] RDX: 0000000000000002 RSI: ffff88810e9aeb08 RDI: ffff88810e980000
[   11.286066] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea067c0 flags=0x0080]
[   11.286211] RBP: ffff88810e991d40 R08: 0000000000000001 R09: 0000000000000000
[   11.286357] AMD-Vi: DTE[0]: 7590000000000003
[   11.286503] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.286649] AMD-Vi: DTE[1]: 0000100103c30002
[   11.287064] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9aeb08
[   11.287210] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.287357] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.287503] AMD-Vi: DTE[3]: 0000000000000000
[   11.287649] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.288064] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06180 flags=0x0080]
[   11.288210] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.288356] AMD-Vi: DTE[0]: 7590000000000003
[   11.288558] Call Trace:
[   11.288708] AMD-Vi: DTE[1]: 0000100103c30002
[   11.289165]  <TASK>
[   11.289305] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.289453]  ? __warn+0x9c/0x1b0
[   11.289597] AMD-Vi: DTE[3]: 0000000000000000
[   11.289744]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.291495] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea062c0 flags=0x0080]
[   11.291643]  ? report_bug+0x188/0x1b0
[   11.291787] AMD-Vi: DTE[0]: 7590000000000003
[   11.292203]  ? handle_bug+0x3a/0x70
[   11.292348] AMD-Vi: DTE[1]: 0000100103c30002
[   11.292551]  ? exc_invalid_op+0x17/0x70
[   11.292705] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.292890]  ? asm_exc_invalid_op+0x16/0x20
[   11.293304] AMD-Vi: DTE[3]: 0000000000000000
[   11.293452]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.295353] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea061c0 flags=0x0080]
[   11.295502]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.297602] AMD-Vi: DTE[0]: 7590000000000003
[   11.297758]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.299655] AMD-Vi: DTE[1]: 0000100103c30002
[   11.299808]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.301826] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.301981]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.303879] AMD-Vi: DTE[3]: 0000000000000000
[   11.304031]  local_pci_probe+0x53/0xb0
[   11.304322] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06600 flags=0x0080]
[   11.304536]  pci_device_probe+0xbc/0x1d0
[   11.304797] AMD-Vi: DTE[0]: 7590000000000003
[   11.304946]  really_probe+0xda/0x390
[   11.305158] AMD-Vi: DTE[1]: 0000100103c30002
[   11.305306]  ? pm_runtime_barrier+0x61/0xb0
[   11.305514] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.305929]  ? __pfx___driver_attach+0x10/0x10
[   11.306086] AMD-Vi: DTE[3]: 0000000000000000
[   11.306233]  __driver_probe_device+0x78/0x150
[   11.306591] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06440 flags=0x0080]
[   11.306737]  driver_probe_device+0x2d/0xb0
[   11.306843] AMD-Vi: DTE[0]: 7590000000000003
[   11.306990]  __driver_attach+0xdc/0x1d0
[   11.307073] AMD-Vi: DTE[1]: 0000100103c30002
[   11.307220]  bus_for_each_dev+0x6a/0xb0
[   11.307311] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.307728]  bus_add_driver+0x139/0x260
[   11.307806] AMD-Vi: DTE[3]: 0000000000000000
[   11.307954]  driver_register+0x55/0x100
[   11.308065] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea064c0 flags=0x0080]
[   11.308212]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.310144] AMD-Vi: DTE[0]: 7590000000000003
[   11.310334]  do_one_initcall+0x60/0x2c0
[   11.310443] AMD-Vi: DTE[1]: 0000100103c30002
[   11.310859]  ? kmalloc_trace_noprof+0x272/0x330
[   11.310930] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.311076]  ? do_init_module+0x22/0x230
[   11.311142] AMD-Vi: DTE[3]: 0000000000000000
[   11.311291]  do_init_module+0x60/0x230
[   11.311345] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06200 flags=0x0080]
[   11.311491]  init_module_from_file+0x89/0xc0
[   11.311773] AMD-Vi: DTE[0]: 7590000000000003
[   11.311922]  idempotent_init_module+0xf9/0x270
[   11.312334] AMD-Vi: DTE[1]: 0000100103c30002
[   11.312675]  __x64_sys_finit_module+0x7b/0xf0
[   11.312828] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.313010]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.313194] AMD-Vi: DTE[3]: 0000000000000000
[   11.313818]  do_syscall_64+0x64/0x130
[   11.313964] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea06240 flags=0x0080]
[   11.314143]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.314288] AMD-Vi: DTE[0]: 7590000000000003
[   11.314344] RIP: 0033:0x7fa236745059
[   11.314757] AMD-Vi: DTE[1]: 0000100103c30002
[   11.314998] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.315144] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.315385] RSP: 002b:00007fff70147348 EFLAGS: 00000246
[   11.315531] AMD-Vi: DTE[3]: 0000000000000000
[   11.315772]  ORIG_RAX: 0000000000000139
[   11.315918] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07100 flags=0x0080]
[   11.316158] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.316304] AMD-Vi: DTE[0]: 7590000000000003
[   11.316590] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.317046] AMD-Vi: DTE[1]: 0000100103c30002
[   11.317318] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.317464] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.317659] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.317805] AMD-Vi: DTE[3]: 0000000000000000
[   11.318046] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.318193] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07000 flags=0x0080]
[   11.318281]  </TASK>
[   11.318425] AMD-Vi: DTE[0]: 7590000000000003
[   11.318501] irq event stamp: 0
[   11.318914] AMD-Vi: DTE[1]: 0000100103c30002
[   11.319026] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.319173] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.319330] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.319477] AMD-Vi: DTE[3]: 0000000000000000
[   11.319603] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.319749] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07040 flags=0x0080]
[   11.319870] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.320016] AMD-Vi: DTE[0]: 7590000000000003
[   11.320148] ---[ end trace 0000000000000000 ]---
[   11.320609] AMD-Vi: DTE[1]: 0000100103c30002
[   11.320893] ------------[ cut here ]------------
[   11.320937] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.321094] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.322850] AMD-Vi: DTE[3]: 0000000000000000
[   11.322853] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07080 flags=0x0080]
[   11.322981] Modules linked in:
[   11.323127] AMD-Vi: DTE[0]: 7590000000000003
[   11.323263]  amdgpu(+)
[   11.323409] AMD-Vi: DTE[1]: 0000100103c30002
[   11.323532]  i2c_algo_bit
[   11.323678] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.323822]  drm_exec
[   11.324237] AMD-Vi: DTE[3]: 0000000000000000
[   11.324389]  drm_suballoc_helper
[   11.324593] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea070c0 flags=0x0080]
[   11.324749]  amdxcp
[   11.324932] AMD-Vi: DTE[0]: 7590000000000003
[   11.325073]  input_leds
[   11.325219] AMD-Vi: DTE[1]: 0000100103c30002
[   11.325351]  drm_buddy
[   11.325497] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.325629]  led_class
[   11.326044] AMD-Vi: DTE[3]: 0000000000000000
[   11.326176]  psmouse
[   11.326322] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07580 flags=0x0080]
[   11.326454]  serio_raw
[   11.326600] AMD-Vi: DTE[0]: 7590000000000003
[   11.326766]  gpu_sched
[   11.326912] AMD-Vi: DTE[1]: 0000100103c30002
[   11.327044]  drm_display_helper
[   11.327190] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.327345]  video
[   11.327760] AMD-Vi: DTE[3]: 0000000000000000
[   11.327895]  wmi
[   11.328041] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea074c0 flags=0x0080]

[   11.328316] AMD-Vi: DTE[0]: 7590000000000003
[   11.328519] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.328533] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.328536] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.330401] AMD-Vi: DTE[1]: 0000100103c30002
[   11.330549] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.330671] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.330818] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.331441] AMD-Vi: DTE[3]: 0000000000000000

[   11.332035] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07800 flags=0x0080]
[   11.332180] RAX: ffff88810919c34c RBX: ffff88810e99c998 RCX: 0000000000000000
[   11.332312] AMD-Vi: DTE[0]: 7590000000000003
[   11.332458] RDX: 0000000000000003 RSI: ffff88810e9aeb08 RDI: ffff88810e980000
[   11.332839] AMD-Vi: DTE[1]: 0000100103c30002
[   11.332990] RBP: ffff88810e991d48 R08: 0000000000000001 R09: 0000000000000000
[   11.333274] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.333421] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.333661] AMD-Vi: DTE[3]: 0000000000000000
[   11.334076] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9aeb08
[   11.334317] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07140 flags=0x0080]
[   11.334463] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.334703] AMD-Vi: DTE[0]: 7590000000000003
[   11.334849] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.334927] AMD-Vi: DTE[1]: 0000100103c30002
[   11.335073] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.335179] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.335326] Call Trace:
[   11.335537] AMD-Vi: DTE[3]: 0000000000000000
[   11.335958]  <TASK>
[   11.336227] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07180 flags=0x0080]
[   11.336374]  ? __warn+0x9c/0x1b0
[   11.336697] AMD-Vi: DTE[0]: 7590000000000003
[   11.336700] AMD-Vi: DTE[1]: 0000100103c30002
[   11.336850]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.338676] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.338786]  ? report_bug+0x188/0x1b0
[   11.338930] AMD-Vi: DTE[3]: 0000000000000000
[   11.339015]  ? handle_bug+0x3a/0x70
[   11.339161] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea072c0 flags=0x0080]
[   11.339252]  ? exc_invalid_op+0x17/0x70
[   11.339398] AMD-Vi: DTE[0]: 7590000000000003
[   11.339479]  ? asm_exc_invalid_op+0x16/0x20
[   11.339893] AMD-Vi: DTE[1]: 0000100103c30002
[   11.340007]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.342014] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.342140]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.343925] AMD-Vi: DTE[3]: 0000000000000000
[   11.344198]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.346080] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07280 flags=0x0080]
[   11.346239]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.347946] AMD-Vi: DTE[0]: 7590000000000003
[   11.348192]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.350148] AMD-Vi: DTE[1]: 0000100103c30002
[   11.350302]  local_pci_probe+0x53/0xb0
[   11.350381] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.350530]  pci_device_probe+0xbc/0x1d0
[   11.350603] AMD-Vi: DTE[3]: 0000000000000000
[   11.350750]  really_probe+0xda/0x390
[   11.350863] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07340 flags=0x0080]
[   11.351008]  ? pm_runtime_barrier+0x61/0xb0
[   11.351165] AMD-Vi: DTE[0]: 7590000000000003
[   11.351580]  ? __pfx___driver_attach+0x10/0x10
[   11.351706] AMD-Vi: DTE[1]: 0000100103c30002
[   11.351853]  __driver_probe_device+0x78/0x150
[   11.351973] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.352120]  driver_probe_device+0x2d/0xb0
[   11.352252] AMD-Vi: DTE[3]: 0000000000000000
[   11.352399]  __driver_attach+0xdc/0x1d0
[   11.352593] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07380 flags=0x0080]
[   11.352786]  bus_for_each_dev+0x6a/0xb0
[   11.352943] AMD-Vi: DTE[0]: 7590000000000003
[   11.353359]  bus_add_driver+0x139/0x260
[   11.353589] AMD-Vi: DTE[1]: 0000100103c30002
[   11.353736]  driver_register+0x55/0x100
[   11.353910] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.354058]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.355837] AMD-Vi: DTE[3]: 0000000000000000
[   11.355840] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07300 flags=0x0080]
[   11.355984]  do_one_initcall+0x60/0x2c0
[   11.356130] AMD-Vi: DTE[0]: 7590000000000003
[   11.356282]  ? kmalloc_trace_noprof+0x272/0x330
[   11.356428] AMD-Vi: DTE[1]: 0000100103c30002
[   11.356646]  ? do_init_module+0x22/0x230
[   11.357102] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.357244]  do_init_module+0x60/0x230
[   11.357388] AMD-Vi: DTE[3]: 0000000000000000
[   11.357522]  init_module_from_file+0x89/0xc0
[   11.357668] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea077c0 flags=0x0080]
[   11.357802]  idempotent_init_module+0xf9/0x270
[   11.357945] AMD-Vi: DTE[0]: 7590000000000003
[   11.358080]  __x64_sys_finit_module+0x7b/0xf0
[   11.358224] AMD-Vi: DTE[1]: 0000100103c30002
[   11.358356]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.358771] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.358938]  do_syscall_64+0x64/0x130
[   11.359084] AMD-Vi: DTE[3]: 0000000000000000
[   11.359218]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.359363] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07680 flags=0x0080]
[   11.359519] RIP: 0033:0x7fa236745059
[   11.359665] AMD-Vi: DTE[0]: 7590000000000003
[   11.359800] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.359946] AMD-Vi: DTE[1]: 0000100103c30002
[   11.360076] RSP: 002b:00007fff70147348 EFLAGS: 00000246
[   11.360541] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.360544] AMD-Vi: DTE[3]: 0000000000000000
[   11.360546] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07640 flags=0x0080]
[   11.360696]  ORIG_RAX: 0000000000000139
[   11.360881] AMD-Vi: DTE[0]: 7590000000000003
[   11.361033] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.361179] AMD-Vi: DTE[1]: 0000100103c30002
[   11.361329] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.361474] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.361638] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.361784] AMD-Vi: DTE[3]: 0000000000000000
[   11.361911] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.362326] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07700 flags=0x0080]
[   11.362498] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.362644] AMD-Vi: DTE[0]: 7590000000000003
[   11.362770]  </TASK>
[   11.362914] AMD-Vi: DTE[1]: 0000100103c30002
[   11.363538] irq event stamp: 0
[   11.363683] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.363861] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.364007] AMD-Vi: DTE[3]: 0000000000000000
[   11.364139] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.364601] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea076c0 flags=0x0080]
[   11.364883] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.365030] AMD-Vi: DTE[0]: 7590000000000003
[   11.365270] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.365416] AMD-Vi: DTE[1]: 0000100103c30002
[   11.365657] ---[ end trace 0000000000000000 ]---
[   11.365803] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.366149] ------------[ cut here ]------------
[   11.366190] AMD-Vi: DTE[3]: 0000000000000000
[   11.366431] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.368191] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07780 flags=0x0080]
[   11.368522] Modules linked in: amdgpu(+)
[   11.369003] AMD-Vi: DTE[0]: 7590000000000003
[   11.369209]  i2c_algo_bit
[   11.369355] AMD-Vi: DTE[1]: 0000100103c30002
[   11.369513]  drm_exec
[   11.369659] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.369817]  drm_suballoc_helper
[   11.369963] AMD-Vi: DTE[3]: 0000000000000000
[   11.370321]  amdxcp
[   11.370468] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07740 flags=0x0080]
[   11.370881]  input_leds
[   11.370988] AMD-Vi: DTE[0]: 7590000000000003
[   11.371134]  drm_buddy
[   11.371217] AMD-Vi: DTE[1]: 0000100103c30002
[   11.371363]  led_class
[   11.371455] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.371602]  psmouse
[   11.371682] AMD-Vi: DTE[3]: 0000000000000000
[   11.371829]  serio_raw
[   11.371940] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07a40 flags=0x0080]
[   11.372355]  gpu_sched
[   11.372430] AMD-Vi: DTE[0]: 7590000000000003
[   11.372633]  drm_display_helper video wmi
[   11.372727] AMD-Vi: DTE[1]: 0000100103c30002
[   11.372914] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.372996] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.373143] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.373226] AMD-Vi: DTE[3]: 0000000000000000
[   11.373373] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.375345] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07a80 flags=0x0080]
[   11.375400] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.375546] AMD-Vi: DTE[0]: 7590000000000003
[   11.375829] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.376095] AMD-Vi: DTE[1]: 0000100103c30002

[   11.376419] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.377184] RAX: ffff88810919c350 RBX: ffff88810e99ce30 RCX: 0000000000000000
[   11.377336] AMD-Vi: DTE[3]: 0000000000000000
[   11.377553] RDX: 0000000000000004 RSI: ffff88810e9aeb08 RDI: ffff88810e980000
[   11.377700] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07840 flags=0x0080]
[   11.377754] RBP: ffff88810e991d50 R08: 0000000000000001 R09: 0000000000000000
[   11.378169] AMD-Vi: DTE[0]: 7590000000000003
[   11.378410] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.378556] AMD-Vi: DTE[1]: 0000100103c30002
[   11.378796] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9aeb08
[   11.378942] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.379183] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.379329] AMD-Vi: DTE[3]: 0000000000000000
[   11.379570] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.379716] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07880 flags=0x0080]
[   11.379956] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.380371] AMD-Vi: DTE[0]: 7590000000000003
[   11.380692] Call Trace:
[   11.380842] AMD-Vi: DTE[1]: 0000100103c30002
[   11.381047]  <TASK>
[   11.381225] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.381467]  ? __warn+0x9c/0x1b0
[   11.381611] AMD-Vi: DTE[3]: 0000000000000000
[   11.381698]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.383539] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07a00 flags=0x0080]
[   11.383957]  ? report_bug+0x188/0x1b0
[   11.384086] AMD-Vi: DTE[0]: 7590000000000003
[   11.384233]  ? handle_bug+0x3a/0x70
[   11.384376] AMD-Vi: DTE[1]: 0000100103c30002
[   11.384594]  ? exc_invalid_op+0x17/0x70
[   11.384798] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.384944]  ? asm_exc_invalid_op+0x16/0x20
[   11.385136] AMD-Vi: DTE[3]: 0000000000000000
[   11.385284]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.387117] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07900 flags=0x0080]
[   11.387243]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.389167] AMD-Vi: DTE[0]: 7590000000000003
[   11.389627]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.391369] AMD-Vi: DTE[1]: 0000100103c30002
[   11.391520]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.393455] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.393612]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.395872] AMD-Vi: DTE[3]: 0000000000000000
[   11.396024]  local_pci_probe+0x53/0xb0
[   11.396198] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea078c0 flags=0x0080]
[   11.396344]  pci_device_probe+0xbc/0x1d0
[   11.396551] AMD-Vi: DTE[0]: 7590000000000003
[   11.397015]  really_probe+0xda/0x390
[   11.397145] AMD-Vi: DTE[1]: 0000100103c30002
[   11.397293]  ? pm_runtime_barrier+0x61/0xb0
[   11.397532] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.397679]  ? __pfx___driver_attach+0x10/0x10
[   11.397919] AMD-Vi: DTE[3]: 0000000000000000
[   11.398065]  __driver_probe_device+0x78/0x150
[   11.398306] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07980 flags=0x0080]
[   11.398453]  driver_probe_device+0x2d/0xb0
[   11.398693] AMD-Vi: DTE[0]: 7590000000000003
[   11.399108]  __driver_attach+0xdc/0x1d0
[   11.399348] AMD-Vi: DTE[1]: 0000100103c30002
[   11.399495]  bus_for_each_dev+0x6a/0xb0
[   11.399572] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.399720]  bus_add_driver+0x139/0x260
[   11.399825] AMD-Vi: DTE[3]: 0000000000000000
[   11.399972]  driver_register+0x55/0x100
[   11.400183] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07940 flags=0x0080]
[   11.400331]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.402247] AMD-Vi: DTE[0]: 7590000000000003
[   11.402408]  do_one_initcall+0x60/0x2c0
[   11.402552] AMD-Vi: DTE[1]: 0000100103c30002
[   11.402911]  ? kmalloc_trace_noprof+0x272/0x330
[   11.403324] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.403460]  ? do_init_module+0x22/0x230
[   11.403606] AMD-Vi: DTE[3]: 0000000000000000
[   11.403701]  do_init_module+0x60/0x230
[   11.403846] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07c40 flags=0x0080]
[   11.403926]  init_module_from_file+0x89/0xc0
[   11.404071] AMD-Vi: DTE[0]: 7590000000000003
[   11.404185]  idempotent_init_module+0xf9/0x270
[   11.404329] AMD-Vi: DTE[1]: 0000100103c30002
[   11.404406]  __x64_sys_finit_module+0x7b/0xf0
[   11.404971] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.405053]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.405237] AMD-Vi: DTE[3]: 0000000000000000
[   11.405321]  do_syscall_64+0x64/0x130
[   11.405468] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07c00 flags=0x0080]
[   11.405551]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.405696] AMD-Vi: DTE[0]: 7590000000000003
[   11.405775] RIP: 0033:0x7fa236745059
[   11.405921] AMD-Vi: DTE[1]: 0000100103c30002
[   11.406005] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.406419] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.406502] RSP: 002b:00007fff70147348 EFLAGS: 00000246
[   11.406648] AMD-Vi: DTE[3]: 0000000000000000
[   11.406786]  ORIG_RAX: 0000000000000139
[   11.406933] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07c80 flags=0x0080]
[   11.407216] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.407362] AMD-Vi: DTE[0]: 7590000000000003
[   11.407628] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.407774] AMD-Vi: DTE[1]: 0000100103c30002
[   11.407952] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.408367] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.409114] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.409264] AMD-Vi: DTE[3]: 0000000000000000
[   11.409480] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.409627] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea079c0 flags=0x0080]
[   11.409684]  </TASK>
[   11.409828] AMD-Vi: DTE[0]: 7590000000000003
[   11.410069] irq event stamp: 0
[   11.410215] AMD-Vi: DTE[1]: 0000100103c30002
[   11.410455] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.410870] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.411111] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.411257] AMD-Vi: DTE[3]: 0000000000000000
[   11.411498] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.411644] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07d00 flags=0x0080]
[   11.411885] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.412031] AMD-Vi: DTE[0]: 7590000000000003
[   11.412303] ---[ end trace 0000000000000000 ]---
[   11.412449] AMD-Vi: DTE[1]: 0000100103c30002
[   11.412841] ------------[ cut here ]------------
[   11.413154] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.413395] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.415159] AMD-Vi: DTE[3]: 0000000000000000
[   11.415281] Modules linked in:
[   11.415428] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07cc0 flags=0x0080]
[   11.415559]  amdgpu(+)
[   11.415705] AMD-Vi: DTE[0]: 7590000000000003
[   11.415849]  i2c_algo_bit
[   11.415995] AMD-Vi: DTE[1]: 0000100103c30002
[   11.416153]  drm_exec
[   11.416648] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.416884]  drm_suballoc_helper
[   11.417030] AMD-Vi: DTE[3]: 0000000000000000
[   11.417205]  amdxcp
[   11.417352] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07d40 flags=0x0080]
[   11.417526]  input_leds
[   11.417672] AMD-Vi: DTE[0]: 7590000000000003
[   11.417835]  drm_buddy
[   11.417982] AMD-Vi: DTE[1]: 0000100103c30002
[   11.418111]  led_class
[   11.418525] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.418661]  psmouse
[   11.418807] AMD-Vi: DTE[3]: 0000000000000000
[   11.418930]  serio_raw
[   11.419077] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07d80 flags=0x0080]
[   11.419220]  gpu_sched
[   11.419366] AMD-Vi: DTE[0]: 7590000000000003
[   11.419518]  drm_display_helper
[   11.419664] AMD-Vi: DTE[1]: 0000100103c30002
[   11.419814]  video
[   11.420228] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.420369]  wmi
[   11.420591] AMD-Vi: DTE[3]: 0000000000000000

[   11.420914] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07dc0 flags=0x0080]
[   11.421047] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.421192] AMD-Vi: DTE[0]: 7590000000000003
[   11.421324] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.421470] AMD-Vi: DTE[1]: 0000100103c30002
[   11.421603] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.423374] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.423791] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.423936] AMD-Vi: DTE[3]: 0000000000000000
[   11.424082] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.424235] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea08000 flags=0x0080]

[   11.424595] AMD-Vi: DTE[0]: 7590000000000003
[   11.424789] RAX: ffff88810919c354 RBX: ffff88810e99d2c8 RCX: 0000000000000000
[   11.424952] AMD-Vi: DTE[1]: 0000100103c30002
[   11.425099] RDX: 0000000000000005 RSI: ffff88810e9aeb08 RDI: ffff88810e980000
[   11.425225] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.425640] RBP: ffff88810e991d58 R08: 0000000000000001 R09: 0000000000000000
[   11.425851] AMD-Vi: DTE[3]: 0000000000000000
[   11.425998] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.426122] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07ac0 flags=0x0080]
[   11.426267] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9aeb08
[   11.426890] AMD-Vi: DTE[0]: 7590000000000003
[   11.427037] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.427214] AMD-Vi: DTE[1]: 0000100103c30002
[   11.427361] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.427492] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.427907] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.428148] AMD-Vi: DTE[3]: 0000000000000000
[   11.428294] Call Trace:
[   11.428594] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07b00 flags=0x0080]
[   11.428787]  <TASK>
[   11.429021] AMD-Vi: DTE[0]: 7590000000000003
[   11.429169]  ? __warn+0x9c/0x1b0
[   11.429408] AMD-Vi: DTE[1]: 0000100103c30002
[   11.429555]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.431369] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.431519]  ? report_bug+0x188/0x1b0
[   11.431791] AMD-Vi: DTE[3]: 0000000000000000
[   11.432207]  ? handle_bug+0x3a/0x70
[   11.432419] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07b40 flags=0x0080]
[   11.432634]  ? exc_invalid_op+0x17/0x70
[   11.432834] AMD-Vi: DTE[0]: 7590000000000003
[   11.432980]  ? asm_exc_invalid_op+0x16/0x20
[   11.433137] AMD-Vi: DTE[1]: 0000100103c30002
[   11.433285]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.435056] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.435172]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.437009] AMD-Vi: DTE[3]: 0000000000000000
[   11.437472]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.439238] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07b80 flags=0x0080]
[   11.439429]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.441693] AMD-Vi: DTE[0]: 7590000000000003
[   11.441755]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.443760] AMD-Vi: DTE[1]: 0000100103c30002
[   11.444007]  local_pci_probe+0x53/0xb0
[   11.444148] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.444422]  pci_device_probe+0xbc/0x1d0
[   11.444636] AMD-Vi: DTE[3]: 0000000000000000
[   11.444876]  really_probe+0xda/0x390
[   11.445022] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07bc0 flags=0x0080]
[   11.445261]  ? pm_runtime_barrier+0x61/0xb0
[   11.445407] AMD-Vi: DTE[0]: 7590000000000003
[   11.445494]  ? __pfx___driver_attach+0x10/0x10
[   11.445908] AMD-Vi: DTE[1]: 0000100103c30002
[   11.445983]  __driver_probe_device+0x78/0x150
[   11.446129] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.446242]  driver_probe_device+0x2d/0xb0
[   11.446387] AMD-Vi: DTE[3]: 0000000000000000
[   11.446546]  __driver_attach+0xdc/0x1d0
[   11.446691] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07e00 flags=0x0080]
[   11.446819]  bus_for_each_dev+0x6a/0xb0
[   11.446964] AMD-Vi: DTE[0]: 7590000000000003
[   11.447086]  bus_add_driver+0x139/0x260
[   11.447499] AMD-Vi: DTE[1]: 0000100103c30002
[   11.447632]  driver_register+0x55/0x100
[   11.447777] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.447922]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.449825] AMD-Vi: DTE[3]: 0000000000000000
[   11.450045]  do_one_initcall+0x60/0x2c0
[   11.450192] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07e40 flags=0x0080]
[   11.450321]  ? kmalloc_trace_noprof+0x272/0x330
[   11.450466] AMD-Vi: DTE[0]: 7590000000000003
[   11.450601]  ? do_init_module+0x22/0x230
[   11.450747] AMD-Vi: DTE[1]: 0000100103c30002
[   11.450873]  do_init_module+0x60/0x230
[   11.451285] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.451430]  init_module_from_file+0x89/0xc0
[   11.451575] AMD-Vi: DTE[3]: 0000000000000000
[   11.451730]  idempotent_init_module+0xf9/0x270
[   11.451874] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07e80 flags=0x0080]
[   11.452025]  __x64_sys_finit_module+0x7b/0xf0
[   11.452169] AMD-Vi: DTE[0]: 7590000000000003
[   11.452310]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.452456] AMD-Vi: DTE[1]: 0000100103c30002
[   11.452650]  do_syscall_64+0x64/0x130
[   11.452658]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.453117] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.453250] RIP: 0033:0x7fa236745059
[   11.453395] AMD-Vi: DTE[3]: 0000000000000000
[   11.453528] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.453674] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07ec0 flags=0x0080]
[   11.453806] RSP: 002b:00007fff70147348 EFLAGS: 00000246
[   11.453952] AMD-Vi: DTE[0]: 7590000000000003
[   11.454119]  ORIG_RAX: 0000000000000139
[   11.454265] AMD-Vi: DTE[1]: 0000100103c30002
[   11.454396] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.454811] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.454966] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.455112] AMD-Vi: DTE[3]: 0000000000000000
[   11.455247] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.455394] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07f00 flags=0x0080]
[   11.455523] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.455669] AMD-Vi: DTE[0]: 7590000000000003
[   11.455815] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.455961] AMD-Vi: DTE[1]: 0000100103c30002
[   11.456116]  </TASK>
[   11.456580] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.456772] irq event stamp: 0
[   11.456917] AMD-Vi: DTE[3]: 0000000000000000
[   11.457080] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.457227] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07f40 flags=0x0080]
[   11.457353] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.457525] AMD-Vi: DTE[0]: 7590000000000003
[   11.457671] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.457795] AMD-Vi: DTE[1]: 0000100103c30002
[   11.457941] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.458564] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.458979] ---[ end trace 0000000000000000 ]---
[   11.459157] AMD-Vi: DTE[3]: 0000000000000000
[   11.459394] ------------[ cut here ]------------
[   11.459435] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07f80 flags=0x0080]
[   11.459581] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.461570] AMD-Vi: DTE[0]: 7590000000000003
[   11.461812] Modules linked in:
[   11.461958] AMD-Vi: DTE[1]: 0000100103c30002
[   11.462036]  amdgpu(+)
[   11.462182] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.462288]  i2c_algo_bit
[   11.462434] AMD-Vi: DTE[3]: 0000000000000000
[   11.462647]  drm_exec
[   11.463062] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07fc0 flags=0x0080]
[   11.463336]  drm_suballoc_helper
[   11.463482] AMD-Vi: DTE[0]: 7590000000000003
[   11.463757]  amdxcp
[   11.463903] AMD-Vi: DTE[1]: 0000100103c30002
[   11.464115]  input_leds
[   11.464261] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.464419]  drm_buddy
[   11.464623] AMD-Vi: DTE[3]: 0000000000000000
[   11.464826]  led_class
[   11.465241] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea08100 flags=0x0080]
[   11.465598]  psmouse
[   11.465744] AMD-Vi: DTE[0]: 7590000000000003
[   11.465851]  serio_raw
[   11.465997] AMD-Vi: DTE[1]: 0000100103c30002
[   11.466081]  gpu_sched
[   11.466227] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.466319]  drm_display_helper
[   11.466465] AMD-Vi: DTE[3]: 0000000000000000
[   11.466545]  video
[   11.466960] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea08040 flags=0x0080]
[   11.467072]  wmi
[   11.467218] AMD-Vi: DTE[0]: 7590000000000003

[   11.467439] AMD-Vi: DTE[1]: 0000100103c30002
[   11.467527] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.467671] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.467755] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.467901] AMD-Vi: DTE[3]: 0000000000000000
[   11.467985] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.470048] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea08080 flags=0x0080]
[   11.470152] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.470297] AMD-Vi: DTE[0]: 7590000000000003
[   11.470352] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.470498] AMD-Vi: DTE[1]: 0000100103c30002

[   11.470927] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.471194] RAX: ffff88810919c348 RBX: ffff88810e99d760 RCX: 0000000000000000
[   11.471340] AMD-Vi: DTE[3]: 0000000000000000
[   11.471518] RDX: 0000000000000002 RSI: ffff88810e9aeb08 RDI: ffff88810e980000
[   11.471933] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea080c0 flags=0x0080]
[   11.472608] RBP: ffff88810e991d60 R08: 0000000000000001 R09: 0000000000000000
[   11.472796] AMD-Vi: DTE[0]: 7590000000000003
[   11.472974] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.473120] AMD-Vi: DTE[1]: 0000100103c30002
[   11.473175] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9aeb08
[   11.473321] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.473562] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.473708] AMD-Vi: DTE[3]: 0000000000000000
[   11.473949] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.474364] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea08140 flags=0x0080]
[   11.474604] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.474750] AMD-Vi: DTE[0]: 7590000000000003
[   11.474991] Call Trace:
[   11.475137] AMD-Vi: DTE[1]: 0000100103c30002
[   11.475383]  <TASK>
[   11.475524] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.475798]  ? __warn+0x9c/0x1b0
[   11.475942] AMD-Vi: DTE[3]: 0000000000000000
[   11.476137]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.478130] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07600 flags=0x0080]
[   11.478140]  ? report_bug+0x188/0x1b0
[   11.478588] AMD-Vi: DTE[0]: 7590000000000003
[   11.478715]  ? handle_bug+0x3a/0x70
[   11.478861] AMD-Vi: DTE[1]: 0000100103c30002
[   11.478982]  ? exc_invalid_op+0x17/0x70
[   11.479128] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.479260]  ? asm_exc_invalid_op+0x16/0x20
[   11.479406] AMD-Vi: DTE[3]: 0000000000000000
[   11.479551]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.481262] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea073c0 flags=0x0080]
[   11.481272]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.482713] AMD-Vi: DTE[0]: 7590000000000003
[   11.482911]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.484248] AMD-Vi: DTE[1]: 0000100103c30002
[   11.484678] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.484875] AMD-Vi: DTE[3]: 0000000000000000
[   11.485029] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea071c0 flags=0x0080]
[   11.484427]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.485459] AMD-Vi: DTE[0]: 7590000000000003
[   11.485461] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485462] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485463] AMD-Vi: DTE[3]: 0000000000000000
[   11.485464] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07400 flags=0x0080]
[   11.485468] AMD-Vi: DTE[0]: 7590000000000003
[   11.485470] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485471] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485472] AMD-Vi: DTE[3]: 0000000000000000
[   11.485474] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07440 flags=0x0080]
[   11.485476] AMD-Vi: DTE[0]: 7590000000000003
[   11.485478] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485479] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485480] AMD-Vi: DTE[3]: 0000000000000000
[   11.485482] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07480 flags=0x0080]
[   11.485484] AMD-Vi: DTE[0]: 7590000000000003
[   11.485485] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485487] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485488] AMD-Vi: DTE[3]: 0000000000000000
[   11.485490] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07540 flags=0x0080]
[   11.485492] AMD-Vi: DTE[0]: 7590000000000003
[   11.485493] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485494] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485496] AMD-Vi: DTE[3]: 0000000000000000
[   11.485497] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07500 flags=0x0080]
[   11.485499] AMD-Vi: DTE[0]: 7590000000000003
[   11.485501] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485502] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485504] AMD-Vi: DTE[3]: 0000000000000000
[   11.485505] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea075c0 flags=0x0080]
[   11.485508] AMD-Vi: DTE[0]: 7590000000000003
[   11.485509] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485510] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485511] AMD-Vi: DTE[3]: 0000000000000000
[   11.485512] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea07240 flags=0x0080]
[   11.485515] AMD-Vi: DTE[0]: 7590000000000003
[   11.485516] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485518] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485519] AMD-Vi: DTE[3]: 0000000000000000
[   11.485520] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09000 flags=0x0080]
[   11.485523] AMD-Vi: DTE[0]: 7590000000000003
[   11.485524] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485525] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485527] AMD-Vi: DTE[3]: 0000000000000000
[   11.485528] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09a00 flags=0x0080]
[   11.485530] AMD-Vi: DTE[0]: 7590000000000003
[   11.485531] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485533] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485534] AMD-Vi: DTE[3]: 0000000000000000
[   11.485535] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea093c0 flags=0x0080]
[   11.485537] AMD-Vi: DTE[0]: 7590000000000003
[   11.485539] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485540] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485541] AMD-Vi: DTE[3]: 0000000000000000
[   11.485543] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09580 flags=0x0080]
[   11.485545] AMD-Vi: DTE[0]: 7590000000000003
[   11.485546] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485547] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485549] AMD-Vi: DTE[3]: 0000000000000000
[   11.485550] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09680 flags=0x0080]
[   11.485552] AMD-Vi: DTE[0]: 7590000000000003
[   11.485553] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485555] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485557] AMD-Vi: DTE[3]: 0000000000000000
[   11.485558] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea091c0 flags=0x0080]
[   11.485560] AMD-Vi: DTE[0]: 7590000000000003
[   11.485561] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485563] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485564] AMD-Vi: DTE[3]: 0000000000000000
[   11.485566] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09340 flags=0x0080]
[   11.485568] AMD-Vi: DTE[0]: 7590000000000003
[   11.485569] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485570] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485572] AMD-Vi: DTE[3]: 0000000000000000
[   11.485573] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09540 flags=0x0080]
[   11.485575] AMD-Vi: DTE[0]: 7590000000000003
[   11.485576] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485578] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485579] AMD-Vi: DTE[3]: 0000000000000000
[   11.485580] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09180 flags=0x0080]
[   11.485583] AMD-Vi: DTE[0]: 7590000000000003
[   11.485584] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485586] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485587] AMD-Vi: DTE[3]: 0000000000000000
[   11.485588] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea096c0 flags=0x0080]
[   11.485591] AMD-Vi: DTE[0]: 7590000000000003
[   11.485592] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485593] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485594] AMD-Vi: DTE[3]: 0000000000000000
[   11.485596] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09440 flags=0x0080]
[   11.485598] AMD-Vi: DTE[0]: 7590000000000003
[   11.485599] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485600] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485601] AMD-Vi: DTE[3]: 0000000000000000
[   11.485602] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09080 flags=0x0080]
[   11.485605] AMD-Vi: DTE[0]: 7590000000000003
[   11.485606] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485607] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485608] AMD-Vi: DTE[3]: 0000000000000000
[   11.485609] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea094c0 flags=0x0080]
[   11.485611] AMD-Vi: DTE[0]: 7590000000000003
[   11.485613] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485614] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485615] AMD-Vi: DTE[3]: 0000000000000000
[   11.485616] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09400 flags=0x0080]
[   11.485618] AMD-Vi: DTE[0]: 7590000000000003
[   11.485620] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485621] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485622] AMD-Vi: DTE[3]: 0000000000000000
[   11.485623] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09380 flags=0x0080]
[   11.485625] AMD-Vi: DTE[0]: 7590000000000003
[   11.485627] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485628] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485629] AMD-Vi: DTE[3]: 0000000000000000
[   11.485630] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09140 flags=0x0080]
[   11.485632] AMD-Vi: DTE[0]: 7590000000000003
[   11.485634] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485635] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485636] AMD-Vi: DTE[3]: 0000000000000000
[   11.485637] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09740 flags=0x0080]
[   11.485639] AMD-Vi: DTE[0]: 7590000000000003
[   11.485641] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485642] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485643] AMD-Vi: DTE[3]: 0000000000000000
[   11.485644] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09200 flags=0x0080]
[   11.485647] AMD-Vi: DTE[0]: 7590000000000003
[   11.485648] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485650] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485651] AMD-Vi: DTE[3]: 0000000000000000
[   11.485652] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea097c0 flags=0x0080]
[   11.485655] AMD-Vi: DTE[0]: 7590000000000003
[   11.485656] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485657] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485658] AMD-Vi: DTE[3]: 0000000000000000
[   11.485659] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09600 flags=0x0080]
[   11.485662] AMD-Vi: DTE[0]: 7590000000000003
[   11.485663] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485664] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485665] AMD-Vi: DTE[3]: 0000000000000000
[   11.485666] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09500 flags=0x0080]
[   11.485668] AMD-Vi: DTE[0]: 7590000000000003
[   11.485669] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485671] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485672] AMD-Vi: DTE[3]: 0000000000000000
[   11.485673] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09240 flags=0x0080]
[   11.485675] AMD-Vi: DTE[0]: 7590000000000003
[   11.485676] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485678] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485679] AMD-Vi: DTE[3]: 0000000000000000
[   11.485680] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea095c0 flags=0x0080]
[   11.485682] AMD-Vi: DTE[0]: 7590000000000003
[   11.485683] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485684] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485685] AMD-Vi: DTE[3]: 0000000000000000
[   11.485687] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09800 flags=0x0080]
[   11.485689] AMD-Vi: DTE[0]: 7590000000000003
[   11.485691] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485692] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485693] AMD-Vi: DTE[3]: 0000000000000000
[   11.485694] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09840 flags=0x0080]
[   11.485697] AMD-Vi: DTE[0]: 7590000000000003
[   11.485698] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485699] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485701] AMD-Vi: DTE[3]: 0000000000000000
[   11.485702] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09880 flags=0x0080]
[   11.485705] AMD-Vi: DTE[0]: 7590000000000003
[   11.485706] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485707] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485708] AMD-Vi: DTE[3]: 0000000000000000
[   11.485710] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea098c0 flags=0x0080]
[   11.485712] AMD-Vi: DTE[0]: 7590000000000003
[   11.485713] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485714] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485716] AMD-Vi: DTE[3]: 0000000000000000
[   11.485717] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09900 flags=0x0080]
[   11.485719] AMD-Vi: DTE[0]: 7590000000000003
[   11.485721] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485722] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485723] AMD-Vi: DTE[3]: 0000000000000000
[   11.485724] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09940 flags=0x0080]
[   11.485726] AMD-Vi: DTE[0]: 7590000000000003
[   11.485727] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485729] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485730] AMD-Vi: DTE[3]: 0000000000000000
[   11.485731] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09980 flags=0x0080]
[   11.485733] AMD-Vi: DTE[0]: 7590000000000003
[   11.485734] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485736] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485737] AMD-Vi: DTE[3]: 0000000000000000
[   11.485739] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea099c0 flags=0x0080]
[   11.485741] AMD-Vi: DTE[0]: 7590000000000003
[   11.485742] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485743] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485744] AMD-Vi: DTE[3]: 0000000000000000
[   11.485745] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09c00 flags=0x0080]
[   11.485748] AMD-Vi: DTE[0]: 7590000000000003
[   11.485749] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485750] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485751] AMD-Vi: DTE[3]: 0000000000000000
[   11.485753] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09c40 flags=0x0080]
[   11.485755] AMD-Vi: DTE[0]: 7590000000000003
[   11.485757] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485758] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485760] AMD-Vi: DTE[3]: 0000000000000000
[   11.485761] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09c80 flags=0x0080]
[   11.485763] AMD-Vi: DTE[0]: 7590000000000003
[   11.485765] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485766] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485767] AMD-Vi: DTE[3]: 0000000000000000
[   11.485769] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09cc0 flags=0x0080]
[   11.485771] AMD-Vi: DTE[0]: 7590000000000003
[   11.485773] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485774] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485775] AMD-Vi: DTE[3]: 0000000000000000
[   11.485776] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09d00 flags=0x0080]
[   11.485779] AMD-Vi: DTE[0]: 7590000000000003
[   11.485780] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485781] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485782] AMD-Vi: DTE[3]: 0000000000000000
[   11.485784] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09a40 flags=0x0080]
[   11.485786] AMD-Vi: DTE[0]: 7590000000000003
[   11.485787] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485788] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485789] AMD-Vi: DTE[3]: 0000000000000000
[   11.485790] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09a80 flags=0x0080]
[   11.485794] AMD-Vi: DTE[0]: 7590000000000003
[   11.485795] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485797] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485798] AMD-Vi: DTE[3]: 0000000000000000
[   11.485800] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09ac0 flags=0x0080]
[   11.485802] AMD-Vi: DTE[0]: 7590000000000003
[   11.485804] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485805] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485806] AMD-Vi: DTE[3]: 0000000000000000
[   11.485807] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09b00 flags=0x0080]
[   11.485810] AMD-Vi: DTE[0]: 7590000000000003
[   11.485811] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485813] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485814] AMD-Vi: DTE[3]: 0000000000000000
[   11.485815] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09b40 flags=0x0080]
[   11.485817] AMD-Vi: DTE[0]: 7590000000000003
[   11.485818] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485819] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485821] AMD-Vi: DTE[3]: 0000000000000000
[   11.485822] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09b80 flags=0x0080]
[   11.485824] AMD-Vi: DTE[0]: 7590000000000003
[   11.485826] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485827] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485828] AMD-Vi: DTE[3]: 0000000000000000
[   11.485829] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09bc0 flags=0x0080]
[   11.485831] AMD-Vi: DTE[0]: 7590000000000003
[   11.485832] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485833] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485835] AMD-Vi: DTE[3]: 0000000000000000
[   11.485836] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09ec0 flags=0x0080]
[   11.485838] AMD-Vi: DTE[0]: 7590000000000003
[   11.485839] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485840] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485841] AMD-Vi: DTE[3]: 0000000000000000
[   11.485842] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09e00 flags=0x0080]
[   11.485845] AMD-Vi: DTE[0]: 7590000000000003
[   11.485846] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485847] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485848] AMD-Vi: DTE[3]: 0000000000000000
[   11.485850] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09e40 flags=0x0080]
[   11.485852] AMD-Vi: DTE[0]: 7590000000000003
[   11.485853] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485854] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485855] AMD-Vi: DTE[3]: 0000000000000000
[   11.485856] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09e80 flags=0x0080]
[   11.485858] AMD-Vi: DTE[0]: 7590000000000003
[   11.485860] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485861] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485862] AMD-Vi: DTE[3]: 0000000000000000
[   11.485863] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09f00 flags=0x0080]
[   11.485866] AMD-Vi: DTE[0]: 7590000000000003
[   11.485867] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485868] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485869] AMD-Vi: DTE[3]: 0000000000000000
[   11.485870] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09f40 flags=0x0080]
[   11.485873] AMD-Vi: DTE[0]: 7590000000000003
[   11.485874] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485875] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485876] AMD-Vi: DTE[3]: 0000000000000000
[   11.485877] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09f80 flags=0x0080]
[   11.485879] AMD-Vi: DTE[0]: 7590000000000003
[   11.485880] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485881] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485882] AMD-Vi: DTE[3]: 0000000000000000
[   11.485884] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09fc0 flags=0x0080]
[   11.485886] AMD-Vi: DTE[0]: 7590000000000003
[   11.485887] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485888] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485889] AMD-Vi: DTE[3]: 0000000000000000
[   11.485890] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09d40 flags=0x0080]
[   11.485892] AMD-Vi: DTE[0]: 7590000000000003
[   11.485894] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485895] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485896] AMD-Vi: DTE[3]: 0000000000000000
[   11.485897] iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:00:01.0 pasid=0x00000 address=0x10ea09d80 flags=0x0080]
[   11.485899] AMD-Vi: DTE[0]: 7590000000000003
[   11.485900] AMD-Vi: DTE[1]: 0000100103c30002
[   11.485901] AMD-Vi: DTE[2]: 200000010ebcc013
[   11.485903] AMD-Vi: DTE[3]: 0000000000000000
[   11.485905] AMD-Vi: IOMMU Event log restarting
[   11.549625]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.551092]  local_pci_probe+0x53/0xb0
[   11.551232]  pci_device_probe+0xbc/0x1d0
[   11.551374]  really_probe+0xda/0x390
[   11.551506]  ? pm_runtime_barrier+0x61/0xb0
[   11.551657]  ? __pfx___driver_attach+0x10/0x10
[   11.551814]  __driver_probe_device+0x78/0x150
[   11.551969]  driver_probe_device+0x2d/0xb0
[   11.552116]  __driver_attach+0xdc/0x1d0
[   11.552253]  bus_for_each_dev+0x6a/0xb0
[   11.552393]  bus_add_driver+0x139/0x260
[   11.552605]  driver_register+0x55/0x100
[   11.552792]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.554266]  do_one_initcall+0x60/0x2c0
[   11.554408]  ? kmalloc_trace_noprof+0x272/0x330
[   11.554571]  ? do_init_module+0x22/0x230
[   11.554715]  do_init_module+0x60/0x230
[   11.554850]  init_module_from_file+0x89/0xc0
[   11.555003]  idempotent_init_module+0xf9/0x270
[   11.555162]  __x64_sys_finit_module+0x7b/0xf0
[   11.555317]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.555489]  do_syscall_64+0x64/0x130
[   11.555623]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.555804] RIP: 0033:0x7fa236745059
[   11.555933] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.556651] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.556958] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.557205] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.557451] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.557697] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.557943] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.558192]  </TASK>
[   11.558273] irq event stamp: 0
[   11.558383] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.558601] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.558887] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.559169] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.559387] ---[ end trace 0000000000000000 ]---
[   11.559682] ------------[ cut here ]------------
[   11.559844] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.561814] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.562367] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.562659] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.562932] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.564428] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.565183] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.565369] RAX: ffff88810919c34c RBX: ffff88810e99dbf8 RCX: 0000000000000000
[   11.565616] RDX: 0000000000000003 RSI: ffff88810e9aeb08 RDI: ffff88810e980000
[   11.565862] RBP: ffff88810e991d68 R08: 0000000000000001 R09: 0000000000000000
[   11.566108] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.566354] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9aeb08
[   11.566600] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.566879] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.567079] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.567326] Call Trace:
[   11.567421]  <TASK>
[   11.567500]  ? __warn+0x9c/0x1b0
[   11.567624]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.569287]  ? report_bug+0x188/0x1b0
[   11.569423]  ? handle_bug+0x3a/0x70
[   11.569551]  ? exc_invalid_op+0x17/0x70
[   11.569688]  ? asm_exc_invalid_op+0x16/0x20
[   11.569841]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.571316]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.572952]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.574424]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.575879]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.577504]  local_pci_probe+0x53/0xb0
[   11.577646]  pci_device_probe+0xbc/0x1d0
[   11.577787]  really_probe+0xda/0x390
[   11.577919]  ? pm_runtime_barrier+0x61/0xb0
[   11.578070]  ? __pfx___driver_attach+0x10/0x10
[   11.578228]  __driver_probe_device+0x78/0x150
[   11.578383]  driver_probe_device+0x2d/0xb0
[   11.578529]  __driver_attach+0xdc/0x1d0
[   11.578667]  bus_for_each_dev+0x6a/0xb0
[   11.578806]  bus_add_driver+0x139/0x260
[   11.578944]  driver_register+0x55/0x100
[   11.579083]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.580569]  do_one_initcall+0x60/0x2c0
[   11.580714]  ? kmalloc_trace_noprof+0x272/0x330
[   11.580878]  ? do_init_module+0x22/0x230
[   11.581023]  do_init_module+0x60/0x230
[   11.581158]  init_module_from_file+0x89/0xc0
[   11.581311]  idempotent_init_module+0xf9/0x270
[   11.581470]  __x64_sys_finit_module+0x7b/0xf0
[   11.581625]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.581797]  do_syscall_64+0x64/0x130
[   11.581932]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.582114] RIP: 0033:0x7fa236745059
[   11.582243] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.582879] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.583142] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.583389] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.583635] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.583880] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.584126] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.584375]  </TASK>
[   11.584456] irq event stamp: 0
[   11.584616] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.584881] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.585167] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.585449] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.585667] ---[ end trace 0000000000000000 ]---
[   11.585964] ------------[ cut here ]------------
[   11.586126] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.587832] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.588383] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.588701] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.588975] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.590474] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.591110] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.591294] RAX: ffff88810919c350 RBX: ffff88810e99e090 RCX: 0000000000000000
[   11.591540] RDX: 0000000000000004 RSI: ffff88810e9aeb08 RDI: ffff88810e980000
[   11.591786] RBP: ffff88810e991d70 R08: 0000000000000001 R09: 0000000000000000
[   11.592032] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.592279] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9aeb08
[   11.592547] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.592827] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.593027] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.593274] Call Trace:
[   11.593368]  <TASK>
[   11.593448]  ? __warn+0x9c/0x1b0
[   11.593571]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.595063]  ? report_bug+0x188/0x1b0
[   11.595198]  ? handle_bug+0x3a/0x70
[   11.595326]  ? exc_invalid_op+0x17/0x70
[   11.595463]  ? asm_exc_invalid_op+0x16/0x20
[   11.595616]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.597116]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.598610]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.600080]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.601556]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.602998]  local_pci_probe+0x53/0xb0
[   11.603139]  pci_device_probe+0xbc/0x1d0
[   11.603280]  really_probe+0xda/0x390
[   11.603412]  ? pm_runtime_barrier+0x61/0xb0
[   11.603563]  ? __pfx___driver_attach+0x10/0x10
[   11.603721]  __driver_probe_device+0x78/0x150
[   11.603875]  driver_probe_device+0x2d/0xb0
[   11.604022]  __driver_attach+0xdc/0x1d0
[   11.604159]  bus_for_each_dev+0x6a/0xb0
[   11.604299]  bus_add_driver+0x139/0x260
[   11.604436]  driver_register+0x55/0x100
[   11.604597]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.606066]  do_one_initcall+0x60/0x2c0
[   11.606209]  ? kmalloc_trace_noprof+0x272/0x330
[   11.606372]  ? do_init_module+0x22/0x230
[   11.606516]  do_init_module+0x60/0x230
[   11.606651]  init_module_from_file+0x89/0xc0
[   11.606804]  idempotent_init_module+0xf9/0x270
[   11.606964]  __x64_sys_finit_module+0x7b/0xf0
[   11.607118]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.607290]  do_syscall_64+0x64/0x130
[   11.607425]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.607607] RIP: 0033:0x7fa236745059
[   11.607736] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.608371] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.608656] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.608903] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.609149] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.609396] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.609642] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.609890]  </TASK>
[   11.609971] irq event stamp: 0
[   11.610081] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.610299] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.610585] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.610867] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.611084] ---[ end trace 0000000000000000 ]---
[   11.611376] ------------[ cut here ]------------
[   11.611537] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.613261] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.613813] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.614106] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.614378] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.615896] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.616626] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.616823] RAX: ffff88810919c354 RBX: ffff88810e99e528 RCX: 0000000000000000
[   11.617109] RDX: 0000000000000005 RSI: ffff88810e9aeb08 RDI: ffff88810e980000
[   11.617355] RBP: ffff88810e991d78 R08: 0000000000000001 R09: 0000000000000000
[   11.617601] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.617846] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9aeb08
[   11.618093] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.618371] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.618571] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.618818] Call Trace:
[   11.618912]  <TASK>
[   11.618992]  ? __warn+0x9c/0x1b0
[   11.619115]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.620637]  ? report_bug+0x188/0x1b0
[   11.620774]  ? handle_bug+0x3a/0x70
[   11.620902]  ? exc_invalid_op+0x17/0x70
[   11.621039]  ? asm_exc_invalid_op+0x16/0x20
[   11.621192]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.622675]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.624156]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.625641]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.627109]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.628575]  local_pci_probe+0x53/0xb0
[   11.628716]  pci_device_probe+0xbc/0x1d0
[   11.628858]  really_probe+0xda/0x390
[   11.628990]  ? pm_runtime_barrier+0x61/0xb0
[   11.629141]  ? __pfx___driver_attach+0x10/0x10
[   11.629299]  __driver_probe_device+0x78/0x150
[   11.629453]  driver_probe_device+0x2d/0xb0
[   11.629600]  __driver_attach+0xdc/0x1d0
[   11.629738]  bus_for_each_dev+0x6a/0xb0
[   11.629877]  bus_add_driver+0x139/0x260
[   11.630014]  driver_register+0x55/0x100
[   11.630153]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.631622]  do_one_initcall+0x60/0x2c0
[   11.631764]  ? kmalloc_trace_noprof+0x272/0x330
[   11.631927]  ? do_init_module+0x22/0x230
[   11.632071]  do_init_module+0x60/0x230
[   11.632205]  init_module_from_file+0x89/0xc0
[   11.632359]  idempotent_init_module+0xf9/0x270
[   11.632540]  __x64_sys_finit_module+0x7b/0xf0
[   11.632697]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.632869]  do_syscall_64+0x64/0x130
[   11.633004]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.633186] RIP: 0033:0x7fa236745059
[   11.633315] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.633950] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.634213] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.634460] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.634706] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.634952] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.635198] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.635445]  </TASK>
[   11.635527] irq event stamp: 0
[   11.635636] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.635854] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.636140] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.636423] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.636649] ---[ end trace 0000000000000000 ]---
[   11.636940] ------------[ cut here ]------------
[   11.637102] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.638803] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.639356] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.639649] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.639922] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.641459] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.642095] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.642279] RAX: ffff8881076b1dc0 RBX: ffff88810e9afb20 RCX: 0000000000000000
[   11.642526] RDX: 0000000000000000 RSI: ffff88810e9b8f90 RDI: ffff88810e980000
[   11.642772] RBP: ffff88810e991d88 R08: 0000000000000001 R09: 0000000000000000
[   11.643018] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.643264] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9b8f90
[   11.643510] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.643789] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.643989] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.644235] Call Trace:
[   11.644329]  <TASK>
[   11.644409]  ? __warn+0x9c/0x1b0
[   11.644540]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.646019]  ? report_bug+0x188/0x1b0
[   11.646155]  ? handle_bug+0x3a/0x70
[   11.646283]  ? exc_invalid_op+0x17/0x70
[   11.646420]  ? asm_exc_invalid_op+0x16/0x20
[   11.646572]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.648053]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.649545]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.651004]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.652545]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.654097]  local_pci_probe+0x53/0xb0
[   11.654237]  pci_device_probe+0xbc/0x1d0
[   11.654379]  really_probe+0xda/0x390
[   11.654511]  ? pm_runtime_barrier+0x61/0xb0
[   11.654662]  ? __pfx___driver_attach+0x10/0x10
[   11.654819]  __driver_probe_device+0x78/0x150
[   11.654974]  driver_probe_device+0x2d/0xb0
[   11.655121]  __driver_attach+0xdc/0x1d0
[   11.655258]  bus_for_each_dev+0x6a/0xb0
[   11.655397]  bus_add_driver+0x139/0x260
[   11.655535]  driver_register+0x55/0x100
[   11.655673]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.657171]  do_one_initcall+0x60/0x2c0
[   11.657315]  ? kmalloc_trace_noprof+0x272/0x330
[   11.657479]  ? do_init_module+0x22/0x230
[   11.657623]  do_init_module+0x60/0x230
[   11.657758]  init_module_from_file+0x89/0xc0
[   11.657911]  idempotent_init_module+0xf9/0x270
[   11.658070]  __x64_sys_finit_module+0x7b/0xf0
[   11.658226]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.658397]  do_syscall_64+0x64/0x130
[   11.658532]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.658713] RIP: 0033:0x7fa236745059
[   11.658842] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.659477] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.659740] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.659987] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.660233] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.660485] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.660732] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.660980]  </TASK>
[   11.661061] irq event stamp: 0
[   11.661171] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.661388] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.661674] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.661957] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.662174] ---[ end trace 0000000000000000 ]---
[   11.662463] ------------[ cut here ]------------
[   11.662625] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.664340] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.664912] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.665206] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.665479] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.666985] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.667621] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.667805] RAX: ffff8881076b1dc4 RBX: ffff88810e9b0468 RCX: 0000000000000000
[   11.668052] RDX: 0000000000000001 RSI: ffff88810e9b8f90 RDI: ffff88810e980000
[   11.668298] RBP: ffff88810e991d90 R08: 0000000000000001 R09: 0000000000000000
[   11.668576] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.668824] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9b8f90
[   11.669070] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.669349] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.669549] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.669796] Call Trace:
[   11.669891]  <TASK>
[   11.669971]  ? __warn+0x9c/0x1b0
[   11.670095]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.671570]  ? report_bug+0x188/0x1b0
[   11.671705]  ? handle_bug+0x3a/0x70
[   11.671832]  ? exc_invalid_op+0x17/0x70
[   11.671969]  ? asm_exc_invalid_op+0x16/0x20
[   11.672121]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.673625]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.675114]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.676595]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.678054]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.679500]  local_pci_probe+0x53/0xb0
[   11.679640]  pci_device_probe+0xbc/0x1d0
[   11.679782]  really_probe+0xda/0x390
[   11.679915]  ? pm_runtime_barrier+0x61/0xb0
[   11.680066]  ? __pfx___driver_attach+0x10/0x10
[   11.680223]  __driver_probe_device+0x78/0x150
[   11.680378]  driver_probe_device+0x2d/0xb0
[   11.680548]  __driver_attach+0xdc/0x1d0
[   11.680688]  bus_for_each_dev+0x6a/0xb0
[   11.680828]  bus_add_driver+0x139/0x260
[   11.680965]  driver_register+0x55/0x100
[   11.681104]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.682568]  do_one_initcall+0x60/0x2c0
[   11.682710]  ? kmalloc_trace_noprof+0x272/0x330
[   11.682873]  ? do_init_module+0x22/0x230
[   11.683017]  do_init_module+0x60/0x230
[   11.683151]  init_module_from_file+0x89/0xc0
[   11.683305]  idempotent_init_module+0xf9/0x270
[   11.683464]  __x64_sys_finit_module+0x7b/0xf0
[   11.683619]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.683791]  do_syscall_64+0x64/0x130
[   11.683925]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.684106] RIP: 0033:0x7fa236745059
[   11.684235] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.684893] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.685157] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.685404] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.685650] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.685896] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.686142] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.686391]  </TASK>
[   11.686472] irq event stamp: 0
[   11.686582] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.686800] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.687085] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.687367] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.687585] ---[ end trace 0000000000000000 ]---
[   11.687868] ------------[ cut here ]------------
[   11.688030] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.689857] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.690410] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.690702] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.690975] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.692444] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.693107] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.693293] RAX: ffff888101c7f0e0 RBX: ffff88810e9b90a0 RCX: 0000000000000000
[   11.693539] RDX: 0000000000000000 RSI: ffff88810e9b9e68 RDI: ffff88810e980000
[   11.693785] RBP: ffff88810e991d98 R08: 0000000000000001 R09: 0000000000000000
[   11.694031] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.694277] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9b9e68
[   11.694523] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.694802] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.695002] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.695248] Call Trace:
[   11.695343]  <TASK>
[   11.695423]  ? __warn+0x9c/0x1b0
[   11.695547]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.697021]  ? report_bug+0x188/0x1b0
[   11.697157]  ? handle_bug+0x3a/0x70
[   11.697285]  ? exc_invalid_op+0x17/0x70
[   11.697422]  ? asm_exc_invalid_op+0x16/0x20
[   11.697574]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.699061]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.700581]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.702040]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.703501]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.704968]  local_pci_probe+0x53/0xb0
[   11.705110]  pci_device_probe+0xbc/0x1d0
[   11.705251]  really_probe+0xda/0x390
[   11.705383]  ? pm_runtime_barrier+0x61/0xb0
[   11.705534]  ? __pfx___driver_attach+0x10/0x10
[   11.705692]  __driver_probe_device+0x78/0x150
[   11.705847]  driver_probe_device+0x2d/0xb0
[   11.705993]  __driver_attach+0xdc/0x1d0
[   11.706131]  bus_for_each_dev+0x6a/0xb0
[   11.706270]  bus_add_driver+0x139/0x260
[   11.706407]  driver_register+0x55/0x100
[   11.706547]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.708011]  do_one_initcall+0x60/0x2c0
[   11.708154]  ? kmalloc_trace_noprof+0x272/0x330
[   11.708317]  ? do_init_module+0x22/0x230
[   11.708478]  do_init_module+0x60/0x230
[   11.708619]  init_module_from_file+0x89/0xc0
[   11.708773]  idempotent_init_module+0xf9/0x270
[   11.708932]  __x64_sys_finit_module+0x7b/0xf0
[   11.709087]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.709259]  do_syscall_64+0x64/0x130
[   11.709393]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.709574] RIP: 0033:0x7fa236745059
[   11.709704] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.710339] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.710601] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.710848] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.711094] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.711340] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.711586] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.711834]  </TASK>
[   11.711915] irq event stamp: 0
[   11.712025] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.712242] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.712537] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.712820] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.713038] ---[ end trace 0000000000000000 ]---
[   11.713322] ------------[ cut here ]------------
[   11.713484] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.715185] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.715737] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.716029] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.716302] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.717833] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.718470] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.718654] RAX: ffff888101c7fb18 RBX: ffff88810e9bb2e0 RCX: 0000000000000000
[   11.718900] RDX: 0000000000000000 RSI: ffff88810e9bc0a8 RDI: ffff88810e980000
[   11.719146] RBP: ffff88810e991da0 R08: 0000000000000001 R09: 0000000000000000
[   11.719392] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.719639] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9bc0a8
[   11.719885] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.720164] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.720364] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.720674] Call Trace:
[   11.720784]  <TASK>
[   11.720876]  ? __warn+0x9c/0x1b0
[   11.721037]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.722538]  ? report_bug+0x188/0x1b0
[   11.722674]  ? handle_bug+0x3a/0x70
[   11.722801]  ? exc_invalid_op+0x17/0x70
[   11.722938]  ? asm_exc_invalid_op+0x16/0x20
[   11.723090]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.724609]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.726105]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.727571]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.729050]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.730506]  local_pci_probe+0x53/0xb0
[   11.730646]  pci_device_probe+0xbc/0x1d0
[   11.730788]  really_probe+0xda/0x390
[   11.730920]  ? pm_runtime_barrier+0x61/0xb0
[   11.731070]  ? __pfx___driver_attach+0x10/0x10
[   11.731228]  __driver_probe_device+0x78/0x150
[   11.731383]  driver_probe_device+0x2d/0xb0
[   11.731529]  __driver_attach+0xdc/0x1d0
[   11.731667]  bus_for_each_dev+0x6a/0xb0
[   11.731806]  bus_add_driver+0x139/0x260
[   11.731943]  driver_register+0x55/0x100
[   11.732081]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.733566]  do_one_initcall+0x60/0x2c0
[   11.733710]  ? kmalloc_trace_noprof+0x272/0x330
[   11.733873]  ? do_init_module+0x22/0x230
[   11.734018]  do_init_module+0x60/0x230
[   11.734153]  init_module_from_file+0x89/0xc0
[   11.734306]  idempotent_init_module+0xf9/0x270
[   11.734465]  __x64_sys_finit_module+0x7b/0xf0
[   11.734620]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.734792]  do_syscall_64+0x64/0x130
[   11.734927]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.735108] RIP: 0033:0x7fa236745059
[   11.735238] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.735873] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.736136] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.736383] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.736637] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.736883] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.737129] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.737377]  </TASK>
[   11.737458] irq event stamp: 0
[   11.737568] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.737786] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.738072] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.738354] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.738572] ---[ end trace 0000000000000000 ]---
[   11.738864] ------------[ cut here ]------------
[   11.739025] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.740759] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.741311] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.741604] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.741876] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.743390] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.744026] RSP: 0018:ffffc900003dbaa8 EFLAGS: 00010246
[   11.744210] RAX: ffff888101c7fb18 RBX: ffff88810e9bb778 RCX: 0000000000000000
[   11.744456] RDX: 0000000000000000 RSI: ffff88810e9bc0a8 RDI: ffff88810e980000
[   11.744723] RBP: ffff88810e991da8 R08: 0000000000000001 R09: 0000000000000000
[   11.744971] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e992118
[   11.745217] R13: ffff88810e980010 R14: ffff88810e980000 R15: ffff88810e9bc0a8
[   11.745463] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.745742] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.745942] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.746188] Call Trace:
[   11.746283]  <TASK>
[   11.746362]  ? __warn+0x9c/0x1b0
[   11.746486]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.747958]  ? report_bug+0x188/0x1b0
[   11.748093]  ? handle_bug+0x3a/0x70
[   11.748221]  ? exc_invalid_op+0x17/0x70
[   11.748358]  ? asm_exc_invalid_op+0x16/0x20
[   11.748531]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.750015]  amdgpu_fence_driver_hw_fini+0xdc/0x100 [amdgpu]
[   11.751499]  amdgpu_device_fini_hw+0x95/0x3b0 [amdgpu]
[   11.752971]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.754436]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.755878]  local_pci_probe+0x53/0xb0
[   11.756018]  pci_device_probe+0xbc/0x1d0
[   11.756159]  really_probe+0xda/0x390
[   11.756292]  ? pm_runtime_barrier+0x61/0xb0
[   11.756442]  ? __pfx___driver_attach+0x10/0x10
[   11.756665]  __driver_probe_device+0x78/0x150
[   11.756833]  driver_probe_device+0x2d/0xb0
[   11.757017]  __driver_attach+0xdc/0x1d0
[   11.757154]  bus_for_each_dev+0x6a/0xb0
[   11.757294]  bus_add_driver+0x139/0x260
[   11.757431]  driver_register+0x55/0x100
[   11.757570]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.759042]  do_one_initcall+0x60/0x2c0
[   11.759185]  ? kmalloc_trace_noprof+0x272/0x330
[   11.759348]  ? do_init_module+0x22/0x230
[   11.759491]  do_init_module+0x60/0x230
[   11.759626]  init_module_from_file+0x89/0xc0
[   11.759780]  idempotent_init_module+0xf9/0x270
[   11.759939]  __x64_sys_finit_module+0x7b/0xf0
[   11.760094]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.760265]  do_syscall_64+0x64/0x130
[   11.760400]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.760606] RIP: 0033:0x7fa236745059
[   11.760737] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.761372] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.761635] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.761882] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.762128] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.762374] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.762620] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.762868]  </TASK>
[   11.762949] irq event stamp: 0
[   11.763058] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.763276] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.763562] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.763844] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.764061] ---[ end trace 0000000000000000 ]---
[   11.765368] ------------[ cut here ]------------
[   11.765537] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.767230] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.767782] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.768074] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.768347] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.769875] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 74 07 31 c0 e9 03 f0 97 e1 0f 1f 00 e9 7b fd ff ff <0f> 0b b8 ea ff ff ff e9 ef ef 97 e1 b8 ea ff ff ff e9 e5 ef 97 e1
[   11.770512] RSP: 0018:ffffc900003dbad8 EFLAGS: 00010246
[   11.770696] RAX: ffff888100cb0ba0 RBX: ffff88810e980000 RCX: 0000000000000000
[   11.770943] RDX: 0000000000000000 RSI: ffff88810e981620 RDI: ffff88810e980000
[   11.771189] RBP: ffff88810e9d7ad2 R08: 0000000000000000 R09: 0000000000000000
[   11.771434] R10: 0000000000000000 R11: 3331306363626530 R12: ffff88810e980010
[   11.771680] R13: ffff88810e9d7ab2 R14: 0000000000009801 R15: 0000000000000000
[   11.771926] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.772205] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.772405] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.772657] Call Trace:
[   11.772752]  <TASK>
[   11.772831]  ? __warn+0x9c/0x1b0
[   11.772955]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.774448]  ? report_bug+0x188/0x1b0
[   11.774583]  ? handle_bug+0x3a/0x70
[   11.774711]  ? exc_invalid_op+0x17/0x70
[   11.774848]  ? asm_exc_invalid_op+0x16/0x20
[   11.775000]  ? amdgpu_irq_put+0x45/0x70 [amdgpu]
[   11.776501]  gmc_v8_0_hw_fini+0x17/0xa0 [amdgpu]
[   11.777972]  amdgpu_device_fini_hw+0x22d/0x3b0 [amdgpu]
[   11.779439]  amdgpu_driver_load_kms+0x8c/0xc0 [amdgpu]
[   11.780936]  amdgpu_pci_probe+0x1b5/0x550 [amdgpu]
[   11.782385]  local_pci_probe+0x53/0xb0
[   11.782525]  pci_device_probe+0xbc/0x1d0
[   11.782667]  really_probe+0xda/0x390
[   11.782798]  ? pm_runtime_barrier+0x61/0xb0
[   11.782948]  ? __pfx___driver_attach+0x10/0x10
[   11.783106]  __driver_probe_device+0x78/0x150
[   11.783261]  driver_probe_device+0x2d/0xb0
[   11.783407]  __driver_attach+0xdc/0x1d0
[   11.783545]  bus_for_each_dev+0x6a/0xb0
[   11.783684]  bus_add_driver+0x139/0x260
[   11.783822]  driver_register+0x55/0x100
[   11.783961]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.785518]  do_one_initcall+0x60/0x2c0
[   11.785702]  ? kmalloc_trace_noprof+0x272/0x330
[   11.785865]  ? do_init_module+0x22/0x230
[   11.786010]  do_init_module+0x60/0x230
[   11.786144]  init_module_from_file+0x89/0xc0
[   11.786298]  idempotent_init_module+0xf9/0x270
[   11.786457]  __x64_sys_finit_module+0x7b/0xf0
[   11.786612]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.786783]  do_syscall_64+0x64/0x130
[   11.786918]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.787099] RIP: 0033:0x7fa236745059
[   11.787228] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.787863] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.788126] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.788372] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.788674] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.788962] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.789208] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.789456]  </TASK>
[   11.789538] irq event stamp: 0
[   11.789647] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.789865] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.790151] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.790433] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.790650] ---[ end trace 0000000000000000 ]---
[   11.791983] amdgpu 0000:00:01.0: probe with driver amdgpu failed with error -110
[   11.792393] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
[   11.794332] ------------[ cut here ]------------
[   11.794496] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382 amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.796221] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.796802] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.797097] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.797370] RIP: 0010:amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.798900] Code: 0b e9 de fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 74 ea 65 e1 eb 8b e8 6d e2 65 e1 eb a5 0f 0b e9 94 fe ff ff <0f> 0b 90 90 eb 98 be 03 00 00 00 e8 f4 81 42 e1 eb 8c 66 90 90 90
[   11.799536] RSP: 0018:ffffc900003dba48 EFLAGS: 00010282
[   11.799720] RAX: 00000000ffffffea RBX: ffff888107956048 RCX: 00000000ffefffff
[   11.799966] RDX: 0000000000000003 RSI: ffffc900003db800 RDI: 0000000000000001
[   11.800212] RBP: ffff88810e98ff80 R08: 00000000ffefffff R09: 0000000000000058
[   11.800459] R10: 0000000000000000 R11: ffffffff8245a1c0 R12: ffff888107956048
[   11.800783] R13: ffff888107956180 R14: ffff88810e98ff80 R15: ffff8881006fd3b8
[   11.801088] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.801367] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.801567] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.801813] Call Trace:
[   11.801909]  <TASK>
[   11.801988]  ? __warn+0x9c/0x1b0
[   11.802112]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.803621]  ? report_bug+0x188/0x1b0
[   11.803756]  ? handle_bug+0x3a/0x70
[   11.803883]  ? exc_invalid_op+0x17/0x70
[   11.804020]  ? asm_exc_invalid_op+0x16/0x20
[   11.804173]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.805689]  ? amdgpu_bo_release_notify+0xf8/0x1d0 [amdgpu]
[   11.807176]  ttm_bo_release+0x113/0x330
[   11.807322]  ? __mutex_unlock_slowpath+0x3b/0x290
[   11.807494]  amdgpu_bo_free_kernel+0xe6/0x150 [amdgpu]
[   11.809061]  amdgpu_vce_sw_fini+0x43/0xa0 [amdgpu]
[   11.810609]  amdgpu_device_fini_sw+0xb6/0x380 [amdgpu]
[   11.812074]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
[   11.813593]  devm_drm_dev_init_release+0x52/0x70
[   11.813763]  release_nodes+0x36/0x100
[   11.813899]  devres_release_all+0x89/0xc0
[   11.814043]  device_unbind_cleanup+0xe/0x70
[   11.814193]  really_probe+0x1a1/0x390
[   11.814325]  ? pm_runtime_barrier+0x61/0xb0
[   11.814476]  ? __pfx___driver_attach+0x10/0x10
[   11.814633]  __driver_probe_device+0x78/0x150
[   11.814788]  driver_probe_device+0x2d/0xb0
[   11.814934]  __driver_attach+0xdc/0x1d0
[   11.815072]  bus_for_each_dev+0x6a/0xb0
[   11.815211]  bus_add_driver+0x139/0x260
[   11.815348]  driver_register+0x55/0x100
[   11.815487]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.817037]  do_one_initcall+0x60/0x2c0
[   11.817221]  ? kmalloc_trace_noprof+0x272/0x330
[   11.817384]  ? do_init_module+0x22/0x230
[   11.817528]  do_init_module+0x60/0x230
[   11.817663]  init_module_from_file+0x89/0xc0
[   11.817816]  idempotent_init_module+0xf9/0x270
[   11.817976]  __x64_sys_finit_module+0x7b/0xf0
[   11.818131]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.818302]  do_syscall_64+0x64/0x130
[   11.818437]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.818618] RIP: 0033:0x7fa236745059
[   11.818749] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.819385] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.819647] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.819894] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.820140] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.820386] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.820651] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.820900]  </TASK>
[   11.820982] irq event stamp: 0
[   11.821091] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.821309] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.821595] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.821877] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.822094] ---[ end trace 0000000000000000 ]---
[   11.822398] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
[   11.824156] ------------[ cut here ]------------
[   11.824318] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382 amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.826185] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.826739] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.827031] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.827304] RIP: 0010:amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.828849] Code: 0b e9 de fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 74 ea 65 e1 eb 8b e8 6d e2 65 e1 eb a5 0f 0b e9 94 fe ff ff <0f> 0b 90 90 eb 98 be 03 00 00 00 e8 f4 81 42 e1 eb 8c 66 90 90 90
[   11.829485] RSP: 0018:ffffc900003dba38 EFLAGS: 00010282
[   11.829669] RAX: 00000000ffffffea RBX: ffff8881081d0048 RCX: 00000000ffefffff
[   11.829916] RDX: 0000000000000003 RSI: ffffc900003db7f0 RDI: 0000000000000001
[   11.830162] RBP: ffff88810e98ff80 R08: 00000000ffefffff R09: 0000000000000058
[   11.830408] R10: 0000000000000000 R11: ffffffff8245a1c0 R12: ffff8881081d0048
[   11.830654] R13: ffff8881081d0180 R14: ffff88810e98ff80 R15: ffff8881006fd3b8
[   11.830900] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.831179] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.831379] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.831625] Call Trace:
[   11.831720]  <TASK>
[   11.831800]  ? __warn+0x9c/0x1b0
[   11.831922]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.833506]  ? report_bug+0x188/0x1b0
[   11.833683]  ? handle_bug+0x3a/0x70
[   11.833810]  ? exc_invalid_op+0x17/0x70
[   11.833947]  ? asm_exc_invalid_op+0x16/0x20
[   11.834100]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.835600]  ? amdgpu_bo_release_notify+0xf8/0x1d0 [amdgpu]
[   11.837109]  ttm_bo_release+0x113/0x330
[   11.837256]  ? __mutex_unlock_slowpath+0x3b/0x290
[   11.837429]  amdgpu_bo_free_kernel+0xe6/0x150 [amdgpu]
[   11.838900]  amdgpu_uvd_sw_fini+0xbf/0xf0 [amdgpu]
[   11.840413]  amdgpu_device_fini_sw+0xb6/0x380 [amdgpu]
[   11.841970]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
[   11.843489]  devm_drm_dev_init_release+0x52/0x70
[   11.843657]  release_nodes+0x36/0x100
[   11.843792]  devres_release_all+0x89/0xc0
[   11.843936]  device_unbind_cleanup+0xe/0x70
[   11.844088]  really_probe+0x1a1/0x390
[   11.844219]  ? pm_runtime_barrier+0x61/0xb0
[   11.844370]  ? __pfx___driver_attach+0x10/0x10
[   11.844554]  __driver_probe_device+0x78/0x150
[   11.844711]  driver_probe_device+0x2d/0xb0
[   11.844858]  __driver_attach+0xdc/0x1d0
[   11.844995]  bus_for_each_dev+0x6a/0xb0
[   11.845134]  bus_add_driver+0x139/0x260
[   11.845272]  driver_register+0x55/0x100
[   11.845410]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.846877]  do_one_initcall+0x60/0x2c0
[   11.847020]  ? kmalloc_trace_noprof+0x272/0x330
[   11.847183]  ? do_init_module+0x22/0x230
[   11.847327]  do_init_module+0x60/0x230
[   11.847461]  init_module_from_file+0x89/0xc0
[   11.847615]  idempotent_init_module+0xf9/0x270
[   11.847773]  __x64_sys_finit_module+0x7b/0xf0
[   11.847928]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.848100]  do_syscall_64+0x64/0x130
[   11.848234]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.848416] RIP: 0033:0x7fa236745059
[   11.848619] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.849313] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.849576] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.849823] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.850069] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.850315] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.850561] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.850809]  </TASK>
[   11.850891] irq event stamp: 0
[   11.851000] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.851218] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.851504] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.851787] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.852004] ---[ end trace 0000000000000000 ]---
[   11.852314] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
[   11.854197] ------------[ cut here ]------------
[   11.854361] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382 amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.856089] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.856761] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.857056] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.857328] RIP: 0010:amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.858855] Code: 0b e9 de fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 74 ea 65 e1 eb 8b e8 6d e2 65 e1 eb a5 0f 0b e9 94 fe ff ff <0f> 0b 90 90 eb 98 be 03 00 00 00 e8 f4 81 42 e1 eb 8c 66 90 90 90
[   11.859491] RSP: 0018:ffffc900003dba40 EFLAGS: 00010282
[   11.859675] RAX: 00000000ffffffea RBX: ffff8881081d1048 RCX: 00000000ffefffff
[   11.859922] RDX: 0000000000000003 RSI: ffffc900003db7f8 RDI: 0000000000000001
[   11.860168] RBP: ffff88810e98ff80 R08: 00000000ffefffff R09: 0000000000000058
[   11.860414] R10: 0000000000000000 R11: ffffffff8245a1c0 R12: ffff8881081d1048
[   11.860762] R13: ffff8881081d1180 R14: ffff88810e98ff80 R15: ffff8881006fd3b8
[   11.861055] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   11.861334] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.861533] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.861779] Call Trace:
[   11.861875]  <TASK>
[   11.861955]  ? __warn+0x9c/0x1b0
[   11.862078]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.863577]  ? report_bug+0x188/0x1b0
[   11.863712]  ? handle_bug+0x3a/0x70
[   11.863839]  ? exc_invalid_op+0x17/0x70
[   11.863976]  ? asm_exc_invalid_op+0x16/0x20
[   11.864128]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.865745]  ttm_bo_release+0x113/0x330
[   11.865892]  ? __mutex_unlock_slowpath+0x3b/0x290
[   11.866065]  amdgpu_bo_free_kernel+0xe6/0x150 [amdgpu]
[   11.867547]  smu8_smu_fini+0x32/0x60 [amdgpu]
[   11.869289]  hwmgr_sw_fini+0x24/0x30 [amdgpu]
[   11.870783]  pp_sw_fini+0x15/0x30 [amdgpu]
[   11.872293]  amdgpu_device_fini_sw+0xb6/0x380 [amdgpu]
[   11.873844]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
[   11.875360]  devm_drm_dev_init_release+0x52/0x70
[   11.875530]  release_nodes+0x36/0x100
[   11.875665]  devres_release_all+0x89/0xc0
[   11.875809]  device_unbind_cleanup+0xe/0x70
[   11.875960]  really_probe+0x1a1/0x390
[   11.876092]  ? pm_runtime_barrier+0x61/0xb0
[   11.876242]  ? __pfx___driver_attach+0x10/0x10
[   11.876399]  __driver_probe_device+0x78/0x150
[   11.876663]  driver_probe_device+0x2d/0xb0
[   11.876854]  __driver_attach+0xdc/0x1d0
[   11.876992]  bus_for_each_dev+0x6a/0xb0
[   11.877130]  bus_add_driver+0x139/0x260
[   11.877268]  driver_register+0x55/0x100
[   11.877407]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.878869]  do_one_initcall+0x60/0x2c0
[   11.879011]  ? kmalloc_trace_noprof+0x272/0x330
[   11.879174]  ? do_init_module+0x22/0x230
[   11.879318]  do_init_module+0x60/0x230
[   11.879453]  init_module_from_file+0x89/0xc0
[   11.879606]  idempotent_init_module+0xf9/0x270
[   11.879765]  __x64_sys_finit_module+0x7b/0xf0
[   11.879920]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.880092]  do_syscall_64+0x64/0x130
[   11.880227]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.880409] RIP: 0033:0x7fa236745059
[   11.880632] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.881314] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.881578] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.881825] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.882070] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.882317] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.882562] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.882811]  </TASK>
[   11.882893] irq event stamp: 0
[   11.883003] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.883221] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.883507] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.883789] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.884006] ---[ end trace 0000000000000000 ]---
[   11.884338] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
[   11.886325] ------------[ cut here ]------------
[   11.886488] WARNING: CPU: 2 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382 amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.888215] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.888933] CPU: 2 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.889238] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.889552] RIP: 0010:amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.891070] Code: 0b e9 de fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 74 ea 65 e1 eb 8b e8 6d e2 65 e1 eb a5 0f 0b e9 94 fe ff ff <0f> 0b 90 90 eb 98 be 03 00 00 00 e8 f4 81 42 e1 eb 8c 66 90 90 90
[   11.891706] RSP: 0018:ffffc900003dba40 EFLAGS: 00010282
[   11.891891] RAX: 00000000ffffffea RBX: ffff8881081d0848 RCX: 00000000ffefffff
[   11.892138] RDX: 0000000000000002 RSI: ffffc900003db7f8 RDI: 0000000000000001
[   11.892384] RBP: ffff88810e98ff80 R08: 00000000ffefffff R09: 0000000000000058
[   11.892691] R10: 0000000000000000 R11: ffffffff8245a1c0 R12: ffff8881081d0848
[   11.892984] R13: ffff8881081d0980 R14: ffff88810e98ff80 R15: ffff8881006fd3b8
[   11.893230] FS:  00007fa236829880(0000) GS:ffff88842f500000(0000) knlGS:0000000000000000
[   11.893509] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.893709] CR2: 00007fa23681f218 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.893955] Call Trace:
[   11.894051]  <TASK>
[   11.894131]  ? __warn+0x9c/0x1b0
[   11.894255]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.895761]  ? report_bug+0x188/0x1b0
[   11.895896]  ? handle_bug+0x3a/0x70
[   11.896023]  ? exc_invalid_op+0x17/0x70
[   11.896160]  ? asm_exc_invalid_op+0x16/0x20
[   11.896312]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.898093]  ttm_bo_release+0x113/0x330
[   11.898240]  ? __mutex_unlock_slowpath+0x3b/0x290
[   11.898413]  amdgpu_bo_free_kernel+0xe6/0x150 [amdgpu]
[   11.899907]  smu8_smu_fini+0x43/0x60 [amdgpu]
[   11.901472]  hwmgr_sw_fini+0x24/0x30 [amdgpu]
[   11.903031]  pp_sw_fini+0x15/0x30 [amdgpu]
[   11.904599]  amdgpu_device_fini_sw+0xb6/0x380 [amdgpu]
[   11.906157]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
[   11.907647]  devm_drm_dev_init_release+0x52/0x70
[   11.907816]  release_nodes+0x36/0x100
[   11.907951]  devres_release_all+0x89/0xc0
[   11.908095]  device_unbind_cleanup+0xe/0x70
[   11.908245]  really_probe+0x1a1/0x390
[   11.908377]  ? pm_runtime_barrier+0x61/0xb0
[   11.908598]  ? __pfx___driver_attach+0x10/0x10
[   11.908781]  __driver_probe_device+0x78/0x150
[   11.908975]  driver_probe_device+0x2d/0xb0
[   11.909121]  __driver_attach+0xdc/0x1d0
[   11.909258]  bus_for_each_dev+0x6a/0xb0
[   11.909397]  bus_add_driver+0x139/0x260
[   11.909535]  driver_register+0x55/0x100
[   11.909674]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.911122]  do_one_initcall+0x60/0x2c0
[   11.911265]  ? kmalloc_trace_noprof+0x272/0x330
[   11.911428]  ? do_init_module+0x22/0x230
[   11.911573]  do_init_module+0x60/0x230
[   11.911707]  init_module_from_file+0x89/0xc0
[   11.911861]  idempotent_init_module+0xf9/0x270
[   11.912020]  __x64_sys_finit_module+0x7b/0xf0
[   11.912175]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.912347]  do_syscall_64+0x64/0x130
[   11.912557]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.912809] RIP: 0033:0x7fa236745059
[   11.912940] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.913576] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.913840] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.914087] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.914332] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.914579] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.914825] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.915073]  </TASK>
[   11.915154] irq event stamp: 0
[   11.915264] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.915482] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.915768] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.916051] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.916268] ---[ end trace 0000000000000000 ]---
[   11.916889] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
[   11.918661] ------------[ cut here ]------------
[   11.918823] WARNING: CPU: 2 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382 amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.920622] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.921253] CPU: 2 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.921545] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.921818] RIP: 0010:amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.923356] Code: 0b e9 de fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 74 ea 65 e1 eb 8b e8 6d e2 65 e1 eb a5 0f 0b e9 94 fe ff ff <0f> 0b 90 90 eb 98 be 03 00 00 00 e8 f4 81 42 e1 eb 8c 66 90 90 90
[   11.923993] RSP: 0018:ffffc900003dba50 EFLAGS: 00010282
[   11.924177] RAX: 00000000ffffffea RBX: ffff8881076cec48 RCX: 00000000ffefffff
[   11.924423] RDX: 0000000000000002 RSI: ffffc900003db808 RDI: 0000000000000001
[   11.924760] RBP: ffff88810e98ff80 R08: 00000000ffefffff R09: 0000000000000058
[   11.925016] R10: 0000000000000000 R11: ffffffff8245a1c0 R12: ffff8881076cec48
[   11.925301] R13: ffff8881076ced80 R14: ffff88810e98ff80 R15: ffff8881006fd3b8
[   11.925547] FS:  00007fa236829880(0000) GS:ffff88842f500000(0000) knlGS:0000000000000000
[   11.925827] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.926026] CR2: 00007fa23681f218 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.926273] Call Trace:
[   11.926369]  <TASK>
[   11.926448]  ? __warn+0x9c/0x1b0
[   11.926572]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.928076]  ? report_bug+0x188/0x1b0
[   11.928211]  ? handle_bug+0x3a/0x70
[   11.928338]  ? exc_invalid_op+0x17/0x70
[   11.928551]  ? asm_exc_invalid_op+0x16/0x20
[   11.928743]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.930290]  ttm_bo_release+0x113/0x330
[   11.930435]  ? __mutex_unlock_slowpath+0x3b/0x290
[   11.930608]  amdgpu_bo_free_kernel+0xe6/0x150 [amdgpu]
[   11.932103]  gfx_v8_0_sw_fini+0x6e/0x150 [amdgpu]
[   11.933809]  amdgpu_device_fini_sw+0xb6/0x380 [amdgpu]
[   11.935317]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
[   11.936869]  devm_drm_dev_init_release+0x52/0x70
[   11.937076]  release_nodes+0x36/0x100
[   11.937211]  devres_release_all+0x89/0xc0
[   11.937356]  device_unbind_cleanup+0xe/0x70
[   11.937506]  really_probe+0x1a1/0x390
[   11.937638]  ? pm_runtime_barrier+0x61/0xb0
[   11.937789]  ? __pfx___driver_attach+0x10/0x10
[   11.937946]  __driver_probe_device+0x78/0x150
[   11.938101]  driver_probe_device+0x2d/0xb0
[   11.938247]  __driver_attach+0xdc/0x1d0
[   11.938385]  bus_for_each_dev+0x6a/0xb0
[   11.938524]  bus_add_driver+0x139/0x260
[   11.938661]  driver_register+0x55/0x100
[   11.938800]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.940265]  do_one_initcall+0x60/0x2c0
[   11.940407]  ? kmalloc_trace_noprof+0x272/0x330
[   11.940646]  ? do_init_module+0x22/0x230
[   11.940836]  do_init_module+0x60/0x230
[   11.940972]  init_module_from_file+0x89/0xc0
[   11.941125]  idempotent_init_module+0xf9/0x270
[   11.941284]  __x64_sys_finit_module+0x7b/0xf0
[   11.941439]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.941611]  do_syscall_64+0x64/0x130
[   11.941747]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.941929] RIP: 0033:0x7fa236745059
[   11.942060] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.942695] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.942960] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.943206] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.943452] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.943698] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.943944] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.944192]  </TASK>
[   11.944274] irq event stamp: 0
[   11.944384] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.944649] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.944979] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.945262] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.945479] ---[ end trace 0000000000000000 ]---
[   11.945721] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
[   11.947470] ------------[ cut here ]------------
[   11.947633] WARNING: CPU: 2 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382 amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.949540] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.950093] CPU: 2 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.950386] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.950659] RIP: 0010:amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.952195] Code: 0b e9 de fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 74 ea 65 e1 eb 8b e8 6d e2 65 e1 eb a5 0f 0b e9 94 fe ff ff <0f> 0b 90 90 eb 98 be 03 00 00 00 e8 f4 81 42 e1 eb 8c 66 90 90 90
[   11.952998] RSP: 0018:ffffc900003dba50 EFLAGS: 00010282
[   11.953226] RAX: 00000000ffffffea RBX: ffff8881076cc448 RCX: 00000000ffefffff
[   11.953472] RDX: 0000000000000002 RSI: ffffc900003db808 RDI: 0000000000000001
[   11.953718] RBP: ffff88810e98ff80 R08: 00000000ffefffff R09: 0000000000000058
[   11.953964] R10: 0000000000000000 R11: ffffffff8245a1c0 R12: ffff8881076cc448
[   11.954211] R13: ffff8881076cc580 R14: ffff88810e98ff80 R15: ffff8881006fd3b8
[   11.954457] FS:  00007fa236829880(0000) GS:ffff88842f500000(0000) knlGS:0000000000000000
[   11.954736] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.954936] CR2: 00007fa23681f218 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.955182] Call Trace:
[   11.955279]  <TASK>
[   11.955358]  ? __warn+0x9c/0x1b0
[   11.955482]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.957245]  ? report_bug+0x188/0x1b0
[   11.957382]  ? handle_bug+0x3a/0x70
[   11.957509]  ? exc_invalid_op+0x17/0x70
[   11.957647]  ? asm_exc_invalid_op+0x16/0x20
[   11.957799]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.959303]  ttm_bo_release+0x113/0x330
[   11.959449]  ? __mutex_unlock_slowpath+0x3b/0x290
[   11.959622]  amdgpu_bo_free_kernel+0xe6/0x150 [amdgpu]
[   11.961169]  gfx_v8_0_sw_fini+0x94/0x150 [amdgpu]
[   11.962704]  amdgpu_device_fini_sw+0xb6/0x380 [amdgpu]
[   11.964167]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
[   11.965924]  devm_drm_dev_init_release+0x52/0x70
[   11.966093]  release_nodes+0x36/0x100
[   11.966228]  devres_release_all+0x89/0xc0
[   11.966371]  device_unbind_cleanup+0xe/0x70
[   11.966522]  really_probe+0x1a1/0x390
[   11.966653]  ? pm_runtime_barrier+0x61/0xb0
[   11.966804]  ? __pfx___driver_attach+0x10/0x10
[   11.966961]  __driver_probe_device+0x78/0x150
[   11.967116]  driver_probe_device+0x2d/0xb0
[   11.967262]  __driver_attach+0xdc/0x1d0
[   11.967399]  bus_for_each_dev+0x6a/0xb0
[   11.967538]  bus_add_driver+0x139/0x260
[   11.967676]  driver_register+0x55/0x100
[   11.967814]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.969342]  do_one_initcall+0x60/0x2c0
[   11.969525]  ? kmalloc_trace_noprof+0x272/0x330
[   11.969688]  ? do_init_module+0x22/0x230
[   11.969833]  do_init_module+0x60/0x230
[   11.969968]  init_module_from_file+0x89/0xc0
[   11.970121]  idempotent_init_module+0xf9/0x270
[   11.970280]  __x64_sys_finit_module+0x7b/0xf0
[   11.970435]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   11.970607]  do_syscall_64+0x64/0x130
[   11.970742]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.970924] RIP: 0033:0x7fa236745059
[   11.971054] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   11.971690] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.971954] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   11.972200] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   11.972446] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   11.972758] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   11.973013] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   11.973301]  </TASK>
[   11.973383] irq event stamp: 0
[   11.973492] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   11.973711] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.973997] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   11.974279] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   11.974496] ---[ end trace 0000000000000000 ]---
[   11.974697] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
[   11.976414] ------------[ cut here ]------------
[   11.976634] WARNING: CPU: 2 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382 amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.978479] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   11.979031] CPU: 2 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   11.979323] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   11.979597] RIP: 0010:amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.981398] Code: 0b e9 de fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 74 ea 65 e1 eb 8b e8 6d e2 65 e1 eb a5 0f 0b e9 94 fe ff ff <0f> 0b 90 90 eb 98 be 03 00 00 00 e8 f4 81 42 e1 eb 8c 66 90 90 90
[   11.982035] RSP: 0018:ffffc900003dba40 EFLAGS: 00010282
[   11.982219] RAX: 00000000ffffffea RBX: ffff8881076cd848 RCX: 00000000ffefffff
[   11.982466] RDX: 0000000000000002 RSI: ffffc900003db7f8 RDI: 0000000000000001
[   11.982712] RBP: ffff88810e98ff80 R08: 00000000ffefffff R09: 0000000000000058
[   11.982958] R10: 0000000000000000 R11: ffffffff8245a1c0 R12: ffff8881076cd848
[   11.983203] R13: ffff8881076cd980 R14: ffff88810e98ff80 R15: ffff8881006fd3b8
[   11.983450] FS:  00007fa236829880(0000) GS:ffff88842f500000(0000) knlGS:0000000000000000
[   11.983729] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.983928] CR2: 00007fa23681f218 CR3: 0000000106198000 CR4: 00000000001506f0
[   11.984175] Call Trace:
[   11.984269]  <TASK>
[   11.984349]  ? __warn+0x9c/0x1b0
[   11.984522]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.986152]  ? report_bug+0x188/0x1b0
[   11.986287]  ? handle_bug+0x3a/0x70
[   11.986414]  ? exc_invalid_op+0x17/0x70
[   11.986551]  ? asm_exc_invalid_op+0x16/0x20
[   11.986704]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   11.988201]  ttm_bo_release+0x113/0x330
[   11.988347]  ? __mutex_unlock_slowpath+0x3b/0x290
[   11.988601]  amdgpu_bo_free_kernel+0xe6/0x150 [amdgpu]
[   11.990159]  amdgpu_gfx_rlc_fini+0x47/0x70 [amdgpu]
[   11.991661]  gfx_v8_0_sw_fini+0x9c/0x150 [amdgpu]
[   11.993363]  amdgpu_device_fini_sw+0xb6/0x380 [amdgpu]
[   11.994886]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
[   11.996362]  devm_drm_dev_init_release+0x52/0x70
[   11.996601]  release_nodes+0x36/0x100
[   11.996749]  devres_release_all+0x89/0xc0
[   11.996932]  device_unbind_cleanup+0xe/0x70
[   11.997083]  really_probe+0x1a1/0x390
[   11.997214]  ? pm_runtime_barrier+0x61/0xb0
[   11.997364]  ? __pfx___driver_attach+0x10/0x10
[   11.997522]  __driver_probe_device+0x78/0x150
[   11.997677]  driver_probe_device+0x2d/0xb0
[   11.997823]  __driver_attach+0xdc/0x1d0
[   11.997960]  bus_for_each_dev+0x6a/0xb0
[   11.998100]  bus_add_driver+0x139/0x260
[   11.998237]  driver_register+0x55/0x100
[   11.998376]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   11.999827]  do_one_initcall+0x60/0x2c0
[   11.999970]  ? kmalloc_trace_noprof+0x272/0x330
[   12.000132]  ? do_init_module+0x22/0x230
[   12.000277]  do_init_module+0x60/0x230
[   12.000411]  init_module_from_file+0x89/0xc0
[   12.000628]  idempotent_init_module+0xf9/0x270
[   12.000814]  __x64_sys_finit_module+0x7b/0xf0
[   12.001009]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   12.001181]  do_syscall_64+0x64/0x130
[   12.001316]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   12.001499] RIP: 0033:0x7fa236745059
[   12.001629] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   12.002264] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   12.002529] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   12.002775] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   12.003021] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   12.003267] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   12.003513] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   12.003761]  </TASK>
[   12.003842] irq event stamp: 0
[   12.003952] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   12.004170] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   12.004455] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   12.004874] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   12.005111] ---[ end trace 0000000000000000 ]---
[   12.005352] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
[   12.007096] ------------[ cut here ]------------
[   12.007258] WARNING: CPU: 2 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382 amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.009093] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   12.009647] CPU: 2 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   12.009939] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   12.010212] RIP: 0010:amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.011728] Code: 0b e9 de fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 74 ea 65 e1 eb 8b e8 6d e2 65 e1 eb a5 0f 0b e9 94 fe ff ff <0f> 0b 90 90 eb 98 be 03 00 00 00 e8 f4 81 42 e1 eb 8c 66 90 90 90
[   12.012364] RSP: 0018:ffffc900003dba50 EFLAGS: 00010282
[   12.012612] RAX: 00000000ffffffea RBX: ffff8881076ce448 RCX: 00000000ffefffff
[   12.012908] RDX: 0000000000000002 RSI: ffffc900003db808 RDI: 0000000000000001
[   12.013154] RBP: ffff88810e98ff80 R08: 00000000ffefffff R09: 0000000000000058
[   12.013401] R10: 0000000000000000 R11: ffffffff8245a1c0 R12: ffff8881076ce448
[   12.013646] R13: ffff8881076ce580 R14: ffff88810e98ff80 R15: ffff8881006fd3b8
[   12.013893] FS:  00007fa236829880(0000) GS:ffff88842f500000(0000) knlGS:0000000000000000
[   12.014172] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.014372] CR2: 00007fa23681f218 CR3: 0000000106198000 CR4: 00000000001506f0
[   12.014618] Call Trace:
[   12.014713]  <TASK>
[   12.014793]  ? __warn+0x9c/0x1b0
[   12.014916]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.016412]  ? report_bug+0x188/0x1b0
[   12.016610]  ? handle_bug+0x3a/0x70
[   12.016761]  ? exc_invalid_op+0x17/0x70
[   12.016939]  ? asm_exc_invalid_op+0x16/0x20
[   12.017091]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.018614]  ttm_bo_release+0x113/0x330
[   12.018759]  ? __mutex_unlock_slowpath+0x3b/0x290
[   12.018932]  amdgpu_bo_free_kernel+0xe6/0x150 [amdgpu]
[   12.020408]  gfx_v8_0_sw_fini+0x9c/0x150 [amdgpu]
[   12.022121]  amdgpu_device_fini_sw+0xb6/0x380 [amdgpu]
[   12.023631]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
[   12.025165]  devm_drm_dev_init_release+0x52/0x70
[   12.025371]  release_nodes+0x36/0x100
[   12.025507]  devres_release_all+0x89/0xc0
[   12.025652]  device_unbind_cleanup+0xe/0x70
[   12.025802]  really_probe+0x1a1/0x390
[   12.025934]  ? pm_runtime_barrier+0x61/0xb0
[   12.026084]  ? __pfx___driver_attach+0x10/0x10
[   12.026242]  __driver_probe_device+0x78/0x150
[   12.026397]  driver_probe_device+0x2d/0xb0
[   12.026543]  __driver_attach+0xdc/0x1d0
[   12.026680]  bus_for_each_dev+0x6a/0xb0
[   12.026820]  bus_add_driver+0x139/0x260
[   12.026957]  driver_register+0x55/0x100
[   12.027096]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   12.028656]  do_one_initcall+0x60/0x2c0
[   12.028846]  ? kmalloc_trace_noprof+0x272/0x330
[   12.029010]  ? do_init_module+0x22/0x230
[   12.029155]  do_init_module+0x60/0x230
[   12.029289]  init_module_from_file+0x89/0xc0
[   12.029443]  idempotent_init_module+0xf9/0x270
[   12.029602]  __x64_sys_finit_module+0x7b/0xf0
[   12.029757]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   12.029929]  do_syscall_64+0x64/0x130
[   12.030064]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   12.030246] RIP: 0033:0x7fa236745059
[   12.030376] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   12.031012] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   12.031276] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   12.031523] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   12.031768] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   12.032015] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   12.032261] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   12.032560]  </TASK>
[   12.032659] irq event stamp: 0
[   12.032810] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   12.033028] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   12.033313] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   12.033595] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   12.033812] ---[ end trace 0000000000000000 ]---
[   12.034248] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
[   12.036005] ------------[ cut here ]------------
[   12.036167] WARNING: CPU: 2 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382 amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.038164] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   12.038718] CPU: 2 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   12.039010] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   12.039284] RIP: 0010:amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.040950] Code: 0b e9 de fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 74 ea 65 e1 eb 8b e8 6d e2 65 e1 eb a5 0f 0b e9 94 fe ff ff <0f> 0b 90 90 eb 98 be 03 00 00 00 e8 f4 81 42 e1 eb 8c 66 90 90 90
[   12.041632] RSP: 0018:ffffc900003dba68 EFLAGS: 00010282
[   12.041817] RAX: 00000000ffffffea RBX: ffff8881095a0c48 RCX: 00000000ffefffff
[   12.042063] RDX: 0000000000000002 RSI: ffffc900003db820 RDI: 0000000000000001
[   12.042309] RBP: ffff88810e98ff80 R08: 00000000ffefffff R09: 0000000000000058
[   12.042556] R10: 0000000000000000 R11: ffffffff8245a1c0 R12: ffff8881095a0c48
[   12.042802] R13: ffff8881095a0d80 R14: ffff88810e98ff80 R15: ffff8881006fd3b8
[   12.043048] FS:  00007fa236829880(0000) GS:ffff88842f500000(0000) knlGS:0000000000000000
[   12.043327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.043526] CR2: 00007fa23681f218 CR3: 0000000106198000 CR4: 00000000001506f0
[   12.043773] Call Trace:
[   12.043868]  <TASK>
[   12.043948]  ? __warn+0x9c/0x1b0
[   12.044072]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.045844]  ? report_bug+0x188/0x1b0
[   12.045981]  ? handle_bug+0x3a/0x70
[   12.046109]  ? exc_invalid_op+0x17/0x70
[   12.046246]  ? asm_exc_invalid_op+0x16/0x20
[   12.046399]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.047908]  ? amdgpu_bo_release_notify+0xf8/0x1d0 [amdgpu]
[   12.049504]  ttm_bo_release+0x113/0x330
[   12.049653]  ? __mutex_unlock_slowpath+0x3b/0x290
[   12.049826]  amdgpu_bo_free_kernel+0xe6/0x150 [amdgpu]
[   12.051311]  amdgpu_device_fini_sw+0x129/0x380 [amdgpu]
[   12.052919]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
[   12.054454]  devm_drm_dev_init_release+0x52/0x70
[   12.054623]  release_nodes+0x36/0x100
[   12.054758]  devres_release_all+0x89/0xc0
[   12.054902]  device_unbind_cleanup+0xe/0x70
[   12.055052]  really_probe+0x1a1/0x390
[   12.055184]  ? pm_runtime_barrier+0x61/0xb0
[   12.055334]  ? __pfx___driver_attach+0x10/0x10
[   12.055492]  __driver_probe_device+0x78/0x150
[   12.055647]  driver_probe_device+0x2d/0xb0
[   12.055793]  __driver_attach+0xdc/0x1d0
[   12.055930]  bus_for_each_dev+0x6a/0xb0
[   12.056069]  bus_add_driver+0x139/0x260
[   12.056207]  driver_register+0x55/0x100
[   12.056345]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   12.057826]  do_one_initcall+0x60/0x2c0
[   12.057970]  ? kmalloc_trace_noprof+0x272/0x330
[   12.058133]  ? do_init_module+0x22/0x230
[   12.058277]  do_init_module+0x60/0x230
[   12.058412]  init_module_from_file+0x89/0xc0
[   12.058565]  idempotent_init_module+0xf9/0x270
[   12.058724]  __x64_sys_finit_module+0x7b/0xf0
[   12.058879]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   12.059051]  do_syscall_64+0x64/0x130
[   12.059186]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   12.059367] RIP: 0033:0x7fa236745059
[   12.059498] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   12.060134] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   12.060397] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   12.060704] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   12.061009] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   12.061256] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   12.061502] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   12.061750]  </TASK>
[   12.061831] irq event stamp: 0
[   12.061941] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   12.062159] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   12.062445] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   12.062727] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   12.062945] ---[ end trace 0000000000000000 ]---
[   12.063286] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
[   12.065174] ------------[ cut here ]------------
[   12.065337] WARNING: CPU: 2 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382 amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.067069] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   12.067621] CPU: 2 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   12.067914] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   12.068187] RIP: 0010:amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.069904] Code: 0b e9 de fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 74 ea 65 e1 eb 8b e8 6d e2 65 e1 eb a5 0f 0b e9 94 fe ff ff <0f> 0b 90 90 eb 98 be 03 00 00 00 e8 f4 81 42 e1 eb 8c 66 90 90 90
[   12.070542] RSP: 0018:ffffc900003dba58 EFLAGS: 00010282
[   12.070726] RAX: 00000000ffffffea RBX: ffff8881095a0048 RCX: 00000000ffefffff
[   12.070972] RDX: 0000000000000002 RSI: ffffc900003db810 RDI: 0000000000000001
[   12.071218] RBP: ffff88810e98ff80 R08: 00000000ffefffff R09: 0000000000000058
[   12.071464] R10: 0000000000000000 R11: ffffffff8245a1c0 R12: ffff8881095a0048
[   12.071710] R13: ffff8881095a0180 R14: ffff88810e98ff80 R15: ffff8881006fd3b8
[   12.071957] FS:  00007fa236829880(0000) GS:ffff88842f500000(0000) knlGS:0000000000000000
[   12.072235] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.072435] CR2: 00007fa23681f218 CR3: 0000000106198000 CR4: 00000000001506f0
[   12.072753] Call Trace:
[   12.072863]  <TASK>
[   12.072946]  ? __warn+0x9c/0x1b0
[   12.073119]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.074619]  ? report_bug+0x188/0x1b0
[   12.074754]  ? handle_bug+0x3a/0x70
[   12.074881]  ? exc_invalid_op+0x17/0x70
[   12.075019]  ? asm_exc_invalid_op+0x16/0x20
[   12.075170]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.076752]  ? amdgpu_bo_release_notify+0xf8/0x1d0 [amdgpu]
[   12.078351]  ttm_bo_release+0x113/0x330
[   12.078497]  ? __mutex_unlock_slowpath+0x3b/0x290
[   12.078669]  amdgpu_bo_free_kernel+0xe6/0x150 [amdgpu]
[   12.080153]  gmc_v8_0_sw_fini+0x2a/0x50 [amdgpu]
[   12.081883]  amdgpu_device_fini_sw+0xb6/0x380 [amdgpu]
[   12.083388]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
[   12.084957]  devm_drm_dev_init_release+0x52/0x70
[   12.085167]  release_nodes+0x36/0x100
[   12.085303]  devres_release_all+0x89/0xc0
[   12.085447]  device_unbind_cleanup+0xe/0x70
[   12.085598]  really_probe+0x1a1/0x390
[   12.085730]  ? pm_runtime_barrier+0x61/0xb0
[   12.085881]  ? __pfx___driver_attach+0x10/0x10
[   12.086038]  __driver_probe_device+0x78/0x150
[   12.086194]  driver_probe_device+0x2d/0xb0
[   12.086340]  __driver_attach+0xdc/0x1d0
[   12.086477]  bus_for_each_dev+0x6a/0xb0
[   12.086616]  bus_add_driver+0x139/0x260
[   12.086754]  driver_register+0x55/0x100
[   12.086893]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   12.088346]  do_one_initcall+0x60/0x2c0
[   12.088621]  ? kmalloc_trace_noprof+0x272/0x330
[   12.088832]  ? do_init_module+0x22/0x230
[   12.088977]  do_init_module+0x60/0x230
[   12.089111]  init_module_from_file+0x89/0xc0
[   12.089265]  idempotent_init_module+0xf9/0x270
[   12.089424]  __x64_sys_finit_module+0x7b/0xf0
[   12.089579]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   12.089750]  do_syscall_64+0x64/0x130
[   12.089884]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   12.090066] RIP: 0033:0x7fa236745059
[   12.090195] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   12.090830] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   12.091094] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   12.091340] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   12.091586] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   12.091832] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   12.092078] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   12.092326]  </TASK>
[   12.092407] irq event stamp: 0
[   12.092585] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   12.092855] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   12.093142] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   12.093424] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   12.093641] ---[ end trace 0000000000000000 ]---
[   12.093954] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
[   12.095812] ------------[ cut here ]------------
[   12.095974] WARNING: CPU: 3 PID: 1219 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382 amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.097976] Modules linked in: amdgpu(+) i2c_algo_bit drm_exec drm_suballoc_helper amdxcp input_leds drm_buddy led_class psmouse serio_raw gpu_sched drm_display_helper video wmi
[   12.098532] CPU: 3 PID: 1219 Comm: systemd-udevd Tainted: G        W          6.10.0-rc1+ #1
[   12.098825] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[   12.099098] RIP: 0010:amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.100703] Code: 0b e9 de fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 74 ea 65 e1 eb 8b e8 6d e2 65 e1 eb a5 0f 0b e9 94 fe ff ff <0f> 0b 90 90 eb 98 be 03 00 00 00 e8 f4 81 42 e1 eb 8c 66 90 90 90
[   12.101399] RSP: 0018:ffffc900003dba18 EFLAGS: 00010282
[   12.101583] RAX: 00000000ffffffea RBX: ffff8881095a1048 RCX: 00000000ffefffff
[   12.101829] RDX: 0000000000000003 RSI: ffffc900003db7d0 RDI: 0000000000000001
[   12.102075] RBP: ffff88810e98ff80 R08: 00000000ffefffff R09: 0000000000000058
[   12.102321] R10: 0000000000000000 R11: ffffffff8245a1c0 R12: ffff8881095a1048
[   12.102568] R13: ffff8881095a1180 R14: ffff88810e98ff80 R15: ffff8881006fd3b8
[   12.102814] FS:  00007fa236829880(0000) GS:ffff88842f580000(0000) knlGS:0000000000000000
[   12.103093] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.103293] CR2: 00007fff701467d8 CR3: 0000000106198000 CR4: 00000000001506f0
[   12.103540] Call Trace:
[   12.103635]  <TASK>
[   12.103715]  ? __warn+0x9c/0x1b0
[   12.103839]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.105531]  ? report_bug+0x188/0x1b0
[   12.105667]  ? handle_bug+0x3a/0x70
[   12.105795]  ? exc_invalid_op+0x17/0x70
[   12.105932]  ? asm_exc_invalid_op+0x16/0x20
[   12.106084]  ? amdgpu_bo_release_notify+0x1bc/0x1d0 [amdgpu]
[   12.107593]  ? amdgpu_bo_release_notify+0xf8/0x1d0 [amdgpu]
[   12.109118]  ttm_bo_release+0x113/0x330
[   12.109265]  ? __mutex_unlock_slowpath+0x3b/0x290
[   12.109439]  amdgpu_bo_free_kernel+0xe6/0x150 [amdgpu]
[   12.110918]  amdgpu_ttm_fini+0x19a/0x1e0 [amdgpu]
[   12.112364]  amdgpu_bo_fini+0x16/0x80 [amdgpu]
[   12.113899]  gmc_v8_0_sw_fini+0x32/0x50 [amdgpu]
[   12.115441]  amdgpu_device_fini_sw+0xb6/0x380 [amdgpu]
[   12.116928]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
[   12.118397]  devm_drm_dev_init_release+0x52/0x70
[   12.118566]  release_nodes+0x36/0x100
[   12.118701]  devres_release_all+0x89/0xc0
[   12.118845]  device_unbind_cleanup+0xe/0x70
[   12.118996]  really_probe+0x1a1/0x390
[   12.119128]  ? pm_runtime_barrier+0x61/0xb0
[   12.119279]  ? __pfx___driver_attach+0x10/0x10
[   12.119436]  __driver_probe_device+0x78/0x150
[   12.119591]  driver_probe_device+0x2d/0xb0
[   12.119737]  __driver_attach+0xdc/0x1d0
[   12.119875]  bus_for_each_dev+0x6a/0xb0
[   12.120014]  bus_add_driver+0x139/0x260
[   12.120152]  driver_register+0x55/0x100
[   12.120290]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   12.121861]  do_one_initcall+0x60/0x2c0
[   12.122047]  ? kmalloc_trace_noprof+0x272/0x330
[   12.122210]  ? do_init_module+0x22/0x230
[   12.122355]  do_init_module+0x60/0x230
[   12.122489]  init_module_from_file+0x89/0xc0
[   12.122643]  idempotent_init_module+0xf9/0x270
[   12.122802]  __x64_sys_finit_module+0x7b/0xf0
[   12.122957]  ? trace_hardirqs_on_prepare+0x88/0xc0
[   12.123128]  do_syscall_64+0x64/0x130
[   12.123264]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   12.123446] RIP: 0033:0x7fa236745059
[   12.123576] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   12.124211] RSP: 002b:00007fff70147348 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   12.124493] RAX: ffffffffffffffda RBX: 000055aeab1abb10 RCX: 00007fa236745059
[   12.124740] RDX: 0000000000000000 RSI: 00007fa236638ded RDI: 0000000000000013
[   12.124986] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055aeab1b21a8
[   12.125233] R10: 0000000000000013 R11: 0000000000000246 R12: 00007fa236638ded
[   12.125478] R13: 0000000000000000 R14: 000055aeab1c79b0 R15: 000055aeab1abb10
[   12.125726]  </TASK>
[   12.125808] irq event stamp: 0
[   12.125918] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   12.126137] hardirqs last disabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   12.126423] softirqs last  enabled at (0): [<ffffffff81091ac5>] copy_process+0x945/0x28c0
[   12.126705] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   12.126922] ---[ end trace 0000000000000000 ]---
[   12.127656] [drm] amdgpu: ttm finalized
[   12.161416] process '/usr/bin/fstype' started with executable stack
[   12.177725] PM: Image not found (code -22)
[   12.243834] EXT4-fs (sda2): mounted filesystem c34989f9-7c8f-49ae-8285-7896af84c685 ro with ordered data mode. Quota mode: disabled.
[   12.273286] printk: systemd-udevd: 25 output lines suppressed due to ratelimiting
[   12.899910] systemd-udevd[1417]: /etc/udev/rules.d/storage_devices.rules:1 Invalid value for OPTIONS key, ignoring: 'all_partitions'
[   13.215850] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input10
[   13.234855] ACPI: AC: AC Adapter [AC] (on-line)
[   13.258230] ACPI: button: Power Button [PWRB]
[   13.261508] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input11
[   13.264669] ACPI: button: Sleep Button [SLPB]
[   13.270603] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input12
[   13.313512] ACPI: button: Lid Switch [LID]
[   13.315578] ACPI: battery: Slot [BAT0] (battery present)
[   13.332608] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input13
[   13.356365] ACPI: button: Power Button [PWRF]
[   13.418410] tg3 0000:01:00.0 eth0: Tigon3 [partno(BCM95762) rev 5762100] (PCI Express) MAC address fc:3f:db:fc:10:9f
[   13.418839] tg3 0000:01:00.0 eth0: attached PHY is 5762C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   13.419210] tg3 0000:01:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   13.419492] tg3 0000:01:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[   13.423323] acpi_cpufreq: overriding BIOS provided _PSD data
[   13.450616] input: PC Speaker as /devices/platform/pcspkr/input/input14
[   13.488091] snd_hda_intel 0000:00:01.1: Force to non-snoop mode
[   13.494413] cryptd: max_cpu_qlen set to 1000
[   13.526016] AVX2 version of gcm_enc/dec engaged.
[   13.526284] AES CTR mode by8 optimization enabled
[   13.534469] systemd-udevd[1426]: ethtool: autonegotiation is unset or enabled, the speed and duplex are not writable.
[   13.558246] snd_hda_codec_generic hdaudioC1D0: autoconfig for Generic: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[   13.558652] snd_hda_codec_generic hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   13.558942] snd_hda_codec_generic hdaudioC1D0:    hp_outs=1 (0x1d/0x0/0x0/0x0/0x0)
[   13.559417] snd_hda_codec_generic hdaudioC1D0:    mono: mono_out=0x0
[   13.559654] snd_hda_codec_generic hdaudioC1D0:    inputs:
[   13.559852] snd_hda_codec_generic hdaudioC1D0:      Internal Mic=0x1a
[   13.560089] snd_hda_codec_generic hdaudioC1D0:      Mic=0x19
[   13.580873] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   13.623994] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   13.625393] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   13.630691] cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
[   13.652567] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:09.2/sound/card1/input18
[   13.658049] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/sound/card0/input15
[   13.663587] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/sound/card0/input16
[   13.670603] input: HD-Audio Generic Headphone as /devices/pci0000:00/0000:00:09.2/sound/card1/input19
[   13.693575] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.1/sound/card0/input17
[   13.750461] Intel(R) Wireless WiFi driver for Linux
[   13.759556] iwlwifi 0000:02:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
[   13.759841] iwlwifi 0000:02:00.0: PCI dev 095a/5010, rev=0x210, rfid=0xd55555d5
[   13.770900] iwlwifi 0000:02:00.0: loaded firmware version 29.1044073957.0 7265D-29.ucode op_mode iwlmvm
[   13.985026] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless AC 7265, REV=0x210
[   13.987883] systemd-udevd[1445]: Using default interface naming scheme 'v243'.
[   14.019055] thermal thermal_zone5: failed to read out thermal zone (-61)
[   14.048302] iwlwifi 0000:02:00.0: base HW address: 18:5e:0f:ef:3f:49, OTP minor version: 0x0
[   14.114326] systemd-udevd[1445]: ethtool: autonegotiation is unset or enabled, the speed and duplex are not writable.
[   14.116893] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   14.126639] systemd-udevd[1435]: Using default interface naming scheme 'v243'.
[   14.133597] systemd-udevd[1435]: ethtool: autonegotiation is unset or enabled, the speed and duplex are not writable.
[   14.221098] kvm_amd: TSC scaling supported
[   14.221594] kvm_amd: Nested Virtualization enabled
[   14.222170] kvm_amd: Nested Paging enabled
[   14.222675] kvm_amd: Virtual GIF supported
[   14.223157] kvm_amd: LBR virtualization supported
[   14.252137] MCE: In-kernel MCE decoding enabled.
[   14.256014] EDAC DEBUG: reserve_mc_sibling_devs: F1: 0000:00:18.1
[   14.256766] EDAC DEBUG: reserve_mc_sibling_devs: F2: 0000:00:18.2
[   14.257536] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[   14.258270] EDAC DEBUG: dct_read_base_mask:   DCSB0[0]=0x00000001 reg: F2x40
[   14.259105] EDAC DEBUG: dct_read_base_mask:   DCSB1[0]=0x00000001 reg: F2x40
[   14.259940] EDAC DEBUG: dct_read_base_mask:   DCSB0[1]=0x00000021 reg: F2x44
[   14.260863] EDAC DEBUG: dct_read_base_mask:   DCSB1[1]=0x00000021 reg: F2x44
[   14.261748] EDAC DEBUG: dct_read_base_mask:   DCSB0[2]=0x00000000 reg: F2x48
[   14.262583] EDAC DEBUG: dct_read_base_mask:   DCSB1[2]=0x00000000 reg: F2x48
[   14.263419] EDAC DEBUG: dct_read_base_mask:   DCSB0[3]=0x00000000 reg: F2x4c
[   14.264259] EDAC DEBUG: dct_read_base_mask:   DCSB1[3]=0x00000000 reg: F2x4c
[   14.265238] EDAC DEBUG: dct_read_base_mask:   DCSB0[4]=0x00000000 reg: F2x50
[   14.266180] EDAC DEBUG: dct_read_base_mask:   DCSB1[4]=0x00000000 reg: F2x50
[   14.266983] EDAC DEBUG: dct_read_base_mask:   DCSB0[5]=0x00000000 reg: F2x54
[   14.267811] EDAC DEBUG: dct_read_base_mask:   DCSB1[5]=0x00000000 reg: F2x54
[   14.268721] EDAC DEBUG: dct_read_base_mask:   DCSB0[6]=0x00000000 reg: F2x58
[   14.269619] EDAC DEBUG: dct_read_base_mask:   DCSB1[6]=0x00000000 reg: F2x58
[   14.270421] EDAC DEBUG: dct_read_base_mask:   DCSB0[7]=0x00000000 reg: F2x5c
[   14.271250] EDAC DEBUG: dct_read_base_mask:   DCSB1[7]=0x00000000 reg: F2x5c
[   14.272085] EDAC DEBUG: dct_read_base_mask:     DCSM0[0]=0x01f8ffc0 reg: F2x60
[   14.273066] EDAC DEBUG: dct_read_base_mask:     DCSM1[0]=0x01f8ffc0 reg: F2x60
[   14.273901] EDAC DEBUG: dct_read_base_mask:     DCSM0[1]=0x00000000 reg: F2x64
[   14.274736] EDAC DEBUG: dct_read_base_mask:     DCSM1[1]=0x00000000 reg: F2x64
[   14.275571] EDAC DEBUG: dct_read_base_mask:     DCSM0[2]=0x00000000 reg: F2x68
[   14.276406] EDAC DEBUG: dct_read_base_mask:     DCSM1[2]=0x00000000 reg: F2x68
[   14.277349] EDAC DEBUG: dct_read_base_mask:     DCSM0[3]=0x00000000 reg: F2x6c
[   14.278185] EDAC DEBUG: dct_read_base_mask:     DCSM1[3]=0x00000000 reg: F2x6c
[   14.279020] EDAC DEBUG: dct_read_mc_regs:   TOP_MEM:  0x00000000c0000000
[   14.279802] EDAC DEBUG: dct_read_mc_regs:   TOP_MEM2: 0x000000043f000000
[   14.280663] EDAC DEBUG: read_dram_ctl_register: F2x110 (DCTSelLow): 0x00000104, High range addrs at: 0x0
[   14.281960] EDAC DEBUG: read_dram_ctl_register:   DCTs operate in unganged mode
[   14.282836] EDAC DEBUG: read_dram_ctl_register:   Address range split per DCT: no
[   14.283720] EDAC DEBUG: read_dram_ctl_register:   data interleave for ECC: disabled, DRAM cleared since last warm reset: no
[   14.285110] EDAC DEBUG: read_dram_ctl_register:   channel interleave: enabled, interleave bits selector: 0x0
[   14.286249] EDAC DEBUG: dct_read_mc_regs:   DRAM range[0], base: 0x0000000000000000; limit: 0x000000043fffffff
[   14.287414] EDAC DEBUG: dct_read_mc_regs:    IntlvEn=Enabled; Range access: RW IntlvSel=0 DstNode=0
[   14.288632] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 0, MCG_CTL: 0x77, NB MSR is enabled
[   14.289707] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 1, MCG_CTL: 0x77, NB MSR is enabled
[   14.290699] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 2, MCG_CTL: 0x77, NB MSR is enabled
[   14.291722] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 3, MCG_CTL: 0x77, NB MSR is enabled
[   15.495894] Adding 15721468k swap on /dev/sda1.  Priority:-2 extents:1 across:15721468k SS
[   15.568910] EXT4-fs (sda2): re-mounted c34989f9-7c8f-49ae-8285-7896af84c685 r/w. Quota mode: disabled.
[   16.152011] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[   16.185632] loop: module loaded
[   16.210159] tg3 0000:01:00.0 eth0: Link is up at 100 Mbps, full duplex
[   16.210417] tg3 0000:01:00.0 eth0: Flow control is on for TX and on for RX
[   16.210661] tg3 0000:01:00.0 eth0: EEE is disabled
[   16.334131] EXT4-fs (sda5): mounted filesystem d78a2e53-75c6-4d4a-887c-f4a66a64ba8c r/w with ordered data mode. Quota mode: disabled.
[   16.335322] /dev/stick1: Can't lookup blockdev

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

