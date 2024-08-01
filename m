Return-Path: <linux-kernel+bounces-271040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7F39448B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3F61F216AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D954161326;
	Thu,  1 Aug 2024 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gFNPNRoJ"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A0EEB3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505592; cv=none; b=g/EVPTG1ckRj4hccCDalvCU5qLXnurEhh0Q5QtYVEQzcWnu2jO0hYkEdF0PInH/jkSR+JkYDll+sMZmnIYlhHXxV+y/beNZW11juo+MTmG+YUjGr+f6mA9vu3V4iTm1esyjCMqr14oetRKDmfBjY6U2XvRHpotxWh3JjgMlXeQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505592; c=relaxed/simple;
	bh=gt1zDgiOZhw+jkpdb9+mBb/0NrcXZxe/7vr9/6JN6/A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=pwJnjUZspL3yi49Y3hiMCgRaw2HORcGqqFiBy/p1i1apE/QZayh14fxefZDycpgXIzgS8rBk3fEpbRpk/V1Iy1EEhy7Cw7124ZL/RjZKu7bZhRPWdkWzoOXXs49iNiwKJ3URwBrwL69unUde8GYZWI7kLUU0iERWAFqnVXNspys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gFNPNRoJ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WZPHL5nbfz9sSl;
	Thu,  1 Aug 2024 11:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1722505582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=0ODfu+hzgtz7d+FUWzja8VvaKRCC7vvKkY26kGB5ts4=;
	b=gFNPNRoJAY4iGlEWSg5+ibFOArA6/XtwDSTm+XAjINPUBDzzg2bMrj37LygO+Fz/iW7PcW
	hkfTNEEqw96v9WQrYgh1+Sjd5II0YavF5+2vHpL1PLJKl98IG2N5YJfC/6erb8gbaFuiRd
	pFxzfAUV9s9SQlm3utRujKlDv/6L+p0pKs+xsGkFwrKFMi/B3ZVNDCATT3A5y1UkmSWVRI
	3FtOXCej0KMHckKY2+lnRCbDr0t6m1TW7eYz08eNZDMKJKHA/kVMfoELqlWyf22JADZJpv
	/jrOdOTG5rHR95Y5F08rUxY4M7iyfC1Pk3olsafyVprwhXVuMpfGU34515VFzw==
Date: Thu, 1 Aug 2024 11:46:05 +0200
From: Erhard Furtner <erhard_f@mailbox.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: alloc_tag was not set WARNING: CPU: 1 PID: 0 at
 include/linux/alloc_tag.h:130 alloc_tagging_slab_free_hook+0x17f/0x1ec
Message-ID: <20240801114605.78ea42ce@yea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/h5wDT.s6wbxhPxXH4h.e5+J"
X-MBO-RS-ID: 2873f693b88c49fed62
X-MBO-RS-META: cic8o3p6e3n9w7up54znn1cw99wmfz3b

--MP_/h5wDT.s6wbxhPxXH4h.e5+J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings!

This report is similar to https://lore.kernel.org/all/20240530163812.33b0ab78@yea/ but on v6.11-rc1 and the attached .config I get this every time at boot:

------------[ cut here ]------------
alloc_tag was not set
WARNING: CPU: 1 PID: 0 at include/linux/alloc_tag.h:130 alloc_tagging_slab_free_hook+0x17f/0x1ec
Modules linked in:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.0-rc1-P3 #2
Hardware name: LENOVO 2007F2G/2007F2G, BIOS 79ETE7WW (2.27 ) 03/21/2011
EIP: alloc_tagging_slab_free_hook+0x17f/0x1ec
Code: 4f 0f 85 d8 fe ff ff eb 7e c6 05 ca 76 8e d8 01 68 49 10 68 d8 89 cb 89 45 e4 e8 28 ca e0 ff 8b 45 e4 89 d9 8b 55 ec 83 c4 04 <0f> 0b 8b 5c da 04 e9 28 ff ff ff e8 b1 26 72 00 8b 55 ec e9 6b ff
EAX: 000000a0 EBX: 00000000 ECX: 00000000 EDX: f728bef8
ESI: c12b9f34 EDI: 00000001 EBP: c12b9f18 ESP: c12b9ef0
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210296
CR0: 80050033 CR2: 00000000 CR3: 18a1e000 CR4: 000006f0
Call Trace:
 <SOFTIRQ>
 ? show_regs+0x4e/0x5c
 ? alloc_tagging_slab_free_hook+0x17f/0x1ec
 ? __warn+0x88/0x164
 ? alloc_tagging_slab_free_hook+0x17f/0x1ec
 ? alloc_tagging_slab_free_hook+0x17f/0x1ec
 ? report_bug+0xa0/0x11c
 ? exc_overflow+0x3c/0x3c
 ? handle_bug+0x30/0x50
 ? exc_invalid_op+0x17/0x40
 ? handle_exception+0x101/0x101
 ? exc_overflow+0x3c/0x3c
 ? alloc_tagging_slab_free_hook+0x17f/0x1ec
 ? exc_overflow+0x3c/0x3c
 ? alloc_tagging_slab_free_hook+0x17f/0x1ec
 ? lock_acquire+0xbe/0x1e4
 ? rcu_nocb_unlock_irqrestore+0x3c/0x3c
 kmem_cache_free+0xeb/0x2d0
 ? mem_pool_free+0x6f/0x80
 ? rcu_lock_release+0x18/0x18
 mem_pool_free+0x6f/0x80
 ? rcu_lock_release+0x18/0x18
 free_object_rcu+0x69/0x74
 ? rcu_lock_release+0x18/0x18
 rcu_core+0x2cd/0x66c
 rcu_core_si+0x8/0xc
 handle_softirqs+0xf6/0x358
 ? __lock_text_end+0x2/0x2
 __do_softirq+0xa/0xe
 do_softirq_own_stack+0x50/0x58
 </SOFTIRQ>
 ? sysvec_call_function_single+0x30/0x30
 __irq_exit_rcu+0x54/0x98
 irq_exit_rcu+0x8/0x14
 sysvec_apic_timer_interrupt+0x1f/0x34
 handle_exception+0x101/0x101
EIP: mwait_idle+0x53/0x64
Code: ae 3e 0f ae f0 8d 76 00 89 f0 31 c9 31 d2 0f 01 c8 f7 06 08 00 00 00 75 12 eb 07 0f 00 2d f4 8e 38 d8 31 c0 31 c9 fb 0f 01 c9 <fa> f0 80 66 02 df 5e 5d 31 c0 31 c9 31 d2 c3 cc cc 55 89 e5 53 57
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: c1280040 EDI: c1280040 EBP: c1271f58 ESP: c1271f54
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00200246
 ? sysvec_call_function_single+0x30/0x30
 ? sysvec_call_function_single+0x30/0x30
 ? mwait_idle+0x53/0x64
 ? do_idle+0xb7/0x208
 arch_cpu_idle+0x8/0xc
 default_idle_call+0x66/0x9c
 do_idle+0xb7/0x208
 ? complete+0xc/0x14
 cpu_startup_entry+0x21/0x24
 start_secondary+0x9f/0xac
 startup_32_smp+0x151/0x154
irq event stamp: 20888
hardirqs last  enabled at (20896): [<d7aca9fa>] console_unlock+0xbe/0x144
hardirqs last disabled at (20903): [<d7aca9e1>] console_unlock+0xa5/0x144
softirqs last  enabled at (15774): [<d7a6396e>] handle_softirqs+0x31e/0x358
softirqs last disabled at (15799): [<d837edea>] __do_softirq+0xa/0xe
---[ end trace 0000000000000000 ]---


Full dmesg and kernel .config attached.

Regards,
Erhard

--MP_/h5wDT.s6wbxhPxXH4h.e5+J
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg_611-rc1_p3.txt

[    0.000000] Linux version 6.11.0-rc1-P3 (root@supah) (clang version 18.1.8, LLD 18.1.8) #2 SMP Tue Jul 30 21:23:44 -00 2024
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] Disabled fast string operations
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000dc000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bfecffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bfed0000-0x00000000bfedefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bfedf000-0x00000000bfefffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bff00000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f3ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed003ff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed14000-0x00000000fed19fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: LENOVO 2007F2G/2007F2G, BIOS 79ETE7WW (2.27 ) 03/21/2011
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1828.629 MHz processor
[    0.003917] last_pfn = 0xbfedf max_arch_pfn = 0x1000000
[    0.003940] total RAM covered: 3071M
[    0.005312] Found optimal setting for mtrr clean up
[    0.005316]  gran_size: 64K 	chunk_size: 2M 	num_reg: 3  	lose cover RAM: 0G
[    0.005332] MTRR map: 8 entries (6 fixed + 2 variable; max 22), built from 8 variable MTRRs
[    0.005338] x86/PAT: PAT not supported by the CPU.
[    0.005343] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.011673] found SMP MP-table at [mem 0x000f6810-0x000f681f]
[    0.011827] RAMDISK: [mem 0x36383000-0x371b8fff]
[    0.011842] ACPI: Early table checksum verification disabled
[    0.011850] ACPI: RSDP 0x00000000000F67E0 000024 (v02 LENOVO)
[    0.011864] ACPI: XSDT 0x00000000BFED14A0 000084 (v01 LENOVO TP-79    00002270  LTP 00000000)
[    0.011881] ACPI: FACP 0x00000000BFED1600 0000F4 (v03 LENOVO TP-79    00002270 LNVO 00000001)
[    0.011895] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 64/32 (20240322/tbfadt-560)
[    0.011907] ACPI BIOS Warning (bug): Optional FADT field Gpe1Block has valid Address but zero Length: 0x000000000000102C/0x0 (20240322/tbfadt-611)
[    0.011921] ACPI: DSDT 0x00000000BFED195E 00D467 (v01 LENOVO TP-79    00002270 MSFT 0100000E)
[    0.011934] ACPI: FACS 0x00000000BFEF4000 000040
[    0.011945] ACPI: FACS 0x00000000BFEF4000 000040
[    0.011956] ACPI: SSDT 0x00000000BFED17B4 0001AA (v01 LENOVO TP-79    00002270 MSFT 0100000E)
[    0.011969] ACPI: ECDT 0x00000000BFEDEDC5 000052 (v01 LENOVO TP-79    00002270 LNVO 00000001)
[    0.011982] ACPI: TCPA 0x00000000BFEDEE17 000032 (v02 LENOVO TP-79    00002270 LNVO 00000001)
[    0.011995] ACPI: APIC 0x00000000BFEDEE49 000068 (v01 LENOVO TP-79    00002270 LNVO 00000001)
[    0.012008] ACPI: MCFG 0x00000000BFEDEEB1 00003C (v01 LENOVO TP-79    00002270 LNVO 00000001)
[    0.012021] ACPI: HPET 0x00000000BFEDEEED 000038 (v01 LENOVO TP-79    00002270 LNVO 00000001)
[    0.012034] ACPI: BOOT 0x00000000BFEDEFD8 000028 (v01 LENOVO TP-79    00002270  LTP 00000001)
[    0.012047] ACPI: SSDT 0x00000000BFEF2655 00025F (v01 LENOVO TP-79    00002270 INTL 20050513)
[    0.012060] ACPI: SSDT 0x00000000BFEF28B4 0000A6 (v01 LENOVO TP-79    00002270 INTL 20050513)
[    0.012072] ACPI: SSDT 0x00000000BFEF295A 0004F7 (v01 LENOVO TP-79    00002270 INTL 20050513)
[    0.012085] ACPI: SSDT 0x00000000BFEF2E51 0001D8 (v01 LENOVO TP-79    00002270 INTL 20050513)
[    0.012097] ACPI: Reserving FACP table memory at [mem 0xbfed1600-0xbfed16f3]
[    0.012102] ACPI: Reserving DSDT table memory at [mem 0xbfed195e-0xbfededc4]
[    0.012106] ACPI: Reserving FACS table memory at [mem 0xbfef4000-0xbfef403f]
[    0.012111] ACPI: Reserving FACS table memory at [mem 0xbfef4000-0xbfef403f]
[    0.012115] ACPI: Reserving SSDT table memory at [mem 0xbfed17b4-0xbfed195d]
[    0.012119] ACPI: Reserving ECDT table memory at [mem 0xbfededc5-0xbfedee16]
[    0.012123] ACPI: Reserving TCPA table memory at [mem 0xbfedee17-0xbfedee48]
[    0.012128] ACPI: Reserving APIC table memory at [mem 0xbfedee49-0xbfedeeb0]
[    0.012132] ACPI: Reserving MCFG table memory at [mem 0xbfedeeb1-0xbfedeeec]
[    0.012136] ACPI: Reserving HPET table memory at [mem 0xbfedeeed-0xbfedef24]
[    0.012140] ACPI: Reserving BOOT table memory at [mem 0xbfedefd8-0xbfedefff]
[    0.012145] ACPI: Reserving SSDT table memory at [mem 0xbfef2655-0xbfef28b3]
[    0.012149] ACPI: Reserving SSDT table memory at [mem 0xbfef28b4-0xbfef2959]
[    0.012153] ACPI: Reserving SSDT table memory at [mem 0xbfef295a-0xbfef2e50]
[    0.012157] ACPI: Reserving SSDT table memory at [mem 0xbfef2e51-0xbfef3028]
[    0.012202] 2184MB HIGHMEM available.
[    0.012207] 885MB LOWMEM available.
[    0.012210]   mapped low ram: 0 - 375fe000
[    0.012214]   low ram: 0 - 375fe000
[    0.012220] Zone ranges:
[    0.012223]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.012231]   Normal   [mem 0x0000000001000000-0x00000000375fdfff]
[    0.012238]   HighMem  [mem 0x00000000375fe000-0x00000000bfedefff]
[    0.012245] Movable zone start for each node
[    0.012248] Early memory node ranges
[    0.012251]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.012256]   node   0: [mem 0x0000000000100000-0x00000000bfecffff]
[    0.012261] Initmem setup node 0 [mem 0x0000000000001000-0x00000000bfecffff]
[    0.012286] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.012395] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.035681] ACPI: PM-Timer IO Port: 0x1008
[    0.035706] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.035712] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.035751] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.035765] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.035772] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.035784] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.035788] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.035807] CPU topo: Max. logical packages:   1
[    0.035810] CPU topo: Max. logical dies:       1
[    0.035814] CPU topo: Max. dies per package:   1
[    0.035817] CPU topo: Max. threads per core:   1
[    0.035821] CPU topo: Num. cores per package:     2
[    0.035825] CPU topo: Num. threads per package:   2
[    0.035828] CPU topo: Allowing 2 present CPUs plus 0 hotplug CPUs
[    0.035897] [mem 0xc0000000-0xefffffff] available for PCI devices
[    0.035909] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.035935] setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.036358] percpu: Embedded 67 pages/cpu s185868 r0 d88564 u274432
[    0.036444] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.11.0-rc1-P3 root=PARTUUID=f6cdabc7-801d-4572-9de8-9b696dc216cc ro systemd.gpt_auto=no mce=0 slub_debug=FZ netconsole=6666@192.168.2.10/eth0,6666@192.168.2.3/A8:A1:59:16:4F:EA
[    0.036699] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-6.11.0-rc1-P3", will be passed to user space.
[    0.036934] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.037048] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.037100] Built 1 zonelists, mobility grouping on.  Total pages: 786030
[    0.039896] allocated 6297208 bytes of page_ext
[    0.040960] mem auto-init: stack:all(pattern), heap alloc:on, heap free:off
[    0.040971] stackdepot: allocating hash table via alloc_large_system_hash
[    0.040981] stackdepot hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.041365] Initializing HighMem for node 0 (000375fe:000bfed0)
[    1.667893] Initializing Movable for node 0 (00000000:00000000)
[    1.676705] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    1.676731] **********************************************************
[    1.676734] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    1.676737] **                                                      **
[    1.676740] ** This system shows unhashed kernel memory addresses   **
[    1.676744] ** via the console, logs, and other interfaces. This    **
[    1.676747] ** might reduce the security of your system.            **
[    1.676750] **                                                      **
[    1.676752] ** If you see this message and you are not debugging    **
[    1.676755] ** the kernel, report this immediately to your system   **
[    1.676759] ** administrator!                                       **
[    1.676762] **                                                      **
[    1.676765] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    1.676767] **********************************************************
[    1.689342] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    1.690958] Kernel/User page tables isolation: enabled
[    1.691381] trace event string verifier disabled
[    1.692917] Running RCU self tests
[    1.692922] Running RCU synchronous self tests
[    1.692940] rcu: Hierarchical RCU implementation.
[    1.692943] rcu: 	RCU lockdep checking is enabled.
[    1.692948] 	Tracing variant of Tasks RCU enabled.
[    1.692951] rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
[    1.693096] Running RCU synchronous self tests
[    1.693103] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    1.718862] NR_IRQS: 2304, nr_irqs: 440, preallocated irqs: 16
[    1.719598] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    1.719845] kfence: initialized - using 2097152 bytes for 255 objects at 0xf72b3000-0xf74b3000
[    1.723835] Console: colour VGA+ 80x25
[    1.723876] printk: legacy console [tty0] enabled
[    1.750942] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    1.751152] ... MAX_LOCKDEP_SUBCLASSES:  8
[    1.751318] ... MAX_LOCK_DEPTH:          48
[    1.751485] ... MAX_LOCKDEP_KEYS:        8192
[    1.751653] ... CLASSHASH_SIZE:          4096
[    1.751820] ... MAX_LOCKDEP_ENTRIES:     32768
[    1.751989] ... MAX_LOCKDEP_CHAINS:      65536
[    1.752158] ... CHAINHASH_SIZE:          32768
[    1.752325]  memory used by lock dependency info: 3869 kB
[    1.752501]  memory used for stack traces: 2112 kB
[    1.752673]  per task-struct memory footprint: 1344 bytes
[    1.752901] ACPI: Core revision 20240322
[    1.756599] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    1.756877] APIC: Switch to symmetric I/O mode setup
[    1.758328] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.773528] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1a5bce66e4d, max_idle_ns: 440795261458 ns
[    1.774815] Calibrating delay loop (skipped), value calculated using timer frequency.. 3658.64 BogoMIPS (lpj=6095430)
[    1.775064] Disabled fast string operations
[    1.775248] CPU0: Thermal monitoring enabled (TM2)
[    1.775527] Last level iTLB entries: 4KB 128, 2MB 0, 4MB 2
[    1.775708] Last level dTLB entries: 4KB 128, 2MB 0, 4MB 8, 1GB 0
[    1.775895] process: using mwait in idle threads
[    1.776070] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    1.776284] Spectre V2 : Mitigation: Retpolines
[    1.776452] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    1.776661] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    1.776848] L1TF: System has more than MAX_PA/2 memory. L1TF mitigation not effective.
[    1.778337] L1TF: You may make it effective by booting the kernel with mem=2147483648 parameter.
[    1.778550] L1TF: However, doing so will make a part of your RAM unusable.
[    1.778736] L1TF: Reading https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html might help you decide.
[    1.778963] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    1.779145] MMIO Stale Data: Unknown: No mitigations
[    1.779330] x86/fpu: x87 FPU will use FXSAVE
[    1.780892] Freeing SMP alternatives memory: 36K
[    1.781065] pid_max: default: 4096 minimum: 301
[    1.784162] LSM: initializing lsm=capability,yama
[    1.784357] Yama: becoming mindful.
[    1.785657] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    1.785877] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    1.794804] Running RCU synchronous self tests
[    1.798140] Running RCU synchronous self tests
[    1.905676] smpboot: CPU0: Genuine Intel(R) CPU           T2400  @ 1.83GHz (family: 0x6, model: 0xe, stepping: 0x8)
[    1.908129] Running RCU Tasks Trace wait API self tests
[    1.908129] Performance Events: Core events, core PMU driver.
[    1.908129] ... version:                1
[    1.908139] ... bit width:              40
[    1.908307] ... generic registers:      2
[    1.908474] ... value mask:             000000ffffffffff
[    1.908652] ... max period:             000000007fffffff
[    1.908828] ... fixed-purpose events:   0
[    1.908994] ... event mask:             0000000000000003
[    1.909602] signal: max sigframe size: 1440
[    1.910116] rcu: Hierarchical SRCU implementation.
[    1.910291] rcu: 	Max phase no-delay instances is 1000.
[    1.911116] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    1.912430] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    1.913034] smp: Bringing up secondary CPUs ...
[    1.914677] smpboot: x86: Booting SMP configuration:
[    1.914846] .... node  #0, CPUs:      #1
[    0.041813] Disabled fast string operations
[    1.916801] TSC synchronization [CPU#0 -> CPU#1]:
[    1.917311] Measured 521576 cycles TSC warp between CPUs, turning off TSC clock.
[    1.918320] tsc: Marking TSC unstable due to check_tsc_sync_source failed
[    1.918582] smp: Brought up 1 node, 2 CPUs
[    1.918582] smpboot: Total of 2 processors activated (7317.28 BogoMIPS)
[    1.921669] Memory: 3057660K/3144120K available (9735K kernel code, 1496K rwdata, 4176K rodata, 856K init, 8548K bss, 81936K reserved, 0K cma-reserved, 2237256K highmem)
[    1.923114] devtmpfs: initialized
[    1.929141] ACPI: PM: Registering ACPI NVS region [mem 0xbfedf000-0xbfefffff] (135168 bytes)
[    1.930119] Running RCU synchronous self tests
[    1.931499] Running RCU synchronous self tests
[    1.931733] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    1.931733] futex hash table entries: 16 (order: -2, 1024 bytes, linear)
[    1.936991] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    1.942490] thermal_sys: Registered thermal governor 'bang_bang'
[    1.942498] thermal_sys: Registered thermal governor 'step_wise'
[    1.942685] thermal_sys: Registered thermal governor 'user_space'
[    1.943035] cpuidle: using governor menu
[    1.943035] Simple Boot Flag at 0x35 set to 0x1
[    1.943035] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    1.945388] PCI: ECAM [mem 0xf0000000-0xf3ffffff] (base 0xf0000000) for domain 0000 [bus 00-3f]
[    1.945613] PCI: ECAM [mem 0xf0000000-0xf3ffffff] reserved as E820 entry
[    1.945803] PCI: Using ECAM for extended config space
[    1.945979] PCI: Using configuration type 1 for base access
[    1.953166] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    1.953362] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    2.021324] raid6: sse2x2   gen()  3235 MB/s
[    2.077989] raid6: sse2x1   gen()  2863 MB/s
[    2.134655] raid6: sse1x2   gen()  2561 MB/s
[    2.191330] raid6: sse1x1   gen()  2076 MB/s
[    2.191469] raid6: using algorithm sse2x2 gen() 3235 MB/s
[    2.247992] raid6: .... xor() 1781 MB/s, rmw enabled
[    2.248136] raid6: using intx1 recovery algorithm
[    2.250323] ACPI: Added _OSI(Module Device)
[    2.250496] ACPI: Added _OSI(Processor Device)
[    2.250668] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.250841] ACPI: Added _OSI(Processor Aggregator Device)
[    2.264822] Callback from call_rcu_tasks_trace() invoked.
[    2.690118] ACPI: 6 ACPI AML tables successfully acquired and loaded
[    2.703791] ACPI: EC: EC started
[    2.703982] ACPI: EC: interrupt blocked
[    2.708450] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    2.708628] ACPI: EC: Boot ECDT EC used to handle transactions
[    2.736141] ------------[ cut here ]------------
[    2.736413] alloc_tag was not set
[    2.736651] WARNING: CPU: 1 PID: 0 at include/linux/alloc_tag.h:130 alloc_tagging_slab_free_hook+0x17f/0x1ec
[    2.736981] Modules linked in:
[    2.737186] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.0-rc1-P3 #2
[    2.737454] Hardware name: LENOVO 2007F2G/2007F2G, BIOS 79ETE7WW (2.27 ) 03/21/2011
[    2.737668] EIP: alloc_tagging_slab_free_hook+0x17f/0x1ec
[    2.737856] Code: 4f 0f 85 d8 fe ff ff eb 7e c6 05 ca 76 8e d8 01 68 49 10 68 d8 89 cb 89 45 e4 e8 28 ca e0 ff 8b 45 e4 89 d9 8b 55 ec 83 c4 04 <0f> 0b 8b 5c da 04 e9 28 ff ff ff e8 b1 26 72 00 8b 55 ec e9 6b ff
[    2.738138] EAX: 000000a0 EBX: 00000000 ECX: 00000000 EDX: f728bef8
[    2.738400] ESI: c12b9f34 EDI: 00000001 EBP: c12b9f18 ESP: c12b9ef0
[    2.738596] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210296
[    2.738794] CR0: 80050033 CR2: 00000000 CR3: 18a1e000 CR4: 000006f0
[    2.738986] Call Trace:
[    2.739144]  <SOFTIRQ>
[    2.739303]  ? show_regs+0x4e/0x5c
[    2.739476]  ? alloc_tagging_slab_free_hook+0x17f/0x1ec
[    2.739663]  ? __warn+0x88/0x164
[    2.739828]  ? alloc_tagging_slab_free_hook+0x17f/0x1ec
[    2.740014]  ? alloc_tagging_slab_free_hook+0x17f/0x1ec
[    2.740200]  ? report_bug+0xa0/0x11c
[    2.740379]  ? exc_overflow+0x3c/0x3c
[    2.740552]  ? handle_bug+0x30/0x50
[    2.740723]  ? exc_invalid_op+0x17/0x40
[    2.741218]  ? handle_exception+0x101/0x101
[    2.741401]  ? exc_overflow+0x3c/0x3c
[    2.741635]  ? alloc_tagging_slab_free_hook+0x17f/0x1ec
[    2.741824]  ? exc_overflow+0x3c/0x3c
[    2.741994]  ? alloc_tagging_slab_free_hook+0x17f/0x1ec
[    2.742234]  ? lock_acquire+0xbe/0x1e4
[    2.742431]  ? rcu_nocb_unlock_irqrestore+0x3c/0x3c
[    2.742618]  kmem_cache_free+0xeb/0x2d0
[    2.742795]  ? mem_pool_free+0x6f/0x80
[    2.743014]  ? rcu_lock_release+0x18/0x18
[    2.743198]  mem_pool_free+0x6f/0x80
[    2.743371]  ? rcu_lock_release+0x18/0x18
[    2.743548]  free_object_rcu+0x69/0x74
[    2.743720]  ? rcu_lock_release+0x18/0x18
[    2.743895]  rcu_core+0x2cd/0x66c
[    2.744071]  rcu_core_si+0x8/0xc
[    2.744239]  handle_softirqs+0xf6/0x358
[    2.744419]  ? __lock_text_end+0x2/0x2
[    2.744805]  __do_softirq+0xa/0xe
[    2.744976]  do_softirq_own_stack+0x50/0x58
[    2.745152]  </SOFTIRQ>
[    2.745310]  ? sysvec_call_function_single+0x30/0x30
[    2.745495]  __irq_exit_rcu+0x54/0x98
[    2.745668]  irq_exit_rcu+0x8/0x14
[    2.745837]  sysvec_apic_timer_interrupt+0x1f/0x34
[    2.746020]  handle_exception+0x101/0x101
[    2.746195] EIP: mwait_idle+0x53/0x64
[    2.746368] Code: ae 3e 0f ae f0 8d 76 00 89 f0 31 c9 31 d2 0f 01 c8 f7 06 08 00 00 00 75 12 eb 07 0f 00 2d f4 8e 38 d8 31 c0 31 c9 fb 0f 01 c9 <fa> f0 80 66 02 df 5e 5d 31 c0 31 c9 31 d2 c3 cc cc 55 89 e5 53 57
[    2.746691] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
[    2.746883] ESI: c1280040 EDI: c1280040 EBP: c1271f58 ESP: c1271f54
[    2.747495] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00200246
[    2.747698]  ? sysvec_call_function_single+0x30/0x30
[    2.747885]  ? sysvec_call_function_single+0x30/0x30
[    2.748138]  ? mwait_idle+0x53/0x64
[    2.748310]  ? do_idle+0xb7/0x208
[    2.748482]  arch_cpu_idle+0x8/0xc
[    2.748652]  default_idle_call+0x66/0x9c
[    2.748827]  do_idle+0xb7/0x208
[    2.748997]  ? complete+0xc/0x14
[    2.749168]  cpu_startup_entry+0x21/0x24
[    2.749343]  start_secondary+0x9f/0xac
[    2.749515]  startup_32_smp+0x151/0x154
[    2.749697] irq event stamp: 20888
[    2.749864] hardirqs last  enabled at (20896): [<d7aca9fa>] console_unlock+0xbe/0x144
[    2.750087] hardirqs last disabled at (20903): [<d7aca9e1>] console_unlock+0xa5/0x144
[    2.751471] softirqs last  enabled at (15774): [<d7a6396e>] handle_softirqs+0x31e/0x358
[    2.751692] softirqs last disabled at (15799): [<d837edea>] __do_softirq+0xa/0xe
[    2.751908] ---[ end trace 0000000000000000 ]---
[    2.759117] ACPI: Dynamic OEM Table Load:
[    2.759324] ACPI: SSDT 0x00000000C1C4E400 000240 (v01 PmRef  Cpu0Ist  00000100 INTL 20050513)
[    2.770988] ACPI: Dynamic OEM Table Load:
[    2.771191] ACPI: SSDT 0x00000000C1813800 00065A (v01 PmRef  Cpu0Cst  00000100 INTL 20050513)
[    2.797058] ACPI: Dynamic OEM Table Load:
[    2.797259] ACPI: SSDT 0x00000000C11F0700 0000C8 (v01 PmRef  Cpu1Ist  00000100 INTL 20050513)
[    2.805468] ACPI: Dynamic OEM Table Load:
[    2.805665] ACPI: SSDT 0x00000000C13347C0 000085 (v01 PmRef  Cpu1Cst  00000100 INTL 20050513)
[    2.816465] ACPI: Interpreter enabled
[    2.816920] ACPI: PM: (supports S0 S3 S5)
[    2.817100] ACPI: Using IOAPIC for interrupt routing
[    2.817813] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    2.818034] PCI: Using E820 reservations for host bridge windows
[    2.823222] ACPI: Enabled 4 GPEs in block 00 to 1F
[    2.994042] ACPI: \_SB_.PCI0.LPC_.EC__.PUBS: New power resource
[    3.090182] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    3.094900] ACPI: PCI: Interrupt link LNKB configured for IRQ 11
[    3.099536] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    3.104176] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    3.108823] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
[    3.113451] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
[    3.118082] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    3.122941] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    3.125381] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    3.125614] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    3.132746] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    3.145848] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability]
[    3.146050] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    3.146313] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf0000000-0xf3ffffff] for domain 0000 [bus 00-3f] only partially covers this bridge
[    3.148687] PCI host bridge to bus 0000:00
[    3.149023] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    3.149232] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    3.149439] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    3.149672] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dbfff window]
[    3.149895] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    3.150118] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.150447] pci 0000:00:00.0: [8086:27a0] type 00 class 0x060000 conventional PCI endpoint
[    3.151745] pci 0000:00:01.0: [8086:27a1] type 01 class 0x060400 PCIe Root Port
[    3.151995] pci 0000:00:01.0: PCI bridge to [bus 01]
[    3.152181] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    3.152374] pci 0000:00:01.0:   bridge window [mem 0xee100000-0xee1fffff]
[    3.152583] pci 0000:00:01.0:   bridge window [mem 0xd8000000-0xdfffffff 64bit pref]
[    3.152967] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    3.155861] pci 0000:00:1b.0: [8086:27d8] type 00 class 0x040300 PCIe Root Complex Integrated Endpoint
[    3.156129] pci 0000:00:1b.0: BAR 0 [mem 0xee400000-0xee403fff 64bit]
[    3.156602] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    3.159109] pci 0000:00:1c.0: [8086:27d0] type 01 class 0x060400 PCIe Root Port
[    3.159381] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    3.159569] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    3.159764] pci 0000:00:1c.0:   bridge window [mem 0xee000000-0xee0fffff]
[    3.160210] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    3.162798] pci 0000:00:1c.1: [8086:27d2] type 01 class 0x060400 PCIe Root Port
[    3.163070] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    3.163258] pci 0000:00:1c.1:   bridge window [io  0x4000-0x5fff]
[    3.163453] pci 0000:00:1c.1:   bridge window [mem 0xec000000-0xedffffff]
[    3.163665] pci 0000:00:1c.1:   bridge window [mem 0xe4000000-0xe40fffff 64bit pref]
[    3.164095] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    3.166607] pci 0000:00:1c.2: [8086:27d4] type 01 class 0x060400 PCIe Root Port
[    3.166879] pci 0000:00:1c.2: PCI bridge to [bus 04-0b]
[    3.167069] pci 0000:00:1c.2:   bridge window [io  0x6000-0x7fff]
[    3.167265] pci 0000:00:1c.2:   bridge window [mem 0xe8000000-0xe9ffffff]
[    3.167480] pci 0000:00:1c.2:   bridge window [mem 0xe4100000-0xe41fffff 64bit pref]
[    3.167909] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    3.170524] pci 0000:00:1c.3: [8086:27d6] type 01 class 0x060400 PCIe Root Port
[    3.170796] pci 0000:00:1c.3: PCI bridge to [bus 0c-13]
[    3.170986] pci 0000:00:1c.3:   bridge window [io  0x8000-0x9fff]
[    3.171181] pci 0000:00:1c.3:   bridge window [mem 0xea000000-0xebffffff]
[    3.171396] pci 0000:00:1c.3:   bridge window [mem 0xe4200000-0xe42fffff 64bit pref]
[    3.171695] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    3.174203] pci 0000:00:1d.0: [8086:27c8] type 00 class 0x0c0300 conventional PCI endpoint
[    3.174508] pci 0000:00:1d.0: BAR 4 [io  0x1800-0x181f]
[    3.177044] pci 0000:00:1d.1: [8086:27c9] type 00 class 0x0c0300 conventional PCI endpoint
[    3.177349] pci 0000:00:1d.1: BAR 4 [io  0x1820-0x183f]
[    3.179906] pci 0000:00:1d.2: [8086:27ca] type 00 class 0x0c0300 conventional PCI endpoint
[    3.180210] pci 0000:00:1d.2: BAR 4 [io  0x1840-0x185f]
[    3.182716] pci 0000:00:1d.3: [8086:27cb] type 00 class 0x0c0300 conventional PCI endpoint
[    3.183021] pci 0000:00:1d.3: BAR 4 [io  0x1860-0x187f]
[    3.185359] pci 0000:00:1d.7: [8086:27cc] type 00 class 0x0c0320 conventional PCI endpoint
[    3.185611] pci 0000:00:1d.7: BAR 0 [mem 0xee404000-0xee4043ff]
[    3.186015] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    3.188419] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401 conventional PCI bridge
[    3.188694] pci 0000:00:1e.0: PCI bridge to [bus 15-18] (subtractive decode)
[    3.188901] pci 0000:00:1e.0:   bridge window [io  0xa000-0xdfff]
[    3.189096] pci 0000:00:1e.0:   bridge window [mem 0xe4300000-0xe7ffffff]
[    3.189312] pci 0000:00:1e.0:   bridge window [mem 0xe0000000-0xe3ffffff 64bit pref]
[    3.191924] pci 0000:00:1f.0: [8086:27b9] type 00 class 0x060100 conventional PCI endpoint
[    3.192364] pci 0000:00:1f.0: quirk: [io  0x1000-0x107f] claimed by ICH6 ACPI/GPIO/TCO
[    3.192588] pci 0000:00:1f.0: quirk: [io  0x1180-0x11bf] claimed by ICH6 GPIO
[    3.192791] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 1600 (mask 007f)
[    3.193007] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 15e0 (mask 000f)
[    3.193223] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 1680 (mask 001f)
[    3.196040] pci 0000:00:1f.1: [8086:27df] type 00 class 0x01018a conventional PCI endpoint
[    3.196289] pci 0000:00:1f.1: BAR 0 [io  0x0000-0x0007]
[    3.196488] pci 0000:00:1f.1: BAR 1 [io  0x0000-0x0003]
[    3.196686] pci 0000:00:1f.1: BAR 2 [io  0x0000-0x0007]
[    3.196884] pci 0000:00:1f.1: BAR 3 [io  0x0000-0x0003]
[    3.197081] pci 0000:00:1f.1: BAR 4 [io  0x1880-0x188f]
[    3.197298] pci 0000:00:1f.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
[    3.197495] pci 0000:00:1f.1: BAR 1 [io  0x03f6]: legacy IDE quirk
[    3.197687] pci 0000:00:1f.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
[    3.197883] pci 0000:00:1f.1: BAR 3 [io  0x0376]: legacy IDE quirk
[    3.200171] pci 0000:00:1f.2: [8086:27c5] type 00 class 0x010601 conventional PCI endpoint
[    3.200421] pci 0000:00:1f.2: BAR 0 [io  0x18c8-0x18cf]
[    3.200620] pci 0000:00:1f.2: BAR 1 [io  0x18ac-0x18af]
[    3.200818] pci 0000:00:1f.2: BAR 2 [io  0x18c0-0x18c7]
[    3.201015] pci 0000:00:1f.2: BAR 3 [io  0x18a8-0x18ab]
[    3.201213] pci 0000:00:1f.2: BAR 4 [io  0x18b0-0x18bf]
[    3.201411] pci 0000:00:1f.2: BAR 5 [mem 0xee404400-0xee4047ff]
[    3.201618] pci 0000:00:1f.2: PME# supported from D3hot
[    3.203986] pci 0000:00:1f.3: [8086:27da] type 00 class 0x0c0500 conventional PCI endpoint
[    3.204309] pci 0000:00:1f.3: BAR 4 [io  0x18e0-0x18ff]
[    3.207237] pci 0000:01:00.0: [1002:7149] type 00 class 0x030000 PCIe Legacy Endpoint
[    3.207531] pci 0000:01:00.0: BAR 0 [mem 0xd8000000-0xdfffffff pref]
[    3.207764] pci 0000:01:00.0: BAR 1 [io  0x2000-0x20ff]
[    3.207987] pci 0000:01:00.0: BAR 2 [mem 0xee100000-0xee10ffff]
[    3.208300] pci 0000:01:00.0: ROM [mem 0x00000000-0x0001ffff pref]
[    3.208521] pci 0000:01:00.0: enabling Extended Tags
[    3.208904] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    3.209333] pci 0000:01:00.0: supports D1 D2
[    4.214820] pci 0000:00:01.0: ASPM: Could not configure common clock
[    4.215118] pci 0000:00:01.0: PCI bridge to [bus 01]
[    4.215955] pci 0000:02:00.0: [8086:109a] type 00 class 0x020000 PCIe Endpoint
[    4.216278] pci 0000:02:00.0: BAR 0 [mem 0xee000000-0xee01ffff]
[    4.216579] pci 0000:02:00.0: BAR 2 [io  0x3000-0x301f]
[    4.217311] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    4.218852] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    4.219622] pci 0000:03:00.0: [8086:4227] type 00 class 0x028000 PCIe Legacy Endpoint
[    4.219958] pci 0000:03:00.0: BAR 0 [mem 0xedf00000-0xedf00fff]
[    4.220906] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    4.222453] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    4.223099] pci 0000:00:1c.2: PCI bridge to [bus 04-0b]
[    4.223676] pci 0000:00:1c.3: PCI bridge to [bus 0c-13]
[    4.223936] pci_bus 0000:15: extended config space not accessible
[    4.224537] pci 0000:15:00.0: [104c:ac56] type 02 class 0x060700 CardBus bridge
[    4.224839] pci 0000:15:00.0: BAR 1 [mem 0xe4300000-0xe4300fff]
[    4.225223] pci 0000:15:00.0: supports D1 D2
[    4.225399] pci 0000:15:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    4.228788] pci 0000:00:1e.0: PCI bridge to [bus 15-18] (subtractive decode)
[    4.229017] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    4.229248] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    4.229479] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    4.229716] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dbfff window] (subtractive decode)
[    4.229953] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xfebfffff window] (subtractive decode)
[    4.230256] pci_bus 0000:16: extended config space not accessible
[    4.230833] pci_bus 0000:16: busn_res: [bus 16-18] end is updated to 17
[    4.267240] ACPI: EC: interrupt unblocked
[    4.267439] ACPI: EC: event unblocked
[    4.267611] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    4.267800] ACPI: EC: GPE=0x1c
[    4.267973] ACPI: \_SB_.PCI0.LPC_.EC__: Boot ECDT EC initialization complete
[    4.268154] ACPI: \_SB_.PCI0.LPC_.EC__: EC: Used to handle transactions and events
[    4.272581] SCSI subsystem initialized
[    4.277543] PCI: Using ACPI for IRQ routing
[    4.282065] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    4.282065] pci 0000:01:00.0: vgaarb: bridge control possible
[    4.282065] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    4.282251] vgaarb: loaded
[    4.282630] hpet: 3 channels of 0 reserved for per-cpu timers
[    4.283213] clocksource: Switched to clocksource hpet
[    4.290910] pnp: PnP ACPI init
[    4.308246] pnp 00:00: disabling [mem 0x000c0000-0x000c3fff] because it overlaps 0000:01:00.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    4.308532] pnp 00:00: disabling [mem 0x000c4000-0x000c7fff] because it overlaps 0000:01:00.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    4.308774] pnp 00:00: disabling [mem 0x000c8000-0x000cbfff] because it overlaps 0000:01:00.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    4.309015] pnp 00:00: disabling [mem 0x000cc000-0x000cffff] because it overlaps 0000:01:00.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    4.309255] pnp 00:00: disabling [mem 0x000dc000-0x000dffff] because it overlaps 0000:01:00.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    4.310053] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    4.310283] system 00:00: [mem 0x000e0000-0x000e3fff] could not be reserved
[    4.310509] system 00:00: [mem 0x000e4000-0x000e7fff] could not be reserved
[    4.310734] system 00:00: [mem 0x000e8000-0x000ebfff] could not be reserved
[    4.310960] system 00:00: [mem 0x000ec000-0x000effff] could not be reserved
[    4.311185] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    4.311409] system 00:00: [mem 0x00100000-0xbfffffff] could not be reserved
[    4.311635] system 00:00: [mem 0xfec00000-0xffffffff] could not be reserved
[    4.315598] system 00:01: [io  0x164e-0x164f] has been reserved
[    4.315811] system 00:01: [io  0x1000-0x107f] has been reserved
[    4.316019] system 00:01: [io  0x1180-0x11bf] has been reserved
[    4.316228] system 00:01: [io  0x0800-0x080f] has been reserved
[    4.316436] system 00:01: [io  0x15e0-0x15ef] has been reserved
[    4.316653] system 00:01: [io  0x1600-0x165f] could not be reserved
[    4.316899] system 00:01: [mem 0xf0000000-0xf3ffffff] has been reserved
[    4.317117] system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    4.317334] system 00:01: [mem 0xfed14000-0xfed17fff] has been reserved
[    4.317550] system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
[    4.317767] system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
[    4.317984] system 00:01: [mem 0xfed40000-0xfed40fff] has been reserved
[    4.340250] pnp: PnP ACPI: found 5 devices
[    4.409676] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    4.410958] NET: Registered PF_INET protocol family
[    4.411483] IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    4.415836] tcp_listen_portaddr_hash hash table entries: 512 (order: 2, 20480 bytes, linear)
[    4.416195] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    4.416935] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    4.417710] TCP bind hash table entries: 8192 (order: 7, 655360 bytes, linear)
[    4.419363] TCP: Hash tables configured (established 8192 bind 8192)
[    4.419846] UDP hash table entries: 512 (order: 3, 49152 bytes, linear)
[    4.420176] UDP-Lite hash table entries: 512 (order: 3, 49152 bytes, linear)
[    4.421313] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    4.421778] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    4.422298] pci 0000:00:1c.0: bridge window [mem 0xc0000000-0xc01fffff 64bit pref]: assigned
[    4.422530] pci 0000:00:01.0: PCI bridge to [bus 01]
[    4.422710] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    4.422900] pci 0000:00:01.0:   bridge window [mem 0xee100000-0xee1fffff]
[    4.423090] pci 0000:00:01.0:   bridge window [mem 0xd8000000-0xdfffffff 64bit pref]
[    4.423304] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    4.423482] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    4.423674] pci 0000:00:1c.0:   bridge window [mem 0xee000000-0xee0fffff]
[    4.423869] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc01fffff 64bit pref]
[    4.424087] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    4.424265] pci 0000:00:1c.1:   bridge window [io  0x4000-0x5fff]
[    4.424457] pci 0000:00:1c.1:   bridge window [mem 0xec000000-0xedffffff]
[    4.424652] pci 0000:00:1c.1:   bridge window [mem 0xe4000000-0xe40fffff 64bit pref]
[    4.424868] pci 0000:00:1c.2: PCI bridge to [bus 04-0b]
[    4.425047] pci 0000:00:1c.2:   bridge window [io  0x6000-0x7fff]
[    4.425269] pci 0000:00:1c.2:   bridge window [mem 0xe8000000-0xe9ffffff]
[    4.425466] pci 0000:00:1c.2:   bridge window [mem 0xe4100000-0xe41fffff 64bit pref]
[    4.425682] pci 0000:00:1c.3: PCI bridge to [bus 0c-13]
[    4.425862] pci 0000:00:1c.3:   bridge window [io  0x8000-0x9fff]
[    4.426054] pci 0000:00:1c.3:   bridge window [mem 0xea000000-0xebffffff]
[    4.426250] pci 0000:00:1c.3:   bridge window [mem 0xe4200000-0xe42fffff 64bit pref]
[    4.426535] pci 0000:15:00.0: CardBus bridge window 1 [mem 0xe0000000-0xe3ffffff pref]: assigned
[    4.426756] pci 0000:15:00.0: unknown [mem 0xc4000000-0xc7ffffff]: assigned
[    4.426949] pci 0000:15:00.0: CardBus bridge window 1 [io  0xa000-0xa0ff]: assigned
[    4.427158] pci 0000:15:00.0: CardBus bridge window 0 [io  0xa400-0xa4ff]: assigned
[    4.427407] pci 0000:15:00.0: CardBus bridge to [bus 16-17]
[    4.427589] pci 0000:15:00.0:   bridge window [io  0xa000-0xa0ff]
[    4.427780] pci 0000:15:00.0:   bridge window [io  0xa400-0xa4ff]
[    4.427970] pci 0000:15:00.0:   bridge window [mem 0xe0000000-0xe3ffffff pref]
[    4.428182] pci 0000:15:00.0:   bridge window [mem 0xc4000000-0xc7ffffff]
[    4.428378] pci 0000:00:1e.0: PCI bridge to [bus 15-18]
[    4.428589] pci 0000:00:1e.0:   bridge window [io  0xa000-0xdfff]
[    4.428782] pci 0000:00:1e.0:   bridge window [mem 0xe4300000-0xe7ffffff]
[    4.428977] pci 0000:00:1e.0:   bridge window [mem 0xe0000000-0xe3ffffff 64bit pref]
[    4.429194] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    4.429381] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    4.429568] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    4.429760] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dbfff window]
[    4.429952] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xfebfffff window]
[    4.430145] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    4.430326] pci_bus 0000:01: resource 1 [mem 0xee100000-0xee1fffff]
[    4.430513] pci_bus 0000:01: resource 2 [mem 0xd8000000-0xdfffffff 64bit pref]
[    4.430722] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    4.430903] pci_bus 0000:02: resource 1 [mem 0xee000000-0xee0fffff]
[    4.431089] pci_bus 0000:02: resource 2 [mem 0xc0000000-0xc01fffff 64bit pref]
[    4.431297] pci_bus 0000:03: resource 0 [io  0x4000-0x5fff]
[    4.431479] pci_bus 0000:03: resource 1 [mem 0xec000000-0xedffffff]
[    4.431666] pci_bus 0000:03: resource 2 [mem 0xe4000000-0xe40fffff 64bit pref]
[    4.431891] pci_bus 0000:04: resource 0 [io  0x6000-0x7fff]
[    4.432073] pci_bus 0000:04: resource 1 [mem 0xe8000000-0xe9ffffff]
[    4.432260] pci_bus 0000:04: resource 2 [mem 0xe4100000-0xe41fffff 64bit pref]
[    4.432468] pci_bus 0000:0c: resource 0 [io  0x8000-0x9fff]
[    4.432650] pci_bus 0000:0c: resource 1 [mem 0xea000000-0xebffffff]
[    4.432837] pci_bus 0000:0c: resource 2 [mem 0xe4200000-0xe42fffff 64bit pref]
[    4.433046] pci_bus 0000:15: resource 0 [io  0xa000-0xdfff]
[    4.433227] pci_bus 0000:15: resource 1 [mem 0xe4300000-0xe7ffffff]
[    4.433414] pci_bus 0000:15: resource 2 [mem 0xe0000000-0xe3ffffff 64bit pref]
[    4.433622] pci_bus 0000:15: resource 4 [io  0x0000-0x0cf7 window]
[    4.433808] pci_bus 0000:15: resource 5 [io  0x0d00-0xffff window]
[    4.433995] pci_bus 0000:15: resource 6 [mem 0x000a0000-0x000bffff window]
[    4.434183] pci_bus 0000:15: resource 7 [mem 0x000d0000-0x000dbfff window]
[    4.434374] pci_bus 0000:15: resource 8 [mem 0xc0000000-0xfebfffff window]
[    4.434567] pci_bus 0000:16: resource 0 [io  0xa000-0xa0ff]
[    4.434748] pci_bus 0000:16: resource 1 [io  0xa400-0xa4ff]
[    4.434925] pci_bus 0000:16: resource 2 [mem 0xe0000000-0xe3ffffff pref]
[    4.435116] pci_bus 0000:16: resource 3 [mem 0xc4000000-0xc7ffffff]
[    4.451396] pci 0000:15:00.0: CLS mismatch (64 != 32), using 64 bytes
[    4.452688] Unpacking initramfs...
[    4.457341] Initialise system trusted keyrings
[    4.458158] workingset: timestamp_bits=14 max_order=20 bucket_order=6
[    4.474558] 9p: Installing v9fs 9p2000 file system support
[    4.476032] NET: Registered PF_ALG protocol family
[    4.476288] xor: measuring software checksum speed
[    4.478761]    pIII_sse        :  4875 MB/sec
[    4.480796]    prefetch64-sse  :  5337 MB/sec
[    4.480972] xor: using function: prefetch64-sse (5337 MB/sec)
[    4.481225] Key type asymmetric registered
[    4.481454] Asymmetric key parser 'x509' registered
[    4.533037] Freeing initrd memory: 14552K
[    4.540428] bounce: pool size: 64 pages
[    4.541038] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    4.541727] io scheduler bfq registered
[    4.547060] atomic64_test: passed for i586+ platform with CX8 and with SSE
[    4.550861] pcieport 0000:00:01.0: PME: Signaling with IRQ 24
[    4.554319] pcieport 0000:00:1c.0: PME: Signaling with IRQ 25
[    4.557402] pcieport 0000:00:1c.1: PME: Signaling with IRQ 26
[    4.560396] pcieport 0000:00:1c.2: PME: Signaling with IRQ 27
[    4.563595] pcieport 0000:00:1c.3: PME: Signaling with IRQ 28
[    4.567847] ACPI: \_PR_.CPU0: Found 3 idle states
[    4.571790] ACPI: \_PR_.CPU1: Found 3 idle states
[    4.573193] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    4.587125] ACPI: bus type drm_connector registered
[    4.599034] ahci 0000:00:1f.2: AHCI vers 0001.0100, 32 command slots, 1.5 Gbps, SATA mode
[    4.599262] ahci 0000:00:1f.2: 1/4 ports implemented (port mask 0x1)
[    4.599455] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
[    4.608730] scsi host0: ahci
[    4.611745] scsi host1: ahci
[    4.614259] scsi host2: ahci
[    4.616786] scsi host3: ahci
[    4.618352] ata1: SATA max UDMA/133 abar m1024@0xee404400 port 0xee404500 irq 29 lpm-pol 0
[    4.618861] ata2: DUMMY
[    4.619019] ata3: DUMMY
[    4.619171] ata4: DUMMY
[    4.633757] scsi host4: ata_piix
[    4.635893] scsi host5: ata_piix
[    4.636948] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x1880 irq 14 lpm-pol 0
[    4.637165] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1888 irq 15 lpm-pol 0
[    4.637986] e1000e: Intel(R) PRO/1000 Network Driver
[    4.638164] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.638793] e1000e 0000:02:00.0: Disabling ASPM  L1
[    4.638977] e1000e 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
[    4.640975] e1000e 0000:02:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    4.739664] e1000e 0000:02:00.0 eth0: (PCI Express:2.5GT/s:Width x1) 00:16:41:54:74:0d
[    4.739889] e1000e 0000:02:00.0 eth0: Intel(R) PRO/1000 Network Connection
[    4.740161] e1000e 0000:02:00.0 eth0: MAC: 2, PHY: 2, PBA No: 005301-003
[    4.740839] pci 0000:00:1e.0: enabling device (0005 -> 0007)
[    4.742062] yenta_cardbus 0000:15:00.0: CardBus bridge found [17aa:2012]
[    4.794794] ata5.00: ATAPI: MATSHITADVD-RAM UJ-852, RB01, max UDMA/33
[    4.931989] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.955275] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
[    4.955496] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    4.984076] ata1.00: ATA-10: ST500LM034-2GH17A, 1001, max UDMA/133
[    5.082234] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    5.116829] ata1.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK) filtered out
[    5.117050] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filtered out
[    5.154037] ata1.00: configured for UDMA/133
[    5.156038] scsi 0:0:0:0: Direct-Access     ATA      ST500LM034-2GH17 1001 PQ: 0 ANSI: 5
[    5.162479] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    5.162766] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    5.163130] sd 0:0:0:0: [sda] Write Protect is off
[    5.163516] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.164015] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    5.164299] scsi 4:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ-852   RB01 PQ: 0 ANSI: 5
[    5.197124] sr 4:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    5.197421] cdrom: Uniform CD-ROM driver Revision: 3.20
[    5.245342]  sda: sda1 sda2 sda3 sda4 sda5 sda6
[    5.250043] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.383686] yenta_cardbus 0000:15:00.0: ISA IRQ mask 0x0cf8, PCI irq 16
[    5.383887] yenta_cardbus 0000:15:00.0: Socket status: 30000010
[    5.384190] yenta_cardbus 0000:15:00.0: pcmcia: parent PCI bridge window: [io  0xa000-0xdfff]
[    5.384458] yenta_cardbus 0000:15:00.0: pcmcia: parent PCI bridge window: [mem 0xe4300000-0xe7ffffff]
[    5.384707] pcmcia_socket pcmcia_socket0: cs: memory probe 0xe4300000-0xe7ffffff:
[    5.384999]  excluding 0xe4300000-0xe46cffff
[    5.385701] yenta_cardbus 0000:15:00.0: pcmcia: parent PCI bridge window: [mem 0xe0000000-0xe3ffffff 64bit pref]
[    5.385957] pcmcia_socket pcmcia_socket0: cs: memory probe 0xe0000000-0xe3ffffff:
[    5.386610]  excluding 0xe0000000-0xe3ffffff
[    5.388785] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    5.396105] serio: i8042 KBD port at 0x60,0x64 irq 1
[    5.396380] serio: i8042 AUX port at 0x60,0x64 irq 12
[    5.399480] rtc_cmos 00:02: RTC can wake from S4
[    5.402856] rtc_cmos 00:02: registered as rtc0
[    5.403535] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    5.404000] i2c_dev: i2c /dev entries driver
[    5.406792] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    5.407508] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    5.420030] NET: Registered PF_INET6 protocol family
[    5.424353] Segment Routing with IPv6
[    5.424680] In-situ OAM (IOAM) with IPv6
[    5.425814] 9pnet: Installing 9P2000 support
[    5.428553] microcode: Current revision: 0x00000039
[    5.431627] IPI shorthand broadcast: enabled
[    5.473130] registered taskstats version 1
[    5.474195] Loading compiled-in X.509 certificates
[    5.602380] zswap: loaded using pool zstd/zsmalloc
[    5.603626] kmemleak: Kernel memory leak detector initialized (mem pool available: 15729)
[    5.603637] kmemleak: Automatic memory scanning thread started
[    5.603844] page_owner is disabled
[    5.622587] Btrfs loaded, zoned=no, fsverity=no
[    6.107286] psmouse serio1: synaptics: Touchpad model: 1, fw: 6.2, id: 0x81a0b1, caps: 0xa04793/0x300000/0x0/0x0, board id: 0, fw id: 67352
[    6.107695] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
[    6.151364] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input2
[    6.318530] pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
[    6.318777] pcmcia_socket pcmcia_socket0: cs: memory probe 0xe46d0000-0xe7ffffff:
[    6.324624]  excluding 0xe4df4000-0xe5185fff 0xe5fce000-0xe635ffff 0xe6e16000-0xe71a7fff 0xe7ff0000-0xe8381fff
[    6.343724] pcmcia (null): pcmcia: registering new device pcmcia(null) (IRQ: 16)
[    6.345175] serial_cs 0.0: trying to set up [0x0279:0x950b] (pfc: 0, multi: 2, quirk: d84237e8)
[    6.394869] 0.0: ttyS4 at I/O 0xa108 (irq = 16, base_baud = 115200) is a 16450
[    7.367872] netpoll: netconsole: local port 6666
[    7.368056] netpoll: netconsole: local IPv4 address 192.168.2.10
[    7.368242] netpoll: netconsole: interface 'eth0'
[    7.368414] netpoll: netconsole: remote port 6666
[    7.368622] netpoll: netconsole: remote IPv4 address 192.168.2.3
[    7.368807] netpoll: netconsole: remote ethernet address a8:a1:59:16:4f:ea
[    7.368999] netpoll: netconsole: device eth0 not up yet, forcing it
[    7.694914] input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/serio2/input/input3
[   10.516188] e1000e 0000:02:00.0 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   10.522696] printk: legacy console [netcon0] enabled
[   10.541160] netconsole: network logging started
[   10.543201] Unstable clock detected, switching default tracing clock to "global"
[   10.543201] If you want to keep using the local clock, then add:
[   10.543201]   "trace_clock=local"
[   10.543201] on the kernel command line
[   10.544310] clk: Disabling unused clocks
[   10.685610] BTRFS: device label bisect_i686 devid 1 transid 71992 /dev/root (8:4) scanned by swapper/0 (1)
[   10.688372] BTRFS info (device sda4): first mount of filesystem 44232644-019b-40cc-8226-8bd9b211d705
[   10.688820] BTRFS info (device sda4): using xxhash64 (xxhash64-generic) checksum algorithm
[   10.689125] BTRFS info (device sda4): disk space caching is enabled
[   10.929280] VFS: Mounted root (btrfs filesystem) readonly on device 0:18.
[   10.941305] devtmpfs: mounted
[   10.943045] Freeing unused kernel image (initmem) memory: 856K
[   10.943562] Write protecting kernel text and read-only data: 13912k
[   10.943774] NX-protecting the kernel data: 8696k
[   10.945809] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   10.946096] rodata_test: all tests were successful
[   10.946561] x86/mm: Checking user space page tables
[   10.946901] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   10.947131] Run /sbin/init as init process
[   12.454573] systemd[1]: systemd 255 running in system mode (+PAM -AUDIT -SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS -OPENSSL +ACL +BLKID -CURL -ELFUTILS -FIDO2 +IDN2 -IDN -IPTC +KMOD -LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE -TPM2 -BZIP2 +LZ4 -XZ -ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
[   12.455069] systemd[1]: Detected architecture x86.
[   12.512433] systemd[1]: Hostname set to <hakla01>.
[   14.461306] systemd[1]: Queued start job for default target Graphical Interface.
[   14.504948] systemd[1]: Created slice Slice /system/getty.
[   14.512957] systemd[1]: Created slice Slice /system/modprobe.
[   14.519041] systemd[1]: Created slice Slice /system/vncserver.
[   14.524562] systemd[1]: Created slice User and Session Slice.
[   14.527394] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   14.529093] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   14.532886] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   14.534077] systemd[1]: Expecting device /dev/disk/by-label/new_tmp...
[   14.535015] systemd[1]: Expecting device /dev/disk/by-label/swap...
[   14.536067] systemd[1]: Reached target Path Units.
[   14.537007] systemd[1]: Reached target Remote File Systems.
[   14.537955] systemd[1]: Reached target Slice Units.
[   14.545471] systemd[1]: Listening on Process Core Dump Socket.
[   14.548194] systemd[1]: Listening on Journal Socket (/dev/log).
[   14.550760] systemd[1]: Listening on Journal Socket.
[   14.554608] systemd[1]: Listening on udev Control Socket.
[   14.556871] systemd[1]: Listening on udev Kernel Socket.
[   14.605841] systemd[1]: Mounting Huge Pages File System...
[   14.615810] systemd[1]: Mounting POSIX Message Queue File System...
[   14.630813] systemd[1]: Mounting Kernel Debug File System...
[   14.662671] systemd[1]: Mounting Kernel Trace File System...
[   14.689921] systemd[1]: Starting Create List of Static Device Nodes...
[   14.717229] systemd[1]: Starting Load Kernel Module configfs...
[   14.752018] systemd[1]: Starting Load Kernel Module dm_mod...
[   14.779348] systemd[1]: Starting Load Kernel Module drm...
[   14.810527] systemd[1]: Starting Load Kernel Module fuse...
[   14.835134] systemd[1]: Starting Load Kernel Module loop...
[   14.859181] systemd[1]: Starting File System Check on Root Device...
[   14.915743] systemd[1]: Starting Journal Service...
[   14.962822] device-mapper: uevent: version 1.0.3
[   14.965409] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[   15.020250] systemd[1]: Starting Load Kernel Modules...
[   15.041048] fuse: init (API version 7.40)
[   15.048984] loop: module loaded
[   15.062911] systemd[1]: Starting Coldplug All udev Devices...
[   15.093100] systemd-journald[126]: Collecting audit messages is disabled.
[   15.110191] systemd[1]: Mounted Huge Pages File System.
[   15.112712] systemd[1]: Mounted POSIX Message Queue File System.
[   15.114900] systemd[1]: Mounted Kernel Debug File System.
[   15.117718] systemd[1]: Mounted Kernel Trace File System.
[   15.124096] systemd[1]: Finished Create List of Static Device Nodes.
[   15.130623] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[   15.133452] systemd[1]: Finished Load Kernel Module configfs.
[   15.137778] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[   15.140795] systemd[1]: Finished Load Kernel Module dm_mod.
[   15.146918] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   15.156065] systemd[1]: Finished Load Kernel Module drm.
[   15.162346] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   15.164485] systemd[1]: Finished Load Kernel Module fuse.
[   15.170875] systemd[1]: modprobe@loop.service: Deactivated successfully.
[   15.173127] systemd[1]: Finished Load Kernel Module loop.
[   15.182088] systemd[1]: Finished File System Check on Root Device.
[   15.231463] Asymmetric key parser 'pkcs8' registered
[   15.232102] systemd[1]: Mounting FUSE Control File System...
[   15.279115] systemd[1]: Mounting Kernel Configuration File System...
[   15.323614] systemd[1]: Starting Remount Root and Kernel File Systems...
[   15.329506] systemd[1]: Repartition Root Disk was skipped because no trigger condition checks were met.
[   15.409399] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[   15.481303] systemd[1]: Finished Load Kernel Modules.
[   15.494128] systemd[1]: Mounted FUSE Control File System.
[   15.506982] systemd[1]: Mounted Kernel Configuration File System.
[   15.559435] systemd[1]: Starting Apply Kernel Variables...
[   15.577841] BTRFS info (device sda4 state M): use zstd compression, level 1
[   15.588552] random: crng init done
[   15.653194] systemd[1]: Finished Remount Root and Kernel File Systems.
[   15.676865] systemd[1]: Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
[   15.722820] systemd[1]: Starting Load/Save OS Random Seed...
[   15.820968] systemd[1]: Finished Apply Kernel Variables.
[   16.128024] systemd[1]: Started Journal Service.
[   16.365937] systemd-journald[126]: Received client request to flush runtime journal.
[   16.911865] systemd-journald[126]: /var/log/journal/99afd334b5564c88beb2143d13a85751/system.journal: Journal file uses a different sequence number ID, rotating.
[   16.912214] systemd-journald[126]: Rotating system journal.
[   19.881928] e1000e 0000:02:00.0 enp2s0: renamed from eth0 (while UP)
[   20.341173] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input4
[   20.349852] ACPI: \_PR_.CPU0: Found 3 idle states
[   20.405810] ACPI: button: Lid Switch [LID]
[   20.422780] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input5
[   20.432814] ACPI: button: Sleep Button [SLPB]
[   20.436262] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input6
[   20.442613] ACPI: \_PR_.CPU1: Found 3 idle states
[   20.462919] ACPI: button: Power Button [PWRF]
[   20.702166] ACPI: AC: AC Adapter [AC] (on-line)
[   20.712735] ACPI: video: Video Device [VID1] (multi-head: yes  rom: no  post: no)
[   20.742593] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:05/LNXVIDEO:01/input/input7
[   20.763396] ACPI: battery: Slot [BAT0] (battery present)
[   20.773864] thermal LNXTHERM:00: registered as thermal_zone0
[   20.774171] ACPI: thermal: Thermal Zone [THM0] (68 C)
[   20.834560] thermal LNXTHERM:01: registered as thermal_zone1
[   20.834848] ACPI: thermal: Thermal Zone [THM1] (75 C)
[   20.844547] ACPI: bus type USB registered
[   20.854667] usbcore: registered new interface driver usbfs
[   20.925881] usbcore: registered new interface driver hub
[   20.941068] usbcore: registered new device driver usb
[   21.034945] Non-volatile memory driver v1.3
[   21.043528] ehci-pci 0000:00:1d.7: EHCI Host Controller
[   21.044449] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   21.044850] ehci-pci 0000:00:1d.7: debug port 1
[   21.055458] ehci-pci 0000:00:1d.7: irq 19, io mem 0xee404000
[   21.068651] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[   21.092725] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
[   21.094198] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   21.094503] usb usb1: Product: EHCI Host Controller
[   21.094757] usb usb1: Manufacturer: Linux 6.11.0-rc1-P3 ehci_hcd
[   21.095022] usb usb1: SerialNumber: 0000:00:1d.7
[   21.102618] hub 1-0:1.0: USB hub found
[   21.105231] hub 1-0:1.0: 8 ports detected
[   21.345084] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   21.365716] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   21.392601] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   21.393122] uhci_hcd 0000:00:1d.0: irq 16, io port 0x00001800
[   21.409666] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.11
[   21.410108] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   21.410394] usb usb2: Product: UHCI Host Controller
[   21.410632] usb usb2: Manufacturer: Linux 6.11.0-rc1-P3 uhci_hcd
[   21.410880] usb usb2: SerialNumber: 0000:00:1d.0
[   21.414145] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[   21.414349] thinkpad_acpi: http://ibm-acpi.sf.net/
[   21.414568] thinkpad_acpi: ThinkPad BIOS 79ETE7WW (2.27 ), EC 79HT50WW-1.07
[   21.414799] thinkpad_acpi: Lenovo ThinkPad T60, model 2007F2G
[   21.437216] [drm] radeon kernel modesetting enabled.
[   21.485625] radeon 0000:01:00.0: vgaarb: deactivate vga console
[   21.488824] hub 2-0:1.0: USB hub found
[   21.493970] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   21.501593] Console: switching to colour dummy device 80x25
[   21.508254] hub 2-0:1.0: 2 ports detected
[   21.532936] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   21.562461] snd_hda_intel 0000:00:1b.0: probe_mask set to 0x1 for device 17aa:2010
[   21.631919] snd_hda_intel 0000:00:1b.0: Cannot probe codecs, giving up
[   21.685654] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   21.685884] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[   21.686570] uhci_hcd 0000:00:1d.1: irq 17, io port 0x00001820
[   21.697114] [drm] initializing kernel modesetting (RV515 0x1002:0x7149 0x17AA:0x2005 0x00).
[   21.697734] resource: resource sanity check: requesting [mem 0x00000000000c0000-0x00000000000dffff], which spans more than PCI Bus 0000:00 [mem 0x000d0000-0x000dbfff window]
[   21.698074] caller pci_map_rom+0x65/0x180 mapping multiple BARs
[   21.713235] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.11
[   21.713388] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   21.713537] usb usb3: Product: UHCI Host Controller
[   21.713647] usb usb3: Manufacturer: Linux 6.11.0-rc1-P3 uhci_hcd
[   21.713767] usb usb3: SerialNumber: 0000:00:1d.1
[   21.742702] ATOM BIOS: M64CSP/M62CSP/M54CSP/M52CSP
[   21.743019] [drm] Generation 2 PCI interface, using max accessible memory
[   21.743126] radeon 0000:01:00.0: VRAM: 128M 0x0000000000000000 - 0x0000000007FFFFFF (64M used)
[   21.743269] radeon 0000:01:00.0: GTT: 512M 0x0000000008000000 - 0x0000000027FFFFFF
[   21.745198] [drm] Detected VRAM RAM=128M, BAR=128M
[   21.745318] [drm] RAM width 64bits DDR
[   21.813000] [drm] radeon: 64M of VRAM memory ready
[   21.813128] [drm] radeon: 512M of GTT memory ready.
[   21.813553] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   21.834353] [drm] radeon: power management initialized
[   21.839581] [drm] radeon: 1 quad pipes, 1 z pipes initialized.
[   21.846847] hub 3-0:1.0: USB hub found
[   21.851907] hub 3-0:1.0: 2 ports detected
[   21.866680] [drm] PCIE GART of 512M enabled (table at 0x0000000000040000).
[   21.886624] radeon 0000:01:00.0: WB enabled
[   21.886735] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000008000000
[   21.887683] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[   21.888045] [drm] radeon: irq initialized.
[   21.888245] [drm] Loading R500 Microcode
[   21.895803] thinkpad_acpi: radio switch found; radios are disabled
[   21.896080] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[   21.896198] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[   21.911688] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   21.912578] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[   21.913221] uhci_hcd 0000:00:1d.2: irq 18, io port 0x00001840
[   21.925842] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.11
[   21.925993] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   21.926140] usb usb4: Product: UHCI Host Controller
[   21.926250] usb usb4: Manufacturer: Linux 6.11.0-rc1-P3 uhci_hcd
[   21.926371] usb usb4: SerialNumber: 0000:00:1d.2
[   21.951508] [drm] radeon: ring at 0x0000000008001000
[   21.952098] [drm] ring test succeeded in 2 usecs
[   21.955240] [drm] ib test succeeded in 0 usecs
[   21.959038] BTRFS info: devid 1 device path /dev/root changed to /dev/sda4 scanned by (udev-worker) (189)
[   22.002159] hub 4-0:1.0: USB hub found
[   22.002485] hub 4-0:1.0: 2 ports detected
[   22.098877] iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection driver for Linux, in-tree:s
[   22.099008] iwl3945: Copyright(c) 2003-2011 Intel Corporation
[   22.099119] iwl3945: hw_scan is disabled
[   22.099668] iwl3945 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[   22.144287] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[   22.144510] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[   22.145584] uhci_hcd 0000:00:1d.3: irq 19, io port 0x00001860
[   22.331541] Adding 16777212k swap on /dev/sda2.  Priority:-2 extents:1 across:16777212k 
[   22.339065] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.11
[   22.339218] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   22.339366] usb usb5: Product: UHCI Host Controller
[   22.339476] usb usb5: Manufacturer: Linux 6.11.0-rc1-P3 uhci_hcd
[   22.339596] usb usb5: SerialNumber: 0000:00:1d.3
[   22.356454] hub 5-0:1.0: USB hub found
[   22.362480] hub 5-0:1.0: 2 ports detected
[   22.495581] iwl3945 0000:03:00.0: Tunable channels: 13 802.11bg, 23 802.11a channels
[   22.495716] iwl3945 0000:03:00.0: Detected Intel Wireless WiFi Link 3945ABG
[   22.611925] usb 5-2: new full-speed USB device number 2 using uhci_hcd
[   22.655522] thinkpad_acpi: Standard ACPI backlight interface available, not loading native one
[   22.658984] thinkpad_acpi: Console audio control enabled, mode: monitor (read only)
[   22.806017] usb 5-2: New USB device found, idVendor=0483, idProduct=2016, bcdDevice= 0.01
[   22.806326] usb 5-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   22.806469] usb 5-2: Product: Biometric Coprocessor
[   22.806581] usb 5-2: Manufacturer: STMicroelectronics
[   22.939473] acpi device:06: registered as cooling_device2
[   22.939987] [drm] Radeon Display Connectors
[   22.940069] [drm] Connector 0:
[   22.940160] [drm]   VGA-1
[   22.940253] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
[   22.940372] [drm]   Encoders:
[   22.940459] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   22.940559] [drm] Connector 1:
[   22.940643] [drm]   LVDS-1
[   22.940732] [drm]   DDC: 0x7e60 0x7e60 0x7e64 0x7e64 0x7e68 0x7e68 0x7e6c 0x7e6c
[   22.940847] [drm]   Encoders:
[   22.940937] [drm]     LCD1: INTERNAL_LVTM1
[   22.941023] [drm] Connector 2:
[   22.941108] [drm]   DVI-I-1
[   22.941190] [drm]   HPD1
[   22.941282] [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
[   22.941397] [drm]   Encoders:
[   22.941489] [drm]     DFP1: INTERNAL_KLDSCP_TMDS1
[   22.954956] [drm] Initialized radeon 2.50.0 for 0000:01:00.0 on minor 0
[   22.960422] thinkpad_acpi: secondary fan control detected & enabled
[   22.972056] thinkpad_acpi: battery 1 registered (start 0, stop 0, behaviours: 0x1)
[   23.022659] ACPI: battery: new extension: ThinkPad Battery Extension
[   23.092435] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input8
[   23.495708] [drm] fb mappable at 0xD80C0000
[   23.496016] [drm] vram apper at 0xD8000000
[   23.496099] [drm] size 3145728
[   23.496171] [drm] fb depth is 24
[   23.496244] [drm]    pitch is 4096
[   23.496821] fbcon: radeondrmfb (fb0) is primary device
[   23.705933] Console: switching to colour frame buffer device 128x48
[   23.710507] radeon 0000:01:00.0: [drm] fb0: radeondrmfb frame buffer device
[   24.173319] bcachefs (sda6): starting version 1.9: disk_accounting_v2 opts=metadata_checksum=xxhash,data_checksum=xxhash,compression=zstd:3
[   24.173728] bcachefs (sda6): recovering from clean shutdown, journal seq 43592
[   25.119834] bcachefs (sda6): accounting_read... done
[   25.141136] bcachefs (sda6): alloc_read... done
[   25.143789] bcachefs (sda6): stripes_read... done
[   25.144001] bcachefs (sda6): snapshots_read... done
[   25.225354] bcachefs (sda6): journal_replay... done
[   25.225608] bcachefs (sda6): resume_logged_ops... done
[   25.235524] bcachefs (sda6): going read-write
[   33.295723] NET: Registered PF_PACKET protocol family
[   33.396340] alg: No test for hmac(md4) (hmac(md4-generic))
[   36.629601] systemd-journald[126]: /var/log/journal/99afd334b5564c88beb2143d13a85751/user-1000.journal: Journal file uses a different sequence number ID, rotating.
[  184.831530] bcachefs (sda6): shutdown complete, journal seq 43606
[  185.113689] systemd-shutdown[1]: Syncing filesystems and block devices.
[  185.734575] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
[  185.787213] systemd-journald[126]: Received SIGTERM from PID 1 (systemd-shutdow).
[  185.947288] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
[  185.992249] systemd-shutdown[1]: Unmounting file systems.
[  186.000730] (sd-remount)[691]: Remounting '/' read-only with options 'compress=zstd:1,discard=async,space_cache,subvolid=5,subvol=/'.
[  186.239731] systemd-shutdown[1]: All filesystems unmounted.
[  186.241518] systemd-shutdown[1]: Deactivating swaps.
[  186.243585] systemd-shutdown[1]: All swaps deactivated.
[  186.245303] systemd-shutdown[1]: Detaching loop devices.
[  186.267731] systemd-shutdown[1]: All loop devices detached.
[  186.269461] systemd-shutdown[1]: Stopping MD devices.
[  186.272253] systemd-shutdown[1]: All MD devices stopped.
[  186.273929] systemd-shutdown[1]: Detaching DM devices.
[  186.276675] systemd-shutdown[1]: All DM devices detached.
[  186.278309] systemd-shutdown[1]: All filesystems, swaps, loop devices, MD devices and DM devices detached.
[  186.284351] systemd-shutdown[1]: Syncing filesystems and block devices.
[  186.289111] systemd-shutdown[1]: Rebooting.
[  186.527320] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  187.609609] e1000e: EEE TX LPI TIMER: 00000000

--MP_/h5wDT.s6wbxhPxXH4h.e5+J
Content-Type: application/octet-stream; name=config_611-rc1_p3+
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=config_611-rc1_p3+

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGZpbGU7IERPIE5PVCBFRElULgojIExpbnV4L3g4
NiA2LjExLjAtcmMxIEtlcm5lbCBDb25maWd1cmF0aW9uCiMKQ09ORklHX0NDX1ZFUlNJT05fVEVY
VD0iY2xhbmcgdmVyc2lvbiAxOC4xLjgiCkNPTkZJR19HQ0NfVkVSU0lPTj0wCkNPTkZJR19DQ19J
U19DTEFORz15CkNPTkZJR19DTEFOR19WRVJTSU9OPTE4MDEwOApDT05GSUdfQVNfSVNfTExWTT15
CkNPTkZJR19BU19WRVJTSU9OPTE4MDEwOApDT05GSUdfTERfVkVSU0lPTj0wCkNPTkZJR19MRF9J
U19MTEQ9eQpDT05GSUdfTExEX1ZFUlNJT049MTgwMTA4CkNPTkZJR19DQ19DQU5fTElOSz15CkNP
TkZJR19DQ19DQU5fTElOS19TVEFUSUM9eQpDT05GSUdfQ0NfSEFTX0FTTV9HT1RPX09VVFBVVD15
CkNPTkZJR19DQ19IQVNfQVNNX0dPVE9fVElFRF9PVVRQVVQ9eQpDT05GSUdfVE9PTFNfU1VQUE9S
VF9SRUxSPXkKQ09ORklHX0NDX0hBU19BU01fSU5MSU5FPXkKQ09ORklHX0NDX0hBU19OT19QUk9G
SUxFX0ZOX0FUVFI9eQpDT05GSUdfUEFIT0xFX1ZFUlNJT049MApDT05GSUdfSVJRX1dPUks9eQpD
T05GSUdfQlVJTERUSU1FX1RBQkxFX1NPUlQ9eQpDT05GSUdfVEhSRUFEX0lORk9fSU5fVEFTSz15
CgojCiMgR2VuZXJhbCBzZXR1cAojCkNPTkZJR19JTklUX0VOVl9BUkdfTElNSVQ9MzIKIyBDT05G
SUdfQ09NUElMRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfV0VSUk9SIGlzIG5vdCBzZXQKQ09O
RklHX0xPQ0FMVkVSU0lPTj0iLVAzIgojIENPTkZJR19MT0NBTFZFUlNJT05fQVVUTyBpcyBub3Qg
c2V0CkNPTkZJR19CVUlMRF9TQUxUPSIiCkNPTkZJR19IQVZFX0tFUk5FTF9HWklQPXkKQ09ORklH
X0hBVkVfS0VSTkVMX0JaSVAyPXkKQ09ORklHX0hBVkVfS0VSTkVMX0xaTUE9eQpDT05GSUdfSEFW
RV9LRVJORUxfWFo9eQpDT05GSUdfSEFWRV9LRVJORUxfTFpPPXkKQ09ORklHX0hBVkVfS0VSTkVM
X0xaND15CkNPTkZJR19IQVZFX0tFUk5FTF9aU1REPXkKIyBDT05GSUdfS0VSTkVMX0daSVAgaXMg
bm90IHNldAojIENPTkZJR19LRVJORUxfQlpJUDIgaXMgbm90IHNldAojIENPTkZJR19LRVJORUxf
TFpNQSBpcyBub3Qgc2V0CiMgQ09ORklHX0tFUk5FTF9YWiBpcyBub3Qgc2V0CiMgQ09ORklHX0tF
Uk5FTF9MWk8gaXMgbm90IHNldAojIENPTkZJR19LRVJORUxfTFo0IGlzIG5vdCBzZXQKQ09ORklH
X0tFUk5FTF9aU1REPXkKQ09ORklHX0RFRkFVTFRfSU5JVD0iIgpDT05GSUdfREVGQVVMVF9IT1NU
TkFNRT0iKG5vbmUpIgpDT05GSUdfU1lTVklQQz15CkNPTkZJR19TWVNWSVBDX1NZU0NUTD15CkNP
TkZJR19QT1NJWF9NUVVFVUU9eQpDT05GSUdfUE9TSVhfTVFVRVVFX1NZU0NUTD15CkNPTkZJR19X
QVRDSF9RVUVVRT15CkNPTkZJR19DUk9TU19NRU1PUllfQVRUQUNIPXkKIyBDT05GSUdfVVNFTElC
IGlzIG5vdCBzZXQKIyBDT05GSUdfQVVESVQgaXMgbm90IHNldApDT05GSUdfSEFWRV9BUkNIX0FV
RElUU1lTQ0FMTD15CgojCiMgSVJRIHN1YnN5c3RlbQojCkNPTkZJR19HRU5FUklDX0lSUV9QUk9C
RT15CkNPTkZJR19HRU5FUklDX0lSUV9TSE9XPXkKQ09ORklHX0dFTkVSSUNfSVJRX0VGRkVDVElW
RV9BRkZfTUFTSz15CkNPTkZJR19HRU5FUklDX1BFTkRJTkdfSVJRPXkKQ09ORklHX0dFTkVSSUNf
SVJRX01JR1JBVElPTj15CkNPTkZJR19IQVJESVJRU19TV19SRVNFTkQ9eQpDT05GSUdfSVJRX0RP
TUFJTj15CkNPTkZJR19JUlFfRE9NQUlOX0hJRVJBUkNIWT15CkNPTkZJR19HRU5FUklDX01TSV9J
UlE9eQpDT05GSUdfR0VORVJJQ19JUlFfTUFUUklYX0FMTE9DQVRPUj15CkNPTkZJR19HRU5FUklD
X0lSUV9SRVNFUlZBVElPTl9NT0RFPXkKQ09ORklHX0lSUV9GT1JDRURfVEhSRUFESU5HPXkKQ09O
RklHX1NQQVJTRV9JUlE9eQojIENPTkZJR19HRU5FUklDX0lSUV9ERUJVR0ZTIGlzIG5vdCBzZXQK
IyBlbmQgb2YgSVJRIHN1YnN5c3RlbQoKQ09ORklHX0NMT0NLU09VUkNFX1dBVENIRE9HPXkKQ09O
RklHX0FSQ0hfQ0xPQ0tTT1VSQ0VfSU5JVD15CkNPTkZJR19DTE9DS1NPVVJDRV9WQUxJREFURV9M
QVNUX0NZQ0xFPXkKQ09ORklHX0dFTkVSSUNfVElNRV9WU1lTQ0FMTD15CkNPTkZJR19HRU5FUklD
X0NMT0NLRVZFTlRTPXkKQ09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlJPQURDQVNUPXkKQ09O
RklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlJPQURDQVNUX0lETEU9eQpDT05GSUdfR0VORVJJQ19D
TE9DS0VWRU5UU19NSU5fQURKVVNUPXkKQ09ORklHX0dFTkVSSUNfQ01PU19VUERBVEU9eQpDT05G
SUdfSEFWRV9QT1NJWF9DUFVfVElNRVJTX1RBU0tfV09SSz15CkNPTkZJR19QT1NJWF9DUFVfVElN
RVJTX1RBU0tfV09SSz15CkNPTkZJR19USU1FX0tVTklUX1RFU1Q9bQpDT05GSUdfQ09OVEVYVF9U
UkFDS0lORz15CkNPTkZJR19DT05URVhUX1RSQUNLSU5HX0lETEU9eQoKIwojIFRpbWVycyBzdWJz
eXN0ZW0KIwpDT05GSUdfVElDS19PTkVTSE9UPXkKQ09ORklHX05PX0haX0NPTU1PTj15CiMgQ09O
RklHX0haX1BFUklPRElDIGlzIG5vdCBzZXQKQ09ORklHX05PX0haX0lETEU9eQojIENPTkZJR19O
T19IWiBpcyBub3Qgc2V0CkNPTkZJR19ISUdIX1JFU19USU1FUlM9eQpDT05GSUdfQ0xPQ0tTT1VS
Q0VfV0FUQ0hET0dfTUFYX1NLRVdfVVM9MTAwCiMgZW5kIG9mIFRpbWVycyBzdWJzeXN0ZW0KCkNP
TkZJR19CUEY9eQpDT05GSUdfSEFWRV9FQlBGX0pJVD15CgojCiMgQlBGIHN1YnN5c3RlbQojCkNP
TkZJR19CUEZfU1lTQ0FMTD15CkNPTkZJR19CUEZfSklUPXkKQ09ORklHX0JQRl9KSVRfQUxXQVlT
X09OPXkKQ09ORklHX0JQRl9KSVRfREVGQVVMVF9PTj15CkNPTkZJR19CUEZfVU5QUklWX0RFRkFV
TFRfT0ZGPXkKIyBDT05GSUdfQlBGX1BSRUxPQUQgaXMgbm90IHNldAojIGVuZCBvZiBCUEYgc3Vi
c3lzdGVtCgpDT05GSUdfUFJFRU1QVF9WT0xVTlRBUllfQlVJTEQ9eQojIENPTkZJR19QUkVFTVBU
X05PTkUgaXMgbm90IHNldApDT05GSUdfUFJFRU1QVF9WT0xVTlRBUlk9eQojIENPTkZJR19QUkVF
TVBUIGlzIG5vdCBzZXQKQ09ORklHX1BSRUVNUFRfQ09VTlQ9eQojIENPTkZJR19QUkVFTVBUX0RZ
TkFNSUMgaXMgbm90IHNldAojIENPTkZJR19TQ0hFRF9DT1JFIGlzIG5vdCBzZXQKCiMKIyBDUFUv
VGFzayB0aW1lIGFuZCBzdGF0cyBhY2NvdW50aW5nCiMKQ09ORklHX1RJQ0tfQ1BVX0FDQ09VTlRJ
Tkc9eQojIENPTkZJR19JUlFfVElNRV9BQ0NPVU5USU5HIGlzIG5vdCBzZXQKQ09ORklHX0JTRF9Q
Uk9DRVNTX0FDQ1Q9eQpDT05GSUdfQlNEX1BST0NFU1NfQUNDVF9WMz15CkNPTkZJR19UQVNLU1RB
VFM9eQpDT05GSUdfVEFTS19ERUxBWV9BQ0NUPXkKQ09ORklHX1RBU0tfWEFDQ1Q9eQpDT05GSUdf
VEFTS19JT19BQ0NPVU5USU5HPXkKIyBDT05GSUdfUFNJIGlzIG5vdCBzZXQKIyBlbmQgb2YgQ1BV
L1Rhc2sgdGltZSBhbmQgc3RhdHMgYWNjb3VudGluZwoKQ09ORklHX0NQVV9JU09MQVRJT049eQoK
IwojIFJDVSBTdWJzeXN0ZW0KIwpDT05GSUdfVFJFRV9SQ1U9eQojIENPTkZJR19SQ1VfRVhQRVJU
IGlzIG5vdCBzZXQKQ09ORklHX1RSRUVfU1JDVT15CkNPTkZJR19UQVNLU19SQ1VfR0VORVJJQz15
CkNPTkZJR19ORUVEX1RBU0tTX1JDVT15CkNPTkZJR19UQVNLU19UUkFDRV9SQ1U9eQpDT05GSUdf
UkNVX1NUQUxMX0NPTU1PTj15CkNPTkZJR19SQ1VfTkVFRF9TRUdDQkxJU1Q9eQojIGVuZCBvZiBS
Q1UgU3Vic3lzdGVtCgojIENPTkZJR19JS0NPTkZJRyBpcyBub3Qgc2V0CiMgQ09ORklHX0lLSEVB
REVSUyBpcyBub3Qgc2V0CkNPTkZJR19MT0dfQlVGX1NISUZUPTE2CkNPTkZJR19MT0dfQ1BVX01B
WF9CVUZfU0hJRlQ9MTMKIyBDT05GSUdfUFJJTlRLX0lOREVYIGlzIG5vdCBzZXQKQ09ORklHX0hB
VkVfVU5TVEFCTEVfU0NIRURfQ0xPQ0s9eQoKIwojIFNjaGVkdWxlciBmZWF0dXJlcwojCiMgQ09O
RklHX1VDTEFNUF9UQVNLIGlzIG5vdCBzZXQKIyBlbmQgb2YgU2NoZWR1bGVyIGZlYXR1cmVzCgpD
T05GSUdfQVJDSF9XQU5UX0JBVENIRURfVU5NQVBfVExCX0ZMVVNIPXkKQ09ORklHX0NDX0lNUExJ
Q0lUX0ZBTExUSFJPVUdIPSItV2ltcGxpY2l0LWZhbGx0aHJvdWdoIgpDT05GSUdfR0NDMTBfTk9f
QVJSQVlfQk9VTkRTPXkKQ09ORklHX0dDQ19OT19TVFJJTkdPUF9PVkVSRkxPVz15CkNPTkZJR19T
TEFCX09CSl9FWFQ9eQpDT05GSUdfQ0dST1VQUz15CkNPTkZJR19QQUdFX0NPVU5URVI9eQojIENP
TkZJR19DR1JPVVBfRkFWT1JfRFlOTU9EUyBpcyBub3Qgc2V0CkNPTkZJR19NRU1DRz15CiMgQ09O
RklHX01FTUNHX1YxIGlzIG5vdCBzZXQKQ09ORklHX0JMS19DR1JPVVA9eQpDT05GSUdfQ0dST1VQ
X1dSSVRFQkFDSz15CkNPTkZJR19DR1JPVVBfU0NIRUQ9eQpDT05GSUdfRkFJUl9HUk9VUF9TQ0hF
RD15CiMgQ09ORklHX0NGU19CQU5EV0lEVEggaXMgbm90IHNldAojIENPTkZJR19SVF9HUk9VUF9T
Q0hFRCBpcyBub3Qgc2V0CkNPTkZJR19TQ0hFRF9NTV9DSUQ9eQpDT05GSUdfQ0dST1VQX1BJRFM9
eQpDT05GSUdfQ0dST1VQX1JETUE9eQpDT05GSUdfQ0dST1VQX0ZSRUVaRVI9eQojIENPTkZJR19D
R1JPVVBfSFVHRVRMQiBpcyBub3Qgc2V0CkNPTkZJR19DUFVTRVRTPXkKQ09ORklHX1BST0NfUElE
X0NQVVNFVD15CkNPTkZJR19DR1JPVVBfREVWSUNFPXkKQ09ORklHX0NHUk9VUF9DUFVBQ0NUPXkK
Q09ORklHX0NHUk9VUF9QRVJGPXkKQ09ORklHX0NHUk9VUF9CUEY9eQpDT05GSUdfQ0dST1VQX01J
U0M9eQojIENPTkZJR19DR1JPVVBfREVCVUcgaXMgbm90IHNldApDT05GSUdfU09DS19DR1JPVVBf
REFUQT15CkNPTkZJR19OQU1FU1BBQ0VTPXkKQ09ORklHX1VUU19OUz15CkNPTkZJR19USU1FX05T
PXkKQ09ORklHX0lQQ19OUz15CkNPTkZJR19VU0VSX05TPXkKQ09ORklHX1BJRF9OUz15CkNPTkZJ
R19ORVRfTlM9eQojIENPTkZJR19DSEVDS1BPSU5UX1JFU1RPUkUgaXMgbm90IHNldApDT05GSUdf
U0NIRURfQVVUT0dST1VQPXkKIyBDT05GSUdfUkVMQVkgaXMgbm90IHNldApDT05GSUdfQkxLX0RF
Vl9JTklUUkQ9eQpDT05GSUdfSU5JVFJBTUZTX1NPVVJDRT0iIgpDT05GSUdfUkRfR1pJUD15CiMg
Q09ORklHX1JEX0JaSVAyIGlzIG5vdCBzZXQKIyBDT05GSUdfUkRfTFpNQSBpcyBub3Qgc2V0CiMg
Q09ORklHX1JEX1haIGlzIG5vdCBzZXQKIyBDT05GSUdfUkRfTFpPIGlzIG5vdCBzZXQKIyBDT05G
SUdfUkRfTFo0IGlzIG5vdCBzZXQKQ09ORklHX1JEX1pTVEQ9eQojIENPTkZJR19CT09UX0NPTkZJ
RyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOSVRSQU1GU19QUkVTRVJWRV9NVElNRSBpcyBub3Qgc2V0
CiMgQ09ORklHX0NDX09QVElNSVpFX0ZPUl9QRVJGT1JNQU5DRSBpcyBub3Qgc2V0CkNPTkZJR19D
Q19PUFRJTUlaRV9GT1JfU0laRT15CkNPTkZJR19MRF9PUlBIQU5fV0FSTj15CkNPTkZJR19MRF9P
UlBIQU5fV0FSTl9MRVZFTD0id2FybiIKQ09ORklHX1NZU0NUTD15CkNPTkZJR19IQVZFX1VJRDE2
PXkKQ09ORklHX1NZU0NUTF9FWENFUFRJT05fVFJBQ0U9eQpDT05GSUdfSEFWRV9QQ1NQS1JfUExB
VEZPUk09eQpDT05GSUdfRVhQRVJUPXkKQ09ORklHX1VJRDE2PXkKQ09ORklHX01VTFRJVVNFUj15
CiMgQ09ORklHX1NHRVRNQVNLX1NZU0NBTEwgaXMgbm90IHNldAojIENPTkZJR19TWVNGU19TWVND
QUxMIGlzIG5vdCBzZXQKQ09ORklHX0ZIQU5ETEU9eQpDT05GSUdfUE9TSVhfVElNRVJTPXkKQ09O
RklHX1BSSU5USz15CkNPTkZJR19CVUc9eQpDT05GSUdfRUxGX0NPUkU9eQojIENPTkZJR19QQ1NQ
S1JfUExBVEZPUk0gaXMgbm90IHNldApDT05GSUdfQkFTRV9TTUFMTD15CkNPTkZJR19GVVRFWD15
CkNPTkZJR19GVVRFWF9QST15CkNPTkZJR19FUE9MTD15CkNPTkZJR19TSUdOQUxGRD15CkNPTkZJ
R19USU1FUkZEPXkKQ09ORklHX0VWRU5URkQ9eQpDT05GSUdfU0hNRU09eQpDT05GSUdfQUlPPXkK
Q09ORklHX0lPX1VSSU5HPXkKQ09ORklHX0FEVklTRV9TWVNDQUxMUz15CkNPTkZJR19NRU1CQVJS
SUVSPXkKQ09ORklHX0tDTVA9eQpDT05GSUdfUlNFUT15CiMgQ09ORklHX0RFQlVHX1JTRVEgaXMg
bm90IHNldApDT05GSUdfQ0FDSEVTVEFUX1NZU0NBTEw9eQojIENPTkZJR19QQzEwNCBpcyBub3Qg
c2V0CkNPTkZJR19LQUxMU1lNUz15CiMgQ09ORklHX0tBTExTWU1TX1NFTEZURVNUIGlzIG5vdCBz
ZXQKQ09ORklHX0tBTExTWU1TX0FMTD15CkNPTkZJR19BUkNIX0hBU19NRU1CQVJSSUVSX1NZTkNf
Q09SRT15CkNPTkZJR19IQVZFX1BFUkZfRVZFTlRTPXkKCiMKIyBLZXJuZWwgUGVyZm9ybWFuY2Ug
RXZlbnRzIEFuZCBDb3VudGVycwojCkNPTkZJR19QRVJGX0VWRU5UUz15CiMgQ09ORklHX0RFQlVH
X1BFUkZfVVNFX1ZNQUxMT0MgaXMgbm90IHNldAojIGVuZCBvZiBLZXJuZWwgUGVyZm9ybWFuY2Ug
RXZlbnRzIEFuZCBDb3VudGVycwoKQ09ORklHX1NZU1RFTV9EQVRBX1ZFUklGSUNBVElPTj15CiMg
Q09ORklHX1BST0ZJTElORyBpcyBub3Qgc2V0CkNPTkZJR19UUkFDRVBPSU5UUz15CgojCiMgS2V4
ZWMgYW5kIGNyYXNoIGZlYXR1cmVzCiMKIyBDT05GSUdfS0VYRUMgaXMgbm90IHNldAojIGVuZCBv
ZiBLZXhlYyBhbmQgY3Jhc2ggZmVhdHVyZXMKIyBlbmQgb2YgR2VuZXJhbCBzZXR1cAoKIyBDT05G
SUdfNjRCSVQgaXMgbm90IHNldApDT05GSUdfWDg2XzMyPXkKQ09ORklHX1g4Nj15CkNPTkZJR19J
TlNUUlVDVElPTl9ERUNPREVSPXkKQ09ORklHX09VVFBVVF9GT1JNQVQ9ImVsZjMyLWkzODYiCkNP
TkZJR19MT0NLREVQX1NVUFBPUlQ9eQpDT05GSUdfU1RBQ0tUUkFDRV9TVVBQT1JUPXkKQ09ORklH
X01NVT15CkNPTkZJR19BUkNIX01NQVBfUk5EX0JJVFNfTUlOPTgKQ09ORklHX0FSQ0hfTU1BUF9S
TkRfQklUU19NQVg9MTYKQ09ORklHX0FSQ0hfTU1BUF9STkRfQ09NUEFUX0JJVFNfTUlOPTgKQ09O
RklHX0FSQ0hfTU1BUF9STkRfQ09NUEFUX0JJVFNfTUFYPTE2CkNPTkZJR19HRU5FUklDX0lTQV9E
TUE9eQpDT05GSUdfR0VORVJJQ19CVUc9eQpDT05GSUdfQVJDSF9NQVlfSEFWRV9QQ19GREM9eQpD
T05GSUdfR0VORVJJQ19DQUxJQlJBVEVfREVMQVk9eQpDT05GSUdfQVJDSF9IQVNfQ1BVX1JFTEFY
PXkKQ09ORklHX0FSQ0hfSElCRVJOQVRJT05fUE9TU0lCTEU9eQpDT05GSUdfQVJDSF9TVVNQRU5E
X1BPU1NJQkxFPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfVVBST0JFUz15CkNPTkZJR19GSVhfRUFS
TFlDT05fTUVNPXkKQ09ORklHX1BHVEFCTEVfTEVWRUxTPTMKQ09ORklHX0NDX0hBU19TQU5FX1NU
QUNLUFJPVEVDVE9SPXkKCiMKIyBQcm9jZXNzb3IgdHlwZSBhbmQgZmVhdHVyZXMKIwpDT05GSUdf
U01QPXkKQ09ORklHX1g4Nl9NUFBBUlNFPXkKIyBDT05GSUdfWDg2X0NQVV9SRVNDVFJMIGlzIG5v
dCBzZXQKIyBDT05GSUdfWDg2X0JJR1NNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9FWFRFTkRF
RF9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9JTlRFTF9MUFNTIGlzIG5vdCBzZXQK
IyBDT05GSUdfWDg2X0FNRF9QTEFURk9STV9ERVZJQ0UgaXMgbm90IHNldAojIENPTkZJR19JT1NG
X01CSSBpcyBub3Qgc2V0CkNPTkZJR19YODZfU1VQUE9SVFNfTUVNT1JZX0ZBSUxVUkU9eQojIENP
TkZJR19YODZfMzJfSVJJUyBpcyBub3Qgc2V0CkNPTkZJR19TQ0hFRF9PTUlUX0ZSQU1FX1BPSU5U
RVI9eQpDT05GSUdfSFlQRVJWSVNPUl9HVUVTVD15CiMgQ09ORklHX1BBUkFWSVJUIGlzIG5vdCBz
ZXQKQ09ORklHX0FSQ0hfQ1BVSURMRV9IQUxUUE9MTD15CiMgQ09ORklHX1BWSCBpcyBub3Qgc2V0
CiMgQ09ORklHX000ODZTWCBpcyBub3Qgc2V0CiMgQ09ORklHX000ODYgaXMgbm90IHNldAojIENP
TkZJR19NNTg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTTU4NlRTQyBpcyBub3Qgc2V0CiMgQ09ORklH
X001ODZNTVggaXMgbm90IHNldAojIENPTkZJR19NNjg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTVBF
TlRJVU1JSSBpcyBub3Qgc2V0CkNPTkZJR19NUEVOVElVTUlJST15CiMgQ09ORklHX01QRU5USVVN
TSBpcyBub3Qgc2V0CiMgQ09ORklHX01QRU5USVVNNCBpcyBub3Qgc2V0CiMgQ09ORklHX01LNiBp
cyBub3Qgc2V0CiMgQ09ORklHX01LNyBpcyBub3Qgc2V0CiMgQ09ORklHX01LOCBpcyBub3Qgc2V0
CiMgQ09ORklHX01DUlVTT0UgaXMgbm90IHNldAojIENPTkZJR19NRUZGSUNFT04gaXMgbm90IHNl
dAojIENPTkZJR19NV0lOQ0hJUEM2IGlzIG5vdCBzZXQKIyBDT05GSUdfTVdJTkNISVAzRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX01FTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTUdFT0RFR1gxIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUdFT0RFX0xYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUNZUklYSUlJIGlz
IG5vdCBzZXQKIyBDT05GSUdfTVZJQUMzXzIgaXMgbm90IHNldAojIENPTkZJR19NVklBQzcgaXMg
bm90IHNldAojIENPTkZJR19NQ09SRTIgaXMgbm90IHNldAojIENPTkZJR19NQVRPTSBpcyBub3Qg
c2V0CiMgQ09ORklHX1g4Nl9HRU5FUklDIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9JTlRFUk5PREVf
Q0FDSEVfU0hJRlQ9NQpDT05GSUdfWDg2X0wxX0NBQ0hFX1NISUZUPTUKQ09ORklHX1g4Nl9JTlRF
TF9VU0VSQ09QWT15CkNPTkZJR19YODZfVVNFX1BQUk9fQ0hFQ0tTVU09eQpDT05GSUdfWDg2X1RT
Qz15CkNPTkZJR19YODZfSEFWRV9QQUU9eQpDT05GSUdfWDg2X0NNUFhDSEc2ND15CkNPTkZJR19Y
ODZfQ01PVj15CkNPTkZJR19YODZfTUlOSU1VTV9DUFVfRkFNSUxZPTYKQ09ORklHX1g4Nl9ERUJV
R0NUTE1TUj15CkNPTkZJR19JQTMyX0ZFQVRfQ1RMPXkKQ09ORklHX1g4Nl9WTVhfRkVBVFVSRV9O
QU1FUz15CkNPTkZJR19QUk9DRVNTT1JfU0VMRUNUPXkKQ09ORklHX0NQVV9TVVBfSU5URUw9eQoj
IENPTkZJR19DUFVfU1VQX0NZUklYXzMyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVX1NVUF9BTUQg
aXMgbm90IHNldAojIENPTkZJR19DUFVfU1VQX0hZR09OIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BV
X1NVUF9DRU5UQVVSIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVX1NVUF9UUkFOU01FVEFfMzIgaXMg
bm90IHNldAojIENPTkZJR19DUFVfU1VQX1VNQ18zMiBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVV9T
VVBfWkhBT1hJTiBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVV9TVVBfVk9SVEVYXzMyIGlzIG5vdCBz
ZXQKQ09ORklHX0hQRVRfVElNRVI9eQpDT05GSUdfSFBFVF9FTVVMQVRFX1JUQz15CkNPTkZJR19E
TUk9eQpDT05GSUdfQk9PVF9WRVNBX1NVUFBPUlQ9eQpDT05GSUdfTlJfQ1BVU19SQU5HRV9CRUdJ
Tj0yCkNPTkZJR19OUl9DUFVTX1JBTkdFX0VORD04CkNPTkZJR19OUl9DUFVTX0RFRkFVTFQ9OApD
T05GSUdfTlJfQ1BVUz0yCiMgQ09ORklHX1NDSEVEX0NMVVNURVIgaXMgbm90IHNldApDT05GSUdf
U0NIRURfU01UPXkKQ09ORklHX1NDSEVEX01DPXkKIyBDT05GSUdfU0NIRURfTUNfUFJJTyBpcyBu
b3Qgc2V0CkNPTkZJR19YODZfTE9DQUxfQVBJQz15CkNPTkZJR19YODZfSU9fQVBJQz15CiMgQ09O
RklHX1g4Nl9SRVJPVVRFX0ZPUl9CUk9LRU5fQk9PVF9JUlFTIGlzIG5vdCBzZXQKQ09ORklHX1g4
Nl9NQ0U9eQojIENPTkZJR19YODZfTUNFTE9HX0xFR0FDWSBpcyBub3Qgc2V0CkNPTkZJR19YODZf
TUNFX0lOVEVMPXkKIyBDT05GSUdfWDg2X0FOQ0lFTlRfTUNFIGlzIG5vdCBzZXQKQ09ORklHX1g4
Nl9NQ0VfVEhSRVNIT0xEPXkKIyBDT05GSUdfWDg2X01DRV9JTkpFQ1QgaXMgbm90IHNldAoKIwoj
IFBlcmZvcm1hbmNlIG1vbml0b3JpbmcKIwpDT05GSUdfUEVSRl9FVkVOVFNfSU5URUxfVU5DT1JF
PXkKQ09ORklHX1BFUkZfRVZFTlRTX0lOVEVMX1JBUEw9eQpDT05GSUdfUEVSRl9FVkVOVFNfSU5U
RUxfQ1NUQVRFPXkKIyBlbmQgb2YgUGVyZm9ybWFuY2UgbW9uaXRvcmluZwoKIyBDT05GSUdfWDg2
X0xFR0FDWV9WTTg2IGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0lPUExfSU9QRVJNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVE9TSElCQSBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9SRUJPT1RGSVhVUFMg
aXMgbm90IHNldApDT05GSUdfTUlDUk9DT0RFPXkKQ09ORklHX01JQ1JPQ09ERV9JTklUUkQzMj15
CiMgQ09ORklHX01JQ1JPQ09ERV9MQVRFX0xPQURJTkcgaXMgbm90IHNldAojIENPTkZJR19YODZf
TVNSIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9DUFVJRD1tCiMgQ09ORklHX05PSElHSE1FTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJR0hNRU00RyBpcyBub3Qgc2V0CkNPTkZJR19ISUdITUVNNjRHPXkK
Q09ORklHX1ZNU1BMSVRfM0c9eQojIENPTkZJR19WTVNQTElUXzJHIGlzIG5vdCBzZXQKIyBDT05G
SUdfVk1TUExJVF8xRyBpcyBub3Qgc2V0CkNPTkZJR19QQUdFX09GRlNFVD0weEMwMDAwMDAwCkNP
TkZJR19ISUdITUVNPXkKQ09ORklHX1g4Nl9QQUU9eQojIENPTkZJR19YODZfQ1BBX1NUQVRJU1RJ
Q1MgaXMgbm90IHNldApDT05GSUdfQVJDSF9GTEFUTUVNX0VOQUJMRT15CkNPTkZJR19BUkNIX1NQ
QVJTRU1FTV9FTkFCTEU9eQpDT05GSUdfQVJDSF9TRUxFQ1RfTUVNT1JZX01PREVMPXkKQ09ORklH
X0lMTEVHQUxfUE9JTlRFUl9WQUxVRT0wCiMgQ09ORklHX1g4Nl9QTUVNX0xFR0FDWSBpcyBub3Qg
c2V0CkNPTkZJR19ISUdIUFRFPXkKIyBDT05GSUdfWDg2X0NIRUNLX0JJT1NfQ09SUlVQVElPTiBp
cyBub3Qgc2V0CkNPTkZJR19NVFJSPXkKQ09ORklHX01UUlJfU0FOSVRJWkVSPXkKQ09ORklHX01U
UlJfU0FOSVRJWkVSX0VOQUJMRV9ERUZBVUxUPTEKQ09ORklHX01UUlJfU0FOSVRJWkVSX1NQQVJF
X1JFR19OUl9ERUZBVUxUPTEKQ09ORklHX1g4Nl9QQVQ9eQpDT05GSUdfQVJDSF9VU0VTX1BHX1VO
Q0FDSEVEPXkKIyBDT05GSUdfWDg2X1VNSVAgaXMgbm90IHNldApDT05GSUdfQ0NfSEFTX0lCVD15
CkNPTkZJR19YODZfSU5URUxfVFNYX01PREVfT0ZGPXkKIyBDT05GSUdfWDg2X0lOVEVMX1RTWF9N
T0RFX09OIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0lOVEVMX1RTWF9NT0RFX0FVVE8gaXMgbm90
IHNldAojIENPTkZJR19FRkkgaXMgbm90IHNldAojIENPTkZJR19IWl8xMDAgaXMgbm90IHNldAoj
IENPTkZJR19IWl8yNTAgaXMgbm90IHNldApDT05GSUdfSFpfMzAwPXkKIyBDT05GSUdfSFpfMTAw
MCBpcyBub3Qgc2V0CkNPTkZJR19IWj0zMDAKQ09ORklHX1NDSEVEX0hSVElDSz15CkNPTkZJR19B
UkNIX1NVUFBPUlRTX0tFWEVDPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfS0VYRUNfUFVSR0FUT1JZ
PXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfS0VYRUNfU0lHPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNf
S0VYRUNfU0lHX0ZPUkNFPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfS0VYRUNfQlpJTUFHRV9WRVJJ
RllfU0lHPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfS0VYRUNfSlVNUD15CkNPTkZJR19BUkNIX1NV
UFBPUlRTX0NSQVNIX0RVTVA9eQpDT05GSUdfQVJDSF9TVVBQT1JUU19DUkFTSF9IT1RQTFVHPXkK
Q09ORklHX1BIWVNJQ0FMX1NUQVJUPTB4MTAwMDAwMApDT05GSUdfUkVMT0NBVEFCTEU9eQpDT05G
SUdfUkFORE9NSVpFX0JBU0U9eQpDT05GSUdfWDg2X05FRURfUkVMT0NTPXkKQ09ORklHX1BIWVNJ
Q0FMX0FMSUdOPTB4MjAwMDAwCkNPTkZJR19IT1RQTFVHX0NQVT15CiMgQ09ORklHX0NPTVBBVF9W
RFNPIGlzIG5vdCBzZXQKIyBDT05GSUdfQ01ETElORV9CT09MIGlzIG5vdCBzZXQKIyBDT05GSUdf
TU9ESUZZX0xEVF9TWVNDQUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RSSUNUX1NJR0FMVFNUQUNL
X1NJWkUgaXMgbm90IHNldAojIGVuZCBvZiBQcm9jZXNzb3IgdHlwZSBhbmQgZmVhdHVyZXMKCkNP
TkZJR19DQ19IQVNfU0xTPXkKQ09ORklHX0NDX0hBU19SRVRVUk5fVEhVTks9eQpDT05GSUdfQ0Nf
SEFTX0VOVFJZX1BBRERJTkc9eQpDT05GSUdfRlVOQ1RJT05fUEFERElOR19DRkk9MApDT05GSUdf
RlVOQ1RJT05fUEFERElOR19CWVRFUz00CkNPTkZJR19DUFVfTUlUSUdBVElPTlM9eQpDT05GSUdf
TUlUSUdBVElPTl9QQUdFX1RBQkxFX0lTT0xBVElPTj15CkNPTkZJR19NSVRJR0FUSU9OX1JFVFBP
TElORT15CiMgQ09ORklHX01JVElHQVRJT05fUkVUSFVOSyBpcyBub3Qgc2V0CiMgQ09ORklHX01J
VElHQVRJT05fR0RTX0ZPUkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlUSUdBVElPTl9SRkRTIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUlUSUdBVElPTl9TUEVDVFJFX0JISSBpcyBub3Qgc2V0CgojCiMg
UG93ZXIgbWFuYWdlbWVudCBhbmQgQUNQSSBvcHRpb25zCiMKQ09ORklHX1NVU1BFTkQ9eQpDT05G
SUdfU1VTUEVORF9GUkVFWkVSPXkKIyBDT05GSUdfU1VTUEVORF9TS0lQX1NZTkMgaXMgbm90IHNl
dAojIENPTkZJR19ISUJFUk5BVElPTiBpcyBub3Qgc2V0CkNPTkZJR19QTV9TTEVFUD15CkNPTkZJ
R19QTV9TTEVFUF9TTVA9eQpDT05GSUdfUE1fQVVUT1NMRUVQPXkKIyBDT05GSUdfUE1fVVNFUlNQ
QUNFX0FVVE9TTEVFUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BNX1dBS0VMT0NLUyBpcyBub3Qgc2V0
CkNPTkZJR19QTT15CiMgQ09ORklHX1BNX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1BNX0NMSz15
CkNPTkZJR19XUV9QT1dFUl9FRkZJQ0lFTlRfREVGQVVMVD15CkNPTkZJR19FTkVSR1lfTU9ERUw9
eQpDT05GSUdfQVJDSF9TVVBQT1JUU19BQ1BJPXkKQ09ORklHX0FDUEk9eQpDT05GSUdfQUNQSV9M
RUdBQ1lfVEFCTEVTX0xPT0tVUD15CkNPTkZJR19BUkNIX01JR0hUX0hBVkVfQUNQSV9QREM9eQpD
T05GSUdfQUNQSV9TWVNURU1fUE9XRVJfU1RBVEVTX1NVUFBPUlQ9eQpDT05GSUdfQUNQSV9USEVS
TUFMX0xJQj15CiMgQ09ORklHX0FDUElfREVCVUdHRVIgaXMgbm90IHNldApDT05GSUdfQUNQSV9T
UENSX1RBQkxFPXkKQ09ORklHX0FDUElfU0xFRVA9eQojIENPTkZJR19BQ1BJX1JFVl9PVkVSUklE
RV9QT1NTSUJMRSBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUElfRUNfREVCVUdGUyBpcyBub3Qgc2V0
CkNPTkZJR19BQ1BJX0FDPW0KQ09ORklHX0FDUElfQkFUVEVSWT1tCkNPTkZJR19BQ1BJX0JVVFRP
Tj1tCiMgQ09ORklHX0FDUElfVElOWV9QT1dFUl9CVVRUT04gaXMgbm90IHNldApDT05GSUdfQUNQ
SV9WSURFTz1tCkNPTkZJR19BQ1BJX0ZBTj1tCiMgQ09ORklHX0FDUElfVEFEIGlzIG5vdCBzZXQK
IyBDT05GSUdfQUNQSV9ET0NLIGlzIG5vdCBzZXQKQ09ORklHX0FDUElfQ1BVX0ZSRVFfUFNTPXkK
Q09ORklHX0FDUElfUFJPQ0VTU09SX0NTVEFURT15CkNPTkZJR19BQ1BJX1BST0NFU1NPUl9JRExF
PXkKQ09ORklHX0FDUElfUFJPQ0VTU09SPW0KQ09ORklHX0FDUElfSE9UUExVR19DUFU9eQojIENP
TkZJR19BQ1BJX1BST0NFU1NPUl9BR0dSRUdBVE9SIGlzIG5vdCBzZXQKQ09ORklHX0FDUElfVEhF
Uk1BTD1tCkNPTkZJR19BQ1BJX1BMQVRGT1JNX1BST0ZJTEU9bQpDT05GSUdfQVJDSF9IQVNfQUNQ
SV9UQUJMRV9VUEdSQURFPXkKQ09ORklHX0FDUElfVEFCTEVfVVBHUkFERT15CiMgQ09ORklHX0FD
UElfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19BQ1BJX1BDSV9TTE9UIGlzIG5vdCBzZXQKQ09O
RklHX0FDUElfQ09OVEFJTkVSPXkKQ09ORklHX0FDUElfSE9UUExVR19JT0FQSUM9eQpDT05GSUdf
QUNQSV9TQlM9bQojIENPTkZJR19BQ1BJX0hFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUElfUkVE
VUNFRF9IQVJEV0FSRV9PTkxZIGlzIG5vdCBzZXQKQ09ORklHX0FDUElfTkhMVD15CkNPTkZJR19I
QVZFX0FDUElfQVBFST15CkNPTkZJR19IQVZFX0FDUElfQVBFSV9OTUk9eQojIENPTkZJR19BQ1BJ
X0FQRUkgaXMgbm90IHNldAojIENPTkZJR19BQ1BJX0RQVEYgaXMgbm90IHNldAojIENPTkZJR19B
Q1BJX0NPTkZJR0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQSV9GRkggaXMgbm90IHNldAojIENP
TkZJR19QTUlDX09QUkVHSU9OIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9QTV9USU1FUj15CiMgQ09O
RklHX0FQTSBpcyBub3Qgc2V0CgojCiMgQ1BVIEZyZXF1ZW5jeSBzY2FsaW5nCiMKQ09ORklHX0NQ
VV9GUkVRPXkKQ09ORklHX0NQVV9GUkVRX0dPVl9BVFRSX1NFVD15CiMgQ09ORklHX0NQVV9GUkVR
X1NUQVQgaXMgbm90IHNldAojIENPTkZJR19DUFVfRlJFUV9ERUZBVUxUX0dPVl9QRVJGT1JNQU5D
RSBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVV9GUkVRX0RFRkFVTFRfR09WX1BPV0VSU0FWRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NQVV9GUkVRX0RFRkFVTFRfR09WX1VTRVJTUEFDRSBpcyBub3Qgc2V0
CiMgQ09ORklHX0NQVV9GUkVRX0RFRkFVTFRfR09WX09OREVNQU5EIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1ZfQ09OU0VSVkFUSVZFIGlzIG5vdCBzZXQKQ09ORklHX0NQ
VV9GUkVRX0RFRkFVTFRfR09WX1NDSEVEVVRJTD15CkNPTkZJR19DUFVfRlJFUV9HT1ZfUEVSRk9S
TUFOQ0U9eQojIENPTkZJR19DUFVfRlJFUV9HT1ZfUE9XRVJTQVZFIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1BVX0ZSRVFfR09WX1VTRVJTUEFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVV9GUkVRX0dP
Vl9PTkRFTUFORCBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVV9GUkVRX0dPVl9DT05TRVJWQVRJVkUg
aXMgbm90IHNldApDT05GSUdfQ1BVX0ZSRVFfR09WX1NDSEVEVVRJTD15CgojCiMgQ1BVIGZyZXF1
ZW5jeSBzY2FsaW5nIGRyaXZlcnMKIwojIENPTkZJR19DUFVGUkVRX0RUIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1BVRlJFUV9EVF9QTEFUREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0lOVEVMX1BT
VEFURSBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9QQ0NfQ1BVRlJFUSBpcyBub3Qgc2V0CiMgQ09O
RklHX1g4Nl9BTURfUFNUQVRFIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9BQ1BJX0NQVUZSRVE9bQoj
IENPTkZJR19YODZfUE9XRVJOT1dfSzYgaXMgbm90IHNldAojIENPTkZJR19YODZfUE9XRVJOT1df
SzcgaXMgbm90IHNldAojIENPTkZJR19YODZfUE9XRVJOT1dfSzggaXMgbm90IHNldAojIENPTkZJ
R19YODZfR1hfU1VTUE1PRCBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9TUEVFRFNURVBfQ0VOVFJJ
Tk8gaXMgbm90IHNldAojIENPTkZJR19YODZfU1BFRURTVEVQX0lDSCBpcyBub3Qgc2V0CiMgQ09O
RklHX1g4Nl9TUEVFRFNURVBfU01JIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X1A0X0NMT0NLTU9E
IGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0NQVUZSRVFfTkZPUkNFMiBpcyBub3Qgc2V0CiMgQ09O
RklHX1g4Nl9MT05HUlVOIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0xPTkdIQVVMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfWDg2X0VfUE9XRVJTQVZFUiBpcyBub3Qgc2V0CgojCiMgc2hhcmVkIG9wdGlv
bnMKIwojIGVuZCBvZiBDUFUgRnJlcXVlbmN5IHNjYWxpbmcKCiMKIyBDUFUgSWRsZQojCkNPTkZJ
R19DUFVfSURMRT15CiMgQ09ORklHX0NQVV9JRExFX0dPVl9MQURERVIgaXMgbm90IHNldApDT05G
SUdfQ1BVX0lETEVfR09WX01FTlU9eQojIENPTkZJR19DUFVfSURMRV9HT1ZfVEVPIGlzIG5vdCBz
ZXQKIyBlbmQgb2YgQ1BVIElkbGUKCkNPTkZJR19JTlRFTF9JRExFPXkKIyBlbmQgb2YgUG93ZXIg
bWFuYWdlbWVudCBhbmQgQUNQSSBvcHRpb25zCgojCiMgQnVzIG9wdGlvbnMgKFBDSSBldGMuKQoj
CiMgQ09ORklHX1BDSV9HT0JJT1MgaXMgbm90IHNldAojIENPTkZJR19QQ0lfR09NTUNPTkZJRyBp
cyBub3Qgc2V0CiMgQ09ORklHX1BDSV9HT0RJUkVDVCBpcyBub3Qgc2V0CkNPTkZJR19QQ0lfR09B
Tlk9eQpDT05GSUdfUENJX0JJT1M9eQpDT05GSUdfUENJX0RJUkVDVD15CkNPTkZJR19QQ0lfTU1D
T05GSUc9eQojIENPTkZJR19QQ0lfQ05CMjBMRV9RVUlSSyBpcyBub3Qgc2V0CiMgQ09ORklHX0lT
QV9CVVMgaXMgbm90IHNldApDT05GSUdfSVNBX0RNQV9BUEk9eQojIENPTkZJR19JU0EgaXMgbm90
IHNldAojIENPTkZJR19TQ3gyMDAgaXMgbm90IHNldAojIENPTkZJR19BTElYIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUNTUwMSBpcyBub3Qgc2V0CiMgQ09ORklHX0dFT1MgaXMgbm90IHNldAojIGVu
ZCBvZiBCdXMgb3B0aW9ucyAoUENJIGV0Yy4pCgojCiMgQmluYXJ5IEVtdWxhdGlvbnMKIwpDT05G
SUdfQ09NUEFUXzMyPXkKIyBlbmQgb2YgQmluYXJ5IEVtdWxhdGlvbnMKCkNPTkZJR19IQVZFX0FU
T01JQ19JT01BUD15CiMgQ09ORklHX1ZJUlRVQUxJWkFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX0FT
X0FWWDUxMj15CkNPTkZJR19BU19TSEExX05JPXkKQ09ORklHX0FTX1NIQTI1Nl9OST15CkNPTkZJ
R19BU19UUEFVU0U9eQpDT05GSUdfQVNfR0ZOST15CkNPTkZJR19BU19WQUVTPXkKQ09ORklHX0FT
X1ZQQ0xNVUxRRFE9eQpDT05GSUdfQVNfV1JVU1M9eQpDT05GSUdfQVJDSF9DT05GSUdVUkVTX0NQ
VV9NSVRJR0FUSU9OUz15CgojCiMgR2VuZXJhbCBhcmNoaXRlY3R1cmUtZGVwZW5kZW50IG9wdGlv
bnMKIwpDT05GSUdfSE9UUExVR19TTVQ9eQpDT05GSUdfSE9UUExVR19DT1JFX1NZTkM9eQpDT05G
SUdfSE9UUExVR19DT1JFX1NZTkNfREVBRD15CkNPTkZJR19IT1RQTFVHX0NPUkVfU1lOQ19GVUxM
PXkKQ09ORklHX0hPVFBMVUdfU1BMSVRfU1RBUlRVUD15CkNPTkZJR19HRU5FUklDX0VOVFJZPXkK
IyBDT05GSUdfS1BST0JFUyBpcyBub3Qgc2V0CkNPTkZJR19KVU1QX0xBQkVMPXkKIyBDT05GSUdf
U1RBVElDX0tFWVNfU0VMRlRFU1QgaXMgbm90IHNldAojIENPTkZJR19TVEFUSUNfQ0FMTF9TRUxG
VEVTVCBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0VGRklDSUVOVF9VTkFMSUdORURfQUNDRVNTPXkK
Q09ORklHX0FSQ0hfVVNFX0JVSUxUSU5fQlNXQVA9eQpDT05GSUdfSEFWRV9JT1JFTUFQX1BST1Q9
eQpDT05GSUdfSEFWRV9LUFJPQkVTPXkKQ09ORklHX0hBVkVfS1JFVFBST0JFUz15CkNPTkZJR19I
QVZFX09QVFBST0JFUz15CkNPTkZJR19IQVZFX0tQUk9CRVNfT05fRlRSQUNFPXkKQ09ORklHX0FS
Q0hfQ09SUkVDVF9TVEFDS1RSQUNFX09OX0tSRVRQUk9CRT15CkNPTkZJR19IQVZFX0ZVTkNUSU9O
X0VSUk9SX0lOSkVDVElPTj15CkNPTkZJR19IQVZFX05NST15CkNPTkZJR19UUkFDRV9JUlFGTEFH
U19TVVBQT1JUPXkKQ09ORklHX1RSQUNFX0lSUUZMQUdTX05NSV9TVVBQT1JUPXkKQ09ORklHX0hB
VkVfQVJDSF9UUkFDRUhPT0s9eQpDT05GSUdfSEFWRV9ETUFfQ09OVElHVU9VUz15CkNPTkZJR19H
RU5FUklDX1NNUF9JRExFX1RIUkVBRD15CkNPTkZJR19BUkNIX0hBU19GT1JUSUZZX1NPVVJDRT15
CkNPTkZJR19BUkNIX0hBU19TRVRfTUVNT1JZPXkKQ09ORklHX0FSQ0hfSEFTX1NFVF9ESVJFQ1Rf
TUFQPXkKQ09ORklHX0FSQ0hfSEFTX0NQVV9GSU5BTElaRV9JTklUPXkKQ09ORklHX0hBVkVfQVJD
SF9USFJFQURfU1RSVUNUX1dISVRFTElTVD15CkNPTkZJR19BUkNIX1dBTlRTX0RZTkFNSUNfVEFT
S19TVFJVQ1Q9eQpDT05GSUdfQVJDSF9XQU5UU19OT19JTlNUUj15CkNPTkZJR19BUkNIXzMyQklU
X09GRl9UPXkKQ09ORklHX0hBVkVfQVNNX01PRFZFUlNJT05TPXkKQ09ORklHX0hBVkVfUkVHU19B
TkRfU1RBQ0tfQUNDRVNTX0FQST15CkNPTkZJR19IQVZFX1JTRVE9eQpDT05GSUdfSEFWRV9GVU5D
VElPTl9BUkdfQUNDRVNTX0FQST15CkNPTkZJR19IQVZFX0hXX0JSRUFLUE9JTlQ9eQpDT05GSUdf
SEFWRV9NSVhFRF9CUkVBS1BPSU5UU19SRUdTPXkKQ09ORklHX0hBVkVfVVNFUl9SRVRVUk5fTk9U
SUZJRVI9eQpDT05GSUdfSEFWRV9QRVJGX0VWRU5UU19OTUk9eQpDT05GSUdfSEFWRV9IQVJETE9D
S1VQX0RFVEVDVE9SX1BFUkY9eQpDT05GSUdfSEFWRV9QRVJGX1JFR1M9eQpDT05GSUdfSEFWRV9Q
RVJGX1VTRVJfU1RBQ0tfRFVNUD15CkNPTkZJR19IQVZFX0FSQ0hfSlVNUF9MQUJFTD15CkNPTkZJ
R19IQVZFX0FSQ0hfSlVNUF9MQUJFTF9SRUxBVElWRT15CkNPTkZJR19NTVVfR0FUSEVSX01FUkdF
X1ZNQVM9eQpDT05GSUdfTU1VX0xBWllfVExCX1JFRkNPVU5UPXkKQ09ORklHX0FSQ0hfSEFWRV9O
TUlfU0FGRV9DTVBYQ0hHPXkKQ09ORklHX0FSQ0hfSEFTX05NSV9TQUZFX1RISVNfQ1BVX09QUz15
CkNPTkZJR19IQVZFX0FMSUdORURfU1RSVUNUX1BBR0U9eQpDT05GSUdfSEFWRV9DTVBYQ0hHX0xP
Q0FMPXkKQ09ORklHX0hBVkVfQ01QWENIR19ET1VCTEU9eQpDT05GSUdfQVJDSF9XQU5UX0lQQ19Q
QVJTRV9WRVJTSU9OPXkKQ09ORklHX0hBVkVfQVJDSF9TRUNDT01QPXkKQ09ORklHX0hBVkVfQVJD
SF9TRUNDT01QX0ZJTFRFUj15CkNPTkZJR19TRUNDT01QPXkKQ09ORklHX1NFQ0NPTVBfRklMVEVS
PXkKIyBDT05GSUdfU0VDQ09NUF9DQUNIRV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0FS
Q0hfU1RBQ0tMRUFLPXkKQ09ORklHX0hBVkVfU1RBQ0tQUk9URUNUT1I9eQojIENPTkZJR19TVEFD
S1BST1RFQ1RPUiBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX1NVUFBPUlRTX0xUT19DTEFORz15CkNP
TkZJR19BUkNIX1NVUFBPUlRTX0xUT19DTEFOR19USElOPXkKQ09ORklHX0hBU19MVE9fQ0xBTkc9
eQpDT05GSUdfTFRPX05PTkU9eQojIENPTkZJR19MVE9fQ0xBTkdfRlVMTCBpcyBub3Qgc2V0CiMg
Q09ORklHX0xUT19DTEFOR19USElOIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfQVJDSF9XSVRISU5f
U1RBQ0tfRlJBTUVTPXkKQ09ORklHX0hBVkVfSVJRX1RJTUVfQUNDT1VOVElORz15CkNPTkZJR19I
QVZFX01PVkVfUFVEPXkKQ09ORklHX0hBVkVfTU9WRV9QTUQ9eQpDT05GSUdfSEFWRV9BUkNIX1RS
QU5TUEFSRU5UX0hVR0VQQUdFPXkKQ09ORklHX0hBVkVfQVJDSF9IVUdFX1ZNQVA9eQpDT05GSUdf
QVJDSF9XQU5UX0hVR0VfUE1EX1NIQVJFPXkKQ09ORklHX0FSQ0hfV0FOVF9QTURfTUtXUklURT15
CkNPTkZJR19IQVZFX01PRF9BUkNIX1NQRUNJRklDPXkKQ09ORklHX01PRFVMRVNfVVNFX0VMRl9S
RUw9eQpDT05GSUdfSEFWRV9TT0ZUSVJRX09OX09XTl9TVEFDSz15CkNPTkZJR19TT0ZUSVJRX09O
X09XTl9TVEFDSz15CkNPTkZJR19BUkNIX0hBU19FTEZfUkFORE9NSVpFPXkKQ09ORklHX0hBVkVf
QVJDSF9NTUFQX1JORF9CSVRTPXkKQ09ORklHX0hBVkVfRVhJVF9USFJFQUQ9eQpDT05GSUdfQVJD
SF9NTUFQX1JORF9CSVRTPTgKQ09ORklHX0hBVkVfUEFHRV9TSVpFXzRLQj15CkNPTkZJR19QQUdF
X1NJWkVfNEtCPXkKQ09ORklHX1BBR0VfU0laRV9MRVNTX1RIQU5fNjRLQj15CkNPTkZJR19QQUdF
X1NJWkVfTEVTU19USEFOXzI1NktCPXkKQ09ORklHX1BBR0VfU0hJRlQ9MTIKQ09ORklHX0NMT05F
X0JBQ0tXQVJEUz15CkNPTkZJR19PTERfU0lHU1VTUEVORDM9eQpDT05GSUdfT0xEX1NJR0FDVElP
Tj15CkNPTkZJR19DT01QQVRfMzJCSVRfVElNRT15CkNPTkZJR19IQVZFX0FSQ0hfUkFORE9NSVpF
X0tTVEFDS19PRkZTRVQ9eQpDT05GSUdfUkFORE9NSVpFX0tTVEFDS19PRkZTRVQ9eQpDT05GSUdf
UkFORE9NSVpFX0tTVEFDS19PRkZTRVRfREVGQVVMVD15CkNPTkZJR19BUkNIX0hBU19TVFJJQ1Rf
S0VSTkVMX1JXWD15CkNPTkZJR19TVFJJQ1RfS0VSTkVMX1JXWD15CkNPTkZJR19BUkNIX0hBU19T
VFJJQ1RfTU9EVUxFX1JXWD15CkNPTkZJR19TVFJJQ1RfTU9EVUxFX1JXWD15CkNPTkZJR19IQVZF
X0FSQ0hfUFJFTDMyX1JFTE9DQVRJT05TPXkKIyBDT05GSUdfTE9DS19FVkVOVF9DT1VOVFMgaXMg
bm90IHNldApDT05GSUdfQVJDSF9IQVNfTUVNX0VOQ1JZUFQ9eQpDT05GSUdfSEFWRV9TVEFUSUNf
Q0FMTD15CkNPTkZJR19IQVZFX1BSRUVNUFRfRFlOQU1JQz15CkNPTkZJR19IQVZFX1BSRUVNUFRf
RFlOQU1JQ19DQUxMPXkKQ09ORklHX0FSQ0hfV0FOVF9MRF9PUlBIQU5fV0FSTj15CkNPTkZJR19B
UkNIX1NVUFBPUlRTX0RFQlVHX1BBR0VBTExPQz15CkNPTkZJR19BUkNIX1NQTElUX0FSRzY0PXkK
Q09ORklHX0FSQ0hfSEFTX1BBUkFOT0lEX0wxRF9GTFVTSD15CkNPTkZJR19EWU5BTUlDX1NJR0ZS
QU1FPXkKQ09ORklHX0FSQ0hfSEFTX0hXX1BURV9ZT1VORz15CkNPTkZJR19BUkNIX0hBU19OT05M
RUFGX1BNRF9ZT1VORz15CkNPTkZJR19BUkNIX0hBU19LRVJORUxfRlBVX1NVUFBPUlQ9eQoKIwoj
IEdDT1YtYmFzZWQga2VybmVsIHByb2ZpbGluZwojCiMgQ09ORklHX0dDT1ZfS0VSTkVMIGlzIG5v
dCBzZXQKQ09ORklHX0FSQ0hfSEFTX0dDT1ZfUFJPRklMRV9BTEw9eQojIGVuZCBvZiBHQ09WLWJh
c2VkIGtlcm5lbCBwcm9maWxpbmcKCkNPTkZJR19IQVZFX0dDQ19QTFVHSU5TPXkKQ09ORklHX0ZV
TkNUSU9OX0FMSUdOTUVOVF80Qj15CkNPTkZJR19GVU5DVElPTl9BTElHTk1FTlQ9NApDT05GSUdf
Q0NfSEFTX1NBTkVfRlVOQ1RJT05fQUxJR05NRU5UPXkKIyBlbmQgb2YgR2VuZXJhbCBhcmNoaXRl
Y3R1cmUtZGVwZW5kZW50IG9wdGlvbnMKCkNPTkZJR19SVF9NVVRFWEVTPXkKQ09ORklHX01PRFVM
RVM9eQojIENPTkZJR19NT0RVTEVfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfRk9S
Q0VfTE9BRCBpcyBub3Qgc2V0CkNPTkZJR19NT0RVTEVfVU5MT0FEPXkKQ09ORklHX01PRFVMRV9G
T1JDRV9VTkxPQUQ9eQojIENPTkZJR19NT0RVTEVfVU5MT0FEX1RBSU5UX1RSQUNLSU5HIGlzIG5v
dCBzZXQKIyBDT05GSUdfTU9EVkVSU0lPTlMgaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfU1JD
VkVSU0lPTl9BTEwgaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfU0lHIGlzIG5vdCBzZXQKQ09O
RklHX01PRFVMRV9DT01QUkVTU19OT05FPXkKIyBDT05GSUdfTU9EVUxFX0NPTVBSRVNTX0daSVAg
aXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfQ09NUFJFU1NfWFogaXMgbm90IHNldAojIENPTkZJ
R19NT0RVTEVfQ09NUFJFU1NfWlNURCBpcyBub3Qgc2V0CiMgQ09ORklHX01PRFVMRV9BTExPV19N
SVNTSU5HX05BTUVTUEFDRV9JTVBPUlRTIGlzIG5vdCBzZXQKQ09ORklHX01PRFBST0JFX1BBVEg9
Ii9zYmluL21vZHByb2JlIgojIENPTkZJR19UUklNX1VOVVNFRF9LU1lNUyBpcyBub3Qgc2V0CkNP
TkZJR19NT0RVTEVTX1RSRUVfTE9PS1VQPXkKQ09ORklHX0JMT0NLPXkKQ09ORklHX0JMT0NLX0xF
R0FDWV9BVVRPTE9BRD15CkNPTkZJR19CTEtfQ0dST1VQX1JXU1RBVD15CkNPTkZJR19CTEtfQ0dS
T1VQX1BVTlRfQklPPXkKQ09ORklHX0JMS19ERVZfQlNHX0NPTU1PTj15CkNPTkZJR19CTEtfSUNR
PXkKIyBDT05GSUdfQkxLX0RFVl9CU0dMSUIgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lO
VEVHUklUWSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfV1JJVEVfTU9VTlRFRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0JMS19ERVZfWk9ORUQgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1RI
Uk9UVExJTkcgaXMgbm90IHNldApDT05GSUdfQkxLX1dCVD15CkNPTkZJR19CTEtfV0JUX01RPXkK
IyBDT05GSUdfQkxLX0NHUk9VUF9JT0xBVEVOQ1kgaXMgbm90IHNldAojIENPTkZJR19CTEtfQ0dS
T1VQX0lPQ09TVCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19DR1JPVVBfSU9QUklPIGlzIG5vdCBz
ZXQKQ09ORklHX0JMS19ERUJVR19GUz15CiMgQ09ORklHX0JMS19TRURfT1BBTCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JMS19JTkxJTkVfRU5DUllQVElPTiBpcyBub3Qgc2V0CgojCiMgUGFydGl0aW9u
IFR5cGVzCiMKQ09ORklHX1BBUlRJVElPTl9BRFZBTkNFRD15CiMgQ09ORklHX0FDT1JOX1BBUlRJ
VElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FJWF9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJ
R19PU0ZfUEFSVElUSU9OIGlzIG5vdCBzZXQKQ09ORklHX0FNSUdBX1BBUlRJVElPTj15CiMgQ09O
RklHX0FUQVJJX1BBUlRJVElPTiBpcyBub3Qgc2V0CkNPTkZJR19NQUNfUEFSVElUSU9OPXkKQ09O
RklHX01TRE9TX1BBUlRJVElPTj15CkNPTkZJR19CU0RfRElTS0xBQkVMPXkKIyBDT05GSUdfTUlO
SVhfU1VCUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfU09MQVJJU19YODZfUEFSVElUSU9O
IGlzIG5vdCBzZXQKIyBDT05GSUdfVU5JWFdBUkVfRElTS0xBQkVMIGlzIG5vdCBzZXQKQ09ORklH
X0xETV9QQVJUSVRJT049eQojIENPTkZJR19MRE1fREVCVUcgaXMgbm90IHNldAojIENPTkZJR19T
R0lfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfVUxUUklYX1BBUlRJVElPTiBpcyBub3Qg
c2V0CiMgQ09ORklHX1NVTl9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19LQVJNQV9QQVJU
SVRJT04gaXMgbm90IHNldApDT05GSUdfRUZJX1BBUlRJVElPTj15CiMgQ09ORklHX1NZU1Y2OF9Q
QVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19DTURMSU5FX1BBUlRJVElPTiBpcyBub3Qgc2V0
CiMgZW5kIG9mIFBhcnRpdGlvbiBUeXBlcwoKQ09ORklHX0JMS19NUV9QQ0k9eQpDT05GSUdfQkxL
X01RX1ZJUlRJTz15CkNPTkZJR19CTEtfUE09eQpDT05GSUdfQkxPQ0tfSE9MREVSX0RFUFJFQ0FU
RUQ9eQpDT05GSUdfQkxLX01RX1NUQUNLSU5HPXkKCiMKIyBJTyBTY2hlZHVsZXJzCiMKIyBDT05G
SUdfTVFfSU9TQ0hFRF9ERUFETElORSBpcyBub3Qgc2V0CiMgQ09ORklHX01RX0lPU0NIRURfS1lC
RVIgaXMgbm90IHNldApDT05GSUdfSU9TQ0hFRF9CRlE9eQpDT05GSUdfQkZRX0dST1VQX0lPU0NI
RUQ9eQojIENPTkZJR19CRlFfQ0dST1VQX0RFQlVHIGlzIG5vdCBzZXQKIyBlbmQgb2YgSU8gU2No
ZWR1bGVycwoKQ09ORklHX1BBREFUQT15CkNPTkZJR19BU04xPXkKQ09ORklHX1VOSU5MSU5FX1NQ
SU5fVU5MT0NLPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfQVRPTUlDX1JNVz15CkNPTkZJR19NVVRF
WF9TUElOX09OX09XTkVSPXkKQ09ORklHX1JXU0VNX1NQSU5fT05fT1dORVI9eQpDT05GSUdfTE9D
S19TUElOX09OX09XTkVSPXkKQ09ORklHX0FSQ0hfVVNFX1FVRVVFRF9TUElOTE9DS1M9eQpDT05G
SUdfUVVFVUVEX1NQSU5MT0NLUz15CkNPTkZJR19BUkNIX1VTRV9RVUVVRURfUldMT0NLUz15CkNP
TkZJR19RVUVVRURfUldMT0NLUz15CkNPTkZJR19BUkNIX0hBU19OT05fT1ZFUkxBUFBJTkdfQURE
UkVTU19TUEFDRT15CkNPTkZJR19BUkNIX0hBU19TWU5DX0NPUkVfQkVGT1JFX1VTRVJNT0RFPXkK
Q09ORklHX0FSQ0hfSEFTX1NZU0NBTExfV1JBUFBFUj15CkNPTkZJR19GUkVFWkVSPXkKCiMKIyBF
eGVjdXRhYmxlIGZpbGUgZm9ybWF0cwojCkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0VMRkNP
UkU9eQpDT05GSUdfQ09SRV9EVU1QX0RFRkFVTFRfRUxGX0hFQURFUlM9eQpDT05GSUdfQklORk1U
X1NDUklQVD15CkNPTkZJR19CSU5GTVRfTUlTQz15CkNPTkZJR19DT1JFRFVNUD15CiMgZW5kIG9m
IEV4ZWN1dGFibGUgZmlsZSBmb3JtYXRzCgojCiMgTWVtb3J5IE1hbmFnZW1lbnQgb3B0aW9ucwoj
CkNPTkZJR19aUE9PTD15CkNPTkZJR19TV0FQPXkKQ09ORklHX1pTV0FQPXkKQ09ORklHX1pTV0FQ
X0RFRkFVTFRfT049eQpDT05GSUdfWlNXQVBfU0hSSU5LRVJfREVGQVVMVF9PTj15CiMgQ09ORklH
X1pTV0FQX0NPTVBSRVNTT1JfREVGQVVMVF9ERUZMQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfWlNX
QVBfQ09NUFJFU1NPUl9ERUZBVUxUX0xaTyBpcyBub3Qgc2V0CiMgQ09ORklHX1pTV0FQX0NPTVBS
RVNTT1JfREVGQVVMVF84NDIgaXMgbm90IHNldAojIENPTkZJR19aU1dBUF9DT01QUkVTU09SX0RF
RkFVTFRfTFo0IGlzIG5vdCBzZXQKIyBDT05GSUdfWlNXQVBfQ09NUFJFU1NPUl9ERUZBVUxUX0xa
NEhDIGlzIG5vdCBzZXQKQ09ORklHX1pTV0FQX0NPTVBSRVNTT1JfREVGQVVMVF9aU1REPXkKQ09O
RklHX1pTV0FQX0NPTVBSRVNTT1JfREVGQVVMVD0ienN0ZCIKIyBDT05GSUdfWlNXQVBfWlBPT0xf
REVGQVVMVF9aQlVEIGlzIG5vdCBzZXQKIyBDT05GSUdfWlNXQVBfWlBPT0xfREVGQVVMVF9aM0ZP
TEQgaXMgbm90IHNldApDT05GSUdfWlNXQVBfWlBPT0xfREVGQVVMVF9aU01BTExPQz15CkNPTkZJ
R19aU1dBUF9aUE9PTF9ERUZBVUxUPSJ6c21hbGxvYyIKIyBDT05GSUdfWkJVRCBpcyBub3Qgc2V0
CiMgQ09ORklHX1ozRk9MRCBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX1pTTUFMTE9DPXkKQ09ORklH
X1pTTUFMTE9DPXkKIyBDT05GSUdfWlNNQUxMT0NfU1RBVCBpcyBub3Qgc2V0CkNPTkZJR19aU01B
TExPQ19DSEFJTl9TSVpFPTgKCiMKIyBTbGFiIGFsbG9jYXRvciBvcHRpb25zCiMKQ09ORklHX1NM
VUI9eQojIENPTkZJR19TTFVCX1RJTlkgaXMgbm90IHNldApDT05GSUdfU0xBQl9NRVJHRV9ERUZB
VUxUPXkKQ09ORklHX1NMQUJfRlJFRUxJU1RfUkFORE9NPXkKQ09ORklHX1NMQUJfRlJFRUxJU1Rf
SEFSREVORUQ9eQpDT05GSUdfU0xBQl9CVUNLRVRTPXkKIyBDT05GSUdfU0xVQl9TVEFUUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NMVUJfQ1BVX1BBUlRJQUwgaXMgbm90IHNldAojIENPTkZJR19SQU5E
T01fS01BTExPQ19DQUNIRVMgaXMgbm90IHNldAojIGVuZCBvZiBTbGFiIGFsbG9jYXRvciBvcHRp
b25zCgpDT05GSUdfU0hVRkZMRV9QQUdFX0FMTE9DQVRPUj15CiMgQ09ORklHX0NPTVBBVF9CUksg
aXMgbm90IHNldApDT05GSUdfU0VMRUNUX01FTU9SWV9NT0RFTD15CkNPTkZJR19GTEFUTUVNX01B
TlVBTD15CiMgQ09ORklHX1NQQVJTRU1FTV9NQU5VQUwgaXMgbm90IHNldApDT05GSUdfRkxBVE1F
TT15CkNPTkZJR19TUEFSU0VNRU1fU1RBVElDPXkKQ09ORklHX0hBVkVfR1VQX0ZBU1Q9eQpDT05G
SUdfRVhDTFVTSVZFX1NZU1RFTV9SQU09eQpDT05GSUdfQVJDSF9NSFBfTUVNTUFQX09OX01FTU9S
WV9FTkFCTEU9eQpDT05GSUdfU1BMSVRfUFRMT0NLX0NQVVM9NApDT05GSUdfQVJDSF9FTkFCTEVf
U1BMSVRfUE1EX1BUTE9DSz15CkNPTkZJR19DT01QQUNUSU9OPXkKQ09ORklHX0NPTVBBQ1RfVU5F
VklDVEFCTEVfREVGQVVMVD0xCkNPTkZJR19QQUdFX1JFUE9SVElORz15CkNPTkZJR19NSUdSQVRJ
T049eQpDT05GSUdfUENQX0JBVENIX1NDQUxFX01BWD01CkNPTkZJR19QSFlTX0FERFJfVF82NEJJ
VD15CkNPTkZJR19CT1VOQ0U9eQpDT05GSUdfTU1VX05PVElGSUVSPXkKQ09ORklHX0tTTT15CkNP
TkZJR19ERUZBVUxUX01NQVBfTUlOX0FERFI9MzI3NjgKQ09ORklHX0FSQ0hfU1VQUE9SVFNfTUVN
T1JZX0ZBSUxVUkU9eQojIENPTkZJR19NRU1PUllfRkFJTFVSRSBpcyBub3Qgc2V0CkNPTkZJR19B
UkNIX1dBTlRfR0VORVJBTF9IVUdFVExCPXkKQ09ORklHX1RSQU5TUEFSRU5UX0hVR0VQQUdFPXkK
IyBDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0VfQUxXQVlTIGlzIG5vdCBzZXQKQ09ORklHX1RS
QU5TUEFSRU5UX0hVR0VQQUdFX01BRFZJU0U9eQojIENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFH
RV9ORVZFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1JFQURfT05MWV9USFBfRk9SX0ZTIGlzIG5vdCBz
ZXQKQ09ORklHX1BHVEFCTEVfSEFTX0hVR0VfTEVBVkVTPXkKQ09ORklHX05FRURfUEVSX0NQVV9F
TUJFRF9GSVJTVF9DSFVOSz15CkNPTkZJR19ORUVEX1BFUl9DUFVfUEFHRV9GSVJTVF9DSFVOSz15
CkNPTkZJR19IQVZFX1NFVFVQX1BFUl9DUFVfQVJFQT15CiMgQ09ORklHX0NNQSBpcyBub3Qgc2V0
CkNPTkZJR19HRU5FUklDX0VBUkxZX0lPUkVNQVA9eQpDT05GSUdfUEFHRV9JRExFX0ZMQUc9eQpD
T05GSUdfSURMRV9QQUdFX1RSQUNLSU5HPXkKQ09ORklHX0FSQ0hfSEFTX0NBQ0hFX0xJTkVfU0la
RT15CkNPTkZJR19BUkNIX0hBU19DVVJSRU5UX1NUQUNLX1BPSU5URVI9eQpDT05GSUdfQVJDSF9I
QVNfWk9ORV9ETUFfU0VUPXkKQ09ORklHX1pPTkVfRE1BPXkKQ09ORklHX1ZNX0VWRU5UX0NPVU5U
RVJTPXkKIyBDT05GSUdfUEVSQ1BVX1NUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfR1VQX1RFU1Qg
aXMgbm90IHNldApDT05GSUdfR1VQX0dFVF9QWFhfTE9XX0hJR0g9eQojIENPTkZJR19ETUFQT09M
X1RFU1QgaXMgbm90IHNldApDT05GSUdfQVJDSF9IQVNfUFRFX1NQRUNJQUw9eQpDT05GSUdfS01B
UF9MT0NBTD15CkNPTkZJR19NRU1GRF9DUkVBVEU9eQpDT05GSUdfU0VDUkVUTUVNPXkKIyBDT05G
SUdfQU5PTl9WTUFfTkFNRSBpcyBub3Qgc2V0CkNPTkZJR19VU0VSRkFVTFRGRD15CkNPTkZJR19M
UlVfR0VOPXkKQ09ORklHX0xSVV9HRU5fRU5BQkxFRD15CiMgQ09ORklHX0xSVV9HRU5fU1RBVFMg
aXMgbm90IHNldApDT05GSUdfTFJVX0dFTl9XQUxLU19NTVU9eQpDT05GSUdfTE9DS19NTV9BTkRf
RklORF9WTUE9eQpDT05GSUdfRVhFQ01FTT15CgojCiMgRGF0YSBBY2Nlc3MgTW9uaXRvcmluZwoj
CiMgQ09ORklHX0RBTU9OIGlzIG5vdCBzZXQKIyBlbmQgb2YgRGF0YSBBY2Nlc3MgTW9uaXRvcmlu
ZwojIGVuZCBvZiBNZW1vcnkgTWFuYWdlbWVudCBvcHRpb25zCgpDT05GSUdfTkVUPXkKQ09ORklH
X05FVF9JTkdSRVNTPXkKQ09ORklHX05FVF9FR1JFU1M9eQpDT05GSUdfTkVUX1hHUkVTUz15CkNP
TkZJR19TS0JfREVDUllQVEVEPXkKQ09ORklHX1NLQl9FWFRFTlNJT05TPXkKCiMKIyBOZXR3b3Jr
aW5nIG9wdGlvbnMKIwpDT05GSUdfUEFDS0VUPW0KQ09ORklHX1BBQ0tFVF9ESUFHPW0KQ09ORklH
X1VOSVg9eQpDT05GSUdfQUZfVU5JWF9PT0I9eQpDT05GSUdfVU5JWF9ESUFHPW0KQ09ORklHX1RM
Uz1tCkNPTkZJR19UTFNfREVWSUNFPXkKIyBDT05GSUdfVExTX1RPRSBpcyBub3Qgc2V0CkNPTkZJ
R19YRlJNPXkKQ09ORklHX1hGUk1fQUxHTz1tCkNPTkZJR19YRlJNX1VTRVI9bQojIENPTkZJR19Y
RlJNX0lOVEVSRkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1hGUk1fU1VCX1BPTElDWSBpcyBub3Qg
c2V0CiMgQ09ORklHX1hGUk1fTUlHUkFURSBpcyBub3Qgc2V0CiMgQ09ORklHX1hGUk1fU1RBVElT
VElDUyBpcyBub3Qgc2V0CkNPTkZJR19YRlJNX0FIPW0KQ09ORklHX1hGUk1fRVNQPW0KQ09ORklH
X1hGUk1fSVBDT01QPW0KQ09ORklHX05FVF9LRVk9bQojIENPTkZJR19ORVRfS0VZX01JR1JBVEUg
aXMgbm90IHNldAojIENPTkZJR19YRFBfU09DS0VUUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRfSEFO
RFNIQUtFPXkKQ09ORklHX05FVF9IQU5EU0hBS0VfS1VOSVRfVEVTVD1tCkNPTkZJR19JTkVUPXkK
IyBDT05GSUdfSVBfTVVMVElDQVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfQURWQU5DRURfUk9V
VEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfUE5QIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lQ
SVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfSVBHUkVfREVNVVggaXMgbm90IHNldApDT05GSUdf
TkVUX0lQX1RVTk5FTD1tCkNPTkZJR19TWU5fQ09PS0lFUz15CiMgQ09ORklHX05FVF9JUFZUSSBp
cyBub3Qgc2V0CkNPTkZJR19ORVRfVURQX1RVTk5FTD1tCiMgQ09ORklHX05FVF9GT1UgaXMgbm90
IHNldApDT05GSUdfSU5FVF9BSD1tCkNPTkZJR19JTkVUX0VTUD1tCiMgQ09ORklHX0lORVRfRVNQ
X09GRkxPQUQgaXMgbm90IHNldAojIENPTkZJR19JTkVUX0VTUElOVENQIGlzIG5vdCBzZXQKQ09O
RklHX0lORVRfSVBDT01QPW0KQ09ORklHX0lORVRfVEFCTEVfUEVSVFVSQl9PUkRFUj0xNgpDT05G
SUdfSU5FVF9YRlJNX1RVTk5FTD1tCkNPTkZJR19JTkVUX1RVTk5FTD1tCiMgQ09ORklHX0lORVRf
RElBRyBpcyBub3Qgc2V0CkNPTkZJR19UQ1BfQ09OR19BRFZBTkNFRD15CiMgQ09ORklHX1RDUF9D
T05HX0JJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX0NVQklDIGlzIG5vdCBzZXQKQ09O
RklHX1RDUF9DT05HX1dFU1RXT09EPXkKIyBDT05GSUdfVENQX0NPTkdfSFRDUCBpcyBub3Qgc2V0
CiMgQ09ORklHX1RDUF9DT05HX0hTVENQIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfSFlC
TEEgaXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19WRUdBUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1RDUF9DT05HX05WIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfU0NBTEFCTEUgaXMgbm90
IHNldAojIENPTkZJR19UQ1BfQ09OR19MUCBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX1ZF
Tk8gaXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19ZRUFIIGlzIG5vdCBzZXQKIyBDT05GSUdf
VENQX0NPTkdfSUxMSU5PSVMgaXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19EQ1RDUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX0NERyBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05H
X0JCUiBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX1dFU1RXT09EPXkKIyBDT05GSUdfREVGQVVM
VF9SRU5PIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfVENQX0NPTkc9Indlc3R3b29kIgojIENP
TkZJR19UQ1BfTUQ1U0lHIGlzIG5vdCBzZXQKQ09ORklHX0lQVjY9eQojIENPTkZJR19JUFY2X1JP
VVRFUl9QUkVGIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWNl9PUFRJTUlTVElDX0RBRCBpcyBub3Qg
c2V0CkNPTkZJR19JTkVUNl9BSD1tCkNPTkZJR19JTkVUNl9FU1A9bQojIENPTkZJR19JTkVUNl9F
U1BfT0ZGTE9BRCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVQ2X0VTUElOVENQIGlzIG5vdCBzZXQK
Q09ORklHX0lORVQ2X0lQQ09NUD1tCiMgQ09ORklHX0lQVjZfTUlQNiBpcyBub3Qgc2V0CkNPTkZJ
R19JTkVUNl9YRlJNX1RVTk5FTD1tCkNPTkZJR19JTkVUNl9UVU5ORUw9bQojIENPTkZJR19JUFY2
X1ZUSSBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfU0lUIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBW
Nl9UVU5ORUwgaXMgbm90IHNldAojIENPTkZJR19JUFY2X01VTFRJUExFX1RBQkxFUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0lQVjZfTVJPVVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWNl9TRUc2X0xX
VFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWNl9TRUc2X0hNQUMgaXMgbm90IHNldAojIENP
TkZJR19JUFY2X1JQTF9MV1RVTk5FTCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfSU9BTTZfTFdU
VU5ORUwgaXMgbm90IHNldAojIENPTkZJR19ORVRMQUJFTCBpcyBub3Qgc2V0CiMgQ09ORklHX01Q
VENQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUV09SS19TRUNNQVJLIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUV09SS19QSFlfVElNRVNUQU1QSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVS
IGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfRENDUCBpcyBub3Qgc2V0CkNPTkZJR19JUF9TQ1RQPW0K
IyBDT05GSUdfU0NUUF9EQkdfT0JKQ05UIGlzIG5vdCBzZXQKQ09ORklHX1NDVFBfREVGQVVMVF9D
T09LSUVfSE1BQ19NRDU9eQojIENPTkZJR19TQ1RQX0RFRkFVTFRfQ09PS0lFX0hNQUNfU0hBMSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDVFBfREVGQVVMVF9DT09LSUVfSE1BQ19OT05FIGlzIG5vdCBz
ZXQKQ09ORklHX1NDVFBfQ09PS0lFX0hNQUNfTUQ1PXkKIyBDT05GSUdfU0NUUF9DT09LSUVfSE1B
Q19TSEExIGlzIG5vdCBzZXQKIyBDT05GSUdfUkRTIGlzIG5vdCBzZXQKIyBDT05GSUdfVElQQyBp
cyBub3Qgc2V0CiMgQ09ORklHX0FUTSBpcyBub3Qgc2V0CiMgQ09ORklHX0wyVFAgaXMgbm90IHNl
dApDT05GSUdfU1RQPW0KQ09ORklHX0JSSURHRT1tCkNPTkZJR19CUklER0VfSUdNUF9TTk9PUElO
Rz15CiMgQ09ORklHX0JSSURHRV9NUlAgaXMgbm90IHNldAojIENPTkZJR19CUklER0VfQ0ZNIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX0RTQSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZMQU5fODAyMVEg
aXMgbm90IHNldApDT05GSUdfTExDPW0KIyBDT05GSUdfTExDMiBpcyBub3Qgc2V0CiMgQ09ORklH
X0FUQUxLIGlzIG5vdCBzZXQKIyBDT05GSUdfWDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTEFQQiBp
cyBub3Qgc2V0CiMgQ09ORklHX1BIT05FVCBpcyBub3Qgc2V0CiMgQ09ORklHXzZMT1dQQU4gaXMg
bm90IHNldAojIENPTkZJR19JRUVFODAyMTU0IGlzIG5vdCBzZXQKQ09ORklHX05FVF9TQ0hFRD15
CgojCiMgUXVldWVpbmcvU2NoZWR1bGluZwojCiMgQ09ORklHX05FVF9TQ0hfSFRCIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1NDSF9IRlNDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9QUklP
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9NVUxUSVEgaXMgbm90IHNldAojIENPTkZJR19O
RVRfU0NIX1JFRCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfU0ZCIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX1NDSF9TRlEgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX1RFUUwgaXMgbm90
IHNldAojIENPTkZJR19ORVRfU0NIX1RCRiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfQ0JT
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9FVEYgaXMgbm90IHNldAojIENPTkZJR19ORVRf
U0NIX1RBUFJJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfR1JFRCBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9TQ0hfTkVURU0gaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX0RSUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfTVFQUklPIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ND
SF9TS0JQUklPIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9DSE9LRSBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9TQ0hfUUZRIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9DT0RFTCBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRfU0NIX0ZRX0NPREVMPXkKIyBDT05GSUdfTkVUX1NDSF9DQUtFIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9GUSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hf
SEhGIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9QSUUgaXMgbm90IHNldAojIENPTkZJR19O
RVRfU0NIX1BMVUcgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX0VUUyBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfU0NIX0RFRkFVTFQ9eQpDT05GSUdfREVGQVVMVF9GUV9DT0RFTD15CiMgQ09ORklH
X0RFRkFVTFRfUEZJRk9fRkFTVCBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX05FVF9TQ0g9ImZx
X2NvZGVsIgoKIwojIENsYXNzaWZpY2F0aW9uCiMKIyBDT05GSUdfTkVUX0NMU19CQVNJQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfUk9VVEU0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NM
U19GVyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfVTMyIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX0NMU19GTE9XIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19DR1JPVVAgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfQ0xTX0JQRiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfRkxPV0VS
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19NQVRDSEFMTCBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9FTUFUQ0ggaXMgbm90IHNldAojIENPTkZJR19ORVRfQ0xTX0FDVCBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfU0NIX0ZJRk89eQojIENPTkZJR19EQ0IgaXMgbm90IHNldApDT05GSUdfRE5TX1JF
U09MVkVSPW0KIyBDT05GSUdfQkFUTUFOX0FEViBpcyBub3Qgc2V0CiMgQ09ORklHX09QRU5WU1dJ
VENIIGlzIG5vdCBzZXQKQ09ORklHX1ZTT0NLRVRTPW0KQ09ORklHX1ZTT0NLRVRTX0RJQUc9bQoj
IENPTkZJR19WU09DS0VUU19MT09QQkFDSyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJUlRJT19WU09D
S0VUUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVExJTktfRElBRyBpcyBub3Qgc2V0CiMgQ09ORklH
X01QTFMgaXMgbm90IHNldAojIENPTkZJR19ORVRfTlNIIGlzIG5vdCBzZXQKIyBDT05GSUdfSFNS
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NXSVRDSERFViBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9MM19NQVNURVJfREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfUVJUUiBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9OQ1NJIGlzIG5vdCBzZXQKQ09ORklHX1BDUFVfREVWX1JFRkNOVD15CkNPTkZJR19N
QVhfU0tCX0ZSQUdTPTE3CkNPTkZJR19SUFM9eQpDT05GSUdfUkZTX0FDQ0VMPXkKQ09ORklHX1NP
Q0tfUlhfUVVFVUVfTUFQUElORz15CkNPTkZJR19YUFM9eQojIENPTkZJR19DR1JPVVBfTkVUX1BS
SU8gaXMgbm90IHNldApDT05GSUdfQ0dST1VQX05FVF9DTEFTU0lEPXkKQ09ORklHX05FVF9SWF9C
VVNZX1BPTEw9eQpDT05GSUdfQlFMPXkKQ09ORklHX0JQRl9TVFJFQU1fUEFSU0VSPXkKQ09ORklH
X05FVF9GTE9XX0xJTUlUPXkKCiMKIyBOZXR3b3JrIHRlc3RpbmcKIwojIENPTkZJR19ORVRfUEtU
R0VOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0RST1BfTU9OSVRPUiBpcyBub3Qgc2V0CiMgZW5k
IG9mIE5ldHdvcmsgdGVzdGluZwojIGVuZCBvZiBOZXR3b3JraW5nIG9wdGlvbnMKCiMgQ09ORklH
X0hBTVJBRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FOIGlzIG5vdCBzZXQKQ09ORklHX0JUPW0K
Q09ORklHX0JUX0JSRURSPXkKQ09ORklHX0JUX1JGQ09NTT1tCkNPTkZJR19CVF9SRkNPTU1fVFRZ
PXkKQ09ORklHX0JUX0JORVA9bQpDT05GSUdfQlRfQk5FUF9NQ19GSUxURVI9eQpDT05GSUdfQlRf
Qk5FUF9QUk9UT19GSUxURVI9eQpDT05GSUdfQlRfSElEUD1tCkNPTkZJR19CVF9MRT15CkNPTkZJ
R19CVF9MRV9MMkNBUF9FQ1JFRD15CkNPTkZJR19CVF9MRURTPXkKQ09ORklHX0JUX01TRlRFWFQ9
eQpDT05GSUdfQlRfQU9TUEVYVD15CkNPTkZJR19CVF9ERUJVR0ZTPXkKIyBDT05GSUdfQlRfU0VM
RlRFU1QgaXMgbm90IHNldApDT05GSUdfQlRfRkVBVFVSRV9ERUJVRz15CgojCiMgQmx1ZXRvb3Ro
IGRldmljZSBkcml2ZXJzCiMKQ09ORklHX0JUX0lOVEVMPW0KQ09ORklHX0JUX0JDTT1tCkNPTkZJ
R19CVF9SVEw9bQpDT05GSUdfQlRfTVRLPW0KQ09ORklHX0JUX0hDSUJUVVNCPW0KQ09ORklHX0JU
X0hDSUJUVVNCX0FVVE9TVVNQRU5EPXkKQ09ORklHX0JUX0hDSUJUVVNCX1BPTExfU1lOQz15CkNP
TkZJR19CVF9IQ0lCVFVTQl9CQ009eQpDT05GSUdfQlRfSENJQlRVU0JfTVRLPXkKQ09ORklHX0JU
X0hDSUJUVVNCX1JUTD15CkNPTkZJR19CVF9IQ0lVQVJUPW0KQ09ORklHX0JUX0hDSVVBUlRfSDQ9
eQpDT05GSUdfQlRfSENJVUFSVF9CQ1NQPXkKQ09ORklHX0JUX0hDSVVBUlRfQVRIM0s9eQojIENP
TkZJR19CVF9IQ0lVQVJUX0lOVEVMIGlzIG5vdCBzZXQKQ09ORklHX0JUX0hDSVVBUlRfQUc2WFg9
eQpDT05GSUdfQlRfSENJQkNNMjAzWD1tCiMgQ09ORklHX0JUX0hDSUJDTTQzNzcgaXMgbm90IHNl
dAojIENPTkZJR19CVF9IQ0lCUEExMFggaXMgbm90IHNldApDT05GSUdfQlRfSENJQkZVU0I9bQoj
IENPTkZJR19CVF9IQ0lEVEwxIGlzIG5vdCBzZXQKIyBDT05GSUdfQlRfSENJQlQzQyBpcyBub3Qg
c2V0CiMgQ09ORklHX0JUX0hDSUJMVUVDQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQlRfSENJVkhD
SSBpcyBub3Qgc2V0CkNPTkZJR19CVF9NUlZMPW0KQ09ORklHX0JUX0FUSDNLPW0KIyBDT05GSUdf
QlRfVklSVElPIGlzIG5vdCBzZXQKIyBDT05GSUdfQlRfSU5URUxfUENJRSBpcyBub3Qgc2V0CiMg
ZW5kIG9mIEJsdWV0b290aCBkZXZpY2UgZHJpdmVycwoKIyBDT05GSUdfQUZfUlhSUEMgaXMgbm90
IHNldAojIENPTkZJR19BRl9LQ00gaXMgbm90IHNldApDT05GSUdfU1RSRUFNX1BBUlNFUj15CiMg
Q09ORklHX01DVFAgaXMgbm90IHNldApDT05GSUdfV0lSRUxFU1M9eQpDT05GSUdfQ0ZHODAyMTE9
bQojIENPTkZJR19OTDgwMjExX1RFU1RNT0RFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0ZHODAyMTFf
REVWRUxPUEVSX1dBUk5JTkdTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0ZHODAyMTFfQ0VSVElGSUNB
VElPTl9PTlVTIGlzIG5vdCBzZXQKQ09ORklHX0NGRzgwMjExX1JFUVVJUkVfU0lHTkVEX1JFR0RC
PXkKQ09ORklHX0NGRzgwMjExX1VTRV9LRVJORUxfUkVHREJfS0VZUz15CkNPTkZJR19DRkc4MDIx
MV9ERUZBVUxUX1BTPXkKIyBDT05GSUdfQ0ZHODAyMTFfREVCVUdGUyBpcyBub3Qgc2V0CkNPTkZJ
R19DRkc4MDIxMV9DUkRBX1NVUFBPUlQ9eQojIENPTkZJR19DRkc4MDIxMV9XRVhUIGlzIG5vdCBz
ZXQKQ09ORklHX0NGRzgwMjExX0tVTklUX1RFU1Q9bQpDT05GSUdfTUFDODAyMTE9bQpDT05GSUdf
TUFDODAyMTFfSEFTX1JDPXkKQ09ORklHX01BQzgwMjExX1JDX01JTlNUUkVMPXkKQ09ORklHX01B
QzgwMjExX1JDX0RFRkFVTFRfTUlOU1RSRUw9eQpDT05GSUdfTUFDODAyMTFfUkNfREVGQVVMVD0i
bWluc3RyZWxfaHQiCkNPTkZJR19NQUM4MDIxMV9LVU5JVF9URVNUPW0KIyBDT05GSUdfTUFDODAy
MTFfTUVTSCBpcyBub3Qgc2V0CkNPTkZJR19NQUM4MDIxMV9MRURTPXkKIyBDT05GSUdfTUFDODAy
MTFfTUVTU0FHRV9UUkFDSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDODAyMTFfREVCVUdfTUVO
VSBpcyBub3Qgc2V0CkNPTkZJR19NQUM4MDIxMV9TVEFfSEFTSF9NQVhfU0laRT0wCkNPTkZJR19S
RktJTEw9bQpDT05GSUdfUkZLSUxMX0xFRFM9eQojIENPTkZJR19SRktJTExfSU5QVVQgaXMgbm90
IHNldAojIENPTkZJR19SRktJTExfR1BJTyBpcyBub3Qgc2V0CkNPTkZJR19ORVRfOVA9eQpDT05G
SUdfTkVUXzlQX0ZEPXkKQ09ORklHX05FVF85UF9WSVJUSU89eQojIENPTkZJR19ORVRfOVBfREVC
VUcgaXMgbm90IHNldAojIENPTkZJR19DQUlGIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0VQSF9MSUIg
aXMgbm90IHNldAojIENPTkZJR19ORkMgaXMgbm90IHNldAojIENPTkZJR19QU0FNUExFIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUX0lGRSBpcyBub3Qgc2V0CiMgQ09ORklHX0xXVFVOTkVMIGlzIG5v
dCBzZXQKQ09ORklHX0RTVF9DQUNIRT15CkNPTkZJR19HUk9fQ0VMTFM9eQpDT05GSUdfU09DS19W
QUxJREFURV9YTUlUPXkKQ09ORklHX05FVF9TT0NLX01TRz15CkNPTkZJR19QQUdFX1BPT0w9eQoj
IENPTkZJR19QQUdFX1BPT0xfU1RBVFMgaXMgbm90IHNldApDT05GSUdfRkFJTE9WRVI9eQpDT05G
SUdfRVRIVE9PTF9ORVRMSU5LPXkKQ09ORklHX05FVERFVl9BRERSX0xJU1RfVEVTVD1tCkNPTkZJ
R19ORVRfVEVTVD1tCgojCiMgRGV2aWNlIERyaXZlcnMKIwpDT05GSUdfSEFWRV9FSVNBPXkKIyBD
T05GSUdfRUlTQSBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX1BDST15CkNPTkZJR19HRU5FUklDX1BD
SV9JT01BUD15CkNPTkZJR19QQ0k9eQpDT05GSUdfUENJX0RPTUFJTlM9eQpDT05GSUdfUENJRVBP
UlRCVVM9eQpDT05GSUdfUENJRUFFUj15CiMgQ09ORklHX1BDSUVBRVJfSU5KRUNUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUENJRV9FQ1JDIGlzIG5vdCBzZXQKQ09ORklHX1BDSUVBU1BNPXkKQ09ORklH
X1BDSUVBU1BNX0RFRkFVTFQ9eQojIENPTkZJR19QQ0lFQVNQTV9QT1dFUlNBVkUgaXMgbm90IHNl
dAojIENPTkZJR19QQ0lFQVNQTV9QT1dFUl9TVVBFUlNBVkUgaXMgbm90IHNldAojIENPTkZJR19Q
Q0lFQVNQTV9QRVJGT1JNQU5DRSBpcyBub3Qgc2V0CkNPTkZJR19QQ0lFX1BNRT15CiMgQ09ORklH
X1BDSUVfRFBDIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJRV9QVE0gaXMgbm90IHNldApDT05GSUdf
UENJX01TST15CkNPTkZJR19QQ0lfUVVJUktTPXkKIyBDT05GSUdfUENJX0RFQlVHIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUENJX1NUVUIgaXMgbm90IHNldApDT05GSUdfUENJX0xPQ0tMRVNTX0NPTkZJ
Rz15CiMgQ09ORklHX1BDSV9JT1YgaXMgbm90IHNldAojIENPTkZJR19QQ0lfUFJJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUENJX1BBU0lEIGlzIG5vdCBzZXQKQ09ORklHX1BDSV9MQUJFTD15CkNPTkZJ
R19QQ0lfRFlOQU1JQ19PRl9OT0RFUz15CiMgQ09ORklHX1BDSUVfQlVTX1RVTkVfT0ZGIGlzIG5v
dCBzZXQKQ09ORklHX1BDSUVfQlVTX0RFRkFVTFQ9eQojIENPTkZJR19QQ0lFX0JVU19TQUZFIGlz
IG5vdCBzZXQKIyBDT05GSUdfUENJRV9CVVNfUEVSRk9STUFOQ0UgaXMgbm90IHNldAojIENPTkZJ
R19QQ0lFX0JVU19QRUVSMlBFRVIgaXMgbm90IHNldApDT05GSUdfVkdBX0FSQj15CkNPTkZJR19W
R0FfQVJCX01BWF9HUFVTPTQKIyBDT05GSUdfSE9UUExVR19QQ0kgaXMgbm90IHNldAoKIwojIFBD
SSBjb250cm9sbGVyIGRyaXZlcnMKIwojIENPTkZJR19QQ0lfRlRQQ0kxMDAgaXMgbm90IHNldAoj
IENPTkZJR19QQ0lfSE9TVF9HRU5FUklDIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJRV9YSUxJTlgg
aXMgbm90IHNldAoKIwojIENhZGVuY2UtYmFzZWQgUENJZSBjb250cm9sbGVycwojCiMgQ09ORklH
X1BDSUVfQ0FERU5DRV9QTEFUX0hPU1QgaXMgbm90IHNldAojIGVuZCBvZiBDYWRlbmNlLWJhc2Vk
IFBDSWUgY29udHJvbGxlcnMKCiMKIyBEZXNpZ25XYXJlLWJhc2VkIFBDSWUgY29udHJvbGxlcnMK
IwojIENPTkZJR19QQ0lfTUVTT04gaXMgbm90IHNldAojIENPTkZJR19QQ0lFX0lOVEVMX0dXIGlz
IG5vdCBzZXQKIyBDT05GSUdfUENJRV9EV19QTEFUX0hPU1QgaXMgbm90IHNldAojIGVuZCBvZiBE
ZXNpZ25XYXJlLWJhc2VkIFBDSWUgY29udHJvbGxlcnMKCiMKIyBNb2JpdmVpbC1iYXNlZCBQQ0ll
IGNvbnRyb2xsZXJzCiMKIyBlbmQgb2YgTW9iaXZlaWwtYmFzZWQgUENJZSBjb250cm9sbGVycwoK
IwojIFBMREEtYmFzZWQgUENJZSBjb250cm9sbGVycwojCiMgQ09ORklHX1BDSUVfTUlDUk9DSElQ
X0hPU1QgaXMgbm90IHNldAojIGVuZCBvZiBQTERBLWJhc2VkIFBDSWUgY29udHJvbGxlcnMKIyBl
bmQgb2YgUENJIGNvbnRyb2xsZXIgZHJpdmVycwoKIwojIFBDSSBFbmRwb2ludAojCiMgQ09ORklH
X1BDSV9FTkRQT0lOVCBpcyBub3Qgc2V0CiMgZW5kIG9mIFBDSSBFbmRwb2ludAoKIwojIFBDSSBz
d2l0Y2ggY29udHJvbGxlciBkcml2ZXJzCiMKIyBDT05GSUdfUENJX1NXX1NXSVRDSFRFQyBpcyBu
b3Qgc2V0CiMgZW5kIG9mIFBDSSBzd2l0Y2ggY29udHJvbGxlciBkcml2ZXJzCgojIENPTkZJR19D
WExfQlVTIGlzIG5vdCBzZXQKQ09ORklHX1BDQ0FSRD15CkNPTkZJR19QQ01DSUE9eQojIENPTkZJ
R19QQ01DSUFfTE9BRF9DSVMgaXMgbm90IHNldApDT05GSUdfQ0FSREJVUz15CgojCiMgUEMtY2Fy
ZCBicmlkZ2VzCiMKQ09ORklHX1lFTlRBPXkKIyBDT05GSUdfWUVOVEFfTzIgaXMgbm90IHNldAoj
IENPTkZJR19ZRU5UQV9SSUNPSCBpcyBub3Qgc2V0CiMgQ09ORklHX1lFTlRBX1RJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfWUVOVEFfVE9TSElCQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BENjcyOSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0k4MjA5MiBpcyBub3Qgc2V0CkNPTkZJR19QQ0NBUkRfTk9OU1RBVElD
PXkKIyBDT05GSUdfUkFQSURJTyBpcyBub3Qgc2V0CgojCiMgR2VuZXJpYyBEcml2ZXIgT3B0aW9u
cwojCiMgQ09ORklHX1VFVkVOVF9IRUxQRVIgaXMgbm90IHNldApDT05GSUdfREVWVE1QRlM9eQpD
T05GSUdfREVWVE1QRlNfTU9VTlQ9eQpDT05GSUdfREVWVE1QRlNfU0FGRT15CkNPTkZJR19TVEFO
REFMT05FPXkKQ09ORklHX1BSRVZFTlRfRklSTVdBUkVfQlVJTEQ9eQoKIwojIEZpcm13YXJlIGxv
YWRlcgojCkNPTkZJR19GV19MT0FERVI9eQpDT05GSUdfRVhUUkFfRklSTVdBUkU9IiIKIyBDT05G
SUdfRldfTE9BREVSX1VTRVJfSEVMUEVSIGlzIG5vdCBzZXQKQ09ORklHX0ZXX0xPQURFUl9DT01Q
UkVTUz15CiMgQ09ORklHX0ZXX0xPQURFUl9DT01QUkVTU19YWiBpcyBub3Qgc2V0CkNPTkZJR19G
V19MT0FERVJfQ09NUFJFU1NfWlNURD15CkNPTkZJR19GV19DQUNIRT15CiMgQ09ORklHX0ZXX1VQ
TE9BRCBpcyBub3Qgc2V0CiMgZW5kIG9mIEZpcm13YXJlIGxvYWRlcgoKQ09ORklHX0FMTE9XX0RF
Vl9DT1JFRFVNUD15CiMgQ09ORklHX0RFQlVHX0RSSVZFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0RF
QlVHX0RFVlJFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1RFU1RfRFJJVkVSX1JFTU9WRSBp
cyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfQVNZTkNfRFJJVkVSX1BST0JFIGlzIG5vdCBzZXQKQ09O
RklHX0RNX0tVTklUX1RFU1Q9bQpDT05GSUdfRFJJVkVSX1BFX0tVTklUX1RFU1Q9bQpDT05GSUdf
R0VORVJJQ19DUFVfREVWSUNFUz15CkNPTkZJR19HRU5FUklDX0NQVV9BVVRPUFJPQkU9eQpDT05G
SUdfR0VORVJJQ19DUFVfVlVMTkVSQUJJTElUSUVTPXkKQ09ORklHX1JFR01BUD15CkNPTkZJR19S
RUdNQVBfS1VOSVQ9bQojIENPTkZJR19SRUdNQVBfQlVJTEQgaXMgbm90IHNldApDT05GSUdfUkVH
TUFQX1JBTT1tCkNPTkZJR19ETUFfU0hBUkVEX0JVRkZFUj15CkNPTkZJR19ETUFfRkVOQ0VfVFJB
Q0U9eQojIENPTkZJR19GV19ERVZMSU5LX1NZTkNfU1RBVEVfVElNRU9VVCBpcyBub3Qgc2V0CiMg
ZW5kIG9mIEdlbmVyaWMgRHJpdmVyIE9wdGlvbnMKCiMKIyBCdXMgZGV2aWNlcwojCiMgQ09ORklH
X01ISV9CVVMgaXMgbm90IHNldAojIENPTkZJR19NSElfQlVTX0VQIGlzIG5vdCBzZXQKIyBlbmQg
b2YgQnVzIGRldmljZXMKCiMKIyBDYWNoZSBEcml2ZXJzCiMKIyBlbmQgb2YgQ2FjaGUgRHJpdmVy
cwoKQ09ORklHX0NPTk5FQ1RPUj15CkNPTkZJR19QUk9DX0VWRU5UUz15CgojCiMgRmlybXdhcmUg
RHJpdmVycwojCgojCiMgQVJNIFN5c3RlbSBDb250cm9sIGFuZCBNYW5hZ2VtZW50IEludGVyZmFj
ZSBQcm90b2NvbAojCiMgZW5kIG9mIEFSTSBTeXN0ZW0gQ29udHJvbCBhbmQgTWFuYWdlbWVudCBJ
bnRlcmZhY2UgUHJvdG9jb2wKCiMgQ09ORklHX0VERCBpcyBub3Qgc2V0CkNPTkZJR19GSVJNV0FS
RV9NRU1NQVA9eQpDT05GSUdfRE1JSUQ9eQpDT05GSUdfRE1JX1NZU0ZTPXkKQ09ORklHX0RNSV9T
Q0FOX01BQ0hJTkVfTk9OX0VGSV9GQUxMQkFDSz15CiMgQ09ORklHX0lTQ1NJX0lCRlQgaXMgbm90
IHNldApDT05GSUdfRldfQ0ZHX1NZU0ZTPW0KIyBDT05GSUdfRldfQ0ZHX1NZU0ZTX0NNRExJTkUg
aXMgbm90IHNldApDT05GSUdfU1lTRkI9eQpDT05GSUdfU1lTRkJfU0lNUExFRkI9eQojIENPTkZJ
R19HT09HTEVfRklSTVdBUkUgaXMgbm90IHNldAoKIwojIFF1YWxjb21tIGZpcm13YXJlIGRyaXZl
cnMKIwojIGVuZCBvZiBRdWFsY29tbSBmaXJtd2FyZSBkcml2ZXJzCgojCiMgVGVncmEgZmlybXdh
cmUgZHJpdmVyCiMKIyBlbmQgb2YgVGVncmEgZmlybXdhcmUgZHJpdmVyCiMgZW5kIG9mIEZpcm13
YXJlIERyaXZlcnMKCiMgQ09ORklHX0dOU1MgaXMgbm90IHNldAojIENPTkZJR19NVEQgaXMgbm90
IHNldApDT05GSUdfRFRDPXkKQ09ORklHX09GPXkKIyBDT05GSUdfT0ZfVU5JVFRFU1QgaXMgbm90
IHNldApDT05GSUdfT0ZfS1VOSVRfVEVTVD1tCkNPTkZJR19PRl9GTEFUVFJFRT15CkNPTkZJR19P
Rl9FQVJMWV9GTEFUVFJFRT15CkNPTkZJR19PRl9LT0JKPXkKQ09ORklHX09GX0RZTkFNSUM9eQpD
T05GSUdfT0ZfQUREUkVTUz15CkNPTkZJR19PRl9JUlE9eQpDT05GSUdfT0ZfUkVTRVJWRURfTUVN
PXkKIyBDT05GSUdfT0ZfT1ZFUkxBWSBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX01JR0hUX0hBVkVf
UENfUEFSUE9SVD15CiMgQ09ORklHX1BBUlBPUlQgaXMgbm90IHNldApDT05GSUdfUE5QPXkKIyBD
T05GSUdfUE5QX0RFQlVHX01FU1NBR0VTIGlzIG5vdCBzZXQKCiMKIyBQcm90b2NvbHMKIwpDT05G
SUdfUE5QQUNQST15CkNPTkZJR19CTEtfREVWPXkKIyBDT05GSUdfQkxLX0RFVl9OVUxMX0JMSyBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfRkQgaXMgbm90IHNldApDT05GSUdfQ0RST009eQoj
IENPTkZJR19CTEtfREVWX1BDSUVTU0RfTVRJUDMyWFggaXMgbm90IHNldAojIENPTkZJR19aUkFN
IGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfTE9PUD1tCkNPTkZJR19CTEtfREVWX0xPT1BfTUlO
X0NPVU5UPTgKIyBDT05GSUdfQkxLX0RFVl9EUkJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RF
Vl9OQkQgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1JBTSBpcyBub3Qgc2V0CiMgQ09ORklH
X0NEUk9NX1BLVENEVkQgaXMgbm90IHNldAojIENPTkZJR19BVEFfT1ZFUl9FVEggaXMgbm90IHNl
dApDT05GSUdfVklSVElPX0JMSz15CiMgQ09ORklHX0JMS19ERVZfUkJEIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkxLX0RFVl9VQkxLIGlzIG5vdCBzZXQKCiMKIyBOVk1FIFN1cHBvcnQKIwojIENPTkZJ
R19CTEtfREVWX05WTUUgaXMgbm90IHNldAojIENPTkZJR19OVk1FX0ZDIGlzIG5vdCBzZXQKIyBD
T05GSUdfTlZNRV9UQ1AgaXMgbm90IHNldAojIENPTkZJR19OVk1FX1RBUkdFVCBpcyBub3Qgc2V0
CiMgZW5kIG9mIE5WTUUgU3VwcG9ydAoKIwojIE1pc2MgZGV2aWNlcwojCiMgQ09ORklHX0FENTI1
WF9EUE9UIGlzIG5vdCBzZXQKIyBDT05GSUdfRFVNTVlfSVJRIGlzIG5vdCBzZXQKIyBDT05GSUdf
SUJNX0FTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1BIQU5UT00gaXMgbm90IHNldAojIENPTkZJR19U
SUZNX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19JQ1M5MzJTNDAxIGlzIG5vdCBzZXQKIyBDT05G
SUdfRU5DTE9TVVJFX1NFUlZJQ0VTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFBfSUxPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQVBEUzk4MDJBTFMgaXMgbm90IHNldAojIENPTkZJR19JU0wyOTAwMyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lTTDI5MDIwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UU0wy
NTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19CSDE3NzAgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0FQRFM5OTBYIGlzIG5vdCBzZXQKIyBDT05GSUdfSE1DNjM1MiBpcyBub3Qgc2V0
CiMgQ09ORklHX0RTMTY4MiBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSF9QSFVCIGlzIG5vdCBzZXQK
IyBDT05GSUdfU1JBTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RXX1hEQVRBX1BDSUUgaXMgbm90IHNl
dAojIENPTkZJR19QQ0lfRU5EUE9JTlRfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTElOWF9T
REZFQyBpcyBub3Qgc2V0CiMgQ09ORklHX09QRU5fRElDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZD
UFVfU1RBTExfREVURUNUT1IgaXMgbm90IHNldAojIENPTkZJR19OU00gaXMgbm90IHNldAojIENP
TkZJR19DMlBPUlQgaXMgbm90IHNldAoKIwojIEVFUFJPTSBzdXBwb3J0CiMKIyBDT05GSUdfRUVQ
Uk9NX0FUMjQgaXMgbm90IHNldAojIENPTkZJR19FRVBST01fTUFYNjg3NSBpcyBub3Qgc2V0CkNP
TkZJR19FRVBST01fOTNDWDY9bQojIENPTkZJR19FRVBST01fSURUXzg5SFBFU1ggaXMgbm90IHNl
dAojIENPTkZJR19FRVBST01fRUUxMDA0IGlzIG5vdCBzZXQKIyBlbmQgb2YgRUVQUk9NIHN1cHBv
cnQKCiMgQ09ORklHX0NCNzEwX0NPUkUgaXMgbm90IHNldAoKIwojIFRleGFzIEluc3RydW1lbnRz
IHNoYXJlZCB0cmFuc3BvcnQgbGluZSBkaXNjaXBsaW5lCiMKIyBDT05GSUdfVElfU1QgaXMgbm90
IHNldAojIGVuZCBvZiBUZXhhcyBJbnN0cnVtZW50cyBzaGFyZWQgdHJhbnNwb3J0IGxpbmUgZGlz
Y2lwbGluZQoKIyBDT05GSUdfU0VOU09SU19MSVMzX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX0FM
VEVSQV9TVEFQTCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX01FSSBpcyBub3Qgc2V0CiMgQ09O
RklHX1ZNV0FSRV9WTUNJIGlzIG5vdCBzZXQKIyBDT05GSUdfRUNITyBpcyBub3Qgc2V0CiMgQ09O
RklHX0JDTV9WSyBpcyBub3Qgc2V0CiMgQ09ORklHX01JU0NfQUxDT1JfUENJIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUlTQ19SVFNYX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX01JU0NfUlRTWF9VU0Ig
aXMgbm90IHNldApDT05GSUdfUFZQQU5JQz15CiMgQ09ORklHX1BWUEFOSUNfTU1JTyBpcyBub3Qg
c2V0CiMgQ09ORklHX1BWUEFOSUNfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BfUENJMVhYWFgg
aXMgbm90IHNldAojIENPTkZJR19LRUJBX0NQNTAwIGlzIG5vdCBzZXQKIyBlbmQgb2YgTWlzYyBk
ZXZpY2VzCgojCiMgU0NTSSBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19TQ1NJX01PRD15CiMgQ09O
RklHX1JBSURfQVRUUlMgaXMgbm90IHNldApDT05GSUdfU0NTSV9DT01NT049eQpDT05GSUdfU0NT
ST15CkNPTkZJR19TQ1NJX0RNQT15CiMgQ09ORklHX1NDU0lfUFJPQ19GUyBpcyBub3Qgc2V0CkNP
TkZJR19TQ1NJX0xJQl9LVU5JVF9URVNUPW0KCiMKIyBTQ1NJIHN1cHBvcnQgdHlwZSAoZGlzaywg
dGFwZSwgQ0QtUk9NKQojCkNPTkZJR19CTEtfREVWX1NEPXkKIyBDT05GSUdfQ0hSX0RFVl9TVCBp
cyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX1NSPXkKQ09ORklHX0NIUl9ERVZfU0c9bQpDT05GSUdf
QkxLX0RFVl9CU0c9eQojIENPTkZJR19DSFJfREVWX1NDSCBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJ
X0NPTlNUQU5UUz15CiMgQ09ORklHX1NDU0lfTE9HR0lORyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJ
X1NDQU5fQVNZTkM9eQpDT05GSUdfU0NTSV9QUk9UT19URVNUPW0KCiMKIyBTQ1NJIFRyYW5zcG9y
dHMKIwojIENPTkZJR19TQ1NJX1NQSV9BVFRSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRkNf
QVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lTQ1NJX0FUVFJTIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9TQVNfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBU19MSUJTQVMg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NSUF9BVFRSUyBpcyBub3Qgc2V0CiMgZW5kIG9mIFND
U0kgVHJhbnNwb3J0cwoKQ09ORklHX1NDU0lfTE9XTEVWRUw9eQojIENPTkZJR19JU0NTSV9UQ1Ag
aXMgbm90IHNldAojIENPTkZJR19JU0NTSV9CT09UX1NZU0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0NTSV9DWEdCM19JU0NTSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQ1hHQjRfSVNDU0kgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0JOWDJfSVNDU0kgaXMgbm90IHNldAojIENPTkZJR19CRTJJ
U0NTSSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfM1dfWFhYWF9SQUlEIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9IUFNBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV8zV185WFhYIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV8zV19TQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FDQVJE
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BQUNSQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9BSUM3WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSUM3OVhYIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9BSUM5NFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9NVlNBUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDU0lfTVZVTUkgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FEVkFOU1lT
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BUkNNU1IgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X0VTQVMyUiBpcyBub3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX05FV0dFTiBpcyBub3Qgc2V0CiMg
Q09ORklHX01FR0FSQUlEX0xFR0FDWSBpcyBub3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX1NBUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTVBUM1NBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
TVBUMlNBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTVBJM01SIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9TTUFSVFBRSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSFBUSU9QIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9CVVNMT0dJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTVlSQiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTVlSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZNV0FSRV9Q
VlNDU0kgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NOSUMgaXMgbm90IHNldAojIENPTkZJR19T
Q1NJX0RNWDMxOTFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9GRE9NQUlOX1BDSSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDU0lfSVNDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVBTIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9JTklUSU8gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lOSUEx
MDAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NURVggaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X1NZTTUzQzhYWF8yIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JUFIgaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX1FMT0dJQ18xMjgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTEFfSVNDU0kg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RDMzk1eCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
QU01M0M5NzQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX05TUDMyIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9XRDcxOVggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RFQlVHIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9QTUNSQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9QTTgwMDEgaXMg
bm90IHNldApDT05GSUdfU0NTSV9WSVJUSU89eQojIENPTkZJR19TQ1NJX0xPV0xFVkVMX1BDTUNJ
QSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfREggaXMgbm90IHNldAojIGVuZCBvZiBTQ1NJIGRl
dmljZSBzdXBwb3J0CgpDT05GSUdfQVRBPXkKQ09ORklHX1NBVEFfSE9TVD15CkNPTkZJR19QQVRB
X1RJTUlOR1M9eQpDT05GSUdfQVRBX1ZFUkJPU0VfRVJST1I9eQojIENPTkZJR19BVEFfRk9SQ0Ug
aXMgbm90IHNldApDT05GSUdfQVRBX0FDUEk9eQpDT05GSUdfU0FUQV9aUE9ERD15CiMgQ09ORklH
X1NBVEFfUE1QIGlzIG5vdCBzZXQKCiMKIyBDb250cm9sbGVycyB3aXRoIG5vbi1TRkYgbmF0aXZl
IGludGVyZmFjZQojCkNPTkZJR19TQVRBX0FIQ0k9eQpDT05GSUdfU0FUQV9NT0JJTEVfTFBNX1BP
TElDWT0wCiMgQ09ORklHX1NBVEFfQUhDSV9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX0FI
Q0lfRFdDIGlzIG5vdCBzZXQKIyBDT05GSUdfQUhDSV9DRVZBIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0FUQV9JTklDMTYyWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfQUNBUkRfQUhDSSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NBVEFfU0lMMjQgaXMgbm90IHNldApDT05GSUdfQVRBX1NGRj15CgojCiMg
U0ZGIGNvbnRyb2xsZXJzIHdpdGggY3VzdG9tIERNQSBpbnRlcmZhY2UKIwojIENPTkZJR19QRENf
QURNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfUVNUT1IgaXMgbm90IHNldAojIENPTkZJR19T
QVRBX1NYNCBpcyBub3Qgc2V0CkNPTkZJR19BVEFfQk1ETUE9eQoKIwojIFNBVEEgU0ZGIGNvbnRy
b2xsZXJzIHdpdGggQk1ETUEKIwpDT05GSUdfQVRBX1BJSVg9eQojIENPTkZJR19TQVRBX01WIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0FUQV9OViBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfUFJPTUlT
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfU0lMIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9T
SVMgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NWVyBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFf
VUxJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9WSUEgaXMgbm90IHNldAojIENPTkZJR19TQVRB
X1ZJVEVTU0UgaXMgbm90IHNldAoKIwojIFBBVEEgU0ZGIGNvbnRyb2xsZXJzIHdpdGggQk1ETUEK
IwojIENPTkZJR19QQVRBX0FMSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQU1EIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFUQV9BUlRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQVRJSVhQIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEFUQV9BVFA4NjdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9D
TUQ2NFggaXMgbm90IHNldAojIENPTkZJR19QQVRBX0NTNTUyMCBpcyBub3Qgc2V0CiMgQ09ORklH
X1BBVEFfQ1M1NTMwIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9DUzU1MzUgaXMgbm90IHNldAoj
IENPTkZJR19QQVRBX0NTNTUzNiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQ1lQUkVTUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBVEFfRUZBUiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSFBUMzY2
IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9IUFQzN1ggaXMgbm90IHNldAojIENPTkZJR19QQVRB
X0hQVDNYMk4gaXMgbm90IHNldAojIENPTkZJR19QQVRBX0hQVDNYMyBpcyBub3Qgc2V0CiMgQ09O
RklHX1BBVEFfSVQ4MjEzIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9JVDgyMVggaXMgbm90IHNl
dAojIENPTkZJR19QQVRBX0pNSUNST04gaXMgbm90IHNldAojIENPTkZJR19QQVRBX01BUlZFTEwg
aXMgbm90IHNldAojIENPTkZJR19QQVRBX05FVENFTEwgaXMgbm90IHNldAojIENPTkZJR19QQVRB
X05JTkpBMzIgaXMgbm90IHNldAojIENPTkZJR19QQVRBX05TODc0MTUgaXMgbm90IHNldAojIENP
TkZJR19QQVRBX09MRFBJSVggaXMgbm90IHNldAojIENPTkZJR19QQVRBX09QVElETUEgaXMgbm90
IHNldAojIENPTkZJR19QQVRBX1BEQzIwMjdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9QRENf
T0xEIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9SQURJU1lTIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9SREMgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NDMTIwMCBpcyBub3Qgc2V0CiMgQ09O
RklHX1BBVEFfU0NIIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9TRVJWRVJXT1JLUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBVEFfU0lMNjgwIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9TSVMgaXMg
bm90IHNldAojIENPTkZJR19QQVRBX1RPU0hJQkEgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1RS
SUZMRVggaXMgbm90IHNldAojIENPTkZJR19QQVRBX1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BB
VEFfV0lOQk9ORCBpcyBub3Qgc2V0CgojCiMgUElPLW9ubHkgU0ZGIGNvbnRyb2xsZXJzCiMKIyBD
T05GSUdfUEFUQV9DTUQ2NDBfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9NUElJWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBVEFfTlM4NzQxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfT1BU
SSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUENNQ0lBIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFU
QV9PRl9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUloxMDAwIGlzIG5vdCBzZXQK
CiMKIyBHZW5lcmljIGZhbGxiYWNrIC8gbGVnYWN5IGRyaXZlcnMKIwojIENPTkZJR19QQVRBX0FD
UEkgaXMgbm90IHNldAojIENPTkZJR19BVEFfR0VORVJJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BB
VEFfTEVHQUNZIGlzIG5vdCBzZXQKQ09ORklHX01EPXkKQ09ORklHX0JMS19ERVZfTUQ9bQojIENP
TkZJR19NRF9CSVRNQVBfRklMRSBpcyBub3Qgc2V0CiMgQ09ORklHX01EX1JBSUQwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTURfUkFJRDEgaXMgbm90IHNldAojIENPTkZJR19NRF9SQUlEMTAgaXMgbm90
IHNldApDT05GSUdfTURfUkFJRDQ1Nj1tCiMgQ09ORklHX0JDQUNIRSBpcyBub3Qgc2V0CkNPTkZJ
R19CTEtfREVWX0RNX0JVSUxUSU49eQpDT05GSUdfQkxLX0RFVl9ETT1tCkNPTkZJR19ETV9ERUJV
Rz15CkNPTkZJR19ETV9CVUZJTz1tCkNPTkZJR19ETV9ERUJVR19CTE9DS19NQU5BR0VSX0xPQ0tJ
Tkc9eQojIENPTkZJR19ETV9ERUJVR19CTE9DS19TVEFDS19UUkFDSU5HIGlzIG5vdCBzZXQKQ09O
RklHX0RNX0JJT19QUklTT049bQpDT05GSUdfRE1fUEVSU0lTVEVOVF9EQVRBPW0KIyBDT05GSUdf
RE1fVU5TVFJJUEVEIGlzIG5vdCBzZXQKQ09ORklHX0RNX0NSWVBUPW0KIyBDT05GSUdfRE1fU05B
UFNIT1QgaXMgbm90IHNldApDT05GSUdfRE1fVEhJTl9QUk9WSVNJT05JTkc9bQojIENPTkZJR19E
TV9DQUNIRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1dSSVRFQ0FDSEUgaXMgbm90IHNldAojIENP
TkZJR19ETV9FUkEgaXMgbm90IHNldAojIENPTkZJR19ETV9DTE9ORSBpcyBub3Qgc2V0CiMgQ09O
RklHX0RNX01JUlJPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1JBSUQgaXMgbm90IHNldAojIENP
TkZJR19ETV9aRVJPIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fTVVMVElQQVRIIGlzIG5vdCBzZXQK
IyBDT05GSUdfRE1fREVMQVkgaXMgbm90IHNldAojIENPTkZJR19ETV9EVVNUIGlzIG5vdCBzZXQK
Q09ORklHX0RNX1VFVkVOVD15CiMgQ09ORklHX0RNX0ZMQUtFWSBpcyBub3Qgc2V0CiMgQ09ORklH
X0RNX1ZFUklUWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1NXSVRDSCBpcyBub3Qgc2V0CiMgQ09O
RklHX0RNX0xPR19XUklURVMgaXMgbm90IHNldAojIENPTkZJR19ETV9JTlRFR1JJVFkgaXMgbm90
IHNldAojIENPTkZJR19UQVJHRVRfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVU0lPTiBpcyBu
b3Qgc2V0CgojCiMgSUVFRSAxMzk0IChGaXJlV2lyZSkgc3VwcG9ydAojCiMgQ09ORklHX0ZJUkVX
SVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfRklSRVdJUkVfTk9TWSBpcyBub3Qgc2V0CiMgZW5kIG9m
IElFRUUgMTM5NCAoRmlyZVdpcmUpIHN1cHBvcnQKCiMgQ09ORklHX01BQ0lOVE9TSF9EUklWRVJT
IGlzIG5vdCBzZXQKQ09ORklHX05FVERFVklDRVM9eQpDT05GSUdfTkVUX0NPUkU9eQojIENPTkZJ
R19CT05ESU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfRFVNTVkgaXMgbm90IHNldApDT05GSUdfV0lS
RUdVQVJEPW0KIyBDT05GSUdfV0lSRUdVQVJEX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfRVFV
QUxJWkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0ZDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1RFQU0gaXMgbm90IHNldAojIENPTkZJR19NQUNWTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBW
TEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfVlhMQU4gaXMgbm90IHNldAojIENPTkZJR19HRU5FVkUg
aXMgbm90IHNldAojIENPTkZJR19CQVJFVURQIGlzIG5vdCBzZXQKIyBDT05GSUdfR1RQIGlzIG5v
dCBzZXQKIyBDT05GSUdfUEZDUCBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ1NFQyBpcyBub3Qgc2V0
CkNPTkZJR19ORVRDT05TT0xFPXkKIyBDT05GSUdfTkVUQ09OU09MRV9FWFRFTkRFRF9MT0cgaXMg
bm90IHNldApDT05GSUdfTkVUUE9MTD15CkNPTkZJR19ORVRfUE9MTF9DT05UUk9MTEVSPXkKQ09O
RklHX1RVTj1tCiMgQ09ORklHX1RVTl9WTkVUX0NST1NTX0xFIGlzIG5vdCBzZXQKIyBDT05GSUdf
VkVUSCBpcyBub3Qgc2V0CkNPTkZJR19WSVJUSU9fTkVUPXkKIyBDT05GSUdfTkxNT04gaXMgbm90
IHNldAojIENPTkZJR19ORVRLSVQgaXMgbm90IHNldAojIENPTkZJR19BUkNORVQgaXMgbm90IHNl
dApDT05GSUdfRVRIRVJORVQ9eQojIENPTkZJR19ORVRfVkVORE9SXzNDT00gaXMgbm90IHNldAoj
IENPTkZJR19ORVRfVkVORE9SX0FEQVBURUMgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9S
X0FHRVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BTEFDUklURUNIIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BTFRFT04gaXMgbm90IHNldAojIENPTkZJR19BTFRFUkFf
VFNFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BTUFaT04gaXMgbm90IHNldAojIENP
TkZJR19ORVRfVkVORE9SX0FNRCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQVFVQU5U
SUEgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0FSQyBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfQVNJWCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQVRIRVJPUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0NYX0VDQVQgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9S
X0JST0FEQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9DQURFTkNFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9DQVZJVU0gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVO
RE9SX0NIRUxTSU8gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0NJU0NPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9DT1JUSU5BIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZF
TkRPUl9EQVZJQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfRE5FVCBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfREVDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9ETElOSyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfRU1VTEVYIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1ZFTkRPUl9FTkdMRURFUiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfRVpDSElQIGlz
IG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfRlVKSVRTVT15CiMgQ09ORklHX1BDTUNJQV9GTVZK
MThYIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9GVU5HSUJMRSBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9WRU5ET1JfR09PR0xFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9I
VUFXRUkgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0k4MjVYWCBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfVkVORE9SX0lOVEVMPXkKIyBDT05GSUdfRTEwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X0UxMDAwIGlzIG5vdCBzZXQKQ09ORklHX0UxMDAwRT15CkNPTkZJR19FMTAwMEVfSFdUUz15CiMg
Q09ORklHX0lHQiBpcyBub3Qgc2V0CiMgQ09ORklHX0lHQlZGIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVhHQkUgaXMgbm90IHNldAojIENPTkZJR19JWEdCRVZGIGlzIG5vdCBzZXQKIyBDT05GSUdfSTQw
RSBpcyBub3Qgc2V0CiMgQ09ORklHX0k0MEVWRiBpcyBub3Qgc2V0CiMgQ09ORklHX0lDRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0ZNMTBLIGlzIG5vdCBzZXQKIyBDT05GSUdfSUdDIGlzIG5vdCBzZXQK
IyBDT05GSUdfSURQRiBpcyBub3Qgc2V0CiMgQ09ORklHX0pNRSBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfTElURVggaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX01BUlZFTEwg
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX01FTExBTk9YIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1ZFTkRPUl9NRVRBIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9NSUNSRUwg
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX01JQ1JPQ0hJUCBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9WRU5ET1JfTUlDUk9TRU1JIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9N
SUNST1NPRlQgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX01ZUkkgaXMgbm90IHNldAoj
IENPTkZJR19GRUFMTlggaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX05JIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9OQVRTRU1JIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZF
TkRPUl9ORVRFUklPTiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTkVUUk9OT01FIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9OVklESUEgaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX09LSSBpcyBub3Qgc2V0CiMgQ09ORklHX0VUSE9DIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1ZFTkRPUl9QQUNLRVRfRU5HSU5FUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5E
T1JfUEVOU0FORE8gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1FMT0dJQyBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQlJPQ0FERSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9W
RU5ET1JfUVVBTENPTU0gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1JEQyBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUkVBTFRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9W
RU5ET1JfUkVORVNBUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUk9DS0VSIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TQU1TVU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1ZFTkRPUl9TRUVRIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TSUxBTiBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9WRU5ET1JfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRP
Ul9TT0xBUkZMQVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TTVNDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TT0NJT05FWFQgaXMgbm90IHNldAojIENPTkZJR19ORVRf
VkVORE9SX1NUTUlDUk8gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1NVTiBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9WRU5ET1JfU1lOT1BTWVMgaXMgbm90IHNldAojIENPTkZJR19ORVRf
VkVORE9SX1RFSFVUSSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfVEkgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfVkVORE9SX1ZFUlRFWENPTSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9W
RU5ET1JfVklBIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9XQU5HWFVOIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9XSVpORVQgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVO
RE9SX1hJTElOWCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1hJUkNPTT15CiMgQ09ORklH
X1BDTUNJQV9YSVJDMlBTIGlzIG5vdCBzZXQKIyBDT05GSUdfRkRESSBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJUFBJIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZTElCIGlzIG5vdCBzZXQKIyBDT05GSUdf
TURJT19ERVZJQ0UgaXMgbm90IHNldAoKIwojIFBDUyBkZXZpY2UgZHJpdmVycwojCiMgQ09ORklH
X1BDU19YUENTIGlzIG5vdCBzZXQKIyBlbmQgb2YgUENTIGRldmljZSBkcml2ZXJzCgojIENPTkZJ
R19QUFAgaXMgbm90IHNldAojIENPTkZJR19TTElQIGlzIG5vdCBzZXQKCiMKIyBIb3N0LXNpZGUg
VVNCIHN1cHBvcnQgaXMgbmVlZGVkIGZvciBVU0IgTmV0d29yayBBZGFwdGVyIHN1cHBvcnQKIwoj
IENPTkZJR19VU0JfTkVUX0RSSVZFUlMgaXMgbm90IHNldApDT05GSUdfV0xBTj15CiMgQ09ORklH
X1dMQU5fVkVORE9SX0FETVRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1dMQU5fVkVORE9SX0FUSCBp
cyBub3Qgc2V0CiMgQ09ORklHX1dMQU5fVkVORE9SX0FUTUVMIGlzIG5vdCBzZXQKIyBDT05GSUdf
V0xBTl9WRU5ET1JfQlJPQURDT00gaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfSU5URUw9
eQojIENPTkZJR19JUFcyMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBXMjIwMCBpcyBub3Qgc2V0
CkNPTkZJR19JV0xFR0FDWT1tCiMgQ09ORklHX0lXTDQ5NjUgaXMgbm90IHNldApDT05GSUdfSVdM
Mzk0NT1tCgojCiMgaXdsMzk0NSAvIGl3bDQ5NjUgRGVidWdnaW5nIE9wdGlvbnMKIwojIENPTkZJ
R19JV0xFR0FDWV9ERUJVRyBpcyBub3Qgc2V0CiMgZW5kIG9mIGl3bDM5NDUgLyBpd2w0OTY1IERl
YnVnZ2luZyBPcHRpb25zCgojIENPTkZJR19JV0xXSUZJIGlzIG5vdCBzZXQKIyBDT05GSUdfV0xB
Tl9WRU5ET1JfSU5URVJTSUwgaXMgbm90IHNldAojIENPTkZJR19XTEFOX1ZFTkRPUl9NQVJWRUxM
IGlzIG5vdCBzZXQKIyBDT05GSUdfV0xBTl9WRU5ET1JfTUVESUFURUsgaXMgbm90IHNldAojIENP
TkZJR19XTEFOX1ZFTkRPUl9NSUNST0NISVAgaXMgbm90IHNldAojIENPTkZJR19XTEFOX1ZFTkRP
Ul9QVVJFTElGSSBpcyBub3Qgc2V0CiMgQ09ORklHX1dMQU5fVkVORE9SX1JBTElOSyBpcyBub3Qg
c2V0CkNPTkZJR19XTEFOX1ZFTkRPUl9SRUFMVEVLPXkKIyBDT05GSUdfUlRMODE4MCBpcyBub3Qg
c2V0CiMgQ09ORklHX1JUTDgxODcgaXMgbm90IHNldAojIENPTkZJR19SVExfQ0FSRFMgaXMgbm90
IHNldApDT05GSUdfUlRMOFhYWFU9bQojIENPTkZJR19SVEw4WFhYVV9VTlRFU1RFRCBpcyBub3Qg
c2V0CiMgQ09ORklHX1JUVzg4IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRXODkgaXMgbm90IHNldAoj
IENPTkZJR19XTEFOX1ZFTkRPUl9SU0kgaXMgbm90IHNldAojIENPTkZJR19XTEFOX1ZFTkRPUl9T
SUxBQlMgaXMgbm90IHNldAojIENPTkZJR19XTEFOX1ZFTkRPUl9TVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1dMQU5fVkVORE9SX1RJIGlzIG5vdCBzZXQKIyBDT05GSUdfV0xBTl9WRU5ET1JfWllEQVMg
aXMgbm90IHNldAojIENPTkZJR19XTEFOX1ZFTkRPUl9RVUFOVEVOTkEgaXMgbm90IHNldAojIENP
TkZJR19NQUM4MDIxMV9IV1NJTSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJUlRfV0lGSSBpcyBub3Qg
c2V0CiMgQ09ORklHX1dBTiBpcyBub3Qgc2V0CgojCiMgV2lyZWxlc3MgV0FOCiMKIyBDT05GSUdf
V1dBTiBpcyBub3Qgc2V0CiMgZW5kIG9mIFdpcmVsZXNzIFdBTgoKIyBDT05GSUdfVk1YTkVUMyBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZVSklUU1VfRVMgaXMgbm90IHNldAojIENPTkZJR19ORVRERVZT
SU0gaXMgbm90IHNldApDT05GSUdfTkVUX0ZBSUxPVkVSPXkKIyBDT05GSUdfSVNETiBpcyBub3Qg
c2V0CgojCiMgSW5wdXQgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdfSU5QVVQ9eQpDT05GSUdfSU5Q
VVRfTEVEUz1tCkNPTkZJR19JTlBVVF9GRl9NRU1MRVNTPW0KQ09ORklHX0lOUFVUX1NQQVJTRUtN
QVA9bQojIENPTkZJR19JTlBVVF9NQVRSSVhLTUFQIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX1ZJ
VkFMRElGTUFQPXkKCiMKIyBVc2VybGFuZCBpbnRlcmZhY2VzCiMKIyBDT05GSUdfSU5QVVRfTU9V
U0VERVYgaXMgbm90IHNldApDT05GSUdfSU5QVVRfSk9ZREVWPW0KQ09ORklHX0lOUFVUX0VWREVW
PW0KIyBDT05GSUdfSU5QVVRfRVZCVUcgaXMgbm90IHNldApDT05GSUdfSU5QVVRfS1VOSVRfVEVT
VD1tCgojCiMgSW5wdXQgRGV2aWNlIERyaXZlcnMKIwpDT05GSUdfSU5QVVRfS0VZQk9BUkQ9eQoj
IENPTkZJR19LRVlCT0FSRF9BRFA1NTg4IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfQURQ
NTU4OSBpcyBub3Qgc2V0CkNPTkZJR19LRVlCT0FSRF9BVEtCRD15CiMgQ09ORklHX0tFWUJPQVJE
X1FUMTA1MCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1FUMTA3MCBpcyBub3Qgc2V0CiMg
Q09ORklHX0tFWUJPQVJEX1FUMjE2MCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0RMSU5L
X0RJUjY4NSBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0xLS0JEIGlzIG5vdCBzZXQKIyBD
T05GSUdfS0VZQk9BUkRfR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0dQSU9fUE9M
TEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfVENBNjQxNiBpcyBub3Qgc2V0CiMgQ09O
RklHX0tFWUJPQVJEX1RDQTg0MTggaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9NQVRSSVgg
aXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9MTTgzMjMgaXMgbm90IHNldAojIENPTkZJR19L
RVlCT0FSRF9MTTgzMzMgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9NQVg3MzU5IGlzIG5v
dCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfTUNTIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRf
TVBSMTIxIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfTkVXVE9OIGlzIG5vdCBzZXQKIyBD
T05GSUdfS0VZQk9BUkRfT1BFTkNPUkVTIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfU0FN
U1VORyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1NUT1dBV0FZIGlzIG5vdCBzZXQKIyBD
T05GSUdfS0VZQk9BUkRfU1VOS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfT01BUDQg
aXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9UTTJfVE9VQ0hLRVkgaXMgbm90IHNldAojIENP
TkZJR19LRVlCT0FSRF9YVEtCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0NBUDExWFgg
aXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9CQ00gaXMgbm90IHNldAojIENPTkZJR19LRVlC
T0FSRF9DWVBSRVNTX1NGIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX01PVVNFPXkKQ09ORklHX01P
VVNFX1BTMj15CiMgQ09ORklHX01PVVNFX1BTMl9BTFBTIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9V
U0VfUFMyX0JZRCBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1BTMl9MT0dJUFMyUFAgaXMgbm90
IHNldApDT05GSUdfTU9VU0VfUFMyX1NZTkFQVElDUz15CiMgQ09ORklHX01PVVNFX1BTMl9TWU5B
UFRJQ1NfU01CVVMgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9QUzJfQ1lQUkVTUyBpcyBub3Qg
c2V0CiMgQ09ORklHX01PVVNFX1BTMl9MSUZFQk9PSyBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNF
X1BTMl9UUkFDS1BPSU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfUFMyX0VMQU5URUNIIGlz
IG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfUFMyX1NFTlRFTElDIGlzIG5vdCBzZXQKIyBDT05GSUdf
TU9VU0VfUFMyX1RPVUNIS0lUIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfUFMyX0ZPQ0FMVEVD
SCBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1BTMl9WTU1PVVNFIGlzIG5vdCBzZXQKIyBDT05G
SUdfTU9VU0VfU0VSSUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfQVBQTEVUT1VDSCBpcyBu
b3Qgc2V0CiMgQ09ORklHX01PVVNFX0JDTTU5NzQgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9D
WUFQQSBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX0VMQU5fSTJDIGlzIG5vdCBzZXQKIyBDT05G
SUdfTU9VU0VfVlNYWFhBQSBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX0dQSU8gaXMgbm90IHNl
dAojIENPTkZJR19NT1VTRV9TWU5BUFRJQ1NfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0Vf
U1lOQVBUSUNTX1VTQiBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9KT1lTVElDSz15CiMgQ09ORklH
X0pPWVNUSUNLX0FOQUxPRyBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX0EzRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0pPWVNUSUNLX0FESSBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX0NP
QlJBIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfR0YySyBpcyBub3Qgc2V0CiMgQ09ORklH
X0pPWVNUSUNLX0dSSVAgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19HUklQX01QIGlzIG5v
dCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfR1VJTExFTU9UIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9Z
U1RJQ0tfSU5URVJBQ1QgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19TSURFV0lOREVSIGlz
IG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfVE1EQyBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNU
SUNLX0lGT1JDRSBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1dBUlJJT1IgaXMgbm90IHNl
dAojIENPTkZJR19KT1lTVElDS19NQUdFTExBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNL
X1NQQUNFT1JCIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfU1BBQ0VCQUxMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSk9ZU1RJQ0tfU1RJTkdFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNL
X1RXSURKT1kgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19aSEVOSFVBIGlzIG5vdCBzZXQK
IyBDT05GSUdfSk9ZU1RJQ0tfQVM1MDExIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfSk9Z
RFVNUCBpcyBub3Qgc2V0CkNPTkZJR19KT1lTVElDS19YUEFEPW0KIyBDT05GSUdfSk9ZU1RJQ0tf
WFBBRF9GRiBpcyBub3Qgc2V0CkNPTkZJR19KT1lTVElDS19YUEFEX0xFRFM9eQojIENPTkZJR19K
T1lTVElDS19QWFJDIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfUVdJSUMgaXMgbm90IHNl
dAojIENPTkZJR19KT1lTVElDS19GU0lBNkIgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19T
RU5TRUhBVCBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1NFRVNBVyBpcyBub3Qgc2V0CiMg
Q09ORklHX0lOUFVUX1RBQkxFVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1RPVUNIU0NSRUVO
IGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX01JU0M9eQojIENPTkZJR19JTlBVVF9BRDcxNFggaXMg
bm90IHNldAojIENPTkZJR19JTlBVVF9BVE1FTF9DQVBUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklH
X0lOUFVUX0JNQTE1MCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0UzWDBfQlVUVE9OIGlzIG5v
dCBzZXQKIyBDT05GSUdfSU5QVVRfTU1BODQ1MCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0FQ
QU5FTCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0dQSU9fQkVFUEVSIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfR1BJT19ERUNPREVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfR1BJT19W
SUJSQSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1dJU1RST05fQlROUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0lOUFVUX0FUTEFTX0JUTlMgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9BVElfUkVN
T1RFMiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0tFWVNQQU5fUkVNT1RFIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5QVVRfS1hUSjkgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9QT1dFUk1BVEUg
aXMgbm90IHNldAojIENPTkZJR19JTlBVVF9ZRUFMSU5LIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5Q
VVRfQ00xMDkgaXMgbm90IHNldApDT05GSUdfSU5QVVRfVUlOUFVUPW0KIyBDT05GSUdfSU5QVVRf
UENGODU3NCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0dQSU9fUk9UQVJZX0VOQ09ERVIgaXMg
bm90IHNldAojIENPTkZJR19JTlBVVF9EQTcyODBfSEFQVElDUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0lOUFVUX0FEWEwzNFggaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9JTVNfUENVIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSU5QVVRfSVFTMjY5QSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0lRUzYy
NkEgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9JUVM3MjIyIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5QVVRfQ01BMzAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0lERUFQQURfU0xJREVCQVIg
aXMgbm90IHNldAojIENPTkZJR19JTlBVVF9EUlYyNjBYX0hBUFRJQ1MgaXMgbm90IHNldAojIENP
TkZJR19JTlBVVF9EUlYyNjY1X0hBUFRJQ1MgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9EUlYy
NjY3X0hBUFRJQ1MgaXMgbm90IHNldAojIENPTkZJR19STUk0X0NPUkUgaXMgbm90IHNldAoKIwoj
IEhhcmR3YXJlIEkvTyBwb3J0cwojCkNPTkZJR19TRVJJTz15CkNPTkZJR19BUkNIX01JR0hUX0hB
VkVfUENfU0VSSU89eQpDT05GSUdfU0VSSU9fSTgwNDI9eQojIENPTkZJR19TRVJJT19TRVJQT1JU
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fQ1Q4MkM3MTAgaXMgbm90IHNldAojIENPTkZJR19T
RVJJT19QQ0lQUzIgaXMgbm90IHNldApDT05GSUdfU0VSSU9fTElCUFMyPXkKIyBDT05GSUdfU0VS
SU9fUkFXIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fQUxURVJBX1BTMiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFUklPX1BTMk1VTFQgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19BUkNfUFMyIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fQVBCUFMyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9f
R1BJT19QUzIgaXMgbm90IHNldAojIENPTkZJR19VU0VSSU8gaXMgbm90IHNldAojIENPTkZJR19H
QU1FUE9SVCBpcyBub3Qgc2V0CiMgZW5kIG9mIEhhcmR3YXJlIEkvTyBwb3J0cwojIGVuZCBvZiBJ
bnB1dCBkZXZpY2Ugc3VwcG9ydAoKIwojIENoYXJhY3RlciBkZXZpY2VzCiMKQ09ORklHX1RUWT15
CkNPTkZJR19WVD15CkNPTkZJR19DT05TT0xFX1RSQU5TTEFUSU9OUz15CkNPTkZJR19WVF9DT05T
T0xFPXkKQ09ORklHX1ZUX0NPTlNPTEVfU0xFRVA9eQpDT05GSUdfVlRfSFdfQ09OU09MRV9CSU5E
SU5HPXkKQ09ORklHX1VOSVg5OF9QVFlTPXkKIyBDT05GSUdfTEVHQUNZX1BUWVMgaXMgbm90IHNl
dAojIENPTkZJR19MRUdBQ1lfVElPQ1NUSSBpcyBub3Qgc2V0CkNPTkZJR19MRElTQ19BVVRPTE9B
RD15CgojCiMgU2VyaWFsIGRyaXZlcnMKIwpDT05GSUdfU0VSSUFMX0VBUkxZQ09OPXkKQ09ORklH
X1NFUklBTF84MjUwPXkKIyBDT05GSUdfU0VSSUFMXzgyNTBfREVQUkVDQVRFRF9PUFRJT05TIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBfUE5QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VS
SUFMXzgyNTBfMTY1NTBBX1ZBUklBTlRTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBf
RklOVEVLIGlzIG5vdCBzZXQKQ09ORklHX1NFUklBTF84MjUwX0NPTlNPTEU9eQojIENPTkZJR19T
RVJJQUxfODI1MF9QQ0kgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfODI1MF9FWEFSIGlzIG5v
dCBzZXQKQ09ORklHX1NFUklBTF84MjUwX0NTPXkKQ09ORklHX1NFUklBTF84MjUwX05SX1VBUlRT
PTgKQ09ORklHX1NFUklBTF84MjUwX1JVTlRJTUVfVUFSVFM9OAojIENPTkZJR19TRVJJQUxfODI1
MF9FWFRFTkRFRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwX1BDSTFYWFhYIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBfRFcgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxf
ODI1MF9SVDI4OFggaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfODI1MF9MUFNTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBfTUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgy
NTBfUEVSSUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9PRl9QTEFURk9STSBpcyBub3Qg
c2V0CgojCiMgTm9uLTgyNTAgc2VyaWFsIHBvcnQgc3VwcG9ydAojCiMgQ09ORklHX1NFUklBTF9V
QVJUTElURSBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfQ09SRT15CkNPTkZJR19TRVJJQUxfQ09S
RV9DT05TT0xFPXkKIyBDT05GSUdfU0VSSUFMX0pTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklB
TF9TSUZJVkUgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfTEFOVElRIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VSSUFMX1NDQ05YUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9TQzE2SVM3WFgg
aXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfVElNQkVSREFMRSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFUklBTF9BTFRFUkFfSlRBR1VBUlQgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfQUxURVJB
X1VBUlQgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfUENIX1VBUlQgaXMgbm90IHNldAojIENP
TkZJR19TRVJJQUxfWElMSU5YX1BTX1VBUlQgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfQVJD
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX1JQMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklB
TF9GU0xfTFBVQVJUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0ZTTF9MSU5GTEVYVUFSVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9DT05FWEFOVF9ESUdJQ09MT1IgaXMgbm90IHNldAoj
IENPTkZJR19TRVJJQUxfU1BSRCBpcyBub3Qgc2V0CiMgZW5kIG9mIFNlcmlhbCBkcml2ZXJzCgpD
T05GSUdfU0VSSUFMX01DVFJMX0dQSU89eQojIENPTkZJR19TRVJJQUxfTk9OU1RBTkRBUkQgaXMg
bm90IHNldAojIENPTkZJR19JUFdJUkVMRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfTl9HU00gaXMg
bm90IHNldAojIENPTkZJR19OT1pPTUkgaXMgbm90IHNldAojIENPTkZJR19OVUxMX1RUWSBpcyBu
b3Qgc2V0CkNPTkZJR19IVkNfRFJJVkVSPXkKIyBDT05GSUdfU0VSSUFMX0RFVl9CVVMgaXMgbm90
IHNldAojIENPTkZJR19UVFlfUFJJTlRLIGlzIG5vdCBzZXQKQ09ORklHX1ZJUlRJT19DT05TT0xF
PXkKIyBDT05GSUdfSVBNSV9IQU5ETEVSIGlzIG5vdCBzZXQKQ09ORklHX0hXX1JBTkRPTT1tCiMg
Q09ORklHX0hXX1JBTkRPTV9USU1FUklPTUVNIGlzIG5vdCBzZXQKIyBDT05GSUdfSFdfUkFORE9N
X0lOVEVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSFdfUkFORE9NX0FNRCBpcyBub3Qgc2V0CiMgQ09O
RklHX0hXX1JBTkRPTV9CQTQzMSBpcyBub3Qgc2V0CiMgQ09ORklHX0hXX1JBTkRPTV9HRU9ERSBp
cyBub3Qgc2V0CiMgQ09ORklHX0hXX1JBTkRPTV9WSUEgaXMgbm90IHNldApDT05GSUdfSFdfUkFO
RE9NX1ZJUlRJTz1tCiMgQ09ORklHX0hXX1JBTkRPTV9DQ1RSTkcgaXMgbm90IHNldAojIENPTkZJ
R19IV19SQU5ET01fWElQSEVSQSBpcyBub3Qgc2V0CiMgQ09ORklHX0FQUExJQ09NIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU09OWVBJIGlzIG5vdCBzZXQKIyBDT05GSUdfTVdBVkUgaXMgbm90IHNldAoj
IENPTkZJR19QQzg3MzZ4X0dQSU8gaXMgbm90IHNldAojIENPTkZJR19OU0NfR1BJTyBpcyBub3Qg
c2V0CkNPTkZJR19ERVZNRU09eQpDT05GSUdfTlZSQU09bQpDT05GSUdfREVWUE9SVD15CiMgQ09O
RklHX0hQRVQgaXMgbm90IHNldAojIENPTkZJR19IQU5HQ0hFQ0tfVElNRVIgaXMgbm90IHNldAoj
IENPTkZJR19UQ0dfVFBNIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVMQ0xPQ0sgaXMgbm90IHNldAoj
IENPTkZJR19YSUxMWUJVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTExZVVNCIGlzIG5vdCBzZXQK
IyBlbmQgb2YgQ2hhcmFjdGVyIGRldmljZXMKCiMKIyBJMkMgc3VwcG9ydAojCkNPTkZJR19JMkM9
eQpDT05GSUdfQUNQSV9JMkNfT1BSRUdJT049eQpDT05GSUdfSTJDX0JPQVJESU5GTz15CiMgQ09O
RklHX0kyQ19DT01QQVQgaXMgbm90IHNldApDT05GSUdfSTJDX0NIQVJERVY9eQojIENPTkZJR19J
MkNfTVVYIGlzIG5vdCBzZXQKQ09ORklHX0kyQ19IRUxQRVJfQVVUTz15CkNPTkZJR19JMkNfU01C
VVM9eQpDT05GSUdfSTJDX0FMR09CSVQ9bQoKIwojIEkyQyBIYXJkd2FyZSBCdXMgc3VwcG9ydAoj
CgojCiMgUEMgU01CdXMgaG9zdCBjb250cm9sbGVyIGRyaXZlcnMKIwojIENPTkZJR19JMkNfQUxJ
MTUzNSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEkxNTYzIGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX0FMSTE1WDMgaXMgbm90IHNldAojIENPTkZJR19JMkNfQU1ENzU2IGlzIG5vdCBzZXQKIyBD
T05GSUdfSTJDX0FNRDgxMTEgaXMgbm90IHNldAojIENPTkZJR19JMkNfQU1EX01QMiBpcyBub3Qg
c2V0CkNPTkZJR19JMkNfSTgwMT15CiMgQ09ORklHX0kyQ19JU0NIIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX0lTTVQgaXMgbm90IHNldApDT05GSUdfSTJDX1BJSVg0PXkKIyBDT05GSUdfSTJDX05G
T1JDRTIgaXMgbm90IHNldAojIENPTkZJR19JMkNfTlZJRElBX0dQVSBpcyBub3Qgc2V0CiMgQ09O
RklHX0kyQ19TSVM1NTk1IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJUzYzMCBpcyBub3Qgc2V0
CiMgQ09ORklHX0kyQ19TSVM5NlggaXMgbm90IHNldAojIENPTkZJR19JMkNfVklBIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSTJDX1ZJQVBSTyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19aSEFPWElOIGlz
IG5vdCBzZXQKCiMKIyBBQ1BJIGRyaXZlcnMKIwpDT05GSUdfSTJDX1NDTUk9bQoKIwojIEkyQyBz
eXN0ZW0gYnVzIGRyaXZlcnMgKG1vc3RseSBlbWJlZGRlZCAvIHN5c3RlbS1vbi1jaGlwKQojCiMg
Q09ORklHX0kyQ19DQlVTX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19JMkNfREVTSUdOV0FSRV9Q
TEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERVNJR05XQVJFX1BDSSBpcyBub3Qgc2V0
CiMgQ09ORklHX0kyQ19FRzIwVCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19FTUVWMiBpcyBub3Qg
c2V0CiMgQ09ORklHX0kyQ19HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX09DT1JFUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0kyQ19QQ0FfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJR19JMkNf
UFhBIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1JLM1ggaXMgbm90IHNldAojIENPTkZJR19JMkNf
U0lNVEVDIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1hJTElOWCBpcyBub3Qgc2V0CgojCiMgRXh0
ZXJuYWwgSTJDL1NNQnVzIGFkYXB0ZXIgZHJpdmVycwojCiMgQ09ORklHX0kyQ19ESU9MQU5fVTJD
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0NQMjYxNSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19Q
Q0kxWFhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ST0JPVEZVWlpfT1NJRiBpcyBub3Qgc2V0
CiMgQ09ORklHX0kyQ19UQU9TX0VWTSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19USU5ZX1VTQiBp
cyBub3Qgc2V0CgojCiMgT3RoZXIgSTJDL1NNQnVzIGJ1cyBkcml2ZXJzCiMKIyBDT05GSUdfU0N4
MjAwX0FDQiBpcyBub3Qgc2V0CkNPTkZJR19JMkNfVklSVElPPW0KIyBlbmQgb2YgSTJDIEhhcmR3
YXJlIEJ1cyBzdXBwb3J0CgojIENPTkZJR19JMkNfU1RVQiBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19TTEFWRSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19DT1JFIGlzIG5vdCBzZXQKIyBD
T05GSUdfSTJDX0RFQlVHX0FMR08gaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdfQlVTIGlz
IG5vdCBzZXQKIyBlbmQgb2YgSTJDIHN1cHBvcnQKCiMgQ09ORklHX0kzQyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQTUkgaXMgbm90IHNldAojIENPTkZJR19I
U0kgaXMgbm90IHNldAojIENPTkZJR19QUFMgaXMgbm90IHNldAoKIwojIFBUUCBjbG9jayBzdXBw
b3J0CiMKIyBDT05GSUdfUFRQXzE1ODhfQ0xPQ0sgaXMgbm90IHNldApDT05GSUdfUFRQXzE1ODhf
Q0xPQ0tfT1BUSU9OQUw9eQoKIwojIEVuYWJsZSBQSFlMSUIgYW5kIE5FVFdPUktfUEhZX1RJTUVT
VEFNUElORyB0byBzZWUgdGhlIGFkZGl0aW9uYWwgY2xvY2tzLgojCiMgZW5kIG9mIFBUUCBjbG9j
ayBzdXBwb3J0CgojIENPTkZJR19QSU5DVFJMIGlzIG5vdCBzZXQKQ09ORklHX0dQSU9MSUI9eQpD
T05GSUdfR1BJT0xJQl9GQVNUUEFUSF9MSU1JVD01MTIKQ09ORklHX09GX0dQSU89eQpDT05GSUdf
R1BJT19BQ1BJPXkKQ09ORklHX0dQSU9MSUJfSVJRQ0hJUD15CiMgQ09ORklHX0RFQlVHX0dQSU8g
aXMgbm90IHNldAojIENPTkZJR19HUElPX1NZU0ZTIGlzIG5vdCBzZXQKQ09ORklHX0dQSU9fQ0RF
Vj15CkNPTkZJR19HUElPX0NERVZfVjE9eQoKIwojIE1lbW9yeSBtYXBwZWQgR1BJTyBkcml2ZXJz
CiMKIyBDT05GSUdfR1BJT183NFhYX01NSU8gaXMgbm90IHNldAojIENPTkZJR19HUElPX0FMVEVS
QSBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fQU1EUFQgaXMgbm90IHNldAojIENPTkZJR19HUElP
X0NBREVOQ0UgaXMgbm90IHNldAojIENPTkZJR19HUElPX0RXQVBCIGlzIG5vdCBzZXQKIyBDT05G
SUdfR1BJT19GVEdQSU8wMTAgaXMgbm90IHNldAojIENPTkZJR19HUElPX0dFTkVSSUNfUExBVEZP
Uk0gaXMgbm90IHNldAojIENPTkZJR19HUElPX0dSQU5JVEVSQVBJRFMgaXMgbm90IHNldAojIENP
TkZJR19HUElPX0dSR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fSExXRCBpcyBub3Qgc2V0
CiMgQ09ORklHX0dQSU9fTUI4NlM3WCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fU0lGSVZFIGlz
IG5vdCBzZXQKIyBDT05GSUdfR1BJT19YSUxJTlggaXMgbm90IHNldAojIENPTkZJR19HUElPX0FN
RF9GQ0ggaXMgbm90IHNldAojIGVuZCBvZiBNZW1vcnkgbWFwcGVkIEdQSU8gZHJpdmVycwoKIwoj
IFBvcnQtbWFwcGVkIEkvTyBHUElPIGRyaXZlcnMKIwojIENPTkZJR19HUElPX1ZYODU1IGlzIG5v
dCBzZXQKIyBDT05GSUdfR1BJT19GNzE4OFggaXMgbm90IHNldAojIENPTkZJR19HUElPX0lUODcg
aXMgbm90IHNldAojIENPTkZJR19HUElPX1NDSDMxMVggaXMgbm90IHNldAojIENPTkZJR19HUElP
X1dJTkJPTkQgaXMgbm90IHNldAojIENPTkZJR19HUElPX1dTMTZDNDggaXMgbm90IHNldAojIGVu
ZCBvZiBQb3J0LW1hcHBlZCBJL08gR1BJTyBkcml2ZXJzCgojCiMgSTJDIEdQSU8gZXhwYW5kZXJz
CiMKIyBDT05GSUdfR1BJT19BRE5QIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19GWEw2NDA4IGlz
IG5vdCBzZXQKIyBDT05GSUdfR1BJT19EUzQ1MjAgaXMgbm90IHNldAojIENPTkZJR19HUElPX0dX
X1BMRCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fTUFYNzMwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X0dQSU9fTUFYNzMyWCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fUENBOTUzWCBpcyBub3Qgc2V0
CiMgQ09ORklHX0dQSU9fUENBOTU3MCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fUENGODU3WCBp
cyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fVFBJQzI4MTAgaXMgbm90IHNldAojIGVuZCBvZiBJMkMg
R1BJTyBleHBhbmRlcnMKCiMKIyBNRkQgR1BJTyBleHBhbmRlcnMKIwojIENPTkZJR19HUElPX0VM
S0hBUlRMQUtFIGlzIG5vdCBzZXQKIyBlbmQgb2YgTUZEIEdQSU8gZXhwYW5kZXJzCgojCiMgUENJ
IEdQSU8gZXhwYW5kZXJzCiMKIyBDT05GSUdfR1BJT19BTUQ4MTExIGlzIG5vdCBzZXQKIyBDT05G
SUdfR1BJT19CVDhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fTUxfSU9IIGlzIG5vdCBzZXQK
IyBDT05GSUdfR1BJT19QQ0ggaXMgbm90IHNldAojIENPTkZJR19HUElPX1BDSV9JRElPXzE2IGlz
IG5vdCBzZXQKIyBDT05GSUdfR1BJT19QQ0lFX0lESU9fMjQgaXMgbm90IHNldAojIENPTkZJR19H
UElPX1JEQzMyMVggaXMgbm90IHNldAojIENPTkZJR19HUElPX1NPREFWSUxMRSBpcyBub3Qgc2V0
CiMgZW5kIG9mIFBDSSBHUElPIGV4cGFuZGVycwoKIwojIFVTQiBHUElPIGV4cGFuZGVycwojCiMg
ZW5kIG9mIFVTQiBHUElPIGV4cGFuZGVycwoKIwojIFZpcnR1YWwgR1BJTyBkcml2ZXJzCiMKQ09O
RklHX0dQSU9fQUdHUkVHQVRPUj1tCiMgQ09ORklHX0dQSU9fTEFUQ0ggaXMgbm90IHNldAojIENP
TkZJR19HUElPX01PQ0tVUCBpcyBub3Qgc2V0CkNPTkZJR19HUElPX1ZJUlRJTz1tCiMgQ09ORklH
X0dQSU9fU0lNIGlzIG5vdCBzZXQKIyBlbmQgb2YgVmlydHVhbCBHUElPIGRyaXZlcnMKCiMKIyBH
UElPIERlYnVnZ2luZyB1dGlsaXRpZXMKIwojIENPTkZJR19HUElPX1NMT1BQWV9MT0dJQ19BTkFM
WVpFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fVklSVFVTRVIgaXMgbm90IHNldAojIGVuZCBv
ZiBHUElPIERlYnVnZ2luZyB1dGlsaXRpZXMKCiMgQ09ORklHX1cxIGlzIG5vdCBzZXQKQ09ORklH
X1BPV0VSX1JFU0VUPXkKQ09ORklHX1BPV0VSX1JFU0VUX0dQSU89eQpDT05GSUdfUE9XRVJfUkVT
RVRfR1BJT19SRVNUQVJUPXkKIyBDT05GSUdfUE9XRVJfUkVTRVRfTFRDMjk1MiBpcyBub3Qgc2V0
CiMgQ09ORklHX1BPV0VSX1JFU0VUX1JFU1RBUlQgaXMgbm90IHNldAojIENPTkZJR19QT1dFUl9S
RVNFVF9TWVNDT04gaXMgbm90IHNldAojIENPTkZJR19QT1dFUl9SRVNFVF9TWVNDT05fUE9XRVJP
RkYgaXMgbm90IHNldAojIENPTkZJR19OVk1FTV9SRUJPT1RfTU9ERSBpcyBub3Qgc2V0CiMgQ09O
RklHX1BPV0VSX1NFUVVFTkNJTkcgaXMgbm90IHNldApDT05GSUdfUE9XRVJfU1VQUExZPXkKIyBD
T05GSUdfUE9XRVJfU1VQUExZX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfSVA1WFhYX1BPV0VS
IGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9QT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJH
RVJfQURQNTA2MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfQ1cyMDE1IGlzIG5vdCBzZXQK
IyBDT05GSUdfQkFUVEVSWV9EUzI3ODAgaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX0RTMjc4
MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfRFMyNzgyIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkFUVEVSWV9TQU1TVU5HX1NESSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfU0JTIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9TQlMgaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX0JR
MjdYWFggaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX01BWDE3MDQyIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkFUVEVSWV9NQVgxNzIwWCBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfTUFYODkw
MyBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfTFA4NzI3IGlzIG5vdCBzZXQKIyBDT05GSUdf
Q0hBUkdFUl9HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9MVDM2NTEgaXMgbm90IHNl
dAojIENPTkZJR19DSEFSR0VSX0xUQzQxNjJMIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9E
RVRFQ1RPUl9NQVgxNDY1NiBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfTUFYNzc5NzYgaXMg
bm90IHNldAojIENPTkZJR19DSEFSR0VSX0JRMjQxNVggaXMgbm90IHNldAojIENPTkZJR19DSEFS
R0VSX0JRMjQyNTcgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX0JRMjQ3MzUgaXMgbm90IHNl
dAojIENPTkZJR19DSEFSR0VSX0JRMjUxNVggaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX0JR
MjU4OTAgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX0JRMjU5ODAgaXMgbm90IHNldAojIENP
TkZJR19DSEFSR0VSX0JRMjU2WFggaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX0dBVUdFX0xU
QzI5NDEgaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX0dPTERGSVNIIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkFUVEVSWV9SVDUwMzMgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX1JUOTQ1NSBp
cyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfQkQ5OTk1NCBpcyBub3Qgc2V0CiMgQ09ORklHX0JB
VFRFUllfVUczMTA1IGlzIG5vdCBzZXQKIyBDT05GSUdfRlVFTF9HQVVHRV9NTTgwMTMgaXMgbm90
IHNldApDT05GSUdfSFdNT049bQpDT05GSUdfSFdNT05fREVCVUdfQ0hJUD15CgojCiMgTmF0aXZl
IGRyaXZlcnMKIwojIENPTkZJR19TRU5TT1JTX0FCSVRVR1VSVSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfQUJJVFVHVVJVMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQUQ3NDE0IGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRDc0MTggaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0FETTEwMjUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTEwMjYgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0FETTEwMjkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FE
TTEwMzEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTExNzcgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0FETTkyNDAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FEVDc0MTAg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FEVDc0MTEgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0FEVDc0NjIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FEVDc0NzAgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0FEVDc0NzUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X0FIVDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BUVVBQ09NUFVURVJfRDVORVhUIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BUzM3MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfQVNDNzYyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVNVU19ST0dfUllVSklOIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BWElfRkFOX0NPTlRST0wgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0s4VEVNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVBQTEVTTUMg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FTQjEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfQVRYUDEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0NISVBDQVAyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19DT1JTQUlSX0NQUk8gaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0NPUlNBSVJfUFNVIGlzIG5vdCBzZXQKQ09ORklHX1NFTlNPUlNfRFJJVkVURU1QPW0KIyBD
T05GSUdfU0VOU09SU19EUzYyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRFMxNjIxIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19ERUxMX1NNTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfSTVLX0FNQiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRjcxODA1RiBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfRjcxODgyRkcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X0Y3NTM3NVMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0ZTQ0hNRCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfR0lHQUJZVEVfV0FURVJGT1JDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfR0w1MThTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfR0w1MjBTTSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfRzc2MEEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0c3
NjIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0dQSU9fRkFOIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19ISUg2MTMwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19IUzMwMDEgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0k1NTAwIGlzIG5vdCBzZXQKQ09ORklHX1NFTlNPUlNf
Q09SRVRFTVA9bQojIENPTkZJR19TRU5TT1JTX0lUODcgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0pDNDIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1BPV0VSWiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfUE9XUjEyMjAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xFTk9W
T19FQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTElORUFHRSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfTFRDMjk0NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRDMjk0N19J
MkMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzI5OTAgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0xUQzI5OTEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzI5OTIgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzQxNTEgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0xUQzQyMTUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzQyMjIgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0xUQzQyNDUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xU
QzQyNjAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzQyNjEgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0xUQzQyODIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDEyNyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYMTYwNjUgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX01BWDE2MTkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDE2NjggaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX01BWDE5NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
TUFYMzE3MzAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDMxNzYwIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUFYMzE4MjcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2MjAgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX01BWDY2MzkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2NTAgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX01BWDY2OTcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01B
WDMxNzkwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19NQzM0VlI1MDAgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX01DUDMwMjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RDNjU0
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UUFMyMzg2MSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfTVI3NTIwMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE02MyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfTE03MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE03
NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE03NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfTE03OCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE04MCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTE04MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE04NSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE04NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
TE05MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05MiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfTE05MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05NTIzNCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfTE05NTI0MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
TE05NTI0NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUEM4NzM2MCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfUEM4NzQyNyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTkNUNjY4
MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTkNUNjc3NSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfTkNUNjc3NV9JMkMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX05DVDc4MDIg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX05QQ003WFggaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX05aWFRfS1JBS0VOMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTlpYVF9LUkFL
RU4zIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19OWlhUX1NNQVJUMiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfT0NDX1A4X0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfT1hQ
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QQ0Y4NTkxIGlzIG5vdCBzZXQKIyBDT05GSUdf
UE1CVVMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1BUNTE2MUwgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX1NCVFNJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TQlJNSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0hUMTUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X1NIVDIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TSFQzeCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfU0hUNHggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NIVEMxIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19TSVM1NTk1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19ETUUxNzM3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19FTUMxNDAzIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19FTUMyMTAzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19FTUMy
MzA1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19FTUM2VzIwMSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfU01TQzQ3TTEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NNU0M0N00x
OTIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NNU0M0N0IzOTcgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX1NUVFM3NTEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FEQzEyOEQ4
MTggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FEUzc4MjggaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0FNQzY4MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0lOQTIwOSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSU5BMlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19JTkEyMzggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0lOQTMyMjEgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX1NQRDUxMTggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RDNzQg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RITUM1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfVE1QMTAyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UTVAxMDMgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX1RNUDEwOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVE1Q
NDAxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UTVA0MjEgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX1RNUDQ2NCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVE1QNTEzIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19WSUFfQ1BVVEVNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfVklBNjg2QSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVlQxMjExIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19WVDgyMzEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4
Mzc3M0cgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4Mzc4MUQgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX1c4Mzc5MUQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4Mzc5MkQg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4Mzc5MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfVzgzNzk1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODNMNzg1VFMgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX1c4M0w3ODZORyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfVzgzNjI3SEYgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4MzYyN0VIRiBpcyBub3Qg
c2V0CgojCiMgQUNQSSBkcml2ZXJzCiMKIyBDT05GSUdfU0VOU09SU19BQ1BJX1BPV0VSIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BVEswMTEwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19BU1VTX1dNSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVNVU19FQyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfSFBfV01JIGlzIG5vdCBzZXQKQ09ORklHX1RIRVJNQUw9eQpDT05G
SUdfVEhFUk1BTF9ORVRMSU5LPXkKIyBDT05GSUdfVEhFUk1BTF9TVEFUSVNUSUNTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVEhFUk1BTF9ERUJVR0ZTIGlzIG5vdCBzZXQKQ09ORklHX1RIRVJNQUxfRU1F
UkdFTkNZX1BPV0VST0ZGX0RFTEFZX01TPTAKQ09ORklHX1RIRVJNQUxfT0Y9eQpDT05GSUdfVEhF
Uk1BTF9ERUZBVUxUX0dPVl9TVEVQX1dJU0U9eQojIENPTkZJR19USEVSTUFMX0RFRkFVTFRfR09W
X0ZBSVJfU0hBUkUgaXMgbm90IHNldAojIENPTkZJR19USEVSTUFMX0RFRkFVTFRfR09WX1VTRVJf
U1BBQ0UgaXMgbm90IHNldAojIENPTkZJR19USEVSTUFMX0RFRkFVTFRfR09WX0JBTkdfQkFORyBp
cyBub3Qgc2V0CiMgQ09ORklHX1RIRVJNQUxfR09WX0ZBSVJfU0hBUkUgaXMgbm90IHNldApDT05G
SUdfVEhFUk1BTF9HT1ZfU1RFUF9XSVNFPXkKQ09ORklHX1RIRVJNQUxfR09WX0JBTkdfQkFORz15
CkNPTkZJR19USEVSTUFMX0dPVl9VU0VSX1NQQUNFPXkKIyBDT05GSUdfVEhFUk1BTF9HT1ZfUE9X
RVJfQUxMT0NBVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVX1RIRVJNQUwgaXMgbm90IHNldAoj
IENPTkZJR19USEVSTUFMX0VNVUxBVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1RIRVJNQUxfTU1J
TyBpcyBub3Qgc2V0CgojCiMgSW50ZWwgdGhlcm1hbCBkcml2ZXJzCiMKIyBDT05GSUdfSU5URUxf
UE9XRVJDTEFNUCBpcyBub3Qgc2V0CkNPTkZJR19YODZfVEhFUk1BTF9WRUNUT1I9eQpDT05GSUdf
SU5URUxfVENDPXkKQ09ORklHX1g4Nl9QS0dfVEVNUF9USEVSTUFMPW0KIyBDT05GSUdfSU5URUxf
U09DX0RUU19USEVSTUFMIGlzIG5vdCBzZXQKCiMKIyBBQ1BJIElOVDM0MFggdGhlcm1hbCBkcml2
ZXJzCiMKIyBlbmQgb2YgQUNQSSBJTlQzNDBYIHRoZXJtYWwgZHJpdmVycwoKIyBDT05GSUdfSU5U
RUxfUENIX1RIRVJNQUwgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9UQ0NfQ09PTElORyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lOVEVMX0hGSV9USEVSTUFMIGlzIG5vdCBzZXQKIyBlbmQgb2YgSW50
ZWwgdGhlcm1hbCBkcml2ZXJzCgojIENPTkZJR19XQVRDSERPRyBpcyBub3Qgc2V0CkNPTkZJR19T
U0JfUE9TU0lCTEU9eQojIENPTkZJR19TU0IgaXMgbm90IHNldApDT05GSUdfQkNNQV9QT1NTSUJM
RT15CiMgQ09ORklHX0JDTUEgaXMgbm90IHNldAoKIwojIE11bHRpZnVuY3Rpb24gZGV2aWNlIGRy
aXZlcnMKIwojIENPTkZJR19NRkRfQ1M1NTM1IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FDVDg5
NDVBIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FTMzcxMSBpcyBub3Qgc2V0CiMgQ09ORklHX01G
RF9TTVBSTyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9BUzM3MjIgaXMgbm90IHNldAojIENPTkZJ
R19QTUlDX0FEUDU1MjAgaXMgbm90IHNldAojIENPTkZJR19NRkRfQUFUMjg3MF9DT1JFIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX0FUTUVMX0ZMRVhDT00gaXMgbm90IHNldAojIENPTkZJR19NRkRf
QVRNRUxfSExDREMgaXMgbm90IHNldAojIENPTkZJR19NRkRfQkNNNTkwWFggaXMgbm90IHNldAoj
IENPTkZJR19NRkRfQkQ5NTcxTVdWIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FYUDIwWF9JMkMg
aXMgbm90IHNldAojIENPTkZJR19NRkRfQ1M0Mkw0M19JMkMgaXMgbm90IHNldAojIENPTkZJR19N
RkRfTUFERVJBIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDU5NzAgaXMgbm90IHNldAojIENP
TkZJR19QTUlDX0RBOTAzWCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9EQTkwNTJfSTJDIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX0RBOTA1NSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9EQTkwNjIg
aXMgbm90IHNldAojIENPTkZJR19NRkRfREE5MDYzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0RB
OTE1MCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9ETE4yIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X0dBVEVXT1JLU19HU0MgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUMxM1hYWF9JMkMgaXMgbm90
IHNldAojIENPTkZJR19NRkRfTVAyNjI5IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0hJNjQyMV9Q
TUlDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0lOVEVMX1FVQVJLX0kyQ19HUElPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTFBDX0lDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0xQQ19TQ0ggaXMgbm90IHNl
dAojIENPTkZJR19NRkRfSU5URUxfTFBTU19BQ1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0lO
VEVMX0xQU1NfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0lOVEVMX1BNQ19CWFQgaXMgbm90
IHNldAojIENPTkZJR19NRkRfSVFTNjJYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0pBTlpfQ01P
RElPIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0tFTVBMRCBpcyBub3Qgc2V0CiMgQ09ORklHX01G
RF84OFBNODAwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEXzg4UE04MDUgaXMgbm90IHNldAojIENP
TkZJR19NRkRfODhQTTg2MFggaXMgbm90IHNldAojIENPTkZJR19NRkRfODhQTTg4Nl9QTUlDIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDE0NTc3IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01B
WDc3NTQxIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDc3NjIwIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX01BWDc3NjUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDc3Njg2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX01BWDc3NjkzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDc3NzE0
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDc3ODQzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X01BWDg5MDcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYODkyNSBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9NQVg4OTk3IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDg5OTggaXMgbm90IHNl
dAojIENPTkZJR19NRkRfTVQ2MzYwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01UNjM3MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX01GRF9NVDYzOTcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUVORjIx
Qk1DIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1ZJUEVSQk9BUkQgaXMgbm90IHNldAojIENPTkZJ
R19NRkRfTlRYRUMgaXMgbm90IHNldAojIENPTkZJR19NRkRfUkVUVSBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9QQ0Y1MDYzMyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9TWTc2MzZBIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX1JEQzMyMVggaXMgbm90IHNldAojIENPTkZJR19NRkRfUlQ0ODMxIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX1JUNTAzMyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SVDUx
MjAgaXMgbm90IHNldAojIENPTkZJR19NRkRfUkM1VDU4MyBpcyBub3Qgc2V0CiMgQ09ORklHX01G
RF9SSzhYWF9JMkMgaXMgbm90IHNldAojIENPTkZJR19NRkRfUk41VDYxOCBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF9TRUNfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9TSTQ3NlhfQ09SRSBp
cyBub3Qgc2V0CiMgQ09ORklHX01GRF9TTTUwMSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9TS1k4
MTQ1MiBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9TVE1QRSBpcyBub3Qgc2V0CiMgQ09ORklHX01G
RF9TWVNDT04gaXMgbm90IHNldAojIENPTkZJR19NRkRfTFAzOTQzIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX0xQODc4OCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9USV9MTVUgaXMgbm90IHNldAoj
IENPTkZJR19NRkRfUEFMTUFTIGlzIG5vdCBzZXQKIyBDT05GSUdfVFBTNjEwNVggaXMgbm90IHNl
dAojIENPTkZJR19UUFM2NTAxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1RQUzY1MDdYIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX1RQUzY1MDg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1MDkw
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1MjE3IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X1RJX0xQODczWCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9USV9MUDg3NTY1IGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX1RQUzY1MjE4IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1MjE5IGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1ODZYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQ
UzY1OTEwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1OTEyX0kyQyBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF9UUFM2NTk0X0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1RXTDQwMzBfQ09SRSBp
cyBub3Qgc2V0CiMgQ09ORklHX1RXTDYwNDBfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9X
TDEyNzNfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9MTTM1MzMgaXMgbm90IHNldAojIENP
TkZJR19NRkRfVElNQkVSREFMRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9UQzM1ODlYIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1RRTVg4NiBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9WWDg1NSBp
cyBub3Qgc2V0CiMgQ09ORklHX01GRF9MT0NITkFHQVIgaXMgbm90IHNldAojIENPTkZJR19NRkRf
QVJJWk9OQV9JMkMgaXMgbm90IHNldAojIENPTkZJR19NRkRfV004NDAwIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUZEX1dNODMxWF9JMkMgaXMgbm90IHNldAojIENPTkZJR19NRkRfV004MzUwX0kyQyBp
cyBub3Qgc2V0CiMgQ09ORklHX01GRF9XTTg5OTQgaXMgbm90IHNldAojIENPTkZJR19NRkRfUk9I
TV9CRDcxOFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1JPSE1fQkQ3MTgyOCBpcyBub3Qgc2V0
CiMgQ09ORklHX01GRF9ST0hNX0JEOTU3WE1VRiBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9ST0hN
X0JEOTY4MDEgaXMgbm90IHNldAojIENPTkZJR19NRkRfU1RQTUlDMSBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9TVE1GWCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9BVEMyNjBYX0kyQyBpcyBub3Qg
c2V0CiMgQ09ORklHX01GRF9RQ09NX1BNODAwOCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9DUzQw
TDUwX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SU01VX0kyQyBpcyBub3Qgc2V0CiMgZW5k
IG9mIE11bHRpZnVuY3Rpb24gZGV2aWNlIGRyaXZlcnMKCiMgQ09ORklHX1JFR1VMQVRPUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JDX0NPUkUgaXMgbm90IHNldAoKIwojIENFQyBzdXBwb3J0CiMKIyBD
T05GSUdfTUVESUFfQ0VDX1NVUFBPUlQgaXMgbm90IHNldAojIGVuZCBvZiBDRUMgc3VwcG9ydAoK
IyBDT05GSUdfTUVESUFfU1VQUE9SVCBpcyBub3Qgc2V0CgojCiMgR3JhcGhpY3Mgc3VwcG9ydAoj
CkNPTkZJR19BUEVSVFVSRV9IRUxQRVJTPXkKQ09ORklHX1NDUkVFTl9JTkZPPXkKQ09ORklHX1ZJ
REVPPXkKIyBDT05GSUdfQVVYRElTUExBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUCBpcyBub3Qg
c2V0CiMgQ09ORklHX1ZHQV9TV0lUQ0hFUk9PIGlzIG5vdCBzZXQKQ09ORklHX0RSTT15CiMgQ09O
RklHX0RSTV9ERUJVR19NTSBpcyBub3Qgc2V0CkNPTkZJR19EUk1fS1VOSVRfVEVTVF9IRUxQRVJT
PW0KQ09ORklHX0RSTV9LVU5JVF9URVNUPW0KQ09ORklHX0RSTV9LTVNfSEVMUEVSPXkKIyBDT05G
SUdfRFJNX0RFQlVHX0RQX01TVF9UT1BPTE9HWV9SRUZTIGlzIG5vdCBzZXQKQ09ORklHX0RSTV9E
RUJVR19NT0RFU0VUX0xPQ0s9eQpDT05GSUdfRFJNX0ZCREVWX0VNVUxBVElPTj15CkNPTkZJR19E
Uk1fRkJERVZfT1ZFUkFMTE9DPTEwMAojIENPTkZJR19EUk1fRkJERVZfTEVBS19QSFlTX1NNRU0g
aXMgbm90IHNldAojIENPTkZJR19EUk1fTE9BRF9FRElEX0ZJUk1XQVJFIGlzIG5vdCBzZXQKQ09O
RklHX0RSTV9ESVNQTEFZX0hFTFBFUj1tCiMgQ09ORklHX0RSTV9ESVNQTEFZX0RQX0FVWF9DRUMg
aXMgbm90IHNldAojIENPTkZJR19EUk1fRElTUExBWV9EUF9BVVhfQ0hBUkRFViBpcyBub3Qgc2V0
CkNPTkZJR19EUk1fRElTUExBWV9EUF9IRUxQRVI9eQpDT05GSUdfRFJNX0RJU1BMQVlfSERNSV9I
RUxQRVI9eQpDT05GSUdfRFJNX0RJU1BMQVlfSERNSV9TVEFURV9IRUxQRVI9eQpDT05GSUdfRFJN
X1RUTT1tCkNPTkZJR19EUk1fRVhFQz1tCkNPTkZJR19EUk1fQlVERFk9bQpDT05GSUdfRFJNX1ZS
QU1fSEVMUEVSPW0KQ09ORklHX0RSTV9UVE1fSEVMUEVSPW0KQ09ORklHX0RSTV9HRU1fU0hNRU1f
SEVMUEVSPXkKQ09ORklHX0RSTV9TVUJBTExPQ19IRUxQRVI9bQoKIwojIEkyQyBlbmNvZGVyIG9y
IGhlbHBlciBjaGlwcwojCiMgQ09ORklHX0RSTV9JMkNfQ0g3MDA2IGlzIG5vdCBzZXQKIyBDT05G
SUdfRFJNX0kyQ19TSUwxNjQgaXMgbm90IHNldAojIENPTkZJR19EUk1fSTJDX05YUF9UREE5OThY
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0kyQ19OWFBfVERBOTk1MCBpcyBub3Qgc2V0CiMgZW5k
IG9mIEkyQyBlbmNvZGVyIG9yIGhlbHBlciBjaGlwcwoKIwojIEFSTSBkZXZpY2VzCiMKIyBDT05G
SUdfRFJNX0tPTUVEQSBpcyBub3Qgc2V0CiMgZW5kIG9mIEFSTSBkZXZpY2VzCgpDT05GSUdfRFJN
X1JBREVPTj1tCkNPTkZJR19EUk1fUkFERU9OX1VTRVJQVFI9eQojIENPTkZJR19EUk1fQU1ER1BV
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX05PVVZFQVUgaXMgbm90IHNldAojIENPTkZJR19EUk1f
STkxNSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9YRSBpcyBub3Qgc2V0CkNPTkZJR19EUk1fVkdF
TT1tCiMgQ09ORklHX0RSTV9WS01TIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1ZNV0dGWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RSTV9HTUE1MDAgaXMgbm90IHNldAojIENPTkZJR19EUk1fVURMIGlz
IG5vdCBzZXQKIyBDT05GSUdfRFJNX0FTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9NR0FHMjAw
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1FYTCBpcyBub3Qgc2V0CkNPTkZJR19EUk1fVklSVElP
X0dQVT1tCkNPTkZJR19EUk1fVklSVElPX0dQVV9LTVM9eQpDT05GSUdfRFJNX1BBTkVMPXkKCiMK
IyBEaXNwbGF5IFBhbmVscwojCiMgQ09ORklHX0RSTV9QQU5FTF9MVkRTIGlzIG5vdCBzZXQKIyBD
T05GSUdfRFJNX1BBTkVMX09MSU1FWF9MQ0RfT0xJTlVYSU5PIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFJNX1BBTkVMX1NBTVNVTkdfUzZFODhBMF9BTVM0NTJFRjAxIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFJNX1BBTkVMX1NBTVNVTkdfQVROQTMzWEMyMCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5F
TF9TQU1TVU5HX1M2RDdBQTAgaXMgbm90IHNldAojIENPTkZJR19EUk1fUEFORUxfU0FNU1VOR19T
NkU2M00wIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVMX1NBTVNVTkdfUzZFOEFBMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9TRUlLT180M1dWRjFHIGlzIG5vdCBzZXQKIyBDT05G
SUdfRFJNX1BBTkVMX0VEUCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9TSU1QTEUgaXMg
bm90IHNldAojIGVuZCBvZiBEaXNwbGF5IFBhbmVscwoKQ09ORklHX0RSTV9CUklER0U9eQpDT05G
SUdfRFJNX1BBTkVMX0JSSURHRT15CgojCiMgRGlzcGxheSBJbnRlcmZhY2UgQnJpZGdlcwojCiMg
Q09ORklHX0RSTV9DSElQT05FX0lDTjYyMTEgaXMgbm90IHNldAojIENPTkZJR19EUk1fQ0hST05U
RUxfQ0g3MDMzIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0RJU1BMQVlfQ09OTkVDVE9SIGlzIG5v
dCBzZXQKIyBDT05GSUdfRFJNX0lURV9JVDY1MDUgaXMgbm90IHNldAojIENPTkZJR19EUk1fTE9O
VElVTV9MVDg5MTJCIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0xPTlRJVU1fTFQ5MjExIGlzIG5v
dCBzZXQKIyBDT05GSUdfRFJNX0xPTlRJVU1fTFQ5NjExIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJN
X0xPTlRJVU1fTFQ5NjExVVhDIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0lURV9JVDY2MTIxIGlz
IG5vdCBzZXQKIyBDT05GSUdfRFJNX0xWRFNfQ09ERUMgaXMgbm90IHNldAojIENPTkZJR19EUk1f
TUVHQUNISVBTX1NURFBYWFhYX0dFX0I4NTBWM19GVyBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9O
V0xfTUlQSV9EU0kgaXMgbm90IHNldAojIENPTkZJR19EUk1fTlhQX1BUTjM0NjAgaXMgbm90IHNl
dAojIENPTkZJR19EUk1fUEFSQURFX1BTODYyMiBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQVJB
REVfUFM4NjQwIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1NBTVNVTkdfRFNJTSBpcyBub3Qgc2V0
CiMgQ09ORklHX0RSTV9TSUxfU0lJODYyMCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9TSUk5MDJY
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1NJSTkyMzQgaXMgbm90IHNldAojIENPTkZJR19EUk1f
U0lNUExFX0JSSURHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9USElORV9USEM2M0xWRDEwMjQg
aXMgbm90IHNldAojIENPTkZJR19EUk1fVE9TSElCQV9UQzM1ODc2MiBpcyBub3Qgc2V0CiMgQ09O
RklHX0RSTV9UT1NISUJBX1RDMzU4NzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1RPU0hJQkFf
VEMzNTg3NjcgaXMgbm90IHNldAojIENPTkZJR19EUk1fVE9TSElCQV9UQzM1ODc2OCBpcyBub3Qg
c2V0CiMgQ09ORklHX0RSTV9UT1NISUJBX1RDMzU4Nzc1IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJN
X1RJX0RMUEMzNDMzIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1RJX1RGUDQxMCBpcyBub3Qgc2V0
CiMgQ09ORklHX0RSTV9USV9TTjY1RFNJODMgaXMgbm90IHNldAojIENPTkZJR19EUk1fVElfU042
NURTSTg2IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1RJX1RQRDEyUzAxNSBpcyBub3Qgc2V0CiMg
Q09ORklHX0RSTV9BTkFMT0dJWF9BTlg2MzQ1IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0FOQUxP
R0lYX0FOWDc4WFggaXMgbm90IHNldAojIENPTkZJR19EUk1fQU5BTE9HSVhfQU5YNzYyNSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RSTV9JMkNfQURWNzUxMSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9D
RE5TX0RTSSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9DRE5TX01IRFA4NTQ2IGlzIG5vdCBzZXQK
IyBlbmQgb2YgRGlzcGxheSBJbnRlcmZhY2UgQnJpZGdlcwoKIyBDT05GSUdfRFJNX0VUTkFWSVYg
aXMgbm90IHNldAojIENPTkZJR19EUk1fTE9HSUNWQyBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9B
UkNQR1UgaXMgbm90IHNldApDT05GSUdfRFJNX0JPQ0hTPW0KIyBDT05GSUdfRFJNX0NJUlJVU19R
RU1VIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0dNMTJVMzIwIGlzIG5vdCBzZXQKQ09ORklHX0RS
TV9TSU1QTEVEUk09eQojIENPTkZJR19EUk1fVkJPWFZJREVPIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFJNX0dVRCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9TU0QxMzBYIGlzIG5vdCBzZXQKQ09ORklH
X0RSTV9FWFBPUlRfRk9SX1RFU1RTPXkKQ09ORklHX0RSTV9MSUJfUkFORE9NPXkKQ09ORklHX0RS
TV9QUklWQUNZX1NDUkVFTj15CkNPTkZJR19EUk1fV0VSUk9SPXkKQ09ORklHX0RSTV9QQU5FTF9P
UklFTlRBVElPTl9RVUlSS1M9eQoKIwojIEZyYW1lIGJ1ZmZlciBEZXZpY2VzCiMKQ09ORklHX0ZC
PXkKIyBDT05GSUdfRkJfQ0lSUlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfUE0yIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkJfQ1lCRVIyMDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQVJDIGlzIG5v
dCBzZXQKIyBDT05GSUdfRkJfQVNJTElBTlQgaXMgbm90IHNldAojIENPTkZJR19GQl9JTVNUVCBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZCX1ZHQTE2IGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVVZFU0Eg
aXMgbm90IHNldAojIENPTkZJR19GQl9WRVNBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTjQxMSBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZCX0hHQSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX09QRU5DT1JF
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1MxRDEzWFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
TlZJRElBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfUklWQSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZC
X0k3NDAgaXMgbm90IHNldAojIENPTkZJR19GQl9NQVRST1ggaXMgbm90IHNldAojIENPTkZJR19G
Ql9SQURFT04gaXMgbm90IHNldAojIENPTkZJR19GQl9BVFkxMjggaXMgbm90IHNldAojIENPTkZJ
R19GQl9BVFkgaXMgbm90IHNldAojIENPTkZJR19GQl9TMyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZC
X1NBVkFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NJUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZC
X1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX05FT01BR0lDIGlzIG5vdCBzZXQKIyBDT05GSUdf
RkJfS1lSTyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCXzNERlggaXMgbm90IHNldAojIENPTkZJR19G
Ql9WVDg2MjMgaXMgbm90IHNldAojIENPTkZJR19GQl9UUklERU5UIGlzIG5vdCBzZXQKIyBDT05G
SUdfRkJfQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfUE0zIGlzIG5vdCBzZXQKIyBDT05GSUdf
RkJfQ0FSTUlORSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0dFT0RFIGlzIG5vdCBzZXQKIyBDT05G
SUdfRkJfU01TQ1VGWCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0lCTV9HWFQ0NTAwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkJfVklSVFVBTCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX01FVFJPTk9NRSBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZCX01CODYyWFggaXMgbm90IHNldAojIENPTkZJR19GQl9TU0Qx
MzA3IGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfU003MTIgaXMgbm90IHNldApDT05GSUdfRkJfQ09S
RT15CkNPTkZJR19GQl9OT1RJRlk9eQojIENPTkZJR19GSVJNV0FSRV9FRElEIGlzIG5vdCBzZXQK
IyBDT05GSUdfRkJfREVWSUNFIGlzIG5vdCBzZXQKQ09ORklHX0ZCX0NGQl9GSUxMUkVDVD15CkNP
TkZJR19GQl9DRkJfQ09QWUFSRUE9eQpDT05GSUdfRkJfQ0ZCX0lNQUdFQkxJVD15CkNPTkZJR19G
Ql9TWVNfRklMTFJFQ1Q9eQpDT05GSUdfRkJfU1lTX0NPUFlBUkVBPXkKQ09ORklHX0ZCX1NZU19J
TUFHRUJMSVQ9eQojIENPTkZJR19GQl9GT1JFSUdOX0VORElBTiBpcyBub3Qgc2V0CkNPTkZJR19G
Ql9TWVNNRU1fRk9QUz15CkNPTkZJR19GQl9ERUZFUlJFRF9JTz15CkNPTkZJR19GQl9JT01FTV9G
T1BTPXkKQ09ORklHX0ZCX0lPTUVNX0hFTFBFUlM9eQpDT05GSUdfRkJfU1lTTUVNX0hFTFBFUlM9
eQpDT05GSUdfRkJfU1lTTUVNX0hFTFBFUlNfREVGRVJSRUQ9eQojIENPTkZJR19GQl9NT0RFX0hF
TFBFUlMgaXMgbm90IHNldAojIENPTkZJR19GQl9USUxFQkxJVFRJTkcgaXMgbm90IHNldAojIGVu
ZCBvZiBGcmFtZSBidWZmZXIgRGV2aWNlcwoKIwojIEJhY2tsaWdodCAmIExDRCBkZXZpY2Ugc3Vw
cG9ydAojCkNPTkZJR19MQ0RfQ0xBU1NfREVWSUNFPW0KQ09ORklHX0xDRF9QTEFURk9STT1tCkNP
TkZJR19CQUNLTElHSFRfQ0xBU1NfREVWSUNFPW0KIyBDT05GSUdfQkFDS0xJR0hUX0tURDI1MyBp
cyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9LVEQyODAxIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkFDS0xJR0hUX0tUWjg4NjYgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfQVBQTEUgaXMg
bm90IHNldAojIENPTkZJR19CQUNLTElHSFRfUUNPTV9XTEVEIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkFDS0xJR0hUX1NBSEFSQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9BRFA4ODYwIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0FEUDg4NzAgaXMgbm90IHNldAojIENPTkZJR19C
QUNLTElHSFRfTE0zNTA5IGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0xNMzYzOSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJ
R0hUX0xWNTIwN0xQIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0JENjEwNyBpcyBub3Qg
c2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9BUkNYQ05OIGlzIG5vdCBzZXQKQ09ORklHX0JBQ0tMSUdI
VF9MRUQ9bQojIGVuZCBvZiBCYWNrbGlnaHQgJiBMQ0QgZGV2aWNlIHN1cHBvcnQKCkNPTkZJR19I
RE1JPXkKCiMKIyBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQKIwpDT05GSUdfVkdBX0NP
TlNPTEU9eQpDT05GSUdfRFVNTVlfQ09OU09MRT15CkNPTkZJR19EVU1NWV9DT05TT0xFX0NPTFVN
TlM9ODAKQ09ORklHX0RVTU1ZX0NPTlNPTEVfUk9XUz0yNQpDT05GSUdfRlJBTUVCVUZGRVJfQ09O
U09MRT15CiMgQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEVfTEVHQUNZX0FDQ0VMRVJBVElPTiBp
cyBub3Qgc2V0CkNPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xFX0RFVEVDVF9QUklNQVJZPXkKIyBD
T05GSUdfRlJBTUVCVUZGRVJfQ09OU09MRV9ST1RBVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZS
QU1FQlVGRkVSX0NPTlNPTEVfREVGRVJSRURfVEFLRU9WRVIgaXMgbm90IHNldAojIGVuZCBvZiBD
b25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQKCiMgQ09ORklHX0xPR08gaXMgbm90IHNldAoj
IGVuZCBvZiBHcmFwaGljcyBzdXBwb3J0CgojIENPTkZJR19EUk1fQUNDRUwgaXMgbm90IHNldApD
T05GSUdfU09VTkQ9bQpDT05GSUdfU05EPW0KQ09ORklHX1NORF9USU1FUj1tCkNPTkZJR19TTkRf
UENNPW0KQ09ORklHX1NORF9IV0RFUD1tCkNPTkZJR19TTkRfU0VRX0RFVklDRT1tCkNPTkZJR19T
TkRfUkFXTUlEST1tCkNPTkZJR19TTkRfQ09SRV9URVNUPW0KQ09ORklHX1NORF9KQUNLPXkKQ09O
RklHX1NORF9KQUNLX0lOUFVUX0RFVj15CiMgQ09ORklHX1NORF9PU1NFTVVMIGlzIG5vdCBzZXQK
Q09ORklHX1NORF9QQ01fVElNRVI9eQpDT05GSUdfU05EX0hSVElNRVI9bQpDT05GSUdfU05EX0RZ
TkFNSUNfTUlOT1JTPXkKQ09ORklHX1NORF9NQVhfQ0FSRFM9NgojIENPTkZJR19TTkRfU1VQUE9S
VF9PTERfQVBJIGlzIG5vdCBzZXQKQ09ORklHX1NORF9QUk9DX0ZTPXkKQ09ORklHX1NORF9WRVJC
T1NFX1BST0NGUz15CiMgQ09ORklHX1NORF9WRVJCT1NFX1BSSU5USyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9DVExfRkFTVF9MT09LVVAgaXMgbm90IHNldAojIENPTkZJR19TTkRfREVCVUcgaXMg
bm90IHNldApDT05GSUdfU05EX0NUTF9JTlBVVF9WQUxJREFUSU9OPXkKQ09ORklHX1NORF9WTUFT
VEVSPXkKQ09ORklHX1NORF9ETUFfU0dCVUY9eQpDT05GSUdfU05EX1NFUVVFTkNFUj1tCiMgQ09O
RklHX1NORF9TRVFfRFVNTVkgaXMgbm90IHNldApDT05GSUdfU05EX1NFUV9IUlRJTUVSX0RFRkFV
TFQ9eQpDT05GSUdfU05EX1NFUV9NSURJX0VWRU5UPW0KQ09ORklHX1NORF9TRVFfTUlEST1tCkNP
TkZJR19TTkRfU0VRX1ZJUk1JREk9bQojIENPTkZJR19TTkRfU0VRX1VNUCBpcyBub3Qgc2V0CkNP
TkZJR19TTkRfTVBVNDAxX1VBUlQ9bQpDT05GSUdfU05EX0RSSVZFUlM9eQpDT05GSUdfU05EX0RV
TU1ZPW0KQ09ORklHX1NORF9BTE9PUD1tCiMgQ09ORklHX1NORF9QQ01URVNUIGlzIG5vdCBzZXQK
Q09ORklHX1NORF9WSVJNSURJPW0KIyBDT05GSUdfU05EX01UUEFWIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX1NFUklBTF9VMTY1NTAgaXMgbm90IHNldApDT05GSUdfU05EX01QVTQwMT1tCkNPTkZJ
R19TTkRfUENJPXkKIyBDT05GSUdfU05EX0FEMTg4OSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9B
TFMzMDAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQUxTNDAwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9BTEk1NDUxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FTSUhQSSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9BVElJWFAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVRJSVhQX01PREVNIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX0FVODgxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BVTg4
MjAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVU4ODMwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0FXMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BWlQzMzI4IGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0JUODdYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NBMDEwNiBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9DTUlQQ0kgaXMgbm90IHNldAojIENPTkZJR19TTkRfT1hZR0VOIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX0NTNDI4MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9DUzQ2WFggaXMgbm90
IHNldAojIENPTkZJR19TTkRfQ1M1NTMwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NTNTUzNUFV
RElPIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NUWEZJIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0RBUkxBMjAgaXMgbm90IHNldAojIENPTkZJR19TTkRfR0lOQTIwIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX0xBWUxBMjAgaXMgbm90IHNldAojIENPTkZJR19TTkRfREFSTEEyNCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9HSU5BMjQgaXMgbm90IHNldAojIENPTkZJR19TTkRfTEFZTEEyNCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9NT05BIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01JQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9FQ0hPM0cgaXMgbm90IHNldAojIENPTkZJR19TTkRfSU5ESUdP
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lORElHT0lPIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0lORElHT0RKIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lORElHT0lPWCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9JTkRJR09ESlggaXMgbm90IHNldAojIENPTkZJR19TTkRfRU1VMTBLMSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9FTVUxMEsxWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FTlMx
MzcwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VOUzEzNzEgaXMgbm90IHNldAojIENPTkZJR19T
TkRfRVMxOTM4IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VTMTk2OCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9GTTgwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IRFNQIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX0hEU1BNIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lDRTE3MTIgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfSUNFMTcyNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9JTlRFTDhYMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9JTlRFTDhYME0gaXMgbm90IHNldAojIENPTkZJR19TTkRf
S09SRzEyMTIgaXMgbm90IHNldAojIENPTkZJR19TTkRfTE9MQSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9MWDY0NjRFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NQUVTVFJPMyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9NSVhBUlQgaXMgbm90IHNldAojIENPTkZJR19TTkRfTk0yNTYgaXMgbm90
IHNldAojIENPTkZJR19TTkRfUENYSFIgaXMgbm90IHNldAojIENPTkZJR19TTkRfUklQVElERSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9STUUzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9STUU5
NiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9STUU5NjUyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X1NFNlggaXMgbm90IHNldAojIENPTkZJR19TTkRfU0lTNzAxOSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9TT05JQ1ZJQkVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1RSSURFTlQgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfVklBODJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9WSUE4MlhYX01P
REVNIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1ZJUlRVT1NPIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX1ZYMjIyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1lNRlBDSSBpcyBub3Qgc2V0CgojCiMg
SEQtQXVkaW8KIwpDT05GSUdfU05EX0hEQT1tCkNPTkZJR19TTkRfSERBX0lOVEVMPW0KQ09ORklH
X1NORF9IREFfSFdERVA9eQpDT05GSUdfU05EX0hEQV9SRUNPTkZJRz15CiMgQ09ORklHX1NORF9I
REFfSU5QVVRfQkVFUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfUEFUQ0hfTE9BREVSIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9DSVJSVVNfU0NPREVDX0tVTklUX1RFU1QgaXMgbm90
IHNldAojIENPTkZJR19TTkRfSERBX0NPREVDX1JFQUxURUsgaXMgbm90IHNldAojIENPTkZJR19T
TkRfSERBX0NPREVDX0FOQUxPRyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfQ09ERUNfU0lH
TUFURUwgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NPREVDX1ZJQSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9IREFfQ09ERUNfSERNSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfQ09E
RUNfQ0lSUlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19DUzg0MDkgaXMgbm90
IHNldAojIENPTkZJR19TTkRfSERBX0NPREVDX0NPTkVYQU5UIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0hEQV9DT0RFQ19TRU5BUllURUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RF
Q19DQTAxMTAgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NPREVDX0NBMDEzMiBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9IREFfQ09ERUNfQ01FRElBIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0hEQV9DT0RFQ19TSTMwNTQgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0dFTkVSSUMgaXMg
bm90IHNldApDT05GSUdfU05EX0hEQV9QT1dFUl9TQVZFX0RFRkFVTFQ9MAojIENPTkZJR19TTkRf
SERBX0lOVEVMX0hETUlfU0lMRU5UX1NUUkVBTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFf
Q1RMX0RFVl9JRCBpcyBub3Qgc2V0CiMgZW5kIG9mIEhELUF1ZGlvCgpDT05GSUdfU05EX0hEQV9D
T1JFPW0KQ09ORklHX1NORF9IREFfQ09NUE9ORU5UPXkKQ09ORklHX1NORF9IREFfUFJFQUxMT0Nf
U0laRT0wCkNPTkZJR19TTkRfSU5URUxfTkhMVD15CkNPTkZJR19TTkRfSU5URUxfRFNQX0NPTkZJ
Rz1tCkNPTkZJR19TTkRfSU5URUxfU09VTkRXSVJFX0FDUEk9bQojIENPTkZJR19TTkRfVVNCIGlz
IG5vdCBzZXQKQ09ORklHX1NORF9QQ01DSUE9eQojIENPTkZJR19TTkRfVlhQT0NLRVQgaXMgbm90
IHNldAojIENPTkZJR19TTkRfUERBVURJT0NGIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPQyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9YODYgaXMgbm90IHNldAojIENPTkZJR19TTkRfVklSVElP
IGlzIG5vdCBzZXQKQ09ORklHX0hJRF9TVVBQT1JUPXkKQ09ORklHX0hJRD1tCkNPTkZJR19ISURf
QkFUVEVSWV9TVFJFTkdUSD15CkNPTkZJR19ISURSQVc9eQpDT05GSUdfVUhJRD1tCkNPTkZJR19I
SURfR0VORVJJQz1tCgojCiMgU3BlY2lhbCBISUQgZHJpdmVycwojCiMgQ09ORklHX0hJRF9BNFRF
Q0ggaXMgbm90IHNldAojIENPTkZJR19ISURfQUNDVVRPVUNIIGlzIG5vdCBzZXQKIyBDT05GSUdf
SElEX0FDUlVYIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0FQUExFIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX0FQUExFSVIgaXMgbm90IHNldAojIENPTkZJR19ISURfQVNVUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9BVVJFQUwgaXMgbm90IHNldAojIENPTkZJR19ISURfQkVMS0lOIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElEX0JFVE9QX0ZGIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0JJR0JFTl9G
RiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9DSEVSUlkgaXMgbm90IHNldAojIENPTkZJR19ISURf
Q0hJQ09OWSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9DT1JTQUlSIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX0NPVUdBUiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9NQUNBTExZIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX1BST0RJS0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9DTUVESUEgaXMg
bm90IHNldAojIENPTkZJR19ISURfQ1AyMTEyIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0NSRUFU
SVZFX1NCMDU0MCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9DWVBSRVNTIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX0RSQUdPTlJJU0UgaXMgbm90IHNldAojIENPTkZJR19ISURfRU1TX0ZGIGlzIG5v
dCBzZXQKIyBDT05GSUdfSElEX0VMQU4gaXMgbm90IHNldAojIENPTkZJR19ISURfRUxFQ09NIGlz
IG5vdCBzZXQKIyBDT05GSUdfSElEX0VMTyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9FVklTSU9O
IGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0VaS0VZIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0ZU
MjYwIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0dFTUJJUkQgaXMgbm90IHNldAojIENPTkZJR19I
SURfR0ZSTSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9HTE9SSU9VUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9IT0xURUsgaXMgbm90IHNldAojIENPTkZJR19ISURfR09PR0xFX1NUQURJQV9GRiBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9WSVZBTERJIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0dU
NjgzUiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9LRVlUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklH
X0hJRF9LWUUgaXMgbm90IHNldApDT05GSUdfSElEX1VDTE9HSUM9bQojIENPTkZJR19ISURfV0FM
VE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1ZJRVdTT05JQyBpcyBub3Qgc2V0CiMgQ09ORklH
X0hJRF9WUkMyIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1hJQU9NSSBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9HWVJBVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9JQ0FERSBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJRF9JVEUgaXMgbm90IHNldAojIENPTkZJR19ISURfSkFCUkEgaXMgbm90IHNl
dAojIENPTkZJR19ISURfVFdJTkhBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9LRU5TSU5HVE9O
IGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0xDUE9XRVIgaXMgbm90IHNldAojIENPTkZJR19ISURf
TEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0xFTk9WTyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9MRVRTS0VUQ0ggaXMgbm90IHNldAojIENPTkZJR19ISURfTE9HSVRFQ0ggaXMgbm90IHNldAoj
IENPTkZJR19ISURfTUFHSUNNT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9NQUxUUk9OIGlz
IG5vdCBzZXQKIyBDT05GSUdfSElEX01BWUZMQVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX01F
R0FXT1JMRF9GRiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9SRURSQUdPTiBpcyBub3Qgc2V0CkNP
TkZJR19ISURfTUlDUk9TT0ZUPW0KIyBDT05GSUdfSElEX01PTlRFUkVZIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX01VTFRJVE9VQ0ggaXMgbm90IHNldApDT05GSUdfSElEX05JTlRFTkRPPW0KIyBD
T05GSUdfTklOVEVORE9fRkYgaXMgbm90IHNldAojIENPTkZJR19ISURfTlRJIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX05UUklHIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX05WSURJQV9TSElFTEQg
aXMgbm90IHNldAojIENPTkZJR19ISURfT1JURUsgaXMgbm90IHNldAojIENPTkZJR19ISURfUEFO
VEhFUkxPUkQgaXMgbm90IHNldAojIENPTkZJR19ISURfUEVOTU9VTlQgaXMgbm90IHNldAojIENP
TkZJR19ISURfUEVUQUxZTlggaXMgbm90IHNldAojIENPTkZJR19ISURfUElDT0xDRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0hJRF9QTEFOVFJPTklDUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9QWFJD
IGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1JBWkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1BS
SU1BWCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9SRVRST0RFIGlzIG5vdCBzZXQKQ09ORklHX0hJ
RF9ST0NDQVQ9bQojIENPTkZJR19ISURfU0FJVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NB
TVNVTkcgaXMgbm90IHNldAojIENPTkZJR19ISURfU0VNSVRFSyBpcyBub3Qgc2V0CiMgQ09ORklH
X0hJRF9TSUdNQU1JQ1JPIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9TT05ZPW0KIyBDT05GSUdfU09O
WV9GRiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TUEVFRExJTksgaXMgbm90IHNldAojIENPTkZJ
R19ISURfU1RFQU0gaXMgbm90IHNldAojIENPTkZJR19ISURfU1RFRUxTRVJJRVMgaXMgbm90IHNl
dAojIENPTkZJR19ISURfU1VOUExVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9STUkgaXMgbm90
IHNldAojIENPTkZJR19ISURfR1JFRU5BU0lBIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NNQVJU
Sk9ZUExVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9USVZPIGlzIG5vdCBzZXQKIyBDT05GSUdf
SElEX1RPUFNFRUQgaXMgbm90IHNldAojIENPTkZJR19ISURfVE9QUkUgaXMgbm90IHNldAojIENP
TkZJR19ISURfVEhJTkdNIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1RIUlVTVE1BU1RFUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9VRFJBV19QUzMgaXMgbm90IHNldAojIENPTkZJR19ISURfVTJG
WkVSTyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9XQUNPTSBpcyBub3Qgc2V0CkNPTkZJR19ISURf
V0lJTU9URT1tCiMgQ09ORklHX0hJRF9XSU5XSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1hJ
Tk1PIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1pFUk9QTFVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SElEX1pZREFDUk9OIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NFTlNPUl9IVUIgaXMgbm90IHNl
dAojIENPTkZJR19ISURfQUxQUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9NQ1AyMjAwIGlzIG5v
dCBzZXQKIyBDT05GSUdfSElEX01DUDIyMjEgaXMgbm90IHNldApDT05GSUdfSElEX0tVTklUX1RF
U1Q9bQojIGVuZCBvZiBTcGVjaWFsIEhJRCBkcml2ZXJzCgojCiMgSElELUJQRiBzdXBwb3J0CiMK
IyBlbmQgb2YgSElELUJQRiBzdXBwb3J0CgojCiMgVVNCIEhJRCBzdXBwb3J0CiMKQ09ORklHX1VT
Ql9ISUQ9bQojIENPTkZJR19ISURfUElEIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9ISURERVY9eQoK
IwojIFVTQiBISUQgQm9vdCBQcm90b2NvbCBkcml2ZXJzCiMKIyBDT05GSUdfVVNCX0tCRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9NT1VTRSBpcyBub3Qgc2V0CiMgZW5kIG9mIFVTQiBISUQgQm9v
dCBQcm90b2NvbCBkcml2ZXJzCiMgZW5kIG9mIFVTQiBISUQgc3VwcG9ydAoKIyBDT05GSUdfSTJD
X0hJRCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfT0hDSV9MSVRUTEVfRU5ESUFOPXkKQ09ORklHX1VT
Ql9TVVBQT1JUPXkKQ09ORklHX1VTQl9DT01NT049bQojIENPTkZJR19VU0JfTEVEX1RSSUcgaXMg
bm90IHNldAojIENPTkZJR19VU0JfVUxQSV9CVVMgaXMgbm90IHNldAojIENPTkZJR19VU0JfQ09O
Tl9HUElPIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9BUkNIX0hBU19IQ0Q9eQpDT05GSUdfVVNCPW0K
Q09ORklHX1VTQl9QQ0k9eQojIENPTkZJR19VU0JfUENJX0FNRCBpcyBub3Qgc2V0CkNPTkZJR19V
U0JfQU5OT1VOQ0VfTkVXX0RFVklDRVM9eQoKIwojIE1pc2NlbGxhbmVvdXMgVVNCIG9wdGlvbnMK
IwpDT05GSUdfVVNCX0RFRkFVTFRfUEVSU0lTVD15CiMgQ09ORklHX1VTQl9GRVdfSU5JVF9SRVRS
SUVTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0RZTkFNSUNfTUlOT1JTIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX09URyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PVEdfUFJPRFVDVExJU1QgaXMg
bm90IHNldAojIENPTkZJR19VU0JfT1RHX0RJU0FCTEVfRVhURVJOQUxfSFVCIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX0xFRFNfVFJJR0dFUl9VU0JQT1JUIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9B
VVRPU1VTUEVORF9ERUxBWT0yCkNPTkZJR19VU0JfREVGQVVMVF9BVVRIT1JJWkFUSU9OX01PREU9
MQpDT05GSUdfVVNCX01PTj1tCgojCiMgVVNCIEhvc3QgQ29udHJvbGxlciBEcml2ZXJzCiMKIyBD
T05GSUdfVVNCX0M2N1gwMF9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfWEhDSV9IQ0QgaXMg
bm90IHNldApDT05GSUdfVVNCX0VIQ0lfSENEPW0KQ09ORklHX1VTQl9FSENJX1JPT1RfSFVCX1RU
PXkKQ09ORklHX1VTQl9FSENJX1RUX05FV1NDSEVEPXkKQ09ORklHX1VTQl9FSENJX1BDST1tCiMg
Q09ORklHX1VTQl9FSENJX0ZTTCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9FSENJX0hDRF9QTEFU
Rk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PWFUyMTBIUF9IQ0QgaXMgbm90IHNldAojIENP
TkZJR19VU0JfSVNQMTE2WF9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfT0hDSV9IQ0QgaXMg
bm90IHNldApDT05GSUdfVVNCX1VIQ0lfSENEPW0KIyBDT05GSUdfVVNCX1NMODExX0hDRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9SOEE2NjU5N19IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
SENEX1RFU1RfTU9ERSBpcyBub3Qgc2V0CgojCiMgVVNCIERldmljZSBDbGFzcyBkcml2ZXJzCiMK
IyBDT05GSUdfVVNCX0FDTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9QUklOVEVSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1dETSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9UTUMgaXMgbm90IHNl
dAoKIwojIE5PVEU6IFVTQl9TVE9SQUdFIGRlcGVuZHMgb24gU0NTSSBidXQgQkxLX0RFVl9TRCBt
YXkKIwoKIwojIGFsc28gYmUgbmVlZGVkOyBzZWUgVVNCX1NUT1JBR0UgSGVscCBmb3IgbW9yZSBp
bmZvCiMKQ09ORklHX1VTQl9TVE9SQUdFPW0KIyBDT05GSUdfVVNCX1NUT1JBR0VfREVCVUcgaXMg
bm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9SRUFMVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NUT1JBR0VfREFUQUZBQiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0ZSRUVD
T00gaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9JU0QyMDAgaXMgbm90IHNldAojIENP
TkZJR19VU0JfU1RPUkFHRV9VU0JBVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1NE
RFIwOSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1NERFI1NSBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9TVE9SQUdFX0pVTVBTSE9UIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JB
R0VfQUxBVURBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfT05FVE9VQ0ggaXMgbm90
IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9LQVJNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9T
VE9SQUdFX0NZUFJFU1NfQVRBQ0IgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9FTkVf
VUI2MjUwIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9VQVM9bQoKIwojIFVTQiBJbWFnaW5nIGRldmlj
ZXMKIwojIENPTkZJR19VU0JfTURDODAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX01JQ1JPVEVL
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCSVBfQ09SRSBpcyBub3Qgc2V0CgojCiMgVVNCIGR1YWwt
bW9kZSBjb250cm9sbGVyIGRyaXZlcnMKIwojIENPTkZJR19VU0JfQ0ROU19TVVBQT1JUIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX01VU0JfSERSQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9EV0Mz
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0RXQzIgaXMgbm90IHNldAojIENPTkZJR19VU0JfQ0hJ
UElERUEgaXMgbm90IHNldAojIENPTkZJR19VU0JfSVNQMTc2MCBpcyBub3Qgc2V0CgojCiMgVVNC
IHBvcnQgZHJpdmVycwojCkNPTkZJR19VU0JfU0VSSUFMPW0KIyBDT05GSUdfVVNCX1NFUklBTF9H
RU5FUklDIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9TSU1QTEUgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfU0VSSUFMX0FJUkNBQkxFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9BUkszMTE2IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9CRUxLSU4gaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX0NIMzQxIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9XSElURUhFQVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0RJR0lfQUNDRUxFUE9S
VCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfQ1AyMTBYIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NFUklBTF9DWVBSRVNTX004IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9F
TVBFRyBpcyBub3Qgc2V0CkNPTkZJR19VU0JfU0VSSUFMX0ZURElfU0lPPW0KIyBDT05GSUdfVVNC
X1NFUklBTF9WSVNPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfSVBBUSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfSVIgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFM
X0VER0VQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9FREdFUE9SVF9USSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfRjgxMjMyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NFUklBTF9GODE1M1ggaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0dBUk1JTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfSVBXIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NF
UklBTF9JVVUgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fUERBIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NFUklBTF9LTFNJIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LT0JJTF9TQ1QgaXMg
bm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX01DVF9VMjMyIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9NRVRSTyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTU9TNzcyMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTU9TNzg0MCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9TRVJJQUxfTVhVUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTkFWTUFO
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9QTDIzMDMgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfU0VSSUFMX09USTY4NTggaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1FDQVVY
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9RVUFMQ09NTSBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TRVJJQUxfU1BDUDhYNSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfU0FG
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfU0lFUlJBV0lSRUxFU1MgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX1NZTUJPTCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJ
QUxfVEkgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0NZQkVSSkFDSyBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9TRVJJQUxfT1BUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9PTU5JTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9PUFRJQ09OIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1NFUklBTF9YU0VOU19NVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9T
RVJJQUxfV0lTSEJPTkUgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1NTVTEwMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfUVQyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NF
UklBTF9VUEQ3OEYwNzMwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9YUiBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfREVCVUcgaXMgbm90IHNldAoKIwojIFVTQiBNaXNjZWxs
YW5lb3VzIGRyaXZlcnMKIwojIENPTkZJR19VU0JfRU1JNjIgaXMgbm90IHNldAojIENPTkZJR19V
U0JfRU1JMjYgaXMgbm90IHNldAojIENPTkZJR19VU0JfQURVVFVYIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NFVlNFRyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MRUdPVE9XRVIgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfTENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0NZUFJFU1NfQ1k3QzYz
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0NZVEhFUk0gaXMgbm90IHNldAojIENPTkZJR19VU0Jf
SURNT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BUFBMRURJU1BMQVkgaXMgbm90IHNldAoj
IENPTkZJR19BUFBMRV9NRklfRkFTVENIQVJHRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MSkNB
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NJU1VTQlZHQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9MRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9UUkFOQ0VWSUJSQVRPUiBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9JT1dBUlJJT1IgaXMgbm90IHNldAojIENPTkZJR19VU0JfVEVTVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9FSFNFVF9URVNUX0ZJWFRVUkUgaXMgbm90IHNldAojIENPTkZJR19V
U0JfSVNJR0hURlcgaXMgbm90IHNldAojIENPTkZJR19VU0JfWVVSRVggaXMgbm90IHNldAojIENP
TkZJR19VU0JfRVpVU0JfRlgyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hVQl9VU0IyNTFYQiBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9IU0lDX1VTQjM1MDMgaXMgbm90IHNldAojIENPTkZJR19V
U0JfSFNJQ19VU0I0NjA0IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xJTktfTEFZRVJfVEVTVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DSEFPU0tFWSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9P
TkJPQVJEX0RFViBpcyBub3Qgc2V0CgojCiMgVVNCIFBoeXNpY2FsIExheWVyIGRyaXZlcnMKIwoj
IENPTkZJR19OT1BfVVNCX1hDRUlWIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dQSU9fVkJVUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9JU1AxMzAxIGlzIG5vdCBzZXQKIyBlbmQgb2YgVVNCIFBo
eXNpY2FsIExheWVyIGRyaXZlcnMKCiMgQ09ORklHX1VTQl9HQURHRVQgaXMgbm90IHNldAojIENP
TkZJR19UWVBFQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9ST0xFX1NXSVRDSCBpcyBub3Qgc2V0
CiMgQ09ORklHX01NQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfVUZTSENEIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUVNU1RJQ0sgaXMgbm90IHNldApDT05GSUdfTkVXX0xFRFM9eQpDT05GSUdfTEVE
U19DTEFTUz15CiMgQ09ORklHX0xFRFNfQ0xBU1NfRkxBU0ggaXMgbm90IHNldAojIENPTkZJR19M
RURTX0NMQVNTX01VTFRJQ09MT1IgaXMgbm90IHNldApDT05GSUdfTEVEU19CUklHSFRORVNTX0hX
X0NIQU5HRUQ9eQoKIwojIExFRCBkcml2ZXJzCiMKIyBDT05GSUdfTEVEU19BTjMwMjU5QSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xFRFNfQVBVIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19BVzIwMFhY
IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19BVzIwMTMgaXMgbm90IHNldAojIENPTkZJR19MRURT
X0JDTTYzMjggaXMgbm90IHNldAojIENPTkZJR19MRURTX0JDTTYzNTggaXMgbm90IHNldAojIENP
TkZJR19MRURTX0xNMzUzMCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTE0zNTMyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTEVEU19MTTM2NDIgaXMgbm90IHNldAojIENPTkZJR19MRURTX0xNMzY5Mlgg
aXMgbm90IHNldAojIENPTkZJR19MRURTX1BDQTk1MzIgaXMgbm90IHNldAojIENPTkZJR19MRURT
X0dQSU8gaXMgbm90IHNldAojIENPTkZJR19MRURTX0xQMzk0NCBpcyBub3Qgc2V0CiMgQ09ORklH
X0xFRFNfTFAzOTUyIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MUDg4NjAgaXMgbm90IHNldAoj
IENPTkZJR19MRURTX1BDQTk1NVggaXMgbm90IHNldAojIENPTkZJR19MRURTX1BDQTk2M1ggaXMg
bm90IHNldAojIENPTkZJR19MRURTX1BDQTk5NVggaXMgbm90IHNldAojIENPTkZJR19MRURTX0JE
MjYwNk1WViBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfQkQyODAyIGlzIG5vdCBzZXQKIyBDT05G
SUdfTEVEU19JTlRFTF9TUzQyMDAgaXMgbm90IHNldAojIENPTkZJR19MRURTX0xUMzU5MyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xFRFNfVENBNjUwNyBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVExD
NTkxWFggaXMgbm90IHNldAojIENPTkZJR19MRURTX0xNMzU1eCBpcyBub3Qgc2V0CiMgQ09ORklH
X0xFRFNfT1QyMDAgaXMgbm90IHNldAojIENPTkZJR19MRURTX0lTMzFGTDMxOVggaXMgbm90IHNl
dAojIENPTkZJR19MRURTX0lTMzFGTDMyWFggaXMgbm90IHNldAoKIwojIExFRCBkcml2ZXIgZm9y
IGJsaW5rKDEpIFVTQiBSR0IgTEVEIGlzIHVuZGVyIFNwZWNpYWwgSElEIGRyaXZlcnMgKEhJRF9U
SElOR00pCiMKIyBDT05GSUdfTEVEU19CTElOS00gaXMgbm90IHNldAojIENPTkZJR19MRURTX01M
WENQTEQgaXMgbm90IHNldAojIENPTkZJR19MRURTX01MWFJFRyBpcyBub3Qgc2V0CiMgQ09ORklH
X0xFRFNfVVNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTklDNzhCWCBpcyBub3Qgc2V0CiMg
Q09ORklHX0xFRFNfTE0zNjk3IGlzIG5vdCBzZXQKCiMKIyBGbGFzaCBhbmQgVG9yY2ggTEVEIGRy
aXZlcnMKIwoKIwojIFJHQiBMRUQgZHJpdmVycwojCgojCiMgTEVEIFRyaWdnZXJzCiMKQ09ORklH
X0xFRFNfVFJJR0dFUlM9eQojIENPTkZJR19MRURTX1RSSUdHRVJfVElNRVIgaXMgbm90IHNldAoj
IENPTkZJR19MRURTX1RSSUdHRVJfT05FU0hPVCBpcyBub3Qgc2V0CkNPTkZJR19MRURTX1RSSUdH
RVJfRElTSz15CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9IRUFSVEJFQVQgaXMgbm90IHNldAojIENP
TkZJR19MRURTX1RSSUdHRVJfQkFDS0xJR0hUIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklH
R0VSX0NQVSBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9BQ1RJVklUWSBpcyBub3Qg
c2V0CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19U
UklHR0VSX0RFRkFVTFRfT04gaXMgbm90IHNldAoKIwojIGlwdGFibGVzIHRyaWdnZXIgaXMgdW5k
ZXIgTmV0ZmlsdGVyIGNvbmZpZyAoTEVEIHRhcmdldCkKIwojIENPTkZJR19MRURTX1RSSUdHRVJf
VFJBTlNJRU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX0NBTUVSQSBpcyBub3Qg
c2V0CkNPTkZJR19MRURTX1RSSUdHRVJfUEFOSUM9eQojIENPTkZJR19MRURTX1RSSUdHRVJfTkVU
REVWIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX1BBVFRFUk4gaXMgbm90IHNldAoj
IENPTkZJR19MRURTX1RSSUdHRVJfVFRZIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VS
X0lOUFVUX0VWRU5UUyBpcyBub3Qgc2V0CgojCiMgU2ltcGxlIExFRCBkcml2ZXJzCiMKIyBDT05G
SUdfQUNDRVNTSUJJTElUWSBpcyBub3Qgc2V0CiMgQ09ORklHX0lORklOSUJBTkQgaXMgbm90IHNl
dApDT05GSUdfRURBQ19BVE9NSUNfU0NSVUI9eQpDT05GSUdfRURBQ19TVVBQT1JUPXkKIyBDT05G
SUdfRURBQyBpcyBub3Qgc2V0CkNPTkZJR19SVENfTElCPXkKQ09ORklHX1JUQ19NQzE0NjgxOF9M
SUI9eQpDT05GSUdfUlRDX0NMQVNTPXkKIyBDT05GSUdfUlRDX0hDVE9TWVMgaXMgbm90IHNldApD
T05GSUdfUlRDX1NZU1RPSEM9eQpDT05GSUdfUlRDX1NZU1RPSENfREVWSUNFPSJydGMwIgojIENP
TkZJR19SVENfREVCVUcgaXMgbm90IHNldApDT05GSUdfUlRDX0xJQl9LVU5JVF9URVNUPW0KQ09O
RklHX1JUQ19OVk1FTT15CgojCiMgUlRDIGludGVyZmFjZXMKIwpDT05GSUdfUlRDX0lOVEZfU1lT
RlM9eQpDT05GSUdfUlRDX0lOVEZfUFJPQz15CkNPTkZJR19SVENfSU5URl9ERVY9eQojIENPTkZJ
R19SVENfSU5URl9ERVZfVUlFX0VNVUwgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1RFU1Qg
aXMgbm90IHNldAoKIwojIEkyQyBSVEMgZHJpdmVycwojCiMgQ09ORklHX1JUQ19EUlZfQUJCNVpF
UzMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0FCRU9aOSBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfQUJYODBYIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzEzMDcgaXMgbm90
IHNldAojIENPTkZJR19SVENfRFJWX0RTMTM3NCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZf
RFMxNjcyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9IWU04NTYzIGlzIG5vdCBzZXQKIyBD
T05GSUdfUlRDX0RSVl9NQVg2OTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NQVgzMTMz
NSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTkNUMzAxOFkgaXMgbm90IHNldAojIENPTkZJ
R19SVENfRFJWX1JTNUMzNzIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0lTTDEyMDggaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX0lTTDEyMDIyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRD
X0RSVl9JU0wxMjAyNiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfWDEyMDUgaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX1BDRjg1MjMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1BD
Rjg1MDYzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTM2MyBpcyBub3Qgc2V0CiMg
Q09ORklHX1JUQ19EUlZfUENGODU2MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENGODU4
MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTTQxVDgwIGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRDX0RSVl9CUTMySyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUzM1MzkwQSBpcyBub3Qg
c2V0CiMgQ09ORklHX1JUQ19EUlZfRk0zMTMwIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9S
WDgwMTAgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JYODExMSBpcyBub3Qgc2V0CiMgQ09O
RklHX1JUQ19EUlZfUlg4NTgxIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SWDgwMjUgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX0VNMzAyNyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19E
UlZfUlYzMDI4IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SVjMwMzIgaXMgbm90IHNldAoj
IENPTkZJR19SVENfRFJWX1JWODgwMyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfU0QzMDc4
IGlzIG5vdCBzZXQKCiMKIyBTUEkgUlRDIGRyaXZlcnMKIwpDT05GSUdfUlRDX0kyQ19BTkRfU1BJ
PXkKCiMKIyBTUEkgYW5kIEkyQyBSVEMgZHJpdmVycwojCiMgQ09ORklHX1JUQ19EUlZfRFMzMjMy
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0YyMTI3IGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRDX0RSVl9SVjMwMjlDMiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlg2MTEwIGlzIG5v
dCBzZXQKCiMKIyBQbGF0Zm9ybSBSVEMgZHJpdmVycwojCkNPTkZJR19SVENfRFJWX0NNT1M9eQoj
IENPTkZJR19SVENfRFJWX0RTMTI4NiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNTEx
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE1NTMgaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX0RTMTY4NV9GQU1JTFkgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RTMTc0MiBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMyNDA0IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRD
X0RSVl9TVEsxN1RBOCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTTQ4VDg2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRDX0RSVl9NNDhUMzUgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX000
OFQ1OSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTVNNNjI0MiBpcyBub3Qgc2V0CiMgQ09O
RklHX1JUQ19EUlZfUlA1QzAxIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9aWU5RTVAgaXMg
bm90IHNldAoKIwojIG9uLUNQVSBSVEMgZHJpdmVycwojCiMgQ09ORklHX1JUQ19EUlZfQ0FERU5D
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRlRSVEMwMTAgaXMgbm90IHNldAojIENPTkZJ
R19SVENfRFJWX1I3MzAxIGlzIG5vdCBzZXQKCiMKIyBISUQgU2Vuc29yIFJUQyBkcml2ZXJzCiMK
IyBDT05GSUdfUlRDX0RSVl9HT0xERklTSCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQURFVklDRVMg
aXMgbm90IHNldAoKIwojIERNQUJVRiBvcHRpb25zCiMKQ09ORklHX1NZTkNfRklMRT15CiMgQ09O
RklHX1NXX1NZTkMgaXMgbm90IHNldApDT05GSUdfVURNQUJVRj15CiMgQ09ORklHX0RNQUJVRl9N
T1ZFX05PVElGWSBpcyBub3Qgc2V0CkNPTkZJR19ETUFCVUZfREVCVUc9eQpDT05GSUdfRE1BQlVG
X1NFTEZURVNUUz1tCkNPTkZJR19ETUFCVUZfSEVBUFM9eQojIENPTkZJR19ETUFCVUZfU1lTRlNf
U1RBVFMgaXMgbm90IHNldApDT05GSUdfRE1BQlVGX0hFQVBTX1NZU1RFTT15CiMgZW5kIG9mIERN
QUJVRiBvcHRpb25zCgojIENPTkZJR19VSU8gaXMgbm90IHNldAojIENPTkZJR19WRklPIGlzIG5v
dCBzZXQKIyBDT05GSUdfVklSVF9EUklWRVJTIGlzIG5vdCBzZXQKQ09ORklHX1ZJUlRJT19BTkNI
T1I9eQpDT05GSUdfVklSVElPPXkKQ09ORklHX1ZJUlRJT19QQ0lfTElCPXkKQ09ORklHX1ZJUlRJ
T19QQ0lfTElCX0xFR0FDWT15CkNPTkZJR19WSVJUSU9fTUVOVT15CkNPTkZJR19WSVJUSU9fUENJ
PXkKQ09ORklHX1ZJUlRJT19QQ0lfQURNSU5fTEVHQUNZPXkKQ09ORklHX1ZJUlRJT19QQ0lfTEVH
QUNZPXkKIyBDT05GSUdfVklSVElPX0JBTExPT04gaXMgbm90IHNldAojIENPTkZJR19WSVJUSU9f
SU5QVVQgaXMgbm90IHNldAojIENPTkZJR19WSVJUSU9fTU1JTyBpcyBub3Qgc2V0CkNPTkZJR19W
SVJUSU9fRE1BX1NIQVJFRF9CVUZGRVI9bQojIENPTkZJR19WSVJUSU9fREVCVUcgaXMgbm90IHNl
dAojIENPTkZJR19WRFBBIGlzIG5vdCBzZXQKQ09ORklHX1ZIT1NUX0lPVExCPW0KQ09ORklHX1ZI
T1NUX1RBU0s9eQpDT05GSUdfVkhPU1Q9bQpDT05GSUdfVkhPU1RfTUVOVT15CkNPTkZJR19WSE9T
VF9ORVQ9bQojIENPTkZJR19WSE9TVF9WU09DSyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZIT1NUX0NS
T1NTX0VORElBTl9MRUdBQ1kgaXMgbm90IHNldAoKIwojIE1pY3Jvc29mdCBIeXBlci1WIGd1ZXN0
IHN1cHBvcnQKIwojIENPTkZJR19IWVBFUlYgaXMgbm90IHNldAojIGVuZCBvZiBNaWNyb3NvZnQg
SHlwZXItViBndWVzdCBzdXBwb3J0CgojIENPTkZJR19HUkVZQlVTIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ09NRURJIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RBR0lORyBpcyBub3Qgc2V0CiMgQ09ORklH
X0dPTERGSVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hST01FX1BMQVRGT1JNUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0NaTklDX1BMQVRGT1JNUyBpcyBub3Qgc2V0CiMgQ09ORklHX01FTExBTk9YX1BM
QVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfU1VSRkFDRV9QTEFURk9STVMgaXMgbm90IHNldApD
T05GSUdfWDg2X1BMQVRGT1JNX0RFVklDRVM9eQpDT05GSUdfQUNQSV9XTUk9bQojIENPTkZJR19X
TUlfQk1PRiBpcyBub3Qgc2V0CiMgQ09ORklHX0hVQVdFSV9XTUkgaXMgbm90IHNldAojIENPTkZJ
R19NWE1fV01JIGlzIG5vdCBzZXQKIyBDT05GSUdfTlZJRElBX1dNSV9FQ19CQUNLTElHSFQgaXMg
bm90IHNldAojIENPTkZJR19YSUFPTUlfV01JIGlzIG5vdCBzZXQKIyBDT05GSUdfR0lHQUJZVEVf
V01JIGlzIG5vdCBzZXQKIyBDT05GSUdfWU9HQUJPT0sgaXMgbm90IHNldAojIENPTkZJR19BQ0VS
SERGIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNFUl9XSVJFTEVTUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0FDRVJfV01JIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1EX1dCUkYgaXMgbm90IHNldAojIENPTkZJ
R19BRFZfU1dCVVRUT04gaXMgbm90IHNldAojIENPTkZJR19BUFBMRV9HTVVYIGlzIG5vdCBzZXQK
IyBDT05GSUdfQVNVU19MQVBUT1AgaXMgbm90IHNldAojIENPTkZJR19BU1VTX1dJUkVMRVNTIGlz
IG5vdCBzZXQKIyBDT05GSUdfQVNVU19URjEwM0NfRE9DSyBpcyBub3Qgc2V0CiMgQ09ORklHX1g4
Nl9QTEFURk9STV9EUklWRVJTX0RFTEwgaXMgbm90IHNldAojIENPTkZJR19BTUlMT19SRktJTEwg
aXMgbm90IHNldAojIENPTkZJR19GVUpJVFNVX0xBUFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZV
SklUU1VfVEFCTEVUIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BEX1BPQ0tFVF9GQU4gaXMgbm90IHNl
dAojIENPTkZJR19YODZfUExBVEZPUk1fRFJJVkVSU19IUCBpcyBub3Qgc2V0CiMgQ09ORklHX1dJ
UkVMRVNTX0hPVEtFWSBpcyBub3Qgc2V0CiMgQ09ORklHX0lCTV9SVEwgaXMgbm90IHNldAojIENP
TkZJR19JREVBUEFEX0xBUFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFTk9WT19ZTUMgaXMgbm90
IHNldApDT05GSUdfU0VOU09SU19IREFQUz1tCkNPTkZJR19USElOS1BBRF9BQ1BJPW0KQ09ORklH
X1RISU5LUEFEX0FDUElfQUxTQV9TVVBQT1JUPXkKIyBDT05GSUdfVEhJTktQQURfQUNQSV9ERUJV
R0ZBQ0lMSVRJRVMgaXMgbm90IHNldApDT05GSUdfVEhJTktQQURfQUNQSV9ERUJVRz15CiMgQ09O
RklHX1RISU5LUEFEX0FDUElfVU5TQUZFX0xFRFMgaXMgbm90IHNldAojIENPTkZJR19USElOS1BB
RF9BQ1BJX1ZJREVPIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhJTktQQURfQUNQSV9IT1RLRVlfUE9M
TCBpcyBub3Qgc2V0CkNPTkZJR19USElOS1BBRF9MTUk9bQojIENPTkZJR19JTlRFTF9TQVJfSU5U
MTA5MiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1dNSV9TQkxfRldfVVBEQVRFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSU5URUxfV01JX1RIVU5ERVJCT0xUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5U
RUxfSElEX0VWRU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfVkJUTiBpcyBub3Qgc2V0CiMg
Q09ORklHX0lOVEVMX0lOVDAwMDJfVkdQSU8gaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9PQUtU
UkFJTCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1BVTklUX0lQQyBpcyBub3Qgc2V0CiMgQ09O
RklHX0lOVEVMX1JTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1NNQVJUQ09OTkVDVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lOVEVMX1ZTRUMgaXMgbm90IHNldAojIENPTkZJR19BQ1BJX1FVSUNL
U1RBUlQgaXMgbm90IHNldAojIENPTkZJR19NRUVHT1BBRF9BTlg3NDI4IGlzIG5vdCBzZXQKIyBD
T05GSUdfTVNJX0VDIGlzIG5vdCBzZXQKIyBDT05GSUdfTVNJX0xBUFRPUCBpcyBub3Qgc2V0CiMg
Q09ORklHX01TSV9XTUkgaXMgbm90IHNldAojIENPTkZJR19NU0lfV01JX1BMQVRGT1JNIGlzIG5v
dCBzZXQKIyBDT05GSUdfUENFTkdJTkVTX0FQVTIgaXMgbm90IHNldAojIENPTkZJR19CQVJDT19Q
NTBfR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NBTVNVTkdfTEFQVE9QIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0FNU1VOR19RMTAgaXMgbm90IHNldAojIENPTkZJR19UT1NISUJBX0JUX1JGS0lMTCBp
cyBub3Qgc2V0CiMgQ09ORklHX1RPU0hJQkFfSEFQUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPU0hJ
QkFfV01JIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQSV9DTVBDIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q09NUEFMX0xBUFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX0xHX0xBUFRPUCBpcyBub3Qgc2V0CiMg
Q09ORklHX1BBTkFTT05JQ19MQVBUT1AgaXMgbm90IHNldAojIENPTkZJR19TT05ZX0xBUFRPUCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NZU1RFTTc2X0FDUEkgaXMgbm90IHNldAojIENPTkZJR19UT1BT
VEFSX0xBUFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX01MWF9QTEFURk9STSBpcyBub3Qgc2V0CiMg
Q09ORklHX0lOU1BVUl9QTEFURk9STV9QUk9GSUxFIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVOT1ZP
X1dNSV9DQU1FUkEgaXMgbm90IHNldApDT05GSUdfRldfQVRUUl9DTEFTUz1tCiMgQ09ORklHX0lO
VEVMX0lQUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1NDVV9QQ0kgaXMgbm90IHNldAojIENP
TkZJR19JTlRFTF9TQ1VfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJR19TSUVNRU5TX1NJTUFU
SUNfSVBDIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lOTUFURV9GTTA3X0tFWVMgaXMgbm90IHNldApD
T05GSUdfUDJTQj15CkNPTkZJR19IQVZFX0NMSz15CkNPTkZJR19IQVZFX0NMS19QUkVQQVJFPXkK
Q09ORklHX0NPTU1PTl9DTEs9eQojIENPTkZJR19DT01NT05fQ0xLX01BWDk0ODUgaXMgbm90IHNl
dAojIENPTkZJR19DT01NT05fQ0xLX1NJNTM0MSBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTU1PTl9D
TEtfU0k1MzUxIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NMS19TSTUxNCBpcyBub3Qgc2V0
CiMgQ09ORklHX0NPTU1PTl9DTEtfU0k1NDQgaXMgbm90IHNldAojIENPTkZJR19DT01NT05fQ0xL
X1NJNTcwIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NMS19DRENFNzA2IGlzIG5vdCBzZXQK
IyBDT05GSUdfQ09NTU9OX0NMS19DRENFOTI1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NM
S19DUzIwMDBfQ1AgaXMgbm90IHNldAojIENPTkZJR19DT01NT05fQ0xLX0FYSV9DTEtHRU4gaXMg
bm90IHNldAojIENPTkZJR19DT01NT05fQ0xLX1JTOV9QQ0lFIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q09NTU9OX0NMS19TSTUyMVhYIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NMS19WQzMgaXMg
bm90IHNldAojIENPTkZJR19DT01NT05fQ0xLX1ZDNSBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTU1P
Tl9DTEtfVkM3IGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NMS19GSVhFRF9NTUlPIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ0xLX0xHTV9DR1UgaXMgbm90IHNldAojIENPTkZJR19YSUxJTlhfVkNV
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NMS19YTE5YX0NMS1daUkQgaXMgbm90IHNldApD
T05GSUdfQ0xLX0tVTklUX1RFU1Q9bQpDT05GSUdfQ0xLX0dBVEVfS1VOSVRfVEVTVD1tCkNPTkZJ
R19DTEtfRkRfS1VOSVRfVEVTVD1tCiMgQ09ORklHX0hXU1BJTkxPQ0sgaXMgbm90IHNldAoKIwoj
IENsb2NrIFNvdXJjZSBkcml2ZXJzCiMKQ09ORklHX0NMS1NSQ19JODI1Mz15CkNPTkZJR19DTEtF
VlRfSTgyNTM9eQpDT05GSUdfQ0xLQkxEX0k4MjUzPXkKIyBlbmQgb2YgQ2xvY2sgU291cmNlIGRy
aXZlcnMKCiMgQ09ORklHX01BSUxCT1ggaXMgbm90IHNldAojIENPTkZJR19JT01NVV9TVVBQT1JU
IGlzIG5vdCBzZXQKCiMKIyBSZW1vdGVwcm9jIGRyaXZlcnMKIwojIENPTkZJR19SRU1PVEVQUk9D
IGlzIG5vdCBzZXQKIyBlbmQgb2YgUmVtb3RlcHJvYyBkcml2ZXJzCgojCiMgUnBtc2cgZHJpdmVy
cwojCiMgQ09ORklHX1JQTVNHX1ZJUlRJTyBpcyBub3Qgc2V0CiMgZW5kIG9mIFJwbXNnIGRyaXZl
cnMKCiMgQ09ORklHX1NPVU5EV0lSRSBpcyBub3Qgc2V0CgojCiMgU09DIChTeXN0ZW0gT24gQ2hp
cCkgc3BlY2lmaWMgRHJpdmVycwojCgojCiMgQW1sb2dpYyBTb0MgZHJpdmVycwojCiMgZW5kIG9m
IEFtbG9naWMgU29DIGRyaXZlcnMKCiMKIyBCcm9hZGNvbSBTb0MgZHJpdmVycwojCiMgZW5kIG9m
IEJyb2FkY29tIFNvQyBkcml2ZXJzCgojCiMgTlhQL0ZyZWVzY2FsZSBRb3JJUSBTb0MgZHJpdmVy
cwojCiMgZW5kIG9mIE5YUC9GcmVlc2NhbGUgUW9ySVEgU29DIGRyaXZlcnMKCiMKIyBmdWppdHN1
IFNvQyBkcml2ZXJzCiMKIyBlbmQgb2YgZnVqaXRzdSBTb0MgZHJpdmVycwoKIwojIGkuTVggU29D
IGRyaXZlcnMKIwojIGVuZCBvZiBpLk1YIFNvQyBkcml2ZXJzCgojCiMgRW5hYmxlIExpdGVYIFNv
QyBCdWlsZGVyIHNwZWNpZmljIGRyaXZlcnMKIwojIENPTkZJR19MSVRFWF9TT0NfQ09OVFJPTExF
UiBpcyBub3Qgc2V0CiMgZW5kIG9mIEVuYWJsZSBMaXRlWCBTb0MgQnVpbGRlciBzcGVjaWZpYyBk
cml2ZXJzCgojIENPTkZJR19XUENNNDUwX1NPQyBpcyBub3Qgc2V0CgojCiMgUXVhbGNvbW0gU29D
IGRyaXZlcnMKIwojIGVuZCBvZiBRdWFsY29tbSBTb0MgZHJpdmVycwoKIyBDT05GSUdfU09DX1RJ
IGlzIG5vdCBzZXQKCiMKIyBYaWxpbnggU29DIGRyaXZlcnMKIwojIGVuZCBvZiBYaWxpbnggU29D
IGRyaXZlcnMKIyBlbmQgb2YgU09DIChTeXN0ZW0gT24gQ2hpcCkgc3BlY2lmaWMgRHJpdmVycwoK
IwojIFBNIERvbWFpbnMKIwoKIwojIEFtbG9naWMgUE0gRG9tYWlucwojCiMgZW5kIG9mIEFtbG9n
aWMgUE0gRG9tYWlucwoKIwojIEJyb2FkY29tIFBNIERvbWFpbnMKIwojIGVuZCBvZiBCcm9hZGNv
bSBQTSBEb21haW5zCgojCiMgaS5NWCBQTSBEb21haW5zCiMKIyBlbmQgb2YgaS5NWCBQTSBEb21h
aW5zCgojCiMgUXVhbGNvbW0gUE0gRG9tYWlucwojCiMgZW5kIG9mIFF1YWxjb21tIFBNIERvbWFp
bnMKIyBlbmQgb2YgUE0gRG9tYWlucwoKIyBDT05GSUdfUE1fREVWRlJFUSBpcyBub3Qgc2V0CiMg
Q09ORklHX0VYVENPTiBpcyBub3Qgc2V0CiMgQ09ORklHX01FTU9SWSBpcyBub3Qgc2V0CiMgQ09O
RklHX0lJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05UQiBpcyBub3Qgc2V0CiMgQ09ORklHX1BXTSBp
cyBub3Qgc2V0CgojCiMgSVJRIGNoaXAgc3VwcG9ydAojCkNPTkZJR19JUlFDSElQPXkKIyBDT05G
SUdfQUxfRklDIGlzIG5vdCBzZXQKIyBDT05GSUdfTEFOOTY2WF9PSUMgaXMgbm90IHNldAojIENP
TkZJR19YSUxJTlhfSU5UQyBpcyBub3Qgc2V0CiMgZW5kIG9mIElSUSBjaGlwIHN1cHBvcnQKCiMg
Q09ORklHX0lQQUNLX0JVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFU0VUX0NPTlRST0xMRVIgaXMg
bm90IHNldAoKIwojIFBIWSBTdWJzeXN0ZW0KIwojIENPTkZJR19HRU5FUklDX1BIWSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9MR01fUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZX0NBTl9UUkFO
U0NFSVZFUiBpcyBub3Qgc2V0CgojCiMgUEhZIGRyaXZlcnMgZm9yIEJyb2FkY29tIHBsYXRmb3Jt
cwojCiMgQ09ORklHX0JDTV9LT05BX1VTQjJfUEhZIGlzIG5vdCBzZXQKIyBlbmQgb2YgUEhZIGRy
aXZlcnMgZm9yIEJyb2FkY29tIHBsYXRmb3JtcwoKIyBDT05GSUdfUEhZX0NBREVOQ0VfVE9SUkVO
VCBpcyBub3Qgc2V0CiMgQ09ORklHX1BIWV9DQURFTkNFX0RQSFkgaXMgbm90IHNldAojIENPTkZJ
R19QSFlfQ0FERU5DRV9EUEhZX1JYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZX0NBREVOQ0VfU0FM
Vk8gaXMgbm90IHNldAojIENPTkZJR19QSFlfUFhBXzI4Tk1fSFNJQyBpcyBub3Qgc2V0CiMgQ09O
RklHX1BIWV9QWEFfMjhOTV9VU0IyIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZX01BUFBIT05FX01E
TTY2MDAgaXMgbm90IHNldAojIENPTkZJR19QSFlfSU5URUxfTEdNX0NPTUJPIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEhZX0lOVEVMX0xHTV9FTU1DIGlzIG5vdCBzZXQKIyBlbmQgb2YgUEhZIFN1YnN5
c3RlbQoKIyBDT05GSUdfUE9XRVJDQVAgaXMgbm90IHNldAojIENPTkZJR19NQ0IgaXMgbm90IHNl
dAoKIwojIFBlcmZvcm1hbmNlIG1vbml0b3Igc3VwcG9ydAojCiMgQ09ORklHX0RXQ19QQ0lFX1BN
VSBpcyBub3Qgc2V0CiMgZW5kIG9mIFBlcmZvcm1hbmNlIG1vbml0b3Igc3VwcG9ydAoKQ09ORklH
X1JBUz15CiMgQ09ORklHX1VTQjQgaXMgbm90IHNldAoKIwojIEFuZHJvaWQKIwojIENPTkZJR19B
TkRST0lEX0JJTkRFUl9JUEMgaXMgbm90IHNldAojIGVuZCBvZiBBbmRyb2lkCgojIENPTkZJR19M
SUJOVkRJTU0gaXMgbm90IHNldAojIENPTkZJR19EQVggaXMgbm90IHNldApDT05GSUdfTlZNRU09
eQpDT05GSUdfTlZNRU1fU1lTRlM9eQpDT05GSUdfTlZNRU1fTEFZT1VUUz15CgojCiMgTGF5b3V0
IFR5cGVzCiMKIyBDT05GSUdfTlZNRU1fTEFZT1VUX1NMMjhfVlBEIGlzIG5vdCBzZXQKIyBDT05G
SUdfTlZNRU1fTEFZT1VUX09OSUVfVExWIGlzIG5vdCBzZXQKIyBlbmQgb2YgTGF5b3V0IFR5cGVz
CgojIENPTkZJR19OVk1FTV9STUVNIGlzIG5vdCBzZXQKCiMKIyBIVyB0cmFjaW5nIHN1cHBvcnQK
IwojIENPTkZJR19TVE0gaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9USCBpcyBub3Qgc2V0CiMg
ZW5kIG9mIEhXIHRyYWNpbmcgc3VwcG9ydAoKIyBDT05GSUdfRlBHQSBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZTSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NJT1ggaXMgbm90IHNldAojIENPTkZJR19TTElN
QlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URVJDT05ORUNUIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q09VTlRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX01PU1QgaXMgbm90IHNldAojIENPTkZJR19QRUNJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfSFRFIGlzIG5vdCBzZXQKIyBlbmQgb2YgRGV2aWNlIERyaXZl
cnMKCiMKIyBGaWxlIHN5c3RlbXMKIwpDT05GSUdfRENBQ0hFX1dPUkRfQUNDRVNTPXkKQ09ORklH
X1ZBTElEQVRFX0ZTX1BBUlNFUj15CkNPTkZJR19GU19JT01BUD15CkNPTkZJR19GU19TVEFDSz15
CkNPTkZJR19CVUZGRVJfSEVBRD15CkNPTkZJR19MRUdBQ1lfRElSRUNUX0lPPXkKIyBDT05GSUdf
RVhUMl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVDNfRlMgaXMgbm90IHNldApDT05GSUdfRVhU
NF9GUz15CkNPTkZJR19FWFQ0X1VTRV9GT1JfRVhUMj15CkNPTkZJR19FWFQ0X0ZTX1BPU0lYX0FD
TD15CiMgQ09ORklHX0VYVDRfRlNfU0VDVVJJVFkgaXMgbm90IHNldAojIENPTkZJR19FWFQ0X0RF
QlVHIGlzIG5vdCBzZXQKQ09ORklHX0VYVDRfS1VOSVRfVEVTVFM9bQpDT05GSUdfSkJEMj15CiMg
Q09ORklHX0pCRDJfREVCVUcgaXMgbm90IHNldApDT05GSUdfRlNfTUJDQUNIRT15CiMgQ09ORklH
X1JFSVNFUkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSkZTX0ZTIGlzIG5vdCBzZXQKQ09ORklH
X1hGU19GUz1tCiMgQ09ORklHX1hGU19TVVBQT1JUX1Y0IGlzIG5vdCBzZXQKIyBDT05GSUdfWEZT
X1NVUFBPUlRfQVNDSUlfQ0kgaXMgbm90IHNldAojIENPTkZJR19YRlNfUVVPVEEgaXMgbm90IHNl
dApDT05GSUdfWEZTX1BPU0lYX0FDTD15CiMgQ09ORklHX1hGU19SVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1hGU19PTkxJTkVfU0NSVUIgaXMgbm90IHNldAojIENPTkZJR19YRlNfV0FSTiBpcyBub3Qg
c2V0CiMgQ09ORklHX1hGU19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0dGUzJfRlMgaXMgbm90
IHNldAojIENPTkZJR19PQ0ZTMl9GUyBpcyBub3Qgc2V0CkNPTkZJR19CVFJGU19GUz15CkNPTkZJ
R19CVFJGU19GU19QT1NJWF9BQ0w9eQojIENPTkZJR19CVFJGU19GU19SVU5fU0FOSVRZX1RFU1RT
IGlzIG5vdCBzZXQKIyBDT05GSUdfQlRSRlNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19CVFJG
U19BU1NFUlQgaXMgbm90IHNldAojIENPTkZJR19CVFJGU19GU19SRUZfVkVSSUZZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTklMRlMyX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRjJGU19GUyBpcyBub3Qg
c2V0CkNPTkZJR19CQ0FDSEVGU19GUz1tCiMgQ09ORklHX0JDQUNIRUZTX1FVT1RBIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkNBQ0hFRlNfRVJBU1VSRV9DT0RJTkcgaXMgbm90IHNldApDT05GSUdfQkNB
Q0hFRlNfUE9TSVhfQUNMPXkKIyBDT05GSUdfQkNBQ0hFRlNfREVCVUcgaXMgbm90IHNldApDT05G
SUdfQkNBQ0hFRlNfVEVTVFM9eQojIENPTkZJR19CQ0FDSEVGU19MT0NLX1RJTUVfU1RBVFMgaXMg
bm90IHNldAojIENPTkZJR19CQ0FDSEVGU19OT19MQVRFTkNZX0FDQ1QgaXMgbm90IHNldApDT05G
SUdfQkNBQ0hFRlNfU0lYX09QVElNSVNUSUNfU1BJTj15CiMgQ09ORklHX01FQU5fQU5EX1ZBUklB
TkNFX1VOSVRfVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19GU19QT1NJWF9BQ0w9eQpDT05GSUdfRVhQ
T1JURlM9eQojIENPTkZJR19FWFBPUlRGU19CTE9DS19PUFMgaXMgbm90IHNldApDT05GSUdfRklM
RV9MT0NLSU5HPXkKIyBDT05GSUdfRlNfRU5DUllQVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZT
X1ZFUklUWSBpcyBub3Qgc2V0CkNPTkZJR19GU05PVElGWT15CkNPTkZJR19ETk9USUZZPXkKQ09O
RklHX0lOT1RJRllfVVNFUj15CkNPTkZJR19GQU5PVElGWT15CiMgQ09ORklHX0ZBTk9USUZZX0FD
Q0VTU19QRVJNSVNTSU9OUyBpcyBub3Qgc2V0CiMgQ09ORklHX1FVT1RBIGlzIG5vdCBzZXQKQ09O
RklHX0FVVE9GU19GUz15CkNPTkZJR19GVVNFX0ZTPW0KIyBDT05GSUdfQ1VTRSBpcyBub3Qgc2V0
CkNPTkZJR19WSVJUSU9fRlM9bQpDT05GSUdfRlVTRV9QQVNTVEhST1VHSD15CiMgQ09ORklHX09W
RVJMQVlfRlMgaXMgbm90IHNldAoKIwojIENhY2hlcwojCkNPTkZJR19ORVRGU19TVVBQT1JUPXkK
IyBDT05GSUdfTkVURlNfU1RBVFMgaXMgbm90IHNldAojIENPTkZJR19GU0NBQ0hFIGlzIG5vdCBz
ZXQKIyBlbmQgb2YgQ2FjaGVzCgojCiMgQ0QtUk9NL0RWRCBGaWxlc3lzdGVtcwojCkNPTkZJR19J
U085NjYwX0ZTPXkKQ09ORklHX0pPTElFVD15CkNPTkZJR19aSVNPRlM9eQpDT05GSUdfVURGX0ZT
PW0KIyBlbmQgb2YgQ0QtUk9NL0RWRCBGaWxlc3lzdGVtcwoKIwojIERPUy9GQVQvRVhGQVQvTlQg
RmlsZXN5c3RlbXMKIwpDT05GSUdfRkFUX0ZTPW0KQ09ORklHX01TRE9TX0ZTPW0KQ09ORklHX1ZG
QVRfRlM9bQpDT05GSUdfRkFUX0RFRkFVTFRfQ09ERVBBR0U9NDM3CkNPTkZJR19GQVRfREVGQVVM
VF9JT0NIQVJTRVQ9Imlzbzg4NTktMTUiCkNPTkZJR19GQVRfREVGQVVMVF9VVEY4PXkKQ09ORklH
X0ZBVF9LVU5JVF9URVNUPW0KQ09ORklHX0VYRkFUX0ZTPW0KQ09ORklHX0VYRkFUX0RFRkFVTFRf
SU9DSEFSU0VUPSJ1dGY4IgpDT05GSUdfTlRGUzNfRlM9bQpDT05GSUdfTlRGUzNfTFpYX1hQUkVT
Uz15CiMgQ09ORklHX05URlMzX0ZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CiMgQ09ORklHX05URlNf
RlMgaXMgbm90IHNldAojIGVuZCBvZiBET1MvRkFUL0VYRkFUL05UIEZpbGVzeXN0ZW1zCgojCiMg
UHNldWRvIGZpbGVzeXN0ZW1zCiMKQ09ORklHX1BST0NfRlM9eQojIENPTkZJR19QUk9DX0tDT1JF
IGlzIG5vdCBzZXQKQ09ORklHX1BST0NfU1lTQ1RMPXkKQ09ORklHX1BST0NfUEFHRV9NT05JVE9S
PXkKIyBDT05GSUdfUFJPQ19DSElMRFJFTiBpcyBub3Qgc2V0CkNPTkZJR19QUk9DX1BJRF9BUkNI
X1NUQVRVUz15CkNPTkZJR19LRVJORlM9eQpDT05GSUdfU1lTRlM9eQpDT05GSUdfVE1QRlM9eQpD
T05GSUdfVE1QRlNfUE9TSVhfQUNMPXkKQ09ORklHX1RNUEZTX1hBVFRSPXkKIyBDT05GSUdfVE1Q
RlNfUVVPVEEgaXMgbm90IHNldApDT05GSUdfSFVHRVRMQkZTPXkKQ09ORklHX0hVR0VUTEJfUEFH
RT15CkNPTkZJR19DT05GSUdGU19GUz1tCiMgZW5kIG9mIFBzZXVkbyBmaWxlc3lzdGVtcwoKQ09O
RklHX01JU0NfRklMRVNZU1RFTVM9eQojIENPTkZJR19PUkFOR0VGU19GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0FERlNfRlMgaXMgbm90IHNldApDT05GSUdfQUZGU19GUz1tCiMgQ09ORklHX0VDUllQ
VF9GUyBpcyBub3Qgc2V0CkNPTkZJR19IRlNfRlM9bQpDT05GSUdfSEZTUExVU19GUz1tCkNPTkZJ
R19CRUZTX0ZTPW0KQ09ORklHX0JFRlNfREVCVUc9eQojIENPTkZJR19CRlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19FRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19DUkFNRlMgaXMgbm90IHNldAoj
IENPTkZJR19TUVVBU0hGUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZYRlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19NSU5JWF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX09NRlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19IUEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfUU5YNEZTX0ZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfUU5YNkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfUk9NRlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19QU1RPUkUgaXMgbm90IHNldAojIENPTkZJR19TWVNWX0ZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfVUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRVJPRlNfRlMgaXMgbm90IHNldApD
T05GSUdfTkVUV09SS19GSUxFU1lTVEVNUz15CkNPTkZJR19ORlNfRlM9bQojIENPTkZJR19ORlNf
VjIgaXMgbm90IHNldAojIENPTkZJR19ORlNfVjMgaXMgbm90IHNldApDT05GSUdfTkZTX1Y0PW0K
IyBDT05GSUdfTkZTX1NXQVAgaXMgbm90IHNldApDT05GSUdfTkZTX1Y0XzE9eQpDT05GSUdfTkZT
X1Y0XzI9eQpDT05GSUdfUE5GU19GSUxFX0xBWU9VVD1tCkNPTkZJR19QTkZTX0JMT0NLPW0KQ09O
RklHX1BORlNfRkxFWEZJTEVfTEFZT1VUPW0KQ09ORklHX05GU19WNF8xX0lNUExFTUVOVEFUSU9O
X0lEX0RPTUFJTj0ia2VybmVsLm9yZyIKIyBDT05GSUdfTkZTX1Y0XzFfTUlHUkFUSU9OIGlzIG5v
dCBzZXQKQ09ORklHX05GU19WNF9TRUNVUklUWV9MQUJFTD15CiMgQ09ORklHX05GU19GU0NBQ0hF
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTX1VTRV9MRUdBQ1lfRE5TIGlzIG5vdCBzZXQKQ09ORklH
X05GU19VU0VfS0VSTkVMX0ROUz15CkNPTkZJR19ORlNfREVCVUc9eQpDT05GSUdfTkZTX0RJU0FC
TEVfVURQX1NVUFBPUlQ9eQojIENPTkZJR19ORlNfVjRfMl9SRUFEX1BMVVMgaXMgbm90IHNldAoj
IENPTkZJR19ORlNEIGlzIG5vdCBzZXQKQ09ORklHX0dSQUNFX1BFUklPRD1tCkNPTkZJR19MT0NL
RD1tCkNPTkZJR19ORlNfQ09NTU9OPXkKQ09ORklHX05GU19WNF8yX1NTQ19IRUxQRVI9eQpDT05G
SUdfU1VOUlBDPW0KQ09ORklHX1NVTlJQQ19CQUNLQ0hBTk5FTD15CiMgQ09ORklHX1JQQ1NFQ19H
U1NfS1JCNSBpcyBub3Qgc2V0CkNPTkZJR19TVU5SUENfREVCVUc9eQojIENPTkZJR19DRVBIX0ZT
IGlzIG5vdCBzZXQKQ09ORklHX0NJRlM9bQpDT05GSUdfQ0lGU19TVEFUUzI9eQpDT05GSUdfQ0lG
U19BTExPV19JTlNFQ1VSRV9MRUdBQ1k9eQojIENPTkZJR19DSUZTX1VQQ0FMTCBpcyBub3Qgc2V0
CkNPTkZJR19DSUZTX1hBVFRSPXkKQ09ORklHX0NJRlNfUE9TSVg9eQpDT05GSUdfQ0lGU19ERUJV
Rz15CiMgQ09ORklHX0NJRlNfREVCVUcyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0lGU19ERUJVR19E
VU1QX0tFWVMgaXMgbm90IHNldApDT05GSUdfQ0lGU19ERlNfVVBDQUxMPXkKQ09ORklHX0NJRlNf
U1dOX1VQQ0FMTD15CiMgQ09ORklHX1NNQl9TRVJWRVIgaXMgbm90IHNldApDT05GSUdfU01CRlM9
bQojIENPTkZJR19DT0RBX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUZTX0ZTIGlzIG5vdCBzZXQK
Q09ORklHXzlQX0ZTPXkKQ09ORklHXzlQX0ZTX1BPU0lYX0FDTD15CiMgQ09ORklHXzlQX0ZTX1NF
Q1VSSVRZIGlzIG5vdCBzZXQKQ09ORklHX05MUz15CkNPTkZJR19OTFNfREVGQVVMVD0idXRmOCIK
Q09ORklHX05MU19DT0RFUEFHRV80Mzc9bQojIENPTkZJR19OTFNfQ09ERVBBR0VfNzM3IGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzc3NSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQ09E
RVBBR0VfODUwPW0KIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MiBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19DT0RFUEFHRV84NTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODU3IGlz
IG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MCBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19DT0RFUEFHRV84NjEgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYyIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19D
T0RFUEFHRV84NjQgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV84NjkgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTM2IGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzk1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV85MzIgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTQ5IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzg3NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5Xzgg
aXMgbm90IHNldApDT05GSUdfTkxTX0NPREVQQUdFXzEyNTA9bQojIENPTkZJR19OTFNfQ09ERVBB
R0VfMTI1MSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19BU0NJSSBpcyBub3Qgc2V0CkNPTkZJR19O
TFNfSVNPODg1OV8xPW0KIyBDT05GSUdfTkxTX0lTTzg4NTlfMiBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19JU084ODU5XzMgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV80IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5
XzYgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV83IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0lTTzg4NTlfOSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzEzIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTQgaXMgbm90IHNldApDT05GSUdfTkxTX0lTTzg4NTlf
MTU9bQojIENPTkZJR19OTFNfS09JOF9SIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tPSThfVSBp
cyBub3Qgc2V0CkNPTkZJR19OTFNfTUFDX1JPTUFOPW0KIyBDT05GSUdfTkxTX01BQ19DRUxUSUMg
aXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0NFTlRFVVJPIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX01BQ19DUk9BVElBTiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfQ1lSSUxMSUMgaXMg
bm90IHNldAojIENPTkZJR19OTFNfTUFDX0dBRUxJQyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19N
QUNfR1JFRUsgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0lDRUxBTkQgaXMgbm90IHNldAoj
IENPTkZJR19OTFNfTUFDX0lOVUlUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19ST01BTklB
TiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfVFVSS0lTSCBpcyBub3Qgc2V0CkNPTkZJR19O
TFNfVVRGOD15CkNPTkZJR19OTFNfVUNTMl9VVElMUz1tCiMgQ09ORklHX0RMTSBpcyBub3Qgc2V0
CkNPTkZJR19VTklDT0RFPW0KIyBDT05GSUdfVU5JQ09ERV9OT1JNQUxJWkFUSU9OX1NFTEZURVNU
IGlzIG5vdCBzZXQKQ09ORklHX0lPX1dRPXkKIyBlbmQgb2YgRmlsZSBzeXN0ZW1zCgojCiMgU2Vj
dXJpdHkgb3B0aW9ucwojCkNPTkZJR19LRVlTPXkKQ09ORklHX0tFWVNfUkVRVUVTVF9DQUNIRT15
CiMgQ09ORklHX1BFUlNJU1RFTlRfS0VZUklOR1MgaXMgbm90IHNldAojIENPTkZJR19UUlVTVEVE
X0tFWVMgaXMgbm90IHNldAojIENPTkZJR19FTkNSWVBURURfS0VZUyBpcyBub3Qgc2V0CkNPTkZJ
R19LRVlfREhfT1BFUkFUSU9OUz15CkNPTkZJR19LRVlfTk9USUZJQ0FUSU9OUz15CiMgQ09ORklH
X1NFQ1VSSVRZX0RNRVNHX1JFU1RSSUNUIGlzIG5vdCBzZXQKQ09ORklHX1NFQ1VSSVRZPXkKIyBD
T05GSUdfU0VDVVJJVFlGUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX05FVFdPUksgaXMg
bm90IHNldAojIENPTkZJR19TRUNVUklUWV9QQVRIIGlzIG5vdCBzZXQKQ09ORklHX0hBUkRFTkVE
X1VTRVJDT1BZPXkKIyBDT05GSUdfU1RBVElDX1VTRVJNT0RFSEVMUEVSIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VDVVJJVFlfU01BQ0sgaXMgbm90IHNldAojIENPTkZJR19TRUNVUklUWV9UT01PWU8g
aXMgbm90IHNldAojIENPTkZJR19TRUNVUklUWV9BUFBBUk1PUiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFQ1VSSVRZX0xPQURQSU4gaXMgbm90IHNldApDT05GSUdfU0VDVVJJVFlfWUFNQT15CiMgQ09O
RklHX1NFQ1VSSVRZX1NBRkVTRVRJRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX0xPQ0tE
T1dOX0xTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX0xBTkRMT0NLIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5URUdSSVRZIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfU0VDVVJJVFlfREFD
PXkKQ09ORklHX0xTTT0ibGFuZGxvY2ssbG9ja2Rvd24seWFtYSxsb2FkcGluLHNhZmVzZXRpZCxp
bnRlZ3JpdHksc2VsaW51eCxzbWFjayx0b21veW8sYXBwYXJtb3IsYnBmIgoKIwojIEtlcm5lbCBo
YXJkZW5pbmcgb3B0aW9ucwojCgojCiMgTWVtb3J5IGluaXRpYWxpemF0aW9uCiMKQ09ORklHX0ND
X0hBU19BVVRPX1ZBUl9JTklUX1BBVFRFUk49eQpDT05GSUdfQ0NfSEFTX0FVVE9fVkFSX0lOSVRf
WkVST19CQVJFPXkKQ09ORklHX0NDX0hBU19BVVRPX1ZBUl9JTklUX1pFUk89eQojIENPTkZJR19J
TklUX1NUQUNLX05PTkUgaXMgbm90IHNldApDT05GSUdfSU5JVF9TVEFDS19BTExfUEFUVEVSTj15
CiMgQ09ORklHX0lOSVRfU1RBQ0tfQUxMX1pFUk8gaXMgbm90IHNldApDT05GSUdfSU5JVF9PTl9B
TExPQ19ERUZBVUxUX09OPXkKIyBDT05GSUdfSU5JVF9PTl9GUkVFX0RFRkFVTFRfT04gaXMgbm90
IHNldApDT05GSUdfQ0NfSEFTX1pFUk9fQ0FMTF9VU0VEX1JFR1M9eQpDT05GSUdfWkVST19DQUxM
X1VTRURfUkVHUz15CiMgZW5kIG9mIE1lbW9yeSBpbml0aWFsaXphdGlvbgoKIwojIEhhcmRlbmlu
ZyBvZiBrZXJuZWwgZGF0YSBzdHJ1Y3R1cmVzCiMKQ09ORklHX0xJU1RfSEFSREVORUQ9eQpDT05G
SUdfQlVHX09OX0RBVEFfQ09SUlVQVElPTj15CiMgZW5kIG9mIEhhcmRlbmluZyBvZiBrZXJuZWwg
ZGF0YSBzdHJ1Y3R1cmVzCgpDT05GSUdfQ0NfSEFTX1JBTkRTVFJVQ1Q9eQpDT05GSUdfUkFORFNU
UlVDVF9OT05FPXkKIyBDT05GSUdfUkFORFNUUlVDVF9GVUxMIGlzIG5vdCBzZXQKIyBlbmQgb2Yg
S2VybmVsIGhhcmRlbmluZyBvcHRpb25zCiMgZW5kIG9mIFNlY3VyaXR5IG9wdGlvbnMKCkNPTkZJ
R19YT1JfQkxPQ0tTPXkKQ09ORklHX0FTWU5DX0NPUkU9bQpDT05GSUdfQVNZTkNfTUVNQ1BZPW0K
Q09ORklHX0FTWU5DX1hPUj1tCkNPTkZJR19BU1lOQ19QUT1tCkNPTkZJR19BU1lOQ19SQUlENl9S
RUNPVj1tCkNPTkZJR19DUllQVE89eQoKIwojIENyeXB0byBjb3JlIG9yIGhlbHBlcgojCkNPTkZJ
R19DUllQVE9fQUxHQVBJPXkKQ09ORklHX0NSWVBUT19BTEdBUEkyPXkKQ09ORklHX0NSWVBUT19B
RUFEPW0KQ09ORklHX0NSWVBUT19BRUFEMj15CkNPTkZJR19DUllQVE9fU0lHPXkKQ09ORklHX0NS
WVBUT19TSUcyPXkKQ09ORklHX0NSWVBUT19TS0NJUEhFUj1tCkNPTkZJR19DUllQVE9fU0tDSVBI
RVIyPXkKQ09ORklHX0NSWVBUT19IQVNIPXkKQ09ORklHX0NSWVBUT19IQVNIMj15CkNPTkZJR19D
UllQVE9fUk5HPW0KQ09ORklHX0NSWVBUT19STkcyPXkKQ09ORklHX0NSWVBUT19STkdfREVGQVVM
VD1tCkNPTkZJR19DUllQVE9fQUtDSVBIRVIyPXkKQ09ORklHX0NSWVBUT19BS0NJUEhFUj15CkNP
TkZJR19DUllQVE9fS1BQMj15CkNPTkZJR19DUllQVE9fS1BQPXkKQ09ORklHX0NSWVBUT19BQ09N
UDI9eQpDT05GSUdfQ1JZUFRPX01BTkFHRVI9eQpDT05GSUdfQ1JZUFRPX01BTkFHRVIyPXkKQ09O
RklHX0NSWVBUT19VU0VSPW0KIyBDT05GSUdfQ1JZUFRPX01BTkFHRVJfRElTQUJMRV9URVNUUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19NQU5BR0VSX0VYVFJBX1RFU1RTIGlzIG5vdCBzZXQK
Q09ORklHX0NSWVBUT19OVUxMPW0KQ09ORklHX0NSWVBUT19OVUxMMj1tCkNPTkZJR19DUllQVE9f
UENSWVBUPW0KQ09ORklHX0NSWVBUT19DUllQVEQ9bQpDT05GSUdfQ1JZUFRPX0FVVEhFTkM9bQoj
IENPTkZJR19DUllQVE9fVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fRU5HSU5FPW0KIyBl
bmQgb2YgQ3J5cHRvIGNvcmUgb3IgaGVscGVyCgojCiMgUHVibGljLWtleSBjcnlwdG9ncmFwaHkK
IwpDT05GSUdfQ1JZUFRPX1JTQT15CkNPTkZJR19DUllQVE9fREg9eQojIENPTkZJR19DUllQVE9f
REhfUkZDNzkxOV9HUk9VUFMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0VDQz1tCkNPTkZJR19D
UllQVE9fRUNESD1tCiMgQ09ORklHX0NSWVBUT19FQ0RTQSBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19FQ1JEU0EgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ1VSVkUyNTUxOSBpcyBub3Qg
c2V0CiMgZW5kIG9mIFB1YmxpYy1rZXkgY3J5cHRvZ3JhcGh5CgojCiMgQmxvY2sgY2lwaGVycwoj
CkNPTkZJR19DUllQVE9fQUVTPW0KIyBDT05GSUdfQ1JZUFRPX0FFU19USSBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19BUklBIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0JMT1dGSVNIIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBTUVMTElBIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZ
UFRPX0NBU1Q1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBU1Q2IGlzIG5vdCBzZXQKQ09O
RklHX0NSWVBUT19ERVM9bQojIENPTkZJR19DUllQVE9fRkNSWVBUIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX1NFUlBFTlQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU000X0dFTkVSSUMg
aXMgbm90IHNldApDT05GSUdfQ1JZUFRPX1RXT0ZJU0g9bQpDT05GSUdfQ1JZUFRPX1RXT0ZJU0hf
Q09NTU9OPW0KIyBlbmQgb2YgQmxvY2sgY2lwaGVycwoKIwojIExlbmd0aC1wcmVzZXJ2aW5nIGNp
cGhlcnMgYW5kIG1vZGVzCiMKQ09ORklHX0NSWVBUT19BRElBTlRVTT1tCkNPTkZJR19DUllQVE9f
Q0hBQ0hBMjA9bQpDT05GSUdfQ1JZUFRPX0NCQz1tCkNPTkZJR19DUllQVE9fQ1RSPW0KIyBDT05G
SUdfQ1JZUFRPX0NUUyBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fRUNCPW0KIyBDT05GSUdfQ1JZ
UFRPX0hDVFIyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0tFWVdSQVAgaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fTFJXIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1BDQkMgaXMgbm90
IHNldApDT05GSUdfQ1JZUFRPX1hUUz1tCkNPTkZJR19DUllQVE9fTkhQT0xZMTMwNT1tCiMgZW5k
IG9mIExlbmd0aC1wcmVzZXJ2aW5nIGNpcGhlcnMgYW5kIG1vZGVzCgojCiMgQUVBRCAoYXV0aGVu
dGljYXRlZCBlbmNyeXB0aW9uIHdpdGggYXNzb2NpYXRlZCBkYXRhKSBjaXBoZXJzCiMKIyBDT05G
SUdfQ1JZUFRPX0FFR0lTMTI4IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NIQUNIQTIwUE9M
WTEzMDUgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0NDTT1tCkNPTkZJR19DUllQVE9fR0NNPW0K
Q09ORklHX0NSWVBUT19HRU5JVj1tCkNPTkZJR19DUllQVE9fU0VRSVY9bQpDT05GSUdfQ1JZUFRP
X0VDSEFJTklWPW0KQ09ORklHX0NSWVBUT19FU1NJVj1tCiMgZW5kIG9mIEFFQUQgKGF1dGhlbnRp
Y2F0ZWQgZW5jcnlwdGlvbiB3aXRoIGFzc29jaWF0ZWQgZGF0YSkgY2lwaGVycwoKIwojIEhhc2hl
cywgZGlnZXN0cywgYW5kIE1BQ3MKIwpDT05GSUdfQ1JZUFRPX0JMQUtFMkI9eQpDT05GSUdfQ1JZ
UFRPX0NNQUM9bQpDT05GSUdfQ1JZUFRPX0dIQVNIPW0KQ09ORklHX0NSWVBUT19ITUFDPXkKQ09O
RklHX0NSWVBUT19NRDQ9bQpDT05GSUdfQ1JZUFRPX01ENT1tCiMgQ09ORklHX0NSWVBUT19NSUNI
QUVMX01JQyBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fUE9MWTEzMDU9bQojIENPTkZJR19DUllQ
VE9fUk1EMTYwIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19TSEExPW0KQ09ORklHX0NSWVBUT19T
SEEyNTY9eQpDT05GSUdfQ1JZUFRPX1NIQTUxMj1tCkNPTkZJR19DUllQVE9fU0hBMz1tCiMgQ09O
RklHX0NSWVBUT19TTTNfR0VORVJJQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TVFJFRUJP
RyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19WTUFDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZ
UFRPX1dQNTEyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1hDQkMgaXMgbm90IHNldApDT05G
SUdfQ1JZUFRPX1hYSEFTSD15CiMgZW5kIG9mIEhhc2hlcywgZGlnZXN0cywgYW5kIE1BQ3MKCiMK
IyBDUkNzIChjeWNsaWMgcmVkdW5kYW5jeSBjaGVja3MpCiMKQ09ORklHX0NSWVBUT19DUkMzMkM9
eQojIENPTkZJR19DUllQVE9fQ1JDMzIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ1JDVDEw
RElGIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NSQzY0X1JPQ0tTT0ZUIGlzIG5vdCBzZXQK
IyBlbmQgb2YgQ1JDcyAoY3ljbGljIHJlZHVuZGFuY3kgY2hlY2tzKQoKIwojIENvbXByZXNzaW9u
CiMKQ09ORklHX0NSWVBUT19ERUZMQVRFPW0KQ09ORklHX0NSWVBUT19MWk89bQojIENPTkZJR19D
UllQVE9fODQyIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19MWjQ9bQojIENPTkZJR19DUllQVE9f
TFo0SEMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX1pTVEQ9eQojIGVuZCBvZiBDb21wcmVzc2lv
bgoKIwojIFJhbmRvbSBudW1iZXIgZ2VuZXJhdGlvbgojCiMgQ09ORklHX0NSWVBUT19BTlNJX0NQ
Uk5HIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19EUkJHX01FTlU9bQpDT05GSUdfQ1JZUFRPX0RS
QkdfSE1BQz15CiMgQ09ORklHX0NSWVBUT19EUkJHX0hBU0ggaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fRFJCR19DVFIgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0RSQkc9bQpDT05GSUdfQ1JZ
UFRPX0pJVFRFUkVOVFJPUFk9bQpDT05GSUdfQ1JZUFRPX0pJVFRFUkVOVFJPUFlfTUVNT1JZX0JM
T0NLUz02NApDT05GSUdfQ1JZUFRPX0pJVFRFUkVOVFJPUFlfTUVNT1JZX0JMT0NLU0laRT0zMgpD
T05GSUdfQ1JZUFRPX0pJVFRFUkVOVFJPUFlfT1NSPTEKQ09ORklHX0NSWVBUT19LREY4MDAxMDhf
Q1RSPXkKIyBlbmQgb2YgUmFuZG9tIG51bWJlciBnZW5lcmF0aW9uCgojCiMgVXNlcnNwYWNlIGlu
dGVyZmFjZQojCkNPTkZJR19DUllQVE9fVVNFUl9BUEk9eQpDT05GSUdfQ1JZUFRPX1VTRVJfQVBJ
X0hBU0g9eQpDT05GSUdfQ1JZUFRPX1VTRVJfQVBJX1NLQ0lQSEVSPW0KQ09ORklHX0NSWVBUT19V
U0VSX0FQSV9STkc9bQojIENPTkZJR19DUllQVE9fVVNFUl9BUElfUk5HX0NBVlAgaXMgbm90IHNl
dApDT05GSUdfQ1JZUFRPX1VTRVJfQVBJX0FFQUQ9bQojIENPTkZJR19DUllQVE9fVVNFUl9BUElf
RU5BQkxFX09CU09MRVRFIGlzIG5vdCBzZXQKIyBlbmQgb2YgVXNlcnNwYWNlIGludGVyZmFjZQoK
Q09ORklHX0NSWVBUT19IQVNIX0lORk89eQoKIwojIEFjY2VsZXJhdGVkIENyeXB0b2dyYXBoaWMg
QWxnb3JpdGhtcyBmb3IgQ1BVICh4ODYpCiMKIyBDT05GSUdfQ1JZUFRPX0FFU19OSV9JTlRFTCBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TRVJQRU5UX1NTRTJfNTg2IGlzIG5vdCBzZXQKQ09O
RklHX0NSWVBUT19UV09GSVNIXzU4Nj1tCiMgQ09ORklHX0NSWVBUT19DUkMzMkNfSU5URUwgaXMg
bm90IHNldAojIENPTkZJR19DUllQVE9fQ1JDMzJfUENMTVVMIGlzIG5vdCBzZXQKIyBlbmQgb2Yg
QWNjZWxlcmF0ZWQgQ3J5cHRvZ3JhcGhpYyBBbGdvcml0aG1zIGZvciBDUFUgKHg4NikKCkNPTkZJ
R19DUllQVE9fSFc9eQojIENPTkZJR19DUllQVE9fREVWX1BBRExPQ0sgaXMgbm90IHNldAojIENP
TkZJR19DUllQVE9fREVWX0dFT0RFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9BVE1F
TF9FQ0MgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVWX0FUTUVMX1NIQTIwNEEgaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fREVWX0NDUCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19E
RVZfUUFUX0RIODk1eENDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9RQVRfQzNYWFgg
aXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVWX1FBVF9DNjJYIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX0RFVl9RQVRfNFhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfUUFU
XzQyMFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9RQVRfREg4OTV4Q0NWRiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfUUFUX0MzWFhYVkYgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fREVWX1FBVF9DNjJYVkYgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0RFVl9WSVJU
SU89bQojIENPTkZJR19DUllQVE9fREVWX1NBRkVYQ0VMIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZ
UFRPX0RFVl9DQ1JFRSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfQU1MT0dJQ19HWEwg
aXMgbm90IHNldApDT05GSUdfQVNZTU1FVFJJQ19LRVlfVFlQRT15CkNPTkZJR19BU1lNTUVUUklD
X1BVQkxJQ19LRVlfU1VCVFlQRT15CkNPTkZJR19YNTA5X0NFUlRJRklDQVRFX1BBUlNFUj15CkNP
TkZJR19QS0NTOF9QUklWQVRFX0tFWV9QQVJTRVI9bQpDT05GSUdfUEtDUzdfTUVTU0FHRV9QQVJT
RVI9eQojIENPTkZJR19QS0NTN19URVNUX0tFWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NJR05FRF9Q
RV9GSUxFX1ZFUklGSUNBVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZJUFNfU0lHTkFUVVJFX1NF
TEZURVNUIGlzIG5vdCBzZXQKCiMKIyBDZXJ0aWZpY2F0ZXMgZm9yIHNpZ25hdHVyZSBjaGVja2lu
ZwojCkNPTkZJR19TWVNURU1fVFJVU1RFRF9LRVlSSU5HPXkKQ09ORklHX1NZU1RFTV9UUlVTVEVE
X0tFWVM9IiIKIyBDT05GSUdfU1lTVEVNX0VYVFJBX0NFUlRJRklDQVRFIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VDT05EQVJZX1RSVVNURURfS0VZUklORyBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU1RF
TV9CTEFDS0xJU1RfS0VZUklORyBpcyBub3Qgc2V0CiMgZW5kIG9mIENlcnRpZmljYXRlcyBmb3Ig
c2lnbmF0dXJlIGNoZWNraW5nCgpDT05GSUdfQklOQVJZX1BSSU5URj15CgojCiMgTGlicmFyeSBy
b3V0aW5lcwojCkNPTkZJR19SQUlENl9QUT15CkNPTkZJR19SQUlENl9QUV9CRU5DSE1BUks9eQpD
T05GSUdfTElORUFSX1JBTkdFUz1tCiMgQ09ORklHX1BBQ0tJTkcgaXMgbm90IHNldApDT05GSUdf
QklUUkVWRVJTRT15CkNPTkZJR19HRU5FUklDX1NUUk5DUFlfRlJPTV9VU0VSPXkKQ09ORklHX0dF
TkVSSUNfU1RSTkxFTl9VU0VSPXkKQ09ORklHX0dFTkVSSUNfTkVUX1VUSUxTPXkKIyBDT05GSUdf
Q09SRElDIGlzIG5vdCBzZXQKQ09ORklHX1BSSU1FX05VTUJFUlM9bQpDT05GSUdfUkFUSU9OQUw9
eQpDT05GSUdfR0VORVJJQ19JT01BUD15CkNPTkZJR19BUkNIX1VTRV9DTVBYQ0hHX0xPQ0tSRUY9
eQpDT05GSUdfQVJDSF9IQVNfRkFTVF9NVUxUSVBMSUVSPXkKQ09ORklHX0FSQ0hfVVNFX1NZTV9B
Tk5PVEFUSU9OUz15CgojCiMgQ3J5cHRvIGxpYnJhcnkgcm91dGluZXMKIwpDT05GSUdfQ1JZUFRP
X0xJQl9VVElMUz15CkNPTkZJR19DUllQVE9fTElCX0FFUz1tCkNPTkZJR19DUllQVE9fTElCX0FS
QzQ9bQpDT05GSUdfQ1JZUFRPX0xJQl9HRjEyOE1VTD1tCkNPTkZJR19DUllQVE9fTElCX0JMQUtF
MlNfR0VORVJJQz15CkNPTkZJR19DUllQVE9fTElCX0NIQUNIQV9HRU5FUklDPW0KQ09ORklHX0NS
WVBUT19MSUJfQ0hBQ0hBPW0KQ09ORklHX0NSWVBUT19MSUJfQ1VSVkUyNTUxOV9HRU5FUklDPW0K
Q09ORklHX0NSWVBUT19MSUJfQ1VSVkUyNTUxOT1tCkNPTkZJR19DUllQVE9fTElCX0RFUz1tCkNP
TkZJR19DUllQVE9fTElCX1BPTFkxMzA1X1JTSVpFPTEKQ09ORklHX0NSWVBUT19MSUJfUE9MWTEz
MDVfR0VORVJJQz1tCkNPTkZJR19DUllQVE9fTElCX1BPTFkxMzA1PW0KQ09ORklHX0NSWVBUT19M
SUJfQ0hBQ0hBMjBQT0xZMTMwNT1tCkNPTkZJR19DUllQVE9fTElCX1NIQTE9eQpDT05GSUdfQ1JZ
UFRPX0xJQl9TSEEyNTY9eQojIGVuZCBvZiBDcnlwdG8gbGlicmFyeSByb3V0aW5lcwoKIyBDT05G
SUdfQ1JDX0NDSVRUIGlzIG5vdCBzZXQKQ09ORklHX0NSQzE2PXkKIyBDT05GSUdfQ1JDX1QxMERJ
RiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQzY0X1JPQ0tTT0ZUIGlzIG5vdCBzZXQKQ09ORklHX0NS
Q19JVFVfVD1tCkNPTkZJR19DUkMzMj15CiMgQ09ORklHX0NSQzMyX1NFTEZURVNUIGlzIG5vdCBz
ZXQKQ09ORklHX0NSQzMyX1NMSUNFQlk4PXkKIyBDT05GSUdfQ1JDMzJfU0xJQ0VCWTQgaXMgbm90
IHNldAojIENPTkZJR19DUkMzMl9TQVJXQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDMzJfQklU
IGlzIG5vdCBzZXQKQ09ORklHX0NSQzY0PW0KIyBDT05GSUdfQ1JDNCBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSQzcgaXMgbm90IHNldApDT05GSUdfTElCQ1JDMzJDPXkKIyBDT05GSUdfQ1JDOCBpcyBu
b3Qgc2V0CkNPTkZJR19YWEhBU0g9eQojIENPTkZJR19SQU5ET00zMl9TRUxGVEVTVCBpcyBub3Qg
c2V0CkNPTkZJR19aTElCX0lORkxBVEU9eQpDT05GSUdfWkxJQl9ERUZMQVRFPXkKQ09ORklHX0xa
T19DT01QUkVTUz15CkNPTkZJR19MWk9fREVDT01QUkVTUz15CkNPTkZJR19MWjRfQ09NUFJFU1M9
bQpDT05GSUdfTFo0SENfQ09NUFJFU1M9bQpDT05GSUdfTFo0X0RFQ09NUFJFU1M9bQpDT05GSUdf
WlNURF9DT01NT049eQpDT05GSUdfWlNURF9DT01QUkVTUz15CkNPTkZJR19aU1REX0RFQ09NUFJF
U1M9eQojIENPTkZJR19YWl9ERUMgaXMgbm90IHNldApDT05GSUdfREVDT01QUkVTU19HWklQPXkK
Q09ORklHX0RFQ09NUFJFU1NfWlNURD15CkNPTkZJR19HRU5FUklDX0FMTE9DQVRPUj15CkNPTkZJ
R19SRUVEX1NPTE9NT049bQpDT05GSUdfUkVFRF9TT0xPTU9OX0VOQzE2PXkKQ09ORklHX1JFRURf
U09MT01PTl9ERUMxNj15CkNPTkZJR19JTlRFUlZBTF9UUkVFPXkKQ09ORklHX1hBUlJBWV9NVUxU
ST15CkNPTkZJR19BU1NPQ0lBVElWRV9BUlJBWT15CkNPTkZJR19DTE9TVVJFUz15CkNPTkZJR19I
QVNfSU9NRU09eQpDT05GSUdfSEFTX0lPUE9SVD15CkNPTkZJR19IQVNfSU9QT1JUX01BUD15CkNP
TkZJR19IQVNfRE1BPXkKQ09ORklHX05FRURfU0dfRE1BX0xFTkdUSD15CkNPTkZJR19ORUVEX0RN
QV9NQVBfU1RBVEU9eQpDT05GSUdfQVJDSF9ETUFfQUREUl9UXzY0QklUPXkKQ09ORklHX0RNQV9E
RUNMQVJFX0NPSEVSRU5UPXkKQ09ORklHX1NXSU9UTEI9eQojIENPTkZJR19TV0lPVExCX0RZTkFN
SUMgaXMgbm90IHNldApDT05GSUdfRE1BX05FRURfU1lOQz15CkNPTkZJR19ETUFfUkVTVFJJQ1RF
RF9QT09MPXkKIyBDT05GSUdfRE1BX0FQSV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQV9N
QVBfQkVOQ0hNQVJLIGlzIG5vdCBzZXQKQ09ORklHX1NHTF9BTExPQz15CkNPTkZJR19DSEVDS19T
SUdOQVRVUkU9eQpDT05GSUdfQ1BVX1JNQVA9eQpDT05GSUdfRFFMPXkKQ09ORklHX0dMT0I9eQoj
IENPTkZJR19HTE9CX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09ORklHX05MQVRUUj15CkNPTkZJR19D
TFpfVEFCPXkKIyBDT05GSUdfSVJRX1BPTEwgaXMgbm90IHNldApDT05GSUdfTVBJTElCPXkKQ09O
RklHX0RJTUxJQj15CkNPTkZJR19MSUJGRFQ9eQpDT05GSUdfT0lEX1JFR0lTVFJZPXkKQ09ORklH
X0hBVkVfR0VORVJJQ19WRFNPPXkKQ09ORklHX0dFTkVSSUNfR0VUVElNRU9GREFZPXkKQ09ORklH
X0dFTkVSSUNfVkRTT18zMj15CkNPTkZJR19HRU5FUklDX1ZEU09fVElNRV9OUz15CkNPTkZJR19H
RU5FUklDX1ZEU09fT1ZFUkZMT1dfUFJPVEVDVD15CkNPTkZJR19GT05UX1NVUFBPUlQ9eQojIENP
TkZJR19GT05UUyBpcyBub3Qgc2V0CkNPTkZJR19GT05UXzh4OD15CkNPTkZJR19GT05UXzh4MTY9
eQpDT05GSUdfU0dfUE9PTD15CkNPTkZJR19BUkNIX0hBU19DUFVfQ0FDSEVfSU5WQUxJREFURV9N
RU1SRUdJT049eQpDT05GSUdfQVJDSF9TVEFDS1dBTEs9eQpDT05GSUdfU1RBQ0tERVBPVD15CkNP
TkZJR19TVEFDS0RFUE9UX0FMV0FZU19JTklUPXkKQ09ORklHX1NUQUNLREVQT1RfTUFYX0ZSQU1F
Uz02NApDT05GSUdfU0JJVE1BUD15CiMgQ09ORklHX0xXUV9URVNUIGlzIG5vdCBzZXQKIyBlbmQg
b2YgTGlicmFyeSByb3V0aW5lcwoKQ09ORklHX0ZJUk1XQVJFX1RBQkxFPXkKCiMKIyBLZXJuZWwg
aGFja2luZwojCgojCiMgcHJpbnRrIGFuZCBkbWVzZyBvcHRpb25zCiMKQ09ORklHX1BSSU5US19U
SU1FPXkKIyBDT05GSUdfUFJJTlRLX0NBTExFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NUQUNLVFJB
Q0VfQlVJTERfSUQgaXMgbm90IHNldApDT05GSUdfQ09OU09MRV9MT0dMRVZFTF9ERUZBVUxUPTcK
Q09ORklHX0NPTlNPTEVfTE9HTEVWRUxfUVVJRVQ9NApDT05GSUdfTUVTU0FHRV9MT0dMRVZFTF9E
RUZBVUxUPTQKIyBDT05GSUdfQk9PVF9QUklOVEtfREVMQVkgaXMgbm90IHNldAojIENPTkZJR19E
WU5BTUlDX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfRFlOQU1JQ19ERUJVR19DT1JFIGlzIG5v
dCBzZXQKQ09ORklHX1NZTUJPTElDX0VSUk5BTUU9eQpDT05GSUdfREVCVUdfQlVHVkVSQk9TRT15
CiMgZW5kIG9mIHByaW50ayBhbmQgZG1lc2cgb3B0aW9ucwoKQ09ORklHX0RFQlVHX0tFUk5FTD15
CiMgQ09ORklHX0RFQlVHX01JU0MgaXMgbm90IHNldAoKIwojIENvbXBpbGUtdGltZSBjaGVja3Mg
YW5kIGNvbXBpbGVyIG9wdGlvbnMKIwpDT05GSUdfQVNfSEFTX05PTl9DT05TVF9VTEVCMTI4PXkK
Q09ORklHX0RFQlVHX0lORk9fTk9ORT15CiMgQ09ORklHX0RFQlVHX0lORk9fRFdBUkZfVE9PTENI
QUlOX0RFRkFVTFQgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19JTkZPX0RXQVJGNCBpcyBub3Qg
c2V0CiMgQ09ORklHX0RFQlVHX0lORk9fRFdBUkY1IGlzIG5vdCBzZXQKQ09ORklHX0ZSQU1FX1dB
Uk49MTAyNApDT05GSUdfU1RSSVBfQVNNX1NZTVM9eQojIENPTkZJR19IRUFERVJTX0lOU1RBTEwg
aXMgbm90IHNldApDT05GSUdfU0VDVElPTl9NSVNNQVRDSF9XQVJOX09OTFk9eQpDT05GSUdfQVJD
SF9XQU5UX0ZSQU1FX1BPSU5URVJTPXkKQ09ORklHX0ZSQU1FX1BPSU5URVI9eQojIENPTkZJR19W
TUxJTlVYX01BUCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0ZPUkNFX1dFQUtfUEVSX0NQVSBp
cyBub3Qgc2V0CiMgZW5kIG9mIENvbXBpbGUtdGltZSBjaGVja3MgYW5kIGNvbXBpbGVyIG9wdGlv
bnMKCiMKIyBHZW5lcmljIEtlcm5lbCBEZWJ1Z2dpbmcgSW5zdHJ1bWVudHMKIwojIENPTkZJR19N
QUdJQ19TWVNSUSBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19GUz15CkNPTkZJR19ERUJVR19GU19B
TExPV19BTEw9eQojIENPTkZJR19ERUJVR19GU19ESVNBTExPV19NT1VOVCBpcyBub3Qgc2V0CiMg
Q09ORklHX0RFQlVHX0ZTX0FMTE9XX05PTkUgaXMgbm90IHNldApDT05GSUdfSEFWRV9BUkNIX0tH
REI9eQojIENPTkZJR19LR0RCIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfSEFTX1VCU0FOPXkKQ09O
RklHX1VCU0FOPXkKIyBDT05GSUdfVUJTQU5fVFJBUCBpcyBub3Qgc2V0CkNPTkZJR19DQ19IQVNf
VUJTQU5fQVJSQVlfQk9VTkRTPXkKQ09ORklHX1VCU0FOX0JPVU5EUz15CkNPTkZJR19VQlNBTl9B
UlJBWV9CT1VORFM9eQpDT05GSUdfVUJTQU5fU0hJRlQ9eQpDT05GSUdfVUJTQU5fVU5SRUFDSEFC
TEU9eQpDT05GSUdfVUJTQU5fU0lHTkVEX1dSQVA9eQpDT05GSUdfVUJTQU5fQk9PTD15CkNPTkZJ
R19VQlNBTl9FTlVNPXkKIyBDT05GSUdfVUJTQU5fQUxJR05NRU5UIGlzIG5vdCBzZXQKIyBDT05G
SUdfVEVTVF9VQlNBTiBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0tDU0FOX0NPTVBJTEVSPXkKIyBl
bmQgb2YgR2VuZXJpYyBLZXJuZWwgRGVidWdnaW5nIEluc3RydW1lbnRzCgojCiMgTmV0d29ya2lu
ZyBEZWJ1Z2dpbmcKIwojIENPTkZJR19ORVRfREVWX1JFRkNOVF9UUkFDS0VSIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX05TX1JFRkNOVF9UUkFDS0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdf
TkVUIGlzIG5vdCBzZXQKIyBlbmQgb2YgTmV0d29ya2luZyBEZWJ1Z2dpbmcKCiMKIyBNZW1vcnkg
RGVidWdnaW5nCiMKQ09ORklHX1BBR0VfRVhURU5TSU9OPXkKQ09ORklHX0RFQlVHX1BBR0VBTExP
Qz15CiMgQ09ORklHX0RFQlVHX1BBR0VBTExPQ19FTkFCTEVfREVGQVVMVCBpcyBub3Qgc2V0CkNP
TkZJR19TTFVCX0RFQlVHPXkKQ09ORklHX1NMVUJfREVCVUdfT049eQpDT05GSUdfUEFHRV9PV05F
Uj15CkNPTkZJR19QQUdFX1BPSVNPTklORz15CiMgQ09ORklHX0RFQlVHX1BBR0VfUkVGIGlzIG5v
dCBzZXQKQ09ORklHX0RFQlVHX1JPREFUQV9URVNUPXkKQ09ORklHX0FSQ0hfSEFTX0RFQlVHX1dY
PXkKQ09ORklHX0RFQlVHX1dYPXkKQ09ORklHX0dFTkVSSUNfUFREVU1QPXkKQ09ORklHX1BURFVN
UF9DT1JFPXkKIyBDT05GSUdfUFREVU1QX0RFQlVHRlMgaXMgbm90IHNldApDT05GSUdfSEFWRV9E
RUJVR19LTUVNTEVBSz15CkNPTkZJR19ERUJVR19LTUVNTEVBSz15CkNPTkZJR19ERUJVR19LTUVN
TEVBS19NRU1fUE9PTF9TSVpFPTE2MDAwCiMgQ09ORklHX0RFQlVHX0tNRU1MRUFLX0RFRkFVTFRf
T0ZGIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0tNRU1MRUFLX0FVVE9fU0NBTj15CiMgQ09ORklH
X0RFQlVHX09CSkVDVFMgaXMgbm90IHNldAojIENPTkZJR19TSFJJTktFUl9ERUJVRyBpcyBub3Qg
c2V0CiMgQ09ORklHX0RFQlVHX1NUQUNLX1VTQUdFIGlzIG5vdCBzZXQKQ09ORklHX1NDSEVEX1NU
QUNLX0VORF9DSEVDSz15CiMgQ09ORklHX0RFQlVHX1ZNIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hf
SEFTX0RFQlVHX1ZJUlRVQUw9eQojIENPTkZJR19ERUJVR19WSVJUVUFMIGlzIG5vdCBzZXQKQ09O
RklHX0RFQlVHX01FTU9SWV9JTklUPXkKIyBDT05GSUdfREVCVUdfUEVSX0NQVV9NQVBTIGlzIG5v
dCBzZXQKIyBDT05GSUdfREVCVUdfS01BUF9MT0NBTCBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX1NV
UFBPUlRTX0tNQVBfTE9DQUxfRk9SQ0VfTUFQPXkKIyBDT05GSUdfREVCVUdfS01BUF9MT0NBTF9G
T1JDRV9NQVAgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19ISUdITUVNIGlzIG5vdCBzZXQKQ09O
RklHX0hBVkVfREVCVUdfU1RBQ0tPVkVSRkxPVz15CkNPTkZJR19ERUJVR19TVEFDS09WRVJGTE9X
PXkKQ09ORklHX0NPREVfVEFHR0lORz15CkNPTkZJR19NRU1fQUxMT0NfUFJPRklMSU5HPXkKQ09O
RklHX01FTV9BTExPQ19QUk9GSUxJTkdfRU5BQkxFRF9CWV9ERUZBVUxUPXkKQ09ORklHX01FTV9B
TExPQ19QUk9GSUxJTkdfREVCVUc9eQpDT05GSUdfQ0NfSEFTX0tBU0FOX0dFTkVSSUM9eQpDT05G
SUdfQ0NfSEFTX0tBU0FOX1NXX1RBR1M9eQpDT05GSUdfQ0NfSEFTX1dPUktJTkdfTk9TQU5JVEla
RV9BRERSRVNTPXkKQ09ORklHX0hBVkVfQVJDSF9LRkVOQ0U9eQpDT05GSUdfS0ZFTkNFPXkKQ09O
RklHX0tGRU5DRV9TQU1QTEVfSU5URVJWQUw9MTAwCkNPTkZJR19LRkVOQ0VfTlVNX09CSkVDVFM9
MjU1CkNPTkZJR19LRkVOQ0VfREVGRVJSQUJMRT15CiMgQ09ORklHX0tGRU5DRV9TVEFUSUNfS0VZ
UyBpcyBub3Qgc2V0CkNPTkZJR19LRkVOQ0VfU1RSRVNTX1RFU1RfRkFVTFRTPTAKIyBDT05GSUdf
S0ZFTkNFX0tVTklUX1RFU1QgaXMgbm90IHNldApDT05GSUdfSEFWRV9LTVNBTl9DT01QSUxFUj15
CiMgZW5kIG9mIE1lbW9yeSBEZWJ1Z2dpbmcKCkNPTkZJR19ERUJVR19TSElSUT15CgojCiMgRGVi
dWcgT29wcywgTG9ja3VwcyBhbmQgSGFuZ3MKIwojIENPTkZJR19QQU5JQ19PTl9PT1BTIGlzIG5v
dCBzZXQKQ09ORklHX1BBTklDX09OX09PUFNfVkFMVUU9MApDT05GSUdfUEFOSUNfVElNRU9VVD00
MApDT05GSUdfTE9DS1VQX0RFVEVDVE9SPXkKQ09ORklHX1NPRlRMT0NLVVBfREVURUNUT1I9eQpD
T05GSUdfQk9PVFBBUkFNX1NPRlRMT0NLVVBfUEFOSUM9eQpDT05GSUdfSEFWRV9IQVJETE9DS1VQ
X0RFVEVDVE9SX0JVRERZPXkKQ09ORklHX0hBUkRMT0NLVVBfREVURUNUT1I9eQojIENPTkZJR19I
QVJETE9DS1VQX0RFVEVDVE9SX1BSRUZFUl9CVUREWSBpcyBub3Qgc2V0CkNPTkZJR19IQVJETE9D
S1VQX0RFVEVDVE9SX1BFUkY9eQojIENPTkZJR19IQVJETE9DS1VQX0RFVEVDVE9SX0JVRERZIGlz
IG5vdCBzZXQKIyBDT05GSUdfSEFSRExPQ0tVUF9ERVRFQ1RPUl9BUkNIIGlzIG5vdCBzZXQKQ09O
RklHX0hBUkRMT0NLVVBfREVURUNUT1JfQ09VTlRTX0hSVElNRVI9eQpDT05GSUdfQk9PVFBBUkFN
X0hBUkRMT0NLVVBfUEFOSUM9eQpDT05GSUdfREVURUNUX0hVTkdfVEFTSz15CkNPTkZJR19ERUZB
VUxUX0hVTkdfVEFTS19USU1FT1VUPTYwCiMgQ09ORklHX0JPT1RQQVJBTV9IVU5HX1RBU0tfUEFO
SUMgaXMgbm90IHNldApDT05GSUdfV1FfV0FUQ0hET0c9eQojIENPTkZJR19XUV9DUFVfSU5URU5T
SVZFX1JFUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfTE9DS1VQIGlzIG5vdCBzZXQKIyBl
bmQgb2YgRGVidWcgT29wcywgTG9ja3VwcyBhbmQgSGFuZ3MKCiMKIyBTY2hlZHVsZXIgRGVidWdn
aW5nCiMKQ09ORklHX1NDSEVEX0RFQlVHPXkKQ09ORklHX1NDSEVEX0lORk89eQpDT05GSUdfU0NI
RURTVEFUUz15CiMgZW5kIG9mIFNjaGVkdWxlciBEZWJ1Z2dpbmcKCkNPTkZJR19ERUJVR19USU1F
S0VFUElORz15CgojCiMgTG9jayBEZWJ1Z2dpbmcgKHNwaW5sb2NrcywgbXV0ZXhlcywgZXRjLi4u
KQojCkNPTkZJR19MT0NLX0RFQlVHR0lOR19TVVBQT1JUPXkKQ09ORklHX1BST1ZFX0xPQ0tJTkc9
eQojIENPTkZJR19QUk9WRV9SQVdfTE9DS19ORVNUSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfTE9D
S19TVEFUIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX1JUX01VVEVYRVM9eQpDT05GSUdfREVCVUdf
U1BJTkxPQ0s9eQpDT05GSUdfREVCVUdfTVVURVhFUz15CkNPTkZJR19ERUJVR19XV19NVVRFWF9T
TE9XUEFUSD15CkNPTkZJR19ERUJVR19SV1NFTVM9eQpDT05GSUdfREVCVUdfTE9DS19BTExPQz15
CkNPTkZJR19MT0NLREVQPXkKQ09ORklHX0xPQ0tERVBfQklUUz0xNQpDT05GSUdfTE9DS0RFUF9D
SEFJTlNfQklUUz0xNgpDT05GSUdfTE9DS0RFUF9TVEFDS19UUkFDRV9CSVRTPTE5CkNPTkZJR19M
T0NLREVQX1NUQUNLX1RSQUNFX0hBU0hfQklUUz0xNApDT05GSUdfTE9DS0RFUF9DSVJDVUxBUl9R
VUVVRV9CSVRTPTEyCkNPTkZJR19ERUJVR19MT0NLREVQPXkKIyBDT05GSUdfREVCVUdfQVRPTUlD
X1NMRUVQIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTE9DS0lOR19BUElfU0VMRlRFU1RTIGlz
IG5vdCBzZXQKQ09ORklHX0xPQ0tfVE9SVFVSRV9URVNUPW0KQ09ORklHX1dXX01VVEVYX1NFTEZU
RVNUPW0KQ09ORklHX1NDRl9UT1JUVVJFX1RFU1Q9bQojIGVuZCBvZiBMb2NrIERlYnVnZ2luZyAo
c3BpbmxvY2tzLCBtdXRleGVzLCBldGMuLi4pCgpDT05GSUdfVFJBQ0VfSVJRRkxBR1M9eQpDT05G
SUdfVFJBQ0VfSVJRRkxBR1NfTk1JPXkKQ09ORklHX05NSV9DSEVDS19DUFU9eQpDT05GSUdfREVC
VUdfSVJRRkxBR1M9eQpDT05GSUdfU1RBQ0tUUkFDRT15CiMgQ09ORklHX1dBUk5fQUxMX1VOU0VF
REVEX1JBTkRPTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0tPQkpFQ1QgaXMgbm90IHNldAoK
IwojIERlYnVnIGtlcm5lbCBkYXRhIHN0cnVjdHVyZXMKIwpDT05GSUdfREVCVUdfTElTVD15CiMg
Q09ORklHX0RFQlVHX1BMSVNUIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX1NHPXkKQ09ORklHX0RF
QlVHX05PVElGSUVSUz15CkNPTkZJR19ERUJVR19DTE9TVVJFUz15CkNPTkZJR19ERUJVR19NQVBM
RV9UUkVFPXkKIyBlbmQgb2YgRGVidWcga2VybmVsIGRhdGEgc3RydWN0dXJlcwoKIwojIFJDVSBE
ZWJ1Z2dpbmcKIwpDT05GSUdfUFJPVkVfUkNVPXkKQ09ORklHX1RPUlRVUkVfVEVTVD1tCiMgQ09O
RklHX1JDVV9TQ0FMRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNVX1RPUlRVUkVfVEVTVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1JDVV9SRUZfU0NBTEVfVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19S
Q1VfQ1BVX1NUQUxMX1RJTUVPVVQ9NjAKQ09ORklHX1JDVV9FWFBfQ1BVX1NUQUxMX1RJTUVPVVQ9
MApDT05GSUdfUkNVX0NQVV9TVEFMTF9DUFVUSU1FPXkKIyBDT05GSUdfUkNVX1RSQUNFIGlzIG5v
dCBzZXQKIyBDT05GSUdfUkNVX0VRU19ERUJVRyBpcyBub3Qgc2V0CiMgZW5kIG9mIFJDVSBEZWJ1
Z2dpbmcKCiMgQ09ORklHX0RFQlVHX1dRX0ZPUkNFX1JSX0NQVSBpcyBub3Qgc2V0CiMgQ09ORklH
X0NQVV9IT1RQTFVHX1NUQVRFX0NPTlRST0wgaXMgbm90IHNldAojIENPTkZJR19MQVRFTkNZVE9Q
IGlzIG5vdCBzZXQKQ09ORklHX1VTRVJfU1RBQ0tUUkFDRV9TVVBQT1JUPXkKQ09ORklHX05PUF9U
UkFDRVI9eQpDT05GSUdfSEFWRV9SRVRIT09LPXkKQ09ORklHX0hBVkVfRlVOQ1RJT05fVFJBQ0VS
PXkKQ09ORklHX0hBVkVfRlVOQ1RJT05fR1JBUEhfVFJBQ0VSPXkKQ09ORklHX0hBVkVfRlVOQ1RJ
T05fR1JBUEhfUkVUVkFMPXkKQ09ORklHX0hBVkVfRFlOQU1JQ19GVFJBQ0U9eQpDT05GSUdfSEFW
RV9EWU5BTUlDX0ZUUkFDRV9XSVRIX1JFR1M9eQpDT05GSUdfSEFWRV9EWU5BTUlDX0ZUUkFDRV9X
SVRIX0RJUkVDVF9DQUxMUz15CkNPTkZJR19IQVZFX0RZTkFNSUNfRlRSQUNFX05PX1BBVENIQUJM
RT15CkNPTkZJR19IQVZFX0ZUUkFDRV9NQ09VTlRfUkVDT1JEPXkKQ09ORklHX0hBVkVfU1lTQ0FM
TF9UUkFDRVBPSU5UUz15CkNPTkZJR19IQVZFX0NfUkVDT1JETUNPVU5UPXkKQ09ORklHX0hBVkVf
QlVJTERUSU1FX01DT1VOVF9TT1JUPXkKQ09ORklHX1RSQUNFX0NMT0NLPXkKQ09ORklHX1JJTkdf
QlVGRkVSPXkKQ09ORklHX0VWRU5UX1RSQUNJTkc9eQpDT05GSUdfQ09OVEVYVF9TV0lUQ0hfVFJB
Q0VSPXkKQ09ORklHX1BSRUVNUFRJUlFfVFJBQ0VQT0lOVFM9eQpDT05GSUdfVFJBQ0lORz15CkNP
TkZJR19UUkFDSU5HX1NVUFBPUlQ9eQojIENPTkZJR19GVFJBQ0UgaXMgbm90IHNldAojIENPTkZJ
R19QUk9WSURFX09IQ0kxMzk0X0RNQV9JTklUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FNUExFUyBp
cyBub3Qgc2V0CkNPTkZJR19BUkNIX0hBU19ERVZNRU1fSVNfQUxMT1dFRD15CkNPTkZJR19TVFJJ
Q1RfREVWTUVNPXkKQ09ORklHX0lPX1NUUklDVF9ERVZNRU09eQoKIwojIHg4NiBEZWJ1Z2dpbmcK
IwpDT05GSUdfWDg2X1ZFUkJPU0VfQk9PVFVQPXkKIyBDT05GSUdfRUFSTFlfUFJJTlRLIGlzIG5v
dCBzZXQKIyBDT05GSUdfREVCVUdfVExCRkxVU0ggaXMgbm90IHNldApDT05GSUdfSEFWRV9NTUlP
VFJBQ0VfU1VQUE9SVD15CiMgQ09ORklHX1g4Nl9ERUNPREVSX1NFTEZURVNUIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU9fREVMQVlfMFg4MCBpcyBub3Qgc2V0CiMgQ09ORklHX0lPX0RFTEFZXzBYRUQg
aXMgbm90IHNldApDT05GSUdfSU9fREVMQVlfVURFTEFZPXkKIyBDT05GSUdfSU9fREVMQVlfTk9O
RSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0JPT1RfUEFSQU1TIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1BBX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfRU5UUlkgaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19OTUlfU0VMRlRFU1QgaXMgbm90IHNldAojIENPTkZJR19YODZfREVCVUdf
RlBVIGlzIG5vdCBzZXQKIyBDT05GSUdfUFVOSVRfQVRPTV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJ
R19VTldJTkRFUl9GUkFNRV9QT0lOVEVSPXkKIyBlbmQgb2YgeDg2IERlYnVnZ2luZwoKIwojIEtl
cm5lbCBUZXN0aW5nIGFuZCBDb3ZlcmFnZQojCkNPTkZJR19LVU5JVD1tCkNPTkZJR19LVU5JVF9E
RUJVR0ZTPXkKIyBDT05GSUdfS1VOSVRfRkFVTFRfVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19LVU5J
VF9URVNUPW0KIyBDT05GSUdfS1VOSVRfRVhBTVBMRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdf
S1VOSVRfQUxMX1RFU1RTIGlzIG5vdCBzZXQKQ09ORklHX0tVTklUX0RFRkFVTFRfRU5BQkxFRD15
CiMgQ09ORklHX05PVElGSUVSX0VSUk9SX0lOSkVDVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZB
VUxUX0lOSkVDVElPTiBpcyBub3Qgc2V0CkNPTkZJR19DQ19IQVNfU0FOQ09WX1RSQUNFX1BDPXkK
Q09ORklHX1JVTlRJTUVfVEVTVElOR19NRU5VPXkKIyBDT05GSUdfVEVTVF9ESFJZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTEtEVE0gaXMgbm90IHNldApDT05GSUdfQ1BVTUFTS19LVU5JVF9URVNUPW0K
Q09ORklHX1RFU1RfTElTVF9TT1JUPW0KQ09ORklHX1RFU1RfTUlOX0hFQVA9bQpDT05GSUdfVEVT
VF9TT1JUPW0KQ09ORklHX1RFU1RfRElWNjQ9bQpDT05GSUdfVEVTVF9JT1ZfSVRFUj1tCkNPTkZJ
R19CQUNLVFJBQ0VfU0VMRl9URVNUPW0KIyBDT05GSUdfVEVTVF9SRUZfVFJBQ0tFUiBpcyBub3Qg
c2V0CkNPTkZJR19SQlRSRUVfVEVTVD1tCkNPTkZJR19SRUVEX1NPTE9NT05fVEVTVD1tCkNPTkZJ
R19JTlRFUlZBTF9UUkVFX1RFU1Q9bQpDT05GSUdfUEVSQ1BVX1RFU1Q9bQpDT05GSUdfQVRPTUlD
NjRfU0VMRlRFU1Q9eQpDT05GSUdfQVNZTkNfUkFJRDZfVEVTVD1tCiMgQ09ORklHX1RFU1RfSEVY
RFVNUCBpcyBub3Qgc2V0CkNPTkZJR19TVFJJTkdfS1VOSVRfVEVTVD1tCkNPTkZJR19TVFJJTkdf
SEVMUEVSU19LVU5JVF9URVNUPW0KQ09ORklHX1RFU1RfS1NUUlRPWD15CkNPTkZJR19URVNUX1BS
SU5URj1tCkNPTkZJR19URVNUX1NDQU5GPW0KQ09ORklHX1RFU1RfQklUTUFQPW0KQ09ORklHX1RF
U1RfVVVJRD1tCkNPTkZJR19URVNUX1hBUlJBWT1tCkNPTkZJR19URVNUX01BUExFX1RSRUU9bQoj
IENPTkZJR19URVNUX1JIQVNIVEFCTEUgaXMgbm90IHNldAojIENPTkZJR19URVNUX0lEQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RFU1RfTEtNIGlzIG5vdCBzZXQKQ09ORklHX1RFU1RfQklUT1BTPW0K
Q09ORklHX1RFU1RfVk1BTExPQz1tCkNPTkZJR19URVNUX0JQRj1tCiMgQ09ORklHX1RFU1RfQkxB
Q0tIT0xFX0RFViBpcyBub3Qgc2V0CkNPTkZJR19GSU5EX0JJVF9CRU5DSE1BUks9bQojIENPTkZJ
R19URVNUX0ZJUk1XQVJFIGlzIG5vdCBzZXQKQ09ORklHX1RFU1RfU1lTQ1RMPW0KQ09ORklHX0JJ
VEZJRUxEX0tVTklUPW0KQ09ORklHX0NIRUNLU1VNX0tVTklUPW0KQ09ORklHX0hBU0hfS1VOSVRf
VEVTVD1tCkNPTkZJR19SRVNPVVJDRV9LVU5JVF9URVNUPW0KQ09ORklHX1NZU0NUTF9LVU5JVF9U
RVNUPW0KQ09ORklHX0xJU1RfS1VOSVRfVEVTVD1tCkNPTkZJR19IQVNIVEFCTEVfS1VOSVRfVEVT
VD1tCkNPTkZJR19MSU5FQVJfUkFOR0VTX1RFU1Q9bQpDT05GSUdfQ01ETElORV9LVU5JVF9URVNU
PW0KQ09ORklHX0JJVFNfVEVTVD1tCkNPTkZJR19TTFVCX0tVTklUX1RFU1Q9bQojIENPTkZJR19S
QVRJT05BTF9LVU5JVF9URVNUIGlzIG5vdCBzZXQKQ09ORklHX01FTUNQWV9LVU5JVF9URVNUPW0K
Q09ORklHX0lTX1NJR05FRF9UWVBFX0tVTklUX1RFU1Q9bQpDT05GSUdfT1ZFUkZMT1dfS1VOSVRf
VEVTVD1tCkNPTkZJR19TVEFDS0lOSVRfS1VOSVRfVEVTVD1tCkNPTkZJR19GT1JUSUZZX0tVTklU
X1RFU1Q9bQpDT05GSUdfU0lQSEFTSF9LVU5JVF9URVNUPW0KQ09ORklHX1VTRVJDT1BZX0tVTklU
X1RFU1Q9bQpDT05GSUdfVEVTVF9VREVMQVk9bQojIENPTkZJR19URVNUX1NUQVRJQ19LRVlTIGlz
IG5vdCBzZXQKIyBDT05GSUdfVEVTVF9LTU9EIGlzIG5vdCBzZXQKQ09ORklHX1RFU1RfTUVNQ0FU
X1A9bQpDT05GSUdfVEVTVF9NRU1JTklUPW0KQ09ORklHX1RFU1RfRlJFRV9QQUdFUz1tCkNPTkZJ
R19URVNUX0ZQVT1tCiMgQ09ORklHX1RFU1RfQ0xPQ0tTT1VSQ0VfV0FUQ0hET0cgaXMgbm90IHNl
dApDT05GSUdfVEVTVF9PQkpQT09MPW0KQ09ORklHX0FSQ0hfVVNFX01FTVRFU1Q9eQojIENPTkZJ
R19NRU1URVNUIGlzIG5vdCBzZXQKIyBlbmQgb2YgS2VybmVsIFRlc3RpbmcgYW5kIENvdmVyYWdl
CgojCiMgUnVzdCBoYWNraW5nCiMKIyBlbmQgb2YgUnVzdCBoYWNraW5nCiMgZW5kIG9mIEtlcm5l
bCBoYWNraW5nCg==

--MP_/h5wDT.s6wbxhPxXH4h.e5+J--

